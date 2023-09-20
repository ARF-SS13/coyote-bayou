//Fallout


/obj/item/gun/energy/laser
	name = "energy weapon template"
	desc = "Should not exists. Bugreport."
	icon_state = "laser"
	item_state = "laser"
	custom_materials = list(/datum/material/iron=2000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun)
	ammo_x_offset = 1
	shaded_charge = 1
	var/select = 1
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/energy/laser/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/stock_parts/cell/ammo))
		var/obj/item/stock_parts/cell/ammo/AM = A
		if(istype(AM, cell_type))
			var/obj/item/stock_parts/cell/ammo/oldcell = cell
			if(user.transferItemToLoc(AM, src))
				cell = AM
				if(oldcell)
					to_chat(user, span_notice("You perform a tactical reload on \the [src], replacing the cell."))
					oldcell.dropped()
					oldcell.forceMove(get_turf(src.loc))
					oldcell.update_icon()
				//else
				//	to_chat(user, span_notice("You insert the cell into \the [src]."))

				//playsound(src, 'sound/weapons/autoguninsert.ogg', 60, TRUE)
				//chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, span_warning("You cannot seem to get \the [src] out of your hands!"))

/obj/item/gun/energy/laser/practice
	name = "practice laser gun"
	icon_state = "laser-p"
	desc = "A modified version of the basic laser gun, this one fires less concentrated energy bolts designed for target practice."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY

	ammo_type = list(/obj/item/ammo_casing/energy/laser/practice)
	clumsy_check = 0
	item_flags = NONE

/obj/item/gun/energy/laser/practice/hyperburst
	name = "toy hyper-burst launcher"
	desc = "A toy laser with a unique beam shaping lens that projects harmless bolts capable of going through objects. Compatible with existing laser tag systems."
	icon_state = "toyburst"
	w_class = WEIGHT_CLASS_HUGE
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	selfcharge = EGUN_SELFCHARGE
	ammo_type = list(/obj/item/ammo_casing/energy/laser/magtag)
	charge_delay = 2
	cell_type = /obj/item/stock_parts/cell/toymagburst

/obj/item/gun/energy/laser/retro //lets see if these changes don't break horribly
	name ="retro laser gun"
	icon_state = "retro"
	desc = "A compact laser gun in a stylish old Design. its smooth edges make it perfect for fitting in a boot."
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/retro)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/captain
	name = "antique laser gun"
	icon_state = "caplaser"
	item_state = "caplaser"
	desc = "This is an antique laser gun. All craftsmanship is of the highest quality. It is decorated with assistant leather and chrome. The object menaces with spikes of energy. On the item is an image of Space Station 13. The station is exploding."
	force = 10
	ammo_x_offset = 3
	selfcharge = EGUN_SELFCHARGE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/cyborg
	name = "integrated AER9"
	can_charge = FALSE
	desc = "An energy-based laser gun that draws power from the Handy's internal energy cell directly. So this is what freedom looks like?"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun/hitscan)
	icon_state = "laser"
	item_state = "laser-rifle9"
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/cyborg/emp_act()
	return

/obj/item/gun/energy/laser/cyborg/mean
	use_cyborg_cell = TRUE
	selfcharge = EGUN_NO_SELFCHARGE

/*this shares a path with the tribeam laser

/obj/item/gun/energy/laser/scatter
	name = "scatter laser gun"
	desc = "A laser gun equipped with a refraction kit that spreads bolts."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter, /obj/item/ammo_casing/energy/laser)

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_NORMAL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

*/

//Laser Cannon
/obj/item/gun/energy/lasercannon
	name = "accelerator laser cannon"
	desc = "An advanced laser cannon that does more damage the farther away the target is."
	icon_state = "lasercannon"
	item_state = "laser"
	flags_1 =  CONDUCT_1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/accelerator)
	pin = null
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
/obj/item/ammo_casing/energy/laser/accelerator
	projectile_type = /obj/item/projectile/beam/laser/accelerator
	select_name = "accelerator"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/projectile/beam/laser/accelerator
	name = "accelerator laser"
	icon_state = "scatterlaser"
	range = 255
	damage = 6

/obj/item/projectile/beam/laser/accelerator/Range()
	..()
	damage += 7
	transform *= 1 + ((damage/7) * 0.2)//20% larger per tile

