/datum/component/storage/concrete/pockets
	max_items = 2
	max_w_class = WEIGHT_CLASS_SMALL
	max_combined_w_class = 50
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/handle_item_insertion(obj/item/I, prevent_warning, mob/user)
	. = ..()
	if(. && silent && !prevent_warning)
		if(quickdraw)
			to_chat(user, span_notice("You discreetly slip [I] into [parent]. Alt-click [parent] to remove it."))
		else
			to_chat(user, span_notice("You discreetly slip [I] into [parent]."))

/datum/component/storage/concrete/pockets/huge
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/pockets/massive
	max_w_class = WEIGHT_CLASS_HUGE

/datum/component/storage/concrete/pockets/massive/swords
	max_items = 1

/datum/component/storage/concrete/pockets/massive/swords/Initialize()
	. = ..()
	can_hold = GLOB.knifebelt_allowed

/datum/component/storage/concrete/pockets/small
	max_items = 1
	//attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/small/collar
	max_items = 1

/datum/component/storage/concrete/pockets/small/collar/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/reagent_containers/food/snacks/cookie,
	/obj/item/reagent_containers/food/snacks/sugarcookie))

/datum/component/storage/concrete/pockets/small/collar/locked/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/reagent_containers/food/snacks/cookie,
	/obj/item/reagent_containers/food/snacks/sugarcookie,
	/obj/item/key/collar))

/datum/component/storage/concrete/pockets/small/four
	max_items = 4 // just like the name~

/datum/component/storage/concrete/pockets/binocular
	max_items = 1

/datum/component/storage/concrete/pockets/binocular/Initialize()
	. = ..()
	can_hold = GLOB.storage_binocular_can_hold


/datum/component/storage/concrete/pockets/treasurer
	max_items = 4

/datum/component/storage/concrete/pockets/treasurer/Initialize()
	. = ..()
	can_hold = GLOB.storage_treasurer_can_hold

/datum/component/storage/concrete/pockets/tiny
	max_items = 1
	max_w_class = WEIGHT_CLASS_TINY
	//attack_hand_interact = FALSE

/datum/component/storage/concrete/pockets/small/detective
	attack_hand_interact = TRUE // so the detectives would discover pockets in their hats

/datum/component/storage/concrete/pockets/shoes
	attack_hand_interact = FALSE
	quickdraw = TRUE
	silent = TRUE

/datum/component/storage/concrete/pockets/shoes/Initialize()
	. = ..()
	cant_hold = typecacheof(list(/obj/item/screwdriver/power))
	can_hold = GLOB.storage_shoes_can_hold


/datum/component/storage/concrete/pockets/pocketprotector
	max_items = 3
	max_w_class = WEIGHT_CLASS_TINY
	var/atom/original_parent

/datum/component/storage/concrete/pockets/pocketprotector/Initialize()
	original_parent = parent
	. = ..()
	can_hold = typecacheof(list( //Same items as a PDA
		/obj/item/pen,
		/obj/item/toy/crayon,
		/obj/item/lipstick,
		/obj/item/flashlight/pen,
		/obj/item/clothing/mask/cigarette))

/datum/component/storage/concrete/pockets/pocketprotector/real_location()
	// if the component is reparented to a jumpsuit, the items still go in the protector
	return original_parent

/datum/component/storage/concrete/pockets/small/rushelmet
	max_items = 1
	quickdraw = TRUE

/datum/component/storage/concrete/pockets/small/rushelmet/Initialize()
	. = ..()
	can_hold = GLOB.storage_hat_can_hold


/datum/component/storage/concrete/pockets/bos/paladin/
	max_items = 4
	max_w_class = WEIGHT_CLASS_NORMAL

/datum/component/storage/concrete/pockets/bos/paladin/Initialize()
	. = ..()
	can_hold = GLOB.gunbelt_allowed

/datum/component/storage/concrete/pockets/small/holdout
	max_items = 1
	attack_hand_interact = TRUE
	max_w_class = WEIGHT_CLASS_NORMAL
	quickdraw = TRUE

/datum/component/storage/concrete/pockets/small/holdout/Initialize()
	. = ..()
	can_hold = GLOB.storage_holdout_can_hold

/// Unarmored dusters
/datum/component/storage/concrete/pockets/duster
	max_items = STORAGE_SUIT_DUSTER_MAX_ITEMS
	max_w_class = STORAGE_SUIT_DUSTER_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_DUSTER_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// Armored dusters
/datum/component/storage/concrete/pockets/duster/armored
	max_items = STORAGE_SUIT_DUSTER_ARMOR_MAX_ITEMS
	max_w_class = STORAGE_SUIT_DUSTER_ARMOR_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_DUSTER_ARMOR_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// Jackets
/datum/component/storage/concrete/pockets/jacket
	max_items = STORAGE_SUIT_JACKET_MAX_ITEMS
	max_w_class = STORAGE_SUIT_JACKET_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_JACKET_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// Generic armor slot
/datum/component/storage/concrete/pockets/armor
	max_items = STORAGE_SUIT_GENERIC_MAX_ITEMS
	max_w_class = STORAGE_SUIT_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_GENERIC_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// scarf
/datum/component/storage/concrete/pockets/scarf
	max_items = STORAGE_NECKPRON_GENERIC_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_GENERIC_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// service apron
/datum/component/storage/concrete/pockets/service
	max_items = STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/service/overalls
	max_items = STORAGE_SUIT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_SUIT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/service/Initialize()
	. = ..()
	can_hold = GLOB.toolbelt_allowed

/// crafter apron
/datum/component/storage/concrete/pockets/crafter
	max_items = STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/crafter/overalls
	max_items = STORAGE_SUIT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_SUIT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/crafter/Initialize()
	. = ..()
	can_hold = GLOB.toolbelt_allowed

/// medi-apron
/datum/component/storage/concrete/pockets/medical
	max_items = STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/medical/overalls
	max_items = STORAGE_SUIT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_SUIT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/medical/Initialize()
	. = ..()
	can_hold = GLOB.medibelt_allowed

/// farmer apron
/datum/component/storage/concrete/pockets/farmer
	max_items = STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/pockets/farmer/overalls
	max_items = STORAGE_SUIT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_SUIT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_SUIT_SPECIALIZED_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/pockets/farmer/Initialize()
	. = ..()
	can_hold = GLOB.toolbelt_allowed

/// Mini bandolier
/datum/component/storage/concrete/pockets/bulletbelt
	max_items = STORAGE_BELT_HOLSTER_MAX_ITEMS
	max_w_class = STORAGE_BELT_HOLSTER_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_HOLSTER_MAX_TOTAL_SPACE

/datum/component/storage/concrete/pockets/bulletbelt/Initialize()
	. = ..()
	can_hold = GLOB.ammobelt_allowed

/// Combat armor bandolier / holster
/datum/component/storage/concrete/pockets/magpouch
	max_items = STORAGE_BELT_HOLSTER_MAX_ITEMS
	max_w_class = STORAGE_BELT_HOLSTER_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_HOLSTER_MAX_TOTAL_SPACE

/datum/component/storage/concrete/pockets/magpouch/Initialize()
	. = ..()
	can_hold = GLOB.gunbelt_allowed
