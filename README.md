# Youtube-dl

## A Docker image for `yt-dlp`

This repository provides an automated build for a lean [yt-dlp](https://github.com/yt-dlp) Docker image.

## Usage

Simple download to MP4 format, see [yt-dlp Docs](https://github.com/yt-dlp) for more information on other options.

```bash
docker run --rm -v "$PWD:/mnt" ghcr.io/alastairhm/ytdown:latest "https://www.youtube.com/watch?v=vJLbRjovtro"
```

The image is also published to Docker Hub:

```bash
docker run --rm -v "$PWD:/mnt" alastairhm/ytdown:latest "https://www.youtube.com/watch?v=vJLbRjovtro"
```

```text
          _    _ __  __
    /\   | |  | |  \/  | Email    : alastair@montgomery.me.uk
   /  \  | |__| | \  / | Web      : https://blog.0x32.co.uk/
  / /\ \ |  __  | |\/| | Twitter  : @alastair_hm
 / ____ \| |  | | |  | | Mastodon : @Alastair@mastodon.me.uk
/_/    \_\_|  |_|_|  |_| (c) 2020
```
