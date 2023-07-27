/// processing subsystem for generating and ticking artifacts
/// Artifacts are basically diablo 2 style magic items
SUBSYSTEM_DEF(artifacts)
	name = "Artifacts"
	flags = SS_BACKGROUND|SS_NO_INIT
	wait = 1 SECONDS

	/// irradiated mobs, to be blasted with radiation every tick
	/// list("mob_whatever" = rad_level)
	var/number_of_artifacts = 0
	var/max_prefixes = 2
	var/max_suffixes = 2

	// 200 ** 200 = 4e+120
	var/list/rare_prefixes = list()
	var/list/rare_suffixes = list()

	var/blood_target_common_minimum = BLOOD_VOLUME_SYMPTOMS_MINOR
	var/blood_target_rare_minimum = BLOOD_VOLUME_SYMPTOMS_WORST
	var/blood_rate_common_maximum = 2
	var/blood_rate_rare_maximum = 10
	var/blood_discrete = 0.1

	var/radiation_target_common_maximum = 1000
	var/radiation_target_rare_maximum = INFINITY
	var/radiation_rate_common_maximum = 2
	var/radiation_rate_rare_maximum = 10
	var/radiation_discrete = 0.1

	var/health_common_maximum = 5
	var/health_common_minimum = -20
	var/health_rare_maximum = 50
	var/health_rare_minimum = -90
	var/health_discrete = 1

	var/stamina_rate_common_maximum = 5
	var/stamina_rate_common_minimum = -5
	var/stamina_rate_rare_maximum = 10
	var/stamina_rate_rare_minimum = -20
	var/stamina_discrete = 1

	var/speed_common_minimum = -0.2
	var/speed_common_maximum = 0.5
	var/speed_rare_minimum = -0.5
	var/speed_rare_maximum = 3
	var/speed_discrete = 0.05

	var/damage_common_cutoff_minimum = 75
	var/damage_rare_cutoff_minimum = 10
	var/damage_discrete = 0.1

	var/damage_brute_common_maximum = 2
	var/damage_brute_rare_maximum = 10

	var/damage_burn_common_maximum = 2
	var/damage_burn_rare_maximum = 10

	var/damage_toxin_common_maximum = 2
	var/damage_toxin_rare_maximum = 10

	var/damage_oxy_common_maximum = 2
	var/damage_oxy_rare_maximum = 10

	var/damage_clone_common_maximum = 2
	var/damage_clone_rare_maximum = 10

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

/datum/controller/subsystem/artifacts/Initialize(start_timeofday)
	populate_affix_lists()
	. = ..()
	
/datum/controller/subsystem/artifacts/fire(resumed)

/datum/controller/subsystem/artifacts/populate_affix_lists()
	var/list/sillystring = safe_json_decode(file2text("strings/artifact_affixes.json"))
	if(LAZYLEN(sillystring) != 2)
		message_admins("Artifact affixes file is malformed!")
		return
	rare_prefixes = sillystring["rare_prefixes"]
	rare_suffixes = sillystring["rare_suffixes"]
	prefixes_speed_good = sillystring["prefixes_speed_good"]
	prefixes_speed_bad = sillystring["prefixes_speed_bad"]
	suffixes_speed_good = sillystring["suffixes_speed_good"]
	suffixes_speed_bad = sillystring["suffixes_speed_bad"]
	prefixes_damage_brute = sillystring["prefixes_damage_brute"]
	prefixes_damage_burn = sillystring["prefixes_damage_burn"]
	prefixes_damage_toxin = sillystring["prefixes_damage_toxin"]
	prefixes_damage_oxy = sillystring["prefixes_damage_oxy"]
	prefixes_damage_clone = sillystring["prefixes_damage_clone"]
	prefixes_damage_brain = sillystring["prefixes_damage_brain"]
	suffixes_damage_brute = sillystring["suffixes_damage_brute"]
	suffixes_damage_burn = sillystring["suffixes_damage_burn"]
	suffixes_damage_toxin = sillystring["suffixes_damage_toxin"]
	suffixes_damage_oxy = sillystring["suffixes_damage_oxy"]
	suffixes_damage_clone = sillystring["suffixes_damage_clone"]
	prefixes_stamina_good = sillystring["prefixes_stamina_good"]
	prefixes_stamina_bad = sillystring["prefixes_stamina_bad"]
	suffixes_stamina_good = sillystring["suffixes_stamina_good"]
	suffixes_stamina_bad = sillystring["suffixes_stamina_bad"]
	prefixes_radiation_good = sillystring["prefixes_radiation_good"]
	prefixes_radiation_bad = sillystring["prefixes_radiation_bad"]
	suffixes_radiation_good = sillystring["suffixes_radiation_good"]
	suffixes_radiation_bad = sillystring["suffixes_radiation_bad"]
	prefixes_health_good = sillystring["prefixes_health_good"]
	prefixes_health_bad = sillystring["prefixes_health_bad"]
	suffixes_health_good = sillystring["suffixes_health_good"]
	suffixes_health_bad = sillystring["suffixes_health_bad"]
	prefixes_blood_good = sillystring["prefixes_blood_good"]
	prefixes_blood_bad = sillystring["prefixes_blood_bad"]
	suffixes_blood_good = sillystring["suffixes_blood_good"]
	suffixes_blood_bad = sillystring["suffixes_blood_bad"]


/datum/controller/subsystem/artifacts/proc/generate_name(datum/component/artifact/art, list/effectlist = list(), rarity = ART_RARITY_COMMON)
	if(rarity >= ART_RARITY_RARE || LAZYLEN(effect_list > max_prefixes + max_suffixes))
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

/datum/component/artifact/proc/generate_rare_name()
	identified_preposition = "The"
	var/prefix = pick(rare_prefixes)
	var/suffix = pick(rare_suffix)
	return "[prefix][suffix][appelation]"



