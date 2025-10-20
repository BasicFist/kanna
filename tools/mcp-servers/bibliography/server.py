#!/usr/bin/env python3
"""
Academic Bibliography MCP Server
=================================

Provides access to Zotero library for the KANNA PhD thesis project via Better BibTeX export.
Enables semantic search, citation retrieval, and French academic citation formatting.

Features:
1. Parse and query Zotero Better BibTeX export file
2. Semantic search over bibliography entries (title, author, keywords, abstract)
3. Citation formatting (inline, footnotes, Chicago style for French theses)
4. Bibliography statistics and corpus analysis

Author: Mickael Souedan
Project: KANNA - Sceletium tortuosum PhD Thesis
License: Internal Use Only
"""

import asyncio
import json
import logging
import os
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Sequence
from dataclasses import dataclass, asdict
from datetime import datetime

# MCP SDK imports
from mcp.server import Server
from mcp.server.stdio import stdio_server
from mcp.types import Resource, Tool, TextContent, ImageContent, EmbeddedResource

# Configure logging to stderr
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    stream=sys.stderr
)
logger = logging.getLogger('bibliography')

# KANNA project root
KANNA_ROOT = Path(os.environ.get('KANNA_ROOT', '/home/miko/LAB/academic/KANNA'))

# Default Zotero export path
DEFAULT_ZOTERO_EXPORT = KANNA_ROOT / 'literature' / 'zotero-export' / 'kanna.bib'


@dataclass
class BibEntry:
    """Represents a single bibliography entry"""
    citation_key: str
    entry_type: str  # article, book, inproceedings, etc.
    title: str
    authors: List[str]
    year: Optional[str] = None
    journal: Optional[str] = None
    volume: Optional[str] = None
    pages: Optional[str] = None
    doi: Optional[str] = None
    abstract: Optional[str] = None
    keywords: Optional[str] = None
    url: Optional[str] = None
    publisher: Optional[str] = None
    booktitle: Optional[str] = None
    raw_entry: Optional[str] = None  # Full BibTeX entry


