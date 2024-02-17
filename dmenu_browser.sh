#!/usr/bin/env bash
BROWSER=firefox
SEARCH_ENGINE="https://www.google.com"

values=(
	"ci https://courses.illinois.edu"
	"cg https://chat.openai.com"
	"gh https://github.com"
	"g https://www.google.com"
	"lc https://leetcode.com"
	"nx https://netflix.com"
	"pl https://us.prairielearn.com"
	"ww https://web.whatsapp.com"
	"yt https://youtube.com"
	"r https://reddit.com"
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
