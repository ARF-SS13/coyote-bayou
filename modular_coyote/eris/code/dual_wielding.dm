//-->Dual wielding system
//leonzrygin, yell at me
//<--

/obj/item
	var/is_dual_wielded = FALSE
	var/sound_dualwield_start = 'sound/weapons/blade_unsheathing.ogg'
	var/sound_dualwield_end = 'sound/weapons/blade_sheathing.ogg'
	var/dual_wielded_mult = 0.66
	var/memory_original_name
	var/memory_original_force
	var/dual_wield_memory_attack_speed  //dangerous variable, I know, but hey what's life without a little bit of spice?

/mob
	var/dual_wield_queue_swap = 0

//Attempt to dual wield
/proc/attempt_dual_wield(mob/user, obj/item/I, obj/item/J, dual_wield_force_mult)
	if(I.is_dual_wielded == TRUE || J.is_dual_wielded == TRUE)  //Trying to dualwield_end it
		dualwield_end(user, I, J)
	else  //Trying to dualwield it
		dualwield_start(user, I, J, dual_wield_force_mult)

/proc/dualwield_end(mob/living/user, obj/item/I, obj/item/J, play_sound = TRUE)
	if((!I.is_dual_wielded && !J.is_dual_wielded) || !user)
		return

	user.dual_wield_queue_swap = 0

	I.is_dual_wielded = FALSE
	J.is_dual_wielded = FALSE

	I.force = I.memory_original_force
	J.force = J.memory_original_force

	I.attack_speed = I.dual_wield_memory_attack_speed
	J.attack_speed = J.dual_wield_memory_attack_speed

	if(findtext(I.name," (Dual Wielded)") || findtext(J.name," (Dual Wielded)"))
		I.name = I.memory_original_name
		J.name = J.memory_original_name
	else //something went wrong
		I.name = "[initial(I.name)]"//Returns name from compile-time instead of name with changes that have happened since
		J.name = "[initial(J.name)]"

	I.update_icon()
	J.update_icon()

	if(user)
		user.update_inv_hands()

	user.visible_message(span_warning("[user] stops dual wielding."))
	if(I.sound_dualwield_end && play_sound)
		playsound(user.loc, I.sound_dualwield_end, 50, 1)
	return

/proc/dualwield_start(mob/living/user, obj/item/I, obj/item/J, dual_wield_force_mult)
	if(I.is_dual_wielded || J.is_dual_wielded)
		return
	if(user.get_num_arms() < 2)
		return

	I.is_dual_wielded = TRUE
	J.is_dual_wielded = TRUE

	I.memory_original_force = I.force
	J.memory_original_force = J.force

	I.dual_wielded_mult = dual_wield_force_mult
	J.dual_wielded_mult = dual_wield_force_mult

	I.dual_wield_memory_attack_speed = I.attack_speed
	J.dual_wield_memory_attack_speed = J.attack_speed

	I.attack_speed = (I.attack_speed / DUAL_WIELDING_SPEED_DIVIDER)
	J.attack_speed = (J.attack_speed / DUAL_WIELDING_SPEED_DIVIDER)

	I.force = (I.force * dual_wield_force_mult)
	J.force = (J.force * dual_wield_force_mult)

	I.memory_original_name = I.name //Else using [initial(name)] for the name of object returns compile-time name without any changes that've happened to the object's name
	J.memory_original_name = J.name

	I.name = "[I.name] (Dual Wielded)"
	J.name = "[J.name] (Dual Wielded)"

	I.update_icon()
	J.update_icon()

	if(user)
		user.update_inv_hands()
	user.visible_message(span_warning("[user] dual wields \the [I.memory_original_name] and \the [J.memory_original_name ]."))
	if(I.sound_dualwield_start)
		playsound(user.loc, I.sound_dualwield_start, 50, 1)
	return

/obj/item/dropped(mob/living/user)  //if we are dropping our dual wielded blades while dualwielding, we want to end dual wielding
	..()
	var/obj/item/I = src
	var/obj/item/J = user.get_inactive_held_item()

	if(I && J)
		if(I.is_dual_wielded || J.is_dual_wielded)
			dualwield_end(user, I, J)
	if(I)
		I.is_dual_wielded = FALSE  //even though, these should be already false, let's be certain about it
	if(J)
		J.is_dual_wielded = FALSE

/obj/item/equipped(mob/living/user)  //if we are equipping our dual wielded blades while dualwielding, we want to end dual wielding
	. = ..()
	var/obj/item/I = src
	var/obj/item/J = user.get_inactive_held_item()

	if(I && J)
		if(I.is_dual_wielded || J.is_dual_wielded)
			dualwield_end(user, I, J)

/obj/item/pickup(mob/living/user)  //temporary fix for a huge issue, you see I love duct tape and wood glue.
	..()
	if(findtext(name," (Dual Wielded)"))
		is_dual_wielded = FALSE
		force = memory_original_force
		attack_speed = dual_wield_memory_attack_speed
		name = memory_original_name
