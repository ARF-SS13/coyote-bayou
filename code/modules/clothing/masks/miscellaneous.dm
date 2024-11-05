/obj/item/clothing/mask/muzzle
	name = "muzzle"
	desc = "To stop that awful noise."
	icon_state = "muzzle"
	inhand_icon_state = "blindfold"
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.9
	equip_delay_other = 20
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/muzzle/attack_paw(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.wear_mask)
			to_chat(user, span_warning("You need help taking this off!"))
			return
	..()

/obj/item/clothing/mask/surgical
	name = "sterile mask"
	desc = "A sterile mask designed to help prevent the spread of diseases."
	icon = 'icons/fallout/clothing/masks.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mask.dmi'
	icon_state = "sterile"
	inhand_icon_state = "sterile"
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEFACE
	visor_flags_cover = MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.01
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)
	actions_types = list(/datum/action/item_action/adjust)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/surgical/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/fakemoustache
	name = "fake moustache"
	desc = "Warning: moustache is fake."
	icon_state = "fake-moustache"
	flags_inv = HIDEFACE
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/fakemoustache/italian
	name = "italian moustache"
	desc = "Made from authentic Italian moustache hairs. Gives the wearer an irresistable urge to gesticulate wildly."
	modifies_speech = TRUE

/obj/item/clothing/mask/fakemoustache/italian/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	var/message = mom.message
	if(message[1] != "*")
		message = " [message]"
		var/list/italian_words = strings("italian_replacement.json", "italian")

		for(var/key in italian_words)
			var/value = italian_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

		if(prob(3))
			message += pick(" Ravioli, ravioli, give me the formuoli!"," Mamma-mia!"," Mamma-mia! That's a spicy meat-ball!", " La la la la la funiculi funicula!")
	mom.message = trim(message)

/obj/item/clothing/mask/joy
	name = "joy mask"
	desc = "Express your happiness or hide your sorrows with this laughing face with crying tears of joy cutout."
	icon_state = "joy"
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/pig
	name = "pig mask"
	desc = "A rubber pig mask with a builtin voice modulator."
	icon_state = "pig"
	inhand_icon_state = "pig"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	clothing_flags = VOICEBOX_TOGGLABLE
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/pig/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	if(!CHECK_BITFIELD(clothing_flags, VOICEBOX_DISABLED))
		mom.message = pick("Oink!","Squeeeeeeee!","Oink Oink!")

/obj/item/clothing/mask/pig/cursed //needs to be different otherwise you could turn the speedmodification off and on
	name = "Pig face"
	desc = "It looks like a mask, but closer inspection reveals it's melded onto this persons face!" //It's only ever going to be attached to your face.
	flags_inv = HIDEFACIALHAIR
	clothing_flags = NONE

/obj/item/clothing/mask/pig/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
	playsound(get_turf(src), 'sound/magic/pighead_curse.ogg', 50, 1)

///frog mask - reeee!!
/obj/item/clothing/mask/frog
	name = "frog mask"
	desc = "An ancient mask carved in the shape of a frog.<br> Sanity is like gravity, all it needs is a push."
	icon_state = "frog"
	inhand_icon_state = "frog"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	clothing_flags = VOICEBOX_TOGGLABLE
	modifies_speech = TRUE

/obj/item/clothing/mask/frog/handle_speech(datum/source, datum/rental_mommy/chat/mom) //whenever you speak
	if(!CHECK_BITFIELD(clothing_flags, VOICEBOX_DISABLED))
		if(prob(5)) //sometimes, the angry spirit finds others words to speak.
			mom.message = pick("HUUUUU!!","SMOOOOOKIN'!!","Hello my baby, hello my honey, hello my rag-time gal.", "Feels bad, man.", "GIT DIS GUY OFF ME!!" ,"SOMEBODY STOP ME!!", "NORMIES, GET OUT!!")
		else
			mom.message = pick("Ree!!", "Reee!!","REEE!!","REEEEE!!") //but its usually just angry gibberish,

/obj/item/clothing/mask/frog/cursed
	clothing_flags = NONE

/obj/item/clothing/mask/frog/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)

/obj/item/clothing/mask/frog/cursed/equipped(mob/user, slot)
	var/mob/living/carbon/C = user
	if(C.wear_mask == src && HAS_TRAIT_FROM(src, TRAIT_NODROP, CURSED_ITEM_TRAIT))
		to_chat(user, span_userdanger("<B>[src] was cursed! Ree!!</B>"))
	return ..()

