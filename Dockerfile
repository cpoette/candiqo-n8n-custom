FROM n8nio/n8n:latest

USER root

# Download standalone Python (works on ANY Linux)
RUN curl -L https://github.com/indygreg/python-build-standalone/releases/download/20241016/cpython-3.12.7+20241016-x86_64-unknown-linux-gnu-install_only.tar.gz \
    | tar -xz -C /opt

# Add Python to PATH
ENV PATH="/opt/python/bin:$PATH"

# Install pymupdf4llm
RUN /opt/python/bin/pip3 install --no-cache-dir pymupdf4llm

USER node

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD node -e "require('http').get('http://localhost:5678/healthz', r => process.exit(r.statusCode === 200 ? 0 : 1))"