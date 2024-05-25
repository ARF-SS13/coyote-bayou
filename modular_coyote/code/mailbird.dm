//////////////////////////////////
///       Birdcall Emote       ///
//////////////////////////////////

/datum/emote/living/carbon/birdcall
	key = "birdcall"
	key_third_person = "birdcalls"
	message = "whistles a tribal birdcall."
	emote_type = EMOTE_AUDIBLE
	sound = 'modular_coyote/sound/mobsounds/birdcall.ogg'
	cooldown = 10 SECONDS

/datum/emote/living/carbon/birdcall/can_run_emote(mob/user, status_check = TRUE, intentional = FALSE)
	. = TRUE
	if(!..(user, status_check, intentional))
		return FALSE
	var/mob/living/carbon/C = user
	if(!istype(C))
		return FALSE

	if(!(HAS_TRAIT(C, TRAIT_TRIBAL) || HAS_TRAIT(C, TRAIT_FORMER_TRIBAL)))
		to_chat(user, span_warning("You need a deeper connection with the tribes to understand how to call for a bird."))
		return FALSE

	return TRUE

/datum/emote/living/carbon/birdcall/run_emote(mob/user)
	var/mob/living/carbon/C = user
	if(!is_type_in_list(get_area(C), GLOB.outdoor_areas))
		to_chat(user, span_warning("You must be outside to call for a bird."))
		return FALSE

	var/obj/item/reagent_containers/food/snacks/grown/pinyon/nut

	for(var/obj/item/reagent_containers/food/snacks/grown/pinyon/P in C.held_items)
		nut = P
		break

	if(!istype(nut))
		to_chat(user, span_warning("You must have a pinyon nut to give to the bird you call."))
		return FALSE

	var/obj/item/mail

	for(var/obj/item/I in C.held_items)
		if(I != nut)
			mail = I
			break

	if(!istype(mail))
		to_chat(user, span_warning("You need an item to give to the bird you call!"))
		return FALSE

	if(mail.w_class > WEIGHT_CLASS_SMALL)
		to_chat(user, span_warning("This item is too heavy to give to a bird!"))
		return FALSE

	. = ..()
	new /obj/effect/mailbird(get_turf(C), C)

//////////////////////////////////
///          Mailbird          ///
//////////////////////////////////

/obj/effect/mailbird
	name = "trained crow" //Strictly speaking, nobody should see this? But whatever.
	desc = "A small crow. Its foot seems to be painted in a tribal color." //Let's put this in case someone does.
	icon = 'modular_coyote/icons/mob/bird.dmi'
	icon_state = "crow-glide"
	alpha = 0
	var/mob/living/carbon/caller
	var/atom/movable/following
	var/datum/component/mailbird_movement/component
	var/TargetName
	var/obj/item/mail

/obj/effect/mailbird/Initialize(mapload, mob/living/carbon/C)
	. = ..()
	caller = C
	following = C
	component = src.AddComponent(/datum/component/mailbird_movement, C)
	var/delayRespond = rand(2,4) SECONDS
	var/delayAnim = delayRespond + rand(1,2) SECONDS
	var/delayQuery = delayAnim + 1.5 SECONDS
	addtimer(CALLBACK(src,PROC_REF(respond)), delayRespond)
	addtimer(CALLBACK(src,PROC_REF(arrive)), delayAnim)
	addtimer(CALLBACK(src,PROC_REF(queryCaller)), delayQuery)

/obj/effect/mailbird/proc/respond()
	playsound(src.loc, 'modular_coyote/sound/mobsounds/crowrespond.ogg', 50, FALSE) //Magic numbers bad. Oh well. 50 is volume (average) and FALSE is for whether or not playsound should go through walls.

