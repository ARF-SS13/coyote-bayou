#define DUMMY_PRUNE_SIZE 3
#define DUMMY_RANDOM_DESIRED_SIZE 20

SUBSYSTEM_DEF(dummy) // who ya callin dummy, dummy?
	name = "Dummy"
	flags = SS_BACKGROUND
	wait = 30 MINUTES

	/// List of all dummies
	var/list/all_dummies = list()
	/// List of images of naked mobs
	/// list("mob_key" = image)
	var/list/image_cache = list()
	/// random mob images
	var/list/random_image_cache = list()
	/// random mob images
	var/list/random_naked_image_cache = list()
	/// Pictures of everyone at various moments, naked~
	/// list("ckey" = list(image, image, image))
	var/list/naked_player_cache = list()
	/// Pictures of everyone at various moments, clothed~
	/// list("ckey" = list(image, image, image))
	var/list/very_naked_player_cache = list()
	/// Pictures of everyone at various moments, clothed~
	/// list("ckey" = list(image, image, image))
	var/list/clothed_player_cache = list()
	/// Pictures of everyone at various moments, clothed~
	/// list("ckey" = list(image, image, image))
	var/list/randomclothed_player_cache = list()
	COOLDOWN_DECLARE(snapshot_cooldown)

/datum/controller/subsystem/dummy/fire(resumed)
	// if(LAZYLEN(all_dummies) < DUMMY_PRUNE_SIZE)
	// 	return
	// for(var/mob/living/carbon/human/dummy/dummy in all_dummies)
	// 	if(COOLDOWN_FINISHED(dummy, unuse_timer))
	// 		unregister_dummy(dummy)
	// 		qdel(dummy)
	//capture_snapshot_of_players() surprise, it doesnt work

/datum/controller/subsystem/dummy/proc/get_a_dummy()
	var/mob/living/carbon/human/dummy/D
	for(var/mob/living/carbon/human/dummy/dum in all_dummies)
		if(!dum.in_use && !QDELETED(dum))
			D = dum
			break
	if(!D)
		D = new()
		register_dummy(D)
	D.in_use = TRUE
	D.wipe_state() // please please PLEASE stop broadcasting random peoples' genitals
	COOLDOWN_START(D, unuse_timer, 20 MINUTES)
	D.setDir(SOUTH)
	return D

/datum/controller/subsystem/dummy/proc/register_dummy(mob/living/carbon/human/dummy/D)
	all_dummies |= D
	return D

/datum/controller/subsystem/dummy/proc/unregister_dummy(mob/living/carbon/human/dummy/D)
	all_dummies -= D

/datum/controller/subsystem/dummy/proc/return_dummy(mob/living/carbon/human/dummy/D)
	if(istype(D))
		D.wipe_state()
		D.in_use = FALSE

/datum/controller/subsystem/dummy/proc/get_dummy_image(
		slotkey,
		datum/species/spec,
		datum/outfit/clothes,
		mob/living/carbon/human/template,
		client_or_prefs,
		loadout,
		random_body,
		random_species,
		random_clothes,
		copy_equipment,
		genitals,
		cache = TRUE,
		underwear = TRUE,
	)
	var/image_key = generate_key(slotkey, spec, clothes, template, client_or_prefs, loadout, random_body, random_species, random_clothes, copy_equipment, genitals, cache)
	if(LAZYACCESS(image_cache, image_key))
		return image_cache[image_key]
	var/mob/living/carbon/human/dummy/mannequin = get_a_dummy()
	if(!mannequin)
		return
	var/client/clint
	if(client_or_prefs)
		if(istype(client_or_prefs, /client))
			clint = client_or_prefs
		else if (istype(client_or_prefs, /datum/preferences))
			var/datum/preferences/P = client_or_prefs
			clint = P.parent
	else if(istype(template) && template.client)
		clint = template.client
	if(!template && ishuman(clint.mob))
		template = clint.mob

	if(istype(clint))
		var/datum/preferences/P = clint.prefs
		P?.copy_to(mannequin)
	if(istype(template))
		copy_human_mob(template, mannequin)
		if(copy_equipment)
			copy_equipped(template, mannequin)
	else
		if(random_species && !ispath(spec))
			spec = pick(list(/datum/species/human, /datum/species/lizard, /datum/species/mammal))
		if(ispath(spec))
			mannequin.set_species(spec)
		if(random_body)
			randomize_human(mannequin, spec, underwear, genitals)
	if(random_clothes)
		if(!ispath(clothes))
			clothes = pick(subtypesof(/datum/outfit/job))
		else
			random_clothes = FALSE
			clothes = new clothes()
			clothes.equip(mannequin, TRUE, clint)
	if(!genitals)
		for(var/obj/item/organ/genital/nad in mannequin.internal_organs)
			qdel(nad) // say bye to ur naddies
	if(!underwear)
		mannequin.underwear = "Nude"
		mannequin.socks = "Nude"
		mannequin.undershirt = "Nude"
	
	mannequin.update_body(TRUE)
	mannequin.update_hair()
	mannequin.update_body_parts()
	COMPILE_OVERLAYS(mannequin)
	/// and snap a photo
	var/image/photo = image(new/mutable_appearance(mannequin))
	/// and save it
	image_cache[image_key] = photo
	/// return the manned mannequin
	return_dummy(mannequin)
	/// and mail out the photo
	return photo

