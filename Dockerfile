FROM lscr.io/linuxserver/firefox:latest

ARG BUILD_DATE
ARG VERSION
ARG CACHE_BUST

LABEL build_version="Custom Firefox VPN image based on lscr.io/linuxserver/firefox - Build-date:- ${BUILD_DATE}"
LABEL maintainer="Serph91P"
LABEL org.opencontainers.image.title="docker-webtop-firefox"
LABEL org.opencontainers.image.description="LinuxServer Firefox image for Sealskin with built-in VPN proxy profile"
LABEL org.opencontainers.image.source="https://github.com/Serph91P/docker-webtop-firefox"

ENV TITLE="Firefox VPN" \
    PIXELFLUX_WAYLAND=true \
    SELKIES_DESKTOP=false \
    AUTO_GPU=true \
    NO_GAMEPAD=true \
    NO_DECOR=true \
    TZ="Europe/Berlin" \
    LANG="de_DE.UTF-8" \
    LANGUAGE="de_DE:de:en_US:en" \
    LC_ALL="de_DE.UTF-8" \
    GTK_THEME="Adwaita:dark" \
    COLOR_SCHEME="dark" \
    SEALSKIN_BROWSER_PROXY="http://sealskin-vpn-proxy:8888"

COPY root/ /

RUN set -eux; \
    echo "**** cache bust ${CACHE_BUST:-none} ****"; \
    chmod +x /defaults/autostart /defaults/autostart_wayland /defaults/startwm_wayland.sh /usr/local/bin/run-firefox; \
    mkdir -p /config/Documents; \
    firefox --version; \
    rm -rf /config/.cache /tmp/*

EXPOSE 3000
VOLUME /config
