/// Bag
/datum/component/storage/concrete/bag
	max_items = STORAGE_BAG_MAX_ITEMS
	max_w_class = STORAGE_BAG_MAX_SIZE
	max_combined_w_class = STORAGE_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_BAG_MAX_TOTAL_SPACE
	allow_quick_gather = TRUE
	allow_quick_empty = TRUE
	display_numerical_stacking = FALSE
	click_gather = TRUE
	insert_preposition = "in"
	storage_flags = STORAGE_FLAGS_LEGACY_DEFAULT
	display_numerical_stacking = TRUE
	limited_random_access = TRUE
	limited_random_access_stack_position = 5


/// Book Bag
/datum/component/storage/concrete/bag/book/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/book, /obj/item/storage/book, /obj/item/spellbook))

/// Medichem bag
/datum/component/storage/concrete/bag/chem_med_etc/Initialize()
	. = ..()
	can_hold = GLOB.medibelt_allowed

/// Produce bag
/datum/component/storage/concrete/bag/produce
	max_items = STORAGE_TRASH_BAG_MAX_ITEMS
	max_w_class = WEIGHT_CLASS_NORMAL
	max_combined_w_class = STORAGE_TRASH_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_TRASH_BAG_MAX_TOTAL_SPACE
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/datum/component/storage/concrete/bag/produce/Initialize()
	. = ..()
	can_hold = GLOB.storage_produce_bag_can_hold

/// Salvage bag
/datum/component/storage/concrete/bag/salvage
	max_items = STORAGE_SALVAGE_BAG_MAX_ITEMS
	max_w_class = STORAGE_SALVAGE_BAG_MAX_SIZE
	max_combined_w_class = STORAGE_SALVAGE_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_SALVAGE_BAG_MAX_TOTAL_SPACE
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/datum/component/storage/concrete/bag/salvage/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/salvage))
	can_hold |= GLOB.storage_salvage_storage_bag_can_hold
	can_hold |= typecacheof(list(/obj/item/stock_parts))

/// Casing bag
/datum/component/storage/concrete/bag/casing
	max_items = STORAGE_CASING_BAG_MAX_ITEMS
	max_w_class = STORAGE_CASING_BAG_MAX_SIZE
	max_combined_w_class = STORAGE_CASING_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_CASING_BAG_MAX_TOTAL_SPACE
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/datum/component/storage/concrete/bag/casing/Initialize()
	. = ..()
	can_hold = typecacheof(list(/obj/item/ammo_casing))
	cant_hold = typecacheof(list(/obj/item/ammo_casing/caseless/arrow))

/datum/component/storage/concrete/bag/casing/get_quickempty_list()
	var/list/insides = contents()
	var/list/empties = list()
	for(var/obj/item/ammo_casing/AC in insides)
		if(!AC.BB)
			empties += AC
	if(LAZYLEN(empties))
		return empties
	return insides

/// Quiver
/datum/component/storage/concrete/bag/quiver
	max_items = STORAGE_QUIVER_MAX_ITEMS
	max_w_class = STORAGE_QUIVER_MAX_SIZE
	max_combined_w_class = STORAGE_QUIVER_TOTAL_SPACE
	max_volume = STORAGE_QUIVER_TOTAL_SPACE //dunno how this is different than combined w class, but, want 24 tiny items, 12 small, or 8 normal sized
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/datum/component/storage/concrete/bag/quiver/Initialize()
	. = ..()
	can_hold = typecacheof(list(
		/obj/item/ammo_casing/caseless/arrow,
		/obj/item/arrow_shaft,
		/obj/item/stack/arrowhead,
	))

/datum/component/storage/concrete/bag/quiver/light_quiver //12 tiny arrows, 6 small, 4 normal
	max_items = STORAGE_QUIVER_LIGHT_MAX_ITEMS
	max_w_class = STORAGE_QUIVER_LIGHT_MAX_SIZE
	max_combined_w_class = STORAGE_QUIVER_LIGHT_TOTAL_SPACE
	max_volume = STORAGE_QUIVER_LIGHT_TOTAL_SPACE
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/datum/component/storage/concrete/bag/quiver/heavy_quiver //lots o arrows
	max_items = STORAGE_QUIVER_HEAVY_MAX_ITEMS
	max_w_class = STORAGE_QUIVER_HEAVY_MAX_SIZE
	max_combined_w_class = STORAGE_QUIVER_HEAVY_TOTAL_SPACE
	max_volume = STORAGE_QUIVER_HEAVY_TOTAL_SPACE
	display_numerical_stacking = TRUE
	limited_random_access = FALSE

/// trashbag
/datum/component/storage/concrete/bag/trash
	max_items = STORAGE_TRASH_BAG_MAX_ITEMS
	max_w_class = STORAGE_TRASH_BAG_MAX_SIZE
	max_combined_w_class = STORAGE_TRASH_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_TRASH_BAG_MAX_TOTAL_SPACE
	limited_random_access_stack_position = 3

/datum/component/storage/concrete/bag/trash/Initialize()
	. = ..()
	can_hold_extra = typecacheof(list(/obj/item/organ/lungs, /obj/item/organ/liver, /obj/item/organ/stomach, /obj/item/clothing/shoes)) - typesof(/obj/item/clothing/shoes/magboots, /obj/item/clothing/shoes/jackboots, /obj/item/clothing/shoes/workboots)
	cant_hold = typecacheof(list(/obj/item/disk/nuclear, /obj/item/storage/wallet, /obj/item/organ/brain))

/// Big outside trashbag
/datum/component/storage/concrete/bag/trash/big
	max_items = STORAGE_BIG_TRASH_BAG_MAX_ITEMS
	max_w_class = STORAGE_BIG_TRASH_BAG_MAX_SIZE
	max_combined_w_class = STORAGE_BIG_TRASH_BAG_MAX_TOTAL_SPACE
	max_volume = STORAGE_BIG_TRASH_BAG_MAX_TOTAL_SPACE
	limited_random_access_stack_position = 5
