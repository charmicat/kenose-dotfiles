local function merge(a, b)
  if type(a) == 'table' and type(b) == 'table' then
    for k, v in pairs(b) do
      if type(v) == 'table' and type(a[k]) == 'table' then
        merge(a[k], v)
      else
        a[k] = v
      end
    end
  end
  return a
end

local function deepcopy(t)
  if type(t) ~= "table" then return t end
  local out = {}
  for k,v in pairs(t) do out[k] = deepcopy(v) end
  return out
end

local conf_dir = os.getenv("HOME") .. "/.config/conky/"

local base_config = {
-- set to yes if you want Conky to be forked in the background
	background = true,
    out_to_x = false,
    out_to_wayland = true,
    store_graph_data_explicitly = false,

-- Use Xft? 
	use_xft = true,
-- Xft font when Xft is enabled
--	font = 'Terminus:size=10',
	font = 'DejaVu Sans Mono:size=10',
-- Text alpha when using Xft
	xftalpha = 0.9,

-- Update interval in seconds
	update_interval = 1.0,

-- This is the number of times Conky will update before quitting.
-- 0 = forever
	total_run_times = 0,

-- Create own window instead of using desktop (required in nautilus)
	own_window = false,

-- If own_window is yes, these window manager hints may be used
--	own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
-- own_window_hints = 'undecorated,below,skip_taskbar,skip_pager',
	own_window_hints = 'skip_taskbar,skip_pager',

-- If own_window is yes, you may use type normal, desktop or override
	own_window_type = 'normal',

-- Use pseudo transparency with own_window?
    own_window_colour = '#262729', --darkgray
	own_window_transparent = true,

    own_window_class = 'Conky',
    own_window_title = 'agios agios agios',
    use_spacer = 'right',

-- Use double buffering (reduces flicker, may not work for everyone)
	double_buffer = true,

-- Minimum size of text area
--	minimum_width = 200, minimum_height = 200,

-- Maximum width
	maximum_width = 550,

	default_graph_height = 10,
	default_graph_width = 300,
	default_bar_height = 6, 
--   default_bar_width = 30,

-- Draw shades?
   draw_shades = false,

-- Draw outlines?
	draw_outline = false,

-- Draw borders around text
	draw_borders = false,
-- Draw borders around graphs
	draw_graph_borders = false,
-- stippled_borders = 8,
-- border_margin = 2,
-- border_width = 1,

-- Text alignment, other possible values are commented
alignment = 'top_left', --top_left|top_right|bottom_left|bottom_right|none
-- first screen
xinerama_head = 0, 

-- Gap between borders of screen and text
-- same thing as passing -x at command line
	gap_x = 10,
	gap_y = 10,

-- Subtract file system buffers from used memory?
	no_buffers = true,

-- set to yes if you want all text to be in uppercase
	uppercase = false,

-- number of cpu samples to average
-- set to 1 to disable averaging
	cpu_avg_samples = 2,
    net_avg_samples = 2,

-- Force UTF8? note that UTF8 support required XFT
	override_utf8_locale = true,

-- Color scheme 
	color1 = '#D3D3D3',--lightgray
	color2 = '#f59342',
    color3 = '#dad9d9',
-- Default colors and also border colors
	default_color = '#FFFFFF',
	default_shade_color = '#FF393B',
	default_outline_color = '#6B7E76',

    short_units = true,
    top_name_width = 10,
};

local session = os.getenv("XDG_SESSION_TYPE")
local is_wayland =
  (session == "wayland") or (os.getenv("WAYLAND_DISPLAY") ~= nil)

local session_overrides = {
  out_to_x = not is_wayland,
  out_to_wayland = is_wayland,
}

local theme_overrides = dofile(conf_dir .. "colors.lua")

local final = deepcopy(base_config)
merge(final, session_overrides)
merge(final, theme_overrides)

conky.config = final

-- EOF