/obj/item/clothing/mask/cowmask
	name = "Cow mask with a builtin voice modulator."
	desc = "A rubber cow mask,"
	icon_state = "cowmask"
	inhand_icon_state = "cowmask"
	clothing_flags = VOICEBOX_TOGGLABLE
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/cowmask/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	if(!CHECK_BITFIELD(clothing_flags, VOICEBOX_DISABLED))
		mom.message = pick("Moooooooo!","Moo!","Moooo!")


/obj/item/clothing/mask/cowmask/cursed
	name = "cow face"
	desc = "It looks like a cow mask, but closer inspection reveals it's melded onto this persons face!"
	flags_inv = HIDEFACIALHAIR
	clothing_flags = NONE

/obj/item/clothing/mask/cowmask/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
	playsound(get_turf(src), 'sound/magic/cowhead_curse.ogg', 50, 1)

/obj/item/clothing/mask/horsehead
	name = "horse head mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a horse."
	icon_state = "horsehead"
	inhand_icon_state = "horsehead"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEEYES|HIDEEARS
	w_class = WEIGHT_CLASS_SMALL
	clothing_flags = VOICEBOX_TOGGLABLE

/obj/item/clothing/mask/horsehead/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	if(!CHECK_BITFIELD(clothing_flags, VOICEBOX_DISABLED))
		mom.message = pick("NEEIIGGGHHHH!", "NEEEIIIIGHH!", "NEIIIGGHH!", "HAAWWWWW!", "HAAAWWW!")


/obj/item/clothing/mask/horsehead/cursed
	name = "horse face"
	desc = "It initially looks like a mask, but it's melded into the poor person's face."
	clothing_flags = NONE
	flags_inv = HIDEFACIALHAIR

/obj/item/clothing/mask/horsehead/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_MASK_TRAIT)
	playsound(get_turf(src), 'sound/magic/horsehead_curse.ogg', 50, 1)

/obj/item/clothing/mask/rat
	name = "rat mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a rat."
	icon_state = "rat"
	inhand_icon_state = "rat"
	flags_inv = HIDEFACE
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/rat/fox
	name = "fox mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a fox."
	icon_state = "fox"
	inhand_icon_state = "fox"

/obj/item/clothing/mask/rat/bee
	name = "bee mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a bee."
	icon_state = "bee"
	inhand_icon_state = "bee"

/obj/item/clothing/mask/rat/bear
	name = "bear mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a bear."
	icon_state = "bear"
	inhand_icon_state = "bear"

/obj/item/clothing/mask/rat/bat
	name = "bat mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a bat."
	icon_state = "bat"
	inhand_icon_state = "bat"

/obj/item/clothing/mask/rat/raven
	name = "raven mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a raven."
	icon_state = "raven"
	inhand_icon_state = "raven"

/obj/item/clothing/mask/rat/jackal
	name = "jackal mask"
	desc = "A mask made of soft vinyl and latex, representing the head of a jackal."
	icon_state = "jackal"
	inhand_icon_state = "jackal"

/obj/item/clothing/mask/rat/tribal
	name = "tribal mask"
	desc = "A mask carved out of wood, detailed carefully by hand."
	icon_state = "bumba"
	inhand_icon_state = "bumba"

/obj/item/clothing/mask/bandana
	name = "botany bandana"
	desc = "A fine bandana with nanotech lining and a hydroponics pattern."
	w_class = WEIGHT_CLASS_TINY
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR
	visor_flags_cover = MASKCOVERSMOUTH
	slot_flags = INV_SLOTBIT_MASK
	adjusted_flags = INV_SLOTBIT_HEAD
	icon_state = "bandbotany"
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/mask/bandana/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/bandana/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if((C.get_item_by_slot(SLOT_HEAD == src)) || (C.get_item_by_slot(SLOT_MASK) == src))
			to_chat(user, span_warning("You can't tie [src] while wearing it!"))
			return
	if(slot_flags & INV_SLOTBIT_HEAD)
		to_chat(user, span_warning("You must undo [src] before you can tie it into a neckerchief!"))
	else
		if(user.is_holding(src))
			var/obj/item/clothing/neck/neckerchief/nk = new(src)
			nk.name = "[name] neckerchief"
			nk.desc = "[desc] It's tied up like a neckerchief."
			nk.icon_state = icon_state
			nk.sourceBandanaType = src.type
			var/currentHandIndex = user.get_held_index_of_item(src)
			user.transferItemToLoc(src, null)
			user.put_in_hand(nk, currentHandIndex)
			user.visible_message(span_notice("You tie [src] up like a neckerchief."), span_notice("[user] ties [src] up like a neckerchief."))
			qdel(src)
		else
			to_chat(user, "<span class='warning'>You must be holding [src] in order to tie it!")

