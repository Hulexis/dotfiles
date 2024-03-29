from .widgets_list import get_widgets
from libqtile import bar
from libqtile.config import Screen


def init_widgets_screen1():
	return get_widgets(1)


def init_widgets_screen2():
	return get_widgets(2)


def init_widgets_screen3():
	return get_widgets(3)


def get_screens():
	return [
		Screen(top=bar.Bar(
			widgets=init_widgets_screen1(),
			opacity=1.0,
			size=30,
			margin=5,
			background="#00000000",
		)),
		Screen(top=bar.Bar(
			widgets=init_widgets_screen2(),
			opacity=1.0,
			size=30,
			margin=5,
			background="#00000000",
		)),
		Screen(
			top=bar.Bar(
				widgets=init_widgets_screen3(),
				opacity=1.0,
				size=30,
				margin=5,
				background="#00000000",
			),),
	]
