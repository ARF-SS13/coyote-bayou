/obj/item/reagent_containers/pill/patch
	name = "chemical patch"
	desc = "A chemical patch for touch based applications."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bandaid"
	item_state = "bandaid"
	possible_transfer_amounts = list()
	volume = 40
	apply_type = PATCH
	apply_method = "apply"
	self_delay = 30		// three seconds
	dissolvable = FALSE

/obj/item/reagent_containers/pill/patch/attack(mob/living/L, mob/user)
	if(ishuman(L))
		var/obj/item/bodypart/affecting = L.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return
		if(!L.can_inject(user, TRUE, user.zone_selected, FALSE, TRUE)) //stopped by clothing, not by species immunity.
			return
		if(affecting.status != BODYPART_ORGANIC)
			to_chat(user, span_notice("Medicine won't work on a robotic limb!"))
			return
	..()

/obj/item/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return 0
	return 1 // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/reagent_containers/pill/patch/styptic
	name = "brute patch"
	desc = "Helps with brute injuries."
	icon = 'icons/obj/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/styptic_powder = 20)
	icon_state = "bandaid_brute"

/obj/item/reagent_containers/pill/patch/silver_sulf
	name = "burn patch"
	desc = "Helps with burn injuries."
	icon = 'icons/obj/chemical.dmi'
	list_reagents = list(/datum/reagent/medicine/silver_sulfadiazine = 20)
	icon_state = "bandaid_burn"

/obj/item/reagent_containers/pill/patch/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

// ---------------------------------
// MED-X

/obj/item/reagent_containers/pill/patch/medx
	name = "Morphidol"
	desc = "A needle containing a single dose of Morphidol. This powerful drug will not only allow the user to take more damage before falling unconscious, but it'll help them recover from critical injuries.\
	IT IS NOT AN ADDICTIVE SUBSTANCE, AND IS INCREDIBLY DIFFICULT TO OVERDOSE ON"
	list_reagents = list(/datum/reagent/medicine/medx = 15) // Addiction is 16u. Technically it's worse than psycho overall, so larger dose-per-item makes it better for pure duration
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "hypo_medx"

// ---------------------------------
// JET

/obj/item/reagent_containers/pill/patch/jet
	name = "Staminup"
	desc = "This inhaler contains a stimulant that not only gives the user an euphoric high, but also causes them to have greatly increased stamina regeneration.\
	IT IS NOT AN ADDICTIVE SUBSTANCE, AND IS INCREDIBLY DIFFICULT TO OVERDOSE ON."
	list_reagents = list(/datum/reagent/drug/jet = 10)
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_jet"

// ---------------------------------
// TURBO

/obj/item/reagent_containers/pill/patch/turbo
	name = "Speedster"
	desc = "Speedster is a powerful drug that pushes the user's body into overdrive, allowing them to temporarily ignore any slowness caused by injuries or bloodloss.\
	IT IS NOT AN ADDICTIVE SUBSTANCE, AND IS INCREDIBLY DIFFICULT TO OVERDOSE ON."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_turbo"
	list_reagents = list(/datum/reagent/drug/turbo = 5)

// ---------------------------------
// PSYCHO

/obj/item/reagent_containers/pill/patch/psycho
	name = "Berserk"
	desc = "A single-use pack of Beserk, this drug is tailor made for a frontline combatant. Users are much harder to both stun and knock unconscious, and gain a large boost in strength.\
	IT IS NOT AN ADDICTIVE SUBSTANCE, AND IS INCREDIBLY DIFFICULT TO OVERDOSE ON."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "hypo_psycho"
	list_reagents = list(/datum/reagent/drug/psycho = 10)

// ---------------------------------
// STEADY

/obj/item/reagent_containers/pill/patch/steady
	name = "Marksman"
	desc = "This inhaler is filled with the combat drug known as 'Marksman.' While under its effects, the user will find it much easier to control any weapon's recoil.\
	IT IS NOT AN ADDICTIVE SUBSTANCE, AND IS INCREDIBLY DIFFICULT TO OVERDOSE ON"
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "hypo_steady"
	list_reagents = list(/datum/reagent/drug/steady = 10)

// ---------------------------------
// HEALING POWDER

/obj/item/reagent_containers/pill/healingpowder // 50hp over 50 seconds.
	name = "Healing powder"
	desc = "A powder used to heal physical wounds derived from ground broc flowers and xander roots, commonly used by tribals."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_healingpowder"
	list_reagents = list(/datum/reagent/medicine/healing_powder = 10)
	self_delay = 5

/obj/item/reagent_containers/pill/healingpowder/random
	name = "randomized powder"
	desc = "A long forgotten prescription. who knows what it contains."
	color = COLOR_PALE_GREEN_GRAY

