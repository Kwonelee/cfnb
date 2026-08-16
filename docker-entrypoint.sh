#!/bin/bash
set -e
cd /app
echo "🚀 Starting Cloudflare IP优选工具 (每24小时执行一次)"
while true; do
    echo "⏰ $(date '+%Y-%m-%d %H:%M:%S') - 开始执行优选任务..."
    python3 /app/main.py
    echo "✅ $(date '+%Y-%m-%d %H:%M:%S') - 任务执行完成，等待24小时后再次运行"
    sleep 86400
done
