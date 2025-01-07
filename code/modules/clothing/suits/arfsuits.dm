///////////////
//// ARMOR ////
///////////////

/obj/item/clothing/suit/armor
	name = "armor template"
	icon = 'icons/obj/clothing/suits.dmi'
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 30
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	body_parts_covered = CHEST|GROIN|ARMS|LEGS // gonna be like this until limbs stop critting people
	blood_overlay_type = "armor"
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tier_desc = ARMOR_CLOTHING_DESC
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

	/// which mutantrace variations are supported. leave at NONE to keep it snapped at plantigrade
	//mutantrace_variation = NONE

	/// These dont seem to do anything
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/armor_block_chance = null //Chance for the armor to block a low penetration projectile
	var/deflection_chance = null //Chance for the armor to redirect a blocked projectile
	var/melee_block_threshold = null
	var/dmg_block_threshold = null

/obj/item/clothing/suit/armor/Initialize()
	. = ..()
	if(!islist(allowed))
		allowed = list()
	// Here we set up what's allowed in their suit storage.
	// this lets us merge multiple lists, and also disallow certain things from it too
	allowed |= GLOB.default_all_armor_slot_allowed

/obj/item/clothing/suit/armor/examine()
	. = ..()
	. += span_notice(armor_tier_desc)


/*

* ARMOR TIERS
*
* Clothes (not armor)
* - lightly armored at best, might be craftable into armor accessories later
* - Pockets?
*
* Light
* - High mobility (can run from most mobs easily)
* - Common, cheap, usually
* - Low protection
* Medium
* - Less mobility (likely need sprint to escape most mobs)
* - something
* - Med protection
* Heavy
* - Low mobility (Tank hits or have friends)
* - High protection
* - More specialized armor too
* Power Armor
* - Mobile
* - Just about godmode

 */

/////////////
// CLOTHES //
/////////////

/*
 * Types:
 * Overalls (chest legs)
 * - utility suits for holding tools and stuff
 * Jacket (chest arms)
 * - Might have pockets?
 * Duster (chest arms legs)
 * - Full body decorative and cool
 * vest (chest)
 * - Decorative and cool
 * costume? (everything?)
 * Also should have armor inserts later
 */

//// Clothes ARMOR PARENT ////

/obj/item/clothing/suit/armor/outfit
	name = "basic outerwear template"
	desc = "probably shouldnt see this"
	icon = 'icons/obj/clothing/suits.dmi'
	//mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "overalls_farmer"
	inhand_icon_state = "overalls_farmer"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket //fuck it everyone gets pockets
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 10
	equip_delay_other = 10
	max_integrity = 100
	armor = ARMOR_VALUE_CLOTHES

//////////////////
//// OVERALLS ////
//////////////////

/obj/item/clothing/suit/armor/outfit/overalls
	name = "overalls"
	desc = "A set of overall templates that shouldnt exist."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "overalls_farmer"
	inhand_icon_state = "overalls_farmer"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets // big pockets!
	body_parts_hidden = CHEST|GROIN|LEGS

/obj/item/clothing/suit/armor/outfit/overalls/farmer
	name = "farmer overalls"
	desc = "A set of denim overalls suitable for farming."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "overalls_farmer"
	inhand_icon_state = "overalls_farmer"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service/overalls

/obj/item/clothing/suit/armor/outfit/overalls/farmer/Initialize()
	. = ..()
	allowed |= GLOB.toolbelt_allowed

/obj/item/clothing/suit/armor/outfit/overalls/sexymaid // best suit
	name = "sexy maid outfit"
	desc = "A maid outfit that shows just a little more skin than needed for cleaning duties."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	icon_state = "sexymaid_s"
	inhand_icon_state = "sexymaid_s"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service/overalls

/obj/item/clothing/suit/armor/outfit/overalls/sexymaid/Initialize()
	. = ..()
	allowed |= GLOB.toolbelt_allowed

/obj/item/clothing/suit/armor/outfit/overalls/blacksmith
	name = "blacksmith apron"
	desc = "A heavy leather apron designed for protecting the user when metalforging."
	icon = 'icons/fallout/clothing/aprons.dmi'
	icon_state = "forge"
	inhand_icon_state = "forge"
	blood_overlay_type = "armor"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service/overalls
	body_parts_hidden = CHEST

/* 	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "opifex_apron"
	inhand_icon_state = "opifex_apron" */ // cus this darn sprite is hidden so well I cant find it

/obj/item/clothing/suit/armor/outfit/overalls/blacksmith/Initialize()
	. = ..()
	allowed |= GLOB.toolbelt_allowed

//////////////
//// VEST ////
//////////////

/obj/item/clothing/suit/armor/outfit/vest
	name = "tan vest"
	desc = "It's a vest made of tanned leather."
	icon_state = "tanleather"
	inhand_icon_state = "det_suit"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	body_parts_hidden = CHEST

/obj/item/clothing/suit/armor/outfit/vest/cowboy //Originally cowboy stuff by Nienhaus
	name = "brown vest"
	desc = "A brown vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboybvest"
	inhand_icon_state = "lb_suit"

/obj/item/clothing/suit/armor/outfit/vest/bartender
	name = "bartenders vest"
	desc = "A grey vest, adorned with bartenders arm cuffs, a classic western look."
	icon_state = "westender"
	inhand_icon_state = "lb_suit"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service/overalls

/obj/item/clothing/suit/armor/outfit/vest/cowboy/grey
	name = "grey vest"
	desc = "A grey vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboygvest"
	inhand_icon_state = "gy_suit"

/obj/item/clothing/suit/armor/outfit/vest/utility
	name = "utility vest"
	desc = "A practical vest with pockets for tools and such."
	icon_state = "vest_utility"
	inhand_icon_state = "vest_utility"
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/four
	body_parts_hidden = 0 // has a bit of upper window stuff

/obj/item/clothing/suit/armor/outfit/custompa
	name = "Custom Midwestern B.O.S Power Armor"
	desc = "A set of reftted custom Power Armor made to function akin to medium armor. Stylish and fitted well!"
	icon_state = "midwestpa"
	inhand_icon_state = "midwestpa"
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2 )
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_power.dmi'
	icon = 'icons/fallout/clothing/armored_power.dmi'
	var/requires_training = FALSE

/obj/item/clothing/suit/armor/outfit/vest/utility/gear_harness
	name = "secondary gear harness"
	desc = "A collection of practically invisible straps useful for holding items. And that's about it."
	icon_state = "gear_harness"
	inhand_icon_state = "gear_harness"
	w_class = WEIGHT_CLASS_TINY

/obj/item/clothing/suit/armor/outfit/vest/utility/logisticsofficer //same as his beret
	name = "logistics officer utility vest"
	desc = "A practical and armored vest with pockets for tools and such."

/obj/item/clothing/suit/armor/outfit/vest/flakjack
	name = "flak jacket"
	desc = "A dilapidated jacket made of ballistic nylon. Smells faintly of napalm."
	icon_state = "flakjack"
	inhand_icon_state = "redtag"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|HEAD
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	armor_tokens = list()



////////////////
//// JACKET ////
////////////////

/obj/item/clothing/suit/armor/outfit/jacket
	name = "jacket template"
	desc = "its a jacket!!"
	icon_state = "veteran"
	inhand_icon_state = "suit-command"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/outfit/jacket/cyberpunkjacket
	name = "CrystalJock Bomber jacket"
	desc = "A very cyberpunk looking jacket. It is quite comfortable to wear and gives you an estimated added coolness factor of 20%. For the chooms and wastelander looking to make their wardrobe extra spiffy."
	icon_state = "cyberjacket"
	inhand_icon_state = "cyberjacket"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/cyberpunkjacket/two
	name = "Darkened Crystaljock jacket"
	desc = "A darkened version of a very cyberpunk looking jacket. Looks very comfortable to wear."
	icon_state = "cyberjacket2"
	inhand_icon_state = "cyberjacket2"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/cyberpunkjacket/three
	name = "Highlighted Crystaljock jacket"
	desc = "A highlighted version of a very cyberpunk looking jacket. Looks very comfortable to wear."
	icon_state = "cyberjacket3"
	inhand_icon_state = "cyberjacket3"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'


/obj/item/clothing/suit/armor/outfit/jacket/cyberpunkjacket/custom
	name = "Luxurious Cropped Crystaljock jacket"
	desc = "An extremely pristine and luxuriously made custom crystaljock jacket from Latos Systems finest tailors. Made with a quilted interior, white leather, and quality stitching. This is a jacket to behold with those golden zippers and a lovely symbol of a moth and cat on the back of the jacket. A jacket for the most luxuriously and lavish living chooms."
	icon_state = "cyberjacketcustom"
	inhand_icon_state = "cyberjacketcustom"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'


/* * * * * * * *
* Cyber stuff
* * * * * * * * */

/obj/item/clothing/suit/armor/outfit/jacket/cybercoat
	name = "Blue cyber themed coat"
	desc = "A very well made cyberpunk themed coat. It is made of a material that allows images and text to be displayed. This one seems to show off the name of some corporation. It's quite comfortable to wear as well."
	icon_state = "cybercoat"
	inhand_icon_state = "cybercoat"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/cybercoat/skull
	name = "Purple cyber themed coat"
	desc = "A very well made cyberpunk themed coat. It is made of a material that allows images and text to be displayed. This one seems to show off the name of a skull. It's quite comfortable to wear as well."
	icon_state = "cybercoat2"
	inhand_icon_state = "cybercoat2"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/cybercoat/interdyne
	name = "Red cyber themed coat"
	desc = "A very well made cyberpunk themed coat. It is made of a material that allows images and text to be displayed. This one seems to show off the name of some corporation. It's quite comfortable to wear as well."
	icon_state = "cybercoat3"
	inhand_icon_state = "cybercoat3"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks
	name = "Black and red cloak"
	desc = "A black and red themed cloak. It seems to signal power to those who wear it, like they are the head of staff somewhere. Or could just be you, it's a damn nice cloak, however."
	icon_state = "hoscloak"
	inhand_icon_state = "hoscloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/qm
	name = "Merchant cloak"
	desc = "A lovingly lavish cloak made of fine brown-dyed silk and golden accents. A fitting cloak for the merchants of the wasteland."
	icon_state = "qmcloak"
	inhand_icon_state = "qmcloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/cmo
	name = "Medic's cloak"
	desc = "A medical themed cloak that screams out 'I am here to save the day'. Or so you believe. None the less, it's comfortable and easy to wear. Good for the summer occassion."
	icon_state = "cmocloak"
	inhand_icon_state = "cmocloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/ce
	name = "Engineer's geometric cloak"
	desc = "A cloak that has some unique geometric designs to it. It gives one the sensation of wanting to use a wrench and yelling out 'Gotta move that gear up!'. It is comfortable and easy to wear."
	icon_state = "cecloak"
	inhand_icon_state = "cecloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/rd
	name = "Researcher's cloak"
	desc = "A cloak that is fitting for a researcher. Purple colored and soft to the touch."
	icon_state = "rdcloak"
	inhand_icon_state = "rdcloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/captain
	name = "Royal Captain's cloak"
	desc = "A cloak that is fitting for the most prestigious captain. A royal blue with gold accents and gold fittings, it's made to be shown off while showcasing just how important you are. Or so one believes so."
	icon_state = "capcloak"
	inhand_icon_state = "capcloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/cleaner
	name = "Janitor's bubbly cloak"
	desc = "A cloak made from animated materials. This one is a light purple, soft to the touch and animated!. The animation depicts bubbles forming from the back of the cloak, how cute."
	icon_state = "cleanercloak"
	inhand_icon_state = "cleanercloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/healer
	name = "Healer's cloak"
	desc = "A cloak made from animated materials. This one is a cloak with a animated medical symbol on the back. Made from sterile materials, it's befitting for a medical practitioner of the wasteland."
	icon_state = "healercloak"
	inhand_icon_state = "healercloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/outfit/jacket/themedcloaks/miner
	name = "Miner's cloak"
	desc = "A cloak made from animated materials. This one is a cloak with a animated pickxe hitting a mineral. It is a cloak befitting a miner and made from hardy materials suited for caves and the such."
	icon_state = "minercloak"
	inhand_icon_state = "minercloak"
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST|ARMS
	slowdown = ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT * ARMOR_SLOWDOWN_LIGHT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'



/obj/item/clothing/suit/armor/outfit/jacket/merc
	name = "merc veteran coat"
	desc = " A blue leather coat adorned with war medals.<br>This type of outfit is common for professional mercenaries and bounty hunters."
	icon_state = "veteran"
	inhand_icon_state = "suit-command"
	body_parts_hidden = CHEST

/obj/item/clothing/suit/armor/outfit/jacket/battlecruiser //Do we have Star Craft here as well?!
	name = "captain's coat"
	desc = "Battlecruiser operational!"
	icon_state = "battlecruiser"
	inhand_icon_state = "hostrench"

/obj/item/clothing/suit/armor/outfit/jacket/mantle
	name = "hide mantle"
	desc = " A rather grisly selection of cured hides and skin, sewn together to form a ragged mantle."
	icon_state = "mantle_liz"
	inhand_icon_state = "det_suit"
	body_parts_hidden = 0

/obj/item/clothing/suit/armor/outfit/jacket/mfp //Mad Max 1 1979 babe!
	name = "MFP jacket"
	desc = "A Main Force Patrol leather jacket.<br>Offbeat."
	icon_state = "mfp"
	inhand_icon_state = "hostrench"

/obj/item/clothing/suit/armor/outfit/jacket/mfp/raider
	name = "offbeat jacket"
	desc = "A black leather jacket with a single metal shoulder pad on the right side.<br>The right sleeve was obviously ripped or cut away.<br>It looks like it was originally a piece of a Main Force Patrol uniform."
	icon_state = "mfp_raider"
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/outfit/jacket/navyblue
	name = "security officer's jacket"
	desc = "This jacket is for those special occasions when a security officer isn't required to wear their armor."
	icon_state = "officerbluejacket"
	inhand_icon_state = "officerbluejacket"
	// body_parts_covered = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/outfit/jacket/banker
	name = "bankers tailcoat"
	desc = " A long black jacket, finely crafted black leather and smooth finishings make this an extremely fancy piece of rich-mans apparel."
	icon_state = "banker"
	inhand_icon_state = "banker"
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/outfit/jacket/jamrock
	name = "disco-ass blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"
	inhand_icon_state = "jamrock_blazer"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/outfit/jacket/blackformaljacket
	name = "black formal overcoat"
	desc = "A neat black overcoat that's only slightly weathered from a nuclear apocalypse."
	icon_state = "black_oversuit"
	inhand_icon_state = "banker"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/outfit/jacket/police
	name = "police officer's jacket"
	desc = "A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_officer"
	inhand_icon_state = "police_officer"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/outfit/jacket/police/lieutenant
	name = "police lieutenant's jacket"
	desc = " A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_lieutenant"
	inhand_icon_state = "police_lieutenant"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/outfit/jacket/police/chief
	name = "police chief's jacket"
	desc = "A simple dark navy jacket, worn by police."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_chief"
	inhand_icon_state = "police_chief"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/outfit/jacket/ncrcfjacket
	name = "simple denim jacket"
	desc = "A simple breezy denim jacket."
	icon_state = "ncrcfjacket"
	inhand_icon_state = "ncrcfjacket"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/outfit/jacket/denison_smock
	name = "denison smock"
	desc = "A brown leafy camo jacket."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	icon_state = "denison_smock"
	inhand_icon_state = "police_chief"


/obj/item/clothing/suit/armor/outfit/jacket/rdashjacket
	name = "Dashing rainbow Parka"
	desc = "A lovingly made parka , adorn with rainbow colors and a thunderbolt symbol on the back of the parka. If anything, this parka makes you oh..I dunno..20% cooler?"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "rainbowdash"
	inhand_icon_state = "rainbowdash"

/obj/item/clothing/suit/armor/outfit/jacket/rarityjacket
	name = "Pristine parka"
	desc = "A lovingly made parka, adorn with white and purple coloring. The back of the parka has the symbol of three diamonds and some faint traces of glitter. Wearing this makes you feel like the fashionista of the wasteland while also looking but the most glamorous."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "rarecoat"
	inhand_icon_state = "rarecoat"

/obj/item/clothing/suit/armor/outfit/jacket/flutterjacket
	name = "Cuddly and soft parka"
	desc = "A lovingly made parka, made with soft yellow, pink, and blue color palete in mind. This parka has a symbol of butterflies on the back and is very comfortable to wear. Wearing this is but the perfect occassion for someone who is shy but yet enduring. Go get em, tiger!"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "shycoat"
	inhand_icon_state = "shycoat"


/obj/item/clothing/suit/armor/outfit/jacket/ww1trench
	name = "Brown trench raider coat."
	desc = "A trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "britishtrench"
	inhand_icon_state = "britishtrench"

/obj/item/clothing/suit/armor/outfit/jacket/ww1trench/latewar
	name = "Anglo trench coat"
	desc = "A Anglo trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "britishtrenchlate"
	inhand_icon_state = "britishtrenchlate"

/obj/item/clothing/suit/armor/outfit/jacket/ww1trenchgerman
	name = "Grey trench raider coat."
	desc = "A trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "germtrench"
	inhand_icon_state = "germtrench"

/obj/item/clothing/suit/armor/outfit/jacket/ww1trenchfrench
	name = "Blue trench raider coat."
	desc = "A trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "frenchtrench"
	inhand_icon_state = "frenchtrench"

/obj/item/clothing/suit/armor/outfit/jacket/sovietpadded
	name = "Padded Soviet jacket"
	desc = "A padded and well made Soviet jacket. Useful for the winter, but doesn't offer much protection against bullets or really any form of punishment. Compliments any soldier belonging to the Motherland. A wise soldier once said 'As long as Mother Russia has enemies, I will answer her call...'."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "sovjacket"
	inhand_icon_state = "sovjacket"

/obj/item/clothing/suit/armor/outfit/flagcapes
	name = "base for the flag capes"
	desc = "Base stuff for the flag capes, no peekie ;3"
	icon_state = "poland"
	inhand_icon_state = "poland"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	armor = ARMOR_VALUE_LIGHT
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/outfit/flagcapes/poland
	name = "Armored Polish flag cape"
	desc = "A cape made to resemble the flag of Poland"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "poland"
	inhand_icon_state = "poland"

/obj/item/clothing/suit/armor/outfit/flagcapes/iceland
	name = "Armored Icelandic flag cape"
	desc = "A cape made to resemble the flag of Iceland"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "iceland"
	inhand_icon_state = "iceland"

/obj/item/clothing/suit/armor/outfit/flagcapes/norway
	name = "Armored Norwegian flag cape"
	desc = "A cape made to resemble the flag of Norway"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "norway"
	inhand_icon_state = "norway"

/obj/item/clothing/suit/armor/outfit/flagcapes/finland
	name = "Armored Finnish flag cape"
	desc = "A cape made to resemble the flag of Finland"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "finland"
	inhand_icon_state = "finland"

/obj/item/clothing/suit/armor/outfit/flagcapes/germanynato
	name = "Armored West German flag cape"
	desc = "A cape made to resemble the flag of NATO West Germany"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "germany"
	inhand_icon_state = "germany"

/obj/item/clothing/suit/armor/outfit/flagcapes/sweden
	name = "Armored Swedish flag cape"
	desc = "A cape made to resemble the flag of Sweden"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "sweden"
	inhand_icon_state = "sweden"

/obj/item/clothing/suit/armor/outfit/flagcapes/denmark
	name = "Armored Danish flag cape"
	desc = "A cape made to resemble the flag of Denmark"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "denmark"
	inhand_icon_state = "denmark"

/obj/item/clothing/suit/armor/outfit/flagcapes/france
	name = "Armored French flag cape"
	desc = "A cape made to resemble the flag of France."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "france"
	inhand_icon_state = "france"

/obj/item/clothing/suit/armor/outfit/flagcapes/tsaristrussia
	name = "Armored Tsarist flag cape"
	desc = "A cape made to resemble the flag of the Tsar."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "imperialrus"
	inhand_icon_state = "imperialrus"

/obj/item/clothing/suit/armor/outfit/flagcapes/ireland
	name = "Armored Irish flag cape"
	desc = "A cape made to resemble the flag of Ireland."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "ireland"
	inhand_icon_state = "ireland"

/obj/item/clothing/suit/armor/outfit/flagcapes/brazil
	name = "Armored Brazilian flag cape"
	desc = "A cape made to resemble the flag of Brazil"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "brazil"
	inhand_icon_state = "brazil"

/obj/item/clothing/suit/armor/outfit/flagcapes/italy
	name = "Armored Italian flag cape"
	desc = "A cape made to resemble the flag of Italy"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "italy"
	inhand_icon_state = "italy"

/obj/item/clothing/suit/armor/outfit/flagcapes/canada
	name = "Armored Canadian flag cape"
	desc = "A cape made to resemble the flag of Canada."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "canada"
	inhand_icon_state = "canada"

/obj/item/clothing/suit/armor/outfit/flagcapes/unitedkingdom
	name = "Armored british flag cape"
	desc = "A cape made to resemble the flag of the United Kingdom"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "uk"
	inhand_icon_state = "uk"

/obj/item/clothing/suit/armor/outfit/flagcapes/australia
	name = "Armored Australian flag cape"
	desc = "A cape made to resemble the flag of Australia"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "australia"
	inhand_icon_state = "australia"

/obj/item/clothing/suit/armor/outfit/flagcapes/newzealand
	name = "Armored New Zealander flag cape"
	desc = "A cape made to resemble the flag of New Zealand"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "newzealand"
	inhand_icon_state = "newzealand"

/obj/item/clothing/suit/armor/outfit/warriorcats
	name = "Armored Thunderous flag cape"
	desc = "A cape made to resemble some tribal clan symbol"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "thunder"
	inhand_icon_state = "thunder"

/obj/item/clothing/suit/armor/outfit/warriorcats/shadow
	name = "Armored Shadowed flag cape"
	desc = "A cape made to resemble some tribal clan symbol"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "shadow"
	inhand_icon_state = "shadow"

/obj/item/clothing/suit/armor/outfit/warriorcats/wind
	name = "Armored Windy flag cape"
	desc = "A cape made to resemble some tribal clan symbol"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "wind"
	inhand_icon_state = "wind"

/obj/item/clothing/suit/armor/outfit/warriorcats/river
	name = "Armored Rivulet flag cape"
	desc = "A cape made to resemble some tribal clan symbol"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "river"
	inhand_icon_state = "river"

