/obj/item/electropack
	name = "electropack"
	desc = "Dance my monkeys! DANCE!!!"
	icon = 'icons/obj/radio.dmi'
	icon_state = "electropack0"
	item_state = "electropack"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/iron=10000, /datum/material/glass=2500)

	var/code = 2
	var/frequency = FREQ_ELECTROPACK
	var/on = TRUE
	var/shock_cooldown = FALSE

/obj/item/electropack/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] hooks [user.p_them()]self to the electropack and spams the trigger! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (FIRELOSS)

/obj/item/electropack/Initialize()
	. = ..()
	set_frequency(frequency)

/obj/item/electropack/Destroy()
	SSradio.remove_object(src, frequency)
	return ..()

/obj/item/electropack/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.back)
			to_chat(user, "<span class='warning'>You need help taking this off!</span>")
			return
	return ..()

/obj/item/electropack/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/clothing/head/helmet))
		var/obj/item/assembly/shock_kit/A = new /obj/item/assembly/shock_kit(user)
		A.icon = 'icons/obj/assemblies.dmi'

		if(!user.transferItemToLoc(W, A))
			to_chat(user, "<span class='warning'>[W] is stuck to your hand, you cannot attach it to [src]!</span>")
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

	if(isliving(loc) && on)
		if(shock_cooldown)
			return
		shock_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, shock_cooldown, FALSE), 100)
		var/mob/living/L = loc
		step(L, pick(GLOB.cardinals))

		to_chat(L, "<span class='danger'>You feel a sharp shock!</span>")
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, L)
		s.start()

		L.DefaultCombatKnockdown(100)

	if(master)
		master.receive_signal()

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
	name = "slave collar"
	desc = "A reinforced metal collar. It seems to have some form of wiring near the front. A small lock is present, though it seems impossible to get it off anyway without external help."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "slavecollar"
	item_state = "slavecollar"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK //no more pocket shockers. Now done without lazyness
	w_class = WEIGHT_CLASS_SMALL
	strip_delay = 60
	equip_delay_other = 60
	custom_materials = list(/datum/material/iron = 5000, /datum/material/glass = 2000)
	var/lock = FALSE
	var/tagname = null

/datum/design/electropack/shockcollar
	name = "Slave collar"
	id = "shockcollar"
	build_type = AUTOLATHE
	build_path = /obj/item/electropack/shockcollar
	materials = list(/datum/material/iron = 5000, /datum/material/glass =2000)
	category = list("hacked", "Misc")

/obj/item/electropack/shockcollar/Initialize()
	. = ..()
	set_frequency(pick(1441,1443,1445,1447,1449,1451,1453,1455,1457,1459))
	code = rand(1,100)
	name = "[name] #[frequency]/[code]"

/obj/item/electropack/shockcollar/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc == user && user.get_item_by_slot(SLOT_NECK))
		to_chat(user, "<span class='warning'>The collar is fastened tight! You'll need help taking this off!</span>")
		return
	return ..()

/obj/item/electropack/shockcollar/receive_signal(datum/signal/signal) //we have to override this because of text
	if(!signal || signal.data["code"] != code)
		return

	if(isliving(loc) && on) //the "on" arg is currently useless
		var/mob/living/L = loc
		if(!L.get_item_by_slot(SLOT_NECK)) //**properly** stops pocket shockers
			return
		if(shock_cooldown == TRUE)
			return
		shock_cooldown = TRUE
		addtimer(VARSET_CALLBACK(src, shock_cooldown, FALSE), 100)
		step(L, pick(GLOB.cardinals))

		to_chat(L, "<span class='danger'>You feel a sharp shock from the collar!</span>")
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(3, 1, L)
		s.start()

		L.DefaultCombatKnockdown(100)

	if(master)
		master.receive_signal()
	return