/obj/item/clothing/mask/bandana/red
	name = "red bandana"
	desc = "A fine red bandana with nanotech lining."
	icon_state = "bandred"

/obj/item/clothing/mask/bandana/blue
	name = "blue bandana"
	desc = "A fine blue bandana with nanotech lining."
	icon_state = "bandblue"

/obj/item/clothing/mask/bandana/green
	name = "green bandana"
	desc = "A fine green bandana with nanotech lining."
	icon_state = "bandgreen"

/obj/item/clothing/mask/bandana/gold
	name = "gold bandana"
	desc = "A fine gold bandana with nanotech lining."
	icon_state = "bandgold"

/obj/item/clothing/mask/bandana/black
	name = "black bandana"
	desc = "A fine black bandana with nanotech lining."
	icon_state = "bandblack"

/obj/item/clothing/mask/bandana/skull
	name = "skull bandana"
	desc = "A fine black bandana with nanotech lining and a skull emblem."
	icon_state = "bandskull"

/obj/item/clothing/mask/mummy
	name = "mummy mask"
	desc = "Ancient bandages."
	icon_state = "mummy_mask"
	inhand_icon_state = "mummy_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/mask/scarecrow
	name = "sack mask"
	desc = "A burlap sack with eyeholes."
	icon_state = "scarecrow_sack"
	inhand_icon_state = "scarecrow_sack"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/mask/gondola
	name = "gondola mask"
	desc = "Genuine gondola fur."
	icon_state = "gondola"
	inhand_icon_state = "gondola"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/gondola/handle_speech(datum/source, datum/rental_mommy/chat/mom)
	var/message = mom.message
	if(message[1] != "*")
		message = " [message]"
		var/list/spurdo_words = strings("spurdo_replacement.json", "spurdo")
		for(var/key in spurdo_words)
			var/value = spurdo_words[key]
			if(islist(value))
				value = pick(value)
			message = replacetextEx(message,regex(uppertext(key),"g"), "[uppertext(value)]")
			message = replacetextEx(message,regex(capitalize(key),"g"), "[capitalize(value)]")
			message = replacetextEx(message,regex(key,"g"), "[value]")
	mom.message = trim(message)

/obj/item/clothing/mask/bandana/durathread
	name = "durathread bandana"
	desc =  "A bandana made from durathread, you wish it would provide some protection to its wearer, but it's far too thin..."
	mob_overlay_icon = 'icons/mob/clothing/mask.dmi'
	icon_state = "banddurathread"

/obj/item/clothing/mask/paper
	name = "paper mask"
	desc = "A neat, circular mask made out of paper."
	icon_state = "plainmask"
	inhand_icon_state = "plainmask"
	flags_inv = HIDEFACE|HIDEFACIALHAIR
	resistance_flags = FLAMMABLE
	max_integrity = 100
	actions_types = list(/datum/action/item_action/adjust)
	var/list/papermask_designs = list()


/obj/item/clothing/mask/paper/Initialize(mapload)
	.=..()
	papermask_designs = list(
		"Blank" = image(icon = src.icon, icon_state = "plainmask"),
		"Neutral" = image(icon = src.icon, icon_state = "neutralmask"),
		"Eyes" = image(icon = src.icon, icon_state = "eyemask"),
		"Sleeping" = image(icon = src.icon, icon_state = "sleepingmask"),
		"Heart" = image(icon = src.icon, icon_state = "heartmask"),
		"Core" = image(icon = src.icon, icon_state = "coremask"),
		"Plus" = image(icon = src.icon, icon_state = "plusmask"),
		"Square" = image(icon = src.icon, icon_state = "squaremask"),
		"Bullseye" = image(icon = src.icon, icon_state = "bullseyemask"),
		"Vertical" = image(icon = src.icon, icon_state = "verticalmask"),
		"Horizontal" = image(icon = src.icon, icon_state = "horizontalmask"),
		"X" = image(icon = src.icon, icon_state = "xmask"),
		"Bugeyes" = image(icon = src.icon, icon_state = "bugmask"),
		"Double" = image(icon = src.icon, icon_state = "doublemask"),
		"Mark" = image(icon = src.icon, icon_state = "markmask")
		)

