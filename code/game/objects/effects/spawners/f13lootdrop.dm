/*	-------------------------------------------------
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
	fan_out_items = TRUE //Randomize pixel x and y

/*	------------------------------------------------
	----------------ARMOR SPAWNERS------------------
	------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/armor
	name = "armor spawners - DO NOT USE THIS"
	icon_state = "armor_loot"

/obj/effect/spawner/lootdrop/f13/armor/clothes
	name = "pre-war clothes spawner"
	loot = list(
				/obj/effect/spawner/bundle/f13/worker,
				/obj/effect/spawner/bundle/f13/plaidskirt,
				/obj/item/clothing/under/blacktango,
				/obj/item/clothing/under/redeveninggown,
				/obj/item/clothing/under/janimaid,
				/obj/effect/spawner/bundle/f13/badass,
				/obj/effect/spawner/bundle/f13/puffer,
				/obj/effect/spawner/bundle/f13/that,
				/obj/effect/spawner/bundle/f13/benny,
				/obj/effect/spawner/bundle/f13/burgundysuit,
				/obj/effect/spawner/bundle/f13/scratch,
				/obj/effect/spawner/bundle/f13/hoodie,
				/obj/item/clothing/under/pants/camo,
				/obj/effect/spawner/bundle/f13/bartender_purple,
				/obj/effect/spawner/bundle/f13/plaidskirt/bluered,
				/obj/effect/spawner/bundle/f13/navysuit,
				/obj/effect/spawner/bundle/f13/femsuit,
	)

/obj/effect/spawner/bundle/f13/worker
	name = "overalls and flat cap"
	items = list(
				/obj/item/clothing/under/overalls,
				/obj/item/clothing/head/flatcap
				)

/obj/effect/spawner/bundle/f13/plaidskirt
	name = "green and purple plaid skirt"
	items = list(
				/obj/item/clothing/under/plaid_skirt/green,
				/obj/item/clothing/under/plaid_skirt/purple
				)

/obj/effect/spawner/bundle/f13/badass
	name = "leather jacket and fingerless gloves"
	items = list(
				/obj/item/clothing/suit/jacket/leather,
				/obj/item/clothing/gloves/fingerless
				)

/obj/effect/spawner/bundle/f13/puffer
	name = "puffer vest, jeans, and grey cloak"
	items = list(
		/obj/item/clothing/suit/jacket/puffer/vest,
		/obj/item/clothing/under/pants/jeans,
		/obj/item/clothing/neck/mantle/gray,
	)

/obj/effect/spawner/bundle/f13/that
	name = "charcoal suit and hat"
	items = list(
				/obj/item/clothing/under/suit_jacket/charcoal,
				/obj/item/clothing/head/that
				)

/obj/effect/spawner/bundle/f13/benny
	name = "checkered suit and shoes"
	items = list(
				/obj/item/clothing/under/suit_jacket/checkered, // It's Benny time!
				/obj/item/clothing/shoes/laceup
				)

/obj/effect/spawner/bundle/f13/burgundysuit
	name = "burgundy suit, shoes, and cloak"
	items = list(
		/obj/item/clothing/under/suit_jacket/burgundy,
		/obj/item/clothing/shoes/laceup,
		/obj/item/clothing/neck/mantle/brown,
	)

/obj/effect/spawner/bundle/f13/scratch
	name = "white suit and shoes"
	items = list(
				/obj/item/clothing/under/scratch,
				/obj/item/clothing/shoes/sneakers/white
				)

/obj/effect/spawner/bundle/f13/hoodie
	name = "hoodie"
	items = list(
				/obj/item/clothing/head/beanie/black,
				/obj/item/clothing/suit/hooded/chaplain_hoodie
				)

/obj/effect/spawner/bundle/f13/bartender_purple
	name = "purple bartender's outfit spawner"
	items = list(
				/obj/item/clothing/neck/apron/bartender,
				/obj/item/clothing/under/rank/bartender/purple,
				)

/obj/effect/spawner/bundle/f13/plaidskirt/bluered
	name = "blue and red plaid skirts"
	items = list(
				/obj/item/clothing/under/plaid_skirt/blue,
				/obj/item/clothing/under/plaid_skirt
				)

/obj/effect/spawner/bundle/f13/navysuit
	name = "navy suit and shoes"
	items = list(
				/obj/item/clothing/under/suit_jacket/navy,
				/obj/item/clothing/shoes/laceup
				)

/obj/effect/spawner/bundle/f13/femsuit
	name = "female executive suit and shoes"
	items = list(
				/obj/item/clothing/under/suit_jacket/female,
				/obj/item/clothing/shoes/laceup
				)



/obj/effect/spawner/lootdrop/f13/armor/costumes
	name = "pre-war costumes spawner"
	loot = list(
				/obj/effect/spawner/bundle/f13/soviet,
				/obj/effect/spawner/bundle/f13/geisha,
				/obj/item/clothing/under/blacktango,
				/obj/item/clothing/under/redeveninggown,
				/obj/effect/spawner/bundle/f13/mexican,
				/obj/item/clothing/under/sailor,
				/obj/effect/spawner/lootdrop/f13/schoolgirl,
				/obj/effect/spawner/bundle/f13/hats,
				/obj/effect/spawner/bundle/f13/jabroni,
				/obj/effect/spawner/bundle/f13/romeaboo,
				/obj/item/clothing/under/maid,
				/obj/effect/spawner/bundle/f13/vampire,
				/obj/item/clothing/under/kilt,
				/obj/effect/spawner/bundle/f13/pirate
	)

/obj/effect/spawner/bundle/f13/soviet
	name = "soviet costume"
	items = list(
		/obj/item/clothing/head/ushanka,
		/obj/item/clothing/under/soviet,
		/obj/item/clothing/neck/mantle/gray,
	)

/obj/effect/spawner/bundle/f13/geisha
	name = "geisha costume"
	items = list(
				/obj/item/clothing/under/geisha,
				/obj/item/clothing/shoes/sandal
				)

/obj/effect/spawner/bundle/f13/mexican
	name = "sombrero and poncho"
	items = list(
				/obj/item/clothing/head/sombrero,
				/obj/item/clothing/neck/mantle/poncho
				)

/obj/effect/spawner/lootdrop/f13/schoolgirl
	name = "schoolgirl outfit spawner"
	loot = list(
				/obj/item/clothing/under/schoolgirl/red,
				/obj/item/clothing/under/schoolgirl
				)

/obj/effect/spawner/bundle/f13/hats
	name = "hats"
	items = list(
				/obj/item/clothing/head/fluff/bandit,
				/obj/item/clothing/head/fluff/gambler
				)

/obj/effect/spawner/bundle/f13/jabroni
	name = "jabroni outfit spawner"
	items = list(
				/obj/item/clothing/under/jabroni,
				/obj/item/clothing/glasses/sunglasses/blindfold
				)

/obj/effect/spawner/bundle/f13/romeaboo
	name = "roman gladiator outfit spawner"
	items = list(
				/obj/item/clothing/under/gladiator,
				/obj/item/clothing/shoes/roman
				)

/obj/effect/spawner/bundle/f13/vampire
	name = "vampire outfit spawner"
	items = list(
		/obj/item/clothing/under/draculass,
		/obj/item/clothing/neck/mantle/gray,
	)

/obj/effect/spawner/bundle/f13/pirate
	name = "pirate outfit spawner"
	items = list(
				/obj/item/clothing/under/pirate,
				/obj/item/clothing/suit/pirate
				)

/*
/obj/effect/spawner/lootdrop/f13/armor/tier1 //TIER 1 ARMOR
	name = "tier 1 armor"
	loot = list(
				/obj/item/clothing/suit/armor/light/leather/leather_jacket,
				/obj/item/clothing/suit/armor/light/leather,
				/obj/effect/spawner/bundle/f13/armor/supafly,
				/obj/effect/spawner/bundle/f13/armor/sadist,
				/obj/effect/spawner/bundle/f13/armor/blastmaster,
				/obj/effect/spawner/bundle/f13/armor/yankee,
				/obj/effect/spawner/bundle/f13/armor/badlands,
				/obj/effect/spawner/bundle/f13/armor/psycho,
				/obj/item/clothing/suit/armor/light/duster,
				/obj/effect/spawner/bundle/f13/armor/combatduster,
				/obj/item/clothing/suit/armor/medium/raider/iconoclast,
				/obj/item/clothing/suit/armor/medium/vest/breastplate/light,
				/obj/item/clothing/suit/armor/light/kit/punk/bronzechestplate,
				/obj/item/clothing/suit/armor/light/kit/punk/leatherarmor,
				/obj/item/clothing/suit/armor/light/kit/punk/ironchestplate,
				/obj/item/clothing/suit/armor/light/kit/punk/scaledarmor,
				/obj/item/clothing/suit/armor/light/kit/punk/roughchainmail,
				/obj/item/clothing/suit/armor/light/kit/punk/fullchainmail,
				/obj/item/clothing/suit/armor/light/kit/punk/ironchestplatered,
				/obj/item/clothing/suit/armor/light/kit/punk/ironchestplateblue,
				/obj/item/clothing/suit/armor/light/kit/punk/oldscalemail,
				/obj/item/clothing/suit/armor/light/kit/punk/scalemail,
				/obj/item/clothing/suit/armor/light/kit/punk/varangianarmor,
				/obj/item/clothing/suit/armor/light/kit/punk/egyptianlam,
				/obj/item/clothing/suit/armor/light/kit/punk/chitinbreastplate,
				/obj/item/clothing/suit/armor/light/kit/punk/steppeleatherarmor,
				/obj/item/clothing/suit/armor/light/kit/punk/chineselam,
				/obj/item/clothing/suit/armor/light/kit/punk/chinesebreastplate,
				/obj/item/clothing/suit/armor/light/kit/punk/woodenbreastplate,
				/obj/item/clothing/suit/armor/light/kit/punk/steelbreastplate,
				/obj/item/clothing/suit/armor/light/kit/punk/bronzebreastplate,

	)
*/

/obj/effect/spawner/bundle/f13/armor/supafly
	name = "supafly raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/light/raider/supafly,
				/obj/item/clothing/head/helmet/f13/raider/supafly
				)

/obj/effect/spawner/bundle/f13/armor/sadist
	name = "blastmaster raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/light/raider/sadist,
				/obj/item/clothing/head/helmet/f13/raider/arclight
				)

/obj/effect/spawner/bundle/f13/armor/blastmaster
	name = "blastmaster raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/raider/blastmaster,
				/obj/item/clothing/head/helmet/f13/raider/blastmaster
				)

/obj/effect/spawner/bundle/f13/armor/yankee
	name = "yankee raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/raider/yankee,
				/obj/item/clothing/head/helmet/f13/raider/yankee
				)

/obj/effect/spawner/bundle/f13/armor/badlands
	name = "badlands raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/raider/badlands,
				/obj/item/clothing/head/helmet/f13/fiend
				)

/obj/effect/spawner/bundle/f13/armor/combatduster
	name = "combat duster raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/raider/combatduster,
				/obj/item/clothing/head/helmet/f13/raidercombathelmet
				)

/obj/effect/spawner/bundle/f13/armor/psycho
	name = "knight armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/light/raider/painspike,
				/obj/item/clothing/head/helmet/f13/raider/psychotic
				)

/*
/obj/effect/spawner/lootdrop/f13/armor/tier2 //TIER 2 ARMOR
	name = "tier 2 armor"
	loot = list(
				/obj/effect/spawner/bundle/f13/armor/knight,
				/obj/effect/spawner/bundle/f13/armor/metal,
				/obj/effect/spawner/bundle/f13/armor/laserproofmetal,
				/obj/item/clothing/suit/armor/light/leather/leather_jacketmk2,
				/obj/item/clothing/suit/armor/light/leather/leathercoat,
				/obj/item/clothing/suit/armor/medium/vest,
				/obj/item/clothing/suit/armor/medium/vest/alt,
				/obj/item/clothing/suit/armor/medium/raider/slam,
				/obj/item/clothing/suit/armor/medium/raider/scrapcombat
				)
*/

/obj/effect/spawner/bundle/f13/armor/knight
	name = "knight armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/metal,
				/obj/item/clothing/head/helmet/knight/f13/metal
				)

