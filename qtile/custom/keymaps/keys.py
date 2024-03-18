from libqtile.config import Key
from libqtile.lazy import lazy

from ..settings.keys import Keys

mod = "mod4"

mod = "mod4"    # Sets mod key to SUPER/WINDOWS
myTerm = "kitty"    # My terminal of choice
myBrowser = "brave"    # My browser of choice
files = "thunar"

launcher = "/home/aj/scripts/launcher.sh"
toggle_keys = "python3 /home/aj/scripts/toggle_keyboard_layout.py"
lock_screen = "sh /home/aj/scripts/lock.sh"

k = Keys()

vol_cur = "amixer -D pulse get Master"
vol_up = "amixer -q -D pulse set Master 2%+"
vol_down = "amixer -q -D pulse set Master 2%-"
vol_mute = "amixer -q -D pulse set Master toggle"

player_prev = "playerctl previous --player=spotify"
player_next = "playerctl next --player=spotify"
player_play_pause = "playerctl play-pause --player=spotify"
player_stop = "playerctl stop --player=spotify"

real_layout = {}


def getKeys():
	return [
	### The essentials
		Key([k.alt, k.control], "q", lazy.spawn(lock_screen),
			desc="Lock screen"),
		Key([mod], "q", lazy.window.kill(), desc='Kill active window'),
		Key([mod, k.shift], "r", lazy.restart(), desc='Restart Qtile'),
		Key([mod, k.shift], "q", lazy.shutdown(), desc='Shutdown Qtile'),
		Key([mod], "Return", lazy.spawn(myTerm + " -e zsh"),
			desc='Launches My Terminal'),
		Key([k.mod], k.space, lazy.spawn(toggle_keys), desc="Toggle keyboard"),

	### Apps
		Key([mod], "w", lazy.spawn(myBrowser), desc='Open browser'),
		Key([mod], "s", lazy.spawn("flameshot gui"),
			desc='Open screenshot tool'),
		Key([mod, k.shift], "s", lazy.spawn("peek"),
			desc='Open screencast tool'),
		Key([k.mod], "n", lazy.spawn(files), desc="Launch file browser"),
		Key([mod], "d", lazy.spawn(launcher), desc='Run Launcher'),
		Key([k.alt], k.space, lazy.spawn(launcher), desc='Run Launcher'),

	### Layout
		Key([k.control], k.tab, lazy.next_layout(),
			desc="Toggle between layouts"),
		Key([k.control, k.shift], k.tab, lazy.prev_layout(),
			desc="Toggle between layouts"),
		Key([k.mod], "b", lazy.hide_show_bar("top"),
			desc='toggle the display of the bar'),
		Key([k.mod], "t", lazy.window.toggle_floating(),
			desc="Toggle floating"),
		Key([k.mod], "m", lazy.window.toggle_maximize(),
			desc="Toggle maximize"),

	### Navigate
		Key([k.mod, k.control], k.down, lazy.layout.shuffle_down(),
			desc="Move window down in current stack "),
		Key([k.mod, k.control], k.up, lazy.layout.shuffle_up(),
			desc="Move window up in current stack "),
		Key([k.mod, k.control], k.left, lazy.layout.shuffle_left(),
			desc="Move window left in current stack "),
		Key([k.mod, k.control], k.right, lazy.layout.shuffle_right(),
			desc="Move window right in current stack "),
		Key([k.mod, k.shift], k.right, lazy.layout.client_to_next(),
			desc="Move window to next"),
		Key([k.mod, k.shift], "Return", lazy.layout.toggle_split(),
			desc="Toggle between split and unsplit sides of stack"),

	### Switch between windows in current stack pane
		Key([k.mod], k.down, lazy.layout.down()),
		Key([k.mod], k.up, lazy.layout.up()),
		Key([k.mod], k.left, lazy.layout.previous()),
		Key([k.mod], k.right, lazy.layout.next()),

	### Move windows in current stack pane
		Key([k.control, k.alt], k.left, lazy.screen.prev_group()),
		Key([k.control, k.alt], k.right, lazy.screen.next_group()),
		Key([k.control, k.alt], k.up, lazy.screen.prev_group()),
		Key([k.control, k.alt], k.down, lazy.screen.next_group()),
		Key([k.alt, k.control, k.shift], k.left, lazy.next_screen()),
		Key([k.alt, k.control, k.shift], k.right, lazy.prev_screen()),
		Key([k.mod], k.period, lazy.next_screen()),
		Key([k.mod], "minus", lazy.layout.shrink(),
			lazy.layout.decrease_nmaster(), desc=
			'Shrink window (MonadTall), decrease number in master pane (Tile)'),
		Key([k.mod], "equal", lazy.layout.grow(),
			lazy.layout.increase_nmaster(), desc=
			'Expand window (MonadTall), increase number in master pane (Tile)'),

	### Media
		Key([], "XF86AudioRaiseVolume", lazy.spawn(vol_up)),
		Key([], "XF86AudioLowerVolume", lazy.spawn(vol_down)),
		Key([], "XF86AudioMute", lazy.spawn(vol_mute)),
		Key([], "XF86AudioNext", lazy.spawn(player_next)),
		Key([], "XF86AudioPrev", lazy.spawn(player_prev)),
		Key([], "XF86AudioPlay", lazy.spawn(player_play_pause)),
		Key([], "XF86AudioStop", lazy.spawn(player_stop)),
	]
