

//NOTE: Breathing happens once per FOUR TICKS, unless the last breath fails. In which case it happens once per ONE TICK! So oxyloss healing is done once per 4 ticks while oxyloss damage is applied once per tick!

// bitflags for the percentual amount of protection a piece of clothing which covers the body part offers.
// Used with human/proc/get_thermal_protection()
// The values here should add up to 1.
// Hands and feet have 2.5%, arms and legs 7.5%, each of the torso parts has 15% and the head has 30%
#define THERMAL_PROTECTION_HEAD			0.3
#define THERMAL_PROTECTION_CHEST		0.15
#define THERMAL_PROTECTION_GROIN		0.15
#define THERMAL_PROTECTION_LEG_LEFT		0.075
#define THERMAL_PROTECTION_LEG_RIGHT	0.075
#define THERMAL_PROTECTION_FOOT_LEFT	0.025
#define THERMAL_PROTECTION_FOOT_RIGHT	0.025
#define THERMAL_PROTECTION_ARM_LEFT		0.075
#define THERMAL_PROTECTION_ARM_RIGHT	0.075
#define THERMAL_PROTECTION_HAND_LEFT	0.025
#define THERMAL_PROTECTION_HAND_RIGHT	0.025

/mob/living/carbon/human/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	handle_active_genes()
	//heart attack stuff
	handle_heart()
	dna.species.spec_life(src) // for mutantraces
	handle_crit()
	return (stat != DEAD) && !QDELETED(src)

/mob/living/carbon/human/PhysicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	//Update our name based on whether our face is obscured/disfigured
	name = get_visible_name()

/mob/living/carbon/human/calculate_affecting_pressure(pressure)
	var/headless = !get_bodypart(BODY_ZONE_HEAD) //should the mob be perennially headless (see dullahans), we only take the suit into account, so they can into space.
	if (wear_suit && istype(wear_suit, /obj/item/clothing) && (headless || (head && istype(head, /obj/item/clothing))))
		var/obj/item/clothing/CS = wear_suit
		var/obj/item/clothing/CH = head
		if (CS.clothing_flags & STOPSPRESSUREDAMAGE && (headless || (CH.clothing_flags & STOPSPRESSUREDAMAGE)))
			return ONE_ATMOSPHERE
	return ..()


