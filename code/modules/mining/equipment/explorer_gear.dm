/****************Explorer's Suit and Mask****************/
/obj/item/clothing/suit/hooded/explorer
	name = "wasteland explorer suit"
	desc = "Originally a standard set of Combat Armor, this suit has been heavily modified to protect the wearer from radiation. Unfortunately, this means the ballistic and laser-resistant armor plates had to be stripped out."
	icon_state = "explorer"
	inhand_icon_state = "explorer"
	w_class = WEIGHT_CLASS_NORMAL
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	cold_protection = CHEST|GROIN|LEGS|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	hoodtype = /obj/item/clothing/head/hooded/explorer
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_DT_T2)
	flags_inv = HIDEJUMPSUIT
	resistance_flags = FIRE_PROOF
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	strip_delay = 60
	equip_delay_other = 60

/obj/item/clothing/head/hooded/explorer
	name = "explorer hood"
	desc = "An armoured hood for exploring harsh environments. Useless without a mask to go with it."
	icon_state = "explorer"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	cold_protection = HEAD
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_DT_T2)
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/mask/gas/explorer
	name = "explorer gas mask"
	desc = "A military-grade gas mask. This one has been meticulously restored to its former glory."
	icon_state = "gas_mining"
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | ALLOWINTERNALS
	visor_flags_inv = HIDEFACIALHAIR
	visor_flags_cover = MASKCOVERSMOUTH
	actions_types = list(/datum/action/item_action/adjust)
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T4)
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/gas/explorer/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/gas/explorer/adjustmask(user)
	..()
	w_class = mask_adjusted ? WEIGHT_CLASS_NORMAL : WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/gas/explorer/folded/Initialize()
	. = ..()
	adjustmask()

/obj/item/clothing/suit/space/hostile_environment
	name = "H.E.C.K. suit"
	desc = "Hostile Environment Cross-Kinetic Suit: A suit designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	inhand_icon_state = "hostile_env"
	clothing_flags = THICKMATERIAL //not spaceproof
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | LAVA_PROOF | ACID_PROOF | GOLIATH_RESISTANCE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC
	slowdown = 0
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/space/hostile_environment/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/space/hostile_environment/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/space/hostile_environment/process()
	var/mob/living/carbon/C = loc
	if(istype(C) && prob(2)) //cursed by bubblegum
		if(prob(15))
			new /datum/hallucination/oh_yeah(C)
			to_chat(C, "<span class='colossus'><b>[pick("I AM IMMORTAL.","I SHALL TAKE BACK WHAT'S MINE.","I SEE YOU.","YOU CANNOT ESCAPE ME FOREVER.","DEATH CANNOT HOLD ME.")]</b></span>")
		else
			to_chat(C, span_warning("[pick("You hear faint whispers.","You smell ash.","You feel hot.","You hear a roar in the distance.")]"))

/obj/item/clothing/head/helmet/space/hostile_environment
	name = "H.E.C.K. helmet"
	desc = "Hostile Environiment Cross-Kinetic Helmet: A helmet designed to withstand the wide variety of hazards from Lavaland. It wasn't enough for its last owner."
	icon_state = "hostile_env"
	inhand_icon_state = "hostile_env"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	clothing_flags = THICKMATERIAL // no space protection
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	resistance_flags = FIRE_PROOF | LAVA_PROOF

/obj/item/clothing/head/helmet/space/hostile_environment/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	update_icon()


/obj/item/clothing/head/helmet/space/hostile_environment/update_overlays()
	. = ..()
	var/mutable_appearance/glass_overlay = mutable_appearance(icon, "hostile_env_glass")
	glass_overlay.appearance_flags = RESET_COLOR
	. += glass_overlay

/obj/item/clothing/head/helmet/space/hostile_environment/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/head.dmi', "hostile_env_glass")
		M.appearance_flags = RESET_COLOR
		. += M


// CITADEL ADDITIONS BELOW

/****************SEVA Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/seva
	name = "SEVA environmental suit"
	desc = "The product of combining a radiation suit and a ballistic vest, the SEVA provides excellent environmental and ballistic protection. Just don't get stabbed. Or stand in front of a laser."
	icon_state = "seva"
	inhand_icon_state = "seva"
	w_class = WEIGHT_CLASS_NORMAL
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/seva
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_DT_T2)
	resistance_flags = FIRE_PROOF | GOLIATH_WEAKNESS
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	strip_delay = 60
	equip_delay_other = 60
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5

/obj/item/clothing/head/hooded/explorer/seva
	name = "SEVA hood"
	desc = "A lead and ballistic weave lined hood. Needs a gas mask to protect the wearer from radiation."
	icon_state = "seva"
	inhand_icon_state = "seva"
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T4, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_DT_T2)
	resistance_flags = FIRE_PROOF | GOLIATH_WEAKNESS
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	strip_delay = 60
	equip_delay_other = 60

/obj/item/clothing/mask/gas/seva
	name = "SEVA Mask"
	desc = "A face-covering plate that can be connected to an air supply. Intended for use with the SEVA Suit."
	icon_state = "seva"
	inhand_icon_state = "seva"
	resistance_flags = FIRE_PROOF

/****************Exo-Suit and Mask****************/

/obj/item/clothing/suit/hooded/explorer/exo
	name = "Exo-suit"
	desc = "A robust suit for fighting dangerous animals. Its design and material make it harder for a Goliath to keep their grip on the wearer."
	icon_state = "exo"
	inhand_icon_state = "exo"
	w_class = WEIGHT_CLASS_BULKY
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	hoodtype = /obj/item/clothing/head/hooded/explorer/exo
	armor = ARMOR_VALUE_MEDIUM
	resistance_flags = FIRE_PROOF | GOLIATH_RESISTANCE

/obj/item/clothing/head/hooded/explorer/exo
	name = "Exo-hood"
	desc = "A robust helmet for fighting dangerous animals. Its design and material make it harder for a Goliath to keep their grip on the wearer."
	icon_state = "exo"
	inhand_icon_state = "exo"
	armor = ARMOR_VALUE_MEDIUM
	resistance_flags = FIRE_PROOF | GOLIATH_RESISTANCE

/obj/item/clothing/mask/gas/exo
	name = "Exosuit Mask"
	desc = "A face-covering mask that can be connected to an air supply. Intended for use with the Exosuit."
	icon_state = "exo"
	inhand_icon_state = "exo"
	resistance_flags = FIRE_PROOF
