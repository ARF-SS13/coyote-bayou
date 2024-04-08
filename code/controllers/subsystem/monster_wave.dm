SUBSYSTEM_DEF(monster_wave)
	name = "Monster Wave"
	wait = 30 SECONDS //change to either 30 MINUTES or 1 HOURS
	var/successful_firing = 0
	var/allowed_firings = 9000
	var/chance_of_fire = 100 //Fuck you, people need mobs to shoot! -TK
	/// big list of all the spawners that have been destroyed
	var/list/spawner_tickets = list() // list(/datum/nest_box)
	/// big list of all the spawner boys in existence
	var/list/spawner_boys = list() // list(/mob


//So admins, you want to be a tough guy, like it really rough guy?
//just know you can't modify the time in between each fire
//but you can allow it to always fire, by changing chance_of_fire to 0
//and changing allowed_firings to like.... 12?
//     ^This guy was a coward. ~TK

/datum/controller/subsystem/monster_wave/fire(resumed = 0)
	if(times_fired <= 0)
		message_admins("The Monster Wave has fired the first time. Next fire (in 30 sececonds) will spawn a monster pit.")
		log_game("The Monster Wave has fired the first time. Next fire (in an hour) will spawn a monster pit.")
		return
	if(successful_firing >= allowed_firings)
		message_admins("The Monster Wave has been disabled, maximum amount of waves spawned.")
		log_game("The Monster Wave has been disabled, maximum amount of waves spawned.")
		can_fire = FALSE
		return
	if(prob(chance_of_fire))
		return // It fires, fuck you lmfaooo
	successful_firing++
	addtimer(CALLBACK(src,PROC_REF(spawn_monsterwave)), 10 SECONDS)
	for(var/M in GLOB.player_list)
		to_chat(M, span_notice("You feel the ground tremor subtly beneath your feet. Something far off in the distance has emerged to the surface.</font>"))

/datum/controller/subsystem/monster_wave/proc/spawn_monsterwave()
	var/pick_unfortune = pick("Ghoul", /*"Deathclaw",*/ "Radscorpion", "Fireant", "Giantrat", "Mirelurk", "Gecko", "Cazador", "Wolf")
	switch(pick_unfortune)
		if("Ghoul")
			ghoul_wave()
//		if("Deathclaw")
//			deathclaw_wave()
		if("Radscorpion")
			radscorpion_wave()
		if("Fireant")
			fireant_wave()
		if("Giantrat")
			molerat_wave()
		if("Mirelurk")
			mirelurk_wave()
		if("Gecko")
			gecko_wave()
		if("Cazador")
			cazador_wave()
		if("Wolf")
			wolf_wave()

