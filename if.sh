#!/bin/bash

function if_hima()
{
	local str=''
	local tmp=$(echo -e $(whois app-set.club|grep -i 'Registry Expiry Date:'| awk -F  '[ T]' '{print $4}'))
	echo $tmp
	local whether_kuhaku=$(echo ${tmp}|grep '20')
	echo ${whether_kuhaku}

	if [ "${whether_kuhaku}" == "" ]
	then
		tmp=$(echo -e $(whois app-set.club|grep -i 'Registry Expiry Date:'| awk -F  '[ T]' '{print $7}'))
	fi

	echo $tmp
}

if_hima
