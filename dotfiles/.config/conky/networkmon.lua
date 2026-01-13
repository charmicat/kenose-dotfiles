local conf_dir = os.getenv("HOME") .. "/.config/conky/"
package.path = conf_dir .. "lib/?.lua;" .. package.path

local util = require("util")
local base_config = require("base_config")

local is_wayland = util.is_wayland()

local final = util.deepcopy(base_config)
util.merge(final, {
  out_to_x = not is_wayland,
  out_to_wayland = is_wayland,
})
util.merge(final, dofile(conf_dir .. "colors.lua"))

local custom_config = {
	background = false,
	cpu_avg_samples = 20,
	net_avg_samples = 20,

-- Create own window instead of using desktop (required in nautilus)
	own_window_hints = 'undecorated,below,skip_taskbar,skip_pager',
	own_window_type = 'desktop',
	own_window_class = 'Conky',
	own_window_title = 'holy holy holy',

-- Minimum size of text area
	minimum_width = 300, minimum_height = 5,
	maximum_width = 650,
	border_width = 2,

-- Text alignment, other possible values are commented
	gap_x = 5, gap_y = 65,
	alignment = 'bottom_right',
	-- Add spaces to keep things from moving about?  This only affects certain object
	use_spacer = 'none',
};

util.merge(final, custom_config)
conky.config = final

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

-- EOF
