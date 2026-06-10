--  _   _                  _                 _
-- | | | |_   _ _ __  _ __| | __ _ _ __   __| |
-- | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` |
-- |  _  | |_| | |_) | |  | | (_| | | | | (_| |
-- |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--        |___/|_|

local home = os.getenv("HOME")

local hostname = "unknown"
local f = io.open("/etc/hostname", "r")
if f then
	hostname = f:read("*l"):gsub("%s+", "")
	f:close()
end

-- =====================================================
-- Monitors
-- =====================================================
if hostname == "tyr" then
	hl.monitor({ output = "DP-2", mode = "2560x1440", position = "0x0", scale = 1 })
	hl.monitor({ output = "DP-3", mode = "2560x1440", position = "2560x0", scale = 1 })
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "5120x0", scale = 1 })
elseif hostname == "hoth" then
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "0x0", scale = 1, transform = 1 })
	hl.monitor({ output = "DP-1", mode = "3440x1440", position = "1440x850", scale = 1 })
	hl.monitor({ output = "DP-2", mode = "3440x1440", position = "4880x850", scale = 1 })
elseif hostname == "mustafar" then
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "0x0", scale = 1 })
	hl.monitor({ output = "DP-2", mode = "3440x1440", position = "2560x0", scale = 1 })
	hl.monitor({ output = "DP-1", mode = "3440x1440", position = "6000x0", scale = 1 })
elseif hostname == "dathomir" then
	hl.monitor({ output = "DP-2", mode = "2560x1440", position = "0x0", scale = 1 })
	hl.monitor({ output = "DP-3", mode = "3440x1440", position = "2560x0", scale = 1 })
	hl.monitor({ output = "HDMI-A-1", mode = "2560x1440", position = "6000x0", scale = 1 })
else
	hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })
end

-- =====================================================
-- Colors (Catppuccin Macchiato)
-- =====================================================
local colors = {
	rosewater = "rgb(f4dbd6)",
	flamingo = "rgb(f0c6c6)",
	pink = "rgb(f5bde6)",
	mauve = "rgb(c6a0f6)",
	red = "rgb(ed8796)",
	maroon = "rgb(ee99a0)",
	peach = "rgb(f5a97f)",
	yellow = "rgb(eed49f)",
	green = "rgb(a6da95)",
	teal = "rgb(8bd5ca)",
	sky = "rgb(91d7e3)",
	sapphire = "rgb(7dc4e4)",
	blue = "rgb(8aadf4)",
	lavender = "rgb(b7bdf8)",
	text = "rgb(cad3f5)",
	subtext1 = "rgb(b8c0e0)",
	subtext0 = "rgb(a5adcb)",
	overlay2 = "rgb(939ab7)",
	overlay1 = "rgb(8087a2)",
	overlay0 = "rgb(6e738d)",
	surface2 = "rgb(5b6078)",
	surface1 = "rgb(494d64)",
	surface0 = "rgb(363a4f)",
	base = "rgb(24273a)",
	mantle = "rgb(1e2030)",
	crust = "rgb(181926)",
}

-- =====================================================
-- Environment Variables
-- =====================================================
hl.env("GTK_THEME", "Adwaita-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")

if hostname == "tyr" or hostname == "dathomir" or hostname == "hoth" then
	hl.env("LIBVA_DRIVER_NAME", "nvidia")
	hl.env("GBM_BACKEND", "nvidia-drm")
	hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
	hl.env("WLR_NO_HARDWARE_CURSORS", "1")
	hl.env("WLR_RENDERER_ALLOW_SOFTWARE", "1")

	hl.config({
		cursor = {
			no_hardware_cursors = true,
		},
	})
end

-- =====================================================
-- Autostart
-- =====================================================
hl.on("hyprland.start", function()
	hl.exec_cmd(home .. "/.config/hypr/scripts/autostart/services.sh")
	hl.exec_cmd(home .. "/.config/hypr/scripts/autostart/apps.sh")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("hyprctl dispatcher focusmonitor 1")
	hl.exec_cmd("[workspace 1 silent] brave")
	hl.exec_cmd("[workspace 2 silent] ghostty")
	hl.exec_cmd("[workspace 3 silent] brave")
	hl.exec_cmd("[workspace 4 silent] slack")
	hl.exec_cmd("[workspace 4 silent] discord")
	hl.exec_cmd("[workspace 9 silent] spotify-launcher")
end)

-- =====================================================
-- Input
-- =====================================================
hl.config({
	input = {
		kb_layout = "us,no",
		kb_options = "grp:win_space_toggle",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = false,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- =====================================================
-- General
-- =====================================================
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(cad3f5ee)", "rgba(b7bdf869)", "rgba(b7bdf869)", "rgba(cad3f5ee)" },
				angle = 45,
			},
			inactive_border = "rgba(b7bdf869)",
		},
		layout = "dwindle",
		allow_tearing = false,
	},
})

-- =====================================================
-- Decoration
-- =====================================================
hl.config({
	decoration = {
		rounding = 7,
		active_opacity = 1,
		blur = {
			enabled = true,
			size = 1,
			passes = 4,
			ignore_opacity = true,
			new_optimizations = true,
			xray = false,
			noise = 0.0,
			popups = true,
		},
		shadow = {
			enabled = true,
			range = 30,
			scale = 2,
			render_power = 5,
			color = colors.crust,
			color_inactive = colors.surface0,
		},
		dim_inactive = true,
		dim_strength = 0.10,
	},
})

-- =====================================================
-- Groups
-- =====================================================
hl.config({
	group = {
		auto_group = false,
		col = {
			border_inactive = "rgba(b7bdf869)",
			border_active = {
				colors = { "rgba(cad3f5ee)", "rgba(b7bdf869)", "rgba(b7bdf869)", "rgba(cad3f5ee)" },
				angle = 45,
			},
			border_locked_inactive = "rgba(b7bdf869)",
			border_locked_active = {
				colors = { "rgba(cad3f5ee)", "rgba(b7bdf869)", "rgba(b7bdf869)", "rgba(cad3f5ee)" },
				angle = 45,
			},
		},
		groupbar = {
			gradients = true,
			gradient_rounding = 7,
			indicator_height = 0,
			gradient_round_only_edges = true,
			col = {
				active = "rgba(b7bdf8CC)",
				inactive = "rgba(b8c0e099)",
				locked_active = "rgba(ee99a0CC)",
				locked_inactive = "rgba(b8c0e099)",
			},
			font_family = "Maple Mono NF",
			font_size = 15,
			text_color = colors.crust,
			height = 20,
		},
	},
})

-- =====================================================
-- Animations
-- =====================================================
hl.curve("default", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.02 } } })
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.02 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.02 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1.03 } } })

hl.animation({ leaf = "global", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "popin" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "overshot", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "default", style = "popin" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.25, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })

-- =====================================================
-- Layout
-- =====================================================
hl.config({
	dwindle = {
		-- pseudotile = true,
		preserve_split = true,
	},
})

-- =====================================================
-- Misc
-- =====================================================
hl.config({
	misc = {
		force_default_wallpaper = -1,
	},
	binds = {
		movefocus_cycles_fullscreen = false,
	},
})

-- =====================================================
-- Keybindings
-- =====================================================
local mainMod = "SUPER"
local terminal = "ghostty"
local browser = "brave"
local menu = home .. "/.dotfiles/scripts/launcher.sh"

-- Core
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("wofi --show drun"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(home .. "/.dotfiles/scripts/toggle_keyboard_layout.py"))

-- Waybar
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))

-- Window management
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("nautilus -w"))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Lock screen
hl.bind("CONTROL + ALT + Q", hl.dsp.exec_cmd("pidof hyprlock || (hyprlock)"))

-- Workspace navigation
hl.bind("CONTROL + ALT + left", hl.dsp.focus({ workspace = "-1" }))
hl.bind("CONTROL + ALT + right", hl.dsp.focus({ workspace = "+1" }))

-- Screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(home .. "/.dotfiles/scripts/hypr/hyprshot.sh"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(home .. "/.dotfiles/scripts/hypr/hyprshot-draw.sh"))
hl.bind(mainMod .. " + CONTROL + S", hl.dsp.exec_cmd("hyprshot -m window --hidecursor --no-cursor"))
hl.bind(mainMod .. " + CONTROL + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m output"))

-- Screen recording
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("kooha"))

-- Focus movement
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + TAB", hl.dsp.window.cycle_next())

-- Move windows
hl.bind(mainMod .. " + CONTROL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CONTROL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CONTROL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CONTROL + down", hl.dsp.window.move({ direction = "down" }))

-- Resize
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("hyprctl dispatch splitratio +0.05"))
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("hyprctl dispatch splitratio -0.05"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl dispatch splitratio exact 1"))

-- Workspaces (qtile-like swap)
for i = 0, 9 do
	local ws = i == 0 and 10 or i
	local key = tostring(i)
	hl.bind(mainMod .. " + " .. key, hl.dsp.exec_cmd(home .. "/.dotfiles/scripts/hypr/qtile_like_swap.sh " .. ws))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(home .. "/.dotfiles/scripts/hypr/qtile_like_swap.sh 11"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = 11 }))

-- Toggle workspace shortcuts
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("python " .. home .. "/.dotfiles/scripts/hypr/toggle_workspace.py 4"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("python " .. home .. "/.dotfiles/scripts/hypr/toggle_workspace.py 7"))
hl.bind(
	mainMod .. " + SHIFT + G",
	hl.dsp.exec_cmd(
		"[workspace 7] gamescope --backend sdl -W 3440 -H 1440 -r 120 --adaptive-sync --steam --force-grab-cursor -f -- steam -gamepadui"
	)
)

-- Scratchpad
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("tmp"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.window.move({ workspace = "special:tmp" }))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(home .. "/scripts/audio/volume_up.sh"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(home .. "/scripts/audio/volume_down.sh"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(home .. "/scripts/audio/volume_mute.sh"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(home .. "/scripts/audio/player_next.sh"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(home .. "/scripts/audio/player_previous.sh"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(home .. "/scripts/audio/player_play_or_pause.sh"), { locked = true })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(home .. "/scripts/audio/player_stop.sh"), { locked = true })

-- Mouse binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- =====================================================
-- Window Rules
-- =====================================================
-- hl.window_rule({ match = { class = ".*" }, suppress_event = { "fullscreen", "maximize" } })
hl.window_rule({ match = { class = "^scrcpy$" }, pseudo = true })
