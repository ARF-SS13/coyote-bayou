/mob/living/Login()
	. = ..()
	HandlePopupMenu()

/mob/living/proc/HandlePopupMenu()
	if(!client)
		return
	
	if(enabled_combat_indicator)
		client.show_popup_menus = FALSE
	else
		client.show_popup_menus = TRUE
