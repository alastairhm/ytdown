# Youtube-dl

## A Docker image for `Youtube-dl`

This repository provides an automated build for a lean [Youtube-dl](https://ytdl-org.github.io/youtube-dl/index.html) Docker image.

## Usage

Simple download to MP4 format, see [Youtube-dl Docs](https://github.com/ytdl-org/youtube-dl/blob/master/README.md#options) for more information on other options.

```bash
docker run --rm -v "$PWD:/mnt" alastairhm/ytdown "https://www.youtube.com/watch?v=vJLbRjovtro"
```
