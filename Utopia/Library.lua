--[[
    Made by samet.exe

    Assign different flags to each element to prevent from configs overriding eachother
    Example script is at the bottom

    Documentation:
        function Library:Window(Data: table
        Name/name: string,
        Size/size: UDim2,
        GradientTitle/gradienttitle: table
    )

    function Window:Page(Data: table
        Name/name: string,
        Columns/columns: number
    )

    function Page:Section(Data: table
        Name/name: string,
        Side/side: number,
    )

    function Page:Playerlist()

    function Section:Label(Data: table
        Name/name: string,
        Alignment/alignment: string
    )

    function Section:Toggle(Data: table
        Name/name: string,
        Default/default: boolean,
        Flag/flag: string,
        Risky/risky: boolean,
        Callback/callback: function
    )

    function Section:Button(Data: table
        Name/name: string,
        Risky/risky: boolean,
        Callback/callback: function
    )

    function Section:Slider(Data: table
        Name/name: string,
        Min/min: number,
        Max/max: number,
        Decimals/decimals: number,
        Default/default: number,
        Suffix/suffix: string,
        Flag/flag: string,
        Callback/callback: function
    )

    function Section:Textbox(Data: table
        Name/name: string,
        Default/default: string,
        Placeholder/placeholder: string,
        Flag/flag: string,
        Callback/callback: function
    )

    function Section:Dropdown(Data: table
        Name/name: string,
        Items/items: table,
        Default/default: string,
        MaxSize/maxsize: number,
        Flag/flag: string,
        Multi/multi: boolean,
        Callback/callback: function
    )

    function Section:Listbox(Data: table
        Size/size: number,
        Items/items: table,
        Default/default: string,
        Multi/multi: boolean,
        Flag/flag: string,
        Callback/callback: function
    )

    function Label:Keybind(Data: table
        Name/name: string,
        Mode/mode: string,
        Default/default: EnumItem,
        Flag/flag: string,
        Callback/callback: function
    )

    function Label:Colorpicker(Data: table
        Name/name: string,
        Default/default: Color3,
        Alpha/alpha: number,
        Flag/flag: string,
        Callback/callback: function
    )

    function Toggle:Colorpicker(Data: table
        Name/name: string,
        Default/default: Color3,
        Alpha/alpha: number,
        Flag/flag: string,
        Callback/callback: function
    )

    function Toggle:Keybind(Data: table
        Name/name: string,
        Mode/mode: string,
        Default/default: EnumItem,
        Flag/flag: string,
        Callback/callback: function
    )

    function Sections:Textbox(Data: table
        Name/name: string,
        Default/default: string,
        Placeholder/placeholder: string,
        Flag/flag: string,
        Callback/callback: function
    )

    function Library:Watermark(Text: string)
    function Library:Notification(Text: string, Duration: number, Color: Color3, Icon: table)
    function Library:KeybindList()
]]

local LoadingTick = os.clock()

if getgenv().Library then 
    getgenv().Library:Unload()
end

