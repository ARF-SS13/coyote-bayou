
/mob/living/carbon/human/restrained(ignore_grab)
	. = ((wear_suit && wear_suit.breakouttime) || ..())


/mob/living/carbon/human/canBeHandcuffed()
	if(get_num_arms(FALSE) >= 2)
		return TRUE
	else
		return FALSE

//gets assignment from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_assignment(if_no_id = "No id", if_no_job = "No job", hand_first = TRUE)
	var/obj/item/card/id/id = get_idcard(hand_first)
	if(id)
		. = id.assignment
	else
		var/obj/item/pda/pda = wear_id
		if(istype(pda))
			. = pda.ownjob
		else
			return if_no_id
	if(!.)
		return if_no_job

//gets name from ID or ID inside PDA or PDA itself
//Useful when player do something with computers
/mob/living/carbon/human/proc/get_authentification_name(if_no_id = "Unknown")
	var/obj/item/card/id/id = get_idcard(FALSE)
	if(id)
		return id.registered_name
	var/obj/item/pda/pda = wear_id
	if(istype(pda))
		return pda.owner
	return if_no_id

//repurposed proc. Now it combines get_id_name() and get_face_name() to determine a mob's name variable. Made into a separate proc as it'll be useful elsewhere
/mob/living/carbon/human/get_visible_name()
	var/face_name = get_face_name("")
	var/id_name = get_id_name("")
	if(name_override)
		return name_override
	if(face_name)
		if(id_name && (id_name != face_name))
			return "[face_name] (as [id_name])"
		return face_name
	if(id_name)
		return id_name
	return "Unknown"

//Returns "Unknown" if facially disfigured and real_name if not. Useful for setting name when Fluacided or when updating a human's name variable
/mob/living/carbon/human/proc/get_face_name(if_no_face="Unknown")
	if(real_name && HAS_TRAIT(src, TRAIT_NOHIDEFACE))
		return real_name
	if(wear_mask && (wear_mask.flags_inv&HIDEFACE)) //Wearing a mask which hides our face, use id-name if possible
		return if_no_face
	if( head && (head.flags_inv&HIDEFACE) )
		return if_no_face		//Likewise for hats
	var/obj/item/bodypart/O = get_bodypart(BODY_ZONE_HEAD)
	if( !O || (HAS_TRAIT(src, TRAIT_DISFIGURED)) || (O.brutestate+O.burnstate)>2 || cloneloss>50 || !real_name)	//disfigured. use id-name if possible
		return if_no_face
	return real_name

//gets name from ID or PDA itself, ID inside PDA doesn't matter
//Useful when player is being seen by other mobs
/mob/living/carbon/human/proc/get_id_name(if_no_id = "Unknown")
	var/obj/item/storage/wallet/wallet = wear_id
	var/obj/item/pda/pda = wear_id
	var/obj/item/card/id/id = wear_id
	var/obj/item/modular_computer/tablet/tablet = wear_id
	if(istype(wallet))
		id = wallet.front_id
	if(istype(id))
		. = id.registered_name
	else if(istype(pda))
		. = pda.owner
	else if(istype(tablet))
		var/obj/item/computer_hardware/card_slot/card_slot = tablet.all_components[MC_CARD]
		if(card_slot?.stored_card)
			. = card_slot.stored_card.registered_name
	if(!.)
		. = if_no_id	//to prevent null-names making the mob unclickable
	return

//gets ID card object from special clothes slot or null.
/mob/living/carbon/human/get_idcard(hand_first = TRUE)
	. = ..()
	if(. && hand_first)
		return
	//Check inventory slots
	var/obj/item/card/id/id_card = wear_id?.GetID()
	if(!id_card)
		id_card = belt?.GetID()
	return id_card || .

/mob/living/carbon/human/IsAdvancedToolUser()
	if(HAS_TRAIT(src, TRAIT_MONKEYLIKE))
		return FALSE
	return TRUE//Humans can use guns and such

/mob/living/carbon/human/reagent_check(datum/reagent/R)
	return dna.species.handle_chemicals(R,src)
	// if it returns 0, it will run the usual on_mob_life for that reagent. otherwise, it will stop after running handle_chemicals for the species.

/mob/living/carbon/human/can_track(mob/living/user)
	if(wear_id && istype(wear_id.GetID(), /obj/item/card/id/syndicate))
		return 0
	if(istype(head, /obj/item/clothing/head))
		var/obj/item/clothing/head/hat = head
		if(hat.blockTracking)
			return 0

	return ..()

