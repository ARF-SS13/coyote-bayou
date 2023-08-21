/// Generic belt
/datum/component/storage/concrete/belt
	max_items = STORAGE_BELT_GENERIC_MAX_ITEMS
	max_w_class = STORAGE_BELT_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_GENERIC_MAX_TOTAL_SPACE
	max_volume = STORAGE_BELT_GENERIC_MAX_TOTAL_SPACE

/// Specialized belt
/datum/component/storage/concrete/belt/specialized
	max_items = STORAGE_BELT_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_BELT_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_BELT_SPECIALIZED_MAX_TOTAL_SPACE

/// Utility Belt
/datum/component/storage/concrete/belt/specialized/utility/Initialize()
	. = ..()
	can_hold = GLOB.toolbelt_allowed

/// Medibelt
/datum/component/storage/concrete/belt/specialized/medical/Initialize()
	. = ..()
	can_hold = GLOB.medibelt_allowed
	max_w_class = WEIGHT_CLASS_NORMAL

/// Bandolier
/datum/component/storage/concrete/belt/specialized/bandolier/Initialize()
	. = ..()
	can_hold = GLOB.ammobelt_allowed

/// Holster
/datum/component/storage/concrete/belt/specialized/gun
	max_items = STORAGE_BELT_HOLSTER_MAX_ITEMS
	max_w_class = STORAGE_BELT_HOLSTER_MAX_SIZE
	max_combined_w_class = STORAGE_BELT_HOLSTER_MAX_TOTAL_SPACE
	max_volume = STORAGE_BELT_HOLSTER_MAX_TOTAL_SPACE

/datum/component/storage/concrete/belt/specialized/gun/Initialize()
	. = ..()
	can_hold = GLOB.gunbelt_allowed
	quickdraw = TRUE //will see if this works!

/datum/component/storage/concrete/belt/specialized/plush
	max_items = 21
	max_w_class = WEIGHT_CLASS_NORMAL
	max_combined_w_class = 21
	max_volume = 21

/datum/component/storage/concrete/belt/specialized/plush/Initialize()
	. = ..()
	can_hold = GLOB.plushbelt_allowed	
