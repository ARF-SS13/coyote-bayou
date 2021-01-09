/* -------------------------------------------------
   ---------F13 SPAWNERS, READABLE EDITION----------
   -old ported spawners read level is kevcode level-
   --so i just made this new one, based on tg one---
   --oh and, if it rutines about "not enough shit---
   -----------to spawn", it is fine(tm)-------------
 */

//Stop using lootspawners in dungeons improperly. If you put guns in a dungeon, people will want to use them, which will result in them shooting people. You'll have to put in nests or something to constantly give people stuff to shoot at. - Nappist

/obj/effect/spawner/lootdrop/f13
	name = "f13 spawners - DO NOT USE THIS"
	lootdoubles = FALSE	//making sure it will /not/ double

/obj/effect/spawner/lootdrop/f13/discomeme
	name = "dancemachine or piano"
	lootcount = 1
	loot = list(
//				/obj/structure/piano = 3,
				/obj/machinery/jukebox = 1
				)

/obj/effect/spawner/lootdrop/f13/discomeme/Initialize(mapload) //dont want it to init same time as piano
	return

/obj/effect/spawner/lootdrop/f13/discomeme/New()
	..()
	if(loot && loot.len)
		var/turf/T = get_turf(src)
		var/loot_spawned = 0
		while((lootcount-loot_spawned) && loot.len)
			var/lootspawn = pickweight(loot)
			if(!lootdoubles)
				loot.Remove(lootspawn)

			if(lootspawn)
				var/atom/movable/spawned_loot = new lootspawn(T)
				if(pixel_x != 0)
					spawned_loot.pixel_x = pixel_x
				if(pixel_y != 0)
					spawned_loot.pixel_y = pixel_y
			loot_spawned++
		qdel(src) //make sure it is deleted at all cost
	qdel(src)

/* ------------------------------------------------
   ----------------ARMOR SPAWNERS------------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/armor
	name = "armor spawners - DO NOT USE THIS"
	icon_state = "armor_loot"

/* ------------------------------------------------
   ---------------MEDICAL SPAWNERS-----------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/medical
	name = "medical spawners - DO NOT USE THIS"

/obj/effect/spawner/lootdrop/f13/medical/surgical/blood
	name = "blood spawner"
	lootcount = 1

	loot = list(
				/obj/item/reagent_containers/blood/random
				)

/obj/effect/spawner/lootdrop/f13/medical/vault
	name = "vault medical spawner - DO NOT USE"

/obj/effect/spawner/lootdrop/f13/medical/vault/equipment
	name = "vault medical equipment spawner"
	lootcount = 1

	loot = list(
				/obj/item/gun/medbeam,
				/obj/item/defibrillator/compact/combat/loaded,
				/obj/item/reagent_containers/hypospray/combat,
				/obj/item/clothing/glasses/hud/health/night,
				///obj/item/disk/surgery/revival
				)

/obj/effect/spawner/lootdrop/f13/medical/vault/meds  //no drugs, didn't add
	name = "vault medical meds spawner"
	lootcount = 1

	loot = list(
				/obj/item/reagent_containers/hypospray/medipen/stimpak,
				/obj/item/storage/pill_bottle/chem_tin/radx,
				/obj/item/reagent_containers/blood/radaway,
				/obj/item/storage/pill_bottle/chem_tin/mentats,
				/obj/item/storage/pill_bottle/chem_tin/fixer
				)

/obj/effect/spawner/lootdrop/f13/deadrodent_or_brainwashdisk
	name = "100% chance of deceased rodent"
	loot = list(
		/obj/item/reagent_containers/food/snacks/deadmouse = 50)