/obj/item/gun/energy/xray
	name = "\improper X-ray laser gun"
	desc = "A high-power laser gun capable of expelling concentrated X-ray blasts that pass through multiple soft targets and heavier materials."
	icon_state = "xray"
	item_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/xray)
	pin = null
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
////////Laser Tag////////////////////

/obj/item/gun/energy/laser/bluetag
	name = "laser tag gun"
	icon_state = "bluetag"
	desc = "A retro laser gun modified to fire harmless blue beams of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/blue
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/bluetag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/bluetag/hitscan)

/obj/item/gun/energy/laser/redtag
	name = "laser tag gun"
	icon_state = "redtag"
	desc = "A retro laser gun modified to fire harmless beams red of light. Sound effects included!"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag)
	item_flags = NONE
	clumsy_check = FALSE
	pin = /obj/item/firing_pin/tag/red
	ammo_x_offset = 2
	selfcharge = EGUN_SELFCHARGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/redtag/hitscan
	ammo_type = list(/obj/item/ammo_casing/energy/laser/redtag/hitscan)




/////////////////
//LASER PISTOLS//
/////////////////


//Wattz 1000 Laser pistol
/obj/item/gun/energy/laser/wattz
	name = "Wattz 1000 laser pistol"
	desc = "A Wattz 1000 Laser Pistol. Civilian model of the AEP7. Its capacity is cut by half per cell, and doesn't shoot as fast, but has more powerful beams. Uses small energy cells."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "wattz1000"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattz)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

//Wattz 1000 smart-laser pistol
/obj/item/gun/energy/laser/wattz/magneto
	name = "Wattz 1000 smart-laser pistol"
	desc = "This Wattz 1000 has been modified with a 'smart' free-floating magnetic aperture, capable of compensating for the user's \
			movement and firing position, effectively ensuring that each shot goes exactly where the gun is pointed. Uses small energy cells."
	icon_state = "magnetowattz"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	added_spread = -100
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	init_recoil = LASER_HANDGUN_RECOIL_RARE(1, 1)

//Wattz 1000s Laser pistol
/obj/item/gun/energy/laser/wattzs
	name = "Wattz 1000s laser pistol"
	desc = "The Wattz 1000 Sports Edition was designed as a direct competitor to the AEP7, boasting an optimized emitter that greatly increases cell efficiency."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "wattz1000s"
	item_state = "laser-pistol"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/wattzs)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

//Recharger Pistol
/obj/item/gun/energy/laser/wattz/recharger
	name = "Recharger Pistol"
	desc = "A recharger pistol manufactured by the Followers of the Apocalpyse. As the name implied, it charges its capacitor banks over time using radioactive decay."
	can_remove = 0
	can_charge = 0
	selfcharge = 1
	icon_state = "rechargerpistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/recharger/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/breeder
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	init_recoil = LASER_HANDGUN_RECOIL(2, 1)

//AEP 7 Laser pistol
/obj/item/gun/energy/laser/pistol
	name = "\improper AEP7 laser pistol"
	desc = "A basic energy-based laser gun that fires concentrated beams of light. Military version of the Wattz-1000. Quicker-firing, armor-penetrating, with slightly less damage, and far more efficiency."
	icon_state = "AEP7"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 7
	scope_y_offset = 22
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

// starter kit havin ass
/obj/item/gun/energy/laser/pistol/worn
	name = "\improper worn AEP7 laser pistol"
	desc = "A basic energy-based laser gun that fires concentrated beams of light. Military version of the Wattz-1000. This one seems a bit scuffy, a couple frayed wires, there's some strange metalic taste if you press the barrel against your cheek."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan/worn)

// Debug laser pistol that does 10 damage and 0 DT piercing
/obj/item/gun/energy/laser/pistol/debug_10_damage_0_dt_pierce
	name = "\improper Debug laser pistol that does 10 damage and 0 DT piercing"
	desc = "im testing mobs lol"
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_0_dt_pierce)

// Debug laser pistol that does 10 damage and 10 DT piercing
/obj/item/gun/energy/laser/pistol/debug_10_damage_10_dt_pierce
	name = "\improper Debug laser pistol that does 10 damage and 10 DT piercing"
	desc = "im testing mobs lol"
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_10_dt_pierce)

// Debug laser pistol that does 10 damage and 0 DT piercing an d 50 AP
/obj/item/gun/energy/laser/pistol/debug_10_damage_0_dt_pierce_50_ap
	name = "\improper Debug laser pistol that does 10 damage and 0 DT piercing and 50 AP (its a laser btw)"
	desc = "im testing mobs lol"
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_0_dt_pierce_50_ap)

