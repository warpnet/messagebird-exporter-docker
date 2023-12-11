FROM alpine:latest as builder

ARG VERSION=0.2.0

WORKDIR /tmp
RUN apk update && \
    apk add curl && \
    curl -sLo ./messagebird_exporter.tar.gz \
    https://github.com/roaldnefs/messagebird_exporter/releases/download/v${VERSION}/messagebird_exporter_${VERSION}_linux_amd64.tar.gz && \
    tar -xf messagebird_exporter.tar.gz


FROM alpine:latest as production
LABEL maintainer="info@warpnet.nl"

#RUN adduser --system -uid 800 --no-create-home messagebird_exporter
RUN addgroup -S -g 800 messagebird_exporter \
 && adduser -S -u 800 -S -H -D -G messagebird_exporter messagebird_exporter

COPY --from=builder /tmp/messagebird_exporter /usr/bin/messagebird_exporter

WORKDIR /tmp
USER messagebird_exporter
ENTRYPOINT /usr/bin/messagebird_exporter --web.listen-address="${LISTEN_ADDRESS:-:9601}" --messagebird.api-key="$MESSAGEBIRD_API_KEY"
