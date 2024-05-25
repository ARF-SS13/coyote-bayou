/* * * * * *
 * Bleeding
 * * * * * */

/datum/wound/bleed
	sound_effect = 'sound/weapons/slice.ogg'
	processes = TRUE
	wound_type = WOUND_PIERCE
	treatable_by_grabbed = list(/obj/item/gun/energy/laser)
	treatable_tool = TOOL_CAUTERY
	base_treat_time = 3 SECONDS
	wound_flags = (FLESH_WOUND | ACCEPTS_GAUZE | ACCEPTS_SUTURE)
	renew_text = "rips back open"
	base_aggravation_force = 3
	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// The lowest that this wound will naturally bleed, before multipliers
	var/minimum_flow
	/// How much the wound stops bleeding per tick. Typically slow, but can be sped up with sutures and such
	var/clot_rate
	/// How much to scale the bleeding if the owner's blood is below low_blood_threshold
	var/low_blood_multiplier = 1
	/// If our owner's blood level is below this, we'll multiply blood loss by low_blood_multiplier
	var/low_blood_threshold
	/// Once wound integrity goes below 0, we demote it to this type of wound. If there's none, we're all better
	var/demotes_to
	/// If wound integrity goes above its max, we promote it to this type of wound. If there's none, just make it worse
	var/promotes_to
	/// A bad system I'm using to track the worst scar we earned (since we can demote, we want the biggest our wound has been, not what it was when it was cured (probably moderate))
	var/datum/scar/highest_scar
	/// When hit on this bodypart, we have this chance of losing some blood + the incoming damage
	var/internal_bleeding_chance
	/// If we let off blood when hit, the max blood lost is this * the incoming damage
	var/internal_bleeding_coefficient
	/// Do bandages fully stop this wound's bleeding?
	var/stopped_by_bandage = FALSE
	COOLDOWN_DECLARE(bleed_heal_cooldown)

/**
 * apply_wound() is used once a wound type is instantiated to assign it to a bodypart, and actually come into play.
 * Somewhat different for bleed wounds. First makes a generic wound based on either slash or pierce
 * Then runs Handle Damage to set the actual wounding values and do all the loud splortch stuff
 * 
 * if there's already a wound of this type, nothing happens and this instance of the wound is deleted
 *
 *
 * Arguments:
 * * L: The bodypart we're wounding, we don't care about the person, we can get them through the limb
 * * silent: Not actually necessary I don't think, was originally used for demoting wounds so they wouldn't make new messages, but I believe old_wound took over that, I may remove this shortly
 * * old_wound: unused
 * * smited: unused
 */
/datum/wound/bleed/apply_wound(obj/item/bodypart/L, silent = FALSE, datum/wound/old_wound = null, smited = FALSE)
	if(!istype(L) || !L.owner || !(L.body_zone in viable_zones) || isalien(L.owner) || !(L.is_organic_limb() || L.render_like_organic))
		qdel(src)
		return

	if(ishuman(L.owner))
		var/mob/living/carbon/human/H = L.owner
		if(((wound_flags & BONE_WOUND) && !(HAS_BONE in H.dna.species.species_traits)) || ((wound_flags & FLESH_WOUND) && !(HAS_FLESH in H.dna.species.species_traits)))
			qdel(src)
			return

	// we accept promotions and demotions, but no point in redundancy. This should have already been checked wherever the wound was rolled and applied for (see: bodypart damage code), but we do an extra check
	// in case we ever directly add wounds
	for(var/datum/wound/bleed/preexisting_wound in L.wounds)
		if(preexisting_wound.type == type) // already have this wound, please call handle_damage to update the wound, ty~<3
			qdel(src)
			return

	victim = L.owner
	limb = L
	LAZYADD(victim.all_wounds, src)
	LAZYADD(limb.wounds, src)
	limb.update_wounds()
	if(status_effect_type)
		linked_status_effect = victim.apply_status_effect(status_effect_type, src)
	SEND_SIGNAL(victim, COMSIG_CARBON_GAIN_WOUND, src, limb)
	if(!victim.alerts["wound"]) // only one alert is shared between all of the wounds
		victim.throw_alert("wound", /atom/movable/screen/alert/status_effect/wound)

	handle_damage(FALSE, TRUE, TRUE, FALSE)

