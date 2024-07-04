
//Last updated November 2023//

/////////////////////
///master spawners///
/////////////////////
/obj/effect/spawner/lootdrop/f13/trash
	name = "trash loot, found everywhere BUT the trash"
	delay_spawn = FALSE
	loot = list(
		/obj/effect/spawner/lootdrop/f13/trash_weps = 10,
		/obj/effect/spawner/lootdrop/f13/trash_mags = 10,
		/obj/effect/spawner/lootdrop/f13/trash_ammo = 10,
		/obj/effect/spawner/lootdrop/f13/trash_medicine = 10,
		/obj/effect/spawner/lootdrop/f13/trash_drugs = 8,
		/obj/effect/spawner/lootdrop/f13/trash_armor = 10,
		/obj/effect/spawner/lootdrop/f13/trash_toys = 5,
		/obj/effect/spawner/lootdrop/f13/trash_mats = 10,
//		/obj/effect/spawner/lootdrop/f13/trash_mods = 10,
		/obj/effect/spawner/lootdrop/f13/trash_parts = 10,
		/obj/effect/spawner/lootdrop/f13/trash_tools = 10,
		/obj/effect/spawner/lootdrop/f13/trash_money = 10,
		/obj/effect/spawner/lootdrop/f13/trash_bombs = 10,
		/obj/effect/spawner/lootdrop/f13/trash_food = 10,
		/obj/effect/spawner/lootdrop/f13/trash_trash = 40,
		/obj/effect/spawner/lootdrop/f13/mice = 3, //the mice are extra~
	)

/obj/effect/spawner/lootdrop/f13/trash/pile
	name = "trash loot, found ONLY IN the trash"
	delay_spawn = TRUE
	fan_out_turfs_range = 1

/obj/effect/spawner/lootdrop/f13/common
	name = "common loot, found everywhere"
	icon_state = "x5"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/common_weps = 10,
		/obj/effect/spawner/lootdrop/f13/common_mags = 10,
		/obj/effect/spawner/lootdrop/f13/common_ammo = 10,
		/obj/effect/spawner/lootdrop/f13/common_medicine = 10,
		/obj/effect/spawner/lootdrop/f13/common_drugs = 8,
		/obj/effect/spawner/lootdrop/f13/common_armor = 10,
		/obj/effect/spawner/lootdrop/f13/common_toys = 4,
		/obj/effect/spawner/lootdrop/f13/common_mats = 10,
//		/obj/effect/spawner/lootdrop/f13/common_mods = 10,
		/obj/effect/spawner/lootdrop/f13/common_parts = 10,
		/obj/effect/spawner/lootdrop/f13/common_tools = 10,
		/obj/effect/spawner/lootdrop/f13/common_money = 10,
		/obj/effect/spawner/lootdrop/f13/common_bombs = 10,
		/obj/effect/spawner/lootdrop/f13/common_food = 10,
	)
	downtier_chance = 10 // 10% chance to downtier to trash
	downtier_list = list(
		/obj/effect/spawner/lootdrop/f13/trash = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon
	name = "uncommon loot, found in dungeons"
	icon_state = "x6"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_weps = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_mags = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_ammo = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_medicine = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_drugs = 8,
		/obj/effect/spawner/lootdrop/f13/uncommon_armor = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_toys = 3,
		/obj/effect/spawner/lootdrop/f13/uncommon_mats = 10,
//		/obj/effect/spawner/lootdrop/f13/uncommon_mods = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_parts = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_tools = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_money = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_bombs = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_food = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_artifacts = 5,
	)
	uptier_chance = 1 // 1% chance to uptier to a restricted rare
	uptier_list = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_upgrade = 1,
	)
	downtier_chance = 10 // 10% chance to downtier to common
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
		/obj/effect/spawner/lootdrop/f13/rare_primary = 10,
		/obj/effect/spawner/lootdrop/f13/rare_secondary = 10,
		/obj/effect/spawner/lootdrop/f13/rare_tertiary = 10,
	)
	downtier_chance = 10 // 10% chance to downtier to uncommon (and no lower)
	downtier_list = list(
		/obj/effect/spawner/lootdrop/f13/uncommon = 1,
	)
	snap_category = "RARE"


/obj/effect/spawner/lootdrop/f13/rare_primary
	name = "rare high-value loot, found in dangerous dungeons"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_weps = 10,
		/obj/effect/spawner/lootdrop/f13/rare_armor = 10,
		/obj/effect/spawner/lootdrop/f13/rare_ammo = 10,
		/obj/effect/spawner/lootdrop/f13/rare_mags = 10,
	)

/// Generally decent stuff, but not as good as the rare primary loot. Shouldnt affect tiering if given in uncommon loot rarely.
/obj/effect/spawner/lootdrop/f13/rare_secondary
	name = "rare but less valuable loot, found in dangerous dungeons or as a rare upgrade to uncommon loot"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_medicine = 20,
//		/obj/effect/spawner/lootdrop/f13/rare_mods = 20,
		/obj/effect/spawner/lootdrop/f13/rare_drugs = 10,
		/obj/effect/spawner/lootdrop/f13/rare_mats = 10,
		/obj/effect/spawner/lootdrop/f13/rare_parts = 10,
		/obj/effect/spawner/lootdrop/f13/rare_tools = 10,
		/obj/effect/spawner/lootdrop/f13/rare_money = 10,
		/obj/effect/spawner/lootdrop/f13/rare_bombs = 10,
		/obj/effect/spawner/lootdrop/f13/rare_artifacts = 5,
	)

/// Generally decent stuff, but are mostly consumables or stuff mainly just valuable for selling. Shouldnt affect tiering if given in uncommon loot rarely.
/obj/effect/spawner/lootdrop/f13/rare_tertiary
	name = "rare but generally trash loot, found in dangerous dungeons or as a rare additional drop to uncommon+ loot"
	icon_state = "x7"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_medicine = 15,
		/obj/effect/spawner/lootdrop/f13/rare_drugs = 10,
		/obj/effect/spawner/lootdrop/f13/rare_toys = 5,
		/obj/effect/spawner/lootdrop/f13/rare_parts = 10,
		/obj/effect/spawner/lootdrop/f13/rare_money = 15,
		/obj/effect/spawner/lootdrop/f13/rare_food = 5,
	)

////////////////////////////
///master weapon spawners///	these ensure fair distribution of different weapon types
////////////////////////////	If you *can,* try and make the values add up to 100. That makes it an easily readable percent. If not, just follow the list's trends.

/obj/effect/spawner/lootdrop/f13/trash_weps
	name = "trash weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/trash_guns = 50,
		/obj/effect/spawner/lootdrop/f13/trash_melee = 50,
	)

/obj/effect/spawner/lootdrop/f13/common_weps
	name = "common weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/common_guns = 30, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/common_melee = 30,
		/obj/effect/spawner/lootdrop/f13/common_cowboy = 15,
		/obj/effect/spawner/lootdrop/f13/common_energy = 30,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_weps
	name = "uncommon weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/uncommon_guns = 30, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/uncommon_melee = 30,
		/obj/effect/spawner/lootdrop/f13/uncommon_cowboy = 15,
		/obj/effect/spawner/lootdrop/f13/uncommon_energy = 30,
	)

