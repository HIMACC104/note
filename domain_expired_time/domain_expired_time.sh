#!/bin/bash

function domain_expired_time_check()
{
  local domain_name=""
  local expired_time=""
  local whether_kuhaku=""
  local path="$(pwd)/result"
  #echo $path 

  echo -e $(rm -f ${path}) 
  echo -e $(touch ${path}) 

  while read list_domain
  do
    domain_name=$list_domain
    expired_time=$(whois $list_domain | grep -i "Registry Expiry Date:" | awk -F  '[ T]' '{print $4}')

    whether_kuhaku=$(echo ${expired_time}|grep '20')
    #echo ${whether_kuhaku}

    if [ "${whether_kuhaku}" == "" ]
    then
    	expired_time=$(echo -e $(whois $list_domain |grep -i 'Registry Expiry Date:'| awk -F  '[ T]' '{print $7}'))
    fi


    echo ""
    echo $domain_name
    echo -e ${expired_time}
    echo -e ${expired_time} >> result
    #echo ""
    sleep 0.5
  done < list_domain
}
domain_expired_time_check

echo ""
echo "Domain expired check done. "
echo ""
