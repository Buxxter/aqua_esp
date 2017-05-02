function switch_all_relays(val)
	gpio.write(RELAY_1, val)
	gpio.write(RELAY_2, val)
	gpio.write(RELAY_3, val)
	gpio.write(RELAY_4, val)
end