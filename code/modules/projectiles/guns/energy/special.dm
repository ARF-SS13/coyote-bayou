/obj/item/gun/energy/ionrifle
	name = "YK-42b Pulse Rifle"
	desc = "The YK42B rifle is an electrical pulse weapon that was developed by the Yuma Flats Energy Consortium. It excels in damage against heavily armored opponents, especially power armor."
	icon_state = "ionrifle"
	inhand_icon_state = "ionrifle"	//so the human update icon uses the icon_state instead.
	can_flashlight = 1
	flags_1 =  CONDUCT_1
	ammo_type = list(/obj/item/ammo_casing/energy/ion)
	ammo_x_offset = 3
	flight_x_offset = 17
	flight_y_offset = 9
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = RIFLE_RECOIL(1.5, 1.5)

/obj/item/gun/energy/ionrifle/emp_act(severity)
	return

/obj/item/gun/energy/ionrifle/carbine
	name = "ion carbine"
	desc = "The MK.II Prototype Ion Projector is a lightweight carbine version of the larger ion rifle, built to be ergonomic and efficient."
	icon_state = "ioncarbine"
	inhand_icon_state = "ioncarbine4"
	ammo_type = list(/obj/item/ammo_casing/energy/ion/carbine)
	ammo_x_offset = 2
	flight_x_offset = 18
	flight_y_offset = 11
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	init_recoil = CARBINE_RECOIL(1.5, 1.5)

/obj/item/gun/energy/ionrifle/compact // needs a mob sprite assigned, 5/5/2023; this is intended to be a roundstart pistol in the same tier as the Wattz 1k pistol
	name = "pulse pistol"
	desc = "This weapon makes a continual and quiet hum, even when the power cell is removed. Written on the side is 'Type III Pulse Projector,' whatever that means."
	icon_state = "tesla"
	inhand_icon_state = "tesla"
	cell_type = /obj/item/stock_parts/cell/ammo/ecp // ECP has 20,000 charge, shot drain is 2000. This gives it 10 shots vs a rifle's 15.
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1.5, 1.5)

/obj/item/gun/energy/decloner
	name = "biological demolecularisor"
	desc = "A gun that discharges high amounts of controlled radiation to slowly break a target into component elements."
	icon_state = "decloner"
	ammo_type = list(/obj/item/ammo_casing/energy/declone)
	pin = null
	ammo_x_offset = 1
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY

/obj/item/gun/energy/decloner/update_overlays()
	..()
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	if(!QDELETED(cell) && (cell.charge > shot.e_cost))
		. += "decloner_spin"

/obj/item/gun/energy/floragun
	name = "floral somatoray"
	desc = "A tool that discharges controlled radiation which induces mutation in plant cells."
	icon_state = "flora"
	inhand_icon_state = "gun"
	ammo_type = list(/obj/item/ammo_casing/energy/flora/yield, /obj/item/ammo_casing/energy/flora/mut)
	modifystate = 1
	ammo_x_offset = 1
	selfcharge = EGUN_SELFCHARGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/meteorgun
	name = "meteor gun"
	desc = "For the love of god, make sure you're aiming this the right way!"
	icon_state = "meteor_gun"
	inhand_icon_state = "c20r"
	w_class = WEIGHT_CLASS_BULKY
	ammo_type = list(/obj/item/ammo_casing/energy/meteor)
	cell_type = "/obj/item/stock_parts/cell/potato"
	clumsy_check = 0 //Admin spawn only, might as well let clowns use it.
	selfcharge = EGUN_SELFCHARGE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/meteorgun/pen
	name = "meteor pen"
	desc = "The pen is mightier than the sword."
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pen"
	inhand_icon_state = "pen"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/mindflayer
	name = "\improper Mind Flayer"
	desc = "A prototype weapon recovered from the ruins of Research-Station Epsilon."
	icon_state = "xray"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/mindflayer)
	ammo_x_offset = 2
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/kinetic_accelerator/crossbow
	name = "small energy crossbow"
	desc = "An ancient classic brought into the modern era. This weapon fires bolts of plasma that not only sear with an intense heat, but also hamper the victim's senses."
	icon_state = "crossbow"
	inhand_icon_state = "crossbow"
	custom_materials = list(/datum/material/iron=2000)
	silenced = null
	ammo_type = list(/obj/item/ammo_casing/energy/bolt)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	w_class = WEIGHT_CLASS_SMALL
	can_remove = 0
	can_charge = 0
	obj_flags = 0
	overheat_time = 25 // 2.5 seconds
	holds_charge = TRUE
	unique_frequency = TRUE
	can_flashlight = 0
	max_mod_capacity = 0 // TG Kinetic Accelerator Mods
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	init_recoil = LASER_HANDGUN_RECOIL(2, 1)

