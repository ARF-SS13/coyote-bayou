#define HH_STATUS_DEFAULT_DURATION (60 SECONDS)


/datum/status_effect/music
	id = "AAAHH!!!!!! MUSIC!!!!!"
	var/desc = "This is so fucking scary."
	duration = HH_STATUS_DEFAULT_DURATION
	alert_type = /atom/movable/screen/alert/status_effect/music
	status_type = STATUS_EFFECT_REFRESH
	var/associated_trait = null


/atom/movable/screen/alert/status_effect/music
	name = "Hunting Horn Music"
	desc = "You feel the music empower you!"

/datum/status_effect/music/on_creation()
	. = ..()
	linked_alert.name = id
	linked_alert.desc = desc

/datum/status_effect/music/on_apply()
	. = ..()
	if(!isnull(associated_trait))
		ADD_TRAIT(owner, associated_trait, id)

/datum/status_effect/music/on_remove()
	. = ..()
	if(!isnull(associated_trait))
		REMOVE_TRAIT(owner, associated_trait, src)


// OFFENSE //

/datum/status_effect/music/attack_up_xs
	id = "\proper Strength"
	desc = "You feel empowered."
	var/had_little_leagues = FALSE

/datum/status_effect/music/attack_up_xs/on_apply()
	. = ..()
	if(HAS_TRAIT(owner, TRAIT_LITTLE_LEAGUES))
		had_little_leagues = TRUE
		REMOVE_TRAIT(owner, TRAIT_LITTLE_LEAGUES, src)
		ADD_TRAIT(owner, TRAIT_BIG_LEAGUES, "Melee - Big Leagues")
		return
	ADD_TRAIT(owner, TRAIT_LITTLE_LEAGUES, "Melee - Little Leagues")

/datum/status_effect/music/attack_up_xs/on_remove()
	. = ..()
	if(had_little_leagues)
		REMOVE_TRAIT(owner, TRAIT_BIG_LEAGUES, src)
		ADD_TRAIT(owner, TRAIT_LITTLE_LEAGUES, "Melee - Little Leagues")
		return
	REMOVE_TRAIT(owner, TRAIT_LITTLE_LEAGUES, src)


/datum/status_effect/music/speed_up
	id = "\proper Agility"
	desc = "You feel light on your feet."

/datum/status_effect/music/speed_up/on_apply()
	. = ..()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/huntinghorn, TRUE, "huntinghornspeed")

/datum/status_effect/music/speed_up/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("huntinghornspeed", update = TRUE)

/datum/movespeed_modifier/huntinghorn
	flags = IGNORE_NOSLOW
	variable = TRUE
	multiplicative_slowdown = -0.1

// check click.dm inside /mob/ClickOn()
/datum/status_effect/music/cooldown_ignore
	id = "\proper Ruthlessness"
	desc = "You feel like really pummelling something."
	associated_trait = TRAIT_HH_COOLDOWN_IGNORE




// DEFENSE //

/datum/status_effect/music/iron_skin
	id = "\proper Endurance"
	desc = "You feel tough."
	associated_trait = TRAIT_HH_IRON_SKIN

/datum/status_effect/music/knockdown_res
	id = "\proper Steadiness"
	desc = "You feel sturdy."
	associated_trait = TRAIT_HH_KNOCKDOWN_RES

/datum/status_effect/music/divine_blessing
	id = "\proper Luck"
	desc = "You feel like you could shrug off some pain."
	associated_trait = TRAIT_HH_DIVINE_BLESSING


// UTILITY //

/datum/status_effect/music/draw_speed
	id = "\proper Alertness"
	desc = "You feel like the fastest gun in the west."
	associated_trait = TRAIT_HH_DRAW_SPEED

/datum/status_effect/music/fast_actions
	id = "\proper Dexterity"
	desc = "You feel like a magician."

/datum/status_effect/music/fast_actions/interact_speed_modifier()
	return 0.8


/datum/status_effect/music/stamina_up
	id = "\proper Persistence"
	desc = "You feel like you could do this all day."

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
	id = "\proper Health"
	desc = "YIPPEE!"
	duration = 1

/datum/status_effect/music/instaheal/on_apply()
	. = ..()
	owner.heal_ordered_damage(20, list(BRUTE, BURN, TOX, OXY))


/datum/status_effect/music/recovery
	id = "\proper Tenacity"
	desc = "You feel soothed."

/datum/status_effect/music/recovery/tick()
	owner.heal_overall_damage(brute = 2, burn = 2, only_organic = FALSE)


/datum/status_effect/music/maxhp_up
	id = "\proper Vigor"
	desc = "You feel hearty."

/datum/status_effect/music/maxhp_up/on_apply()
	. = ..()
	owner.maxHealth += 10

/datum/status_effect/music/maxhp_up/on_remove()
	. = ..()
	owner.maxHealth -= 10
