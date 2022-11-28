#define BODYPART_MISSING "LIMB GONE"
#define BODYPART_INORGANIC "LIMB BAD"
#define CARBON_ISNT "NOT CARBON"
#define UNABLE_TO_HEAL 0
#define BODYPART_FINE 0
#define DO_HEAL_DAMAGE (1<<1)
#define DO_UNBLEED_WOUND (1<<2)
#define DO_UNBURN_WOUND (1<<3)
#define DO_APPLY_BANDAGE (1<<4)
#define DO_APPLY_SUTURE (1<<5)
#define DO_HURT_DAMAGE (1<<6) // only works with sutures for now
#define USER_HAS_THE_SKILLS 1
#define VICTIM_HAS_THE_SKILLS 2
#define NO_SKILLS_REQUIRED 3

/obj/item/stack/medical
	name = "medical pack"
	singular_name = "medical pack"
	icon = 'icons/obj/stack_objects.dmi'
	amount = 12
	max_amount = 12
	w_class = WEIGHT_CLASS_TINY
	full_w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	resistance_flags = FLAMMABLE
	max_integrity = 50
	novariants = FALSE
	item_flags = NOBLUDGEON
	merge_type = /obj/item/stack/medical
	/// Bandages have a number of hits it can sustain before falling apart. this is that number
	var/covering_hitpoints
	/// We have an active do_after, dont superstack healing things
	var/is_healing = FALSE
	/// trait needed to use this at full speed and effectiveness. Accepts TRAIT_SURGERY_LOW, TRAIT_SURGERY_MID, TRAIT_SURGERY_HIGH
	var/needed_trait
	/// Time penalty multiplier if they dont have the trait
	var/unskilled_speed_mult = 2
	/// Effectiveness penalty multiplier if they dont have the trait
	var/unskilled_effectiveness_mult = 0.5
	var/self_penalty_effectiveness = 0.8
	var/self_delay = 50
	var/other_delay = 50
	var/repeating = TRUE
	/// How much brute we hurt per application
	var/hurt_brute
	/// How much brute we heal per application
	var/heal_brute
	/// How much burn we heal per application
	var/heal_burn
	/// Is this a bandage?
	var/is_bandage = FALSE
	/// Is this a suture?
	var/is_suture = FALSE
	/// How much of an effect does the suture have on wound healing?
	var/suture_power
	/// How much of an effect does the bandage have on wound healing?
	var/bandage_power
	/// How much of an effect does the bandage have on slowing bloodloss?
	var/bandage_staunch
	/// Bandages will only help with wounds under this amount of bleed_dam on a limb
	var/max_bandage_healing
	/// How much sanitization to apply to burns on application
	var/sanitization
	/// How much we add to flesh_healing for burn wounds on application
	var/flesh_regeneration
	/// Can this heal critters?
	var/can_heal_critters = TRUE
	/// How long this bandage should last on someone before falling apart
	var/covering_lifespan = BANDAGE_OKAY_MAX_DURATION
	/// How much this covering will heal over its healing time
	var/heal_per_tick
	/// How much of the healing should be applied per cycle
	//var/heal_over_time_per_tick // unused, pending rework
	/// Told our wearer that we're out of healstuffs
	var/told_owner_its_out_of_juice = FALSE
	/// Infinite?
	var/infinite_uses = FALSE
	/// Sound to play on use
	var/start_sound
	/// Sound to play on end
	var/end_sound

/obj/item/stack/medical/attack(mob/living/M, mob/user)
	. = ..()
	INVOKE_ASYNC(src, .proc/try_heal, M, user)

/obj/item/stack/medical/proc/try_heal(mob/living/M, mob/user, silent = FALSE)
	if(heal(M, user))
		log_combat(user, M, "healed", src.name)
		if(!infinite_uses)
			use(1)
		if(repeating && amount > 0)
			try_heal(M, user, TRUE)

/obj/item/stack/medical/proc/heal(mob/living/M, mob/user)
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, 0)
	if(isanimal(M) && can_heal_critters)
		return heal_critter(M, user)
	to_chat(user, span_warning("You can't heal [M] with \the [src]!"))


