/obj/machinery/cardpuncher
	name = "Bounty Ticket Puncher"
	desc = "A machine rigged with a series of hole punchers and a slot for inserting bounty tickets!"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "ticketmachine"
	flags_1 = DEFAULT_RICOCHET_1 | NODECONSTRUCT_1

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9
	circuit = /obj/item/circuitboard/machine/cardpuncher

/obj/machinery/cardpuncher/attackby(obj/item/I, mob/living/user, params, damage_override)
    if(istype(I, /obj/item/card))
        punch_card(user, I)
    else
        . = ..()

/obj/machinery/cardpuncher/proc/punch_card(mob/living/user, obj/item/card/thecard)
	if(!istype(thecard) || !isliving(user))
		return
	if(thecard.punch(user))
		new /obj/item/stack/f13Cash/random/bankerticket(get_turf(src))
		playsound(get_turf(src), 'sound/weapons/circsawhit.ogg', 50, 1)


