conky.config = {
	background = false,

	cpu_avg_samples = 20,
	net_avg_samples = 20,

	out_to_console = false,

-- X font when Xft is disabled, you can pick one with program xfontsel
--font 7x12
--font 6x10
--font 7x13
--font 8x13
--font 7x12
--font *mintsmild.se*
--font -*-*-*-*-*-*-34-*-*-*-*-*-*-*
--font -artwiz-snap-normal-r-normal-*-*-100-*-*-p-*-iso8859-1

-- Use Xft?
	use_xft = true,

-- Xft font when Xft is enabled
--	font = 'Bitstream Vera Sans Mono:size=8',
	font = 'DejaVu Sans Mono:size=10',

-- Text alpha when using Xft
	xftalpha = 0.8,

-- Update interval in seconds
	update_interval = 1,
-- Create own window instead of using desktop (required in nautilus)
	own_window = true,
	own_window_transparent = true,
--	own_window_argb_visual = false,
--	own_window_argb_value = 0,
	own_window_hints = 'undecorated,below,skip_taskbar,skip_pager',
	own_window_type = 'desktop',
	own_window_class = 'Conky',
	own_window_title = 'holy holy holy',

-- Use double buffering (reduces flicker, may not work for everyone)
	double_buffer = true,

-- Minimum size of text area
	minimum_width = 300, minimum_height = 5,
	maximum_width = 650,

-- Draw shades?
	draw_shades = false,

-- Draw outlines?
	draw_outline = false,

-- Draw borders around text
	draw_borders = false,

-- Stippled borders?
	stippled_borders = no,

-- border margins
--	border_margin = '10',

-- border width
	border_width = 2,

-- Color scheme 
--  color1 = 'lightgray'
    color1 = '#D3D3D3',--lightgray

--  color2 = 'orange',
    color2 = '#f59342',
--    color1 = 'gray',
    color1 = '#dad9d9',

-- Default colors and also border colors
	default_color = '#ffffff',
	default_shade_color = '#FF393B',
	default_outline_color = '#6B7E76',

-- Text alignment, other possible values are commented
--alignment top_left
--minimum_size 10 10
	gap_x = 5,
	gap_y = 65,
	alignment = 'bottom_right',
--alignment bottom_left
--alignment bottom_right
xinerama_head = 0,

-- Gap between borders of screen and text

-- Add spaces to keep things from moving about?  This only affects certain object
	use_spacer = 'none',

-- Subtract file system buffers from used memory?
	no_buffers = true,

-- set to yes if you want all text to be in uppercase
	uppercase = false,

	short_units = true,
	top_name_width = 10,
-- How strict should if_up be when testing an interface for being up? 'up', 'link', 'address'
	if_up_strictness = 'address',

-- variable is given either in format $variable or in ${variable}. Latter
-- allows characters right after the variable and must be used in network
-- stuff because of an argument
--${font Dungeon:style=Bold:pixelsize=10}I can change the font as well
--${font Verdana:size=10}as many times as I choose
--${font Perry:size=10}Including UTF-8,

};

conky.text = [[
$nodename $sysname $kernel $alignr Uptime: $uptime
${color1}${time %A, %d %B %Y} ${alignr}${time %H:%M.%S}${alignr}${color}

${if_up enp7s0}enp7s0: ${color1}${addr enp7s0}${color}${alignr}Public IP: ${color1}${execi 3600 curl ipinfo.io/ip}${color}

Down:${color1} ${downspeedf enp7s0} k/s${color} $alignr Up:${color1} ${upspeedf enp7s0} k/s${color}
${downspeedgraph enp7s0 27,120 000000 FF0000 180} $alignr${upspeedgraph enp7s0 27,120 000000 FF0000 25}
${color1}${totaldown enp7s0}           $alignr${totalup enp7s0}${color}
${endif}
${if_up wlp5s0}wlp5s0: ${color1}${addr wlp5s0}${color}${alignr}Public IP: ${color1}${execi 3600 curl ipinfo.io/ip}${color}

Down:${color1} ${downspeedf wlp5s0} k/s${color} $alignr Up:${color1} ${upspeedf wlp5s0} k/s${color}
${downspeedgraph wlp5s0 27,120 000000 FF0000 180} $alignr${upspeedgraph wlp5s0 27,120 000000 FF0000 25}
${color1}${totaldown wlp5s0}           $alignr${totalup wlp5s0}${color}
${endif}

Port(s)${offset 48}Connections:
ALL: ${color1}${alignc}${tcp_portmon 1 65535 count}${color}
${color2}1 - 442:${alignc}${tcp_portmon 1 442 count}${color}
${color2}444 - 1024:${alignc}${tcp_portmon 444 1024 count}${color}
1025 - 65535:${color1}${alignc}${tcp_portmon 1025 65535 count}${color}

SSH (2213): ${color1}${alignc}${tcp_portmon 2213 2213 count}${color}
HTTPS (443): ${color1}${alignc}${tcp_portmon 443 443 count}${color}

Remote Address:${alignr} rport-lport:
${color2}${tcp_portmon 1 1024 rhost 0}:${alignr}${tcp_portmon 1 1024 rport 0}${color}
${tcp_portmon 2213 2213 rhost 0}${alignr}${tcp_portmon 2213 2213 rport 0}
${color1}${tcp_portmon 1 65535 rhost 0}${alignr}${tcp_portmon 1 65535 rport 0}:${tcp_portmon 1 65535 lservice 0}
${tcp_portmon 1 65535 rhost 1}${alignr}${tcp_portmon 1 65535 rport 1}:${tcp_portmon 1 65535 lservice 1}
${tcp_portmon 1 65535 rhost 2}${alignr}${tcp_portmon 1 65535 rport 2}:${tcp_portmon 1 65535 lservice 2}
${tcp_portmon 1 65535 rhost 3}${alignr}${tcp_portmon 1 65535 rport 3}:${tcp_portmon 1 65535 lservice 3}
${tcp_portmon 1 65535 rhost 4}${alignr}${tcp_portmon 1 65535 rport 4}:${tcp_portmon 1 65535 lservice 4}
${tcp_portmon 1 65535 rhost 5}${alignr}${tcp_portmon 1 65535 rport 5}:${tcp_portmon 1 65535 lservice 5}
${tcp_portmon 1 65535 rhost 6}${alignr}${tcp_portmon 1 65535 rport 6}:${tcp_portmon 1 65535 lservice 6}
${tcp_portmon 1 65535 rhost 7}${alignr}${tcp_portmon 1 65535 rport 7}:${tcp_portmon 1 65535 lservice 7}
${tcp_portmon 1 65535 rhost 8}${alignr}${tcp_portmon 1 65535 rport 8}:${tcp_portmon 1 65535 lservice 8}
${tcp_portmon 1 65535 rhost 9}${alignr}${tcp_portmon 1 65535 rport 9}:${tcp_portmon 1 65535 lservice 9}
${tcp_portmon 1 65535 rhost 10}${alignr}${tcp_portmon 1 65535 rport 10}:${tcp_portmon 1 65535 lservice 10}${color}

${hr #cccccc}
${color1}${execi 240 fping 192.168.0.89}${color}
]];
