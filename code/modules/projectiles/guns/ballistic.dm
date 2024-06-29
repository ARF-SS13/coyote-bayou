GLOBAL_LIST_EMPTY(gun_accepted_magazines)

/obj/item/gun/ballistic
	desc = "Now comes in flavors like GUN. Uses 10mm ammo, for some reason."
	name = "projectile gun"
	icon_state = "pistol"
	weapon_class = WEAPON_CLASS_RIFLE
	var/icon_state_base
	var/spawnwithmagazine = TRUE
	var/mag_type = /obj/item/ammo_box/magazine/m10mm/adv //Removes the need for max_ammo and caliber 
	var/init_mag_type = null
	var/list/extra_mag_types = list()
	/// List of mags accepted by the gun
	/// defaults to a typecache of mag_type
	/// Dont set this, its handled by Init()
	var/list/allowed_mags = list()
	/// List of mags not accepted by the gun
	var/list/disallowed_mags = list()
	/// Loaded magazine
	var/obj/item/ammo_box/magazine/magazine
	var/casing_ejector = TRUE //whether the gun ejects the chambered casing
	var/magazine_wording = "magazine"
	var/cock_wording = "rack"
	var/en_bloc = 0
	/// Which direction do the casings fly out?
	var/handedness = GUN_EJECTOR_RIGHT
	var/cock_sound = "gun_slide_lock"
	fire_sound = null //null tells the gun to draw from the casing instead of the gun for sound

	/// Sets if this thing will use the cool CMLS gun-side damage and ammo properties (thanks bun!)
	/// the following are CMLS vars!
	var/use_cmls = TRUE // reject ballistic, embrace gameplay
	/// without a damage_list defined, default to this damage
	var/damage // if left null, and the rest of these damage vars are also null, the projectile will default to its own damage system
	/// The damage list to use for this gun! format: list("dmg" = weight) so, list("15" = 5, "20" = 3, "1000" = 0.1)
	var/damage_list
	/// without a damage list defined, and both of these defined, will roll a random number between these two values
	var/damage_high
	var/damage_low
	/// if not null, will override the projectile's damage type
	var/damage_type
	/// if not null, will override what kind of armor the projectile checks against
	var/damage_armor_type

	var/datum/ammo_kind/ammo_kind = /datum/ammo_kind/shotgun/q_12_gauge
	var/ammo_magazine_name = "%MAXAMMO% round clipazine"
	var/ammo_capacity = 10
	var/ammo_single_load = FALSE
	var/is_revolver = FALSE
	var/ejects_magazine = FALSE

	var/recoil_per_shot = 2 // degrees

	var/sound_magazine_eject = "gun_remove_empty_magazine"
	var/sound_magazine_insert = "gun_insert_full_magazine"

	var/use_gun_sprite_handler = FALSE

/obj/item/gun/ballistic/Initialize()
	. = ..()
	if(use_cmls)
		if(!SScmls.GunCanCMLS(src))
			message_admins("GUN [src] cannot use CMLS, please fix it! It also exploded, fix that too.")
			log_world("GUN [src] cannot use CMLS, please fix it! It also exploded, fix that too.")
			stack_trace("GUN [src] cannot use CMLS, please fix it! It also exploded, fix that too.")
			explosion(src, 1, 1, 1, 1, TRUE, TRUE, 1)
			return
		SScmls.SetupGun(src)
	else
		if(spawnwithmagazine)
			if (!magazine)
				if(init_mag_type)
					magazine = new init_mag_type(src)
				else
					magazine = new mag_type(src)
				if(magazine.fixed_mag)
					gun_tags |= GUN_INTERNAL_MAG
		allowed_mags |= mag_type
		allowed_mags |= subtypesof(mag_type)
		if(extra_mag_types)
			if(islist(extra_mag_types) && LAZYLEN(extra_mag_types))
				allowed_mags |= extra_mag_types
			else if (ispath(extra_mag_types))
				allowed_mags |= typesof(extra_mag_types)
		if(LAZYLEN(disallowed_mags))
			allowed_mags -= disallowed_mags
	register_magazines()
	chamber_round()
	if(use_gun_sprite_handler)
		SSgun_sprites.RegisterGunSprites(src)
	update_icon()

