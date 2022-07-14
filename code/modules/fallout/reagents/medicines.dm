/* 
 * Stimpak Juice
 * Initial insta-heal
 * Some lingering heal over time
 * Heals either brute or burn per tick, whichever's higher
 * Overdose makes you barf stunlock yourself
 */
/datum/reagent/medicine/stimpak	// Supplemented by other chems within a stimpak
	name = "Stimfluid"
	description = "A cocktail of advanced medicines designed to rapidly heal wounds."
	reagent_state = LIQUID
	color = "#eb0000"
	taste_description = "numbness"
	metabolization_rate = 2.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	value = REAGENT_VALUE_COMMON
	ghoulfriendly = TRUE

// insta-heal on inject, 1 of each brute and burn per volume
/datum/reagent/medicine/stimpak/reaction_mob(mob/living/M, method=INJECT, reac_volume)
	if(iscarbon(M))
		if(M.stat == DEAD) // Doesnt work on the dead
			return
		if(method != INJECT) // Gotta be injected
			return
		if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
		if(M.getFireLoss())
			M.adjustFireLoss(-reac_volume)
	..()

// heals 1 damage of either brute or burn on life, whichever's higher
/datum/reagent/medicine/stimpak/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() > M.getFireLoss())	//Less effective at healing mixed damage types.
		M.adjustBruteLoss(-1*REAGENTS_EFFECT_MULTIPLIER)
	else
		M.adjustFireLoss(-1*REAGENTS_EFFECT_MULTIPLIER)
	. = TRUE
	..()

// Overdose makes you barflock yourself
/datum/reagent/medicine/stimpak/overdose_process(mob/living/carbon/M)
	if(M.disgust < 80)
		M.adjust_disgust(10)
	..()
	. = TRUE

/* 
 * Super Stimpak Juice
 * Initial insta-heal
 * Fixes up cuts like a weaker sanguirite
 * Overdose makes your heart die
 */

/datum/reagent/medicine/super_stimpak // Handles superior healing of the super stim cocktail, plus its wound recovery, stim sickness, and dangerous OD.
	name = "super stimfluid"
	description = "Advanced, potent healing chemicals."
	reagent_state = LIQUID
	color = "#e50d0d"
	taste_description = "numbness"
	metabolization_rate = 3 * REAGENTS_METABOLISM	// 50 seconds, same as poultice
	overdose_threshold = 40	// you can risk a second dose
	ghoulfriendly = TRUE
	var/clot_rate = 0.25
	var/clot_coeff_per_wound = 0.7

/datum/reagent/medicine/super_stimpak/reaction_mob(mob/living/M, method=INJECT, reac_volume)
	if(iscarbon(M))
		if(M.stat == DEAD)
			return
		if(method != INJECT)
			return
		if(M.getBruteLoss())
			M.adjustBruteLoss(-reac_volume)
		if(M.getFireLoss())
			M.adjustFireLoss(-reac_volume)
	..()

/// Slows you down and tells you that your heart's gonna get wrecked if you keep taking more
/datum/reagent/medicine/super_stimpak/on_mob_metabolize(mob/living/L) // Stim Sickness
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/super_stimpak_slowdown)
	to_chat(L, span_alert("You feel a sudden violent <i>lurch</i> in your chest, followed shortly by your heart racing at an agonizing pace and your muscles burning like you've run one too many marathons."))

/// Removes the slowdown and lets you know its safe to take another dose
/datum/reagent/medicine/super_stimpak/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_movespeed_modifier(/datum/movespeed_modifier/super_stimpak_slowdown)
	to_chat(L, span_notice("Your heart slows to a more reasonable pace, and your aching muscular fatigue fades.")) // tells you when it's safe to take another dose

/// Seals up bleeds like a weaker sanguirite, doesnt do any passive heals though
/datum/reagent/medicine/super_stimpak/on_mob_life(mob/living/carbon/M) // Heals fleshwounds like a weak sanguirite
	clot_bleed_wounds(user = M, bleed_reduction_rate = clot_rate, coefficient_per_wound = clot_coeff_per_wound, single_wound_full_effect = FALSE)
	. = TRUE
	..()


/datum/reagent/medicine/super_stimpak/overdose_process(mob/living/carbon/M)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, 4)
	if((M.getOrganLoss(ORGAN_SLOT_HEART) >= 20) && prob(8))
		var/superstim_od_message = pick(
			"You feel like someone punched you in the chest, but from the inside.", 
			"You breathe heavily, yet still feel winded.",
			"Your heart stops for a moment.",
			"You feel an agonizing shudder in your chest.")
		to_chat(M, span_warning("[superstim_od_message]"))
	. = TRUE
	..()


