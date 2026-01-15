FROM n8nio/n8n:2.1.4

USER root

# Install Python + build tools
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev \
    libffi-dev \
    openssl-dev

# Install pymupdf4llm (léger, bon pour commencer)
RUN pip3 install --no-cache-dir \
    pymupdf4llm==0.0.17

USER node

# Healthcheck identique à l'image officielle
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1
