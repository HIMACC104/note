#!/bin/bash

#PID=$!
#echo "PID is $PID"


#sleep 2

timeout 3 wscat -c "wss://tradingplatform-v2-api.bigdatainn-uat.site/ws" 

#PID="$(jobs -l | awk '{print $2}')"

#kill -9 $PID
#echo $PID
