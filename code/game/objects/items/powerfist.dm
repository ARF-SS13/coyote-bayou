/obj/item/melee/powerfist
	name = "power-fist"
	desc = "A metal gauntlet with a piston-powered ram ontop for that extra 'ompfh' in your punch."
	icon_state = "powerfist"
	inhand_icon_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	item_flags = NEEDS_PERMIT | NO_COMBAT_MODE_FORCE_MODIFIER //To avoid ambushing and oneshotting healthy crewmembers on force setting 3.
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 14
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	attack_speed = CLICK_CD_MELEE * 1.5
	//var/fisto_setting = 1
	//var/gasperfist = 3
	var/obj/item/tank/internals/tank = null //Tank used for the gauntlet's piston-ram.

/obj/item/melee/powerfist/examine(mob/user)
	. = ..()
	if(!in_range(user, src))
		. += span_notice("You'll need to get closer to see any more.")
		return
	if(tank)
		. += span_notice("[icon2html(tank, user)] It has \a [tank] mounted onto it.")


//obj/item/melee/powerfist/attackby(obj/item/W, mob/user, params)
	//if(istype(W, /obj/item/tank/internals))
		//if(!tank)
			//var/obj/item/tank/internals/IT = W
			//if(IT.volume <= 3)
				//to_chat(user, span_warning("\The [IT] is too small for \the [src]."))
				//return
			//updateTank(W, 0, user)
	//else if(istype(W, /obj/item/wrench))
		//switch(fisto_setting)
			//if(1)
				//fisto_setting = 2
			//if(2)
				//fisto_setting = 3
			//if(3)
				//fisto_setting = 1
		//W.play_tool_sound(src)
		//to_chat(user, span_notice("You tweak \the [src]'s piston valve to [fisto_setting]."))
	//else if(istype(W, /obj/item/screwdriver))
		//if(tank)
			//updateTank(tank, 1, user)

/obj/item/melee/powerfist/proc/updateTank(obj/item/tank/internals/thetank, removing = 0, mob/living/carbon/human/user)
	if(removing)
		if(!tank)
			to_chat(user, span_notice("\The [src] currently has no tank attached to it."))
			return
		to_chat(user, span_notice("You detach \the [thetank] from \the [src]."))
		tank.forceMove(get_turf(user))
		user.put_in_hands(tank)
		tank = null
	if(!removing)
		if(tank)
			to_chat(user, span_warning("\The [src] already has a tank."))
			return
		if(!user.transferItemToLoc(thetank, src))
			return
		to_chat(user, span_notice("You hook \the [thetank] up to \the [src]."))
		tank = thetank


/obj/item/melee/powerfist/attack(mob/living/target, mob/living/user, attackchain_flags = NONE)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm other living beings!"))
		return FALSE
	// if(!tank)
	// 	to_chat(user, span_warning("\The [src] can't operate without a source of gas!"))
	// 	return FALSE

	var/weight = getweight(user, STAM_COST_ATTACK_MOB_MULT)
	// var/turf/T = get_turf(src)
	// if(!T)
	// 	return FALSE
	var/totalitemdamage = target.pre_attacked_by(src, user)
	// var/moles_used = gasperfist * fisto_setting
	// if(!moles_used)

	// 	to_chat(user, span_warning("\The [src]'s tank is empty!"))

	// 	target.attacked_by(src, user, attackchain_flags, fisto_setting*1.5)

	// 	//target.apply_damage((totalitemdamage / 5), BRUTE)
	// 	playsound(loc, 'sound/weapons/punch1.ogg', 50, 1)
	// 	target.visible_message(span_danger("[user]'s powerfist lets out a dull thunk as [user.p_they()] punch[user.p_es()] [target.name]!"),
	// 	span_userdanger("[user]'s punches you!"))
	// 	return
	// if(tank.air_contents.total_moles() < moles_used)
	// 	to_chat(user, span_warning("\The [src]'s piston-ram lets out a weak hiss, it needs more gas!"))
	// 	playsound(loc, 'sound/weapons/punch4.ogg', 50, 1)

	// 	target.attacked_by(src, user, attackchain_flags, fisto_setting*1.5)

	// 	//target.apply_damage((totalitemdamage / 2), BRUTE)
	// 	target.visible_message(span_danger("[user]'s powerfist lets out a weak hiss as [user.p_they()] punch[user.p_es()] [target.name]!"),
	// 		span_userdanger("[user]'s punch strikes with force!"))
	// 	return

	// T.assume_air_moles(tank.air_contents, gasperfist * fisto_setting)
	// T.air_update_turf()
	SSdamage.damage_mob(user, target, totalitemdamage)

	target.visible_message(span_danger("[user]'s powerfist lets out a loud hiss as [user.p_they()] punch[user.p_es()] [target.name]!"), \
		span_userdanger("You cry out in pain as [user]'s punch flings you backwards!"))
	new /obj/effect/temp_visual/kinetic_blast(target.loc)
	playsound(loc, 'sound/weapons/resonator_blast.ogg', 50, 1)
	playsound(loc, 'sound/weapons/genhit2.ogg', 50, 1)

	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 2 * 2, 0.5 + (2))

	log_combat(user, target, "power fisted", src)

	weight = getweight(user, STAM_COST_ATTACK_MOB_MULT)
	if(weight)
		user.adjustStaminaLossBuffered(weight)
	return TRUE
