//Tiers of loot
///Trash tier
#define LOOT_TIER_LOWEST 1
///Common tier
#define LOOT_TIER_LOW 2
///Uncommon tier
#define LOOT_TIER_MID 3
///Rare tier
#define LOOT_TIER_HIGH 4
///Very Rare tier
#define LOOT_TIER_HIGHEST 5


//Types of loot
//trash
#define LOOT_TRASH "trash"
//military
#define LOOT_AMMO "ammo"
#define LOOT_ARMOR "armor"
#define LOOT_WEAPONS "weapons" //A combination of guns and melee weapons
#define LOOT_GUNS "guns" //Just gun-type weapons
#define LOOT_BALLISTIC "ballistic guns"
#define LOOT_LASERS "energy guns"
#define LOOT_MELEE "melee"
//household
#define LOOT_KITCHEN "kitchen" //food, cookware, etc
#define LOOT_CLOTHES "clothes"
//farm
#define LOOT_FARM "farm" //Farming tools, cowboy weapons and clothes
#define LOOT_PLANTS "plants" //Seeds, grown stuff, fertilizer, water, etc.
//job specific
#define LOOT_MECHANIC "mechanic" //mostly tools
#define LOOT_ELECTRICAL "electrical" //circuit boards, batteries, wires, etc. Things you could find in consumer electronics like televisions and fridges
#define LOOT_SCIENCE "science" //gadgets and gizmos, futuristic stuff, research materials
//medical
#define LOOT_FIRSTAID "first aid"
#define LOOT_SURGERY "surgery"
//others
#define LOOT_CONVENIENCE_STORE "convenience store"
#define LOOT_CHURCH "church"
#define LOOT_SCHOOL "school"
#define LOOT_HOBO "hobo"
#define LOOT_ORE "ore" //abandoned ore boxes
#define LOOT_HIDDEN_STASH "hidden stash" //Could be anything

/// These are things in the world that a player could click on to pull loot out of. Lets more than one person loot a place rather than having static loot everywhere.
/obj/structure/lootable
	anchored = TRUE //Always keep this as TRUE
	can_be_unanchored = FALSE //Always keep this as FALSE

	name = "cardboard box"
	desc = "I wonder what's inside?"
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
	///Players who have recently looted this container. You can't loot it again if you're on this list.
	var/list/loot_players = list()
	/// If true, will try and fill up our inventory until we're full, then spit our loot out if we have to.
	var/place_loot_inside = FALSE
	///If not null, will subtract by 1 every time it's looted until it's depleted.
	var/uses
	///Can players come back to loot this after a while?
	var/reusable = FALSE
	///If this can be re-lootable later, how long do we wait?
	var/reusable_cooldown = 1 MINUTES

/obj/structure/lootable/Initialize(mapload)
	//Do dynamic loot tier magic here

	//Based on the tier selected (or the static loot tier), generate the name
	name = "[GetLootableNamePrefix()][GetLootableName()]"
	. = ..()

/obj/structure/lootable/attack_hand(mob/user)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("You need a ckey to search this! Gratz on not having a ckey, tell a coder about it!"))
	if(ukey in loot_players)
		if(!reusable)
			to_chat(user, span_notice("You've already looted [src]. A fresh pair of eyes might be able to find more..."))
			return
		else if((world.time - loot_players[ukey]) < reusable_cooldown)
			to_chat(user, span_notice("You have already looted [src] too recently...."))
			return
	if(!being_looted)
		playsound(get_turf(src), GetLootingSound(), 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("You start looking through [src] for anything worth taking..."))
	being_looted = TRUE
	if(!do_mob(user, src, time_to_loot, public_progbar = TRUE))
		being_looted = FALSE
		return
	being_looted = FALSE
	loot_players[ukey] = world.time
	//Switch to the open icon state for a while.
	if(icon_state_open)
		icon_state = icon_state_open
	var/num_loot = rand(loot_rolls_min, loot_rolls_max)
	if(num_loot < 1 || (!isnull(uses) && uses < 1))
		to_chat(user, span_notice("You didn't find anything useful in [src]."))
		return
	to_chat(user, span_notice("You finish searching [src]."))
	var/turf/loot_turf = get_turf(user)
	for(var/i=0, i<num_loot, i++ )
		var/list/ourlist = LAZYACCESS(GLOB.lootable_types, loot_type)
		if(LAZYLEN(ourlist))
			var/obj/effect/spawner/lootdrop/L = pickweight(LAZYACCESS(ourlist, loot_tier))
			if(ispath(L))
				L = new L(loot_turf)

	//Inspect our loot pile automatically
	AltClickNoInteract(user, loot_turf)

	if(uses > 0)
		uses--
	if(uses <= 0)
		qdel(src)

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

