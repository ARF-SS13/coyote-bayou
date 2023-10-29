//Allows a pokemon to rest in order to slowly regain health.
/datum/action/cooldown/pokemon_rest
	name = "Rest"
	desc = "Lie down and rest."
//	desc = "Lie down and rest in order to slowly heal or just relax." Swap this in when the healing works.
	icon_icon = 'modular_coyote/icons/mob/pokemon32.dmi'
	button_icon_state = "a_rest"
	check_flags = AB_CHECK_CONSCIOUS
	required_mobility_flags = MOBILITY_RESIST
	cooldown_time = 2 SECONDS

/datum/action/cooldown/pokemon_rest/Trigger()
	if(!..())
		return FALSE
	if(isadvancedmob(owner))
		var/mob/living/simple_animal/advanced/O = owner
		O.lay_down()
		O.update_mobility()
		return TRUE
	else
		to_chat(owner,span_notice("You shouldn't have this!"))
		return FALSE
