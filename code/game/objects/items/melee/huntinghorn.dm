#define HH_WIELD_TIME (2 SECONDS)

/obj/item/twohanded/huntinghorn
	name = "hunting horn"
	icon_state = "louisville"
	icon_prefix = "louisville"
	wielded_icon = "louisville2"
	var/readytoplay = FALSE
	var/list/notes = list()
	var/list/songlist = list()
	
/obj/item/twohanded/huntinghorn/on_wield(obj/item/source, mob/user)
	. = ..()
	spawn(HH_WIELD_TIME)
		if(user.get_active_held_item() == src && wielded)
			setreadytoplay(user, TRUE)

/obj/item/twohanded/huntinghorn/on_unwield(obj/item/source, mob/user)
	. = ..()
	setreadytoplay(user, FALSE)

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
