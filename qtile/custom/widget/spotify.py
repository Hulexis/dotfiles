# The MIT License (MIT)

# Copyright(c) 2022 Ben Hunt

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from subprocess import CompletedProcess, run
from libqtile.log_utils import logger

from libqtile.widget import base

class Spotify(base.ThreadPoolText):
	"""
	A widget to interact with spotify via dbus.
	"""
	defaults = [("play_icon", '', "icon to display when playing music"),
				("pause_icon", '', "icon to display when music paused"),
				("update_interval", 0.5, "polling rate in seconds"),
				("format", "{icon}  {artist}:{album} - {track}",
				 "Spotify display format")]

	lastWindow = "9"

	def __init__(self, **config):
		base.ThreadPoolText.__init__(self, text='', **config)
		self.add_defaults(Spotify.defaults)
		self.add_callbacks({
			'Button3': self.go_to_spotify,
			'Button1': self.toggle_music,
		})

	def _is_proc_running(self, proc_name: str) -> bool:
		# create regex pattern to search for to avoid similar named processes
		pattern = proc_name + '$'

		# pgrep will return a string of pids for matching processes
		proc_out = run(['pgrep', '-fli', pattern],
					   capture_output=True).stdout.decode("utf-8")

		# empty string means nothing started
		if proc_out == "":
			return False
		return True

	def go_to_spotify(self):
		"""
		Switch to whichever group has the current spotify instance
		if none exists then we will spawn an instance on the current group
		"""

		# spawn spotify if not already running
		if not self._is_proc_running('spotify'):
			logger.warning("Not running")
			self.qtile.spawn('spotify', shell=True)
			return

		self.qtile.groups_map["9"].cmd_toscreen()

	def poll(self) -> str:
		"""Poll content for the text box"""
		vars = {}
		if self.playing:
			vars["icon"] = self.play_icon
		else:
			vars["icon"] = self.pause_icon

		vars["artist"] = self.artist
		vars["track"] = self.song_title
		vars["album"] = self.album

		return self.format.format(**vars)

	def toggle_music(self):
		run("dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause",
			shell=True)

	def get_proc_output(self, proc: CompletedProcess) -> str:
		if proc.stderr.decode('utf-8') != "":
			return "" if "org.mpris.MediaPlayer2.spotify" in proc.stderr.decode(
				"utf-8") else proc.stderr.decode("utf-8")

		return proc.stdout.decode('utf-8').rstrip()

	@property
	def _meta(self) -> str:
		proc = run(
			"dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'",
			shell=True,
			capture_output=True)

		output: str = proc.stdout.decode('utf-8').replace("'", "ʼ").rstrip()
		return "" if ("org.mpris.MediaPlayer2.spotify" in output) else output

	@property
	def artist(self) -> str:
		proc: CompletedProcess = run(
			"dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' | grep -m1 'xesam:artist' -b2 | tail -n 1 | grep -o '\".*\"' | sed 's/\"//g' | sed -e 's/&/and/g'",
			shell=True,
			capture_output=True)

		out = self.get_proc_output(proc)
		return out

	@property
	def song_title(self) -> str:
		proc: CompletedProcess = run(
			f"echo '{self._meta}' | grep -m1 'xesam:title' -b1 | tail -n1 | grep -o '\".*\"' | sed 's/\"//g' | sed -e 's/&/and/g'",
			shell=True,
			capture_output=True)

		return self.get_proc_output(proc)

	@property
	def album(self) -> str:
		proc = run(
			f"echo '{self._meta}' | grep -m1 'xesam:album' -b1 | tail -n1 | grep -o '\".*\"' | sed 's/\"//g' | sed -e 's/&/and/g'",
			shell=True,
			capture_output=True)

		output: str = self.get_proc_output(proc)
		return output

	@property
	def playing(self) -> bool:
		play = run(
			"dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' | grep -o Playing",
			shell=True,
			capture_output=True).stdout.decode('utf-8')
		if play == "":
			return False
		return True