// ---------------------------
// LONGPORK STEW REAGENT

/datum/reagent/medicine/longpork_stew
	name = "Longpork stew"
	description = "A dish sworn by some to have unusual healing properties. To most it just tastes disgusting. What even is longpork anyways?..."
	reagent_state = LIQUID
	color =  "#915818"
	taste_description = "oily water, with bits of raw-tasting tender meat."
	metabolization_rate = 0.15 * REAGENTS_METABOLISM //slow, weak heal that lasts a while. Metabolizies much faster if you are not hurt.
	overdose_threshold = 50 //If you eat too much you get poisoned from all the human flesh you're eating
	var/longpork_hurting = 0
	var/longpork_lover_healing = -2
	ghoulfriendly = TRUE

/datum/reagent/medicine/longpork_stew/on_mob_life(mob/living/carbon/M)
	var/is_longporklover = FALSE
	if(HAS_TRAIT(M, TRAIT_LONGPORKLOVER))
		is_longporklover = TRUE
	if(M.getBruteLoss() == 0 && M.getFireLoss() == 0)
		metabolization_rate = 3 * REAGENTS_METABOLISM //metabolizes much quicker if not injured
	var/longpork_heal_rate = (is_longporklover ? longpork_lover_healing : longpork_hurting) * REAGENTS_EFFECT_MULTIPLIER
	if(!M.reagents.has_reagent(/datum/reagent/medicine/stimpak) && !M.reagents.has_reagent(/datum/reagent/medicine/healing_powder))
		M.adjustFireLoss(longpork_heal_rate)
		M.adjustBruteLoss(longpork_heal_rate)
		M.adjustToxLoss(is_longporklover ? 0 : 3)
		. = TRUE
		..()

/datum/reagent/medicine/longpork_stew/overdose_process(mob/living/M)
	M.adjustToxLoss(2*REAGENTS_EFFECT_MULTIPLIER)
	..()
	. = TRUE

/* 
 * Healing Powder
 * Bicaridine and Kelotane, in one chem
 * Heals either brute or burn, whichever's higher
 * Overdose makes you sleepy
 * Ghouls love it
 */

/datum/reagent/medicine/healing_powder	//about as strong as bicaridine or kelotane, but a safer OD.
	name = "Healing powder"
	description = "A healing powder derived from a mix of ground broc flowers and xander roots."
	reagent_state = SOLID
	color = "#A9FBFB"
	taste_description = "bitterness"
	metabolization_rate = 1 * REAGENTS_METABOLISM	// same as bicaridine
	overdose_threshold = 30
	ghoulfriendly = TRUE

/datum/reagent/medicine/healing_powder/on_mob_life(mob/living/carbon/M)
	if(M.getBruteLoss() > M.getFireLoss())	//Less effective at healing mixed damage types.
		M.adjustBruteLoss(-2*REAGENTS_EFFECT_MULTIPLIER)
	else
		M.adjustFireLoss(-2*REAGENTS_EFFECT_MULTIPLIER)
	. = TRUE
	..()

/datum/reagent/medicine/healing_powder/overdose_process(mob/living/carbon/M)
	M.drowsyness += 3
	. = TRUE
	..()

/* 
 * Healing Poultice
 * Heals both brute and burn
 * Seals up cuts
 * Overdose poisons you
 * Ghouls love it
 */

/datum/reagent/medicine/healing_powder/poultice	// Handles superior healing of the poultice herbal mix, with its superior healing, wound recovery, and painful OD
	name = "Healing poultice"
	description = "Potent, stinging herbs that swiftly aid in the recovery of grevious wounds."
	color = "#C8A5DC"
	overdose_threshold = 12
	var/clot_rate = 0.25
	var/clot_coeff_per_wound = 0.7

/datum/reagent/medicine/healing_powder/poultice/on_mob_metabolize(mob/living/L) // a painful remedy!
	. = ..()
	L.add_movespeed_modifier(/datum/movespeed_modifier/healing_poultice_slowdown)
	to_chat(L, span_alert("You feel a burning pain spread through your skin, concentrating around your wounds."))

/datum/reagent/medicine/healing_powder/poultice/on_mob_end_metabolize(mob/living/L)
	. = ..()
	L.remove_movespeed_modifier(/datum/movespeed_modifier/healing_poultice_slowdown)
	to_chat(L, span_notice("The poultice's burning subsides."))

