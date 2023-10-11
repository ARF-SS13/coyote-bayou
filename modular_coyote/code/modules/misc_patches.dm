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


/obj/item/reagent_containers/food/drinks/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_LICKED, .proc/LapDrink)


/obj/item/reagent_containers/food/drinks/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_LICKED)

/obj/item/reagent_containers/food/drinks/proc/LapDrink(atom/A, mob/living/carbon/licker, obj/item/hand_item/tongue)
	if(!iscarbon(licker) || !tongue)
		return FALSE

	attack(licker, licker, licker.get_organ_target())


/mob/living/carbon
	var/notifiedHint = 0 // A 1 time var to make it so you get told you can heal when sleeping.
	
/mob/living/carbon/proc/NotifySleepHealing()
	if(notifiedHint)
		return
	
	to_chat(src, span_yellowteamradio("You're down, but not out! Rest up and get some sleep and you can fight back to your feet!"))
	to_chat(src, span_tinynoticeital("You can regenerate health slowly by sleeping anywhere (you generate health faster while in a bed), you'll only see this message appear once!"))

	notifiedHint = TRUE
