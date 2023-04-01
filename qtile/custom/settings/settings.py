import socket
import os

from Xlib import display
from Xlib.ext import randr

from libqtile.log_utils import logger

laptopNames = ["arne-work", "aj-work"]
usKeyboardPc = ["arne-work"]


def settingsInit():
    global myTerm
    global colors
    global isLaptop
    global keyBoardLayouts
    global openWeaterApiKey
    global numberOfScreens

    myTerm = "alacritty"  # My terminal of choice
    colors = [["#16213E", "#0F3460"], ["#1c1f24", "#1c1f24"],
              ["#dfdfdf", "#dfdfdf"], ["#507DBC", "#507DBC"],
              ["#98be65", "#98be65"], ["#E94560", "#E94560"],
              ["#51afef", "#51afef"], ["#c678dd", "#c678dd"],
              ["#46d9ff", "#46d9ff"], ["#a9a1e1", "#a9a1e1"]]
    isLaptop = getIsLaptop()
    keyBoardLayouts = getKeyboardLayouts()
    openWeaterApiKey = os.getenv('OPEN_WEATHER_API_KEY', default=None)
    numberOfScreens = len(get_display_info())


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
        result.append({
            'name': params.name,
            'resolution': "{}x{}".format(crtc.width, crtc.height),
            'available_resolutions': list(modes)
        })

    return result