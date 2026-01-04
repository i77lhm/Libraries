local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Xezios/Library.lua"))()

local Window = Library:Window({name = "nebula"})

local Tabs = {
    Combat = Window:Tab({Name = "Combat", Icon = "rbxassetid://132776928710277"}),
    Visuals = Window:Tab({Name = "Visuals"}),
    Players = Window:Tab({Name = "Players"})
}

for i = 1, 5 do
    local Section = Tabs.Combat:Section({Name = "Section", Side = "Left"})

    local Toggle = Section:Toggle({Name = "Toggle"})
    Toggle:Colorpicker({Name = "Hello!", Flag = "This is a flag" .. i}) -- For animation pickers you need to either designate speific names or Flags to differentiate animations. else itll break
    Toggle:Keybind({Name = "hello!", Callback = function(bool) print(bool) end})
    Section:Button({Name = "Button", Callback = function() print("I have been clicked!") end})
end 

local Section = Tabs.Combat:Section({Name = "Section", Side = "Right"})

for i = 1, 5 do
    local Toggle = Section:Toggle({Name = "Toggle"})
    Toggle:Colorpicker({Name = "Hello!", Flag = "This is a flag" .. i}) -- For animation pickers you need to either designate speific names or Flags to differentiate animations. else itll break
    Toggle:Keybind({Name = "hello!", Callback = function(bool) print(bool) end})
    Section:Button({Name = "Button", Callback = function() print("I have been clicked!") end})
end 


Section:Slider({Name = "Slider", Callback = function(int) print(int) end})
Section:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}, Multi = true})
Section:Textbox({Name = "Hi"})


Library:Configs(Window)