// Debug laser pistol that does 10 damage and 10 DT piercing an d 50 AP
/obj/item/gun/energy/laser/pistol/debug_10_damage_0_dt_pierce_50_ap
	name = "\improper Debug laser pistol that does 10 damage and 10 DT piercing and 50 AP (its a laser btw)"
	desc = "im testing mobs lol"
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_10_dt_pierce_50_ap)

/obj/item/gun/energy/laser/pistol/cyborg
	name = "\improper assaultron AEP7 laser eye"
	desc = "A basic energy-based laser projector that fires concentrated beams of light from your eye! It draws power from your cell so try not to go crazy."
	can_scope = FALSE
	can_charge = FALSE
	selfcharge = EGUN_SELFCHARGE_BORG
	cell_type = /obj/item/stock_parts/cell/secborg
	charge_delay = 3
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
/obj/item/gun/energy/laser/pistol/cyborg/gutsy
	name = "\improper integrated laser pistol"
	desc = "An integrated laser pistol that draws power directly from your cell."

//Compliance Regulator

/obj/item/gun/energy/laser/complianceregulator
	name = "AEP5-CR Disabling Beam Pistol"
	desc = "A laser pistol that has been modified for less-than-lethal work."
	slowdown = 0.2
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
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

//Solar Scorcher
/obj/item/gun/energy/laser/solar
	name = "\improper Solar Scorcher"
	slowdown = 0.2
	desc = "This modified AEP7 laser pistol takes its power from the sun, recharging slowly using stored solar energy. However, it cannot be recharged manually as a result."
	icon_state = "solarscorcher"
	item_state = "solarscorcher"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/solar/hitscan) //27 dmg, .15 AP
	cell_type = /obj/item/stock_parts/cell/ammo/ultracite //16 shots, self-charges
	can_charge = 0
	selfcharge = 1 //selfcharging adds 100 a shot
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'

	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

//Badland's Special
/obj/item/gun/energy/laser/badlands
	name = "\improper Badland's Special"
	slowdown = 0.2
	desc = "A jury-rigged AEP7, this pistol carves out every safety feature and shortens the lenses length to cram a second emitter inside."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "bspecial"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/badlands)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO

//Worn Badland's Special
/obj/item/gun/energy/laser/badlands/worn
	name = "\improper Worn Badland's Special"
	slowdown = 0.2
	desc = "A jury-rigged AEP7, this pistol carves out every safety feature and shortens the lenses length to cram a second emitter inside. This ones seems aged."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "bspecial"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/badlands/worn)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO

//Freeblade Blaster
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
	init_recoil = LASER_HANDGUN_RECOIL(2, 1)

//Compact RCW

/obj/item/gun/energy/laser/auto
	name = "compact RCW"
	desc = "A beefed-up laser pistol manufactured by West Tek, reinforced to allow it to withstand the thermal load of sustained fire."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "protolaser"
	item_state = "laser"
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	ammo_type =  list(/obj/item/ammo_casing/energy/laser/autolaser) //5dmg, 0.4 AP, good for fast firings.
	can_scope = FALSE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)
	init_recoil = LASER_SMG_RECOIL(1, 1)

/obj/item/gun/energy/laser/auto/twin
	name = "twin-shot RCW carbine"
	desc = "Made by Lone Star Armories, this variant of the compact RCW ironically fires two star-shaped laser blasts in quick succession."
	icon_state = "export_cannon"
	ammo_type =  list(/obj/item/ammo_casing/energy/laser/autolaser/twinshot) // 1200 damage per cell vs Tesla Autoshock's 1196
	init_firemodes = list(
		/datum/firemode/burst/two/fastest
	)

//Worn compact RCW
/obj/item/gun/energy/laser/auto/worn
	name = "worn compact rcw"
	desc = "A much more compact version of the RCW. Attuned to pierce through most armor with ease, while also being more streamlined."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "protolaser"
	item_state = "laser"
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	ammo_type =  list(/obj/item/ammo_casing/energy/laser/autolaser/worn) //5dmg, 0.4 AP, good for fast firings.
	can_scope = FALSE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	init_recoil = LASER_SMG_RECOIL(2, 2)

