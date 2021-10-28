SUBSYSTEM_DEF(monster_wave)
	name = "Monster Wave"
	wait = 1 HOURS //change to either 30 MINUTES or 1 HOURS
	var/successful_firing = 0
	var/allowed_firings = 2
	var/chance_of_fire = 50

//So admins, you want to be a tough guy, like it really rough guy?
//just know you can't modify the time in between each fire
//but you can allow it to always fire, by changing chance_of_fire to 0
//and changing allowed_firings to like.... 12? 

/datum/controller/subsystem/monster_wave/fire(resumed = 0)
	if(times_fired <= 0)
		message_admins("The Monster Wave has fired the first time. Next fire (in an hour) will spawn a monster pit.")
		log_game("The Monster Wave has fired the first time. Next fire (in an hour) will spawn a monster pit.")
		return
	if(successful_firing >= allowed_firings)
		message_admins("The Monster Wave has been disabled, maximum amount of waves spawned.")
		log_game("The Monster Wave has been disabled, maximum amount of waves spawned.")
		can_fire = FALSE
		return
	if(prob(chance_of_fire))
		return // 50/50 chance for it to either fire or not fire
	successful_firing++
	addtimer(CALLBACK(src, .proc/spawn_monsterwave), 10 SECONDS)
	for(var/M in GLOB.player_list)
		to_chat(M, "<span class='notice'>You feel the ground tremor subtly beneath your feet. Something far off in the distance has emerged to the surface.</font></span>")

/datum/controller/subsystem/monster_wave/proc/spawn_monsterwave()
	var/pick_unfortune = pick("Ghoul", "Deathclaw", "Radscorpion", "Fireant", "Molerat", "Mirelurk")
	switch(pick_unfortune)
		if("Ghoul")
			ghoul_wave()
		if("Deathclaw")
			deathclaw_wave()
		if("Radscorpion")
			radscorpion_wave()
		if("Fireant")
			fireant_wave()
		if("Molerat")
			molerat_wave()
		if("Mirelurk")
			mirelurk_wave()

/datum/controller/subsystem/monster_wave/proc/ghoul_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 8, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/ghoul(choose_turf)
		if(prob(10))
			new /mob/living/simple_animal/hostile/ghoul/glowing(choose_turf)
	new /obj/structure/nest/ghoul(choose_turf)
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

/datum/controller/subsystem/monster_wave/proc/deathclaw_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 20, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/deathclaw(choose_turf)
		if(prob(2))
			new /mob/living/simple_animal/hostile/deathclaw/mother(choose_turf)
	new /obj/structure/nest/deathclaw(choose_turf)
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")

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
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
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
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")


/datum/controller/subsystem/monster_wave/proc/molerat_wave()
	var/spawn_amount = CEILING(GLOB.player_list.len / 5, 1)
	var/turf/choose_turf = quick_safe_turf()
	var/turf/pixel_turf = get_turf_pixel(choose_turf)
	for(var/i in 1 to spawn_amount)
		new /mob/living/simple_animal/hostile/molerat(choose_turf)
	new /obj/structure/nest/molerat(choose_turf)
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
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
	message_admins("The Monster Wave has fired. A nest has been spawned at [ADMIN_VERBOSEJMP(pixel_turf)]")
	log_game("The Monster Wave has fired. A nest has been spawned at [AREACOORD(pixel_turf)]")
