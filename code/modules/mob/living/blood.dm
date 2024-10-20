/****************************************************
				BLOOD SYSTEM
****************************************************/

#define EXOTIC_BLEED_MULTIPLIER 4 //Multiplies the actually bled amount by this number for the purposes of turf reaction calculations.


/mob/living/carbon/monkey/handle_blood()
	if(bodytemperature <= TCRYO || (HAS_TRAIT(src, TRAIT_HUSK))) //cryosleep or husked people do not pump the blood.
		return

	var/temp_bleed = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		temp_bleed += BP.get_bleed_rate()
		BP.generic_bleedstacks = max(0, BP.generic_bleedstacks - 1)
	if(temp_bleed)
		bleed(temp_bleed)

	//Blood regeneration if there is some space
	if(blood_volume < BLOOD_VOLUME_NORMAL)
		blood_volume += 0.1 // regenerate blood VERY slowly
		if(blood_volume < BLOOD_VOLUME_OKAY)
			adjustOxyLoss(round((BLOOD_VOLUME_NORMAL - blood_volume) * 0.02, 1))

/mob/living/carbon/human/proc/resume_bleeding()
	bleedsuppress = 0
	if(stat != DEAD && is_bleeding())
		to_chat(src, span_warning("The blood soaks through your bandage."))

GLOBAL_LIST_INIT(blood_loss_messages, list(
	BLOOD_ANEMIA_MESSAGE_WARN = list(
		"You feel thirsty.",
		"You feel a chill.",
		"You feel tired."),
	BLOOD_ANEMIA_MESSAGE_MINOR = list(
		"You feel your heart flutter for a moment.",
		"You feel woozy.",
		"You feel very tired."),
	BLOOD_ANEMIA_MESSAGE_ANNOYING = list(
		"Your limbs feel cold.",
		"Your heart races.",
		"You can't seem to catch your breath."),
	BLOOD_ANEMIA_MESSAGE_DEBILITATING = list(
		"You feel a deep chill.",
		"You feel lethargic.",
		"You gasp for air, but it doesn't help!"),
	BLOOD_ANEMIA_MESSAGE_WORST = list(
		"You feel like a light breeze would knock you over.",
		"Your heart thrashes in your chest.",
		"You struggle to summon the strength to take a step.")
		))

