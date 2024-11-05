/obj/item/clothing/neck
	name = "necklace"
	icon = 'icons/obj/clothing/neck.dmi'
	mob_overlay_icon = 'icons/mob/clothing/neck.dmi'
	body_parts_covered = NECK
	slot_flags = INV_SLOTBIT_NECK|INV_SLOTBIT_MASK
	strip_delay = 40
	equip_delay_other = 40
	var/mood_event_on_equip = /datum/mood_event/equipped_necklace/any

/obj/item/clothing/neck/equipped(mob/user, slot)
	. = ..()
	if (slot == SLOT_NECK && istype(user))
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "necklacebuff", mood_event_on_equip)
	else
		SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "necklacebuff")

/obj/item/clothing/neck/dropped(mob/user)
	. = ..()
	SEND_SIGNAL(user, COMSIG_CLEAR_MOOD_EVENT, "necklacebuff")

/obj/item/clothing/neck/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		if(body_parts_covered & HEAD)
			if(damaged_clothes)
				. += mutable_appearance('icons/effects/item_damage.dmi', "damagedmask")
			if(blood_DNA)
				. += mutable_appearance('icons/effects/blood.dmi', "maskblood", color = blood_DNA_to_color())

/obj/item/clothing/neck/tie
	name = "tie"
	desc = "A neosilk clip-on tie."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bluetie"
	inhand_icon_state = ""	//no inhands
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/tie/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/neck/tie/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/neck/tie/black
	name = "black tie"
	icon_state = "blacktie"

/obj/item/clothing/neck/tie/horrible
	name = "horrible tie"
	desc = "A neosilk clip-on tie. This one is disgusting."
	icon_state = "horribletie"

/obj/item/clothing/neck/stethoscope
	name = "stethoscope"
	desc = "An outdated medical apparatus for listening to the sounds of the human body. It also makes you look like you know what you're doing."
	icon_state = "stethoscope"

/obj/item/clothing/neck/stethoscope/attack(mob/living/carbon/human/M, mob/living/user)
	if(ishuman(M) && isliving(user))
		if(user.a_intent == INTENT_HELP)
			var/body_part = parse_zone(user.zone_selected)

			var/heart_strength = span_danger("no")
			var/lung_strength = span_danger("no")

			var/obj/item/organ/heart/heart = M.getorganslot(ORGAN_SLOT_HEART)
			var/obj/item/organ/lungs/lungs = M.getorganslot(ORGAN_SLOT_LUNGS)

			if (!do_mob(user,M,60))	// Stethoscope should take a moment to listen
				return // FAIL
			if(!(M.stat == DEAD || (HAS_TRAIT(M, TRAIT_FAKEDEATH)) || (HAS_TRAIT(M, TRAIT_NOPULSE))))
				if(heart && istype(heart))
					heart_strength = span_danger("an unstable")
					if(heart.beating)
						heart_strength = "a healthy"
				if(lungs && istype(lungs))
					lung_strength = span_danger("strained")
					if(!(M.failed_last_breath || M.losebreath))
						lung_strength = "healthy"

			if(M.stat == DEAD && heart && world.time - M.timeofdeath < DEFIB_TIME_LIMIT * 10)
				heart_strength = span_boldannounce("a faint, fluttery")

			var/diagnosis = (body_part == BODY_ZONE_CHEST ? "You hear [heart_strength] pulse and [lung_strength] respiration." : "You faintly hear [heart_strength] pulse.")
			user.visible_message("[user] places [src] against [M]'s [body_part] and listens attentively.", span_notice("You place [src] against [M]'s [body_part]. [diagnosis]"))
			return
	return ..(M,user)

///////////
//SCARVES//
///////////

/obj/item/clothing/neck/scarf //Default white color, same functionality as beanies.
	name = "white scarf"
	icon_state = "scarf"
	desc = "A stylish scarf. The perfect winter accessory for those with a keen fashion sense, and those who just can't handle a cold breeze on their necks."
	dog_fashion = /datum/dog_fashion/head
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/scarf/black
	name = "black scarf"
	icon_state = "scarf"
	color = "#4A4A4B" //Grey but it looks black

/obj/item/clothing/neck/scarf/pink
	name = "pink scarf"
	icon_state = "scarf"
	color = "#F699CD" //Pink

/obj/item/clothing/neck/scarf/red
	name = "red scarf"
	icon_state = "scarf"
	color = "#D91414" //Red

/obj/item/clothing/neck/scarf/green
	name = "green scarf"
	icon_state = "scarf"
	color = "#5C9E54" //Green

