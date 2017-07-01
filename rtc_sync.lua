local module = {}

local function _success()
	print("RTC: " .. module.get_formatted_time_string())
end

local function _fail()
	print('Time sync error')
end

function module.sync()
	sntp.sync('192.168.14.1', _success, _fail, true)
end

function module.get_formatted_time_string(tm)
	if tm == nil then
		tm = rtctime.epoch2cal(rtctime.get() + config.TIMEZONE * 3600)
	end
	return string.format("%04d-%02d-%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
end

return module
