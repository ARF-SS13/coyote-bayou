/* 
 * File:   clam_quirks.dm
 * Author: wubbalubbadubdub
 * Date: 2020-07-30
 * License: DK GG-NO-RE 4.0
 * 
 * Description: A bunch of clamstuffs for yinglets, cus we both have them and I like them
*/

#define CLAM_OYSTER_THRESHOLD 4

/datum/quirk/clam_tongue
	name = "Clam Licker"
	desc = "Through some sort of adaptation to a questionable seafood diet, your tongue is specially shaped for yoinking the meat out of various bivalves (clams, oysters, etc)."
	value = 5
	category = "Food Quirks"
	mechanics = "You can *lick clams to extract their meat and eat it, like some kind of wierd bird rat."
	conflicts = list(
		/datum/quirk/no_taste,
		/datum/quirk/pineapple_hater,
		/datum/quirk/nukalover,
		/datum/quirk/deviant_tastes,
	)
	mob_trait = TRAIT_CLAM_TONGUE
	gain_text = span_notice("No clam can resist zhe pointyness of your tongue!")
	lose_text = span_notice("Back to using a screwdriver!")
	medical_record_text = "Patient's tongue is able to rip meat from inside of clams. Neat."

/datum/quirk/clam_lover
	name = "Clam Lover"
	desc = "You really, really *really* like clams."
	value = 7
	category = "Food Quirks"
	mechanics = "Clam meat and juice gives you a significant mood boost!"
	conflicts = list(
		/datum/quirk/no_taste,
		/datum/quirk/pineapple_hater,
		/datum/quirk/nukalover,
		/datum/quirk/deviant_tastes,
	)
	mob_trait = TRAIT_CLAM_LOVER
	gain_text = span_notice("Zhe clams, zhey call to you...")
	lose_text = span_notice("Ew clams, gross!")
	medical_record_text = "Patient really loves clams."

/datum/quirk/clam_fisher
	name = "Clam Fisher"
	desc = "You're a master at fishing for clams! You're so good in fact that you can just jab your hand into the water and snag em!"
	value = 7
	category = "Food Quirks"
	mechanics = "You can click on water tiles to fish for clams with your bare hands. Otherwise, clam fishing takes around 5 seconds, and has a chance of failing!"
	mob_trait = TRAIT_CLAM_FISHER
	gain_text = span_notice("Zhere isn't a clam alive zhat can escape your grazhp!")
	lose_text = span_notice("You've lost your touch for clam fishing.")
	medical_record_text = "Patient is able to fish for clams with their bare hands."

/datum/quirk/clam_bundle
	name = "Clam Life"
	desc = "You're a lean, mean, clam-eating machine! Your body is specially adapted to yoink clams out of the filthy sand, lick em right out of the shell, and love every moment of it!"
	value = 13
	category = "Food Quirks"
	mechanics = "Combines the effects of Clam Tongue, Clam Lover, and Clam Fisher quirks."
	conflicts = list(
		/datum/quirk/no_taste,
		/datum/quirk/pineapple_hater,
		/datum/quirk/nukalover,
		/datum/quirk/deviant_tastes,
	)
	mob_trait = list(
		TRAIT_CLAM_TONGUE,
		TRAIT_CLAM_LOVER,
		TRAIT_CLAM_FISHER,
	)
	gain_text = span_notice("Clams! Clams! Clams!")
	lose_text = span_notice("Bivalves are bivile!")
	medical_record_text = "Patient posesses various yingloidal traits."

/// clam, shell and all
/obj/item/reagent_containers/food/snacks/clam
	name = "clam"
	desc = "Nature's lunchbox! Inside is a delicious morsel of clam meat, both good for zhe body and soul. Course, you gotta get it out first."
	icon = 'icons/mob/clothing/clam.dmi'
	icon_state = "clam"
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	inedible = TRUE // sorta
	tastes = list("seafood" = 4, "dirt" = 1, "shrapnel" = 1)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/water = 2,
		/datum/reagent/consumable/sodiumchloride = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/clam_meat = 3,
		/datum/reagent/consumable/clam_juice = 5,
		/datum/reagent/shell_shrapnel = 5, // yeouch!
		/datum/reagent/calciumcarbonate = 2,
	)

	bonus_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 4)
	bitesize = 3
	filling_color = "#CD853F"
	/// sike its actually an oyster, git fukt
	var/is_actually_oyster = FALSE
	var/secret_identity_revealed = FALSE
	var/getting_screwed = FALSE
	var/otter_smacks_remaining = 3
	var/obj/item/reagent_containers/food/snacks/clam_meat/guts
	var/obj/item/pearl/perl
	var/obj/item/reagent_containers/food/snacks/clam_shell/shell

