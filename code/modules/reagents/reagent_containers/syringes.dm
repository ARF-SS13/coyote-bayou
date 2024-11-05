/obj/item/reagent_containers/syringe
	name = "syringe"
	desc = "A syringe that can hold up to 15 units."
	icon = 'icons/obj/syringe.dmi'
	inhand_icon_state = "syringe_0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	icon_state = "0"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list()
	volume = 15
	var/mode = SYRINGE_DRAW
	var/busy = FALSE		// needed for delayed drawing of blood
	var/proj_piercing = 0 //does it pierce through thick clothes when shot with syringe gun
	var/show_filling = TRUE
	custom_materials = list(/datum/material/iron=10, /datum/material/glass=20)
	reagent_flags = TRANSPARENT
	custom_price = PRICE_CHEAP_AS_FREE
	sharpness = SHARP_POINTY

/obj/item/reagent_containers/syringe/Initialize()
	. = ..()
	if(list_reagents) //syringe starts in inject mode if its already got something inside
		mode = SYRINGE_INJECT
		update_icon()

/obj/item/reagent_containers/syringe/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/reagent_containers/syringe/on_reagent_change(changetype)
	update_icon()

/obj/item/reagent_containers/syringe/pickup(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/syringe/dropped(mob/user)
	..()
	update_icon()

/obj/item/reagent_containers/syringe/attack_self(mob/user)
	mode = !mode
	update_icon()

/obj/item/reagent_containers/syringe/on_attack_hand()
	. = ..()
	update_icon()

/obj/item/reagent_containers/syringe/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/reagent_containers/syringe/attackby(obj/item/I, mob/user, params)
	return

/obj/item/reagent_containers/syringe/attack()
	return			// no bludgeoning.

/obj/item/reagent_containers/syringe/afterattack(atom/target, mob/user, proximity)
	. = ..()
	INVOKE_ASYNC(src,PROC_REF(attempt_inject), target, user, proximity)

/obj/item/reagent_containers/syringe/proc/attempt_inject(atom/target, mob/user, proximity)
	if(busy)
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!L.can_inject(user, 1))
			return

	// chance of monkey retaliation
	if(ismonkey(target) && prob(MONKEY_SYRINGE_RETALIATION_PROB))
		var/mob/living/carbon/monkey/M
		M = target
		M.retaliate(user)

	switch(mode)
		if(SYRINGE_DRAW)

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("The syringe is full."))
				return

			if(L) //living mob
				var/drawn_amount = reagents.maximum_volume - reagents.total_volume
				if(target != user)
					target.visible_message(span_danger("[user] is trying to take a blood sample from [target]!"), \
									span_userdanger("[user] is trying to take a blood sample from [target]!"))
					busy = TRUE
					if(!do_mob(user, target, extra_checks=CALLBACK(L, /mob/living/proc/can_inject,user,1), allow_incap = TRUE, allow_lying = TRUE, public_progbar = TRUE))
						busy = FALSE
						return
					if(reagents.total_volume >= reagents.maximum_volume)
						return
				busy = FALSE
				if(L.transfer_blood_to(src, drawn_amount))
					user.visible_message("[user] takes a blood sample from [L].")
				else
					to_chat(user, span_warning("You are unable to draw any blood from [L]!"))

			else //if not mob
				if(!target.reagents.total_volume)
					to_chat(user, span_warning("[target] is empty!"))
					return

				if(!target.is_drawable())
					to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
					return

				var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, log = TRUE)	// transfer from, transfer to - who cares?

				to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
			if (round(reagents.total_volume, 0.1) >= reagents.maximum_volume)
				mode=!mode
				update_icon()

		if(SYRINGE_INJECT)
			// Always log attemped injections for admins
			var/contained = reagents.log_list()
			log_combat(user, target, "attempted to inject", src, addition="which had [contained]")

			if(!reagents.total_volume)
				to_chat(user, span_notice("[src] is empty."))
				return

			if(!L && !target.is_injectable()) //only checks on non-living mobs, due to how can_inject() handles
				to_chat(user, span_warning("You cannot directly fill [target]!"))
				return

			if(target.reagents.total_volume >= target.reagents.maximum_volume)
				to_chat(user, span_notice("[target] is full."))
				return

			if(L) //living mob
				if(!L.can_inject(user, TRUE))
					return
				if(L != user)
					L.visible_message(span_danger("[user] is trying to inject [L]!"), \
											span_userdanger("[user] is trying to inject [L]!"))
					if(!do_mob(user, target, extra_checks=CALLBACK(L, /mob/living/proc/can_inject,user,1), allow_incap = TRUE, allow_lying = TRUE, public_progbar = TRUE))
						return
					if(!reagents.total_volume)
						return
					if(L.reagents.total_volume >= L.reagents.maximum_volume)
						return
					L.visible_message("<span class='danger'>[user] injects [L] with the syringe!", \
									span_userdanger("[user] injects [L] with the syringe!"))

				if(L != user)
					log_combat(user, L, "injected", src, addition="which had [contained]")
				else
					L.log_message("injected themselves ([contained]) with [src.name]", LOG_ATTACK, color="orange")
			var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)
			reagents.reaction(L, INJECT, fraction)
			reagents.trans_to(target, amount_per_transfer_from_this, log = TRUE)
			to_chat(user, span_notice("You inject [amount_per_transfer_from_this] units of the solution. The syringe now contains [reagents.total_volume] units."))
			if (reagents.total_volume <= 0 && mode==SYRINGE_INJECT)
				mode = SYRINGE_DRAW
				update_icon()

