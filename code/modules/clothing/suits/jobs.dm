/*
 * Job related
 */

//Captain
/obj/item/clothing/suit/captunic
	name = "captain's parade tunic"
	desc = "Worn by a Captain to show their class."
	icon_state = "captunic"
	inhand_icon_state = "bio_suit"
	flags_inv = HIDEJUMPSUIT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

//Chaplain
/obj/item/clothing/suit/chaplain
	name = "chaplain suit"
	desc = "A piece of clothing adorned by the gods of Coding. Should never exist in this mortal realm."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

/obj/item/clothing/suit/chaplain/nun
	name = "nun robe"
	desc = "Maximum piety in this star system."
	icon_state = "nun"
	inhand_icon_state = "nun"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/chaplain/studentuni
	name = "student robe"
	desc = "The uniform of a bygone institute of learning."
	icon_state = "studentuni"
	inhand_icon_state = "studentuni"
	body_parts_covered = ARMS|CHEST

/obj/item/clothing/suit/chaplain/witchhunter
	name = "witchunter garb"
	desc = "This worn outfit saw much use back in the day."
	icon_state = "witchhunter"
	inhand_icon_state = "witchhunter"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/chaplain/pharaoh
	name = "pharaoh tunic"
	desc = "Lavish tomb not included."
	icon_state = "pharaoh"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/chaplain/holidaypriest
	name = "holiday priest"
	desc = "This is a nice holiday, my son."
	icon_state = "holidaypriest"
	inhand_icon_state = "w_suit"
	flags_inv = HIDEJUMPSUIT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON


//Chef
/obj/item/clothing/suit/toggle/chef
	name = "chef's apron"
	desc = "An apron-jacket used by a high class chef."
	icon_state = "chef"
	inhand_icon_state = "chef"
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	allowed = list(/obj/item/kitchen)
	togglename = "sleeves"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

//Detective
/obj/item/clothing/suit/det_suit
	name = "trenchcoat"
	desc = "An 18th-century multi-purpose trenchcoat. Someone who wears this means serious business."
	icon_state = "detective"
	inhand_icon_state = "det_suit"
	blood_overlay_type = "coat"
	armor = ARMOR_VALUE_LIGHT
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

/obj/item/clothing/suit/det_suit/Initialize()
	. = ..()
	allowed = GLOB.detective_vest_allowed

/obj/item/clothing/suit/det_suit/grey
	name = "noir trenchcoat"
	desc = "A hard-boiled private investigator's grey trenchcoat."
	icon_state = "greydet"
	inhand_icon_state = "greydet"

/obj/item/clothing/suit/det_suit/forensicsred
	name = "red forensics coat"
	icon_state = "forensics_red"
	inhand_icon_state = "forensics_red"

/obj/item/clothing/suit/det_suit/forensicsred/long
	name = "long red forensics coat"
	icon_state = "forensics_red_long"
	inhand_icon_state = "forensics_red_long"

/obj/item/clothing/suit/det_suit/forensicsblue
	name = "blue forensics coat"
	icon_state = "forensics_blue"
	inhand_icon_state = "forensics_blue"

/obj/item/clothing/suit/det_suit/forensicsblue/long
	name = "long blue forensics coat"
	icon_state = "forensics_blue_long"
	inhand_icon_state = "forensics_blue_long"


//Engineering
/obj/item/clothing/suit/hazardvest
	name = "hazard vest"
	desc = "A high-visibility vest used in work zones."
	icon_state = "hazard"
	inhand_icon_state = "hazard"
	blood_overlay_type = "armor"
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	body_parts_hidden = CHEST

//Lawyer
/obj/item/clothing/suit/toggle/lawyer
	name = "blue suit jacket"
	desc = "A snappy dress jacket."
	icon_state = "suitjacket_blue"
	inhand_icon_state = "suitjacket_blue"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	togglename = "buttons"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

/obj/item/clothing/suit/toggle/lawyer/purple
	name = "purple suit jacket"
	desc = "A foppish dress jacket."
	icon_state = "suitjacket_purp"
	inhand_icon_state = "suitjacket_purp"

/obj/item/clothing/suit/toggle/lawyer/black
	name = "black suit jacket"
	desc = "A professional suit jacket."
	icon_state = "suitjacket_black"
	inhand_icon_state = "ro_suit"

/obj/item/clothing/suit/toggle/lawyer/black/syndie
	desc = "A snappy dress jacket. Suspiciously has no tags or branding."

/obj/item/clothing/suit/suspenders
	name = "suspenders"
	desc = "They suspend the illusion of the mime's play."
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "suspenders"
	blood_overlay_type = "armor" //it's the less thing that I can put here
	body_parts_covered = NONE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

//Curator
/obj/item/clothing/suit/curator
	name = "treasure hunter's coat"
	desc = "Both fashionable and lightly armoured, this jacket is favoured by treasure hunters the wasteland over."
	icon_state = "curator"
	inhand_icon_state = "curator"
	blood_overlay_type = "coat"
	cold_protection = CHEST|ARMS
	heat_protection = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket


//Robotocist

/obj/item/clothing/suit/hooded/techpriest
	name = "techpriest robes"
	desc = "For those who REALLY love their toasters."
	icon_state = "techpriest"
	inhand_icon_state = "techpriest"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	hoodtype = /obj/item/clothing/head/hooded/techpriest
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket

/obj/item/clothing/head/hooded/techpriest
	name = "techpriest's hood"
	desc = "A hood for those who REALLY love their toasters."
	icon_state = "techpriesthood"
	inhand_icon_state = "techpriesthood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS
	mutantrace_variation = STYLE_MUZZLE


//Paramedic

/obj/item/clothing/suit/toggle/labcoat/paramedic
	name = "paramedic vest"
	desc = "A dark blue vest with reflective strips for emergency medical technicians."
	icon_state = "paramedic-vest"
	inhand_icon_state = "paramedic-vest"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/four

/obj/item/clothing/suit/toggle/labcoat/emt
	name = "emt vest"
	desc = "A dark blue vest with reflective strips for emergency medical technicians."
	icon_state = "labcoat_emt"
	inhand_icon_state = "labcoat_emt"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/four

/obj/item/clothing/suit/toggle/labcoat/emt/red
	name = "red emt vest"
	desc = "A red vest with reflective strips for emergency medical technicians."
	icon_state = "labcoat_emtred"
	inhand_icon_state = "labcoat_emtred"
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/four

/obj/item/clothing/suit/toggle/labcoat/emt/highvis
	name = "high visibility emt vest"
	desc = "a high visibility vest for emergency medical technicians."
	icon_state = "labcoat_highvis"
	inhand_icon_state = "labcoat_highvis"
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/four
