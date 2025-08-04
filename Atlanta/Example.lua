local library, themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Atlanta/Library.lua"))()

local dim2 = UDim2.new
local hex = Color3.fromHex 

-- documentation 
	local window = library:window({name = os.date('Atlanta |  - %b %d %Y'), size = dim2(0, 750, 0, 782)})

	local Aiming = window:tab({name = "Aiming"})
	local Misc = window:tab({name = "Misc"})
	local Visuals = window:tab({name = "Visuals"})

	-- Aiming
		local column =  Aiming:column() 
			local selec, lock, assist  = column:multi_section({names = {"Selection", "Lock"}})
				selec:toggle({name = "Enabled", flag = "target_selected", tooltip = "Manages selection of the target (both lock and aim assist)"})
				:keybind({name = "Aiming", flag = "target_selected_bind"})
				selec:toggle({name = "Auto Select", flag = "auto_select", tooltip = "Selects targets for you. (Edit the delay slider if you want more fps.)"})
				selec:toggle({name = "Only Select Enemies", flag = "enemy_priority", tooltip = "Only targets users under the priority enemy (through the playerlist)"})
				selec:dropdown({name = "Origin", flag = "distance_priority", items = {"Mouse", "Distance"}, default = "Mouse", tooltip = "Selects targets based on the origin"})
				selec:slider({name = "Delay", min = 0, max = 1000, default = 40, interval = 1, suffix = "ms", flag = "target_selector_refresh_time", tooltip = "Used for optimizing the checks and target selection. Use for lower end pcs."})
				selec:toggle({name = "Wall Check", flag = "wall_check"})
				selec:toggle({name = "Knocked Check", flag = "knocked_check"})
				selec:toggle({name = "ForceField Check", flag = "forcefield_check"})
				selec:toggle({name = "Distance Check", flag = "distance_check", tooltip = "Checks if they are in the distance of the guns range"})
				lock:toggle({name = "Enabled", flag = "silent_aim"})
				lock:toggle({name = "Auto Shoot", flag = "auto_shoot"})
				lock:dropdown({name = "Aim Bone", flag = "silent_aim_bone", items = {"Hrp", "Head"}, default = "Head"})                lock:toggle({name = "Invisible Bullets", flag = "invis_bullet", tooltip = "Makes your bullets invisible"})
				
		local column =  Aiming:column() 
			local vis, other  = column:multi_section({names = {"Visuals", "Other"}})
				other:toggle({name = "Look At", flag = "look_at"})
				other:toggle({name = "Spectate", flag = "spectate"})
				vis:toggle({name = "Tracer", flag = "snap_line"})
				:colorpicker({name = "Tracer Inline", flag = "snap_line_color", color = hex("#7D0DC3")})
				:colorpicker({flag = "Tracer Outline", color = hex("#000000")})
				vis:slider({name = "Thickness", min = 1, max = 5, default = 1, interval = 1, suffix = "°", flag = "target_snap_line_thickness"})
				vis:toggle({name = "Highlight", flag = "target_highlight"})
				:colorpicker({name = "Outline", flag = "target_highlight_settings", color = hex("#000000")})
				:colorpicker({name = "Fill", flag = "target_highlight_settings", color = hex("#000000")})  
				vis:toggle({name = "Field Of View", flag = "fov"})   
				:colorpicker({name = "1st Color (Gradient)", flag = "fov_1_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
				:colorpicker({name = "2nd Color (Gradient)", flag = "fov_2_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
				vis:toggle({name = "Outline", flag = "outline_fov"})  
				:colorpicker({name = "1st Color (Gradient)", flag = "outline_fov_settings_1", color = hex("#000000"), alpha = 1}) 
				:colorpicker({name = "2nd Color (Gradient)", flag = "outline_fov_settings_2", color = hex("#000000"), alpha = 1}) 
				vis:slider({name = "Radius", min = 0, max = 1000, default = 100, interval = 1, flag = "fov_radius"})
				vis:slider({name = "Thickness", min = 0, max = 5, default = 1, interval = 1, flag = "outline_thickness_fov"})
				vis:slider({name = "Custom Rotation", min = -180, max = 180, default = 0, interval = 1, flag = "custom_rotation_fov"})
				vis:toggle({name = "Spin", flag = "spin_fov"})
				vis:slider({name = "Rotation Speed", min = 0, max = 100, default = 100, interval = 1, flag = "spin_speed_fov"})
				library.config_flags["fov"](false)
			local vis, other  = column:multi_section({names = {"Visuals", "Other"}})
				other:toggle({name = "Look At", flag = "look_at"})
				other:toggle({name = "Spectate", flag = "spectate"})
				vis:toggle({name = "Tracer", flag = "snap_line"})
				:colorpicker({name = "Tracer Inline", flag = "snap_line_color", color = hex("#7D0DC3")})
				:colorpicker({flag = "Tracer Outline", color = hex("#000000")})
				vis:slider({name = "Thickness", min = 1, max = 5, default = 1, interval = 1, suffix = "°", flag = "target_snap_line_thickness"})
				vis:toggle({name = "Highlight", flag = "target_highlight"})
				:colorpicker({name = "Outline", flag = "target_highlight_settings", color = hex("#000000")})
				:colorpicker({name = "Fill", flag = "target_highlight_settings", color = hex("#000000")})  
				vis:toggle({name = "Field Of View", flag = "fov"})   
				:colorpicker({name = "1st Color (Gradient)", flag = "fov_1_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
				:colorpicker({name = "2nd Color (Gradient)", flag = "fov_2_settings", color = hex("#7D0DC3"), alpha = 0.5}) 
				vis:toggle({name = "Outline", flag = "outline_fov"})  
				:colorpicker({name = "1st Color (Gradient)", flag = "outline_fov_settings_1", color = hex("#000000"), alpha = 1}) 
				:colorpicker({name = "2nd Color (Gradient)", flag = "outline_fov_settings_2", color = hex("#000000"), alpha = 1}) 
				vis:slider({name = "Radius", min = 0, max = 1000, default = 100, interval = 1, flag = "fov_radius"})
				vis:slider({name = "Thickness", min = 0, max = 5, default = 1, interval = 1, flag = "outline_thickness_fov"})
				vis:slider({name = "Custom Rotation", min = -180, max = 180, default = 0, interval = 1, flag = "custom_rotation_fov"})
				vis:toggle({name = "Spin", flag = "spin_fov"})
				vis:slider({name = "Rotation Speed", min = 0, max = 100, default = 100, interval = 1, flag = "spin_speed_fov"})
				library.config_flags["fov"](false)
	--

	-- Visuals
		local esp;
		local function update_elements() if esp and esp.refresh_elements then esp.refresh_elements() end end 
		local column = Visuals:column()
		local section = column:section({name = "General", toggle = false})
		section:toggle({name = "Enabled", flag = "Enabled", callback = update_elements})
		section:toggle({name = "Names", flag = "Names", callback = function() end}):colorpicker({flag = "Name_Color", callback = update_elements})
		local settings = section:toggle({name = "Boxes", flag = "Boxes", callback = update_elements})
		section:dropdown({name = "Box Type", flag = "Box_Type", items = {"Corner", "Full"}, default = "Corner", callback = update_elements})
		settings:colorpicker({name = "Box Color", flag = "Box_Color", callback = update_elements})
		local toggle = section:toggle({name = "Healthbar", flag = "Healthbar", callback = update_elements})
		toggle:colorpicker({name = "High HP Color", flag = "Health_High", callback = update_elements})
		toggle:colorpicker({name = "Low HP Color", flag = "Health_Low", callback = update_elements})
		section:toggle({name = "Distance", flag = "Distance", callback = update_elements})
		:colorpicker({name = "Distance Color", flag = "Distance_Color", callback = update_elements})
		section:toggle({name = "Weapon", flag = "Weapon", callback = update_elements})
		:colorpicker({name = "Weapon Color", flag = "Weapon_Color", callback = update_elements})
		esp = window.esp_section:esp_preview({})
	-- 

	Aiming.open_tab() 
-- 

-- Initialisation stuff
library:config_list_update()

for index, value in themes.preset do 
	pcall(function()
		library:update_theme(index, value)
	end)
end

task.wait()

library.old_config = library:get_config()


