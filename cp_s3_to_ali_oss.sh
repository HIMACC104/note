#!bin/bash

for i in `cat applist`
    do
    if [[ `echo $i | grep apk` != "" ]];then
      appPath="android"
    else
      appPath="ios"
    fi
    aws s3 cp s3://your_s3_bucket_name_here/appdownload/$appPath/$i .
    ossutil cp $i oss://your_oss_bucket_name_here/appdownload/$appPath/
    rm -f $i
    done

