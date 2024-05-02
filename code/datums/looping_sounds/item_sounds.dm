#define RAD_GEIGER_LOW 100							// Geiger counter sound thresholds
#define RAD_GEIGER_MEDIUM 500
#define RAD_GEIGER_HIGH 1000

/datum/looping_sound/geiger
	mid_sounds = list(
		list(
			SOUND_LOOP_ENTRY('sound/items/geiger/low1.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/low2.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/low3.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/low4.ogg', 0.2 SECONDS, 1)
			),
		list(
			SOUND_LOOP_ENTRY('sound/items/geiger/med1.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/med2.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/med3.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/med4.ogg', 0.2 SECONDS, 1)
			),
		list(
			SOUND_LOOP_ENTRY('sound/items/geiger/high1.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/high2.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/high3.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/high4.ogg', 0.2 SECONDS, 1)
			),
		list(
			SOUND_LOOP_ENTRY('sound/items/geiger/ext1.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/ext2.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/ext3.ogg', 0.2 SECONDS, 1),
			SOUND_LOOP_ENTRY('sound/items/geiger/ext4.ogg', 0.2 SECONDS, 1)
			)
		)
	mid_length = 2
	volume = 10
	var/last_radiation

/datum/looping_sound/geiger/get_sound(starttime)
	var/danger
	switch(last_radiation)
		if(RAD_BACKGROUND_RADIATION to RAD_GEIGER_LOW)
			danger = 1
		if(RAD_GEIGER_LOW to RAD_GEIGER_MEDIUM)
			danger = 2
		if(RAD_GEIGER_MEDIUM to RAD_GEIGER_HIGH)
			danger = 3
		if(RAD_GEIGER_HIGH to INFINITY)
			danger = 4
		else
			return null
	return ..(starttime, mid_sounds[danger])

/datum/looping_sound/geiger/stop(atom/remove_thing, kill = FALSE)
	. = ..()
	last_radiation = 0

#undef RAD_GEIGER_LOW
#undef RAD_GEIGER_MEDIUM
#undef RAD_GEIGER_HIGH

/datum/looping_sound/reverse_bear_trap
	mid_sounds = list('sound/effects/clock_tick.ogg')
	mid_length = 3.5
	volume = 25


/datum/looping_sound/reverse_bear_trap_beep
	mid_sounds = list('sound/machines/beep.ogg')
	mid_length = 60
	volume = 10

/datum/looping_sound/tattoo_gun
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/machines/tattoo_buzz.ogg', 1 SECONDS, 1), 
		)
	mid_length = 1 SECONDS
	volume = 30

/datum/looping_sound/cell_charger
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/machines/cell_charger_loop.ogg', 0.8 SECONDS, 1), 
		)
	mid_length = 0.8 SECONDS
	volume = 20

/datum/looping_sound/musket_load
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weapons/stuff_casing.ogg', 0.7 SECONDS, 1), 
		)
	mid_length = 0.7 SECONDS
	volume = 50

/datum/looping_sound/energy_charging
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weapons/energy_chargeloop.ogg', 2.8 SECONDS, 1), 
		)
	mid_length = 2.8 SECONDS
	volume = 50

/datum/looping_sound/musket_fuse
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_01.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_02.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_03.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_04.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_05.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_06.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_07.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_08.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_09.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_10.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_11.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_12.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_13.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_14.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_15.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_16.ogg', 0.2 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/weapons/fuse_loop/fuse_17.ogg', 0.2 SECONDS, 1),
		)
	mid_length = 2
	volume = 20

/datum/looping_sound/rockpile
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_01.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_02.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_03.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_04.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_05.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_06.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_07.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_08.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_09.ogg', 0.5 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/effects/rocks/rocks1_10.ogg', 0.5 SECONDS, 1),
		)
	mid_length = 2
	volume = 35

