supermenu = {
	{ "Chromium", "chromium" },
	{ "XFCE4 screenshoter", "xfce4-screenshooter" },
	{ "VLC", "vlc" },
	{ "Arduino", "arduino" },
	{ "Shutdown", {
		{ "No ", "" },
		{ "Suspend", "systemctl suspend -i" },
		{ "Reboot", "sudo shutdown -r now" },
		{ "Yes", "sudo shutdown -h now" }
		}
	}
}

return supermenu
