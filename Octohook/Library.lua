--[[
    Octohook
    -> Made by @finobe 
    -> Kind of got bored idk what to do with life
    -> Reason for leak: 
    User was offered free features when the library was finished as compensation for the wait
    Then proceeded to ask for more and started harassing other customers and me over petty shit. 
    Yes this user said the library is TRASH somehow.. sob

    Anyways bringing u this pretty sexy library I spent like a week on it maybe less. 
    Esp preview took me a couple hours to make but holy the amount of bug fixing is insane

    LIBRARY MAY HAVE MISSING OPTIMISATION THAT IS REQUIRED FOR 0 FPS LOSS WHEN DRAGGING / CLOSING THE MENU. 
    ^^ Dont have to be worried about this its pretty darn optimised for the amount of elements I store 
]]

-- Variables 
    local InputService, HttpService, GuiService, RunService, Stats, CoreGui, TweenService, SoundService, Workspace, Players, Lighting = game:GetService("UserInputService"), game:GetService("HttpService"), game:GetService("GuiService"), game:GetService("RunService"), game:GetService("Stats"), game:GetService("CoreGui"), game:GetService("TweenService"), game:GetService("SoundService"), game:GetService("Workspace"), game:GetService("Players"), game:GetService("Lighting")
    local Camera, LocalPlayer, gui_offset = Workspace.CurrentCamera, Players.LocalPlayer, GuiService:GetGuiInset().Y
    local Mouse = LocalPlayer:GetMouse()
    local vec2, vec3, dim2, dim, rect, dim_offset = Vector2.new, Vector3.new, UDim2.new, UDim.new, Rect.new, UDim2.fromOffset
    local color, rgb, hex, hsv, rgbseq, rgbkey, numseq, numkey = Color3.new, Color3.fromRGB, Color3.fromHex, Color3.fromHSV, ColorSequence.new, ColorSequenceKeypoint.new, NumberSequence.new, NumberSequenceKeypoint.new
    local angle, empty_cfr, cfr = CFrame.Angles, CFrame.new(), CFrame.new
-- 

