/obj/item/stock_parts/chem_cartridge
	name = "Chemical Cartridge"
	desc = "A propriatary casing holding a mix of raw material for use in chem dispensors."
	icon = 'modular_coyote/icons/objects/chem_cartridge.dmi' //these are coder sprites.
	icon_state = "simple"
	inhand_icon_state = "simple"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	
	custom_materials = list(/datum/material/iron=1000, /datum/material/glass=500, /datum/material/plasma=100)
	force = 5
	throwforce = 5
	throw_speed = 2
	throw_range = 4
	w_class = WEIGHT_CLASS_TINY

	rating = 1
	var/charge = 0 //set on init
	var/maxCharge = 1000000000

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
	icon_state = "salvaged"
	inhand_icon_state = "salvaged"
	custom_price = PRICE_ALMOST_EXPENSIVE
	maxCharge = 250000000
	custom_materials = list(/datum/material/iron=500, /datum/material/glass=500)

/obj/item/stock_parts/chem_cartridge/crafted
	name = "Improvised chemical cartridge"
	desc = "A casing holding a mix of raw material for use in chem dispensors. This one is a crudely fabricated imitation."
	icon_state = "crafted"
	inhand_icon_state = "crafted"
	custom_price = PRICE_ABOVE_EXPENSIVE
	maxCharge = 700000000
	custom_materials = list(/datum/material/iron=1000, /datum/material/glass=500)

/obj/item/stock_parts/chem_cartridge/simple
	name = "Knock-off chemical cartridge"
	desc = "A casing holding a mix of raw material for use in chem dispensors. It looks like a mass produced knock-off."
	maxCharge = 500000000
	custom_price = PRICE_ABOVE_EXPENSIVE
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500, /datum/material/plasma = 100)

/obj/item/stock_parts/chem_cartridge/pristine
	name = "Pristine chemical cartridge"
	desc = "A propriatary single use casing holding a mix of raw material for use in chem dispensors. This one looks good as new"
	icon_state = "pristine"
	inhand_icon_state = "pristine"
	custom_price = PRICE_REALLY_EXPENSIVE
	maxCharge = 1000000000
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=1000, /datum/material/plasma = 500)
