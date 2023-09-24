#!/usr/bin/env python3
import os


#引用程式的名字(現在會是python_os.py)
print(__file__)
print(os.path.dirname(__file__))
print(os.path.abspath(__file__))
print(os.path.abspath(os.path.dirname(__file__)))
print(os.path.dirname(os.path.abspath(__file__)))

#執行程式時所在位置
print(os.getcwd())



file_path = __file__
cwd_path = os.getcwd()

#會因為執行地方不同回傳不同路徑
print(file_path.split(cwd_path))


print(os.path.abspath(os.path.dirname(__file__)))



absFilePath = os.path.abspath(__file__)
path, filename = os.path.split(absFilePath)

print("\nabsFilePath: ", absFilePath)
print("Dir_Path: ", path,"\nFile_name: ", filename)


print(os.path.isdir(path))
print(os.path.isfile(path))
print(os.path.isfile(absFilePath))
