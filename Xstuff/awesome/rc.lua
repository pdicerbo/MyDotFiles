-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local lain = require("lain")
menubar.cache_entries = false
menubar.app_folders =
   {
      '/usr/share/applications/',
   }
menubar.show_categories = false
-- Vic ious
local vicious = require("vicious")
--Revelation
local revelation = require("revelation")
local quake = require("quake")

-- require("collision")()

terminal = "urxvt"

--Freedesktop Not working (;_;)
require('freedesktop.utils')
freedesktop.utils.terminal = terminal
freedesktop.utils.icon_theme = 'Faenza-Dark'
require('freedesktop.menu')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
		    title = "Oops, there were errors during startup!",
		    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
			     -- Make sure we don't go into an endless error loop
			     if in_error then return end
			     in_error = true
			     
			     naughty.notify({ preset = naughty.config.presets.critical,
					      title = "Oops, an error happened!",
					      text = err })
			     in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
local home = os.getenv("HOME")
--terminal = "urxvt"
editor = "emacs"
editor_cmd = editor
modkey = "Mod4"
ArchIcon = ".config/awesome/archlinux-artwork/icons/archlinux-icon-crystal-16.svg"

quake_console = quake({
      terminal = terminal,
      argname = "-name %s ",
      name = "MyQuake",
      height = 0.45, -- 300,
      width = 1, -- 500,
      horiz = "left",
      vert = "top",
      screen = 1
})

quake_console_nx = quake({
      terminal = terminal,
      argname = "-name %s ",
      name = "MyQuake",
      height = 0.45, -- 300,
      width = 1, -- 500,
      horiz = "left",
      vert = "top",
      screen = 2
})

-- Themes define colours, icons, and wallpapers
beautiful.init(home .. "/.config/awesome/themes/zenburn/theme.lua") 

-- Table of layouts to cover with awful.layout.inc, order matters.
-- pdicerbo note:
-- if you want lain layouts, then clone into ~/.config/awesome/lain the lain package with:
-- git clone https://github.com/copycat-killer/lain.git ~/.config/awesome/lain
-- info at https://github.com/copycat-killer/lain/wiki
local layouts =
   {
      awful.layout.suit.max,              --1
      awful.layout.suit.floating,         --2
      awful.layout.suit.fair,             --3
      awful.layout.suit.fair.horizontal,  --4
      awful.layout.suit.spiral,           --5
      awful.layout.suit.spiral.dwindle,   --6
      awful.layout.suit.tile,             --7
      awful.layout.suit.tile.left,        --8
      awful.layout.suit.tile.bottom,      --9
      awful.layout.suit.tile.top,         --10
      awful.layout.suit.max.fullscreen,   --11
      awful.layout.suit.magnifier,        --12
      lain.layout.cascade                 --13       
   }
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
   -- Each screen has its own tag table.
    --tags[s] = awful.tag({ '1 ', '1 ', '2 ', '3 ', '5 ', '8 ', '13 ', '21 ', '34 ', '55 ' }, s, layouts[1])
   tags[s] = awful.tag({ '⌘', '♐', '⌥', 'ℵ', '⌥', '⌤', '⚡ ' }, s,
      {layouts[7], layouts[2], layouts[2], layouts[2],
       layouts[7], layouts[7], layouts[6]
   })
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu =
   {
      { "restart awesome", awesome.restart },
      --     { "lock", 'dm-tool lock' },
      { "suspend", 'systemctl suspend' },
      { "quit", awesome.quit },
      { "poweroff", 'systemctl poweroff' }
   }

mymainmenu = awful.menu(
   { items =
	{
	   { "Awesome", myawesomemenu, beautiful.awesome_icon },
	   { "Everything", freedesktop.menu.new(), },
	   { "Chromium", 'chromium' },
	   { "Firefox", 'firefox' },
	   { "File Manager", 'thunar /home/pierluigi/' },
	   { "Gimp", 'gimp-2.8' },
	   { "Writer", 'libreoffice --writer' },
	   { "Calc", 'libreoffice --calc' },
	   { "Vlc", 'vlc' },
	},
     theme = { width = 140 }
})

mylauncher = awful.widget.launcher({ image = ArchIcon,
                                     menu = mymainmenu })
--beautiful.awesome_icon,

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox

-- Separators
spacer = wibox.widget.textbox(" ")
seperator = wibox.widget.textbox("|")
--spacer.text = " "
--seperator.text = "|"

-- Wifiwidget
wificon = wibox.widget.imagebox()
wificon:set_image(beautiful.widget_wifi)

wifiwidget = wibox.widget.textbox()
vicious.register(wifiwidget, vicious.widgets.wifi, "⇗ ${linp}%", 5, "wlp2s0")
-- vicious.register(wifiwidget, vicious.widgets.wifi, "${link}%", 5, "wlp2s0")

-- Net Widget
netup = wibox.widget.imagebox()
netup:set_image(beautiful.widget_up)

netdw = wibox.widget.imagebox()
netdw:set_image(beautiful.widget_dw)

netwidget = wibox.widget.textbox()
-- vicious.register(netwidget, vicious.widgets.net, "[⇓ ${wlp2s0 down_kb} / ${wlp2s0 up_kb} ⇑]", 1)
vicious.register(netwidget, vicious.widgets.net, "${wlp2s0 down_kb} / ${wlp2s0 up_kb}", 1)

-- Battery Widget
baticon = wibox.widget.imagebox()
baticon:set_image(beautiful.widget_bat)

batwidget = wibox.widget.textbox()
-- vicious.register(batwidget, vicious.widgets.bat, "⚡ $1$2 %", 32, "BAT1")
vicious.register(batwidget, vicious.widgets.bat, "$1$2 %", 32, "BAT1")

--CPU Widget
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)

cpuwidget = wibox.widget.textbox()
-- vicious.register(cpuwidget, vicious.widgets.cpu, "⚒: $1%", 2)
vicious.register(cpuwidget, vicious.widgets.cpu, "$1%", 2)

-- Create a textclock widget
clockicon = wibox.widget.imagebox()
clockicon:set_image(beautiful.widget_clock)

mytextclock = awful.widget.textclock(" %a %b %e, %I:%M %p " , 1)

local calendar = nil
local offset = 0

function remove_calendar()
   if calendar ~= nil then
      naughty.destroy(calendar)
      calendar = nil
      offset = 0
   end
end

function add_calendar(inc_offset)
   local LocalInfo = {
      mouse = mouse,
      screen = screen
   }
   local save_offset = offset
   remove_calendar()
   offset = save_offset + inc_offset
   local datespec = os.date("*t")
   datespec = datespec.year * 12 + datespec.month - 1 + offset
   datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
   local cal = awful.util.pread("cal -m " .. datespec)
   cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")
   calendar = naughty.notify({
	 --	 text = string.format('<span font_desc="%s">%s</span>', "monospace", os.date("%a, %d %B %Y") .. "\n" .. cal),
	 --	 text = string.format('<span font_desc="%s">%s</span>', font, cal),
	 text = string.format('<span font_desc="%s">%s</span>', "monospace", cal),
	 position = "top_right",
	 fg = beautiful.fg_urgent,
	 bg = beautiful.bg_normal,
	 timeout = 0,
	 hover_timeout = 0.5,
	 border_color = beautiful.border_tooltip,
	 border_width = 1,
	 screen= LocalInfo.mouse.screen
	 -- opacity = 1.,
	 -- width = 150,
	 -- height = 140,
   })
end

mytextclock:connect_signal('mouse::enter', function () add_calendar(0) end)
mytextclock:connect_signal('mouse::leave', function () remove_calendar() end)

mytextclock:buttons(awful.util.table.join(
		       awful.button({ }, 1, function() add_calendar(1) end),
		       awful.button({ }, 3, function() add_calendar(-1) end),
		       awful.button({ 'Shift' }, 1, function() add_calendar(12) end),
		       awful.button({ 'Shift' }, 3, function() add_calendar(-12) end)))

--RAM
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)

memwidget = wibox.widget.textbox()
-- vicious.register(memwidget, vicious.widgets.mem, "<span color='" .. beautiful.fg_normal .. "'>$2</span>", 3)
vicious.register(memwidget, vicious.widgets.mem, "<span color='" .. beautiful.fg_normal .. "'>$1 % ($2MB)</span>", 3)

