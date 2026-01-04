--[[

    XEZIOS
    -> Made by @finobe 
    -> Kind of got bored idk what to do with life
]]

if getgenv().Loaded then 
    getgenv().Library:Unload()
end 

getgenv().Loaded = true 

-- Variables 
    -- Services
    local InputService, HttpService, GuiService, RunService, Stats, CoreGui, TweenService, SoundService, Workspace, Players = game:GetService("UserInputService"), game:GetService("HttpService"), game:GetService("GuiService"), game:GetService("RunService"), game:GetService("Stats"), game:GetService("CoreGui"), game:GetService("TweenService"), game:GetService("SoundService"), game:GetService("Workspace"), game:GetService("Players")
    local Camera, lp, gui_offset = Workspace.CurrentCamera, Players.LocalPlayer, GuiService:GetGuiInset().Y
    local mouse = lp:GetMouse()

    -- Data types
    local vec2, vec3, dim2, dim, rect, dim_offset = Vector2.new, Vector3.new, UDim2.new, UDim.new, Rect.new, UDim2.fromOffset

    -- Extra data types
    local color, rgb, hex, hsv, rgbseq, rgbkey, numseq, numkey = Color3.new, Color3.fromRGB, Color3.fromHex, Color3.fromHSV, ColorSequence.new, ColorSequenceKeypoint.new, NumberSequence.new, NumberSequenceKeypoint.new
-- 