/obj/effect/mailbird/proc/arrive()
	alpha = 0
	icon_state = "crow-glide"
	var/matrix/OuterMatrix = matrix(src.transform)
	OuterMatrix.Translate(0, 100)
	var/matrix/OriginMatrix = matrix(src.transform)
	src.transform = OuterMatrix
	animate(src, alpha = 255, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
	animate(src, transform = OriginMatrix, time = 1.45 SECONDS, flags = ANIMATION_PARALLEL, easing = QUAD_EASING | EASE_IN)
	src.SpinAnimation(1.45 SECONDS)

/obj/effect/mailbird/proc/queryCaller()
	alpha = 0

	var/obj/item/reagent_containers/food/snacks/grown/pinyon/nut
	var/mob/living/carbon/human/C = caller

	for(var/obj/item/reagent_containers/food/snacks/grown/pinyon/P in C.held_items)
		nut = P
		break

	for(var/obj/item/I in C.held_items)
		if(I != nut)
			mail = I
			break

	if(!istype(nut) || !istype(mail) || mail.w_class > WEIGHT_CLASS_SMALL)
		playsound(src.loc, 'modular_coyote/sound/mobsounds/crowpeck.ogg', 50, TRUE)
		C.visible_message(span_warning("[C] was pecked by the messenger crow!"), span_userdanger("The messenger crow pecked you and flew off!"))
		var/obj/item/bodypart/head = C.get_bodypart("head")
		if(istype(head))
			head.receive_damage(1)
		else
			C.adjustBruteLoss(1)
		mail = null
		flyOff()
		return

	to_chat(C, span_info("You feed \the [nut] to the crow, and offer \the [mail] to it."))

	C.dropItemToGround(nut)
	qdel(nut)

	C.dropItemToGround(mail)
	mail.forceMove(src)

	TargetName = stripped_input(C, "Who would you like \the [mail] delivered to?", "Messenger Crow")
	if(!TargetName)
		to_chat(span_warning("The crow tilts its head in confusion, placing \the [mail] on the ground before flying off."))
		mail.forceMove(get_turf(src))
		mail = null
		flyOff()
		return
	to_chat(C, span_info("You use your tribal bond to ask the crow to deliver \the [mail] to someone named \"[TargetName].\""))
	flyOff()

/obj/effect/mailbird/proc/flyOff()
	alpha = 0
	playsound(src.loc, 'modular_coyote/sound/mobsounds/crowleave.ogg', 50, FALSE)
	if(!istype(mail))
		qdel(src)
		return
	component.unsetTarget()
	addtimer(CALLBACK(src,PROC_REF(deliver)), rand(60, 90) SECONDS)

/obj/effect/mailbird/proc/deliver()
	icon_state = "crow-glide"
	if(!istype(mail))
		qdel(src) //Whatever you gave the crow stopped existing in mid air! The crow doesn't mind. Free nut.
		return
	var/mob/living/carbon/C = null
	for(var/mob/living/carbon/target in world)
		if(findtext(target.real_name, TargetName))
			C = target
			break

	var/success = FALSE
	if(!istype(C))
		following = caller
	else
		following = C
		success = TRUE

	src.forceMove(get_turf(following))
	component.changeTarget(following)
	pixel_y = 60
	pixel_x = -100
	addtimer(CALLBACK(src,PROC_REF(dropAndLeave), success), 0.5 SECONDS)
	playsound(src.loc, 'modular_coyote/sound/mobsounds/crowrespond.ogg', 50, FALSE)
	animate(src, pixel_y = 30, pixel_x = 0, time = 0.5 SECONDS, flags = ANIMATION_PARALLEL)
	animate(src, alpha = 255, time = 0.1 SECONDS, flags = ANIMATION_PARALLEL)

/obj/effect/mailbird/proc/dropAndLeave(successful)
	mail.forceMove(src.loc)
	if(successful)
		to_chat(following, span_info("A crow swoops in and gently deposits \a [mail] at your feet."))
	else
		to_chat(following, span_warning("The crow returns \the [mail], unable to find someone to deliver to."))
	addtimer(CALLBACK(src,PROC_REF(fadeAway)), 0.4 SECONDS)
	animate(src, pixel_y = 60, pixel_x = 100, time = 0.5 SECONDS)

/obj/effect/mailbird/proc/fadeAway()
	animate(src, alpha = 0, time = 0.1 SECONDS, flags = ANIMATION_PARALLEL)
	qdel(src)

//////////////////////////////////
///      Follow Component      ///
//////////////////////////////////

/datum/component/mailbird_movement
	var/atom/movable/target

/datum/component/mailbird_movement/Initialize(atom/movable/newTarget)
	if(!ismovable(newTarget))
		return COMPONENT_INCOMPATIBLE

	target = newTarget
	RegisterSignal(target, COMSIG_MOVABLE_MOVED,PROC_REF(move_react))

/datum/component/mailbird_movement/proc/unsetTarget()
	UnregisterSignal(target, COMSIG_MOVABLE_MOVED)
	target = null

/datum/component/mailbird_movement/proc/changeTarget(atom/movable/newTarget)
	if(!ismovable(newTarget))
		return COMPONENT_INCOMPATIBLE
	unsetTarget()
	target = newTarget
	RegisterSignal(target, COMSIG_MOVABLE_MOVED,PROC_REF(move_react))

/datum/component/mailbird_movement/proc/move_react(atom/moved, atom/oldloc, direction)
	var/atom/movable/A = parent
	if(istype(A))
		A.forceMove(get_turf(moved))
