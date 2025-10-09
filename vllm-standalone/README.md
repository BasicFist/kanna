# KANNA vLLM Infrastructure

High-performance vLLM inference server with optimized configuration for KANNA models.

## Features
- Optimized vLLM configuration
- Dockerized deployment
- Kubernetes support
- Monitoring and logging
- Auto-scaling capabilities

## Quick Start

```bash
docker-compose up -d
```

## Configuration
See `config/kanna-vllm.yaml` for main configuration options.

## Requirements
- Docker 20.10+
- NVIDIA GPU with CUDA 11.8+
- Python 3.9+