local function dispmem()
   local f, infos
   local capi = {
      mouse = mouse,
      screen = screen
   }
   -- original
   -- f = io.popen("free -m | grep total && free -m | grep Mem")
   -- in order to by aligned, I use my own script MyMemInfo, which use sed s/.....
   f = io.popen("MyMemInfo")
   infos = f:read("*all")
   f:close()
   
   showmeminfo = naughty.notify( {
	 text= infos,
	 font    = font,
	 fg = beautiful.fg_normal,
	 bg = beautiful.bg_normal,
	 timeout= 0,
	 hover_timeout = 0.5,
	 position = "top_right",
	 -- margin = 10,
	 -- height = 61,
	 -- width = 540,
	 border_color = beautiful.border_tooltip,
	 border_width = 1,
	 -- opacity = 0.94,
	 screen= capi.mouse.screen })
end

memwidget:connect_signal('mouse::enter', function () dispmem(path) end)
memwidget:connect_signal('mouse::leave', function () naughty.destroy(showmeminfo) end)

-- Volume

-- volicon = wibox.widget.imagebox()
-- volicon:set_image(beautiful.widget_vol)
--volicon:buttons(awful.util.table.join(awful.button({ }, 1, function () exec(mixer) end)))
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)

volumewidget = wibox.widget.textbox()
vicious.register( volumewidget, vicious.widgets.volume, "<span color='" .. beautiful.fg_normal .. "'> $1 % </span>", 1, "Master" )

