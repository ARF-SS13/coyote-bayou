/obj/effect/sound_emitter
	name = "sound emitter"
	desc = "Shh! Just pretend I'm a rock."
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	anchored = TRUE
	layer = MID_LANDMARK_LAYER
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// The looping sound it'll play forever.
	var/datum/looping_sound/snd

/obj/effect/sound_emitter/Initialize()
	. = ..()
	if(!ispath(snd))
		return
	soundify()

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
