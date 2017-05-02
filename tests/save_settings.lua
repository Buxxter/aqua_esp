-- WiFi
function save_setting(name, value)
    file.open(name .. '.sav', 'w') -- you don't need to do file.remove if you use the 'w' method of writing
    file.writeline(value)
    file.close()
end


save_setting('WIFI_SSID', 'Manuna')
save_setting('WIFI_PASS', 'QWEdsa321!')
save_setting('MQTT_CLIENTID', 'aqua_esp')
save_setting('MQTT_HOST', '192.168.14.32')