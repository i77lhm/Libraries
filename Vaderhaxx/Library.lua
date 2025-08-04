-- REASON: Discontinued nobody wanted to buy it either... I can see why vaderhaxx was super ugly lol 
-- Code from around october of 2024

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
        directory = "vaderhaxx",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},

        connections = {},   
        notifications = {},
        playerlist_data = {
            players = {},
            player = {}, 
        },
        colorpicker_open = false; 
        gui; 
    }

    local themes = {
        preset = {
            accent = rgb(255, 200, 69),
            text = rgb(255, 255, 255),
            text_outline = rgb(0, 0, 0),
            a = Color3.fromRGB(0, 0, 0),
            b = Color3.fromRGB(56, 56, 56),
            c = Color3.fromRGB(46, 46, 46),
            d = Color3.fromRGB(12, 12, 12),
            e = Color3.fromRGB(21, 21, 21),
            f = Color3.fromRGB(84, 84, 84),
            g = Color3.fromRGB(54, 54, 54),
        },

        utility = {
            accent = {BackgroundColor3 = {}, Color = {}, ScrollBarImageColor3 = {}, TextColor3 = {}},
            text = {
                TextColor3 = {},
                BackgroundColor3 = {},
            },
            text_outline = {
                Color = {} 	
            },
            a = {BackgroundColor3 = {}, Color = {}},
            b = {BackgroundColor3 = {}, Color = {}},
            c = {BackgroundColor3 = {}, Color = {}},
            d = {BackgroundColor3 = {}, Color = {}},
            e = {BackgroundColor3 = {}, Color = {}},
            f = {BackgroundColor3 = {}, Color = {}},
            g = {BackgroundColor3 = {}, Color = {}},
        }
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

    -- Font importing system 
        if not isfile(library.directory .. "/fonts/main.ttf") then 
            writefile(library.directory .. "/fonts/main.ttf", game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/ProggyClean.ttf"))
        end
        
        local proggy_clean = {
            name = "ProggyClean",
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
            writefile(library.directory .. "/fonts/main_encoded.ttf", http_service:JSONEncode(proggy_clean))
        end 
        
        library.font = Font.new(getcustomasset(library.directory .. "/fonts/main_encoded.ttf"), Enum.FontWeight.Regular)
    -- 
-- 

-- Library functions
    -- Misc functions
        function library:tween(obj, properties) 
            local tween = tween_service:Create(obj, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end 

        function library:close_current_element(cfg) 
            local path = library.current_element_open

            if path then
                path.set_visible(false)
                path.open = false 
            end
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
                    frame.Size = current_size
                end
            end)
        end

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        library.lerp = function(start, finish, t)
            t = t or 1 / 8

            return start * (1 - t) + finish * t
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

                    frame.Position = current_position
                end
            end)
        end 

        function library:convert(str)
            local items ={}

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
        
            for idx, file in next, listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
                list[#list + 1] = name
            end
            
            config_holder.refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
        
            for _, v in flags do
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
            
            for _, v in next, config do 
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

        function library:apply_theme(instance, theme, property) 
            insert(themes.utility[theme][property], instance)
        end

        function library:update_theme(theme, color)
            for _, property in themes.utility[theme] do 

                for m, object in property do 
                    if object[_] == themes.preset[theme] then 
                        object[_] = color 
                    end 
                end 
            end 

            themes.preset[theme] = color 
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:apply_stroke(parent) 
            -- local STROKE = library:create("UIStroke", {
            --     Parent = parent,
            --     Color = themes.preset.text_outline, 
            --     LineJoinMode = Enum.LineJoinMode.Miter
            -- }) 

            -- library:apply_theme(STROKE, "text_outline", "Color")
        end

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in next, options do 
                ins[prop] = value
            end
            
            if instance == "TextLabel" or instance == "TextButton" or instance == "TextBox" then 	
                library:apply_theme(ins, "text", "TextColor3")
                library:apply_stroke(ins)
            end
            
            return ins 
        end

        function library:unload_menu() 
            if library.gui then 
                library.gui:Destroy()
            end
            
            for index, connection in next, library.connections do 
                connection:Disconnect() 
                connection = nil 
            end     
            
            library = nil 
        end 
    --
        
    -- Library element functions
        function library:window(properties)
            local cfg = {
                name = properties.name or properties.Name or "sigmaware.hackpaste",
                size = properties.size or properties.Size or dim2(0, 560, 0, 740),
                selected_tab 
            }

            library.gui = library:create("ScreenGui", {
                Parent = coregui,
                Name = "\0",
                Enabled = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                IgnoreGuiInset = true,
            })

            -- Window
                local a = library:create("Frame", {
                    Parent = library.gui;
                    BackgroundTransparency = 1;
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = cfg.size;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:resizify(a); library:draggify(a); a.Position = dim2(0, a.AbsolutePosition.Y, 0, a.AbsolutePosition.Y)

                library:create("UIStroke", {
                    Parent = a;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });	library:apply_theme(UIStroke, "a", "Color")
                
                local b = library:create("Frame", {
                    Parent = a;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(56, 56, 56)
                });	library:apply_theme(b, "b", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(56, 56, 56);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = b;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "b", "Color")
                
                local c = library:create("Frame", {
                    Parent = b;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(c, "c", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(46, 46, 46);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = c;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "c", "Color")
                
                local c = library:create("Frame", {
                    Parent = c;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(c, "c", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(46, 46, 46);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = c;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "c", "Color")
                
                local b = library:create("Frame", {
                    Parent = c;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(b, "c", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(56, 56, 56);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = b;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "b", "Color")
                
                local a = library:create("Frame", {
                    Parent = b;
                    BackgroundTransparency = 0.3499999940395355;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });	library:apply_theme(a, "a", "BackgroundColor3")
                
                local tab_holder = library:create("Frame", {
                    Parent = a;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 17, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -34, 0, 28);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.tab_holder = tab_holder
                
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = tab_holder;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                local a = library:create("Frame", {
                    Parent = a;
                    Position = dim2(0, 17, 0, 31);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -34, 1, -46);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });	library:apply_theme(a, "a", "BackgroundColor3")
                
                local b = library:create("Frame", {
                    Parent = a;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(b, "c", "BackgroundColor3"); cfg.inline = b
            -- 

            -- Keybind list
                local keybindlist = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = library.gui;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 100, 0, 600);
                    Size = dim2(0, 202, 0, 66);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:resizify(keybindlist); library:draggify(keybindlist);
                
                library:create("UIStroke", {
                    Parent = keybindlist;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });	library:apply_theme(UIStroke, "a", "Color")
                
                local inline1 = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = keybindlist;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(56, 56, 56)
                });	library:apply_theme(inline1, "b", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(56, 56, 56);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = inline1;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "b", "Color")
                
                local inline2 = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = inline1;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(inline2, "c", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(46, 46, 46);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = inline2;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "c", "Color")
                
                local inline3 = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = inline2;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(inline3, "c", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(46, 46, 46);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = inline3;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "c", "Color")
                
                local inline4 = library:create("Frame", {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = inline3;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(inline4, "b", "BackgroundColor3")
                
                library:create("UIStroke", {
                    Color = rgb(56, 56, 56);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Parent = inline4;
                    Transparency = 0.25
                });	library:apply_theme(UIStroke, "b", "Color")
                
                local inline5 = library:create("Frame", {
                    Parent = inline4;
                    BackgroundTransparency = 0.3499999940395355;
                    Size = dim2(1, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(0, 0, 0)
                });	library:apply_theme(inline5, "a", "BackgroundColor3")
                
                local tab_holder = library:create("Frame", {
                    Parent = inline5;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 17, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 28);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIListLayout", {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = tab_holder;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                local button = library:create("TextButton", {
                    FontFace = library.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "keybinds";
                    Parent = tab_holder;
                    BackgroundTransparency = 1;
                    Size = dim2(0, 200, 0, 50);
                    BorderSizePixel = 0;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local accent = library:create("Frame", {
                    AnchorPoint = vec2(0, 1);
                    Parent = button;
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 4);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                }); library:apply_theme(accent, "accent", "BackgroundColor3")
                
                local split = library:create("Frame", {
                    AnchorPoint = vec2(0, 1);
                    Parent = accent;
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });
                
                library:create("UIGradient", {
                    Color = rgbseq{rgbkey(0, rgb(167, 167, 167)), rgbkey(1, rgb(167, 167, 167))};
                    Parent = split
                });
                
                local inline6 = library:create("Frame", {
                    Parent = inline5;
                    Size = dim2(1, -34, 0, 0);
                    Position = dim2(0, 17, 0, 31);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(0, 0, 0)
                });	library:apply_theme(inline6, "a", "BackgroundColor3")
                
                local inline7 = library:create("Frame", {
                    Parent = inline6;
                    Size = dim2(1, -2, 1, -2);
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(inline7, "b", "BackgroundColor3")
                
                local inline8 = library:create("Frame", {
                    Parent = inline7;
                    Size = dim2(1, -2, 1, -2);
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(21, 21, 21)
                });	library:apply_theme(inline8, "e", "BackgroundColor3"); library.keybind_list = inline8;
                
                library:create("UIListLayout", {
                    Parent = inline8;
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create("UIPadding", {
                    PaddingTop = dim(0, 8);
                    PaddingBottom = dim(0, 8);
                    Parent = inline8;
                    PaddingRight = dim(0, 2);
                    PaddingLeft = dim(0, 8)
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = inline7
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = inline6
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 10);
                    PaddingRight = dim(0, 34);
                    Parent = inline5
                });
                
                library:create("UIPadding", {
                    Parent = inline4
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = inline3
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = inline2
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = inline1
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 2);
                    PaddingRight = dim(0, 2);
                    Parent = keybindlist
                });                 
            -- 

            return setmetatable(cfg, library)
        end 

        function library:watermark(options)
            local cfg = {
                name = options.name or "nebulahax";
            }
            
            -- Instances
                local outline = library:create("Frame", {
                    Parent = library.gui;
                    Size = dim2(0, 0, 0, 18);
                    Position = dim2(0, 50, 0, 50);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(outline, "c", "BackgroundColor3");  library:draggify(outline)

                local inline = library:create("Frame", {
                    Parent = outline;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(21, 21, 21)
                });	library:apply_theme(inline, "e", "BackgroundColor3")
                
                local menu_title = library:create("TextLabel", {
                    FontFace = library.font;
                    Parent = inline;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "[ ] ";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, -4, 1, 0);
                    Position = dim2(0, 4, 0, -2);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
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
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "[                  ] | game : baseplate | ping : 32";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, -4, 1, 0);
                    Position = dim2(0, 4, 0, -2);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 1);
                    PaddingRight = dim(0, 1);
                    Parent = outline
                });
            --

            function cfg.update_text(text)
                misc_text.Text = "[ "
                
                for i = 1, string.len(cfg.name) do 
                    misc_text.Text ..= " "
                end  
                
                misc_text.Text ..= " ] fps: 1000 objects rendeed: 1000"
                menu_title.Text = "[ " .. cfg.name .. " ]"
            end 

            cfg.update_text("a")

            task.spawn(function()
                while true do
                    local offset = tick() * 0.2
                    
                    uigradient.Color = rgbseq{
                        rgbkey(0, hsv(offset % 1, 1, 1)), 
                        rgbkey(0.17, hsv((offset + 0.17) % 1, 1, 1)), 
                        rgbkey(0.33, hsv((offset + 0.33) % 1, 1, 1)), 
                        rgbkey(0.5, hsv((offset + 0.5) % 1, 1, 1)), 
                        rgbkey(0.67, hsv((offset + 0.67) % 1, 1, 1)), 
                        rgbkey(0.83, hsv((offset + 0.83) % 1, 1, 1)), 
                        rgbkey(1, hsv((offset + 1) % 1, 1, 1))
                    }

                    task.wait()
                end 
            end)

            return setmetatable(cfg, library)
        end 

        local notifications = {notifs = {}} 

        function notifications:refresh_notifs() 
            for i, v in notifications.notifs do 
                local Position = vec2(20, 20)
                tween_service:Create(v, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = dim_offset(Position.X, Position.Y + (i * 30))}):Play()
            end
        end
        
        function notifications:fade(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            tween_service:Create(path, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = fading}):Play()
        
            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Transparency = fading}):Play()
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {TextTransparency = fading}):Play()
                elseif instance:IsA("Frame") then
                    tween_service:Create(instance, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {BackgroundTransparency = fading}):Play()
                end
            end
        end 
        
        local sgui = library:create("ScreenGui", {
            Name = "Hi",
            Parent = gethui() 
        })
        
        function notifications:create_notification(options)
            local cfg = {
                name = options.name or "Hit: q3sm (finobe) in the Head for 100 Damage!",
                outline; 
            }

            -- Instances
                local outline = library:create("Frame", {
                    Parent = sgui;
                    Size = dim2(0, 0, 0, 0);
                    Position = dim_offset(20, 20 + (#notifications.notifs * 30));
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(outline, "c", "BackgroundColor3");  library:draggify(outline)

                local inline = library:create("Frame", {
                    Parent = outline;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(21, 21, 21)
                });	library:apply_theme(inline, "e", "BackgroundColor3")
                
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
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, -4, 1, 0);
                    Position = dim2(0, 4, 0, -2);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 1);
                    PaddingRight = dim(0, 1);
                    Parent = outline
                });
            -- 
            
            local index = #notifications.notifs + 1
            notifications.notifs[index] = outline
            
            notifications:refresh_notifs()
            tween_service:Create(outline, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = vec2(0, 0)}):Play()
            
            notifications:fade(outline, false)
        
            task.spawn(function()
                task.wait(3)
                
                notifications.notifs[index] = nil
        
                notifications:fade(outline, true)
        
                task.wait(3)
        
                outline:Destroy() 
            end)
        end

        function library:tab(properties)
            local cfg = {
                name = properties.name or "visuals", 
            } 

            -- Instances 
                -- Tab Button
                    local button = library:create("TextButton", {
                        FontFace = library.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = self.tab_holder;
                        BackgroundTransparency = 1;
                        Size = dim2(0, 200, 0, 50);
                        BorderSizePixel = 0;
                        TextSize = 12;
                        Text = cfg.name;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); 
                    
                    local accent = library:create("Frame", {
                        AnchorPoint = vec2(0, 1);
                        Parent = button;
                        Position = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 4);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(84, 84, 84)
                    }); library:apply_theme(accent, "accent", "BackgroundColor3"); library:apply_theme(accent, "f", "BackgroundColor3")
                    
                    local split = library:create("Frame", {
                        AnchorPoint = vec2(0, 1);
                        Parent = accent;
                        Position = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(84, 84, 84)
                    }); library:apply_theme(split, "accent", "BackgroundColor3"); library:apply_theme(split, "f", "BackgroundColor3")
                    
                    library:create("UIGradient", {
                        Color = rgbseq{rgbkey(0, rgb(167, 167, 167)), rgbkey(1, rgb(167, 167, 167))};
                        Parent = split
                    });                
                -- 

                -- Page Elements
                    -- Page Holder 
                        local e = library:create("Frame", {
                            Parent = self.inline;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            Visible = false;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(21, 21, 21)
                        });	library:apply_theme(e, "e", "BackgroundColor3"); cfg.page_holder = e;
                        
                        library:create("UIListLayout", {
                            FillDirection = Enum.FillDirection.Horizontal;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = e;
                            Padding = dim(0, 12);
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            VerticalFlex = Enum.UIFlexAlignment.Fill
                        });
                        
                        library:create("UIPadding", {
                            PaddingTop = dim(0, 22);
                            PaddingBottom = dim(0, 22);
                            Parent = e;
                            PaddingRight = dim(0, 22);
                            PaddingLeft = dim(0, 22)
                        });
                    -- 
                    
                    -- Columns 
                        local frame = library:create("Frame", {
                            BackgroundTransparency = 1;
                            Position = dim2(0, 22, 0, 22);
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = e;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.left = frame
                        
                        library:create("UIListLayout", {
                            Parent = frame;
                            Padding = dim(0, 12);
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                        });

                        local frame = library:create("Frame", {
                            BackgroundTransparency = 1;
                            Position = dim2(0, 22, 0, 22);
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = e;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.right = frame
                        
                        library:create("UIListLayout", {
                            Parent = frame;
                            Padding = dim(0, 12);
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                        });
                    -- 
                -- 
            -- 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                
                if selected_tab then 
                    selected_tab[1].Visible = false
                    selected_tab[2].BackgroundColor3 = themes.preset.f
                    selected_tab[3].BackgroundColor3 = themes.preset.f

                    selected_tab = nil 
                end

                e.Visible = true
                accent.BackgroundColor3 = themes.preset.accent
                split.BackgroundColor3 = themes.preset.accent

                self.selected_tab = {e, accent, split}
            end

            button.MouseButton1Down:Connect(function()
                cfg.open_tab()
            end)

            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return setmetatable(cfg, library)    
        end 

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section", 
                side = properties.side or "left",
                fill = properties.fill or 0.01,
            }   

            -- Instances
                local parent = self[cfg.side] 

                local section = library:create("Frame", {
                    Parent = parent;
                    BackgroundTransparency = 1;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, cfg.fill, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = section;
                    Padding = dim(0, 12);
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                local a = library:create("Frame", {
                    Position = dim2(0, 22, 0, 22);
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = section;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                });
                
                local c = library:create("Frame", {
                    Parent = a;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(c, "c", "BackgroundColor3")
                
                local e = library:create("Frame", {
                    Parent = c;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 21)
                });	library:apply_theme(e, "e", "BackgroundColor3")
                
                local section_title = library:create("TextLabel", {
                    FontFace = library.font;
                    Parent = e;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    Size = dim2(1, -10, 0, 0);
                    Position = dim2(0, 10, 0, -7);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local scrolling_frame = library:create("ScrollingFrame", {
                    ScrollBarImageColor3 = themes.preset.accent;
                    MidImage = "rbxassetid://72824869889812";
                    Parent = e;
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    ZIndex = 2;
                    Size = dim2(1, 0, 1, 0);
                    BackgroundColor3 = rgb(255, 255, 255);
                    TopImage = "rbxassetid://85156243582367";
                    BorderColor3 = rgb(0, 0, 0);
                    BackgroundTransparency = 1;
                    BottomImage = "rbxassetid://139338441481766";
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });	library:apply_theme(scrolling_frame, "accent", "ScrollBarImageColor3")
                
                local elements = library:create("Frame", {
                    Parent = scrolling_frame;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 8, 0, 10);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -12, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.elements = elements;
                
                library:create("UIListLayout", {
                    Parent = elements;
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                local scrollbar_fill = library:create("Frame", {
                    Visible = true;
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    Position = dim2(1, 0, 0, 0);
                    Parent = e;
                    Size = dim2(0, 3, 1, 0);
                    BorderSizePixel = 0;
                    ZIndex = -1;
                    BackgroundColor3 = rgb(46, 46, 46)
                });	library:apply_theme(scrollbar_fill, "c", "BackgroundColor3")  
                
                library:create("UIPadding", {
                    PaddingBottom = dim(0, 15);
                    Parent = scrolling_frame
                });
            -- 

            -- Connections 
                scrolling_frame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
                    local is_scrollbar_visible = scrolling_frame.AbsoluteCanvasSize.Y < elements.AbsoluteSize.Y + 26

                    scrollbar_fill.Visible = is_scrollbar_visible and true or false 
                end)
            --

            return setmetatable(cfg, library)
        end 

        -- Elements  
            function library:label(options)
                local cfg = {name = options.name or "This is a textlabel"}

                -- Element
                    local label = library:create("TextButton", {
                        FontFace = library.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.elements;
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 10);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local toggle_text = library:create("TextLabel", {
                        FontFace = library.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = label;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(0, 9, 0, -1);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local right_components = library:create("Frame", {
                        Parent = label;
                        Position = dim2(1, -7, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); cfg.right_components = right_components
                    
                    library:create("UIListLayout", {
                        Parent = right_components;
                        Padding = dim(0, 4);
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                -- 
                
                return setmetatable(cfg, library)
            end 

            function library:toggle(options) 
                local cfg = {
                    enabled = options.enabled or nil,
                    name = options.name or "Toggle",
                    flag = options.flag or tostring(random(1,9999999)),
                    
                    default = options.value or options.default or false,
                    folding = options.folding or false, 
                    callback = options.callback or function() end,
                }

                -- Instances
                    -- Element
                        local toggle = library:create("TextButton", {
                            FontFace = library.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            Parent = self.elements;
                            BackgroundTransparency = 1;
                            Size = dim2(1, 0, 0, 10);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local d = library:create("Frame", {
                            Parent = toggle;
                            Position = dim2(0, -1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 10, 0, 10);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(d, "d", "BackgroundColor3")
                        
                        local f = library:create("Frame", {
                            Parent = d;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(84, 84, 84)
                        });	library:apply_theme(f, "f", "BackgroundColor3")
                        
                        local toggle_text = library:create("TextLabel", {
                            FontFace = library.font;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = cfg.name;
                            Parent = toggle;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 15, 0, -1);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local right_components = library:create("Frame", {
                            Parent = toggle;
                            Position = dim2(1, -7, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 0, 1, 0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.right_components = right_components
                        
                        library:create("UIListLayout", {
                            Parent = right_components;
                            Padding = dim(0, 4);
                            FillDirection = Enum.FillDirection.Horizontal;
                            HorizontalAlignment = Enum.HorizontalAlignment.Right;
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                    -- 

                    -- Sub sections
                        local elements;

                        if cfg.folding then
                            elements = library:create("Frame", {
                                Parent = self.elements;
                                BackgroundTransparency = 1;
                                Position = dim2(0, 4, 0, 21);
                                Size = dim2(1, 0, 0, 0);
                                BorderSizePixel = 0;
                                AutomaticSize = Enum.AutomaticSize.Y;
                                BackgroundColor3 = rgb(255, 255, 255)
                            }); cfg.elements = elements
                            
                            library:create("UIListLayout", {
                                Parent = elements;
                                Padding = dim(0, 7);
                                HorizontalAlignment = Enum.HorizontalAlignment.Right;
                                SortOrder = Enum.SortOrder.LayoutOrder
                            });                            
                        end 
                    --      
                -- 
                
                -- Functions 
                    function cfg.set(bool)                        
                        f.BackgroundColor3 = bool and themes.preset.accent or themes.preset.f

                        cfg.callback(bool)

                        if cfg.folding then 
                            elements.Visible = bool
                        end
                    end 

                    cfg.set(cfg.default)

                    config_flags[cfg.flag] = cfg.set
                --

                -- Connections
                    toggle.MouseButton1Click:Connect(function()
                        cfg.enabled = not cfg.enabled 
                        cfg.set(cfg.enabled)
                    end)
                -- 
                
                return setmetatable(cfg, library)
            end 
            
            function library:slider(options) 
                local cfg = {
                    name = options.name or nil,
                    suffix = options.suffix or "",
                    flag = options.flag or tostring(2^789),
                    callback = options.callback or function() end, 
    
                    min = options.min or options.minimum or 0,
                    max = options.max or options.maximum or 100,
                    intervals = options.interval or options.decimal or 1,
                    default = options.value or options.default or 10,

                    ignore = options.ignore or false, 
                    dragging = false,
                } 

                -- Instances
                    local object = library:create("TextButton", {
                        FontFace = library.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.elements;
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 32);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local toggle_text = library:create("TextLabel", {
                        FontFace = library.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = object;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(0, 8, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local slider_frame = library:create("TextButton", {
                        Parent = object;
                        Position = dim2(0, 8, 0, 16);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -14, 0, 8);
                        AutoButtonColor = false; 
                        Text = "";
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(12, 12, 12)
                    });	library:apply_theme(slider_frame, "d", "BackgroundColor3")
                    
                    local background = library:create("Frame", {
                        Parent = slider_frame;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(56, 56, 56)
                    });	library:apply_theme(background, "b", "BackgroundColor3")
                    
                    local fill = library:create("Frame", {
                        Parent = background;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0.5, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	library:apply_theme(fill, "accent", "BackgroundColor3")
                    
                    local output = library:create("TextLabel", {
                        FontFace = library.font;
                        Parent = fill;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "50";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AnchorPoint = vec2(0.5, 0);
                        Position = dim2(1, 0, 1, -1);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local plus = library:create("ImageButton", {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = slider_frame;
                        Image = "rbxassetid://126987373762224";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -3, 0, 2);
                        Size = dim2(0, 5, 0, 5);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_theme(plus, "text", "BackgroundColor3")
                    
                    local minus = library:create("ImageButton", {
                        AnchorPoint = vec2(1, 0);
                        Parent = slider_frame; 
                        Position = dim2(0, -3, 0, 4);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 5, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_theme(minus, "text", "BackgroundColor3")
                -- 

                -- Functions 
                    function cfg.set(value)
                        local valuee = tonumber(value)

                        if valuee == nil then 
                            return 
                        end 

                        cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                        fill.Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)
                        output.Text = tostring(cfg.value) .. cfg.suffix
                        
                        flags[cfg.flag] = cfg.value

                        cfg.callback(flags[cfg.flag])
                    end 

                    cfg.set(cfg.default)
                -- 

                -- Connections
                    slider_frame.MouseButton1Down:Connect(function()
                        cfg.dragging = true 
                    end)

                    minus.MouseButton1Down:Connect(function()
                        cfg.value -= cfg.intervals
                        cfg.set(cfg.value)
                    end)

                    plus.MouseButton1Down:Connect(function()
                        cfg.value += cfg.intervals
                        cfg.set(cfg.value)
                    end)

                    library:connection(uis.InputChanged, function(input)
                        if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                            local size_x = (input.Position.X - slider_frame.AbsolutePosition.X) / slider_frame.AbsoluteSize.X
                            local value = ((cfg.max - cfg.min) * size_x) + cfg.min

                            cfg.set(value)
                        end
                    end)

                    library:connection(uis.InputEnded, function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            cfg.dragging = false 
                        end 
                    end)
                -- 

                cfg.set(cfg.default)

                config_flags[cfg.flag] = cfg.set

                return setmetatable(cfg, library)
            end 

            function library:dropdown(options)  
                local cfg = {
                    name = options.name or nil,
                    flag = options.flag or tostring(random(1,9999999)),

                    items = options.items or {""},
                    callback = options.callback or function() end,
                    multi = options.multi or false, 
                    scrolling = options.scrolling or false, 

                    -- Ignore these 
                    open = false, 
                    option_instances = {}, 
                    multi_items = {}, 
                    ignore = options.ignore or false, 
                }   

                cfg.default = options.value or options.default or options.value or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"

                flags[cfg.flag] = {} 

                -- Instances
                    -- Element 
                        local object = library:create("TextButton", {
                            FontFace = library.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            Parent = self.elements;
                            BackgroundTransparency = 1;
                            Size = dim2(1, 0, 0, 35);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local title = library:create("TextLabel", {
                            FontFace = library.font;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = cfg.name;
                            Parent = object;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 8, 0, 2);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local dropdown_holder = library:create("TextButton", {
                            Parent = object;
                            Text = "";
                            Position = dim2(0, 8, 0, 17);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -14, 0, 18);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(dropdown_holder, "d", "BackgroundColor3")
                        
                        local inline = library:create("Frame", {
                            Parent = dropdown_holder;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(46, 46, 46)
                        });	library:apply_theme(inline, "c", "BackgroundColor3")
                        
                        local text = library:create("TextLabel", {
                            FontFace = library.font;
                            Parent = inline;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "ERROR";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Size = dim2(1, -4, 1, 0);
                            Position = dim2(0, 4, 0, -1);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local plus = library:create("ImageLabel", {
                            BorderColor3 = rgb(0, 0, 0);
                            AnchorPoint = vec2(1, 0);
                            Image = "rbxassetid://126987373762224";
                            BackgroundTransparency = 1;
                            Position = dim2(1, -4, 0, 6);
                            Parent = inline;
                            Size = dim2(0, 5, 0, 5);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });	library:apply_theme(ImageLabel, "text", "BackgroundColor3")
                    -- 

                    -- Holder
                        local items = library:create("Frame", {
                            Parent = library.gui;
                            Visible = false;
                            Size = dim2(0.0907348021864891, 0, 0.006218905560672283, 20);
                            Position = dim2(0, 500, 0, 100);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(12, 12, 12)
                        }); library:apply_theme(items, "d", "BackgroundColor3")
                        
                        local holder_items = library:create("Frame", {
                            Parent = items;
                            Size = dim2(1, -2, 1, -2);
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(46, 46, 46)
                        }); library:apply_theme(holder_items, "c", "BackgroundColor3")
                        
                        library:create("UIListLayout", {
                            Parent = holder_items;
                            Padding = dim(0, 6);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        library:create("UIPadding", {
                            PaddingTop = dim(0, 5);
                            PaddingBottom = dim(0, 6);
                            Parent = holder_items;
                            PaddingRight = dim(0, 6);
                            PaddingLeft = dim(0, 6)
                        });
                        
                        library:create("UIPadding", {
                            PaddingBottom = dim(0, 2);
                            Parent = items
                        });                    
                    --  
                --

                -- Functions 
                    function cfg.render_option(text) 
                        local option = library:create("TextButton", {
                            FontFace = library.font;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = text;
                            Parent = holder_items;
                            Size = dim2(1, 0, 0, 0);
                            Position = dim2(0, 0, 0, 1);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); library:apply_theme(option, "accent", "TextColor3")

                        return option
                    end 
                    
                    function cfg.set_visible(bool) 
                        items.Visible = bool

                        plus.Image = bool and "rbxassetid://0" or "rbxassetid://126987373762224"
                        plus.Position = bool and dim2(1, -4, 0, 9) or dim2(1, -4, 0, 6)
                        plus.Size = bool and dim2(0, 5, 0, 1) or dim2(0, 5, 0, 5)
                        plus.BackgroundTransparency = bool and 0 or 1 
                    end
                    
                    function cfg.set(value)
                        local selected = {}
                        local isTable = type(value) == "table"

                        if value == nil then 
                            return 
                        end

                        for _, option in next, cfg.option_instances do 
                            if option.Text == value or (isTable and find(value, option.Text)) then 
                                insert(selected, option.Text)
                                cfg.multi_items = selected
                                option.TextColor3 = themes.preset.accent
                            else
                                option.TextColor3 = themes.preset.text
                            end
                        end

                        text.Text = if isTable then concat(selected, ", ") else selected[1]

                        flags[cfg.flag] = if isTable then selected else selected[1]
                        
                        cfg.callback(flags[cfg.flag]) 
                    end
                    
                    function cfg.refresh_options(list) 
                        for _, option in next, cfg.option_instances do 
                            option:Destroy() 
                        end
                        
                        cfg.option_instances = {} 

                        for _, option in next, list do 
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

                    cfg.refresh_options(cfg.items)

                    cfg.set(cfg.default)

                    config_flags[cfg.flag] = cfg.set
                -- 

                -- Connections 
                    dropdown_holder.MouseButton1Click:Connect(function()
                        cfg.open = not cfg.open 
                        
                        items.Size = dim2(0, dropdown_holder.AbsoluteSize.X, 0, items.Size.Y.Offset)
                        items.Position = dim2(0, dropdown_holder.AbsolutePosition.X, 0, dropdown_holder.AbsolutePosition.Y + 80)
                        
                        cfg.set_visible(cfg.open)
                    end)
                    
                    library:connection(uis.InputEnded, function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if not (library:mouse_in_frame(items) or library:mouse_in_frame(dropdown_holder)) then 
                                cfg.open = false
                                cfg.set_visible(false)
                            end
                        end
                    end)
                -- 

                return setmetatable(cfg, library)
            end 

            function library:button(options)  
                local cfg = {
                    callback = options.callback or function() end 
                }   

                cfg.default = options.value or options.default or options.value or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"

                flags[cfg.flag] = {} 

                -- 
                    
                -- 

                -- Functions 
                    function cfg.render_option(text) 
                        local option = library:create("TextButton", {
                            FontFace = library.font;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = text;
                            Parent = holder_items;
                            Size = dim2(1, 0, 0, 0);
                            Position = dim2(0, 0, 0, 1);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); library:apply_theme(option, "accent", "TextColor3")

                        return option
                    end 
                    
                    function cfg.set_visible(bool) 
                        items.Visible = bool

                        plus.Image = bool and "rbxassetid://0" or "rbxassetid://126987373762224"
                        plus.Position = bool and dim2(1, -4, 0, 9) or dim2(1, -4, 0, 6)
                        plus.Size = bool and dim2(0, 5, 0, 1) or dim2(0, 5, 0, 5)
                        plus.BackgroundTransparency = bool and 0 or 1 
                    end
                    
                    function cfg.set(value)
                        local selected = {}
                        local isTable = type(value) == "table"

                        if value == nil then 
                            return 
                        end

                        for _, option in next, cfg.option_instances do 
                            if option.Text == value or (isTable and find(value, option.Text)) then 
                                insert(selected, option.Text)
                                cfg.multi_items = selected
                                option.TextColor3 = themes.preset.accent
                            else
                                option.TextColor3 = themes.preset.text
                            end
                        end

                        text.Text = if isTable then concat(selected, ", ") else selected[1]

                        flags[cfg.flag] = if isTable then selected else selected[1]
                        
                        cfg.callback(flags[cfg.flag]) 
                    end
                    
                    function cfg.refresh_options(list) 
                        for _, option in next, cfg.option_instances do 
                            option:Destroy() 
                        end
                        
                        cfg.option_instances = {} 

                        for _, option in next, list do 
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

                    cfg.refresh_options(cfg.items)

                    cfg.set(cfg.default)

                    config_flags[cfg.flag] = cfg.set
                -- 

                -- Connections 
                    dropdown_holder.MouseButton1Click:Connect(function()
                        cfg.open = not cfg.open 
                        
                        items.Size = dim2(0, dropdown_holder.AbsoluteSize.X, 0, items.Size.Y.Offset)
                        items.Position = dim2(0, dropdown_holder.AbsolutePosition.X, 0, dropdown_holder.AbsolutePosition.Y + 80)
                        
                        cfg.set_visible(cfg.open)
                    end)
                    
                    library:connection(uis.InputEnded, function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if not (library:mouse_in_frame(items) or library:mouse_in_frame(dropdown_holder)) then 
                                cfg.open = false
                                cfg.set_visible(false)
                            end
                        end
                    end)
                -- 

                return setmetatable(cfg, library)
            end 
            
            function library:colorpicker(options) 
                local cfg = {
                    name = options.name or "Color", 
                    flag = options.flag or tostring(2^789),

                    color = options.color or color(1, 1, 1), -- Default to white color if not provided
                    alpha = options.alpha and 1 - options.alpha or 0,
                    
                    open = false, 
                    callback = options.callback or function() end,
                }

                -- Instances
                    -- Label reparenting 
                        if not self.right_components then
                            cfg.label = self:label({name = cfg.name})
                        end
                    --

                    -- Element
                        local colorpicker_element = library:create("TextButton", {
                            Parent = self.right_components or cfg.label.right_components;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 24, 0, 12);
                            Text = "";
                            AutoButtonColor = false;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(colorpicker_element, "d", "BackgroundColor3")
                        
                        local colorpicker_element_color = library:create("Frame", {
                            Parent = colorpicker_element;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 194, 11)
                        });
                        
                        library:create("UIGradient", {
                            Rotation = 90;
                            Parent = colorpicker_element_color;
                            Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(182, 182, 182))}
                        });
                        
                        library:create("UIGradient", {
                            Color = rgbseq{rgbkey(0, rgb(99, 99, 99)), rgbkey(1, rgb(99, 99, 99))};
                            Parent = colorpicker_element
                        });
                    -- 

                    -- Elements
                        local colorpicker = library:create("Frame", {
                            Parent = library.gui;
                            Position = dim2(0.6888179183006287, 0, 0.24751244485378265, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Visible = false;
                            Size = dim2(0, 231, 0, 209);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(46, 46, 46)
                        });	library:apply_theme(colorpicker, "c", "BackgroundColor3")
                        
                        local e = library:create("Frame", {
                            Parent = colorpicker;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(21, 21, 21)
                        });	library:apply_theme(e, "e", "BackgroundColor3")
                        
                        local _ = library:create("UIPadding", {
                            PaddingTop = dim(0, 7);
                            PaddingBottom = dim(0, -13);
                            Parent = e;
                            PaddingRight = dim(0, 6);
                            PaddingLeft = dim(0, 7)
                        });
                        
                        local textbox = library:create("Frame", {
                            Parent = e;
                            Position = dim2(0, 0, 1, -36);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -1, 0, 16);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(textbox, "d", "BackgroundColor3")
                        
                        local b = library:create("Frame", {
                            Parent = textbox;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(56, 56, 56)
                        });	library:apply_theme(b, "b", "BackgroundColor3")
                        
                        local textbox = library:create("TextBox", {
                            FontFace = library.font;
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            Parent = b;
                            BackgroundTransparency = 1;
                            ClearTextOnFocus = false;
                            PlaceholderColor3 = rgb(255, 255, 255);
                            Size = dim2(1, 0, 1, 0);
                            BorderSizePixel = 0;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255);
                            TextXAlignment = Enum.TextXAlignment.Center;
                        });
                        
                        local hue_button = library:create("TextButton", {
                            AnchorPoint = vec2(1, 0);
                            Text = "";
                            AutoButtonColor = false;
                            Parent = e;
                            Position = dim2(1, -1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 14, 1, -60);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(hue_button, "d", "BackgroundColor3")
                        
                        local hue_drag = library:create("Frame", {
                            Parent = hue_button;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create("UIGradient", {
                            Rotation = 90;
                            Parent = hue_drag;
                            Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))}
                        });
                        
                        local hue_picker = library:create("Frame", {
                            Parent = hue_drag;
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, 2, 0, 3);
                            Position = dim2(0, -1, 0, -1);
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local alpha_button = library:create("TextButton", {
                            AnchorPoint = vec2(0, 0.5);
                            Text = "";
                            AutoButtonColor = false;
                            Parent = e;
                            Position = dim2(0, 0, 1, -48);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -1, 0, 14);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(alpha_button, "d", "BackgroundColor3")
                        
                        local alpha_color = library:create("Frame", {
                            Parent = alpha_button;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(0, 221, 255)
                        });
                        
                        local alphaind = library:create("ImageLabel", {
                            ScaleType = Enum.ScaleType.Tile;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = alpha_color;
                            Image = "rbxassetid://18274452449";
                            BackgroundTransparency = 1;
                            Size = dim2(1, 0, 1, 0);
                            TileSize = dim2(0, 4, 0, 4);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create("UIGradient", {
                            Parent = alphaind;
                            Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                        });
                        
                        local alpha_picker = library:create("Frame", {
                            Parent = alpha_color;
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 3, 1, 2);
                            Position = dim2(0, -1, 0, -1);
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local saturation_value_button = library:create("TextButton", {
                            Parent = e;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -20, 1, -60);
                            Text = "";
                            AutoButtonColor = false;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(saturation_value_button, "d", "BackgroundColor3")
                        
                        local colorpicker_color = library:create("Frame", {
                            Parent = saturation_value_button;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(0, 221, 255)
                        });
                        
                        local val = library:create("TextButton", {
                            Parent = colorpicker_color;
                            Text = "";
                            AutoButtonColor = false;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, 0, 1, 0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create("UIGradient", {
                            Parent = val;
                            Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                        });
                        
                        local saturation_value_picker = library:create("Frame", {
                            Parent = colorpicker_color;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 3, 0, 3);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(0, 0, 0)
                        });
                        
                        local inline = library:create("Frame", {
                            Parent = saturation_value_picker;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        local saturation_button = library:create("TextButton", {
                            Parent = colorpicker_color;
                            Text = "";
                            AutoButtonColor = false;
                            Size = dim2(1, 0, 1, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create("UIGradient", {
                            Rotation = 270;
                            Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                            Parent = saturation_button;
                            Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                        });
                        
                        
                    -- 
                -- 
                
                -- Functions 
                    local dragging_sat = false 
                    local dragging_hue = false 
                    local dragging_alpha = false 

                    local h, s, v = cfg.color:ToHSV() 
                    local a = cfg.alpha 

                    flags[cfg.flag] = {} 

                    function cfg.set_visible(bool) 
                        colorpicker.Visible = bool
                        
                        colorpicker.Position = dim_offset(colorpicker_element.AbsolutePosition.X, colorpicker_element.AbsolutePosition.Y + colorpicker_element.AbsoluteSize.Y + 65)
                    end

                    function cfg.set(color, alpha)
                        if color then 
                            h, s, v = color:ToHSV()
                        end
                        
                        if alpha then 
                            a = alpha
                        end 
                        
                        local Color = Color3.fromHSV(h, s, v)
                        
                        hue_picker.Position = dim2(0, -1, 1 - h, -1)
                        alpha_picker.Position = dim2(1 - a, -1, 0, -1)
                        saturation_value_picker.Position = dim2(s, -1, 1 - v, -1)

                        --element_alpha.ImageTransparency = 1 - a

                        alpha_color.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                        colorpicker_element_color.BackgroundColor3 = Color
                        colorpicker_color.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                        
                        flags[cfg.flag] = {
                            Color = Color;
                            Transparency = a 
                        }
                        
                        local color = colorpicker_element_color.BackgroundColor3
                        textbox.Text = string.format("%s, %s, %s, ", library:round(color.R * 255), library:round(color.G * 255), library:round(color.B * 255))
                        textbox.Text ..= library:round(1 - a, 0.01)
                        
                        cfg.callback(Color, a)
                    end
        
                    function cfg.update_color() 
                        local mouse = uis:GetMouseLocation() 
                        local offset = vec2(mouse.X, mouse.Y - gui_offset) 

                        if dragging_sat then	
                            s = math.clamp((offset - saturation_value_button.AbsolutePosition).X / saturation_value_button.AbsoluteSize.X, 0, 1)
                            v = 1 - math.clamp((offset - saturation_value_button.AbsolutePosition).Y / saturation_value_button.AbsoluteSize.Y, 0, 1)
                        elseif dragging_hue then
                            h = 1 - math.clamp((offset - hue_button.AbsolutePosition).Y / hue_button.AbsoluteSize.Y, 0, 1)
                        elseif dragging_alpha then
                            a = 1 - math.clamp((offset - alpha_button.AbsolutePosition).X / alpha_button.AbsoluteSize.X, 0, 1)
                        end

                        cfg.set(nil, nil)
                    end

                    cfg.set(cfg.color, cfg.alpha)
                    
                    config_flags[cfg.flag] = cfg.set
                -- 
                
                -- Connections 
                    colorpicker_element.MouseButton1Click:Connect(function()
                        cfg.open = not cfg.open 

                        cfg.set_visible(cfg.open)            
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

                            if not (library:mouse_in_frame(colorpicker_element) or library:mouse_in_frame(colorpicker)) then 
                                cfg.open = false
                                cfg.set_visible(false)
                            end
                        end
                    end)

                    alpha_button.MouseButton1Down:Connect(function()
                        dragging_alpha = true 
                    end)
                    
                    hue_button.MouseButton1Down:Connect(function()
                        dragging_hue = true 
                    end)
                    
                    saturation_button.MouseButton1Down:Connect(function()
                        print("hiu")
                        dragging_sat = true  
                    end)
                    
                    textbox.FocusLost:Connect(function()
                        local r, g, b, a = library:convert(textbox.Text)
                        
                        if r and g and b and a then 
                            cfg.set(rgb(r, g, b), 1 - a)
                        end 
                    end)
                -- 

                return setmetatable(cfg, library)
            end 

            function library:textbox(options) 
                local cfg = {
                    name = options.name or "TextBox",
                    placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                    default = options.value or options.default,
                    flag = options.flag or "SET ME NIGGA",
                    callback = options.callback or function() end,
                    visible = options.visible or true,
                }
                
                -- Instances 
                    local textbox = library:create("Frame", {
                        Parent = self.elements;
                        Position = dim2(0, 0, 0, 16);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(12, 12, 12)
                    });	library:apply_theme(textbox, "outline", "BackgroundColor3")

                    local inline = library:create("Frame", {
                        Parent = textbox;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	library:apply_theme(inline, "inline", "BackgroundColor3")

                    local background = library:create("Frame", {
                        Parent = inline;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	library:apply_theme(background, "background", "BackgroundColor3")

                    local input = library:create("TextBox", {
                        FontFace = library.font;
                        TextColor3 = rgb(170, 170, 170);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = background;
                        BackgroundTransparency = 1;
                        PlaceholderColor3 = rgb(170, 170, 170);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 
                
                -- Functions
                    function cfg.set(text) 
                        flags[cfg.flag] = text

                        input.Text = text

                        cfg.callback(text)
                    end 
                    
                    config_flags[cfg.flag] = cfg.set

                    if cfg.default then 
                        cfg.set(cfg.default) 
                    end
                --

                -- Connections 
                    input:GetPropertyChangedSignal("Text"):Connect(function()
                        cfg.set(input.Text) 
                    end)
                -- 
                
                return setmetatable(cfg, library)
            end 
            
            function library:keybind(options) 
                local cfg = {
                    flag = options.flag or "SET ME A FLAG NOWWW!!!!",
                    callback = options.callback or function() end,
                    name = options.name or nil, 
                    ignore_key = options.ignore or false, 
    
                    key = options.key or nil, 
                    mode = options.mode or "Hold",
                    active = options.default or false, 
    
                    hold_instances = {},
                    open = false,
                    binding = nil, 
                }

                flags[cfg.flag] = {} 

                if not self.right_components then 
                    cfg.label = self:label({name = cfg.name or "Keybind"})
                end

                -- Instances
                    local keybind_element = library:create("TextButton", {
                        Parent = self.right_components or cfg.label.right_components;
                        Size = dim2(0, 40, 0, 16);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });	library:apply_theme(keybind_element, "a", "BackgroundColor3")
                    
                    local b = library:create("Frame", {
                        Parent = keybind_element;
                        Size = dim2(1, -2, 1, -2);
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(46, 46, 46)
                    });	library:apply_theme(b, "c", "BackgroundColor3")

                    library:create("UIPadding", {
                        PaddingRight = dim(0, 2);
                        PaddingBottom = dim(0, 2);
                        PaddingLeft = dim(0, 8);
                        PaddingTop = dim(0, 4);
                        Parent = b
                    });
                    
                    local toggle_text = library:create("TextLabel", {
                        FontFace = library.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = " LSHIFT ";
                        Parent = b;
                        Position = dim2(0, 0, 0, -1);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        Size = dim2(1,0,1,0);
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create("UIPadding", {
                        PaddingRight = dim(0, 2);
                        Parent = keybind_element
                    });

                    -- Holder
                        local items = library:create("Frame", {
                            Parent = library.gui;
                            Selectable = true;
                            Visible = false;
                            Position = dim2(0, 500, 0, 100);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(12, 12, 12)
                        });	library:apply_theme(items, "d", "BackgroundColor3")
                        
                        local item_holder = library:create("Frame", {
                            Parent = items;
                            Size = dim2(1, -2, 1, -2);
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(56, 56, 56)
                        });	library:apply_theme(item_holder, "b", "BackgroundColor3")
                        
                        library:create("UIListLayout", {
                            Parent = item_holder;
                            Padding = dim(0, 6);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        library:create("UIPadding", {
                            PaddingTop = dim(0, 5);
                            PaddingBottom = dim(0, 2);
                            Parent = item_holder;
                            PaddingRight = dim(0, 6);
                            PaddingLeft = dim(0, 6)
                        });
                        
                        library:create("UIPadding", {
                            PaddingBottom = dim(0, 2);
                            Parent = items
                        });
                        
                        local options = {"Hold", "Toggle", "Always"}
                        
                        for _, v in options do
                            local option = library:create("TextButton", {
                                FontFace = library.font;
                                TextColor3 = rgb(255, 255, 255);
                                BorderColor3 = rgb(0, 0, 0);
                                Text = v;
                                Parent = item_holder;
                                Position = dim2(0, 0, 0, 1);
                                BackgroundTransparency = 1;
                                TextXAlignment = Enum.TextXAlignment.Left;
                                BorderSizePixel = 0;
                                AutomaticSize = Enum.AutomaticSize.XY;
                                TextSize = 12;
                                BackgroundColor3 = rgb(255, 255, 255)
                            }); cfg.hold_instances[v] = option

                            option.MouseButton1Click:Connect(function()
                                cfg.set(v)

                                --cfg.modify_mode_color(v)

                                cfg.set_visible(false)

                                cfg.open = false
                            end)
                        end
                    -- 

                    -- Keybind list text
                        local keybind_list_text; 
                        if cfg.name then
                            keybind_list_text = library:create("TextLabel", {
                                FontFace = library.font;
                                TextColor3 = rgb(255, 255, 255);
                                BorderColor3 = rgb(0, 0, 0);
                                Text = "[ M ] triggerbot: always";
                                Parent = library.keybind_list;
                                AutomaticSize = Enum.AutomaticSize.XY;
                                Position = dim2(0, 18, 0, -3);
                                BackgroundTransparency = 1;
                                TextXAlignment = Enum.TextXAlignment.Left;
                                BorderSizePixel = 0;
                                ZIndex = 2;
                                TextSize = 12;
                                BackgroundColor3 = rgb(255, 255, 255)
                            });
                        end 
                    -- 
                -- 

                -- Functions 
                    function cfg.modify_mode_color(path) -- ts so frikin tuff 💀
                        for _, v in item_holder:GetChildren() do 
                            if v:IsA("TextButton") then 
                                v.TextColor3 = themes.preset.text
                            end 
                        end

                        cfg.hold_instances[path].TextColor3 = themes.preset.accent
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
                            local __cached = input 

                            if cfg.mode == "Always" then 
                                __cached = true 
                            end 

                            cfg.active = __cached 
                            cfg.callback(__cached)
                        elseif tostring(input):find("Enum") then 
                            input = input.Name == "Escape" and "..." or input

                            cfg.key = input or "..."	

                            cfg.callback(cfg.active or false)
                        elseif find({"Toggle", "Hold", "Always"}, input) then 
                            cfg.set_mode(input)

                            if input == "Always" then 
                                cfg.active = true 
                            end 

                            cfg.callback(cfg.active or false)
                        elseif type(input) == "table" then 
                            input.key = type(input.key) == "string" and input.key ~= "..." and library:convert_enum(input.key) or input.key

                            input.key = input.key == Enum.KeyCode.Escape and "..." or input.key
                            cfg.key = input.key or "..."
                            
                            cfg.mode = input.mode or "Toggle"
                            cfg.set_mode(input.mode)

                            if input.active then
                                cfg.active = input.active
                            end
                        end 

                        flags[cfg.flag] = {
                            mode = cfg.mode,
                            key = cfg.key, 
                            active = cfg.active
                        }

                        local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                        local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                        
                        toggle_text.Text = " ".. __text .." "

                        if keybind_list_text then
                            keybind_list_text.Text = "[ ".. __text  .." ] ".. cfg.name ..":".. string.lower(cfg.mode) .."";
                            keybind_list_text.Visible = cfg.active
                        end
                    end

                    function cfg.set_visible(bool)
                        items.Visible = bool
                        
                        items.Position = dim_offset(keybind_element.AbsolutePosition.X, keybind_element.AbsolutePosition.Y + keybind_element.AbsoluteSize.Y + 60)
                    end
                -- 
                
                -- Connections
                    keybind_element.MouseButton1Down:Connect(function()
                        task.wait()
                        toggle_text.Text = "..."	

                        cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                            cfg.set(keycode.KeyCode)

                            cfg.binding:Disconnect() 
                            cfg.binding = nil
                        end)
                    end)

                    keybind_element.MouseButton2Down:Connect(function()
                        cfg.open = not cfg.open 

                        cfg.set_visible(cfg.open) 
                    end)

                    library:connection(uis.InputBegan, function(input, game_event) 
                        if not game_event then 
                            if input.KeyCode == cfg.key then 
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

                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if not (library:mouse_in_frame(keybind_element) or library:mouse_in_frame(item_holder)) then 
                                cfg.open = false
                                cfg.set_visible(false)
                            end
                        end
                    end)
                --
                
                config_flags[cfg.flag] = cfg.set
                cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})
                        
                return setmetatable(cfg, library)
            end

            function library:button(options) 
                local cfg = {
                    name = options.name or "TextBox",
                    callback = options.callback or function() end,
                }
                
                -- Instances 
                    local button = library:create("TextButton", {
                        Parent = self.elements;
                        Text = "";
                        Position = dim2(0, 0, 0, 16);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(12, 12, 12)
                    });	library:apply_theme(button, "outline", "BackgroundColor3")
                    
                    local inline = library:create("Frame", {
                        Parent = button;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	library:apply_theme(inline, "inline", "BackgroundColor3")
                    
                    local background = library:create("Frame", {
                        Parent = inline;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	library:apply_theme(background, "background", "BackgroundColor3")
                    
                    local text = library:create("TextButton", {
                        FontFace = library.font;
                        TextColor3 = rgb(170, 170, 170);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = background;
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Connections 
                    text.MouseButton1Click:Connect(function()
                        cfg.callback()
                    end)
                --
                
                return setmetatable(cfg, library)
            end 
        -- 
    -- 
-- 

return library, notifications
