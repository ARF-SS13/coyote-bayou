/mob/living/silicon/pai/update_icon()
	if(chassis == "custom")			//Make sure custom exists if it's set to custom
		custom_holoform_icon = client?.prefs?.get_filtered_holoform(HOLOFORM_FILTER_PAI)
		if(!custom_holoform_icon)
			chassis = pick(possible_chassis - "custom")
	else if(chassis == "custom")
		icon = custom_holoform_icon
		icon_state = ""
		rotate_on_lying = TRUE
	else
		icon = initial(icon)
		icon_state = "[chassis][resting? "_rest" : (stat == DEAD? "_dead" : "")]"
		rotate_on_lying = FALSE
	pixel_x = 0
	update_transform()
