#define GUN_MASTER var/obj/item/gun/master = parent; if(!QDELETED(master)){return};
#define BALLISTIC_MASTER var/obj/item/gun/ballistic/master = parent; if(!QDELETED(master)){return};
#define ENERGY_MASTER var/obj/item/gun/energy/master = parent; if(!QDELETED(master)){return};

#define GR_LOAD_MAGAZINE (1<<0)
#define GR_LOAD_SPEEDLOADER (1<<1)
#define GR_LOAD_LOOSE (1<<2)
#define GR_LOAD_CHAMBER (1<<3)

/* * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * RELOAD BUTTON
 * lives on a gun, and is used to reload it
 * THE PROCESS:
 * 1. user clicks reload button
 * 2. user sends reload signal to gun, we get the signal
 * 2-1. if the gun is already reloading, eject the loaded casing
 * 3. we start the reload process!
 * 4. get a list of all the ammolike things in our inventory
 * 4-1. Try and prioritize things in belts and holsters
 * 4-2. Things from those places reload much faster, things from your backpack and such reload slower
 * 5. See wht we found!
 * 5-1. If we found nothing, then, cool.
 * 5-2. If the gun takes magazines, and we found a magazine, check for the one with the highest ammo count, regardless of capacity
 * 5-3. If the gun takes magazines, and we did not find a loaded magazine? abort! Magazine autoloading will be handled elsewhere
 * 5-4. If the gun takes speedloaders, and we found a speedloader, check for the one with the highest ammo count, regardless of capacity
 * 5-6. Otherwise look for loose ammo and load one. at. a. time.
 * 5-7. oh yeah if we take magazines, and theres no viable mags, but there is loose ammo? load one in the chamber =3
 * 6. If we found something, start the reload process! Unwield the gun
 * 7. If magazine, eject the old magazine and put it in our inventory, or drop it
 * 7-1. If speedloader or loosies, skip this step
 * 8. If magazine, put the new magazine in the gun
 * 8-1. If speedloader or loosies, put the new ammo in the gun
 * 9. Cocka the gun if needed
 */
