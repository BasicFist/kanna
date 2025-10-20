#!/usr/bin/env python3
"""
FPIC Compliance Validator MCP Server
=====================================

Validates data anonymization and FPIC (Free, Prior, Informed Consent) compliance
for indigenous Khoisan knowledge protection in the KANNA PhD thesis project.

This server provides tools to:
1. Check files/directories for sensitive content (PII, identifiable information)
2. Validate FPIC compliance against project gitignore rules
3. Audit data operations for ethical compliance
4. Generate compliance reports

Author: Mickael Souedan
Project: KANNA - Sceletium tortuosum PhD Thesis
License: Internal Use Only (FPIC-Protected Research)
"""

import asyncio
import json
import logging
import os
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence

# MCP SDK imports (will be available via mcp package)
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Resource, Tool, TextContent, ImageContent, EmbeddedResource

# Configure logging to stderr (stdout reserved for MCP JSON-RPC)
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    stream=sys.stderr
)
logger = logging.getLogger('fpic-validator')

# KANNA project root (can be overridden via environment variable)
KANNA_ROOT = Path(os.environ.get('KANNA_ROOT', '/home/miko/LAB/academic/KANNA'))

# Protected directories (from .gitignore sensitive data section)
PROTECTED_PATHS = [
    'fieldwork/interviews-raw',
    'data/ethnobotanical/interviews',
    'data/ethnobotanical/fpic-protocols/*/personal-info',
    'collaboration/khoisan-partners/*/contact-info',
    'data/clinical/trials/*/patient-data',
    'data/clinical/trials/*/identifiable-info',
    'data/legal/confidential',
    'collaboration/academic-partners/*/nda',
]