/obj/item/clothing/neck/scarf/darkblue
	name = "dark blue scarf"
	icon_state = "scarf"
	color = "#1E85BC" //Blue

/obj/item/clothing/neck/scarf/purple
	name = "purple scarf"
	icon_state = "scarf"
	color = "#9557C5" //Purple

/obj/item/clothing/neck/scarf/yellow
	name = "yellow scarf"
	icon_state = "scarf"
	color = "#E0C14F" //Yellow

/obj/item/clothing/neck/scarf/orange
	name = "orange scarf"
	icon_state = "scarf"
	color = "#C67A4B" //Orange

/obj/item/clothing/neck/scarf/cyan
	name = "cyan scarf"
	icon_state = "scarf"
	color = "#54A3CE" //Cyan


//Striped scarves get their own icons

/obj/item/clothing/neck/scarf/zebra
	name = "zebra scarf"
	icon_state = "zebrascarf"

/obj/item/clothing/neck/scarf/christmas
	name = "christmas scarf"
	icon_state = "christmasscarf"

//The three following scarves don't have the scarf subtype
//This is because Ian can equip anything from that subtype
//However, these 3 don't have corgi versions of their sprites - The purple haired princess saw this and decided to fucking toss the Laika sprites here. No dog fashion.  
/obj/item/clothing/neck/stripedredscarf
	name = "striped red scarf"
	icon_state = "stripedredscarf"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor

/obj/item/clothing/neck/stripedgreenscarf
	name = "striped green scarf"
	icon_state = "stripedgreenscarf"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor

/obj/item/clothing/neck/stripedbluescarf
	name = "striped blue scarf"
	icon_state = "stripedbluescarf"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/armor

/obj/item/clothing/neck/laika
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze."
	icon_state = "laika"
	pocket_storage_component_path = /datum/component/storage/concrete/belt/specialized/gun // Laika uses gun(s) and there's not a visible holster on her. I assume it's a hidden shoulder holster. Also, why skip out on mechanics for drip?

/obj/item/clothing/neck/laika/redder
	name = "Blood Red Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is awfully Red."
	icon_state = "laika_redder"

/obj/item/clothing/neck/laika/blue
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is a dull shade of Blue."
	icon_state = "laika_blue"

/obj/item/clothing/neck/laika/bluer
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is a vibrant Blue."
	icon_state = "laika_bluer"

/obj/item/clothing/neck/laika/cyan
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is the color of coastal waters."
	icon_state = "laika_cyan"

/obj/item/clothing/neck/laika/tan
	name = "Tactical Coyote Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is a tacticool Coyote color."
	icon_state = "laika_tan"

/obj/item/clothing/neck/laika/brown
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is the color of dirt."
	icon_state = "laika_brown"

/obj/item/clothing/neck/laika/yellow
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is the color of.. Primula."
	icon_state = "laika_yellow"

/obj/item/clothing/neck/laika/olive
	name = "Tactical OD Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is in a tacticool drabby green."
	icon_state = "laika_olive"

/obj/item/clothing/neck/laika/white
	name = "Chilly Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is the color of snow."
	icon_state = "laika_white"

/obj/item/clothing/neck/laika/black
	name = "Spooky Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is the color of spilled ink."
	icon_state = "laika_black"

/obj/item/clothing/neck/laika/tricolor
	name = "Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one smells of baguettes or vodka."
	icon_state = "laika_tricolor"

/obj/item/clothing/neck/laika/starspangledbanner
	name = "Loud Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one smells of burgers, beer, and gunpowder."
	icon_state = "laika_ssb"

/obj/item/clothing/neck/laika/striped
	name = "Striped Scarf-Cape w/ Holster"
	desc = "A stylish scarf.. and cape? The perfect winter accessory for those who ride motorcycles and just can't handle the cold breeze. This one is striped."
	icon_state = "laika_striped"

///////////
//COLLARS//
///////////

/obj/item/clothing/neck/petcollar
	name = "pet collar"
	desc = "It's for pets. Though you probably could wear it yourself, you'd doubtless be the subject of ridicule. It seems to be made out of a polychromic material."
	icon_state = "petcollar"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar
	w_class = WEIGHT_CLASS_SMALL
	var/poly_states = 1
	var/poly_colors = list("#00BBBB")
	var/tagname = null
	var/treat_path = /obj/item/reagent_containers/food/snacks/cookie

/obj/item/clothing/neck/petcollar/Initialize()
	. = ..()
	if(treat_path)
		new treat_path(src)

/obj/item/clothing/neck/petcollar/ComponentInitialize()
	. = ..()
	if(!poly_states)
		return
	AddElement(/datum/element/polychromic, poly_colors, poly_states)

