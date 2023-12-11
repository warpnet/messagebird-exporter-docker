# Messagebird Exporter Docker

This repository builds a Docker container based on Debian that holds
[messagebird_exporter](https://github.com/roaldnefs/messagebird_exporter) as created by Roald Nefs

Usage:

```bash
docker run -e MESSAGEBIRD_API_KEY="API_TOKEN" warpnetbv/messagebird-exporter:latest
```

To specify a different listen address:

```bash
docker run -e LISTEN_ADDRESS=":9601" -e MESSAGEBIRD_API_KEY="API_TOKEN" warpnetbv/messagebird-exporter:latest
```