/obj/item/clothing/suit/armor/outfit/warriorcats/customshadow
	name = "Custom Shadowclan greatcoat"
	desc = "A gifted greatcoat. Red in appearance, this greatcoat is a very old design of a ancient clan-like tribal full of cats! It is comfortable to wear and on the chest is a pin of the Shadowclan symbol. It comes with elbow length gloves and a ballistic vest alongside an armored shoulder cape. Adorning the front of the plate are two pages that are taken from 'The warrior's code', Page 1 and page 3. It seems recently it was adorned with such attachments."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "kriegshadowfanatic"
	inhand_icon_state = "kriegshadowfanatic"
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1)
// until togglesuits are made into normal suits, treat these as jackets

/obj/item/clothing/suit/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	// body_parts_covered = CHEST|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	togglename = "buttons"
	species_exception = list(/datum/species/golem)
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	body_parts_hidden = CHEST | ARMS
	toggled_hidden_parts = ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/toggle/labcoat/cmo
	name = "chief medical officer's labcoat"
	desc = "Bluer than the standard model."
	icon_state = "labcoat_cmo"
	inhand_icon_state = "labcoat_cmo"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/toggle/labcoat/mad
	name = "\proper The Mad's labcoat"
	desc = "It makes you look capable of konking someone on the noggin and shooting them into space."
	icon_state = "labgreen"
	inhand_icon_state = "labgreen"

/obj/item/clothing/suit/toggle/labcoat/genetics
	name = "geneticist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a blue stripe on the shoulder."
	icon_state = "labcoat_gen"

/obj/item/clothing/suit/toggle/labcoat/chemist
	name = "chemist labcoat"
	desc = " A suit that protects against minor chemical spills. Has an orange stripe on the shoulder."
	icon_state = "labcoat_chem"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/toggle/labcoat/virologist
	name = "virologist labcoat"
	desc = "A suit that protects against minor chemical spills. Offers slightly more protection against biohazards than the standard model. Has a green stripe on the shoulder."
	icon_state = "labcoat_vir"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/toggle/labcoat/science
	name = "scientist labcoat"
	desc = "A suit that protects against minor chemical spills. Has a purple stripe on the shoulder."
	icon_state = "labcoat_tox"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

// Departmental Jackets

/obj/item/clothing/suit/toggle/labcoat/depjacket/sci
	name = "science jacket"
	desc = "A comfortable jacket in science purple."
	icon_state = "sci_dep_jacket"
	inhand_icon_state = "sci_dep_jacket"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/toggle/labcoat/depjacket/med
	name = "medical jacket"
	desc = "A comfortable jacket in medical blue."
	icon_state = "med_dep_jacket"
	inhand_icon_state = "med_dep_jacket"

/obj/item/clothing/suit/toggle/labcoat/depjacket/sec
	name = "security jacket"
	desc = "A comfortable jacket in security red."
	icon_state = "sec_dep_jacket"
	inhand_icon_state = "sec_dep_jacket"
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/toggle/labcoat/depjacket/sup
	name = "supply jacket"
	desc = "A comfortable jacket in supply brown."
	icon_state = "supply_dep_jacket"
	inhand_icon_state = "supply_dep_jacket"

/obj/item/clothing/suit/toggle/labcoat/depjacket/sup/qm
	name = "quartermaster's jacket"
	desc = "A loose covering often warn by station quartermasters."
	icon_state = "qmjacket"
	inhand_icon_state = "qmjacket"

/obj/item/clothing/suit/toggle/labcoat/depjacket/eng
	name = "engineering jacket"
	desc = "A comfortable jacket in engineering yellow."
	icon_state = "engi_dep_jacket"
	inhand_icon_state = "engi_dep_jacket"

/obj/item/clothing/suit/toggle/labcoat/fieldscribe
	name = "fieldscribe suit"
	desc = "A heavy-duty coat and chestrig fitted with tons of pockets. Ballistic weave and ceramic inserts are included to substantially increase Field Scribe survival rates."
	icon_state = "fieldscribe"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/toggle/labcoat/scribecoat
	name = "fieldscribe coat"
	desc = "A heavy-duty coat and chestrig fitted with tons of pockets. Ballistic weave and ceramic inserts are included to substantially increase Field Scribe survival rates."
	icon_state = "scribecoat"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/toggle/labcoat/emergency
	name = "first responder jacket"
	desc = "A high-visibility jacket worn by medical first responders."
	icon_state = "fr_jacket"
	inhand_icon_state = "fr_jacket"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/toggle/labcoat/warriors
	name = "warriors jacket"
	desc = "A red leather jacket, with the word \"Warriors\" sewn above the white wings on the back."
	icon_state = "warriors"
	inhand_icon_state = "owl"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/toggle/labcoat/wanderer
	name = "wanderer jacket"
	desc = "A zipped-up hoodie made of tanned leather."
	icon_state = "wanderer"
	inhand_icon_state = "owl"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/toggle/labcoat/followers
	name = "clinic lab coat"
	desc = "A worn-down white labcoat with some wiring hanging from the right side.<br>Upon closer inspection, you can see an ancient bloodstains that could tell an entire story about thrilling adventures of a previous owner."
	icon_state = "followers"
	inhand_icon_state = "labcoat"

//these are jackets too
/obj/item/clothing/suit/hooded/parka/medical
	name = "armored medical parka"
	icon_state = "armormedical"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	hoodtype = /obj/item/clothing/head/hooded/parkahood/medical
	body_parts_hidden = CHEST | ARMS
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/parkahood/medical
	name = "armored medical parka hood"
	icon_state = "armorhoodmedical"
	desc = " A protective & concealing parka hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/parka/grey
	name = "grey armored parka"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	icon_state = "armorgrey"
	hoodtype = /obj/item/clothing/head/hooded/parkahood/grey
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/parkahood/grey
	name = "armored grey parka hood"
	desc = "A protective & concealing parka hood."
	icon_state = "armorhoodgrey"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/////////////////
//// COSTUME ////
/////////////////

/obj/item/clothing/suit/armor/outfit/costume/ghost
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	inhand_icon_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/armor/outfit/slavelabor
	name = "old leather strips"
	desc = "Worn leather strips, used as makeshift protection from chafing and sharp stones by labor slaves."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "legion_slaveleather"
	inhand_icon_state = "legion_slaveleather"
	body_parts_hidden = 0
	mutantrace_variation = STYLE_DIGITIGRADE

///////////
// LIGHT //
///////////

/* Stats
 * No slowdown, mobility key
 * 10% DR for general armor
 * 15-20% for specialist armor (most everything else is butt)
 * Assuming 25 damage from the average attack:
 * - goes from 4 hit crit to 5 at 25
 * - 5 hit crit to 6 at 20 dmg
 * - 4 hit crit to 5 at 30 for specialists maybe???
 *
 * Types:
 * Tribal
 * Duster
 * Raider
 * leather (special, ++melee , --bullet, --laser)
 * light ballistic vest (special, ++bullet , --melee, --laser, chest only)
 * metal breastplate (special, ++laser , +melee, --bullet, chest only)
 */

//// LIGHT ARMOR PARENT ////
/obj/item/clothing/suit/armor/light
	name = "light armor template"
	//icon = 'icons/fallout/clothing/armored_light.dmi'
	//mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 10
	equip_delay_other = 10
	max_integrity = 100
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS

////////////////////////
// LIGHT TRIBAL ARMOR //
////////////////////////
/obj/item/clothing/suit/armor/light/tribal
	name = "tribal armor"
	desc = "A set of armor made of gecko hides.<br>It's pretty good for makeshift armor."
	icon_state = "tribal"
	inhand_icon_state = "tribal"
//	flags_inv = HIDEJUMPSUIT
	//icon = 'icons/fallout/clothing/armored_light.dmi'
	//mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	cold_protection = CHEST|GROIN|ARMS|LEGS // worm
	heat_protection = CHEST|GROIN|ARMS|LEGS // chyll
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/armor/light/tribal/wastetribe
	name = "wasteland tribe armor"
	desc = "Soft armor made from layered dog hide strips glued together, with some metal bits here and there."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "tribal"
	inhand_icon_state = "tribal"
	body_parts_hidden = GROIN|ARMS|LEGS

/obj/item/clothing/suit/armor/light/tribal/cloak
	name = "light tribal cloak"
	desc = "A light cloak made from gecko skins and small metal plates at vital areas to give some protection, a favorite amongst scouts of the tribe."
	icon_state = "lightcloak"
	inhand_icon_state = "lightcloak"
	body_parts_hidden = CHEST|ARMS|LEGS


/obj/item/clothing/suit/armor/light/tribal/simple
	name = "simple tribal armor"
	desc = "Armor made of leather strips and a large, flat piece of turquoise. The wearer is displaying the Mountain River traditional garb."
	icon_state = "tribal_armor"
	inhand_icon_state = "tribal_armor"
	body_parts_hidden = CHEST|ARMS|LEGS

/obj/item/clothing/suit/armor/light/tribal/sorrows
	name = "Sorrows armour"
	desc = "A worn ballistic vest from Salt Lake, adorned with feathers and turqoise beads, with an ornamental pattern painted over the sides. Commonly worn by the members of the peaceful Sorrows tribe."
	icon_state = "sorrows_armour"
	inhand_icon_state = "sorrows_armour"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/light/tribal/westernwayfarer
	name = "Western Wayfarer salvaged armor"
	desc = "A set of scrap and banded metal armor forged by the Wayfarer tribe, due to it's lightweight and unrestrictive nature,  it's used by scouts and agile hunters. A torn cloak hangs around its neck, protecting the user from the harsh desert sands."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "western_wayfarer_armor"
	inhand_icon_state = "western_wayfarer_armor"

/obj/item/clothing/suit/armor/light/tribal/bone
	name = "Bone armor"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bone_dancer_armor_light"
	inhand_icon_state = "bone_dancer_armor_light"
	mutantrace_variation = STYLE_DIGITIGRADE
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/light/tribal/bone/cool
	name = "bone armor suit"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bonearmor_light"
	inhand_icon_state = "bonearmor_light"
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/light/tribal/rustwalkers
	name = "Rustwalkers light armor"
	desc = "A chestplate, pauldron and vambrace that bear a distinct resemblance to a coolant tank, engine valves and an exhaust. Commonly worn by members of the Rustwalkers tribe"
	icon_state = "rustwalkers_armour_light"
	inhand_icon_state = "rustwalkers_armour_light"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/tribal/whitelegs
	name = "White Legs light armour"
	desc = "A series of tan and khaki armour plates, held in place with a considerable amount of strapping. Commonly worn by members of the White Legs tribe."
	icon_state = "white_legs_armour_light"
	inhand_icon_state = "white_legs_armour_light"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/tribal/eighties
	name = "80s light armour"
	desc = "A plain, slightly cropped leather jacket with a black lining and neck brace, paired with a set of metal vambraces and a black belt of pouches. Commonly worn by the members of the 80s tribe."
	icon_state = "80s_armour_light"
	inhand_icon_state = "80s_armour_light"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/tribal/deadhorses
	name = "Dead Horses light armour"
	desc = "A simple leather bandolier and gecko hide chest covering, with an engraved metal pauldron and a pair of black leather straps. Commonly worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour_light"
	inhand_icon_state = "dead_horses_armour_light"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = 0

/obj/item/clothing/suit/armor/light/tribal/geckocloak
	name = "light tribal cloak"
	desc = "Light cloak armor, made of gecko skins and minor metal plating to protect against light weaponry, a favorite amongst scouts of the tribe."
	icon_state = "lightcloak"
	inhand_icon_state = "lightcloak"
	body_parts_hidden = ARMS
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/tribal/strips
	name = "light tribal armor"
	desc = "Light armor made of leather stips and a large, flat piece of turquoise. Armor commonplace among the local tribe."
	icon_state = "tribal_armor"
	inhand_icon_state = "tribal_armor"
	body_parts_hidden = CHEST
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/// to be refactored to work with the New Tier System (tm)
/obj/item/clothing/suit/hooded/cloak
	name = "cloak"
	desc = "A cloak, made out of cloak."
	icon_state = "clawsuitcloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	heat_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 10
	equip_delay_other = 10
	max_integrity = 100
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	body_parts_hidden = 0
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/hooded/cloak/Initialize()
	/// make sure the parents work first for this, child lists take priority
	. = ..()
	/// i hate my extended family
	allowed = GLOB.default_all_armor_slot_allowed

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "aethergiest cloak"
	desc = "A staunch, practical cloak made out of sinew and skin from the fearsome aethergiest."
	icon_state = "clawsuitcloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "aethergiest cloak hood"
	desc = "A protective & concealing hood."
	icon_state = "clawheadcloak"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	name = "tattered red cloak"
	desc = "An old ragged, tattered red cloak that is covered in burns and bullet holes."
	icon_state = "goliath_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	name = "tattered red cloak hood"
	desc = "A tattered hood, better than nothing in the waste."
	icon_state = "golhood"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/hooded/cloak/drake //SS13 item, obviously
	name = "drake armour"
	desc = "A suit of armour fashioned from the remains of an ash drake."
	icon_state = "dragon"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	desc = "The skull of a dragon."
	icon_state = "dragon"
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/cloak/hhunter
	name = "Razorclaw armour"
	desc = "A suit of armour fashioned out of the remains of a legendary aethergiest."
	icon_state = "rcarmour"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/hhunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	// body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/hhunter
	name = "Razorclaw helm"
	desc = "The skull of a legendary aethergiest."
	icon_state = "rchelmet"
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/cloak/shunter
	name = "quickclaw armour"
	desc = "A suit of armour fashioned out of the remains of a legendary aethergiest, this one has been crafted to remove a good portion of its protection to improve on speed and trekking."
	icon_state = "birdarmor"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/shunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	// body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/shunter
	name = "quickclaw hood"
	desc = "A hood made of aethergiest hides, light while also being comfortable to wear, designed for speed."
	icon_state = "birdhood"
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)
	body_parts_hidden = 0

/obj/item/clothing/suit/hooded/cloak/aethergiest
	name = "aethergiest cloak"
	icon_state = "aethergiest"
	desc = "Made from the sinew and skin of the fearsome aethergiest, this cloak will shield its wearer from harm."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/aethergiest
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/aethergiest
	name = "aethergiest cloak hood"
	icon_state = "hood_aethergiest"
	desc = "A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/cloak/razorclaw
	name = "razorclaw cloak"
	icon_state = "rcarmor"
	desc = "A suit of armour fashioned out of the remains of a legendary aethergiest."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/razorclaw
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	// body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/razorclaw
	name = "razorclaw helm"
	icon_state = "helmet_razorclaw"
	desc = "The skull of a legendary aethergiest."
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/cloak/desert
	name = "desert cloak"
	icon_state = "desertcloak"
	desc = "A practical cloak made out of animal hide."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/cloakhood/desert
	name = "desert cloak hood"
	icon_state = "desertcloak"
	desc = "A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/cloak/desert/raven_cloak
	name = "Raven cloak"
	desc = "A huge cloak made out of hundreds of knife-like black bird feathers. It glitters in the light, ranging from blue to dark green and purple."
	icon_state = "raven_cloak"
	inhand_icon_state = "raven_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert/raven_hood
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/cloakhood/desert/raven_hood
	name = "Raven cloak hood"
	desc = "A hood fashioned out of patchwork and feathers"
	icon_state = "raven_hood"
	inhand_icon_state = "raven_hood"

/obj/item/clothing/suit/hooded/outcast
	name = "patched heavy leather cloak"
	desc = "A robust cloak made from layered gecko skin patched with various bits of leather from dogs and other animals, able to absorb more force than one would expect from leather."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "cloak_outcast"
	inhand_icon_state = "cloak_outcast"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/outcast
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/outcast
	name = "patched leather hood"
	desc = "Thick layered leather, patched together."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hood_tribaloutcast"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	inhand_icon_state = "hood_tribaloutcast"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/hooded/outcast/tribal
	name = "patched heavy leather cloak"
	desc = "A robust cloak made from layered gecko skin patched with various bits of leather from dogs and other animals, able to absorb more force than one would expect from leather."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	icon_state = "cloak_outcast"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	inhand_icon_state = "cloak_outcast"
	strip_delay = 40
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/tribaloutcast
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/head/hooded/cloakhood/tribaloutcast
	name = "patched leather hood"
	desc = "Thick layered leather, patched together."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hood_tribaloutcast"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	inhand_icon_state = "hood_tribaloutcast"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

//////////////////////
// WARHAMMER LIGHT //
/////////////////////
// more sexy, even more protection.

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits
	name = "Ancient greatcoat"
	desc = "A trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "krieg"
	inhand_icon_state = "krieg"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/medical
	name = "Ancient Medical West german greatcoat"
	desc = "A trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "mkrieg"
	inhand_icon_state = "mkrieg"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/officer
	name = "Ancient dark greatcoat"
	desc = "A adorned trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "Kriegissar"
	inhand_icon_state = "Kriegissar"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/americanofficer
	name = "Ancient Officer's American greatcoat"
	desc = "A adorned trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "40kofficer"
	inhand_icon_state = "40kofficer"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/genericofficer
	name = "Ancient Officer's greatcoat"
	desc = "A adorned trench coat that is quite comfortable to wear."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "ancientofficer"
	inhand_icon_state = "ancientofficer"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/techpriesting
	name = "Cyber priest outfit."
	desc = "A trench coat that's all cyber themed!"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "cyberpriest"
	inhand_icon_state = "cyberpriest"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/cyberpriesting
	name = "Cyber-pyscho priest outfit."
	desc = "A trench coat that's all cyber themed! Comes with some helping hands."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "tecpriest"
	inhand_icon_state = "tecpriest"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/fanaticalpriest
	name = "Town crier outfit."
	desc = "A trench coat that screams 'listen to my words, hear me!'. Comes with some recipts wax stamped to it!"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "acolytecoat"
	inhand_icon_state = "acolytecoat"

/obj/item/clothing/suit/armor/light/outfit/jacket/warhammersuits/urmandoutfit
	name = "Ancient West German fanatic outfit."
	desc = "A trench coat that once belonged to a fanatical person. Who or what did they worship? Who knows. All one knows is, it's a good piece of clothing for those wanting to showcase their more hear-ye side of life!"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "fanatic"
	inhand_icon_state = "fanatic"

//////////////////
// LIGHT RAIDER //
//////////////////
// more style and pockets, less protection

/obj/item/clothing/suit/armor/light/raider
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 10
	equip_delay_other = 10
	max_integrity = 150
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/armor/light/raider/badlands
	name = "badlands raider armor"
	desc = "A leather top with a bandolier over it and a straps that cover the arms. Suited for warm climates, comes with storage space."
	icon_state = "badlands"
	inhand_icon_state = "badlands"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/raider/tribalraider
	name = "tribal raider wear"
	desc = "Very worn bits of clothing and armor in a style favored by many tribes."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "tribal_outcast"
	inhand_icon_state = "tribal_outcast"
	body_parts_hidden = ARMS | GROIN

/obj/item/clothing/suit/armor/light/raider/supafly
	name = "supa-fly raider armor"
	desc = "Fabulous mutant powers were revealed to me the day I held aloft my bumper sword and said...<br>BY THE POWER OF Cosmic-COLA, I AM RAIDER MAN!"
	icon_state = "supafly"
	inhand_icon_state = "supafly"

/obj/item/clothing/suit/armor/light/raider/sadist
	name = "sadist raider armor"
	desc = "A bunch of metal chaps adorned with severed hands at the waist with a leather plate worn on the left shoulder. Very intimidating."
	icon_state = "sadist"
	inhand_icon_state = "sadist"

/obj/item/clothing/suit/armor/light/raider/painspike
	name = "painspike raider armor"
	desc = "A particularly unhuggable armor, even by raider standards. Extremely spiky."
	icon_state = "painspike"
	inhand_icon_state = "painspike"


/////////////////////
// DUSTERS & COATS //
/////////////////////

/obj/item/clothing/suit/armor/light/duster
	name = "duster"
	desc = "A long brown leather overcoat with discrete protective reinforcements sewn into the lining."
	icon_state = "duster"
	inhand_icon_state = "duster"
	permeability_coefficient = 0.5
	heat_protection = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 20
	equip_delay_other = 20
	max_integrity = 150
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)
	// Nothing extra fancy for their storage, but they can carry an extra 2 normal-sized guns in their pockets
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/harpercoat
	name = "outlaw coat"
	desc = "An ugly looking combat duster"
	icon_state = "harperduster"
	inhand_icon_state = "combatduster"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/lonesome
	name = "lonesome duster"
	desc = "A blue leather coat with the number 21 on the back.<br><i>If war doesn't change, men must change, and so must their symbols.</i><br><i>Even if there is nothing at all, know what you follow.</i>"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "duster_courier"
	inhand_icon_state = "duster_courier"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/autumn //Based of Colonel Autumn's uniform.
	name = "tan trenchcoat"
	desc = "A heavy-duty tan trenchcoat typically worn by Pre-Fall generals."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "duster_autumn"
	inhand_icon_state = "duster_autumn"

/obj/item/clothing/suit/armor/light/duster/vet
	name = "merc veteran coat"
	desc = "A blue leather coat with its sleeves cut off, adorned with war medals.<br>This type of outfit is common for professional mercenaries and bounty hunters."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "duster_vet"
	inhand_icon_state = "duster_vet"
	body_parts_hidden = CHEST

/obj/item/clothing/suit/armor/light/duster/brahmin
	name = "brahmin leather duster"
	desc = "A duster made from tanned brahmin hide. It has a thick waxy surface from the processing, making it surprisingly laser resistant."
	icon_state = "duster"
	inhand_icon_state = "duster"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/brahmin/biker
	name = "sleeveless brahmin leather duster"
	desc = "A duster made from tanned brahmin hide. Seems to be missing its arms. Seems like it was on purpose.."
	icon_state = "brahmin_leather_duster_sleeveless"
	inhand_icon_state = "duster"
	body_parts_hidden = 0

/* 	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "duster_brahmin"
	inhand_icon_state = "duster_brahmin" */

/obj/item/clothing/suit/armor/light/duster/desperado
	name = "desperado's duster"
	desc = "A dyed brahmin hide duster, with a thick waxy surface, making it less vulnerable to lasers and energy based weapons."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "duster_lawman"
	inhand_icon_state = "duster_lawman"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/town
	name = "town trenchcoat"
	desc = "A non-descript black trenchcoat."
	icon_state = "towntrench"
	inhand_icon_state = "hostrench"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/greatcoatgrey
	name = "Grey greatcoat"
	desc = "A greyed out greatcoat. This coat also comes with a furred interior for the toughest of winters"
	icon_state = "gerparka"
	inhand_icon_state = "gerparka"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/duster/vlongcoat
	name = "Black winter greatcoat"
	desc = "A black greatcoat that resembles the coats used by Kuban cossacks. A greatcoat, fitting for your cold weather needs."
	icon_state = "bcossack"
	inhand_icon_state = "bcossack"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/duster/vlongcoat/blue
	name = "Blue winter greatcoat"
	desc = "A blue greatcoat that resembles the coats used by Don cossacks. A greatcoat, fitting for your cold weather needs."
	icon_state = "blcossack"
	inhand_icon_state = "blcossack"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/duster/town/leather
	name = "leather trenchcoat"
	desc = "A snazzy black trenchcoat, fit for a dragon."
	icon_state = "leathercoat"
	inhand_icon_state = "hostrench"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/town/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof)."