/obj/item/gun/energy/kinetic_accelerator/crossbow/kisser
	name = "smoocher"
	desc = "A pair of lips, perfect for blowing kisses."
	icon_state = null
	inhand_icon_state = "kisser"
	force = 0
	force_unwielded = 0
	force_wielded = 0
	max_upgrades = 0 // I was sorely tempted to leave this at 1 for the meme.
	overheat_time = 40 // 4.0 seconds
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/smooch)
	fire_sound = 'sound/effects/kiss.ogg'
	init_recoil = LASER_HANDGUN_RECOIL(1, 1)

/obj/item/gun/energy/kinetic_accelerator/crossbow/sling
	name = "sling"
	desc = "A simple piece of leather, shaped to hold one rock, and hurl it at a target at high speed. Due to the abundance of stray stones and rubble, this weapon has effectively unlimited reloads."
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/sling)
	weapon_weight = GUN_ONE_HAND_ONLY
	w_class = WEIGHT_CLASS_TINY
	force = 5
	force_unwielded = 5
	force_wielded = 10
	throwforce = 5
	silenced = TRUE
	icon = 'modular_coyote/icons/objects/bows.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	icon_state = "sling"
	inhand_icon_state = "utility"
	pin = null
	no_pin_required = TRUE
	fire_sound = 'sound/weapons/punchmiss.ogg'
	init_recoil = LASER_HANDGUN_RECOIL(1.2, 1)

/obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff
	name = "sling staff"
	desc = "A simple piece of leather strapped to a staff allowing it greater damage both in melee and at range. Due to the abundance of stray stones and rubble, this weapon has effectively unlimited reloads."
	weapon_weight = GUN_TWO_HAND_ONLY
	w_class = WEIGHT_CLASS_NORMAL
	force = 25
	force_unwielded = 25
	force_wielded = 35
	throwforce = 25
	silenced = TRUE
	icon_state = "slingstaff"
	overheat_time = 40 // 4.0 seconds
	init_recoil = LASER_CARBINE_RECOIL(2, 1)
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/energy/kinetic_accelerator/crossbow/halloween
	name = "candy corn crossbow"
	desc = "A weapon favored by Syndicate trick-or-treaters."
	icon_state = "crossbow_halloween"
	inhand_icon_state = "crossbow"
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/halloween)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/kinetic_accelerator/crossbow/large
	name = "energy crossbow"
	desc = "An ancient classic brought into the modern era. This weapon fires intense bolts of plasma that not only sear with an intense heat, but also hamper the victim's senses."
	icon_state = "crossbowlarge"
	custom_materials = list(/datum/material/iron=4000)
	silenced = null
	ammo_type = list(/obj/item/ammo_casing/energy/bolt/large)
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	w_class = WEIGHT_CLASS_BULKY
	overheat_time = 35 // 3.5 seconds
	init_recoil = LASER_CARBINE_RECOIL(2, 1)
//	pin = null
//	unique_frequency = FALSE

/obj/item/gun/energy/plasmacutter
	name = "plasma cutter"
	desc = "A mining tool capable of expelling concentrated plasma bursts. You could use it to cut limbs off xenos! Or, you know, mine stuff."
	icon_state = "plasmacutter"
	inhand_icon_state = "plasmacutter"
	ammo_type = list(/obj/item/ammo_casing/energy/miningplasma)
	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "slashed", "cut", "sliced")
	force = 12
	sharpness = SHARP_EDGED
	can_charge = 0
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	heat = 3800
	usesound = list('sound/items/welder.ogg', 'sound/items/welder2.ogg')
	tool_behaviour = TOOL_WELDER
	toolspeed = 0.7 //plasmacutters can be used as welders, and are faster than standard welders

