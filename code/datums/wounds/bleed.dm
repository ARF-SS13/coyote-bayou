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
	/// How much blood we start losing when this wound is first applied
	var/initial_flow
	/// When we have less than this amount of flow, either from treatment or clotting, we demote to a lower cut or are healed of the wound
	var/minimum_flow
	/// How much the wound's integrity drops per cycle on its own. Huge wounds bleed out faster
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
	/// Wound size, basically the wound's hitpoints
	var/wound_integrity
	/// Required wound integrity to promote to the next
	var/wound_integrity_max
	COOLDOWN_DECLARE(bleed_heal_cooldown)

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
				victim.visible_message(span_danger("Blood droplets fly from the wound in [victim]'s [limb.name]."), span_danger("You cough up a bit of blood from the blow to your [limb.name]."), vision_distance=COMBAT_MESSAGE_RANGE)
				victim.bleed(blood_bled, TRUE)
			if(14 to 19)
				victim.visible_message(span_danger("A small stream of blood spurts from the wound in [victim]'s [limb.name]!"), span_danger("You spit out a string of blood from the blow to your [limb.name]!"), vision_distance=COMBAT_MESSAGE_RANGE)
				new /obj/effect/temp_visual/dir_setting/bloodsplatter(victim.loc, victim.dir)
				victim.bleed(blood_bled)
			if(20 to INFINITY)
				victim.visible_message(span_danger("A spray of blood streams from the gash in [victim]'s [limb.name]!"), "<span class='danger'><b>You choke up on a spray of blood from the blow to your [limb.name]!</b></span>", vision_distance=COMBAT_MESSAGE_RANGE)
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

/datum/wound/bleed/get_examine_description(mob/user)
	if(istype(limb.current_gauze, /obj/item/stack/medical/gauze))
		var/list/msg = list("The bleeding wounds on [victim.p_their()] [limb.name] are wrapped with ")
		var/bandaid_max_time = initial(limb.current_gauze.covering_lifespan)
		var/bandaid_time = limb.get_covering_timeleft(COVERING_BANDAGE, COVERING_TIME_TRUE)
		// how much life we have left in these bandages
		switch(bandaid_time)
			if((bandaid_max_time * BANDAGE_GOODLIFE_DURATION) to INFINITY)
				msg += "fresh "
			if((bandaid_max_time * BANDAGE_MIDLIFE_DURATION) to (bandaid_max_time * BANDAGE_GOODLIFE_DURATION))
				msg += "slightly worn "
			if((bandaid_max_time * BANDAGE_ENDLIFE_DURATION) to (bandaid_max_time * BANDAGE_MIDLIFE_DURATION))
				msg += "badly worn "
			if(-INFINITY to (bandaid_max_time * BANDAGE_ENDLIFE_DURATION))
				msg += "nearly ruined "
		msg += "[limb.current_gauze.name]!"
		. += "<B>[msg.Join()]</B>\n"

	if(istype(limb.current_suture, /obj/item/stack/medical/suture))
		var/list/msg = list("The bleeding wounds on [victim.p_their()] [limb.name] are stitched up with ")
		var/bandaid_max_time = initial(limb.current_suture.covering_lifespan)
		var/bandaid_time = limb.get_covering_timeleft(COVERING_SUTURE, COVERING_TIME_TRUE)
		// how much life we have left in these bandages
		switch(bandaid_time)
			if((bandaid_max_time * BANDAGE_GOODLIFE_DURATION) to INFINITY)
				msg += "sturdy "
			if((bandaid_max_time * BANDAGE_MIDLIFE_DURATION) to (bandaid_max_time * BANDAGE_GOODLIFE_DURATION))
				msg += "slightly frayed "
			if((bandaid_max_time * BANDAGE_ENDLIFE_DURATION) to (bandaid_max_time * BANDAGE_MIDLIFE_DURATION))
				msg += "badly frayed "
			if(-INFINITY to (bandaid_max_time * BANDAGE_ENDLIFE_DURATION))
				msg += "nearly popped "
		msg += "[limb.current_suture.name]s!"
		. += "<B>[msg.Join()]</B>\n"

