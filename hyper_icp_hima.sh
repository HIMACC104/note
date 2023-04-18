#!/bin/bash
#Write by Hima

function whether_input_correct()
{
  old_domain=$1
  new_domain=$2
  correct=1

  if [ -z "$1" ]||[ -z "$2" ]
  then
        #echo "Helle??? r u kidding me???????"
	correct=0
  fi

  return "$correct"
}

function make_need_files()
{
	old_domain=$1
        new_domain=$2
	
	old_tfvars_path=$(find ./ -name *$1.tfvars)
	old_tfstate_path=$(find ./ -name *$1.tfstate)
	old_ssl_tf_path=$(find ./ -name *$1.tf)
	
	new_tfvars_path=$(echo $old_tfvars_path|sed 's/'"$old_domain"'/'"$new_domain"'/')
	new_tfstate_path=$(echo $old_tfstate_path|sed 's/'"$old_domain"'/'"$new_domain"'/')
	new_ssl_tf_path=$(echo $old_ssl_tf_path|sed 's/'"$old_domain"'/'"$new_domain"'/')

	echo ""
	echo "New files path:"
	echo $new_tfvars_path
	echo $new_tfstate_path
	echo $new_ssl_tf_path
	echo ""
	old_domain_front=$(echo $old_domain | awk -F '.' '{print $1}')
	old_domain_back=$(echo $old_domain | awk -F '.' '{print $2}')
	new_domain_front=$(echo $new_domain | awk -F '.' '{print $1}')
	new_domain_back=$(echo $new_domain | awk -F '.' '{print $2}')

	cp $old_tfvars_path $new_tfvars_path
	touch $new_tfstate_path
	cp $old_ssl_tf_path $new_ssl_tf_path
	sed -i 's/'"$old_domain"'/'"$new_domain"'/g' $new_tfvars_path
	sed -i 's/'"$old_domain_front"'/'"$new_domain_front"'/g' $new_ssl_tf_path
	sed -i 's/'"$old_domain_back"'/'"$new_domain_back"'/g' $new_ssl_tf_path

	module_names=$(cat $new_ssl_tf_path | grep 'module ' | awk -F '"' '{print $2}'|grep -v cdnetworks|xargs -I {} echo -e "--target=module.{}")
	final_ssl_command="terraform apply "
	echo "Upload SSL Command:"
	echo $final_ssl_command$module_names
	echo ""	


	command_create_icp_var_file_name=$(echo $new_tfvars_path|awk -F "/" '{print $NF}')
	command_create_icp_state_file_name=$(echo $new_tfstate_path|awk -F "/" '{print $NF}')
	echo "Create ICP Command:"
	#echo "cd "
	echo "terraform apply -var-file=\"vars/$command_create_icp_var_file_name\" -state=\"states/$command_create_icp_state_file_name\" -parallelism=3"
	echo ""

}

old_domain=$1
new_domain=$2
whether_input_correct $old_domain $new_domain
#correct=$(whether_input_correct $old_domain $new_domain)
correct=$?

if [ "$correct" -eq "1" ]
then
        #echo 'Input Correct.'
	make_need_files $old_domain $new_domain
else
	echo -e '\nInput Error. Please enter again.'
	echo -e '\nInput format:\n ./this_shell old_domain new_domain'
	echo -e '\nExanple: \n ./hyper_icp_hima.sh klooo.site hima.com\n'
fi

