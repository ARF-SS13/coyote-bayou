/obj/item/clothing/gloves/f13
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 10, bomb = 10, bio = 10, rad = 10, fire = 10, acid = 10)

/obj/item/clothing/gloves/f13/baseball
	name = "baseball glove"
	desc = "A large leather glove worn by baseball players of the defending team which assists them in catching and fielding balls hit by a batter or thrown by a teammate."
	icon_state = "baseball"
	item_state = "b_shoes"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/f13/leather
	name = "leather gloves"
	desc = "Gloves made of wasteland animals hides, that were tanned and carefully stiched together."
	icon_state = "leather"
	item_state = "leather"
	item_color = null
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
	item_state = "ncr_gloves"
	transfer_prints = TRUE
	heat_protection = null
	max_heat_protection_temperature = null

/obj/item/clothing/gloves/f13/military
	name = "military gloves"
	desc = "Tight fitting black leather gloves with mesh along the finger tips and padding along the palm. The craftsmanship indicates it was made for a officer."
	icon_state = "military"
	item_state = "military"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/f13/doom
	name = "strange gloves"
	desc = "These gloves look like a part of some sort of space suit, or maybe exquisite armor, but you can't tell for sure."
	icon_state = "doom"
	item_state = "doom"
	item_color = null
	transfer_prints = TRUE
	strip_delay = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	armor = list(melee = 10, bullet = 10, laser = 10, energy = 10, bomb = 10, bio = 80, rad = 80, fire = 80, acid = 50)

/obj/item/clothing/gloves/f13/handwraps
	name = "handwraps"
	desc = "A roll of cloth to roll around one's palms, provides only minimal effectiveness."
	icon_state = "handwraps"
	item_state = "handwraps"
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
	item_state = "lacegloves"
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
	item_state = "opifex_gloves"
	item_color = null
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
	item_state = "offwhite"
	siemens_coefficient = 0.5
	permeability_coefficient = 0.1

/obj/item/clothing/gloves/f13/mutant
	name = "mutant bracers"
	desc = "(IV) A pair of metal tubes with rope on the inside."
	icon_state = "mutie_bracer"
	item_state = "mutie_bracer"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/gloves/f13/mutant/mk2
	name = "mutant bracers"
	desc = "(IV) A pair of giant metal tubes with rope on the inside."
	icon_state = "mutie_bracer_mk2"
	item_state = "mutie_bracer_mk2"

/obj/item/clothing/gloves/f13/mutant/sign
	name = "mutant sign bracers"
	desc = "(IV) See this sign? It's a sign to move on."
	icon_state = "mutie_bracer_sign"
	item_state = "mutie_bracer_sign"

//////////
//LEGION//
//////////

/obj/item/clothing/gloves/legion
	name = "leather gloves"
	desc = "Fingerless leather gloves to improve grip worn by legionaires."
	icon = 'icons/fallout/objects/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/hands.dmi'
	icon_state = "legion-fingerless"
	item_state = "legion-fingerless"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/legion/forgemaster
	name = "forgemaster gloves"
	desc = "A pair of heavy duty leather gloves designed to help the Forgemaster do his work."
	icon_state = "legion-forge"
	item_state = "legion-forge"
	item_color = null
	transfer_prints = FALSE
	strip_delay = 10
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT

/obj/item/clothing/gloves/legion/plated
	name = "plated gloves"
	desc = "Leather gloves with metal reinforcement."
	icon_state = "legion-plated"
	item_state = "legion-plated"
	transfer_prints = FALSE
	armor = list("melee" = 20, "bullet" = 15, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 10, "fire" = 10, "acid" = 10)

/obj/item/clothing/gloves/legion/legate
	name = "brass gauntlets"
	desc = "Heavy finely crafted metal gloves."
	icon_state = "legion-legate"
	item_state = "legion-legate"
	transfer_prints = FALSE
	armor = list("melee" = 25, "bullet" = 25, "laser" = 35, "energy" = 20, "bomb" = 35, "bio" = 35, "rad" = 35, "fire" = 0, "acid" = 0)
