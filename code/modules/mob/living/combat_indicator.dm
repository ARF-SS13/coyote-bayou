/mob/living
	var/enabled_combat_indicator = FALSE
	var/nextcombatpopup = 0
	var/static/mutable_appearance/combat_indicator

/obj/effect/overlay/combat_indicator
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	icon = 'icons/mob/talk.dmi'
	icon_state = "combat"
	appearance_flags = RESET_COLOR | TILE_BOUND | PIXEL_SCALE
	layer = FLY_LAYER



/mob/living/proc/set_combat_indicator(state)
	if(enabled_combat_indicator == state)
		return

	if(!combat_indicator)
		//visible_message("loading combat indictaor")
		combat_indicator = mutable_appearance('icons/mob/talk.dmi', "combat", FLY_LAYER)
	//	combat_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART

	if(state && stat != DEAD)
		add_overlay(combat_indicator)
	//	visible_message("enabling")
		enabled_combat_indicator = TRUE
	else
		//visible_message("disabling")
		cut_overlay(combat_indicator)
		enabled_combat_indicator = FALSE

/mob/living/proc/change_combat_indicator(state)
	if(state && world.time >= combatmessagecooldown) //If combat mode didn't make a message
		combatmessagecooldown = world.time + 10 SECONDS
		nextcombatpopup = world.time + 10 SECONDS
		playsound(src, 'sound/machines/chime.ogg', 10)
		//flick_overlay(src, "combat", 20)
		visible_message("<span class='warning'>[src] gets ready for combat!</span>")
	set_combat_indicator(state)

/mob/living/proc/disable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	set_combat_indicator(FALSE)
	change_combat_indicator(FALSE)

/mob/living/proc/enable_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	set_combat_indicator(TRUE)
	change_combat_indicator(TRUE)

/mob/living/proc/toggle_combat_mode(silent = TRUE, was_forced = FALSE, visible = FALSE, update_icon = TRUE)
	if (!enabled_combat_indicator)
		//set_combat_indicator(TRUE)
		log_attack("[src] has toggled on the combat indicator")
		log_message("has turned the combat indicator ON.", LOG_ATTACK)
		change_combat_indicator(TRUE)
	else
		//set_combat_indicator(FALSE)
		log_attack("[src] has toggled off the combat indicator")
		log_message("has turned the combat indicator OFF.", LOG_ATTACK)
		change_combat_indicator(FALSE)
