//Fallout 13 shoes directory
/*
/obj/item/clothing/shoes
	var/stepsound = TRUE
*/
/obj/item/clothing/shoes/f13
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	mutantrace_variation = NONE // Temporal fix until digitigrade-adapted sprites are done mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/enclave/serviceboots
	name = "enclave service boots"
	desc = "Tall shiny boots with kevlar layers."
	icon_state = "boots_enclave"
	item_state = "boots_enclave"

/obj/item/clothing/shoes/f13/rag
	name = "footcloths"
	desc = "Ripped cloth used as improvised foot strips, instead of shoes. Crude and gets dirty fast."
	icon_state = "rag"
	item_state = "rag"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/rag/pawb
	name = "tough feet"
	desc = "For one reason or another your feet are too tough to need shoes. Or maybe you're just very agile. Who knows."
	icon_state = "pawb" //uwu//
	item_state = "pawb"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_tied	= FALSE
	rad_flags = RAD_NO_CONTAMINATE
	item_flags = ABSTRACT

/obj/item/clothing/shoes/f13/rag/pawb/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, FEET_REPLACEMENT_TRAIT)

/obj/item/clothing/shoes/f13/tan
	name = "tan shoes"
	desc = "A pair of tanned leather shoes."
	icon_state = "tan"
	item_state = "tan"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/ninja
	name = "ninja shoes"
	desc = "A pair of running shoes. Excellent for running and even better for smashing skulls."
	icon_state = "s-ninja"
	icon_state = "s-ninja"

/obj/item/clothing/shoes/f13/brownie //Make a craft recipe, and delete this comment.
	name = "brown shoes"
	desc = "A pair of brown leather shoes made of wasteland animals hides."
	icon_state = "brownie"
	item_state = "brownie"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/fancy
	name = "black shoes"
	desc = "A pair of fancy black shoes." //Nice shoes!
	icon_state = "fancy"
	item_state = "fancy"

/obj/item/clothing/shoes/f13/cowboy
	name = "cowboy boots"
	desc = "A pair of cowhide boots with spurs.<br>They have a Cuban heel, rounded to pointed toe, high shaft, and, traditionally, no lacing."
	icon_state = "cowboy"
	item_state = "cowboy"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/explorer
	name = "worn boots"
	desc = "A pair of slightly worn, steel-toed work boots.<br>Good at keeping toes safe from falling junk you find amid the ruins."
	icon_state = "explorer"
	armor = ARMOR_VALUE_LIGHT
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/raidertreads
	name = "raider treads"
	desc = "A decrepit boot on one foot, fuckall on the other, the height of raider fashion."
	icon_state = "raidertreads"
	item_state = "raidertreads"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/diesel
	name = "male diesel boots"
	desc = "Fancy mens' steel-toed boots."
	icon_state = "diesel_m"
	item_state = "diesel_m"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/diesel/alt
	name = "female diesel boots"
	desc = "Fancy womens' knee-high platform boots with shiny steel clasps."
	icon_state = "diesel_f"
	item_state = "diesel_f"

/obj/item/clothing/shoes/f13/military
	name = "military boots"
	desc = "High speed, no-drag combat boots, designed for use by the U.S. Army before the Great War."
	icon_state = "military"
	item_state = "military"
	permeability_coefficient = 0.05
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T3, ARMOR_MODIFIER_DOWN_LASER_T1)
	strip_delay = 40
	resistance_flags = NONE
	can_be_tied = FALSE
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/shoes
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/military/leather
	name = "leather combat boots"
	desc = "A pair of laced, heavy-duty leather boots designed for hard combat."
	icon_state = "laced"
	item_state = "laced"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/shoes/f13/military/desert
	name = "desert combat boots"
	desc = "An old pair of desert combat boots. This one seems to have a tighter fit, and a padded interior."
	icon_state = "laced"
	item_state = "erin_boot"

///// "NCR" boots below

/obj/item/clothing/shoes/f13/military/ncr
	name = "patrol boots"
	desc = "A pair of standard issue brown boots, with a puttee."
	icon_state = "ncr_boots"
	item_state = "ncr"

/obj/item/clothing/shoes/f13/military/ncr_officer_boots
	name = "officer boots"
	desc = "A pair of well-polished brown leather calf boots fitted with straps."
	icon_state = "ncr_officer_boots"
	item_state = "ncr_officer_boots"


//// "Legion" Stuff below

/obj/item/clothing/shoes/roman
	name = "roman sandals"
	desc = "Sandals with buckled leather straps on it."
	icon = 'icons/fallout/clothing/shoes.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/shoe.dmi'
	icon_state = "legion_sandals"
	item_state = "legion_sandals"
	strip_delay = 100
	equip_delay_other = 100
	permeability_coefficient = 0.9
	can_be_tied = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/peltboots
	name = "pelt boots"
	desc = "These boots are made from tanned hide and lined with soft long horner wool. A fashion from wealthy tribes that has spread. "
	icon = 'icons/fallout/clothing/shoes.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/shoe.dmi'
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_DOWN_BULLET_T3)
	icon_state = "legion_pelt"
	item_state = "legion_pelt"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/shoes/f13/military/legion
	name = "rough leather boots"
	desc = "A pair of crudely made leather boots, followng the standardized pattern laid down according to the wisdom of Caesar."
	icon = 'icons/fallout/clothing/shoes.dmi'
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_DOWN_BULLET_T3)
	mob_overlay_icon = 'icons/fallout/onmob/clothes/shoe.dmi'
	icon_state = "legion_leather"
	item_state = "legion_leather"

