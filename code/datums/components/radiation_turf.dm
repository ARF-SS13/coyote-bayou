/datum/component/radiation_turf
	/// rads per 2 seconds
	var/rads = 0
	/// refs to puddles that supposedly make this tile radioactive, used for tile-changes
	/// list("[0x4206900]" = /obj/item/thing) - double check!
	var/list/radioactive_things = list()
	/// our coordinates, for when our parent disappears and we need to latch on to something
	var/our_coordinates
	/// debug thing, makes flashing happen
	var/thingtoggle = FALSE
	/// it was debug-done
	var/was_debug = FALSE
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/radiation_turf/Initialize(rads_per_second, list/ref_n_type)
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isnull(rads_per_second))
		rads = rads_per_second
	if(!rads)
		return COMPONENT_INCOMPATIBLE // gotta have some rads
	if(!ref_n_type)
		return COMPONENT_INCOMPATIBLE // gotta have something irradiating us
	for(var/reff in ref_n_type)
		radioactive_things[reff] = ref_n_type[reff]
	var/turf/our_turf = parent
	our_coordinates = "[our_turf.x]:[our_turf.y]:[our_turf.z]"
	RegisterSignal(parent, list(COMSIG_TURF_CHECK_RADIATION), .proc/im_still_here)
	RegisterSignal(parent, list(COMSIG_TURF_IRRADIATE), .proc/update_rads)
	RegisterSignal(parent, list(COMSIG_ATOM_ENTERED), .proc/AddMob)
	RegisterSignal(parent, list(COMSIG_ATOM_EXITED), .proc/RemoveMob)
	RegisterSignal(parent, list(COMSIG_TURF_CHANGE), .proc/on_turf_change)
	START_PROCESSING(SSradiation, src)

// from this point onwards, we cannot rely on our parent to be our turf. 
// So, we'll have to sit here and treat whatever's at our coordinates *as* our parent 

/datum/component/radiation_turf/proc/AddMob(turf/the_turf, mob/living/carbon/human/glowy)
	if(!istype(glowy))
		return
	if(!check_puddles())
		return
	var/weakie = WEAKERREF(glowy)
	if(SSradiation.irradiated_mobs[weakie] < rads)
		SSradiation.irradiated_mobs[weakie] = rads

/datum/component/radiation_turf/proc/RemoveMob(turf/the_turf, mob/living/carbon/human/glowy)
	if(!istype(glowy))
		return
	var/weakie = WEAKERREF(glowy)
	SSradiation.irradiated_mobs -= weakie
	if(!check_puddles())
		return

/// Alter the tile's radiation up or down.
/// Also assume that if something added rads, its either new or changed a bit
/// And if it goes down, assume the thing was destroyed. either way, check if everything's okay
/datum/component/radiation_turf/proc/update_rads(turf/the_turf, rad_change = 0, reff, typee)
	if(rad_change <= 0)
		radioactive_things -= reff
	if((rads += rad_change) <= 0) // check if our tile is radioactive
		qdel(src)
		return
	var/atom/plip = RESOLVEREF(reff)
	if(plip && !QDELETED(plip))
		radioactive_things[reff] = typee
	if(!check_puddles()) // check if we're still tied to anything
		return
	return clamp(abs(rads), 0, (1<<23))

/// Checks if our puddles still exist
/datum/component/radiation_turf/proc/check_puddles()
	for(var/reffie in radioactive_things)
		var/atom/plip = RESOLVEREF(reffie)
		if(!plip)
			radioactive_things -= reffie
			continue
		if(QDELETED(plip))
			radioactive_things -= reffie
			continue
		if(plip.type != radioactive_things[reffie])
			radioactive_things -= reffie
			continue
		var/plipcoord = atom2coords(plip)
		if(plipcoord != our_coordinates)
			radioactive_things -= reffie
			continue
	if(!LAZYLEN(radioactive_things)) // MUST have a puddle
		qdel(src)
		return FALSE // puddles are missing, likely, so unirradiate this turf
	return clamp(abs(rads), 0, (1<<23)) // just in case someone makes a turf give 16777217 rads
	
/// so the SSradiation can periodically check if the shitload of coordinates its remembering are still radioactive
/datum/component/radiation_turf/proc/im_still_here()
	return check_puddles() // technically, signals can only return bitfields. byond treats bitfields as numbers (probably), so, *shruggo*

/// tells the radiation subsys (that really does all the work) to remove this tile from its radlist
/datum/component/radiation_turf/UnregisterFromParent()
	STOP_PROCESSING(SSradiation, src)
	var/turf/radbgone = coords2turf(our_coordinates)
	radbgone?.maptext = initial(radbgone.maptext)
	thingtoggle = -1

/// Tell the radiation system that we're gonna die, put another component at whatever's gonna be here
/datum/component/radiation_turf/proc/on_turf_change()
	SIGNAL_HANDLER
	SSradiation.tile_got_changed(our_coordinates, radioactive_things, rads)
	qdel(src)

/// debug shit
/datum/component/radiation_turf/process()
	if(GLOB.rad_puddle_debug && thingtoggle != -1)
		was_debug = TRUE
		var/turf/blinker = coords2turf(our_coordinates)
		if(!isturf(blinker) || QDELETED(blinker))
			qdel(src)
			return
		thingtoggle = !thingtoggle
		blinker.maptext = thingtoggle ? "[rads]" : initial(blinker.maptext)
		blinker.color = thingtoggle ? "#00FF00" : initial(blinker.color)
		return
	if(was_debug)
		var/turf/blinker = coords2turf(our_coordinates)
		if(!isturf(blinker) || QDELETED(blinker))
			qdel(src)
			return
		blinker.maptext = initial(blinker.maptext)
		blinker.color = initial(blinker.color)

/obj/item/storage/backpack/debug_radiation
	name = "Bag of Radstuff"
	desc = "Cool shit for testing various radiations!"

/obj/item/storage/backpack/debug_radiation/PopulateContents()
	. = ..()
	new /obj/item/crowbar/abductor(src)
	new /obj/item/healthanalyzer/advanced(src)
	new /obj/item/geiger_counter(src)
	new /obj/item/storage/firstaid/radbgone(src)
	new /obj/item/crafting/abraxo(src)
	new /obj/item/crafting/abraxo(src)
	new /obj/item/crafting/abraxo(src)
	new /obj/item/storage/box/dynamite_box(src)
	new /obj/item/grenade/syndieminibomb(src)
	new /obj/item/grenade/syndieminibomb(src)
	new /obj/item/grenade/syndieminibomb(src)
	new /obj/item/grenade/syndieminibomb(src)

