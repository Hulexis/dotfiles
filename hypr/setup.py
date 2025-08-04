import os
import socket
import json
import shutil


def copy_waybar_files(source_dir, target_dir, exclude_file):
	"""Copy all files from source_dir to target_dir, excluding a specific file."""
	if not os.path.exists(source_dir):
		print(f"Source directory does not exist: {source_dir}")
		return

	if not os.path.exists(target_dir):
		os.makedirs(target_dir)

	for item in os.listdir(source_dir):
		source_path = os.path.join(source_dir, item)
		target_path = os.path.join(target_dir, item)

		if os.path.isfile(source_path) and item == exclude_file:
			continue

		if os.path.isfile(source_path):
			shutil.copy2(source_path, target_path)
		elif os.path.isdir(source_path):
			if os.path.exists(target_path):
				shutil.rmtree(target_path)
			shutil.copytree(source_path, target_path)


def deep_merge(base, override):
	"""
	Recursively merge override properties into base.
	Override values fully replace base values for matching keys.
	"""
	for key, value in override.items():
		if isinstance(value, dict) and key in base and isinstance(base[key], dict):
			deep_merge(base[key], value)
		else:
			base[key] = value


def merge_configs(base_config_path, override_config_path, output_path):
	"""Merge base and override JSON configs and write the result to the output file."""
	try:
		with open(base_config_path, 'r') as base_file:
			base_config = json.load(base_file)

		if os.path.exists(override_config_path):
			with open(override_config_path, 'r') as override_file:
				override_config = json.load(override_file)
		else:
			override_config = {}

		deep_merge(base_config, override_config)

		with open(output_path, 'w') as output_file:
			json.dump(base_config, output_file, indent=4)

	except Exception as e:
		print(f"Error merging configs: {e}")


def main():
	config = os.path.expanduser("~/.config/")
	hypr = os.path.expanduser("~/.dotfiles/hypr")

	# Determine machine-specific paths
	machine = socket.gethostname()
	chypr = os.path.join(config, "hypr")
	clocal = os.path.join(config, "hypr-local.conf")
	cwaybar = os.path.join(config, "waybar")

	dmonitors = os.path.join(hypr, "machines", machine, "hypr-local.conf")
	dwaybar = os.path.join(hypr, "machines", machine, "waybar", "config.json")
	dwaybar_base = os.path.join(hypr, "waybar", "config.json")
	dwaybar_base_folder = os.path.join(hypr, "waybar")
	dwaybar_output = os.path.join(cwaybar, "config.jsonc")

	for path in [clocal, cwaybar, chypr]:
		if os.path.exists(path):
			if os.path.isfile(path) or os.path.islink(path):
				os.remove(path)
			elif os.path.isdir(path):
				shutil.rmtree(path)

	os.symlink(hypr, chypr)
	os.symlink(dmonitors, clocal)

	os.mkdir(cwaybar)

	copy_waybar_files(dwaybar_base_folder, cwaybar, "config.json")

	if os.path.exists(dwaybar):
		merge_configs(dwaybar_base, dwaybar, dwaybar_output)
	else:
		print(f"No machine-specific Waybar config found at {dwaybar}")


if __name__ == "__main__":
	main()
