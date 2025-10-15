FROM neosmemo/memos:stable

WORKDIR /usr/local/memos

RUN apk add --no-cache curl tar gcompat libc6-compat gcc musl-dev sqlite-dev libgcc libstdc++

COPY backup.sh /usr/local/memos/backup.sh
RUN chmod +x /usr/local/memos/backup.sh

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && /usr/local/memos/entrypoint.sh /usr/local/memos/memos"]
