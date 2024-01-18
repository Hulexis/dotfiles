import os
from libqtile import bar
from libqtile import qtile

from qtile_extras import widget
from qtile_extras.widget import decorations
from qtile_extras.widget.decorations import BorderDecoration
from qtile_extras.widget.decorations import RectDecoration
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
    laptopIndexes = [5, 6, 7, 8, 9]

    colors = settings.colors
    colors2 = settings.colors2

    # if settings.isLaptop:
    #     indexes = laptopDockedIndexes

    if screen == 2:
        for index in sorted(indexes, reverse=True):
            del rightWidgets[index]

    # if settings.numberOfScreens == 1:
    #     for index in sorted(laptopIndexes, reverse=True):
    #         if 0 <= index < len(laptopIndexes):
    #             del rightWidgets[index]

    # Get the widgets for the top left side of the screen
    widgets.extend(leftWidgets)
    widgets.extend([widget.Spacer(width=bar.STRETCH)])

    # Get the widgets for the top center side of the screen
    widgets.extend(centerWidgets)
    widgets.extend([widget.Spacer(width=bar.STRETCH)])

    # Get the widgets for the top right side of the screen
    widgets.extend(rightWidgets)

    return list(widgets)


def getWidgetDecorations(color):
    return [
        RectDecoration(
            colour="#16213E",
            radius=10,
            filled=True,
            group=False,
            padding_x=4,
        ),
    ]


def getCommonOptions():
    return {"padding": 15}


def get_left_widgets():
    colors = settings.colors
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
            padding_x=6,
            borderwidth=3,
            inactive=colors2[0],
            active=colors2[8],
						other_current_screen_border=colors2[0],
						this_current_screen_border=colors2[0],
            rounded=True,
            highlight_color=colors2[1],
            highlight_method="block",
        ),
        widget.OpenWeather(
            app_key=settings.openWeaterApiKey,
            location='Stavanger,NO',
            foreground=colors[7],
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[2],
            scale=0.7,
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
        widget.GlobalMenu(
            foreground=colors[6],
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
    ]
    return list(left_widgets)


def get_center_widgets():
    colors = settings.colors

    center_widgets = [
        widget.Clock(
            foreground=colors[9],
            format="%A, %B %d - %H:%M ",
            margin_x=5,
            decorations=getWidgetDecorations(colors[9]),
            **getCommonOptions(),
        ),
    ]

    return list(center_widgets)


def get_right_widgets():
    colors = settings.colors

    right_widgets = [
        widget.Notify(
            decorations=getWidgetDecorations(colors[3]),
            **getCommonOptions(),
        ),
        widget.Systray(
            **getCommonOptions(),
        ),
        widget.ThermalSensor(
            foreground=colors[7],
            threshold=90,
            fmt='Temp: {}',
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
        widget.CheckUpdates(
            update_interval=1800,
            distro="Arch_checkupdates",
            display_format="Updates: {updates} ",
            colour_have_updates=colors[5],
            colour_no_updates=colors[7],
            mouse_callbacks={
                'Button1':
                lambda: qtile.cmd_spawn(settings.myTerm +
                                        ' -e sudo pacman -Syu')
            },
            no_update_string='No updates',
            foreground=colors[5],
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
        widget.Memory(
            mouse_callbacks={
                'Button1':
                lambda: qtile.cmd_spawn(settings.myTerm + ' -e htop')
            },
            fmt='Mem: {}',
            decorations=getWidgetDecorations(colors[6]),
            foreground=colors[6],
            **getCommonOptions(),
        ),
        modify(
            Spotify,
            foreground=colors[7],
            decorations=getWidgetDecorations(colors[7]),
            **getCommonOptions(),
        ),
        # widget.Bluetooth(
        #     hci='/dev_C8_BD_4D_F7_B1_70',
        #     foreground=colors[6],
        #     decorations=getWidgetDecorations(colors[6]),
        #     **getCommonOptions(),
        # ),
        # idget.Volume(
        #     fmt='Vol: {}',
        #     decorations=getWidgetDecorations(colors[8]),
        #     foreground=colors[8],
        #     margin=10,
        #     **getCommonOptions(),
        # ),
        widget.KeyboardLayout(
            fmt='{}',
            configured_keyboards=settings.keyBoardLayouts,
            decorations=getWidgetDecorations(colors[2]),
            foreground=colors[2],
            **getCommonOptions(),
        ),
    ]

    # if settings.isLaptop:
    #     right_widgets.extend([
    #         widget.Battery(
    #             foreground=colors[9],
    #             decorations=getWidgetDecorations(colors[9]),
    #             **getCommonOptions(),
    #         ),
    #     ])

    widgetList = []

    for rightWidget in right_widgets:
        widgetList.append(rightWidget)

    return list(widgetList)
