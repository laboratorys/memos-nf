FROM neosmemo/memos:stable

WORKDIR /usr/local/memos

# 安装更多兼容性库和调试工具
RUN apk update && apk add --no-cache curl tar gcompat libc6-compat gcc musl-dev sqlite-dev libgcc libstdc++ strace && \
    ls -l /usr/lib | grep gcompat || true && \
    apk info gcompat || true && \
    ldconfig /lib /usr/lib || true

COPY backup.sh /usr/local/memos/backup.sh
RUN chmod +x /usr/local/memos/backup.sh

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && /usr/local/memos/memos"]
