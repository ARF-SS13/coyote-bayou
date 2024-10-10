/obj/effect/sound_emitter
	name = "sound emitter"
	desc = "Shh! Just pretend I'm a rock."
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	anchored = TRUE
	layer = MID_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT //This is what makes it unseeable
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// The looping sound it'll play forever.
	var/datum/looping_sound/snd
	/// If every sound rock with the same loop datum thing should sync their output sounds
	var/synchronize = TRUE

/obj/effect/sound_emitter/Initialize()
	. = ..()
	return INITIALIZE_HINT_QDEL
	//if(!ispath(snd))
	//	return
	//if(synchronize)
	//	soundify()
	//else
	//	unique_soundify()

/obj/effect/sound_emitter/Destroy()
	SSweather.remove_sound_rock(src, snd)
	if(istype(snd))
		QDEL_NULL(snd)
	..()

/obj/effect/sound_emitter/ex_act(severity) // if ratley nukes a pond, all the little critter in it are fuckin dead
	if(severity >= 3)
		return
	qdel(src)

/obj/effect/sound_emitter/proc/unique_soundify()
	if(!ispath(snd))
		return
	snd = new snd(list(src))
	snd.start()

/obj/effect/sound_emitter/proc/soundify(datum/looping_sound/override)
	if(ispath(override, /datum/looping_sound))
		SSweather.remove_sound_rock(src, snd)
		snd = override
	SSweather.add_sound_rock(src, snd)

/obj/effect/sound_emitter/debug
	name = "sound emitter (debug)"
	desc = "Hi, I'm a debug sound emitter. I'm here to help you debug your sound emitters. I'm not actually a sound emitter, though. I'm just a rock."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	invisibility = 0
	snd = /datum/looping_sound/ambient/debug3


/obj/effect/sound_emitter/frogs
	name = "sound emitter (frogs)"
	desc = "Sound emitter for frog noises, even if no frogs."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	snd = /datum/looping_sound/soundrock/frogs
	synchronize = FALSE

/obj/effect/sound_emitter/crows
	name = "sound emitter (crows)"
	desc = "Sound emitter for some sort of noise."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	snd = /datum/looping_sound/ambient/critters/birds/crow/louder
	synchronize = FALSE

/obj/effect/sound_emitter/birds
	name = "sound emitter (birds)"
	desc = "Sound emitter for some sort of noise."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	snd = /datum/looping_sound/ambient/critters/birds/louder
	synchronize = FALSE


/obj/effect/sound_emitter/creek
	name = "sound emitter (creek)"
	desc = "Sound emitter for some sort of noise."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	snd = /datum/looping_sound/soundrock/creek
	synchronize = TRUE

