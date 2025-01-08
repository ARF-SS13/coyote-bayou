// Put tier respective guns (and loadout options) here. Ammo goes in their respective files somewhere around modular_coyote/code/modules/znuguns/code/ammo .

/obj/item/gun/ballistic/automatic/pistol/ninemil/rare99
	name = "Colt N104-D"
	desc = "A compact .45 pistol. A shorter version of a straightline. It is tiny compared to its bigger brothers and packs a punch."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "Warden10"
	inhand_icon_state = "glock"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list()
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_recoil = HANDGUN_RECOIL(1.5, 1.1)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "Beretta 9mm"
	desc = "One of the more common 9mm pistols, the Beretta is popular due to its reliability, 15 round magazine and good looks."
	icon_state = "beretta"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'

	reskinnable_component = null

	damage_multiplier = TIER2


/obj/item/gun/ballistic/automatic/autopipe
	name = "Auto-pipe rifle"
	desc = "The pride of wasteland engineering, a fully automatic, belt fed pipe machine gun. Despite looking like the scrap heap it was \
		made from, and its eagerness to fire before fully chambering, many wasters swear by its overwhelming firepower, capable of delivering \
		24 or so .357 magnum bullets into some unlucky beast before needing to reload. Not only does its loose receiver accept 9mm, .38 special, \
		and .357 magnum with ease, but it also can survive dozens of premature detonations without a scratch!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "autopipe"
	inhand_icon_state = "autopipe"
	mag_type = /obj/item/ammo_box/magazine/autopipe
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = TIER2
	init_recoil = RIFLE_RECOIL(2.7, 2.7)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three/slow,
		/datum/firemode/semi_auto
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	misfire_possibilities = list(
		GUN_MISFIRE_UNLOADS_GUN(3, 20),
	)
	// Gives a fairly low chance to misfire with anything short of .357 FMJ, or the special 9mm rounds.
	// Misfire chance is still low enough that you can run entire belts of .357 FMJ without issues occassionally.
	// .357 Handload outta the bags is fine aswell. it's a shitgun made by poors.
	// TODO: Find some way to make a blinding effect on misfire.

	//fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/autopipe/update_icon_state()
	icon_state = "autopipe[magazine ? "-[CEILING(get_ammo(0)/1, 6)*1]" : ""][chambered ? "" : "-e"][silenced ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/pistol/sig
	name = "Sig 9mm"
	desc = "A pistol that is compact and has an average rate of fire, but still in .45. Adopted by Park Rangers."
	icon_state = "newsig"
	inhand_icon_state = "gun"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1.1, 1.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "Desert Eagle"
	desc = "A .44 magnum semi-automatic handgun."
	icon_state = "deagle"
	inhand_icon_state = "deagle"
	init_mag_type = /obj/item/ammo_box/magazine/m44
	mag_type = /obj/item/ammo_box/magazine/m44 // load any .44 pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/revolver/police
	name = "Double Action Revoler"
	desc = "Pre-Cataclysm double action police revolver chambered in .357 magnum."
	icon_state = "police"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/policepistol.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC // limbfucker2000

	damage_multiplier = TIER2

/obj/item/gun/ballistic/revolver/m29
	name = "Big Iron"
	desc = "Powerful handgun for those who want to travel the deadlands safely in style. Has a bit of a kick."
	inhand_icon_state = "model29"
	icon_state = "m29"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	can_scope = TRUE
	scope_state = "revolver_scope"
	scope_x_offset = 6
	scope_y_offset = 24
	fire_sound = 'sound/f13weapons/44mag.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5
	name = "HK MP5"
	desc = "A pre-fall design, ancient and fairly common as far as sub machineguns go."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	weapon_class = WEAPON_CLASS_NORMAL //high class, one of the few smol smgs
	weapon_weight = GUN_ONE_HAND_ONLY
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10
	name = "MAC-10"
	desc = "A pre-fall compact machine pistol with a blistering fire rate. Not terribly accurate though."
	icon = 	'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "mac10"
	weapon_class = WEAPON_CLASS_NORMAL
	init_recoil = SMG_RECOIL(2, 2)
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/faster
	)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/smg/greasegun
	name = "Greasegun"
	desc = "A pre-fall design similar to the fairly common post-fall open bolt smgs. It has tight tolerances and fires a heavy cartridge."
	icon_state = "grease_gun"
	inhand_icon_state = "smg9mm"
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	mag_type = /obj/item/ammo_box/magazine/greasegun
	init_mag_type = /obj/item/ammo_box/magazine/greasegun
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	can_suppress = TRUE
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/fast // was on fast(er), ancient ass bug. what. the fuck.
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 19

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/m1carbine/compact
	name = "M1 Carbine - Folding Stock"
	desc = "Similar to the reservist carbine, this model has a folding stock for greater mobility."
	icon_state = "m1a1carbine"
	weapon_class = WEAPON_CLASS_CARBINE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_recoil = CARBINE_RECOIL(1.5, 1.5)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/varmint
	name = "Ruger Ranch Rifle"
	desc = "A simple pre-fall semi-auto rifle in 5.56mm calibre. Easy to use and maintain."
	icon_state = "varmint"
	inhand_icon_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	can_scope = TRUE

	damage_multiplier = TIER2 * 1.05