/obj/item/reagent_containers/food/snacks/clam/Initialize(mapload)
	. = ..()
	roll_for_oyster()

/obj/item/reagent_containers/food/snacks/clam/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_LICKED,PROC_REF(lick_clam))

/obj/item/reagent_containers/food/snacks/clam/Destroy()
	destroy_innards()
	. = ..()

/obj/item/reagent_containers/food/snacks/clam/examine(mob/user)
	. = ..()
	var/list/terry_hintz = list()
	terry_hintz += oysterclam(span_notice("Maybe try jimmying open the shell with a screwdriver or knife! Or you can pick up a rock with *rocks and just smash it open like an otter."), user)
	terry_hintz += oysterclam(span_notice("If you've got a quirky clam-licking tongue, you could try sticking that *lick in there."), user)
	terry_hintz += oysterclam(span_notice("If you're desperate and absolutely hate your gums, you could just crunch right through the shell. Wouldn't recommend it, though."), user)
	if(perl)
		terry_hintz += oysterclam(span_notice("Oh hey, there's a pearl in there!"), user)
	terry_hintz += oysterclam(span_notice("The world is your clam!"), user)
	. |= terry_hintz

/// Is our clam actually an oyster?
/obj/item/reagent_containers/food/snacks/clam/proc/roll_for_oyster()
	GLOB.clam_counter++
	if(GLOB.clam_counter > CLAM_OYSTER_THRESHOLD)
		GLOB.clam_counter = 0
		oysterify()
		return // yeah its totally an oyster
	clammify()

/obj/item/reagent_containers/food/snacks/clam/proc/oysterify()
	is_actually_oyster = TRUE
	destroy_innards()
	perl = new /obj/item/pearl(src)
	guts = new /obj/item/reagent_containers/food/snacks/clam_meat(src)
	shell = new /obj/item/reagent_containers/food/snacks/clam_shell(src)
	guts.oysterize()
	shell.oysterize()
	return TRUE // we're an oyster now (the name and such will be updated once we're revealed)

/obj/item/reagent_containers/food/snacks/clam/proc/clammify()
	destroy_innards()
	guts = new /obj/item/reagent_containers/food/snacks/clam_meat(src)
	shell = new /obj/item/reagent_containers/food/snacks/clam_shell(src)
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/null_innards()
	perl = null
	guts = null
	shell = null

/obj/item/reagent_containers/food/snacks/clam/proc/destroy_innards()
	if(perl)
		QDEL_NULL(perl)
	if(guts)
		QDEL_NULL(guts)
	if(shell)
		QDEL_NULL(shell)

/obj/item/reagent_containers/food/snacks/clam/attack(mob/living/M, mob/living/user, attackchain_flags, damage_multiplier)
	if(user.a_intent == INTENT_HARM && M && M == user)
		return ..()
	eat_clam(user)

/obj/item/reagent_containers/food/snacks/clam/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/ammo_casing/caseless/rock))
		pound_clam(user, W)
	else if(W && W.tool_behaviour == TOOL_SCREWDRIVER)
		screw_clam(user, W)
	. = ..()
	

/// Gasp! Someone found out we're an oyster! Reveal our secret identity! If we actually are an oyster, otherwise remain a clam
/obj/item/reagent_containers/food/snacks/clam/proc/reveal_secret_identity(mob/living/carbon/likcer)
	if(!is_actually_oyster)
		return
	if(secret_identity_revealed)
		return
	if(likcer)
		to_chat(likcer, span_notice("Oh! This clam is actually an oyster! Neat!"))
	name = "oyster"
	icon_state = "oyster"
	desc = replacetext(desc, "clam", "oyster") // brilliant
	secret_identity_revealed = TRUE
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/lick_clam(datum/source, mob/living/carbon/likcer, obj/item/hand_item/tongue)
	SIGNAL_HANDLER
	if(!likcer)
		return
	if(brokecheck(likcer))
		return
	if(!HAS_TRAIT(likcer, TRAIT_CLAM_TONGUE))
		to_chat(likcer, span_alert(oysterclam("You can't quite get your tongue in there! Maybe try a screwdriver or knife?", likcer)))
		return // fun fact, copilot can't STAND the word lic*er
	if(!guts)
		to_chat(likcer, span_alert(oysterclam("You fish your tongue around in there for a bit, but aw man, there's no meat!", likcer)))
		return // no guts no glory
	likcer.visible_message(oysterclam("Wizh a deft flick of your tongue, you dart in between a gap in the shell and lap out the meat!", likcer))
	eviscerate_clam(likcer, TRUE, tongue)

