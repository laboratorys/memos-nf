# 构建阶段
FROM neosmemo/memos:stable AS builder
WORKDIR /usr/local/memos

# 运行阶段
FROM debian:12-slim
WORKDIR /usr/local/memos

# 安装依赖并清理缓存
RUN apt-get update && \
    apt-get install -y curl tar && \
    rm -rf /var/lib/apt/lists/*

# 从构建阶段复制文件
COPY --from=builder /usr/local/memos/memos /usr/local/memos/
COPY backup.sh /usr/local/memos/

# 设置可执行权限
RUN chmod +x /usr/local/memos/memos /usr/local/memos/backup.sh

ENV MEMOS_MODE=prod
ENV MEMOS_PORT=5230
ENV TZ=Asia/Shanghai

RUN mkdir -p /var/opt/memos && \
    chown -R nobody:nogroup /var/opt/memos && \
    chmod -R 755 /var/opt/memos

# 修复：正确的 ENTRYPOINT 格式
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && exec /usr/local/memos/memos"]
