#!/bin/bash

#kubectl get pod -n node-uat -o wide | grep crypto | awk '{print $7}' | xargs -I {} kubectl get node {} -o json | jq -r '.status.conditions'

#unit namespace
node_list_crypto=$(kubectl get pod -n node-prod-vd004 -o wide | grep crypto | awk '{print $7}')

#all_nampspace
#node_list_diskpress=$(kubectl get pod --all-namespaces -o wide | grep crypto | awk '{print $8}')
#sed -i 's/ /\n/g' < < (echo $node_list_diskpress)

#echo $node_list_diskpress

node_list_crypto_line=$(echo $node_list_crypto | tr " " "\n")

#echo $node_list_diskpress_line


for node in $node_list_crypto_line
do
	command_k8s=`kubectl get node $node -o json | jq -r '.status.conditions'|grep KubeletHasDiskPressure`
	#is_DiskPressure=${command_k8s}
	is_DiskPressure=$command_k8s
	#echo $is_DiskPressure
	#echo $node

	if [ "${is_DiskPressure}" != "" ]; then
		#echo $node

	fi
	#echo $node
done

#while read node_list
#do
#	echo hi
#	echo $node_list
#	echo ma
#done < <(echo $node_list_diskpress_line)
