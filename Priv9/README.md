## How 2 Use

**disclaimer:**
This library was not created by me, and I do **not** claim any credit for its development.
This repository exists to provide usage instructions and documentation,
as well as to serve as a place for potential improvements in the future.

# Preview:
![Preview](assets/priv9.png)


## Loading the Library

```lua
local library, notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/i77lhm/Libraries/refs/heads/main/Priv9/Library.lua"))()
```

library → Main UI library object

notifications → Notification manager object

## Window
```lua
local window = library:window({
  name = <sting> -- window name
})
```

Field	Type	Description
name	<string>	Title of the window.


## Notifications
```lua
notifications:create_notification({
  name = <string> -- notification text
})
```
Field	Type	Description
name	<string>	Text to display.


## Tabs
```lua
local tab = window:tab({
  name = <string> -- 
})
```


## Columns
```lua
local column = tab:column({})
```


## Sections
```lua
local section = column:section({
  name = <string>,
  auto_fill = <boolean>,
  size = <number>

  callback = function()
})
```


## Toggle
```lua
section:toggle({
  name = <string>,
  flag = <string>

  callback = function()
})
```

## Keybind
```lua
section:keybind({
  name = <string>

  callback = function()
})
```


## Sliders
```lua
section:slider({
  name = <string>,
  min = <number>,
  max = <number>,
  default = <number>,
  interval = <number>,
  suffix = <string>

  callback = function()
})
```


## Dropdown
```lua
section:dropdown({
  name = <string>,
  flag = <string>,
  items = {<string>, <string>},
  default = <string>

  callback = function()
})
```


## ColorPicker
```lua
section:colorpicker({
  name = <string>,
  color = Color3.fromRGB(255, 0, 0),
  alpha = <value>,
  flag = "color_picker",

  callback = function()
})
```


## Button
```lua
section:button({
  name = <string>,

  callback = <function>
})
```


## Config
```lua
library:init_config(window)
```