/obj/item/clothing/shoes/f13/military/plated
	name = "plated war boots"
	desc = "A pair of leather boots reinforced with hardened toe caps and shin guards, usually recycled old workboot steel caps taken from rotted old boots and glued to new ones."
	icon = 'icons/fallout/clothing/shoes.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/shoe.dmi'
	icon_state = "legion_war"
	item_state = "legion_war"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/shoes/f13/military/legate
	name = "heavy metal boots"
	desc = "A pair of heavy leather boots with bronzed metal leg guards added. Heavy, and uncomfy.."
	icon = 'icons/fallout/clothing/shoes.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/shoe.dmi'
	icon_state = "legion_legate"
	item_state = "legion_legate"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T3 )

// ---------------------------------------------------------
// Great Khan boots

/obj/item/clothing/shoes/f13/military/khan
	name = "steel-tipped boots"
	desc = "A pair of leather boots reinforced with metal toe caps. The shin guards can be removed easily (alt-click)."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_boots"
	item_state = "khan_boots"
	var/boottoggled = FALSE

/obj/item/clothing/shoes/f13/military/khan/Goji
	name = "steel-tipped Snakeskin Loafers"
	desc = "A pair of Snakeskin Loafers reinforced with metal toe caps."
	icon = 'icons/fallout/clothing/khans.dmi'
	icon_state = "Gojishoes"
	item_state = "Gojishoes"

/obj/item/clothing/shoes/f13/military/khan/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	boot_toggle(user)
	return TRUE

/obj/item/clothing/shoes/f13/military/khan/ui_action_click()
	boot_toggle()

/obj/item/clothing/shoes/f13/military/khan/proc/boot_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You mess around with the shin guards."))
	if(src.boottoggled)
		src.icon_state = "[initial(icon_state)]"
		src.item_state = "[initial(icon_state)]"
		src.boottoggled = FALSE
	else if(!src.boottoggled)
		src.icon_state = "[initial(icon_state)]_t"
		src.item_state = "[initial(icon_state)]_t"
		src.boottoggled = TRUE
	usr.update_inv_shoes()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()


/obj/item/clothing/shoes/f13/military/khan_pelt
	name = "tall pelt boots"
	desc = "A pair of soft pelt boots with fur lining."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_peltboots"
	item_state = "khan_peltboots"

///// End of "khans"

/obj/item/clothing/shoes/f13/military/duty
	name = "duty boots"
	desc = "A pair of laced old combat boots used by Pre-Fall riot police. These have a very shining front as if they were made from rubber. (can be reskinned by alt clicking once)"
	icon_state = "duty"
	item_state = "duty"
	reskinnable_component = /datum/component/reskinnable/khan_boots

/obj/item/clothing/shoes/f13/military/patrol
	name = "patrol boots"
	desc = "A pair of hardened leather boots made for combat."
	icon_state = "patrol"
	item_state = "patrol"

//Fluff

/obj/item/clothing/shoes/f13/swimfins
	name = "swimming fins"
	desc = "You see, Ivan, when you wear fin in desert, they help you swim good if you find much water."
	icon_state = "flippers"
	item_state = "flippers"
	clothing_flags = NOSLIP

/obj/item/clothing/shoes/f13/moon
	name = "moon boots"
	desc = "These boots are constructed with a thin rubber exterior and cellular rubber midsole covered by colorful nylon fabrics and using polyurethane foams.<br>To the Moon!"
	icon_state = "moon"
	item_state = "moon"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	clothing_flags = NOSLIP

/obj/item/clothing/shoes/f13/doom
	name = "mars boots"
	desc = "These boots are constructed with a titanium alloy. There are some runes engraved on the side.<br>To Mars!"
	icon_state = "mars"
	item_state = "mars"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	clothing_flags = NOSLIP

/obj/item/clothing/shoes/f13/miner
	name = "mining boots"
	desc = "Heavy-duty work boots with steel-reinforced toes and some fluffy wool for extra warmth."
	icon_state = "miner"
	item_state = "miner"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/f13/jamrock
	name = "Green Snakeskin Shoes"
	desc = "They may have lost some of their lustre over the years, but these green crocodile leather shoes fit you perfectly."
	icon_state = "jamrock_skins"
	item_state = "jamrock_skins"
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT

/obj/item/clothing/shoes/f13/mutie
	name = "super mutant sandals"
	desc = "A pair of oversized sandals, likely designed for super mutants."
	icon_state = "mutie_sandals"

/obj/item/clothing/shoes/f13/mutie/boots
	name = "super mutant boots"
	desc = "A pair of oversized boots."
	icon_state = "mutie_boots"
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1)
	cold_protection = FEET

/obj/item/clothing/shoes/f13/mutie/boots/dark
	icon_state = "mutie_boots_dark"
	icon_state = "mutie_boots_dark"

/obj/item/clothing/shoes/f13/mutie/boots/ncr
	icon_state = "mutie_boots_ncr"
	icon_state = "mutie_boots_ncr"

/obj/item/clothing/shoes/f13/mutie/boots/ncr/ranger
	icon_state = "mutie_boots_ranger"
	icon_state = "mutie_boots_ranger"

/obj/item/clothing/shoes/f13/tribal_sandals
	icon_state = "tribaltreads"
	icon_state = "tribaltreads"
