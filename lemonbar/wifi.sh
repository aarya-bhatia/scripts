#!/bin/sh
echo  $(hostname -i | cut -d" " -f1)