/obj/effect/spawner/lootdrop/f13/rare_weps
	name = "rare weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/rare_guns = 30, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/rare_melee = 30,
		/obj/effect/spawner/lootdrop/f13/rare_energy = 30,
		/obj/effect/spawner/lootdrop/f13/rare_cowboy = 10,
		/obj/effect/spawner/lootdrop/f13/uncommon_weps = 20
	)

/obj/effect/spawner/lootdrop/f13/very_rare
	name = "very rare weapons"
	loot = list(
		/obj/effect/spawner/lootdrop/f13/very_rare_guns = 50, //can adjust these values as needed
		/obj/effect/spawner/lootdrop/f13/very_rare_energy = 50,
	)

///////////////////////////////
///ballistic weapon spawners///
///////////////////////////////

/// DPS should be 100 or less
/// If it's on the higher or lower side, it should have another stat lowered or raised such as magazine capacity.
/obj/effect/spawner/lootdrop/f13/trash_guns
	name = "trash guns"
	loot = list(                                                                // dps(banedps) mag cap        *staple
		//Primary weapon candidates
		/obj/item/gun/ballistic/revolver/winchesterrebored = 6,                 //138         2      really not that good
		/obj/item/gun/ballistic/automatic/pistol/deagle = 8,                    //96          8
		/obj/item/gun/ballistic/automatic/hobo/zipgun = 10,                     //86          5
		/obj/item/gun/ballistic/revolver/hobo/pepperbox = 10,                   //78          4
		/obj/item/gun/ballistic/automatic/pistol/fivemilimeterpistol = 10,      // 78         20          *
		/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle = 8,               // 66         25

		//Single shot or meme weapons
		/obj/item/gun/ballistic/revolver/hobo/piperifle = 2,                    //136         1
//		/obj/item/gun/flintlock/musket/jezail = 3,                              //131         1
//		/obj/item/gun/flintlock/musket = 3,                                     //118         1
//		/obj/item/gun/flintlock/musketoon = 3,                                  //118         1
		/obj/item/gun/ballistic/rifle/mosin/mini = 2,                           //113         5
//		/obj/item/gun/flintlock = 3,                                            //87.5        1
		/obj/item/gun/ballistic/revolver/shotpistol = 2,                        //85          1
		/obj/item/gun/ballistic/revolver/hobo/single_shotgun = 2,               //74 (102)    1
		/obj/item/gun/ballistic/revolver/hobo/knifegun = 2,                     //43          1
		/obj/item/gun/ballistic/revolver/hobo/knucklegun = 2,                   //40          4
	)

/// DPS should be 100-150 ish
/// If it's on the higher or lower side, it should have another stat lowered or raised such as magazine capacity.
/obj/effect/spawner/lootdrop/f13/common_guns
	name = "common guns"
	loot = list(                                                            // dps	mag cap     *staple
		/obj/item/gun/ballistic/automatic/type93/worn = 4,                  //156 20
		/obj/item/gun/ballistic/automatic/smg/mini_uzi = 5,                 //151 32
		/obj/item/gun/ballistic/automatic/varmint/ratslayer = 6,            //151 10
		/obj/item/gun/ballistic/automatic/smg/american180 = 6,              //150 180
		/obj/item/gun/ballistic/automatic/smg/american180/b180 = 1,         //150 180
		/obj/item/gun/ballistic/automatic/smg/american180/dp27 = 1,			//150 180
		/obj/item/gun/ballistic/automatic/saiga12k = 8,                     //146 8
		/obj/item/gun/ballistic/shotgun/needles = 8,                        //???
		/obj/item/gun/ballistic/automatic/needlersmg = 9,                    //???
		/obj/item/gun/ballistic/automatic/pistol/beretta/carbine = 10,      //139 15
		/obj/item/gun/ballistic/automatic/rangemaster = 10,                 //138 7
		/obj/item/gun/ballistic/automatic/combat = 10,                      //138 20
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22 = 10,          //135 32        *
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/mp22 = 4, 		//135 32
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/ppsh = 2,			//135 32
		/obj/item/gun/ballistic/automatic/hobo/destroyer = 10,              //132 30
		/obj/item/gun/ballistic/automatic/smg/sidewinder = 10,              //126 15
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/smg22/tec22 = 10,    //121 16
		/obj/item/gun/ballistic/automatic/varmint = 10,                     //121 10
		/obj/item/gun/ballistic/automatic/m1carbine/compact = 10,           //120 12
		/obj/item/gun/ballistic/automatic/assault_carbine/scarrifle = 10,   //115 30
		/obj/item/gun/ballistic/automatic/assault_carbine/aug5mm = 10,      //115 30
		/obj/item/gun/ballistic/automatic/armalite = 10,                    //115 30
		/obj/item/gun/ballistic/automatic/fnfal/ak47 = 10,                  //114 20
		/obj/item/gun/ballistic/shotgun/automatic/combat/neostead = 10,     //113 6
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/rockwell = 5,        //113 20 ECHO
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/owengun = 5,         //113 20 echo
		/obj/item/gun/ballistic/automatic/sportcarbine/m1_22 = 10,          //110 32
		/obj/item/gun/ballistic/automatic/l1a1 = 10,                        //104 10
		/obj/item/gun/ballistic/automatic/slr = 10,                         //104 10
		/obj/item/gun/ballistic/automatic/m1garand/sks = 9,                 //103 8
		/obj/item/gun/ballistic/automatic/varmint/bushmaster_arm_gun = 8,   //102 20
		/obj/item/gun/ballistic/automatic/assault_carbine/psg5mm = 6,       //90 30
		//sidearms
		/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan = 4,     //149 7
		/obj/item/gun/ballistic/automatic/pistol/beretta = 4,               //126 15
		/obj/item/gun/ballistic/automatic/pistol/ninemil/auto = 4,          //125 10
		/obj/item/gun/ballistic/automatic/pistol/ninemil/rare99 = 4,        //119.6 12
		/obj/item/gun/ballistic/automatic/pistol/vg77 = 4,                  //113 15
		/obj/item/gun/ballistic/automatic/pistol/automag = 4,               //106 7
		/obj/item/gun/ballistic/automatic/pistol/n99/executive = 1,         //104 12
		/obj/item/gun/ballistic/automatic/pistol/n99/crusader = 1,          //104 12
		/obj/item/gun/ballistic/automatic/pistol/n99 = 2,                   //104 12
	)

