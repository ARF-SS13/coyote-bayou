/* 
 * File:   clam_quirks.dm
 * Author: wubbalubbadubdub
 * Date: 2020-07-30
 * License: DK GG-NO-RE 4.0
 * 
 * Description: A bunch of clamstuffs for yinglets, cus we both have them and I like them
  */

/datum/quirk/clam_tongue
	name = "Clam Licker"
	desc = "Through some sort of adaptation to a questionable seafood diet, your tongue is specially shaped for yoinking the meat out of various bivalves (clams, oysters, etc)."
	value = 5
	category = "Food Quirks"
	mechanics = "You can lick clams to extract their meat and eat it, like some kind of wierd bird rat."
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
	mechanics = "Clam meat gives you a significant mood boost! However they can be quite addicting..."
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
	mechanics = "You can click on water tiles to fish for clams with your bare hands."
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
	icon = 'icons/obj/food.dmi'
	icon_state = "clam"
	desc = "Nature's lunchbox! Inside is a delicious morsel of clam meat, both good for zhe body and soul. Course, you gotta get it out first."
	inedible = TRUE // sorta
	tastes = list("seafood" = 4, "dirt" = 1, "pointy" = 1)
	list_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/water = 2,
		/datum/reagent/consumable/sodiumchloride = 3,
		/datum/reagent/consumable/iron = 1,
		/datum/reagent/consumable/vitamin = 2,
		/datum/reagent/consumable/clam_meat = 6,
		/datum/reagent/consumable/clam_juice = 14,
		/datum/reagent/shell_shrapnel = 10,
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

/obj/item/reagent_containers/food/snacks/clam/examine(mob/user)
	. = ..()
	var/list/terry_hintz = list()
	terry_hintz += span_notice("Maybe try jimmying open the shell with a screwdriver or knife, or just smash it with a rock like an otter.")
	terry_hintz += span_notice("If you've got an oddly-specific clam-licking tongue, you could try sticking that *lick in there.")
	terry_hintz += span_notice("<b>Or</b> if you've got some serious chompers and an absolute contempt for your gums, you could just crunch right through the shell.")
	terry_hintz += span_notice("The world is your clam!")
	if(is_actually_oyster && secret_identity_revealed)
		var/list/terrier_hintz = list()
		for(var/hint in terry_hintz)
			terrier_hintz += replacetext(hint, "clam", "oyster")
		terry_hintz = terrier_hintz
	. |= terry_hintz

/// Is our clam actually an oyster?
/obj/item/reagent_containers/food/snacks/clam/proc/roll_for_oyster()
	if(prob(5))
		oysterify()
		return // yeah its totally an oyster
	clammify()

/obj/item/reagent_containers/food/snacks/clam/proc/oysterify()
	is_actually_oyster = TRUE
	destroy_innards()
	perl = new /obj/item/pearl(src)
	guts = new /obj/item/reagent_containers/food/snacks/clam_meat/oyster(src)
	shell = new /obj/item/reagent_containers/food/snacks/clam_shell/oyster(src)
	return TRUE // we're an oyster now (the name and such will be updated once we're revealed)

/obj/item/reagent_containers/food/snacks/clam/proc/clammify()
	destroy_innards()
	guts = new /obj/item/reagent_containers/food/snacks/clam_meat/clam(src)
	shell = new /obj/item/reagent_containers/food/snacks/clam_shell/clam(src)
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
		to_chat(likcer, span_notice(oysterclam("Oh! This clam is actually an oyster! Neat!", likcer)))
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
	eviscerate_clam(likcer, tongue)

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
	eviscerate_clam(likcer, screwer)
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
		if(0 to -INFINITY)
			to_chat(likcer, span_alert(oysterclam("You pound the clam with the rock! The shell shatters and dumps out everything inside! Ew.")))
			QDEL_NULL(shell) // smash!
			eviscerate_clam(likcer, rock)
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/eat_clam(mob/living/carbon/likcer)
	if(!likcer)
		return
	if(brokecheck(likcer))
		return
	if(HAS_TRAIT(likcer, TRAIT_CLAM_LOVER)) // zhey got shelltooth
		playsound(src, 'sound/items/Crowbar.ogg', 75, TRUE)
		to_chat(likcer, span_alert(oysterclam("You slot the clam around your shelltooth (or whatever it is you use to eat clams) and pop it open like a true scav!", likcer)))
		eviscerate_clam(likcer, null)
		return
	getting_screwed = TRUE
	to_chat(likcer, span_alert(oysterclam("You stick the clam in your mouth and start to chomp down into the hard, gritty shell...", likcer)))
	if(!do_after(likcer, 3 SECONDS, TRUE, src))
		to_chat(likcer, span_notice(oysterclam("You spit out the clam shell cus seriously, why would you do that?", likcer)))
		getting_screwed = FALSE
		return
	getting_screwed = FALSE
	otter_smacks_remaining--
	if(otter_smacks_remaining <= 0)
		to_chat(likcer, span_alert(oysterclam("You crunch down on the clam shell and it shatters in your mouth, dumping out everything inside all over the place! Ouch.", likcer)))
		QDEL_NULL(shell) // smash!
		eviscerate_clam(likcer, null)
		return
	to_chat(likcer, span_alert(oysterclam("You crunch down on the clam shell and hear it (and your teeth, probably) crack! Maybe try again?", likcer)))
	INVOKE_ASYNC(src,PROC_REF(attempt_forcefeed), likcer, likcer)
	return TRUE

/obj/item/reagent_containers/food/snacks/clam/proc/brokecheck(mob/living/carbon/likcer)
	if(guts || shell || perl)
		return
	to_chat(likcer, span_alert(oysterclam("You jimmy open the clam and find a note taped to the inner shell. it reads: 'Property of Buggerry Barne's Bugged Shellfish Emporium. If found, please call 1-800-IM-CODER and describe the events leading up to this thing's discovery. Thanks! -Lagg'", likcer)))

/obj/item/reagent_containers/food/snacks/clam/proc/eviscerate_clam(mob/living/carbon/likcer, obj/item/hand_item/tongue)
	if(is_actually_oyster && !secret_identity_revealed)
		reveal_secret_identity(likcer)
	var/turf/puthere = likcer.drop_location()
	if(likcer && loc == likcer)
		likcer.dropItemToGround(src)
	var/meat_handed = FALSE
	if(guts)
		guts.forceMove(puthere)
		if(likcer)
			meat_handed = likcer.put_in_hands(guts)
	if(perl)
		perl.forceMove(puthere)
	if(shell)
		shell.forceMove(puthere)
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
			if(meat_handed)
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
			else
				msg_out.replacetext("clam", "oyster")
		to_chat(likcer, span_notice(oysterclam(msg_out, likcer)))
	null_innards()
	qdel(src)

/obj/item/reagent_containers/food/snacks/clam/proc/oysterclam(msg_in, mob/living/lice)
	if(is_actually_oyster)
		msg_in.replacetext("clam", "oyster")
	else
		if(prob(1) || (lice && HAS_TRAIT(lice, TRAIT_CLAM_TONGUE) && prob(50)))
			msg_in.replacetext("th", "zh") // yinglet
	return msg_in




