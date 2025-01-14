// Put tier respective guns (and loadout options) here. Ammo goes in their respective files somewhere around modular_coyote/code/modules/znuguns/code/ammo .

/obj/item/gun/ballistic/automatic/pistol/ninemil
	name = "Hi Power 9mm"
	desc = "A mass produced pre-fall 9mm pistol."
	icon_state = "ninemil"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion
	name = "Skorpion"
	desc = "A machine pistol. In 9mm."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "skorpion"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby
	name = "ruby"
	desc = "A post-cataclysm petite pocket pistol copied after the pre-cataclysm design of the same name."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "ruby"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)
	weapon_class = WEAPON_CLASS_TINY

/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov
	name = "makarov"
	desc = "An easy to conceal pistol chambered in 9mm."
	icon_state = "makarov"
	inhand_icon_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	weapon_class = WEAPON_CLASS_SMALL

/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger
	name = "luger"
	desc = "A foreign 9mm pistol."
	icon_state = "p08"
	inhand_icon_state = "p38"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/automatic/pistol/ninemil/glock
	name = "glock"
	desc = "Chambered in 9mm, this is a versatile compact pistol. It fits comfortably in the hand or a chest rig, and its solid design lets it survive mud, sand, and sometimes even peanut butter."
	icon_state = "glock"
	inhand_icon_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/type17
	name = "broomhandle"
	desc = "The ones around are old and worn, but somewhat popular due to the long barrel and rechambered in 9mm after the original ammo ran dry centuries ago."
	icon_state = "chinapistol"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm 
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(0.6, 0.6)

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE

	damage_multiplier = TIER1

/obj/item/gun/ballistic/revolver/revolver45
	name = ".45 Single Action"
	desc = "Post-fall revolver firing .45 ACP from a seven round cylinder."
	inhand_icon_state = "45revolver"
	icon_state = "45revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	fire_sound = 'sound/f13weapons/45revolver.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/revolver/colt357
	name = "Single Action Army"
	desc = "A no-nonsense revolver, more than likely made in some crude workshop in one of the more prosperous frontier towns."
	icon_state = "357colt"
	inhand_icon_state = "357colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/357magnum.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/revolver/revolver44
	name = ".44 Single Action"
	desc = "A fairly large post-fall revolver chambered in .44, chunky."
	inhand_icon_state = "44colt"
	icon_state = "44colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1, 0.8)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	fire_sound = 'sound/f13weapons/44revolver.ogg'

/obj/item/gun/ballistic/revolver/buntline
	name = "Colt Buntline"
	desc = "A revolver carbine. The revolver itself is the same as any other single action, albeit it has an elongated barrel and attachable stock. For when you wanna hit the cowpokes from afar."
	icon_state = "coltcarbine"
	inhand_icon_state = "coltcarbine"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = SMG_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = FALSE
	can_bayonet = FALSE

/obj/item/gun/ballistic/revolver/derringerLC
	name = "derringer"
	desc = "A classy, pearl handled pistol firing .45 in a very compact package."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "remington_95_ivory"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45/two
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/smg/cg45
	name = "open bolt smg"
	desc = "Post-cataclysm submachine gun crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop."
	icon_state = "cg45"
	inhand_icon_state = "cg45"
	mag_type = /obj/item/ammo_box/magazine/cg45
	init_mag_type = null
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/obj/item/gun/ballistic/automatic/m1carbine
	name = "M1 Carbine"
	desc = "A design thought to have been used hundreds of years ago by a now long gone power. It's ubiquitous nature made it prime for post-fall gunsmiths to restore."
	icon_state = "m1carbine"
	inhand_icon_state = "rifle"
	mag_type = null
	init_mag_type = /obj/item/ammo_box/magazine/m1carbine
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE) //need to check what this do
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/obj/item/gun/ballistic/revolver/shotpistol
	name = "single shot shotgunpistol"
	desc = "Exactly one half of a hammer fired double barrel shotgun, stripped down and streamlined to fit snugly in someone's pocket."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotpistol"
	inhand_icon_state = "357colt"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/single
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed
	)

	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

/obj/item/gun/ballistic/revolver/widowmaker
	name = "double barrel shotgunned"
	desc = "A simple hammer fired double barrel shotgun."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "widowmaker"
	inhand_icon_state = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed,
	)
	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'
	damage_multiplier = TIER1

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock
	name = "lever shotgun"
	desc = "A speedy lever action shotgun with a five-shell capacity underneath plus one in chamber."
	icon_state = "lashotgunstocked"
	inhand_icon_state = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_SHOTGUN_FAST
	init_recoil = SHOTGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = FALSE

	damage_multiplier = TIER1

