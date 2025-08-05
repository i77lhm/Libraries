--[[
    Extra info: 
    -> Library has notifications
    -> Library has an unload function and doesnt have auto unload on re-execute.
    -> Please credit me this lib took SOOO long
]]

local dim_offset = UDim2.fromOffset 
local dim2 = UDim2.new 
local Camera = workspace.CurrentCamera -- DETECTED WTFFF
local rgb = Color3.fromRGB 
local Players = cloneref(game:GetService("Players")) -- Thanks peke for the bullying 
local LocalPlayer = Players.LocalPlayer

local Library, Esp, MiscOptions, Options = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Octohook/Library.lua"))()
local Holder = Library:Window({Name = "Octohook"})

local Window = Holder:Panel({
    Name = "Menu", 
    ButtonName = "Menu", 
    Size = dim_offset(550, 709), 
    Position = dim2(0, (Camera.ViewportSize.X / 2) - 550/2, 0, (Camera.ViewportSize.Y / 2) - 709/2), -- offset based on sizing 
})

local Tabs = {
    Combat = Window:Tab({Name = "Combat"}),
    Visuals = Window:Tab({Name = "Visuals"}),
    Players = Window:Tab({Name = "Players"}),
}

-- Main documentation
    local tab = Tabs.Combat
    local col1 = tab:Column({})

    local aimlock = col1:Section({Name = "Aimlock"})
    aimlock:Toggle({Name = "Enabled"})
    :Keybind({Name = "Aimbot", Mode = "Toggle", Key = Enum.KeyCode.F, Active = true}) 
    aimlock:Toggle({Name = "Visualize FOV"})
    :Colorpicker({Color = rgb(255, 255, 255), Alpha = 1})
    aimlock:Slider({Name = "Smoothing X", Min = -100, Max = 100, Decimal = 1})
    aimlock:Slider({Name = "Smoothing Y", Min = -100, Max = 100, Decimal = 1})
    aimlock:Slider({Name = "Target Distance", Min = 0, Max = 500, Decimal = 1})
    aimlock:Dropdown({Name = "Aim Mode", Options = {"none"}, Default = "none", Multi = false})
    aimlock:Dropdown({Name = "Aimbones", Options = {"none"}, Default = "none", Multi = false})

    local config = col1:Section({Name = "Configuration"})
    config:Toggle({
        Name = "Resolver", 
        Tooltip = {
            Title = "Resolver", 
            Text = "Uses advanced scanning to determine an appropriate shoot position.\nMay be very laggy!!", 
            Width = 200,
        },
        Default = false
    })
    
    config:Toggle({Name = "Target Bots"})
    config:Toggle({Name = "Target Indicator"})
    :Colorpicker({Color = rgb(255, 255, 255), Alpha = 1}) 
    config:Dropdown({Name = "Indicator Values", Options = {"none"}, Default = "none", Multi = false})
    config:Dropdown({Name = "Conditions", Options = {"none"}, Default = "none", Multi = false})
    config:Dropdown({Name = "Ignorelist", Options = {"none"}, Default = "none", Multi = false})

    local col2 = tab:Column({})

    local silent = col2:Section({Name = "Silent-Aim"})
    silent:Toggle({Name = "Enabled"})
    silent:Toggle({Name = "Visualize FOV"})
    :Colorpicker({Color = rgb(255, 255, 255), Alpha = 1})
    silent:Slider({Min = -100, Max = 100, Decimal = 1})
    silent:Slider({Name = "Head Hitchance", Min = 0, Max = 100, Decimal = 1})
    silent:Slider({Name = "Body Hitchance", Min = 0, Max = 100, Decimal = 1})
    silent:Slider({Name = "Target Distance", Min = 0, Max = 500, Decimal = 1})

    local mods = col2:Section({Name = "Gun Modifications"})
    mods:Toggle({Name = "Manipulation", Tooltip = {
            Title = "<font color = '#FFFF00'>WARNING!!</font>", 
            Text = "This may be detected, please use with caution.\nDesyncs your shoot position on the serverside.", 
            Width = 200,
        }
    })  

    -- Example of usage (Can be tweaked)
    local List;
    mods:Textbox({Name = "Search", Callback = function(text)
        if not List then 
            return 
        end 

        List.Filter(text)
    end})

    List = mods:Dropdown({Name = "Search + Scroll", Scrolling = true, Size = 100, Search = true, Callback = function(option)
        print(option)
    end})
        
    local Table = {}

    for i = 1, 100 do 
        table.insert(Table, tostring(i))
    end

    List.RefreshOptions(Table)

    local List;
    mods:Textbox({Name = "Search", Callback = function(text)
        if not List then 
            return 
        end 

        List.Filter(text)
    end})

    List = mods:List({Name = "Search + Scroll", Scrolling = true, Size = 100, Callback = function(option)
        print(option)
    end})
        
    local Table = {}

    for i = 1, 100 do 
        table.insert(Table, tostring(i))
    end

    List.RefreshOptions(Table)

    mods:Slider({Min = 0.1, Max = 10, Decimal = 1}) 
