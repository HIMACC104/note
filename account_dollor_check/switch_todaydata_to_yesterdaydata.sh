#!/bin/bash


function switch_todaydata_to_yesterdaydata()
{

        local workdir_path="$(pwd)"


        local today_data_path=$workdir_path"/today_data"


        local yesterday_data_path=$workdir_path"/yesterday_data"

	#local hima_test_path=$workdir_path"/hima_data"

	mv $today_data_path $yesterday_data_path


	echo ""
	echo "Switch Success."
	echo ""
}

switch_todaydata_to_yesterdaydata
