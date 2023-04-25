//Allows a pokemon to rest in order to slowly regain health.
/datum/action/cooldown/pokemon_rest
	name = "Rest"
	desc = "Lie down and rest in order to slowly heal or just relax."
	icon_icon = 'modular_coyote/icons/mob/pokemon32.dmi'
	button_icon_state = "a_rest"
	background_icon_state = "bg_default"	
	check_flags = AB_CHECK_CONSCIOUS
	required_mobility_flags = MOBILITY_RESIST
	active = 0
	cooldown_time = 1 SECONDS

/datum/action/cooldown/pokemon_rest/Trigger()
	if(!..())
		return FALSE
	if(ispokemon(owner))
		var/mob/living/simple_animal/passive/pokemon/O = owner
		O.resting = !O.resting
		TOGGLE_BITFIELD(combat_flags, COMBAT_FLAG_INTENTIONALLY_RESTING)
		O.update_mobility()
		to_chat(O,"<span class='notice'>You are now [resting ? "resting" : "getting up"].</span>")
		return TRUE
