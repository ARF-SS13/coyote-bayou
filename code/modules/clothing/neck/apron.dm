// Aprons	Specialized pockets, small environmental bonus for some
/obj/item/clothing/neck/apron
	name = "apron template"
	icon = 'icons/fallout/clothing/aprons.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/apron.dmi'
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS
	permeability_coefficient = 0.9
	pocket_storage_component_path = null

/obj/item/clothing/neck/apron/bartender
	name = "bartenders apron"
	desc = "A fancy purple apron for a stylish person. Can hold some bottles, a few kitchen trinkets and maybe a small discrete revolver...."
	icon_state = "bartender"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bartender

/obj/item/clothing/neck/apron/medicus
	name = "medicus apron"
	desc = "The waxed cotton apron of a Medicus, marked with a red bull insignia. Has pockets for some small medical equipment."
	icon_state = "medicus"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 20, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/neck/apron/surgical
	name = "surgical apron"
	desc = "A sterile blue surgical apron that has pockets for small medical items."
	icon_state = "surgical"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 20, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/neck/apron/chef
	name = "chefs apron"
	desc = "A white apron for kitchenwork, got loops to attack kitchen knives and rollings pin to it."
	icon_state = "chef"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/kitchen

/obj/item/clothing/neck/apron/labor
	name = "labor apron"
	desc = "A dark apron for manual labor."
	icon_state = "labor"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/crafter

/obj/item/clothing/neck/apron/labor/forge
	name = "forgemasters apron"
	desc = "A heavy leather apron designed for protecting the user when metalforging and help carry some minor tools. The bull insignia marks the wearer as a Forgemaster."
	icon_state = "forge"
	heat_protection = CHEST|GROIN|LEGS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/crafter
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0)

/obj/item/clothing/neck/apron/housewife
	name = "50s housewife apron"
	desc = "A cutesy pink checkerboard apron. The pattern is inspired by ancient commercial billboards. Some kitchen equipment can be stored in its pocket."
	icon_state = "housewife"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/kitchen
