# n8n Custom pour Candiqo

Image n8n avec pymupdf4llm pour extraction PDF avancée.

## Build local

```bash
docker build -t n8n-candiqo:latest .
```

## Modifications vs image officielle

- Python 3 + pip
- pymupdf4llm pour parsing PDF layout-aware