// Takes care blood loss and regeneration
/mob/living/carbon/human/handle_blood()
	if(NOBLOOD in dna.species.species_traits || bleedsuppress || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		return
	if(HAS_TRAIT(src, TRAIT_NOMARROW)) //Bloodsuckers don't need to be here.
		return
	if(bodytemperature >= TCRYO && !(HAS_TRAIT(src, TRAIT_HUSK))) //cryosleep or husked people do not pump the blood.
		regenerate_blood()
		//Effects of bloodloss
		var/current_blood = get_blood(FALSE)
		switch(current_blood)
			// Blood loss detected, start warning that its getting low
			if(BLOOD_VOLUME_SYMPTOMS_MINOR to BLOOD_VOLUME_SYMPTOMS_WARN)
				if(prob(0.5))
					switch(rand(1,3))
						if(1)
							emote("shiver")
						if(2)
							emote("pale")
						if(3)
							to_chat(src, span_warning(pick(GLOB.blood_loss_messages[BLOOD_ANEMIA_MESSAGE_WARN])))

			// Blood loss progressed, start applying minor effects, not lethal, but kinda inconvenient
			if(BLOOD_VOLUME_SYMPTOMS_ANNOYING to BLOOD_VOLUME_SYMPTOMS_MINOR)
				if(prob(5))
					switch(rand(1,3))
						if(1)
							emote("shiver")
						if(2)
							emote("pale")
						if(3)
							to_chat(src, span_warning(pick(GLOB.blood_loss_messages[BLOOD_ANEMIA_MESSAGE_MINOR])))
				apply_bloodloss_effects(
					BLOOD_LOSS_OXYLOSS_CAP_MINOR,
					BLOOD_LOSS_STAMLOSS_CAP_MINOR,
					BLOOD_LOSS_DIZZINESS_CAP_MINOR,
					BLOOD_LOSS_CONFUSION_CAP_MINOR,
					BLOOD_LOSS_BLUR_CAP_MINOR,
					BLOOD_LOSS_SPRINT_BUFFER_MULT_MINOR,
					BLOOD_LOSS_SPRINT_REGEN_MULT_MINOR,
					BLOOD_LOSS_SPRINT_COST_MULT_MINOR,
					0,
					0,
					BLOOD_LOSS_SLOWDOWN_MINOR
					)

			// Blood loss is getting bad, start applying more effects, not lethal, but annoying
			if(BLOOD_VOLUME_SYMPTOMS_DEBILITATING to BLOOD_VOLUME_SYMPTOMS_ANNOYING)
				if(prob(15))
					switch(rand(1,3))
						if(1)
							emote("shiver")
						if(2)
							emote("pale")
						if(3)
							to_chat(src, span_warning(pick(GLOB.blood_loss_messages[BLOOD_ANEMIA_MESSAGE_ANNOYING])))
				apply_bloodloss_effects(
					BLOOD_LOSS_OXYLOSS_CAP_ANNOYING,
					BLOOD_LOSS_STAMLOSS_CAP_ANNOYING,
					BLOOD_LOSS_DIZZINESS_CAP_ANNOYING,
					BLOOD_LOSS_CONFUSION_CAP_ANNOYING,
					BLOOD_LOSS_BLUR_CAP_ANNOYING,
					BLOOD_LOSS_SPRINT_BUFFER_MULT_ANNOYING,
					BLOOD_LOSS_SPRINT_REGEN_MULT_ANNOYING,
					BLOOD_LOSS_SPRINT_COST_MULT_ANNOYING,
					BLOOD_LOSS_KNOCKDOWN_CHANCE_ANNOYING,
					BLOOD_LOSS_KNOCKDOWN_LENGTH_ANNOYING,
					BLOOD_LOSS_SLOWDOWN_ANNOYING
					)

			// Blood loss is bad, mess them up a bunch
			if(BLOOD_VOLUME_SYMPTOMS_WORST to BLOOD_VOLUME_SYMPTOMS_DEBILITATING)
				if(prob(15))
					switch(rand(1,3))
						if(1)
							emote("shiver")
						if(2)
							emote("pale")
						if(3)
							to_chat(src, span_warning(pick(GLOB.blood_loss_messages[BLOOD_ANEMIA_MESSAGE_DEBILITATING])))
				apply_bloodloss_effects(
					BLOOD_LOSS_OXYLOSS_CAP_DEBILITATING,
					BLOOD_LOSS_STAMLOSS_CAP_DEBILITATING,
					BLOOD_LOSS_DIZZINESS_CAP_DEBILITATING,
					BLOOD_LOSS_CONFUSION_CAP_DEBILITATING,
					BLOOD_LOSS_BLUR_CAP_DEBILITATING,
					BLOOD_LOSS_SPRINT_BUFFER_MULT_DEBILITATING,
					BLOOD_LOSS_SPRINT_REGEN_MULT_DEBILITATING,
					BLOOD_LOSS_SPRINT_COST_MULT_DEBILITATING,
					BLOOD_LOSS_KNOCKDOWN_CHANCE_DEBILITATING,
					BLOOD_LOSS_KNOCKDOWN_LENGTH_DEBILITATING,
					BLOOD_LOSS_SLOWDOWN_DEBILITATING
					)

			// Blood loss is as bad as it'll get before they die, they're gonna have a very bad day
			if(BLOOD_VOLUME_DEATH to BLOOD_VOLUME_SYMPTOMS_WORST)
				if(prob(15))
					switch(rand(1,3))
						if(1)
							emote("shiver")
						if(2)
							emote("pale")
						if(3)
							to_chat(src, span_warning(pick(GLOB.blood_loss_messages[BLOOD_ANEMIA_MESSAGE_WORST])))
				apply_bloodloss_effects(
					BLOOD_LOSS_OXYLOSS_CAP_WORST,
					BLOOD_LOSS_STAMLOSS_CAP_WORST,
					BLOOD_LOSS_DIZZINESS_CAP_WORST,
					BLOOD_LOSS_CONFUSION_CAP_WORST,
					BLOOD_LOSS_BLUR_CAP_WORST,
					BLOOD_LOSS_SPRINT_BUFFER_MULT_WORST,
					BLOOD_LOSS_SPRINT_REGEN_MULT_WORST,
					BLOOD_LOSS_SPRINT_COST_MULT_WORST,
					BLOOD_LOSS_KNOCKDOWN_CHANCE_WORST,
					BLOOD_LOSS_KNOCKDOWN_LENGTH_WORST,
					BLOOD_LOSS_SLOWDOWN_WORST
					)

			// you blood fall out. dork.
			if(-INFINITY to BLOOD_VOLUME_DEATH)
				if(!HAS_TRAIT(src, TRAIT_NODEATH))
					death()

			else // blood's fine
				remove_movespeed_modifier(/datum/movespeed_modifier/bloodloss_slowdown)
				apply_bloodloss_sprint_effects(reset = TRUE) // reset it initially

		var/temp_bleed = 0
		//Bleeding out
		for(var/X in bodyparts)
			var/obj/item/bodypart/BP = X
			temp_bleed += BP.get_bleed_rate()
			BP.generic_bleedstacks = max(0, BP.generic_bleedstacks - 1)

		if(temp_bleed)
			bleed(rand(temp_bleed*0.5, temp_bleed))
/* 
 * Applies bloodloss effects
 * oxy_loss_cap = How much do we cap their oxy damage? 
 * stam_cap = What's their new stamina cap? causes stam damage until its above this amount
 * dizzy = max dizziness to apply to this mob
 * confusion = max confusion to apply to this mob
 * sprint_max = Multiplier to the mob's sprint maximum
 * sprint_regen = Multiplier to the mob's sprint regeneration (lower numbers mean less regen)
 * sprint_cost = Multiplier to stamina cost per tile sprinted
 * knockdown_chance = chance for a knockdown to occur
 * knockdown_time = time they're knocked down for
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
/mob/living/carbon/proc/apply_bloodloss_effects(
	oxy_loss_cap,
	stam_cap,
	dizzy,
	confusion,
	blurry,
	sprint_max,
	sprint_regen,
	sprint_cost,
	knockdown_chance,
	knockdown_time,
	slowdown,
)
	var/stammoxy_dam = round((BLOOD_VOLUME_NORMAL - blood_volume) * 0.02, 1)
	if(oxy_loss_cap && (getBruteLoss() + getFireLoss() + getToxLoss()) < oxy_loss_cap)
		adjustBruteLoss(stammoxy_dam, TRUE, FALSE, TRUE, FALSE)
	// if(oxy_loss_cap && getOxyLoss() < oxy_loss_cap)
	// 	adjustOxyLoss(stammoxy_dam)
	if(stam_cap && getStaminaLoss() < stam_cap)
		adjustStaminaLoss(stammoxy_dam)
	if(dizzy && (dizziness < dizzy) && prob(50))
		Dizzy(1)
	if(confusion && confused < confusion)
		confused = confusion
	if(blurry && (eye_blurry < blurry) && prob(35))
		adjust_blurriness(1)
	if(knockdown_chance && prob(knockdown_chance))
		to_chat(src, span_warning("You stumble over, dazed by your blood loss!"))
		AdjustKnockdown(knockdown_time, TRUE)
	apply_bloodloss_sprint_effects(sprint_max, sprint_regen, sprint_cost, reset = FALSE)
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/bloodloss_slowdown, TRUE, slowdown)

/// Applies sprint modifiers. Here so it can be easily reset.
/mob/living/carbon/proc/apply_bloodloss_sprint_effects(sprint_max, sprint_regen, sprint_cost, reset = FALSE)
	if(reset)
		update_config_movespeed()
		return
	sprint_buffer_max = CONFIG_GET(number/movedelay/sprint_buffer_max) * sprint_max
	sprint_buffer_regen_ds = CONFIG_GET(number/movedelay/sprint_buffer_regen_per_ds) * sprint_regen
	sprint_stamina_cost = CONFIG_GET(number/movedelay/sprint_stamina_cost) * sprint_cost

/// Returns how much blood you have, effective or otherwise
/// just_blood just makes it return your real blood amount
/mob/living/proc/get_blood(just_blood = FALSE)
	. = blood_volume * blood_ratio
	if(just_blood)
		return
	if(. < BLOOD_VOLUME_EXPANDER_MAX) // start adding in blood volume buffs
		var/extra_blood
		for(var/datum/reagent/blood_expander in reagents.reagent_list)
			if(!blood_expander.effective_blood_multiplier)
				continue
			extra_blood += min(blood_expander.volume * blood_expander.effective_blood_multiplier, blood_expander.effective_blood_max)
		. = min(. + extra_blood, BLOOD_VOLUME_EXPANDER_MAX)

		if(has_reagent(/datum/reagent/medicine/epinephrine))
			. = max(., BLOOD_VOLUME_SYMPTOMS_WORST + 10) // Vasopressors~

// Passive blood regeneration
/mob/living/carbon/proc/regenerate_blood()
	if(get_blood(FALSE) > BLOOD_REFILL_NUTRITION_MAX)
		return
	var/blood_refill = BLOOD_REFILL_PER_TICK // guaranteed refill
	// Food based blood replenishment, spends nutrition to regen blood
	// Blood has a fixed nutrition cost, but being more well fed speeds it up a bit
	if(!HAS_TRAIT(src, TRAIT_NOHUNGER) && nutrition > BLOOD_REFILL_NUTRITION_HUNGRY)
		var/nutrition_bonus = 0
		switch(nutrition)
			if(NUTRITION_LEVEL_HUNGRY to NUTRITION_LEVEL_FED)
				nutrition_bonus = BLOOD_REFILL_NUTRITION_HUNGRY
			if(NUTRITION_LEVEL_FED to NUTRITION_LEVEL_WELL_FED)
				nutrition_bonus = BLOOD_REFILL_NUTRITION_FED
			if(NUTRITION_LEVEL_WELL_FED to NUTRITION_LEVEL_FULL)
				nutrition_bonus = BLOOD_REFILL_NUTRITION_WELL_FED
			if(NUTRITION_LEVEL_FULL to NUTRITION_LEVEL_FAT)
				nutrition_bonus = BLOOD_REFILL_NUTRITION_FULL
			if(NUTRITION_LEVEL_FAT to INFINITY)
				nutrition_bonus = BLOOD_REFILL_NUTRITION_FAT

		if(satiety > 80)
			nutrition_bonus *= 1.25
		if(HAS_TRAIT(src, TRAIT_HIGH_BLOOD))
			nutrition_bonus *= 2 // you just convert more nutrition to blood
		blood_refill += (BLOOD_REFILL_PER_TICK * nutrition_bonus)
		adjust_nutrition(-nutrition_bonus * BLOOD_UNIT_NUTRITION_COST)
	blood_volume += blood_refill

//Makes a blood drop, leaking amt units of blood from the mob
/mob/living/carbon/proc/bleed(amt)
	if(blood_volume)
		if(get_blood(FALSE) < BLOOD_VOLUME_LOSS_FLOOR)
			amt *= 0.05
		blood_volume = max(blood_volume - amt, 0)
		if(isturf(src.loc)) //Blood loss still happens in locker, floor stays clean
			if(amt >= 10)
				add_splatter_floor(src.loc)
			else
				add_splatter_floor(src.loc, 1)

/mob/living/carbon/human/bleed(amt)
	amt *= physiology.bleed_mod
	if(!(NOBLOOD in dna.species.species_traits))
		.=..()
		if(dna.species.exotic_blood && .) // Do we have exotic blood, and have we left any on the ground?
			var/datum/reagent/R = GLOB.chemical_reagents_list[get_blood_id()]
			if(istype(R) && isturf(loc))
				R.reaction_turf(get_turf(src), amt * EXOTIC_BLEED_MULTIPLIER)

/mob/living/proc/restore_blood()
	blood_volume = initial(blood_volume)

/mob/living/carbon/restore_blood()
	blood_volume = (BLOOD_VOLUME_NORMAL * blood_ratio)
	for(var/i in bodyparts)
		var/obj/item/bodypart/BP = i
		BP.generic_bleedstacks = 0

/****************************************************
				BLOOD TRANSFERS
****************************************************/

//Gets blood from mob to a container or other mob, preserving all data in it.
/mob/living/proc/transfer_blood_to(atom/movable/AM, amount, forced)
	var/our_blood = get_blood(FALSE)
	if(!our_blood || !AM.reagents)
		return FALSE
	if(our_blood < (BLOOD_VOLUME_SYMPTOMS_DEBILITATING * blood_ratio) && !forced)
		return FALSE

	if(our_blood < amount)
		amount = blood_volume

	var/blood_id = get_blood_id()
	if(!blood_id)
		return FALSE

	blood_volume -= amount

	var/list/blood_data = get_blood_data(blood_id)

	if(iscarbon(AM))
		var/mob/living/carbon/C = AM
		if(blood_id == C.get_blood_id())//both mobs have the same blood substance
			if(blood_id == /datum/reagent/blood || blood_id == /datum/reagent/blood/jellyblood) //normal blood
				if(blood_data["viruses"])
					for(var/thing in blood_data["viruses"])
						var/datum/disease/D = thing
						if((D.spread_flags & DISEASE_SPREAD_SPECIAL) || (D.spread_flags & DISEASE_SPREAD_NON_CONTAGIOUS))
							continue
						C.ForceContractDisease(D)
				//This used to inject oof ouch results, but since we add the reagent, and the reagent causes oof ouch on mob life... why double dip?

			C.blood_volume = min(C.blood_volume + round(amount, 0.1), BLOOD_VOLUME_MAXIMUM)
			return TRUE

	AM.reagents.add_reagent(blood_id, amount, blood_data, bodytemperature)
	return TRUE


/mob/living/proc/get_blood_data(blood_id)
	return

/mob/living/carbon/get_blood_data(blood_id)
	if(blood_id == /datum/reagent/blood || /datum/reagent/blood/jellyblood) //actual blood reagent
		var/blood_data = list()
		//set the blood data
		blood_data["viruses"] = list()

		for(var/thing in diseases)
			var/datum/disease/D = thing
			blood_data["viruses"] += D.Copy()

		blood_data["blood_DNA"] = dna.unique_enzymes
		blood_data["bloodcolor"] = dna.species.exotic_blood_color
		if(client && !isnull(client.prefs.features["blood_color"]) && client.prefs.features["blood_color"] != "")
			blood_data["bloodcolor"] = client.prefs.features["blood_color"]
		if(disease_resistances && disease_resistances.len)
			blood_data["resistances"] = disease_resistances.Copy()
		var/list/temp_chem = list()
		for(var/datum/reagent/R in reagents.reagent_list)
			temp_chem[R.type] = R.volume
		blood_data["trace_chem"] = list2params(temp_chem)
		if(mind)
			blood_data["mind"] = mind
		else if(last_mind)
			blood_data["mind"] = last_mind
		if(ckey)
			blood_data["ckey"] = ckey
		else if(last_mind)
			blood_data["ckey"] = ckey(last_mind.key)

		blood_data["cloneable"] = 1
		blood_data["blood_type"] = dna.blood_type
		blood_data["gender"] = gender
		blood_data["real_name"] = real_name
		blood_data["features"] = dna.features
		blood_data["factions"] = faction
		blood_data["quirks"] = list()
		for(var/V in mob_quirks)
			var/datum/quirk/T = V
			blood_data["quirks"] += T.type
		blood_data["changeling_loudness"] = 0
		if(mind)
			var/datum/antagonist/changeling/ling = mind.has_antag_datum(/datum/antagonist/changeling)
			if(istype(ling))
				blood_data["changeling_loudness"] = ling.loudfactor
		return blood_data

//get the id of the substance this mob use as blood.
/mob/proc/get_blood_id()
	return

/mob/living/simple_animal/get_blood_id()
	if(blood_volume)
		return /datum/reagent/blood

/mob/living/carbon/monkey/get_blood_id()
	if(!(HAS_TRAIT(src, TRAIT_NOCLONE)))
		return /datum/reagent/blood

/mob/living/carbon/get_blood_id()
	if(isjellyperson(src))
		return /datum/reagent/blood/jellyblood
	if(dna?.species?.exotic_blood)
		return dna.species.exotic_blood
	else if((dna && (NOBLOOD in dna.species.species_traits)) || HAS_TRAIT(src, TRAIT_NOCLONE))
		return
	else
		return /datum/reagent/blood

// This is has more potential uses, and is probably faster than the old proc.
/proc/get_safe_blood(bloodtype)
	. = list()
	if(!bloodtype)
		return

	var/static/list/bloodtypes_safe = list(
		"A-" = list("A-", "O-", "SY", "PLA"),
		"A+" = list("A-", "A+", "O-", "O+", "SY", "PLA"),
		"B-" = list("B-", "O-", "SY", "PLA"),
		"B+" = list("B-", "B+", "O-", "O+", "SY", "PLA"),
		"AB-" = list("A-", "B-", "O-", "AB-", "SY", "PLA"),
		"AB+" = list("A-", "A+", "B-", "B+", "O-", "O+", "AB-", "AB+", "SY", "PLA"),
		"O-" = list("O-","SY", "PLA"),
		"O+" = list("O-", "O+","SY", "PLA"),
		"L" = list("L","SY", "PLA"),
		"U" = list("A-", "A+", "B-", "B+", "O-", "O+", "AB-", "AB+", "L", "U", "SY", "PLA"),
		"HF" = list("HF", "SY", "PLA"),
		"X*" = list("X*", "SY", "PLA"),
		"SY" = list("SY", "PLA"),
		"GEL" = list("GEL","SY", "PLA"),
		"BUG" = list("BUG", "SY", "PLA")
	)

	var/safe = bloodtypes_safe[bloodtype]
	if(safe)
		. = safe

//to add a splatter of blood or other mob liquid.
/mob/living/proc/add_splatter_floor(turf/T, small_drip)
	if(get_blood_id() == null)
		return
	if(!T)
		T = get_turf(src)

	var/list/temp_blood_DNA
	if(small_drip)
		// Only a certain number of drips (or one large splatter) can be on a given turf.
		var/obj/effect/decal/cleanable/blood/drip/drop = locate() in T
		if(drop)
			if(drop.drips < 5)
				drop.drips++
				drop.add_overlay(pick(drop.random_icon_states))
				drop.transfer_mob_blood_dna(src)
				drop.update_icon()
				return
			else
				temp_blood_DNA = drop.blood_DNA.Copy()		//transfer dna from drip to splatter.
				qdel(drop)//the drip is replaced by a bigger splatter
		else
			drop = new(T, get_static_viruses())
			drop.transfer_mob_blood_dna(src)
			drop.update_icon()
			return

	// Find a blood decal or create a new one.
	var/obj/effect/decal/cleanable/blood/splats/B = locate() in T
	if(!B)
		B = new /obj/effect/decal/cleanable/blood/splats(T, get_static_viruses())
	if(B.bloodiness < MAX_SHOE_BLOODINESS) //add more blood, up to a limit
		B.bloodiness += BLOOD_AMOUNT_PER_DECAL
	B.transfer_mob_blood_dna(src) //give blood info to the blood decal.
	if(temp_blood_DNA)
		B.blood_DNA |= temp_blood_DNA

/mob/living/carbon/human/add_splatter_floor(turf/T, small_drip)
	if(!(NOBLOOD in dna.species.species_traits))
		..()

/mob/living/carbon/alien/add_splatter_floor(turf/T, small_drip)
	if(!T)
		T = get_turf(src)
	var/obj/effect/decal/cleanable/blood/splatter/B = locate() in T.contents
	if(!B)
		B = new(T)
	B.blood_DNA["UNKNOWN DNA"] = "X*"

/mob/living/silicon/robot/add_splatter_floor(turf/T, small_drip)
	if(!T)
		T = get_turf(src)
	var/obj/effect/decal/cleanable/oil/B = locate() in T.contents
	if(!B)
		B = new(T)

/mob/living/proc/add_splash_floor(turf/T)
	if(get_blood_id() == null)
		return
	if(!T)
		T = get_turf(src)

	var/list/temp_blood_DNA

	// Find a blood decal or create a new one.
	var/obj/effect/decal/cleanable/blood/B = locate() in T
	if(!B)
		B = new /obj/effect/decal/cleanable/blood/splatter(T, get_static_viruses())
	if(B.bloodiness < MAX_SHOE_BLOODINESS) //add more blood, up to a limit
		B.bloodiness += BLOOD_AMOUNT_PER_DECAL
	B.transfer_mob_blood_dna(src) //give blood info to the blood decal.
	src.transfer_blood_to(B, 10) //very heavy bleeding, should logically leave larger pools
	if(temp_blood_DNA)
		B.blood_DNA |= temp_blood_DNA

/mob/living/carbon/human/add_splash_floor(turf/T)
	if(!(NOBLOOD in dna.species.species_traits))
		..()

/mob/living/carbon/alien/add_splash_floor(turf/T)
	if(!T)
		T = get_turf(src)
	var/obj/effect/decal/cleanable/blood/splatter/B = locate() in T.contents
	if(!B)
		B = new(T)
	B.blood_DNA["UNKNOWN DNA"] = "X*"

/mob/living/silicon/robot/add_splash_floor(turf/T)
	if(!T)
		T = get_turf(src)
	var/obj/effect/decal/cleanable/oil/B = locate() in T.contents
	if(!B)
		B = new(T)

//This is a terrible way of handling it.
/mob/living/proc/ResetBloodVol()
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		if (HAS_TRAIT(src, TRAIT_HIGH_BLOOD))
			blood_ratio = 1.2
			H.handle_blood()
			return
		blood_ratio = 1
		H.handle_blood()
		return
	blood_ratio = 1

/mob/living/proc/AdjustBloodVol(value)
	if(blood_ratio == value)
		return
	blood_ratio = value
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		H.handle_blood()
