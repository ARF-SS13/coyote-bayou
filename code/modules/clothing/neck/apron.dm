// Aprons	Specialized pockets, small environmental bonus for some
/obj/item/clothing/neck/apron
	name = "apron template"
	icon = 'icons/fallout/clothing/aprons.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/apron.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS
	permeability_coefficient = 0.9
	pocket_storage_component_path = null

/obj/item/clothing/neck/apron/bartender
	name = "bartenders apron"
	desc = "A fancy purple apron for a stylish bartender. Has stylish loops for bottles and snacks, sheaths for kitchen trinkets, and a discrete little holster under a flap. Service with a smile!"
	icon_state = "bartender"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service

/obj/item/clothing/neck/apron/medical
	name = "nurse's apron"
	desc = "The waxed cotton apron of a medical professional. Has pockets for some small medical equipment."
	icon_state = "medicus"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical

/obj/item/clothing/neck/apron/medical/surgical
	name = "surgeon's apron"
	desc = "The sterile apron of a medical professional. Has pockets for some small medical equipment."
	icon_state = "surgical"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical

/obj/item/clothing/neck/apron/chef
	name = "chef's apron"
	desc = "A white apron for kitchenwork, or for some improvised surgery. Has robust loops for bottles and snacks, sheathes for kitchen trinkets, and a discrete little holster under a flap. Order up!"
	icon_state = "chef"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service

/obj/item/clothing/neck/apron/labor
	name = "labor apron"
	desc = "A dark apron for manual labor. Comes with various pockets and loops for holding everything a handycritter could need."
	icon_state = "labor"
	heat_protection = CHEST|GROIN|LEGS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service

/obj/item/clothing/neck/apron/labor/forge
	name = "smith's apron"
	desc = "A heavy leather apron designed for protecting the user when metalforging and help carry some minor tools."
	icon_state = "forge"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service

/obj/item/clothing/neck/apron/housewife
	name = "50s housewife apron"
	desc = "A cutesy pink checkerboard apron. The pattern is inspired by ancient commercial billboards. Comes with deep pockets to hold everything a homemaker/wrecker could need."
	icon_state = "housewife"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service
