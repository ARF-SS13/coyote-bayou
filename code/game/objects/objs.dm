
/obj
	var/crit_fail = FALSE
	animate_movement = 2
	speech_span = SPAN_ROBOT
	vis_flags = VIS_INHERIT_PLANE //when this be added to vis_contents of something it inherit something.plane, important for visualisation of obj in openspace.
	var/obj_flags = CAN_BE_HIT
	var/set_obj_flags // ONLY FOR MAPPING: Sets flags from a string list, handled in Initialize. Usage: set_obj_flags = "EMAGGED;!CAN_BE_HIT" to set EMAGGED and clear CAN_BE_HIT.

	var/damtype = BRUTE
	var/force = 0

	/// How much extra force does this item have over the base version of this item. Helps properly calculate damage and dps when examining weapons without relying on the force variable which changes frequently
	var/force_bonus = 0
	/// How good a given object is at causing wounds on carbons. Higher values equal better shots at creating serious wounds.
	var/wound_bonus = 0
	/// If this attacks a human with no wound armor on the affected body part, add this to the wound mod. Some attacks may be significantly worse at wounding if there's even a slight layer of armor to absorb some of it vs bare flesh
	var/bare_wound_bonus = 0

	var/datum/armor/armor
	var/obj_integrity	//defaults to max_integrity
	var/max_integrity = 500
	var/super_advanced_technology = FALSE
	var/integrity_failure = 0 //0 if we have no special broken behavior, otherwise is a percentage of at what point the obj breaks. 0.5 being 50%

	var/resistance_flags = NONE // INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ON_FIRE | UNACIDABLE | ACID_PROOF

	var/acid_level = 0 //how much acid is on that obj

	var/persistence_replacement //have something WAY too amazing to live to the next round? Set a new path here. Overuse of this var will make me upset.

	// Access levels, used in modules\jobs\access.dm
	var/list/req_access
	var/req_access_txt = "0"
	var/list/req_one_access
	var/req_one_access_txt = "0"

	var/renamedByPlayer = FALSE //set when a player uses a pen on a renamable object

	//Was this item rotated? if so, how much? (only working with Edit Vars verb for now)
	var/is_tilted

/obj/vv_edit_var(vname, vval)
	switch(vname)
		if("anchored")
			setAnchored(vval)
			return TRUE
		if(NAMEOF(src, obj_flags))
			if ((obj_flags & DANGEROUS_POSSESSION) && !(vval & DANGEROUS_POSSESSION))
				return FALSE
	return ..()

/obj/Initialize()
	setup_armor_values()
	if (islist(armor))
		armor = getArmor(arglist(armor))
	/*
	else if (!armor)
		armor = getArmor()
	else if (!istype(armor, /datum/armor))
		stack_trace("Invalid type [armor.type] found in .armor during /obj Initialize()")
	*/
	if(obj_integrity == null)
		obj_integrity = max_integrity

	. = ..() //Do this after, else mat datums is mad.

	if (set_obj_flags)
		var/flagslist = splittext(set_obj_flags,";")
		var/list/string_to_objflag = GLOB.bitfields["obj_flags"]
		for (var/flag in flagslist)
			if(flag[1] == "!")
				flag = copytext(flag, length(flag[1]) + 1) // Get all but the initial !
				obj_flags &= ~string_to_objflag[flag]
			else
				obj_flags |= string_to_objflag[flag]
	if((obj_flags & ON_BLUEPRINTS) && isturf(loc))
		var/turf/T = loc
		T.add_blueprints_preround(src)

	add_debris_element()

/obj/Destroy(force=FALSE)
	if(!ismachinery(src))
		STOP_PROCESSING(SSobj, src) // TODO: Have a processing bitflag to reduce on unnecessary loops through the processing lists
	SStgui.close_uis(src)
	. = ..()

/obj/proc/setAnchored(anchorvalue)
	SEND_SIGNAL(src, COMSIG_OBJ_SETANCHORED, anchorvalue)
	anchored = anchorvalue

/obj/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, messy_throw = TRUE)
	. = ..()
	if(obj_flags & FROZEN)
		visible_message(span_danger("[src] shatters into a million pieces!"))
		qdel(src)

/obj/assume_air(datum/gas_mixture/giver)
	return TRUE

/obj/assume_air_moles(datum/gas_mixture/giver, moles)
	return TRUE

/obj/assume_air_ratio(datum/gas_mixture/giver, ratio)
	return TRUE

