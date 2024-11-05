/obj/item/clothing/under/rank/captain
	desc = "It's a blue jumpsuit with some gold markings denoting the rank of \"Captain\"."
	name = "captain's jumpsuit"
	icon_state = "captain"
	inhand_icon_state = "b_suit"
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/captain/pilot
	desc = "A blue jumpsuit with gold markings. One shoulder stripe reads \"New Boston\" while the other reads \"Pilot\"."
	name = "pilot's jumpsuit"
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/rank/captain/util
	name = "Command Utiltiy Uniform"
	desc = "A utility uniform for command personnel."
	icon_state = "utilcom"
	inhand_icon_state = "utilcom"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/skirt
	name = "captain's jumpskirt"
	desc = "It's a blue jumpskirt with some gold markings denoting the rank of \"Captain\"."
	icon_state = "captain_skirt"
	inhand_icon_state = "b_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/rank/captain/suit
	name = "captain's suit"
	desc = "A green suit and yellow necktie. Exemplifies authority."
	icon_state = "green_suit"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/suit/skirt
	name = "green suitskirt"
	desc = "A green suitskirt and yellow necktie. Exemplifies authority."
	icon_state = "green_suit_skirt"
	inhand_icon_state = "dg_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/rank/captain/parade
	name = "captain's parade uniform"
	desc = "A captain's luxury-wear, for special occasions."
	icon_state = "captain_parade"
	inhand_icon_state = "by_suit"
	can_adjust = FALSE

/obj/item/clothing/under/rank/captain/femformal
	name = "captain's female formal outfit"
	desc = "An ironically skimpy blue dress with gold markings denoting the rank of \"Captain\"."
	icon_state = "lewdcap"
	inhand_icon_state = "lewdcap"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|USE_TAUR_CLIP_MASK
