/obj/item/organ/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	genital_flags = GENITAL_INTERNAL|GENITAL_FLUID_PRODUCTION
	fluid_id = /datum/reagent/consumable/semen/femcum
	linked_organ_slot = ORGAN_SLOT_VAGINA

/obj/item/organ/genital/womb/format_for_tgui()
	var/list/out = list()
	out["BitKind"] = "uterine lining"
	out["BitName"] = "A uterus."
	out["BitSize"] = "It has a 17.91pg Total Breeding Capacity!"
	out["BitColor"] = "[color]"
	out["BitAroused"] = FALSE
	out["BitExtra"] = "Operating at %[fluid_efficiency] capacity."
	out["BitEmoji"] = "🎈"
	return out
