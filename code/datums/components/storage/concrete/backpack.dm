/datum/component/storage/concrete/backpack
	max_items = STORAGE_BACKPACK_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BACKPACK_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/backpack/spear_quiver/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/throwing_star/spear, /obj/item/restraints/legcuffs/bola))

/datum/component/storage/concrete/backpack/duffelbag
	max_items = STORAGE_DUFFEL_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_DUFFEL_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_DUFFEL_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/backpack/duffelbag/scav
	max_items = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_DUFFEL_SCAV_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/backpack/duffelbag/syndie
	rustle_sound = FALSE
