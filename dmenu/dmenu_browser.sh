#!/usr/bin/env bash
BROWSER=firefox
SEARCH_ENGINE="https://www.google.com/search?q="

values="clipboard
ce https://courses.illinois.edu
gh https://github.com
gg https://www.google.com
gpt https://chat.openai.com
lc https://leetcode.com
nx https://netflix.com
pl https://us.prairielearn.com
r https://reddit.com
w https://web.whatsapp.com
yt https://youtube.com"

chosen=$(printf "%s" "$values" | dmenu -i -l 20 | tr -d '\n')
if [ -z "$chosen" ]; then
	exit 0
fi

if [ "$chosen" = "clipboard" ]; then
	chosen="$(xsel -b -o)"
fi

if echo $chosen  | grep -qE "https?"; then
	chosen=$(echo "$chosen" | cut -d" " -f2)
	exec $BROWSER "$chosen"
else
	notify-send "Your search term: $chosen"
	if which urlencode; then
		chosen=$(echo $chosen | urlencode)
	fi
	exec $BROWSER "$SEARCH_ENGINE$chosen"
fi
