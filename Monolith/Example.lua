local library, notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Monolith/Library.lua"))()

local window = library:window({name = "nebula"})

for i = 1, 3 do 
    local tab = window:Tab({})
    for _,side in {"left", "right"} do 
        local section = tab:Section({name = "hello!", side = side})
        section:Toggle({}) 
        section:Slider({})
        section:Dropdown({Name = "Dropdown " .. i .. side})

        -- Grouped objects / elements 
        local Toggle = section:Toggle({})
        Toggle:Slider({Name = "Slider " .. i .. side})

        local Toggle = section:Toggle({})
        Toggle:Slider({})

        local Toggle = section:Toggle({Name = "Flags testing " .. i .. side})
        Toggle:Dropdown({Name = "Dropdown " .. i .. side})

        local Toggle = section:Toggle({})
        Toggle:Dropdown({})

        local Toggle = section:Toggle({name = "Hello! " .. i .. side})
        Toggle:Keybind({Callback = function(Bool) print(Bool) end})

        local Toggle = section:Toggle({name = "Hello! " .. i .. side})
        Toggle:Keybind({Name = "Aimbot Bind " .. i .. side, Callback = function(Bool) print(Bool) end})

        local Toggle = section:Toggle({Name = "Hello! " .. i .. side})
        Toggle:Colorpicker({})

        local Toggle = section:Toggle({Name = "Hello! " .. i .. side})
        Toggle:Colorpicker({Name = "I have a name now! " .. i .. side})

        section:Button({Callback = function() print("Clicked") end})

        section:Textbox({})
    end
end 

window.toggle_menu(true)
library:init_config(window) 