/mob/living/carbon/human/proc/handle_crit()
	if(HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
		return FALSE
	if(health > crit_threshold) // if we're above crit, we're not in crit
		// handle_agony(src)
		return FALSE
	// welcome to crit! We're gonna make your life suck until you unsuck it
	var/die_at = abs(HEALTH_THRESHOLD_DEAD)
	var/total_crit_hp = crit_threshold + die_at // 200 + 0 = 200
	var/hp_below_crit = total_crit_hp - (health + die_at) // 200 - (-30 + 200) = 30 hp below crit
	var/crit_percent = hp_below_crit / total_crit_hp // 30 / 200 = 0.15
	var/is_bandaged_enuf = injury_bandage_proportion() > crit_percent
	/// first, update the deepest crit we've gone
	crit_agony = max(crit_percent, crit_agony) // its actually a number 0-1
	/// Now, mess em up, if we can
	if(COOLDOWN_FINISHED(src, crit_damage_cd))
		if(is_bandaged_enuf && prob(150 * crit_percent))
			apply_damage(2 * crit_percent, pick(BRUTE, BURN), BODY_ZONE_CHEST, 0, src, FALSE, FALSE, sendsignal = FALSE)
			COOLDOWN_START(src, crit_damage_cd, 10 SECONDS)
	if(COOLDOWN_FINISHED(src, crit_bleed_cd))
		if(is_bandaged_enuf && prob(100 * crit_percent))
			COOLDOWN_START(src, crit_bleed_cd, 20 SECONDS)
			if(!can_bleed()) // why cant they bleed?
				apply_damage(2 * crit_percent, BRUTE, BODY_ZONE_CHEST, 0, src, FALSE, FALSE, sendsignal = FALSE)
			else
				if(is_bleeding())
					to_chat(src, span_danger("You feel a clot dislodge, spraying blood all over!"))
					aggravate_wound(crit_percent)
				else
					apply_damage(2 * crit_percent, OXY, BODY_ZONE_CHEST, 0, src, FALSE, FALSE, sendsignal = FALSE)
	if(COOLDOWN_FINISHED(src, crit_faint_cd))
		if(is_bandaged_enuf && prob(100 * crit_percent))
			var/sleeptime = 10 SECONDS * crit_percent
			COOLDOWN_START(src, crit_faint_cd, rand(15 SECONDS, 45 SECONDS) + sleeptime)
			if(HAS_TRAIT(src, TRAIT_SLEEPIMMUNE))
				drop_all_held_items()
			else
				AdjustSleeping(sleeptime)
				to_chat(src, span_danger("You feel faint and collapse!"))

/mob/living/carbon/human/proc/can_bleed()
	var/list/implies_nonbleedable = list(
		NOBLOOD,
		ROBOTIC_LIMBS,
	)
	var/datum/species/S = dna.species
	if(S)
		for(var/traint in S.species_traits)
			if(traint in implies_nonbleedable)
				return FALSE
		var/list/implies_bleedable = list(
			HAS_FLESH,
		)
		var/notableed = TRUE
		for(var/traint in S.species_traits)
			if(traint in implies_bleedable)
				notableed = FALSE
		if(notableed)
			return FALSE
	if(HAS_TRAIT(src, TRAIT_NOBREATH))
		return FALSE
	return TRUE // *in theory*

// GLOBAL_LIST_EMPTY(agony_cache) // todo: this

// /datum/species/proc/handle_agony(mob/living/carbon/human/src)
// 	if(crit_agony <= CRIT_AGONY_THRESHOLD)
// 		return
// 	var/how_bad = CRIT_AGONY_NONE
// 	switch(crit_agony)
// 		if(-INFINITY to CRIT_AGONY_THRESHOLD)
// 			return
// 		if(CRIT_AGONY_THRESHOLD to CRIT_AGONY_THRESHOLD_LIGHT)
// 			how_bad = CRIT_AGONY_LIGHT
// 		if(CRIT_AGONY_THRESHOLD_LIGHT to CRIT_AGONY_THRESHOLD_MAJOR)
// 			how_bad = CRIT_AGONY_MAJOR
// 		if(CRIT_AGONY_THRESHOLD_MAJOR to CRIT_AGONY_THRESHOLD_CATASTROPHIC)
// 			how_bad = CRIT_AGONY_CATASTROPHIC
// 		else
// 			how_bad = CRIT_AGONY_DIED
// 	if(!LAZYLEN(GLOB.agony_cache))
// 		for(var/pain in subtypesof(/datum/agony))
// 			var/datum/agony/AAA = pain
// 			GLOB.agony_cache |= new AAA()
// 	var/list/eligable_agonies = list()


/mob/living/carbon/human/handle_traits()
	if(eye_blind)			//blindness, heals slowly over time
		if(HAS_TRAIT_FROM(src, TRAIT_BLIND, EYES_COVERED)) //covering your eyes heals blurry eyes faster
			adjust_blindness(-3)
		else
			adjust_blindness(-1)
	else if(eye_blurry)			//blurry eyes heal slowly
		adjust_blurriness(-1)

	if (getOrganLoss(ORGAN_SLOT_BRAIN) >= 30) //Citadel change to make memes more often.
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "brain_damage", /datum/mood_event/brain_damage)
		if(prob(1))
			to_chat(src, span_warning("Your head feels numb and painful."))
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "brain_damage")

/mob/living/carbon/human/handle_mutations_and_radiation()
	if(!dna || !dna.species.handle_mutations_and_radiation(src))
		..()

///FIRE CODE
/mob/living/carbon/human/handle_fire()
	if(!last_fire_update)
		last_fire_update = fire_stacks
	if((fire_stacks > HUMAN_FIRE_STACK_ICON_NUM && last_fire_update <= HUMAN_FIRE_STACK_ICON_NUM) || (fire_stacks <= HUMAN_FIRE_STACK_ICON_NUM && last_fire_update > HUMAN_FIRE_STACK_ICON_NUM))
		last_fire_update = fire_stacks
		update_fire()

	..()
	if(dna)
		dna.species.handle_fire(src)

/mob/living/carbon/human/proc/easy_thermal_protection()
	var/thermal_protection = 0 //Simple check to estimate how protected we are against multiple temperatures
	if(wear_suit)
		if(wear_suit.max_heat_protection_temperature >= FIRE_SUIT_MAX_TEMP_PROTECT)
			thermal_protection += (wear_suit.max_heat_protection_temperature*0.7)
	if(head)
		if(head.max_heat_protection_temperature >= FIRE_HELM_MAX_TEMP_PROTECT)
			thermal_protection += (head.max_heat_protection_temperature*THERMAL_PROTECTION_HEAD)
	thermal_protection = round(thermal_protection)
	return thermal_protection