/obj/effect/spawner/lootdrop/f13/uncommon_guns
	name = "uncommon guns"
	loot = list(
		//primary weapon candidates                                         //dps mag cap
		/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle = 7,          //249 20
		/obj/item/gun/ballistic/automatic/autopipe = 8,                     //244 18
		/obj/item/gun/ballistic/automatic/r84 = 9,                          //241 60
		/obj/item/gun/ballistic/automatic/rifle47mm/china = 10,            //240.73 35
		/obj/item/gun/ballistic/automatic/smg/cg45/worn = 10,               //234 36
		/obj/item/gun/ballistic/automatic/smg/smg10mm/worn = 10, 			//234 24
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10 = 10, 			//227 32
		/obj/item/gun/ballistic/automatic/r93 = 10,                         //217 20
		/obj/item/gun/ballistic/shotgun/automatic/combat/auto5 = 10,        //213 4
		/obj/item/gun/ballistic/automatic/assault_carbine = 10,             //209 30
		/obj/item/gun/ballistic/automatic/ak556 = 10,                       //209 30
		/obj/item/gun/ballistic/automatic/smg/p90/worn = 10,                //208 50
		/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator = 10,   //208 20
		/obj/item/gun/ballistic/automatic/fnfal = 10,                       //207 10
		/obj/item/gun/ballistic/automatic/matildar = 5,                     //207 10
		/obj/item/gun/ballistic/automatic/compact14mmrifle = 10,            //199 21
		/obj/item/gun/ballistic/automatic/service/alr = 10,                 //199 20
		/obj/item/gun/ballistic/automatic/marksman = 10,                    //199 20
		/obj/item/gun/ballistic/automatic/aksmol = 10,                      //199 20
		/obj/item/gun/ballistic/automatic/rifle47mm = 10,                    //196.25 35
		/obj/item/gun/ballistic/automatic/sportcarbine = 10,                //186 32
		/obj/item/gun/ballistic/automatic/service/carbine = 5,              //181 20
		/obj/item/gun/ballistic/automatic/service = 5,                      //181 20
		/obj/item/gun/ballistic/automatic/service/r82 = 10,                 //181 20
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5 = 10,            //185 32
		/obj/item/gun/ballistic/automatic/type93 = 10,                      //181 20
		/obj/item/gun/ballistic/automatic/marksman/policerifle = 10,        //180 20
		/obj/item/gun/ballistic/automatic/needlerrifle = 10,                //106(175) 24
		/obj/item/gun/ballistic/automatic/assault_carbine/m5a1 = 10,        //172 30
		/obj/item/gun/ballistic/rifle/antique/tankgun = 5,                  //168
		/obj/item/gun/ballistic/automatic/assault_carbine/policerifle = 10, //157 30
		/obj/item/gun/ballistic/automatic/famas/pristine = 10,              //154 20
		/obj/item/gun/ballistic/automatic/rpd = 9,                          //152 40
		/obj/item/gun/ballistic/automatic/democracy = 5,                     //151 20
		/obj/item/gun/ballistic/automatic/shotgun/riot = 8,                 //beanbags 8
		/obj/item/gun/ballistic/automatic/smg/sidewinder/magnum = 7,        //97 8 multicaliber, deceiving stats

		//sidearms
		/obj/item/gun/ballistic/automatic/pistol/beretta/automatic = 3, 	//252 15
		/obj/item/gun/ballistic/automatic/pistol/schmeisser = 1,            //208 12
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 3,                  //198 12
		/obj/item/gun/ballistic/automatic/pistol/sig = 3,                   //180 8
		/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion = 3,      //168 15
		/obj/item/gun/ballistic/automatic/pistol/pistol22 = 3,              //150 16
		/obj/item/gun/ballistic/automatic/pistol/pistol22/val = 1,			//150 16
		/obj/item/gun/ballistic/automatic/pistol/pistol14/lildevil = 1,     //143 7
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 3,          //138 8
		/obj/item/gun/ballistic/automatic/pistol/pistol14 = 1,              //130 7
		/obj/item/gun/ballistic/automatic/pistol/pistol14/compact = 1,      //130 7
)

/obj/effect/spawner/lootdrop/f13/rare_guns
	name = "rare guns"
	loot = list(                                                          //dps(bane) mag cap
		/obj/item/gun/ballistic/automatic/smg/smg10mm = 7,                //281 24
		/obj/item/gun/ballistic/automatic/concussive = 8,                 //281 8
		/obj/item/gun/ballistic/automatic/unmcamr = 9,                    //279 4
		/obj/item/gun/ballistic/automatic/assault_rifle = 10,             //277 20
		/obj/item/gun/ballistic/automatic/smg/mp5sd = 10,                 //277 32
		/obj/item/gun/ballistic/automatic/m1919 = 10,                     //276 80
		/obj/item/gun/ballistic/automatic/xl70e3 = 10,                    //265 20
		/obj/item/gun/ballistic/automatic/smg/smg14 = 10,                 //260 21
		/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle = 10,       //249 20
		/obj/item/gun/ballistic/automatic/needlerhmg = 1,                 //243(448) 72
		/obj/item/gun/ballistic/automatic/lsw = 10,                       //241 50
		/obj/item/gun/ballistic/revolver/needlerrifle = 3,                 //220(520) 3
		/obj/item/gun/ballistic/automatic/smg/p90 = 9,                    //260 50
		/obj/item/gun/ballistic/automatic/marksman/sniper/gold = 1,       //110 7
		/obj/item/gun/ballistic/automatic/marksman/sniper = 8,            //99 7

		//wildcards and sidearms
		/obj/item/gun/ballistic/rifle/mag/antimaterial = 3,               //152 8
		/obj/item/gun/ballistic/automatic/pistol/ninemil/maria = 3,       //277 15
		/obj/item/gun/ballistic/revolver/shotpistol/flair_gun = 1,        //254 1
		/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller = 3,  //113 12
	)

/// DPS should be 300+ or have some other excellent quality like magazine capacity
/obj/effect/spawner/lootdrop/f13/very_rare_guns
	name = "very rare guns"
	loot = list(                                                        //dps(bane) mag cap
		/obj/item/gun/ballistic/rifle/leespeedster = 5,                 //911 5
		/obj/item/gun/ballistic/automatic/autopipe/special = 10,        //456 18
		/obj/item/gun/ballistic/automatic/smg/m22 = 10,                 //428 32
		/obj/item/gun/ballistic/automatic/pistol/goldendeag = 5,        //426 7
		/obj/item/gun/ballistic/automatic/fastlmg = 4,                  //416 60
		/obj/item/gun/ballistic/automatic/bozar = 10,                   //361 20
		/obj/item/gun/ballistic/automatic/smg/greasegun = 10,           //360 30
		/obj/item/gun/ballistic/automatic/m41br = 10,                   //341 10
		/obj/item/gun/ballistic/automatic/smg/vss = 10,                 //340 30
		/obj/item/gun/ballistic/automatic/assault_carbine/worn = 10,    //333 30
		/obj/item/gun/ballistic/automatic/g11 = 10,                     //317 50
		/obj/item/gun/ballistic/minigunbal5mm = 5,                      //314 480
		/obj/item/gun/ballistic/automatic/smg/cg45 = 10,                //312 36
		/obj/item/gun/ballistic/automatic/p47 = 10,                     //311 10
		/obj/item/minigunpackbal5mm = 2,
		/obj/item/minigunpack = 2,
		/obj/item/gun/ballistic/fatman = 0.5,
	)

////////////////////
///cowboy weapons///		ensures we gett plenty of stylish guns and bows
////////////////////

