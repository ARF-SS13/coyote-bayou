//-->laser guns that have a dynamo to recharge
//<--

/obj/item/gun
	var/recharge_queued = 1


/obj/item/gun/energy/laser/cranklasergun
	name = "energy dynamo cranked weapon template"
	desc = "Should not exists. Bugreport."
	icon_state = "laser"
	item_state = "laser"
	allow_ui_interact = FALSE  //this variable must stay false to all cranklaserguns
	var/cranking_time = 1 SECONDS
	var/list/sound = list(
		'sound/effects/dynamo_crank/dynamo_crank.mp3',
	)
	dead_cell = TRUE
	custom_materials = list(/datum/material/iron=2000)
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun)
	ammo_x_offset = 1
	shaded_charge = 1
	can_remove = 0 // Can you remove the cell? 
	can_charge = 0 // Can you put it in a Weapon Recharger?
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
////////////////////////////////////////////////////////////////

//-->regular cranklaser cell
/obj/item/stock_parts/cell/ammo/mfc/cranklasergun  //basically a single shot charge
	name = "integrated single charge cell"
	desc = "An integrated single charge cell, typically used as fast discharge power bank for energy weapons."
	icon = 'icons/fallout/objects/powercells.dmi'
	icon_state = "mfc-full"
	maxcharge = 1


/obj/item/ammo_casing/energy/cranklasergun
	projectile_type = /obj/item/projectile/beam/laser/cranklasergun
	e_cost = 1
	select_name = "kill"


/obj/item/projectile/beam/laser/cranklasergun
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE| PASSGLASS
	damage = 60
	light_range = 2
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED
	ricochets_max = 50	//Honk!
	ricochet_chance = 0
	is_reflectable = TRUE
	wound_bonus = -30
	bare_wound_bonus = 40
	recoil = BULLET_RECOIL_LASER
////////////////////////////////////////////////////////////////

//-->Gun mechanics
/obj/item/gun/energy/attack_self(mob/living/user)
	. = ..()
	//we have to check if the gun is a cranklasergun type, otherwise ignore it
	if(istype(src, /obj/item/gun/energy/laser/cranklasergun))
		var/obj/item/gun/energy/laser/cranklasergun/firearm = src
		var/obj/item/stock_parts/cell/C = src.get_cell()
		
		if((C.charge < C.maxcharge) && (!recharge_queued))
			recharge_queued = 1
			playsound(user.loc, pick(firearm.sound), 50, TRUE)
			if(do_after(user, firearm.cranking_time, target = src, allow_movement = TRUE))
				recharge_queued = 0
				C.charge += 1
				update_icon()
			else
				recharge_queued = 0


/obj/item/gun/shoot_live_shot(mob/living/user)
	. = ..()
	//we have to check if the gun is a cranklasergun type, otherwise ignore it
	if(istype(src, /obj/item/gun/energy/laser/cranklasergun))
		recharge_queued = 0
//<--

////////////////////////////////////////////////////////////////
//Actual crankable guns start here
//maybe don't name the first instance my_first_crank

/obj/item/gun/energy/laser/cranklasergun/my_first_crank
	name = "My first crank template"
	desc = "googoo zaza"
	icon_state = "laer-e"
	item_state = "laer-e"
	cranking_time = 1.5 SECONDS
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun/my_first_crank
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun/my_first_crank)
	sound = list(
		'sound/effects/dynamo_crank/dynamo_crank_mb1.ogg',
		'sound/effects/dynamo_crank/dynamo_crank_mb2.ogg',
		'sound/effects/dynamo_crank/dynamo_crank_mb3.ogg',
	)


/obj/item/stock_parts/cell/ammo/mfc/cranklasergun/my_first_crank  //basically a single shot charge
	maxcharge = 4


/obj/item/ammo_casing/energy/cranklasergun/my_first_crank
	projectile_type = /obj/item/projectile/beam/laser/cranklasergun/my_first_crank
	fire_sound = 'sound/weapons/pulse2.ogg'


/obj/item/projectile/beam/laser/cranklasergun/my_first_crank
	damage = 35
////////////////////////////////////////////////////////////////
