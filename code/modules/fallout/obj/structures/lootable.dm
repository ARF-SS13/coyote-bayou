
#define LOOT_TIER_LOWEST 1
#define LOOT_TIER_LOW 2
#define LOOT_TIER_MID 3
#define LOOT_TIER_HIGH 4
#define LOOT_TIER_HIGHEST 5
#define LOOT_TRASH "trash"

GLOBAL_LIST_INIT(lootable_random_names, list(
	"debug" = list("report this as a bug"),
	"cardboard" = list(	"cardboard box",
							"rotten cardboard box",
							"smelly paper box",
							"forgotten cardboard box",
							"pristine box",
							"dusty box",
							"damp box"),
))

GLOBAL_LIST_INIT(lootable_random_sounds, list(
	"debug" = list(),
	"cardboard" = list(),
))

GLOBAL_LIST_INIT(ammo_loot_tiers, list(
	1 = /obj/effect/spawner/lootdrop/f13/common_ammo,
	2 = /obj/effect/spawner/lootdrop/f13/uncommon_ammo,
	3 = /obj/effect/spawner/lootdrop/f13/rare_ammo,
))

GLOBAL_LIST_INIT(trash_loot_tiers, list(
	1 = /obj/effect/spawner/lootdrop/f13/trash,
))

GLOBAL_LIST_INIT(lootable_types, list(
	"ammo" = GLOB.ammo_loot_tiers
	"trash" = GLOB.trash_loot_tiers
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
	var/static_loot_tier = LOOT_TIER_LOWEST
	var/loot_type = LOOT_TRASH
	var/loot_rolls_max = 10
	var/loot_rolls_min = 5
	var/random_name_list = "cardboard"
	var/random_sound_list = "cardboard"
	///Is someone looting this right now?
	var/being_looted = FALSE
	///Players who have recently looted this container
	var/list/loot_players = list()


/obj/item/storage/lootableattack_hand(mob/user)
	var/turf/trash_turf = get_turf(src)
	var/ukey = ckey(user?.ckey)
	if(!ukey)
		to_chat(user, span_alert("You need a ckey to search the trash! Gratz on not having a ckey, tell a coder about it!"))
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	if(!rifling)
		playsound(get_turf(src), 'sound/f13effects/loot_trash.ogg', 100, TRUE, 1)
	to_chat(user, span_smallnoticeital("You start picking through [src]..."))
	rifling = TRUE
	if(!do_mob(user, src, 3 SECONDS))
		rifling = FALSE
		return
	rifling = FALSE
	if(ukey in loot_players)
		to_chat(user, span_notice("You already have looted [src]."))
		return
	loot_players += ukey
	to_chat(user, span_notice("You scavenge through [src]."))
	for(var/i in 1 to rand(1,4))
		var/list/trash_passthru = list()
		var/obj/effect/spawner/lootdrop/f13/trash/pile/my_trash = new(trash_turf)
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