/obj/effect/spawner/bundle/f13/armor/metal
	name = "metal armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/metal,
				/obj/item/clothing/head/helmet/f13/metalmask
				)

/obj/effect/spawner/bundle/f13/armor/laserproofmetal
	name = "polsihed metal armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/metal/polished,
				/obj/item/clothing/head/helmet/f13/metalmask
				)

/*
/obj/effect/spawner/lootdrop/f13/armor/tier3 //TIER 3 ARMOR
	name = "tier 3 armor"
	loot = list(
				/obj/effect/spawner/bundle/f13/armor/metal/reinforced,
				/obj/effect/spawner/bundle/f13/armor/swat,
				/obj/effect/spawner/bundle/f13/armor/combat,
				/obj/effect/spawner/bundle/f13/armor/bulletproof,
				/obj/effect/spawner/bundle/f13/armor/sulphite,
				/obj/effect/spawner/bundle/f13/armor/vault
				)
*/

/obj/effect/spawner/lootdrop/f13/armor/randomraiderchest //random raider armor
	name = "raider boss armor drop"
	loot = list(
				/obj/item/clothing/suit/armor/medium/raider/scrapcombat,
				/obj/item/clothing/suit/armor/medium/raider/slam,
				/obj/item/clothing/suit/armor/medium/raider/rebel,
				/obj/item/clothing/suit/armor/medium/raider/scrapcombat,
				/obj/item/clothing/suit/armor/medium/raider/slam,
				/obj/item/clothing/suit/armor/medium/raider/wastewar,
				/obj/item/clothing/suit/armor/medium/combat/mk2/raider) // da grail

/obj/effect/spawner/lootdrop/f13/armor/randomraiderhead //random raider armor
	name = "raider boss armor drop"
	loot = list(
				/obj/item/clothing/head/helmet/f13/raider/wastehound,
				/obj/item/clothing/head/helmet/f13/raidermetal,
				/obj/item/clothing/head/helmet/f13/combat/mk2/raider
				)

/obj/effect/spawner/bundle/f13/armor/metal/reinforced
	items = list(
				/obj/item/clothing/suit/armor/heavy/metal/reinforced,
				/obj/item/clothing/head/helmet/f13/metalmask/mk2
				)

/obj/effect/spawner/bundle/f13/armor/swat
	items = list(
				/obj/item/clothing/head/helmet/f13/combat/swat,
				/obj/item/clothing/suit/armor/medium/combat/swat
				)

/obj/effect/spawner/bundle/f13/armor/combat
	name = "combat armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/combat,
				/obj/item/clothing/head/helmet/f13/combat
				)

/obj/effect/spawner/bundle/f13/armor/bulletproof
	name = "bulletproof armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/vest/bulletproof,
				/obj/item/clothing/head/helmet/alt
				)

/obj/effect/spawner/bundle/f13/armor/combat/dark
	name = "dark combat armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/combat/dark,
				/obj/item/clothing/head/helmet/f13/combat/dark
				)


/obj/effect/spawner/bundle/f13/armor/sulphite
	name = "sulphite raider armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/metal/sulphite,
				/obj/item/clothing/head/helmet/f13/sulphitehelm
				)
/*
/obj/effect/spawner/lootdrop/f13/armor/tier4 //TIER 4 ARMOR
	name = "tier 4 armor"
	loot = list(
				/obj/effect/spawner/bundle/f13/armor/t45b_salvaged,
				/obj/effect/spawner/bundle/f13/armor/riot,
				/obj/effect/spawner/bundle/f13/armor/combat/mk2,
				/obj/effect/spawner/bundle/f13/armor/combat/mk2/dark,
				/obj/item/clothing/suit/armor/medium/raider/reptiliatenebris
				)
*/
/obj/effect/spawner/bundle/f13/armor/t45b_salvaged
	name = "salvaged t45b power armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b,
				/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b
				)

/obj/effect/spawner/bundle/f13/armor/riot
	name = "riot armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/riot/combat,
				/obj/item/clothing/head/helmet/f13/combat/rangerbroken
				)

/obj/effect/spawner/bundle/f13/armor/vault
	name = "vault armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/vest/bulletproof/big,
				/obj/item/clothing/head/helmet/riot/vaultsec,
				)

/obj/effect/spawner/bundle/f13/armor/combat/mk2
	name = "MkII combat armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/combat/mk2,
				/obj/item/clothing/head/helmet/f13/combat/mk2
				)

/obj/effect/spawner/bundle/f13/armor/combat/mk2/dark
	name = "dark MkII combat armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/medium/combat/mk2/dark,
				/obj/item/clothing/head/helmet/f13/combat/mk2/dark
				)

/obj/effect/spawner/bundle/f13/armor/raiderpa
	name = "raider power armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/raider,
				/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/raider
				)

/obj/effect/spawner/bundle/f13/armor/hotrodpa
	name = "hotrod power armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/hotrod,
				/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/hotrod
				)


/obj/effect/spawner/lootdrop/f13/armor/tier5 //TIER 5 ARMOR
	name = "tier 5 armor"
	loot = list(
				/obj/effect/spawner/bundle/f13/armor/t45d,
				/obj/effect/spawner/bundle/f13/armor/t51b,
				)

/obj/effect/spawner/bundle/f13/armor/t45d
	name = "t45d power armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/power_armor/t45d,
				/obj/item/clothing/head/helmet/f13/power_armor/t45d,
				)

/obj/effect/spawner/bundle/f13/armor/t51b
	name = "t51b power armor spawner"
	items = list(
				/obj/item/clothing/suit/armor/power_armor/t51b,
				/obj/item/clothing/head/helmet/f13/power_armor/t51b,
				)

/*
/obj/effect/spawner/lootdrop/f13/armor/random
	name = "random armor loot"
	lootcount = 1

	loot = list(
			/obj/effect/spawner/lootdrop/f13/armor/tier1 = 90,
			/obj/effect/spawner/lootdrop/f13/armor/tier2 = 9,
			/obj/effect/spawner/lootdrop/f13/armor/tier3 = 1,
			)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/mid
	name = "high tier random armor loot"
	lootcount = 1

	loot = list(
			/obj/effect/spawner/lootdrop/f13/armor/tier2 = 70,
			/obj/effect/spawner/lootdrop/f13/armor/tier3 = 35,
			/obj/effect/spawner/lootdrop/f13/armor/tier4 = 10
			///obj/item/traumapack = 1 //one ring to rule them all
			)
*/
/*	------------------------------------------------
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
				/obj/item/clothing/suit/hooded/surgical,
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
/*
/obj/effect/spawner/lootdrop/f13/medical/vault
	name = "vault medical spawner - DO NOT USE"

/obj/effect/spawner/lootdrop/f13/medical/vault/equipment
	name = "vault medical equipment spawner"
	lootcount = 1

	loot = list(
				/obj/item/defibrillator/compact/combat/loaded,
				/obj/item/reagent_containers/hypospray/combat,
				/obj/item/disk/medical/defib_heal
				)

/obj/effect/spawner/lootdrop/f13/medical/vault/meds  //no drugs, didn't add
	name = "vault medical meds spawner"
	lootcount = 1

	loot = list(
				/obj/item/reagent_containers/hypospray/medipen/stimpak,
				/obj/item/storage/pill_bottle/chem_tin/radx,
				/obj/item/reagent_containers/blood/radaway,
				/obj/item/storage/pill_bottle/chem_tin/mentats
				)

/obj/effect/spawner/lootdrop/f13/medical/wasteland
	name = "wasteland medical spawner - DO NOT USE"

/obj/effect/spawner/lootdrop/f13/medical/wasteland/meds //remove equipment, has nothing on it
	name = "wasteland meds spawner"
	lootcount = 1

	loot = list(/obj/item/reagent_containers/pill/healingpowder,
				/obj/item/storage/pill_bottle/chem_tin/radx,
				/obj/item/reagent_containers/blood/radaway,
				/obj/item/storage/pill_bottle/chem_tin/mentats,
				/obj/item/reagent_containers/hypospray/medipen/stimpak,
				/obj/item/reagent_containers/medspray/styptic,
				/obj/item/reagent_containers/medspray/silver_sulf,
				/obj/item/reagent_containers/medspray/sterilizine,
				/obj/item/storage/pill_bottle/chem_tin/fixer,
				/obj/item/reagent_containers/pill/patch/psycho,
				)

/obj/effect/spawner/lootdrop/f13/medical/wasteland/meds/drug //remove equipment, has nothing on it
	name = "wasteland drugs spawner"
	lootcount = 1

	loot = list(
				/obj/item/reagent_containers/pill/patch/jet,
				/obj/item/reagent_containers/pill/patch/turbo,
				/obj/item/reagent_containers/pill/healingpowder,
				/obj/item/reagent_containers/pill/stimulant,
				/obj/item/reagent_containers/pill/patch/medx,
				/obj/item/storage/pill_bottle/chem_tin/buffout,
				/obj/item/reagent_containers/pill/patch/steady,
				/obj/item/reagent_containers/pill/patch/psycho,
				/obj/item/storage/pill_bottle/chem_tin/mentats,
				)


/obj/effect/spawner/lootdrop/f13/medical/rnd/mid
	name = "mid dungeon science loot"	//to replace guns as treasure in slightly protected areas
	lootcount = 1

	loot = list(
		/obj/item/screwdriver/power,
		/obj/item/wrench/power,
		/obj/item/storage/box/medicine/stimpaks/stimpaks5,
		/obj/item/stack/sheet/prewar/twenty,
		/obj/item/stack/sheet/plastic/twenty,
		/obj/item/defibrillator/primitive,
		/obj/item/reagent_containers/syringe/bluespace,
		)


/obj/effect/spawner/lootdrop/f13/medical/rnd/good
	name = "good dungeon science loot"	//to replace guns as treasure in heavily guarded areas
	lootcount = 1

	loot = list(
		/obj/item/reagent_containers/glass/beaker/meta = 5,
		/obj/item/stack/sheet/mineral/abductor/ten = 5,
		/obj/item/scalpel/advanced = 5,
		/obj/item/surgical_drapes/advanced = 5,
		//obj/effect/spawner/bundle/f13/needler = 5, //needler needs some fixins
		/obj/item/clothing/glasses/night = 5,
		/obj/item/circuitboard/machine/chem_dispenser/apothecary = 5,
		/obj/item/storage/box/stockparts/deluxe = 5,
		/obj/item/storage/box/emps = 5,
		/obj/item/organ/cyberimp/arm/janitor = 5,
		/obj/item/reagent_containers/glass/bottle/fentanyl = 5,
		/obj/item/reagent_containers/glass/bottle/frostoil = 5,
		/obj/item/book/granter/trait/midsurgery = 5,
		/obj/item/reagent_containers/glass/bottle/FEV_solution = 2,
		/obj/item/reagent_containers/glass/bottle/FEV_solution/two = 2,
		)
*/
/*
/obj/effect/spawner/lootdrop/f13/medical/random_fev
	name = "random FEV bottle"	//for when you can't decide what is worse
	lootcount = 1

	loot = list(
		/obj/item/reagent_containers/glass/bottle/FEV_solution = 1,
		/obj/item/reagent_containers/glass/bottle/FEV_solution/two = 1,
		/obj/item/reagent_containers/glass/bottle/FEV_solution/curling = 1,
		)
*/
/*	------------------------------------------------
	--------------WEAPON SPAWNERS-------------------
	------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon
	name = "weapon spawners - DO NOT USE THIS"
	icon_state = "gun_loot"

/*current weapon rarity chart, for reference. can be fine tuned later (I have no idea how weapon spawns will quite look after this big change):
common: 10 (normal rarity)
uncommon: 5 (either a little stronger or a lil more special looking)
very common: 20 (weapons we want exceptionally lots of)
very rare: 1 (weapons we want to be a rare prize)

power levels:
wasteland tier weapons are comparible to starter weapons, or slightly better
they are found just about everywhere: closets, trash, old buildings, etc.

dungeon tier weapons are comparible to the service rifle, 10mm smg, etc. decent but not outstanding.
they are found in nooks and crannies within dungeons, and more dangerous or far away areas

boss tier weapons are very strong, semi-auto .308 rifles, automatic 5.56, and high capacity submachineguns
they are found at the end of dungeons, in small numbers, as a reward

unique tier weapons include weapons with unique skins, famed names, or extremely powerful effects
there should be very few of these spawns on the whole map. finding one should be a prize
*/