class BibTeXParser:
    """Parse BibTeX files exported from Zotero Better BibTeX"""

    def __init__(self, bib_file: Path):
        self.bib_file = bib_file
        self.entries: Dict[str, BibEntry] = {}
        self._parse()

    def _parse(self):
        """Parse the BibTeX file"""
        if not self.bib_file.exists():
            logger.warning(f"BibTeX file not found: {self.bib_file}")
            return

        with open(self.bib_file, 'r', encoding='utf-8') as f:
            content = f.read()

        # Split by entry (starts with @)
        entries = re.split(r'\n(?=@)', content)

        for entry_text in entries:
            entry_text = entry_text.strip()
            if not entry_text or not entry_text.startswith('@'):
                continue

            entry = self._parse_entry(entry_text)
            if entry:
                self.entries[entry.citation_key] = entry

        logger.info(f"Parsed {len(self.entries)} bibliography entries from {self.bib_file}")

    def _parse_entry(self, entry_text: str) -> Optional[BibEntry]:
        """Parse a single BibTeX entry"""
        try:
            # Extract entry type and citation key
            # Format: @article{CitationKey,
            match = re.match(r'@(\w+)\{([^,]+),', entry_text)
            if not match:
                return None

            entry_type = match.group(1).lower()
            citation_key = match.group(2).strip()

            # Extract fields
            fields = {}
            # Match field = {value} or field = "value"
            field_pattern = r'(\w+)\s*=\s*[{"](.*?)[}"](?:,|\s*\n)'
            for field_match in re.finditer(field_pattern, entry_text, re.DOTALL):
                field_name = field_match.group(1).lower()
                field_value = field_match.group(2).strip()
                # Remove LaTeX commands and clean up
                field_value = re.sub(r'\\[a-zA-Z]+\{([^}]*)\}', r'\1', field_value)
                field_value = re.sub(r'[{}]', '', field_value)
                fields[field_name] = field_value

            # Parse authors
            authors = []
            if 'author' in fields:
                # Split by 'and' and clean up
                author_list = fields['author'].split(' and ')
                authors = [a.strip() for a in author_list]

            # Create BibEntry
            return BibEntry(
                citation_key=citation_key,
                entry_type=entry_type,
                title=fields.get('title', ''),
                authors=authors,
                year=fields.get('year'),
                journal=fields.get('journal'),
                volume=fields.get('volume'),
                pages=fields.get('pages'),
                doi=fields.get('doi'),
                abstract=fields.get('abstract'),
                keywords=fields.get('keywords'),
                url=fields.get('url'),
                publisher=fields.get('publisher'),
                booktitle=fields.get('booktitle'),
                raw_entry=entry_text
            )

        except Exception as e:
            logger.error(f"Error parsing entry: {e}")
            return None

    def search(self, query: str, fields: Optional[List[str]] = None) -> List[BibEntry]:
        """
        Search bibliography entries

        Args:
            query: Search query string
            fields: Fields to search in (default: title, authors, keywords, abstract)

        Returns:
            List of matching BibEntry objects
        """
        if fields is None:
            fields = ['title', 'authors', 'keywords', 'abstract']

        query_lower = query.lower()
        results = []

        for entry in self.entries.values():
            match = False

            for field in fields:
                if field == 'authors':
                    if any(query_lower in author.lower() for author in entry.authors):
                        match = True
                        break
                else:
                    field_value = getattr(entry, field, None)
                    if field_value and query_lower in field_value.lower():
                        match = True
                        break

            if match:
                results.append(entry)

        return results

    def get_by_key(self, citation_key: str) -> Optional[BibEntry]:
        """Get entry by citation key"""
        return self.entries.get(citation_key)

    def get_by_author(self, author_name: str) -> List[BibEntry]:
        """Get all entries by author (partial match)"""
        author_lower = author_name.lower()
        return [
            entry for entry in self.entries.values()
            if any(author_lower in author.lower() for author in entry.authors)
        ]

    def get_by_year(self, year: str) -> List[BibEntry]:
        """Get all entries from a specific year"""
        return [
            entry for entry in self.entries.values()
            if entry.year == str(year)
        ]

    def get_statistics(self) -> Dict[str, Any]:
        """Get bibliography statistics"""
        stats = {
            'total_entries': len(self.entries),
            'by_type': {},
            'by_year': {},
            'authors': set()
        }

        for entry in self.entries.values():
            # Count by type
            stats['by_type'][entry.entry_type] = stats['by_type'].get(entry.entry_type, 0) + 1

            # Count by year
            if entry.year:
                stats['by_year'][entry.year] = stats['by_year'].get(entry.year, 0) + 1

            # Collect unique authors
            stats['authors'].update(entry.authors)

        stats['unique_authors'] = len(stats['authors'])
        stats['authors'] = list(stats['authors'])[:50]  # Limit for display

        return stats


class CitationFormatter:
    """Format citations in various academic styles"""

    @staticmethod
    def format_inline(entry: BibEntry) -> str:
        """Format as inline citation (Author Year)"""
        if not entry.authors:
            return f"(Unknown, {entry.year or 'n.d.'})"

        # Get first author's last name
        first_author = entry.authors[0]
        # Simple last name extraction
        last_name = first_author.split()[-1] if first_author else "Unknown"

        if len(entry.authors) > 1:
            return f"({last_name} et al., {entry.year or 'n.d.'})"
        else:
            return f"({last_name}, {entry.year or 'n.d.'})"

    @staticmethod
    def format_footnote(entry: BibEntry) -> str:
        """Format as French academic footnote (Chicago style)"""
        # Authors
        if not entry.authors:
            author_str = "Auteur inconnu"
        elif len(entry.authors) == 1:
            author_str = entry.authors[0]
        elif len(entry.authors) == 2:
            author_str = f"{entry.authors[0]} et {entry.authors[1]}"
        else:
            author_str = f"{entry.authors[0]} et al."

        # Title in italics (using markdown)
        title = f"*{entry.title}*" if entry.title else "*Titre inconnu*"

        # Publication info
        pub_info = []
        if entry.journal:
            pub_info.append(f"*{entry.journal}*")
        if entry.volume:
            pub_info.append(f"vol. {entry.volume}")
        if entry.pages:
            pub_info.append(f"p. {entry.pages}")
        if entry.year:
            pub_info.append(entry.year)

        pub_str = ", ".join(pub_info) if pub_info else ""

        return f"{author_str}, {title}, {pub_str}."

    @staticmethod
    def format_full_reference(entry: BibEntry) -> str:
        """Format as full bibliography reference (Chicago style)"""
        parts = []

        # Authors
        if entry.authors:
            if len(entry.authors) == 1:
                parts.append(f"{entry.authors[0]}.")
            else:
                # Last name, First name for first author
                first_author = entry.authors[0]
                parts.append(f"{first_author}, ")

                if len(entry.authors) == 2:
                    parts.append(f"et {entry.authors[1]}.")
                else:
                    parts.append(f"et al.")
        else:
            parts.append("Auteur inconnu.")

        # Year
        if entry.year:
            parts.append(f" {entry.year}.")

        # Title
        if entry.title:
            parts.append(f' "{entry.title}."')

        # Journal/Book
        if entry.journal:
            parts.append(f" *{entry.journal}*")
            if entry.volume:
                parts.append(f" {entry.volume}")
            if entry.pages:
                parts.append(f": {entry.pages}")
        elif entry.booktitle:
            parts.append(f" In *{entry.booktitle}*")

        # DOI
        if entry.doi:
            parts.append(f" https://doi.org/{entry.doi}")

        return "".join(parts)


