//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn/golden
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard

/datum/gear/donator/donortestingbikehorn
	name = "Donor item testing bikehorn"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/bikehorn
	geargroupID = list("DONORTEST") //This is a list mainly for the sake of testing, but geargroupID works just fine with ordinary strings

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
	ckeywhitelist = list("pilotbland",
						"poots13",
						"panzer1944",
						"nbveh123",
						"svenja",
						"idiocityinc",
						"zeronetalpha",
						"mrmatrixman")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger45
	name = ".45 ACP Service Revolver"
	slot = SLOT_NECK
	ckeywhitelist = list("seabass390",
						"poots13",
						"julwaters",
						"asterixcodix")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

/datum/gear/donator/ranger357
	name = ".357 Magnum Service Revolver"
	slot = SLOT_NECK
	ckeywhitelist = list("shoi87")
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
						"asterixcodix")
	restricted_roles = list("NCR Ranger", "NCR Veteran Ranger", "NCR Off-Duty")

////////////////////////////
///Ranger items end here.///
////////////////////////////
