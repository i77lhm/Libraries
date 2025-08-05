local library, notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Priv9/Library.lua"))()

local window = library:window({
	name = "priv9",
})

notifications:create_notification({name = "loading menu..."})
notifications:create_notification({name = "loading modules..."})

local rage = window:tab({name = "rage"})
local column = rage:column({})
local section = column:section({name = "aimbot", auto_fill = false, size = 0.3})
local section2 = column:section({name = "target selection", auto_fill = false, size = 0.7})
section:toggle({name = "enabled", flag = "toggle_flag"})
section:keybind({name = "aim key"})
section:toggle({name = "silent", flag = "toggle_flag"})
section:slider({name = "smooth", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})

section2:slider({name = "fov", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section2:slider({name = "max distance", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section2:toggle({name = "target npcs", flag = "toggle_flag"})
section2:dropdown({name = "hitbox", flag = "distance_priority", items = {"head","chest","legs"}, default = "head"})
section2:slider({name = "hs after x shots", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})

local column = rage:column({})
local section = column:section({name = "weapon modifications"})
local section2 = column:section({name = "other"})
section:toggle({name = "no-spread", flag = "toggle_flag"})
section:slider({name = "recoil multiplier", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section:slider({name = "bullet thickness", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section:slider({name = "bullet speed", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})

local column = rage:column({})
local section = column:section({name = "hax"})
section:toggle({name = "speed hax"})
section:slider({name = "speed multiplier", min = 0, max = 10, default = 10, interval = 0.1, suffix = "st"})
section:slider({name = "radius", min = 0, max = 10, default = 10, interval = 0.1, suffix = "rad"})
section:slider({name = "skidding speed", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})

local section2 = column:section({name = "other"})
section:toggle({name = "no-spread", flag = "toggle_flag"})
section:slider({name = "recoil multiplier", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section:slider({name = "bullet thickness", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section:slider({name = "bullet speed", min = 0, max = 10, default = 10, interval = 0.1, suffix = ""})
section:button({name = "Test notification", callback = function()
    notifications:create_notification({name = "NOTIFICATION TESTING"})
end})

local rage = window:tab({name = "visuals"})
local rage = window:tab({name = "misc"})

notifications:create_notification({name = "loaded cheat"})
library:init_config(window) 
