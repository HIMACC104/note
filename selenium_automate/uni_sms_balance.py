import time
import ddddocr
import requests, json
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver import ActionChains
from selenium.webdriver.support.wait import WebDriverWait 
import pyautogui
from PIL import Image

def get_capture(driver):

    capture_picture = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[3]/div/div/img')

    time.sleep(1)

    driver.save_screenshot('test.jpg')

    left = capture_picture.location['x']

    right = capture_picture.location['x'] + capture_picture.size['width']

    top = capture_picture.location['y']

    bottom = capture_picture.location['y'] + capture_picture.size['height']
    img = Image.open('test.jpg')
    img = img.crop((left, top, right, bottom))
    img = img.convert("RGB")
    img.save("catpure.jpg")

    ocr = ddddocr.DdddOcr()

    with open('catpure.jpg', 'rb') as f:
        image = f.read()


    #驗證碼
    res = ocr.classification(image)
    #print("The capture ans is: ", res)
    return res

def login_unisms(account, password):

    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--incognito") #隱私模式 無痕
    chrome_options.add_argument("--start-maximized")
    chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
    chrome_options.add_argument('--disable-blink-features=AutomationControlled')
    chrome_options.add_argument("--disable-component-update")
    chrome_options.add_argument('--no-sandbox') # 這個配置很重要

    driver = webdriver.Chrome("C:\\Users\\user\\Documents\\works\\chromedriver.exe",chrome_options=chrome_options)

    driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument", {
        "source": """Object.defineProperty(navigator, 'webdriver', {get: () => undefined})""",
    })

    driver.get('https://unisms.apistd.com/signin/');

    account_block = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[1]/div/input')
    account_block.click()
    account_block.send_keys(account)

    password_block = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[2]/div/input')
    password_block.click()
    password_block.send_keys(password)

    capture_block = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[3]/div/div/input')
    capture_block.click()
    #驗證碼
    res = get_capture(driver)
    capture_block.send_keys(res)

    login_bottom = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[5]/div/button')
    login_bottom.click()

    capture_picture = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[3]/div/div/img')
    capture_picture.click()

    time.sleep(1)


    #驗證碼
    res = get_capture(driver)
    capture_block = driver.find_element(By.XPATH,'/html/body/div[1]/div/main/section/div/div/div[2]/form/div[3]/div/div/input')
    capture_block.click()
    capture_block.clear()
    capture_block.send_keys(res)

    login_bottom.click()

    time.sleep(3)

    okane_front = driver.find_element(By.XPATH,'/html/body/div[1]/div/div[2]/div[2]/div[2]/div[3]/div/div/div[2]/div/span')
    okane_back = driver.find_element(By.XPATH,'/html/body/div[1]/div/div[2]/div[2]/div[2]/div[3]/div/div/div[2]/div/small[2]')
    okane_front_not_space = okane_front.text
    okane_front_not_space = okane_front_not_space.replace(' ', '')
    okane_back_not_space = okane_back.text
    okane_back_not_space = okane_back_not_space.replace(' ', '')

    result = ""
    result = okane_front_not_space + okane_back_not_space + '\n'
    time.sleep(3)
    driver.quit()
    return result
    
    
def sent_message_to_alert_test(title, message):
    url = "Your_alert_server_here"
    data = {
        "title" : title,
        "msg" : message
    }
    response = requests.post(url, data=json.dumps(data))

    
    
msg = ""
msg_title = ""

flag_vd002 = 0
flag_vd003 = 0
flag_vd006 = 0
flag_vd007 = 0
flag_vd008 = 0
flag_vd009 = 0
    
print('Copyright © 2023 Hima. All rights reserved.')

while flag_vd002 == 0:
    try:
        msg += '2 Unisms\n' + '\n餘額： ' + login_unisms('2_account', '2_password') + '\n'
        flag_vd002 = 1
        print('2 檢測完畢')
    except:
        flag_vd002 = 0
        
while flag_vd003 == 0:
    try:
        msg += '3 Unisms\n' + '\n餘額： ' + login_unisms('3_account', '3_password') + '\n'
        flag_vd003 = 1
        print('3 檢測完畢')
    except:
        flag_vd003 = 0
        
while flag_vd006 == 0:
    try:
        msg += '6 Unisms\n' + '\n餘額： ' + login_unisms('6_account', '6_password') + '\n'
        flag_vd006 = 1
        print('6 檢測完畢')
    except:
        flag_vd006 = 0

while flag_vd007 == 0:
    try:
        msg += '7 Unisms\n' + '\n餘額： ' + login_unisms('7_account', '7_password') + '\n'
        flag_vd007 = 1
        print('7 檢測完畢')
    except:
        flag_vd007 = 0

while flag_vd008 == 0:
    try:
        msg += '8 Unisms\n' + '\n餘額： ' + login_unisms('8_account', '8_password') + '\n'
        flag_vd008 = 1
        print('8 檢測完畢')
    except:
        flag_vd008 = 0
        
while flag_vd009 == 0:
    try:
        msg += '9 Unisms\n' + '\n餘額： ' + login_unisms('9_account', '9_password') + '\n'
        flag_vd009 = 1
        print('9 檢測完畢\n')
    except:
        flag_vd009 = 0

time_origin = time.localtime()
time_origin = time.strftime("%Y/%m/%d %H:%M:%S", time_origin)


msg_title = time.strftime("%Y/%m/%d") + ' UniSms帳號餘額檢測'

print(time_origin)
print('\n')
#print(msg)
sent_message_to_alert_test(msg_title,msg)
print('\n')




