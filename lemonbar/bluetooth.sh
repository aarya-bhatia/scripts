#!/bin/sh

status=$(bluetooth status)
off=#f0f2ed

if echo $status | grep -q "on"; then
	echo %{+u}  %{-u}
else
	echo %{u${off}}%{+u}  %{-u}%{u-}
fi
