# TODO

Issues and improvement ideas found while reviewing the repo (Dockerfile, Taskfile.yml, README.md,
CHANGELOG.md, `.github/workflows/deploy.yml`). Not yet actioned — tracked here for follow-up.

## CI / release process

- [ ] `deploy.yml` builds **and pushes** to `ghcr.io/…:latest` on every `pull_request` to `master`, not just
      on merge — any open PR overwrites the `latest` tag before review completes. Push only on `push` to
      `master`; build-only (no push) on PRs to validate the Dockerfile.
- [ ] Image is only ever tagged `:latest` (both GHCR and Docker Hub) — no versioned tag (e.g. git SHA, a
      semver tag, or the pinned yt-dlp version), so there's no way to pin to or roll back to a prior build.
- [ ] No scheduled rebuild. Since the Dockerfile doesn't pin a yt-dlp version (see below), the image only
      picks up yt-dlp fixes when *this* repo changes — a `schedule:` trigger (e.g. weekly) would keep it
      current with upstream yt-dlp releases, which ship frequently to fix site breakage.
- [ ] `deploy.yml` has no `permissions:` block (least-privilege for the `GITHUB_TOKEN`) and no
      `workflow_dispatch` trigger for manual re-runs.
- [ ] Two independent, differently-tagged publish paths exist (CI → GHCR, `Taskfile.yml` → Docker Hub) with
      no shared versioning — worth consolidating or at least documenting why both exist.

## Dockerfile

- [ ] yt-dlp version is unpinned (`pip3 install yt-dlp`) — every build picks up whatever is latest at build
      time, so builds aren't reproducible and a bad upstream release breaks the image with no easy diagnosis.
      Consider pinning (`yt-dlp==<version>`) and bumping deliberately, or explicitly documenting that it's
      intentionally always-latest.
- [ ] `apt-get -y upgrade` in the Dockerfile is a Docker anti-pattern — it makes builds non-reproducible
      (behavior depends on whatever's newest in the apt repos that day) and defeats layer caching. Prefer
      pinning the base image tag and rebuilding to pick up updates.
- [ ] No apt cache cleanup (`rm -rf /var/lib/apt/lists/*`) and no `pip install --no-cache-dir` — both leave
      unnecessary bytes in the image layers, which matters since the README calls this a "lean" image.
- [ ] `git` and `build-essential` are installed but it's not obvious yt-dlp needs them at runtime — if
      they're only needed to build a pip package from source, a slimmer base (e.g. `python:3.x-slim`) plus
      just the runtime deps (`ffmpeg`, `pip`) would shrink the image substantially. Worth confirming whether
      they're actually required.
- [ ] Runs as root — no non-root `USER` is set.
- [ ] No `LABEL` metadata (e.g. `org.opencontainers.image.source`) — useful for GHCR to link the package back
      to this repo.
- [ ] No `DEBIAN_FRONTEND=noninteractive` — `ffmpeg` pulls in `tzdata`, which can prompt interactively and
      hang non-TTY builds in some environments.

## README.md

- [ ] Malformed markdown link: `[Youtube-dl]()https://github.com/yt-dlp)` — the URL is outside the
      parentheses, so it doesn't render as a link.
- [ ] Project is titled/described as "Youtube-dl" throughout but wraps `yt-dlp` (a different, actively
      maintained fork) — worth renaming references for clarity, since the two are commonly confused.
- [ ] Only documents the `ghcr.io` image; the Docker Hub image (`alastairhm/ytdown`, pushed via
      `task push`) isn't mentioned anywhere.

## CHANGELOG.md

- [ ] Dates look inconsistent: the `2020.06.16.1 2020-07-09` entry lists "Updated to yt-dlp 2022.09.01" — a
      2022 update recorded under a 2020-dated release heading.
- [ ] Hasn't been updated for the last several commits (Ubuntu base image switch, GitHub Actions build,
      README/build tweaks) despite the file claiming to adhere to Keep a Changelog — those changes are only
      visible via `git log`, not the changelog.

## Taskfile.yml

- [ ] `push` doesn't depend on `build` (no `deps:`), so running `task push` on its own can push a stale or
      nonexistent local image rather than failing loudly or building first.
- [ ] Only ever builds/pushes `:latest`, same versioning gap as the CI workflow above.
