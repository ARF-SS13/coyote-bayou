/datum/species/smutant
	name = "Super Mutant"
	id = "smutant"
	say_mod = "yells"
	limbs_id = "smutant"
	species_traits = list(NOTRANSSTING,NOAROUSAL)
	inherent_traits = list(TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_SMUTANT,)
	inherent_biotypes = list(MOB_INORGANIC, MOB_HUMANOID)
	speedmod = 0.90
	siemens_coeff = 0
	punchdamagelow = 25
	punchdamagehigh = 30
	use_skintones = 0
	sexes = 0
	liked_food = JUNKFOOD | FRIED | RAW

/datum/species/smutant/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	for(var/obj/item/bodypart/b in C.bodyparts)
		b.max_damage += 80
/datum/species/smutant/on_species_loss(mob/living/carbon/C)
	..()
	for(var/obj/item/bodypart/b in C.bodyparts)
		b.max_damage = initial(b.max_damage)

/datum/species/smutant/qualifies_for_rank(rank, list/features)
	if(rank in GLOB.legion_positions) /* Legion isn't a fan of muties */
		return 0
	if(rank in GLOB.brotherhood_positions) //Kill it with fire.
		return 0
	if(rank in GLOB.vault_positions) //How did they even get in??.
		return 0
	return ..()
