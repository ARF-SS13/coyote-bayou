/obj/item/lipstick
	gender = PLURAL
	name = "red lipstick"
	desc = "A generic brand of lipstick."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "lipstick"
	w_class = WEIGHT_CLASS_TINY
	var/colour = "red"
	var/open = FALSE

/obj/item/lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/lipstick/jade
	//It's still called Jade, but theres no HTML color for jade, so we use lime.
	name = "jade lipstick"
	colour = "lime"

/obj/item/lipstick/black
	name = "black lipstick"
	colour = "black"

/obj/item/lipstick/random
	name = "lipstick"
	icon_state = "random_lipstick"

/obj/item/lipstick/random/New()
	..()
	icon_state = "lipstick"
	colour = pick("red","purple","lime","black","green","blue","white")
	name = "[colour] lipstick"

/obj/item/lipstick/attack_self(mob/user)
	cut_overlays()
	to_chat(user, span_notice("You twist \the [src] [open ? "closed" : "open"]."))
	open = !open
	if(open)
		var/mutable_appearance/colored_overlay = mutable_appearance(icon, "lipstick_uncap_color")
		colored_overlay.color = colour
		icon_state = "lipstick_uncap"
		add_overlay(colored_overlay)
	else
		icon_state = "lipstick"

/obj/item/lipstick/attack(mob/M, mob/user)
	if(!open)
		return

	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.is_mouth_covered())
			to_chat(user, span_warning("Remove [ H == user ? "your" : "[H.p_their()]" ] mask!"))
			return
		if(H.lip_style)	//if they already have lipstick on
			to_chat(user, span_warning("You need to wipe off the old lipstick first!"))
			return
		if(H == user)
			user.visible_message(span_notice("[user] does [user.p_their()] lips with \the [src]."), \
								span_notice("You take a moment to apply \the [src]. Perfect!"))
			H.lip_style = "lipstick"
			H.lip_color = colour
			H.update_body()
		else
			user.visible_message(span_warning("[user] begins to do [H]'s lips with \the [src]."), \
								span_notice("You begin to apply \the [src] on [H]'s lips..."))
			if(do_after(user, 20, target = H))
				user.visible_message("[user] does [H]'s lips with \the [src].", \
									span_notice("You apply \the [src] on [H]'s lips."))
				H.lip_style = "lipstick"
				H.lip_color = colour
				H.update_body()
	else
		to_chat(user, span_warning("Where are the lips on that?"))

//you can wipe off lipstick with paper!
/obj/item/paper/attack(mob/M, mob/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_MOUTH)
		if(!ismob(M))
			return

		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H == user)
				to_chat(user, span_notice("You wipe off the lipstick with [src]."))
				H.lip_style = null
				H.update_body()
			else
				user.visible_message(span_warning("[user] begins to wipe [H]'s lipstick off with \the [src]."), \
									span_notice("You begin to wipe off [H]'s lipstick..."))
				if(do_after(user, 10, target = H))
					user.visible_message("[user] wipes [H]'s lipstick off with \the [src].", \
										span_notice("You wipe off [H]'s lipstick."))
					H.lip_style = null
					H.update_body()
	else
		..()

/obj/item/razor
	name = "electric razor"
	desc = "The latest and greatest power razor born from the science of shaving."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "razor"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_TINY