-- Library init
    getgenv().Library = {
        Directory = "octo",
        Folders = {
            "/fonts",
            "/configs",
        },
        Flags = {},
        ConfigFlags = {},
        Connections = {},   
        Notifications = {Notifs = {}},
        OpenElement = {}; -- type: table or userdata
        AvailablePanels = {};

        EasingStyle = Enum.EasingStyle.Quint;
        TweeningSpeed = .3;
        DraggingSpeed = .05;
        Tweening = false;
    }

    local themes = {
        preset = {
            inline = rgb(46, 46, 46),
            outline = rgb(10, 10, 15),
            accent = rgb(19, 128, 225),
            background = rgb(20, 20, 25),              
            misc_1 = rgb(30, 30, 35),
            text_color = rgb(245, 245, 245),
            unselected = rgb(145, 145, 145),
            tooltip = rgb(73, 73, 73),
            misc_2 = rgb(23, 23, 28),
            font = "ProggyClean",
            textsize = 12
        },
        utility = {},
        gradients = {
            elements = {}
        },
    }

    for theme, color in themes.preset do 
        if theme == "font" or theme == "textsize" then 
            continue 
        end 

        themes.utility[theme] = {
            BackgroundColor3 = {}; 	
            TextColor3 = {};
            ImageColor3 = {};
            ScrollBarImageColor3 = {};
            Color = {};
        }
    end 

    local Keys = {
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
        
    Library.__index = Library

    for _,path in Library.Folders do 
        makefolder(Library.Directory .. path)
    end

    local Flags = Library.Flags 
    local ConfigFlags = Library.ConfigFlags
    local Notifications = Library.Notifications 

    local FontNames = {
        ["ProggyClean"] = "ProggyClean.ttf",
        ["Tahoma"] = "fs-tahoma-8px.ttf",
        ["Verdana"] = "Verdana-Font.ttf",
        ["SmallestPixel"] = "smallest_pixel-7.ttf",
        ["ProggyTiny"] = "ProggyTiny.ttf",
        ["Minecraftia"] = "Minecraftia-Regular.ttf",
        ["Tahoma Bold"] = "tahoma_bold.ttf",
        ["Rubik"] = "Rubik-Regular.ttf"
    }

    local FontIndexes = {"ProggyClean", "Tahoma", "Verdana", "SmallestPixel", "ProggyTiny", "Minecraftia", "Tahoma Bold", "Rubik"}

    local Fonts = {}; do
        local function RegisterFont(Name, Weight, Style, Asset)
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font)
            end

            if isfile(Name .. ".font") then
                delfile(Name .. ".font")
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", HttpService:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end

        for name, suffix in FontNames do 
            local Weight = 400 

            if name == "Rubik" then -- fuckin stupid 
                Weight = 900 
            end 

            local RegisteredFont = RegisterFont(name, Weight, "Normal", {
                Id = suffix,
                Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/" .. suffix),
            }) 
            
            Fonts[name] = Font.new(RegisteredFont, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
        end
    end
--

-- Library functions 
    -- Misc functions
        function Library:GetTransparency(obj)
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

        function Library:Tween(Object, Properties, Info)
            local tween = TweenService:Create(Object, Info or TweenInfo.new(Library.TweeningSpeed, Library.EasingStyle, Enum.EasingDirection.InOut, 0, false, 0), Properties)
            tween:Play()
            
            return tween
        end
        
        function Library:Fade(obj, prop, vis, speed)
            if not (obj and prop) then
                return
            end

            local OldTransparency = obj[prop]
            obj[prop] = vis and 1 or OldTransparency

            local Tween = Library:Tween(obj, { [prop] = vis and OldTransparency or 1 }, TweenInfo.new(speed or Library.TweeningSpeed, Library.EasingStyle, Enum.EasingDirection.InOut, 0, false, 0))
            
            Library:Connection(Tween.Completed, function()
                if not vis then
                    task.wait()
                    obj[prop] = OldTransparency
                end
            end)

            return Tween
        end

        function Library:Resizify(Parent)
            local Resizing = Library:Create("TextButton", {
                Position = dim2(1, -10, 1, -10);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 10, 0, 10);
                BorderSizePixel = 0;
                BackgroundColor3 = rgb(255, 255, 255);
                Parent = Parent;
                BackgroundTransparency = 1; 
                Text = ""
            })
            
            local IsResizing = false 
            local Size 
            local InputLost 
            local ParentSize = Parent.Size  
            
            Resizing.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    IsResizing = true
                    InputLost = input.Position
                    Size = Parent.Size
                end
            end)
            
            Resizing.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    IsResizing = false
                end
            end)
        
            Library:Connection(InputService.InputChanged, function(input, game_event) 
                if IsResizing and input.UserInputType == Enum.UserInputType.MouseMovement then            
                    Library:Tween(Parent, {
                        Size = dim2(
                            Size.X.Scale,
                            math.clamp(Size.X.Offset + (input.Position.X - InputLost.X), ParentSize.X.Offset, Camera.ViewportSize.X), 
                            Size.Y.Scale, 
                            math.clamp(Size.Y.Offset + (input.Position.Y - InputLost.Y), ParentSize.Y.Offset, Camera.ViewportSize.Y)
                        )
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end
            end)
        end
        
        function Library:Hovering(Object)
            if type(Object) == "table" then 
                local Pass = false;

                for _,obj in Object do 
                    if Library:Hovering(obj) then 
                        Pass = true
                        return Pass
                    end 
                end 
            else 
                local y_cond = Object.AbsolutePosition.Y <= Mouse.Y and Mouse.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
                local x_cond = Object.AbsolutePosition.X <= Mouse.X and Mouse.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
                
                return (y_cond and x_cond)
            end 
        end  

        function Library:ConvertHex(color)
            local r = math.floor(color.R * 255)
            local g = math.floor(color.G * 255)
            local b = math.floor(color.B * 255)
            return string.format("#%02X%02X%02X", r, g, b)
        end

        function Library:ConvertFromHex(color)
            color = color:gsub("#", "")
            local r = tonumber(color:sub(1, 2), 16) / 255
            local g = tonumber(color:sub(3, 4), 16) / 255
            local b = tonumber(color:sub(5, 6), 16) / 255
            return Color3.new(r, g, b)
        end

        function Library:Draggify(Parent)
            local Dragging = false 
            local IntialSize = Parent.Position
            local InitialPosition 

            Parent.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = true
                    InitialPosition = Input.Position
                    InitialSize = Parent.Position
                end
            end)

            Parent.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Dragging = false
                end
            end)

            Library:Connection(InputService.InputChanged, function(Input, game_event) 
                if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                    local Horizontal = Camera.ViewportSize.X
                    local Vertical = Camera.ViewportSize.Y

                    local NewPosition = dim2(
                        0,
                        math.clamp(
                            InitialSize.X.Offset + (Input.Position.X - InitialPosition.X),
                            0,
                            Horizontal - Parent.Size.X.Offset
                        ),
                        0,
                        math.clamp(
                            InitialSize.Y.Offset + (Input.Position.Y - InitialPosition.Y),
                            0,
                            Vertical - Parent.Size.Y.Offset
                        )
                    )

                    Library:Tween(Parent, {
                        Position = NewPosition
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end
            end)
        end 

        function Library:Convert(str)
            local Values = {}

            for Value in string.gmatch(str, "[^,]+") do
                table.insert(Values, tonumber(Value))
            end

            if #Values == 3 then              
                return unpack(Values)
            else
                return
            end
        end
        
        function Library:Lerp(start, finish, t)
            t = t or 1 / 8

            return start * (1 - t) + finish * t
        end

        function Library:ConvertEnum(enum)
            local EnumParts = {}

            for _,part in string.gmatch(tostring(enum), "[%w_]+") do
                table.insert(EnumParts, part)
            end
            
            local EnumTable = tostring(enum)  

            for i = 2, #EnumParts do
                local EnumItem = EnumTable[EnumParts[i]]
        
                EnumTable = EnumItem
            end
            
            return EnumTable
        end

        local ConfigHolder;
        function Library:UpdateConfigList() 
            if not ConfigHolder then 
                return 
            end
            
            local List = {}
            
            for _,file in listfiles(Library.Directory .. "/configs") do
                local Name = file:gsub(Library.Directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(Library.Directory .. "\\configs\\", "")
                List[#List + 1] = Name
            end

            ConfigHolder.RefreshOptions(List)
        end
        
        function Library:Keypicker(properties) 
            local Cfg = {
                Name = properties.Name or "Color", 
                Flag = properties.Flag or properties.Name or "Colorpicker",
                Callback = properties.Callback or function() end,

                Color = properties.Color or color(1, 1, 1), -- Default to white color if not provided
                Alpha = properties.Alpha or properties.Transparency or 0,
                
                Mode = properties.Mode or "Keypicker"; -- Animation

                -- Other
                Open = false, 
                Items = {Dropdown = nil};
                Tweening = false;
            }

            local DraggingSat = false 
            local DraggingHue = false 
            local DraggingAlpha = false 

            local h, s, v = Cfg.Color:ToHSV() 
            local a = Cfg.Alpha 

            Flags[Cfg.Flag] = {Color = Cfg.Color, Transparency = Cfg.Alpha}

            local Items = Cfg.Items; do 
                -- Component
                    Items.ColorpickerObject = Library:Create( "TextButton" , {
                        Name = "\0";
                        Parent = self.Items.Components;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 20, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.ColorpickerObject, "outline", "BackgroundColor3")

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.ColorpickerObject;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 50)
                    });

                    Items.Outline2 = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline2, "outline", "BackgroundColor3")

                    Items.MainColor = Library:Create( "Frame" , {
                        Parent = Items.Outline2;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });

                    Items.TransparencyHandler = Library:Create("ImageLabel", {
                        Parent = Items.MainColor;
                        Image = "rbxassetid://18274452449";
                        ZIndex = 3;
                        BackgroundTransparency = 1;
                        ImageTransparency = 1;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        ScaleType = Enum.ScaleType.Tile;
                        TileSize = dim2(0, 4, 0, 4);
                    })
                --
                    
                -- Colorpicker
                    Items.Colorpicker = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Name = "\0";
                        ZIndex = 999;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 179, 0, 234);
                        Visible = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Colorpicker, "outline", "BackgroundColor3"); Library:Resizify(Items.Colorpicker); 

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Colorpicker;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    }); Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    }); Library:Themify(Items.Background, "background", "BackgroundColor3")

                    Items.Text = Library:Create( "TextLabel" , {
                        Parent = Items.Background;
                        FontFace = Fonts[themes.preset.font];
                        Name = "\0";
                        TextColor3 = rgb(235, 235, 235);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Name;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Size = dim2(0, 0, 0, 16);
                        Position = dim2(0, 3, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Elements = Library:Create( "Frame" , {
                        Parent = Items.Background;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 3, 1, -42);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -6, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 49)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Elements;
                        Padding = dim(0, 2);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });

                    local Section = setmetatable(Cfg, Library)

                    Items.RGB = Section:Textbox({Callback = function(text)
                        if Cfg.Set then 
                            local r, g, b = Library:Convert(text)
                            Cfg.Set(rgb(r, g, b), a)
                        end
                    end, Flag = "ignore"})

                    Items.Hex = Section:Textbox({Callback = function(text)
                        if Cfg.Set then 
                            Cfg.Set(Library:ConvertFromHex(text), a)
                        end 
                    end, Flag = "ignore"})

                    Items.Elements = Library:Create( "Frame" , {
                        Parent = Items.Background;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 3, 1, -21);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -6, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 49)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Elements;
                        Padding = dim(0, 2);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });

                    local Section = setmetatable(Cfg, Library)
                    Items.Animations = Section:Dropdown({
                        Options = {"Rainbow", "Breathing"}, 
                        Default = {""}, 
                        Multi = true,
                        Flag = Cfg.Flag .. "_RAINBOW_FLAG"
                    })

                    task.spawn(function()
                        while true do 
                            task.wait()
                            local Flag = Flags[Cfg.Flag .. "_RAINBOW_FLAG"]

                            if not Flag then 
                                continue 
                            end 

                            if not Cfg.Set then 
                                continue 
                            end

                            if #Flag == 0 then 
                                continue 
                            end 

                            local Sine = math.abs(math.sin(tick()))
                            local Hue = table.find(Flag, "Rainbow") and Sine or h 
                            local Alpha = table.find(Flag, "Breathing") and Sine or a

                            Cfg.Set(hsv(Hue, s, v), Alpha) 
                        end     
                    end)

                    Items.SatValHolder = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(0, 3, 0, 16);
                        Selectable = false;
                        Size = dim2(1, -21, 1, -76);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 49)
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.SatValHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(14, 8, 12)
                    });

                    Items.SatValBackground = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -3, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(21, 255, 99)
                    });

                    Items.SatValPicker = Library:Create( "Frame" , {
                        Parent = Items.SatValBackground;
                        Name = "\0";
                        Size = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 3;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.SatValPicker;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Saturation = Library:Create( "Frame" , {
                        Parent = Items.SatValBackground;
                        Name = "\0";
                        Size = dim2(1, 1, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = Items.Saturation;
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });

                    Items.Value = Library:Create( "Frame" , {
                        Rotation = 180;
                        Name = "\0";
                        Parent = Items.SatValBackground;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIGradient" , {
                        Parent = Items.Value;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });

                    Items.Hue = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(0, 3, 1, -59);
                        Selectable = false;
                        Size = dim2(1, -6, 0, 14);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 49)
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Hue;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(14, 8, 12)
                    });

                    Items.HueBackground = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
                        Parent = Items.HueBackground
                    });

                    Items.HuePickerHolder = Library:Create( "Frame" , {
                        Parent = Items.HueBackground;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 2, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -4, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.HuePicker = Library:Create( "Frame" , {
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(12, 12, 12);
                        AnchorPoint = vec2(1, 0);
                        Parent = Items.HuePickerHolder;
                        BackgroundTransparency = 0.25;
                        Position = dim2(1, 1, 0, 1);
                        Name = "\0";
                        Size = dim2(0, 2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.HuePicker;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Alpha = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(1, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(1, -3, 0, 16);
                        Size = dim2(0, 14, 1, -76);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 49)
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Alpha;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(14, 8, 12)
                    });

                    Items.AlphaBackground = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.AlphaIndicator = Library:Create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.AlphaBackground;
                        Name = "\0";
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        TileSize = dim2(0, 8, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Fading = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.AlphaBackground;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(21, 255, 99)
                    });

                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Transparency = numseq{numkey(0, 1), numkey(1, 0)};
                        Parent = Items.Fading
                    });

                    Items.PickerHolder = Library:Create( "Frame" , {
                        Parent = Items.Fading;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, -4);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.AlphaPicker = Library:Create( "Frame" , {
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(12, 12, 12);
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.PickerHolder;
                        BackgroundTransparency = 0.25;
                        Position = dim2(0, 1, 1, 1);
                        Name = "\0";
                        Size = dim2(1, -2, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.AlphaPicker;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                --
            end
            
            function Cfg.SetVisible(bool)
                if Cfg.Tweening == true then
                    return 
                end 

                Items.Colorpicker.Position = dim2(0, Items.ColorpickerObject.AbsolutePosition.X + 2, 0, Items.ColorpickerObject.AbsolutePosition.Y + 74)
                
                Cfg.Tween(bool)
                Cfg.Set(hsv(h, s, v), a)
            end

            function Cfg.Tween(bool) 
                if Cfg.Tweening == true then 
                    return 
                end         

                Cfg.Tweening = true 

                if bool then 
                    Items.Colorpicker.Visible = true
                    Items.Colorpicker.Parent = Library.Items
                end

                local Children = Items.Colorpicker:GetDescendants()
                table.insert(Children, Items.Colorpicker)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                    end
                end

                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.Colorpicker.Visible = bool
                end)
            end

            function Cfg.UpdateColor() 
                local Mouse = InputService:GetMouseLocation()
                local offset = vec2(Mouse.X, Mouse.Y - gui_offset) 
                
                if DraggingSat then	
                    s = 1 - math.clamp((offset - Items.SatValHolder.AbsolutePosition).X / Items.SatValHolder.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - Items.SatValHolder.AbsolutePosition).Y / Items.SatValHolder.AbsoluteSize.Y, 0, 1)
                elseif DraggingHue then
                    h = math.clamp((offset - Items.Hue.AbsolutePosition).X / Items.Hue.AbsoluteSize.X, 0, 1)
                elseif DraggingAlpha then
                    a = math.clamp((offset - Items.Alpha.AbsolutePosition).Y / Items.Alpha.AbsoluteSize.Y, 0, 1)
                end

                Cfg.Set()
            end
            
            function Cfg.Set(color, alpha)
                if type(color) == "boolean" then 
                    return
                end 

                if color then 
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                Items.MainColor.BackgroundColor3 = hsv(h, s, v)
                Items.TransparencyHandler.ImageTransparency = a

                if Items.Colorpicker.Visible then 
                    Library:Tween(Items.SatValPicker, {
                        Position = dim2(1 - s, 0, 1 - v, 0)
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                    Library:Tween(Items.AlphaPicker, {
                        Position = dim2(0, 1, a, 1)
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                    Library:Tween(Items.HuePicker, {
                        Position = dim2(h, 1, 0, 1)
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                    Items.SatValBackground.BackgroundColor3 = hsv(h, 1, 1)
                    Items.Fading.BackgroundColor3 = hsv(h, 1, 1)

                    local Color = Items.MainColor.BackgroundColor3 -- Overwriting to format<<
                    
                    if not Items.RGB.Focused then 
                        Items.RGB.Items.Input.Text = string.format("%s, %s, %s", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255))
                    end 

                    if not Items.Hex.Focused then 
                        Items.Hex.Items.Input.Text = Library:ConvertHex(Color)
                    end 
                end 

                local Color = hsv(h, s, v)

                Flags[Cfg.Flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                Cfg.Callback(Color, a)
            end

            Items.ColorpickerObject.MouseButton1Click:Connect(function()
                Cfg.Open = not Cfg.Open
                Cfg.SetVisible(Cfg.Open)            
            end)

            InputService.InputChanged:Connect(function(input)
                if (DraggingSat or DraggingHue or DraggingAlpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    Cfg.UpdateColor() 
                end
            end)

            Library:Connection(InputService.InputBegan, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and not Library:Hovering({Items.Colorpicker, Items.Animations.Items.DropdownElements}) and Items.Colorpicker.Visible then
                    Cfg.SetVisible(false)
                end
            end) 

            Library:Connection(InputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    DraggingSat = false
                    DraggingHue = false
                    DraggingAlpha = false
                end
            end)    

            Items.Alpha.MouseButton1Down:Connect(function()
                DraggingAlpha = true 
            end)
            
            Items.Hue.MouseButton1Down:Connect(function()
                DraggingHue = true 
            end)
            
            Items.SatValHolder.MouseButton1Down:Connect(function()
                DraggingSat = true  
            end)
            
            Cfg.Set(Cfg.Color, Cfg.Alpha)
            Cfg.SetVisible(false)
            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 

        function Library:GetConfig()
            local Config = {}
            
            for Idx, Value in Flags do
                if type(Value) == "table" and Value.Key then
                    Config[Idx] = {Active = Value.Active, Mode = Value.Mode, Key = tostring(Value.Key)}
                elseif type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                    Config[Idx] = {Transparency = Value["Transparency"], Color = Value["Color"]:ToHex()}
                else
                    Config[Idx] = Value
                end
            end 

            return HttpService:JSONEncode(Config)
        end

        function Library:LoadConfig(JSON) 
            local Config = HttpService:JSONDecode(JSON)
            
            for Idx, Value in Config do  
                if Idx == "ignore" then 
                    continue 
                end 

                local Function = ConfigFlags[Idx]

                if Function then 
                    if type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                        Function(hex(Value["Color"]), Value["Transparency"])
                    else 
                        Function(Value)
                    end
                end 
            end 
        end 
        
        function Library:Round(num, float) 
            local Multiplier = 1 / (float or 1)
            return math.floor(num * Multiplier + 0.5) / Multiplier
        end

        function Library:Themify(instance, theme, property)
            table.insert(themes.utility[theme][property], instance)
        end

        function Library:SaveGradient(instance, theme)
            table.insert(themes.gradients[theme], instance)
        end

        function Library:RefreshTheme(theme, color)
            for property,instances in themes.utility[theme] do 
                for _,object in instances do
                    if object[property] == themes.preset[theme] then 
                        object[property] = color 
                    end
                end 
            end

            themes.preset[theme] = color 
        end 

        function Library:Connection(signal, callback)
            local connection = signal:Connect(callback)
            
            table.insert(Library.Connections, connection)

            return connection 
        end

        function Library:CloseElement() 
            local IsMulti = typeof(Library.OpenElement)

            if not Library.OpenElement then 
                return 
            end

            for i = 1, #Library.OpenElement do
                local Data = Library.OpenElement[i]

                if Data.Ignore then 
                    continue 
                end 

                Data.SetVisible(false)
                Data.Open = false
            end

            Library.OpenElement = {}
		end

        function Library:Create(instance, options)
            local ins = Instance.new(instance) 

            for prop, value in options do
                ins[prop] = value
            end

            if ins.ClassName == "TextButton" then 
                ins["AutoButtonColor"] = false 
                ins["Text"] = ""
                Library:Themify(ins, "text_color", "TextColor3")
            end 

            if ins.ClassName == "TextLabel" or ins.ClassName == "TextBox" then 
                Library:Themify(ins, "text_color", "TextColor3")
                Library:Themify(ins, "unselected", "TextColor3")
            end 

            return ins 
        end

        function Library:Unload() 
            if not Library then 
                return 
            end 

            if Library.Items then 
                Library.Items:Destroy()
            end

            if Library.Other then 
                Library.Other:Destroy()
            end

            if Library.Elements then 
                Library.Elements:Destroy()
            end 
            
            for _,connection in Library.Connections do 
                if not connection then 
                    continue 
                end 

                connection:Disconnect() 
                connection = nil 
            end

            if Library.Blur then 
                Library.Blur:Destroy()
            end 

            getgenv().Library = nil 
        end
    --
    
    -- List Library 
        function Library:StatusList(properties)
            local Cfg = {
                Name = properties.Name or "List"; 

                Items = {}
            } 

            local Items = Cfg.Items; do 
                -- Top
                    Items.List = Library:Create( "Frame", {
                        Parent = Library.Elements;
                        Size = dim2(0, 0, 0, 20);
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.List, "outline", "BackgroundColor3"); Library:Draggify(Items.List)
                    
                    Items.Inline = Library:Create( "Frame", {
                        Parent = Items.List;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.inline
                    }); Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame", {
                        Parent = Items.Inline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.misc_1
                    });	Library:Themify(Items.Background, "misc_1", "BackgroundColor3")

                    Items.StatusList = Library:Create( "TextLabel", {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Background;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(0.5, 0, 0, 5);
                        AnchorPoint = vec2(0.5, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        RichText = true;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.StatusList, "text_color", "TextColor3")

                    Library:Create( "UIStroke", {
                        Parent = Items.StatusList;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding", {
                        PaddingBottom = dim(0, 5);
                        Parent = Items.StatusList;
                        PaddingLeft = dim(0, 5);
                        PaddingRight = dim(0, 3)
                    });

                    Items.Accent = Library:Create( "Frame", {
                        AnchorPoint = vec2(1, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    }); Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                    Library:Create( "UIPadding", {
                        PaddingRight = dim(0, 2);
                        Parent = Items.Inline
                    });

                    Library:Create( "UIPadding", {
                        PaddingRight = dim(0, 2);
                        Parent = Items.List
                    });
                --

                -- Holder
                    Items.Holder = Library:Create( "Frame", {
                        Parent = Library.Elements;
                        Name = "\0";
                        ZIndex = 5;
                        Position = dim2(0, 300, 0, 100);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); 

                    Library:Create( "UIListLayout", {
                        Parent = Items.Holder;
                        Padding = dim(0, -1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                --  
            end 

            Items.List:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
                Items.Holder.Position = Items.List.Position + dim_offset(0, 23)
                Items.List.Size = dim2(0, math.max(0, Items.Holder.AbsoluteSize.X, 120), 0, 20)
            end)

            Items.Holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                Items.List.Size = dim2(0, math.max(0, Items.Holder.AbsoluteSize.X, 120), 0, 20)
                Items.Holder.Position = Items.List.Position + dim_offset(0, 23)
            end)

            task.delay(0.01, function()
                Items.List.Position = dim2(0, 50, 0, 700);
            end)
            
            return setmetatable(Cfg, Library)
        end 

        function Library:ListElement(properties)
            local Cfg = {
                Name = properties.Name or "Text"; 
                Items = {}
            } 

            local Items = Cfg.Items; do     
                Items.Outline = Library:Create( "Frame", {
                    Parent = self.Items.Holder;
                    Size = dim2(1, 0, 0, 20);
                    Name = "\0";
                    Position = dim2(0, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame", {
                    Parent = Items.Outline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.inline 
                }); Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame", {
                    Parent = Items.Inline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.misc_1
                });	Library:Themify(Items.Background, "misc_1", "BackgroundColor3")

                Items.Title = Library:Create( "TextLabel", {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.Background;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Position = dim2(0, 0, 0, 3);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    RichText = true;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Parent = Items.Title;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Library:Create( "UIPadding", {
                    PaddingBottom = dim(0, 5);
                    PaddingLeft = dim(0, 5);
                    Parent = Items.Title
                });

                Library:Create( "UIListLayout", {
                    Parent = Items.Background;
                    Padding = dim(0, 15);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                Library:Create( "UIPadding", {
                    PaddingTop = dim(0, 4);
                    PaddingBottom = dim(0, 2);
                    Parent = Items.Background;
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 2)
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.Inline
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.Outline
                });
            end 

            function Cfg.SetVisible(bool) 
                Items.Outline.Visible = bool 
            end 

            function Cfg.SetText(string)
                Items.Title.Text = string
            end 
        
            return setmetatable(Cfg, Library)
        end 
    -- 

    -- Image Holders 
        function Library:ImageHolder(properties) 
            local Cfg = {
                Name = properties.Name or "Viewer"; 
                Items = {} 
            }

            local Items = Cfg.Items; do 
                Items.Glow = Library:Create( "ImageLabel", {
                    ImageColor3 = themes.preset.accent;
                    ScaleType = Enum.ScaleType.Slice;
                    ImageTransparency = 0.65;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Library.Elements;
                    Name = "\0";
                    BorderSizePixel = 0;
                    Image = "rbxassetid://18245826428";
                    BackgroundTransparency = 1;
                    BackgroundColor3 = rgb(255, 255, 255);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    SliceCenter = rect(vec2(21, 21), vec2(79, 79))
                }); Library:Themify(Items.Glow, "accent", "ImageColor3"); Library:Draggify(Items.Glow)
                
                Items.OutlineMenu = Library:Create( "Frame", {
                    Parent = Items.Glow;
                    Name = "\0";
                    Size = dim2(0, 0, 0, 101);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.OutlineMenu, "outline", "BackgroundColor3")

                Items.AccentMenu = Library:Create( "Frame", {
                    Parent = Items.OutlineMenu;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.accent
                }); Library:Themify(Items.AccentMenu, "accent", "BackgroundColor3")

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.AccentMenu
                });

                Items.InlineMenu = Library:Create( "Frame", {
                    Parent = Items.AccentMenu;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.background
                });	Library:Themify(Items.InlineMenu, "background", "BackgroundColor3")

                Items.StatusList = Library:Create( "TextLabel", {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.InlineMenu;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Position = dim2(0, 0, 0, 3);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    RichText = true;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.StatusList, "text_color", "BackgroundColor3")

                Library:Create( "UIStroke", {
                    Parent = Items.StatusList;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Library:Create( "UIPadding", {
                    PaddingBottom = dim(0, 5);
                    Parent = Items.StatusList;
                    PaddingLeft = dim(0, 5);
                    PaddingRight = dim(0, 3)
                });

                Items.InnerSection = Library:Create( "Frame", {
                    Parent = Items.InlineMenu;
                    Size = dim2(1, -8, 1, -22);
                    Name = "\0";
                    Position = dim2(0, 4, 0, 18);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InnerSection, "outline", "BackgroundColor3")

                Items.InnerInline = Library:Create( "Frame", {
                    Parent = Items.InnerSection;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = rgb(46, 46, 46)
                });

                Items.InnerBackground = Library:Create( "Frame", {
                    Parent = Items.InnerInline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InnerBackground, "misc_1", "BackgroundColor3")

                Library:Create( "UIListLayout", {
                    Parent = Items.InnerBackground;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });

                Library:Create( "UIPadding", {
                    PaddingTop = dim(0, 4);
                    PaddingBottom = dim(0, 4);
                    Parent = Items.InnerBackground;
                    PaddingRight = dim(0, -4);
                    PaddingLeft = dim(0, 4)
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.InnerInline
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.InnerSection
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 8);
                    Parent = Items.InlineMenu
                });

                Library:Create( "UIPadding", {
                    PaddingRight = dim(0, 2);
                    Parent = Items.OutlineMenu
                });

                Library:Create( "UIPadding", {
                    PaddingTop = dim(0, 20);
                    PaddingBottom = dim(0, 20);
                    Parent = Items.Glow;
                    PaddingRight = dim(0, 20);
                    PaddingLeft = dim(0, 20)
                });
            end 

            function Cfg.SetVisible(bool)
                Items.Glow.Visible = bool
            end 
            
            return setmetatable(Cfg, Library)
        end 

        function Library:AddImage(properties)
            local Cfg = {
                Image = properties.Image or "rbxassetid://86659429043601"; 
                Items = {} 
            }

            local Items = Cfg.Items; do 
                Items.Outline = Library:Create( "Frame", {
                    Parent = self.Items.InnerBackground;
                    Name = "\0";
                    Position = dim2(0, 4, 0, 18);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 63, 0, 63);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame", {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                }); Library:Themify(Items.Inline, "inline", "BackgroundColor3") 
                
                Items.Background = Library:Create( "Frame", {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.misc_1
                });	Library:Themify(Items.Background, "misc_1", "BackgroundColor3")

                Items.Image = Library:Create( "ImageLabel", {
                    Parent = Items.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Image = Cfg.Image;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                });	
            end

            function Cfg.Remove()  
                Items.Outline:Destroy()
            end 

            return setmetatable(Cfg, Library)
        end 
    --  
        
    -- Library element functions
        function Library:Window(properties)
            local Cfg = {
                Name = properties.Name or "nebula";
                Size = properties.Size or dim2(0, 455, 0, 605);
                Items = {};
                Tweening = false;
                Tick = tick();
                Fps = 0;
            }

            Library.Items = Library:Create( "ScreenGui" , {
                Parent = CoreGui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
                DisplayOrder = 100;
            });
            
            Library.Other = Library:Create( "ScreenGui" , {
                Parent = CoreGui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            Library.Elements = Library:Create( "ScreenGui" , {
                Parent = gethui();
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
                DisplayOrder = 100;
            }); 

            Library.Blur = Library:Create( "BlurEffect" , {
                Parent = Lighting;
                Enabled = true;
                Size = 0
            });

            Library.KeybindList = Library:StatusList({Name = "Keybinds"})

            local Items = Cfg.Items; do
                -- Items 
                    Items.Holder = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.FirstInline = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Holder;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 6, 0, 26);
                        Size = dim2(1, -12, 1, -36);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    local Stroke = Library:Create( "UIStroke" , {
                        Color = rgb(40, 40, 45);
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.FirstInline
                    });	Library:Themify(Stroke, "inline", "Color")

                    Items.SecondInline = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.FirstInline;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        Size = dim2(1, -2, 1, -2);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    local Stroke = Library:Create( "UIStroke" , {
                        Color = themes.preset.outline;
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.SecondInline
                    });	Library:Themify(Stroke, "outline", "Color");

                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.SecondInline;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                    Items.ThirdInline = Library:Create( "Frame" , {
                        Parent = Items.SecondInline;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.ThirdInline, "inline", "BackgroundColor3")

                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.SecondInline;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    Items.InnerOutline = Library:Create( "Frame" , {
                        Parent = Items.Holder;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 6, 0, 26);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -12, 1, -36);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    local Stroke = Library:Create( "UIStroke" , {
                        Color = rgb(15, 15, 20);
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.InnerOutline;
                        Thickness = 10000
                    }); Library:Themify(Stroke, "outline", "Color");

                    Items.Title = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        TextColor3 = rgb(235, 235, 235);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Parent = Items.InnerOutline;
                        Name = "\0";
                        AnchorPoint = vec2(0, 1);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, -1, 0, -8);
                        BorderColor3 = rgb(0, 0, 0);
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Title;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.WindowButtonHolder = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(1, 1);
                        Parent = Items.InnerOutline;
                        BackgroundTransparency = 1;
                        Position = dim2(1, 1, 0, -6);
                        Name = "\0";
                        Size = dim2(0, 0, 0, 16);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = Items.WindowButtonHolder;
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                -- 

                -- Watermark
                    Items.Watermark = Library:Create( "Frame" , {
                        Parent = Library.Elements;
                        Name = "\0";
                        Visible = false;
                        Position = dim2(0.024000000208616257, 0, 0, 33);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Watermark, "outline", "BackgroundColor3")
                    Library:Draggify(Items.Watermark)

                    Items.AccentLineFade = Library:Create( "Frame" , {
                        Parent = Items.Watermark;
                        Size = dim2(1, -3, 0, 1);
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 3;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    }); Library:Themify(Items.AccentLineFade, "accent", "BackgroundColor3")
                    
                    Items.FadingGradient = Library:Create( "UIGradient" , {
                        Offset = vec2(0, 0);
                        Transparency = numseq{numkey(0, 0), numkey(0.5, 1), numkey(1, 0)};
                        Parent = Items.AccentLineFade
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Watermark;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = rgb(28, 28, 33)
                    });

                    Items.Text = Library:Create( "TextLabel" , {
                        RichText = true;
                        Parent = Items.Background;
                        TextColor3 = themes.preset.accent;
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = 'octohook.xyz <font color = "rgb(235, 235, 235)">@placeholder / UID @ / Developer / 00/00/0000 / 00:00:00 / 0fps / Oms</font>';
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BorderColor3 = rgb(0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        FontFace = Fonts[themes.preset.font];
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Text, "accent", "TextColor3")

                    Library:Create( "UIStroke" , {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 5);
                        PaddingBottom = dim(0, 6);
                        Parent = Items.Text;
                        PaddingRight = dim(0, 4);
                        PaddingLeft = dim(0, 6)
                    });

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 1);
                        PaddingRight = dim(0, 1);
                        Parent = Items.Inline
                    });

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 1);
                        PaddingRight = dim(0, 1);
                        Parent = Items.Watermark
                    });
                -- 
            end

            function Cfg.ChangeMenuTitle(string)
                Items.Title.Text = string
            end 

            -- recommended that you use richtext for automatic theming of the accent text.
            function Cfg.ChangeWatermarkTitle(string) 
                Items.Text.Text = string
            end 

            function Cfg.SetWatermarkVisible(bool)
                Items.Watermark.Visible = bool
            end

            function Cfg.SetVisible(bool)
                if Library.Tweening then
                    return 
                end     

                Library:Tween(Library.Blur, {Size = bool and (Flags["BlurSize"] or 15) or 0})

                Cfg.Tween(bool)
            end 

            function Cfg.Tween(bool) 
                if Library.Tweening then 
                    return 
                end 

                Library.Tweening = true 

                if bool then 
                    Library.Items.Enabled = true
                end

                local Children = Library.Items:GetDescendants()
                table.insert(Children, Items.Holder)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool)
                    end
                end

                Library:Connection(Tween.Completed, function()
                    Library.Tweening = false
                    Library.Items.Enabled = bool
                end)
            end 
            
            Cfg.SetVisible(true)

            Library:Connection(RunService.RenderStepped, function()
                if not Items.Watermark.Visible then 
                    return 
                end 

                local Tick = tick()
                Cfg.Fps += 1 

                Items.FadingGradient.Offset = vec2(math.sin(Tick), 0) 

                if Tick - Cfg.Tick >= 1 then 
                    Cfg.Tick = Tick

                    local Uid = 1
                    local Status = "Developer"
                    local Ping = math.floor(Stats.PerformanceStats.Ping:GetValue())
                    Cfg.ChangeWatermarkTitle(string.format('%s <font color = "%s">/ UID %s / %s / %s / %sfps / %sms</font>', Cfg.Name, Library:ConvertHex(themes.preset.text_color), Uid, Status, os.date("%x / %X"), Cfg.Fps, Ping))

                    Cfg.Fps = 0
                end 
            end)

            return setmetatable(Cfg, Library)
        end 

        function Library:Panel(properties) 
            local Cfg = {  
                Name = properties.Name or "nebula";
                ButtonName = properties.ButtonName or properties.Name or "Button";
                Size = properties.Size or dim2(0, 455, 0, 605);
                Position = properties.Position or dim2(0.5, 0, 0.5, 0);
                AnchorPoint = properties.AnchorPoint or vec2(0, 0);
                
                TabInfo;
                Open = true; 
                Items = {};
                Tweening = false;
            }

            local Items = Cfg.Items; do
                -- Button 
                    Items.Button = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = self.Items.WindowButtonHolder;
                        Name = "\0";
                        Selectable = false;
                        Size = dim2(0, 0, 0, 16);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Button, "inline", "BackgroundColor3")

                    Items.ButtonTitle = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Button;
                        TextColor3 = themes.preset.text_color;
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.ButtonName;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AnchorPoint = vec2(0, 0.5);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0.5, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); Library:Themify(Items.ButtonTitle, "unselected", "TextColor3")

                    Library:Create( "UIStroke" , {
                        Parent = Items.ButtonTitle;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.ButtonTitle;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 7)
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Button;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Inline, "outline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.misc_1
                    }); Library:Themify(Items.Background, "misc_1", "BackgroundColor3");

                    Library:Create( "UIPadding" , {
                        PaddingRight = dim(0, 2);
                        Parent = Items.Inline
                    });

                    Library:Create( "UIPadding" , {
                        PaddingRight = dim(0, 2);
                        Parent = Items.Button
                    });


                -- 

                -- Window 
                    Items.Window = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Name = "\0";
                        ClipsDescendants = false;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Position = Cfg.Position;
                        AnchorPoint = Cfg.AnchorPoint;
                        Size = Cfg.Size;
                        -- Rotation = 180;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Window, "outline", "BackgroundColor3")

                    Items.Fading = Library:Create( "Frame", {
                        Parent = Items.Panel;
                        BackgroundTransparency = 1; -- 0.6499999761581421
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    -- task.spawn(function()
                    --     while true do 
                    --         Items.Window.Rotation += 1
                    --         task.wait() 
                    --     end 
                    -- end)

                    Items.Glow = Library:Create( "ImageLabel", {
                        ImageColor3 = themes.preset.accent;
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Window;
                        ImageTransparency = 1; -- 0.6499999761581421
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        Size = dim2(1, 41, 1, 41);
                        BorderSizePixel = 0;
                        AnchorPoint = vec2(0.5, 0.5);
                        Image = "rbxassetid://18245826428";
                        BackgroundTransparency = 1;
                        Position = dim2(0.5, -1, 0.5, -1);
                        BackgroundColor3 = rgb(255, 255, 255);
                        AutomaticSize = Enum.AutomaticSize.XY;
                        SliceCenter = rect(vec2(21, 21), vec2(79, 79))
                    }); Library:Themify(Items.Glow, "accent", "ImageColor3")

                    Library:Create( "UIPadding", {
                        PaddingTop = dim(0, 20);
                        PaddingBottom = dim(0, 20);
                        Parent = Items.Glow;
                        PaddingRight = dim(0, 20);
                        PaddingLeft = dim(0, 20)
                    });

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.misc_1
                    }); Library:Themify(Items.Background, "misc_1", "BackgroundColor3");

                    Items.PageHolderBackground = Library:Create( "Frame" , {
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(0, 6, 0, 21);
                        Size = dim2(1, -12, 1, -26);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.PageHolderBackground, "inline", "BackgroundColor3")

                    Items.InlineSecond = Library:Create( "Frame" , {
                        Parent = Items.PageHolderBackground;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.InlineSecond, "outline", "BackgroundColor3")

                    Items.BackgroundSecond = Library:Create( "Frame" , {
                        Parent = Items.InlineSecond;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(15, 15, 20)
                    });

                    Items.Accent = Library:Create( "Frame" , {
                        Parent = Items.BackgroundSecond;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                    Items.TabButtonHolder = Library:Create( "Frame" , {
                        Parent = Items.BackgroundSecond;
                        Size = dim2(1, -26, 0, 39);
                        Name = "\0";
                        Position = dim2(0, 13, 0, 13);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.TabButtonHolder, "outline", "BackgroundColor3")

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.TabButtonHolder;
                        Padding = dim(0, -1);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });

                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 1);
                        PaddingBottom = dim(0, 1);
                        Parent = Items.TabButtonHolder;
                        PaddingRight = dim(0, 1);
                        PaddingLeft = dim(0, 1)
                    });

                    Items.PageHolder = Library:Create( "Frame" , {
                        Parent = Items.BackgroundSecond;
                        Size = dim2(1, -26, 1, -71);
                        Name = "\0";
                        Position = dim2(0, 13, 0, 58);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.PageHolder, "outline", "BackgroundColor3")

                    Items.InlineThird = Library:Create( "Frame" , {
                        Parent = Items.PageHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.InlineThird, "inline", "BackgroundColor3")

                    Items.PageHolder = Library:Create( "Frame" , {
                        Parent = Items.InlineThird;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(28, 28, 33)
                    });

                    Items.Title = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        TextColor3 = themes.preset.text_color;
                        Text = Cfg.Name;
                        Parent = Items.Background;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 5);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Title;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.Title;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 7)
                    });
                -- 
            end 

            do -- Other
                Library:Draggify(Items.Window)
                Library:Resizify(Items.Window)
            end

            function Cfg.ChangeName(string)
                Items.Title.Text = string
            end 

            function Cfg.SetMenuVisible(bool)
                if Cfg.Tweening or Library.Tweening then
                    return
                end 

                Library:Tween(Items.ButtonTitle, {TextColor3 = bool and themes.preset.text_color or themes.preset.unselected})
                Cfg.ToggleMenu(bool)
            end 

            Items.Button.MouseButton1Click:Connect(function()
                if self.Tweening then 
                    return 
                end 

                Cfg.Open = not Cfg.Open
                Cfg.SetMenuVisible(Cfg.Open)
            end)

            function Cfg.ToggleMenu(bool)
                if Cfg.Tweening or Library.Tweening then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.Window.Visible = true
                end

                local Children = Items.Window:GetDescendants()
                table.insert(Children, Items.Window)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool)
                    end
                end

                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.Window.Visible = bool
                end)
            end     

            Items.Window.MouseEnter:Connect(function()
                Library:Tween(Items.Glow, {ImageTransparency = 0.6499999761581421})
            end)

            Items.Window.MouseLeave:Connect(function()
                Library:Tween(Items.Glow, {ImageTransparency = 1})
            end)

            local Index = setmetatable(Cfg, Library)
            Library.AvailablePanels[#Library.AvailablePanels + 1] = Index

            return Index
        end 

        function Library:Tab(properties)
            local Cfg = {
                Name = properties.name or properties.Name or "tab"; 
                Items = {};
                AutoColumn = properties.Columns or true;
                Tweening = false;
            }
            
            local Items = Cfg.Items; do 
                -- Tab buttons 
                    Items.Outline = Library:Create( "TextButton" , {
                        Parent = self.Items.TabButtonHolder;
                        Size = dim2(0, 100, 0, 100);
                        Name = "\0";
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Background;
                        Color = rgbseq{rgbkey(0, rgb(27, 27, 32)), rgbkey(1, rgb(21, 21, 25))}
                    });

                    Items.Title = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Background;
                        TextColor3 = rgb(140, 140, 140);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Name;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AnchorPoint = vec2(0.5, 0.5);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0.5, 0, 0.5, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Title;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.Title;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 7)
                    });
                -- 

                -- Page Directory
                    Items.Page = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Library.Other; -- self.Items.PageHolder
                        Name = "\0";
                        Visible = false;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 6, 0, 6);
                        Size = dim2(1, -12, 1, -12);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Page;
                        Padding = dim(0, 6);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });
                --
            end 

            function Cfg.OpenTab() 
                local Tab = self.TabInfo

                if Tab == Cfg then 
                    return 
                end 

                if Tab then
                    Tab.Items.Title.TextColor3 = themes.preset.unselected
                    Tab.Tween(false)
                end

                Cfg.Tween(true)
                Items.Title.TextColor3 = themes.preset.text_color

                self.TabInfo = Cfg
            end

            function Cfg.Tween(bool) 
                if Cfg.Tweening == true then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.Page.Visible = true
                    Items.Page.Parent = self.Items.PageHolder
                end

                local Children = Items.Page:GetDescendants()
                table.insert(Children, Items.Page)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                    end
                end
                
                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.Page.Visible = bool
                    Items.Page.Parent = bool and self.Items.PageHolder or Library.Other
                end)
            end

            Items.Outline.MouseButton1Down:Connect(function()
                if Cfg.Tweening or self.TabInfo.Tweening then
                    return 
                end 

                Cfg.OpenTab()
            end)

            if not self.TabInfo then
                Cfg.OpenTab()
            end

            return setmetatable(Cfg, Library)
        end

        function Library:Column(properties)
            local Cfg = {
                Items = {}
            }

            local Items = Cfg.Items; do 
                Items.Column = Library:Create( "Frame" , {
                    Parent = self.Items.Page;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 100, 0, 100);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIListLayout" , {
                    Parent = Items.Column;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Padding = dim(0, 11);
                });
            end 

            return setmetatable(Cfg, Library) 
        end 

        function Library:Section(properties)
            local Cfg = {
                Name = properties.name or properties.Name or "Section"; 
                Side = properties.side or properties.Side or "Left";

                -- Fill settings 
                Size = properties.size or properties.Size or nil;
                
                -- Other
                Items = {};
            };
            
            local Items = Cfg.Items; do
                Items.Outline = Library:Create( "Frame" , {
                    Parent = self.Items.Column;
                    Name = "\0";
                    Size = dim2(0, 100, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")

                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 2);
                    Parent = Items.Outline
                });

                Items.TitleHolder = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Outline;
                    Size = dim2(0, 0, 0, 10);
                    Name = "\0";
                    Position = dim2(0, 10, 0, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.background
                });	Library:Themify(Items.TitleHolder, "background", "BackgroundColor3")

                Library:Create( "UIPadding" , {
                    Parent = Items.TitleHolder;
                    PaddingRight = dim(0, 2);
                    PaddingLeft = dim(0, 3)
                });

                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.TitleHolder;
                    TextColor3 = themes.preset.text_color;
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = Cfg.Name;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    AnchorPoint = vec2(0, 1);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 9);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Inline, "outline", "BackgroundColor3")

                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 2);
                    Parent = Items.Inline
                });

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.background
                });	Library:Themify(Items.Background, "background", "BackgroundColor3")

                Items.Accent = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Background;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                Items.Elements = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 12, 0, 15);
                    Size = dim2(1, -24, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 5);
                    Parent = Items.Elements
                });

                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
            end 

            return setmetatable(Cfg, Library)
        end  

        function Library:Toggle(properties) 
            local Cfg = {
                Name = properties.Name or "Toggle";
                Flag = properties.Flag or properties.Name or "Toggle";
                Enabled = properties.Default or false;
                Callback = properties.Callback or function() end;

                -- Sub / Group Section
                Folding = properties.Folding or false;
                Collapsable = properties.Collapsing or true;

                -- Tooltip = {Title = "Title", Text = "Text goes here\n Whatever", Width = 100}
                Tooltip = properties.Tooltip or nil;

                Items = {};
            }

            local Items = Cfg.Items; do
                Items.Toggle = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 12);
                    Selectable = false;
                    TextTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Toggle;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = Items.Components;
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });

                Items.Outline = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Toggle;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Fonts[themes.preset.font];
                    TextStrokeColor3 = rgb(255, 255, 255);
                    ZIndex = 2;
                    TextSize = 12;
                    Size = dim2(0, 0, 1, 0);
                    RichText = true;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Outline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Position = dim2(0, 17, 0, -1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if Cfg.Tooltip then 
                    Library:Tooltip({Title = Cfg.Tooltip.Title, Text = Cfg.Tooltip.Text, Width = Cfg.Tooltip.Width, Path = Items.Title})
                end 

                Library:Create( "UIStroke" , {
                    Parent = Items.Title;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    BackgroundColor3 = rgb(45, 45, 50)
                }); Library:Themify(Items.Inline, "accent", "BackgroundColor3")

                Items.Accent2 = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    ZIndex = 1;
                    BackgroundColor3 = themes.preset.accent;
                }); Library:Themify(Items.Accent2, "accent", "BackgroundColor3");

                Items.InlineInline = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.InlineInline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.misc_1
                }); Library:Themify(Items.Background, "misc_1", "BackgroundColor3");
                
                Items.Accent1 = Library:Create( "Frame" , {
                    Parent = Items.InlineInline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    ZIndex = 1;
                    BackgroundColor3 = themes.preset.accent;
                }); Library:Themify(Items.Accent1, "accent", "BackgroundColor3");
            end 
            
            function Cfg.Set(bool)
                Library:Tween(Items.Accent2, {BackgroundTransparency = bool and 0 or 1})
                Library:Tween(Items.Inline, {BackgroundTransparency = bool and 1 or 0})
                Library:Tween(Items.Accent1, {BackgroundTransparency = bool and 0 or 1})
                Library:Tween(Items.Title, {TextColor3 = bool and themes.preset.text_color or themes.preset.unselected })

                Cfg.Callback(bool)                
                Flags[Cfg.Flag] = bool
            end 
            
            Items.Toggle.MouseButton1Click:Connect(function()
                Cfg.Enabled = not Cfg.Enabled
                Cfg.Set(Cfg.Enabled)
            end)

            Cfg.Set(Cfg.Enabled)

            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 
        
        function Library:Slider(properties) 
            local Cfg = {
                Name = properties.Name or nil,
                Suffix = properties.Suffix or "",
                Flag = properties.Flag or properties.Name or "Slider",
                Callback = properties.Callback or function() end, 

                -- Value Settings
                Min = properties.Min or 0,
                Max = properties.Max or 100,
                Intervals = properties.Decimal or 1,
                Value = properties.Default or 10, 

                -- Other
                Dragging = false,
                Items = {}
            } 

            local Items = Cfg.Items; do
                Items.Slider = Library:Create( "Frame" , {
                    Parent = self.Items.Elements;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, Cfg.Name and 27 or 10);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if Cfg.Name then 
                    Items.Text = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Slider;
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Name;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(0, 1, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end

                Library:Create( "UIStroke" , {
                    Parent = Items.Text;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Items.Outline = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Slider;
                    Name = "\0";
                    Position = dim2(0, 4, 0, Cfg.Name and 17 or 0);
                    Selectable = false;
                    Size = dim2(1, -8, 0, 10);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(45, 45, 50)
                });

                Items.InlineInline = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.InlineInline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Accent = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Background;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                Items.Value = Library:Create( "TextBox" , {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.Accent;
                    TextColor3 = rgb(235, 235, 235);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = "5000st";
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    AnchorPoint = vec2(0.5, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(1, 0, 0.5, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIStroke" , {
                    Parent = Items.Value;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Accent;
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(42, 42, 42))}
                });

                local Gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                }); Library:SaveGradient(Gradient, "elements");

                Items.Minus = Library:Create( "TextButton" , {
                    FontFace = Fonts[themes.preset.font];
                    Active = false;
                    AnchorPoint = vec2(1, 0.5);
                    ZIndex = 100;
                    TextSize = 12;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "-";
                    Parent = Items.Outline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, -5, 0.5, 0);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextStrokeColor3 = rgb(255, 255, 255);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Items.Minus.Text = "-";

                Items.Plus = Library:Create( "TextButton" , {
                    FontFace = Fonts[themes.preset.font];
                    Active = false;
                    AnchorPoint = vec2(0, 0.5);
                    ZIndex = 100;
                    TextSize = 12;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Outline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(1, 5, 0.5, 0);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextStrokeColor3 = rgb(255, 255, 255);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Items.Plus.Text = "+";
            end 

            function Cfg.Set(value)
                Cfg.Value = math.clamp(Library:Round(value, Cfg.Intervals), Cfg.Min, Cfg.Max)

                Items.Value.Text = tostring(Cfg.Value) .. Cfg.Suffix

                Library:Tween(Items.Accent, 
                    {Size = dim2((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 1, 0)
                }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                Flags[Cfg.Flag] = Cfg.Value
                Cfg.Callback(Flags[Cfg.Flag])
            end
            
            Items.Outline.MouseButton1Down:Connect(function()
                Cfg.Dragging = true 
            end)

            Items.Minus.MouseButton1Click:Connect(function()
                Cfg.Value -= Cfg.Intervals
                Cfg.Set(Cfg.Value)
            end)

            Items.Plus.MouseButton1Click:Connect(function()
                Cfg.Value += Cfg.Intervals
                Cfg.Set(Cfg.Value)
            end)

            Items.Value.Focused:Connect(function()
                if Items.Text then 
                    Library:Tween(Items.Text, 
                        {TextColor3 = themes.preset.text_color,
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end 

                Library:Tween(Items.Value,
                    {TextColor3 = themes.preset.accent,
                }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
            end)

            Items.Value.FocusLost:Connect(function()
                if Items.Text then 
                    Library:Tween(Items.Text,
                        {TextColor3 = themes.preset.unselected,
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end 

                Library:Tween(Items.Value,
                    {TextColor3 = themes.preset.text_color,
                }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))

                pcall(function() -- me lazy ;(
                    Cfg.Set(Items.Value.Text)
                end)
            end)

            Library:Connection(InputService.InputChanged, function(input)
                if Cfg.Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then 
                    local Size = (input.Position.X - Items.Outline.AbsolutePosition.X) / Items.Outline.AbsoluteSize.X
                    local Value = ((Cfg.Max - Cfg.Min) * Size) + Cfg.Min
                    Cfg.Set(Value)
                end
            end)

            Library:Connection(InputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Cfg.Dragging = false
                end 
            end)
            
            Cfg.Set(Cfg.Value)
            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 

        function Library:Tooltip(properties)
            local Cfg = {
                Path = properties.Path;
                Text = properties.Text;
                Title = properties.Title;
                Width = properties.Width; 
                
                Items = {};
                Tweening = false;
            }   

            local Items = Cfg.Items; do 
                -- Text
                    Items.Tooltip = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        TextStrokeColor3 = rgb(255, 255, 255);
                        ZIndex = 2;
                        TextSize = 12;
                        Size = dim2(0, 0, 1, 0);
                        RichText = true;
                        TextColor3 = themes.preset.tooltip;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "(?)";
                        Parent = Cfg.Path;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(1, 3, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); Library:Themify(Items.Tooltip, "tooltip", "TextColor3")

                    Library:Create( "UIStroke" , {
                        Parent = Items.Tooltip;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 

                -- Holder
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Name = "\0";
                        Visible = false;
                        Position = dim2(0.024000000208616257, 0, 0, 140);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, Cfg.Width, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.background;
                    }); Library:Themify(Items.Background, "background", "BackgroundColor3")

                    Items.Text = Library:Create( "TextLabel" , {
                        RichText = true;
                        Parent = Items.Background;
                        TextColor3 = rgb(235, 235, 235);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Text;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 0, 0, 18);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        FontFace = Fonts[themes.preset.font];
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Title = Library:Create( "TextLabel" , {
                        RichText = true;
                        Parent = Items.Background;
                        TextColor3 = themes.preset.accent;
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Title;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BorderColor3 = rgb(0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        FontFace = Fonts[themes.preset.font];
                        ZIndex = 2;
                        TextSize = 12;
                    });	Library:Themify(Items.Title, "accent", "TextColor3")

                    Library:Create( "UIStroke" , {
                        Parent = Items.Title;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.Title;
                        PaddingTop = dim(0, 5);
                        PaddingRight = dim(0, 4);
                        PaddingLeft = dim(0, 6)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 5);
                        PaddingBottom = dim(0, 6);
                        Parent = Items.Text;
                        PaddingRight = dim(0, 4);
                        PaddingLeft = dim(0, 6)
                    });

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 1);
                        PaddingRight = dim(0, 1);
                        Parent = Items.Inline
                    });

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 1);
                        PaddingRight = dim(0, 1);
                        Parent = Items.Outline
                    });

                    Library:Create( "UIGradient" , {
                        Parent = Items.Outline
                    });
                -- 
            end 

            function Cfg.Tween(bool) 
                if Cfg.Tweening then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.Outline.Visible = true
                end

                local Children = Items.Outline:GetDescendants()
                table.insert(Children, Items.Outline)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool)
                    end
                end
                
                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.Outline.Visible = bool
                end)
            end 

            Items.Tooltip.MouseEnter:Connect(function()
                if Cfg.Tweening or Cfg.Path.TextTransparency == 1 then
                    return 
                end 

                Cfg.Tween(true) 
            end)
            
            Items.Tooltip.MouseLeave:Connect(function()
                if Cfg.Tweening or Cfg.Path.TextTransparency == 1 then
                    return 
                end     

                Cfg.Tween(false)
            end)

            Library:Connection(InputService.InputChanged, function(input)
                if Items.Tooltip.Visible and input.UserInputType == Enum.UserInputType.MouseMovement and Library:Hovering(Items.Tooltip) then 
                    Library:Tween(Items.Outline, {
                        Position = dim_offset(input.Position.X, input.Position.Y + 86)
                    }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                end

                if (not Library:Hovering(Items.Tooltip)) and Cfg.Tweening == false and Items.Outline.Visible then 
                    Cfg.Tween(false)   
                end 
            end)

            Cfg.Tween(false)

            return setmetatable(Cfg, Library)
        end 

        function Library:Dropdown(properties) 
            local Cfg = {
                Name = properties.Name or nil;
                Flag = properties.Flag or properties.Name or "Dropdown";
                Options = properties.Options or {""};
                Callback = properties.Callback or function() end;
                Multi = properties.Multi or false;
                Scrolling = properties.Scrolling or false;
                YSize = properties.Size or 100;
                Search = properties.Search or false; 

                -- Ignore these 
                Open = false;
                OptionInstances = {};
                MultiItems = {};
                Items = {};
                Tweening = false;
                Ignore = properties.Ignore or false;
            }   

            Cfg.Default = properties.Default or (Cfg.Multi and {Cfg.Items[1]}) or Cfg.Items[1] or "None"
            Flags[Cfg.Flag] = Cfg.Default
            local Parent; 

            local Items = Cfg.Items; do 
                -- Element
                    Items.Dropdown = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = self.Items.Elements;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, Cfg.Name and 35 or 17);
                        Selectable = false;
                        TextTransparency = 1;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Outline = Library:Create( "TextButton" , {
                        Parent = Items.Dropdown;
                        Name = "\0";
                        Position = dim2(0, 0, 0, Cfg.Name and 18 or 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 17);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 50)
                    });

                    Items.InlineInline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.InlineInline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Plus = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Background;
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = "+";
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AnchorPoint = vec2(1, 0);
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        BackgroundTransparency = 1;
                        Position = dim2(1, -2, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 444;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Plus;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Fading = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(1, 0);
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, 80, 0, 12);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    local Gradient = Library:Create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))};
                        Transparency = numseq{numkey(0, 1), numkey(0.82, 0), numkey(1, 0)};
                        Parent = Items.Fading
                    }); Library:SaveGradient(Gradient, "elements");

                    local Gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Background;
                        Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                    }); Library:SaveGradient(Gradient, "elements");

                    Items.Value = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = "...";
                        Parent = Items.Background;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 2, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    if Cfg.Name then 
                        Items.Text = Library:Create( "TextLabel" , {
                            FontFace = Fonts[themes.preset.font];
                            Parent = Items.Dropdown;
                            TextColor3 = rgb(145, 145, 145);
                            TextStrokeColor3 = rgb(255, 255, 255);
                            Text = Cfg.Name;
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIStroke" , {
                            Parent = Items.Text;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                    end 
                --  
                    
                -- Element Holder
                    Items.DropdownElements = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Visible = false;
                        Size = dim2(0, 213, 0, Cfg.Scrolling and Cfg.YSize or 18);
                        Name = "DropdownElements";
                        Position = dim2(0, 300, 0, 300);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.DropdownElements, "outline", "BackgroundColor3")
                    
                    if Cfg.Search then 
                        Library:Create( "UIPadding", {
                            PaddingBottom = dim(0, 1);
                            Parent = Items.DropdownElements
                        });

                        Items.TextboxOutline = Library:Create( "Frame", {
                            Name = "\0";
                            Parent = Items.DropdownElements;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, 0, 0, 18);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Items.TextboxOutline, "outline", "BackgroundColor3")

                        Items.Inline = Library:Create( "Frame", {
                            Parent = Items.TextboxOutline;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(45, 45, 50)
                        });

                        Items.InlineInline = Library:Create( "Frame", {
                            Parent = Items.Inline;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                        Items.Background = Library:Create( "Frame", {
                            Parent = Items.InlineInline;
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.Fading = Library:Create( "Frame", {
                            BorderColor3 = rgb(0, 0, 0);
                            AnchorPoint = vec2(1, 0);
                            Parent = Items.Background;
                            Name = "\0";
                            Position = dim2(1, 0, 0, 0);
                            Size = dim2(0, 80, 0, 12);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIGradient", {
                            Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))};
                            Transparency = numseq{numkey(0, 1), numkey(0.82, 0), numkey(1, 0)};
                            Parent = Items.Fading
                        }); Library:SaveGradient(Gradient, "elements"); 

                        Library:Create( "UIGradient", {
                            Rotation = 90;
                            Parent = Items.Background;
                            Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                        }); Library:SaveGradient(Gradient, "elements");

                        Items.Textbox = Library:Create( "TextBox", {
                            CursorPosition = -1;
                            Active = false;
                            Selectable = false;
                            ZIndex = 2;
                            TextSize = 12;
                            Size = dim2(1, 0, 1, 0);
                            TextColor3 = rgb(145, 145, 145);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "...";
                            Parent = Items.Background;
                            Name = "\0";
                            FontFace = Fonts[themes.preset.font];
                            BackgroundTransparency = 1;
                            Position = dim2(0, 2, 0, 0);
                            TextStrokeColor3 = rgb(255, 255, 255);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });	Library:Themify(Items.Textbox, "unselected", "BackgroundColor3")
                    end 

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.DropdownElements;
                        Name = "\0";
                        Position = dim2(0, 1, 0, Cfg.Search and 18 or 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, Cfg.Search and 0 or 1, Cfg.Search and Cfg.YSize or -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 50)
                    });

                    Items.InlineInline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.InlineInline;
                        Size = dim2(1, Cfg.Scrolling and -5 or -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    local Gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Background;
                        Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                    }); Library:SaveGradient(Gradient, "elements");
                    
                    if Cfg.Scrolling then 
                        Items.ScrollBar = Library:Create( "ScrollingFrame", {
                            ScrollBarImageColor3 = rgb(0, 0, 0);
                            Active = true;
                            ScrollBarThickness = 2;
                            AutomaticCanvasSize = Enum.AutomaticSize.Y;
                            BorderColor3 = rgb(0, 0, 0);
                            CanvasSize = dim2(0, 0, 0, 0);
                            Parent = Items.Background;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BottomImage = "rbxassetid://102257413888451";
                            TopImage = "rbxassetid://102257413888451";
                            MidImage = "rbxassetid://102257413888451";
                            Size = dim2(1, 3, 1, 0);
                            BorderSizePixel = 0;
                            ZIndex = 2;
                            BackgroundColor3 = rgb(255, 255, 255);
                            ScrollBarImageColor3 = themes.preset.accent
                        }); Library:Themify(Items.ScrollBar, "accent", "ScrollBarImageColor3")
                        
                    
                    end 

                    Parent = Cfg.Scrolling and Items.ScrollBar or Items.Background -- gay

                    Library:Create( "UIListLayout" , {
                        Parent = Parent;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 3);
                        Parent = Parent
                    });
                -- 
            end 

            function Cfg.RenderOption(text)       
                local Button = Library:Create( "TextButton" , {
                    FontFace = Fonts[themes.preset.font];
                    TextColor3 = themes.preset.unselected;
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = text;
                    Size = dim2(1, 0, 0, 0);
                    Parent = Cfg.Scrolling and Items.ScrollBar or Items.Background;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 2, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    TextXAlignment = Enum.TextXAlignment.Left;
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Library:Themify(Button, "unselected", "TextColor3"); Button.Text = text;

                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, 3);
                    PaddingBottom = dim(0, 3);
                    Parent = Button;
                    PaddingRight = dim(0, 3);
                    PaddingLeft = dim(0, 3)
                });

                table.insert(Cfg.OptionInstances, Button)

                return Button
            end
            
            function Cfg.SetVisible(bool)
                if Cfg.Tweening then
                    return 
                end 

                if Library.OpenElement ~= Cfg then 
                    Library:CloseElement(Cfg)
                end

                Items.DropdownElements.Position = dim2(0, Items.Outline.AbsolutePosition.X, 0, Items.Outline.AbsolutePosition.Y + 80)
				Items.DropdownElements.Size = dim_offset(Items.Outline.AbsoluteSize.X + 1, Cfg.Scrolling and Cfg.YSize or 0)

                if not Cfg.Multi then 
                    Items.Plus.Text = bool and "-" or "+"
                end

                Cfg.Tween(bool)
                
                Library.OpenElement = Cfg
            end
            
            function Cfg.Set(value)
                local Selected = {}
                local IsTable = type(value) == "table"

                for _,option in Cfg.OptionInstances do 
                    if option.Text == value or (IsTable and table.find(value, option.Text)) then 
                        table.insert(Selected, option.Text)
                        Cfg.MultiItems = Selected
                        option.TextColor3 = themes.preset.text_color
                    else
                        option.TextColor3 = themes.preset.unselected
                        option.BackgroundTransparency = 1
                    end
                end

                Items.Value.Text = if IsTable then table.concat(Selected, ", ") else Selected[1] or ""
                Flags[Cfg.Flag] = if IsTable then Selected else Selected[1]
                
                Cfg.Callback(Flags[Cfg.Flag]) 
            end
            
            function Cfg.RefreshOptions(options) 
                for _,option in Cfg.OptionInstances do 
                    option:Destroy() 
                end
                
                Cfg.OptionInstances = {} 

                for _,option in options do
                    local Button = Cfg.RenderOption(option)
                    
                    Button.MouseButton1Down:Connect(function()
                        if Cfg.Multi then 
                            local Selected = table.find(Cfg.MultiItems, Button.Text)
                            
                            if Selected then 
                                table.remove(Cfg.MultiItems, Selected)
                            else
                                table.insert(Cfg.MultiItems, Button.Text)
                            end
                            
                            Cfg.Set(Cfg.MultiItems) 				
                        else 
                            Cfg.SetVisible(false)
                            Cfg.Open = false
                            
                            Cfg.Set(Button.Text)
                        end
                    end)
                end

                Items.DropdownElements.Size = dim_offset(Items.Outline.AbsoluteSize.X + 1, Cfg.Scrolling and Cfg.YSize or #Cfg.OptionInstances * themes.preset.textsize)
            end

            function Cfg.Tween(bool) 
                if Cfg.Tweening == true then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.DropdownElements.Parent = Library.Items
                    Items.DropdownElements.Visible = true 
                end

                local Children = Items.DropdownElements:GetDescendants()
                table.insert(Children, Items.DropdownElements)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                    end
                end

                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.DropdownElements.Parent = bool and Library.Items or Library.Other
                    Items.DropdownElements.Visible = bool 
                end)
            end

            function Cfg.Filter(text)
                for _,label in Cfg.OptionInstances do 
                    if string.find(label.Text, text) then 
                        label.Visible = true 
                    else 
                        label.Visible = false
                    end
                end
            end

            Items.Outline.MouseButton1Click:Connect(function()
                Cfg.Open = not Cfg.Open 

                Cfg.SetVisible(Cfg.Open)
            end)

            Library:Connection(InputService.InputBegan, function(input, game_event)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Library:Hovering({Items.DropdownElements, Items.Dropdown}) then
                        Cfg.SetVisible(false)
                        Cfg.Open = false
                    end 
                end 
            end)

            if Cfg.Search then 
                Items.Textbox:GetPropertyChangedSignal("Text"):Connect(function()
                    Cfg.Filter(Items.Textbox.Text)
                end)
            end 

            Cfg.SetVisible(false)

            Flags[Cfg.Flag] = {} 
            ConfigFlags[Cfg.Flag] = Cfg.Set
            
            Cfg.RefreshOptions(Cfg.Options)
            Cfg.Set(Cfg.Default)
                
            return setmetatable(Cfg, Library)
        end

        function Library:Label(properties)
            local Cfg = {
                Name = properties.Name or "Label",

                -- Other
                Items = {};
            }

            local Items = Cfg.Items; do 
                Items.Label = Library:Create( "Frame" , {
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 12);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Label;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = Items.Components;
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });

                Items.Name = Library:Create( "TextLabel" , {
                    Parent = Items.Label;
                    RichText = true;
                    Name = "\0";
                    TextColor3 = rgb(145, 145, 145);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = Cfg.Name;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    BorderColor3 = rgb(0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    FontFace = Fonts[themes.preset.font];
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
            end 

            function Cfg.Set(Text)
                Items.Name.Text = Text
            end 

            Cfg.Set(Cfg.Name)

            return setmetatable(Cfg, Library)
        end

        function Library:Textbox(properties) 
            local Cfg = {
                Name = properties.Name or nil;
                PlaceHolder = properties.PlaceHolder or properties.PlaceHolderText or properties.Holder or properties.HolderText or "Type here...";
                ClearTextOnFocus = properties.ClearTextOnFocus or false;
                Default = properties.Default or ""; 
                Flag = properties.Flag or properties.Name or "TextBox";
                Callback = properties.Callback or function() end;
                
                Items = {};
                Focused = false;
            }

            Flags[Cfg.Flag] = Cfg.default

            local Items = Cfg.Items; do 
                Items.Textbox = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 35);
                    Selectable = false;
                    TextTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if Cfg.Name then 
                    Items.Text = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Textbox;
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Name;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Position = dim2(0, 1, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                end 

                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Textbox;
                    Name = "\0";
                    Position = dim2(0, 0, 0, Cfg.Name and 17 or 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 18);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(45, 45, 50)
                });

                Items.InlineInline = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.InlineInline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    ClipsDescendants = true;
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(0, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Fading = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    Parent = Items.Background;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(0, 80, 0, 12);
                    ZIndex = 3;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Gradient = Library:Create( "UIGradient" , {
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))};
                    Transparency = numseq{numkey(0, 1), numkey(0.82, 0), numkey(1, 0)};
                    Parent = Items.Fading
                }); Library:SaveGradient(Gradient, "elements");

                local Gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                }); Library:SaveGradient(Gradient, "elements");

                Items.Input = Library:Create( "TextBox" , {
                    Parent = Items.Background;
                    FontFace = Fonts[themes.preset.font];
                    Name = "\0";
                    TextColor3 = rgb(145, 145, 145);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = "";
                    Size = dim2(1, 0, 1, 0);
                    Selectable = false;
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 2, 0, 0);
                    ClearTextOnFocus = Cfg.ClearTextOnFocus;
                    Active = false;
                    ZIndex = 44;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
            end 
            
            function Cfg.Set(text) 
                Flags[Cfg.Flag] = text

                Items.Input.Text = text

                Cfg.Callback(text)
            end 
            
            Items.Input:GetPropertyChangedSignal("Text"):Connect(function()
                if Cfg.Focused then 
                    Cfg.Set(Items.Input.Text)
                end 
            end) 

            Items.Input.Focused:Connect(function()
                Cfg.Focused = true;
            end)

            Items.Input.FocusLost:Connect(function()
                Cfg.Focused = false;
            end)

            if Cfg.Default then 
                Cfg.Set(Cfg.Default) 
            end

            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end

        function Library:Keybind(properties) 
            local Cfg = {
                Flag = properties.Flag or properties.Name;
                Callback = properties.Callback or function() end;
                Name = properties.Name or "Keybind"; 

                Key = properties.Key or nil;
                Mode = properties.Mode or "Toggle";
                Active = properties.Default or false; 
                
                Show = properties.ShowInList or true;

                Open = false;
                Binding;
                Ignore = false;

                Items = {};
                Tweening = false;
            }
            
            Flags[Cfg.Flag] = {
                Mode = Cfg.Mode,
                Key = Cfg.Key, 
                Active = Cfg.Active
            }

            local KeybindElement = Library.KeybindList:ListElement({})

            local Items = Cfg.Items; do 
                -- Component
                    Items.Keybind = Library:Create( "TextButton" , {
                        Parent = self.Items.Components;
                        FontFace = Fonts[themes.preset.font];
                        Name = "\0";
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = "[NONE]";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Size = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 17, 0, 0);
                        RichText = true;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Keybind;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
                
                -- Mode holder
                    Items.Information = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Size = dim2(0, 213, 0, 71);
                        Name = "\0";
                        Visible = false;
                        Position = dim2(0, 100, 0, 100);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 1;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Information, "outline", "BackgroundColor3")

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Information;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(45, 45, 50)
                    });

                    Items.InlineInline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.InlineInline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    local Gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Background;
                        Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                    }); Library:SaveGradient(Gradient, "elements");

                    Items.Elements = Library:Create( "Frame" , {
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(0, 12, 0, 5);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -24, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.Elements;
                        PaddingTop = dim(0, 15)
                    });

                    Library:Create( "UIListLayout" , {
                        Parent = Items.Elements;
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    local Section = setmetatable(Cfg, Library)
                    Items.Dropdown = Section:Dropdown({Name = "Mode", Options = {"Toggle", "Hold", "Always"}, Callback = function(option)
                        if Cfg.Set then 
                            Cfg.Set(option)
                        end
                    end, Default = Cfg.Mode, Flag = Cfg.Flag .. "_MODE"})
                    Section:Toggle({Name = "Show on list", Flag = Cfg.Flag .. "_LIST", Callback = function()
                        KeybindElement.SetVisible(Flags[Cfg.Flag .. "_LIST"] and Cfg.Active or false)
                    end})
                --
            end 

            function Cfg.SetMode(mode) 
                Cfg.Mode = mode 

                if mode == "Always" then
                    Cfg.Set(true)
                elseif mode == "Hold" then
                    Cfg.Set(false)
                end

                Flags[Cfg.Flag].Mode = mode
            end

            function Cfg.Set(input)
                if type(input) == "boolean" then 
                    Cfg.Active = input

                    if Cfg.Mode == "Always" then 
                        Cfg.Active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    Cfg.Key = input or "NONE"	
                elseif table.find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        Cfg.Active = true 
                    end 

                    Cfg.Mode = input
                    Cfg.SetMode(Cfg.Mode) 
                elseif type(input) == "table" then
                    input.Key = type(input.Key) == "string" and input.Key ~= "NONE" and Library:ConvertEnum(input.Key) or input.Key
                    input.Key = input.Key == Enum.KeyCode.Escape and "NONE" or input.Key

                    Cfg.Key = input.Key or "NONE"
                    Cfg.Mode = input.Mode or "Toggle"

                    if input.Active then
                        Cfg.Active = input.Active
                    end

                    Cfg.SetMode(Cfg.Mode) 
                end 

                Cfg.Callback(Cfg.Active)

                local text = (tostring(Cfg.Key) ~= "Enums" and (Keys[Cfg.Key] or tostring(Cfg.Key):gsub("Enum.", "")) or nil)
                local __text = text and tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "") or ""

                Items.Keybind.Text = string.format("[%s]", __text)

                Flags[Cfg.Flag] = {
                    Mode = Cfg.Mode,
                    Key = Cfg.Key, 
                    Active = Cfg.Active
                }
                
                KeybindElement.SetText(string.format("%s [%s] - %s", Cfg.Name, __text, Cfg.Mode))
                KeybindElement.SetVisible(Flags[Cfg.Flag .. "_LIST"] and Cfg.Active or false)
            end

            function Cfg.SetVisible(bool)
                if Cfg.Tweening then  
                    return 
                end 

                Items.Information.Position = dim2(0, Items.Keybind.AbsolutePosition.X + 2, 0, Items.Keybind.AbsolutePosition.Y + 74)
               
                Cfg.Tween(bool)
            end

            function Cfg.Tween(bool) 
                if Cfg.Tweening == true then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.Information.Visible = true
                    Items.Information.Parent = Library.Items
                end

                local Children = Items.Information:GetDescendants()
                table.insert(Children, Items.Information)

                local Tween;
                for _,obj in Children do
                    local Index = Library:GetTransparency(obj)

                    if not Index then 
                        continue 
                    end

                    if type(Index) == "table" then
                        for _,prop in Index do
                            Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                    end
                end

                Library:Connection(Tween.Completed, function()
                    Cfg.Tweening = false
                    Items.Information.Visible = bool
                end)
            end
                         
            Items.Keybind.MouseButton1Down:Connect(function()
                task.wait()
                Items.Keybind.Text = "..."	

                Cfg.Binding = Library:Connection(InputService.InputBegan, function(keycode, game_event)  
                    Cfg.Set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    Cfg.Binding:Disconnect() 
                    Cfg.Binding = nil
                end)
            end)

            Items.Keybind.MouseButton2Down:Connect(function()
                Cfg.Open = not Cfg.Open 

                Cfg.SetVisible(Cfg.Open)
            end)

            Library:Connection(InputService.InputBegan, function(input, game_event) 
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not (Library:Hovering(Items.Dropdown.Items.DropdownElements) or Library:Hovering(Items.Information)) and Items.Information.Visible then
                        Cfg.SetVisible(false)
                        Cfg.Open = false;
                    end 
                end 
                
                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == Cfg.Key or tostring(selected_key) == Cfg.Key then 
                        if Cfg.Mode == "Toggle" then 
                            Cfg.Active = not Cfg.Active
                            Cfg.Set(Cfg.Active)
                        elseif Cfg.Mode == "Hold" then 
                            Cfg.Set(true)
                        end
                    end
                end
            end)    

            Library:Connection(InputService.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == Cfg.Key then
                    if Cfg.Mode == "Hold" then 
                        Cfg.Set(false)
                    end
                end
            end)
            
            Cfg.Set({Mode = Cfg.Mode, Active = Cfg.Active, Key = Cfg.Key})           
            ConfigFlags[Cfg.Flag] = Cfg.Set
            Items.Dropdown.Set(Cfg.Mode)

            return setmetatable(Cfg, Library)
        end
        
        function Library:Button(properties) 
            local Cfg = {
                Name = properties.Name or "TextBox",
                Callback = properties.Callback or function() end,
                 
                -- Other
                Items = {};
            }

            local Items = Cfg.Items; do
                Items.Button = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 18);
                    Selectable = false;
                    TextTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Outline = Library:Create( "TextButton" , {
                    Parent = Items.Button;
                    Size = dim2(1, 0, 0, 18);
                    Name = "\0";
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Selectable = false;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(45, 45, 50)
                });

                Items.InlineInline = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.InlineInline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    ClipsDescendants = true;
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(0, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                }); Library:SaveGradient(Gradient, "elements");

                Items.Text = Library:Create( "TextLabel" , {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.Background;
                    TextColor3 = rgb(145, 145, 145);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = Cfg.Name;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 2, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIStroke" , {
                    Parent = Items.Text
                });
            end 

            Items.Outline.MouseButton1Click:Connect(function()
                Cfg.Callback()
            end)
            
            return setmetatable(Cfg, Library)
        end
        
        function Library:Colorpicker(properties) 
            local Cfg = {
                Name = properties.Name or self.Name or "Color", 
                Flag = properties.Flag or properties.Name or self.Name or "Colorpicker",
                Callback = properties.Callback or function() end,

                Color = properties.Color or color(1, 1, 1), -- Default to white color if not provided
                Alpha = properties.Alpha or properties.Transparency or 1,
                
                -- Other
                Open = false;
                Mode = properties.Mode or "Animation";
                Items = {};
            }

            local Picker = self:Keypicker(Cfg)

            local Items = Picker.Items; do
                Cfg.Items = Items
                Cfg.Set = Picker.Set
            end;
            
            Cfg.Set(Cfg.Color, Cfg.Alpha)
            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 

        function Library:List(properties)
            local Cfg = {
                Flag = properties.Flag or properties.Name or "Dropdown";
                Options = properties.Options or {""};
                Callback = properties.Callback or function() end;
                Multi = properties.Multi or false;

                AutoSizing = properties.AutoSize or false; 
                Size = properties.Size or 18;
                VisualMode = properties.VisualMode or false;

                Items = {};
                OptionInstances = {};
                MultiItems = {};
            } 

            local Items = Cfg.Items; do 
                Items.List = Library:Create( "TextButton", {
                    Active = false;
                    TextTransparency = 1;
                    Parent = self.Items.Elements;
                    AutoButtonColor = false;
                    Name = "\0";
                    Size = dim2(1, 0, 0, Cfg.Size);
                    BackgroundTransparency = 1;
                    Selectable = false;
                    BorderSizePixel = 0;
                    BorderColor3 = rgb(0, 0, 0);
                    AutomaticSize = Enum.AutomaticSize[Cfg.AutoSize and "Y" or "None"];
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Outline = Library:Create( "TextButton", {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    AutoButtonColor = false;
                    Name = "\0";
                    Parent = Items.List;
                    Selectable = false;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame", {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(45, 45, 50)
                });

                Items.InlineInline = Library:Create( "Frame", {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.TextHolder = Library:Create( "Frame", {
                    Parent = Items.InlineInline;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    ClipsDescendants = true;
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(0, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Gradient = Library:Create( "UIGradient", {
                    Rotation = 90;
                    Parent = Items.TextHolder;
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                }); Library:SaveGradient(Gradient, "elements");

                if not Cfg.AutoSizing then 
                    local Old = Items.TextHolder
                    Items.TextHolder = Library:Create( "ScrollingFrame", {
                        ScrollBarImageColor3 = rgb(0, 0, 0);
                        Active = true;
                        BottomImage = "rbxassetid://102257413888451";
                        TopImage = "rbxassetid://102257413888451";
                        MidImage = "rbxassetid://102257413888451";
                        ZIndex = 2;
                        AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        ScrollBarThickness = 2;
                        Parent = Old;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BackgroundColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        CanvasSize = dim2(0, 0, 0, 0);
                        ScrollBarImageColor3 = themes.preset.accent
                    }); Library:Themify(Items.TextHolder, "accent", "ScrollBarImageColor3")
                end  

                Library:Create( "UIListLayout", {
                    Parent = Items.TextHolder;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                });
                
                Library:Create( "UIPadding", {
                    PaddingBottom = dim(0, 4);
                    Parent = Items.TextHolder
                });
            end 

            do -- Functions 
                function Cfg.Set(value) 
                    if Cfg.VisualMode then 
                        return 
                    end 

                    local Selected = {}
                    local IsTable = type(value) == "table"

                    for _,option in Cfg.OptionInstances do 
                        if option.Text == value or (IsTable and table.find(value, option.Text)) then 
                            table.insert(Selected, option.Text)
                            Cfg.MultiItems = Selected
                            option.TextColor3 = themes.preset.text_color
                        else
                            option.TextColor3 = themes.preset.unselected
                        end
                    end

                    Flags[Cfg.Flag] = if IsTable then Selected else Selected[1]
                    
                    Cfg.Callback(Flags[Cfg.Flag]) 
                end 

                function Cfg.RenderOption(name)
                    local Button = Library:Create( "TextButton", {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.TextHolder;
                        TextColor3 = rgb(145, 145, 145);
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = name;
                        RichText = true;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        Size = dim2(0, 0, 0, 0);
                        TextXAlignment = Enum.TextXAlignment[Cfg.VisualMode and "Left" or "Center"];
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 2, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 100;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Button, "unselected", "BackgroundColor3")

                    Button.Text = name

                    Library:Create( "UIStroke", {
                        Parent = Button
                    });

                    Library:Create( "UIPadding", {
                        PaddingTop = dim(0, 3);
                        PaddingBottom = dim(0, 3);
                        Parent = Button;
                        PaddingRight = dim(0, 3);
                        PaddingLeft = dim(0, 3)
                    });
                    
                    table.insert(Cfg.OptionInstances, Button)

                    return Button
                end 

                function Cfg.RefreshOptions(options) 
                    for _,option in Cfg.OptionInstances do 
                        option:Destroy() 
                    end
                    
                    Cfg.OptionInstances = {} 

                    for _,option in options do
                        local Button = Cfg.RenderOption(option)
                        
                        Button.MouseButton1Down:Connect(function()
                            if Cfg.Multi then 
                                local Selected = table.find(Cfg.MultiItems, Button.Text)
                                
                                if Selected then 
                                    table.remove(Cfg.MultiItems, Selected)
                                else
                                    table.insert(Cfg.MultiItems, Button.Text)
                                end
                                
                                Cfg.Set(Cfg.MultiItems) 				
                            else                                 
                                Cfg.Set(Button.Text)
                            end
                        end)
                    end
                end

                function Cfg.Filter(text)
                    for _,label in Cfg.OptionInstances do 
                        if string.find(label.Text, text) then 
                            label.Visible = true 
                        else 
                            label.Visible = false
                        end
                    end
                end

                -- Init
                Flags[Cfg.Flag] = {} 
                ConfigFlags[Cfg.Flag] = Cfg.Set
                Cfg.RefreshOptions(Cfg.Options)
                Cfg.Set(Cfg.Default)
            end 

            return setmetatable(Cfg, Library)
        end 

        function Library:Configs(Window, Tab)
            -- Settings
                local ConfigText;
                local Column = Tab:Column({})
                local Section = Column:Section({Name = "Main"})
                ConfigHolder = Section:List({
                    Name = "Configs", 
                    Flag = "config_Name_list", 
                    Size = 100;
                    Callback = function(option) 
                        if Text and option then 
                            Text.Set(option) 
                        end 
                    end, 
                }); 
                Library:UpdateConfigList();

                Text = Section:Textbox({Name = "Config Name:", Flag = "config_Name_text", Callback = function(text)
                    ConfigText = text
                end})

                Section:Button({Name = "Save", Callback = function() 
                    writefile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg", Library:GetConfig())
                    Library:Notification({Name = "Saved config.", Lifetime = 5})
                    Library:UpdateConfigList()
                end})

                Section:Button({Name = "Load", Callback = function() 
                    Window.Tweening = true 
                    Library:LoadConfig(readfile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg"))  
                    Library:Notification({Name = "Loaded config.", Lifetime = 5})
                    Library:UpdateConfigList() 
                    Window.Tweening = false 
                end})

                Section:Button({Name = "Delete", Callback = function() 
                    delfile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg")  
                    Library:Notification({Name = "Deleted config.", Lifetime = 5})
                    Library:UpdateConfigList() 
                end})

                local Section = Column:Section({Name = "Server"})
                Section:Button({Name = "Copy JobId", Callback = function()
                    setclipboard(game.JobId)
                end})
                Section:Button({Name = "Copy GameID", Callback = function()
                    setclipboard(game.GameId)
                end})
                Section:Button({Name = "Copy Join Script", Callback = function()
                    setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ', "' .. game.JobId .. '", game.Players.LocalPlayer)')
                end})
                Section:Button({Name = "Rejoin", Callback = function()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
                end})
                Section:Button({Name = "Join New Server", Callback = function()
                    local apiRequest = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                    local data = apiRequest.data[math.random(1, #apiRequest.data)]

                    if data.playing <= Flags["MaxPlayers"] then 
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, data.id)
                    end 
                end})
                Section:Slider({Name = "Max Players", Min = 0, Max = 40, Default = 10, Decimal = 1, Flag = "MaxPlayers"})

            -- 

            -- Theming 
                local Column = Tab:Column({})
                local Section = Column:Section({Name = "Other"})
                Section:Label({Name = "Inline"}):Colorpicker({Color = themes.preset.inline, Callback = function(color, alpha)
                    Library:RefreshTheme("inline", color)
                end})
                Section:Label({Name = "Outline"}):Colorpicker({Color = themes.preset.outline, Callback = function(color, alpha)
                    Library:RefreshTheme("outline", color)
                end})
                Section:Label({Name = "Accent"}):Colorpicker({Color = themes.preset.accent, Callback = function(color, alpha)
                    Library:RefreshTheme("accent", color)
                end})
                local Label = Section:Label({Name = "Background"})
                Label:Colorpicker({Color = themes.preset.background, Callback = function(color, alpha)
                    Library:RefreshTheme("background", color)
                end})
                Label:Colorpicker({Color = themes.preset.misc_1, Callback = function(color, alpha)
                    Library:RefreshTheme("misc_1", color)
                end})
                Section:Label({Name = "Text Color"}):Colorpicker({Color = themes.preset.text_color, Callback = function(color, alpha)
                    Library:RefreshTheme("text_color", color)
                end})
                Section:Label({Name = "Tooltip"}):Colorpicker({Color = themes.preset.tooltip, Callback = function(color, alpha)
                    Library:RefreshTheme("tooltip", color)
                end})
                Section:Label({Name = "Unselected"}):Colorpicker({Color = themes.preset.unselected, Callback = function(color, alpha)
                    Library:RefreshTheme("unselected", color)
                end})
                local Label = Section:Label({Name = "Element Gradients"})
                Label:Colorpicker({Color = themes.preset.misc_1, Callback = function(color, alpha)
                    Library:RefreshTheme("misc_1", color)

                    for _,seq in themes.gradients.elements do
                        seq.Color = rgbseq{rgbkey(0, themes.preset.misc_1), rgbkey(1, themes.preset.misc_2)}
                    end
                end, Flag = "Element Gradient 1"})
                Label:Colorpicker({Color = themes.preset.misc_2, Callback = function(color, alpha)
                    themes.preset.misc_2 = color 

                    for _,seq in themes.gradients.elements do
                        seq.Color = rgbseq{rgbkey(0, themes.preset.misc_1), rgbkey(1, themes.preset.misc_2)}
                    end
                end, Flag = "Element Gradient 2"})
                Section:Slider({Name = "Tween Speed", Min = 0, Max = 3, Decimal = Library.DraggingSpeed, Default = .3, Callback = function(num)
                    Library.TweeningSpeed = num
                end})
                Section:Dropdown({Name = "Tweening Style", Options = {"Linear", "Sine", "Back", "Quad", "Quart", "Quint", "Bounce", "Elastic", "Exponential", "Circular", "Cubic"}, Flag = "LibraryEasingStyle", Default = "Quint", Callback = function(Option)
                    Library.EasingStyle = Enum.EasingStyle[Option]
                end});
                Section:Slider({Name = "Dragging Speed", Min = 0, Max = 1, Decimal = .01, Default = .05, Callback = function(num)
                    Library.DraggingSpeed = num
                end})
                Section:Label({Name = "Menu Bind"}):Keybind({Name = "Menu Bind", Key = Enum.KeyCode.E, Callback = function(bool) 
                    print(bool)
                    Window.SetVisible(bool) 
                end})
                Window.Tweening = false
                Section:Toggle({Name = "Toggle Watermark", Callback = function(bool)
                    Window.SetWatermarkVisible(bool)
                end})
                Section:Toggle({Name = "Toggle Keybind List", Callback = function(bool)
                    Library.KeybindList.Items.Holder.Visible = bool 
                    Library.KeybindList.Items.List.Visible = bool 
                end})
                Section:Textbox({Name = "Custom Menu Name", Default = Window.Name, Callback = function(text)
                    Window.Name = text
                end})
                Section:Dropdown({Name = "Font", Options = FontIndexes, Callback = function(option)
                    for _,text in themes.utility.text_color.TextColor3 do 
                        text.FontFace = Fonts[option]
                    end 
                end, Default = "ProggyClean", Flag = "Menu Font"})
                Section:Slider({Name = "TextSize", Default = 12, Decimal = 1, Min = 1, Max = 30, Callback = function(int)
                    for _,text in themes.utility.text_color.TextColor3 do 
                        text.TextSize = int
                    end 

                    themes.preset.textsize = int
                end})
                Section:Slider({Name = "Blur Intensity", Default = 14, Decimal = 1, Min = 1, Max = 100, Flag = "BlurSize", Callback = function(int)
                    if Window.Items.Holder.Visible then 
                        Library.Blur.Size = int
                    end 
                end})
                Section:Button({Name = "Test", Callback = function()
                    local Notification = Library:Notification({Name = "Hello there!", Lifetime = 5})
                    Notification:NotificationButton({Name = "Discard", Callback = function()
                        Notification.DestroyNotif()
                    end})
                    Notification:NotificationButton({Name = "Make another", Callback = function()
                    end})
                end})
            -- 
        end
    --
        
    -- Notification Library
        local Notifications = Library.Notifications

        function Library:FadeNotification(path, is_fading) -- Horrendous dogshit code from like 500 years ago
            local fading = is_fading and 1 or 0 

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        Library:Tween(instance, {Transparency = fading}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    Library:Tween(instance, {TextTransparency = fading}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                elseif instance:IsA("Frame") then
                    Library:Tween(instance, {BackgroundTransparency = instance.Transparency and 0 and is_fading and 1 or 0}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                end
            end
        end 

        function Library:ReorderNotifications()
            local Offset = 50
            
            for _,notif in Notifications.Notifs do
                local Position = vec2(20, Offset)
                notif.Position = dim_offset(Position.X, Position.Y)
                -- Library:Tween(notif, {Position =}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                Offset += (notif.AbsoluteSize.Y + 5)
            end

            return Offset
        end 
        
        function Library:Notification(properties)
            local Cfg = {
                Name = properties.Name or "Notification",
                Lifetime = properties.Lifetime or nil,
                Type = properties.Type or "Normal", -- Flashing, Normal, Fading
                
                Items = {} 
            }

            local Index = #Notifications.Notifs + 1

            local Items = Cfg.Items; do
                Items.Holder = Library:Create( "Frame" , {
                    Parent = Library.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 18, 0, 70);
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(0, 0, 0, 21);
                    BorderSizePixel = 0;
                });	

                Items.ButtonHolder = Library:Create( "Frame" , {
                    Name = "\0";
                    Position = dim2(0, 0, 1, 5);
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Holder;
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIListLayout" , {
                    Parent = Items.ButtonHolder;
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                }); 

                Items.Notification = Library:Create( "Frame" , {
                    Parent = Items.Holder;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(0, 0, 0, 25);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Notification, "outline", "BackgroundColor3")

                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Notification;
                    Size = dim2(0, 1, 1, -4);
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Position = dim2(0, 2, 0, 2);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 3;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent 
                }); Library:Themify(Items.Accent, "accent", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    Parent = Items.Notification;
                    Size = dim2(1, -4, 1, -4);
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 2, 0, 2);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(15, 15, 20)
                });

                Items.FadingLine = Library:Create( "Frame" , {
                    Parent = Items.Notification;
                    Size = dim2(1, -4, 0, 1);
                    Name = "\0";
                    Position = dim2(0, 2, 1, -3);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                }); Library:Themify(Items.FadingLine, "accent", "BackgroundColor3")

                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.Notification;
                    TextColor3 = rgb(235, 235, 235);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = Cfg.Name;
                    Name = "\0";
                    TextTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    AnchorPoint = vec2(0, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 3;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIStroke" , {
                    Parent = Items.Title;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Library:Create( "UIPadding" , {
                    Parent = Items.Title;
                    PaddingRight = dim(0, 7);
                    PaddingLeft = dim(0, 9)
                });

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Notification;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(45, 45, 50)
                });
            end     

            function Cfg.DestroyNotif() 
                local Tween = Library:Tween(Items.Holder, {AnchorPoint = vec2(1, 0)}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))
                Library:FadeNotification(Items.Holder, true)

                Tween.Completed:Connect(function()
                    Items.Holder:Destroy()
                    Notifications.Notifs[Index] = nil
                    Library:ReorderNotifications()
                end)
            end

            local Offset = Library:ReorderNotifications()
            Notifications.Notifs[Index] = Items.Holder
            Library:FadeNotification(Items.Holder, false)

            Library:Tween(Items.Holder, {
                AnchorPoint = vec2(0, 0), 
                BackgroundTransparency = 1,
            }, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, false, 0))

            Items.Holder.Position = dim_offset(20, Offset)

            if Cfg.Lifetime then 
                task.spawn(function() 
                    task.wait(Cfg.Lifetime)
                    Cfg.DestroyNotif()
                end)            
            end 

            return setmetatable(Cfg, Library)
        end 

        function Library:NotificationButton(properties)
            local Cfg = {
                Name = properties.Name or "Name"; 
                Callback = properties.Callback or self.NotificationFade;
                
                Items = {};
            }   

            local Items = Cfg.Items; do 
                Items.Outline = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = self.Items.ButtonHolder;
                    Name = "\0";
                    Selectable = false;
                    Size = dim2(0, 0, 0, 18);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Size = dim2(0, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.inline 
                }); Library:Themify(Items.Inline, "inline", "BackgroundColor3")

                Items.InlineInline = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Size = dim2(0, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.InlineInline, "outline", "BackgroundColor3")

                Items.Background = Library:Create( "Frame" , {
                    ClipsDescendants = true;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.InlineInline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(0, -2, 1, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                }); Library:SaveGradient(Gradient, "elements");

                Items.Text = Library:Create( "TextLabel" , {
                    FontFace = Fonts[themes.preset.font];
                    Parent = Items.Background;
                    TextColor3 = rgb(145, 145, 145);
                    TextStrokeColor3 = rgb(255, 255, 255);
                    Text = Cfg.Name;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 2, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Library:Create( "UIStroke" , {
                    Parent = Items.Text
                });

                Library:Create( "UIPadding" , {
                    PaddingRight = dim(0, 2);
                    Parent = Items.Text
                });

                Library:Create( "UIPadding" , {
                    PaddingRight = dim(0, 3);
                    Parent = Items.InlineInline
                });

                Library:Create( "UIPadding" , {
                    PaddingRight = dim(0, 1);
                    Parent = Items.Inline
                });

                Library:Create( "UIPadding" , {
                    PaddingRight = dim(0, 1);
                    Parent = Items.Outline
                });
            end 

            Items.Outline.MouseButton1Click:Connect(Cfg.Callback)

            return setmetatable(Cfg, Library)
        end 
    -- 

    -- Esp Library Section  
        local MiscOptions = {
            ["Enabled"] = false;
            ["Render Distance"] = 10000; 

            -- Chams   
            ["ChamsEnabled"] = false; 
            ["Chams Fill"] = { Color = rgb(0, 255, 255), Transparency = 0.9 };
            ["Chams Outline"] = { Color = rgb(255, 0, 0), Transparency = 0.4 };

            -- Boxes
            ["Boxes"] = false;
            ["BoxType"] = "Normal";
            ["Box Gradient 1"] = { Color = rgb(0, 255, 255), Transparency = 0.9 };
            ["Box Gradient 2"] = { Color = rgb(255, 0, 0), Transparency = 0.4 };
            ["Box Gradient Rotation"] = 90;
            ["Box Fill"] = false; 
            ["Box Fill 1"] = { Color = rgb(0, 255, 255), Transparency = 0.9 };
            ["Box Fill 2"] = { Color = rgb(0, 255, 255), Transparency = 0.9 };
            ["Box Fill Rotation"] = 0;

            ["Healthbar"] = false; 
            ["Healthbar_Position"] = "Right"; 
            ["Healthbar_Number"] = false; 
            ["Healthbar_Low"] = { Color = rgb(247, 24, 180), Transparency = 1 }; --
            ["Healthbar_Medium"] = { Color = rgb(17, 30, 211), Transparency = 1 }; --
            ["Healthbar_Animations"] = false; 
            ["Healthbar_High"] = { Color = rgb(173, 69, 86), Transparency = 1 }; -- 
            ["Healthbar_Font"] = "ProggyClean";
            ["Healthbar_Text_Size"] = 12;
            ["Healthbar_Thickness"] = 1;
            ["Healthbar_Tween"] = false;
            ["Healthbar_EasingStyle"] = "Circular"; 
            ["Healthbar_EasingDirection"] = "InOut"; 
            ["Healthbar_Easing_Speed"] = 1;

            -- Text Based Elements
            ["Name_Text"] = false; 
            ["Name_Text_Color"] = { Color = rgb(255, 255, 255) };
            ["Name_Text_Position"] = "Top";
            ["Name_Text_Font"] = "ProggyClean";
            ["Name_Text_Size"] = 12;
            
            ["Distance_Text"] = false; 
            ["Distance_Text_Color"] = { Color = rgb(255, 255, 255) };
            ["Distance_Text_Position"] = "Bottom";
            ["Distance_Text_Font"] = "ProggyClean";
            ["Distance_Text_Size"] = 12;
        };  

        local Options = setmetatable({}, {__index = MiscOptions, __newindex = function(self, key, value) MiscOptions[key] = value Esp.RefreshElements(key, value) end});

        function Library:EspPreview(properties)
            local Cfg = {
                Items = {};
                CurrentTab;
                Section = self;
            } 

            local Items = Cfg.Items; do 
                Items.ESPHolder = Library:Create( "TextButton" , {
                    Parent = self.Items.Elements;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.ESPHolder, "outline", "BackgroundColor3")

                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, 1);
                    PaddingBottom = dim(0, 1);
                    Parent = Items.ESPHolder;
                    PaddingRight = dim(0, 1);
                    PaddingLeft = dim(0, 1)
                });

                Library:Create( "UIListLayout" , {
                    Parent = Items.ESPHolder;
                    Padding = dim(0, -1);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill
                });

                Items.Outline = Library:Create( "Frame" , {
                    LayoutOrder = -1;
                    Name = "\0";
                    Parent = Items.ESPHolder;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 18);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")

                Items.TabHolder = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.misc_1
                });	Library:Themify(Items.TabHolder, "misc_1", "BackgroundColor3")

                Library:Create( "UIListLayout" , {
                    Parent = Items.TabHolder;
                    Padding = dim(0, -1);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });

                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, -1);
                    PaddingBottom = dim(0, -1);
                    Parent = Items.TabHolder;
                    PaddingRight = dim(0, -1);
                    PaddingLeft = dim(0, -1)
                });
            end    

            return setmetatable(Cfg, Library)
        end 

        function Library:AddTab(properties)
            local Cfg = {
                Name = properties.Name;
                Items = {};
                Model = properties.Model; -- can be an id or a model
                Scale = properties.Scale or 1; -- This is used for scaling models. 
                ModelOffset = properties.ModelOffset or 1; -- offsetting large models or irregular bounding sized models. Especially well paired with scaling for best looks hehe
                VisualizedModel;
                Options = {};
                Chams = properties.Chams or false; -- Kinda hardcoded in since math is kinda poopy
                ReturnedOptions = {};
            } 

            local Items = Cfg.Items; do 
                -- Top Page
                    Items.Outline = Library:Create( "TextButton" , {
                        Parent = self.Items.TabHolder;
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.misc_1
                    }); Library:Themify(Items.Inline, "misc_2", "BackgroundColor3")
                    Library:Themify(Items.Inline, "misc_1", "BackgroundColor3")

                    Items.Title = Library:Create( "TextLabel" , {
                        FontFace = Fonts[themes.preset.font];
                        Parent = Items.Inline;
                        TextColor3 = themes.preset.unselected;
                        TextStrokeColor3 = rgb(255, 255, 255);
                        Text = Cfg.Name;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AnchorPoint = vec2(0, 0.5);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0.5, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIPadding" , {
                        Parent = Items.Title;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 7)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Title;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                --

                -- Middle page
                    Items.Holder = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Name = "\0";
                        Visible = false;
                        Size = dim2(0, 100, 0, 100);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.CharacterHolder = Library:Create( "Frame" , {
                        Parent = Items.Holder;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 18);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.CharacterHolder, "inline", "BackgroundColor3")

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 2);
                        Parent = Items.CharacterHolder
                    });

                    -- Fix here for studio? i think studio breaks it idk it worked before on pts
                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.CharacterHolder;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.misc_1
                    });	Library:Themify(Items.Background, "misc_1", "BackgroundColor3")

                    Library:Create( "UIPadding" , {
                        Parent = Items.Background
                    });

                    Items.ViewportFrame = Library:Create( "ViewportFrame" , {
                        Parent = Items.Background;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 200, 0, 200);
                        BorderSizePixel = 0;
                        ClipsDescendants = true;
                        BackgroundColor3 = themes.preset.misc_1
                    });	Library:Themify(Items.ViewportFrame, "misc_1", "BackgroundColor3")

                    -- Library:Create( "Frame" , {
                    --     Parent = Items.ViewportFrame;
                    --     BorderColor3 = rgb(0, 0, 0);
                    --     Size = dim2(0, 100, 0, 100);
                    --     BorderSizePixel = 0;
                    --     BackgroundColor3 = rgb(255, 255, 255)
                    -- }); why do u even exist
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Holder;
                        Padding = dim(0, -1);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    });

                    Items.ElementSelector = Library:Create( "Frame" , {
                        Parent = Items.Holder;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 18);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.ElementSelector, "inline", "BackgroundColor3")

                    Items.ElementHolder = Library:Create( "Frame" , {
                        Parent = Items.ElementSelector;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.misc_1
                    });	Library:Themify(Items.ElementHolder, "misc_1", "BackgroundColor3")

                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 5);
                        PaddingBottom = dim(0, 5);
                        Parent = Items.ElementHolder;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });

                    Library:Create( "UIGridLayout" , {
                        Parent = Items.ElementHolder;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        CellSize = dim2(0, 5, 0, 15)
                    });

                    -- for i = 1, 30 do testing haha lol
                    --     Items.Text = Library:Create( "TextLabel" , {
                    --         FontFace = Fonts[themes.preset.font];
                    --         Parent = Items.ElementHolder;
                    --         TextColor3 = rgb(145, 145, 145);
                    --         TextStrokeColor3 = rgb(255, 255, 255);
                    --         Text = "Badwawddawdawdawdawdawadwox " .. tostring(i);
                    --         Name = "\0";
                    --         AutomaticSize = Enum.AutomaticSize.XY;
                    --         Position = dim2(0, 1, 0, 0);
                    --         BorderSizePixel = 0;
                    --         BackgroundTransparency = 1;
                    --         TextXAlignment = Enum.TextXAlignment.Left;
                    --         BorderColor3 = rgb(0, 0, 0);
                    --         ZIndex = 2;
                    --         TextSize = 12;
                    --         BackgroundColor3 = themes.preset.unselected
                    --     });	Library:Themify(Items.Text, "unselected", "BackgroundColor3")

                    --     local Constraint = Library:Create( "UISizeConstraint" , {
                    --         MinSize = vec2(Items.Text.TextBounds.X, 0);
                    --         Parent = Items.Text
                    --     });

                    --     Items.Text:GetPropertyChangedSignal("TextBounds"):Connect(function()
                    --         Constraint.MinSize = vec2(Items.Text.TextBounds.X, 0);
                    --     end)
                    -- end 

                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 2);
                        Parent = Items.ElementSelector
                    });
                -- 

                -- Box
                    Items.Box = Library:Create( "Frame" , {
                        BackgroundTransparency = 1;
                        Parent = Items.ViewportFrame;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Left = Library:Create( "Frame" , {
                        Parent = Items.Box;
                        Size = dim2(0, 100, 1, 0);
                        BackgroundTransparency = 1;
                        Name = "\0";
                        AnchorPoint = vec2(1, 0);
                        Position = dim2(0, -1, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.LeftTexts = Library:Create( "Frame" , {
                        Parent = Items.Left;
                        Size = dim2(0, 0, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 1, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        LayoutOrder = 9999;
                        ZIndex = 2;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Vertical;
                        Parent = Items.LeftTexts;
                        Padding = dim(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Left;
                        Padding = dim(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Items.Bottom = Library:Create( "Frame" , {
                        Parent = Items.Box;
                        Size = dim2(1, 0, 0, 100);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        AutomaticSize = Enum.AutomaticSize.Y;
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.BottomTexts = Esp:Create( "Frame", {
                        LayoutOrder = 1;
                        Parent = Items.Bottom;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIListLayout", {
                        Parent = Items.BottomTexts;
                        Padding = dim(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Library:Create( "UIListLayout" , {
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalAlignment = Enum.HorizontalAlignment.Center;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Bottom;
                        Padding = dim(0, 1)
                    });

                    Items.Top = Library:Create( "Frame" , {
                        Parent = Items.Box;
                        Size = dim2(1, 0, 0, 100);
                        BackgroundTransparency = 1;
                        Name = "\0";
                        AnchorPoint = vec2(0, 1);
                        Position = dim2(0, 0, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        VerticalAlignment = Enum.VerticalAlignment.Bottom;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalAlignment = Enum.HorizontalAlignment.Center;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Top;
                        Padding = dim(0, 1)
                    });
                    
                    Items.TopTexts = Esp:Create( "Frame", {
                        LayoutOrder = -1;
                        Parent = Items.Top;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Right = Library:Create( "Frame" , {
                        Parent = Items.Box;
                        Size = dim2(0, 100, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 1, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Right;
                        Padding = dim(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });

                    Items.RightTexts = Library:Create( "Frame" , {
                        Parent = Items.Right;
                        Size = dim2(0, 0, 1, 0);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        LayoutOrder = 9999;
                        ZIndex = 2;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIListLayout" , {
                        Parent = Items.RightTexts;
                        Padding = dim(0, 1);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                -- 

                Items.Camera = Library:Create( "Camera" , {
                    CameraType = Enum.CameraType.Track;
                    Focus = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    Parent = Workspace;
                    CFrame = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1);
                    Name = "\0"
                });
            end

            local Math = {}; do 
                -- This will be coded entirely different btw
                -- Math for bounding is taken from dev forums cause im too lazy to figure out
                local Methods = Instance.new('Part')
                local IsA = Methods.IsA
                local GetDescendants = Methods.GetDescendants

                -- Methods (caching methods is faster ig?)
                local CFMethods = CFrame.new()
                local ToObjSpace = CFMethods.toObjectSpace
                local GetComponents = CFMethods.GetComponents
                local PointToWorldSpace = CFMethods.PointToWorldSpace
                
                local inf = math.huge
                local negInf = -inf

                function Math:GetBoundingBox(model, orientation)
                    model = type(model) ~= 'table' and model:GetDescendants() or model

                    orientation = orientation or CFrame.new()

                    local minx, miny, minz = inf, inf, inf
                    local maxx, maxy, maxz = negInf, negInf, negInf

                    for _,obj in model do
                        if obj:IsA("BasePart") then
                            local cf = ToObjSpace(orientation, obj.CFrame)
                            local size = obj.Size
                            local sx, sy, sz = size.X, size.Y, size.Z

                            local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = GetComponents(cf)

                            local wsx = 0.5 * (math.abs(R00) * sx + math.abs(R01) * sy + math.abs(R02) * sz)
                            local wsy = 0.5 * (math.abs(R10) * sx + math.abs(R11) * sy + math.abs(R12) * sz)
                            local wsz = 0.5 * (math.abs(R20) * sx + math.abs(R21) * sy + math.abs(R22) * sz)

                            minx = minx > x - wsx and x - wsx or minx
                            miny = miny > y - wsy and y - wsy or miny
                            minz = minz > z - wsz and z - wsz or minz

                            maxx = maxx < x + wsx and x + wsx or maxx
                            maxy = maxy < y + wsy and y + wsy or maxy
                            maxz = maxz < z + wsz and z + wsz or maxz
                        end
                    end

                    local omin, omax = Vector3.new(minx, miny, minz), Vector3.new(maxx, maxy, maxz)
                    return orientation - orientation.p + PointToWorldSpace(orientation, (omax + omin) * 0.5), (omax - omin)
                end
                
                function Math:Solve(model, viewportFrame, Camera)
                    local min = Vector2.new(math.huge, math.huge)
                    local max = Vector2.new(-math.huge, -math.huge)

                    for _,obj in model:GetDescendants() do
                        if obj:IsA("BasePart") then
                            local size = obj.Size
                            local cframe = obj.CFrame

                            local corners = {
                                Vector3.new( 0.5,  0.5,  0.5),
                                Vector3.new(-0.5,  0.5,  0.5),
                                Vector3.new( 0.5, -0.5,  0.5),
                                Vector3.new(-0.5, -0.5,  0.5),
                                Vector3.new( 0.5,  0.5, -0.5),
                                Vector3.new(-0.5,  0.5, -0.5),
                                Vector3.new( 0.5, -0.5, -0.5),
                                Vector3.new(-0.5, -0.5, -0.5),
                            }

                            for _, corner in pairs(corners) do
                                local worldPoint = cframe:PointToWorldSpace(Vector3.new(
                                    corner.X * size.X,
                                    corner.Y * size.Y,
                                    corner.Z * size.Z
                                    ))

                                local viewportPoint, visible = Camera:WorldToViewportPoint(worldPoint)

                                if visible then
                                    min = Vector2.new(math.min(min.X, viewportPoint.X), math.min(min.Y, viewportPoint.Y))
                                    max = Vector2.new(math.max(max.X, viewportPoint.X), math.max(max.Y, viewportPoint.Y))
                                end
                            end
                        end
                    end

                    local viewAbsSize = viewportFrame.AbsoluteSize

                    local size2D = max - min
                    local pos2D = min

                    local relativePos = Vector2.new(pos2D.X / viewAbsSize.X, pos2D.Y / viewAbsSize.Y)
                    local relativeSize = Vector2.new(size2D.X / viewAbsSize.X, size2D.Y / viewAbsSize.Y)

                    return UDim2.fromScale(relativePos.X * 200, relativePos.Y * 200), UDim2.fromScale(relativeSize.X * 200, relativeSize.Y * 200)
                end

                function Math:FindClosestFrame(Position, Instances, List)
                    local Min = math.huge
                    local ClosestFrame

                    -- What the fuck this is so gay
                    local String = List or {"Items.Left", "Items.Right", "Items.Bottom", "Items.Top", "Items.ElementHolder"}

                    for _,frame in (Instances or {Items.Left, Items.Right, Items.Bottom, Items.Top, Items.ElementHolder}) do
                        local Magnitude = (vec2(frame.AbsolutePosition.X, frame.AbsolutePosition.Y) - Position).magnitude
                        if Magnitude < Min then
                            ClosestFrame = String[_]:gsub("Items.", "")
                            Min = Magnitude
                        end
                    end 

                    return ClosestFrame
                end 
            end 

            function Cfg.AddBar(props) 
                local Config = {
                    Name = props.Name or "I dont know";
                    Enabled = props.Enabled or false; 
                    Position = props.Position or "Left"; 
                    Flag = Cfg.Name .. " " .. props.Name;
                    Colors = props.Colors; 
                    Width = 3;

                    Prefix = props.Prefix or "Healthbar"; 

                    Items = {};
                    Objects = {};
                    Holder;
                    Tweening = false;
                }

                local TextDragging = false;
                local BarDragging = false; 

                local Elements = Config.Items; do -- Useless ahh
                    -- Esp Preview
                        Elements.Type = Library:Create( "Frame" , {
                            Name = "\0";
                            Parent = Items.Left;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 3, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(0, 0, 0)
                        });

                        Elements.Bar = Library:Create( "Frame" , {
                            Parent = Elements.Type;
                            Name = "\0";
                            Position = dim2(0, 1, 0.5, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 0.5, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Elements.BarGradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.Bar;
                            Color = rgbseq{rgbkey(0, rgb(0, 255, 0)), rgbkey(0.5, rgb(255, 125, 0)), rgbkey(1, rgb(255, 0, 0))}
                        });
                    -- 
                    
                    -- Healthbar Section
                        Elements.Information = Library:Create( "TextButton" , {
                            Parent = Library.Other;
                            Size = dim2(0, 213, 0, 71);
                            Name = "\0";
                            Visible = false;
                            Position = dim2(0, 100, 0, 100);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 1;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.Information, "outline", "BackgroundColor3")

                        Elements.Inline = Library:Create( "Frame" , {
                            Parent = Elements.Information;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(45, 45, 50)
                        });

                        Elements.InlineInline = Library:Create( "Frame" , {
                            Parent = Elements.Inline;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.InlineInline, "outline", "BackgroundColor3")

                        Elements.Background = Library:Create( "Frame" , {
                            Parent = Elements.InlineInline;
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        local Gradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.Background;
                            Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                        }); Library:SaveGradient(Gradient, "elements");
                        
                        Elements.Elements = Library:Create( "Frame" , {
                            Parent = Elements.Background;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 12, 0, 5);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -24, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIPadding" , {
                            Parent = Elements.Elements;
                            PaddingTop = dim(0, 0);
                            PaddingBottom = dim(0, 8)
                        });

                        Library:Create( "UIListLayout" , {
                            Parent = Elements.Elements;
                            Padding = dim(0, 7);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        -- Caching elements so that I can make a funny open check so that it dont close when a colorpicker is open
                        Elements.Options = {} 

                        local Section = setmetatable(Config, Library)
                        Elements.Options.Low = Section:Label({Name = "Low"}):Colorpicker({Callback = function(color)
                            Elements.BarGradient.Color = rgbseq{
                                rgbkey(0, Flags[Config.Flag .. "_COLOR1"].Color), 
                                Elements.BarGradient.Color.Keypoints[2], 
                                Elements.BarGradient.Color.Keypoints[3]
                            }

                            Options[Config.Prefix .. "_Low"] = Flags[Config.Flag .. "_COLOR1"]
                        end, Flag = Config.Flag .. "_COLOR1", Color = props.Color1 or rgb(255, 0, 0)})

                        Elements.Options.Medium = Section:Label({Name = "Medium"}):Colorpicker({Callback = function(color)
                            Elements.BarGradient.Color = rgbseq{
                                Elements.BarGradient.Color.Keypoints[1], 
                                rgbkey(0.5, Flags[Config.Flag .. "_COLOR2"].Color), 
                                Elements.BarGradient.Color.Keypoints[3]
                            }

                            Options[Config.Prefix .. "_Medium"] = Flags[Config.Flag .. "_COLOR2"]
                        end, Flag = Config.Flag .. "_COLOR2", Color = props.Color1 or rgb(255, 255, 0)})

                        Elements.Options.High = Section:Label({Name = "High"}):Colorpicker({Callback = function(color)
                            Elements.BarGradient.Color = rgbseq{
                                Elements.BarGradient.Color.Keypoints[1], 
                                Elements.BarGradient.Color.Keypoints[2], 
                                rgbkey(1, Flags[Config.Flag .. "_COLOR3"].Color)
                            }

                            Options[Config.Prefix .. "_High"] = Flags[Config.Flag .. "_COLOR3"]
                        end, Flag = Config.Flag .. "_COLOR3", Color = props.Color1 or rgb(0, 255, 0)})

                        Elements.Options.BarThickness = Section:Slider({Name = "Thickness", Min = 1, Max = 5, Default = 1, Decimal = 1, Callback = function(int)
                            Options[Config.Prefix .. "_Thickness"] = int
                        end, Flag = Config.Flag .. "_THICKNESS"})

                        Section:Toggle({Name = "Show Number", Callback = function(bool)
                            Options[Config.Prefix .. "_Number"] = bool
                        end, Flag = Config.Flag .. "_NUMBER"})

                        Elements.Options.Font = Section:Dropdown({Name = "Font", Options = FontIndexes, Default = "ProggyClean", Callback = function(option)
                            Options[Config.Prefix .. "_Font"] = option
                        end, Flag = Config.Flag .. "_FONT"})

                        Elements.Options.TextSize = Section:Slider({Name = "Text Size", Min = 1, Max = 30, Default = 12, Decimal = 1, Callback = function(int)
                            Options[Config.Prefix .. "_Text_Size"] = int
                        end, Flag = Config.Flag .. "_TEXT_SIZE"})

                        Section:Toggle({Name = "Enable Animations", Flag = Config.Flag .. "_LIST", Callback = function(bool)
                            Options[Config.Prefix .. "_Tween"] = bool
                        end, Flag = Config.Flag .. "_ANIMATIONS"})

                        Elements.Options.Mode = Section:Dropdown({Name = "Mode", Options = {"Linear", "Sine", "Back", "Bounce", "Circular", "Cubic", "Elastic", "Exponential", "Quad", "Quart", "Quint"}, Default = "Sine", Callback = function(option)
                            Options[Config.Prefix .. "_EasingStyle"] = option
                        end, Flag = Config.Flag .. "_MODE"})

                        Elements.Options.Direction = Section:Dropdown({Name = "Direction", Options = {"In", "Out", "InOut"}, Default = "InOut", Callback = function(option)
                            Options[Config.Prefix .. "_EasingDirection"] = option
                        end, Flag = Config.Flag .. "_EASING_DIRECTION"})
                        
                        Elements.Options.AnimationSpeed = Section:Slider({Name = "Speed", Min = 0, Max = 5, Decimal = 0.01, Suffix = "s", Default = 1, Callback = function(num)
                            Options[Config.Prefix .. "_Easing_Speed"] = num
                        end, Flag = Config.Flag .. "_ANIMATION_SPEED"})

                        for _,element in {Elements.Options.Low, Elements.Options.Medium, Elements.Options.High} do 
                            Elements.Options[#Elements.Options + 1] = element.Items.Animations
                        end 
                    -- 
                    
                    -- TextLabel
                        Elements.Text = Library:Create( "TextLabel" , {
                            FontFace = Fonts[themes.preset.font];
                            Parent = Items.ElementHolder;
                            TextColor3 = rgb(145, 145, 145);
                            TextStrokeColor3 = rgb(255, 255, 255);
                            Text = Config.Name;
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = themes.preset.unselected
                        });	Library:Themify(Elements.Text, "unselected", "BackgroundColor3")

                        local Constraint = Library:Create( "UISizeConstraint" , {
                            MinSize = vec2(Elements.Text.TextBounds.X, Elements.Text.TextBounds.Y);
                            Parent = Elements.Text
                        }); 

                        Elements.Text:GetPropertyChangedSignal("TextBounds"):Connect(function()
                            Constraint.MinSize = vec2(Elements.Text.TextBounds.X + 10, Elements.Text.TextBounds.Y);
                        end)
                    --
                end

                function Config.UpdateOnParent() 
                    for _,newparent in {Items.Left, Items.Top, Items.Right, Items.Bottom} do 
                        if newparent == Elements.Type.Parent then 
                            local isVertical =  _ % 2 == 1
                            Elements.Type.Size = isVertical and dim2(0, Config.Width, 1, 0) or dim2(1, 0, 0, Config.Width)
                            Elements.Bar.Position = isVertical and dim2(0, 1, 0, 1) or dim2(0, 1, 0, 1)
                            Elements.Bar.Size = isVertical and dim2(0, Config.Width - 2, 1, -2) or dim2(1, -2, 0, Config.Width - 2)
                            Elements.BarGradient.Rotation = isVertical and -90 or 180
                            
                            return
                        end
                    end
                end 

                function Config.Set(Info) 
                    local Enabled = Info.Enabled 
                    local Position = Info.Position 

                    Elements.Text.Parent = Enabled and Library.Other or Items.ElementHolder
                    Elements.Type.Parent = Enabled and Items[Position] or Library.Other

                    Options[Config.Prefix] = Enabled
                    Options[Config.Prefix .. "_Position"] = Position
                    
                    Config.UpdateOnParent()

                    Flags[Config.Flag] = {
                        Enabled = Enabled,
                        Position = Position 
                    }
                end

                function Config.Tween(bool) 
                    if Config.Tweening == true then 
                        return 
                    end 

                    Config.Tweening = true 

                    if bool then 
                        Elements.Information.Visible = true
                    end

                    local Children = Elements.Information:GetDescendants()
                    table.insert(Children, Elements.Information)

                    local Tween;
                    for _,obj in Children do
                        local Index = Library:GetTransparency(obj)

                        if not Index then 
                            continue 
                        end

                        if type(Index) == "table" then
                            for _,prop in Index do
                                Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                            end
                        else
                            Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                        end
                    end

                    Library:Connection(Tween.Completed, function()
                        Config.Tweening = false
                        Elements.Information.Parent = bool and Library.Items or Library.Other
                        Elements.Information.Visible = bool
                    end)
                end

                function Config.DetermineClosing() 
                    for _,element in Elements.Options do
                        local Holder = element.Items.DropdownElements
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end 

                        local Holder = element.Items.Colorpicker
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end     
                    end 

                    return false
                end 

                Elements.Text.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                        Elements.Text.Parent = Library.Items 

                        TextDragging = true
                    end
                end)

                Elements.Text.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36))
                        local ParentIsHolder = Parent == "ElementHolder"

                        TextDragging = false

                        Config.Set({Enabled = not ParentIsHolder, Position = Parent})
                    end
                end)

                Elements.Type.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                        Elements.Text.Parent = Library.Items 
                        Elements.Type.Parent = Library.Other 

                        BarDragging = true
                    end

                    if input.UserInputType == Enum.UserInputType.MouseButton2 then 
                        if Config.Tweening then 
                            return 
                        end 

                        Config.Open = not Config.Open 
                        Config.Tween(Config.Open)
                        Elements.Information.Position = dim_offset(input.Position.X + 5, input.Position.Y + 70)
                    end
                end)

                Elements.Type.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36))

                        local ParentIsHolder = Parent == "ElementHolder"

                        BarDragging = false
                        Config.Set({Enabled = not ParentIsHolder, Position = Parent})
                    end
                end)
                
                Library:Connection(InputService.InputChanged, function(input, game_event) 
                    if (TextDragging or BarDragging) and input.UserInputType == Enum.UserInputType.MouseMovement then            
                        Library:Tween(Elements.Text, {
                            Position = dim_offset(input.Position.X, input.Position.Y + 36 + Elements.Text.AbsoluteSize.Y)
                        }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                    end
                end)    

                Library:Connection(InputService.InputEnded, function(input, game_event) 
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and Elements.Information.Visible and not (Library:Hovering({Elements.Information}) or Config.DetermineClosing()) then 
                        Config.Tween(false)
                        Config.Open = false
                    end 
                end)

                Elements.Type:GetPropertyChangedSignal("Parent"):Connect(Config.UpdateOnParent)

                ConfigFlags[Config.Flag] = Config.Set
                Config.Set({Enabled = Config.Enabled, Position = Config.Position})
                
                return setmetatable(Config, Library)
            end 

            function Cfg.AddText(props) 
                local Config = {
                    Name = props.Name or "I dont know";
                    Enabled = props.Enabled or false; 
                    Position = props.Position or "Left"; 
                    Flag = Cfg.Name .. " " .. props.Name;
                    Colors = props.Colors or 2; 

                    Prefix = props.Prefix or "Name";

                    Items = {};
                    Objects = {};
                    Holder;
                    Width = 3;
                    Tweening = false;
                }

                local TextDragging = false;
                local BarDragging = false; 

                local Elements = Config.Items; do -- Useless ahh
                    -- Esp Preview
                        Elements.Name = Library:Create( "TextLabel" , {
                            FontFace = Fonts[themes.preset.font];
                            TextColor3 = rgb(255, 255, 255);
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "Left";
                            Text = Config.Name;
                            BackgroundTransparency = 1;
                            Size = dim2(1, 0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 9;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });	Library:Themify(Elements.Text, "unselected", "BackgroundColor3")

                        Elements.Stroke = Library:Create( "UIStroke" , {
                            Parent = Elements.Name;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                    -- 
                    
                    -- Text Section
                        Elements.Information = Library:Create( "TextButton" , {
                            Parent = Library.Other;
                            Size = dim2(0, 213, 0, 71);
                            Name = "\0";
                            Visible = false;
                            Position = dim2(0, 100, 0, 100);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 1;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.Information, "outline", "BackgroundColor3")

                        Elements.Inline = Library:Create( "Frame" , {
                            Parent = Elements.Information;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(45, 45, 50)
                        });

                        Elements.InlineInline = Library:Create( "Frame" , {
                            Parent = Elements.Inline;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.InlineInline, "outline", "BackgroundColor3")

                        Elements.Background = Library:Create( "Frame" , {
                            Parent = Elements.InlineInline;
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        local Gradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.Background;
                            Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                        }); Library:SaveGradient(Gradient, "elements");
                        
                        Elements.Elements = Library:Create( "Frame" , {
                            Parent = Elements.Background;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 12, 0, 5);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -24, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIPadding" , {
                            Parent = Elements.Elements;
                            PaddingTop = dim(0, 0);
                            PaddingBottom = dim(0, 8)
                        });

                        Library:Create( "UIListLayout" , {
                            Parent = Elements.Elements;
                            Padding = dim(0, 7);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        -- Caching elements so that I can make a funny open check so that it dont close when a colorpicker is open
                        Elements.Options = {} 

                        local Section = setmetatable(Config, Library)
                        local Label = Section:Label({Name = "Color"})
                        Elements.Options.Text = Label:Colorpicker({Callback = function(value)
                            Elements.Name.TextColor3 = Flags[Config.Flag .. "_COLOR1"].Color
                            Options[Config.Prefix .. "_Text_Color"] = Flags[Config.Flag .. "_COLOR1"]
                        end, Flag = Config.Flag .. "_COLOR1", Color = props.Color1 or rgb(255, 255, 255)})

                        Elements.Options.Font = Section:Dropdown({Name = "Font", Options = FontIndexes, Default = "ProggyClean", Callback = function(option)
                            Options[Config.Prefix .. "_Text_Font"] = option
                        end, Flag = Config.Flag .. "_FONT"})

                        Elements.Options.TextSize = Section:Slider({Name = "Text Size", Min = 1, Max = 30, Default = 12, Decimal = 1, Callback = function(int)
                            Options[Config.Prefix .. "_Text_Size"] = int
                        end, Flag = Config.Flag .. "_TEXT_SIZE"})

                        -- Might add more here thats why I made it a table
                        for _,element in {Elements.Options.Text, Elements.Options.Outline} do 
                            Elements.Options[#Elements.Options + 1] = element.Items.Animations
                        end 
                    -- 
                    
                    -- TextLabel
                        Elements.Text = Library:Create( "TextLabel" , {
                            FontFace = Fonts[themes.preset.font];
                            Parent = Items.ElementHolder;
                            TextColor3 = rgb(145, 145, 145);
                            TextStrokeColor3 = rgb(255, 255, 255);
                            Text = Config.Name;
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = themes.preset.unselected
                        });	Library:Themify(Elements.Text, "unselected", "BackgroundColor3")

                        local Constraint = Library:Create( "UISizeConstraint" , {
                            MinSize = vec2(Elements.Text.TextBounds.X, Elements.Text.TextBounds.Y);
                            Parent = Elements.Text
                        });

                        Elements.Text:GetPropertyChangedSignal("TextBounds"):Connect(function()
                            Constraint.MinSize = vec2(Elements.Text.TextBounds.X, Elements.Text.TextBounds.Y);
                        end)
                    --
                end

                function Config.UpdateOnParent() 
                    for _,newparent in {"Left", "Top", "Right", "Bottom"} do 
                        if Items[newparent .. "Texts"] == Elements.Name.Parent then 
                            local isVertical = _ % 2 ~= 0
                            local isRightParent = newparent == "Right"

                            local Direction = (isVertical and isRightParent) and "Left" or (isVertical and "Right" or "Center")
                            Elements.Name.TextXAlignment = Enum.TextXAlignment[Direction]

                            return  
                        end
                    end
                end 

                function Config.Set(Info) 
                    local Enabled = Info.Enabled 
                    local Position = Info.Position

                    Elements.Text.Parent = Enabled and Library.Other or Items.ElementHolder
                    Elements.Name.Parent = Enabled and Items[Position] or Library.Other

                    Options[Config.Prefix .. "_Text"] = Enabled
                    Options[Config.Prefix .. "_Text_Position"] = Position:gsub("Texts", "")
                    
                    Flags[Config.Flag] = {
                        Enabled = Enabled,
                        Position = Position 
                    }
                end

                function Config.Tween(bool) 
                    if Config.Tweening == true then 
                        return 
                    end 

                    Config.Tweening = true 

                    if bool then 
                        Elements.Information.Visible = true
                        Elements.Information.Parent = Library.Items
                    end

                    local Children = Elements.Information:GetDescendants()
                    table.insert(Children, Elements.Information)

                    local Tween;
                    for _,obj in Children do
                        local Index = Library:GetTransparency(obj)

                        if not Index then 
                            continue 
                        end

                        if type(Index) == "table" then
                            for _,prop in Index do
                                Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                            end
                        else
                            Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                        end
                    end

                    Library:Connection(Tween.Completed, function()
                        Config.Tweening = false
                        Elements.Information.Parent = bool and Library.Items or Library.Other
                        Elements.Information.Visible = bool
                    end)
                end

                function Config.DetermineClosing() 
                    for _,element in Elements.Options do
                        local Holder = element.Items.DropdownElements
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end 

                        local Holder = element.Items.Colorpicker
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end     
                    end 

                    return false
                end 

                Elements.Text.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                        Elements.Text.Parent = Library.Items 

                        TextDragging = true
                    end
                end)

                Elements.Text.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36))
                        local ParentIsHolder = Parent == "ElementHolder"

                        TextDragging = false

                        Config.Set({Enabled = not ParentIsHolder, Position = Parent .. "Texts"})
                    end
                end)

                Elements.Name.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                        Elements.Text.Parent = Library.Items 
                        Elements.Name.Parent = Library.Other 

                        BarDragging = true
                    end

                    if input.UserInputType == Enum.UserInputType.MouseButton2 then 
                        if Config.Tweening then 
                            return 
                        end 

                        Config.Open = not Config.Open 
                        Config.Tween(Config.Open)
                        Elements.Information.Position = dim_offset(input.Position.X + 5, input.Position.Y + 70)
                    end
                end)

                Elements.Name.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36))
                        local ParentIsHolder = Parent == "ElementHolder"

                        BarDragging = false 
                        Config.Set({Enabled = not ParentIsHolder, Position = Parent .. "Texts"})
                    end
                end)
                
                Library:Connection(InputService.InputChanged, function(input, game_event) 
                    if (TextDragging or BarDragging) and input.UserInputType == Enum.UserInputType.MouseMovement then            
                        Library:Tween(Elements.Text, {
                            Position = dim_offset(input.Position.X, input.Position.Y + 36 + Elements.Text.AbsoluteSize.Y)
                        }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                    end
                end)    

                Library:Connection(InputService.InputEnded, function(input, game_event) 
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and Elements.Information.Visible and not (Library:Hovering({Elements.Information}) or Config.DetermineClosing()) then 
                        Config.Tween(false)
                        Config.Open = false
                    end 
                end)    

                Elements.Name:GetPropertyChangedSignal("Parent"):Connect(Config.UpdateOnParent)

                ConfigFlags[Config.Flag] = Config.Set
                Config.Set({Enabled = Config.Enabled, Position = Config.Position})

                return setmetatable(Config, Library)
            end

            function Cfg.AddBox(props) 
                local Config = {
                    Name = props.Name or "I dont know";
                    Enabled = props.Enabled or false; 
                    Position = props.Position or "Left"; 
                    Flag = Cfg.Name .. " " .. props.Name;
                    Colors = props.Colors or 2; 

                    Items = {};
                    Objects = {};
                    Holder;
                    Width = 3;
                    Tweening = false;
                }

                local TextDragging = false;
                local BarDragging = false; 

                local Elements = Config.Items; do
                    -- Esp Preview
                        Elements.BoxHolder = Library:Create( "Frame" , {
                            Visible = true;
                            Size = dim2(1, -2, 1, -2);
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Library.Other;
                            BackgroundTransparency = 0.8500000238418579;
                            Position = dim2(0, 1, 0, 1);
                            Name = "\0";
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Elements.BoxHolderGradient = Library:Create( "UIGradient" , {
                            Rotation = 0;
                            Name = "\0";
                            Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(255, 255, 255))};
                            Parent = Elements.BoxHolder;
                            Enabled = true
                        }); 

                        Library:Create( "UIStroke" , {
                            Parent = Elements.BoxHolder;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                        
                        Elements.Inner = Library:Create( "Frame" , {
                            Parent = Elements.BoxHolder;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Elements.UIStroke = Library:Create( "UIStroke" , {
                            Color = rgb(255, 255, 255);
                            LineJoinMode = Enum.LineJoinMode.Miter;
                            Parent = Elements.Inner
                        });
                        
                        Elements.Gradient = Library:Create( "UIGradient" , {
                            Rotation = 0;
                            Name = "\0";
                            Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(255, 255, 255))};
                            Parent = Elements.UIStroke;
                            Enabled = true
                        });
                        
                        Elements.Inner2 = Library:Create( "Frame" , {
                            Parent = Elements.BoxHolder;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 2, 0, 2);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -4, 1, -4);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIStroke" , {
                            Parent = Elements.Inner2;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                    -- 

                    -- Cornerboxes
                        Elements.Corners = Library:Create( "Frame" , {
                            Parent = Library.Other;
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, 0, 1, 0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Elements.CornersGradient = Library:Create( "UIGradient" , {
                            Parent = Elements.Corners;
                        });

                        Elements.BottomLeftX = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0.25, 0, 0, 3);
                            AnchorPoint = vec2(0, 1);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 1, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                        });

                        Library:Create( "UIGradient" , {
                            Parent = Elements.BottomLeftX
                        });

                        Elements.BottomLeftY = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0, 3, 0.25, -9);
                            AnchorPoint = vec2(0, 1);
                            Image = "rbxassetid://101715268403902";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 1, -2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                        });

                        Library:Create( "UIGradient" , {
                            Rotation = -90;
                            Parent = Elements.BottomLeftY
                        });

                        Elements.BottomLeftX = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0.25, 0, 0, 3);
                            AnchorPoint = vec2(1, 1);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 0, 1, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                        });

                        Library:Create( "UIGradient" , {
                            Parent = Elements.BottomLeftX
                        });

                        Elements.BottomLeftY = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0, 3, 0.25, -9);
                            AnchorPoint = vec2(1, 1);
                            Image = "rbxassetid://101715268403902";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 0, 1, -2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                        });

                        Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.BottomLeftY
                        });

                        Elements.TopLeftY = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Elements.Corners;
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0, 3, 0.25, -9);
                            Image = "rbxassetid://102467475629368";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 0, 2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                        });

                        Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.TopLeftY
                        });

                        Elements.TopRightY = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0, 3, 0.25, -9);
                            AnchorPoint = vec2(1, 0);
                            Image = "rbxassetid://102467475629368";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 0, 0, 2);
                            ZIndex = 500;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                        });

                        Library:Create( "UIGradient" , {
                            Rotation = -90;
                            Parent = Elements.TopRightY
                        });

                        Elements.TopRightX = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            Parent = Elements.Corners;
                            BorderColor3 = rgb(0, 0, 0);
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Size = dim2(0.25, 0, 0, 3);
                            AnchorPoint = vec2(1, 0);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                        });

                        Library:Create( "UIGradient" , {
                            Parent = Elements.TopRightX
                        });

                        Elements.TopLeftX = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Slice;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Elements.Corners;
                            Name = "\0";
                            BackgroundColor3 = rgb(255, 255, 255);
                            Image = "rbxassetid://83548615999411";
                            BackgroundTransparency = 1;
                            Size = dim2(0.25, 0, 0, 3);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                        });

                        Library:Create( "UIGradient" , {
                            Parent = Elements.TopLeftX
                        });
                    -- 

                    -- Box Section
                        Elements.Information = Library:Create( "TextButton" , {
                            Parent = Library.Other;
                            Size = dim2(0, 213, 0, 71);
                            Name = "\0";
                            Visible = false;
                            Position = dim2(0, 100, 0, 100);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 1;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.Information, "outline", "BackgroundColor3")

                        Elements.Inline = Library:Create( "Frame" , {
                            Parent = Elements.Information;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(45, 45, 50)
                        });

                        Elements.InlineInline = Library:Create( "Frame" , {
                            Parent = Elements.Inline;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Elements.InlineInline, "outline", "BackgroundColor3")

                        Elements.Background = Library:Create( "Frame" , {
                            Parent = Elements.InlineInline;
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            ClipsDescendants = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        local Gradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Elements.Background;
                            Color = rgbseq{rgbkey(0, rgb(30, 30, 35)), rgbkey(1, rgb(23, 23, 28))}
                        }); Library:SaveGradient(Gradient, "elements");
                        
                        Elements.Elements = Library:Create( "Frame" , {
                            Parent = Elements.Background;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 12, 0, 5);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -24, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Library:Create( "UIPadding" , {
                            Parent = Elements.Elements;
                            PaddingTop = dim(0, 0);
                            PaddingBottom = dim(0, 8)
                        });

                        Library:Create( "UIListLayout" , {
                            Parent = Elements.Elements;
                            Padding = dim(0, 7);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        -- Caching elements so that I can make a funny open check so that it dont close when a colorpicker is open
                        Elements.Options = {} 

                        local Section = setmetatable(Config, Library)
                        Elements.Options.Type = Section:Dropdown({
                            Name = "Type",
                            Options = { "Corner", "Box"},
                            Default = "Box",
                            Flag = Config.Flag .. "_CORNERS_ENABLED",
                            Callback = function(option)
                                local isCorner = Flags[Config.Flag .. "_CORNERS_ENABLED"] == "Corner"
                                Elements.Corners.Parent = isCorner and Items.Box or Library.Other
                                Elements.BoxHolder.Parent = isCorner and Library.Other or Items.Box

                                Items.ViewportFrame.AutomaticSize = Enum.AutomaticSize.Y 
                                task.wait()
                                Items.ViewportFrame.AutomaticSize = Enum.AutomaticSize.None -- ultra gay fixes for robloxses stupid asf automatic size PELASE ROBLOX FIX THIS SHIT

                                Elements.BoxHolder.Size = dim2(1, 0, 0, 0)
                                task.wait()
                                Elements.BoxHolder.Size = dim2(1, -2, 1, -2) -- what the fuck

                                Options.BoxType = option
                            end
                        })

                        Elements.Options.Low = Section:Label({ Name = "Low" }):Colorpicker({Default = props.Color1 or rgb(255, 255, 255), Callback = function()
                                local Color1 = Flags[Config.Flag .. "_GRADIENT_COLOR1"].Color
                                local Color2 = Flags[Config.Flag .. "_GRADIENT_COLOR2"] and Flags[Config.Flag .. "_GRADIENT_COLOR2"].Color or (props.Color2 or rgb(255, 255, 255))

                                for _, descendant in Elements.Corners:GetDescendants() do
                                    if descendant:IsA("UIGradient") then
                                        descendant.Color = rgbseq{ rgbkey(0, Color1), rgbkey(1, Color2) }
                                    end
                                end

                                Elements.Gradient.Color = rgbseq{ rgbkey(0, Color1), rgbkey(1, Color2) }

                                Options["Box Gradient 1"] = Flags[Config.Flag .. "_GRADIENT_COLOR1"]
                        end, Flag = Config.Flag .. "_GRADIENT_COLOR1"})
                        
                        Elements.Options.High = Section:Label({ Name = "High" }):Colorpicker({
                            Flag = Config.Flag .. "_GRADIENT_COLOR2",
                            Default = props.Color2 or rgb(255, 255, 255),
                            Callback = function()
                                local color1 = Flags[Config.Flag .. "_GRADIENT_COLOR1"].Color
                                local color2 = Flags[Config.Flag .. "_GRADIENT_COLOR2"].Color

                                for _, descendant in Elements.Corners:GetDescendants() do
                                    if descendant:IsA("UIGradient") then
                                        descendant.Color = rgbseq{ rgbkey(0, color1), rgbkey(1, color2) }
                                    end
                                end

                                Elements.Gradient.Color = rgbseq{ rgbkey(0, color1), rgbkey(1, color2) }

                                Options["Box Gradient 2"] = Flags[Config.Flag .. "_GRADIENT_COLOR2"]
                            end
                        })

                        Elements.Options.Slider = Section:Slider({Name = "Gradient Rotation", Min = 0, Max = 360, Decimals = 1, Default = props.Rotation or 0, Callback = function(rotation)
                            for _, descendant in Elements.Corners:GetDescendants() do
                                if descendant:IsA("UIGradient") then
                                    descendant.Rotation += rotation
                                end
                            end
                            
                            Elements.Gradient.Rotation = rotation

                            Options["Box Gradient Rotation"] = rotation
                        end, Flag = Config.Flag .. "_GRADIENT_ROTATION"})  

                        Elements.Options.BoxFillToggle = Section:Toggle({Name = "Box Fill", Callback = function(bool)
                            Elements.Corners.BackgroundTransparency = bool and 0 or 1
                            Elements.BoxHolder.BackgroundTransparency = bool and 0 or 1

                            Options["Box Fill"] = bool
                        end, Flag = Config.Flag .. "_BOX_FILL_ENABLED"})

                        Elements.Options.BoxFill1 = Elements.Options.BoxFillToggle:Colorpicker({Name = "Top Gradient", Callback = function(color, alpha)
                            local Path = Elements.CornersGradient
                            Path.Transparency = numseq{
                                numkey(0, 1 - alpha), 
                                Path.Transparency.Keypoints[2]
                            };

                            Path.Color = rgbseq{
                                rgbkey(0, color), 
                                Path.Color.Keypoints[2]
                            }

                            local Path = Elements.BoxHolderGradient
                            Path.Transparency = numseq{
                                Path.Transparency.Keypoints[1],
                                numkey(1, 1 - alpha)
                            };

                            Path.Color = rgbseq{
                                Path.Color.Keypoints[1],
                                rgbkey(1, color)
                            }

                            Options["Box Fill 1"] = Flags[Config.Flag .. "_BOX_FILL_1"]
                        end, Flag = Config.Flag .. "_BOX_FILL_1"})
                        
                        Elements.Options.BoxFill2 = Elements.Options.BoxFillToggle:Colorpicker({Name = "Bottom Gradient", Callback = function(color, alpha)
                            local Path = Elements.CornersGradient
                            Path.Transparency = numseq{
                                Path.Transparency.Keypoints[1],
                                numkey(1, alpha)
                            };

                            Path.Color = rgbseq{
                                Path.Color.Keypoints[1],
                                rgbkey(1, color)
                            };

                            local Path = Elements.BoxHolderGradient
                            Path.Transparency = numseq{
                                numkey(0, alpha), 
                                Path.Transparency.Keypoints[2]
                            };

                            Path.Color = rgbseq{
                                rgbkey(0, color), 
                                Path.Color.Keypoints[2]
                            }

                            Options["Box Fill 2"] = Flags[Config.Flag .. "_BOX_FILL_2"]
                        end, Flag = Config.Flag .. "_BOX_FILL_2"})

                        Elements.Options.Slider = Section:Slider({Name = "Box Fill Rotation", Min = 0, Max = 360, Decimals = 1, Default = 0, Callback = function(rotation)
                            Elements.CornersGradient.Rotation = rotation
                            Elements.BoxHolderGradient.Rotation = rotation

                            Options["Box Fill Rotation"] = rotation
                        end, Flag = Config.Flag .. "_BOX_FILL_GRADIENT_ROTATION"})  

                        for _,element in {Elements.Options.Low, Elements.Options.Medium, Elements.Options.High, Elements.Options.BoxFill1, Elements.Options.BoxFill2} do 
                            Elements.Options[#Elements.Options + 1] = element.Items.Animations
                        end 
                    -- 
                    
                    -- TextLabel
                        Elements.Text = Library:Create( "TextLabel" , {
                            FontFace = Fonts[themes.preset.font];
                            Parent = Items.ElementHolder;
                            TextColor3 = rgb(145, 145, 145);
                            TextStrokeColor3 = rgb(255, 255, 255);
                            Text = Config.Name;
                            Name = "\0";
                            AutomaticSize = Enum.AutomaticSize.XY;
                            Position = dim2(0, 1, 0, 0);
                            BorderSizePixel = 0;
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            TextSize = 12;
                            BackgroundColor3 = themes.preset.unselected
                        });	Library:Themify(Elements.Text, "unselected", "BackgroundColor3")

                        local Constraint = Library:Create( "UISizeConstraint" , {
                            MinSize = vec2(Elements.Text.TextBounds.X, Elements.Text.TextBounds.Y);
                            Parent = Elements.Text
                        });

                        Elements.Text:GetPropertyChangedSignal("TextBounds"):Connect(function()
                            Constraint.MinSize = vec2(Elements.Text.TextBounds.X, Elements.Text.TextBounds.Y);
                        end)
                    --
                end

                function Config.Set(Info) 
                    local Enabled = Info.Enabled 
                    local Position = Info.Position 

                    Elements.Text.Parent = Enabled and Library.Other or Items.ElementHolder
                    Elements.BoxHolder.Parent = Enabled and Items[Position] or Library.Other

                    Items.ViewportFrame.AutomaticSize = Enum.AutomaticSize.Y 
                    task.wait()
                    Items.ViewportFrame.AutomaticSize = Enum.AutomaticSize.None -- ultra gay fixes for robloxses stupid asf automatic size PELASE ROBLOX FIX THIS SHIT

                    Elements.BoxHolder.Size = dim2(1, 0, 0, 0)
                    task.wait()
                    Elements.BoxHolder.Size = dim2(1, -2, 1, -2) -- what the fuck

                    Cfg.VisualizedModel:SetPrimaryPartCFrame(Cfg.VisualizedModel.PrimaryPart.CFrame)

                    Options.Boxes = Enabled

                    if Enabled then 
                        Elements.Options.Type.Set(Flags[Config.Flag .. "_CORNERS_ENABLED"])
                    end 

                    Flags[Config.Flag] = {
                        Enabled = Enabled,
                        Position = Position 
                    }
                end

                function Config.Tween(bool) 
                    if Config.Tweening == true then 
                        return 
                    end 

                    Config.Tweening = true 

                    if bool then 
                        Elements.Information.Visible = true
                    end

                    local Children = Elements.Information:GetDescendants()
                    table.insert(Children, Elements.Information)

                    local Tween;
                    for _,obj in Children do
                        local Index = Library:GetTransparency(obj)

                        if not Index then 
                            continue 
                        end

                        if type(Index) == "table" then
                            for _,prop in Index do
                                Tween = Library:Fade(obj, prop, bool, Library.TweeningSpeed)
                            end
                        else
                            Tween = Library:Fade(obj, Index, bool, Library.TweeningSpeed)
                        end
                    end

                    Library:Connection(Tween.Completed, function()
                        Config.Tweening = false
                        Elements.Information.Parent = bool and Library.Items or Library.Other
                        Elements.Information.Visible = bool
                    end)
                end
                
                function Config.DetermineClosing() 
                    for _,element in Elements.Options do
                        local Holder = element.Items.DropdownElements
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end 

                        local Holder = element.Items.Colorpicker
                        if Holder then 
                            if Holder.Visible and Library:Hovering({Holder}) then 
                                return true 
                            end 
                        end     
                    end 

                    return false
                end 

                Elements.Text.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                        Elements.Text.Parent = Library.Items 

                        TextDragging = true
                    end
                end)

                Elements.Text.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36), {Items.Box, Items.ElementHolder}, {"Items.Box", "Items.ElementHolder"})
                        local isHolder = Items[Parent] == Items.ElementHolder
                        
                        Config.Set({Enabled = not isHolder, Position = Parent})
                        TextDragging = false
                    end
                end)

                for _,box in {Elements.Corners, Elements.BoxHolder} do 
                    box.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                            Elements.Text.Parent = Library.Items 
                            Elements.BoxHolder.Parent = Library.Other 
                            Elements.Corners.Parent = Library.Other 

                            BarDragging = true
                        end

                        if input.UserInputType == Enum.UserInputType.MouseButton2 then 
                            if Config.Tweening then 
                                return 
                            end 

                            Config.Open = not Config.Open 
                            Config.Tween(Config.Open)
                            Elements.Information.Position = dim_offset(input.Position.X + 5, input.Position.Y + 70)
                        end
                    end)

                    box.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local Parent = Math:FindClosestFrame(vec2(input.Position.X, input.Position.Y - 36), {Items.Box, Items.ElementHolder}, {"Items.Box", "Items.ElementHolder"})
                            local ParentIsHolder = Parent == "ElementHolder"

                            BarDragging = false
                            Config.Set({Enabled = not ParentIsHolder, Position = Parent})
                        end
                    end)
                end 

                Library:Connection(InputService.InputChanged, function(input, game_event) 
                    if (TextDragging or BarDragging) and input.UserInputType == Enum.UserInputType.MouseMovement then            
                        Library:Tween(Elements.Text, {
                            Position = dim_offset(input.Position.X, input.Position.Y + 36 + Elements.Text.AbsoluteSize.Y)
                        }, TweenInfo.new(Library.DraggingSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0))
                    end
                end)    

                Library:Connection(InputService.InputEnded, function(input, game_event) 
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and Elements.Information.Visible and not (Library:Hovering({Elements.Information}) or Config.DetermineClosing()) then 
                        Config.Tween(false)
                        Config.Open = false
                    end 
                end)

                ConfigFlags[Config.Flag] = Config.Set
                Config.Set({Enabled = Config.Enabled, Position = Config.Position})

                return setmetatable(Config, Library)
            end

            function Cfg.FlipPage()
                local OldItems = self.CurrentTab 

                if OldItems then 
                    OldItems.Holder.Visible = false
                    OldItems.Holder.Parent = Library.Other
                    Library:Tween(OldItems.Title, {TextColor3 = themes.preset.unselected})
                end 

                Items.Holder.Visible = true 
                Items.Holder.Parent = self.Items.ESPHolder
                Library:Tween(Items.Title, {TextColor3 = themes.preset.text_color})

                self.CurrentTab = Cfg.Items
            end

            -- Viewport frame
            if type(Cfg.Model) == "string" then 
                Cfg.VisualizedModel = game:GetObjects(Cfg.Model)[1]
                Cfg.VisualizedModel.Parent = Items.ViewportFrame
            elseif type(Cfg.Model) == "userdata" and Cfg.Model:IsA("Model") then 
                Cfg.Model.Archivable = true 
                Cfg.VisualizedModel = Cfg.Model:Clone()
                Cfg.VisualizedModel:ScaleTo(Cfg.Scale)
                Cfg.VisualizedModel.Parent = Items.ViewportFrame
            end

            Cfg.VisualizedModel:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, Cfg.ModelOffset, -8)))

            -- Gay
                local Dragging = false
                local MousePos = nil
                local Sensitivity = 0.01
                local Angle = CFrame.Angles(0, math.rad(-180), 0)
                local Cache = Angle 
                
                Items.ViewportFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = true
                        MousePos = input.Position
                    end
                end)

                Items.ViewportFrame.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Dragging = false
                        Cfg.VisualizedModel:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, Cfg.ModelOffset, -8)) * CFrame.Angles(0, math.rad(-180), 0))
                        Angle = CFrame.Angles(0, math.rad(-180), 0)
                    end
                end)

                InputService.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local delta = input.Position - MousePos
                        MousePos = input.Position
                        Angle *= CFrame.Angles(0, delta.X * Sensitivity, 0)
                        Cfg.VisualizedModel:SetPrimaryPartCFrame(CFrame.new(Vector3.new(0, Cfg.ModelOffset, -8)) * Angle)
                    end
                end)

                Items.Outline.MouseButton1Click:Connect(Cfg.FlipPage)

                Library:Connection(RunService.RenderStepped, function()	
                    local Pos, Size = Math:Solve(Cfg.VisualizedModel, Items.ViewportFrame, Items.Camera)
                    Items.Box.Position = Pos
                    Items.Box.Size = Size
                end)
            
                if not self.CurrentTab then 
                    Cfg.FlipPage() 
                end 
            -- 

            self.Section:Toggle({Name = Cfg.Name, Callback = function(bool)
                Options.Enabled = bool
            end, Flag = Cfg.Name .. "_GLOBAL_ENABLED"})

            self.Section:Slider({
                Name = "Max Render Distance", 
                Min = 0, 
                Max = 10000, 
                Default = 10000, 
                Decimal = 5,
                Flag = Cfg.Name .. "_RENDER_DISTANCE",
                Callback = function(int)
                    Options["Render Distance"] = int
                end 
            })

            if Cfg.Chams then 
                local Toggle = self.Section:Toggle({Name = Cfg.Name .. " Chams", Callback = function(bool)
                    Options["ChamsEnabled"] = bool
                    print("I am real", bool)
                end, Flag = Cfg.Name .. "_CHAMS"})

                Toggle:Colorpicker({Name = "Fill", Color = rgb(255, 255, 255), Transparency = 1, Callback = function(color, alpha)
                    Options["Chams Fill"] = Flags[Cfg.Name .. "_FILL_CHAMS"]
                end, Flag = Cfg.Name .. "_FILL_CHAMS"})

                Toggle:Colorpicker({Name = "Outline", Color = rgb(255, 255, 255), Transparency = 0.5, Callback = function(color, alpha)
                    Options["Chams Outline"] = Flags[Cfg.Name .. "_OUTLINE_CHAMS"]
                end, Flag = Cfg.Name .. "_OUTLINE_CHAMS"})
            end

            return setmetatable(Cfg, Library)
        end
    -- 
