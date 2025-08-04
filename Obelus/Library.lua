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
    local coregui = game.Players.LocalPlayer.PlayerGui
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
    if getgenv().library then 
        library:unloadMenu()
    end 

    getgenv().library = {
        directory = "obels",
        folders = {
            "/fonts",
            "/configs",
        },
        flags = {},
        config_flags = {},

        connections = {},   
        notifications = {notifs = {}, offset = 0},
        playerlist_data = {
            players = {},
            player = {}, 
        },
        colorpicker_open = false; 
        gui; 
    }

    local themes = {
        preset = {
            ["accent"] = hex("#AA55EB"),
            -- ["glow"] = hex("#AA55EB"), -- ignore
        }, 	

        utility = {
            ["accent"] = {
                ["BackgroundColor3"] = {}, 	
                ["TextColor3"] = {}, 
                ["ImageColor3"] = {}, 
                ["ScrollBarImageColor3"] = {} 
            },
            -- UNCOMMENT THIS TO ADD GLOW TO YOUR UI (modify it yourself.)
            -- ["glow"] = {
            --     ["ImageColor3"] = {}, 	
            -- }, 
        }, 
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

    if not LPH_OBFUSCATED then
        getfenv().LPH_NO_VIRTUALIZE = function(...) return (...) end
    end

    -- -- Font importing system 
        -- Hello skids, i dont know why you are overwriting a table and using setreadonly this is so unneccessary and removes solara support.. ;(

        if not isfile(library.directory .. "/fonts/main.ttf") then 
            writefile(library.directory .. "/fonts/main.ttf", game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/fs-tahoma-8px.ttf"))
        end
        
        local tahoma = {
            name = "SmallestPixel7",
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
            writefile(library.directory .. "/fonts/main_encoded.ttf", http_service:JSONEncode(tahoma))
        end 
        
        library.font = Font.new(getcustomasset(library.directory .. "/fonts/main_encoded.ttf"), Enum.FontWeight.Regular)
        -- library.font = library.font
    -- -- 

    --library.font = Font.new("rbxasset://fonts/families/Zekton.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
-- 

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties) 
            local tween = tween_service:Create(obj, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end 

        function library:closeCurrentElement(cfg) 
            local path = library.current_element_open 

            if path and path ~= cfg then 
                path.setVisible(false)
                path.open = false 
            end
        end 

        function library:makeResizable(frame) 
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

        function library:mouseInFrame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        library.lerp = LPH_NO_VIRTUALIZE(function(start, finish, t)
            t = t or 1 / 8

            return start * (1 - t) + finish * t
        end)

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

        function library:convertEnum(enum)
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
        function library:configListUpdate() 
            if not config_holder then return end 
        
            local list = {}
        
            for idx, file in next, listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "\\configs\\", ""):gsub(".cfg", "")
                list[#list + 1] = name
            end
            
            config_holder.refresh_options(list)
        end 

        function library:getConfig()
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

        function library:loadConfig(config_json) 
            local config = http_service:JSONDecode(config_json)
        
            for _, v in next, config do 
                local function_set = library.config_flags[_]
                
                if function_set then 
                    if type(v) == "table" and not v["active"] then
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

        function library:applyTheme(instance, theme, property) 
            insert(themes.utility[theme][property], instance)
        end

        function library:updateTheme(theme, color)
            for _, property in next, themes.utility[theme] do 

                for m, object in next, property do 
                    if object[_] == themes.preset[theme] or object.ClassName == "UIGradient" then 
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

        function library:applyStroke(parent) 
            local STROKE = library:create("UIStroke", {
                Parent = parent,
                Color = themes.preset.text_outline, 
                LineJoinMode = Enum.LineJoinMode.Miter
            }) 

            library:applyTheme(STROKE, "text_outline", "Color")
        end

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in next, options do 
                ins[prop] = value
            end
            
            -- if instance == "TextLabel" or instance == "TextButton" or instance == "TextBox" then 	
            --     library:apply_theme(ins, "text", "TextColor3")
            --     library:applyStroke(ins)
            -- end 
            
            return ins 
        end

        function library:unloadMenu() 
            if library.gui then 
                library.gui:Destroy()
            end
            
            for index, connection in next, library.connections do 
                connection:Disconnect() 
                connection = nil 
            end     
            
            getgenv().library = nil 
        end 

        function library:initializeColorPicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or tostring(2^789),

                color = options.color or color(1, 1, 1), -- Default to white color if not provided
                alpha = options.alpha or 1,

                callback = options.callback or function() end,
                open = false 
            }

            flags[cfg.flag] = {
                ["animation"] = "None",
                ["animationSpeed"] = 0.2,
                ["color1"] = {
                    Color3.fromRGB(255, 255, 255), 
                    0  
                },
                ["color2"] = {
                    Color3.fromRGB(255, 0, 255), 
                    0
                }
            } 

            local flagDirectory = flags[cfg.flag]

            local draggingSaturation = false
            local draggingHue = false
            local draggingAlpha = false

            local OUTLINE = library:create("Frame", {
                Parent = library.gui,
                Name = "",
                Visible = false, 
                Position = dim2(0, 120, 0, 228),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 150, 0, 150),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(1, 1, 1),
                ZIndex = 999, 
            })

            library:draggify(OUTLINE)
            library:makeResizable(OUTLINE)

            cfg.outline = OUTLINE
            
            local inline = library:create("Frame", {
                Parent = OUTLINE,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(45, 45, 45)
            })  
            
            local INSTANCE_HOLDERS = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(12, 12, 12)
            })

            local h, s, v = color(1, 1, 1):ToHSV() 
            local a = 0

            -- Color Selections
                local colorpicker_picker = library:create("Frame", {
                    Parent = INSTANCE_HOLDERS,
                    Name = "",
                    Visible = true,
                    BorderColor3 = rgb(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, 20),
                    Size = dim2(1, 0, 1, -26),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local outline = library:create("Frame", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Position = dim2(0, 6, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -62, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local inline = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })

                local dragging_sat_val = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    Size = dim2(0, 2, 0, 2),
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255),
                    ZIndex = 3, 
                })
                
                library:create("UIStroke", {
                    Parent = dragging_sat_val,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })                
                
                local sat = library:create("TextButton", {
                    Parent = background,
                    Name = "",
                    Size = dim2(1, 0, 1, 0),
                    Text = "", 
                    AutoButtonColor = false, 
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = sat,
                    Name = "",
                    Rotation = 270,
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)},
                    Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                })
                
                local val = library:create("TextButton", {
                    Parent = background,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    Rotation = 180,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = val,
                    Name = "",
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                })
                
                local hue = library:create("TextButton", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    AnchorPoint = vec2(1, 0),
                    Position = dim2(1, -32, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 16, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local outline = library:create("Frame", {
                    Parent = hue,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local Frame = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = Frame,
                    Name = "",
                    Rotation = 270,
                    Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))}
                })
                
                local hue_picker = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    BorderMode = Enum.BorderMode.Inset,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 4),
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local alpha = library:create("TextButton", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    AnchorPoint = vec2(1, 0),
                    Position = dim2(1, -8, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 16, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local outline = library:create("Frame", {
                    Parent = alpha,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local alpha_drag = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local alpha_picker = library:create("Frame", {
                    Parent = alpha_drag,
                    Name = "",
                    BorderMode = Enum.BorderMode.Inset,
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    Size = dim2(1, 0, 0, 4),
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local alphaind = library:create("ImageLabel", {
                    Parent = alpha_drag,
                    Name = "",
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = rgb(0, 0, 0),
                    Image = "rbxassetid://18274452449",
                    BackgroundTransparency = 1,
                    Size = dim2(1, 0, 1, 0),
                    TileSize = dim2(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = alphaind,
                    Name = "",
                    Rotation = 90,
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                })
            -- 

            -- Animations Tab 
                cfg["animations"] = library:create("Frame", {
                    Parent = INSTANCE_HOLDERS,
                    Name = "",
                    Visible = false, 
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, 20),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, -32),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                cfg["colorpickerElements"] = library:create("Frame", {
                    Parent = cfg["animations"],
                    Name = "",
                    Position = dim2(0, 8, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -16, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                library:create("UIListLayout", {
                    Parent = cfg["colorpickerElements"],
                    Name = "",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = dim(0, 3)
                })

                local elements = setmetatable(cfg, library)

                local dropdown = elements:addDropdown({
                    name = "animation", 
                    items = {"None", "Fade", "Rainbow"},
                    ignore = true,
                    multi = false, 
                    callback = function(option)
                        flagDirectory["animation"] = option

                        if color2 then 
                            color1.setVisible(false)
                            color2.setVisible(false)
                        end 
                    end 
                })

                local color1 = dropdown:addColorPicker({
                    color = rgb(255, 255, 255), 
                    alpha = 1, 
                    animation = "single",
                    ignore = true, 
                    callback = function(color, alpha)
                        flagDirectory["color1"] = {color, alpha}
                    end
                }) 

                local color2 = dropdown:addColorPicker({
                    color = rgb(255, 255, 255), 
                    alpha = 1, 
                    animation = "single",
                    ignore = true, 
                    callback = function(color, alpha)
                        flagDirectory["color2"] = {color, alpha}
                    end
                })  

                elements:addSlider({
                    name = "animation speed",
                    min = 0, 
                    max = 100, 
                    default = 0.2, 
                    interval = 0.01, 
                    suffix = "%", 
                    callback = function(int)
                        flagDirectory["animationSpeed"] = int
                    end
                })
            -- 
            
            -- Tab Button Holders
                local text_holder = library:create("Frame", {
                    Parent = INSTANCE_HOLDERS,
                    Name = "",
                    BackgroundTransparency = 1,
                    --AnchorPoint = vec2(0, 1),
                    Position = dim2(0, 0, 0, 5),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = text_holder,
                    Name = "",
                    Padding = dim(0, 10),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local colorpicker_tab = library:create("TextButton", {
                    Parent = text_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = themes.preset.accent,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "color",
                    AnchorPoint = vec2(1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                })library:applyTheme(colorpicker_tab, "accent", "TextColor3")
                
                cfg["animations_tab"] = library:create("TextButton", {
                    Parent = text_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = rgb(180, 180, 180),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "animations",
                    AnchorPoint = vec2(1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIPadding = library:create("UIPadding", {
                    Parent = text_holder,
                    Name = "",
                    PaddingLeft = dim(0, 10)
                })
            -- 

            -- Functions 
                function cfg.updateColor() 
                    local mouse = uis:GetMouseLocation() 
                    
                    if draggingSaturation then	
                        s = clamp((vec2(mouse.X, mouse.Y - gui_offset) - val.AbsolutePosition).X / val.AbsoluteSize.X, 0, 1)
                        v = 1 - clamp((vec2(mouse.X, mouse.Y - gui_offset) - sat.AbsolutePosition).Y / sat.AbsoluteSize.Y, 0, 1)
                    elseif draggingHue then 
                        h = clamp(1 - (vec2(mouse.X, mouse.Y - gui_offset) - hue.AbsolutePosition).Y / hue.AbsoluteSize.Y, 0, 1)
                    elseif draggingAlpha then 
                        a = clamp((vec2(mouse.X, mouse.Y - gui_offset) - alpha.AbsolutePosition).Y / alpha.AbsoluteSize.Y, 0, 1)
                    end

                    cfg.set(nil, nil)
                end  

                function cfg.setVisible(bool)
                    cfg.outline.Visible = bool

                    if bool then 
                        library:closeCurrentElement(cfg)
                        library.current_element_open = cfg 
                    end
                end 

                function cfg.set(color, alpha)                    
                    if color then 
                        h, s, v = color:ToHSV()
                    end 
                    
                    if alpha then 
                        a = alpha
                    end 
                    
                    local Color = hsv(h, s, v)
                    
                    -- Editing the window colorpicker
                        -- Hue
                        local value = 1 - h
                        local offset = (value < 1) and 0 or -4
                        hue_picker.Position = dim2(0, 0, value, offset)

                        -- Alpha
                        local offset = (a < 1) and 0 or -4
                        alpha_picker.Position = dim2(0, 0, a, offset)
                        alpha_drag.BackgroundColor3 = hsv(h, s, v)

                        -- Sat / Val
                        local s_offset = (s < 1) and 0 or -3
                        local v_offset = (1 - v < 1) and 0 or -3
                        dragging_sat_val.Position = dim2(s, s_offset, 1 - v, v_offset)

                        val.BackgroundColor3 = hsv(h, 1, 1)
                        sat.BackgroundColor3 = hsv(h, 1, 1)
                    -- 

                    -- For the origin colorpicker
                        options.alphaPath.ImageTransparency = a 
                        options.colorPath.BackgroundColor3 = Color
                    -- 

                    if cfg.callback then 
                        cfg.callback(Color, a)
                    end 

                    flags[cfg.flag] = {
                        Color = Color, 
                        Transparency = a,
                    }
                end 

                cfg.set(cfg.color, cfg.alpha)
            -- 

            -- Connections
                colorpicker_tab.MouseButton1Click:Connect(function()
                    cfg["animations"].Visible = false 
                    colorpicker_picker.Visible = true 

                    colorpicker_tab.TextColor3 = themes.preset.accent
                    cfg["animations_tab"].TextColor3 = rgb(180, 180, 180)
                end)

                cfg["animations_tab"].MouseButton1Click:Connect(function()
                    cfg["animations"].Visible = true 
                    colorpicker_picker.Visible = false 

                    colorpicker_tab.TextColor3 = rgb(180, 180, 180)
                    cfg["animations_tab"].TextColor3 = themes.preset.accent
                end)

                -- Colorpicker Init 
                    alpha.MouseButton1Down:Connect(function()
                        draggingAlpha = true 
                    end)    
        
                    hue.MouseButton1Down:Connect(function()
                        draggingHue = true 
                    end)
        
                    sat.MouseButton1Down:Connect(function()
                        draggingSaturation = true  
                    end)
        
                    uis.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            draggingSaturation = false
                            draggingHue = false
                            draggingAlpha = false 
                        end
                    end)
                    
                    uis.InputChanged:Connect(function(input)
                        if (draggingSaturation or draggingHue or draggingAlpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                            cfg.updateColor() 
                        end
                    end)	
                -- 

                task.spawn(function()
                    while true do 
                        local anim = flagDirectory["animation"] 

                        if anim ~= "None" then 
                            local color; 
                            local alpha; 
                            local sin = abs(sin(tick() * flagDirectory["animationSpeed"]))

                            color = anim == "Rainbow" and hsv(sin, 1, 1) or flagDirectory["color2"][1]:Lerp(flagDirectory["color1"][1], sin)
                            alpha = anim == "Rainbow" and a or library.lerp(flagDirectory["color2"][2], flagDirectory["color1"][2], sin) 

                            cfg.set(color, alpha)
                        end 

                        task.wait() 
                    end 
                end)
            -- 
                
            return setmetatable(cfg, library)
        end 

        function library:keyPicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or tostring(2^789),

                color = options.color or color(1, 1, 1), -- Default to white color if not provided
                alpha = options.alpha or 1,

                ignore = options.ignore or false, 

                callback = options.callback or function() end,
                open = false 
            }

            local draggingSaturation = false
            local draggingHue = false
            local draggingAlpha = false

            local OUTLINE = library:create("Frame", {
                Parent = library.gui,
                Name = "",
                Visible = false, 
                Position = dim2(0, 120, 0, 228),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 261, 0, 236),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(1, 1, 1),
                ZIndex = 999, 
            })

            library:draggify(OUTLINE)
            library:makeResizable(OUTLINE)

            cfg.outline = OUTLINE
            
            local inline = library:create("Frame", {
                Parent = OUTLINE,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(45, 45, 45)
            })  
            
            local INSTANCE_HOLDERS = library:create("Frame", {
                Parent = inline,
                Name = "",
                Position = dim2(0, 1, 0, 1),
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(1, -2, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(12, 12, 12)
            })

            local h, s, v = color(1, 1, 1):ToHSV() 
            local a = 0

            -- Color Selections
                local colorpicker_picker = library:create("Frame", {
                    Parent = INSTANCE_HOLDERS,
                    Name = "",
                    Visible = true,
                    BorderColor3 = rgb(0, 0, 0),
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, 20),
                    Size = dim2(1, 0, 1, -26),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local outline = library:create("Frame", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Position = dim2(0, 6, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -62, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local inline = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })

                local dragging_sat_val = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    Size = dim2(0, 2, 0, 2),
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255),
                    ZIndex = 3, 
                })
                
                library:create("UIStroke", {
                    Parent = dragging_sat_val,
                    Name = "",
                    LineJoinMode = Enum.LineJoinMode.Miter
                })                
                
                local sat = library:create("TextButton", {
                    Parent = background,
                    Name = "",
                    Size = dim2(1, 0, 1, 0),
                    Text = "", 
                    AutoButtonColor = false, 
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = sat,
                    Name = "",
                    Rotation = 270,
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)},
                    Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                })
                
                local val = library:create("TextButton", {
                    Parent = background,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    Rotation = 180,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = val,
                    Name = "",
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                })
                
                local hue = library:create("TextButton", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    AnchorPoint = vec2(1, 0),
                    Position = dim2(1, -32, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 16, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local outline = library:create("Frame", {
                    Parent = hue,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local Frame = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = Frame,
                    Name = "",
                    Rotation = 270,
                    Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))}
                })
                
                local hue_picker = library:create("Frame", {
                    Parent = Frame,
                    Name = "",
                    BorderMode = Enum.BorderMode.Inset,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 4),
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local alpha = library:create("TextButton", {
                    Parent = colorpicker_picker,
                    Name = "",
                    Text = "", 
                    AutoButtonColor = false, 
                    AnchorPoint = vec2(1, 0),
                    Position = dim2(1, -8, 0, 6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 16, 1, -5),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(1, 1, 1)
                })
                
                local outline = library:create("Frame", {
                    Parent = alpha,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local alpha_drag = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local alpha_picker = library:create("Frame", {
                    Parent = alpha_drag,
                    Name = "",
                    BorderMode = Enum.BorderMode.Inset,
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 2,
                    Size = dim2(1, 0, 0, 4),
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local alphaind = library:create("ImageLabel", {
                    Parent = alpha_drag,
                    Name = "",
                    ScaleType = Enum.ScaleType.Tile,
                    BorderColor3 = rgb(0, 0, 0),
                    Image = "rbxassetid://18274452449",
                    BackgroundTransparency = 1,
                    Size = dim2(1, 0, 1, 0),
                    TileSize = dim2(0, 6, 0, 6),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 183, 0)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = alphaind,
                    Name = "",
                    Rotation = 90,
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                })
            -- 
            
            -- Tab Button Holders
                local text_holder = library:create("Frame", {
                    Parent = INSTANCE_HOLDERS,
                    Name = "",
                    BackgroundTransparency = 1,
                    --AnchorPoint = vec2(0, 1),
                    Position = dim2(0, 0, 0, 5),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 12),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local UIListLayout = library:create("UIListLayout", {
                    Parent = text_holder,
                    Name = "",
                    Padding = dim(0, 10),
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                local colorpicker_tab = library:create("TextButton", {
                    Parent = text_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = themes.preset.accent,
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "color",
                    AnchorPoint = vec2(1, 0),
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                })library:applyTheme(colorpicker_tab, "accent", "TextColor3")
                
                local UIPadding = library:create("UIPadding", {
                    Parent = text_holder,
                    Name = "",
                    PaddingLeft = dim(0, 10)
                })
            -- 

            -- Functions 
                function cfg.updateColor() 
                    local mouse = uis:GetMouseLocation() 
                    
                    if draggingSaturation then	
                        s = clamp((vec2(mouse.X, mouse.Y - gui_offset) - val.AbsolutePosition).X / val.AbsoluteSize.X, 0, 1)
                        v = 1 - clamp((vec2(mouse.X, mouse.Y - gui_offset) - sat.AbsolutePosition).Y / sat.AbsoluteSize.Y, 0, 1)
                    elseif draggingHue then 
                        h = clamp(1 - (vec2(mouse.X, mouse.Y - gui_offset) - hue.AbsolutePosition).Y / hue.AbsoluteSize.Y, 0, 1)
                    elseif draggingAlpha then 
                        a = clamp((vec2(mouse.X, mouse.Y - gui_offset) - alpha.AbsolutePosition).Y / alpha.AbsoluteSize.Y, 0, 1)
                    end

                    cfg.set(nil, nil)
                end  

                function cfg.setVisible(bool)
                    cfg.outline.Visible = bool

                    if bool then 
                        library:closeCurrentElement(cfg)
                        library.current_element_open = cfg 
                    end
                end 

                function cfg.set(color, alpha) 
                    if color then 
                        h, s, v = color:ToHSV()
                    end 
                
                    if alpha then 
                        a = alpha
                    end 
                    
                    local Color = hsv(h, s, v)
                    
                    -- Editing the window colorpicker
                        -- Hue
                        local value = 1 - h
                        local offset = (value < 1) and 0 or -4
                        hue_picker.Position = dim2(0, 0, value, offset)

                        -- Alpha
                        local offset = (a < 1) and 0 or -4
                        alpha_picker.Position = dim2(0, 0, a, offset)
                        alpha_drag.BackgroundColor3 = hsv(h, s, v)

                        -- Sat / Val
                        local s_offset = (s < 1) and 0 or -3
                        local v_offset = (1 - v < 1) and 0 or -3
                        dragging_sat_val.Position = dim2(s, s_offset, 1 - v, v_offset)

                        val.BackgroundColor3 = hsv(h, 1, 1)
                        sat.BackgroundColor3 = hsv(h, 1, 1)
                    -- 

                    -- For the origin colorpicker
                        options.alphaPath.ImageTransparency = a 
                        options.colorPath.BackgroundColor3 = Color
                    -- 

                    if cfg.callback then 
                        cfg.callback(Color, a)
                    end 
                    flags[cfg.flag] = {
                        Color = Color;
                        Transparency = a 
                    }
                end 
                
                cfg.set(cfg.color, cfg.alpha)
                
                library.config_flags[cfg.flag] = cfg.set
            -- 

            -- Connections
                -- Colorpicker Init 
                    alpha.MouseButton1Down:Connect(function()
                        draggingAlpha = true 
                    end)    
        
                    hue.MouseButton1Down:Connect(function()
                        draggingHue = true 
                    end)
        
                    sat.MouseButton1Down:Connect(function()
                        draggingSaturation = true  
                    end)
        
                    uis.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            draggingSaturation = false
                            draggingHue = false
                            draggingAlpha = false 
                        end
                    end)
                    
                    uis.InputChanged:Connect(function(input)
                        if (draggingSaturation or draggingHue or draggingAlpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                            cfg.updateColor() 
                        end
                    end)	
                -- 
            -- 

            return setmetatable(cfg, library)
        end 
    --
        
    -- Library element functions
        function library:window(properties)
            local cfg = {
                name = properties.name or properties.Name or os.date('<font color="rgb(170,85,235)">obelus</font> | %b %d %Y | %H:%M'),
                size = properties.size or properties.Size or dim2(0, 516, 0, 563),
                selected_tab, 
                is_closing_menu = false,
            }

            library.gui = library:create("ScreenGui", {
                Parent = coregui,
                Name = "",
                Enabled = true,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                IgnoreGuiInset = true,
            })

            local outline = library:create("Frame", {
                Parent = library.gui,
                Name = "",
                Position = dim2(0.5, 0 - (cfg.size.X.Offset / 2), 0.5, 0 - (cfg.size.X.Offset / 2)),
                BorderColor3 = rgb(0, 0, 0),
                Size = cfg.size,
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(0, 0, 0)
            }); outline.Position = dim_offset(outline.AbsolutePosition.X, outline.AbsolutePosition.Y) -- gay dragging fix

            -- local glow = library:create("ImageLabel", {
            --     Parent = outline,
            --     Name = "",
            --     ImageColor3 = themes.preset.accent,
            --     ScaleType = Enum.ScaleType.Slice,
            --     BorderColor3 = rgb(0, 0, 0),
            --     BackgroundColor3 = rgb(255, 255, 255),
            --     Visible = true,
            --     Image = "http://www.roblox.com/asset/?id=18245826428",
            --     BackgroundTransparency = 1,
            --     ImageTransparency = 0.8, 
            --     Position = dim2(0, -20, 0, -20),
            --     Size = dim2(1, 40, 1, 40),
            --     ZIndex = 2,
            --     BorderSizePixel = 0,
            --     SliceCenter = rect(vec2(21, 21), vec2(79, 79))
            -- }); library:applyTheme(glow, "accent", "ImageColor3")

            library:draggify(outline)
            library:makeResizable(outline)
             
            -- Instances 
                local inline = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(48, 48, 48)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(12, 12, 12)
                })
                
                local title_holder = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    BackgroundTransparency = 1,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 29),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local ui_title = library:create("TextLabel", {
                    Parent = title_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = rgb(135, 135, 135),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = cfg.name,
                    Size = dim2(1, 0, 0, 24),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    RichText = true,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local accent_line = library:create("Frame", {
                    Parent = title_holder,
                    Name = "",
                    Position = dim2(0, 0, 1, -6),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = themes.preset.accent
                }); library:applyTheme(accent_line, "accent", "BackgroundColor3")
                
                library:create("UIGradient", {
                    Parent = accent_line,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(109, 109, 109))}
                })
                
                cfg["tab_holder"] = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, 30),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 0, 30),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                library:create("UIListLayout", {
                    Parent = cfg["tab_holder"],
                    Name = "",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = dim(0, -1),
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
                
                library:create("UIPadding", {
                    Parent = background,
                    Name = "",
                    PaddingBottom = dim(0, 11),
                    PaddingRight = dim(0, 9),
                    PaddingLeft = dim(0, 9)
                })
                
                local page_holder = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    Position = dim2(0, 0, 0, 66),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, 0, 1, -66),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(0, 0, 0)
                })
                
                local inline = library:create("Frame", {
                    Parent = page_holder,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(51, 51, 51)
                })
                
                cfg["page_holder"] = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(13, 13, 13)
                }) 
            -- 

            -- Functions 
                local old_data = {} 
                local text_data = {} 
                local image_data = {} 
                local scroll_data = {}

                function cfg.toggle_menu(bool)
                    if not cfg.is_closing_menu then
                        cfg.is_closing_menu = true
                
                        if bool == true then
                            for element, original_transparency in next, old_data do
                                library:tween(element, {
                                    BackgroundTransparency = original_transparency,
                                }, 0.5)
                            end
                
                            for element, original_transparency in next, text_data do
                                library:tween(element, {
                                    TextTransparency = original_transparency,
                                }, 0.5)
                            end
                
                            for element, original_transparency in next, image_data do
                                library:tween(element, {
                                    ImageTransparency = original_transparency,
                                }, 0.5)
                            end

                            for element, original_transparency in next, scroll_data do
                                library:tween(element, {
                                    ScrollBarImageTransparency = original_transparency,
                                }, 0.5)
                            end
                            
                        else
                            for _, element in next, library.gui:GetDescendants() do
                                if not element:IsA("GuiObject") then
                                    continue
                                end
                
                                old_data[element] = element.BackgroundTransparency
                                library:tween(element, {
                                    BackgroundTransparency = 1,
                                }, 0.5)
                
                                if element:IsA("TextLabel") or element:IsA("TextButton") or element:IsA("TextBox") then
                                    text_data[element] = element.TextTransparency
                                    library:tween(element, {
                                        TextTransparency = 1,
                                    }, 0.5)
                                end
                
                                if element:IsA("ImageLabel") or element:IsA("ImageButton") then
                                    image_data[element] = element.ImageTransparency
                                    library:tween(element, {
                                        ImageTransparency = 1,
                                    }, 0.5)
                                end

                                if element:IsA("ScrollingFrame") then 
                                    scroll_data[element] = element.ScrollBarImageTransparency
                                    library:tween(element, {
                                        ScrollBarImageTransparency = 1,
                                    }, 0.5)
                                end 
                            end
                        end
                        
                        task.delay(0.5, function()
                            cfg.is_closing_menu = false 

                        end)
                    end
                end
            -- 

            return setmetatable(cfg, library)
        end 

        function library:tab(properties)
            local cfg = {
                name = properties.name or "visuals", 
            } 

            -- tab button
                local outline = library:create("TextButton", {
                    Parent = self.tab_holder,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = rgb(0, 0, 0),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    Size = dim2(0, 0, 0, 30),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = rgb(0, 0, 0)
                })
                
                local inline = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(41, 41, 41)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local gradient = library:create("UIGradient", {
                    Parent = background,
                    Name = "",
                    Rotation = 90,
                    Color = rgbseq{
                        rgbkey(0, rgb(41, 41, 41)), 
                        rgbkey(1, rgb(16, 16, 16))
                    }
                })
                
                local text = library:create("TextLabel", {
                    Parent = background,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = rgb(140, 140, 140),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = cfg.name,
                    BackgroundTransparency = 1,
                    Position = dim2(0, 0, 0, -1),
                    Size = dim2(1, 0, 1, 0),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:applyTheme(text, "accent", "TextColor3")
            -- 

            -- page 
                cfg["page"] = library:create("Frame", {
                    Parent = self.page_holder,
                    Name = "",
                    Visible = false, 
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(13, 13, 13)
                })
                
                library:create("UIListLayout", {
                    Parent = cfg["page"],
                    Name = "",
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Padding = dim(0, 11),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                })
                
                library:create("UIPadding", {
                    Parent = cfg["page"],
                    Name = "",
                    PaddingTop = dim(0, 11),
                    PaddingBottom = dim(0, 11),
                    PaddingRight = dim(0, 11),
                    PaddingLeft = dim(0, 11)
                })
            -- 

            function cfg.open_tab() 
                library:closeCurrentElement() 

                if self.selected_tab then 
                    self.selected_tab[1].TextColor3 = rgb(160,160,160)
                    self.selected_tab[2].Visible = false 
                    self.selected_tab[3].Color = rgbseq{
                        rgbkey(0, rgb(41, 41, 41)),
                        rgbkey(1, rgb(16, 16, 16))
                    }

                    self.selected_tab = nil 
                end 

                text.TextColor3 = themes.preset.accent
                cfg["page"].Visible = true 
                gradient.Color = rgbseq{
                    rgbkey(0, rgb(41, 41, 41)),
                    rgbkey(1, rgb(25, 25, 25))
                }
                self.selected_tab = {text, cfg["page"], gradient}
            end 

            outline.MouseButton1Down:Connect(function()
                cfg.open_tab()
            end)

            if not self.selected_tab then 
                cfg.open_tab(true) 
            end 

            return setmetatable(cfg, library)    
        end 

        function library:column(properties)
            local cfg = {
                fill = properties.fill or properties.Fill or false, 
            }

            cfg["column"] = library:create("Frame", {
                Parent = self.page,
                Name = "",
                BackgroundTransparency = 1,
                BorderColor3 = rgb(0, 0, 0),
                Size = dim2(0, 100, 0, 100),
                BorderSizePixel = 0,
                BackgroundColor3 = rgb(12, 12, 12)
            })
            
            library:create("UIListLayout", {
                Parent = cfg["column"],
                Name = "",
                Padding = dim(0, 12),
                SortOrder = Enum.SortOrder.LayoutOrder, 
                VerticalFlex = cfg.fill and Enum.UIFlexAlignment.Fill or Enum.UIFlexAlignment.None
            })

            return setmetatable(cfg, library)
        end 

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section", 
                size = properties.size or properties.Size or dim2(1, 0, 1, -12)
            }   

            -- Instances
                local outline = library:create("Frame", {
                    Parent = self.column,
                    Name = "",
                    BorderColor3 = rgb(0, 0, 0),
                    Size = self.fill and dim2(1, 0, 0, 0) or cfg.size,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(12, 12, 12)
                })
                
                local inline = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local background = library:create("Frame", {
                    Parent = inline,
                    Name = "",
                    Position = dim2(0, 1, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -2, 1, -2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(19, 19, 19)
                })

                local scrollbar_fill = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    Visible = false, 
                    Size = dim2(0, 5, 1, 0),
                    Position = dim2(1, -5, 0, 0),
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 4,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(45, 45, 45)
                })
                
                local shadow = library:create("Frame", {
                    Parent = background,
                    Name = "",
                    Size = dim2(1, -5, 0, 21),
                    Position = dim2(0, 0, 1, -21),
                    BorderColor3 = rgb(0, 0, 0),
                    ZIndex = 999,
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(19, 19, 19)
                })
                
                local UIGradient = library:create("UIGradient", {
                    Parent = shadow,
                    Name = "",
                    Rotation = -90,
                    Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                })
                
                local elements_scroll = library:create("ScrollingFrame", {
                    Parent = background,
                    Name = "",
                    ScrollBarImageColor3 = rgb(65, 65, 65),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 4,
                    BorderColor3 = rgb(0, 0, 0),
                    BackgroundTransparency = 1,
                    Size = dim2(1, 0, 1, 0),
                    BackgroundColor3 = rgb(255, 255, 255),
                    ZIndex = 5,
                    BorderSizePixel = 0,
                    CanvasSize = dim2(0, 0, 0, 0)
                })
                
                cfg["elements"] = library:create("Frame", {
                    Parent = elements_scroll,
                    Name = "",
                    Position = dim2(0, 8, 0, 16),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(1, -16, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                library:create("UIListLayout", {
                    Parent = cfg["elements"],
                    Name = "",
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    Padding = dim(0, 3)
                })
                
                local empty_space = library:create("Frame", {
                    Parent = cfg["elements"],
                    Name = "",
                    LayoutOrder = 9999999,
                    BackgroundTransparency = 1,
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, 0, 0, 50),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(255, 255, 255)
                })
                
                local section_title = library:create("TextLabel", {
                    Parent = outline,
                    Name = "",
                    FontFace = library.font,
                    TextColor3 = rgb(205, 205, 205),
                    BorderColor3 = rgb(0, 0, 0),
                    Text = cfg.name,
                    AutomaticSize = Enum.AutomaticSize.XY,
                    AnchorPoint = vec2(0, 0.5),
                    Position = dim2(0, 14, 0, 3),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    ZIndex = 2,
                    TextSize = 12,
                    BackgroundColor3 = rgb(19, 19, 19)
                })

                local section_filler = library:create("Frame", {
                    Parent = outline,
                    Name = "",
                    AnchorPoint = vec2(0, 0.5),
                    Position = dim2(0, 13, 0, 1),
                    BorderColor3 = rgb(0, 0, 0),
                    Size = dim2(0, section_title.TextBounds.X, 0, 3),
                    BorderSizePixel = 0,
                    BackgroundColor3 = rgb(19, 19, 19)
                })
            -- 

            -- Connections 
                elements_scroll:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
                    scrollbar_fill.Visible = elements_scroll.AbsoluteCanvasSize.Y > background.AbsoluteSize.Y and true or false 
                end)
            -- 

            return setmetatable(cfg, library)
        end 

        -- Elements     
            function library:addToggle(options) 
                local cfg = {
                    enabled = options.enabled or nil,
                    name = options.name or "Toggle",
                    flag = options.flag or tostring(random(1,9999999)),
                    
                    default = options.default or false,
                    folding = options.folding or false, 
                    callback = options.callback or function() end,
                }

                -- Instances 
                    local toggle = library:create("TextLabel", {
                        Parent = self.background or self.elements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(151, 151, 151),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    cfg["right_components"] = library:create("Frame", {
                        Parent = toggle,
                        Name = "",
                        Position = dim2(1, 0, 0, -1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = cfg["right_components"],
                        Name = "",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = dim(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    library:create("UIPadding", {
                        Parent = toggle,
                        Name = ""
                    })
                    
                    local left_components = library:create("Frame", {
                        Parent = toggle,
                        Name = "",
                        BackgroundTransparency = 1,
                        Position = dim2(0, 3, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 14),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = left_components,
                        Name = "",
                        Padding = dim(0, 5),
                        FillDirection = Enum.FillDirection.Horizontal
                    })
                    
                    library:create("UIPadding", {
                        Parent = left_components,
                        Name = "",
                        PaddingBottom = dim(0, 5)
                    })
                    
                    local toggle_button = library:create("TextButton", {
                        Parent = left_components,
                        Name = "",
                        Text = "",
                        Position = dim2(0, 0, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 8, 0, 8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(2, 2, 2),
                        LayoutOrder = -1,
                        AutoButtonColor = false
                    })
                    
                    local inline = library:create("Frame", {
                        Parent = toggle_button,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(63, 63, 63)
                    })
                    
                    library:create("UIGradient", {
                        Parent = inline,
                        Name = "",
                        Rotation = 90,
                        Color = rgbseq{rgbkey(0, rgb(232, 232, 232)), rgbkey(1, rgb(162, 162, 162))}
                    })
                    
                    local accent = library:create("Frame", {
                        Parent = inline,
                        Name = "",
                        Visible = false,
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = themes.preset.accent
                    }); library:applyTheme(accent, "accent", "BackgroundColor3")
                    
                    library:create("UIGradient", {
                        Parent = accent,
                        Name = "",
                        Rotation = 90,
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(109, 109, 109))}
                    })
                    
                    local text = library:create("TextButton", {
                        Parent = left_components,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = cfg.name,
                        BackgroundTransparency = 1,
                        Size = dim2(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })

                    cfg.background = library:create("Frame", {
                        Parent = toggle,
                        Name = "",
                        Visible = false,
                        BorderColor3 = rgb(0, 0, 0),
                        LayoutOrder = 99,
                        Position = dim2(0, 0, 0, 15),
                        Size = dim2(1, self.background and 2 or -6, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })

                    library:create("UIListLayout", {
                        Parent = cfg.background,
                        Name = "",
                        Padding = dim(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical
                    })
                -- 

                -- Functions 
                    function cfg.set(bool) 
                        accent.Visible = bool 
                        cfg.callback(bool)

                        flags[cfg.flag] = bool

                        if cfg.folding then 
                            cfg.background.Visible = bool
                        end 
                    end 

                    cfg.set(cfg.default)

                    library.config_flags[cfg.flag] = cfg.set
                -- 

                -- Connections
                    toggle_button.MouseButton1Click:Connect(function()
                        cfg.enabled = not cfg.enabled 
                        cfg.set(cfg.enabled)
                    end)

                    text.MouseButton1Click:Connect(function()
                        cfg.enabled = not cfg.enabled 
                        cfg.set(cfg.enabled)
                    end)
                -- 

                return setmetatable(cfg, library)
            end
            
            function library:addSlider(options) 
                local cfg = {
                    name = options.name or nil,
                    suffix = options.suffix or "",
                    flag = options.flag or tostring(2^789),
                    callback = options.callback or function() end, 
    
                    min = options.min or options.minimum or 0,
                    max = options.max or options.maximum or 100,
                    intervals = options.interval or options.decimal or 1,
                    default = options.default or 10,
                    value = options.default or 10, 

                    ignore = options.ignore or false, 
                    dragging = false,
                } 

                -- Instances 
                    local slider = library:create("TextLabel", {
                        Parent = self.elements or self.background or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local bottom_components = library:create("Frame", {
                        Parent = slider,
                        Name = "",
                        Position = dim2(0, 15, 0, cfg.name and 13 or 0),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, self.background and 2 or -6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local slider_dragger = library:create("TextButton", {
                        Parent = bottom_components,
                        Name = "",
                        AutoButtonColor = false, 
                        Text = "", 
                        Position = dim2(0, 0, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -27, 1, 8),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(1, 1, 1)
                    })
                    
                    local background = library:create("Frame", {
                        Parent = slider_dragger,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local fill = library:create("Frame", {
                        Parent = background,
                        Name = "",
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 1, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = themes.preset.accent
                    }); library:applyTheme(fill, "accent", "BackgroundColor3")
                    
                    library:create("UIGradient", {
                        Parent = fill,
                        Name = "",
                        Rotation = 90,
                        Color = rgbseq{rgbkey(0, rgb(232, 232, 232)), rgbkey(1, rgb(162, 162, 162))}
                    })
                    
                    local text_slider = library:create("TextLabel", {
                        Parent = fill,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "0%",
                        AnchorPoint = vec2(0.5, 0),
                        BackgroundTransparency = 1,
                        Position = dim2(1, 0, 0, 0),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.XY,
                        TextSize = 12,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIGradient", {
                        Parent = background,
                        Name = "",
                        Rotation = 90,
                        Color = rgbseq{rgbkey(0, rgb(63, 63, 63)), rgbkey(1, rgb(42, 42, 42))}
                    })
                    
                    library:create("UIListLayout", {
                        Parent = bottom_components,
                        Name = "",
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = dim(0, 3),
                        FillDirection = Enum.FillDirection.Vertical
                    })
            
                    library:create("UIPadding", {
                        Parent = slider,
                        Name = "",
                        PaddingLeft = dim(0, 1)
                    })
                    
                    if cfg.name then 
                        local left_components = library:create("Frame", {
                            Parent = slider,
                            Name = "",
                            BackgroundTransparency = 1,
                            Position = dim2(0, 16, 0, 1),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(0, 0, 0, 14),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        local text = library:create("TextLabel", {
                            Parent = left_components,
                            Name = "",
                            FontFace = library.font,
                            TextColor3 = rgb(180, 180, 180),
                            BorderColor3 = rgb(0, 0, 0),
                            Text = cfg.name,
                            BackgroundTransparency = 1,
                            Size = dim2(0, 0, 1, -1),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 12,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        library:create("UIListLayout", {
                            Parent = left_components,
                            Name = "",
                            Padding = dim(0, 5),
                            FillDirection = Enum.FillDirection.Horizontal
                        })
                        
                        library:create("UIPadding", {
                            Parent = left_components,
                            Name = "",
                            PaddingBottom = dim(0, 6)
                        })
                    end 

                    if not self.background then 
                        local seperator = library:create("Frame", {
                            Parent = slider,
                            Name = "",
                            Position = dim2(0, 0, 1, 0),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(0, 0, 0, 5),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                    end 
                -- 

                -- Functions 
                    function cfg.set(value) 
                        cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                        fill.Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)
                        text_slider.Text = tostring(cfg.value) .. cfg.suffix

                        flags[cfg.flag] = cfg.value
                        cfg.callback(flags[cfg.flag])
                    end 

                    cfg.set(cfg.default)
                -- 

                -- Connections
                    slider_dragger.MouseButton1Down:Connect(function()
                        cfg.dragging = true 
                    end)

                    library:connection(uis.InputChanged, function(input)
                        if cfg.dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                            local size_x = (input.Position.X - slider_dragger.AbsolutePosition.X) / slider_dragger.AbsoluteSize.X
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

            function library:addDropdown(options) 
                local cfg = {
                    name = options.name or nil,
                    flag = options.flag or tostring(random(1,9999999)),

                    items = options.items or {"1", "2", "3"},
                    callback = options.callback or function() end,
                    multi = options.multi or false, 
                    scrolling = options.scrolling or false, 

                    -- Ignore these 
                    open = false, 
                    option_instances = {}, 
                    multi_items = {}, 
                    ignore = options.ignore or false, 
                }   

                cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1]

                flags[cfg.flag] = {} 

                -- Instances
                    local dropdown_path = library:create("TextLabel", {
                        Parent = self.background or self.elements or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })

                    cfg["right_components"] = library:create("Frame", {
                        Parent = dropdown_path,
                        Name = "",
                        Position = dim2(1, 0, 0, -1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = cfg["right_components"],
                        Name = "",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = dim(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    local bottom_components = library:create("Frame", {
                        Parent = dropdown_path,
                        Name = "",
                        Position = dim2(0, 15, 0, cfg.name and 11 or 0),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, self.background and 2 or -6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local dropdown = library:create("TextButton", {
                        Parent = bottom_components,
                        Name = "",
                        AutoButtonColor = false, 
                        Text = "",
                        Position = dim2(0, 0, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -27, 1, 20),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(1, 1, 1)
                    })
                    
                    local inline = library:create("Frame", {
                        Parent = dropdown,
                        Name = "",
                        Position = dim2(0, 0, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -1, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(45, 45, 45)
                    })
                    
                    local background = library:create("Frame", {
                        Parent = inline,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(25, 25, 25)
                    })
                    
                    local arrow = library:create("ImageLabel", {
                        Parent = background,
                        Name = "",
                        Image = "rbxassetid://116204929609664",
                        Position = dim2(1, -13, 0, 7),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 5, 0, 3),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })  

                    local text = library:create("TextLabel", {
                        Parent = background,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "players",
                        Size = dim2(1, 0, 1, 0),
                        BackgroundTransparency = 1,
                        Position = dim2(0, 7, 0, -1),
                        BorderSizePixel = 0,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left, 
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })                    
                    
                    if cfg.name then 
                        local left_components = library:create("Frame", {
                            Parent = dropdown_path,
                            Name = "",
                            BackgroundTransparency = 1,
                            Position = dim2(0, 16, 0, 1),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(0, 0, 0, 14),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        local text = library:create("TextLabel", {
                            Parent = left_components,
                            Name = "",
                            FontFace = library.font,
                            TextColor3 = rgb(180, 180, 180),
                            BorderColor3 = rgb(0, 0, 0),
                            Text = cfg.name,
                            BackgroundTransparency = 1,
                            Size = dim2(0, 0, 1, -1),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 12,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        library:create("UIListLayout", {
                            Parent = left_components,
                            Name = "",
                            Padding = dim(0, 5),
                            FillDirection = Enum.FillDirection.Horizontal
                        })
                        
                        library:create("UIPadding", {
                            Parent = left_components,
                            Name = "",
                            PaddingBottom = dim(0, 6)
                        })
                    end 

                    -- local UIStroke = library:create("UIStroke", {
                    --     Parent = dropdown,
                    --     Name = ""
                    -- })
                    
                    local UIPadding = library:create("UIPadding", {
                        Parent = dropdown,
                        Name = "",
                        PaddingLeft = dim(0, 1)
                    })

                    -- Dropdown holder 
                        local dropdown_holder = library:create("Frame", {
                            Parent = library.gui,
                            Name = "",
                            Size = dim2(0, 161, 0, 0),
                            Position = dim2(0, 100, 0, 200),
                            BorderColor3 = rgb(0, 0, 0),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            BackgroundColor3 = rgb(1, 1, 1),
                            Visible = false, 
                            ZIndex = 999
                        })
                        
                        local inline = library:create("Frame", {
                            Parent = dropdown_holder,
                            Name = "",
                            Position = dim2(0, 1, 0, 1),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(1, -2, 1, -2),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(45, 45, 45)
                        })
                        
                        local text_holder = library:create("Frame", {
                            Parent = inline,
                            Name = "",
                            Position = dim2(0, 1, 0, 1),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(1, -2, 1, -2),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(25, 25, 25)
                        })
                        
                        library:create("UIPadding", {
                            Parent = text_holder,
                            Name = "",
                            PaddingTop = dim(0, 2),
                            PaddingBottom = dim(0, 7),
                            PaddingLeft = dim(0, 7)
                        })
                        
                        library:create("UIListLayout", {
                            Parent = text_holder,
                            Name = "",
                            Padding = dim(0, 5),
                            SortOrder = Enum.SortOrder.LayoutOrder
                        })
                    -- 
                -- 

                -- Functions 
                    function cfg.renderOption(text) 
                        local OPTION = library:create("TextButton", {
                            Parent = text_holder,
                            Name = "",
                            FontFace = library.font,
                            TextColor3 = rgb(180, 180, 180),
                            BorderColor3 = rgb(0, 0, 0),
                            Text = text,
                            Size = dim2(0, 0, 0, -1),
                            BackgroundTransparency = 1,
                            Position = dim2(0, 6, 0, -1),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.XY,
                            TextSize = 12,
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); library:applyTheme(OPTION, "accent", "TextColor3")

                        return OPTION
                    end 
                    
                    function cfg.setVisible(bool) 
                        dropdown_holder.Visible = bool

                        arrow.Rotation = bool and 180 or 0 

                        if bool then 
                            library:closeCurrentElement(cfg)
                            library.current_element_open = cfg 
                        end
                    end
                    
                    function cfg.set(value) 
                        local selected = {}
                        local isTable = type(value) == "table"

                        for _, option in next, cfg.option_instances do 
                            if option.Text == value or (isTable and find(value, option.Text)) then 
                                insert(selected, option.Text)
                                cfg.multi_items = selected
                                option.TextColor3 = themes.preset.accent
                            else 
                                option.TextColor3 = rgb(160, 160, 160)
                            end
                        end

                        text.Text = isTable and concat(selected, ", ") or selected[1]
                        flags[cfg.flag] = isTable and selected or selected[1]
                            
                        cfg.callback(flags[cfg.flag]) 
                    end
                    
                    function cfg.refreshOptions(list) 
                        for _, option in next, cfg.option_instances do 
                            option:Destroy() 
                        end
                        
                        cfg.option_instances = {} 

                        for _, option in next, list do 
                            local OPTION_INSTANCE = cfg.renderOption(option)
                            insert(cfg.option_instances, OPTION_INSTANCE)
                            
                            OPTION_INSTANCE.MouseButton1Down:Connect(function()
                                if cfg.multi then 
                                    local selected_index = find(cfg.multi_items, OPTION_INSTANCE.Text)
        
                                    if selected_index then 
                                        remove(cfg.multi_items, selected_index)
                                    else
                                        insert(cfg.multi_items, OPTION_INSTANCE.Text)
                                    end
        
                                    cfg.set(cfg.multi_items) 				
                                else 
                                    cfg.setVisible(false)
                                    cfg.open = false 
                                    
                                    cfg.set(OPTION_INSTANCE.Text)
                                end
                            end)
                        end
                    end

                    cfg.refreshOptions(cfg.items)
                    cfg.set(cfg.default)
                -- 

                -- Connections 
                    dropdown.MouseButton1Click:Connect(function()
                        cfg.open = not cfg.open 
                        
                        cfg.setVisible(cfg.open)
                    end)

                    dropdown:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                        dropdown_holder.Size = dim2(0, dropdown.AbsoluteSize.X, 0, dropdown_holder.Size.Y.Offset)
                    end)
    
                    dropdown:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                        dropdown_holder.Position = dim2(0, dropdown.AbsolutePosition.X, 0, dropdown.AbsolutePosition.Y + 80)
                    end)
                -- 

                return setmetatable(cfg, library)
            end 
            
            function library:addColorPicker(options) 
                local cfg = {
                    name = options.name or "Color", 
                    flag = options.flag or tostring(2^789),

                    color = options.color or color(1, 1, 1), -- Default to white color if not provided
                    alpha = options.alpha or 1,

                    open = false, 
                    type = options.animation or "animation",

                    ignore = options.ignore or false, 

                    callback = options.callback or function() end,
                }

                flags[cfg.flag] = {} 

                -- Instances
                    local outline = library:create("Frame", {
                        Parent = self.right_components,
                        Name = "",
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 18, 0, 9),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(2, 2, 2)
                    })
                    
                    cfg.colorPath = library:create("Frame", {
                        Parent = outline,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(162, 57, 209)
                    })

                    cfg.alphaPath = library:create("ImageLabel", {
                        Parent = cfg.colorPath,
                        Name = "",
                        ScaleType = Enum.ScaleType.Tile,
                        ImageTransparency = 0.28999999165534973,
                        BorderColor3 = rgb(0, 0, 0),
                        Image = "rbxassetid://18274452449",
                        BackgroundTransparency = 1,
                        Size = dim2(1, 0, 1, 0),
                        TileSize = dim2(0, 2, 0, 2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIGradient", {
                        Parent = cfg.colorPath,
                        Name = "",
                        Rotation = 90,
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(152, 152, 152))}
                    })

                    local button = library:create("TextButton", {
                        Parent = outline,
                        Name = "",
                        Text = "",
                        AutoButtonColor = false, 
                        BackgroundTransparency = 1, 
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, 0, 1, 0),
                        BorderSizePixel = 0,
                        ZIndex = 2, 
                        BackgroundColor3 = rgb(2, 2, 2)
                    })
                -- 
                
                local colorpicker = library:keyPicker(cfg)
                
                -- Connections 
                    button.MouseButton1Click:Connect(function()
                        colorpicker.open = not colorpicker.open 
                        colorpicker.setVisible(colorpicker.open)              
                    end)

                    button:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                        colorpicker.outline.Position = dim_offset(button.AbsolutePosition.X + 1, button.AbsolutePosition.Y + button.AbsoluteSize.Y + 63)
                    end)

                    colorpicker.outline.Position = dim_offset(button.AbsolutePosition.X + 1, button.AbsolutePosition.Y + button.AbsoluteSize.Y + 63)
                -- 

                return setmetatable(cfg, library)
            end 

            function library:addLabel(options)
                local cfg = {
                    name = options.name or "Label!",
                }

                -- Instances 
                    local label = library:create("TextLabel", {
                        Parent = self.elements or self.background or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(151, 151, 151),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    cfg["right_components"] = library:create("Frame", {
                        Parent = label,
                        Name = "",
                        Position = dim2(1, 0, 0, -1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = cfg["right_components"],
                        Name = "",
                        VerticalAlignment = Enum.VerticalAlignment.Center,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalAlignment = Enum.HorizontalAlignment.Right,
                        Padding = dim(0, 4),
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    library:create("UIPadding", {
                        Parent = label,
                        Name = ""
                    })
                    
                    local left_components = library:create("Frame", {
                        Parent = label,
                        Name = "",
                        BackgroundTransparency = 1,
                        Position = dim2(0, 3, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 14),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = left_components,
                        Name = "",
                        Padding = dim(0, 5),
                        FillDirection = Enum.FillDirection.Horizontal
                    })
                    
                    library:create("UIPadding", {
                        Parent = left_components,
                        Name = "",
                        PaddingBottom = dim(0, 5)
                    })
                    
                    local text = library:create("TextButton", {
                        Parent = left_components,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = cfg.name,
                        BackgroundTransparency = 1,
                        Size = dim2(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })

                    library:create("UIListLayout", {
                        Parent = cfg.background,
                        Name = "",
                        Padding = dim(0, 3),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        FillDirection = Enum.FillDirection.Vertical
                    })
                -- 

                return setmetatable(cfg, library)
            end 
            
            function library:addTextBox(options) 
                local cfg = {
                    name = options.name or "TextBox",
                    placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                    default = options.default,
                    flag = options.flag or "SET ME NIGGA",
                    callback = options.callback or function() end,
                    visible = options.visible or true,
                }
                
                -- Instances 
                    local textbox_holder = library:create("TextLabel", {
                        Parent = self.background or self.elements or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local bottom_components = library:create("Frame", {
                        Parent = textbox_holder,
                        Name = "",
                        Position = dim2(0, 14, 0, 13),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local textbox = library:create("Frame", {
                        Parent = bottom_components,
                        Name = "",
                        Position = dim2(0, -1, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -27, 1, 20),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(1, 1, 1)
                    })
                    
                    local inline = library:create("Frame", {
                        Parent = textbox,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(45, 45, 45)
                    })
                    
                    local background = library:create("Frame", {
                        Parent = inline,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(19, 19, 19)
                    })
                    
                    local textbox = library:create("TextBox", {
                        Parent = background,
                        Name = "",
                        FontFace = library.font,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextSize = 12,
                        Size = dim2(1, -6, 1, 0),
                        RichText = true,
                        TextColor3 = rgb(178, 178, 178),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "IF I SEE WEED I GOTTA LIGHT IT",
                        CursorPosition = -1,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        Position = dim2(0, 6, 0, 0),
                        BorderSizePixel = 0,
                        PlaceholderColor3 = rgb(178, 178, 178),
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = bottom_components,
                        Name = "",
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    local UIStroke = library:create("UIStroke", {
                        Parent = textbox_holder,
                        Name = ""
                    })
                    
                    local UIPadding = library:create("UIPadding", {
                        Parent = textbox_holder,
                        Name = "",
                        PaddingLeft = dim(0, 1)
                    })
                    
                    local left_components = library:create("Frame", {
                        Parent = textbox_holder,
                        Name = "",
                        BackgroundTransparency = 1,
                        Position = dim2(0, 16, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(0, 0, 0, 14),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local text = library:create("TextLabel", {
                        Parent = left_components,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = cfg.name,
                        BackgroundTransparency = 1,
                        Size = dim2(0, 0, 1, -1),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    library:create("UIListLayout", {
                        Parent = left_components,
                        Name = "",
                        Padding = dim(0, 5),
                        FillDirection = Enum.FillDirection.Horizontal
                    })
                    
                    library:create("UIPadding", {
                        Parent = left_components,
                        Name = "",
                        PaddingBottom = dim(0, 6)
                    })
                -- 
                
                -- Functions
                    function cfg.set(text) 
                        flags[cfg.flag] = text
                        textbox.Text = text
                        cfg.callback(text)
                    end 

                    if cfg.default then 
                        cfg.set(cfg.default) 
                    end 
                -- 

                -- Connections 
                    textbox:GetPropertyChangedSignal("Text"):Connect(function()
                        cfg.set(textbox.Text) 
                    end)
                -- 
                
                return setmetatable(cfg, library)
            end 
            
            function library:addKeyBind(options) 
                local cfg = {
                    flag = options.flag or "SET ME A FLAG NOWWW!!!!",
                    callback = options.callback or function() end,
                    open = false,
                    binding = nil, 
                    name = options.name or nil, 
                    ignore_key = options.ignore or false, 
    
                    key = options.key or nil, 
                    mode = options.mode or "toggle",
                    active = options.default or false, 
    
                    hold_instances = {},
                }

                flags[cfg.flag] = {} 

                -- Instances
                    local outline = library:create("TextButton", {
                        Parent = self.right_components,
                        Name = "",
                        Text = "", 
                        AutoButtonColor = false, 
                        BorderColor3 = rgb(0, 0, 0),
                        BackgroundTransparency = 1,
                        SelectionOrder = -1,
                        Size = dim2(0, 0, 0, 9),
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local text_label = library:create("TextLabel", {
                        Parent = outline,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "[ NIGGER ]",
                        Size = dim2(1, 0, 1, 0),
                        Position = dim2(0, 0, 0, -1),
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        AutomaticSize = Enum.AutomaticSize.X,
                        TextSize = 12,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                
                -- 

                -- Functions 
                    function cfg.set_mode(mode) 
                        cfg.mode = mode 

                        if mode == "always" then
                            cfg.set(true)
                        elseif mode == "hold" then
                            cfg.set(false)
                        end

                        flags[cfg.flag]["mode"] = mode
                    end 

                    function cfg.set(input)
                        if type(input) == "boolean" then 
                            local __cached = input 

                            if cfg.mode == "always" then 
                                __cached = true 
                            end 

                            cfg.active = __cached 
                            cfg.callback(__cached)
                        elseif tostring(input):find("Enum") then 
                            input = input.Name == "Escape" and "..." or input

                            cfg.key = input or "..."	

                            cfg.callback(cfg.active or false)
                        elseif find({"toggle", "hold", "always"}, input) then 
                            cfg.set_mode(input)

                            if input == "always" then 
                                cfg.active = true 
                            end 

                            cfg.callback(cfg.active or false)
                        elseif type(input) == "table" then 
                            input.key = type(input.key) == "string" and input.key ~= "..." and library:convertEnum(input.key) or input.key

                            input.key = input.key == Enum.KeyCode.Escape and "..." or input.key
                            cfg.key = input.key or "..."
                            
                            cfg.mode = input.mode or "toggle"

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
                        
                        text_label.Text = "[" .. string.lower(__text) .. "]"

                        -- KEYBIND LIST
                        -- if cfg.name then 
                        --     KEYBIND_ELEMENT.Visible = cfg.active
                        -- end 

                        -- local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                        -- local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))

                        -- if cfg.name then 
                        --     KEYBIND_ELEMENT.Text = "[ " .. string.upper(string.sub(cfg.mode, 1, 1)) .. string.sub(cfg.mode, 2) .. " ] " .. cfg.name .. " - " .. __text
                        -- end 
                    end
                -- 
                
                -- Connections 
                    outline.MouseButton1Down:Connect(function()
                        task.wait()
                        text_label.Text = "[ ... ]"	

                        cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                            cfg.set(keycode.KeyCode)

                            cfg.binding:Disconnect() 
                            cfg.binding = nil
                        end)
                    end)

                    library:connection(uis.InputBegan, function(input, game_event) 
                        if not game_event then 
                            if input.KeyCode == cfg.key then 
                                if cfg.mode == "toggle" then 
                                    cfg.active = not cfg.active
                                    cfg.set(cfg.active)
                                elseif cfg.mode == "hold" then 
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
                            if cfg.mode == "hold" then 
                                cfg.set(false)
                            end
                        end
                    end)
            
                    cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})
                --      
                    
                config_flags[cfg.flag] = cfg.set

                return setmetatable(cfg, library)
            end

            function library:addList(options)
                local cfg = {
                    callback = options and options.callback or function() end, 
                    name = options.name or nil, 

                    scale = options.size or 232, 
                    items = options.items or {"1", "2", "3"}, 
                    -- order = options.order or 1, 
                    visible = options.visible or true,
            
                    option_instances = {}, 
                    current_instance = nil, 
                    flag = options.flag or "SET A FLAG U NIGGER", 
            
                }
            
                -- Instances
                    local list_path = library:create("TextLabel", {
                        Parent = self.background or self.elements or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local bottom_components = library:create("Frame", {
                        Parent = list_path,
                        Name = "",
                        Position = dim2(0, 15, 0, cfg.name and 11 or 0),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, self.background and 2 or -6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local list = library:create("TextButton", {
                        Parent = bottom_components,
                        Name = "",
                        AutoButtonColor = false, 
                        Text = "",
                        Position = dim2(0, 0, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -27, 0, cfg.scale),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(1, 1, 1)
                    })
                    
                    local inline = library:create("Frame", {
                        Parent = list,
                        Name = "",
                        Position = dim2(0, 0, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -1, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(45, 45, 45)
                    })
                    
                    local background = library:create("Frame", {
                        Parent = inline,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(25, 25, 25)
                    })         

                    local scrollbar_fill = library:create("Frame", {
                        Parent = background,
                        Name = "",
                        Visible = false, 
                        Size = dim2(0, 5, 1, 0),
                        Position = dim2(1, -5, 0, 0),
                        BorderColor3 = rgb(0, 0, 0),
                        ZIndex = 4,
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(45, 45, 45)
                    })

                    local ScrollingFrame = library:create("ScrollingFrame", {
                        Parent = background,
                        Name = "",
                        Active = true,
                        AutomaticCanvasSize = Enum.AutomaticSize.Y,
                        ScrollBarThickness = 4,
                        BackgroundTransparency = 1,
                        ScrollBarImageColor3 = rgb(65, 65, 65),
                        Size = dim2(1, 0, 1, 0),
                        BackgroundColor3 = rgb(255, 255, 255),
                        BorderColor3 = rgb(0, 0, 0),
                        BorderSizePixel = 0,
                        CanvasSize = dim2(0, 0, 0, 0),
                        ZIndex = 999,
                    })

                    local UIPadding = library:create("UIPadding", {
                        Parent = ScrollingFrame,
                        Name = "",
                        PaddingLeft = dim(0, 5),
                        PaddingBottom  = dim(0, 5),
                        PaddingTop  = dim(0, 5),
                        PaddingRight = dim(0, 5)
                    })

                    library:create("UIListLayout", {
                        Parent = ScrollingFrame,
                        Name = "",
                        Padding = dim(0, 5),
                        FillDirection = Enum.FillDirection.Vertical
                    })
                    
                    if cfg.name then 
                        local left_components = library:create("Frame", {
                            Parent = list_path,
                            Name = "",
                            BackgroundTransparency = 1,
                            Position = dim2(0, 16, 0, 1),
                            BorderColor3 = rgb(0, 0, 0),
                            Size = dim2(0, 0, 0, 14),
                            BorderSizePixel = 0,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        local text = library:create("TextLabel", {
                            Parent = left_components,
                            Name = "",
                            FontFace = library.font,
                            TextColor3 = rgb(180, 180, 180),
                            BorderColor3 = rgb(0, 0, 0),
                            Text = cfg.name,
                            BackgroundTransparency = 1,
                            Size = dim2(0, 0, 1, -1),
                            BorderSizePixel = 0,
                            AutomaticSize = Enum.AutomaticSize.X,
                            TextSize = 12,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })
                        
                        library:create("UIListLayout", {
                            Parent = left_components,
                            Name = "",
                            Padding = dim(0, 5),
                            FillDirection = Enum.FillDirection.Horizontal
                        })
                        
                        library:create("UIPadding", {
                            Parent = left_components,
                            Name = "",
                            PaddingBottom = dim(0, 6)
                        })
                    end 
            
                    -- local UIStroke = library:create("UIStroke", {
                    --     Parent = list,
                    --     Name = ""
                    -- })
                    
                    local UIPadding = library:create("UIPadding", {
                        Parent = list,
                        Name = "",
                        PaddingLeft = dim(0, 1)
                    })
                --      
            
                -- Functions
                    function cfg.render_option(text) 
                        local text = library:create("TextButton", {
                            Parent = ScrollingFrame,
                            Name = "",
                            FontFace = library.font,
                            TextColor3 = rgb(180, 180, 180),
                            BorderColor3 = rgb(0, 0, 0),
                            Text = text,
                            Size = dim2(1, 0, 0, 0),
                            BackgroundTransparency = 1,
                            Position = dim2(0, 7, 0, -1),
                            BorderSizePixel = 0,
                            TextSize = 12,
                            AutomaticSize = Enum.AutomaticSize.Y,
                            TextXAlignment = Enum.TextXAlignment.Left, 
                            TextTruncate = Enum.TextTruncate.AtEnd,
                            BackgroundColor3 = rgb(255, 255, 255)
                        })       
                
                        return text 
                    end 
                
                    function cfg.refresh_options(options)
                        for _, v in next, cfg.option_instances do 
                            v:Destroy() 
                        end 
                
                        for _, option in next, options do 
                            local button = cfg.render_option(option) 
                
                            insert(cfg.option_instances, button)
                
                            button.MouseButton1Click:Connect(function()
                                if cfg.current_instance and cfg.current_instance ~= button then 
                                    cfg.current_instance.TextColor3 = rgb(180, 180, 180) 
                                end 
                
                                cfg.current_instance = button 
                                button.TextColor3 = themes.preset.accent 
                
                                flags[cfg.flag] = button.text
                                
                                cfg.callback(button.text)
                            end)
                        end 
                    end
                    
                    function cfg.filter_options(text)
                        for _, v in next, cfg.option_instances do 
                            if string.find(v.Text, text) then 
                                v.Visible = true 
                            else 
                                v.Visible = false
                            end
                        end
                    end
            
                    function cfg.set(value)
                        for _, buttons in next, cfg.option_instances do 
                            if buttons.Text == value then 
                                buttons.TextColor3 = themes.preset.accent 
                            else 
                                buttons.TextColor3 = rgb(180, 180, 180) 
                            end 
                        end 
            
                        flags[cfg.flag] = value
                        cfg.callback(value)
                    end 
            
                    cfg.refresh_options(cfg.items) 
                -- 
                    
                -- Connections 
                    ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
                        scrollbar_fill.Visible = ScrollingFrame.AbsoluteCanvasSize.Y > background.AbsoluteSize.Y and true or false 
                    end)
                -- 

                library.config_flags[cfg.flag] = cfg.set

                return setmetatable(cfg, library)
            end

            function library:addButton(options)
                local cfg = {
                    callback = options.callback or function() end, 
                    name = options.text or options.name or "Button",
                }

                -- Instances 
                    local button_holder = library:create("TextLabel", {
                        Parent = self.background or self.elements or self.colorpickerElements,
                        Name = "",
                        FontFace = library.font,
                        TextColor3 = rgb(180, 180, 180),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = "",
                        ZIndex = 2,
                        Size = dim2(1, -8, 0, 12),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextSize = 11,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local bottom_components = library:create("Frame", {
                        Parent = button_holder, 
                        Name = "",
                        Position = dim2(0, 14, 0, 0),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })
                    
                    local button = library:create("Frame", {
                        Parent = bottom_components,
                        Name = "",
                        Position = dim2(0, -1, 0, 2),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -27, 1, 20),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(1, 1, 1)
                    })
                    
                    local inline = library:create("Frame", {
                        Parent = button,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(45, 45, 45)
                    })
                    
                    local background = library:create("Frame", {
                        Parent = inline,
                        Name = "",
                        Position = dim2(0, 1, 0, 1),
                        BorderColor3 = rgb(0, 0, 0),
                        Size = dim2(1, -2, 1, -2),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(19, 19, 19)
                    })
                    
                    local button = library:create("TextButton", {
                        Parent = background,
                        Name = "",
                        FontFace = library.font,
                        TextTruncate = Enum.TextTruncate.AtEnd,
                        TextSize = 12,
                        Size = dim2(1, -6, 1, 0),
                        RichText = true,
                        TextColor3 = rgb(178, 178, 178),
                        BorderColor3 = rgb(0, 0, 0),
                        Text = cfg.name,
                        BackgroundTransparency = 1,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Position = dim2(0, 6, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundColor3 = rgb(255, 255, 255)
                    })

                    button.MouseButton1Click:Connect(function()
                        cfg.callback() 
                    end)
                    
                    library:create("UIListLayout", {
                        Parent = bottom_components,
                        Name = "",
                        SortOrder = Enum.SortOrder.LayoutOrder
                    })
                    
                    local UIStroke = library:create("UIStroke", {
                        Parent = button_holder,
                        Name = ""
                    })
                    
                    local UIPadding = library:create("UIPadding", {
                        Parent = button_holder,
                        Name = "",
                        PaddingLeft = dim(0, 1)
                    })
                    
            end
        -- 
    -- 
-- 

-- Notification Library
    local notifications = library.notifications

    function notifications:refresh_notifs() 
        local yOffset = 50
        for i, v in ipairs(notifications.notifs) do
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
            outline; 
        }
        
        -- Instances
            local outline = library:create("Frame", {
                Parent = gethui();
                Size = dim2(0, 0, 0, 0);
                BorderColor3 = rgb(0, 0, 0);
                BorderSizePixel = 0;
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
                Text = string.format("[ fecurity.lua ] %s", cfg.name);
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

            local line = library:create( "Frame" , {
                Parent = outline;
                Name = "\0";
                Position = dim2(0, 1, 1, -1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 0, 0, 1);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.accent
            });
            
            local accent = library:create( "Frame" , {
                Parent = outline;
                Name = "\0";
                Position = dim2(0, 1, 0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 1, 1, -1);
                BorderSizePixel = 0;
                BackgroundColor3 = themes.preset.accent
            });
        -- 
        
        local index = #notifications.notifs + 1
        notifications.notifs[index] = outline
        
        notifications:refresh_notifs()
        tween_service:Create(outline, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {AnchorPoint = vec2(0, 0)}):Play()
        
        notifications:fade(outline, false)

        task.spawn(function()
            tween_service:Create(line, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Size = dim2(1, -1, 0, 1)}):Play()
            task.wait(3)
            notifications.notifs[index] = nil
            notifications:fade(outline, true)
            task.wait(1)
            outline:Destroy() 
            notifications:refresh_notifs()
        end)
    end
-- 

return library, notifications, themes