/datum/reagent/medicine/healing_powder/poultice/on_mob_life(mob/living/carbon/M)
	. = ..()
	M.adjustBruteLoss(-1*REAGENTS_EFFECT_MULTIPLIER)
	M.adjustFireLoss(-1*REAGENTS_EFFECT_MULTIPLIER)
	clot_bleed_wounds(user = M, bleed_reduction_rate = clot_rate, coefficient_per_wound = clot_coeff_per_wound, single_wound_full_effect = FALSE)
	. = TRUE
	..()


/datum/reagent/medicine/healing_powder/poultice/overdose_process(mob/living/carbon/M)
	M.adjustToxLoss(4)
	if((M.getToxLoss() >= 30) && prob(8))
		var/poultice_od_message = pick(
			"Burning red streaks form on your skin.", 
			"You feel a searing pain shoot through your skin.",
			"You feel like your blood's been replaced with acid. It burns.")
		to_chat(M, span_notice("[poultice_od_message]"))
	. = TRUE
	..()


// ---------------------------
// RAD-X REAGENT

/datum/reagent/medicine/radx
	name = "Rad-X"

	description = "Reduces massive amounts of radiation and some toxin damage."
	reagent_state = LIQUID
	color = "#ff6100"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ghoulfriendly = TRUE

/datum/reagent/medicine/radx/on_mob_life(mob/living/carbon/M)
	if(M.radiation > 0)
		M.radiation -= min(M.radiation, 8)
	M.adjustToxLoss(-0.5*REAGENTS_EFFECT_MULTIPLIER)
	. = TRUE
	..()


// ---------------------------
// RADAWAY REAGENT

/datum/reagent/medicine/radaway
	name = "Radaway"

	description = "A potent anti-toxin drug."
	reagent_state = LIQUID
	color = "#ff7200"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	ghoulfriendly = TRUE

/datum/reagent/medicine/radaway/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-3*REAGENTS_EFFECT_MULTIPLIER)
	M.radiation -= min(M.radiation, 16)
	if(ishuman(M) && prob(7))
		var/mob/living/carbon/human/H = M
		H.confused = max(M.confused, 3)
	. = TRUE
	..()

// ---------------------------
// MED-X REAGENT

/datum/reagent/medicine/medx
	name = "Med-X"

	description = "Med-X is a potent painkiller, allowing users to withstand high amounts of pain and continue functioning. Addictive. Prolonged presence in the body can cause seizures and organ damage."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 25
	addiction_threshold = 15
	var/od_strikes = 0 // So we dont get roflstomped by a sudden massive dose of medx
	var/od_next_strike = 0 // there's a cool down between strikes, to give the user time to purge this stuff
	var/od_strike_cooldown = 6 SECONDS
	var/od_cycles = 0 // Number of cycles we've been ODing

/datum/reagent/medicine/medx/on_mob_add(mob/living/carbon/human/M)
	..()
	if(isliving(M))
		to_chat(M, span_alert("You feel a dull warmth spread throughout your body, masking all sense of pain with a not-unpleasant tingle. Injuries don't seem to hurt as much."))
		M.maxHealth += 30
		M.health += 30

/datum/reagent/medicine/medx/on_mob_delete(mob/living/carbon/human/M)
	if(isliving(M))
		to_chat(M, span_danger("The warmth fades, and every injury you you had slams into you like a truck."))
		M.maxHealth -= 30
		M.health -= 30
	..()

/datum/reagent/medicine/medx/on_mob_life(mob/living/carbon/M)
	if(M.health < 0)
		M.adjustToxLoss(-0.5*REAGENTS_EFFECT_MULTIPLIER, 0)
		M.adjustBruteLoss(-0.5*REAGENTS_EFFECT_MULTIPLIER, 0)
		M.adjustFireLoss(-0.5*REAGENTS_EFFECT_MULTIPLIER, 0)
	if(M.oxyloss > 35)
		M.setOxyLoss(35, 0)
	if(M.losebreath >= 4)
		M.losebreath = max(M.losebreath - 2, 0)
	M.adjustStaminaLoss(-1*REAGENTS_EFFECT_MULTIPLIER, 0)
	. = 1
	if(prob(20))
		M.AdjustAllImmobility(-20, 0)
		M.AdjustUnconscious(-20, 0)
	..()
	if(M.mind)
		var/datum/job/job = SSjob.GetJob(M.mind.assigned_role)
		if(istype(job))
			switch(job.faction)
				if(FACTION_LEGION)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "betrayed caesar", /datum/mood_event/betrayed_caesar, name)
	. = TRUE

