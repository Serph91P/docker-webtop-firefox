FROM ghcr.io/linuxserver/baseimage-selkies:arch

ARG BUILD_DATE
ARG VERSION
ARG CACHE_BUST

LABEL build_version="Custom Firefox VPN image - Build-date:- ${BUILD_DATE}"
LABEL maintainer="Serph91P"
LABEL org.opencontainers.image.title="docker-webtop-firefox"
LABEL org.opencontainers.image.description="Firefox single-app browser for Sealskin with built-in VPN proxy profile"
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
    SEALSKIN_BROWSER_PROXY="http://sealskin-vpn-proxy:8888"

COPY root/ /

RUN set -eux;     echo "**** cache bust ${CACHE_BUST:-none} ****";     pacman -Sy --noconfirm --needed         ca-certificates         curl         dbus         firefox         gtk3         nss         ttf-dejavu         xdg-user-dirs         xdg-utils         xorg-xwayland;     curl -fsSL -o /usr/share/selkies/www/icon.png         https://raw.githubusercontent.com/mozilla-firefox/firefox/main/browser/branding/official/default256.png;     chmod +x /defaults/autostart /defaults/autostart_wayland /defaults/startwm_wayland.sh /usr/local/bin/run-firefox;     sed -i 's|/bin/sh$|/bin/bash|g' /etc/passwd;     mkdir -p /config/Documents;     HOME=/config XDG_CONFIG_HOME=/config/.config xdg-user-dir DOCUMENTS;     firefox --version;     rm -rf /config/.cache /tmp/* /var/cache/pacman/pkg/* /var/lib/pacman/sync/*

EXPOSE 3000
VOLUME /config
