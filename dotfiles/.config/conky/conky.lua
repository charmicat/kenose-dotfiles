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
conky.config = final

conky.text = [[

$nodename $sysname $kernel $alignr Uptime: $uptime
#- 53.287393° N 6.123512° W - 13m (+6)
 
 RAM   ${color1}$mem/$memmax $membar${color}
 Swap  ${color1}$swap/$swapmax $swapbar${color}

 CPU - ${execi 3600 cat /proc/cpuinfo | grep 'model name' | sed -e 's/model name.*: //'| uniq}:
  ${font Font Awesome 6 Free:style=Solid:pixelsize=15}${font} (Tctl) ${color1}${hwmon 2 temp 1}°C${color} $alignr ${font Font Awesome 6 Free:style=Solid:pixelsize=15}${font} ${color1}${cpu cpu0}% ${cpubar cpu0 6,100} (${freq_g}GHz)${color}
  01 ${color1}${goto 50}${cpu cpu1}%${goto 90}${cpubar cpu1 7,60}${color} ${goto 185}02 ${color1}${goto 217}${cpu cpu2}%${goto 270}${cpubar cpu2 7,60}${color} ${goto 365}03 ${color1}${goto 390}${cpu cpu3}%${goto 430}${cpubar cpu3 7,60}${color}
  04 ${color1}${goto 50}${cpu cpu4}%${goto 90}${cpubar cpu4 7,60}${color} ${goto 185}05 ${color1}${goto 217}${cpu cpu5}%${goto 270}${cpubar cpu5 7,60}${color} ${goto 365}06 ${color1}${goto 390}${cpu cpu6}%${goto 430}${cpubar cpu6 7,60}${color}
  07 ${color1}${goto 50}${cpu cpu7}%${goto 90}${cpubar cpu7 7,60}${color} ${goto 185}08 ${color1}${goto 217}${cpu cpu8}%${goto 270}${cpubar cpu8 7,60}${color} ${goto 365}09 ${color1}${goto 390}${cpu cpu9}%${goto 430}${cpubar cpu9 7,60}${color}
  10 ${color1}${goto 50}${cpu cpu10}%${goto 90}${cpubar cpu10 7,60}${color} ${goto 185}11 ${color1}${goto 217}${cpu cpu11}%${goto 270}${cpubar cpu11 7,60}${color} ${goto 365}12 ${color1}${goto 390}${cpu cpu12}%${goto 430}${cpubar cpu12 7,60}${color}
  13 ${color1}${goto 50}${cpu cpu13}%${goto 90}${cpubar cpu13 7,60}${color} ${goto 185}14 ${color1}${goto 217}${cpu cpu14}%${goto 270}${cpubar cpu14 7,60}${color} ${goto 365}15 ${color1}${goto 390}${cpu cpu15}%${goto 430}${cpubar cpu15 7,60}${color}
  16 ${color1}${goto 50}${cpu cpu16}%${goto 90}${cpubar cpu16 7,60}${color} ${goto 185}17 ${color1}${goto 217}${cpu cpu17}%${goto 270}${cpubar cpu17 7,60}${color} ${goto 365}18 ${color1}${goto 390}${cpu cpu18}%${goto 430}${cpubar cpu18 7,60}${color}
  19 ${color1}${goto 50}${cpu cpu19}%${goto 90}${cpubar cpu19 7,60}${color} ${goto 185}20 ${color1}${goto 217}${cpu cpu20}%${goto 270}${cpubar cpu20 7,60}${color} ${goto 365}21 ${color1}${goto 390}${cpu cpu21}%${goto 430}${cpubar cpu21 7,60}${color}
  22 ${color1}${goto 50}${cpu cpu22}%${goto 90}${cpubar cpu22 7,60}${color} ${goto 185}23 ${color1}${goto 217}${cpu cpu23}%${goto 270}${cpubar cpu23 7,60}${color} ${goto 365}

# GPU Usage: ${color1}$alignr${execi 5 radeontop -d- -l1 | grep -o 'gpu [0-9]*.[0-9]*' | cut -c 5-8 }%${color} #not very interesting
 GPU - ${execi 3600 nvidia-smi --query-gpu name --format=csv,noheader}: 
 # ${color1}${nvidiagraph temp 15,235 -l}${font}${color} #not very useful
 ${font Font Awesome 6 Free:style=Solid:pixelsize=15}${font} ${color1}${execi 300 "nvidia-settings -q gpucoretemp -t"}°C $alignr${font Font Awesome 6 Free:style=Solid:pixelsize=15}${font} ${execpi 300 nvidia-smi | grep -o  C.*% | sed -e 's/C.*P[0-9]*[^0-9]*\(.*\)/\1/g' -e 's/   //g' } ${color}
#GPU $alignr ${nvidia gpufreq} Mhz | Memory $alignr ${nvidia memfreq} Mhz | ${nvidia threshold}  #useful for overclocking

Disk usage:
${execpi 300 "df -t ntfs -t ext2 -t ext3 -t ext4 -t vfat -t fuseblk -t btrfs -h --output=target,used,avail,pcent | sed 's/^\/\([^ ]*\)\(.*\)/\/\1\2 \$\{fs_bar 7,80 \/\1\}/g'"}

Network:${alignr}${color1}${execi 3600 curl ipinfo.io/ip} ${color}
 enp6s0:$alignr${color1}${alignr} ${addr enp6s0} ${color}
${if_existing /sys/class/net/enp6s0/operstate up}${color1}${font Font Awesome 6 Free:style=Solid:pixelsize=13}${font}${goto 30}${downspeedf enp6s0}k/s (${totaldown enp6s0})${alignr}${font Font Awesome 6 Free:style=Solid:pixelsize=13} ${font} ${upspeedf enp6s0}k/s (${totalup enp6s0}) ${color}${else}#${endif}
${if_existing /sys/class/net/wlan0/operstate up} wlan0:$alignr${color1}${alignr} ${addr wlan0} ${color} $alignr SSID: ${color1}${wireless_essid wlan0} ${color}
 Speed: ${color1}${wireless_bitrate wlan0} ${color} $alignr Quality: ${color1}${wireless_link_qual_perc wlan0}% ${color}
${color1}${font Font Awesome 6 Free:style=Solid:pixelsize=13}${font}${goto 30}${downspeedf wlan0}k/s (${totaldown wlan0})${alignr}${font Font Awesome 6 Free:style=Solid:pixelsize=13} ${font} ${upspeedf wlan0}k/s (${totalup wlan0}) ${else}#${endif}

${if_existing /sys/class/net/wlp5s0/operstate up}wlp5s0:$alignr${color1}${alignr} ${addr wlp5s0} ${color} $alignr SSID: ${color1}${wireless_essid wlp5s0} ${color}
 Speed: ${color1}${wireless_bitrate wlp5s0} ${color} $alignr Quality: ${color1}${wireless_link_qual_perc wlp5s0}% ${color}
${color1}${font Font Awesome 6 Free:style=Solid:pixelsize=13}${font}${goto 30}${downspeedf wlp5s0}k/s (${totaldown wlp5s0})${alignr}${font Font Awesome 6 Free:style=Solid:pixelsize=13} ${font} ${upspeedf wlp5s0}k/s (${totalup wlp5s0}) ${else}#${endif}

#Portage:
#${color1}${tail /var/tmp/lastsync 3 120}${color}

#${execpi 3600 "cal -m --color=always | sed s/\\x1b\\[7m\\\([^0-9]*[0-9][0-9]*\\\)\\x1b\\[27m/\$\{color2\}\\1\$\{color\}/"} #this breaks on July, because it's month 7. \x1B[ = ^[, Esc + [ 
#${execpi 3600 "myCal.sh"} # using orage started by i3 now
S.M.A.R.T. errors:
${color1}${tail /var/tmp/smartctl_out.txt 10 1440}${color}

]];

-- EOF