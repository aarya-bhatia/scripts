#!/usr/bin/env bash
BROWSER=firefox
SEARCH_ENGINE="https://www.google.com"

values=(
	"https://courses.illinois.edu"
	"gh https://github.com"
	"gg https://www.google.com"
	"gpt https://chat.openai.com"
	"lc https://leetcode.com"
	"nx https://netflix.com"
	"pl https://us.prairielearn.com"
	"r https://reddit.com"
	"w https://web.whatsapp.com"
	"yt https://youtube.com"
)

chosen=$(for value in "${values[@]}"; do
    echo $value
done | dmenu -i -p "Run >" -l 20)

if [ -z "$chosen" ]; then
	# exec $BROWSER "$SEARCH_ENGINE"
	exit 0
fi

link=$(echo "$chosen" | cut -d" " -f2)
exec $BROWSER "$link"
