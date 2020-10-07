local config = require('configuration.secrets')
local secrets = {
	email_address = config.widget.email.address,
	app_password = config.widget.email.app_password,
	weatherApiKey = config.widget.weather.key,
	city = config.widget.weather.city_id,
	wired_interface = config.widget.network.wired_interface,
	wireless_interface = config.widget.network.wireless_interface,
	fallbackPassword = config.module.lockscreen.fallback_password
}

return {
	widget = {
		email  = {
			address       = 'secrets.email.address',
			app_password  = 'secrets.app_password',
			imap_server   = 'imap.seznam.cz',
			port          = '993'
		},

		weather = {
			key           = secrets.weatherApiKey,
			city_id       = secrets.city,
			units         = 'metric',
			update_interval = 1200
		},

		network = {
			wired_interface = secrets.wired_interface,
			wireless_interface = secrets.wireless_interface
		},

		clock = {
			military_mode = true,
		},

		screen_recorder = {
			resolution = '1366x768',
			offset = '0,0',
			audio = false,
			save_directory = '$(xdg-user-dir VIDEOS)/Recordings/',
			mic_level = '20',
			fps = '30'
		}
	},

	module = {
		auto_start = {
			debug_mode = false
		},

		dynamic_wallpaper = {
			wall_dir = 'theme/wallpapers/',
			valid_picture_formats = {"jpg", "png", "jpeg"},
			-- Leave this table empty for full auto scheduling
			wallpaper_schedule = {
				['00:00:00'] = 'midnight-wallpaper.jpg',
				['06:22:00'] = 'morning-wallpaper.jpg',
				['12:00:00'] = 'noon-wallpaper.jpg',
				['17:58:00'] = 'night-wallpaper.jpg'
			-- Example of just using auto-scheduling with keywords
			--[[
				'midnight',
				'morning',
				'noon',
				'afternoon',
				'evening',
				'night'
			--]]
			},
			stretch = true -- false => STRECH ACROSS DISPLAYS
		},

		lockscreen = {
			military_clock = true,
			fallback_password = secrets.fallbackPassword,
			capture_intruder = true,
			face_capture_dir = '$(xdg-user-dir PICTURES)/Intruders/',
			blur_background = true,
			wall_dir = 'theme/wallpapers/',
			default_wall_name = 'morning-wallpaper.jpg',
			tmp_wall_dir = '/tmp/awesomewm/' .. os.getenv('USER') .. '/'
		}
	}
}
