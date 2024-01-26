GLOBAL_DATUM_INIT(combat_indicator, /mutable_appearance, mutable_appearance('modular_sand/icons/mob/combat_indicator.dmi', "combat", FLY_LAYER, appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART))

/mob/living/proc/set_combat_indicator(state)
	if(state && stat != DEAD)
		add_overlay(GLOB.combat_indicator)
	else
		cut_overlay(GLOB.combat_indicator)
