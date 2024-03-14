//meowmeowcat
/obj/item/hatchet/war_axe
	name = "war axe"
	desc = "A small one-handed axe, great for throwing and hitting people with. Also just as good for chopping down trees!"
	icon = 'modular_coyote/icons/objects/melee.dmi'
	icon_state = "war_axe"
	lefthand_file = 'modular_coyote/icons/mob/inhands/melee_lefthand.dmi'
	righthand_file = 'modular_coyote/icons/mob/inhands/melee_righthand.dmi'
	force = 35
	force_unwielded = 35
	force_wielded = 37	// Specifically one-handed, using both hands is giving you diminishing returns here.
	armour_penetration = 5
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 40
	throw_speed = 1
	throw_range = 10
	custom_materials = list(/datum/material/iron = 12000)	// Six sheets, the same as an ingot.
	hitsound = 'sound/weapons/bladeslice_heavy.ogg'
	weapon_special_component = /datum/component/weapon_special/single_turf
