function exec_template(fname)
    file.open(fname, "r")
    local txt = {}

    while true do
        ln = file.readline()
        if (ln == nil) then break end

        for w in string.gmatch(ln, "{{$[^}]+}}") do
            f = loadstring("return ".. string.sub(w,4,-3))
            local nw = string.gsub(w, "[^%w%s]", "%%%1")
            print("nw = " .. nw)
            print("string.gsub( " .. ln .. ", " .. nw .. "")
            ln = string.gsub(ln, nw, f())
            print("ok\r\n")

        end

        txt[#txt+1] = ln
    end
    file.close()
--    return table.concat(txt, "")
    return txt
end

function load_file(fname, ftxt, cmpl)
    file.remove(fname)
    file.open(fname, "w")
    file.write(ftxt)
    file.flush()
    file.close()
    if string.sub(fname, -3, -1) == "lua" and cmpl == true then
        node.compile(fname)
        file.remove(fname)
    end
end


local pl = nil;
local sv=net.createServer(net.TCP, 120) 

sv:listen(80,function(conn)
    conn:on("receive", function(conn, pl) 
        local payload = pl;
        print(string.sub(pl, 0, 22))
        if string.sub(pl, 0, 9) == "**LOAD**\n"  then
            print("HTTP : File received...")
            pl = string.sub(pl,10,-1)
            local idx = string.find(pl,"\n")
            local fname = string.sub(pl, 0, idx-1)
            local ftxt = string.sub(pl, idx+1, -1)
            load_file(fname, ftxt, true)
            conn:close()
            collectgarbage()
        elseif string.sub(pl, 0, 12) == "**RESTART**\n" then
            print("HTTP : Restarting")
            node.restart()
            conn:close()
            collectgarbage()
        else
            print("HTTP : default page:")
            local _, _, method, path, vars = string.find(pl, "([A-Z]+) (.+)?(.+) HTTP");
            print(path)
            if(method == nil)then
                _, _, method, path = string.find(pl, "([A-Z]+) (.+) HTTP");
            end
            local _GET = {}
            if (vars ~= nil)then
                for k, v in string.gmatch(vars, "([%w_]+)=(%w+)&*") do
                    _GET[k] = v
                end
            end
            
            if _GET.relay_1 ~= nil then
                gpio.write(config.RELAY_1, _GET.relay_1 == "1" and 1 or 0)
                -- TODO mqtt_publish_state()
            end
            if _GET.relay_2 ~= nil then
                gpio.write(config.RELAY_2, _GET.relay_2 == "1" and 1 or 0)
                -- TODO mqtt_publish_state()
            end
            if _GET.relay_3 ~= nil then
                gpio.write(config.RELAY_3, _GET.relay_3 == "1" and 1 or 0)
                -- TODO mqtt_publish_state()
            end
            if _GET.relay_4 ~= nil then
                gpio.write(config.RELAY_4, _GET.relay_4 == "1" and 1 or 0)
                -- TODO mqtt_publish_state()
            end

            local action = _GET["do"]
            if action ~= nil then
                if action == "restart" then
                    conn:send("<b>ok</b>")
                    conn:close()
                    collectgarbage()
                    tmr.delay(5000000)
                    node.restart()
                    return
                end
            end

            local response = exec_template("page.tmpl")
            
            local function send(localSocket)
                if #response > 0 then
                    localSocket:send(table.remove(response, 1))
                else
                    localSocket:close()
                    response = nil
                    collectgarbage()
                end
            end        
            conn:on("sent", send)
            send(conn)      
        end
        
    end)
end)

print("Server running...")