/obj/item/gun/ballistic/admin_fill_gun()
	if(!istype(magazine))
		return
	return SEND_SIGNAL(magazine, COMSIG_GUN_MAG_ADMIN_RELOAD) // get relayed, noob

/obj/item/gun/ballistic/UpdateAmmoCountOverlay()
	if(isturf(loc))//Only show th ammo count if the magazine is, like, in an inventory or something. Mags on the ground don't need a big number on them, that's ugly.
		maptext = ""
	else 
		var/ammos = get_ammo()
		var/ammomax = get_max_ammo()
		var/textt = ""
		var/culur = "#FF0000"
		if(ammomax == 0)
			culur = "#FFFFFF"
		else if(ammos == ammomax)
			culur = "#00FFFF"
		else if(ammos > ammomax * 0.75)
			culur = "#00FF00"
		else if(ammos > ammomax * 0.5)
			culur = "#FFFF00"
		else if(ammos > ammomax * 0.25)
			culur = "#FFA500"
		else if(ammos > 0)
			culur = "#FF0000"
		else
			culur = "#FF00FF"
		if(ammos > 0)
			textt = "[ammos]/[get_max_ammo()]"
		else
			textt = "0/[get_max_ammo()]"
		maptext = "<font color='[culur]'><b>[textt]</b></font>"

/obj/item/gun/ballistic/update_icon_state()
	if(SSgun_sprites.SkinGun(src))
		return
	if(SEND_SIGNAL(src, COMSIG_ITEM_UPDATE_RESKIN))
		return // all done!
	icon_state = "[initial(icon_state)][sawn_off ? "-sawn" : ""]"

/obj/item/gun/ballistic/modify_projectile(obj/item/projectile/BB)
	if(!isnull(damage))            BB.damage      = damage
	if(!isnull(damage_list))       BB.damage_list = damage_list
	if(!isnull(damage_high))       BB.damage_high = damage_high
	if(!isnull(damage_low))        BB.damage_low  = damage_low
	if(!isnull(damage_type))       BB.damage_type = damage_type
	if(!isnull(damage_armor_type)) BB.flag        = damage_armor_type
	if(!isnull(recoil_per_shot))   BB.recoil      = recoil_per_shot
	// stop me~ you cant~

/obj/item/gun/ballistic/proc/register_magazines()
	if(LAZYACCESS(GLOB.gun_accepted_magazines, "[type]"))
		return
	GLOB.gun_accepted_magazines["[type]"] = ""
	if(magazine && magazine.fixed_mag)
		GLOB.gun_accepted_magazines["[type]"] = "This weapon accepts [english_list(magazine.caliber)]."
		return
	var/list/names_of_mags = list()
	for(var/mag in allowed_mags)
		if(!ispath(mag))
			continue
		var/atom/movable/marge = mag
		names_of_mags += initial(marge.name)
	GLOB.gun_accepted_magazines["[type]"] = "This weapon accepts: [english_list(names_of_mags)]."

/// Ejects whatever's chambered, and attempts to load a new one from the magazine
/// chamber_round wont load another one if something's still in the chamber
/// this is how bolt-action guns require pumping
/obj/item/gun/ballistic/process_chamber(mob/living/user, soft_eject = FALSE)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		if(casing_ejector)
			AC.forceMove(drop_location()) //Eject casing onto ground.
			AC.bounce_away(TRUE, toss_direction = (soft_eject ? null : get_ejector_direction(user)))
			chambered = null
	chamber_round()

/// If the chamber is empty, take a round from the magazine and put it in there
/// If the chamber is not empty, or theres no magazine, do nothing
/obj/item/gun/ballistic/proc/chamber_round()
	if (chambered || !magazine)
		return
	else if (magazine.ammo_count())
		if(is_revolver)
			chambered = magazine.get_round(TRUE)
		else
			chambered = magazine.get_round()
			chambered.forceMove(src)
	update_icon()

