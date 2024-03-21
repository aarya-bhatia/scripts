#!/bin/sh
pkgcount=$(pacman -Q | wc -l)
pkguser=$(pacman -Qe | wc -l)
echo -e "\uf07a $pkguser/$pkgcount"