/*
/obj/effect/spawner/lootdrop/f13/weapon/wasteland
	name = "wasteland weapons, found anywhere"
	loot = list(
		/obj/item/gun/ballistic/automatic/smg/smg10mm/worn = 1,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi = 5,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40 = 1,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22 = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10 = 5,
		/obj/item/gun/ballistic/automatic/m1carbine = 10,
		/obj/item/gun/ballistic/automatic/m1carbine/compact = 5,
		/obj/item/gun/ballistic/automatic/delisle = 10,
		/obj/item/gun/ballistic/automatic/delisle/commando = 1,
		/obj/item/gun/ballistic/automatic/sportcarbine = 20,
		/obj/item/gun/ballistic/automatic/varmint = 10,
		/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun = 1,
		/obj/item/gun/ballistic/automatic/assault_carbine/policerifle = 1, // decently strong, but small chance, and hard to scavange ammo for
		/obj/item/gun/ballistic/automatic/pistol/pistol22 = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22 = 5,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 20,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93 = 5,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger = 5,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby = 5,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/auto = 5,
		/obj/item/gun/ballistic/automatic/pistol/beretta = 5,
		/obj/item/gun/ballistic/automatic/pistol/beretta/carbine = 5,
		/obj/item/gun/ballistic/automatic/pistol/n99 = 10,
		/obj/item/gun/ballistic/automatic/pistol/type17 = 5,
		/obj/item/gun/ballistic/automatic/pistol/sig = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 10,
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 1,
		/obj/item/gun/ballistic/revolver/detective = 10,
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/gun/ballistic/revolver/colt357 = 10,
		/obj/item/gun/ballistic/revolver/police = 10,
		/obj/item/gun/ballistic/revolver/m29 = 10,
		/obj/item/gun/ballistic/revolver/m29/alt = 1,
		/obj/item/gun/ballistic/revolver/m29/snub = 5,
		/obj/item/gun/ballistic/revolver/revolver44 = 1,
		/obj/item/gun/ballistic/revolver/thatgun = 10,
		/obj/item/gun/ballistic/rifle/repeater/cowboy = 10,
		/obj/item/gun/ballistic/rifle/hunting = 10,
		/obj/item/gun/ballistic/rifle/antique/gras = 5,
		/obj/item/gun/ballistic/rifle/mosin = 5,
		/obj/item/gun/ballistic/rifle/enfield = 5,
		/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
		/obj/item/gun/ballistic/revolver/widowmaker = 10,
		/obj/item/gun/ballistic/revolver/shotpistol = 5,
		/obj/item/gun/ballistic/shotgun/hunting = 10,
		/obj/item/gun/ballistic/automatic/hobo/zipgun = 20, //lets make junk guns very common~
		/obj/item/gun/ballistic/revolver/hobo/piperifle = 20,
		/obj/item/gun/ballistic/revolver/hobo/pepperbox = 20,
		/obj/item/gun/ballistic/revolver/hobo/single_shotgun = 10,
		/obj/item/gun/ballistic/revolver/hobo/knifegun = 20,
		/obj/item/gun/ballistic/revolver/hobo/knucklegun = 5,
		/obj/item/gun/ballistic/automatic/autopipe = 5,
		/obj/item/gun/ballistic/revolver/winchesterrebored = 10,
		/obj/item/gun/energy/laser/retro = 1,
		/obj/item/gun/energy/laser/wattz = 10,
		/obj/item/gun/energy/laser/wattzs = 10,
		/obj/item/gun/energy/laser/pistol = 5,
		/obj/item/gun/energy/laser/complianceregulator = 1,
		/obj/item/gun/energy/laser/auto = 10,
		/obj/item/melee/onehanded/machete = 10,
		/obj/item/melee/onehanded/machete/forgedmachete = 10,
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/melee/onehanded/machete/scrapsabre = 5,
		/obj/item/throwing_star/spear = 10,
		/obj/item/melee/onehanded/knife/hunting = 10,
		/obj/item/melee/onehanded/knife/survival = 10,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/melee/onehanded/knife/bowie = 5,
		/obj/item/melee/onehanded/knife/trench = 1,
		/obj/item/melee/onehanded/knife/switchblade = 10,
		/obj/item/melee/onehanded/knife/cosmicdirty = 5,
		/obj/item/melee/onehanded/knife/throwing = 20,
		/obj/item/melee/onehanded/club = 20,
		/obj/item/melee/onehanded/club/tireiron = 20,
		/obj/item/melee/unarmed/brass = 20,
		/obj/item/melee/unarmed/brass/spiked = 5,
		/obj/item/melee/unarmed/sappers = 10,
		/obj/item/twohanded/fireaxe = 10,
		/obj/item/twohanded/fireaxe/bmprsword = 5,
		/obj/item/twohanded/spear = 10,
		/obj/item/twohanded/spear/scrapspear = 10,
		/obj/item/twohanded/baseball = 20,
		/obj/item/twohanded/baseball/spiked = 5,
		/obj/item/twohanded/baseball/golfclub = 10,
		/obj/item/twohanded/sledgehammer/simple = 10,
		/obj/item/twohanded/chainsaw = 1,
		/obj/item/melee/transforming/plasmacutter/regular/celestia = 1,
		/obj/item/melee/unarmed/yaoguaigauntlet = 1,
		/obj/item/melee/onehanded/club/fryingpan = 20,
		/obj/item/shovel/trench = 1,
		/obj/item/gun/ballistic/bow/lightxbow = 10,
		/obj/item/gun/ballistic/bow/recurvebow = 20,
		/obj/item/gun/flintlock = 10,
		/obj/item/gun/flintlock/laser = 5,
)

/obj/effect/spawner/lootdrop/f13/weapon/dungeon
	name = "dungeon weapons, found in nooks and corners"
	loot = list(
		/obj/item/gun/ballistic/automatic/smg/american180 = 10,
		/obj/item/gun/ballistic/automatic/smg/smg10mm = 20,
		/obj/item/gun/ballistic/automatic/m1carbine/m2 = 5,
		/obj/item/gun/ballistic/automatic/smg/mp5sd = 5,
		/obj/item/gun/ballistic/automatic/smg/sidewinder = 20,
		/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum = 1,
		/obj/item/gun/ballistic/automatic/combat = 10,
		/obj/item/gun/ballistic/automatic/service = 20,
		/obj/item/gun/ballistic/automatic/service/alr = 1,
		/obj/item/gun/ballistic/automatic/service/carbine = 1,
		/obj/item/gun/ballistic/automatic/marksman = 5,
		/obj/item/gun/ballistic/automatic/marksman/policerifle = 10,
		/obj/item/gun/ballistic/revolver/police/webley = 10,
		/obj/item/gun/ballistic/automatic/assault_carbine = 10,
		/obj/item/gun/ballistic/automatic/armalite = 10,
		/obj/item/gun/ballistic/automatic/l1a1 = 10,
		/obj/item/gun/ballistic/revolver/grenadelauncher = 5,
		/obj/item/gun/ballistic/shotgun/grenade = 5,
		/obj/item/gun/ballistic/automatic/pistol/beretta/automatic = 10,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion = 10,
		/obj/item/gun/ballistic/automatic/pistol/type17/c96auto = 5,
		/obj/item/gun/ballistic/automatic/pistol/schmeisser = 10,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 10,
		/obj/item/gun/ballistic/revolver/hunting = 10,
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 5,
		/obj/item/gun/ballistic/revolver/colt357/auto = 5,
		/obj/item/gun/ballistic/rifle/repeater/trail = 20,
		/obj/item/gun/ballistic/rifle/repeater/ranger = 10,
		/obj/item/gun/ballistic/shotgun/trench = 10,
		/obj/item/gun/ballistic/shotgun/automatic/combat/auto5 = 10,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock = 5,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 5,
		/obj/item/gun/ballistic/automatic/hobo/destroyer = 1,
		/obj/item/gun/ballistic/rifle/hunting/obrez = 5,
		/obj/item/gun/energy/laser/wattz/recharger = 1,
		/obj/item/gun/energy/laser/wattz2k = 10,
		/obj/item/gun/energy/laser/wattz2ks = 5,
		/obj/item/gun/energy/laser/aer9 = 20,
		/obj/item/gun/energy/laser/plasma/pistol = 5,
		/obj/item/melee/onehanded/machete/spatha = 10,
		/obj/item/melee/unarmed/tigerclaw = 10,
		/obj/item/melee/unarmed/lacerator = 10,
		/obj/item/melee/unarmed/maceglove = 10,
		/obj/item/melee/unarmed/punchdagger = 10,
		/obj/item/shishkebabpack = 5,
		/obj/item/twohanded/baseball/louisville = 10,
		/obj/item/melee/transforming/plasmacutter/regular = 5,
		/obj/item/gun/ballistic/bow/longbow = 20,
		/obj/item/gun/ballistic/bow/crossbow = 10,
)

/obj/effect/spawner/lootdrop/f13/weapon/boss
	name = "boss loot weapons, found at the end of dungeons"
	loot = list(
		/obj/item/gun/ballistic/automatic/smg/greasegun = 10,
		/obj/item/gun/ballistic/automatic/smg/cg45 = 5,
		/obj/item/gun/ballistic/automatic/smg/tommygun = 10,
		/obj/item/gun/ballistic/automatic/smg/p90 = 1,
		/obj/item/gun/ballistic/automatic/smg/ppsh = 1,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5 = 10,
		/obj/item/gun/ballistic/automatic/rangemaster = 5,
		/obj/item/gun/ballistic/automatic/slr = 5,
		/obj/item/gun/ballistic/automatic/m1garand = 5,
		/obj/item/gun/ballistic/automatic/m1garand/sks = 1,
		/obj/item/gun/ballistic/automatic/marksman/sniper = 5,
		/obj/item/gun/ballistic/automatic/service/r82 = 20, //is weakest 5.56 automatic
		/obj/item/gun/ballistic/automatic/assault_rifle = 10,
		/obj/item/gun/ballistic/automatic/r93 = 5,
		/obj/item/gun/ballistic/automatic/lewis = 5,
		/obj/item/gun/ballistic/automatic/type93 = 10,
		/obj/item/gun/ballistic/automatic/g11 = 1,
		/obj/item/gun/ballistic/automatic/lsw = 5,
		/obj/item/m2flamethrowertank = 1,
		/obj/item/gun/ballistic/rocketlauncher = 5,
		/obj/item/gun/ballistic/automatic/pistol/deagle = 10,
		/obj/item/gun/ballistic/automatic/pistol/automag = 10,
		/obj/item/gun/ballistic/automatic/pistol/pistol14 = 5,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/compact = 1,
		/obj/item/gun/ballistic/revolver/m2405 = 5,
		/obj/item/gun/ballistic/revolver/sequoia = 10,
		/obj/item/gun/ballistic/rifle/repeater/brush = 20, //pretty common cause we need cowboy guns
		/obj/item/gun/ballistic/rifle/mag/boys = 10,
		/obj/item/gun/ballistic/rifle/mag/antimaterial = 5,
		/obj/item/gun/ballistic/shotgun/police = 10,
		/obj/item/gun/ballistic/shotgun/automatic/combat/neostead = 1,
		/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller = 10,
		/obj/item/gun/ballistic/automatic/shotgun/riot = 5,
		/obj/item/gun/energy/laser/ultra_pistol = 1,
		/obj/item/gun/energy/laser/scatter = 1,
		/obj/item/gun/energy/laser/aer12 = 10,
		/obj/item/gun/energy/laser/rcw = 5,
		/obj/item/gun/energy/laser/plasma/glock = 5,
		/obj/item/gun/energy/laser/plasma = 5,
		/obj/item/gun/energy/ionrifle = 5,
		/obj/item/gun/energy/laser/wattz2k/extended = 10,
		/obj/item/gun/energy/laser/solar = 15,
		/obj/item/melee/powerfist/f13 = 10,
		/obj/item/gun/ballistic/revolver/ballisticfist = 1,
		/obj/item/melee/powered/ripper = 5,
		/obj/item/twohanded/legionaxe = 10,
		/obj/item/twohanded/thermic_lance = 5,
		/obj/item/melee/transforming/energy/axe/protonaxe = 5,
		/obj/item/twohanded/sledgehammer/supersledge = 10,
		/obj/item/twohanded/sledgehammer/rockethammer = 5,
		/obj/item/melee/transforming/plasmacutter/regular/eve = 5,
		/obj/item/gun/ballistic/automatic/fnfal = 5,
		/obj/item/gun/ballistic/automatic/bar = 5,
		/obj/item/gun/ballistic/bow/compoundbow = 20,
)

/obj/effect/spawner/lootdrop/f13/weapon/unique
	name = "unique loot weapons, found in only the most dangerous of places"
	loot = list(
		/obj/item/gun/ballistic/automatic/smg/smg14 = 1,
		/obj/item/gun/ballistic/automatic/sportcarbine/m1_22 = 1,//
		/obj/item/gun/ballistic/automatic/varmint/ratslayer = 20,//
		/obj/item/gun/ballistic/automatic/m1garand/oldglory = 10,//
		/obj/item/gun/ballistic/automatic/m1garand/republicspride = 10,
		/obj/item/gun/ballistic/automatic/marksman/sniper/gold = 10,
		/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator = 20,//
		/obj/item/gun/ballistic/automatic/bozar = 10,
		/obj/item/gun/ballistic/automatic/wt550 = 5,
		/obj/item/gun/ballistic/automatic/r84 = 10,
		/obj/item/gun/ballistic/automatic/lewis/lanoe = 10,
		/obj/item/gun/ballistic/automatic/m1919 = 10,
		/obj/item/gun/ballistic/automatic/m72 = 5,
		/obj/item/gun/ballistic/automatic/xl70e3 = 10,
		/obj/item/minigunpackbal5mm = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/maria = 20,//
		/obj/item/gun/ballistic/automatic/pistol/n99/executive = 20,//
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 20,//
		/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan = 10,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil = 20,
		/obj/item/gun/ballistic/revolver/colt357/lucky = 20,//
		/obj/item/gun/ballistic/rifle/hunting/paciencia = 20,
		//obj/item/gun/energy/laser/captain = 5, //needs some work before this is added
		/obj/item/gun/energy/laser/badlands = 10,
		/obj/item/gun/energy/laser/scatter/nonlethal = 20,
		/obj/item/gun/energy/laser/scatter/laserbuss = 10,
		/obj/item/gun/energy/laser/aer14 = 10,
		/obj/item/gun/energy/laser/laer = 5,
		/obj/item/gun/energy/laser/plasma/pistol/alien = 1,
		/obj/item/minigunpack = 1,
		/obj/item/gun/energy/laser/plasma/pistol/eve = 10,
		/obj/item/gun/energy/laser/plasma/pistol/adam = 5,
		/obj/item/gun/energy/laser/plasma/carbine = 10,
		/obj/item/gun/energy/laser/plasma/scatter = 5,
		/obj/item/gun/energy/ionrifle/carbine = 10,
		//obj/item/gun/energy/emitter = 5, //fun lil gun. make it normal sized, do maybe 40 damage, and use an energy cell with 10 shots. we'll see where it goes
		/obj/item/gun/energy/tesla/teslacannon = 10, //it'll be fiiiiine
		/obj/item/melee/onehanded/dragonfire = 1, //edgy
		/obj/item/melee/unarmed/aethergiestgauntlet = 20,
		/obj/item/melee/powerfist/f13/goliath = 20,
		/obj/item/melee/powered/ripper/prewar = 20,
		/obj/item/twohanded/spear/bonespear/aethergiest = 20, //sure why not
		/obj/item/twohanded/sledgehammer/atomsjudgement = 10,
		/obj/item/sord = 20, //for the meme
		/obj/item/melee/transforming/plasmacutter/regular/adam = 10,
		/obj/item/gun/ballistic/automatic/smg/american180/b180 = 10,
		/obj/item/gun/ballistic/fatman = 5,
)
*/
/*
/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/garbagetomid //not bothering to change the path name, since it's still used in other portions of code
	name = "burrow gun spawns"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/weapon/wasteland = 20,
		/obj/effect/spawner/lootdrop/f13/medical/wasteland/meds/drug = 20, //might be too high. will see
		/obj/effect/spawner/lootdrop/f13/junkspawners = 20,
		/obj/item/stack/medical/gauze/improvised = 10,
		/obj/item/stack/medical/ointment/five = 5,
		/obj/item/stack/medical/suture/emergency/five = 5,
		/obj/effect/spawner/lootdrop/f13/armor/tier1 = 10,
		/obj/item/stack/f13Cash/random/low = 10,
		/obj/effect/spawner/lootdrop/plush/dangerous = 5, //plushies!
		/obj/item/stealthboy = 1,
		/obj/effect/spawner/lootdrop/f13/weapon/dungeon = 1 //very very smol chance of getting a shiny gun
)
*/
/obj/effect/spawner/lootdrop/plush/dangerous
	name = "random plushie spawner with tiny chance of changeling plush or dehydrated carp"
	loot = list(
		/obj/effect/spawner/lootdrop/plush = 100,
		/obj/item/toy/plush/carpplushie/dehy_carp = 1,
		/obj/item/toy/plush/plushling = 1
)

