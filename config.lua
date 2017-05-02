
local module = {}
dofile("gpio_defines.lua")
local function save_setting(name, value)
    file.open(name .. '.sav', 'w') -- you don't need to do file.remove if you use the 'w' method of writing
    file.writeline(value)
    file.close()
end

local function load_setting(name)
    if (file.open(name .. '.sav')~=nil) then
        result = string.sub(file.readline(), 1, -2) -- to remove newline character
        file.close()
        return true, result
    else
        return false, nil
    end
end

function read_setting_num(name)
    res, val = read_setting(name)
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

RELAY_1 = GPIO5
RELAY_2 = GPIO4
RELAY_3 = GPIO14
RELAY_4 = GPIO16

gpio.mode(RELAY_1, gpio.OUTPUT)
gpio.mode(RELAY_2, gpio.OUTPUT)
gpio.mode(RELAY_3, gpio.OUTPUT)
gpio.mode(RELAY_4, gpio.OUTPUT)

gpio.write(RELAY_1, 0)
gpio.write(RELAY_2, 0)
gpio.write(RELAY_3, 0)
gpio.write(RELAY_4, 0)


module.MOT_IN1 = GPIO4
module.MOT_IN2 = GPIO5
module.MOT_IN3 = GPIO15
module.MOT_IN4 = GPIO2

gpio.mode(module.MOT_IN1, gpio.OUTPUT)
gpio.mode(module.MOT_IN2, gpio.OUTPUT)
gpio.mode(module.MOT_IN3, gpio.OUTPUT)
gpio.mode(module.MOT_IN4, gpio.OUTPUT)

gpio.write(module.MOT_IN1, 0)
gpio.write(module.MOT_IN2, 0)
gpio.write(module.MOT_IN3, 0)
gpio.write(module.MOT_IN4, 0)




-- /////////////
-- DS_SDA_PIN = GPIO14
-- DS_SCL_PIN = GPIO12
-- DS_SQW_PIN = GPIO13

-- rtc
module.TIMEZONE = 3

-- WiFi
res, module.WIFI_SSID = load_setting('WIFI_SSID')
res, module.WIFI_PASS = load_setting('WIFI_PASS')

-- Alarms
module.WIFI_ALARM_ID = tmr.create()
module.WIFI_LED_BLINK_ALARM_ID = tmr.create()
module.WIFI_LED_CONNECTED_ALARM_ID = tmr.create()

-- MQTT
res, module.MQTT_CLIENTID = load_setting('MQTT_CLIENTID')
res, module.MQTT_HOST = load_setting('MQTT_HOST')
module.MQTT_PORT = 1883
module.MQTT_MAINTOPIC = "/devices/" .. module.MQTT_CLIENTID

-- Confirmation message
print("\nGlobal variables loaded...\n")

return module
