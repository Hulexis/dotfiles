import os

import socket

machine = socket.gethostname()

config = os.path.expanduser("~/.config/")
hypr = os.path.expanduser("~/.dotfiles/hypr")

chypr = os.path.join(config, "hypr")
clocal = os.path.join(config, "hypr-local.conf")
cwaybar = os.path.join(config, "waybar")

if os.path.exists(clocal):
	os.remove(clocal)
if os.path.exists(cwaybar):
	os.remove(cwaybar)
if os.path.exists(chypr):
	os.remove(chypr)

dmonitors = os.path.join(hypr, "machines", machine, "hypr-local.conf")
dwaybar = os.path.join(hypr, "machines", machine, "waybar")

os.system(f"ln -s {hypr} {chypr}")
os.system(f"ln -s {dmonitors} {clocal}")
os.system(f"ln -s {dwaybar} {cwaybar}")
