from enum import Enum
import sys
import json
import argparse
import os
import logging
import subprocess

logger = logging.getLogger(__name__)


class Workspace(Enum):
	ONE = 1
	TWO = 2
	THREE = 3
	FOUR = 4
	FIVE = 5
	SIX = 6
	SEVEN = 7
	EIGHT = 8
	NINE = 9

	def icon(self):
		return {
			Workspace.ONE: "",
			Workspace.TWO: "",
			Workspace.THREE: "",
			Workspace.FOUR: "󱠓",
			Workspace.FIVE: "󰒱",
			Workspace.SIX: "󰖺",
			Workspace.SEVEN: "",
			Workspace.EIGHT: "󰓇",
			Workspace.NINE: "",
		}.get(self, "Unknown")


class Output(object):

	def __init__(self, workspace: Workspace) -> None:
		self.workspace = workspace
		pass

	def to_dict(self) -> dict:
		return {"text": self.workspace.icon(), "class": f"custom-workspace-{self.workspace.value}"}


class WorkspaceManager:

	def __init__(self, workspace: Workspace, action: str) -> None:
		self.workspace = workspace
		self.action = action
		pass

	def main(self):

		if self.action == "output":
			self.output()
		elif self.action == "click":
			self.click()

		pass

	def click(self):
		pass

	def output(self):

		currentwork = self.get_current_workspace()
		activework = self.get_active_workspaces()
		logger.info(currentwork)
		logger.info(activework)

		output = Output(self.workspace).to_dict()

		sys.stdout.write(json.dumps(output) + "\n")
		sys.stdout.flush()

	def get_current_workspace(self):
		try:
			output = subprocess.check_output(['hyprctl', 'activeworkspace', "-j"], text=True)
			return output.strip()
		except subprocess.CalledProcessError as e:
			logger.warn(f"Failed to get current workspace: {e}")
			return None

	def get_active_workspaces(self):
		try:
			output = subprocess.check_output(['hyprctl', 'workspaces', "-j"], text=True)
			return output.strip()
		except subprocess.CalledProcessError as e:
			logger.warn(f"Failed to get current workspace: {e}")
			return None


def parse_arguments():
	parser = argparse.ArgumentParser()

	# Increase verbosity with every occurrence of -v
	parser.add_argument("-v", "--verbose", action="count", default=0)
	parser.add_argument("-e", "--enable-logging", action="store_true")
	parser.add_argument("-a", "--action")
	parser.add_argument("-w", "--workspace", default="1")

	return parser.parse_args()


def main():
	arguments = parse_arguments()

	# Initialize logging
	if arguments.enable_logging:
		logfile = os.path.join(os.path.dirname(os.path.realpath(__file__)), "workspace.log")
		logging.basicConfig(
			filename=logfile, level=logging.DEBUG, format="%(asctime)s %(name)s %(levelname)s:%(lineno)d %(message)s"
		)

	# Logging is set by default to WARN and higher.
	# With every occurrence of -v it's lowered by one
	logger.setLevel(max((3 - arguments.verbose) * 10, 0))

	logger.info("Creating workspace manager")
	if arguments.action:
		logger.info(f"Action: {arguments.action}")

	work = Workspace(int(arguments.workspace))
	manager = WorkspaceManager(work, arguments.action)
	manager.main()


if __name__ == "__main__":
	main()
