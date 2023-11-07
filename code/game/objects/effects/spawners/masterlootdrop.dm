/////////////////////
///master spawners///
/////////////////////

/obj/effect/spawner/lootdrop/f13/trash
	name = "trash loot, found everywhere BUT the trash"
	delay_spawn = FALSE
	loot = list(
		/obj/effect/spawner/lootdrop/f13/trash_weps = 1,
		/obj/effect/spawner/lootdrop/f13/trash_mags = 1,
		/obj/effect/spawner/lootdrop/f13/trash_ammo = 1,
		/obj/effect/spawner/lootdrop/f13/trash_medicine = 1,
		/obj/effect/spawner/lootdrop/f13/trash_drugs = 1,
		/obj/effect/spawner/lootdrop/f13/trash_armor = 1,
		/obj/effect/spawner/lootdrop/f13/trash_toys = 1,
		/obj/effect/spawner/lootdrop/f13/trash_mats = 1,
		/obj/effect/spawner/lootdrop/f13/trash_mods = 1,
		/obj/effect/spawner/lootdrop/f13/trash_parts = 1,
		/obj/effect/spawner/lootdrop/f13/trash_tools = 1,
		/obj/effect/spawner/lootdrop/f13/trash_money = 1,
		/obj/effect/spawner/lootdrop/f13/trash_bombs = 1,
		/obj/effect/spawner/lootdrop/f13/trash_food = 1,
		/obj/effect/spawner/lootdrop/f13/trash_trash = 15,
		/obj/effect/spawner/lootdrop/f13/mice = 1, //the mice are extra~
	)

/obj/effect/spawner/lootdrop/f13/trash/pile
	name = "trash loot, found ONLY IN the trash"
	delay_spawn = TRUE

/obj/effect/spawner/lootdrop/f13/common
	name = "common loot, found everywhere"
	icon_state = "x5"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/common_weps = 1,
		/obj/effect/spawner/lootdrop/f13/common_mags = 2,
		/obj/effect/spawner/lootdrop/f13/common_ammo = 2,
		/obj/effect/spawner/lootdrop/f13/common_medicine = 2,
		/obj/effect/spawner/lootdrop/f13/common_drugs = 2,
		/obj/effect/spawner/lootdrop/f13/common_armor = 2,
		/obj/effect/spawner/lootdrop/f13/common_toys = 2,
		/obj/effect/spawner/lootdrop/f13/common_mats = 2,
		/obj/effect/spawner/lootdrop/f13/common_mods = 2,
		/obj/effect/spawner/lootdrop/f13/common_parts = 2,
		/obj/effect/spawner/lootdrop/f13/common_tools = 2,
		/obj/effect/spawner/lootdrop/f13/common_money = 2,
		/obj/effect/spawner/lootdrop/f13/common_bombs = 2,
		/obj/effect/spawner/lootdrop/f13/common_food = 2,
	)
	downtier_chance = 50 // 50% chance to downtier to trash
	downtier_list = list(
		/obj/effect/spawner/lootdrop/f13/trash = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon
	name = "uncommon loot, found in dungeons"
	icon_state = "x6"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_weps = 1,
		/obj/effect/spawner/lootdrop/f13/uncommon_mags = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_medicine = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_drugs = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_armor = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_toys = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_mats = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_mods = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_parts = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_tools = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_money = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_bombs = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_food = 2,
		/obj/effect/spawner/lootdrop/f13/uncommon_artifacts = 0.5,
	)
	uptier_chance = 1 // 1% chance to uptier to a restricted rare
	uptier_list = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_upgrade = 1,
	)
	downtier_chance = 33 // 33% chance to downtier to common
	downtier_list = list(
		/obj/effect/spawner/lootdrop/f13/common = 1,
	)
	snap_category = "UNCOMMON"

/obj/effect/spawner/lootdrop/f13/uncommon_upgrade
	name = "uncommon loot that rolled an upgrade to a limited rare tier, found in dungeons. Do not place in the map!!!"
	icon_state = "x6"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_primary = 1, // 0.25% chance to roll a rare primary, on top of the 1% chance to uptier. This means 0.25% of 1% = 0.0025% chance to roll a rare primary. goot look!
		/obj/effect/spawner/lootdrop/f13/rare_secondary = 100, // 25% chance to roll a rare secondary
		/obj/effect/spawner/lootdrop/f13/rare_tertiary = 300, // 75% chance to roll a rare tertiary
	)

/obj/effect/spawner/lootdrop/f13/rare
	name = "rare loot, found in dangerous dungeons"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_primary = 4,
		/obj/effect/spawner/lootdrop/f13/rare_secondary = 5,
		/obj/effect/spawner/lootdrop/f13/rare_tertiary = 5,
	)
	downtier_chance = 15 // 15% chance to downtier to uncommon (and no lower)
	downtier_list = list(
		/obj/effect/spawner/lootdrop/f13/uncommon = 1,
	)
	snap_category = "RARE"


/obj/effect/spawner/lootdrop/f13/rare_primary
	name = "rare high-value loot, found in dangerous dungeons"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_weps = 3,
		/obj/effect/spawner/lootdrop/f13/rare_armor = 1,
		/obj/effect/spawner/lootdrop/f13/rare_mods = 3,
	)

/// Generally decent stuff, but not as good as the rare primary loot. Shouldnt affect tiering if given in uncommon loot rarely.
/obj/effect/spawner/lootdrop/f13/rare_secondary
	name = "rare but less valuable loot, found in dangerous dungeons or as a rare upgrade to uncommon loot"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_mags = 1,
		/obj/effect/spawner/lootdrop/f13/rare_ammo = 1,
		/obj/effect/spawner/lootdrop/f13/rare_medicine = 2,
		/obj/effect/spawner/lootdrop/f13/rare_drugs = 2,
		/obj/effect/spawner/lootdrop/f13/rare_mats = 2,
		/obj/effect/spawner/lootdrop/f13/rare_parts = 2,
		/obj/effect/spawner/lootdrop/f13/rare_tools = 2,
		/obj/effect/spawner/lootdrop/f13/rare_money = 2,
		/obj/effect/spawner/lootdrop/f13/rare_bombs = 2,
		/obj/effect/spawner/lootdrop/f13/rare_artifacts = 0.5
	)

/// Generally decent stuff, but are mostly consumables or stuff mainly just valuable for selling. Shouldnt affect tiering if given in uncommon loot rarely.
/obj/effect/spawner/lootdrop/f13/rare_tertiary
	name = "rare but generally trash loot, found in dangerous dungeons or as a rare additional drop to uncommon+ loot"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_medicine = 1,
		/obj/effect/spawner/lootdrop/f13/rare_drugs = 2,
		/obj/effect/spawner/lootdrop/f13/rare_toys = 3,
		/obj/effect/spawner/lootdrop/f13/rare_parts = 3,
		/obj/effect/spawner/lootdrop/f13/rare_money = 2,
		/obj/effect/spawner/lootdrop/f13/rare_food = 1,
	)

////////////////////////////
///master weapon spawners///	these ensure fair distribution of different weapon types
////////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_weps
	name = "trash weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/trash_guns = 1,
		/obj/effect/spawner/lootdrop/f13/trash_melee = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_weps
	name = "common weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/common_guns = 15, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/common_melee = 10,
		/obj/effect/spawner/lootdrop/f13/common_cowboy = 10,
		/obj/effect/spawner/lootdrop/f13/common_energy = 6,
		/obj/effect/spawner/lootdrop/f13/common_unique = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_weps
	name = "uncommon weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_guns = 12, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/uncommon_melee = 12,
		/obj/effect/spawner/lootdrop/f13/uncommon_cowboy = 4,
		/obj/effect/spawner/lootdrop/f13/uncommon_energy = 4,
		/obj/effect/spawner/lootdrop/f13/uncommon_unique = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_weps
	name = "rare weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_melee = 15, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/rare_cowboy = 15,
		/obj/effect/spawner/lootdrop/f13/rare_guns = 8,
		/obj/effect/spawner/lootdrop/f13/rare_energy = 2,
		/obj/effect/spawner/lootdrop/f13/rare_unique = 1,
	)