/obj/item/gun/energy/laser/auto/nayriin
	name = "Lucy"
	desc = "This RCW stands out from most others in the wastes, clearly having had loving hands maintaining it over the course of years. Despite this maintenance, the weapon looks worse for wear featuring a warped, heat stressed barrel. It's polished wooden stock has a Vault-Tec logo in the center of it, with Vault 60 written above it, both being gold inlays. The name Lucy is written in the same gold inlay at the bottom, with the name Cyl carefully carved next to it."
	icon_state = "lasercw"
	item_state = "rcw"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/autolaser/worn)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)

// OASIS autolaser
/obj/item/gun/energy/laser/auto/oasis
	name = "autoshock tesla pistol"
	desc = " An upgraded version of the Compact RCW. Boasts a higher cell efficiency at the cost of the burstfire and armor melting power."
	ammo_type =  list(/obj/item/ammo_casing/energy/laser/autolaser/shock) //8dmg + 10 Stamina, flagged as "energy" so very few armors can reduce it below 5-6 dmg, has a very high bare wound bonus, so anyone with no armor on will be crippled
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/fastest
	)
	init_recoil = LASER_SMG_RECOIL(1, 1)

//Ultracite Laser pistol
/obj/item/gun/energy/laser/ultra_pistol
	name = "\improper Ultracite laser pistol"
	desc = "An ultracite enhanced energy-based laser gun that fires concentrated beams of light."
	icon_state = "ultra_pistol"
	item_state = "laser-pistol"
	scope_x_offset = 7
	scope_y_offset = 22
	ammo_type = list(/obj/item/ammo_casing/energy/laser/ultra_pistol)
	cell_type = /obj/item/stock_parts/cell/ammo/ec
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

// The Synth's Lasergun
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
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

////////////////
//LASER RIFLES//
////////////////


//Wattz 2000 Laser rifle
/obj/item/gun/energy/laser/wattz2k
	name = "wattz 2000"
	desc = "Wattz 2000 Laser Rifle. Uses micro fusion cells for more powerful lasers, and an extended barrel for additional range."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "wattz2k"
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/wattz2k/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
//Wattz 2000 Extended
/obj/item/gun/energy/laser/wattz2k/extended
	name = "wattz 2000e"
	desc = "This Wattz 2000 laser rifle has had its recharging system upgraded and a special recycling chip installed that reduces the drain on the micro fusion cell by 50%."
	icon_state = "wattz2k_ext"
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/wattz2k/extended/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
//Wattz 2000s Laser rifle
/obj/item/gun/energy/laser/wattz2ks
	name = "wattz 2000s"
	desc = "The Postwar Unicorn of laser rifles, The Wattz 2000 Sports Edition was designed for professional hunting - featuring a state-of-the-art self-charging system that has still endured two hundred years later."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "wattz2ks"
	item_state = "sniper_rifle"
	ammo_type = list(/obj/item/ammo_casing/energy/wattz2ks/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ultracite
	can_scope = FALSE
	zoom_factor = 1
	can_charge = 0
	selfcharge = 1
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/energy/laser/LaserAK/worn
	name = "Laser AK470M"
	desc = "An AK470 that was rebuilt with spare parts found around the wastes."
	icon_state = "LaserAK"
	item_state = null
	icon = 'modular_citadel/icons/obj/guns/VGguns.dmi'
	cell_type = "/obj/item/stock_parts/cell/ammo/mfc"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/AK470M)
	ammo_x_offset = 4
	lefthand_file = 'modular_citadel/icons/mob/citadel/guns_lefthand.dmi'
	righthand_file = 'modular_citadel/icons/mob/citadel/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
	/datum/firemode/semi_auto,
	/datum/firemode/automatic/rpm300
	)
	init_recoil = LASER_AUTORIFLE_RECOIL(1, 1)

//AER9 Laser rifle
/obj/item/gun/energy/laser/aer9
	name = "\improper AER9 laser rifle"
	desc = "A sturdy pre-war laser rifle. Emits beams of concentrated light to kill targets. Fast firing, but not very powerful."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "laser"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	fire_delay = 1
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	init_recoil = LASER_CARBINE_RECOIL(1, 1)

/obj/item/gun/energy/laser/aer9/focused
	name = "\improper Hot-wired AER9 laser rifle"
	desc = "A sturdy pre-war laser rifle. Emits beams of concentrated light to kill targets. This one has been jury-rigged against common sense to dump more power into its shots."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun/hitscan/focused)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)

