#define SPRINT_BUFFER_SOUND_COOLDOWN 5 SECONDS

/// Sprint buffer ///
/mob/living/carbon/doSprintLossTiles(tiles)
	doSprintBufferRegen(FALSE)		//first regen.
	if(sprint_buffer && !HAS_TRAIT(src, TRAIT_ENDLESS_RUNNER))
		var/use = tiles
		if(HAS_TRAIT(src, TRAIT_ZOOMIES))
			use *= ZOOMIES_STAM_MULT
		else if(HAS_TRAIT(src, TRAIT_SUPER_ZOOMIES))
			use *= SUPER_ZOOMIES_STAM_MULT
		use = min(use, sprint_buffer)//Use the rest of our sprint buffer or the normal amount of stamina
		sprint_buffer -= use
		tiles -= use
	update_hud_sprint_bar()
	if(!tiles)		//we had enough, we're done!
		return
	/*
	var/datum/keybinding/living/toggle_sprint/sprint_bind = GLOB.keybindings_by_name["toggle_sprint"]
	var/datum/keybinding/living/hold_sprint/sprint_hold_bind = GLOB.keybindings_by_name["hold_sprint"]
	if(!client || !((client in sprint_bind.is_down) || !(client in sprint_hold_bind.is_down))) // there are two keybinds, apparently
		disable_intentional_sprint_mode()
		return // if you're not holding it, you stop sprinting when you run out
	*/
	if(tiles > sprint_buffer)//Drain from stamina only when our sprint buffer can't supply all of the needed tiles
		if(HAS_TRAIT(usr, TRAIT_ENDLESS_RUNNER))
			return // you don't stop sprinting if you have this trait
		else if(HAS_TRAIT(usr, TRAIT_ZOOMIES))
			adjustStaminaLoss((tiles * sprint_stamina_cost) * ZOOMIES_STAM_MULT)
		else if(HAS_TRAIT(usr, TRAIT_SUPER_ZOOMIES))
			adjustStaminaLoss((tiles * sprint_stamina_cost) * SUPER_ZOOMIES_STAM_MULT)
		else
			adjustStaminaLoss(tiles * sprint_stamina_cost)		//use stamina to cover deficit.

		if(usr.client?.prefs.toggles & SOUND_SPRINTBUFFER && world.time > sprint_buffer_sound_time)
			sprint_buffer_sound_time = world.time + SPRINT_BUFFER_SOUND_COOLDOWN
			SEND_SOUND(usr, sound('sound/machines/terminal_error.ogg'))

/mob/living/carbon/proc/doSprintBufferRegen(updating = TRUE)
	var/diff = world.time - sprint_buffer_regen_last
	sprint_buffer_regen_last = world.time
	sprint_buffer = min(sprint_buffer_max, sprint_buffer + sprint_buffer_regen_ds * diff)
	if(updating)
		update_hud_sprint_bar()
