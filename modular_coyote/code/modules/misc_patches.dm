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
