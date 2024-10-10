/obj/item/ammo_casing
	name = "bullet casing"
	desc = "A bullet casing."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "s-casing"
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	pass_flags = PASSTABLE | LETPASSTHROW // ejected casings can go over things now
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_LIGHT_CASING + MATS_PISTOL_LIGHT_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_LIGHT_CASING)
	/// Used to deduct powder and bullet mats from the bullet when fired
	var/material_class = BULLET_IS_LIGHT_PISTOL
	/// Used to deduct the right amount of bullet mats from the bullet when fired
	var/casing_quality = BULLET_IS_SURPLUS
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
	/// A string pointing to a list pointing to a datum pointing to a bunch of sound shit
	var/sound_properties = CSP_PISTOL_LIGHT
	var/e_cost = 100 //The amount of energy a cell needs to expend to create this shot.
	var/select_name = "energy"
	shadow = FALSE

/obj/item/ammo_casing/Initialize(mapload, spent)
	setup_sound_datums()
	. = ..()
	if(spent)
		spend_casing()
	if(projectile_type && !spent)
		BB = new projectile_type(src)
		register_statblock()
	pixel_x = rand(-10, 10)
	pixel_y = rand(-10, 10)
	setDir(pick(GLOB.alldirs))
	update_icon()

/obj/item/ammo_casing/Destroy()
	if(BB)
		QDEL_NULL(BB)
	return ..()

/obj/item/ammo_casing/proc/spend_casing()
	name = "spent [initial(name)]"
	BB = null
	deduct_powder_and_bullet_mats()
	update_icon()

/obj/item/ammo_casing/update_icon_state()
	icon_state = "[initial(icon_state)][BB ? "-live" : ""]"

/obj/item/ammo_casing/examine(mob/user)
	. = ..()
	if(!BB)
		. += span_alert("This one is spent.")

/// When you shoot a bullet, the bullet and powder go away! wow!
/obj/item/ammo_casing/proc/deduct_powder_and_bullet_mats()
	if(!LAZYLEN(custom_materials))
		return // good enough
	var/iron_to_deduct
	var/powder_to_deduct
	switch(material_class)
		if(BULLET_IS_LIGHT_PISTOL)
			iron_to_deduct = MATS_PISTOL_LIGHT_BULLET
			powder_to_deduct = MATS_PISTOL_LIGHT_POWDER
		if(BULLET_IS_MEDIUM_PISTOL)
			iron_to_deduct = MATS_PISTOL_MEDIUM_BULLET
			powder_to_deduct = MATS_PISTOL_MEDIUM_POWDER
		if(BULLET_IS_HEAVY_PISTOL)
			iron_to_deduct = MATS_PISTOL_HEAVY_BULLET
			powder_to_deduct = MATS_PISTOL_HEAVY_POWDER
		if(BULLET_IS_LIGHT_RIFLE)
			iron_to_deduct = MATS_RIFLE_LIGHT_BULLET
			powder_to_deduct = MATS_RIFLE_LIGHT_POWDER
		if(BULLET_IS_MEDIUM_RIFLE)
			iron_to_deduct = MATS_RIFLE_MEDIUM_BULLET
			powder_to_deduct = MATS_RIFLE_MEDIUM_POWDER
		if(BULLET_IS_HEAVY_RIFLE)
			iron_to_deduct = MATS_RIFLE_HEAVY_BULLET
			powder_to_deduct = MATS_RIFLE_HEAVY_POWDER
		if(BULLET_IS_SHOTGUN)
			iron_to_deduct = MATS_SHOTGUN_BULLET
			powder_to_deduct = MATS_SHOTGUN_POWDER
		if(BULLET_IS_GRENADE)
			iron_to_deduct = MATS_GRENADE_BULLET
			powder_to_deduct = MATS_GRENADE_POWDER
		if(BULLET_IS_GAUSS)
			iron_to_deduct = MATS_GAUSS_BULLET
			powder_to_deduct = MATS_GAUSS_POWDER // surprise its nothing
		else
			return
	switch(casing_quality)
		if(BULLET_IS_MATCH)
			iron_to_deduct *= MATS_AMMO_BULLET_MATCH_MULT
			powder_to_deduct *= MATS_AMMO_POWDER_MATCH_MULT
		if(BULLET_IS_HANDLOAD, BULLET_IS_RUBBER)
			iron_to_deduct *= MATS_AMMO_BULLET_HANDLOAD_MULT
			powder_to_deduct *= MATS_AMMO_POWDER_HANDLOAD_MULT
	var/list/newmats = list()
	var/matz_iron = custom_materials[SSmaterials.GetMaterialRef(/datum/material/iron)]
	var/matz_bp = custom_materials[SSmaterials.GetMaterialRef(/datum/material/blackpowder)]
	if(iron_to_deduct && matz_iron)
		newmats[/datum/material/iron] = max(matz_iron - iron_to_deduct, 10)
	if(powder_to_deduct && matz_bp)
		newmats[/datum/material/blackpowder] = max(matz_bp - (powder_to_deduct * MATS_AMMO_POWDER_BURN_MULT), 10) // idk why it kept going necative
	if(LAZYLEN(newmats))
		set_custom_materials(newmats)

