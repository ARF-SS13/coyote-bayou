#define HH_STATUS_DEFAULT_DURATION (60 SECONDS)


/datum/status_effect/music
	id = "AAAHH!!!!!! MUSIC!!!!!"
	duration = HH_STATUS_DEFAULT_DURATION
	alert_type = /atom/movable/screen/alert/status_effect

// OFFENSE //

/datum/status_effect/music/attack_up_xs
	id = "Strength"

/datum/status_effect/music/speed_up
	id = "Agility"

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

// HEALING //

/datum/status_effect/music/instaheal
	id = "Health"

/datum/status_effect/music/recovery
	id = "Tenacity"

/datum/status_effect/music/maxhp_up
	id = "Vigor"
