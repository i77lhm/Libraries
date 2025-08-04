-- Variables 
    local uis = game:GetService("UserInputService") 
    local players = game:GetService("Players") 
    local ws = game:GetService("Workspace")
    local rs = game:GetService("ReplicatedStorage")
    local http_service = game:GetService("HttpService")
    local gui_service = game:GetService("GuiService")
    local lighting = game:GetService("Lighting")
    local run = game:GetService("RunService")
    local stats = game:GetService("Stats")
    local coregui = game:GetService("CoreGui")
    local debris = game:GetService("Debris")
    local tween_service = game:GetService("TweenService")
    local sound_service = game:GetService("SoundService")

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local point_object_space = empty_cfr.PointToObjectSpace
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 
    local gui_offset = gui_service:GetGuiInset().Y

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local noise = math.noise
    local rad = math.rad 
    local random = math.random 
    local pow = math.pow 
    local sin = math.sin 
    local pi = math.pi 
    local tan = math.tan 
    local atan2 = math.atan2 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat
-- 

-- Library init
    getgenv().library = {
        directory = "monolithhh",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},
        connections = {},   
        notifications = {notifs = {}},
        current_open; 
    }

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end

    local flags = library.flags 
    local config_flags = library.config_flags
    local notifications = library.notifications 

    -- Font importing system 
        if isfile(library.directory .. "/fonts/main.ttf") then 
            delfile(library.directory .. "/fonts/main.ttf")
        else 
            writefile(library.directory .. "/fonts/main.ttf", game:HttpGet("https://github.com/f1nobe7650/Nebula/raw/refs/heads/main/Minecraftia-Regular.ttf"))
        end 
        
        local minecraftia = {
            name = "Minecraftia",
            faces = {
                {
                    name = "Regular",
                    weight = 400,
                    style = "normal",
                    assetId = getcustomasset(library.directory .. "/fonts/main.ttf")
                }
            }
        }
        
        if not isfile(library.directory .. "/fonts/main_encoded.ttf") then 
            writefile(library.directory .. "/fonts/main_encoded.ttf", http_service:JSONEncode(minecraftia))
        end 
        
        library.font = Font.new(getcustomasset(library.directory .. "/fonts/main_encoded.ttf"), Enum.FontWeight.Regular)
        -- library.font = library.font
    -- 
