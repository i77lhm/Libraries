local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Millenium/Library.lua"))()

--[[
  This ui uses a column way of creating holders for sections, its a bit confusing for newbies so heres an easy explanation:
  Each column is how much sections sideways you can have, eg normal menus have only two however you can have 3 or 4 or 1 with this library.
  There is alot of customisability with this library which made it very high in demand.

  Also I haven't even got a clue how this got leaked since loads of people had it.
]]

local window = library:window({name = "nebula", suffix = "tech", gameInfo = "Milenium for Counter-Strike: Global Offensive"})

window:seperator({name = "General"})
local enemies, teammates, self_section = window:tab({name = "Example", tabs = {"Enemies", "Teammates", "Self"}})
for _,tab in {enemies, teammates, self_section} do 
    local column = tab:column({})
    local section = column:section({name = "General", default = true, toggle = false})
    section:label({name = "This is a title!", info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
    
    local page = tab:sub_tab({order = -10000, size = 2}) -- -1 sets it to the top
    
    for i = 1, 2 do 
        local column = page:column({})
        local section = column:section({name = "General", default = true})
        section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
        section:toggle({name = "Through walls", seperator = true})
        local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

        -- Sub Section Example
            local toggle = section:toggle({name = "Name", seperator = true})
            toggle:colorpicker({})
            local sub_section = toggle:settings({})
            sub_section:toggle({name = "Show Display Names", seperator = true})
            sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
            sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
            sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
        -- 

        section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
        section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
        section:toggle({name = "Other Shit", seperator = false}):colorpicker({})
    end
end 

local enemies, teammates, self_section = window:tab({name = "Example", tabs = {"Enemies", "Teammates", "Self"}})
for _,tab in {enemies, teammates, self_section} do 
    for i = 1, 2 do 
        local column = tab:column({})
        local section = column:section({name = "General", default = true})
        section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
        section:toggle({name = "Through walls", seperator = true})
        local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

        -- Sub Section Example
            local toggle = section:toggle({name = "Name", seperator = true})
            toggle:colorpicker({})
            local sub_section = toggle:settings({})
            sub_section:toggle({name = "Show Display Names", seperator = true})
            sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
            sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
            sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
        -- 

        section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
        section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
        section:toggle({name = "Other Shit", seperator = false}):colorpicker({})
    end
end 


local enemies, teammates, self_section = window:tab({name = "Example", tabs = {"Enemies", "Teammates", "Self"}})
for _,tab in {enemies, teammates, self_section} do 
    local column = tab:column({})
    local section = column:section({name = "General", default = true})
    section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
    section:toggle({name = "Through walls", seperator = true})
    local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

    -- Sub Section Example
        local toggle = section:toggle({name = "Name", seperator = true})
        toggle:colorpicker({})
        local sub_section = toggle:settings({})
        sub_section:toggle({name = "Show Display Names", seperator = true})
        sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
        sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
        sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
    -- 

    section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
    section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
    section:toggle({name = "Other Shit", seperator = false}):colorpicker({})
end 

local enemies, teammates, self_section = window:tab({name = "Example", tabs = {"Enemies", "Teammates", "Self"}})
for _,tab in {enemies, teammates, self_section} do 
    local column = tab:column({})

    for i = 1, 2 do 
        local section = column:section({name = "General", default = true, size = 0.5})
        section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
        section:toggle({name = "Through walls", seperator = true})
        local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

        -- Sub Section Example
            local toggle = section:toggle({name = "Name", seperator = true})
            toggle:colorpicker({})
            local sub_section = toggle:settings({})
            sub_section:toggle({name = "Show Display Names", seperator = true})
            sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
            sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
            sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
        -- 

        section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
        section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
        section:toggle({name = "Other Shit", seperator = false}):colorpicker({})
    end 
end 

-- OLD DOCUMENTATION
-- for i = 1, 5 do 
--     window:seperator({name = "General"})
--     local enemies, teammates, self_section = window:tab({name = "Players", tabs = {"Enemies", "Teammates", "Self"}})

--     for _, v in {enemies, teammates, self_section} do 
--         for s, side in {"left", "right", ""} do 
--             local column = v:column({})
--             local section = column:section({name = "General", size = 0.3, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, callback = function(bool) print(bool) end})
--             section:toggle({name = "Through walls", seperator = true})
--             local toggle = section:toggle({name = "Shared ESP", seperator = true}):colorpicker({})

--             -- Sub Section Example
--                 local toggle = section:toggle({name = "Name", seperator = true})
--                 toggle:colorpicker({})
--                 local sub_section = toggle:settings({})
--                 sub_section:toggle({name = "Show Display Names", seperator = true})
--                 sub_section:dropdown({name = "Font Name", items = {"ProggyTiny", "MonoSpace", "Tahoma"}, default = "MonoSpace", seperator = true})
--                 sub_section:colorpicker({name = "Another Colorpicker why not", seperator = true})
--                 sub_section:keybind({name = "Keybind", callback = function(bool) print(bool) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             -- 

--             section:toggle({name = "Weapon", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})
--             section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true})
--             section:toggle({name = "Other Shit", seperator = false}):colorpicker({})

--             local section = column:section({name = "General", size = 0.3, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             section:toggle({name = "Through walls", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             local toggle = section:toggle({name = "Shared ESP", seperator = true, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"}):colorpicker({})

--             local section = column:section({name = "General", size = 0.4, default = true})
--             section:toggle({name = "Enable ESP", seperator = true, info = "Hello!!!!!"})
--             section:dropdown({name = "Flags", items = {"Scoped", "Flashed", "Knocked", "Touched"}, default = {"Scoped", "Flashed", "Knocked"}, multi = true, seperator = true, info = "Hello!!!!!"})
--             section:slider({name = "Slider", info = "This is extra info.", min = 0, max = 50, interval = 0.5, callback = function(int) print(int) end, info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--             section:label({name = "This is a title!", info = "Hello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawdHello there this is a paragraph.. adawdawdawd\nextra info here ig"})
--         end 
--     end 
-- end 


library:init_config(window) 