/obj/item/reagent_containers/syringe/update_icon_state()
	var/rounded_vol = get_rounded_vol()
	icon_state = "[rounded_vol]"
	inhand_icon_state = "syringe_[rounded_vol]"

/obj/item/reagent_containers/syringe/update_overlays()
	. = ..()
	if(show_filling)
		var/rounded_vol = get_rounded_vol()
		if(reagents && reagents.total_volume)
			. += mutable_appearance('icons/obj/reagentfillings.dmi', "syringe[rounded_vol]", color = mix_color_from_reagents(reagents.reagent_list))
	if(ismob(loc))
		var/injoverlay
		switch(mode)
			if (SYRINGE_DRAW)
				injoverlay = "draw"
			if (SYRINGE_INJECT)
				injoverlay = "inject"
		. += injoverlay

///Used by update_icon() and update_overlays()
/obj/item/reagent_containers/syringe/proc/get_rounded_vol()
	if(reagents && reagents.total_volume)
		return clamp(round((reagents.total_volume / volume * 15),5), 1, 15)
	else
		return 0

/obj/item/reagent_containers/syringe/epinephrine
	name = "syringe (epinephrine)"
	desc = "Contains epinephrine - used to stabilize patients."
	list_reagents = list(/datum/reagent/medicine/epinephrine = 15)

/obj/item/reagent_containers/syringe/charcoal
	name = "syringe (charcoal)"
	desc = "Contains charcoal."
	list_reagents = list(/datum/reagent/medicine/charcoal = 15)

/obj/item/reagent_containers/syringe/sanguirite
	name = "syringe (sanguirite)"
	desc = "Contains sanguirite."
	list_reagents = list(/datum/reagent/medicine/coagulant = 15)

/obj/item/reagent_containers/syringe/antiviral
	name = "syringe (penicillin)"
	desc = "Contains antiviral agents."
	list_reagents = list(/datum/reagent/medicine/spaceacillin = 15)

/obj/item/reagent_containers/syringe/bioterror
	name = "bioterror syringe"
	desc = "Contains several paralyzing reagents."
	list_reagents = list(/datum/reagent/consumable/ethanol/neurotoxin = 5, /datum/reagent/toxin/mutetoxin = 5, /datum/reagent/toxin/sodium_thiopental = 5)

/obj/item/reagent_containers/syringe/stimulants
	name = "Stimulants"
	desc = "Contains stimulants."
	amount_per_transfer_from_this = 50
	volume = 50
	list_reagents = list(/datum/reagent/medicine/stimulants = 50)

/obj/item/reagent_containers/syringe/calomel
	name = "syringe (calomel)"
	desc = "Contains calomel."
	list_reagents = list(/datum/reagent/medicine/calomel = 15)

/obj/item/reagent_containers/syringe/plasma
	name = "syringe (plasma)"
	desc = "Contains plasma."
	list_reagents = list(/datum/reagent/toxin/plasma = 15)

/obj/item/reagent_containers/syringe/lethal
	name = "lethal injection syringe"
	desc = "A syringe used for lethal injections. It can hold up to 50 units."
	amount_per_transfer_from_this = 50
	volume = 50

/obj/item/reagent_containers/syringe/lethal/choral
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 50)

/obj/item/reagent_containers/syringe/lethal/execution
	list_reagents = list(/datum/reagent/toxin/amatoxin = 15, /datum/reagent/toxin/formaldehyde = 15, /datum/reagent/toxin/cyanide = 10, /datum/reagent/toxin/acid/fluacid = 10) //Citadel edit, changing out plasma from lethals

/obj/item/reagent_containers/syringe/mulligan
	name = "Mulligan"
	desc = "A syringe used to completely change the users identity."
	amount_per_transfer_from_this = 1
	volume = 1
	list_reagents = list(/datum/reagent/mulligan = 1)

/obj/item/reagent_containers/syringe/gluttony
	name = "Gluttony's Blessing"
	desc = "A syringe recovered from a dread place. It probably isn't wise to use."
	amount_per_transfer_from_this = 1
	volume = 1
	list_reagents = list(/datum/reagent/gluttonytoxin = 1)

/obj/item/reagent_containers/syringe/bluespace
	name = "bluespace syringe"
	desc = "An advanced syringe that can hold 60 units of chemicals."
	amount_per_transfer_from_this = 20
	volume = 60

/obj/item/reagent_containers/syringe/large
	name = "large syringe"
	desc = "An advanced syringe that can hold 30 units of chemicals."
	amount_per_transfer_from_this = 10
	volume = 30

/obj/item/reagent_containers/syringe/xlarge
	name = "X-large syringe"
	desc = "An advanced syringe that can hold 45 units of chemicals."
	amount_per_transfer_from_this = 15
	volume = 45

/obj/item/reagent_containers/syringe/noreact
	name = "cryo syringe"
	desc = "An advanced syringe that stops reagents inside from reacting. It can hold up to 20 units."
	volume = 20
	reagent_flags = TRANSPARENT | NO_REACT

/obj/item/reagent_containers/syringe/piercing
	name = "piercing syringe"
	desc = "A diamond-tipped syringe that pierces armor when launched at high velocity. It can hold up to 10 units."
	volume = 10
	proj_piercing = 1

/obj/item/reagent_containers/syringe/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

/obj/item/reagent_containers/syringe/dart
	name = "medicinal smartdart"
	desc = "A non-harmful dart that can administer medication from a range. Once it hits a patient, using its smart nanofilter technology only medicines contained within the dart are administered to the patient. Additonally, due to capillary action, injection of chemicals past the overdose limit is prevented."
	volume = 20
	amount_per_transfer_from_this = 20
	icon_state = "empty"
	inhand_icon_state = "syringe_empty"
	show_filling = FALSE
	var/emptrig = FALSE

/obj/item/reagent_containers/syringe/dart/afterattack(atom/target, mob/user , proximity)

	if(busy)
		return
	if(!proximity)
		return
	if(!target.reagents)
		return

	var/mob/living/L
	if(isliving(target))
		L = target
		if(!L.can_inject(user, 1))
			return

	switch(mode)
		if(SYRINGE_DRAW)

			if(reagents.total_volume >= reagents.maximum_volume)
				to_chat(user, span_notice("The dart is full!"))
				return

			if(L) //living mob
				to_chat(user, span_warning("You can't draw blood using a dart!"))
				return

			else //if not mob
				if(!target.reagents.total_volume)
					to_chat(user, span_warning("[target] is empty!"))
					return

				if(!target.is_drawable())
					to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
					return

				var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this)

				to_chat(user, span_notice("You soak the [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))
			if (round(reagents.total_volume,1) >= reagents.maximum_volume)
				mode=!mode
				update_icon()

		if(SYRINGE_INJECT)
			src.visible_message(span_danger("The smartdart gives a frustrated boop! It's fully saturated; You need to shoot someone with it!"))

/obj/item/reagent_containers/syringe/dart/attack_self(mob/user)
	return

/obj/item/reagent_containers/syringe/dart/update_icon_state()
	var/empty_full = "empty"
	if(round(reagents.total_volume, 1) == reagents.maximum_volume)
		empty_full = "full"
		mode = SYRINGE_INJECT
	icon_state = "[empty_full]"
	inhand_icon_state = "syringe_[empty_full]"

/obj/item/reagent_containers/syringe/dart/emp_act(severity)
	emptrig = TRUE
	..()

/obj/item/reagent_containers/syringe/dart/bluespace
	name = "bluespace smartdart"
	desc = "A non-harmful dart that can administer medication from a range. Once it hits a patient, using its smart nanofilter technology only medicines contained within the dart are administered to the patient. Additonally, due to capillary action, injection of chemicals past the overdose limit is prevented. Has an extended volume capacity thanks to bluespace foam."
	amount_per_transfer_from_this = 50
	volume = 50

/obj/item/reagent_containers/syringe/random
	name = "randomized syringe"
	desc = "A long forgotten prescription. who knows what it contains."

/obj/item/reagent_containers/syringe/random/Initialize()
	list_reagents = list(get_random_reagent_id() = rand(5,15))
	var/syringe_name = pick("candy", "fun", "discarded", "forgotten", "old", "ancient", "random", "unknown", "strange", "abandoned", "hobo", "trash", "forsaken", "alluring", "peculiar", "anomalous", "unfamiliar", "odd", "funny", "tasty", "neglected", "mysterious", "strange")
	name = "[syringe_name] syringe"
	. = ..()
