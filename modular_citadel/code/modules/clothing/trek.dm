/*/////////////////////////////////////////////////////////////////////////////////
///////																		///////
///////								Star Trek Stuffs						///////
///////																		///////
*//////////////////////////////////////////////////////////////////////////////////
//  <3 Nienhaus && Joan.
// I made the Voy and DS9 stuff tho. - Poojy
// Armor lists for even Heads of Staff is Nulled out do round start armor as well most armor going onto the suit itself rather then a armor slot - Trilby
///////////////////////////////////////////////////////////////////////////////////

//DS9

/obj/item/clothing/suit/storage/trek/ds9
	name = "Padded Overcoat"
	desc = "The overcoat worn by all officers of the 2380s."
	icon = 'modular_citadel/icons/obj/clothing/trek_item_icon.dmi'
	icon_state = "trek_ds9_coat"
	mob_overlay_icon = 'modular_citadel/icons/mob/clothing/trek_mob_icon.dmi'
	inhand_icon_state = "trek_ds9_coat"
	body_parts_covered = CHEST|GROIN|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	permeability_coefficient = 0.50
	allowed = list(
		/obj/item/flashlight, /obj/item/analyzer,
		/obj/item/radio, /obj/item/tank/internals/emergency_oxygen,
		/obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer,/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/glass/bottle/vial,/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/pill,/obj/item/storage/pill_bottle, /obj/item/restraints/handcuffs,/obj/item/hypospray
		)
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/storage/trek/ds9/admiral // Only for adminuz
	name = "Admiral Overcoat"
	desc = "Admirality specialty coat to keep flag officers fashionable and protected."
	icon_state = "trek_ds9_coat_adm"
	inhand_icon_state = "trek_ds9_coat_adm"
	permeability_coefficient = 0.01
	armor = ARMOR_VALUE_LIGHT

//MODERN ish Joan sqrl sprites. I think

//For general use
/obj/item/clothing/suit/storage/fluff/fedcoat
	name = "Federation Uniform Jacket"
	desc = "A uniform jacket from the United Federation. Set phasers to awesome."
	icon = 'modular_citadel/icons/obj/clothing/trek_item_icon.dmi'
	mob_overlay_icon = 'modular_citadel/icons/mob/clothing/trek_mob_icon.dmi'
	icon_state = "fedcoat"
	inhand_icon_state = "fedcoat"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
				/obj/item/tank/internals/emergency_oxygen,
				/obj/item/flashlight,
				/obj/item/analyzer,
				/obj/item/radio,
				/obj/item/gun,
				/obj/item/melee/baton,
				/obj/item/restraints/handcuffs,
				/obj/item/reagent_containers/hypospray,
				/obj/item/hypospray,
				/obj/item/healthanalyzer,
				/obj/item/reagent_containers/syringe,
				/obj/item/reagent_containers/glass/bottle/vial,
				/obj/item/reagent_containers/glass/beaker,
				/obj/item/storage/pill_bottle,
				/obj/item/taperecorder)
	armor = ARMOR_VALUE_LIGHT
	var/unbuttoned = 0

/obj/item/clothing/suit/storage/fluff/fedcoat/verb/toggle()
	set name = "Toggle coat buttons"
	set category = "Object"
	set src in usr

	var/mob/living/L = usr
	if(!istype(L) || !CHECK_MOBILITY(L, MOBILITY_USE))
		return FALSE

	switch(unbuttoned)
		if(0)
			icon_state = "[initial(icon_state)]_open"
			inhand_icon_state = "[initial(inhand_icon_state)]_open"
			unbuttoned = 1
			to_chat(usr,"You unbutton the coat.")
		if(1)
			icon_state = "[initial(icon_state)]"
			inhand_icon_state = "[initial(inhand_icon_state)]"
			unbuttoned = 0
			to_chat(usr,"You button up the coat.")
	usr.update_inv_wear_suit()

	//Variants
/obj/item/clothing/suit/storage/fluff/fedcoat/medsci
		icon_state = "fedblue"
		inhand_icon_state = "fedblue"

/obj/item/clothing/suit/storage/fluff/fedcoat/eng
		icon_state = "fedeng"
		inhand_icon_state = "fedeng"

/obj/item/clothing/suit/storage/fluff/fedcoat/capt
		icon_state = "fedcapt"
		inhand_icon_state = "fedcapt"

//"modern" ones for fancy

/obj/item/clothing/suit/storage/fluff/modernfedcoat
	name = "Modern Federation Uniform Jacket"
	desc = "A modern uniform jacket from the United Federation."
	icon = 'modular_citadel/icons/obj/clothing/trek_item_icon.dmi'
	mob_overlay_icon = 'modular_citadel/icons/mob/clothing/trek_mob_icon.dmi'
	icon_state = "fedmodern"
	inhand_icon_state = "fedmodern"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_covered = CHEST|GROIN|ARMS
	allowed = list(
		/obj/item/flashlight, /obj/item/analyzer,
		/obj/item/radio, /obj/item/tank/internals/emergency_oxygen,
		/obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer,/obj/item/reagent_containers/syringe,
		/obj/item/reagent_containers/glass/bottle/vial,/obj/item/reagent_containers/glass/beaker,
		/obj/item/reagent_containers/pill,/obj/item/storage/pill_bottle, /obj/item/restraints/handcuffs,/obj/item/hypospray
		)
	armor = ARMOR_VALUE_LIGHT

	//Variants
/obj/item/clothing/suit/storage/fluff/modernfedcoat/medsci
		icon_state = "fedmodernblue"
		inhand_icon_state = "fedmodernblue"

/obj/item/clothing/suit/storage/fluff/modernfedcoat/eng
		icon_state = "fedmoderneng"
		inhand_icon_state = "fedmoderneng"

/obj/item/clothing/suit/storage/fluff/modernfedcoat/sec
		icon_state = "fedmodernsec"
		inhand_icon_state = "fedmodernsec"

/obj/item/clothing/head/caphat/formal/fedcover
	name = "Federation Officer's Cap"
	armor = ARMOR_VALUE_LIGHT
	desc = "An officer's cap that demands discipline from the one who wears it."
	icon = 'modular_citadel/icons/obj/clothing/trek_item_icon.dmi'
	icon_state = "fedcapofficer"
	mob_overlay_icon = 'modular_citadel/icons/mob/clothing/trek_mob_icon.dmi'
	inhand_icon_state = "fedcapofficer"

	//Variants
/obj/item/clothing/head/caphat/formal/fedcover/medsci
		icon_state = "fedcapsci"
		inhand_icon_state = "fedcapsci"

/obj/item/clothing/head/caphat/formal/fedcover/eng
		icon_state = "fedcapeng"
		inhand_icon_state = "fedcapeng"

/obj/item/clothing/head/caphat/formal/fedcover/sec
		icon_state = "fedcapsec"
		inhand_icon_state = "fedcapsec"

/obj/item/clothing/head/caphat/formal/fedcover/black
		icon_state = "fedcapblack"
		inhand_icon_state = "fedcapblack"

//orvilike caps
/obj/item/clothing/head/kepi/orvi
	name = "\improper Federation kepi"
	desc = "A visored cap worn by all officers since 2550s."
	icon_state = "kepi_ass"

/obj/item/clothing/head/kepi/orvi/command
	icon_state = "kepi_com"

/obj/item/clothing/head/kepi/orvi/engsec
	icon_state = "kepi_ops"

/obj/item/clothing/head/kepi/orvi/medsci
	icon_state = "kepi_medsci"

/obj/item/clothing/head/kepi/orvi/service
	icon_state = "kepi_srv"
