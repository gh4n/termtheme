#!/bin/bash

CONFIG_FILE="/home/han/Projects/termtheme/test/src.txt"
THEME_FILE="/home/han/Projects/termtheme/test/themes.grace"
usage="$0 [theme] [optional flags]"
args=$#

function change_theme {
	
	# parse config file for theme flags
	start_line=$(grep -nr themeterm.start $CONFIG_FILE | awk -F: '{print $1}')
	end_line=$(grep -nr themeterm.end $CONFIG_FILE | awk -F: '{print $1}')

	start_line=$((start_line + 1))
	end_line=$((end_line - 1))

	# delete from starting line to end line
	sed -i.bak -e "${start_line}, ${end_line}d" $CONFIG_FILE
	
	# parse theme file for theme name
	OUTPUT=$(grep -nr $1 $THEME_FILE | awk -F: '{print $1}')
	
	if [[ $OUTPUT ]]; then
		theme_start_line=$OUTPUT
	else
		echo theme not found!
	fi

	# get endline, if returns nothing assume end of file 
	OUTPUT=$(tail -n +$theme_start_line $THEME_FILE | grep -i -n ">" | awk -F: 'NR==1{print $1}')
	if [[ $OUTPUT ]]; then
		theme_end_line=$OUTPUT
	else
		theme_end_line=$(wc -l < $THEME_FILE)
	fi

	# parse config file again for line to paste code
	start_line=$(grep -nr themeterm.start $CONFIG_FILE | awk -F: '{print $1}')

	# copy and paste code
	theme=$(sed -n "${theme_start_line}, ${theme_end_line}p" $THEME_FILE)
	sed '${start_line} a ${theme}' $CONFIG_FILE
	

	# refresh config file
	xrdb $CONFIG_FILE

}


if [ $args -ne 1 ]; then
	echo $usage
else
	theme_name=$1
	change_theme "$theme_name";
fi



