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

/obj/effect/spawner/lootdrop/f13/armor/clothes
	name = "pre-war clothes spawner"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/under/overalls,
				/obj/item/clothing/head/flatcap
				)
	var/loot2 = list(
				/obj/item/clothing/under/plaid_skirt/green,
				/obj/item/clothing/under/plaid_skirt/purple
				)
	var/loot3 = list(
				/obj/item/clothing/under/blacktango,
				""
				)
	var/loot4 = list(
				/obj/item/clothing/under/redeveninggown,
				""
				)
	var/loot5 = list(
				/obj/item/clothing/under/janimaid,
				""
				)
	var/loot6 = list(
				/obj/item/clothing/suit/jacket/leather,
				/obj/item/clothing/gloves/fingerless
				)
	var/loot7 = list(
				/obj/item/clothing/suit/jacket/puffer/vest,
				/obj/item/clothing/under/pants/jeans,
				/obj/item/clothing/neck/cloak/grey
				)
	var/loot8 = list(
				/obj/item/clothing/under/suit_jacket/charcoal,
				/obj/item/clothing/head/that
				)
	var/loot9 = list(
				/obj/item/clothing/under/suit_jacket/checkered, // It's Benny time!
				/obj/item/clothing/shoes/laceup
				)
	var/loot10 = list(
				/obj/item/clothing/under/suit_jacket/burgundy,
				/obj/item/clothing/shoes/laceup,
				/obj/item/clothing/neck/cloak
				)
	var/loot11 = list(
				/obj/item/clothing/under/scratch,
				/obj/item/clothing/shoes/sneakers/white
				)
	var/loot12 = list(
				/obj/item/clothing/head/beanie/black,
				/obj/item/clothing/suit/hooded/chaplain_hoodie
				)
	var/loot13 = list(
				/obj/item/clothing/under/pants/camo,
				""
				)
	var/loot14 = list(
				/obj/item/clothing/suit/apron/purple_bartender,
				/obj/item/clothing/under/rank/bartender/purple
				)
	var/loot15 = list(
				/obj/item/clothing/under/plaid_skirt/blue,
				/obj/item/clothing/under/plaid_skirt
				)
	var/loot16 = list(
				/obj/item/clothing/under/suit_jacket/navy,
				/obj/item/clothing/shoes/laceup
				)
	var/loot17 = list(
				/obj/item/clothing/under/suit_jacket/female,
				/obj/item/clothing/shoes/laceup
				)
	var/loot18 = list(
				/obj/item/clothing/under/f13/erpdress,
				/obj/item/clothing/shoes/laceup
				)

/obj/effect/spawner/lootdrop/f13/armor/clothes/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10, loot11, loot12, loot13, loot14, loot15, loot16, loot17, loot18)
	. = ..()

/obj/effect/spawner/lootdrop/f13/armor/costumes
	name = "pre-war costumes spawner"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/head/ushanka,
				/obj/item/clothing/under/soviet,
				/obj/item/clothing/neck/cloak/grey
				)
	var/loot2 = list(
				/obj/item/clothing/under/geisha,
				/obj/item/clothing/shoes/sandal
				)
	var/loot3 = list(
				/obj/item/clothing/under/blacktango,
				""
				)
	var/loot4 = list(
				/obj/item/clothing/under/redeveninggown,
				""
				)
	var/loot5 = list(
				/obj/item/clothing/head/sombrero,
				/obj/item/clothing/suit/poncho
				)
	var/loot6 = list(
				/obj/item/clothing/under/sailor,
				""
				)
	var/loot7 = list(
				/obj/item/clothing/under/schoolgirl/red,
				/obj/item/clothing/under/schoolgirl
				)
	var/loot8 = list(
				/obj/item/clothing/head/fluff/bandit,
				/obj/item/clothing/head/fluff/gambler
				)
	var/loot9 = list(
				/obj/item/clothing/under/jabroni,
				/obj/item/clothing/glasses/sunglasses/blindfold
				)
	var/loot10 = list(
				/obj/item/clothing/under/gladiator,
				/obj/item/clothing/shoes/roman
				)
	var/loot11 = list(
				/obj/item/clothing/under/maid,
				""
				)
	var/loot12 = list(
				/obj/item/clothing/under/draculass,
				/obj/item/clothing/neck/cloak/grey,
				""
				)
	var/loot13 = list(
				/obj/item/clothing/under/kilt,
				""
				)
	var/loot14 = list(
				/obj/item/clothing/under/pirate,
				/obj/item/clothing/suit/pirate
				)

/obj/effect/spawner/lootdrop/f13/armor/costumes/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10, loot11, loot12, loot13, loot14)
	. = ..()


/obj/effect/spawner/lootdrop/f13/armor/tier1 //TIER 1 ARMOR
	name = "tier 1 armor"
	lootcount = 2 //guranteeing it /will/ spawn
	var/loot1 = list(
				/obj/item/clothing/suit/armor/f13/leather_jacket,
				""
				)
				//"" returns absolutley nothing
	var/loot2 = list(
				/obj/item/clothing/suit/armor/f13/kit,
				""
				)
	var/loot3 = list(
				/obj/item/clothing/suit/armor/f13/raider/supafly,
				/obj/item/clothing/head/helmet/f13/raider
				)
	var/loot4 = list(
				/obj/item/clothing/suit/armor/f13/raider/sadist,
				/obj/item/clothing/head/helmet/f13/raider/arclight
				)
	var/loot5 = list(
				/obj/item/clothing/suit/armor/f13/raider/blastmaster,
				/obj/item/clothing/head/helmet/f13/raider/blastmaster
				)
	var/loot6 = list(
				/obj/item/clothing/suit/armor/f13/raider/yankee,
				/obj/item/clothing/head/helmet/f13/raider/yankee
				)
	var/loot7 = list(
				/obj/item/clothing/head/helmet/f13/fiend
				)
	var/loot8 = list(
				/obj/item/clothing/suit/armor/f13/raider/painspike,
				/obj/item/clothing/head/helmet/f13/raider/psychotic
				)
	var/loot9 = list(
				/obj/item/clothing/suit/armor/f13/raider/supafly,
				/obj/item/clothing/head/helmet/f13/raider
				)
	var/loot10 = list(
				/obj/item/clothing/suit/f13/duster,
				""
				)
	var/loot11 = list(
				/obj/item/clothing/suit/armor/f13/raider/iconoclast,
				""
				)