/obj/item/gun/ballistic/can_shoot()
	return !!chambered?.BB
/* 	if(!magazine || !magazine.ammo_count(0))
		return FALSE
	if(!casing_ejector)
	return TRUE */

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/crafting/metalparts))
		if(istype(magazine))
			magazine.attackby(A, user)

	if(istype(A, /obj/item/ammo_casing))
		if(istype(magazine))
			if(magazine.caliber_change_step == MAGAZINE_CALIBER_CHANGE_STEP_3)
				magazine.attackby(A, user)
				return TRUE
			if(magazine.fixed_mag) // fixed mag, just load bullets in
				magazine.load_from_casing(A, user, FALSE)
				chamber_round(0)
				update_icon()
				return TRUE

	if(SScmls.InsertCMLSmagIntoGun(user, src, A))
		return TRUE

	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/new_mag = A
		if(magazine?.fixed_mag) // fixed mag, just load bullets in
			magazine.load_from_box(A, user, FALSE)
			chamber_round(0)
			update_icon()
			return TRUE
		// removable mag, eject the mag
		if(!is_magazine_allowed(new_mag, user)) // But only if the new mag would fit
			return FALSE
		var/obj/item/ammo_box/oldmag
		if(istype(magazine))
			oldmag = magazine
			eject_magazine(user, en_bloc, !en_bloc, TRUE) //stop ejecting perfectly good shells!
		if(user.transferItemToLoc(new_mag, src))
			magazine = new_mag
			if(oldmag && user.put_in_hands(oldmag))
				to_chat(user, span_notice("You load a new magazine into \the [src], keeping hold of the old one."))
			else
				to_chat(user, span_notice("You load a new magazine into \the [src]."))
		else
			to_chat(user, span_warning("You cannot seem to get \the [new_mag] out of your hands!"))
			return FALSE
		if(magazine.ammo_count())
			playsound(src, "gun_insert_full_magazine", 70, 1)
			if(!chambered)
				chamber_round()
				addtimer(CALLBACK(usr, GLOBAL_PROC_REF(playsound), src, 'sound/weapons/gun_chamber_round.ogg', 100, 1), 3)
		else
			playsound(src, "gun_insert_empty_magazine", 70, 1)
		new_mag.update_icon()
		update_icon()
		do_squish(0.75,0.75,0.25 SECONDS)
		return TRUE
	return FALSE

/obj/item/gun/ballistic/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(magazine)
		magazine.screwdriver_act(user, I)
		return

/obj/item/gun/ballistic/welder_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(magazine)
		magazine.welder_act(user, I)
		return


/obj/item/gun/ballistic/proc/is_magazine_allowed(obj/item/ammo_box/mag_to_check, mob/user)
	. = FALSE
	if(!istype(mag_to_check))
		if(user)
			to_chat(user, span_phobia("Whatever you tried to stuff into \the [src] wasn't a thing! This is a bug~"))
		return FALSE
	if(mag_to_check.type in allowed_mags)
		return TRUE
	if(user)
		to_chat(user, span_alert("You can't seem to fit \the [mag_to_check] into \the [src]."))

/obj/item/gun/ballistic/proc/load_fixed_magazine(obj/item/casing_or_magazine, user, params)
	if(istype(casing_or_magazine, /obj/item/ammo_casing) || istype(casing_or_magazine, /obj/item/ammo_box))
		var/num_loaded = magazine.attackby(casing_or_magazine, user, params, 1)
		if(num_loaded)
			to_chat(user, span_notice("You load [num_loaded] shell\s into \the [src]!"))
			playsound(user, 'sound/weapons/shotguninsert.ogg', 60, 1)
			casing_or_magazine.update_icon()
			update_icon()
			chamber_round(0)
			return TRUE
		else
			to_chat(user, span_alert("You can't fit \the [casing_or_magazine] into \the [src]!"))
			return FALSE

