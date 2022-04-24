//ghouls-heal from radiation, do not breathe. do not go into crit. terrible at melee, easily dismembered. 
//cannot use medical chemicals to heal brute or burn, must heal from rads, sutures. can use antitoxin chemicals. 
//incredibly slow, appear dead. rotted organs unable to use for transplant.
//todo-make them take more damage from melee specifically.
//like before, they cannot take piercing wounds or burn wounds or slash wounds, but they can have their bones broken by any source of wound now instead of being impervious

/datum/species/ghoul
	name = "Ghoul"
	id = "ghoul"
	say_mod = "rasps"
	limbs_id = "ghoul"
	species_traits = list(HAIR,FACEHAIR,HAS_BONE,NOGENITALS, NOBLOOD)
	inherent_traits = list(TRAIT_RADIMMUNE, TRAIT_VIRUSIMMUNE, TRAIT_NOBREATH, TRAIT_NOHARDCRIT, TRAIT_NOSOFTCRIT, TRAIT_GHOULMELEE, TRAIT_EASYDISMEMBER, TRAIT_EASYLIMBDISABLE, TRAIT_LIMBATTACHMENT, TRAIT_NOPULSE, TRAIT_FAKEDEATH)
	inherent_biotypes = list(MOB_ORGANIC, MOB_HUMANOID)
	punchstunthreshold = 9
	use_skintones = 0
	speedmod = 1.5 //slow
	sexes = 1
	disliked_food = NONE
	liked_food = NONE

//Ghouls have weak limbs.
/datum/species/ghoul/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	for(var/obj/item/bodypart/r_arm/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -40
	for(var/obj/item/bodypart/l_arm/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -40
	for(var/obj/item/bodypart/r_leg/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -40
	for(var/obj/item/bodypart/l_leg/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -40
	C.faction |= "ghoul"
/datum/species/ghoul/on_species_loss(mob/living/carbon/C)
	..()
	C.faction -= "ghoul"
	for(var/obj/item/bodypart/r_arm/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)
		b.wound_resistance = initial(b.wound_resistance)
	for(var/obj/item/bodypart/l_arm/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)
		b.wound_resistance = initial(b.wound_resistance)
	for(var/obj/item/bodypart/r_leg/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)
		b.wound_resistance = initial(b.wound_resistance)
	for(var/obj/item/bodypart/l_leg/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)
		b.wound_resistance = initial(b.wound_resistance)

/datum/species/ghoul/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.legion_positions) /* legion HATES these ghoul */
		return 0
	if(rank in GLOB.brotherhood_positions) //don't hate them, just tolorate. 
		return 0
	if(rank in GLOB.vault_positions) //purest humans left in america. supposedly.
		return 0
	return ..()

/datum/species/ghoul/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(istype(chem) && !chem.ghoulfriendly)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * 1000)
		return TRUE
	if(chem.type == /datum/reagent/medicine/radaway)
		H.adjustBruteLoss(2)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		if(prob(5))
			to_chat(H, "<span class='warning'>You feel like taking radaway wasn't the best idea.</span>")
	if(chem.type == /datum/reagent/medicine/radx)
		H.adjustBruteLoss(2)
		if(prob(5))
			to_chat(H, "<span class='warning'>You feel sick...</span>")
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
	return ..()

/datum/species/ghoul/spec_life(mob/living/carbon/human/H)
	..()
	var/healpwr = 0
	var/is_healing = FALSE
	if(H.stat == DEAD)
		is_healing = FALSE
		return
	switch(H.radiation)
		if(0)
			healpwr = 0
			is_healing = FALSE
			H.set_light(0)
		if(1 to RAD_MOB_SAFE)
			healpwr = 1
			is_healing = TRUE
			H.set_light(0)
		if(RAD_MOB_SAFE to RAD_BURN_THRESHOLD)
			healpwr = 2
			is_healing = TRUE
			H.set_light(0)
		if(RAD_BURN_THRESHOLD to RAD_MOB_MUTATE)
			healpwr = 3
			is_healing = TRUE
			H.set_light(0)
		if(RAD_MOB_MUTATE to RAD_MOB_KNOCKDOWN)
			healpwr = 4
			H.set_light(2, 15, LIGHT_COLOR_GREEN)
			is_healing = TRUE
			H.add_movespeed_modifier(/datum/movespeed_modifier/ghoulhealone)
			H.remove_movespeed_modifier(/datum/movespeed_modifier/ghoulhealtwo)
		if(RAD_MOB_KNOCKDOWN to RAD_MOB_EXTREME)
			healpwr = 5
			H.set_light(2, 30, LIGHT_COLOR_GREEN)
			is_healing = TRUE
			H.add_movespeed_modifier(/datum/movespeed_modifier/ghoulhealtwo)
			H.remove_movespeed_modifier(/datum/movespeed_modifier/ghoulhealone)
			H.remove_movespeed_modifier(/datum/movespeed_modifier/ghoulhealthree)
			H.remove_status_effect(/datum/status_effect/ghouldoomed)
		else
			healpwr = 6
			H.add_movespeed_modifier(/datum/movespeed_modifier/ghoulhealthree)
			H.remove_movespeed_modifier(/datum/movespeed_modifier/ghoulhealtwo)
			H.set_light(2, 60, LIGHT_COLOR_GREEN)
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
			if(prob(5))
				to_chat(H, "<span class='cultbold'>You've taken in too much radiation, and it is cooking your brain!'</span>")
			is_healing = FALSE //removes ghoulheal
			H.apply_status_effect(/datum/status_effect/ghouldoomed)
	H.adjustCloneLoss(-healpwr)
	H.adjustToxLoss(-0.3) //ghouls always heal toxin very slowly no matter what
	H.heal_overall_damage(healpwr, healpwr, healpwr)
	if(is_healing)
		H.apply_status_effect(/datum/status_effect/ghoulheal)
	else
		H.remove_status_effect(/datum/status_effect/ghoulheal)



/*/datum/species/ghoul/glowing
	name = "Glowing Ghoul"
	id = "glowing ghoul"
	limbs_id = "glowghoul"
	armor = -30
	speedmod = 0.5
	brutemod = 1.3
	punchdamagehigh = 6
	punchstunthreshold = 6
	use_skintones = 0
	sexes = 0

//Ghouls have weak limbs.
/datum/species/ghoul/glowing/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	for(var/obj/item/bodypart/b in C.bodyparts)
		b.max_damage -= 15
	C.faction |= "ghoul"
	C.set_light(2, 1, LIGHT_COLOR_GREEN)
	SSradiation.processing += C

/datum/species/ghoul/glowing/on_species_loss(mob/living/carbon/C)
	..()
	C.set_light(0)
	C.faction -= "ghoul"
	for(var/obj/item/bodypart/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)
	SSradiation.processing -= C
*/