/obj/item/clothing/suit/armor/light/duster/rustedcowboy
	name = "rusted cowboy outfit"
	desc = "A weather treated leather cowboy outfit. Yeehaw Pard'!"
	icon_state = "rusted_cowboy"
	inhand_icon_state = "rusted_cowboy"
	flags_inv = HIDEJUMPSUIT
	permeability_coefficient = 0.5

/obj/item/clothing/suit/armor/light/duster/peacecoat
	name = "tattered peace coat"
	desc = "An old overcoat with a crude peace symbol painted on the back in white with white spraypaint. Whatever symbols the coat originally came with have long since been worn away by time."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	icon_state = "ghostechoe"
	inhand_icon_state = "ghostechoe"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/vaquero
	name = "vaquero suit"
	desc = "An ornate suit popularized by traders from the south, using tiny metal studs and plenty of silver thread wich serves as decoration and also reflects energy very well, useful when facing the desert sun or a rogue Eyebot."
	icon_state = "vaquero"
	inhand_icon_state = "vaquero"
	flags_inv = HIDEJUMPSUIT
	heat_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	siemens_coefficient = 1.1
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/battlecoat //Maxson's battlecoat from Fallout 4
	name = "battlecoat"
	desc = "A heavy padded leather coat, worn by Pre-Fall bomber pilots in the past and post-War zeppelin pilots in the future."
	icon_state = "maxson_battlecoat"
	inhand_icon_state = "maxson_battlecoat"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/duster/battlecoat/vault
	name = "command coat"
	desc = "A heavy Pre-Fall bomber coat, dyed blue with the number '113' embroidered on the back. Most often worn by leaders, such as the Overseer."
	icon_state = "maxson_battlecoat"
	inhand_icon_state = "maxson_battlecoat"

/obj/item/clothing/suit/armor/light/duster/battlecoat/vault/overseer
	name = "Overseer's battlecoat"
	desc = "A heavy Pre-Fall bomber coat, dyed blue with the insignia of the Vault-Tec embroidered on the back. This one is worn by the Coalition's Overseer."
	icon_state = "maxson_battlecoat"
	inhand_icon_state = "maxson_battlecoat"

/obj/item/clothing/suit/armor/light/duster/battlecoat/vault/marshal
	name = "Marhsal's battlecoat"
	desc = "A heavy Pre-Fall bomber coat, dyed blue with the insignia of the Vault-Tec City Coalition embroidered on the back. This one is worn by the Marshals of the Coalition."
	icon_state = "maxson_battlecoat"
	inhand_icon_state = "maxson_battlecoat"

/obj/item/clothing/suit/armor/light/duster/herbertranger //Armor wise, it's reskinned raider armor.
	name = "weathered desert ranger armor"
	desc = "A set of pre-unification desert ranger armor, made using parts of what was once USMC riot armor. It looks as if it has been worn for decades; the coat has become discoloured from years under the Mojave sun and has multiple tears and bullet holes in its leather. The armor plating itself seems to be in relatively good shape, though it could do with some maintenance."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	icon_state = "usmc_riot_gear"
	inhand_icon_state = "usmc_riot_gear"
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/armor/light/duster/marlowsuit //Raider armour reskin.
	name = "Marlow gang overcoat"
	desc = "A heavy raw buckskin overcoat littered with aged bullet holes and frays from regular wear-and-tear."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	icon_state = "marlowsuit"
	inhand_icon_state = "marlowsuit"
	strip_delay = 40
	body_parts_hidden = ARMS

/obj/item/clothing/suit/armor/light/duster/marlowsuit/ikesuit
	name = "gunfighter's overcoat"
	desc = "A thick double-breasted red leather overcoat worn through with scattered tears and bullet holes."
	icon_state = "ikesuit"
	inhand_icon_state = "ikesuit"

/obj/item/clothing/suit/armor/light/duster/marlowsuit/masonsuit
	name = "vagabond's vest"
	desc = "A padded thick red leather vest, coated in stitched pockets and other mends."
	icon_state = "masonsuit"
	inhand_icon_state = "masonsuit"
	body_parts_hidden = 0

/obj/item/clothing/suit/armor/light/duster/rustedcowboy
	name = "rusted cowboy outfit"
	desc = " A weather treated leather cowboy outfit.  Yeehaw Pard'!"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "rusted_cowboy"
	inhand_icon_state = "rusted_cowboy"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/duster/tan_robe
	name = "tan robe"
	desc = "Only a monk would find this robe nice and comfortable."
	icon_state = "robe_liz"
	inhand_icon_state = "brownjsuit"

/obj/item/clothing/suit/armor/light/duster/town
	name = "town trenchcoat"
	desc = "A non-descript black trenchcoat."
	icon_state = "towntrench"
	inhand_icon_state = "hostrench"

/obj/item/clothing/suit/armor/light/duster/robe_hubologist
	name = "hubologist robe"
	desc = "A black robe worn by Adepts of Hubology Studies.<br>Beware - the spirits of the dead are all around us!"
	icon_state = "hubologist"
	inhand_icon_state = "wcoat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/armor/light/duster/goner
	name = "dev-patched dull trenchcoat"
	desc = "A non-existent dull trenchcoat."
	icon = 'modular_sunset/icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'modular_sunset/icons/mob/clothing/suit.dmi'
	anthro_mob_worn_overlay = 'modular_sunset/icons/mob/clothing/suit_digi.dmi'
	icon_state = "goner_suit"
	inhand_icon_state = "ro_suit"
	// body_parts_covered = CHEST|GROIN|LEGS|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE

/* /obj/item/clothing/suit/armor/light/duster/goner/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate) */

/obj/item/clothing/suit/armor/light/duster/goner/red
	name = "red-patched olive trenchcoat"
	desc = "A rather crude looking, olive trenchcoat with red linings and arm patches.<br>Guess war can be boring too."
	icon_state = "goner_suit_r"

/obj/item/clothing/suit/armor/light/duster/goner/green
	name = "green-patched olive trenchcoat"
	desc = "A rather crude looking, olive trenchcoat with green linings and arm patches.<br>Guess war can be boring too."
	icon_state = "goner_suit_g"

/obj/item/clothing/suit/armor/light/duster/goner/blue
	name = "blue-patched olive trenchcoat"
	desc = "A rather crude looking, olive trenchcoat with blue linings and arm patches.<br>Guess war can be boring too."
	icon_state = "goner_suit_b"

/obj/item/clothing/suit/armor/light/duster/goner/yellow
	name = "yellow-patched olive trenchcoat"
	desc = "A rather crude looking, olive trenchcoat with yellow linings and arm patches.<br>Guess war can be boring too."
	icon_state = "goner_suit_y"

/obj/item/clothing/suit/armor/light/duster/goner/alt
	name = "dev-patched brown trenchcoat"
	desc = "A non-existent ugly trenchcoat."
	icon_state = "goner_suitb"
	inhand_icon_state = "duster"

/obj/item/clothing/suit/armor/light/duster/goner/alt/red
	name = "red-patched brown trenchcoat"
	desc = "A rather crude looking, brown trenchcoat with red linings and arm patches.<br>Guess war can be ugly too."
	icon_state = "goner_suitb_r"

/obj/item/clothing/suit/armor/light/duster/goner/alt/green
	name = "green-patched brown trenchcoat"
	desc = "A rather crude looking, brown trenchcoat with green linings and arm patches.<br>Guess war can be ugly too."
	icon_state = "goner_suitb_g"

/obj/item/clothing/suit/armor/light/duster/goner/alt/blue
	name = "blue-patched brown trenchcoat"
	desc = "A rather crude looking, brown trenchcoat with blue linings and arm patches.<br>Guess war can be ugly too."
	icon_state = "goner_suitb_b"

/obj/item/clothing/suit/armor/light/duster/goner/alt/yellow
	name = "yellow-patched brown trenchcoat"
	desc = "A rather crude looking, brown trenchcoat with yellow linings and arm patches.<br>Guess war can be ugly too."
	icon_state = "goner_suitb_y"

/obj/item/clothing/suit/armor/light/duster/russian_coat
	name = "russian battle coat"
	desc = "Used in extremly cold fronts, made out of real bears."
	icon_state = "rus_coat"
	inhand_icon_state = "rus_coat"
	clothing_flags = THICKMATERIAL
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT

/obj/item/clothing/suit/armor/light/duster/bos/scribe
	name = "Brotherhood Scribe's robe"
	desc = "A red cloth robe worn by the Brotherhood of Steel Scribes."
	icon_state = "scribe"
	inhand_icon_state = "scribe"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/bos/scribe/headscribe
	name = "brotherhood head scribe robe"
	desc = " A red cloth robe with gold trimmings, worn eclusively by the Head Scribe of a chapter."
	icon_state = "headscribe"
	inhand_icon_state = "headscribe"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/bos/scribe/seniorscribe
	name = "Brotherhood Senior Scribe's robe"
	desc = "A red cloth robe with silver gildings worn by the Brotherhood of Steel Senior Scribes."
	icon_state = "seniorscribe"
	inhand_icon_state = "seniorscribe"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/bos/scribe/elder
	name = "Brotherhood Elder's robe"
	desc = "A blue cloth robe with some scarlet red parts, traditionally worn by the Brotherhood of Steel Elder."
	icon_state = "elder"
	inhand_icon_state = "elder"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/bos/outcast
	name = "outcast's breastplate"
	desc = "A generic light piece of armor for the Southern Brotherhood Outcasts. In their hasty retreat, there was little time to delegate supplies; and so, a frock of kevlar, polypropylene, and alloy was woven. Obviously, does not protect your arms or legs- but it does its job fine, otherwise."
	icon_state = "brotherhood_armor_light"
	inhand_icon_state = "brotherhood_armor_light"
	body_parts_covered = CHEST|GROIN
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/town
	name = "town trenchcoat"
	desc = "A non-descript black trenchcoat."
	icon_state = "towntrench"
	inhand_icon_state = "hostrench"

/obj/item/clothing/suit/armor/light/duster/bomberjacket
	name = "armored bomber jacket"
	desc = "It looks like someone dragged this out of a muddy lake. This one has metal plates attached..."
	icon_state = "bomberalt"
	inhand_icon_state = "bomberalt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/duster/breastplate/khan
	name = "Leather battle coat" //NO PIT THIS GAME UNIVERSE AND THAT GAME UNIVERSE HAVE NOTHING TO DO WITH EACH OTHER!!! (Sorry but I'm not keeping the original name of a petfaction) - Blue
	desc = "Heavy leather coat lined with a patchwork of metal plates on the inside. The plates lining it appear to be just the right metal quality to deflect most physical blunt trauma as well as laser weaponry slightly, but terrible at defending against bullets."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_heavy"
	inhand_icon_state = "khan_heavy"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T3, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/armor/light/duster/armoredformalcoat
	name = "armored formal overcoat"
	desc = "A neat black overcoat that's only slightly weathered from a nuclear apocalypse. This one has armor plating..."
	icon_state = "black_oversuit"
	inhand_icon_state = "banker"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/kit/dustersmog
	name = "winterized riot coat"
	desc = "This coat was originally intended to be a riot jacket and armour meant for cold climates, now it's some sort of heirloom, the fur of some animal sewn inside the coat and the armour replaced with some fine leather, it'd probably stop a bullet or two.. maybe."
	icon_state = "duster_recon_smog"
	inhand_icon_state = "duster_recon_smog"
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'

///////////////////
// LEATHER ARMOR //
///////////////////

/obj/item/clothing/suit/armor/light/leather
	name = "leather armor"
	desc = "Before the war motorcycle-football was one of the largest specator sports in America. This armor copies the style of armor used by the players,	using leather boiled in corn oil to make hard sheets to emulate the light weight and toughness of the original polymer armor."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "leather_armor"
	inhand_icon_state = "leather_armor"
	permeability_coefficient = 0.9
	heat_protection = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|ARMS|LEGS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 20
	equip_delay_other = 20
	max_integrity = 150
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_FIRE_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T2)
	body_parts_hidden = ARMS | CHEST

// Recipe the above + 2 gecko hides
/obj/item/clothing/suit/armor/light/leather/leathermk2
	name = "leather armor mk II"
	desc = "Armor in the motorcycle-football style, either with intact original polymer plating, or reinforced with gecko hide."
	icon_state = "leather_armor_mk2"
	inhand_icon_state = "leather_armor_mk2"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_FIRE_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T3)

/obj/item/clothing/suit/armor/light/leather/leathersuit
	name = "leather suit"
	desc = "Comfortable suit of tanned leather leaving one arm mostly bare. Keeps you warm and cozy."
	icon_state = "leather_suit"
	inhand_icon_state = "leather_suit"
	flags_inv = HIDEJUMPSUIT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_DT_T1)
	cold_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	siemens_coefficient = 0.9
	body_parts_hidden = ARMS | CHEST | GROIN | LEGS

/obj/item/clothing/suit/armor/light/leather/ninja
	name = "ninja suit"
	desc = "A lightly armored, padded suit designed specifically for thoses with stealth in mind."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	icon_state = "s-ninja"
	inhand_icon_state = "s-ninja"
	flags_inv = HIDEJUMPSUIT
	body_parts_hidden = ARMS | CHEST | GROIN | LEGS

/obj/item/clothing/suit/armor/light/leather/leather_jacket
	name = "bouncer jacket"
	icon_state = "leather_jacket_fighter"
	inhand_icon_state = "leather_jacket_fighter"
	desc = "A very stylish Pre-Fall black, heavy leather jacket. Not always a good choice to wear this the scorching sun of the desert, and one of the arms has been torn off"
	body_parts_hidden = ARMS | CHEST

/obj/item/clothing/suit/armor/light/leather/leather_jacketmk2
	name = "thick leather jacket"
	desc = "This heavily padded leather jacket is unusual in that it has two sleeves. You'll definitely make a fashion statement whenever, and wherever, you rumble."
	icon_state = "leather_jacket_thick"
	inhand_icon_state = "leather_jacket_thick"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)
	body_parts_hidden = ARMS | CHEST | LEGS

// Recipe : Thick Leather Jacket + Deathclaw Skin
/obj/item/clothing/suit/armor/light/leather/leathercoat
	name = "thick leather coat"
	desc = "Reinforced leather jacket with a overcoat. Well insulated, creaks a lot while moving."
	icon_state = "leather_coat_fighter"
	inhand_icon_state = "leather_coat_fighter"
	siemens_coefficient = 0.8
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_FIRE_T2, ARMOR_MODIFIER_UP_DT_T3)
	body_parts_hidden = ARMS | CHEST

/obj/item/clothing/suit/armor/light/leather/tanvest
	name = "tanned vest"
	icon_state = "tanleather"
	inhand_icon_state = "tanleather"
	desc = "Layers of leather glued together to make a stiff vest, crude but gives some protection against wild beasts and knife stabs to the liver."
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_DOWN_DT_T1)
	body_parts_hidden = 0

/obj/item/clothing/suit/armor/light/leather/cowboyvest
	name = "cowboy vest"
	icon_state = "cowboybvest"
	inhand_icon_state = "cowboybvest"
	desc = "Stylish and has discrete lead plates inserted, just in case someone brings a laser to a fistfight."
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_DT_T1, ARMOR_MODIFIER_UP_LASER_T1)

/obj/item/clothing/suit/armor/light/leather/durathread
	name = "makeshift vest"
	desc = "A makeshift vest made of heat-resistant fiber."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = null
	icon_state = "durathread"
	inhand_icon_state = "durathread"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/leather/rig
	name = "chest gear harness"
	desc = "A handmade tactical rig. The actual rig is made of a black, fiberous cloth, being attached to a dusty desert-colored belt with enough room for four small items."
	icon_state = "r_gear_rig"
	inhand_icon_state = "r_gear_rig"
	body_parts_hidden = 0
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_DT_T1)

/obj/item/clothing/suit/armor/light/leather/scrap
	name = "slim scrap armor"
	desc = "A series of leather straps criss-crossing the body paired with stragetically placed leather and scrap plates. It looks like it'd provide okay protection against lighter strikes."
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_FIRE_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T1)
	icon_state = "slimscrap"
	inhand_icon_state = "slimscrap"

/obj/item/clothing/suit/armor/light/leather/scrapalt
	name = "scrap armor"
	desc = "A series of leather straps criss-crossing the body paired with liberally placed leather and scrap plates. It looks like it'd stop small bullets and bludgeons, at least."
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_FIRE_T1, ARMOR_MODIFIER_DOWN_LASER_T1)
	icon_state = "scrap"
	inhand_icon_state = "scrap"

/obj/item/clothing/suit/armor/light/leather/scrapheavy // not actually heavy armor
	name = "heavy scrap armor"
	desc = "A liberal amount of scrap and leather tied together to cover the body. Not actually all that heavy; lasers will burn right through it, but it otherwise offers decent all-around protection."
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	stiffness = MEDIUM_STIFFNESS
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_FIRE_T1, ARMOR_MODIFIER_DOWN_LASER_T1)
	icon_state = "scrapheavy"
	inhand_icon_state = "scrapheavy"

/obj/item/clothing/suit/armor/light/leather/lightscoutarmor 
	name = "light scout armor"
	desc = "A makeshift set of pauldrons made of leather and scrap metal. It offers minimal protection, but is pretty light."
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_FIRE_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T1)
	icon_state = "lightscout"
	inhand_icon_state = "lightscout"

//-->Taur armored saddles
//the main gimmick about taur saddles is that obviously only taurs can equip it
//wearing a taur saddle allows for the rider to have both of his hands free
//-->can the carbon equip this? Afterall they are equippable only if they have a lower half.
/obj/item/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	. = ..()
	if(iscarbon(equipper))
		var/mob/living/carbon/C = equipper
		if((istype(src, /obj/item/clothing/suit/armor/taursaddle/)) && (C.dna.features["taur"] == "None"))
			to_chat(usr, span_danger("You're missing an extra pair of legs or a lower half to wear this! (not a taur)"))
			return FALSE
//<--

//The actual saddles
/obj/item/clothing/suit/armor/taursaddle
	name = "taur saddle"
	desc = "A simple leather saddle made out of leather to allow a much more comfortable ride and probably some better dexterity for the knight!"
	icon = 'icons/fallout/clothing/taursaddles_inhand.dmi'
	icon_state = "taursaddle"
	inhand_icon_state = "taursaddle"
	mutantrace_variation = STYLE_ALL_TAURIC
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/saddlebag
////////////////////////////////////////////////////////////////

/obj/item/clothing/suit/armor/taursaddle/light
	name = "light armored taur saddle"
	desc = "A simple leather saddle made out of leather to allow a much more comfortable ride and probably some better dexterity for the knight!"
	icon = 'icons/fallout/clothing/taursaddles_inhand.dmi'
	icon_state = "taursaddle_light"
	inhand_icon_state = "taursaddle_light"
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 10
	equip_delay_other = 10
	max_integrity = 100
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
////////////////////////////////////////////////////////////////

/obj/item/clothing/suit/armor/taursaddle/medium
	name = "medium armored taur saddle"
	desc = "A simple leather saddle made out of leather to allow a much more comfortable ride and probably some better dexterity for the knight!"
	icon = 'icons/fallout/clothing/taursaddles_inhand.dmi'
	icon_state = "taursaddle_medium"
	inhand_icon_state = "taursaddle_medium"
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 30
	equip_delay_other = 50
	max_integrity = 200
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	stiffness = MEDIUM_STIFFNESS
////////////////////////////////////////////////////////////////

/obj/item/clothing/suit/armor/taursaddle/heavy
	name = "heavy armored taur saddle"
	desc = "A simple leather saddle made out of leather to allow a much more comfortable ride and probably some better dexterity for the knight!"
	icon = 'icons/fallout/clothing/taursaddles_inhand.dmi'
	icon_state = "taursaddle_heavy"
	inhand_icon_state = "taursaddle_heavy"
	strip_delay = 50
	equip_delay_other = 50
	max_integrity = 300
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_HEAVY
	armor_tier_desc = ARMOR_CLOTHING_HEAVY
	stiffness = HEAVY_STIFFNESS

//<--End of Taur Saddles

////////////////
// ARMOR KITS //
////////////////

/obj/item/clothing/suit/armor/light/kit
	name = "armor kit"
	desc = "Separate armor parts you can wear over your clothing, giving basic protection against bullets entering some of your organs. Very well ventilated."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "armorkit"
	inhand_icon_state = "armorkit"
	heat_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	siemens_coefficient = 1.1
	body_parts_hidden = 0
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/kit/punk
	name = "punk armor kit"
	desc = "A couple of armor parts that can be worn over the clothing for moderate protection against the dangers of wasteland.<br>Do you feel lucky now? Well, do ya, punk?"
	icon_state = "armorkit_punk"
	inhand_icon_state = "armorkit_punk"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/kit/shoulder
	name = "armor kit"
	desc = "A single big metal shoulderplate for the right side, keeping it turned towards the enemy is advisable."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "armorkit_shoulder"
	inhand_icon_state = "armorkit_shoulder"

/obj/item/clothing/suit/armor/light/kit/plates
	name = "light armor plates"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	desc = "Well-made metal plates covering your vital organs."
	icon_state = "light_plates"
	body_parts_hidden = CHEST

/* /obj/item/clothing/suit/armor/light/kit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate) */

/obj/item/clothing/suit/armor/light/mutantkit
	name = "oversized armor kit"
	desc = "Bits of armor fitted to a giant harness. Clearly not made for use by humans."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "mutie_armorkit"
	inhand_icon_state = "mutie_armorkit"
	heat_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	siemens_coefficient = 1.1

///////////////////////////////////////////////////////////////////
//Fenis's Snarmor Compendium of Snaggletoothed Snarting Snarmors//
/////////////////////////////////////////////////////////////////

