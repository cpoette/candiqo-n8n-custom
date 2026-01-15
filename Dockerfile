FROM n8nio/n8n:2.1.4

USER root

# Install Python + build dependencies (Debian)
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    libffi-dev \
    libssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install pymupdf4llm
RUN pip3 install --no-cache-dir \
    pymupdf4llm==0.0.17

USER node

# Healthcheck (identique à l'image de base)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1