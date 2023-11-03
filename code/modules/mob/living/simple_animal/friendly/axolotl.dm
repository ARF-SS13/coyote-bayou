/mob/living/simple_animal/axolotl
	name = "axolotl"
	desc = "Quite the colorful amphibian!"
	icon_state = "axolotl"
	icon_living = "axolotl"
	icon_dead = "axolotl_dead"
	maxHealth = 10
	health = 10
	attack_verb_continuous = "nibbles" //their teeth are just for gripping food, not used for self defense nor even chewing
	attack_verb_simple = "nibble"
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "splats"
	response_harm_simple = "splat"
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
//	can_be_held = TRUE
	mob_size = MOB_SIZE_SMALL
//	worn_slot_flags = INV_SLOTBIT_HEAD
//	head_icon = 'icons/mob/clothing/head/animal_item_head.dmi'
