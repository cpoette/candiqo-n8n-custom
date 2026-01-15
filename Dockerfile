FROM node:20-alpine

WORKDIR /home/node

# Install n8n globally
RUN npm install -g n8n@latest

# Install Python + dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    build-base \
    python3-dev \
    libffi-dev \
    cairo-dev \
    pango-dev \
    wget

# Create node user early
RUN addgroup -g 1000 node 2>/dev/null || true
RUN adduser -u 1000 -G node -s /bin/sh -D node 2>/dev/null || true

# Create .n8n directory (will be mounted by Coolify)
RUN mkdir -p /home/node/.n8n

# Create Python venv OUTSIDE of .n8n (so it's not overwritten by volume)
RUN python3 -m venv /opt/n8n-python-env

# Install pymupdf4llm in the venv
RUN /opt/n8n-python-env/bin/pip install --upgrade pip
RUN /opt/n8n-python-env/bin/pip install pymupdf4llm

# Fix permissions
RUN chown -R node:node /home/node
RUN chown -R node:node /opt/n8n-python-env

USER node

ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_RUNNERS_MODE=internal
ENV N8N_PYTHON_BINARY=/opt/n8n-python-env/bin/python

EXPOSE 5678

CMD ["n8n"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1