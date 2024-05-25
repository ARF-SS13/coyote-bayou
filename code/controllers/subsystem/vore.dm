/// List of types that are allowed to be eaten (right now)
/// Register COMSIG_VORE_ATOM_DEVOURED to a proc on these to make them do stuff

//
// Vore subsystem - Process vore bellies
//
PROCESSING_SUBSYSTEM_DEF(vore)
	name = "Bellies"
	priority = FIRE_PRIORITY_VORE
	wait = 5 SECONDS
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING
	runlevels = RUNLEVEL_GAME|RUNLEVEL_POSTGAME
	/// mobtypes allowed to have a vore component
	var/list/approved_vore_mobtypes = list()
	/// itemtypes allowed to be vored
	var/list/approved_vore_paths = list()
	/// list of smells
	var/list/smell_by_mob = list()
	//I don't think we've ever altered these lists. making them static until someone actually overrides them somewhere.
	//Actual full digest modes
	var/list/digest_modes = list(
		DM_HOLD,
		DM_DIGEST,
		//DM_ABSORB,
		//DM_DRAIN,
		//DM_SELECT,
		//DM_UNABSORB,
		//DM_HEAL,
		//DM_SHRINK,
		//DM_GROW,
		//DM_SIZE_STEAL,
		//DM_EGG
		)
	//Digest mode addon flags
	//var/list/mode_flag_list = list("Numbing" = DM_FLAG_NUMBING, "Stripping" = DM_FLAG_STRIPPING, "Leave Remains" = DM_FLAG_LEAVEREMAINS, "Muffles" = DM_FLAG_THICKBELLY, "Affect Worn Items" = DM_FLAG_AFFECTWORN, "Jams Sensors" = DM_FLAG_JAMSENSORS, "Complete Absorb" = DM_FLAG_FORCEPSAY)
	//Item related modes
	//var/list/item_digest_modes = list(IM_HOLD,IM_DIGEST_FOOD,IM_DIGEST)

	//List of slots that stripping handles strips
	//var/list/slots = list(slot_back,slot_handcuffed,slot_l_store,slot_r_store,slot_wear_mask,slot_l_hand,slot_r_hand,slot_wear_id,slot_glasses,slot_gloves,slot_head,slot_shoes,slot_belt,slot_wear_suit,slot_w_uniform,slot_s_store,slot_l_ear,slot_r_ear)

/datum/controller/subsystem/processing/vore/Initialize(start_timeofday)
	build_list_of_mobtypes_that_should_vore()
	build_list_of_items_that_can_be_vored()
	return ..()

/datum/controller/subsystem/processing/vore/proc/build_list_of_mobtypes_that_should_vore()
	approved_vore_mobtypes |= typecacheof(/mob/living/carbon/human)
	approved_vore_mobtypes |= typecacheof(/mob/living/simple_animal)

/datum/controller/subsystem/processing/vore/proc/build_list_of_items_that_can_be_vored()
	approved_vore_paths |= typecacheof(list(
		/obj/item/reagent_containers/food,
		/mob/living/simple_animal,
		/obj/item/organ,
		/obj/item/clothing/head/mob_holder,
		/obj/item/trash,
		/obj/item/grenade,
		/obj/item/key, // if you eat your own house keys, thats on you
		/obj/item/lock_construct,
		/obj/item/pda,
		/obj/item/cool_book, // hey i coded the darn thing, I say its edible
		/obj/item/toy,
		/obj/item/dice,
		/obj/item/latexballon,
		/obj/item/book,
		/obj/item/shrapnel, // yum
	))
	approved_vore_paths |= approved_vore_mobtypes

/// Stores a mob's smell
/// Yes I know its a wierd place for it, it'll make sense when more things have scents
/// much better than storing a list on every fucking atom
/datum/controller/subsystem/processing/vore/proc/register_smell(mob/living/living_pred, smell)
	var/datum/weakref/sniffa = WEAKREF(living_pred)
	smell_by_mob[sniffa] = "[smell]"

/// Returns if something is valid to eat. Mobs are always valid (didnt ya know?)
/datum/controller/subsystem/processing/vore/proc/can_eat(atom/movable/eat_thing)
	if(!istype(eat_thing))
		return FALSE
	if(ishuman(eat_thing))
		return TRUE
	if(isliving(eat_thing))
		var/mob/living/L = eat_thing
		if(L.ckey || L.client)
			return TRUE // we'll check their prefs later
	return approved_vore_paths[eat_thing.type]

// Returns a mob's smell
/datum/controller/subsystem/processing/vore/proc/get_scent(mob/living/living_pred)
	var/datum/weakref/sniffa = WEAKREF(living_pred)
	. = smell_by_mob[sniffa]
	if(!. || . == "")
		return "what you'd expect."

/datum/controller/subsystem/processing/vore/proc/should_have_vore(mob/living/living_pred)
	if(!isliving(living_pred))
		return FALSE // no ghostvore (yet)
	// if(!is_type_in_typecache(living_pred.type, approved_vore_mobtypes))
	// 	return FALSE // screw it, everyone gets vore
	return TRUE
