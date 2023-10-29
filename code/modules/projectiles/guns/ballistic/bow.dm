/obj/item/gun/ballistic/bow
	name = "base bow"
	desc = "base type of bow used to define features for multiple-loading bows"
	icon_state = "bow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_NORMAL
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
		/datum/firemode/semi_auto/slower //we start very sloow
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
	if(magazine.attackby(A, user, params, 1))
		to_chat(user, span_notice("You load [A] into \the [src]."))
		update_icon()
		return

/obj/item/gun/ballistic/bow/update_icon()
	icon_state = "[initial(icon_state)]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"

/obj/item/gun/ballistic/bow/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", bonus_spread = 0, stam_cost = 0)
	..()
	if(HAS_TRAIT(user, TRAIT_AUTO_DRAW) && !chambered && get_ammo(FALSE))
		user.visible_message(span_warning("[user] instinctively draws the string on [src]!"), span_warning("You instinctively draw the string on [src]!"))
		draw(user, FALSE)
		recentdraw = world.time + 2

//the main stats we have to work with making each bow different, is size, (normal versus belt, versus back only), damage multiplier, and fire rate
//NOT ALL BOWS SHOULD BE CRAFTABLE. there's no point in having more types of bows and a variety in their stats and power levels if you just rush to craft your max tier bow and ignore all progression

//Tier 1 bow, starter bow
//shortbow. fits in bags, but otherwise minimum stats.
/obj/item/gun/ballistic/bow/shortbow
	name = "shortbow"
	desc = "A lightweight bow, rather lacking in firepower. Alt click to attach to a quiver on your belt slot."
	icon_state = "bow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_0 //BASIC 40 DAMAGE, SLOW SHOTS, BUT COMPACT
	init_firemodes = list(
			/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/bow/shortbow/yumi
	name = "yumi bow"
	desc = "A lightweight samurai bow. It's big, has low draw weight. Why would someone use this? Alt click to attach to a quiver on your belt slot."
	//icon_state = "yumi"		//temporary fix
	icon_state = "tribalbow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_0 //BASIC 40 DAMAGE, SLOW SHOTS, BUT COMPACT
	init_firemodes = list(
			/datum/firemode/semi_auto/slower
	)	

	//weak pocket xbow meant to shoot special arrows rather than pure damage//
/obj/item/gun/ballistic/bow/handxbow
	name = "hand crossbow"
	desc = "A compact, pocket sized crossbow, what it lacks in power makes up in concealment."
	icon_state = "crossbow"
	item_state = "crossbow"
	trigger_guard = TRIGGER_GUARD_NONE
	weapon_class = WEAPON_CLASS_SMALL
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_firemodes = list(
			/datum/firemode/semi_auto/slow
	)
//dunno if you want to include more information for each bow, but this is the basics

//tier 2 bows. craftable bows
//recurve bow. +fire rate, but bulky. fits on belts
/obj/item/gun/ballistic/bow/recurvebow
	name = "recurve bow"
	desc = "A light bow designed for ease of draw. Alt click to attach to a quiver on your belt slot."
	icon_state = "tribalbow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_CARBINE
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
			/datum/firemode/semi_auto/slow
	)

//light crossbow. +damage, bulky but fits on belt
/obj/item/gun/ballistic/bow/lightxbow
	name = "light crossbow"
	desc = "A compact crossbow, with decent firepower."
	icon_state = "xbow"
	item_state = "xbow"
	trigger_guard = TRIGGER_GUARD_NONE
	weapon_class = WEAPON_CLASS_CARBINE
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //50 damage. bolt action rifle firepower
	init_firemodes = list(
			/datum/firemode/semi_auto/slower
	)
	can_scope = TRUE //?

//tier 3 bows. looted only? mid tier loot pools, but marked as common. bow gear progression is lacking, especially when you can just make the highest tier weapon from the communal materal pile
//composite bow. fire rate++ but bulky and back slot only. max potential drawn out with bow trained quirk. will see if it's too wimpy
/obj/item/gun/ballistic/bow/compositebow
	name = "Composite bow"
	desc = "A finely crafted bow with an excellent draw. Alt click to attach to a quiver on your belt slot."
	icon_state = "tribalbow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_RIFLE
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
			/datum/firemode/semi_auto //fast bow. skilled archers will make the most use out of this. mebbe needs buff iuno
	)

//longbow, damage+, speed+, back slot only
/obj/item/gun/ballistic/bow/longbow
	name = "longbow"
	desc = "A tall, elegant bow, with a good balance of firepower and draw speed. Alt click to attach to a quiver on your belt slot."
	icon_state = "ashenbow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_RIFLE
	damage_multiplier = GUN_EXTRA_DAMAGE_T3 //50 damage. bolt action rifle firepower
	init_firemodes = list(
			/datum/firemode/semi_auto/slow //a bit faster
	)

