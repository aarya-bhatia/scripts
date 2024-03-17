#!/bin/sh
label="\uf17c"
label_nerdfont=
value=$(echo $label $(uname -a | cut -d" " -f3))
echo -e "%{A1:alacritty:}$value%{A}"
