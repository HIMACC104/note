#!/bin/bash

#Made By Hima 2023/9/2


#echo ${namespaces}




#node_namespace=${namespaces}

vendor_input=$@
#done < <(cat namespaces_list)

echo ${vendor_input}

export PATH=/home/hima/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/home/hima/bin
source /etc/profile

echo ""
date +'%Y/%m/%d %H:%M:%S %Z'

#if [ "${node_namespace}"=="" ]
#then
#               echo hima
#fi
for vendor in $vendor_input
do
    if [ "${vendor}" == "vd004" ]; then
            kube_config_name="tiger-vd004"
            node_namespace="node-prod-vd004"
    elif [ "${vendor}" == "vd008" ]; then
            kube_config_name="tiger-prod-vd008"
            node_namespace="node-prod-vd008"
    elif [ "${vendor}" == "pp001" ]; then
            kube_config_name="tiger-prod-vd008"
            node_namespace="node-prod-pp001"
    elif [ "${vendor}" == "vd009" ]; then
            kube_config_name="tiger-prod-vd008"
            node_namespace="node-prod-vd009"
    elif [ "${vendor}" == "vd006" ]; then
            kube_config_name="tiger-vd006"
            node_namespace="node-prod-vd006"
    elif [ "${vendor}" == "vd007" ]; then
            kube_config_name="tiger-vd006"
            node_namespace="node-prod-vd007"
    elif [ "${vendor}" == "prod" ]; then
            kube_config_name="tiger-prod"
            node_namespace="node-prod"
    elif [ "${vendor}" == "vd002" ]; then
            kube_config_name="tiger-prod"
            node_namespace="node-prod-vd002"
    elif [ "${vendor}" == "vd003" ]; then
            kube_config_name="tiger-prod"
            node_namespace="node-prod-vd003"
    elif [ "${vendor}" == "uat" ]; then
            kube_config_name="tiger-uat"
            node_namespace="node-uat"
    else
            kube_config_name="ERROR"
    fi

    echo $kube_config_name

    kubectl config use-context $kube_config_name

    echo ${node_namespace}
    kube_command=$(echo "kubectl get pod -n $node_namespace")

    #drain node 當那台node上有pod狀態為ERROR
    kubectl get pod -n ${node_namespace} | grep Error | awk '{print $1}' | xargs -I {} kubectl get pod -n ${node_namespace} -o wide {} | awk '{print $7}'|grep compute > target_${node_namespace}

    #drain node 當那台node上有pod狀態為ContainerStatusUnknown
    kubectl get pod -n ${node_namespace} | grep ContainerStatusUnknown | awk '{print $1}' | xargs -I {} kubectl get pod -n ${node_namespace} -o wide {} | awk '{print $7}'|grep compute >> target_${node_namespace}

    #drain node 當那台node上有狀態KubeletHasDiskPressure為true
    while read target_node_name
    do
            kubectl drain --ignore-daemonsets --delete-emptydir-data ${target_node_name}
            #echo 1
    done < <(cat target_${node_namespace})
done

echo "Drain Nodes done."


