/datum/action/innate/summon_backup
	name = "Summon Backup"
	desc = "Draws friendly mobs nearby."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/innate/summon_backup/IsAvailable(silent = FALSE)
	if(..())
		return TRUE

/datum/action/innate/summon_backup/Activate()
	if(owner.incapacitated())
		return

	var/mob/living/simple_animal/user = owner

	var/turf/the_turf = get_turf(user)
	if(!the_turf)
		return

	//playsound(get_turf(user), 'sound/machines/chime.ogg', 50, 1, -1)
	user.do_alert_animation(user)
	for(var/mob/living/simple_animal/hostile/M in orange(10, get_turf(user)))
		if(user.faction_check_mob(M, FALSE))
			if(M.AIStatus == AI_OFF || M.stat == DEAD || M.ckey)
				return
			M.Goto(user,M.move_to_delay,1)
			M.do_alert_animation(M)
	return TRUE


/obj/effect/proc_holder/direct_mobs
	name = "Send Mobs"
	desc = "Direct nearby mobs to go to a tile."
	panel = "Player Mob"
	active = FALSE
	action = null
	action_icon = 'icons/mob/actions.dmi'
	action_icon_state = "Chevron_State_0"

/obj/effect/proc_holder/direct_mobs/Initialize()
	. = ..()
	action = new(src)

/obj/effect/proc_holder/direct_mobs/update_icon()
	action.button_icon_state = "Chevron_State_[active]"
	action.UpdateButtonIcon()

/obj/effect/proc_holder/direct_mobs/Trigger(mob/living/simple_animal/user)
	if(!istype(user))
		return TRUE
	activate(user)
	return TRUE

/obj/effect/proc_holder/direct_mobs/proc/activate(mob/living/user)
	var/message
	if(active)
		message = span_notice("You decide not to direct any mobs.")
		remove_ranged_ability(message)
	else
		message = span_notice("You get ready to direct nearby mobs somewhere. <b>Click on a tile to send them!</b>")
		add_ranged_ability(user, message, TRUE)
		return 1

/obj/effect/proc_holder/direct_mobs/InterceptClickOn(mob/living/caller, params, atom/target)
	if(..())
		return
	if(ranged_ability_user.incapacitated())
		remove_ranged_ability()
		return

	var/mob/living/simple_animal/user = ranged_ability_user

	var/turf/the_turf = get_turf(target)
	if(!the_turf)
		remove_ranged_ability()
		return

	//playsound(get_turf(user), 'sound/machines/chime.ogg', 50, 1, -1)
	user.do_alert_animation(the_turf)
	for(var/mob/living/simple_animal/hostile/M in orange(10, get_turf(user)))
		if(user.faction_check_mob(M, FALSE))
			if(M.AIStatus == AI_OFF || M.stat == DEAD || M.ckey)
				return
			M.Goto(target,M.move_to_delay,M.minimum_distance)
			M.do_alert_animation(M)
	remove_ranged_ability()
	return TRUE

/obj/effect/proc_holder/direct_mobs/on_lose(mob/living/carbon/user)
	remove_ranged_ability()
