# Youtube-dl

## A Docker image for `Youtube-dl`

This repository provides an automated build for a lean [Youtube-dl]()https://github.com/yt-dlp) Docker image.

## Usage

Simple download to MP4 format, see [Youtube-dl Docs](https://github.com/yt-dlp) for more information on other options.

```bash
docker run --rm -v "$PWD:/mnt" alastairhm/ytdown "https://www.youtube.com/watch?v=vJLbRjovtro"
```
