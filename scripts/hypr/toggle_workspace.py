import json
import subprocess
import sys


def toggle_workspace(target_workspace):
	ret = subprocess.getstatusoutput("hyprctl activeworkspace -j")
	if ret[0] != 0:
		exit("Failed to get active workspace")

	try:
		d = json.loads(ret[1])
	except json.JSONDecodeError:
		exit("Failed to parse JSON")

	if "id" not in d:
		exit("Failed to locate workspace id")

	if d["id"] != target_workspace:
		subprocess.getstatusoutput(f"~/.dotfiles/scripts/hypr/qtile_like_swap.sh {target_workspace}")
	else:
		subprocess.getstatusoutput("hyprctl dispatch workspace previous")


if __name__ == "__main__":
	if len(sys.argv) != 2:
		exit("Usage: python script.py <workspace_number>")

	try:
		workspace_num = int(sys.argv[1])
	except ValueError:
		exit("Invalid workspace number")

	toggle_workspace(workspace_num)
