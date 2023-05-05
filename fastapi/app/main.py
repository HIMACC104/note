from typing import Optional

from fastapi import FastAPI

import os

import subprocess

#import urllib.request

import requests, json
#from flask import jsonify

#import json

app = FastAPI() # 建立一個 Fast API application

#cd_command = 'cd /opt/terraform'
#subprocess.call(cd_command,shell=True)

@app.get("/") # 指定 api 路徑 (get方法)
def read_root():
    return {"Hello": "World"}

@app.get("/reboot")
def restart_container():  
    command = "ooo"
    return {"Not complete function": command}
@app.get("/users/{user_id}") # 指定 api 路徑 (get方法)
def read_user(user_id: int, q: Optional[str] = None):
    return {"user_id": user_id, "q": q}

@app.get("/status/{service_name}")
def show_status(service_name: str, q:Optional[str] = None):
    return {"service_name": service_name, "status": q}

@app.get("/update_ssl/{domain_name}")
def execute_update_ssl_shell(domain_name: str):
    #command_half = 'bash /opt/terrraform/daily_update_ssl.sh '
    command = 'cd /opt/terraform && bash /opt/terraform/daily_update_ssl_for_fastapi.sh ' + domain_name
    #result = os.system(command)



    result = subprocess.run(command, shell=True, stdout=subprocess.PIPE)
    #print(result)
    result_str = result.stdout
    #print(result_str)
    result_str = str(result_str.decode().replace("\n",""))
    #result_str = str(result_str.replace("\n",""))


    gtm_flag = 0
    main_flag = 0
    if "In 00.gtm" in result_str:
        gtm_flag = 1
        #result_str = result_str.replace("In 00.gtm: ","")

        #result_json = {
        #    "Path" : "In 00.gtm",
        #    "Command" : result_str
        #}
    if "In main" in result_str:
        main_flag = 1



    print("gtm_flag",gtm_flag)
    print("main_flag",main_flag)


    if gtm_flag == 1 and main_flag == 1:

        result_str = result_str.replace("In 00.gtm: ","")
        result_str = result_str.split("In main: ", 1)

        #print(result_str)

        result_json = {
                "Path_gtm" : "In 00.gtm",
                "Command_gtm" : result_str[0],
                "Path_main" : "In main",
                "Command_main" : result_str[1]
                }
    elif gtm_flag == 1 and main_flag == 0:
        result_str = result_str.replace("In 00.gtm: ","")
        result_json = {
                "Path_gtm" : "In 00.gtm",
                "Command_gtm" : result_str
                }
    elif gtm_flag == 0 and main_flag == 1:
        result_str = result_str.replace("In main: ","")
        #print(result_str)
        domain_name_front = domain_name.split(".", 1)
        if domain_name_front[1] in result_str:
            result_json = {
                    "Path_main" : "In main",
                    "Command_main" : result_str
                    }
        else:
            result_json = {
                "Error" : "Input error. Please check again."
                }

    else:
        result_json = {
                "Error" : "Input error. Please check again."
                }



    return (result_json)
    #return (json.dumps(result_json))
    #return jsonify({"command": str(result.stdout)})

@app.get("/alert_test/{data_from_user}")
def send_data_to_alert_test_server(data_from_user: str):
    url = "http://alert-server.hinno.site/normal/alert-test"
    title = 'Data from Hima local api'
    message = data_from_user
    data = {
        "title" : title,
        "msg" : message
    }
    response = requests.post(url, data=json.dumps(data))

    return {"status code: ": response.status_code}
