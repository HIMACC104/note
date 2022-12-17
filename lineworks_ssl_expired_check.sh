#!/bin/bash



function find_expired_date()
{
        #local color_yellow='\e[1;33m';
        local color_reset='\e[0m'
        local color_red='\e[0;31m';
        local color_green='\e[1;32m';
        #local color_purple='\e[0;35m';


	certification_dir_path=$(pwd)"/certification"

	sed -i '/^$/d' ssl_checklist


	success_count=0
	fail_count=0
	old_result=$(ls|grep ssl_expired.result)

	if [ "$old_result"!="" ]
	then
		rm -f *ssl_expired.result

	fi

        while read data_from_lineworks
        do

		vendor_number=$(echo -e $data_from_lineworks | awk -F "/" '{print $3}')
		whether_vendor_domain=$(echo $vendor_number|grep vd0)

		if [ "$whether_vendor_domain" != "" ]
		then
			path_ssl_half=$(echo -e $data_from_lineworks | awk -F ":" '{print $2}')
			path_ssl_half_after=$(echo -e $path_ssl_half| sed 's/^.//')
			path_ssl=$certification_dir_path$path_ssl_half_after
			
			if [ -d "${path_ssl}" ]
			then
				cd ${path_ssl}
				echo -e ""$path_ssl_half_after"$color_green success. $color_reset"
				domain_name=$(echo -e $data_from_lineworks | awk -F "/" '{print $NF}')
				fullchain_name=$(ls | grep fullchain)
				result=$(date --date="$(openssl x509 -noout -enddate -in ${fullchain_name}  | cut -d= -f 2)" --iso-8601)
            			cd ../../../..
				if [ -f "./$vendor_number.result" ]; 
				then
					echo ${domain_name} $result >> $vendor_number.ssl_expired.result
				else
					touch $vendor_number.ssl_expired.result
					echo ${domain_name} $result >> $vendor_number.ssl_expired.result
				fi
				((success_count++))
			else
				if [ -f "./error.ssl_expired.result" ];
                                then
                                        echo ${path_ssl} >> error.ssl_expired.result
                                else
                                        touch error.ssl_expired.result
                                        echo ${path_ssl} >> error.ssl_expired.result
				fi
				echo -e ""$path_ssl_half_after"$color_red Fail. $color_reset"
				((fail_count++))

			fi
		fi


        done < ssl_checklist

	echo ""
	echo "======Result======"
	echo "Success: $success_count" 
	echo "Failed: $fail_count"
	echo "=================="
	echo ""

	#echo -e "$color_green All check done. $color_reset"
        #rm -f total_list
}

find_expired_date