/obj/item/clothing/suit/armor/light/kit/punk/bronzechestplate
	name = "old bronze chestplate"
	desc = "A bronze chestplate caste after the fall of the old world, it's in okay shape, if a little banged up."
	icon_state = "old_bronze_chestplate"
	inhand_icon_state = "old_bronze_chestplate"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/leatherarmor
	name = "leather armor"
	desc = "A rough leather chestpiece, hardened to help keep the owies out."
	icon_state = "leather_armor"
	inhand_icon_state = "leather_armor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/armor/light/kit/punk/ironchestplate
	name = "iron chestplate"
	desc = "An iron breastplate made after the fall of the old world, its only a little rusted on the inside."
	icon_state = "iron_chestplate"
	inhand_icon_state = "iron_chestplate"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/scaledarmor
	name = "scaled armor"
	desc = "Overlapping scaled armor made by a smith after the fall of the old world."
	icon_state = "scaled_armor"
	inhand_icon_state = "scaled_armor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/roughchainmail
	name = "rough chainmail"
	desc = "A roughly made, but workable, set of chainmail"
	icon_state = "early_chainmail"
	inhand_icon_state = "early_chainmail"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/fullchainmail
	name = "chainmail shirt"
	desc = "A solidly made bit of chainmail in the shape of a shirt, protects the nips but may chafe."
	icon_state = "chainmail"
	inhand_icon_state = "chainmail"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/crusaderweak
	name = "crusader chainmail with tabard"
	desc = "A full set of chainmail that covers the torso and arms. This one has a tabard with a red cross!"
	icon_state = "knight_templar"
	inhand_icon_state = "knight_templar"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/ironchestplatered
	name = "iron chestplate with red cape"
	desc = "An iron breastplate made after the fall of the old world, includes a dashing red cape."
	icon_state = "iron_chestplater"
	inhand_icon_state = "iron_chestplater"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/ironchestplateblue
	name = "iron chestplate with blue cape"
	desc = "An iron breastplate made after the fall of the old world, includes a cool blue cape."
	icon_state = "iron_chestplateb"
	inhand_icon_state = "iron_chestplateb"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/oldscalemail
	name = "old scale armor"
	desc = "A set of dull scale armor, overlaps just right in all the wrong places."
	icon_state = "old_scale_armor"
	inhand_icon_state = "old_scale_armor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/scalemail
	name = "scale armor"
	desc = "A decent set of scale armor made in the last few years by a smith in the wastes."
	icon_state = "scale_armor"
	inhand_icon_state = "scale_armor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/varangianarmor
	name = "Lamellar Armor"
	desc = "A decent set of lamellar armor, no need to be byzantine about it."
	icon_state = "varangian_lamellar"
	inhand_icon_state = "varangian_lamellar"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/egyptianlam
	name = "Dusty Lamellar Armor"
	desc = "You're in denial if you like this armor, but that's okay."
	icon_state = "egyptian_lamellar"
	inhand_icon_state = "egyptian_lamellar"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/chitinbreastplate
	name = "Fire Ant Breastplate"
	desc = "A tough armor made out of the hide of gigantic fireants, pretty hot to be honest."
	icon_state = "chitin_chestplate"
	inhand_icon_state = "chitin_chestplate"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/steppeleatherarmor
	name = "Full Leather Armor"
	desc = "Creaking leather armor with shoulder pads and thigh protection. Mongol Tested, Wasteland approved."
	icon_state = "steppe_leather_armor"
	inhand_icon_state = "steppe_leather_armor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/armor/light/kit/punk/chineselam
	name = "Lamellar Armor with Red Tunic"
	desc = "Your ancestors protect you more thant his armor likely does, but at least it looks nice."
	icon_state = "chinese_lamellar"
	inhand_icon_state = "chinese_lamellar"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/chinesebreastplate
	name = "Steel Armor with Red Tunic"
	desc = "This steel breastplate and red shirt are quite stylish, if you like being imortalized in a clay statue."
	icon_state = "imperial_chinese"
	inhand_icon_state = "imperial_chinese"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/woodenbreastplate
	name = "Wooden Breastplate"
	desc = "This is exactly what it would feel like to be a monkey wearing a coconut for armor."
	icon_state = "wooden_chestarmor"
	inhand_icon_state = "wooden_chestarmor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/armor/light/kit/punk/steelbreastplate
	name = "Unpainted Steel Breastplate"
	desc = "A relatively recently made breastplate, put together by god knows who in this swamp."
	icon_state = "imperial_breastplate"
	inhand_icon_state = "imperial_breastplate"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/bronzebreastplate
	name = "Bronze Breastplate"
	desc = "Abs not included."
	icon_state = "bronze_chestplate"
	inhand_icon_state = "bronze_chestplate"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samurai1
	name = "Yoroi - Reddish Brown"
	desc = "A samurais true armor is their ability to not be cringe."
	icon_state = "samurai1"
	inhand_icon_state = "samurai1"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samurai2
	name = "Yoroi - Blue"
	desc = "A samurais true armor is their ability to not be cringe."
	icon_state = "samurai2"
	inhand_icon_state = "samurai2"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samurai3
	name = "Yoroi - Brown"
	desc = "A samurais true armor is their ability to not be cringe."
	icon_state = "samurai3"
	inhand_icon_state = "samurai3"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samurai4
	name = "Yoroi - Black"
	desc = "A samurais true armor is their ability to not be cringe."
	icon_state = "samurai4"
	inhand_icon_state = "samurai4"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)


/obj/item/clothing/suit/armor/light/kit/punk/samurai5
	name = "Yoroi - Black"
	desc = "A samurais true armor is their ability to not be cringe. This one should be good for painting."
	icon_state = "samurai5"
	inhand_icon_state = "samurai5"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samuraipoor1
	name = "Yoroi Lightened - Reddish Brown"
	desc = "You're one broke ass samurai, pal."
	icon_state = "samuraipoor1"
	inhand_icon_state = "samuraipoor1"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samuraipoor2
	name = "Yoroi Lightened - Blue"
	desc = "You're one broke ass samurai, pal."
	icon_state = "samuraipoor2"
	inhand_icon_state = "samuraipoor2"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)


/obj/item/clothing/suit/armor/light/kit/punk/samuraipoor3
	name = "Yoroi Lightened - Brown"
	desc = "You're one broke ass samurai, pal."
	icon_state = "samuraipoor3"
	inhand_icon_state = "samuraipoor3"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samuraipoor4
	name = "Yoroi Lightened - Black"
	desc = "You're one broke ass samurai, pal."
	icon_state = "samuraipoor4"
	inhand_icon_state = "samuraipoor4"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/samuraiwar1
	name = "Padded Yoroi - Red"
	desc = "A slightly higher quality samurai armor that still won't stop anything more than the occasion melee attack."
	icon_state = "samurai_warrior1"
	inhand_icon_state = "samurai_warrior1"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/samuraiwar2
	name = "Padded Yoroi - Blue"
	desc = "A slightly higher quality samurai armor that still won't stop anything more than the occasion melee attack."
	icon_state = "samurai_warrior2"
	inhand_icon_state = "samurai_warrior2"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/samuraiwar3
	name = "Padded Yoroi - Brown"
	desc = "A slightly higher quality samurai armor that still won't stop anything more than the occasion melee attack."
	icon_state = "samurai_warrior3"
	inhand_icon_state = "samurai_warrior3"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/samuraiwar4
	name = "Padded Yoroi - Black"
	desc = "A slightly higher quality samurai armor that still won't stop anything more than the occasion melee attack."
	icon_state = "samurai_warrior4"
	inhand_icon_state = "samurai_warrior4"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/samuraiwar5
	name = "Padded Yoroi - White"
	desc = "A slightly higher quality samurai armor that still won't stop anything more than the occasion melee attack."
	icon_state = "samurai_warrior5"
	inhand_icon_state = "samurai_warrior5"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/scraparmor
	name = "Beefy Scrap Armor"
	desc = "This is a whole pile of trash, just sitting on your chest.  Maybe it'll even stop someone from beating you to death. No promises though."
	icon_state = "scraparmor"
	inhand_icon_state = "scraparmor"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/suit/armor/light/kit/punk/prehistoricfur
	name = "Messy furs"
	desc = "That is definitely something you could wear."
	icon_state = "prehistoric_fur1"
	inhand_icon_state = "prehistoric_fur1"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/prehistoricfur/two
	name = "Messier furs"
	desc = "That is definitely something you could wear."
	icon_state = "prehistoric_fur2"
	inhand_icon_state = "prehistoric_fur2"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/prehistoricfur/three
	name = "Messier furs - White"
	desc = "That is definitely something you could wear."
	icon_state = "prehistoric_fur3"
	inhand_icon_state = "prehistoric_fur3"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/armor/light/kit/punk/prehistoricfur/four
	name = "Messier furs - Gray"
	desc = "That is definitely something you could wear."
	icon_state = "prehistoric_fur4"
	inhand_icon_state = "prehistoric_fur4"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)


////////////////
// OTHER //
////////////////

/obj/item/clothing/suit/armor/light/knight
	name = "preacher plate armour"
	desc = "A classic suit of plate armour, highly effective at stopping melee attacks."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "knight_red"
	inhand_icon_state = "knight_red"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = ARMS | CHEST

/obj/item/clothing/suit/armor/light/poachervest
	name = "Poachers Vest"
	desc = "A makeshift vest made out of salvaged vault-suits haphazardly stitched together. Comes with a pelt collar, leather bits and a shoulder holster hidden underneath."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "poachervest"
	inhand_icon_state = "poachervest"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/light/kit/punk/labcoat
	name = "lightly armored labcoat"
	desc = "A tattered labocat with a faded silver emblem of  wings, cogwheels and a sword on it's back. It has a couple of armor parts affixed over a leg and the shoulders for moderate protection against the dangers of wasteland."
	icon_state = "armored_labcoat"
	inhand_icon_state = "armorkit_punk"
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/light/pilotformal
	name = "formal pilot's jacket"
	desc = "An ostentatious jacket decorated with brass metals and gold cloth. It won't do much to protect the wearer, but it does let them style all over their opponents."
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1)
	icon_state = "capformal"
	inhand_icon_state = "capformal"

/////////////
// MEDIUM  //
/////////////

/*
 * Stats
 * Some slowdown, decent protection
 * 25% DR for general armor - 134% effective HP
 * 30-35% for specialist armor (most everything else is butt)
 * Assuming 25 damage from the average attack:
 * - goes from 4 hit crit to 6 at 25
 * - 5 hit crit to 7 at 20 dmg
 * - 4 hit crit to 6 at 30 dmg
 *
 * Tribal (general, got extra pockets)
 * Raider (general, ammo pouches?)
 * combat armor (Just good, also holds lots of stuff in the armor slot)
 * ballistic vest (++bullet , --melee, --laser)
 * breastplate (--bullet , ++melee, +laser)
 * riot (+++melee , -bullet, --laser, full body)
 */

/obj/item/clothing/suit/armor/medium
	name = "medium armor template"
	//icon = 'icons/fallout/clothing/armored_medium.dmi'
	//mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 30
	equip_delay_other = 50
	max_integrity = 200
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	stiffness = MEDIUM_STIFFNESS

////////////////////////////
/// MEDIUM TRIBAL ARMOR ////
////////////////////////////

// big pockets, lighter, melee focus
/obj/item/clothing/suit/armor/medium/tribal
	name = "heavy tribal armor"
	desc = "A thick suit of armor made of brahmin and gecko hides. It seems lighter than one would expect."
	cold_protection = CHEST|GROIN
	heat_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 30
	equip_delay_other = 50
	max_integrity = 200
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT // lighter, cus melee focus

/obj/item/clothing/suit/armor/medium/tribal/chitinarmor
	name = "insect chitin armor"
	desc = "A suit made from gleaming insect chitin. The glittering black scales are remarkably resistant to hostile environments, except cold."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "insect"
	inhand_icon_state = "insect"
	flags_inv = HIDEJUMPSUIT
	heat_protection = CHEST | GROIN | LEGS| ARMS | HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	siemens_coefficient = 0.5
	permeability_coefficient = 0.5
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T2) // tribal enviro armor

/obj/item/clothing/suit/armor/medium/tribal/rustwalkers
	name = "Rustwalkers armor"
	desc = "A car seat leather duster, a timing belt bandolier, and armour plating made from various parts of a car, it surely would weigh the wearer down. Commonly worn by members of the Rustwalkers tribe."
	icon_state = "rustwalkers_armour"
	inhand_icon_state = "rustwalkers_armour"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = CHEST

/obj/item/clothing/suit/armor/medium/tribal/whitelegs
	name = "White Legs armour"
	desc = "A series of tan and khaki armour plates, held in place with a considerable amount of strapping and possibly duct tape. Commonly worn by members of the White Legs tribe."
	anthro_mob_worn_overlay = 'icons/fallout/onmob/clothes/armor_medium_digi.dmi'
	icon_state = "white_legs_armour"
	inhand_icon_state = "white_legs_armour"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = ARMS | LEGS

/obj/item/clothing/suit/armor/medium/tribal/eighties
	name = "80s armour"
	desc = "A ballistic duster with the number 80 stitched onto the back worn over a breastplate made from a motorcycle's engine housing, with kneepads made from stirrups. Worn by the members of the 80s tribe."
	icon_state = "80s_armour"
	inhand_icon_state = "80s_armour"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = ARMS | CHEST

/obj/item/clothing/suit/armor/medium/tribal/deadhorses
	name = "Dead Horses armour"
	desc = "A simple leather bandolier and gecko hide chest covering, with an engraved metal pauldron and a set of black leather straps, one holding a shinpad in place. Commonly worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour"
	inhand_icon_state = "dead_horses_armour"
	mutantrace_variation = STYLE_DIGITIGRADE
	body_parts_hidden = 0

/obj/item/clothing/suit/armor/medium/tribal/bone
	name = "Reinforced Bone armor"
	desc = "A tribal armor plate, reinforced with leather and a few metal parts."
	icon_state = "bone_dancer_armor"
	inhand_icon_state = "bone_dancer_armor"
	mutantrace_variation = STYLE_DIGITIGRADE
	blood_overlay_type = "armor"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_DT_T2)

/*/obj/item/clothing/suit/armor/medium/tribal/westernwayfarer
	name = "Western Wayfarer armor"
	desc = "A Suit of armor crafted by Tribals using pieces of scrap metals and the armor of fallen foes, a bighorner's skull sits on the right pauldron along with bighorner fur lining the collar of the leather bound chest. Along the leather straps adoring it are multiple bone charms with odd markings on them."
	icon_state = "western_wayfarer_armor"
	inhand_icon_state = "western_wayfarer_armor"
	// body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	*/

/obj/item/clothing/suit/armor/medium/tribal/tribe_heavy_armor
	name = "heavy tribal armor"
	desc = "Heavy armor make of sturdy leather and pieces of bone. Worn by seasoned veterans within the local tribe."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "tribal_heavy"
	inhand_icon_state = "tribal_heavy"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_DT_T3)

////////////////////////////////
//// MEDIUM BALLISTIC VESTS ////
////////////////////////////////

// Bullet resistant, melee vulnerable, light
/obj/item/clothing/suit/armor/medium/vest
	name = "light armor vest"
	desc = "A slim vest made of kevlar. Popular Pre-Fall for their concealability, but popular in the Wasteland for their light weight and ability to stop most pistol rounds. Won't do much against bigger bullets, though."
	icon_state = "armoralt"
	inhand_icon_state = "armoralt"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST



///////////////////////////////////
//// Ballistic Vests //////////////
///////////////////////////////////

/obj/item/clothing/suit/armor/medium/ballisticvest
	name = "A base for kevlar vest"
	desc = "A base for kevlar vest electric boogaloo"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1 , ARMOR_MODIFIER_UP_BULLET_T2 , ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	vis_flags = GROIN

/obj/item/clothing/suit/armor/medium/heavierballisticvest
	name = "A heavier version of a bv"
	desc = "I'm still standing, YEAH YEAH YEAH"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1 , ARMOR_MODIFIER_UP_BULLET_T2 , ARMOR_MODIFIER_UP_DT_T1)
	vis_flags = GROIN


/obj/item/clothing/suit/armor/medium/ww1trenchbib
	name = "trench warfare wrought steel armor"
	desc = "A steel bib that was in use by the sentry units and stationary units of numerous nations and factions over the centuries. It protected mainly against shrapnel. Seems to offer better melee and shrapnel resistance."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	icon_state = "ww1bib"
	inhand_icon_state = "ww1bib"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1 , ARMOR_MODIFIER_UP_BULLET_T1 , ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	vis_flags = GROIN

/obj/item/clothing/suit/armor/medium/ballisticvest/rusvest1
	name = "A-type body armor"
	desc = "A plate carrier. This plate carrier saw primary usage long ago."
	icon_state = "russianlight"
	inhand_icon_state = "russianlight"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/foreign
	name = "Strange plate carrier"
	desc = "A foreign plate carrier. This plate carrier saw primary usage by foreign nations and PMCs"
	icon_state = "foreignplate"
	inhand_icon_state = "foreignplate"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/heavierballisticvest/rusvest2
	name = "B-type body armor"
	desc = "A plate carrier. This plate carrier saw primary usage long ago."
	icon_state = "russianheavy"
	inhand_icon_state = "russianheavy"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/newsvest
	name = "War Press vest"
	desc = "A War correspondent ballistic vest. It's lightweight and quite slim with the words 'WAR PRESS' on the back. It's a blue colored with the text being white."
	icon_state = "warpressvest"
	inhand_icon_state = "warpressvest"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/civvest
	name = "Civilian grade bodyarmor"
	desc = "A basic and lightweight Tier IIA+ vest. Meant for the civilian markets of Pre-Fall times."
	icon_state = "civplate"
	inhand_icon_state = "civplate"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/fivetact
	name = "Tactical plate carrier"
	desc = "A Tactical Plate Carrier."
	icon_state = "511tact"
	inhand_icon_state = "511tact"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/bushsuit
	name = "Ghillie suit"
	desc = "A basic kevlar vest with a whole ghillie suit over it. The ghillie suit is a macabre of leaves, plants, grass, and flora patterns by the wearer. Meant to disguise the user in grassy enviroments. A man once said 'Keep a low profile and hold your fire. Try to anticipate their paths'"
	icon_state = "ghilliesuit"
	inhand_icon_state = "ghilliesuit"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/leovest
	name = "Police vest"
	desc = "A basic and lightweight vest. Meant for the civilian markets of Pre-Fall times. Amazing that it's survived this long."
	icon_state = "nashpolicevest"
	inhand_icon_state = "nashpolicevest"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/bvest
	name = "Baily vest"
	desc = "A basic and lightweight armored vest."
	icon_state = "bailyvest"
	inhand_icon_state = "bailyvest"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/medvest
	name = "Medical ballistic vest"
	desc = "A medical themed basic and lightweight Tier IIA+ vest. Meant for the civilian markets of Pre-Fall times."
	icon_state = "vestmed"
	inhand_icon_state = "vestmed"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer
	name = "Armored Priestess ballistic suit"
	desc = "A French based suit of ballistic plating. It was an expiremental armor used by chaplin soldiers before the war. Their armor being of white, black, and gold. Adorned with whatever the user could find that suited their religious needs."
	icon_state = "40ksister"
	inhand_icon_state = "40ksister"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/battlesister
	name = "Armored Russian Priestess ballistic suit"
	desc = "A Russian designed suit of ballistic plating. This one takes after the french counterpart! It was an expiremental armor used by chaplin soldiers before the war. Their armor being of red and gold. It is adorned with whatever the user could find that suited their religious needs."
	icon_state = "brsister"
	inhand_icon_state = "brsister"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/battlesisterno2
	name = "Armored Irish Priestess ballistic suit"
	desc = "A French designed suit of ballistic plating. This one originates from Ireland it seems. It was an expiremental armor used by chaplin soldiers before the war. Their armor being of red and black. It is adorned with whatever the user could find that suited their religious needs."
	icon_state = "mlsister"
	inhand_icon_state = "mlsister"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/chaos
	name = "Armored Soviet priest robes"
	desc = "A set of silk robes with a steel plate carrier, it was used by ancient Soviet priests who needed a bit of protection as they went about life."
	icon_state = "chaos"
	inhand_icon_state = "chaos"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/imperiumspecial
	name = "Armored Special Forces ballistic armor"
	desc = "An expiremental american plating system. It consisted of chest, back, thigh, and grieves. It wasn't the best, sure, but it looks stylish and was used by very few units before the war. It was replaced by the true and tested combat armor one sees today. This one comes in a black color scheme"
	icon_state = "cadian"
	inhand_icon_state = "cadian"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/imperiuminfected
	name = "Infected ancient american ballistic armor"
	desc = "An expiremental american plating system. It consisted of chest, back, thigh, and grieves. It wasn't the best, sure, but it looks stylish and was used by very few units before the war. It was replaced by the true and tested combat armor one sees today. This one seems to be infected and looks much more streamline.."
	icon_state = "necron"
	inhand_icon_state = "necron"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/japanesearmor
	name = "Armored C.J ballistic armor"
	desc = "An expiremental Communist Japanese based armor. Used by The People's Republic of Japan or 'C.J' short for Communist Japan, this armor was adorned in a red and white armor. It's not as good as the original thing but can be nifty for style points."
	icon_state = "tau"
	inhand_icon_state = "tau"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/ballisticvest/warhammer/imperium
	name = "Armored American ballistic armor"
	desc = "An expiremental american plating system. It consisted of chest, back, thigh, and grieves. It wasn't the best, sure, but it looks stylish and was used by very few units before the war. It was replaced by the true and tested combat armor one sees today."
	icon_state = "40kpublicarmor"
	inhand_icon_state = "40kpublicarmor"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/warhammertox
	name = "Void Priestess battle armor"
	desc = "A custom set of Void Priestess X-99 battle armor. The armor is adorned with Void esq symbolism adorned with a golden Void based jewelry wrapped around the waist.The armor's void cross is adorned with a purple jewel. Inside, the armor has a quilted and luxuriously made interior complimenting it is also a soft padding for comfort!"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1 , ARMOR_MODIFIER_UP_BULLET_T2 , ARMOR_MODIFIER_UP_ENV_T1 , ARMOR_MODIFIER_UP_DT_T1)
	vis_flags = GROIN
	icon_state = "toxsister"
	inhand_icon_state = "toxsister"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

/obj/item/clothing/suit/armor/medium/spartanmarkviarmor
	name = "Leo Armaments MARK XI armor"
	desc = "A unpowered and redone set of Mark XI assault armor which was created by Leo Armaments. The armor itself is outfitted with a comfortable and nifty ballistic weave nanocomposite bodysuit. While form fitting, this armor itself can be quite protective of the user's body. Albeit it leaves crucial spots such as the stomach region exposed, which is only protected by the bodysuit."
	icon_state = "markvi"
	inhand_icon_state = "markvi"
	equip_delay_self = 5
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2,ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG


/obj/item/clothing/suit/armor/medium/spartanmarkviarmor/arggroup
	name = "ARG AEGIS Armor"
	desc = "This set of armor is a heavily modified Leo Armaments MARK XI suit, designated the Anomalous Environment General Infantry Suit. The modified set includes sample collection pouches, a mounting point for a trauma kit, an internal compass, emergency power cell, life support monitor and armor plating. This suit is a good starting point for the soldier-scientist, produced by the Augur Research Group."
	icon_state = "argmkvi"
	inhand_icon_state = "argmkvi"
	equip_delay_self = 5
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2,ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG

/obj/item/clothing/suit/armor/medium/spartanmarkviarmor2
	name = "Leo Armaments MARK XI armor 'Icebreaker'"
	desc = "A unpowered and redone set of Mark XI assault armor which was created by Leo Armaments. The armor itself is outfitted with a comfortable and nifty ballistic weave nanocomposite bodysuit. While form fitting, this armor itself can be quite protective of the user's body. Albeit it leaves crucial spots such as the stomach region exposed, which is only protected by the bodysuit. This one has the armor coated in a winter finish."
	icon_state = "markvi2"
	inhand_icon_state = "markvi2"
	equip_delay_self = 5
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2,ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG

/obj/item/clothing/suit/armor/medium/helldiver
	name = "Democratic EA-5 assault armor"
	desc = "A black and yellow colored set of armor. There is a skull isignia directly on the chest plate. This armor was manufactured by America in the late 2220s. Used for troopers sent out to explore hostile xenoplanets. Its official name is EA-5 exoarmor. "
	icon_state = "helldiver"
	inhand_icon_state = "helldiver"
	equip_delay_self = 3
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1,ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	anthro_mob_worn_overlay = 'icons/fallout/onmob/clothes/armor_medium_digi.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/wolf
	name = "Hardened Combat Carapace"
	desc = "A unique set of heavy carapace with a skull within a bunker an wings upon the shoulder, underneath the skull. A simple '43rd' Was labeled with a sword stabbing through it. On the chest embrassened was 'Kas-'' the rest was scarred off. Beyond the name 'Relt' on the pectoral. Along the blackened armor, was a bunch of different bits of graffite in chalkwhite..."
	icon_state = "wolfsquad"
	inhand_icon_state = "wolfsquad"
	icon = 'icons/fallout/clothing/armored_power.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_power.dmi'
	armor = ARMOR_VALUE_HEAVY
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)
	slowdown = ARMOR_SLOWDOWN_HEAVY* ARMOR_SLOWDOWN_GLOBAL_MULT
	mutantrace_variation = STYLE_DIGITIGRADE | STYLE_NO_ANTHRO_ICON
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch

/obj/item/clothing/suit/armor/medium/spartanmarkviarmor3
	name = "Leo Armaments MARK XI armor 'Patriot'"
	desc = "A unpowered and redone set of Mark XI assault armor which was created by Leo Armaments. The armor itself is outfitted with a comfortable and nifty ballistic weave nanocomposite bodysuit. While form fitting, this armor itself can be quite protective of the user's body. Albeit it leaves crucial spots such as the stomach region exposed, which is only protected by the bodysuit. This one has the armor coated in a Leo Armaments colored finish."
	icon_state = "markvi3"
	inhand_icon_state = "markvi3"
	equip_delay_self = 5
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2,ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG

/obj/item/clothing/suit/armor/medium/toxspartanarmors
	name = "Leo Armaments MARK XI armor 'Patriot'"
	desc = "A set of royal themed Mark XI assault armor.This armo was made to fit more curvy and hourglass shaped feminine bodies. The armor is the same as any other, however it seems to have the name 'Tox' scratched onto the right plate of the armor. The interior of the armor is made for comfort, foregoing protection for comfort fitting and enjoyment. The bodysuit is more skimpier and skin-tighter than usual, hugging the body as the user moves about."
	icon_state = "markvi2"
	inhand_icon_state = "markvi2"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor = ARMOR_VALUE_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2,ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'
	flags_inv = HIDE_PENIS | HIDE_PENIS | HIDE_BUTT | HIDE_VAG

/* * * * * * * * * *
* Old medieval armors
* * * * * * * * * * */
/obj/item/clothing/suit/armor/medium/oldarmors
	name = "template for old armors"
	desc = "Template for muh old armors go brrrrr"
	armor = ARMOR_VALUE_MEDIUM
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T2 , ARMOR_MODIFIER_UP_MELEE_T2 , ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/oldarmors/basicknightarmor
	name = "Full plate armor"
	desc = "A suit of full plated armor. It's certainly not good for bullets but good against melee attacks. Unpainted and awaiting your personalization. 'For that guy we like er..no the one in the blue.' "
	icon_state = "basicknight"
	inhand_icon_state = "basicknight"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/fancycapes
	name = "Fancy cape"
	desc = "A very fancy and luxuriously made cape, made of the finest materials and adorned in jewels and authentic furs. Long live the King/Queen."
	armor = ARMOR_VALUE_CLOTHES
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1 , ARMOR_MODIFIER_UP_DT_T1)
	icon_state = "fancycape"
	inhand_icon_state = "fancycape"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon = 'icons/fallout/clothing/armored_light.dmi'

///////////////////////////////////
//// Halo Variation armor //////
//////////////////////////////////

// Just variations of any armors to be put here if unable to make into Power Armor variations.


/obj/item/clothing/suit/armor/medium/odst
	name = "UNMC Shock Armor"
	desc = "A set of United Nations Marine Corps Shock Armor. This armor is in pristine condition and can take quite a beating. Albeit it's very prone to breaking due to any melee or plasma/laser based attacks. A wise man once said, In times like these, it pays to be the strong, silent type."
	icon_state = "odst1"
	inhand_icon_state = "odst1"
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T3 ,  ARMOR_MODIFIER_UP_ENV_T3,ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'


/obj/item/clothing/suit/armor/medium/unmcmarine
	name = "UNMC standard armor"
	desc = "A set of UNMC standard issue armor. It's generally weak and only really made to stop light projectiles and blows. Albeit whack it lacks in light to null armor, it makes up for sub-par enviromental resistance. OORAH soldier, double time!"
	icon_state = "unmct"
	inhand_icon_state = "unmct"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'


/obj/item/clothing/suit/armor/medium/retrohazmat
	name = "Old Hazmat suit"
	desc = "A old set of some sort of hazmat suit. Just shy better than most hazmat suits, but has extra pocket space and one hell of a color scheme."
	icon_state = "rhaz"
	inhand_icon_state = "rhaz"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T4 , ARMOR_MODIFIER_UP_LASER_T1 , ARMOR_MODIFIER_UP_ENERGY_T1 )
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/unmcinfiltrator
	name = "dysfunctional stealth suit"
	desc = "A suit of dysfunctional, albeit repaired to look good enough, American made stealth gear. Offers little protection."
	icon_state = "usainfil"
	inhand_icon_state = "usainfil"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2 )
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/chinastealth
	name = "dysfunctional stealth armor"
	desc = "A suit of dysfunctional Chinese Stealth Armor, albeit repaired to look good enough, once belonging to a feared Crimson Dragoon. Offers little protection."
	icon_state = "chinastealth"
	inhand_icon_state = "chinastealth"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2 )
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	flags_inv = HIDEJUMPSUIT
	body_parts_hidden = ARMS | CHEST | GROIN | LEGS

/obj/item/clothing/suit/armor/medium/unmcmedic
	name = "UNMC standard medical armor"
	desc = "A set of a medic's armor set from the UNMC before Pre-Fall times. Repainted, repaired, and now in-use by the wearer, it's mainly used by frontline medics to tank in just a tiny bit extra punishment as they tend to the fallen and wounded."
	icon_state = "unmcmedic"
	inhand_icon_state = "unmcmedic"
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2 ,)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/unmcwinter
	name = "UNMC Winter armor"
	desc = "A set of UNMC standard issue armor.This one seems to be a winter camo painted version. It's generally weak and only really made to stop light projectiles and blows. Albeit whack it lacks in light to null armor, it makes up for sub-par enviromental resistance. The winter coating gives it a boost in more unconventional based attacks. Let's get a move on, the enemy won't kick its own ass!"
	icon_state = "unmcwi"
	inhand_icon_state = "unmcwi"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/odstlead
	name = "UNMC Leader Armor"
	desc = "A set of United Nations Marine Corps Leader Armor. This armor is in pristine condition and is suited for true hardened combat. The armor itself has quite the padding, but leaves the user slow and a sitting duck. Due to the material it is made from, it's weak to laser fire. Painted on the chest is a skull with the words below it 'get sum' "
	icon_state = "odstlead"
	inhand_icon_state = "odstlead"
	equip_delay_self = 60
	equip_delay_other = 60
	armor_tier_desc = ARMOR_CLOTHING_HEAVY
	slowdown = ARMOR_SLOWDOWN_REPA * ARMOR_SLOWDOWN_MORE_T3 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_SALVAGE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_UP_DT_T3)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/merek
	name = "salvaged UNMC armor"
	desc = "A set of salvaged UNMC armor. Most of what made this armor completely terrifying to deal with is now gone or repurposed. It feels much lighter and offers much less protection than the usual set of UNMC armor. Personalized by the scavenger who found this."
	icon_state = "odstcqb"
	inhand_icon_state = "odstcqb"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	armor = ARMOR_VALUE_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1 , ARMOR_MODIFIER_UP_ENV_T2 )
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/odstcqb
	name = "UNMC CQB Armor"
	desc = "A set of United Nations Marine Corps CQB Armor. This armor is in pristine condition and is suited for CQC related situations. Weaker than its bulkier more armored counterparts and has far less padding and less enviromental equipment. But with less padding, means greater speed."
	icon_state = "odstcqb"
	inhand_icon_state = "odstcqb"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T2,ARMOR_MODIFIER_DOWN_ENERGY_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/vest/zeroodst
	name = "Custom fitted UNMC Trooper armor"
	desc = "A set of modified UNMC Trooper armor. This one has red accents on it and seems to have been designed to withstand the harshness of the wastes. The name 'Corrigan' is stenciled on the chestplate."
	icon_state = "zeroodst"
	inhand_icon_state = "zeroodst"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/vest/SpartanTox
	name = "MIRAGE Class Assault Armor"
	desc = "A set of MIRAGE Class Assault armor. Used for infiltration while providing a good set of resistance. Performs very well for enviromental hazards"
	icon_state = "miragearmor"
	inhand_icon_state = "miragearmor"
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T3, ARMOR_MODIFIER_UP_DT_T1)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'

/obj/item/clothing/suit/armor/medium/vest/flak
	name = "ancient flak vest"
	desc = "Poorly maintained, this patched vest will still still stop some bullets, but don't expect any miracles! The ballistic nylon used in its construction is inferior to kevlar, and very weak to acid, but still quite tough."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "vest_flak"
	inhand_icon_state = "vest_flak"

/obj/item/clothing/suit/armor/medium/vest/polis
	name = "police jacket"
	desc = "A sturdy durathread police coat; It's not going to stop anything good but it's better than your undies."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	mutantrace_variation = STYLE_DIGITIGRADE
	icon_state = "police_officer"
	inhand_icon_state = "police_officer"

/obj/item/clothing/suit/armor/medium/vest/polislt
	name = "police lieutenant's jacket"
	desc = "A sturdy durathread police coat; It's not going to stop anything good but it's better than your undies, This one's got silver on it."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	mutantrace_variation = STYLE_DIGITIGRADE
	icon_state = "police_lieutenant"
	inhand_icon_state = "police_lieutenant"

/obj/item/clothing/suit/armor/medium/vest/polischief
	name = "police chief's jacket"
	desc = "A sturdy durathread police coat; It's not going to stop anything good but it's better than your undies, This one's got silver on it."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	mutantrace_variation = STYLE_DIGITIGRADE
	icon_state = "police_chief"
	inhand_icon_state = "police_chief"

/obj/item/clothing/suit/armor/medium/vest/polissnr
	name = "police search and rescue jacket"
	desc = "A sturdy durathread police coat; It's not going to stop anything good but it's better than your undies, This one's got search and rescue markings."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	mutantrace_variation = STYLE_DIGITIGRADE
	icon_state = "police_snr"
	inhand_icon_state = "police_snr"

/obj/item/clothing/suit/armor/medium/vest/kevlar
	name = "kevlar vest"
	desc = "Worn but serviceable, the vest is is effective against ballistic impacts."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "vest_kevlar"
	inhand_icon_state = "vest_kevlar"

/obj/item/clothing/suit/armor/medium/vest/bulletproof
	name = "bulletproof vest"
	desc = "This vest is in good shape, the layered kevlar lightweight yet very good at stopping bullets."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "vest_bullet"
	inhand_icon_state = "vest_bullet"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T2, ARMOR_MODIFIER_UP_DT_T2)
/obj/item/clothing/suit/armor/medium/vest/bulletproof/armor
	name = "armored vest"
	desc = "Large bulletproof vest with ballistic plates."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "vest_armor"
	inhand_icon_state = "vest_armor"

/obj/item/clothing/suit/armor/medium/vest/bulletproof/big
	name = "security vest"
	desc = "A thick bullet-resistant vest composed of ballistic plates and padding. Common with Pre-Fall security forces?"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "vest_armor"
	inhand_icon_state = "vest_armor"

/obj/item/clothing/suit/armor/medium/vest/followers
	name = "followers armor vest"
	desc = "A coat in light colors with the markings of the Followers, concealing a bullet-proof vest."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "vest_follower"
	inhand_icon_state = "vest_follower"

/obj/item/clothing/suit/armor/medium/vest/town
	name = "New Boston flak vest"
	desc = "A refurbished flak vest, repaired by the Nash Police Department. The ballistic nylon has a much tougher weave, but it still will not take acid or most high-powered rounds."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "vest_flak"
	inhand_icon_state = "vest_flak"

/obj/item/clothing/suit/armor/medium/vest/oasis
	name = "Vault-Sec vest"
	desc = "a lightweight ballistic vest that is commonly worn by Vault-Tec security personnel. This one still has the badge attached."
	icon_state = "blueshift"
	inhand_icon_state = "blueshift"

/obj/item/clothing/suit/armor/light/vest/russian
	name = "russian vest"
	desc = "A bulletproof vest with forest camo. Good thing there's plenty of forests to hide in around here, right?"
	icon_state = "rus_armor"
	inhand_icon_state = "rus_armor"

/obj/item/clothing/suit/armor/medium/vest/chinese
	name = "chinese flak vest"
	desc = "An uncommon suit of Pre-Fall Chinese armor. It's a very basic and straightforward piece of armor that covers the front of the user."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "vest_chicom"
	inhand_icon_state = "vest_chicom"

/obj/item/clothing/suit/armor/medium/vest/trench
	name = "followers trenchcoat"
	desc = "A grey and white trench coat with dark blue highlights, on the sides and back it has the unique symbol of the followers. Under said coat is an armor vest, perfect for light weight protection."
	icon_state = "followerstrench"
	inhand_icon_state = "followerstrench"

/obj/item/clothing/suit/armor/medium/vest/alt
	desc = "A thick armored vest that provides decent protection against most types of damage."
	icon_state = "armor"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/medium/vest/old
	name = "degrading armor vest"
	desc = "Older generation Type 1 armored vest. It looks like a fixer-upper, but it could still stop a bullet."
	icon_state = "armor"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/medium/vest/blueshirt
	name = "large armor vest"
	desc = "A large, yet comfortable piece of armor, protecting you from some threats."
	icon_state = "blueshift"
	inhand_icon_state = "blueshift"
	custom_premium_price = PRICE_ABOVE_EXPENSIVE

/obj/item/clothing/suit/armor/medium/vest/warden
	name = "warden's jacket"
	desc = "A navy-blue armored jacket with blue shoulder designations and '/Warden/' stitched into one of the chest pockets."
	icon_state = "warden_alt"
	inhand_icon_state = "armor"
	resistance_flags = FLAMMABLE
	dog_fashion = null
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/vest/warden/alt
	name = "warden's armored jacket"
	desc = "A red jacket with silver rank pips and body armor strapped on top."
	icon_state = "warden_jacket"

/obj/item/clothing/suit/armor/medium/vest/warden/navyblue
	name = "warden's jacket"
	desc = "Perfectly suited for the warden that wants to leave an impression of style on those who visit the brig."
	icon_state = "wardenbluejacket"
	inhand_icon_state = "wardenbluejacket"
	// body_parts_covered = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/medium/vest/leather
	name = "security overcoat"
	desc = "Lightly armored leather overcoat meant as casual wear for high-ranking officers."
	icon_state = "leathercoat-sec"
	inhand_icon_state = "hostrench"
	dog_fashion = null

/obj/item/clothing/suit/armor/medium/vest/capcarapace
	name = "captain's carapace"
	desc = "A fireproof armored chestpiece reinforced with ceramic plates and plasteel pauldrons to provide additional protection whilst still offering maximum mobility and flexibility. Issued only to the station's finest, although it does chafe your nipples."
	icon_state = "capcarapace"
	inhand_icon_state = "armor"
	dog_fashion = null
	resistance_flags = FIRE_PROOF

/obj/item/clothing/suit/armor/medium/vest/capcarapace/syndicate
	name = "syndicate captain's vest"
	desc = "A sinister looking vest of advanced armor worn over a black and red fireproof jacket. The gold collar and shoulders denote that this belongs to a high ranking syndicate officer."
	icon_state = "syndievest"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/vest/capcarapace/alt
	name = "captain's parade jacket"
	desc = "For when an armoured vest isn't fashionable enough."
	icon_state = "capformal"
	inhand_icon_state = "capspacesuit"

/obj/item/clothing/suit/armor/medium/vest/det_suit
	name = "detective's armor vest"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	resistance_flags = FLAMMABLE
	dog_fashion = null

/obj/item/clothing/suit/armor/medium/vest/infiltrator
	name = "insidious combat vest"
	desc = "An insidious combat vest designed using Syndicate nanofibers to absorb the supreme majority of kinetic blows. Although it doesn't look like it'll do too much for energy impacts."
	icon_state = "infiltrator"
	inhand_icon_state = "infiltrator"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	strip_delay = 80

/obj/item/clothing/suit/armor/medium/vest/enclave
	name = "armored vest"
	desc = "Efficient prefall design issued to Enclave personell."
	icon_state = "armor_enclave_peacekeeper"
	inhand_icon_state = "armor_enclave_peacekeeper"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T2, ARMOR_MODIFIER_UP_DT_T3)


/////////////////////////////
//// MEDIUM BREASTPLATES ////
/////////////////////////////

// metal breastplates!
// ++Melee, -Bullet, +laser, bit slower
/obj/item/clothing/suit/armor/medium/vest/breastplate
	name = "steel breastplate"
	desc = "a steel breastplate, inspired by a Pre-Fall design. It provides some protection against impacts, cuts, and medium-velocity bullets."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "steel_bib"
	inhand_icon_state = "steel_bib"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/armor/medium/vest/breastplate/light
	name = "light armor plates"
	desc = "Well-made metal plates covering your vital organs."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "light_plates"
	inhand_icon_state = "armorkit"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/vest/breastplate/oasis
	name = "New Boston steel breastplate"
	desc = "a steel breastplate, inspired by a Pre-Fall design. Looks like Nash citizens added an additional layer of metal on the front face."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "steel_bib"
	inhand_icon_state = "steel_bib"

/obj/item/clothing/suit/armor/medium/vest/breastplate/town
	name = "steel breastplate"
	desc = "A steel breastplate inspired by a Pre-Fall design, this one was made locally in Nash. It uses a stronger steel alloy in it's construction, still heavy though"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'

/obj/item/clothing/suit/armor/medium/vest/breastplate/reinforced
	name = "reinforced steel breastplate"
	desc = "a steel breastplate inspired by a Pre-Fall design. It provides some protection against impacts, cuts, and medium-velocity bullets. It's pressed steel construction feels heavy."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "steel_bib_rein"
	inhand_icon_state = "steel_bib_rein"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T3)

/obj/item/clothing/suit/armor/medium/vest/breastplate/scrap
	name = "scrap metal chestplate"
	desc = "Various metal bits welded together to form a crude chestplate."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "metal_chestplate"
	inhand_icon_state = "metal_chestplate"
	siemens_coefficient = 1.3
	mutantrace_variation = STYLE_PAW_TAURIC

/obj/item/clothing/suit/armor/medium/vest/breastplate/scrap/reinforced
	name = "reinforced metal chestplate"
	desc = "Various metal bits welded together to form a crude chestplate, with extra bits of metal top of the first layer. Heavy."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "metal_chestplate2"
	inhand_icon_state = "metal_chestplate2"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T3)
	mutantrace_variation = STYLE_PAW_TAURIC

/obj/item/clothing/suit/armor/medium/vest/breastplate/scrap/brokencombat
	name = "broken combat armor chestpiece"
	desc = "It's barely holding together, but the plates might still work, you hope."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "combat_chestpiece"
	inhand_icon_state = "combat_chestpiece"
	mutantrace_variation = NONE

/obj/item/clothing/suit/armor/medium/vest/breastplate/scrap/mutant
	name = "mutant armour"
	desc = "Metal plates rigged to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "mutie_heavy_metal"
	inhand_icon_state = "mutie_heavy_metal"
	mutantrace_variation = NONE

///////////////////////
//// MEDIUM DUSTER ////
///////////////////////

/obj/item/clothing/suit/armor/medium/duster
	name = "armored greatcoat"
	desc = "A greatcoat enhanced with a special alloy for some extra protection and style for those with a commanding presence."
	icon_state = "hos"
	inhand_icon_state = "greatcoat"
	// body_parts_covered = CHEST|GROIN|ARMS|LEGS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	heat_protection = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	equip_delay_other = 50
	max_integrity = 200
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T3 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/armor/medium/duster/navyblue
	name = "head of security's jacket"
	desc = "This piece of clothing was specifically designed for asserting superior authority."
	icon_state = "hosbluejacket"
	inhand_icon_state = "hosbluejacket"

/obj/item/clothing/suit/armor/medium/duster/trenchcoat
	name = "armored trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon_state = "hostrench"
	inhand_icon_state = "hostrench"
	flags_inv = 0
	reskinnable_component = /datum/component/reskinnable/hos_trench_coat

/obj/item/clothing/suit/armor/medium/duster/armoredcoat
	name = "armored battlecoat"
	desc = "A heavy padded leather coat with faded colors, worn over a armor vest."
	icon_state = "battlecoat_tan"
	inhand_icon_state = "battlecoat_tan"

/obj/item/clothing/suit/armor/medium/duster/armoredcoat/panzer
	name = "dishevelled tan battlecoat"
	desc = "A heavy padded leather coat with faded colors, worn over an armor vest. This particular coat is torn around the edges with small holes along the shoulders and arms wherein one might denote their rank, while the underlying armor vest would be marred by burn marks and bullet holes - clearly having seen better days."
	icon_state = "battlecoat_tan"
	inhand_icon_state = "battlecoat_tan"