/datum/wound/bleed/handle_process()
	if(victim.stat == DEAD)
		blood_flow -= max(clot_rate, WOUND_SLASH_DEAD_CLOT_MIN)
		if(blood_flow < minimum_flow)
			if(demotes_to)
				replace_wound(demotes_to)
				return
			qdel(src)
			return

	limb.check_gauze_time()
	limb.check_suture_time()
	
	reduce_bloodflow()

	if(get_blood_flow(FALSE) < minimum_flow)
		to_chat(victim, span_green("The cut on your [limb.name] has stopped bleeding!"))
		qdel(src)

/datum/wound/bleed/drag_bleed_amount()
	// say we have 3 severe cuts with 3 blood flow each, pretty reasonable
	// compare with being at 100 brute damage before, where you bled (brute/100 * 2), = 2 blood per tile
	var/bleed_amt = min(blood_flow * 0.1, 1) // 3 * 3 * 0.1 = 0.9 blood total, less than before! the share here is .3 blood of course.

	if(limb.current_gauze) // gauze stops all bleeding from dragging on this limb
		limb.check_gauze_time()
		return bleed_amt * WOUND_BLEED_BANDAGE_MULTIPLIER

	return bleed_amt

/// calculates how much the wound should be ensmallening
/datum/wound/bleed/proc/reduce_bloodflow()
	if(!COOLDOWN_FINISHED(src, bleed_heal_cooldown))
		return
	COOLDOWN_START(src, bleed_heal_cooldown, BLEED_HEAL_COOLDOWN_TIME)
	blood_flow -= rand(0,clot_rate)

	if(victim.bodytemperature < (BODYTEMP_NORMAL -  10))
		blood_flow -= clot_rate
		if(prob(5))
			to_chat(victim, span_notice("You feel the [lowertext(name)] in your [limb.name] firming up from the cold!"))

	if(istype(limb.current_suture))
		suture_healing()

/// calculates how much our suturejob should ensmallen the wound
/datum/wound/bleed/proc/suture_healing()
	if(!istype(limb.current_suture))
		return FALSE
	var/obj/item/stack/medical/suture/our_suture = limb.current_suture
	blood_flow -= our_suture.suture_power * (istype(limb.current_gauze) ? SUTURE_AND_BANDAGE_BONUS : 1)
	// Food based wound healing, spends nutrition to regen blood
	// Wound healing has a fixed nutrition cost, but being more well fed speeds it up a bit
	if(!HAS_TRAIT(victim, TRAIT_NOHUNGER))
		var/nutrition_bonus = 0
		switch(victim.nutrition)
			if(0 to NUTRITION_LEVEL_FED)
				nutrition_bonus = WOUND_HEAL_FULL
			if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_FULL)
				nutrition_bonus = WOUND_HEAL_FED
			if(NUTRITION_LEVEL_FULL to INFINITY)
				nutrition_bonus = WOUND_HEAL_HUNGRY

		if(victim.satiety > 80)
			nutrition_bonus *= 1.25
		victim.adjust_nutrition(-nutrition_bonus)
		blood_flow -= nutrition_bonus / WOUND_HEAL_NUTRITION_COST

/datum/wound/bleed/get_blood_flow(include_reductions = FALSE)
	. = blood_flow
	
	if(!include_reductions)
		return

	if(victim.bodytemperature < (BODYTEMP_NORMAL - 10))
		. *= 0.5

	if(!(victim.mobility_flags & MOBILITY_STAND))
		. *= WOUND_BLEED_LYING_DOWN_MULTIPLIER

	if(limb.check_gauze_time() & BANDAGE_STILL_INTACT)
		. *= WOUND_BLEED_BANDAGE_MULTIPLIER

	if(limb.check_suture_time() & SUTURE_STILL_INTACT)
		. *= WOUND_BLEED_SUTURE_MULTIPLIER // its 0 lol

	if(victim.reagents?.reagent_list)
		for(var/datum/reagent/bleed_changer in victim.reagents.reagent_list)
			. *= bleed_changer.bleed_mult

	var/owner_blood_volume = victim.get_blood(FALSE)
	if(owner_blood_volume < low_blood_threshold)
		. *= low_blood_multiplier
	
/datum/wound/bleed/on_stasis()
	if(blood_flow >= minimum_flow)
		return
	if(demotes_to)
		replace_wound(demotes_to)
		return
	qdel(src)

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
	else if(istype(I, /obj/item/gun/energy/laser))
		las_cauterize(I, user)

