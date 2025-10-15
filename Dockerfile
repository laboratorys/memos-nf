# 第一阶段：构建 memos
FROM neosmemo/memos:stable AS builder
WORKDIR /usr/local/memos

# 第二阶段：运行环境
FROM debian:12-slim
WORKDIR /usr/local/memos

# 安装依赖
RUN apt-get update && apt-get install -y curl tar

# 从 builder 复制 memos 二进制文件
COPY --from=builder /usr/local/memos/memos /usr/local/memos/

# 复制 backup.sh 脚本
COPY backup.sh /usr/local/memos/
RUN chmod +x /usr/local/memos/backup.sh /usr/local/memos/memos

# 设置入口点
ENTRYPOINT ["/bin/sh", "-c", "/usr/local/memos/backup.sh && /usr/local/memos/memos