/*	------------------------------------------------
	-----------MELEE WEAPON SPAWNERS----------------
	------------------------------------------------ */

/* old spawn lists, no longer needed

/obj/effect/spawner/lootdrop/f13/weapon/melee
	name = "melee spawners - DO NOT USE THIS"
	icon_state = "melee_loot"

/obj/effect/spawner/bundle/f13/throwingknife3
	name = "throwing knife spawner - 3"
	items = list(
				/obj/item/melee/onehanded/knife/throwing,
				/obj/item/melee/onehanded/knife/throwing,
				/obj/item/melee/onehanded/knife/throwing,
				)


/obj/effect/spawner/lootdrop/f13/weapon/melee/tier1 //TIER 1 MELEE WEAPON
	name = "tier 1 melee"
	lootcount = 1
	loot = list(/obj/item/crowbar,
				/obj/item/extinguisher,
				/obj/item/hatchet,
				/obj/item/pickaxe/mini,
				/obj/item/wrench,
				/obj/item/kitchen/knife,
				/obj/item/kitchen/rollingpin,
				/obj/item/weldingtool,
				/obj/item/gavelhammer,
				/obj/item/oar,
				/obj/item/pickaxe,
				/obj/item/shovel,
				/obj/item/instrument/guitar,
				/obj/item/surgicaldrill,
				/obj/item/melee/transforming/plasmacutter/regular/celestia
				)


/obj/effect/spawner/lootdrop/f13/weapon/melee/tier2 //TIER 2 MELEE WEAPON
	name = "tier 2 melee"
	lootcount = 1

	loot = list(/obj/effect/spawner/bundle/f13/throwingknife3,
				/obj/item/melee/onehanded/knife/switchblade,
				/obj/item/throwing_star/spear,
				/obj/item/melee/onehanded/knife/hunting,
				/obj/item/melee/onehanded/knife/survival,
				/obj/item/melee/onehanded/knife/bone,
				/obj/item/twohanded/spear/scrapspear,
				/obj/item/melee/onehanded/club,
				/obj/item/melee/onehanded/knife/cosmicdirty,
				/obj/item/melee/onehanded/machete,
				/obj/item/melee/unarmed/brass,
				/obj/item/melee/unarmed/brass/spiked,
				/obj/item/melee/transforming/plasmacutter/regular
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 //TIER 3 MELEE WEAPON
	name = "tier 3 melee"
	lootcount = 1

	loot = list(/obj/effect/spawner/bundle/f13/throwingknife3,
				/obj/item/twohanded/spear,
				/obj/item/twohanded/baseball,
				/obj/item/kitchen/knife/butcher,
				/obj/item/twohanded/baseball/golfclub,
				/obj/item/melee/onehanded/machete/forgedmachete,
				/obj/item/shield/riot/buckler,
				/obj/item/melee/unarmed/tigerclaw,
				/obj/item/melee/unarmed/sappers,
				/obj/item/melee/transforming/plasmacutter/regular/eve
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 //TIER 4 MELEE WEAPON
	name = "tier 4 melee"
	lootcount = 1

	loot = list(/obj/item/twohanded/fireaxe,
				/obj/item/twohanded/sledgehammer/simple,
				/obj/item/twohanded/fireaxe/bmprsword,
				/obj/item/melee/unarmed/lacerator,
				/obj/item/melee/unarmed/maceglove,
				/obj/item/melee/unarmed/punchdagger,
				/obj/item/twohanded/baseball/louisville,
				/obj/item/shield/riot,
				/obj/item/melee/onehanded/machete/gladius,
				/obj/item/melee/onehanded/machete/spatha,
				/obj/item/melee/transforming/plasmacutter/regular/adam
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/tier5 //TIER 5 MELEE WEAPON
	name = "tier 5 melee"
	lootcount = 1

	loot = list(/obj/item/twohanded/thermic_lance,
				/obj/item/twohanded/chainsaw,
				/obj/item/twohanded/sledgehammer/rockethammer,
				/obj/item/melee/powered/ripper,
				/obj/item/melee/powerfist/f13,
				/obj/item/melee/transforming/energy/axe/protonaxe,
				/obj/item/gun/ballistic/revolver/ballisticfist,
				/obj/item/twohanded/sledgehammer/supersledge,
				/obj/item/melee/powerfist/f13/goliath,
				/obj/item/shishkebabpack,
				/obj/item/melee/unarmed/aethergiestgauntlet,
				/obj/item/melee/powerfist/f13/moleminer
				)

/obj/effect/spawner/lootdrop/f13/weapon/melee/random
	name = "random melee loot"
	lootcount = 1

	loot = list(
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier1 = 40,
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier2 = 30,
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 = 20,
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 = 10
			)

/obj/effect/spawner/lootdrop/f13/weapon/melee/random_mid
	name = "mid tier random melee loot"
	loot = list(
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier3 = 20,
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 = 10
			)

/obj/effect/spawner/lootdrop/f13/weapon/melee/random_high
	name = "high tier random melee loot"
	lootcount = 1
	loot = list(/obj/effect/spawner/lootdrop/f13/weapon/melee/tier4 = 2,
			/obj/effect/spawner/lootdrop/f13/weapon/melee/tier5 = 1
			)

/*	------------------------------------------------
	-------------GUN WEAPON SPAWNERS----------------
	------------------------------------------------ */

/obj/effect/spawner/lootdrop/f13/weapon/gun
	name = "gun spawners - DO NOT USE THIS"
	icon_state = "gun_loot"

