FROM neosmemo/memos:stable

WORKDIR /usr/local/memos

RUN apk add --no-cache curl tar libc6-compat

COPY backup.sh /usr/local/memos/backup.sh
RUN chmod +x /usr/local/memos/backup.sh

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/entrypoint.sh /usr/local/memos/memos"]