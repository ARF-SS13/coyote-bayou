
/obj/item/clothing/under/suit/white_on_white
	name = "white suit"
	desc = "A white suit, suitable for an excellent host."
	icon_state = "scratch"
	inhand_icon_state = "scratch"
	can_adjust = FALSE

/obj/item/clothing/under/suit/white_on_white/skirt
	name = "white suitskirt"
	desc = "A white suitskirt, suitable for an excellent host."
	icon_state = "white_suit_skirt"
	inhand_icon_state = "scratch"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/suit/sl
	desc = "It's a very amish looking suit."
	name = "amish suit"
	icon_state = "sl_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/waiter
	name = "waiter's outfit"
	desc = "It's a very smart uniform with a special pocket for tip."
	icon_state = "waiter"
	inhand_icon_state = "waiter"
	can_adjust = FALSE

/obj/item/clothing/under/suit/black
	name = "black suit"
	desc = "A black suit and red tie. Very formal."
	icon_state = "black_suit"
	inhand_icon_state = "bl_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/black_really
	name = "executive suit"
	desc = "A formal black suit and red tie, intended for the station's finest."
	icon_state = "really_black_suit"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/suit/black/skirt
	name = "executive suit"
	desc = "A formal trouser suit for women, intended for the station's finest."
	icon_state = "black_suit_fem"
	inhand_icon_state = "black_suit_fem"

/obj/item/clothing/under/suit/green
	name = "green suit"
	desc = "A green suit and yellow necktie. Baller."
	icon_state = "green_suit"
	inhand_icon_state = "dg_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/red
	name = "red suit"
	desc = "A red suit and blue tie. Somewhat formal."
	icon_state = "red_suit"
	inhand_icon_state = "r_suit"
	can_adjust = FALSE


/obj/item/clothing/under/suit/charcoal
	name = "charcoal suit"
	desc = "A charcoal suit and red tie. Very professional."
	icon_state = "charcoal_suit"
	inhand_icon_state = "charcoal_suit"
	can_adjust = FALSE
/obj/item/clothing/under/suit/navy
	name = "navy suit"
	desc = "A navy suit and red tie, intended for the station's finest."
	icon_state = "navy_suit"
	inhand_icon_state = "navy_suit"
	can_adjust = FALSE
/obj/item/clothing/under/suit/burgundy
	name = "burgundy suit"
	desc = "A burgundy suit and black tie. Somewhat formal."
	icon_state = "burgundy_suit"
	inhand_icon_state = "burgundy_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/checkered
	name = "checkered suit"
	desc = "That's a very nice suit you have there. Shame if something were to happen to it, eh?"
	icon_state = "checkered_suit"
	inhand_icon_state = "checkered_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/tan
	name = "tan suit"
	desc = "A tan suit with a yellow tie. Smart, but casual."
	icon_state = "tan_suit"
	inhand_icon_state = "tan_suit"
	can_adjust = FALSE

/obj/item/clothing/under/suit/white
	name = "white formal underclothes"
	desc = "A neat set of black slacks and a white shirt, only slightly weathered from the nuclear apocalypse."
	icon_state = "white_suit"
	inhand_icon_state = "white_suit"
	can_adjust = FALSE
/obj/item/clothing/under/suit/telegram
	name = "telegram suit"
	desc = "Bright and red, hard to miss. Mostly warn by hotel staff or singing telegram."
	icon_state = "telegram"
	inhand_icon_state = "telegram"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE

/obj/item/clothing/under/suit/polychromic	//enables all three overlays to reduce copypasta and defines basic stuff
	name = "polychromic suit"
	desc = "For when you want to show off your horrible colour coordination skills."
	icon_state = "polysuit"
	inhand_icon_state = "sl_suit"
	can_adjust = FALSE
	mutantrace_variation = NONE

/obj/item/clothing/under/suit/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#FFFFFF", "#808080"), 3)

/obj/item/clothing/under/suit/turtle
	desc = "a debatably stylish turtleneck."
	can_adjust = FALSE

/obj/item/clothing/under/suit/turtle/teal
	name = "teal turtleneck"
	icon_state = "tealturtle"
	inhand_icon_state = "tealturtle"
	can_adjust = FALSE

/obj/item/clothing/under/suit/turtle/grey
	name = "grey turtleneck"
	icon_state = "greyturtle"
	inhand_icon_state = "greyturtle"
	can_adjust = FALSE