//Energy Weapon Spawners
/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/low
	name = "low tier energy gun"
	loot = list(/obj/effect/spawner/bundle/f13/wattz = 35,
				/obj/effect/spawner/bundle/f13/wattzm = 25,
				/obj/item/gun/energy/laser/wattzs = 10,
				/obj/effect/spawner/bundle/f13/laserpistol = 20,
				/obj/item/gun/energy/laser/auto = 20
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/mid
	name = "mid tier energy gun"
	loot = list(/obj/effect/spawner/bundle/f13/aer9 = 40,
				///obj/effect/spawner/bundle/f13/aer12 = 13, Now a high tier gun.
				/obj/effect/spawner/bundle/f13/wattz2k = 30,
				///obj/effect/spawner/bundle/f13/wattz2kext = 10, Now a high tier gun.
				/obj/effect/spawner/bundle/f13/plasmapistol = 25,
				/obj/effect/spawner/bundle/f13/ionrifle = 5
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/midhigh //overlaps with midtier
	name = "mid-high tier energy gun"
	loot = list(/obj/effect/spawner/bundle/f13/aer12 = 15,
				/obj/item/gun/energy/laser/aer9/focused = 20,
				/obj/effect/spawner/bundle/f13/plasmapistol = 25,
				/obj/effect/spawner/bundle/f13/wattz2kext = 15,
				/obj/effect/spawner/bundle/f13/ionrifle = 25
				///obj/effect/spawner/bundle/f13/aer14 //die
				)
/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/high
	name = "high tier energy gun"
	loot = list(/obj/effect/spawner/bundle/f13/plasmarifle = 20,
				/obj/effect/spawner/bundle/f13/aer12 = 10,
				/obj/effect/spawner/bundle/f13/tribeam = 20,
				/obj/effect/spawner/bundle/f13/rcw = 20,
				/obj/effect/spawner/bundle/f13/wattz2kext = 10, //Now a high tier gun.
				///obj/effect/spawner/bundle/f13/aer14, kill
				/obj/effect/spawner/bundle/f13/plasmaglock = 20
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/superhigh
	name = "superhigh tier energy gun"
	loot = list(/obj/effect/spawner/bundle/f13/multiplas,
				/obj/item/gun/energy/laser/plasma/pistol/alien
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/energy/unique
	name = "unique tier energy gun"
	lootcount = 1

	loot = list(/obj/item/gun/energy/laser/solar,
				/obj/item/gun/energy/laser/badlands,
				/obj/item/gun/energy/laser/scatter/laserbuss,
				/obj/item/gun/energy/laser/plasma/pistol/eve,
				/obj/item/gun/energy/laser/wattz2ks,
				/obj/item/gun/energy/laser/plasma/pistol/adam
				)

//Ballistic Weapon Spawners
/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/hobo
	name = "hobo tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/pepperbox,
				/obj/effect/spawner/bundle/weapon/piperifle,
				/obj/effect/spawner/bundle/f13/zipgun,
				/obj/item/gun/ballistic/revolver/hobo/knifegun,
				/obj/item/gun/ballistic/revolver/hobo/knucklegun,
				/obj/effect/spawner/bundle/f13/autopipe,
				/obj/effect/spawner/bundle/f13/pistol22,
				/obj/item/gun/ballistic/revolver/winchesterrebored
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/superlow
	name = "very low tier non-hobo ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/ninemil,
				/obj/effect/spawner/bundle/f13/caravan_shotgun,
				/obj/item/gun/ballistic/rifle/hunting, //No. More. Mosin.
				/obj/effect/spawner/bundle/f13/remington,
				/obj/effect/spawner/bundle/f13/shotpistol,
				/obj/effect/spawner/bundle/f13/sportcarbine,
				/obj/effect/spawner/bundle/f13/widowmaker,
				/obj/effect/spawner/bundle/f13/varmint
				)


/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/low
	name = "low tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/m1911 = 5,
				/obj/effect/spawner/bundle/f13/thatgun = 5,
				/obj/effect/spawner/bundle/f13/n99 = 5,
				/obj/effect/spawner/bundle/f13/colt357 = 5,
				/obj/effect/spawner/bundle/f13/huntingshotgun = 4,
				/obj/effect/spawner/bundle/f13/police_pistol = 5,
				/obj/effect/spawner/bundle/f13/guns/commando = 5,
				/obj/effect/spawner/bundle/f13/m1carbine = 5,
				/obj/effect/spawner/bundle/f13/sidewinder_carbine = 1,
				/obj/effect/spawner/bundle/f13/mini22uzi = 2
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/garbagetomid
	name = "burrow gun spawns"
	loot = list(/obj/effect/spawner/bundle/f13/m1911 = 5,
				/obj/effect/spawner/bundle/f13/thatgun = 4,
				/obj/effect/spawner/bundle/f13/n99 = 4,
				/obj/effect/spawner/bundle/f13/colt357 = 5,
				/obj/effect/spawner/bundle/f13/huntingshotgun = 2,
				/obj/effect/spawner/bundle/f13/police_pistol = 2,
				/obj/effect/spawner/bundle/f13/guns/commando = 2,
				/obj/effect/spawner/bundle/f13/m1carbine = 3,
				/obj/effect/spawner/bundle/f13/wattz = 1,
				/obj/item/gun/energy/laser/wattzs = 3,
				/obj/item/gun/energy/laser/auto = 1,
				/obj/item/gun/ballistic/rifle/mosin = 1,
				/obj/item/gun/ballistic/rifle/hunting = 3,
				/obj/item/gun/ballistic/automatic/pistol/type17 = 3,
				/obj/effect/spawner/lootdrop/f13/junkspawners = 32,
				/obj/item/stack/medical/gauze/improvised = 2,
				/obj/item/stack/medical/ointment/five = 2,
				/obj/item/stack/medical/suture/emergency/five = 2,
				/obj/effect/spawner/lootdrop/f13/armor/tier1 = 8,
				/obj/item/stack/f13Cash/random/low = 10,
				/obj/item/gun/ballistic/automatic/smg/american180 = 1,
				/obj/effect/spawner/bundle/f13/sportcarbine = 1,
				/obj/effect/spawner/bundle/f13/ninemil = 1,
				/obj/effect/spawner/bundle/f13/widowmaker = 2,
				/obj/effect/spawner/bundle/f13/sig = 4,
				/obj/effect/spawner/bundle/f13/varmint = 2,
				/obj/item/stealthboy = 1
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/lowmid
	name = "low-mid tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/n99,
				/obj/effect/spawner/bundle/f13/cowboy,
				/obj/effect/spawner/bundle/f13/mk23,
				/obj/effect/spawner/bundle/f13/hunting,
				/obj/effect/spawner/bundle/f13/mini22uzi,
				/obj/effect/spawner/lootdrop/f13/weapon/revolver44variants,
				/obj/effect/spawner/bundle/f13/trenchshotgun,
				/obj/effect/spawner/bundle/f13/m1carbine,
				/obj/effect/spawner/bundle/f13/sidewinder_carbine,
				/obj/effect/spawner/bundle/f13/sidewinder_magnum,
				/obj/effect/spawner/bundle/f13/huntingshotgun,
				/obj/effect/spawner/bundle/f13/revolver45
		)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/mid
	name = "mid tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/trail,
				/obj/effect/spawner/bundle/f13/service,
				/obj/effect/spawner/bundle/f13/miniuzi,
				/obj/effect/spawner/bundle/f13/auto5,
				/obj/effect/spawner/bundle/f13/marksman,
				/obj/effect/spawner/bundle/f13/m1garand,
				/obj/effect/spawner/bundle/f13/sidewinder_magnum,
				/obj/effect/spawner/bundle/f13/sidewinder,
				/obj/effect/spawner/bundle/f13/deagle,
				/obj/effect/spawner/bundle/f13/automag,
				/obj/item/gun/ballistic/automatic/pistol/schmeisser,
				/obj/item/gun/ballistic/rifle/repeater/ranger,
				/obj/item/gun/ballistic/automatic/smg/american180
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/highmid
	name = "high-mid tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/mp5,
				/obj/effect/spawner/bundle/f13/combat_rifle,
				/obj/effect/spawner/bundle/f13/smg10mm,
				/obj/effect/spawner/bundle/f13/needler,
				/obj/effect/spawner/bundle/f13/marksman,
				/obj/effect/spawner/bundle/f13/guns/tommygun,
				/obj/effect/spawner/bundle/f13/shotgunlever,
				/obj/effect/spawner/bundle/f13/brushgun,
				/obj/item/gun/ballistic/automatic/armalite,
				/obj/item/gun/ballistic/rifle/repeater/ranger
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/high
	name = "high tier ballistic gun"
	loot = list(/obj/item/gun/ballistic/automatic/type93 = 15,
				/obj/effect/spawner/bundle/f13/dkssniper = 15,
				/obj/effect/spawner/bundle/f13/pistol14 = 15,
				/obj/item/gun/ballistic/revolver/grenadelauncher = 5,
				/obj/item/gun/ballistic/rocketlauncher = 5,
				/obj/effect/spawner/bundle/f13/riotshotgun = 10,
				/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller = 10,
				/obj/effect/spawner/bundle/f13/guns/p90 = 2,
				)


/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/superhigh
	name = "superhigh tier ballistic gun"
	loot = list(/obj/effect/spawner/bundle/f13/riotshotgun = 5,
				/obj/effect/spawner/bundle/f13/amr = 10,
				/obj/effect/spawner/bundle/f13/assault_rifle = 15,
				/obj/effect/spawner/bundle/f13/r84 = 10,
				/obj/effect/spawner/bundle/f13/brushgun = 15,
				/obj/effect/spawner/bundle/f13/rangemaster = 15,
				/obj/effect/spawner/bundle/f13/fnfal = 10,
				/obj/item/gun/ballistic/rocketlauncher = 10,
				/obj/item/gun/ballistic/automatic/bozar = 10,
				/obj/effect/spawner/bundle/f13/infiltrator = 15
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/superhighcargo //this loot table is for the prewar cargo crate
	name = "superhigh tier ballistic gun (cargo)"
	loot = list(/obj/effect/spawner/bundle/f13/amr = 5,
				/obj/item/gun/ballistic/rocketlauncher = 10,
				/obj/item/gun/ballistic/automatic/bozar = 7,
				/obj/effect/spawner/bundle/f13/m1919 = 5,
				/obj/effect/spawner/bundle/f13/guns/p90 = 7,
				/obj/effect/spawner/bundle/f13/dks = 10
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ballistic/unique
	name = "unique tier ballistic gun"
	lootcount = 1

	loot = list(
				/obj/item/gun/ballistic/automatic/pistol/ninemil/maria,
				/obj/item/gun/ballistic/rifle/hunting/paciencia,
				/obj/item/gun/ballistic/automatic/varmint/ratslayer,
				/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator,
				/obj/item/gun/ballistic/revolver/colt357/lucky,
				/obj/item/gun/ballistic/automatic/m1garand/oldglory,
				/obj/item/gun/ballistic/automatic/marksman/sniper/gold,
				/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil
				)


//Random-pick pools so that regular spawners aren't super diluted with shit like 3 .44 revolver variants

/obj/effect/spawner/lootdrop/f13/weapon/revolver44variants
	name = "random spawner for .44 revolvers/variants"
	loot = list(/obj/effect/spawner/bundle/f13/revolverm29,
				/obj/effect/spawner/bundle/f13/revolverm29alt,
				/obj/effect/spawner/bundle/f13/revolver44,
				/obj/effect/spawner/bundle/f13/revolverm29snub
	)



//Gun Bundles
/obj/effect/spawner/bundle/f13/zipgun
	name = "zip gun spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/hobo/zipgun,
				/obj/item/ammo_box/magazine/zipgun
				)

/obj/effect/spawner/bundle/f13/single_shotgun
	name = "shotgun bat and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/single_shotgun,
				/obj/item/ammo_box/generic/shotgun/improvised
				)

/obj/effect/spawner/bundle/f13/caravan_shotgun
	name = "caravan shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/caravan_shotgun,
				/obj/item/ammo_box/generic/shotgun/improvised
				)

/obj/effect/spawner/bundle/f13/mosin
	name = "mosin nagant and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/mosin,
				/obj/item/ammo_box/a762
				)

/obj/effect/spawner/bundle/f13/remington
	name = "hunting rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/hunting,
				/obj/item/ammo_box/a308
				)

/obj/effect/spawner/bundle/f13/shotpistol
	name = "shotpistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/shotpistol,
				/obj/item/ammo_box/generic/shotgun/buck
				)

/obj/effect/spawner/bundle/f13/n99
	name = "10mm pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/n99,
				/obj/item/ammo_box/magazine/m10mm/adv/simple/
				)

/obj/effect/spawner/bundle/f13/m1911
	name = "m1911 and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/m1911,
				/obj/item/ammo_box/magazine/m45
				)

/obj/effect/spawner/bundle/f13/ninemil
	name = "9mm pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/ninemil,
				/obj/item/ammo_box/magazine/m9mm/doublestack
				)

/obj/effect/spawner/bundle/f13/varmint
	name = "varmint rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/varmint,
				/obj/item/ammo_box/magazine/m556/rifle
				)

/obj/effect/spawner/bundle/f13/pistol22
	name = ".22 pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/pistol22,
				/obj/item/ammo_box/magazine/m22
				)

/obj/effect/spawner/bundle/f13/beretta
	name = "beretta pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/beretta,
				/obj/item/ammo_box/magazine/m9mm/doublestack/
				)

/obj/effect/spawner/bundle/f13/sig
	name = " p220 pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/sig,
				/obj/item/ammo_box/magazine/m45
				)

/obj/effect/spawner/bundle/f13/pepperbox
	name = "pepperbox gun spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/hobo/pepperbox,
				/obj/item/ammo_box/c10mm/improvised,
				)

