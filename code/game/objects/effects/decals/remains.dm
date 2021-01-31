/obj/effect/decal/remains
	name = "remains"
	gender = PLURAL
	icon = 'icons/effects/blood.dmi'
	debris_result = /obj/item/stack/sheet/bone
	var/drop_amount = 1

/obj/effect/decal/remains/acid_act()
	visible_message(SPAN_WARNING("[src] dissolve[gender==PLURAL?"":"s"] into a puddle of sizzling goop!"))
	playsound(src, 'sound/items/welder.ogg', 150, 1)
	new /obj/effect/decal/cleanable/greenglow(drop_location())
	qdel(src)

/obj/effect/decal/remains/attack_hand(mob/user)
	visible_message(SPAN_NOTICE("[user] begins to pick through [src]."))
	if(do_after(user, 40, target = src))
		var/atom/find = make_debris()
		if(find)
			to_chat(user, SPAN_NOTICE("You find \a [find] in [src]!"))
		return
	. = ..()

/obj/effect/decal/remains/proc/make_debris()
	if(drop_amount == 0)
		qdel(src)
		return
	drop_amount--
	return new debris_result (get_turf(src), 1)

/obj/effect/decal/remains/proc/examine()
	. = ..()
	if(drop_amount && (drop_amount <= initial(drop_amount)))
		. += SPAN_NOTICE("It looks like someone has already picked through it.")

/obj/effect/decal/remains/human
	desc = "They look like human remains. They have a strange aura about them."
	icon_state = "remains"
	drop_amount = 2

/obj/effect/decal/remains/plasma
	icon_state = "remainsplasma"
	drop_amount = 0

/obj/effect/decal/remains/xeno
	desc = "They look like the remains of something... alien. They have a strange aura about them."
	icon_state = "remainsxeno"
	drop_amount = 2

/obj/effect/decal/remains/xeno/larva
	icon_state = "remainslarva"

/obj/effect/decal/remains/robot
	desc = "They look like the remains of something mechanical. They have a strange aura about them."
	icon = 'icons/mob/robots.dmi'
	icon_state = "remainsrobot"
	drop_amount = 0

/obj/effect/decal/cleanable/robot_debris/old
	name = "dusty robot debris"
	desc = "Looks like nobody has touched this in a while."
