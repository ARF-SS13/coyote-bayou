/// processing subsystem for generating and ticking artifacts
/// Artifacts are basically diablo 2 style magic items
PROCESSING_SUBSYSTEM_DEF(artifacts)
	name = "Artifacts"
	flags = SS_BACKGROUND
	wait = 1 SECONDS
	init_order = INIT_ORDER_ARTIFACT

	/// Number of artifacts in existence
	var/list/number_of_artifacts = list(
		ART_RARITY_COMMON = 0,
		ART_RARITY_UNCOMMON = 0,
		ART_RARITY_RARE = 0,
		ART_RARITY_UNIQUE = 0,
	)
	var/list/number_of_effects = list(
		ART_RARITY_COMMON = 0,
		ART_RARITY_UNCOMMON = 0,
		ART_RARITY_RARE = 0,
		ART_RARITY_UNIQUE = 0,
	)

	var/spawn_chance = 0.1 // chance for an artifact to spawn per tick
	var/use_valid_ball_spawner_chance = 75 // chance for an artifact to use a valid ball spawner

	var/buff_ratio_chance = 85 // chance for an artifact to use the buff ratio
	var/buff_ratio = 0.5 // half will be buffs, half will be bad. rounds up. or down. i forget which
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
	var/list/existing_uniques = list()

	var/list/unique_templates = list()

	var/list/all_effects = list()
	var/list/all_effects_stripped = list()
	var/list/bad_effects = list()
	var/list/bad_effects_stripped = list()

	var/list/allowed_effects_by_rarity = list(
		ART_RARITY_COMMON = list(),
		ART_RARITY_UNCOMMON = list(),
		ART_RARITY_RARE = list(),
	)

	var/list/common_spawner_distribution = list(
		ART_RARITY_COMMON = 100,
		ART_RARITY_UNCOMMON = 10,
		ART_RARITY_RARE = 1,
		ART_RARITY_UNIQUE = 0.00000001, // lol
	)
	var/list/uncommon_spawner_distribution = list(
		ART_RARITY_COMMON = 25,
		ART_RARITY_UNCOMMON = 100,
		ART_RARITY_RARE = 10,
		ART_RARITY_UNIQUE = 0.1,
	)
	var/list/rare_spawner_distribution = list(
		ART_RARITY_COMMON = 5,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 100,
		ART_RARITY_UNIQUE = 1,
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

	var/list/artifactible_items = list(
		/obj/item/toy/tennis,
		/obj/item/toy/gun,
		/obj/item/toy/sword,
		/obj/item/toy/talking,
		/obj/item/toy/clockwork_watch,
		/obj/item/toy/toy_dagger,
		/obj/item/toy/toy_xeno,
		/obj/item/toy/cattoy,
		// /obj/item/toy/figure,
		/obj/item/toy/seashell,
		/obj/item/trash,
		/obj/item/taster,
		/obj/item/candle,
		/obj/item/extinguisher/mini,
		/obj/item/toy/plush,
		/obj/item/laser_pointer,
		/obj/item/healthanalyzer,
	)
	var/list/unartifactible_items = list(
		/obj/item/candle/tribal_torch,
	)

	var/blood_target_common_minimum = BLOOD_VOLUME_SYMPTOMS_MINOR
	var/blood_target_uncommon_minimum = BLOOD_VOLUME_SYMPTOMS_ANNOYING
	var/blood_target_rare_minimum = BLOOD_VOLUME_SYMPTOMS_WORST
	var/blood_rate_common_maximum = 0.5
	var/blood_rate_uncommon_maximum = 3
	var/blood_rate_rare_maximum = 10
	var/blood_discrete = 0.1

	var/radiation_target_common_maximum = 1000
	var/radiation_target_uncommon_maximum = 3000
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

	var/nutrition_target_common_maximum = NUTRITION_LEVEL_FULL
	var/nutrition_rate_common_minimum = 1
	var/nutrition_rate_common_maximum = 2
	var/nutrition_target_uncommon_maximum = NUTRITION_LEVEL_FAT
	var/nutrition_rate_uncommon_minimum = 1
	var/nutrition_rate_uncommon_maximum = 3
	var/nutrition_target_rare_maximum = NUTRITION_LEVEL_FAT * 2 // uwu~
	var/nutrition_rate_rare_minimum = 2
	var/nutrition_rate_rare_maximum = 20
	var/nutrition_discrete = 1

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

	var/damage_dps_brain_common_maximum = 2
	var/damage_dps_brain_uncommon_maximum = 5
	var/damage_dps_brain_rare_maximum = 10

	var/heal_common_minimum_health = 50
	var/heal_common_maximum_health = 100
	var/heal_uncommon_minimum_health = 25
	var/heal_uncommon_maximum_health = 100
	var/heal_rare_minimum_health = 10
	var/heal_rare_maximum_health = 100
	var/heal_discrete = 0.1

	var/heal_dps_brute_common_maximum = 0.1
	var/heal_dps_brute_uncommon_maximum = 0.2
	var/heal_dps_brute_rare_maximum = 0.5

	var/heal_dps_burn_common_maximum = 0.1
	var/heal_dps_burn_uncommon_maximum = 0.2
	var/heal_dps_burn_rare_maximum = 0.5

	var/heal_dps_toxin_common_maximum = 0.1
	var/heal_dps_toxin_uncommon_maximum = 0.2
	var/heal_dps_toxin_rare_maximum = 0.5

	var/heal_dps_oxy_common_maximum = 0.1
	var/heal_dps_oxy_uncommon_maximum = 0.2
	var/heal_dps_oxy_rare_maximum = 0.5

	var/heal_dps_clone_common_maximum = 0.1
	var/heal_dps_clone_uncommon_maximum = 0.2
	var/heal_dps_clone_rare_maximum = 0.5

	var/heal_dps_brain_common_maximum = 0.1
	var/heal_dps_brain_uncommon_maximum = 0.2
	var/heal_dps_brain_rare_maximum = 0.5

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

	var/list/prefixes_nutrition_good = list()
	var/list/prefixes_nutrition_bad = list()
	var/list/suffixes_nutrition_good = list()
	var/list/suffixes_nutrition_bad = list()

	var/list/prefixes_unidentified = list()

/datum/controller/subsystem/processing/artifacts/Initialize(start_timeofday)
	populate_affix_lists()
	populate_effect_lists()
	populate_artifactibles()
	. = ..()

/datum/controller/subsystem/processing/artifacts/stat_entry(msg)
	var/allarts = LAZYLEN(all_artifacts[ART_RARITY_COMMON]) + LAZYLEN(all_artifacts[ART_RARITY_UNCOMMON]) + LAZYLEN(all_artifacts[ART_RARITY_RARE])
	var/artc = LAZYLEN(all_artifacts[ART_RARITY_COMMON])
	var/artu = LAZYLEN(all_artifacts[ART_RARITY_UNCOMMON])
	var/artr = LAZYLEN(all_artifacts[ART_RARITY_RARE])
	var/plen = LAZYLEN(processing)
	var/alleffects = LAZYLEN(all_effects[ART_RARITY_COMMON]) + LAZYLEN(all_effects[ART_RARITY_UNCOMMON]) + LAZYLEN(all_effects[ART_RARITY_RARE])
	var/aec = LAZYLEN(all_effects[ART_RARITY_COMMON])
	var/aeu = LAZYLEN(all_effects[ART_RARITY_UNCOMMON])
	var/aer = LAZYLEN(all_effects[ART_RARITY_RARE])
	msg = "A:[allarts]([artc]:[artu]:[artr]-P:[plen])/E[alleffects]([aec]:[aeu]:[aer]):-C:[round(cost,0.005)]"
	return ..()

/datum/controller/subsystem/processing/artifacts/fire(resumed = 0)
	if (!resumed)
		currentrun = processing.Copy()
	//cache for sanic speed (lists are references anyways)
	var/list/current_run = currentrun

	while(current_run.len)
		var/datum/thing = current_run[current_run.len]
		current_run.len--
		if(QDELETED(thing))
			processing -= thing
		else if(thing.process(wait) == PROCESS_KILL)
			// fully stop so that a future START_PROCESSING will work
			STOP_PROCESSING(src, thing)
		if (MC_TICK_CHECK)
			return
	attempt_spawn_artifact()

/datum/controller/subsystem/processing/artifacts/proc/attempt_spawn_artifact()
	if(!prob(spawn_chance))
		return
	var/turf/put_here
	if(prob(use_valid_ball_spawner_chance))
		var/coordz = pick(SSvalidball.valid_ball_spawner_coords)
		put_here = coords2turf(coordz)
		if(!isturf(put_here))
			return // shrug
	else
		put_here = find_safe_turf(zlevels = 1)


	var/randomitem = pick(artifactible_items)
	if(!ispath(randomitem))
		return
	var/obj/item/chunk = new randomitem()

/datum/controller/subsystem/processing/artifacts/proc/populate_artifactibles()
	var/list/output = list()
	for(var/thingpath in artifactible_items)
		output |= typesof(thingpath)
	var/list/ingrab = list()
	for(var/thing in unartifactible_items)
		ingrab |= typesof(thing)
	output -= ingrab
	artifactible_items = output
	
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
		if(AE.special_spawn_only)
			continue
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
	prefixes_nutrition_good = LAZYACCESS(sillystring, "prefixes_nutrition_good")
	prefixes_nutrition_bad =  LAZYACCESS(sillystring, "prefixes_nutrition_bad")
	suffixes_nutrition_good = LAZYACCESS(sillystring, "suffixes_nutrition_good")
	suffixes_nutrition_bad =  LAZYACCESS(sillystring, "suffixes_nutrition_bad")

/datum/controller/subsystem/processing/artifacts/proc/uniqueify(obj/item/thing, list/overrides = list())
	if(!isitem(thing))
		CRASH("uniqueify() called on non-item! yeah it only works on items.")
	var/unique_tag
	if((LAZYACCESS(overrides, ART_FORCE_SPECIFIC_UNIQUE)) in unique_templates)
		unique_tag = LAZYACCESS(overrides, ART_FORCE_SPECIFIC_UNIQUE)
	else
		unique_tag = roll_unique(thing)
	var/datum/artifact_unique/unique_template = LAZYACCESS(unique_templates, unique_tag)
	if(!istype(unique_template))
		CRASH("uniqueify() called with invalid unique tag [unique_tag]!!!!!!!!!!!!!!!!!!!!!!!")
	var/list/effects = unique_template.get_unique_effects(thing)
	effectify(thing, effects)
	sig_reg(thing)
	catalogue_artifact()

/datum/controller/subsystem/processing/artifacts/proc/roll_unique(obj/item/thing)
	if(!isitem(thing))
		CRASH("roll_unique() called on non-item! yeah it only works on items.")
	var/list/unique_rollers = list()
	for(var/ukey in unique_templates)
		var/datum/artifact_unique/unique_template = LAZYACCESS(unique_templates, ukey)
		if(!istype(unique_template))
			continue
		if(!unique_template.chance)
			continue
		if(unique_template.num_available <= 0)
			continue
		if(!istype(thing, unique_template.prefered))
			continue
		unique_rollers[ukey] = unique_template.chance
	var/rolled = pickweight(unique_rollers)
	return rolled

/datum/controller/subsystem/processing/artifacts/proc/artifactify(obj/item/thing, rarity_class = ART_RARITY_COMMON, rarity_override, list/overrides = list())
	if(!isitem(thing))
		CRASH("artifactify() called on non-item! yeah it only works on items.")
	///first, generate a rarity!
	var/rarity = ART_RARITY_COMMON
	if(rarity_override)
		rarity = rarity_override
	else
		rarity = roll_rarity(rarity_class)
	if(rarity >= ART_RARITY_UNIQUE)
		uniqueify(thing, overrides)
		return
	var/datum/artifact_unique
	var/list/effectlist = roll_effects(rarity, thing, overrides)
	var/rolled_buff = prob(LAZYACCESS(helpful_chances, rarity))
	var/list/parms = generate_override_lists(effectlist, rolled_buff, overrides)
	/// now, roll some effects
	/// check if our item has an artifact component
	if(!SEND_SIGNAL(thing, COMSIG_ITEM_ARTIFACT_EXISTS))
		AddComponent(thing, /datum/component/artifact) // welcome to life, little artifact!
	/// and now the actual artifactification!
	effectify(thing, effectlist, parms)
	sig_reg(thing)
	catalogue_artifact(thing, effectlist, rarity)

/datum/controller/subsystem/processing/artifacts/proc/effectify(obj/item/thing, list/effectlist, list/parms, datum/artifact_unique/unique)
	for(var/fx in effectlist)
		SEND_SIGNAL(thing, COMSIG_ITEM_ARTIFACT_ADD_EFFECT, fx, LAZYACCESS(parms, fx))
	if(istype(unique, /datum/artifact_unique))
		SEND_SIGNAL(thing, COMSIG_ITEM_ARTIFACT_MAKE_UNIQUE, unique)

/datum/controller/subsystem/processing/artifacts/proc/catalogue_artifact(obj/item/thing, list/effectlist, rarity, unique_tag)
	if(unique_tag)
		existing_uniques += "[unique_tag]"
	number_of_artifacts[rarity] += 1
	number_of_effects[rarity] += LAZYLEN(effectlist)
	all_artifacts += WEAKREF(thing)
	switch(rarity)
		if(ART_RARITY_COMMON)
			common_artifacts |= WEAKREF(thing)
		if(ART_RARITY_UNCOMMON)
			uncommon_artifacts |= WEAKREF(thing)
		if(ART_RARITY_RARE)
			rare_artifacts |= WEAKREF(thing)

/datum/controller/subsystem/processing/artifacts/proc/sig_reg(obj/item/thing)
	RegisterSignal(thing, COMSIG_PARENT_PREQDELETED, .proc/artifact_deleted, TRUE)

/datum/controller/subsystem/processing/artifacts/proc/artifact_deleted(obj/item/thing)
	if(!isitem(thing))
		CRASH("artifact_deleted() called on non-item! yeah it only works on items.")
	var/datum/weakref/weakthing = WEAKREF(thing)
	all_artifacts -= weakthing
	common_artifacts -= weakthing
	uncommon_artifacts -= weakthing
	rare_artifacts -= weakthing
	var/datum/component/artifact/art = thing.GetComponent(/datum/component/artifact)
	if(!art)
		return
	var/rarity = art.rarity
	var/unique_tag = art.unique_tag
	var/effect_num = LAZYLEN(art.effects)
	number_of_artifacts[rarity] -= 1
	number_of_effects[rarity] -= effect_num
	if(unique_tag)
		existing_uniques -= "[unique_tag]"
		var/datum/artifact_unique/AU = LAZYACCESS(unique_templates, unique_tag)
		if(istype(AU))
			AU.num_available = min(AU.num_available + 1, initial(AU.num_available))

/datum/controller/subsystem/processing/artifacts/proc/generate_override_lists(list/effectlist, rolled_buff, list/overrides = list())
	var/list/parm_out = list()
	for(var/fx in effectlist)
		parm_out[fx] = list()
		if(rolled_buff)
			parm_out[fx][ARTVAR_IS_BUFF] = TRUE
		if(fx in overrides)
			parm_out[fx] |= overrides[fx]
	return parm_out

/datum/controller/subsystem/processing/artifacts/proc/roll_effects(rarity = ART_RARITY_COMMON, obj/item/thing, list/overrides = list())
	var/list/effectlist = list()
	var/max_effects = LAZYACCESS(max_effects_by_rarity, rarity)
	var/min_effects = LAZYACCESS(min_effects_by_rarity, rarity)
	var/number_of_effects = rand(round(max_effects * 0.5), max_effects)
	for(var/over_fx in overrides)
		if(over_fx in all_effects)
			effectlist += over_fx
	/// now adjust the number of effects based on the overrides
	if(LAZYLEN(effectlist) >= number_of_effects)
		return effectlist // all done!
	number_of_effects -= LAZYLEN(effectlist)
	var/effect_pool = filter_effect_pool(rarity, thing, LAZYACCESS(allowed_effects_by_rarity, rarity))
	var/num_buffs = 0
	if(prob(buff_ratio_chance))
		num_buffs = round(number_of_effects * buff_ratio)
	for(var/i in 1 to min(number_of_effects, LAZYLEN(effect_pool)))
		if(!LAZYLEN(effect_pool)) // we... ran out?
			effectlist += ARTMOD_RADIATION // fuck it, its radioactive
			break
		var/rolled_effect = pickweight(effect_pool)
		var/datum/artifact_effect/effect = LAZYACCESS(all_effects, rolled_effect)
		if(!effect.allow_dupes)
			effect_pool -= rolled_effect
		effectlist += rolled_effect
	return effectlist

/datum/controller/subsystem/processing/artifacts/proc/filter_effect_pool(rarity = ART_RARITY_COMMON, obj/item/thing, list/effects = list())
	if(!LAZYLEN(effects))
		return list(ARTMOD_RADIATION)
	var/fx_puddle = list()
	for(var/fx in effects) // todo: this
		// if(rolled_buff && (fx in bad_effects))
		// 	fx_puddle -= fx
		var/datum/artifact_effect/effect = LAZYACCESS(all_effects, fx)
		// if(!effect.thing_can_take_effect(thing))
		// 	fx_puddle -= fx
		fx_puddle[fx] = effect.chance_weight
	return fx_puddle

/datum/controller/subsystem/processing/artifacts/proc/roll_rarity(rarity_class = ART_RARITY_COMMON)
	var/rareness = ART_RARITY_COMMON
	switch(rarity_class)
		if(ART_RARITY_COMMON)
			rareness = pickweight(common_spawner_distribution)
		if(ART_RARITY_UNCOMMON)
			rareness = pickweight(uncommon_spawner_distribution)
		if(ART_RARITY_RARE)
			rareness = pickweight(rare_spawner_distribution)
	return rareness

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
/// unique artifacts! holds a list of effects, ranges for those effects, name, item, the whole fuckdangle
/datum/artifact_unique
	var/key = "Diggler"
	var/name
	var/true_name
	var/true_desc
	var/obj/item/prefered = /obj/item
	var/color = "#FFFFFF"
	var/icon
	var/icon_state
	var/chance
	/// Only a certain number can spawn
	var/num_available = 1
	var/value = 6000
	var/list/base_overrides = list()
	var/list/visible_jobs = ART_SCI_JOBS
	var/use_alternate_appearance = TRUE

/datum/artifact_unique/New() // only generated by the subsystem to be used as templates
	if(!true_name)
		true_name = name
	generate_base_overrides()

/datum/artifact_unique/proc/generate_base_overrides()
	base_overrides[ART_UNIQUE_TAG] = "[key]" // for getting the right vars n shit

/datum/artifact_unique/proc/get_unique_effects()
	return list()

/datum/artifact_unique/apotheosis
	key = ART_UNIQUE_APOTHEOSIS
	name = "perfect gem"
	true_name = "Apotheosis"
	true_desc = "Most artifacts are flawed in some way or another, except for this one. Apotheosis is the closest thing an artifact comes to \
		'perfection', combining every positive aspect of other artifacts into one."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "pustishka"
	value = 6000
	var/brute_heal = -0.5
	var/burn_heal =  -0.5
	var/tox_heal =   -0.5
	var/oxy_heal =   -0.5
	var/clone_heal = -0.5
	var/brain_heal = -0.5
	var/stam_heal =  -0.5
	var/blood_heal =  0.5
	var/blood_max =   BLOOD_VOLUME_NORMAL
	var/min_heal =   -INFINITY
	var/max_heal =    INFINITY
	var/rad_heal =    0.5
	var/rad_target =  0
	var/max_hp =      10
	var/speed_up =   -0.5
	var/nut_heal =    0.5
	var/max_nut =     NUTRITION_LEVEL_FED

/datum/artifact_unique/apotheosis/get_unique_effects()
	var/list/heal_vars = list(
		ARTVAR_BRUTE = round(rand(0.1, brute_heal)),
		ARTVAR_BURN = round(rand(0.1, burn_heal)),
		ARTVAR_TOXIN = round(rand(0.1, tox_heal)),
		ARTVAR_OXY = round(rand(0.1, oxy_heal)),
		ARTVAR_CLONE = round(rand(0.1, clone_heal)),
		ARTVAR_BRAIN = round(rand(0.1, brain_heal)),
		ARTVAR_MIN_HEALTH = min_heal,
		ARTVAR_MAX_HEALTH = max_heal,
	)
	var/list/stam_vars = list(
		ARTVAR_STAMINA_ADJUSTMENT = round(rand(0.1, stam_heal)),
	)
	var/list/blood_vars = list(
		ARTVAR_BLOOD_ADJUSTMENT = round(rand(0.1, blood_heal)),
		ARTVAR_TARGET_BLOOD = blood_max,
	)
	var/list/rad_vars = list(
		ARTVAR_RADIATION_ADJUSTMENT = round(rand(0.1, rad_heal)),
		ARTVAR_TARGET_RADIATION = rad_target,
	)
	var/list/speed_vars = list(
		ARTVAR_SPEED_ADJUSTMENT = round(rand(0.1, speed_up)),
	)
	var/list/nut_vars = list(
		ARTVAR_NUTRITION_ADJUSTMENT = round(rand(0.1, nut_heal)),
		ARTVAR_TARGET_NUTRITION = max_nut,
	)
	var/list/hp_vars = list(
		ARTVAR_HP_CHANGE = max_hp,
	)
	var/list/overrides = list(
		ARTMOD_MAX_HP =	hp_vars.Copy(),
		ARTMOD_SPEED = speed_vars.Copy(),
		ARTMOD_PASSIVE_HEAL = heal_vars.Copy(),
		ARTMOD_STAMINA = stam_vars.Copy(),
		ARTMOD_RADIATION = rad_vars.Copy(),
		ARTMOD_BLOOD = blood_vars.Copy(),
		ARTMOD_FEEDER = nut_vars.Copy(),
	)
	return overrides

/datum/artifact_unique/perfection
	key = ART_UNIQUE_PERFECTION
	name = "perfect gem"
	true_name = "Perfection"
	true_desc = "Most artifacts are flawed in some way or another, except for this one. Perfection, is the closest thing an artifact comes to \
		'perfection', at least in one aspect."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "pustishka_q"
	value = 6000
	var/max_mod = 2
	var/min_mod = 1.5

/datum/artifact_unique/perfection/get_unique_effects()
	var/effect = pick(SSartifacts.all_effects - SSartifacts.bad_effects)
	var/list/output = list()
	var/list/best_effects = list()
	var/multiplier = rand(min_mod, max_mod)
	switch(effect)
		if(ARTMOD_BLOOD)
			best_effects[ARTVAR_BLOOD_ADJUSTMENT] = SSartifacts.blood_rate_rare_maximum * multiplier
			best_effects[ARTVAR_TARGET_BLOOD] = BLOOD_VOLUME_NORMAL
		if(ARTMOD_FEEDER)
			best_effects[ARTVAR_NUTRITION_ADJUSTMENT] = SSartifacts.nutrition_rate_rare_maximum * multiplier
			best_effects[ARTVAR_TARGET_NUTRITION] = NUTRITION_LEVEL_FAT
		if(ARTMOD_MAX_HP)
			best_effects[ARTVAR_HP_CHANGE] = SSartifacts.health_rare_maximum * multiplier
		if(ARTMOD_PASSIVE_HEAL)
			switch(rand(1, 6))
				if(1)
					best_effects[ARTVAR_BRUTE] = SSartifacts.heal_dps_brute_rare_maximum * multiplier
				if(2)
					best_effects[ARTVAR_BURN] = SSartifacts.heal_dps_burn_rare_maximum * multiplier
				if(3)
					best_effects[ARTVAR_TOXIN] = SSartifacts.heal_dps_toxin_rare_maximum * multiplier
				if(4)
					best_effects[ARTVAR_OXY] = SSartifacts.heal_dps_oxy_rare_maximum * multiplier
				if(5)
					best_effects[ARTVAR_CLONE] = SSartifacts.heal_dps_clone_rare_maximum * multiplier
				if(6)
					best_effects[ARTVAR_BRAIN] = SSartifacts.heal_dps_brain_rare_maximum * multiplier
			best_effects[ARTVAR_MIN_HEALTH] = -100
			best_effects[ARTVAR_MAX_HEALTH] = 200
		if(ARTMOD_RADIATION)
			best_effects[ARTVAR_RADIATION_ADJUSTMENT] = SSartifacts.radiation_rate_rare_maximum * multiplier
			best_effects[ARTVAR_TARGET_RADIATION] = 0
		if(ARTMOD_SPEED)
			best_effects[ARTVAR_SLOWDOWN] = SSartifacts.speed_rare_maximum * multiplier
		if(ARTMOD_STAMINA)
			best_effects[ARTVAR_STAMINA_ADJUSTMENT] = SSartifacts.stamina_rate_rare_maximum * multiplier
	output[effect] = best_effects
	return output

/datum/artifact_unique/penance
	key = ART_UNIQUE_PENANCE
	name = "painful gem"
	true_name = "Penance"
	true_desc = "This artifact hurts to look at, and simply being near it causes one's being to ache. If one were to carry this in their \
		jacket, there is no doubt they would suffer greatly. However, in that suffering, there's a vague sense of a promise, that if one \
		were to suffer enough, they would be rewarded. Whether or not the reward is more pain isn't clear."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "pustishka_old"
	value = 6000
	var/brute_harm = -0.5
	var/burn_harm =  -0.5
	var/tox_harm =   -0.5
	var/oxy_harm =   -0.5
	var/stam_harm =  -0.5
	var/blood_heal =  1
	var/blood_max =   BLOOD_VOLUME_SYMPTOMS_DEBILITATING
	var/min_damage =  5
	var/rad_heal =    0.5
	var/rad_target =  RAD_MOB_VOMIT
	var/max_hp =      -10
	var/speed_down =  0.5
	var/nut_eat =    -0.5
	var/max_nut =     0

/datum/artifact_unique/penance/get_unique_effects()
	var/list/harm_vars = list(
		ARTVAR_BRUTE = brute_harm,
		ARTVAR_BURN = burn_harm,
		ARTVAR_TOXIN = tox_harm,
		ARTVAR_OXY = oxy_harm,
		ARTVAR_MIN_HEALTH = min_damage,
	)
	var/list/stam_vars = list(
		ARTVAR_STAMINA_ADJUSTMENT = stam_harm,
	)
	var/list/blood_vars = list(
		ARTVAR_BLOOD_ADJUSTMENT = blood_heal,
		ARTVAR_TARGET_BLOOD = blood_max,
	)
	var/list/rad_vars = list(
		ARTVAR_RADIATION_ADJUSTMENT = rad_heal,
		ARTVAR_TARGET_RADIATION = rad_target,
	)
	var/list/speed_vars = list(
		ARTVAR_SPEED_ADJUSTMENT = speed_down,
	)
	var/list/nut_vars = list(
		ARTVAR_NUTRITION_ADJUSTMENT = nut_eat,
		ARTVAR_TARGET_NUTRITION = max_nut,
	)
	var/list/hp_vars = list(
		ARTVAR_HP_CHANGE = max_hp,
	)
	var/list/overrides = list(
		ARTMOD_MAX_HP =	hp_vars.Copy(),
		ARTMOD_SPEED = speed_vars.Copy(),
		ARTMOD_PASSIVE_DOT_RANDOM = harm_vars.Copy(),
		ARTMOD_STAMINA = stam_vars.Copy(),
		ARTMOD_RADIATION = rad_vars.Copy(),
		ARTMOD_BLOOD = blood_vars.Copy(),
		ARTMOD_FEEDER = nut_vars.Copy(),
	)
	return overrides

/datum/artifact_unique/bubble
	key = ART_UNIQUE_BUBBLE
	name = "delicious gem"
	true_name = "Bubble"
	true_desc = "A delicious smell radiates from this artifact, constantly shifting to match the desires of the one who holds it. \
		The so called 'Bubble' is known for its ability to feed whoever holds it, and is often used by those who are too lazy to \
		cook for themselves. Supposedly got its name from the effect it has its owner's waistline."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "bubble"
	value = 6000
	var/nut_target = NUTRITION_LEVEL_FAT * 2
	var/nut_rate = 4

/datum/artifact_unique/penance/get_unique_effects()
	var/list/nut_vars = list(
		ARTVAR_NUTRITION_ADJUSTMENT = nut_eat,
		ARTVAR_TARGET_NUTRITION = max_nut,
	)
	var/list/overrides = list(
		ARTMOD_FEEDER = nut_vars.Copy(),
	)
	return overrides

///////////////////////////////////////////////////////////
/datum/atom_hud/alternate_appearance/basic/artifact
	var/visible_jobs = list()

/datum/atom_hud/alternate_appearance/basic/artifact/New(list/visible_jobs = list())
	..()
	src.visible_jobs = visible_jobs
	for(var/mob in GLOB.player_list)
		if(mobShouldSee(mob))
			add_hud_to(mob)

/datum/atom_hud/alternate_appearance/basic/artifact/mobShouldSee(mob/M)
	return SEND_SIGNAL(target, COMSIG_ITEM_ARTIFACT_IDENTIFIED, visible_jobs)


/// anomalous bread


	//6000 credits
	/*
	if(M.health > 5)
		M.adjustBruteLoss(-0.5, 0, include_roboparts = TRUE)
		M.adjustFireLoss(-0.5, 0, include_roboparts = TRUE)
		M.adjustToxLoss(-0.5, 0, TRUE)
	M.adjustStaminaLoss(-0.5, 0)
	if(M.get_blood(TRUE) < (BLOOD_VOLUME_NORMAL*M.blood_ratio && M.get_blood(TRUE) > 250))
		M.blood_volume += 0.5
	if(M.radiation > 0)
		M.radiation -= min(M.radiation, 0.5)
	//on add
	M.maxHealth += 10
	M.health += 10
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/artifact, TRUE, -0.5)

	//on remove
	M.maxHealth -= 10
	M.health = min(M.health - 10, M.maxHealth)
	remove_movespeed_modifier(/datum/movespeed_modifier/artifact)
	*/

