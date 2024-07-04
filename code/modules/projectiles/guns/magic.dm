/obj/item/gun/magic
	name = "staff of nothing"
	desc = "This staff is boring to watch because even though it came first you've seen everything it can do in other staves for years."
	icon = 'icons/obj/guns/magic.dmi'
	icon_state = "staffofnothing"
	item_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	fire_sound = 'sound/weapons/emitter.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	flags_1 =  CONDUCT_1
	w_class = WEIGHT_CLASS_HUGE
	var/checks_antimagic = TRUE
	var/max_charges = 6
	var/charges = 0
	var/recharge_rate = 10 SECONDS
	var/charge_tick = 0
	var/can_charge = 1
	var/datum/looping_sound/wand_charge_1/soundloop
	var/ammo_type
	var/charge_timer
	var/no_den_usage = FALSE
	clumsy_check = FALSE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL // Has no trigger at all, uses magic instead
	pin = /obj/item/firing_pin/magic

/obj/item/gun/magic/update_icon_state()
	return // icon_prefix is buhhuuulllllshit and shouldnt be used

/obj/item/gun/magic/afterattack(atom/target, mob/living/user, flag)
	if(no_den_usage)
		var/area/A = get_area(user)
		if(istype(A, /area/wizard_station))
			to_chat(user, span_warning("You know better than to violate the security of The Den, best wait until you leave to use [src]."))
			return
		else
			no_den_usage = 0
	if(checks_antimagic && user.anti_magic_check(TRUE, FALSE, FALSE, 0, TRUE))
		to_chat(user, span_warning("Something is interfering with [src]."))
		return
	. = ..()

/obj/item/gun/magic/can_shoot()
	return charges >= 1

/obj/item/gun/magic/recharge_newshot()
	if (chambered && !chambered.BB)
		chambered.newshot()

/obj/item/gun/magic/process_chamber()
	charges-- // deduct a charge
	recharge_newshot() // Make sure there's still a bullet in the chamber
	start_charging() // Start charging a new shot

/obj/item/gun/magic/Initialize()
	. = ..()
	charges = max_charges
	chambered = new ammo_type(src)
	soundloop = new(list(src), FALSE)

/obj/item/gun/magic/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/item/gun/magic/proc/start_charging()
	if(charge_timer)
		return FALSE // Already charging
	if(!can_charge)
		return FALSE // Can't charge
	if(charges >= max_charges)
		return FALSE // Already full
	soundloop.start()
	charge_timer = addtimer(CALLBACK(src,PROC_REF(charge)), recharge_rate, TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/gun/magic/proc/charge()
	recharge_newshot()
	if(charges >= max_charges)
		charges = max_charges
		soundloop.stop()
		charge_timer = null
		return FALSE
	charges++
	charge_timer = addtimer(CALLBACK(src,PROC_REF(charge)), recharge_rate, TIMER_UNIQUE|TIMER_STOPPABLE)

/obj/item/gun/magic/UpdateAmmoCountOverlay()
	if(isturf(loc))//Only show th ammo count if the magazine is, like, in an inventory or something. Mags on the ground don't need a big number on them, that's ugly.
		maptext = ""
	else
		var/txte = ""
		var/culur = "#FF0000"
		var/shots_max = max_charges
		var/shots_remaining = charges
		if(shots_remaining >= shots_max)
			culur = "#00FFFF"
		else if(shots_remaining >= shots_max * 0.75)
			culur = "#00FF00"
		else if(shots_remaining >= shots_max * 0.5)
			culur = "#FFFF00"
		else if(shots_remaining >= shots_max * 0.25)
			culur = "#FFA500"
		else if(shots_remaining > 0)
			culur = "#FF0000"
		else
			culur = "#FF00FF"
		txte = "[shots_remaining]/[shots_max]"
		maptext = "<font color='[culur]'><b>[txte]</b></font>"

/obj/item/gun/magic/vv_edit_var(var_name, var_value)
	. = ..()
	switch(var_name)
		if(NAMEOF(src, charges))
			recharge_newshot()