/obj/item/clothing/mask/paper/ui_action_click(mob/user)
	if(!istype(user) || user.incapacitated(allow_crit = TRUE))
		return

	var/static/list/options = list("Blank" = "plainmask", "Neutral" = "neutralmask", "Eyes" = "eyemask",
							"Sleeping" ="sleepingmask", "Heart" = "heartmask", "Core" = "coremask",
							"Plus" = "plusmask", "Square" ="squaremask", "Bullseye" = "bullseyemask",
							"Vertical" = "verticalmask", "Horizontal" = "horizontalmask", "X" ="xmask",
							"Bugeyes" = "bugmask", "Double" = "doublemask", "Mark" = "markmask")

	var/choice = show_radial_menu(user,src, papermask_designs, custom_check = FALSE, radius = 36, require_near = TRUE)

	if(src && choice && !user.incapacitated() && in_range(user,src))
		icon_state = options[choice]
		user.update_inv_wear_mask()
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		to_chat(user, span_notice("Your paper mask now has a [choice] symbol!"))
		return 1


//NCR Facewrap

/obj/item/clothing/mask/ncr_facewrap 
	name = "desert facewrap"
	desc = "A facewrap commonly employed by NCR troops in desert environments."
	icon_state = "ncr_facewrap"
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEMASK|HIDEFACE
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEMASK|HIDEFACE
	visor_flags_cover = MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.01
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)
	actions_types = list(/datum/action/item_action/adjust)



/obj/item/clothing/mask/ncr_facewrap/attack_self(mob/user)
	adjustmask(user)

/////////////////////
//"LEGION" BANDANAS//
/////////////////////

/obj/item/clothing/mask/bandana/legion
	name = "legion mask template"
	desc = "Should not exist."
	icon = 'icons/fallout/clothing/masks.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mask.dmi'
	flags_inv = HIDEFACE
	visor_flags_inv = HIDEFACE
	adjusted_flags = null
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/bandana/legion/camp
	name = "desperado bandana"
	desc = "Simple black cloth normally used by desperados"
	icon_state = "legaux"

/obj/item/clothing/mask/bandana/legion/legrecruit
	name = "thieves bandana"
	desc = "A coarse dark thieves bandana."
	icon_state = "legrecruit"

/obj/item/clothing/mask/bandana/legion/legprime
	name = "prime bandana"
	desc = "A dark linen bandana worn by primes"
	icon_state = "legdecan"

/obj/item/clothing/mask/bandana/legion/legvet
	name = "bandito bandana"
	desc = "A banditos bandana in red."
	icon_state = "legvet"

/obj/item/clothing/mask/bandana/legion/legdecan
	name = "outlaw bandana"
	desc = "A fine bandana in dark red."
	icon = 'icons/fallout/clothing/masks.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mask.dmi'
	icon_state = "legdecan"

/obj/item/clothing/mask/bandana/legion/legcenturion
	name = "overboss bandana"
	desc = "A high quality bandana made for a overboss."
	icon_state = "legcenturion"


//Desert facewrap

/obj/item/clothing/mask/facewrap
	name = "desert headwrap"
	desc = "A headwrap to help shield the face from sand and other dirt."
	icon_state = "facewrap"
	inhand_icon_state = "facewrap"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEFACE
	visor_flags_cover = MASKCOVERSMOUTH

//Society Mask

/obj/item/clothing/mask/society
	name = "golden facemask"
	desc = "A burlap sack with eyeholes."
	icon_state = "societymask"
	inhand_icon_state = "societymask"
	flags_inv = HIDEFACE

/obj/item/clothing/mask/bandana/momentobandana
	name = "momento bandana"
	desc = "A bandana that serves the user as a reminder of the past."
	icon_state = "momento"
	flags_inv = HIDEFACE
	visor_flags_inv = HIDEFACE
	adjusted_flags = null
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/kitsune
	name = "kitsune mask"
	desc = "A mask made of plastic and paint."
	icon_state = "whitekitsunemask"
	inhand_icon_state = "whitekitsunemask"

/obj/item/clothing/mask/kitsune/black
	name = "kitsune mask - black"
	desc = "A mask made of plastic and paint."
	icon_state = "blackkitsunemask"
	inhand_icon_state = "blackkitsunemask"
