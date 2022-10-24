#!/bin/bash
PWD=`pwd`
SUCCESS_COUNT=0
SSL_TEMP="$(mktemp -dt SSL_TEMP-XXXXXX)"

unzip $PWD/$1 -d $PWD 1>/dev/null
unzip -l $PWD/$1 |grep zip |grep -v $1 |awk  -F '.' 'gsub(/.zip/," ",$0)' |awk '{print $4}'  > $SSL_TEMP/while_read.txt
#unzip -l $PWD/$1 | grep zip | awk  -F '.' 'gsub(/.zip/," ",$0)' > $SSL_TEMP/while_read.txt

CER_TOTAL=$(cat $SSL_TEMP/while_read.txt |wc -l)
#ls |grep zip |grep -v $1 |awk -F '.' '{print $1"."$2}' > while_read.txt

#刪除照片沒啥意義
#echo "unzip -l $1 |grep png |awk '{print $4}' |xargs rm -f"
unzip -l $PWD/$1 |grep image |awk '{print $4}' |xargs rm -f 

while read line; do
	mkdir $line ;
	mv $line*.txt $line/$line.key;
	mv $line"."zip $line/ ;
	find $PWD/$line/ |grep zip |grep -v $1 >> $SSL_TEMP/certificate_list.txt
done < $SSL_TEMP/while_read.txt


while read line; 
do 
	#echo $line
	LOCATION=`echo $line|awk -F '/' '{gsub(/[^\/]*$/,"");print}'`
	unzip $line -d $LOCATION 1>/dev/null
	#echo $LOCATION
	DOMAIN=`echo $LOCATION |sed 's/.$//' | awk -F "/" '{print $NF}'`
	KEY=`ls $LOCATION | grep "key"`
	GD=`ls $LOCATION*.crt | grep gd`
	NGD=`ls $LOCATION*.crt | grep -v gd`
	PEM=`ls $LOCATION |grep pem`
	KEY_CHECK=`ls $LOCATION | grep "key" | wc -l`
	GD_CHECK=`ls $LOCATION*.crt | grep gd | wc -l`
	NGD_CHECK=`ls $LOCATION*.crt | grep -v gd | wc -l`
	#LAST_CHECK=`echo $LOCATION |sed 's/.$//' | awk -F "/" '{print $NF}'`
	#echo "domain:$DOMAIN,key:$KEY,gd:$GD,ngd:$NGD,key_check:$KEY_CHECK,gd_check:$GD_CHECK,ngd_check:$NGD_CHECK,last_check:$LAST_CHECK"
	#################################################################################
	##Create SSL CRT and KEY                                                       ##
	#################################################################################
	if [[ $KEY_CHECK -eq 1 ]]&&[[ $GD_CHECK -eq 1 ]]&&[[ $NGD_CHECK -eq 1 ]]; then
	        cat "${NGD}" "${GD}" > "${LOCATION}"fullchain.crt
	        RSA_KEY=$(openssl rsa -noout -modulus -in "${LOCATION}""${DOMAIN}".key)
	        X509_CRT=$(openssl x509 -noout -modulus -in "${LOCATION}"fullchain.crt)
		if [ $RSA_KEY == $X509_CRT ]
		then
			SUCCESS_COUNT=$((SUCCESS_COUNT+1))
			echo -e "success SSL證書金鑰匹配正確"
		elif [ $RSA_KEY != $X509_CR ]
		then
			echo -e "金鑰匹配不正確請確認"
		fi
	else
	        echo -e "$line SSL證書金鑰匙數量不正確，請檢查資料夾" && exit 1
	fi
	
	
	#echo "rm $LOCATION${DOMAIN}.zip"
	rm $LOCATION${DOMAIN}.zip
	#echo "rm ${NGD}"
	rm ${NGD}
	#echo "rm ${GD}"
	rm ${GD}
	#echo "rm $LOCATION${PEM}"
	rm $LOCATION${PEM}
done < $SSL_TEMP/certificate_list.txt

echo "正確匹配數量$SUCCESS_COUNT /總證書數量 $CER_TOTAL"

rm -rf $SSL_TEMP
