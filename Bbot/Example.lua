local Library, Notifications, Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Bbot/Library.lua"))()

local Window = Library:Window({name = "nebula"})

local Tabs = {
    Combat = Window:Tab({Name = "Combat"}),
    Visuals = Window:Tab({Name = "Visuals"}),
    Players = Window:Tab({Name = "Players"})
}

Tabs.Players:PlayerList({}) -- Tabs.Players.GetPriority(player.Name)

local Section = Tabs.Combat:Section({Name = "Section", Side = "Left"})

for i = 1, 3 do
    local Toggle = Section:Toggle({Name = "Toggle"})
    Toggle:Colorpicker({Name = "Hello!", Flag = "This is a flag" .. i}) -- For animation pickers you need to either designate speific names or flags to differentiate animations. else itll break
    Toggle:Keybind({Name = "hello!", Callback = function(bool) print(bool) end, ShowInList = true})
    Section:Button({Name = "Button", Callback = function() print("I have been clicked!") end})
end 

Section:Slider({Name = "Slider", Callback = function(int) print(int) end})
Section:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}})

local Toggle = Section:Toggle({Name = "Group", Folding = true})
Toggle:Toggle({Name = "Toggle"})
Toggle:Slider({Name = "Slider", Callback = function(int) print(int) end})
Toggle:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}, Multi = true})

for i = 1, 5 do 
    Toggle = Toggle:Toggle({Name = "Group", Folding = true})
    Toggle:Toggle({Name = "Toggle"})
    Toggle:Slider({Name = "Slider", Callback = function(int) print(int) end})
    Toggle:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}})
end

local Tab1, Tab2, Tab3 = Tabs.Combat:MultiSection({Tabs = {"Hi", "Hello", "Sick"}, Side = "Right", Size = 1})
for _,tab in {Tab1, Tab2, Tab3} do 
    tab:Toggle({Name = "Toggle"})
    tab:Slider({Name = "Slider", Callback = function(int) print(int) end})
    tab:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}})

    local Toggle = tab:Toggle({Name = "Group", Folding = true})
    Toggle:Toggle({Name = "Toggle"})
    Toggle:Slider({Name = "Slider", Callback = function(int) print(int) end})
    Toggle:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}})

    for i = 1, 5 do 
        Toggle = Toggle:Toggle({Name = "Group", Folding = true})
        Toggle:Toggle({Name = "Toggle"})
        Toggle:Slider({Name = "Slider", Callback = function(int) print(int) end})
        Toggle:Dropdown({Name = "Hello!", Options = {"1", "2", "3"}})
        Toggle:Textbox({Name = "Textbox", Default = "hELLO!", Callback = function(Text) print(Text) end})
    end
end

Library:Configs(Window)

for index, value in Themes.preset do 
    pcall(function()
        Library:RefreshTheme(index, value)
    end)
end