/// AMMO ///
GLOBAL_LIST_INIT(trash_loot_tiers, list(
	LOOT_TIER_LOWEST = list(/obj/effect/spawner/lootdrop/f13/trash = 25),
	LOOT_TIER_LOW = list(/obj/effect/spawner/lootdrop/f13/trash = 25),
	LOOT_TIER_MID = list(/obj/effect/spawner/lootdrop/f13/trash = 25),
	LOOT_TIER_HIGH = list(/obj/effect/spawner/lootdrop/f13/trash = 25),
	LOOT_TIER_HIGHEST = list(/obj/effect/spawner/lootdrop/f13/trash = 25),
))

/// AMMO ///
GLOBAL_LIST_INIT(ammo_loot_tiers, list(
	LOOT_TIER_LOWEST = list(/obj/item/salvage/ammo = 10),

	LOOT_TIER_LOW = list(/obj/item/salvage/ammo = 10),

	LOOT_TIER_MID = list(/obj/item/salvage/ammo = 10),
	LOOT_TIER_HIGH = list(/obj/item/salvage/ammo = 10),
	LOOT_TIER_HIGHEST = list(/obj/item/salvage/ammo = 10),
))

				/// GUNS ///
/// Includes both energy and ballistics ///
GLOBAL_LIST_INIT(gun_loot_tiers, list(
	LOOT_TIER_LOWEST = list(
						/obj/effect/spawner/lootdrop/f13/common_weps = 5,
						),

	LOOT_TIER_LOW = list(
						/obj/effect/spawner/lootdrop/f13/common_weps = 25,
						/obj/effect/spawner/lootdrop/f13/uncommon_weps = 5,
						),

	LOOT_TIER_MID = list(
						/obj/effect/spawner/lootdrop/f13/common_weps = 5,
						/obj/effect/spawner/lootdrop/f13/uncommon_weps = 25,
						/obj/effect/spawner/lootdrop/f13/rare_weps = 5,
						),
	LOOT_TIER_HIGH = list(
						/obj/effect/spawner/lootdrop/f13/uncommon_weps = 5,
						/obj/effect/spawner/lootdrop/f13/rare_weps = 25,
						/obj/effect/spawner/lootdrop/f13/very_rare = 5,
						),
	LOOT_TIER_HIGHEST = list(
						/obj/effect/spawner/lootdrop/f13/rare_weps = 5,
						/obj/effect/spawner/lootdrop/f13/very_rare = 25,
						),
))

				/// Clothes ///
GLOBAL_LIST_INIT(clothes_loot_tiers, list(
	LOOT_TIER_LOWEST = list(
						/obj/effect/spawner/lootdrop/f13/clothes = 25
						),
	LOOT_TIER_LOW = list(
						/obj/effect/spawner/lootdrop/f13/clothes = 25
						),
	LOOT_TIER_MID = list(
						/obj/effect/spawner/lootdrop/f13/clothes = 25
						),
	LOOT_TIER_HIGH = list(
						/obj/effect/spawner/lootdrop/f13/clothes = 25
						),
	LOOT_TIER_HIGHEST = list(
						/obj/effect/spawner/lootdrop/f13/clothes = 25
						),
))

				/// electrical ///