/obj/item/reagent_containers/pill/healingpowder/random/Initialize()
	list_reagents = list(get_random_reagent_id() = rand(5,15))
	var/powder_name = pick("candy", "fun", "discarded", "forgotten", "old", "ancient", "random", "unknown", "strange", "abandoned", "hobo", "trash", "forsaken", "alluring", "peculiar", "anomalous", "unfamiliar", "odd", "funny", "tasty", "neglected", "mysterious", "strange")
	name = "[powder_name] powder"
	. = ..()



// ---------------------------------
// CUSTOM POWDER

/obj/item/reagent_containers/pill/healingpowder/custom
	name = "Homebrew powder"
	desc = "A mysterious mix of powders."
	list_reagents = null
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_healingpowder"
	self_delay = 5
	color = COLOR_PALE_GREEN_GRAY

// ---------------------------------
// HEALING POULTICE

/obj/item/reagent_containers/pill/patch/healpoultice // 100hp over 50 seconds. a bit more potent than just bitters.
	name = "Healing poultice"
	desc = "A concoction of broc flower, cave fungus, agrave fruit and xander root."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	list_reagents = list(/datum/reagent/medicine/healing_powder/poultice = 10, /datum/reagent/medicine/healing_powder = 10, /datum/reagent/medicine/bicaridine = 5, /datum/reagent/medicine/kelotane = 5)
	icon_state = "patch_healingpoultice"
	self_delay = 5

// ---------------------------------
// BITTER DRINK

/obj/item/reagent_containers/pill/bitterdrink // 50hp over 25 seconds
	name = "Bitter drink"
	desc = "A strong herbal healing concoction invented and created by the Twin Mothers tribe."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_bitterdrink"
	list_reagents = list(/datum/reagent/medicine/healing_powder = 5, /datum/reagent/medicine/bicaridine = 5, /datum/reagent/medicine/kelotane = 5)
	self_delay = 5

// ---------------------------------
// HYDRA - never a thing, make it something. Sprites done. *Kelpnote- perfect chem for healing Wound damage since that's an unfilled niche.

/* /obj/item/reagent_containers/pill/patch/hydra
	name = "Hydra"
	desc = "Hydra is a drug developed from antivenom. Due to the Legion's disapproval of using modern medicine, some Legionaries attempted to develop a different means to help them heal damaged limbs. To do that, they combined cave fungus, nightstalker blood and the poison from a radscorpion poison gland with antivenom before use. This resulted in the development of Hydra, a curative agent that both anesthetizes and restores crippled limbs over time."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "patch_hydra"
	list_reagents = null
	self_delay = 0
 */

// ---------------------------------
// Ambrosia

/obj/item/reagent_containers/pill/redambrosia // Heals 100 brute and 50 everything else, deals 20 stamloss
	name = "Elixir Vitae"
	desc = "A mysterious, sweet tasting and scented red fluid flows within this bottle. Its held back by a cork stopper, which keeps it from spilling prematurely. Nicknamed 'the food of the gods', this red ambrosia is unparalelled in its healing factor on the body."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_redambrosia"
	list_reagents = list(/datum/reagent/red_ambrosia = 1)
	self_delay = 5 SECONDS

/obj/item/reagent_containers/pill/blueambrosia // Heals brain damage and traumas
	name = "Elixir Mentem"
	desc = "A mysterious, sweet tasting and scented blue fluid flows within this bottle. Its held back by a cork stopper, which keeps it from spilling prematurely. Nicknamed 'the food of the gods', this blue ambrosia is unparalelled in its healing factor on the mind."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_blueambrosia"
	list_reagents = list(/datum/reagent/blue_ambrosia = 1)
	self_delay = 5 SECONDS

/obj/item/reagent_containers/pill/greenambrosia // Heals 100 damage to all internal organs
	name = "Elixir Animae"
	desc = "A mysterious, sweet tasting and scented green fluid flows within this bottle. Its held back by a cork stopper, which keeps it from spilling prematurely. Nicknamed 'the food of the gods', this green ambrosia is unparalelled in its healing factor on one's internals."
	icon = 'icons/fallout/objects/medicine/drugs.dmi'
	icon_state = "pill_greenambrosia"
	list_reagents = list(/datum/reagent/green_ambrosia = 1)
	self_delay = 5 SECONDS

/obj/item/reagent_containers/pill/patch/random
	name = "randomized patch"
	desc = "A long forgotten prescription. who knows what it contains."
	icon_state = "bandaid"

/obj/item/reagent_containers/pill/patch/random/Initialize()
	list_reagents = list(get_random_reagent_id() = rand(5,15))
	var/patch_name = pick("candy", "fun", "discarded", "forgotten", "old", "ancient", "random", "unknown", "strange", "abandoned", "hobo", "trash", "forsaken", "alluring", "peculiar", "anomalous", "unfamiliar", "odd", "funny", "tasty", "neglected", "mysterious", "strange")
	name = "[patch_name] patch"
	. = ..()
