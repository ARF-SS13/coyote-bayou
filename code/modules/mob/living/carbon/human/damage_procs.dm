
// depending on the species, it will run the corresponding apply_damage code there
/mob/living/carbon/human/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE, damage_threshold = 0, sendsignal = TRUE)
	if(!forced && damage <= 0)
		return 0
	INVOKE_ASYNC(dna.species, PROC_REF(apply_damage), damage, damagetype, def_zone, blocked, src, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, damage_threshold, sendsignal)
	return TRUE