/obj/item/reagent_containers/food/snacks/clam/proc/screw_clam(mob/living/carbon/likcer, obj/item/screwer)
	if(!screwer || !likcer)
		return
	if(screwer.tool_behaviour != TOOL_SCREWDRIVER)
		to_chat(likcer, span_alert(oysterclam("You can't quite get that in there! Maybe try a knife or a screwdriver? Maybe ask someone for a scav?", likcer)))
		return
	if(brokecheck(likcer))
		return
	if(getting_screwed) // grow up
		to_chat(likcer, span_alert(oysterclam("You're already screwing this clam!")))
		return
	getting_screwed = TRUE
	if(!screwer.use_tool(src, likcer, 3 SECONDS))
		getting_screwed = FALSE
		to_chat(likcer, span_alert(oysterclam("Dang! The clam snapped back shut! Maybe try again?", likcer)))
		return
	playsound(src, 'sound/items/Crowbar.ogg', 75, TRUE)
	eviscerate_clam(likcer, FALSE, screwer)
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/pound_clam(mob/living/carbon/likcer, obj/item/rock)
	if(!rock || !likcer)
		return
	if(brokecheck(likcer))
		return
	otter_smacks_remaining--
	playsound(src, "swing_hit", 75, TRUE)
	switch(otter_smacks_remaining)
		if(3 to INFINITY)
			to_chat(likcer, span_alert(oysterclam("You pound the clam with the rock! It's starting to crack!")))
		if(2)
			to_chat(likcer, span_alert(oysterclam("You pound the clam with the rock! Cracks are forming in the shell!")))
		if(1)
			to_chat(likcer, span_alert(oysterclam("You pound the clam with the rock! The shell is starting to give!")))
		if(-INFINITY to 0)
			to_chat(likcer, span_alert(oysterclam("You pound the clam with the rock! The shell shatters and dumps out everything inside! Ew.")))
			QDEL_NULL(shell) // smash!
			eviscerate_clam(likcer, FALSE, rock)
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/eat_clam(mob/living/carbon/likcer)
	if(!likcer)
		return
	if(brokecheck(likcer))
		return
	if(HAS_TRAIT(likcer, TRAIT_CLAM_LOVER)) // zhey got shelltooth
		playsound(src, 'sound/items/Crowbar.ogg', 75, TRUE)
		to_chat(likcer, span_alert(oysterclam("You slot the clam around your shelltooth (or whatever it is you use to eat clams) and pop it open like a true scav!", likcer)))
		eviscerate_clam(likcer, FALSE, null)
		return
	getting_screwed = TRUE
	to_chat(likcer, span_alert(oysterclam("You stick the clam in your mouth and start to chomp down into the hard, gritty shell...", likcer)))
	if(!do_after(likcer, 3 SECONDS, TRUE, src))
		to_chat(likcer, span_notice(oysterclam("You spit out the clam shell cus seriously, why would you do that?", likcer)))
		getting_screwed = FALSE
		return
	getting_screwed = FALSE
	otter_smacks_remaining--
	INVOKE_ASYNC(src,PROC_REF(attempt_forcefeed), likcer, likcer)
	if(otter_smacks_remaining <= 0)
		to_chat(likcer, span_alert(oysterclam("You crunch down on the clam shell and it shatters in your mouth, dumping out everything inside all over the place! Ouch.", likcer)))
		QDEL_NULL(shell) // smash!
		eviscerate_clam(likcer, FALSE, null)
		return
	to_chat(likcer, span_alert(oysterclam("You crunch down on the clam shell and hear it (and your teeth, probably) crack! Maybe try again?", likcer)))
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/brokecheck(mob/living/carbon/likcer)
	if(guts || shell || perl)
		return
	to_chat(likcer, span_alert(oysterclam("You jimmy open the clam and find a note taped to the inner shell. it reads: 'Property of Buggerry Barne's Bugged Shellfish Emporium. If found, please call 1-800-IM-CODER and describe the events leading up to this thing's discovery. Thanks! -Lagg'", likcer)))