///DPS <= 120
/obj/effect/spawner/lootdrop/f13/common_cowboy
	name = "common classic guns" // basically WW2 and earlier
	loot = list(                                                                  //DPS Mag Capacity
		/obj/item/gun/ballistic/automatic/gewehr41civ = 10,                       //120 15
		/obj/item/gun/ballistic/revolver/revolver45 = 10,                         //119 7
		/obj/item/gun/ballistic/automatic/gewehr43 = 10,                          //114 10
		/obj/item/gun/ballistic/revolver/m2405 = 10,                              //114 10
		/obj/item/gun/ballistic/rifle/repeater/ranger = 10,                       //114 7
		/obj/item/gun/ballistic/shotgun/trench = 10,                              //113 5
		/obj/item/gun/ballistic/shotgun/hunting = 10,                             //113 4
		/obj/item/gun/ballistic/rifle/hunting = 9,                                //110 2
		/obj/item/gun/ballistic/rifle/hunting/paciencia = 1,                      //110 2
		/obj/item/gun/ballistic/rifle/repeater/trail = 10,                        //106 12
		/obj/item/gun/ballistic/automatic/m1garand/sks = 10,                      //104 8
		/obj/item/gun/ballistic/rifle/mag/boys = 10,                              //102 5
		/obj/item/gun/ballistic/rifle/repeater/cowboy = 10,                       //100 12
		/obj/item/gun/ballistic/revolver/Lemat = 10,                              //97 9
		/obj/item/gun/ballistic/revolver/m29 = 10,                                //97 6
		/obj/item/gun/ballistic/revolver/m29/alt = 10,                            //97 6
		/obj/item/gun/ballistic/revolver/m29/snub = 10,                           //87 6
		/obj/item/gun/ballistic/rifle/antique/gras = 10,                          //85 1
		/obj/item/gun/ballistic/rifle/repeater/volcanic = 10,                     //81 5
		/obj/item/gun/ballistic/rifle/mosin = 10,                                 //69 5
		/obj/item/gun/ballistic/revolver/hunting = 10,                            //68 6
		/obj/item/gun/ballistic/rifle/enfield = 10,                               //60 10
		/obj/item/gun/ballistic/revolver/revolver44 = 10,                         //56 6
		/obj/item/gun/ballistic/bow/longbow = 10,                                 //45 1 oof
	)

///DPS <= 200
/obj/effect/spawner/lootdrop/f13/uncommon_cowboy
	name = "uncommon classic guns" // basically WW2 and earlier
	loot = list(                                                                  //DPS Mag Capacity
		/obj/item/gun/ballistic/revolver/buntline = 10,                           //194 6
		/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,                    //189 2
		/obj/item/gun/ballistic/revolver/colt357 = 9,                             //183 6
		/obj/item/gun/ballistic/revolver/colt357/lucky = 1,                       //183 6
		/obj/item/gun/ballistic/automatic/m1carbine/m2 = 10,                      //179 24
		/obj/item/gun/ballistic/revolver/police = 10,                             //165 6
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93 = 10,                //156 10
		/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger = 10,          //156 10
		/obj/item/gun/ballistic/automatic/ww1selfloader = 10,                     //152 4
		/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp40 = 10,                 //151 32
		/obj/item/gun/ballistic/automatic/c96auto = 10,                           //151 20
		/obj/item/gun/ballistic/automatic/smg/greasegun/worn = 10,                //150 30
		/obj/item/gun/ballistic/rifle/repeater/brush = 10,                        //142 10
		/obj/item/gun/ballistic/revolver/sequoia = 10,                            //142 6
		/obj/item/gun/ballistic/automatic/pistol/type17 = 10,                     //140 12
		/obj/item/gun/ballistic/automatic/delisle/commando = 4,                   //138 12
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 10,                      //138 8
		/obj/item/gun/ballistic/automatic/m1garand/oldglory = 1,                  //138 8
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 10,                    //126 15
		/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby = 10,               //126 10
		/obj/item/gun/ballistic/automatic/m1garand = 10,                          //124 8

		//other
		/obj/item/m2flamethrowertank = 5,                                         //who knows
		/obj/item/gun/ballistic/bow/modern = 5,                                   //83 (With bane) 1
	)

/// DPS >200 or equally as good
/obj/effect/spawner/lootdrop/f13/rare_cowboy
	name = "rare classic guns" // basically WW2 and earlier
	loot = list(                                                                  //DPS Mag Capacity
		/obj/item/gun/ballistic/revolver/police/webley = 10,                      //329 6
		/obj/item/gun/ballistic/revolver/colt357/auto = 10,                       //329 6
		/obj/item/gun/ballistic/revolver/widowmaker = 10,                         //283 2
		/obj/item/gun/ballistic/automatic/smg/ppsh = 10,                          //252 71
		/obj/item/gun/ballistic/automatic/smg/tommygun = 10,                      //240 20
		/obj/item/gun/ballistic/revolver/detective = 10,                          //225 6
		/obj/item/gun/ballistic/automatic/bar = 10,                               //207 20
		/obj/item/gun/ballistic/bow/compoundbow = 5,                              //218 (With bane) 1
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 5,        //213 5
		/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock = 5,  //213 5
		/obj/item/gun/ballistic/revolver/thatgun = 10,                            //207 5
		/obj/item/gun/ballistic/automatic/lewis/lanoe = 10,                       //186 97
		/obj/item/gun/ballistic/automatic/lewis = 10,                             //186 47
		/obj/item/gun/ballistic/automatic/lewis/dp27 = 10,							//186 47
	)

////////////////////////////
///energy weapon spawners///
////////////////////////////


/// Note: Energy guns are weird. Please try and consider unique features (self recharging, shots per battery, Plasma/EMP, etc) along with DPS.
/// DPS should be 100 or less ish
/// If it's on the higher or lower side, it should have another stat lowered or raised such as magazine capacity.
/obj/effect/spawner/lootdrop/f13/common_energy
	name = "common energy"
	loot = list(

		/obj/item/gun/energy/laser/cranklasergun/tg/carbine = 10,         //100 25 internal cell
		/obj/item/gun/energy/laser/cranklasergun/tg/pistol = 10,  //60  20 internal cell
		/obj/item/gun/energy/laser/pistol = 10,             //80  25
		/obj/item/gun/energy/laser/aer9 = 10,               //80  20
		/obj/item/gun/energy/laser/cranklasergun/tg/spamlaser = 10,		//67  125 internal cell
		/obj/item/gun/energy/laser/cranklasergun/tg/spamlaser/shock = 10, //100 60 internal cell, slower crank


		// Better in some way (self charge, plasma, more efficient)
		/obj/item/gun/energy/laser/plasma/pistol = 8,      //88 10 plasma
		/obj/item/gun/energy/laser/plasma = 8,             //80 12 plasma
		/obj/item/gun/energy/laser/aer12 = 8,              //90 20 efficient
		/obj/item/gun/energy/laser/wattzs = 8,             //83 30 efficient
		/obj/item/gun/energy/gammagun = 8,                 //62 25 rad damage
	)

