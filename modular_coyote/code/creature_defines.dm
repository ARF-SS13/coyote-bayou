//Non-humanoids with all carbon-based features
/mob/living/carbon/feral
	name = "creature"
	desc = "That's a creature all right."
	icon = 'modular_coyote/icons/mob/pokemon64.dmi'
	icon_state = "eevee"
	icon_living = "eevee"
	icon_dead = "eevee_d"
	/// see /code/__DEFINES/mobs.dm for these
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gib_type = /obj/effect/decal/cleanable/blood/gibs
	buckle_lying = 0
	blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	hud_type = /datum/hud/feral
	possible_a_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, INTENT_HARM)
	pressure_resistance = 25
	can_buckle = TRUE
	buckle_lying = FALSE
	/// Enable stamina combat
	combat_flags = COMBAT_FLAGS_DEFAULT | COMBAT_FLAG_UNARMED_PARRY
	status_flags = CANSTUN|CANKNOCKDOWN|CANUNCONSCIOUS|CANPUSH|CANSTAGGER
	has_field_of_vision = FALSE //Handled by species.
	hud_possible = list(
		HEALTH_HUD,
		STATUS_HUD,
		ID_HUD,
		WANTED_HUD,
		IMPLOYAL_HUD,
		IMPCHEM_HUD,
		IMPTRACK_HUD, 
		NANITE_HUD, 
		DIAG_NANITE_FULL_HUD,
		ANTAG_HUD,
		GLAND_HUD,
		SENTIENT_DISEASE_HUD,
		RAD_HUD,
		ONLINE_HUD,
		GENITAL_HUD = HUD_LIST_LIST, // and boy what a list it is
		TAIL_HUD,
		)
