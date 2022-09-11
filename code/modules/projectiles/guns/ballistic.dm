/obj/item/gun/ballistic
	desc = "Now comes in flavors like GUN. Uses 10mm ammo, for some reason."
	name = "projectile gun"
	icon_state = "pistol"
	w_class = WEIGHT_CLASS_NORMAL
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
	var/en_bloc = 0

/obj/item/gun/ballistic/Initialize()
	. = ..()
	if(spawnwithmagazine)
		if (!magazine)
			if(init_mag_type)
				magazine = new init_mag_type(src)
			else
				magazine = new mag_type(src)
			if(magazine.fixed_mag)
				gun_tags |= GUN_INTERNAL_MAG
	allowed_mags |= mag_type
	allowed_mags |= typecacheof(mag_type)
	if(LAZYLEN(extra_mag_types))
		for(var/obj/item/ammo_box/ammo_type in extra_mag_types)
			allowed_mags |= ammo_type
	if(LAZYLEN(disallowed_mags))
		for(var/obj/item/ammo_box/un_ammo_type in disallowed_mags)
			allowed_mags -= un_ammo_type
	chamber_round()
	update_icon()

/obj/item/gun/ballistic/update_icon_state()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][sawn_off ? "-sawn" : ""]"
	else
		icon_state = "[initial(icon_state)][sawn_off ? "-sawn" : ""]"

/obj/item/gun/ballistic/process_chamber(mob/living/user, empty_chamber = 1)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		if(casing_ejector)
			AC.forceMove(drop_location()) //Eject casing onto ground.
			AC.bounce_away(TRUE)
			chambered = null
		else if(empty_chamber)
			chambered = null
	chamber_round()


/obj/item/gun/ballistic/proc/chamber_round()
	if (chambered || !magazine)
		return
	else if (magazine.ammo_count())
		chambered = magazine.get_round()
		chambered.forceMove(src)

/obj/item/gun/ballistic/can_shoot()
	if(!magazine || !magazine.ammo_count(0))
		return 0
	return 1

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
				update_icon()
				chamber_round(0)
				return TRUE

	if(istype(A, /obj/item/ammo_box))
		var/obj/item/ammo_box/new_mag = A
		if(magazine?.fixed_mag) // fixed mag, just load bullets in
			magazine.load_from_box(A, user, FALSE)
			update_icon()
			chamber_round(0)
			return TRUE
		// removable mag, eject the mag
		if(!is_magazine_allowed(new_mag, user)) // But only if the new mag would fit
			return FALSE
		if(istype(magazine))
			attack_self(user) //stop ejecting perfectly good shells!
		if(user.transferItemToLoc(new_mag, src))
			magazine = new_mag
			to_chat(user, span_notice("You load a new magazine into \the [src]."))
		else
			to_chat(user, span_warning("You cannot seem to get \the [new_mag] out of your hands!"))
			return FALSE
		if(magazine.ammo_count())
			playsound(src, "gun_insert_full_magazine", 70, 1)
			if(!chambered)
				chamber_round()
				addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/weapons/gun_chamber_round.ogg', 100, 1), 3)
		else
			playsound(src, "gun_insert_empty_magazine", 70, 1)
		new_mag.update_icon()
		update_icon()
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

/obj/item/gun/ballistic/attack_self(mob/living/user)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(magazine)
		if(en_bloc)
			magazine.forceMove(drop_location())
			user.dropItemToGround(magazine)
			magazine.update_icon()
			playsound(src, "sound/f13weapons/garand_ping.ogg", 70, 1)
			magazine = null
			to_chat(user, span_notice("You eject the enbloc clip out of \the [src]."))
		else
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


/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	if(istype(magazine) && magazine.fixed_mag && length(magazine.caliber))
		. += "It accepts [span_notice(english_list(magazine.caliber))]"
	. += "It has [span_notice("[get_ammo()]")] round\s remaining."

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

#define BRAINS_BLOWN_THROW_RANGE 3
#define BRAINS_BLOWN_THROW_SPEED 1
/obj/item/gun/ballistic/suicide_act(mob/living/user)
	var/obj/item/organ/brain/B = user.getorganslot(ORGAN_SLOT_BRAIN)
	if (B && chambered && chambered.BB && can_trigger_gun(user) && !chambered.BB.nodamage)
		user.visible_message(span_suicide("[user] is putting the barrel of [src] in [user.p_their()] mouth.  It looks like [user.p_theyre()] trying to commit suicide!"))
		sleep(25)
		if(user.is_holding(src))
			var/turf/T = get_turf(user)
			process_fire(user, user, FALSE, null, BODY_ZONE_HEAD)
			user.visible_message(span_suicide("[user] blows [user.p_their()] brain[user.p_s()] out with [src]!"))
			playsound(src, 'sound/weapons/dink.ogg', 30, 1)
			var/turf/target = get_ranged_target_turf(user, turn(user.dir, 180), BRAINS_BLOWN_THROW_RANGE)
			B.Remove()
			B.forceMove(T)
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				B.add_blood_DNA(C.dna, C.diseases)
			var/datum/callback/gibspawner = CALLBACK(user, /mob/living/proc/spawn_gibs, FALSE, B)
			B.throw_at(target, BRAINS_BLOWN_THROW_RANGE, BRAINS_BLOWN_THROW_SPEED, callback=gibspawner)
			return(BRUTELOSS)
		else
			user.visible_message(span_suicide("[user] panics and starts choking to death!"))
			return(OXYLOSS)
	else
		user.visible_message("<span class='suicide'>[user] is pretending to blow [user.p_their()] brain[user.p_s()] out with [src]! It looks like [user.p_theyre()] trying to commit suicide!</b></span>")
		playsound(src, "gun_dry_fire", 30, 1)
		return (OXYLOSS)
#undef BRAINS_BLOWN_THROW_SPEED
#undef BRAINS_BLOWN_THROW_RANGE

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
		w_class = WEIGHT_CLASS_NORMAL
		weapon_weight = GUN_ONE_HAND_ONLY // years of ERP made me realize wrists of steel isnt a good thing
		item_state = "gun"
		slot_flags |= ITEM_SLOT_BELT //but you can wear it on your belt (poorly concealed under a trenchcoat, ideally)
		recoil_dat.modifyAllRatings(2)
		cock_delay = GUN_COCK_SHOTGUN_FAST
		damage_multiplier *= GUN_LESS_DAMAGE_T2 // -15% damage
		sawn_off = TRUE
		gun_accuracy_zone_type = ZONE_WEIGHT_SHOTGUN
		init_firemodes = list(
			list(mode_name="Single-fire", mode_desc="Send Vagabonds flying back several paces", burst_size=1, icon="semi"),
		)
		initialize_firemodes()
		if(firemodes.len)
			set_firemode(sel_mode)
		update_icon()
		return 1

/obj/item/gun/ballistic/get_dud_projectile()
	var/proj_type
	if(chambered)
		if(!chambered.BB)
			return null
		proj_type = chambered.BB.type
	else if(magazine && get_ammo(0,0))
		var/obj/item/ammo_casing/A = magazine.stored_ammo[1]
		if(!A)
			return null
		if(!A.BB)
			return null
		proj_type = A.BB.type
	if(!proj_type)
		return null
	return new proj_type

/obj/item/gun/ballistic/ui_data(mob/user)
	var/list/data = ..()
	if(istype(magazine) && length(magazine.caliber))
		data["caliber"] = english_list(magazine.caliber)
	data["current_ammo"] = get_ammo()
	data["max_shells"] = get_max_ammo()

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
