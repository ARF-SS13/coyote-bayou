/* LIST STRUCTURELOADOUT_ROOT
 * list encodes "tag" = list(LOADOUT_BITFIELD = a bitfield, LOADOUT_CLASS = melee, LOADOUT_PATH = the path)
 */
#define LOADOUT_FLAG_WASTER (1<<0)
#define LOADOUT_FLAG_LAWMAN (1<<1)
#define LOADOUT_FLAG_PREMIUM (1<<2)
#define LOADOUT_FLAG_TRIBAL (1<<3)
#define LOADOUT_FLAG_PREACHER (1<<4)
#define LOADOUT_FLAG_TOOL_WASTER (1<<5)

#define LOADOUT_BITFIELD "loadout_bitfield"
#define LOADOUT_CLASS "loadout_class"
#define LOADOUT_PATH "loadout_path"

#define LOADOUT_CAT_PREMIUM "Fancy Weapons"
#define LOADOUT_CAT_LAWMAN "Law Weapons"
#define LOADOUT_CAT_MELEE_ONE "One Handed Melee"
#define LOADOUT_CAT_MELEE_TWO "Two Handed Melee"
#define LOADOUT_CAT_PISTOL "Pistols"
#define LOADOUT_CAT_REVOLVER "Revolvers"
#define LOADOUT_CAT_MAGIC "Magic"
#define LOADOUT_CAT_LONGGUN "Long Guns"
#define LOADOUT_CAT_HOBO "Improvised Guns"
#define LOADOUT_CAT_MUSKET "Blackpowder Guns"
#define LOADOUT_CAT_MISC "Misc Things"
#define LOADOUT_CAT_BOW "Bows"
#define LOADOUT_CAT_NULLROD "Spiritual Device"
#define LOADOUT_CAT_SHIELD "Shields"
#define LOADOUT_CAT_ENERGY "Energy Weapons"
#define LOADOUT_CAT_WORKER "Worker Tools"
#define LOADOUT_CAT_ADVENTURE "Adventure Tools"
#define LOADOUT_CAT_MEDICAL "Medical Tools"
#define LOADOUT_CAT_SINISTER "Sinister Tools"
#define LOADOUT_CAT_OTHER "Other Things"

#define LOADOUT_ROOT_ENTRIES list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO, LOADOUT_CAT_PISTOL, LOADOUT_CAT_REVOLVER, LOADOUT_CAT_MAGIC, LOADOUT_CAT_LONGGUN, LOADOUT_CAT_HOBO, LOADOUT_CAT_MISC, LOADOUT_CAT_BOW, LOADOUT_CAT_ENERGY, LOADOUT_CAT_NULLROD, LOADOUT_CAT_SHIELD, LOADOUT_FLAG_TOOL_WASTER, LOADOUT_CAT_MUSKET)
#define LOADOUT_ALL_ENTRIES list(LOADOUT_CAT_PREMIUM, LOADOUT_CAT_LAWMAN, LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO, LOADOUT_CAT_PISTOL, LOADOUT_CAT_REVOLVER, LOADOUT_CAT_MAGIC, LOADOUT_CAT_LONGGUN, LOADOUT_CAT_HOBO, LOADOUT_CAT_MISC, LOADOUT_CAT_BOW, LOADOUT_CAT_ENERGY, LOADOUT_CAT_NULLROD, LOADOUT_CAT_SHIELD, LOADOUT_CAT_WORKER, LOADOUT_CAT_ADVENTURE, LOADOUT_CAT_MEDICAL, LOADOUT_CAT_SINISTER, LOADOUT_CAT_OTHER, LOADOUT_CAT_MUSKET)

GLOBAL_LIST_EMPTY(loadout_datums)
GLOBAL_LIST_EMPTY(loadout_boxes)

/obj/item/kit_spawner
	name = "kit spawner!"
	desc = "Some kind of kit spawner!"
	icon = 'icons/obj/crates.dmi' //old weapon crate uses this. good enough for a gun case
	icon_state = "weaponcrate"
	item_state = "syringe_kit" //old weapon crate used this. I'm not familiar enough to know if there's something better
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi' //taken from briefcase code, should look okay for an inhand
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT
	/// these flags plus whatever's picked in the root menu = what we're allowed to spawn, easy peasy
	/// MUST be set
	var/allowed_flags
	/// What kits are inside this kit? If blank, just show a list of everything set to be allowed
	var/list/multiple_choice = list()
	/// One instance of this fuckin thing at a time. ONE. please
	var/in_use

/obj/item/kit_spawner/waster
	name = "Wasteland survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/raider
	name = "Rugged survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/raider/doctor
	name = "Rugged survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/raider/civvy
	name = "Rugged survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/raider/boss
	name = "Ruggedest survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM | LOADOUT_FLAG_TRIBAL
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/townie
	name = "Civilian survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/townie/doctor
	name = "Medical survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/townie/barkeep
	name = "Barkeep survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/townie/banker
	name = "Banker survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/townie/trader
	name = "Trader survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/townie/mayor
	name = "Mayoral survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/follower
	name = "Volunteer survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER

/obj/item/kit_spawner/follower/guard
	name = "Guard survival kit"
	desc = "Packed with the essentials: Some kind of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO)
	)

/obj/item/kit_spawner/follower/doctor
	name = "Doctor survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER

/obj/item/kit_spawner/follower/scientist
	name = "Science survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER

/obj/item/kit_spawner/follower/admin
	name = "Science survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/bos
	name = "Techy survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/bos/boss
	name = "Techy survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/bos/combat
	name = "Techy survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Combat" = list(LOADOUT_CAT_LAWMAN)
	)

/obj/item/kit_spawner/bos/scientist
	name = "Techy survival kit"
	desc = "Packed with the essentials: Some kind of cool weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Premium" = list(LOADOUT_CAT_PREMIUM)
	)

/obj/item/kit_spawner/preacher
	name = "Spiritual survival kit"
	desc = "Packed with the essentials: Some kind of weapon, and a cool holy stick."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL | LOADOUT_FLAG_PREACHER
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Rod" = list(LOADOUT_CAT_NULLROD)
	)

/obj/item/kit_spawner/lawman
	name = "Lawman equipment kit"
	desc = "Loaded with two sets of weapon."
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Lawman" = list(LOADOUT_CAT_LAWMAN)
	)

/obj/item/kit_spawner/lawman/sheriff
	name = "Sheriff equipment kit"
	desc = "Now with access to better things!"
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Lawman" = list(LOADOUT_CAT_LAWMAN)
	)

/obj/item/kit_spawner/premium
	name = "Premium equipment kit"
	desc = "Some of the fanciest guns known to the wastes!"
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_PREMIUM
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO)
	)

/obj/item/kit_spawner/tribal
	name = "Tribal equipment kit"
	desc = "Primitive equipment for a primitive person!"
	allowed_flags = LOADOUT_FLAG_TRIBAL
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO)
	)

/obj/item/kit_spawner/tribal/farlands
	name = "Farlands tribal equipment kit"
	desc = "Primitive equipment for a primitive person!"
	allowed_flags = LOADOUT_FLAG_TRIBAL | LOADOUT_FLAG_WASTER
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO)
	)

/obj/item/kit_spawner/debug_waster
	name = "waster kit spawner!"
	desc = "Some kind of kit spawner!"
	allowed_flags = LOADOUT_FLAG_WASTER
	multiple_choice = list(
		"Bepis Mk 1" = list(LOADOUT_CAT_MELEE_ONE, LOADOUT_CAT_MELEE_TWO),
		"hobo energy" = list(LOADOUT_CAT_HOBO, LOADOUT_CAT_ENERGY),
		"all of em" = LOADOUT_ROOT_ENTRIES
	)

/obj/item/kit_spawner/debug_waster_lawman
	name = "waster kit spawner!"
	desc = "Some kind of kit spawner!"
	/// these flags plus whatever's picked in the root menu = what we're allowed to spawn, easy peasy
	allowed_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN

/obj/item/kit_spawner/debug_tribal
	name = "waster kit spawner!"
	desc = "Some kind of kit spawner!"
	/// these flags plus whatever's picked in the root menu = what we're allowed to spawn, easy peasy
	allowed_flags = LOADOUT_FLAG_TRIBAL

/obj/item/kit_spawner/Initialize()
	. = ..()
	build_loadout_list()
	build_output_list()

/obj/item/kit_spawner/proc/build_loadout_list()
	if(LAZYLEN(GLOB.loadout_datums))
		return
	for(var/some_box in subtypesof(/datum/loadout_box))
		var/datum/loadout_box/loadybox = some_box
		GLOB.loadout_datums[initial(loadybox.entry_tag)] = list(LOADOUT_BITFIELD = initial(loadybox.entry_flags), LOADOUT_CLASS = initial(loadybox.entry_class), LOADOUT_PATH = initial(loadybox.spawn_thing))

/obj/item/kit_spawner/proc/build_output_list()
	if(!LAZYLEN(GLOB.loadout_datums))
		build_loadout_list()
		return
	if(LAZYLEN(GLOB.loadout_boxes[type])) // already init'd!
		return
	var/list/list_of_stuff = list()
	for(var/loadya in LOADOUT_ALL_ENTRIES)
		var/list/list2add = list()
		for(var/loadies in GLOB.loadout_datums)
			if(GLOB.loadout_datums[loadies][LOADOUT_CLASS] == loadya && CHECK_BITFIELD(GLOB.loadout_datums[loadies][LOADOUT_BITFIELD], allowed_flags))
				list2add[loadies] = GLOB.loadout_datums[loadies][LOADOUT_PATH]
		if(LAZYLEN(list2add))
			if(!islist(list_of_stuff[loadya]))
				list_of_stuff[loadya] = list()
			list2add = sort_list(list2add)
			list_of_stuff[loadya] |= list2add
	if(LAZYLEN(list_of_stuff))
		GLOB.loadout_boxes[type] = list_of_stuff
		log_admin("[src] initialized successfully!")
	else
		message_admins(span_phobia("Hey Lagg, [src] didnt initialize right. The list is empty! point and laugh"))