/// Update the wound's stats to the apropriate values
/datum/wound/bleed/proc/handle_damage(silent = FALSE, can_promote = TRUE, force_wound, can_reopen = FALSE, healing = FALSE)
	var/target_severity = get_limb_bleed_severity()
	switch(target_severity)
		if(WOUND_DO_NOTHING)
			return
		if(WOUND_DELETE)
			remove_wound(FALSE, FALSE)
			return
	if(healing) // fun fact, using sutures on people with multiple wounds would make them keep shooting out blood
		return
	var/what_do = check_damage(target_severity)
	update_wound(what_do, silent, can_promote, force_wound ? target_severity : FALSE, can_reopen)

/// Returns the limb's target wound severity
/datum/wound/bleed/proc/get_limb_bleed_severity()
	switch(limb.bleed_dam)
		if(-INFINITY to WOUND_BLEED_CLOSE_THRESHOLD)
			. = WOUND_DELETE // wound's healed
		if(WOUND_BLEED_CLOSE_THRESHOLD to WOUND_BLEED_MODERATE_THRESHOLD)
			. = WOUND_DO_NOTHING // under the threshold, its too minor to do anything useful
		if(WOUND_BLEED_MODERATE_THRESHOLD to WOUND_BLEED_SEVERE_THRESHOLD)
			. = WOUND_SEVERITY_MODERATE
		if(WOUND_BLEED_SEVERE_THRESHOLD to WOUND_BLEED_CRITICAL_THRESHOLD)
			. = WOUND_SEVERITY_SEVERE
		if(WOUND_BLEED_CRITICAL_THRESHOLD to INFINITY)
			. = WOUND_SEVERITY_CRITICAL

/// Compares an input limb severity to our current severity, and outputs
/datum/wound/bleed/proc/check_damage(limb_severity)
	if(severity == limb_severity)
		return WOUND_RENEW // refresh the wound if needed
	if(severity < limb_severity)
		return WOUND_PROMOTE // our severity is less than the limb's injury severity, increase ours to match
	if(severity > limb_severity)
		return WOUND_DEMOTE // our severity is more than the limb's injury severity, decrease ours to match

/datum/wound/bleed/update_wound(which_way, silent = FALSE, can_promote, force_severity, can_reopen)
	var/datum/wound/bleed/new_wound
	var/splortch = FALSE
	var/splortch_reopen = FALSE
	var/second_wind = FALSE
	if(force_severity >= WOUND_SEVERITY_MODERATE)
		if(istype(src, /datum/wound/bleed/pierce))
			new_wound = GLOB.global_pierce_wound_severities[force_severity]
		else if(istype(src, /datum/wound/bleed/slash))
			new_wound = GLOB.global_slash_wound_severities[force_severity]
		else // getting something
			new_wound = GLOB.global_slash_wound_severities[force_severity]
		splortch = TRUE
		splortch_reopen = FALSE
		second_wind = TRUE
	else
		if(!can_promote && which_way == WOUND_PROMOTE)
			which_way = WOUND_RENEW
		switch(which_way)
			if(WOUND_RENEW)
				if(!can_reopen)
					return
				new_wound = GLOB.global_pierce_wound_severities[severity]
				second_wind = TRUE
				splortch = TRUE
				splortch_reopen = TRUE
			if(WOUND_PROMOTE)
				second_wind = TRUE
				splortch = TRUE
				splortch_reopen = FALSE
				if(promotes_to)
					new_wound = promotes_to
				else
					new_wound = GLOB.global_pierce_wound_severities[severity] // reopen it!
					splortch_reopen = TRUE
			if(WOUND_DEMOTE)
				if(demotes_to)
					new_wound = demotes_to
				else
					remove_wound(FALSE, FALSE)
					return //shrug
	if(new_wound)
		name = initial(new_wound.name)
		desc = initial(new_wound.desc)
		treat_text = initial(new_wound.treat_text)
		examine_desc = initial(new_wound.examine_desc)
		occur_text = initial(new_wound.occur_text)
		renew_text = initial(new_wound.renew_text)
		sound_effect = initial(new_wound.sound_effect)
		severity = initial(new_wound.severity)
		initial_flow = initial(new_wound.initial_flow)
		minimum_flow = initial(new_wound.minimum_flow)
		clot_rate = initial(new_wound.clot_rate)
		internal_bleeding_chance = initial(new_wound.internal_bleeding_chance)
		internal_bleeding_coefficient = initial(new_wound.internal_bleeding_coefficient)
		threshold_minimum = initial(new_wound.threshold_minimum)
		threshold_penalty = initial(new_wound.threshold_penalty)
		low_blood_threshold = initial(new_wound.low_blood_threshold)
		low_blood_multiplier = initial(new_wound.low_blood_multiplier)
		promotes_to = initial(new_wound.promotes_to)
		status_effect_type = initial(new_wound.status_effect_type)
		scar_keyword = initial(new_wound.scar_keyword)
		stopped_by_bandage = initial(new_wound.stopped_by_bandage)
		wound_flags = initial(new_wound.wound_flags)
	if(splortch)
		do_splortch(splortch_reopen)
	if(second_wind)
		second_wind()

