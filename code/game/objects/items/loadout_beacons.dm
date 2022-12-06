/* LIST STRUCTURELOADOUT_ROOT
 * list encodes "tag" = list(LOADOUT_BITFIELD = a bitfield, LOADOUT_CLASS = melee, LOADOUT_PATH = the path)
 */
#define LOADOUT_FLAG_WASTER (1<<0)
#define LOADOUT_FLAG_LAWMAN (1<<1)
#define LOADOUT_FLAG_PREMIUM (1<<2)
#define LOADOUT_FLAG_TRIBAL (1<<3)
#define LOADOUT_FLAG_PREACHER (1<<4)

#define LOADOUT_BITFIELD "loadout_bitfield"
#define LOADOUT_CLASS "loadout_class"
#define LOADOUT_PATH "loadout_path"

#define LOADOUT_CAT_PREMIUM "Fancy Weapons"
#define LOADOUT_CAT_LAWMAN "Law Weapons"
#define LOADOUT_CAT_MELEE "Melee"
#define LOADOUT_CAT_PISTOL "Pistols"
#define LOADOUT_CAT_REVOLVER "Revolvers"
#define LOADOUT_CAT_LONGGUN "Long Guns"
#define LOADOUT_CAT_HOBO "Improvised Guns"
#define LOADOUT_CAT_BOW "Bows"
#define LOADOUT_CAT_NULLROD "Spiritual Device"
#define LOADOUT_CAT_SHIELD "Shields"
#define LOADOUT_CAT_ENERGY "Energy Weapons"

#define LOADOUT_ROOT_ENTRIES list(LOADOUT_CAT_MELEE, LOADOUT_CAT_PISTOL, LOADOUT_CAT_REVOLVER, LOADOUT_CAT_LONGGUN, LOADOUT_CAT_HOBO, LOADOUT_CAT_BOW, LOADOUT_CAT_ENERGY, LOADOUT_CAT_NULLROD, LOADOUT_CAT_SHIELD)
#define LOADOUT_ALL_ENTRIES list(LOADOUT_CAT_PREMIUM, LOADOUT_CAT_LAWMAN, LOADOUT_CAT_MELEE, LOADOUT_CAT_PISTOL, LOADOUT_CAT_REVOLVER, LOADOUT_CAT_LONGGUN, LOADOUT_CAT_HOBO, LOADOUT_CAT_BOW, LOADOUT_CAT_ENERGY, LOADOUT_CAT_NULLROD, LOADOUT_CAT_SHIELD)

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
	slot_flags = ITEM_SLOT_BELT
	/// these flags plus whatever's picked in the root menu = what we're allowed to spawn, easy peasy
	/// MUST be set
	var/allowed_flags
	/// What kits are inside this kit? If blank, just show a list of everything set to be allowed
	var/list/multiple_choice = list()

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
		"Secondary" = list(LOADOUT_CAT_MELEE)
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
		"Secondary" = list(LOADOUT_CAT_MELEE)
	)

/obj/item/kit_spawner/tribal
	name = "Tribal equipment kit"
	desc = "Primitive equipment for a primitive person!"
	allowed_flags = LOADOUT_FLAG_TRIBAL
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE)
	)

/obj/item/kit_spawner/tribal/farlands
	name = "Farlands tribal equipment kit"
	desc = "Primitive equipment for a primitive person!"
	allowed_flags = LOADOUT_FLAG_TRIBAL | LOADOUT_FLAG_WASTER
	multiple_choice = list(
		"Primary" = LOADOUT_ROOT_ENTRIES,
		"Secondary" = list(LOADOUT_CAT_MELEE)
	)

