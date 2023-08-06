#!/usr/bin/env python
# coding: utf-8

# In[28]:


import json
import os
import sys
import logging
import time
import requests
from tencentcloud.common.exception.tencent_cloud_sdk_exception import TencentCloudSDKException
from tencentcloud.common.abstract_client import AbstractClient
from tencentcloud.billing.v20180709 import models, billing_client
from tencentcloud.common import credential
#from tencentcloud.cvm.v20170312 import cvm_client, models
#from tencentcloud.common.profile.client_profile import ClientProfile
#from tencentcloud.common.profile.http_profile import HttpProfile


try:
    # 实例化一个认证对象，入参需要传入腾讯云账户secretId，secretKey。
    # 为了保护密钥安全，建议将密钥设置在环境变量中或者配置文件中，请参考本文凭证管理章节。
    # 硬编码密钥到代码中有可能随代码泄露而暴露，有安全隐患，并不推荐。
    # cred = credential.Credential("secretId", "secretKey")
    """
    cred = credential.Credential(
        os.environ.get("TENCENTCLOUD_SECRET_ID"),
        os.environ.get("TENCENTCLOUD_SECRET_KEY"))
        
    """
    cred = credential.Credential("TENCENTCLOUD_SECRET_ID", "TENCENTCLOUD_SECRET_KEY")

    """
    # 实例化一个http选项，可选的，没有特殊需求可以跳过。
    httpProfile = HttpProfile()
    # 如果需要指定proxy访问接口，可以按照如下方式初始化hp
    # httpProfile = HttpProfile(proxy="http://用户名:密码@代理IP:代理端口")
    httpProfile.protocol = "https"  # 在外网互通的网络环境下支持http协议(默认是https协议),建议使用https协议
    httpProfile.keepAlive = True  # 状态保持，默认是False
    httpProfile.reqMethod = "GET"  # get请求(默认为post请求)
    httpProfile.reqTimeout = 30    # 请求超时时间，单位为秒(默认60秒)
    httpProfile.endpoint = "cvm.ap-shanghai.tencentcloudapi.com"  # 指定接入地域域名(默认就近接入)



    # 实例化一个client选项，可选的，没有特殊需求可以跳过。
    clientProfile = ClientProfile()
    clientProfile.signMethod = "TC3-HMAC-SHA256"  # 指定签名算法
    clientProfile.language = "en-US"  # 指定展示英文（默认为中文）
    clientProfile.httpProfile = httpProfile


    # 实例化要请求产品(以cvm为例)的client对象，clientProfile是可选的。
    client = cvm_client.CvmClient(cred, "ap-shanghai", clientProfile)
    """
    
    client = billing_client.BillingClient(cred, "")

    # 打印日志按照如下方式，也可以设置log_format，默认为 '%(asctime)s %(process)d %(filename)s L%(lineno)s %(levelname)s %(message)s'
    # client.set_stream_logger(stream=sys.stdout, level=logging.DEBUG)
    # client.set_file_logger(file_path="/log", level=logging.DEBUG) 日志文件滚动输出，最多10个文件，单个文件最大512MB
    # client.set_default_logger() 去除所有log handler，默认不输出


    # 实例化一个cvm实例信息查询请求对象,每个接口都会对应一个request对象。
    #req = models.DescribeInstancesRequest()
    
    req = models.DescribeAccountBalanceRequest()
        
    """
    # 填充请求参数,这里request对象的成员变量即对应接口的入参。
    # 你可以通过官网接口文档或跳转到request对象的定义处查看请求参数的定义。
    respFilter = models.Filter()  # 创建Filter对象, 以zone的维度来查询cvm实例。
    respFilter.Name = "zone"
    respFilter.Values = ["ap-shanghai-1", "ap-shanghai-2"]
    req.Filters = [respFilter]  # Filters 是成员为Filter对象的列表
    """


    # 通过client对象调用DescribeInstances方法发起请求。注意请求方法名与请求对象是对应的。
    # 返回的resp是一个DescribeInstancesResponse类的实例，与请求对象对应。
    resp = client.DescribeAccountBalance(req)


    # 输出json格式的字符串回包
    #print(resp.to_json_string(indent=2))


    # 也可以取出单个值。
    # 你可以通过官网接口文档或跳转到response对象的定义处查看返回字段的定义。
    #Balance_origin = list[resp.Balance]
    #result = Balance_origin.insert((len(str(resp.Balance)-2)), ".")
    result_str = str(resp.Balance) 
    str_list = list(result_str)
    str_list.insert((len(str_list)-2), '.')
    str_out = ''.join(str_list)
    #print(str_out)
    #print(resp.Balance)
    
    time_origin = time.localtime()
    time_origin = time.strftime("%Y/%m/%d %H:%M:%S", time_origin)
    
    print("目前 account_here 中國騰訊雲帳戶餘額: ", str_out)

    """
    msg_title = time.strftime("%Y/%m/%d") + ' account_here 中國騰訊雲帳戶餘額'
    #print("目前 account_here 中國騰訊雲帳戶餘額: ", str_out)
    msg = ""
    msg += '目前 account_here 中國騰訊雲帳戶餘額: ' + str_out
    """
except TencentCloudSDKException as err:
    print(err)





