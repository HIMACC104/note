vendor_id = []
#check_flag = []
uni_account = []
uni_password = []
count = 0
msg_to_robot = ""

account_txt_path = 'unisms_account.txt'

#txt file
#vendor_id account password
#ex:
#vd005 1523489416 66542133

with open(account_txt_path) as f:
    for line in f.readlines():
        if line != '\n':#濾空白行
            s = line.split(' ')
            s[0] = s[0].replace('\n', "")
            s[1] = s[1].replace('\n', "")
            s[2] = s[2].replace('\n', "")#濾換行符號
            #check_flag.append(s[0])

            vendor_id.append(s[0])
            uni_account.append(s[1])
            uni_password.append(s[2])
        else:
            pass


while count < len(vendor_id):
    print(vendor_id[count], uni_account[count], uni_password[count])
    msg_to_robot += 'PROD-' + str(vendor_id[count]) + ' Unisms\n帳號： ' + str(uni_account[count]) + '\n餘額： \n'
    #print(vendor_id[count], end = '')
    #print(' 檢測完畢')
    count+=1
    
#msg += 'PROD-vd006 Unisms\n' + '帳號： 13054464612313\n餘額： '
#msg1 += 'PROD-' + str(vendor_id[0]) + ' Unisms\n帳號： ' + str(uni_account[0]) + '\n餘額： ' 



print(msg_to_robot)
#print('msg1 value is:\n', msg1)
#print(vendor_id[0], end = '')
#print(' 檢測完畢')
