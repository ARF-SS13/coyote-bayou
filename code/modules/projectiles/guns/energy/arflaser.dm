/////////////////
//LASER PISTOLS//
/////////////////

//todo
/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. It is decorated with leather and chrome. The object menaces with spikes of energy. On the item is an image of a space station. The station is exploding."
	ammo_x_offset = 3
	ammo_type = list(/obj/item/ammo_casing/energy/fifty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = HANDGUN_RECOIL(0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/wattz
	name = "Wattz 1000 laser pistol"
	desc = "A Wattz 1000 Laser Pistol. Civilian model of the AEP7. Its capacity is cut by half per cell, and doesn't shoot as fast, but has more powerful beams. Uses small energy cells."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "wattz1000"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/wattz/magneto
	name = "Wattz 1000 magneto-laser pistol"
	desc = "This Wattz 1000 laser pistol has been upgraded with a magnetic field targeting system that tightens the laser emission."
	icon_state = "magnetowattz"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/wattzs
	name = "Wattz 1000s laser pistol"
	desc = "The Wattz 1000 Sports Edition was designed as a direct competitor to the AEP7, boasting an optimized emitter that greatly increases cell efficiency."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "wattz1000s"
	item_state = "laser-pistol"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/energy/laser/wattz/recharger
	name = "Recharger Pistol"
	desc = "A recharger pistol manufactured by the Followers of the Apocalpyse. As the name implied, it charges its capacitor banks over time using radioactive decay."
	can_remove = 0
	can_charge = 0
	selfcharge = 1
	icon_state = "rechargerpistol"
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/pistol
	name = "\improper AEP7 laser pistol"
	desc = "A basic energy-based laser gun that fires concentrated beams of light. Military version of the Wattz-1000."
	icon_state = "AEP7"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 7
	scope_y_offset = 22
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/complianceregulator
	name = "AEP5-CR Disabling Beam Pistol"
	desc = "A laser pistol that has been modified for less-than-lethal work."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "AEP5CR"
	item_state = "AEP5CR"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/stun)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 7
	scope_y_offset = 22
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/solar
	name = "\improper Solar Scorcher"
	desc = "This modified AEP7 laser pistol takes its power from the sun, recharging slowly using stored solar energy. However, it cannot be recharged manually as a result."
	icon_state = "solarscorcher"
	item_state = "solarscorcher"
	ammo_type = list(/obj/item/ammo_casing/energy/fifteen/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_charge = 0
	selfcharge = 1 //selfcharging adds 100 a shot
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'

	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)

/obj/item/gun/energy/laser/badlands
	name = "\improper Badland's Special"
	desc = "A jury-rigged AEP7, this pistol carves out every safety feature and shortens the lenses length to cram a second emitter inside."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "bspecial"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/burst/two
	)

/obj/item/gun/energy/laser/badlands/worn
	name = "\improper Worn Badland's Special"
	desc = "A jury-rigged AEP7, this pistol carves out every safety feature and shortens the lenses length to cram a second emitter inside. This ones seems aged."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "bspecial"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)

/obj/item/gun/energy/laser/freeblade
	name = "\improper Freeblade Blaster"
	desc = "A special tri-shot pistol. Does decent damage, and is specialty customized for a certain someone."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "freeblade"
	item_state = "freeblade"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/freeblade)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/auto
	name = "compact rcw"
	desc = "A beefed-up laser pistol manufactured by West Tek, reinforced to allow it to withstand the thermal load of sustained fire."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "protolaser"
	item_state = "laser"
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	ammo_type =  list(/obj/item/ammo_casing/energy/ten/hitscan)
	can_scope = FALSE
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/energy/laser/auto/nayriin
	name = "Lucy"
	desc = "This RCW stands out from most others in the wastes, clearly having had loving hands maintaining it over the course of years. Despite this maintenance, the weapon looks worse for wear featuring a warped, heat stressed barrel. It's polished wooden stock has a Vault-Tec logo in the center of it, with Vault 60 written above it, both being gold inlays. The name Lucy is written in the same gold inlay at the bottom, with the name Cyl carefully carved next to it."
	icon_state = "lasercw"
	item_state = "rcw"
	ammo_type = list(/obj/item/ammo_casing/energy/ten/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/energy/laser/auto/oasis
	name = "autoshock tesla pistol"
	desc = " An upgraded version of the Compact RCW. Boasts a higher cell efficiency at the cost of the burstfire and armor melting power."
	ammo_type =  list(/obj/item/ammo_casing/energy/ten)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/energy/laser/ultra_pistol
	name = "\improper Ultracite laser pistol"
	desc = "An ultracite enhanced energy-based laser gun that fires concentrated beams of light."
	icon_state = "ultra_pistol"
	item_state = "laser-pistol"
	scope_x_offset = 7
	scope_y_offset = 22
	ammo_type = list(/obj/item/ammo_casing/energy/fifteen)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

/obj/item/gun/energy/laser/sida
	name = "S.I.D.A."
	desc = "A Wattz 1000 Sports Edition that was tampered with by the headscribe XAL, \
		its body was given a white finish in honor of his partner and also augmented so its cell feeds on radiation decay, \
		a relationship is made of ups and down after all. The name 'Sida' is etched along the side of its hip."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "sida"
	item_state = "laser-pistol"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattzs)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	can_remove = FALSE
	can_charge = FALSE
	selfcharge = EGUN_SELFCHARGE
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/energy/laser/wattz2k
	name = "wattz 2000"
	desc = "Wattz 2000 Laser Rifle. Uses micro fusion cells for more powerful lasers, and an extended barrel for additional range."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "wattz2k"
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/energy/laser/wattz2k/extended
	name = "wattz 2000e"
	desc = "This Wattz 2000 laser rifle has had its capacitor system upgraded to allow stronger shots but a slower recovery."
	icon_state = "wattz2k_ext"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/wattz2ks
	name = "wattz 2000s"
	desc = "The Wattz 2000 Sports Edition was designed for ease of use when hunting light game or target shooting."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "wattz2ks"
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

