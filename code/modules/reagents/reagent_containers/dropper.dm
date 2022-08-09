/obj/item/reagent_containers/dropper
	name = "dropper"
	desc = "A dropper. Holds up to 5 units."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "dropper0"
	amount_per_transfer_from_this = 5
	possible_transfer_amounts = list(1, 2, 3, 4, 5)
	volume = 5
	reagent_flags = TRANSPARENT
	custom_price = PRICE_CHEAP_AS_FREE

/obj/item/reagent_containers/dropper/afterattack(obj/target, mob/user , proximity)
	. = ..()
	if(!proximity)
		return
	if(!target.reagents)
		return

	if(reagents.total_volume > 0)
		if(target.reagents.total_volume >= target.reagents.maximum_volume)
			to_chat(user, span_notice("[target] is full."))
			return

		if(!target.is_injectable())
			to_chat(user, span_warning("You cannot directly fill [target]!"))
			return

		var/trans = 0
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

		if(ismob(target))
			if(ishuman(target))
				var/mob/living/carbon/human/victim = target

				var/obj/item/safe_thing = null
				if(victim.wear_mask)
					if(victim.wear_mask.flags_cover & MASKCOVERSEYES)
						safe_thing = victim.wear_mask
				if(victim.head)
					if(victim.head.flags_cover & MASKCOVERSEYES)
						safe_thing = victim.head
				if(victim.glasses)
					if(!safe_thing)
						safe_thing = victim.glasses

				if(safe_thing)
					if(!safe_thing.reagents)
						safe_thing.create_reagents(100, NONE, NO_REAGENTS_VALUE)

					reagents.reaction(safe_thing, TOUCH, fraction)
					trans = reagents.trans_to(safe_thing, amount_per_transfer_from_this, log = TRUE)

					target.visible_message(span_danger("[user] tries to squirt something into [target]'s eyes, but fails!"), \
											span_userdanger("[user] tries to squirt something into [target]'s eyes, but fails!"))

					to_chat(user, span_notice("You transfer [trans] unit\s of the solution."))
					update_icon()
					return
			else if(isalien(target)) //hiss-hiss has no eyes!
				to_chat(target, span_danger("[target] does not seem to have any eyes!"))
				return

			target.visible_message(span_danger("[user] squirts something into [target]'s eyes!"), \
									span_userdanger("[user] squirts something into [target]'s eyes!"))

			reagents.reaction(target, TOUCH, fraction)
			var/mob/M = target
			log_combat(user, M, "squirted", reagents.log_list())

		trans = src.reagents.trans_to(target, amount_per_transfer_from_this, log = TRUE)
		to_chat(user, span_notice("You transfer [trans] unit\s of the solution."))
		update_icon()

	else

		if(!target.is_drawable(FALSE)) //No drawing from mobs here
			to_chat(user, span_notice("You cannot directly remove reagents from [target]."))
			return

		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return

		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, log = TRUE)

		to_chat(user, span_notice("You fill [src] with [trans] unit\s of the solution."))

		update_icon()

/obj/item/reagent_containers/dropper/update_overlays()
	. = ..()
	if(reagents.total_volume)
		. += mutable_appearance('icons/obj/reagentfillings.dmi', "dropper", color = mix_color_from_reagents(reagents.reagent_list))

/obj/item/reagent_containers/dropper/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "pouch")