/obj/item/clothing/neck/petcollar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

/obj/item/clothing/neck/petcollar/leather
	name = "leather pet collar"
	icon_state = "leathercollar"
	poly_states = 2
	poly_colors = list("#222222", "#888888")

/obj/item/clothing/neck/petcollar/choker
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	name = "choker"
	icon_state = "choker"
	poly_colors = list("#222222")

/obj/item/clothing/neck/petcollar/locked
	name = "locked collar"
	desc = "A collar that has a small lock on it to keep it from being removed."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/collar/locked
	treat_path = /obj/item/key/collar
	var/lock = FALSE

/obj/item/clothing/neck/petcollar/locked/attackby(obj/item/K, mob/user, params)
	if(istype(K, /obj/item/key/collar))
		if(lock != FALSE)
			to_chat(user, span_warning("With a click the collar unlocks!"))
			lock = FALSE
		else
			to_chat(user, span_warning("With a click the collar locks!"))
			lock = TRUE
	return

/obj/item/clothing/neck/petcollar/locked/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user && user.get_item_by_slot(SLOT_NECK) && lock != FALSE)
		to_chat(user, span_warning("The collar is locked! You'll need unlock the collar before you can take it off!"))
		return
	..()

/obj/item/clothing/neck/petcollar/locked/leather
	name = "leather pet collar"
	icon_state = "leathercollar"
	poly_states = 2
	poly_colors = list("#222222", "#888888")

/obj/item/clothing/neck/petcollar/locked/choker
	name = "choker"
	desc = "Quite fashionable... if you're somebody who's just read their first BDSM-themed erotica novel."
	icon_state = "choker"
	poly_colors = list("#222222")

/obj/item/key/collar
	name = "Collar Key"
	desc = "A key for a tiny lock on a collar or bag."

//////////////
//DOPE BLING//
//////////////

/obj/item/clothing/neck/necklace/dope
	name = "gold necklace"
	desc = "Damn, it feels good to be a gangster."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "bling"
/obj/item/clothing/neck/necklace/dope/merchant
	desc = "Don't ask how it works, the proof is in the holochips!"
	/// scales the amount received in case an admin wants to emulate taxes/fees.
	var/profit_scaling = 1
	/// toggles between sell (TRUE) and get price post-fees (FALSE)
	var/selling = FALSE

/obj/item/clothing/neck/necklace/dope/merchant/attack_self(mob/user)
	. = ..()
	selling = !selling
	to_chat(user, span_notice("[src] has been set to [selling ? "'Sell'" : "'Get Price'"] mode."))

/obj/item/clothing/neck/necklace/dope/merchant/afterattack(obj/item/I, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	var/datum/export_report/ex = export_item_and_contents(I, allowed_categories = (ALL), dry_run=TRUE)
	var/price = 0
	for(var/x in ex.total_amount)
		price += ex.total_value[x]

	if(price)
		var/true_price = round(price*profit_scaling)
		to_chat(user, span_notice("[selling ? "Sold" : "Getting the price of"] [I], value: <b>[true_price]</b> credits[I.contents.len ? " (exportable contents included)" : ""].[profit_scaling < 1 && selling ? "<b>[round(price-true_price)]</b> credit\s taken as processing fee\s." : ""]"))
		if(selling)
			new /obj/item/holochip(get_turf(user),true_price)
			for(var/i in ex.exported_atoms_ref)
				var/atom/movable/AM = i
				if(QDELETED(AM))
					continue
				qdel(AM)
	else
		to_chat(user, span_warning("There is no export value for [I] or any items within it."))

//////////////////////////////////
//VERY SUPER BADASS NECKERCHIEFS//
//////////////////////////////////

/obj/item/clothing/neck/neckerchief
	icon = 'icons/obj/clothing/masks.dmi' //In order to reuse the bandana sprite
	w_class = WEIGHT_CLASS_TINY
	var/sourceBandanaType

/obj/item/clothing/neck/neckerchief/worn_overlays(isinhands)
	. = ..()
	if(!isinhands)
		var/mutable_appearance/realOverlay = mutable_appearance('icons/mob/clothing/mask.dmi', icon_state)
		realOverlay.pixel_y = -3
		. += realOverlay

/obj/item/clothing/neck/neckerchief/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.get_item_by_slot(SLOT_NECK) == src)
			to_chat(user, span_warning("You can't untie [src] while wearing it!"))
			return
		if(user.is_holding(src))
			var/obj/item/clothing/mask/bandana/newBand = new sourceBandanaType(user)
			var/currentHandIndex = user.get_held_index_of_item(src)
			var/oldName = src.name
			qdel(src)
			user.put_in_hand(newBand, currentHandIndex)
			user.visible_message("You untie [oldName] back into a [newBand.name]", "[user] unties [oldName] back into a [newBand.name]")
		else
			to_chat(user, "<span class='warning'>You must be holding [src] in order to untie it!")


