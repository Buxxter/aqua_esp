local module = {}

function module.get_cron_table( ... )
	if crontab == nil then return nil end


	local tasklist = crontab.tasks()
	local result = "<table bordercolor=\"black\" border=2>\r\n<caption>crontab</caption>\r\n"
	result = result .. "<tr><th>Name</th><th>Mask</th><th>Enabled</th><th>Last run</th></tr>\r\n"
	for i = 1, #tasklist do
		result = result .. string.format("<tr> <td>%s</td> <td>%s</td> <td>%s</td> <td>%s</td> </tr>\r\n", tasklist[i][1], tasklist[i][2], tasklist[i][3], tasklist[i][4] == nil and "" or tasklist[i][4])
	end
	result = result .. "</table>"

	return result
end

return module