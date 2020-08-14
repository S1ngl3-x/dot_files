--       █████╗ ██████╗ ██████╗ ███████╗
--      ██╔══██╗██╔══██╗██╔══██╗██╔════╝
--      ███████║██████╔╝██████╔╝███████╗
--      ██╔══██║██╔═══╝ ██╔═══╝ ╚════██║
--      ██║  ██║██║     ██║     ███████║
--      ╚═╝  ╚═╝╚═╝     ╚═╝     ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local filesystem = require("gears.filesystem")

-- define module table
local apps = {}


-- ===================================================================
-- App Declarations
-- ===================================================================


-- define default apps
apps.default = {
   terminal = "alacritty",
   launcher = "rofi -normal-window -modi drun -show drun",
   lock = "i3lock",
   screenshot = "scrot -e 'mv $f ~/Pictures/ 2>/dev/null'",
   filebrowser = "nautilus"
}

-- List of apps to start once on start-up
local run_on_start_up = {
   "picom",
--   "owncloud",
--   "mailspring -b"
   "setxkbmap -option grp:switch,grp_led:scroll,grp:win_space_toggle -layout us,cz -variant ,qwerty"
}


-- ===================================================================
-- Functionality
-- ===================================================================


-- Run all the apps listed in run_on_start_up
function apps.autostart()
   for _, app in ipairs(run_on_start_up) do
      local findme = app
      local firstspace = app:find(" ")
      if firstspace then
         findme = app:sub(0, firstspace - 1)
      end
--         awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, app), false)
         awful.util.spawn(app)

   end
end
--function apps.autostart()
--	for app = 1, run_on_start_up do
--		awful.util.spawn(run_on_start_up[app])
--	end
--end

return apps