/obj/effect/spawner/bundle/f13/huntingshotgun
	name = "hunting shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/hunting,
				/obj/item/ammo_box/generic/shotgun/buck
				)

/obj/effect/spawner/bundle/f13/shotgunlever
	name = "lever action shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever,
				/obj/item/ammo_box/generic/shotgun/buck
	)

/obj/effect/spawner/bundle/f13/revolverm29
	name = "m29 revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/m29,
				/obj/item/ammo_box/m44/
				)

/obj/effect/spawner/bundle/f13/revolverm29alt
	name = "alt m29 revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/m29/alt,
				/obj/item/ammo_box/m44
	)

/obj/effect/spawner/bundle/f13/revolverm29snub
	name = "m29 snub-nose revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/m29/snub,
				/obj/item/ammo_box/m44/
				)


/obj/effect/spawner/bundle/f13/automag
	name = "automag and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/automag,
				/obj/item/ammo_box/magazine/m44/automag
	)

/obj/effect/spawner/bundle/f13/revolver45
	name = "s&w revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/revolver45,
				/obj/item/ammo_box/c45rev
	)

/obj/effect/spawner/bundle/f13/cowboy
	name = "cowboy repeater and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/repeater/cowboy,
				/obj/item/ammo_box/tube/a357/
				)

/obj/effect/spawner/bundle/f13/colt357
	name = "colt 357 and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/colt357,
				/obj/item/ammo_box/c38
				)

/obj/effect/spawner/bundle/f13/service
	name = "NCR service rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/service,
				/obj/item/ammo_box/magazine/m556/rifle
				)

/obj/effect/spawner/bundle/f13/police_pistol
	name = "police revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/police,
				/obj/item/ammo_box/c38
	)

/obj/effect/spawner/bundle/f13/laserpistol
	name = "AEP7 laser pistol and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/pistol,
				/obj/item/stock_parts/cell/ammo/ec
	)

/obj/effect/spawner/bundle/f13/m1carbine
	name = "m1 carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/m1carbine,
				/obj/item/ammo_box/magazine/m10mm/adv/simple
	)

/obj/effect/spawner/bundle/f13/sidewinder
	name = "sidewinder and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/sidewinder,
				/obj/item/ammo_box/magazine/uzim9mm
	)

/obj/effect/spawner/bundle/f13/sidewinder_carbine
	name = "sidewinder carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/sidewinder/worn,
				/obj/item/ammo_box/magazine/m9mm/doublestack
	)

/obj/effect/spawner/bundle/f13/sidewinder_magnum
	name = "sidewinder magnum and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum,
				/obj/item/ammo_box/magazine/m14mm
	)

/obj/effect/spawner/bundle/f13/guns/commando
	name = "de lisle carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/delisle,
				/obj/item/ammo_box/magazine/m9mm/doublestack
	)

/obj/effect/spawner/bundle/f13/mk23
	name = "mk23 and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/mk23,
				/obj/item/ammo_box/magazine/m45/socom/
	)

/obj/effect/spawner/bundle/f13/thatgun
	name = "223 pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/thatgun,
				/obj/item/ammo_box/a308
	)

/obj/effect/spawner/bundle/f13/widowmaker
	name = "widowmaker spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/widowmaker
				)

/obj/effect/spawner/bundle/f13/autopipe
	name = "auto pipe rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/autopipe,
				/obj/item/ammo_box/magazine/autopipe
				)

/obj/effect/spawner/bundle/f13/miniuzi
	name = "mini uzi and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/mini_uzi,
				/obj/item/ammo_box/magazine/uzim9mm
				)

/obj/effect/spawner/bundle/f13/mini22uzi
	name = "mini 22 uzi and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22,
				/obj/item/ammo_box/magazine/m22/extended
				)

/obj/effect/spawner/bundle/f13/sportcarbine
	name = "sport carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/sportcarbine,
				/obj/item/ammo_box/magazine/m22/extended
				)

/obj/effect/spawner/bundle/f13/smg10mm
	name = "10mm SMG and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/smg10mm,
				/obj/item/ammo_box/magazine/m10mm/adv/ext/
				)

/obj/effect/spawner/bundle/f13/greasegun
	name = "m3a1 grease gun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/greasegun,
				/obj/item/ammo_box/magazine/greasegun/
				)

/obj/effect/spawner/bundle/f13/guns/auto5
	name = "auto-5 shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/automatic/combat/auto5,
				/obj/item/ammo_box/generic/shotgun/buck,
				)

/obj/effect/spawner/bundle/f13/trenchshotgun
	name = "trench shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/trench,
				/obj/item/ammo_box/generic/shotgun/buck,
				)

/obj/effect/spawner/bundle/f13/wattz
	name = "Wattz laser rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/wattz,
				/obj/item/stock_parts/cell/ammo/ec
				)

/obj/effect/spawner/bundle/f13/wattzm
	name = "Wattz magneto pistol and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/wattz/magneto,
				/obj/item/stock_parts/cell/ammo/ec
	)

/obj/effect/spawner/bundle/f13/needler
	name = "needler and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/needler,
				/obj/item/ammo_box/needle
				)

/obj/effect/spawner/bundle/f13/trail
	name = "trail carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/repeater/trail,
				/obj/item/ammo_box/tube/m44/
				)

/obj/effect/spawner/bundle/f13/revolver44
	name = ".44 revolver and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/revolver44,
				/obj/item/ammo_box/m44/
				)

/obj/effect/spawner/bundle/f13/beretta/select
	name = "select-fire beretta pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/beretta/automatic,
				/obj/item/ammo_box/magazine/m9mm/doublestack/
				)

/obj/effect/spawner/bundle/f13/deagle
	name = "Desert Eagle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/ammo_box/magazine/m44/
				)

/obj/effect/spawner/bundle/f13/pistol14
	name = "14mm pistol and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/pistol/pistol14,
				/obj/item/ammo_box/magazine/m14mm
	)

/obj/effect/spawner/bundle/f13/neostead
	name = "Neostead 2000 shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/automatic/combat/neostead,
				/obj/item/ammo_box/generic/shotgun/slug,
				/obj/item/ammo_box/generic/shotgun/buck
	)

/obj/effect/spawner/bundle/f13/auto5
	name = "Auto 5 shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/shotgun/automatic/combat/auto5,
				/obj/item/ammo_box/generic/shotgun/buck,
				/obj/item/ammo_box/generic/shotgun/slug
	)

// Obsolete
/obj/effect/spawner/bundle/f13/smg22
	name = "american 180 spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/american180
				)

/obj/effect/spawner/bundle/f13/assault_rifle
	name = "assault rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/assault_rifle,
				/obj/item/ammo_box/magazine/m556/rifle/assault/
				)

/obj/effect/spawner/bundle/f13/assault_carbine
	name = "assault carbine and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/assault_carbine,
				/obj/item/ammo_box/magazine/m5mm
				)

/obj/effect/spawner/bundle/f13/marksman
	name = "marksman rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/marksman,
				/obj/item/ammo_box/magazine/m556/rifle/
				)

/obj/effect/spawner/bundle/f13/combat_rifle
	name = "combat rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/combat,
				/obj/item/ammo_box/magazine/tommygunm45/stick
				)

/obj/effect/spawner/bundle/f13/rcw
	name = "laser RCW and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/rcw,
				/obj/item/stock_parts/cell/ammo/ecp
				)

/obj/effect/spawner/bundle/f13/plasmapistol
	name = "plasma pistol and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/plasma/pistol,
				/obj/item/stock_parts/cell/ammo/ec
				)

/obj/effect/spawner/bundle/f13/aer9
	name = "AER9 laser rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/aer9,
				/obj/item/stock_parts/cell/ammo/mfc
				)

/obj/effect/spawner/bundle/f13/infiltrator
	name = "infiltrator rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator,
				/obj/item/ammo_box/magazine/m556/rifle/
				)

/obj/effect/spawner/bundle/f13/brushgun
	name = "brush gun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/repeater/brush,
				/obj/item/ammo_box/tube/c4570/
				)

/obj/effect/spawner/bundle/f13/m1garand
	name = "m1 garand and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/m1garand,
				/obj/item/ammo_box/magazine/garand308
	)

/obj/effect/spawner/bundle/f13/dkssniper
	name = "dks sniper and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/marksman/sniper,
				/obj/item/ammo_box/magazine/w308
	)

/obj/effect/spawner/bundle/f13/rangemaster
	name = "rangemaster rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/rangemaster,
				/obj/item/ammo_box/magazine/m762/
				)

/obj/effect/spawner/bundle/f13/riotshotgun
	name = "riot shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/shotgun/riot,
				/obj/item/ammo_box/magazine/d12g/
				)

/obj/effect/spawner/bundle/f13/ionrifle
	name = "ion rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/ionrifle,
				/obj/item/stock_parts/cell/ammo/mfc
				)

/obj/effect/spawner/bundle/f13/plasmaglock
	name = "plasma glock and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/plasma/glock,
				/obj/item/stock_parts/cell/ammo/ec
				)

/obj/effect/spawner/bundle/f13/wattz2k
	name = "Wattz 2000 laser rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/wattz2k,
				/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/wattz2kext
	name = "Wattz 2000 laser extended laser rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/wattz2k/extended,
				/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/mp5
	name = "mp5 and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/mp5sd,
				/obj/item/ammo_box/magazine/uzim9mm/
	)

/obj/effect/spawner/bundle/f13/citykiller
	name = "citykiller and ammo spawner"
	items = list(
		/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller,
		/obj/item/ammo_box/generic/shotgun/buck
	)

/obj/effect/spawner/bundle/f13/guns/p90
	name = "P90 SMG spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/p90,
				/obj/item/ammo_box/magazine/m10mm_p90/
	)

/obj/effect/spawner/bundle/f13/hunting
	name = "hunting revolver spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/hunting,
				/obj/item/ammo_box/c4570/
	)

/obj/effect/spawner/bundle/f13/riotshotgun
	name = "riot shotgun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/shotgun/riot,
				/obj/item/ammo_box/magazine/d12g/
	)

/obj/effect/spawner/bundle/f13/aer12
	name = "aer12 and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/aer12,
				/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/r84
	name = "r84 spawner"
	items = list(
		/obj/item/gun/ballistic/automatic/r84,
		/obj/item/ammo_box/magazine/m556/rifle/extended/
	)

/obj/effect/spawner/bundle/f13/bozar
	name = "bozar and ammo spawner"
	items = list(
			/obj/item/gun/ballistic/automatic/bozar,
			/obj/item/ammo_box/magazine/m556/rifle/extended/
	)

/obj/effect/spawner/bundle/f13/plasmarifle
	name = "plasma rifle and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/plasma,
				/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/guns/tommygun
	name = "tommygun and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/smg/tommygun,
				/obj/item/ammo_box/magazine/tommygunm45/
	)

/obj/effect/spawner/bundle/f13/aer14
	name = "aer14 and ammo spawner"
	items = list(
		/obj/item/gun/energy/laser/aer14,
		/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/amr
	name = "amr and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rifle/mag/antimaterial,
				/obj/item/ammo_box/magazine/amr/
	)

/obj/effect/spawner/bundle/f13/tribeam
	name = "tribeam and ammo spawner"
	items = list(
		/obj/item/gun/energy/laser/scatter,
		/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/multiplas
	name = "multiplas and ammo spawner"
	items = list(
				/obj/item/gun/energy/laser/plasma/scatter,
				/obj/item/stock_parts/cell/ammo/mfc
	)

/obj/effect/spawner/bundle/f13/gauss
	name = "gauss rifle and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/m72,
				/obj/item/ammo_box/magazine/m2mm
	)

/obj/effect/spawner/bundle/f13/fnfal
	name = "fn fal and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/automatic/fnfal,
				/obj/item/ammo_box/magazine/m762/ext
	)

/obj/effect/spawner/bundle/f13/bar
	name = "automatic rifle and ammo spawner"
	items = list(
			/obj/item/gun/ballistic/automatic/bar,
			/obj/item/ammo_box/magazine/m762/ext,
	)

/obj/effect/spawner/bundle/f13/rocketlauncher
	name = "rocket launcher and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/rocketlauncher,
				/obj/item/ammo_casing/caseless/rocket
	)