# Initialize MCP server
app = Server("bibliography")
bib_parser: Optional[BibTeXParser] = None


def load_bibliography(bib_file: Path = DEFAULT_ZOTERO_EXPORT):
    """Load or reload bibliography"""
    global bib_parser
    bib_parser = BibTeXParser(bib_file)
    return bib_parser


# Load bibliography on startup
load_bibliography()


@app.list_resources()
async def list_resources() -> list[Resource]:
    """List available bibliography resources"""
    return [
        Resource(
            uri="bib://statistics",
            name="Bibliography Statistics",
            mimeType="application/json",
            description="Statistics about the KANNA literature corpus (entry counts, authors, years)"
        ),
        Resource(
            uri="bib://export-path",
            name="Zotero Export Path",
            mimeType="text/plain",
            description="Path to the Zotero Better BibTeX export file"
        )
    ]


@app.read_resource()
async def read_resource(uri: str) -> str:
    """Read bibliography resources"""
    if uri == "bib://statistics":
        if not bib_parser:
            return json.dumps({"error": "Bibliography not loaded"}, indent=2)

        stats = bib_parser.get_statistics()
        return json.dumps(stats, indent=2)

    elif uri == "bib://export-path":
        return str(DEFAULT_ZOTERO_EXPORT)

    else:
        raise ValueError(f"Unknown resource URI: {uri}")


@app.list_tools()
async def list_tools() -> list[Tool]:
    """List available bibliography tools"""
    return [
        Tool(
            name="search_bibliography",
            description="Search the bibliography by keywords, authors, title, or abstract",
            inputSchema={
                "type": "object",
                "properties": {
                    "query": {
                        "type": "string",
                        "description": "Search query (keywords, author names, title fragments)"
                    },
                    "fields": {
                        "type": "array",
                        "items": {"type": "string"},
                        "description": "Fields to search (default: title, authors, keywords, abstract)",
                        "default": ["title", "authors", "keywords", "abstract"]
                    },
                    "max_results": {
                        "type": "integer",
                        "description": "Maximum number of results to return (default: 10)",
                        "default": 10
                    }
                },
                "required": ["query"]
            }
        ),
        Tool(
            name="get_citation",
            description="Get citation by citation key from Zotero library",
            inputSchema={
                "type": "object",
                "properties": {
                    "citation_key": {
                        "type": "string",
                        "description": "BibTeX citation key (e.g., 'smith2011')"
                    },
                    "format": {
                        "type": "string",
                        "enum": ["inline", "footnote", "full", "bibtex"],
                        "description": "Citation format (inline: (Author Year), footnote: French academic, full: complete reference, bibtex: raw BibTeX)",
                        "default": "inline"
                    }
                },
                "required": ["citation_key"]
            }
        ),
        Tool(
            name="get_by_author",
            description="Get all papers by a specific author",
            inputSchema={
                "type": "object",
                "properties": {
                    "author_name": {
                        "type": "string",
                        "description": "Author name (partial match, e.g., 'Gericke')"
                    }
                },
                "required": ["author_name"]
            }
        ),
        Tool(
            name="get_by_year",
            description="Get all papers from a specific year",
            inputSchema={
                "type": "object",
                "properties": {
                    "year": {
                        "type": "string",
                        "description": "Publication year (e.g., '2011')"
                    }
                },
                "required": ["year"]
            }
        ),
        Tool(
            name="reload_bibliography",
            description="Reload bibliography from Zotero export file (use after Zotero updates)",
            inputSchema={
                "type": "object",
                "properties": {},
                "required": []
            }
        )
    ]


