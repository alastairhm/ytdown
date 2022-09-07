FROM ubuntu:22.04

RUN apt-get update && apt-get -y upgrade && apt-get -y install git build-essential pip ffmpeg python3 \
    python3 -m pip install -U yt-dlp

WORKDIR /mnt
ENTRYPOINT ["yt-dlp"]
