//I tried hard to make it for any living thing, but really, its better for only simple animals, sorry
/datum/component/glow_heal
	//this is the var to choose what is healed over time when the parent is alive
	var/mob/living/simple_animal/sa_targets
	//because I need this for some reason(?)
	var/mob/living/simple_animal/sa_owner
	//this is to make sure it doesnt get ridiculous
	var/time_cooldown = 0
	//this is the cooldown time
	var/actual_cooldown = 5 SECONDS
	//perhaps someone wants to make a healing effect smaller/larger(?)
	var/heal_range = 3

/datum/component/glow_heal/Initialize(mob/living/simple_animal/chosen_targets)
	if(!isanimal(parent))
		return COMPONENT_INCOMPATIBLE
	sa_owner = parent
	if(chosen_targets)
		sa_targets = chosen_targets
	START_PROCESSING(SSobj, src)
	RegisterSignal(sa_owner, COMSIG_LIVING_REVIVE, .proc/restart_process)

/datum/component/glow_heal/proc/restart_process()
	START_PROCESSING(SSobj, src)

/datum/component/glow_heal/process()
	var/mob/living/srcLive = sa_owner
	if(srcLive.stat == DEAD)
		STOP_PROCESSING(SSobj, src)
		return //cmon, only living things are allowed use this process
	if(!sa_targets)
		return //we don't need to go on cooldown if we have no targets, so keep checking
	if(time_cooldown > world.time)
		return //honestly need a cooldown on the healing, it could make combat really hard against a horde of ghouls
	time_cooldown = world.time + actual_cooldown
	for(var/mob/living/simple_animal/saMob in range(heal_range, sa_owner))
		if(!istype(saMob, sa_targets))
			continue
		saMob.adjustHealth(-saMob.maxHealth*0.1)
		if(saMob.stat == DEAD)
			saMob.revive(full_heal = TRUE)
		var/obj/effect/temp_visual/heal/H = new /obj/effect/temp_visual/heal(get_turf(saMob)) //shameless copy from blobbernaut
		H.color = "#d9ff00" //I want yellow because glowing
