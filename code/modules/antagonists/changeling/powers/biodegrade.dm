/obj/effect/proc_holder/changeling/biodegrade
	name = "Biodegrade"
	desc = "Dissolves restraints or other objects preventing free movement."
	helptext = "This is obvious to nearby people, and can destroy standard restraints and closets. This ability is somewhat loud, and carries a small risk of our blood gaining violent sensitivity to heat."
	chemical_cost = 15 //High cost to prevent spam
	loudness = 1
	dna_cost = 2
	req_human = 1
	action_icon = 'icons/mob/actions/actions_changeling.dmi'
	action_icon_state = "ling_freedom"
	action_background_icon_state = "bg_ling"

/obj/effect/proc_holder/changeling/biodegrade/sting_action(mob/living/carbon/human/user)
	var/used = FALSE // only one form of shackles removed per use
	if(!user.restrained() && isopenturf(user.loc))
		to_chat(user, span_warning("We are already free!"))
		return 0

	if(user.handcuffed)
		var/obj/O = user.get_item_by_slot(SLOT_HANDCUFFED)
		if(!istype(O))
			return 0
		user.visible_message(span_warning("[user] vomits a glob of acid on [user.p_their()] [O]!"), \
			span_warning("We vomit acidic ooze onto our restraints!"))

		addtimer(CALLBACK(src,PROC_REF(dissolve_handcuffs), user, O), 30)
		used = TRUE

	if(user.wear_suit && user.wear_suit.breakouttime && !used)
		var/obj/item/clothing/suit/S = user.get_item_by_slot(SLOT_WEAR_SUIT)
		if(!istype(S))
			return 0
		user.visible_message(span_warning("[user] vomits a glob of acid across the front of [user.p_their()] [S]!"), \
			span_warning("We vomit acidic ooze onto our straight jacket!"))
		addtimer(CALLBACK(src,PROC_REF(dissolve_straightjacket), user, S), 30)
		used = TRUE


	if(istype(user.loc, /obj/structure/closet) && !used)
		var/obj/structure/closet/C = user.loc
		if(!istype(C))
			return 0
		C.visible_message(span_warning("[C]'s hinges suddenly begin to melt and run!"))
		to_chat(user, span_warning("We vomit acidic goop onto the interior of [C]!"))
		addtimer(CALLBACK(src,PROC_REF(open_closet), user, C), 70)
		used = TRUE

	if(istype(user.loc, /obj/structure/spider/cocoon) && !used)
		var/obj/structure/spider/cocoon/C = user.loc
		if(!istype(C))
			return 0
		C.visible_message(span_warning("[src] shifts and starts to fall apart!"))
		to_chat(user, span_warning("We secrete acidic enzymes from our skin and begin melting our cocoon..."))
		addtimer(CALLBACK(src,PROC_REF(dissolve_cocoon), user, C), 25) //Very short because it's just webs
		used = TRUE

	return used

/obj/effect/proc_holder/changeling/biodegrade/proc/dissolve_handcuffs(mob/living/carbon/human/user, obj/O)
	if(O && user.handcuffed == O)
		user.visible_message(span_warning("[O] dissolve[O.gender==PLURAL?"":"s"] into a puddle of sizzling goop."))
		new /obj/effect/decal/cleanable/greenglow(O.drop_location())
		qdel(O)

/obj/effect/proc_holder/changeling/biodegrade/proc/dissolve_straightjacket(mob/living/carbon/human/user, obj/S)
	if(S && user.wear_suit == S)
		user.visible_message(span_warning("[S] dissolves into a puddle of sizzling goop."))
		new /obj/effect/decal/cleanable/greenglow(S.drop_location())
		qdel(S)

/obj/effect/proc_holder/changeling/biodegrade/proc/open_closet(mob/living/carbon/human/user, obj/structure/closet/C)
	if(C && user.loc == C)
		C.visible_message(span_warning("[C]'s door breaks and opens!"))
		new /obj/effect/decal/cleanable/greenglow(C.drop_location())
		C.welded = FALSE
		C.locked = FALSE
		C.broken = TRUE
		C.open()
		to_chat(user, span_warning("We open the container restraining us!"))

/obj/effect/proc_holder/changeling/biodegrade/proc/dissolve_cocoon(mob/living/carbon/human/user, obj/structure/spider/cocoon/C)
	if(C && user.loc == C)
		new /obj/effect/decal/cleanable/greenglow(C.drop_location())
		qdel(C) //The cocoon's destroy will move the changeling outside of it without interference
		to_chat(user, span_warning("We dissolve the cocoon!"))
