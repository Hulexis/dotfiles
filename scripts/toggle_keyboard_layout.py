#!/bin/python3

import os
import subprocess


def change_to_norwegian():
	os.system("setxkbmap no,us")


def change_to_us():
	os.system("setxkbmap us,no")


ret = subprocess.check_output("setxkbmap -query |grep layout",
								stderr=subprocess.STDOUT, shell=True)
ret = ret.decode("utf-8")
index = ret.find(":") + 1
ret = ret[index:len(ret) - 1].strip()

layout = ret.split(",")[0]

if layout == "no":
	change_to_us()
elif layout == "us":
	change_to_norwegian()
