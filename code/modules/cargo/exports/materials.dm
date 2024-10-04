/datum/export/material
	k_elasticity = 1/1000
	cost = 5 // Cost per MINERAL_MATERIAL_AMOUNT, which is 2000cm3 as of April 2016.
	message = "cm3 of developer's tears. Please, report this on github"
	var/material_id = null
	export_types = list(
		/obj/item/stack/sheet/mineral, /obj/item/stack/tile/mineral,
		/obj/item/stack/ore, /obj/item/coin)
// Yes, it's a base type containing export_types.
// But it has no material_id, so any applies_to check will return false, and these types reduce amount of copypasta a lot

/datum/export/material/get_amount(obj/O)
	if(!material_id)
		return 0
	if(!isitem(O))
		return 0
	var/obj/item/I = O
	if(!(SSmaterials.GetMaterialRef(material_id) in I.custom_materials))
		return 0

	var/amount = I.custom_materials[SSmaterials.GetMaterialRef(material_id)]

	if(istype(I, /obj/item/stack/ore))
		amount *= 0.8 // Station's ore redemption equipment is really goddamn good.

	return round(amount/MINERAL_MATERIAL_AMOUNT)

// Materials. Selling raw can lead to a big payout but takes a lot of work for miners to get a lot. Best to craft art/rnd gear
// Mats are getting a spike in price due to low payout with T4 parts + new demand for crafting. Needs to be tweaked over time. -Kelp

/datum/export/material/diamond
	cost = 1000
	material_id = /datum/material/diamond
	message = "cm3 of diamonds"

/datum/export/material/plasma
	cost = 75 //way too common to be uber valuable
	material_id = /datum/material/plasma
	message = "cm3 of plasma"

/datum/export/material/uranium
	cost = 100
	material_id = /datum/material/uranium
	message = "cm3 of uranium"

/datum/export/material/gold
	cost = 300
	material_id = /datum/material/gold
	message = "cm3 of gold"

/datum/export/material/silver
	cost = 150
	material_id = /datum/material/silver
	message = "cm3 of silver"

/datum/export/material/titanium
	cost = 75 // buffed because payouts from scrapping are WAY lower
	material_id = /datum/material/titanium
	message = "cm3 of titanium"
	export_types = list(/obj/item/stack/sheet/mineral/titanium)

/datum/export/material/plastic
	cost = 75
	material_id = /datum/material/plastic
	message = "cm3 of plastic"
	export_types = list(/obj/item/stack/sheet/plastic)

/datum/export/material/metal
	cost = 10
	message = "cm3 of metal"
	material_id = /datum/material/iron
	export_types = list(
		/obj/item/stack/sheet/metal, /obj/item/stack/tile/plasteel,
		/obj/item/stack/sheet/plasteel, /obj/item/stack/rods,
		/obj/item/stack/ore, /obj/item/coin)

/datum/export/material/glass
	cost = 10
	message = "cm3 of glass"
	material_id = /datum/material/glass
	export_types = list(/obj/item/stack/sheet/glass, /obj/item/stack/ore,
		/obj/item/shard)

/datum/export/material/adamantine
	cost = 250
	material_id = /datum/material/adamantine
	message = "cm3 of Pre-Fall ingots"
	export_types = list(/obj/item/ingot/adamantine, /obj/item/stack/sheet/mineral/adamantine)

/*
/datum/export/material/prefall
	cost = 15
	material_id = /datum/material/prefall
	message = "cm3 of prefall alloy"
	export_types = (/obj/item/stack/sheet/prefall)
*/

/datum/export/material/mythril
	cost = 100
	material_id = /datum/material/mythril
	message = "cm3 of mythril"
	export_types = list(/obj/item/ingot/mythril)

/datum/export/material/bscrystal
	cost = 500 // Beware of Mass Fusion
	message = "cm3 of ultracite crystals"
	material_id = /datum/material/bluespace
	export_types = list(/obj/item/stack/sheet/bluespace_crystal)

/datum/export/material/runite
	cost = 300
	message = "cm3 of runite"
	material_id = /datum/material/runite

/datum/export/material/leather
	cost = 20
	message = " "
	unit_name = "sheets of leather"
	material_id = /datum/material/leather
	export_types = list(/obj/item/stack/sheet/leather)
	k_elasticity = 1/1000

/datum/export/material/expalloy
	cost = 100 // Limited, unless clinic goes out of their way, which takes time.
	message = ""
	unit_name = "polymer alloy"
	material_id = /datum/material/leather
	export_types = list(/obj/item/stack/sheet/mineral/abductor)

/datum/export/material/bone
	cost = 40
	message = ""
	unit_name = "bone"
	material_id = /datum/material/bone
	export_types = list(/obj/item/stack/sheet/bone)

/datum/export/material/sinew
	cost = 15
	message = ""
	unit_name = "pieces of sinew"
	material_id = /datum/material/sinew
	export_types = list(/obj/item/stack/sheet/sinew)

/datum/export/material/chitin
	cost = 100
	message = ""
	unit_name = "pieces of chitin"
	material_id = /datum/material/chitin
	export_types = list(/obj/item/stack/sheet/animalhide/chitin)

/datum/export/material/f13cash
	cost = 10
	message = ""
	unit_name = "copper coin"
	material_id = /datum/material/f13cash
	export_types = list(/obj/item/stack/f13Cash/caps)

/datum/export/material/f13cash/silver
	cost = 100
	unit_name = "silver coin"
	export_types = list(/obj/item/stack/f13Cash/denarius)

/datum/export/material/f13cash/gold
	cost = 1000
	unit_name = "gold coin"
	export_types = list(/obj/item/stack/f13Cash/aureus)

/datum/export/material/f13cash/scrip
	cost = 0.00000001 // Texarkana Trade Union scrip. They like people using their money because economics or something; 1 copper = 2 scrip; if abused again, set to 5
	unit_name = "scrip"
	export_types = list(/obj/item/stack/f13Cash/ncr)
	k_elasticity = 0/1000


/datum/export/material/aethergiesthide
	cost = 1000
	message = " "
	unit_name = "aethergiest hide"
	material_id = /datum/material/aethergiesthide
	export_types = list(/obj/item/stack/sheet/animalhide/aethergiest)
	k_elasticity = 0/1000


/datum/export/material/geckohide
	cost = 100 //will see if this works out...
	message = " "
	unit_name = "gecko hide"
	material_id = /datum/material/geckohide
	export_types = list(/obj/item/stack/sheet/animalhide/gecko)

/datum/export/material/molerathide
	cost = 100
	message = " "
	unit_name = "giant rat hide"
	material_id = /datum/material/molerathide
	export_types = list(/obj/item/stack/sheet/animalhide/molerat)

/datum/export/material/wolfhide
	cost = 200
	message = " "
	unit_name = "dog hide"
	material_id = /datum/material/wolfhide
	export_types = list(/obj/item/stack/sheet/animalhide/wolf)

/datum/export/material/radstaghide
	cost = 250
	message = " "
	unit_name = "radstag hide"
	material_id = /datum/material/radstaghide
	export_types = list(/obj/item/stack/sheet/animalhide/radstag)

/datum/export/material/brahminhide
	cost = 150
	message = " "
	unit_name = "brahmin hide"
	material_id = /datum/material/brahminhide
	export_types = list(/obj/item/stack/sheet/animalhide/brahmin)
