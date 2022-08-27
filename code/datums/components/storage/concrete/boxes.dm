/datum/component/storage/concrete/box
	max_items = STORAGE_BOX_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_DEFAULT_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_DEFAULT_MAX_TOTAL_SPACE
	rustle_sound = TRUE

/datum/component/storage/concrete/box/survivalkit
	max_items = STORAGE_BOX_SURVIVAL_GENERIC_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_GENERIC_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_GENERIC_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/triple
	max_items = STORAGE_BOX_SURVIVAL_TRIPLE_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_TRIPLE_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_TRIPLE_MAX_TOTAL_SPACE
	limited_random_access = TRUE
	limited_random_access_stack_position = 3

/datum/component/storage/concrete/box/survivalkit/specialized
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/medical
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/medical/Initialize()
	. = ..()
	can_hold = GLOB.medibelt_allowed

/datum/component/storage/concrete/box/survivalkit/specialized/combat
	max_items = STORAGE_BOX_SURVIVAL_SPECIALIZED_DEFAULT_MAX_ITEMS
	max_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_SIZE
	max_combined_w_class = STORAGE_BOX_SURVIVAL_SPECIALIZED_MAX_TOTAL_SPACE

/datum/component/storage/concrete/box/survivalkit/specialized/combat/Initialize()
	. = ..()
	can_hold = GLOB.ammobelt_allowed
	can_hold |= GLOB.gunbelt_allowed