/obj/item/gun/energy/plasmacutter/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 25, 105, 0, 'sound/weapons/plasma_cutter.ogg')
	AddElement(/datum/element/update_icon_blocker)

/obj/item/gun/energy/plasmacutter/examine(mob/user)
	. = ..()
	if(cell)
		. += span_notice("[src] is [round(cell.percent())]% charged.")

/obj/item/gun/energy/plasmacutter/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/stack/sheet/mineral/plasma))
		I.use(1)
		cell.give(1000)
		to_chat(user, span_notice("You insert [I] in [src], recharging it."))
	else if(istype(I, /obj/item/stack/ore/plasma))
		I.use(1)
		cell.give(500)
		to_chat(user, span_notice("You insert [I] in [src], recharging it."))
	else
		..()

// Tool procs, in case plasma cutter is used as welder
/obj/item/gun/energy/plasmacutter/tool_use_check(mob/living/user, amount)
	if(!QDELETED(cell) && (cell.charge >= amount * 100))
		return TRUE

	to_chat(user, span_warning("You need more charge to complete this task!"))
	return FALSE

/obj/item/gun/energy/plasmacutter/use(amount)
	return cell.use(amount * 100)

/obj/item/gun/energy/plasmacutter/use_tool(atom/target, mob/living/user, delay, amount=1, volume=0, datum/callback/extra_checks, skill_gain_mult = STD_USE_TOOL_MULT)

	if(amount)
		target.add_overlay(GLOB.welding_sparks)
		. = ..()
		target.cut_overlay(GLOB.welding_sparks)
	else
		. = ..(amount=1)

/obj/item/gun/energy/plasmacutter/adv
	name = "advanced plasma cutter"
	icon_state = "adv_plasmacutter"
	force = 15
	ammo_type = list(/obj/item/ammo_casing/energy/plasma/adv)

/obj/item/gun/energy/wormhole_projector
	name = "bluespace wormhole projector"
	desc = "A projector that emits high density quantum-coupled bluespace beams."
	ammo_type = list(/obj/item/ammo_casing/energy/wormhole, /obj/item/ammo_casing/energy/wormhole/orange)
	inhand_icon_state = null
	icon_state = "wormhole_projector"
	pin = null
	automatic_charge_overlays = FALSE
	var/obj/effect/portal/p_blue
	var/obj/effect/portal/p_orange
	var/atmos_link = FALSE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/wormhole_projector/update_icon_state()
	icon_state = "[initial(icon_state)][current_firemode_index]"
	inhand_icon_state = icon_state

/obj/item/gun/energy/wormhole_projector/update_ammo_types()
	. = ..()
	for(var/i in 1 to ammo_type.len)
		var/obj/item/ammo_casing/energy/wormhole/W = ammo_type[i]
		if(istype(W))
			W.gun = src
			var/obj/item/projectile/beam/wormhole/WH = W.BB
			if(istype(WH))
				WH.gun = src

/obj/item/gun/energy/wormhole_projector/process_chamber()
	..()
	select_fire()

/obj/item/gun/energy/wormhole_projector/proc/on_portal_destroy(obj/effect/portal/P)
	if(P == p_blue)
		p_blue = null
	else if(P == p_orange)
		p_orange = null

/obj/item/gun/energy/wormhole_projector/proc/has_blue_portal()
	if(istype(p_blue) && !QDELETED(p_blue))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/has_orange_portal()
	if(istype(p_orange) && !QDELETED(p_orange))
		return TRUE
	return FALSE

/obj/item/gun/energy/wormhole_projector/proc/crosslink()
	if(!has_blue_portal() && !has_orange_portal())
		return
	if(!has_blue_portal() && has_orange_portal())
		p_orange.link_portal(null)
		return
	if(!has_orange_portal() && has_blue_portal())
		p_blue.link_portal(null)
		return
	p_orange.link_portal(p_blue)
	p_blue.link_portal(p_orange)

