//spears
/obj/item/twohanded/spear
	icon_state = "spearglass0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "improvised metal glaive"
	desc = "A improvised metal glaive that can be wielded."
	force = 25
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 25
	reach = 2
	throw_speed = 4
	embedding = list("embedded_impact_pain_multiplier" = 3)
	armour_penetration = 0
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "impaled", "jabbed", "torn", "gored")
	sharpness = IS_SHARP
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	var/obj/item/grenade/explosive = null
	var/war_cry = "AAAAARGH!!!"

/obj/item/twohanded/spear/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70, /datum/component/two_handed, force_unwielded=25, force_wielded=40) //decent in a pinch, but pretty bad.

/obj/item/twohanded/spear/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to sword-swallow \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(explosive)
		user.say("[war_cry]")
		explosive.forceMove(user)
		explosive.prime()
		user.gib()
		qdel(src)
		return BRUTELOSS
	return BRUTELOSS

/obj/item/twohanded/spear/examine(mob/user)
	..()
	if(explosive)
		to_chat(user, "<span class='notice'>Alt-click to set your war cry.</span>")

/obj/item/twohanded/spear/update_icon()
	if(explosive)
		icon_state = "spearbomb"
	else
		icon_state = "spearglass"

/obj/item/twohanded/spear/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(AM)) //So you can actually melee with it
		return
	if(explosive)
		user.say("[war_cry]")
		explosive.forceMove(AM)
		explosive.prime()
		qdel(src)

 //THIS MIGHT BE UNBALANCED SO I DUNNO // it totally is.
/obj/item/twohanded/spear/throw_impact(atom/target)
	. = ..()
	if(!.) //not caught
		if(explosive)
			explosive.prime()
			qdel(src)

/obj/item/twohanded/spear/AltClick(mob/user)
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(!explosive)
			return
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you want your war cry to be? You will shout it when you hit someone in melee.", ,"", 50)
			if(input)
				src.war_cry = input

/obj/item/twohanded/spear/CheckParts(list/parts_list)
	var/obj/item/twohanded/spear/S = locate() in parts_list
	if(S)
		if(S.explosive)
			S.explosive.forceMove(get_turf(src))
			S.explosive = null
		parts_list -= S
		qdel(S)
	..()
	var/obj/item/grenade/G = locate() in contents
	if(G)
		explosive = G
		name = "explosive lance"
		desc = "A makeshift spear with [G] attached to it."
	update_icon()

/obj/item/twohanded/spear/ultra
	icon_state = "ultraglaive0"
	name = "Ultracite glaive"
	desc = "An ultracite enhanced metal glaive that can be wielded."
	force = 35

/obj/item/twohanded/spear/ultra/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70, /datum/component/two_handed, force_unwielded=35, force_wielded=55)

/obj/item/twohanded/spear/ultra/update_icon()
	icon_state = "ultraglaive"

/obj/item/twohanded/spear/ultra/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, TOX, null, 0)