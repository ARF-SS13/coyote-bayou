/obj/item/clothing/gloves/color
	dying_key = DYE_REGISTRY_GLOVES

/obj/item/clothing/gloves/color/yellow
	desc = "These gloves will protect the wearer from electric shock."
	name = "insulated gloves"
	icon = 'icons/fallout/clothing/gloves.dmi'
	icon_state = "yellow"
	inhand_icon_state = "ygloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE
	var/can_be_cut = 1
	custom_price = PRICE_EXPENSIVE
	custom_premium_price = PRICE_ALMOST_ONE_GRAND

/obj/item/toy/sprayoncan
	name = "spray-on insulation applicator"
	desc = "What is the number one problem facing our station today?"
	icon = 'icons/obj/clothing/gloves.dmi'
	icon_state = "sprayoncan"

/obj/item/toy/sprayoncan/afterattack(atom/target, mob/living/carbon/user, proximity)
	if(iscarbon(target) && proximity)
		var/mob/living/carbon/C = target
		var/mob/living/carbon/U = user
		var/success = C.equip_to_slot_if_possible(new /obj/item/clothing/gloves/color/yellow/sprayon, INV_SLOTBIT_GLOVES, TRUE, TRUE, clothing_check = TRUE)
		if(success)
			if(C == user)
				C.visible_message(span_notice("[U] sprays their hands with glittery rubber!"))
			else
				C.visible_message(span_warning("[U] sprays glittery rubber on the hands of [C]!"))
		else
			user.visible_message(span_warning("The rubber fails to stick to [C]'s hands!"),
				span_warning("The rubber fails to stick to [C]'s [(SLOT_GLOVES in C.check_obscured_slots()) ? "unexposed" : ""] hands!"))

		qdel(src)

/obj/item/clothing/gloves/color/yellow/sprayon
	desc = "How're you gonna get 'em off, nerd?"
	name = "spray-on insulated gloves"
	icon_state = "sprayon"
	inhand_icon_state = "sprayon"
	permeability_coefficient = 0
	resistance_flags = ACID_PROOF
	var/shocks_remaining = 10

/obj/item/clothing/gloves/color/yellow/sprayon/Initialize()
	.=..()
	ADD_TRAIT(src, TRAIT_NODROP, GLOVE_TRAIT)

/obj/item/clothing/gloves/color/yellow/sprayon/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(user, COMSIG_LIVING_SHOCK_PREVENTED,PROC_REF(Shocked))

/obj/item/clothing/gloves/color/yellow/sprayon/proc/Shocked()
	shocks_remaining--
	if(shocks_remaining < 0)
		qdel(src) //if we run out of uses, the gloves crumble away into nothing, just like my dreams after working with .dm

/obj/item/clothing/gloves/color/yellow/sprayon/dropped()
	.=..()
	qdel(src) //loose nodrop items bad

/obj/item/clothing/gloves/color/fyellow                             //Cheap Chinese Crap
	desc = "These gloves are cheap knockoffs of the coveted ones - no way this can end badly."
	name = "budget insulated gloves"
	icon_state = "yellow"
	inhand_icon_state = "ygloves"
	siemens_coefficient = 1			//Set to a default of 1, gets overridden in New()
	permeability_coefficient = 0.05
	resistance_flags = NONE
	var/can_be_cut = 1

/obj/item/clothing/gloves/color/fyellow/New()
	..()
	siemens_coefficient = pick(0,0.5,0.5,0.5,0.5,0.75,1.5)

/obj/item/clothing/gloves/color/fyellow/old
	desc = "Old and worn out insulated gloves, hopefully they still work."
	name = "worn out insulated gloves"

/obj/item/clothing/gloves/color/fyellow/old/Initialize()
	. = ..()
	siemens_coefficient = pick(0,0,0,0.5,0.5,0.5,0.75)

/obj/item/clothing/gloves/cut
	desc = "These gloves would protect the wearer from electric shock.. if the fingers were covered."
	name = "fingerless insulated gloves"
	icon_state = "yellowcut"
	inhand_icon_state = "yglovescut"
	siemens_coefficient = 1
	permeability_coefficient = 1
	resistance_flags = NONE
	transfer_prints = TRUE
	strip_mod = 0.8

/obj/item/clothing/gloves/cut/family
	desc = "The old gloves your great grandfather stole from Engineering, many moons ago. They've seen some tough times recently."
	name = "fingerless insulated gloves"

/obj/item/clothing/gloves/color/yellow/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))
		if(can_be_cut && icon_state == initial(icon_state))//only if not dyed
			to_chat(user, span_notice("You snip the fingertips off of [src]."))
			I.play_tool_sound(src)
			new /obj/item/clothing/gloves/cut(drop_location())
			qdel(src)
	..()