/datum/reagent/medicine/medx/overdose_process(mob/living/carbon/human/M)
	/// Dont cause the effects if they have more than 15u of mentat, and any epinephrine at all
	/// Doesnt stop the severity ramping up, so if it goes below that... it all catches up
	if(M.reagents.get_reagent_amount(/datum/reagent/medicine/mentat) >= 5 && M.reagents.has_reagent(/datum/reagent/medicine/epinephrine))
		if(prob(5))
			to_chat(M, span_danger("Your nerves buzz like a hive of angry bees, kept running by sheer force of mentat."))
	else
		switch(od_strikes)
			if(0)
				od_next_strike = od_strike_cooldown + world.time // give a delay before the next strike check
				to_chat(M, span_danger("The numbing warmth attacks your senses, your body feeling like its in a dream, masking the sensation of your organs disintegrating under all that Med-X strain!"))
				od_strikes = 1
			if(1 to 3)
				M.confused = clamp(M.confused + 1, 1, 20)
				M.blur_eyes(5)
				M.adjustOrganLoss(ORGAN_SLOT_EYES, 1)
				if(prob(5))
					to_chat(M, span_danger("You feel a dull, building pressure behind your eyes, this can't be good for you."))
			if(4 to 6)
				M.confused = clamp(M.confused + 1, 1, 20)
				M.blur_eyes(10)
				M.losebreath = clamp(M.losebreath + 1, 1, 8)
				M.set_disgust(12)
				M.adjustStaminaLoss(5*REAGENTS_EFFECT_MULTIPLIER)
				M.adjustOrganLoss(ORGAN_SLOT_EYES, 2)
				if(prob(5))
					to_chat(M, span_danger("It takes conscious thought to continue breathing, thought continually interrupted by worrying throbs in your skull."))
			if(6 to 12)
				M.confused = clamp(M.confused + 1, 1, 200)
				M.blur_eyes(30)
				M.losebreath = clamp(M.losebreath + 1, 1, 10)
				M.adjustToxLoss(2)
				M.adjustOrganLoss(ORGAN_SLOT_EYES, 3)
				M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1, 40)
				M.adjustOrganLoss(ORGAN_SLOT_HEART, 1, 40)
				M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2, BRAIN_DAMAGE_MILD)
				M.set_disgust(25)
				M.adjustStaminaLoss(10*REAGENTS_EFFECT_MULTIPLIER)
				M.Jitter(20)
				M.playsound_local(M, 'sound/effects/singlebeat.ogg', 100, 0)
				if(prob(5))
					M.vomit(30, 1, 1, 5, 0, 0, 0, 60)
					to_chat(M, span_danger("You throw up everything you've eaten in the past week and some blood to boot. You're pretty sure your heart just stopped for a second, too."))
				if(prob(5))
					M.visible_message(
						span_danger("[M] stumbles around drunkenly, gasping for air in between long stretches of not breathing!"),
						span_danger("Your muscles don't seem to obey you, feeling like they're being pushed through a raging river. You feel dead inside."))
			if(13 to INFINITY)
				M.adjustOrganLoss(ORGAN_SLOT_EYES, 3)
				M.adjustOrganLoss(ORGAN_SLOT_LUNGS, 1, 40)
				M.adjustOrganLoss(ORGAN_SLOT_HEART, 1, 40)
				M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2, BRAIN_DAMAGE_MILD)
				if(prob(10))
					M.vomit(30, 1, 1, 5, 0, 0, 0, 60)
					to_chat(M, span_danger("You throw up everything you've eaten in the past week and some blood to boot. You're pretty sure your heart just stopped for a second, too."))
				if(prob(20))
					M.visible_message(
						span_danger("[M] twitches violently!"),
						span_danger("You feel an ominous slosh within you, your organs dissolving under the chemical stress and shutting down. You see a light..."))
	if(od_next_strike <= world.time)
		od_next_strike = world.time + od_strike_cooldown
		od_strikes = clamp(od_strikes + (((volume + od_cycles) / 3) % overdose_threshold), od_strikes + 1, od_strikes + 3)
		od_cycles++
	..()

/datum/reagent/medicine/medx/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Jitter(2)
	..()

/datum/reagent/medicine/medx/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REAGENTS_EFFECT_MULTIPLIER)
		. = TRUE
		M.Dizzy(3)
		M.Jitter(3)
	..()

/datum/reagent/medicine/medx/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REAGENTS_EFFECT_MULTIPLIER)
		. = TRUE
		M.Dizzy(4)
		M.Jitter(4)
	..()