/obj/transfer_air(datum/gas_mixture/taker, moles)
	return TRUE

/obj/transfer_air_ratio(datum/gas_mixture/taker, ratio)
	return TRUE


/obj/remove_air(amount)
	return TRUE

/obj/remove_air_ratio(ratio)
	return TRUE

/obj/return_air()
	return TRUE

/obj/proc/handle_internal_lifeform(mob/lifeform_inside_me, breath_request)
	//Return: (NONSTANDARD)
	//		null if object handles breathing logic for lifeform
	//		datum/air_group to tell lifeform to process using that breath return
	//DEFAULT: Take air from turf to give to have mob process

	if(breath_request>0)
		var/datum/gas_mixture/environment = return_air()
		return remove_air_ratio(BREATH_VOLUME / environment.return_volume())
	else
		return null

/obj/proc/updateUsrDialog()
	if((obj_flags & IN_USE) && !(obj_flags & USES_TGUI))
		var/is_in_use = FALSE
		var/list/nearby = fov_viewers(1, src)
		for(var/mob/M in nearby)
			if ((M.client && M.machine == src))
				is_in_use = TRUE
				ui_interact(M)
		if(usr && hasSiliconAccessInArea(usr) && !(usr in nearby))
			if (usr.client && usr.machine==src) // && M.machine == src is omitted because if we triggered this by using the dialog, it doesn't matter if our machine changed in between triggering it and this - the dialog is probably still supposed to refresh.
				is_in_use = TRUE
				ui_interact(usr)

		// check for TK users

		if(ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(!(usr in nearby))
				if(usr.client && usr.machine==src)
					if(H.dna.check_mutation(TK))
						is_in_use = TRUE
						ui_interact(usr)
		if (is_in_use)
			obj_flags |= IN_USE
		else
			obj_flags &= ~IN_USE

/obj/proc/updateDialog(update_viewers = TRUE,update_ais = TRUE)
	// Check that people are actually using the machine. If not, don't update anymore.
	if(obj_flags & IN_USE)
		var/is_in_use = FALSE
		if(update_viewers)
			for(var/mob/M in fov_viewers(1, src))
				if ((M.client && M.machine == src))
					is_in_use = TRUE
					src.interact(M)
		var/ai_in_use = FALSE
		if(update_ais)
			ai_in_use = AutoUpdateAI(src)

		if(update_viewers && update_ais) //State change is sure only if we check both
			if(!ai_in_use && !is_in_use)
				obj_flags &= ~IN_USE


/obj/attack_ghost(mob/user)
	. = ..()
	if(.)
		return
	ui_interact(user)

/obj/proc/container_resist(mob/living/user)
	return

/mob/proc/unset_machine()
	if(machine)
		machine.on_unset_machine(src)
		machine = null

//called when the user unsets the machine.
/atom/proc/on_unset_machine(mob/user)
	return

/mob/proc/set_machine(obj/O)
	if(src.machine)
		unset_machine()
	src.machine = O
	if(istype(O))
		O.obj_flags |= IN_USE

/obj/item/proc/updateSelfDialog()
	var/mob/M = src.loc
	if(istype(M) && M.client && M.machine == src)
		src.attack_self(M)

/obj/proc/hide(h)
	return

/obj/singularity_pull(S, current_size)
	..()
	if(!anchored || current_size >= STAGE_FIVE)
		step_towards(src,S)

/obj/get_dumping_location(datum/component/storage/source,mob/user)
	return get_turf(src)

/**
 * This proc is used for telling whether something can pass by this object in a given direction, for use by the pathfinding system.
 *
 * Trying to generate one long path across the station will call this proc on every single object on every single tile that we're seeing if we can move through, likely
 * multiple times per tile since we're likely checking if we can access said tile from multiple directions, so keep these as lightweight as possible.
 *
 * Arguments:
 * * ID- An ID card representing what access we have (and thus if we can open things like airlocks or windows to pass through them). The ID card's physical location does not matter, just the reference
 * * to_dir- What direction we're trying to move in, relevant for things like directional windows that only block movement in certain directions
 * * caller- The movable we're checking pass flags for, if we're making any such checks
 **/
/obj/proc/CanAStarPass(obj/item/card/id/ID, to_dir, atom/movable/caller)
	if(istype(caller) && (caller.pass_flags & pass_flags_self))
		return TRUE
	. = !density

/obj/proc/check_uplink_validity()
	return 1

/obj/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---")
	VV_DROPDOWN_OPTION(VV_HK_MASS_DEL_TYPE, "Delete all of type")
	VV_DROPDOWN_OPTION(VV_HK_OSAY, "Object Say")
	VV_DROPDOWN_OPTION(VV_HK_ARMOR_MOD, "Modify armor values")

/obj/vv_do_topic(list/href_list)
	if(!(. = ..()))
		return
	if(href_list[VV_HK_OSAY])
		if(check_rights(R_FUN, FALSE))
			usr.client.object_say(src)
	if(href_list[VV_HK_ARMOR_MOD])
		var/list/pickerlist = list()
		var/list/armorlist = armor.getList()

		for (var/i in armorlist)
			pickerlist += list(list("value" = armorlist[i], "name" = i))

		var/list/result = presentpicker(usr, "Modify armor", "Modify armor: [src]", Button1="Save", Button2 = "Cancel", Timeout=FALSE, inputtype = "text", values = pickerlist)

		if (islist(result))
			if (result["button"] != 2) // If the user pressed the cancel button
				// text2num conveniently returns a null on invalid values
				armor = armor.setRating(melee = text2num(result["values"]["melee"]),\
							bullet = text2num(result["values"]["bullet"]),\
							laser = text2num(result["values"]["laser"]),\
							energy = text2num(result["values"]["energy"]),\
							bomb = text2num(result["values"]["bomb"]),\
							bio = text2num(result["values"]["bio"]),\
							rad = text2num(result["values"]["rad"]),\
							fire = text2num(result["values"]["fire"]),\
							acid = text2num(result["values"]["acid"]),\
							melee = text2num(result["values"]["melee"]),\
							bullet = text2num(result["values"]["bullet"]),\
							laser = text2num(result["values"]["laser"])
							)
				log_admin("[key_name(usr)] modified the armor on [src] ([type]) to  melee: [armor.melee], bullet: [armor.bullet], laser: [armor.laser] energy: [armor.energy], bomb: [armor.bomb], bio: [armor.bio], rad: [armor.rad], fire: [armor.fire], acid: [armor.acid]")
				message_admins(span_notice("[key_name_admin(usr)] modified the armor on [src] ([type]) to melee: [armor.melee], bullet: [armor.bullet], laser: [armor.laser] energy: [armor.energy], bomb: [armor.bomb], bio: [armor.bio], rad: [armor.rad], fire: [armor.fire], acid: [armor.acid]"))
	if(href_list[VV_HK_MASS_DEL_TYPE])
		if(check_rights(R_DEBUG|R_SERVER))
			var/action_type = alert("Strict type ([type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
			if(action_type == "Cancel" || !action_type)
				return

			if(alert("Are you really sure you want to delete all objects of type [type]?",,"Yes","No") != "Yes")
				return

			if(alert("Second confirmation required. Delete?",,"Yes","No") != "Yes")
				return

			var/O_type = type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/obj/Obj in world)
						if(Obj.type == O_type)
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted) "))
				if("Type and subtypes")
					var/i = 0
					for(var/obj/Obj in world)
						if(istype(Obj,O_type))
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No objects of this type exist")
						return
					log_admin("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted) "))

