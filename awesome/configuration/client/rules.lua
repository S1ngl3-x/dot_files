local awful = require('awful')
local gears = require('gears')
local ruled = require('ruled')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

ruled.client.connect_signal(
	'request::rules',
	function()

		-- All clients will match this rule.
		ruled.client.append_rule {
			id         = 'global',
			rule       = { },
			properties = {
				focus     = awful.client.focus.filter,
				raise     = true,
				floating = false,
				maximized = false,
				above = false,
				below = false,
				ontop = false,
				sticky = false,
				maximized_horizontal = false,
				maximized_vertical = false,
				round_corners = true,
				keys = client_keys,
				buttons = client_buttons,
				screen    = awful.screen.preferred,
				shape = function(cr, width, height)
					gears.shape.rectangle(cr, width, height)
				end,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen
			}
		}

		-- Titlebar rules
		ruled.client.append_rule {
			id 		= 'titlebars',
			rule_any   = {
				type = {
					'normal',
					'dialog'
				}
			},
			properties = {
				titlebars_enabled = true
			}
		}

		-- Dialogs
		ruled.client.append_rule {
			id         = 'dialog',
			rule_any   = { 
				type  = { 'dialog' },
				class = { 'Wicd-client.py', 'calendar.google.com' }
			},
			properties = { 
				titlebars_enabled = true,
				floating = true,
				above = true,
				draw_backdrop = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Modals
		ruled.client.append_rule {
			id         = 'dialog',
			rule_any   = { 
				type = { 'modal' }
			},
			properties = { 
				titlebars_enabled = true,
				floating = true,
				above = true,
				draw_backdrop = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Utilities
		ruled.client.append_rule {
			id         = 'utility',
			rule_any   = { 
				type = { 'utility' }
			},
			properties = { 
				titlebars_enabled = false,
				floating = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Splash
		ruled.client.append_rule {
			id         = 'splash',
			rule_any   = { 
				type = { 'splash' }
			},
			properties = {
				titlebars_enabled = false,
				round_corners = false,
				floating = true,
				above = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Terminal emulators
		ruled.client.append_rule {
			id         = 'terminals',
			rule_any   = { 
				class = { 
					'URxvt',
					'XTerm',
					'UXTerm',
					'kitty',
					'K3rmit',
					"jetbrains-datagrip"
				}
			},
			properties = {
				tag = '1',
				switch_to_tags = true,
				size_hints_honor = false,
				titlebars_enabled = true
			}
		}

		-- Text editors and word processing
		ruled.client.append_rule {
			id         = 'text_editors',
			rule_any   = {
				class = {
					'Geany',
					'Atom',
					'Subl3',
					'code-oss',
					"jetbrains-idea",
					"jetbrains-webstorm",
					"jetbrains-clion",
					"DesktopEditors"
				},
				name  = {
					'LibreOffice',
					'libreoffice'
				}
			},
			properties = { 
				tag = '2',
				switch_to_tags = true
			}
		}

		-- Browsers
		ruled.client.append_rule {
			id         = 'web_browsers',
			rule_any   = {
				class = {
					'firefox',
					'Tor Browser',
					'discord',
					'Chromium',
					'Google-chrome',
					"Vivaldi"
				}
			},
			properties = {
				tag = '3',
				switch_to_tags = true
			}
		}

		-- File managers and chats
		ruled.client.append_rule {
			id         = 'file_managers',
			rule_any   = {
				class = {
					'dolphin',
					'ark',
					"thunar",
					'File-roller',
					"Slack",
					"Caprine",
					"Signal Beta"
				}
			},
			properties = { 
				tag = '4',
				switch_to_tags = true
			}
		}

		-- Multimedia
		ruled.client.append_rule {
			id         = 'multimedia',
			rule_any   = {
				class = {
					'vlc',
--					'Spotify',
					"mpv"
				}
			},
			properties = { 
				tag = '5',
				switch_to_tags = true,
				draw_backdrop = false
			}
		}

		-- Email and tools
		ruled.client.append_rule {
			id         = 'ide',
			rule_any   = {
				class = {
					'Oomox',
					'Unity',
					'UnityHub',
					'Ettercap',
					"Mailspring",
					"MineTime"
				}
			},
			properties = {
				tag = '6',
				skip_decoration = true,
				switch_to_tags = true
			}
		}

		-- Multimedia Streaming And Editing
		ruled.client.append_rule {
			id         = 'graphics_editors',
			rule_any   = {
				class = {
					'Gimp-2.10',
					'Inkscape',
					'Flowblade',
					"zoom",
					"Microsoft Teams - Preview"
				}
			},
			properties = { 
				tag = '7',
				skip_decoration = true,
				switch_to_tags = true,
				floating = true,
				placement = awful.placement.centered
			}
		}

		-- Sandboxes and VMs
		ruled.client.append_rule {
			id         = 'sandbox',
			rule_any   = {
				class = {
					'VirtualBox Manage',
					'VirtualBox Machine'
				}
			},
			properties = { 
				tag = '8'
			}
		}

		-- Gaming
		ruled.client.append_rule {
			id         = 'gaming',
			rule_any   = {
				class = {
					'Wine',
					'dolphin-emu',
					'Steam',
					'Citra',
					'supertuxkart'
				},
				name = { 'Steam' }
			},
			properties = {
				tag = '9',
				skip_decoration = true,
				switch_to_tags = true,
				floating = true,
				placement = awful.placement.centered
			}
		}

		-- Image viewers
		ruled.client.append_rule {
			id        = 'image_viewers',
			rule_any  = {
				class    = {
					'feh',
					'Pqiv',
					'Sxiv'
				},
			},
			properties = { 
				titlebars_enabled = true,
				skip_decoration = true,
				floating = true,
				ontop = false,
				placement = awful.placement.centered
			}
		}

		-- Discord updater
		ruled.client.append_rule {
			id        = 'discord_updater',
			rule_any  = {
				name = {'Discord Updater'}
			},
			properties = { 
				round_corners = false,
				skip_decoration = true,
				titlebars_enabled = false,
				floating = true,
				ontop = true,
				placement = awful.placement.centered
			}
		}

		-- Floating
		ruled.client.append_rule {
			id       = 'floating',
			rule_any = {
				instance    = {
					'file_progress',
					'Popup',
					'nm-connection-editor',
				},
				class = { 
					'scrcpy' ,
					'Mugshot',
					'Pulseeffects'
				}
			},
			properties = { 
				titlebars_enabled = true,
				skip_decoration = true,
				ontop = true,
				floating = true,
				focus = awful.client.focus.filter,
				raise = true,
				keys = client_keys,
				buttons = client_buttons,
				placement = awful.placement.centered
			}
		}

		-- Stupid Microsoft Teams rule to stop notifications from dividing my screen in half
--		ruled.client.append_rule {
--			id       = 'microsoft-teams',
--			rule_any = {
--				class = {
--					"Microsoft Teams - Preview"
--				}
--			},
--			properties = {
--				titlebars_enabled = true,
--				skip_decoration = true,
--				floating = true,
--				focus = awful.client.focus.filter,
--				raise = true,
--				keys = client_keys,
--				buttons = client_buttons,
--				placement = awful.placement.centered
--			}
--		}
		
	end
)


-- Normally we'd do this with a rule, but some program like spotify doesn't set its class or name
-- until after it starts up, so we need to catch that signal.

-- If the application is fullscreen in its settings, make sure to set `c.fullscreen = false` first
-- before moving to the desired tag or else the tag where the program spawn will cause panels to hide. 
-- After moving the program to specified tag you can set `c.fullscreen = true` now

client.connect_signal(
	'property::class',
	function(c)
		if c.class == 'Spotify' then
			local window_mode = false

			-- Check if fullscreen or window mode
			if c.fullscreen then
				window_mode = false
				c.fullscreen = false
			else
				window_mode = true
			end

			-- Check if Spotify is already open
			local stk = function (c)
				return ruled.client.match(c, { class = 'Spotify' })
			end

			local stk_count = 0
			for c in awful.client.iterate(stk) do
				stk_count = stk_count + 1
			end

			-- If Spotify is already open, don't open a new instance
			if stk_count > 1 then
				c:kill()
				-- Switch to previous instance
				for c in awful.client.iterate(stk) do
					c:jump_to(false)
				end
			else
				-- Move the instance to specified tag on this screen
				local t = awful.tag.find_by_name(awful.screen.focused(), '5')
				c:move_to_tag(t)
				t:view_only()

				-- Fullscreen mode if not window mode
				if not window_mode then
					c.fullscreen = true
				else
					c.floating = true
				end
			end
		end
	end
)