/// Returns a bodypart and a bitfield in a list with the first valid bodypart we can work on
/// Returns just a number (FALSE) if nothing is found
/obj/item/stack/medical/proc/pick_a_bodypart(mob/living/carbon/C, mob/user)
	var/obj/item/bodypart/first_choice = C.get_bodypart(check_zone(user.zone_selected))
	var/do_these_things = check_bodypart(user, C, first_choice, TRUE)
	var/list/output_heal_instructions = list("bodypart" = UNABLE_TO_HEAL, "operations" = UNABLE_TO_HEAL)
	// shouldnt happen, but just in case
	if(do_these_things == CARBON_ISNT)
		to_chat(user, span_warning("That can't be healed with this!"))
		return output_heal_instructions

	// limb is missing, output a message and move on
	if(do_these_things == BODYPART_MISSING)
		to_chat(user, span_warning("[C] doesn't have \a [parse_zone(user.zone_selected)]! Let's try another part..."))

	// limb is missing, output a message and move on
	if(do_these_things == BODYPART_INORGANIC)
		to_chat(user, span_warning("[C]'s [parse_zone(user.zone_selected)] is robotic! Let's try another part..."))
	
	// If our operations are a number, and that number corresponds to operations to do, good! output what we're working on and what to do
	if(isnum(do_these_things) && do_these_things > BODYPART_FINE)
		output_heal_instructions = list("bodypart" = first_choice, "operations" = do_these_things)
		return output_heal_instructions
	
	// Part wasn't there, or needed no healing. Lets find one that does need healing!
	var/obj/item/bodypart/affecting
	for(var/limb_slot_to_check in GLOB.main_body_parts)
		if(limb_slot_to_check == user.zone_selected)
			continue // We already checked this, dont check again
		affecting = C.get_bodypart(check_zone(limb_slot_to_check))
		do_these_things = check_bodypart(user, C, affecting)
		if(isnum(do_these_things) && do_these_things > BODYPART_FINE)
			return output_heal_instructions = list("bodypart" = affecting, "operations" = do_these_things)
	return output_heal_instructions

/// Checks the limb for things we can do to it
/// Returns a string if the limb is certainly not suitable for healing
/// Returns a bitfield if the limb can be healed
/// Returns 0 if the limb just doesnt need healing
/obj/item/stack/medical/proc/check_bodypart(mob/living/carbon/user, mob/living/carbon/C, obj/item/bodypart/target_bodypart, output_message = FALSE)
	if(!iscarbon(C))
		return output_message ? CARBON_ISNT : UNABLE_TO_HEAL
	if(!target_bodypart || !istype(target_bodypart, /obj/item/bodypart))
		return output_message ? BODYPART_MISSING : UNABLE_TO_HEAL
	if(target_bodypart.status != BODYPART_ORGANIC)
		return output_message ? BODYPART_INORGANIC : UNABLE_TO_HEAL
	/// Okay we can reasonably assume this limb is okay to try and treat
	. = BODYPART_FINE
	if((heal_brute && target_bodypart.brute_dam) || (heal_burn && target_bodypart.burn_dam))
		. |= DO_HEAL_DAMAGE
	if(is_bandage)
		if(target_bodypart.is_damaged() && target_bodypart.apply_gauze(src, 1, TRUE)) // always apply the stuff if they dont have it
			ENABLE_BITFIELD(., DO_APPLY_BANDAGE)
		/* else if(target_bodypart.bleed_dam || target_bodypart.burn_dam || target_bodypart.burn_dam)
			. |= DO_APPLY_BANDAGE */
	if(is_suture)
		if(target_bodypart.is_damaged() && target_bodypart.apply_suture(src, 1, TRUE)) // always apply the stuff if they dont have it
			ENABLE_BITFIELD(., DO_APPLY_SUTURE)
	if(CHECK_BITFIELD(., DO_APPLY_SUTURE) && hurt_brute)
		ENABLE_BITFIELD(., DO_HURT_DAMAGE)
		/* else if(target_bodypart.bleed_dam || target_bodypart.burn_dam || target_bodypart.burn_dam)
			. |= DO_APPLY_SUTURE */
	for(var/datum/wound/burn/burndies in target_bodypart.wounds)
		if(sanitization || flesh_regeneration)
			if(burndies.flesh_damage || burndies.infestation)
				ENABLE_BITFIELD(., DO_UNBURN_WOUND)

/* * * * * * * * * * * * * * * * * * *
 * Proc that heals simplemobs
 * * * * * * * * * * * * * * * * * * */
/obj/item/stack/medical/proc/heal_critter(mob/living/M, mob/user)
	if(!isanimal(M))
		return
	var/mob/living/simple_animal/critter = M
	if(M.stat == DEAD)
		to_chat(user, span_notice(" [M] is dead. You can not help [M.p_them()]!"))
		return 
	if (!(critter.healable))
		to_chat(user, span_warning("[M] cannot be healed!"))
		return FALSE
	else if (critter.health == critter.maxHealth)
		to_chat(user, span_notice("[M] is at full health."))
		return FALSE
	user.visible_message(span_green("[user] applies \the [src] on [M]."), span_green("You apply \the [src] on [M]."))
	M.heal_bodypart_damage(heal_brute)
	return TRUE

/* * * * * * * * * * * * * * * * * * *
 * Proc that actually does the healing
 * * * * * * * * * * * * * * * * * * */