/obj/item/gun/energy/laser/aer9/focused/rynn
	name = "\improper Hot-wired AER10 laser rifle"
	desc = "A pre-war laser rifle prototype that has seen better day, known as a failed attempt at competing with the wattz 2000. Part of it's grip seems broken along it's barrel, and it has cloth wrapped around it's stock and grip."
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun/hitscan/focused)
	icon = 'icons/fallout/objects/guns/energy.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "hotwiredlaser"
	item_state = "hotwiredlaser"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/burst/two/slow
	)

//Ultracite Laser rifle
/obj/item/gun/energy/laser/ultra_rifle
	name = "\improper Ultracite laser rifle"
	desc = "A sturdy and advanced military grade pre-war service laser rifle, now enhanced with ultracite"
	icon_state = "ultra_rifle"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/lasgun)
	cell_type = /obj/item/stock_parts/cell/ammo/ultracite
	can_scope = FALSE
	zoom_factor = 1
	equipsound = 'sound/f13weapons/equipsounds/aer9equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//Tribeam Laser rifle
/obj/item/gun/energy/laser/scatter //this needs higher spread
	name = "tribeam laser rifle"
	desc = "A modified AER9 equipped with a refraction kit that divides the laser shot into three separate beams. While powerful, it has a reputation for friendly fire."
	icon_state = "tribeam"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	init_recoil = LASER_CARBINE_RECOIL(1, 1)

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
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
/obj/item/gun/energy/laser/scatter/laserbuss
	name = "Laserbuss"
	desc = "A questionably-designed tribeam laser rifle that has been modified to feature a dense array of emitters and scatter lenses."
	icon_state = "tribeam"
	item_state = "laser-rifle9"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/scatter/tribeam/laserbuss/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

//AER12 Laser rifle
/obj/item/gun/energy/laser/aer12
	name = "\improper AER12 laser rifle"
	desc = "A cutting-edge, pre-war laser rifle. Its focusing crystal array is housed in gold alloy, making it difficult to maintain."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "aer12new"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/aer12/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/tribeamequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//AER14 Laser rifle
/obj/item/gun/energy/laser/aer14
	name = "\improper AER14 laser rifle"
	desc = "A bleeding-edge, pre-war laser rifle. A little more powerful than the previous model AER."
	icon_state = "aer14"
	item_state = "aer12new"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/aer14/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	scope_state = "AEP7_scope"
	scope_x_offset = 12
	scope_y_offset = 20
	equipsound = 'sound/f13weapons/equipsounds/aer14equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//LAER Energy rifle
/obj/item/gun/energy/laser/laer
	name = "\improper LAER"
	desc = "The Laser Assister Energy Rifle is a powerful pre-war weapon developed just before the turn of the Great War. Due to its incredible rarity and unprecedented firepower, the weapon is coveted and nearly solely possesed by the Brotherhood of Steel; typically held by an Elder as a status symbol."
	icon_state = "laer"
	item_state = "laer"
	ammo_type = list(/obj/item/ammo_casing/energy/laser/laer/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	equipsound = 'sound/f13weapons/equipsounds/laerequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//Fallout 4 laser tommy gun.
/obj/item/gun/energy/laser/rcw
	name = "laser RCW"
	desc = "A rapid-fire laser rifle modeled after the familiar \"Thompson\" SMG. It features high-accuracy burst fire that will whittle down targets in a matter of seconds."
	icon_state = "lasercw"
	item_state = "rcw"
	automatic = 1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/rcw/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/slow
	)
	init_recoil = LASER_AUTORIFLE_RECOIL(1, 1)

/obj/item/gun/energy/laser/stunrcw
	name = "Disabler RCW"
	desc = "A rapid-fire laser rifle modeled after the familiar \"Thompson\" SMG. It features high-accuracy burst fire that will whittle down targets in a matter of seconds. This one seems to be modified with special capacitors that make it non lethal!"
	icon_state = "disablerrcw"
	item_state = "rcw"
	automatic = 1
	ammo_type = list(/obj/item/ammo_casing/energy/laser/stunrcw)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	equipsound = 'sound/f13weapons/equipsounds/RCWequip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/slow
	)
	init_recoil = LASER_AUTORIFLE_RECOIL(1, 1)

