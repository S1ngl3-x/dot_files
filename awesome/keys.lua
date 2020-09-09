--      ██╗  ██╗███████╗██╗   ██╗███████╗
--      ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
--      █████╔╝ █████╗   ╚████╔╝ ███████╗
--      ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
--      ██║  ██╗███████╗   ██║   ███████║
--      ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local dpi = beautiful.xresources.apply_dpi

-- Default Applications
local apps = require("apps").default

-- Define mod keys
local modkey = "Mod4"
local altkey = "Mod1"

-- define module table
local keys = {}


-- ===================================================================
-- Movement Functions (Called by some keybinds)
-- ===================================================================


-- Move given client to given direction
local function move_client(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        local workarea = awful.screen.focused().workarea
        if direction == "up" then
            c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
        elseif direction == "down" then
            c:geometry({ nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil })
        elseif direction == "left" then
            c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
        elseif direction == "right" then
            c:geometry({ x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil })
        end
        -- Otherwise swap the client in the tiled layout
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end


-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
    if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
        end
    else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
    end
end


-- raise focused client
local function raise_client()
    if client.focus then
        client.focus:raise()
    end
end


-- ===================================================================
-- Mouse bindings
-- ===================================================================


-- Mouse buttons on the desktop
keys.desktopbuttons = gears.table.join(-- left click on desktop to hide notification
    awful.button({}, 1,
        function()
            naughty.destroy_all_notifications()
        end))

-- Mouse buttons on the client
keys.clientbuttons = gears.table.join(-- Raise client
    awful.button({}, 1,
        function(c)
            client.focus = c
            c:raise()
        end),

    -- Move and Resize Client
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


-- ===================================================================
-- Desktop Key bindings
-- ===================================================================


keys.globalkeys = gears.table.join(-- =========================================
-- SPAWN APPLICATION KEY BINDINGS
-- =========================================

-- =========================================
-- FUNCTION KEYS
-- =========================================

-- Brightness
    awful.key({}, "XF86MonBrightnessUp",
        function()
            awful.spawn("xbacklight -inc 10", false)
        end,
        { description = "+10%", group = "hotkeys" }),
    awful.key({}, "XF86MonBrightnessDown",
        function()
            awful.spawn("xbacklight -dec 10", false)
        end,
        { description = "-10%", group = "hotkeys" }),

    -- ALSA volume control
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%+", false)
            awesome.emit_signal("volume_change")
        end,
        { description = "volume up", group = "hotkeys" }),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%-", false)
            awesome.emit_signal("volume_change")
        end,
        { description = "volume down", group = "hotkeys" }),
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn("amixer -D pulse set Master 1+ toggle", false)
            awesome.emit_signal("volume_change")
        end,
        { description = "toggle mute", group = "hotkeys" }),
    awful.key({}, "XF86AudioNext",
        function()
            awful.spawn("mpc next", false)
        end,
        { description = "next music", group = "hotkeys" }),
    awful.key({}, "XF86AudioPrev",
        function()
            awful.spawn("mpc prev", false)
        end,
        { description = "previous music", group = "hotkeys" }),
    awful.key({}, "XF86AudioPlay",
        function()
            awful.spawn("mpc toggle", false)
        end,
        { description = "play/pause music", group = "hotkeys" }),

    -- Screenshot on prtscn using scrot
    awful.key({}, "Print",
        function()
            awful.util.spawn(apps.screenshot, false)
        end),

    -- =========================================
    -- RELOAD / QUIT AWESOME
    -- =========================================

    -- Reload Awesome
    awful.key({ modkey, "Shift" }, "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    -- Quit Awesome
    awful.key({ modkey }, "Escape",
        function()
            -- emit signal to show the exit screen
            awesome.emit_signal("show_exit_screen")
        end,
        { description = "toggle exit screen", group = "hotkeys" }),

    awful.key({}, "XF86PowerOff",
        function()
            -- emit signal to show the exit screen
            awesome.emit_signal("show_exit_screen")
        end,
        { description = "toggle exit screen", group = "hotkeys" }),

    awful.key({ modkey, }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    -- =========================================
    -- UTILITIES
    -- =========================================

    awful.key({}, "Print", function() awful.util.spawn("flameshot screen -c -p /home/adam/Pictures/screenshots/") end,
        { description = "screenshot of 1 screen", group = "hotkeys" }),

    awful.key({ "Shift" }, "Print", function() awful.util.spawn("flameshot full -c -p /home/adam/Pictures/screenshots/") end,
        { description = "screenshot of all screens", group = "hotkeys" }),

    awful.key({ modkey, "Shift" }, "s", function() awful.util.spawn("flameshot gui -p /home/adam/Pictures/screenshots") end,
        { description = "take a screenshot", group = "hotkeys" }),

    -- =========================================
    -- BASIC PROGRAMS
    -- =========================================

    -- Spawn terminal
    awful.key({ modkey }, "Return",
        function()
            awful.spawn(apps.terminal)
        end,
        { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey }, "r",
        function()
            awful.spawn(apps.launcher)
        end,
        { description = "application launcher", group = "launcher" }),

    awful.key({ modkey }, "b", function()
        awful.util.spawn("vivaldi-stable")
    end,
        { description = "Vivaldi", group = "launcher" }),

    awful.key({ modkey }, "q", function()
        awful.util.spawn("thunar")
    end,
        { description = "File manager", group = "launcher" }),

    -- =========================================
    -- BASIC PROGRAMS
    -- =========================================

    awful.key({ modkey, altkey }, "i", function()
        awful.util.spawn("intellij-idea-ultimate-edition")
    end,
        { description = "Intellij", group = "apps" }),

    awful.key({ modkey, altkey }, "m", function()
        awful.util.spawn("mailspring")
    end,
        { description = "Mailspring", group = "apps" }),

    awful.key({ modkey, altkey }, "a", function()
        awful.util.spawn("android-studio-beta")
    end,
        { description = "Android Studio", group = "apps" }),

    awful.key({ modkey, altkey }, "p", function()
        awful.util.spawn("spotify --force-device-scale-factor=1.5 %U")
    end,
        { description = "Spotify", group = "apps" }),

    awful.key({ modkey, altkey }, "s", function()
        awful.util.spawn("slack")
    end,
        { description = "Slack", group = "apps" }),

    awful.key({ modkey, altkey }, "w", function()
        awful.util.spawn("webstorm")
    end,
        { description = "Webstorm", group = "apps" }),

    awful.key({ modkey, altkey }, "t", function()
        awful.util.spawn("teams")
    end,
        { description = "Microsoft Teams", group = "apps" }),

    awful.key({ modkey, altkey }, "k", function()
        awful.util.spawn("keepassxc")
    end,
        { description = "KeePassXC", group = "apps" }),

    awful.key({ modkey, altkey }, "d", function()
        awful.util.spawn("datagrip")
    end,
        { description = "Data Grip", group = "apps" }),

    awful.key({ modkey, altkey }, "g", function()
        awful.util.spawn("google-chrome-stable")
    end,
        { description = "Google Chrome", group = "apps" }),

    awful.key({ modkey, altkey }, "c", function()
        awful.util.spawn("caprine")
    end,
        { description = "Caprine", group = "apps" }),


    awful.key({ modkey, altkey }, "o", function()
        awful.util.spawn("ms-office-online")
    end,
        { description = "Microsoft Office", group = "apps" }),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus right", group = "client" }),
    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),


    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),
    awful.key({ modkey, }, "Tab",
        function()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        { description = "cycle with previous/go back", group = "client" }),
    awful.key({ modkey, "Shift" }, "Tab",
        function()
            if cycle_prev then
                awful.client.focus.byidx(1)
                if client.focus then
                    client.focus:raise()
                end
            end
        end,
        { description = "go forth", group = "client" }),

    -- Focus client by direction (arrow keys)
    awful.key({ modkey }, "Down",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        { description = "focus down", group = "client" }),
    awful.key({ modkey }, "Up",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        { description = "focus up", group = "client" }),
    awful.key({ modkey }, "Left",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        { description = "focus left", group = "client" }),
    awful.key({ modkey }, "Right",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        { description = "focus right", group = "client" }),

    -- Focus client by index (cycle through clients)
    awful.key({ modkey }, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }),

    -- =========================================
    -- CLIENT RESIZING
    -- =========================================

    awful.key({ modkey, "Control" }, "Down",
        function(c)
            resize_client(client.focus, "down")
        end),
    awful.key({ modkey, "Control" }, "Up",
        function(c)
            resize_client(client.focus, "up")
        end),
    awful.key({ modkey, "Control" }, "Left",
        function(c)
            resize_client(client.focus, "left")
        end),
    awful.key({ modkey, "Control" }, "Right",
        function(c)
            resize_client(client.focus, "right")
        end),
    awful.key({ modkey, "Control" }, "j",
        function(c)
            resize_client(client.focus, "down")
        end),
    awful.key({ modkey, "Control" }, "k",
        function(c)
            resize_client(client.focus, "up")
        end),
    awful.key({ modkey, "Control" }, "h",
        function(c)
            resize_client(client.focus, "left")
        end),
    awful.key({ modkey, "Control" }, "l",
        function(c)
            resize_client(client.focus, "right")
        end),

    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================

    -- Number of master clients
    awful.key({ modkey, altkey }, "h",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        { description = "decrease the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "Left",
        function()
            awful.tag.incnmaster(1, nil, true)
        end,
        { description = "increase the number of master clients", group = "layout" }),
    awful.key({ modkey, altkey }, "Right",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        { description = "decrease the number of master clients", group = "layout" }),

    -- Number of columns
    awful.key({ modkey, altkey }, "k",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "j",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "decrease the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "Up",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        { description = "increase the number of columns", group = "layout" }),
    awful.key({ modkey, altkey }, "Down",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "decrease the number of columns", group = "layout" }),

    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key({ modkey, "Shift" }, "minus",
        function()
            awful.tag.incgap(5, nil)
        end,
        { description = "increment gaps size for the current tag", group = "gaps" }),
    awful.key({ modkey }, "minus",
        function()
            awful.tag.incgap(-5, nil)
        end,
        { description = "decrement gap size for the current tag", group = "gaps" }),

    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    -- awful.key({modkey}, "space",
    --    function()
    --       awful.layout.inc(1)
    --    end,
    --    {description = "select next", group = "layout"}
    -- ),
    -- -- select previous layout
    -- awful.key({modkey, "Shift"}, "space",
    --    function()
    --       awful.layout.inc(-1)
    --    end,
    --    {description = "select previous", group = "layout"}
    -- ),

    -- =========================================
    -- CLIENT MINIMIZATION
    -- =========================================

    -- restore minimized client
    awful.key({ modkey, "Shift" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        { description = "restore minimized", group = "client" }))


-- ===================================================================
-- Client Key bindings
-- ===================================================================


keys.clientkeys = gears.table.join(-- Move to edge or swap by direction
    awful.key({ modkey, "Shift" }, "Down",
        function(c)
            move_client(c, "down")
        end),
    awful.key({ modkey, "Shift" }, "Up",
        function(c)
            move_client(c, "up")
        end),
    awful.key({ modkey, "Shift" }, "Left",
        function(c)
            move_client(c, "left")
        end),
    awful.key({ modkey, "Shift" }, "Right",
        function(c)
            move_client(c, "right")
        end),
    awful.key({ modkey, "Shift" }, "j",
        function(c)
            move_client(c, "down")
        end),
    awful.key({ modkey, "Shift" }, "k",
        function(c)
            move_client(c, "up")
        end),
    awful.key({ modkey, "Shift" }, "h",
        function(c)
            move_client(c, "left")
        end),
    awful.key({ modkey, "Shift" }, "l",
        function(c)
            move_client(c, "right")
        end),

    -- toggle fullscreen
    awful.key({ modkey }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
        end,
        { description = "toggle fullscreen", group = "client" }),

    -- close client
    awful.key({ modkey }, "x",
        function(c)
            c:kill()
        end,
        { description = "close", group = "client" }),

    -- Minimize
    awful.key({ modkey }, "n",
        function(c)
            c.minimized = true
        end,
        { description = "minimize", group = "client" }),
awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),

    -- Maximize
    awful.key({ modkey }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        { description = "(un)maximize", group = "client" }))

-- Bind all key numbers to tags
for i = 1, 9 do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- Switch to tag
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            { description = "view tag #" .. i, group = "tag" }),
        -- Move client to tag
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }))
end

return keys