/obj/item/stack/medical/proc/heal_carbon(mob/living/carbon/C, mob/living/user)
	if(!iscarbon(C) || !user)
		return FALSE
	if(is_healing)
		user.show_message(span_alert("You're already doing something with this!"))
		return
	if(!user.can_inject(C, TRUE))
		return
	
	var/list/output_list = pick_a_bodypart(C, user)
	if(!islist(output_list))
		to_chat(user, span_phobia("Uh oh! [src] didnt return a list! This is a bug, probably! Report this pls~ =3"))
		return FALSE
	if(!istype(output_list["bodypart"], /obj/item/bodypart))
		if(output_list["bodypart"] == UNABLE_TO_HEAL)
			to_chat(user, span_warning("[C] wouldn't really benefit from \the [src]!"))
			return FALSE
		else
			to_chat(user, span_phobia("Uh oh! [src] somehow returned something that wasnt a bodypart! This is a bug, probably! Report this pls~ =3"))
			return FALSE

	var/obj/item/bodypart/affected_bodypart = output_list["bodypart"]
	var/heal_operations = output_list["operations"]
	do_medical_message(user, C, affected_bodypart, "start")
	is_healing = TRUE
	var/covering_output = null
	//var/is_skilled = 1
	if(start_sound)
		playsound(get_turf(user), start_sound, 50, 1, SOUND_DISTANCE(4))
	if(!do_mob(user, C, get_delay_time(user, C, 1), progress = TRUE))
		to_chat(user, span_warning("You were interrupted!"))
		is_healing = FALSE
		return
	is_healing = FALSE
	/// now we start doing 'healy' things!
	if(heal_operations & DO_HURT_DAMAGE) // Needle pierce flesh, ow ow ow
		if(affected_bodypart.receive_damage(hurt_brute * 1, sharpness = SHARP_NONE, wound_bonus = CANT_WOUND, damage_coverings = FALSE)) // as funny as it is to wound people with a suture, its buggy as fuck and breaks everything
			if(prob(50))
				C.emote("scream") // a
			C.update_damage_overlays()
	if(heal_operations & DO_HEAL_DAMAGE)
		if(affected_bodypart.heal_damage(heal_brute, heal_burn, (heal_brute + heal_burn), updating_health = TRUE))
			C.update_damage_overlays()
	/* if(heal_operations & DO_UNBLEED_WOUND)
		for(var/datum/wound/wounds_to_unbleed in affected_bodypart.wounds)
			if(wounds_to_unbleed.blood_flow)
				wounds_to_unbleed.treat_bleed(src, user, (user == C), is_skilled ? 1 : unskilled_effectiveness_mult)
				break */
	if(heal_operations & DO_UNBURN_WOUND)
		for(var/datum/wound/burn/wounds_to_unburn in affected_bodypart.wounds)
			if(wounds_to_unburn.flesh_damage || wounds_to_unburn.infestation)
				wounds_to_unburn.treat_burn(src, user, (user == C))
				break
	if(heal_operations & DO_APPLY_BANDAGE)
		covering_output = affected_bodypart.apply_gauze(src, 1)
	if(heal_operations & DO_APPLY_SUTURE)
		covering_output = affected_bodypart.apply_suture(src, 1)

	if(end_sound)
		playsound(get_turf(user), end_sound, 50, 1, SOUND_DISTANCE(4))
	do_medical_message(user, C, affected_bodypart, "end", 1, covering_output)
	return TRUE

/// Returns if the user is skilled enough to use this thing effectively (unused, currently)
/obj/item/stack/medical/proc/is_skilled_enough(mob/user, mob/target)
	return NO_SKILLS_REQUIRED
/* 	if(!needed_trait)
		return NO_SKILLS_REQUIRED
	if(HAS_TRAIT(user, needed_trait))
		return USER_HAS_THE_SKILLS
	if(HAS_TRAIT(target, needed_trait)) // doc's walking you through it
		return VICTIM_HAS_THE_SKILLS

	switch(needed_trait)
		if(TRAIT_SURGERY_LOW)
			if(HAS_TRAIT(user, TRAIT_SURGERY_LOW) || HAS_TRAIT(user, TRAIT_SURGERY_MID) || HAS_TRAIT(user, TRAIT_SURGERY_HIGH))
				return USER_HAS_THE_SKILLS
			if(HAS_TRAIT(target, TRAIT_SURGERY_LOW) || HAS_TRAIT(target, TRAIT_SURGERY_MID)|| HAS_TRAIT(target, TRAIT_SURGERY_HIGH))
				return VICTIM_HAS_THE_SKILLS
		if(TRAIT_SURGERY_MID)
			if(HAS_TRAIT(user, TRAIT_SURGERY_MID) || HAS_TRAIT(user, TRAIT_SURGERY_HIGH))
				return USER_HAS_THE_SKILLS
			if(HAS_TRAIT(target, TRAIT_SURGERY_MID)|| HAS_TRAIT(target, TRAIT_SURGERY_HIGH))
				return VICTIM_HAS_THE_SKILLS
		if(TRAIT_SURGERY_HIGH)
			if(HAS_TRAIT(user, TRAIT_SURGERY_HIGH))
				return USER_HAS_THE_SKILLS
			if(HAS_TRAIT(target, TRAIT_SURGERY_HIGH))
				return VICTIM_HAS_THE_SKILLS */


