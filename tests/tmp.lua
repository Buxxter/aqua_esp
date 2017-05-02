DELAY_IMPULSE_US = 200
DELAY_COIL_MS = 1

config = require("config")

function mot_stop()
	gpio.write(config.MOT_IN1, 0)
	gpio.write(config.MOT_IN2, 0)
	gpio.write(config.MOT_IN3, 0)
	gpio.write(config.MOT_IN4, 0)
end

function impulse(port)
	gpio.write(port, 1)
	tmr.delay(DELAY_IMPULSE_US)
	gpio.write(port, 0)
	tmr.delay(DELAY_COIL_MS * 1000)
end

function turn(count, right)
	for i = 1, count do
		if right then
			impulse(config.MOT_IN1) -- 4
			impulse(config.MOT_IN3) -- 17
			impulse(config.MOT_IN2) -- 27
			impulse(config.MOT_IN4) -- 22
		else
			impulse(config.MOT_IN4) -- 22
			impulse(config.MOT_IN2) -- 27
			impulse(config.MOT_IN3) -- 17
			impulse(config.MOT_IN1) -- 4
		end
		-- tmr.delay(1000000)
	end
	mot_stop()
	print('done')
end

turn(50, true)
turn(50, false)



