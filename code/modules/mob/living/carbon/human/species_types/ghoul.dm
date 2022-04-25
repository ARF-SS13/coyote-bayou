//ghouls-heal from radiation, do not breathe. do not go into crit. terrible at melee, easily dismembered. 
//cannot use medical chemicals to heal brute or burn, must heal from rads, sutures. can use antitoxin chemicals.  //actually changed my mind i'll give stims reduced effect instead
//Slower than humans at combat armor speed, appear dead. rotted organs unable to use for transplant.
//like before, they cannot take piercing wounds or burn wounds or slash wounds, but they can have their bones broken by any source of wound now instead of being impervious

/datum/species/ghoul
	name = "Ghoul"
	id = "ghoul"
	say_mod = "rasps"
	limbs_id = "ghoul"
	species_traits = list(HAIR,FACEHAIR,HAS_BONE,NOGENITALS, NOBLOOD)
	inherent_traits = list(TRAIT_RADIMMUNE, TRAIT_VIRUSIMMUNE, TRAIT_NOBREATH, TRAIT_NOHARDCRIT, TRAIT_NOSOFTCRIT, TRAIT_GHOULMELEE, TRAIT_EASYDISMEMBER, TRAIT_EASYLIMBDISABLE, TRAIT_LIMBATTACHMENT, TRAIT_FAKEDEATH)
	inherent_biotypes = list(MOB_ORGANIC, MOB_HUMANOID)
	punchstunthreshold = 9
	use_skintones = 0
	speedmod = 0.3 //slightly slower than humans
	sexes = 1
	disliked_food = NONE
	liked_food = NONE
	var/info_text = "You are a <span class='danger'>Ghoul.</span>. As pre-war zombified relic, or an unluckily recently made post-necrotic, you cannot bleed, cannot breathe, and heal from radiation. On surface examination, you are indistinguishable from a corpse. \
					Your <span class='warning'>fragile limbs</span> are a source of vulnerability for you-they are easily dismembered and easily detached, though you can stick them on just as easily. \
					<span class='boldwarning'>Stimpaks and powder</span> will have reduced effect on your bizzare biology. Sutures, radiation, and other, non-chemical sources of healing are more effective. All chemicals that do not heal brute or burn work as normal. \
					<span class='nicegreen'>Radiation heals you slowly.</span> \
					<span class='warning'>You are terrible at melee</span> and innately slower than humans. You also cannot go into critical condition-ever. You will keep shambling forward until you are <span class='danger'>dead.</span>"

//Ghouls have weak limbs.
/datum/species/ghoul/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	to_chat(C, "[info_text]")
	for(var/obj/item/bodypart/r_arm/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -20
	for(var/obj/item/bodypart/l_arm/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -20
	for(var/obj/item/bodypart/r_leg/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -20
	for(var/obj/item/bodypart/l_leg/b in C.bodyparts)
		b.max_damage -= 10
		b.wound_resistance = -20
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
	if(chem.type == /datum/reagent/medicine/stimpak)
		H.adjustBruteLoss(1.5) //this is a very shitty way of making it so that they heal at a reduced rate for the emergency fix, i'll make the code cleaner tomorrow
	if(chem.type == /datum/reagent/medicine/super_stimpak)
		H.adjustBruteLoss(2.5)
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
		else
			healpwr = 3
			is_healing = TRUE
			H.set_light(2, 15, LIGHT_COLOR_GREEN)
	H.adjustCloneLoss(-healpwr)
	H.adjustToxLoss(-0.3) //ghouls always heal toxin very slowly no matter what
	H.adjustStaminaLoss(-20) //ghouls don't get tired ever
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

