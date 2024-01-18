# -*- coding: utf-8 -*-
import os
import socket
import subprocess
from os import path
from libqtile.config import Click, Drag, Group, Match
from libqtile.command import lazy
from libqtile import layout, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List    # noqa: F401from typing import List  # noqa: F401

from libqtile.utils import guess_terminal

from custom.settings import settings
from custom.settings.path import qtile_path
# from custom.settings.path import qtile_path

from custom.widget.widgets import get_screens
from custom.keymaps.keys import getKeys

settings.settingsInit()

mod = "mod4"
terminal = guess_terminal()

mod = "mod4"    # Sets mod key to SUPER/WINDOWS
myTerm = "kitty"    # My terminal of choice
myBrowser = "chromium"    # My browser of choice

keys = getKeys()


def getLayout():
	if settings.isLaptop:
		return 'max'
	return 'monadtall'


groups = [
	Group("1", label="", layout='monadtall'),
	Group("2", label="", layout='monadtall'),
	Group("3", label="", layout='monadtall'),
	Group("4", label="󱠓", layout='monadtall'),
	Group("5", label="", layout='monadtall'),
	Group("6", label="󰒱", layout='max', spawn=['slack', 'discord']),
	Group("7", label="󰖺", layout='monadtall'),
	Group("8", label="", layout=getLayout(), spawn=['obsidian']),
	Group("9", label="󰓇", layout='monadtall',
			spawn=['spotify', 'spotify-launcher']),
	Group("0", label="", layout='monadtall')
]

# Allow MODKEY+[0 through 9] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MOD4 + index Number : Switch to Group[index]
# MOD4 + shift + index Number : Send active window to another Group
from libqtile.dgroups import simple_key_binder

dgroups_key_binder = simple_key_binder("mod4")

layout_theme = {
	"border_width": 2,
	"margin": 8,
	"border_focus": "e1acff",
	"border_normal": "1D2330"
}

layouts = [
	# layout.MonadWide(**layout_theme),
	# layout.Bsp(**layout_theme),
	# layout.Stack(stacks=2, **layout_theme),
	# layout.Columns(**layout_theme),
	# layout.RatioTile(**layout_theme),
	# layout.Tile(shift_windows=True, **layout_theme),
	# layout.VerticalTile(**layout_theme),
	# layout.Matrix(**layout_theme),
	# layout.Zoomy(**layout_theme),
	layout.MonadTall(**layout_theme),
	layout.Max(**layout_theme),
	# layout.Stack(num_stacks=2),
	layout.RatioTile(**layout_theme),
	layout.Tile(**layout_theme),
	# layout.TreeTab(font="Ubuntu",
	#                fontsize=10,
	#                sections=["FIRST", "SECOND", "THIRD", "FOURTH"],
	#                section_fontsize=10,
	#                border_width=2,
	#                bg_color="1c1f24",
	#                active_bg="c678dd",
	#                active_fg="000000",
	#                inactive_bg="a9a1e1",
	#                inactive_fg="1c1f24",
	#                padding_left=0,
	#                padding_x=0,
	#                padding_y=5,
	#                section_top=10,
	#                section_bottom=20,
	#                level_shift=8,
	#                vspace=3,
	#                panel_width=200),
	layout.Floating(**layout_theme)
]

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

if __name__ in ["config", "__main__"]:
	screens = get_screens()


def window_to_prev_group(qtile):
	if qtile.currentWindow is not None:
		i = qtile.groups.index(qtile.currentGroup)
		qtile.currentWindow.togroup(qtile.groups[i - 1].name)


def window_to_next_group(qtile):
	if qtile.currentWindow is not None:
		i = qtile.groups.index(qtile.currentGroup)
		qtile.currentWindow.togroup(qtile.groups[i + 1].name)


def window_to_previous_screen(qtile):
	i = qtile.screens.index(qtile.current_screen)
	if i != 0:
		group = qtile.screens[i - 1].group.name
		qtile.current_window.togroup(group)


def window_to_next_screen(qtile):
	i = qtile.screens.index(qtile.current_screen)
	if i + 1 != len(qtile.screens):
		group = qtile.screens[i + 1].group.name
		qtile.current_window.togroup(group)


def switch_screens(qtile):
	i = qtile.screens.index(qtile.current_screen)
	group = qtile.screens[i - 1].group
	qtile.current_screen.set_group(group)


mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(),
			start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(),
			start=lazy.window.get_size()),
	Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []    # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
	# Run the utility of `xprop` to see the wm class and name of an X client.
	# default_float_rules include: utility, notification, toolbar, splash, dialog,
	# file_progress, confirm, download and error.
	*layout.Floating.default_float_rules,
	Match(title='Confirmation'),    # tastyworks exit box
	Match(title='Qalculate!'),    # qalculate-gtk
	Match(wm_class='kdenlive'),    # kdenlive
	Match(wm_class='pinentry-gtk-2'),    # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def start_once():
	subprocess.call([path.join(qtile_path, "autostart.sh")])


last_client = None


@hook.subscribe.client_focus
def win_focus(current_client):
	last_client = current_client


@hook.subscribe.startup
def dbus_register():
	id = os.environ.get('DESKTOP_AUTOSTART_ID')
	if not id:
		return
	subprocess.Popen([
		'dbus-send', '--session', '--print-reply',
		'--dest=org.gnome.SessionManager', '/org/gnome/SessionManager',
		'org.gnome.SessionManager.RegisterClient', 'string:qtile',
		'string:' + id
	])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
