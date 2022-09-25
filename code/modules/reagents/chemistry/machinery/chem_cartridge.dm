/obj/item/stock_parts/chem_cartridge
	name = "Chemical Cartridge"
	desc = "A propriatary casing holding a mix of raw material for use in chem dispensors."
	icon = 'modular_coyote/icons/objects/chem_cartridge.dmi' //placeholder
	icon_state = "simple" //placeholder
	item_state = "simple" //placeholder
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi' //placeholder
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi' //placeholder
	
	custom_materials = list(/datum/material/iron=1000, /datum/material/glass=500, /datum/material/plasma=100)
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL

	rating = 1
	var/charge = 0 //set on init
	var/maxCharge = 10000

/obj/item/stock_parts/chem_cartridge/Initialize()
	. = ..()
	charge = maxCharge

/obj/item/stock_parts/chem_cartridge/proc/takeMaterial(ammount)
	ammount = round(ammount)
	if(charge <= 0 || ammount > charge)
		return FALSE
	charge = (charge - ammount)
	return TRUE

/obj/item/stock_parts/chem_cartridge/proc/getPercentage()
	return round((charge / maxCharge) * 100)

/obj/item/stock_parts/chem_cartridge/examine()
	. = ..()
	. += span_info("It currently has [src.getPercentage()]% remaining.")

/obj/item/stock_parts/chem_cartridge/garbage
	name = "ancient chemical cartridge"
	desc = "A propriatary single use casing holding a mix of raw material for use in chem dispensors. This one is very worn and mostly used up."
	icon_state = "salvaged" //placeholder
	item_state = "salvaged" //placeholder
	maxCharge = 1250
	custom_materials = list(/datum/material/iron=500, /datum/material/glass=500)

/obj/item/stock_parts/chem_cartridge/crafted
	name = "imitation chemical cartridge"
	desc = "A casing holding a mix of raw material for use in chem dispensors. This one is a crudely fabricated imitation."
	icon_state = "crafted" //placeholder
	item_state = "crafted" //placeholder
	maxCharge = 2500
	custom_materials = list(/datum/material/iron=1000, /datum/material/glass=500)

/obj/item/stock_parts/chem_cartridge/simple
	name = "salvaged chemical cartridge"
	desc = "A casing holding a mix of raw material for use in chem dispensors. It looks like a mass produced knock-off."
	maxCharge = 5000
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500, /datum/material/plasma = 100)

/obj/item/stock_parts/chem_cartridge/pristine
	name = "Pristine chemical cartridge"
	desc = "A propriatary single use casing holding a mix of raw material for use in chem dispensors. This one looks good as new"
	icon_state = "pristine" //placeholder
	item_state = "pristine" //placeholder
	maxCharge = 10000
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=1000, /datum/material/plasma = 500)
