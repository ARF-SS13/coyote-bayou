//-->Armor Aversion trait is here
//-->can the human equip this?
/obj/item/clothing/suit/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE, clothing_check = FALSE, list/return_warning)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(HAS_TRAIT(H, TRAIT_NO_MED_HVY_ARMOR))
			if( armor.linemelee  		> ARMOR_VALUE_LIGHT["linemelee"] || \
				armor.linebullet  		> ARMOR_VALUE_LIGHT["linebullet"] || \
				armor.linelaser  		> ARMOR_VALUE_LIGHT["linelaser"] || \
				armor.energy  			> ARMOR_VALUE_LIGHT["energy"] || \
				armor.bomb  			> ARMOR_VALUE_LIGHT["bomb"] || \
				armor.magic 			> ARMOR_VALUE_LIGHT["magic"] || \
				armor.wound  			> ARMOR_VALUE_LIGHT["wound"] || \
				armor.damage_threshold	> ARMOR_VALUE_LIGHT["damage_threshold"])

				to_chat(M, span_danger("You can't wear this armour, it's too heavy!"))
				return FALSE

