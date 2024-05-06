//IN THIS DOCUMENT: Rifle template, Lever-action rifles, Bolt-action rifles, Magazine-fed bolt-action rifles
// See gun.dm for keywords and the system used for gun balance

/// Main thing that makes boltie guns are:
///  INTERNAL MAG and CASING_EJECTOR = FALSE
/// the internal mag makes it be loaded from a box or strip
/// the casing ejector = FALSE makes it pumped after each shot
/// enjoy!

////////////////////
// RIFLE TEMPLATE //
////////////////////


/obj/item/gun/ballistic/rifle
	name = "rifle template"
	desc = "Should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgun"
	item_state = "shotgun"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_bayonet = TRUE

	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	casing_ejector = FALSE // THIS makes it require manual cocking of the gun!!!
	spawnwithmagazine = TRUE
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	cock_sound = 'sound/weapons/shotgunpump.ogg'
	reloading_time = 0.5 SECONDS

/* /obj/item/gun/ballistic/rifle/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/rifle/can_shoot()
	return !!chambered?.BB

/obj/item/gun/ballistic/rifle/attack_self(mob/living/user)
	pump(user, TRUE) */

/obj/item/gun/ballistic/rifle/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/* * * * * * *
 * Repeaters *
 * * * * * * */

/* * * * * * * * * * *
 * Revolvers, but bigger
 * More magazine space
 * Little more damage
 * Two handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater
	name = "repeater template"
	desc = "should not exist"
	can_scope = TRUE
	scope_state = "scope_long"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	scope_x_offset = 5
	scope_y_offset = 13
	cock_sound = 'sound/f13weapons/cowboyrepeaterreload.ogg'

/* * * * * * * * * * *
 * Cowboy Repeater
 * Baseline Repeater
 * .357 Magnum
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/cowboy
	name = "cowboy repeater"
	desc = "A lever action rifle chambered in .357 Magnum. Smells vaguely of whiskey and cigarettes."
	icon_state = "cowboyrepeater"
	item_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/* * * * * * * * * * * * * * * *
* .22LR Lever Action Rifle
* 20 round capacity
* My hands are stupid and I must game
* 我的社會信用太低所以我不能離開家
* Its In .22 I Don't Know What Else I Can Put Here
* * * * * * * * * * * * * * * * * */
/obj/item/gun/ballistic/rifle/repeater/trainer
	name = "Training Repeater"
	desc = "A lever action rifle chambered in .22LR. Used to teach people the basics of firearm operation."
	icon_state = "lever22" // Placeholder
	item_state = "lever22"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/long22
	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE // Either this does nothing or it only affects bolt workers click to cock. 
	damage_multiplier = GUN_EXTRA_DAMAGE_T5 // It'd be rpetty stupid if it did less damage than the snubnose .22 revolver that is a tiny sized thing
	init_recoil = CARBINE_RECOIL(1, 0.8)
	can_scope = TRUE
	scope_state = "scope_long" // Scope sprites currently don't work unfortunately, and fixing it is probably a low priority
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 29
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/* * * * * * * * * * * * * * * *
* .22LR Mares Leg
* 10 round capacity
* For when you need to be a badass on a budget
* 我的太空站上有一個人不誠實地透露自己的真實身分和意圖
* Its In .22 I Don't Know What Else I Can Put Here
* * * * * * * * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/trainerator
	name = ".22 Mares Leg"
	desc = "A lever action rifle chambered in .22LR. This one has been cut down crudely, and probably named something like The Filly Buster because you're not just the peak of comedy, you're the whole damn circus and the laugh track, too."
	icon_state = "lever22short" // Placeholder
	item_state = "lever22short"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/short22
	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T5 // It'd be rpetty stupid if it did less damage than the snubnose .22 revolver that is a tiny sized thing
	init_recoil = CARBINE_RECOIL(1, 0.8)
	can_scope = TRUE
	scope_state = "scope_short" // Scope sprites currently don't work unfortunately, and fixing it is probably a low priority
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 21 // FIRST TRY BAYEEEEEEE
	suppressor_y_offset = 23
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/* * * * * * * * * * * * * * * *
* Volcanic pistol
* -6 round capacity
* + Slightly better than the .45 ACP base damage
* +/- Muh lever action
* + Based off RDO, can be dual wielded
* + Uses .45 acp, the lord's caliber
* * * * * * * * * * * * * * * * * */
/obj/item/gun/ballistic/rifle/repeater/volcanic
	name = "Lever action pistol"
	desc = "A Volcanic Pistol from the Volcanic Repeating Arms Company. The pistol itself is a 6 round capacity rechambered in a much more fitting .45 ACP. The gun's original problems have been seemingly taken care of as to not allow your hand or hands to blow off when using the gun itself."
	icon_state = "volcanic"
	item_state = "volcanic"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/internal/shot/volcanic
	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL (1.2 , 1.2)
	can_suppress = FALSE
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	reskinnable_component = /datum/component/reskinnable/volcanic

