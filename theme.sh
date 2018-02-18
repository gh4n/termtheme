#!/bin/bash

CONFIG_FILE="/home/han/Personal/termtheme/test/src.txt"
THEME_FILE="/home/han/Personal/termtheme/test/themes.grace"
usage="$0 [theme] [optional flags]"
args=$#

function change_theme {

	start_line=$(grep -nr themeterm.start $CONFIG_FILE | awk -F: '{print $1}')
	end_line=$(grep -nr themeterm.end $CONFIG_FILE | awk -F: '{print $1}')

	start_line=$((start_line + 1))
	end_line=$((end_line - 1))

	# delete from starting line to end line
	sed -i.bak -e "${start_line}, ${end_line}d" $CONFIG_FILE
	
	# parse theme file
	theme_start_line=$(grep -nr $1 $THEME_FILE | awk -F: '{print $1}')
	sed -n 's/> ${$1}/'  
}


if [ $args -ne 1 ]; then
	echo $usage
else
	theme_name=$1
	change_theme "$theme_name";
fi



