from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
import time

def test_login():
    chrome_options = Options()
    chrome_options.add_argument("--headless")  # Run in headless mode
    chrome_options.add_argument("--no-sandbox")  # Required for CI
    chrome_options.add_argument("--disable-dev-shm-usage")  # Overcome limited resource issues

    driver = webdriver.Chrome(options=chrome_options)

    try:
        driver.get("https://the-internet.herokuapp.com/login")
        
        email_input = driver.find_element(By.NAME, "username")
        email_input.send_keys("username")
        
        password_input = driver.find_element(By.NAME, "password")
        password_input.send_keys("password")
        
        login_button = driver.find_element(By.CSS_SELECTOR, "button[type='submit']")
        login_button.click()
        
        time.sleep(3)
        
        assert "Welcome" in driver.page_source
        
        print("Login test passed")
    
    except Exception as e:
        print(f"Login test failed: {e}")
    
    finally:
        driver.quit()

if __name__ == "__main__":
    test_login()
