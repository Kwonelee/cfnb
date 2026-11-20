FROM --platform=linux/arm64 python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl git gcc g++ \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/

RUN pip install --no-cache-dir requests aiohttp brotlicffi

RUN chmod +x /app/git_sync.sh 2>/dev/null || true

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
