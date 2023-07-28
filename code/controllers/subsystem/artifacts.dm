/// processing subsystem for generating and ticking artifacts
/// Artifacts are basically diablo 2 style magic items
PROCESSING_SUBSYSTEM_DEF(artifacts)
	name = "Artifacts"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 1 SECONDS

	/// Number of artifacts in existence
	var/list/number_of_artifacts = list(
		ART_RARITY_COMMON = 0,
		ART_RARITY_UNCOMMON = 0,
		ART_RARITY_RARE = 0,
	)
	var/list/number_of_effects = list(
		ART_RARITY_COMMON = 0,
		ART_RARITY_UNCOMMON = 0,
		ART_RARITY_RARE = 0,
	)

	var/list/max_effects_by_rarity = list(
		ART_RARITY_COMMON = 2,
		ART_RARITY_UNCOMMON = 4,
		ART_RARITY_RARE = 6,
	)
	var/list/min_effects_by_rarity = list(
		ART_RARITY_COMMON = 1,
		ART_RARITY_UNCOMMON = 2,
		ART_RARITY_RARE = 4,
	)
	var/list/max_prefixes_by_rarity = list(
		ART_RARITY_COMMON = 1,
		ART_RARITY_UNCOMMON = 2,
		ART_RARITY_RARE = 3,
	)
	var/list/max_suffixes_by_rarity = list(
		ART_RARITY_COMMON = 1,
		ART_RARITY_UNCOMMON = 2,
		ART_RARITY_RARE = 3,
	)

	/// list of all artifacts, for fulfilling quotas or something
	var/list/all_artifacts = list()
	var/list/common_artifacts = list()
	var/list/uncommon_artifacts = list()
	var/list/rare_artifacts = list()

	var/list/unique_templates = list()

	var/list/all_effects = list()
	var/list/bad_effects = list()

	var/list/allowed_effects_by_rarity = list(
		ART_RARITY_COMMON = list(),
		ART_RARITY_UNCOMMON = list(),
		ART_RARITY_RARE = list(),
	)

	var/list/common_spawner_distribution = list(
		ART_RARITY_COMMON = 100,
		ART_RARITY_UNCOMMON = 10,
		ART_RARITY_RARE = 1,
	)
	var/list/uncommon_spawner_distribution = list(
		ART_RARITY_COMMON = 25,
		ART_RARITY_UNCOMMON = 100,
		ART_RARITY_RARE = 10,
	)
	var/list/rare_spawner_distribution = list(
		ART_RARITY_COMMON = 5,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 100,
	)

	/// chance for an effect to be a buff instead of somewhere between buff and debuff
	var/list/helpful_chances = list(
		ART_RARITY_COMMON = 50,
		ART_RARITY_UNCOMMON = 25,
		ART_RARITY_RARE = 15,
	)

	// 200 ** 200 = 4e+120
	var/list/rare_prefixes = list()
	var/list/rare_suffixes = list()

	var/blood_target_common_minimum = BLOOD_VOLUME_SYMPTOMS_MINOR
	var/blood_target_uncommon_minimum = BLOOD_VOLUME_SYMPTOMS_ANNOYING
	var/blood_target_rare_minimum = BLOOD_VOLUME_SYMPTOMS_WORST
	var/blood_rate_common_maximum = 0.5
	var/blood_rate_uncommon_maximum = 3
	var/blood_rate_rare_maximum = 10
	var/blood_discrete = 0.1

	var/radiation_target_common_maximum = 1000
	var/radiation_target_uncommon_maximum = 10000
	var/radiation_target_rare_maximum = INFINITY
	var/radiation_rate_common_maximum = 2
	var/radiation_rate_common_minimum = 0
	var/radiation_rate_uncommon_maximum = 5
	var/radiation_rate_uncommon_minimum = 0
	var/radiation_rate_rare_maximum = 10
	var/radiation_rate_rare_minimum = 0
	var/radiation_discrete = 0.1

	var/health_common_maximum = 5
	var/health_common_minimum = -10
	var/health_uncommon_maximum = 10
	var/health_uncommon_minimum = -20
	var/health_rare_maximum = 50
	var/health_rare_minimum = -90
	var/health_discrete = 1

	var/stamina_rate_common_maximum = 3
	var/stamina_rate_common_minimum = -3
	var/stamina_rate_uncommon_maximum = 5
	var/stamina_rate_uncommon_minimum = -5
	var/stamina_rate_rare_maximum = 10
	var/stamina_rate_rare_minimum = -20
	var/stamina_discrete = 1

	var/speed_common_maximum = 0.5
	var/speed_common_minimum = -0.1
	var/speed_uncommon_maximum = 1
	var/speed_uncommon_minimum = -0.5
	var/speed_rare_maximum = 3
	var/speed_rare_minimum = -1
	var/speed_discrete = 0.05

	var/damage_common_cutoff_minimum = 75
	var/damage_uncommon_cutoff_minimum = 25
	var/damage_rare_cutoff_minimum = 10
	var/damage_discrete = 0.1

	var/damage_max_types_common = 1
	var/damage_max_types_uncommon = 2
	var/damage_max_types_rare = 3

	var/damage_dps_brute_common_maximum = 1
	var/damage_dps_brute_uncommon_maximum = 5
	var/damage_dps_brute_rare_maximum = 10

	var/damage_dps_burn_common_maximum = 1
	var/damage_dps_burn_uncommon_maximum = 5
	var/damage_dps_burn_rare_maximum = 10

	var/damage_dps_toxin_common_maximum = 1
	var/damage_dps_toxin_uncommon_maximum = 5
	var/damage_dps_toxin_rare_maximum = 10

	var/damage_dps_oxy_common_maximum = 2
	var/damage_dps_oxy_uncommon_maximum = 5
	var/damage_dps_oxy_rare_maximum = 10

	var/damage_dps_clone_common_maximum = 2
	var/damage_dps_clone_uncommon_maximum = 5
	var/damage_dps_clone_rare_maximum = 10

	var/heal_common_minimum_health = 50
	var/heal_common_maximum_health = 100
	var/heal_uncommon_minimum_health = 25
	var/heal_uncommon_maximum_health = 100
	var/heal_rare_minimum_health = 10
	var/heal_rare_maximum_health = 100
	var/heal_discrete = 0.1

	var/heal_dps_brute_common_maximum = 0.1
	var/heal_dps_brute_uncommon_maximum = 0.5
	var/heal_dps_brute_rare_maximum = 2

	var/heal_dps_burn_common_maximum = 0.1
	var/heal_dps_burn_uncommon_maximum = 0.5
	var/heal_dps_burn_rare_maximum = 2

	var/heal_dps_toxin_common_maximum = 0.1
	var/heal_dps_toxin_uncommon_maximum = 0.5
	var/heal_dps_toxin_rare_maximum = 2

	var/heal_dps_oxy_common_maximum = 0.1
	var/heal_dps_oxy_uncommon_maximum = 0.5
	var/heal_dps_oxy_rare_maximum = 2

	var/heal_dps_clone_common_maximum = 0.1
	var/heal_dps_clone_uncommon_maximum = 0.5
	var/heal_dps_clone_rare_maximum = 2

	var/heal_dps_brain_common_maximum = 0.1
	var/heal_dps_brain_uncommon_maximum = 0.5
	var/heal_dps_brain_rare_maximum = 2

	var/damage_max_types_common = 1
	var/damage_max_types_uncommon = 2
	var/damage_max_types_rare = 3

	var/list/prefixes_speed_good = list()
	var/list/prefixes_speed_bad = list()
	var/list/suffixes_speed_good = list()
	var/list/suffixes_speed_bad = list()

	var/list/prefixes_damage_brute = list()
	var/list/prefixes_damage_burn = list()
	var/list/prefixes_damage_toxin = list()
	var/list/prefixes_damage_oxy = list()
	var/list/prefixes_damage_clone = list()
	var/list/prefixes_damage_brain = list()

	var/list/suffixes_damage_brute = list()
	var/list/suffixes_damage_burn = list()
	var/list/suffixes_damage_toxin = list()
	var/list/suffixes_damage_oxy = list()
	var/list/suffixes_damage_clone = list()
	var/list/suffixes_damage_brain = list()

	var/list/prefixes_heal_brute = list()
	var/list/prefixes_heal_burn = list()
	var/list/prefixes_heal_toxin = list()
	var/list/prefixes_heal_oxy = list()
	var/list/prefixes_heal_clone = list()
	var/list/prefixes_heal_brain = list()

	var/list/suffixes_heal_brute = list()
	var/list/suffixes_heal_burn = list()
	var/list/suffixes_heal_toxin = list()
	var/list/suffixes_heal_oxy = list()
	var/list/suffixes_heal_clone = list()
	var/list/suffixes_heal_brain = list()

	var/list/prefixes_stamina_good = list()
	var/list/prefixes_stamina_bad = list()
	var/list/suffixes_stamina_good = list()
	var/list/suffixes_stamina_bad = list()

	var/list/prefixes_radiation_good = list()
	var/list/prefixes_radiation_bad = list()
	var/list/suffixes_radiation_good = list()
	var/list/suffixes_radiation_bad = list()

	var/list/prefixes_health_good = list()
	var/list/prefixes_health_bad = list()
	var/list/suffixes_health_good = list()
	var/list/suffixes_health_bad = list()

	var/list/prefixes_blood_good = list()
	var/list/prefixes_blood_bad = list()
	var/list/suffixes_blood_good = list()
	var/list/suffixes_blood_bad = list()

	var/list/prefixes_unidentified = list()

