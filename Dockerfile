FROM ubuntu:22.04

RUN apt-get update && apt-get -y upgrade && apt-get -y install git build-essential pip ffmpeg python3 
RUN pip3 install yt-dlp

WORKDIR /mnt
ENTRYPOINT ["yt-dlp"]