/obj/item/gun/energy/wormhole_projector/proc/create_portal(obj/item/projectile/beam/wormhole/W, turf/target)
	var/obj/effect/portal/P = new /obj/effect/portal(target, src, 300, null, FALSE, null, atmos_link)
	if(istype(W, /obj/item/projectile/beam/wormhole/orange))
		qdel(p_orange)
		p_orange = P
		P.icon_state = "portal1"
	else
		qdel(p_blue)
		p_blue = P
	crosslink()

/* 3d printer 'pseudo guns' for borgs */

/obj/item/gun/energy/printer
	name = "cyborg lmg"
	desc = "A LMG that fires 3D-printed flechettes. They are slowly resupplied using the cyborg's internal power source."
	icon_state = "l6closed0"
	icon = 'icons/obj/guns/projectile.dmi'
	cell_type = "/obj/item/stock_parts/cell/secborg"
	ammo_type = list(/obj/item/ammo_casing/energy/c3dbullet)
	can_charge = 0
	use_cyborg_cell = 1
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/printer/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/gun/energy/printer/emp_act()
	return

/obj/item/gun/energy/temperature
	name = "temperature gun"
	icon_state = "freezegun"
	desc = "A gun that changes temperatures."
	ammo_type = list(/obj/item/ammo_casing/energy/temp, /obj/item/ammo_casing/energy/temp/hot)
	cell_type = "/obj/item/stock_parts/cell/high"
	pin = null
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/temperature/security
	name = "security temperature gun"
	desc = "A weapon that can only be used to its full potential by the truly robust."
	pin = /obj/item/firing_pin
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/instakill
	name = "instakill rifle"
	icon_state = "instagib"
	inhand_icon_state = "instagib"
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit."
	ammo_type = list(/obj/item/ammo_casing/energy/instakill)
	force = 60
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/instakill/red
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a red design."
	icon_state = "instagibred"
	inhand_icon_state = "instagibred"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/red)
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/instakill/blue
	desc = "A specialized ASMD laser-rifle, capable of flat-out disintegrating most targets in a single hit. This one has a blue design."
	icon_state = "instagibblue"
	inhand_icon_state = "instagibblue"
	ammo_type = list(/obj/item/ammo_casing/energy/instakill/blue)
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/laser/instakill/emp_act() //implying you could stop the instagib
	return

/obj/item/gun/energy/gravity_gun
	name = "one-point bluespace-gravitational manipulator"
	desc = "An experimental, multi-mode device that fires bolts of Zero-Point Energy, causing local distortions in gravity."
	ammo_type = list(/obj/item/ammo_casing/energy/gravity/repulse, /obj/item/ammo_casing/energy/gravity/attract, /obj/item/ammo_casing/energy/gravity/chaos)
	inhand_icon_state = "gravity_gun"
	icon_state = "gravity_gun"
	pin = null
	var/power = 4
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/gravity_gun/security
	pin = /obj/item/firing_pin

//Emitter Gun

/obj/item/gun/energy/emitter
	name = "Emitter Carbine"
	desc = "A small emitter fitted into a handgun case, do to size constraints and safety it can only shoot about ten times when fully charged."
	icon_state = "emitter_carbine"
	force = 12
	w_class = WEIGHT_CLASS_SMALL
	cell_type = /obj/item/stock_parts/cell/super
	ammo_type = list(/obj/item/ammo_casing/energy/emitter)
	automatic_charge_overlays = FALSE
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/energy/emitter/update_icon_state()
	var/obj/item/ammo_casing/energy/shot = ammo_type[current_firemode_index]
	if(!QDELETED(cell) && (cell.charge > shot.e_cost))
		icon_state = "emitter_carbine_empty"
	else
		icon_state = "emitter_carbine"

//the pickle ray
/obj/item/gun/energy/pickle_gun
	name = "pickle ray"
	desc = "funniest shit i've ever seen"
	icon_state = "decloner"
	no_pin_required = TRUE
	ammo_type = list(/obj/item/ammo_casing/energy/pickle)
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
