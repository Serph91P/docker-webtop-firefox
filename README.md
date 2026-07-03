# docker-webtop-firefox

Firefox single-app image for Sealskin based on the official LinuxServer Firefox image: `lscr.io/linuxserver/firefox:latest`.

## Behavior

- Inherits Firefox, Selkies, nginx, pcmflux, pixelflux, labwc and LinuxServer `/init` from `lscr.io/linuxserver/firefox`.
- Runs Firefox in a persistent `/config/firefox-vpn-profile` profile.
- Bakes in the Sealskin Gluetun HTTP proxy by default: `http://sealskin-vpn-proxy:8888`.
- Applies the Twitch-compatible Firefox profile prefs used by the previous working setup.
- Forces `/defaults/autostart_wayland` into persistent labwc config on every boot so stale Sealskin config does not restore a broken launcher.

Set `SEALSKIN_BROWSER_PROXY` to an empty string to disable proxying in custom deployments.
