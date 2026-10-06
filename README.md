# docker-webtop-firefox

Firefox single-app image for Sealskin based on the official LinuxServer Firefox image: a versioned and digest-pinned `lscr.io/linuxserver/firefox` base (see `Dockerfile`).

## Behavior

- Inherits Firefox, Selkies, nginx, pcmflux, pixelflux, labwc and LinuxServer `/init` from `lscr.io/linuxserver/firefox`.
- Runs Firefox in a persistent `/config/firefox-vpn-profile` profile.
- Bakes in the Sealskin Gluetun HTTP proxy by default: `http://sealskin-vpn-proxy:8888`.
- Applies the Twitch-compatible Firefox profile prefs used by the previous working setup.
- Forces `/defaults/autostart_wayland` into persistent labwc config on every boot so stale Sealskin config does not restore a broken launcher.

Set `SEALSKIN_BROWSER_PROXY` to an empty string to disable proxying in custom deployments.

## Base image updates

- `Dockerfile` pins the official LinuxServer release tag and multi-platform digest, rather than `latest`.
- Dependabot checks Docker dependencies every night at 03:00 Europe/Berlin, including weekends. The cron schedule is intentional: Dependabot's `daily` interval only runs on weekdays.
- Each update opens a pull request. The validation workflow builds the image without publishing and checks Firefox and the launcher.
- Updates are not automatically merged. Merging into `main` runs the existing release workflow, explicitly pulls the base image, publishes to GHCR, and dispatches the existing Sealskin store update.
- The current store tracks the custom image's `latest` tag and records its published digest. This is separate from the pinned LinuxServer base image.
- An already running Sealskin app container is not upgraded by a store change. Refresh/update the app through Sealskin so it recreates the container with the new image, retaining its persistent `/config` profile.

