FROM debian:latest as builder

ARG VERSION=0.2.0
ARG ARCH=amd64

RUN apt update && \
    apt install -y curl && \
    if [[ "$ARCH" == "ARM64" ]]; then \
      OSARCH="arm64" \
    elif [[ "ARCH" == "X64" ]]; then \
      OSARCH="amd64" \ 
    else \
      OSARCH=$ARCH \
    fi && \
    curl -sLo /tmp/messagebird_exporter.deb \
    https://github.com/roaldnefs/messagebird_exporter/releases/download/v${VERSION}/messagebird_exporter_${VERSION}_linux_${OSARCH}.deb && \
    apt install -y /tmp/messagebird_exporter.deb


FROM debian:latest as production
LABEL maintainer="info@warpnet.nl"

RUN adduser --system -uid 800 --no-create-home messagebird_exporter

COPY --from=builder /usr/bin/messagebird_exporter /usr/bin/messagebird_exporter

WORKDIR /tmp
USER messagebird_exporter
ENTRYPOINT /usr/bin/messagebird_exporter --web.listen-address="${LISTEN_ADDRESS:-:9601}" --messagebird.api-key="$MESSAGEBIRD_API_KEY"
