/obj/item/cosmetics
	icon = 'modular_atom/fashion/icons/cosmetics.dmi'
	righthand_file = 'modular_atom/fashion/icons/onmobright.dmi'
	lefthand_file = 'modular_atom/fashion/icons/onmobleft.dmi'
	w_class = WEIGHT_CLASS_TINY
	gender = PLURAL
	var/datum/sprite_accessory/hair/hair_style = null

// ------------------------ LIPSTICK ------------------------------- //  -AffectedArc07
/obj/item/cosmetics/lipstick
	name = "red lipstick"
	desc = "A generic brand of lipstick."
	icon_state = "lipstick"
	var/colour = "red"
	var/open = FALSE

/obj/item/cosmetics/lipstick/purple
	name = "purple lipstick"
	colour = "purple"

/obj/item/cosmetics/lipstick/jade
	//It's still called Jade, but theres no HTML color for jade, so we use lime.
	name = "jade lipstick"
	colour = "lime"

/obj/item/cosmetics/lipstick/black
	name = "black lipstick"
	colour = "black"

/obj/item/cosmetics/lipstick/random
	name = "lipstick"
	icon_state = "random_lipstick"

/obj/item/cosmetics/lipstick/random/New()
	..()
	icon_state = "lipstick"
	colour = pick("red","purple","lime","black","green","blue","white")
	name = "[colour] lipstick"

/obj/item/cosmetics/lipstick/attack_self(mob/user)
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

/obj/item/cosmetics/lipstick/attack(mob/M, mob/user)
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

// ------------------------ HANDHELD MIRROR ------------------------------- // for applying makeup and a little mood boost - Pebbles
/obj/item/cosmetics/mirror_makeup
	name = "makeup mirror"
	desc = "Makes it easy to apply a tiny bit of makeup. Has a few tiny vials in the handle with powders and whatnot."
	icon_state = "mirror"

/obj/item/cosmetics/mirror_makeup/attack_self(mob/living/carbon/human/user)
	user.visible_message("<span class='notice'>\The [user] checks for dirt in \the [src]. Its comforting to know you don't have a piece of gecko on your forehead.</span>")
	SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/hug)

/obj/item/cosmetics/mirror_makeup/attack(mob/M, mob/user)
	if(!ismob(M))
		return

	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.is_mouth_covered())
			to_chat(user, span_warning("Remove [ H == user ? "your" : "[H.p_their()]" ] mask!"))
			return
		if(H.lip_style)	//if they already have lipstick or makeup on
			to_chat(user, span_warning("You need to wipe off the old makeup with some paper first!"))
			return
		if(H == user)
			user.visible_message(span_notice("[user] stares in the mirror while applying a little bit of makeup."), \
								span_notice("You take a moment to apply a bit of makeup. Perfect!"))
			if(do_after(user, 50, target = H))
				H.lip_style = "makeup"
				H.lip_color = null
				H.update_body()
		else
			user.visible_message(span_warning("[user] begins to apply makeup to [H]'s face."), \
								span_notice("You begin to apply some makeup on [H]'s face..."))
			if(do_after(user, 100, target = H))
				user.visible_message("[user] gives [H] a fresh coat of makeup.", \
									span_notice("You apply some makeup on [H]'s face."))
				H.lip_style = "makeup"
				H.lip_color = null
				H.update_body()
	else
		to_chat(user, span_warning("You can't put makeup on that."))


// ------------------------ RAZOR ------------------------------- // for cutting away annoying hair and beards -AffectedArc
/obj/item/cosmetics/razor
	name = "electric razor"
	desc = "The latest and greatest power razor born from the science of shaving."
	icon_state = "razor"
	flags_1 = CONDUCT_1

/obj/item/cosmetics/razor/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] begins shaving [user.p_them()]self without the razor guard! It looks like [user.p_theyre()] trying to commit suicide!"))
	shave(user, BODY_ZONE_PRECISE_MOUTH)
	shave(user, BODY_ZONE_HEAD)//doesnt need to be BODY_ZONE_HEAD specifically, but whatever
	return BRUTELOSS

/obj/item/cosmetics/razor/proc/shave(mob/living/carbon/human/H, location = BODY_ZONE_PRECISE_MOUTH)
	if(location == BODY_ZONE_PRECISE_MOUTH)
		H.facial_hair_style = "Shaved"
	else
		H.hair_style = "Skinhead"

	H.update_hair()
	playsound(loc, 'sound/items/welder2.ogg', 20, 1)


