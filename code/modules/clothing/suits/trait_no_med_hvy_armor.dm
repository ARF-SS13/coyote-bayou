//-->Armor Aversion trait is here
#define ARMOR_AVERSION_THRESHOLD_MEDIUM ARMOR_CLOTHING_MEDIUM
#define ARMOR_AVERSION_THRESHOLD_HEAVY ARMOR_CLOTHING_HEAVY
#define ARMOR_AVERSION_THRESHOLD_SALAVAGE ARMOR_CLOTHING_SALVAGE
#define ARMOR_AVERSION_THRESHOLD_PA ARMOR_CLOTHING_PA

//-->can the human equip this?
/obj/item/clothing/suit/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR))
			if(armor_tier_desc in list(ARMOR_AVERSION_THRESHOLD_MEDIUM,ARMOR_AVERSION_THRESHOLD_MEDIUM,
			ARMOR_AVERSION_THRESHOLD_SALAVAGE, ARMOR_AVERSION_THRESHOLD_PA))

				to_chat(M, span_danger("You can't wear this armour, it's too heavy!"))
				return FALSE

