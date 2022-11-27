/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "s-casing"
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_SMALL_CASING + MATS_PISTOL_SMALL_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_SMALL_CASING)
	/// Used to deduct powder and bullet mats from the bullet when fired
	var/material_class = BULLET_IS_LIGHT_PISTOL
	var/fire_sound = null						//What sound should play when this ammo is fired
	var/caliber = null							//Which kind of guns it can be loaded into - NOT a list!
	var/projectile_type = null					//The bullet type to create when New() is called
	var/obj/item/projectile/BB = null 			//The loaded bullet
	var/pellets = 1								//Pellets for spreadshot
	var/variance = 0							//Variance for inaccuracy fundamental to the casing
	var/randomspread = 1						//Randomspread for automatics
	var/delay = 0								//Delay for energy weapons
	/// Override this to make the gun check for a different cooldown rather than CLICK_CD_RANGE, which is 4 deciseconds.
	var/click_cooldown_override
	var/firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect	//the visual effect appearing when the ammo is fired.
	var/heavy_metal = TRUE
	var/harmful = TRUE //pacifism check for boolet, set to FALSE if bullet is non-lethal
	var/is_pickable = TRUE
	/// The power of the casing on the gun itself, mostly for hobo guns checking whats loaded for misfires
	var/fire_power = CASING_POWER_NONE * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/spent
	name = "spent bullet casing"
	BB = null
	deduct_powder_and_bullet_mats()

/obj/item/ammo_casing/Initialize()
	. = ..()
	if(projectile_type)
		BB = new projectile_type(src)
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)
	setDir(pick(GLOB.alldirs))
	update_icon()

/obj/item/ammo_casing/Destroy()
	if(BB)
		QDEL_NULL(BB)
	return ..()

/obj/item/ammo_casing/update_icon_state()
	icon_state = "[initial(icon_state)][BB ? "-live" : ""]"
	desc = "[initial(desc)][BB ? "" : " This one is spent."]"

/// When you shoot a bullet, the bullet and powder go away! wow!
/obj/item/ammo_casing/proc/deduct_powder_and_bullet_mats()
	if(!LAZYLEN(custom_materials))
		return // good enough
	var/iron_to_deduct
	var/powder_to_deduct
	switch(material_class)
		if(BULLET_IS_LIGHT_PISTOL)
			iron_to_deduct = MATS_PISTOL_SMALL_BULLET
			powder_to_deduct = MATS_PISTOL_SMALL_POWDER
		if(BULLET_IS_MEDIUM_PISTOL)
			iron_to_deduct = MATS_PISTOL_MEDIUM_BULLET
			powder_to_deduct = MATS_PISTOL_MEDIUM_POWDER
		if(BULLET_IS_HEAVY_PISTOL)
			iron_to_deduct = MATS_PISTOL_HEAVY_BULLET
			powder_to_deduct = MATS_PISTOL_HEAVY_POWDER
		if(BULLET_IS_LIGHT_RIFLE)
			iron_to_deduct = MATS_PISTOL_SMALL_BULLET
			powder_to_deduct = MATS_PISTOL_SMALL_POWDER
		if(BULLET_IS_MEDIUM_RIFLE)
			iron_to_deduct = MATS_PISTOL_MEDIUM_BULLET
			powder_to_deduct = MATS_PISTOL_MEDIUM_POWDER
		if(BULLET_IS_HEAVY_RIFLE)
			iron_to_deduct = MATS_PISTOL_HEAVY_BULLET
			powder_to_deduct = MATS_PISTOL_HEAVY_POWDER
		if(BULLET_IS_SHOTGUN)
			iron_to_deduct = MATS_SHOTGUN_BULLET
			powder_to_deduct = MATS_SHOTGUN_POWDER
		if(BULLET_IS_GRENADE)
			iron_to_deduct = MATS_GRENADE_BULLET
			powder_to_deduct = MATS_GRENADE_POWDER
		if(BULLET_IS_GAUSS)
			iron_to_deduct = MATS_GAUSS_BULLET
			powder_to_deduct = MATS_GAUSS_POWDER // surprise its nothing
	var/list/newmats = custom_materials
	if(iron_to_deduct && newmats[/datum/material/iron])
		newmats[/datum/material/iron] -= iron_to_deduct
	if(powder_to_deduct && newmats[/datum/material/blackpowder])
		newmats[/datum/material/blackpowder] -= (powder_to_deduct * MATS_AMMO_POWDER_BURN_MULT)
	set_custom_materials(newmats)

//proc to magically refill a casing with a new projectile
/obj/item/ammo_casing/proc/newshot() //For energy weapons, syringe gun, shotgun shells and wands (!).
	if(!BB)
		BB = new projectile_type(src, src)

/obj/item/ammo_casing/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_box))
		var/obj/item/ammo_box/box = I
		if(isturf(loc))
			var/boolets = 0
			for(var/obj/item/ammo_casing/bullet in loc)
				if (box.stored_ammo.len >= box.max_ammo)
					break
				if (bullet.BB)
					if (box.give_round(bullet, 0))
						boolets++
				else
					continue
			if (boolets > 0)
				box.update_icon()
				to_chat(user, span_notice("You collect [boolets] shell\s. [box] now contains [box.stored_ammo.len] shell\s."))
			else
				to_chat(user, span_warning("You fail to collect anything!"))
	else
		if(istype(I, /obj/item/wrench)) //FO13 - salvaging blackpowder/metal from ammo
			for(var/obj/item/ammo_casing/C in src.loc.contents)
				new /obj/item/stack/crafting/powder(user.drop_location())
				qdel(C)
		return ..()

/obj/item/ammo_casing/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(heavy_metal)
		bounce_away(FALSE, NONE)
	. = ..()

/obj/item/ammo_casing/proc/bounce_away(still_warm = FALSE, bounce_delay = 3, toss_direction, max_dist = 6, max_spread = 2)
	update_icon()
	SpinAnimation(10, 1)
	var/matrix/M = matrix(transform)
	M.Turn(rand(-170,170))
	transform = M
	pixel_x = rand(-12, 12)
	pixel_y = rand(-12, 12)
	if(toss_direction)
		var/turf/ejected_case_destination = get_casing_destination(toss_direction, max_dist, max_spread)
		if(!isturf(ejected_case_destination))
			return
		throw_at(ejected_case_destination, 10, rand(1,3))
		return
	var/turf/this_turf_here = get_turf(src)
	if(still_warm && this_turf_here && this_turf_here.bullet_sizzle)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.
	else if(this_turf_here && this_turf_here.bullet_bounce_sound)
		addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, this_turf_here.bullet_bounce_sound, 60, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.

/obj/item/ammo_casing/proc/get_casing_destination(eject_direction, max_dist = 6, max_spread = 2)
	if(!eject_direction)
		return get_turf(src) // just throw it on the ground
	return get_ranged_target_turf(src, eject_direction, rand(1,max_dist), max_spread)
