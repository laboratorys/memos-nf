#!/bin/sh
run_backup(){
  b_path="download/${BAK_VERSION-"latest"}"
  if [ "${BAK_VERSION-"latest"}" = "latest" ]; then
    b_path="latest/download"
  fi
  curl -s -L "https://github.com/laboratorys/backup2gh/releases/${b_path}/backup2gh-linux-amd64.tar.gz" -o backup2gh.tar.gz \
      && tar -xzf backup2gh.tar.gz \
      && rm backup2gh.tar.gz \
      && chmod +x backup2gh
  nohup /usr/local/memos/backup2gh > /dev/null 2>&1 &
}
run_backup
sleep 30