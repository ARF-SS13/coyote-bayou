/client/verb/checkbgcolor()
	set name = "Check Chat BG Color"
	set desc = "Re-check chat BG color."
	set category = "OOC"

	spawn(0)
		var/color = winget(src, "statwindow", "background-color") // So, this is technically the wrong color but I don't know where the right one is.
		if(color == "none")												// If you change the chat bg color to be noticeably different from THIS color,
			color = "#ffffff"										   // this will break.
		prefs.chatbgcolor = color
		to_chat(src, "Successfully re-checked chat background color. ([color])")