/datum/reagent/medicine/medx/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(3*REAGENTS_EFFECT_MULTIPLIER)
		. = TRUE
		M.Dizzy(5)
		M.Jitter(5)
	..()

// ---------------------------
// MENTAT REAGENT

/datum/reagent/medicine/mentat
	name = "Mentat Powder"

	description = "A powerful drug that heals and increases the perception and intelligence of the user."
	color = "#C8A5DC"
	reagent_state = SOLID
	overdose_threshold = 25
	addiction_threshold = 15
	ghoulfriendly = TRUE

/datum/reagent/medicine/mentat/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-3*REAGENTS_EFFECT_MULTIPLIER)
	var/obj/item/organ/eyes/eyes = M.getorganslot(ORGAN_SLOT_EYES)
	if (!eyes)
		return
	if(M.getOrganLoss(ORGAN_SLOT_BRAIN) == 0)
		M.cure_all_traumas(TRAUMA_RESILIENCE_SURGERY)
/*	if(HAS_TRAIT(M, TRAIT_BLIND, TRAIT_GENERIC))
		if(prob(20))
			to_chat(M, "<span class='warning'>Your vision slowly returns...</span>")
			M.cure_blind(EYE_DAMAGE)
			M.cure_nearsighted(EYE_DAMAGE)
			M.blur_eyes(35)
	else if(HAS_TRAIT(M, TRAIT_NEARSIGHT, TRAIT_GENERIC))
		to_chat(M, "<span class='warning'>The blackness in your peripheral vision fades.</span>")
		M.cure_nearsighted(EYE_DAMAGE)
		M.blur_eyes(10)*/
	if(M.eye_blind || M.eye_blurry)
		M.set_blindness(0)
		M.set_blurriness(0)
		to_chat(M, "<span class='warning'>Your vision slowly returns to normal...</span>")
	M.adjustOrganLoss(ORGAN_SLOT_EYES, -1)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -1)
	if (prob(5))
		to_chat(M, "<span class='notice'>You feel a strange mental fortitude!</span>")
	..()
	. = TRUE

/datum/reagent/medicine/mentat/overdose_process(mob/living/M)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15)
	if(prob(33))
		M.Dizzy(2)
		M.Jitter(2)
	..()

/datum/reagent/medicine/mentat/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.Jitter(2)
	..()

/datum/reagent/medicine/mentat/addiction_act_stage2(mob/living/M)
	if(prob(33))
		. = TRUE
		M.Dizzy(3)
		M.Jitter(3)
	..()

/datum/reagent/medicine/mentat/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.adjustToxLoss(1*REAGENTS_EFFECT_MULTIPLIER)
//		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
//		. = TRUE
		M.Dizzy(4)
		M.Jitter(4)
	..()

/datum/reagent/medicine/mentat/addiction_act_stage4(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REAGENTS_EFFECT_MULTIPLIER)
//		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 4)
//		. = TRUE
		M.Dizzy(5)
		M.Jitter(5)
	..()

// ---------------------------
// FIXER REAGENT

/datum/reagent/medicine/fixer
	name = "Fixer Powder"

	description = "Treats addictions while also purging other chemicals from the body. Side effects include nausea."
	reagent_state = SOLID
	color = "#C8A5DC"
	ghoulfriendly = TRUE

/datum/reagent/medicine/fixer/on_mob_life(mob/living/carbon/M)
//	for(var/datum/reagent/R in M.reagents.reagent_list)
//		if(R != src)
//			M.reagents.remove_reagent(R.id,2)
	for(var/datum/reagent/R in M.reagents.addiction_list)
		M.reagents.addiction_list.Remove(R)
		to_chat(M, "<span class='notice'>You feel like you've gotten over your need for [R.name].</span>")
	M.confused = max(M.confused, 4)
	if(ishuman(M) && prob(5))
		var/mob/living/carbon/human/H = M
		H.vomit(10)
	..()
	. = TRUE

// ---------------------------
// GAIA EXTRACT REAGENT

/datum/reagent/medicine/gaia
	name = "Gaia Extract"

	description = "Liquid extracted from a gaia branch. Provides a slow but reliable healing effect"
	reagent_state = LIQUID
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	taste_description = "deliciousness"
	overdose_threshold = 30
	color = "##DBCE18"
	ghoulfriendly = TRUE

/datum/reagent/medicine/gaia/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustOxyLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustBruteLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustFireLoss(-0.75*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()

/datum/reagent/medicine/gaia/overdose_start(mob/living/M)
	metabolization_rate = 15 * REAGENTS_METABOLISM
	..()