/obj/item/gun/ballistic/rifle/repeater/cowboy
	name = "Winchester Lever Action"
	desc = "A lever action rifle chambered in .357 Magnum. Smells vaguely of whiskey and cigarettes."
	icon_state = "cowboyrepeater"
	inhand_icon_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = CARBINE_RECOIL(1, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/rifle/antique/gras
	name = "Gras rifle"
	desc = "A post-catacylsm copy of an old black powder cartridge gun of foreign lineage. No one is sure where the name came from, but it stuck."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "gras"
	inhand_icon_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/gras
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 25
	cock_sound = 'sound/f13weapons/grasbolt.ogg'
	fire_sound = 'sound/f13weapons/gras.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	reskinnable_component = null

	damage_multiplier = TIER1

/obj/item/gun/ballistic/rifle/mag/boys
	name = "Boys anti tank rifle"
	desc = "A heavy rifle boasting a strong kick and an even stronger punch. This one probably won't even come apart from the excess pressures (hose clamps not included)!"
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "boys"
	inhand_icon_state = "boys"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = HMG_RECOIL(3, 3)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle
	name = "salvaged AK"
	desc = "A clever design adapted out of salvaged surplus eastern wyverns and wasteland scarcity. The magazine is welded to the frame and a port was added after."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "salvak"
	inhand_icon_state = "salvak"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1, 0.5)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/salvaged.ogg'
	can_scope = TRUE
	casing_ejector = TRUE

	damage_multiplier = TIER1

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "Colt 1911"
	desc = "A classic .45 handgun with a small magazine capacity."
	icon_state = "m1911"
	inhand_icon_state = "pistolchrome"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

	damage_multiplier = TIER1

/obj/item/gun/ballistic/bow/shortbow
	name = "Shortbow"
	desc = "A compact bow with a low draw weight. Easy to make, gets the job done. It can fit in your bag, however."
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "shortbow"
	inhand_icon_state = "bow" 
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	damage_multiplier = TIER1

/obj/item/gun/ballistic/revolver/hobo/knucklegun
	name = "knucklegun (.45)"
	desc = "When your knuckles don't cut it, put some brass on them. When that doesnt work? Weld on four slamfire barrels \"chambered\" \
		in .45 ACP, connect all those to a pressure plate on the strikeface, and try not to think about all the explosives you have \
		less than an inch from your fingers. Fires all four rounds at once, and if your hand still exists, delivers a solid punch too."
	icon_state = "knucklegun"
	inhand_icon_state = "knucklegun"
	slot_flags = INV_SLOTBIT_GLOVES
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised45
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = TIER1
	init_recoil = HANDGUN_RECOIL(1.6, 1.6)
	init_firemodes = list(
		/datum/firemode/burst/four/fastest/hobo
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS // very likely to explode, cept with 9mm and 38
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 10, 25, BRUTELOSS | FIRELOSS),
		GUN_MISFIRE_THROWS_GUN(5),
		GUN_MISFIRE_UNLOADS_GUN(25, 50)
	)

/obj/item/gun/ballistic/automatic/hobo/zipgun
	name = "Zip gun (9mm)"
	icon_state = "zipgun"
	desc = "A clever little makeshift pistol, one of the few easily-constructed firearms that accept more rounds than it has barrels. \
		Light, compact, and packing a surprising punch, the zip gun serves as a waster's insurance policy when doing business, \
		small enough to whip out of a coat when someone doesn't feel like paying for your raccoon pelts. \
		A brave, enterprising waster can stuff just about anything into the improvised clipazine, though anything more powerful \
		than a handloaded 9mm round will run the risk of voiding the warranty on your fingers."
	inhand_icon_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/zipgun
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = TIER1
	init_recoil = HANDGUN_RECOIL(2.1, 2.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(10, 5, 15, BRUTELOSS),
		GUN_MISFIRE_THROWS_GUN(5),
		GUN_MISFIRE_UNLOADS_GUN(3, 50)	
	)
	//fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/hobo/zipgun/update_icon_state()
	icon_state = "zipgun[magazine ? "-[CEILING(get_ammo(0)/1, 1)*1]" : ""][chambered ? "" : "-e"][silenced ? "-suppressed" : ""]"

	//fire_sound = 'sound/weapons/Gunshot.ogg'

///////////// LOADOUT EDIT VERSIONS /////////////

/obj/item/gun/ballistic/automatic/pistol/ninemil/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/ninemil/glock/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/type17/loadout 
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/revolver45/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/revolver/colt357/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/revolver44/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/buntline/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/derringerLC/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/cg45/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/m1carbine/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/shotpistol/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/widowmaker/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock/loadout
 	damage_multiplier = TIER0

/obj/item/gun/ballistic/rifle/repeater/cowboy/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/rifle/antique/gras/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/rifle/mag/boys/loadout
	damage_multiplier = TIER0
 
/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/pistol/m1911/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/bow/shortbow
	damage_multiplier = TIER0