/// returns how long it should take to use this thing
/obj/item/stack/medical/proc/get_delay_time(mob/user, mob/target, is_skilled = TRUE)
	. = other_delay
	if(user == target)
		. = self_delay
	if(!is_skilled)
		. *= unskilled_speed_mult

/* * * * * * * * * * * * * * * * * * *
 * Outputs a message at the start or end of use
 */
/obj/item/stack/medical/proc/do_medical_message(mob/user, mob/target, obj/item/bodypart/part, which_message, is_skilled, bandage_code)
	if(!user || !target)
		return
	var/target_part = istype(part) ? "[part.name]" : "wounds"
	switch(which_message)
		if("start")
			user.visible_message(
				span_warning("[user] begins applying \a [src] to [target]'s [target_part]..."), 
				span_warning("You begin applying \a [src] to [user == target ? "your" : "[target]'s"] [target_part]..."))
/*			if(is_skilled && is_skilled != NO_SKILLS_REQUIRED)
				switch(needed_trait)
					if(TRAIT_SURGERY_LOW)
						if(is_skilled == USER_HAS_THE_SKILLS)
							user.show_message(span_green("Your first aid training helps you breeze through this!"))
						else
							user.show_message(span_green("[target]'s first aid training steadies your hand and helps you work!"))
					if(TRAIT_SURGERY_MID)
						if(is_skilled == USER_HAS_THE_SKILLS)
							user.show_message(span_green("Your medical training makes this easy as could be!"))
						else
							user.show_message(span_green("[target]'s medical training inspires you to steady your hand!"))
					if(TRAIT_SURGERY_HIGH)
						if(is_skilled == USER_HAS_THE_SKILLS)
							user.show_message(span_green("It's an advanced procedure, but well within your skillset!"))
						else
							user.show_message(span_green("[target] is a well versed surgeon, and that fact steadies your hand!")) */

		if("end")
			if(isnull(bandage_code))
				user.visible_message(
					span_green("[user] applies \a [src] to [target]'s [target_part]."), 
					span_green("You apply \a [src] to [user == target ? "your" : "[target]'s"] [target_part]."))
			else
				if(bandage_code & BANDAGE_NEW_APPLIED)
					user.visible_message(
						span_green("[user] applies a fresh new [src] to [target]'s [target_part]!"), 
						span_green("You apply a fresh new [src] to [user == target ? "your" : "[target]'s"] [target_part]!"))
				if(bandage_code & BANDAGE_WAS_REPAIRED)
					user.visible_message(
						span_green("[user] fixes up the bandages on [target]'s [target_part] with [src]!"), 
						span_green("You fix up the bandages on [user == target ? "your" : "[target]'s"] [target_part] with [src]!"))
				if(bandage_code & BANDAGE_WAS_REPAIRED_TO_FULL)
					user.visible_message(
						span_green("[user] fixes up the bandages on [target]'s [target_part] with [src], repairing them completely!"), 
						span_green("You fix up the bandages on [user == target ? "your" : "[target]'s"] [target_part] with [src], repairing them completely!"))
				if(bandage_code & BANDAGE_TIMER_REFILLED)
					user.visible_message(
						span_green("[user] freshens up the bandages on [target]'s [target_part] with [src]!"), 
						span_green("You freshen up the bandages on [user == target ? "your" : "[target]'s"] [target_part] with [src]!"))
				
				if(bandage_code & SUTURE_NEW_APPLIED)
					user.visible_message(
						span_green("[user] applies a fresh new set of [src] to [target]'s [target_part]!"), 
						span_green("You apply a fresh new set of [src] to [user == target ? "your" : "[target]'s"] [target_part]!"))
				if(bandage_code & SUTURE_WAS_REPAIRED)
					user.visible_message(
						span_green("[user] reinforces the sutures on [target]'s [target_part] with [src]!"), 
						span_green("You reinforce the sutures on [user == target ? "your" : "[target]'s"] [target_part] with [src]!"))
				if(bandage_code & SUTURE_WAS_REPAIRED_TO_FULL)
					user.visible_message(
						span_green("[user] reinforces the sutures on [target]'s [target_part] with [src], repairing them completely!"), 
						span_green("You reinforce the sutures on [user == target ? "your" : "[target]'s"] [target_part] with [src], repairing them completely!"))
				if(bandage_code & SUTURE_TIMER_REFILLED)
					user.visible_message(
						span_green("[user] freshens up the sutures on [target]'s [target_part] with [src]!"), 
						span_green("You freshen up the sutures on [user == target ? "your" : "[target]'s"] [target_part] with [src]!"))

/obj/item/stack/medical/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

///Override this proc for special post heal effects.
/obj/item/stack/medical/proc/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	return

/obj/item/stack/medical/bruise_pack
	name = "medical pack"
	singular_name = "medical pack"
	desc = "A self-contained medical kit, containing therapeutic gel packs and bandages designed to treat blunt-force trauma and burns. Seems the instructions are missing."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	//needed_trait = TRAIT_SURGERY_LOW
	heal_brute = 30
	heal_burn = 30
	self_delay = 40
	other_delay = 20
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10, /datum/reagent/medicine/silver_sulfadiazine = 10)
	merge_type = /obj/item/stack/medical/bruise_pack

/obj/item/stack/medical/bruise_pack/lick
	name = "healing saliva"
	singular_name = "healing saliva"
	desc = "A fresh coating of somehow medicinal saliva, good for soothing shallow injuries. Not the best of treatments, but somehow better than nothing."
	icon_state = "brutepack"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	//needed_trait = TRAIT_SURGERY_LOW
	infinite_uses = TRUE
	heal_brute = 1
	heal_burn = 1
	self_delay = 1 SECONDS
	other_delay = 1 SECONDS
	end_sound = 'sound/effects/lick.ogg'
	grind_results = list(/datum/reagent/medicine/styptic_powder = 10, /datum/reagent/medicine/silver_sulfadiazine = 10)
	merge_type = /obj/item/stack/medical/bruise_pack/lick

/obj/item/stack/medical/bruise_pack/lick/do_medical_message(mob/user, mob/target, obj/item/bodypart/part, which_message, is_skilled, bandage_code)
	if(!user || !target)
		return
	var/target_part = istype(part) ? "[part.name]" : "wounds"
	switch(which_message)
		if("start")
			user.visible_message(
				span_notice("[user] starts lapping at [target]'s [target_part]..."), 
				span_notice("You lick at [user == target ? "your" : "[target]'s"] [target_part]..."))

		if("end")
			user.visible_message(
				span_green("[user] lick [target]'s [target_part]!"), 
				span_green("You lick [user == target ? "your" : "[target]'s"] [target_part]!"))

/obj/item/stack/medical/bruise_pack/one
	amount = 1

/obj/item/stack/medical/bruise_pack/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is bludgeoning [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)

/* * * * * *
 * BANDAGES
 * * * * * */

/* * * * * * * * * * * * * * * * * * *
 * + Quick to apply
 * + Low skill needed
 * + Prevents further blood loss 
 * + Heals a little brute and burn
 * - Doesnt stop bleeding on its own
 * - Falls apart easily
 * * * * * * * * * * * * * * * * * * */

/// Mid tier bandage
/obj/item/stack/medical/gauze
	name = "medical bandages"
	desc = "A roll of elastic cloth. Use it to staunch and heal bleeding and burns, and treat infection."
	icon_state = "gauze"
	singular_name = "medical bandage"
	gender = PLURAL
	covering_hitpoints = 3
	heal_brute = 0
	heal_burn = 0
	heal_per_tick = BANDAGE_NORMAL_HEAL_OVER_TIME
	//heal_over_time_per_tick = BANDAGE_NORMAL_HEAL_RATE
	bandage_power = BANDAGE_GOOD_WOUND_CLOSURE
	bandage_staunch = WOUND_BLEED_BANDAGE_MULTIPLIER
	max_bandage_healing = BANDAGE_GOOD_WOUND_MAX
	self_delay = 30
	other_delay = 10
	amount = 10
	max_amount = 10
	is_bandage = TRUE
	covering_lifespan = BANDAGE_OKAY_MAX_DURATION
	//absorption_rate = 0.45
	//absorption_capacity = 10
	//is_bandage = 3
	splint_factor = 0.35
	custom_price = PRICE_REALLY_CHEAP
	grind_results = list(/datum/reagent/cellulose = 2)
	merge_type = /obj/item/stack/medical/gauze

/obj/item/stack/medical/gauze/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_WIRECUTTER || I.get_sharpness())
		if(get_amount() < 2)
			to_chat(user, span_warning("You need at least two gauzes to do this!"))
			return
		new /obj/item/stack/sheet/cloth(user.drop_location())
		user.visible_message("[user] cuts [src] into pieces of cloth with [I].", \
					span_notice("You cut [src] into pieces of cloth with [I]."), \
					"You hear cutting.")
		use(2)
	else if(I.is_drainable() && I.reagents.has_reagent(/datum/reagent/abraxo_cleaner/sterilizine))
		if(!I.reagents.has_reagent(/datum/reagent/abraxo_cleaner/sterilizine, 10))
			to_chat(user, span_warning("There's not enough sterilizine in [I] to sterilize [src]!"))
			return
		user.visible_message(span_notice("[user] pours the contents of [I] onto [src], sterilizing it."), span_notice("You pour the contents of [I] onto [src], sterilizing it."))
		I.reagents.remove_reagent(/datum/reagent/abraxo_cleaner/sterilizine, 10)
		new /obj/item/stack/medical/gauze/adv/one(user.drop_location())
		use(1)
	else
		return ..()

/obj/item/stack/medical/gauze/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] begins tightening \the [src] around [user.p_their()] neck! It looks like [user.p_they()] forgot how to use medical supplies!"))
	return OXYLOSS

/// Low tier bandage
/obj/item/stack/medical/gauze/improvised
	name = "improvised bandages"
	singular_name = "improvised bandage"
	desc = "A roll of cloth. Useful for staunching bleeding, healing bruises and burns, as well as reversing infection. Sort of."
	covering_hitpoints = 1 // fragile!
	heal_brute = 0
	heal_burn = 0
	heal_per_tick = BANDAGE_IMPROVISED_HEAL_OVER_TIME
	//heal_over_time_per_tick = BANDAGE_IMPROVISED_HEAL_RATE
	self_delay = 30
	other_delay = 10
	bandage_power = BANDAGE_BASE_WOUND_CLOSURE
	max_bandage_healing = BANDAGE_BASE_WOUND_MAX
	is_bandage = TRUE
	covering_lifespan = BANDAGE_POOR_MAX_DURATION
	merge_type = /obj/item/stack/medical/gauze/improvised

/obj/item/stack/medical/gauze/improvised/microwave_act(obj/machinery/microwave/MW)
	..()
	new /obj/item/stack/medical/gauze(drop_location(), amount)
	qdel(src)

/// High tier bandage
/// needs some training to use properly
/obj/item/stack/medical/gauze/adv
	name = "sterilized medical bandages"
	singular_name = "sterilized medical bandage"
	desc = "A roll of durable elastic sterilized cloth that is extremely effective at stopping bleeding and covering burns. Somewhat awkward to use without training."
	covering_hitpoints = 5
	heal_brute = 0
	heal_brute = 0
	self_delay = 10
	other_delay = 10
	heal_per_tick = BANDAGE_MEDICAL_HEAL_OVER_TIME
	//heal_over_time_per_tick = BANDAGE_MEDICAL_HEAL_RATE
	bandage_power = BANDAGE_BEST_WOUND_CLOSURE
	max_bandage_healing = BANDAGE_BEST_WOUND_MAX
	is_bandage = TRUE
	//needed_trait = TRAIT_SURGERY_LOW
	//absorption_rate = 0.4
	//absorption_capacity = 15
	covering_lifespan = BANDAGE_GOOD_MAX_DURATION
	merge_type = /obj/item/stack/medical/gauze/adv

/obj/item/stack/medical/gauze/adv/one
	amount = 1

/obj/item/stack/medical/gauze/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250
	merge_type = /obj/item/stack/medical/gauze/cyborg

/// ...
/obj/item/stack/medical/gauze/lick
	name = "coagulating saliva"
	desc = "A fresh coating of somehow medicinal saliva, good for slowing the blood flow on a wound. Not the best of treatments, but somehow better than nothing."
	icon_state = "gauze"
	singular_name = "coagulating saliva"
	gender = PLURAL
	covering_hitpoints = 1
	heal_brute = 0
	heal_burn = 0
	heal_per_tick = 0
	//heal_over_time_per_tick = BANDAGE_NORMAL_HEAL_RATE
	bandage_power = BANDAGE_GOOD_WOUND_CLOSURE
	bandage_staunch = WOUND_BLEED_LICK_MULTIPLIER
	self_delay = 50
	other_delay = 20
	amount = 1
	max_amount = 1
	is_bandage = TRUE
	end_sound = 'sound/effects/lick.ogg'
	covering_lifespan = LICK_MAX_DURATION
	splint_factor = 0.35
	custom_price = PRICE_REALLY_CHEAP
	grind_results = null
	merge_type = /obj/item/stack/medical/gauze/lick

/* * * * * *
 * SUTURES
 * * * * * */

/* * * * * * * * * * * * * * * * * * *
 * + Actually reduces bleeding on use
 * ! Best used with bandages on them
 * - Slow to apply
 * - High skill needed
 * - Doesnt stop blood loss immediately
 * - Hurts a little brute to use
 * * * * * * * * * * * * * * * * * * */

/// Mid tier suture
/obj/item/stack/medical/suture
	name = "sutures"
	desc = "Basic sterile sutures used to seal up cuts and lacerations and stop bleeding. Painful, but ought to do the trick. Requires mid-level medical training to use effectively."
	gender = PLURAL
	singular_name = "suture"
	icon_state = "suture"
	//needed_trait = TRAIT_SURGERY_MID
	covering_hitpoints = 3
	self_delay = 80
	other_delay = 60
	amount = 15
	max_amount = 15
	hurt_brute = 3
	heal_per_tick = SUTURE_NORMAL_HEAL_OVER_TIME
	//heal_over_time_per_tick = SUTURE_NORMAL_HEAL_RATE
	suture_power = SUTURE_GOOD_WOUND_CLOSURE
	covering_lifespan = SUTURE_OKAY_MAX_DURATION
	is_suture = TRUE
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)
	merge_type = /obj/item/stack/medical/suture

/obj/item/stack/medical/suture/one
	amount = 1

/obj/item/stack/medical/suture/five
	amount = 5

/// Low tier suture - usable by anyone, but they suuuuuuuuck
/// better have some bandages
/obj/item/stack/medical/suture/emergency
	name = "improvised sutures"
	icon_state = "suture_imp"
	desc = "A set of improvised sutures consisting of clothing thread and a sewing needle. Liable to tear up your flesh, but will eventually close up minor bleeds. Medical training won't help you with this."
	//needed_trait = null
	covering_hitpoints = 1
	hurt_brute = 8 // Owie
	self_delay = 100
	other_delay = 80
	amount = 5
	max_amount = 15
	heal_per_tick = SUTURE_IMPROVISED_HEAL_OVER_TIME
	//heal_over_time_per_tick = SUTURE_IMPROVISED_HEAL_RATE
	covering_lifespan = SUTURE_POOR_MAX_DURATION
	suture_power = SUTURE_BASE_WOUND_CLOSURE
	is_suture = TRUE
	merge_type = /obj/item/stack/medical/suture/emergency

/obj/item/stack/medical/suture/emergency/five
	amount = 5

/obj/item/stack/medical/suture/emergency/ten
	amount = 10

/obj/item/stack/medical/suture/emergency/fifteen
	amount = 15

/// High tier sutures
/// Actually heals you too, but needs a real doc
/obj/item/stack/medical/suture/medicated
	name = "advanced medicated sutures"
	icon_state = "suture_purp"
	desc = "An advanced suture and ultra-sharp needle, both infused with specialized coagulants and painkillers that make for a quick and painless wound treatment. It's very delicate and requires extensive medical training to use effectively."
	//needed_trait = TRAIT_SURGERY_HIGH
	covering_hitpoints = 5
	self_delay = 80
	other_delay = 60
	heal_brute = 3
	heal_burn = 3
	heal_per_tick = SUTURE_MEDICAL_HEAL_OVER_TIME
	//heal_over_time_per_tick = SUTURE_MEDICAL_HEAL_RATE
	covering_lifespan = SUTURE_GOOD_MAX_DURATION
	suture_power = SUTURE_GOOD_WOUND_CLOSURE
	is_suture = TRUE
	grind_results = list(/datum/reagent/medicine/polypyr = 2)
	merge_type = /obj/item/stack/medical/suture/medicated

/obj/item/stack/medical/ointment
	name = "ointment"
	desc = "Basic burn ointment, rated effective for second degree burns with proper bandaging. Not very effective at treating infection, but better than nothing. USE WITH A BANDAGE."
	gender = PLURAL
	singular_name = "ointment"
	icon_state = "ointment"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	amount = 12
	max_amount = 12
	self_delay = 40
	other_delay = 20
	merge_type = /obj/item/stack/medical/ointment

	heal_burn = 5
	flesh_regeneration = 7
	sanitization = 2
	grind_results = list(/datum/reagent/medicine/kelotane = 10)

/obj/item/stack/medical/ointment/five
	amount = 5

/obj/item/stack/medical/ointment/twelve
	amount = 12

/obj/item/stack/medical/ointment/heal(mob/living/M, mob/user)
	if(iscarbon(M))
		return heal_carbon(M, user, heal_brute, heal_burn)
	to_chat(user, span_warning("You can't heal [M] with \the [src]!"))

/obj/item/stack/medical/ointment/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] is squeezing \the [src] into [user.p_their()] mouth! [user.p_do(TRUE)]n't [user.p_they()] know that stuff is toxic?"))
	return TOXLOSS

/obj/item/stack/medical/mesh
	name = "regenerative mesh"
	desc = "An advanced bacteriostatic mesh used to dress burns and sanitize burns. Also removes infection directly, unlike ointment. Best for severe burns. This is the kind of thing you would expect to see in a pre-war hospital."
	gender = PLURAL
	singular_name = "regenerative mesh"
	icon_state = "regen_mesh"
	self_delay = 30
	other_delay = 10
	amount = 15
	max_amount = 15
	heal_burn = 10
	sanitization = 2
	flesh_regeneration = 6
	var/is_open = TRUE ///This var determines if the sterile packaging of the mesh has been opened.
	grind_results = list(/datum/reagent/medicine/spaceacillin = 2)
	merge_type = /obj/item/stack/medical/mesh

/obj/item/stack/medical/mesh/one
	amount = 1

/obj/item/stack/medical/mesh/five
	amount = 5

/obj/item/stack/medical/mesh/advanced
	name = "advanced regenerative mesh"
	desc = "An advanced mesh made with aloe extracts and sterilizing chemicals, used for the most critical burns. Also removes infection directly, unlike ointment. This is the kind of thing you would expect to see in a pre-war hospital for rich people."
	gender = PLURAL
	singular_name = "advanced regenerative mesh"
	icon_state = "aloe_mesh"
	heal_burn = 15
	sanitization = 6
	flesh_regeneration = 12
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)
	merge_type = /obj/item/stack/medical/mesh/advanced

/obj/item/stack/medical/mesh/advanced/one
	amount = 1

/obj/item/stack/medical/mesh/Initialize()
	. = ..()
	if(amount == max_amount)	 //only seal full mesh packs
		is_open = FALSE
		update_icon()

/obj/item/stack/medical/mesh/advanced/update_icon_state()
	if(!is_open)
		icon_state = "aloe_mesh_closed"
	else
		return ..()

/obj/item/stack/medical/mesh/update_icon_state()
	if(!is_open)
		icon_state = "regen_mesh_closed"
	else
		return ..()

/obj/item/stack/medical/mesh/try_heal(mob/living/M, mob/user, silent = FALSE)
	if(!is_open)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/AltClick(mob/living/user)
	if(!is_open)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(!is_open && user.get_inactive_held_item() == src)
		to_chat(user, span_warning("You need to open [src] first."))
		return
	. = ..()

/obj/item/stack/medical/mesh/attack_self(mob/user)
	if(!is_open)
		is_open = TRUE
		to_chat(user, span_notice("You open the sterile mesh package."))
		update_icon()
		playsound(src, 'sound/items/poster_ripped.ogg', 20, TRUE)
		return
	. = ..()

/obj/item/stack/medical/bone_gel
	name = "bone gel"
	singular_name = "bone gel"
	desc = "A potent medical gel that, when applied to a damaged bone in a proper surgical setting, triggers an intense melding reaction to repair the wound. Can be directly applied alongside surgical sticky tape to a broken bone in dire circumstances, though this is very harmful to the patient and not recommended."

	icon = 'icons/obj/surgery.dmi'
	icon_state = "bone-gel"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	amount = 4
	self_delay = 20
	grind_results = list(/datum/reagent/medicine/bicaridine = 10)
	novariants = TRUE

/obj/item/stack/medical/bone_gel/attack(mob/living/M, mob/user)
	to_chat(user, span_warning("Bone gel can only be used on fractured limbs while aggressively holding someone!"))
	return

/obj/item/stack/medical/bone_gel/suicide_act(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.visible_message(span_suicide("[C] is squirting all of \the [src] into [C.p_their()] mouth! That's not proper procedure! It looks like [C.p_theyre()] trying to commit suicide!"))
		if(do_after(C, 2 SECONDS))
			C.emote("scream")
			for(var/i in C.bodyparts)
				var/obj/item/bodypart/bone = i
				var/datum/wound/blunt/severe/oof_ouch = new
				oof_ouch.apply_wound(bone)
				var/datum/wound/blunt/critical/oof_OUCH = new
				oof_OUCH.apply_wound(bone)

			for(var/i in C.bodyparts)
				var/obj/item/bodypart/bone = i
				bone.receive_damage(brute=60)
			use(1)
			return (BRUTELOSS)
		else
			C.visible_message(span_suicide("[C] screws up like an idiot and still dies anyway!"))
			return (BRUTELOSS)

/obj/item/stack/medical/bone_gel/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250
	merge_type = /obj/item/stack/medical/bone_gel/cyborg

/obj/item/stack/medical/mesh/aloe
	name = "aloe cream"
	desc = "A healing paste you can apply on wounds."

	icon_state = "aloe_paste"
	self_delay = 20
	other_delay = 10
	novariants = TRUE
	heal_burn = 10
	amount = 20
	max_amount = 20
	grind_results = list(/datum/reagent/consumable/aloejuice = 1)

/obj/item/stack/medical/mesh/aloe/Initialize()
	. = ..()
	if(amount == max_amount)	 //aloe starts open lol
		is_open = TRUE
		update_icon()


// ------------------
// MOURNING DUST   (should be repathed to be less misleading at some point)
// ------------------

/obj/item/stack/medical/poultice
	name = "mourning dust"
	singular_name = "mourning dust"
	desc = "A type of primitive herbal powder.\nWhile traditionally used to prepare corpses for the mourning feast, it can also treat scrapes and burns on the living, however, it is liable to cause shortness of breath when employed in this manner.\nIt is imbued with ancient wisdom."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "mourningdust"
	amount = 15
	max_amount = 15
	heal_brute = 10
	heal_burn = 10
	self_delay = 40
	other_delay = 10
	merge_type = /obj/item/stack/medical/poultice
	novariants = TRUE

/obj/item/stack/medical/poultice/ten
	amount = 10

/obj/item/stack/medical/poultice/five
	amount = 5

/obj/item/stack/medical/poultice/post_heal_effects(amount_healed, mob/living/carbon/healed_mob, mob/user)
	. = ..()
	healed_mob.adjustOxyLoss(amount_healed)

/datum/chemical_reaction/mourningpoultice
	name = "mourning dust"
	id = "mourningdust"
	required_reagents = list(/datum/reagent/consumable/tea/coyotetea = 10, /datum/reagent/cellulose = 20, /datum/reagent/consumable/tea/feratea = 10)
	mob_react = FALSE

/datum/chemical_reaction/mourningpoultice/on_reaction(datum/reagents/holder, multiplier)
	var/location = get_turf(holder.my_atom)
	for(var/i = 1, i <= multiplier, i++)
		new /obj/item/stack/medical/poultice/five(location)