/obj/item/razor/proc/shave(mob/living/carbon/human/H, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		H.facial_hair_style = "Shaved"
	else
		H.hair_style = "Skinhead"

	H.update_hair()
	playsound(loc, 'sound/items/welder2.ogg', 20, 1)


/obj/item/razor/attack(mob/M, mob/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/location = user.zone_selected
		if((location in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !H.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[H] doesn't have a head!"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in H.dna.species.species_traits))
				to_chat(user, span_warning("There is no facial hair to shave!"))
				return
			if(!get_location_accessible(H, location))
				to_chat(user, span_warning("The mask is in the way!"))
				return
			if(H.facial_hair_style == "Shaved")
				to_chat(user, span_warning("Already clean-shaven!"))
				return

			if(H == user) //shaving yourself
				user.visible_message("[user] starts to shave [user.p_their()] facial hair with [src].", \
									span_notice("You take a moment to shave your facial hair with [src]..."))
				if(do_after(user, 50, target = H))
					user.visible_message("[user] shaves [user.p_their()] facial hair clean with [src].", \
										span_notice("You finish shaving with [src]. Fast and clean!"))
					shave(H, location)
			else
				var/turf/H_loc = H.loc
				user.visible_message(span_warning("[user] tries to shave [H]'s facial hair with [src]."), \
									span_notice("You start shaving [H]'s facial hair..."))
				if(do_after(user, 50, target = H))
					if(H_loc == H.loc)
						user.visible_message(span_warning("[user] shaves off [H]'s facial hair with [src]."), \
											span_notice("You shave [H]'s facial hair clean off."))
						shave(H, location)

		else if(location == BODY_ZONE_HEAD)
			if(!(HAIR in H.dna.species.species_traits))
				to_chat(user, span_warning("There is no hair to shave!"))
				return
			if(!get_location_accessible(H, location))
				to_chat(user, span_warning("The headgear is in the way!"))
				return
			if(H.hair_style == "Bald" || H.hair_style == "Balding Hair" || H.hair_style == "Skinhead")
				to_chat(user, span_warning("There is not enough hair left to shave!"))
				return

			if(H == user) //shaving yourself
				user.visible_message("[user] starts to shave [user.p_their()] head with [src].", \
									span_notice("You start to shave your head with [src]..."))
				if(do_after(user, 5, target = H))
					user.visible_message("[user] shaves [user.p_their()] head with [src].", \
										span_notice("You finish shaving with [src]."))
					shave(H, location)
			else
				var/turf/H_loc = H.loc
				user.visible_message(span_warning("[user] tries to shave [H]'s head with [src]!"), \
									span_notice("You start shaving [H]'s head..."))
				if(do_after(user, 50, target = H))
					if(H_loc == H.loc)
						user.visible_message(span_warning("[user] shaves [H]'s head bald with [src]!"), \
											span_notice("You shave [H]'s head bald."))
						shave(H, location)
		else
			..()
	else
		..()


//port splurt nailpolish

//Nail polish
/obj/item/nailpolish
	name = "nail polish"
	desc = "Paint with a fine brush to do your nails, or someone elses."
	icon = 'modular_splurt/icons/obj/cosmetic.dmi'
	icon_state = "nailcap"
	inhand_icon_state = "nailpolish"
	w_class = WEIGHT_CLASS_TINY
	var/paint = "black"
	var/mutable_appearance/bottle //show the colour on the bottle.

/obj/item/nailpolish/red
	name = "red nail polish"
	paint = "red"

/obj/item/nailpolish/blue
	name = "blue nail polish"
	paint = "blue"

/obj/item/nailpolish/aqua
	name = "cyan nail polish"
	paint = "aqua"

/obj/item/nailpolish/black
	name = "black nail polish"
	paint = "black"

/obj/item/nailpolish/white
	name = "white nail polish"
	paint = "white"

/obj/item/nailpolish/navy
	name = "navy nail polish"
	paint = "navy"

/obj/item/nailpolish/yellow
	name = "yellow nail polish"
	paint = "yellow"

/obj/item/nailpolish/purple
	name = "purple nail polish"
	paint = "purple"

/obj/item/nailpolish/Initialize()
	. = ..()
	bottle = mutable_appearance('modular_splurt/icons/obj/cosmetic.dmi', "nailpolish")
	bottle.color = paint
	add_overlay(bottle)


/obj/item/nailpolish/attack(mob/M, mob/user)
	if(!ismob(M))
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.nail_style) //to stop stacking bugs
			to_chat(user, span_warning("Remove the old nail polish first!"))

		if(H == user)
			user.visible_message(span_notice("[user] does [user.p_their()] nails with \the [src]."), \
								span_notice("You take a moment to apply \the [src]. Perfect!"))
			H.nail_style = "nails"
			H.nail_color = paint
			H.update_body()
		else
			user.visible_message(span_warning("[user] begins to do [H]'s nails with \the [src]."), \
								span_notice("You begin to apply \the [src] on [H]'s nails..."))
			if(do_after(user, 20, target = H))
				user.visible_message("[user] does [H]'s nails with \the [src].", \
									span_notice("You apply \the [src] on [H]'s nails."))
				H.nail_style = "nails"
				H.nail_color = paint
				H.update_body()
	else
		to_chat(user, span_warning("Where are the nail on that?"))