/datum/controller/subsystem/dummy/proc/generate_key(slotkey, datum/species/spec, datum/outfit/clothes, mob/living/carbon/human/template, client/clint, random_body, random_species, random_clothes, copy_equipment, genitals, cache)
	. = "dummy"
	if(slotkey)
		. += "-[slotkey]"
	if(ispath(spec))
		. += "-[initial(spec.id)]"
	if(ispath(clothes))
		. += "-[initial(clothes.name)]"
	if(istype(template))
		. += "-[template.real_name]"
	if(istype(clint) && clint.prefs)
		. += "-[clint.prefs.real_name]"
	if(copy_equipment)
		. += "-COPY_EQUIP"
		var/list/equipment
		if(istype(template))
			equipment = template.get_body_slots()
		else if(istype(clint) && ishuman(clint.mob))
			var/mob/living/carbon/human/H = clint.mob
			equipment = H.get_body_slots()
			for(var/obj/item/I in equipment)
				. += "+[I.name]"
	if(genitals)
		. += "-GENITALS"
	if(random_body)
		. += "-RANDOM_BOD[rand(10000, 99999)]"
	if(random_species)
		. += "-RANDOM_SPEC[rand(10000, 99999)]"
	if(random_clothes)
		. += "-RANDOM_CLOTHES[rand(10000, 99999)]"
	if(!cache)
		. += "-[round(world.time, 1)]"
	

//This proc attempts to create a dummy which is an exact copy of a passed human, including all of their equipment.
//Attempts being the key word, it is far from flawless. Notably it will not copy...:
	//Post-spawn body changes, eg mutations gained or limbs lost during a round
	//Items held in the hand
	//Items stored in any container on the person
/datum/controller/subsystem/dummy/proc/copy_human_mob(mob/living/carbon/human/template, mob/living/carbon/human/dummy/target)
	if(!ishuman(template) || !ishuman(target))
		return
	target.set_species(template?.dna.species)
	target.gender 					= template.gender
	target.real_name 				= template.real_name
	target.name 					= template.name
	target.underwear 				= template.underwear
	target.undie_color 				= template.undie_color
	target.undershirt 				= template.undershirt
	target.shirt_color 				= template.shirt_color
	target.dna.skin_tone_override 	= template.dna.skin_tone_override
	target.skin_tone 				= template.skin_tone
	target.hair_style 				= template.hair_style
	target.facial_hair_style 		= template.facial_hair_style
	target.hair_color 				= template.hair_color
	target.facial_hair_color 		= template.facial_hair_color
	target.left_eye_color 			= template.left_eye_color
	target.right_eye_color 			= template.right_eye_color
	target.dna.blood_type 			= template.dna.blood_type
	target.saved_underwear 			= template.saved_underwear
	target.saved_undershirt 		= template.saved_undershirt
	target.saved_socks 				= template.saved_socks
	for(var/feature in template.dna.features)
		target.dna.features[feature] = template.dna.features[feature]
	return target

/datum/controller/subsystem/dummy/proc/copy_equipped(mob/living/carbon/human/template, mob/living/carbon/human/dummy/target)
	if(!ishuman(template) || !ishuman(target))
		return
	for(var/slot in ALL_EQUIP_SLOTS)
		if(!istype(template.vars[slot], /datum))
			continue
		var/datum/olditem = template.vars[slot]
		target.vars[slot] = new olditem.type(target)
	return target

/datum/controller/subsystem/dummy/proc/get_clothed_dummy_image()
	if(!LAZYLEN(random_image_cache))
		build_random_image_cache()
	var/image/photo = pick(random_image_cache)
	if(!photo)
		return get_dummy_image("ANYONE", random_body = TRUE, random_species = TRUE, random_clothes = TRUE)
	return photo

/datum/controller/subsystem/dummy/proc/get_naked_dummy_image()
	if(!LAZYLEN(random_naked_image_cache))
		build_random_image_cache()
	var/image/photo = pick(random_naked_image_cache)
	if(!photo)
		return get_dummy_image("ANYONE", random_body = TRUE, random_species = TRUE, random_clothes = FALSE)
	return photo

/datum/controller/subsystem/dummy/proc/build_random_image_cache()
	if(LAZYLEN(random_image_cache) >= DUMMY_RANDOM_DESIRED_SIZE)
		return
	for(var/i in 1 to DUMMY_RANDOM_DESIRED_SIZE)
		var/image/photo = get_dummy_image("ANYONE", random_body = TRUE, random_species = TRUE, random_clothes = TRUE)
		if(!photo)
			continue
		random_image_cache[photo] = TRUE
	for(var/i in 1 to DUMMY_RANDOM_DESIRED_SIZE)
		var/image/photo = get_dummy_image("ANYONE", random_body = TRUE, random_species = TRUE, random_clothes = FALSE)
		if(!photo)
			continue
		random_naked_image_cache[photo] = TRUE

