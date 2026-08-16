#!/bin/bash
set -e
cd /app

# 从环境变量读取执行间隔（秒），默认 7 天 = 604800 秒
# 可以通过设置环境变量 INTERVAL_SECONDS 来覆盖
# 例如：INTERVAL_SECONDS=3600 表示每小时执行一次
if [ -z "$INTERVAL_SECONDS" ]; then
    INTERVAL_SECONDS=604800  # 默认 7 天
fi

# 将秒数转换为可读格式，方便日志显示
format_duration() {
    local seconds=$1
    local days=$((seconds / 86400))
    local hours=$(((seconds % 86400) / 3600))
    local minutes=$(((seconds % 3600) / 60))
    local secs=$((seconds % 60))
    
    if [ $days -gt 0 ]; then
        echo "${days}天${hours}小时${minutes}分钟"
    elif [ $hours -gt 0 ]; then
        echo "${hours}小时${minutes}分钟"
    elif [ $minutes -gt 0 ]; then
        echo "${minutes}分钟${secs}秒"
    else
        echo "${secs}秒"
    fi
}

INTERVAL_READABLE=$(format_duration $INTERVAL_SECONDS)
echo "🚀 Starting Cloudflare IP优选工具 (每 ${INTERVAL_READABLE} 执行一次)"

while true; do
    echo "⏰ $(date '+%Y-%m-%d %H:%M:%S') - 开始执行优选任务..."
    python3 /app/main.py
    echo "✅ $(date '+%Y-%m-%d %H:%M:%S') - 任务执行完成，等待 ${INTERVAL_READABLE} 后再次运行"
    sleep $INTERVAL_SECONDS
done
