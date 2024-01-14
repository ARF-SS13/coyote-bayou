/obj/item/twohanded/huntinghorn
	name = "hunting horn"
	icon_state = "louisville"
	icon_prefix = "louisville"
	wielded_icon = "louisville2"
	var/readytoplay = FALSE
	var/readytimer = FALSE
	var/list/notes = list()
	var/list/songlist = list()
	
/obj/item/twohanded/huntinghorn/on_wield(obj/item/source, mob/user)
	. = ..()
	readytimer = addtimer(CALLBACK(src, .proc/setreadytoplay, user, TRUE), 2 SECONDS, TIMER_STOPPABLE)

/obj/item/twohanded/huntinghorn/on_unwield(obj/item/source, mob/user)
	. = ..()
	readytoplay = FALSE
	deltimer(readytimer)

/obj/item/twohanded/huntinghorn/proc/setreadytoplay(mob/user, set_to)
	if(readytoplay == set_to)
		return
	readytoplay = set_to
	if(readytoplay)
		to_chat(user, span_info("You're ready to perform!"))
	else
		to_chat(user, span_info("You relax, finished with your performance for now."))

/obj/item/twohanded/huntinghorn/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!readytoplay || !CheckAttackCooldown(user, target))
		return
	var/list/clickparams = params2list(click_parameters)
	if(clickparams["alt"])
		to_chat(user, span_warning("You were pressing alt!"))
	if(clickparams["shift"])
		to_chat(user, span_warning("You pressed shift!"))
	if(clickparams["ctrl"])
		to_chat(user, span_warning("There's ctrl!"))
