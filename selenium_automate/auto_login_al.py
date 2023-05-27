import time
import pyautogui 
import requests, json
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver import ActionChains
from selenium.webdriver.support.wait import WebDriverWait 
from selenium.common.exceptions import NoSuchElementException


def auto_login_ali(account_id):
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--incognito") #隱私模式 無痕
    chrome_options.add_argument("--start-maximized")
    chrome_options.add_experimental_option('excludeSwitches', ['enable-automation'])
    chrome_options.add_argument('--disable-blink-features=AutomationControlled')

    chrome_options.add_argument('--no-sandbox') # 這個配置很重要

    driver = webdriver.Chrome("C:\\Users\\user\\Documents\\works\\chromedriver.exe",chrome_options=chrome_options)
    
    driver.set_page_load_timeout(66)
    
    driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument", {
        "source": """Object.defineProperty(navigator, 'webdriver', {get: () => undefined})""",
    })
    
    #driver.execute_cdp_cmd("Page.addScriptToEvaluateOnNewDocument", {
    #    "source": """Object.defineProperty(navigator, 'webdriver', {get: () => undefined})""",
    #})
    
    account_full = 'devops@' + account_id + '.onaliyun.com'
    #account example: devops@3-7.onaliyn.com

    driver.get('https://signin.aliyun.com/');

    time.sleep(1) 
    
    try:
        login_box = driver.find_element("id",'loginName')

        login_box.send_keys(account_full)

        time.sleep(1) 

        next_bottom = driver.find_element(By.XPATH,'/html/body/div[2]/div[1]/div[2]/div/div/div[1]/div[2]/div/div/div/div/div/form/div[5]/button')

        next_bottom.click()

        time.sleep(1)

        password_box = driver.find_element("name",'password')
        password_box.send_keys('Your_password_here')

        password_bottom = driver.find_element(By.XPATH,'/html/body/div[2]/div[1]/div[2]/div/div/div[1]/div[2]/div/div/div/div/div/form/div[5]/button')
        password_bottom.click()

        time.sleep(5)
    except:
        driver.quit()
        return False
    
    try:
        balance_path = driver.find_element(By.CLASS_NAME,'WidgetHomeBillingOverview-amount-388TE')
        balance_result = balance_path.text
        
        if "¥ 0.00" in balance_result:
            time.sleep(7)
            balance_path = driver.find_element(By.CLASS_NAME,'WidgetHomeBillingOverview-amount-388TE')
            balance_result = balance_path.text
        
        if "¥ 0.00" in balance_result:
            driver.quit()
            return False
        else:
            check_result = ""
            balance_result = balance_result.replace('¥ ', '')
            #check_result = account_id + " 餘額 " + balance_result
            check_result = balance_result + ' 元'
            #print(check_result)
            driver.quit()
            return(check_result)
            #check_result = ""
            #check_result = account_id + " 餘額 " + balance_result
            #print(check_result)
            #driver.quit()
            #return(check_result)

    #觸發滑塊    
    except NoSuchElementException:
        try:
            print('觸發滑塊驗證，開始模擬拖曳動作:')
            time.sleep(3)
            distance = 500
            
            #slider_bar = driver.find_element(By.XPATH,'/html/body/center/div[1]/div/div/div/span')
            #print(side_bar.location['x'],slider_bar.location['y'],slider_bar.size['width'],slider_bar.size['hgight'])
            
            #mouse_left = slider_bar.location['x']
            #mouse_right = slider_bar.location['x'] + (slider_bar.size['width']/2)
            #mouse_top = slider_bar.location['y']
            #mouse_bottom = slider_bar.location['y'] + (slider_bar.size['hgight']/2)
            

            #print(mouse_left,mouse_right,mouse_top,mouse_bottom)
            
            #pyautogui.moveTo(mouse_right, mouse_bottom)
            #pyautogui.dragTo(mouse_right + distance, mouse_bottom,3)
            pyautogui.moveTo(747, 522)
            pyautogui.dragTo(747 + distance, 522, 3)
            time.sleep(5)

            balance_path = driver.find_element(By.CLASS_NAME,'WidgetHomeBillingOverview-amount-388TE')
            balance_result = balance_path.text
            
            if "¥ 0.00" in balance_result:
                time.sleep(7)
                balance_path = driver.find_element(By.CLASS_NAME,'WidgetHomeBillingOverview-amount-388TE')
                balance_result = balance_path.text
                
            if "¥ 0.00" in balance_result:
                driver.quit()
                return False
            else:
                check_result = ""
                balance_result = balance_result.replace('¥ ', '')
                #check_result = account_id + " 餘額 " + balance_result
                check_result = balance_result + ' 元'
                #print(check_result)
                driver.quit()
                return(check_result)

        except:
            driver.quit()
            return False

        driver.quit()
        time.sleep(2)
    except:
        driver.quit()
        return False
    return(check_result)
    driver.quit()

    
def sent_message_to_alert_test(title, message):
    url = "Your_alert_server_address_here"
    data = {
        "title" : title,
        "msg" : message
    }
    response = requests.post(url, data=json.dumps(data))


msg = ""
msg_title = ""

flag_34 = flag_37 = flag_47 = flag_65 = flag_74 = flag_85 = flag_95 = flag_96 = 0
print('Copyright © 2023 Hima. All rights reserved.')

while flag_34 == 0:
    try:
        msg += '3-4' + auto_login_ali('3-4') + '\n'
        flag_34 = 1
        print('3-4 檢測完畢')
    except:
        pass
    
while flag_37 == 0:
    try:
        msg += '3-7' + auto_login_ali('3-7') + '\n'
        flag_37 = 1
        print('3-7 檢測完畢')
    except:
        pass
    
while flag_47 == 0:
    try:
        msg += '4-7' + auto_login_ali('4-7') + '\n'
        flag_47 = 1
        print('4-7 檢測完畢')
    except:
        pass    
    
while flag_65 == 0:
    try:
        msg += '6-5' + auto_login_ali('6-5') + '\n'
        flag_65 = 1
        print('6-5 檢測完畢')
    except:
        pass
    
while flag_74 == 0:
    try:
        msg += '7-4' + auto_login_ali('7-4') + '\n'
        flag_74 = 1
        print('7-4 檢測完畢')
    except:
        pass
    
while flag_85 == 0:
    try:
        msg += '8-5' + auto_login_ali('8-5') + '\n'
        flag_85 = 1
        print('8-5 檢測完畢')
    except:
        pass
    
while flag_95 == 0:
    try:
        msg += '9-5' + auto_login_ali('9-5') + '\n'
        flag_95 = 1
        print('9-5 檢測完畢')
    except:
        pass
    
while flag_96 == 0:
    try:
        msg += '9-6' + auto_login_ali('9-6') + '\n'
        flag_96 = 1
        print('9-6 檢測完畢')
    except:
        pass



time_origin = time.localtime()
time_origin = time.strftime("%Y/%m/%d %H:%M:%S", time_origin)


msg_title = time.strftime("%Y/%m/%d") + ' 阿里雲帳號餘額檢測'

#sent_message_to_alert_test(msg_title,msg)

print(msg)

print('\n')

print(time_origin)

print("全部帳號檢查完畢.")



