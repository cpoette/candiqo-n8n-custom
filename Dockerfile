FROM n8nio/n8n:latest

USER root

# Universal package manager detection
RUN if command -v apk; then \
      apk add --no-cache python3 py3-pip build-base python3-dev; \
    elif command -v apt-get; then \
      apt-get update && apt-get install -y python3 python3-pip build-essential; \
    fi

RUN pip3 install --no-cache-dir pymupdf4llm

USER node