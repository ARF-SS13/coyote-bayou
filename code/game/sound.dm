/proc/playsound(
		atom/source,
		soundin,
		vol as num,
		vary,
		extrarange as num,
		falloff_exponent = SOUND_FALLOFF_EXPONENT,
		frequency = null,
		channel = 0,
		pressure_affected = TRUE,
		ignore_walls = FALSE,
		falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE,
		use_reverb = FALSE,
		distant_sound,
		distant_range,
		soundpref_index)
	if(isarea(source))
		CRASH("playsound(): source is an area")

	var/turf/turf_source = get_turf(source)

	if (!turf_source)
		return

	//allocate a channel if necessary now so its the same for everyone
	channel = channel || SSsounds.random_available_channel()

	// Looping through the player list has the added bonus of working for mobs inside containers
	var/sound/S = sound(get_sfx(soundin))
	var/sound/S_distant = distant_sound ? sound(get_sfx(distant_sound)) : null
	var/maxdistance = SOUND_RANGE + extrarange
	var/source_z = turf_source.z
	var/list/listeners = SSmobs.clients_by_zlevel[source_z].Copy()

	var/turf/above_turf = SSmapping.get_turf_above(turf_source)
	var/turf/below_turf = SSmapping.get_turf_below(turf_source)

	// if(!ignore_walls) //these sounds don't carry through walls
	// 	listeners = listeners & (hearers(maxdistance,turf_source) | viewers(maxdistance,turf_source))

	// 	if(above_turf && istransparentturf(above_turf))
	// 		listeners += (hearers(maxdistance,above_turf) | viewers(maxdistance,turf_source))

	// 	if(below_turf && istransparentturf(turf_source))
	// 		listeners += (hearers(maxdistance,below_turf) | viewers(maxdistance,turf_source))

	// else
	if(above_turf && istransparentturf(above_turf))
		listeners += SSmobs.clients_by_zlevel[above_turf.z]

	if(below_turf && istransparentturf(turf_source))
		listeners += SSmobs.clients_by_zlevel[below_turf.z]

	for(var/mob/listening_mob as anything in listeners + SSmobs.dead_players_by_zlevel[source_z])
		if(soundpref_index && !CHECK_PREFS(listening_mob, soundpref_index))
			continue
		var/listener_distance = get_dist(listening_mob, turf_source)
		if(listener_distance <= maxdistance)
			listening_mob.playsound_local(
				turf_source, 
				soundin, 
				vol, 
				vary, 
				frequency, 
				falloff_exponent, 
				channel, 
				pressure_affected, 
				S, 
				maxdistance, 
				falloff_distance, 
				1, 
				use_reverb)
		if(distant_sound && distant_range && ignore_walls && listener_distance >= (maxdistance * SOUND_NORMAL_TO_DISTANT_COEFF) && listener_distance <= distant_range)
			listening_mob.playsound_local(
				turf_source, 
				distant_sound, 
				vol, 
				vary, 
				frequency, 
				falloff_exponent, 
				channel, 
				pressure_affected, 
				S_distant, 
				distant_range, 
				maxdistance, 
				1, 
				use_reverb)
/* 	for(var/mob/listening_mob as anything in SSmobs.dead_players_by_zlevel[source_z])
		if(get_dist(listening_mob, turf_source) <= maxdistance)
			listening_mob.playsound_local(turf_source, soundin, vol, vary, frequency, falloff_exponent, channel, pressure_affected, S, maxdistance, falloff_distance, 1, use_reverb) */