/mob/living/carbon/human/can_use_guns(obj/item/G)
	. = ..()
	if(!.)
		return
	if(G.trigger_guard == TRIGGER_GUARD_NORMAL)
		if(HAS_TRAIT(src, TRAIT_CHUNKYFINGERS))
			to_chat(src, span_warning("Your meaty finger is much too large for the trigger guard!"))
			return FALSE
		if(HAS_TRAIT(src, TRAIT_NOGUNS))
			to_chat(src, span_warning("Your fingers don't fit in the trigger guard!"))
			return FALSE

/mob/living/carbon/human/proc/get_bank_account()
	RETURN_TYPE(/datum/bank_account)
	var/datum/bank_account/account
	var/obj/item/card/id/I = get_idcard()

	if(I && I.registered_account)
		account = I.registered_account
		return account

	return FALSE

/mob/living/carbon/human/can_see_reagents()
	. = ..()
	if(.) //No need to run through all of this if it's already true.
		return
	if(isclothing(glasses) && (glasses.clothing_flags & SCAN_REAGENTS))
		return TRUE

/*
/mob/living/carbon/human/transfer_blood_dna(list/blood_dna)
	..()
	if(blood_dna.len)
		last_bloodtype = blood_dna[blood_dna[blood_dna.len]]//trust me this works
		last_blood_DNA = blood_dna[blood_dna.len]*/

/// For use formatting all of the scars this human has for saving for persistent scarring
/mob/living/carbon/human/proc/format_scars()
	var/list/missing_bodyparts = get_missing_limbs()
	if(!all_scars && !length(missing_bodyparts))
		return
	var/scars = ""
	for(var/i in missing_bodyparts)
		var/datum/scar/scaries = new
		scars += "[scaries.format_amputated(i)]"
	for(var/i in all_scars)
		var/datum/scar/scaries = i
		scars += "[scaries.format()];"
	return scars

/// Takes a single scar from the persistent scar loader and recreates it from the saved data
/mob/living/carbon/human/proc/load_scar(scar_line)
	var/list/scar_data = splittext(scar_line, "|")
	if(LAZYLEN(scar_data) != SCAR_SAVE_LENGTH)
		return // invalid, should delete
	var/version = text2num(scar_data[SCAR_SAVE_VERS])
	if(!version || version < SCAR_CURRENT_VERSION) // get rid of old scars
		return
	var/obj/item/bodypart/the_part = get_bodypart("[scar_data[SCAR_SAVE_ZONE]]")
	var/datum/scar/scaries = new
	return scaries.load(the_part, scar_data[SCAR_SAVE_VERS], scar_data[SCAR_SAVE_DESC], scar_data[SCAR_SAVE_PRECISE_LOCATION], text2num(scar_data[SCAR_SAVE_SEVERITY]))

/mob/living/carbon/human/get_biological_state()
	return dna.species.get_biological_state()

/// permanent tattoo procs

/// turn all tattoos into one long, formatted string
/mob/living/carbon/human/proc/format_tattoos()
	var/tats = ""
	for(var/obj/item/bodypart/i in bodyparts)
		for(var/tatspot in i.tattoos)
			var/datum/tattoo/tat = i.tattoos[tatspot]
			if(!isnull(tat) && tat.is_permanent == TRUE)
				tats += "[tat.name]|[tat.desc]|[tat.extra_desc]|[tat.tat_location];"
	return tats

/// turn part of a formatted string into one tattoo
/mob/living/carbon/human/proc/load_tattoo(tattoo_string)
	var/list/tat_dat = splittext(tattoo_string, "|")
	if(LAZYLEN(tat_dat) != 4)
		return

	var/obj/item/bodypart/part = get_part_from_tat_zone(tat_dat[4])
	if(isnull(part))
		return

	var/datum/tattoo/blank/tat = new()
	tat.name = tat_dat[1]
	tat.desc = tat_dat[2]
	tat.extra_desc = tat_dat[3]
	tat.tat_location = tat_dat[4]
	tat.fade_time = null
	tat.is_permanent = TRUE

	part.add_tattoo(tat, tat.tat_location)
	return tat

///turn one long, formatted string into all tattoos that should be on a character
/mob/living/carbon/human/proc/load_all_tattoos(full_tattoo_string)
	var/list/strings = splittext(full_tattoo_string, ";")
	for(var/i in strings)
		load_tattoo(i)

///convert a tattoo location into a bodypart
/mob/living/carbon/human/proc/get_part_from_tat_zone(tat_zone)
	for(var/key in GLOB.tattoo_locations)
		if(tat_zone in GLOB.tattoo_locations[key])
			return get_bodypart(key)
	return null
