FROM neosmemo/memos:stable AS builder

WORKDIR /usr/local/memos

FROM debian:slim

WORKDIR /usr/local/memos

RUN apt-get update && apt-get install -y curl tar sqlite3 libucontext1 libobstack-dev libresolv2 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/memos/memos /usr/local/memos/memos COPY --from=builder 

RUN chmod +x /usr/local/memos/memos

COPY backup.sh /usr/local/memos/backup.sh
RUN chmod +x /usr/local/memos/backup.sh

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && /usr/local/memos/memos"]
