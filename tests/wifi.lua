-- -- Print AP list that is easier to read
-- function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
--     print("\n\t\t\tSSID\t\t\t\t\tBSSID\t\t\t  RSSI\t\tAUTHMODE\t\tCHANNEL")
--     for bssid,v in pairs(t) do
--         local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
--         print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
--     end
-- end
-- wifi.sta.getap(1, listap)


-- print AP list in old format (format not defined)
function listap(t)
    for k,v in pairs(t) do
        print(k.." : "..v)
    end
end
wifi.sta.getap(listap)