/mob/proc/playsound_local(
		turf/turf_source, 
		soundin, 
		vol as num, 
		vary, 
		frequency, 
		falloff_exponent = SOUND_FALLOFF_EXPONENT, 
		channel = 0, 
		pressure_affected = TRUE, 
		sound/S, 
		max_distance, 
		falloff_distance = SOUND_DEFAULT_FALLOFF_DISTANCE, 
		distance_multiplier = 1, 
		use_reverb = FALSE,
		soundpref_index,
		respect_deafness = TRUE
		)
	if(!client || (respect_deafness && !can_hear()))
		return

	if(!S)
		S = sound(get_sfx(soundin))

	if(soundpref_index && !CHECK_PREFS(src, soundpref_index))
		return

	S.wait = 0 //No queue
	S.channel = channel || SSsounds.random_available_channel()
	S.volume = vol

	if(frequency) // fun fact, -100 to 100 is used by byond to just multiply the playback, neato
		S.frequency = frequency
	else if(vary)
		S.frequency = get_rand_frequency()

	if(isturf(turf_source))
		var/turf/T = get_turf(src)

		//sound volume falloff with distance
		var/distance = get_dist(T, turf_source)

		distance *= distance_multiplier

		if(max_distance) //If theres no max_distance we're not a 3D sound, so no falloff.
			S.volume -= (max(distance - falloff_distance, 0) ** (1 / falloff_exponent)) / ((max(max_distance, distance) - falloff_distance) ** (1 / falloff_exponent)) * S.volume
			//https://www.desmos.com/calculator/sqdfl8ipgf

		/*
		if(pressure_affected)
			//Atmosphere affects sound
			var/pressure_factor = 1
			var/datum/gas_mixture/hearer_env = T.return_air()
			var/datum/gas_mixture/source_env = turf_source.return_air()

			if(hearer_env && source_env)
				var/pressure = min(hearer_env.return_pressure(), source_env.return_pressure())
				if(pressure < ONE_ATMOSPHERE)
					pressure_factor = max((pressure - SOUND_MINIMUM_PRESSURE)/(ONE_ATMOSPHERE - SOUND_MINIMUM_PRESSURE), 0)
			else //space
				pressure_factor = 0

			if(distance <= 1)
				pressure_factor = max(pressure_factor, 0.15) //touching the source of the sound

			S.volume *= pressure_factor
			//End Atmosphere affecting sound
			*/

		if(S.volume <= 0)
			return //No sound

		var/dx = turf_source.x - T.x // Hearing from the right/left
		S.x = dx * distance_multiplier
		var/dz = turf_source.y - T.y // Hearing from infront/behind
		S.z = dz * distance_multiplier
		var/dy = (turf_source.z - T.z) * 5 * distance_multiplier // Hearing from  above / below, multiplied by 5 because we assume height is further along coords.
		S.y = dy

		S.falloff = max_distance || 1 //use max_distance, else just use 1 as we are a direct sound so falloff isnt relevant.

		// Sounds can't have their own environment. A sound's environment will be:
		// 1. the mob's
		// 2. the area's (defaults to SOUND_ENVRIONMENT_NONE)
		if(sound_environment_override != SOUND_ENVIRONMENT_NONE)
			S.environment = sound_environment_override
		else
			var/area/A = get_area(src)
			S.environment = A.sound_environment

		if(use_reverb && S.environment != SOUND_ENVIRONMENT_NONE) //We have reverb, reset our echo setting
			S.echo[3] = 0 //Room setting, 0 means normal reverb
			S.echo[4] = 0 //RoomHF setting, 0 means normal reverb.

	SEND_SOUND(src, S)

/proc/sound_to_playing_players(soundin, volume = 100, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S)
	if(!S)
		S = sound(get_sfx(soundin))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			M.playsound_local(M, null, volume, vary, frequency, falloff, channel, pressure_affected, S)

/mob/proc/stop_sound_channel(chan)
	SEND_SOUND(src, sound(null, repeat = 0, wait = 0, channel = chan))

/mob/proc/set_sound_channel_volume(channel, volume)
	var/sound/S = sound(null, FALSE, FALSE, channel, volume)
	S.status = SOUND_UPDATE
	SEND_SOUND(src, S)

/client/proc/playtitlemusic(vol = 85)
	set waitfor = FALSE
	UNTIL(SSticker.login_music) //wait for SSticker init to set the login music

	if(prefs && (prefs.toggles & SOUND_LOBBY))
		SEND_SOUND(src, sound(SSticker.login_music, repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC)) // MAD JAMS

/client/proc/playbeginmusic(vol = 75)

	SEND_SOUND(src, sound(SSticker.begin_music, repeat = 0, wait = 0, volume = vol, channel = CHANNEL_LOBBYMUSIC))

/proc/get_rand_frequency()
	return rand(32000, 55000) //Frequency stuff only works with 45kbps oggs.