/obj/item/gun/ballistic/proc/pump(mob/living/M, visible = TRUE)
	if(visible)
		M?.visible_message(span_warning("[M] [cock_wording]\s \the [src]."), span_warning("You [cock_wording] \the [src]."))
		playsound(src, cock_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	update_firemode()
	do_squish(0.75,0.75,0.25 SECONDS)
	return 1

/obj/item/gun/ballistic/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/proc/pump_reload(mob/M)
	if(chambered)
		return FALSE
	if(!magazine)
		return FALSE
	if(!magazine.ammo_count())
		return FALSE
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	if(AC)
		chambered = AC
		return TRUE

/obj/item/gun/ballistic/attack_self(mob/living/user)
	if(SScmls.EjectCMLSmagFromGun(user, src, magazine))
		return TRUE
	if(magazine)
		if(magazine.fixed_mag || !casing_ejector)
			pump(user, TRUE)
			update_icon()
		else
			eject_magazine(user, en_bloc, !en_bloc, TRUE)
			update_icon()
		return
	if(chambered)
		pump(user, TRUE)
		update_icon()
		return
	to_chat(user, span_notice("There's no magazine in \the [src]."))
	update_icon()
	return

///obj/item/gun/ballistic/AltClick(mob/living/user)
//	pump(user, TRUE)

/obj/item/gun/ballistic/proc/eject_magazine(mob/living/user, is_enbloc, put_it_in_their_hand, sounds_and_words)
	if(magazine.fixed_mag)
		return FALSE
	magazine.forceMove(drop_location())
	if(put_it_in_their_hand)
		user.put_in_hands(magazine)
	else
		user.dropItemToGround(magazine)
	if(sounds_and_words)
		if(en_bloc)
			playsound(src, "sound/f13weapons/garand_ping.ogg", 70, 1)
		else if(magazine.ammo_count())
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, 1)
		else
			playsound(src, "gun_remove_empty_magazine", 70, 1)
		to_chat(user, span_notice("You eject \the [magazine] from \the [src]."))
	magazine.update_icon()
	magazine = null
	update_icon()
	do_squish(0.75,0.75,0.25 SECONDS)
	return TRUE