/obj/effect/spawner/bundle/f13/grenadelauncher
	name = "grenade launcher and ammo spawner"
	items = list(
				/obj/item/gun/ballistic/revolver/grenadelauncher,
				/obj/item/ammo_box/a40mm
	)
/obj/effect/spawner/bundle/f13/m1919
	name = "browning m1919 and ammo spawner"
	items = list(/obj/item/gun/ballistic/automatic/m1919,
				/obj/item/ammo_box/magazine/mm308
				)

/obj/effect/spawner/bundle/f13/dks
	name ="dks 501 and ammo spawner"
	items = list(/obj/item/gun/ballistic/automatic/marksman/sniper/sniperranger,
	/obj/item/ammo_box/magazine/w308
	)
*/

/*	------------------------------------------------
	------------WEAPON AMMO SPAWNERS----------------
	------------------------------------------------ */
/*
/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo
	name = "ammo spawners - DO NOT USE THIS"
	icon_state = "ammo_loot"

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier1
	name = "tier 1 ammo"
	lootcount = 2 //2 random ammo
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/magazine/m9mm,
				/obj/item/ammo_box/generic/shotgun/buck,
				/obj/item/ammo_box/generic/shotgun/slug,
				/obj/item/ammo_box/magazine/m10mm/adv/simple,
				/obj/item/ammo_box/magazine/m556/rifle/small
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier2
	name = "tier 2 ammo"
	lootdoubles = TRUE

	loot = list(
				/obj/item/ammo_box/magazine/m45,
				/obj/item/ammo_box/a3006,
				/obj/item/ammo_box/a308,
				/obj/item/ammo_box/magazine/m10mm/adv/simple,
				/obj/item/ammo_box/magazine/m556/rifle,
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
				/obj/item/ammo_box/generic/shotgun/buck,
				/obj/item/ammo_box/magazine/uzim9mm,
				/obj/item/ammo_box/magazine/m10mm/adv/simple,
				/obj/item/ammo_box/magazine/greasegun,
				/obj/item/ammo_box/magazine/tommygunm45/stick,
				/obj/item/ammo_box/tube/m44,
				/obj/item/ammo_box/magazine/m10mm/adv/ext,
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
				/obj/item/ammo_box/magazine/m44,
				/obj/item/ammo_box/magazine/m556/rifle,
				/obj/item/ammo_box/c4570,
				/obj/item/ammo_box/tube/c4570,
				/obj/item/ammo_box/a50MG,
				/obj/item/ammo_box/a308/doublestacked,
				/obj/item/stock_parts/cell/ammo/mfc,
				/obj/item/ammo_casing/caseless/rocket,
				/obj/item/ammo_box/a40mm,
				/obj/item/ammo_box/a40mm/hedp,
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
				/obj/item/ammo_box/magazine/m308/ext,
				/obj/item/ammo_box/magazine/d12g,
				/obj/item/ammo_box/a50MG/penetrator,
				/obj/item/ammo_casing/caseless/rocket/big,
				/obj/item/ammo_casing/caseless/rocket/incendiary = 10,
				/obj/item/ammo_casing/caseless/rocket/chem = 3,
				/obj/item/ammo_box/a40mm,
				/obj/item/ammo_box/magazine/tommygunm45
				)

/obj/effect/spawner/lootdrop/f13/weapon/gun/ammo/tier5/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2, 3, 4)
	. = ..()
*/
/*
//BOMBS N GRENADES
/obj/effect/spawner/loot/f13/bomb
	name = "DO NOT USE THIS BASIC SPAWNER"
	icon_state = "ammo_loot"

/obj/effect/spawner/lootdrop/f13/bomb/tier1
	name = "tier 1 grenade spawner"
	icon_state = "ammo_loot"
	lootdoubles = TRUE
	lootcount = 2 //2 random grenades
	loot = list(
				/obj/item/grenade/homemade/coffeepotbomb,
				/obj/item/grenade/homemade/firebomb,
				/obj/item/grenade/flashbang,
				/obj/item/reagent_containers/food/drinks/bottle/molotov,
				/obj/item/grenade/smokebomb
				)

/obj/effect/spawner/lootdrop/f13/bomb/tier2
	loot = list(
				/obj/item/grenade/f13/frag = 30,
				/obj/item/grenade/flashbang,
				/obj/item/grenade/f13/stinger,
				/obj/item/grenade/empgrenade = 50
				)

/obj/effect/spawner/lootdrop/f13/bomb/tier3
	loot = list(
				/obj/item/grenade/syndieminibomb/concussion,
				/obj/item/grenade/plastic/c4,
				/obj/item/grenade/empgrenade,
				/obj/item/grenade/f13/radiation,
				/obj/item/grenade/f13/frag,
				/obj/item/gun/ballistic/revolver/grenadelauncher,
				)
/obj/effect/spawner/lootdrop/f13/bomb/top_tier
	lootcount = 1
	loot = list(
				/obj/item/grenade/f13/plasma,
				/obj/item/grenade/f13/incendiary,
				/obj/item/grenade/f13/radiation,
				/obj/item/grenade/plastic/x4,
				/obj/item/grenade/stingbang/shred = 1,
				/obj/item/gun/ballistic/rocketlauncher,
				)
*/
/*
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
				/obj/item/stack/cable_coil/random,
				/obj/item/stack/medical/bruise_pack,
				/obj/item/trash/popcorn,
				/obj/item/valentine,
				/obj/item/taperecorder,
				/obj/item/tape/random,
				/obj/item/stack/medical/gauze,
				/obj/item/trash/plate,
				/obj/item/storage/box/snappops,
				/obj/item/trash/f13/rotten,
				/obj/item/trash/f13/tin,
				/obj/item/trash/f13/dog,
				/obj/item/trash/f13/dandyapples,
				/obj/item/storage/crayons,
				/obj/item/stack/packageWrap,
				/obj/item/storage/box/matches,
				/obj/item/reagent_containers/food/snacks/deadmouse,
				/obj/item/toner,
				/obj/item/tank/internals/oxygen,
				/obj/item/storage/box/papersack,
				/obj/item/storage/box/lights/mixed,
				/obj/item/reagent_containers/food/drinks/sillycup,
				/obj/item/restraints/handcuffs/cable/zipties,
				/obj/item/storage/pill_bottle,
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
*/

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
					/obj/item/seeds/chanterelle,
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
				/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans,
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
				)


/obj/effect/spawner/lootdrop/f13/foodspawner/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2)
	. = ..()
/*
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
				/obj/item/reagent_containers/glass/bottle/blackpowder)

/obj/effect/spawner/lootdrop/f13/crafting/Initialize(mapload) //on mapload, pick how many shit to spawn
	lootcount = pick(1, 2)
	. = ..()
*/

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

/*
/obj/effect/spawner/lootdrop/f13/resourcespawner //now include R N G (TM) (higher number means it has a bigger spawn chance)
	name = "resource spawner"
	lootcount = 2

	loot = list(
				/obj/item/stack/rods/ten = 3,
				/obj/item/stack/sheet/metal/ten = 5,
				/obj/item/stack/sheet/cardboard/twenty = 1,
//				/obj/item/stack/sheet/glass/ten = 2,
				/obj/item/stack/sheet/metal/five = 2,
				/obj/item/stack/sheet/plasteel/five = 1,
				/obj/item/stack/sheet/plastic/five = 4,
				/obj/item/stack/sheet/cloth/ten = 1,
				/obj/item/stack/crafting/metalparts/five = 4,
				/obj/item/stack/crafting/goodparts/three = 2
				)
*/
// Updated money spawners to era match to Coyote Bayou's date, 2222. ~TK420634
// Also, fuck this multi-tiered way of trying to spawn money into the game.  Cludged together crap, my dude.


/*
/obj/effect/spawner/lootdrop/f13/cash_random_low
	name = "low value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/low = 50 /*,
				/obj/item/stack/f13Cash/random/ncr/low = 30,
				/obj/item/stack/f13Cash/random/denarius/low = 30,
				/obj/item/stack/f13Cash/random/aureus/low = 10 */
				)

/obj/effect/spawner/lootdrop/f13/cash_random_med
	name = "medium value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/med = 43,
				// /obj/item/stack/f13Cash/random/ncr/med = 35,
				/obj/item/stack/f13Cash/random/denarius/med = 20,
				/obj/item/stack/f13Cash/random/aureus/med = 5,
				//obj/item/stack/f13Cash/random/low = 40,
				// /obj/item/stack/f13Cash/random/ncr/low = 19,
				/obj/item/stack/f13Cash/random/denarius/low = 35,
				/obj/item/stack/f13Cash/random/aureus/low = 5,
				//obj/item/stack/f13Cash/random/high = 2
				// /obj/item/stack/f13Cash/random/ncr/high = 1,
				/obj/item/stack/f13Cash/random/denarius/high = 2,
				/obj/item/stack/f13Cash/random/aureus/high = 1,
				)

/obj/effect/spawner/lootdrop/f13/cash_random_high
	name = "high value cash spawner"
	lootcount = 1

	loot = list(
				/obj/item/stack/f13Cash/random/high = 25,
				/obj/item/stack/f13Cash/random/med = 50,
				/obj/item/stack/f13Cash/random/low = 10,
				// /obj/item/stack/f13Cash/random/ncr/high = 30,
				/obj/item/stack/f13Cash/random/denarius/high = 30,
				/obj/item/stack/f13Cash/random/aureus/high = 10,
				//obj/item/stack/f13Cash/random/med = 50,
				//obj/item/stack/f13Cash/random/ncr/med = 15,
				/obj/item/stack/f13Cash/random/denarius/med = 15,
				/obj/item/stack/f13Cash/random/aureus/med = 5,
				//obj/item/stack/f13Cash/random/low = 10,
				//obj/item/stack/f13Cash/random/ncr/low = 5,
				/obj/item/stack/f13Cash/random/denarius/low = 5,
				/obj/item/stack/f13Cash/random/aureus/low = 1,
				)