//Alien Blaster
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
//Gamma gun
/obj/item/gun/energy/gammagun
	name = "Gamma gun"
	desc = "An advanced radiation weapon commonly utilized by people who have passionate hatred for their fellow man. Fires slow velocity, low damage radiation beams."
	icon_state = "ultra_pistol"
	item_state = "laser-pistol"
	ammo_type = list(/obj/item/ammo_casing/energy/gammagun)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc
	ammo_x_offset = 3
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

//Gatling Laser


//The ammo/gun is stored in a back slot item
/obj/item/minigunpack
	name = "backpack power source"
	desc = "The massive external power source for the laser gatling gun."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "holstered"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = INV_SLOTBIT_BACK
	w_class = WEIGHT_CLASS_HUGE
	var/obj/item/gun/energy/minigun/gun
	var/armed = 0 //whether the gun is attached, 0 is attached, 1 is the gun is wielded.

/obj/item/minigunpack/Initialize()
	. = ..()
	gun = new(src)
	START_PROCESSING(SSobj, src)

/obj/item/minigunpack/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/minigunpack/on_attack_hand(mob/living/carbon/user)
	if(src.loc == user)
		if(!armed)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				armed = 1
				if(!user.put_in_hands(gun))
					armed = 0
					to_chat(user, span_warning("You need a free hand to hold the gun!"))
					return
				update_icon()
				user.update_inv_back()
		else
			to_chat(user, span_warning("You are already holding the gun!"))
	else
		..()

/obj/item/minigunpack/attackby(obj/item/W, mob/user, params)
	if(W == gun) //Don't need armed check, because if you have the gun assume its armed.
		user.dropItemToGround(gun, TRUE)
	else
		..()

/obj/item/minigunpack/dropped(mob/user)
	. = ..()
	if(armed)
		user.dropItemToGround(gun, TRUE)

/obj/item/minigunpack/MouseDrop(atom/over_object)
	. = ..()
	if(armed)
		return
	if(iscarbon(usr))
		var/mob/M = usr

		if(!over_object)
			return

		if(!M.incapacitated())

			if(istype(over_object, /obj/screen/inventory/hand))
				var/obj/screen/inventory/hand/H = over_object
				M.putItemFromInventoryInHandIfPossible(src, H.held_index)


/obj/item/minigunpack/update_icon_state()
	if(armed)
		icon_state = "notholstered"
	else
		icon_state = "holstered"

/obj/item/minigunpack/proc/attach_gun(mob/user)
	if(!gun)
		gun = new(src)
	gun.forceMove(src)
	armed = 0
	if(user)
		to_chat(user, span_notice("You attach the [gun.name] to the [name]."))
	else
		src.visible_message(span_warning("The [gun.name] snaps back onto the [name]!"))
	update_icon()
	user.update_inv_back()

/obj/item/gun/energy/minigun
	name = "laser gatling gun"
	desc = "An advanced laser cannon with an incredible rate of fire. Requires a bulky backpack power source to use."
	icon = 'icons/obj/guns/minigun.dmi'
	icon_state = "minigun_spin"
	item_state = "minigun"
	flags_1 = CONDUCT_1
	slot_flags = null
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = null
	fire_sound = 'sound/weapons/laser.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/laser/gatling/hitscan)
	cell_type = /obj/item/stock_parts/cell/ammo/ecp
	item_flags = NEEDS_PERMIT | SLOWS_WHILE_IN_HAND
	var/obj/item/minigunpack/ammo_pack
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)
	init_recoil = HMG_RECOIL(1, 1)

/obj/item/gun/energy/minigun/Initialize()
	if(istype(loc, /obj/item/minigunpack)) //We should spawn inside an ammo pack so let's use that one.
		ammo_pack = loc
	else
		return INITIALIZE_HINT_QDEL //No pack, no gun

	return ..()

/obj/item/gun/energy/minigun/attack_self(mob/living/user)
	return

/obj/item/gun/energy/minigun/dropped(mob/user)
	. = ..()
	if(ammo_pack)
		ammo_pack.attach_gun(user)
	else
		qdel(src)

/obj/item/gun/energy/minigun/afterattack(atom/target, mob/living/user, flag, params)
	if(!ammo_pack || ammo_pack.loc != user)
		to_chat(user, "You need the backpack power source to fire the gun!")
	. = ..()

/obj/item/gun/energy/minigun/dropped(mob/living/user)
	. = ..()
	ammo_pack.attach_gun(user)


//// BETA /// Obsolete
/obj/item/gun/energy/laser/lasertesting
	ammo_type = list(/obj/item/ammo_casing/energy/laser/pistol/lasertest)