/// DPS should be <= 150 ish
/obj/effect/spawner/lootdrop/f13/uncommon_energy
	name = "uncommon energy"
	loot = list(
		/obj/item/gun/energy/laser/plasma/scatter = 10,             //140 10
		/obj/item/gun/energy/laser/wattz = 10,                      //130 12
		/obj/item/gun/energy/laser/laer = 10,                       //113 16 high RNG
		/obj/item/gun/energy/ionrifle = 10,                         //107 15 EMP
		/obj/item/gun/energy/ionrifle/carbine = 10,                 //107 12 EMP
		/obj/item/gun/energy/ionrifle/compact = 10,                 //107 10 EMP
		/obj/item/gun/energy/laser/aer14 = 10,                      //105 25
		/obj/item/gun/energy/laser/wattz2k/extended = 10,           //100 16
		/obj/item/gun/energy/laser/scatter = 10,                    //100 10
		/obj/item/gun/energy/laser/retro = 10,                      //100 8  high damage
		/obj/item/gun/energy/laser/ultra_rifle = 10,                //80  40 very rare ammo
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle = 10,     //150 40 internal cell

		// Better in some way (self charge, plasma, more efficient)
		/obj/item/gun/energy/laser/wattz2k = 8,                    //130 12 efficient
		/obj/item/gun/energy/laser/wattz/magneto = 8,              //87  16 efficient
		/obj/item/gun/energy/laser/wattz2ks = 1,                   //113 25 AP, self recharge
		/obj/item/gun/energy/laser/wattz/recharger = 5,            //83  20 recharger pistol, has fast recharge
		/obj/item/gun/energy/laser/tg/recharger/nuclear/rifle = 8, //100 24 self recharge, EMP weakness, rad damage
		/obj/item/gun/energy/laser/tg/recharger/nuclear = 10,      //100 16 self recharge, EMP weakness, rad damage
		/obj/item/gun/energy/laser/tg/recharger = 7,               //100 16 self recharge
	//	/obj/item/gun/energy/laser/LaserAK/worn = 8,               //133 30 self recharge
		/obj/item/gun/energy/laser/solar = 8,                      //90  16 self recharge
		/obj/item/gun/energy/laser/plasma/bouncy = 1,              //93  20 plasma, bouncy shots

		//others
		/obj/item/gun/energy/laser/complianceregulator = 5,         //330(690) 16 nonlethal

		//magic
		/obj/item/gun/magic/wand/kelpmagic/firebolt = 2,
		/obj/item/gun/magic/wand/kelpmagic/healwand = 2,
		/obj/item/gun/magic/wand/kelpmagic/magicmissile/improved = 2,
		/obj/item/gun/magic/wand/kelpmagic/sparky = 2,
		/obj/item/gun/magic/staff/kelpmagic/acidstaff = 2,
	)
//dps <= 200 ish
/obj/effect/spawner/lootdrop/f13/rare_energy
	name = "rare energy"
	loot = list(                                                    //dps magcap
		/obj/item/gun/energy/laser/scatter/laserbuss = 5,           //213 2
		/obj/item/gun/energy/laser/auto = 10,                       //200 60
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle/heavy = 10,             //80  24 internal cell
		/obj/item/gun/energy/laser/rcw = 10,                        //190 50
		/obj/item/gun/energy/laser/badlands = 10,                   //167 16
		/obj/item/gun/energy/laser/auto/twin = 10,                  //37.5 30 DPS tool says it's low but I think it struggles with burst fire. Similar in power to tesla autoshock
		/obj/item/gun/energy/laser/scatter/nonlethal = 10,					//132(276) 20 insane for pve wtf, nonlethal damage only so it's here

		//sidearms
		/obj/item/gun/energy/laser/plasma/pistol/eve = 8,           //150 10 plasma
		/obj/item/gun/energy/laser/plasma/pistol/adam = 8,          //138 8  plasma

		// Better in some way (self charge, plasma, more efficient)
		/obj/item/gun/energy/kinetic_accelerator/crossbow = 5,     //100 1 self charge, EMP immune
	//	/obj/item/gun/energy/laser/LaserAK = 5,                    //200 30 self charge

		//magic
		/obj/item/gun/magic/staff/kelpmagic/fireball = 2,
		/obj/item/gun/magic/staff/kelpmagic/lightning = 2,
		/obj/item/gun/magic/staff/kelpmagic/healstaff = 2,
	)

/// DPS should be >200
/obj/effect/spawner/lootdrop/f13/very_rare_energy
	name = "very rare energy"
	loot = list(
		/obj/item/gun/energy/laser/tg/particlecannon = 5,					//133 (~300) 5, have to use a Weapon Recharger
		/obj/item/gun/energy/laser/auto/oasis = 10,							//266 50 low damage per shot, deals plasma damage
		/obj/item/gun/energy/laser/cranklasergun/tg/rifle/auto = 10,		//200 60 internal cell
		/obj/item/gun/energy/kinetic_accelerator/crossbow/large = 50,		//200 1 self charge, EMP immune
		/obj/item/gun/energy/laser/plasma/pistol/alien = 10,				//225 4
		/obj/item/gun/medbeam/magic = 10,									//000 inf medbeam
		/obj/item/minigunpack = 5,											//??? 200 Note: the laser gatling actually isn't working with the DPS tool, but it's 15 damage at 600 RPM. Once in a blue moon this will make someone's day.
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
		/obj/item/melee/onehanded/machete/gladius = 1,
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
		/obj/item/melee/transforming/plasmacutter/sword/cx/broken = 10,
		/obj/item/melee/onehanded/machete/spatha = 10,
		/obj/item/melee/unarmed/tigerclaw = 10,
		/obj/item/melee/unarmed/lacerator = 10,
		/obj/item/melee/unarmed/maceglove = 10,
		/obj/item/melee/unarmed/punchdagger = 10,
		/obj/item/twohanded/baseball/louisville = 10,
		/obj/item/melee/onehanded/knife/trench = 10,
		/obj/item/melee/transforming/plasmacutter/sword/cx = 4,
	)

/obj/effect/spawner/lootdrop/f13/rare_melee
	name = "rare melee"
	loot = list(
		/obj/item/gun/ballistic/revolver/ballisticfist = 10,
		/obj/item/melee/powered/ripper = 10,
		/obj/item/twohanded/legionaxe = 10,
		/obj/item/melee/transforming/energy/axe/protonaxe = 10,
		/obj/item/melee/unarmed/powerfist = 10,
		/obj/item/twohanded/sledgehammer/supersledge = 10,
		/obj/item/twohanded/sledgehammer/rockethammer = 10,
		/obj/item/twohanded/thermic_lance = 10,
		// /obj/item/melee/transforming/plasmacutter/sword = 5, // Commenting it out until its sprite is fixed.

		//uniques
		/obj/item/melee/powerfist/f13/satfist = 5,
		/obj/item/melee/unarmed/powerfist/goliath = 5,
		/obj/item/melee/onehanded/dragonfire = 5, //edgy
		/obj/item/melee/powered/ripper/prewar = 5,
		/obj/item/twohanded/spear/bonespear/aethergiest = 5, //sure why not
		/obj/item/melee/unarmed/aethergiestgauntlet = 5,
		/obj/item/book/granter/martial/bass = 5,
		/obj/item/melee/transforming/plasmacutter/regular/adam = 5,
		/obj/item/twohanded/sledgehammer/atomsjudgement = 5,
		/obj/item/dualsaber/hypereutactic = 5,
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
		/obj/item/gun/ballistic/rifle/mag/antimaterial = 1,
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
		/obj/item/reagent_containers/pill/bitterdrink = 10,
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
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 4,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 1,
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
		/obj/item/reagent_containers/pill/patch/medx = 1,
		/obj/item/reagent_containers/pill/patch/steady = 1,
		/obj/item/reagent_containers/pill/patch/psycho = 1,
		/obj/item/storage/pill_bottle/chem_tin/mentats = 1,
	)

