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

	var/rare_soft_cap = 20
	var/rare_hard_cap = 30
	var/uncommon_soft_cap = 25
	var/uncommon_hard_cap = 50
	var/common_soft_cap = 50
	var/common_hard_cap = 75
	var/spawn_chance = 1 // chance for an artifact to spawn per tick
	var/use_valid_ball_spawner_chance = 0 // chance for an artifact to use a valid ball spawner

	var/list/buffs_by_rarity = list(
		ART_RARITY_COMMON = 1,
		ART_RARITY_UNCOMMON = 2,
		ART_RARITY_RARE = 3,
	)
	var/list/max_effects_by_rarity = list(
		ART_RARITY_COMMON = 1,
		ART_RARITY_UNCOMMON = 2,
		ART_RARITY_RARE = 4,
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
	var/list/bad_effects = list()

	var/list/allowed_effects_by_rarity = list(
		ART_RARITY_COMMON = list(),
		ART_RARITY_UNCOMMON = list(),
		ART_RARITY_RARE = list(),
	)

	var/list/random_spawn_distribution = list(
		ART_RARITY_COMMON = 100,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 10,
		// ART_RARITY_UNIQUE = 0.1,
	)

	var/list/common_spawner_distribution = list(
		ART_RARITY_COMMON = 100,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 10,
		// ART_RARITY_UNIQUE = 0.1,
	)
	var/list/uncommon_spawner_distribution = list(
		ART_RARITY_COMMON = 25,
		ART_RARITY_UNCOMMON = 100,
		ART_RARITY_RARE = 10,
		// ART_RARITY_UNIQUE = 0.1,
	)
	var/list/rare_spawner_distribution = list(
		ART_RARITY_COMMON = 5,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 100,
		// ART_RARITY_UNIQUE = 1,
	)

	var/list/common_spawner_distribution_softcap = list(
		ART_RARITY_INHIBIT = 200,
		ART_RARITY_COMMON = 100,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 10,
		// ART_RARITY_UNIQUE = 0.1,
	)
	var/list/uncommon_spawner_distribution_softcap = list(
		ART_RARITY_INHIBIT = 100,
		ART_RARITY_COMMON = 25,
		ART_RARITY_UNCOMMON = 100,
		ART_RARITY_RARE = 10,
		// ART_RARITY_UNIQUE = 0.1,
	)
	var/list/rare_spawner_distribution_softcap = list(
		ART_RARITY_INHIBIT = 5,
		ART_RARITY_COMMON = 5,
		ART_RARITY_UNCOMMON = 50,
		ART_RARITY_RARE = 100,
		// ART_RARITY_UNIQUE = 1,
	)

	/// chance for an effect to be a buff instead of somewhere between buff and debuff
	var/list/helpful_chances = list(
		ART_RARITY_COMMON = 50,
		ART_RARITY_UNCOMMON = 25,
		ART_RARITY_RARE = 15,
	)

	var/allow_bads = FALSE // no b ad, only good

	// 200 ** 200 = 4e+120
	var/list/rare_prefixes = list()
	var/list/rare_suffixes = list()

	var/list/artifactible_items = list(
		/obj/item/toy,
		/obj/item/trash,
		/obj/item/taster,
		// /obj/item/candle, // ironically next to impossible to see
		/obj/item/extinguisher/mini,
		/* /obj/item/toy/plush/carpplushie,
		/obj/item/toy/plush/bubbleplush,
		/obj/item/toy/plush/narplush/hugbox,
		/obj/item/toy/plush/lizardplushie,
		/obj/item/toy/plush/slimeplushie,
		/obj/item/toy/plush/beeplushie,
		/obj/item/toy/plush/mothplushie,
		/obj/item/toy/plush/lampplushie,
		/obj/item/toy/plush/box,
		/obj/item/toy/plush/slaggy,
		/obj/item/toy/plush/mr_buckety,
		/obj/item/toy/plush/dr_scanny,
		/obj/item/toy/plush/borgplushie,
		/obj/item/toy/plush/borgplushie/medihound,
		/obj/item/toy/plush/borgplushie/scrubpuppy,
		/obj/item/toy/plush/aiplush,
		/obj/item/toy/plush/snakeplushie,
		/obj/item/toy/plush/mammal/fox,
		/obj/item/toy/plush/mammal/fox/fuzzy,
		/obj/item/toy/plush/catgirl/fermis,
		/obj/item/toy/plush/hairball, */
		/obj/item/laser_pointer,
		/obj/item/healthanalyzer,
		/obj/item/pda,
		/obj/item/dice,
		/obj/item/latexballon,
		// /obj/item/organ, // totally not a horrible horrible idea
		/obj/item/weapon/dvd,
		/obj/item/fishy,
		/obj/item/binoculars,
		/obj/item/laser_pointer,
		/obj/item/cardboard_cutout,
		/obj/item/flashlight,
	)

	var/list/unartifactible_items = list(
		/obj/item/toy/plush/mammal/fox/squishfox, // its too powerful
	)
	//These specific items, but not their subtypes, are not allowed
	var/list/specific_unartifactable_items = list(
		/obj/item/trash/f13,
	)
	
	var/identify_time = ART_IDENT_TIME
	var/identify_max_delta = ART_IDENT_MAX_DELTA
	var/identify_trait = TRAIT_ARTIFACT_IDENTIFY

	var/fuzzy_time = FALSE
	var/fuzzy_time_low = 0.9
	var/fuzzy_time_high = 1.1

	var/blood_target_good_common_min = BLOOD_VOLUME_SAFE
	var/blood_target_good_common_max = BLOOD_VOLUME_SAFE
	var/blood_target_good_uncommon_min = BLOOD_VOLUME_SAFE
	var/blood_target_good_uncommon_max = BLOOD_VOLUME_SAFE
	var/blood_target_good_rare_min = BLOOD_VOLUME_SAFE
	var/blood_target_good_rare_max = BLOOD_VOLUME_SAFE
	var/blood_target_bad_common_min = BLOOD_VOLUME_SYMPTOMS_ANNOYING
	var/blood_target_bad_common_max = BLOOD_VOLUME_SAFE
	var/blood_target_bad_uncommon_min = BLOOD_VOLUME_SYMPTOMS_DEBILITATING
	var/blood_target_bad_uncommon_max = BLOOD_VOLUME_SYMPTOMS_WARN
	var/blood_target_bad_rare_min = BLOOD_VOLUME_SYMPTOMS_WORST
	var/blood_target_bad_rare_max = BLOOD_VOLUME_SYMPTOMS_ANNOYING
	var/blood_rate_common_min = 0.1
	var/blood_rate_common_max = 0.25
	var/blood_rate_uncommon_min = 0.5
	var/blood_rate_uncommon_max = 2
	var/blood_rate_rare_min = 3
	var/blood_rate_rare_max = 5
	var/blood_discrete = 0.1

	var/radiation_target_bad_common_min = 600
	var/radiation_target_bad_common_max = 1000
	var/radiation_target_bad_uncommon_min = 1000
	var/radiation_target_bad_uncommon_max = 3000
	var/radiation_target_bad_rare_min = 2000
	var/radiation_target_bad_rare_max = 10000
	var/radiation_target_good_common_min = 100
	var/radiation_target_good_common_max = 300
	var/radiation_target_good_uncommon_min = 25
	var/radiation_target_good_uncommon_max = 100
	var/radiation_target_good_rare_min = 0
	var/radiation_target_good_rare_max = 50
	var/radiation_rate_common_min = -5
	var/radiation_rate_common_max = -15
	var/radiation_rate_uncommon_min = -15
	var/radiation_rate_uncommon_max = -25
	var/radiation_rate_rare_min = -25
	var/radiation_rate_rare_max = -50
	var/radiation_discrete = 1

	var/health_bad_common_min = -2
	var/health_bad_common_max = -5
	var/health_bad_uncommon_min = -10
	var/health_bad_uncommon_max = -25
	var/health_bad_rare_min = -50
	var/health_bad_rare_max = -75
	var/health_good_common_min = 5
	var/health_good_common_max = 10
	var/health_good_uncommon_min = 8
	var/health_good_uncommon_max = 22
	var/health_good_rare_min = 18
	var/health_good_rare_max = 50
	var/health_discrete = 1

	var/stamina_bad_common_min = 3
	var/stamina_bad_common_max = 1
	var/stamina_bad_uncommon_min = 5
	var/stamina_bad_uncommon_max = 3
	var/stamina_bad_rare_min = 65
	var/stamina_bad_rare_max = 3
	var/stamina_good_common_min = -6
	var/stamina_good_common_max = -8
	var/stamina_good_uncommon_min = -8
	var/stamina_good_uncommon_max = -10
	var/stamina_good_rare_min = -5
	var/stamina_good_rare_max = -65
	var/stamina_discrete = 0.1

	var/speed_bad_common_min = 0.2
	var/speed_bad_common_max = 0.5
	var/speed_bad_uncommon_min = 0.5
	var/speed_bad_uncommon_max = 1
	var/speed_bad_rare_min = 1
	var/speed_bad_rare_max = 2
	var/speed_good_common_min = -0.05
	var/speed_good_common_max = -0.15
	var/speed_good_uncommon_min = -0.15
	var/speed_good_uncommon_max = -0.25
	var/speed_good_rare_min = -0.25
	var/speed_good_rare_max = -1 // lol
	var/speed_discrete = 0.05

	var/nutrition_rate_bad_common_min = -2
	var/nutrition_rate_bad_common_max = -1
	var/nutrition_rate_bad_uncommon_min = -10
	var/nutrition_rate_bad_uncommon_max = -5
	var/nutrition_rate_bad_rare_min = -20
	var/nutrition_rate_bad_rare_max = -10
	var/nutrition_rate_good_common_min = 1
	var/nutrition_rate_good_common_max = 2
	var/nutrition_rate_good_uncommon_min = 3
	var/nutrition_rate_good_uncommon_max = 5
	var/nutrition_rate_good_rare_min = 10
	var/nutrition_rate_good_rare_max = 20 // YUM YUM YUM YUM YUM YUM YUM YUM GET FATTER GET FATTER GET FATTER GET FATTER GET FATTER GET FATTER
	var/nutrition_discrete = 1

	var/damage_common_cutoff_min = 50
	var/damage_uncommon_cutoff_min = 25
	var/damage_rare_cutoff_min = 10
	var/damage_discrete = 0.1

	var/damage_max_types_common = 1
	var/damage_max_types_uncommon = 2
	var/damage_max_types_rare = 3

	var/damage_dps_brute_common_max = 0.5
	var/damage_dps_brute_common_min = 0.3
	var/damage_dps_brute_uncommon_max = 1
	var/damage_dps_brute_uncommon_min = 0.5
	var/damage_dps_brute_rare_max = 2
	var/damage_dps_brute_rare_min = 0.5

	var/damage_dps_burn_common_max = 0.5
	var/damage_dps_burn_common_min = 0.3
	var/damage_dps_burn_uncommon_max = 1
	var/damage_dps_burn_uncommon_min = 0.5
	var/damage_dps_burn_rare_max = 2
	var/damage_dps_burn_rare_min = 0.5

	var/damage_dps_toxin_common_max = 0.5
	var/damage_dps_toxin_common_min = 0.3
	var/damage_dps_toxin_uncommon_max = 1
	var/damage_dps_toxin_uncommon_min = 0.5
	var/damage_dps_toxin_rare_max = 2
	var/damage_dps_toxin_rare_min = 0.5

	var/damage_dps_oxy_common_max = 0.5
	var/damage_dps_oxy_common_min = 0.3
	var/damage_dps_oxy_uncommon_max = 1
	var/damage_dps_oxy_uncommon_min = 0.5
	var/damage_dps_oxy_rare_max = 2
	var/damage_dps_oxy_rare_min = 0.5

	var/damage_dps_clone_common_max = 0.5
	var/damage_dps_clone_common_min = 0.3
	var/damage_dps_clone_uncommon_max = 1
	var/damage_dps_clone_uncommon_min = 0.5
	var/damage_dps_clone_rare_max = 2
	var/damage_dps_clone_rare_min = 0.5

	var/damage_dps_brain_common_max = 0.5
	var/damage_dps_brain_common_min = 0.3
	var/damage_dps_brain_uncommon_max = 1
	var/damage_dps_brain_uncommon_min = 0.5
	var/damage_dps_brain_rare_max = 2
	var/damage_dps_brain_rare_min = 0.5

	var/heal_common_min_health = 5
	var/heal_common_max_health = 100
	var/heal_uncommon_min_health = 5
	var/heal_uncommon_max_health = 100
	var/heal_rare_min_health = 5
	var/heal_rare_max_health = 100
	var/heal_discrete = 0.1

	var/heal_dps_brute_common = 0.1
	var/heal_dps_brute_uncommon = 0.2
	var/heal_dps_brute_rare = 0.5

	var/heal_dps_burn_common = 0.1
	var/heal_dps_burn_uncommon = 0.2
	var/heal_dps_burn_rare = 0.5

	var/heal_dps_toxin_common = 0.1
	var/heal_dps_toxin_uncommon = 0.2
	var/heal_dps_toxin_rare = 0.5

	var/heal_dps_oxy_common = 0.1
	var/heal_dps_oxy_uncommon = 0.2
	var/heal_dps_oxy_rare = 0.5

	var/heal_dps_clone_common = 0.1
	var/heal_dps_clone_uncommon = 0.2
	var/heal_dps_clone_rare = 0.5

	var/heal_dps_brain_common = 0.1
	var/heal_dps_brain_uncommon = 0.2
	var/heal_dps_brain_rare = 0.5

	var/heal_max_types_common = 1
	var/heal_max_types_uncommon = 2
	var/heal_max_types_rare = 3

	var/heal_armor_dr_threshold = 22 // light armor gets full heal, anything after that gets reduced

	var/list/traits_good_common = list(
	)

	var/list/traits_good_uncommon = list(

	)
	var/list/traits_good_rare = list(

	)
	var/list/quirks_good_common = list(
		// /datum/quirk/night_vision,
		/datum/quirk/empath,
		/datum/quirk/spiritual,
		/datum/quirk/alcohol_tolerance,
		/datum/quirk/nukalover,
		/datum/quirk/drunkhealing,
		/datum/quirk/playdead,
		/datum/quirk/improved_heal,
		/datum/quirk/builder,
		/datum/quirk/brickwall,
		/datum/quirk/freerunning,
		/datum/quirk/light_step,

	)
	var/list/quirks_good_uncommon = list(
		// /datum/quirk/night_vision,
		/datum/quirk/empath,
		/datum/quirk/spiritual,
		/datum/quirk/alcohol_tolerance,
		/datum/quirk/nukalover,
		/datum/quirk/drunkhealing,
		/datum/quirk/playdead,
		/datum/quirk/improved_heal,
		/datum/quirk/builder,
		/datum/quirk/brickwall,
		/datum/quirk/freerunning,
		/datum/quirk/light_step,
		/datum/quirk/shocking,
		/datum/quirk/telepathy,
		/datum/quirk/armblader,
		/datum/quirk/tentaclearm,

	)
	var/list/quirks_good_rare = list(
		// /datum/quirk/night_vision,
		/datum/quirk/empath,
		/datum/quirk/spiritual,
		/datum/quirk/alcohol_tolerance,
		/datum/quirk/nukalover,
		/datum/quirk/drunkhealing,
		/datum/quirk/playdead,
		/datum/quirk/improved_heal,
		/datum/quirk/builder,
		/datum/quirk/brickwall,
		/datum/quirk/freerunning,
		/datum/quirk/light_step,
		/datum/quirk/shocking,
		/datum/quirk/telepathy,
		/datum/quirk/armblader,
		/datum/quirk/tentaclearm,
		/datum/quirk/bowtrained,
		/datum/quirk/masterrifleman,
		/datum/quirk/wandproficient,
		// /datum/quirk/night_vision_greater,
		/datum/quirk/nohunger,
		/*/datum/quirk/artifact_identify,*/// Artifacts take 5 seconds to identify, to be upgraded eventually

	)

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

	var/art_effect_colorwobble_delay = 6 SECONDS
	var/art_effect_colorwobble_length = 6 SECONDS

	var/debug_easy_identify = FALSE
	var/debug_insta_identify = FALSE
	var/debug_spawn_message_admemes = FALSE

/datum/controller/subsystem/processing/artifacts/Initialize(start_timeofday)
	populate_affix_lists()
	populate_effect_lists()
	populate_artifactibles()
	if(debug_insta_identify || debug_easy_identify || debug_spawn_message_admemes || spawn_chance > 25)
		to_chat(world, span_phobia("Dan left the debug vars on, point and laugh!"))
	. = ..()

/datum/controller/subsystem/processing/artifacts/stat_entry(msg)
	var/allarts = (LAZYACCESS(number_of_artifacts, ART_RARITY_COMMON)) + (LAZYACCESS(number_of_artifacts, ART_RARITY_UNCOMMON)) + (LAZYACCESS(number_of_artifacts, ART_RARITY_RARE))
	var/artc = (LAZYACCESS(number_of_artifacts, ART_RARITY_COMMON))
	var/artu = (LAZYACCESS(number_of_artifacts, ART_RARITY_UNCOMMON))
	var/artr = (LAZYACCESS(number_of_artifacts, ART_RARITY_RARE))
	var/plen = LAZYLEN(processing)
	var/alleffects = (LAZYACCESS(number_of_effects, ART_RARITY_COMMON)) + (LAZYACCESS(number_of_effects, ART_RARITY_UNCOMMON)) + (LAZYACCESS(number_of_effects, ART_RARITY_RARE))
	var/aec = (LAZYACCESS(number_of_effects, ART_RARITY_COMMON))
	var/aeu = (LAZYACCESS(number_of_effects, ART_RARITY_UNCOMMON))
	var/aer = (LAZYACCESS(number_of_effects, ART_RARITY_RARE))
	msg = "A:[allarts]([artc]:[artu]:[artr]-P:[plen])/E[alleffects]([aec]:[aeu]:[aer]):-C:[round(cost,0.005)]"
	return msg

/datum/controller/subsystem/processing/artifacts/fire(resumed = 0)
	if(prob(spawn_chance))
		INVOKE_ASYNC(src,PROC_REF(spawn_random_artifact), null, null, TRUE)
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
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/processing/artifacts/proc/spawn_random_artifact(turf/spawn_here, rarity, randomroll)
	var/turf/put_here = spawn_here || get_artifactible_turf()
	if(!isturf(put_here))
		return // shrug
	var/randomitem = pick(artifactible_items)
	if(!ispath(randomitem))
		return
	
	if(randomroll)
		rarity = roll_rarity(pickweight(random_spawn_distribution), TRUE)
	if(rarity == ART_RARITY_INHIBIT)
		return // no artifact today!
	
	var/obj/item/chunk = new randomitem(put_here)
	for(var/atom/movable/AM in get_turf(chunk))
		if(SEND_SIGNAL(AM, COMSIG_CONTAINS_STORAGE))
			SEND_SIGNAL(AM, COMSIG_TRY_STORAGE_INSERT, chunk)
			break
		if(istype(AM, /obj/structure/closet))
			chunk.forceMove(AM)
	chunk.w_class = WEIGHT_CLASS_SMALL
	artifactify(chunk, null, rarity, list(ARTVAR_CRUD_IT_UP = TRUE))
	if(debug_spawn_message_admemes)
		message_admins("Spawned [chunk] at [ADMIN_VERBOSEJMP(put_here)].")
	SEND_SIGNAL(chunk, COMSIG_ITEM_ARTIFACT_FINALIZE)

/datum/controller/subsystem/processing/artifacts/proc/get_artifactible_turf()
	if(prob(use_valid_ball_spawner_chance) && LAZYLEN(SSvalidball.valid_ball_spawner_coords))
		return coords2turf(pick(SSvalidball.valid_ball_spawner_coords))
	else
		return find_safe_turf(zlevels = ARTIFACT_Z_LEVELS, extended_safety_checks = TRUE)

/datum/controller/subsystem/processing/artifacts/proc/populate_artifactibles()
	var/list/output = list()
	for(var/thingpath in artifactible_items)
		output |= typesof(thingpath)
	var/list/ingrab = list()
	for(var/thing in unartifactible_items)
		ingrab |= typesof(thing)
	for(var/thing in specific_unartifactable_items)
		ingrab |= thing
	output -= ingrab
	artifactible_items = output
	
/datum/controller/subsystem/processing/artifacts/proc/populate_effect_lists()
	for(var/ae_type in subtypesof(/datum/artifact_effect))
		var/datum/artifact_effect/AE = new ae_type(src)
		var/kye = AE.kind
		var/isbad = AE.is_only_harmful
		LAZYSET(all_effects, kye, AE)
		if(isbad)
			LAZYSET(bad_effects, kye, AE)
		if(AE.special_spawn_only)
			continue
		switch(AE.min_rarity_to_spawn)
			if(ART_RARITY_COMMON)
				allowed_effects_by_rarity[ART_RARITY_COMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_UNCOMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight
			if(ART_RARITY_UNCOMMON)
				allowed_effects_by_rarity[ART_RARITY_UNCOMMON][kye] = AE.chance_weight
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight
			if(ART_RARITY_RARE)
				allowed_effects_by_rarity[ART_RARITY_RARE][kye] = AE.chance_weight
	for(var/unq in subtypesof(/datum/artifact_unique))
		var/datum/artifact_unique/AQ = new unq(src)
		var/kye = AQ.key
		LAZYSET(unique_templates, kye, AQ)


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
	overrides |= unique_template.get_unique_effects() // this is the important thing =3

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
	if(!islist(overrides))
		overrides = list()
	///first, generate a rarity!
	if(!SEND_SIGNAL(thing, COMSIG_ITEM_ARTIFACT_EXISTS))
		thing.AddComponent(/datum/component/artifact) // welcome to life, little artifact!
	var/rarity = ART_RARITY_COMMON
	if(rarity_override)
		rarity = rarity_override
	else
		rarity = roll_rarity(rarity_class)
	if(rarity == ART_RARITY_UNIQUE)
		uniqueify(thing, overrides)
	if(!LAZYACCESS(overrides, ARTCOMP_PREROLLED))
		if(rarity == ART_RARITY_UNIQUE)
			uniqueify(thing, overrides)
			return
		var/num_buffs = LAZYACCESS(buffs_by_rarity, rarity)
		roll_effects(rarity, thing, overrides, num_buffs)
	/// now, roll some effects
	/// check if our item has an artifact component
	/// and now the actual artifactification!
	effectify(thing, overrides)
	sig_reg(thing)
	catalogue_artifact(thing, overrides, rarity)

/datum/controller/subsystem/processing/artifacts/proc/effectify(obj/item/thing, list/parameters)
	SEND_SIGNAL(thing, COMSIG_ITEM_ARTIFACT_READ_PARAMETERS, parameters)

/datum/controller/subsystem/processing/artifacts/proc/roll_effects(rarity = ART_RARITY_COMMON,  obj/item/thing, list/overrides, buffs = 0)
	if(!islist(overrides))
		CRASH("roll_effects() called with non-list overrides!!!!!!!!!!!!!!!!!!!!!!!!")
	var/number_of_effects = LAZYACCESS(max_effects_by_rarity, rarity)
	var/list/effect_pool = list()
	var/list/good_pool = list()
	var/list/rarity_effects = LAZYACCESS(allowed_effects_by_rarity, rarity)
	for(var/fx_path in rarity_effects) // todo: this
		var/datum/artifact_effect/AE = LAZYACCESS(all_effects, fx_path)
		if(AE.chance_weight <= 0)
			continue
		if(AE.special_spawn_only)
			continue
		LAZYSET(effect_pool, AE.kind, AE.chance_weight)
		if(AE.is_only_harmful)
			continue
		LAZYSET(good_pool, AE.kind, AE.chance_weight)

	// var/list/only_effects = overrides & allowed_effects_by_rarity[rarity]
	for(var/i in 1 to min(number_of_effects, LAZYLEN(effect_pool)))
		if(!LAZYLEN(effect_pool)) // we... ran out?
			overrides[ARTMOD_RADIATION] = list() // fuck it, its radioactive
			break
		var/rolled_effect = (buffs < 1 && allow_bads) ? pickweight(effect_pool) : pickweight(good_pool)
		if(!islist(LAZYACCESS(overrides, rolled_effect)))
			overrides[rolled_effect] = list()
		overrides[rolled_effect][ARTVAR_IS_BUFF] = allow_bads ? !!buffs : TRUE
		buffs = max(buffs - 1, 0)
		effect_pool -= rolled_effect
		good_pool -= rolled_effect

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
	RegisterSignal(thing, COMSIG_PARENT_PREQDELETED,PROC_REF(artifact_deleted), TRUE)

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


/datum/controller/subsystem/processing/artifacts/proc/roll_rarity(rarity_class = ART_RARITY_COMMON, randomroll)
	var/rareness = ART_RARITY_COMMON
	switch(rarity_class)
		if(ART_RARITY_COMMON)
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_COMMON) > common_hard_cap)
				return ART_RARITY_INHIBIT
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_COMMON) > common_soft_cap)
				rareness = pickweight(common_spawner_distribution_softcap)
			else
				rareness = pickweight(common_spawner_distribution)
		if(ART_RARITY_UNCOMMON)
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_UNCOMMON) > uncommon_hard_cap)
				return ART_RARITY_INHIBIT
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_UNCOMMON) > uncommon_soft_cap)
				rareness = pickweight(uncommon_spawner_distribution_softcap)
			else
				rareness = pickweight(uncommon_spawner_distribution)
		if(ART_RARITY_RARE)
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_RARE) > rare_hard_cap)
				return ART_RARITY_INHIBIT
			if(LAZYACCESS(number_of_artifacts, ART_RARITY_RARE) > rare_soft_cap)
				rareness = pickweight(rare_spawner_distribution_softcap)
			else
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
	base_overrides[ARTCOMP_PREROLLED] = TRUE // for getting the right vars n shit

/datum/artifact_unique/proc/get_unique_effects(list/overrides)
	if(!islist(overrides))
		CRASH("get_unique_effects() called with non-list overrides!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	overrides |= base_overrides

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

/datum/artifact_unique/apotheosis/get_unique_effects(list/overrides)
	. = ..()
	if(!.)
		CRASH("get_unique_effects() called with non-list overrides!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	overrides[ARTMOD_PASSIVE_HEAL] = list()
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BRUTE] = round(rand(0.1, brute_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BURN] = round(rand(0.1, burn_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_TOXIN] = round(rand(0.1, tox_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_OXY] = round(rand(0.1, oxy_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_CLONE] = round(rand(0.1, clone_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BRAIN] = round(rand(0.1, brain_heal))
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MIN_HEALTH] = min_heal
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MAX_HEALTH] = max_heal

	overrides[ARTMOD_STAMINA] = list()
	overrides[ARTMOD_STAMINA][ARTVAR_STAMINA_ADJUSTMENT] = round(rand(0.1, stam_heal))

	overrides[ARTMOD_BLOOD] = list()
	overrides[ARTMOD_BLOOD][ARTVAR_BLOOD_ADJUSTMENT] = round(rand(0.1, blood_heal))
	overrides[ARTMOD_BLOOD][ARTVAR_TARGET_BLOOD] = blood_max

	overrides[ARTMOD_RADIATION] = list()
	overrides[ARTMOD_RADIATION][ARTVAR_RADIATION_ADJUSTMENT] = round(rand(0.1, rad_heal))
	overrides[ARTMOD_RADIATION][ARTVAR_TARGET_RADIATION] = rad_target

	overrides[ARTMOD_RADIATION] = list()
	overrides[ARTMOD_RADIATION][ARTVAR_SPEED_ADJUSTMENT] = round(rand(0.1, speed_up))

	overrides[ARTMOD_FEEDER] = list()
	overrides[ARTMOD_FEEDER][ARTVAR_NUTRITION_ADJUSTMENT] = round(rand(0.1, nut_heal))
	overrides[ARTMOD_FEEDER][ARTVAR_TARGET_NUTRITION] = max_nut

	overrides[ARTMOD_FEEDER] = list()
	overrides[ARTMOD_FEEDER][ARTVAR_HP_CHANGE] = max_hp

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
	var/min_mod = 1

/datum/artifact_unique/perfection/get_unique_effects(list/overrides)
	. = ..()
	if(!.)
		CRASH("get_unique_effects() called with non-list overrides!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	var/effect = pick(SSartifacts.all_effects - SSartifacts.bad_effects)
	var/multiplier = rand(min_mod, max_mod)
	switch(effect)
		if(ARTMOD_BLOOD)
			overrides[ARTMOD_BLOOD] = list()
			overrides[ARTMOD_BLOOD][ARTVAR_BLOOD_ADJUSTMENT] = SSartifacts.blood_rate_rare_max * multiplier
			overrides[ARTMOD_BLOOD][ARTVAR_TARGET_BLOOD] = BLOOD_VOLUME_NORMAL
		if(ARTMOD_FEEDER)
			overrides[ARTMOD_FEEDER] = list()
			overrides[ARTMOD_FEEDER][ARTVAR_NUTRITION_ADJUSTMENT] = SSartifacts.nutrition_rate_good_rare_max * multiplier
			overrides[ARTMOD_FEEDER][ARTVAR_TARGET_NUTRITION] = NUTRITION_LEVEL_FAT
		if(ARTMOD_MAX_HP)
			overrides[ARTMOD_MAX_HP] = list()
			overrides[ARTMOD_MAX_HP][ARTVAR_HP_CHANGE] = SSartifacts.health_good_rare_max * multiplier
		if(ARTMOD_PASSIVE_HEAL)
			overrides[ARTMOD_PASSIVE_HEAL] = list()
			switch(rand(1, 6))
				if(1)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BRUTE] = SSartifacts.heal_dps_brute_rare * multiplier
				if(2)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BURN] = SSartifacts.heal_dps_burn_rare * multiplier
				if(3)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_TOXIN] = SSartifacts.heal_dps_toxin_rare * multiplier
				if(4)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_OXY] = SSartifacts.heal_dps_oxy_rare * multiplier
				if(5)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_CLONE] = SSartifacts.heal_dps_clone_rare * multiplier
				if(6)
					overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BRAIN] = SSartifacts.heal_dps_brain_rare * multiplier
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MIN_HEALTH] = -100
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MAX_HEALTH] = 200
		if(ARTMOD_RADIATION)
			overrides[ARTMOD_RADIATION] = list()
			overrides[ARTMOD_RADIATION][ARTVAR_RADIATION_ADJUSTMENT] = SSartifacts.radiation_rate_rare_max * multiplier
			overrides[ARTMOD_RADIATION][ARTVAR_TARGET_RADIATION] = 0
		if(ARTMOD_SPEED)
			overrides[ARTMOD_SPEED] = list()
			overrides[ARTMOD_SPEED][ARTVAR_SPEED_ADJUSTMENT] = SSartifacts.speed_good_rare_max * multiplier
		if(ARTMOD_STAMINA)
			overrides[ARTMOD_STAMINA] = list()
			overrides[ARTMOD_STAMINA][ARTVAR_STAMINA_ADJUSTMENT] = SSartifacts.stamina_good_rare_max * multiplier

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

/datum/artifact_unique/penance/get_unique_effects(list/overrides)
	. = ..()
	if(!.)
		CRASH("get_unique_effects() called with non-list overrides!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
	
	overrides[ARTMOD_PASSIVE_DOT] = list()
	overrides[ARTMOD_PASSIVE_DOT][ARTVAR_BRUTE] = brute_harm
	overrides[ARTMOD_PASSIVE_DOT][ARTVAR_BURN] = burn_harm
	overrides[ARTMOD_PASSIVE_DOT][ARTVAR_TOXIN] = tox_harm
	overrides[ARTMOD_PASSIVE_DOT][ARTVAR_OXY] = oxy_harm
	overrides[ARTMOD_PASSIVE_DOT][ARTVAR_MIN_HEALTH] = min_damage

	overrides[ARTMOD_PASSIVE_HEAL] = list()
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BLOOD_ADJUSTMENT] = blood_heal
	overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_TARGET_BLOOD] = blood_max

	overrides[ARTMOD_RADIATION] = list()
	overrides[ARTMOD_RADIATION][ARTVAR_RADIATION_ADJUSTMENT] = rad_heal
	overrides[ARTMOD_RADIATION][ARTVAR_TARGET_RADIATION] = rad_target

	overrides[ARTMOD_SPEED] = list()
	overrides[ARTMOD_SPEED][ARTVAR_SPEED_ADJUSTMENT] = speed_down

	overrides[ARTMOD_STAMINA] = list()
	overrides[ARTMOD_STAMINA][ARTVAR_STAMINA_ADJUSTMENT] = stam_harm

	overrides[ARTMOD_FEEDER] = list()
	overrides[ARTMOD_FEEDER][ARTVAR_NUTRITION_ADJUSTMENT] = nut_eat

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

/datum/artifact_unique/bubble/get_unique_effects()
	var/list/nut_vars = list(
		ARTVAR_NUTRITION_ADJUSTMENT = nut_rate,
		ARTVAR_TARGET_NUTRITION = nut_target,
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


/obj/item/debug_artifact_wand
	name = "Thing that makes artifacts"
	desc = "This is a thing that makes artifacts. Just point and click and wow, arti-fun!"
	icon = 'icons/obj/lighting.dmi'
	icon_state = "ltube"
	var/rarity = ART_RARITY_COMMON

/obj/item/debug_artifact_wand/attack_self(mob/user)
	. = ..()
	var/rarrrty = alert(user, "Set rarity to what?", "Cool stuff", "Common", "Uncommon", "Rare")
	switch(rarrrty)
		if("Common")
			rarity = ART_RARITY_COMMON
		if("Uncommon")
			rarity = ART_RARITY_UNCOMMON
		if("Rare")
			rarity = ART_RARITY_RARE
		else
			rarity = ART_RARITY_COMMON
	to_chat(user, span_phobia("Rarity set to [rarity]!"))

/obj/item/debug_artifact_wand/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!target)
		return
	var/turf/there = get_turf(target)
	if(!there)
		return
	SSartifacts.spawn_random_artifact(there, rarity)
	to_chat(user, span_green("Artifact spawned!"))


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

