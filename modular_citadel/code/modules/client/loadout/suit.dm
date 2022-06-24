/datum/gear/suit
	category = LOADOUT_CATEGORY_SUIT
	subcategory = LOADOUT_SUBCATEGORY_SUIT_GENERAL
	slot = SLOT_WEAR_SUIT

/datum/gear/suit/redhood
	name = "Red cloak"
	path = /obj/item/clothing/suit/hooded/cloak/david
	cost = 3

/datum/gear/suit/labcoat
	name = "Labcoat"
	path = /obj/item/clothing/suit/toggle/labcoat
	cost = 2

/datum/gear/suit/jacketbomber
	name = "Bomber jacket"
	path = /obj/item/clothing/suit/jacket
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/oldjacketbomber
	name = "Old bomber jacket"
	path = /obj/item/clothing/suit/bomber
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/jacketflannelblack // all of these are reskins of bomber jackets but with the vibe to make you look like a true lumberjack
	name = "Black flannel jacket"
	path = /obj/item/clothing/suit/jacket/flannel
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketflannelred
	name = "Red flannel jacket"
	path = /obj/item/clothing/suit/jacket/flannel/red
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketflannelaqua
	name = "Aqua flannel jacket"
	path = /obj/item/clothing/suit/jacket/flannel/aqua
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketflannelbrown
	name = "Brown flannel jacket"
	path = /obj/item/clothing/suit/jacket/flannel/brown
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketleather
	name = "Leather jacket"
	path = /obj/item/clothing/suit/armor/light/leather/leather_jacket
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/overcoatleather
	name = "Leather overcoat"
	path = /obj/item/clothing/suit/jacket/leather/overcoat
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/jacketpuffer
	name = "Puffer jacket"
	path = /obj/item/clothing/suit/jacket/puffer
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/vestpuffer
	name = "Puffer vest"
	path = /obj/item/clothing/suit/jacket/puffer/vest
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketlettermanbrown
	name = "Brown letterman jacket"
	path = /obj/item/clothing/suit/jacket/letterman
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/jacketlettermanred
	name = "Red letterman jacket"
	path = /obj/item/clothing/suit/jacket/letterman_red
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 2

/datum/gear/suit/militaryjacket
	name = "Military Jacket"
	path = /obj/item/clothing/suit/jacket/miljacket
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/flakjack
	name = "Flak Jacket"
	path = /obj/item/clothing/suit/flakjack
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/armorkit
	name = "Armor Kit"
	path = /obj/item/clothing/suit/armor/kit
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 5

/datum/gear/suit/punkkit
	name = "Punk Armor Kit"
	path = /obj/item/clothing/suit/armor/punk
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 5

/datum/gear/suit/autumn
	name = "tan trenchcoat"
	path = /obj/item/clothing/suit/autumn
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 3

/datum/gear/suit/ncrcfjacket
	name = "NCRCF jacket"
	path = /obj/item/clothing/suit/armor/ncrcfjacket
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 1

/datum/gear/suit/samurai  //added by TK420634 ~ 5/29/2022 "Samurai Wasteland WeebShit Edition (tm)
	name = "Rusted Samurai Armor"
	path = /obj/item/clothing/suit/samurai
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS
	cost = 4

/datum/gear/suit/NCRutilityvest
	name = "Utility Vest"
	path = /obj/item/clothing/suit/armor/utilityvest
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 4
	restricted_desc = "NCR"
	restricted_roles = list("NCR Captain",
							"NCR Lieutenant",
							"NCR Medical Officer",
							"NCR Veteran Ranger",
							"NCR Lieutenant",
							"NCR Heavy Trooper",
							"NCR Sergeant First Class",
							"NCR Sergeant",
							"NCR Corporal",
							"NCR Combat Engineer",
							"NCR Combat Medic",
							"NCR Trooper",
							"NCR Rear Echelon",
							"NCR Off-Duty",
							"NCR Ranger"
						)



/datum/gear/suit/fieldscribe
	name = "Fieldscribe suit"
	path = /obj/item/clothing/suit/toggle/labcoat/fieldscribe
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 5
	restricted_desc = "Scribes"
	restricted_roles = list("Head Scribe",
							"Senior Scribe",
							"Scribe",
							)

/datum/gear/suit/scribecoat
	name = "Fieldscribe coat"
	path = /obj/item/clothing/suit/toggle/labcoat/scribecoat
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 5
	restricted_desc = "Scribes"
	restricted_roles = list("Head Scribe",
							"Senior Scribe",
							"Scribe",
							)

/datum/gear/suit/town
	name = "Town Trenchcoat"
	path = /obj/item/clothing/suit/armor/town
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 4
	restricted_desc = "Oasis"
	restricted_roles = list("Mayor",
							"Secretary",
							"Sheriff",
							"Doctor",
							"Citizen",
							"Deputy",
							"Shopkeeper",
							"Farmer",
							"Prospector",
							"Detective",
							"Barkeep",
							)

/datum/gear/suit/deputyvest
	name = "OPD armor vest"
	path = /obj/item/clothing/suit/armor/medium/vest/oasis
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 4
	restricted_desc = "Oasis Police, Oasis Officials"
	restricted_roles = list("Chief of Police",
							"Officer",
							"Mayor",
							"Detective",
							"Secretary",
							"Shopkeeper",
						)

/datum/gear/suit/hazardvest
	name = "Hazard Vest"
	path = /obj/item/clothing/suit/hazardvest
	subcategory = LOADOUT_SUBCATEGORY_SUIT_FACTIONS
	cost = 2
	restricted_roles = list("Citizen",
							"Prospector",
							)

//These should be left commented out until the holidays or special events.
/*
/datum/gear/suit/christmascoatr
	name = "Red Christmas Coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/christmascoatr
	subcategory = LOADOUT_SUBCATEGORY_SUIT_COATS

/datum/gear/suit/christmascoatg
	name = "Green Christmas Coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/christmascoatg
	subcategory = LOADOUT_SUBCATEGORY_SUIT_COATS

/datum/gear/suit/christmascoatrg
	name = "Red and Green Christmas Coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/christmascoatrg
	subcategory = LOADOUT_SUBCATEGORY_SUIT_COATS
*/

// BEGIN_INTERNALS
// END_INTERNALS
// BEGIN_FILE_DIR
#define FILE_DIR .
// END_FILE_DIR
// BEGIN_PREFERENCES
// END_PREFERENCES
// BEGIN_INCLUDE
// END_INCLUDE
