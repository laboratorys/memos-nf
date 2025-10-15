FROM neosmemo/memos:stable

WORKDIR /usr/local/memos

# 安装更多兼容性库和调试工具
RUN apk add --no-cache curl tar gcompat libc6-compat gcc musl-dev sqlite-dev libgcc libstdc++ strace && \
    ln -sf /usr/lib/libucontext.so.1 /usr/lib/libucontext.so && \
    ln -sf /usr/lib/libobstack.so.1 /usr/lib/libobstack.so && \
    ldconfig /lib /usr/lib || true

COPY backup.sh /usr/local/memos/backup.sh
RUN chmod +x /usr/local/memos/backup.sh

# 调试：检查依赖和符号
RUN ldd /usr/local/memos/backup2gh && nm -D /usr/lib/gcompat/libgcompat.so.0 | grep fcntl64 || true

ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && /usr/local/memos/memos"]
