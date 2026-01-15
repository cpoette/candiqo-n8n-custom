FROM node:20-alpine

WORKDIR /home/node

# Install n8n globally
RUN npm install -g n8n@latest

# Install Python + dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    build-base \
    python3-dev \
    libffi-dev \
    cairo-dev \
    pango-dev \
    wget

# Install pymupdf4llm
RUN pip3 install --break-system-packages pymupdf4llm

# Create node user (if not exists)
RUN addgroup -g 1000 node 2>/dev/null || true
RUN adduser -u 1000 -G node -s /bin/sh -D node 2>/dev/null || true

# Set proper permissions
RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node

USER node

ENV N8N_USER_FOLDER=/home/node/.n8n

EXPOSE 5678

CMD ["n8n"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s \
  CMD wget --quiet --tries=1 --spider http://localhost:5678/healthz || exit 1