/obj/effect/spawner/lootdrop/f13/armor/tier1/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10, loot11)
	. = ..()

/obj/effect/spawner/lootdrop/f13/armor/tier2 //TIER 2 ARMOR
	name = "tier 2 armor"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/suit/armor/f13/metalarmor,
				/obj/item/clothing/head/helmet/knight/fluff/metal
				)

	var/loot2 = list(
				/obj/item/clothing/suit/armor/f13/metalarmor,
				/obj/item/clothing/head/helmet/f13/metalmask
				)

	var/loot3 = list(
				/obj/item/clothing/suit/armor/f13/leatherarmor,
				""
				)
	var/loot4 = list(
				/obj/item/clothing/suit/armor/f13/leather_jacket/combat,
				""
				)
	var/loot5 = list(
				/obj/item/clothing/suit/armor/f13/leather_jacket/combat/coat,
				)

/obj/effect/spawner/lootdrop/f13/armor/tier2/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5)
	. = ..()

/obj/effect/spawner/lootdrop/f13/armor/tier3 //TIER 3 ARMOR
	name = "tier 3 armor"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/suit/armor/f13/metalarmor/reinforced,
				/obj/item/clothing/head/helmet/f13/metalmask/mk2
				)
	var/loot2 = list(
				/obj/item/clothing/suit/armor/f13/metalarmor/strange,
				/obj/item/clothing/head/helmet/knight/fluff/metal/strange
				)
	var/loot3 = list(
				/obj/item/clothing/suit/armor/f13/leather_jacket/combat/coat,
				)
	var/loot4 = list(
				/obj/item/clothing/head/helmet/f13/combat/swat,
				/obj/item/clothing/suit/armor/f13/combat/swat
				)
	var/loot5 = list(
				/obj/item/clothing/suit/armor/f13/combat,
				/obj/item/clothing/head/helmet/f13/combat
				)
	var/loot6 = list(
				/obj/item/clothing/suit/armor/bulletproof,
				/obj/item/clothing/head/helmet/alt
				)
	var/loot7 = list(
				/obj/item/clothing/suit/armor/f13/combat/dark,
				/obj/item/clothing/head/helmet/f13/combat/dark
				)
	var/loot8 = list(
				/obj/item/clothing/suit/armor/f13/combat/mk2/dark,
				/obj/item/clothing/head/helmet/f13/combat/mk2/dark
				)
	var/loot9 = list(
				/obj/item/clothing/suit/armor/f13/sulphitearmor,
				/obj/item/clothing/head/helmet/f13/sulphitehelm
				)

/obj/effect/spawner/lootdrop/f13/armor/tier3/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9)
	. = ..()

/obj/effect/spawner/lootdrop/f13/armor/tier4 //TIER 4 ARMOR
	name = "tier 4 armor"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/head/helmet/f13/power_armor/t45b,
				/obj/item/clothing/suit/armor/f13/power_armor/t45b
				)
	var/loot2 = list(
				/obj/item/clothing/suit/armor/f13/leather_jacket/combat/riotpolice,
				/obj/item/clothing/head/helmet/f13/rangerbroken
				)
	var/loot3 = list(
				/obj/item/clothing/suit/armor/f13/combat/mk2,
				/obj/item/clothing/head/helmet/f13/combat/mk2
				)
	var/loot4 = list(
				/obj/item/clothing/suit/armor/f13/power_armor/raiderpa,
				/obj/item/clothing/head/helmet/f13/power_armor/raiderpa_helm
				)
	var/loot5 = list(
				/obj/item/clothing/suit/armor/f13/power_armor/hotrod,
				/obj/item/clothing/head/helmet/f13/power_armor/hotrod
				)

/obj/effect/spawner/lootdrop/f13/armor/tier4/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5)
	. = ..()


/obj/effect/spawner/lootdrop/f13/armor/tier5 //TIER 5 ARMOR
	name = "tier 5 armor"
	lootcount = 2
	var/loot1 = list(
				/obj/item/clothing/suit/armor/f13/power_armor/t45d,
				/obj/item/clothing/head/helmet/f13/power_armor/t45d
				)
	var/loot2 = list(
				/obj/item/clothing/suit/armor/f13/power_armor/t51b,
				/obj/item/clothing/head/helmet/f13/power_armor/t51b
				)

/obj/effect/spawner/lootdrop/f13/armor/tier5/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2)
	. = ..()

/obj/effect/spawner/lootdrop/f13/armor/random
    name = "random armor loot"
    lootcount = 1

    loot = list(
            /obj/effect/spawner/lootdrop/f13/armor/tier1 = 80,
            /obj/effect/spawner/lootdrop/f13/armor/tier2 = 19,
            /obj/effect/spawner/lootdrop/f13/armor/tier3 = 1,
            )

/obj/effect/spawner/lootdrop/f13/armor/random_high
    name = "high tier random armor loot"
    lootcount = 1

    loot = list(
            /obj/effect/spawner/lootdrop/f13/armor/tier2 = 59,
            /obj/effect/spawner/lootdrop/f13/armor/tier3 = 30,
            /obj/effect/spawner/lootdrop/f13/armor/tier4 = 10,
            /obj/item/ring = 1 //one ring to rule them all
            )