/// Pump if click with empty thing
/obj/item/gun/ballistic/shoot_with_empty_chamber(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	if(!casing_ejector && chambered && HAS_TRAIT(user, TRAIT_FAST_PUMP) && !istype(magazine, /obj/item/ammo_box/magazine/internal/cylinder))
		pump(user, TRUE)
	else
		..()

/obj/item/gun/ballistic/proc/eject_chambered_round(mob/living/user, sounds_and_words)
	if(sounds_and_words)
		to_chat(user, span_notice("You eject \a [chambered] from \the [src]'s chamber."))
		playsound(src, "gun_slide_lock", 70, 1)
	process_chamber(user, FALSE)

/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	if(istype(magazine) && magazine.fixed_mag && length(magazine.caliber))
		. += "It accepts [span_notice(english_list(magazine.caliber))]"
	. += "It has [span_notice("[get_ammo()]")] round\s remaining."
	if (chambered && !casing_ejector)
		. += "A [chambered.BB ? span_green("live") : span_alert("spent")] one is in the chamber."

/obj/item/gun/ballistic/proc/get_ammo(countchambered = 1)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count()
	return boolets

/obj/item/gun/ballistic/proc/get_max_ammo(countchambered = 1)
	var/boolets = 0 //mature var names for very mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.max_ammo
	return boolets

/obj/item/gun/ballistic/proc/sawoff(mob/user)
	if(sawn_off)
		to_chat(user, span_warning("\The [src] is already shortened!"))
		return
	user.DelayNextAction(CLICK_CD_MELEE)
	user.visible_message("[user] begins to shorten \the [src].", span_notice("You begin to shorten \the [src]..."))

	//if there's any live ammo inside the gun, makes it go off
	if(blow_up(user))
		user.visible_message(span_danger("\The [src] goes off!"), span_danger("\The [src] goes off in your face!"))
		return

	if(do_after(user, 30, target = src))
		if(sawn_off)
			return
		user.visible_message("[user] shortens \the [src]!", span_notice("You shorten \the [src]."))
		name = "sawn-off [src.name]"
		desc = sawn_desc
		w_class = WEIGHT_CLASS_SMALL
		weapon_weight = GUN_TWO_HAND_ONLY // years of ERP made me realize wrists of steel isnt a good thing
		item_state = "gun"
		slot_flags |= INV_SLOTBIT_BELT //but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
		recoil_tag = SSrecoil.modify_gun_recoil(recoil_tag, list(2, 2))
		cock_delay = GUN_COCK_SHOTGUN_FAST
		damage_multiplier *= GUN_LESS_DAMAGE_T2 // -15% damage
		sawn_off = TRUE
		gun_accuracy_zone_type = ZONE_WEIGHT_SHOTGUN
		/*
		init_firemodes = list(
			list(mode_name="Single-fire", mode_desc="Send Vagabonds flying back several paces", burst_size=1, icon="semi"),
		)
		initialize_firemodes()
		if(firemodes.len)
			set_firemode(sel_mode)
			*/
		update_icon()
		return 1
		
		
// /obj/item/gun/ballistic/get_dud_projectile()
// 	var/proj_type
// 	if(chambered)
// 		if(!chambered.BB)
// 			return null
// 		proj_type = chambered.BB.type
// 	else if(magazine && get_ammo(0,0))
// 		var/obj/item/ammo_casing/A = magazine.stored_ammo[1]
// 		if(!A)
// 			return null
// 		if(!A.BB)
// 			return null
// 		proj_type = A.BB.type
// 	if(!proj_type)
// 		return null
// 	return new proj_type

/obj/item/gun/ballistic/ui_data(mob/user)
	var/list/data = ..()
	data["has_magazine"] = !!magazine
	data["accepted_magazines"] = LAZYACCESS(GLOB.gun_accepted_magazines, "[type]")
	if(istype(magazine))
		data["magazine_name"] = magazine.name
		data["magazine_calibers"] = english_list(magazine.caliber)
	data["shots_remaining"] = get_ammo()
	data["shots_max"] = get_max_ammo() - (is_revolver ? 1 : 0) // revolvers have one less shot

	return data

// Sawing guns related proc
/obj/item/gun/ballistic/proc/blow_up(mob/user)
	. = 0
	for(var/obj/item/ammo_casing/AC in magazine.stored_ammo)
		if(AC.BB)
			process_fire(user, user, FALSE)
			. = 1

/obj/item/gun/ballistic/generate_guntags()
	..()
	gun_tags |= GUN_PROJECTILE

/obj/item/gun/ballistic/refresh_upgrades()
	if(istype(magazine,/obj/item/ammo_box/magazine/internal))
		magazine?.max_ammo = initial(magazine?.max_ammo)
	..()

/obj/item/gun/ballistic/proc/get_ejector_direction(mob/user)
	if(user?.dir)
		switch(handedness)
			if(GUN_EJECTOR_RIGHT)
				return turn(user.dir, -90)
			if(GUN_EJECTOR_LEFT)
				return turn(user.dir, 90)
			if(GUN_EJECTOR_ANY)
				return turn(user.dir, pick(0, -90, 90, 180))
	return angle2dir_cardinal(rand(0,360)) // something fucked up, just send a direction

/obj/item/gun/ballistic/Reload(mob/user)
	if(!ishuman(user))
		return FALSE
	if(on_cooldown(user) || !user.has_direct_access_to(src, STORAGE_VIEW_DEPTH))
		to_chat(user, span_notice("You can't reload \the [src] right now!"))
		return FALSE
	//Shotguns, bolt action rifles, etc.
	if(magazine?.fixed_mag)
		return InternalReload(user)
	//External magazine weapons
	else
		return MagReload(user)

/*
* Reloads an internal magazine of a weapon with boxes of ammo in your inventory or loose rounds. Unsafe, call Reload() instead.
*/
/obj/item/gun/ballistic/proc/InternalReload(mob/user)
	//typecast the user as a human
	var/mob/living/carbon/human/H = user

	//Wait a second or two so we can't spam reload too quickly. Also if this runtimes then the gun will never be reloadable again with this proc so rip
	busy_action = TRUE
	playsound(get_turf(H), "rustle", rand(50,100), 1, SOUND_DISTANCE(7))
	H.visible_message(span_notice("[H] starts reloading \the [src]..."), span_notice("You start looking for a magazine to reload \the [src] with..."), span_notice("You hear the clinking of metal..."))
	if(!do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE))
		busy_action = FALSE
		return FALSE

	var/isrevolver = FALSE
	if(istype(src, /obj/item/gun/ballistic/revolver) || istype(magazine, /obj/item/ammo_box/magazine/internal/cylinder))//Pull any loose shells out, first.
		var/obj/item/gun/ballistic/revolver/R = src
		isrevolver = TRUE
		R.eject_shells(H, TRUE)
	else if((chambered && !chambered?.BB) || (!chambered && LAZYLEN(magazine?.stored_ammo)))//Eject any empty shells from the chamber
		attack_self(H)

	var/list/validboxes = list()
	var/boxedrounds = 0 //If we don't have enough boxed rounds, look for loose rounds as well
	var/list/validcasings = list()
	var/list/yourstuff = H?.contents + H?.belt?.contents + H?.back?.contents + H?.wear_suit?.contents + H?.shoes?.contents + H?.head?.contents + H?.l_store?.contents + H?.r_store?.contents + H?.s_store?.contents + H?.wear_neck?.contents
	//find compatible boxes of ammo
	for(var/obj/item/ammo_box/B in yourstuff)
		var/rounds = LAZYLEN(B.stored_ammo)
		if(rounds > 0 && B.caliber?[1] == magazine.caliber?[1] && !isgun(B.loc))
			boxedrounds += rounds
			validboxes += B
			validboxes[B] = rounds
	//find loose rounds if there aren't enough boxed rounds to fill the magazine
	if(LAZYLEN(validboxes) == 0 || boxedrounds < (magazine.max_ammo - magazine.ammo_count()))
		for(var/obj/item/ammo_casing/AC in yourstuff)
			if(AC.BB && (AC.caliber in magazine?.caliber) && !isgun(AC.loc))//Not spent, correct caliber
				if(AC.loc in validboxes)//don't count these twice
					continue
				validcasings += AC

	if(LAZYLEN(validboxes) || LAZYLEN(validcasings))
		if(LAZYLEN(validboxes) && magazine.ammo_count() < magazine.max_ammo)
			sortTim(validboxes, /proc/cmp_numeric_asc, TRUE)//Sort them by least to most filled so we empty the least filled ones first.
			for(var/obj/item/ammo_box/B in validboxes)
				if(isnull(B) || QDELETED(B))
					continue
				//reload from this ammo box multiple times if our magazine doesn't get filled in one go or we need to chamber a round and then fill up.
				if(!magazine?.multiload)//internal magazines that don't load multiple rounds at once
					var/numroundstoload = clamp((magazine.max_ammo - magazine.ammo_count()), 1, LAZYLEN(B.stored_ammo))
					for(var/i = 1; i <= numroundstoload; i++)
						if(do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE) && H.has_direct_access_to(B, STORAGE_VIEW_DEPTH) && attackby(B, user))
							continue
						else
							break
				else// magazines that accept multiple rounds at once
					if(do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE) && H.has_direct_access_to(B, STORAGE_VIEW_DEPTH) && attackby(B, user))
						if(!isrevolver && ((chambered && !chambered?.BB) || !chambered))//spent round or an empty chamber
							attack_self(H)//rack the bolt
							//Insert another round to top us off since we just chambered a round
							if(LAZYLEN(B.stored_ammo) && do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE) && magazine.ammo_count() < magazine.max_ammo && LAZYLEN(B.stored_ammo))
								attackby(B, user)
						var/newammo = LAZYLEN(B.stored_ammo)
						if(newammo == 0)
							validboxes -= B
						else
							validboxes[B] = newammo //update this box's ammo count
							sortTim(validboxes, /proc/cmp_numeric_asc, TRUE)			
				if(LAZYLEN(magazine.stored_ammo) < magazine.max_ammo)
					continue
				else
					break
		if(LAZYLEN(validcasings) && magazine.ammo_count() < magazine.max_ammo)
			for(var/obj/item/ammo_casing/AC in validcasings)
				if(isnull(AC) || QDELETED(AC) || !AC.BB)
					continue
				if(do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE) && H.has_direct_access_to(AC, STORAGE_VIEW_DEPTH) && attackby(AC, user))
					validcasings -= AC
					if(!isrevolver && ((chambered && !chambered?.BB) || !chambered))//spent round or an empty chamber
						attack_self(H)//rack the bolt
				if(magazine.ammo_count() < magazine.max_ammo)
					continue
				else
					break
	else
		to_chat(H, span_alert("You couldn't find any ammunition that fits into \the [src]!"))

	busy_action = FALSE
	return TRUE

