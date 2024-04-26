/// Backpack
/datum/component/storage/concrete/debug_sack
	storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT // space limited, only
	max_items = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_ITEMS
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_DUFFEL_SCAV

/datum/component/storage/concrete/debug_sack/smaller
	storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT // space limited, only
	max_items = STORAGE_BACKPACK_DEFAULT_MAX_ITEMS
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = STORAGE_BACKPACK_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_BACKPACK_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_BACKPACK

/// Backpack
/datum/component/storage/concrete/backpack
	storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT // space limited, only
	max_items = STORAGE_BACKPACK_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BACKPACK_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BACKPACK_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_BACKPACK_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_BACKPACK

/// Spearquiver
/datum/component/storage/concrete/backpack/spear_quiver/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/throwing_star/spear, /obj/item/restraints/legcuffs/bola, /obj/item/melee/smith/dagger/javelin))

/// Duffelbag
/datum/component/storage/concrete/backpack/duffelbag
	max_items = STORAGE_DUFFEL_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_DUFFEL_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_DUFFEL_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_DUFFEL_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_DUFFEL

/// Duffelscav
/datum/component/storage/concrete/backpack/duffelbag/scav
	max_items = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE
	max_volume = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE
	number_of_rows = STORAGE_ROWS_DUFFEL_SCAV

/// Syndiebag
/datum/component/storage/concrete/backpack/duffelbag/syndie
	rustle_sound = FALSE
