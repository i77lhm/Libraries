local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Utopia/Library.lua"))()

local Window = Library:Window({
    Name = "U T O P I A",
    GradientTitle = {
        Enabled = true,
        Start = Color3.fromRGB(255, 255, 255),
        Middle = Color3.fromRGB(0, 251, 255),
        End = Color3.fromRGB(50, 135, 168),
        Speed = 1
    }
})

local Watermark = Library:Watermark("This is a watermark LAOLASLDASLDASLLDSALDSL", {"77974153657891", Color3.fromRGB(149, 255, 139)})
local KeybindList = Library:KeybindList()

--Watermark:SetVisibility(false)
--KeybindList:SetVisibility(false)

local CombatTab = Window:Page({Name = "Combat", Columns = 2  })
local MiscTab = Window:Page({Name = "Misc", Columns = 2  })
local VisualsTab = Window:Page({Name = "Visuals", Columns = 2  })
local PlayersTab = Window:Page({Name = "Players", Columns = 1  })
local SettingsTab = Window:Page({Name = "Settings", Columns = 2 })

local AimbotSection = CombatTab:Section({Name = "Aimbot", Side = 1 })
CombatTab:Section({Name = "NIGGERRSDSSSSSSSSSS", Side = 2 })

PlayersTab:PlayerList({
    Name = "Playerlist", 
    Flag = "Playerlist", 
    Callback = function(Players)
        print(Players)
    end
})

local Toggle = AimbotSection:Toggle({
    Name = "Toggle", 
    Default = false, 
    Flag = "Toggle",
    Tooltip = "Nigger",
    Risky = true,
    Callback = function(Value)
        print(Value)
    end
})

local Button = AimbotSection:Button({
    Name = "Button", 
    Risky = true,
    Callback = function()
        print("Button")
    end
})

local Button = AimbotSection:Button({
    Name = "Button", 
    Callback = function()
        print("Button")
    end
}):SubButton({
    Name = "SubButton", 
    Callback = function()
        print("SubButton")
    end
})

local Slider = AimbotSection:Slider({
    Name = "Slider", 
    Flag = "Slider", 
    Min = 0, 
    Default = 0, 
    Max = 100, 
    Suffix = "%", 
    Decimals = 1, 
    Callback = function(Value)
        print(Value)
    end
})

local Dropdown = AimbotSection:Dropdown({
    Name = "Dropdown", 
    Flag = "Dropdown", 
    Items = { }, 
    Multi = false,
    Default = nil,
    Callback = function(Value)
        print(Value)
    end
})

local MultiDropdown = AimbotSection:Dropdown({
    Name = "Multi Dropdown", 
    Flag = "Multi Dropdown", 
    Items = { }, 
    Default = nil,
    Multi = true,
    Callback = function(Value)
        print(Value)
    end
})

local ColorpickerLabel = AimbotSection:Label("Colorpicker", "Left")

ColorpickerLabel:Colorpicker({ 
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end
})

ColorpickerLabel:Colorpicker({ 
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end
})

Toggle:Colorpicker({ 
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end
})

Toggle:Colorpicker({ 
    Name = "Colorpicker", 
    Flag = "Colorpicker", 
    Default = Color3.fromRGB(255, 255, 255), 
    Callback = function(Value, Alpha)
        print(Value, Alpha)
    end
})

local Keybind = AimbotSection:Label("Keybind", "Left"):Keybind({ 
    Name = "Keybind", 
    Flag = "Keybind", 
    Default = Enum.KeyCode.Z, 
    Mode = "Toggle", 
    Callback = function(Value)
        print(Value)
    end
})

local Input = AimbotSection:Textbox({
    Name = "Input",
    Flag = "Input",
    Default = "Input",
    Placeholder = "Placeholder",
    Callback = function(Value)
        print(Value)
    end
})

local Listbox = AimbotSection:Listbox({
    Name = "List",
    Flag = "List",
    Items = { "One" },
    Multi = false,
    Default = nil,
    Callback = function(Value)
        print(Value)
    end
})

for Index = 1, 20 do 
    Dropdown:Add("Option " .. Index)
    MultiDropdown:Add("Option " .. Index)
    Listbox:Add("Option " .. Index)
end

local ThemesSection = SettingsTab:Section({ Name = "Settings", Side = 1 })

