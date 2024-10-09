/// Generic neckpron
/datum/component/storage/concrete/neckpron
	max_items = STORAGE_NECKPRON_GENERIC_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_GENERIC_MAX_TOTAL_SPACE
	max_volume = STORAGE_NECKPRON_GENERIC_MAX_TOTAL_SPACE

/// Specialized neckpron
/datum/component/storage/concrete/neckpron/specialized
	max_items = STORAGE_NECKPRON_SPECIALIZED_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE
	max_volume = STORAGE_NECKPRON_SPECIALIZED_MAX_TOTAL_SPACE

/// Utility Belt
/datum/component/storage/concrete/neckpron/specialized/utility/Initialize()
	. = ..()

/// Medineckpron
/datum/component/storage/concrete/neckpron/specialized/medical/Initialize()
	. = ..()

/// Bandolier

/datum/component/storage/concrete/neckpron/specialized/bandolier/Initialize()
	. = ..()

/// Holster
/datum/component/storage/concrete/neckpron/specialized/gun
	max_items = STORAGE_NECKPRON_HOLSTER_MAX_ITEMS
	max_w_class = STORAGE_NECKPRON_HOLSTER_MAX_SIZE
	max_combined_w_class = STORAGE_NECKPRON_HOLSTER_MAX_TOTAL_SPACE
	max_volume = STORAGE_NECKPRON_HOLSTER_MAX_TOTAL_SPACE

/datum/component/storage/concrete/neckpron/specialized/gun/Initialize()
	. = ..()
	quickdraw = TRUE

