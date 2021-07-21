// Weapon exports. Stun batons, disablers, etc.

/datum/export/weapon
	include_subtypes = FALSE


/datum/export/weapon/flash
	cost = 5
	unit_name = "handheld flash"
	export_types = list(/obj/item/assembly/flash)
	include_subtypes = TRUE

/datum/export/weapon/handcuffs
	cost = 3
	unit_name = "pair"
	message = "of handcuffs"
	export_types = list(/obj/item/restraints/handcuffs)



/////////////////////////
//Bow and Arrows/////////
/////////////////////////

/datum/export/weapon/bows
	cost = 450
	unit_name = "bow"
	export_types = list(/obj/item/gun/ballistic/bow)

/datum/export/weapon/arrows
	cost = 150
	unit_name = "arrow"
	export_types = list(/obj/item/ammo_casing/caseless/arrow, /obj/item/ammo_casing/caseless/arrow/bone, /obj/item/ammo_casing/caseless/arrow/ash)

/datum/export/weapon/bow_teaching
	cost = 500
	unit_name = "bowyery tablet"
	export_types = list(/obj/item/book/granter/crafting_recipe/bone_bow)

/datum/export/weapon/quiver
	cost = 100
	unit_name = "quiver"
	export_types = list(/obj/item/storage/belt/tribe_quiver)
