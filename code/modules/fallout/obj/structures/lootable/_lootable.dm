
#define LOOT_TIER_LOWEST 1
#define LOOT_TIER_LOW 2
#define LOOT_TIER_MID 3
#define LOOT_TIER_HIGH 4
#define LOOT_TIER_HIGHEST 5
#define LOOT_TRASH "trash"

/obj/item/storage/lootable/proc/GetLootableName()
	if(!random_name_list)
		return name
	switch(random_name_list)
		if("cardboard box")
			return pick(list("cardboard box",
							"paper box",
							"cardboard crate",
							"shoe box",
							))
		if("ammo box")
			return pick(list("ammunition crate",
							"crate of ammo",
							"ammo box",
							"ammunition storage",
							"box of ammunition",
							"crate of bullets"))
		if("weapon box")
			return pick(list("weapon box",
							"weapon crate",
							"gun crate",
							"crate of weapons",
							"box of weaponry",
							))
		if("magic box")
			return pick(list("arcane crate",
							"box of the arcane",
							"wand storage",
							"eldritch storage unit",
							"scroll box",
							"magic box"))
		if("safe")
			return pick(list("lockbox",
							"safe",
							"secure container"))
		if("fridge")
			return pick(list("refridgerator",
							"ice box",
							"fridge",
							"freezer"))

		else
			return name

/obj/item/storage/lootable/proc/GetLootableNamePrefix()
	if(!random_prefix)
		return
	switch(loot_tier)
		if(LOOT_TIER_LOWEST)
			return pick(list("smelly",
							"gross",
							"moldy",
							"decrepit",
							"ancient",
							"bug infested"))
		if(LOOT_TIER_LOW)
			return pick(list("old",
							"dusty",
							"damp",
							"crusty"))
		if(LOOT_TIER_MID)
			return
		if(LOOT_TIER_HIGH)
			return pick(list("new",
							"brand new",
							"clean",
							"maintained",
							"well kept",))
		if(LOOT_TIER_HIGHEST)
			return pick(list("pristine",
							"glowing",
							"radioactive",
							"factory new",
							"sealed"))

GLOBAL_LIST_INIT(lootable_random_sounds, list(
	"debug" = list(),
	"cardboard" = list(),
))

GLOBAL_LIST_INIT(ammo_loot_tiers, list(
	LOOT_TIER_LOWEST = /obj/effect/spawner/lootdrop/f13/common_ammo,
	LOOT_TIER_LOW = /obj/effect/spawner/lootdrop/f13/uncommon_ammo,
	LOOT_TIER_MID = /obj/effect/spawner/lootdrop/f13/rare_ammo,
))

GLOBAL_LIST_INIT(trash_loot_tiers, list(
	1 = /obj/effect/spawner/lootdrop/f13/trash,
))

GLOBAL_LIST_INIT(lootable_types, list(
	"ammo" = GLOB.ammo_loot_tiers,
	"trash" = GLOB.trash_loot_tiers,
))

/// These are things in the world that a player could click on to pull loot out of. Lets more than one person loot a place rather than having static loot everywhere.
/obj/item/storage/lootable
	anchored = TRUE //Always keep this as TRUE
	can_be_unanchored = FALSE //Always keep this as FALSE

	name = "cardboard box"
	desc = "Some kind of cardboard box. I wonder what's inside?"
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "smallbox"
	density = FALSE //May be true depending on what kind of lootable object it is. Cardboard boxes are small and could be easily stepped over so this is FALSE by default.
	/// Should this loot container automatically set its loot tier based on its area / z level / surrounding enemies / etc
	var/dynamic_loot_tier = FALSE
	/// Dynamic loot tiering will override this if it can, so this is just the fallback.
	var/loot_tier = LOOT_TIER_LOWEST
	var/loot_type = LOOT_TRASH
	var/loot_rolls_max = 10
	var/loot_rolls_min = 5
	/// Set to null to not randomize the name.
	var/random_name_list = "cardboard"
	var/random_sound_list = "cardboard"
	/// Should we assign a random prefix depending on the loot tier of this lootable?
	var/random_prefix = TRUE
	/// Play an animation while/after looting this thing?
	var/loot_animation = TRUE
	///Is someone looting this right now?
	var/being_looted = FALSE
	///Players who have recently looted this container
	var/list/loot_players = list()
	/// If true, will try and fill up our inventory until we're full, then spit our loot out if we have to.
	var/place_loot_inside = FALSE

/obj/item/storage/lootable/Initialize(mapload)
	. = ..()
	//Do dynamic loot tier magic here

	//Based on the tier selected, generate the name
	name = "[GetLootableNamePrefix()][GetLootableName()]"

/obj/item/storage/lootable/attack_hand(mob/user)
	var/turf/loot_turf = get_turf(src)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("You need a ckey to search the trash! Gratz on not having a ckey, tell a coder about it!"))
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	if(!being_looted)
		playsound(get_turf(src), 'sound/f13effects/loot_trash.ogg', 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("You start picking through [src]..."))
	being_looted = TRUE
	if(!do_mob(user, src, 3 SECONDS))
		being_looted = FALSE
		return
	being_looted = FALSE
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	loot_players += ukey
	to_chat(user, span_notice("You scavenge through [src]."))
	for(var/i in 1 to rand(1,4))
		var/list/trash_passthru = list()
		var/obj/effect/spawner/lootdrop/f13/trash/pile/my_trash = new(loot_turf)
		my_trash.spawn_the_stuff(trash_passthru) // fun fact, lists are references, so this'll be populated when the proc runs (cool huh?)
		for(var/atom/movable/spawned in trash_passthru)
			if(isitem(spawned))
				var/obj/item/newitem = spawned
				newitem.from_trash = TRUE
			if(isgun(spawned))
				var/obj/item/gun/trash_gun = spawned
				var/prob_trash = 80
				for(var/tries in 1 to 3)
					if(!prob(prob_trash))
						continue
					prob_trash -= 40
					var/trash_mod_path = pick(GLOB.trash_gunmods)
					var/obj/item/gun_upgrade/trash_mod = new trash_mod_path
					if(SEND_SIGNAL(trash_mod, COMSIG_ITEM_ATTACK_OBJ_NOHIT, trash_gun, null))
						break
					QDEL_NULL(trash_mod)
