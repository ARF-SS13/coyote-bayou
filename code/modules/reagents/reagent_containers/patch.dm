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
			to_chat(user, "<span class='warning'>The limb is missing!</span>")
			return
		if(!L.can_inject(user, TRUE, user.zone_selected, FALSE, TRUE)) //stopped by clothing, not by species immunity.
			return
		if(affecting.status != BODYPART_ORGANIC)
			to_chat(user, "<span class='notice'>Medicine won't work on a robotic limb!</span>")
			return
	..()

/obj/item/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return 0
	return 1 // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/reagent_containers/pill/patch/styptic
	name = "brute patch"
	desc = "Helps with brute injuries."
	list_reagents = list(/datum/reagent/medicine/styptic_powder = 20)
	icon_state = "bandaid_brute"

/obj/item/reagent_containers/pill/patch/silver_sulf
	name = "burn patch"
	desc = "Helps with burn injuries."
	list_reagents = list(/datum/reagent/medicine/silver_sulfadiazine = 20)
	icon_state = "bandaid_burn"

/obj/item/reagent_containers/pill/patch/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

/obj/item/reagent_containers/pill/patch/jet
	name = "Jet"
	desc = "A highly addictive meta-amphetamine that produces a fast-acting, intense euphoric high on the user."
	list_reagents = list(/datum/reagent/drug/jet = 10)
	icon_state = "bandaid_jet"

/obj/item/reagent_containers/pill/patch/turbo
	name = "Turbo"
	desc = "A chem that vastly increases the user's reflexes and slows their perception of time."
	list_reagents = list(/datum/reagent/drug/turbo = 5)
	icon_state = "bandaid_turbo"

/obj/item/reagent_containers/pill/patch/healingpowder
	name = "Healing Powder"
	desc = "A powder used to heal physical wounds derived from ground broc flowers and xander roots, commonly used by tribals."
	list_reagents = list(/datum/reagent/medicine/healing_powder = 10)
	icon_state = "bandaid_healingpowder"
	self_delay = 0

/obj/item/reagent_containers/pill/patch/healpoultice
	name = "Healing poultice"
	desc = "A concoction of broc flower, cave fungus, agrave fruit and xander root."
	list_reagents = list(/datum/reagent/medicine/healing_powder/poultice = 10)
	icon_state = "bandaid_healingpoultice"
	self_delay = 0

/obj/item/reagent_containers/pill/patch/healingpowder/custom
	name = "Healing Powder"
	desc = "A powder used to heal physical wounds derived from ground broc flowers and xander roots, commonly used by tribals."
	list_reagents = null
	icon_state = "bandaid_healingpowder"
	self_delay = 0

/obj/item/reagent_containers/pill/patch/bitterdrink
	name = "Bitter drink"
	desc = "A strong herbal healing concoction which enables wounded soldiers and travelers to tend to their wounds without stopping during journeys."
	list_reagents = list(/datum/reagent/medicine/bitter_drink = 15) 
	icon_state = "Voodoo"
	self_delay = 0

/obj/item/reagent_containers/pill/patch/healingpowder/berserker
	name = "Berserker Powder"
	desc = "a combination of psychadelic mushrooms and tribal drugs used by legion berserkers. Induces a trancelike state, allowing them much greater pain resistance. Extremely dangerous, even for those who are trained to use it. It's a really bad idea to use this if you're not a berserker. Even if you are, taking it for too long causes extreme symptoms when the trance ends."
	list_reagents = list(/datum/reagent/medicine/berserker_powder = 10)
	icon_state = "bandaid_berserkerpowder"
	self_delay = 0

