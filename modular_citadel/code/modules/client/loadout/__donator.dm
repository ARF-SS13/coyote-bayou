//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	cost = 0

/datum/gear/donator/donortestingbikehorn
	name = "Donor item testing bikehorn"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn
	geargroupID = list("DONORTEST") //This is a list mainly for the sake of testing, but geargroupID works just fine with ordinary strings
/////////////////////
///Loadout Boxes///// See kits.dm, use this model for loadouts that have more than one item per character.
/////////////////////
/datum/gear/donator/kits
	slot = SLOT_IN_BACKPACK

/datum/gear/donator/kits/terryklip
	name = "Terry Klip's belongings"
	path = /obj/item/storage/box/large/custom_kit/terryklip
	ckeywhitelist = list("luckydente")

/datum/gear/donator/kits/stephaniemoui
	name = "Stephanie Moui's belongings"
	path = /obj/item/storage/box/large/custom_kit/stephaniemoui
	ckeywhitelist = list("xerdies")

/datum/gear/donator/kits/danaseshata
	name = "Dana Seshata's belongings"
	path = /obj/item/storage/box/large/custom_kit/danaseshata
	ckeywhitelist = list("s1lv3rv1x3n")

/datum/gear/donator/kits/ashtonfox
	name = "Ashton Fox's belongings"
	path = /obj/item/storage/box/large/custom_kit/ashtonfox
	ckeywhitelist = list("superballs")

/datum/gear/donator/kits/averyamadeus
	name = "Avery Amadeus' belongings"
	path = /obj/item/storage/box/large/custom_kit/averyamadeus
	ckeywhitelist = list("topbirb")

/datum/gear/donator/kits/rigs
	name = "Rigs' belongings"
	path = /obj/item/storage/box/large/custom_kit/rigs
	ckeywhitelist = list("topbirb")

/datum/gear/donator/kits/sangarinusofkanab
	name = "Sangarinus of Kanab's belongings"
	path = /obj/item/storage/box/large/custom_kit/sangarinusofkanab
	ckeywhitelist = list("topbirb")

/datum/gear/donator/kits/johnthaxton
	name = "John Thaxton's belongings"
	path = /obj/item/storage/box/large/custom_kit/johnthaxton
	ckeywhitelist = list("svenja")

//////////////////////////////
///Ranger items start here.///
//////////////////////////////

/datum/gear/donator/ranger4570
	name = "45-70 Gov't Service Revolver"
	slot = SLOT_NECK
	path = /obj/item/storage/belt/holster/ranger4570
	ckeywhitelist = list("superballs",
						"allakai")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger44
	name = ".44 Magnum Service Revolver"
	slot = SLOT_NECK
	path = /obj/item/storage/belt/holster/ranger44
	ckeywhitelist = list("pilotbland",
						"poots13",
						"panzer1944",
						"nbveh123",
						"svenja",
						"idiocityinc",
						"zeronetalpha",
						"mrmatrixman",
						"thegreatcoward")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger45
	name = ".45 ACP Service Revolver"
	slot = SLOT_NECK
	path = /obj/item/storage/belt/holster/ranger45
	ckeywhitelist = list("seabass390",
						"poots13",
						"julwaters",
						"asterixcodix")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger357
	name = ".357 Magnum Service Revolver"
	slot = SLOT_NECK
	path = /obj/item/storage/belt/holster/ranger357
	ckeywhitelist = list("shoi87")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger10mm
	name = "10mm Service Revolver"
	slot = SLOT_NECK
	path = /obj/item/storage/belt/holster/ranger10mm
	ckeywhitelist = list("hawkwestheimer")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/rangercaptainpins
	name = "Ranger-Captain Pins"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/ranger/CPT
	ckeywhitelist = list("superballs")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/rangerlieutenantpins
	name = "Ranger-Lieutenant Pins"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/ranger/LT
	ckeywhitelist = list("allakai")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/rangerpins
	name = "Ranger Pins"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/clothing/accessory/ranger
	ckeywhitelist = list("pilotbland",
						"poots13",
						"panzer1944",
						"nbveh123",
						"svenja",
						"seabass390",
						"julwaters",
						"shoi87",
						"idiocityinc",
						"zeronetalpha",
						"mrmatrixman",
						"asterixcodix",
						"thegreatcoward")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/zirilliuniform
	name = "Major Zirilli's service uniform"
	slot = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/f13/ncr_formal_uniform/majzirilli
	ckeywhitelist = list("shoi87")
	restricted_roles = list("NCR Off-Duty", "NCR Lieutenant", "NCR Colonel", "NCR Captain")
		
////////////////////////////
///Ranger items end here.///
////////////////////////////
