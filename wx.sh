#!/bin/bash

map=(
  '星期天'
  '星期一'
  '星期二'
  '星期三'
  '星期四'
  '星期五'
  '星期六'
)
week=$(echo ${map[$(date +%w)]})

wx=$(curl -d "city=haidian&appkey=$APP_KEY" "https://way.jd.com/he/freeweather" | jq '.result.HeWeather5[0].daily_forecast[0]')

date=$(echo ${wx} | jq '.date' | cut -d '"' -f2)

txt_d=$(echo ${wx} | jq '.cond.txt_d' | cut -d '"' -f2)
txt_n=$(echo ${wx} | jq '.cond.txt_n' | cut -d '"' -f2)

max=$(echo ${wx} | jq '.tmp.max' | cut -d '"' -f2)
min=$(echo ${wx} | jq '.tmp.min' | cut -d '"' -f2)

curl -X POST "https://api.telegram.org/bot$API_TOKEN/sendMessage" -d "chat_id=@$CHANNEL_ID&disable_notification=true&text=北京海淀%0A${date}%0A${week}%0A${txt_d}/${txt_n}%0A${min}/${max}℃"