/obj/item/clothing/suit/armor/medium/duster/duster_renegade
	name = "renegade duster"
	desc = "Metal armor worn under a stylish duster. For the bad boy who wants to look good while commiting murder."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "duster-renegade"
	inhand_icon_state = "duster-renegade"

/obj/item/clothing/suit/armor/medium/duster/town
	name = "deputy trenchcoat"
	desc = "An armored trench coat with added shoulderpads, a chestplate, and leg guards."
	icon_state = "towntrench_medium"
	inhand_icon_state = "hostrench"

/obj/item/clothing/suit/armor/medium/duster/town/embroidered
	name = "embroidered trenchcoat"
	desc = "A custom armored trench coat with extra-length and a raised collar. There's a flower embroidered onto the back, although the color is a little faded."
	icon_state = "towntrench_special"
	inhand_icon_state = "towntrench_special"

/obj/item/clothing/suit/armor/medium/duster/town/deputy
	name = "armored town trenchcoat"
	desc = "An armored trench coat with added shoulderpads, a chestplate, and legguards."
	icon_state = "towntrench_medium"

/obj/item/clothing/suit/armor/medium/duster/town/sheriff
	name = "sheriff trenchcoat"
	desc = "A trenchcoat which does a poor job at hiding the full-body combat armor beneath it."
	icon_state = "towntrench_heavy"

/obj/item/clothing/suit/armor/medium/duster/town/sheriff/detsuit
	name = "sheriff duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of a respectful sheriff, bringer of justice."
	icon_state = "sheriff"
	inhand_icon_state = "det_suit"

/obj/item/clothing/suit/armor/medium/duster/town/commissioner
	name = "commissioner's jacket"
	desc = "A navy-blue jacket with blue shoulder designations, '/NPD/' stitched into one of the chest pockets, and hidden ceramic trauma plates. It has a small compartment for a holdout pistol."
	icon_state = "warden_alt"
	inhand_icon_state = "armor"

/obj/item/clothing/suit/armor/medium/duster/town/chief
	name = "NPD Chief's jacket"
	desc = "A navy-blue jacket with blue shoulder designations, '/NPD/' stitched into one of the chest pockets, and hidden ceramic trauma plates. It has a small compartment for a holdout pistol."
	icon = 'icons/fallout/clothing/suits_cosmetic.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_cosmetic.dmi'
	icon_state = "police_chief"
	inhand_icon_state = "police_chief"

/obj/item/clothing/suit/armor/medium/duster/town/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof). It has discrete armor plating in the lining, to foil assassination attempts."

/obj/item/clothing/suit/armor/medium/duster/motorball
	name = "motorball suit"
	desc = "Reproduction motorcycle-football suit, made in vault 75 that was dedicated to a pure sports oriented culture."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "motorball"
	inhand_icon_state = "motorball"

/obj/item/clothing/suit/armor/medium/duster/mutant
	name = "mutant poncho"
	desc = "An oversized poncho, made to fit the frame of a super mutant. Maybe he's the big ranger with an iron on his hip?"
	icon_state = "mutie_poncho"
	inhand_icon_state = "mutie_poncho"

/obj/item/clothing/suit/armor/medium/duster/cloak_armored
	name = "armored cloak"
	desc = "A dark cloak worn over protective plating."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "cloak_armored"
	inhand_icon_state = "cloak_armored"

/obj/item/clothing/suit/armor/medium/duster/enclave
	name = "enclave officer trenchcoat"
	desc = "Premium prefall military armor worn under a coat for Enclave officers."
	icon_state = "armor_enclave_officer"
	inhand_icon_state = "armor_enclave_officer"

/obj/item/clothing/suit/armor/medium/duster/follower
	name = "follower's duster"
	desc = "An old military-grade Pre-Fall combat armor under a white weathered duster. An emblem of the Followers is painted on the back of it. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "shank_follower"
	inhand_icon_state = "shank_follower"

//////////////////////
//// COMBAT ARMOR ////
//////////////////////

/obj/item/clothing/suit/armor/medium/combat
	name = "combat armor"
	desc = "An old military grade pre fall combat armor."
	icon_state = "combat_armor"
	inhand_icon_state = "combat_armor"
	mutantrace_variation = STYLE_DIGITIGRADE
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)
	equip_delay_other = 50
	max_integrity = 200
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch // 4 slots for ammo!
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = NONE

/obj/item/clothing/suit/armor/medium/combat/laserproof
	name = "ablative combat armor"
	desc = "An old military grade pre war combat armor. This one switches out its ballistic fibers for an ablative coating that disrupts energy weapons."
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)


/obj/item/clothing/suit/armor/medium/combat/dark
	name = "combat armor"
	desc = "An old military grade pre war combat armor. Now in dark, and extra-crispy!"
	color = "#514E4E"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/combat/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src) // Lagg note: No idea what this does

/obj/item/clothing/suit/armor/medium/combat/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()


//custom loadout armor for someone

/obj/item/clothing/suit/armor/medium/combat/mk2/funniloadout
	name = "weathered aethergiest power armor"
	desc = "A suit of heavily customized Enclave 'Equalizer' Advanced power armor, modified extensively to be wearable by a aethergiest, not too unlike the suits worn by Frank Horrigan, and Captain Arlem, arm-blade and all. While it is indeed a genuine Mk. 1 set of Advanced power armor, it looks like it hasn't seen any maintenance in the better part of two decades. Much of its protection has eroded, but it remains functional with a myriad of ad-hoc bandaid repairs that would make a brotherhood scribe cry in anguish."
	icon_state = "arroyoapa"
	inhand_icon_state = "arroyoapa"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_power.dmi'
	icon = 'icons/fallout/clothing/armored_power.dmi'
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T3)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	mutantrace_variation = STYLE_DIGITIGRADE |STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/medium/combat/mk2
	name = "reinforced combat armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prefall design. This one is kitted with additional plates."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "combat_armor_mk2"
	inhand_icon_state = "combat_armor_mk2"
	mutantrace_variation = STYLE_DIGITIGRADE
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 8)
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T3)

/obj/item/clothing/suit/armor/medium/combat/mk2/dark
	name = "reinforced combat armor"
	desc = "A reinforced model based of the Pre-Fall combat armor. Now in dark, light, and smoky barbeque!"
	color = "#302E2E"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/combat/mk2/remnant
	name = "remnant combat armor"
	desc = "A dark armor, used commonly in espionage or shadow ops."
	icon_state = "remnant"
	inhand_icon_state = "remnant"

/obj/item/clothing/suit/armor/medium/combat/mk2/desert_ranger
	name = "reinforced desert ranger armor"
	desc = "A suit of armor styled after those used by the Desert Rangers, with extra plates strapped to it to boot."
	icon_state = "ncr_patrol"
	inhand_icon_state = "ncr_patrol"

/obj/item/clothing/suit/armor/medium/combat/mk2/desert_ranger/pro
	name = "reinforced desert ranger suit"
	desc = "A set of armor styled after those used by the Desert Rangers, with extra plates strapped to it to boot."
	icon_state = "ncr_armor_mk2"
	inhand_icon_state = "ncr_armor_mk2"

/obj/item/clothing/suit/armor/medium/combat/mk2/raider
	name = "raider combat armor"
	desc = "An old set of reinforced combat armor with some parts supplanted with painspike armor. It seems less protective than a mint-condition set of combat armor. Can probably be used to make a better set, though..."
	inhand_icon_state = "combat_armor_raider"
	mutantrace_variation = STYLE_DIGITIGRADE
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_DOWN_ENV_T1)

/obj/item/clothing/suit/armor/medium/combat/mk2/tribal
	name = "tribal reinforced combat armor"
	desc = "An old military grade Pre-Fall reinforced combat armor, now decorated with sinew and the bones of the hunted for its new wearer."
	anthro_mob_worn_overlay = 'icons/fallout/onmob/clothes/armor_medium_digi.dmi'
	icon_state = "tribecombatarmor"
	inhand_icon_state = "tribecombatarmor"
	mutantrace_variation = STYLE_DIGITIGRADE
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/armor/medium/combat/swat
	name = "SWAT combat armor"
	desc = "A custom version of the Pre-Fall combat armor, slimmed down and minimalist for domestic S.W.A.T. teams."
	icon_state = "armoralt"
	inhand_icon_state = "armoralt"

/obj/item/clothing/suit/armor/medium/combat/chinese
	name = "ancient combat armor"
	desc = "An uncommon suit of post-fall combat armor. It's a very basic and straightforward piece of armor that covers the front of the user."
	icon_state = "chicom_armor"
	inhand_icon_state = "chicom_armor"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger
	name = "desert ranger combat armor"
	desc = "A suit of combat armor styled after those used by the Desert Rangers. It smells like red mist."
	icon_state = "desert_ranger"
	inhand_icon_state = "desert_ranger"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/combat
	name = "desert ranger combat suit"
	desc = "A suit of combat armor styled after those used by the Desert Rangers. It smells like red mist."
	icon_state = "ncr_armor"
	inhand_icon_state = "ncr_armor"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/scout
	name = "desert ranger scout armor"
	desc = "A refurbished set of desert ranger scout armor, refitted for use in the swamps. A few shiny platinum shards stick out of the webbing."
	icon_state = "refurb_scout"
	inhand_icon_state = "refurb_scout"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/officer
	name = "desert ranger officer armor"
	desc = "A suit of desert ranger styled armor, now with a fancy-looking coat to boot. Very official."
	icon_state = "ncr_officer_coat"
	inhand_icon_state = "ncr_officer_coat"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/officer/colonel
	name = "NCR colonels armor"
	desc = "A suit of desert ranger styled armor, decorated to look more official. Very, very official."
	icon_state = "ncr_captain_armour"
	inhand_icon_state = "ncr_captain_armour"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/outlaw
	name = "desert outlaw armor"
	desc = "A modified detoriated armor kit consisting of Desert Ranger style combat armor and scrap metal."
	icon_state = "ncrexile"
	inhand_icon_state = "ncrexile"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/mutant
	name = "NCR mutant armor"
	desc = "Multiple sets of NCR patrol vests that have been fused, stitched and welded together in order to fit the frame of a Super Mutant."
	icon_state = "mutie_ncr"
	inhand_icon_state = "mutie_ncr"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/patrol
	name = "desert ranger patrol armor"
	desc = "A set of desert ranger patrol armor, modified to be light and breezy here in the swamps, perfect for making blood sausage."
	icon_state = "ncr_patrol"
	inhand_icon_state = "ncr_patrol"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/patrol/mutant
	name = "mutant desert ranger armor"
	desc = "Multiple sets of desert ranger patrol armor made to protect a massive humanoid, modified to be light and breezy here in the swamps, and smelling like blood sausage."
	icon_state = "mutie_ranger_armour"
	inhand_icon_state = "mutie_ranger_armour"

/obj/item/clothing/suit/armor/medium/combat/desert_ranger/patrol/thax
	name = "desert ranger patrol duster"
	desc = "A customized and moderately-worn suit of desert ranger armor. A sun-worn thick olive duster is worn over the armor."
	icon_state = "thaxarmor"
	inhand_icon_state = "thaxarmor"

/obj/item/clothing/suit/armor/medium/combat/rusted
	name = "rusted combat armor"
	desc = "An old military grade pre war combat armor. This set has seen better days, weathered by time. The composite plates, meant for bullets and lasers, look sound and intact still. Everything else...uh..."
	icon_state = "rusted_combat_armor"
	inhand_icon_state = "rusted_combat_armor"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_DOWN_DT_T1)

/obj/item/clothing/suit/armor/medium/combat/environmental
	name = "environmental armor"
	desc = "A Pre-Fall suit developed for use in heavily contaminated environments, and is prized in the Wasteland for its ability to protect against biological threats."
	icon_state = "environmental_armor"
	inhand_icon_state = "environmental_armor"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.1
	strip_delay = 60
	equip_delay_other = 60
	flags_inv = HIDEJUMPSUIT
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T3)

/obj/item/clothing/suit/armor/medium/combat/environmental/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, FALSE)

//recipe any combat armor + duster
/obj/item/clothing/suit/armor/medium/combat/duster
	name = "combat duster"
	desc = "Refurbished combat armor under a weathered duster. Simple metal plates replace the ceramic plates that has gotten damaged."
	icon_state = "combatduster"
	inhand_icon_state = "combatduster"
	permeability_coefficient = 0.9
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_DOWN_DT_T2)

///brotherhood of steel
/obj/item/clothing/suit/armor/medium/combat/brotherhood
	name = "brotherhood armor"
	desc = "A combat armor set made by the Brotherhood of Steel, standard issue for all Knights. It bears a red stripe."
	icon_state = "brotherhood_armor_knight"
	inhand_icon_state = "brotherhood_armor_knight"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/combat/brotherhood/senior
	name = "brotherhood senior knight armor"
	desc = "A renforced combat armor set made by the Brotherhood of Steel, standard issue for all Senior Knights. It bears a silver stripe."
	icon_state = "brotherhood_armor_senior"
	inhand_icon_state = "brotherhood_armor_senior"

/obj/item/clothing/suit/armor/medium/combat/brotherhood/captain
	name = "brotherhood head knight armor"
	desc = "A renforced combat armor set made by the Brotherhood of Steel, standard issue for all Head Knights. It bears golden embroidery."
	icon_state = "brotherhood_armor_captain"
	inhand_icon_state = "brotherhood_armor_captain"

/obj/item/clothing/suit/armor/medium/combat/brotherhood/initiate
	name = "initiate armor"
	desc = "An old degraded pre war combat armor, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor"
	inhand_icon_state = "brotherhood_armor"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/combat/brotherhood/initiate/mk2
	name = "reinforced knight armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prefall design This one is kitted with additional plates and, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_armor_mk2"
	inhand_icon_state = "brotherhood_armor_mk2"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/medium/combat/brotherhood/outcast
	name = "brotherhood armor" //unused?
	desc = "A superior combat armor set made by the Brotherhood of Steel, bearing a series of red markings."
	icon_state = "brotherhood_armor_outcast"
	inhand_icon_state = "brotherhood_armor_outcast"

/obj/item/clothing/suit/armor/medium/combat/brotherhood/exile
	name = "modified Brotherhood armor"
	desc = "A modified detoriated armor kit consisting of brotherhood combat armor and scrap metal."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "exile_bos"
	inhand_icon_state = "exile_bos"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/combat/tribal
	name = "tribal combat armor"
	desc = "An old military grade pre war combat armor, now decorated with sinew and the bones of the hunted for its new wearer."
	icon_state = "tribecombatarmor"
	inhand_icon_state = "tribecombatarmor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/armor/medium/combat/marine
	name = "old United States Marine Corp Armor"
	desc = "An advanced model of combat armor worn by marines aboard the USS Democracy, second only to power armor in protection used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "enclave_marine"
	inhand_icon_state = "enclave_marine"

/obj/item/clothing/suit/armor/medium/combat/enclave
	name = "enclave combat armor"
	desc = "An old set of Pre-Fall combat armor, painted black."
	icon_state = "enclave_new"
	inhand_icon_state = "enclave_new"
/obj/item/clothing/suit/armor/medium/combat/enclave/aldric
	name = "Intercessors Exoskeleton"
	desc = "A lightly-armored full-body powered exoskeleton. Primarily designed for psionic officers, it features a multistage cascaded psionic amplifier that aids in focus and projection of their psionic abilities, especially those that require nuance and precision"
	icon_state = "enclave_new"
	inhand_icon_state = "enclave_new"

/obj/item/clothing/suit/armor/medium/pilotcarapace
	name = "pilot's combat carapace"
	desc = "A compact, if bulky, set of armor marking the wearer as one of Nash's pilots. The materials used offer solid physical protection, but does little against heat."
	icon_state = "capcarapace"
	inhand_icon_state = "capcarapace"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

///////////////////
// MEDIUM RAIDER //
///////////////////
// Has the heavier raider armors in it, less style, more protection. Still pretty light

/obj/item/clothing/suit/armor/medium/raider
	name = "base raider armor"
	desc = "for testing"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_DOWN_ENV_T1)

/obj/item/clothing/suit/armor/medium/raider/slam
	name = "slammer raider armor"
	desc = "Crude armor that appears to employ a tire of some kind as the shoulder pad. What appears to be a quilt is tied around the waist.<br>Come on and slam and turn your foes to jam!"
	icon_state = "slam"
	inhand_icon_state = "slam"
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	body_parts_hidden = ARMS | LEGS | GROIN

/obj/item/clothing/suit/armor/medium/raider/rebel
	name = "rebel raider armor"
	desc = "Rebel, rebel. Your face is a mess."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "raider_rebel_icon"
	inhand_icon_state = "raider_rebel_armor"

/obj/item/clothing/suit/armor/medium/raider/scrapcombat
	name = "scrap combat armor"
	desc = "Scavenged military combat armor, repaired by unskilled hands many times, most of the original plating having cracked or crumbled to dust."
	icon_state = "raider_combat"
	inhand_icon_state = "raider_combat"

/obj/item/clothing/suit/armor/medium/raider/badlands
	name = "badlands raider armor"
	desc = "A leather top with a bandolier over it and a straps that cover the arms."
	icon_state = "badlands"
	inhand_icon_state = "badlands"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	body_parts_hidden = ARMS | LEGS | GROIN

/obj/item/clothing/suit/armor/medium/raider/combatduster
	name = "combat duster"
	desc = "An old military-grade Pre-Fall combat armor under a weathered duster. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "combatduster"
	inhand_icon_state = "combatduster"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/raider/combatduster/patrolduster
	name = "Patrol Duster"
	desc = "What appears to be an NCR patrol ranger's armor under a green tinted duster. The armor itself looks much more well kept then the duster itself, said duster looking somewhat faded. On the back of the duster, is a symbol of a skull with an arrow piercing through the eye."
	icon_state = "patrolduster"
	inhand_icon_state = "patrolduster"

/obj/item/clothing/suit/armor/medium/raider/raidercombat
	name = "combat raider armor"
	desc = "An old military-grade Pre-Fall combat armor. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "raider_combat"
	inhand_icon_state = "raider_combat"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/suit/armor/medium/raider/raidermetal
	name = "metal raider armor"
	desc = "A suit of welded, fused metal plates. Looks bulky, with great protection."
	icon_state = "raider_metal"
	inhand_icon_state = "raider_metal"
	resistance_flags = FIRE_PROOF
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/armor/medium/raider/wastewar
	name = "wasteland warrior armor"
	desc = "a mad attempt to recreate armor based of images of japanese samurai, using a sawn up old car tire as shoulder pads, bits of chain to cover the hips and pieces of furniture for a breastplate. Might stop a blade but nothing else, burns easily too. Comes with an enormous scabbard welded to the back!"
	icon_state = "wastewar"
	inhand_icon_state = "wastewar"
	resistance_flags = FLAMMABLE
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/massive/swords
	body_parts_hidden = CHEST | GROIN

/obj/item/clothing/suit/armor/medium/raider/blastmaster
	name = "blastmaster raider armor"
	desc = "A suit composed largely of blast plating, though there's so many holes it's hard to say if it will protect against much."
	icon_state = "blastmaster"
	inhand_icon_state = "blastmaster"
	flash_protect = 2
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_BOMB_T2)

/obj/item/clothing/suit/armor/medium/raider/yankee
	name = "yankee raider armor"
	desc = "A set of armor made from bulky plastic and rubber. A faded sports team logo is printed in various places. Go Desert Rats!"
	icon_state = "yankee"
	inhand_icon_state = "yankee"
	body_parts_hidden = ARMS | CHEST

/// Environmental raider armor
/obj/item/clothing/suit/armor/medium/raider/iconoclast
	name = "iconoclast raider armor"
	desc = "A rigid armor set that appears to be fashioned from a radiation suit, or a mining suit."
	icon_state = "iconoclast"
	inhand_icon_state = "iconoclast"
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T2)


///////////
// HEAVY //
///////////

/*
 * Stats
 * Big slowdown, high protection
 * 40% DR for general armor - ???% effective HP
 * 50-60% for specialist armor (most everything else is butt)
 *
 * Types:
 * Tribal Raider (basically the same at this point)
 * metal (-bullet , ++melee, ++laser)
 * Polished (--bullet , +melee, +++laser)
 * riot (special, +++melee , -bullet, --laser)
 * Vest - bulletproof (special, +++bullet, --everything else)
 * Salvaged PA (partway to PA, but super sloooow and bulky)
 */

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor template"
	//icon = 'icons/fallout/clothing/armored_heavy.dmi'
	//mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	strip_delay = 50
	equip_delay_other = 50
	max_integrity = 300
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_HEAVY
	armor_tier_desc = ARMOR_CLOTHING_HEAVY
	stiffness = HEAVY_STIFFNESS

/////////////////////
//// BULLET VEST //// ...?
/////////////////////

/obj/item/clothing/suit/armor/heavy/vest/bulletproof
	name = "heavy bulletproof armor"
	desc = "A heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry."
	icon_state = "bulletproof"
	inhand_icon_state = "armor"
	blood_overlay_type = "armor"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch // 4 slots for ammo!
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_ENV_T2, ARMOR_MODIFIER_UP_DT_T3)

//////////////////////
//// TRIBAL ARMOR ////
//////////////////////

/obj/item/clothing/suit/armor/heavy/tribal
	name = "tribal heavy carapace"
	desc = "Thick layers of leather and bone, with metal reinforcements, surely this will make the wearer tough and uncaring for claws and blades."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "tribal_heavy"
	inhand_icon_state = "tribal_heavy"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/jacket
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_LASER_T1)


/obj/item/clothing/suit/armor/heavy/tribal/bone
	name = "Heavy Bone armor"
	desc = "A tribal full armor plate, crafted from animal bone, metal and leather. Usually worn by the Bone Dancers"
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = null
	icon_state = "bone_dancer_armor_heavy"
	inhand_icon_state = "bone_dancer_armor_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE
	blood_overlay_type = "armor"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T1)


/obj/item/clothing/suit/armor/heavy/tribal/metal
	name = "metal armor suit"
	desc = "A suit of welded, fused metal plates. Bulky, but with great protection."
	icon = 'icons/obj/clothing/suits.dmi'
	mob_overlay_icon = null
	icon_state = "raider_metal"
	inhand_icon_state = "raider_metal"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1)

