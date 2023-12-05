/client/verb/checkbgcolor()
	set name = "Check Chat BG Color"
	set desc = "Re-check chat BG color."
	set category = "OOC"

	spawn(0)
		var/color = winget(src, "statwindow", "background-color")
		if(color == "none")
			color = "#ffffff"
		prefs.chatbgcolor = color
		to_chat(src, "Successfully re-checked chat background color. ([color])")
