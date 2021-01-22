//I tried hard to make it for any living thing, but really, its better for only simple animals, sorry
//I won't remove the above comment, because I don't want to hide my previous self ideas
/datum/component/glow_heal
	//this is the var to choose what is healed over time when the parent is alive
	var/mob/living/living_targets
	//because I need this for some reason(?)
	var/mob/living/living_owner
	//this is to make sure it doesnt get ridiculous
	var/time_cooldown = 0
	//this is the cooldown time
	var/actual_cooldown = 5 SECONDS
	//perhaps someone wants to make a healing effect smaller/larger(?)
	var/heal_range = 3
	//customization
	var/revive_allowed = TRUE
	//faction healing only
	var/faction_only = null
	//allows healing of types: Brute, Burn, Toxin, Oxygen. 
	var/healing_types = list(TRUE, TRUE, TRUE, TRUE)

/datum/component/glow_heal/Initialize(mob/living/simple_animal/chosen_targets, allow_revival = TRUE, restrict_faction = null, list/type_healing = list(TRUE, TRUE, TRUE, TRUE))
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	living_owner = parent
	if(chosen_targets)
		living_targets = chosen_targets
	if(!allow_revival)
		revive_allowed = FALSE
	if(restrict_faction)
		faction_only = restrict_faction
	healing_types = type_healing
	START_PROCESSING(SSobj, src)
	RegisterSignal(living_owner, COMSIG_LIVING_REVIVE, .proc/restart_process)

/datum/component/glow_heal/proc/restart_process()
	START_PROCESSING(SSobj, src)

/datum/component/glow_heal/process()
	var/mob/living/srcLive = living_owner
	if(srcLive.stat == DEAD)
		STOP_PROCESSING(SSobj, src)
		return //cmon, only living things are allowed use this process
	if(!living_targets)
		return //we don't need to go on cooldown if we have no targets, so keep checking
	if(time_cooldown > world.time)
		return //honestly need a cooldown on the healing, it could make combat really hard against a horde of ghouls
	time_cooldown = world.time + actual_cooldown
	for(var/mob/living/livingMob in range(heal_range, living_owner))
		if(!istype(livingMob, living_targets))
			continue
		if(faction_only && !(faction_only in livingMob.faction))
			continue //if you don't have the faction listed in the intial, then you aren't getting targeted 
		if(healing_types[1])
			livingMob.adjustBruteLoss(-livingMob.maxHealth*0.1)
		if(healing_types[2])	
			livingMob.adjustFireLoss(-livingMob.maxHealth*0.1)
		if(healing_types[3])	
			livingMob.adjustToxLoss(-livingMob.maxHealth*0.1)
		if(healing_types[4])	
			livingMob.adjustOxyLoss(-livingMob.maxHealth*0.1)
		if(livingMob.stat == DEAD && revive_allowed)
			livingMob.revive(full_heal = TRUE)
		var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal(get_turf(livingMob)) //shameless copy from blobbernaut
		H.color = "#d9ff00" //I want yellow because glowing; sidenote: maybe this should be a var so it can be multiple things