/// Reloads a magazine into a gun that uses external magazines. Unsafe, call Reload() instead.
/obj/item/gun/ballistic/proc/MagReload(mob/user)
	if(!mag_type)
		return FALSE
	//typecast the user as a human
	var/mob/living/carbon/human/H = user

	//Wait a second or two so we can't spam reload too quickly. Also if this runtimes then the gun will never be reloadable again with this proc so rip
	busy_action = TRUE
	playsound(get_turf(H), "rustle", rand(50,100), 1, SOUND_DISTANCE(7))
	H.visible_message(span_notice("[H] starts reloading \the [src]..."), span_notice("You start looking for some ammunition to reload \the [src] with..."), span_notice("You hear the clinking of metal..."))
	if(!do_after(H, reloading_time, TRUE, src, TRUE, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE))
		busy_action = FALSE
		return FALSE

	//First, search for compatible magazines in some predictable locations. Let's not search every item on them to save compute time. Skips organs and other weird stuff by doing it this way.
	var/list/validmags = list()
	var/list/yourstuff = H?.contents + H?.belt?.contents + H?.back?.contents + H?.wear_suit?.contents + H?.shoes?.contents + H?.head?.contents + H?.l_store?.contents + H?.r_store?.contents + H?.s_store?.contents + H?.wear_neck?.contents
	for(var/obj/item/ammo_box/magazine/M in yourstuff)
		var/rounds = LAZYLEN(M.stored_ammo)
		if(rounds > 0 && is_magazine_allowed(M))//valid mags have ammo and are allowed to be inserted into your gun
			validmags[M] = rounds
	yourstuff = null

	//Then, try to insert the one with the most ammo in it.
	if(LAZYLEN(validmags))
		sortTim(validmags, /proc/cmp_numeric_dsc, TRUE)//Sort them by most filled to least filled.
		for(var/obj/item/ammo_box/magazine/M in validmags)
			var/obj/magloc = isobj(M.loc) ? M.loc : null
			if(isgun(magloc))// Don't swap magazines with two guns.
				continue
			var/obj/oldmag = isobj(magazine) ? magazine : null
			if(H.has_direct_access_to(M, STORAGE_VIEW_DEPTH) && attackby(M, user))//Actually reload the gun
				if(magloc && oldmag)
					if(!magloc.attackby(oldmag, user))// Try to put your old mag in the new one's place
						H.quick_equip(oldmag)// If that fails, quick equip it.
				break//If we loaded a new mag successfully, stop
	else
		to_chat(H, span_alert("You couldn't find any filled magazines that fit \the [src]!"))
		busy_action = FALSE
		return FALSE

	busy_action = FALSE
	return TRUE
