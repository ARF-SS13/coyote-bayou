/obj/item/clothing/under/shorts
	name = "athletic shorts"
	desc = "95% Polyester, 5% Spandex!"
	gender = PLURAL
	body_parts_covered = GROIN
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE //how do they show up on taurs otherwise?

/obj/item/clothing/under/shorts/red
	name = "red athletic shorts"
	icon_state = "redshorts"

/obj/item/clothing/under/shorts/green
	name = "green athletic shorts"
	icon_state = "greenshorts"

/obj/item/clothing/under/shorts/blue
	name = "blue athletic shorts"
	icon_state = "blueshorts"

/obj/item/clothing/under/shorts/black
	name = "black athletic shorts"
	icon_state = "blackshorts"

/obj/item/clothing/under/shorts/grey
	name = "grey athletic shorts"
	icon_state = "greyshorts"

/obj/item/clothing/under/shorts/purple
	name = "purple athletic shorts"
	icon_state = "purpleshorts"

/obj/item/clothing/under/shorts/polychromic
	name = "polychromic athletic shorts"
	desc = "95% Polychrome, 5% Spandex!"
	icon_state = "polyshortpants"
	item_state = "rainbow"
	mutantrace_variation = NONE
	var/list/poly_colors = list("#FFFFFF", "#F08080")

/obj/item/clothing/under/shorts/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, 2)

/obj/item/clothing/under/shorts/polychromic/pantsu
	name = "polychromic panties"
	desc = "Topless striped panties. Now with 120% more polychrome!"
	icon_state = "polypantsu"
	item_state = "rainbow"
	body_parts_covered = GROIN
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

	poly_colors = list("#FFFFFF", "#8CC6FF")

/// F13 Shorts Below

/obj/item/clothing/under/shorts/jeanbshorts
	name = "jean booty shorts"
	desc = "A Pair of faded Daisy Dukes"
	icon_state = "jeanbshorts"
	item_color = "jeanbshorts"
	can_adjust = FALSE

/obj/item/clothing/under/shorts/darkbshorts
	name = "dark booty shorts"
	desc = "A pair of Daisy Dukes that haven't faded."
	icon_state = "darkbshorts"
	item_color = "darkbshorts"
	can_adjust = FALSE

/obj/item/clothing/under/shorts/blackbshorts
	name = "black booty shorts"
	desc = "A pair of black jeans cut super short."
	icon_state = "blackbshorts"
	item_color = "blackbshorts"
	can_adjust = FALSE

/obj/item/clothing/under/shorts/brownbshorts
	name = "Cargo booty shorts"
	desc = "A pair of Cargo pants cut super short."
	icon_state = "brownbshorts"
	item_color = "brownbshorts"
	can_adjust = FALSE
