local awful = require('awful')
local beautiful = require('beautiful')

require('awful.autofocus')

local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key
local apps = require('configuration.apps')

-- Key bindings
local globalKeys = awful.util.table.join(

	-- Hotkeys
	awful.key(
		{modkey}, 
		'F1', 
		hotkeys_popup.show_help, 
		{description = 'show help', group = 'awesome'}
	),
	awful.key({modkey, 'Control'}, 
		'r', 
		awesome.restart, 
		{description = 'reload awesome', group = 'awesome'}
	),
	
	awful.key({modkey, 'Control'}, 
		'q', 
		awesome.quit, 
		{description = 'quit awesome', group = 'awesome'}
	),
	awful.key(
		{modkey},
		'l',
		function()
			awful.tag.incmwfact(0.05)
		end,
		{description = 'increase master width factor', group = 'layout'}
	),
	awful.key(
		{modkey},
		'h',
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{description = 'decrease master width factor', group = 'layout'}
	),
	awful.key(
		{modkey, 'Control'},
		'h',
		function()
			awful.tag.incncol(1, nil, true)
		end,
		{description = 'increase the number of columns', group = 'layout'}
	),
	awful.key(
		{modkey, 'Control'},
		'l',
		function()
			awful.tag.incncol(-1, nil, true)
		end,
		{description = 'decrease the number of columns', group = 'layout'}
	),
	awful.key(
		{modkey, 'Shift'},
		'space',
		function()
			awful.layout.inc(-1)
		end,
		{description = 'select previous layout', group = 'layout'}
	),
	awful.key(
		{modkey},
		'g',
		function()
			awful.tag.incgap(1)
		end,
		{description = 'increase gap', group = 'layout'}
	),
	awful.key(
		{modkey, 'Shift'},
		'g',
		function()
			awful.tag.incgap(-1)
		end,
		{description = 'decrease gap', group = 'layout'}
	),
	awful.key(
		{modkey}, 
		'w', 
		awful.tag.viewprev, 
		{description = 'view previous tag', group = 'tag'}
	),
	awful.key(
		{modkey}, 
		's', 
		awful.tag.viewnext, 
		{description = 'view next tag', group = 'tag'}
	),
--	awful.key(
--		{modkey},
--		'Escape',
--		awful.tag.history.restore,
--		{description = 'alternate between current and previous tag', group = 'tag'}
--	),
	awful.key({ modkey, 'Control' }, 
		'w',
		function ()
			-- tag_view_nonempty(-1)
			local focused = awful.screen.focused()
			for i = 1, #focused.tags do
				awful.tag.viewidx(-1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end, 
		{description = 'view previous non-empty tag', group = 'tag'}
	),
	awful.key({ modkey, 'Control' }, 
		's',
		function ()
			-- tag_view_nonempty(1)
			local focused =  awful.screen.focused()
			for i = 1, #focused.tags do
				awful.tag.viewidx(1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end, 
		{description = 'view next non-empty tag', group = 'tag'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'F1',  
		function() 
			awful.screen.focus_relative(-1) 
		end,
		{ description = 'focus the previous screen', group = 'screen'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'F2', 
		function()
			awful.screen.focus_relative(1)
		end,
		{ description = 'focus the next screen', group = 'screen'}
	),
	awful.key(
		{modkey, 'Control'},
		'n',
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				client.focus = c
				c:raise()
			end
		end,
		{description = 'restore minimized', group = 'screen'}
	),
	awful.key(
		{},
		'XF86MonBrightnessUp',
		function()
			awful.spawn('light -A 10', false)
			awesome.emit_signal('widget::brightness')
			awesome.emit_signal('module::brightness_osd:show', true)
		end,
		{description = 'increase brightness by 10%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86MonBrightnessDown',
		function()
			awful.spawn('light -U 10', false)
			awesome.emit_signal('widget::brightness')
			awesome.emit_signal('module::brightness_osd:show', true)
		end,
		{description = 'decrease brightness by 10%', group = 'hotkeys'}
	),
	-- ALSA volume control
	awful.key(
		{},
		'XF86AudioRaiseVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%+', false)
			awesome.emit_signal('widget::volume')
			awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'increase volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioLowerVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%-', false)
			awesome.emit_signal('widget::volume')
			awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'decrease volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioMute',
		function()
			awful.spawn('amixer -D pulse set Master 1+ toggle', false)
		end,
		{description = 'toggle mute', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioNext',
		function()
			awful.spawn('mpc next', false)
		end,
		{description = 'next music', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPrev',
		function()
			awful.spawn('mpc prev', false)
		end,
		{description = 'previous music', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPlay',
		function()
			awful.spawn('mpc toggle', false)
		end,
		{description = 'play/pause music', group = 'hotkeys'}

	),
	awful.key(
		{},
		'XF86AudioMicMute',
		function()
			awful.spawn('amixer set Capture toggle', false)
		end,
		{description = 'mute microphone', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86PowerDown',
		function()
			--
		end,
		{description = 'shutdown skynet', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86PowerOff',
		function()
			awesome.emit_signal('module::exit_screen:show')
		end,
		{description = 'toggle exit screen', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86Display',
		function()
			awful.spawn.single_instance('arandr', false)
		end,
		{description = 'arandr', group = 'hotkeys'}
	),
	awful.key(
		{modkey},
		"Escape",
		function()
			awesome.emit_signal('module::exit_screen:show')
		end,
		{description = 'toggle exit screen', group = 'hotkeys'}
	),
	awful.key(
		{modkey},
		'`',
		function()
			awesome.emit_signal('module::quake_terminal:toggle')
		end,
		{description = 'dropdown application', group = 'launcher'}
	),
	awful.key(
		{ }, 
		'Print',
		function ()
			awful.spawn.easy_async_with_shell(apps.utils.full_screenshot,function() end)
		end,
		{description = 'fullscreen screenshot', group = 'Utility'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		's',
		function ()
			awful.spawn.easy_async_with_shell(apps.utils.area_screenshot,function() end)
		end,
		{description = 'area/selected screenshot', group = 'Utility'}
	),
	awful.key(
		{modkey},
		']',
		function()
			awesome.emit_signal('widget::blur:increase')
		end,
		{description = 'increase blur effect by 10%', group = 'Utility'}
	),
	awful.key(
		{modkey},
		'[',
		function()
			awesome.emit_signal('widget::blur:decrease')
		end,
		{description = 'decrease blur effect by 10%', group = 'Utility'}
	),
	awful.key(
		{modkey},
		't',
		function() 
			awesome.emit_signal('widget::blue_light:toggle')
		end,
		{description = 'toggle redshift filter', group = 'Utility'}
	),
	awful.key(
		{ 'Control' }, 
		'Escape', 
		function ()
			if screen.primary.systray then
				if not screen.primary.tray_toggler then
					local systray = screen.primary.systray
					systray.visible = not systray.visible
				else
					awesome.emit_signal('widget::systray:toggle')
				end
			end
		end, 
		{description = 'toggle systray visibility', group = 'Utility'}
	),
	awful.key(
		{modkey, "Shift"},
		'Escape',
		function()
			awful.spawn(apps.default.lock, false)
		end,
		{description = 'lock the screen', group = 'Utility'}
	),
	awful.key(
		{modkey}, 
		'Return',
		function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'e',
		function()
			awful.spawn(apps.default.file_manager)
		end,
		{description = 'open default file manager', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'f',
		function()
			awful.spawn(apps.default.web_browser)
		end,
		{description = 'open default web browser', group = 'launcher'}
	),
	awful.key(
		{'Control', 'Shift'}, 
		'Escape',
		function()
			awful.spawn(apps.default.terminal .. ' ' .. 'htop')
		end,
		{description = 'open system monitor', group = 'launcher'}
	),
	awful.key(
		{modkey}, 
		'e',
		function()
			local focused = awful.screen.focused()

			if focused.control_center then
				focused.control_center:hide_dashboard()
				focused.control_center.opened = false
			end
			if focused.info_center then
				focused.info_center:hide_dashboard()
				focused.info_center.opened = false
			end
			awful.spawn(apps.default.rofi_appmenu, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),
	awful.key(
		{}, 
		'XF86Launch1',
		function()
			local focused = awful.screen.focused()

			if focused.control_center then
				focused.control_center:hide_dashboard()
				focused.control_center.opened = false
			end
			if focused.info_center then
				focused.info_center:hide_dashboard()
				focused.info_center.opened = false
			end
			awful.spawn(apps.default.rofi_appmenu, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'},
		'x',
		function()
			awful.spawn(apps.default.rofi_global, false)
		end,
		{description = 'open global search', group = 'launcher'}
	),
	awful.key(
		{modkey},
		'r',
		function()
			local focused = awful.screen.focused()
			if focused.info_center and focused.info_center.visible then
				focused.info_center:toggle()
			end
			focused.control_center:toggle()
		end,
		{description = 'open control center', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'},
		'r',
		function()
			local focused = awful.screen.focused()
			if focused.control_center and focused.control_center.visible then
				focused.control_center:toggle()
			end
			focused.info_center:toggle()
		end,
		{description = 'open info center', group = 'launcher'}
	),

	awful.key({ modkey }, "q", function()
		awful.util.spawn("nemo")
	end,
		{ description = "File manager", group = "launcher" }),

	-- =========================================
	-- BASIC PROGRAMS
	-- =========================================

	awful.key({ modkey }, "b", function()
		awful.util.spawn("vivaldi-stable")
	end,
		{ description = "Vivaldi", group = "launcher" }),

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
--		awful.util.spawn("spotify --force-device-scale-factor=1.5 %U")
		awful.util.spawn("spotify")
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
		{ description = "Microsoft Office", group = "apps" })

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = {description = 'view tag #', group = 'tag'}
		descr_toggle = {description = 'toggle tag #', group = 'tag'}
		descr_move = {description = 'move focused client to tag #', group = 'tag'}
		descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
	end
	globalKeys =
		awful.util.table.join(
		globalKeys,
		-- View tag only.
		awful.key(
			{modkey},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			descr_view
		),
		-- Toggle tag display.
		awful.key(
			{modkey, 'Control'},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			descr_toggle
		),
		-- Move client to tag.
		awful.key(
			{modkey, 'Shift'},
			'#' .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			descr_move
		),
		-- Toggle tag on focused client.
		awful.key(
			{modkey, 'Control', 'Shift'},
			'#' .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			descr_toggle_focus
		)
	)
end

return globalKeys
