///Trash
#define LOOT_TIER_LOWEST 1
///Common
#define LOOT_TIER_LOW 2
///Uncommon
#define LOOT_TIER_MID 3
///Rare
#define LOOT_TIER_HIGH 4
///Very Rare
#define LOOT_TIER_HIGHEST 5

#define LOOT_TRASH "trash"
#define LOOT_AMMO "ammo"
#define LOOT_GUNS "guns"
#define LOOT_LASERS "energy weapons"
#define LOOT_KITCHEN "kitchen"
#define LOOT_FARM "farm"
#define LOOT_MECHANIC "mechanic"
#define LOOT_SCIENCE "science"
#define LOOT_FIRSTAID "first aid"
#define LOOT_SURGERY "surgery"

/obj/structure/lootable/proc/GetLootableName()
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

/obj/structure/lootable/proc/GetLootableNamePrefix()
	if(!random_prefix)
		return
	switch(loot_tier)
		if(LOOT_TIER_LOWEST)
			return pick(list("smelly ",
							"gross ",
							"moldy ",
							"decrepit ",
							"ancient ",
							"bug infested ",))
		if(LOOT_TIER_LOW)
			return pick(list("old ",
							"dusty ",
							"damp ",
							"crusty ",
							"burned ",))
		if(LOOT_TIER_MID)
			return
		if(LOOT_TIER_HIGH)
			return pick(list("new ",
							"brand new ",
							"clean ",
							"maintained ",
							"well kept ",))
		if(LOOT_TIER_HIGHEST)
			return pick(list("pristine ",
							"glowing ",
							"radioactive ",
							"factory new ",
							"sealed ",))

/obj/structure/lootable/proc/GetLootingSound()
	switch(random_sound_list)
		if("trash")
			return 'sound/f13effects/loot_trash.ogg'
		else
			return 'sound/f13effects/loot_trash.ogg'


GLOBAL_LIST_INIT(lootable_random_sounds, list(
	"debug" = list(),
	"cardboard" = list(),
))

GLOBAL_LIST_INIT(ammo_loot_tiers, list(
	LOOT_TIER_LOWEST = list(
						/obj/effect/spawner/lootdrop/f13/trash_ammo = 15,
						/obj/effect/spawner/lootdrop/f13/common_ammo = 5,
						/obj/effect/spawner/lootdrop/f13/uncommon_ammo = 2,
						),

	LOOT_TIER_LOW = list(/obj/effect/spawner/lootdrop/f13/common_ammo = 15,
						/obj/effect/spawner/lootdrop/f13/uncommon_ammo = 15,
						/obj/effect/spawner/lootdrop/f13/trash_ammo = 5,
						),

	LOOT_TIER_MID = list(/obj/effect/spawner/lootdrop/f13/rare_ammo = 10,
						/obj/effect/spawner/lootdrop/f13/uncommon_ammo = 10,
						/obj/effect/spawner/lootdrop/f13/common_ammo = 10,
						),
))

GLOBAL_LIST_INIT(trash_loot_tiers, list(
	LOOT_TIER_LOWEST = list(/obj/effect/spawner/lootdrop/f13/trash),
))

GLOBAL_LIST_INIT(lootable_types, list(
	LOOT_AMMO = GLOB.ammo_loot_tiers,
	LOOT_TRASH = GLOB.trash_loot_tiers,
))

/// These are things in the world that a player could click on to pull loot out of. Lets more than one person loot a place rather than having static loot everywhere.
/obj/structure/lootable
	anchored = TRUE //Always keep this as TRUE
	can_be_unanchored = FALSE //Always keep this as FALSE

	name = "cardboard box"
	desc = "Some kind of cardboard box. I wonder what's inside?"
	icon = 'icons/fallout/objects/crates.dmi'
	icon_state = "smallbox"
	var/icon_state_open = "smallboxopen"
	density = FALSE //May be true depending on what kind of lootable object it is. Cardboard boxes are small and could be easily stepped over so this is FALSE by default.
	/// Should this loot container automatically set its loot tier based on its area / z level / surrounding enemies / etc
	var/dynamic_loot_tier = FALSE
	/// Dynamic loot tiering will override this if it can, so this is just the fallback.
	var/loot_tier = LOOT_TIER_LOWEST
	var/loot_type = LOOT_TRASH
	var/loot_rolls_max = 5
	var/loot_rolls_min = 1
	/// Set to null to not randomize the name.
	var/random_name_list = "cardboard"
	var/random_sound_list = "trash"
	/// Probably set this close to the length of the sound files used.
	var/time_to_loot = 3 SECONDS
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
	///If not null, will subtract by 1 every time it's looted until it's depleted.
	var/uses
	///Can players come back to loot this after a while?
	var/reusable = FALSE

/obj/structure/lootable/Initialize(mapload)
	//Do dynamic loot tier magic here

	//Based on the tier selected (or the static loot tier), generate the name
	name = "[GetLootableNamePrefix()][GetLootableName()]"
	. = ..()

/obj/structure/lootable/attack_hand(mob/user)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("You need a ckey to search the trash! Gratz on not having a ckey, tell a coder about it!"))
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	if(!being_looted)
		playsound(get_turf(src), GetLootingSound(), 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("You start looking through [src] for anything worth taking..."))
	being_looted = TRUE
	if(!do_mob(user, src, time_to_loot, public_progbar = TRUE))
		being_looted = FALSE
		return
	being_looted = FALSE
	if(!reusable && (ukey in loot_players))
		to_chat(user, span_notice("You have already looted [src]."))
		return
	loot_players[ukey] = world.time
	//Switch to the open icon state for a while.
	if(icon_state_open)
		icon_state = icon_state_open
	var/num_loot = rand(loot_rolls_min, loot_rolls_max)
	if(num_loot < 1)
		to_chat(user, span_notice("You didn't find anything useful in [src]."))
		return
	to_chat(user, span_notice("You finish looting through [src]."))
	var/turf/loot_turf = get_turf(user)
	for(var/i=0, i<num_loot, i++ )
		var/list/ourlist = LAZYACCESS(GLOB.lootable_types, loot_type)
		if(LAZYLEN(ourlist))
			var/obj/effect/spawner/lootdrop/L = pickweight(LAZYACCESS(ourlist, loot_tier))
			if(ispath(L))
				L = new L(loot_turf)

	//Inspect our loot pile
	AltClickNoInteract(user, loot_turf)