/* * * * * * * * * * *
 * Coyote Repeater
 * Baseline Repeater Tribal Skin
 * .357 Magnum
 * Tribal Only
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/cowboy/tribal
	name = "coyote repeater"
	desc = "A sanctified .357 lever action rifle, bearing a paw print, teeth painted on the handguard and what appears to be a severed paw."
	icon_state = "cowboyrepeatert"
	item_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/* * * * * * * * * * *
 * Trail Repeater
 * Big Repeater
 * .44 Magnum
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/trail
	name = "trail carbine"
	desc = "A lever action rifle chambered in .44 Magnum."
	icon_state = "trailcarbine"
	item_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/44mag.ogg'

/* * * * * * * * * * *
 * Trail Repeater Tribal
 * Rain Stick
 * .44 Magnum
 * Tribal Only
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/trail/tribal
	name = "rainstick"
	desc = "A sactified .44 lever action rifle, coated in detailed markings and a carved bead chain that sounds like rain."
	icon_state = "trailcarbinet"
	item_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/44mag.ogg'

/* * * * * * * * * * *
 * Brush Repeater
 * Bigger Repeater
 * .45-70 Bigboy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/brush
	name = "brush gun"
	desc = "A heavy Lever-action rifle chambered in .45-70. its sturdy design lets it handle the largest cartridges and largest game."
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

/* * * * * * * * * * *
 * Brush Repeater Tribal
 * Medicine Stick
 * .45-70 Bigboy
 * Tribal Only
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/brush/tribal
	name = "medicine stick"
	desc = "A heavy .45-70 Lever-action rifle. Beautiful paintings coat the fine weapon, a bead that whistles when spun hangs from a hand woven cord."
	icon_state = "brushgunt"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube4570
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 2)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'

/* * * * * * * * * * *
 * Ranger repeater
 * Biggest repeater
 * .308
 * Medium rarity
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/ranger
	name = "long ranger repeater"
	desc = "A lever action chambered in .308. Shares lots of characteristics with lever actions, but also the clunkiness of bolt actions, Best of both worlds, or master of none?"
	icon_state = "308-lever"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube380
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 0.9)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'

/* * * * * * * * * * *
 * Ranger repeater tribal
 * Smell-The-Roses
 * .308
 * Tribal Only
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/ranger/tribal
	name = "Smell-The-Roses"
	desc = "A .308 lever action. Clunky, Heavy and decorated by someone with a sick sense of humor. A flowering rose around the bore, it's stem trailing along and petals on a string."
	icon_state = "smell-the-roses"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube380
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 2)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'

/* * * * * * * * * * *
 * Three oh hate
 * unique repeater
 * .308
 * unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/ranger/threeohate
	name = "Three Oh Hate"
	desc = "placeholder"

/* * * * * * * * * * * *
 * Bolt-Action Rifles  *
 * * * * * * * * * * * */