//crossbow. damage++. the brush gun of bows.
/obj/item/gun/ballistic/bow/crossbow
	name = "crossbow"
	desc = "A large crossbow with a heavy draw, for maximum killing power."
	icon_state = "crossbow"
	item_state = "crossbow"
	trigger_guard = TRIGGER_GUARD_NONE
	weapon_class = WEAPON_CLASS_RIFLE
	damage_multiplier = GUN_EXTRA_DAMAGE_T5 //60 damage, brush gun power level
	init_firemodes = list(
			/datum/firemode/semi_auto/slower
	)
	can_scope = TRUE //?

//tier 4 legendary bow, either boss tier or unique tier, unsure just yet
//modern compound bow. speed++, damage++. the ultimate bow
/obj/item/gun/ballistic/bow/compoundbow
	name = "prewar compound bow"
	desc = "A rare, functional prewar bow, with a complex system of pullies that allow for a much stronger draw, with much less effort, than most hand crafted bows can provide. Alt click to attach to a quiver on your belt slot."
	icon_state = "pipebow"
	item_state = "bow"
	weapon_class = WEAPON_CLASS_RIFLE
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_firemodes = list(
			/datum/firemode/semi_auto
	)

// Special bows?
/* maybe at some point
/obj/item/gun/ballistic/bow/gold
	name = "golden bow"
	desc = "A firm sturdy golden bow created by the earth, its smooth metal and strong grip allows for swift firing rates."
	icon_state = "goldbow"
	item_state = "goldbow"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BACK
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_firemodes = list(
			/datum/firemode/semi_auto/slow
	)
*/
/* old bows, stinky, like fenny
/obj/item/gun/ballistic/bow/xbow
	name = "magazine-fed crossbow"
	desc = "A somewhat primitive projectile weapon. Has a spring-loaded magazine, but still requires drawing back before firing. Fires arrows slightly faster than regular bows, improving damage"
	icon_state = "xbow"
	item_state = "xbow"
	trigger_guard = TRIGGER_GUARD_NONE
	zoom_factor = 1
	mag_type = /obj/item/ammo_box/magazine/internal/bow/xbow
	extra_speed = 400


//Regular Bow
/obj/item/gun/ballistic/bow/tribal
	name = "short bow"
	desc = "A simple wooden bow with small pieces of turquiose, cheaply made and small enough to fit most bags, better then nothing I guess."
	icon_state = "tribalbow"
	item_state = "tribalbow"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10


//Bone Bow
/obj/item/gun/ballistic/bow/claw
	name = "deathclaw bow"
	desc = "A bone bow, made of pieces of sinew and deathclaw skin for extra structure, it is a fierce weapon that all expert hunters and bowmen carry, allowing for ease of firing many arrows."
	icon_state = "ashenbow"
	item_state = "ashenbow"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/internal/bow/claw
	fire_delay = 2
	extra_speed = 100

//Sturdy Bow
/obj/item/gun/ballistic/bow/sturdy
	name = "sturdy bow"
	desc = "A firm sturdy wooden bow with leather handles and sinew wrapping, for extra stopping power in the shot speed of the arrows."
	icon_state = "bow"
	force = 15
	mag_type = /obj/item/ammo_box/magazine/internal/bow/sturdy
	extra_speed = 300

//Silver Bow
/obj/item/gun/ballistic/bow/silver
	name = "silver bow"
	desc = "A firm sturdy silver bow created by the earth, its durability and rather strong material allow it to be an excellent option for those looking for the ability to fire more arrows than normally."
	icon_state = "pipebow"
	item_state = "pipebow"
	force = 15
	mag_type = /obj/item/ammo_box/magazine/internal/bow/silver
	fire_delay = 1.5

//Golden Bow
/obj/item/gun/ballistic/bow/gold
	name = "golden bow"
	desc = "A firm sturdy golden bow created by the earth, its smooth metal and strong grip allows for swift firing rates."
	icon_state = "goldbow"
	item_state = "goldbow"
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/bow/gold
	fire_delay = 1.5
	extra_speed = 100

//Crossbow
/obj/item/gun/ballistic/bow/crossbow
	name = "crossbow"
	desc = "A crossbow."
	icon_state = "crossbow"
	trigger_guard = TRIGGER_GUARD_NONE
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/bow/cross
	fire_delay = 1.5
	extra_speed = 400
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
*/