/obj/item/clothing/gloves/color/fyellow/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))
		if(can_be_cut && icon_state == initial(icon_state))//only if not dyed
			to_chat(user, span_notice("You snip the fingertips off of [src]."))
			I.play_tool_sound(src)
			new /obj/item/clothing/gloves/cut(drop_location())
			qdel(src)
	..()

/obj/item/clothing/gloves/color/black
	desc = "These gloves are fire-resistant."
	name = "black gloves"
	icon_state = "black"
	inhand_icon_state = "blackgloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	var/can_be_cut = TRUE
	strip_mod = 1.2

/obj/item/clothing/gloves/color/black/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))
		if(can_be_cut && icon_state == initial(icon_state))//only if not dyed
			to_chat(user, span_notice("You snip the fingertips off of [src]."))
			I.play_tool_sound(src)
			new /obj/item/clothing/gloves/fingerless(drop_location())
			qdel(src)
	..()

/obj/item/clothing/gloves/color/orange
	name = "orange gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "orange"
	inhand_icon_state = "orangegloves"

/obj/item/clothing/gloves/color/red
	name = "red gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "red"
	inhand_icon_state = "redgloves"

/obj/item/clothing/gloves/color/red/insulated
	name = "insulated gloves"
	desc = "These gloves will protect the wearer from electric shock."
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	resistance_flags = NONE

/obj/item/clothing/gloves/color/rainbow
	name = "rainbow gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "rainbow"
	inhand_icon_state = "rainbowgloves"

/obj/item/clothing/gloves/color/blue
	name = "blue gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "blue"
	inhand_icon_state = "bluegloves"

/obj/item/clothing/gloves/color/purple
	name = "purple gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "purple"
	inhand_icon_state = "purplegloves"

/obj/item/clothing/gloves/color/green
	name = "green gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "green"
	inhand_icon_state = "greengloves"

/obj/item/clothing/gloves/color/grey
	name = "grey gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "gray"
	inhand_icon_state = "graygloves"

/obj/item/clothing/gloves/color/white/bos
	name = "brotherhood formal gloves"
	desc = "White gloves worn with the Brotherhood's formal dress."
	icon_state = "white"
	inhand_icon_state = "wgloves"
	item_color="white"

/obj/item/clothing/gloves/color/light_brown
	name = "light brown gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "lightbrown"
	inhand_icon_state = "lightbrowngloves"

/obj/item/clothing/gloves/color/brown
	name = "brown gloves"
	desc = "A pair of gloves, they don't look special in any way."
	icon_state = "brown"
	inhand_icon_state = "browngloves"

/obj/item/clothing/gloves/color/captain
	desc = "Regal blue gloves, with a nice gold trim, a diamond anti-shock coating, and an integrated thermal barrier. Swanky."
	name = "captain's gloves"
	icon_state = "captain"
	inhand_icon_state = "egloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 60
	armor = ARMOR_VALUE_CLOTHES

/obj/item/clothing/gloves/color/latex
	name = "latex gloves"
	desc = "Cheap sterile gloves made from latex."
	icon = 'icons/fallout/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/hand.dmi'
	icon_state = "surgery"
	inhand_icon_state = "surgery"
	siemens_coefficient = 0.3
	permeability_coefficient = 0.01
	transfer_prints = TRUE
	resistance_flags = NONE

/obj/item/clothing/gloves/color/latex/nitrile
	name = "nitrile gloves"
	desc = "Pricy sterile gloves that are stronger than latex."
	icon = 'icons/fallout/clothing/gloves.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/hand.dmi'
	icon_state = "surgery"
	inhand_icon_state = "surgery"
	transfer_prints = FALSE

/obj/item/clothing/gloves/color/latex/nitrile/infiltrator
	name = "insidious combat gloves"
	desc = "Specialized combat gloves for carrying people around."
	icon_state = "infiltrator"
	inhand_icon_state = "infiltrator"
	siemens_coefficient = 0
	permeability_coefficient = 0.3
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/gloves/color/latex/engineering
	name = "tinker's gloves"
	desc = "Overdesigned engineering gloves that have automated construction subroutines dialed in, allowing for faster construction while worn."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_gauntlets"
	inhand_icon_state = "clockwork_gauntlets"
	siemens_coefficient = 0.8
	permeability_coefficient = 0.3
	var/carrytrait = TRAIT_QUICK_BUILD
	custom_materials = list(/datum/material/iron=2000, /datum/material/silver=1500, /datum/material/gold = 1000)

/obj/item/clothing/gloves/color/latex/engineering/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_GLOVES)
		ADD_TRAIT(user, carrytrait, GLOVE_TRAIT)

/obj/item/clothing/gloves/color/latex/engineering/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, carrytrait, GLOVE_TRAIT)

/obj/item/clothing/gloves/color/white
	name = "white gloves"
	desc = "These look pretty fancy."
	icon_state = "white"
	inhand_icon_state = "wgloves"
