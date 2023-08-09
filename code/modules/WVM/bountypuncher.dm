/obj/machinery/cardpuncher
	name = "Card Puncher"
	desc = "A vending machine that's been modified to accept various items in exchange for copper Edisons. \
			A sign on it reads, 'Keep your workplace clean and get paid doing it!' \
			It's better than a trash can, at least."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "trade_idle"
	flags_1 = DEFAULT_RICOCHET_1 | NODECONSTRUCT_1

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	circuit = /obj/item/circuitboard/machine/card_puncher

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  // infinite profits should be crap, more limited profits should be good. Should never be better than cargo.
	var/trader_key = WVM_SCRAPPER

/obj/machinery/cardpuncher/attackby(obj/item/I, mob/living/user, params, damage_override)
	if(istype(I, /obj/item/card))
		punch_card(user, I)
	else
		. = ..()
	
/obj/machinery/cardpuncher/proc/punch_card(mob/living/user, obj/item/card/thecard)
	if(!istype(thecard) || !isliving(user))
		return
	if(thecard.punch(user))
		playsound(get_turf(src), "sounds/somekindofsound.ogg")
		visible_message("[user] punches [thecard]!")



