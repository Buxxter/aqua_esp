
local module = {}

GPIO0   =   3
GPIO1   =   10
GPIO2   =   4
GPIO3   =   9
GPIO4   =   2
GPIO5   =   1
GPIO9   =   11
GPIO10  =   12
GPIO12  =   6
GPIO13  =   7
GPIO14  =   5
GPIO15  =   8
GPIO16  =   0

function module.save_setting(name, value)
    file.open(name .. '.sav', 'w') -- you don't need to do file.remove if you use the 'w' method of writing
    file.writeline(value)
    file.close()
end

function module.load_setting(name)
    if (file.open(name .. '.sav')~=nil) then
        result = string.sub(file.readline(), 1, -2) -- to remove newline character
        file.close()
        return true, result
    else
        return false, nil
    end
end

function module.read_setting_num(name)
    res, val = module.read_setting(name)
    return res, tonumber(val)
end

-- GPIOS
-- GPIO_LED = 7    -- GPIO13
-- GPIO_RELAY = 6 -- GPIO12
-- GPIO_EXT_RELAY = 7  -- same as green led
-- GPIO_BUTTON = 3 -- GPIO0
-- GPIO_DHT = 5    -- GPIO14

module.LED_STATUS = GPIO2
module.TELNET = false

module.SDA = GPIO0
module.SCL = GPIO12

-- RELAY_1 = GPIO5
-- RELAY_2 = GPIO4
-- RELAY_3 = GPIO14
-- RELAY_4 = GPIO16

module.RELAY_1 = GPIO5
module.RELAY_2 = GPIO4
module.RELAY_3 = GPIO14
module.RELAY_4 = GPIO16


module.RELAY_ONE = RELAY_1

gpio.mode(module.RELAY_1, gpio.OUTPUT)
gpio.mode(module.RELAY_2, gpio.OUTPUT)
gpio.mode(module.RELAY_3, gpio.OUTPUT)
gpio.mode(module.RELAY_4, gpio.OUTPUT)

gpio.write(module.RELAY_1, 0)
gpio.write(module.RELAY_2, 0)
gpio.write(module.RELAY_3, 0)
gpio.write(module.RELAY_4, 0)


--module.MOT_IN1 = GPIO4
--module.MOT_IN2 = GPIO5
--module.MOT_IN3 = GPIO15
--module.MOT_IN4 = GPIO2
--
--gpio.mode(module.MOT_IN1, gpio.OUTPUT)
--gpio.mode(module.MOT_IN2, gpio.OUTPUT)
--gpio.mode(module.MOT_IN3, gpio.OUTPUT)
--gpio.mode(module.MOT_IN4, gpio.OUTPUT)

--gpio.write(module.MOT_IN1, 0)
--gpio.write(module.MOT_IN2, 0)
--gpio.write(module.MOT_IN3, 0)
--gpio.write(module.MOT_IN4, 0)




-- /////////////
-- DS_SDA_PIN = GPIO14
-- DS_SCL_PIN = GPIO12
-- DS_SQW_PIN = GPIO13

-- rtc
module.TIMEZONE = 3

-- WiFi
res, module.WIFI_SSID = module.load_setting('WIFI_SSID')
if not res then module.WIFI_SSID = 'Manuna' end
res, module.WIFI_PASS = module.load_setting('WIFI_PASS')

-- Alarms
module.WIFI_ALARM_ID = tmr.create()
module.WIFI_LED_BLINK_ALARM_ID = tmr.create()
module.WIFI_LED_CONNECTED_ALARM_ID = tmr.create()

-- MQTT
res, module.MQTT_CLIENTID = module.load_setting('MQTT_CLIENTID')
if not res then 
    module.MQTT_CLIENTID = 'aqua_esp'
    if wifi.sta.getmac() ~= "5c:cf:7f:81:d2:bf" then
        module.MQTT_CLIENTID = module.MQTT_CLIENTID .. '/' .. wifi.sta.getmac()
    end
end

res, module.MQTT_HOST = module.load_setting('MQTT_HOST')
if not res then module.MQTT_HOST = '192.168.14.32' end
module.MQTT_PORT = 1883
module.MQTT_MAINTOPIC = "/devices/" .. module.MQTT_CLIENTID

-- Confirmation message
print("\nGlobal variables loaded...\n")

return module