//proc to magically refill a casing with a new projectile
/obj/item/ammo_casing/proc/newshot() //For energy weapons, syringe gun, shotgun shells and wands (!).
	if(!BB)
		BB = new projectile_type(src, src)

/obj/item/ammo_casing/proc/register_statblock(update)
	if(LAZYACCESS(GLOB.casing2stats, "[type]") && !update)
		return
	if(!istype(BB))
		return // come back when you're a little... mmm... loaded
	var/list/my_statblock = build_statblock(BB)
	LAZYSET(GLOB.casing2stats, "[type]", my_statblock)

/obj/item/ammo_casing/proc/build_statblock(obj/item/projectile/proj)
	if(!BB)
		return
	if(!proj && BB)
		proj = BB
	var/my_statblock = SANITIZE_LIST(proj.create_statblock())
	my_statblock["casing_name"] = name || "Ammo Casing"
	my_statblock["casing_caliber"] = caliber || 0
	my_statblock["casing_pellets"] = pellets || 1
	my_statblock["casing_variance"] = variance || 0
	my_statblock["casing_fire_power"] = fire_power || 0
	my_statblock["casing_damage_threshold_penetration"] = damage_threshold_penetration
	my_statblock["casing_select_name"] = select_name || "energy"
	my_statblock["casing_e_cost"] = e_cost || 100
	return my_statblock

/obj/item/ammo_casing/proc/get_statblock(update)
	register_statblock(update)
	return GLOB.casing2stats["[type]"]

/// Returns our sound data lookup table~
/obj/item/ammo_casing/proc/get_sound_datum()
	if(!LAZYLEN(GLOB.casing_sound_properties))
		setup_sound_datums()
	return GLOB.casing_sound_properties[sound_properties]

/// Sets up our precious sound datums
/obj/item/ammo_casing/proc/setup_sound_datums()
	if(LAZYLEN(GLOB.casing_sound_properties))
		return
	new /datum/ammo_sound_properties/light_pistol(TRUE) // it'll set it all up

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
		addtimer(CALLBACK(usr, GLOBAL_PROC_REF(playsound), src, 'sound/items/welder.ogg', 20, 1), bounce_delay) //If the turf is made of water and the shell casing is still hot, make a sizzling sound when it's ejected.
	else if(this_turf_here && this_turf_here.bullet_bounce_sound)
		addtimer(CALLBACK(usr, GLOBAL_PROC_REF(playsound), src, this_turf_here.bullet_bounce_sound, 60, 1), bounce_delay) //Soft / non-solid turfs that shouldn't make a sound when a shell casing is ejected over them.

/obj/item/ammo_casing/proc/get_casing_destination(eject_direction, max_dist = 6, max_spread = 2)
	if(!eject_direction)
		return get_turf(src) // just throw it on the ground
	return get_ranged_target_turf(src, eject_direction, rand(1,max_dist), max_spread)
