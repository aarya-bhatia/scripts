#!/bin/sh
title=$(playerctl -f "{{title}}" metadata | head -c 40)
echo $title
