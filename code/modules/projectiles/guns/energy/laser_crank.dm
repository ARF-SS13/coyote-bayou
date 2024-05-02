//-->laserv guns that have a dynamo to recharge
//<--

/obj/item/gun/energy/laser/cranklasergun
	name = "energy dynamo cranked weapon template"
	desc = "Should not exists. Bugreport."
	icon_state = "laser"
	item_state = "laser"
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun)
	var/list/crank_overcharge_mult = list()  //depending on how many overcharge stages the gun has, leave blank if you want no overcharge
	var/list/crank_overcharge_fire_sounds = list()  //if your overcharged shots have different sounds put the actual paths here
	var/cranking_time = 1 SECONDS
	var/crank_stamina_cost = 10
	var/list/crank_sound = list(
		'sound/effects/dynamo_crank/dynamo_crank.mp3',
	)
	dead_cell = TRUE  //This variable also has to stay TRUE for all cranklaserguns or else you'll get extra shots in your gun upon spawn
	allow_ui_interact = FALSE  //this variable must stay false to all cranklaserguns or else the gun UI will pop up every time you crank
	custom_materials = list(/datum/material/iron=2000)
	ammo_x_offset = 1
	shaded_charge = 1
	can_remove = 0 //We can't remove the battery of a cranklasergun
	can_charge = 0 //And we surely can't put such weapon in recharger, it's faster to crank anyways
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
//Crank to recharge
/obj/item/gun/energy/attack_self(mob/living/user)
	. = ..()
	//we have to check if the gun is a cranklasergun type, otherwise ignore it
	if(istype(src, /obj/item/gun/energy/laser/cranklasergun))  //does the gun belong to the cranklasergun type we seek?
		var/obj/item/gun/energy/laser/cranklasergun/firearm = src  //let's assign it a name then
		var/obj/item/stock_parts/cell/C = src.get_cell()

		var/playsound_volume = 50
		
		if((C.charge < C.maxcharge) && (!recharge_queued))
			recharge_queued = 1  //this variable makes it so we can't queue multiple recharges at once, only one at a time (variable gets reset in {/obj/item/gun/shoot_live_shot(mob/living/user)})
			playsound(user.loc, pick(firearm.crank_sound), playsound_volume, TRUE)
			if(do_after(user, firearm.cranking_time, target = src, allow_movement = TRUE))
				recharge_queued = 0
				user.apply_damage(firearm.crank_stamina_cost, STAMINA)  //have you ever ridden a bike with a dynamo?
				C.charge += 1
				update_icon()
				
				//if it's the overcharged variant, then execute this too
				if(firearm.crank_overcharge_mult.len)
					if(!C.charge)
						firearm.damage_multiplier = firearm.crank_overcharge_mult[1]
					else if(C.charge <= firearm.crank_overcharge_mult.len)
						firearm.damage_multiplier = firearm.crank_overcharge_mult[C.charge]
					else
						firearm.damage_multiplier = firearm.crank_overcharge_mult[firearm.crank_overcharge_mult.len]

				if(firearm.crank_overcharge_fire_sounds.len)
					if(!C.charge)
						firearm.fire_sound = firearm.crank_overcharge_fire_sounds[1]
					else if(C.charge <= firearm.crank_overcharge_fire_sounds.len)
						firearm.fire_sound = firearm.crank_overcharge_fire_sounds[C.charge]
					else
						firearm.fire_sound = firearm.crank_overcharge_fire_sounds[firearm.crank_overcharge_fire_sounds.len]

			else
				recharge_queued = 0

//if I'm shooting, reset few variables in the way it makes sense
/obj/item/gun/shoot_live_shot(mob/living/user)
	. = ..()
	//we have to check if the gun is a cranklasergun type, otherwise ignore it
	if(istype(src, /obj/item/gun/energy/laser/cranklasergun))
		var/obj/item/gun/energy/laser/cranklasergun/firearm = src
		recharge_queued = 0
		
		if(firearm.crank_overcharge_mult.len)
			var/obj/item/stock_parts/cell/C = src.get_cell()
			C.charge = 0
//<--

////////////////////////////////////////////////////////////////
//Actual crankable guns start here

