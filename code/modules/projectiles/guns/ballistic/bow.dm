/obj/item/gun/ballistic/bow
	name = "base bow"
	desc = "base type of bow used to define features for multiple-loading bows"
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "bow"
	item_state = "bow"
	weapon_class = null
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
	draw_time = GUN_DRAW_QUICK
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	mag_type = /obj/item/ammo_box/magazine/internal/bow
	fire_sound = 'sound/weapons/bowfire.wav'
	item_flags = NONE
	pin = null
	no_pin_required = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL //so ashwalkers (and monke) can use it
	spawnwithmagazine = TRUE
	casing_ejector = TRUE
	
	var/recentdraw
	var/draw_sound = 'sound/weapons/bowdraw.wav'
	dryfire_text = "*no arrows*"
	dryfire_sound = ""
	var/release_text = "You gently release the bowstring, removing the arrow."
	var/draw_noun = "string"
	safety = 0
	restrict_safety = 1
	init_firemodes = list(
		/datum/firemode/semi_auto/slowest
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION


	/// Can this bow link to a quiver?
	var/can_link_to_quiver = TRUE
	/// Is this bow drawing from a quiver, if linked?
	var/drawing_from_quiver = FALSE
	/// The quiver the bow is drawing from
	var/datum/weakref/our_quiver
	var/list/slotlist = list(
		SLOT_BACK,
		SLOT_BELT,
		SLOT_NECK,
		SLOT_WEAR_SUIT,
		SLOT_L_STORE,
		SLOT_R_STORE,
		SLOT_S_STORE,
		SLOT_GENERIC_DEXTROUS_STORAGE
	)

/obj/item/gun/ballistic/bow/process_chamber(mob/living/user, empty_chamber = 0)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		AC.forceMove(drop_location()) //Eject casing onto ground.
		chambered = null

/obj/item/gun/ballistic/bow/examine(mob/user)
	. = ..()
	if(can_link_to_quiver && loc == user)
		if(!drawing_from_quiver)
			. += "Not drawing from a worn quiver."
			. += "Alt-click the bow to start drawing from a quiver."
			return
		var/obj/item/storage/bag/tribe_quiver/my_quiver = get_quiver(user)
		if(istype(my_quiver))
			. += "Currently drawing from [my_quiver]."
			. += "Alt-click the bow to stop drawing from this quiver."
			. += "Smack a quiver against this bow, or smack this against a quiver, to start drawing arrows from that quiver."
			return
		. += "No quiver found to draw from. Wear a quiver on your belt, or smack a quiver on this bow, to draw from that quiver."
		. += "Alt-click the bow to stop drawing from this quiver."

/obj/item/gun/ballistic/bow/can_shoot()
	return chambered

/obj/item/gun/ballistic/bow/attack_self(mob/living/user)
	if(chambered)
		user.put_in_hands(chambered)
		chambered = null
		update_icon()
		to_chat(user, span_notice(release_text))
		return
/* 	if(recentdraw > world.time || !get_ammo(FALSE))
		return */
	draw(user, TRUE)
//	recentdraw = world.time + 2

/obj/item/gun/ballistic/bow/proc/draw(mob/M, visible = TRUE)
	if(!draw_load(M))
		return TRUE
	if(visible)
		M.visible_message(span_warning("[M] draws the [draw_noun] on [src]!"), span_warning("You draw the [draw_noun] on [src]!"))
	playsound(M, draw_sound, 60, 1)
	draw_load(M)
	update_icon()
	return 1

/obj/item/gun/ballistic/bow/proc/draw_load(mob/M)
	if(chambered)
		return FALSE
	if(!magazine.ammo_count() && !load_from_quiver(M)) // if its empty, try sticking a new ammo in there
		return FALSE
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC
	. = TRUE
	var/room_left_in_mag = magazine.max_ammo - LAZYLEN(magazine.stored_ammo)
	if(room_left_in_mag) // and fill up the rest of the bow if possible
		var/did_a_load = FALSE
		for(var/i in 1 to room_left_in_mag)
			if(!load_from_quiver(M))
				break
			did_a_load = TRUE
		if(did_a_load)
			M.show_message(span_notice("You ready some arrows from your quiver."))

/obj/item/gun/ballistic/bow/proc/load_from_quiver(mob/user)
	if(!drawing_from_quiver)
		return FALSE
	if(!can_link_to_quiver)
		return FALSE
	if(!istype(user))
		return FALSE
	if(LAZYLEN(magazine.stored_ammo) >= magazine.max_ammo)
		return FALSE
	var/obj/item/storage/bag/tribe_quiver/got_quiver = get_quiver(user)
	if(!istype(got_quiver))
		return FALSE
	for(var/obj/item/ammo_casing/isit_pointy in got_quiver.contents)
		if(!isit_pointy.BB)
			continue
		if(!SEND_SIGNAL(got_quiver, COMSIG_TRY_STORAGE_TAKE, isit_pointy, magazine))
			continue
		if(magazine.give_round(isit_pointy))
			return TRUE

/obj/item/gun/ballistic/bow/proc/get_quiver(mob/user, just_get_it)
	if(!istype(user))
		return
	var/obj/item/storage/bag/tribe_quiver/getted_quiver
	/// First try and draw from our chosen quiver
	if(isweakref(our_quiver))
		getted_quiver = our_quiver.resolve()
		if(istype(getted_quiver, /obj/item/storage/bag/tribe_quiver) && (getted_quiver.loc == user || just_get_it))
			return getted_quiver
	/// Otherwise, draw from whatever's on the belt
	for(var/slut in slotlist)
		getted_quiver = user.get_item_by_slot(slut)
		if(!istype(getted_quiver, /obj/item/storage/bag/tribe_quiver))
			continue
		if((getted_quiver.loc != user && !just_get_it))
			continue
		if(link_quiver_to_bow(user, getted_quiver))
			return getted_quiver

/obj/item/gun/ballistic/bow/proc/link_quiver_to_bow(mob/user, obj/item/storage/bag/tribe_quiver/the_quiver)
	if(!istype(the_quiver))
		return
	if(!ismob(user))
		return
	if(our_quiver)
		var/obj/item/storage/bag/tribe_quiver/prev_quiver = our_quiver.resolve()
		if(prev_quiver == the_quiver)
			user.show_message(span_notice("[src] is already drawing from [the_quiver]!"))
			return TRUE
	our_quiver = WEAKREF(the_quiver)
	if(our_quiver)
		user.show_message(span_notice("You are now drawing from [the_quiver]!"))
		return TRUE

/obj/item/gun/ballistic/bow/AltClick(mob/living/carbon/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return FALSE
	if(loc != user)
		return FALSE
	drawing_from_quiver = !drawing_from_quiver
	if(can_link_to_quiver)
		user.show_message("You're [drawing_from_quiver?"now":"no longer"] drawing from a quiver, if one is worn.")
	return TRUE

/obj/item/gun/ballistic/bow/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/storage/bag/tribe_quiver))
		link_quiver_to_bow(user, A)
		return
	/*if(istype(A, /obj/item/gun_upgrade))
		return*/
	if(magazine.attackby(A, user, params, 1))
		to_chat(user, span_notice("You load [A] into \the [src]."))
		update_icon()
		return
	// Bows hate attachments, this tries to check for them. I'm done fucking with it, someone skilled is needed

