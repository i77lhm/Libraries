local library, notifications, themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Obelus/Library.lua"))()

local dim2 = UDim2.new 
local hex = Color3.fromHex 

-- documentation 
    local window = library:window({
        name = os.date('<font color="rgb(170,85,235)">obelus</font> | %b %d %Y'),
        size = dim2(0, 516, 0, 563)
    })  
    
    -- Aiming 
        local Aiming = window:tab({name = "Legit"})

        local column = Aiming:column({fill = true}) 

        -- Column 
            local section = column:section({name = "Target Selection"})
            section:addToggle({name = "Enabled", flag = "target_selected"})
            :addKeyBind({name = "Aiming", flag = "target_selected_bind", callback = function(bool) print(bool) end})
            section:addToggle({name = "Auto Select", flag = "auto_select"})
            section:addToggle({name = "Ignore Friendlies", flag = "ignore_friendlies"})
            section:addDropdown({name = "Origin", flag = "distance_priority", items = {"Mouse", "Distance"}, default = "Mouse"})
            section:addSlider({name = "Fov", min = 0, max = 100, default = 100, interval = 1, suffix = "°", flag = "target_selector_fov"})
            section:addSlider({name = "Delay", min = 0, max = 1000, default = 40, interval = 1, suffix = "ms", flag = "target_selector_refresh_time"})
            section:addDropdown({name = "Checks", flag = "target_selected_checks", items = {"Knocked", "ForceField", "Wall"}, multi = true})
            section:addToggle({name = "Look At", flag = "look_at"})
            section:addToggle({name = "Spectate", flag = "spectate"})
            --:addToggle({name = "Auto Stomp", flag = "target_auto_stomp"})
            local toggle = section:addToggle({name = "Tracer", flag = "snap_line", folding = true})
            toggle:addColorPicker({name = "Tracer Inline", flag = "snap_line_color", color = hex("#7D0DC3")})
            toggle:addSlider({name = "Thickness", min = 1, max = 5, default = 1, interval = 1, suffix = "°", flag = "target_snap_line_thickness"})
            local toggle = section:addToggle({name = "Bounding Box", flag = "target_bounding_box", folding = true})
            toggle:addColorPicker({name = "Bounding Box Color", flag = "target_bounding_box_settings", color = hex("#000000")})
            toggle:addToggle({name = "Fill", flag = "target_bounding_box_fill"})
            toggle:addColorPicker({name = "Bounding Box Fill", flag = "bounding_box_fill_settings", color = hex("#7D0DC3")})
            toggle:addDropdown({name = "Material", flag = "target_bounding_box_material", items = {"ForceField", "Neon", "Plastic"}})    
            local toggle = section:addToggle({name = "Field Of View", flag = "fov", folding = true})   
            toggle:addColorPicker({name = "1st Color (Gradient)", flag = "fov_1_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
            toggle:addColorPicker({name = "2nd Color (Gradient)", flag = "fov_2_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
            toggle:addToggle({name = "Outline", flag = "outline_fov"})  
            toggle:addColorPicker({name = "Outline Settings", flag = "outline_fov_settings", color = hex("#000000")}) 
            toggle:addSlider({name = "Thickness", min = 0, max = 5, default = 1, interval = 1, flag = "outline_thickness_fov"})
            toggle:addSlider({name = "Custom Rotation", min = -180, max = 180, default = 0, interval = 1, flag = "custom_rotation_fov"})
            toggle:addToggle({name = "Spin", flag = "spin_fov"})
            toggle:addSlider({name = "Rotation Speed", min = 0, max = 100, default = 100, interval = 1, flag = "spin_speed_fov"})
            toggle:addLabel({name = "Hello!!! >_<"})
            section:addLabel({name = "Hello!!! >_<"})
        -- 
        
        local column = Aiming:column({fill = true})
            local section = column:section({name = "Silent Aim"})  
            section:addToggle({name = "Enabled", flag = "silent_aim"})
            section:addToggle({name = "Auto Shoot", flag = "auto_shoot"})
            section:addDropdown({name = "Prediction Type", flag = "silent_aim_velocity_type", items = {"Recalculation", "Velocity"}})
            local toggle = section:addToggle({name = "Auto Prediction", flag = "silent_use_auto_prediction", folding = true})
            toggle:addSlider({min = 0, max = 2000, default = 500, interval = 1, suffix = "°", flag = "silent_ping_factor"})
            section:addDropdown({name = "Aim Bone", flag = "silent_aim_bone", items = {"Feet", "Hrp", "Arms", "Legs", "Torso", "Head"}, default = {"Hrp"}, multi = true})
            section:addDropdown({name = "Air Bone", flag = "silent_aim_air_bone", items = {"Feet", "Hrp", "Arms", "Legs", "Torso", "Head"}, default = {"Feet"}, multi = true})
            section:addTextBox({name = "Manual Prediction", flag = "silent_manual_prediction"})
            local section = column:section({name = "Aim Assist"}) 
            section:addToggle({name = "Aim Assist", flag = "aim_assist"})
            section:addSlider({name = "Smoothing", min = 0, max = 100, default = 0, interval = 0.1, flag = "smoothing_factor"})
            section:addToggle({name = "Adjust For Jumping", flag = "adjust_for_jumping"})
            section:addDropdown({name = "Air Part", items = {"Feet", "Hrp", "Arms", "Legs", "Torso", "Head"}, flag = "aim_assist_air_bone", multi = true})
            section:addDropdown({name = "Hit Part", flag = "aim_assist_bone", items = {"Feet", "Hrp", "Arms", "Legs", "Torso", "Head"}, default = {"Torso"}, multi = true})
            section:addDropdown({name = "Prediction Type", flag = "aim_assist_velocity_type", items = {"Velocity", "Recalculation"}})
            local toggle = section:addToggle({name = "Auto Prediction", flag = "aim_assist_auto_prediction", folding = true})
            toggle:addSlider({name = "Ping Factor", min = 0, max = 1500, default = 1500, interval = 1, flag = "aim_assist_ping_factor"})
            section:addTextBox({name = "Manual Prediction", flag = "aim_assist_prediction"})

    -- 

    local Rage = window:tab({name = "Rage"})
    local Misc = window:tab({name = "Misc"})
    local Visuals = window:tab({name = "Visuals"})
    -- local Players = window:tab({name = "Players"})
    local Settings = window:tab({name = "Settings"})

    -- -- Configs 
        local column = Settings:column({fill = true})
        local general = column:section({name = "Configs"})

        config_holder = general:addList({name = "Configs", flag = "config_name_list", scale = 100})
        
        general:addTextBox({name = "Config Name", default = "", flag = "config_name_text_box"})

        general:addButton({name = "Create", callback = function()
            if flags["config_name_text_box"] == "" then 
                return 
            end 

            writefile(library.directory .. "/configs/" .. flags["config_name_text_box"] .. ".cfg", library:getConfig())

            library:configListUpdate()
        end})

        general:addButton({name = "Delete", callback = function()
            delfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg")
            library:configListUpdate()
        end})

        general:addButton({name = "Load", callback = function()
            print(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg")
            library:loadConfig(readfile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg"))
        end})
        general:addButton({name = "Save", callback = function()
            writefile(library.directory .. "/configs/" .. flags["config_name_list"] .. ".cfg", library:getConfig())
            library:configListUpdate()
        end})

        general:addButton({name = "Refresh configs", callback = function()
            library:configListUpdate()
        end}); library:configListUpdate()

        local column = Settings:column({fill = true})
        local other = column:section({name = "Other"})

        local enabled = true
        general:addLabel({name = "Menu Bind"}):addKeyBind({callback = function(booll) 
            if window.is_closing_menu == false then 
                enabled = not enabled
            end
            
            window.toggle_menu(enabled)
        end})

        general:addLabel({name = "Accent"}):addColorPicker({color = themes.preset.accent, callback = function(color) 
            library:updateTheme("accent", color)
        end})

        local old_config = library:getConfig()

        other:addButton({name = "Unload Config", callback = function()
            library:loadConfig(old_config)
        end})

        other:addButton({name = "Unload Menu", callback = function()
            library:unloadMenu()
        end})
    -- --
-- 

notifications:create_notification({name = "Hi! loaded btw"})

