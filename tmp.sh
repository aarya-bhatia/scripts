#!/bin/sh
always=0
never=0

confirm() {
	ret_yes=0
	ret_no=1

	if [ $always -eq 1 ]; then
		return $ret_yes
	fi

	if [ $never -eq 1 ]; then
		return $ret_no
	fi

	printf "$1 [y/n]:"
	read ans

	if [ "$ans" = 'y' ]; then
		return $ret_yes
	fi

	return $ret_no
}

confirm "Hello" && echo "ok"