-- 

-- Esp  
    if getgenv().Esp then 
        getgenv().Esp.Unload()
    end 

    getgenv().Esp = { 
        Players = {}, 
        PlayersOptions = {},
        ScreenGui = Instance.new("ScreenGui", CoreGui), 
        Cache = Instance.new("ScreenGui", gethui()), 
        Connections = {}, 
    }; do 
        Esp.ScreenGui.IgnoreGuiInset = true
        Esp.ScreenGui.Name = "EspObject"

        Esp.Cache.Enabled = false   

        function Esp:Create(instance, options)
            local Ins = Instance.new(instance) 
            
            for prop, value in options do 
                Ins[prop] = value
            end
            
            return Ins 
        end

        function Esp:ConvertScreenPoint(world_position)
            local ViewportSize = Camera.ViewportSize
            local LocalPos = Camera.CFrame:pointToObjectSpace(world_position) 

            local AspectRatio = ViewportSize.X / ViewportSize.Y
            local HalfY = -LocalPos.Z * math.tan(math.rad(Camera.FieldOfView / 2))
            local HalfX = AspectRatio * HalfY
            
            local FarPlaneCorner = Vector3.new(-HalfX, HalfY, LocalPos.Z)
            local RelativePos = LocalPos - FarPlaneCorner
        
            local ScreenX = RelativePos.X / (HalfX * 2)
            local ScreenY = -RelativePos.Y / (HalfY * 2)
            
            local OnScreen = -LocalPos.Z > 0 and ScreenX >= 0 and ScreenX <= 1 and ScreenY >= 0 and ScreenY <= 1
            
            -- returns in pixels as opposed to scale
            return Vector3.new(ScreenX * ViewportSize.X, ScreenY * ViewportSize.Y, -LocalPos.Z), OnScreen
        end

        function Esp:Connection(signal, callback)
            local Connection = signal:Connect(callback)
            Esp.Connections[#Esp.Connections + 1] = Connection
            
            return Connection 
        end

        function Esp:BoxSolve(torso)
            if not torso then
                return nil, nil, nil
            end 

            local ViewportTop = torso.Position + (torso.CFrame.UpVector * 1.8) + Camera.CFrame.UpVector
            local ViewportBottom = torso.Position - (torso.CFrame.UpVector * 2.5) - Camera.CFrame.UpVector
            local Distance = (torso.Position - Camera.CFrame.p).Magnitude

            local NewDistance = math.floor(Distance * 0.333)

            local Top, TopIsRendered = Esp:ConvertScreenPoint(ViewportTop)
            local Bottom, BottomIsRendered = Esp:ConvertScreenPoint(ViewportBottom)
            
            local Width = math.max(math.floor(math.abs(Top.X - Bottom.X)), 8)
            local Height = math.max(math.floor(math.max(math.abs(Bottom.Y - Top.Y), Width / 2)), 12)
            local BoxSize = Vector2.new(math.floor(math.max(Height / 1.5, Width)), Height)
            local BoxPosition = Vector2.new(math.floor(Top.X * 0.5 + Bottom.X * 0.5 - BoxSize.X * 0.5), math.floor(math.min(Top.Y, Bottom.Y)))
            
            return BoxSize, BoxPosition, TopIsRendered, NewDistance 
        end
        
        function Esp:Lerp(start, finish, t)
            t = t or 1 / 8

            return start * (1 - t) + finish * t
        end

        function Esp:Tween(obj, props, info)
            local tween = TweenService:Create(obj, info, props)
            tween:Play()
            
            return tween
        end

        function Esp.CreateObject( player, typechar ) -- IMPORTANT! 
            local Data = { 
                Items = { }, 
                Info = {Character; Humanoid; Health = 0}; 
                Drawings = { }, 
                Type = typechar or "player",
                Handles = { }, 
            }; Data.Chams = Data.Type == "player" and true or false;

            local Items = Data.Items; do
                -- Holder
                    Items.Holder = Esp:Create( "Frame" , {
                        Parent = Esp.ScreenGui;
                        Visible = false;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0.4332570433616638, 0, 0.3255814015865326, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 211, 0, 240);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.HolderGradient = Library:Create( "UIGradient" , {
                        Rotation = 0;
                        Name = "\0";
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = Items.Holder;
                        Enabled = true
                    });

                    -- All directions have a set default parent of Items.Holder 

                    -- Directions 
                        Items.Left = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(0, 0, 1, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.HealthbarTextsLeft = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = -100;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            FillDirection = Enum.FillDirection.Horizontal;
                            HorizontalAlignment = Enum.HorizontalAlignment.Right;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Left;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.LeftTexts = Esp:Create( "Frame" , {
                            LayoutOrder = -100;
                            Parent = Items.Left;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            Parent = Items.LeftTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Bottom = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(1, 0, 0, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 1, 1);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.HealthbarTextsBottom = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = 0;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalAlignment = Enum.HorizontalAlignment.Center;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Bottom;
                            Padding = dim(0, 1)
                        });

                        Items.BottomTexts = Esp:Create( "Frame", {
                            LayoutOrder = 1;
                            Parent = Items.Bottom;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout", {
                            Parent = Items.BottomTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Top = Esp:Create( "Frame" , {
                            Parent = Items.Holder;
                            Size = dim2(1, 0, 0, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 0, 0, -1);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.HealthbarTextsTop = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = -100;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            VerticalAlignment = Enum.VerticalAlignment.Bottom;
                            SortOrder = Enum.SortOrder.LayoutOrder;
                            HorizontalAlignment = Enum.HorizontalAlignment.Center;
                            HorizontalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Top;
                            Padding = dim(0, 1)
                        });

                        Items.TopTexts = Esp:Create( "Frame", {
                            LayoutOrder = -100;
                            Parent = Items.Top;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout", {
                            Parent = Items.TopTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.Right = Esp:Create( "Frame" , {
                            Parent = Esp.Cache;
                            Size = dim2(0, 0, 1, 0);
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(1, 1, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 2;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Esp:Create( "UIListLayout" , {
                            FillDirection = Enum.FillDirection.Horizontal;
                            VerticalFlex = Enum.UIFlexAlignment.Fill;
                            Parent = Items.Right;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        Items.RightTexts = Esp:Create( "Frame" , {
                            LayoutOrder = 100;
                            Parent = Esp.Cache;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Esp:Create( "UIListLayout" , {
                            Parent = Items.RightTexts;
                            Padding = dim(0, 1);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });

                        Items.HealthbarTextsRight = Esp:Create( "Frame", {
                            Visible = true;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Esp.Cache;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            LayoutOrder = 99;
                            BorderSizePixel = 0;
                            ZIndex = 0;
                            AutomaticSize = Enum.AutomaticSize.X;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    --
                -- 

                -- Corner Boxes
                    Items.Corners = Esp:Create( "Frame", {
                        Parent = Esp.Cache; -- Items.Holder
                        Name = "\0";
                        BackgroundTransparency = 1;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.BottomLeftX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(0, 1);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.BottomLeftX
                    });

                    Items.BottomLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(0, 1);
                        Image = "rbxassetid://101715268403902";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, -2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = -90;
                        Parent = Items.BottomLeftY
                    });

                    Items.BottomRighX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(1, 1);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 1, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.BottomRighX
                    });

                    Items.BottomLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(1, 1);
                        Image = "rbxassetid://101715268403902";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 1, -2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 96))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = 90;
                        Parent = Items.BottomLeftY
                    });

                    Items.TopLeftY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Corners;
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        Image = "rbxassetid://102467475629368";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = 90;
                        Parent = Items.TopLeftY
                    });

                    Items.TopRightY = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0, 3, 0.25, 0);
                        AnchorPoint = vec2(1, 0);
                        Image = "rbxassetid://102467475629368";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 0, 2);
                        ZIndex = 500;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 0), vec2(2, 98))
                    });

                    Esp:Create( "UIGradient", {
                        Rotation = -90;
                        Parent = Items.TopRightY
                    });

                    Items.TopRightX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        Parent = Items.Corners;
                        BorderColor3 = rgb(0, 0, 0);
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Size = dim2(0.4, 0, 0, 3);
                        AnchorPoint = vec2(1, 0);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Position = dim2(1, 0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.TopRightX
                    });

                    Items.TopLeftX = Esp:Create( "ImageLabel", {
                        ScaleType = Enum.ScaleType.Slice;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Corners;
                        Name = "\0";
                        BackgroundColor3 = rgb(255, 255, 255);
                        Image = "rbxassetid://83548615999411";
                        BackgroundTransparency = 1;
                        Size = dim2(0.4, 0, 0, 3);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        SliceCenter = rect(vec2(1, 1), vec2(99, 2))
                    });

                    Esp:Create( "UIGradient", {
                        Parent = Items.TopLeftX
                    });
                -- 

                -- Normal Box 
                    Items.Box = Esp:Create( "Frame" , {
                        Parent = Esp.Cache; -- Items.Holder
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke" , {  
                        Parent = Items.Box;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Inner = Esp:Create( "Frame" , {
                        Parent = Items.Box;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.UIStroke = Esp:Create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.Inner
                    });

                    Items.BoxGradient = Esp:Create( "UIGradient" , {
                        Parent = Items.UIStroke
                    });

                    Items.Inner2 = Esp:Create( "Frame" , {
                        Parent = Items.Inner;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke" , {
                        Parent = Items.Inner2;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
                
                -- Healthbar
                    Items.Healthbar = Esp:Create( "Frame" , {
                        Name = "Left";
                        Parent = Esp.Cache;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    Items.HealthbarAccent = Esp:Create( "Frame" , {
                        Parent = Items.Healthbar;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.HealthbarFade = Esp:Create( "Frame" , {
                        Parent = Items.Healthbar;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });

                    Items.HealthbarGradient = Esp:Create( "UIGradient" , {
                        Enabled = true;
                        Parent = Items.HealthbarAccent;
                        Rotation = 90;
                        Color = rgbseq{rgbkey(0, rgb(0, 255, 0)), rgbkey(0.5, rgb(255, 125, 0)), rgbkey(1, rgb(255, 0, 0))}
                    });

                    Items.HealthbarText = Esp:Create( "TextLabel", {
                        FontFace = Fonts.ProggyClean;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache; -- Items.HealthbarTextsLeft
                        Name = "\0";
                        Visible = true; 
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.HealthbarText;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 

                -- Texts
                    Items.Text = Esp:Create( "TextLabel", {
                        FontFace = Fonts.ProggyClean;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache;
                        Name = "Left";
                        Text = player.Name;
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 9;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.Text;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Distance = Esp:Create( "TextLabel", {
                        FontFace = Fonts.ProggyClean;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Esp.Cache;
                        Name = "Left";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 9;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Esp:Create( "UIStroke", {
                        Parent = Items.Distance;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
            end       

            Data.RefreshChams = function()
                local Character = Data.Info.Character
                
                local Enabled = Flags["Players_CHAMS"]
                local FillSettings = Flags["Players_FILL_CHAMS"]
                local OutlineSettings = Flags["Players_OUTLINE_CHAMS"]

                if not Data.Highlight then 
                    Data.Highlight = Esp:Create( "Highlight", {
                        FillColor = FillSettings.Color;
                        Enabled = Flags["Players_CHAMS"];
                        OutlineTransparency = OutlineSettings.Transparency;
                        Adornee = Character;
                        FillTransparency = FillSettings.Transparency;
                        OutlineColor = OutlineSettings.Color;
                        Parent = CoreGui
                    });
                else 
                    Data.Highlight.Adornee = Character
                end     
            end   

            Data.ToolAdded = function(item)
                -- if not item:FindFirstChild("ItemRoot") then 
                --     return 
                -- end 

                -- local exists = Data.Info.Character:FindFirstChild(item.Name) 
                -- Items["weapon"].Text = "[" .. item.Name .. "]"

                -- pcall(function()
                --     Items["weapon"].Parent = exists and Items["Holder"] or Esp.Cache
                -- end)

                -- Refresh
            end

            Data.HealthChanged = function(Value)
                if not MiscOptions.Healthbar then 
                    return 
                end 

                local Humanoid = Data.Info.Humanoid
                local Multiplier = Value / 100
                local isHorizontal = MiscOptions.Healthbar_Position == "Top" or MiscOptions.Healthbar_Position == "Bottom"

                local Color = MiscOptions.Healthbar_Low.Color:Lerp(MiscOptions.Healthbar_Medium.Color, Multiplier)
                local Color_2 = Color:Lerp(MiscOptions.Healthbar_High.Color, Multiplier)

                if MiscOptions.Healthbar_Number then 
                    if Items.HealthbarText.Parent == Esp.Cache then 
                        Options.Healthbar = MiscOptions.Healthbar_Position 
                        Options.Healthbar_Number = true
                    end 
                end 

                if MiscOptions.Healthbar_Tween then  
                    local Health = Data.Info.Health
                    
                    Esp:Tween(Items.HealthbarFade, {
                        Size = dim2(isHorizontal and 1 - Multiplier or 1, isHorizontal and -2 or -2, isHorizontal and 1 or 1 - Multiplier, -2),
                        Position = dim2(isHorizontal and Multiplier or 0, 1, 0, 1)
                    }, TweenInfo.new(MiscOptions.Healthbar_Easing_Speed, Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection], 0, false, 0))
                    Esp:Tween(Items.HealthbarText, {
                        Position = dim2(isHorizontal and Multiplier or 0, isHorizontal and -(Items.HealthbarText.TextBounds.X / 2) or 0, isHorizontal and 0 or 1 - Multiplier, 0), 
                        TextColor3 = Color_2
                    }, TweenInfo.new(MiscOptions.Healthbar_Easing_Speed, Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection], 0, false, 0))

                    task.spawn(function()
                        local Start = tick()
                        
                        while true do
                            if not Esp then 
                                break 
                            end 

                            local Elapsed = tick() - Start
                            local Alpha = math.clamp(Elapsed, 0, 1)

                            local Value = Esp:Lerp(
                                Data.Info.Health, 
                                Value, 
                                TweenService:GetValue(
                                    Alpha, 
                                    Enum.EasingStyle[MiscOptions.Healthbar_EasingStyle], 
                                    Enum.EasingDirection[MiscOptions.Healthbar_EasingDirection]
                                )
                            )   

                            Items.HealthbarText.Text = math.floor(Value)

                            if Elapsed >= MiscOptions.Healthbar_Easing_Speed then 
                                Data.Info.Health = Value 
                                break
                            end

                            task.wait()
                        end                            
                    end)
                else 
                    Items.HealthbarFade.Size = dim2(isHorizontal and 1 - Multiplier or 1, isHorizontal and -2 or -2, isHorizontal and 1 or 1 - Multiplier, -2)
                    Items.HealthbarFade.Position = dim2(isHorizontal and Multiplier or 0, 1, 0, 1)
                    
                    Items.HealthbarText.Text = math.floor(Value)
                    Items.HealthbarText.Position = dim2(isHorizontal and Multiplier or 0, isHorizontal and -(Items.HealthbarText.TextBounds.X / 2) or 0, isHorizontal and 0 or 1 - Multiplier, 0)
                    Items.HealthbarText.TextColor3 = Color_2
                end 
            end

            Data.RefreshDescendants = function() 
                local Character = (typechar and player) or player.Character or player.CharacterAdded:Wait()
                local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild( "Humanoid" )
                
                Data.Info.Character = typechar and player or Character
                Data.Info.Humanoid = Humanoid
                Data.Info.RootPart = Humanoid.RootPart

                Esp:Connection(Humanoid.HealthChanged, Data.HealthChanged)
                Esp:Connection(Character.ChildAdded, Data.ToolAdded)
                Esp:Connection(Character.ChildRemoved, Data.ToolAdded)

                Data.HealthChanged(Data.Info.Humanoid.Health)

                Data.RefreshChams()
            end 

            Data.Destroy = function()
                if Items["Holder"] then 
                    Items["Holder"].Parent = nil
                    Items["Holder"]:Destroy()
                end 

                Data.Highlight:Destroy()  

                if Esp.Players[index] then 
                    Esp.Players[index] = nil
                end 
            end 

            Data.RefreshDescendants()
            Esp:Connection(Data.Info.Character.ChildAdded, Data.ToolAdded)
            Esp:Connection(player.CharacterAdded, Data.RefreshDescendants)

            -- Recaching element holders that arent neccessary <- roblox calculates math for them even if they have no objects in them or invisible ;(
            for _,ItemParentor in {Items.Left, Items.Right, Items.Top, Items.Bottom} do  
                Esp:Connection(ItemParentor.ChildAdded, function()
                    task.wait(.1)

                    if ItemParentor.Parent == nil then 
                        return 
                    end
                    
                    ItemParentor.Parent = Items.Holder
                end)    

                Esp:Connection(ItemParentor.ChildRemoved, function()
                    task.wait(.1)
                    if #ItemParentor:GetChildren() == 0 then
                        if ItemParentor.Parent == nil then 
                            return 
                        end 

                        ItemParentor.Parent = Esp.Cache
                    end 
                end)
            end     

            for _,HealthHolder in {"Right", "Left", "Top", "Bottom"} do
                local Parent = Items["HealthbarTexts" .. HealthHolder]

                Esp:Connection(Parent.ChildAdded, function()
                    task.wait(.1)

                    if Parent.Parent == nil then 
                        return 
                    end

                    Parent.Parent = Items[HealthHolder]
                end)    

                Esp:Connection(Parent.ChildRemoved, function()
                    task.wait(.1)
                    if #Parent:GetChildren() == 0 then
                        if Parent.Parent == nil then 
                            return 
                        end 

                        Parent.Parent = Esp.Cache
                    end 
                end)
            end 

            for _,TextHolder in {"Right", "Left", "Bottom", "Top"} do
                local Parent = Items[TextHolder .. "Texts"]

                Esp:Connection(Parent.ChildAdded, function()
                    task.wait(.1)

                    if Parent.Parent == nil then 
                        return 
                    end

                    Parent.Parent = Items[TextHolder]
                end)    

                Esp:Connection(Parent.ChildRemoved, function()
                    task.wait(.1)
                    if #Parent:GetChildren() == 0 then
                        if Parent.Parent == nil then 
                            return 
                        end 

                        Parent.Parent = Esp.Cache
                    end 
                end)
            end 

            Esp.Players[ player.Name ] = Data

            return Data
        end

        function Esp.Update() -- IMPORTANT! 
            if not Esp then 
                return 
            end 

            if not MiscOptions.Enabled then
                return 
            end 

            for _,Data in Esp.Players do
                if not Data.Info then
                    continue 
                end 
            
                local Character = Data.Info.Character

                if not Character then 
                    continue 
                end 

                local Humanoid = Data.Info.Humanoid 

                if not Humanoid then
                    continue 
                end 

                if not (Character or Humanoid) then 
                    continue 
                end 
                
                local Items = Data and Data.Items 

                if not Items then 
                    continue 
                end 

                local BoxSize, BoxPos, OnScreen, Distance = Esp:BoxSolve(Humanoid.RootPart)
                local Holder = Items["Holder"]
                
                if not (Holder or MiscOptions["Render Distance"]) then 
                    continue 
                end

                -- some exploits may be using ways to delete and break the box solve, prevents that
                if Distance == nil then 
                    if Holder.Visible then 
                        Holder.Visible = false 
                    end 

                    continue
                end 

                if Distance > MiscOptions["Render Distance"] and Holder.Visible then 
                    Holder.Visible = false 
                    continue 
                end 

                if Holder.Visible ~= OnScreen and not (Distance > MiscOptions["Render Distance"]) then 
                    Holder.Visible = OnScreen
                end 

                if not OnScreen then
                    continue
                end 

                local Pos = dim_offset(BoxPos.X, BoxPos.Y)
                if Pos ~= Holder.Position then 
                    Holder.Position = Pos
                end 
                
                local Size = dim2(0, BoxSize.X, 0, BoxSize.Y)
                if Size ~= Holder.Size then 
                    Holder.Size = Size
                end 

                local DistanceLabel = Items.Distance
                local Text = tostring( math.round(Distance) )  .. "m"
                if DistanceLabel.Text ~= Text then 
                    DistanceLabel.Text = Text
                end 
                
                -- if Options["Box Fill"] and Options["Box Spin"] then 
                --     Items["Holder_gradient"].Rotation += Options["Box Spin Speed"] / 100
                -- end

                -- if Options["Box Gradient"] and Options["Box Gradient Spin"] then 
                --     Items["box_outline_gradient"].Rotation += Options["Box Gradient Spin Speed"] / 100
                -- end
            end
        end 
        
        function Esp.RefreshElements(key, value) -- IMPORTANT!                  
            for _,Data in Esp.Players do
                local Items = Data and Data.Items 

                -- These checks are so annoying
                if not Items then 
                    continue  
                end 

                if not Items.Holder then 
                    continue 
                end 

                if Items.Holder.Parent == nil then 
                    continue 
                end 

                if key == "Enabled" then
                    Items.Holder.Visible = value
                end 

                -- Boxes
                    if key == "BoxType" then
                        if not (Items.Box.Parent == Items.Holder or Items.Corners.Parent == Items.Holder) then 
                            continue
                        end 

                        local isCorner = value == "Corner"
                        Items.Box.Parent = isCorner and Esp.Cache or Items.Holder
                        Items.Corners.Parent = isCorner and Items.Holder or Esp.Cache
                    end 

                    if key == "Boxes" then 
                        local isCorner = Items.Corners.Parent == Items.Holder and true or false
                        local Enabled = value and Items.Holder or Esp.Cache

                        if isCorner then 
                            Items.Corners.Parent = Enabled
                        else 
                            Items.Box.Parent = Enabled
                        end
                    end 

                    if key == "Box Gradient 1" then 
                        local Color = rgbseq{
                            Items.BoxGradient.Color.Keypoints[1], 
                            rgbkey(1, value.Color)
                        }

                        for _,corner in Items.Corners:GetChildren() do 
                            corner:FindFirstChildOfClass("UIGradient").Color = Color
                        end     

                        Items.BoxGradient.Color = Color
                    end 

                    if key == "Box Gradient 2" then 
                        local Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Items.BoxGradient.Color.Keypoints[2]
                        }
                        
                        for _,corner in Items.Corners:GetChildren() do 
                            corner:FindFirstChildOfClass("UIGradient").Color = Color
                        end

                        Items.BoxGradient.Color = Color
                    end 

                    if key == "Box Gradient Rotation" then 
                        Items.BoxGradient.Rotation = 180 - value

                        for _,corner in Items.Corners:GetChildren() do 
                            corner:FindFirstChildOfClass("UIGradient").Rotation = 180 - value
                        end
                    end 

                    if key == "Box Fill" then 
                        Items.Holder.BackgroundTransparency = value and 0 or 1
                    end

                    if key == "Box Fill 1" then 
                        local Path = Items.HolderGradient
                        Path.Transparency = numseq{
                            numkey(0, 1 - value.Transparency), 
                            Path.Transparency.Keypoints[2]
                        };

                        Path.Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Path.Color.Keypoints[2]
                        }
                    end 

                    if key == "Box Fill 2" then 
                        local Path = Items.HolderGradient
                        Path.Transparency = numseq{
                            Path.Transparency.Keypoints[1],
                            numkey(1, 1 - value.Transparency)
                        };

                        Path.Color = rgbseq{
                            Path.Color.Keypoints[1],
                            rgbkey(1, value.Color)
                        };
                    end 

                    if key == "Box Fill Rotation" then 
                        Items.HolderGradient.Rotation = value
                    end 
                -- 

                -- Bars 
                    if key == "Healthbar" then 
                        if Items.Healthbar.Parent == nil then 
                            continue
                        end 

                        Items.Healthbar.Parent = value and Items[Items.Healthbar.Name] or Esp.Cache  
                        Items.HealthbarText.Parent = (Items.HealthbarText.Parent ~= Esp.Cache and value) and Items["HealthbarTexts" .. Items.Healthbar.Name] or Esp.Cache  
                    end 

                    if key == "Healthbar_Position" then 
                        local isEnabled = not (Items.Healthbar.Parent == Esp.Cache)

                        if Items.Healthbar.Parent == nil then 
                            return 
                        end 
                        
                        Items.Healthbar.Parent = isEnabled and Items[value] or Esp.Cache
                        Items.Healthbar.Name = value -- This is super gay
                        Items.HealthbarText.Parent = isEnabled and value and Items.HealthbarText.Parent ~= Esp.Cache and Items["HealthbarTexts" .. Items.Healthbar.Name] or Esp.Cache

                        if value == "Bottom" or value == "Top" then 
                            Items.HealthbarGradient.Rotation = -180
                        else 
                            Items.HealthbarGradient.Rotation = 90
                        end 

                        Data.HealthChanged(Data.Info.Humanoid.Health)
                    end 
                    
                    if key == "Healthbar_Number" then  
                        if Items.Healthbar.Parent == Esp.Cache then 
                            continue
                        end 

                        local Parent = Items["HealthbarTexts" .. Items.Healthbar.Name]
                        
                        Items.HealthbarText.Parent = value and Parent or Esp.Cache
                    end

                    if key == "Healthbar_Low" then 
                        local Color = rgbseq{
                            Items.HealthbarGradient.Color.Keypoints[1], 
                            Items.HealthbarGradient.Color.Keypoints[2], 
                            rgbkey(1, value.Color)
                        }

                        Items.HealthbarGradient.Color = Color
                    end 

                    if key == "Healthbar_Medium" then 
                        local Color = rgbseq{
                            Items.HealthbarGradient.Color.Keypoints[1], 
                            rgbkey(0.5, value.Color), 
                            Items.HealthbarGradient.Color.Keypoints[3]
                        }

                        Items.HealthbarGradient.Color = Color
                    end

                    if key == "Healthbar_High" then 
                        local Color = rgbseq{
                            rgbkey(0, value.Color), 
                            Items.HealthbarGradient.Color.Keypoints[2], 
                            Items.HealthbarGradient.Color.Keypoints[3]
                        }

                        Items.HealthbarGradient.Color = Color
                    end

                    if key == "Healthbar_Thickness" then 
                        local Bar = Items.Healthbar
                        local isHorizontal = Bar.Parent == Items.Bottom or Bar.Parent == Items.Top

                        Bar.Size = dim2(0, value + 2, 0, value + 2)
                    end

                    if key == "Healthbar_Text_Size" then 
                        Items.HealthbarText.TextSize = value
                    end

                    if key == "Healthbar_Font" then 
                        Items.HealthbarText.FontFace = Fonts[value]
                    end
                -- 
                
                -- Texts
                    local Text;
                    local Match;
                    if string.match(key, "Name") then 
                        Text = Items.Text
                        Match = "Name"
                    elseif string.match(key, "Distance") then 
                        Text = Items.Distance
                        Match = "Distance"
                    end 

                    if Text then 
                        if key == Match .. "_Text" then  
                            if Text.Parent == nil then 
                                continue
                            end

                            Text.Parent = value and Items[Text.Name .. "Texts"] or Esp.Cache
                        end 

                        if key == Match .. "_Text_Position" then 
                            local isEnabled = not (Text.Parent == Esp.Cache)

                            if Text.Parent == nil then 
                                return 
                            end 

                            Text.Parent = isEnabled and Items[value .. "Texts"] or Esp.Cache
                            Text.Name = tostring(value) -- This is super gay

                            if value == "Top" or value == "Bottom" then 
                                Text.AutomaticSize = Enum.AutomaticSize.Y 
                                Text.TextXAlignment = Enum.TextXAlignment.Center
                            else 
                                Text.AutomaticSize = Enum.AutomaticSize.XY 
                                Text.TextXAlignment = Enum.TextXAlignment[value == "Right" and "Left" or "Right"]
                            end     
                        end 

                        if key == Match .. "_Text_Color" then 
                            Text.TextColor3 = value.Color
                        end 

                        if key == Match .. "_Text_Font" then 
                            Text.FontFace = Fonts[value]
                        end 

                        if key == Match .. "_Text_Size" then 
                            Text.TextSize = value
                        end
                    end 
                -- 

                -- Chams
                    if key == "ChamsEnabled" then 
                        Data.Highlight.Enabled = value
                    end 

                    if key == "Chams Fill" then 
                        Data.Highlight.FillColor = value.Color 
                        Data.Highlight.FillTransparency = 1 - value.Transparency
                    end 

                    if key == "Chams Outline" then 
                        Data.Highlight.OutlineColor = value.Color 
                        Data.Highlight.OutlineTransparency = 1 - value.Transparency
                    end 
                --
            end 
        end 
        
        function Esp.Unload() 
            for _,player in Players:GetPlayers() do 
                Esp.RemovePlayer(player)
            end

            for _,connection in Esp.Connections do 
                connection:Disconnect() 
                connection = nil
            end 
            
            if Esp.Loop then 
                RunService:UnbindFromRenderStep("Run Loop")
                Esp.Loop = nil
            end 

            Esp.Cache:Destroy() 
            Esp.ScreenGui:Destroy()

            getgenv().Esp = nil
            Esp = nil 
        end 

        function Esp.RemovePlayer(player)
            local Path = Esp.Players[player.Name]
            
            if Path then
                Path.Destroy()
            end
        end
    end

    Esp.Loop = RunService:BindToRenderStep("Run Loop", 400, Esp.Update)
-- 

return Library, Esp, MiscOptions, Options 
