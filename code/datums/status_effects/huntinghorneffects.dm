#define HH_STATUS_DEFAULT_DURATION (60 SECONDS)


/datum/status_effect/music
	id = "AAAHH!!!!!! MUSIC!!!!!"
	duration = HH_STATUS_DEFAULT_DURATION
	alert_type = /atom/movable/screen/alert/status_effect



// OFFENSE //

/datum/status_effect/music/attack_up_xs
	id = "Strength"
	var/had_little_leagues = FALSE

/datum/status_effect/music/attack_up_xs/on_apply()
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_LITTLE_LEAGUES))
		had_little_leagues = TRUE
		REMOVE_TRAIT(owner, TRAIT_LITTLE_LEAGUES)
		ADD_TRAIT(owner, TRAIT_BIG_LEAGUES, "Melee - Big Leagues")
		return
	ADD_TRAIT(owner, TRAIT_LITTLE_LEAGUES, "Melee - Little Leagues")

/datum/status_effect/music/attack_up_xs/on_remove()
	. = ..()
	if(had_little_leagues)
		REMOVE_TRAIT(owner, TRAIT_BIG_LEAGUES)
		ADD_TRAIT(owner, TRAIT_LITTLE_LEAGUES, "Melee - Little Leagues")
		return
	REMOVE_TRAIT(owner, TRAIT_LITTLE_LEAGUES)


/datum/status_effect/music/speed_up
	id = "Agility"

/datum/status_effect/music/speed_up/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/huntinghorn, update = TRUE, cool_id = "huntinghornspeed")

/datum/status_effect/music/speed_up/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("huntinghornspeed", update = TRUE)

/datum/movespeed_modifier/huntinghorn
	flags = IGNORE_NOSLOW
	variable = TRUE
	multiplicative_slowdown = -0.1


/datum/status_effect/music/cooldown_ignore
	id = "Ruthlessness"



// DEFENSE //

/datum/status_effect/music/iron_skin
	id = "Endurance"


/datum/status_effect/music/knockdown_res
	id = "Steadiness"


/datum/status_effect/music/divine_blessing
	id = "Luck"



// UTILITY //

/datum/status_effect/music/draw_speed
	id = "Alertness"


/datum/status_effect/music/fast_actions
	id = "Dexterity"


/datum/status_effect/music/stamina_up
	id = "Persistence"

/datum/status_effect/music/stamina_up/on_apply()
	. = ..()
	owner.sprint_buffer_max += 20
	owner.sprint_buffer_regen_ds += 0.05

/datum/status_effect/music/stamina_up/on_remove()
	. = ..()
	owner.sprint_buffer_max -= 20
	owner.sprint_buffer_regen_ds -= 0.05



// HEALING //

/datum/status_effect/music/instaheal
	id = "Health"

/datum/status_effect/music/instaheal/on_apply()
	. = ..()
	owner.health += 10
	owner.remove_status_effect(src)


/datum/status_effect/music/recovery
	id = "Tenacity"

/datum/status_effect/music/recovery/tick()
	. = ..()
	owner.heal_overall_damage(brute = 1, burn = 1, only_organic = FALSE, bleed = 1, include_roboparts = FALSE)


/datum/status_effect/music/maxhp_up
	id = "Vigor"

/datum/status_effect/music/maxhp_up/on_apply()
	. = ..()
	owner.maxHealth += 10

/datum/status_effect/music/maxhp_up/on_remove()
	. = ..()
	owner.maxHealth -= 10