/obj/item/electropack/shockcollar/attackby(obj/item/W, mob/user, params) //moves it here because on_click is being bad
	if(istype(W, /obj/item/pen))
		var/t = stripped_input(user, "Would you like to write a name on the collar?", "Name your new slave", tagname ? tagname : "Sclavus", MAX_NAME_LEN)
		if(t)
			tagname = t
			name = "[initial(name)] - [t]"
		return
	if(istype(W, /obj/item/clothing/head/helmet)) //lazy method of denying this
		return
	/*if(istype(W, /obj/item/key/scollar)) //SCRAPPING FOR NOW
		if(lock != FALSE)
			to_chat(user, "<span class='warning'>With a click the shock collar unlocks!</span>")
			lock = FALSE
			REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		else
			to_chat(user, "<span class='warning'>With a click the shock collar locks!</span>")
			lock = TRUE
		if(ismob(src.loc))
			return
		var/mob/M = src.loc
		if(M.get_item_by_slot(SLOT_NECK) == src)
			ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	return ..()*/


//
//Explosive collar
/obj/item/electropack/shockcollar/explosive
	name = "explosive collar"
	desc = "A thick reinforced metal collar. 'Explosion' danger symbols line the outside. A small lock is present, though it seems impossible to get it off anyway without external help."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "slavecollarb"
	item_state = "slavecollarb"
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = NECK
	strip_delay = 60
	equip_delay_other = 60

/obj/item/electropack/shockcollar/explosive/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/pen))
		var/t = stripped_input(user, "Would you like to write a name on the collar?", "Name your new slave", tagname ? tagname : "Sclavus", MAX_NAME_LEN)
		if(t)
			tagname = t
			name = "[initial(name)] - [t]"
		return
	if(istype(W, /obj/item/clothing/head/helmet)) //lazy method of denying this
		return
/*	if(istype(W, /obj/item/key/bcollar)) //SCRAPPING FOR NOW
		if(lock != FALSE)
			to_chat(user, "<span class='warning'>With a click the explosive collar unlocks!</span>")
			lock = FALSE
			REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
		to_chat(user, "<span class='warning'>With a click the explosive collar locks!</span>")
		lock = TRUE
		if(!ismob(src.loc))
			return
		var/mob/M = src.loc
		if(M.get_item_by_slot(SLOT_NECK) == src)
			ADD_TRAIT(src, TRAIT_NODROP, TRAIT_GENERIC)
	return ..()*/

/obj/item/electropack/shockcollar/explosive/receive_signal(datum/signal/signal) //this removes the "on" check
	if(!signal || signal.data["code"] != code)
		return

	if(isliving(loc))
		var/mob/living/L = loc
		step(L, pick(GLOB.cardinals))
		to_chat(L, "<span class='danger'>Beep beep</span>")
		boom(L)

	if(master)
		master.receive_signal()
	return

/obj/item/electropack/shockcollar/explosive/proc/boom(mob/living/L)
	explosion(get_turf(src),0,1,2, flame_range = 2)
	if(!istype(L) || L != loc || L.get_item_by_slot(SLOT_NECK) != src)
		return
	var/obj/item/bodypart/head/victimhead = L.get_bodypart(BODY_ZONE_HEAD)
	if(istype(victimhead))
		victimhead.dismember()

//Collar keys
/obj/item/key/scollar
	name = "Slave Collar Key"
	desc = "A small key designed to work with shock collars."
/* I'LL COME BACK TO THIS MAYBE. TODAYS DATE IS 9th JAN 2021. IF I DIDN'T COME BACK TO THIS GET RID OF THE KEY STUFF
/obj/item/key/scollar/attack(mob/living/M, mob/living/user)
    if(!istype(M.get_item_by_slot(SLOT_NECK), /obj/item/electropack/shockcollar))
        return ..()
    var/obj/item/electropack/shockcollar/shockCollar = M.get_item_by_slot(SLOT_NECK)
    shockCollar.lock = !shockCollar.lock
    visible_message("<span class='warning'>[shockCollar] [shockCollar.lock ? "locks" : "unlocks"] around [M]'s neck.</span>")
    if(shockCollar.lock)
        ADD_TRAIT(shockCollar, TRAIT_NODROP, TRAIT_GENERIC)
        return
    REMOVE_TRAIT(shockCollar, TRAIT_NODROP, TRAIT_GENERIC)
*/
/obj/item/key/bcollar
	name = "Explosive Collar Key"
	desc = "A small key designed to work with explosive collars."