/obj/item/kit_spawner/attack_self(mob/user)
	if(can_use_kit(user))
		INVOKE_ASYNC(src,PROC_REF(use_the_kit), user)
	else
		playsound(src, 'sound/machines/synth_no.ogg', 40, 1)

/obj/item/kit_spawner/proc/stop_using_the_kit(mob/user)
	in_use = FALSE

/obj/item/kit_spawner/proc/can_use_kit(mob/living/user)
	if(in_use)
		to_chat(user, span_alert("Hold your horses, you're still using this thing!"))
		return FALSE
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE

/obj/item/kit_spawner/proc/use_the_kit(mob/living/user)
	in_use = TRUE
	if(!LAZYLEN(GLOB.loadout_boxes[type]))
		build_output_list()
		if(!LAZYLEN(GLOB.loadout_boxes[type]))
			message_admins(span_phobia("Hey Lagg, [src] didnt set up its lists, like, at all. And cant!. The list is empty! point and laugh"))
	var/first_key
	var/list/first_list
	if(LAZYLEN(multiple_choice))
		first_key = input(user, "Pick a category!", "Pick a category!") as null|anything in multiple_choice
		if(!first_key)
			user.show_message(span_alert("Invalid selection!"))
			stop_using_the_kit(user)
			return
		if(!LAZYLEN(multiple_choice[first_key]))
			user.show_message(span_phobia("Whoever set up [src] didn't set up the multiple choice list right! there should be a list here, and there isnt one! this is a bug~"))
			stop_using_the_kit(user)
			return
		first_list = multiple_choice[first_key]
		// Filter out anything from the first list that isnt in the second list. & might work, were I cleverer
		for(var/in_it in first_list)
			if(!(in_it in GLOB.loadout_boxes[type]))
				first_list -= in_it
	else
		first_list = GLOB.loadout_boxes[type]
	var/one_only
	//first, show the player the root menu! ROOT is just a list of strings
	var/second_key
	if(LAZYLEN(first_list) > 1)
		second_key = input(user, "Pick a category!", "Pick a category!") as null|anything in first_list
	else
		for(var/choosething in first_list)
			if(choosething)
				second_key = choosething
		one_only = TRUE
	if(!second_key)
		user.show_message(span_alert("Invalid selection!"))
		stop_using_the_kit(user)
		return
	user.show_message("[second_key] selected!")
	/// now the actual gunweapon! entries are formatted as "thingname" = path
	var/final_key
	if(LAZYLEN(GLOB.loadout_boxes[type][second_key]) == 1 && one_only)
		for(var/choosethinge in GLOB.loadout_boxes[type][second_key])
			if(choosethinge)
				final_key = choosethinge
	else
		final_key = input(user, "Pick a weapon!", "Pick a weapon!") as null|anything in GLOB.loadout_boxes[type][second_key]
	if(!check_choice(GLOB.loadout_boxes[type][second_key][final_key]))
		user.show_message(span_alert("Invalid selection!"))
		stop_using_the_kit(user)
		return
	//user.show_message("[final_key] selected!")
	INVOKE_ASYNC(src,PROC_REF(spawn_the_thing), user, GLOB.loadout_boxes[type][second_key][final_key], first_key)

/obj/item/kit_spawner/proc/check_choice(choice_to_check)
	if(!choice_to_check)
		return FALSE
	if(!ispath(choice_to_check))
		return FALSE
	return TRUE

/obj/item/kit_spawner/proc/spawn_the_thing(mob/user, atom/the_thing, first_key)
	var/turf/spawn_here
	spawn_here = user ? get_turf(user) : get_turf(src)
	var/obj/item/new_thing = new the_thing(spawn_here)
	stop_using_the_kit(user)
	if(!istype(new_thing))
		user.show_message(span_alert("Couldn't get the thing out of the case. Try again?"))
		return
	user.show_message(span_green("You pull \a [new_thing.name] out of [src]."))
	user.put_in_hands(new_thing)
	if(first_key && (first_key in multiple_choice))
		multiple_choice[first_key] = null
		multiple_choice -= first_key
	if(LAZYLEN(multiple_choice) < 1)
		qdel(src)

/obj/item/storage/box/gun
	name = "weapon case"
	desc = "a sturdy case keeping your weapon of choice safe until you pop it open."
	icon = 'icons/obj/crates.dmi' //old weapon crate uses this. good enough for a gun case
	icon_state = "weaponcrate"
	item_state = "syringe_kit" //old weapon crate used this. I'm not familiar enough to know if there's something better
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi' //taken from briefcase code, should look okay for an inhand
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'
	component_type = /datum/component/storage/concrete/box

/obj/item/storage/box/gun/update_icon_state()
	if(contents.len == 0)
		qdel(src)

/obj/item/storage/box/gun/PostPopulateContents()
	for(var/obj/item/thing in contents)
		SEND_SIGNAL(thing, COMSIG_GUN_MAG_ADMIN_RELOAD) // no more empty clippazines

/// Guns for the LAWman
/obj/item/storage/box/gun/law
	name = "American 180 case" //it was meant to be a police rifle anyways~
	w_class = WEIGHT_CLASS_BULKY //most will be rifles

/obj/item/storage/box/gun/law/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/american180(src)
	new /obj/item/ammo_box/magazine/m22smg/empty(src) //you get a ton of ammo already
	new /obj/item/ammo_box/m22(src) //but just in case you get unlucky...

/obj/item/storage/box/gun/law/smg10mm
	name = "10mm smg case"

