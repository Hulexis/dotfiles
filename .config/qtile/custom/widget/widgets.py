from .widgets_list import get_widgets
from libqtile import bar
from libqtile.config import Screen


def init_widgets_screen1():
    widgets_screen1 = get_widgets(1)
    return widgets_screen1


def init_widgets_screen2():
    widgets_screen2 = get_widgets(2)
    return widgets_screen2  # Monitor 2 will display all widgets in widgets_list


def get_screens():
    return [
        Screen(top=bar.Bar(
            widgets=init_widgets_screen1(),
            opacity=1.0,
            size=30,
        )),
        Screen(top=bar.Bar(
            widgets=init_widgets_screen2(),
            opacity=1.0,
            size=30,
        )),
        Screen(
            top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=30))
    ]