/obj/item/clothing/neck/scarf/cptpatriot
	name = "desert scarf"
	icon_state = "cptpatriotscarf"
	item_color = "cptpatriotscarf"
	desc = "A stylish scarf. This one has a camoflage pattern popularized during the great war."

/obj/item/clothing/neck/corditeclamp
	name = "Cordite Clamps Y-72"
	desc = "People say having a glass jaw is a bad thing but when that jaw is a RobCo alloy-infused combat facial prosthetic made for the U.S army and the American Elite, they are inclined to think twice about throwing a punch. At least a bare fisted one."
	icon_state = "corditeclamps"
	item_color = "corditeclamps"
	inhand_icon_state = "corditeclamps"

/obj/item/clothing/neck/jamrock
	name = "Eldritch Tie"
	desc = "The necktie is adorned with a garish pattern. It's disturbingly vivid. Somehow you feel as if it would be wrong to ever take it off. It's your friend now. You will betray it if you change it for some boring scarf."
	icon_state = "eldritch_tie"
	item_color = "eldritch_tie"
	inhand_icon_state = "eldritch_tie"
	w_class = WEIGHT_CLASS_SMALL

// Necklace and Collars!

/obj/item/clothing/neck/cursednecklace
	name = "cursed necklace"
	desc = "A necklace with a spooky aura about it."
	icon_state = "cursed_necklace"
	inhand_icon_state = "cursed_necklace"
	mood_event_on_equip = /datum/mood_event/equipped_necklace/cursed_necklace

/obj/item/clothing/neck/sapphirecollar
	name = "Sapphire Collar"
	desc = "A gold and platinum collar, with a embedded sapphire gem."
	icon_state = "sapphirecollar"
	inhand_icon_state = "sapphirecollar"
	mood_event_on_equip = /datum/mood_event/equipped_necklace/sapphire

/obj/item/clothing/neck/rubycollar
	name = "Ruby Collar"
	desc = "A gold and platinum collar, with a embedded ruby gem."
	icon_state = "rubycollar"
	inhand_icon_state = "rubycollar"
	mood_event_on_equip = /datum/mood_event/equipped_necklace/ruby

/obj/item/clothing/neck/heartcollar
	name = "Heart Collar"
	desc = "This collar appears to have a heart shaped pin on the front."
	icon_state = "heartcollar"
	inhand_icon_state = "heartcollar"
	mood_event_on_equip = /datum/mood_event/equipped_necklace/heart

/obj/item/clothing/neck/wolfpendant
	name = "Wolf Pendant"
	desc = "It is a black pendant with what looks like a wolf head with tentacles coming out from the sides."
	icon_state = "wolfpendant"
	inhand_icon_state = "wolfpendant"
	mood_event_on_equip = /datum/mood_event/equipped_necklace/wolf

/obj/item/clothing/neck/spikecollar
	name = "Spiked Collar"
	desc = "A black synthleather collar with spikey studs."
	icon_state = "spikecollar"
	inhand_icon_state = "spikecollar"

/obj/item/clothing/neck/redcowbell
	name = "Red cowbell collar"
	desc = "This collar appears to have red band and a yellow bell. Moo!"
	icon_state = "collar_cowbell"
	inhand_icon_state = "collar_cowbell"

/obj/item/clothing/neck/whitecowbell
	name = "white cowbell collar"
	desc = "This collar appears to have white band and a grey bell. Moo!"
	icon_state = "collar_cowbell_white"
	inhand_icon_state = "collar_cowbell_white"

/obj/item/clothing/neck/bluecowbell
	name = "blue cowbell collar"
	desc = "This collar appears to have blue band and a grey bell. Moo!"
	icon_state = "collar_cowbell_bluu"
	inhand_icon_state = "collar_cowbell_blue"


/obj/item/clothing/neck/customfleur
	name = "Fluer's necklace"
	desc = "A simple but handmade necklace. The chain was of a soft, glistening silver, carefully linked together. On the end of the necklace was a small heart in the most pristine sliver. Gently glistening in the light. On the back, in-graved in small careful words was, 'Never lose sight of hope or love.' Along with an image of two tails carefully intertwining."
	icon_state = "fleurnecklace"
	inhand_icon_state = "fleurnecklace"
	icon = 'icons/fallout/clothing/mantles.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/mantle.dmi'
