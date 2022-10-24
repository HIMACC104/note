#!/bin/bash

function total_file_and_list()
{
	path_now="$('pwd')"
	#echo $path_now
	#count="$path_now"

	#echo -e "Now path is $(count)"
	#total_list=$(ls *.zip | awk '{print $NF}')
	#echo $total_list > "$path_now/total_list"
	ls *.zip | awk '{print $NF}' > "$path_now/total_list"
	count=$(cat "$path_now/total_list" | wc -l)
	echo "Total zip : $count"
}
total_file_and_list


function unzip_and_make_fullchain()
{
	while read zip_file_name
	do
		#echo $domain_name 
		#echo hi
		key_before="_key.txt"
		key_after=".key"

		crt_profix=".crt"
		crt_file_name=""
		gd_file_name=""
		domain_name=$(echo $zip_file_name|awk -F. '{print $1"."$2}')
		local color_reset='\e[0m'
		local color_red='\e[0;31m';
		local color_green='\e[1;32m';

		#echo $domain_name
		mkdir "$('pwd')/$domain_name"
		mv $zip_file_name "$('pwd')/$domain_name/"
		cp "$domain_name$key_before" "$('pwd')/$domain_name/$domain_name$key_after"   # cp need to change to mv after finish
		cd "$('pwd')/$domain_name/"
		unzip $zip_file_name > /dev/null
		mv $zip_file_name ./..        # need to remove this line after finish
		gd_file_name=$(ls| grep gd)
		#echo $gd_file_name
		crt_file_name=$(ls| grep pem|awk -F. '{print $1".crt"}')

		cat $crt_file_name $gd_file_name > fullchain.crt



		RSA_KEY=$(openssl rsa -noout -modulus -in $domain_name$key_after | openssl md5|awk '{print $2}')
		#echo $RSA_KEY
		X509_CRT=$(openssl x509 -noout -modulus -in fullchain.crt | openssl md5|awk '{print $2}')
		#echo $X509_CRT

		if [ "${RSA_KEY}" == "${X509_CRT}" ]
		then
			echo -e "$domain_name crt check ${color_green}Success${color_reset}"
			#grep -v $gd_file_name|grep -v $
		else
			echo -e "$domain_name crt check ${color_red}Fail${color_reset}"
		fi

		ls |grep -v "$domain_name$key_after" | grep -v "fullchain.crt" | xargs rm -f

		#echo $crt_file_name
		#rm -f $zip_file_name         # need to open after finish
		cd ./..

	done < total_list

}
unzip_and_make_fullchain
rm -f "$('pwd')/total_list"
