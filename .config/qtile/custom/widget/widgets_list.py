import os
from libqtile import bar
from libqtile import qtile

from qtile_extras import widget
from qtile_extras.widget import decorations
from qtile_extras.widget.decorations import BorderDecoration
from qtile_extras.widget import modify

from ..settings import settings

from .spotify import Spotify


def get_widgets(screen):
    widgets = []

    leftWidgets = get_left_widgets()
    centerWidgets = get_center_widgets()
    rightWidgets = get_right_widgets()

    indexes = [0, 1]
    laptopDockedIndexes = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    laptopIndexes = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    colors = settings.colors

    if settings.isLaptop:
        indexes = laptopDockedIndexes

    if screen == 2:
        for index in sorted(indexes, reverse=True):
            del rightWidgets[index]

    if settings.numberOfScreens == 1:
        for index in sorted(laptopIndexes, reverse=True):
            if 0 <= index < len(laptopIndexes):
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


def getWidgetDecorations(color):
    return [BorderDecoration(colour=color[0], border_width=[0, 0, 2, 0])]


def get_left_widgets():
    colors = settings.colors

    left_widgets = [
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[0]),
        widget.Image(filename="~/.config/qtile/icons/python-white.png",
                     scale="False",
                     foreground=colors[2],
                     background=colors[0],
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

    # test = bar.Bar(widgets=left_widgets, size=20)

    return list(left_widgets)


def get_center_widgets():
    colors = settings.colors

    center_widgets = [
        widget.Clock(foreground=colors[9],
                     background=colors[0],
                     format="%A, %B %d - %H:%M ",
                     padding=10,
                     margin_x=5,
                     decorations=getWidgetDecorations(colors[9])),
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground=colors[3],
                       padding=0,
                       fontsize=20),
        widget.OpenWeather(app_key=settings.openWeaterApiKey,
                           location='Stavanger,NO',
                           foreground=colors[7],
                           background=colors[0],
                           padding=10,
                           decorations=getWidgetDecorations(colors[7])),
    ]

    return list(center_widgets)


def get_right_widgets():
    colors = settings.colors

    right_widgets = [
        widget.Systray(background=colors[0], padding=5),
        widget.Net(format='Net: {down} ↓↑ {up}',
                   foreground=colors[3],
                   background=colors[0],
                   padding=5,
                   decorations=getWidgetDecorations(colors[3])),
        widget.ThermalSensor(foreground=colors[4],
                             background=colors[0],
                             threshold=90,
                             fmt='Temp: {}',
                             padding=5,
                             decorations=getWidgetDecorations(colors[4])),
        widget.CheckUpdates(update_interval=1800,
                            distro="Arch_checkupdates",
                            display_format="Updates: {updates} ",
                            colour_have_updates=colors[5],
                            colour_no_updates=colors[5],
                            mouse_callbacks={
                                'Button1':
                                lambda: qtile.cmd_spawn(settings.myTerm +
                                                        ' -e sudo pacman -Syu')
                            },
                            padding=5,
                            no_update_string='No updates',
                            foreground=colors[5],
                            background=colors[0],
                            decorations=getWidgetDecorations(colors[5])),
        widget.Memory(
            mouse_callbacks={
                'Button1':
                lambda: qtile.cmd_spawn(settings.myTerm + ' -e htop')
            },
            fmt='Mem: {}',
            padding=5,
            decorations=getWidgetDecorations(colors[6]),
            foreground=colors[6],
            background=colors[0],
        ),
        modify(
            Spotify,
            background=colors[0],
            foreground=colors[7],
            decorations=getWidgetDecorations(colors[7]),
        ),
        widget.Bluetooth(
            hci='/dev_C8_BD_4D_F7_B1_70',
            foreground=colors[6],
            background=colors[0],
            decorations=getWidgetDecorations(colors[6]),
            ),
        widget.Volume(
            fmt='Vol: {}',
            padding=5,
            decorations=getWidgetDecorations(colors[8]),
            foreground=colors[8],
            background=colors[0],
        ),
        widget.KeyboardLayout(
            fmt='{}',
            padding=5,
            configured_keyboards=settings.keyBoardLayouts,
            decorations=getWidgetDecorations(colors[2]),
            foreground=colors[2],
            background=colors[0],
        ),
    ]

    if settings.isLaptop:
        right_widgets.extend([
            widget.Battery(
                foreground=colors[9],
                background=colors[0],
                decorations=getWidgetDecorations(colors[9]),
            ),
        ])

    widgetList = []

    for rightWidget in right_widgets:
        widgetList.append(
            widget.TextBox(text=' ',
                           font="Ubuntu Mono",
                           background=colors[0],
                           foreground=colors[3],
                           padding=0,
                           fontsize=20))
        widgetList.append(rightWidget)

    widgetList.append(
        widget.TextBox(text=' ',
                       font="Ubuntu Mono",
                       background=colors[0],
                       foreground=colors[3],
                       padding=0,
                       fontsize=20))

    return list(widgetList)
