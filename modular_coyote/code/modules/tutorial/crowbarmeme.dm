/obj/item/crowbar
	name = "sadbar"

/obj/item/crowbar/attack_hand(mob/user, act_intent, attackchain_flags)
	. = ..()
	say("yeet")
