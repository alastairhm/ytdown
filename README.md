# Youtube-dl

## A Docker image for `Youtube-dl`

This repository provides an automated build for a lean [Youtube-dl]()https://github.com/yt-dlp) Docker image.

## Usage

Simple download to MP4 format, see [Youtube-dl Docs](https://github.com/yt-dlp) for more information on other options.

```bash
docker run --rm -v "$PWD:/mnt" ghcr.io/alastairhm/ytdown:latest "https://www.youtube.com/watch?v=vJLbRjovtro"
```