*/
/*
/obj/effect/spawner/lootdrop/f13/cash_legion_low
	name = "low value legion cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/denarius/low = 50,
			/obj/item/stack/f13Cash/random/aureus/low = 30,
			/obj/item/stack/f13Cash/random/low = 10,
			/obj/item/stack/f13Cash/random/denarius/med = 10,
			/obj/item/stack/f13Cash/random/aureus/med = 5,
			/obj/item/stack/f13Cash/random/med = 1,
			)

/obj/effect/spawner/lootdrop/f13/cash_legion_med
	name = "medium value legion cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/denarius/med = 50,
			/obj/item/stack/f13Cash/random/aureus/med = 30,
			/obj/item/stack/f13Cash/random/med = 10,
			/obj/item/stack/f13Cash/random/denarius/high = 10,
			/obj/item/stack/f13Cash/random/aureus/high = 5,
			/obj/item/stack/f13Cash/random/high = 1,
			/obj/item/stack/f13Cash/random/denarius/low = 10,
			/obj/item/stack/f13Cash/random/aureus/low = 5,
			/obj/item/stack/f13Cash/random/low = 1,
			)

/obj/effect/spawner/lootdrop/f13/cash_legion_high
	name = "high value legion cash spawner"
	lootcount = 1
	loot = list(
		/obj/item/stack/f13Cash/random/denarius/high = 50,
		/obj/item/stack/f13Cash/random/aureus/high = 30,
		/obj/item/stack/f13Cash/random/high = 10,
		/obj/item/stack/f13Cash/random/denarius/med = 10,
		/obj/item/stack/f13Cash/random/aureus/med = 5,
		/obj/item/stack/f13Cash/random/med = 1,
		)


/obj/effect/spawner/lootdrop/f13/cash_ncr_low
	name = "low value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/low = 50,
			/obj/item/stack/f13Cash/random/low = 10,
			/obj/item/stack/f13Cash/random/ncr/med = 25,
			/obj/item/stack/f13Cash/random/med = 5,
			)

/obj/effect/spawner/lootdrop/f13/cash_ncr_med
	name = "medium value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/med = 50,
			/obj/item/stack/f13Cash/random/med = 10,
			/obj/item/stack/f13Cash/random/ncr/high = 25,
			/obj/item/stack/f13Cash/random/high = 5,
			)

/obj/effect/spawner/lootdrop/f13/cash_ncr_high
	name = "high value ncr cash spawner"
	lootcount = 1
	loot = list(
			/obj/item/stack/f13Cash/random/ncr/high = 50,
			/obj/item/stack/f13Cash/random/high = 10,
			/obj/item/stack/f13Cash/random/ncr/med = 25,
			/obj/item/stack/f13Cash/random/med = 5,
			)
*/
/*
/obj/effect/spawner/lootdrop/f13/deadrodent_or_brainwashdisk
	name = "100% chance of deceased rodent"
	loot = list(
		/obj/item/reagent_containers/food/snacks/deadmouse = 50)


/obj/effect/spawner/lootdrop/f13/traitbooks
	name = "trait book spawner"
	lootcount = 1
	loot = list(/obj/item/book/granter/trait/explosives = 10,
				/obj/item/book/granter/trait/explosives_advanced = 5,
				/obj/item/book/granter/crafting_recipe/gunsmith_two = 20,
				/obj/item/book/granter/crafting_recipe/gunsmith_three = 10,
				/obj/item/book/granter/crafting_recipe/gunsmith_four = 10
				)

/obj/effect/spawner/lootdrop/f13/traitbooks/low
	name = "low trait book spawner"
	lootcount = 1
	loot = list(/obj/item/book/granter/crafting_recipe/scav_one = 10,
				/obj/item/book/granter/crafting_recipe/scav_two = 10,
				/obj/item/book/granter/trait/explosives = 10,
				/obj/item/book/granter/crafting_recipe/ODF = 10,
				/obj/item/book/granter/action/drink_fling = 10,
				/obj/item/book/granter/crafting_recipe/gunsmith_one = 10,
				)
/obj/effect/spawner/lootdrop/f13/blueprintLow
	name = "gun comps spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/advanced_crafting_components/flux,
		/obj/item/advanced_crafting_components/lenses,
		/obj/item/advanced_crafting_components/conductors,
		/obj/item/advanced_crafting_components/receiver,
		/obj/item/advanced_crafting_components/assembly,
		/obj/item/advanced_crafting_components/alloys,
		/obj/item/gun_upgrade/scope/watchman,
		/obj/item/gun_upgrade/trigger/raidertrigger,
		/obj/item/tool_upgrade/productivity/ergonomic_grip,
		/obj/item/tool_upgrade/refinement/ported_barrel,
		/obj/item/tool_upgrade/productivity/red_paint
	)

/obj/effect/spawner/lootdrop/f13/blueprintLowPartsWeighted
	name = "parts and mods spawner (weighted towards parts)"
	icon_state = "blueprint_loot"
	lootcount = 3
	lootdoubles = FALSE
	loot = list(
		/obj/item/advanced_crafting_components/flux = 2,
		/obj/item/advanced_crafting_components/lenses = 2,
		/obj/item/advanced_crafting_components/conductors = 2,
		/obj/item/advanced_crafting_components/receiver = 2,
		/obj/item/advanced_crafting_components/assembly = 2,
		/obj/item/advanced_crafting_components/alloys = 2,
		/obj/item/gun_upgrade/scope/watchman,
		/obj/item/gun_upgrade/trigger/raidertrigger,
		/obj/item/tool_upgrade/productivity/ergonomic_grip,
		/obj/item/tool_upgrade/refinement/ported_barrel,
		/obj/item/tool_upgrade/productivity/red_paint
	)
*/
/* weapon schematic spawns disabled until it can be reworked to something reasonable.

/obj/effect/spawner/lootdrop/f13/blueprintLowMid
	name = "blueprint-tier(Mid-Low) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/thatgun,
		/obj/item/book/granter/crafting_recipe/blueprint/uzi,
		/obj/item/book/granter/crafting_recipe/blueprint/greasegun,
		/obj/item/book/granter/crafting_recipe/blueprint/commando,
		/obj/item/book/granter/crafting_recipe/blueprint/m1carbine,
		/obj/item/book/granter/crafting_recipe/blueprint/schmeisser,
	)
/obj/effect/spawner/lootdrop/f13/blueprintMid
	name = "blueprint-tier(Mid) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/service,
		/obj/item/book/granter/crafting_recipe/blueprint/trailcarbine,
		/obj/item/book/granter/crafting_recipe/blueprint/smg10mm,
		/obj/item/book/granter/crafting_recipe/blueprint/aep7,
		/obj/item/book/granter/crafting_recipe/blueprint/scoutcarbine,
		/obj/item/book/granter/crafting_recipe/blueprint/sniper,
		/obj/item/book/granter/crafting_recipe/blueprint/armalite,
	)


/obj/effect/spawner/lootdrop/f13/blueprintHigh
	name = "blueprint-tier(High) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/leveraction,
		/obj/item/book/granter/crafting_recipe/blueprint/r91,
		/obj/item/book/granter/crafting_recipe/blueprint/r84,
		/obj/item/book/granter/crafting_recipe/blueprint/deagle,
		/obj/item/book/granter/crafting_recipe/blueprint/marksman,
		/obj/item/book/granter/crafting_recipe/blueprint/combatrifle,
		/obj/item/book/granter/crafting_recipe/blueprint/plasmapistol,
		/obj/item/book/granter/crafting_recipe/blueprint/brushgun,
		/obj/item/book/granter/crafting_recipe/blueprint/r82
	)


/obj/effect/spawner/lootdrop/f13/blueprintVHigh
	name = "blueprint-tier(VHigh) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/neostead,
		/obj/item/book/granter/crafting_recipe/blueprint/riotshotgun,
		/obj/item/book/granter/crafting_recipe/blueprint/aer9,
	)

/obj/effect/spawner/lootdrop/f13/blueprintVHighBallistics
	name = "blueprint-tier(VHighBallistics) item spawner"
	icon_state = "blueprint_loot"
	lootcount = 1
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/gauss,
		/obj/item/book/granter/crafting_recipe/blueprint/am_rifle,
		/obj/item/book/granter/crafting_recipe/blueprint/citykiller,
		/obj/item/book/granter/crafting_recipe/blueprint/rangemaster,
		/obj/item/book/granter/crafting_recipe/blueprint/bozar
	)

/obj/effect/spawner/lootdrop/f13/blueprintVHighPartsWeighted
	name = "parts and mods spawner (weighted towards blueprints)"
	icon_state = "blueprint_loot"
	lootcount = 3
	lootdoubles = FALSE
	loot = list(
		/obj/item/book/granter/crafting_recipe/blueprint/r91 = 3,
		/obj/item/book/granter/crafting_recipe/blueprint/r84 = 3,
		/obj/item/book/granter/crafting_recipe/blueprint/am_rifle = 3,
		/obj/item/book/granter/crafting_recipe/blueprint/rangemaster = 3,
		/obj/item/advanced_crafting_components/flux,
		/obj/item/advanced_crafting_components/lenses,
		/obj/item/advanced_crafting_components/conductors,
		/obj/item/advanced_crafting_components/receiver,
		/obj/item/advanced_crafting_components/assembly,
		/obj/item/advanced_crafting_components/alloys,
	)

*/
/*
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
		/obj/item/ingot/adamantine, // Valuable for smithing
	)

/obj/effect/spawner/lootdrop/f13/attachments
	name = "attachments"
	lootcount = 1
	lootdoubles = FALSE
	loot = list(
		/obj/item/gun_upgrade/scope/watchman,
		/obj/item/gun_upgrade/trigger/raidertrigger,
		/obj/item/tool_upgrade/productivity/ergonomic_grip,
		/obj/item/tool_upgrade/refinement/ported_barrel,
		/obj/item/tool_upgrade/refinement/stabilized_grip,
		/obj/item/tool_upgrade/refinement/laserguide,
		/obj/item/tool_upgrade/productivity/booster,
		/obj/item/tool_upgrade/productivity/red_paint
	)

/obj/effect/spawner/lootdrop/f13/npc_raider
	name = "loot drop"
	lootcount = 1
	lootdoubles = FALSE
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/beretta,
		/obj/item/gun/ballistic/automatic/pistol/ninemil
	)
*/
/obj/effect/spawner/lootdrop/f13/ncr_c_ration
	name = "c-ration spawner"
	icon = 'icons/obj/storage.dmi'
	icon_state = "c-ration"
	lootcount = 1
	loot = list(
			/obj/item/storage/box/ration/menu_one,
			/obj/item/storage/box/ration/menu_two,
			/obj/item/storage/box/ration/menu_three,
			/obj/item/storage/box/ration/menu_four,
			/obj/item/storage/box/ration/menu_five,
			/obj/item/storage/box/ration/menu_six,
			/obj/item/storage/box/ration/menu_seven,
			/obj/item/storage/box/ration/menu_eight,
			/obj/item/storage/box/ration/menu_nine,
			/obj/item/storage/box/ration/menu_ten,
			/obj/item/storage/box/ration/menu_eleven,
			)

/obj/effect/spawner/lootdrop/f13/ncr_k_ration
	name = "c-ration spawner"
	icon = 'icons/obj/storage.dmi'
	icon_state = "k-ration"
	lootcount = 1
	loot = list(
			/obj/item/storage/box/ration/ranger_breakfast,
			/obj/item/storage/box/ration/ranger_lunch,
			/obj/item/storage/box/ration/ranger_dinner,
			)

/obj/effect/spawner/lootdrop/f13/deadantloot //12 out of 22 chance to get ores, 8 / 22 for the jackpot ones
	name = "dead ant loot"
	lootcount = 1
	loot = list(
		/obj/item/stack/sheet/mineral/sandstone = 1,
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/uranium = 4,
		/obj/item/stack/ore/silver = 3,
		/obj/item/stack/ore/slag = 2,
		/obj/item/stack/ore/plasma = 3,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/glass = 2,
		/obj/item/stack/ore/iron = 2,
		/obj/item/stack/ore/titanium = 2)

/obj/effect/spawner/lootdrop/f13/bounty
	name = "f13 spawners - DO NOT USE THIS"
	lootdoubles = FALSE	//making sure it will /not/ double
	fan_out_items = TRUE //Randomize pixel x and y
	downtier_chance = 50
	lootcount = 1
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"

/obj/effect/spawner/lootdrop/f13/bounty/low
	name = "none to low bounty ticket spawner, 50% chance for nothing"
	loot = list(/obj/item/card/lowbounty)
	color = "#00ff00"

/obj/effect/spawner/lootdrop/f13/bounty/low_to_med
	name = "low to medium bounty ticket spawner, 50% chance for nothing"
	loot = list(/obj/item/card/lowbounty, /obj/item/card/midbounty)
	color = "#0000ff"

/obj/effect/spawner/lootdrop/f13/bounty/med_to_high
	name = "low to medium bounty ticket spawner, 50% chance for nothing"
	loot = list(/obj/item/card/midbounty, /obj/item/card/highbounty)
	color = "#ff0000"

/obj/effect/spawner/lootdrop/f13/bounty/high_to_king
	name = "low to medium bounty ticket spawner, 50% chance for nothing"
	loot = list(/obj/item/card/highbounty, /obj/item/card/kingbounty)
	color = "#ffe600"

/obj/effect/spawner/lootdrop/f13/bounty/king
	name = "king to none bounty ticket spawner, 50% chance for nothing"
	loot = list(/obj/item/card/kingbounty)
	color = "#ffe600"

/obj/effect/spawner/lootdrop/f13/bounty/any
	name = "equal chance to spawn any kind of bounty ticket, 50% chance for nothing"
	loot = list(/obj/item/card/lowbounty,
			/obj/item/card/midbounty,
			/obj/item/card/highbounty,
			/obj/item/card/kingbounty,
			)
	color = "#ffe600"

/obj/effect/spawner/lootdrop/f13/bounty/low_to_high
	name = "equal chance to spawn a low, med, or high bounty ticket, 50% chance for nothing"
	loot = list(/obj/item/card/lowbounty,
			/obj/item/card/midbounty,
			/obj/item/card/highbounty,
			)
	color = "#ff0000"

/obj/effect/spawner/lootdrop/f13/bounty/med_to_king
	name = "equal chance to spawn a med, high, or king bounty ticket, 50% chance for nothing"
	loot = list(/obj/item/card/midbounty,
			/obj/item/card/highbounty,
			/obj/item/card/kingbounty,
			)
	color = "#ffe600"