@app.call_tool()
async def call_tool(name: str, arguments: Any) -> Sequence[TextContent | ImageContent | EmbeddedResource]:
    """Execute bibliography tools"""

    if name == "search_bibliography":
        query = arguments["query"]
        fields = arguments.get("fields", ["title", "authors", "keywords", "abstract"])
        max_results = arguments.get("max_results", 10)

        if not bib_parser:
            return [TextContent(type="text", text=json.dumps({"error": "Bibliography not loaded"}, indent=2))]

        results = bib_parser.search(query, fields)
        results = results[:max_results]

        formatted_results = []
        for entry in results:
            formatted_results.append({
                "citation_key": entry.citation_key,
                "title": entry.title,
                "authors": entry.authors,
                "year": entry.year,
                "journal": entry.journal,
                "type": entry.entry_type,
                "inline_citation": CitationFormatter.format_inline(entry)
            })

        response = {
            "query": query,
            "total_results": len(results),
            "results": formatted_results
        }

        return [TextContent(type="text", text=json.dumps(response, indent=2))]

    elif name == "get_citation":
        citation_key = arguments["citation_key"]
        format_type = arguments.get("format", "inline")

        if not bib_parser:
            return [TextContent(type="text", text=json.dumps({"error": "Bibliography not loaded"}, indent=2))]

        entry = bib_parser.get_by_key(citation_key)
        if not entry:
            return [TextContent(type="text", text=json.dumps({"error": f"Citation key '{citation_key}' not found"}, indent=2))]

        if format_type == "inline":
            citation = CitationFormatter.format_inline(entry)
        elif format_type == "footnote":
            citation = CitationFormatter.format_footnote(entry)
        elif format_type == "full":
            citation = CitationFormatter.format_full_reference(entry)
        elif format_type == "bibtex":
            citation = entry.raw_entry or "BibTeX entry not available"
        else:
            citation = CitationFormatter.format_inline(entry)

        response = {
            "citation_key": citation_key,
            "format": format_type,
            "citation": citation,
            "entry": asdict(entry)
        }

        return [TextContent(type="text", text=json.dumps(response, indent=2))]

    elif name == "get_by_author":
        author_name = arguments["author_name"]

        if not bib_parser:
            return [TextContent(type="text", text=json.dumps({"error": "Bibliography not loaded"}, indent=2))]

        results = bib_parser.get_by_author(author_name)

        formatted_results = []
        for entry in results:
            formatted_results.append({
                "citation_key": entry.citation_key,
                "title": entry.title,
                "authors": entry.authors,
                "year": entry.year,
                "journal": entry.journal
            })

        response = {
            "author": author_name,
            "total_papers": len(results),
            "papers": formatted_results
        }

        return [TextContent(type="text", text=json.dumps(response, indent=2))]

    elif name == "get_by_year":
        year = arguments["year"]

        if not bib_parser:
            return [TextContent(type="text", text=json.dumps({"error": "Bibliography not loaded"}, indent=2))]

        results = bib_parser.get_by_year(year)

        formatted_results = []
        for entry in results:
            formatted_results.append({
                "citation_key": entry.citation_key,
                "title": entry.title,
                "authors": entry.authors,
                "journal": entry.journal
            })

        response = {
            "year": year,
            "total_papers": len(results),
            "papers": formatted_results
        }

        return [TextContent(type="text", text=json.dumps(response, indent=2))]

    elif name == "reload_bibliography":
        load_bibliography()

        return [TextContent(
            type="text",
            text=json.dumps({
                "status": "success",
                "message": f"Bibliography reloaded: {len(bib_parser.entries) if bib_parser else 0} entries",
                "path": str(DEFAULT_ZOTERO_EXPORT)
            }, indent=2)
        )]

    else:
        raise ValueError(f"Unknown tool: {name}")


async def main():
    """Run the Bibliography MCP server"""
    logger.info("Starting Academic Bibliography MCP server")
    logger.info(f"KANNA project root: {KANNA_ROOT}")
    logger.info(f"Zotero export path: {DEFAULT_ZOTERO_EXPORT}")

    if bib_parser:
        logger.info(f"Loaded {len(bib_parser.entries)} bibliography entries")
    else:
        logger.warning("Bibliography not loaded - Zotero export file not found")

    async with stdio_server() as (read_stream, write_stream):
        await app.run(read_stream, write_stream, app.create_initialization_options())


if __name__ == "__main__":
    asyncio.run(main())
