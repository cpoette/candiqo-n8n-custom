FROM n8nio/n8n:2.1.4

USER root

# Install Python + build dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev \
    libffi-dev

# Install pymupdf4llm (commence léger)
RUN pip3 install --no-cache-dir \
    pymupdf4llm==0.0.17

USER node

# Healthcheck (garde le même que l'image de base)
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1
