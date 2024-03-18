/obj/structure/statue
	name = "statue"
	desc = "Placeholder. Yell at Firecage if you SOMEHOW see this."
	icon = 'icons/obj/statue.dmi'
	icon_state = ""
	density = TRUE
	anchored = FALSE
	max_integrity = 100
	var/oreAmount = 5
	var/material_drop_type = /obj/item/stack/sheet/metal
	var/impressiveness = 15
	CanAtmosPass = ATMOS_PASS_DENSITY


/obj/structure/statue/Initialize()
	. = ..()
	AddElement(/datum/element/art, impressiveness)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum,_AddElement), list(/datum/element/beauty, impressiveness *  75)), 0)
	AddComponent(/datum/component/simple_rotation, ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src,PROC_REF(can_user_rotate)), CALLBACK(src,PROC_REF(can_be_rotated)), null)

/obj/structure/statue/proc/can_be_rotated(mob/user)
	if(!anchored)
		return TRUE
	to_chat(user, span_warning("It's bolted to the floor, you'll need to unwrench it first."))

/obj/structure/statue/proc/can_user_rotate(mob/user)
	return user.canUseTopic(src, BE_CLOSE, FALSE, !iscyborg(user))

/obj/structure/statue/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(default_unfasten_wrench(user, W))
			return
		if(istype(W, /obj/item/weldingtool) || istype(W, /obj/item/gun/energy/plasmacutter))
			if(!W.tool_start_check(user, amount=0))
				return FALSE

			user.visible_message("[user] is slicing apart the [name].", \
								span_notice("You are slicing apart the [name]..."))
			if(W.use_tool(src, user, 40, volume=50))
				user.visible_message("[user] slices apart the [name].", \
									span_notice("You slice apart the [name]!"))
				deconstruct(TRUE)
			return
	return ..()

/obj/structure/statue/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(material_drop_type)
			var/drop_amt = oreAmount
			if(!disassembled)
				drop_amt -= 2
			if(drop_amt > 0)
				new material_drop_type(get_turf(src), drop_amt)
	qdel(src)

//////////////////////////////////////STATUES/////////////////////////////////////////////////////////////
////////////////////////uranium///////////////////////////////////

/obj/structure/statue/uranium
	max_integrity = 300
	light_range = 2
	material_drop_type = /obj/item/stack/sheet/mineral/uranium
	var/last_event = 0
	var/active = null
	impressiveness = 25 // radiation makes an impression

/obj/structure/statue/uranium/nuke
	name = "statue of a nuclear fission explosive"
	desc = "This is a grand statue of a Nuclear Explosive. It has a sickening green colour."
	icon_state = "nuke"

/obj/structure/statue/uranium/eng
	name = "Statue of an engineer"
	desc = "This statue has a sickening green colour."
	icon_state = "eng"

/obj/structure/statue/uranium/attackby(obj/item/W, mob/user, params)
	radiate()
	return ..()

/obj/structure/statue/uranium/Bumped(atom/movable/AM)
	radiate()
	..()

/obj/structure/statue/uranium/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	radiate()
	. = ..()

/obj/structure/statue/uranium/attack_paw(mob/user)
	radiate()
	. = ..()

/obj/structure/statue/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 30)
			last_event = world.time
			active = null
			return
	return

////////////////////////////plasma///////////////////////////////////////////////////////////////////////

/obj/structure/statue/plasma
	max_integrity = 200
	material_drop_type = /obj/item/stack/sheet/mineral/plasma
	desc = "This statue is suitably made from plasma."
	impressiveness = 20

/obj/structure/statue/plasma/scientist
	name = "statue of a scientist"
	icon_state = "sci"

/obj/structure/statue/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)


