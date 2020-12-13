/datum/reagent/toxin/FEV_solution
	name = "Unstable FEV solution"
	description = "An incredibly lethal strain of the Forced Evolutionary Virus. Consume at your own risk."
	color = "#00FF00"
	toxpwr = 5
	taste_description = "slime"
	taste_mult = 0.9

/datum/reagent/toxin/FEV_solution/reaction_mob(mob/living/carbon/M, method=TOUCH, reac_volume)
	if(!..())
		return
	if(!M.has_dna())
		return  //No robots, AIs, aliens, Ians or other mobs should be affected by this.
	if((method==VAPOR && prob(min(25, reac_volume))) || method==INGEST || method==PATCH || method==INJECT)
		M.easy_randmut(NEGATIVE + MINOR_NEGATIVE, sequence = FALSE)
		M.updateappearance()
		M.domutcheck()
	..()

/datum/reagent/toxin/FEV_solution/on_mob_life(mob/living/carbon/C)
	C.apply_effect(30,EFFECT_IRRADIATE,0)
	C.adjustCloneLoss(30,0)
	return ..()