/datum/wound/bleed/proc/do_splortch(renewing = FALSE)
	var/verbiage = renewing ? "[renew_text]" : "[occur_text]"
	var/msg = span_danger("[victim]'s [limb.name] [verbiage]!")
	var/vis_dist = COMBAT_MESSAGE_RANGE

	if(severity != WOUND_SEVERITY_MODERATE)
		msg = "<b>[msg]</b>"
		vis_dist = DEFAULT_MESSAGE_RANGE

	victim.visible_message(msg, span_userdanger("Your [limb.name] [verbiage]!"), vision_distance = vis_dist)
	if(sound_effect)
		playsound(limb.owner, sound_effect, 70 + 20 * severity, TRUE, ignore_walls = TRUE)

/datum/wound/bleed/receive_damage(wounding_type, wounding_dmg, wound_bonus)
	if(victim.stat != DEAD && wounding_type == WOUND_SLASH) // can't stab dead bodies to make it bleed faster this way
		blood_flow += 0.05 * wounding_dmg
	if(victim.get_blood(TRUE) && prob(internal_bleeding_chance + wounding_dmg))
		if(limb.current_gauze && limb.current_gauze.splint_factor)
			wounding_dmg *= (1 - limb.current_gauze.splint_factor)
		var/blood_bled = rand(1, wounding_dmg * internal_bleeding_coefficient) // 12 brute toolbox can cause up to 15/18/21 bloodloss on mod/sev/crit
		switch(blood_bled)
			if(1 to 6)
				victim.bleed(blood_bled, TRUE)
			if(7 to 13)
//				victim.visible_message(span_danger("Blood droplets fly from the wound in [victim]'s [limb.name]."), span_danger("You cough up a bit of blood from the blow to your [limb.name]."), vision_distance=COMBAT_MESSAGE_RANGE) // combat messages happen often and fast- causing severe client lag
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
//				victim.visible_message(span_danger("A small stream of blood spurts from the wound in [victim]'s [limb.name]!"), span_danger("You spit out a string of blood from the blow to your [limb.name]!"), vision_distance=COMBAT_MESSAGE_RANGE) // combat messages happen often and fast- causing severe client lag
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
//				victim.visible_message(span_danger("A spray of blood streams from the gash in [victim]'s [limb.name]!"), span_danger("<b>You choke up on a spray of blood from the blow to your [limb.name]!</b>"), vision_distance=COMBAT_MESSAGE_RANGE) // combat messages happen often and fast- causing severe client lag
				victim.bleed(blood_bled)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.add_splatter_floor(get_step(victim.loc, victim.dir))

/datum/wound/bleed/wound_injury(datum/wound/bleed/old_wound = null)
	blood_flow = initial_flow
	if(old_wound)
		blood_flow = max(old_wound.blood_flow, initial_flow)
		if(old_wound.severity > severity && old_wound.highest_scar)
			highest_scar = old_wound.highest_scar
			old_wound.highest_scar = null

	if(!highest_scar)
		highest_scar = new
		highest_scar.generate(limb, src, add_to_scars=FALSE)

/datum/wound/bleed/remove_wound(ignore_limb, replaced)
	if(!replaced && highest_scar)
		already_scarred = TRUE
		highest_scar.lazy_attach(limb)
	return ..()

/datum/wound/bleed/handle_process()
	/* if(victim.stat == DEAD)
		blood_flow -= max(clot_rate, WOUND_SLASH_DEAD_CLOT_MIN)
		if(blood_flow < minimum_flow)
			if(demotes_to)
				replace_wound(demotes_to)
				return
			qdel(src)
			return */

	limb.check_gauze_time()
	limb.check_suture_time()
	
	reduce_bloodflow()