/obj/item/reagent_containers/food/snacks/clam/proc/eviscerate_clam(mob/living/carbon/likcer, eatit, obj/item/hand_item/tongue)
	if(is_actually_oyster && !secret_identity_revealed)
		reveal_secret_identity(likcer)
	var/turf/puthere = likcer.drop_location()
	if(likcer && loc == likcer)
		likcer.dropItemToGround(src)
	var/meat_handed = FALSE
	if(guts)
		guts.forceMove(puthere)
		if(likcer && !eatit)
			meat_handed = likcer.put_in_hands(guts)
	if(perl)
		perl.forceMove(puthere)
		if(!meat_handed)
			if(likcer)
				meat_handed = likcer.put_in_hands(perl)
	if(shell)
		shell.forceMove(puthere)
		if(likcer && !meat_handed)
			meat_handed = likcer.put_in_hands(shell)
	/// now we're just a shell of our former self
	/// stick the meat into the user's a, if possible
	/// if we were in a storage, try and stuff the stuff into the storage
	if(SEND_SIGNAL(loc, COMSIG_CONTAINS_STORAGE))
		if(perl)
			SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_INSERT, perl, null, TRUE)
		if(shell)
			SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_INSERT, shell, null, TRUE)
		if(guts && !meat_handed)
			SEND_SIGNAL(loc, COMSIG_TRY_STORAGE_INSERT, guts, null, TRUE)
	if(likcer)
		var/msg_out = ""
		if(guts)
			msg_out += "You've extracted the meat from the clam"
			if(eatit)
				msg_out += " and ate it!"
			else if(meat_handed)
				msg_out += " into your hand!"
			else
				msg_out += "!"
			if(shell)
				msg_out += " And the clam shell is intact too! Wonder what you could craft out of it?"
			if(perl)
				msg_out += " Oooh hey is that a clam pearl?"
		else
			msg_out += "You fish around in the clam for a bit, but there's no meat to be found!"
			if(shell)
				msg_out += " At least you've got the clam shell!"
				if(perl)
					msg_out += " And a pearl!"
			else
				if(perl)
					msg_out += " At least you've got a clam pearl out of it!"
		if(is_actually_oyster)
			if(!secret_identity_revealed)
				msg_out += " Oh also that clam was actually an oyster! Neat."
		to_chat(likcer, span_notice(oysterclam(msg_out, likcer, secret_identity_revealed)))
		secret_identity_revealed = TRUE
	if(eatit && guts)
		guts.bitesize = 1000
		INVOKE_ASYNC(guts,PROC_REF(attempt_forcefeed), likcer, likcer, TRUE)
	null_innards()
	qdel(src)

/obj/item/reagent_containers/food/snacks/clam/proc/oysterclam(msg_in, mob/living/lice, suppress_truth)
	if(is_actually_oyster && secret_identity_revealed && !suppress_truth)
		msg_in = replacetext(msg_in,"clam", "oyster")
	else
		if(prob(1) || (lice && HAS_TRAIT(lice, TRAIT_CLAM_TONGUE) && prob(50)))
			msg_in = replacetext(msg_in,"th", "zh") // yinglet
	return msg_in

/////////////////
// Meat
/obj/item/reagent_containers/food/snacks/clam_meat
	name = "clam meat"
	desc = "A delicious morsel of clam meat, both good for zhe body and soul. A local delicacy of weird rats on stilts."
	icon_state = "clam_meat"
	icon = 'icons/mob/clothing/clam.dmi'
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	tastes = list("seafood" = 4, "dirt" = 1, "weh" = 1)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/water = 2,
		/datum/reagent/consumable/sodiumchloride = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/clam_meat = 3,
		/datum/reagent/consumable/clam_juice = 5,
	)
	bitesize = 5
	filling_color = "#CD853F"

/obj/item/reagent_containers/food/snacks/clam_meat/proc/oysterize()
	name = "oyster meat"
	desc = "A delicious morsel of oyster meat, both good for zhe body and soul. A local rocky mountain delicacy of weird rats on stilts, despite not being a clam."
	icon_state = "oyster_meat"
	tastes = list("oyster" = 4, "dirt" = 1, "weh" = 1)