/* * * * * * * * * * *
 * Slow rifles
 * Low magazine space
 * More damage
 * Higher caliber
 * Accurate
 * Generally scopeable
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Hunting Bolt-Action Rifle
 * Baseline Bolt-Action Rifle
 * .308 / 7.62
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting
	name = "hunting rifle"
	desc = "A sturdy hunting rifle, chambered in .30-06 Springfield."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	sawn_desc = "A hunting rifle, crudely shortened with a saw. It's far from accurate, but the short barrel makes it quite portable."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	reskinnable_component = /datum/component/reskinnable/hunting_rifle

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/rifle/hunting/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/rifle/hunting/special
	name = "hypocritical oath"
	desc = "An old, worn-in hunting rifle with leather wrapping the stock. Do (no) harm."
	icon_state = "308special"
	item_state = "308special"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)


/* * * * * * * * * * *
 * Remmington Bolt-Action Rifle
 * Accurate Bolt-Action Rifle
 * .308 / 7.62
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting/remington
	name = "Remington 700"
	desc = "This bolt action rifle was popular among hunters, police, and the military before the War."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0

/obj/item/gun/ballistic/rifle/hunting/remington/attackby(obj/item/A, mob/user, params) //DO NOT BUBBA YOUR STANDARD ISSUE RIFLE SOLDIER!
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()

/* * * * * * * * * * *
 * Paciencia Bolt-Action Rifle
 * Superstrong Bolt-Action Rifle
 * .308 / 7.62
 * More damage
 * Less magazine
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting/paciencia
	name = "Paciencia"
	desc = "A modified .30-06 hunting rifle with a reduced magazine but an augmented receiver. A Mexican flag is wrapped around the stock. You only have three shots- make them count."
	icon_state = "paciencia"
	item_state = "paciencia"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/paciencia
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_recoil = RIFLE_RECOIL(1, 1)

	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE

/obj/item/gun/ballistic/rifle/hunting/paciencia/attackby(obj/item/A, mob/user, params) //no sawing off this one
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()

/* * * * * * * * * * *
 * Mosin Bolt-Action Rifle
 * Moist Bolt-Action Rifle
 * .308 / 7.62
 * Can bayonet
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mosin
	name = "Mosin-Nagant m38"
	desc = "A rusty old Russian bolt action chambered in 7.62."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "mosin"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
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

//lee speed
/obj/item/gun/ballistic/rifle/leespeedster
	name = "Lee Einfield 'Speed' rifle."
	desc = "A modified Lee Enfield with a shorten mag capacity but high stopping power. The bolt is greased and well made, even lighter which allows for faster operation of the rifle. It lacks the bayonet lug."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "speed"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/speedinglee
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	can_bayonet = FALSE
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'

	init_firemodes = list(
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/ballistic/rifle/mosin/mini
	name = "Mini-mosin"
	desc = "A tiny replica of a classic russian rifle. the stock barely fits your shoulder!"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/twentytwo
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_T5

	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/ballistic/rifle/mosin/mini/Initialize()
	.=..()
	transform *= 0.6
	special_transform = transform

/* * * * * * * * * * *
 * Laser Mosin Bolt-Action Rifle
 * Moist Bolt-Action Laser
 * Laser Musket Cell
 * Can bayonet
 * Rare
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mosin/laserbubba
	name = "Modified Mosin-Nagant"
	desc = "An ancient bolt-action rifle modified to accept, and fire, energy cells in semi-automatic style. The worksmanship is as impressive as it is vile."
	icon_state = "mosin-energy"
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lasmusket/mosin


/* * * * * * * * * * *
 * SMLE Bolt-Action Rifle
 * Quick Bolt-Action Rifle
 * .308 / 7.62
 * Faster cock
 * More tiring cock
 * Can bayonet
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/enfield
	name = "Lee-Enfield rifle"
	desc = "A British rifle sometimes known as the SMLE. It seems to have been re-chambered in .308. Can be sawn off."
	sawn_desc = "This accursed abomination was a common modification for trench warfare. Now some waster is likely using it for close quarters."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "smle"
	item_state = "smle"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enfield
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
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
	reskinnable_component = /datum/component/reskinnable/enfield

/obj/item/gun/ballistic/rifle/enfield/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/rifle/enfield/jungle
	name = "Jungle Carbine"
	desc = "A shortened Enfield used for secondary service in the Australian and New Zealand army for jungle warfare. Made from an SMLE, it holds 10 rounds but sadly cannot fit a scope."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "junglecarbine"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enfield
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_FAST
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower

	)

/obj/item/gun/ballistic/rifle/antique/gras
	name = "Gras"
	desc = "A very old black powder cartridge gun of French lineage. How has it gotten here? Or survived this long?"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "gras"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/gras
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2 // will see if it's too much // It seems T5 was too much
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
	reskinnable_component = /datum/component/reskinnable/gras


/obj/item/gun/ballistic/rifle/antique/tankgun
	name = "Mauser TankGewehr M1918"
	desc = "A very old yet heavy AT rifle. Chambered in 13.7mm(50.cal), this rifle was used in limited numbers in 1918. The rifle weighs a staggering 40 pounds but packs a HEFTY punch. Go ahead, send that mutant to the gates in the sky."
	icon = 'icons/fallout/objects/guns/tg1918.dmi'
	icon_state = "tg"
	item_state = "tg"
	mag_type = /obj/item/ammo_box/magazine/internal/giantgun
	lefthand_file = 'icons/fallout/objects/guns/tglefthand.dmi'
	righthand_file = 'icons/fallout/objects/guns/tgrighthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	init_recoil = HMG_RECOIL(3, 2)
	slowdown = GUN_SLOWDOWN_RIFLE_LMG
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	can_bayonet = FALSE
	can_suppress = FALSE

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

/obj/item/gun/ballistic/rifle/antique/tankgun/custom
	name = "Custom TankGewehr M1918"
	desc = "A custom made TGM1918 rifle. This rifle still weighs a staggering 40+ pounds, but the gun is engraved and the wood akin to that of birch. A fancy AT rifle for those that pack heat. On the butt of the gun is a scene of a moth chasing a feline."
	icon = 'icons/fallout/objects/guns/tg1918.dmi'
	icon_state = "tg"
	item_state = "tg"
	mag_type = /obj/item/ammo_box/magazine/internal/giantgun
	lefthand_file = 'icons/fallout/objects/guns/tglefthand.dmi'
	righthand_file = 'icons/fallout/objects/guns/tgrighthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = HMG_RECOIL(3, 2)
	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = FALSE
	can_bayonet = FALSE
	can_suppress = FALSE

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

/obj/item/gun/ballistic/rifle/antique/gross
	name = "sawed off Gras"
	desc = "A very old black powder cartridge gun of French lineage. Unfortunately, it evidently did not survive its journey here."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "gross"
	item_state = "308-sawn"
	mag_type = /obj/item/ammo_box/magazine/internal/gras
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2 // T1 or T0 just make it a downgrade to the sawed off hunting rifle
	init_recoil = RIFLE_RECOIL(3, 2) // Say goodbye your to kneecaps chucklenuts
	gun_accuracy_zone_type = ZONE_WEIGHT_SEMI_AUTO // There ain't no got dang sights
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = FALSE
	cock_sound = 'sound/f13weapons/grasbolt.ogg'
	fire_sound = 'sound/f13weapons/gras.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/rifle/antique/gross/marty
	name = "sawed off Martini Henry"
	desc = "The shortened version of the shortened version of Henry Martin's 'Kilometer Gun'. Considerably more portable."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "marty"

/obj/item/gun/ballistic/rifle/antique/gras/laserfusil
	name = "Fusil Energie"
	desc = "A very old black powder cartridge gun of French lineage. How has it gotten here? Or survived this long? Someone tore out it's internals and built a laser musket into it."
	icon_state = "madsenm47FE"
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lasmusket/mosin
	damage_multiplier = GUN_EXTRA_DAMAGE_0

/* * * * * * * * * * *
 * Salvaged Eastern Rifle
 * Fixed-mag semi-auto rifle
 * .223 / 5.56mm / 5mm
 * Loads 556 and 5mm!
 * loaded one at a time
 *
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle
	name = "salvaged eastern rifle"
	desc = "A clever design adapted out of salvaged surplus eastern rifles and wasteland scarcity. It features a complex loading mechanism \
		and barrel capable of using both 5mm and 5.56mm rifle ammunition with reasonable success. \
		The magazine is welded to the frame, and the loading port angled <i>just enough</i> to make stripper clips not work. \
		Apparently these 'features' to the design, being on every instance of this gun."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "salvak"
	item_state = "salvak"
	mag_type = /obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	init_mag_type = /obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
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





/* * * * * * * * * * *
 * snowflake varmint rifle
 * identical to a varmint rifle excepting in projectile cosmetics
 * .223 / 5.56mm
 * Scopeable
 * Same damage, literally GUN_EXTRA_DAMAGE_0
 * Homie just wanted a resprite
 * Unique, doesn't have to be, throw it in the loot pool if you wanna be goofy
 * * * * * * * * * * */