/obj/examine(mob/user)
	. = ..()
	if(obj_flags & UNIQUE_RENAME)
		. += span_notice("Use a pen on it to rename it or change its description.")
	if(SEND_SIGNAL(src, COMSIG_ITEM_RESKINNABLE))
		. += span_notice("Ctrl-Shift-Click this to reskin it!")

/obj/update_overlays()
	. = ..()
	if(acid_level)
		. += GLOB.acid_overlay
	if(resistance_flags & ON_FIRE)
		. += GLOB.fire_overlay

//Called when the object is constructed by an autolathe
//Has a reference to the autolathe so you can do !!FUN!! things with hacked lathes
/obj/proc/autolathe_crafted(obj/machinery/autolathe/A)
	return

/obj/proc/rnd_crafted(obj/machinery/rnd/production/P)
	return

/obj/handle_ricochet(obj/item/projectile/P)
	. = ..()
	if(. && ricochet_damage_mod)
		take_damage(P.damage * ricochet_damage_mod, P.damage_type, P.flag, 0, turn(P.dir, 180), P.armour_penetration, attacked_by = P.firer) // pass along ricochet_damage_mod damage to the structure for the ricochet

/obj/proc/plunger_act(obj/item/plunger/P, mob/living/user, reinforced)
	return

/obj/proc/setup_armor_values()
	if(!armor)
		return
	if(!islist(armor))
		return