/////////////////
// Shell
/// Hard, sharp, and where it lacks in meat, it more than makes up for in shell
/obj/item/reagent_containers/food/snacks/clam_shell
	name = "clam shell"
	desc = "A hard, sharp clam shell. Where it lacks in meat, it more than makes up for in shell."
	icon = 'icons/mob/clothing/clam.dmi'
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	icon_state = "clam_shell"
	slot_flags = INV_SLOTBIT_HEAD // as a tiny dorky hat
	tastes = list("shell" = 4, "dirt" = 1, "weh" = 1)
	list_reagents = list(
		/datum/reagent/shell_shrapnel = 5,
		/datum/reagent/calciumcarbonate = 2,
	)
	bitesize = 3
	filling_color = "#CD853F"
	force = 25
	sharpness = SHARP_EDGED

/obj/item/reagent_containers/food/snacks/clam_shell/examine(mob/user)
	. = ..()
	. += span_notice("You can wear this as a tiny dorky hat! Or craft it into a cute, uncomfortable bra or codpiece!")
	. += span_notice("You *could* eat it, but that would be a terrible idea.")

/obj/item/reagent_containers/food/snacks/clam_shell/proc/oysterize()
	name = "oyster shell"
	desc = "A hard, sharp oyster shell. Where it lacks in meat, it more than makes up for in shell."
	icon_state = "oyster_shell"
	tastes = list("shell" = 4, "dirt" = 1, "weh" = 1)

/////////////////
// Pearl
/obj/item/pearl
	name = "clam pearl"
	desc = "A small, shiny pearl. Technically, it's a grain of sand that got stuck in a clam's mouth and was coated in layers of nacre so it wouldn't irritate the clam. And now it's yours! Should fetch a couple copper at the local scrapper, or be made into some cute jewelry hunny."
	icon = 'icons/mob/clothing/clam.dmi'
	icon_state = "pearl"
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	tastes = list("pearl" = 4, "dirt" = 1)
	grind_results = list(
		/datum/reagent/medicine/bicaridine = 4,
		/datum/reagent/medicine/kelotane = 4,
		/datum/reagent/medicine/mannitol = 4,
		/datum/reagent/medicine/salbutamol = 4,
		/datum/reagent/consumable/gibbfloats = 4,
		/datum/reagent/shell_shrapnel = 5,
	) // yeah thats what pearls are made of, right?

/obj/item/pearl/Initialize()
	. = ..()
	if(prob(5))
		icon_state = "pearl_jpg" // artifact pearl

/obj/item/pearl/examine(mob/user)
	. = ..()
	. += span_notice("This should fit in a produce bag! Also it is worth a lot more if crafted into a necklace and sold to the Scrapper.")

/// cool necklace
/obj/item/clothing/accessory/pearl_necklace // its like a scarf, but smaller, and made of pearls
	name = "pearl necklace"
	desc = "A dainty little necklace made from pearls strung up on some kind of string. \
		It is very pretty and clearly someone put a lot of effort into making it. \
		Some say you can get one for free, granted you have the right assets."
	icon = 'icons/mob/clothing/clam.dmi'
	icon_state = "pearl_necklace"
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/////////////////
// Bikini
/obj/item/clothing/accessory/shell_bra
	name = "seashell bra"
	desc = "A cute tropical bra made from seashells and string. It's as cute as it is impractical and utterly lacking in support, \
		which is saying something cus this bra is really really cute! Perfect for flat chested weird rats on stilts to pretend they have boobs."
	icon = 'icons/mob/clothing/clam.dmi'
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	icon_state = "clam_bra"
	slot_flags = INV_SLOTBIT_OCLOTHING|INV_SLOTBIT_ICLOTHING|INV_SLOTBIT_MASK|INV_SLOTBIT_NECK
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/obj/item/clothing/accessory/shell_bra/proc/oysterize()
	name = "oyster bra"
	desc = "A cute tropical bra made from oyster shells and string. It's as cute as it is impractical and utterly lacking in support, \
		which is saying something cus this bra is really really cute! Perfect for flat chested weird rats on stilts to pretend they have boobs."
	icon_state = "oyster_bra"