-- 

-- Esp preview 
    local Column = Tabs.Players:Column({})
    local EspPreviewSection = Column:Section({Name = "ESP"})
    local EspPreview = EspPreviewSection:EspPreview({})
    local PlayersTab = EspPreview:AddTab({
        Name = "Players", 
        Model = "rbxassetid://14966982841",
        Chams = true
    });
    -- EspPreview:AddTab({Name = "Idk", Model = "rbxassetid://12340371165", Scale = 0.5})
    

    --[[
        READ IF YOU WANT TO MODIFY THE ESP SOURCE CODE

        Adding a new text or bar means you have to go to the createobject code and make a new element for said item 
            -> (Also you have to call addbar or addtext to add a suffix to the esp) 
           
        For adding static text (like usernames), make the text and filter it in the refreshelements function. 
            -> Yes the filter looks like yandere dev code and can be easily rewritten.
        
        For updating text, eg distance or tools or whatever, update it in the update function
            -> Look at the distance text for more info 

        Bars aren't filtered I didnt add code for it, if you want you can modify it to filter through like healthbars
            -> If you make the filter then you can follow same instructions as the text. 
        
        Boxes just exist, you dont need to do anything to them I believe

        Yes multi tabs exist however I didnt find a use for 2 tabs yet so the code may not be compatible, you will need to code a filter for that aswell.
        (Literally can be added in like under 5 minutes if you know lua)

        Extra Info: 
        + CHAMS ARE HARDCODED TO PLAYERS TAB
        + For the tab where the 3d character is held, there is a scale parameter for larger models. 
        + Esp relies on miscoptions and options for the newindex where each element is filtered and updated. Dont ask why.  
    ]]
    
    PlayersTab.AddBar({Name = "Healthbar", Prefix = "Healthbar"})
    PlayersTab.AddText({Name = "Name", Prefix = "Name"})
    PlayersTab.AddText({Name = "Distance", Prefix = "Distance"})
    PlayersTab.AddBox({Name = "Box"})
    
    local Column = Tabs.Players:Column({})
-- 

Tabs.Settings = Window:Tab({Name = "Settings"})
Library:Configs(Holder, Tabs.Settings)

-- Loops for text
    task.spawn(function()
        while task.wait(1) do
            if not Holder.Items.Holder.Visible then 
                continue
            end 

            Holder.ChangeMenuTitle(string.format("%s - universal vers. - %s", Holder.Name, os.date("%b. %d %Y, %X")))
        end 
    end)

    Holder.ChangeMenuTitle(string.format("%s - universal vers. - %s", Holder.Name, os.date("%b. %d %Y, %X")))
-- 

-- init this before esp 
    for index,value in MiscOptions do 
        Options[index] = value -- gotta trigger that new index
    end
-- 

-- REMOVE: This is an example for testing healthbar tweening, remove if you wish to use. 
    task.spawn(function()
        while Esp do 
            for _,player in Players:GetPlayers() do 
                if not player.Character then 
                    continue 
                end 

                if player.Character:FindFirstChild("Humanoid") then 
                    player.Character.Humanoid.Health = math.random(1, 100)
                end     
            end 

            task.wait(3)
        end 
    end) 
-- 

for _,player in Players:GetPlayers() do 
    if player == LocalPlayer then 
        continue 
    end 

    Esp.CreateObject(player)
end 

Esp:Connection(Players.PlayerRemoving, Esp.RemovePlayer)
Esp:Connection(Players.PlayerAdded, function(player)
    Esp.CreateObject(player)

    for index,value in MiscOptions do 
        Options[index] = value
    end 
end)
