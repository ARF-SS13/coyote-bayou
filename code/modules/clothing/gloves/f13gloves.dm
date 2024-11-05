/obj/item/clothing/gloves/f13
	armor = ARMOR_VALUE_CLOTHES

/obj/item/clothing/gloves/f13/baseball
	name = "baseball glove"
	desc = "A large leather glove worn by baseball players of the defending team which assists them in catching and fielding balls hit by a batter or thrown by a teammate."
	icon_state = "baseball"
	inhand_icon_state = "b_shoes"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/f13/leather
	name = "leather gloves"
	desc = "Gloves made of wasteland animals hides, that were tanned and carefully stiched together."
	icon = 'icons/fallout/clothing/gloves.dmi'
	icon_state = "leather"
	inhand_icon_state = "leather"
	item_color = null
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T3, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_DOWN_ENV_T3)
	transfer_prints = FALSE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/leather/fingerless
	name = "fingerless leather gloves"
	desc = "Gloves made out of wasteland animal hides, tanned and stitched together without any fingers."
	icon_state = "ncr_gloves"
	inhand_icon_state = "ncr_gloves"
	transfer_prints = TRUE
	heat_protection = null
	max_heat_protection_temperature = null

/obj/item/clothing/gloves/f13/military
	name = "military gloves"
	desc = "Tight fitting black leather gloves with mesh along the finger tips and padding along the palm, designed for use by the U.S. Army before the Great War."
	icon_state = "military"
	inhand_icon_state = "military"
	item_color = null
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T3, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_ENV_T2)
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/military/engineer
	name = "military engineering gloves"
	desc = "Sleek, black leather gloves issued by the U.S. Army centuries ago. They have an extra layer to help protect the wearer from both burns and electrical shocks."
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_FIRE_T1)

/obj/item/clothing/gloves/f13/doom
	name = "strange gloves"
	desc = "These gloves look like a part of some sort of space suit, or maybe exquisite armor, but you can't tell for sure."
	icon_state = "doom"
	inhand_icon_state = "doom"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/handwraps
	name = "handwraps"
	desc = "A roll of cloth to roll around one's palms, provides only minimal effectiveness."
	icon_state = "handwraps"
	inhand_icon_state = "handwraps"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/lace
	name = "lace gloves"
	desc = "A tight, seethrough pair of black gloves, designed to be worn with something fancy."
	icon_state = "lacegloves"
	inhand_icon_state = "lacegloves"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/blacksmith
	name = "blacksmith gloves"
	desc = "A pair of heavy duty leather gloves designed to protect the wearer when metalforging."
	icon_state = "opifex_gloves"
	inhand_icon_state = "opifex_gloves"
	item_color = null
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T3, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_DOWN_ENV_T3)
	transfer_prints = FALSE
	strip_delay = 10
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/crudemedical
	name = "crude medical gloves"
	desc = "Cotton gloves waxed to prevent the blood from soaking through immediatly. Better than nothing."
	icon_state = "offwhite"
	inhand_icon_state = "offwhite"
	siemens_coefficient = 0.5
	permeability_coefficient = 0.1

/obj/item/clothing/gloves/f13/mutant
	name = "mutant bracers"
	desc = "A pair of metal tubes with rope on the inside."
	icon_state = "mutie_bracer"
	inhand_icon_state = "mutie_bracer"
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/gloves/f13/mutant/mk2
	name = "mutant bracers"
	desc = "A pair of giant metal tubes with rope on the inside."
	icon_state = "mutie_bracer_mk2"
	inhand_icon_state = "mutie_bracer_mk2"

/obj/item/clothing/gloves/f13/mutant/sign
	name = "mutant sign bracers"
	desc = "See this sign? It's a sign to move on."
	icon_state = "mutie_bracer_sign"
	inhand_icon_state = "mutie_bracer_sign"

/obj/item/clothing/gloves/botanic_leather
	name = "farmers gloves"
	desc = "These thick leather gloves protect against thorns, barbs, prickles, spikes and other harmful objects of floral origin.  They're also quite warm."
	icon = 'icons/fallout/clothing/gloves.dmi'
	icon_state = "farmer"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/hand.dmi'
	inhand_icon_state = "farmer"
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	strip_mod = 0.9


//////////
//LEGION//
//////////

/obj/item/clothing/gloves/legion
	name = "leather gloves"
	desc = "Fingerless leather gloves to improve grip."
	icon = 'icons/fallout/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/hand.dmi'
	icon_state = "legion_fingerless"
	inhand_icon_state = "legion_fingerless"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/gloves/legion/forgemaster
	name = "forgemaster gloves"
	desc = "A pair of heavy duty leather gloves designed to help a forgemaster do their work."
	icon_state = "legion_forge"
	inhand_icon_state = "legion_forge"
	item_color = null
	transfer_prints = FALSE
	strip_delay = 10
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/legion/plated
	name = "plated gloves"
	desc = "Leather gloves with metal reinforcement."
	icon_state = "legion_plated"
	inhand_icon_state = "legion_plated"
	transfer_prints = FALSE
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/gloves/legion/legate
	name = "brass gauntlets"
	desc = "Heavy finely crafted metal gloves."
	icon_state = "legion_legate"
	inhand_icon_state = "legion_legate"
	transfer_prints = FALSE
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)
