FROM docker.io/alpine:3.21.3 AS downloader

ARG FACTORIO_VERSION=2.0.42

RUN apk add --no-cache wget tar xz && \
    wget -O factorio_headless_x64_${FACTORIO_VERSION}.tar.xz https://www.factorio.com/get-download/${FACTORIO_VERSION}/headless/linux64 && \
    tar -xJf factorio_headless_x64_${FACTORIO_VERSION}.tar.xz && \
    rm factorio_headless_x64_${FACTORIO_VERSION}.tar.xz

FROM docker.io/ubuntu

COPY --from=downloader /factorio /opt/factorio

EXPOSE 34197/udp
ENV SAVE_NAME="save"

VOLUME [ "/saves" ]

CMD /opt/factorio/bin/x64/factorio --start-server "/saves/${SAVE_NAME}.zip"
