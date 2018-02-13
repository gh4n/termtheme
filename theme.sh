#!/bin/bash

CONFIG_FILE="/home/han/src.txt"
THEME_FILE="/home/han/themes.grace"
usage="$0 [theme] [optional flags]"
args=$#

function change_theme {
	#grep config file for defined symb
	#define starting line num
	# delete from starting line to end of config file,
}


if [ $args -ne 1 ]; then
	echo $usage
else
	theme_name=$1
	change_theme "$theme_name";
fi