GLOBAL_LIST_INIT(electrical_loot_tiers, list(
	LOOT_TIER_LOWEST = list(
						/obj/effect/spawner/lootdrop/f13/trash_parts = 10,
						/obj/effect/spawner/lootdrop/f13/electrical = 25,
						),
	LOOT_TIER_LOW = list(
						/obj/effect/spawner/lootdrop/f13/common_parts = 10,
						/obj/effect/spawner/lootdrop/f13/electrical = 25,
						),
	LOOT_TIER_MID = list(
						/obj/effect/spawner/lootdrop/f13/common_parts = 5,
						/obj/effect/spawner/lootdrop/f13/electrical = 25,
						/obj/effect/spawner/lootdrop/f13/uncommon_parts = 5,
						),
	LOOT_TIER_HIGH = list(
						/obj/effect/spawner/lootdrop/f13/electrical = 25,
						/obj/effect/spawner/lootdrop/f13/uncommon_parts = 10,
						),
	LOOT_TIER_HIGHEST = list(
						/obj/effect/spawner/lootdrop/f13/electrical = 25,
						/obj/effect/spawner/lootdrop/f13/rare_parts = 10,
						),
))

				/// hidden stashes ///
GLOBAL_LIST_INIT(hiddenstash_loot_tiers, list(
	LOOT_TIER_LOWEST = list(
						/obj/effect/spawner/lootdrop/f13/trash = 1,
						/obj/effect/spawner/lootdrop/f13/common = 3,
						/obj/effect/spawner/lootdrop/f13/uncommon = 5,
						/obj/effect/spawner/lootdrop/f13/rare = 1,
						),
	LOOT_TIER_LOW = list(
						/obj/effect/spawner/lootdrop/f13/trash = 1,
						/obj/effect/spawner/lootdrop/f13/common = 3,
						/obj/effect/spawner/lootdrop/f13/uncommon = 5,
						/obj/effect/spawner/lootdrop/f13/rare = 1,
						),
	LOOT_TIER_MID = list(
						/obj/effect/spawner/lootdrop/f13/trash = 1,
						/obj/effect/spawner/lootdrop/f13/common = 3,
						/obj/effect/spawner/lootdrop/f13/uncommon = 5,
						/obj/effect/spawner/lootdrop/f13/rare = 3,
						),
	LOOT_TIER_HIGH = list(
						/obj/effect/spawner/lootdrop/f13/trash = 1,
						/obj/effect/spawner/lootdrop/f13/common = 3,
						/obj/effect/spawner/lootdrop/f13/uncommon = 5,
						/obj/effect/spawner/lootdrop/f13/rare = 3,
						),
	LOOT_TIER_HIGHEST = list(
						/obj/effect/spawner/lootdrop/f13/trash = 1,
						/obj/effect/spawner/lootdrop/f13/common = 3,
						/obj/effect/spawner/lootdrop/f13/uncommon = 5,
						/obj/effect/spawner/lootdrop/f13/rare = 4,
						),
))

GLOBAL_LIST_INIT(lootable_types, list(
	LOOT_AMMO = GLOB.ammo_loot_tiers,
	LOOT_TRASH = GLOB.trash_loot_tiers,
	LOOT_GUNS = GLOB.gun_loot_tiers,
	LOOT_CLOTHES = GLOB.clothes_loot_tiers,
	LOOT_ELECTRICAL = GLOB.electrical_loot_tiers,
	LOOT_HIDDEN_STASH = GLOB.hiddenstash_loot_tiers,
))


//TODO: move this to another file
/obj/structure/lootable/hidden_stash
	name = "hidden stash"
	desc = "Maybe I can find something to wear in here..."
	icon = 'modular_coyote/icons/objects/paxilmaniacpak/loot_structures.dmi'
	icon_state = "cache"
	loot_tier = LOOT_TIER_MID
	loot_type = LOOT_HIDDEN_STASH
	var/randomize_loot_tier = TRUE
	icon_state_open = null
	loot_rolls_max = 12
	loot_rolls_min = 6
	alpha = 128 //hehe
	uses = 1

/obj/structure/lootable/hidden_stash/Initialize(mapload)
	if(randomize_loot_tier)
		loot_tier = rand(LOOT_TIER_LOWEST, LOOT_TIER_HIGHEST)
	. = ..()
