//-->Armor Aversion trait is here
#define ARMOR_AVERSION_THRESHOLD_MELEE 	35
#define ARMOR_AVERSION_THRESHOLD_BULLET 35
#define ARMOR_AVERSION_THRESHOLD_LASER 	35
#define ARMOR_AVERSION_THRESHOLD_THRES	2
// IF YOU UPDATE THESE VALUES, UPDATE THE DESCRIPTION OF /datum/quirk/armor_aversion


//-->can the human equip this?
/obj/item/clothing/suit/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR))
			if( armor.melee		> (ARMOR_AVERSION_THRESHOLD_MELEE) || \
				armor.bullet	> (ARMOR_AVERSION_THRESHOLD_BULLET) || \
				armor.laser		> (ARMOR_AVERSION_THRESHOLD_LASER) || \
				armor.damage_threshold > (ARMOR_AVERSION_THRESHOLD_THRES))

				to_chat(M, span_danger("You can't wear this armour, it's too heavy!"))
				return FALSE

