// Put tier respective guns (and loadout options) here. Ammo goes in their respective files somewhere around modular_coyote/code/modules/znuguns/code/ammo .

/obj/item/gun/ballistic/revolver/police/webley
	name = "half step"
	desc = "A gas operated police revolver that fires just about as fast as you can click the trigger."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "webley"
	item_state = "police"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)
	fire_sound = 'sound/f13weapons/policepistol.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC // limbfucker2000

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/smg/tommygun
	name = "drumroll"
	desc = "A powerful pre-fall submachinegun chambered in .45 ACP, this weapon fires at a blistering rate with a heavy pistol cartridge, and can accept very high capacity magazines, to boot."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "tommygun"
	item_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/greasegun
	init_mag_type = /obj/item/ammo_box/magazine/greasegun
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

	fire_sound = 'sound/weapons/gunshot_smg.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "staccato"
	desc = "A lightweight, automatic submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	item_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/uzim9mm/rockwell) //so I don't have to assign a ton of new sprite names
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	can_suppress = TRUE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/smg/mp5sd
	name = "nailtacker"
	desc = "An integrally suppressed submachinegun chambered in 9mm."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	silenced = TRUE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
	fire_sound_silenced = 'sound/weapons/Gunshot_silenced.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/m1garand
	name = "eagle"
	desc = "A very hefty pre-fall rifle with an en-bloc magazine known for making an appealing noise when it is ejected."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "m1garand"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/garand3006
	init_mag_type = /obj/item/ammo_box/magazine/garand3006
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	gun_tags = list(GUN_SCOPE)
	en_bloc = 1
	auto_eject = 1
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 5
	scope_y_offset = 14
	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/ak556
	name = "eastern lynx"
	desc = "A pre-fall eastern rifle of a design believed to be more modern. A bit of a unicorn of a gun, and kind of needy."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "ak74"
	icon_state = "ak74"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/assault
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(1.4, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200 ,
		/datum/firemode/semi_auto
		)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/z34rifle
	name = "eastern puma"
	desc = "A pre-fall large eastern rifle designed for hunting. Hunting what? Men."
	icon_state = "zastava"
	item_state = "zastava"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield
	init_mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.5, 2.5)
	init_firemodes = list (
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_flashlight = FALSE
	zoom_factor = 1.1
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/fnfal
	name = "handy"
	desc = "A large pre-fall battle rifle. Known today as a tempermental, heavy, beast of a weapon. At least the designers had the foresight to add a handle."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "fnfal"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle
	name = "forte"
	desc = "A foreign designed battle rifle. Pre-fall in design and well. Tempermental. Pretty decent overall though."
	icon_state = "g3"
	item_state = "g3"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.3, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto ,
		/datum/firemode/automatic/rpm200
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/rpd
	name = "eastern whirlwind"
	desc = "A pre-fall eastern designed light machine gun. It's rude, it's crude, it's downright demonic."
	icon_state = "rpd"
	item_state = "rpd"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/rpd
	init_mag_type = /obj/item/ammo_box/magazine/rpd
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/bar
	name = "lion"
	desc = "A pre-fall rifle. No one is sure who these were made for, they're almost too big for the average man to use. Perhaps people were larger back then?"
	icon = 'icons/fallout/objects/guns/bar.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "BAR"
	item_state = "BAR"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield/bar
	init_mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield/bar
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

	damage_multiplier = TIER3

/obj/item/gun/ballistic/automatic/saiga12k
	name = "eastern stag"
	desc = "A pre-fall eastern shotgun. It's reliable and packs a punch. Sure hope you don't want spare parts though."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "saiga"
	icon_state = "saiga"
	mag_type = /obj/item/ammo_box/magazine/saiga
	init_mag_type = /obj/item/ammo_box/magazine/saiga
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(2, 1.8)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75 ,
		/datum/firemode/semi_auto/slow
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = FALSE
	can_suppress = TRUE

	damage_multiplier = TIER3

/obj/item/gun/ballistic/shotgun/police
	name = "jackhammer"
	desc = "A pre-war shotgun with large magazine and folding stock, made from steel and polymers. Flashlight attachment rail."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/police
	sawn_desc = "Portable but with a poor recoil managment."
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
	
	stock = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 23
	flight_y_offset = 21
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/shotgun/trench
	name = "bucktoothed boar"
	desc = "A post-fall military shotgun designed for close-quarters fighting, equipped with a bayonet lug."
	icon_state = "trench"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 22
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/rifle/repeater/brush
	name = "smashback"
	desc = "A heavy Lever-action rifle chambered in .30-06 its sturdy design lets it handle the largest cartridges and largest game."
	icon_state = "brushgun"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube4570
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'

/obj/item/gun/ballistic/rifle/enfield
	name = "smelly"
	desc = "A pre-fall 10 round bolt action rifle. No one is sure why they're called smellies, they don't stink at all generally and are quite good."
	sawn_desc = "Why would someone short stock a smelly? Does that make this just a whiff?"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "smle"
	item_state = "smle"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/enfield
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	reskinnable_component = null

///////////// LOADOUT EDIT VERSIONS /////////////

/obj/item/gun/ballistic/revolver/police/webley/loadout
	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/smg/tommygun/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/mini_uzi/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/smg/mp5sd/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/m1garand/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/ak556/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/z34rifle/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/fnfal/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/rpd/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/bar/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/automatic/saiga12k/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/shotgun/police/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/shotgun/trench/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/rifle/repeater/brush/loadout
	damage_multiplier = TIER0
	
/obj/item/gun/ballistic/rifle/enfield/loadout
	damage_multiplier = TIER0
