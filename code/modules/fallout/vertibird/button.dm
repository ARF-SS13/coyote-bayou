/obj/machinery/button/vertibird
	name = "Lock Vertibird"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/button/vertibird/attack_hand(mob/user)
	..()
	vertibird:toggleLock(user)