/obj/structure/statue/plasma/bullet_act(obj/item/projectile/Proj)
	var/burn = FALSE
	if(!(Proj.nodamage) && Proj.damage_type == BURN && !QDELETED(src))
		burn = TRUE
	if(burn)
		var/turf/T = get_turf(src)
		if(Proj.firer)
			message_admins("Plasma statue ignited by [ADMIN_LOOKUPFLW(Proj.firer)] in [ADMIN_VERBOSEJMP(T)]")
			log_game("Plasma statue ignited by [key_name(Proj.firer)] in [AREACOORD(T)]")
		else
			message_admins("Plasma statue ignited by [Proj]. No known firer, in [ADMIN_VERBOSEJMP(T)]")
			log_game("Plasma statue ignited by [Proj] in [AREACOORD(T)]. No known firer.")
		PlasmaBurn(2500)
	return ..()

/obj/structure/statue/plasma/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature() > 300 && !QDELETED(src))//If the temperature of the object is over 300, then ignite
		var/turf/T = get_turf(src)
		message_admins("Plasma statue ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Plasma statue ignited by [key_name(user)] in [AREACOORD(T)]")
		ignite(W.get_temperature())
	else
		return ..()

/obj/structure/statue/plasma/proc/PlasmaBurn(exposed_temperature)
	if(QDELETED(src))
		return
	atmos_spawn_air("plasma=[oreAmount*10];TEMP=[exposed_temperature]")
	deconstruct(FALSE)

/obj/structure/statue/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

//////////////////////gold///////////////////////////////////////

/obj/structure/statue/gold
	max_integrity = 300
	material_drop_type = /obj/item/stack/sheet/mineral/gold
	desc = "This is a highly valuable statue made from gold."
	impressiveness = 30

/obj/structure/statue/gold/hos
	name = "statue of the head of security"
	icon_state = "hos"

/obj/structure/statue/gold/hop
	name = "statue of the head of personnel"
	icon_state = "hop"

/obj/structure/statue/gold/cmo
	name = "statue of the chief medical officer"
	icon_state = "cmo"

/obj/structure/statue/gold/ce
	name = "statue of the chief engineer"
	icon_state = "ce"

/obj/structure/statue/gold/rd
	name = "statue of the research director"
	icon_state = "rd"

//////////////////////////silver///////////////////////////////////////

/obj/structure/statue/silver
	max_integrity = 300
	material_drop_type = /obj/item/stack/sheet/mineral/silver
	desc = "This is a valuable statue made from silver."
	impressiveness = 25

/obj/structure/statue/silver/md
	name = "statue of a medical officer"
	icon_state = "md"

/obj/structure/statue/silver/janitor
	name = "statue of a janitor"
	icon_state = "jani"

/obj/structure/statue/silver/sec
	name = "statue of a security officer"
	icon_state = "sec"

/obj/structure/statue/silver/secborg
	name = "statue of a security cyborg"
	icon_state = "secborg"

/obj/structure/statue/silver/medborg
	name = "statue of a medical cyborg"
	icon_state = "medborg"

/////////////////////////diamond/////////////////////////////////////////

/obj/structure/statue/diamond
	max_integrity = 1000
	material_drop_type = /obj/item/stack/sheet/mineral/diamond
	desc = "This is a very expensive diamond statue."
	impressiveness = 60

/obj/structure/statue/diamond/captain
	name = "statue of THE captain."
	icon_state = "cap"

/obj/structure/statue/diamond/ai1
	name = "statue of the AI hologram."
	icon_state = "ai1"

/obj/structure/statue/diamond/ai2
	name = "statue of the AI core."
	icon_state = "ai2"

/////////////////////sandstone/////////////////////////////////////////

/obj/structure/statue/sandstone
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/sandstone

/obj/structure/statue/sandstone/assistant
	name = "statue of an assistant"
	desc = "A cheap statue of sandstone for a greyshirt."
	icon_state = "assist"

/obj/structure/statue/sandstone/gravestone
	name = "gravestone"
	desc = "A stone grave marker, the name of the person buried here has long been lost to time."
	icon = 'icons/obj/graveyard.dmi'
	icon_state = "stone-1"


/obj/structure/statue/sandstone/venus //call me when we add marble i guess
	name = "statue of a pure maiden"
	desc = "An ancient marble statue. The subject is depicted with a floor-length braid and is wielding a toolbox. By Jove, it's easily the most gorgeous depiction of a woman you've ever seen. The artist must truly be a master of his craft. Shame about the broken arm, though."
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "venus"

