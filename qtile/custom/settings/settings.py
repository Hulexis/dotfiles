import socket
import os

from Xlib import display
from Xlib.ext import randr

from libqtile.log_utils import logger
from .icons import Icons
from .keys import Keys

laptopNames = ["arne-work", "aj-work", "aj-arch-work"]
usKeyboardPc = ["arne-work", "aj-work-station", "aj-home-pc"]

color_primary_fg = "#dfdfdf"
color_secondary_fg = "#1c1f24"

color_primary_bg = "#16213E"


def settingsInit():
	global myTerm
	global colors
	global colors2
	global isLaptop
	global keyBoardLayouts
	global openWeaterApiKey
	global numberOfScreens
	global icons
	global keys

	myTerm = "alacritty"  # My terminal of choice
	colors = [
		["#16213E", "#0F3460"], ["#1c1f24", "#1c1f24"], ["#dfdfdf", "#dfdfdf"], ["#507DBC", "#507DBC"], ["#98be65", "#98be65"],
		["#E94560", "#E94560"], ["#51afef", "#51afef"], ["#c678dd", "#c678dd"], ["#46d9ff", "#46d9ff"], ["#a9a1e1", "#a9a1e1"]
	]

	colors2 = [
		["#292d3e", "#292d3e"],  # color 0
		["#A8A8A8", "#A8A8A8"],  # color 1
		["#f99db3", "#f99db3"],  # color 2
		["#B9BCDF", "#B9BCDF"],  # color 3
		["#F98DA6", "#F98DA6"],  # color 4
		["#ffffff", "#ffffff"],  # color 5
		["#C7CAEF", "#C7CAEF"],  # color 6
		["#F9A9BC", "#F9A9BC"],  # color 7
		["#b79feb", "#b79feb"],  # color 8
		["#bbebca", "#bbebca"],  # color 9
		["#DCDEFC"]
	]  # color 10

	isLaptop = getIsLaptop()
	keyBoardLayouts = getKeyboardLayouts()
	openWeaterApiKey = os.getenv('OPEN_WEATHER_API_KEY', default=None)
	numberOfScreens = len(get_display_info())
	icons = Icons()
	keys = Keys()


def hostnameInList(list: list[str]):
	name = socket.gethostname()

	for item in list:
		if item in name:
			return bool(True)

	return bool(False)


def getIsLaptop():
	return hostnameInList(laptopNames)


def useUsKeyboardAsDefault():
	return hostnameInList(usKeyboardPc)


def getKeyboardLayouts():
	layouts = ["no", "us"]

	if useUsKeyboardAsDefault():
		layouts.sort(reverse=True)

	return layouts


def find_mode(id, modes):
	for mode in modes:
		if id == mode.id:
			return "{}x{}".format(mode.width, mode.height)


def get_display_info():
	d = display.Display(':0')
	screen_count = d.screen_count()
	default_screen = d.get_default_screen()
	result = []
	screen = 0
	info = d.screen(screen)
	window = info.root

	res = randr.get_screen_resources(window)
	for output in res.outputs:
		params = d.xrandr_get_output_info(output, res.config_timestamp)
		if not params.crtc:
			continue
		crtc = d.xrandr_get_crtc_info(params.crtc, res.config_timestamp)
		modes = set()
		for mode in params.modes:
			modes.add(find_mode(mode, res.modes))
		result.append({'name': params.name, 'resolution': "{}x{}".format(crtc.width, crtc.height), 'available_resolutions': list(modes)})

	return result
