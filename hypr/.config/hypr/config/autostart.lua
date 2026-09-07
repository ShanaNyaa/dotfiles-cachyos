-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function()
	-- hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("xhost +SI:localuser:root")
end)

local noctCall = "noctalia msg "

hl.on("window.open", function(window)
	if window.class == "com.obsproject.Studio" then
		-- OBS starts its WebSocket server shortly after its first window appears.
		hl.exec_cmd(
			"sleep 1 && obs-cmd replay start && "
				.. noctCall
				.. 'notification-show \'{"app_name":"Noctalia","summary":"Replay buffer started","body":"OBS replay buffer started","urgency":"low","timeout_ms":4000,"icon":"circle-check"}\''
		)
	end
end)
