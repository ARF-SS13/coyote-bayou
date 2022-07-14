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
	overdose_threshold = 16
	addiction_threshold = 6

/datum/reagent/medicine/medx/on_mob_add(mob/living/carbon/human/M)
	..()
	if(isliving(M))
		to_chat(M, "<span class='notice'>You feel tougher, able to shrug off pain more easily.</span>")
		M.maxHealth += 50
		M.health += 50

/datum/reagent/medicine/medx/on_mob_delete(mob/living/carbon/human/M)
	if(isliving(M))
		to_chat(M, "<span class='notice'>You feel as vulnerable to pain as a normal person.</span>")
		M.maxHealth -= 50
		M.health -= 50
	switch(current_cycle)
		if(1 to 40)
			M.confused += 10
			M.blur_eyes(20)
			to_chat(M, "<span class='notice'>Your head is pounding. Med-X is hard on the body. </span>")
		if(41 to 80)
			M.confused +=20
			M.blur_eyes(30)
			M.losebreath += 8
			M.set_disgust(12)
			M.adjustStaminaLoss(30*REAGENTS_EFFECT_MULTIPLIER)
			to_chat(M, "<span class='danger'>Your stomach churns, your eyes cloud and you're pretty sure you just popped a lung. You shouldn't take so much med-X at once. </span>")
		if(81 to 120)
			M.confused +=40
			M.blur_eyes(30)
			M.losebreath += 10
			M.adjustOrganLoss(ORGAN_SLOT_EYES, 3)
			M.set_disgust(25)
			M.adjustStaminaLoss(40*REAGENTS_EFFECT_MULTIPLIER)
			M.vomit(30, 1, 1, 5, 0, 0, 0, 60)
			M.Jitter(1000)
			M.playsound_local(M, 'sound/effects/singlebeat.ogg', 100, 0)
			M.visible_message("<span class='userdanger'>[M] clutches their stomach and vomits violently onto the ground, bloody froth covering their lips!</span>")
			to_chat(M, "<span class='userdanger'>You throw up everything you've eaten in the past week and some blood to boot. You're pretty sure your heart just stopped for a second, too. </span>")
		if(121 to INFINITY)
			M.adjustOrganLoss(ORGAN_SLOT_EYES, 3)
			M.Unconscious(400)
			M.Jitter(1000)
			M.set_heartattack(TRUE)
			M.visible_message("<span class='userdanger'>[M] clutches at their chest as if their heart stopped!</span>")
			to_chat(M, "<span class='danger'>Your vision goes black and your heart stops beating as the amount of drugs in your system shut down your organs one by one. Say hello to Elvis in the afterlife. </span>")

	..()

/datum/reagent/medicine/medx/on_mob_life(mob/living/carbon/M)
	M.AdjustStun(-30*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.AdjustKnockdown(-30*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.AdjustUnconscious(-30*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustStaminaLoss(-5*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()
	if(M.mind)
		var/datum/job/job = SSjob.GetJob(M.mind.assigned_role)
		if(istype(job))
			switch(job.faction)
				if(FACTION_LEGION)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "betrayed caesar", /datum/mood_event/betrayed_caesar, name)
	. = TRUE

/datum/reagent/medicine/medx/overdose_process(mob/living/carbon/human/M)
	M.set_blurriness(30)
	M.Unconscious(400)
	M.Jitter(1000)
	M.drop_all_held_items()
	M.Dizzy(2)
	M.visible_message("<span class='userdanger'>[M] suddenly passes out!</span>")
	if(prob(10))
		to_chat(M, "<span class='userdanger'>Too much med-x! </span>")
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

/datum/reagent/medicine/legionmedx
	name = "natural painkiller"

	description = "Med-X is a potent painkiller, allowing users to withstand high amounts of pain and continue functioning."
	reagent_state = LIQUID
	color = "#6D6374"
	metabolization_rate = 0.7 * REAGENTS_METABOLISM
	overdose_threshold = 14
	addiction_threshold = 50

/datum/reagent/medicine/legionmedx/on_mob_add(mob/M)
	..()
	if(isliving(M))
		var/mob/living/carbon/L = M
		L.hal_screwyhud = SCREWYHUD_HEALTHY
		ADD_TRAIT(L, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)

/datum/reagent/medicine/legionmedx/on_mob_delete(mob/M)
	if(isliving(M))
		var/mob/living/carbon/L = M
		L.hal_screwyhud = SCREWYHUD_NONE
		REMOVE_TRAIT(M, TRAIT_IGNOREDAMAGESLOWDOWN, TRAIT_GENERIC)
	..()

/datum/reagent/medicine/legionmedx/on_mob_life(mob/living/carbon/M)
	M.AdjustStun(-20*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.AdjustKnockdown(-20*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.AdjustUnconscious(-20*REAGENTS_EFFECT_MULTIPLIER, 0)
	M.adjustStaminaLoss(-3*REAGENTS_EFFECT_MULTIPLIER, 0)
	..()
	. = TRUE

/datum/reagent/medicine/legionmedx/overdose_process(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Dizzy(2)
		M.Jitter(2)
	..()

/datum/reagent/medicine/legionmedx/addiction_act_stage1(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.Jitter(2)
	..()

/datum/reagent/medicine/legionmedx/addiction_act_stage2(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(1*REAGENTS_EFFECT_MULTIPLIER)
		. = TRUE
		M.Dizzy(3)
		M.Jitter(3)
	..()

/datum/reagent/medicine/legionmedx/addiction_act_stage3(mob/living/M)
	if(prob(33))
		M.drop_all_held_items()
		M.adjustToxLoss(2*REAGENTS_EFFECT_MULTIPLIER)
		. = TRUE
		M.Dizzy(4)
		M.Jitter(4)
	..()

/datum/reagent/medicine/legionmedx/addiction_act_stage4(mob/living/M)
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
	else if(M.eye_blind || M.eye_blurry)
		M.set_blindness(0)
		M.set_blurriness(0)
		to_chat(M, "<span class='warning'>Your vision slowly returns to normal...</span>")
//	else if(eyes.eye_damage > 0)
//		M.adjust_eye_damage(-1)
//	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -2)
	if (prob(5))
		to_chat(M, "<span class='notice'>You feel way more intelligent!</span>")
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