/* ------------------------------------------------
   ---------------MEDICAL SPAWNERS-----------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/medical
	name = "medical spawners - DO NOT USE THIS"

/obj/effect/spawner/lootdrop/f13/medical/surgical
	name = "surgical item spawner"
	lootcount = 1

	loot = list(
				/obj/item/hemostat,
				/obj/item/surgicaldrill,
				/obj/item/retractor,
				/obj/item/cautery,
				/obj/item/scalpel,
				/obj/item/clothing/suit/apron/surgical,
				/obj/item/clothing/gloves/color/latex,
				/obj/item/clothing/mask/surgical,
				/obj/item/surgical_drapes,
				/obj/item/circular_saw
				)

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

/obj/effect/spawner/lootdrop/f13/medical/wasteland
	name = "wasteland medical spawner - DO NOT USE"

/obj/effect/spawner/lootdrop/f13/medical/wasteland/meds //remove equipment, has nothing on it
	name = "wasteland meds spawner"
	lootcount = 1

	loot = list(/obj/item/reagent_containers/pill/patch/healingpowder,
				/obj/item/storage/pill_bottle/chem_tin/radx,
				/obj/item/reagent_containers/blood/radaway,
				/obj/item/storage/pill_bottle/chem_tin/mentats,
				/obj/item/storage/pill_bottle/chem_tin/fixer,
				/obj/item/reagent_containers/hypospray/medipen/stimpak,
				/obj/item/reagent_containers/medspray/styptic,
				/obj/item/reagent_containers/medspray/silver_sulf,
				/obj/item/reagent_containers/medspray/sterilizine
				)

/obj/effect/spawner/lootdrop/f13/medical/wasteland/meds/drug //remove equipment, has nothing on it
	name = "wasteland drugs spawner"
	lootcount = 1

	loot = list(
				/obj/item/reagent_containers/pill/patch/jet,
				/obj/item/reagent_containers/pill/patch/turbo,
				/obj/item/reagent_containers/pill/patch/healingpowder,
				/obj/item/reagent_containers/pill/stimulant,
				/obj/item/reagent_containers/syringe/medx
				)
/* ------------------------------------------------
   --------------WEAPON SPAWNERS-------------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon
	name = "weapon spawners - DO NOT USE THIS"
	icon_state = "gun_loot"

/* ------------------------------------------------
   -----------MELEE WEAPON SPAWNERS----------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon/melee
	name = "melee spawners - DO NOT USE THIS"
	icon_state = "melee_loot"

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier1 //TIER 1 MELEE WEAPON
	name = "tier 1 melee"
	lootcount = 1

	loot = list(
				/obj/item/crowbar,
				/obj/item/extinguisher,
				/obj/item/hatchet,
				/obj/item/pickaxe/mini,
				/obj/item/wrench,
				/obj/item/kitchen/knife,
				/obj/item/kitchen/rollingpin,
				)


/obj/effect/spawner/lootdrop/f13/weapon/melee/tier2 //TIER 2 MELEE WEAPON
	name = "tier 2 melee"
	lootcount = 1

	loot = list(
				/obj/item/gavelhammer,
				/obj/item/oar,
				/obj/item/pickaxe,
				/obj/item/shovel,
				/obj/item/switchblade,
				/obj/item/throwing_star/spear,
				/obj/item/surgicaldrill,
				/obj/item/kitchen/knife/combat,
				/obj/item/kitchen/knife/combat/survival,
				/obj/item/kitchen/knife/combat/bone,
				/obj/item/instrument/guitar,
				/obj/item/instrument/violin,
				/obj/item/instrument/saxophone,
				/obj/item/claymore/machete/pipe,
				/obj/item/kitchen/knife/cosmicdirty,
				/obj/item/melee/unarmed/brass,
				/obj/item/melee/unarmed/brass/spiked
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 //TIER 3 MELEE WEAPON
	name = "tier 3 melee"
	lootcount = 1

	loot = list(
				/obj/item/weldingtool,
				/obj/item/twohanded/spear,
				/obj/item/bostaff,
				/obj/item/baseball,
				/obj/item/kitchen/knife/butcher,
				/obj/item/claymore/machete/golf,
				/obj/item/claymore/machete,
				/obj/item/claymore/machete/reinforced,
				/obj/item/shield/legion/buckler,
				/obj/item/melee/unarmed/tigerclaw,
				/obj/item/melee/unarmed/bladed,
				/obj/item/melee/unarmed/sappers
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 //TIER 4 MELEE WEAPON
	name = "tier 4 melee"
	lootcount = 1

	loot = list(
				/obj/item/fireaxe,
				/obj/item/sledgehammer,
				/obj/item/fireaxe/bmprsword,
				/obj/item/melee/unarmed/lacerator,
				/obj/item/melee/unarmed/maceglove,
				/obj/item/melee/unarmed/punchdagger,
				/obj/item/shield/riot
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier5 //TIER 5 MELEE WEAPON
	name = "tier 5 melee"
	lootcount = 1

	loot = list(
				/obj/item/twohanded/required/thermic_lance,
				/obj/item/chainsaw,
				/obj/item/kinetic_crusher,
				/obj/item/nullrod/claymore/chainsaw_sword,
				/obj/item/melee/powerfist,
				/obj/item/melee/transforming/energy/axe,
				/obj/item/gun/ballistic/revolver/ballisticfist,
				/obj/item/sledgehammer/supersledge,
				/obj/item/shishkebabpack,
				/obj/item/melee/unarmed/deathclawgauntlet,
				/obj/item/melee/powerfist/moleminer
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/random
    name = "random melee loot"
    lootcount = 1

    loot = list(
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier1 = 40,
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier2 = 30,
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 = 20,
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 = 10,
            )

/obj/effect/spawner/lootdrop/f13/weapon/melee/random_high
    name = "high tier random melee loot"
    lootcount = 1

    loot = list(
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 = 45,
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 = 35,
            /obj/effect/spawner/lootdrop/f13/weapon/melee/tier5 = 20
            )

/* ------------------------------------------------
   -------------GUN WEAPON SPAWNERS----------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon/gun
	name = "gun spawners - DO NOT USE THIS"
	icon_state = "gun_loot"

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier1 //TIER 1 GUN
	name = "tier 1 gun"
	lootcount = 3
	var/loot1 = list(
				/obj/item/gun/ballistic/revolver/single_shotgun,
				/obj/item/storage/box/rubbershot/beanbag,
				""
				)

	var/loot2 = list(
				/obj/item/gun/ballistic/revolver/caravan_shotgun,
				/obj/item/storage/box/rubbershot/beanbag,
				""
				)

	var/loot3 = list(
				/obj/item/gun/ballistic/shotgun/boltaction,
				/obj/item/ammo_box/a762,
				//obj/item/ammo_box/a762
				)

	var/loot4 = list(
				/obj/item/gun/ballistic/revolver/zipgun,
				"",
				""
				)

	var/loot5 = list(
				/obj/item/gun/ballistic/revolver/pipe_rifle,
				"",
				""
				)

	var/loot6 = list(
				/obj/item/gun/ballistic/shotgun/remington,
				/obj/item/ammo_box/a308,
				//obj/item/ammo_box/a308
				)

	var/loot7 = list(
				/obj/item/gun/ballistic/automatic/pistol/n99,
				/obj/item/ammo_box/magazine/m10mm_adv,
				//obj/item/ammo_box/magazine/m10mm_adv
				)

	var/loot8 = list(
				/obj/item/gun/ballistic/automatic/pistol/m1911,
				/obj/item/ammo_box/magazine/m45,
				//obj/item/ammo_box/magazine/m45
				)

	var/loot9 = list(
				/obj/item/gun/ballistic/automatic/pistol/ninemil,
				/obj/item/ammo_box/magazine/m9mm,
				//obj/item/ammo_box/magazine/m9mm
				)

	var/loot10 = list(
				/obj/item/gun/ballistic/revolver/colt6250,
				/obj/item/ammo_box/l10mm,
				//obj/item/ammo_box/l10mm
				)

	var/loot11 = list(
				/obj/item/gun/ballistic/automatic/varmint,
				//obj/item/ammo_box/magazine/m556/rifle/small,
				/obj/item/ammo_box/magazine/m556/rifle/small)

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier1/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10, loot11)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier2 //TIER 2 GUN
	name = "tier 2 gun"
	lootcount = 3

	var/loot1 = list(
				/obj/item/gun/ballistic/shotgun/hunting,
				/obj/item/storage/box/lethalshot,
				""
				)

	var/loot2 = list(
				/obj/item/gun/ballistic/revolver/m29,
				/obj/item/ammo_box/m44,
				//obj/item/ammo_box/m44
				)

	var/loot3 = list(
				/obj/item/gun/ballistic/shotgun/remington/scoped,
				//obj/item/ammo_box/a308,
				/obj/item/ammo_box/a308
				)

	var/loot4 = list(
				/obj/item/gun/ballistic/revolver/m29/scoped,
				//obj/item/ammo_box/m44,
				/obj/item/ammo_box/m44
				)

	var/loot5 = list(/obj/item/gun/ballistic/shotgun/automatic/hunting/cowboy,
				//obj/item/ammo_box/tube/a357,
				/obj/item/ammo_box/a357
				)

	var/loot6 = list(/obj/item/gun/ballistic/shotgun/automatic/hunting/cowboy/scoped,
				//obj/item/ammo_box/tube/a357,
				/obj/item/ammo_box/a357
				)

	var/loot7 = list(/obj/item/gun/ballistic/revolver/colt357,
				//obj/item/ammo_box/a357,
				/obj/item/ammo_box/a357
				)

	var/loot8 = list(
				/obj/item/gun/ballistic/automatic/marksman/servicerifle,
				//obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/magazine/m556/rifle
				)

	var/loot9 = list(
				/obj/item/gun/ballistic/revolver/police,
				//obj/item/ammo_box/a357,
				/obj/item/ammo_box/a357
	)
	var/loot10 = list(
				/obj/item/gun/energy/laser/pistol,
				/obj/item/stock_parts/cell/ammo/ec,
				""
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier2/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier3 //TIER 3 GUN
	name = "tier 3 gun"
	lootcount = 3

	var/loot1 = list(
				/obj/item/gun/ballistic/automatic/mini_uzi,
				/obj/item/ammo_box/magazine/uzim9mm,
				//obj/item/ammo_box/magazine/uzim9mm
				)

	var/loot2 = list(
				/obj/item/gun/ballistic/automatic/smg10mm,
				//obj/item/ammo_box/magazine/m10mm_auto,
				/obj/item/ammo_box/magazine/m10mm_auto
				)

	var/loot3 = list(
				/obj/item/gun/ballistic/automatic/greasegun,
				//obj/item/ammo_box/magazine/greasegun,
				/obj/item/ammo_box/magazine/greasegun
				)

	var/loot4 = list(
				/obj/item/gun/ballistic/shotgun/trench,
				/obj/item/storage/box/lethalshot,
				)

	var/loot5 = list(
				/obj/item/gun/energy/laser/wattz,
				/obj/item/stock_parts/cell/ammo/ec,
				""
				)

	var/loot6 = list(
				/obj/item/gun/ballistic/revolver/needler,
				//obj/item/ammo_box/needle,
				/obj/item/ammo_box/needle
				)

	var/loot7 = list(
				/obj/item/gun/ballistic/shotgun/automatic/hunting/trail,
			    //obj/item/ammo_box/tube/m44,
				/obj/item/ammo_box/tube/m44
				)

	var/loot8 = list(
				/obj/item/gun/ballistic/shotgun/automatic/hunting/trail/scoped,
				//obj/item/ammo_box/tube/m44,
				/obj/item/ammo_box/tube/m44
				)
	var/loot9 = list(
				/obj/item/gun/energy/laser/aer9,
				/obj/item/stock_parts/cell/ammo/mfc,
				""
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier3/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier4 //TIER 4 GUN
	name = "tier 4 gun"
	lootcount = 3
	var/loot1 = list(
				/obj/item/gun/ballistic/automatic/assault_rifle,
				//obj/item/ammo_box/magazine/m556/rifle/assault,
				/obj/item/ammo_box/magazine/m556/rifle/assault
				)

	var/loot2 = list(
				/obj/item/gun/ballistic/automatic/marksman,
				//obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/magazine/m556/rifle
				)

	var/loot3 = list(
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/ammo_box/magazine/a50,
				//obj/item/ammo_box/magazine/a50
				)

	var/loot4 = list(
				/obj/item/gun/energy/laser/rcw,
				/obj/item/stock_parts/cell/ammo/ecp,
				""
				)

	var/loot5 = list(
				/obj/item/gun/energy/laser/plasma/pistol,
				/obj/item/stock_parts/cell/ammo/ec,
				""
				)

	var/loot6 = list(
				/obj/item/gun/energy/laser/aer9,
				/obj/item/stock_parts/cell/ammo/mfc,
				""
				)

	var/loot7 = list(
				/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator,
				//obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/magazine/m556/rifle
				)

	var/loot8 = list(
				 /obj/item/gun/ballistic/shotgun/automatic/hunting/brush,
				 //obj/item/ammo_box/tube/c4570,
				 /obj/item/ammo_box/tube/c4570
				 )

	var/loot9 = list(
				/obj/item/gun/ballistic/shotgun/automatic/hunting/brush/scoped,
				/obj/item/ammo_box/tube/c4570,
				//obj/item/ammo_box/tube/c4570,
				""
				)

	var/loot10 = list(
				/obj/item/gun/ballistic/shotgun/antimateriel,
				//obj/item/ammo_box/a50MG,
				/obj/item/ammo_box/a50MG,
				""
				)

	var/loot11 = list(
				/obj/item/gun/ballistic/automatic/rangemaster,
				//obj/item/ammo_box/magazine/m762,
				/obj/item/ammo_box/magazine/m762,
				""
				)

	var/loot12 = list(
				/obj/item/gun/ballistic/automatic/shotgun/riot,
				//obj/item/ammo_box/magazine/d12g,
				/obj/item/ammo_box/magazine/d12g,
				""
				)

	var/loot13 = list(
				/obj/item/gun/energy/ionrifle,
				/obj/item/stock_parts/cell/ammo/mfc,
				""
				)

	var/loot14 = list(
				/obj/item/gun/energy/laser/plasma/glock,
				//obj/item/stock_parts/cell/ammo/ec,
				/obj/item/stock_parts/cell/ammo/ec,
				)

	var/loot15 = list(
				/obj/item/gun/medbeam,
				""
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier4/Initialize(mapload) //on mapload, pick what shit to spawn
	loot = pick(loot1, loot2, loot3, loot4, loot5, loot6, loot7, loot8, loot9, loot10, loot11, loot12, loot13, loot14, loot15)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/tier5 //TIER 5 GUN
	name = "tier 5 gun"
	lootcount = 1

	loot = list(
				/obj/item/gun/energy/laser/plasma,
				/obj/item/gun/ballistic/automatic/tommygun,
				/obj/item/gun/ballistic/automatic/shotgun/riot,
				/obj/item/gun/energy/laser/scatter,
				/obj/item/gun/ballistic/revolver/sequoia/scoped,
				/obj/item/gun/ballistic/automatic/bozar,
				/obj/item/gun/energy/gammagun
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/unique //UNIQUE GUN
	name = "unique gun"
	lootcount = 1

	loot = list(
				/obj/item/gun/ballistic/revolver/colt357/lucky,
				/obj/item/gun/ballistic/automatic/pistol/ninemil/maria,
				/obj/item/gun/ballistic/shotgun/remington/scoped/paciencia,
				/obj/item/gun/energy/laser/solar,
				/obj/item/gun/energy/laser/plasma/alien
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/random
    name = "random gun loot"
    lootcount = 1

    loot = list(
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier1 = 80,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier2 = 14,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier3 = 4,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier4 = 1,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier5 = 1
            )

/obj/effect/spawner/lootdrop/f13/weapon/gun/random_high
	name = "high tier random gun loot"
	lootcount = 1

	loot = list(
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier2 = 55,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier3 = 35,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier4 = 5,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/tier5 = 4,
            /obj/effect/spawner/lootdrop/f13/weapon/gun/unique = 1
            )

/* ------------------------------------------------
   ------------WEAPON AMMO SPAWNERS----------------
   ------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo
	name = "ammo spawners - DO NOT USE THIS"
	icon_state = "ammo_loot"

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier1
	name = "tier 1 ammo"
	lootcount = 2 //2 random ammo
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/magazine/m9mm,
				/obj/item/storage/box/lethalshot,
				/obj/item/storage/box/rubbershot,
				/obj/item/storage/box/rubbershot/beanbag,
				/obj/item/ammo_box/c38,
				/obj/item/ammo_box/magazine/m10mm_adv,
				/obj/item/ammo_box/magazine/m556/rifle/small
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier2
	name = "tier 2 ammo"
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/magazine/m45,
				/obj/item/ammo_box/a762,
        		/obj/item/ammo_box/a308,
				/obj/item/ammo_box/magazine/m10mm_adv,
				/obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/c38,
				/obj/item/ammo_box/magazine/m9mm,
				/obj/item/ammo_box/m44,
				/obj/item/ammo_box/tube/a357,
				/obj/item/ammo_box/a357,
				/obj/item/ammo_box/magazine/m556/rifle/small
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier2/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(2, 3)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3
	name = "tier 3 ammo"
	lootdoubles = TRUE

	loot = list(
				/obj/item/storage/box/lethalshot,
				/obj/item/ammo_box/magazine/uzim9mm,
				/obj/item/ammo_box/magazine/m10mm_adv,
				/obj/item/ammo_box/magazine/greasegun,
				/obj/item/ammo_box/needle,
				/obj/item/ammo_box/magazine/tommygunm45,
				/obj/item/ammo_box/tube/m44,
				/obj/item/ammo_box/magazine/m10mm_auto,
				/obj/item/stock_parts/cell/ammo/ec
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier3/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(2, 3)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier4
	name = "tier 4 ammo"
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/magazine/d12g,
				/obj/item/ammo_box/magazine/a50,
				/obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/c4570,
				/obj/item/ammo_box/tube/c4570,
				/obj/item/ammo_box/a50MG,
				/obj/item/ammo_box/a762/doublestacked,
				/obj/item/stock_parts/cell/ammo/mfc
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier4/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(2, 3)
	. = ..()

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier5
	name = "tier 5 ammo"
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/a50MG,
				/obj/item/ammo_box/a50MG/incendiary,
				/obj/item/ammo_box/magazine/m556/rifle/extended,
				/obj/item/ammo_box/magazine/m762/ext,
				/obj/item/ammo_box/magazine/d12g
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier5/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2, 3, 4)
	. = ..()


/obj/effect/spawner/lootdrop/f13/junkspawners //TIER 4 GARBAGE
	name = "garbage spawner"
	lootcount = 2
	fan_out_items = TRUE

	loot = list(
				/obj/item/broken_bottle,
				/obj/item/poster/random_official,
				/obj/item/multitool,
				/obj/item/cigbutt/cigarbutt,
				/obj/item/razor,
				/obj/item/candle,
				/obj/item/rollingpaper,
				/obj/item/trash/coal,
				/obj/item/soap/homemade,
				/obj/item/bikehorn,
				/obj/item/stack/cable_coil/random,
				/obj/item/stack/medical/bruise_pack,
				/obj/item/trash/popcorn,
				/obj/item/valentine,
				/obj/item/taperecorder,
				/obj/item/bikehorn/airhorn,
				/obj/item/tape/random,
				/obj/item/stack/medical/gauze,
				/obj/item/trash/plate,
				/obj/item/storage/box/snappops,
				/obj/item/bikehorn/rubberducky,
				/obj/item/stack/packageWrap,
				/obj/item/storage/box/matches,
				/obj/item/reagent_containers/food/snacks/deadmouse,
				/obj/item/toner,
				/obj/item/tank/internals/oxygen,
				/obj/item/storage/box/papersack,
				/obj/item/storage/box/lights/mixed,
				/obj/item/storage/box/beakers,
				/obj/item/storage/belt/fannypack/black,
				/obj/item/camera,
				/obj/item/bodypart/l_arm,
				/obj/item/toy/dummy,
				/obj/item/toy/eightball,
				/obj/item/toy/cards/deck,
				/obj/item/trash/tray,
				/obj/item/toy/xmas_cracker,
				/obj/item/reagent_containers/glass/bowl,
				/obj/item/reagent_containers/spray/cleaner,
				/obj/item/reagent_containers/glass/bucket,
				/obj/item/poster/random_contraband
				)

/obj/effect/spawner/lootdrop/f13/seedspawner
	name = "seed spawner"
	lootdoubles = TRUE
	fan_out_items = TRUE
	lootcount = 4

/obj/effect/spawner/lootdrop/f13/seedspawner/Initialize(mapload) // This will spawn gatfruit sometimes.
	loot = list(/obj/item/seeds/ambrosia,
		            /obj/item/seeds/apple,
		            /obj/item/seeds/banana,
		            /obj/item/seeds/cotton,
		            /obj/item/seeds/berry,
		            /obj/item/seeds/poppy/broc,
					/obj/item/seeds/cabbage,
					/obj/item/seeds/carrot,
					/obj/item/seeds/carrot/parsnip,
					/obj/item/seeds/cherry,
					/obj/item/seeds/chanter,
					/obj/item/seeds/chili,
					/obj/item/seeds/cocoapod,
					/obj/item/seeds/coffee,
					/obj/item/seeds/corn,
					/obj/item/seeds/eggplant,
					/obj/item/seeds/grape,
					/obj/item/seeds/grass,
					/obj/item/seeds/lemon,
					/obj/item/seeds/lime,
					/obj/item/seeds/onion,
					/obj/item/seeds/orange,
					/obj/item/seeds/rainbow_bunch,
					/obj/item/seeds/pineapple,
					/obj/item/seeds/potato,
					/obj/item/seeds/poppy,
					/obj/item/seeds/pumpkin,
					/obj/item/seeds/wheat/rice,
					/obj/item/seeds/soya,
					/obj/item/seeds/sugarcane,
					/obj/item/seeds/sunflower,
					/obj/item/seeds/tea,
					/obj/item/seeds/tobacco,
					/obj/item/seeds/tomato,
					/obj/item/seeds/tower,
					/obj/item/seeds/watermelon,
					/obj/item/seeds/wheat,
					/obj/item/seeds/whitebeet,
					/obj/item/seeds/xander,
					/obj/item/seeds/mutfruit,
					/obj/item/seeds/amanita,
		            /obj/item/seeds/glowshroom,
		            /obj/item/seeds/liberty,
		            /obj/item/seeds/nettle,
					/obj/item/seeds/plump,
					/obj/item/seeds/reishi,
					/obj/item/seeds/cannabis,
					/obj/item/seeds/starthistle,
					/obj/item/seeds/random)
	. = ..()

/obj/effect/spawner/lootdrop/f13/foodspawner
	name = "food spawner"
	lootdoubles = TRUE
	fan_out_items = TRUE

	loot = list(
				/obj/item/storage/box/ingredients/american,
				/obj/item/reagent_containers/food/snacks/f13/crisps,
				/obj/item/reagent_containers/food/snacks/f13/crisps,
				/obj/item/reagent_containers/food/snacks/f13/bubblegum,
				/obj/item/reagent_containers/food/snacks/f13/cram,
				/obj/item/reagent_containers/food/snacks/f13/yumyum,
				/obj/item/reagent_containers/food/snacks/f13/fancylads,
				/obj/item/reagent_containers/food/snacks/f13/sugarbombs,
				/obj/item/reagent_containers/food/snacks/cheesiehonkers,
				/obj/item/reagent_containers/food/snacks/f13/steak,
				/obj/item/reagent_containers/food/snacks/f13/dandyapples,
				/obj/item/reagent_containers/food/snacks/f13/blamco,
				/obj/item/reagent_containers/food/snacks/f13/instamash ,
				/obj/item/reagent_containers/food/snacks/f13/porknbeans,
				/obj/item/storage/box/ingredients/carnivore,
				/obj/item/storage/box/ingredients/delights,
				/obj/item/storage/box/ingredients/exotic,
				/obj/item/storage/box/ingredients/fiesta,
				/obj/item/storage/box/ingredients/fruity,
				/obj/item/storage/box/ingredients/grains,
				/obj/item/storage/box/ingredients/italian,
				/obj/item/storage/box/ingredients/sweets,
				/obj/item/storage/box/ingredients/vegetarian,
				/obj/item/storage/box/ingredients/wildcard,
				/obj/item/reagent_containers/food/condiment/flour,
				/obj/item/reagent_containers/food/condiment/rice,
				/obj/item/reagent_containers/food/condiment/yeast,
				/obj/item/reagent_containers/food/condiment/soymilk,
				/obj/item/reagent_containers/food/condiment/ketchup,
				/obj/item/reagent_containers/food/condiment/sugar,
				/obj/item/reagent_containers/food/condiment/milk,
				/obj/item/reagent_containers/food/condiment/saltshaker,
				/obj/item/reagent_containers/food/condiment/peppermill,
				/obj/item/reagent_containers/food/condiment/soysauce,
				/obj/item/reagent_containers/food/snacks/beans,
				/obj/item/reagent_containers/food/snacks/cracker,
				/obj/item/reagent_containers/food/snacks/lollipop,
				"" // a chance to spawn nothing
				)


/obj/effect/spawner/lootdrop/f13/foodspawner/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2)
	. = ..()

/obj/effect/spawner/lootdrop/f13/crafting
	name = "crafting spawner"
	lootdoubles = TRUE
	fan_out_items = TRUE

	loot = list(
				/obj/item/crafting/abraxo,
				/obj/item/stack/crafting/metalparts/three,
				/obj/item/stack/crafting/metalparts/five,
				/obj/item/stack/crafting/goodparts/three,
				/obj/item/stack/crafting/goodparts/five,
				/obj/item/stack/crafting/electronicparts/three,
				/obj/item/stack/crafting/electronicparts/five,
				/obj/item/reagent_containers/glass/bottle/blackpowder,
				/obj/item/crafting/wonderglue,
				/obj/item/crafting/duct_tape)

/obj/effect/spawner/lootdrop/f13/crafting/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2)
	. = ..()


/obj/effect/spawner/lootdrop/f13/alcoholspawner //TIER 7 ALCOHOL
	name = "alcoholspawner"
	lootdoubles = TRUE
	fan_out_items = TRUE

	loot = list(
				/obj/item/reagent_containers/food/drinks/beer,
				/obj/item/reagent_containers/food/drinks/ale,
				/obj/item/reagent_containers/food/drinks/bottle/gin,
				/obj/item/reagent_containers/food/drinks/bottle/hcider,
				/obj/item/reagent_containers/food/drinks/bottle/whiskey,
				/obj/item/reagent_containers/food/drinks/bottle/vodka,
				/obj/item/reagent_containers/food/drinks/bottle/tequila,
				/obj/item/reagent_containers/food/drinks/bottle/rum,
				/obj/item/reagent_containers/food/drinks/bottle/vermouth,
				/obj/item/reagent_containers/food/drinks/bottle/kahlua,
				/obj/item/reagent_containers/food/drinks/bottle/cognac,
				/obj/item/reagent_containers/food/drinks/bottle/wine,
				/obj/item/reagent_containers/food/drinks/bottle/absinthe,
				/obj/item/reagent_containers/food/drinks/bottle/lizardwine,
				/obj/item/reagent_containers/food/drinks/bottle/hcider,
				/obj/item/reagent_containers/food/drinks/bottle/grappa,
				/obj/item/reagent_containers/food/drinks/bottle/sake,
				/obj/item/reagent_containers/food/drinks/bottle/fernet
				)

/obj/effect/spawner/lootdrop/f13/alcoholspawner/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2)
	. = ..()

/obj/effect/spawner/lootdrop/f13/resourcespawner //now include R N G (TM) (higher number means it has a bigger spawn chance)
	name = "resource spawner"
	lootcount = 2

	loot = list(
				/obj/item/stack/rods/ten = 3,
				/obj/item/stack/sheet/metal/ten = 5,
				/obj/item/stack/sheet/cardboard/fifty = 1,
				/obj/item/stack/sheet/cardboard/twenty = 1,
//				/obj/item/stack/sheet/glass/ten = 2,
				/obj/item/stack/sheet/metal/five = 2,
				/obj/item/stack/sheet/plasteel/five = 1,
				/obj/item/stack/sheet/plastic/five = 4,
				/obj/item/stack/sheet/paperframes/twenty = 1,
				/obj/item/stack/sheet/cloth/ten = 1,
				/obj/item/stack/crafting/metalparts/five = 4,
				/obj/item/stack/crafting/goodparts/three = 2
				)

/obj/effect/spawner/lootdrop/f13/cash_random_low
	name = "low value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/bottle_cap/low = 50,
				/obj/item/stack/f13Cash/random/ncr/low = 30,
				/obj/item/stack/f13Cash/random/denarius/low = 30,
				/obj/item/stack/f13Cash/random/aureus/low = 10,
				/obj/item/stack/f13Cash/random/bottle_cap/med = 25,
				/obj/item/stack/f13Cash/random/ncr/med = 15,
				/obj/item/stack/f13Cash/random/denarius/med = 15,
				/obj/item/stack/f13Cash/random/aureus/med = 5,
				/obj/item/stack/f13Cash/random/bottle_cap/high = 10,
				/obj/item/stack/f13Cash/random/ncr/high = 5,
				/obj/item/stack/f13Cash/random/denarius/high = 5,
				/obj/item/stack/f13Cash/random/aureus/high = 1,
				)

/obj/effect/spawner/lootdrop/f13/cash_random_med
	name = "medium value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/bottle_cap/med = 50,
				/obj/item/stack/f13Cash/random/ncr/med = 30,
				/obj/item/stack/f13Cash/random/denarius/med = 30,
				/obj/item/stack/f13Cash/random/aureus/med = 10,
				/obj/item/stack/f13Cash/random/bottle_cap/low = 25,
				/obj/item/stack/f13Cash/random/ncr/low = 15,
				/obj/item/stack/f13Cash/random/denarius/low = 15,
				/obj/item/stack/f13Cash/random/aureus/low = 5,
				/obj/item/stack/f13Cash/random/bottle_cap/high = 10,
				/obj/item/stack/f13Cash/random/ncr/high = 5,
				/obj/item/stack/f13Cash/random/denarius/high = 5,
				/obj/item/stack/f13Cash/random/aureus/high = 1,
				)

/obj/effect/spawner/lootdrop/f13/cash_random_high
	name = "high value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/bottle_cap/high = 50,
				/obj/item/stack/f13Cash/random/ncr/high = 30,
				/obj/item/stack/f13Cash/random/denarius/high = 30,
				/obj/item/stack/f13Cash/random/aureus/high = 10,
				/obj/item/stack/f13Cash/random/bottle_cap/med = 25,
				/obj/item/stack/f13Cash/random/ncr/med = 15,
				/obj/item/stack/f13Cash/random/denarius/med = 15,
				/obj/item/stack/f13Cash/random/aureus/med = 5,
				/obj/item/stack/f13Cash/random/bottle_cap/low = 10,
				/obj/item/stack/f13Cash/random/ncr/low = 5,
				/obj/item/stack/f13Cash/random/denarius/low = 5,
				/obj/item/stack/f13Cash/random/aureus/low = 1,
				)

/obj/effect/spawner/lootdrop/f13/cash_legion_low
	name = "low value legion cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/denarius/low = 50,
			/obj/item/stack/f13Cash/random/aureus/low = 30,
			/obj/item/stack/f13Cash/random/bottle_cap/low = 10,
			/obj/item/stack/f13Cash/random/denarius/med = 10,
			/obj/item/stack/f13Cash/random/aureus/med = 5,
			/obj/item/stack/f13Cash/random/bottle_cap/med = 1,
			)

/obj/effect/spawner/lootdrop/f13/cash_legion_med
	name = "medium value legion cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/denarius/med = 50,
			/obj/item/stack/f13Cash/random/aureus/med = 30,
			/obj/item/stack/f13Cash/random/bottle_cap/med = 10,
			/obj/item/stack/f13Cash/random/denarius/high = 10,
			/obj/item/stack/f13Cash/random/aureus/high = 5,
			/obj/item/stack/f13Cash/random/bottle_cap/high = 1,
			/obj/item/stack/f13Cash/random/denarius/low = 10,
			/obj/item/stack/f13Cash/random/aureus/low = 5,
			/obj/item/stack/f13Cash/random/bottle_cap/low = 1,
			)

/obj/effect/spawner/lootdrop/f13/cash_legion_high
	name = "high value legion cash spawner"
	lootcount = 1
	loot = list(
		/obj/item/stack/f13Cash/random/denarius/high = 50,
		/obj/item/stack/f13Cash/random/aureus/high = 30,
		/obj/item/stack/f13Cash/random/bottle_cap/high = 10,
		/obj/item/stack/f13Cash/random/denarius/med = 10,
		/obj/item/stack/f13Cash/random/aureus/med = 5,
		/obj/item/stack/f13Cash/random/bottle_cap/med = 1,
		)


/obj/effect/spawner/lootdrop/f13/cash_ncr_low
	name = "low value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/low = 50,
			/obj/item/stack/f13Cash/random/bottle_cap/low = 10,
			/obj/item/stack/f13Cash/random/ncr/med = 25,
			/obj/item/stack/f13Cash/random/bottle_cap/med = 5,
			)

/obj/effect/spawner/lootdrop/f13/cash_ncr_med
	name = "medium value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/med = 50,
			/obj/item/stack/f13Cash/random/bottle_cap/med = 10,
			/obj/item/stack/f13Cash/random/ncr/high = 25,
			/obj/item/stack/f13Cash/random/bottle_cap/high = 5,
			)

/obj/effect/spawner/lootdrop/f13/cash_ncr_high
	name = "high value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/high = 50,
			/obj/item/stack/f13Cash/random/bottle_cap/high = 10,
			/obj/item/stack/f13Cash/random/ncr/med = 25,
			/obj/item/stack/f13Cash/random/bottle_cap/med = 5,
			)

/obj/effect/spawner/lootdrop/f13/deadrodent_or_brainwashdisk
	name = "100% chance of deceased rodent"
	loot = list(
		/obj/item/reagent_containers/food/snacks/deadmouse = 50)

/obj/effect/spawner/lootdrop/f13/traitbooks
	name = "trait book spawner"
	lootcount = 1
	loot = list(/obj/item/book/granter/trait/chemistry = 10,
	/obj/item/book/granter/trait/trekking = 10,
	/obj/item/book/granter/trait/pa_wear = 1,
	/obj/item/book/granter/trait/gunsmith_one = 50,
	/obj/item/book/granter/trait/gunsmith_two = 20,
	/obj/item/book/granter/trait/gunsmith_three = 10,
	/obj/item/book/granter/trait/gunsmith_four = 10)

/obj/effect/spawner/lootdrop/f13/blueprintLow
	name = "gun comps spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		//obj/item/blueprint/weapon/AEP7,
		//obj/item/blueprint/weapon/lever_action,
		//obj/item/blueprint/weapon/kar98,
		/obj/item/prefabs/complex/action/auto,
		/obj/item/prefabs/complex/bolt/high,
		/obj/item/prefabs/complex/barrel/m4570,
		/obj/item/prefabs/complex/barrel/m762
	)
/obj/effect/spawner/lootdrop/f13/blueprintMid
	name = "blueprint-tier(Mid) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/blueprint/weapon/marksmanrifle,
		/obj/item/blueprint/weapon/plasmapistol,
		/obj/item/blueprint/weapon/brush,
		//obj/item/blueprint/weapon/grease_gun,
		///obj/item/blueprint/weapon/pps,
		/obj/item/blueprint/weapon/mg34
	)
/obj/effect/spawner/lootdrop/f13/blueprintMidLimited
	name = "blueprint-tier(MidLimited) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/blueprint/weapon/marksmanrifle/limited,
		/obj/item/blueprint/weapon/plasmapistol/limited,
		/obj/item/blueprint/weapon/brush/limited,
		//obj/item/blueprint/weapon/grease_gun/limited,
		/obj/item/blueprint/weapon/mg34/limited,
		/obj/item/prefabs/complex/action/auto,
		/obj/item/prefabs/complex/bolt/high,
		/obj/item/prefabs/complex/barrel/m4570
	)
/obj/effect/spawner/lootdrop/f13/blueprintHigh
	name = "blueprint-tier(High) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		//obj/item/blueprint/weapon/R91,
		/obj/item/blueprint/weapon/sniper,
		/obj/item/blueprint/weapon/breacher,
		/obj/item/blueprint/weapon/lmg,
		/obj/item/blueprint/weapon/R82,
		/obj/item/blueprint/weapon/deagle
	)
/obj/effect/spawner/lootdrop/f13/blueprintVHigh
	name = "blueprint-tier(VHigh) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/blueprint/weapon/plasmarifle,
		/obj/item/blueprint/weapon/AER9,
		/obj/item/blueprint/weapon/AM_rifle,
		/obj/item/blueprint/weapon/city_killer
		//obj/item/blueprint/weapon/rangemaster
	)
/obj/effect/spawner/lootdrop/f13/blueprintVHighBallistics
	name = "blueprint-tier(VHighBallistics) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/blueprint/weapon/AM_rifle,
		/obj/item/blueprint/weapon/city_killer,
		//obj/item/blueprint/weapon/rangemaster,
		/obj/item/blueprint/weapon/bozar
	)

/obj/effect/spawner/lootdrop/f13/advcrafting
	name = "advanced_crafting"
	lootcount = 1
	lootdoubles = FALSE
	loot = list(
		/obj/item/advanced_crafting_components/flux,
		/obj/item/advanced_crafting_components/lenses,
		/obj/item/advanced_crafting_components/conductors,
		/obj/item/advanced_crafting_components/receiver,
		/obj/item/advanced_crafting_components/assembly,
	    /obj/item/advanced_crafting_components/alloys,
	)

/obj/effect/spawner/lootdrop/f13/attachments
	name = "attachments"
	lootcount = 1
	lootdoubles = FALSE
	loot = list(
		/obj/item/attachments/scope,
		/obj/item/attachments/bullet_speed,
		/obj/item/attachments/burst_improvement,
		/obj/item/attachments/recoil_decrease
	)

