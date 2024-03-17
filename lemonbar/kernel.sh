#!/bin/sh
value=$(echo  $(uname -a | cut -d" " -f3))
echo -e "%{A1:alacritty:}$value%{A}"
