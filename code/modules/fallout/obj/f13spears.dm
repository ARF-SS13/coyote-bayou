//spears
/obj/item/spear/ultra
	icon_state = "ultraglaive0"
	name = "Ultracite glaive"
	desc = "An ultracite enhanced metal glaive that can be wielded."
	force = 35

/obj/item/spear/ultra/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70, /datum/component/two_handed, force_unwielded=35, force_wielded=55)

/obj/item/spear/ultra/update_icon()
	icon_state = "ultraglaive"

/obj/item/spear/ultra/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, TOX, null, 0)