/datum/controller/subsystem/processing/artifacts/Initialize(start_timeofday)
	populate_affix_lists()
	populate_effect_lists()
	. = ..()
	
/datum/controller/subsystem/processing/artifacts/fire(resumed)

/datum/controller/subsystem/processing/artifacts/proc/populate_effect_lists()
	for(var/ae_type in subtypesof(/datum/artifact_effect))
		var/datum/artifact_effect/AE = new ae_type(src)
		var/kye = AE.kind
		var/isbad = AE.is_only_harmful
		LAZYSET(all_effects, kye, AE)
		LAZYADD(all_effects_stripped, kye)
		if(isbad)
			LAZYSET(bad_effects, kye, AE)
			LAZYADD(bad_effects_stripped, kye)
		switch(AE.minimum_rarity_to_spawn)
			if(ART_RARITY_COMMON)
				allowed_effects_by_rarity[ART_RARITY_COMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_UNCOMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight
			if(ART_RARITY_UNCOMMON)
				allowed_effects_by_rarity[ART_RARITY_UNCOMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight
			if(ART_RARITY_RARE)
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight


/datum/controller/subsystem/processing/artifacts/proc/populate_affix_lists()
	var/list/sillystring = safe_json_decode(file2text("strings/artifact_affixes.json"))
	if(!LAZYLEN(sillystring))
		CRASH("Artifact affixes file is missing or invalid!")
	prefixes_unidentified =   LAZYACCESS(sillystring, "prefixes_unidentified")
	rare_prefixes =           LAZYACCESS(sillystring, "rare_prefixes")
	rare_suffixes =           LAZYACCESS(sillystring, "rare_suffixes")
	prefixes_speed_good =     LAZYACCESS(sillystring, "prefixes_speed_good")
	prefixes_speed_bad =      LAZYACCESS(sillystring, "prefixes_speed_bad")
	suffixes_speed_good =     LAZYACCESS(sillystring, "suffixes_speed_good")
	suffixes_speed_bad =      LAZYACCESS(sillystring, "suffixes_speed_bad")
	prefixes_damage_brute =   LAZYACCESS(sillystring, "prefixes_damage_brute")
	prefixes_damage_burn =    LAZYACCESS(sillystring, "prefixes_damage_burn")
	prefixes_damage_toxin =   LAZYACCESS(sillystring, "prefixes_damage_toxin")
	prefixes_damage_oxy =     LAZYACCESS(sillystring, "prefixes_damage_oxy")
	prefixes_damage_clone =   LAZYACCESS(sillystring, "prefixes_damage_clone")
	prefixes_damage_brain =   LAZYACCESS(sillystring, "prefixes_damage_brain")
	suffixes_damage_brute =   LAZYACCESS(sillystring, "suffixes_damage_brute")
	suffixes_damage_burn =    LAZYACCESS(sillystring, "suffixes_damage_burn")
	suffixes_damage_toxin =   LAZYACCESS(sillystring, "suffixes_damage_toxin")
	suffixes_damage_oxy =     LAZYACCESS(sillystring, "suffixes_damage_oxy")
	suffixes_damage_clone =   LAZYACCESS(sillystring, "suffixes_damage_clone")
	suffixes_damage_brain =   LAZYACCESS(sillystring, "suffixes_damage_brain")
	prefixes_heal_brute =     LAZYACCESS(sillystring, "prefixes_heal_brute")
	prefixes_heal_burn =      LAZYACCESS(sillystring, "prefixes_heal_burn")
	prefixes_heal_toxin =     LAZYACCESS(sillystring, "prefixes_heal_toxin")
	prefixes_heal_oxy =       LAZYACCESS(sillystring, "prefixes_heal_oxy")
	prefixes_heal_clone =     LAZYACCESS(sillystring, "prefixes_heal_clone")
	prefixes_heal_brain =     LAZYACCESS(sillystring, "prefixes_heal_brain")
	suffixes_heal_brute =     LAZYACCESS(sillystring, "suffixes_heal_brute")
	suffixes_heal_burn =      LAZYACCESS(sillystring, "suffixes_heal_burn")
	suffixes_heal_toxin =     LAZYACCESS(sillystring, "suffixes_heal_toxin")
	suffixes_heal_oxy =       LAZYACCESS(sillystring, "suffixes_heal_oxy")
	suffixes_heal_clone =     LAZYACCESS(sillystring, "suffixes_heal_clone")
	suffixes_heal_brain =     LAZYACCESS(sillystring, "suffixes_heal_brain")
	prefixes_stamina_good =   LAZYACCESS(sillystring, "prefixes_stamina_good")
	prefixes_stamina_bad =    LAZYACCESS(sillystring, "prefixes_stamina_bad")
	suffixes_stamina_good =   LAZYACCESS(sillystring, "suffixes_stamina_good")
	suffixes_stamina_bad =    LAZYACCESS(sillystring, "suffixes_stamina_bad")
	prefixes_radiation_good = LAZYACCESS(sillystring, "prefixes_radiation_good")
	prefixes_radiation_bad =  LAZYACCESS(sillystring, "prefixes_radiation_bad")
	suffixes_radiation_good = LAZYACCESS(sillystring, "suffixes_radiation_good")
	suffixes_radiation_bad =  LAZYACCESS(sillystring, "suffixes_radiation_bad")
	prefixes_health_good =    LAZYACCESS(sillystring, "prefixes_health_good")
	prefixes_health_bad =     LAZYACCESS(sillystring, "prefixes_health_bad")
	suffixes_health_good =    LAZYACCESS(sillystring, "suffixes_health_good")
	suffixes_health_bad =     LAZYACCESS(sillystring, "suffixes_health_bad")
	prefixes_blood_good =     LAZYACCESS(sillystring, "prefixes_blood_good")
	prefixes_blood_bad =      LAZYACCESS(sillystring, "prefixes_blood_bad")
	suffixes_blood_good =     LAZYACCESS(sillystring, "suffixes_blood_good")
	suffixes_blood_bad =      LAZYACCESS(sillystring, "suffixes_blood_bad")

/datum/controller/subsystem/processing/artifacts/proc/artifactify(obj/item/thing, rarity_class = ART_RARITY_COMMON, rarity_override, list/overrides = list())
	if(!isitem(thing))
		CRASH("artifactify() called on non-item! yeah it only works on items.")
	///first, generate a rarity!
	var/rarity = ART_RARITY_COMMON
	if(rarity_override)
		rarity = rarity_override
	else
		rarity = roll_rarity(rarity_class)
	/// now, roll some effects
	var/list/effectlist = roll_effects(rarity, thing)
	var/rolled_buff = prob(LAZYACCESS(helpful_chances, rarity))
	/// check if our item has an artifact component
	if(!SEND_SIGNAL(thing, COMSIG_ITEM_HAS_ARTIFACT_COMPONENT))
		AddComponent(thing, /datum/component/artifact) // welcome to life, little artifact!
	var/list/parms = generate_override_lists(effectlist, rolled_buff, overrides)
	/// and now the actual artifactification!
	for(var/fx in effectlist)
		var/list/my_parms = parms[fx]
		SEND_SIGNAL(thing, COMSIG_ITEM_ADD_EFFECT, fx, my_parms)

/datum/controller/subsystem/processing/artifacts/proc/generate_override_lists(list/effectlist, rolled_buff, list/overrides = list())
	var/list/parm_out = list()
	for(var/fx in effect_list)
		parm_out[fx] = list()
		if(rolled_buff)
			parm_out[fx][ARTVAR_IS_BUFF] = TRUE
		if(fx in overrides)
			parm_out[fx] |= overrides[fx]
	return parm_out

/datum/controller/subsystem/processing/artifacts/proc/roll_effects(rarity = ART_RARITY_COMMON, obj/item/thing)
	var/list/effectlist = list()
	var/max_effects = LAZYACCESS(max_effects_by_rarity, rarity)
	var/min_effects = LAZYACCESS(min_effects_by_rarity, rarity)
	var/number_of_effects = rand(floor(max_effects * 0.5), max_effects)
	var/effect_pool_pre = LAZYACCESS(allowed_effects_by_rarity, rarity)
	var/effect_pool = effect_pool_pre.Copy()
	for(var/fx in effect_pool)
		if(rolled_buff && (fx in bad_effects))
			effect_pool -= fx
		var/datum/artifact_effect/effect = LAZYACCESS(all_effects, fx)
		if(!effect.thing_can_take_effect(thing))
			effect_pool -= fx
	for(var/i in 1 to number_of_effects)
		if(!LAZYLEN(effect_pool)) // we... ran out?
			effectlist += ARTMOD_RADIATION // fuck it, its radioactive
			break
		var/rolled_effect = pickweight(effect_pool)
		var/datum/artifact_effect/effect = LAZYACCESS(all_effects, rolled_effect)
		if(!effect.allow_dupes)
			effect_pool -= rolled_effect
		effectlist += rolled_effect
	return effectlist

/datum/controller/subsystem/processing/artifacts/proc/roll_rarity(rarity_class = ART_RARITY_COMMON)
	var/rareness = ART_RARITY_COMMON
	switch(rarity_class)
		if(ART_RARITY_COMMON)
			rarity = pickweight(common_spawner_distribution)
		if(ART_RARITY_UNCOMMON)
			rarity = pickweight(uncommon_spawner_distribution)
		if(ART_RARITY_RARE)
			rarity = pickweight(rare_spawner_distribution)
	return rarity

/datum/controller/subsystem/processing/artifacts/proc/generate_name(datum/component/artifact/art, list/effectlist = list(), rarity = ART_RARITY_COMMON)
	if(rarity >= ART_RARITY_RARE)
		generate_rare_name()
		return
	var/number_of_effects = LAZYLEN(effectlist)
	var/list/suffixes = list()
	var/list/prefixes = list()
	for(var/i in 1 to min(number_of_effects, max_prefixes + max_suffixes))
		var/datum/artifact_effect/effect = pick(effectlist)
		if(prob(75) && LAZYLEN(suffixes) < max_suffixes)
			prefixes += "[capitalize(effect.get_prefix())]"
		else if(LAZYLEN(prefixes) < max_prefixes)
			suffixes += "[capitalize(effect.get_suffix())]"
		else
			break // all full!
	var/prefix_string = ""
	if(LAZYLEN(prefixes))
		prefix_string = "[prefixes.Join(" ")] "
	var/suffix_string = ""
	if(LAZYLEN(suffixes))
		suffix_string = " of [english_list(suffixes)]"
	return "[prefix_string][art.get_name()][suffix_string]" // flaming burning mushroom pizza of choking and death

/datum/controller/subsystem/processing/artifacts/proc/generate_rare_name()
	identified_preposition = "The"
	var/prefix = pick(rare_prefixes)
	var/suffix = pick(rare_suffix)
	return "[prefix][suffix]"

//////////////////////////////////////////////////
/// unique artifacts! holds a list of effects, ranges for those effects, name, item, the whole fuckdangle
/datum/artifact_unique
	var/name
	var/true_name
	var/obj/item/thingpath
	var/list/effects = list()
	var/color = "#FFFFFF"
	var/icon
	var/icon_state
	var/chance
	/// Only a certain number can spawn
	var/num_available = 1

/datum/artifact_unique/New() // only generated by the subsystem to be used as templates
	if(!true_name)
		true_name = name



