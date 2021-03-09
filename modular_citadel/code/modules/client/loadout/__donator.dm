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

/datum/gear/donator/foxrangersuit
	name = "Fox's Custom Riot Armor"
	slot = SLOT_WEAR_SUIT
	path = /obj/item/clothing/suit/armor/f13/rangercombat/foxcustom
	ckeywhitelist = list("superballs")
	restricted_roles = list("NCR Veteran Ranger")

/datum/gear/donator/foxrangerhelmet
	name = "Fox's Custom Riot Helmet"
	slot = SLOT_HEAD
	path = /obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom
	ckeywhitelist = list("superballs")
	restricted_roles = list("NCR Veteran Ranger")

/datum/gear/donator/foxuniform
	name = "Fox's Flannel"
	slot = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/f13/ranger/vet/foxflannel
	ckeywhitelist = list("superballs")
	restricted_roles = list("NCR Veteran Ranger", "NCR Ranger", "NCR Off-Duty")

/datum/gear/donator/thaxuniform
	name = "Thaxton's Flannel"
	slot = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/f13/ranger/vet/thaxflannel
	ckeywhitelist = list("svenja")
	restricted_roles = list("NCR Ranger", "NCR Off-Duty")

/datum/gear/donator/zirilliuniform
	name = "Major Zirilli's service uniform"
	slot = SLOT_W_UNIFORM
	path = /obj/item/clothing/under/f13/ncr_formal_uniform/majzirilli
	ckeywhitelist = list("shoi87")
	restricted_roles = list("NCR Off-Duty", "NCR Lieutenant", "NCR Colonel", "NCR Captain")
		
////////////////////////////
///Ranger items end here.///
////////////////////////////
