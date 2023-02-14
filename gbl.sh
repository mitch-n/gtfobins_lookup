#!/bin/bash

gtfobins_dir=/usr/share/gtfobins
filter="."

if [ $2 ]
then 
	filter=$(echo $2 | sed 's/,/|/')
fi
#echo "FUNCTION: $functions"


function update_gtfobins () {
	rm -rf $1/*
	mkdir $1/temp
	git clone https://github.com/GTFOBins/GTFOBins.github.io.git $1/temp
	mv $1/temp/_gtfobins/* $1
	rm -rf $1/temp	
}


if [ ! -d "$gtfobins_dir" ]
then
	mkdir $gtfobins_dir
	update_gtfobins $gtfobins_dir
fi


cat $1 | while read line
do
	
	tool_name=$(echo $line | rev | cut -d "/" -f1 | rev)
	tool_path="$gtfobins_dir/$tool_name.md"
	if [ "$(grep $filter $tool_path 2>/dev/null)"  ]
	then
		echo $line
		cat $tool_path | sed 's/^/    /'
		echo ""
	fi
done

