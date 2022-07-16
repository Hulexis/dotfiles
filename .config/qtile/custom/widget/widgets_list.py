import os
from libqtile import bar, widget
from libqtile import qtile

from ..settings import settings

from .spotify import Spotify


def get_widgets(screen):
    widgets = []

    leftWidgets = get_left_widgets()
    centerWidgets = get_center_widgets()
    rightWidgets = get_right_widgets()

    indexes = [0, 1]
    laptopIndexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    colors = settings.colors

    if settings.isLaptop:
        indexes = laptopIndexes

    if screen == 2:
        for index in sorted(indexes, reverse=True):
            del rightWidgets[index]

    # Get the widgets for the top left side of the screen
    widgets.extend(leftWidgets)
    widgets.extend([widget.Spacer(width=bar.STRETCH, background=colors[0])])

    # Get the widgets for the top center side of the screen
    widgets.extend(centerWidgets)
    widgets.extend([widget.Spacer(width=bar.STRETCH, background=colors[0])])

    # Get the widgets for the top right side of the screen
    widgets.extend(rightWidgets)

    return list(widgets)


def get_left_widgets():
    colors = settings.colors

    left_widgets = [
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[0]),
        widget.Image(filename="~/.config/qtile/icons/python-white.png",
                     scale="False",
                     mouse_callbacks={
                         'Button1': lambda: qtile.cmd_spawn(settings.myTerm)
                     }),
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[0]),
        widget.GroupBox(font="Ubuntu Bold",
                        fontsize=9,
                        margin_y=3,
                        margin_x=0,
                        padding_y=5,
                        padding_x=3,
                        borderwidth=3,
                        active=colors[2],
                        inactive=colors[7],
                        rounded=False,
                        highlight_color=colors[1],
                        highlight_method="line",
                        this_current_screen_border=colors[6],
                        this_screen_border=colors[4],
                        other_current_screen_border=colors[6],
                        other_screen_border=colors[4],
                        foreground=colors[2],
                        background=colors[0]),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[2],
            background=colors[0],
            padding=0,
            scale=0.7),
        widget.CurrentLayout(foreground=colors[2],
                             background=colors[0],
                             padding=5),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.WindowName(foreground=colors[6],
                          background=colors[0],
                          padding=0),
    ]

    return list(left_widgets)


def get_center_widgets():
    colors = settings.colors

    center_widgets = [
        widget.Clock(foreground=colors[1],
                     background=colors[9],
                     format="%A, %B %d - %H:%M ",
                     padding=10),
        widget.OpenWeather(app_key=settings.openWeaterApiKey,
                           location='Stavanger,NO',
                           foreground=colors[1],
                           background=colors[7],
                           padding=10),
    ]

    return list(center_widgets)


def get_right_widgets():
    colors = settings.colors

    right_widgets = [
        widget.Systray(background=colors[0], padding=5),
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[0],
                   background=colors[0]),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground=colors[3],
                       padding=0,
                       fontsize=45),
        widget.Net(format='Net: {down} ↓↑ {up}',
                   foreground=colors[1],
                   background=colors[3],
                   padding=5),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[3],
                       foreground=colors[4],
                       padding=0,
                       fontsize=45),
        widget.ThermalSensor(foreground=colors[1],
                             background=colors[4],
                             threshold=90,
                             fmt='Temp: {}',
                             padding=5),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[4],
                       foreground=colors[5],
                       padding=0,
                       fontsize=45),
        widget.CheckUpdates(update_interval=1800,
                            distro="Arch",
                            display_format="Updates: {updates} ",
                            foreground=colors[1],
                            colour_have_updates=colors[1],
                            colour_no_updates=colors[1],
                            mouse_callbacks={
                                'Button1':
                                lambda: qtile.cmd_spawn(settings.myTerm +
                                                        ' -e sudo pacman -Syu')
                            },
                            padding=5,
                            no_update_string='No updates',
                            background=colors[5]),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[5],
                       foreground=colors[6],
                       padding=0,
                       fontsize=45),
        widget.Memory(foreground=colors[1],
                      background=colors[6],
                      mouse_callbacks={
                          'Button1':
                          lambda: qtile.cmd_spawn(settings.myTerm + ' -e htop')
                      },
                      fmt='Mem: {}',
                      padding=5),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[6],
                       foreground=colors[7],
                       padding=0,
                       fontsize=45),
        Spotify(background=colors[7], foreground=colors[1]),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[7],
                       foreground=colors[8],
                       padding=0,
                       fontsize=45),
        widget.Volume(foreground=colors[1],
                      background=colors[8],
                      fmt='Vol: {}',
                      padding=5),
        widget.TextBox(text='',
                       font="Ubuntu Mono",
                       background=colors[8],
                       foreground=colors[2],
                       padding=0,
                       fontsize=45),
        widget.KeyboardLayout(foreground=colors[1],
                              background=colors[2],
                              fmt='{}',
                              padding=5,
                              configured_keyboards=settings.keyBoardLayouts),
    ]

    if settings.isLaptop:
        right_widgets.extend([
            widget.TextBox(text='',
                           font="Ubuntu Mono",
                           background=colors[1],
                           foreground=colors[2],
                           padding=0,
                           fontsize=45),
            widget.Battery(
                foreground=colors[7],
                background=colors[8],
            ),
        ])

    return list(right_widgets)
