#!/bin/sh

set -e

VERSION=${VERSION:-"17.5"}
ARCH=$(uname -m)
WORKDIR="/app"

# 适配架构
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  armv7l) ARCH="armv7" ;;
  *) echo "❌ 不支持的架构: $ARCH"; exit 1 ;;
esac

echo "📦 安装依赖..."
if command -v apk >/dev/null 2>&1; then
  apk add --no-cache curl tar ca-certificates
else
  echo "❌ 当前不是 Alpine 系统，请使用原版脚本。"
  exit 1
fi

# 创建目录
mkdir -p $WORKDIR
cd $WORKDIR

# 下载探针
echo "⬇️  下载哪吒探针 v$VERSION ($ARCH)..."
curl -L -o nezha-agent.tar.gz "https://github.com/naiba/nezha/releases/download/v$VERSION/nezha-agent_linux_${ARCH}.tar.gz"

tar -xzf nezha-agent.tar.gz
chmod +x nezha-agent

# 提示启动方式
echo "✅ 安装完成，启动命令示例："
echo "./nezha-agent -s nezha.hani.nyc.mn:443 -p SuqDQlGuIlMYwiGeGP --tls"