/datum/controller/subsystem/monster_wave/proc/ghoul_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 8, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/ghoul(choose_turf)
		if(prob(10))
			new /mob/living/simple_animal/hostile/ghoul/glowing(choose_turf)
	new /obj/structure/nest/ghoul(choose_turf)
	message_admins("The Monster Wave for ghouls has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/*
/datum/controller/subsystem/monster_wave/proc/deathclaw_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 20, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/deathclaw(choose_turf)
		if(prob(2))
			new /mob/living/simple_animal/hostile/deathclaw/mother(choose_turf)
	new /obj/structure/nest/deathclaw(choose_turf)
	message_admins("The Monster Wave for Deathclaws has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")
*/

/datum/controller/subsystem/monster_wave/proc/radscorpion_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 15, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		if(prob(50))
			new /mob/living/simple_animal/hostile/radscorpion/black(choose_turf)
		else
			new /mob/living/simple_animal/hostile/radscorpion(choose_turf)
	new /obj/structure/nest/scorpion(choose_turf)
	message_admins("The Monster Wave for Radscorpions has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/datum/controller/subsystem/monster_wave/proc/fireant_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 10, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/giantant(choose_turf)
		if(prob(1))
			new /mob/living/simple_animal/hostile/giantantqueen(choose_turf)
	new /obj/structure/nest/fireant(choose_turf)
	message_admins("The Monster Wave for Fireants has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")


/datum/controller/subsystem/monster_wave/proc/molerat_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 5, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/molerat(choose_turf)
	new /obj/structure/nest/molerat(choose_turf)
	message_admins("The Monster Wave for Molerats has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/datum/controller/subsystem/monster_wave/proc/mirelurk_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 10, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/mirelurk/baby(choose_turf)
		if(prob(20))
			new /mob/living/simple_animal/hostile/mirelurk(choose_turf)
		if(prob(8))
			new /mob/living/simple_animal/hostile/mirelurk/hunter(choose_turf)
	new /obj/structure/nest/mirelurk(choose_turf)
	message_admins("The Monster Wave for Mirelurks has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/datum/controller/subsystem/monster_wave/proc/gecko_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 5, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/gecko(choose_turf)
	new /obj/structure/nest/gecko(choose_turf)
	message_admins("The Monster Wave for Geckos has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")


/datum/controller/subsystem/monster_wave/proc/cazador_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 5, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/cazador(choose_turf)
	new /obj/structure/nest/cazador(choose_turf)
	message_admins("The Monster Wave for Cazador has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/datum/controller/subsystem/monster_wave/proc/wolf_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 5, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/wolf/alpha(choose_turf)
	new /obj/structure/nest/wolf(choose_turf)
	message_admins("The Monster Wave for Dogs has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")


/mob/living/simple_animal/nest_spawn_hole_guy
	name = "rift"
	desc = "An ominous haze of indescernable make and model, forming an otherworldly coccoon around what appears to be somewhere else. Within this wriggling \
		mass of mangled spacetime, you can see the faint silhouettes of familiar creatures moving around inside-- familiar <i>hostile</i> creatures! \
		Its like mama always said, that whenever you come across a dimensional rift to planes of existence where that nest full of monsters you filled never got filled, \
		if you hit it enough, it should go away. That or stand next to it for a while. Let's make her proud!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "dragnetfield"
	mob_armor = ARMOR_VALUE_RIFT
	maxHealth = 100
	health = 100
	move_resist = MOVE_FORCE_OVERPOWERING
	density = FALSE
	a_intent = INTENT_HARM
	del_on_death = TRUE
	wander = FALSE
	AIStatus = AI_OFF
	var/my_coords
	var/datum/weakref/my_event

/mob/living/simple_animal/nest_spawn_hole_guy/Destroy()
	un_nest()
	. = ..()

/mob/living/simple_animal/nest_spawn_hole_guy/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_HOSTILE_CHECK_FACTION,PROC_REF(no_attack_pls))
	RegisterSignal(src, COMSIG_MOB_APPLY_DAMAGE,PROC_REF(im_hit))

/mob/living/simple_animal/nest_spawn_hole_guy/update_overlays()
	. = ..()
	cut_overlays()
	var/mutable_appearance/overlay1 = mutable_appearance(icon, "quantum_sparks")
	. += overlay1

/mob/living/simple_animal/nest_spawn_hole_guy/proc/no_attack_pls()
	return TRUE

/mob/living/simple_animal/nest_spawn_hole_guy/proc/register_event(datum/round_event/common/spawn_nests/event)
	my_event = WEAKREF(event)

/mob/living/simple_animal/nest_spawn_hole_guy/proc/un_nest()
	var/datum/round_event/common/spawn_nests/event = GET_WEAKREF(my_event)
	if(event)
		event.coords_to_spawn_at -= my_coords
		event.spawn_holes -= src
	do_sparks(3, FALSE, src, /datum/effect_system/spark_spread/quantum)

/mob/living/simple_animal/nest_spawn_hole_guy/proc/im_hit()
	playsound(src, 'sound/effects/portalboy_hit.ogg', 100, TRUE)
	do_sparks(1, FALSE, src, /datum/effect_system/spark_spread/quantum)

/mob/living/simple_animal/nest_spawn_hole_guy/proc/succ()
	playsound(src, 'sound/effects/portalboy_success.ogg', 100, TRUE)
	qdel(src)

/mob/living/simple_animal/nest_spawn_hole_guy/death()
	playsound(src, 'sound/effects/portalboy_death.ogg', 100, TRUE)
	un_nest()
	. = ..()