/* 	if(get_blood_flow(FALSE) < minimum_flow)
		to_chat(victim, span_green("The cut on your [limb.name] has stopped bleeding!"))
		qdel(src) */

/datum/wound/bleed/drag_bleed_amount()
	return get_blood_flow(TRUE)

/// calculates how much the wound should be ensmallening
/datum/wound/bleed/proc/reduce_bloodflow()
	if(!COOLDOWN_FINISHED(src, bleed_heal_cooldown))
		return
	COOLDOWN_START(src, bleed_heal_cooldown, BLEED_HEAL_COOLDOWN_TIME)
	blood_flow -= rand(clot_rate * 0.5, clot_rate)

	if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
		blood_flow -= rand(clot_rate * 0.5, clot_rate)
		if(prob(5))
			to_chat(victim, span_notice("You feel the [lowertext(name)] in your [limb.name] firming up from the cold!"))

	blood_flow = max(blood_flow, minimum_flow)

/datum/wound/bleed/get_blood_flow(include_reductions = FALSE)
	. = blood_flow

	if(aggravated_until > world.time)
		. *= (base_aggravation_force * aggravation_scalar)
	else
		aggravated_until = 0
	
	if(!include_reductions)
		return

	if(victim.stat == DEAD)
		return 0
		
	if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
		. *= 0.5

	if(!(victim.mobility_flags & MOBILITY_STAND))
		. *= WOUND_BLEED_LYING_DOWN_MULTIPLIER

	if(limb.check_gauze_time() & BANDAGE_STILL_INTACT)
		. *= WOUND_BLEED_BANDAGE_MULTIPLIER

	if(limb.check_suture_time() & SUTURE_STILL_INTACT)
		. *= WOUND_BLEED_SUTURE_MULTIPLIER // its 0 lol

	//var/signal_mod = SEND_SIGNAL(victim, COMSIG_CARBON_GET_BLEED_MOD, src, limb)
	// if(!isnull(signal_mod))
	// 	. *= signal_mod

	if(victim.reagents?.reagent_list)
		for(var/datum/reagent/bleed_changer in victim.reagents.reagent_list)
			. *= bleed_changer.bleed_mult

	var/owner_blood_volume = victim.get_blood(FALSE)
	if(owner_blood_volume < low_blood_threshold)
		. *= low_blood_multiplier
	
/datum/wound/bleed/on_stasis()
	return

/datum/wound/bleed/slash/check_grab_treatments(obj/item/I, mob/user)
	if(istype(I, /obj/item/gun/energy/laser))
		return TRUE

/datum/wound/bleed/try_handling(mob/living/carbon/human/user)
	if(user.pulling != victim || user.zone_selected != limb.body_zone || user.a_intent == INTENT_GRAB)
		return FALSE

	if(!iscatperson(user))
		return FALSE

	lick_wounds(user)
	return TRUE

/datum/wound/bleed/treat(obj/item/I, mob/user)
	//if(istype(I, /obj/item/stack/medical/suture))
	//	suture(I, user)
	if(I.tool_behaviour == TOOL_CAUTERY || I.get_temperature() > 300)
		tool_cauterize(I, user)
	//else if(istype(I, /obj/item/gun/energy/laser))
	//	las_cauterize(I, user)

/datum/wound/bleed/on_xadone(power)
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/bleed/on_synthflesh(power)
	. = ..()
	//blood_flow -= 0.075 * power // 20u * 0.075 = -1.5 blood flow, pretty good for how little effort it is