/datum/wound/bleed/on_xadone(power)
	. = ..()
	blood_flow -= 0.03 * power // i think it's like a minimum of 3 power, so .09 blood_flow reduction per tick is pretty good for 0 effort

/datum/wound/bleed/on_synthflesh(power)
	. = ..()
	//blood_flow -= 0.075 * power // 20u * 0.075 = -1.5 blood flow, pretty good for how little effort it is

/// Someone is trying to cauterize a wound with a fucking lasergun
/datum/wound/bleed/proc/las_cauterize(obj/item/gun/energy/laser/lasgun, mob/user)
	var/self_penalty_mult = (user == victim ? 1.25 : 1)
	user.visible_message(span_warning("[user] begins aiming [lasgun] directly at [victim]'s [limb.name]..."), span_userdanger("You begin aiming [lasgun] directly at [user == victim ? "your" : "[victim]'s"] [limb.name]..."))
	if(!do_after(user, base_treat_time  * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	var/damage = lasgun.chambered.BB.damage
	lasgun.chambered.BB.wound_bonus -= 30
	lasgun.chambered.BB.damage *= self_penalty_mult
	if(!lasgun.process_fire(victim, victim, TRUE, null, limb.body_zone))
		return
	victim.emote("scream")
	blood_flow -= damage / (5 * self_penalty_mult) // 20 / 5 = 4 bloodflow removed, p good
	victim.visible_message(span_warning("The cuts on [victim]'s [limb.name] scar over!"))

/// If someone is using a suture to close this cut
/datum/wound/bleed/proc/suture(obj/item/stack/medical/suture/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.2 : 1)
	user.visible_message(span_notice("[user] begins stitching [victim]'s [limb.name] with [I]..."), span_notice("You begin stitching [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."))

	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return
	user.visible_message(span_green("[user] stitches up some of the bleeding on [victim]."), span_green("You stitch up some of the bleeding on [user == victim ? "yourself" : "[victim]"]."))
	var/blood_sutured = I.is_bandage / self_penalty_mult
	blood_flow -= blood_sutured
	limb.heal_damage(I.heal_brute, I.heal_burn)

	if(blood_flow > minimum_flow)
		try_treating(I, user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))


/// If someone is using either a cautery tool or something with heat to cauterize this cut
/datum/wound/bleed/proc/tool_cauterize(obj/item/I, mob/user)
	var/self_penalty_mult = (user == victim ? 1.5 : 1)
	user.visible_message(span_danger("[user] begins cauterizing [victim]'s [limb.name] with [I]..."), span_danger("You begin cauterizing [user == victim ? "your" : "[victim]'s"] [limb.name] with [I]..."))
	if(!do_after(user, base_treat_time * self_penalty_mult, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message(span_green("[user] cauterizes some of the bleeding on [victim]."), span_green("You cauterize some of the bleeding on [victim]."))
	limb.receive_damage(burn = 2 + severity, wound_bonus = CANT_WOUND)
	if(prob(30))
		victim.emote("scream")
	var/blood_cauterized = (0.6 / self_penalty_mult)
	blood_flow -= blood_cauterized

	if(blood_flow > minimum_flow)
		try_treating(I, user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [user == victim ? "your" : "[victim]'s"] cuts."))

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
	if(!do_after(user, base_treat_time, target=victim, extra_checks = CALLBACK(src, .proc/still_exists)))
		return

	user.visible_message(span_notice("[user] licks the wounds on [victim]'s [limb.name]."), span_notice("You lick some of the wounds on [victim]'s [limb.name]"), ignored_mobs=victim)
	to_chat(victim, "<span class='green'>[user] licks the wounds on your [limb.name]!</span")
	blood_flow -= 0.05
	if(isinsect(victim) || iscatperson(victim) || ismammal(victim) || isdwarf(victim) || ismonkey(victim)) // Yep you can lick monkeys.
		user.reagents.add_reagent(/datum/reagent/hairball, 2)

	else if(ishumanbasic(victim) || isflyperson(victim) || islizard(victim) || isdullahan(victim))
		user.reagents.add_reagent(/datum/reagent/hairball, 1)

	if(blood_flow > minimum_flow)
		try_handling(user)
	else if(demotes_to)
		to_chat(user, span_green("You successfully lower the severity of [victim]'s cuts."))
