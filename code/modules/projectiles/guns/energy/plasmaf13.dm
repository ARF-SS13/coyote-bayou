
//////////////////
//PLASMA WEAPONS//
//////////////////

//Plasma pistol
/obj/item/gun/energy/laser/plasma/pistol
	name ="plasma pistol"
	item_state = "plasma-pistol"
	icon_state = "plasma-pistol"
	desc = "A pistol-sized miniaturized plasma caster built by REPCONN. It fires a bolt of superhot ionized gas."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	init_recoil = HANDGUN_RECOIL(1, 1)

//Plasma pistol: Eve
/obj/item/gun/energy/laser/plasma/pistol/eve
	name ="eve"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "eve"
	desc = "A Plasmophiles wet dream. This meticulously modified pistol has seen every part serviced or improved in some manner."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/eve)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

//Eve, Worn version
/obj/item/gun/energy/laser/plasma/pistol/eve/worn
	name ="eve"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "eve"
	desc = "A Plasmophiles wet dream. This meticulously modified pistol has seen every part serviced or improved in some manner. This one has seen some age..."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/eve/worn)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY

//Plasma pistol: Adam
/obj/item/gun/energy/laser/plasma/pistol/adam
	name ="adam"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	item_state = "plasma-pistol"
	icon_state = "adam"
	desc = "Love is fundamentally about looking forward, not backward. It's a committment to becoming, not merely being. It's an enlistment in togetherness, not aloneness."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/adam)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

//BoS knight craftable plasma pistol
/obj/item/gun/energy/laser/plasma/pistol/light
	name = "lightweight plasma pistol"
	icon_state = "light-plasma-pistol"
	desc = "A lightweight modification of the common REPCONN-built plasma pistol. Fires heavy low penetration plasma clots at a slower rate than the regular design due to reduced cooling."
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/plasma/pistol/worn
	name ="shoddy plasma pistol"
	desc = "A pistol-sized miniaturized plasma caster built by REPCONN. It fires a bolt of superhot ionized gas. This one's internal parts have loose seals and corroded electronics."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/worn)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

//Glock 86 Plasma pistol
/obj/item/gun/energy/laser/plasma/glock
	name = "glock 86"
	desc = "Glock 86 Plasma Pistol. Designed by the Gaston Glock artificial intelligence. Shoots a small bolt of superheated plasma. Powered by a small energy cell."
	item_state = "plasma-pistol"
	icon_state = "glock86"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/glock)
	equipsound = 'sound/f13weapons/equipsounds/pistolplasequip.ogg'
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
//Glock 86 A Plasma pistol
/obj/item/gun/energy/laser/plasma/glock/extended
	name ="glock 86a"
	item_state = "plasma-pistol"
	icon_state = "glock86a"
	desc = "This Glock 86 plasma pistol has had its magnetic housing chamber realigned to reduce the drain on its energy cell. Its efficiency has doubled, allowing it to fire more shots before the battery is expended."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/glock/extended)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY

//Plasma Rifle
/obj/item/gun/energy/laser/plasma
	name ="plasma rifle"
	item_state = "plasma"
	icon_state = "plasma"
	desc = "A miniaturized plasma caster that fires bolts of magnetically accelerated toroidal plasma towards an unlucky target."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	init_recoil = CARBINE_RECOIL(1, 1)

//Plasma carbine
/obj/item/gun/energy/laser/plasma/carbine
	name ="plasma carbine"
	item_state = "plasma"
	icon_state = "plasmacarbine"
	desc = "A burst-fire energy weapon that fires a steady stream of toroidal plasma towards an unlucky target."
	ammo_type = list(/obj/item/ammo_casing/energy/plasmacarbine)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = TRUE
	scope_state = "plasma_scope"
	scope_x_offset = 13
	scope_y_offset = 16
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/burst/two
	)
	init_recoil = AUTOCARBINE_RECOIL(1, 1)

//Multiplas rifle
/obj/item/gun/energy/laser/plasma/scatter
	name = "multiplas rifle"
	item_state = "multiplas"
	icon_state = "multiplas"
	desc = "A modified A3-20 plasma caster built by REPCONN equipped with a multicasting kit that creates multiple weaker clots."
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/scatter)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	init_recoil = SHOTGUN_RECOIL(1, 1)


//Bouncy Plasma
/obj/item/gun/energy/laser/plasma/bouncy
	name ="Neptune-35 matter modulator"
	icon_state = "instagibblue"
	item_state = "instagibblue"
	desc = "A  experimental, miniaturized plasma caster that fires orbs of magnetically accelerated, quasi-stable toroidal plasma towards an unlucky target, has a tendency to bounce on contact with solid surfaces."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/bouncy)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	init_recoil = CARBINE_RECOIL(1, 1)


