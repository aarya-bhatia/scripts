#!/bin/sh

terminal="\uf120"
firefox="\uf269"
document="\uf15b"
chat="\uf0e0"
discord="\uf392"
music="\uf001"
tasks="\uf0ae"

F1() {
	echo -e -n "%{A1:$1:}$2 %{A}"
}

echo -e $(F1 "alacritty" ${terminal})		\
		$(F1 "firefox"	${firefox})			\
		$(F1 "thunderbird"	${chat})		\
		%{T3}$(F1 "discord"	${discord})%{T-} \
		$(F1 "alacritty -e ncmpcpp"	${music})