/obj/item/kit_spawner/debug_waster
	name = "waster kit spawner!"
	desc = "Some kind of kit spawner!"
	allowed_flags = LOADOUT_FLAG_WASTER
	multiple_choice = list(
		"Bepis Mk 1" = list(LOADOUT_CAT_MELEE),
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
		use_the_kit(user)

/obj/item/kit_spawner/proc/can_use_kit(mob/living/user)
	if(user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return TRUE
	playsound(src, 'sound/machines/synth_no.ogg', 40, 1)
	return FALSE

/obj/item/kit_spawner/proc/use_the_kit(mob/living/user)
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
			return
		if(!LAZYLEN(multiple_choice[first_key]))
			user.show_message(span_phobia("Whoever set up [src] didn't set up the multiple choice list right! there should be a list here, and there isnt one! this is a bug~"))
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
		return
	//user.show_message("[final_key] selected!")
	if(!spawn_the_thing(user, GLOB.loadout_boxes[type][second_key][final_key]))
		user.show_message(span_alert("Couldn't get the thing out of the case. Try again?"))
		return
	if(first_key && (first_key in multiple_choice))
		multiple_choice[first_key] = null
		multiple_choice -= first_key
	if(LAZYLEN(multiple_choice) < 1)
		qdel(src)


/obj/item/kit_spawner/proc/check_choice(choice_to_check)
	if(!choice_to_check)
		return FALSE
	if(!ispath(choice_to_check))
		return FALSE
	return TRUE

/obj/item/kit_spawner/proc/spawn_the_thing(mob/user, atom/the_thing)
	var/turf/spawn_here
	spawn_here = user ? get_turf(user) : get_turf(src)
	var/obj/item/new_thing = new the_thing(spawn_here)
	if(istype(new_thing))
		user.show_message(span_green("You pull \a [new_thing.name] out of [src]."))
		return TRUE

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

/// Guns for the LAWman
/obj/item/storage/box/gun/law
	name = "American 180 case" //it was meant to be a police rifle anyways~
	w_class = WEIGHT_CLASS_BULKY //most will be rifles

/obj/item/storage/box/gun/law/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/american180(src)
	new /obj/item/ammo_box/magazine/m22smg(src)

/obj/item/storage/box/gun/law/smg10mm
	name = "10mm smg case"

/obj/item/storage/box/gun/law/smg10mm/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/smg10mm(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/ext(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/ext(src)

/obj/item/storage/box/gun/law/commando
	name = "commando carbine case"

/obj/item/storage/box/gun/law/commando/PopulateContents()
	new /obj/item/gun/ballistic/automatic/delisle/commando(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)

/obj/item/storage/box/gun/law/combat //luv u scryden
	name = "combat carbine case"

/obj/item/storage/box/gun/law/combat/PopulateContents()
	new /obj/item/gun/ballistic/automatic/combat(src)
	new /obj/item/ammo_box/magazine/tommygunm45/stick(src)
	new /obj/item/ammo_box/magazine/tommygunm45/stick(src)

/obj/item/storage/box/gun/law/service
	name = "service rifle case"

/obj/item/storage/box/gun/law/service/PopulateContents()
	new /obj/item/gun/ballistic/automatic/service(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)

/obj/item/storage/box/gun/law/policerifle
	name = "police rifle case"

/obj/item/storage/box/gun/law/policerifle/PopulateContents()
	new /obj/item/gun/ballistic/automatic/marksman/policerifle(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)
	new /obj/item/ammo_box/magazine/m556/rifle(src)

/obj/item/storage/box/gun/law/assault_carbine
	name = "assault carbine case" //police assault rifle is stronger, not sure which they should have

/obj/item/storage/box/gun/law/assault_carbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/assault_carbine(src)
	new /obj/item/ammo_box/magazine/m5mm(src)
	new /obj/item/ammo_box/magazine/m5mm(src)

/obj/item/storage/box/gun/law/mk23 //not a whole rifle, but a really good pistol if you track down your own rifle
	name = "Tactical MK-23 case"
	w_class = WEIGHT_CLASS_NORMAL //only normal sized law gun

/obj/item/storage/box/gun/law/mk23/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/mk23(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)
	new /obj/item/ammo_box/magazine/m45/socom(src)

/obj/item/storage/box/gun/law/trail
	name = "trail carbine case"

/obj/item/storage/box/gun/law/trail/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/trail(src)
	new /obj/item/ammo_box/tube/m44(src)
	new /obj/item/ammo_box/tube/m44(src)
	new /obj/item/ammo_box/tube/m44(src) //one extra, just for you for choosing the stylish gun

/obj/item/storage/box/gun/law/police
	name = "police shotgun case"

/obj/item/storage/box/gun/law/police/PopulateContents()
	new /obj/item/gun/ballistic/shotgun/police(src)
	new /obj/item/ammo_box/shotgun/buck(src) //eeeevery flavor
	new /obj/item/ammo_box/shotgun/slug(src)
	new /obj/item/ammo_box/shotgun/bean(src)
	new /obj/item/ammo_box/shotgun/rubber(src) //make sure these are okay

/obj/item/storage/box/gun/rifle/brushgun
	name = "brush gun case"

/obj/item/storage/box/gun/rifle/brushgun/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/brush(src)
	new /obj/item/ammo_box/c4570box(src)

/obj/item/storage/box/gun/rifle/amr
	name = "anti-materiel rifle case"

/obj/item/storage/box/gun/rifle/amr/PopulateContents()
	new /obj/item/gun/ballistic/rifle/mag/antimateriel(src)
	new /obj/item/ammo_box/magazine/amr(src)
	new /obj/item/ammo_box/a50MGbox(src)

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
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)

/obj/item/storage/box/gun/premium/automatic //beretta m93r, but keeping the naming scheme I got
	name = "Beretta M93R case" //might be stronk, might need to not take greasegun mags, will see

/obj/item/storage/box/gun/premium/automatic/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/beretta/automatic(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)

/obj/item/storage/box/gun/premium/executive //good to be here till we get the vault back
	name = "the Executive case"

/obj/item/storage/box/gun/premium/executive/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/executive(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)

/obj/item/storage/box/gun/premium/crusader
	name = "Crusader pistol case"

/obj/item/storage/box/gun/premium/crusader/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99/crusader(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)

/obj/item/storage/box/gun/premium/sig //can downgrade to whatever the trusty sig p220 is for. it has slightly lower fire rate
	name = "Sig P220 case"

/obj/item/storage/box/gun/premium/sig/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/sig(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/storage/box/gun/premium/custom
	name = "M1911 Custom case"

/obj/item/storage/box/gun/premium/custom/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911/custom(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

//mk23 and magnum semi-autos are just a liiiiittle too chonky for this list

/obj/item/storage/box/gun/premium/mateba //ugh, fiiiiiiiine you can have your dumb coolness revolver, if you're the right rank~
	name = "Unica 6 case"

/obj/item/storage/box/gun/premium/mateba/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357/mateba(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/box/gun/premium/lucky //not sure if this should be allowed, or if is supposed to be unique
	name = ".357 magnum revolver case"

/obj/item/storage/box/gun/premium/lucky/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357/lucky(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/box/gun/premium/alt //pearly .44 mag
	name = "pearl .44 magnum case"

/obj/item/storage/box/gun/premium/alt/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/alt(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/premium/peacekeeper
	name = "Peacekeeper case"

/obj/item/storage/box/gun/premium/peacekeeper/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/peacekeeper(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/premium/desert_ranger
	name = "ranger revolver case"

/obj/item/storage/box/gun/premium/desert_ranger/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver44/desert_ranger(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/// Long guns

/obj/item/storage/box/gun/rifle
	name = "cowboy repeater case"
	w_class = WEIGHT_CLASS_BULKY //rifles beeg, no fit in backpack for later

/obj/item/storage/box/gun/rifle/PopulateContents()
	new /obj/item/gun/ballistic/rifle/repeater/cowboy(src)
	new /obj/item/ammo_box/tube/a357(src) //high capacity, only get one

/obj/item/storage/box/gun/rifle/hunting
	name = "hunting rifle case"

/obj/item/storage/box/gun/rifle/hunting/PopulateContents()
	new /obj/item/gun/ballistic/rifle/hunting(src)
	new /obj/item/ammo_box/a308(src)
	new /obj/item/ammo_box/a308(src)

/obj/item/storage/box/gun/rifle/caravan_shotgun
	name = "caravan shotgun case"

/obj/item/storage/box/gun/rifle/caravan_shotgun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/caravan_shotgun(src)
	new /obj/item/ammo_box/shotgun/buck(src) //lots of shotshells, just one box

/obj/item/storage/box/gun/rifle/widowmaker
	name = "Winchester Widowmaker case"

/obj/item/storage/box/gun/rifle/widowmaker/PopulateContents()
	new /obj/item/gun/ballistic/revolver/widowmaker(src)
	new /obj/item/ammo_box/shotgun/buck(src)

/obj/item/storage/box/gun/rifle/smg22 //only full auto gun you can has roundstart. might not be allowed, will see
	name = ".22 Uzi case"

/obj/item/storage/box/gun/rifle/smg22/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22(src)
	new /obj/item/ammo_box/magazine/m22/extended(src)

/obj/item/storage/box/gun/rifle/sidewinder //should this be allowed? not field tested personally
	name = "multi-caliber smg case"

/obj/item/storage/box/gun/rifle/sidewinder/PopulateContents()
	new /obj/item/gun/ballistic/automatic/smg/sidewinder(src)
	new /obj/item/ammo_box/magazine/m22(src) //you asked for multicaliber, you get multiple calibers
	new /obj/item/ammo_box/magazine/m45(src)

/obj/item/storage/box/gun/rifle/m1carbine
	name = "M1 carbine case"

/obj/item/storage/box/gun/rifle/m1carbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/m1carbine(src)
	new /obj/item/ammo_box/magazine/m10mm/adv(src) //why can't 10mm magazines be normal? make sure these aren't extended or broken
	new /obj/item/ammo_box/magazine/m10mm/adv(src)

/obj/item/storage/box/gun/rifle/delisle
	name = "De Lisle carbine case"

/obj/item/storage/box/gun/rifle/delisle/PopulateContents()
	new /obj/item/gun/ballistic/automatic/delisle(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)

/obj/item/storage/box/gun/rifle/sportcarbine
	name = "sport carbine case"

/obj/item/storage/box/gun/rifle/sportcarbine/PopulateContents()
	new /obj/item/gun/ballistic/automatic/sportcarbine(src)
	new /obj/item/ammo_box/magazine/m22/extended(src) //high cap, just one

/obj/item/storage/box/gun/rifle/varmint
	name = "varmint rifle case"

/obj/item/storage/box/gun/rifle/varmint/PopulateContents()
	new /obj/item/gun/ballistic/automatic/varmint(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src) //no extendeds for you till you find em
	new /obj/item/ammo_box/magazine/m556/rifle/small(src)

/// MELEE
//gunmelee
/obj/item/storage/box/gun/melee //hopefully a decent variety. someone with more expertise expand on this. maybe split between one and two handed
	name = "scrap sabre case" //stronk, but currently a roundstart. we shall see
	w_class = WEIGHT_CLASS_NORMAL //some are bulky

/obj/item/storage/box/gun/melee/PopulateContents()
	new /obj/item/melee/onehanded/machete/scrapsabre(src)

/obj/item/storage/box/gun/melee/bowie //that's not a knife, this is a knife.
	name = "bowie knife case" //not as strong as a scrap sabre, but a good weapon to slip in boot

/obj/item/storage/box/gun/melee/bowie/PopulateContents()
	new /obj/item/melee/onehanded/knife/bowie(src)

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

/obj/item/storage/box/gun/melee/sledgehammer
	name = "sledgehammer case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/sledgehammer/PopulateContents()
	new /obj/item/twohanded/sledgehammer/simple(src)

/obj/item/storage/box/gun/melee/chainsaw
	name = "chainsaw case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/melee/chainsaw/PopulateContents()
	new /obj/item/twohanded/chainsaw(src)

/obj/item/storage/box/gun/melee/militarypolice
	name = "baton case"

/obj/item/storage/box/gun/melee/militarypolice/PopulateContents()
	new /obj/item/melee/classic_baton/militarypolice(src)

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
	new /obj/item/ammo_box/magazine/zipgun(src)
	new /obj/item/ammo_box/magazine/zipgun(src) //smol cap, get a couple extra
	new /obj/item/ammo_box/magazine/zipgun(src)

/obj/item/storage/box/gun/hobo/piperifle
	name = "pipe rifle case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/piperifle/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/piperifle(src)
	new /obj/item/ammo_box/a762/doublestacked(src) //it's like a box but smaller

/obj/item/storage/box/gun/hobo/pepperbox
	name = "pepperbox gun case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/pepperbox/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/pepperbox(src)
	new /obj/item/ammo_box/l10mm(src) //no idea wtf this is for originally but it'll do
	new /obj/item/ammo_box/l10mm(src)

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
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/hobo/knucklegun
	name = "knucklegun case"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gun/hobo/knucklegun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/hobo/knucklegun(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45rev(src)

/obj/item/storage/box/gun/hobo/winchesterrebored
	name = "rebored Whinchester case"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/storage/box/gun/hobo/winchesterrebored/PopulateContents()
	new /obj/item/gun/ballistic/revolver/winchesterrebored(src)
	new /obj/item/ammo_box/a762/doublestacked(src) //it's like a box but smaller

/// revolvers!

/obj/item/storage/box/gun/revolver
	name = ".38 Detective Special case"
	w_class = WEIGHT_CLASS_NORMAL //revolvers aren't bulky

/obj/item/storage/box/gun/revolver/PopulateContents()
	new /obj/item/gun/ballistic/revolver/detective(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38(src) //smol round, so extra loader

/obj/item/storage/box/gun/revolver/revolver45
	name = ".45 ACP revolver case"

/obj/item/storage/box/gun/revolver/revolver45/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver45(src)
	new /obj/item/ammo_box/c45rev(src)
	new /obj/item/ammo_box/c45rev(src)

/obj/item/storage/box/gun/revolver/colt357
	name = ".357 magnum revolver case" //what does \improper mean, is needed here?

/obj/item/storage/box/gun/revolver/colt357/PopulateContents()
	new /obj/item/gun/ballistic/revolver/colt357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/box/gun/revolver/police
	name = "police revolver case"

/obj/item/storage/box/gun/revolver/police/PopulateContents()
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/obj/item/storage/box/gun/revolver/m29
	name = ".44 magnum revolver case"

/obj/item/storage/box/gun/revolver/m29/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/revolver/m29snub
	name = "snubnose .44 magnum case"

/obj/item/storage/box/gun/revolver/m29snub/PopulateContents()
	new /obj/item/gun/ballistic/revolver/m29/snub(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/revolver/revolver44
	name = ".44 magnum single-action case"

/obj/item/storage/box/gun/revolver/revolver44/PopulateContents()
	new /obj/item/gun/ballistic/revolver/revolver44(src)
	new /obj/item/ammo_box/m44(src)
	new /obj/item/ammo_box/m44(src)

/obj/item/storage/box/gun/revolver/thatgun
	name = ".223 pistol case"

/obj/item/storage/box/gun/revolver/thatgun/PopulateContents()
	new /obj/item/gun/ballistic/revolver/thatgun(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src)
	new /obj/item/ammo_box/magazine/m556/rifle/small(src)

/// Semiauto pistols!

/obj/item/storage/box/gun/pistol
	name = ".22 pistol case"
	w_class = WEIGHT_CLASS_NORMAL //pistols aren't bulky

/obj/item/storage/box/gun/pistol/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/pistol22(src)
	new /obj/item/ammo_box/magazine/m22(src)
	new /obj/item/ammo_box/magazine/m22(src)

/obj/item/storage/box/gun/pistol/ninemil
	name = "Browning Hi-power case"

/obj/item/storage/box/gun/pistol/ninemil/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/ninemil(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)

/obj/item/storage/box/gun/pistol/beretta
	name = "Beretta M9FS case"

/obj/item/storage/box/gun/pistol/beretta/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/beretta(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)
	new /obj/item/ammo_box/magazine/m9mm/doublestack(src)

/obj/item/storage/box/gun/pistol/n99
	name = "10mm pistol case"

/obj/item/storage/box/gun/pistol/n99/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/n99(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)

/obj/item/storage/box/gun/pistol/type17
	name = "Type 17 case"

/obj/item/storage/box/gun/pistol/type17/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/type17(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)
	new /obj/item/ammo_box/magazine/m10mm/adv/simple(src)

/obj/item/storage/box/gun/pistol/m1911 //muh three worldly whores
	name = "M1911 case"

/obj/item/storage/box/gun/pistol/m1911/PopulateContents()
	new /obj/item/gun/ballistic/automatic/pistol/m1911(src)
	new /obj/item/ammo_box/magazine/m45(src)
	new /obj/item/ammo_box/magazine/m45(src)

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

/obj/item/storage/box/gun/tribal/bmprword/PopulateContents()
	new /obj/item/twohanded/fireaxe/bmprsword(src)

/obj/item/storage/box/gun/tribal/warmace
	name = "warmace case"

/obj/item/storage/box/gun/tribal/warmace/PopulateContents()
	new /obj/item/twohanded/sledgehammer/warmace(src)

/obj/item/storage/box/gun/tribal/spearquiver
	name = "spear quiver case"

/obj/item/storage/box/gun/tribal/spearquiver/PopulateContents()
	new /obj/item/storage/backpack/spearquiver(src)

/obj/item/storage/box/gun/bow/sturdy
	name = "sturdy bow case"

/obj/item/storage/box/gun/bow/sturdy/PopulateContents()
	new /obj/item/gun/ballistic/bow/sturdy(src)
	new /obj/item/storage/bag/tribe_quiver/archer(src)

/obj/item/storage/box/gun/bow/crossbow
	name = "crossbow case"

/obj/item/storage/box/gun/bow/crossbow/PopulateContents()
	new /obj/item/gun/ballistic/bow/crossbow(src)
	new /obj/item/storage/bag/tribe_quiver/archer(src)

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

/datum/loadout_box/caravan_shotgun
	entry_tag = "Caravan Shotgun"
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

/datum/loadout_box/sidewinder
	entry_tag = "Multicaliber SMG"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_LONGGUN
	spawn_thing = /obj/item/storage/box/gun/rifle/sidewinder

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

/datum/loadout_box/amr
	entry_tag = "Anti-Materiel Rifle"
	entry_flags = LOADOUT_FLAG_PREMIUM
	entry_class = LOADOUT_CAT_PREMIUM
	spawn_thing = /obj/item/storage/box/gun/rifle/amr

/datum/loadout_box/brushgun
	entry_tag = "Brush Gun"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/rifle/brushgun

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
	entry_tag = ".38 Detective Special"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver

/datum/loadout_box/revolver45
	entry_tag = ".45ACP Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/revolver45

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
	entry_tag = ".223 Revolver"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_REVOLVER
	spawn_thing = /obj/item/storage/box/gun/revolver/thatgun

/// Semi-auto pistols!

/datum/loadout_box/pistol
	entry_tag = ".22 Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol

/datum/loadout_box/ninemil
	entry_tag = "Hi-Power Pistol"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_PISTOL
	spawn_thing = /obj/item/storage/box/gun/pistol/ninemil

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
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee

/datum/loadout_box/bowie
	entry_tag = "Bowie Knife"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/bowie

/datum/loadout_box/throwing
	entry_tag = "Throwing Knives"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/throwing

/datum/loadout_box/brass
	entry_tag = "Brass Knuckles"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL | LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/brass

/datum/loadout_box/fryingpan
	entry_tag = "Frying Pan"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/fryingpan

/datum/loadout_box/scrapspear
	entry_tag = "Scrap Spear"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/scrapspear

/datum/loadout_box/baseball
	entry_tag = "Baseball Bat"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_LAWMAN | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/baseball

/datum/loadout_box/sledgehammer
	entry_tag = "Sledgehammer"
	entry_flags = LOADOUT_FLAG_WASTER | LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/sledgehammer

/datum/loadout_box/chainsaw
	entry_tag = "Chainsaw"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/melee/chainsaw

/datum/loadout_box/militarypolice
	entry_tag = "Police Baton"
	entry_flags = LOADOUT_FLAG_LAWMAN
	entry_class = LOADOUT_CAT_LAWMAN
	spawn_thing = /obj/item/storage/box/gun/melee/militarypolice

/// Tribal

/datum/loadout_box/tribal
	entry_tag = "Bone Spear"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal

/datum/loadout_box/forgedmachete
	entry_tag = "Machete"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/forgedmachete

/datum/loadout_box/bmprsword
	entry_tag = "Bumper Sword"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/bmprsword

/datum/loadout_box/warmace
	entry_tag = "Warmace"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/warmace

/datum/loadout_box/spearquivergun/bow/sturdy
	entry_tag = "Spear Quiver"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/spearquiver

/datum/loadout_box/warclub
	entry_tag = "War Club"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/warclub

/datum/loadout_box/boneaxe
	entry_tag = "Bone Axe"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_MELEE
	spawn_thing = /obj/item/storage/box/gun/tribal/boneaxe

/// BOWS

/datum/loadout_box/sturdy
	entry_tag = "Sturdy Bow"
	entry_flags = LOADOUT_FLAG_TRIBAL
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/bow/sturdy

/datum/loadout_box/crossbow
	entry_tag = "Crossbow"
	entry_flags = LOADOUT_FLAG_WASTER
	entry_class = LOADOUT_CAT_BOW
	spawn_thing = /obj/item/storage/box/gun/bow/crossbow

/// Preacher Stuff

/datum/loadout_box/nullrod
	entry_tag = "Spiritual Device"
	entry_flags = LOADOUT_FLAG_PREACHER
	entry_class = LOADOUT_CAT_NULLROD
	spawn_thing = /obj/item/storage/box/gun/preacher/nullrod