-- Library init
    getgenv().Library = {
        Directory = "xezios",
        Folders = {
            "/fonts",
            "/configs",
        },
        Flags = {},
        ConfigFlags = {},
        Connections = {},   
        Notifications = {Notifs = {}},
        OpenElement = {}; -- type: table or userdata
    }

    local themes = {
        preset = {
            accent = rgb(108, 109, 152),
            window_outline = rgb(0, 0, 0),
            inline = rgb(25, 27, 27),
            background = rgb(17, 19, 19),
            visible_backgrounds = rgb(20, 23, 22),
            text_color = rgb(221, 223, 222),
            glow = rgb(0, 0, 0),
            deselected = rgb(89, 91, 91),
        },
        utility = {},
        gradients = {
            Selected = {};
            Deselected = {};
        },
    }

    for theme,color in themes.preset do 
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
            local tween = TweenService:Create(Object, Info or TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), Properties)
            tween:Play()
            
            return tween
        end

        function Library:Fade(obj, prop, vis, speed)
            if not (obj and prop) then
                return
            end

            local OldTransparency = obj[prop]
            obj[prop] = vis and 1 or OldTransparency

            local Tween = Library:Tween(obj, { [prop] = vis and OldTransparency or 1 }, TweenInfo.new(speed or 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0))

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
                    Parent.Size = dim2(
                        Size.X.Scale,
                        math.clamp(Size.X.Offset + (input.Position.X - InputLost.X), ParentSize.X.Offset, Camera.ViewportSize.X), 
                        Size.Y.Scale, 
                        math.clamp(Size.Y.Offset + (input.Position.Y - InputLost.Y), ParentSize.Y.Offset, Camera.ViewportSize.Y)
                    )
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
                local y_cond = Object.AbsolutePosition.Y <= mouse.Y and mouse.Y <= Object.AbsolutePosition.Y + Object.AbsoluteSize.Y
                local x_cond = Object.AbsolutePosition.X <= mouse.X and mouse.X <= Object.AbsolutePosition.X + Object.AbsoluteSize.X
    
                return (y_cond and x_cond)
            end 
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

                    Parent.Position = NewPosition
                end
            end)
        end 

        function Library:Convert(str)
            local Values = {}

            for Value in string.gmatch(str, "[^,]+") do
                table.insert(Values, tonumber(Value))
            end

            if #Values == 4 then              
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
            
            for part in string.gmatch(enum, "[%w_]+") do
                insert(EnumParts, part)
            end
        
            local EnumTable = Enum

            for i = 2, #EnumParts do
                local EnumItem = EnumTable[EnumParts[i]]
        
                EnumTable = EnumItem
            end
            
            return EnumTable
        end

        function Library:ConvertHex(color, alpha)
            local r = math.floor(color.R * 255)
            local g = math.floor(color.G * 255)
            local b = math.floor(color.B * 255)
            local a = alpha and math.floor(alpha * 255) or 255
            return string.format("#%02X%02X%02X%02X", r, g, b, a)
        end

        function Library:ConvertFromHex(color)
            color = color:gsub("#", "")
            local r = tonumber(color:sub(1, 2), 16) / 255
            local g = tonumber(color:sub(3, 4), 16) / 255
            local b = tonumber(color:sub(5, 6), 16) / 255
            local a = tonumber(color:sub(7, 8), 16) and tonumber(color:sub(7, 8), 16) / 255 or 1
            return Color3.new(r, g, b), a
        end

        local ConfigHolder;
        function Library:UpdateConfigList() 
            if not ConfigHolder then 
                print("no exist :(")
                return 
            end
            
            local List = {}
            
            for _,file in listfiles(Library.Directory .. "/configs") do
                local Name = file:gsub(Library.Directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(Library.Directory .. "\\configs\\", "")
                List[#List + 1] = Name
            end

            for _,v in List do 
                print(_,v)
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
                Items = {};
            }

            local DraggingSat = false 
            local DraggingHue = false 
            local DraggingAlpha = false 

            local h, s, v = Cfg.Color:ToHSV() 
            local a = Cfg.Alpha 

            Flags[Cfg.Flag] = {Color = Cfg.Color, Transparency = Cfg.Alpha}

            local Items = Cfg.Items; do 
                -- Component
                    Items.Button = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        Name = "\0";
                        LayoutOrder = -1;
                        Parent = self.Items.Components;
                        Size = dim2(0, 28, 0, 14);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(26, 28, 28)
                    });
                    
                    Items.ButtonColor = Library:Create( "Frame" , {
                        Parent = Items.Button;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(119, 180, 91)
                    });
                    
                    Library:Create( "UICorner" , {
                        Parent = Items.ButtonColor;
                        CornerRadius = dim(0, 4)
                    });
                    
                    Library:Create( "UICorner" , {
                        Parent = Items.Button;
                        CornerRadius = dim(0, 4)
                    });
                --
                
                -- Colorpicker
                    Items.Window = Library:Create( "TextButton" , {
                        Parent = Library.Other;
                        Text = "";
                        AutoButtonColor = false;
                        Active = false;
                        Name = "\0";
                        Position = dim2(0, 100, 0, 10);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 230, 0, 200);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Window, "inline", "BackgroundColor3")

                    Items.Fade = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        BackgroundTransparency = 1;
                        ZIndex = 500;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Window, "inline", "BackgroundColor3")

                    Library:Create( "UICorner" , {
                        Parent = Items.Window
                    });                    

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.visible_backgrounds
                    });	Library:Themify(Items.Inline, "visible_backgrounds", "BackgroundColor3")
                    
                    Library:Create( "UICorner" , {
                        Parent = Items.Inline
                    });                    

                    Items.Fill = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 26);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Fill, "inline", "BackgroundColor3")
                    
                    Items.Pallete = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -4, 1, -3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(40, 40, 40)
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Pallete;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -38, 1, -43);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Inner = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 221, 255)
                    });
                    
                    Items.Val = Library:Create( "TextButton" , {
                        Name = "\0";
                        Text = "";
                        AutoButtonColor = false;
                        Parent = Items.Inner;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIGradient" , {
                        Parent = Items.Val;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    Items.SatValPicker = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Inner;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.inline = Library:Create( "Frame" , {
                        Parent = Items.SatValPicker;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Saturation = Library:Create( "Frame" , {
                        Parent = Items.Inner;
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
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
                    
                    Items.HexTextbox = Library:Create( "Frame" , {
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.Pallete;
                        Name = "\0";
                        Position = dim2(0, 1, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -39, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.HexTextbox;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.Background, "background", "BackgroundColor3")
                    
                    Items.AlphaInput = Library:Create( "TextBox" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                        Parent = Items.Background;
                        TextColor3 = rgb(239, 239, 239);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "255, 255, 255, 0.5";
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        Active = false;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.HueTextbox = Library:Create( "Frame" , {
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.Pallete;
                        Name = "\0";
                        Position = dim2(0, 1, 1, -22);
                        BorderColor3 = rgb(0, 0, 0);
                        ClearTextOnFocus = false;
                        Size = dim2(1, -39, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.HueTextbox;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.Background, "background", "BackgroundColor3")
                    
                    Items.RGBInput = Library:Create( "TextBox" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                        Parent = Items.Background;
                        TextColor3 = rgb(239, 239, 239);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "255, 255, 255, 0.5";
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Selectable = false;
                        ClearTextOnFocus = false;
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Active = false;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Alpha = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 1);
                        Parent = Items.Pallete;
                        Name = "\0";
                        Position = dim2(1, 2, 1, 0);
                        Size = dim2(0, 16, 1, 0);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Alpha;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Inline;
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
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(9, 9, 9))}
                    });
                    
                    Items.AlphaPicker = Library:Create( "Frame" , {
                        Parent = Items.Background;
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 2, 0, 3);
                        Position = dim2(0, -1, 0, -1);
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.RGB = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 1);
                        Parent = Items.Pallete;
                        Name = "\0";
                        Position = dim2(1, -18, 1, 0);
                        Size = dim2(0, 16, 1, 0);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.RGB;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.hue_drag = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.hue_drag;
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))}
                    });
                    
                    Items.HuePicker = Library:Create( "Frame" , {
                        Parent = Items.hue_drag;
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 2, 0, 3);
                        Position = dim2(0, -1, 0, -1);
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 2);
                        PaddingBottom = dim(0, 3);
                        Parent = Items.Pallete;
                        PaddingRight = dim(0, 3);
                        PaddingLeft = dim(0, 2)
                    });
                -- 
            end;
            
            function Cfg.SetVisible(bool)
                Items.Fade.BackgroundTransparency = 0 
                Library:Tween(Items.Fade, {BackgroundTransparency = 1})

                Items.Window.Visible = bool
                Items.Window.Parent = bool and Library.Items or Library.Other
                Items.Window.Position = dim2(0, Items.Button.AbsolutePosition.X + 2, 0, Items.Button.AbsolutePosition.Y + 74)
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
                
                local Color = hsv(h, s, v)

                Items.SatValPicker.Position = dim2(s, 0, 1 - v, 0)
                Items.AlphaPicker.Position = dim2(0, -1, a, -1)
                Items.HuePicker.Position = dim2(0, -1, h, -1)
                
                Items.ButtonColor.BackgroundColor3 = hsv(h,s,v)
                Items.Inner.BackgroundColor3 = hsv(h,1,1)

                Flags[Cfg.Flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local Color = Items.ButtonColor.BackgroundColor3 -- Overwriting to format<<
                Items.RGBInput.Text = string.format("%s, %s, %s, ", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255))
                Items.RGBInput.Text ..= Library:Round(1 - a, 0.01)
                
                Items.AlphaInput.Text = Library:ConvertHex(Color, 1 - a)

                Cfg.Callback(Color, a)
            end

            function Cfg.UpdateColor() 
                local Mouse = InputService:GetMouseLocation()
                local offset = vec2(Mouse.X, Mouse.Y - gui_offset) 
                
                if DraggingSat then	
                    s = math.clamp((offset - Items.Val.AbsolutePosition).X / Items.Val.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - Items.Val.AbsolutePosition).Y / Items.Val.AbsoluteSize.Y, 0, 1)
                elseif DraggingHue then
                    h = math.clamp((offset - Items.RGB.AbsolutePosition).Y / Items.RGB.AbsoluteSize.Y, 0, 1)
                elseif DraggingAlpha then
                    a = math.clamp((offset - Items.Alpha.AbsolutePosition).Y / Items.Alpha.AbsoluteSize.Y, 0, 1)
                end

                Cfg.Set()
            end

            Items.Button.MouseButton1Click:Connect(function()
                Cfg.Open = not Cfg.Open
                Cfg.SetVisible(Cfg.Open)            
            end)

            InputService.InputChanged:Connect(function(input)
                if (DraggingSat or DraggingHue or DraggingAlpha) and input.UserInputType == Enum.UserInputType.MouseMovement then
                    Cfg.UpdateColor() 
                end
            end)

            Library:Connection(InputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    DraggingSat = false
                    DraggingHue = false
                    DraggingAlpha = false

                    if not Library:Hovering({Items.Button, Items.Window}) then
                        Cfg.SetVisible(false)
                        Cfg.Open = false
                    end 
                end
            end)    

            Library:Connection(InputService.InputBegan, function(input, game_event)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Library:Hovering({Items.Button, Items.Window}) then
                        Cfg.SetVisible(false)
                        Cfg.Open = false
                    end 
                end 
            end)

            Items.Alpha.MouseButton1Down:Connect(function()
                DraggingAlpha = true 
            end)
            
            Items.RGB.MouseButton1Down:Connect(function()
                DraggingHue = true 
            end)
            
            Items.Val.MouseButton1Down:Connect(function()
                DraggingSat = true  
            end)

            Items.RGBInput.FocusLost:Connect(function()
                local text = Items.RGBInput.Text
                local r, g, b, a = Library:Convert(text)
                
                if r and g and b and a then 
                    Cfg.Set(rgb(r, g, b), 1 - a)
                end 
            end)

            Items.AlphaInput.FocusLost:Connect(function()
                local Color, Alpha = Library:ConvertFromHex(Items.AlphaInput.Text)
                Cfg.Set(Color, 1 - Alpha)
            end)

            Cfg.Set(Cfg.Color, Cfg.Alpha)
            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 

        function Library:GetConfig()
            local Config = {}
            
            for Idx, Value in Flags do
                if type(Value) == "table" and Value.key then
                    Config[Idx] = {active = Value.Active, mode = Value.Mode, key = tostring(Value.Key)}
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
                if Idx == "config_name_list" then 
                    continue 
                end

                local Function = ConfigFlags[Idx]

                if Function then 
                    if type(Value) == "table" and Value["Transparency"] and Value["Color"] then
                        Function(hex(Value["Color"]), Value["Transparency"])
                    elseif type(Value) == "table" and Value["Active"] then 
                        Function(Value)
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

        function Library:SaveGradient(instance, theme) -- instance, tabfill or background, color
            table.insert(themes.gradients[theme], instance)
        end

        --[[
            gradients = {
            Selected = {};
            Deselected = {};
        },
        gradient_preset = {
            Selected = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)};
            Deselected = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)};
        },
        ]]

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
            if not (Library.OpenElement and Library.OpenElement.SetVisible) then 
                return 
            end 

            Library.OpenElement.SetVisible(false)
            Library.OpenElement.Open = false
		end

        function Library:Create(instance, options)
            local ins = Instance.new(instance) 

            for prop, value in options do
                ins[prop] = value
            end

            if ins == "TextButton" then 
                ins["AutoButtonColor"] = false 
                ins["Text"] = ""
            end 
            
            return ins 
        end

        function Library:Unload() 
            if Library.Items then 
                Library.Items:Destroy()
            end

            if Library.Other then 
                Library.Other:Destroy()
            end
            
            for _,connection in Library.Connections do 
                connection:Disconnect() 
                connection = nil 
            end

            getgenv().Library = nil 
        end
    --
    
    -- Library element functions
        function Library:Window(properties)
            local Cfg = {
                Prefix = properties.Prefix or "XEZIOS";
                Suffix = properties.Suffix or "PRIME";
                Size = properties.Size or dim2(0, 620, 0, 471);
                TabInfo;
                Items = {};
            }
            
            Library.Items = Library:Create( "ScreenGui" , {
                Parent = CoreGui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            });
            
            Library.Other = Library:Create( "ScreenGui" , {
                Parent = CoreGui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            local Items = Cfg.Items; do
                Items.Window = Library:Create( "Frame" , {
                    Parent = Library.Items;
                    Name = "\0";
                    Position = dim2(0.5, -Cfg.Size.X.Offset / 2, 0.5, -Cfg.Size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = Cfg.Size;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                }); Items.Window.Position = dim2(0, Items.Window.AbsolutePosition.X, 0, Items.Window.AbsolutePosition.Y); Library:Themify(Items.Window, "window_outline", "BackgroundColor3");
                
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Window;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    ZIndex = 2;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(0, 0, 0)
                }); Library:Themify(Items.Outline, "window_outline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                
                Items.TabHolderFrame = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 139, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(12, 14, 14)
                });
                
                Items.Filler = Library:Create( "Frame" , {
                    Parent = Items.TabHolderFrame;
                    Name = "\0";
                    Position = dim2(1, -1, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Filler, "inline", "BackgroundColor3")
                
                Items.TabHolder = Library:Create( "Frame" , {
                    Parent = Items.TabHolderFrame;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.TabHolder;
                    Padding = dim(0, 6);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Library:Create( "UIPadding" , {
                    Parent = Items.TabHolder;
                    PaddingTop = dim(0, 6)
                });
                
                Items.PageHolder = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 140, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -141, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.background
                });	Library:Themify(Items.PageHolder, "background", "BackgroundColor3")
                
                Items.TitleHolder = Library:Create( "Frame" , {
                    Parent = Items.PageHolder;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 43);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	
                
                Items.Filler = Library:Create( "Frame" , {
                    Parent = Items.TitleHolder;
                    Name = "\0";
                    Position = dim2(0, 0, 1, -1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Filler, "inline", "BackgroundColor3")
                
                Items.SectionTitle = Library:Create( "TextLabel" , {
                    RichText = true;
                    Parent = Items.TitleHolder;
                    TextColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = '<font color = "rgb(255,255,255)">' .. Cfg.Prefix .. '</font> ' .. Cfg.Suffix .. '';
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    AnchorPoint = vec2(0, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0.5, 0);
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
                    ZIndex = 2;
                    TextSize = 20;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Library:Themify(Items.SectionTitle, "accent", "TextColor3")
                
                Library:Create( "UIPadding" , {
                    Parent = Items.SectionTitle;
                    PaddingRight = dim(0, 8);
                    PaddingLeft = dim(0, 13)
                });
                
                Items.Pages = Library:Create( "Frame" , {
                    Parent = Items.PageHolder;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 43);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -43);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	

                Items.Fade = Library:Create( "Frame" , {
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Parent = Items.Pages;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(17, 19, 19);
                    ZIndex = 2;
                });	Library:Themify(Items.Fade, "background", "BackgroundColor3")                
                
                Items.Glow = Library:Create( "ImageLabel" , {
                    ImageColor3 = rgb(0, 0, 0);
                    ScaleType = Enum.ScaleType.Slice;
                    ImageTransparency = 0.6499999761581421;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Window;
                    Name = "\0";
                    Size = dim2(1, 40, 1, 40);
                    Image = "rbxassetid://18245826428";
                    BackgroundTransparency = 1;
                    Position = dim2(0, -20, 0, -20);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderSizePixel = 0;
                    SliceCenter = rect(vec2(21, 21), vec2(79, 79))
                });	Library:Themify(Items.Glow, "glow", "ImageColor3")                
            end

            do -- Other
                Library:Draggify(Items.Window)
                Library:Resizify(Items.Window)
            end

            function Cfg.ToggleMenu(bool) 
                if Cfg.Tweening then 
                    return 
                end 

                Cfg.Tweening = true 

                Items.Window.Visible = true

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
                    task.wait()
                    Cfg.Tweening = false
                    Items.Window.Visible = bool
                end)
            end 

            function Cfg.ChangeMenuTitle(text)
                Items.UITitle.Text = text
            end

            function Cfg.ToggleKeybindList(bool)
                Items.Keybind_List.Visible = bool
            end
            
            return setmetatable(Cfg, Library)
        end 

        function Library:Tab(properties)
            local Cfg = {
                Name = properties.name or properties.Name or "visuals"; 
                Icon = properties.Icon or properties.icon or "rbxassetid://112730572155522";
                Items = {};
            }

            local Items = Cfg.Items; do 
                -- Tab buttons 
                    Items.Button = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        Parent = self.Items.TabHolder;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 30);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Holder = Library:Create( "Frame" , {
                        Parent = Items.Button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 6, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -13, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.visible_backgrounds
                    });	Library:Themify(Items.Holder, "visible_backgrounds", "BackgroundColor3")
                    
                    Items.Icon = Library:Create( "ImageLabel" , {
                        ImageColor3 = themes.preset.deselected;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Holder;
                        Name = "\0";
                        AnchorPoint = vec2(0, 0.5);
                        Image = Cfg.Icon;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 8, 0.5, 0);
                        Size = dim2(0, 14, 0, 14);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.Icon, "deselected", "ImageColor3"); Library:Themify(Items.Icon, "accent", "ImageColor3")
                    
                    Items.SectionTitle = Library:Create( "TextLabel" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
                        TextColor3 = themes.preset.deselected;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Parent = Items.Holder;
                        Name = "\0";
                        AnchorPoint = vec2(0, 0.5);
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 22, 0.5, 0);
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 14;
                        BackgroundColor3 = rgb(12, 14, 14)
                    });	Library:Themify(Items.SectionTitle, "text_color", "TextColor3") Library:Themify(Items.SectionTitle, "deselected", "TextColor3") 
                    Items.SectionTitle.TextColor3 = themes.preset.deselected;
                    Library:Create( "UIPadding" , {
                        Parent = Items.SectionTitle;
                        PaddingRight = dim(0, 8);
                        PaddingLeft = dim(0, 8)
                    });
                    
                    Items.Indicator = Library:Create( "ImageLabel" , {
                        ImageColor3 = themes.preset.accent;
                        ImageTransparency = 1;
                        BackgroundTransparency = 1;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Button;
                        AnchorPoint = vec2(0, 0.5);
                        Image = "rbxassetid://126397903791071";
                        Name = "\0";
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 2, 0, 19);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.Indicator, "accent", "ImageColor3")                
                -- 

                -- Page directory 
                    Items.Pages = Library:Create( "Frame" , {
                        Parent = Library.Other; -- self.Items.Pages;
                        Visible = false;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Pages;
                        Padding = dim(0, 6);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 6);
                        PaddingBottom = dim(0, 6);
                        Parent = Items.Pages;
                        PaddingRight = dim(0, 6);
                        PaddingLeft = dim(0, 6)
                    });
                    
                    Items.Left = Library:Create( "ScrollingFrame" , {
                        ScrollBarImageColor3 = rgb(0, 0, 0);
                        Active = true;
                        AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        ScrollBarThickness = 0;
                        Parent = Items.Pages;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(0, 100, 0, 100);
                        BackgroundColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        CanvasSize = dim2(0, 0, 0, 0)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Left;
                        Padding = dim(0, 6);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    });
                    
                    Items.Right = Library:Create( "ScrollingFrame" , {
                        ScrollBarImageColor3 = rgb(0, 0, 0);
                        Active = true;
                        AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        ScrollBarThickness = 0;
                        Parent = Items.Pages;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(0, 100, 0, 100);
                        BackgroundColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        CanvasSize = dim2(0, 0, 0, 0)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Right;
                        Padding = dim(0, 6);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill
                    });                
                -- 
            end 

            function Cfg.OpenTab() 
                local Tab = self.TabInfo
                
                if Tab then
                    Library:Tween(Tab.Indicator, {ImageTransparency = 1})
                    Library:Tween(Tab.Holder, {BackgroundTransparency = 1})
                    Library:Tween(Tab.Icon, {ImageColor3 = themes.preset.deselected})
                    Library:Tween(Tab.SectionTitle, {TextColor3 = themes.preset.deselected})

                    Tab.Pages.Visible = false
                    Tab.Pages.Parent = Library.Other
                end

                    self.Items.Fade.BackgroundTransparency = 0 
                    Library:Tween(self.Items.Fade, {BackgroundTransparency = 1})

                Library:Tween(Items.Indicator, {ImageTransparency = 0})
                Library:Tween(Items.Holder, {BackgroundTransparency = 0})
                Library:Tween(Items.Icon, {ImageColor3 = themes.preset.accent})
                Library:Tween(Items.SectionTitle, {TextColor3 = themes.preset.text_color})

                Items.Pages.Parent = self.Items.Pages;
                Items.Pages.Visible = true
                
                self.TabInfo = Cfg.Items
            end

            Items.Button.MouseButton1Down:Connect(function()
                Cfg.OpenTab()
            end)

            if not self.TabInfo then
                Cfg.OpenTab()
            end

            return setmetatable(Cfg, Library)
        end

        function Library:Section(properties)
            local Cfg = {
                Name = properties.name or properties.Name or "Section"; 
                Side = properties.side or properties.Side or "Left";

                -- Fill settings 
                -- Size = properties.size or properties.Size or nil;
                
                -- Other
                Items = {};
            };
            
            local Items = Cfg.Items; do
                Items.Section = Library:Create( "Frame" , {
                    Parent = self.Items[ Cfg.Side ];
                    Name = "\0";
                    Size = dim2(0, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Section, "inline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Size = dim2(1, -2, 1, -2);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.visible_backgrounds
                });	Library:Themify(Items.Inline, "visible_backgrounds", "BackgroundColor3")
                
                Items.SectionTitle = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Inline;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 6);
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIPadding" , {
                    Parent = Items.SectionTitle;
                    PaddingRight = dim(0, 8);
                    PaddingLeft = dim(0, 6)
                });
                
                Items.Fill = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 26);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Fill, "inline", "BackgroundColor3")
                
                Items.Elements = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Inline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 7, 0, 36);
                    Size = dim2(1, -14, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = Items.Elements
                });
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 2);
                    Parent = Items.Section
                });                
            end;

            return setmetatable(Cfg, Library)
        end  

        function Library:Toggle(properties) 
            local Cfg = {
                Name = properties.Name or "Toggle";
                Flag = properties.Flag or properties.Name or "Toggle";
                Enabled = properties.Default or false;
                Callback = properties.callback or function() end;

                -- Sub / Group Section
                Folding = properties.Folding or false;
                Collapsable = properties.Collapsing or true;

                Items = {};
            }

            local Items = Cfg.Items; do 
                Items.Toggle = Library:Create( "TextButton" , {
                    Active = false;
                    TextTransparency = 1;
                    Text = "";
                    Parent = self.Items.Elements;
                    AutoButtonColor = false;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    Selectable = false;
                    BorderSizePixel = 0;
                    BorderColor3 = rgb(0, 0, 0);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Toggle;
                    Name = "\0";
                    RichText = true;
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")
                
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
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Items.ToggleComponent = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Components;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 29, 0, 14);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(26, 28, 28)
                });
                
                Library:Create( "UICorner" , {
                    Parent = Items.ToggleComponent
                });
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.ToggleComponent;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(24, 24, 27)
                });
                
                Library:Create( "UICorner" , {
                    Parent = Items.Inline
                });
                
                Library:Create( "UIGradient" , {
                    Color = rgbseq{rgbkey(0, rgb(213, 213, 213)), rgbkey(1, rgb(213, 213, 213))};
                    Parent = Items.Inline
                });
                
                Items.Circle = Library:Create( "Frame" , {
                    AnchorPoint = vec2(0, 0.5);
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 2, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 8, 0, 8);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(68, 68, 69)
                });
                
                Library:Create( "UICorner" , {
                    Parent = Items.Circle;
                    CornerRadius = dim(0, 999)
                });                
            end;
            
            function Cfg.Set(bool)
                Flags[Cfg.Flag] = bool

                Cfg.Callback(bool)

                Library:Tween(Items.ToggleComponent, {BackgroundColor3 = bool and themes.preset.accent or themes.preset.inline})
                Library:Tween(Items.Inline, {BackgroundColor3 = bool and themes.preset.accent or themes.preset.background})
                Library:Tween(Items.Circle, {BackgroundColor3 = bool and rgb(255, 255, 255) or themes.preset.deselected, Position = bool and dim2(1, -10, 0.5, 0) or dim2(0, 2, 0.5, 0)})                
            end
            
            Items.Toggle.MouseButton1Click:Connect(function()
                Cfg.Enabled = not Cfg.Enabled
                Cfg.Set(Cfg.Enabled)
            end)

            Cfg.Set(Cfg.Default)

            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end 
        
        function Library:Slider(properties) 
            local Cfg = {
                Name = properties.Name,
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
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Slider;
                    Name = "\0";
                    RichText = true;
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")
                
                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Slider;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 14);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.Components;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                });
                
                Items.Value = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.deselected;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "0.5";
                    Parent = Items.Components;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Value, "deselected", "BackgroundColor3")
                
                Items.Outline = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Parent = Items.Slider;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 21);
                    Size = dim2(1, 0, 0, 7);
                    Selectable = false;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(12, 14, 14)
                });
                
                Items.Fill = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Outline;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Fill, "accent", "BackgroundColor3")
                
                Items.Circle = Library:Create( "Frame" , {
                    AnchorPoint = vec2(0.5, 0.5);
                    Parent = Items.Fill;
                    Name = "\0";
                    Position = dim2(1, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 11, 0, 11);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Circle, "accent", "BackgroundColor3")
                
                Library:Create( "UICorner" , {
                    Parent = Items.Circle;
                    CornerRadius = dim(0, 999)
                });
            end 

            function Cfg.Set(value)
                Cfg.Value = math.clamp(Library:Round(value, Cfg.Intervals), Cfg.Min, Cfg.Max)

                Items.Fill.Size = dim2((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), 0, 1, 0)
                Items.Value.Text = tostring(Cfg.Value) .. Cfg.Suffix

                Flags[Cfg.Flag] = Cfg.Value
                Cfg.Callback(Flags[Cfg.Flag])
            end
            
            Items.Outline.MouseButton1Down:Connect(function()
                Cfg.Dragging = true 
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

        function Library:Dropdown(properties) 
            local Cfg = {
                Name = properties.Name or nil;
                Flag = properties.Flag or properties.Name or "Dropdown";
                Options = properties.Options or {""};
                Callback = properties.Callback or function() end;
                Multi = properties.Multi or false;
                Scrolling = properties.Scrolling or false;

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
            
            local Items = Cfg.Items; do 
                -- Element
                    Items.Dropdown = Library:Create( "Frame" , {
                        Parent = self.Items.Elements;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Title = Library:Create( "TextLabel" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Parent = Items.Dropdown;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        RichText = true;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")
                    
                    Items.Outline = Library:Create( "TextButton" , {
                        Active = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        Parent = Items.Dropdown;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 21);
                        Size = dim2(1, 0, 0, 20);
                        Selectable = false;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(31, 31, 31)
                    });
                    
                    Items.Arrow = Library:Create( "ImageLabel" , {
                        ImageColor3 = rgb(219, 222, 221);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Inline;
                        Name = "\0";
                        AnchorPoint = vec2(0, 0.5);
                        Image = "rbxassetid://70449495580650";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -15, 0.5, 0);
                        Size = dim2(0, 11, 0, 9);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.InnerText = Library:Create( "TextLabel" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Option1, Option2, Option3";
                        Parent = Items.Inline;
                        Name = "\0";
                        AnchorPoint = vec2(0, 0.5);
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 4, 0.5, 1);
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.InnerText, "text_color", "BackgroundColor3")                
                -- 
                
                -- Element Holder
                    Items.DropdownElements = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Size = dim2(0, 211, 0, 20);
                        Name = "\0";
                        Position = dim2(0, 0, 0, 21);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.DropdownElements, "inline", "BackgroundColor3")
                    
                    Items.DropdownHolder = Library:Create( "Frame" , {
                        Parent = Items.DropdownElements;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(31, 31, 31)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.DropdownHolder;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 2);
                        Parent = Items.DropdownElements
                    });                        
                -- 
            end 

            function Cfg.RenderOption(text)
                local Button = Library:Create( "TextButton" , {
                    Parent = Items.DropdownHolder;
                    AutoButtonColor = false;
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    Name = "\0";
                    TextColor3 = themes.preset.deselected;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    Size = dim2(1, 0, 0, 0);
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 4, 0.5, 1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Button, "deselected", "TextColor3")
                
                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, 4);
                    PaddingBottom = dim(0, 4);
                    Parent = Button;
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });                   

                table.insert(Cfg.OptionInstances, Button)

                return Button
            end
            
            function Cfg.SetVisible(bool)
                Items.DropdownElements.Position = dim2(0, Items.Outline.AbsolutePosition.X, 0, Items.Outline.AbsolutePosition.Y + 80)
				Items.DropdownElements.Size = dim_offset(Items.Outline.AbsoluteSize.X + 1, 0)
                Items.DropdownElements.Visible = bool 
                Items.DropdownElements.Parent = bool and Library.Items or Library.Other

                Library:Tween(Items.Arrow, {Rotation = bool and 180 or 0})
            end
            
            function Cfg.Set(value)
                local Selected = {}
                local IsTable = type(value) == "table"

                for _,option in Cfg.OptionInstances do 
                    if option.Text == value or (IsTable and table.find(value, option.Text)) then 
                        table.insert(Selected, option.Text)
                        Cfg.MultiItems = Selected
                        option.TextColor3 = themes.preset.text_color
                        option.BackgroundTransparency = 0.95
                    else
                        option.TextColor3 = themes.preset.deselected
                        option.BackgroundTransparency = 1
                    end
                end

                Items.InnerText.Text = if IsTable then table.concat(Selected, ", ") else Selected[1] or ""
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
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Label;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    RichText = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")
                
                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Label;
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
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                        
            end 

            function Cfg.Set(Text)
                Items.Title.Text = Text
            end 

            return setmetatable(Cfg, Library)
        end
        
        function Library:Colorpicker(properties) 
            local Cfg = {
                Name = properties.Name or "Color", 
                Flag = properties.Flag or properties.Name or "Colorpicker",
                Callback = properties.Callback or function() end,

                Color = properties.Color or color(1, 1, 1), -- Default to white color if not provided
                Alpha = properties.Alpha or properties.Transparency or 0,
                
                -- Other
                Open = false;
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

        function Library:Textbox(properties) 
            local Cfg = {
                Name = properties.Name or "TextBox",
                PlaceHolder = properties.PlaceHolder or properties.PlaceHolderText or properties.Holder or properties.HolderText or "Type here...",
                Default = properties.Default or "",
                Flag = properties.Flag or properties.Name or "TextBox",
                Callback = properties.Callback or function() end,
                
                Items = {};
            }

            Flags[Cfg.Flag] = Cfg.default

            local Items = Cfg.Items; do 
                Items.Textbox = Library:Create( "Frame" , {
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    RichText = true;
                    Text = Cfg.Name;
                    Parent = Items.Textbox;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")
                
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Textbox;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 21);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 20);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(26, 28, 28)
                });
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(31, 31, 31)
                });
                
                Items.Input = Library:Create( "TextBox" , {
                    Parent = Items.Inline;
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    Name = "\0";
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "hello theree!!";
                    Size = dim2(1, 0, 1, 0);
                    Selectable = false;
                    Position = dim2(0, 3, 0, 0);
                    BorderSizePixel = 0;
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextColor3 = rgb(239, 239, 239);
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                    
            end 
            
            function Cfg.Set(text) 
                Flags[Cfg.Flag] = text

                Items.Input.Text = text

                Cfg.Callback(text)
            end 
            
            Items.Input:GetPropertyChangedSignal("Text"):Connect(function()
                Cfg.Set(Items.Input.Text) 
            end) 

            if Cfg.default then 
                Cfg.Set(Cfg.default) 
            end

            ConfigFlags[Cfg.Flag] = Cfg.Set

            return setmetatable(Cfg, Library)
        end

        function Library:Keybind(properties) 
            local Cfg = {
                Flag = properties.Flag or properties.Name;
                Callback = properties.Callback or function() end;
                Name = properties.Name or nil; 

                Key = properties.Key or nil;
                Mode = properties.Mode or "Toggle";
                Active = properties.Default or false; 
                
                Open = false;
                Binding;
                Ignore = false;

                Items = {}
            }

            Flags[Cfg.Flag] = {
                Mode = Cfg.Mode,
                Key = Cfg.Key, 
                Active = Cfg.Active
            }

            local Items = Cfg.Items; do 
                -- Component
                    Items.KeybindOutline = Library:Create( "TextButton" , {
                        Active = false;
                        LayoutOrder = -1;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        Parent = self.Items.Components;
                        Name = "\0";
                        Size = dim2(0, 28, 0, 14);
                        Selectable = false;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(26, 28, 28)
                    });
                    
                    Items.ButtonColor = Library:Create( "Frame" , {
                        Parent = Items.KeybindOutline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(31, 31, 31)
                    });
                    
                    Library:Create( "UICorner" , {
                        Parent = Items.ButtonColor;
                        CornerRadius = dim(0, 4)
                    });
                    
                    Items.Key = Library:Create( "TextLabel" , {
                        FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "LSHIFT";
                        Parent = Items.ButtonColor;
                        Name = "\0";
                        TextXAlignment = Enum.TextXAlignment.Center;
                        BackgroundTransparency = 1;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.Key, "text_color", "BackgroundColor3")
                    
                    Library:Create( "UIPadding" , {
                        Parent = Items.Key;
                        PaddingRight = dim(0, 4);
                        PaddingLeft = dim(0, 5);
                        PaddingBottom = dim(0, 2);
                    });
                    
                    Library:Create( "UICorner" , {
                        Parent = Items.KeybindOutline;
                        CornerRadius = dim(0, 4)
                    }); 
                -- 
                
                -- Mode Holder
                    Items.ModeHolder = Library:Create( "TextButton" , {
                        Name = "\0";
                        Text = "";
                        AutoButtonColor = false;
                        Position = dim2(0.5217983722686768, 0, 0.47139304876327515, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 160, 0, 58);
                        Visible = false;
                        Parent = Library.Items;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.visible_backgrounds
                    });	Library:Themify(Items.ModeHolder, "visible_backgrounds", "BackgroundColor3")
                    
                    Items.Elements = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.ModeHolder;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 7, 0, 7);
                        Size = dim2(1, -14, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Elements;
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 15);
                        Parent = Items.Elements
                    });
                    
                    Items.Dropdown = setmetatable(Cfg, Library):Dropdown({Name = "Mode", Options = {"Hold", "Toggle", "Always"}, Flag = Cfg.Flag .. "OPTION_SETTINGS", Callback = function(options)
                        if Cfg.Set then 
                            Cfg.Set(options)
                        end
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
                    input.Key = type(input.Key) == "string" and input.Key ~= "NONE" and Library:ConvertEnum(input.key) or input.Key
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
                local __text = text and tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", "")

                Items.Key.Text = " " .. __text .. " "

                if Items.Keybinds then
                    Items.Keybinds.TextTransparency = 1
                    Library:Tween(Items.Keybinds, {TextTransparency = 0})

                    Items.KeybindsStroke.Transparency = 1
                    Library:Tween(Items.KeybindsStroke, {Transparency = 0})

                    Items.Keybinds.Visible = Cfg.Active
                    Items.Keybinds.Text = string.format("[%s]: %s", __text, Cfg.Name or Cfg.Flag or "Key")
                end 

                Flags[Cfg.Flag] = {
                    mode = Cfg.Mode,
                    key = Cfg.Key, 
                    active = Cfg.Active
                }
            end

            function Cfg.SetVisible(bool)
                -- Items.Fade.BackgroundTransparency = 0
                -- Library:Tween(Items.Fade, {BackgroundTransparency = 1})

                Items.ModeHolder.Visible = bool 
                Items.ModeHolder.Position = dim2(0, Items.KeybindOutline.AbsolutePosition.X + 2, 0, Items.KeybindOutline.AbsolutePosition.Y + 74)
            end

            Items.KeybindOutline.MouseButton1Down:Connect(function()
                task.wait()
                Items.Key.Text = " ... "	

                Cfg.Binding = Library:Connection(InputService.InputBegan, function(keycode, game_event)  
                    Cfg.Set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    Cfg.Binding:Disconnect() 
                    Cfg.Binding = nil
                end)
            end)

            Items.KeybindOutline.MouseButton2Down:Connect(function()
                Cfg.Open = not Cfg.Open 

                Cfg.SetVisible(Cfg.Open)
            end)

            Library:Connection(InputService.InputBegan, function(input, game_event) 
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    if not Library:Hovering({Items.ModeHolder, Items.Dropdown.Items.DropdownElements}) then 
                        Items.Dropdown.SetVisible(false)
                        Items.Dropdown.Visible = false

                        Cfg.SetVisible(false)
                        Cfg.Open = false;
                    end 
                end 

                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == Cfg.Key then 
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
                Items.Button = Library:Create( "Frame" , {
                    Parent = self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Outline = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Name = "\0";
                    Parent = Items.Button;
                    Size = dim2(1, 0, 0, 20);
                    Selectable = false;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(26, 28, 28)
                });
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(31, 31, 31)
                });
                
                Items.Title = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    RichText = true;
                    Text = Cfg.Name;
                    Parent = Items.Inline;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Title, "text_color", "BackgroundColor3")                                          
            end 

            Items.Outline.MouseButton1Click:Connect(function()
                Items.Title.TextColor3 = rgb(255, 255, 255)
                Library:Tween(Items.Title, {TextColor3 = themes.preset.text_color})
                
                Cfg.Callback()
            end)
            
            return setmetatable(Cfg, Library)
        end

        function Library:Configs(window) 
            local Text;
            local Tab = window:Tab({Name = "Settings"})

            local Section = Tab:Section({Name = "Main", Side = "Left"})
            ConfigHolder = Section:Dropdown({Name = "Configs", Options = {"Report", "This", "Error", "To", "Finobe"}, Callback = function(option) if Text then Text.Set(option) end end, Flag = "config_Name_list"}); Library:UpdateConfigList()
            Section:Textbox({Name = "Config Name:", Flag = "config_Name_text", default = ""})
            Section:Button({Name = "Save", Callback = function() if Flags["config_Name_text"] == "" then return end writefile(Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg", Library:GetConfig()) Library:UpdateConfigList() Notifications:Create({Name = "Saved Config (" ..  Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg" .. ")"}) end})
            Section:Button({Name = "Load", Callback = function() if Flags["config_Name_text"] == "" then return end Library:LoadConfig(readfile(Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg")) Library:UpdateConfigList() Notifications:Create({Name = "Loaded Config (" ..  Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg" .. ")"}) end})
            Section:Button({Name = "Delete", Callback = function() if Flags["config_Name_text"] == "" then return end delfile(Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg") Library:UpdateConfigList() Notifications:Create({Name = "Deleted Config (" ..  Library.Directory .. "/configs/" .. Flags["config_Name_text"] .. ".cfg" .. ")"}) end})

            local Section = Tab:Section({Name = "Other", Side = "Right"})
            Section:Label({Name = "Accent Color"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("accent", color) end, Color = themes.preset.accent})
            Section:Label({Name = "Window Outline"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("window_outline", color) end, Color = themes.preset.window_outline})
            Section:Label({Name = "Inline Elements"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("inline", color) end, Color = themes.preset.inline})
            Section:Label({Name = "Main Background"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("background", color) end, Color = themes.preset.background})
            Section:Label({Name = "Visible Backgrounds"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("visible_backgrounds", color) end, Color = themes.preset.visible_backgrounds})
            Section:Label({Name = "Text Color"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("text_color", color) end, Color = themes.preset.text_color})
            Section:Label({Name = "Glow Effect"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("glow", color) end, Color = themes.preset.glow})
            Section:Label({Name = "Deselected Elements"}):Colorpicker({Callback = function(color, alpha) Library:RefreshTheme("deselected", color) end, Color = themes.preset.deselected})

            window.Tweening = true
            Section:Label({Name = "Menu Bind"}):Keybind({Name = "Menu Bind", Callback = function(bool) 
                if window.Tweening then
                    return 
                end 

                window.ToggleMenu(bool) 
            end, Default = true})

            delay(2, function() window.Tweening = false end)
        end
    --

    -- Notification Library
        function Notifications:RefreshNotifications() 
            local offset = 50
            
            for i, v in Notifications.Notifs do
                local Position = vec2(20, offset)
                Library:Tween(v, {Position = dim_offset(Position.X, Position.Y)}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function Notifications:FadeNotifs(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            Library:Tween(path, {BackgroundTransparency = fading}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        Library:Tween(instance, {Transparency = fading}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    Library:Tween(instance, {TextTransparency = fading}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                elseif instance:IsA("Frame") then
                    Library:Tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                end
            end
        end 
        
        function Notifications:Create(properties)
            local Cfg = {
                Name = properties.Name or "This is a title!";
                Lifetime = properties.LifeTime or 3;
                
                Items = {};
                outline;
            }

            local Items = Cfg.Items; do 
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Library.Items;
                    Name = "\0";
                    Position = dim2(0, 100, 0, 10);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = themes.preset.inline
                });	Library:Themify(Items.Outline, "inline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.visible_backgrounds
                });	Library:Themify(Items.Inline, "visible_backgrounds", "BackgroundColor3")
                
                Library:Create( "UICorner" , {
                    Parent = Items.Inline
                });
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Inline;
                    Name = "\0";
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Name, "text_color", "BackgroundColor3")
                
                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, 5);
                    PaddingBottom = dim(0, 5);
                    Parent = Items.Name;
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                Library:Create( "UICorner" , {
                    Parent = Items.Outline
                });                       
            end 
            
            local index = #Notifications.Notifs + 1
            Notifications.Notifs[index] = Items.Outline
            
            local offset = Notifications:RefreshNotifications()

            Items.Outline.Position = dim_offset(20, offset)

            Library:Tween(Items.Outline, {AnchorPoint = vec2(0, 0)}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))

            task.spawn(function()
                task.wait(Cfg.Lifetime)
                Notifications.Notifs[index] = nil
                Notifications:FadeNotifs(Items.Outline, true)
                Library:Tween(Items.Outline, {AnchorPoint = vec2(1, 0)}, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out))
                task.wait(1)
                Items.Outline:Destroy() 
            end)
        end
    --
-- 

return Library