/obj/item/storage/box/gun/law/smg10mm/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/smg10mm(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/ext(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/law/commando
	name = "commando carbine case"

/obj/item/storage/box/gun/law/commando/PopulateContents()
	new /obj/item/gun/ballistic/automatic/delisle/commando(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/law/combat //luv u scryden
	name = "combat carbine case"

/obj/item/storage/box/gun/law/combat/PopulateContents()
	new /obj/item/gun/ballistic/automatic/combat(src)
	new /obj/item/ammo_box/magazine/tommygunm45/stick(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/law/service
	name = "service rifle case"

/obj/item/storage/box/gun/law/service/PopulateContents()
	new /obj/item/gun/ballistic/automatic/service(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/ammo_box/a556(src)

/obj/item/storage/box/gun/law/policerifle
	name = "police rifle case"

/obj/item/storage/box/gun/law/policerifle/PopulateContents()
	new /obj/item/gun/ballistic/automatic/marksman/policerifle(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/ammo_box/a556(src)

/obj/item/storage/box/gun/law/assault_carbine
	name = "assault carbine case" //police assault rifle is stronger, not sure which they should have

/obj/item/storage/box/gun/law/assault_carbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/assault_carbine(src)
	new /obj/item/ammo_box/magazine/m5mm(src)
	new /obj/item/ammo_box/m5mmbox(src)

/obj/item/storage/box/gun/law/mk23 //not a whole rifle, but a really good pistol if you track down your own rifle
	name = "Tactical MK-23 case"
	w_class = WEIGHT_CLASS_NORMAL //only normal sized law gun

/obj/item/storage/box/gun/law/mk23/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/mk23(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/law/trail
	name = "trail carbine case"

/obj/item/storage/box/gun/law/trail/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/trail(src)
	new /obj/item/ammo_box/tube/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/law/police
	name = "police shotgun case"

/obj/item/storage/box/gun/law/police/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/police(src)
	new /obj/item/ammo_box/shotgun/buck(src) //eeeevery flavor
	new /obj/item/ammo_box/shotgun/bean(src)
	new /obj/item/ammo_box/shotgun/rubber(src) //make sure these are okay

/obj/item/storage/box/gun/rifle/brushgun
	name = "brush gun case"

/obj/item/storage/box/gun/rifle/brushgun/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/brush(src)
	new /obj/item/ammo_box/c4570box(src)

/obj/item/storage/box/gun/rifle/junglecarbine
	name = "jungle carbine case"

/obj/item/storage/box/gun/rifle/junglecarbine/PopulateContents()
	new /obj/item/gun/ballistic/rifle/enfield/jungle(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/ammo_box/a308box(src)

/obj/item/storage/box/gun/rifle/smle
	name = "lee-enfield case"

/obj/item/storage/box/gun/rifle/smle/PopulateContents()
	new /obj/item/gun/ballistic/rifle/enfield(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/ammo_box/a308box(src)

/obj/item/storage/box/gun/aer9
	name = "laser rifle case"

/obj/item/storage/box/gun/aer9/PopulateContents()
	new /obj/item/gun/energy/laser/aer9(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)
	new /obj/item/stock_parts/cell/ammo/mfc(src)

/// Premium guns!

/obj/item/storage/box/gun/premium/maria //fancier guns, for high rank roles
	name = "Maria case" //maria might not should be allowed, cause meant to be unique, but will see
	w_class = WEIGHT_CLASS_NORMAL //all neat and tidy pistols

/obj/item/storage/box/gun/premium/maria/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/maria(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/premium/automatic //beretta m93r, but keeping the naming scheme I got
	name = "Beretta M93R case" //might be stronk, might need to not take greasegun mags, will see

/obj/item/storage/box/gun/premium/automatic/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/beretta/automatic(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/premium/executive //good to be here till we get the vault back
	name = "the Executive case"

/obj/item/storage/box/gun/premium/executive/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/executive(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/premium/crusader
	name = "Crusader pistol case"

/obj/item/storage/box/gun/premium/crusader/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/crusader(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/premium/sig //can downgrade to whatever the trusty sig p220 is for. it has slightly lower fire rate
	name = "Sig P220 case"

/obj/item/storage/box/gun/premium/sig/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/sig(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/premium/custom
	name = "M1911 Custom case"

/obj/item/storage/box/gun/premium/custom/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/custom(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/c45(src)

//mk23 and magnum semi-autos are just a liiiiittle too chonky for this list

/obj/item/storage/box/gun/premium/mateba //ugh, fiiiiiiiine you can have your dumb coolness revolver, if you're the right rank~
	name = "Unica 6 case"

/obj/item/storage/box/gun/premium/mateba/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357/mateba(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357box(src)
	new /obj/item/ammo_box/a357/ratshot(src)

/obj/item/storage/box/gun/premium/lucky //not sure if this should be allowed, or if is supposed to be unique
	name = ".357 magnum revolver case"

/obj/item/storage/box/gun/premium/lucky/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357/lucky(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357box(src)
	new /obj/item/ammo_box/a357/ratshot(src)

/obj/item/storage/box/gun/premium/alt //pearly .44 mag
	name = "pearl .44 magnum case"

/obj/item/storage/box/gun/premium/alt/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/premium/peacekeeper
	name = "Peacekeeper case"

/obj/item/storage/box/gun/premium/peacekeeper/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/peacekeeper(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/premium/desert_ranger
	name = "ranger revolver case"

/obj/item/storage/box/gun/premium/desert_ranger/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver44/desert_ranger(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/// Long guns

/obj/item/storage/box/gun/rifle
	name = "cowboy repeater case"
	w_class = WEIGHT_CLASS_BULKY //rifles beeg, no fit in backpack for later

/obj/item/storage/box/gun/rifle/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/cowboy(src)
	new /obj/item/ammo_box/tube/a357(src) //high capacity, only get one
	new /obj/item/ammo_box/a357box(src)
	new /obj/item/ammo_box/a357/ratshot(src)

/obj/item/storage/box/gun/rifle/hunting
	name = "hunting rifle case"

/obj/item/storage/box/gun/rifle/hunting/PopulateContents()
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/ammo_box/a3006(src)
	new /obj/item/ammo_box/a3006box(src)

/obj/item/storage/box/gun/rifle/minimosin
	name = "mini-mosin case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/rifle/minimosin/PopulateContents()
	new /obj/item/gun/ballistic/rifle/mosin/mini(src)
	new /obj/item/ammo_box/a22(src)
	new /obj/item/ammo_box/a22(src)
	new /obj/item/ammo_box/a22(src)
	new /obj/item/ammo_box/m22(src)


/obj/item/storage/box/gun/rifle/caravan_shotgun
	name = "caravan rifle case"

/obj/item/storage/box/gun/rifle/caravan_shotgun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/caravan_shotgun(src)
	//new /obj/item/ammo_box/shotgun/buck(src) //lots of shotshells, just one box
	new /obj/item/ammo_box/c4570box(src)
	new /obj/item/ammo_box/c4570/ratshot(src)

/obj/item/storage/box/gun/rifle/widowmaker
	name = "Winchester Widowmaker case"

/obj/item/storage/box/gun/rifle/widowmaker/PopulateContents()
	new /obj/item/gun/ballistic/revolver/widowmaker(src)
	new /obj/item/ammo_box/shotgun/buck(src)

/obj/item/storage/box/gun/rifle/gras
	name = "Gras Rifle"

/obj/item/storage/box/gun/rifle/gras/PopulateContents()
	new /obj/item/gun/ballistic/rifle/antique/gras (src)
	new /obj/item/ammo_box/a3006box(src)

/obj/item/storage/box/gun/rifle/smg22
	name = ".22 Uzi case"

/obj/item/storage/box/gun/rifle/smg22/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22(src)
	new /obj/item/ammo_box/magazine/m22/extended(src)
	new /obj/item/ammo_box/m22(src)

/obj/item/storage/box/gun/rifle/rockwell
	name = "9mm Rockwell SMG case"

/obj/item/storage/box/gun/rifle/rockwell/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell(src)
	new /obj/item/ammo_box/magazine/uzim9mm/rockwell(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/rifle/sidewinder //should this be allowed? not field tested personally
	name = "multi-caliber carbine case"

/obj/item/storage/box/gun/rifle/sidewinder/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/sidewinder/worn(src)
	new /obj/item/ammo_box/magazine/m22(src) //you asked for multicaliber, you get multiple calibers
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/m22(src)

/obj/item/storage/box/gun/rifle/sidewinder_magnum //should this be allowed? not field tested personally
	name = "multi-caliber magnum case"

/obj/item/storage/box/gun/rifle/sidewinder_magnum/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/sidewinder/magnum(src)
	new /obj/item/ammo_box/magazine/m45(src) //you asked for multicaliber, you get multiple calibers
	new /obj/item/ammo_box/magazine/m44(src)
	new /obj/item/ammo_box/magazine/m14mm(src)

/obj/item/storage/box/gun/rifle/m1carbine
	name = "M1 carbine case"

/obj/item/storage/box/gun/rifle/m1carbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/m1carbine(src)
	new /obj/item/ammo_box/magazine/m10mm/adv(src) //why can't 10mm magazines be normal? make sure these aren't extended or broken
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/pistol/covpistole
	name = "EG-2A7 Pistol case"

/obj/item/storage/box/gun/pistol/covpistole/PopulateContents()
	new /obj/item/gun/energy/laser/plasma/covpistol(src)

/obj/item/storage/box/gun/rifle/delisle
	name = "De Lisle carbine case"

/obj/item/storage/box/gun/rifle/delisle/PopulateContents()
	new /obj/item/gun/ballistic/automatic/delisle(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/rifle/carbine9mm
	name = "9mm carbine case"

/obj/item/storage/box/gun/rifle/carbine9mm/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/beretta/carbine(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/rifle/sportcarbine
	name = "sport carbine case"

/obj/item/storage/box/gun/rifle/sportcarbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sportcarbine(src)
	new /obj/item/ammo_box/magazine/m22/extended(src) //high cap, just one
	new /obj/item/ammo_box/m22(src)

/obj/item/storage/box/gun/rifle/varmint
	name = "varmint rifle case"

/obj/item/storage/box/gun/rifle/varmint/PopulateContents()
	new /obj/item/gun/ballistic/automatic/varmint(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src) //no extendeds for you till you find em
	new /obj/item/ammo_box/a556(src)

/obj/item/storage/box/gun/rifle/trainer
	name = "training repeater case"

/obj/item/storage/box/gun/rifle/trainer/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/trainer(src)
	new /obj/item/ammo_box/m22(src)

/// MELEE
//gunmelee
/obj/item/storage/box/gun/melee //hopefully a decent variety. someone with more expertise expand on this. maybe split between one and two handed
	name = "scrap sabre case" //stronk, but currently a roundstart. we shall see
	w_class = WEIGHT_CLASS_NORMAL //some are bulky

/obj/item/storage/box/gun/melee/PopulateContents()
	new /obj/item/melee/onehanded/machete/scrapsabre(src)

/obj/item/storage/box/gun/melee/celestia
	name = "Plasma Slicer Celestia"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/melee/celestia/PopulateContents()
	new /obj/item/melee/transforming/plasmacutter/regular/celestia(src)

/obj/item/storage/box/gun/melee/energykatana
	name = "Energy Katana"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/melee/energykatana/PopulateContents()
	new	/obj/item/melee/transforming/plasmacutter/regular/energykatana(src)

/obj/item/storage/box/gun/melee/eve
	name = "Plasma Slicer Eve"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/melee/eve/PopulateContents()
	new /obj/item/melee/transforming/plasmacutter/regular/eve(src)

/obj/item/storage/box/gun/melee/plasma
	name = "Plasma Slicer"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/melee/PopulateContents()
	new /obj/item/melee/transforming/plasmacutter/regular(src)

/obj/item/storage/box/gun/melee/bowie //that's not a knife, this is a knife.
	name = "bowie knife case" //not as strong as a scrap sabre, but a good weapon to slip in boot

/obj/item/storage/box/gun/melee/bowie/PopulateContents()
	new /obj/item/melee/onehanded/knife/bowie(src)

/obj/item/storage/box/gun/melee/switchblade
	name = "switchblade case"

/obj/item/storage/box/gun/melee/switchblade/PopulateContents()
	new /obj/item/melee/onehanded/knife/switchblade(src)

/datum/loadout_box/boomerang
	entry_tag = "Boomerang"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/f13onehanded/boomerang

/obj/item/storage/box/gun/melee/throwing
	name = "throwing knife case"

/obj/item/storage/box/gun/melee/throwing/PopulateContents()
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src)
	new /obj/item/melee/onehanded/knife/throwing(src) //go have fun~

/obj/item/storage/box/gun/melee/brass //roundstart unarmed bb
	name = "brass knuckles case" //what? you don't keep your brass knuckles ina gun case?

/obj/item/storage/box/gun/melee/brass/PopulateContents()
	new /obj/item/melee/unarmed/brass(src)

/obj/item/storage/box/gun/melee/fryingpan //because YES
	name = "frying pan case" //a deadly weapon, keep it in its case

/obj/item/storage/box/gun/melee/fryingpan/PopulateContents()
	new /obj/item/melee/onehanded/club/fryingpan(src)

/obj/item/storage/box/gun/melee/scrapspear //pretty scrappy
	name = "scrap spear case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/scrapspear/PopulateContents()
	new /obj/item/twohanded/spear/scrapspear(src)

/obj/item/storage/box/gun/melee/baseball
	name = "baseball bat case"

/obj/item/storage/box/gun/melee/baseball/PopulateContents()
	new /obj/item/twohanded/baseball(src)

/*
/obj/item/storage/box/gun/melee/sledgehammer
	name = "sledgehammer case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/sledgehammer/PopulateContents()
	new /obj/item/twohanded/sledgehammer/simple(src)

/obj/item/storage/box/gun/melee/fireaxe
	name = "fire axe case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/fireaxe/PopulateContents()
	new /obj/item/twohanded/fireaxe(src)
*/

/obj/item/storage/box/gun/melee/pitchfork
	name = "pitchfork case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/pitchfork/PopulateContents()
	new /obj/item/pitchfork(src)

/*
/obj/item/storage/box/gun/melee/chainsaw
	name = "chainsaw case"
	w_class = WEIGHT_CLASS_BULKY
*/

/obj/item/storage/box/gun/melee/chainsaw/PopulateContents()
	new /obj/item/twohanded/chainsaw(src)

/obj/item/storage/box/gun/melee/fist_of_the_swampstar
	name = "bands of the swampstar case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/fist_of_the_swampstar/PopulateContents()
	new /obj/item/clothing/gloves/fingerless/pugilist/rapid(src)

/obj/item/storage/box/gun/melee/militarypolice
	name = "baton case"

/obj/item/storage/box/gun/melee/militarypolice/PopulateContents()
	new /obj/item/melee/classic_baton/militarypolice(src)

/obj/item/storage/box/gun/melee/raging_boar
	name = "raging boar case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/raging_boar/PopulateContents()
	new /obj/item/book/granter/martial/raging_boar(src)

/obj/item/storage/box/gun/melee/sleeping_carp
	name = "sleeping carp case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/sleeping_carp/PopulateContents()
	new /obj/item/book/granter/martial/carp(src)

/obj/item/storage/box/gun/melee/oldclaymore/PopulateContents()
	new /obj/item/melee/coyote/oldclaymore(src)

/obj/item/storage/box/gun/melee/harpoon/PopulateContents()
	new /obj/item/melee/coyote/harpoon(src)

/obj/item/storage/box/gun/melee/katanaold/PopulateContents()
	new /obj/item/melee/coyote/katanaold(src)

/obj/item/storage/box/gun/melee/wakazashiold/PopulateContents()
	new /obj/item/melee/coyote/wakazashiold(src)

/obj/item/storage/box/gun/melee/tantoold/PopulateContents()
	new /obj/item/melee/coyote/tantoold(src)

/obj/item/storage/box/gun/melee/combataxe/PopulateContents()
	new /obj/item/melee/coyote/combataxe(src)

/obj/item/storage/box/gun/melee/smallsword/PopulateContents()
	new /obj/item/melee/coyote/smallsword(src)

/obj/item/storage/box/gun/melee/oldcutlass/PopulateContents()
	new /obj/item/melee/coyote/oldcutlass(src)

/obj/item/storage/box/gun/melee/crudeblade/PopulateContents()
	new /obj/item/melee/coyote/crudeblade(src)

/*
/obj/item/storage/box/gun/melee/oldkanobo/PopulateContents()
	new /obj/item/melee/coyote/oldkanobo(src)

/obj/item/storage/box/gun/melee/mauler/PopulateContents()
	new /obj/item/melee/coyote/mauler(src)
*/

/obj/item/storage/box/gun/melee/club/PopulateContents()
	new /obj/item/melee/coyote/club(src)

/obj/item/storage/box/gun/melee/bigclub/PopulateContents()
	new /obj/item/melee/coyote/bigclub(src)

/obj/item/storage/box/gun/melee/oldlongsword/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword(src)

/obj/item/storage/box/gun/melee/oldhalberd/PopulateContents()
	new /obj/item/melee/coyote/oldhalberd(src)

/obj/item/storage/box/gun/melee/oldquarterstaff/PopulateContents()
	new /obj/item/melee/classic_baton/coyote/oldquarterstaff(src)

/obj/item/storage/box/gun/melee/olddervish/PopulateContents()
	new /obj/item/melee/coyote/olddervish(src)

/obj/item/storage/box/gun/melee/oldpike/sarissa/PopulateContents()
	new /obj/item/melee/coyote/oldpike/sarissa(src)

/obj/item/storage/box/gun/melee/oldlongsword/spadroon/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword/spadroon(src)

/obj/item/storage/box/gun/melee/oldlongsword/broadsword/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword/broadsword(src)

/obj/item/storage/box/gun/melee/oldlongsword/armingsword/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword/armingsword(src)

/obj/item/storage/box/gun/melee/oldlongsword/longquan/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword/longquan(src)

/obj/item/storage/box/gun/melee/oldlongsword/xiphos/PopulateContents()
	new /obj/item/melee/coyote/oldlongsword/xiphos(src)

/obj/item/storage/box/gun/melee/oldpike/PopulateContents()
	new /obj/item/melee/coyote/oldpike(src)

/obj/item/storage/box/gun/melee/oldnaginata/PopulateContents()
	new /obj/item/melee/coyote/oldnaginata(src)

/obj/item/storage/box/gun/melee/oldashandarei/PopulateContents()
	new /obj/item/melee/coyote/oldashandarei(src)

/obj/item/storage/box/gun/melee/macuahuitl/PopulateContents()
	new /obj/item/melee/coyote/macuahuitl(src)

/obj/item/storage/box/gun/melee/oldkhopesh/PopulateContents()
	new /obj/item/melee/coyote/oldkhopesh(src)

/// HOBO GUNS

/obj/item/storage/box/gun/hobo
	name = "hand shotgun case"
	w_class = WEIGHT_CLASS_NORMAL //will designate for each box since pipe guns vary in size

/obj/item/storage/box/gun/hobo/PopulateContents()
	new /obj/item/gun/ballistic/revolver/shotpistol(src)
	new /obj/item/ammo_box/shotgun/buck(src)

/obj/item/storage/box/gun/hobo/zipgun
	name = "Zip gun case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/hobo/zipgun/PopulateContents()
	new /obj/item/gun/ballistic/automatic/hobo/zipgun(src)
	new /obj/item/ammo_box/magazine/zipgun(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/hobo/piperifle
	name = "pipe rifle case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/piperifle/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/piperifle(src)
	new /obj/item/ammo_box/a556/improvised(src) //it's like a box but smaller

/obj/item/storage/box/gun/hobo/brick
	name = "brick launcher case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/brick/PopulateContents()
	new /obj/item/gun/ballistic/revolver/brick(src)

/obj/item/storage/box/gun/hobo/pepperbox
	name = "pepperbox gun case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/pepperbox/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/pepperbox(src)
	new /obj/item/ammo_box/l10mm(src) //no idea wtf this is for originally but it'll do
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/hobo/single_shotgun
	name = "shotgun bat case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/hobo/single_shotgun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/single_shotgun(src)
	new /obj/item/ammo_box/shotgun/buck(src)

/obj/item/storage/box/gun/hobo/knifegun
	name = "knife gun case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/hobo/knifegun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/knifegun(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/hobo/knucklegun
	name = "knucklegun case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/hobo/knucklegun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/knucklegun(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/hobo/winchesterrebored
	name = "rebored Winchester case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/winchesterrebored/PopulateContents()
	new /obj/item/gun/ballistic/revolver/winchesterrebored(src)
	new /obj/item/ammo_box/a308box(src) //it's like a box but smaller

/// revolvers!

/obj/item/storage/box/gun/revolver
	name = ".22LR Revolver case"
	w_class = WEIGHT_CLASS_NORMAL //revolvers aren't bulky

/obj/item/storage/box/gun/revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective(src)
	new /obj/item/ammo_box/m22(src)
	new /obj/item/ammo_box/c22(src)

/obj/item/storage/box/gun/revolver/derringer22
	name = ".22LR Derringer case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/revolver/derringer22/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective/derringer(src)
	new /obj/item/ammo_box/m22(src)
	new /obj/item/ammo_box/c22(src)

/obj/item/storage/box/gun/revolver/revolver45
	name = ".45 ACP revolver case"

/obj/item/storage/box/gun/revolver/revolver45/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver45(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/revolver/derringerLC
	name = ".45 LC Derringer case"

/obj/item/storage/box/gun/revolver/derringerLC/PopulateContents()
	new /obj/item/gun/ballistic/revolver/derringerLC(src)
	new /obj/item/ammo_box/a45lcbox(src)

/obj/item/storage/box/gun/revolver/derringer4570
	name = ".45-70 Derringer case"

/obj/item/storage/box/gun/revolver/derringer4570/PopulateContents()
	new /obj/item/gun/ballistic/revolver/derringer4570(src)
	new /obj/item/ammo_box/c4570box(src)
	new /obj/item/ammo_box/c4570/ratshot(src)

/datum/loadout_box/medusa
	entry_tag = "Medusa Revolver"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/medusa

/obj/item/storage/box/gun/revolver/medusa/PopulateContents()
	new /obj/item/gun/ballistic/revolver/medusa(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/datum/loadout_box/hermes
	entry_tag = "Hermes Revolver"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/hermes

/obj/item/storage/box/gun/revolver/hermes/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hermes(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/revolver/colt357
	name = ".357 magnum revolver case" //what does \improper mean, is needed here?

/obj/item/storage/box/gun/revolver/colt357/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357box(src)
	new /obj/item/ammo_box/a357/ratshot(src)

/obj/item/storage/box/gun/revolver/police
	name = "police revolver case"

/obj/item/storage/box/gun/revolver/police/PopulateContents()
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357box(src)
	new /obj/item/ammo_box/a357/ratshot(src)

/obj/item/storage/box/gun/revolver/m29
	name = ".44 magnum revolver case"

/obj/item/storage/box/gun/revolver/m29/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/revolver/m29snub
	name = "snubnose .44 magnum case"

/obj/item/storage/box/gun/revolver/m29snub/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/snub(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/revolver/revolver44
	name = ".44 magnum single-action case"

/obj/item/storage/box/gun/revolver/revolver44/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/revolver/thatgun
	name = ".308 pistol case"

/obj/item/storage/box/gun/revolver/thatgun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/thatgun(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/ammo_box/a308box(src)

/obj/item/storage/box/gun/revolver/rev47
	name = "4.7mm caseless revolver case"

/obj/item/storage/box/gun/revolver/rev47/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver47mm(src)
	new /obj/item/ammo_box/m473(src)

/obj/item/storage/box/gun/revolver/rev5
	name = "5mm revolver case"

/obj/item/storage/box/gun/revolver/rev5/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver5mm(src)
	new /obj/item/ammo_box/m5mmbox(src)

/obj/item/storage/box/gun/pistol/pistol47
	name = "4.7mm pistol case"

/obj/item/storage/box/gun/pistol/pistol47/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/pistol47mm(src)
	new /obj/item/ammo_box/m473(src)
	new /obj/item/ammo_box/magazine/m47pistol(src)

/// Semiauto pistols!

/obj/item/storage/box/gun/pistol
	name = ".22 pistol case"
	w_class = WEIGHT_CLASS_NORMAL //pistols aren't bulky

/obj/item/storage/box/gun/pistol/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/pistol22(src)
	new /obj/item/ammo_box/magazine/m22(src)
	new /obj/item/ammo_box/m22(src)

/obj/item/storage/box/gun/pistol/tec22
	name = ".22 machine pistol case"

/obj/item/storage/box/gun/pistol/tec22/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22(src)
	new /obj/item/ammo_box/magazine/m22(src)
	new /obj/item/ammo_box/m22(src)

/obj/item/storage/box/gun/pistol/ninemil
	name = "Browning Hi-power case"

/obj/item/storage/box/gun/pistol/ninemil/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)


/obj/item/storage/box/gun/pistol/glock
	name = "Glock pistol case"

/obj/item/storage/box/gun/pistol/glock/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/glock(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/m3pistolcivillian
	name = "M3 Civilian Magnum case"

/obj/item/storage/box/gun/pistol/m3pistolcivillian/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/m3civ(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/maky
	name = "9mm Makarov pistol case"

/obj/item/storage/box/gun/pistol/maky/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/makarov(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/rifle/covcarbinesgobrr
	name = "T25 rifle case"

/obj/item/storage/box/gun/rifle/covcarbinesgobrr/PopulateContents()
	new /obj/item/gun/ballistic/automatic/m1carbine/covcarbine(src)
	new /obj/item/ammo_box/magazine/m10mm/adv(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/pistol/m3socom
	name = "M3 Special pistol case"

/obj/item/storage/box/gun/pistol/m3socom/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/custom/m6socom (src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/c45(src)

/obj/item/storage/box/gun/pistol/m3pistol
	name = "M3 Magnum case"

/obj/item/storage/box/gun/pistol/m3pistol/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/automag/m6(src)
	new /obj/item/ammo_box/magazine/m44/automag(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/pistol/fourtyfourpistol
	name = "Desert Eagle case"

/obj/item/storage/box/gun/pistol/fourtyfourpistol/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/deagle(src)
	new /obj/item/ammo_box/magazine/m44/automag(src)
	new /obj/item/ammo_box/m44box(src)

/obj/item/storage/box/gun/pistol/automagcasing
	name = "Automag .44 case"

/obj/item/storage/box/gun/pistol/automagcasing/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/automag(src)
	new /obj/item/ammo_box/magazine/m44/automag(src)
	new /obj/item/ammo_box/m44box(src)



/obj/item/storage/box/gun/pistol/taurpistol
	name = "Judge pistol case"

/obj/item/storage/box/gun/pistol/taurpistol/PopulateContents()
	new /obj/item/gun/ballistic/revolver/taurjudge(src)
	new /obj/item/ammo_box/shotgun/buck(src)

/obj/item/storage/box/gun/rifle/shottybotty
	name = "S163 Shotgun case"

/obj/item/storage/box/gun/rifle/shottybotty/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/s163(src)
	new /obj/item/ammo_box/shotgun/buck(src)


/obj/item/storage/box/gun/rifle/foomas
	name = "Famas Rifle case"

/obj/item/storage/box/gun/rifle/foomas/PopulateContents()
	new /obj/item/gun/ballistic/automatic/famas(src)
	new /obj/item/ammo_box/a556(src)

/obj/item/storage/box/gun/rifle/svdgobrr
	name = "Z34 Rifle case"

/obj/item/storage/box/gun/rifle/svdgobrr/PopulateContents()
	new /obj/item/gun/ballistic/automatic/z34rifle(src)
	new /obj/item/ammo_box/a308box(src)

/obj/item/storage/box/gun/pistol/volcanics
	name = "Volcanic pistol case"

/obj/item/storage/box/gun/pistol/volcanics/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/volcanic(src)
	new /obj/item/ammo_box/c45(src)


/obj/item/storage/box/gun/pistol/cyberpunks
	name = "P-36 pistol case"

/obj/item/storage/box/gun/pistol/cyberpunks/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ticon(src)
	new /obj/item/ammo_box/m14mm(src)
	new /obj/item/ammo_box/magazine/m14mmcustom(src)

/obj/item/storage/box/gun/pistol/needler
	name = "NP-149/40 pistol case"

/obj/item/storage/box/gun/pistol/needler/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/needlerpistol(src)
	new /obj/item/ammo_box/needlercapsule/handloaded(src)


/obj/item/storage/box/gun/pistol/nineshotrevolver
	name = "LeMat revolver case"

/obj/item/storage/box/gun/pistol/nineshotrevolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/Lemat(src)
	new /obj/item/ammo_box/c9mm(src)


/obj/item/storage/box/gun/pistol/auto9mm
	name = "9mm Autopistol case"

/obj/item/storage/box/gun/pistol/auto9mm/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/auto(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/borchardt
	name = "9mm Borchardt case"

/obj/item/storage/box/gun/pistol/borchardt/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/c93(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/luger
	name = "9mm Luger case"

/obj/item/storage/box/gun/pistol/luger/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/ruby/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil/ruby(src)
	new /obj/item/ammo_box/magazine/m9mm(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/beretta
	name = "Beretta M9FS case"

/obj/item/storage/box/gun/pistol/beretta/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/c9mm(src)

/obj/item/storage/box/gun/pistol/n99
	name = "10mm pistol case"

/obj/item/storage/box/gun/pistol/n99/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/rifle/maus71
	name = "Mauser 71 rifle case"

/obj/item/storage/box/gun/rifle/maus71/PopulateContents()
	new /obj/item/gun/ballistic/rifle/mauserrifle(src)
	new /obj/item/ammo_box/a50MGbox(src)

/obj/item/storage/box/gun/rifle/gew88
	name = "Gewehr 88 rifle case"

/obj/item/storage/box/gun/rifle/gew88/PopulateContents()
	new /obj/item/gun/ballistic/rifle/gewehr88(src)
	new /obj/item/ammo_box/a3006box(src)

/obj/item/storage/box/gun/pistol/flintlock
	name = "flintlock pistol case"

/obj/item/storage/box/gun/pistol/flintlock/PopulateContents()
	new /obj/item/gun/flintlock(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musket
	name = "flintlock musket case"

/obj/item/storage/box/gun/rifle/musket/PopulateContents()
	new /obj/item/gun/flintlock/musket(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musketoon
	name = "flintlock musketoon case"

/obj/item/storage/box/gun/rifle/musketoon/PopulateContents()
	new /obj/item/gun/flintlock/musketoon(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/pistol/musketoon/spingarda
	name = "flintlock Spingarda case"

/obj/item/storage/box/gun/rifle/musketoon/spingarda/PopulateContents()
	new /obj/item/gun/flintlock/musketoon/spingarda(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musketoon/mosquete
	name = "flintlock Mosquete case"

/obj/item/storage/box/gun/rifle/musketoon/mosquete/PopulateContents()
	new /obj/item/gun/flintlock/musketoon/mosquete(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musket/tanegashima
	name = "tanegashima case"

/obj/item/storage/box/gun/rifle/musket/tanegashima/PopulateContents()
	new /obj/item/gun/flintlock/musket/tanegashima(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/jezail
	name = "jezail case"

/obj/item/storage/box/gun/rifle/jezail/PopulateContents()
	new /obj/item/gun/flintlock/musket/jezail(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/jezail/culverin
	name = "culverin case"

/obj/item/storage/box/gun/rifle/jezail/culverin/PopulateContents()
	new /obj/item/gun/flintlock/musket/jezail/culverin(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musket/flintlock/handcannon
	name = "hand cannon case"

/obj/item/storage/box/gun/matchlock/handcannon/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/handcannon(src)
	new /obj/item/ammo_box/flintlock(src)

//matchlocks


/obj/item/storage/box/gun/rifle/musket/matchlock/handcannon
	name = "handcannon case"

/obj/item/storage/box/gun/matchlock/handcannon/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/handcannon(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musket/matchlock/handgonne
	name = "handgonne case"

/obj/item/storage/box/gun/matchlock/handgonne/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/handcannon/handgonne(src)
	new /obj/item/ammo_box/flintlock(src)


/obj/item/storage/box/gun/rifle/musket/flintlock/matchlockarquebus
	name = "classy arquebus case"

/obj/item/storage/box/gun/rifle/flintlock/matchlockarquebus/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/matchlockarquebus(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/rifle/musket/matchlock/matchlockarquebus/arquebus
	name = "arquebus case"

/obj/item/storage/box/gun/rifle/matchlock/matchlockarquebus/arquebus/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/matchlockarquebus/arquebus(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/carbine/matchlock/musketoon
	name = "matchlock musketoon case"

/obj/item/storage/box/gun/carbine/matchlock/musketoon/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/musketoon(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/carbine/matchlock/musketoon/espi
	name = "matchlock espingole case"

/obj/item/storage/box/gun/carbine/matchlock/musketoon/espi/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/musketoon/espingole(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/carbine/matchlock/musketoon/carbine
	name = "matchlock carbine case"

/obj/item/storage/box/gun/carbine/matchlock/musketoon/carbine/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/musketoon/carabine(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/carbine/matchlock/cavalier
	name = "matchlock cavalier sharpshooter case"

/obj/item/storage/box/gun/carbine/matchlock/cavalier/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/cavalier(src)
	new /obj/item/ammo_box/flintlock(src)

/obj/item/storage/box/gun/carbine/matchlock/handbombard
	name = "matchlock handbombard case"

/obj/item/storage/box/gun/carbine/matchlock/handbombard/PopulateContents()
	new /obj/item/gun/flintlock/matchlock/handbombard(src)
	new /obj/item/ammo_box/flintlock(src)



/obj/item/storage/box/gun/pistol/type17
	name = "Type 17 case"

/obj/item/storage/box/gun/pistol/type17/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/type17(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/c10mm(src)

/obj/item/storage/box/gun/pistol/m1911 //muh three worldly whores
	name = "M1911 case"

/obj/item/storage/box/gun/pistol/m1911/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/c45(src)

/// Tribal!

/obj/item/storage/box/gun/tribal //not terribly versed in tribal stuff. someone can give this a bit more love than I
	name = "bone spear case"
	w_class = WEIGHT_CLASS_BULKY //a few are small

/obj/item/storage/box/gun/tribal/PopulateContents()
	new /obj/item/twohanded/spear/bonespear(src)

/obj/item/storage/box/gun/tribal/forgedmachete
	name = "machete case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/tribal/forgedmachete/PopulateContents()
	new /obj/item/melee/onehanded/machete/forgedmachete(src)

/obj/item/storage/box/gun/tribal/bmprsword
	name = "bumpersword case"

/obj/item/storage/box/gun/tribal/bmprsword/PopulateContents()
	new /obj/item/twohanded/fireaxe/bmprsword(src)

/obj/item/storage/box/gun/tribal/warmace
	name = "warmace case"

/obj/item/storage/box/gun/tribal/warmace/PopulateContents()
	new /obj/item/twohanded/sledgehammer/warmace(src)

/obj/item/storage/box/gun/tribal/spearquiver
	name = "spear quiver case"

/obj/item/storage/box/gun/tribal/spearquiver/PopulateContents()
	new /obj/item/storage/backpack/spearquiver(src)

/obj/item/storage/box/gun/bow/shortbow
	name = "shortbow case"

/obj/item/storage/box/gun/bow/shortbow/PopulateContents()
	new /obj/item/gun/ballistic/bow/shortbow(src)
	new /obj/item/storage/bag/tribe_quiver/light/full(src)

/obj/item/storage/box/gun/bow/longbow
	name = "longbow case"

/obj/item/storage/box/gun/bow/longbow/PopulateContents()
	new /obj/item/gun/ballistic/bow/longbow(src)
	new /obj/item/storage/bag/tribe_quiver/light/full(src)

/obj/item/storage/box/gun/tribal/warclub
	name = "war club case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/tribal/warclub/PopulateContents()
	new /obj/item/melee/onehanded/club/warclub(src)



/obj/item/storage/box/gun/tribal/boneaxe
	name = "bone axe case"

/obj/item/storage/box/gun/tribal/boneaxe/PopulateContents()
	new /obj/item/twohanded/fireaxe/boneaxe(src)

/// Preacher Stuff

/obj/item/storage/box/gun/preacher/nullrod
	name = "spriritual device case"

/obj/item/storage/box/gun/preacher/nullrod/PopulateContents()
	new /obj/item/nullrod(src)

/// ENERGY!

/obj/item/storage/box/gun/energy
	name = "compact rcw case"
	w_class = WEIGHT_CLASS_NORMAL //no roundstart laser rifles rn

/obj/item/storage/box/gun/energy/PopulateContents()
	new /obj/item/gun/energy/laser/auto/worn(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)

/obj/item/storage/box/gun/energy/plasma
	name = "plasma pistol case"

/obj/item/storage/box/gun/energy/plasma/PopulateContents()
	new /obj/item/gun/energy/laser/plasma/pistol/worn(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/obj/item/storage/box/gun/energy/stun
	name = "compliance regulator case"

/obj/item/storage/box/gun/energy/stun/PopulateContents()
	new /obj/item/gun/energy/laser/complianceregulator(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/obj/item/storage/box/gun/energy/compact_rcw
	name = "compact RCW case"

/obj/item/storage/box/gun/energy/compact_rcw/PopulateContents()
	new /obj/item/gun/energy/laser/auto(src)
	new /obj/item/stock_parts/cell/ammo/ecp(src)

/obj/item/storage/box/gun/energy/ccovrifle
	name = "PR-M1A2 rifle case"

/obj/item/storage/box/gun/energy/ccovrifle/PopulateContents()
	new /obj/item/gun/energy/laser/plasma/plasmacov(src)

/obj/item/storage/box/gun/energy/wattz1000
	name = "wattz 1000 case"

/obj/item/storage/box/gun/energy/wattz1000/PopulateContents()
	new /obj/item/gun/energy/laser/wattz(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/obj/item/storage/box/gun/energy/wornaep7
	name = "worn AEP-7 case"

/obj/item/storage/box/gun/energy/wornaep7/PopulateContents()
	new /obj/item/gun/energy/laser/pistol/worn(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)

/obj/item/choice_beacon/box/gun //template for sprites
	name = "weapon case"
	desc = "a sturdy case keeping your weapon of choice safe until you pop it open."
	icon = 'icons/obj/crates.dmi' //old weapon crate uses this. good enough for a gun case
	icon_state = "weaponcrate"
	item_state = "syringe_kit" //old weapon crate used this. I'm not familiar enough to know if there's something better
	lefthand_file = 'icons/mob/inhands/equipment/briefcase_lefthand.dmi' //taken from briefcase code, should look okay for an inhand
	righthand_file = 'icons/mob/inhands/equipment/briefcase_righthand.dmi'

//could use a click sound when opened instead of a tear?

/datum/loadout_box
	var/entry_tag
	var/entry_flags
	var/entry_class
	var/obj/item/spawn_thing

/// Energy Guns

/datum/loadout_box/energy
	entry_tag = "Compact RCW"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy

/datum/loadout_box/plasma
	entry_tag = "Plasma Pistol"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/energy/plasma

/datum/loadout_box/aer9
	entry_tag = "AER-9"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/aer9

/datum/loadout_box/aer92
	entry_tag = "AER-9"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/aer9

/datum/loadout_box/stun
	entry_tag = "Compliance Regulator"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/stun

/datum/loadout_box/compact_rcw
	entry_tag = "Compact RCW"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/compact_rcw

/datum/loadout_box/wattz1000
	entry_tag = "Wattz 1000"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/wattz1000

/datum/loadout_box/wornaep7
	entry_tag = "Worn AEP-7"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/wornaep7

/// Fancyguns

/datum/loadout_box/maria
	entry_tag = "Maria"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/maria

/datum/loadout_box/beretta_auto
	entry_tag = "Beretta M93R Burstfire"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/automatic

/datum/loadout_box/executive_10mm
	entry_tag = "The Executive 10mm pistol"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/executive

/datum/loadout_box/crusader
	entry_tag = "Crusader 10mm pistol"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/crusader

/datum/loadout_box/sig
	entry_tag = "Sig P220"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/sig

/datum/loadout_box/m1911_custom
	entry_tag = "M1911 Custom"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/custom

/datum/loadout_box/mateba
	entry_tag = "Unica 6"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/mateba

/datum/loadout_box/lucky
	entry_tag = "Lucky Revolver"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/lucky

/datum/loadout_box/alt
	entry_tag = "Pearl .44 Magnum"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/premium/alt

/datum/loadout_box/alt2
	entry_tag = "Pearl .44 Magnum"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/premium/alt

/datum/loadout_box/peacekeeper
	entry_tag = "Peacekeeper Magnum"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/premium/peacekeeper

/datum/loadout_box/desert_ranger
	entry_tag = "Desert Ranger Magnum"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/premium/desert_ranger

/// Lawman guns

/datum/loadout_box/american_180
	entry_tag = "American 180"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law

/datum/loadout_box/smg10mm
	entry_tag = "10mm SMG"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/smg10mm

/datum/loadout_box/commando
	entry_tag = "Commando Carbine"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/commando

/datum/loadout_box/combat
	entry_tag = "Combat Carbine"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/combat

/datum/loadout_box/service
	entry_tag = "Service Rifle"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/service

/datum/loadout_box/policerifle
	entry_tag = "Police Rifle"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/policerifle

/datum/loadout_box/assault_carbine
	entry_tag = "Assault Carbine"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/assault_carbine

/datum/loadout_box/mk23
	entry_tag = "Tactical MK-23"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/mk23

/// Long guns, mostly wasters

/datum/loadout_box/rifle
	entry_tag = "Cowboy Repeater"
	entry_flags = LOADOUT_FLAG_WASTER // frontier something something
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle

/datum/loadout_box/hunting
	entry_tag = "Hunting Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/hunting

/datum/loadout_box/minimosin
	entry_tag = "mini mosin"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/minimosin

/datum/loadout_box/caravan_shotgun
	entry_tag = "Caravan Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/caravan_shotgun

/datum/loadout_box/widowmaker
	entry_tag = "Widowmaker Shotgun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/widowmaker

/datum/loadout_box/smg22
	entry_tag = ".22 Uzi"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/smg22

/datum/loadout_box/rockwell
	entry_tag = "9mm Rockwell SMG"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/rockwell

/datum/loadout_box/gras
	entry_tag = "Gras Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/gras

/datum/loadout_box/sidewinder
	entry_tag = "Multicaliber Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/sidewinder

/datum/loadout_box/revolver47
	entry_tag = "4.7mm revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/rev47

/datum/loadout_box/revolver5
	entry_tag = "5mm revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/rev5

/datum/loadout_box/pistol47mmm
	entry_tag = "4.7mm caseless pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/pistol47

/* /datum/loadout_box/sidewinder_magnum
	entry_tag = "Multicaliber Magnum"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/sidewinder_magnum */

/datum/loadout_box/m1carbine
	entry_tag = "M1 Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/m1carbine

/datum/loadout_box/delisle
	entry_tag = "Delisle Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/delisle

/datum/loadout_box/mauser71gobrr
	entry_tag = "Mauser 71 Bolt action rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/maus71


/datum/loadout_box/gewehr88gobrr
	entry_tag = "Gewehr 88 Bolt action rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/gew88

/datum/loadout_box/carbine9mm
	entry_tag = "9mm Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/carbine9mm

/datum/loadout_box/sportcarbine
	entry_tag = "Sport Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/sportcarbine

/datum/loadout_box/varmint
	entry_tag = "Varmint Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/varmint

/datum/loadout_box/trainer
	entry_tag = "Training Repeater"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/trainer

/datum/loadout_box/trail
	entry_tag = "Trail Carbine"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/law/trail

/datum/loadout_box/flintlockmusket
	entry_tag = "Flintlock Musket"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket

/datum/loadout_box/tanegashima
	entry_tag = "Tanegashima Musket"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/tanegashima

/datum/loadout_box/flintlockmusketoon
	entry_tag = "Flintlock Musketoon"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musketoon

/datum/loadout_box/flintlockspingarda
	entry_tag = "Flintlock Spingarda"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musketoon/spingarda

/datum/loadout_box/flintlockmosquete
	entry_tag = "Flintlock Mosquete"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musketoon/mosquete

/datum/loadout_box/flintlockjezail
	entry_tag = "Jezail Long Rifle"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/jezail


/datum/loadout_box/flintlockculverin
	entry_tag = "Culverin"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/jezail/culverin

/datum/loadout_box/matchlock/handcannon
	entry_tag = "Matchlock Hand Cannon"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/matchlock/handcannon

/datum/loadout_box/matchlock/handgonne
	entry_tag = "Matchlock Handgonne"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/matchlock/handgonne

/datum/loadout_box/matchlock/classyarquebus
	entry_tag = "Matchlock Arquebus - Fancy"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/flintlock/matchlockarquebus

/datum/loadout_box/matchlock/normalarquebus
	entry_tag = "Matchlock Arquebus"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/matchlock/matchlockarquebus/arquebus

/datum/loadout_box/matchlock/musketoon
	entry_tag = "Matchlock Musketoon"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/carbine/matchlock/musketoon

/datum/loadout_box/matchlock/musketoon/espi
	entry_tag = "Matchlock espingole"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/carbine/matchlock/musketoon/espi

/datum/loadout_box/matchlock/musketoon/carbine
	entry_tag = "Matchlock Carbine"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/carbine/matchlock/musketoon/carbine


/datum/loadout_box/matchlock/cavalier
	entry_tag = "Matchlock Cavalier Sharpshooter"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/carbine/matchlock/cavalier

/datum/loadout_box/matchlock/handbombard
	entry_tag = "Matchlock Hand Bombard"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/carbine/matchlock/handbombard




/datum/loadout_box/matchlock/
	entry_tag = "Matchlock Handgonne"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/rifle/musket/matchlock/handgonne





/datum/loadout_box/junglecarbine
	entry_tag = "Jungle Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/junglecarbine

/datum/loadout_box/smle
	entry_tag = "Lee-Enfield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/smle

/// Hobo Guns

/datum/loadout_box/hand_shotgun
	entry_tag = "Hand Shotgun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo

/datum/loadout_box/zipgun
	entry_tag = "Zipgun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/zipgun

/datum/loadout_box/piperifle
	entry_tag = "Pipe Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/piperifle

/datum/loadout_box/brick
	entry_tag = "Brick Launcher"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/brick

/datum/loadout_box/pepperbox
	entry_tag = "Pepperbox"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/pepperbox

/datum/loadout_box/single_shotgun
	entry_tag = "Shotgun Bat"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/single_shotgun

/datum/loadout_box/knifegun
	entry_tag = "Knife Gun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/knifegun

/datum/loadout_box/knucklegun
	entry_tag = "Knuckle Gun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/knucklegun

/datum/loadout_box/winchesterrebored
	entry_tag = "Rebored Winchester"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/storage/box/gun/hobo/winchesterrebored

/// Revolvers!

/datum/loadout_box/detective
	entry_tag = ".22LR Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver

/datum/loadout_box/derringer22
	entry_tag = ".22LR Derringer"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/derringer22


/datum/loadout_box/revolver45
	entry_tag = ".45ACP Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/revolver45

/datum/loadout_box/derringerLC
	entry_tag = ".45 LC Derringer"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/derringerLC

/datum/loadout_box/derringer4570
	entry_tag = ".45-70 Derringer"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/derringer4570

/datum/loadout_box/colt357
	entry_tag = ".357 Magnum Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/colt357

/datum/loadout_box/police
	entry_tag = ".357 Snubnose Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/police

/datum/loadout_box/m29
	entry_tag = ".44 Magnum Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/m29

/datum/loadout_box/m29snub
	entry_tag = ".44 Snubnose Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/m29snub

/datum/loadout_box/revolver44
	entry_tag = ".44 Single-Action Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/revolver44

/datum/loadout_box/thatgun //thotgun
	entry_tag = ".308 Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/thatgun

/// Semi-auto pistols!

/datum/loadout_box/pistol
	entry_tag = ".22 Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol

/datum/loadout_box/tec22
	entry_tag = ".22 Machine Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/tec22

/datum/loadout_box/ninemil
	entry_tag = "Hi-Power Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/ninemil

/datum/loadout_box/auto9mm
	entry_tag = "9mm Autopistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/auto9mm

/datum/loadout_box/shotgunrevolver
	entry_tag = "judge shotgun revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/pistol/taurpistol


/datum/loadout_box/covenantcarbie
	entry_tag = "T25 carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/covcarbinesgobrr

/datum/loadout_box/shottygunny
	entry_tag = "S163 Shotgun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/shottybotty

/datum/loadout_box/covpistols
	entry_tag = "EG-2A7 Plasma Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/pistol/covpistole

/datum/loadout_box/makrov
	entry_tag = "9mm Makarov Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/maky

/datum/loadout_box/covrifles
	entry_tag = "PR-M1A2 Plasma Rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/ccovrifle

/datum/loadout_box/volcanicsgobrr
	entry_tag = "Volcanic Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/volcanics

/datum/loadout_box/needlergobrr
	entry_tag = "NP-149/40 Prototype Needler Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/needler

/datum/loadout_box/lematsgobrr
	entry_tag = "LeMat revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/pistol/nineshotrevolver

/datum/loadout_box/frenchassault
	entry_tag = "Famas rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/foomas

/datum/loadout_box/sovietsniper
	entry_tag = "Z34 battle rifle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/svdgobrr

/datum/loadout_box/automagbrr
	entry_tag = ".44 Automag"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/automagcasing


/datum/loadout_box/deaglebeagle
	entry_tag = ".44 Desert Eagle"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/fourtyfourpistol


/datum/loadout_box/halospecial
	entry_tag = "M3 SOCOM"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/m3socom



/datum/loadout_box/ninemilglock
	entry_tag = "9mm glock"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/glock

/datum/loadout_box/halonormal
	entry_tag = "M3 Magnum"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/m3pistol

/datum/loadout_box/haloninemil
	entry_tag = "M3 Civilian"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/m3pistolcivillian

/datum/loadout_box/militech
	entry_tag = "P-47 Assault Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/cyberpunks

/datum/loadout_box/borchardt
	entry_tag = "9mm Borchardt"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/borchardt

/datum/loadout_box/luger
	entry_tag = "9mm Luger"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/luger

/datum/loadout_box/ruby
	entry_tag = "9mm Bootgun"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/ruby

/datum/loadout_box/beretta
	entry_tag = "Beretta M9FS"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/beretta

/datum/loadout_box/n99
	entry_tag = "10mm Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/n99

/datum/loadout_box/flintlock
	entry_tag = "Flintlock Pistol"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MUSKET
	spawn_thing = /obj/item/storage/box/gun/pistol/flintlock

/datum/loadout_box/type17
	entry_tag = "10mm Type17 Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/type17

/datum/loadout_box/m1911
	entry_tag = ".45ACP Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/m1911

/// Melee!

/datum/loadout_box/melee
	entry_tag = "Scrap Sabre"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee

/datum/loadout_box/melee/celestia
	entry_tag = "Plasma Slicer Celestia"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/celestia

/datum/loadout_box/melee/eve
	entry_tag = "Plasma Slicer Eve"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/eve

/datum/loadout_box/melee/energykatana
	entry_tag = "Energy Katana"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/energykatana

/datum/loadout_box/melee/plasma
	entry_tag = "Plasma slicer"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/plasma

/datum/loadout_box/bowie
	entry_tag = "Bowie Knife"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/bowie

/datum/loadout_box/switchblade
	entry_tag = "Switchblade"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/switchblade

/datum/loadout_box/throwing
	entry_tag = "Throwing Knives"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/melee/throwing

/datum/loadout_box/brass
	entry_tag = "Brass Knuckles"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL | LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/storage/box/gun/melee/brass

/datum/loadout_box/fryingpan
	entry_tag = "Frying Pan"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/melee/fryingpan

/datum/loadout_box/scrapspear
	entry_tag = "Scrap Spear"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/scrapspear

/datum/loadout_box/baseball
	entry_tag = "Baseball Bat"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/baseball

/*
/datum/loadout_box/sledgehammer
	entry_tag = "Sledgehammer"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/sledgehammer

/datum/loadout_box/fireaxe
	entry_tag = "fire axe"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/fireaxe
*/

/datum/loadout_box/pitchfork
	entry_tag = "pitchfork"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/pitchfork

/*
/datum/loadout_box/chainsaw
	entry_tag = "Chainsaw"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/melee/chainsaw
*/

/datum/loadout_box/fist_of_the_swampstar // pornstar
	entry_tag = "Bands of the Swamp Star gloves"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/storage/box/gun/melee/fist_of_the_swampstar

/datum/loadout_box/raging_boar // YEET
	entry_tag = "Raging Boar Scroll"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/storage/box/gun/melee/raging_boar

/datum/loadout_box/sleeping_carp // Snippity Snap
	entry_tag = "Sleeping Carp Scroll"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/storage/box/gun/melee/sleeping_carp

/datum/loadout_box/oldclaymore //FOR SCOTLAND
	entry_tag = "Old Claymore"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldclaymore

/datum/loadout_box/harpoon //https://youtu.be/-UhrVpRCOYM ~TK
	entry_tag = "Harpoon"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/harpoon

/datum/loadout_box/katanaold
	entry_tag = "Old Katana"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/katanaold

/datum/loadout_box/wakazashiold
	entry_tag = "Old Wakazashi"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/wakazashiold

/datum/loadout_box/tantoold
	entry_tag = "Old Tanto"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/tantoold

/datum/loadout_box/combataxe
	entry_tag = "Combat Axe"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/combataxe

/datum/loadout_box/smallsword
	entry_tag = "Small Sword"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/smallsword

/datum/loadout_box/oldcutlass
	entry_tag = "Old Cutlass"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldcutlass


/datum/loadout_box/crudeblade
	entry_tag = "Crude Blade"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/crudeblade

/datum/loadout_box/mauler
	entry_tag = "Mauler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/mauler


/datum/loadout_box/club
	entry_tag = "Club"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/club

/datum/loadout_box/club/mace
	entry_tag = "Mace"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/club/mace


/datum/loadout_box/bigclub
	entry_tag = "Big Club"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/bigclub

/datum/loadout_box/oldlongsword
	entry_tag = "Old Longsword"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword

/datum/loadout_box/oldhalberd
	entry_tag = "Old Halberd"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldhalberd

/datum/loadout_box/oldpike
	entry_tag = "Old Pike"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldpike

/datum/loadout_box/oldnaginata
	entry_tag = "Old Naginata"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldnaginata

/datum/loadout_box/oldashandarei
	entry_tag = "Old Ashandarei"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldashandarei

/datum/loadout_box/oldkhopesh
	entry_tag = "Old Khopesh"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldkhopesh

/datum/loadout_box/oldkanobo
	entry_tag = "Old Kanobo"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldkanobo

/datum/loadout_box/macuahuitl
	entry_tag = "Macuahuitl"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/macuahuitl

/datum/loadout_box/militarypolice
	entry_tag = "Police Baton"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/melee/militarypolice

/// Tribal

/datum/loadout_box/tribal
	entry_tag = "Bone Spear"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/tribal

/datum/loadout_box/forgedmachete
	entry_tag = "Machete"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/tribal/forgedmachete

/*
/datum/loadout_box/bmprsword
	entry_tag = "Bumper Sword"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/tribal/bmprsword
*/

/datum/loadout_box/warmace
	entry_tag = "Warmace"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/tribal/warmace

/datum/loadout_box/spear_quiver
	entry_tag = "Spear Quiver"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/tribal/spearquiver

/datum/loadout_box/warclub
	entry_tag = "War Club"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/storage/box/gun/tribal/warclub

/datum/loadout_box/boneaxe
	entry_tag = "Bone Axe"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/storage/box/gun/tribal/boneaxe

/// BOWS

/datum/loadout_box/shortbow
	entry_tag = "Shortbow"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/bow/shortbow

/datum/loadout_box/longbow
	entry_tag = "Longbow"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/bow/longbow

/// Preacher Stuff

/datum/loadout_box/nullrod
	entry_tag = "Spiritual Device"
	entry_flags = LOADOUT_FLAG_PREACHER
	entry_class = LOADOUT_CAT_NULLROD
	spawn_thing = /obj/item/storage/box/gun/preacher/nullrod

/// misc Stuff

/datum/loadout_box/dynamite
	entry_tag = "Box of Dynamite"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/storage/box/dynamite_box

/datum/loadout_box/caps
	entry_tag = "25 Coins"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/stack/f13Cash/caps/twofive

/datum/loadout_box/woodenbuckler
	entry_tag = "Wooden Buckler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/shield/riot/buckler

/datum/loadout_box/stopsign
	entry_tag = "Stop Sign Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/riot/buckler/stop


/datum/loadout_box/kiteshield
	entry_tag = "Kite Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/kiteshield


/datum/loadout_box/bucklertwo
	entry_tag = "Oak Buckler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/bucklertwo

/datum/loadout_box/egyptianshield
	entry_tag = "Dusty Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/egyptianshield

/datum/loadout_box/semioval
	entry_tag = "Semioval Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/semioval

/datum/loadout_box/romanbuckler
	entry_tag = "Skirmisher's Buckler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/romanbuckler

/datum/loadout_box/ironshieldfour
	entry_tag = "Checkered Red Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/ironshieldfour

/datum/loadout_box/ironshieldthree
	entry_tag = "Red Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/ironshieldthree

/datum/loadout_box/ironshieldtwo
	entry_tag = "Oval Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/ironshieldtwo

/datum/loadout_box/bronzeshield
	entry_tag = "Bronze Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/bronzeshield

/datum/loadout_box/ironshield
	entry_tag = "Iron Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/ironshield

/datum/loadout_box/steelshield
	entry_tag = "Steel Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/steelshield

/datum/loadout_box/bluebuckler
	entry_tag = "Blue Buckler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/bluebuckler

/datum/loadout_box/redbuckler
	entry_tag = "Red Buckler"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/redbuckler

/datum/loadout_box/oldquarterstaff
	entry_tag = "Old Quarterstaff"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/classic_baton/coyote/oldquarterstaff

/datum/loadout_box/oldquarterstaff/bokken
	entry_tag = "Old Bokken"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/classic_baton/coyote/oldquarterstaff/oldbokken

/datum/loadout_box/olddervish
	entry_tag = "Old Dervish Blade"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/olddervish

/datum/loadout_box/oldpike/sarissa
	entry_tag = "Old Sarissa"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_TWO
	spawn_thing = /obj/item/melee/coyote/oldpike/sarissa

/datum/loadout_box/oldlongsword/spadroon
	entry_tag = "Old Spadroon"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword/spadroon

/datum/loadout_box/oldlongsword/broadsword
	entry_tag = "Old Broadsword"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword/broadsword

/datum/loadout_box/oldlongsword/armingsword
	entry_tag = "Old Arming Sword"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword/armingsword

/datum/loadout_box/oldlongsword/longquan
	entry_tag = "Old Chinese Sword"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword/longquan

/datum/loadout_box/oldlongsword/xiphos
	entry_tag = "Old Xiphos"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/melee/coyote/oldlongsword/xiphos

/datum/loadout_box/gar/
	entry_tag = "Black Gar Glasses"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/clothing/glasses/sunglasses/garb


/datum/loadout_box/blackgiggagar/
	entry_tag = "Black Gigga Gar Glasses"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/clothing/glasses/sunglasses/garb/supergarb

/datum/loadout_box/orangegar/
	entry_tag = "Orange Gar Glasses"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/clothing/glasses/sunglasses/gar

/datum/loadout_box/giggagar/
	entry_tag = "Gigga Gar Glasses"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE_ONE
	spawn_thing = /obj/item/clothing/glasses/sunglasses/gar/supergar

/datum/loadout_box/sling
	entry_tag = "Sling"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling

/datum/loadout_box/slingstaff
	entry_tag = "Slingstaff"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_HOBO
	spawn_thing = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff

/datum/loadout_box/riotweathered
	entry_tag = "Weathered Riot Shield"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_SHIELD
	spawn_thing = /obj/item/shield/coyote/riotweathered

/datum/loadout_box/beserker
	entry_tag = "Berserker's rites"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/book/granter/martial/berserker

/datum/loadout_box/bagorocks
	entry_tag = "A bag for carrying rocks"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MISC
	spawn_thing = /obj/item/ammo_box/rock/improvised

	// Kelp's magical stuff!

/datum/loadout_box/bonewands
	entry_tag = "Improvised Wands of Magic Missile"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MAGIC
	spawn_thing = /obj/item/storage/box/magic/bonewands

/obj/item/storage/box/magic/bonewands
	name = "wand storage case"

/obj/item/storage/box/magic/bonewands/PopulateContents()
	new /obj/item/gun/magic/wand/kelpmagic/magicmissile(src)
	new /obj/item/gun/magic/wand/kelpmagic/magicmissile(src)

/datum/loadout_box/shockwands
	entry_tag = "Improvised Shockwands"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MAGIC
	spawn_thing = /obj/item/storage/box/magic/rodwands

/obj/item/storage/box/magic/rodwands
	name = "wand storage case"

/obj/item/storage/box/magic/rodwands/PopulateContents()
	new /obj/item/gun/magic/wand/kelpmagic/basiczappies(src)
	new /obj/item/gun/magic/wand/kelpmagic/basiczappies(src)

/datum/loadout_box/healstaff
	entry_tag = "Staff of Lesser Healing"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MAGIC
	spawn_thing = /obj/item/storage/box/magic/healstaff

/obj/item/storage/box/magic/healstaff
	name = "staff storage case"

/obj/item/storage/box/magic/healstaff/PopulateContents()
	new /obj/item/gun/magic/staff/healing/triheal(src)

/datum/loadout_box/lesserfireball
	entry_tag = "Lesser Fireball Staff"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MAGIC
	spawn_thing = /obj/item/gun/magic/staff/kelpmagic/fireball/lowpower




// Putting this down here because it refuses to work. Needs to be fixed later.

/datum/loadout_box/energy/tglaser
	entry_tag = "Laser Pistol and Carbine"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/tglaser

/obj/item/storage/box/gun/energy/tglaser
	name = "laser pistol and carbine case"

/obj/item/storage/box/gun/energy/tglaser/PopulateContents()
	new /obj/item/gun/energy/laser/cranklasergun/tg/carbine(src)
	new /obj/item/gun/energy/laser/cranklasergun/tg/pistol(src)

// Spamlaser
/datum/loadout_box/energy/tglaser/spammer
	entry_tag = "Repeating Blaster"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_ENERGY
	spawn_thing = /obj/item/storage/box/gun/energy/tglaser/spammer

/obj/item/storage/box/gun/energy/tglaser/spammer
	name = "repeating blaster case"

/obj/item/storage/box/gun/energy/tglaser/spammer/PopulateContents()
	new /obj/item/gun/energy/laser/cranklasergun/tg/spamlaser(src)
