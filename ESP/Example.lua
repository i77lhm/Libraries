local workspace = cloneref(game:GetService("Workspace"))
local run = cloneref(game:GetService("RunService"))
local http_service = cloneref(game:GetService("HttpService"))
local players = cloneref(game:GetService("Players"))

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

local camera = workspace.CurrentCamera

local bones = {
    {"Head", "UpperTorso"},
    {"UpperTorso", "LowerTorso"},
    {"UpperTorso", "LeftUpperArm"},
    {"UpperTorso", "RightUpperArm"},
    {"LeftUpperArm", "LeftLowerArm"},
    {"RightUpperArm", "RightLowerArm"},
    {"LowerTorso", "LeftUpperLeg"},
    {"LowerTorso", "RightUpperLeg"},
    {"LeftUpperLeg", "LeftLowerLeg"},
    {"RightUpperLeg", "RightLowerLeg"},
}

local flags = { -- basically a substitute for ur ui flags (flags["wahdiuawdhwa"])
    ["Enabled"] = true;
    ["Names"] = true; 
    ["Name_Color"] = { Color = rgb(0, 255, 255) };
    ["Boxes"] = true;
    ["Box_Type"] = "Corner";
    ["Box_Color"] = { Color = rgb(0, 255, 0) };
    ["Healthbar"] = true; 
    ["Health_High"] = { Color = rgb(0, 255, 0) };
    ["Health_Low"] = { Color = rgb(255, 0, 0) };
    ["Distance"] = true;
    ["Weapon"] = true;
    ["Skeletons"] = true;
    ["Skeletons_Color"] = { Color = rgb(16, 0, 247) };
    ["Distance_Color"] = { Color = rgb(0, 255, 0) };
    ["Weapon_Color"] = { Color = rgb(0, 255, 255) }
}

