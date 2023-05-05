#!/bin/bash
#Write by Hima 2023/4/18

function whether_input_exist()
{
  input_total=$#
  correct=1

  #echo $input_total
  #zennbu no innpultuto katu

  if [ "${input_total}" -eq 0 ]
  then
        #echo "Helle??? r u kidding me???????"
	correct=0
  fi
  #echo -e $@

  return "$correct"
}

function create_ssl_terraform_command()
{
	old_domain=$@  
	#total_number_input


	final_ssl_command_gtm="In 00.gtm: terraform apply \c"
	final_ssl_command="In main: terraform apply \c"
	#echo ""
	#echo "Upload SSL Command:"
	#echo ""
	#echo "In 00.gtm:"
        #echo -e $final_ssl_command
	final_not_00gtm=""
	final_00gtm=""

	for VAR in $old_domain
	do
		#echo "HIMA"
		#echo $VAR
		old_ssl_tf_path="$(find ./ -name *$VAR.tf)"
		#echo $old_ssl_tf_path
		#if [ $old_ssl_tf_path
		old_domain_front=$(echo $old_domain | awk -F '.' '{print $1}')
		old_domain_back=$(echo $old_domain | awk -F '.' '{print $2}')
		module_names=$(cat $old_ssl_tf_path | grep 'module ' | awk -F '"' '{print $2}'|grep -v cdnetworks|xargs -I {} echo -e "--target=module.{}")
		module_names=$module_names' '
		
		whether_00gtm=$(echo $old_ssl_tf_path|awk -F '/' '{print $4}')

		#gtm_string="00.gtm"

		#echo -e $VAR "$whether_00gtm" $gtm_string

		if [ "$whether_00gtm" == '00.gtm' ]
		then
			final_00gtm=$final_00gtm$module_names
		else
			final_not_00gtm=$final_not_00gtm$module_names
        #echo 'Input Correct.'
		fi	

		#module_names=$(cat $old_ssl_tf_path | grep 'module ' | awk -F '"' '{print $2}'|grep -v cdnetworks|xargs -I {} echo -e "--target=module.{}")
		#final_ssl_command="terraform apply "
		#echo -e $module_names'\c'
	done

	if [ "$final_00gtm" == "" ]
	then
		echo ""
	else
		echo -e $final_ssl_command_gtm
		echo $final_00gtm
	fi

	#echo ""
	#echo "In main:"


	if [ "$final_not_00gtm" == "" ]
        then
                echo ""
		#continue
        else

		echo -e $final_ssl_command
		echo $final_not_00gtm
	fi



	#echo "Upload SSL Command:"
	#echo $final_ssl_command$module_names
	echo ""	
}

input=$@
whether_input_exist $input
correct=$?

if [ "$correct" -eq "1" ]
then
	create_ssl_terraform_command $input 
else
	echo -e 'Input Error. Please enter again.'
	#echo -e '\nInput format:\n ./this_shell old_domain new_domain'
	#echo -e '\nExanple: \n ./hyper_icp_hima.sh klooo.site hima.com\n'
fi

