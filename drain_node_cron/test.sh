while read namespaces
do
#echo ${namespaces}
node_namespace="${namespaces}"
#done < <(cat namespaces_list)

#echo ${node_namespace}

if [ "$node_namespace" == "node-prod-vd006" ]
then
        echo hima
fi

if [ "$node_namespace" == "node-prod-vd004" ]; then
	echo ${node_namespace}
	#echo $node_namespace
        kube_config_name="tiger-vd004"

elif [ "${node_namespace}"=="node-prod-vd008" ]; then
        kube_config_name="tiger-prod-vd008"

elif [ "${node_namespace}"=="node-prod-pp001" ]; then
        kube_config_name="tiger-prod-vd008"

elif [ "${node_namespace}"=="node-prod-vd009" ]; then
        kube_config_name="tiger-prod-vd008"

elif [ "${node_namespace}"=="node-prod-vd006" ]; then
        kube_config_name="tiger-vd006"

elif [ "${node_namespace}" == "node-prod-vd007" ]; then
        kube_config_name="tiger-vd006"

elif [ "${node_namespace}"=="node-prod" ]; then
        kube_config_name="tiger-prod"

elif [ "${node_namespace}"=="node-prod-vd002" ]; then
        kube_config_name="tiger-prod"

elif [ "${node_namespace}"=="node-prod-vd003" ]; then
        kube_config_name="tiger-prod"

elif [ "${node_namespace}"=="node-uat" ]; then
        kube_config_name="tiger-uat"

else
        kube_config_name="ERROR"
fi

echo $kube_config_name
done < <(cat namespaces_list)