/mob/living/carbon/human/IgniteMob()
	//If have no DNA or can be Ignited, call parent handling to light user
	//If firestacks are high enough
	if(!dna || dna.species.CanIgniteMob(src))
		return ..()
	. = FALSE //No ignition

/mob/living/carbon/human/ExtinguishMob()
	if(!dna || !dna.species.ExtinguishMob(src))
		last_fire_update = null
		..()
//END FIRE CODE

//This proc returns a number made up of the flags for body parts which you are protected on. (such as HEAD, CHEST, GROIN, etc. See setup.dm for the full list)
/mob/living/carbon/human/proc/get_heat_protection_flags(temperature) //Temperature is the temperature you're being exposed to.
	var/thermal_protection_flags = 0
	//Handle normal clothing
	if(head)
		if(head.max_heat_protection_temperature && head.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= head.heat_protection
	if(wear_suit)
		if(wear_suit.max_heat_protection_temperature && wear_suit.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= wear_suit.heat_protection
	if(w_uniform)
		if(w_uniform.max_heat_protection_temperature && w_uniform.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= w_uniform.heat_protection
	if(shoes)
		if(shoes.max_heat_protection_temperature && shoes.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= shoes.heat_protection
	if(gloves)
		if(gloves.max_heat_protection_temperature && gloves.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= gloves.heat_protection
	if(wear_mask)
		if(wear_mask.max_heat_protection_temperature && wear_mask.max_heat_protection_temperature >= temperature)
			thermal_protection_flags |= wear_mask.heat_protection

	return thermal_protection_flags

//See proc/get_heat_protection_flags(temperature) for the description of this proc.
/mob/living/carbon/human/proc/get_cold_protection_flags(temperature)
	var/thermal_protection_flags = 0
	//Handle normal clothing

	if(head)
		if(head.min_cold_protection_temperature && head.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= head.cold_protection
	if(wear_suit)
		if(wear_suit.min_cold_protection_temperature && wear_suit.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= wear_suit.cold_protection
	if(w_uniform)
		if(w_uniform.min_cold_protection_temperature && w_uniform.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= w_uniform.cold_protection
	if(shoes)
		if(shoes.min_cold_protection_temperature && shoes.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= shoes.cold_protection
	if(gloves)
		if(gloves.min_cold_protection_temperature && gloves.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= gloves.cold_protection
	if(wear_mask)
		if(wear_mask.min_cold_protection_temperature && wear_mask.min_cold_protection_temperature <= temperature)
			thermal_protection_flags |= wear_mask.cold_protection

	return thermal_protection_flags

/mob/living/carbon/human/proc/get_thermal_protection(temperature, cold = FALSE)
	if(cold)
		temperature = max(temperature, 2.7) //There is an occasional bug where the temperature is miscalculated in ares with a small amount of gas on them, so this is necessary to ensure that that bug does not affect this calculation. Space's temperature is 2.7K and most suits that are intended to protect against any cold, protect down to 2.0K.
	var/thermal_protection_flags = cold ? get_cold_protection_flags(temperature) : get_heat_protection_flags(temperature)
	var/missing_body_parts_flags = ~get_body_parts_flags()
	var/max_protection = 1
	if(missing_body_parts_flags) //I don't like copypasta as much as proc overhead. Do you want me to make these into a macro?
		DISABLE_BITFIELD(thermal_protection_flags, missing_body_parts_flags)
		if(missing_body_parts_flags & HEAD)
			max_protection -= THERMAL_PROTECTION_HEAD
		if(missing_body_parts_flags & CHEST)
			max_protection -= THERMAL_PROTECTION_CHEST
		if(missing_body_parts_flags & GROIN)
			max_protection -= THERMAL_PROTECTION_GROIN
		if(missing_body_parts_flags & LEG_LEFT)
			max_protection -= THERMAL_PROTECTION_LEG_LEFT
		if(missing_body_parts_flags & LEG_RIGHT)
			max_protection -= THERMAL_PROTECTION_LEG_RIGHT
		if(missing_body_parts_flags & FOOT_LEFT)
			max_protection -= THERMAL_PROTECTION_FOOT_LEFT
		if(missing_body_parts_flags & FOOT_RIGHT)
			max_protection -= THERMAL_PROTECTION_FOOT_RIGHT
		if(missing_body_parts_flags & ARM_LEFT)
			max_protection -= THERMAL_PROTECTION_ARM_LEFT
		if(missing_body_parts_flags & ARM_RIGHT)
			max_protection -= THERMAL_PROTECTION_ARM_RIGHT
		if(missing_body_parts_flags & HAND_LEFT)
			max_protection -= THERMAL_PROTECTION_HAND_LEFT
		if(missing_body_parts_flags & HAND_RIGHT)
			max_protection -= THERMAL_PROTECTION_HAND_RIGHT
		if(max_protection == 0) //Is it even a man if it doesn't have a body at all? Early return to avoid division by zero.
			return 1

	var/thermal_protection = 0
	if(thermal_protection_flags)
		if(thermal_protection_flags & HEAD)
			thermal_protection += THERMAL_PROTECTION_HEAD
		if(thermal_protection_flags & CHEST)
			thermal_protection += THERMAL_PROTECTION_CHEST
		if(thermal_protection_flags & GROIN)
			thermal_protection += THERMAL_PROTECTION_GROIN
		if(thermal_protection_flags & LEG_LEFT)
			thermal_protection += THERMAL_PROTECTION_LEG_LEFT
		if(thermal_protection_flags & LEG_RIGHT)
			thermal_protection += THERMAL_PROTECTION_LEG_RIGHT
		if(thermal_protection_flags & FOOT_LEFT)
			thermal_protection += THERMAL_PROTECTION_FOOT_LEFT
		if(thermal_protection_flags & FOOT_RIGHT)
			thermal_protection += THERMAL_PROTECTION_FOOT_RIGHT
		if(thermal_protection_flags & ARM_LEFT)
			thermal_protection += THERMAL_PROTECTION_ARM_LEFT
		if(thermal_protection_flags & ARM_RIGHT)
			thermal_protection += THERMAL_PROTECTION_ARM_RIGHT
		if(thermal_protection_flags & HAND_LEFT)
			thermal_protection += THERMAL_PROTECTION_HAND_LEFT
		if(thermal_protection_flags & HAND_RIGHT)
			thermal_protection += THERMAL_PROTECTION_HAND_RIGHT

	return round(thermal_protection/max_protection, 0.001)

/mob/living/carbon/human/handle_random_events()
	//Puke if toxloss is too high
	if(!stat)
		if(getToxLoss() >= 45 && nutrition > 20)
			lastpuke += prob(50)
			if(lastpuke >= 50) // about 25 second delay I guess
				vomit(20, toxic = TRUE)
				lastpuke = 0


/mob/living/carbon/human/has_smoke_protection()
	if(wear_mask)
		if(wear_mask.clothing_flags & BLOCK_GAS_SMOKE_EFFECT)
			return TRUE
	if(glasses)
		if(glasses.clothing_flags & BLOCK_GAS_SMOKE_EFFECT)
			return TRUE
	if(head && istype(head, /obj/item/clothing))
		var/obj/item/clothing/CH = head
		if(CH.clothing_flags & BLOCK_GAS_SMOKE_EFFECT)
			return TRUE
	return ..()

/mob/living/carbon/human/proc/handle_active_genes()
	if(HAS_TRAIT(src, TRAIT_MUTATION_STASIS))
		return
	for(var/datum/mutation/human/HM in dna.mutations)
		HM.on_life(src)

/mob/living/carbon/human/proc/handle_heart()
	var/we_breath = !HAS_TRAIT_FROM(src, TRAIT_NOBREATH, SPECIES_TRAIT)

	if(!undergoing_cardiac_arrest())
		return

	if(we_breath)
		adjustOxyLoss(8)
		Unconscious(80)
	// Tissues die without blood circulation
	adjustBruteLoss(2)




#undef THERMAL_PROTECTION_HEAD
#undef THERMAL_PROTECTION_CHEST
#undef THERMAL_PROTECTION_GROIN
#undef THERMAL_PROTECTION_LEG_LEFT
#undef THERMAL_PROTECTION_LEG_RIGHT
#undef THERMAL_PROTECTION_FOOT_LEFT
#undef THERMAL_PROTECTION_FOOT_RIGHT
#undef THERMAL_PROTECTION_ARM_LEFT
#undef THERMAL_PROTECTION_ARM_RIGHT
#undef THERMAL_PROTECTION_HAND_LEFT
#undef THERMAL_PROTECTION_HAND_RIGHT
