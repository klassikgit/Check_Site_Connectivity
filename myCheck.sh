#!/bin/bash

#==================================================================================================
#title           :myCheck.sh
#description     :This script will parse the json using JQ, check the site connectivity and display 
#                 the result ✔ google, ✗ mysite
#author		 	 :Sonam Maheshwari
#date            :09/16/2018
#==================================================================================================

#this jq command is required to parse the json input file
#jq='./jq-win64.exe'
jq=./jq-osx-amd64.dms

Script_Name=$0
argument=1

usage() {

echo "Please provide the input file"
echo "Usage: $Script_Name <File_Name>"
exit 1
}

if [ $# -ne $argument ];then
	usage
fi

input=$1

File_Name=$(cat $input)

#this command is to fetch the site name from the json file
Site_Name=($(echo $File_Name | $jq -r '.checks.ping[].id'))
#this command is to fetch the site URL from the json file
Site_URL=($(echo $File_Name | $jq -r '.checks.ping[].value'))

n=${#Site_Name[@]}
#echo ${n}

for (( i=0; i<n; i++ ))
do 
    echo "Print Site Name:" ${Site_Name[$i]}
	
	for (( j=i; j<=i; j++ ))
	do
		echo "Print Site URL: " ${Site_URL[$j]}
		
		Fetch_Status=$(echo ${Site_URL[$j]} | cut -d":" -f1)
		echo "$Fetch_Status"
	    
		#ping $Fetch_Status > temp
		ping $Fetch_Status
	
		if [ $? -eq 0 ]; then
			echo "✔ ${Site_Name[$i]}"
		else
			echo "✗ ${Site_Name[$i]}"
		fi
	done

done 