//Eve Caster
/obj/item/gun/energy/laser/plasma/castereve
	name ="Malediction"
	icon = 'icons/fallout/objects/guns/longenergy.dmi'
	item_state = "Aldric-Plasma-CasterEve"
	icon_state = "Aldric-Plasma-CasterEve"
	desc = "A burst-fire energy weapon that fires a torrential stream of toroidal plasma towards an unlucky target. This ones glows purple and has the words; Pick a god and pray. etched into the side."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/eve/caster)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
		/datum/firemode/burst/three/slower
	)
	init_recoil = AUTOCARBINE_RECOIL(1, 1)

//Normal Plasma Caster
/obj/item/gun/energy/laser/plasma/caster
	name ="Plasma Caster"
	icon = 'icons/fallout/objects/guns/longenergy.dmi'
	item_state = "Aldric-Plasma-Caster"
	icon_state = "Aldric-Plasma-Caster"
	desc = "A burst-fire energy weapon that fires a torrential stream of toroidal plasma towards an unfortunate soul."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/caster)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
		/datum/firemode/burst/three/slower
	)
	init_recoil = AUTOCARBINE_RECOIL(1, 1)


// plasma covenant pistol, starter weapon. Fairly weak, one haded only but small. Has added bane damage to make up for low damage.
/obj/item/gun/energy/laser/plasma/covpistol
	name = "Latos Systems EG-2A7 pistol"
	desc = "A EG-2A7 prototype pistol manufactured by Latos Systems. It doesn't hurt hard against armor, but on unarmored or exposed bits, it can be quite painful to be hit by!"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "energyhalo"
	item_state = "energyhalo"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/covenantpistol)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_remove = 0
	can_charge = 1
	selfcharge = 1
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/plasma/covpistol/Drekavacpistol
	name = "Honorbounded Drekavac pistol"
	desc = "A EG-2A7 prototype pistol manufactured by Latos Systems. On the handle is a slavic text, stating 'He who haunts the living'. It comes in a differing color scheme and hits much harder with a higher capacity than the original model."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "drekavac"
	item_state = "drekavac"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/covenantpistol/screech)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_remove = 0
	can_charge = 1
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)


/obj/item/gun/energy/laser/plasma/plasmacov
	name = "Latos Systems PR-M1A2 Rifle"
	desc = "A PR-M1A2. The M1A2 plasma rifle seems to very weak in hitting just about anything, a seemingly failed prototype. Alien in appearance, this rifle has a slow ROF for automatic speed but seems to be able to hold its own with a rechargeable battery!"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "pr"
	item_state = "pr"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/covenantrifle)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_remove = 0
	can_charge = 1
	selfcharge = 1
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow ,
		/datum/firemode/automatic/rpm75
	)

// Non-spawnable version. Much more powerful than the original one. Loot only
/obj/item/gun/energy/laser/plasma/plasmacov/demon
	name = "Oni's Bane rifle"
	desc = "A PR-M1A2. This one is marked by the markings of the Oni, which are demons in Japanese folklore. Enscribed onto the handle is Japanese text. For those that read, it reads out 'I am the bane of the demons'. This specific prototype plasma rifle from Latos Systems seems to fire much faster and hits way harder than usual. Armor? You mean butter,right?"
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "oni"
	item_state = "oni"
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/onirifle)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_remove = 0
	can_charge = 1
	can_scope = FALSE
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/fast ,
		/datum/firemode/automatic/rpm150
	)


/obj/item/gun/energy/laser/plasma/spear
	name = "ergonomic plasmacaster"
	icon = 'icons/fallout/objects/melee/twohanded.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	item_state = "plasma"
	icon_state = "plasma"
	desc = "An ergonomic pre-war plasmacaster designed for precision mining work. This one appears to be built into a single thick staff, with a bulbous hilt and sharp saturnite alloy blades ringing the caster assembly- strongly resembling sort of spear."
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/miner)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	sharpness = SHARP_EDGED
	scope_y_offset = 16
	equipsound = 'sound/f13weapons/equipsounds/plasequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	force_unwielded = GUN_MELEE_FORCE_RIFLE_LIGHT
	force_wielded = GUN_MELEE_FORCE_RIFLE_LIGHT * 2
	wielded_icon = "plasma2"
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	weapon_special_component = /datum/component/weapon_special/ranged_spear