/obj/item/cosmetics/razor/attack(mob/M, mob/user)
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
			if(H.hair_style == "Bald" || H.hair_style == "Mature (Balding)" || H.hair_style == "Shaved")
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

// ------------------------ COMBS AND BRUSHES ------------------------------ // - Pebbles
/obj/item/cosmetics/haircomb //This was painful to make
	name = "hair comb"
	desc = "A worn comb made from old plastic."
	slot_flags = SLOT_EARS
	icon_state = "comb"
	item_state = "comb"


// This code is meant to make the item comb a mob on clicking them with the item, giving a message in chat, and can't be done while wearing a hat.
// Idea is to use hairstyle flags and give various mood boosts depending on hair length, and none to baldies. Some issue making this part work properly. Only paritally done, for working full section see bottom.
/obj/item/cosmetics/haircomb/attack(mob/M, mob/user)
	var/mob/living/carbon/human/H = M
	if(!ismob(M))
		return
	if(istype(H.head, /obj/item/clothing/head))
		to_chat(user, span_warning("Remove [ H == user ? "your" : "[H.p_their()]" ] headwear before you use your comb."))
		return

	if(ishuman(M))
		if(H == user)
//			var/datum/sprite_accessory/hair/hair_style = GLOB.hair_styles_list[H.hair_style]
//			if(hair_style.flags & VERY_SHORT_HAIR)
//				to_chat(user, span_warning("[user] scrapes the scalp in a futile attempt to comb the hair."))
			user.visible_message(span_notice("[user] combs [user.p_their()] hair with \the [src]. What a tidy[user.gender == FEMALE ? "gal" : "guy"]"), \
			span_notice("You comb your hair for a moment, getting rid of dust and grime. Perfect!"))
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "combed", /datum/mood_event/combed)
		else
			user.visible_message(span_warning("[user] begins to comb [H]'s hair."), \
								span_notice("You begin to comb [H]'s hair..."))
			if(do_after(user, 30, target = H))
				user.visible_message("[user] combs [H]'s hair.", \
									span_notice("You groom [H]'s hair."))
				SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "combed", /datum/mood_event/combed)
	else
		to_chat(user, span_warning("Where is the hair on that?"))


/obj/item/cosmetics/haircomb/brush
	name = "hairbrush"
	desc = "A surprisingly decent hairbrush with a wood handle and semi-soft bristles."
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = null
	icon_state = "brush"
	item_state = "brush"

/obj/item/cosmetics/haircomb/brush/attack(mob/M, mob/user)
	var/mob/living/carbon/human/H = M
	if(!ismob(M))
		return
	if(istype(H.head, /obj/item/clothing/head))
		to_chat(user, span_warning("Remove [ H == user ? "your" : "[H.p_their()]" ] headgear before you use your brush."))
		return

	if(ishuman(M))
		if(H == user)
			user.visible_message(span_notice("[user] brushes [user.p_their()] hair with \the [src]."), \
								span_notice("You brush your hair for a moment, enjoying the feeling."))
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed)
		else
			user.visible_message(span_warning("[user] begins to brush [H]'s hair."), \
								span_notice("You begin to brush [H]'s hair..."))
			if(do_after(user, 40, target = H))
				user.visible_message("[user] brushes [H]'s hair.", \
									span_notice("You groom [H]'s hair."))
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "brushed", /datum/mood_event/brushed)
	else
		to_chat(user, span_warning("Where is the hair on that?"))

/*
/obj/item/cosmetics/haircomb/brush/attack_self(mob/living/carbon/human/user)
	if(!user.incapacitated())
		var/datum/sprite_accessory/hair/hair_style = GLOB.hair_styles_list[user.hair_style]
		if(hair_style.flags & VERY_SHORT_HAIR)
			user.visible_message("<span class='notice'>\The [user] just sort of runs \the [src] over their scalp.</span>")
		if(hair_style.flags & VERY_LONG_HAIR)
			user.visible_message("<span class='notice'>\The [user] feels a lot better after carefully brushing their long hair with \the [src].</span>")
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "oblivious", /datum/mood_event/oblivious)
		else
			user.visible_message("<span class='notice'>\The [user] meticulously brushes their hair with \the [src].</span>")
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "hug", /datum/mood_event/hug)
*/
