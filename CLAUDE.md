# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A minimal Docker packaging of [yt-dlp](https://github.com/yt-dlp/yt-dlp) (a `youtube-dl` fork). There is no
application source code — the entire project is a `Dockerfile`, a `Taskfile.yml`, and a GitHub Actions
workflow. The built image's `ENTRYPOINT` is `yt-dlp` itself, so the image is invoked directly with yt-dlp's
own CLI arguments (e.g. a URL to download), mounting a host directory to `/mnt` to receive output:

```bash
docker run --rm -v "$PWD:/mnt" ghcr.io/alastairhm/ytdown:latest "https://www.youtube.com/watch?v=vJLbRjovtro"
```

## Commands

Builds are driven via [Task](https://taskfile.dev) (`Taskfile.yml`):

- `task build` — `docker buildx build -t alastairhm/ytdown:latest ./`
- `task push` — `docker push alastairhm/ytdown:latest`

There is no test suite, linter, or application code to run — changes are almost always edits to the
`Dockerfile` itself, verified by building the image and running a download through it.

## Architecture

- `Dockerfile` — single-stage build on `ubuntu:22.04`; installs `yt-dlp` via `pip3` plus its runtime deps
  (`ffmpeg`, `git`, `build-essential`, `python3`). `WORKDIR /mnt` is the mount point for output, and
  `ENTRYPOINT ["yt-dlp"]` means the container is a thin, direct wrapper around the `yt-dlp` binary — CLI args
  passed to `docker run` pass straight through to `yt-dlp`.
- `.github/workflows/deploy.yml` — on every push/PR to `master`, builds the Docker image and pushes it to
  `ghcr.io/<repo>:latest` (GitHub Container Registry). Note this pushes on PRs too, not just merges to
  `master`.
- `Taskfile.yml` — separate, manual path for building/pushing to Docker Hub (`alastairhm/ytdown`) rather than
  GHCR. The two publishing paths (CI → GHCR, Taskfile → Docker Hub) are independent and use different image
  tags/registries.
- `CHANGELOG.md` — follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format; update it when
  making notable changes (e.g. bumping the pinned `yt-dlp` version).
