import os
from libqtile import bar
from libqtile import qtile

from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from qtile_extras.widget import modify

from ..settings import settings

from .spotify import Spotify

color_primary_fg = settings.color_primary_fg
color_secondary_fg = settings.color_secondary_fg

color_primary_bg = settings.color_primary_bg


def get_widgets(screen):
	widgets = []

	is_primary = screen == 1

	leftWidgets = get_left_widgets()
	centerWidgets = get_center_widgets(is_primary)
	rightWidgets = get_right_widgets(is_primary)

	leftIndexes = []
	centerIndexes = [0, 1, 2]

	# if screen != 3:
	# 	for index in sorted(centerIndexes, reverse=True):
	# 		del centerWidgets[index]

	# if screen != 1:
	# rightWidgets = centerWidgets
	# centerWidgets = []

	# for index in sorted(leftIndexes, reverse=True):
	# 	del leftWidgets[index]

	# Get the widgets for the top left side of the screen
	widgets.extend(leftWidgets)
	widgets.extend([widget.Spacer(width=bar.STRETCH)])

	# Get the widgets for the top center side of the screen
	widgets.extend(centerWidgets)
	widgets.extend([widget.Spacer(width=bar.STRETCH)])

	# Get the widgets for the top right side of the screen
	widgets.extend(rightWidgets)

	return list(widgets)


def getWidgetDecorations():
	return [
		RectDecoration(
			colour=color_primary_bg,
			radius=10,
			filled=True,
			group=False,
			padding_x=4,
		),
	]


def getCommonOptions():
	return {"padding": 15}


def get_left_widgets():
	colors2 = settings.colors2

	xx = 14
	xf = "space mono for powerline bold"

	left_widgets = [
		widget.GroupBox(
			font=xf,
			fontsize=xx,
			margin_y=3,
			margin_x=5,
			padding_y=5,
			padding_x=7,
			borderwidth=3,
			inactive=colors2[0],
			active=colors2[5],
			center_aligned=True,
			this_screen_border="#1F4068",
			other_screen_border="#264653",
			other_current_screen_border="#5AA0D9",
			this_current_screen_border="#3E92CC",
			rounded=True,
			highlight_color=colors2[1],
			highlight_method="block",
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
		widget.StatusNotifier(
			foreground=color_primary_fg,
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
		widget.CurrentLayoutIcon(
			custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
			foreground=color_secondary_fg,
			scale=0.7,
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
		widget.GlobalMenu(
			foreground=color_primary_fg,
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
	]
	return list(left_widgets)


def get_center_widgets(is_primary=False):
	indexes = [0]
	if is_primary:
		indexes = []

	widgets = [
		widget.Clock(
			foreground=color_primary_fg,
			format="%A, %B %d - %H:%M ",
			margin_x=5,
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
	]

	for index in sorted(indexes, reverse=True):
		del widgets[index]

	return list(widgets)


def get_right_widgets(is_primary=False):
	colors = settings.colors
	indexes = [0, 1]
	if is_primary:
		indexes = []

	widgets = [
		widget.Systray(
			**getCommonOptions(),
		),
		widget.CheckUpdates(
			update_interval=1800,
			distro="Arch_checkupdates",
			display_format="Updates: {updates} ",
			colour_have_updates=colors[5],
			colour_no_updates=colors[7],
			mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(settings.myTerm + ' -e sudo pacman -Syu')},
			no_update_string='No updates',
			foreground=color_primary_fg,
			decorations=getWidgetDecorations(),
			**getCommonOptions(),
		),
		widget.Memory(
			mouse_callbacks={'Button1': lambda: qtile.cmd_spawn(settings.myTerm + ' -e htop')},
			fmt='Mem: {}',
			decorations=getWidgetDecorations(),
			foreground=color_primary_fg,
			**getCommonOptions(),
		),
		modify(
			Spotify,
			foreground=color_primary_fg,
			decorations=getWidgetDecorations(),
			initialise=True,
			**getCommonOptions(),
			max_chars=30
		),
		widget.Volume(
			decorations=getWidgetDecorations(),
			foreground=color_primary_fg,
			**getCommonOptions(),
		),
		widget.KeyboardLayout(
			fmt='{}',
			configured_keyboards=settings.keyBoardLayouts,
			decorations=getWidgetDecorations(),
			foreground=color_primary_fg,
			**getCommonOptions(),
		),
	]

	for index in sorted(indexes, reverse=True):
		del widgets[index]

	return list(widgets)
