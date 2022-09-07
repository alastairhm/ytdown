FROM alastairhm/alpine-python3

RUN apk add --no-cache --update ffmpeg && \
    python3 -m pip install -U yt-dlp

WORKDIR /mnt
ENTRYPOINT ["yt-dlp"]