/obj/item/gun/ballistic/rifle/magnetic
	name = "Hephestus Ferromagnetic Rifle"
	desc = "a damaged, juryrigged prototype utilizing maglev technologies to propel a ferromagnetic slug to extreme velocities."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "magriflev"
	item_state = "magrifle"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
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
	fire_sound = 'sound/weapons/magrifle.ogg'
	can_scope = TRUE
	casing_ejector = TRUE
	weapon_special_component = null

/obj/item/gun/ballistic/rifle/magnetic/post_modify_projectile(obj/item/projectile/BB) //thurr. I turned a regular bullet into a mag bullet.
	BB.name = "ferromagnetic bullet"
	BB.icon = 'icons/obj/projectiles.dmi'
	BB.icon_state = "magjectile-large"
	BB.pass_flags = PASSTABLE
	BB.light_range = 3
	BB.damage_type = BRUTE
	BB.flag = "bullet"
	BB.impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	BB.light_color = LIGHT_COLOR_RED
	BB.is_reflectable = TRUE
	BB.hitsound = 'sound/weapons/elecfire.ogg'
	BB.hitsound_wall = 'sound/weapons/effects/searwall.ogg'

/* * * * * * * * * * * * * * * * * *
 * Magazine-Fed Bolt-Action Rifles *
 * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * *
 * Slower rifles
 * Low magazine space
 * More damage
 * Higher caliber
 * Accurate
 * Generally scopeable
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mag
	name = "magazine fed bolt-action rifle template"
	desc = "should not exist."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
/obj/item/gun/ballistic/rifle/mag/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to remove the magazine.")

/obj/item/gun/ballistic/rifle/mag/AltClick(mob/living/user)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(magazine)
		magazine.forceMove(drop_location())
		user.put_in_hands(magazine)
		magazine.update_icon()
		if(magazine.ammo_count())
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, 1)
		else
			playsound(src, "gun_remove_empty_magazine", 70, 1)
		magazine = null
		to_chat(user, span_notice("You pull the magazine out of \the [src]."))
	else if(chambered)
		AC.forceMove(drop_location())
		AC.bounce_away()
		chambered = null
		to_chat(user, span_notice("You unload the round from \the [src]'s chamber."))
		playsound(src, "gun_slide_lock", 70, 1)
	else
		to_chat(user, span_notice("There's no magazine in \the [src]."))
	update_icon()
	return

/obj/item/gun/ballistic/rifle/mag/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/* * * * * * * * * * *
 * Anti-Material Rifle
 * Huge Bolt-Action Rifle
 * .50MG
 * Slow to fire
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mag/antimaterial
	name = "anti-material rifle"
	desc = "The Hecate II is a heavy, high-powered bolt action sniper rifle chambered in .50 caliber ammunition. Lacks an iron sight."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "amr"
	item_state = "amr"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/amr
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T6
	init_recoil = HMG_RECOIL(3, 3)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	zoom_factor = 1
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

/obj/item/gun/ballistic/rifle/mag/antimaterial/loadout
	desc = "The Hecate II is a heavy, high-powered bolt action sniper rifle chambered in .50 caliber ammunition. Not only lacks an iron sight, but due to unmaintained age it doesn't punch as hard."
	damage_multiplier = GUN_EXTRA_DAMAGE_T3

/obj/item/gun/ballistic/rifle/mag/pz39custom //custom
	name = "Custom Panzerbüchse 39"
	desc = "A customized PzB.39 AT rifle. This rifle seems to be custom fitted to fire in a bolt-action mode instead of a falling-block action.The bolt is not really much of a bolt but it works, it also adds more weight to the rifle. From 27.78 lbs to 30 pounds! The rifle consists of premium grade parts. The stock itself, the part where one rests their shoulder, is extra padded for comfort and shock absorbing properties. Engraved on the reciever is baroque motifs while the rifle itself has a few moths and feline figures engraved on the reciever. A rifle fit for the Queen from the shadows."
	icon_state = "pzb39"
	item_state = "pzb39"
	mag_type = /obj/item/ammo_box/magazine/pzb39magazne
	init_mag_type = /obj/item/ammo_box/magazine/pzb39magazne
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/objects/guns/ww2gunsleft.dmi'
	righthand_file = 'icons/fallout/objects/guns/ww2gunsright.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T4
	init_recoil = HMG_RECOIL (1.4 , 1.5)
	cock_delay = GUN_COCK_RIFLE_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = TRUE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'



/obj/item/gun/ballistic/rifle/mauserrifle
	name = "Mauser Model 1871"
	desc = "A Mauser Model 1871, also known as the Gewehr 71 or Infantry Gewehr 71. A bolt action rifle chambered in 11.7mm(50.cal), this rifle saw service by the German Empire. It was replaced by the Gewehr 88 in 1888 through 1890."
	icon_state = "m71"
	item_state = "m71"
	mag_type = /obj/item/ammo_box/magazine/internal/mausereight
	init_mag_type = /obj/item/ammo_box/magazine/internal/mausereight
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T4
	init_recoil = RIFLE_RECOIL (1.4 , 0.9)
	cock_delay = GUN_COCK_RIFLE_BASE
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/fg42.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

/obj/item/gun/ballistic/rifle/gewehr88
	name = "Model 1888 commission rifle"
	desc = "A Model 1888 commission rifle. This rifle interestingly enough has the ability to eject the clip, also seems to require it itself to fire. This specific model was made so it is extra sturdy. It seems to be in perfect condition with freshly new wood varnish!"
	icon_state = "g88"
	item_state = "g88"
	mag_type = /obj/item/ammo_box/magazine/internal/gewehreight
	init_mag_type = /obj/item/ammo_box/magazine/internal/gewehreight
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_recoil = RIFLE_RECOIL (1.2 , 0.7)
	cock_delay = GUN_COCK_RIFLE_BASE
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_scope = TRUE
	fire_sound = 'sound/f13weapons/fg42.ogg'
	force_unwielded = 30
	force = 30
	force_wielded = 35



//no scope, less capacity, more common
/obj/item/gun/ballistic/rifle/mag/boys
	name = "Boys anti-tank rifle"
	desc = "A heavy british rifle boasting a strong kick and an even stronger punch."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "boys"
	item_state = "boys"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/boys
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HMG_RECOIL(3, 3)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

// BETA // Obsolete
/obj/item/gun/ballistic/rifle/rifletesting
	name = "hunting"
	mag_type = /obj/item/ammo_box/magazine/testbullet
	damage_multiplier = 30