/obj/item/gun/ballistic/bow/update_icon()
	icon_state = "[initial(icon_state)]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"

/obj/item/gun/ballistic/bow/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", bonus_spread = 0, stam_cost = 0)
	..()
	if(HAS_TRAIT(user, TRAIT_AUTO_DRAW) && !chambered && get_ammo(FALSE))
		user.visible_message(span_warning("[user] instinctively draws the string on [src]!"), span_warning("You instinctively draw the string on [src]!"))
		draw(user, FALSE)
		recentdraw = world.time + 2

//////////////////////////////
//	Coyote Boyou Additions	//
//////////////////////////////
/obj/item/gun/ballistic/bow
	force = 15
	force_wielded = 30

/obj/item/gun/ballistic/bow/CtrlShiftClick(mob/user)
	if(damtype == BRUTE)
		balloon_alert(user, "Switched to Stamina melee damage.")
		damtype = STAMINA
	else
		balloon_alert(user, "Switched to Brute melee damage.")
		damtype = BRUTE
// Hopefully some player somewhere at some point in time will make use of this incredibly niche attack.
// Not without telling them about it lmfao

//////////////
//	Tier 1	//
//////////////
// Shortbow - Loadout bow, fits in bags.
/obj/item/gun/ballistic/bow/shortbow
	name = "Shortbow"
	desc = "A compact bow with a low draw weight. Easy to make, gets the job done. It can fit in your bag, however."
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "shortbow"
	item_state = "bow" 
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	damage_multiplier = GUN_EXTRA_DAMAGE_0 // Cheap, worst bow.

