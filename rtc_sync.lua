local module = {}

local function _success()
	tm = rtctime.epoch2cal(rtctime.get())
	print(string.format("RTC: %04d-%02d-%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
end

local function _fail()
	print('Time sync error')
end

function module.sync()
	sntp.sync('192.168.14.1', _success, _fail, true)
end

return module