/////////////////////snow/////////////////////////////////////////

/obj/structure/statue/snow
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/snow

/obj/structure/statue/snow/snowman
	name = "snowman"
	desc = "Several lumps of snow put together to form a snowman."
	icon_state = "snowman"

/obj/structure/statue/sandstone/mars
	name = "statue of Mars"
	desc = "A statue dedicated to Legion's God of War."
	icon_state = "marsred"

//Wood

/obj/structure/statue/wood
	obj_integrity = 150
	material_drop_type = /obj/item/stack/sheet/mineral/wood

/obj/structure/statue/wood/headstonewood
	name = "gravemarker"
	desc = "A wooden gravemarker, used to mark a burial site."
	icon = 'icons/obj/graveyard.dmi'
	icon_state = "wooden"
	density = 0
	anchored = 1
	oreAmount = 2
	var/obj/item/clothing/head/Helmet = null
	var/obj/item/card/id/dogtag/Dogtags = null

/obj/structure/statue/wood/headstonewood/examine(mob/user)
	. = ..()
	if(Helmet)
		. += span_notice("It has [Helmet] on it.")
	if(Dogtags)
		. += span_notice("It has [Dogtags] on it.")

/obj/structure/statue/wood/headstonewood/Destroy()
	if(Helmet)
		Helmet.forceMove(src.loc)
	if(Dogtags)
		Dogtags.forceMove(src.loc)
	return ..()

/obj/structure/statue/wood/headstonewood/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/clothing/head))
		if(Helmet)
			to_chat(user, span_notice("There's already a hat on the marker."))
			return
		W.forceMove(src)
		Helmet = W
		update_icon()
		user.visible_message("[user] puts the [Helmet] on the grave marker.", "You put the [Helmet] on the grave marker.")
		return
	if(istype(W, /obj/item/card/id/dogtag))
		if(Dogtags)
			to_chat(user, span_notice("There's already some dogtags on the marker."))
			return
		W.forceMove(src)
		Dogtags = W
		update_icon()
		user.visible_message("[user] puts the [Dogtags] on the grave marker.", "You put the [Dogtags] on the grave marker.")
		return
	..()

/obj/structure/statue/wood/headstonewood/attack_hand(mob/user)
	if(Helmet)
		user.put_in_hands(Helmet)
		user.visible_message("[user] removes the [Helmet] from the grave marker.", "You remove the [Helmet] from the grave marker.")
		Helmet = null
		update_icon()
		return
	if(Dogtags)
		user.put_in_hands(Dogtags)
		user.visible_message("[user] removes the [Dogtags] from the grave marker.", "You remove the [Dogtags] from the grave marker.")
		Dogtags = null
		update_icon()
		return
	..()

/obj/structure/statue/wood/headstonewood/update_icon()
	name = initial(name)
	overlays.Cut()
	if(Dogtags)
		var/icon/O = new('icons/mob/mob.dmi', icon_state = "[Dogtags.icon_state]")
		O.Shift(SOUTH, 6)
		overlays += O
		name = "[initial(name)] ([Dogtags.registered_name])"
	if(Helmet)
		var/icon/O = new('icons/mob/clothing/head.dmi', icon_state = "[Helmet.icon_state]")
		O.Shift(SOUTH, 6)
		overlays += O

//fortuna statues

/obj/structure/statue/bos/ladyleft
	name = "The Lady"
	desc = "The inscription reads 'Scribe with hands outstretched, pray her shelter of the world, reborn anew of olde.'"
	icon = 'icons/obj/tomb.dmi'
	icon_state = "ladystatue-left"
	anchored = TRUE
/obj/structure/statue/bos/ladyright
	name = "The Lady"
	desc = "The inscription reads 'Scribe with hands outstretched, pray her shelter of the world, reborn anew of olde.'"
	icon = 'icons/obj/tomb.dmi'
	icon_state = "ladystatue-right"
	anchored = TRUE