volumewidget:buttons(awful.util.table.join(
			awful.button({ }, 1, function () awful.util.spawn( "amixer -c 0 set Master 0 mute") end),
			awful.button({ }, 3, function () awful.util.spawn( "amixer -c 0 set Master 20+ unmute")   end),
			awful.button({ }, 5, function () awful.util.spawn( "amixer -q sset Master 1dB-")   end)))


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
	 if c == client.focus then
	    c.minimized = true
	 else
	    -- Without this, the following
	    -- :isvisible() makes no sense
	    c.minimized = false
	    if not c:isvisible() then
	       awful.tag.viewonly(c:tags()[1])
	    end
	    -- This will also un-minimize
	    -- the client, if needed
	    client.focus = c
	    c:raise()
	 end
   end),
   awful.button({ }, 3, function ()
	 if instance then
	    instance:hide()
	    instance = nil
	 else
	    instance = awful.menu.clients({ width=250 })
	 end
   end),
   awful.button({ }, 4, function ()
	 awful.client.focus.byidx(1)
	 if client.focus then client.focus:raise() end
   end),
   awful.button({ }, 5, function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
   mypromptbox[s] = awful.widget.prompt({ prompt = "Orders, sir? " })
   -- Create an imagebox widget which will contains an icon indicating which layout we're using.
   -- We need one layoutbox per screen.
   mylayoutbox[s] = awful.widget.layoutbox(s)
   mylayoutbox[s]:buttons(awful.util.table.join(
			     awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
			     awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
			     awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
			     awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
   -- Create a taglist widget
   mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)
   
   -- Create a tasklist widget
   mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)
   
   -- Create the wibox
   mywibox[s] = awful.wibox({ position = "top", screen = s })
   
   -- Widgets that are aligned to the left
   local left_layout = wibox.layout.fixed.horizontal()
   left_layout:add(mylauncher)
   left_layout:add(spacer)
   left_layout:add(mytaglist[s])
   left_layout:add(spacer)
   left_layout:add(mypromptbox[s])
   left_layout:add(spacer)
   
   -- Widgets that are aligned to the right
   local right_layout = wibox.layout.fixed.horizontal()
   
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(volicon)
   right_layout:add(spacer)
   right_layout:add(volumewidget)
   right_layout:add(seperator)
   
   -- Battery Monitor
   right_layout:add(spacer)
   right_layout:add(baticon)    
   right_layout:add(spacer)
   right_layout:add(batwidget)
   
   -- Wifi Monitor
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   -- right_layout:add(wificon)
   -- right_layout:add(spacer)
   right_layout:add(wifiwidget)
   
   -- Net Monitor
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   right_layout:add(netdw)
   right_layout:add(netwidget)
   right_layout:add(netup)
   
   -- CPU Monitor, and yes I mean Monitor like the god damn lizard!
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   right_layout:add(memicon)
   right_layout:add(spacer)
   right_layout:add(memwidget)
   
   -- CPU Monitor, and yes I mean Monitor like the god damn lizard!
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   right_layout:add(cpuicon)
   right_layout:add(spacer)
   right_layout:add(cpuwidget)
   
   -- Systray, on every screen because fuck devs.
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   if s == 1 then right_layout:add(wibox.widget.systray()) end
   
   -- Clock
   right_layout:add(spacer)
   right_layout:add(seperator)
   right_layout:add(spacer)
   right_layout:add(clockicon)
   right_layout:add(mytextclock)
   
   -- And this thing!
   right_layout:add(spacer)
   right_layout:add(mylayoutbox[s])
   
   -- Now bring it all together (with the tasklist in the middle)
   local layout = wibox.layout.align.horizontal()
   layout:set_left(left_layout)
    -- layout:set_middle(mytasklist[s])
   layout:set_right(right_layout)
   
   mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end),
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({}, "F12", function () quake_console:toggle() end),
   awful.key({"Shift"}, "F12", function () quake_console_nx:toggle() end),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
   awful.key({ modkey,           }, "s", revelation), 
   awful.key({ modkey,           }, "j",
      function ()
	 awful.client.focus.byidx( 1)
	 if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey,           }, "k",
      function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
   end),
   awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
   
   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative(-1) end),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "Tab",
      function ()
	 awful.client.focus.history.previous()
	 if client.focus then
	    client.focus:raise()
	 end
   end),
   
   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
   awful.key({ modkey, "Shift"   }, "r", awesome.restart),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit),
   awful.key({ modkey, "Control" }, "n", awful.client.restore),
   
   awful.key({ modkey }, "x",
      function ()
	 awful.prompt.run({ prompt = "Lua Prompt: " },
	    mypromptbox[mouse.screen].widget,
	    awful.util.eval, nil,
	    awful.util.getdir("cache") .. "/history_eval")
   end),
   
   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
   
   -- Custom Keybindings
   awful.key({ modkey,           }, "Down",  function () awful.util.spawn("xbacklight -dec 40") end),
   awful.key({ modkey,           }, "Up",    function () awful.util.spawn("xbacklight -inc 40") end),
   awful.key({                   }, "Print", function () awful.util.spawn("scrot -e 'mv $f " .. home .."/Images/Scrot/ 2>/dev/null'") end),
   awful.key({ modkey,           }, "b",     function () awful.util.spawn(home .. "/bin/fehbg") end),
   -- awful.key({ modkey,           }, "-",     function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3- unmute") end),
   -- awful.key({ modkey,           }, "+",     function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3+ unmute") end),
   awful.key({"Control", "Shift" }, "-",     function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3- unmute") end),
   awful.key({"Control", "Shift" }, "+",     function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3+ unmute") end),
   awful.key({ }, "XF86AudioLowerVolume",    function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3- unmute") end),
   awful.key({ }, "XF86AudioRaiseVolume",    function () awful.util.spawn("/usr/bin/amixer -c 0 set Master 3+ unmute") end),
   -- Prompt
   awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
   
   -- Menubar
   awful.key({ modkey }, "d", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey, "Control" }, "r",      function (c) c:redraw()                       end),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
   
   -- Easily move the windows around
   awful.key({ modkey, "Shift"   }, ",",
      function (c)
	 local curidx = awful.tag.getidx(c:tags()[1])
	 if curidx == 1 then
	    awful.client.movetotag(tags[client.focus.screen][7]) 
	 else
	    awful.client.movetotag(tags[client.focus.screen][curidx - 1]) 
	 end
   end),
   
   awful.key({ modkey, "Shift"   }, ".",
      function (c)
	 local curidx = awful.tag.getidx(c:tags()[1])
	 if curidx == 10 then
	    awful.client.movetotag(tags[client.focus.screen][1]) 
	 else
	    awful.client.movetotag(tags[client.focus.screen][curidx + 1]) 
	 end
   end),
   
   -- Minimize/Maximize
   awful.key({ modkey,           }, "n",
        function (c)
	   -- The client currently has the input focus, so it cannot be
	   -- minimized, since minimized clients can't have the focus.
	   c.minimized = true
   end),
   awful.key({ modkey,           }, "m",
      function (c)
	 c.maximized_horizontal = not c.maximized_horizontal
	 c.maximized_vertical   = not c.maximized_vertical
   end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
   globalkeys = awful.util.table.join(globalkeys,
				      
				      awful.key({ modkey }, "#" .. i + 9,
					 function ()
					    local screen = mouse.screen
					    if tags[screen][i] then
					       awful.tag.viewonly(tags[screen][i])
					    end
				      end),
				      awful.key({ modkey, "Control" }, "#" .. i + 9,
					 function ()
					    local screen = mouse.screen
					    if tags[screen][i] then
					       awful.tag.viewtoggle(tags[screen][i])
					    end
				      end),
				      awful.key({ modkey, "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus and tags[client.focus.screen][i] then
					       awful.client.movetotag(tags[client.focus.screen][i])
					    end
				      end),
				      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
					 function ()
					    if client.focus and tags[client.focus.screen][i] then
					       awful.client.toggletag(tags[client.focus.screen][i])
					    end
				      end),
				      
				      -- "limited to 9" is a ridiculous phrase and I wholeheartedly reject it.
				      awful.key({ modkey }, "0",
					 function ()
					    local screen = mouse.screen
					    if tags[screen][10] then
					       awful.tag.viewonly(tags[screen][10])
					    end
				      end),
				      
				      awful.key({ modkey, "Control" }, "0",
					 function ()
					    local screen = mouse.screen
					    if tags[screen][10] then
					       awful.tag.viewtoggle(tags[screen][10])
					    end
				      end),
				      
				      awful.key({ modkey, "Shift" }, "0",
					 function ()
					    if client.focus and tags[client.focus.screen][10] then
					       awful.client.movetotag(tags[client.focus.screen][10])
					    end
				      end),
				      
				      awful.key({ modkey, "Control", "Shift" }, "0",
					 function ()
					    if client.focus and tags[client.focus.screen][10] then
					       awful.client.toggletag(tags[client.focus.screen][10])
					    end
   end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))


-- XRandR SECTION!
-- Get active outputs
local function outputs()
   local outputs = {}
   local xrandr = io.popen("xrandr -q")
   if xrandr then
      for line in xrandr:lines() do
	 output = line:match("^([%w-]+) connected ")
	 if output then
	    outputs[#outputs + 1] = output
	 end
      end
      xrandr:close()
   end

   return outputs
end

local function arrange(out)
   -- We need to enumerate all the way to combinate output. We assume
   -- we want only an horizontal layout.
   local choices  = {}
   local previous = { {} }
   for i = 1, #out do
      -- Find all permutation of length `i`: we take the permutation
      -- of length `i-1` and for each of them, we create new
      -- permutations by adding each output at the end of it if it is
      -- not already present.
      local new = {}
      for _, p in pairs(previous) do
	 for _, o in pairs(out) do
	    if not awful.util.table.hasitem(p, o) then
	       new[#new + 1] = awful.util.table.join(p, {o})
	    end
	 end
      end
      choices = awful.util.table.join(choices, new)
      previous = new
   end

   return choices
end

-- Build available choices
local function menu()
   local menu = {}
   local out = outputs()
   local choices = arrange(out)

   for _, choice in pairs(choices) do
      local cmd = "xrandr"
      -- Enabled outputs
      for i, o in pairs(choice) do
	 cmd = cmd .. " --output " .. o .. " --auto"
	 if i > 1 then
	    cmd = cmd .. " --right-of " .. choice[i-1]
	    -- cmd = cmd .. " --same-as " .. choice[i-1]
	 end
      end
      -- Disabled outputs
      for _, o in pairs(out) do
	 if not awful.util.table.hasitem(choice, o) then
	    cmd = cmd .. " --output " .. o .. " --off"
	 end
      end

      local label = ""
      if #choice == 1 then
	 label = 'Only <span weight="bold">' .. choice[1] .. '</span>'
      else
	 for i, o in pairs(choice) do
	    if i > 1 then label = label .. " + " end
	    label = label .. '<span weight="bold">' .. o .. '</span>'
	 end
      end

      menu[#menu + 1] = { label,
			  cmd,
			  "/usr/share/icons/gnome/32x32/devices/display.png"}
   end

   return menu
end

-- Display xrandr notifications from choices
local state = { iterator = nil,
		timer = nil,
		cid = nil }
local function xrandr()
   -- Stop any previous timer
   if state.timer then
      state.timer:stop()
      state.timer = nil
   end

   -- Build the list of choices
   if not state.iterator then
      state.iterator = awful.util.table.iterate(menu(),
						function() return true end)
   end

   -- Select one and display the appropriate notification
   local next  = state.iterator()
   local label, action, icon
   if not next then
      label, icon = "Keep the current configuration", "/usr/share/icons/gnome/32x32/devices/display.png"
      state.iterator = nil
   else
      label, action, icon = unpack(next)
   end
   state.cid = naughty.notify({ text = label,
				icon = icon,
				timeout = 4,
				screen = mouse.screen, -- Important, not all screens may be visible
				font = "Free Sans 18",
				replaces_id = state.cid }).id

   -- Setup the timer
   state.timer = timer { timeout = 2 }
   state.timer:connect_signal("timeout",
			      function()
				 state.timer:stop()
				 state.timer = nil
				 state.iterator = nil
				 if action then
				    awful.util.spawn(action, false)
				 end
   end)
   state.timer:start()
end

globalkeys = awful.util.table.join(
   globalkeys,
   awful.key({}, "XF86Display", xrandr))


-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules =
   {
      -- All clients will match this rule.
   { rule = { },
     properties =
	{
	   border_width = beautiful.border_width,
	   border_color = beautiful.border_normal,
	   size_hints_honor = false,
	   focus = true,
	   keys = clientkeys,
	   buttons = clientbuttons,
	   maximized_vertical   = false,
	   maximized_horizontal = false
	}
   },
   
   { rule = { class = "vlc" },
     properties = { floating = true }
   },
   
   { rule = { class = "Thunar" },
     properties = { floating = true }
   },
      
   { rule = { class = "gimp" },
     properties = { floating = true }
   },

   { rule = { class = "Skype" },
     properties = { floating = true }
   },

   -- plt.show() generated windows
   { rule = { class = "Tk" },
     properties = { floating = true }
   }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
			 c:connect_signal("mouse::enter", function(c)
					     if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
					     and awful.client.focus.filter(c) then
						client.focus = c
					     end
			 end)
			 
			 if not startup then
			    -- Set the windows at the slave,
			    -- i.e. put it at the end of others instead of setting it master.
			    -- awful.client.setslave(c)
			    
			    -- Put windows in a smart way, only if they does not set an initial position.
			    if not c.size_hints.user_position and not c.size_hints.program_position then
			       awful.placement.no_overlap(c)
			       awful.placement.no_offscreen(c)
			    end
			 end
			 
			 local titlebars_enabled = false
			 if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
			    -- Widgets that are aligned to the left
			    local left_layout = wibox.layout.fixed.horizontal()
			    left_layout:add(awful.titlebar.widget.iconwidget(c))
			    
			    -- Widgets that are aligned to the right
			    local right_layout = wibox.layout.fixed.horizontal()
			    right_layout:add(awful.titlebar.widget.floatingbutton(c))
			    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
			    right_layout:add(awful.titlebar.widget.stickybutton(c))
			    right_layout:add(awful.titlebar.widget.ontopbutton(c))
			    right_layout:add(awful.titlebar.widget.closebutton(c))
			    
			    -- The title goes in the middle
			    local title = awful.titlebar.widget.titlewidget(c)
			    title:buttons(awful.util.table.join(
					     awful.button({ }, 1, function()
						   client.focus = c
						   c:raise()
						   awful.mouse.client.move(c)
					     end),
					     awful.button({ }, 3, function()
						   client.focus = c
						   c:raise()
						   awful.mouse.client.resize(c)
					     end)
			    ))
			    
			    -- Now bring it all together
			    local layout = wibox.layout.align.horizontal()
			    layout:set_left(left_layout)
			    layout:set_right(right_layout)
			    layout:set_middle(title)
			    
			    awful.titlebar(c):set_widget(layout)
			 end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

function run_once(cmd)
   findme = cmd
   firstspace = cmd:find(" ")
   if firstspace then
      findme = cmd:sub(0, firstspace-1)
   end
   awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- awful.util.spawn("my_walls &")
run_once("dropbox start -i &")
run_once("xfce4-power-manager")
run_once("compton --config=/home/pierluigi/.config/compton.conf")
run_once("my_walls &")

awful.util.spawn("conky --config=/home/pierluigi/.conky/aw_conky")
