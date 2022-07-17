import socket
import os

laptopNames = ["arne-work"]
usKeyboardPc = ["arne-work"]


def settingsInit():
    global myTerm
    global colors
    global isLaptop
    global keyBoardLayouts
    global openWeaterApiKey

    myTerm = "alacritty"  # My terminal of choice
    colors = [["#04080F", "#282c34"], ["#1c1f24", "#1c1f24"],
              ["#dfdfdf", "#dfdfdf"], ["#507DBC", "#507DBC"],
              ["#98be65", "#98be65"], ["#da8548", "#da8548"],
              ["#51afef", "#51afef"], ["#c678dd", "#c678dd"],
              ["#46d9ff", "#46d9ff"], ["#a9a1e1", "#a9a1e1"]]
    isLaptop = getIsLaptop()
    keyBoardLayouts = getKeyboardLayouts()
    openWeaterApiKey = os.getenv('OPEN_WEATHER_API_KEY', default=None)


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
