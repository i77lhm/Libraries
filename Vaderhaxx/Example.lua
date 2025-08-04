local library, notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Vaderhaxx/Library.lua"))()

-- documentation 
    local window = library:window({})
    local watermark = library:watermark({name = "Expandable watermark"})

    local legit = window:tab({name = "legit"})
    local rage = window:tab({name = "rage"})
    local esp = window:tab({name = "esp"})
    local visuals = window:tab({name = "visuals"})
    local misc = window:tab({name = "misc"})
    local config = window:tab({name = "config"})
    
    do 
        local section = legit:section({name = "aim assist"})
        section:toggle({name = "enabled", flag = "legit_aimassist", default = false, tooltip = "master switch for aim assist, helps with aiming by moving your mouse for you based on the below settings"})
        section:slider({name = "speed", suffix = "%", flag = "legit_aimassistsmoothing", tooltip = "how fast the assist will help aim at the target"})
        section:dropdown({name = "smoothing", flag = "legit_aimassistsmoothingtype", items = {"exponential", "linear"}, multi = false, tooltip = "the type of smoothing of the aim aim assist"})
        section:slider({name = "randomisation", flag = "legit_aimassistrandomisation", default = 5, min =  0, max = 20, tooltip = "the randomisation of where the aim assist will be trying to aim at"})
        section:slider({name = "enemy switching delay", suffix = "ms", flag = "legit_aimassistswitchdelay", default = 100, min =  0, max = 2000, tooltip = "how long the aim assist will wait before locking onto a new player"})
        section:slider({name = "maximum lock-on time", suffix = "ms", flag = "legit_aimassistlockontime", default = 1000, min =  1, max = 2001, custom = {["2001"] = "inf"}, tooltip = "how long the aim assist will aim at a single target"})
        section:slider({name = "accuracy", suffix = "%", flag = "legit_aimassistaccuracy", default = 90, min =  0, max = 100, tooltip = "the chance that the hitscan priority will be considered before anything else"})
        section:dropdown({name = "activation", flag = "legit_aimassistactivation", items = {"mouse 1", "mouse 2", "always"}, multi = false, tooltip = "the aim assist will be actively aiming whilst this action is performed"})
        section:dropdown({name = "target priority", flag = "legit_aimassisttargpriority", items = {"closest", "enemy look direction"}, multi = false, tooltip = "the player that the aim assist will consider aiming at first"})
        section:dropdown({name = "hitscan priority", flag = "legit_aimassistpriority", items = {"closest", "head", "body"}, multi = false, tooltip = "the hitbox that the aim assist will consider aiming at first"})
        section:dropdown({name = "hitscan points", flag = "legit_aimassistpoints", items = {"head", "body", "arms", "legs"}, multi = true, tooltip = "the hitboxes that the aim assist will consider at all"})
        section:toggle({name = "require mouse movement", flag = "legit_aimonmousemove", default = false, tooltip = "requires you to be moving your mouse for the aim assist to assist your aim"})
        section:toggle({name = "require mouse nearing enemy", flag = "legit_aimonmousemoveatenemy", default = false, tooltip = "requires you to be moving your mouse towards the enemy for the aim assist to assist your aim"})
        section:toggle({name = "use barrel fov", flag = "legit_aimassistbarrelfov", default = false, tooltip = "bases fov from your barrel direction instead of camera direction"})
        section:toggle({name = "adjust for bullet drop", flag = "legit_bulletcompensation", default = false, tooltip = "will predict the bullet drop to a target once found and will compensate for it"})
        section:slider({name = "drop prediction inaccuracy", suffix = "%", flag = "legit_bulletdropaccuracy", default = 90, min =  0, max = 100, tooltip = "how accurate the bullet drop adjustment is"})
        section:toggle({name = "adjust for target movement", flag = "legit_movementcompensation", default = false, tooltip = "will predict the movement of the target and will compensate for it"})
        section:slider({name = "target prediction inaccuracy", suffix = "%", flag = "legit_movementtaccuracy", default = 80, min =  0, max = 100, tooltip = "how accurate the movement prediction adjustment is"})
        section:toggle({name = "adjust for barrel angle", flag = "legit_barrelcompensation", default = false, tooltip = "will predict where the bullet will be based off of your barrel and will assist you in pointing your barrel towards the enemy, helps with quickscoping and recoil control"})
        section:slider({name = "barrel adjustment inaccuracy", suffix = "%", flag = "legit_barrelaccuracy", default = 60, min =  0, max = 100, tooltip = "how accurate the barrel angle adjustment is"})
        
        local section = legit:section({name = "silent aim", side = "right"})
        section:toggle({name = "silent aim", flag = "legit_bulletredirection", default = false, tooltip = "master switch for silent aim, helps with aiming by automatically redirecting bullets based on the below settings"})
        section:slider({name = "silent aim fov", suffix = "°", flag = "legit_bulletredirectionfov", default = 15, min =  0, max = 90, tooltip = "the maximum fov of the silent aim, enemies within this fov will be considered and aimed at by the silent aim"})
        section:slider({name = "spread", suffix = "/10st", flag = "legit_bulletredirectiondeviation", default = 8, min =  0, max = 80, custom = {["0"] = "off"}, tooltip = "shoots around your enemy rather than the direct center of the hitbox to prevent shooting in a perfect line every time which can look blatant. the slider will determine (in studs) how much spread there will be at exactly 100 studs, scales linearly with distance. at 200 studs the amount of spread doubles and at 50 studs the amount is halved"})
        section:slider({name = "hit chance", suffix = "%", flag = "legit_bulletredirectionhitchance", default = 30, min =  0, max = 100, tooltip = "the chance that the silent aim will attempt to redirect a bullet"})
        section:slider({name = "accuracy", suffix = "%", flag = "legit_bulletredirectionaccuracy", default = 70, min =  0, max = 100, tooltip = "the chance that the hitscan priority will be considered before anything else"})
        section:dropdown({name = "hitscan priority", flag = "legit_bulletredirectionpriority", items = {"closest", "head", "body"}, multi = false, tooltip = "the hitbox that the silent aim will consider aiming at first"})
        section:dropdown({name = "hitscan points", flag = "legit_bulletredirectionpoints", items = {"head", "body", "arms", "legs"}, multi = true, tooltip = "the hitboxes that the silent aim will consider at all "})
        section:toggle({name = "use barrel fov", flag = "legit_silentbarrelfov", default = false, tooltip = "bases fov from your barrel instead of camera"})
        section:toggle({name = "auto wallbang", flag = "legit_bulletredirectionwallbang", default = false, tooltip = "will target enemies that can be wallbanged"})
        section:toggle({name = "instant hit", flag = "legit_silentinstanthit", default = false, tooltip = "instantly hits your shots. not garunteed to be undetected"})
        
        local section = legit:section({name = "triggerbot", side = "right"})
        local toggle = section:toggle({subsection = "trigger bot", name = "enabled", flag = "legit_triggerbot", default = false, tooltip = "master switch for trigger bot, helps with shooting by automatically clicking when an enemy intersects your bullet path"})
        toggle:keybind({subsection = "trigger bot", object = "enabled", name = "trigger bot key", flag = "legit_triggerbotkey", parentflag = "legit_triggerbot", default = Enum.KeyCode.M})
        section:slider({subsection = "trigger bot", name = "reaction time", suffix = "ms", flag = "legit_triggerbotspeed", default = 120, min =  0, max = 400, custom = {["0"] = "off"}, tooltip = "how long an enemy must intersect your bullet path before automatically clicking"})
        section:dropdown({subsection = "trigger bot", name = "triggerbot hitboxes", flag = "legit_triggerbotpoints", items = {"head", "body", "arms", "legs"}, multi = true, tooltip = "the hitboxes that the triggerbot will automatically click on"})
        section:toggle({subsection = "trigger bot", name = "auto wallbang", flag = "legit_triggerbotautowall", default = false, tooltip = "will automatically click when someone can be wallbanged by your bullet path"})
        section:toggle({subsection = "trigger bot", name = "magnet triggerbot", flag = "legit_magnet", default = false, tooltip = "master switch for the magnet, helps with aiming by applying a custom fov, smoothing and hitscan priority to the aim assist on triggerbot keybind"})
        section:slider({subsection = "trigger bot", name = "magnet fov", suffix = "°", flag = "legit_magnetfov", default = 80, min =  0, max = 180, tooltip = "the maximum fov of the aim assist when the magnet triggerbot is active"})
        section:slider({subsection = "trigger bot", name = "magnet speed", suffix = "%", flag = "legit_magnetsmoothing", default = 10, min =  0, max = 100, tooltip = "the smoothness of the aim assist when the magnet triggerbot is active"})
        section:dropdown({subsection = "trigger bot", name = "magnet priority", flag = "legit_magnetnpriority", items = {"closest", "head", "body"}, multi = false, tooltip = "the hitscan priority of the aim assist when the magnet triggerbot is active"})
    end 

    do 
        local enemy = esp:section({name = "enemy", fill = 0.5})
        local dropped = esp:section({name = "dropped"})
        local team = esp:section({name = "team", side = "right"})
        local esp_settings = esp:section({name = "esp_settings", fill = 0.1, side = "right"})

        enemy:toggle({name = "enabled", flag = "enemy_esp", default = false, tooltip = "enables enemy esp"})

        enemy:toggle({name = "bounding box", flag = "enemy_box", default = false, tooltip = "shows enemy boxes"})
        :colorpicker({object = "bounding box", name = "box", flag = "enemy_boxcolor", color = Color3.new(1, 0, 0)})
        enemy:toggle({name = "filled bounding box", flag = "enemy_filledbox", default = false, tooltip = "filles enemy boxes"})
        :colorpicker({object = "filled bounding box", name = "filled box", flag = "enemy_filledboxcolor", color = Color3.new(1, 0, 0), transparency = 0.8})
        
        enemy:toggle({name = "health bar", flag = "enemy_healthbar", default = false, tooltip = "shows enemy health bars"})
        :colorpicker({object = "health bar", name = "low health", flag = "enemy_lowhealth", color = Color3.fromRGB(255, 100, 100)})
        :colorpicker({object = "health bar", name = "full health", flag = "enemy_fullhealth", color = Color3.fromRGB(100, 255, 100)})
        enemy:toggle({name = "gradient health bar", flag = "enemy_gradienthealthbar", default = false, tooltip = "health bars will appear as gradients"})
        enemy:toggle({name = "health number", flag = "enemy_healthnumber", default = false, tooltip = "shows enemy health values"})
        :colorpicker({object = "health number", name = "health number", flag = "enemy_healthnumbercolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "display name", flag = "enemy_name", default = false, tooltip = "shows enemy names"})
        :colorpicker({object = "display name", name = "name", flag = "enemy_namecolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "rank", flag = "enemy_rank", default = false, tooltip = "shows enemy ranks"})
        :colorpicker({object = "rank", name = "rank", flag = "enemy_rankcolor", color = Color3.fromRGB(0, 219, 255)})

        enemy:toggle({name = "held weapon", flag = "enemy_heldweapon", default = false, tooltip = "shows the enemies held weapon"})
        :colorpicker({object = "held weapon", name = "held weapon", flag = "enemy_heldweaponcolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "distance", flag = "enemy_distance", default = false, tooltip = "shows the distance to the enemy"})
        :colorpicker({object = "distance", name = "distance", flag = "enemy_distancecolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "exploiting", flag = "enemy_exploit", default = false, tooltip = "shows when a enemy is using a time exploit, usually involved with fire rate modification, teleporting and fake position. delta is the time difference between packet times, changes between this indicates tick shifting. delay is how far the packet time stamp is, consider this how time travelled someone is. choke is when the last packet was sent. typically indicating fake lag"})
        :colorpicker({object = "exploiting", name = "exploit flag", flag = "enemy_exploitcolor", color = Color3.new(1, 0, 0)})

        enemy:toggle({name = "stance", flag = "enemy_stance", default = false, tooltip = "shows what stance a enemy has"})
        :colorpicker({object = "stance", name = "exploit flag", flag = "enemy_stancecolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "visible", flag = "enemy_visible", default = false, tooltip = "shows if a enemy is visible"})
        :colorpicker({object = "visible", name = "visible flag", flag = "enemy_visiblecolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "chams", flag = "enemy_chams", default = false, tooltip = "shows enemy chams"})
        :colorpicker({object = "chams", name = "inner cham", flag = "enemy_innerchamcolor", color = Color3.fromRGB(100, 0, 0), transparency = 155/255})
        :colorpicker({object = "chams", name = "outer cham", flag = "enemy_outerchamcolor", color = Color3.fromRGB(255, 0, 0), transparency = 0})

        enemy:toggle({name = "skeleton", flag = "enemy_skeleton", default = false, tooltip = "shows enemy skeletons"})
        :colorpicker({object = "skeleton", name = "skeleton", flag = "enemy_skeletoncolor", color = Color3.fromRGB(236, 251, 136)})

        enemy:toggle({name = "snap lines", flag = "enemy_snaplines", default = false, tooltip = "shows enemy snap lines"})
        :colorpicker({object = "snap lines", name = "snap line", flag = "enemy_snaplinescolor", color = Color3.new(1, 1, 1), transparency = 0})

        enemy:toggle({name = "view angle", flag = "enemy_viewangle", default = false, tooltip = "shows a line in the direction the enemy is looking"})
        :colorpicker({object = "view angle", name = "view angle", flag = "enemy_viewanglecolor", color = Color3.new(1, 1, 1)})

        enemy:toggle({name = "head dot", flag = "enemy_headdot", default = false, tooltip = "shows a circle at which shooting at will result in a headshot"})
        :colorpicker({object = "head dot", name = "head dot", flag = "enemy_headdotcolor", color = Color3.new(1, 0, 0)})

        enemy:toggle({name = "out of view", flag = "enemy_oov", default = false, tooltip = "shows an arrow pointing towards an enemy if they are not in view"})
        :colorpicker({object = "out of view", name = "arrow", flag = "enemy_oovcolor", color = Color3.new(1, 1, 1)})

        enemy:slider({name = "arrow distance", suffix = "%", flag = "arrow_distance", value = 30, minimum = 1, maximum = 100})
        enemy:slider({name = "arrow size", suffix = "%", flag = "arrow_size", value = 30, minimum = 1, maximum = 100})
        enemy:toggle({name = "dynamic arrow size", flag = "enemy_dynamicarrowsize", default = false, tooltip = "sizes the arrows based on distance"})
        enemy:toggle({name = "show resolved flag", flag = "enemy_showresolvedflag", default = false, tooltip = "highlights enemies that have been successfully resolved"})
        :colorpicker({object = "show resolved flag", name = "resolved", flag = "enemy_resolvedflagcolor", color = Color3.fromRGB(237, 229, 62)})

        dropped:toggle({name = "grenade warning", flag = "dropped_grenadewarning", default = false, tooltip = "predicts where nades will land and will display the danger level"})
        :colorpicker({object = "grenade warning", name = "low time", flag = "dropped_grenadehighcolor", color = Color3.fromRGB(255, 0, 0)})
        :colorpicker({object = "grenade warning", name = "high time", flag = "dropped_grenadelowcolor", color = Color3.fromRGB(0, 255, 0)})
        dropped:toggle({name = "grenade lines", flag = "dropped_grenadelines", default = false, tooltip = "displays a line that maps how a grenade will travel"})
        :colorpicker({object = "grenade lines", name = "line start", flag = "dropped_grenadealinecolor", color = Color3.fromRGB(81, 75, 242)})
        :colorpicker({object = "grenade lines", name = "line end", flag = "dropped_grenadeblinecolor", color = Color3.fromRGB(237, 85, 103)})
        dropped:toggle({name = "weapon names", flag = "dropped_weaponnames", default = false, tooltip = "shows weapon names"})
        :colorpicker({object = "weapon names", name = "weapon name", flag = "dropped_weaponnamecolor", color = Color3.fromRGB(255, 255, 255)})

        team:toggle({name = "enabled", flag = "team_esp", default = false, tooltip = "enables team esp"})

        team:toggle({name = "bounding box", flag = "team_box", default = false, tooltip = "shows team boxes"})
        :colorpicker({object = "bounding box", name = "box", flag = "team_boxcolor", color = Color3.new(0, 1, 0)})
        team:toggle({name = "filled bounding box", flag = "team_filledbox", default = false, tooltip = "fills team boxes"})
        :colorpicker({object = "filled bounding box", name = "filled box", flag = "team_filledboxcolor", color = Color3.new(0, 1, 0), transparency = 0.8})

        team:toggle({name = "health bar", flag = "team_healthbar", default = false, tooltip = "shows team health bars"})
        :colorpicker({object = "health bar", name = "low health", flag = "team_lowhealth", color = Color3.fromRGB(255, 100, 100)})
        :colorpicker({object = "health bar", name = "full health", flag = "team_fullhealth", color = Color3.fromRGB(100, 255, 100)})
        team:toggle({name = "gradient health bar", flag = "team_gradienthealthbar", default = false, tooltip = "health bars will appear as gradients"})
        team:toggle({name = "health number", flag = "team_healthnumber", default = false, tooltip = "shows enemy health values"})
        :colorpicker({object = "health number", name = "health number", flag = "team_healthnumbercolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "display name", flag = "team_name", default = false, tooltip = "shows team names"})
        :colorpicker({object = "display name", name = "name", flag = "team_namecolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "rank", flag = "team_rank", default = false, tooltip = "shows team ranks"})
        :colorpicker({object = "rank", name = "rank", flag = "team_rankcolor", color = Color3.fromRGB(0, 219, 255)})

        team:toggle({name = "held weapon", flag = "team_heldweapon", default = false, tooltip = "shows teammate held weapon"})
        :colorpicker({object = "held weapon", name = "held weapon", flag = "team_heldweaponcolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "distance", flag = "team_distance", default = false, tooltip = "shows the distance to teammate"})
        :colorpicker({object = "distance", name = "distance", flag = "team_distancecolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "exploiting", flag = "team_exploit", default = false, tooltip = "shows when a enemy is using a time exploit, usually involved with fire rate modification, teleporting and fake position. delta is the time difference between packet times, changes between this indicates tick shifting. delay is how far the packet time stamp is, consider this how time travelled someone is. choke is when the last packet was sent. typically indicating fake lag"})
        :colorpicker({object = "exploiting", name = "exploit flag", flag = "team_exploitcolor", color = Color3.new(1, 0, 0)})

        team:toggle({name = "stance", flag = "team_stance", default = false, tooltip = "shows what stance a teammate has"})
        :colorpicker({object = "stance", name = "stance flag", flag = "team_stance", color = Color3.new(1, 1, 1)})

        team:toggle({name = "visible", flag = "team_visible", default = false, tooltip = "shows if a teammate is visible"})
        :colorpicker({object = "visible", name = "visible flag", flag = "team_visiblecolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "chams", flag = "team_chams", default = false, tooltip = "shows teammate chams"})
        :colorpicker({object = "chams", name = "inner cham", flag = "team_innerchamcolor", color = Color3.fromRGB(0, 100, 0), transparency = 155/255})
        :colorpicker({object = "chams", name = "outer cham", flag = "team_outerchamcolor", color = Color3.fromRGB(0, 255, 0), transparency = 0})

        team:toggle({name = "skeleton", flag = "team_skeleton", default = false, tooltip = "shows teammate skeletons"})
        :colorpicker({object = "skeleton", name = "skeleton", flag = "team_skeletoncolor", color = Color3.fromRGB(236, 251, 136)})

        team:toggle({name = "view angle", flag = "team_viewangle", default = false, tooltip = "shows a line in the direction the teammate is looking"})
        :colorpicker({object = "view angle", name = "view angle", flag = "team_viewanglecolor", color = Color3.new(1, 1, 1)})

        team:toggle({name = "head dot", flag = "team_headdot", default = false, tooltip = "shows a circle at which shooting at will result in a headshot"})
        :colorpicker({object = "head dot", name = "head dot", flag = "team_headdotcolor", color = Color3.new(0, 1, 0)})

        esp_settings:slider({name = "max hp visiblity cap", suffix = "hp", flag = "espsettings_maxhp", value = 98, minimum = 0, maximum = 100, tooltip = "the highest a health value can be before showing health numbers"})
        esp_settings:dropdown({name = "text font", flag = "espsettings_font", items ={"Plex", "Monospace", "System", "UI"}, multi = false, tooltip = "the font of the main text"})
        esp_settings:dropdown({name = "text case", flag = "espsettings_case", items ={"lowercase", "UPPERCASE", "Normal"}, multi = false, tooltip = "the case of the main text"})
        esp_settings:slider({name = "text size", flag = "espsettings_size", value = 13, minimum = 1, maximum = 40, tooltip = "the size of the main text"})
        esp_settings:dropdown({name = "flag text font", flag = "espsettings_flagfont", items ={"Plex", "Monospace", "System", "UI"}, multi = false, tooltip = "the font of the main text"})
        esp_settings:dropdown({name = "flag text case", flag = "espsettings_flagcase", items ={"lowercase", "UPPERCASE", "Normal"}, multi = false, tooltip = "the case of the main text"})
        esp_settings:slider({name = "flag text size", flag = "espsettings_flagsize", value = 13, minimum = 1, maximum = 40, tooltip = "the size of the main text"})
        esp_settings:toggle({name = "highlight aimbot target", flag = "espsettings_showaimbottarget", default = false, tooltip = "shows the current aimbot target"})
        :colorpicker({object = "highlight aimbot target", name = "aimbot target", flag = "espsettings_showaimbottargetcolor", color = Color3.new(1, 0, 0)})
        esp_settings:toggle({name = "highlight friendlies", flag = "espsettings_showfriendlies", default = false, tooltip = "shows the current aimbot target"})
        :colorpicker({object = "highlight friendlies", name = "friendlies", flag = "espsettings_showfriendliescolor", color = Color3.fromRGB(120, 189, 245)})
        esp_settings:toggle({name = "highlight priorities", flag = "espsettings_showpriorities", default = false, tooltip = "shows the current aimbot target"})
        :colorpicker({object = "highlight priorities", name = "priorities", flag = "espsettings_showprioritiescolor", color = Color3.fromRGB(245, 239, 120)})
    end 

    do
        local section = visuals:section({name = "local", fill = 0.2})
        section:toggle({name = "arm chams"})
        section:slider({name = "arm reflectance", min = 0, max = 100, default = 0, interval = 1})
        section:dropdown({name = "arm material", items = {"ghost", "solid", "wireframe"}, default = "ghost"})
        section:toggle({name = "weapon chams"})
        section:slider({name = "weapon reflectance", min = 0, max = 100, default = 0, interval = 1})
        section:dropdown({name = "weapon material", items = {"ghost", "solid", "wireframe"}, default = "ghost"})
        section:toggle({name = "local chams"})
        section:dropdown({name = "local material", items = {"ghost", "solid", "wireframe"}, default = "ghost"})
        section:dropdown({name = "arm animation", items = {"off", "wave", "spin"}, default = "off"})
        section:dropdown({name = "weapon animation", items = {"off", "wave", "spin"}, default = "off"})
        section:dropdown({name = "local animation", items = {"off", "wave", "spin"}, default = "off"})
        
        local camera = visuals:section({name = "camera", side = "right"})
        camera:slider({name = "camera fov", min = 0, max = 120, default = 90, interval = 1})
        camera:slider({name = "horizontal aspect ratio", min = 0, max = 200, default = 100, interval = 1})
        camera:slider({name = "vertical aspect ratio", min = 0, max = 200, default = 100, interval = 1})
        camera:toggle({name = "remove camera bob"})
        camera:toggle({name = "remove ads fov"})
        camera:toggle({name = "remove visual suppression"})
        camera:toggle({name = "reduce camera recoil"})
        camera:slider({name = "camera recoil reduction", min = 0, max = 100, default = 0, interval = 1})
        camera:toggle({name = "third person"})
        camera:slider({name = "third person distance", min = 0, max = 200, default = 100, interval = 1})
        
        local world = visuals:section({name = "world", side = "right", fill = 0.2})
        local toggle = world:toggle({name = "ambient"})
        toggle:colorpicker({name = "ambient", color = Color3.fromRGB(128, 128, 255), alpha = 1})
        toggle:colorpicker({name = "ambient", color = Color3.fromRGB(128, 128, 255), alpha = 1})
        world:slider({name = "time of day", min = 0, max = 24, default = 6, interval = 1})
        world:toggle({name = "local bullet tracers"}):colorpicker({name = "ambient", color = Color3.fromHex("#C94536"), alpha = 1})
        world:toggle({name = "enemy bullet tracers"}):colorpicker({name = "ambient", color = Color3.fromHex("#C94536"), alpha = 1})
        world:slider({name = "bullet tracer time", min = 0, max = 10, default = 4, interval = 1})
        world:toggle({name = "hit chams"})
        world:slider({name = "hit cham time", min = 0, max = 10, default = 2, interval = 1})
        world:dropdown({name = "hit chams material", items = {"ghost", "solid", "wireframe"}, default = "ghost"})
        world:dropdown({name = "brightness mode", items = {"dimmed", "bright", "default"}, default = "dimmed"})
        world:toggle({name = "teleporting lines"}):colorpicker({name = "ambient", color = Color3.fromRGB(168, 232, 65), alpha = 1})
        world:toggle({name = "show fake position"})
        local fov = world:toggle({name = "show fov"})
        fov:colorpicker({name = "ambient", color = Color3.fromHex("#7F48A3"), alpha = 1})
        fov:colorpicker({name = "ambient", color = Color3.fromHex("#646464"), alpha = 1})
        fov:colorpicker({name = "ambient", color = Color3.fromHex("#A3487F"), alpha = 1})
        fov:colorpicker({name = "ambient", color = Color3.fromHex("#FF3C00"), alpha = 1})
        world:toggle({name = "custom skybox"})
        
        local viewmodel = visuals:section({name = "viewmodel"})
        viewmodel:toggle({name = "offset viewmodel"})
        viewmodel:slider({name = "offset x", min = -200, max = 200, default = 180, interval = 1})
        viewmodel:slider({name = "offset y", min = -200, max = 200, default = 180, interval = 1})
        viewmodel:slider({name = "offset z", min = -200, max = 200, default = 180, interval = 1})
        viewmodel:slider({name = "pitch", min = -180, max = 180, default = 180, interval = 1})
        viewmodel:slider({name = "yaw", min = -180, max = 180, default = 180, interval = 1})
        viewmodel:slider({name = "roll", min = -180, max = 180, default = 180, interval = 1})
    end 

    do

    end 

    for i = 1, 30  do 
        task.wait(0.1)
        notifications:create_notification({name = "Example notification"})
    end 
--
