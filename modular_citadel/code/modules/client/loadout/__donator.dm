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

/datum/gear/donator/kits/crimson
	name = "Crimson's Belongings"
	path = /obj/item/storage/box/large/custom_kit/crimson
	ckeywhitelist = list("rigbe")

/datum/gear/donator/kits/cas
	name = "Cas's Belongings"
	path = /obj/item/storage/box/large/custom_kit/cas
	ckeywhitelist = list("killergryphyn")

/datum/gear/donator/kits/whiskey
	name = "Wihskey's Belongings"
	path = /obj/item/storage/box/large/custom_kit/whiskey
	ckeywhitelist = list("whiskeyxl")

/datum/gear/donator/kits/degan
	name = "Degan's Belongings"
	path = /obj/item/storage/box/large/custom_kit/degan
	ckeywhitelist = list("kuusday")