local fonts = {}; do
    function Register_Font(Name, Weight, Style, Asset)
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
        writefile(Name .. ".font", http_service:JSONEncode(Data))

        return getcustomasset(Name .. ".font");
    end
    
    local ProggyTiny = Register_Font("adwdawdwadadwadawdawdawdawd!", 100, "Normal", {
        Id = "ProggyTinyyyy.ttf",
        Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/ProggyTiny.ttf"),
    })

    fonts = {
        main = Font.new(ProggyTiny, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
    }
end

local esp = { players = {}, screengui = Instance.new("ScreenGui", gethui()), cache = Instance.new("ScreenGui", gethui()), connections = {}}; do 
    esp.screengui.IgnoreGuiInset = true
    esp.screengui.Name = "\0"

    esp.cache.Enabled = false

    -- Functions 
        function esp:get_screen_pos(world_position)
            local viewport_size = camera.ViewportSize
            local local_position = camera.CFrame:pointToObjectSpace(world_position) 
            
            local aspect_ratio = viewport_size.x / viewport_size.y
            local half_height = -local_position.z * math.tan(math.rad(camera.FieldOfView / 2))
            local half_width = aspect_ratio * half_height
            
            local far_plane_corner = Vector3.new(-half_width, half_height, local_position.z)
            local relative_position = local_position - far_plane_corner
        
            local screen_x = relative_position.x / (half_width * 2)
            local screen_y = -relative_position.y / (half_height * 2)
        
            local is_on_screen = -local_position.z > 0 and screen_x >= 0 and screen_x <= 1 and screen_y >= 0 and screen_y <= 1
            
            -- returns in pixels as opposed to scale
            return Vector3.new(screen_x * viewport_size.x, screen_y * viewport_size.y, -local_position.z), is_on_screen
        end

        function esp:box_solve(torso)
            if not torso then
                return nil, nil, nil
            end
            
            local ViewportTop = torso.Position + (torso.CFrame.UpVector * 1.8) + camera.CFrame.UpVector
            local ViewportBottom = torso.Position - (torso.CFrame.UpVector * 2.5) - camera.CFrame.UpVector
            local Distance = (torso.Position - camera.CFrame.p).Magnitude

            local Top, TopIsRendered = esp:get_screen_pos(ViewportTop)
            local Bottom, BottomIsRendered = esp:get_screen_pos(ViewportBottom)

            local Width = math.max(math.floor(math.abs(Top.X - Bottom.X)), 3)
            local Height = math.max(math.floor(math.max(math.abs(Bottom.Y - Top.Y), Width / 2)), 3)
            local BoxSize = Vector2.new(math.floor(math.max(Height / 1.5, Width)), Height)
            local BoxPosition = Vector2.new(math.floor(Top.X * 0.5 + Bottom.X * 0.5 - BoxSize.X * 0.5), math.floor(math.min(Top.Y, Bottom.Y)))
            
            return BoxSize, BoxPosition, TopIsRendered, Distance
            
        end

        function esp:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in options do 
                ins[prop] = value
            end
            
            return ins 
        end

        function esp:create_object( player )
            esp[ player.Name ] = { objects = { }, info = {character = character; humanoid = humanoid}; drawings = { }} 
            local data = esp[ player.Name ] 

            local objects = data.objects; do
                objects[ "holder" ] = esp:create( "Frame" , {
                    Parent = esp.screengui;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                objects[ "box_outline" ] = esp:create( "UIStroke" , {
                    Parent = (flags["Boxes"] and flags["Box_Type"] ~= "Corner" and objects["holder"]) or esp.cache;
                    LineJoinMode = Enum.LineJoinMode.Miter
                });
                
                objects[ "name" ] = esp:create( "TextLabel" , {
                    FontFace = fonts.main;
                    Parent = objects[ "holder" ];
                    TextColor3 = flags["Name_Color"].Color;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = string.format("%s (@%s)", player.DisplayName, player.Name);
                    Name = "\0";
                    TextStrokeTransparency = 0;
                    AnchorPoint = vec2(0, 1);
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, -3);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 9;
                });
                
                objects[ "box_handler" ] = esp:create( "Frame" , {
                    Parent = (flags["Boxes"] and flags["Box_Type"] ~= "Corner" and objects["holder"]) or esp.cache;
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                objects[ "box_color" ] = esp:create( "UIStroke" , {
                    Color = rgb(255, 255, 255);
                    LineJoinMode = Enum.LineJoinMode.Miter;
                    Name = "\0";
                    Parent = objects[ "box_handler" ]
                });
                
                objects[ "outline" ] = esp:create( "Frame" , {
                    Parent = objects[ "box_handler" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                esp:create( "UIStroke" , {
                    Parent = objects[ "outline" ];
                    LineJoinMode = Enum.LineJoinMode.Miter
                });  
                
                -- Corner Boxes
                    objects[ "corners" ] = esp:create( "Frame" , {
                        Visible = true;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = flags["Boxes"] and flags["Box_Type"] == "Corner" and objects["holder"] or esp.cache;
                        BackgroundTransparency = 1;
                        Position = dim2(0, -1, 0, 2);
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });

                    objects[ "1" ] = esp:create( "Frame" , {
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(0, 0, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0.4, 0, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "1" ];
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "2" ] = esp:create( "Frame" , {
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(0, 0, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0.25, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "2" ];
                        Position = dim2(0, 1, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "3" ] = esp:create( "Frame" , {
                        AnchorPoint = vec2(1, 0);
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(1, 0, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0.4, 0, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "3" ];
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "4" ] = esp:create( "Frame" , {
                        AnchorPoint = vec2(1, 0);
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(1, 0, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 3, 0.25, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "4" ];
                        Position = dim2(0, 1, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "5" ] = esp:create( "Frame" , {
                        AnchorPoint = vec2(0, 1);
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(0, 0, 1, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0.4, 0, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "5" ];
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "6" ] = esp:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Rotation = 180;
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(0, 0, 1, -5);
                        AnchorPoint = vec2(0, 1);
                        Size = dim2(0, 3, 0.25, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "6" ];
                        Position = dim2(0, 1, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "7" ] = esp:create( "Frame" , {
                        AnchorPoint = vec2(1, 1);
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(1, 0, 1, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0.4, 0, 0, 3);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "7" ];
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                    
                    objects[ "7" ] = esp:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Rotation = 180;
                        Parent = objects[ "corners" ];
                        Name = "line";
                        Position = dim2(1, 0, 1, -5);
                        AnchorPoint = vec2(1, 1);
                        Size = dim2(0, 3, 0.25, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    esp:create( "Frame" , {
                        Parent = objects[ "7" ];
                        Position = dim2(0, 1, 0, -2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = flags["Box_Color"].Color
                    });
                -- 
                
                -- Healthbar
                    objects[ "healthbar_holder" ] = esp:create( "Frame" , {
                        AnchorPoint = vec2(1, 0);
                        Parent = flags["Healthbar"] and objects[ "holder" ] or esp.cache;
                        Name = "\0";
                        Position = dim2(0, -2, 0, -1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 4, 1, 2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    objects[ "healthbar" ] = esp:create( "Frame" , {
                        Parent = objects[ "healthbar_holder" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Distance esp
                    objects[ "distance" ] = esp:create( "TextLabel" , {
                        FontFace = fonts.main;
                        TextColor3 = flags["Distance_Color"].Color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "127st";
                        Parent = flags[ "Distance" ] and objects[ "holder" ] or esp.cache;
                        TextStrokeTransparency = 0;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, 3);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 9;
                    });                
                -- 

                -- Weapon esp
                    objects[ "weapon" ] = esp:create( "TextLabel" , {
                        FontFace = fonts.main;
                        TextColor3 = flags["Weapon_Color"].Color;
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "[ak-47]";
                        Parent = esp.cache;
                        TextStrokeTransparency = 0;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 1, 19);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 9;
                    });
                -- 
                
                -- Skeleton Lines
                    
                    for _, bone in bones do
                        local line = Drawing.new("Line")
                        line.Color = flags["Skeletons_Color"].Color;
                        line.Thickness = 1;
                        line.Visible = false;

                        data.drawings[#data.drawings + 1] = line;
                    end
                -- 
            end
            
            do --[[ data functions ]]
                data.health_changed = function( value )
                    if not flags[ "Healthbar" ] then 
                        return 
                    end

                    local selected_layout = objects[ player.Name ]
                    local humanoid = data.info.humanoid
                    
                    local multiplier = value / humanoid.MaxHealth
                    local color = flags[ "Health_Low" ].Color:Lerp( flags["Health_High"].Color, multiplier )
                    
                    objects[ "healthbar" ].Size = UDim2.new(1, -2, multiplier, -2)
                    objects[ "healthbar" ].Position = UDim2.new(0, 1, 1 - multiplier, 1)
                    objects[ "healthbar" ].BackgroundColor3 = color
                end

                data.tool_added = function( item )
                    if not item:IsA("Tool") then 
                        return 
                    end 

                    local exists = data.info.character:FindFirstChild(item.Name) 
                    print(exists, item.Name)
                    objects[ "weapon" ].Text = item.Name
                    objects[ "weapon" ].Parent = exists and objects[ "holder" ] or esp.cache
                end

                data.refresh_offsets = function()
                    local offset = 5; 

                    if objects["distance"].Parent == objects[ "holder" ] then 
                        offset += 5
                        objects[ "weapon" ].Position = dim2(0, 0, 1, offset)
                    end 

                    if objects[ "weapon" ].Parent == objects[ "holder" ] then 
                        offset += 5
                        objects[ "weapon" ].Position = dim2(0, 0, 1, offset)
                    end 
                end 

                data.refresh_descendants = function() 
                    local character = player.Character or player.CharacterAdded:Wait()
                    local humanoid = character:WaitForChild( "Humanoid" )
                    
                    data.info.character = character
                    data.info.humanoid = humanoid
                    data.info.rootpart = rootpart

                    humanoid.HealthChanged:Connect( data.health_changed )

                    character.ChildAdded:Connect( data.tool_added )
                    character.ChildRemoved:Connect( data.tool_added )

                    data.health_changed( data.info.humanoid.Health )
                end
            end 
            
            do --[[ init / connections ]]  
                data.refresh_descendants()

                data.health_changed( data.info.humanoid.Health )

                player.CharacterAdded:Connect( data.refresh_descendants )

                local tool = player.Character:FindFirstChildOfClass("Tool")

                if tool then
                    data.tool_added( tool )
                end 
            end 
        end

        function esp:remove_object(player)
            local holder = esp[player.Name]

            if not holder then return end 

            local objects = holder.objects
 
            for _, line in holder.drawings do 
                line:Remove()
            end
            
            objects[ "holder" ]:Destroy() 
            esp[player.Name] = nil
        end
        
        function esp.refresh_elements( )
            for _,v in players:GetPlayers() do 
                if v == players.LocalPlayer then 
                    continue
                end
                print("1")
                
                if not v.Character then 
                    continue 
                end 
                print("2")

                local path = esp[v.Name]
                local objects = path and path.objects
                
                if not objects then 
                    continue 
                end
                print("3")
                objects.holder.Parent = flags["Enabled"] and esp.screengui or esp.cache

                objects[ "name" ].Parent = flags["Names"] and objects["holder"] or esp.cache
                objects[ "name" ].TextColor3 = flags["Name_Color"].Color
                
                local is_corner = flags[ "Box_Type" ] == "Corner"

                if flags["Boxes"] then 
                    objects[ "corners" ].Parent = (is_corner and objects["holder"]) or esp.cache
                    objects[ "box_handler" ].Parent = (is_corner and esp.cache or objects[ "holder" ])
                    objects[ "box_outline" ].Parent = (is_corner and esp.cache or objects[ "holder" ]) 
                else
                    objects[ "corners" ].Parent =  esp.cache
                    objects[ "box_handler" ].Parent = esp.cache
                    objects[ "box_outline" ].Parent = esp.cache
                end 
                print("4")
                objects[ "box_color" ].Color = flags["Box_Color"].Color 

                for _, corner in objects[ "corners" ]:GetChildren() do
                    corner.Frame.BackgroundColor3 = flags["Box_Color"].Color
                end
                print("5")

                for _, line in path.drawings do
                    line.Color = flags["Skeletons_Color"].Color
                    line.Visible = flags["Skeletons"]
                end

                objects[ "healthbar_holder" ].Parent = flags[ "Healthbar" ] and objects[ "holder" ] or esp.cache
                print("6")
                objects[ "weapon" ].TextColor3 = flags["Weapon_Color"].Color
                objects[ "weapon" ].Parent = flags["Weapon"] and v.Character:FindFirstChildOfClass("Tool") and objects[ "holder" ] or esp.cache

                objects[ "distance" ].TextColor3 = flags["Distance_Color"].Color
                objects[ "distance" ].Parent = flags["Distance"] and objects[ "holder" ] or esp.cache
            end
        end

        esp.connection = run.RenderStepped:Connect(function()
            if not flags["Enabled"] then 
                return
            end

            for _, player in players:GetPlayers() do 
                local data = esp[player.Name]

                if not data then 
                    continue 
                end 

                local character = data.info.character
                local humanoid = data.info.humanoid 
                
                if not (character or humanoid) then 
                    continue 
                end 

                local objects = data and data.objects 

                if not objects then 
                    continue 
                end 

                local box_size, box_pos, on_screen, distance = esp:box_solve(humanoid.RootPart)
                local holder = objects[ "holder" ]

                if holder.Visible ~= on_screen then 
                    holder.Visible = on_screen
                end 

                -- Skeletons 
                    if flags["Skeletons"] and character:FindFirstChild("UpperTorso") then 
                        for i = 1, #bones do
                            local origin, destination = bones[i][1], bones[i][2]

                            if not data.drawings[i] then 
                                continue  
                            end 

                            local path = data.drawings[i]

                            local origin_3d = character:FindFirstChild(origin) 
                            local destination_3d = character:FindFirstChild(destination) 

                            if origin_3d and destination_3d then 
                                local origin_2d, on_screen_start = esp:get_screen_pos(origin_3d.Position)
                                local destination_2d, on_screen_end = esp:get_screen_pos(destination_3d.Position)
                                
                                if on_screen_start and on_screen_end then 
                                    path.Visible = true
                                    path.From = Vector2.new(origin_2d.X, origin_2d.Y)
                                    path.To = Vector2.new(destination_2d.X, destination_2d.Y)
                                else
                                    path.Visible = false
                                end 
                            end
                        end 
                    end 
                -- 

                if not on_screen then
                    continue
                end 
                
                local pos = dim_offset(box_pos.X, box_pos.Y) -- silly sanity check
                if pos ~= holder.Position then 
                    holder.Position = dim_offset(box_pos.X, box_pos.Y)
                end 

                local size = dim_offset(box_size.X, box_size.Y) -- more silly sanity checks
                if size ~= holder.Size then 
                    holder.Size = size
                end 

                local distance_label = objects[ "distance" ]
                if distance_label.Text ~= tostring( math.round(distance) )  .. "st" then 
                    distance_label.Text = tostring( math.round(distance) ) .. "st"
                end 

            end
        end)

        function esp:unload() 
            for _, player in players:GetPlayers() do 
                esp:remove_object(player)
            end 

            esp.connection:Disconnect() 
            esp.player_added:Disconnect() 
            esp.player_removed:Disconnect() 

            esp.cache:Destroy() 
            esp.screengui:Destroy()

            esp = nil
        end 
    -- 
end

for _,v in players:GetPlayers() do 
    if v ~= players.LocalPlayer then 
        esp:create_object(v)
    end 
end 

esp.player_added = players.PlayerAdded:Connect(function(v)
    esp:create_object(v)
end)

esp.player_removed = players.PlayerRemoving:Connect(function(v)
    esp:remove_object(v)
end)

flags = { -- basically a substitute for ur ui flags (flags["wahdiuawdhwa"])
    ["Enabled"] = true;
    ["Names"] = true; 
    ["Name_Color"] = { Color = rgb(255, 255, 255) };
    ["Boxes"] = true;
    ["Box_Type"] = "Corner";
    ["Box_Color"] = { Color = rgb(255, 255, 255) };
    ["Healthbar"] = true; 
    ["Health_High"] = { Color = rgb(0, 255, 0) };
    ["Health_Low"] = { Color = rgb(255, 0, 0) };
    ["Distance"] = true;
    ["Weapon"] = true;
    ["Skeletons"] = true;
    ["Skeletons_Color"] = { Color = rgb(255, 255, 255) };
    ["Distance_Color"] = { Color = rgb(255, 255, 255) };
    ["Weapon_Color"] = { Color = rgb(255, 255, 255) }
}; 
task.wait()
esp.refresh_elements()

--[[
    If you want to enable or change something you do this:
    (prefferably in a callback) 
]]

flags.Boxes = false 
esp.refresh_elements()