/obj/item/gun/energy/laser/aer9
	name = "\improper AER9 laser rifle"
	desc = "A sturdy pre-war laser rifle. Emits beams of concentrated light to kill targets. Fast firing, but not very powerful."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "laser"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/thirty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/energy/laser/aer9/focused
	name = "\improper Hot-wired AER9 laser rifle"
	desc = "A sturdy pre-war laser rifle. Emits beams of concentrated light to kill targets. This one has been jury-rigged against common sense to dump more power into its shots."
	ammo_type = list(/obj/item/ammo_casing/energy/thirty/hitscan)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)

/obj/item/gun/energy/laser/aer9/focused/rynn
	name = "\improper Hot-wired AER10 laser rifle"
	desc = "A pre-war laser rifle prototype that has seen better day, known as a failed attempt at competing with the wattz 2000. Part of it's grip seems broken along it's barrel, and it has cloth wrapped around it's stock and grip."
	ammo_type = list(/obj/item/ammo_casing/energy/thirty/hitscan)
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "hotwiredlaser"
	item_state = "hotwiredlaser"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)

/obj/item/gun/energy/laser/ultra_rifle
	name = "\improper Ultracite laser rifle"
	desc = "A sturdy and advanced military grade pre-war service laser rifle, now enhanced with ultracite"
	icon_state = "ultra_rifle"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/fifteen)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/energy/laser/scatter
	name = "tribeam laser rifle"
	desc = "A modified AER9 equipped with a refraction kit that divides the laser shot into three separate beams. While powerful, it has a reputation for friendly fire."
	icon_state = "tribeam"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/scatter/nonlethal
	name = "tribeam stunrifle"
	desc = "A modified AER9 equipped with a refraction kit that divides the laser shot into three separate beams. This one has its power consumption lowered, delivering only non-lethal strikes and charging faster."
	icon_state = "tribeam_nonlethal"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan/nonlethal)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/scatter/laserbuss
	name = "Laserbuss"
	desc = "A questionably-designed tribeam laser rifle that has been modified to feature a dense array of emitters and scatter lenses."
	icon_state = "tribeam"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/laserbuss)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/burst/five
	)

/obj/item/gun/energy/laser/aer12
	name = "\improper AER12 laser rifle"
	desc = "A cutting-edge, pre-war laser rifle. Its focusing crystal array is housed in gold alloy, making it difficult to maintain."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "aer12new"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/twenty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/three
	)

/obj/item/gun/energy/laser/aer14
	name = "\improper AER14 laser rifle"
	desc = "A bleeding-edge, pre-war laser rifle. Extremely powerful, but eats MFCs like nothing else."
	icon_state = "aer14"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/twentyfive/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/three
	)

/obj/item/gun/energy/laser/laer
	name = "\improper LAER"
	desc = "The Laser Assister Energy Rifle is a powerful pre-war weapon developed just before the turn of the Great War. Due to its incredible rarity and unprecedented firepower, the weapon is coveted and nearly solely possesed by the Brotherhood of Steel; typically held by an Elder as a status symbol."
	icon_state = "laer"
	item_state = "laer"
	ammo_type = list(/obj/item/ammo_casing/energy/twenty/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/laerequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/rcw
	name = "laser RCW"
	desc = "A rapid-fire laser rifle modeled after the familiar \"Thompson\" SMG. It features high-accuracy burst fire that will whittle down targets in a matter of seconds."
	icon_state = "lasercw"
	item_state = "rcw"
	ammo_type = list(/obj/item/ammo_casing/energy/ten/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)

/obj/item/gun/energy/laser/plasma/pistol/alien
	name = "alien blaster"
	item_state = "alienblaster"
	icon_state = "alienblaster"
	desc = "This weapon is unlike any other you've ever seen before, and appears to be made out of metals not usually found on Earth. It certainly packs a punch, though."
	can_charge = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/pistol/alien)
	cell_type = /obj/item/stock_parts/cell/ammo/alien //unchargeable, but removable
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/gammagun
	name = "Gamma gun"
	desc = "An advanced radiation weapon commonly utilized by people who have passionate hatred for their fellow man. Fires slow velocity, low damage radiation beams."
	icon_state = "gammagun"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/gammagun)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/pulse
	name = "Pulse Rifle"
	desc = "A sturdy, rapid fire laser weapon intended for special forces operations. Turns out tracers work both ways though, and it never gained popularity."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "pulse"
	item_state = "pulseDESTROY"
	ammo_type = list(/obj/item/ammo_casing/energy/twenty)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)
