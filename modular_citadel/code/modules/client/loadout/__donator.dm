//This is the file that handles donator loadout items.

/datum/gear/donator
	name = "IF YOU SEE THIS, PING A CODER RIGHT NOW!"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/holster/ranger45
	category = LOADOUT_CATEGORY_DONATOR
	ckeywhitelist = list("This entry should never appear with this variable set.") //If it does, then that means somebody fucked up the whitelist system pretty hard
	cost = 0

/datum/gear/donator/donortestingbikehorn
	name = "Donor item testing"
	slot = SLOT_IN_BACKPACK
	path = /obj/item/storage/belt/holster/ranger45
	geargroupID = list("DONORTEST") //This is a list mainly for the sake of testing, but geargroupID works just fine with ordinary strings
/////////////////////
///Loadout Boxes///// See kits.dm, use this model for loadouts that have more than one item per character.
/////////////////////
/datum/gear/donator/kits
	slot = SLOT_IN_BACKPACK

/*example
/datum/gear/donator/kits/averyamadeus
	name = "Avery Amadeus' belongings"
	path = /obj/item/storage/box/large/custom_kit/averyamadeus
	ckeywhitelist = list("topbirb")


*/

/obj/item/storage/box/large/custom_kit/cayce/PopulateContents()
	new /obj/item/clothing/suit/armored/medium/steelbib(src)
	new /obj/item/clothing/head/helmet/armyhelmet/heavy(src)
	new /obj/item/twohanded/sledgehammer(src)
	new /obj/item/pda(src)

/datum/gear/donator/kits/cayce
	name = "Jett Lowes belongings"
	path = /obj/item/storage/box/large/custom_kit/cayce
	ckeywhitelist = list("cayce")

/obj/item/storage/box/large/custom_kit/sugga/PopulateContents()
	new /obj/item/clothing/suit/armor/f13/combat(src)
	new /obj/item/clothing/head/helmet/f13/combat(src)
	new /obj/item/gun/ballistic/revolver/police(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)
	new /obj/item/ammo_box/a357(src)

/datum/gear/donator/kits/sugga
	name = "Suggas box"
	path = /obj/item/storage/box/large/custom_kit/sugga
	ckeywhitelist = list("sugga")

/obj/item/storage/box/large/custom_kit/klatue/PopulateContents()
	new /obj/item/gun/ballistic/rifle/hobo/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/storage/belt/holster(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat(src)
	new /obj/item/gun/energy/laser/wattz/magneto(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/clothing/head/helmet/riot(src)

/datum/gear/donator/kits/klatue
	name = "Klatue box"
	path = /obj/item/storage/box/large/custom_kit/klatue
	ckeywhitelist = list("klatue9")

/obj/item/storage/box/large/custom_kit/riggy/PopulateContents()
	new /obj/item/gun/ballistic/rifle/hobo/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/ammo_casing/caseless/plasmacaster(src)
	new /obj/item/storage/belt/holster(src)
	new /obj/item/clothing/suit/armor/hos/trenchcoat(src)
	new /obj/item/gun/energy/laser/wattz/magneto(src)
	new /obj/item/stock_parts/cell/ammo/ec(src)
	new /obj/item/clothing/head/helmet/riot(src)

/datum/gear/donator/kits/riggy
	name = "Items"
	path = /obj/item/storage/box/large/custom_kit/riggy
	ckeywhitelist = list("rigbe")