/datum/component/gunreload
	var/load_flags = NONE
	var/list/speedloader_typecache = list()
	var/unload_time
	var/fetch_time
	var/load_time
	var/my_bar

	var/reloading

	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/gunreload/Initialize()
	if(!isgun(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_GUN_START_RELOAD, .proc/start_reload)
	RegisterSignal(parent, COMSIG_GUN_SHOT, .proc/interrupt_reload)
	RegisterSignal(parent, COMSIG_GUN_CHANGE_HANDS, .proc/interrupt_reload)

/// pre-checks to see if we can reload or something
/datum/component/gunreload/proc/start_reload(mob/living/loader)
	if(!isliving(loader))
		return
	if(!can_reload(loader))
		return
	if(reloading)
		rack_slide()
		return
	if(gun_is_full())
		to_chat(user, span_alert("That's already full!"))
		return
	INVOKE_ASYNC(src, .proc/reload, loader)

/datum/component/gunreload/proc/reload(mob/living/loader)
	var/datum/ammo_cache/AC = new /datum/ammo_cache(loader, parent, load_flags)
	var/obj/item/ammo_box/toload
	if(CHECK_BITFIELD(load_flags, GR_LOAD_MAGAZINE))
		to_load = AC.get_best_ammo_container(parent, "MAGAZINE")
		if(to_load)
			reload_magazine(loader, to_load)
		else if(CHECK_BITFIELD(load_flags, GR_LOAD_CHAMBER))
			reload_chamber(loader, AC)
	if(CHECK_BITFIELD(load_flags, GR_LOAD_SPEEDLOADER))
		to_load = AC.get_best_ammo_container(parent, "SPEEDLOADER")
		if(to_load)
			reload_speedloader(loader, to_load)
	if(CHECK_BITFIELD(load_flags, GR_LOAD_BOX))
		to_load = AC.get_best_ammo_container(parent, "BOX")
		if(to_load)
			reload_ammobox(loader, to_load)
	if(CHECK_BITFIELD(load_flags, GR_LOAD_LOOSE))
		reload_loose(AC)

/// reloads a magazine
/datum/component/gunreload/proc/reload_magazine(mob/living/loader, obj/item/ammo_box/ammo)
	if(!isliving(loader))
		return
	if(QDELETED(ammo))
		to_chat(user, span_phobia("SOmething went wreong!"))
		return
	progbarify(loader, ammo)
	var/obj/item/unloaded = remove_magazine_or_cell(loader, "BALLISTIC")
	if(!istype(unloaded))
		return abort()
	if(!stash_magazine(loader))
		drop_magazine(loader)
	if(!fetch_magazine(loader, ammo))
		return abort()
	if(!load_magazine(loader, ammo))
		return abort()
	chamber_new_round(loader)

/datum/component/gunreload/proc/remove_magazine_or_cell(mob/living/loader, kind)
	switch(kind)
		if("BALLISTIC")
			BALLISTIC_MASTER
			if(!master.magazine)
				return TRUE
			if(!master.magazine.fixed_mag)
				return FALSE
			playsound(master.sound_unload)
			if(!do_after(loader, unload_time, TRUE, master, TRUE, allow_movement = TRUE, stay_close = TRUE))
				to_chat(loader, span_alert("You were interrupted!"))
				return FALSE
			return TRUE







/datum/component/gunreload/proc/gun_is_full()
	if(istype(parent, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/ballgun = parent
		if(!ballgun.magazine)
			return FALSE
		return LAZYLEN(ballgun.magazine.stored_ammo) >= ballgun.magazine.max_ammo
	else if(istype(parent, /obj/item/gun/energy))
		var/obj/item/gun/energy/egun = parent
		if(!egun.cell)
			return FALSE
		return egun.cell.charge >= egun.cell.maxcharge
	else
		return FALSE

/datum/component/gunreload/proc/can_reload(mob/living/loader)
	GUN_MASTER
	if(!isliving(loader))
		return FALSE
	if(loader.stat)
		to_chat(user, span_alert("You're in no state to reload that!"))
		return FALSE
	if(master.loc != loader)
		to_chat(user, span_alert("You need to be holding that to reload it!"))
		return FALSE
	var/obj/item/held = loader.get_active_held_item()
	held.unwield(loader)
	if(!loader.get_empty_held_indexes())
		to_chat(user, span_alert("You need a free hand to reload that!"))
		return FALSE
	return TRUE

/datum/component/gunreload/proc/progbarify(mob/living/loader, obj/item/ammo_box/ammo)
	var/total_load_time = unload_time + fetch_time + load_time
	if(istype(parent, /obj/item/gun/ballistic))
		BALLISTIC_MASTER
		if(!master.magazine)
			total_load_time -= unload_time
	else if(istype(parent, /obj/item/gun/energy))
		ENERGY_MASTER
		if(!master.cell)
			total_load_time -= unload_time
	var/storage_flags = SEND_SIGNAL(ammo.loc, COMSIG_STORAGE_FLAGS)
	if(CHECK_BITFIELD(storage_flags, STORAGE_BANDOLIER))
		total_load_time *= 0.5
	my_bar = SSprogress_bars.add_bar(loader, list(loader), total_load_time, TRUE, TRUE)

/datum/ammo_cache
	var/list/magazines = list()
	var/list/slow_magazines = list()
	var/list/fast_magazines = list()
	var/list/held_magazines = list()

	var/list/speedloaders = list()
	var/list/slow_speedloaders = list()
	var/list/fast_speedloaders = list()
	var/list/held_speedloaders = list()

	var/list/ammoboxes = list()
	var/list/slow_ammoboxes = list()
	var/list/fast_ammoboxes = list()
	var/list/held_ammoboxes = list()

	var/list/loosies = list()

/datum/ammo_cache/New(mob/living/user, obj/item/gun/mygun, lookfor_flags = NONE)
	if(!isliving(user))
		qdel(src)
		return
	var/list/storage_places = get_all_storages(user)
	get_all_thingies(storage_places, lookfor_flags)

/datum/ammo_cache/proc/get_all_storages(mob/living/carbon/human/user)
	if(!isliving(user))
		qdel(src)
		return
	. = list()
	for(var/obj/item/thing in user.contents)
		if(!SEND_SIGNAL(thing, COMSIG_CONTAINS_STORAGE))
			continue
		. |= thing
	. |= user

/datum/ammo_cache/proc/get_all_thingies(list/storage_places, obj/item/gun/mygun, lookfor_flags = NONE)
	if(lookfor_flags == NONE)
		return // all done!
	for(var/atom/movable/storage in storage_places)
		var/storage_flags = SEND_SIGNAL(storage, COMSIG_STORAGE_FLAGS)
		var/is_bandolier = CHECK_BITFIELD(storage_flags, STORAGE_BANDOLIER)
		var/is_user = istype(storage, /mob/living)
		var/list/stuff_inside = list()
		SEND_SIGNAL(storage, COMSIG_TRY_STORAGE_RETURN_INVENTORY, stuff_inside)
		var/obj/item/gun/ballistic/ballgun = istype(mygun, /obj/item/gun/ballistic) && mygun
		var/obj/item/gun/energy/egun = istype(mygun, /obj/item/gun/energy) && mygun
		for(var/obj/item/thing in stuff_inside)
			if(ballgun)
				if(istype(thing, /obj/item/ammo_box))
					var/obj/item/ammo_box/AB = thing
					if(!LAZYLEN(AB.stored_ammo))
						continue
					if(!(AB.type in ballgun.allowed_mags))
						continue
					if(CHECK_BITFIELD(lookfor_flags, GR_LOAD_MAGAZINE))
						if(AB.ammo_kind == AMMO_MAGAZINE)
							magazines |= AB
							if(is_bandolier)
								fast_magazines |= AB
							else
								slow_magazines |= AB
							continue
					if(CHECK_BITFIELD(lookfor_flags, GR_LOAD_SPEEDLOADER))
						if(AB.ammo_kind == AMMO_SPEEDLOADER)
							speedloaders |= AB
							if(is_bandolier)
								fast_speedloaders |= AB
							else
								slow_speedloaders |= AB
							continue
					if(CHECK_BITFIELD(lookfor_flags, GR_LOAD_BOX))
						if(AB.ammo_kind == AMMO_LOOSE)
							ammoboxes |= AB
							if(is_bandolier)
								fast_ammoboxes |= AB
							else
								slow_ammoboxes |= AB
							continue
				else if(CHECK_BITFIELD(lookfor_flags, GR_LOAD_LOOSE) && istype(thing, /obj/item/ammo_casing))
					var/obj/item/ammo_casing/casing = thing
					if(!(casing.caliber in ballgun.magazine.caliber))
						continue
					loosies |= thing

/datum/ammo_cache/proc/get_best_ammo_container(obj/item/gun/ballistic/mygun, kind)
	var/list/mags
	switch(kind)
		if("MAGAZINE")
			mags = held_magazines + fast_magazines + slow_magazines // puts the fast ones first
		if("SPEEDLOADER")
			mags = held_speedloaders + fast_speedloaders + slow_speedloaders
		if("BOX")
			mags = held_ammoboxes + fast_ammoboxes + slow_ammoboxes
		else
			return // shruggo
	var/obj/item/ammo_box/highest_ammo
	for(var/obj/item/ammo_box/mag in mags)
		if(mygun.magazine)
			if(LAZYLEN(mag.stored_ammo) > LAZYLEN(mygun.magazine.stored_ammo))
				highest_ammo = mag
		else if(!highest_ammo)
			highest_ammo = mag
		else if(LAZYLEN(mag.stored_ammo) > LAZYLEN(highest_ammo.stored_ammo))
			highest_ammo = mag
	return highest_ammo



