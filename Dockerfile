FROM ubuntu:22.04

RUN apt-get update
RUN apt-get -y upgrade 
RUN apt-get -y install git build-essential pip ffmpeg python3 
RUN pip3 install yt-dlp

WORKDIR /mnt
ENTRYPOINT ["yt-dlp"]