/////////////////
// Bikini
/obj/item/clothing/accessory/shell_codpiece
	name = "seashell codpiece"
	desc = "A cute tropical codpiece made from a seashell and string. It's as cute as it is impractical for anyone even remotely hung, \
		which is saying something cus this codpiece is really really cute! Perfect for weird rats on stilts to pretend they have a bulge."
	icon = 'icons/mob/clothing/clam.dmi'
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	icon_state = "clam_codpiece"
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/obj/item/clothing/accessory/shell_codpiece/proc/oysterize()
	name = "oyster codpiece"
	desc = "A cute tropical codpiece made from an oyster shell and string. It's as cute as it is impractical for anyone even remotely hung, \
		which is saying something cus this codpiece is really really cute! Perfect for weird rats on stilts to pretend they have a bulge. \
		Legally a troutpiece."
	icon_state = "oyster_codpiece"

/////////////////
// Actual Bikini
/obj/item/clothing/under/bikini/shell_bikini
	name = "seashell bikini"
	desc = "A cute tropical bikini made from seashells and string. It's as cute as it is impractical and utterly lacking in support, \
		which is saying something cus this bikini is really really cute! Perfect for flat chested weird rats on stilts to pretend they have boobs and or a bulge."
	icon = 'icons/mob/clothing/clam.dmi'
	icon_state = "clam_bikini"
	mob_overlay_icon = 'icons/mob/clothing/clam_onmob.dmi'
	slot_flags = INV_SLOTBIT_OCLOTHING|INV_SLOTBIT_ICLOTHING|INV_SLOTBIT_MASK|INV_SLOTBIT_NECK
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/datum/crafting_recipe/pearl_necklace
	name = "Pearl Necklace"
	result = /obj/item/clothing/accessory/pearl_necklace
	reqs = list(/obj/item/pearl = 7) // 28 fished clams
	time = 5
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/shell_bra
	name = "Seashell Bra"
	result = /obj/item/clothing/accessory/shell_bra
	reqs = list(/obj/item/reagent_containers/food/snacks/clam_shell = 1)
	customtext = list(
		/obj/item/reagent_containers/food/snacks/clam_shell = "Clam or Oyster shell(s)"
	)
	time = 5
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/shell_codpiece
	name = "Seashell Codpiece"
	result = /obj/item/clothing/accessory/shell_codpiece
	reqs = list(/obj/item/reagent_containers/food/snacks/clam_shell = 1)
	customtext = list(
		/obj/item/reagent_containers/food/snacks/clam_shell = "Clam or Oyster shell(s)"
	)
	time = 5
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/shell_bikini
	name = "Seashell Bikini"
	result = /obj/item/clothing/under/bikini/shell_bikini
	reqs = list(
		/obj/item/clothing/accessory/shell_codpiece = 1,
		/obj/item/clothing/accessory/shell_bra = 1,
	)
	time = 5
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/mood_event/clam_love
	description = span_nicegreen("I loved zhat clam!")
	mood_change = 7
	timeout = 10 MINUTES

/// the clam reagents
/datum/reagent/consumable/clam_meat
	name = "clam meat"
	taste_description = "seafood"
	taste_mult = 4
	value = REAGENT_VALUE_VERY_COMMON
	metabolization_rate = 1 * REAGENTS_METABOLISM
	nutriment_factor = 2 * REAGENTS_METABOLISM
	max_nutrition = INFINITY
	quality = 0
	ghoulfriendly = TRUE
	effective_blood_max = 200
	effective_blood_multiplier = 5
	var/yinglet_love = TRUE

/datum/reagent/consumable/clam_meat/pre_react(mob/living/M, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(!HAS_TRAIT(M, TRAIT_CLAM_LOVER))
		return
	taste_description = span_love("delicious clam")
	taste_mult = 20
	yinglet_love = TRUE
	metabolization_rate = 0.1 * REAGENTS_METABOLISM // lingers and heals longer
	nutriment_factor = 1 * REAGENTS_METABOLISM // so it doesnt ultrafat you so easily
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "clam", /datum/mood_event/clam_love)