/obj/effect/spawner/lootdrop/f13/uncommon_drugs
	name = "uncommon drugs"
	loot = list(
		/obj/item/storage/pill_bottle/chem_tin/radx = 10,
		/obj/item/reagent_containers/pill/patch/jet = 10,
		/obj/item/reagent_containers/pill/patch/medx = 4,
		/obj/item/reagent_containers/pill/patch/steady = 4,
		/obj/item/reagent_containers/pill/patch/psycho = 4,
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
		/obj/item/reagent_containers/pill/patch/medx = 4,
		/obj/item/reagent_containers/pill/patch/steady = 4,
		/obj/item/reagent_containers/pill/patch/psycho = 4,
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
		/obj/effect/spawner/bundle/f13/armor/t45b_salvaged = 20,
		/obj/item/clothing/suit/armor/heavy/riot/vault = 20,
		/obj/item/clothing/suit/armor/heavy/riot/marine = 20,
		/obj/item/clothing/suit/armor/medium/odst = 2,
		/obj/effect/spawner/bundle/f13/armor/hotrodpa = 2,
		/obj/effect/spawner/bundle/f13/armor/t45d = 1,
		/obj/item/clothing/suit/armor/medium/odstlead = 1,
		/obj/effect/spawner/bundle/f13/armor/t51b = 1,
		/obj/item/clothing/suit/armor/power_armor/t51b/pony = 1,
		/obj/effect/spawner/lootdrop/f13/uncommon_armor = 20
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

/////////////////////////////////////////
///(legacy) weapon attachment spawners///
/////////////////////////////////////////
/*
/obj/effect/spawner/lootdrop/f13/trash_mods
	name = "trash attachments"
	loot = list(
		/obj/item/tool_upgrade/paint/red = 1,
		/obj/item/tool_upgrade/paint/blue = 1,
		/obj/item/tool_upgrade/paint/yellow = 1,
		/obj/item/tool_upgrade/refinement/laserguide = 1,
		/obj/item/tool_upgrade/reinforcement/heatsink = 1,
		/obj/item/gun_upgrade/trigger/raidertrigger = 1,
//		/obj/item/gun_upgrade/cosmetic/gold = 1,
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
		/obj/item/gun_upgrade/barrel/better = 1,
		/obj/item/tool_upgrade/reinforcement/guard = 1,
		/obj/item/tool_upgrade/refinement/ported_barrel = 1,
	)


/obj/effect/spawner/lootdrop/f13/rare_mods
	name = "rare attachments"
	loot = list(
		/obj/item/gun_upgrade/barrel/blender = 1,
		/obj/item/gun_upgrade/trigger/better = 1,
		/obj/item/gun_upgrade/muzzle/better = 1,
		/obj/item/gun_upgrade/scope/better = 1,
		/obj/item/gun_upgrade/mechanism/battery_shunt = 1,
		/obj/item/tool_upgrade/augment/ai_tool = 1,
	)
*/
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
		/obj/item/crowbar/crude = 1,
		/obj/item/wrench/crude = 1,
		/obj/item/screwdriver/crude = 1,
		/obj/item/weldingtool/crude = 1,
		/obj/item/wirecutters/crude = 1,
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
		/obj/item/storage/fancy/flare_pouch = 1,
		/obj/item/storage/fancy/flare_pouch/glowstick = 1,
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
		/obj/item/flashlight/blue = 1,
		/obj/item/flashlight/lantern/mining = 1,
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
		/obj/item/flashlight/lantern = 1,
		/obj/item/weldingtool/hightech = 1,
		/obj/item/crowbar/hightech = 1,
		/obj/item/crowbar/hightech = 1,
		/obj/item/screwdriver/hightech = 1,
		/obj/item/screwdriver/hightech = 1,
		/obj/item/wrench/hightech = 1,
		/obj/item/wrench/hightech = 1,
		/obj/item/wirecutters/hightech = 1,
		/obj/item/wirecutters/hightech = 1,
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
		/obj/item/reagent_containers/food/snacks/f13/aethergiestegg = 1,
		/obj/item/reagent_containers/food/snacks/f13/molejerky = 1,
		/obj/item/reagent_containers/food/snacks/f13/caravanlunch = 1,
		/obj/item/reagent_containers/food/snacks/f13/aethergiestomelette = 1,
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
		/obj/effect/spawner/bundle/mobs/rat/actually_a_aethergiest = 1, //because yes...until someone cries and says no~
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

/////////////////////
///clothes spawner/// Totally not vending machine item lists smashed together
/////////////////////

/obj/effect/spawner/lootdrop/f13/clothes
	name = "clothes"
	loot = list(
		/obj/effect/spawner/lootdrop/gloves = 8,
		/obj/item/clothing/head/that = 4,
		/obj/item/clothing/head/fedora = 3,
		/obj/item/clothing/head/beret = 3,
		/obj/item/clothing/head/beret/black = 3,
		/obj/item/clothing/head/beret/purple = 3,
		/obj/item/clothing/head/beret/blue = 3,
		/obj/item/clothing/glasses/monocle = 3,
		/obj/item/clothing/suit/jacket = 4,
		/obj/item/clothing/suit/jacket/flannel = 4,
		/obj/item/clothing/suit/jacket/flannel/red = 4,
		/obj/item/clothing/suit/jacket/flannel/aqua = 4,
		/obj/item/clothing/suit/jacket/flannel/brown = 4,
		/obj/item/clothing/suit/jacket/puffer/vest = 4,
		/obj/item/clothing/suit/jacket/puffer = 4,
		/obj/item/clothing/suit/armor/outfit/overalls/sexymaid = 5,
		/obj/item/clothing/suit/hooded/cloak/david = 4,
		/obj/item/clothing/suit/bomber = 5,
		/obj/item/clothing/under/suit/turtle/teal = 3,
		/obj/item/clothing/under/suit/turtle/grey = 3,
		/obj/item/clothing/under/rank/civilian/util = 5,
		/obj/item/clothing/under/rank/civilian/util/greyshirt = 5,
		/obj/item/clothing/under/suit/navy = 3,
		/obj/item/clothing/under/suit/black_really = 3,
		/obj/item/clothing/under/suit/burgundy = 3,
		/obj/item/clothing/under/suit/charcoal = 3,
		/obj/item/clothing/under/suit/white = 3,
		/obj/item/clothing/under/costume/kilt = 3,
		/obj/item/clothing/under/misc/overalls = 3,
		/obj/item/clothing/under/suit/sl = 3,
		/obj/item/clothing/under/sweater = 3,
		/obj/item/clothing/under/sweater/black = 3,
		/obj/item/clothing/under/sweater/purple = 3,
		/obj/item/clothing/under/sweater/green = 3,
		/obj/item/clothing/under/sweater/red = 3,
		/obj/item/clothing/under/sweater/blue = 3,
		/obj/item/clothing/under/pants/jeans = 5,
		/obj/item/clothing/under/pants/classicjeans = 5,
		/obj/item/clothing/under/pants/camo = 3,
		/obj/item/clothing/under/pants/blackjeans = 5,
		/obj/item/clothing/under/pants/khaki = 5,
		/obj/item/clothing/under/pants/white = 5,
		/obj/item/clothing/under/pants/red = 3,
		/obj/item/clothing/under/pants/black = 4,
		/obj/item/clothing/under/pants/tan = 4,
		/obj/item/clothing/under/pants/track = 3,
		/obj/item/clothing/under/shorts/jeanbshorts = 3,
		/obj/item/clothing/under/shorts/darkbshorts = 3,
		/obj/item/clothing/under/shorts/blackbshorts = 3,
		/obj/item/clothing/under/shorts/brownbshorts = 3,
		/obj/item/clothing/suit/jacket/miljacket = 5,
		/obj/item/clothing/under/suit/white_on_white/skirt = 2,
		/obj/item/clothing/under/rank/captain/suit/skirt = 2,
		/obj/item/clothing/under/rank/civilian/head_of_personnel/suit/skirt = 2,
		/obj/item/clothing/neck/tie/blue = 3,
		/obj/item/clothing/neck/tie/red = 3,
		/obj/item/clothing/neck/tie/black = 3,
		/obj/item/clothing/neck/tie/horrible = 5,
		/obj/item/clothing/neck/scarf/pink = 3,
		/obj/item/clothing/neck/scarf/red = 3,
		/obj/item/clothing/neck/scarf/green = 3,
		/obj/item/clothing/neck/scarf/darkblue = 3,
		/obj/item/clothing/neck/scarf/purple = 3,
		/obj/item/clothing/neck/scarf/yellow = 3,
		/obj/item/clothing/neck/scarf/orange = 3,
		/obj/item/clothing/neck/scarf/cyan = 3,
		/obj/item/clothing/neck/scarf = 3,
		/obj/item/clothing/neck/scarf/black = 3,
		/obj/item/clothing/neck/scarf/zebra = 3,
		/obj/item/clothing/neck/scarf/christmas = 3,
		/obj/item/clothing/neck/stripedredscarf = 3,
		/obj/item/clothing/neck/stripedbluescarf = 3,
		/obj/item/clothing/neck/stripedgreenscarf = 3,
		/obj/item/clothing/accessory/waistcoat = 2,
		/obj/item/clothing/under/dress/skirt = 3,
		/obj/item/clothing/under/dress/skirt/blue = 3,
		/obj/item/clothing/under/dress/skirt/red = 3,
		/obj/item/clothing/under/dress/skirt/purple = 3,
		/obj/item/clothing/under/dress/sundress = 4,
		/obj/item/clothing/under/dress/sundress/white = 4,
		/obj/item/clothing/under/dress/striped = 3,
		/obj/item/clothing/under/dress/sailor = 3,
		/obj/item/clothing/under/dress/skirt/swept = 3,
		/obj/item/clothing/under/dress/green = 3,
		/obj/item/clothing/under/dress/pink = 3,
		/obj/item/clothing/under/dress/redeveninggown = 3,
		/obj/item/clothing/under/dress/blacktango = 3,
		/obj/item/clothing/under/dress/westernbustle = 3,
		/obj/item/clothing/under/dress/flamenco = 3,
		/obj/item/clothing/under/dress/flower = 3,
		/obj/item/clothing/under/dress/skirt/plaid = 3,
		/obj/item/clothing/under/dress/skirt/plaid/blue = 3,
		/obj/item/clothing/under/dress/skirt/plaid/purple = 3,
		/obj/item/clothing/under/dress/skirt/plaid/green = 3,
		/obj/item/clothing/under/croptop = 3,
		/obj/item/clothing/glasses/regular = 2,
		/obj/item/clothing/glasses/regular/jamjar = 2,
		/obj/item/clothing/head/sombrero = 3,
		/obj/item/clothing/neck/mantle/poncho = 3,
		/obj/item/clothing/suit/ianshirt = 3,
		/obj/item/clothing/shoes/laceup = 5,
		/obj/item/clothing/shoes/sneakers/black = 6,
		/obj/item/clothing/shoes/wraps = 3,
		/obj/item/clothing/shoes/wraps/silver = 3,
		/obj/item/clothing/shoes/wraps/red = 3,
		/obj/item/clothing/shoes/wraps/blue = 3,
		/obj/item/clothing/shoes/sandal = 3,
		/obj/item/clothing/gloves/fingerless = 3,
		/obj/item/clothing/glasses/orange = 5,
		/obj/item/clothing/glasses/red = 5,
		/obj/item/storage/belt/fannypack = 3,
		/obj/item/clothing/suit/jacket/letterman = 5,
		/obj/item/clothing/head/beanie = 3,
		/obj/item/clothing/head/beanie/black = 3,
		/obj/item/clothing/head/beanie/red = 3,
		/obj/item/clothing/head/beanie/green = 3,
		/obj/item/clothing/head/beanie/darkblue = 3,
		/obj/item/clothing/head/beanie/purple = 3,
		/obj/item/clothing/head/beanie/yellow = 3,
		/obj/item/clothing/head/beanie/orange = 3,
		/obj/item/clothing/head/beanie/cyan = 3,
		/obj/item/clothing/head/beanie/christmas = 3,
		/obj/item/clothing/head/beanie/striped = 3,
		/obj/item/clothing/head/beanie/stripedred = 3,
		/obj/item/clothing/head/beanie/stripedblue = 3,
		/obj/item/clothing/head/beanie/stripedgreen = 3,
		/obj/item/clothing/suit/jacket/letterman_red = 3,
		/obj/item/clothing/ears/headphones = 10,
		/obj/item/clothing/neck/apron/bartender = 4,
		/obj/item/clothing/under/rank/civilian/bartender/purple = 4,
		/obj/item/clothing/under/costume/christmas = 3,
		/obj/item/clothing/under/costume/christmas/green = 3,
		/obj/item/clothing/under/costume/christmas/croptop = 3,
		/obj/item/clothing/under/costume/christmas/croptop/green = 3,
		/obj/item/clothing/suit/hooded/wintercoat/christmascoatr = 3,
		/obj/item/clothing/suit/hooded/wintercoat/christmascoatg = 3,
		/obj/item/clothing/suit/hooded/wintercoat/christmascoatrg = 3,
		/obj/item/clothing/head/christmashat = 3,
		/obj/item/clothing/head/christmashatg = 3,
		/obj/item/clothing/shoes/winterboots/christmasbootsr = 3,
		/obj/item/clothing/shoes/winterboots/christmasbootsg = 3,
		/obj/item/clothing/shoes/winterboots/santaboots = 3,
		/obj/item/clothing/head/cowboyhat = 3,
		/obj/item/clothing/head/cowboyhat/black = 3,
		/obj/item/clothing/head/cowboyhat/white = 3,
		/obj/item/clothing/head/cowboyhat/pink = 3,
		/obj/item/clothing/shoes/cowboyboots = 3,
		/obj/item/clothing/shoes/cowboyboots/black = 3,
		/obj/item/clothing/under/costume/qipao = 3,
		/obj/item/clothing/under/costume/qipao/white = 3,
		/obj/item/clothing/under/costume/qipao/red = 3,
		/obj/item/clothing/under/costume/cheongsam = 3,
		/obj/item/clothing/under/costume/cheongsam/white = 3,
		/obj/item/clothing/under/costume/cheongsam/red = 3,
		/obj/item/clothing/suit/chickensuit = 1,
		/obj/item/clothing/head/chicken = 1,
		/obj/item/clothing/under/costume/gladiator = 1,
		/obj/item/clothing/head/helmet/gladiator = 1,
		/obj/item/clothing/under/rank/captain/suit = 1,
		/obj/item/clothing/head/flatcap = 1,
		/obj/item/clothing/suit/toggle/labcoat/mad = 1,
		/obj/item/clothing/shoes/jackboots = 1,
		/obj/item/clothing/under/costume/schoolgirl = 1,
		/obj/item/clothing/under/costume/schoolgirl/red = 1,
		/obj/item/clothing/under/costume/schoolgirl/green = 1,
		/obj/item/clothing/under/costume/schoolgirl/orange = 1,
		/obj/item/clothing/head/simplekitty = 1,
		/obj/item/clothing/under/dress/skirt = 1,
		/obj/item/clothing/head/beret = 1,
		/obj/item/clothing/accessory/waistcoat = 1,
		/obj/item/clothing/under/suit/black = 1,
		/obj/item/clothing/head/that = 1,
		/obj/item/clothing/under/costume/kilt = 1,
		/obj/item/clothing/head/beret = 1,
		/obj/item/clothing/accessory/waistcoat = 1,
		/obj/item/clothing/glasses/monocle =1,
		/obj/item/clothing/head/bowler = 1,
		/obj/item/cane = 1,
		/obj/item/clothing/under/rank/civilian/victorian_redsleeves = 1,
		/obj/item/clothing/under/rank/civilian/victorian_redvest = 1,
		/obj/item/clothing/under/rank/civilian/victorian_vest = 1,
		/obj/item/clothing/under/rank/civilian/victorian_purple = 1,
		/obj/item/clothing/suit/tailcoat = 1,
		/obj/item/clothing/under/rank/civilian/victorianreddress = 1,
		/obj/item/clothing/suit/vickyred = 1,
		/obj/item/clothing/under/rank/civilian/victorianblackdress = 1,
		/obj/item/clothing/suit/vickyblack =1,
		/obj/item/clothing/under/rank/civilian/dutch = 2,
		/obj/item/clothing/under/suit/sl = 1,
		/obj/item/clothing/mask/fakemoustache = 1,
		/obj/item/clothing/suit/bio_suit/plaguedoctorsuit = 1,
		/obj/item/clothing/head/plaguedoctorhat = 1,
		/obj/item/clothing/mask/gas/plaguedoctor = 1,
		/obj/item/clothing/suit/toggle/owlwings = 1,
		/obj/item/clothing/under/costume/owl = 1,
		/obj/item/clothing/mask/gas/owl_mask = 1,
		/obj/item/clothing/suit/toggle/owlwings/griffinwings = 1,
		/obj/item/clothing/under/costume/griffin = 1,
		/obj/item/clothing/shoes/griffin = 1,
		/obj/item/clothing/head/griffin = 1,
		/obj/item/clothing/neck/apron/labor = 1,
		/obj/item/clothing/under/suit/waiter = 1,
		/obj/item/clothing/suit/jacket/miljacket = 1,
		/obj/item/clothing/under/costume/pirate = 1,
		/obj/item/clothing/suit/pirate = 1,
		/obj/item/clothing/head/pirate = 1,
		/obj/item/clothing/head/bandana = 1,
		/obj/item/clothing/head/bandana = 1,
		/obj/item/clothing/under/costume/soviet = 1,
		/obj/item/clothing/head/ushanka = 1,
		/obj/item/clothing/suit/imperium_monk = 1,
		/obj/item/clothing/mask/gas/cyborg = 1,
		/obj/item/clothing/suit/chaplain/holidaypriest = 1,
		/obj/item/clothing/head/wizard/marisa/fake = 1,
		/obj/item/clothing/suit/wizrobe/marisa/fake = 1,
		/obj/item/clothing/under/dress/sundress = 1,
		/obj/item/clothing/head/witchwig = 1,
		/obj/item/staff/broom = 1,
		/obj/item/clothing/suit/wizrobe/fake = 1,
		/obj/item/clothing/head/wizard/fake = 1,
		/obj/item/staff = 3,
		/obj/item/clothing/under/rank/captain/suit/skirt = 1,
		/obj/item/clothing/mask/rat/bat = 1,
		/obj/item/clothing/mask/rat/bee = 1,
		/obj/item/clothing/mask/rat/bear = 1,
		/obj/item/clothing/mask/rat/raven = 1,
		/obj/item/clothing/mask/rat/jackal = 1,
		/obj/item/clothing/mask/rat/fox = 1,
		/obj/item/clothing/mask/frog = 1,
		/obj/item/clothing/mask/rat/tribal = 1,
		/obj/item/clothing/mask/rat = 1,
		/obj/item/clothing/suit/armor/outfit/overalls/farmer = 1,
		/obj/item/clothing/head/rabbitears =1,
		/obj/item/clothing/head/sombrero = 1,
		/obj/item/clothing/head/sombrero/green = 1,
		/obj/item/clothing/neck/mantle/poncho = 1,
		/obj/item/clothing/suit/armor/outfit/overalls/sexymaid = 5,
		/obj/item/clothing/head/maid = 3,
		/obj/item/clothing/under/costume/maid = 3,
		/obj/item/clothing/under/janimaid = 3,
		/obj/item/clothing/under/rank/civilian/janitor/maid = 3,
		/obj/item/clothing/gloves/evening = 1,
		/obj/item/clothing/glasses/cold=1,
		/obj/item/clothing/glasses/heat=1,
		/obj/item/clothing/suit/whitedress = 1,
		/obj/item/clothing/under/costume/villain = 1,
		/obj/item/clothing/shoes/singery = 1,
		/obj/item/clothing/under/costume/singer/yellow = 1,
		/obj/item/clothing/shoes/singerb = 1,
		/obj/item/clothing/under/costume/singer/blue = 1,
		/obj/item/clothing/suit/hooded/carp_costume = 1,
		/obj/item/clothing/suit/snowman = 1,
		/obj/item/clothing/head/snowman = 1,
		/obj/item/clothing/mask/joy = 1,
		/obj/item/clothing/head/cueball = 1,
		/obj/item/clothing/under/suit/white_on_white = 1,
		/obj/item/clothing/under/costume/sailor = 1,
		/obj/item/clothing/ears/headphones = 2,
		/obj/item/clothing/head/wig/random = 3,
		/obj/item/clothing/suit/ran = 2,
		/obj/item/clothing/head/ran = 2,
		/obj/item/clothing/suit/pirate/captain = 2,
		/obj/item/clothing/head/pirate/captain = 2,
		/obj/item/clothing/under/costume/lobster = 1,
		/obj/item/clothing/head/lobsterhat = 1,
		/obj/item/clothing/head/drfreezehat = 1,
		/obj/item/clothing/suit/dracula = 1,
		/obj/item/clothing/suit/drfreeze_coat = 1,
		/obj/item/clothing/suit/gothcoat = 2,
		/obj/item/clothing/under/costume/draculass = 1,
		/obj/item/clothing/under/costume/drfreeze = 1,
		)

/obj/effect/spawner/lootdrop/f13/electrical
	name = "electrical appliance loot"
	loot = list(
	/obj/item/stack/cable_coil/random/five = 5,
	/obj/item/radio/off = 5,
	/obj/item/assembly/infra = 3,
	/obj/item/assembly/igniter = 3,
	/obj/item/assembly/signaler = 3,
	/obj/item/stack/sheet/metal/five = 5,
	/obj/item/stack/sheet/glass/five = 5,
	/obj/item/stack/rods/ten = 5,
	/obj/item/stack/crafting/metalparts = 2,
	/obj/item/stack/crafting/goodparts = 2,
	/obj/item/stack/crafting/electronicparts/five = 10,
	)