//-->Standard issue crankable laser gun template, this can't be overcharged and can shoot multiple times.
/obj/item/gun/energy/laser/cranklasergun/classic
	name = "My first crank template"
	desc = "googoo zaza"
	icon_state = "laer-e"
	item_state = "laer-e"
	cranking_time = 1.5 SECONDS
	crank_stamina_cost = 0 // put a number here if you want your cranking to tire people out
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun/classic
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun/classic)
	crank_sound = list(
		'sound/effects/dynamo_crank/dynamo_crank_mb1.ogg',
		'sound/effects/dynamo_crank/dynamo_crank_mb2.ogg',
		'sound/effects/dynamo_crank/dynamo_crank_mb3.ogg',
	)

/obj/item/stock_parts/cell/ammo/mfc/cranklasergun/classic  //basically a single shot charge
	maxcharge = 4

/obj/item/ammo_casing/energy/cranklasergun/classic
	projectile_type = /obj/item/projectile/beam/laser/cranklasergun/classic
	fire_sound = 'sound/weapons/pulse2.ogg'

/obj/item/projectile/beam/laser/cranklasergun/classic
	damage = 25
////////////////////////////////////////////////////////////////

//-->Standard issue crankable laser gun that can be overcharged, this allows for a single shot only, but charging the gun makes the shot stronger
/obj/item/gun/energy/laser/cranklasergun/overcharge
	name = "Crankable laser musket template"
	desc = "you shouldn't see this, please report it!"
	icon_state = "laer-e"
	item_state = "laer-e"
	crank_overcharge_mult = list(1, 2, 3)
	crank_overcharge_fire_sounds = list(
		'sound/weapons/pulse3.ogg',
		'sound/weapons/pulse2.ogg',
		'sound/weapons/pulse.ogg',
	)
	cranking_time = 1.5 SECONDS
	crank_stamina_cost = 0  // put a number here if you want your cranking to tire people out
	damage_multiplier = 3
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun/overcharge
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun/overcharge)
	fire_sound = 'sound/weapons/pulse.ogg'
	crank_sound = list(
		'sound/effects/dynamo_crank/dynamo_crank.mp3',
	)

/obj/item/stock_parts/cell/ammo/mfc/cranklasergun/overcharge
	maxcharge = 3

/obj/item/ammo_casing/energy/cranklasergun/overcharge
	projectile_type = /obj/item/projectile/beam/laser/cranklasergun/overcharge
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/projectile/beam/laser/cranklasergun/overcharge
	damage = 30
////////////////////////////////////////////////////////////////

//-->Revolver_man's laser musket
/obj/item/gun/energy/laser/cranklasergun/overcharge/revolver_man
	name = "Revolver Man's lazor"
	desc = "Revolver Man has fucking lasors now???!!!"
	icon_state = "laer-e"
	item_state = "laer-e"
	crank_overcharge_mult = list(1, 1.5, 2, 2.5, 3, 3.5)
	crank_overcharge_fire_sounds = list(
		'sound/weapons/pulse3.ogg',
		'sound/weapons/pulse2.ogg',
		'sound/weapons/pulse.ogg',
	)
	cranking_time = 0.8 SECONDS
	crank_stamina_cost = 0 // put a number here if you want your cranking to tire people out
	damage_multiplier = 3.5
	cell_type = /obj/item/stock_parts/cell/ammo/mfc/cranklasergun/overcharge/revolver_man
	ammo_type = list(/obj/item/ammo_casing/energy/cranklasergun/overcharge/revolver_man)
	fire_sound = 'sound/weapons/pulse.ogg'
	crank_sound = list(
		'sound/effects/dynamo_crank/dynamo_crank.mp3',
	)

/obj/item/stock_parts/cell/ammo/mfc/cranklasergun/overcharge/revolver_man
	maxcharge = 6

/obj/item/ammo_casing/energy/cranklasergun/overcharge/revolver_man
	projectile_type = /obj/item/projectile/beam/laser/cranklasergun/overcharge/revolver_man
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/projectile/beam/laser/cranklasergun/overcharge/revolver_man
	damage = 30
////////////////////////////////////////////////////////////////