/proc/get_sfx(soundin)
	if(istext(soundin))
		switch(soundin)
			if ("explosion_creaking") // from skyrat-ss13/skyrat13/pull/3295
				soundin = pick('sound/effects/explosioncreak1.ogg', 'sound/effects/explosioncreak2.ogg')
			if ("hull_creaking") // from skyrat-ss13/skyrat13/pull/3295
				soundin = pick('sound/effects/creak1.ogg', 'sound/effects/creak2.ogg', 'sound/effects/creak3.ogg')
			if ("shatter")
				soundin = pick('sound/effects/glassbr1.ogg','sound/effects/glassbr2.ogg','sound/effects/glassbr3.ogg')
			if ("explosion")
				soundin = pick('sound/effects/explosion1.ogg','sound/effects/explosion2.ogg')
			if ("sparks")
				soundin = pick('sound/effects/sparks1.ogg','sound/effects/sparks2.ogg','sound/effects/sparks3.ogg','sound/effects/sparks4.ogg')
			if ("rustle")
				soundin = pick('sound/effects/rustle1.ogg','sound/effects/rustle2.ogg','sound/effects/rustle3.ogg','sound/effects/rustle4.ogg','sound/effects/rustle5.ogg')
			if ("bodyfall")
				soundin = pick('sound/effects/bodyfall1.ogg','sound/effects/bodyfall2.ogg','sound/effects/bodyfall3.ogg','sound/effects/bodyfall4.ogg')
			if ("punch")
				soundin = pick('sound/weapons/punch1.ogg','sound/weapons/punch2.ogg','sound/weapons/punch3.ogg','sound/weapons/punch4.ogg')
			if ("clownstep")
				soundin = pick('sound/effects/clownstep1.ogg','sound/effects/clownstep2.ogg')
			if ("suitstep")
				soundin = pick('sound/effects/suitstep1.ogg','sound/effects/suitstep2.ogg')
			if ("swing_hit")
				soundin = pick('sound/weapons/genhit1.ogg', 'sound/weapons/genhit2.ogg', 'sound/weapons/genhit3.ogg')
			if ("hiss")
				soundin = pick('sound/voice/hiss1.ogg','sound/voice/hiss2.ogg','sound/voice/hiss3.ogg','sound/voice/hiss4.ogg')
			if ("pageturn")
				soundin = pick('sound/effects/pageturn1.ogg', 'sound/effects/pageturn2.ogg','sound/effects/pageturn3.ogg')
			if ("gunshot")
				soundin = pick('sound/weapons/gunshot.ogg', 'sound/weapons/gunshot2.ogg','sound/weapons/gunshot3.ogg','sound/weapons/gunshot4.ogg')
			if ("ricochet")
				soundin = pick(	'sound/weapons/effects/ric1.ogg', 'sound/weapons/effects/ric2.ogg','sound/weapons/effects/ric3.ogg','sound/weapons/effects/ric4.ogg','sound/weapons/effects/ric5.ogg')
			if ("terminal_type")
				soundin = pick('sound/machines/terminal_button01.ogg', 'sound/machines/terminal_button02.ogg', 'sound/machines/terminal_button03.ogg', \
								'sound/machines/terminal_button04.ogg', 'sound/machines/terminal_button05.ogg', 'sound/machines/terminal_button06.ogg', \
								'sound/machines/terminal_button07.ogg', 'sound/machines/terminal_button08.ogg')
			if ("desceration")
				soundin = pick('sound/misc/desceration-01.ogg', 'sound/misc/desceration-02.ogg', 'sound/misc/desceration-03.ogg')
			if ("im_here")
				soundin = pick('sound/hallucinations/im_here1.ogg', 'sound/hallucinations/im_here2.ogg')
			if ("can_open")
				soundin = pick('sound/effects/can_open1.ogg', 'sound/effects/can_open2.ogg', 'sound/effects/can_open3.ogg')
			if("bullet_miss")
				soundin = pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg')
			if("gun_dry_fire")
				soundin = pick('sound/weapons/gun_dry_fire_1.ogg', 'sound/weapons/gun_dry_fire_2.ogg', 'sound/weapons/gun_dry_fire_3.ogg', 'sound/weapons/gun_dry_fire_4.ogg')
			if("gun_insert_empty_magazine")
				soundin = pick('sound/weapons/gun_magazine_insert_empty_1.ogg', 'sound/weapons/gun_magazine_insert_empty_2.ogg', 'sound/weapons/gun_magazine_insert_empty_3.ogg', 'sound/weapons/gun_magazine_insert_empty_4.ogg')
			if("gun_insert_full_magazine")
				soundin = pick('sound/weapons/gun_magazine_insert_full_1.ogg', 'sound/weapons/gun_magazine_insert_full_2.ogg', 'sound/weapons/gun_magazine_insert_full_3.ogg', 'sound/weapons/gun_magazine_insert_full_4.ogg', 'sound/weapons/gun_magazine_insert_full_5.ogg')
			if("gun_remove_empty_magazine")
				soundin = pick('sound/weapons/gun_magazine_remove_empty_1.ogg', 'sound/weapons/gun_magazine_remove_empty_2.ogg', 'sound/weapons/gun_magazine_remove_empty_3.ogg', 'sound/weapons/gun_magazine_remove_empty_4.ogg')
			if("gun_slide_lock")
				soundin = pick('sound/weapons/gun_slide_lock_1.ogg', 'sound/weapons/gun_slide_lock_2.ogg', 'sound/weapons/gun_slide_lock_3.ogg', 'sound/weapons/gun_slide_lock_4.ogg', 'sound/weapons/gun_slide_lock_5.ogg')
			if("law")
				soundin = pick('sound/voice/beepsky/god.ogg', 'sound/voice/beepsky/iamthelaw.ogg', 'sound/voice/beepsky/secureday.ogg', 'sound/voice/beepsky/radio.ogg', 'sound/voice/beepsky/insult.ogg', 'sound/voice/beepsky/creep.ogg')
			if("goose")
				soundin = pick('sound/creatures/goose1.ogg', 'sound/creatures/goose2.ogg', 'sound/creatures/goose3.ogg', 'sound/creatures/goose4.ogg')
			if("water_wade")
				soundin = pick('sound/effects/water_wade1.ogg', 'sound/effects/water_wade2.ogg', 'sound/effects/water_wade3.ogg', 'sound/effects/water_wade4.ogg')
			if("clang")
				soundin = pick('sound/effects/clang1.ogg', 'sound/effects/clang2.ogg')
			if("clangsmall")
				soundin = pick('sound/effects/clangsmall1.ogg', 'sound/effects/clangsmall2.ogg')
			if("slosh")
				soundin = pick('sound/effects/slosh1.ogg', 'sound/effects/slosh2.ogg')
			if("smcalm")
				soundin = pick('sound/machines/sm/accent/normal/1.ogg', 'sound/machines/sm/accent/normal/2.ogg', 'sound/machines/sm/accent/normal/3.ogg', 'sound/machines/sm/accent/normal/4.ogg', 'sound/machines/sm/accent/normal/5.ogg', 'sound/machines/sm/accent/normal/6.ogg', 'sound/machines/sm/accent/normal/7.ogg', 'sound/machines/sm/accent/normal/8.ogg', 'sound/machines/sm/accent/normal/9.ogg', 'sound/machines/sm/accent/normal/10.ogg', 'sound/machines/sm/accent/normal/11.ogg', 'sound/machines/sm/accent/normal/12.ogg', 'sound/machines/sm/accent/normal/13.ogg', 'sound/machines/sm/accent/normal/14.ogg', 'sound/machines/sm/accent/normal/15.ogg', 'sound/machines/sm/accent/normal/16.ogg', 'sound/machines/sm/accent/normal/17.ogg', 'sound/machines/sm/accent/normal/18.ogg', 'sound/machines/sm/accent/normal/19.ogg', 'sound/machines/sm/accent/normal/20.ogg', 'sound/machines/sm/accent/normal/21.ogg', 'sound/machines/sm/accent/normal/22.ogg', 'sound/machines/sm/accent/normal/23.ogg', 'sound/machines/sm/accent/normal/24.ogg', 'sound/machines/sm/accent/normal/25.ogg', 'sound/machines/sm/accent/normal/26.ogg', 'sound/machines/sm/accent/normal/27.ogg', 'sound/machines/sm/accent/normal/28.ogg', 'sound/machines/sm/accent/normal/29.ogg', 'sound/machines/sm/accent/normal/30.ogg', 'sound/machines/sm/accent/normal/31.ogg', 'sound/machines/sm/accent/normal/32.ogg', 'sound/machines/sm/accent/normal/33.ogg')
			if("smdelam")
				soundin = pick('sound/machines/sm/accent/delam/1.ogg', 'sound/machines/sm/accent/normal/2.ogg', 'sound/machines/sm/accent/normal/3.ogg', 'sound/machines/sm/accent/normal/4.ogg', 'sound/machines/sm/accent/normal/5.ogg', 'sound/machines/sm/accent/normal/6.ogg', 'sound/machines/sm/accent/normal/7.ogg', 'sound/machines/sm/accent/normal/8.ogg', 'sound/machines/sm/accent/normal/9.ogg', 'sound/machines/sm/accent/normal/10.ogg', 'sound/machines/sm/accent/normal/11.ogg', 'sound/machines/sm/accent/normal/12.ogg', 'sound/machines/sm/accent/normal/13.ogg', 'sound/machines/sm/accent/normal/14.ogg', 'sound/machines/sm/accent/normal/15.ogg', 'sound/machines/sm/accent/normal/16.ogg', 'sound/machines/sm/accent/normal/17.ogg', 'sound/machines/sm/accent/normal/18.ogg', 'sound/machines/sm/accent/normal/19.ogg', 'sound/machines/sm/accent/normal/20.ogg', 'sound/machines/sm/accent/normal/21.ogg', 'sound/machines/sm/accent/normal/22.ogg', 'sound/machines/sm/accent/normal/23.ogg', 'sound/machines/sm/accent/normal/24.ogg', 'sound/machines/sm/accent/normal/25.ogg', 'sound/machines/sm/accent/normal/26.ogg', 'sound/machines/sm/accent/normal/27.ogg', 'sound/machines/sm/accent/normal/28.ogg', 'sound/machines/sm/accent/normal/29.ogg', 'sound/machines/sm/accent/normal/30.ogg', 'sound/machines/sm/accent/normal/31.ogg', 'sound/machines/sm/accent/normal/32.ogg', 'sound/machines/sm/accent/normal/33.ogg')
			if ("struggle_sound")
				soundin = pick( 'sound/vore/pred/struggle_01.ogg','sound/vore/pred/struggle_02.ogg','sound/vore/pred/struggle_03.ogg',
								'sound/vore/pred/struggle_04.ogg','sound/vore/pred/struggle_05.ogg')
			if ("prey_struggle")
				soundin = pick( 'sound/vore/prey/struggle_01.ogg','sound/vore/prey/struggle_02.ogg','sound/vore/prey/struggle_03.ogg',
								'sound/vore/prey/struggle_04.ogg','sound/vore/prey/struggle_05.ogg')
			if ("digest_pred")
				soundin = pick( 'sound/vore/pred/digest_01.ogg','sound/vore/pred/digest_02.ogg','sound/vore/pred/digest_03.ogg',
								'sound/vore/pred/digest_04.ogg','sound/vore/pred/digest_05.ogg','sound/vore/pred/digest_06.ogg',
								'sound/vore/pred/digest_07.ogg','sound/vore/pred/digest_08.ogg','sound/vore/pred/digest_09.ogg',
								'sound/vore/pred/digest_10.ogg','sound/vore/pred/digest_11.ogg','sound/vore/pred/digest_12.ogg',
								'sound/vore/pred/digest_13.ogg','sound/vore/pred/digest_14.ogg','sound/vore/pred/digest_15.ogg',
								'sound/vore/pred/digest_16.ogg','sound/vore/pred/digest_17.ogg','sound/vore/pred/digest_18.ogg')
			if ("death_pred")
				soundin = pick( 'sound/vore/pred/death_01.ogg','sound/vore/pred/death_02.ogg','sound/vore/pred/death_03.ogg',
								'sound/vore/pred/death_04.ogg','sound/vore/pred/death_05.ogg','sound/vore/pred/death_06.ogg',
								'sound/vore/pred/death_07.ogg','sound/vore/pred/death_08.ogg','sound/vore/pred/death_09.ogg',
								'sound/vore/pred/death_10.ogg')
			if ("digest_prey")
				soundin = pick( 'sound/vore/prey/digest_01.ogg','sound/vore/prey/digest_02.ogg','sound/vore/prey/digest_03.ogg',
								'sound/vore/prey/digest_04.ogg','sound/vore/prey/digest_05.ogg','sound/vore/prey/digest_06.ogg',
								'sound/vore/prey/digest_07.ogg','sound/vore/prey/digest_08.ogg','sound/vore/prey/digest_09.ogg',
								'sound/vore/prey/digest_10.ogg','sound/vore/prey/digest_11.ogg','sound/vore/prey/digest_12.ogg',
								'sound/vore/prey/digest_13.ogg','sound/vore/prey/digest_14.ogg','sound/vore/prey/digest_15.ogg',
								'sound/vore/prey/digest_16.ogg','sound/vore/prey/digest_17.ogg','sound/vore/prey/digest_18.ogg')
			if ("death_prey")
				soundin = pick( 'sound/vore/prey/death_01.ogg','sound/vore/prey/death_02.ogg','sound/vore/prey/death_03.ogg',
								'sound/vore/prey/death_04.ogg','sound/vore/prey/death_05.ogg','sound/vore/prey/death_06.ogg',
								'sound/vore/prey/death_07.ogg','sound/vore/prey/death_08.ogg','sound/vore/prey/death_09.ogg',
								'sound/vore/prey/death_10.ogg')
			if("hunger_sounds")
				soundin = pick(	'sound/vore/growl1.ogg','sound/vore/growl2.ogg','sound/vore/growl3.ogg','sound/vore/growl4.ogg',
								'sound/vore/growl5.ogg')

	return soundin
