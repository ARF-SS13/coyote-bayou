/datum/export/material
	k_elasticity = 0
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

/datum/export/material/diamond
	cost = 250
	material_id = /datum/material/diamond
	message = "cm3 of diamonds"

/datum/export/material/plasma
	cost = 100
	material_id = /datum/material/plasma
	message = "cm3 of ultracite"

/datum/export/material/uranium
	cost = 50
	material_id = /datum/material/uranium
	message = "cm3 of uranium"

/datum/export/material/gold
	cost = 60
	material_id = /datum/material/gold
	message = "cm3 of gold"

/datum/export/material/silver
	cost = 25
	material_id = /datum/material/silver
	message = "cm3 of silver"

/datum/export/material/titanium
	cost = 60
	material_id = /datum/material/titanium
	message = "cm3 of titanium"
	export_types = list(/obj/item/stack/sheet/mineral/titanium)

/datum/export/material/plastic
	cost = 5
	material_id = /datum/material/plastic
	message = "cm3 of plastic"
	export_types = list(/obj/item/stack/sheet/plastic)

/datum/export/material/metal
	cost = 3
	message = "cm3 of metal"
	material_id = /datum/material/iron
	export_types = list(
		/obj/item/stack/sheet/metal, /obj/item/stack/tile/plasteel,
		/obj/item/stack/sheet/plasteel, /obj/item/stack/rods, 
		/obj/item/stack/ore, /obj/item/coin)

/datum/export/material/glass
	cost = 3
	message = "cm3 of glass"
	material_id = /datum/material/glass
	export_types = list(/obj/item/stack/sheet/glass, /obj/item/stack/ore,
		/obj/item/shard)

/datum/export/material/adamantine
	cost = 100
	material_id = /datum/material/adamantine
	message = "cm3 of pre-war ingots"
	export_types = list(/obj/item/stack/sheet/mineral/adamantine,
	/obj/item/ingot/adamantine)

/* /datum/export/material/prewar
	cost = 15
	material_id = /datum/material/prewar
	message = "cm3 of prewar alloy"
	export_types = (/obj/item/stack/sheet/prewar) */

/datum/export/material/mythril
	cost = 1000
	material_id = /datum/material/mythril
	message = "cm3 of mythril"

/datum/export/material/bscrystal
	cost = 150
	message = "cm3 of bluespace crystals"
	material_id = /datum/material/bluespace

/datum/export/material/runite
	cost = 300
	message = "cm3 of runite"
	material_id = /datum/material/runite

/datum/export/material/leather
	cost = 7
	unit_name = "sheets of leather"
	material_id = /datum/material/leather
	export_types = list(/obj/item/stack/sheet/leather)

/datum/export/material/bone
	cost = 3
	unit_name = "bone"
	material_id = /datum/material/bone
	export_types = list(/obj/item/stack/sheet/bone)

/datum/export/material/sinew
	cost = 3
	unit_name = "pieces of sinew"
	material_id = /datum/material/sinew
	export_types = list(/obj/item/stack/sheet/sinew)

/datum/export/material/chitin
	cost = 4
	unit_name = "pieces of chitin"
	material_id = /datum/material/chitin
	export_types = list(/obj/item/stack/sheet/animalhide/chitin)

/datum/export/material/f13cash
	cost = 2
	unit_name = "caps"
	material_id = /datum/material/f13cash
	export_types = list(/obj/item/stack/f13Cash/caps)

/datum/export/material/deathclawhide
	cost = 175
	unit_name = "deathclaw hide"
	material_id = /datum/material/deathclawhide
	export_types = list(/obj/item/stack/sheet/animalhide/deathclaw)