# PII detection patterns (basic, can be enhanced)
PII_PATTERNS = {
    'email': re.compile(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'),
    'phone_za': re.compile(r'\b(?:\+27|0)[6-8][0-9]{8}\b'),  # South African mobile
    'phone_intl': re.compile(r'\+\d{1,3}[\s-]?\(?\d{1,4}\)?[\s-]?\d{1,4}[\s-]?\d{1,9}'),
    'id_number_za': re.compile(r'\b\d{13}\b'),  # South African ID (13 digits)
    'name_markers': re.compile(r'\b(?:Mr\.|Mrs\.|Ms\.|Dr\.|Prof\.)\s+[A-Z][a-z]+\b'),
    'gps_coords': re.compile(r'-?\d{1,2}\.\d{4,},\s*-?\d{1,3}\.\d{4,}'),  # GPS coordinates
}

# Severity levels for compliance issues
SEVERITY_CRITICAL = 'CRITICAL'  # Definitely identifiable data
SEVERITY_WARNING = 'WARNING'    # Potentially sensitive, needs review
SEVERITY_INFO = 'INFO'          # Advisory, low risk


class FPICComplianceChecker:
    """Core FPIC compliance validation logic"""

    def __init__(self, project_root: Path):
        self.project_root = project_root
        self.gitignore_path = project_root / '.gitignore'
        self.protected_patterns = self._load_protected_patterns()

    def _load_protected_patterns(self) -> List[re.Pattern]:
        """Load protected path patterns from gitignore"""
        patterns = []
        for path_pattern in PROTECTED_PATHS:
            # Convert glob-style patterns to regex
            regex_pattern = path_pattern.replace('**', '.*').replace('*', '[^/]*')
            patterns.append(re.compile(regex_pattern))
        return patterns

    def is_protected_path(self, file_path: Path) -> bool:
        """Check if path matches protected directories"""
        rel_path = str(file_path.relative_to(self.project_root))
        for pattern in self.protected_patterns:
            if pattern.search(rel_path):
                return True
        return False

    def scan_file_for_pii(self, file_path: Path) -> List[Dict[str, Any]]:
        """Scan file content for PII patterns"""
        findings = []

        if not file_path.exists():
            return findings

        if not file_path.is_file():
            return findings

        # Only scan text files (skip binary)
        try:
            with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
        except Exception as e:
            logger.warning(f"Could not read {file_path}: {e}")
            return findings

        lines = content.split('\n')

        for line_num, line in enumerate(lines, start=1):
            for pattern_name, pattern in PII_PATTERNS.items():
                matches = pattern.findall(line)
                if matches:
                    for match in matches:
                        findings.append({
                            'line': line_num,
                            'pattern': pattern_name,
                            'match': match,
                            'severity': self._get_severity(pattern_name),
                            'context': line[:100] + ('...' if len(line) > 100 else '')
                        })

        return findings

    def _get_severity(self, pattern_name: str) -> str:
        """Determine severity level for PII pattern"""
        critical_patterns = ['email', 'phone_za', 'phone_intl', 'id_number_za']
        if pattern_name in critical_patterns:
            return SEVERITY_CRITICAL
        elif pattern_name == 'gps_coords':
            return SEVERITY_WARNING
        else:
            return SEVERITY_INFO

    def validate_file(self, file_path: Path) -> Dict[str, Any]:
        """Comprehensive FPIC validation for a single file"""
        result = {
            'file': str(file_path.relative_to(self.project_root)),
            'compliant': True,
            'issues': [],
            'warnings': [],
            'info': []
        }

        # Check if file is in protected path
        if self.is_protected_path(file_path):
            result['compliant'] = False
            result['issues'].append({
                'type': 'protected_path',
                'severity': SEVERITY_CRITICAL,
                'message': f'File is in FPIC-protected directory: {file_path.parent}'
            })

        # Scan for PII
        pii_findings = self.scan_file_for_pii(file_path)
        for finding in pii_findings:
            issue = {
                'type': 'pii_detected',
                'severity': finding['severity'],
                'message': f"Potential {finding['pattern']} at line {finding['line']}: {finding['match']}",
                'context': finding['context']
            }

            if finding['severity'] == SEVERITY_CRITICAL:
                result['compliant'] = False
                result['issues'].append(issue)
            elif finding['severity'] == SEVERITY_WARNING:
                result['warnings'].append(issue)
            else:
                result['info'].append(issue)

        return result

    def validate_directory(self, dir_path: Path, recursive: bool = False) -> Dict[str, Any]:
        """Validate all files in a directory"""
        results = {
            'directory': str(dir_path.relative_to(self.project_root)),
            'total_files': 0,
            'compliant_files': 0,
            'non_compliant_files': 0,
            'files': []
        }

        if not dir_path.is_dir():
            results['error'] = f"Not a directory: {dir_path}"
            return results

        pattern = '**/*' if recursive else '*'
        for file_path in dir_path.glob(pattern):
            if file_path.is_file():
                file_result = self.validate_file(file_path)
                results['files'].append(file_result)
                results['total_files'] += 1

                if file_result['compliant']:
                    results['compliant_files'] += 1
                else:
                    results['non_compliant_files'] += 1

        return results


# Initialize MCP server
app = Server("fpic-validator")
checker = FPICComplianceChecker(KANNA_ROOT)


@app.list_resources()
async def list_resources() -> list[Resource]:
    """List available FPIC compliance resources"""
    return [
        Resource(
            uri="fpic://protected-paths",
            name="Protected Directories",
            mimeType="application/json",
            description="List of FPIC-protected directories in KANNA project"
        ),
        Resource(
            uri="fpic://pii-patterns",
            name="PII Detection Patterns",
            mimeType="application/json",
            description="Patterns used to detect personally identifiable information"
        )
    ]


@app.read_resource()
async def read_resource(uri: str) -> str:
    """Read FPIC compliance resources"""
    if uri == "fpic://protected-paths":
        return json.dumps({
            "protected_paths": PROTECTED_PATHS,
            "description": "Directories containing FPIC-protected indigenous knowledge and identifiable data"
        }, indent=2)

    elif uri == "fpic://pii-patterns":
        return json.dumps({
            "patterns": list(PII_PATTERNS.keys()),
            "description": "PII detection patterns for South African context (phones, ID numbers, GPS, etc.)"
        }, indent=2)

    else:
        raise ValueError(f"Unknown resource URI: {uri}")


@app.list_tools()
async def list_tools() -> list[Tool]:
    """List available FPIC compliance tools"""
    return [
        Tool(
            name="validate_file",
            description="Validate a single file for FPIC compliance and PII detection",
            inputSchema={
                "type": "object",
                "properties": {
                    "file_path": {
                        "type": "string",
                        "description": "Path to file (relative to KANNA project root or absolute)"
                    }
                },
                "required": ["file_path"]
            }
        ),
        Tool(
            name="validate_directory",
            description="Validate all files in a directory for FPIC compliance",
            inputSchema={
                "type": "object",
                "properties": {
                    "directory_path": {
                        "type": "string",
                        "description": "Path to directory (relative to KANNA project root or absolute)"
                    },
                    "recursive": {
                        "type": "boolean",
                        "description": "Recursively scan subdirectories (default: false)",
                        "default": False
                    }
                },
                "required": ["directory_path"]
            }
        ),
        Tool(
            name="check_protected_path",
            description="Check if a path is in a FPIC-protected directory",
            inputSchema={
                "type": "object",
                "properties": {
                    "path": {
                        "type": "string",
                        "description": "Path to check (relative to KANNA project root or absolute)"
                    }
                },
                "required": ["path"]
            }
        )
    ]


@app.call_tool()
async def call_tool(name: str, arguments: Any) -> Sequence[TextContent | ImageContent | EmbeddedResource]:
    """Execute FPIC compliance tools"""

    if name == "validate_file":
        file_path = Path(arguments["file_path"])
        if not file_path.is_absolute():
            file_path = KANNA_ROOT / file_path

        result = checker.validate_file(file_path)

        return [
            TextContent(
                type="text",
                text=json.dumps(result, indent=2)
            )
        ]

    elif name == "validate_directory":
        dir_path = Path(arguments["directory_path"])
        if not dir_path.is_absolute():
            dir_path = KANNA_ROOT / dir_path

        recursive = arguments.get("recursive", False)
        result = checker.validate_directory(dir_path, recursive)

        return [
            TextContent(
                type="text",
                text=json.dumps(result, indent=2)
            )
        ]

    elif name == "check_protected_path":
        path = Path(arguments["path"])
        if not path.is_absolute():
            path = KANNA_ROOT / path

        is_protected = checker.is_protected_path(path)

        result = {
            "path": str(path.relative_to(KANNA_ROOT)),
            "is_protected": is_protected,
            "message": "Path is FPIC-protected" if is_protected else "Path is not in protected directories"
        }

        return [
            TextContent(
                type="text",
                text=json.dumps(result, indent=2)
            )
        ]

    else:
        raise ValueError(f"Unknown tool: {name}")


async def main():
    """Run the FPIC Compliance Validator MCP server"""
    logger.info("Starting FPIC Compliance Validator MCP server")
    logger.info(f"KANNA project root: {KANNA_ROOT}")
    logger.info(f"Protected paths: {len(PROTECTED_PATHS)}")
    logger.info(f"PII patterns: {len(PII_PATTERNS)}")

    async with stdio_server() as (read_stream, write_stream):
        await app.run(read_stream, write_stream, app.create_initialization_options())


if __name__ == "__main__":
    asyncio.run(main())
