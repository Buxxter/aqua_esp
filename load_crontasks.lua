--on
function relay1_on( ... )
	gpio.write(config.RELAY_1, 1)
end

function relay2_on( ... )
	gpio.write(config.RELAY_2, 1)
end

function relay3_on( ... )
	gpio.write(config.RELAY_3, 1)
end

function relay4_on( ... )
	gpio.write(config.RELAY_4, 1)
end

-- off
function relay1_off( ... )
	gpio.write(config.RELAY_1, 0)
end

function relay2_off( ... )
	gpio.write(config.RELAY_2, 0)
end

function relay3_off( ... )
	gpio.write(config.RELAY_3, 0)
end

function relay4_off( ... )
	gpio.write(config.RELAY_4, 0)
end

-- help
function light_low( ... )
	relay2_on()
	relay3_off()
	-- mqttc.log("light low")
end

function light_med( ... )
	relay2_off()
	relay3_on()
	-- mqttc.log("light med")
end

function light_hi( ... )
	relay2_on()
	relay3_on()
	-- mqttc.log("light hi")
end

function light_off( ... )
	relay2_off()
	relay3_off()
	-- mqttc.log("light off")
end

function gas_on( ... )
	relay1_on()
	-- mqttc.log("gas on")
end

function gas_off( ... )
	relay1_off()
	-- mqttc.log("gas off")
end


function tick()
  -- mqttc.log("tick")
  print("tick")
end


-- load_lib("crontab")

--
-- 10:00	gas on
-- 10:30	light low
-- 11:30	light med
-- 12:00	light hi
-- 21:30	light med
-- 22:00	gas off
-- 22:30	light low
-- 00:00	light off
--

CRONTABLE = {}
crontab.add_or_update_task('gas_on', 	'*/5 10-21 * * *', gas_on, true)
crontab.add_or_update_task('light_low',	'30-55/5 10,22 * * *', light_low, true)
crontab.add_or_update_task('light_med',	'30-55/5 11,21 * * *', light_med, true)
crontab.add_or_update_task('light_hi',	'*/5 12-20 * * *', light_hi, true)
crontab.add_or_update_task('light_off',	'*/5 0-9 * * *', light_off, true)
crontab.add_or_update_task('gas_off', 	'*/5 22-9 * * *', gas_off, true)
-- crontab.add_or_update_task('tick', '* * * * *', tick, true)
