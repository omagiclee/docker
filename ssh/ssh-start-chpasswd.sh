#!/bin/bash
# SSH 启动：可选设密、权限修复、每容器独立 host key、放宽 fd 限制后启动 sshd
set -e

# 每容器生成独立主机密钥，避免多实例/重建后出现 REMOTE HOST IDENTIFICATION HAS CHANGED
ssh-keygen -A

# StrictModes 要求：保证挂载或已有的 .ssh 目录权限符合 sshd 要求
mkdir -p /root/.ssh
chmod 700 /root/.ssh
[ -f /root/.ssh/authorized_keys ] && chmod 600 /root/.ssh/authorized_keys

# UsePAM no 时 limits.conf 不生效，预先放宽 fd 限制，避免训练时 Too many open files
ulimit -n 65535 2>/dev/null || true

if [ -n "${PASSWORD}" ]; then
  echo "root:${PASSWORD}" | chpasswd
fi
exec /usr/sbin/sshd -D
