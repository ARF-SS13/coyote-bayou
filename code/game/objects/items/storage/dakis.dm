//////////////////////////////////
//dakimakuras
//////////////////////////////////

/obj/item/storage/daki
	name = "dakimakura"
	desc = "A large pillow depicting a girl in a compromising position. Featuring as many dimensions as you."
	icon = 'icons/obj/daki.dmi'
	icon_state = "daki_base"
	slot_flags = INV_SLOTBIT_BACK
	var/cooldowntime = 20
	var/static/list/dakimakura_options = list("Callie","Casca","Chaika","Elisabeth","Foxy Grandpa","Haruko","Holo","Ian","Jolyne","Kurisu","Marie","Mugi","Nar'Sie","Patchouli","Plutia","Rei","Reisen","Naga","Squid","Squigly","Tomoko","Toriel","Umaru","Yaranaika","Yoko") //Kurisu is the ideal girl." - Me, Logos.

/obj/item/storage/daki/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_SMALL
	STR.max_combined_w_class = 21
	STR.max_items = 3
	STR.cant_hold = typecacheof(list(/obj/item/disk/nuclear))

/obj/item/storage/daki/attack_self(mob/living/user)
	var/body_choice
	var/custom_name

	if(icon_state == "daki_base")
		body_choice = input("Pick a body.") in dakimakura_options
		icon_state = "daki_[body_choice]"
		custom_name = stripped_input(user, "What's her name?")
		if(length(custom_name) > MAX_NAME_LEN)
			to_chat(user,span_danger("Name is too long!"))
			return FALSE
		if(custom_name)
			name = custom_name
			desc = "A large pillow depicting [custom_name] in a compromising position. Featuring as many dimensions as you."
	else
		switch(user.a_intent)
			if(INTENT_HELP)
				user.visible_message(span_notice("[user] hugs the [name]."))
				playsound(src, "rustle", 50, 1, -5)
			if(INTENT_DISARM)
				user.visible_message(span_notice("[user] kisses the [name]."))
				playsound(src, "rustle", 50, 1, -5)
			if(INTENT_GRAB)
				user.visible_message(span_warning("[user] holds the [name]!"))
				playsound(src, 'sound/items/bikehorn.ogg', 50, 1)
			if(INTENT_HARM)
				user.visible_message(span_danger("[user] punches the [name]!"))
				playsound(src, 'sound/effects/shieldbash.ogg', 50, 1)
		user.DelayNextAction(CLICK_CD_MELEE)

	SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "dakimakura", /datum/mood_event/pet_pillow)

////////////////////////////
