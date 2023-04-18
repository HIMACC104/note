#!/bin/bash


source /etc/profile

export workdir="/home/hima/hima_shell/monitor_wss"


timeout 5 bash $workdir/main.sh > $workdir/onetime_result 

#echo "onetime_result:"
#cat $workdir/onetime_result


#connect_or_not=`cat $workdir/onetime_result|grep -a 'sessionID'`

#command_grep_id="cat $workdir/onetime_result|grep -a 'sessionID'"

#connect_or_not=${command_grep_id}

connect_or_not=$(cat -v "$workdir"/onetime_result|grep -a 'sessionID' 2>/dev/null)

#echo "uuid:" 
#echo -e $connect_or_not


connect_or_not="$connect_or_not"

echo "${connect_or_not:8}" > $workdir/onetime_result


#cat $workdir/onetime2_result > onetime_result

#grep_uuid_command="cat $workdir/onetime_result"

success_or_not=$(cat "$workdir"/onetime_result)
#success_or_not=$(${grep_uuid_command})

#echo $success_or_not


if [ "$success_or_not" != "" ]
then
	echo "Success. $(date +'%Y/%m/%d %H:%M:%S %Z')" >> $workdir/result
else
	echo "Failed. $(date +'%Y/%m/%d %H:%M:%S %Z')" >> $workdir/result
fi

#rm -f $workdir/onetime_result
#PID=$!

#echo "monitor_wss.sh PID is $PID"

#sleep 5

#kill $PID
