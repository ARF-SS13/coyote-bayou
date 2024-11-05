/obj/item/electropack
	name = "electropack"
	desc = "Dance my monkeys! DANCE!!!"
	icon = 'icons/obj/radio.dmi'
	icon_state = "electropack0"
	inhand_icon_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BACK
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=2500)
	var/stepbro = FALSE

	var/code = 2
	var/frequency = FREQ_ELECTROPACK
	var/on = TRUE
	var/shock_cooldown = FALSE

/obj/item/electropack/Initialize()
	. = ..()
	set_frequency(frequency)

/obj/item/electropack/Destroy()
	SSradio.remove_object(src, frequency)
	return ..()

/obj/item/electropack/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(iscarbon(user) && stepbro) // im stuck in the shock collar stepbro
		var/mob/living/carbon/C = user
		if(src == C.back)
			to_chat(user, span_warning("You need help taking this off!"))
			return
	return ..()

/obj/item/electropack/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/clothing/head/helmet))
		var/obj/item/assembly/shock_kit/A = new /obj/item/assembly/shock_kit(user)
		A.icon = 'icons/obj/assemblies.dmi'

		if(!user.transferItemToLoc(W, A))
			to_chat(user, span_warning("[W] is stuck to your hand, you cannot attach it to [src]!"))
			return
		W.master = A
		A.part1 = W

		user.transferItemToLoc(src, A, TRUE)
		master = A
		A.part2 = src

		user.put_in_hands(A)
		A.add_fingerprint(user)
	else
		return ..()

/obj/item/electropack/receive_signal(datum/signal/signal)
	if(!signal || signal.data["code"] != code)
		return
	Zap()
	if(master)
		master.receive_signal()

/obj/item/electropack/proc/Zap()
	if(isliving(loc) && on)
		if(shock_cooldown)
			return
		shock_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, shock_cooldown, FALSE), 100)
		var/mob/living/L = loc
		step(L, pick(GLOB.cardinals))

		to_chat(L, span_danger("You feel a sharp shock!"))
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, L)
		s.start()

		L.DefaultCombatKnockdown(100)


/obj/item/electropack/proc/set_frequency(new_frequency)
	SSradio.remove_object(src, frequency)
	frequency = new_frequency
	SSradio.add_object(src, frequency, RADIO_SIGNALER)

/obj/item/electropack/ui_state(mob/user)
	return GLOB.hands_state

/obj/item/electropack/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Electropack", name)
		ui.open()

/obj/item/electropack/ui_data(mob/user)
	var/list/data = list()
	data["power"] = on
	data["frequency"] = frequency
	data["code"] = code
	data["minFrequency"] = MIN_FREE_FREQ
	data["maxFrequency"] = MAX_FREE_FREQ
	return data

/obj/item/electropack/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("power")
			on = !on
			icon_state = "electropack[on]"
			. = TRUE
		if("freq")
			var/value = unformat_frequency(params["freq"])
			if(value)
				frequency = sanitize_frequency(value, TRUE)
				set_frequency(frequency)
				. = TRUE
		if("code")
			var/value = text2num(params["code"])
			if(value)
				value = round(value)
				code = clamp(value, 1, 100)
				. = TRUE
		if("reset")
			if(params["reset"] == "freq")
				frequency = initial(frequency)
				. = TRUE
			else if(params["reset"] == "code")
				code = initial(code)
				. = TRUE

/obj/item/electropack/ui_act(action, params)
	if(action == "power") // DO. NOT.
		return FALSE
	return ..()

/obj/item/electropack/shockcollar
	name = "novelty buzz collar"
	desc = "A cute industrial-looking choker with some cute wires running to a box with a picture of a cartoon lightning bolt on it. Vibrates and makes a loud buzzing noise when activated!"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "slavecollar"
	inhand_icon_state = "slavecollar"
	body_parts_covered = NECK
	slot_flags = INV_SLOTBIT_NECK //no more pocket shockers. Now done without lazyness
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	var/tagname = null

/obj/item/electropack/shockcollar/Initialize()
	. = ..()
	set_frequency(pick(1441,1443,1445,1447,1449,1451,1453,1455,1457,1459))
	code = rand(1,100)
	name = "[name] #[frequency]/[code]"

/*
/obj/item/electropack/shockcollar/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user && user.get_item_by_slot(SLOT_NECK))
		to_chat(user, span_warning("The collar is fastened tight! You'll need help taking this off!"))
		return
	return ..()
*/ //Removed due to these being basically for kink stuff only. ~TK

/obj/item/electropack/shockcollar/Zap()
	playsound(src, "sound/weapons/taserhit.ogg", 80, TRUE)
	var/mob/wearer = loc
	if(!ismob(wearer))
		return
	to_chat(wearer, span_danger("You feel your collar vibrate and make a totally authentic shocking noise! Oh no! What a terrible shock! Oh no!~"))

/obj/item/electropack/shockcollar/attackby(obj/item/W, mob/user, params) //moves it here because on_click is being bad
	if(istype(W, /obj/item/pen))
		var/t = stripped_input(user, "What's your collar's name?", "My collar is named Susan, Betty", tagname ? tagname : "Susan", MAX_NAME_LEN)
		if(t)
			tagname = t
			name = "[initial(name)] - [t]"
		return

//
//Explosive collar
/obj/item/electropack/shockcollar/explosive
	name = "'explosive' collar"
	desc = "A cute industrial-looking choker with some cute wires running to a box with a picture of a cartoon bomb on it. Oh nooo, it'll toooootally explode if someone signals it!~"
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "slavecollarb"
	inhand_icon_state = "slavecollarb"
	slot_flags = INV_SLOTBIT_NECK
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = NECK

/obj/item/electropack/shockcollar/explosive/Zap()
	playsound(src, "sound/effects/explosioncreak.ogg", 80, TRUE)
	var/mob/wearer = loc
	if(!ismob(wearer))
		return
	to_chat(wearer, span_danger("Your collar rumbles and makes a loud head-shattering kaboom! Oh no! Such a massive explosion that totally blew your head off! Oh no!~"))

//Collar keys
/obj/item/key/scollar
	name = "Novelty Collar Key"
	desc = "A small key designed to work with shock collars. Or it would, if they had a lock."
/* I'LL COME BACK TO THIS MAYBE. TODAYS DATE IS 9th JAN 2021. IF I DIDN'T COME BACK TO THIS GET RID OF THE KEY STUFF
/obj/item/key/scollar/attack(mob/living/M, mob/living/user)
	if(!istype(M.get_item_by_slot(SLOT_NECK), /obj/item/electropack/shockcollar))
		return ..()
	var/obj/item/electropack/shockcollar/shockCollar = M.get_item_by_slot(SLOT_NECK)
	shockCollar.lock = !shockCollar.lock
	visible_message(span_warning("[shockCollar] [shockCollar.lock ? "locks" : "unlocks"] around [M]'s neck."))
	if(shockCollar.lock)
		ADD_TRAIT(shockCollar, TRAIT_NODROP, TRAIT_GENERIC)
		return
	REMOVE_TRAIT(shockCollar, TRAIT_NODROP, TRAIT_GENERIC)
*/
/obj/item/key/bcollar
	name = "Novelty Explosive Collar Key"
	desc = "A small key designed to work with explosive collars. Or it would, if they had a lock."
