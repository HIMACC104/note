#!/bin/bash
#Writed by HIMA
#2023/2/13



function check_account_dollor()
{

	local workdir_path="$(pwd)"
	

	local today_data_path=$workdir_path"/today_data"
	
	if [ -f $today_data_path ]
        then
                rm -f *today_data

        fi

	local yesterday_data_path=$workdir_path"/yesterday_data"
	local devops_cronjob_data_path=$workdir_path"/devops_cronjob_data"

	

	if [ ! -f "$yesterday_data_path" ] || [ ! -f "$devops_cronjob_data_path" ]
	then
		echo ""
		echo "Please make sure two file exist in this dir:"
		echo "yesterday_data --- data from ops group"
		echo "devops_cronjob_data --- data from deveops_cronjob"
		echo ""
		exit
	fi

	#cat $workdir_path/yesterday_data
	#yesterday="$(head -1 $workdir_path/yesterday_data)"

	this_month="$(date +%m/)"
	today_date="$(date +%d)"
	yesterday_date=$(expr $today_date - 1)
	#yesterday_date=$(expr $yesterday_date + 1)
	#echo $yesterday_date
	if [ $yesterday_date -lt 10 ]
	then
		yesterday_date="0$yesterday_date"

	fi
	
	#echo $yesterday_date
	yesterday=$this_month$yesterday_date
	today=$this_month$today_date
	##echo -e $yesterday >> $workdir_path/today_data
	#yesterday_date="$(echo $yesterday | awk -F  "/" '{print $2}')"
	#this_month="$(echo $yesterday | awk -F  "$yesterday_date" '{print $1}')"
	#today_date=`expr $yesterday_date + 1`
	#today=$this_month$today_date


	function divide_data_by_vendor()
	{
		total_grep_from_yesterday_data=$(cat $workdir_path/yesterday_data | grep $1|wc -l)
		start_line_float="$(expr $total_grep_from_yesterday_data / 2)"
		start_line="$(echo $start_line_float | awk '{printf("%d\n",$1)}')"
		start_line="$(expr $start_line + 1)"
		#echo $start_line
		echo -e $yesterday >> $workdir_path/today_data
		cat $workdir_path/yesterday_data | grep $1 | sed -n "$start_line,$total_grep_from_yesterday_data p" >> $workdir_path/today_data
		echo $today >> $workdir_path/today_data
		cat $workdir_path/devops_cronjob_data | grep $1 >> $workdir_path/today_data
		echo "" >> $workdir_path/today_data
	}

	divide_data_by_vendor "978" 
	divide_data_by_vendor "9393" 
	divide_data_by_vendor "678" 
	divide_data_by_vendor "6686" 
	divide_data_by_vendor "didi" 
	divide_data_by_vendor "8868" 
	divide_data_by_vendor "zbo" 
	divide_data_by_vendor "1717" 
	divide_data_by_vendor "6566"

	echo ""
	echo "Done. Please check today_data"
	echo ""
	echo "https://signin.aliyun.com/vd003-4.onaliyun.com/login.htm"
        echo ""	
	echo "3-4 hydgei02"
	echo "3-7 jiwhsw"
	echo "4-7 hiwsqo"
	echo "6-5 hsuydeo"
	echo "7-4 hesaow01"
	echo "8-5 htdsiw"
	echo "9-5 hudiwos"
	echo "9-6 hsiwjde"
}

check_account_dollor

