# docker-webtop-firefox

Firefox single-app image for Sealskin based on LinuxServer baseimage-selkies.

## Behavior

- Runs Firefox in a persistent `/config/firefox-vpn-profile` profile.
- Bakes in the Sealskin Gluetun HTTP proxy by default: `http://sealskin-vpn-proxy:8888`.
- Keeps LinuxServer `/init`, Selkies, nginx, pcmflux, pixelflux, and labwc startup intact.
- Forces `/defaults/autostart_wayland` into persistent labwc config on every boot so stale Sealskin config does not restore a broken launcher.

Set `SEALSKIN_BROWSER_PROXY` to an empty string to disable proxying in custom deployments.
