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
	if(!thecard.punch(user))
		to_chat(user, span_alert("That's already been punched! You're free to toss that thing onto the train."))
		return
	var/payout = round(COINS_TO_CREDITS(thecard.punchbonus))
	if(payout)
		new /obj/item/stack/f13Cash/caps(get_turf(src), payout)
	else
		new /obj/item/stack/f13Cash/random/bankerticket(get_turf(src))
	playsound(get_turf(src), 'sound/machines/card_punch.ogg', 50, 1)
	to_chat(user, span_green("You punch the ticket, and coins fall out! Be sure to give the coins to whoever gave you this ticket, that's their reward! You can sell this ticket on the train, or give it back to them if you really want to."))

