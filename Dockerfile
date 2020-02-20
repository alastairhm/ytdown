FROM alastairhm/alpine-python3

RUN apk add --no-cache --update ffmpeg && \
    pip3 install --upgrade youtube_dl

WORKDIR /mnt
ENTRYPOINT ["youtube-dl"]
