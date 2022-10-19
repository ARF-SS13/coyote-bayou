/datum/looping_sound/ambient
	/// Chance every 'mid_length' time to play an ambient sound
	chance = 1
	vary = TRUE
	vary_direction = TRUE
	/// adds in varied volumes, use this format plz: volume = SOUND_LOOP_VOL_RANGE(min, max)
	volume = SOUND_LOOP_VOL_RANGE(10, 50)
	/// Plays the sound directly to the player, cus ambient sounds dont have a real source tile
	direct = TRUE
	/// Here used as time between rolls for sounds happening
	loop_delay = 5 SECONDS

// random bullshit used for testing
/datum/looping_sound/ambient/debug
	chance = 25 // might be kinda low for ambience
	vary = TRUE
	volume = SOUND_LOOP_VOL_RANGE(10, 50)
	direct = TRUE
	vary_direction = TRUE
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/misc/sadtrombone.ogg', 3.5 SECONDS, 1), 
		SOUND_LOOP_ENTRY('sound/machines/microwave/microwave-mid2.ogg', 1 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/machines/sm/supermatter1.ogg', 1 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/items/geiger/ext3.ogg', 0.2 SECONDS, 1)
		)
/datum/looping_sound/ambient/debug2
	chance = 100
	vary = TRUE
	volume = SOUND_LOOP_VOL_RANGE(10, 50)
	direct = TRUE
	loop_delay = 0
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/f13weapons/american180.ogg', 0.2 SECONDS, 1), 
		SOUND_LOOP_ENTRY('sound/f13weapons/boltfire.ogg', 1.7 SECONDS, 1), 
		SOUND_LOOP_ENTRY('sound/f13weapons/laser_rifle.ogg', 2.2 SECONDS, 1), 
		SOUND_LOOP_ENTRY('sound/f13weapons/magnum_fire.ogg', 2.4 SECONDS, 1)
		)
