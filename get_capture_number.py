import time
#import pyautogui 
import ddddocr
import os


ocr = ddddocr.DdddOcr()

#print(os.path.abspath)

print(os.path.abspath("下載.png"))

print(os.path.dirname((os.path.abspath("下載.png"))))

all_file = os.listdir(os.path.dirname((os.path.abspath("下載.png"))))

print(len(all_file))

i=0

for x in all_file:
    print(all_file[i])
    i += 1
#os.chdir(os.path.abspath("下載.png"))

with open("下載.png", 'rb') as f:
    image = f.read()

res = ocr.classification(image)

ocr_result = res.split('\n')
#print(res)
#print(ocr_result)

print("The capture ans is: ", res)