/datum/controller/subsystem/dummy/proc/get_player_image(client_or_mob, equipped = FALSE)
	var/randokey
	var/client/clont
	var/mob/living/carbon/human/H
	if(istype(client_or_mob, /mob/living/carbon/human))
		H = client_or_mob
		if(H.client)
			clont = H.client
		randokey = H.real_name
	else if(istype(client_or_mob, /client))
		clont = client_or_mob
		if(ishuman(clont.mob))
			H = clont.mob
		randokey = clont.prefs.real_name
	if(!randokey)
		if(!LAZYLEN(GLOB.clients)) // how?
			return get_dummy_image("PLAYER", random_body = TRUE, random_species = TRUE, random_clothes = TRUE)
		clont = pick(GLOB.clients)
		if(ishuman(clont.mob))
			H = clont.mob
		randokey = clont.prefs.real_name
	for(var/slutkey in image_cache)
		if(findtext(slutkey, randokey))
			return LAZYACCESS(image_cache, slutkey)
	return get_dummy_image("PLAYER", template = H, client_or_prefs = clont, copy_equipment = equipped)

/datum/controller/subsystem/dummy/proc/capture_snapshot_of_players()
	for(var/client/C in GLOB.clients)
		snapshot_player(C)

/datum/controller/subsystem/dummy/proc/snapshot_player(client_or_ckey)
	var/mob/living/carbon/human/H
	var/client/C
	if(isclient(client_or_ckey))
		C = client_or_ckey
		H = C.mob
	else if(istext(client_or_ckey))
		C = LAZYACCESS(GLOB.directory, client_or_ckey)
		if(!C)
			return
		H = C.mob
	if(!ishuman(H))
		return
	if(!LAZYACCESS(very_naked_player_cache, "[C.ckey]%%[H.real_name]"))
		very_naked_player_cache["[C.ckey]%%[H.real_name]"] = list()
	if(!LAZYACCESS(naked_player_cache, "[C.ckey]%%[H.real_name]"))
		naked_player_cache["[C.ckey]%%[H.real_name]"] = list()
	if(!LAZYACCESS(clothed_player_cache, "[C.ckey]%%[H.real_name]"))
		clothed_player_cache["[C.ckey]%%[H.real_name]"] = list()
	if(!LAZYACCESS(randomclothed_player_cache, "[C.ckey]%%[H.real_name]"))
		randomclothed_player_cache["[C.ckey]%%[H.real_name]"] = list()
	var/image/naked = get_dummy_image("PLAYER", template = H, client_or_prefs = C, random_body = FALSE, random_species = FALSE, random_clothes = FALSE)
	var/image/supernaked = get_dummy_image("PLAYER", template = H, client_or_prefs = C, random_body = FALSE, random_species = FALSE, random_clothes = FALSE, underwear = FALSE, genitals = TRUE)
	var/image/clothed = get_dummy_image("PLAYER", template = H, client_or_prefs = C, random_body = FALSE, random_species = FALSE, random_clothes = FALSE, copy_equipment = TRUE)
	var/image/clothed2 = get_dummy_image("PLAYER", template = H, client_or_prefs = C, random_body = FALSE, random_species = FALSE, random_clothes = TRUE)
	if(naked)
		naked_player_cache["[C.ckey]%%[H.real_name]"] |= naked
	if(supernaked)
		very_naked_player_cache["[C.ckey]%%[H.real_name]"] |= supernaked
	if(clothed)
		clothed_player_cache["[C.ckey]%%[H.real_name]"] |= clothed
	if(clothed2)
		randomclothed_player_cache["[C.ckey]%%[H.real_name]"] |= clothed2

/mob/living/carbon/human/dummy
	real_name = "Test Dummy"
	status_flags = GODMODE|CANPUSH
	mouse_drag_pointer = MOUSE_INACTIVE_POINTER
	put_away_them_grippers_hooh_you_got_them_grippers = TRUE
	var/in_use = FALSE
	var/dummyckey
	COOLDOWN_DECLARE(unuse_timer)

INITIALIZE_IMMEDIATE(/mob/living/carbon/human/dummy)

/mob/living/carbon/human/dummy/Destroy()
	in_use = FALSE
	SSdummy.unregister_dummy(src)
	return ..()

/mob/living/carbon/human/dummy/Life()
	return

/mob/living/carbon/human/dummy/update_mobility()
	return

/mob/living/carbon/human/dummy/proc/wipe_state()
	delete_equipment()
	set_species(/datum/species/human)
	dna.initialize_dna("B+", randomise = TRUE)
	icon_render_key = null
	transform = initial(transform)
	dummyckey = null
	destroy_genitals()
	cut_overlays()
	if(loc)
		moveToNullspace()

//Inefficient pooling/caching way.
// GLOBAL_LIST_EMPTY(human_dummy_list)
// GLOBAL_LIST_EMPTY(all_dummies)

//proc/generate_or_wait_for_human_dummy(slotkey)




