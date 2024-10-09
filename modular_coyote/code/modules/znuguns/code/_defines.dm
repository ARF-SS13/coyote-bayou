#define TIER0 1.00 // bad maintenance, poor design, a shortened barrel, or all three.
#define TIER1 1.15 // regular unskilled maintenance, okay design, a standard barrel, or all three.
#define TIER2 1.25 // regular maintenance, respectable design, a standard length or slightly elongated barrel, or all three.
#define TIER3 1.30 // regular skilled maintenance, modern design, a standard length or slightly elongated barrel, or all three.

/obj/item/gun/wirecutter_act(mob/user, obj/item/I)
	. = ..()

	// to_chat(user, "You start to salvage the gun...")
	// if(!do_after(user, 3 SECONDS))
	// 	to_chat(user, "...but you're interrupted!")
	// 	return // I couldn't figure out how to get this to work, it was just immediately interrupting the thing

	if (damage_multiplier == TIER0)
		to_chat(user, span_notice("You realize you can't salvage anything from this!"))

	if (damage_multiplier == TIER1)
		to_chat(user, span_notice("You manage to salvage something!"))
		I.play_tool_sound(src)
		new /obj/effect/spawner/lootdrop/znuguns/mods/tier1 get_turf(src) 
		new /obj/item/gun_upgrade/kittier1 get_turf(src)
		qdel(src)

	if (damage_multiplier == TIER2)
		to_chat(user, span_notice("You manage to salvage something decent!"))
		I.play_tool_sound(src)
		new /obj/effect/spawner/lootdrop/znuguns/mods/tier2 get_turf(src) 
		new /obj/item/gun_upgrade/kittier2 get_turf(src)
		qdel(src)

	if (damage_multiplier == TIER3)
		to_chat(user, span_notice("You manage to salvage something good!"))
		I.play_tool_sound(src)
		new /obj/effect/spawner/lootdrop/znuguns/mods/tier3 get_turf(src) 
		new /obj/item/gun_upgrade/kittier3 get_turf(src)
		qdel(src)
	else
		to_chat(user, span_notice("You realize you can't salvage anything from this!"))

// start of salvage attachment spawners

/obj/effect/spawner/lootdrop/znuguns/mods/tier1
	name = "tier1 attachments"
	loot = list(
		/obj/item/gun_upgrade/gripone = 1,
		/obj/item/gun_upgrade/muzzleone = 1,
		/obj/item/gun_upgrade/triggerone = 1,
		/obj/item/gun_upgrade/sightone = 1,
	)

/obj/effect/spawner/lootdrop/znuguns/mods/tier2
	name = "tier2 attachments"
	loot = list(
		/obj/item/gun_upgrade/griptwo = 1,
		/obj/item/gun_upgrade/muzzletwo = 1,
		/obj/item/gun_upgrade/triggertwo = 1,
		/obj/item/gun_upgrade/sighttwo = 1,
	)

/obj/effect/spawner/lootdrop/znuguns/mods/tier3
	name = "tier3 attachments"
	loot = list(
		/obj/item/gun_upgrade/gripthree = 1,
		/obj/item/gun_upgrade/muzzlethree = 1,
		/obj/item/gun_upgrade/triggerthree = 1,
		/obj/item/gun_upgrade/sightthree = 1,
	)

/obj/item/gun_upgrade/kittier1
	name = "Maintenance Kit"
	desc = "A small tin filled with maintenance supplies like solvents and lubrication. Class 1."
	icon_state = "weintraub"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun_upgrade/kittier1/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = TIER1
	)
	I.req_gun_tags = null
	I.gun_loc_tag = GUN_MECHANISM

/obj/item/gun_upgrade/kittier2
	name = "Upgrade Kit"
	desc = "A small tin filled with average quality parts. Class 2."
	icon_state = "overshooter"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun_upgrade/kittier2/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = TIER2
	)
	I.req_gun_tags = null
	I.gun_loc_tag = GUN_MECHANISM

/obj/item/gun_upgrade/kittier3
	name = "Upgrade Kit"
	desc = "A small tin filled with specialized furniture and internals. Class 3."
	icon_state = "reverse_loader"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun_upgrade/kittier3/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = TIER3
	)
	I.req_gun_tags = null
	I.gun_loc_tag = GUN_MECHANISM