/obj/item/clothing/suit/armor/heavy/tribal/rustwalkers
	name = "Rustwalkers heavy armor"
	desc = "A car seat leather duster, a timing belt bandolier, and armour plating made from various parts of a car, it surely would weigh the wearer down. Commonly worn by members of the Rustwalkers tribe."
	icon_state = "rustwalkers_armour_heavy"
	inhand_icon_state = "rustwalkers_armour_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/heavy/tribal/whitelegs
	name = "White Legs heavy armour"
	desc = "A series of tan and khaki armour plates, held in place with a considerable amount of strapping and possibly duct tape. Commonly worn by members of the White Legs tribe."
	icon_state = "white_legs_armour_heavy"
	inhand_icon_state = "white_legs_armour_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/heavy/tribal/eighties
	name = "80s heavy armour"
	desc = "A ballistic duster with the number 80 stitched onto the back worn over a breastplate made from a motorcycle's engine housing, with kneepads made from stirrups. Worn by the members of the 80s tribe."
	icon_state = "80s_armour_heavy"
	inhand_icon_state = "80s_armour_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/heavy/tribal/deadhorses
	name = "Dead Horses heavy armour"
	desc = "A simple leather bandolier and gecko hide chest covering, with an engraved metal pauldron and a set of black leather straps, one holding a shinpad in place. Commonly worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour_heavy"
	inhand_icon_state = "dead_horses_armour_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/heavy/tribal/westernwayfarer
	name = "Western Wayfarer heavy armor"
	desc = "A Suit of armor crafted by Tribals using pieces of scrap metals and the armor of fallen foes, a bighorner's skull sits on the right pauldron along with bighorner fur lining the collar of the leather bound chest. Along the leather straps adoring it are multiple bone charms with odd markings on them."
	icon_state = "western_wayfarer_armor_heavy"
	inhand_icon_state = "western_wayfarer_armor_heavy"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS

/obj/item/clothing/suit/armor/heavy/tribal/bone
	name = "Heavy Bone armor"
	desc = "A tribal full armor plate, crafted from animal bone, metal and leather. Usually worn by the Bone Dancers"
	icon_state = "bone_dancer_armor_heavy"
	inhand_icon_state = "bone_dancer_armor_heavy"
	mutantrace_variation = STYLE_DIGITIGRADE
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/////////////////////
//// METAL ARMOR ////
/////////////////////

/obj/item/clothing/suit/armor/heavy/metal
	name = "metal armor"
	desc = "A set of plates formed together to form a crude chestplate."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "metal_chestplate"
	inhand_icon_state = "metal_chestplate"
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_PAW_TAURIC

/obj/item/clothing/suit/armor/heavy/metal/polished
	name = "polished metal armor"
	desc = "A set of plates formed together to form a crude chestplate. These have been waxed and buffed to a mirror finish, but it looks a bit thinner."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "armor_enclave_peacekeeper"
	inhand_icon_state = "armor_enclave_peacekeeper"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)
	mutantrace_variation = NONE

/obj/item/clothing/suit/armor/heavy/metal/polished/actually_laserproof // also actually_unobtainable
	name = "reflector vest"
	desc = "A vest that excels in protecting the wearer against energy projectiles, as well as occasionally reflecting them."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "armor_reflec"
	inhand_icon_state = "armor_reflec"
	blood_overlay_type = "armor"
	mob_overlay_icon = null
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	var/hit_reflect_chance = 40
	protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN)
	mutantrace_variation = NONE
	armor = list(
		"melee" = 0,
		"bullet" = 0,
		"laser" = 90,
		"energy" = 30,
		"bomb" = 10,
		"bio" = 10,
		"rad" = 10,
		"fire" = 10,
		"acid" = 50)

/obj/item/clothing/suit/armor/heavy/metal/polished/actually_laserproof/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(def_zone in protected_zones)
		if(prob(hit_reflect_chance))
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/heavy/metal/tesla //changed from armor/laserproof
	name = "tesla armor"
	desc = "A prefall armor design by Nikola Tesla before being confinscated by the U.S. government. Has a chance to deflect energy projectiles."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "tesla_armor"
	inhand_icon_state = "tesla_armor"
	blood_overlay_type = "armor"
	mob_overlay_icon = null
	resistance_flags = FIRE_PROOF
	var/hit_reflect_chance = 20
	protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	mutantrace_variation = NONE
	armor = list(
		"melee" = 5,
		"bullet" = 5,
		"laser" = 65,
		"energy" = 50,
		"bomb" = 0,
		"bio" = 0,
		"rad" = 0,
		"fire" = 0,
		"acid" = 0)

/obj/item/clothing/suit/armor/heavy/metal/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/heavy/metal/reinforced
	name = "reinforced metal armor"
	desc = "A set of well-fitted plates formed together to provide effective protection."
	icon_state = "metal_chestplate2"
	inhand_icon_state = "metal_chestplate2"
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = STYLE_PAW_TAURIC

/obj/item/clothing/suit/armor/heavy/metal/mutant
	name = "mutant armour"
	desc = "An oversized set of metal armour, made to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "mutie_metal_armour"
	inhand_icon_state = "mutie_metal_armour"
	mutantrace_variation = NONE

/obj/item/clothing/suit/armor/heavy/metal/mutant/reinforced
	name = "mutant armour"
	desc = "An oversized boiler plate, hammered to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon_state = "mutie_metal_armour_mk2"
	inhand_icon_state = "mutie_metal_armour_mk2"
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	mutantrace_variation = NONE

/obj/item/clothing/suit/armor/heavy/metal/sulphite
	name = "sulphite armor"
	desc = "A combination of what seems to be raider metal armor with a jerry-rigged flame-exhaust system and ceramic plating."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	resistance_flags = FIRE_PROOF
	icon_state = "sulphite"
	inhand_icon_state = "sulphite"
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_MORE_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_FIRE_T3)
	mutantrace_variation = NONE

////////////////////
//// RIOT ARMOR ////
////////////////////

/obj/item/clothing/suit/armor/heavy/riot
	name = "riot suit"
	desc = "A suit of semi-flexible polycarbonate body armor with heavy padding to protect against melee attacks. Helps the wearer resist shoving in close quarters."
	icon_state = "riot"
	inhand_icon_state = "swat_suit"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch // 4 slots for ammo!
	blocks_shove_knockdown = TRUE
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_FIRE_T3, ARMOR_MODIFIER_UP_DT_T3)

/obj/item/clothing/suit/armor/heavy/riot/combat
	name = "combat riot armor"
	icon_state = "combat_coat"
	inhand_icon_state = "combat_coat"
	desc = "A heavy armor with ballistic inserts, sewn into a padded riot police coat."

/obj/item/clothing/suit/armor/heavy/riot/police
	name = "riot police armor"
	icon_state = "bulletproof_heavy"
	inhand_icon_state = "bulletproof_heavy"
	desc = "Heavy armor with ballistic inserts, sewn into a padded riot police coat."

/obj/item/clothing/suit/armor/heavy/riot/vault
	name = "VTCC riot armour"
	desc = "(VII) A suit of riot armour adapted from the design of the Pre-Fall U.S.M.C. armour, painted blue and white."
	icon_state = "vtcc_riot_gear"
	inhand_icon_state = "vtcc_riot_gear"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3)

/obj/item/clothing/suit/armor/heavy/riot/marine
	name = "old United States Marine Corp riot suit"
	desc = "A Pre-Fall riot suit helmet used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "usmc_riot_gear"
	inhand_icon_state = "usmc_riot_gear"

/*/obj/item/clothing/suit/armor/heavy/riot/retrofitted
	name = "retro fitted riot combat armor"
	desc = "A Pre-Fall riot suit helmet used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen, and has been heavily modified with extra pockets and armor-plates. Heavy as sin."
	icon_state = "usmc_riot_gear"
	inhand_icon_state = "usmc_riot_gear"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_DOWN_FIRE_T3, ARMOR_MODIFIER_DOWN_DT_T1)

/obj/item/clothing/suit/armor/heavy/riot/retrofitted/worn
	name = "Enclave exile armor"
	icon_state = "unmct"
	inhand_icon_state = "unmct"
	desc = "A slimmed down set of reinforced combat armor. While not as effective as the standard issue, it makes up for it in more room for holding things and keeping you light on your feet."
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_DT_T2)
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	stiffness = LIGHT_STIFFNESS
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon = 'icons/fallout/clothing/armored_medium.dmi'*/

/obj/item/clothing/suit/armor/heavy/riot/elite
	name = "elite riot gear"
	desc = "A heavily reinforced set of military grade armor."
	icon_state = "elite_riot"
	inhand_icon_state = "elite_riot"
	icon = 'icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/armor/heavy/riot/eliteweak
	name = "worn elite riot gear"
	desc = "A heavily reinforced set of military grade armor. This one appears to be aged..."
	icon_state = "elite_riot"
	inhand_icon_state = "elite_riot"
	icon = 'icons/obj/clothing/suits.dmi'
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_FIRE_T3, ARMOR_MODIFIER_DOWN_DT_T1)

//////////////////////////
// Salvaged Power Armor //
//////////////////////////

/obj/item/clothing/suit/armor/heavy/salvaged_pa
	name = "salvaged power armor template"
	desc = "It's a set of early-model SS-13 power armor, except it isn't real. Stop looking at it, go ping coders or something. \
	It's literally not meant to be here, you are just wasting your time reading some text that someone wrote for you \
	because he thought it'd be funny, or expected someone to check GitHub for once, hello by the way. \
	If you still don't understand - it's a 'master' item, basically main type/parent object or something. \
	It isn't meant to be used, it just dictates procs and all that stuff to the subtypes, such as t45b and so on. \
	Now begone, report this to coders. NOW!"
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	slowdown = ARMOR_SLOWDOWN_SALVAGE * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_SALVAGE
	armor_tier_desc = ARMOR_CLOTHING_SALVAGE

// T-45B
/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b
	name = "salvaged T-45b power armor"
	desc = "It's a set of early-model T-45 power armor with a custom air conditioning module and stripped out servomotors. Bulky and slow, but almost as good as the real thing."
	icon_state = "t45b_salvaged"
	inhand_icon_state = "t45b_salvaged"

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/raider
	name = "salvaged raider power armor"
	desc = "A destroyed T-45b power armor has been brought back to life with the help of a welder and lots of scrap metal."
	icon_state = "raider_salvaged"
	inhand_icon_state = "raider_salvaged"

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/hotrod
	name = "salvaged hotrod T-45b power armor"
	desc = " It's a set of T-45b power armor with a with some of its plating removed. This set has exhaust pipes piped to the pauldrons, flames erupting from them."
	mob_overlay_icon = 'icons/fallout/clothing/armored_heavy.dmi'
	icon_state = "t45hotrod"
	inhand_icon_state = "t45hotrod"
	armor_tokens = list(ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_DOWN_DT_T2)


/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal
	name = "salvaged tribal T45-b power armor"
	desc = "A set of salvaged power armor, with certain bits of plating stripped out to retain more freedom of movement. No cooling module, though."
	icon_state = "tribal_power_armor"
	inhand_icon_state = "tribal_power_armor"
	// body_parts_covered = CHEST|GROIN|ARMS|LEGS
	mutantrace_variation = STYLE_DIGITIGRADE
	slowdown = ARMOR_SLOWDOWN_SALVAGE * ARMOR_SLOWDOWN_LESS_T3 * ARMOR_SLOWDOWN_GLOBAL_MULT // zooom
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2)

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal/junk
	name = "salvaged weathered tribal T45-b power armor"
	desc = "A set of salvaged tribal power armor, one that's seen better days. Proof that power armor doesn't age like wine, especially dragged through the swamp as much as this one has. All that weathered off armor plating's sure made it light, though!"
	icon_state = "tribal_power_armor"
	inhand_icon_state = "tribal_power_armor"
	// body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = ARMOR_VALUE_HEAVY
	mutantrace_variation = STYLE_DIGITIGRADE
	slowdown = ARMOR_SLOWDOWN_HEAVY * ARMOR_SLOWDOWN_GLOBAL_MULT
	color = "#b1a687"

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45d
	name = "salvaged T-45d power armor"
	desc = "T-45d power armor with servomotors and all valuable components stripped out of it."
	icon_state = "t45d_salvaged"
	inhand_icon_state = "t45d_salvaged"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1)

// T-51B
/obj/item/clothing/suit/armor/heavy/salvaged_pa/t51b
	name = "salvaged T-51b power armor"
	desc = "T-51b power armor with servomotors and all valuable components stripped out of it."
	icon_state = "t51b_salvaged"
	inhand_icon_state = "t51b_salvaged"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_DT_T1)


// X-02
/obj/item/clothing/suit/armor/heavy/salvaged_pa/x02
	name = "salvaged Enclave power armor"
	desc = "X-02 power armor with servomotors and all valuable components stripped out of it."
	icon_state = "advanced_salvaged"
	inhand_icon_state = "advanced_salvaged"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_DT_T2)


// Just generic PA I guess??
/obj/item/clothing/suit/armor/heavy/salvaged_pa/recycled
	name = "recycled power armor"
	desc = "Taking pieces off from a wrecked power armor will at least give you thick plating, but don't expect too much of this shot up, piecemeal armor.."
	icon_state = "recycled_power"

/////////////////
// Power armor //
/////////////////

/obj/item/clothing/suit/armor/power_armor
	name = "power armor template"
	desc = "It's a template for PA. If you can see this, something's gone wrong."
	w_class = WEIGHT_CLASS_HUGE
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	item_flags = SLOWS_WHILE_IN_HAND
	clothing_flags = THICKMATERIAL
	equip_delay_self = 50
	equip_delay_other = 60
	strip_delay = 200
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 20)
	salvage_tool_behavior = TOOL_WELDER
	pocket_storage_component_path = null // quit ripping your power cell out ffs
	/// Cell that is currently installed in the suit
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell/high
	/// How much power the cell consumes each process tick
	var/usage_cost = 5 // With high-capacity cell it'd run out of charge in ~33 minutes
	/// If TRUE - suit has ran out of charge and is currently affected by slowdown from it
	var/no_power = FALSE
	/// How much slowdown is added when suit is unpowered
	var/unpowered_slowdown = 3
	/// Projectiles below this damage will get deflected
	var/deflect_damage = 20 // blocks handload 9mm, which simplemobs shoot
	/// If TRUE - it requires PA training trait to be worn
	var/requires_training = FALSE // testing if the PA perk is actually fun or not
	/// If TRUE - the suit will give its user specific traits when worn
	var/powered = TRUE
	/// If TRUE - the suit has been recently affected by EMP blast
	var/emped = FALSE
	/// Path of item that this set of armor gets salvaged into
	var/obj/item/salvaged_type = null
	/// Used to track next tool required to salvage the suit
	var/salvage_step = 0
	var/deflecting = FALSE
	// Can deflect determines if you can toggle the deflection on armor. Intended for armors that shouldnt have the ability by default.
	var/can_deflect = TRUE
	var/deflect_power_mult = 20
	COOLDOWN_DECLARE(emp_cooldown)
	COOLDOWN_DECLARE(deflect_cd)
	var/deflect_cooldown = 1 SECONDS
	var/can_deflect_while_blocking = TRUE
	slowdown = ARMOR_SLOWDOWN_PA * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_PA
	armor_tier_desc = ARMOR_CLOTHING_PA
	stiffness = MEDIUM_STIFFNESS

/obj/item/clothing/suit/armor/power_armor/Initialize()
	. = ..()
	if(ispath(cell))
		cell = new cell(src)

/obj/item/clothing/suit/armor/power_armor/mob_can_equip(mob/user, mob/equipper, slot, disable_warning = 1)
	var/mob/living/carbon/human/H = user
	if(src == H.wear_suit) //Suit is already equipped
		return ..()
	if (!HAS_TRAIT(H, TRAIT_PA_WEAR) && slot == SLOT_WEAR_SUIT && requires_training)
		to_chat(user, span_warning("You don't have the proper training to operate the power armor!"))
		return FALSE
	if(slot == SLOT_WEAR_SUIT)
		return ..()
	return

/obj/item/clothing/suit/armor/power_armor/equipped(mob/user, slot)
	..()
	if(slot == SLOT_WEAR_SUIT && powered)
		START_PROCESSING(SSobj, src)
		assign_traits(user)

/obj/item/clothing/suit/armor/power_armor/proc/assign_traits(mob/user)
	if(no_power) // Has no charge left
		return
	ADD_TRAIT(user, TRAIT_STUNIMMUNE, "PA_stun_immunity")
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, "PA_push_immunity")
	ADD_TRAIT(user, SPREAD_CONTROL, "PA_spreadcontrol")
	ADD_TRAIT(user, TRAIT_POWER_ARMOR, "PA_worn_trait") // General effects from being in PA

/obj/item/clothing/suit/armor/power_armor/dropped(mob/user)
	..()
	if(powered)
		STOP_PROCESSING(SSobj, src)
		remove_traits(user)

/obj/item/clothing/suit/armor/power_armor/proc/remove_traits(mob/user)
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, "PA_stun_immunity")
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, "PA_push_immunity")
	REMOVE_TRAIT(user, SPREAD_CONTROL, "PA_spreadcontrol")
	REMOVE_TRAIT(user, TRAIT_POWER_ARMOR, "PA_worn_trait")

/obj/item/clothing/suit/armor/power_armor/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/power_armor/process()
	var/mob/living/carbon/human/user = src.loc
	if(!user || !ishuman(user) || (user.wear_suit != src))
		return
	if((!cell || !cell?.use(usage_cost) || (salvage_step > 1))) // No cell, ran out of charge or we're in the process of being salvaged
		if(!no_power)
			remove_power(user)
		return
	if(no_power) // Above didn't proc and suit is currently unpowered, meaning cell is installed and has charge - restore power
		restore_power(user)
		return

/obj/item/clothing/suit/armor/power_armor/proc/remove_power(mob/user)
	if(salvage_step > 1) // Being salvaged
		to_chat(user, span_warning("Components in [src] require repairs!"))
	else
		to_chat(user, span_warning("\The [src] has ran out of charge!"))
	slowdown += unpowered_slowdown
	no_power = TRUE
	remove_traits(user)
	user.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/power_armor/proc/restore_power(mob/user)
	to_chat(user, span_notice("\The [src]'s power restored."))
	slowdown -= unpowered_slowdown
	no_power = FALSE
	assign_traits(user)
	user.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/power_armor/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(powered && istype(I, /obj/item/stock_parts/cell))
		if(cell)
			to_chat(user, span_warning("\The [src] already has a cell installed."))
			return
		if(user.transferItemToLoc(I, src))
			cell = I
			to_chat(user, span_notice("You successfully install \the [cell] into [src]."))
		return

	if(ispath(salvaged_type))
		switch(salvage_step)
			if(0)
				// Salvage
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before salvaging it."))
						return
					to_chat(user, span_notice("You begin unsecuring the wiring cover..."))
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 1
						to_chat(user, span_notice("You unsecure the wiring cover."))
					return
			if(1)
				// Salvage
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before salvaging it."))
						return
					to_chat(user, span_notice("You start to cut down the wiring..."))
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 2
						to_chat(user, span_notice("You disconnect the wires."))
					return
				// Fix
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before fixing it."))
						return
					to_chat(user, span_notice("You begin securing the wiring cover..."))
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 0
						to_chat(user, span_notice("You secure the wiring cover."))
					return
			if(2)
				// Salvage
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before salvaging it."))
						return
					to_chat(user, span_notice("You start loosening the bolts that secure components to the frame..."))
					if(I.use_tool(src, user, 100, volume=50))
						salvage_step = 3
						to_chat(user, span_notice("You disconnect the inner components."))
					return
				// Fix
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before fixing it."))
						return
					to_chat(user, span_notice("You begin placing wires back into their place..."))
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 1
						to_chat(user, span_notice("You re-connect the wires."))
					return
			if(3)
				// Salvage
				if(istype(I, /obj/item/weldingtool) || istype(I, /obj/item/gun/energy/plasmacutter))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before salvaging it."))
						return
					to_chat(user, span_notice("You begin slicing the servomotors apart from the frame..."))
					if(I.use_tool(src, user, 150, volume=60))
						salvage_step = 4
						to_chat(user, span_notice("You disconnect servomotors from the main frame."))
					return
				// Fix
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before fixing it."))
						return
					to_chat(user, span_notice("You start securing components to the frame..."))
					if(I.use_tool(src, user, 100, volume=50))
						salvage_step = 2
						to_chat(user, span_notice("You re-connect the inner components."))
					return
			if(4)
				// Salvage
				if(istype(I, /obj/item/crowbar))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before salvaging it."))
						return
					to_chat(user, span_notice("You start to remove remaining components..."))
					if(I.use_tool(src, user, 50, volume=70))
						to_chat(user, span_notice("You finish salvaging the suit."))
						var/obj/item/ST = new salvaged_type(src)
						user.put_in_hands(ST)
						qdel(src)
					return
				// Fix
				if(istype(I, /obj/item/weldingtool) || istype(I, /obj/item/gun/energy/plasmacutter))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the suit before fixing it."))
						return
					to_chat(user, span_notice("You begin welding the servomotors to the frame..."))
					if(I.use_tool(src, user, 150, volume=60))
						salvage_step = 3
						to_chat(user, span_notice("You re-connect servomotors to the main frame."))
					return
	return ..()

/obj/item/clothing/suit/armor/power_armor/attack_self(mob/living/user)
	if(powered)
		toggle_cell(user)
	return ..()

/obj/item/clothing/suit/armor/power_armor/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return ..()
	if(powered)
		toggle_cell(user)
	return

/obj/item/clothing/suit/armor/power_armor/CtrlShiftClick(mob/user)
	if(!can_deflect)
		to_chat(user, span_warning("Your armor doesnt have deflector shields!"))
		return ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return ..()
	if(!COOLDOWN_FINISHED(src, emp_cooldown))
		to_chat(user, span_warning("Deflector shields still respooling!"))
	TOGGLE_VAR(deflecting)
	if(deflecting)
		to_chat(user, span_notice("You activate the suit's deflector shield."))
	else
		to_chat(user, span_alert("You deactivate the suit's deflector shield."))

/obj/item/clothing/suit/armor/power_armor/proc/toggle_cell(mob/living/user)
	if(cell)
		user.visible_message(span_notice("[user] removes \the [cell] from [src]!"), \
			span_notice("You remove [cell]."))
		cell.add_fingerprint(user)
		user.put_in_hands(cell)
		cell = null
	else
		to_chat(user, span_warning("[src] has no cell installed."))

/obj/item/clothing/suit/armor/power_armor/examine(mob/user)
	. = ..()
	if(powered && (in_range(src, user) || isobserver(user)))
		if(cell)
			. += "The power meter shows [round(cell.percent(), 0.1)]% charge remaining."
		else
			. += "The power cell slot is currently empty."
	if(deflecting && powered && cell)
		. += "The deflector shield is currently active."
	else if(!COOLDOWN_FINISHED(src, emp_cooldown))
		. += "The deflector shield is respooling!"
	else
		. += "The deflector shield is currently inactive."
	if(ispath(salvaged_type))
		. += salvage_hint()