/obj/item/gun/ballistic/automatic/service
	name = "AR-15"
	desc = "A pre-fall semi-automatic rifle that is believed to have served a great nation at one time. Now they're fairly rare, high maintenance and not very popular. Good for those who can keep it fed."
	icon_state = "service_rifle"
	inhand_icon_state = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	reskinnable_component = null

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/m1garand/sks // to-do, make this have an internal mag please
	name = "SKS"
	desc = "Somehow, despite all that has gone wrong over the last few hundred years this eastern rifle is still working. It's almost immaculate."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "sks"
	inhand_icon_state = "sks"
	mag_type = /obj/item/ammo_box/magazine/sks
	init_mag_type = /obj/item/ammo_box/magazine/sks
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1, 1)

	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 23
	scope_state = "scope_mosin"
	scope_x_offset = 4
	scope_y_offset = 12
	auto_eject_sound = 'sound/weapons/magout.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/aksmol
	name = "Draco"
	desc = "An assault rifle given to rear echelon troops in place of an SMG. Lacks a stock, but packs a punch."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	inhand_icon_state = "ak74utest"
	icon_state = "ak74utest"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(1.5, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = TRUE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/fnfal/ak47
	name = "AK-47"
	desc = "A fairly uncommon eastern rifle. It's hard to tell if this one is in good shape or really bad. They just don't ever look quite right."
	icon_state = "trueak"
	inhand_icon_state = "trueak"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.0, 2.0)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto/slow
	)
	can_scope = TRUE
	can_suppress = FALSE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/automatic/armalite
	name = "AR-10"
	desc = "A pre-fall semi-automatic .308 rifle. Accurate and packs a punch, but recoil picks up quick, and it's heavy. Makes it suitable for bashing skulls, at least..."
	icon_state = "armalite"
	inhand_icon_state = "assault_carbine"
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.5, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/shotgun/grenade // keep this out of the loot list until we fix it
	name = "Grenade Launcher"
	desc = "A pre-fall bulky but surprisingly lightweight grenade launcher with a stiff pump."
	icon = 'modular_coyote/icons/objects/ncrrangersguns.dmi'
	icon_state = "china_lake"
	inhand_icon_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	init_mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY

	can_bayonet = FALSE
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/shotgun/hunting
	name = "Pump Shotgun"
	desc = "A pre-fall traditional hunting shotgun with wood furniture and a four-shell capacity underneath."
	icon_state = "pump"
	inhand_icon_state = "shotgunpump"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	damage_multiplier = TIER2

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5
	name = "Auto 5"
	desc = "A pre-fall semi-automatic shotgun with a four round tube."
	icon_state = "auto5"
	inhand_icon_state = "shotgunauto5"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	casing_ejector = TRUE // makes it eject casings -- and not need pumping!!!
	fire_sound = 'sound/f13weapons/auto5.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/rifle/repeater/trail
	name = ".44 Lever Action"
	desc = "A lever action rifle chambered in .44 Magnum."
	icon_state = "trailcarbine"
	inhand_icon_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/44mag.ogg'

	damage_multiplier = TIER2

/obj/item/gun/ballistic/rifle/hunting
	name = "hunting rifle"
	desc = "A sturdy military surplus rifle, rechambered to .30-06 Springfield. Which one? Maybe <b>you</b> should tell us."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	inhand_icon_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	sawn_desc = "A hunting rifle, crudely shortened with a saw. It's far from accurate, but the short barrel makes it quite portable."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	reskinnable_component = null // was /datum/component/reskinnable/hunting_rifle, please go through this list
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	damage_multiplier = TIER2

/obj/item/gun/ballistic/bow/longbow
	name = "Longbow"
	desc = "Large, bulky and powerful. "
	icon = 'modular_coyote/icons/objects/guns/bows.dmi'
	icon_state = "longbow"
	inhand_icon_state = "bow"
	init_recoil = RIFLE_RECOIL(3, 3) // Fires the slowest, high damage, hard to control
	w_class = WEIGHT_CLASS_BULKY

	damage_multiplier = TIER2

///////////// LOADOUT EDIT VERSIONS /////////////

/obj/item/gun/ballistic/automatic/pistol/ninemil/rare99/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/pistol/beretta/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/pistol/sig/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/pistol/deagle/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/revolver/police/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/revolver/m29/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/greasegun/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/m1carbine/compact/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/varmint/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/service/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/m1garand/sks/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/aksmol/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/fnfal/ak47/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/armalite/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/shotgun/hunting/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/rifle/repeater/trail/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/rifle/hunting/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/bow/longbow
	damage_multiplier = TIER0
