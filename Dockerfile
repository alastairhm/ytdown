FROM alastairhm/alpine-python3

RUN pip3 install --upgrade youtube_dl

WORKDIR /mnt
ENTRYPOINT ["youtube-dl"]