/datum/reagent/consumable/clam_meat/on_mob_life(mob/living/carbon/M)
	if(HAS_TRAIT(M, TRAIT_NO_PROCESS_FOOD))
		return ..()
	if(!yinglet_love)
		. = TRUE
		return ..()
	if(M.health < 0)
		M.adjustToxLoss(-0.2*REM, 0)
		M.adjustBruteLoss(-0.2*REM, 0)
		M.adjustFireLoss(-0.2*REM, 0)
	M.adjustOxyLoss(-1 * effect_mult, 0)
	if(M.losebreath >= 4)
		M.losebreath -= 2 * effect_mult
	if(M.losebreath < 0)
		M.losebreath = 0
	M.adjustBruteLoss(-0.1*REM, FALSE)
	M.adjustFireLoss(-0.1*REM, FALSE)
	M.adjustOxyLoss(-0.1*REM, FALSE)
	M.adjustToxLoss(-0.1*REM, FALSE)
	. = 1
	if(prob(20 * effect_mult))
		M.AdjustAllImmobility(-20 * effect_mult, 0)
		M.AdjustUnconscious(-20 * effect_mult, 0)
	if(prob(0.5))
		M.emote("weh")
	..()

/datum/reagent/consumable/clam_juice
	name = "clam juice"
	taste_description = "clam juice"
	taste_mult = 5
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	value = REAGENT_VALUE_COMMON
	nutriment_factor = 5 * REAGENTS_METABOLISM
	max_nutrition = INFINITY
	quality = 0
	ghoulfriendly = TRUE

/datum/reagent/consumable/clam_juice/pre_react(mob/living/M, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(!HAS_TRAIT(M, TRAIT_CLAM_LOVER))
		return
	taste_description = span_love("clam juice")
	taste_mult = 20
	effective_blood_multiplier = 4
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "clam", /datum/mood_event/clam_love)

/datum/reagent/consumable/clammato_juice
	name = "clammato juice"
	taste_description = "clam and tomato juice"
	taste_mult = 5
	metabolization_rate = 0.75 * REAGENTS_METABOLISM
	value = REAGENT_VALUE_COMMON
	nutriment_factor = 5 * REAGENTS_METABOLISM
	max_nutrition = INFINITY
	quality = 0
	ghoulfriendly = TRUE
	var/yinglet_love = TRUE

/datum/reagent/consumable/clammato_juice/pre_react(mob/living/M, method=TOUCH, reac_volume, show_message = 1, touch_protection = 0)
	if(!HAS_TRAIT(M, TRAIT_CLAM_LOVER))
		return
	taste_description = "[span_love("clam")] and tomato juice"
	taste_mult = 20
	effective_blood_multiplier = 4
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "clam", /datum/mood_event/clam_love)

