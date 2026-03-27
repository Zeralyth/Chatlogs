-- Chat Logger (because messages  inyour server)
-- Logs normal chat (i couldnt get the dms to work :P)

 local log_dir = minetest.get_worldpath() .. "/chatlog"
minetest.mkdir(log_dir) 

 minetest.register_on_chat_message(function(name, message)
    -- one file per day, keeps things tidy
    local filename = log_dir .. "/" .. os.date("%Y_%m_%d") .. ".txt"
    local time = os.date("%H:%M:%S")
    local line = ""

     -- check if it's a private message
    local target, msg = message:match("^/msg%s+(%S+)%s+(.+)")
    if target and msg then
        line = time .. " [DM] " .. name .. " -> " .. target .. ": " .. msg .. "\n"
    else
        line = time .. " " .. name .. ": " .. message .. "\n"
    end

     -- try writing the message into the log
    local file = io.open(filename, "a")
    if not file then
        minetest.log("error", "[chatlog] couldn't open file: " .. filename)
        return
    end

     file:write(line)
    file:close()

    -- add this mod to world.mt to insure it works
    -- minetest.log("action", "[chatlog] " .. line:sub(1, -2))
end)

--a little help from ai, and nexarith at the same time
