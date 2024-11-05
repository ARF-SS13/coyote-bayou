/* Clown Items
 * Contains:
 *		Soap
 *		Bike Horns
 *		Air Horns
 *		Canned Laughter
 */

/*
 * Soap
 */

/obj/item/soap
	name = "soap"
	desc = "A cheap bar of soap. Doesn't smell."
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "soap"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	grind_results = list(/datum/reagent/lye = 10)
	var/cleanspeed = 50 //slower than mop
	force_string = "robust... against germs"

/obj/item/soap/Initialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80)

/obj/item/soap/nanotrasen
	desc = "A US Government brand bar of soap. Smells of plasma."
	icon_state = "soapnt"

/obj/item/soap/homemade
	desc = "A homemade bar of soap. Smells of... well...."
	icon_state = "soapgibs"
	cleanspeed = 45 // a little faster to reward chemists for going to the effort

/obj/item/soap/deluxe
	desc = "A deluxe Waffle Co. brand bar of soap. Smells of high-class luxury."
	icon_state = "soapdeluxe"
	cleanspeed = 40 //same speed as mop because deluxe -- captain gets one of these

/obj/item/soap/syndie
	desc = "An untrustworthy bar of soap made of strong chemical agents that dissolve blood faster."
	icon_state = "soapsyndie"
	cleanspeed = 10 //much faster than mop so it is useful for traitors who want to clean crime scenes

/obj/item/soap/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !check_allowed_items(target))
		return
	//I couldn't feasibly  fix the overlay bugs caused by cleaning items we are wearing.
	//So this is a workaround. This also makes more sense from an IC standpoint. ~Carn
	if(user.client && ((target in user.client.screen) && !user.is_holding(target)))
		to_chat(user, span_warning("You need to take that [target.name] off before cleaning it!"))
	else if(istype(target, /obj/effect/decal/cleanable))
		user.visible_message("[user] begins to scrub \the [target.name] out with [src].", span_warning("You begin to scrub \the [target.name] out with [src]..."))
		if(do_after(user, src.cleanspeed, target = target))
			to_chat(user, span_notice("You scrub \the [target.name] out."))
			qdel(target)
	else if(ishuman(target) && user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		var/mob/living/carbon/human/H = user
		user.visible_message(span_warning("\the [user] washes \the [target]'s mouth out with [src.name]!"), span_notice("You wash \the [target]'s mouth out with [src.name]!")) //washes mouth out with soap sounds better than 'the soap' here
		H.lip_style = null //removes lipstick
		H.update_body()
		return
	else if(istype(target, /obj/structure/window))
		user.visible_message("[user] begins to clean \the [target.name] with [src]...", span_notice("You begin to clean \the [target.name] with [src]..."))
		if(do_after(user, src.cleanspeed, target = target))
			to_chat(user, span_notice("You clean \the [target.name]."))
			target.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
			target.set_opacity(initial(target.opacity))
	else
		user.visible_message("[user] begins to clean \the [target.name] with [src]...", span_notice("You begin to clean \the [target.name] with [src]..."))
		if(do_after(user, src.cleanspeed, target = target))
			to_chat(user, span_notice("You clean \the [target.name]."))
			var/obj/effect/decal/cleanable/C = locate() in target
			qdel(C)
			target.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
			target.clean_blood()
			SEND_SIGNAL(target, COMSIG_COMPONENT_CLEAN_ACT, CLEAN_MEDIUM)
			target.wash_cream()
	return


/*
 * Bike Horns
 */

/obj/item/bikehorn
	name = "bike horn"
	desc = "A horn off of a bicycle."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "bike_horn"
	inhand_icon_state = "bike_horn"
	lefthand_file = 'icons/mob/inhands/equipment/horns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/horns_righthand.dmi'
	throwforce = 0
	hitsound = null //To prevent tap.ogg playing, as the item lacks of force
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb = list("HONKED")
	var/moodlet = "honk" //used to define which kind of moodlet is added to the honked target
	var/list/honksounds = list('sound/items/bikehorn.ogg' = 1)

/obj/item/bikehorn/attack(mob/living/carbon/M, mob/living/carbon/user)
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, moodlet, /datum/mood_event/honk)
	return ..()

/obj/item/bikehorn/silver
	name = "silver bike horn"
	desc = "A shiny bike horn handcrafted in the artisan workshops of Mars, with superior kevlar-reinforced rubber bulb attached to a polished plasteel reed horn."
	attack_verb = list("elegantly HONKED")
	icon_state = "silverhorn"