do
    for Index, Value in Library.Theme do 
        Library.ThemeColorpickers[Index] = ThemesSection:Label(Index, "Left"):Colorpicker({
            Name = Index,
            Flag = "Theme" .. Index,
            Default = Value,
            Callback = function(Value)
                Library.Theme[Index] = Value
                Library:ChangeTheme(Index, Value)
            end
        })
    end

    ThemesSection:Dropdown({Name = "Themes list", Items = {"Default", "Bitchbot", "Onetap", "Aqua"}, Default = "Default", Callback = function(Value)
        local ThemeData = Library.Themes[Value]

        if not ThemeData then 
            return
        end

        for Index, Value in Library.Theme do 
            Library.Theme[Index] = ThemeData[Index]
            Library:ChangeTheme(Index, ThemeData[Index])

            Library.ThemeColorpickers[Index]:Set(ThemeData[Index])
        end

        task.wait(0.3)

        Library:Thread(function() -- i do this because sometimes the themes dont update
            for Index, Value in Library.Theme do 
                Library.Theme[Index] = Library.Flags["Theme"..Index].Color
                Library:ChangeTheme(Index, Library.Flags["Theme"..Index].Color)
            end    
        end)
    end})

    local ThemeName
    local SelectedTheme 

    local ThemesListbox = ThemesSection:Listbox({
        Name = "Themes List",
        Flag = "Themes List",
        Items = { },
        Multi = false,
        Default = nil,
        Callback = function(Value)
            SelectedTheme = Value
        end
    })

    ThemesSection:Textbox({
        Name = "Name",
        Flag = "Theme Name",
        Default = "",
        Placeholder = ". . .",
        Callback = function(Value)
            ThemeName = Value
        end
    })

    ThemesSection:Button({
        Name = "Save Theme",
        Callback = function()
            if ThemeName == "" then 
                return
            end

            if not isfile(Library.Folders.Themes .. "/" .. ThemeName .. ".json") then
                writefile(Library.Folders.Themes .. "/" .. ThemeName .. ".json", Library:GetTheme())

                Library:RefreshThemeList(ThemesListbox)
            else
                Library:Notification("Theme '" .. ThemeName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
                return
            end
        end
    }):SubButton({
        Name = "Load Theme",
        Callback = function()
            if SelectedTheme then
                Library:LoadTheme(readfile(Library.Folders.Themes .. "/" .. SelectedTheme))
            end
        end
    })

    ThemesSection:Button({
        Name = "Refresh Themes",
        Callback = function()
            Library:RefreshThemeList(ThemesListbox)
        end
    })

    Library:RefreshThemeList(ThemesListbox)
end

local ConfigsSection = SettingsTab:Section({  Name = "Configs", Side = 2 })

do 
    local ConfigName 
    local SelectedConfig 

    local ConfigsListbox = ConfigsSection:Listbox({
        Name = "Configs list",
        Flag = "Configs List",
        Items = { },
        Multi = false,
        Default = nil,
        Callback = function(Value)
            SelectedConfig = Value
        end
    })

    ConfigsSection:Textbox({
        Name = "Name",
        Flag = "Config Name",
        Default = "",
        Placeholder = ". . .",
        Callback = function(Value)
            ConfigName = Value
        end
    })

    ConfigsSection:Button({
        Name = "Load Config",
        Callback = function()
            if SelectedConfig then
                Library:LoadConfig(readfile(Library.Folders.Configs .. "/" .. SelectedConfig))
            end

            Library:Thread(function()
                task.wait(0.1)

                for Index, Value in Library.Theme do 
                    Library.Theme[Index] = Library.Flags["Theme"..Index].Color
                    Library:ChangeTheme(Index, Library.Flags["Theme"..Index].Color)
                end    
            end)
        end
    }):SubButton({
        Name = "Save Config",
        Callback = function()
            if SelectedConfig then
                Library:SaveConfig(SelectedConfig)
            end
        end
    })

    ConfigsSection:Button({
        Name = "Create Config",
        Callback = function()
            if ConfigName == "" then 
                return
            end

            if not isfile(Library.Folders.Configs .. "/" .. ConfigName .. ".json") then
                writefile(Library.Folders.Configs .. "/" .. ConfigName .. ".json", Library:GetConfig())

                Library:RefreshConfigsList(ConfigsListbox)
            else
                Library:Notification("Config '" .. ConfigName .. ".json' already exists", 3, Color3.fromRGB(255, 0, 0))
                return
            end
        end
    }):SubButton({
        Name = "Delete Config",
        Callback = function()
            if SelectedConfig then
                Library:DeleteConfig(SelectedConfig)

                Library:RefreshConfigsList(ConfigsListbox)
            end
        end
    })

    ConfigsSection:Button({
        Name = "Refresh Configs",
        Callback = function()
            Library:RefreshConfigsList(ConfigsListbox)
        end
    })

    Library:RefreshConfigsList(ConfigsListbox)

    ConfigsSection:Label("Menu Keybind", "Left"):Keybind({Name = "Menu Keybind", Flag = "Menu Keybind", Default = Enum.KeyCode.RightControl, Mode = "Toggle", Callback = function(Value)
        Library.MenuKeybind = Library.Flags["Menu Keybind"].Key
    end})

    ConfigsSection:Toggle({Name = "Watermark", Flag = "Watermark", Default = false, Callback = function(Value)
        Watermark:SetVisibility(Value)
    end})

    ConfigsSection:Toggle({Name = "Keybind List", Flag = "Keybind List", Default = false, Callback = function(Value)
        KeybindList:SetVisibility(Value)
    end})

    ConfigsSection:Dropdown({Name = "Style", Flag = "Tweening Style", Default = "Exponential", Items = {"Linear", "Sine", "Quad", "Cubic", "Quart", "Quint", "Exponential", "Circular", "Back", "Elastic", "Bounce"}, Callback = function(Value)
        Library.Tween.Style = Enum.EasingStyle[Value]
    end})

    ConfigsSection:Dropdown({Name = "Direction", Flag = "Tweening Direction", Default = "Out", Items = {"In", "Out", "InOut"}, Callback = function(Value)
        Library.Tween.Direction = Enum.EasingDirection[Value]
    end})

    ConfigsSection:Slider({Name = "Tweening Time", Min = 0, Max = 5, Default = 0.25, Decimals = 0.01, Flag = "Tweening Time", Callback = function(Value)
        Library.Tween.Time = Value
    end})

    ConfigsSection:Button({Name = "Notification test", Callback = function()
        Library:Notification("This is a notification This is a notification This is a notification This is a notification", 5, Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)))
    end})

    ConfigsSection:Button({Name = "Unload library", Callback = function()
        Library:Unload()
    end})
end

Library:Notification("Loaded library in " .. string.format("%.4f", os.clock() - LoadingTick) .. " seconds", 5, Color3.fromRGB(0, 255, 0), {"135757045959142", Color3.fromRGB(149, 255, 139)})