/obj/item/gun/ballistic/bow/shortbow/nayriin_crossbow
	name = "Marksman Crossbow"
	desc = "A compact crossbow with a precision scope."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "xbow"
	item_state = "xbow"
	trigger_guard = TRIGGER_GUARD_NONE
	can_scope = FALSE
	zoom_factor = 1.5
	damage_multiplier = GUN_EXTRA_DAMAGE_0

/obj/item/gun/ballistic/bow/shortbow/yumi
	name = "yumi bow"
	desc = "A lightweight samurai bow. It's big, has low draw weight. Why would someone use this?"	//temporary fix
	icon_state = "tribalbow"
	item_state = "bow"
	damage_multiplier = GUN_EXTRA_DAMAGE_0 //BASIC 40 DAMAGE, SLOW SHOTS, BUT COMPACT

//dunno if you want to include more information for each bow, but this is the basics

//////////////
//	Tier 2	//
//////////////
//	Modern Recurve Bow - The sort of thing you'd get at a sports shop, made with modern materials. Not craftable (Pre-War, duh) loot-drop.
//	Light Crossbow - Currently one player's exclusive loadout item. Needs removing and re-implementing properly!

/obj/item/gun/ballistic/bow/modern
	name = "Modern Recurve Bow"
	desc = "A recurve bow manufactured with modern tools and materials."
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "modern"
	item_state = "bow"
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //Now actually worth taking over the longbow.
	init_firemodes = list(
		/datum/firemode/semi_auto/slower // Fires faster, more accurate.
	)

/obj/item/gun/ballistic/bow/longbow
	name = "Longbow"
	desc = "Large, bulky and powerful. "
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "longbow"
	item_state = "bow"
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	init_recoil = RIFLE_RECOIL(3, 3) // Fires the slowest, high damage, hard to control
	w_class = WEIGHT_CLASS_BULKY

/obj/item/gun/ballistic/bow/lightxbow
	name = "Light Crossbow"
	desc = "A compact crossbow, with decent firepower."
	icon_state = "xbow"
	item_state = "xbow"
	trigger_guard = TRIGGER_GUARD_NONE
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //50 damage. bolt action rifle firepower

//////////////
//	Tier 3	//
//////////////
// Composite Bow - Best bow that can fit into a bag.

/obj/item/gun/ballistic/bow/composite
	name = "Composite Bow"
	desc = "An amalgamation of different materials - wood, animal horn and string, makes it faster to use. Can be stored within bags."
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "composite"
	item_state = "bow"
	damage_multiplier = GUN_EXTRA_DAMAGE_T2 // Has lower damage, high firerate
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,// Fires much faster
	)

/obj/item/gun/ballistic/bow/composite/masterwork
	name = "Masterwork Composite Bow"
	desc = "A work of art produced by a seasoned bowyer, addorned with gold leaf."
	icon_state = "composite_gold"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
	)
	damage_multiplier = GUN_EXTRA_DAMAGE_T5 // The chiefs bow, supposed to be for tribal chiefs only

//tier 4 legendary bow, either boss tier or unique tier, unsure just yet
//modern compound bow. speed++, damage++. the ultimate bow
/obj/item/gun/ballistic/bow/compoundbow
	name = "prewar compound bow"
	desc = "A rare, functional prewar bow, with a complex system of pullies that allow for a much stronger draw, with much less effort. The pinical of weaponry like this. Alt click to attach to a quiver on your belt slot."
	icon_state = "pipebow"
	item_state = "bow"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
	)
	damage_multiplier = GUN_EXTRA_DAMAGE_T6 // The damn longbow WAS better than this. Lets make it actually boss tier.