/obj/item/clothing/suit/armor/power_armor/proc/salvage_hint()
	switch(salvage_step)
		if(0)
			return span_notice("The wiring cover is <i>screwed</i> in place.")
		if(1)
			return span_notice("The cover is <i>screwed</i> open and <i>wires</i> are visible.")
		if(2)
			return span_warning("The wiring has been <i>cut</i> and components connected with <i>bolts</i> are visible.")
		if(3)
			return span_warning("The components have been <i>unanchored</i> servomotors inside the suit can be <i>sliced through</i>.")
		if(4)
			return span_warning("The servomotors have been <i>sliced apart</i> from the frame and remaining components can be <i>pried away</i>.")

/obj/item/clothing/suit/armor/power_armor/emp_act(mob/living/carbon/human/owner, severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(deflecting)
		deflecting = FALSE
		to_chat(owner, span_alert("Deflector shield overloaded!"))
		playsound(get_turf(src), "sound/effects/electric_hiss.ogg", 100, TRUE)
		COOLDOWN_START(src, emp_cooldown, 30 SECONDS)
	if(!powered)
		return
	if(cell)
		cell.emp_act(severity)
	if(!emped)
		if(isliving(loc))
			var/mob/living/L = loc
			var/induced_slowdown = 0
			if(severity >= 41) //heavy emp
				induced_slowdown = 4
				to_chat(L, span_boldwarning("Warning: severe electromagnetic surge detected in armor. Rerouting power to emergency systems."))
			else
				induced_slowdown = 2
				to_chat(L, span_warning("Warning: light electromagnetic surge detected in armor. Rerouting power to emergency systems."))
			emped = TRUE
			slowdown += induced_slowdown
			L.update_equipment_speed_mods()
			addtimer(CALLBACK(src,PROC_REF(end_emp_effect), induced_slowdown), 50)
	return

/obj/item/clothing/suit/armor/power_armor/proc/end_emp_effect(slowdown_induced)
	emped = FALSE
	slowdown -= slowdown_induced // Even if armor is dropped it'll fix slowdown
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, span_warning("Armor power reroute successful. All systems operational."))
		L.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/power_armor/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!COOLDOWN_FINISHED(src, deflect_cooldown))
		return ..()
	if(!deflecting)
		return ..()
	if(!can_deflect_while_blocking && (CHECK_BITFIELD(owner.combat_flags, COMBAT_FLAG_ACTIVE_BLOCKING) || CHECK_BITFIELD(owner.combat_flags, COMBAT_FLAG_ACTIVE_BLOCK_STARTING)))
		return ..()
	if(attack_type != ATTACK_TYPE_PROJECTILE)
		return ..()
	if(!(def_zone in protected_zones))
		return ..()
	if(!powered || !cell || cell.charge <= 0)
		return ..()
	if(!istype(object, /obj/item/projectile))
		return ..()
	var/obj/item/projectile/P = object
	if(P.damage > deflect_damage)
		return ..()
	if(P.armour_penetration > 0)
		return ..()
	block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
	cell.use(round(rand(damage*(deflect_power_mult*0.5), damage*(deflect_power_mult*2)), 100))
	do_sparks(2, FALSE, owner)
	SSrecoil.kickback(owner, recoil_in = 10)
	var/soundplay = pick("sound/weapons/bullet_ricochet_1.ogg", "sound/weapons/bullet_ricochet_2.ogg")
	playsound(get_turf(src), soundplay, 100, TRUE)
	playsound(get_turf(src), "sound/weapons/metal_clank.ogg", 100, TRUE)
	playsound(get_turf(src), "sound/effects/bworp.ogg", 75, TRUE)
	COOLDOWN_START(src, deflect_cd, deflect_cooldown)
	return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL

/obj/item/clothing/suit/armor/power_armor/fluff
	name = "Placeholder Loadout Power Armor"
	desc = "A placeholder block for personal and loadout power armors."
	icon = 'icons/fallout/clothing/armored_power.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_power.dmi'
	icon_state = "t45bpowerarmor"
	inhand_icon_state = "t45bpowerarmor"
	armor = ARMOR_VALUE_HEAVY
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)
	slowdown =  ARMOR_SLOWDOWN_REPA * ARMOR_SLOWDOWN_GLOBAL_MULT
	can_deflect = FALSE
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	requires_training = FALSE
/obj/item/clothing/suit/armor/power_armor/fluff/arroyo
	name = "Weathered Deathclaw Power Armor"
	desc = "A suit of heavily customized Enclave 'Equalizer' Advanced power armor, modified extensively to be wearable by a aethergiest, not too unlike the suits worn by Frank Horrigan, and Captain Arlem, arm-blade and all. While it is indeed a genuine Mk. 1 set of Advanced power armor, it looks like it hasn't seen any maintenance in the better part of two decades. Much of its protection has eroded, but it remains functional with a myriad of ad-hoc bandaid repairs that would make a brotherhood scribe cry in anguish."
	icon_state = "arroyoapa"
	inhand_icon_state = "arroyoapa"

/obj/item/clothing/suit/armor/power_armor/fluff/pappavol
	name = "Decaying Power Armor"
	desc = "Large big and green with hints of rust that cover its decaying metal robotic frame. It looks like it was custom built... roughly put together with shitty welding and crude rivets that hold the green rusty armor together."
	icon_state = "pappavolarmor"
	inhand_icon_state = "pappavolarmor"

/obj/item/clothing/suit/armor/power_armor/t45b
	name = "Power Armor Exo-Skeleton"
	desc = "A set of power armor with the metallic outer workings removed, fit for any form of addition to make a proper set of power armor!"
	icon_state = "t45bpowerarmor"
	inhand_icon_state = "t45bpowerarmor"
	armor = ARMOR_VALUE_SALVAGE
	slowdown =  ARMOR_SLOWDOWN_REPA * ARMOR_SLOWDOWN_GLOBAL_MULT
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b
	deflect_power_mult = 80
	deflect_cooldown = 2 SECONDS
	can_deflect_while_blocking = FALSE

/obj/item/clothing/suit/armor/power_armor/t45b/debug_pa
	name = "Debug T-45b power armor"
	desc = "Its comfy and easy to wear!"
	requires_training = FALSE

/obj/item/clothing/suit/armor/power_armor/t45b/raider
	name = "powered scrap suit"
	desc = "A monumentously heavy suit of rusty metal and car parts. Either an actual power armor exoskeleton or some home-built substitute sits embedded under all that rust. Is this some attempt at power armor???"
	icon_state = "raiderpa"
	inhand_icon_state = "raiderpa"
	armor = ARMOR_VALUE_SALVAGE
	slowdown =  ARMOR_SLOWDOWN_REPA * ARMOR_SLOWDOWN_GLOBAL_MULT
	mutantrace_variation = STYLE_DIGITIGRADE
	salvaged_type = /obj/item/clothing/suit/armor/medium/raider/raidermetal

/obj/item/clothing/suit/armor/power_armor/t45b/hotrod
	name = "Refurbished T-45b Hotrod power armor"
	desc = "It's a set of T-45b power armor with a with some of its plating replaced by ablative, fire resistant armor. This set has exhaust pipes piped to the pauldrons, flames erupting from them."
	icon_state = "t45hotrod"
	inhand_icon_state = "t45hotrod"
	armor = ARMOR_VALUE_SALVAGE
	slowdown = ARMOR_SLOWDOWN_REPA * ARMOR_SLOWDOWN_GLOBAL_MULT
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/hotrod

/obj/item/clothing/suit/armor/power_armor/t45d
	name = "T-45d power armor"
	desc = "Originally developed and manufactured for the United States Army by American defense contractor West Tek, the T-45d power armor was the first version of power armor to be successfully deployed in battle."
	icon_state = "t45dpowerarmor"
	inhand_icon_state = "t45dpowerarmor"
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45d

/obj/item/clothing/suit/armor/power_armor/t45d/knightcaptain
	name = "Head-Knight's T-45d Power Armour"
	desc = "A classic set of T-45d Power Armour only to be used in armed combat, it signifies the Head Knight and their place in the Brotherhood. A leader, and a beacon of structure in a place where chaos reigns. All must rally to his call, for he is the Head Knight and your safety is his duty."
	icon_state = "t45dkc"
	inhand_icon_state = "t45dkc"

/obj/item/clothing/suit/armor/power_armor/t45d/bos
	name = "Brotherhood T-45d Power Armour"
	desc = "A suit of T-45d Power Armour adorned with the markings of the Brotherhood of Steel. Commonly used by the Paladins of the Brotherhood."
	icon_state = "t45dpowerarmor_bos"
	inhand_icon_state = "t45dpowerarmor_bos"

/obj/item/clothing/suit/armor/power_armor/t51b
	name = "T-51b power armor"
	desc = "The pinnacle of Pre-Fall technology. This suit of power armor provides substantial protection to the wearer."
	icon_state = "t51bpowerarmor"
	inhand_icon_state = "t51bpowerarmor"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 25)
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t51b

/obj/item/clothing/suit/armor/power_armor/t51b/pony
	name = "colorful T-51b power armor"
	desc = "The pinnacle of Pre-Fall technology. Someone's gone and painted a heart on the chest piece."
	icon = 'icons/obj/clothing/suits.dmi'
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	icon_state = "t51forpony"
	inhand_icon_state = "midwestpa"
	mutantrace_variation = null

/obj/item/clothing/suit/armor/power_armor/t51b/hardened
	name = "Hardened T-51b power armor"
	desc = "The pinnacle of Pre-Fall technology. This suit of power armor provides substantial protection to the wearer. It's plates have been chemially treated to be stronger."
	icon_state = "t51green"
	inhand_icon_state = "t51green"


/obj/item/clothing/suit/armor/power_armor/t51b/bos
	name = "Brotherhood T-51b Power Armour"
	desc = "The pinnacle of Pre-Fall technology, appropriated by the Brotherhood of Steel. Commonly worn by Head Paladins."
	icon_state = "t51bpowerarmor_bos"
	inhand_icon_state = "t51bpowerarmor_bos"

/obj/item/clothing/suit/armor/power_armor/excavator
	name = "excavator power armor"
	desc = "Developed by Garrahan Mining Co. in collaboration with West Tek, the Excavator-class power armor was designed to protect miners from rockfalls and airborne contaminants while increasing the speed at which they could work. "
	icon_state = "excavator"
	inhand_icon_state = "excavator"

/obj/item/clothing/suit/armor/power_armor/advanced
	name = "advanced power armor"
	desc = "An advanced suit of armor typically used by the Enclave.<br>It is composed of lightweight metal alloys, reinforced with ceramic castings at key stress points.<br>Additionally, like the T-51b power armor, it includes a recycling system that can convert human waste into drinkable water, and an air conditioning system for its user's comfort."
	icon_state = "advpowerarmor1"
	inhand_icon_state = "advpowerarmor1"

/obj/item/clothing/suit/armor/power_armor/hellfire // Event only - Deathsquad tier
	name = "Hellfire power armor"
	desc = "This model of power armor is the ultimate expression of power armor technology, sporting some of the best protection physically possible. This protection comes at a cost, however. This model of power armor drains cells much quicker than standard suits. While this design is technically a prototype, it has seen limited production similar to more standard suits. However, it remains incredibly rare due to the vast majority of the suits being damaged or destroyed."
	icon = 'icons/fallout/clothing/armored_power.dmi'
	mob_overlay_icon = 'icons/mob/clothing/suit.dmi'
	icon_state = "hellfire"
	inhand_icon_state = "hellfire"
	armor_tokens = null
	armor = list("melee" = 80, "bullet" = 85, "laser" = 90, "energy" = 75, "bomb" = 75, "bio" = 80, "rad" = 75, "fire" = 60, "acid" = 60, "wound" = 120, "damage_threshold" = 15)
	usage_cost = 15 // 3x the passive drain of normal PA, 11 minutes on a basic cell. Basically makes using e-guns with it impossible unless you have literal boxes of cells. But it's also Deathsquad tier armor so y'know.

//Peacekeeper armor adjust as needed
/obj/item/clothing/suit/armor/power_armor/advanced/x02
	name = "Enclave power armor"
	desc = "Upgraded Pre-Fall power armor design used by the Enclave. It is mildly worn due to it's age and lack of maintenance after the fall of the Enclave."
	icon_state = "advanced"
	inhand_icon_state = "advanced"
	salvaged_type = /obj/item/clothing/suit/armor/heavy/salvaged_pa/x02 // Oh the misery

/obj/item/clothing/suit/toggle/armor
	// body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	togglename = "collar"

// Toggle armor
/obj/item/clothing/suit/toggle/armored
	// body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	togglename = "collar"

// Recycled NCR Armor - all over the place in weight class so it goes in its own place

/obj/item/clothing/suit/armor/texaskevlar
	name = "post-fall militia vest"
	desc = "A slim kevlar vest with a brown, cloth covering. Originally modified by the First Texas Militia, these vests are now scattered across the wasteland since its fall."
	icon_state = "ncr_kelvar_vest"
	inhand_icon_state = "ncr_kelvar_vest"
	blood_overlay_type = "armor"
	dog_fashion = /datum/dog_fashion/back
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
	body_parts_hidden = CHEST

/obj/item/clothing/suit/armor/texaslight
	name = "post-fall militia armor"
	desc = "A light vest produced by the First Texas Militia over a century ago. Even now it still provides decent protection with minimal encumbrance."
	icon_state = "ncr_infantry_vest"
	inhand_icon_state = "ncr_infantry_vest"
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tier_desc = ARMOR_CLOTHING_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)
	stiffness = LIGHT_STIFFNESS

/obj/item/clothing/suit/armor/texaslight/mantle
	name = "mantled Texas militia armor"
	desc = "A light vest produced by the First Texas Militia over a century ago. This one has some cloth thrown over the shoulder."
	icon_state = "ncr_standard_mantle"
	inhand_icon_state = "ncr_standard_mantle"

/obj/item/clothing/suit/armor/texasmed
	name = "post-fall militia breastplate"
	desc = "A medium set of armor used by the First Texas Militia. While once famous for their effectiveness in the Battle of Round Rock, these days it's more known for being popular among caravaneers and salvagers."
	icon_state = "ncr_reinforced_vest"
	inhand_icon_state = "ncr_reinforced_vest"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T2 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_MEDIUM
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	stiffness = MEDIUM_STIFFNESS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/magpouch
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/armor/texasmed/infiltrator
	name = "infiltrator combat vest"
	desc = "An insidious combat vest designed for covert operations using kevlar nanofibers to absorb the supreme majority of kinetic blows. Although it doesn't look like it'll do too much for energy impacts."
	icon_state = "infiltrator"
	inhand_icon_state = "infiltrator"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/armor/texasmed/infiltrator/contractor
	name = "contractor combat suit"
	desc = "An suspicious looking combat suit designed for covert operations using kevlar nanofibers to absorb the supreme majority of kinetic blows. Although it doesn't look like it'll do too much for energy impacts."
	icon_state = "syndicate-contract"
	inhand_icon_state = "syndicate-contract"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/armor/texasmed/infiltrator/contractor/CtrlShiftClick(mob/user)
	var/static/list/choices = list(
			"Black" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black"),
			"Green Stripe" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-green"),
			"Orange Stripe" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-orange"),
			"Blue Stripe" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-blue"),
			"Red Stripe" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-red"),
			"Medic Marks" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-med"),
			"Engi Marks" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-black-engie"),
			"Contractor" = image(icon = 'icons/mob/clothing/suit.dmi', icon_state = "syndicate-contract"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 32, require_near = TRUE)
	switch(choice)
		if("Black")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black"
			inhand_icon_state = "syndicate-black"
		if("Green Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-green"
			inhand_icon_state = "syndicate-black-green"
		if("Orange Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-orange"
			inhand_icon_state = "syndicate-black-orange"
		if("Blue Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-blue"
			inhand_icon_state = "syndicate-black-blue"
		if("Red Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-red"
			inhand_icon_state = "syndicate-black-red"
		if("Medic Marks")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-med"
			inhand_icon_state = "syndicate-black-med"
		if("Engi Marks")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-black-engie"
			inhand_icon_state = "syndicate-black-engie"
		if("Contractor")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-contract"
			inhand_icon_state = "syndicate-contract"
		else
			return

/obj/item/clothing/suit/armor/texasmed/mantle
	name = "mantled Texas militia breastplate"
	desc = "A medium set of armor used by the First Texas Militia. This one has some cloth thrown over the shoulder."
	icon_state = "ncr_reinforced_mantle"
	inhand_icon_state = "ncr_reinforced_mantle"

/obj/item/clothing/suit/armor/heavy/texasheavy
	name = "heavy Texas militia armor"
	desc = "Some of the heaviest armor the First Texas Militia ever fielded. It remains unpopular centuries later for its bulk and heat, though some still swear by its protective capabilities."
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)
	mutantrace_variation = 	STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	icon_state = "ncr_lt_armour"
	inhand_icon_state = "ncr_lt_armour"

/obj/item/clothing/suit/armor/heavy/texasheavy/mantle
	name = "mantled heavy Texas militia armor"
	desc = "Some of the heaviest armor the First Texas Militia ever fielded. Some madman has thrown a heavy, cloth mantle over one shoulder making the already hot armor even warmer."
	icon_state = "ncr_lt_armour_mantle"
	inhand_icon_state = "ncr_lt_armour_mantle"

//Biosuit complete with shoes (in the item sprite)
/obj/item/clothing/head/bio_hood
	name = "bio hood"
	icon_state = "bio"
	desc = "A hood that protects the head and face from biological contaminants."
	permeability_coefficient = 0.01
	clothing_flags = THICKMATERIAL | BLOCK_GAS_SMOKE_EFFECT
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE|HIDESNOUT
	resistance_flags = ACID_PROOF
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	mutantrace_variation = STYLE_MUZZLE
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T4)

/obj/item/clothing/suit/bio_suit
	name = "bio suit"
	desc = "A suit that protects against biological contamination."
	icon_state = "bio"
	inhand_icon_state = "bio_suit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	clothing_flags = THICKMATERIAL
	// body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETAUR
	strip_delay = 70
	equip_delay_other = 70
	resistance_flags = ACID_PROOF
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T4)

/obj/item/clothing/suit/bio_suit/enclave
	name = "enclave envirosuit"
	desc = "An advanced white and airtight environmental suit. It seems to be equipped with a fire-resistant seal, enhanced armor inserts, and a refitted internals system. Designed and produced exclusively by the Enclave post-war, it's probably not a good idea to be seen wearing this."
	icon_state = "envirosuit"
	inhand_icon_state = "envirosuit"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	clothing_flags = THICKMATERIAL
	strip_delay = 60
	equip_delay_other = 60
	flags_inv = HIDEJUMPSUIT
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_ENV_T4)

//Standard biosuit, orange stripe
/obj/item/clothing/head/bio_hood/general
	icon_state = "bio_general"

/obj/item/clothing/suit/bio_suit/general
	icon_state = "bio_general"


//Virology biosuit, green stripe
/obj/item/clothing/head/bio_hood/virology
	icon_state = "bio_virology"

/obj/item/clothing/suit/bio_suit/virology
	icon_state = "bio_virology"


//Security biosuit, grey with red stripe across the chest || Craftable, has good ballistic/laser armor, but not good against melee. It's a light armor, use that speed dummy -Kelprunner
/obj/item/clothing/head/bio_hood/security
	name = "reinforced hazard hood"
	desc = "A lead-lined hood that's been reinforced with a kevlar weave."
	icon_state = "bio_security"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_DT_T3)

/obj/item/clothing/suit/bio_suit/security
	name = "reinforced hazard suit"
	desc = "A CBRN hazard suit that's been paired with a ballistic vest. Surprisingly lightweight for all of its bulk."
	icon_state = "bio_security"
	w_class = WEIGHT_CLASS_NORMAL
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_DT_T3)

//Janitor's biosuit, grey with purple arms
/obj/item/clothing/head/bio_hood/janitor
	icon_state = "bio_janitor"

/obj/item/clothing/suit/bio_suit/janitor
	icon_state = "bio_janitor"


//Scientist's biosuit, white with a pink-ish hue
/obj/item/clothing/head/bio_hood/scientist
	icon_state = "bio_scientist"

/obj/item/clothing/suit/bio_suit/scientist
	icon_state = "bio_scientist"


//CMO's biosuit, blue stripe
/obj/item/clothing/suit/bio_suit/cmo
	icon_state = "bio_cmo"

/obj/item/clothing/head/bio_hood/cmo
	icon_state = "bio_cmo"


//Plague Dr mask can be found in clothing/masks/gasmask.dm
/obj/item/clothing/suit/bio_suit/plaguedoctorsuit
	name = "plague doctor suit"
	desc = "It protected doctors from the Black Death, back then. You bet your arse it's gonna help you against viruses."
	icon_state = "plaguedoctor"
	inhand_icon_state = "bio_suit"
	strip_delay = 40
	equip_delay_other = 20

/obj/item/clothing/suit/bio_suit/hazmat
	name = "hazmat suit"
	desc = "(Yellow Level A , hazmat protective suit.<br>You can see some numbers on the tag: 35 56."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "hazmat"
	inhand_icon_state = "hazmat"

/obj/item/clothing/head/bio_hood/hazmat
	name = "hazmat hood"
	desc = "My star, my perfect silence."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hazmat"
	inhand_icon_state = "hazmat_helmet"

// Magic armors - bizarre stats, don't fit into normal categories? Probably will need tweaking down the line.

/obj/item/clothing/suit/armor/outfit/vest/utility/magicarmor
	name = "talisman of protection"
	desc = "A talisman made of magically charged titanium and set with a gleaming fragment of gold. This will protect the wearer from all attacks equally, but the enchantment prevents the wearing of proper armor."
	w_class = WEIGHT_CLASS_TINY
	max_integrity = 500
	icon_state = "protamulet"
	pocket_storage_component_path = null
	slowdown = ARMOR_SLOWDOWN_LIGHT * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor = list("linemelee" = 0, "linebullet" = 0, "linelaser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0, "wound" = 10, "damage_threshold" = 10)
	armor_tier_desc = ARMOR_CLOTHING_LIGHT

/obj/item/clothing/suit/armor/outfit/vest/utility/magicarmor/hazard
	name = "talisman of cleansing"
	desc = "A talisman made of magically charged titanium and set with a humming shard of plasma. This will protect the wearer from hazards like radiation and acid, but offers no protection from more mundane threats."
	icon_state = "hazardamulet"
	armor = list("linemelee" = 0, "linebullet" = 0, "linelaser" = 0, "energy" = 50, "bomb" = 0, "bio" = 75, "rad" = 90, "fire" = 75, "acid" = 75, "wound" = 0, "damage_threshold" = 0)
	armor_tier_desc = ARMOR_CLOTHING_DESC