/// Someone is trying to cauterize a wound with a fucking lasergun - unused for now, doesnt work
/datum/wound/bleed/proc/las_cauterize(obj/item/gun/energy/laser/lasgun, mob/user)
	var/self_penalty_mult = (user == victim ? 1.25 : 1)
	user.visible_message(span_warning("[user] begins aiming [lasgun] directly at [victim]'s [limb.name]..."), span_userdanger("You begin aiming [lasgun] directly at [user == victim ? "your" : "[victim]'s"] [limb.name]..."))
	if(!do_after(user, base_treat_time  * self_penalty_mult, target=victim, extra_checks = CALLBACK(src,PROC_REF(still_exists))))
		return
	var/damage = lasgun.chambered.BB.damage
	lasgun.chambered.BB.wound_bonus -= 30
	lasgun.chambered.BB.damage *= self_penalty_mult
	if(!lasgun.process_fire(victim, victim, TRUE, null, limb.body_zone))
		return
	victim.emote("scream")
	blood_flow -= damage / (5 * self_penalty_mult) // 20 / 5 = 4 bloodflow removed, p good
	victim.visible_message(span_warning("The cuts on [victim]'s [limb.name] scar over!"))

/// If someone is using a suture to close this cut - unused for now, handled by various other mechanics
/datum/wound/bleed/proc/suture(obj/item/stack/medical/suture/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.2 : 1)
	user.visible_message(span_notice("[user] begins stitching [victim]'s [limb.name] with [I]..."), span_notice("You begin stitching [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."))

	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src,PROC_REF(still_exists))))
		return
	user.visible_message(span_green("[user] stitches up some of the bleeding on [victim]."), span_green("You stitch up some of the bleeding on [user == victim ? "yourself" : "[victim]"]."))
	var/blood_sutured = I.is_bandage / self_penalty_mult
	blood_flow -= blood_sutured
	limb.heal_damage(I.heal_brute, I.heal_burn)

	//if(blood_flow > minimum_flow)
	//	try_treating(I, user)
	//else if(demotes_to)
	//	to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))


/// If someone is using either a cautery tool or something with heat to cauterize this cut
/datum/wound/bleed/proc/tool_cauterize(obj/item/I, mob/user)
	if(blood_flow <= minimum_flow)
		to_chat(user, span_danger("You can't cauterize [limb.name] any further, use a bandage and/or a suture!"))
		return
	var/self_penalty_mult = (user == victim ? 1.5 : 1)
	user.visible_message(span_danger("[user] begins cauterizing [victim]'s [limb.name] with [I]..."), span_danger("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."))
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src,PROC_REF(still_exists))))
		return

	user.visible_message(span_green("[user] cauterizes some of the bleeding on [victim]."), span_green("You cauterize some of the bleeding on [victim]."))
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / self_penalty_mult)
	blood_flow = max(blood_flow - blood_cauterized, minimum_flow)

	//if(blood_flow > minimum_flow)
	//	try_treating(I, user)
	//else if(demotes_to)
	//	to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))

/// If someone is licking at their wounds cus they're a cat and that works
/datum/wound/bleed/proc/lick_wounds(mob/living/carbon/human/user)
	if(INTERACTING_WITH(user, victim))
		to_chat(user, span_warning("You're already interacting with [victim]!"))
		return

	if(user.is_mouth_covered())
		to_chat(user, span_warning("Your mouth is covered, you can't lick [victim]'s wounds!"))
		return

	if(!user.getorganslot(ORGAN_SLOT_TONGUE))
		to_chat(user, span_warning("You can't lick wounds without a tongue!")) // f in chat
		return

	// transmission is one way patient -> felinid since google said cat saliva is antiseptic or whatever, and also because felinids are already risking getting beaten for this even without people suspecting they're spreading a deathvirus
	for(var/datum/disease/D in victim.diseases)
		user.ForceContractDisease(D)

	user.visible_message(span_notice("[user] begins licking the wounds on [victim]'s [limb.name]."), span_notice("You begin licking the wounds on [victim]'s [limb.name]..."), ignored_mobs=victim)
	to_chat(victim, "<span class='notice'>[user] begins to lick the wounds on your [limb.name].</span")
	if(!do_after(user, base_treat_time, target=victim, extra_checks = CALLBACK(src,PROC_REF(still_exists))))
		return

	user.visible_message(span_notice("[user] licks the wounds on [victim]'s [limb.name]."), span_notice("You lick some of the wounds on [victim]'s [limb.name]"), ignored_mobs=victim)
	to_chat(victim, "<span class='green'>[user] licks the wounds on your [limb.name]!</span")
	blood_flow -= 0.05
	if(isinsect(victim) || iscatperson(victim) || ismammal(victim) || isdwarf(victim) || ismonkey(victim)) // Yep you can lick monkeys.
		user.reagents.add_reagent(/datum/reagent/hairball, 2)

	else if(ishumanbasic(victim) || isflyperson(victim) || islizard(victim) || isdullahan(victim))
		user.reagents.add_reagent(/datum/reagent/hairball, 1)

	//if(blood_flow > minimum_flow)
	//	try_handling(user)
	//else if(demotes_to)
	//	to_chat(user, span_green("You successfully lower the severity of [victim]'s cuts."))
