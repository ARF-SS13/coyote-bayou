/*
	output_atoms	(list of atoms)		The destination(s) for the sounds
	mid_sounds		(list or soundfile)	Sound to play over and over -- if its a list, use this format: list(SOUND_LOOP_ENTRY('sound/file.ogg', length_in_deciseconds, chance_weight), SOUND_LOOP_ENTRY('sound/file.ogg', length_in_deciseconds, chance_weight))
	mid_length		(num)				The length to wait between playing mid_sounds -- only used if mid_sounds is NOT a list!
	loop_delay		(num)				Delay between attempts to play a sound. if 0, it tries to play immediately after the sound ends
	start_sound		(soundfile)			Played before starting the mid_sounds loop
	start_length	(num)				How long to wait before starting the main loop after playing start_sound
	end_sound		(soundfile)			The sound played after the main loop has concluded
	chance			(num)				Chance per loop to play a mid_sound
	volume			(num or list)		Sound output volume
	max_loops		(num)				The max amount of loops to run for.
	direct			(bool)				If true plays directly to provided atoms instead of from them
*/
/datum/looping_sound
	var/list/atom/output_atoms = list()
	var/list/mid_sounds
	var/mid_length
	var/loop_delay = 0
	var/list/start_sound
	var/start_length
	var/list/end_sound
	var/chance
	var/volume = 100
	var/vary = FALSE
	/// Makes direct sounds emulate coming from other directions
	var/vary_direction = FALSE
	var/max_loops
	var/direct
	var/extra_range = 0
	var/falloff
	var/channel

	var/timerid
	var/init_timerid

/datum/looping_sound/New(list/_output_atoms=list(), start_immediately=FALSE, _direct)
	if(!mid_sounds)
		WARNING("A looping sound datum was created without sounds to play.")
		return

	if(LAZYLEN(_output_atoms))
		output_atoms |= _output_atoms
	if(_direct)
		direct = _direct

	if(start_immediately)
		start()

/datum/looping_sound/Destroy()
	stop(kill = TRUE)
	output_atoms = null
	return ..()

/datum/looping_sound/proc/add_atom(atom/add_thing)
	if(!istype(add_thing))
		CRASH("looping sound [src] given [add_thing]. [add_thing] is not an atom!!!!!!!!!!!!!!!!!")
	output_atoms |= add_thing
	RegisterSignal(add_thing, COMSIG_PARENT_PREQDELETED,PROC_REF(remove_atom))

/datum/looping_sound/proc/remove_atom(atom/remove_thing)
	UnregisterSignal(remove_thing, COMSIG_PARENT_PREQDELETED)
	output_atoms -= remove_thing

/datum/looping_sound/proc/start(atom/add_thing)
	if(add_thing)
		output_atoms |= add_thing
		RegisterSignal(add_thing, COMSIG_PARENT_PREQDELETED, PROC_REF(remove_atom), override = TRUE)
	if(timerid || init_timerid) // already running, will pick them up on the next go
		return
	on_start()

/// *Kill kills the timer, even if things are still in the output atoms list
/// This is crucial for things like microwaves and weather, as they'll always have something in their list, and otherwise it'll NEVER stop playing
/// Areas use output_atoms differently, as a list of players to play the sound to. If we stop it as normal and kill it, itll stop playing to all mobs who were listening!
/// To sum up: If the output_atoms are *playing* the sound, kill should = true
/// If the output_atoms are *listening* to the sound, kill should = false
/datum/looping_sound/proc/stop(atom/remove_thing, kill = TRUE)
	on_stop()
	if(remove_thing)
		output_atoms -= remove_thing
		UnregisterSignal(remove_thing, COMSIG_PARENT_PREQDELETED)
	if(LAZYLEN(output_atoms) && !kill)
		return // If people're still listening, dont kill it yet
	if(init_timerid)
		deltimer(init_timerid)
		init_timerid = null
	if(!timerid)
		return
	deltimer(timerid)
	timerid = null

/datum/looping_sound/proc/sound_loop(starttime)
	if(max_loops && world.time >= starttime + ((mid_length + loop_delay) * max_loops))
		stop(kill = TRUE)
		return
	var/list/atoms_cache = output_atoms
	if(!LAZYLEN(atoms_cache))
		return // If a datum sound_loops and nobodys around to hear it, does it make a sound? no
	if(!chance || prob(chance))
		var/sound_play = get_sound(starttime)
		if(!sound_play) // someone didnt set it up right~
			stop(kill = TRUE)
			return
		if(isfile(sound_play))
			sound_play = list(sound_play, mid_length)
		play(sound_play)
		mid_length = sound_play[SL_FILE_LENGTH]
	if(!timerid)
		timerid = addtimer(CALLBACK(src,PROC_REF(sound_loop), world.time), mid_length + loop_delay, TIMER_CLIENT_TIME | TIMER_STOPPABLE | TIMER_LOOP)
	else
		set_timer_wait(timerid, mid_length + loop_delay)

/// takes in list('sound/file.ogg', mid_length) and plays the file and ques up another in mid_length deciseconds
/datum/looping_sound/proc/play(list/sound_list)
	var/list/atoms_cache = output_atoms
	if(!LAZYLEN(atoms_cache))
		return
	var/sound/S = sound(sound_list[SL_FILE_PATH])
	if(direct)
		if(channel)
			S.channel = channel
		else
			S.channel = SSsounds.random_available_channel()
		if(vary_direction)
			S.x = rand(-10, 10)
			S.z = rand(-10, 10)
	if(islist(volume))
		S.volume = rand(volume[AMB_MIN_VOLUME], volume[AMB_MAX_VOLUME])
	else
		S.volume = volume
	for(var/i in 1 to atoms_cache.len)
		var/atom/thing = atoms_cache[i]
		if(direct)
			SEND_SOUND(thing, S)
		else
			playsound(thing, S, S.volume, vary, extra_range, falloff)

/// Converts SOUND_LOOP_ENTRY('sound/file.ogg', length, weight) to list('sound/file.ogg', length) and returns that
/datum/looping_sound/proc/get_sound(starttime, _mid_sounds)
	var/list/sound_list
	if(_mid_sounds)
		sound_list = _mid_sounds
	else
		sound_list = mid_sounds
	if(sound_list)
		if(!islist(sound_list))
			sound_list = list(SOUND_LOOP_ENTRY(sound_list, mid_length, 1))
	if(LAZYLEN(sound_list))
		return pickweight(sound_list)

/datum/looping_sound/proc/on_start()
	var/start_wait = 0
	if(start_sound)
		var/list/sound_start = pickweight(start_sound)
		play(sound_start)
		start_wait = sound_start[SL_FILE_LENGTH]
	init_timerid = addtimer(CALLBACK(src,PROC_REF(sound_loop)), start_wait, TIMER_CLIENT_TIME | TIMER_STOPPABLE)

/datum/looping_sound/proc/on_stop()
	if(end_sound)
		var/list/sound_end = pickweight(end_sound)
		play(sound_end)