local Library do 
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local Vector2New = Vector2.new

    local InstanceNew = Instance.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub

    Library = {
        Flags = { },

        MenuKeybind = tostring(Enum.KeyCode.Z), 

        Tween = {
            Time = 0.25,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.Out
        },

        Folders = {
            Directory = "testpath",
            Configs = "testpath/Configs",
            Assets = "testpath/Assets",
            Themes = "testpath/Themes"
        },

        Images = { -- you're welcome to reupload the images and replace it with your own links
            ["Saturation"] = {"Saturation.png", "https://github.com/sametexe001/images/blob/main/saturation.png?raw=true" },
            ["Value"] = { "Value.png", "https://github.com/sametexe001/images/blob/main/value.png?raw=true" },
            ["Hue"] = { "Hue.png", "https://github.com/sametexe001/images/blob/main/horizontalhue.png?raw=true" },
            ["Checkers"] = { "Checkers.png", "https://github.com/sametexe001/images/blob/main/checkers.png?raw=true" },
        },

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        Themes = { },
        
        CurrentFrames = { },

        ThemeColorpickers = { },

        SetFlags = { },

        CopiedColor = nil,

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Holder = nil,
        NotifHolder = nil,
        Font = nil,
        KeyList = nil,
    }

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    Library.__index = Library
    
    Library.Pages.__index = Library.Pages
    Library.Sections.__index = Library.Sections

    for _, FileName in Library.Folders do
        if not isfolder(FileName) then
            makefolder(FileName)
        end
    end

    for _, Image in Library.Images do
        if not isfile(Library.Folders.Assets .. "/" .. Image[1]) then
            writefile(Library.Folders.Assets .. "/" .. Image[1], game:HttpGet(Image[2]))
        end
    end

    local Themes = {
        ["Default"] = {
            ["Window Background"] = FromRGB(43, 43, 43),
            ["Inline"] = FromRGB(12, 12, 12),
            ["Text"] = FromRGB(180, 180, 180),
            ["Section Background"] = FromRGB(19, 19, 19),
            ["Element"] = FromRGB(63, 63, 63),
            ["Border"] = FromRGB(68, 68, 68),
            ["Outline"] = FromRGB(0, 0, 0),
            ["Dark Liner"] = FromRGB(56, 56, 56),
            ["Risky"] = FromRGB(255, 50, 50),
            ["Accent"] = FromRGB(31, 226, 130)
        },

        ["Bitchbot"] = {
            ["Window Background"] = FromRGB(33, 33, 33),
            ["Inline"] = FromRGB(14, 14, 14),
            ["Text"] = FromRGB(255, 255, 255),
            ["Section Background"] = FromRGB(18, 18, 18),
            ["Element"] = FromRGB(14, 14, 14),
            ["Border"] = FromRGB(0, 0, 0),
            ["Outline"] = FromRGB(19, 19, 19),
            ["Dark Liner"] = FromRGB(21, 21, 21),
            ["Risky"] = FromRGB(255, 50, 50),
            ["Accent"] = FromRGB(158, 79, 249)
        },

        ["Onetap"] = {
            ["Window Background"] = FromRGB(71, 71, 71),
            ["Inline"] = FromRGB(30, 30, 30),
            ["Text"] = FromRGB(244, 239, 232),
            ["Section Background"] = FromRGB(20, 20, 20),
            ["Element"] = FromRGB(33, 33, 33),
            ["Border"] = FromRGB(0, 0, 0),
            ["Outline"] = FromRGB(51, 51, 51),
            ["Dark Liner"] = FromRGB(22, 22, 20),
            ["Risky"] = FromRGB(255, 50, 50),
            ["Accent"] = FromRGB(237, 170, 0)
        },

        ["Aqua"] = {
            ["Window Background"] = FromRGB(71, 84, 99),
            ["Inline"] = FromRGB(31, 35, 39),
            ["Text"] = FromRGB(255, 255, 255),
            ["Section Background"] = FromRGB(22, 25, 28),
            ["Element"] = FromRGB(58, 66, 77),
            ["Border"] = FromRGB(48, 56, 63),
            ["Outline"] = FromRGB(20, 25, 30),
            ["Dark Liner"] = FromRGB(38, 45, 53),
            ["Risky"] = FromRGB(255, 50, 50),
            ["Accent"] = FromRGB(104, 214, 255)
        }
    }

    Library.Theme = TableClone(Themes["Default"])
    Library.Themes = Themes

    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.MakeDraggable = function(self)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Dragging = false 
            local DragStart
            local StartPosition 

            local Set = function(Input)
                local DragDelta = Input.Position - DragStart
                self:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(StartPosition.X.Scale, StartPosition.X.Offset + DragDelta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + DragDelta.Y)})
            end

            self:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true

                    DragStart = Input.Position
                    StartPosition = Gui.Position
                end
            end)

            self:Connect("InputEnded", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                    if Dragging then
                        Set(Input)
                    end
                end
            end)

            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local Gui = self.Instance

            local Resizing = false 
            local Start = UDim2New()
            local Delta = UDim2New()
            local ResizeMax = Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

            local ResizeButton = Instances:Create("TextButton", {
				Parent = Gui,
				AnchorPoint = Vector2New(1, 1),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(0, 8, 0, 8),
				Position = UDim2New(1, 0, 1, 0),
                Name = "\0",
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				AutoButtonColor = false,
                Visible = true,
                Text = ""
			})

            ResizeButton:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Resizing = true

                    Start = Gui.Size - UDim2New(0, Input.Position.X, 0, Input.Position.Y)
                end
            end)

            ResizeButton:Connect("InputEnded", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Resizing = false
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseMovement and Resizing then
					ResizeMax = Maximum or Gui.Parent.AbsoluteSize - Gui.AbsoluteSize

					Delta = Start + UDim2New(0, Input.Position.X, 0, Input.Position.Y)
					Delta = UDim2New(0, math.clamp(Delta.X.Offset, Minimum.X, ResizeMax.X), 0, math.clamp(Delta.Y.Offset, Minimum.Y, ResizeMax.Y))

					Tween:Create(Gui, TweenInfo.new(0.17, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = Delta}, true)
                end
            end)

            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end

        Instances.Tooltip = function(self, Text)
            if not self.Instance then 
                return
            end

            if Text == nil then 
                return
            end

            local Gui = self.Instance

            local MouseLocation = UserInputService:GetMouseLocation()
            local RenderStepped

            local Tooltip = Instances:Create("Frame", {
                Parent = Library.Holder.Instance,
                BackgroundColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                Size = UDim2New(0, 0, 0, 22),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 22),
                Visible = true,
            })

            local TooltipText = Instances:Create("TextLabel", {
                Parent = Tooltip.Instance,
                BackgroundColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 0),
                FontFace = Library.Font,
                Text = Text,
                TextTransparency = 1,
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 12,
            })  TooltipText:AddToTheme({TextColor3 = "Text"})

            Instances:Create("UIPadding", {
                Parent = TooltipText.Instance,
                PaddingLeft = UDimNew(0, 5),
                PaddingRight = UDimNew(0, 5)
            })

            Library:Connect(Gui.MouseEnter, function()
                Tooltip:Tween(nil, {BackgroundTransparency = 0})
                TooltipText:Tween(nil, {TextTransparency = 0})

                RenderStepped = RunService.RenderStepped:Connect(function()
                    MouseLocation = UserInputService:GetMouseLocation()
                    Tooltip:Tween(nil, {Position = UDim2New(0, MouseLocation.X, 0, MouseLocation.Y - 22)})
                end)
            end)

            Library:Connect(Gui.MouseLeave, function()
                Tooltip:Tween(nil, {BackgroundTransparency = 1})
                TooltipText:Tween(nil, {TextTransparency = 1})

                if RenderStepped then 
                    RenderStepped:Disconnect()
                end
            end)

            return Tooltip
        end
    end

    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end

            if not isfile(Library.Folders.Assets .. "/" .. Name .. ".ttf") then 
                writefile(Library.Folders.Assets .. "/" .. Name .. ".ttf", game:HttpGet(Data.Url))
            end

            local FontData = {
                name = Name,
                faces = { {
                    name = "Regular",
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".ttf")
                } }
            }

            writefile(Library.Folders.Assets .. "/" .. Name .. ".json", HttpService:JSONEncode(FontData))
            return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
        end

        function CustomFont:Get(Name)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end
        end

        CustomFont:New("Windows-XP-Tahoma", 200, "Regular", {
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/windows-xp-tahoma.ttf"
        })

        Library.Font = CustomFont:Get("Windows-XP-Tahoma")
    end

    Library.Holder = Instances:Create("ScreenGui", {
        Parent = gethui(),
        Name = "\0",
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        IgnoreGuiInset = true
    })

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.Holder.Instance,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0.5, 0),
        BackgroundTransparency = 1,
        Position = UDim2New(0.5, 0, 0, 0),
        Name = "\0",
        Size = UDim2New(0.34, 0, 1, -14),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(255, 255, 255)
    }) 

    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        Padding = UDimNew(0, 10)
    }) 

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    Library.IsMouseOverFrame = function(self, Frame)
        local AbsolutePosition = Frame.AbsolutePosition
        local AbsoluteSize = Frame.AbsoluteSize

        if Mouse.X >= AbsolutePosition.X and Mouse.X <= AbsolutePosition.X + AbsoluteSize.X and Mouse.Y >= AbsolutePosition.Y and Mouse.Y <= AbsolutePosition.Y + AbsoluteSize.Y then    
            return true
        end
    end

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            Value.Connection:Disconnect()
        end

        for Index, Value in self.Threads do 
            coroutine.close(Value)
        end

        if self.Holder then 
            self.Holder:Clean()
        end

        Library = nil 
        getgenv().Library = nil
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)

        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            Library:Notification("Error caught in function, report this to the devs:\n"..Result, 5, FromRGB(255, 0, 0))
            warn(Result)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("Connection_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("Flag Number %s %s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)

        if Success then 
            Library:Notification("Successfully loaded config", 5, FromRGB(0, 255, 0))
        end
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then 
            delfile(Library.Folders.Configs .. "/" .. Config)
            Library:Notification("Deleted config " .. Config .. ".json", 5, FromRGB(0, 255, 0))
        end
    end

    Library.SaveConfig = function(self, Config)
        if isfile(Library.Folders.Configs .. "/" .. Config) then
            writefile(Library.Folders.Configs .. "/" .. Config, Library:GetConfig())
            Library:Notification("Saved config " .. Config .. ".json", 5, FromRGB(0, 255, 0))
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ConfigFolderName = StringGSub(Library.Folders.Configs, Library.Folders.Directory .. "/", "")

        for Index, Value in listfiles(Library.Folders.Configs) do
            local FileName = StringGSub(Value, Library.Folders.Directory .. "\\" .. ConfigFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.GetTheme = function(self)
        local Theme = { } 

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Library.Flags do 
                if type(Value) == "table" and Value.Color and StringFind(Value.Flag, "Theme") then
                    Theme[Index] = {Color = Value.HexValue, Alpha = Value.Alpha}
                else
                end
            end
        end)

        return HttpService:JSONEncode(Theme)
    end

    Library.LoadTheme = function(self, Theme)
        local Decoded = HttpService:JSONDecode(Theme)

        local Success, Result = Library:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = Library.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                end
            end
        end)

        if Success then 
            Library:Notification("Successfully loaded theme", 5, FromRGB(0, 255, 0))
        end
    end

    Library.DeleteTheme = function(self, Theme)
        if isfile(Library.Folders.Themes .. "/" .. Theme) then 
            delfile(Library.Folders.Themes .. "/" .. Theme)
            Library:Notification("Deleted theme " .. Theme .. ".json", 5, FromRGB(0, 255, 0))
        end
    end

    Library.SaveTheme = function(self, Theme)
        if isfile(Library.Folders.Themes .. "/" .. Theme) then
            writefile(Library.Folders.Themes .. "/" .. Theme, Library:GetTheme())
            Library:Notification("Saved theme " .. Theme .. ".json", 5, FromRGB(0, 255, 0))
        end
    end

    Library.RefreshThemeList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ThemeFolderName = StringGSub(Library.Folders.Themes, Library.Folders.Directory .. "/", "")

        for Index, Value in listfiles(Library.Folders.Themes) do
            local FileName = StringGSub(Value, Library.Folders.Directory .. "\\" .. ThemeFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.ToRich = function(self, Text, Color)
        return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                end
            end
        end
    end

    Library.Watermark = function(self, Text, Icon)
        local Watermark = { }

        local Items = { } do
            Items["Watermark"] = Instances:Create("Frame", {
                Parent = Library.Holder.Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0.5, 0),
                Name = "\0",
                Position = UDim2New(0.5, 0, 0, 20),
                Size = UDim2New(0, 0, 0, 25),
                BorderSizePixel = 2,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = FromRGB(12, 12, 12)
            })  Items["Watermark"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Items["Watermark"]:MakeDraggable()

            Instances:Create("UIStroke", {
                Parent = Items["Watermark"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Watermark"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Text,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(0, 0, 1, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Instances:Create("UIPadding", {
                Parent = Items["Watermark"].Instance,
                PaddingRight = UDimNew(0, 8),
                PaddingLeft = UDimNew(0, 8)
            }) 

            Items["Liner"] = Instances:Create("Frame", {
                Parent = Items["Watermark"].Instance,
                Name = "\0",
                Position = UDim2New(0, -8, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 16, 0, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Accent"})

            Instances:Create("UIGradient", {
                Parent = Items["Liner"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(94, 94, 94))}
            }) 

            if Icon then 
                if type(Icon) == "table" then
                    Items["Icon"] = Instances:Create("ImageLabel", {
                        Parent = Items["Watermark"].Instance,
                        ImageColor3 = Icon[2] or FromRGB(255, 255, 255),
                        ScaleType = Enum.ScaleType.Fit,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Name = "\0",
                        Image = "rbxassetid://" .. Icon[1],
                        BackgroundTransparency = 1,
                        Position = UDim2New(0, -3, 0, 4),
                        Size = UDim2New(0, 18, 0, 18),
                        BorderSizePixel = 0,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    }) 

                    Items["Text"].Instance.Position = UDim2New(0, 20, 0, 0)
                end
            end
        end

        function Watermark:SetVisibility(Bool)
            Items["Watermark"].Instance.Visible = Bool
        end

        return Watermark
    end

    Library.KeybindList = function(self)
        local KeybindList = { }
        Library.KeyList = KeybindList

        local Items = { } do 
            Items["KeybindListOutline"] = Instances:Create("Frame", {
                Parent = Library.Holder.Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(0, 20, 0.5, 0),
                Size = UDim2New(0, 70, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(43, 43, 43)
            })  Items["KeybindListOutline"]:AddToTheme({BackgroundColor3 = "Window Background", BorderColor3 = "Outline"})

            Items["KeybindListOutline"]:MakeDraggable()

            Instances:Create("UIStroke", {
                Parent = Items["KeybindListOutline"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Inline"] = Instances:Create("Frame", {
                Parent = Items["KeybindListOutline"].Instance,
                Name = "\0",
                Position = UDim2New(0, 5, 0, 5),
                BorderColor3 = FromRGB(68, 68, 68),
                Size = UDim2New(1, -10, 1, -10),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(12, 12, 12)
            })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Border"})

            Instances:Create("UIStroke", {
                Parent = Items["Inline"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Instances:Create("UIPadding", {
                Parent = Items["Inline"].Instance,
                PaddingTop = UDimNew(0, 7),
                PaddingBottom = UDimNew(0, 7),
                PaddingRight = UDimNew(0, 8),
                PaddingLeft = UDimNew(0, 7)
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["Inline"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Keybinds",
                Name = "\0",
                Size = UDim2New(0, 0, 0, 20),
                Position = UDim2New(0, -2, 0, -4),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

            Items["Content"] = Instances:Create("Frame", {
                Parent = Items["Inline"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 4, 0, 21),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Content"].Instance,
                Padding = UDimNew(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
            
            Instances:Create("UIPadding", {
                Parent = Items["Content"].Instance,
                PaddingBottom = UDimNew(0, 7),
                PaddingRight = UDimNew(0, 5)
            }) 

            Items["Liner"] = Instances:Create("Frame", {
                Parent = Items["KeybindListOutline"].Instance,
                Name = "\0",
                Position = UDim2New(0, 5, 0, 5),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -10, 0, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Accent"})

            Instances:Create("UIGradient", {
                Parent = Items["Liner"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(125, 125, 125))}
            }) 
        end

        function KeybindList:Add(Mode, Name, Key)
            local NewKey = Instances:Create("TextLabel", {
                Parent = Items["Content"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(31, 226, 130),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "( " .. Mode .. " ) " .. Name .. " - " .. Key .. " ",
                Name = "\0",
                Size = UDim2New(0, 0, 0, 17),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  NewKey:AddToTheme({TextColor3 = "Text"})

            function NewKey:Set(Mode, Name, Key)
                NewKey.Instance.Text = "( " .. Mode .. " ) " .. Name .. " - " .. Key .. " "
            end

            function NewKey:SetStatus(Bool)
                if Bool then 
                    NewKey:ChangeItemTheme({TextColor3 = "Accent"})
                    NewKey:Tween(nil, {TextColor3 = Library.Theme.Accent})
                else
                    NewKey:ChangeItemTheme({TextColor3 = "Text"})
                    NewKey:Tween(nil, {TextColor3 = Library.Theme.Text})
                end
            end

            return NewKey
        end

        function KeybindList:SetVisibility(Bool)
            Items["KeybindListOutline"].Instance.Visible = Bool
        end

        return KeybindList
    end

    Library.Notification = function(self, Text, Duration, Color, Icon)
        local Items = { } do
            Items["Notification"] = Instances:Create("Frame", {
                Parent = Library.NotifHolder.Instance,
                Name = "\0",
                Size = UDim2New(0, 0, 0, 24),
                BorderColor3 = FromRGB(10, 10, 10),
                BorderSizePixel = 2,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Notification"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Items["Notification"].Instance,
                PaddingTop = UDimNew(0, 1),
                PaddingRight = UDimNew(0, 6),
                PaddingLeft = UDimNew(0, 5)
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["Notification"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(215, 215, 215),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Text,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 4),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Liner"] = Instances:Create("Frame", {
                Parent = Items["Notification"].Instance,
                Name = "\0",
                Position = UDim2New(0, -5, 0, -1),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 11, 0, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = Color
            })  

            Instances:Create("UIGradient", {
                Parent = Items["Liner"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(94, 94, 94))}
            }) 
        end

        if Icon then
            if type(Icon) == "table" then
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Notification"].Instance,
                    ImageColor3 = Icon[2],
                    ScaleType = Enum.ScaleType.Fit,
                    BorderColor3 = FromRGB(0, 0, 0),
                    Name = "\0",
                    Image = "rbxassetid://"..Icon[1],
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 2, 0, 5),
                    Size = UDim2New(0, 13, 0, 13),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Items["Title"].Instance.Position = UDim2New(0, 13, 0, 4)
                Items["Liner"].Instance.Size = UDim2New(1, 13, 0, 2)
            else

            end
        end

        Items["Notification"].Instance.BackgroundTransparency = 1
        Items["Notification"].Instance.Size = UDim2New(0, 0, 0, 0)
        for Index, Value in Items["Notification"].Instance:GetDescendants() do
            if Value:IsA("UIStroke") then 
                Value.Transparency = 1
            elseif Value:IsA("TextLabel") then 
                Value.TextTransparency = 1
            elseif Value:IsA("ImageLabel") then 
                Value.ImageTransparency = 1
            elseif Value:IsA("Frame") then 
                Value.BackgroundTransparency = 1
            end
        end

        Library:Thread(function()
            Items["Notification"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Size = UDim2New(0, 0, 0, 24)})
            
            task.wait(0.06)

            for Index, Value in Items["Notification"].Instance:GetDescendants() do
                if Value:IsA("UIStroke") then
                    Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Transparency = 0}, true)
                elseif Value:IsA("TextLabel") then
                    Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 0}, true)
                elseif Value:IsA("ImageLabel") then
                    Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 0}, true)
                elseif Value:IsA("Frame") then
                    Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0}, true)
                end
            end

            task.delay(Duration + 0.1, function()
                for Index, Value in Items["Notification"].Instance:GetDescendants() do
                    if Value:IsA("UIStroke") then
                        Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Transparency = 1}, true)
                    elseif Value:IsA("TextLabel") then
                        Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextTransparency = 1}, true)
                    elseif Value:IsA("ImageLabel") then
                        Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {ImageTransparency = 1}, true)
                    elseif Value:IsA("Frame") then
                        Tween:Create(Value, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1}, true)
                    end
                end

                task.wait(0.06)

                Items["Notification"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})

                task.wait(0.5)
                Items["Notification"]:Clean()
            end)
        end)
    end

    local Components = { } do
        Components.Window = function(Data)
            local Items = { } do 
                if not Data.IsTextButton then
                    Items["Outline"] = Instances:Create("Frame", {
                        Parent = Data.Parent.Instance,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Name = "\0",
                        Position = Data.Position,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = Data.Size,
                        Visible = Data.Visible or true,
                        BorderSizePixel = 2,
                        BackgroundColor3 = FromRGB(43, 43, 43)
                    })  Items["Outline"]:AddToTheme({BackgroundColor3 = "Window Background", BorderColor3 = "Outline"})
                else
                    Items["Outline"] = Instances:Create("TextButton", {
                        Parent = Data.Parent.Instance,
                        Text = "",
                        AutoButtonColor = false,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Name = "\0",
                        Position = Data.Position,
                        BorderColor3 = FromRGB(0, 0, 0),
                        Size = Data.Size,
                        Visible = Data.Visible or true,
                        BorderSizePixel = 2,
                        BackgroundColor3 = FromRGB(43, 43, 43)
                    })  Items["Outline"]:AddToTheme({BackgroundColor3 = "Window Background", BorderColor3 = "Outline"})
                end

                if Data.Draggable then 
                    Items["Outline"]:MakeDraggable()
                end

                Instances:Create("UIStroke", {
                    Parent = Items["Outline"].Instance,
                    Color = FromRGB(68, 68, 68),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["Inline"] = Instances:Create("Frame", {
                    Parent = Items["Outline"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 5, 0, 5),
                    BorderColor3 = FromRGB(68, 68, 68),
                    Size = UDim2New(1, -10, 1, -10),
                    BorderSizePixel = 2,
                    BackgroundColor3 = FromRGB(12, 12, 12)
                })  Items["Inline"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Border"})

                Instances:Create("UIStroke", {
                    Parent = Items["Inline"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Outline"})

                Items["Liner"] = Instances:Create("Frame", {
                    Parent = Items["Inline"].Instance,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 0, 2),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 226, 130)
                })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Accent"})

                Instances:Create("UIGradient", {
                    Parent = Items["Liner"].Instance,
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(125, 125, 125))}
                }) 
            end

            return Items
        end

        Components.Page = function(Data)
            local Page = {
                Active = false
            }

            local Items = { } do 
                Items["Inactive"] = Instances:Create("TextButton", {
                    Parent = Data.PageHolder.Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(180, 180, 180),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Name,
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Name = "\0",
                    Size = UDim2New(0, 200, 1, -12),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Inactive"]:AddToTheme({TextColor3 = "Text"})

                Items["Liner"] = Instances:Create("Frame", {
                    Parent = Items["Inactive"].Instance,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 1),
                    Name = "\0",
                    Position = UDim2New(0.5, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, 2),
                    ZIndex = 2,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(56, 56, 56)
                })  Items["Liner"]:AddToTheme({BackgroundColor3 = "Dark Liner"})

                Instances:Create("UIGradient", {
                    Parent = Items["Liner"].Instance,
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(125, 125, 125))}
                }) 

                Instances:Create("UIStroke", {
                    Parent = Items["Liner"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Outline"})

                Items["Glow"] = Instances:Create("Frame", {
                    Parent = Items["Inactive"].Instance,
                    BorderColor3 = FromRGB(0, 0, 0),
                    AnchorPoint = Vector2New(0.5, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2New(0.5, 0, 1, 0),
                    Name = "\0",
                    Size = UDim2New(1, 2, 0, 0),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(31, 226, 130)
                })  Items["Glow"]:AddToTheme({BackgroundColor3 = "Accent"})

                Instances:Create("UIGradient", {
                    Parent = Items["Glow"].Instance,
                    Rotation = -90,
                    Transparency = NumSequence{NumSequenceKeypoint(0, 0), NumSequenceKeypoint(0.074, 0.6937500238418579), NumSequenceKeypoint(0.354, 0.90625), NumSequenceKeypoint(1, 1)}
                }) 

                Items["Page"] = Instances:Create("Frame", {
                    Parent = Data.ContentHolder.Instance,
                    BackgroundTransparency = 1,
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, 0, 1, 0),
                    Visible = false,
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                if Data.HasColumns then 
                    Instances:Create("UIListLayout", {
                        Parent = Items["Page"].Instance,
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalFlex = Enum.UIFlexAlignment.Fill,
                        Padding = UDimNew(0, 20),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        VerticalFlex = Enum.UIFlexAlignment.Fill
                    }) 
                end
            end

            function Page:Column(ColumnIndex)
                if not Data.HasColumns then 
                    return 
                end

                local NewColumn = Instances:Create("ScrollingFrame", {
                    Parent = Items["Page"].Instance,
                    ScrollBarImageColor3 = FromRGB(0, 0, 0),
                    Active = true,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    ScrollBarThickness = 0,
                    Name = "\0",
                    MidImage = "rbxassetid://85239668542938",
                    TopImage = "rbxassetid://85239668542938",
                    BottomImage = "rbxassetid://85239668542938",
                    BackgroundTransparency = 1,
                    Size = UDim2New(0, 100, 0, 100),
                    BackgroundColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    CanvasSize = UDim2New(0, 0, 0, 0)
                })  NewColumn:AddToTheme({ScrollBarImageColor3 = "Accent"})

                local Padding = Instances:Create("UIPadding", {
                    Parent = NewColumn.Instance,
                    PaddingTop = UDimNew(0, 18),
                    PaddingBottom = UDimNew(0, 15),
                    PaddingRight = UDimNew(0, 18),
                    PaddingLeft = UDimNew(0, 18)
                }) 

                if ColumnIndex == 1 then 
                    Padding.Instance.PaddingRight = UDimNew(0, 5)
                elseif ColumnIndex == 2 then
                    Padding.Instance.PaddingRight = UDimNew(0, 18)
                    Padding.Instance.PaddingLeft = UDimNew(0, 5)
                end

                Instances:Create("UIListLayout", {
                    Parent = NewColumn.Instance,
                    Padding = UDimNew(0, 17),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }) 

                return NewColumn
            end

            function Page:Turn(Bool)
                Page.Active = Bool
                Items["Page"].Instance.Visible = Bool

                if Page.Active then 
                    Items["Inactive"]:ChangeItemTheme({TextColor3 = "Accent"})
                    Items["Liner"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

                    Items["Inactive"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
                    Items["Liner"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                    Items["Glow"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(1, 2, 1, 0)})
                else
                    Items["Inactive"]:ChangeItemTheme({TextColor3 = "Text"})
                    Items["Liner"]:ChangeItemTheme({BackgroundColor3 = "Dark Liner"})

                    Items["Inactive"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    Items["Liner"]:Tween(nil, {BackgroundColor3 = Library.Theme["Dark Liner"]})
                    Items["Glow"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(1, 2, 0, 0)})
                end
            end

            Items["Inactive"]:Connect("MouseButton1Down", function()
                for Index, Value in Data.PagesTable do
                    Value:Turn(Value == Page)
                end
            end)

            if #Data.PagesTable == 0 then 
                Page:Turn(true)
            end

            TableInsert(Data.PagesTable, Page)
            return Page, Items
        end

        Components.Section = function(Data)
            local Items = { } do 
                Items["Section"] = Instances:Create("Frame", {
                    Parent = Data.Parent.Instance,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 25),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 2,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundColor3 = FromRGB(19, 19, 19)
                })  Items["Section"]:AddToTheme({BackgroundColor3 = "Section Background", BorderColor3 = "Outline"})

                Instances:Create("UIPadding", {
                    Parent = Items["Section"].Instance,
                    PaddingBottom = UDimNew(0, 10)
                }) 

                Instances:Create("UIStroke", {
                    Parent = Items["Section"].Instance,
                    Color = FromRGB(68, 68, 68),
                    LineJoinMode = Enum.LineJoinMode.Miter,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Items["Title"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Size = UDim2New(1, -4, 0, 2),
                    Name = "\0",
                    Position = UDim2New(0, 2, 0, -2),
                    BorderColor3 = FromRGB(0, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundColor3 = FromRGB(31, 226, 130)
                })  Items["Title"]:AddToTheme({BackgroundColor3 = "Accent"})

                Instances:Create("UIGradient", {
                    Parent = Items["Title"].Instance,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(226, 226, 226)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))},
                    Transparency = NumSequence{NumSequenceKeypoint(0, 0.512499988079071), NumSequenceKeypoint(0.42, 0.768750011920929), NumSequenceKeypoint(1, 1)}
                }) 

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Title"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(180, 180, 180),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Name,
                    Size = UDim2New(0, 40, 0, 13),
                    Name = "\0",
                    Position = UDim2New(0, 9, 0, 0),
                    BorderSizePixel = 0,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(19, 19, 19)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Section Background"})

                Instances:Create("UIPadding", {
                    Parent = Items["Text"].Instance,
                    PaddingLeft = UDimNew(0, 3),
                    PaddingRight = UDimNew(0, 4),
                    PaddingBottom = UDimNew(0, 2)
                })

                Items["Content"] = Instances:Create("Frame", {
                    Parent = Items["Section"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Position = UDim2New(0, 12, 0, 17),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(1, -24, 1, -20),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Instances:Create("UIListLayout", {
                    Parent = Items["Content"].Instance,
                    Padding = UDimNew(0, 6),
                    SortOrder = Enum.SortOrder.LayoutOrder
                }) 
            end

            return Items
        end

        Components.Toggle = function(Data)
            local Toggle = {
                Value = false,

                Flag = Data.Flag 
            }

            local Items = { } do 
                Items["Toggle"] = Instances:Create("TextButton", {
                    Parent = Data.Parent.Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    BackgroundTransparency = 1,
                    Name = "\0",
                    Size = UDim2New(1, 0, 0, 15),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(172, 158, 158)
                })

                if Data.Tooltip then 
                    Items["Toggle"]:Tooltip(Data.Tooltip)
                end

                Items["Indicator"] = Instances:Create("Frame", {
                    Parent = Items["Toggle"].Instance,
                    AnchorPoint = Vector2New(0, 0.5),
                    Name = "\0",
                    Position = UDim2New(0, 0, 0.5, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    BackgroundColor3 = FromRGB(63, 63, 63)
                })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UIStroke", {
                    Parent = Items["Indicator"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Outline"})

                Instances:Create("UIGradient", {
                    Parent = Items["Indicator"].Instance,
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
                }) 

                Items["Text"] = Instances:Create("TextLabel", {
                    Parent = Items["Toggle"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(180, 180, 180),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Name,
                    Name = "\0",
                    Size = UDim2New(1, -18, 1, 0),
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Position = UDim2New(0, 18, 0, -1),
                    BorderSizePixel = 0,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

                if Data.Risky then 
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Risky"})
                else
                    Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                end
            end

            function Toggle:Set(Bool)
                Toggle.Value = Bool

                Library.Flags[Toggle.Flag] = Toggle.Value

                if Toggle.Value then 
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

                    if not Data.Risky then 
                        Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
                        Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
                    end
                else
                    Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})

                    if not Data.Risky then
                        Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                        Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    end
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Toggle.Value)
                end
            end

            function Toggle:Get()
                return Toggle.Value
            end

            function Toggle:SetVisibility(Bool)
                Items["Toggle"].Instance.Visible = Bool
            end

            if Data.Default then 
                Toggle:Set(Data.Default)
            end

            Items["Toggle"]:Connect("MouseButton1Down", function()
                Toggle:Set(not Toggle.Value)
            end)

            Library.SetFlags[Toggle.Flag] = function(Value)
                Toggle:Set(Value)
            end

            return Toggle, Items
        end
    end

    Components.Button = function(Data)
        local Button = { }

        local Items = { } do 
            Items["Button"] = Instances:Create("TextButton", {
                Parent = Data.Parent.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 17),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(63, 63, 63)
            })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element"})

            if Data.Tooltip then 
                Items["Button"]:Tooltip(Data.Tooltip)
            end

            Instances:Create("UIStroke", {
                Parent = Items["Button"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Instances:Create("UIGradient", {
                Parent = Items["Button"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Button"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Data.Name,
                Name = "\0",
                Position = UDim2New(0, 0, 0, -1),
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextWrapped = true,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            if Data.Risky then 
                Items["Text"]:ChangeItemTheme({TextColor3 = "Risky"})
            else
                Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
            end
        end

        function Button:Press()
            Library:SafeCall(Data.Callback)

            Items["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
            Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

            Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
            Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

            task.wait(0.1)

            if not Data.Risky then 
                Items["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            else
                Items["Text"]:ChangeItemTheme({TextColor3 = "Risky"})
                Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                Items["Text"]:Tween(nil, {TextColor3 = Library.Theme.Risky})
                Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            end
        end

        function Button:SetVisibility(Bool)
            Items["Button"].Instance.Visible = Bool
        end

        function Button:SubButton(Data)
            local SubButton = { }

            Items["ButtonHolder"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 17),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Items["Button"].Instance.Parent = Items["ButtonHolder"].Instance
            Items["Button"].Instance.Size =  UDim2New(0.475, 3, 0, 17)

            local SubItems = { } do 
                SubItems["Button"] = Instances:Create("TextButton", {
                    Parent = Items["ButtonHolder"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(0, 0, 0),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = "",
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    Name = "\0",
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0.475, 3, 0, 17),
                    BorderSizePixel = 0,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(63, 63, 63)
                })  SubItems["Button"]:AddToTheme({BackgroundColor3 = "Element"})

                if Data.Tooltip then 
                    SubItems["Button"]:Tooltip(Data.Tooltip)
                end

                Instances:Create("UIStroke", {
                    Parent = SubItems["Button"].Instance,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    LineJoinMode = Enum.LineJoinMode.Miter
                }):AddToTheme({Color = "Outline"})

                Instances:Create("UIGradient", {
                    Parent = SubItems["Button"].Instance,
                    Rotation = 90,
                    Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
                }) 

                SubItems["Text"] = Instances:Create("TextLabel", {
                    Parent = SubItems["Button"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(180, 180, 180),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = Data.Name,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    Size = UDim2New(1, 0, 1, 0),
                    Position = UDim2New(0, 0, 0, -1),
                    BorderSizePixel = 0,
                    TextWrapped = true,
                    TextSize = 12,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  SubItems["Text"]:AddToTheme({TextColor3 = "Text"})

                if Data.Risky then 
                    SubItems["Text"]:ChangeItemTheme({TextColor3 = "Risky"})
                else
                    SubItems["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                end
            end

            function SubButton:Press()
                Library:SafeCall(Data.Callback)

                SubItems["Text"]:ChangeItemTheme({TextColor3 = "Accent"})
                SubItems["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})

                SubItems["Text"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
                SubItems["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})

                task.wait(0.1)

                if not Data.Risky then 
                    SubItems["Text"]:ChangeItemTheme({TextColor3 = "Text"})
                    SubItems["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                    SubItems["Text"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                    SubItems["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                else
                    SubItems["Text"]:ChangeItemTheme({TextColor3 = "Risky"})
                    SubItems["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})

                    SubItems["Text"]:Tween(nil, {TextColor3 = Library.Theme.Risky})
                    SubItems["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end
            end

            function SubButton:SetVisibility(Bool)
                SubItems["Button"].Instance.Visible = Bool
            end

            SubItems["Button"]:Connect("MouseButton1Down", function()
                SubButton:Press()
            end)
        end

        Items["Button"]:Connect("MouseButton1Down", function()
            Button:Press()
        end)

        return Button, Items
    end

    Components.Slider = function(Data)
        local Slider = {
            Sliding = false,
            Value = 0,

            Flag = Data.Flag
        }

        local Items = { } do
            Items["Slider"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 26),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            if Data.Tooltip then 
                Items["Slider"]:Tooltip(Data.Tooltip)
            end

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Slider"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Data.Name,
                Name = "\0",
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 13),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["RealSlider"] = Instances:Create("TextButton", {
                Parent = Items["Slider"].Instance,
                AutoButtonColor = false,
                Text = "",
                AnchorPoint = Vector2New(0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 8),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(63, 63, 63)
            })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UIGradient", {
                Parent = Items["RealSlider"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["RealSlider"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["RealSlider"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.23999999463558197, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Accent"})

            Instances:Create("UIGradient", {
                Parent = Items["Indicator"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["Slider"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "24%",
                Name = "\0",
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Right,
                Size = UDim2New(1, 0, 0, 13),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
        end

        function Slider:Set(Value)
            Slider.Value = MathClamp(Library:Round(Value, Data.Decimals), Data.Min, Data.Max)

            Library.Flags[Slider.Flag] = Slider.Value

            Items["Indicator"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2New((Slider.Value - Data.Min) / (Data.Max - Data.Min), 0, 1, 0)})
            Items["Value"].Instance.Text = StringFormat("%s%s", tostring(Slider.Value), Data.Suffix)

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Slider.Value)
            end
        end

        function Slider:SetVisibility(Bool)
            Items["Slider"].Instance.Visible = Bool
        end

        function Slider:Get()
            return Slider.Value
        end

        Items["RealSlider"]:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                Slider.Sliding = true

                local SizeX = (Mouse.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                local Value = ((Data.Max - Data.Min) * SizeX) + Data.Min

                Slider:Set(Value)

                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Slider.Sliding = false
                    end
                end)
            end
        end)

        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Slider.Sliding then
                    local SizeX = (Mouse.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X
                    local Value = ((Data.Max - Data.Min) * SizeX) + Data.Min

                    Slider:Set(Value)
                end
            end
        end)

        if Data.Default then 
            Slider:Set(Data.Default)
        end

        Library.SetFlags[Slider.Flag] = function(Value)
            Slider:Set(Value)
        end

        return Slider, Items
    end

    Components.Dropdown = function(Data)
        local Dropdown = {
            Value = { },
            IsOpen = false,
            Options = { },

            Flag = Data.Flag,

            Name = "Dropdown"
        }

        local Items = { } do
            Items["Dropdown"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 17),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            if Data.Tooltip then 
                Items["Dropdown"]:Tooltip(Data.Tooltip)
            end

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Dropdown"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Data.Name,
                Name = "\0",
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["RealDropdown"] = Instances:Create("TextButton", {
                Parent = Items["Dropdown"].Instance,
                AutoButtonColor = false,
                Text = "",
                AnchorPoint = Vector2New(1, 1),
                Name = "\0",
                Position = UDim2New(1, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -85, 0, 17),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(63, 63, 63)
            })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UIGradient", {
                Parent = Items["RealDropdown"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["RealDropdown"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["RealDropdown"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "--",
                Name = "\0",
                Size = UDim2New(1, -25, 1, 0),
                Position = UDim2New(0, 6, 0, -1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})

            Items["OpenIcon"] = Instances:Create("ImageLabel", {
                Parent = Items["RealDropdown"].Instance,
                ImageColor3 = FromRGB(170, 170, 170),
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AnchorPoint = Vector2New(1, 0.5),
                Image = "rbxassetid://97269400371594",
                BackgroundTransparency = 1,
                Position = UDim2New(1, -2, 0.5, 0),
                Size = UDim2New(0, 14, 1, -2),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  

            Items["OptionHolder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Dropdown"].Instance,
                ScrollBarImageColor3 = FromRGB(31, 226, 130),
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                Size = UDim2New(1, -85, 0, Data.MaxSize),
                MidImage = "rbxassetid://85239668542938",
                TopImage = "rbxassetid://85239668542938",
                BottomImage = "rbxassetid://85239668542938",
                AnchorPoint = Vector2New(1, 0),
                Visible = false,
                Name = "\0",
                Position = UDim2New(1, 0, 1, 3),
                BackgroundColor3 = FromRGB(19, 19, 19),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Section Background", ScrollBarImageColor3 = "Accent"})

            Items["Holder"] = Instances:Create("TextButton", {
                Parent = Items["OptionHolder"].Instance,
                AutoButtonColor = false,
                Text = "",
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Position = UDim2New(0, 0, 0, 0),
                Size = UDim2New(1, 0, 1, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0
            })

            Instances:Create("UIStroke", {
                Parent = Items["OptionHolder"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Padding = UDimNew(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["Holder"].Instance,
                PaddingBottom = UDimNew(0, 8)
            }) 
        end

        local Debounce = false

        function Dropdown:Set(Option)
            if Data.Multi then
                if type(Option) ~= "table" then 
                    return
                end

                Dropdown.Value = Option
                Library.Flags[Dropdown.Flag] = Dropdown.Value

                for Index, Value in Option do 
                    local OptionData = Dropdown.Options[Value]
                    
                    if not OptionData then 
                        return
                    end

                    OptionData.Selected = true
                    OptionData:Toggle("Active")
                end

                Items["Value"].Instance.Text = TableConcat(Option, ", ")
            else
                local OptionData = Dropdown.Options[Option]

                if not OptionData then 
                    return 
                end

                OptionData.Selected = true  
                OptionData:Toggle("Active")

                Dropdown.Value = OptionData.Name
                Library.Flags[Dropdown.Flag] = Dropdown.Value

                for Index, Value in Dropdown.Options do 
                    if Value ~= OptionData then 
                        Value.Selected = false
                        Value:Toggle("Inactive")
                    end
                end

                Items["Value"].Instance.Text = Dropdown.Value
            end

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Dropdown.Value)
            end
        end

        function Dropdown:SetVisibility(Bool)
            Items["Dropdown"].Instance.Visible = Bool
        end

        function Dropdown:SetOpen(Bool)
            Dropdown.IsOpen = Bool 

            if Dropdown.IsOpen then 
                Debounce = true

                Items["OptionHolder"].Instance.Visible = true
                Items["OptionHolder"].Instance.ZIndex = 1001

                for Index, Value in Items["OptionHolder"].Instance:GetDescendants() do 
                    if not StringFind(Value.ClassName, "UI") then 
                        Value.ZIndex = 1001
                    end
                end

                task.wait(0.1)
                Debounce = false
            else
                Items["OptionHolder"].Instance.Visible = false
                Items["OptionHolder"].Instance.ZIndex = 1

                for Index, Value in Items["OptionHolder"].Instance:GetDescendants() do
                    if not StringFind(Value.ClassName, "UI") then 
                        Value.ZIndex = 1
                    end
                end

                Debounce = false
            end
        end

        function Dropdown:Remove(Option)
            if Dropdown.Options[Option] then 
                Dropdown.Options[Option].OptionButton:Clean()
            end
        end

        function Dropdown:Refresh(List)
            for Index, Value in Dropdown.Options do 
                Dropdown:Remove(Value.Name)
            end

            for Index, Value in List do 
                Dropdown:Add(Value)
            end
        end

        function Dropdown:Add(Option)
            local OptionButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Option,
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  OptionButton:AddToTheme({TextColor3 = "Text"})

            local UIPadding = Instances:Create("UIPadding", {
                Parent = OptionButton.Instance,
                PaddingTop = UDimNew(0, 5),
                PaddingLeft = UDimNew(0, 7)
            })

            local OptionData = {
                Name = Option,
                OptionButton = OptionButton,
                Padding = UIPadding,
                Selected = false
            }

            function OptionData:Toggle(Status)
                if Status == "Active" then 
                    OptionData.OptionButton:ChangeItemTheme({TextColor3 = "Accent"})
                    OptionData.OptionButton:Tween(nil, {TextColor3 = Library.Theme.Accent})

                    OptionData.Padding.Instance.PaddingLeft = UDimNew(0, 12)
                else
                    OptionData.OptionButton:ChangeItemTheme({TextColor3 = "Text"})
                    OptionData.OptionButton:Tween(nil, {TextColor3 = Library.Theme.Text})

                    OptionData.Padding.Instance.PaddingLeft = UDimNew(0, 7)
                end
            end

            function OptionData:Set()
                OptionData.Selected = not OptionData.Selected

                if Data.Multi then 
                    local Index = TableFind(Dropdown.Value, OptionData.Name)

                    if Index then 
                        TableRemove(Dropdown.Value, Index)
                    else
                        TableInsert(Dropdown.Value, OptionData.Name)
                    end

                    Library.Flags[Dropdown.Flag] = Dropdown.Value

                    OptionData:Toggle(Index and "Inactive" or "Active")

                    local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                    Items["Value"].Instance.Text = TextFormat
                else
                    if OptionData.Selected then
                        Dropdown.Value = OptionData.Name

                        OptionData:Toggle("Active")
                        Items["Value"].Instance.Text = OptionData.Name

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        for Index, Value in Dropdown.Options do 
                            if Value ~= OptionData then 
                                Value.Selected = false
                                Value:Toggle("Inactive")
                            end
                        end
                    else
                        Dropdown.Value = nil

                        OptionData:Toggle("Inactive")
                        Items["Value"].Instance.Text = "--"

                        Library.Flags[Dropdown.Flag] = Dropdown.Value
                    end
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Dropdown.Value)
                end
            end

            OptionData.OptionButton:Connect("MouseButton1Down", function()
                OptionData:Set()
            end)

            Dropdown.Options[Option] = OptionData
            return OptionData
        end

        function Dropdown:Get()
            return Dropdown.Value
        end

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Debounce then 
                    return
                end

                if not Dropdown.IsOpen then  
                    return 
                end

                if Library:IsMouseOverFrame(Items["OptionHolder"].Instance) then 
                    return
                end

                Dropdown:SetOpen(false)
            end
        end)

        Items["RealDropdown"]:Connect("MouseButton1Down", function()
            Dropdown:SetOpen(not Dropdown.IsOpen)
        end)

        for Index, Value in Data.Items do 
            Dropdown:Add(Value)
        end

        if Data.Default then 
            Dropdown:Set(Data.Default)
        end

        Library.SetFlags[Dropdown.Flag] = function(Value)
            Dropdown:Set(Value)    
        end

        return Dropdown, Items
    end

    Components.Colorpicker = function(Data)
        local Colorpicker = {
            Hue = 0,
            Saturation = 0,
            Value = 0,

            Alpha = 0,

            Color = nil,
            HexValue = "",

            IsOpen = false,

            Pages = { },

            Flag = Data.Flag,

            OnAnimationChanged = nil,

            CurrentAnimation = "",
            AnimationIntensity = 0,
            AnimationSpeed = 0
        }

        Library.Flags[Colorpicker.Flag] = { }

        local Items = { } do
            Items["ColorpickerButton"] = Instances:Create("TextButton", {
                Parent = Data.Parent.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = Vector2New(1, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 0),
                Size = UDim2New(0, 25, 0, 12),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(31, 226, 130)
            }) 

            if Data.Tooltip then
                Items["ColorpickerButton"]:Tooltip(Data.Tooltip)
            end

            Instances:Create("UIGradient", {
                Parent = Items["ColorpickerButton"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["ColorpickerButton"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            local CalculateCount = function(Index)
                local MaxButtonsAdded = 5

                local Column = Index % MaxButtonsAdded
            
                local ButtonSize = Items["ColorpickerButton"].Instance.AbsoluteSize
                local Spacing = 4
            
                local XPosition = (ButtonSize.X + Spacing) * Column - Spacing - 25
            
                Items["ColorpickerButton"].Instance.Position = UDim2New(1, -XPosition, 0.5, 0)
            end

            CalculateCount(Data.Count)

            Items["ColorpickerWindow"] = Components.Window({
                Position = UDim2New(0, Camera.ViewportSize.X / 3, 0, Camera.ViewportSize.Y / 3),
                Size = UDim2New(0, 263, 0, 243),
                Parent = Library.Holder,
                Visible = false,
                IsTextButton = true,
                Draggable = true
            })

            Items["ColorpickerWindow"]["Outline"].Instance.Visible = false

            Items["Pages"] = Instances:Create("Frame", {
                Parent = Items["ColorpickerWindow"]["Inline"].Instance,
                Name = "\0",
                Position = UDim2New(0.12, -12, 0, 12),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.875, -2, 0, 37),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Pages"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Pages"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["RealHolder"] = Instances:Create("Frame", {
                Parent = Items["Pages"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 7, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -14, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["RealHolder"].Instance,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = UDimNew(0, 15),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Content"] = Instances:Create("Frame", {
                Parent = Items["ColorpickerWindow"]["Inline"].Instance,
                Name = "\0",
                Position = UDim2New(0.12, -12, 0, 60),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.875, -2, 1, -69),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Content"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Content"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            local PickingPage, PickingPageItems = Components.Page({
                HasColumns = false,
                PageHolder = Items["RealHolder"],
                Name = "Picking",
                PagesTable = Colorpicker.Pages,
                ContentHolder =  Items["Content"],
            })

            local LerpingPage, LerpingPageItems = Components.Page({
                HasColumns = false,
                PageHolder = Items["RealHolder"],
                Name = "Lerping",
                PagesTable = Colorpicker.Pages,
                ContentHolder =  Items["Content"],
            })

            LerpingPageItems["Page"].Instance.Visible = false

            local ColorsPage, ColorsPageItems = Components.Page({
                HasColumns = false,
                PageHolder = Items["RealHolder"],
                Name = "Colors",
                PagesTable = Colorpicker.Pages,
                ContentHolder =  Items["Content"],
            })

            ColorsPageItems["Page"].Instance.Visible = false

            Items["Palette"] = Instances:Create("TextButton", {
                Parent = PickingPageItems["Page"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Name = "\0",
                Position = UDim2New(0.05, 2, 0.07, -2),
                Size = UDim2New(0.9, -4, 0.67, 0),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(31, 226, 130)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Palette"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["PaletteDragger"] = Instances:Create("Frame", {
                Parent = Items["Palette"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 2, 0, 2),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["PaletteDragger"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Saturation"] = Instances:Create("ImageLabel", {
                Parent = Items["Palette"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Library:GetImage("Saturation"),
                BackgroundTransparency = 1,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Value"] = Instances:Create("ImageLabel", {
                Parent = Items["Palette"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Library:GetImage("Value"),
                BackgroundTransparency = 1,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Alpha"] = Instances:Create("TextButton", {
                Parent = PickingPageItems["Page"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Name = "\0",
                Position = UDim2New(0.05, 2, 1, -22),
                Size = UDim2New(0.9, -4, 0.1, -3),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(31, 226, 130)
            }) 

            Items["Checkers"] = Instances:Create("ImageLabel", {
                Parent = Items["Alpha"].Instance,
                ScaleType = Enum.ScaleType.Tile,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Image = Library:GetImage("Checkers"),
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 1, 0),
                TileSize = UDim2New(0, 6, 0, 6),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIGradient", {
                Parent = Items["Checkers"].Instance,
                Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Alpha"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["AlphaDragger"] = Instances:Create("Frame", {
                Parent = Items["Alpha"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 1, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["AlphaDragger"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Hue"] = Instances:Create("ImageButton", {
                Parent = PickingPageItems["Page"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                Image = Library:GetImage("Hue"),
                Name = "\0",
                Position = UDim2New(0.05, 2, 1, -40),
                Size = UDim2New(0.9, -4, 0.1, -3),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Hue"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["HueDragger"] = Instances:Create("Frame", {
                Parent = Items["Hue"].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 1, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["HueDragger"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            local AnimationIntensitySlider
            local AnimationIntensitySliderItems

            local AnimationSpeedSlider 
            local AnimationSpeedSliderItems

            local AnimationModeDropdown, AnimationModeDropdownItems = Components.Dropdown({
                Parent = LerpingPageItems["Page"],
                Name = "Animation",
                Flag = Colorpicker.Flag .. "AnimationModeDropdown",
                Items = { "Rainbow", "Fade Alpha" },
                MaxSize = 50,
                Default = nil,
                Callback = function(Value)
                    Colorpicker.CurrentAnimation = Value

                    if Colorpicker.OnAnimationChanged then 
                        Colorpicker.OnAnimationChanged(Value)
                    end

                    if Value == "Fade Alpha" and AnimationIntensitySlider and AnimationSpeedSlider then 
                        AnimationIntensitySlider:SetVisibility(true)
                        AnimationSpeedSlider:SetVisibility(true)
                        AnimationSpeedSliderItems["Slider"].Instance.Position = UDim2New(0, 8, 0, 55)
                    elseif Value == "Rainbow" and AnimationIntensitySlider and  AnimationSpeedSlider then
                        AnimationIntensitySlider:SetVisibility(false)
                        AnimationSpeedSlider:SetVisibility(true)
                        AnimationSpeedSliderItems["Slider"].Instance.Position = UDim2New(0, 8, 0, 25)
                    else
                        AnimationIntensitySlider:SetVisibility(false)
                        AnimationSpeedSlider:SetVisibility(false)
                        AnimationSpeedSliderItems["Slider"].Instance.Position = UDim2New(0, 8, 0, 55)
                    end
                end,
                Multi = false
            })

            AnimationModeDropdownItems["Dropdown"].Instance.Size = UDim2New(1, -16, 0, 17)
            AnimationModeDropdownItems["Dropdown"].Instance.Position = UDim2New(0, 8, 0, 8)

            AnimationIntensitySlider, AnimationIntensitySliderItems = Components.Slider({
                Parent = LerpingPageItems["Page"],
                Name = "Intensity",
                Flag = Colorpicker.Flag .. "AnimationIntensitySlider",
                Min = 0,
                Max = 100,
                Default = 50,
                Suffix = "%",
                Callback = function(Value)
                    Colorpicker.CurrentAnimationIntensity = Value
                end
            })

            AnimationIntensitySlider:SetVisibility(false)
            AnimationIntensitySliderItems["Slider"].Instance.Size = UDim2New(1, -16, 0, 26)
            AnimationIntensitySliderItems["Slider"].Instance.Position = UDim2New(0, 8, 0, 25)

            AnimationSpeedSlider, AnimationSpeedSliderItems = Components.Slider({
                Parent = LerpingPageItems["Page"],
                Name = "Speed",
                Flag = Colorpicker.Flag .. "AnimationSpeedSlider",
                Min = 0,
                Max = 5,
                Decimals = 0.01,
                Default = 0.2,
                Suffix = "s",
                Callback = function(Value)
                    Colorpicker.CurrentAnimationSpeed = Value
                end
            })

            AnimationSpeedSlider:SetVisibility(false)
            AnimationSpeedSliderItems["Slider"].Instance.Position = UDim2New(0, 8, 0, 55)
            AnimationSpeedSliderItems["Slider"].Instance.Size = UDim2New(1, -16, 0, 26)

            Items["CurrentColor"] = Instances:Create("Frame", {
                Parent = ColorsPageItems["Page"].Instance,
                Name = "\0",
                Position = UDim2New(0, 8, 0, 8),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 55, 1, -16),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(31, 226, 130)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["CurrentColor"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Instances:Create("UIGradient", {
                Parent = Items["CurrentColor"].Instance,
                Rotation = 123,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(125, 125, 125)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))}
            }) 

            Items["RGB"] = Instances:Create("TextLabel", {
                Parent = ColorsPageItems["Page"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "R,G,B:",
                Name = "\0",
                Size = UDim2New(1, -75, 0, 15),
                Position = UDim2New(0, 70, 0, 4),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = true,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["RGB"]:AddToTheme({TextColor3 = "Text"})

            Items["HSV"] = Instances:Create("TextLabel", {
                Parent = ColorsPageItems["Page"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "H,S,V: ",
                Name = "\0",
                Size = UDim2New(1, -75, 0, 15),
                Position = UDim2New(0, 70, 0, 21),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = true,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["HSV"]:AddToTheme({TextColor3 = "Text"})

            Items["Hex"] = Instances:Create("TextLabel", {
                Parent = ColorsPageItems["Page"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "HEX:",
                Name = "\0",
                Size = UDim2New(1, -75, 0, 15),
                Position = UDim2New(0, 70, 0, 38),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = true,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Hex"]:AddToTheme({TextColor3 = "Text"})

            local CopyButton, CopyButtonItems = Components.Button({
                Name = "Copy",
                Parent = ColorsPageItems["Page"],
                Callback = function()
                    Library.CopiedColor = Colorpicker.Color
                    setclipboard(tostring(Colorpicker.Color))
                end
            })

            CopyButtonItems["Button"].Instance.Position = UDim2New(0, 70, 0, 57)
            CopyButtonItems["Button"].Instance.Size = UDim2New(1, -75, 0, 17)

            local PasteButton, PasteButtonItems = Components.Button({
                Name = "Paste",
                Parent = ColorsPageItems["Page"],
                Callback = function()
                    if Library.CopiedColor then 
                        Colorpicker:Set(Library.CopiedColor, Colorpicker.Alpha)
                    end
                end
            })

            PasteButtonItems["Button"].Instance.Position = UDim2New(0, 70, 0, 77)
            PasteButtonItems["Button"].Instance.Size = UDim2New(1, -75, 0, 17)
        end

        local SlidingPalette = false
        local SlidingHue = false
        local SlidingAlpha = false 
        
        local Debounce = false 

        function Colorpicker:Set(Color, Alpha)
            if type(Color) == "table" then 
                Color = FromRGB(Color[1], Color[2], Color[3])
                Alpha = Color[4]
            elseif type(Color) == "string" then 
                Color = FromHex(Color)
            end

            Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value = Color:ToHSV()
            Colorpicker.Alpha = Alpha or 0

            Colorpicker.Color = Color
            Colorpicker.HexValue = "#" .. Color:ToHex()

            local ColorPositionX = MathClamp(1 - Colorpicker.Saturation, 0, 0.989)
            local ColorPositionY = MathClamp(1 - Colorpicker.Value, 0, 0.989)

            Items["PaletteDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(ColorPositionX, 0, ColorPositionY, 0)})

            local HuePositionX = MathClamp(Colorpicker.Hue, 0, 0.994)

            Items["HueDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(HuePositionX, 0, 0, 0)})

            local AlphaPositionX = MathClamp(Colorpicker.Alpha, 0, 0.994)

            Items["AlphaDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(AlphaPositionX, 0, 0, 0)})
            
            Colorpicker:Update(true)
        end

        function Colorpicker:Update(IsFromAlpha)
            Colorpicker.Color = FromHSV(Colorpicker.Hue, Colorpicker.Saturation, Colorpicker.Value)
            Colorpicker.HexValue = Colorpicker.Color:ToHex()

            Items["Palette"]:Tween(nil, {BackgroundColor3 = FromHSV(Colorpicker.Hue, 1, 1)})
            Items["ColorpickerButton"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})

            Items["CurrentColor"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})

            local Red = MathFloor(Library:Round(Colorpicker.Color.R, 0.01) * 255)
            local Green = MathFloor(Library:Round(Colorpicker.Color.G, 0.01) * 255)
            local Blue = MathFloor(Library:Round(Colorpicker.Color.B, 0.01) * 255)

            local Hue = Library:Round(Colorpicker.Hue, 0.01)
            local Saturation = Library:Round(Colorpicker.Saturation, 0.01)
            local Value = Library:Round(Colorpicker.Value, 0.01)

            Items["RGB"].Instance.Text = "RGB: ".. Library:ToRich("".. Red .. ", ".. Green .. ", ".. Blue, Colorpicker.Color)
            Items["Hex"].Instance.Text = "HEX: ".. Library:ToRich(Colorpicker.HexValue, Colorpicker.Color)
            Items["HSV"].Instance.Text = "HSV: ".. Library:ToRich("" .. Hue .. ", ".. Saturation .. ", ".. Value, Colorpicker.Color)

            Library.Flags[Colorpicker.Flag] = {
                HexValue = Colorpicker.HexValue,
                Color = Colorpicker.Color,
                Alpha = Colorpicker.Alpha,
                Flag = Colorpicker.Flag
            }

            if not IsFromAlpha then 
                Items["Alpha"]:Tween(nil, {BackgroundColor3 = Colorpicker.Color})
            end

            if Data.Callback then
                Library:SafeCall(Data.Callback, Colorpicker.Color, Colorpicker.Alpha)
            end
        end

        function Colorpicker:SetOpen(Bool)
            Colorpicker.IsOpen = Bool

            if Colorpicker.IsOpen then 
                Debounce = true 
                Items["ColorpickerWindow"]["Outline"].Instance.Position = UDim2New(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y + 225)

                Items["ColorpickerWindow"]["Outline"].Instance.Visible = true 
                Items["ColorpickerWindow"]["Outline"].Instance.ZIndex = 25

                for Index, Value in Items["ColorpickerWindow"]["Outline"].Instance:GetDescendants() do 
                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = 25
                end

                Items["PaletteDragger"].Instance.ZIndex = 26

                task.wait(0.1)
                Debounce = false
            else
                Items["ColorpickerWindow"]["Outline"].Instance.Visible = false 
                Items["ColorpickerWindow"]["Outline"].Instance.ZIndex = 1

                for Index, Value in Items["ColorpickerWindow"]["Outline"].Instance:GetDescendants() do 
                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = 1000
                end

                Debounce = false 
            end
        end

        function Colorpicker:Get()
            return Colorpicker.Color, Colorpicker.Alpha
        end

        function Colorpicker:SetVisibility(Bool)
            Items["ColorpickerButton"].Instance.Visible = Bool
        end

        local OldColor = Colorpicker.Color

        function Colorpicker:SlidePalette(Input)
            if not SlidingPalette or not Input then
                return 
            end

            local ValueX = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
            local ValueY = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

            Colorpicker.Saturation = ValueX
            Colorpicker.Value = ValueY

            local SlideX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.989)
            local SlideY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.989)

            Items["PaletteDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(SlideX, 0, SlideY, 0)})
            Colorpicker:Update()        
            
            OldColor = Colorpicker.Color
        end

        function Colorpicker:SlideHue(Input)
            if not Input or not SlidingHue then 
                return
            end

            local ValueX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

            Colorpicker.Hue = ValueX

            local PositionX = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.994)

            Items["HueDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PositionX, 0, 0, 0)})
            Colorpicker:Update()
        end

        local OldAlpha = Colorpicker.Alpha

        function Colorpicker:SlideAlpha(Input)
            if not Input or not SlidingAlpha then 
                return
            end

            local ValueX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)
            
            Colorpicker.Alpha = ValueX

            OldAlpha = Colorpicker.Alpha

            local PositionX = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 0.994)

            Items["AlphaDragger"]:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(PositionX, 0, 0, 0)})
            Colorpicker:Update(true)
        end

        Colorpicker.OnAnimationChanged = function(Value)
            if Value == "Rainbow" then
                OldColor = Colorpicker.Color
                Library:Thread(function()
                    while task.wait() do 
                        local RainbowHue = MathAbs(MathSin(tick() * Colorpicker.CurrentAnimationSpeed))
                        local Color = FromHSV(RainbowHue, 1, 1)

                        Colorpicker:Set(Color, Colorpicker.Alpha)

                        if Colorpicker.CurrentAnimation ~= "Rainbow" then
                            Colorpicker:Set(OldColor, Colorpicker.Alpha)
                            break
                        end
                    end
                end)
            end

            if Value == "Fade Alpha" then
                Library:Thread(function()
                    while task.wait() do
                        local AlphaIntensity = Colorpicker.CurrentAnimationIntensity
                        local Alpha = MathAbs(MathSin(tick() % AlphaIntensity) * Colorpicker.CurrentAnimationSpeed)

                        Colorpicker:Set(Colorpicker.Color, Alpha)

                        if Colorpicker.CurrentAnimation ~= "Fade Alpha" then
                            Colorpicker:Set(Colorpicker.Color, OldAlpha)
                            break
                        end
                    end
                end)
            end
        end

        Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
            Colorpicker:SetOpen(not Colorpicker.IsOpen)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                if Debounce then 
                    return 
                end

                if not Colorpicker.IsOpen then 
                    return 
                end

                if Library:IsMouseOverFrame(Items["ColorpickerWindow"]["Outline"].Instance) then 
                    return 
                end

                Colorpicker:SetOpen(false)
            end
        end)

        Items["Palette"]:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingPalette = true
                Colorpicker:SlidePalette(Input)
            end
        end)

        Items["Palette"]:Connect("InputEnded", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingPalette = false
            end
        end)

        Items["Hue"]:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingHue = true
                Colorpicker:SlideHue(Input)
            end
        end)

        Items["Hue"]:Connect("InputEnded", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingHue = false
            end
        end)

        Items["Alpha"]:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingAlpha = true
                Colorpicker:SlideAlpha(Input)
            end
        end)

        Items["Alpha"]:Connect("InputEnded", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                SlidingAlpha = false
            end
        end)

        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                if SlidingPalette then
                    Colorpicker:SlidePalette(Input)
                end

                if SlidingHue then
                    Colorpicker:SlideHue(Input)
                end

                if SlidingAlpha then
                    Colorpicker:SlideAlpha(Input)
                end
            end
        end)

        if Data.Default then
            Colorpicker:Set(Data.Default, Data.Alpha)
        end

        Library.SetFlags[Colorpicker.Flag] = function(Value)
            Colorpicker:Set(Value, Colorpicker.Alpha)
        end

        return Colorpicker, Items
    end

    Components.Label = function(Data)
        local Items = { } do 
            Items["Label"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 15),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Label"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Data.Text,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment[Data.Alignment],
                BorderSizePixel = 0,
                RichText = true,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
        end

        return Items
    end

    Components.Keybind = function(Data)
        local Keybind = {
            Toggled = false,
            Key = nil,
            Value = "",
            Mode = "",

            Flag = Data.Flag,

            IsOpen = false,
        }

        local KeybindListItem

        if Library.KeyList then 
            KeybindListItem = Library.KeyList:Add("None", "None", "None")
        end

        local Items = { } do
            Items["KeyButton"] = Instances:Create("TextButton", {
                Parent = Data.Parent.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "[-]",
                AutomaticSize = Enum.AutomaticSize.X,
                Name = "\0",
                AutoButtonColor = false,
                AnchorPoint = Vector2New(1, 0),
                Size = UDim2New(0, 0, 1, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(1, 0, 0, 0),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["KeyButton"]:AddToTheme({TextColor3 = "Text"})

            if Data.Tooltip then 
                Items["KeyButton"]:Tooltip(Data.Tooltip)
            end

            Items["KeybindWindow"] = Components.Window({
                Position = UDim2New(1, 0, 0, 25),
                Size = UDim2New(0, 70, 0, 75),
                Parent = Data.Parent,
                IsTextButton = true,
                Draggable = false
            })

            Instances:Create("UIStroke", {
                Parent = Items["KeybindWindow"]["Outline"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Outline"})

            Items["KeybindWindow"]["Outline"].Instance.Visible = false 
            Items["KeybindWindow"]["Outline"].Instance.AnchorPoint = Vector2New(1, 0)

            Items["Toggle"] = Instances:Create("TextButton", {
                Parent = Items["KeybindWindow"]["Outline"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(31, 226, 130),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Toggle",
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 8),
                BorderSizePixel = 0,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Toggle"]:AddToTheme({TextColor3 = "Text"})

            Items["Hold"] = Instances:Create("TextButton", {
                Parent = Items["KeybindWindow"]["Outline"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Hold",
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 30),
                BorderSizePixel = 0,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Hold"]:AddToTheme({TextColor3 = "Text"})

            Items["Always"] = Instances:Create("TextButton", {
                Parent = Items["KeybindWindow"]["Outline"].Instance,
                TextWrapped = true,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Always",
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 52),
                BorderSizePixel = 0,
                FontFace = Library.Font,
                TextSize = 12,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Always"]:AddToTheme({TextColor3 = "Text"})
        end

        local Modes = {
            ["Toggle"] = Items["Toggle"],
            ["Hold"] = Items["Hold"],
            ["Always"] = Items["Always"]
        }

        local Debounce = false

        local Update = function()
            if KeybindListItem then
                KeybindListItem:Set(Keybind.Mode, Data.Name, Keybind.Value)
                KeybindListItem:SetStatus(Keybind.Toggled)
            end
        end

        function Keybind:Get()
           return Keybind.Toggled, Keybind.Key, Keybind.Mode 
        end

        function Keybind:SetVisibility(Bool)
            Items["KeyButton"].Instance.Visible = Bool
        end

        function Keybind:SetOpen(Bool)
            Keybind.IsOpen = Bool

            if Bool then 
                Debounce = true
                Items["KeybindWindow"]["Outline"].Instance.Visible = true
                Items["KeybindWindow"]["Outline"].Instance.ZIndex = 16

                for Index, Value in Items["KeybindWindow"]["Outline"].Instance:GetDescendants() do 
                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = 17
                end

                task.wait(0.1)
                Debounce = false
            else 
                for Index, Value in Items["KeybindWindow"]["Outline"].Instance:GetDescendants() do 
                    if StringFind(Value.ClassName, "UI") then
                        continue
                    end

                    Value.ZIndex = 17
                end
                
                Items["KeybindWindow"]["Outline"].Instance.ZIndex = 1
                Items["KeybindWindow"]["Outline"].Instance.Visible = false
                Debounce = false
            end
        end

        function Keybind:Set(Key)
            if StringFind(tostring(Key), "Enum") then 
                Keybind.Key = tostring(Key)

                Key = Key.Name == "Backspace" and "[-]" or Key.Name

                local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                Keybind.Value = TextToDisplay
                Items["KeyButton"].Instance.Text = TextToDisplay

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }
    
                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end

                Update()
           elseif TableFind({"Toggle", "Hold", "Always"}, Key) then 
                Keybind.Mode = Key
                
                Keybind:SetMode(Key)

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Keybind.Toggled)
                end
            elseif type(Key) == "table" then 
                local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                Keybind.Key = tostring(Key.Key)

                if Key.Mode then
                    Keybind.Mode = Key.Mode
                    Keybind:SetMode(Key.Mode)
                else
                    Keybind.Mode = "Toggle"
                    Keybind:SetMode("Toggle")
                end

                local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                Keybind.Value = TextToDisplay
                Items["KeyButton"].Instance.Text = TextToDisplay

                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end

                Update()
            end

            Keybind.Picking = false
            Items["KeyButton"]:ChangeItemTheme({TextColor3 = "Text"})
            Items["KeyButton"]:Tween(nil, {TextColor3 = Library.Theme.Text})
        end

        function Keybind:SetMode(Mode)
            for Index, Value in Modes do 
                if Index == Mode then 
                    Value:ChangeItemTheme({TextColor3 = "Accent"})
                    Value:Tween(nil, {TextColor3 = Library.Theme.Accent})
                else
                    Value:ChangeItemTheme({TextColor3 = "Text"})
                    Value:Tween(nil, {TextColor3 = Library.Theme.Text})
                end
            end

            if Keybind.Mode == "Always" then 
                Keybind.Toggled = true
            else
                Keybind.Toggled = false
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Keybind.Toggled)
            end

            Update()
        end

        function Keybind:Press(Bool)
            if Keybind.Mode == "Toggle" then
                Keybind.Toggled = not Keybind.Toggled
            elseif Keybind.Mode == "Hold" then
                Keybind.Toggled = Bool
            elseif Keybind.Mode == "Always" then
                Keybind.Toggled = true
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Keybind.Toggled)
            end

            Update()
        end

        Items["KeyButton"]:Connect("MouseButton1Click", function()
            if Keybind.Picking then 
                return
            end

            Keybind.Picking = true

            Items["KeyButton"]:ChangeItemTheme({TextColor3 = "Accent"})
            Items["KeyButton"]:Tween(nil, {TextColor3 = Library.Theme.Accent})

            local InputBegan 
            InputBegan = UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.Keyboard then 
                    Keybind:Set(Input.KeyCode)
                else
                    Keybind:Set(Input.UserInputType)
                end

                InputBegan:Disconnect()
                InputBegan = nil
            end)
        end)

        Items["KeyButton"]:Connect("MouseButton2Down", function()
            Keybind:SetOpen(not Keybind.IsOpen)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.Mode == "Toggle" then 
                    Keybind:Press()
                elseif Keybind.Mode == "Hold" then 
                    Keybind:Press(true)
                end
            end

            if Debounce then 
                return
            end

            if not Keybind.IsOpen then 
                return
            end

            if Library:IsMouseOverFrame(Items["KeybindWindow"]["Outline"].Instance) then 
                return
            end

            Keybind:SetOpen(false)
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.Mode == "Hold" then 
                    Keybind:Press(false)
                end
            end
        end)

        Items["Toggle"]:Connect("MouseButton1Down", function()
            Keybind.Mode = "Toggle"
            Keybind:SetMode("Toggle")
        end)

        Items["Always"]:Connect("MouseButton1Down", function()
            Keybind.Mode = "Always"
            Keybind:SetMode("Always")
        end)

        Items["Hold"]:Connect("MouseButton1Down", function()
            Keybind.Mode = "Hold"
            Keybind:SetMode("Hold")
        end)

        if Data.Default then 
            Keybind:Set({Key = Data.Default, Mode = Data.Mode})
        end

        Library.SetFlags[Keybind.Flag] = function(Value)
            Keybind:Set(Value)
        end

        return Keybind, Items
    end

    Components.Textbox = function(Data)
        local Textbox = {
            Value = "",

            Flag = Data.Flag
        }

        local Items = { } do
            Items["Textbox"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 37),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            if Data.Tooltip then 
                Items["Textbox"]:Tooltip(Data.Tooltip)
            end

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Textbox"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Data.Name,
                Name = "\0",
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 13),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["Background"] = Instances:Create("Frame", {
                Parent = Items["Textbox"].Instance,
                AnchorPoint = Vector2New(0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 17),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(63, 63, 63)
            })  Items["Background"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UIGradient", {
                Parent = Items["Background"].Instance,
                Rotation = 90,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 255, 255)), RGBSequenceKeypoint(1, FromRGB(127, 127, 127))}
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Background"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Inline"] = Instances:Create("TextBox", {
                Parent = Items["Background"].Instance,
                CursorPosition = -1,
                Name = "\0",
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                TextXAlignment = Enum.TextXAlignment.Left,
                FontFace = Library.Font,
                BackgroundTransparency = 1,
                PlaceholderColor3 = FromRGB(145, 145, 145),
                PlaceholderText = Data.Placeholder,
                ClearTextOnFocus = false,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Inline"]:AddToTheme({TextColor3 = "Text"})

            Instances:Create("UIPadding", {
                Parent = Items["Inline"].Instance,
                PaddingLeft = UDimNew(0, 5),
                PaddingBottom = UDimNew(0, 2)
            }) 
        end

        function Textbox:Get()
            return Textbox.Value
        end

        function Textbox:SetVisibility(Bool)
            Items["Textbox"].Instance.Visible = Bool
        end

        function Textbox:Set(Value)
            Textbox.Value = tostring(Value)

            Library.Flags[Textbox.Flag] = Textbox.Value

            Items["Inline"].Instance.Text = Textbox.Value

            if Data.Callback then
                Library:SafeCall(Data.Callback, Textbox.Value)
            end

            Items["Inline"]:ChangeItemTheme({TextColor3 = "Text"})
            Items["Inline"]:Tween(nil, {TextColor3 = Library.Theme.Text})
        end

        Items["Inline"]:Connect("Focused", function()
            Items["Inline"]:ChangeItemTheme({TextColor3 = "Accent"})
            Items["Inline"]:Tween(nil, {TextColor3 = Library.Theme.Accent})
        end)

        Items["Inline"]:Connect("FocusLost", function()
            Textbox:Set(Items["Inline"].Instance.Text)
        end)

        if Data.Default then 
            Textbox:Set(Data.Default)
        end

        Library.SetFlags[Textbox.Flag] = function(Value)
            Textbox:Set(Value)
        end

        return Textbox, Items 
    end

    Components.Listbox = function(Data)
        local Listbox = { 
            Value = { },
            Flag = Data.Flag,
            Options = { }
        }

        local Items = { } do
            Items["Listbox"] = Instances:Create("Frame", {
                Parent = Data.Parent.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(68, 68, 68),
                Size = UDim2New(1, 0, 0, Data.Size),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Listbox"]:AddToTheme({BackgroundColor3 = "Inline"})

            Instances:Create("UIStroke", {
                Parent = Items["Listbox"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Holder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Listbox"].Instance,
                ScrollBarImageColor3 = FromRGB(0, 0, 0),
                MidImage = "rbxassetid://7783554086",
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BackgroundColor3 = FromRGB(255, 255, 255),
                TopImage = "rbxassetid://7783554086",
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                BottomImage = "rbxassetid://7783554086",
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Padding = UDimNew(0, 1),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
        end

        function Listbox:Set(Option)
            if Data.Multi then
                if type(Option) ~= "table" then 
                    return
                end

                Listbox.Value = Option
                Library.Flags[Listbox.Flag] = Listbox.Value

                for Index, Value in Option do 
                    local OptionData = Listbox.Options[Value]
                    
                    if not OptionData then 
                        return
                    end

                    OptionData.Selected = true
                    OptionData:Toggle("Active")
                end
            else
                local OptionData = Listbox.Options[Option]

                if not OptionData then 
                    return 
                end

                OptionData.Selected = true  
                OptionData:Toggle("Active")

                Listbox.Value = OptionData.Name
                Library.Flags[Listbox.Flag] = Listbox.Value

                for Index, Value in Listbox.Options do 
                    if Value ~= OptionData then 
                        Value.Selected = false
                        Value:Toggle("Inactive")
                    end
                end
            end

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Listbox.Value)
            end
        end

        function Listbox:SetVisibility(Bool)
            Items["Listbox"].Instance.Visible = Bool
        end

        function Listbox:Remove(Option)
            if Listbox.Options[Option] then 
                Listbox.Options[Option].OptionButton:Clean()
            end
        end

        function Listbox:Refresh(List)
            for Index, Value in Listbox.Options do 
                Listbox:Remove(Value.Name)
            end

            for Index, Value in List do 
                Listbox:Add(Value)
            end
        end

        function Listbox:Add(Option)
            local OptionButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Option,
                AutoButtonColor = false,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Center,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  OptionButton:AddToTheme({TextColor3 = "Text"})

            Instances:Create("UIPadding", {
                Parent = OptionButton.Instance,
                PaddingTop = UDimNew(0, 5),
                PaddingLeft = UDimNew(0, 7)
            })

            local OptionData = {
                Name = Option,
                OptionButton = OptionButton,
                Selected = false
            }

            function OptionData:Toggle(Status)
                if Status == "Active" then 
                    OptionData.OptionButton:ChangeItemTheme({TextColor3 = "Accent"})
                    OptionData.OptionButton:Tween(nil, {TextColor3 = Library.Theme.Accent})
                else
                    OptionData.OptionButton:ChangeItemTheme({TextColor3 = "Text"})
                    OptionData.OptionButton:Tween(nil, {TextColor3 = Library.Theme.Text})
                end
            end

            function OptionData:Set()
                OptionData.Selected = not OptionData.Selected

                if Data.Multi then 
                    local Index = TableFind(Listbox.Value, OptionData.Name)

                    if Index then 
                        TableRemove(Listbox.Value, Index)
                    else
                        TableInsert(Listbox.Value, OptionData.Name)
                    end

                    Library.Flags[Listbox.Flag] = Listbox.Value

                    OptionData:Toggle(Index and "Inactive" or "Active")
                else
                    if OptionData.Selected then
                        Listbox.Value = OptionData.Name

                        OptionData:Toggle("Active")

                        Library.Flags[Listbox.Flag] = Listbox.Value

                        for Index, Value in Listbox.Options do 
                            if Value ~= OptionData then 
                                Value.Selected = false
                                Value:Toggle("Inactive")
                            end
                        end
                    else
                        Listbox.Value = nil

                        OptionData:Toggle("Inactive")

                        Library.Flags[Listbox.Flag] = Listbox.Value
                    end
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Listbox.Value)
                end
            end

            OptionData.OptionButton:Connect("MouseButton1Down", function()
                OptionData:Set()
            end)

            Listbox.Options[Option] = OptionData
            return OptionData
        end

        function Listbox:Get()
            return Listbox.Value
        end

        for Index, Value in Data.Items do 
            Listbox:Add(Value)
        end

        if Data.Default then 
            Listbox:Set(Listbox.Default)
        end

        Library.SetFlags[Listbox.Flag] = function(Value)
            Listbox:Set(Value)    
        end

        return Listbox, Items
    end

    Library.Window = function(self, Data)
        Data = Data or { }

        local Window = {
            Name = Data.Name or Data.name or "Window",
            Size = Data.Size or Data.size or UDim2New(0, 563, 0, 558),

            GradientTitle = Data.GradientTitle or Data.gradienttitle or false,

            Pages = { },
            Sections = { },

            IsOpen = true,

            Items = { }
        }

        local Items = Components.Window({
            Position = UDim2New(0, Camera.ViewportSize.X / 4, 0, Camera.ViewportSize.Y / 3),
            Size = Window.Size,
            Parent = self.Holder,
            Draggable = true
        }) do 
            Items["Title"] = Instances:Create("Frame", {
                Parent = Items["Inline"].Instance,
                Name = "\0",
                Position = UDim2New(0, 13, 0, 20),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.188, 0, 0, 37),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Title"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Title"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Title"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Window.Name,
                Name = "\0",
                Size = UDim2New(1, 0, 1, -1),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, -1),
                BorderSizePixel = 0,
                RichText = true,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            if Window.GradientTitle.Enabled then
                local UIGradient = Instances:Create("UIGradient", {
                    Parent = Items["Text"].Instance,
                    Rotation = 0,
                    Color = RGBSequence{
                        RGBSequenceKeypoint(0, Window.GradientTitle.Start),
                        RGBSequenceKeypoint(0.25, Window.GradientTitle.Middle),
                        RGBSequenceKeypoint(1, Window.GradientTitle.End)
                    }
                })

                Items["Text"].Instance.TextColor3 = FromRGB(255, 255, 255)

                Library:Connect(RunService.Heartbeat, function()
                    local GradientOffset = MathAbs(MathSin(tick() * Window.GradientTitle.Speed))
                    UIGradient.Instance.Offset = Vector2New(GradientOffset, 0)   
                end)
            else
                Items["Text"]:AddToTheme({TextColor3 = "Text"})
            end

            Items["Pages"] = Instances:Create("Frame", {
                Parent = Items["Inline"].Instance,
                Name = "\0",
                Position = UDim2New(0.188, 28, 0, 20),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0.736, 0, 0, 37),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(13, 13, 13)
            })  Items["Pages"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Pages"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["RealHolder"] = Instances:Create("Frame", {
                Parent = Items["Pages"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 20, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -40, 1, 0),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["RealHolder"].Instance,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = UDimNew(0, 15),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Content"] = Instances:Create("Frame", {
                Parent = Items["Inline"].Instance,
                Name = "\0",
                Position = UDim2New(0, 13, 0, 77),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -28, 1, -93),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(12, 12, 12)
            })  Items["Content"]:AddToTheme({BackgroundColor3 = "Inline", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Content"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})
        end

        function Window:SetOpen(Bool)
            Window.IsOpen = Bool

            Items["Outline"].Instance.Visible = Bool
        end

        Library:Connect(UserInputService.InputBegan, function(Input, GameProcessed)
            if GameProcessed then 
                return
            end

            if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                Window:SetOpen(not Window.IsOpen)
            end
        end)

        Window.Items = Items
        return setmetatable(Window, self)
    end

    Library.Page = function(self, Data)
        Data = Data or { }

        local Page = {
            Window = self,

            Name = Data.Name or Data.name or "Page",
            Columns = Data.Columns or Data.columns or 2,

            ColumnsData = { },

            Active = false,

            Items = { }
        }

        local NewPage, Items = Components.Page({
            HasColumns = true,
            PageHolder = Page.Window.Items["RealHolder"],
            Name = Page.Name,
            PagesTable = Page.Window.Pages,
            ContentHolder =  Page.Window.Items["Content"],
        }) do 
            for Index = 1, Page.Columns do 
                local NewColumn = NewPage:Column(Index)
                Page.ColumnsData[Index] = NewColumn
            end
        end

        function Page:Turn(Bool)
            NewPage:Turn(Bool)
        end

        function Page:Column(ColumnIndex)
            NewPage:Column(ColumnIndex)
        end
        
        Page.Items = Items
        return setmetatable(Page, Library.Pages)
    end

    Library.Pages.Section = function(self, Data)
        Data = Data or { }

        local Section = {
            Window = self.Window,
            Page = self,

            Name = Data.Name or Data.name or "Section",
            Side = Data.Side or Data.side or 1,

            Items = { }
        }

        local Items = Components.Section({
            Name = Section.Name,
            Parent = Section.Page.ColumnsData[Section.Side],
        })

        Section.Items = Items
        return setmetatable(Section, Library.Sections)
    end

    Library.Pages.PlayerList = function(self, Data)
        local Playerlist = {
            Window = self.Window,
            Page = self,

            CurrentPlayer = nil,

            Players = { }
        }

        if Playerlist.Page.Columns ~= 1 then
            Library:Notification("Playerlist can only be added to a page with 1 column.", 5, FromRGB(255, 0, 0))
            return 
        end

        local Items = { } do
            Items["Playerlist"] = Instances:Create("Frame", {
                Parent = Playerlist.Page.ColumnsData[1].Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -13, 0, 419),
                BorderSizePixel = 2,
                BackgroundColor3 = FromRGB(19, 19, 19)
            })  Items["Playerlist"]:AddToTheme({BackgroundColor3 = "Section Background", BorderColor3 = "Outline"})

            Instances:Create("UIStroke", {
                Parent = Items["Playerlist"].Instance,
                Color = FromRGB(68, 68, 68),
                LineJoinMode = Enum.LineJoinMode.Miter,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Title"] = Instances:Create("Frame", {
                Parent = Items["Playerlist"].Instance,
                Size = UDim2New(1, -4, 0, 2),
                Name = "\0",
                Position = UDim2New(0, 2, 0, -2),
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = FromRGB(31, 226, 130)
            })  Items["Title"]:AddToTheme({BackgroundColor3 = "Accent"})

            Instances:Create("UIGradient", {
                Parent = Items["Title"].Instance,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(226, 226, 226)), RGBSequenceKeypoint(1, FromRGB(255, 255, 255))},
                Transparency = NumSequence{NumSequenceKeypoint(0, 0.512499988079071), NumSequenceKeypoint(0.42, 0.768750011920929), NumSequenceKeypoint(1, 1)}
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Title"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Players",
                Size = UDim2New(0, 40, 0, 13),
                Name = "\0",
                Position = UDim2New(0, 9, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 12,
                BackgroundColor3 = FromRGB(19, 19, 19)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Section Background"})

            Instances:Create("UIPadding", {
                Parent = Items["Text"].Instance,
                PaddingLeft = UDimNew(0, 3),
                PaddingRight = UDimNew(0, 4),
                PaddingBottom = UDimNew(0, 2)
            })

            Items["Avatar"] = Instances:Create("ImageLabel", {
                Parent = Items["Playerlist"].Instance,
                ScaleType = Enum.ScaleType.Fit,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AnchorPoint = Vector2New(0, 1),
                Image = "rbxassetid://98200387761744",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 8, 1, -8),
                Size = UDim2New(0, 70, 0, 70),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Avatar"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Items["Holder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Playerlist"].Instance,
                ScrollBarImageColor3 = FromRGB(31, 226, 130),
                MidImage = "rbxassetid://7783554086",
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 1,
                Name = "\0",
                Size = UDim2New(1, -16, 0, 315),
                BackgroundColor3 = FromRGB(13, 13, 13),
                TopImage = "rbxassetid://7783554086",
                Position = UDim2New(0, 8, 0, 17),
                BorderColor3 = FromRGB(0, 0, 0),
                BottomImage = "rbxassetid://7783554086",
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })  Items["Holder"]:AddToTheme({BackgroundColor3 = "Inline", ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIStroke", {
                Parent = Items["Holder"].Instance,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                LineJoinMode = Enum.LineJoinMode.Miter
            }):AddToTheme({Color = "Outline"})

            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Padding = UDimNew(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            Items["Username"] = Instances:Create("TextLabel", {
                Parent = Items["Playerlist"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Username: sametexe009",
                Name = "\0",
                AnchorPoint = Vector2New(0, 1),
                Size = UDim2New(0, 185, 0, 15),
                BackgroundTransparency = 1,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2New(0, 88, 1, -68),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Username"]:AddToTheme({TextColor3 = "Text"})

            Items["UserID"] = Instances:Create("TextLabel", {
                Parent = Items["Playerlist"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Userid: 7596677757",
                Name = "\0",
                AnchorPoint = Vector2New(0, 1),
                Size = UDim2New(0, 200, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2New(0, 88, 1, -53),
                BorderSizePixel = 0,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["UserID"]:AddToTheme({TextColor3 = "Text"})
            
            Items["UserID"].Instance.Text = ""
            Items["Username"].Instance.Text = ""

            local PlayerStatusModeDropdown, PlayerStatusModeDropdownItems = Components.Dropdown({
                Name = "Status",
                Flag = "PlayerListPlayerStatus",
                Parent = Items["Playerlist"],
                Items = { "Neutral", "Priority", "Friendly" },
                Default = "All",
                MaxSize = 75,
                Callback = function(Value)
                    if Playerlist.Player then
                        if Playerlist.Player == LocalPlayer then
                            return
                        end

                        if Value == "Neutral" then
                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                                TextColor3 = FromRGB(180, 180, 180)
                            })

                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Neutral"
                        elseif Value == "Priority" then
                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                                TextColor3 = FromRGB(255, 50, 50)
                            })

                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Priority"
                        elseif Value == "Friendly" then
                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                                TextColor3 = FromRGB(83, 255, 83)
                            })

                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Friendly"
                        else
                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus:Tween(nil, {
                                TextColor3 = FromRGB(180, 180, 180)
                            })

                            Playerlist.Players[Playerlist.Player.Name].PlayerStatus.Instance.Text = "Neutral"
                        end
                    end
                end
            })

            PlayerStatusModeDropdownItems["Dropdown"].Instance.Position = UDim2New(1, -8, 1, -65)
            PlayerStatusModeDropdownItems["Dropdown"].Instance.Size = UDim2New(0, 200, 0, 17)
            PlayerStatusModeDropdownItems["Dropdown"].Instance.AnchorPoint = Vector2New(1, 1)
        end

        function Playerlist:Remove(Name)
            if Playerlist.Players[Name] then
                Playerlist.Players[Name].PlayerButton:Clean()
            end
            
            Playerlist.Players[Name] = nil
        end

        function Playerlist:Add(Player)
            local PlayerButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 20),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  

            local PlayerBackground = Instances:Create("Frame", {
                Parent = PlayerButton.Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 3, 0, 2),
                Size = UDim2New(1, -7, 1, -5),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(31, 31, 31)
            })  PlayerBackground:AddToTheme({BackgroundColor3 = "Window Background"})

            local PlayerName = Instances:Create("TextLabel", {
                Parent = PlayerButton.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Player.Name,
                Name = "\0",
                Size = UDim2New(0.35, 0, 1, -2),
                Position = UDim2New(0, 7, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  PlayerName:AddToTheme({TextColor3 = "Text"})

            Instances:Create("Frame", {
                Parent = PlayerName.Instance,
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(1, -7, 0.5, 1),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 1, 1, -8),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(0, 0, 0)
            }):AddToTheme({BackgroundColor3 = "Outline"})

            local PlayerTeam = Instances:Create("TextLabel", {
                Parent = PlayerButton.Instance,
                FontFace = Library.Font,
                TextColor3 = BrickColor.new(tostring(Player.TeamColor)).Color,
                BorderColor3 = FromRGB(0, 0, 0),
                Text = tostring(Player.Team) or "None",
                Name = "\0",
                Size = UDim2New(0.35, 0, 1, 0),
                Position = UDim2New(0.35, 8, 0, -1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  

            if PlayerTeam.Instance.Text == "None" then
                PlayerTeam.Instance.TextColor3 = FromRGB(180, 180, 180)
                PlayerTeam:AddToTheme({TextColor3 = "Text"})
            end

            Instances:Create("Frame", {
                Parent = PlayerTeam.Instance,
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 1),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 1, 1, -10),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(0, 0, 0)
            }):AddToTheme({BackgroundColor3 = "Outline"})

            local PlayerStatus = Instances:Create("TextLabel", {
                Parent = PlayerButton.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(180, 180, 180),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "Neutral",
                Name = "\0",
                Size = UDim2New(0.35, 0, 1, 0),
                Position = UDim2New(0.7, 16, 0, -1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                TextTruncate = Enum.TextTruncate.AtEnd,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  

            if Player == LocalPlayer then 
                PlayerStatus.Instance.TextColor3 = Library.Theme.Accent
                PlayerStatus.Instance.Text = "LocalPlayer"
                PlayerStatus:AddToTheme({TextColor3 = "Accent"})
            else
                PlayerStatus.Instance.TextColor3 = FromRGB(180, 180, 180)
                PlayerStatus.Instance.Text = "Neutral"
            end

            Instances:Create("Frame", {
                Parent = PlayerStatus.Instance,
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 1, 1, -10),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(0, 0, 0)
            }):AddToTheme({BackgroundColor3 = "Outline"})

            Instances:Create("Frame", {
                Parent = PlayerButton.Instance,
                AnchorPoint = Vector2New(0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 1),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(0, 0, 0)
            }):AddToTheme({BackgroundColor3 = "Outline"})

            local PlayerData = {
                Name = Player.Name,
                Selected = false,
                PlayerButton = PlayerButton,
                PlayerName = PlayerName,
                PlayerTeam = PlayerTeam,
                PlayerStatus = PlayerStatus,
                PlayerBackground = PlayerBackground,
                Player = Player
            }

            function PlayerData:Toggle(Status)
                if Status == "Active" then
                    PlayerData.PlayerName:ChangeItemTheme({TextColor3 = "Accent"})
                    PlayerData.PlayerName:Tween(nil, {TextColor3 = Library.Theme.Accent})

                    PlayerData.PlayerBackground:Tween(nil, {BackgroundTransparency = 0})
                else
                    PlayerData.PlayerName:ChangeItemTheme({TextColor3 = "Text"})
                    PlayerData.PlayerName:Tween(nil, {TextColor3 = Library.Theme.Text})

                    PlayerData.PlayerBackground:Tween(nil, {BackgroundTransparency = 1})
                end
            end

            function PlayerData:Set()
                PlayerData.Selected = not PlayerData.Selected

                if PlayerData.Selected then
                    Playerlist.Player = PlayerData.Player

                    for Index, Value in Playerlist.Players do 
                        Value.Selected = false
                        Value:Toggle("Inactive")
                    end

                    PlayerData:Toggle("Active")

                    local PlayerAvatar = Players:GetUserThumbnailAsync(Playerlist.Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                    Items["Avatar"].Instance.Image = PlayerAvatar
                    Items["Username"].Instance.Text = Playerlist.Player.DisplayName .. " (@" .. Playerlist.Player.Name .. ")"
                    Items["UserID"].Instance.Text = tostring(Playerlist.Player.UserId)
                else
                    Playerlist.Player = nil
                    PlayerData:Toggle("Inactive")
                    Items["Avatar"].Instance.Image = "rbxassetid://98200387761744"
                    Items["Username"].Instance.Text = "None"
                    Items["UserID"].Instance.Text = "None"
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Playerlist.Player, PlayerData.PlayerStatus, PlayerData.PlayerTeam)
                end
            end

            PlayerData.PlayerButton:Connect("MouseButton1Down", function()
                PlayerData:Set()
            end)

            Playerlist.Players[PlayerData.Name] = PlayerData
            return PlayerData
        end

        for Index, Value in Players:GetPlayers() do 
            Playerlist:Add(Value)
        end

        Library:Connect(Players.PlayerRemoving, function(Player)
            if Playerlist.Players[Player.Name] then 
                Playerlist:Remove(Player.Name)
            end
        end)

        Library:Connect(Players.PlayerAdded, function(Player)
            Playerlist:Add(Player)
        end)

        return Playerlist
    end

    Library.Sections.Toggle = function(self, Data)
        Data = Data or { }

        local Toggle = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Toggle",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or false,
            Callback = Data.Callback or Data.callback or function() end,
            Risky = Data.Risky or Data.risky or false,
            Tooltip = Data.Tooltip or Data.tooltip or nil,

            Value = false,
            Count = 0
        }

        local NewToggle, Items = Components.Toggle({
            Name = Toggle.Name,
            Parent = Toggle.Section.Items["Content"],
            Risky = Toggle.Risky,
            Flag = Toggle.Flag,
            Default = Toggle.Default,
            Callback = Toggle.Callback,
            Tooltip = Toggle.Tooltip
        })

        function Toggle:Set(Value)
            NewToggle:Set(Value)
        end

        function Toggle:Get()
            return NewToggle:Get()
        end

        function Toggle:SetVisibility(Value)
            NewToggle:SetVisibility(Value)
        end

        function Toggle:Colorpicker(Data)
            Data = Data or { } 

            local Colorpicker = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Colorpicker",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                Callback = Data.Callback or Data.callback or function() end,
                Alpha = Data.Alpha or Data.alpha or false,
                Count = Toggle.Count
            }

            Toggle.Count += 1
            Colorpicker.Count = Toggle.Count

            local NewColorpicker, ColorpickerItems = Components.Colorpicker({
                Name = Colorpicker.Name,
                Parent = Items["Toggle"],
                Flag = Colorpicker.Flag,
                Default = Colorpicker.Default,
                Callback = Colorpicker.Callback,
                Count = Colorpicker.Count,
                Alpha = Colorpicker.Alpha
            })

            function Colorpicker:Set(Value, Alpha)
                NewColorpicker:Set(Value, Alpha)
            end

            function Colorpicker:Get()
                return NewColorpicker:Get()
            end

            function Colorpicker:SetVisibility(Bool)
                NewColorpicker:SetVisibility(Bool)
            end

            return Colorpicker
        end

        function Toggle:Keybind(Data)
            Data = Data or { }

            local Keybind = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Keybind",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Enum.KeyCode.RightControl,
                Mode = Data.Mode or Data.mode or "Toggle",
                Callback = Data.Callback or Data.callback or function() end,
                Tooltip = Data.Tooltip or Data.tooltip or nil,
                Count = Toggle.Count
            }

            local NewKeybind, KeybindItems = Components.Keybind({
                Name = Keybind.Name,
                Parent = Items["Toggle"],
                Flag = Keybind.Flag,
                Default = Keybind.Default,
                Tooltip = Keybind.Tooltip,
                Mode = Keybind.Mode,
                Callback = Keybind.Callback,
                Count = Keybind.Count
            })

            function Keybind:Set(Value)
                NewKeybind:Set(Value)
            end

            function Keybind:Get()
                return NewKeybind:Get()
            end

            function Keybind:SetVisibility(Bool)
                NewKeybind:SetVisibility(Bool)
            end

            return Keybind
        end

        return Toggle
    end

    Library.Sections.Button = function(self, Data)
        Data = Data or { }

        local Button = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Button",
            Callback = Data.Callback or Data.callback or function() end,
            Tooltip = Data.Tooltip or Data.tooltip or nil,
            Risky = Data.Risky or Data.risky or false
        }

        local NewButton, Items = Components.Button({
            Name = Button.Name,
            Parent = Button.Section.Items["Content"],
            Callback = Button.Callback,
            Tooltip = Button.Tooltip,
            Risky = Button.Risky
        })

        function Button:SetVisibility(Bool)
            Button:SetVisibility(Bool)
        end

        function Button:SubButton(Data)
            Data = Data or { }

            local SubButton = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Button",
                Callback = Data.Callback or Data.callback or function() end,
                Parent = Button.Section.Items["Content"],
                Tooltip = Data.Tooltip or Data.tooltip or nil,
                Risky = Data.Risky or Data.risky or false
            }

            local NewSubbutton, SubItems = NewButton:SubButton(SubButton)

            function SubButton:SetVisibility(Bool)
                NewSubbutton:SetVisibility(Bool)
            end

            return SubButton
        end

        return Button
    end

    Library.Sections.Slider = function(self, Data)
        Data = Data or { }

        local Slider = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Slider",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Min = Data.Min or Data.min or 0,
            Default = Data.Default or Data.default or 0,
            Max = Data.Max or Data.max or 100,
            Tooltip = Data.Tooltip or Data.tooltip or nil,
            Suffix = Data.Suffix or Data.suffix or "",
            Decimals = Data.Decimals or Data.decimals or 1,
            Callback = Data.Callback or Data.callback or function() end,
        }

        local NewSlider, Items = Components.Slider({
            Name = Slider.Name,
            Parent = Slider.Section.Items["Content"],
            Flag = Slider.Flag,
            Min = Slider.Min,
            Default = Slider.Default,
            Max = Slider.Max,
            Tooltip = Slider.Tooltip,
            Suffix = Slider.Suffix,
            Decimals = Slider.Decimals,
            Callback = Slider.Callback
        })

        function Slider:Set(Value)
            NewSlider:Set(Value)
        end

        function Slider:SetVisibility(Bool)
            NewSlider:SetVisibility(Bool)
        end

        return Slider
    end

    Library.Sections.Dropdown = function(self, Data)
        Data = Data or { }

        local Dropdown = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Dropdown",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Items = Data.Items or Data.items or { },
            Default = Data.Default or Data.default or nil,
            Callback = Data.Callback or Data.callback or function() end,
            Tooltip = Data.Tooltip or Data.tooltip or nil,
            MaxSize = Data.MaxSize or Data.maxsize or 75,
            Multi = Data.Multi or Data.multi or false,
        }

        local NewDropdown, Items = Components.Dropdown({
            Name = Dropdown.Name,
            Parent = Dropdown.Section.Items["Content"],
            Flag = Dropdown.Flag,
            Items = Dropdown.Items,
            Tooltip = Dropdown.Tooltip,
            MaxSize = Dropdown.MaxSize,
            Default = Dropdown.Default,
            Callback = Dropdown.Callback,
            Multi = Dropdown.Multi
        })

        function Dropdown:Set(Value)
            NewDropdown:Set(Value)
        end

        function Dropdown:Get()
            return NewDropdown:Get()
        end

        function Dropdown:SetVisibility(Bool)
            NewDropdown:SetVisibility(Bool)
        end

        function Dropdown:Refresh(List)
            NewDropdown:Refresh(List)
        end

        function Dropdown:Remove(Option)
            NewDropdown:Remove(Option)
        end

        function Dropdown:Add(Option)
            NewDropdown:Add(Option)
        end

        return Dropdown
    end

    Library.Sections.Label = function(self, Text, Alignment)
        local Label = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Text or "Label",
            Alignment = Alignment or "Left",

            Count = 0
        }
        
        local Items = Components.Label({
            Text = Label.Name,
            Parent = Label.Section.Items["Content"],
            Alignment = Label.Alignment
        })

        function Label:SetVisibility(Bool)
            Items["Label"].Instance.Visible = Bool
        end

        function Label:Colorpicker(Data)
            Data = Data or { } 

            local Colorpicker = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Colorpicker",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
                Callback = Data.Callback or Data.callback or function() end,
                Alpha = Data.Alpha or Data.alpha or false,
                Count = Label.Count
            }

            Label.Count += 1
            Colorpicker.Count = Label.Count

            local NewColorpicker, ColorpickerItems = Components.Colorpicker({
                Name = Colorpicker.Name,
                Parent = Items["Label"],
                Flag = Colorpicker.Flag,
                Default = Colorpicker.Default,
                Callback = Colorpicker.Callback,
                Count = Colorpicker.Count,
                Alpha = Colorpicker.Alpha
            })

            function Colorpicker:Set(Value, Alpha)
                NewColorpicker:Set(Value, Alpha)
            end

            function Colorpicker:Get()
                return NewColorpicker:Get()
            end

            function Colorpicker:SetVisibility(Bool)
                NewColorpicker:SetVisibility(Bool)
            end

            return Colorpicker
        end

        function Label:Keybind(Data)
            Data = Data or { }

            local Keybind = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Keybind",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Enum.KeyCode.RightControl,
                Mode = Data.Mode or Data.mode or "Toggle",
                Callback = Data.Callback or Data.callback or function() end,
                Count = Label.Count
            }

            local NewKeybind, KeybindItems = Components.Keybind({
                Name = Keybind.Name,
                Parent = Items["Label"],
                Flag = Keybind.Flag,
                Default = Keybind.Default,
                Mode = Keybind.Mode,
                Callback = Keybind.Callback,
                Count = Keybind.Count
            })

            function Keybind:Set(Value)
                NewKeybind:Set(Value)
            end

            function Keybind:Get()
                return NewKeybind:Get()
            end

            function Keybind:SetVisibility(Bool)
                NewKeybind:SetVisibility(Bool)
            end

            return Keybind
        end

        return Label 
    end

    Library.Sections.Textbox = function(self, Data)
        Data = Data or { }

        local Textbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Textbox",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or "",
            Tooltip = Data.Tooltip or Data.tooltip or nil,
            Placeholder = Data.Placeholder or Data.placeholder or "...",
            Callback = Data.Callback or Data.callback or function() end,
        }

        local NewTextbox, Items = Components.Textbox({
            Name = Textbox.Name,
            Parent = Textbox.Section.Items["Content"],
            Flag = Textbox.Flag,
            Tooltip = Textbox.Tooltip,
            Default = Textbox.Default,
            Placeholder = Textbox.Placeholder,
            Callback = Textbox.Callback
        })

        function Textbox:Set(Value)
            NewTextbox:Set(Value)
        end

        function Textbox:Get()
            return NewTextbox:Get()
        end

        function Textbox:SetVisibility(Bool)
            NewTextbox:SetVisibility(Bool)
        end

        return Textbox
    end

    Library.Sections.Listbox = function(self, Data)
        Data = Data or { }

        local Listbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Listbox",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or { },
            Callback = Data.Callback or Data.callback or function() end,
            Multi = Data.Multi or Data.multi or false,
            Items = Data.Items or Data.items or { },
            Size = Data.Size or Data.size or 175
        }

        local NewListbox, Items = Components.Listbox({
            Name = Listbox.Name,
            Parent = Listbox.Section.Items["Content"],
            Flag = Listbox.Flag,
            Default = Listbox.Default,
            Callback = Listbox.Callback,
            Multi = Listbox.Multi,
            Items = Listbox.Items,
            Size = Listbox.Size
        })

        function Listbox:Set(Option)
            NewListbox:Set(Option)
        end

        function Listbox:Get()
            return NewListbox:Get()
        end

        function Listbox:Add(Option)
            NewListbox:Add(Option)
        end

        function Listbox:Remove(Option)
            NewListbox:Remove(Option)
        end

        function Listbox:Refresh(List)
            NewListbox:Refresh(List)
        end

        function Listbox:SetVisibility(Bool)
            NewListbox:SetVisibility(Bool)
        end

        return Listbox
    end
end

getgenv().Library = Library
return Library
