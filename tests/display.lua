config = require("config")
lcd = require("i2clcdpcf")

lcd.begin(config.SDA, config.SCL)
lcd.setBacklight(1)
lcd.print("hello youtube")
lcd.setCursor(5,1)
lcd.print("Hi")