///////////////////////////////
///ballistic weapon spawners///
///////////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_guns
	name = "trash guns"
	loot = list(
		/obj/item/gun/ballistic/automatic/hobo/zipgun = 10,
		/obj/item/gun/ballistic/revolver/hobo/piperifle = 10,
		/obj/item/gun/ballistic/revolver/hobo/pepperbox = 10,
		/obj/item/gun/ballistic/rifle/mosin/mini = 10,
		/obj/item/gun/ballistic/revolver/hobo/knifegun = 5,
		/obj/item/gun/ballistic/revolver/shotpistol = 5,
		/obj/item/gun/ballistic/revolver/hobo/single_shotgun = 3,
		/obj/item/gun/ballistic/revolver/hobo/knucklegun = 3,
		/obj/item/gun/ballistic/automatic/autopipe = 3,
		/obj/item/gun/ballistic/revolver/winchesterrebored = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_guns
	name = "common guns"
	loot = list(
		/obj/item/gun/ballistic/automatic/varmint = 10,
		/obj/item/gun/ballistic/automatic/pistol/sig = 10,
		/obj/item/gun/ballistic/automatic/pistol/deagle= 10,
		/obj/item/gun/ballistic/automatic/pistol/beretta/carbine = 4,
		/obj/item/gun/ballistic/automatic/sportcarbine = 4,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22 = 4,
		/obj/item/gun/ballistic/automatic/pistol/n99 = 4,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10 = 4,
		/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun = 4,
		/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle = 4,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/auto = 4,
		/obj/item/gun/ballistic/automatic/pistol/vg77 = 4,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell = 3, // Pretty much the same gun but I felt like its fair keeping them here
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun = 3, // <- ^
		/obj/item/gun/ballistic/automatic/pistol/beretta/automatic = 2,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion = 2,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22 = 2,
		/obj/item/gun/ballistic/automatic/pistol/pistol22 = 1,
		/obj/item/gun/ballistic/automatic/smg/smg10mm/worn = 1,
		/obj/item/gun/ballistic/automatic/assault_carbine/policerifle = 1,
		/obj/item/gun/ballistic/automatic/marksman/policerifle = 1,
		/obj/item/gun/ballistic/automatic/pistol/automag = 1,
		/obj/item/gun/ballistic/automatic/pistol/beretta = 1,
		/obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol = 4,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_guns
	name = "uncommon guns"
	loot = list(
		/obj/item/gun/ballistic/automatic/matildar = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi = 10,
		/obj/item/gun/ballistic/automatic/smg/american180 = 10,
		/obj/item/gun/ballistic/automatic/ak556 = 10,
		/obj/item/gun/ballistic/automatic/service = 10,
		/obj/item/gun/ballistic/automatic/pistol/schmeisser = 10,
		/obj/item/gun/ballistic/automatic/service/r82 = 10, //is weakest 5.56 automatic
		/obj/item/gun/ballistic/automatic/assault_carbine/psg5mm = 10,
		/obj/item/gun/ballistic/automatic/smg/sidewinder = 4,
		/obj/item/gun/ballistic/automatic/smg/smg10mm = 4,
		/obj/item/gun/ballistic/automatic/combat = 4,
		/obj/item/gun/ballistic/automatic/assault_carbine = 4,
		/obj/item/gun/ballistic/automatic/armalite = 4,
		/obj/item/gun/ballistic/automatic/smg/m22 = 4,
		/obj/item/gun/ballistic/automatic/l1a1 = 4,
		/obj/item/gun/ballistic/shotgun/automatic/combat/auto5 = 4,
		/obj/item/gun/ballistic/automatic/p47 = 4,
		/obj/item/gun/ballistic/automatic/needlerrifle = 4,
		/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle = 4,
		/obj/item/gun/ballistic/automatic/marksman = 4,
		/obj/item/gun/ballistic/automatic/pistol/needlerpistol = 1,
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/gun/ballistic/automatic/rangemaster = 1,
		/obj/item/gun/ballistic/automatic/hobo/destroyer = 1,
		/obj/item/gun/ballistic/automatic/slr = 1,
		/obj/item/gun/ballistic/automatic/assault_carbine/psg5mm = 10,
		/obj/item/gun/ballistic/automatic/m1garand/sks = 1,
		// /obj/item/gun/ballistic/rifle/hunting/obrez = 1, // Commenting out until the sprite is fixed.
		// /obj/item/gun/ballistic/automatic/wt550/worn = 1, // Commenting out until the sprite is fixed.
	)

/obj/effect/spawner/lootdrop/f13/rare_guns
	name = "rare guns"
	loot = list(
		/obj/item/gun/ballistic/automatic/fnfal/ak47 = 10,
		/obj/item/gun/ballistic/automatic/smg/cg45 = 10,
		/obj/item/gun/ballistic/automatic/smg/p90 = 10,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5 = 10, // bonus damage means rarer
		/obj/item/gun/ballistic/automatic/type93 = 10,
		/obj/item/gun/ballistic/automatic/lsw = 10,
		/obj/item/gun/ballistic/automatic/unmcamr = 10,
		/obj/item/gun/ballistic/automatic/assault_carbine/m5a1 = 10,
		/obj/item/gun/ballistic/automatic/assault_carbine/scarrifle = 10,
		/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm = 4,
		/obj/item/gun/ballistic/automatic/smg/mp5 = 4, // MP5SD, what the fuck are these item paths?
		/obj/item/gun/ballistic/automatic/marksman/sniper = 4,
		/obj/item/gun/ballistic/automatic/assault_rifle = 4,
		/obj/item/gun/ballistic/automatic/r93 = 4,
		/obj/item/gun/ballistic/automatic/concussive = 4,
		/obj/item/gun/ballistic/automatic/pistol/pistol14 = 4,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/compact = 1,
		/obj/item/gun/ballistic/rifle/mag/antimateriel = 1,
		/obj/item/gun/ballistic/shotgun/police = 1,
		/obj/item/gun/ballistic/shotgun/automatic/combat/neostead = 1,
		/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller = 1,
		/obj/item/gun/ballistic/automatic/shotgun/riot = 1,
		/obj/item/gun/ballistic/automatic/fnfal = 1,
		/obj/item/gun/ballistic/automatic/rpd = 1,
		/obj/item/gun/ballistic/automatic/aksmol = 1,
		// /obj/item/gun/ballistic/automatic/wt550 = 2, // Commenting out until the sprite is fixed.

	)

////////////////////
///cowboy weapons///		ensures we gett plenty of stylish guns and bows
////////////////////

/obj/effect/spawner/lootdrop/f13/common_cowboy
	name = "common classic guns" // basically WW2 and earlier
	loot = list(
		/obj/item/gun/ballistic/revolver/detective = 10,
		/obj/item/gun/ballistic/rifle/repeater/cowboy = 10,
		/obj/item/gun/ballistic/revolver/police = 10,
		/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
		/obj/item/gun/ballistic/revolver/revolver44 = 10,
		/obj/item/gun/ballistic/rifle/hunting = 10,
		/obj/item/gun/ballistic/rifle/antique/gras = 10,
		/obj/item/gun/ballistic/rifle/repeater/volcanic = 10,
		/obj/item/gun/ballistic/bow/recurvebow = 4,
		/obj/item/gun/ballistic/bow/lightxbow = 4,
		/obj/item/gun/ballistic/revolver/widowmaker = 4,
		/obj/item/gun/ballistic/revolver/revolver45 = 4,
		/obj/item/gun/ballistic/revolver/colt357 = 4,
		/obj/item/gun/ballistic/revolver/m29/snub = 4,
		/obj/item/gun/ballistic/revolver/buntline = 4,
		/obj/item/gun/ballistic/revolver/Lemat = 4,
		/obj/item/gun/ballistic/rifle/mosin = 4,
		/obj/item/gun/ballistic/shotgun/hunting = 4,
		/obj/item/gun/ballistic/revolver/m29 = 1,
		/obj/item/gun/ballistic/revolver/m29/alt = 1,
		/obj/item/gun/ballistic/rifle/enfield = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93 = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby = 4,
		/obj/item/gun/ballistic/automatic/pistol/type17 = 10,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_cowboy
	name = "uncommon classic guns" // basically WW2 and earlier
	loot = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 10,
		/obj/item/gun/ballistic/revolver/thatgun = 10,
		/obj/item/gun/ballistic/revolver/police/webley = 10,
		/obj/item/gun/ballistic/revolver/hunting = 10,
		/obj/item/gun/ballistic/rifle/repeater/trail = 10,
		/obj/item/gun/ballistic/rifle/repeater/ranger = 10,
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 10,
		/obj/item/gun/ballistic/shotgun/trench = 10,
		/obj/item/gun/ballistic/revolver/colt357/auto = 4,
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40 = 4,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock = 4,
		/obj/item/gun/ballistic/automatic/gewehr43 = 4,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 1,
		/obj/item/gun/ballistic/bow/longbow = 4,
		/obj/item/gun/ballistic/bow/crossbow = 4,
		/obj/item/gun/ballistic/automatic/m1garand = 4,
		/obj/item/m2flamethrowertank = 1,
		/obj/item/gun/ballistic/automatic/m1carbine/m2 = 1,
		/obj/item/gun/ballistic/automatic/gewehr41civ = 4,
		/obj/item/gun/ballistic/automatic/gewehr43 = 4,
		/obj/item/gun/ballistic/automatic/m1garand/sks = 4,
		// /obj/item/gun/ballistic/bow/compositebow = 1, // I do not know the difference between this and the recurve.
	)

/obj/effect/spawner/lootdrop/f13/rare_cowboy
	name = "rare classic guns" // basically WW2 and earlier
	loot = list(
		/obj/item/gun/ballistic/revolver/m2405 = 10,
		/obj/item/gun/ballistic/automatic/c96auto = 10,
		/obj/item/gun/ballistic/revolver/sequoia = 10,
		/obj/item/gun/ballistic/rifle/repeater/brush = 10,
		/obj/item/gun/ballistic/automatic/smg/greasegun = 10,
		/obj/item/gun/energy/kinetic_accelerator/crossbow = 4, // ebow
		/obj/item/gun/ballistic/automatic/gewehr41civ = 4,
		/obj/item/gun/ballistic/bow/compoundbow = 4,
		/obj/item/gun/ballistic/rifle/mag/boys = 4,
		/obj/item/gun/ballistic/automatic/bar = 4,
		/obj/item/gun/ballistic/automatic/smg/tommygun = 4,
		/obj/item/gun/ballistic/rifle/mosin/laserbubba = 4, // for the meme
		/obj/item/gun/ballistic/automatic/lewis = 1,
		/obj/item/gun/ballistic/automatic/smg/ppsh = 1,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/large = 1, // big ebow
	)
///////////////////////////
///melee weapon spawners///
///////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_melee
	name = "trash melee"
	loot = list(
		/obj/item/melee/onehanded/club/tireiron = 10,
		/obj/item/melee/onehanded/club = 4,
		/obj/item/twohanded/spear/scrapspear = 4,
		/obj/item/twohanded/fireaxe/bmprsword = 4,
		/obj/item/melee/onehanded/knife/cosmicdirty = 1,
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/shishkebabpack = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_melee
	name = "common melee"
	loot = list(
		/obj/item/melee/onehanded/machete = 10,
		/obj/item/melee/onehanded/machete/forgedmachete = 10,
		/obj/item/throwing_star/spear = 10,
		/obj/item/melee/onehanded/knife/throwing = 10,
		/obj/item/twohanded/baseball/golfclub = 10,
		/obj/item/melee/onehanded/club/fryingpan = 10,
		/obj/item/melee/unarmed/yaoguaigauntlet = 10,
		/obj/item/melee/onehanded/machete/scrapsabre = 4,
		/obj/item/melee/onehanded/knife/bowie = 4,
		/obj/item/melee/onehanded/knife/switchblade = 4,
		/obj/item/melee/unarmed/brass = 4,
		/obj/item/twohanded/spear = 4,
		/obj/item/twohanded/fireaxe = 4,
		/obj/item/twohanded/baseball = 4,
		/obj/item/twohanded/chainsaw = 4,
		/obj/item/melee/transforming/plasmacutter/regular/celestia = 1,
		/obj/item/melee/transforming/plasmacutter/regular/eve = 1,
		/obj/item/melee/transforming/plasmacutter/regular = 1,
		/obj/item/shovel/trench = 1,
		/obj/item/twohanded/baseball/spiked = 1,
		/obj/item/melee/unarmed/sappers = 1,
		/obj/item/melee/unarmed/brass/spiked = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_melee //kinda slim rn
	name = "uncommon melee"
	loot = list(
		/obj/item/twohanded/sledgehammer/simple = 10,
		/obj/item/melee/transforming/plasmacutter/sword/cx/broken = 4,
		/obj/item/melee/onehanded/machete/spatha = 4,
		/obj/item/melee/unarmed/tigerclaw = 4,
		/obj/item/melee/unarmed/lacerator = 4,
		/obj/item/melee/unarmed/maceglove = 4,
		/obj/item/melee/unarmed/punchdagger = 4,
		/obj/item/twohanded/baseball/louisville = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_melee
	name = "rare melee"
	loot = list(
		/obj/item/gun/ballistic/revolver/ballisticfist = 10,
		/obj/item/melee/powered/ripper = 10,
		/obj/item/twohanded/legionaxe = 10,
		/obj/item/melee/transforming/energy/axe/protonaxe = 10,
		/obj/item/melee/unarmed/powerfist = 4,
		/obj/item/twohanded/sledgehammer/supersledge = 4,
		/obj/item/twohanded/sledgehammer/rockethammer = 4,
		/obj/item/twohanded/thermic_lance = 1,
		// /obj/item/melee/transforming/plasmacutter/sword = 5, // Commenting it out until its sprite is fixed.
	)

////////////////////////////
///energy weapon spawners///
////////////////////////////

/obj/effect/spawner/lootdrop/f13/common_energy
	name = "common energy"
	loot = list(
		/obj/item/gun/energy/laser/wattz = 10,
		/obj/item/gun/energy/laser/pistol = 10,
		/obj/item/gun/energy/laser/tg/carbine/pistol = 10,
		/obj/item/gun/energy/laser/complianceregulator = 10,
		/obj/item/gun/energy/laser/tg/carbine = 4,
		/obj/item/gun/energy/ionrifle/compact = 4,
		/obj/item/gun/energy/laser/wattzs = 4,
		/obj/item/gun/energy/laser/auto = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_energy
	name = "uncommon energy"
	loot = list(
		/obj/item/gun/energy/laser/wattz2k = 10,
		/obj/item/gun/energy/laser/aer9 = 10,
		/obj/item/gun/energy/laser/plasma/pistol = 10,
		/obj/item/gun/energy/ionrifle/carbine = 10,
		/obj/item/gun/energy/laser/tg/rifle = 4,
		/obj/item/gun/energy/laser/solar = 4,
		/obj/item/gun/magic/wand/kelpmagic/firebolt = 1,
		/obj/item/gun/magic/wand/kelpmagic/healwand = 1,
		/obj/item/gun/magic/wand/kelpmagic/magicmissile/improved = 1,
		/obj/item/gun/magic/wand/kelpmagic/sparky = 1,
		/obj/item/gun/magic/staff/kelpmagic/acidstaff = 1,
		/obj/item/gun/energy/laser/tg/recharger/nuclear = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_energy
	name = "rare energy"
	loot = list(
		/obj/item/gun/energy/laser/scatter = 10,
		/obj/item/gun/energy/laser/aer12 = 10,
		/obj/item/gun/energy/laser/rcw = 10,
		/obj/item/gun/energy/laser/plasma/glock = 10,
		/obj/item/gun/energy/laser/plasma = 10,
		/obj/item/gun/energy/laser/wattz2k/extended = 10,
		/obj/item/gun/energy/ionrifle = 4,
		/obj/item/gun/energy/laser/laer = 4,
		/obj/item/gun/energy/laser/plasma/carbine = 4,
		/obj/item/gun/energy/laser/tg/rifle/heavy = 4,
		/obj/item/gun/energy/laser/tg/rifle/auto = 4,
		/obj/item/gun/energy/laser/plasma/pistol/eve = 1,
		/obj/item/gun/energy/laser/plasma/pistol/adam = 1,
		/obj/item/gun/energy/laser/tg/recharger/nuclear/rifle = 1,
		/obj/item/gun/energy/laser/LaserAK/worn = 1,
		/obj/item/gun/energy/laser/ultra_rifle = 1,
		/obj/item/gun/magic/staff/kelpmagic/fireball = 1,
		/obj/item/gun/magic/staff/kelpmagic/lightning = 1,
		/obj/item/gun/magic/staff/kelpmagic/healstaff = 1,
	)


////////////////////
///cowboy weapons///		ensures we gett plenty of stylish guns and bows
////////////////////
/*
/obj/effect/spawner/lootdrop/f13/common_cowboy
	name = "common cowboy"
	loot = list(
		/obj/item/gun/ballistic/revolver/detective = 5,
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/gun/ballistic/revolver/colt357 = 20,
		/obj/item/gun/ballistic/revolver/police = 5,
		/obj/item/gun/ballistic/revolver/m29 = 5,
		/obj/item/gun/ballistic/revolver/m29/alt = 1,
		/obj/item/gun/ballistic/revolver/m29/snub = 5,
		/obj/item/gun/ballistic/revolver/revolver44 = 1,
		/obj/item/gun/ballistic/revolver/thatgun = 10,
		/obj/item/gun/ballistic/rifle/repeater/cowboy = 20,
		/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
		/obj/item/gun/ballistic/revolver/widowmaker = 10,
		/obj/item/gun/ballistic/bow/lightxbow = 10,
		/obj/item/gun/ballistic/bow/recurvebow = 20,
		/obj/item/gun/ballistic/revolver/detective/derringer = 1,
		/obj/item/gun/ballistic/revolver/derringer4570 = 1,
		/obj/item/gun/ballistic/revolver/derringerLC = 5,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_cowboy
	name = "uncommon cowboy"
	loot = list(
		/obj/item/gun/ballistic/revolver/police/webley = 5,
		/obj/item/gun/ballistic/revolver/hunting = 10,
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 5,
		/obj/item/gun/ballistic/revolver/colt357/auto = 5,
		/obj/item/gun/ballistic/rifle/repeater/trail = 20,
		/obj/item/gun/ballistic/rifle/repeater/ranger = 10,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock = 10,
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 5,
		/obj/item/gun/ballistic/bow/longbow = 20,
		/obj/item/gun/ballistic/bow/crossbow = 10,
		/obj/item/gun/ballistic/bow/compositebow = 10,
	)

/obj/effect/spawner/lootdrop/f13/rare_cowboy
	name = "rare cowboy"
	loot = list(
		/obj/item/gun/ballistic/revolver/m2405 = 5,
		/obj/item/gun/ballistic/revolver/sequoia = 10,
		/obj/item/gun/ballistic/rifle/repeater/brush = 20,
		/obj/item/gun/energy/kinetic_accelerator/crossbow = 5, // ebow
		/obj/item/gun/energy/kinetic_accelerator/crossbow/large = 1, // big ebow
		/obj/item/gun/ballistic/bow/compoundbow = 3,
		/obj/item/m2flamethrowertank = 1,
	)

*/
//////////////////////////
///unique weapon spawns///
//////////////////////////

/obj/effect/spawner/lootdrop/f13/common_unique
	name = "common unique"
	loot = list(
		/obj/item/gun/ballistic/automatic/sportcarbine/m1_22 = 10,
		/obj/item/gun/ballistic/automatic/varmint/ratslayer = 10,
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 10,
		/obj/item/gun/energy/laser/scatter/nonlethal = 10,
		/obj/item/gun/energy/laser/LaserAK = 4,
		/obj/item/gun/ballistic/revolver/colt357/lucky = 4,
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 4,
		/obj/item/gun/ballistic/automatic/delisle/commando = 4,
		/obj/item/gun/ballistic/automatic/m1carbine/compact = 4,
		/obj/item/melee/onehanded/knife/trench = 4,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/maria = 1,
		/obj/item/sord = 1,
		/obj/item/melee/onehanded/machete/gladius = 1,
		/obj/item/gun/energy/laser/retro = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/rubee = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/mousegun = 1,
		/obj/item/gun/ballistic/automatic/autopipe/special = 1,
		/obj/item/gun/ballistic/revolver/hobo/pepperbox/deal = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_unique
	name = "uncommon unique"
	loot = list(
		/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator = 10,
		/obj/item/gun/ballistic/automatic/pistol/n99/executive = 10,
		/obj/item/gun/ballistic/rifle/hunting/paciencia = 10,
		/obj/item/gun/ballistic/automatic/service/alr = 10,
		/obj/item/gun/ballistic/automatic/m1garand/oldglory = 10,
		/obj/item/gun/ballistic/automatic/m41br = 10,
		/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan = 10,
		/obj/item/gun/ballistic/automatic/service/carbine = 10,
		/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil = 10,
		/obj/item/gun/ballistic/automatic/marksman/sniper/gold = 4,
		/obj/item/gun/ballistic/automatic/pistol/goldendeag = 4,
		/obj/item/gun/ballistic/automatic/g11 = 4,
		/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum = 4,
		/obj/item/melee/transforming/plasmacutter/sword/cx = 4,
		/obj/item/gun/energy/laser/tg/recharger = 4,
		/obj/item/gun/energy/laser/wattz2ks = 4,
		/obj/item/gun/ballistic/automatic/smg/vss = 4,
		// /obj/item/gun/ballistic/automatic/recoilessrifle = 1, //Will ask community on ideas of a revamped recoiless rifle. Needs a complete overhaul of its niche abilities.
		/obj/item/gun/ballistic/automatic/smg/american180/b180 = 1,
		/obj/item/gun/energy/laser/wattz/recharger = 1,
		/obj/item/sord = 1,
		// /obj/item/gun/ballistic/automatic/m1garand/republicspride = 10, // Commenting out until its sprite is fixed.
	)

/obj/effect/spawner/lootdrop/f13/rare_unique //most uniques gonna end up here: the epitome of high tier loot
	name = "rare unique"
	loot = list(
		/obj/item/gun/ballistic/automatic/bozar = 10,
		/obj/item/gun/ballistic/automatic/r84 = 10,
		/obj/item/gun/ballistic/automatic/lewis/lanoe = 10,
		/obj/item/gun/ballistic/automatic/m1919 = 10,
		/obj/item/melee/powered/ripper/prewar = 10,
		/obj/item/twohanded/spear/bonespear/deathclaw = 10, //sure why not
		/obj/item/gun/energy/laser/badlands = 10,
		/obj/item/melee/unarmed/deathclawgauntlet = 10,
		/obj/item/gun/energy/laser/scatter/laserbuss = 10,
		/obj/item/book/granter/martial/bass = 10,
		/obj/item/gun/ballistic/automatic/fastlmg = 4,
		/obj/item/melee/transforming/plasmacutter/regular/adam = 4,
		/obj/item/gun/ballistic/revolver/shotpistol/flair_gun = 4,
		/obj/item/twohanded/sledgehammer/atomsjudgement = 4,
		/obj/item/gun/ballistic/automatic/smg/smg14 = 4,
		/obj/item/dualsaber/hypereutactic = 4,
		/obj/item/gun/energy/laser/aer14 = 4,
		/obj/item/melee/powerfist/f13/satfist = 4,
		/obj/item/gun/ballistic/automatic/m72 = 4,
		/obj/item/gun/ballistic/automatic/xl70e3 = 4,
		/obj/item/melee/unarmed/powerfist/goliath = 1,
		/obj/item/minigunpackbal5mm = 1,
		/obj/item/minigunpack = 1,
		/obj/item/gun/energy/laser/plasma/pistol/alien = 1,
		/obj/item/gun/energy/laser/plasma/bouncy = 1, // basically the alien gun, but reloadable. Might make it literally an Alien cell gun later
		/obj/item/gun/energy/laser/plasma/scatter = 1,
		/obj/item/gun/energy/laser/tg/particlecannon = 1, // old tesla cannon was kind of... bad. In several ways.
		/obj/item/melee/onehanded/dragonfire = 1, //edgy
		/obj/item/sord = 1, //for the meme
		/obj/item/gun/ballistic/automatic/compact14mmrifle = 4,
		/obj/item/gun/ballistic/fatman = 0.5,
	)

////////////////////////////
///magazine ammo spawners///		each tier reflects the type of guns available in this tier
////////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_mags
	name = "trash magazines"
	loot = list(
		/obj/item/ammo_box/magazine/zipgun = 10,
		/obj/item/ammo_box/magazine/uzim9mm/rockwell = 4,
		/obj/item/ammo_box/magazine/autopipe = 4,
		/obj/item/ammo_box/magazine/m556/rifle/small = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_mags
	name = "common magazines"
	loot = list(
		/obj/item/ammo_box/magazine/m9mm = 10,
		/obj/item/ammo_box/magazine/m22 = 10,
		/obj/item/ammo_box/magazine/m45 = 10,
		/obj/item/stock_parts/cell/ammo/ec = 10,
		/obj/item/ammo_box/magazine/uzim9mm = 4,
		/obj/item/ammo_box/magazine/m22/extended = 4,
		/obj/item/ammo_box/magazine/m10mm/adv/simple = 4,
		/obj/item/ammo_box/magazine/m9mm/doublestack = 4,
		/obj/item/ammo_box/magazine/m556/rifle = 4,
		/obj/item/ammo_box/a3006 = 1,
		/obj/item/ammo_box/a308 = 1,
		/obj/item/ammo_box/c22 = 1,
		/obj/item/ammo_box/a22 = 1,
		/obj/item/ammo_box/a357 = 1,
		/obj/item/ammo_box/a357/ratshot = 1,
		/obj/item/ammo_box/tube/a357 = 1,
		/obj/item/ammo_box/m44 = 1,
		/obj/item/ammo_box/c45rev = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_mags
	name = "uncommon magazines"
	loot = list(
		/obj/item/ammo_box/magazine/tommygunm45/stick = 10,
		/obj/item/ammo_box/magazine/m556/rifle/assault = 10,
		/obj/item/ammo_box/magazine/m5mm = 10,
		/obj/item/ammo_box/magazine/m308 = 10,
		/obj/item/ammo_box/magazine/m45/socom = 10,
		/obj/item/ammo_box/magazine/m22smg = 10,
		/obj/item/ammo_box/magazine/m10mm/adv/ext = 4,
		/obj/item/stock_parts/cell/ammo/mfc = 4,
		/obj/item/ammo_box/a45lcrev = 4,
		/obj/item/ammo_box/c4570 = 4,
		/obj/item/ammo_box/c4570/ratshot = 1,
		/obj/item/ammo_box/tube/m44 = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_mags
	name = "rare magazines"
	loot = list(
		/obj/item/ammo_box/magazine/greasegun = 10,
		/obj/item/ammo_box/magazine/tommygunm45 = 10,
		/obj/item/ammo_box/magazine/garand3006 = 10,
		/obj/item/ammo_box/magazine/w3006 = 10,
		/obj/item/ammo_box/magazine/sks = 10,
		/obj/item/ammo_box/magazine/boys = 10,
		/obj/item/ammo_box/magazine/m14mm = 10,
		/obj/item/ammo_box/tube/c4570 = 10,
		/obj/item/ammo_box/rev308 = 4,
		/obj/item/stock_parts/cell/ammo/ecp = 4,
		/obj/item/ammo_box/magazine/d12g = 4,
		/obj/item/ammo_box/magazine/m44 = 4,
		/obj/item/ammo_box/magazine/pps9mm = 4,
		/obj/item/ammo_box/magazine/m10mm_p90 = 4,
		/obj/item/ammo_box/magazine/cg45 = 4,
		/obj/item/ammo_box/magazine/m308/ext = 1,
		/obj/item/ammo_box/magazine/m44/automag = 1,
		/obj/item/ammo_box/magazine/m556/rifle/extended = 1,
		/obj/item/ammo_box/magazine/lewis/l47 = 1,
		/obj/item/gun/ballistic/rifle/mag/antimateriel = 1,
	)

///////////////////////
///ammo box spawners///		trash ammo has all ammo types evenly. the rest reflect the kinds of magazine for that tier
///////////////////////

/obj/effect/spawner/lootdrop/f13/trash_ammo //all equal chance cause the boxes hold different amounts
	name = "trash ammo boxes"
	loot = list(
		/obj/item/ammo_box/a308box/improvised = 1,
		/obj/item/ammo_box/a3006box/improvised = 1,
		/obj/item/ammo_box/m5mmbox/improvised = 1,
		/obj/item/ammo_box/a556/improvised = 1,
		/obj/item/ammo_box/c10mm/improvised = 1,
		/obj/item/ammo_box/c9mm/improvised = 1,
		/obj/item/ammo_box/shotgun/improvised = 1,
		/obj/item/ammo_box/a357box/improvised = 1,
		/obj/item/ammo_box/m44box/improvised = 1,
		/obj/item/ammo_box/c45/improvised = 1,
		/obj/item/ammo_box/m14mm/improvised = 1,
		/obj/item/ammo_box/c4570box/improvised = 1,
		/obj/item/ammo_box/m22 = 1,
		/obj/item/ammo_box/rock/improvised = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_ammo
	name = "common ammo boxes"
	loot = list(
		/obj/item/ammo_box/c9mm = 1,
		/obj/item/ammo_box/m22 = 1,
		/obj/item/ammo_box/c10mm = 1,
		/obj/item/ammo_box/a556 = 1,
		/obj/item/ammo_box/c45 = 1,
		/obj/item/ammo_box/a308box = 1,
		/obj/item/ammo_box/a3006box = 1,
		/obj/item/ammo_box/a357box = 1,
		/obj/item/ammo_box/a357box/ratshot = 1,
		/obj/item/ammo_box/m44box = 1,
		/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/ammo_box/shotgun/slug = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_ammo
	name = "uncommon ammo boxes"
	loot = list(
		/obj/item/ammo_box/m22 = 1,
		/obj/item/ammo_box/c10mm = 1,
		/obj/item/ammo_box/a556 = 1,
		/obj/item/ammo_box/c45 = 1,
		/obj/item/ammo_box/m5mmbox = 1,
		/obj/item/ammo_box/a308box = 1,
		/obj/item/ammo_box/c4570box = 1,
		/obj/item/ammo_box/c4570box/ratshot = 1,
		/obj/item/ammo_box/m44box = 1,
		/obj/item/ammo_box/a45lcbox = 1,
		/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/ammo_box/shotgun/slug = 1,
		/obj/item/ammo_box/a40mm/buck = 1,
		/obj/effect/spawner/lootdrop/f13/rare_ammo = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_ammo
	name = "rare ammo boxes"
	loot = list(
		/obj/item/ammo_box/a556 = 1,
		/obj/item/ammo_box/c45 = 1,
		/obj/item/ammo_box/a308box = 1,
		/obj/item/ammo_box/a3006box = 1,
		/obj/item/ammo_box/m44box = 1,
		/obj/item/ammo_box/m14mm = 1,
		/obj/item/ammo_box/c4570box = 1,
		/obj/item/ammo_box/c4570box/ratshot = 1,
		/obj/item/ammo_box/a50MGbox = 1,
	)

///////////////////////
///medicine spawners///
///////////////////////

/obj/effect/spawner/lootdrop/f13/trash_medicine
	name = "trash medicines"
	loot = list(
		/obj/item/reagent_containers/pill/healingpowder = 10,
		/obj/item/stack/medical/gauze/improvised = 10,
		/obj/item/stack/medical/ointment/five = 4,
		/obj/item/stack/medical/suture/emergency/five = 4,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/glucose = 4,
		/obj/item/reagent_containers/pill/bitterdrink = 1,
		/obj/item/reagent_containers/pill/fiery_purgative = 1,
		/obj/item/reagent_containers/pill/antivenom = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_medicine
	name = "common medicines"
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 10,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 10,
		/obj/item/stack/medical/gauze = 10,
		/obj/item/stack/medical/suture/five = 4,
		/obj/item/stack/medical/mesh/five = 4,
		/obj/item/reagent_containers/pill/charcoal = 4,
		/obj/item/reagent_containers/blood/radaway = 1,
		/obj/item/reagent_containers/blood/random = 1,
		/obj/item/reagent_containers/pill/patch/styptic = 1,
		/obj/item/reagent_containers/pill/patch/silver_sulf = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_medicine
	name = "uncommon medicines"
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 10,
		/obj/item/stack/medical/gauze = 10,
		/obj/item/stack/medical/suture/five = 10,
		/obj/item/reagent_containers/blood/radaway = 10,
		/obj/item/stack/medical/mesh/five = 10,
		/obj/item/reagent_containers/pill/patch/healpoultice = 1,
		/obj/item/reagent_containers/medspray/styptic  = 1,
		/obj/item/reagent_containers/medspray/silver_sulf = 1,
		/obj/item/reagent_containers/medspray/synthflesh = 1,
		/obj/item/reagent_containers/medspray/sterilizine = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/epipak = 1,
		/obj/item/storage/firstaid/ancient = 1, //lucky you
		/obj/item/reagent_containers/hypospray/combat/omnizine = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_medicine
	name = "rare medicines"
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 10,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 10,
		/obj/item/stack/medical/gauze/adv = 10,
		/obj/item/stack/medical/suture/medicated/five = 4,
		/obj/item/stack/medical/mesh/advanced/five = 4,
		/obj/item/reagent_containers/medspray/styptic = 1,
		/obj/item/reagent_containers/medspray/silver_sulf = 1,
		/obj/item/reagent_containers/blood/universal = 1,
		/obj/item/reagent_containers/blood/radaway = 1,
		/obj/item/reagent_containers/hypospray/combat = 1,
		/obj/item/storage/firstaid/ancient = 1,
	)

///////////////////
///drug spawners///
///////////////////

/obj/effect/spawner/lootdrop/f13/trash_drugs
	name = "trash drugs"
	loot = list(
		/obj/item/reagent_containers/pill/random = 10,
		/obj/item/reagent_containers/syringe/random = 10,
		/obj/item/reagent_containers/pill/patch/random = 10,
		/obj/item/reagent_containers/pill/healingpowder/random = 10,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/random = 4,
		/obj/item/reagent_containers/glass/bottle/random = 4,
		/obj/item/storage/pill_bottle/random = 4,
	)

/obj/effect/spawner/lootdrop/f13/common_drugs
	name = "common drugs"
	loot = list(
		/obj/item/storage/pill_bottle/chem_tin/radx = 1,
		/obj/item/reagent_containers/pill/patch/jet = 1,
		/obj/item/reagent_containers/hypospray/medipen/medx = 1,
		/obj/item/reagent_containers/hypospray/medipen/steady = 1,
		/obj/item/reagent_containers/hypospray/medipen/psycho = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_drugs
	name = "uncommon drugs"
	loot = list(
		/obj/item/storage/pill_bottle/chem_tin/radx = 10,
		/obj/item/reagent_containers/pill/patch/jet = 10,
		/obj/item/reagent_containers/hypospray/medipen/medx = 4,
		/obj/item/reagent_containers/hypospray/medipen/steady = 4,
		/obj/item/reagent_containers/hypospray/medipen/psycho = 4,
		/obj/item/storage/pill_bottle/chem_tin/mentats = 4,
		/obj/item/reagent_containers/pill/patch/turbo = 4,
		/obj/item/storage/pill_bottle/chem_tin/buffout = 4,
		/obj/item/reagent_containers/pill/fixer = 4,
		/obj/item/storage/pill_bottle/chem_tin/mentats/grape = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats/orange = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats/berry = 1,
		// /obj/item/reagent_containers/glass/bottle/FEV_solution = 4, // Commenting out due to its... Lack of general decency? Its bad.
	)

/obj/effect/spawner/lootdrop/f13/rare_drugs
	name = "rare drugs"
	loot = list(
		/obj/item/storage/pill_bottle/chem_tin/radx = 10,
		/obj/item/reagent_containers/pill/patch/jet = 10,
		/obj/item/reagent_containers/hypospray/medipen/medx = 4,
		/obj/item/reagent_containers/hypospray/medipen/steady = 4,
		/obj/item/reagent_containers/hypospray/medipen/psycho = 4,
		/obj/item/storage/pill_bottle/chem_tin/mentats = 4,
		/obj/item/reagent_containers/pill/patch/turbo = 4,
		/obj/item/storage/pill_bottle/chem_tin/buffout = 4,
		/obj/item/storage/pill_bottle/chem_tin/fixer = 4,
		/obj/item/storage/pill_bottle/chem_tin/mentats/grape = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats/orange = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats/berry = 1,
		// /obj/item/reagent_containers/glass/bottle/FEV_solution = 2,
		// /obj/item/reagent_containers/glass/bottle/FEV_solution/two = 1,
	)

////////////////////
///armor spawners///
////////////////////

/obj/effect/spawner/lootdrop/f13/trash_armor
	name = "trash armor"
	loot = list(
	/obj/item/clothing/suit/armor/light/kit/punk = 1,
	/obj/item/clothing/suit/armor/light/kit = 1,
	/obj/item/clothing/suit/armor/medium/vest/breastplate/light = 1,
	/obj/item/clothing/head/helmet/knight/f13/rider = 1,
	/obj/item/clothing/suit/armor/light/leather/leather_jacket = 1,
	/obj/item/clothing/suit/armor/light/kit/punk/leatherarmor = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_armor
	name = "common armor"
	loot = list(
		/obj/item/clothing/suit/armor/light/leather/leather_jacket = 5,,
		/obj/item/clothing/suit/armor/light/leather = 5,
		/obj/effect/spawner/bundle/f13/armor/supafly = 5,
		/obj/effect/spawner/bundle/f13/armor/sadist = 5,
		/obj/effect/spawner/bundle/f13/armor/blastmaster = 5,
		/obj/effect/spawner/bundle/f13/armor/yankee = 5,
		/obj/effect/spawner/bundle/f13/armor/badlands = 5,
		/obj/effect/spawner/bundle/f13/armor/psycho = 5,
		/obj/item/clothing/suit/armor/light/duster = 5,
		/obj/effect/spawner/bundle/f13/armor/combatduster = 5,
		/obj/item/clothing/suit/armor/medium/raider/iconoclast = 5,
		/obj/item/clothing/suit/armor/medium/raider/scrapcombat = 5,
		/obj/item/clothing/suit/armor/medium/vest/breastplate/light = 5,
		/obj/item/clothing/suit/armor/medium/vest = 5,
		/obj/item/clothing/suit/armor/light/kit/punk/bronzechestplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/leatherarmor = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/ironchestplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/scaledarmor = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/roughchainmail = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/fullchainmail = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/ironchestplatered = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/ironchestplateblue = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/oldscalemail = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/scalemail = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/varangianarmor = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/egyptianlam = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/chitinbreastplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/steppeleatherarmor = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/chineselam = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/chinesebreastplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/woodenbreastplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/steelbreastplate = 1,
		/obj/item/clothing/suit/armor/light/kit/punk/bronzebreastplate = 1,
		/obj/effect/spawner/bundle/f13/armor/knight = 1,
		/obj/effect/spawner/bundle/f13/armor/metal = 1,
		/obj/effect/spawner/bundle/f13/armor/laserproofmetal = 1,
		/obj/item/clothing/suit/armor/light/leather/leather_jacketmk2 = 1,
		/obj/item/clothing/suit/armor/light/leather/leathercoat = 1,
		/obj/item/clothing/suit/armor/medium/vest/alt = 1,
		/obj/item/clothing/suit/armor/medium/raider/slam = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_armor
	name = "uncommon armor"
	loot = list(
		/obj/effect/spawner/bundle/f13/armor/swat = 5,
		/obj/effect/spawner/bundle/f13/armor/combat = 5,
		/obj/effect/spawner/bundle/f13/armor/bulletproof = 3,
		/obj/effect/spawner/bundle/f13/armor/combat/dark = 3,
		/obj/effect/spawner/bundle/f13/armor/sulphite = 3,
		/obj/effect/spawner/bundle/f13/armor/metal/reinforced = 1,
		/obj/effect/spawner/bundle/f13/armor/vault = 1,
		/obj/item/clothing/suit/armor/medium/raider/slam = 1,
		/obj/item/clothing/suit/armor/medium/raider/rebel = 1,
		/obj/item/clothing/suit/armor/medium/raider/slam = 1,
		/obj/item/clothing/suit/armor/medium/raider/wastewar = 1,
		/obj/item/clothing/suit/armor/medium/combat/mk2/raider = 1,
		/obj/item/clothing/head/helmet/f13/raider/wastehound = 1,
		/obj/item/clothing/head/helmet/f13/raidermetal = 1,
		/obj/item/clothing/suit/armor/medium/raider/reptiliatenebris = 1,
		/obj/item/clothing/suit/armor/medium/odstcqb = 1,
		/obj/item/clothing/suit/space/hardsuit/lavaknight = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_armor
	name = "rare armor"
	loot = list(
		/obj/effect/spawner/bundle/f13/armor/riot = 40,
		/obj/effect/spawner/bundle/f13/armor/combat/mk2 = 40,
		/obj/effect/spawner/bundle/f13/armor/combat/mk2/dark = 40,
		/obj/item/clothing/suit/armor/heavy/riot/retrofitted = 20,
		/obj/effect/spawner/bundle/f13/armor/t45b_salvaged = 20,
		/obj/item/clothing/suit/armor/heavy/riot/vault = 20,
		/obj/item/clothing/suit/armor/heavy/riot/marine = 20,
		/obj/item/clothing/suit/armor/medium/odst = 2,
		/obj/effect/spawner/bundle/f13/armor/hotrodpa = 2,
		/obj/effect/spawner/bundle/f13/armor/t45d = 1,
		/obj/item/clothing/suit/armor/medium/odstlead = 1,
		/obj/effect/spawner/bundle/f13/armor/t51b = 1,
		/obj/item/clothing/suit/armor/power_armor/t51b/pony = 1,
	)

//////////////////
///toy spawners///
//////////////////

/obj/effect/spawner/lootdrop/f13/trash_toys
	name = "trash toys"
	loot = list(
		/obj/item/toy/gun = 5,
		/obj/item/toy/ammo/gun = 5,
		/obj/item/toy/balloon = 5,
		/obj/item/toy/cattoy = 5,
		/obj/item/toy/snappop = 5,
		/obj/item/gun/ballistic/automatic/toy/pistol = 5,
		/obj/item/toy/windupToolbox = 1,
		/obj/item/toy/prize/ripley = 1,
		/obj/item/toy/prize/fireripley = 1,
		/obj/item/toy/talking/owl = 1,
		/obj/item/toy/talking/griffin = 1,
		/obj/item/toy/beach_ball = 1,
		/obj/item/toy/toy_dagger = 1,
		/obj/item/toy/figure/assistant = 1,
		/obj/item/toy/figure/bartender = 1,
		/obj/item/toy/figure/botanist = 1,
		/obj/item/toy/figure/chaplain = 1,
		/obj/item/toy/figure/curator = 1,
		/obj/item/toy/figure/lawyer = 1,
		/obj/item/ammo_box/foambox = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_toys
	name = "common toys"
	loot = list(
		/obj/effect/spawner/lootdrop/plush/dangerous = 10,
		/obj/item/toy/dummy = 5,
		/obj/item/toy/sword = 5,
		/obj/item/gun/ballistic/shotgun/toy = 5,
		/obj/item/toy/cards/deck = 5,
		/obj/item/ammo_box/foambox = 1,
		/obj/item/toy/syndicateballoon = 1,
		/obj/item/toy/foamblade = 1,
		/obj/item/toy/prize/deathripley = 1,
		/obj/item/toy/prize/gygax = 1,
		/obj/item/toy/prize/durand = 1,
		/obj/item/toy/talking/AI = 1,
		/obj/item/toy/redbutton = 1,
		/obj/item/toy/toy_xeno = 1,
		/obj/item/toy/figure/atmos = 1,
		/obj/item/toy/figure/cargotech = 1,
		/obj/item/toy/figure/chef = 1,
		/obj/item/toy/figure/chemist = 1,
		/obj/item/toy/figure/engineer = 1,
		/obj/item/toy/figure/geneticist = 1,
		/obj/item/toy/figure/janitor = 1,
		/obj/item/toy/figure/lawyer = 1,
		/obj/item/toy/figure/roboticist = 1,
		/obj/item/toy/figure/scientist = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_toys
	name = "uncommon toys"
	loot = list(
		/obj/effect/spawner/lootdrop/plush/dangerous = 10,
		/obj/item/gun/ballistic/automatic/toy = 5,
		/obj/item/toy/sword/cx = 5,
		/obj/item/toy/katana = 5,
		/obj/item/toy/cards/deck/syndicate = 5,
		/obj/item/ammo_box/foambox/riot = 1,
		/obj/item/toy/prize/marauder = 1,
		/obj/item/toy/prize/seraph = 1,
		/obj/item/toy/prize/mauler = 1,
		/obj/item/toy/nuke = 1,
		/obj/item/toy/figure/cmo = 1,
		/obj/item/toy/figure/captain = 1,
		/obj/item/toy/figure/ce = 1,
		/obj/item/toy/figure/hop = 1,
		/obj/item/toy/figure/hos = 1,
		/obj/item/toy/figure/qm = 1,
		/obj/item/toy/figure/miner = 1,
		/obj/item/toy/figure/rd = 1,
		/obj/item/toy/figure/secofficer = 1,
		/obj/item/toy/figure/virologist = 1,
		/obj/item/toy/figure/warden = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_toys
	name = "rare toys"
	loot = list(
		/obj/effect/spawner/lootdrop/plush/dangerous = 10,
		/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot = 5,
		/obj/item/dualsaber/toy = 5,
		/obj/item/ammo_box/foambox/riot = 1,
		/obj/item/toy/spinningtoy = 1,
		/obj/item/toy/snappop/phoenix = 1,
		/obj/item/toy/prize/odysseus = 1,
		/obj/item/toy/prize/phazon = 1,
		/obj/item/toy/talking/codex_gigas = 1,
		/obj/item/toy/minimeteor = 1,
		/obj/item/toy/figure/borg = 1,
		/obj/item/toy/figure/ian = 1,
		/obj/item/toy/figure/dsquad = 1,
		/obj/item/toy/figure/ninja = 1,
		/obj/item/toy/figure/wizard = 1,
		/obj/item/toy/figure/syndie = 1,
	)

///////////////////////
///material spawners///
///////////////////////

/obj/effect/spawner/lootdrop/f13/trash_mats
	name = "trash materials"
	loot = list(
		/obj/item/stack/crafting/metalparts = 5,
		/obj/item/stack/crafting/goodparts = 5,
		/obj/item/stack/rods/ten = 5,
		/obj/item/stack/sheet/metal/five = 5,
		/obj/item/stack/sheet/mineral/wood/five = 5,
		/obj/item/stack/sheet/cloth/five = 5,
		/obj/item/stack/sheet/glass/five = 3,
		/obj/item/stack/crafting/electronicparts = 3,
		/obj/item/stack/sheet/bone = 3,
		/obj/item/stack/sheet/animalhide/human = 1,
		/obj/item/stack/sheet/wetleather = 1,
		/obj/item/stack/sheet/cardboard = 1,
		/obj/item/stack/sheet/sandblock/five = 1,
		/obj/item/stack/sheet/hay/five = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_mats
	name = "common materials"
	loot = list(
		/obj/item/stack/crafting/metalparts/five = 5,
		/obj/item/stack/crafting/goodparts/five = 5,
		/obj/item/stack/crafting/electronicparts/five = 5,
		/obj/item/stack/rods/ten = 5,
		/obj/item/stack/sheet/metal/twenty = 5,
		/obj/item/stack/sheet/mineral/wood/twenty = 5,
		/obj/item/stack/sheet/cloth/ten = 5,
		/obj/item/stack/sheet/glass/five = 5,
		/obj/item/stack/sheet/leather/ten = 3,
		/obj/item/crafting/duct_tape = 2,
		/obj/item/crafting/coffee_pot = 2,
		/obj/item/crafting/wonderglue = 2,
		/obj/item/crafting/abraxo = 2,
		/obj/item/crafting/turpentine = 1,
		/obj/item/crafting/lunchbox = 1,
		/obj/item/stack/sheet/mineral/coal/ten = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_mats
	name = "uncommon materials"
	loot = list(
		/obj/item/ingot/mythril = 20,
		/obj/item/advanced_crafting_components/receiver = 10,
		/obj/item/advanced_crafting_components/conductors = 10,
		/obj/item/stack/sheet/metal/twenty = 10,
		/obj/item/stack/crafting/metalparts/five = 5,
		/obj/item/stack/crafting/goodparts/five = 5,
		/obj/item/stack/crafting/electronicparts/five = 5,
		/obj/item/stack/sheet/cloth/ten = 5,
		/obj/item/stack/sheet/plasteel/five = 5,
		/obj/item/stack/sheet/mineral/bamboo/ten = 5,
		/obj/item/stack/sheet/plastic/twenty = 5,
		/obj/item/stack/sheet/prewar/twenty = 5,
		/obj/item/crafting/abraxo = 5,
		/obj/item/stack/sheet/mineral/titanium/twentyfive = 3,
		/obj/item/stack/sheet/mineral/silver/twentyfive = 1,
		/obj/item/stack/sheet/bronze/thirty = 1,
		/obj/item/stack/rods/scaffold/ten = 1,
		/obj/item/stack/sheet/lead/ten = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_mats
	name = "rare materials"
	loot = list(
		/obj/item/ingot/adamantine = 20,
		/obj/item/stack/sheet/mineral/plasma/twentyfive = 5,
		/obj/item/stack/sheet/mineral/plastitanium/twentyfive = 5,
		/obj/item/stack/sheet/mineral/abductor/ten = 5,
		/obj/item/stack/sheet/bluespace_crystal/twentyfive = 5,
		/obj/item/advanced_crafting_components/flux = 5,
		/obj/item/advanced_crafting_components/lenses = 5,
		/obj/item/advanced_crafting_components/receiver = 5,
		/obj/item/advanced_crafting_components/assembly = 5,
		/obj/item/advanced_crafting_components/alloys = 5,
		/obj/item/stack/sheet/mineral/gold/twentyfive = 3,
		/obj/item/stack/sheet/mineral/diamond/twentyfive = 1,
	)

////////////////////////////////
///weapon attachment spawners///
////////////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_mods
	name = "trash attachments"
	loot = list(
		/obj/item/tool_upgrade/productivity/red_paint = 1,
		/obj/item/tool_upgrade/refinement/laserguide = 1,
		/obj/item/tool_upgrade/reinforcement/heatsink = 1,
		/obj/item/gun_upgrade/trigger/raidertrigger = 1,
		/obj/item/gun_upgrade/trigger/boom = 1,

	)

/obj/effect/spawner/lootdrop/f13/common_mods
	name = "common attachments"
	loot = list(
		/obj/item/gun_upgrade/muzzle/silencer = 1,
		/obj/item/gun_upgrade/trigger/cop_block = 1,
		/obj/item/gun_upgrade/scope/watchman = 1,
		/obj/item/gun_upgrade/mechanism/overdrive = 1,
		/obj/item/tool_upgrade/productivity/ergonomic_grip = 1,
		/obj/item/tool_upgrade/productivity/booster = 1,
		/obj/item/tool_upgrade/refinement/stabilized_grip = 1,

	)

/obj/effect/spawner/lootdrop/f13/uncommon_mods
	name = "uncommon attachments"
	loot = list(
		/obj/item/gun_upgrade/barrel/forged = 1,
		/obj/item/gun_upgrade/scope/killer = 1,
		/obj/item/gun_upgrade/mechanism/better = 1,
		/obj/item/gun_upgrade/barrel/excruciator = 1,
		/obj/item/tool_upgrade/reinforcement/guard = 1,
		/obj/item/tool_upgrade/refinement/ported_barrel = 1,
	)


/obj/effect/spawner/lootdrop/f13/rare_mods
	name = "rare attachments"
	loot = list(
		/obj/item/gun_upgrade/barrel/blender = 1,
		/obj/item/gun_upgrade/trigger/better = 1,
		/obj/item/gun_upgrade/barrel/better = 1,
		/obj/item/gun_upgrade/muzzle/better = 1,
		/obj/item/gun_upgrade/scope/better = 1,
		/obj/item/gun_upgrade/mechanism/battery_shunt = 1,
		/obj/item/tool_upgrade/augment/ai_tool = 1,
	)

///////////////////////////
///machine part spawners///
///////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_parts
	name = "trash parts"
	loot = list(
		/obj/item/stock_parts/capacitor/simple = 1,
		/obj/item/stock_parts/scanning_module/simple = 1,
		/obj/item/stock_parts/manipulator/simple = 1,
		/obj/item/stock_parts/micro_laser/simple = 1,
		/obj/item/stock_parts/matter_bin/simple = 1,
		/obj/item/stock_parts/cell = 1,
		/obj/item/circuitboard/machine/autolathe/ammo/improvised = 1,
		/obj/item/stock_parts/chem_cartridge/garbage = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_parts
	name = "common parts"
	loot = list(
		/obj/item/stock_parts/capacitor/adv = 1,
		/obj/item/stock_parts/scanning_module/adv = 1,
		/obj/item/stock_parts/manipulator/nano = 1,
		/obj/item/stock_parts/micro_laser/high = 1,
		/obj/item/stock_parts/matter_bin/adv = 1,
		/obj/item/stock_parts/cell/high = 1,
		/obj/item/stock_parts/chem_cartridge/simple = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_parts
	name = "uncommon parts"
	loot = list(
		/obj/item/stock_parts/capacitor/super = 1,
		/obj/item/stock_parts/scanning_module/phasic = 1,
		/obj/item/stock_parts/manipulator/pico = 1,
		/obj/item/stock_parts/micro_laser/ultra = 1,
		/obj/item/stock_parts/matter_bin/super = 1,
		/obj/item/stock_parts/cell/super = 1,
		/obj/item/stock_parts/chem_cartridge/crafted = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_parts
	name = "rare parts"
	loot = list(
		/obj/item/stock_parts/capacitor/quadratic = 1,
		/obj/item/stock_parts/scanning_module/triphasic = 1,
		/obj/item/stock_parts/manipulator/femto = 1,
		/obj/item/stock_parts/micro_laser/quadultra = 1,
		/obj/item/stock_parts/matter_bin/bluespace = 1,
		/obj/item/stock_parts/cell/hyper = 1,
		/obj/item/stock_parts/chem_cartridge/pristine = 1,
		/obj/item/blueprint/research = 1,
	)

///////////////////
///tool spawners///		tools, surgery equipment, books. maybe add janitor and gardening tools laters
///////////////////

/obj/effect/spawner/lootdrop/f13/trash_tools
	name = "trash tools"
	loot = list(
		/obj/item/retractor/tribal = 1,
		/obj/item/hemostat/tribal = 1,
		/obj/item/handsaw = 1,
		/obj/item/clothing/gloves/f13/crudemedical = 1,
		/obj/item/crowbar/basic = 1,
		/obj/item/wrench/basic = 1,
		/obj/item/screwdriver/basic = 1,
		/obj/item/weldingtool/basic = 1,
		/obj/item/wirecutters/basic = 1,
		/obj/item/restraints/handcuffs/cable = 1,
		/obj/item/restraints/handcuffs/sinew = 1,
		/obj/item/lockpick_set = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_one = 1,
		/obj/item/book/granter/crafting_recipe/ODF = 1,
		/obj/item/geiger_counter = 1,
		/obj/item/reagent_containers/glass/beaker = 1,
		/obj/item/flashlight/flare = 1,
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/flashlight/glowstick = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_tools
	name = "common tools"
	loot = list(
		/obj/item/defibrillator/primitive = 1,
		/obj/item/scalpel = 1,
		/obj/item/circular_saw = 1,
		/obj/item/bonesetter = 1,
		/obj/item/retractor = 1,
		/obj/item/hemostat = 1,
		/obj/item/cautery = 1,
		/obj/item/surgicaldrill = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/crowbar = 1,
		/obj/item/wrench = 1,
		/obj/item/screwdriver = 1,
		/obj/item/weldingtool = 1,
		/obj/item/weldingtool/mini = 1,
		/obj/item/wirecutters = 1,
		/obj/item/extinguisher = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/mop = 1,
		/obj/item/lockpick_set = 1,
		/obj/item/stealthboy = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_two = 1,
		/obj/item/book/granter/crafting_recipe/scav_one = 1,
		/obj/item/book/granter/crafting_recipe/blueprint/trapper = 1,
		/obj/item/reagent_containers/glass/beaker/large = 1,
		/obj/item/flashlight = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_tools
	name = "uncommon tools"
	loot = list(
		/obj/item/scalpel/advanced = 1,
		/obj/item/surgical_drapes/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/crowbar/red = 1,
		/obj/item/wrench/bronze = 1,
		/obj/item/screwdriver/nuke = 1,
		/obj/item/weldingtool/largetank = 1,
		/obj/item/wirecutters/bronze = 1,
		/obj/item/defibrillator = 1,
		/obj/item/extinguisher/mini = 1,
		/obj/item/mop/advanced = 1,
		/obj/item/stealthboy = 1,
		/obj/item/book/granter/action/drink_fling = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_three = 1,
		/obj/item/book/granter/crafting_recipe/scav_two = 1,
		/obj/item/book/granter/trait/explosives = 1,
		/obj/item/reagent_containers/glass/beaker/plastic = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/flashlight/lamp = 1,
		/obj/item/book/granter/martial/raging_boar = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_tools
	name = "rare tools"
	loot = list(
		/obj/item/scalpel/alien = 1,
		/obj/item/hemostat/alien = 1,
		/obj/item/retractor/alien = 1,
		/obj/item/circular_saw/alien = 1,
		/obj/item/surgicaldrill/alien = 1,
		/obj/item/cautery/alien = 1,
		/obj/item/crowbar/power = 1,
		/obj/item/wrench/power = 1,
		/obj/item/weldingtool/hugetank = 1,
		/obj/item/wirecutters/power = 1,
		/obj/item/defibrillator/compact = 1,
		/obj/item/extinguisher/advanced = 1,
		/obj/item/stealthboy = 1,
		/obj/item/book/granter/crafting_recipe/gunsmith_four = 1,
		/obj/item/book/granter/crafting_recipe/scav_three = 1,
		/obj/item/book/granter/trait/explosives_advanced = 1,
		/obj/item/reagent_containers/glass/beaker/meta = 1,
		/obj/item/reagent_containers/glass/beaker/noreact = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/flashlight/lamp = 1,
	)

////////////////////
///money spawners///		will add stacked silver and gold laters. this is all ballpark anywho
////////////////////

/obj/effect/spawner/lootdrop/f13/trash_money
	name = "trash money"
	loot = list(
		/obj/item/stack/f13Cash/random/low = 10,
		/obj/item/stack/f13Cash/denarius = 1,
		/obj/item/card/lowbounty = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_money
	name = "common money"
	loot = list(
		/obj/item/stack/f13Cash/random/med = 10,
		/obj/item/stack/f13Cash/denarius = 5,
		/obj/item/card/midbounty = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_money
	name = "uncommon money"
	loot = list(
		/obj/item/stack/f13Cash/random/med = 10,
		/obj/item/stack/f13Cash/denarius = 3,
		/obj/item/stack/f13Cash/aureus = 1,
		/obj/item/card/highbounty = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_money
	name = "rare money"
	loot = list(
		/obj/item/stack/f13Cash/random/high = 10,
		/obj/item/stack/f13Cash/aureus = 5,
		/obj/item/stack/f13Cash/denarius = 1,
		/obj/item/card/kingbounty = 1,
	)

////////////////////
///bomb spawners~///
////////////////////

/obj/effect/spawner/lootdrop/f13/trash_bombs
	name = "trash bombs"
	loot = list(
		/obj/item/grenade/f13/dynamite = 5,
		/obj/item/grenade/homemade/coffeepotbomb = 1,
		/*/obj/item/grenade/homemade/firebomb = 100,*/
		/*/obj/item/reagent_containers/food/drinks/bottle/molotov= 100,*/
		// /obj/item/gun/ballistic/fatman = 1, //we do a lil trolling~ --fatman got buffed, needs to be rare now
	)

/obj/effect/spawner/lootdrop/f13/common_bombs
	name = "common bombs"
	loot = list(
		/obj/item/grenade/homemade/coffeepotbomb = 5,
		/obj/item/grenade/f13/dynamite = 3,
		/*/obj/item/grenade/homemade/firebomb = 1,*/
		/*/obj/item/reagent_containers/food/drinks/bottle/molotov= 1,*/
		/obj/item/grenade/flashbang = 3,
		/obj/item/grenade/plastic = 1,
		/obj/item/grenade/empgrenade = 1,
		/obj/item/storage/box/dynamite_box = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_bombs
	name = "uncommon bombs"
	loot = list(
		/obj/item/grenade/f13/frag = 10,
		/obj/item/ammo_box/a40mm = 5,
		/obj/item/grenade/f13/stinger = 3,
		/obj/item/grenade/empgrenade = 3,
		/obj/item/grenade/stingbang = 3,
		/obj/item/gun/ballistic/revolver/grenadelauncher = 2,
		/obj/item/gun/ballistic/shotgun/grenade = 1,
		/obj/item/ammo_box/a40mm/hedp = 1,
		/obj/item/grenade/plastic/c4 = 1,
		/obj/item/grenade/f13/radiation = 1,
		/obj/item/grenade/spawnergrenade/spesscarp = 1,
		/obj/item/grenade/spawnergrenade/manhacks = 1,
		/obj/item/grenade/spawnergrenade/buzzkill = 1,
		/obj/item/grenade/syndieminibomb/concussion = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_bombs
	name = "rare bombs"
	loot = list(
/obj/item/grenade/syndieminibomb/concussion = 20,
/obj/item/grenade/plastic/x4 = 10,
/obj/item/grenade/f13/plasma = 10,
/obj/item/ammo_casing/caseless/rocket = 10,
/obj/item/gun/ballistic/rocketlauncher = 5,
/obj/item/ammo_casing/caseless/rocket/hedp = 5,
//obj/item/ammo_casing/caseless/rocket/incendiary = 1, //you know what? no. these suck. it always feels bad finding an incendiary or chemical rocket instead of a standard one, knowing that they're designed as PVP gamer ammos, and are useless against simple mobs. if you want them? craft them.
//obj/item/ammo_casing/caseless/rocket/chem = 1,
/obj/item/ammo_casing/caseless/rocket/big = 5,
/obj/item/grenade/clusterbuster = 1,	//these are all rare fun toys~
/obj/item/grenade/clusterbuster/soap = 1,
/obj/item/grenade/clusterbuster/spawner_spesscarp = 1,
/obj/item/grenade/clusterbuster/spawner_manhacks = 1,
/obj/item/grenade/frag/mega = 1,
/obj/item/ammo_casing/caseless/mininuke = 1,
/obj/item/grenade/stingbang/mega = 1,
	)

//////////////////////////////////
///foooooooooooooooood spawners///		welcome to the dan zone. incomplete list but there's a lot of food out there
//////////////////////////////////

/obj/effect/spawner/lootdrop/f13/trash_food
	name = "trash food"
	loot = list(
		/obj/item/reagent_containers/food/snacks/cannedpeaches/maint = 10,
		/obj/item/reagent_containers/food/snacks/deadmouse = 10,
		/obj/item/reagent_containers/food/snacks/f13/bubblegum = 10,
		/obj/item/reagent_containers/food/snacks/breadhard = 10,
		/obj/item/reagent_containers/food/snacks/meatsalted = 10,
		/obj/item/reagent_containers/food/snacks/f13/crispysquirrel = 10,
		/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans = 10,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog = 10,
		/obj/item/reagent_containers/food/snacks/f13/fried_molerat_lung = 10,
		/obj/item/reagent_containers/food/drinks/sillycup = 10,
		/obj/item/reagent_containers/food/drinks/bottle/orangejuice = 10,
		/datum/reagent/consumable/mayonnaise = 1,
		/obj/item/seeds/ambrosia = 1,
		/obj/item/seeds/apple = 1,
		/obj/item/seeds/banana = 1,
		/obj/item/seeds/cotton = 1,
		/obj/item/seeds/berry = 1,
		/obj/item/seeds/poppy/broc = 1,
		/obj/item/seeds/cabbage = 1,
		/obj/item/seeds/carrot = 1,
		/obj/item/seeds/carrot/parsnip = 1,
		/obj/item/seeds/cherry = 1,
		/obj/item/seeds/chanterelle = 1,
		/obj/item/seeds/chili = 1,
		/obj/item/seeds/cocoapod = 1,
		/obj/item/seeds/coffee = 1,
		/obj/item/seeds/corn = 1,
		/obj/item/seeds/eggplant = 1,
		/obj/item/seeds/grape = 1,
		/obj/item/seeds/grass = 1,
		/obj/item/seeds/lemon = 1,
		/obj/item/seeds/lime = 1,
		/obj/item/seeds/onion = 1,
		/obj/item/seeds/orange = 1,
		/obj/item/seeds/rainbow_bunch = 1,
		/obj/item/seeds/pineapple = 1,
		/obj/item/seeds/potato = 1,
		/obj/item/seeds/poppy = 1,
		/obj/item/seeds/pumpkin = 1,
		/obj/item/seeds/wheat/rice = 1,
		/obj/item/seeds/soya = 1,
		/obj/item/seeds/sugarcane = 1,
		/obj/item/seeds/sunflower = 1,
		/obj/item/seeds/tea = 1,
		/obj/item/seeds/tobacco = 1,
		/obj/item/seeds/tomato = 1,
		/obj/item/seeds/tower = 1,
		/obj/item/seeds/watermelon = 1,
		/obj/item/seeds/wheat = 1,
		/obj/item/seeds/whitebeet = 1,
		/obj/item/seeds/xander = 1,
		/obj/item/seeds/mutfruit = 1,
		/obj/item/seeds/amanita = 1,
		/obj/item/seeds/glowshroom = 1,
		/obj/item/seeds/liberty = 1,
		/obj/item/seeds/nettle = 1,
		/obj/item/seeds/plump = 1,
		/obj/item/seeds/reishi = 1,
		/obj/item/seeds/cannabis = 1,
		/obj/item/seeds/starthistle = 1,
		/obj/item/seeds/random = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_food
	name = "common food"
	loot = list(
		/obj/item/reagent_containers/food/snacks/f13/bubblegum = 1,
		/obj/item/reagent_containers/food/snacks/f13/cram = 1,
		/obj/item/reagent_containers/food/snacks/f13/yumyum = 1,
		/obj/item/reagent_containers/food/snacks/f13/fancylads = 1,
		/obj/item/reagent_containers/food/snacks/f13/sugarbombs = 1,
		/obj/item/reagent_containers/food/snacks/f13/crisps = 1,
		/obj/item/reagent_containers/food/snacks/f13/steak = 1,
		/obj/item/reagent_containers/food/snacks/f13/dandyapples = 1,
		/obj/item/reagent_containers/food/snacks/f13/blamco = 1,
		/obj/item/reagent_containers/food/snacks/f13/instamash = 1,
		/obj/item/reagent_containers/food/snacks/f13/squirrelstick = 1,
		/obj/item/reagent_containers/food/snacks/f13/canned/porknbeans = 1,
		/obj/item/reagent_containers/food/snacks/f13/canned/borscht = 1,
		/obj/item/reagent_containers/food/snacks/f13/canned/dog = 1,
		/obj/item/storage/box/ingredients/carnivore = 1,
		/obj/item/storage/box/ingredients/delights = 1,
		/obj/item/storage/box/ingredients/exotic = 1,
		/obj/item/storage/box/ingredients/fiesta = 1,
		/obj/item/storage/box/ingredients/fruity = 1,
		/obj/item/storage/box/ingredients/grains = 1,
		/obj/item/storage/box/ingredients/italian = 1,
		/obj/item/storage/box/ingredients/sweets = 1,
		/obj/item/storage/box/ingredients/vegetarian = 1,
		/obj/item/storage/box/ingredients/wildcard = 1,
		/obj/item/reagent_containers/food/condiment/flour = 1,
		/obj/item/reagent_containers/food/condiment/rice = 1,
		/obj/item/reagent_containers/food/condiment/yeast = 1,
		/obj/item/reagent_containers/food/condiment/soymilk = 1,
		/obj/item/reagent_containers/food/condiment/ketchup = 1,
		/obj/item/reagent_containers/food/condiment/sugar = 1,
		/obj/item/reagent_containers/food/condiment/milk = 1,
		/obj/item/reagent_containers/food/condiment/saltshaker = 1,
		/obj/item/reagent_containers/food/condiment/peppermill = 1,
		/obj/item/reagent_containers/food/condiment/soysauce = 1,
		/obj/item/reagent_containers/food/snacks/beans = 1,
		/obj/item/reagent_containers/food/snacks/cracker = 1,
		/obj/item/reagent_containers/food/snacks/lollipop = 1,
		/obj/item/reagent_containers/food/drinks/beer = 1,
		/obj/item/reagent_containers/food/drinks/ale = 1,
		/obj/item/reagent_containers/food/drinks/bottle/gin = 1,
		/obj/item/reagent_containers/food/drinks/bottle/hcider = 1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vodka = 1,
		/obj/item/reagent_containers/food/drinks/bottle/tequila = 1,
		/obj/item/reagent_containers/food/drinks/bottle/rum = 1,
		/obj/item/reagent_containers/food/drinks/bottle/vermouth = 1,
		/obj/item/reagent_containers/food/drinks/bottle/kahlua = 1,
		/obj/item/reagent_containers/food/drinks/bottle/cognac = 1,
		/obj/item/reagent_containers/food/drinks/bottle/wine = 1,
		/obj/item/reagent_containers/food/drinks/bottle/absinthe = 1,
		/obj/item/reagent_containers/food/drinks/bottle/lizardwine = 1,
		/obj/item/reagent_containers/food/drinks/bottle/hcider = 1,
		/obj/item/reagent_containers/food/drinks/bottle/grappa = 1,
		/obj/item/reagent_containers/food/drinks/bottle/sake = 1,
		/obj/item/reagent_containers/food/drinks/bottle/fernet = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_food
	name = "uncommon food"
	loot = list(
		/obj/item/reagent_containers/food/snacks/f13/bubblegum/large = 1,
		/obj/item/reagent_containers/food/snacks/f13/cram/large = 1,
		/obj/item/reagent_containers/food/snacks/f13/specialapples = 1,
		/obj/item/reagent_containers/food/snacks/f13/blamco/large = 1,
		/obj/item/reagent_containers/food/snacks/f13/mechanic = 1,
		/obj/item/reagent_containers/food/snacks/f13/galette = 1,
		/obj/item/reagent_containers/food/snacks/meatsmoked = 1,
		/obj/item/reagent_containers/food/snacks/f13/wastelandwellington = 1,
		/obj/item/export/bottle/gin = 1,
		/obj/item/export/bottle/whiskey = 1,
		/obj/item/export/bottle/wine = 1,
		/obj/item/export/bottle/vodka = 1,
		/obj/item/export/bottle/rum = 1,
		/obj/item/export/bottle/tequila = 1,
		/obj/item/export/bottle/minikeg = 1,
		/obj/item/export/bottle/applejack = 1,
		/obj/item/export/bottle/cognac = 1,
		/obj/item/export/bottle/sake = 1,
		/obj/item/export/bottle/hcider = 1,
		/obj/item/export/bottle/vermouth = 1,
		/obj/item/export/bottle/absinthe = 1,
		/obj/item/export/bottle/grappa = 1,
		/obj/item/export/bottle/fernet = 1,
		/obj/item/export/bottle/kahlua = 1,
		/obj/item/export/bottle/champagne = 1,
		/obj/item/export/bottle/blazaam = 1,
		/obj/item/export/bottle/nukashine = 1,
		/obj/item/export/bottle/trappist = 1,
		/obj/item/export/bottle/goldschlager = 1,
		/obj/item/export/bottle/patron = 1,
	)

/obj/effect/spawner/lootdrop/f13/common_artifacts
	name = "common artifacts"
	loot = list(
		/obj/item/artifact/common = 10,
		/obj/item/artifact/uncommon = 1,
		/obj/item/artifact/rare = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_artifacts
	name = "uncommon artifacts"
	loot = list(
		/obj/item/artifact/common = 10,
		/obj/item/artifact/uncommon = 4,
		/obj/item/artifact/rare = 1,
	)

/obj/effect/spawner/lootdrop/f13/rare_artifacts
	name = "rare artifacts"
	loot = list(
		/obj/item/artifact/common = 1,
		/obj/item/artifact/uncommon = 2,
		/obj/item/artifact/rare = 10,
	)

/obj/effect/spawner/lootdrop/f13/rare_food
	name = "rare food"
	loot = list(
		/obj/item/reagent_containers/food/snacks/f13/mre = 1,
		/obj/item/reagent_containers/food/snacks/f13/deathclawegg = 1,
		/obj/item/reagent_containers/food/snacks/f13/molejerky = 1,
		/obj/item/reagent_containers/food/snacks/f13/caravanlunch = 1,
		/obj/item/reagent_containers/food/snacks/f13/deathclawomelette = 1,
		/obj/item/storage/box/ration/menu_one = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		/obj/item/storage/box/ration/menu_three = 1,
		/obj/item/storage/box/ration/menu_four = 1,
		/obj/item/storage/box/ration/menu_five = 1,
		/obj/item/storage/box/ration/menu_six = 1,
		/obj/item/storage/box/ration/menu_seven = 1,
		/obj/item/storage/box/ration/menu_eight = 1,
		/obj/item/storage/box/ration/menu_nine = 1,
		/obj/item/storage/box/ration/menu_ten = 1,
		/obj/item/storage/box/ration/menu_eleven = 1,
		/obj/item/storage/box/ration/ranger_breakfast = 1,
		/obj/item/storage/box/ration/ranger_lunch = 1,
		/obj/item/storage/box/ration/ranger_dinner = 1,
	)

///////////////////
///mice spawner///
///////////////////

/obj/effect/spawner/lootdrop/f13/mice
	name = "trash mice"
	loot = list(
		/obj/effect/spawner/bundle/mobs/rat/one = 3000,
		/obj/effect/spawner/bundle/mobs/rat/three = 900,
		/obj/effect/spawner/bundle/mobs/rat/five = 100,
		/obj/effect/spawner/bundle/mobs/rat/actually_a_deathclaw = 1, //because yes...until someone cries and says no~
	)

////////////////////
///tramsh spawner///		I didn't bother to change the percent chance of all these
////////////////////

/obj/effect/spawner/lootdrop/f13/trash_trash
	name = "trash trash"
	loot = list(
		/obj/effect/spawner/lootdrop/gloves = 8,
		/obj/item/stack/cable_coil/random/five = 6,
		/obj/item/trash/f13/electronic/toaster = 5,
		/obj/item/reagent_containers/glass/bucket = 5,
		/obj/item/kitchen/knife = 5,
		/obj/item/kitchen/fork = 5,
		/obj/item/storage/bag/tray = 5,
		/obj/item/reagent_containers/glass/bowl = 5,
		/obj/item/reagent_containers/food/drinks/drinkingglass = 5,
		/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass = 5,
		/obj/item/taperecorder/empty = 5,
		/obj/item/light/tube = 5,
		/obj/item/light/bulb = 5,
		/obj/item/reagent_containers/syringe = 5,
		/obj/item/restraints/handcuffs = 5,
		/obj/item/toy/crayon/spraycan = 5,
		/obj/item/laser_pointer = 5,
		/obj/item/weapon/dvd = 5,
		/obj/item/storage/daki = 5,
		/obj/item/assembly/prox_sensor = 4,
		/obj/item/stack/cable_coil/random = 4,
		/obj/item/reagent_containers/rag = 3,
		/obj/item/assembly/timer = 3,
		/obj/item/storage/secure/briefcase = 3,
		/obj/item/storage/toolbox/artistic = 2,
		/obj/item/storage/box/marshmallow = 2,
		/obj/item/clothing/head/cone = 2,
		/obj/item/assembly/igniter = 2,
		/obj/item/assembly/signaler = 2,
		/obj/item/assembly/mousetrap = 2,
		/obj/item/reagent_containers/syringe = 2,
		/obj/item/clothing/suit/hooded/flashsuit = 2,
		/obj/item/storage/box = 2,
		/obj/item/clothing/glasses/meson = 2,
		/obj/item/bodybag = 1,
		/obj/item/clothing/glasses/sunglasses = 1,
		/obj/item/clothing/gloves/color/fyellow = 1,
		/obj/item/clothing/head/hardhat = 1,
		/obj/item/clothing/head/hardhat/red = 1,
		/obj/item/clothing/head/that = 1,
		/obj/item/clothing/head/ushanka = 1,
		/obj/item/clothing/head/welding = 1,
		/obj/item/clothing/suit/hazardvest = 1,
		/obj/item/clothing/under/misc/vice_officer = 1,
		/obj/item/clothing/accessory/medal/greytide = 1,
		/obj/item/coin/silver = 1,
		/obj/item/coin/twoheaded = 1,
		/obj/item/poster/random_contraband = 1,
		/obj/item/poster/random_official = 1,
		/obj/item/hand_labeler = 1,
		/obj/item/paper/crumpled = 1,
		/obj/item/pen = 1,
		/obj/item/reagent_containers/spray/pestspray = 1,
		/obj/item/storage/box/cups = 1,
		/obj/item/storage/fancy/cigarettes/dromedaryco = 1,
		/obj/item/radio/headset = 1,
		/obj/item/assembly/infra = 1,
		/obj/item/clothing/shoes/laceup = 1,
		/obj/item/toy/eightball = 1,
		/obj/item/clothing/shoes/kindleKicks = 1,
		/obj/item/clothing/gloves/tackler/offbrand = 1,
		/obj/item/stack/sticky_tape = 1,
	)
