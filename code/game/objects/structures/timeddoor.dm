GLOBAL_LIST_EMPTY(timeddoor_list)
/obj/structure/timeddoor // Used for Fallout bunkers
	name = "mysterious door"
	desc = "A weird clicking can be heard coming from within the door"
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "timedoor"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Ensures that even if theres a fuckload of these doors, only one message and sound will happen per group of doors
	/// To use, just set a bunch of these doors to the same region key, and they'll do the rest
	var/region_key = "some_door"
	/// Message sent to all players when the door opens
	var/open_message = span_notice("The ground rumbles, as though a barrier somewhere has been lifted.")
	/// Sound sent to all players when the door opens
	var/sound_to_play = 'sound/effects/timeddoors/coolwhoosh.ogg'
	/// Door opens this long from when it spawns
	var/deletion_time = 30 MINUTES

/obj/structure/timeddoor/fiveseconds
	region_key = "fiveseconds"
	deletion_time = 5 SECONDS

/obj/structure/timeddoor/sixtyminute
	region_key = "sixtyminute"
	deletion_time = 60 MINUTES

/obj/structure/timeddoor/twohours
	region_key = "twohours"
	deletion_time = 120 MINUTES

/obj/structure/timeddoor/threehours
	region_key = "threehours"
	deletion_time = 180 MINUTES

/obj/structure/timeddoor/fourhours
	region_key = "fourhours"
	deletion_time = 240 MINUTES

/obj/structure/timeddoor/proc/announce_fall()
	if(LAZYACCESS(GLOB.timeddoor_list, region_key))
		return
	GLOB.timeddoor_list[region_key] = TRUE
	to_chat(world, open_message)
	for(var/mob/dingus in GLOB.player_list)
		dingus.playsound_local(src, sound_to_play, 30, distance_multiplier = 0)

/obj/structure/timeddoor/Initialize()
	. = ..()
	addtimer(CALLBACK(src,PROC_REF(timeddeletedoor)), deletion_time)

/obj/structure/timeddoor/proc/timeddeletedoor()
	announce_fall()
	qdel(src)
