#!/bin/bash

CHAT_ID=$TLG_CHAT_ID 
TEXT="$1" 
BOT_AUTH_TOKEN=$TLG_BOT_TOKEN 

echo "CHAT_ID="$CHAT_ID 
echo "TLG_BOT_TOKEN="$TLG_BOT_TOKEN
echo "BOT_AUTH_TOKEN="$BOT_AUTH_TOKEN

# -s, --silent        Silent mode (тихий режим)
# -S, --show-error    Show error even when -s is used (показывать ошибки даже в тихом режиме)
# -i, --include       Include protocol response headers in the output (включить в вывод заголовки ответа)
#  -m, --max-time <time> Maximum time allowed for the transfer (Сколько времени ждать ответа)
# Передаем все данные в curl, которым сделаем запрос к API Telegram на отправку сообщения.
curl -sS -i --max-time 30 \
        --header 'Content-Type: application/json' \
        --request 'POST' \
        --data '{"chat_id": "'"${CHAT_ID}"'", "text": "'"${TEXT}"'"}' \
        "https://api.telegram.org/bot${BOT_AUTH_TOKEN}/sendMessage" 2>&1
