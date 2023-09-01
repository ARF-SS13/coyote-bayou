/// Boxes
/datum/component/storage/concrete/box
	max_items = STORAGE_BOX_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/// DonkBoxes
/datum/component/storage/concrete/box/donk
	quickdraw = TRUE

/datum/component/storage/concrete/box/donk/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/reagent_containers/food/snacks))

/// Cigpacks
/datum/component/storage/concrete/box/cigarette
	quickdraw = TRUE

/datum/component/storage/concrete/box/cigarette/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/clothing/mask/cigarette, /obj/item/lighter))

/// monkey
/datum/component/storage/concrete/box/monkey
	quickdraw = TRUE

/datum/component/storage/concrete/box/monkey/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/reagent_containers/food/snacks/cube/monkey))

/// Big Box
/datum/component/storage/concrete/box/big
	max_items = STORAGE_BIG_BOX_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BIG_BOX_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BIG_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_BIG_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_BIGBOX

/// snap pops!
/datum/component/storage/concrete/box/big/snap_pop
	quickdraw = TRUE

/datum/component/storage/concrete/box/big/snap_pop/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/toy/snappop))

/// Matches!
/datum/component/storage/concrete/box/big/match
	quickdraw = TRUE

/datum/component/storage/concrete/box/big/match/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/match))

/// Hugeboxes
/datum/component/storage/concrete/box/huge
	max_items = STORAGE_HUGE_BOX_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_HUGE_BOX_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_HUGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_HUGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_HUGEBOX

/// Lights!
/datum/component/storage/concrete/box/huge/lights
	quickdraw = TRUE

/datum/component/storage/concrete/box/huge/lights/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/light/tube, /obj/item/light/bulb))

/// Survival kit
/datum/component/storage/concrete/box/survivalkit
	max_items = STORAGE_BOX_SURVIVAL_GENERIC_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_GENERIC_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_GENERIC_MAX_TOTAL_SPACE

/// Big kit
/datum/component/storage/concrete/box/survivalkit/triple
	max_items = STORAGE_BOX_SURVIVAL_TRIPLE_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_TRIPLE_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_TRIPLE_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_TRIPLE_MAX_TOTAL_SPACE
	number_of_rows = STORAGE_ROWS_SURVIVAL_TRIPLE

/// Specialized kit
/datum/component/storage/concrete/box/survivalkit/specialized
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/// Medi kit
/datum/component/storage/concrete/box/survivalkit/specialized/medical
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/medical/Initialize()
	. = ..()
	can_hold = GLOB.medibelt_allowed

/// Synthy kit
/datum/component/storage/concrete/box/survivalkit/specialized/synthmed
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/synthmed/Initialize()
	. = ..()
	can_hold = GLOB.toolbelt_allowed
	can_hold |= typecacheof(list(/obj/item/clothing/glasses/sunglasses/blindfold))

/// combat kit
/datum/component/storage/concrete/box/survivalkit/specialized/combat
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/combat/Initialize()
	. = ..()
	can_hold = GLOB.ammobelt_allowed
	can_hold |= GLOB.gunbelt_allowed

/// debug shit
/datum/component/storage/concrete/box/debug/huge_volume_two_item
	max_items = 2
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = WEIGHT_CLASS_GIGANTIC * 1000
	rustle_sound = TRUE
	storage_flags = STORAGE_FLAGS_VOLUME_AND_NUMBER

/// debug shit
/datum/component/storage/concrete/box/debug/huge_volume_four_item
	max_items = 4
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = WEIGHT_CLASS_GIGANTIC * 1000
	rustle_sound = TRUE
	storage_flags = STORAGE_FLAGS_VOLUME_AND_NUMBER

/// debug shit
/datum/component/storage/concrete/box/debug/tiny_volume_four_item
	max_items = 4
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	max_volume = WEIGHT_CLASS_SMALL * 2
	rustle_sound = TRUE
	storage_flags = STORAGE_FLAGS_VOLUME_AND_NUMBER


