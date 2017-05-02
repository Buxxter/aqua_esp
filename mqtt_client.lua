local module = {}
m = nil

function module.log(message)
	if m == nil then
		return
	end

	local tm = rtctime.epoch2cal(rtctime.get() + config.TIMEZONE * 3600)
	local str_msg = string.format("%04d-%02d-%02d %02d:%02d:%02d: ", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]) .. message
	m:publish(config.MQTT_MAINTOPIC .. "/log", str_msg, 0, 0)
    print(str_msg)
end

-- Sends a simple ping to the broker
local function send_ping()  
    m:publish(config.MQTT_MAINTOPIC .. "ping","id=" .. config.ID,0,0)
end

-- Sends my id to the broker for registration
local function register_myself()  
    m:subscribe(config.MQTT_MAINTOPIC, 0, function(conn)
        print("MQTT subscribed: " .. config.MQTT_MAINTOPIC)
    end)
end

local function mqtt_start()  
    m = mqtt.Client(config.MQTT_CLIENTID, 120)
    -- register message callback beforehand
    m:on("message", function(conn, topic, data) 
      if data ~= nil then
        print("MQTT:" .. topic .. ": " .. data)
        -- do something, we have received a message
      end
    end)
    -- Connect to broker
    m:connect(config.MQTT_HOST, config.MQTT_PORT, 0, 1, function(con) 
        register_myself()
        -- And then pings each 1000 milliseconds
        -- tmr.stop(6)
        -- tmr.alarm(6, 1000, 1, send_ping)
    end) 
end

function module.start()
	mqtt_start()
end

return module
