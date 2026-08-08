-- Input configuration

hl.config({
	input = {
		-- sensitivity = -0.25,
		accel_profile = "flat",
		-- Delay in milliseconds before repeat starts (default: 600)
		-- Lower value = starts repeating faster
		repeat_delay = 200,
		-- Repeats per second once triggered (default: 25)
		-- Higher value = faster repeat speed
		repeat_rate = 50,
	},
	-- Uncomment the section below to enable software cursors; this can help with cursor display or behavior issues
	-- cursor = {
	--     no_hardware_cursors = 1,
	-- },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })
