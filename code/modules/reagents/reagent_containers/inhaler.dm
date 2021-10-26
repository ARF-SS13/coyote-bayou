/obj/item/reagent_containers/inhaler // all a fortuna addition
	name = "inhaler"
	desc = "A generic inhaler."
	icon = 'icons/obj/chemical.dmi'
	item_state = "bandaid_jet"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	icon_state = "hypo"
	amount_per_transfer_from_this = 5
	volume = 25
	possible_transfer_amounts = list()
	resistance_flags = ACID_PROOF
	slot_flags = ITEM_SLOT_BELT
	var/ignore_flags = 0
	var/shaken = FALSE
	var/infinite = FALSE
	var/shake_time = 50
	var/delay = 0

/obj/item/reagent_containers/inhaler/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/reagent_containers/inhaler/attack_self(mob/user)
	if(shaken == TRUE)
		return
	if(shaken == FALSE)
		playsound(src, 'sound/f13effects/inhalershake.ogg', 50, 0)
		shakeinhaler(user)
		return

/obj/item/reagent_containers/inhaler/proc/resetshake()
	shaken = FALSE
	return

/obj/item/reagent_containers/inhaler/proc/shakeinhaler(mob/living/user)
	if(!shaken && do_after(user, 25, target = src))
		to_chat(user, "<span class='warning'>You shake up the [src]!</span>")
		shaken = TRUE
		return

/obj/item/reagent_containers/inhaler/attack(mob/living/M, mob/user)
	if(shaken == FALSE)
		to_chat(user, "<span class='warning'>The [src] needs shaking!</span>")
		return
	if(!reagents.total_volume)
		to_chat(user, "<span class='warning'>The [src] is empty!</span>")
		return
	if(!iscarbon(M))
		return

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/R in reagents.reagent_list)
		injected += R.name
	var/contained = english_list(injected)
	log_combat(user, M, "attempted to force", src, "to use an inhaler", "([contained])")

	if(reagents.total_volume && (ignore_flags || M.can_inject(user, 1))) // Ignore flag should be checked first or there will be an error message.
		to_chat(M, "<span class='warning'>You feel a rush of air in the back of your throat!</span>")
		playsound(src, 'sound/f13effects/inhaler.ogg', 50, 0)
		new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(M))
		to_chat(user, "<span class='notice'>You make [M] inhale the [src].</span>")
		resetshake(user)

		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)
		reagents.reaction(M, INJECT, fraction)
		if(M.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(M, amount_per_transfer_from_this)
			else
				trans = reagents.copy_to(M, amount_per_transfer_from_this)

			to_chat(user, "<span class='notice'>[trans] unit\s inhaled. [reagents.total_volume] unit\s remaining in \The [src].</span>")


			log_combat(user, M, "inhaled", src, "([contained])")

/obj/item/reagent_containers/inhaler/jet
	name = "jet inhaler"
	icon_state = "bandaid_jet"
	desc = "A small, disposable red inhaler. You're better off not asking where the gas comes from."
	list_reagents = list(/datum/reagent/drug/jet = 20)

/obj/item/reagent_containers/inhaler/turbo
	name = "turbo inhaler"
	icon_state = "bandaid_turbo"
	amount_per_transfer_from_this = 3
	desc = "A jet inhaler crudely duct-taped to a can of HairStylez hairspray. This doesn't look healthy!"
	list_reagents = list(/datum/reagent/drug/turbo = 12)

/obj/item/reagent_containers/inhaler/addictol
	name = "addictol inhaler"
	icon_state = "bandaid_addictol"
	desc = "A blue inhaler with a white A across the front of the cylinder. Addictol - by junkies, for junkies!"
	list_reagents = list(/datum/reagent/medicine/addictol = 20)