/datum/reagent/consumable/clammato_juice/on_mob_life(mob/living/carbon/M)
	if(M.get_blood(TRUE) < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(BLOOD_VOLUME_NORMAL, M.blood_volume + 1)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	..()
	. = TRUE

/datum/reagent/shell_shrapnel
	name = "shell shrapnel"
	metabolization_rate = 4 * REAGENTS_METABOLISM
	taste_description = "razor sharp shell fragments"
	taste_mult = 100
	value = REAGENT_VALUE_COMMON

// insta-hurt on apply
/datum/reagent/shell_shrapnel/reaction_mob(mob/living/M, method=INJECT, reac_volume)
	if(iscarbon(M))
		if(method == INGEST)
			var/obj/item/bodypart/head/hed = M.get_bodypart(BODY_ZONE_HEAD)
			if(hed)
				hed.receive_damage(
					brute = volume,
					burn = 0,
					stamina = volume,
					blocked = 0,
					updating_health = TRUE,
					required_status = null,
					wound_bonus = volume * 2,
					bare_wound_bonus = volume * 2,
					sharpness = SHARP_EDGED,
					damage_coverings = FALSE
				)
			to_chat(M, span_alert("You get a mouth full of sharp shell fragments! They really hurt!"))
		else
			var/obj/item/bodypart/party = M.get_bodypart(BODY_ZONE_CHEST)
			if(party)
				party.receive_damage(
					brute = volume,
					burn = 0,
					stamina = volume,
					blocked = 0,
					updating_health = TRUE,
					required_status = null,
					wound_bonus = volume * 2,
					bare_wound_bonus = volume * 2,
					sharpness = SHARP_EDGED,
					damage_coverings = FALSE
				)
			to_chat(M, span_alert("You feel sharp shell fragments enter your blood! They really hurt!"))
		M.emote("scream")
	..()

/datum/reagent/shell_shrapnel/on_mob_life(mob/living/carbon/M)
	. = ..()
	var/obj/item/bodypart/part = M.get_bodypart(pick(GLOB.main_body_parts))
	if(part)
		part.receive_damage(
			brute = volume,
			burn = 0,
			stamina = volume,
			blocked = 0,
			updating_health = TRUE,
			required_status = null,
			wound_bonus = 0,
			bare_wound_bonus = 0,
			sharpness = SHARP_EDGED,
			damage_coverings = FALSE
		)
		if(prob(10))
			M.emote("scream")

/datum/chemical_reaction/clammato_juice
	name = "Clammato Juice"
	id = "clammato_juice"
	results = list(/datum/reagent/consumable/clammato_juice = 2)
	required_reagents = list(
		/datum/reagent/consumable/clam_juice = 1,
		/datum/reagent/consumable/tomatojuice = 1
	)

/datum/chemical_reaction/clammato_juice2
	name = "Clammatochup Juice "
	id = "clammato_juice2"
	results = list(/datum/reagent/consumable/clammato_juice = 2)
	required_reagents = list(
		/datum/reagent/consumable/clam_juice = 1,
		/datum/reagent/consumable/ketchup = 1
	)

GLOBAL_VAR_INIT(clam_counter, 0)
GLOBAL_LIST_EMPTY(clam_fished)

/turf/open/indestructible/ground/outside/water/examine(mob/user)
	. = ..()
	var/clam_when = ClamWhen()
	if(clam_when > world.time)
		. += span_notice("This spot lacks clams! They should be back in around [DisplayTimeText(clam_when - world.time)].")
	else
		. += span_notice("You can see some clams in the water! Click on the water with an empty hand on grab intent to fish em out!")

/turf/open/indestructible/ground/outside/water/proc/ClamWhen()
	var/coords = atom2coords(src)
	return GLOB.clam_fished[coords]

/turf/open/indestructible/ground/outside/water/proc/HasClam()
	var/coords = atom2coords(src)
	var/time2 = GLOB.clam_fished[coords]
	if(time2 < world.time)
		GLOB.clam_fished -= coords
		return TRUE
	return FALSE

/turf/open/indestructible/ground/outside/water/proc/ClamFished()
	var/coords = atom2coords(src)
	GLOB.clam_fished[coords] = world.time + 1 HOURS

/turf/open/indestructible/ground/outside/water/attack_hand(mob/user, act_intent, attackchain_flags)
	. = ..()
	if(!user)
		return
	if(user.a_intent != INTENT_GRAB)
		return
	if(!HasClam())
		to_chat(user, span_notice("You fish around in the water for a bit, but there's no clams to be found! Someone must have dug em all up. Dang. Check back in about [DisplayTimeText(ClamWhen() - world.time)]."))
		return
	if(HAS_TRAIT(user, TRAIT_CLAM_FISHER))
		var/obj/item/reagent_containers/food/snacks/clam/clam = new /obj/item/reagent_containers/food/snacks/clam(get_turf(src))
		ClamFished()
		user.put_in_hands(clam)
		if(HAS_TRAIT(user, TRAIT_CLAM_LOVER))
			to_chat(user, span_notice("You jab your hand into the water and pull out a [span_love("clam~")]"))
		else
			to_chat(user, span_notice("You jab your hand into the water and pull out a clam!"))
		playsound(user, 'sound/effects/grab_clam.ogg', 75, TRUE)
		return
	else
		to_chat(user, span_notice("You start sifting through the mud for some clams..."))
		playsound(user, 'sound/effects/fish_for_clam.ogg', 75, TRUE)
		if(!do_after(user, 5 SECONDS, TRUE, src))
			to_chat(user, span_alert("You were interrupted!"))
			return
		if(prob(50))
			if(HAS_TRAIT(user, TRAIT_CLAM_LOVER))
				to_chat(user, span_notice("You find a [span_love("clam~")]"))
			else
				to_chat(user, span_notice("You find a clam! Neat!"))
			var/obj/item/reagent_containers/food/snacks/clam/clam = new /obj/item/reagent_containers/food/snacks/clam(get_turf(src))
			ClamFished()
			user.put_in_hands(clam)
			playsound(user, 'sound/effects/fished_clam.ogg', 75, TRUE)
		else
			to_chat(user, span_alert("Darn, it got away! It's still in there, maybe try again?"))



