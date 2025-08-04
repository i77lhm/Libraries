-- Probably my newest code up to date thats available publicly. 
-- Made around march - april 2025

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
        Directory = "Bbot v3",
        Folders = {
            "/fonts",
            "/configs",
        },
        Flags = {},
        ConfigFlags = {},
        Connections = {},   
        Notifications = {Notifs = {}},
        OpenElement = {}; -- type: table or userdata
        EasingStyle = Enum.EasingStyle.Quint;
        TweeningSpeed = 0.25
    }
    
    local themes = {
        preset = {
            inline = rgb(50, 50, 50);
            gradient = rgb(40, 40, 40);
            outline = rgb(20, 20, 20);
            accent = rgb(50, 119, 186);
            background = rgb(30, 30, 30);
            text_color = rgb(239, 239, 239);
            text_outline = rgb(0, 0, 0);
            tab_background = rgb(26, 26, 26);
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

    local Fonts = {}; do
        function RegisterFont(Name, Weight, Style, Asset)
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
        
        local Verdana = RegisterFont("Verawdawdawdwaddana", 400, "Normal", {
            Id = "Verdanawdawdwada.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/fs-tahoma-8px.ttf"),
        })

        Library.Font = Font.new(Verdana, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
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
                    Items.ColorpickerObject = Library:Create( "TextButton" , {
                        Name = "\0";
                        Text = "";
                        AutoButtonColor = false;
                        Parent = self.Items.Components;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 24, 0, 11);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.ColorpickerObject, "inline", "BackgroundColor3")
                    
                    Items.InlineColorPicker = Library:Create( "Frame" , {
                        Parent = Items.ColorpickerObject;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(162, 162, 162)), rgbkey(1, rgb(162, 162, 162))};
                        Parent = Items.InlineColorPicker
                    });
                    
                    Items.Inner = Library:Create( "Frame" , {
                        Parent = Items.InlineColorPicker;
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -4, 1, -4);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                --
                
                -- Colorpicker
                    Items.Colorpicker = Library:Create( "TextButton" , {
                        Parent = Library.Other;
                        Text = "";
                        AutoButtonColor = false;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 214, 0, 210);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Colorpicker, "inline", "BackgroundColor3")

                    Items.Fade = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Colorpicker;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 23);
                        Size = dim2(1, -2, 1, -24);
                        ZIndex = 100;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.Fade, "gradient", "BackgroundColor3")
                    
                    Items.UIStroke = Library:Create( "UIStroke" , {
                        Color = themes.preset.outline;
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.Colorpicker;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    }); Library:Themify(Items.UIStroke, "outline", "Color")
                    
                    Items.ColorTab = Library:Create( "Frame" , {
                        Parent = Items.Colorpicker;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 23);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -24);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.ColorTab, "gradient", "BackgroundColor3")
                    
                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 2);
                        PaddingBottom = dim(0, 2);
                        Parent = Items.ColorTab;
                        PaddingRight = dim(0, 2);
                        PaddingLeft = dim(0, 2)
                    });
                    
                    Items.SatValHolder = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.ColorTab;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -36, 1, -41);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.SatValHolder, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.SatValHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Color = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 221, 255)
                    });
                    
                    Items.Val = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Color;
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
                        AnchorPoint = vec2(0.5, 0);
                        Parent = Items.Color;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0, 3);
                        BorderSizePixel = 0;
                        ZIndex = 3;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    Items.inline = Library:Create( "Frame" , {
                        Parent = Items.SatValPicker;
                        Name = "\0";
                        ZIndex = 3;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Sat = Library:Create( "TextButton" , {
                        Parent = Items.Color;
                        Name = "\0";
                        Text = "";
                        AutoButtonColor = false;
                        Size = dim2(1, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = Items.Sat;
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    Items.AlphaInputFrame = Library:Create( "Frame" , {
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.ColorTab;
                        Name = "\0";
                        Position = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -36, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.AlphaInputFrame, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.AlphaInputFrame;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Input = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Input;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Items.InputAlpha = Library:Create( "TextBox" , {
                        CursorPosition = -1;
                        Parent = Items.Input;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "255, 255, 255, 0";
                        Name = "\0";
                        ClearTextOnFocus = false;
                        Size = dim2(1, -2, 1, -2);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BackgroundTransparency = 1;
                        PlaceholderColor3 = themes.preset.text_color;
                        AutomaticSize = Enum.AutomaticSize.X;
                        FontFace = Library.Font;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.InputAlpha;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingLeft = dim(0, 3);
                        Parent = Items.InputAlpha
                    });
                    
                    Items.RGBTextBox = Library:Create( "Frame" , {
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.ColorTab;
                        Name = "\0";
                        Position = dim2(0, 0, 1, -20);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -36, 0, 18);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.RGBTextBox, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.RGBTextBox;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Input = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Input;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Items.RGBInput = Library:Create( "TextBox" , {
                        CursorPosition = -1;
                        Parent = Items.Input;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "255, 255, 255, 0";
                        Name = "\0";
                        ClearTextOnFocus = false;
                        Size = dim2(1, -2, 1, -2);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BackgroundTransparency = 1;
                        PlaceholderColor3 = themes.preset.text_color;
                        AutomaticSize = Enum.AutomaticSize.X;
                        FontFace = Library.Font;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.RGBInput;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingLeft = dim(0, 3);
                        Parent = Items.RGBInput
                    });
                    
                    Items.AlphaSlider = Library:Create( "TextButton" , {
                        AnchorPoint = vec2(1, 1);
                        Parent = Items.ColorTab;
                        Name = "\0";
                        AutoButtonColor = false;
                        Text = "";
                        Position = dim2(1, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 16, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.AlphaSlider, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.AlphaSlider;
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
                    
                    Items.HueSlider = Library:Create( "TextButton" , {
                        AnchorPoint = vec2(1, 1);
                        Parent = Items.ColorTab;
                        Text = "";
                        AutoButtonColor = false;
                        Name = "\0";
                        Position = dim2(1, -18, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 16, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.HueSlider, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.HueSlider;
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
                    
                    if Cfg.Mode == "Animation" then 
                        Items.AnimationTab = Library:Create( "Frame" , {
                            Visible = false;
                            Parent = Items.Colorpicker;
                            Name = "\0";
                            Position = dim2(0, 1, 0, 23);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(1, -2, 1, -24);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.gradient
                        });	Library:Themify(Items.AnimationTab, "gradient", "BackgroundColor3")
                        
                        Library:Create( "UIPadding" , {
                            PaddingTop = dim(0, 2);
                            PaddingBottom = dim(0, 2);
                            Parent = Items.AnimationTab;
                            PaddingRight = dim(0, 2);
                            PaddingLeft = dim(0, 2)
                        });
                        
                        Items.Elements = Library:Create( "Frame" , {
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Items.AnimationTab;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Position = dim2(0, 6, 0, 0);
                            Size = dim2(1, -13, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Library:Create( "UIListLayout" , {
                            Parent = Items.Elements;
                            Padding = dim(0, 4);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        Library:Create( "UIPadding" , {
                            PaddingBottom = dim(0, 10);
                            Parent = Items.Elements
                        });

                        task.spawn(function()
                            while true do 
                                task.wait() 
                                local Type = Flags[Cfg.Flag .. "_ANIMATION_TYPE"]
                                local FlashSpeed = (100 - Flags[Cfg.Flag .. "_ANIMATION_SPEED"]) / 25
                                if Type ~= "None" then 
                                    local Speed = math.abs(math.sin(tick() * (Flags[Cfg.Flag .. "_ANIMATION_SPEED"] / 25)))
                                    if Type == "Rainbow" then 
                                        Cfg.Set(hsv(Speed, s, v), a)
                                    elseif Type == "Fading" then 
                                        local Color = Flags[Cfg.Flag .. "_PRIMARY_COLOR"].Color:Lerp(Flags[Cfg.Flag .. "_SECONDARY_COLOR"].Color, Speed)
                                        Cfg.Set(Color, Library:Lerp(Flags[Cfg.Flag .. "_PRIMARY_COLOR"].Transparency, Flags[Cfg.Flag .. "_SECONDARY_COLOR"].Transparency, Speed))
                                    elseif Type == "Flashing" then 
                                        Cfg.Set(Flags[Cfg.Flag .. "_PRIMARY_COLOR"].Color, Flags[Cfg.Flag .. "_PRIMARY_COLOR"].Transparency)
                                        task.wait(FlashSpeed)
                                        Cfg.Set(Flags[Cfg.Flag .. "_SECONDARY_COLOR"].Color, Flags[Cfg.Flag .. "_SECONDARY_COLOR"].Transparency)
                                        task.wait(FlashSpeed)
                                    end 
                                end 
                            end 
                        end)
                    end
                -- 

                -- 
                    Items.TabButtons = Library:Create( "Frame" , {
                        Parent = Items.Colorpicker;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 23);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.TabButtons;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.TabButtons;
                        Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                    }); Library:SaveGradient(gradient, "Deselected");
                    
                    Items.Buttons = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, -1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Buttons;
                        FillDirection = Enum.FillDirection.Horizontal;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        Padding = dim(0, -1);
                    });
                    
                    Library:Create( "UIPadding" , {
                        Parent = Items.Buttons;
                        PaddingTop = dim(0, 3)
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.TabButtons;
                        Name = "\0";
                        Position = dim2(0, 0, 1, 0);
                        Size = dim2(1, 0, 0, 1);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                --
                
                -- Buttons
                    local Tabs = {}
                    local OldTab;

                    if Cfg.Mode == "Animation" then 
                        Tabs = {"ColorTab", "AnimationTab"}
                    else 
                        Tabs = {"ColorTab"}
                    end 

                    for _,tab in Tabs do
                        local Temp = {}

                        Temp.Button = Library:Create( "TextButton" , {
                            Parent = Items.Buttons;
                            Name = "\0";
                            Size = dim2(0, 0, 1, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            Text = "";
                            AutomaticSize = Enum.AutomaticSize.X;
                            AutoButtonColor = false;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Temp.Background = Library:Create( "TextLabel" , {
                            FontFace = Library.Font;
                            TextColor3 = themes.preset.text_color;
                            BorderColor3 = rgb(0, 0, 0);
                            Text = tab:gsub("Tab", "");
                            Parent = Temp.Button;
                            Name = "\0";
                            BackgroundTransparency = _==1 and 1;
                            Size = dim2(0, 0, 1, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 12;
                            BackgroundColor3 = themes.preset.tab_background
                        });	Library:Themify(Temp.Background, "tab_background", "BackgroundColor3")
                        
                        Temp.TextPadding = Library:Create( "UIPadding" , {
                            Parent = Temp.Background;
                            PaddingRight = dim(0, 6);
                            PaddingLeft = dim(0, 5)
                        });
                        
                        Library:Create( "UIStroke" , {
                            Parent = Temp.Background;
                            LineJoinMode = Enum.LineJoinMode.Miter;
                        });
                        
                        Temp.Fill = Library:Create( "Frame" , {
                            BorderColor3 = rgb(0, 0, 0);
                            AnchorPoint = vec2(0, 1);
                            Parent = Temp.Button;
                            Name = "\0";
                            Position = dim2(0, 0, 1, 1);
                            Size = dim2(1, 0, 0, 1);
                            ZIndex = 3;
                            BackgroundTransparency = _==1 and 0;
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.gradient
                        });	Library:Themify(Temp.Fill, "gradient", "BackgroundColor3")
                        
                        local gradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = Temp.Button;
                            Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                        });  Library:SaveGradient(gradient, "Selected");
                        
                        Temp.UIStroke = Library:Create( "UIStroke" , {
                            Color = themes.preset.outline;
                            LineJoinMode = Enum.LineJoinMode.Miter;
                            Parent = Temp.Button;
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        });	Library:Themify(Temp.UIStroke, "outline", "Color");

                        if _ == 1 then 
                            OldTab = Temp
                        end 

                        Temp.Button.MouseButton1Click:Connect(function()
                            for _,close in Tabs do 
                                Items[close].Visible = false
                            end 
                            
                            if OldTab then 
                                Library:Tween(OldTab.Fill, {BackgroundTransparency = 1})
                                Library:Tween(OldTab.Background, {BackgroundTransparency = 0})
                            end 

                            Items[tab].Visible = true
                            Library:Tween(Temp.Fill, {BackgroundTransparency = 0})
                            Library:Tween(Temp.Background, {BackgroundTransparency = 1})

                            if Items.Dropdown then 
                                Items.Dropdown.SetVisible(false)
                                Items.Dropdown.Open = false

                                Items.Primary.SetVisible(false)
                                Items.Primary.Open = false

                                Items.Secondary.SetVisible(false)
                                Items.Secondary.Open = false
                            end

                            Items.Fade.BackgroundTransparency = 0 
                            Library:Tween(Items.Fade, {BackgroundTransparency = 1})

                            OldTab = Temp
                        end)
                    end 
                --
            end;
            
            if Cfg.Mode == "Animation" then 
                local Index = setmetatable(Cfg, Library)
                Items.Dropdown = Index:Dropdown({Name = "Animation", Flag = Cfg.Flag .. "_ANIMATION_TYPE", Options = {"None", "Rainbow", "Fading", "Flashing"}})
                Items.Primary = Index:Label({Name = "Primary"}):Keypicker({Mode = "Keypicker", Flag = Cfg.Flag .. "_PRIMARY_COLOR"})
                Items.Secondary = Index:Label({Name = "Secondary"}):Keypicker({Mode = "Keypicker", Flag = Cfg.Flag .. "_SECONDARY_COLOR"})
                Index:Slider({Name = "Speed", Min = 0, Max = 100, Interval = 1, Suffix = "%", Flag = Cfg.Flag .. "_ANIMATION_SPEED"})
                
                Library:Connection(InputService.InputBegan, function(input, game_event) 
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if Items.Colorpicker.Visible and not Library:Hovering({
                                Items.ColorpickerObject, 
                                Items.Dropdown.Items.DropdownElements, 
                                Items.Dropdown.Items.Dropdown, 
                                Items.Colorpicker,
                                Items.Primary.Items.Colorpicker,
                                Items.Secondary.Items.Colorpicker
                            }) then
                            Items.Dropdown.SetVisible(false)
                            Items.Dropdown.Open = false
                            
                            Cfg.Open = false
                            Cfg.SetVisible(false)
                            
                            Items.Primary.SetVisible(false)
                            Items.Primary.Open = false

                            Items.Secondary.SetVisible(false)
                            Items.Secondary.Open = false
                        end 
                    end 
                end) 
                
                local Pickers = {Items.Primary, Items.Secondary}
                for _,picker in Pickers do
                    Library:Connection(InputService.InputBegan, function(input, game_event)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            if picker.Items.Colorpicker.Visible and not Library:Hovering({picker.Items.ColorpickerObject, picker.Items.Colorpicker}) then
                                picker.SetVisible(false)
                                picker.Open = false
                            end 
                        end 
                    end)
                end
            end
            
            function Cfg.SetVisible(bool)
                Items.Fade.BackgroundTransparency = 0 
                Library:Tween(Items.Fade, {BackgroundTransparency = 1})

                Items.Colorpicker.Visible = bool
                Items.Colorpicker.Parent = bool and Library.Items or Library.Other
                Items.Colorpicker.Position = dim2(0, Items.ColorpickerObject.AbsolutePosition.X + 2, 0, Items.ColorpickerObject.AbsolutePosition.Y + 74)
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
                
                Items.Inner.BackgroundColor3 = hsv(h,s,v)
                Items.InlineColorPicker.BackgroundColor3 = hsv(h,s,v)
                Items.Color.BackgroundColor3 = hsv(h, 1, 1)

                Flags[Cfg.Flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local Color = Items.InlineColorPicker.BackgroundColor3 -- Overwriting to format<<
                Items.RGBInput.Text = string.format("%s, %s, %s, ", Library:Round(Color.R * 255), Library:Round(Color.G * 255), Library:Round(Color.B * 255))
                Items.RGBInput.Text ..= Library:Round(1 - a, 0.01)
                
                Items.InputAlpha.Text = Library:ConvertHex(Color, 1 - a)

                Cfg.Callback(Color, a)
            end

            function Cfg.UpdateColor() 
                local Mouse = InputService:GetMouseLocation()
                local offset = vec2(Mouse.X, Mouse.Y - gui_offset) 
                
                if DraggingSat then	
                    s = math.clamp((offset - Items.Sat.AbsolutePosition).X / Items.Sat.AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - Items.Sat.AbsolutePosition).Y / Items.Sat.AbsoluteSize.Y, 0, 1)
                elseif DraggingHue then
                    h = math.clamp((offset - Items.HueSlider.AbsolutePosition).Y / Items.HueSlider.AbsoluteSize.Y, 0, 1)
                elseif DraggingAlpha then
                    a = math.clamp((offset - Items.AlphaSlider.AbsolutePosition).Y / Items.AlphaSlider.AbsoluteSize.Y, 0, 1)
                end

                Cfg.Set()
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

            Library:Connection(InputService.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    DraggingSat = false
                    DraggingHue = false
                    DraggingAlpha = false
                end
            end)    

            Items.AlphaSlider.MouseButton1Down:Connect(function()
                DraggingAlpha = true 
            end)
            
            Items.HueSlider.MouseButton1Down:Connect(function()
                DraggingHue = true 
            end)
            
            Items.Sat.MouseButton1Down:Connect(function()
                DraggingSat = true  
            end)

            Items.RGBInput.FocusLost:Connect(function()
                local text = Items.RGBInput.Text
                local r, g, b, a = Library:Convert(text)
                
                if r and g and b and a then 
                    Cfg.Set(rgb(r, g, b), 1 - a)
                end 
            end)

            Items.InputAlpha.FocusLost:Connect(function()
                local Color, Alpha = Library:ConvertFromHex(Items.InputAlpha.Text)
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
                Name = properties.Name or "nebula";
                Size = properties.Size or dim2(0, 455, 0, 605);
                TabInfo;
                Items = {};
            }
            
            Library.Items = Library:Create( "ScreenGui" , {
                Parent = CoreGui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Global;
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
                -- Window
                    Items.Window = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Name = "\0";
                        Position = dim2(0.5, -Cfg.Size.X.Offset / 2, 0.5, -Cfg.Size.Y.Offset / 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = Cfg.Size;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    }); Items.Window.Position = dim2(0, Items.Window.AbsolutePosition.X, 0, Items.Window.AbsolutePosition.Y); Library:Themify(Items.Window, "outline", "BackgroundColor3");

                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 4);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -5);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.Inline, "gradient", "BackgroundColor3")
                    
                    Items.Gradient = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 0, 16);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Gradient;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 5, 0, 18);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -10, 1, -23);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.Background = Library:Create( "Frame" , {
                        Parent = Items.Outline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.Background, "background", "BackgroundColor3")
                    
                    Items.PageHolder = Library:Create( "Frame" , {
                        Parent = Items.Background;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.PageHolder, "outline", "BackgroundColor3")
                    
                    Items.TabButtons = Library:Create( "Frame" , {
                        Parent = Items.PageHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 0, 23);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.TabButtons;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.TabButtons;
                        Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                    }); Library:SaveGradient(gradient, "Deselected");
                    
                    Items.Buttons = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, -1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Buttons;
                        FillDirection = Enum.FillDirection.Horizontal;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        Padding = dim(0, -1);
                    });
                    
                    Library:Create( "UIPadding" , {
                        Parent = Items.Buttons;
                        PaddingTop = dim(0, 3)
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.TabButtons;
                        Name = "\0";
                        Position = dim2(0, 0, 1, 0);
                        Size = dim2(1, 0, 0, 1);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.PageHolder = Library:Create( "Frame" , {
                        Parent = Items.PageHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 24);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -25);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.PageHolder, "background", "BackgroundColor3")

                    Items.Fade = Library:Create( "Frame" , {
                        Parent = Items.PageHolder;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.Fade, "background", "BackgroundColor3")                

                    Items.FadeGradient = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Fade;
                        ZIndex = 5;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.FadeGradient;
                        Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                    }); Library:SaveGradient(gradient, "Deselected");                

                    Items.Gradient = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.PageHolder;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 20);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Gradient;
                        Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                    }); Library:SaveGradient(gradient, "Deselected");
                    
                    -- Items.Outline = Library:Create( "Frame" , {
                    --     Parent = Items.PageHolder;
                    --     Name = "\0";
                    --     Position = dim2(0, 2, 0, 3);
                    --     BorderColor3 = rgb(0, 0, 0);
                    --     Size = dim2(1, -4, 0, 1);
                    --     BorderSizePixel = 0;
                    --     BackgroundColor3 = themes.preset.outline
                    -- });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Size = dim2(1, -2, 1, -5);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 4);
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 0;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.Inline, "gradient", "BackgroundColor3")
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.Window;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 3);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.UITitle = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Parent = Items.Window;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 5, 0, 6);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.UITitle;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });  
                --
                
                -- Keybind list
                    Items.Keybind_List = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Name = "\0";
                        Position = dim2(0, 50, 0, 500);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Keybind_List, "outline", "BackgroundColor3"); Library:Draggify(Items.Keybind_List)
                        
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 4);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 6, 1, 22);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.Inline, "gradient", "BackgroundColor3")
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 6, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 3);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 7, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.Activity = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Activity";
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 3, 0, 6);
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.Activity;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Items.Gradient = Library:Create( "Frame" , {
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 4);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 6, 0, 16);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Gradient;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 5);
                        Parent = Items.Keybind_List
                    });
                    
                    Items.Elements = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 16, 0, 38);
                        Size = dim2(1, -8, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); Library.KeybindParent = Items.Elements
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Elements;
                        Padding = dim(0, 3);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Items.Keybinds = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Keybinds";
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 8, 0, 22);
                        RichText = true;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.Keybinds;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Items.Activity = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Activity: Ready";
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 6, 1, 8);
                        BorderSizePixel = 0;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.Activity;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingBottom = dim(0, 7);
                        Parent = Items.Activity
                    });
                    
                    Items.ActivityLine = Library:Create( "Frame" , {
                        Parent = Items.Keybind_List;
                        Name = "\0";
                        Position = dim2(0, 5, 1, 5);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -3, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(204, 204, 204)
                    });
                -- 

                -- Watermark
                    Items.Watermark = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Name = "\0";
                        Position = dim2(0, 20, 0, 60);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.inline
                    }); Library:Themify(Items.Watermark, "inline", "BackgroundColor3")
                    Library:Draggify(Items.Watermark)

                    local stroke = Library:Create( "UIStroke" , {
                        Color = themes.preset.outline;
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.Watermark
                    }); Library:Themify(stroke, "outline", "Color")
                    
                    Items.Holder = Library:Create( "Frame" , {
                        Parent = Items.Watermark;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local grad = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Holder;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    });  Library:SaveGradient(grad, "Selected");
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.Watermark;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    }); Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.Watermark;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    }); Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.WatermarkTitle = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = rgb(239, 239, 239);
                        BorderColor3 = rgb(0, 0, 0);
                        RichText = true;
                        Text = Cfg.Name .. "lua";
                        Parent = Items.Watermark;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 14, 0, -2);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.WatermarkTitle;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingTop = dim(0, 5);
                        PaddingBottom = dim(0, 2);
                        Parent = Items.WatermarkTitle;
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    Library:Create( "ImageLabel" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Watermark;
                        Image = "rbxassetid://133601737414791";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 3, 0, 2);
                        Size = dim2(0, 11, 0, 15);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                --
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

            function Cfg.ChangeTitle(text)
                Items.UITitle.Text = text
            end

            function Cfg.ToggleWatermark(bool) 
                Items.Watermark.Visible = bool
            end 

            function Cfg.ChangeWatermarkTitle(text)
                Items.WatermarkTitle.Text = text
            end

            function Cfg.ToggleStatus(bool) 
                Items.Activity.Visible = bool
                Items.ActivityLine.Visible = bool
            end

            function Cfg.ToggleKeybindList(bool)
                Items.Keybind_List.Visible = bool
                print(bool)
            end
            
            return setmetatable(Cfg, Library)
        end 

        function Library:Tab(properties)
            local Cfg = {
                Name = properties.name or properties.Name or "visuals"; 
                Items = {};
            }

            local Items = Cfg.Items; do 
                -- Tab buttons 
                    Items.Button = Library:Create( "TextButton" , {
                        Parent = self.Items.Buttons;
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Text = "";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        AutoButtonColor = false;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Background = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Parent = Items.Button;
                        Name = "\0";
                        BackgroundTransparency = 0;
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = themes.preset.tab_background
                    });	Library:Themify(Items.Background, "tab_background", "BackgroundColor3")
                    
                    Items.TextPadding = Library:Create( "UIPadding" , {
                        Parent = Items.Background;
                        PaddingRight = dim(0, 6);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.Background;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Items.Fill = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.Button;
                        Name = "\0";
                        Position = dim2(0, 0, 1, 1);
                        Size = dim2(1, -2, 0, 1);
                        ZIndex = 3;
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.gradient
                    });	Library:Themify(Items.Fill, "gradient", "BackgroundColor3")
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Button;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Items.UIStroke = Library:Create( "UIStroke" , {
                        Color = themes.preset.outline;
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.Button;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    });	Library:Themify(Items.UIStroke, "outline", "Color");
                -- 

                -- Page directory 
                    Items.Page = Library:Create( "Frame" , {
                        Parent = Library.Other; -- self.Items.PageHolder
                        Name = "\0";
                        Visible = false;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -4, 1, -4);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = Items.Page;
                        Padding = dim(0, 4);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    });
                    
                    Items.Left = Library:Create( "Frame" , {
                        Parent = Items.Page;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 100, 0, 100);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Left;
                        Padding = dim(0, 4);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Items.Right = Library:Create( "Frame" , {
                        Parent = Items.Page;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 100, 0, 100);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Right;
                        Padding = dim(0, 4);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });
                -- 
            end 

            function Cfg.OpenTab() 
                local Tab = self.TabInfo
                
                if Tab then
                    Library:Tween(Tab.Fill, {BackgroundTransparency = 1})
                    Library:Tween(Tab.Background, {BackgroundTransparency = 0})

                    Tab.Page.Visible = false
                    Tab.Page.Parent = Library.Other
                end

                Library:Tween(Items.Fill, {BackgroundTransparency = 0})
                Library:Tween(Items.Background, {BackgroundTransparency = 1})

                Items.Page.Parent = self.Items.PageHolder
                Items.Page.Visible = true

                if Tab ~= Items then
                    Library:Tween(self.Items.Fade, {BackgroundTransparency = 1})
                    Library:Tween(self.Items.FadeGradient, {BackgroundTransparency = 1})

                    self.Items.Fade.BackgroundTransparency = 0 
                    self.Items.FadeGradient.BackgroundTransparency = 0
                end 

                

                self.TabInfo = Cfg.Items
            end

            Items.Button.MouseButton1Down:Connect(function()
                Library:CloseElement()
                Cfg.OpenTab()
            end)

            if not self.TabInfo then
                Items.TextPadding.PaddingRight = dim(0, 8);
                Cfg.OpenTab()
            end

            return setmetatable(Cfg, Library)
        end

        function Library:PlayerList(properties)
            local Cfg = {
                Players = {};
                Items = {};

                Selected;
            }   

            local Colors = {
                ["Neutral"] = themes.preset.text_color;
                ["Friendly"] = rgb(38, 89, 140);
                ["Enemy"] = rgb(140, 0, 2)
            }

            self.Items.Left:Destroy()
            self.Items.Right:Destroy()

            local Items = Cfg.Items; do 
                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = self.Items.Page;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
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
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Items.Outline = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Column;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -84);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                }); Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                
                Items.PriorityHolder = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 19);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 18);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                }); Library:Themify(Items.PriorityHolder, "outline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.PriorityHolder;
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
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = Items.Background;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                Items.UITitle = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "Name";
                    Parent = Items.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.UITitle;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Items.UITitle = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "UserId";
                    Parent = Items.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.UITitle;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Items.UITitle = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "Priority";
                    Parent = Items.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.UITitle;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Items.ScrollingFrame = Library:Create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(45, 108, 168);
                    MidImage = "rbxassetid://74268315755026";
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 3;
                    Parent = Items.Outline;
                    Size = dim2(1, -4, 1, -38);
                    BorderColor3 = rgb(0, 0, 0);
                    BackgroundColor3 = rgb(255, 255, 255);
                    TopImage = "rbxassetid://74268315755026";
                    Position = dim2(0, 2, 0, 38);
                    BackgroundTransparency = 1;
                    BottomImage = "rbxassetid://74268315755026";
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.ScrollingFrame;
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Items.Refresh = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(1, -1, 0, 1);
                    Size = dim2(0, 58, 0, 18);
                    Selectable = false;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                }); Library:Themify(Items.Refresh, "outline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Refresh;
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
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "Refresh";
                    Parent = Items.Background;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    Position = dim2(0, 3, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    Parent = Items.Name
                });
                
                Items.Holder = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -60, 0, 18);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline;
                }); Library:Themify(Items.Holder, "outline", "BackgroundColor3")

                Items.Search = Library:Create( "TextBox" , {
                    Active = true;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Holder;
                    Name = "\0";    
                    Selectable = false;
                    Position = dim2(0, 5, 0, 0);
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    FontFace = Library.Font;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextTransparency = 0;
                    TextColor3 = themes.preset.text_color;
                    BackgroundTransparency = 1;
                    Text = "";
                    TextSize = 12;
                    ZIndex = 2;
                    PlaceholderText = "Search Here";
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Search;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Holder;
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
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");             
                
                Items.PlayerSelection = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Column;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 80);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                }); Library:Themify(Items.PlayerSelection, "outline", "BackgroundColor3");
                
                Items.ImageProfile = Library:Create( "ImageLabel" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.PlayerSelection;
                    Name = "\0";
                    AnchorPoint = vec2(0, 0.5);
                    Image = "rbxassetid://131920135912699";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 8, 0.5, 0);
                    Size = dim2(0, 64, 0, 64);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Elements = Library:Create( "Frame" , {
                    Parent = Items.PlayerSelection;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 84, 0, 8);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 100, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Parent = setmetatable(Cfg, Library)
                Items.NameLabel = Parent:Label({Name = "Name: ???"})
                Items.DisplayNameLabel = Parent:Label({Name = "DisplayName: ???"})
                Items.UserIdLabel = Parent:Label({Name = "UserId: ???"})

                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 3);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Items.Elements = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    Parent = Items.PlayerSelection;
                    BackgroundTransparency = 1;
                    Position = dim2(1, -4, 0, 8);
                    Name = "\0";
                    Size = dim2(0, 150, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                local Parent = setmetatable(Cfg, Library)
                Items.PriorityDropdown = Parent:Dropdown({Name = "Priority", Options = {"Friendly", "Enemy", "Neutral"}, Callback = function(option)
                    if Cfg.ModifyPriority then 
                        Cfg.ModifyPriority(option)
                    end
                end})
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 3);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
            end     

            function Cfg.AddPlayer(player)
                local SeperateData = {}

                SeperateData.Background = Library:Create( "TextButton" , {
                    Active = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.ScrollingFrame;
                    Name = "\0";
                    Size = dim2(1, -2, 0, 19);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    Selectable = false;
                    TextTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = SeperateData.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                    Parent = SeperateData.Background;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    VerticalFlex = Enum.UIFlexAlignment.Fill
                });
                
                SeperateData.Name = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = player.Name;
                    Parent = SeperateData.Background;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Library:Themify(SeperateData.Name, "accent", "TextColor3");
                
                Library:Create( "UIStroke" , {
                    Parent = SeperateData.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    PaddingLeft = dim(0, 4);
                    Parent = SeperateData.Name
                });
                
                SeperateData.UserId = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = player.UserId;
                    Parent = SeperateData.Background;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); Library:Themify(SeperateData.UserId, "accent", "TextColor3");
                
                Library:Create( "UIStroke" , {
                    Parent = SeperateData.UserId;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                SeperateData.Priority = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = player.Name == Players.LocalPlayer.Name and rgb(119, 119, 119) or themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = player.Name == Players.LocalPlayer.Name and "LocalPlayer" or "Neutral";
                    Parent = SeperateData.Background;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = SeperateData.Priority;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    PaddingRight = dim(0, 8);
                    Parent = SeperateData.Priority
                });               
                
                SeperateData.Background.MouseButton1Click:Connect(function()
                    if SeperateData.Priority.Text == "LocalPlayer" then 
                        return
                    end 

                    local Old = Cfg.Selected

                    if Old then
                        Old.Name.TextColor3 = themes.preset.text_color
                        Old.UserId.TextColor3 = themes.preset.text_color
                    end     

                    SeperateData.Name.TextColor3 = themes.preset.accent
                    SeperateData.UserId.TextColor3 = themes.preset.accent
                    Items.ImageProfile.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size150x150)

                    Items.NameLabel.Set("Name: " .. player.Name)
                    Items.UserIdLabel.Set("UserId: " .. player.UserId)
                    Items.DisplayNameLabel.Set("DisplayName: " .. player.DisplayName)

                    Cfg.Selected = SeperateData
                    task.wait()
                    Items.PriorityDropdown.Set(SeperateData.Priority.Text)
                end)

                Cfg.Players[player.Name] = SeperateData
            end 
            
            function Cfg.ModifyPriority(Priority, Items)
                local Path = Items or Cfg.Selected
                if Path then
                    Path.Priority.Text = Priority
                    Path.Priority.TextColor3 = Colors[Priority]
                end
            end 

            function Cfg.GetPriority(Player)
                return Cfg.Players[Player].Priority.Text;
            end     

            for _,player in Players:GetPlayers() do 
                Cfg.AddPlayer(player)
            end

            Items.Refresh.MouseButton1Click:Connect(function()
                for _,player in Players:GetPlayers() do
                    if player == Players.LocalPlayer then 
                        continue 
                    end 

                    Cfg.ModifyPriority("Neutral", Cfg.Players[player.Name])
                end
            end)

            Items.Search:GetPropertyChangedSignal("Text"):Connect(function()
                local Text = Items.Search.Text

                for _,player in Players:GetPlayers() do 
                    local Path = Cfg.Players[player.Name] and Cfg.Players[player.Name].Background

                    if not Path then
                        return 
                    end 

                    if string.match(string.lower(player.Name), string.lower(Text)) then 
                        Path.Visible = true 
                    else 
                        Path.Visible = false
                    end
                end 
            end)

            return setmetatable(Cfg, Library)
        end 

        function Library:MultiSection(properties)
            local Cfg = {
                Tabs = properties.Tabs or {"1", "2", "3"}; 
                Side = properties.side or properties.Side or "Left";

                -- Fill settings 
                Size = properties.size or properties.Size or nil;
                
                -- Other
                Items = {};
                Store = {};

                TabInfo;
            };

            local Items = Cfg.Items; do
                Items.Section = Library:Create( "Frame" , {
                    Parent = self.Items[Cfg.Side];
                    Name = "\0";
                    Size = dim2(1, 0, Cfg.Size or 0, -4);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Cfg.Size and Enum.AutomaticSize.None or Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Section, "outline", "BackgroundColor3")

                -- Tab buttons 
                    Items.TabButtons = Library:Create( "Frame" , {
                        Parent = Items.Section;
                        Name = "\0";
                        ZIndex = 2;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 0, 23);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        ZIndex = 2;
                        Parent = Items.TabButtons;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        Name = "\0";
                        ZIndex = 2;
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.TabButtons;
                        Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                    }); Library:SaveGradient(gradient, "Deselected");
                    
                    Items.Buttons = Library:Create( "Frame" , {
                        Parent = Items.TabButtons;
                        BackgroundTransparency = 1;
                        ZIndex = 3;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, -1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Buttons;
                        FillDirection = Enum.FillDirection.Horizontal;
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        Padding = dim(0, -1);
                    });
                    
                    Library:Create( "UIPadding" , {
                        Parent = Items.Buttons;
                        PaddingTop = dim(0, 3)
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(0, 1);
                        Parent = Items.TabButtons;
                        Name = "\0";
                        Position = dim2(0, 0, 1, 0);
                        Size = dim2(1, 0, 0, 1);
                        ZIndex = 3;
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                --

                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Size = dim2(1, -2, Cfg.Size and 1 or 0, -4);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 4);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Cfg.Size and Enum.AutomaticSize.None or Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.gradient
                });	Library:Themify(Items.Inline, "gradient", "BackgroundColor3")

                Items.Fade = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Size = dim2(1, 0, 1, -24);
                    Name = "\0";
                    Position = dim2(0, 0, 0, 24);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    ZIndex = 2;
                    BackgroundTransparency = 1;
                    BackgroundColor3 = themes.preset.gradient
                });	Library:Themify(Items.Fade, "gradient", "BackgroundColor3")

                Items.Gradient = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Gradient;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 5);
                    Parent = Items.Inline
                });
                
                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                
                Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Accent;
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                });
                
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 3);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Library:Create( "UIStroke" , {
                    Parent = Items.UITitle;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });  
                
                Items.Elements = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Inline; -- SubItems.Inline
                    Name = "\0";
                    Visible = true;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 6, 0, 26);
                    Size = dim2(1, 12, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.Elements, "text_outline", "BackgroundColor3")   

                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });

                Items.ScrollingFrame = Library:Create( "ScrollingFrame" , {
                    Active = true;
                    ScrollingEnabled = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ZIndex = 2;
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0);
                    ScrollBarImageColor3 = themes.preset.accent;
                    MidImage = "rbxassetid://120496541810421";
                    BorderColor3 = rgb(0, 0, 0);
                    ScrollBarThickness = 0;
                    Parent = Items.Inline;
                    Size = dim2(1, -3, 1, -21);
                    TopImage = "rbxassetid://118750478739322";
                    Position = dim2(0, 0, 0, 23);
                    BottomImage = "rbxassetid://74268315755026";
                    BackgroundTransparency = 1;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.ScrollingFrame, "accent", "ScrollBarImageColor3")
                
                Items.ScrollingLine = Library:Create( "Frame" , {
                    Visible = false;
                    BorderColor3 = rgb(0, 0, 0);
                    AnchorPoint = vec2(1, 0);
                    Name = "\0";
                    Position = dim2(1, -2, 0, 22);
                    Parent = Items.Inline;
                    Size = dim2(0, 4, 1, -18);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.ScrollingLine, "outline", "BackgroundColor3")
                
                Items.Elements:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    if Items.ScrollingFrame.AbsoluteSize.Y < Items.Elements.AbsoluteSize.Y then 
                        Items.ScrollingLine.Visible = true 
                        Library:Tween(Items.ScrollingFrame, {ScrollBarThickness = 2})
                        Library:Tween(Items.Elements, {Size = dim2(1, -14, 0, 0)})
                    else
                        Items.ScrollingLine.Visible = false
                        Library:Tween(Items.ScrollingFrame, {ScrollBarThickness = 0})
                        Library:Tween(Items.Elements, {Size = dim2(1, -10, 0, 0)})
                    end     
                end)
                
                Items.Elements.Parent = Items.ScrollingFrame
                Items.Elements.Position = dim2(0, 6, 0, 6);
            end;

            for _,tab in Cfg.Tabs do 
                local Data = {Items = {}}

                local SubItems = Data.Items; do 
                    -- Tab buttons 
                        SubItems.Button = Library:Create( "TextButton" , {
                            Parent = Items.Buttons;
                            Name = "\0";
                            ZIndex = 4;
                            Size = dim2(0, 0, 1, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            Text = "";
                            AutomaticSize = Enum.AutomaticSize.X;
                            AutoButtonColor = false;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        SubItems.Background = Library:Create( "TextLabel" , {
                            FontFace = Library.Font;
                            TextColor3 = themes.preset.text_color;
                            BorderColor3 = rgb(0, 0, 0);
                            Text = tab;
                            ZIndex = 4;
                            Parent = SubItems.Button;
                            Name = "\0";
                            BackgroundTransparency = Cfg.TabInfo and 0 or 1;
                            Size = dim2(0, 0, 1, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 12;
                            BackgroundColor3 = themes.preset.tab_background
                        });	Library:Themify(SubItems.Background, "tab_background", "BackgroundColor3")
                        
                        SubItems.TextPadding = Library:Create( "UIPadding" , {
                            Parent = SubItems.Background;
                            PaddingRight = dim(0, 6);
                            PaddingLeft = dim(0, 5)
                        });
                        
                        Library:Create( "UIStroke" , {
                            Parent = SubItems.Background;
                            LineJoinMode = Enum.LineJoinMode.Miter
                        });
                        
                        SubItems.Fill = Library:Create( "Frame" , {
                            BorderColor3 = rgb(0, 0, 0);
                            AnchorPoint = vec2(0, 1);
                            Parent = SubItems.Button;
                            ZIndex = 5;
                            Name = "\0";
                            Position = dim2(0, 0, 1, 1);
                            Size = dim2(1, 0, 0, 1);
                            BackgroundTransparency = Cfg.TabInfo and 1 or 0;
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.gradient
                        });	Library:Themify(SubItems.Fill, "gradient", "BackgroundColor3")
                        
                        local gradient = Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Parent = SubItems.Button;
                            Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                        });  Library:SaveGradient(gradient, "Selected");
                        
                        SubItems.UIStroke = Library:Create( "UIStroke" , {
                            Color = themes.preset.outline;
                            LineJoinMode = Enum.LineJoinMode.Miter;
                            Parent = SubItems.Button;
                            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                        });	Library:Themify(SubItems.UIStroke, "outline", "Color");
                    -- 
                        
                    -- Page directory  
                        SubItems.Elements = Library:Create( "Frame" , {
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Library.Other; -- SubItems.Inline
                            Name = "\0";
                            Visible = false;
                            BackgroundTransparency = 1;
                            Position = dim2(0, 6, 0, 26);
                            Size = dim2(1, 1, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });	Library:Themify(SubItems.Elements, "text_outline", "BackgroundColor3")   

                        Library:Create( "UIListLayout" , {
                            Parent = SubItems.Elements;
                            Padding = dim(0, 4);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                    --
                end 

                function Data.OpenTab() 
                    local Cache = Cfg.TabInfo
                    
                    if Cache then
                        Items.Fade.BackgroundTransparency = 0 
                        Library:Tween(Items.Fade, {BackgroundTransparency = 1})
                        Library:Tween(Cache.Fill, {BackgroundTransparency = 1})
                        Library:Tween(Cache.Background, {BackgroundTransparency = 0})
                        
                        Cache.Elements.Visible = false
                        Cache.Elements.Parent = Library.Other
                    end

                    Library:Tween(SubItems.Fill, {BackgroundTransparency = 0})
                    Library:Tween(SubItems.Background, {BackgroundTransparency = 1})

                    SubItems.Elements.Parent = Items.Elements
                    SubItems.Elements.Visible = true
                    
                    Cfg.TabInfo = SubItems
                end
                
                SubItems.Button.MouseButton1Down:Connect(function()
                    Data.OpenTab()
                end)
    
                if not Cfg.TabInfo then
                    print("new tab")
                    SubItems.Fill.Size = dim2(1, -2, 0, 1);
                    SubItems.TextPadding.PaddingRight = dim(0, 8);
                    Data.OpenTab()
                end

                Cfg.Store[#Cfg.Store + 1] = setmetatable(Data, Library)
            end

            return unpack(Cfg.Store)
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
                Items.Section = Library:Create( "Frame" , {
                    Parent = self.Items[Cfg.Side];
                    Name = "\0";
                    Size = dim2(1, 0, Cfg.Size or 0, -4);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Cfg.Size and Enum.AutomaticSize.None or Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Section, "outline", "BackgroundColor3")
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Size = dim2(1, -2, Cfg.Size and 1 or 0, -4);
                    Name = "\0";
                    Position = dim2(0, 1, 0, 4);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Cfg.Size and Enum.AutomaticSize.None or Enum.AutomaticSize.Y;
                    BackgroundColor3 = themes.preset.gradient
                });	Library:Themify(Items.Inline, "gradient", "BackgroundColor3")

                Items.Gradient = Library:Create( "Frame" , {
                    Parent = Items.Inline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Gradient;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Items.Elements = Library:Create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Inline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 6, 0, 20);
                    Size = dim2(1, -12, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if Cfg.Size then 
                    Items.ScrollingFrame = Library:Create( "ScrollingFrame" , {
                        Active = true;
                        ScrollingEnabled = true;
                        AutomaticCanvasSize = Enum.AutomaticSize.Y;
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        CanvasSize = dim2(0, 0, 0, 0);
                        ScrollBarImageColor3 = themes.preset.accent;
                        MidImage = "rbxassetid://120496541810421";
                        BorderColor3 = rgb(0, 0, 0);
                        ScrollBarThickness = 0;
                        Parent = Items.Inline;
                        Size = dim2(1, -3, 1, -23);
                        TopImage = "rbxassetid://118750478739322";
                        Position = dim2(0, 0, 0, 20);
                        BottomImage = "rbxassetid://74268315755026";
                        BackgroundTransparency = 1;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });	Library:Themify(Items.ScrollingFrame, "accent", "ScrollBarImageColor3")
                    
                    Items.ScrollingLine = Library:Create( "Frame" , {
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        AnchorPoint = vec2(1, 0);
                        Name = "\0";
                        Position = dim2(1, -2, 0, 19);
                        Parent = Items.Inline;
                        Size = dim2(0, 4, 1, -21);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.ScrollingLine, "outline", "BackgroundColor3")
                    
                    Items.Elements:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                        if Items.ScrollingFrame.AbsoluteSize.Y < Items.Elements.AbsoluteSize.Y then 
                            Items.ScrollingLine.Visible = true 
                            Library:Tween(Items.ScrollingFrame, {ScrollBarThickness = 2})
                            Library:Tween(Items.Elements, {Size = dim2(1, -14, 0, 0)})
                        else
                            Items.ScrollingLine.Visible = false
                            Library:Tween(Items.ScrollingFrame, {ScrollBarThickness = 0})
                            Library:Tween(Items.Elements, {Size = dim2(1, -10, 0, 0)})
                        end     
                    end)

                    Items.Elements.Parent = Items.ScrollingFrame
                    Items.Elements.Position = dim2(0, 6, 0, 0);
                end 

                Library:Create( "UIListLayout" , {
                    Parent = Items.Elements;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 5);
                    Parent = Items.Inline
                });
                
                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 0, 2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                
                Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Accent;
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                });
                
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Section;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 3);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                
                Items.UITitle = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Section;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 5, 0, 6);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });	Library:Themify(Items.UITitle, "text_outline", "BackgroundColor3")
                
                Library:Create( "UIStroke" , {
                    Parent = Items.UITitle;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 1);
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
                Callback = properties.Callback or function() end;

                -- Sub / Group Section
                Folding = properties.Folding or false;
                Collapsable = properties.Collapsing or true;

                Items = {};
            }

            local Items = Cfg.Items; do 
                Items.Object = Library:Create( "TextButton" , {
                    FontFace = Library.Font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.Items.GroupElements or self.Items.Elements;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 11);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                Items.Outline = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Object;
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 11, 0, 11);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")

                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                }); Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                Library:Themify(Items.Accent, "inline", "BackgroundColor3")
                Items.Accent.BackgroundColor3 = themes.preset.inline 

                Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Accent;
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                });

                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Object;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 15, 0, -2);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });

                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Object;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIListLayout" , {
                    Parent = Items.Components;
                    FillDirection = Enum.FillDirection.Horizontal;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Padding = dim(0, 4)
                }); 

                if Cfg.Folding then 
                    -- Object
                        Items.ArrowHolder = Library:Create( "Frame" , {
                            Parent = Items.Components;
                            BackgroundTransparency = 1;
                            Name = "\0";
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 7, 0, 7);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Items.Arrow = Library:Create( "ImageLabel" , {
                            ScaleType = Enum.ScaleType.Fit;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Items.ArrowHolder;
                            Name = "\0";
                            ResampleMode = Enum.ResamplerMode.Pixelated;
                            BackgroundTransparency = 1;
                            Size = dim2(0, 7, 1, 7);
                            Image = "rbxassetid://108270041153906";
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    --          
                    
                    -- Elements
                        Items.Group = Library:Create( "Frame" , {
                            LayoutOrder = 2;
                            BorderColor3 = rgb(0, 0, 0);
                            Parent = Library.Other;
                            Name = "\0";
                            Visible = false;
                            BackgroundTransparency = 1;
                            Position = dim2(0, 6, 0, 20);
                            Size = dim2(1, -12, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });

                        Items.Fade = Library:Create( "Frame" , {
                            Parent = Items.Group;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Size = dim2(1, 12, 1, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            ZIndex = 5;
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(40,40,40)
                        });	Library:Themify(Items.Fade, "gradient", "BackgroundColor3")  
                        
                        Items.GroupElements = Library:Create( "Frame" , {
                            Parent = Items.Group;
                            Name = "\0";
                            BackgroundTransparency = 1;
                            Size = dim2(1, 12, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.Y;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        Library:Create( "UIListLayout" , {
                            Parent = Items.GroupElements;
                            Padding = dim(0, 4);
                            SortOrder = Enum.SortOrder.LayoutOrder
                        });
                        
                        Library:Create( "UIPadding" , {
                            PaddingLeft = dim(0, 9);
                            Parent = Items.GroupElements
                        });
                        
                        Items.GroupLine = Library:Create( "Frame" , {
                            Parent = Items.Group;
                            Name = "\0";
                            Position = dim2(0, 2, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 3, 1, 0);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.outline
                        });	Library:Themify(Items.GroupLine, "outline", "BackgroundColor3")
                        
                        Library:Create( "UIGradient" , {
                            Rotation = 90;
                            Transparency = numseq{numkey(0, 1), numkey(0.05, 0), numkey(0.5, 0.018750011920928955), numkey(0.95, 0), numkey(1, 1)};
                            Parent = Items.GroupLine
                        });                
                    -- 
                end 
            end;
            
            function Cfg.Set(bool)
                Cfg.Callback(bool)

                Library:Tween(Items.Accent, {BackgroundColor3 = bool and themes.preset.accent or themes.preset.inline})
                
                Flags[Cfg.Flag] = bool
                
                if Cfg.Folding then
                    Items.Group.Visible = bool
                    Items.Group.Parent = bool and (self.Items.GroupElements or self.Items.Elements) or Library.Other
                    Items.Fade.BackgroundTransparency = 0
                    
                    Library:Tween(Items.Arrow or Items.Arrow, {Rotation = bool and 180 or 0})
                    Library:Tween(Items.Fade, {BackgroundTransparency = 1})
                end 
            end 
            
            Items.Object.MouseButton1Click:Connect(function()
                Cfg.Enabled = not Cfg.Enabled
                Cfg.Set(Cfg.Enabled)
            end)

            Cfg.Set(Cfg.Enabled)

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
                Items.Slider = Library:Create( "TextButton" , {
                    FontFace = Library.Font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.Items.GroupElements or self.Items.Elements;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 25);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Outline = Library:Create( "TextButton" , {
                    Parent = Items.Slider;
                    Text = "";
                    AutoButtonColor = false;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 14);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 11);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.outline
                });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                
                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                
                Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Accent;
                    Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                });
                
                Items.Value = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "0.1";
                    Parent = Items.Outline;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Value;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    Parent = Items.Value;
                    PaddingTop = dim(0, -1)
                });
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Slider;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Items.Components = Library:Create( "Frame" , {
                    Parent = Items.Slider;
                    Name = "\0";
                    Position = dim2(1, 0, 0, 2);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 11);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = Items.Components;
                    Padding = dim(0, 4);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                Items.Minus = Library:Create( "ImageButton" , {
                    ScaleType = Enum.ScaleType.Fit;
                    AutoButtonColor = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Components;
                    Image = "rbxassetid://120056247050601";
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(0, 7, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Plus = Library:Create( "ImageButton" , {
                    ScaleType = Enum.ScaleType.Fit;
                    AutoButtonColor = false;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = Items.Components;
                    Image = "rbxassetid://120458671764177";
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(0, 7, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Interval = Library:Create( "TextLabel" , {
                    LayoutOrder = -1;
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Intervals;
                    Parent = Items.Components;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Interval;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Library:Create( "UIPadding" , {
                    Parent = Items.Interval;
                    PaddingTop = dim(0, -1)
                });                          
            end 

            function Cfg.Set(value)
                Cfg.Value = math.clamp(Library:Round(value, Cfg.Intervals), Cfg.Min, Cfg.Max)

                Items.Accent.Size = dim2((Cfg.Value - Cfg.Min) / (Cfg.Max - Cfg.Min), Cfg.Value == Cfg.Min and 0 or -2, 1, -2)
                Items.Value.Text = tostring(Cfg.Value) .. Cfg.Suffix

                Flags[Cfg.Flag] = Cfg.Value
                Cfg.Callback(Flags[Cfg.Flag])
            end
            
            Items.Outline.MouseButton1Down:Connect(function()
                Cfg.Dragging = true 
            end)

            Items.Minus.MouseButton1Down:Connect(function()
                Cfg.Value -= Cfg.Intervals

                Cfg.Set(Cfg.Value)
            end)

            Items.Plus.MouseButton1Down:Connect(function()
                Cfg.Value += Cfg.Intervals

                Cfg.Set(Cfg.Value)
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
                    Items.Dropdown = Library:Create( "TextButton" , {
                        FontFace = Library.Font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.Items.GroupElements or self.Items.Elements;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 32);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Items.Outline = Library:Create( "TextButton" , {
                        Parent = Items.Dropdown;
                        AutoButtonColor = false;
                        Text = "";
                        Name = "\0";
                        Position = dim2(0, 0, 0, 14);
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

                    Items.InnerText = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Closest";
                        Parent = Items.Background;
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        BackgroundTransparency = 1;
                        Position = dim2(0, 3, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.InnerText;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Background;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");

                    Items.Icon = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Multi and "..." or "-";
                        Parent = Items.Background;
                        Name = "\0";
                        AnchorPoint = vec2(1, 0);
                        Size = dim2(0, 0, 1, 0);
                        BackgroundTransparency = 1;
                        Position = dim2(1, -4, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Icon;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });

                    Items.Name = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = Cfg.Name;
                        Parent = Items.Dropdown;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    Library:Create( "UIStroke" , {
                        Parent = Items.Name;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                -- 
                
                -- Element Holder
                    Items.DropdownElements = Library:Create( "Frame" , {
                        Parent = Library.Other;
                        Size = dim2(0, 0, 0, 0);
                        Name = "\0";
                        Position = dim2(0.30000001192092896, 0, 0.5, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.DropdownElements, "outline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.DropdownElements;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.Inline, "inline", "BackgroundColor3")
                    
                    Items.DropdownHolder = Library:Create( "Frame" , {
                        Parent = Items.Inline;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.DropdownHolder;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.DropdownHolder;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });                
                -- 
            end 

            function Cfg.RenderOption(text)
                local Button = Library:Create( "TextButton" , {
                    FontFace = Library.Font;
                    TextColor3 = rgb(179, 179, 179);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = Items.DropdownHolder;
                    Name = "\0";
                    ZIndex = 999;
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Button;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
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
                if Library.OpenElement ~= Cfg then 
                    Library:CloseElement()
                end

                Items.DropdownElements.Position = dim2(0, Items.Outline.AbsolutePosition.X, 0, Items.Outline.AbsolutePosition.Y + 80)
				Items.DropdownElements.Size = dim_offset(Items.Outline.AbsoluteSize.X + 1, 0)
                Items.DropdownElements.Visible = bool 
                Items.DropdownElements.Parent = bool and Library.Items or Library.Other; 

                if not Cfg.Multi then 
                    Items.Icon.Text = bool and "+" or "-"
                end

                -- Cfg.Tween(bool)
                
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
                        option.TextColor3 = rgb(179, 179, 179)
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

            function Cfg.Tween(bool) 
                if Cfg.Tweening == true then 
                    return 
                end 

                Cfg.Tweening = true 

                if bool then 
                    Items.DropdownElements.Visible = true
                    Items.DropdownElements.Parent = Library.Items
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
                            Tween = Library:Fade(obj, prop, bool, 0.1)
                        end
                    else
                        Tween = Library:Fade(obj, Index, bool, 0.1)
                    end
                end

                task.delay(0.09, function() 
                    Cfg.Tweening = false
                    Items.DropdownElements.Visible = bool
                    Items.DropdownElements.Parent = bool and Library.Items or Library.Other
                end)
            end

            Items.Outline.MouseButton1Click:Connect(function()
                Cfg.Open = not Cfg.Open 

                Cfg.SetVisible(Cfg.Open)
            end)

            Library:Connection(InputService.InputBegan, function(input, game_event)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    print("clicked")
                    if (Items.DropdownElements.Visible) and not Library:Hovering({Items.DropdownElements, Items.Dropdown}) then
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
                Items.Label = Library:Create( "TextButton" , {
                    LayoutOrder = 1;
                    FontFace = Library.Font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.Items.Elements;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 11);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Label;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
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
                    Parent = Items.Components;
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right
                });                
            end 

            function Cfg.Set(Text)
                Items.Name.Text = Text
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
                Items.Textbox = Library:Create( "TextButton" , {
                    FontFace = Library.Font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.Items.GroupElements or self.Items.Elements;
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 32);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Outline = Library:Create( "Frame" , {
                    Parent = Items.Textbox;
                    Name = "\0";
                    Position = dim2(0, 0, 0, 14);
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
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Items.Input = Library:Create( "TextBox" , {
                    FontFace = Library.Font;
                    ClearTextOnFocus = false;
                    Active = false;
                    Selectable = false;
                    PlaceholderColor3 = themes.preset.text_color;
                    PlaceholderText = "Hi!";
                    TextSize = 12;
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    Size = dim2(1, 0, 1, 0);
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Default;
                    Parent = Items.Background;
                    TextXAlignment= Enum.TextXAlignment.Left;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 3, 0, 0);
                    CursorPosition = -1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Input;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Textbox;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
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
                Name = properties.Name or nil; 

                Key = properties.Key or nil;
                Mode = properties.Mode or "Toggle";
                Active = properties.Default or false; 
                
                Show = properties.ShowInList or true;

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
                        Parent = self.Items.Components;
                        AutoButtonColor = false;
                        Text = "";
                        Name = "\0";
                        Size = dim2(0, 10, 0, 11);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.KeybindOutline, "inline", "BackgroundColor3")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.KeybindOutline;
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = themes.preset.background
                    });	Library:Themify(Items.Inline, "background", "BackgroundColor3")
                    
                    Items.Key = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "MB2";
                        Parent = Items.Inline;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIStroke" , {
                        Parent = Items.Key;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });
                    
                    Library:Create( "UIPadding" , {
                        Parent = Items.Key;
                        PaddingTop = dim(0, -2);
                        PaddingRight = dim(0, 2);
                        PaddingLeft = dim(0, 4)
                    });
                    
                    Library:Create( "UIPadding" , {
                        PaddingRight = dim(0, 2);
                        Parent = Items.KeybindOutline
                    });                  
                -- 
                
                -- Mode Holder
                    Items.ModeHolder = Library:Create( "Frame" , {
                        Parent = Library.Items;
                        Size = dim2(0, 150, 0, 44);
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundColor3 = themes.preset.inline
                    });	Library:Themify(Items.ModeHolder, "inline", "BackgroundColor3")
                    
                    Items.UIStroke = Library:Create( "UIStroke" , {
                        Color = themes.preset.outline;
                        LineJoinMode = Enum.LineJoinMode.Miter;
                        Parent = Items.ModeHolder
                    });	Library:Themify(Items.UIStroke, "outline", "Color")
                    
                    Items.Inline = Library:Create( "Frame" , {
                        Parent = Items.ModeHolder;
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Inline;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");
                    
                    Items.Elements = Library:Create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Items.Inline;
                        AnchorPoint = vec2(0, 0.5);
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 5, 0.5, 0);
                        Size = dim2(1, -10, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Library:Create( "UIListLayout" , {
                        Parent = Items.Elements;
                        Padding = dim(0, 4);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    Items.Accent = Library:Create( "Frame" , {
                        Name = "\0";
                        Parent = Items.ModeHolder;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.accent
                    });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")
                    
                    Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Accent;
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(158, 158, 158))}
                    });
                    
                    Items.Outline = Library:Create( "Frame" , {
                        Parent = Items.ModeHolder;
                        Name = "\0";
                        Position = dim2(0, 0, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = themes.preset.outline
                    });	Library:Themify(Items.Outline, "outline", "BackgroundColor3")
                    
                    Items.Fade = Library:Create( "Frame" , {
                        Parent = Items.ModeHolder;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    local gradient = Library:Create( "UIGradient" , {
                        Rotation = 90;
                        Parent = Items.Fade;
                        Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                    }); Library:SaveGradient(gradient, "Selected");

                    Items.Dropdown = setmetatable(Cfg, Library):Dropdown({Name = "Mode", Options = {"Hold", "Toggle", "Always"}, Flag = Cfg.Flag .. "OPTION_SETTINGS", Callback = function(options)
                        if Cfg.Set then 
                            Cfg.Set(options)
                        end
                    end})
                --
                
                if Cfg.Show then
                    Items.Keybinds = Library:Create( "TextLabel" , {
                        FontFace = Library.Font;
                        TextColor3 = themes.preset.text_color;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = Library.KeybindParent;
                        Name = "\0";
                        AutomaticSize = Enum.AutomaticSize.XY;
                        BackgroundTransparency = 1;
                        BorderSizePixel = 0;
                        RichText = true;
                        Visible = false;
                        ZIndex = 2;
                        TextSize = 12;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    Items.KeybindsStroke = Library:Create( "UIStroke" , {
                        Parent = Items.Keybinds;
                        LineJoinMode = Enum.LineJoinMode.Miter
                    });                    
                end 
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

                Items.Key.Text = __text

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
                Items.Fade.BackgroundTransparency = 0
                Library:Tween(Items.Fade, {BackgroundTransparency = 1})

                Items.ModeHolder.Visible = bool 
                Items.ModeHolder.Position = dim2(0, Items.KeybindOutline.AbsolutePosition.X + 2, 0, Items.KeybindOutline.AbsolutePosition.Y + 74)
            end

            Items.KeybindOutline.MouseButton1Down:Connect(function()
                task.wait()
                Items.Key.Text = "..."	

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
                    if (Items.Dropdown.Items.DropdownElements.Visible and Items.ModeHolder.Visible) and not (Library:Hovering(Items.Dropdown.Items.DropdownElements) or Library:Hovering(Items.ModeHolder)) then 
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
                Items.Button = Library:Create( "TextButton" , {
                    FontFace = Library.Font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.Items.GroupElements or self.Items.Elements;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Items.Outline = Library:Create( "Frame" , {
                    Name = "\0";
                    Parent = Items.Button;
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
                
                local gradient = Library:Create( "UIGradient" , {
                    Rotation = 90;
                    Parent = Items.Background;
                    Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                }); Library:SaveGradient(gradient, "Selected");
                
                Items.Name = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    TextColor3 = themes.preset.text_color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Parent = Items.Background;
                    Name = "\0";
                    Size = dim2(1, 0, 1, 0);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 3, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 12;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                Library:Create( "UIStroke" , {
                    Parent = Items.Name;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });                                  
            end 

            Items.Button.MouseButton1Click:Connect(function()
                Items.Name.TextColor3 = rgb(255, 255, 255)
                Library:Tween(Items.Name, {TextColor3 = themes.preset.text_color})
                
                Cfg.Callback()
            end)
            
            return setmetatable(Cfg, Library)
        end

        function Library:Configs(window) 
            local Text;
            local ConfigText; 

            local Tab = window:Tab({Name = "Settings"})

            local Section = Tab:Section({Name = "Main", Side = "Left"})
            ConfigHolder = Section:Dropdown({Name = "Configs", Options = {"Report", "This", "Error", "To", "Finobe"}, Callback = function(option) if Text then Text.Set(option) end end, Flag = "config_Name_list"}); Library:UpdateConfigList()
            window.Tweening = true
            Text = Section:Textbox({Name = "Config Name:", Flag = "config_Name_text", Callback = function(text)
                ConfigText = text
            end})
            window.Tweening = false
            Section:Button({Name = "Save", Callback = function() 
                writefile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg", Library:GetConfig())
                Library:UpdateConfigList()
                Notifications:Create({Name = "Saved Config (" ..  Library.Directory .. "/configs/" .. ConfigText .. ".cfg" .. ")"}) 
            end})

            Section:Button({Name = "Load", Callback = function() 
                Library:LoadConfig(readfile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg"))  
                Library:UpdateConfigList() 
                Notifications:Create({Name = "Loaded Config (" ..  Library.Directory .. "/configs/" .. ConfigText .. ".cfg" .. ")"}) 
            end})

            Section:Button({Name = "Delete", Callback = function() 
                delfile(Library.Directory .. "/configs/" .. ConfigText .. ".cfg")  
                Library:UpdateConfigList() 
                Notifications:Create({Name = "Deleted Config (" ..  Library.Directory .. "/configs/" .. ConfigText .. ".cfg" .. ")"}) 
            end})

            window.Tweening = true
            Section:Label({Name = "Menu Bind"}):Keybind({Name = "Menu Bind", ShowInList = false, Callback = function(bool) 
                if window.Tweening then
                    return 
                end 

                window.ToggleMenu(bool) 
            end, Default = true})

            delay(2, function() window.Tweening = false end)

            local Section = Tab:Section({Name = "Other", Side = "Right"})
            Section:Toggle({Name = "Watermark", Flag = "Watermark", Callback = window.ToggleWatermark})
            Section:Toggle({Name = "Keybind List", Flag = "KeybindList", Callback = window.ToggleKeybindList})
            Section:Toggle({Name = "Toggle Status", Flag = "Status", Callback = window.ToggleStatus})
            Section:Textbox({Name = "Custom Menu Name", Callback = window.ChangeTitle, Default = window.Name, Placeholder = "Title name here..."})
            Section:Textbox({Name = "Custom Watermark Name", Callback = window.ChangeWatermarkTitle, Default = window.Name .. ".lua", Placeholder = "Title name here..."})
            Section:Dropdown({Name = "Tweening Style", Options = {"Linear", "Sine", "Back", "Quad", "Quart", "Quint", "Bounce", "Elastic", "Exponential", "Circular", "Cubic"}, Flag = "LibraryEasingStyle", Default = "Quint", Callback = function(Option)
                Library.EasingStyle = Enum.EasingStyle[Option]
            end});
            Section:Slider({Name = "Tweening Speed", Min = 0, Max = 10, Decimal = 0.01, Suffix = "s", Default = 0.25, Flag = "TweeningSpeed", Callback = function(int)
                Library.TweeningSpeed = int
            end})

            Section:Label({Name = "Inline"}):Colorpicker({Flag = "Inline", Callback = function(color, alpha) 
                Library:RefreshTheme("inline", color) 

                for _,seq in themes.gradients.Selected do 
                    seq.Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                end 
            end, Color = themes.preset.inline})

            Section:Label({Name = "Gradient"}):Colorpicker({Flag = "Gradient", Callback = function(color, alpha) 
                Library:RefreshTheme("gradient", color)

                for _,seq in themes.gradients.Selected do 
                    seq.Color = rgbseq{rgbkey(0, themes.preset.inline), rgbkey(1, themes.preset.gradient)}
                end

                for _,seq in themes.gradients.Deselected do 
                    seq.Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                end
            end, Color = themes.preset.gradient})
            
            Section:Label({Name = "Outline"}):Colorpicker({Flag = "Outline", Callback = function(color, alpha) 
                Library:RefreshTheme("outline", color) 
            end, Color = themes.preset.outline})
            
            Section:Label({Name = "Accent"}):Colorpicker({Flag = "Accent", Callback = function(color, alpha) 
                Library:RefreshTheme("accent", color) 
            end, Color = themes.preset.accent})
            
            Section:Label({Name = "Background"}):Colorpicker({Flag = "Background", Callback = function(color, alpha) 
                Library:RefreshTheme("background", color) 

                for _,seq in themes.gradients.Deselected do 
                    seq.Color = rgbseq{rgbkey(0, themes.preset.gradient), rgbkey(1, themes.preset.background)}
                end
            end, Color = themes.preset.background})
            
            Section:Label({Name = "Text Color"}):Colorpicker({Flag = "Text Color", Callback = function(color, alpha) 
                Library:RefreshTheme("text_color", color) 
            end, Color = themes.preset.text_color})
            
            Section:Label({Name = "Text Outline"}):Colorpicker({Flag = "Text Outline", Callback = function(color, alpha) 
                Library:RefreshTheme("text_outline", color) 
            end, Color = themes.preset.text_outline})
            
            Section:Label({Name = "Background"}):Colorpicker({Flag = "Background", Callback = function(color, alpha) 
                Library:RefreshTheme("tab_background", color) 
            end, Color = themes.preset.tab_background})
            
            

        end
    --

    -- Notification Library
        -- IGNORE: , TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
        function Notifications:RefreshNotifications() 
            local offset = 50
            
            for i, v in Notifications.Notifs do
                local Position = vec2(20, offset)
                Library:Tween(v, {Position = dim_offset(Position.X, Position.Y)})
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function Notifications:FadeNotifs(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            Library:Tween(path, {BackgroundTransparency = fading})

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        Library:Tween(instance, {Transparency = fading})
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    Library:Tween(instance, {TextTransparency = fading})
                elseif instance:IsA("Frame") then
                    Library:Tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6})
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
                    Size = dim2(0, 0, 0, 18);
                    Name = "\0";
                    AnchorPoint = vec2(1, 0);
                    Position = dim2(0, 7, 0, 46);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(52, 52, 52)
                });
                
                Items.Inline = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    BackgroundColor3 = rgb(5, 5, 5)
                });
                
                Library:Create( "UIPadding" , {
                    PaddingTop = dim(0, 7);
                    PaddingBottom = dim(0, 6);
                    Parent = Items.Inline;
                    PaddingRight = dim(0, 8);
                    PaddingLeft = dim(0, 4)
                });
                
                Items.Text = Library:Create( "TextLabel" , {
                    FontFace = Library.Font;
                    Parent = Items.Inline;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = Cfg.Name;
                    Name = "\0";
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
                
                Library:Create( "UIPadding" , {
                    PaddingBottom = dim(0, 1);
                    PaddingRight = dim(0, 1);
                    Parent = Items.Outline
                });
                
                Items.AccentLine = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    Position = dim2(0, 2, 1, -1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -1, 0, 1);
                    BorderSizePixel = 0;
                    ZIndex = 100;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.AccentLine, "accent", "BackgroundColor3")
                
                Items.Accent = Library:Create( "Frame" , {
                    Parent = Items.Outline;
                    Name = "\0";
                    ZIndex = 100;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, -1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });	Library:Themify(Items.Accent, "accent", "BackgroundColor3")                    
            end 
            
            local index = #Notifications.Notifs + 1
            Notifications.Notifs[index] = Items.Outline

            -- Notifications:FadeNotifs(Items.Outline, false)
            
            local offset = Notifications:RefreshNotifications()

            Items.Outline.Position = dim_offset(20, offset)

            Library:Tween(Items.Outline, {AnchorPoint = vec2(0, 0)})
            Library:Tween(Items.AccentLine, {Size = dim2(0, -2, 0, 1)}, TweenInfo.new(Cfg.Lifetime, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0))

            print(Items.AccentLine.BackgroundTransparency)
            task.spawn(function()
                task.wait(Cfg.Lifetime)
                Notifications.Notifs[index] = nil
                Notifications:FadeNotifs(Items.Outline, true)
                Library:Tween(Items.Outline, {AnchorPoint = vec2(1, 0)})
                task.wait(1)
                Items.Outline:Destroy() 
            end)
        end
    --
-- 

return Library, Notifications, themes