--

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties, easing_style, time) 
            local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties)
            tween:Play()
                
            return tween
        end

        function library:get_transparency(obj)
            if obj:IsA("Frame") then
                return {"BackgroundTransparency"}
            elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                return { "BackgroundTransparency", "ImageTransparency" }
            elseif obj:IsA("ScrollingFrame") then
                return { "BackgroundTransparency", "ScrollBarImageTransparency" }
            elseif obj:IsA("TextBox") then
                return { "TextTransparency", "BackgroundTransparency" }
            elseif obj:IsA("UIStroke") then 
                return { "Transparency" }
            end
            
            return nil
        end

        function library:fade(obj, prop, vis, speed)
            if not (obj and prop) then
                return
            end

            local OldTransparency = obj[prop]
            obj[prop] = vis and 1 or OldTransparency

            local Tween = library:tween(obj, { [prop] = vis and OldTransparency or 1 })

            library:connection(Tween.Completed, function()
                if not vis then
                    task.wait()
                    obj[prop] = OldTransparency
                end
            end)

            return Tween
        end

        function library:resizify(frame) 
            local Frame = Instance.new("TextButton")
            Frame.Position = dim2(1, -10, 1, -10)
            Frame.BorderColor3 = rgb(0, 0, 0)
            Frame.Size = dim2(0, 10, 0, 10)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = rgb(255, 255, 255)
            Frame.Parent = frame
            Frame.BackgroundTransparency = 1 
            Frame.Text = ""

            local resizing = false 
            local start_size 
            local start 
            local og_size = frame.Size  

            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = true
                    start = input.Position
                    start_size = frame.Size
                end
            end)

            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    resizing = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_size = dim2(
                        start_size.X.Scale,
                        math.clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            og_size.X.Offset,
                            viewport_x
                        ),
                        start_size.Y.Scale,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            og_size.Y.Offset,
                            viewport_y
                        )
                    )

                    -- library:tween(frame, {Size = current_size}, Enum.EasingStyle.Linear, 0.05) -- nobody will ntoice this aswell 👿
                    frame.Size = current_size
                end
            end)
        end 

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        function library:draggify(frame)
            local dragging = false 
            local start_size = frame.Position
            local start 

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    start = input.Position
                    start_size = frame.Position
                end
            end)

            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_position = dim2(
                        0,
                        clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            0,
                            viewport_x - frame.Size.X.Offset
                        ),
                        0,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            0,
                            viewport_y - frame.Size.Y.Offset
                        )
                    )

                    -- library:tween(frame, {Position = current_position}, Enum.EasingStyle.Linear, 0) -- heh, nobody will notice 
                    frame.Position = current_position
                    library:close_current_element(nil) 
                end
            end)
        end 

        function library:convert(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                insert(values, tonumber(value))
            end
            
            if #values == 4 then              
                return unpack(values)
            else 
                return
            end
        end
        
        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        local config_holder;
        function library:update_config_list() 
            if not config_holder then 
                return 
            end
            
            local list = {}
            
            for idx, file in listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
                list[#list + 1] = name
            end

            config_holder.refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
            
            for _, v in next, flags do
                if type(v) == "table" and v.key then
                    Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
                elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                    Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
                else
                    Config[_] = v
                end
            end 
            
            return http_service:JSONEncode(Config)
        end

        function library:load_config(config_json) 
            local config = http_service:JSONDecode(config_json)
            
            for _, v in config do 
                local function_set = library.config_flags[_]
                
                if _ == "config_name_list" then 
                    continue 
                end

                if function_set then 
                    if type(v) == "table" and v["Transparency"] and v["Color"] then
                        function_set(hex(v["Color"]), v["Transparency"])
                    elseif type(v) == "table" and v["active"] then 
                        function_set(v)
                    else
                        function_set(v)
                    end
                end 
            end 
        end 
        
        function library:round(number, float) 
            local multiplier = 1 / (float or 1)

            return floor(number * multiplier + 0.5) / multiplier
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:close_current_element(cfg) 
			local path = library.current 

			if path and path ~= cfg then 
				path.set_visible(false)
				path.open = false 
			end
		end

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in options do 
                ins[prop] = value
            end
            
            return ins 
        end

        function library:unload_menu() 
            if library[ "items" ] then 
                library[ "items" ]:Destroy()
            end

            if library[ "other" ] then 
                library[ "other" ]:Destroy()
            end 
            
            for index, connection in library.connections do 
                connection:Disconnect() 
                connection = nil 
            end
            
            library = nil 
        end 
    --
    
    -- Library element functions
        function library:window(properties)
            local cfg = { 
                -- Properties
                name = properties.name or properties.Name or "nebula";
                size = properties.size or properties.Size or dim2(0, 650, 0, 400);
                logo = properties.logo or properties.Logo or "rbxassetid://128155293790451";

                selected_tab;
                items = {};
                tweening;
            }
            
            library[ "items" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            });
            
            library[ "other" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            local items = cfg.items; do
                items[ "window" ] = library:create( "Frame" , {
                    Parent = library.items;
                    Name = "\0";
                    Visible = false;
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = cfg.size;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                }); items[ "window" ].Position = dim2(0, items[ "window" ].AbsolutePosition.X, 0, items[ "window" ].AbsolutePosition.Y)          

                items[ "top_frame" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "window" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 45);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "logo" ] = library:create( "ImageLabel" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "top_frame" ];
                    Name = "\0";
                    Image = cfg.logo;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 16, 0, 7);
                    Size = dim2(0, 32, 0, 32);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "ui_title" ] = library:create( "TextLabel" , {
                    FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = rgb(255, 255, 255);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = cfg.name;
                    Parent = items[ "top_frame" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BorderColor3 = rgb(0, 0, 0);
                    TextSize = 35;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "window" ];
                    Name = "\0";
                    Position = dim2(0, 0, 0, 44);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 63, 1, -44);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "tab_button_holder" ] = library:create( "Frame" , {
                    Parent = items[ "inline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 14)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "tab_button_holder" ];
                    PaddingTop = dim(0, 37)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "tab_button_holder" ];
                    Padding = dim(0, 24);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                items[ "page_holder" ] = library:create( "Frame" , {
                    Parent = items[ "window" ];
                    Name = "\0";
                    Position = dim2(0, 63, 0, 45);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -63, 1, -45);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(12, 12, 12)
                });                
            end 

            do -- Other
                library:draggify(items[ "window" ])
                library:resizify(items[ "window" ])
            end 
            
            function cfg.toggle_menu(bool) 
                if cfg.tweening then 
                    return 
                end 

                cfg.tweening = true 

                if bool then 
                    items[ "window" ].Visible = true
                end

                local Children = items[ "window" ]:GetDescendants()
                table.insert(Children, items[ "window" ])

                local Tween;
                for _,obj in Children do
                    local Index = library:get_transparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = library:fade(obj, prop, bool)
                        end
                    else
                        Tween = library:fade(obj, Index, bool)
                    end
                end

                library:connection(Tween.Completed, function()
                    cfg.tweening = false
                    items[ "window" ].Visible = bool
                end)
            end 
                
            return setmetatable(cfg, library)
        end 

        function library:Tab(properties)
            local cfg = {
                -- properties
                name = properties.name or properties.Name or "visuals"; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6034767608";
                
                items = {};
            } 

            local items = cfg.items; do                
                -- Tab buttons 
                    items[ "tab_button" ] = library:create( "TextButton" , {
                        Parent = self.items[ "tab_button_holder" ];
                        BackgroundTransparency = 1;
                        Text = "";
                        Size = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "image" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(128, 128, 128);
                        Active = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "tab_button" ];
                        Name = "\0";
                        Size = dim2(0, 32, 0, 32);
                        AnchorPoint = vec2(0.5, 0);
                        Image = cfg.icon;
                        BackgroundTransparency = 1;
                        Position = dim2(0.5, 0, 0, 0);
                        Selectable = true;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });                       
                -- 

                -- Page directory
                    items[ "tab" ] = library:create( "Frame" , {
                        Parent = library.items;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = items[ "tab" ];
                        Padding = dim(0, 21);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingTop = dim(0, 24);
                        PaddingBottom = dim(0, 21);
                        Parent = items[ "tab" ];
                        PaddingRight = dim(0, 21);
                        PaddingLeft = dim(0, 21)
                    });     
                    
                    for _,column in {"left", "right"} do 
                        items[ column ] = library:create( "Frame" , {
                            Parent = items[ "tab" ];
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 100, 0, 100);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(8, 8, 8)
                        }); 
                    end                  
                -- 
            end 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                
                if selected_tab then 
                   selected_tab[ 1 ].ImageColor3 = rgb(128, 128, 128)
                   selected_tab[ 2 ].Parent = library.items
                   selected_tab[ 2 ].Visible = false
                end
                
                items.image.ImageColor3 = rgb(255, 255, 255)
                items.tab.Parent = self.items[ "page_holder" ]
                items.tab.Visible = true

                self.selected_tab = {
                    items.image;
                    items.tab;
                }

                library:close_current_element(nil) 
            end

            items[ "tab_button" ].MouseButton1Down:Connect(function()
                cfg.open_tab()
            end)

            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return setmetatable(cfg, library)
        end

        function library:Section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section"; 
                side = properties.side or properties.Side or "left";
                default = properties.default or properties.Default or false;
                size = properties.size or properties.Size or 0.5; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6022668898";
                fading_toggle = properties.fading or properties.Fading or false;
                items = {};
            };
            
            local items = cfg.items; do 
                items[ "section_outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Parent = self.items[ cfg.side ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(8, 8, 8)
                });
                
                items[ "section_shadow" ] = library:create( "Frame" , {
                    Parent = items[ "section_outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BackgroundTransparency = 1;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(5, 5, 5)
                });
                
                items[ "section_shadow_one" ] = library:create( "Frame" , {
                    Parent = items[ "section_shadow" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BackgroundTransparency = 1;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "section_shadow_two" ] = library:create( "Frame" , {
                    Parent = items[ "section_shadow_one" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "section_shadow_three" ] = library:create( "Frame" , {
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Parent = items[ "section_shadow_two" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 14)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "section_shadow_three" ];
                    CornerRadius = dim(0, 0)
                });
                
                items[ "scrolling" ] = library:create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(0, 0, 0);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 0;
                    Parent = items[ "section_shadow_three" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "scrolling" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 12, 0, 12);
                    Size = dim2(1, -24, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "section_shadow_two" ];
                    CornerRadius = dim(0, 0)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "section_shadow_one" ];
                    CornerRadius = dim(0, 0)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "section_shadow" ];
                    CornerRadius = dim(0, 0)
                });
                
                items.text = library:create( "TextLabel" , {
                    FontFace = library.font;
                    TextColor3 = rgb(178, 178, 178);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "section_outline" ];
                    BackgroundTransparency = 1;
                    Position = dim2(0, 8, 0, -15);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 10;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items.line = library:create( "Frame" , {
                    Parent = items.text;
                    Position = dim2(0, 0, 1, 2);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                

                library:create( "UIStroke" , {
                    Parent = items.text;
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "section_outline" ];
                    CornerRadius = dim(0, 0)
                });                
            end;

            items[ "section_outline" ].MouseEnter:Connect(function()
                for _,instance in items[ "section_outline" ]:GetDescendants() do 
                    if instance:IsA("UICorner") then 
                        library:tween(instance, {CornerRadius = dim(0, 8)})
                    end 
                end 

                for _,section in {"section_shadow_three", "section_shadow_two", "section_shadow_one", "section_shadow"} do 
                    library:tween(items[ section ], {BackgroundTransparency = 0})
                end 
                
                library:tween(items.line, {Size = dim2(1, 0, 0, 1)})
                library:tween(items.text, {TextColor3 = rgb(255, 255, 255)})
            end)

            items[ "section_outline" ].MouseLeave:Connect(function()
                for _,instance in items[ "section_outline" ]:GetDescendants() do 
                    if instance:IsA("UICorner") then 
                        library:tween(instance, {CornerRadius = dim(0, 0)})
                    end 
                end 

                for _,section in {"section_shadow_three", "section_shadow_two", "section_shadow_one", "section_shadow"} do 
                    library:tween(items[ section ], {BackgroundTransparency = 1})
                end

                library:tween(items.line, {Size = dim2(0, 0, 0, 1)})
                library:tween(items.text, {TextColor3 = rgb(178, 178, 178)})
            end)

            return setmetatable(cfg, library)
        end  

        function library:Toggle(options) 
            local cfg = {
                enabled = options.enabled or options.Enabled or nil,
                name = options.name or options.Name or "Toggle",
                flag = options.flag or options.Flag or options.name or options.Name or "please set me a flag 🥺",
                
                default = options.default or options.Default or false,
                callback = options.callback or options.Callback or function() end,

                items = {};
            }

            local items = cfg.items; do 
                items[ "object" ] = library:create( "TextButton" , {
                    Parent = self.items[ "elements" ];
                    Text = "";
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 12);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    -- AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "toggle_outline" ] = library:create( "Frame" , {
                    Parent = items[ "object" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "toggle_shading" ] = library:create( "Frame" , {
                    Parent = items[ "toggle_outline" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(92, 92, 92)
                });
                
                items[ "toggle_inline" ] = library:create( "Frame" , {
                    Parent = items[ "toggle_shading" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(54, 54, 54)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "object" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "text" ] = library:create( "TextLabel" , {
                    FontFace = library.font;
                    TextColor3 = rgb(178, 178, 178);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "object" ];
                    BackgroundTransparency = 1;
                    Position = dim2(0, 12, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 10;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIStroke" , {
                    Parent = items[ "text" ]
                });
                
                library:create( "UIPadding" , {
                    PaddingLeft = dim(0, 1);
                    Parent = items[ "text" ]
                });
            end;
            
            function cfg.set(bool)
                library:tween(items[ "text" ], {TextColor3 = bool and rgb(255, 255, 255) or rgb(178, 178, 178)})
                library:tween(items[ "toggle_outline" ], {BackgroundTransparency = bool and 0 or 1})
                library:tween(items[ "toggle_shading" ], {BackgroundTransparency = bool and 0 or 1})
                library:tween(items[ "toggle_inline" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(74, 74, 74)})

                cfg.callback(bool)
                
                flags[cfg.flag] = bool
            end 
            
            items[ "object" ].MouseButton1Click:Connect(function()
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            
            cfg.set(cfg.default)

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 
        
        function library:Slider(options) 
            local cfg = {
                -- Options
                name = options.name or options.Name or nil;
                suffix = options.suffix or options.Suffix or "";
                flag = options.flag or options.Flag or options.name or options.Name or "please set me a flag 🥺";
                callback = options.callback or options.Callback or function() end; 
                show_value = options.ShowValue or options.show_value or true; 

                -- value settings
                min = options.min or options.minimum or options.Min or options.Minimum or 0;
                max = options.max or options.maximum or options.Max or options.Maximum or 100;
                intervals = options.interval or options.decimal or options.Interval or options.Decimal or 1;
                default = options.default or options.Default or 10;
                value = options.default or options.default or 10; 

                -- ignore
                dragging = false;
                items = {}
            } 

            local items = cfg.items; do
                items[ "object" ] = library:create( "Frame" , {
                    Parent = self.items.object or self.items.elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(0, 0, 0, 12);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "object" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "slider_parent" ] = library:create( "TextButton" , {
                    Parent = items[ "object" ];
                    BackgroundTransparency = 1;
                    Text = "";
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 100, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "slider_holder" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 0.5);
                    Parent = items[ "slider_parent" ];
                    Name = "\0";
                    Position = dim2(0, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 5);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "gradient_holder" ] = library:create( "Frame" , {
                    Parent = items[ "slider_holder" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIGradient" , {
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(93, 93, 93))};
                    Parent = items[ "gradient_holder" ]
                });
                
                items[ "slider" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 0.5);
                    Parent = items[ "gradient_holder" ];
                    Name = "\0";
                    Position = dim2(0, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 4, 0, 9);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "slider" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if cfg.name then
                    items[ "name" ] = setmetatable(cfg, library):Label({padding_top = 1})
                end

                if cfg.show_value then 
                    items[ "value" ] = setmetatable(cfg, library):Label({padding_top = 1})
                end       
            end 

            function cfg.set(value)
                cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)
                
                items[ "slider" ].Position = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 0.5, 0)

                if items[ "value" ] then
                    items[ "value" ].set(tostring(cfg.value) .. cfg.suffix)
                end

                flags[cfg.flag] = cfg.value
                cfg.callback(flags[cfg.flag])
            end

            items[ "slider_parent" ].MouseButton1Down:Connect(function()
                cfg.dragging = true 
            end)

            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                    local size_x = (input.Position.X - items[ "gradient_holder" ].AbsolutePosition.X) / items[ "gradient_holder" ].AbsoluteSize.X
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    cfg.dragging = false
                end 
            end)
            
            cfg.set(cfg.default)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:Dropdown(options) 
            local cfg = {
                obj_type = "dropdown";

                -- Options
                name = options.name or options.Name or nil;
                flag = options.flag or options.Flag or options.name or options.Name or "please set me a flag 🥺";
                options = options.items or options.Items or {"1", "2", "3"};
                callback = options.callback or options.Callback or function() end;
                multi = options.multi or options.Multi or false;

                -- Ignore these 
                open = false;
                option_instances = {};
                multi_items = {};
                items = {};
            }   

            cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"
            flags[cfg.flag] = cfg.default
            
            local items = cfg.items; do 
                -- Element
                    items[ "object" ] = library:create( "Frame" , {
                        Parent = self.items.object or self.items.elements;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 12);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    if self.items.object then 
                        library:create( "UIPadding" , {
                            Parent = items[ "object" ];
                            PaddingTop = dim(0, -2)
                        });                        
                    end 
                    
                    items[ "dropdown_outline" ] = library:create( "TextButton" , {
                        Parent = items[ "object" ];
                        Text = "";
                        AutoButtonColor = false;
                        Name = "\0";
                        Size = dim2(0, 0, 0, 16);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "dropdown_shading" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_outline" ];
                        Size = dim2(0, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "dropdown_shading" ];
                        Color = rgbseq{rgbkey(0, rgb(33, 33, 33)), rgbkey(1, rgb(8, 8, 8))}
                    });
                    
                    items.inner_text = library:create( "TextLabel" , {
                        FontFace = library.font;
                        TextColor3 = rgb(178, 178, 178);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Combat";
                        Parent = items[ "dropdown_shading" ];
                        AnchorPoint = vec2(0, 0.5);
                        Size = dim2(1, 0, 1, 0);
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0.5, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 10;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIStroke" , {
                        Parent = items[ "TextLabel" ]
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "TextLabel" ]
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "dropdown_shading" ];
                        PaddingRight = dim(0, 40);
                        PaddingLeft = dim(0, 40)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingRight = dim(0, 1);
                        Parent = items[ "dropdown_outline" ]
                    });
                    
                    items[ "arrow" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(178, 178, 178);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "dropdown_outline" ];
                        Name = "\0";
                        AnchorPoint = vec2(1, 0.5);
                        Image = "rbxassetid://76667213487638";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -4, 0.5, 0);
                        Size = dim2(0, 7, 0, 4);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "object" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        FillDirection = Enum.FillDirection.Horizontal
                    });
                -- 

                -- Element Holder
                    items[ "dropdown_holder" ] = library:create( "Frame" , {
                        Parent = library.items;
                        Size = dim2(0, 114, 0, 0);
                        Visible = false;
                        Name = "\0";
                        Position = dim2(0.05823293328285217, 0, 0.19430045783519745, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "dropdown_shading" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_holder" ];
                        Size = dim2(1, -2, 0, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "dropdown_shading" ];
                        Color = rgbseq{rgbkey(0, rgb(33, 33, 33)), rgbkey(1, rgb(8, 8, 8))}
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "dropdown_shading" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 5);
                        PaddingTop = dim(0, 5);
                        Parent = items[ "dropdown_shading" ]
                    });            
                -- 
            end 

            function cfg.render_option(text)
                local button = library:create( "TextButton" , {
                    FontFace = library.font;
                    TextColor3 = rgb(178, 178, 178);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = items[ "dropdown_shading" ];
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Center;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 10;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIStroke" , {
                    Parent = button
                });
                
                library:create( "UIPadding" , {
                    Parent = button
                });

                return button
            end
            
            function cfg.set_visible(bool)
                local a = bool and cfg.y_size or 0
                items[ "dropdown_holder" ].Visible = bool 
                items[ "arrow" ].Rotation = bool and 180 or 0

                items[ "dropdown_holder" ].Size = dim2(0, items.dropdown_outline.AbsoluteSize.X, 0, 0)
                items[ "dropdown_holder" ].Position = dim2(0, items.dropdown_outline.AbsolutePosition.X, 0, items.dropdown_outline.AbsolutePosition.Y + 75)
                
                library.current = cfg
            end
            
            function cfg.set(value)
                local selected = {}
                local isTable = type(value) == "table"

                for _, option in cfg.option_instances do 
                    if option.Text == value or (isTable and find(value, option.Text)) then 
                        insert(selected, option.Text)
                        cfg.multi_items = selected
                        option.TextColor3 = rgb(255, 255, 255)
                    else
                        option.TextColor3 = rgb(174, 174, 174)
                    end
                end

                items.inner_text.Text = if isTable then concat(selected, ", ") else selected[1] or ""
                flags[cfg.flag] = if isTable then selected else selected[1]
                
                cfg.callback(flags[cfg.flag]) 
            end
            
            function cfg.refresh_options(list) 
                for _, option in cfg.option_instances do 
                    option:Destroy() 
                end
                
                cfg.option_instances = {} 

                for _, option in list do 
                    local button = cfg.render_option(option)
                    insert(cfg.option_instances, button)
                    
                    button.MouseButton1Down:Connect(function()
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                end
            end

            items.dropdown_outline.MouseButton1Click:Connect(function()
                cfg.open = not cfg.open
                cfg.set_visible(cfg.open)
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not (library:mouse_in_frame(items.dropdown_holder) or library:mouse_in_frame(items.object)) then 
                        cfg.open = false
                        cfg.set_visible(false)
                    end
                end
            end)
            
            flags[cfg.flag] = {} 
            config_flags[cfg.flag] = cfg.set
            
            cfg.refresh_options(cfg.options)
            cfg.set(cfg.default)

            local set = setmetatable(cfg, library)

            if cfg.name then 
                set:Label({name = cfg.name, padding_bottom = 2})
            end 

            return set
        end

        function library:Label(options)
            local cfg = {
                name = options.Name or options.name or "Label",

                -- ignore
                padding_top = options.PaddingTop or options.padding_top or 0; -- used because roblox cant make proper layouts
                padding_top = options.PaddingBottom or options.padding_bottom or 0;

                items = {};
            }

            local items = cfg.items; do 
                items[ "object" ] = library:create( "TextButton" , {
                    Parent = self.items.object or self.items.elements;
                    Text = "";
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 12);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                items.text = library:create( "TextLabel" , {
                    FontFace = library.font;
                    TextColor3 = rgb(178, 178, 178);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    RichText = true;
                    Parent = items.object;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 12, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 10;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                library:create( "UIListLayout" , {
                    Parent = items[ "object" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });

                library:create( "UIStroke" , {
                    Parent = items.text
                });

                library:create( "UIPadding" , {
                    PaddingLeft = dim(0, 1);
                    PaddingTop = dim(0, cfg.padding_top);
                    PaddingBottom = dim(0, cfg.padding_bottom);
                    Parent = items.text
                });
            end 

            function cfg.set(text)
                items.text.Text = text
            end

            return setmetatable(cfg, library)
        end 
        
        function library:Colorpicker(options) 
            local cfg = {
                -- options
                name = options.name or options.Name or "", 
                flag = options.flag or options.Flag or options.name or options.Name or "please set me a flag 🥺",
                color = options.color or options.Color or color(1, 1, 1), -- Default to white color if not provided
                alpha = (options.alpha and 1 - options.alpha) or (options.Alpha and 1 - options.Alpha) or 0,
                callback = options.callback or options.Callback or function() end,

                -- ignore
                open = false, 
                items = {};
            }

            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

            local items = cfg.items; do 
                -- Component
                    items[ "gear_holder" ] = library:create( "TextButton" , {
                        Parent = self.items.object;
                        AutoButtonColor = false;
                        Text = "";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "gear" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(178, 178, 178);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "gear_holder" ];
                        Image = "rbxassetid://99473719385675";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "gear_holder" ];
                        PaddingTop = dim(0, -1)
                    });                
                --
                
                -- Colorpicker
                    items[ "colorpicker_outline" ] = library:create( "Frame" , {
                        Parent = library.items;
                        Visible = false;
                        Size = dim2(0, 161, 0, 180);
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 100;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "_" ] = library:create( "UICorner" , {
                        Parent = items[ "colorpicker_outline" ];
                        Name = "\0";
                        CornerRadius = dim(0, 0)
                    });
                    
                    items[ "colorpicker_inline" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_outline" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(32, 32, 32)
                    });
                    
                    items[ "_" ] = library:create( "UICorner" , {
                        Parent = items[ "colorpicker_inline" ];
                        Name = "\0";
                        CornerRadius = dim(0, 0)
                    });
                    
                    items[ "colorpicker_background" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_inline" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(8, 8, 8)
                    });
                    
                    items[ "_" ] = library:create( "UICorner" , {
                        Parent = items[ "colorpicker_background" ];
                        Name = "\0";
                        CornerRadius = dim(0, 0)
                    });
                    
                    items[ "_" ] = library:create( "UIPadding" , {
                        PaddingTop = dim(0, 18);
                        Name = "\0";
                        PaddingBottom = dim(0, 3);
                        Parent = items[ "colorpicker_background" ];
                        PaddingRight = dim(0, 3);
                        PaddingLeft = dim(0, 3)
                    });
                    
                    items[ "saturation_outline" ] = library:create( "TextButton" , {
                        Name = "\0";
                        AutoButtonColor = false;
                        Text = "";
                        Parent = items[ "colorpicker_background" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -12, 1, -12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "color_saturation" ] = library:create( "Frame" , {
                        Parent = items[ "saturation_outline" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 39, 39)
                    });
                    
                    items[ "sat" ] = library:create( "Frame" , {
                        Parent = items[ "color_saturation" ];
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = items[ "sat" ];
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    items[ "satval_picker" ] = library:create( "Frame" , {
                        Parent = items[ "color_saturation" ];
                        Size = dim2(0, 3, 0, 3);
                        Name = "\0";
                        Position = dim2(0, 1, 0.5, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 4;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "_" ] = library:create( "Frame" , {
                        Parent = items[ "satval_picker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "val" ] = library:create( "Frame" , {
                        Name = "\0";
                        Parent = items[ "color_saturation" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Parent = items[ "val" ];
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    items[ "hue_slider" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_background" ];
                        Name = "\0";
                        AutoButtonColor = false;
                        Text = "";
                        Position = dim2(1, -10, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 10, 1, -12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "hue_components" ] = library:create( "Frame" , {
                        Parent = items[ "hue_slider" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "_" ] = library:create( "UIGradient" , {
                        Rotation = 270;
                        Parent = items[ "hue_components" ];
                        Name = "\0";
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))}
                    });
                    
                    items[ "hue_picker" ] = library:create( "Frame" , {
                        Parent = items[ "hue_components" ];
                        Size = dim2(1, 2, 0, 3);
                        Name = "\0";
                        Position = dim2(0, -1, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 4;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "_" ] = library:create( "Frame" , {
                        Parent = items[ "hue_picker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "alpha_slider" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_background" ];
                        Name = "\0";
                        AutoButtonColor = false;
                        Text = "";
                        Position = dim2(0, 0, 1, -10);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -12, 0, 10);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "alpha_components" ] = library:create( "Frame" , {
                        Parent = items[ "alpha_slider" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "_" ] = library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))};
                        Name = "\0";
                        Parent = items[ "alpha_components" ]
                    });
                    
                    items[ "alpha_picker" ] = library:create( "Frame" , {
                        Parent = items[ "alpha_components" ];
                        Size = dim2(0, 3, 1, 2);
                        Name = "\0";
                        Position = dim2(0, -1, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 4;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "_" ] = library:create( "Frame" , {
                        Parent = items[ "alpha_picker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "visualize_outline" ] = library:create( "Frame" , {
                        AnchorPoint = vec2(1, 1);
                        Parent = items[ "colorpicker_background" ];
                        Name = "\0";
                        Position = dim2(1, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 10, 0, 10);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "visualizer" ] = library:create( "Frame" , {
                        Parent = items[ "visualize_outline" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(123, 83, 255)
                    });
                    
                    items[ "alpha_visualizer" ] = library:create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        ImageTransparency = 0.41999998688697815;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "visualizer" ];
                        Name = "\0";
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        
                        TileSize = dim2(0, 2, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "gear" ] = library:create( "ImageButton" , {
                        ImageColor3 = rgb(178, 178, 178);
                        AutoButtonColor = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "colorpicker_inline" ];
                        Name = "\0";
                        Image = "rbxassetid://99473719385675";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 4, 0, 3);
                        
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "TextLabel" , {
                        FontFace = library.font;
                        TextColor3 = rgb(178, 178, 178);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "colorpicker_outline" ];
                        BackgroundTransparency = 1;
                        Position = dim2(0, 20, 0, 5);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 10;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIStroke" , {
                        Parent = items[ "TextLabel" ]
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingLeft = dim(0, 1);
                        Parent = items[ "TextLabel" ]
                    });                
                --  
            end;

            function cfg.set_visible(bool) 
                items.colorpicker_outline.Visible = bool
                items.colorpicker_outline.Position = dim2(0, items.gear_holder.AbsolutePosition.X - 5, 0, items.gear_holder.AbsolutePosition.Y + items.gear_holder.AbsoluteSize.Y + 60 - 19)

                library.current = cfg
            end

            function cfg.set(color, alpha)
                if color then
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                local Color = Color3.fromHSV(h, s, v)
                
                items.hue_picker.Position = dim2(0, -1, 1 - h, -1)
                items.alpha_picker.Position = dim2(1 - a, -1, 0, -1)
                items.satval_picker.Position = dim2(s, -1, 1 - v, -1)

                items.color_saturation.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                items.color_saturation.BackgroundColor3 = Color3.fromHSV(h, 1, 1)

                items.alpha_visualizer.ImageTransparency = 1 - a 
                items.visualizer.BackgroundColor3 = Color

                flags[cfg.flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                cfg.callback(Color, a)
            end

            function cfg.update_color() 
                local mouse = uis:GetMouseLocation() 
                local offset = vec2(mouse.X, mouse.Y - gui_offset) 

                if dragging_sat then	
                    s = math.clamp((offset - items.sat.AbsolutePosition).X / items.sat.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - items.val.AbsolutePosition).Y / items.val.AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then
                    h = 1 - math.clamp((offset - items.hue_slider.AbsolutePosition).Y / items.hue_slider.AbsoluteSize.Y, 0, 1)
                elseif dragging_alpha then
                    a = 1 - math.clamp((offset - items.alpha_slider.AbsolutePosition).X / items.alpha_slider.AbsoluteSize.X, 0, 1)
                end

                cfg.set(nil, nil)
            end

            items.gear_holder.MouseButton1Click:Connect(function()
                cfg.set_visible(true)            
            end)

            items.gear.MouseButton1Click:Connect(function()
                cfg.set_visible(false)            
            end)

            uis.InputChanged:Connect(function(input)
                if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    cfg.update_color() 
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false  

                    if not (library:mouse_in_frame(items.gear_holder) or library:mouse_in_frame(items.colorpicker_outline)) then 
                        cfg.open = false
                        cfg.set_visible(false)
                    end
                end
            end)

            items.alpha_slider.MouseButton1Down:Connect(function()
                dragging_alpha = true 
            end)
            
            items.hue_slider.MouseButton1Down:Connect(function()
                dragging_hue = true 
            end)
            
            items.saturation_outline.MouseButton1Down:Connect(function()
                print("hiu")
                dragging_sat = true  
            end)

            cfg.set(cfg.color, cfg.alpha)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:Textbox(options) 
            local cfg = {
                name = options.name or options.Name or "TextBox",
                placeholder = options.placeholder or options.PlaceHolder or "type here...",
                default = options.default or options.Default or "",
                flag = options.flag or options.name or "please set me a flag 🥺",
                callback = options.callback or options.Callback or function() end,
                visible = options.visible or true,
                items = {};
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                items[ "object" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 16);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "textbox_outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "object" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 20);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "textbox_shading" ] = library:create( "Frame" , {
                    Parent = items[ "textbox_outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "textbox" ] = library:create( "TextBox" , {
                    FontFace = library.font;
                    Active = false;
                    Selectable = false;
                    PlaceholderText = cfg.placeholder;
                    TextSize = 10;
                    Size = dim2(1, 0, 1, 0);
                    TextColor3 = rgb(180, 180, 180);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = items[ "textbox_shading" ];
                    Name = "\0";
                    CursorPosition = -1;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    TextWrapped = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    PaddingLeft = dim(0, 7);
                    Parent = items[ "textbox" ]
                });
                
                library:create( "UIStroke" , {
                    Parent = items[ "textbox" ]
                });
                
                library:create( "UIGradient" , {
                    Rotation = 90;
                    Parent = items[ "textbox_shading" ];
                    Color = rgbseq{rgbkey(0, rgb(33, 33, 33)), rgbkey(1, rgb(8, 8, 8))}
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "object" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                
            end 
            
            function cfg.set(text) 
                if type(text) == "boolean" then 
                    return 
                end 

                flags[cfg.flag] = text

                items[ "textbox" ].Text = text

                cfg.callback(text)
            end 
            
            items[ "textbox" ]:GetPropertyChangedSignal("Text"):Connect(function()
                cfg.set(items[ "textbox" ].Text) 
            end)

            items[ "textbox" ].Focused:Connect(function()
                library:tween(items[ "textbox" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "textbox" ].FocusLost:Connect(function()
                library:tween(items[ "textbox" ], {TextColor3 = rgb(72, 72, 72)})
            end)
                
            if cfg.default then 
                cfg.set(cfg.default) 
            end

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:Keybind(options) 
            local cfg = {
                -- options
                flag = options.flag or options.Flag or options.name or options.Name or "please set me a flag 🥺",
                callback = options.callback or options.Callback or function() end,
                name = options.name or options.Name or nil, 
                key = options.key or options.Key or nil, 
                mode = options.mode or options.Mode or "Toggle",
                active = options.default or options.Default or false, 

                -- ignore
                open = false,
                binding = nil, 
                hold_instances = {},
                items = {};
            }

            flags[cfg.flag] = {
                mode = cfg.mode,
                key = cfg.key, 
                active = cfg.active
            }

            local items = cfg.items; do 
                -- Component
                    items.text_label = library:create( "TextButton" , {
                        FontFace = library.font;
                        AutoButtonColor = false;
                        TextColor3 = rgb(178, 178, 178);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "J";
                        Parent = self.items.object;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 10;
                        BackgroundColor3 = rgb(38, 38, 38)
                    });

                    library:create( "UIStroke" , {
                        Parent = items.text_label
                    });

                    library:create( "UIPadding" , {
                        Parent = items.text_label;
                        PaddingRight = dim(0, 4);
                        PaddingLeft = dim(0, 4)
                    });

                    if cfg.name then
                        self:Label({Name = cfg.name})
                    end 
                -- 
                
                -- Mode Holder
                    items[ "modes" ] = library:create( "Frame" , {
                        Parent = library.items;
                        Visible = false;
                        Size = dim2(0, 114, 0, 0);
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "mode_shading" ] = library:create( "Frame" , {
                        Parent = items[ "modes" ];
                        Size = dim2(0, -2, 0, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "mode_shading" ];
                        Color = rgbseq{rgbkey(0, rgb(33, 33, 33)), rgbkey(1, rgb(8, 8, 8))}
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "mode_shading" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 5);
                        PaddingTop = dim(0, 5);
                        Parent = items[ "mode_shading" ]
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingRight = dim(0, 1);
                        Parent = items[ "modes" ]
                    });
                    
                
                    local options = {"Hold", "Toggle", "Always"}
                    
                    for _,option in options do
                        local name = library:create( "TextButton" , {
                            FontFace = library.font;
                            AutoButtonColor = false;
                            TextColor3 = rgb(178, 178, 178);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = option;
                            Parent = items[ "mode_shading" ];
                            BackgroundTransparency = 1;
                            Size = dim2(1, 0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 10;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.hold_instances[option] = name
                        
                        library:create( "UIStroke" , {
                            Parent = items[ "TextLabel" ]
                        });
                        
                        library:create( "UIPadding" , {
                            PaddingLeft = dim(0, 5);
                            Parent = items[ "TextLabel" ]
                        });
                                                
                        -- cfg.y_size += name.AbsoluteSize.Y

                        library:create( "UIPadding" , {
                            Parent = name;
                            PaddingTop = dim(0, 1);
                            PaddingRight = dim(0, 5);
                            PaddingLeft = dim(0, 5)
                        });

                        name.MouseButton1Click:Connect(function()
                            cfg.set(option)
                            cfg.set_visible(false)
                            cfg.open = false
                        end)
                    end
                -- 
            end 
            
            function cfg.modify_mode_color(path) -- ts so frikin tuff 💀
                for _,v in cfg.hold_instances do 
                    v.TextColor3 = rgb(178, 178, 178)
                end 

                cfg.hold_instances[path].TextColor3 = rgb(255, 255, 255)
            end

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "Always" then
                    cfg.set(true)
                elseif mode == "Hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                cfg.modify_mode_color(mode)
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    cfg.active = input

                    if cfg.mode == "Always" then 
                        cfg.active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    cfg.key = input or "NONE"	
                elseif find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        cfg.active = true 
                    end 

                    cfg.mode = input
                    cfg.set_mode(cfg.mode) 
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
                    input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key

                    cfg.key = input.key or "NONE"
                    cfg.mode = input.mode or "Toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    cfg.set_mode(cfg.mode) 
                end 

                cfg.callback(cfg.active)

                local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                
                items.text_label.Text = __text

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
            end

            function cfg.set_visible(bool)
                -- local size = bool and cfg.y_size or 0
                -- library:tween(items.object, {Size = dim_offset(items.text_label.AbsoluteSize.X, size)})
                items.modes.Visible = bool 
                items.modes.Position = dim_offset(items.text_label.AbsolutePosition.X + items.text_label.AbsoluteSize.X + 5, items.text_label.AbsolutePosition.Y + 58)

                library.current = cfg
            end
            
            items.text_label.MouseButton1Down:Connect(function()
                task.wait()
                items.text_label.Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            items.text_label.MouseButton2Down:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == cfg.key then 
                        if cfg.mode == "Toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "Hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)    

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "Hold" then 
                        cfg.set(false)
                    end
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not (library:mouse_in_frame(items[ "modes" ]) or library:mouse_in_frame(items.text_label)) then 
                        cfg.open = false
                        cfg.set_visible(false)
                    end
                end
            end)
            
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:Button(options) 
            local cfg = {
                -- options
                name = options.name or options.Name or "TextBox",
                callback = options.callback or options.Callback or function() end,

                -- ignore
                items = {};
            }
            
            local items = cfg.items; do 
                items[ "button" ] = library:create( "TextButton" , {
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    AutoButtonColor = false;
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 16);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "button_outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "button" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 20);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                items[ "button_shading" ] = library:create( "Frame" , {
                    Parent = items[ "button_outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIGradient" , {
                    Rotation = 90;
                    Parent = items[ "button_shading" ];
                    Color = rgbseq{rgbkey(0, rgb(33, 33, 33)), rgbkey(1, rgb(8, 8, 8))}
                });
                
                items[ "button_text" ] = library:create( "TextLabel" , {
                    FontFace = library.font;
                    TextColor3 = rgb(178, 178, 178);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button_shading" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 10;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIStroke" , {
                    Parent = items[ "button_text" ]
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "button" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                             
            end 

            items[ "button" ].MouseButton1Click:Connect(function()
                cfg.callback()

                items[ "button_text" ].TextColor3 = rgb(255, 255, 255) 
                library:tween(items[ "button_text" ], {TextColor3 = rgb(178, 178, 178)})
            end)
            
            return setmetatable(cfg, library)
        end

        function library:list(properties) 
            local cfg = {
                items = {};
                options = properties.options or {"1", "2", "3"};
                flag = properties.flag or options.name or "please set me a flag 🥺";    
                callback = properties.callback or function() end;
                data_store = {};        
                current_element;
            }

            local items = cfg.items; do
                items[ "list" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "list" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "list" ];
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });
            end 

            function cfg.refresh_options(options_to_refresh) -- ignore goofy parameter
                for _,option in cfg.data_store do 
                    option:Destroy()
                end

                for _, option_data in options_to_refresh do -- haha u skids no next >_<
                    local button = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "list" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); cfg.data_store[#cfg.data_store + 1] = button;

                    local name = library:create( "TextLabel" , {
                        FontFace = library.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = option_data;
                        Parent = button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = button;
                        CornerRadius = dim(0, 3)
                    });     

                    button.MouseButton1Click:Connect(function()
                        local current = cfg.current_element 
                        if current and current ~= name then 
                            library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                        end

                        flags[cfg.flag] = option_data
                        cfg.callback(option_data)
                        library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                        cfg.current_element = name
                    end)

                    name.MouseEnter:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(140, 140, 140)})
                    end)

                    name.MouseLeave:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(72, 72, 72)})
                    end)
                end
            end

            cfg.refresh_options(cfg.options)

            return setmetatable(cfg, library)
        end 

        function library:init_config(window) 
            local textbox;
            local main = window:Tab({name = "Configs", icon = "rbxassetid://72506063321241"})
            local section = main:Section({name = "Settings", side = "right", size = 1, default = true})
            config_holder = section:Dropdown({Name = "Configs", options = {"Report", "This", "Error", "To", "Finobe"}, callback = function(option) if textbox then textbox.set(option) end end, flag = "config_name_list"}); library:update_config_list()
            textbox = section:Textbox({name = "Config name:", flag = "config_name_text"})
            section:Button({name = "Save", callback = function() writefile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg", library:get_config()) library:update_config_list() end}) 
            section:Button({name = "Load", callback = function() library:load_config(readfile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg"))  library:update_config_list() end})
            section:Button({name = "Delete", callback = function() delfile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg")  library:update_config_list() end})
            
            window.tweening = true 
            section:Label({Name = "UI Bind"}):Keybind({callback = function(bool) window.toggle_menu(bool) print(window.tweening) end, default = false})
        end
    --

    -- Notification library
		local notifications = library.notifications

		function notifications:refresh_notifs() 
			local yOffset = 50
			for i, v in notifications.notifs do
				local Position = vec2(20, yOffset)
				tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = dim_offset(Position.X, Position.Y)}):Play()
				yOffset = yOffset + v.AbsoluteSize.Y + 10
			end
		end
		
		function notifications:fade(path, is_fading)
			local fading = is_fading and 1 or 0 
			
			tween_service:Create(path, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = fading}):Play()

			for _, instance in path:GetDescendants() do 
				if instance:IsA("UIStroke") then
					tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = fading}):Play()
				elseif instance:IsA("TextLabel") then
					tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = fading}):Play()
				elseif instance:IsA("Frame") then
					tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = fading}):Play()
				end
			end
		end 

		function notifications:create_notification(options)
			local cfg = {
				name = options.name or "Hit: q3sm (finobe) in the Head for 100 Damage!",
				color = options.color or rgb(255, 255, 255);
				clickable = options.click or false;
			}
			
			-- Instances
				local outline = library:create("TextButton", {
					Parent = library.items;
					Size = dim2(0, 0, 0, 0);
					BorderColor3 = rgb(0, 0, 0);
					BorderSizePixel = 0;
					AutoButtonColor = false;
					Text = "";
					AutomaticSize = Enum.AutomaticSize.XY;
					BackgroundColor3 = rgb(46, 46, 46)
				});

				local inline = library:create("Frame", {
					Parent = outline;
					Position = dim2(0, 1, 0, 1);
					BorderColor3 = rgb(0, 0, 0);
					BorderSizePixel = 0;
					AutomaticSize = Enum.AutomaticSize.XY;
					BackgroundColor3 = rgb(21, 21, 21)
				});	
				
				local uigradient = library:create("UIGradient", {
					Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
					Transparency = numseq{numkey(0, -1), numkey(1, -1)};
					Parent = menu_title
				});
				
				library:create("UIPadding", {
					PaddingTop = dim(0, 7);
					PaddingBottom = dim(0, 6);
					Parent = inline;
					PaddingRight = dim(0, 8);
					PaddingLeft = dim(0, 4)
				});
				
				local misc_text = library:create("TextLabel", {
					FontFace = library.font;
					Parent = inline;
					LineHeight = 1.75;
					TextColor3 = rgb(255, 255, 255);
					BorderColor3 = rgb(0, 0, 0);
					Text = cfg.name; -- string.format("[ cht name ] %s", cfg.name);
					AutomaticSize = Enum.AutomaticSize.XY;
					Size = dim2(1, -4, 1, 0);
					Position = dim2(0, 4, 0, -2);
					BackgroundTransparency = 1;
					TextXAlignment = Enum.TextXAlignment.Left;
					BorderSizePixel = 0;
					ZIndex = 2;
					TextSize = 10;
					BackgroundColor3 = rgb(255, 255, 255)
				});
				
				library:create("UIPadding", {
					PaddingBottom = dim(0, 1);
					PaddingRight = dim(0, 1);
					Parent = outline
				});

				local line = library:create( "Frame" , {
					Parent = outline;
					Name = "\0";
					Position = dim2(0, 1, 1, -1);
					BorderColor3 = rgb(0, 0, 0);
					Size = dim2(0, 0, 0, 1);
					BorderSizePixel = 0;
					BackgroundColor3 = cfg.color
				});
				
				local accent = library:create( "Frame" , {
					Parent = outline;
					Name = "\0";
					Position = dim2(0, 1, 0, 1);
					BorderColor3 = rgb(0, 0, 0);
					Size = dim2(0, 1, 1, -1);
					BorderSizePixel = 0;
					BackgroundColor3 = cfg.color
				});
			-- 
			
			local index = #notifications.notifs + 1
			notifications.notifs[index] = outline
			
			notifications:refresh_notifs()
			tween_service:Create(outline, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = vec2(0, 0)}):Play()
			
			for _, obj in outline:GetDescendants() do
                if obj:IsA("Frame") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                    library.fade(obj, "BackgroundTransparency", true)
        
                elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    library.fade(obj, "TextTransparency", true)
                    
                elseif obj:IsA("UIStroke") then
                    library.fade(obj, "Transparency", true)
        
                elseif obj:IsA("ScrollingFrame") then
                    library.fade(obj, "ScrollBarImageTransparency", true)
                end
            end
            print("fade1")

			outline.Position = dim2(0, 20, 0, #notifications.notifs * 20);

			if cfg.clickable then 
				outline.MouseButton1Click:Connect(function()
					notifications.notifs[index] = nil
					task.wait(1)
					outline:Destroy() 
					notifications:refresh_notifs()
				end)
			else 
                -- booty code
				task.spawn(function()
					tween_service:Create(line, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = dim2(1, -1, 0, 1)}):Play()
					task.wait(5)
                    print("fade2")
					notifications.notifs[index] = nil
					for _, obj in outline:GetDescendants() do
                        if obj:IsA("Frame") or obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
                            library.fade(obj, "BackgroundTransparency", false)
                
                        elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
                            library.fade(obj, "TextTransparency", false)
                
                        elseif obj:IsA("UIStroke") then
                            library.fade(obj, "Transparency", false)
                
                        elseif obj:IsA("ScrollingFrame") then
                            library.fade(obj, "ScrollBarImageTransparency", false)
                        end
                    end
					task.wait(1)
					outline:Destroy() 
					notifications:refresh_notifs()
				end)
			end
		end
	-- 
-- 

return library, notifications
