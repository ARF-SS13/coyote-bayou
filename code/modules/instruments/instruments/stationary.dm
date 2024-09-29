/obj/structure/musician
	name = "Not A Piano"
	desc = "Something broke, contact coderbus."
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND | INTERACT_ATOM_UI_INTERACT | INTERACT_ATOM_REQUIRES_DEXTERITY
	var/can_play_unanchored = FALSE
	var/list/allowed_instrument_ids
	var/datum/song/song

/obj/structure/musician/Initialize(mapload)
	. = ..()
	song = new(src, allowed_instrument_ids)
	allowed_instrument_ids = null

/obj/structure/musician/Destroy()
	QDEL_NULL(song)
	return ..()

/obj/structure/musician/proc/should_stop_playing(mob/user)
	if(!(anchored || can_play_unanchored))
		return TRUE
	if(!user)
		return FALSE
	return !user.canUseTopic(src, FALSE, TRUE, FALSE, FALSE)		//can play with TK and while resting because fun.

/obj/structure/musician/ui_interact(mob/user)
	. = ..()
	user.set_machine(src)
	song.ui_interact(user)

/obj/structure/musician/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 40)
	return TRUE

/obj/structure/musician/piano
	name = "minimoog"
	icon = 'icons/obj/musician.dmi'
	icon_state = "minimoog"
	anchored = TRUE
	density = TRUE

/obj/structure/musician/piano/unanchored
	anchored = FALSE

/obj/structure/musician/piano/Initialize(mapload)
	. = ..()
	if(prob(50) && icon_state == initial(icon_state))
		name = "minimoog"
		desc = "This is a minimoog, like a piano, but more futuristic!"
		icon_state = "minimoog"
	else
		name = "piano"
		desc = "This old piano can barely hold a tune. Too bad all the piano tuners are dead, more or less."
		icon_state = "piano"

/obj/structure/piano/fancy
	name = "piano"
	icon = 'icons/obj/musician.dmi'
	icon_state = "piano"
	anchored = FALSE
	density = FALSE
