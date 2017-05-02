-- gp = {3,10,4,9,2,1,11,12,6,7,5,8,0}
gp = {3,4,2,1,6,7,5,8,0}

for key = 1, #gp do
	print('Testing ' .. key .. ':')
	gpio.mode(gp[key], gpio.OUTPUT)
	gpio.write(gp[key], 0)
	tmr.delay(1000000)
	gpio.write(gp[key], 1)
	tmr.delay(1000000)
	gpio.write(gp[key], 0)
	gpio.mode(gp[key], gpio.OPENDRAIN)
end
