//-->Dual wielding system
//leonzrygin, yell at me
//<--

//Maximum weight allowed for dual wielding.
#define DUAL_WIELDING_MAX_WEIGHT_ALLOWED WEIGHT_CLASS_NORMAL

/obj/item
	var/is_dual_wielded = FALSE
	var/sound_dualwield_start = 'sound/weapons/blade_unsheathing.ogg'
	var/sound_dualwield_end = 'sound/weapons/blade_sheathing.ogg'
	var/force_dual_unwielded = 0 //If you have a specific force for it being un-is_dual_wielded. If for whatever reason you don't want to use the original force of the weapon.
	var/force_dual_wielded = 0 //If you have a specific force for it being dual wielded.
	var/dual_wielded_mult = 1
	var/memory_original_name
	var/dual_wield_queue_swap = FALSE


//Attempt to dual wield
/proc/attempt_dual_wield(mob/user, obj/item/I, obj/item/J)
	if(I.is_dual_wielded == TRUE || J.is_dual_wielded == TRUE)  //Trying to dualwield_end it
		dualwield_end(user, I, J)
	else  //Trying to dualwield it
		dualwield_start(user, I, J)	

/proc/dualwield_end(mob/living/user, obj/item/I, obj/item/J)
	if((!I.is_dual_wielded && !J.is_dual_wielded) || !user)
		return

	I.is_dual_wielded = FALSE
	J.is_dual_wielded = FALSE

	if(I.force_dual_unwielded)
		I.force = I.force_dual_unwielded
	if(J.force_dual_unwielded)
		J.force = J.force_dual_unwielded

	if(I.dual_wielded_mult)
		I.force = (I.force / I.dual_wielded_mult)
	else
		I.force = (I.force / 1.15)

	if(J.dual_wielded_mult)
		J.force = (J.force / J.dual_wielded_mult)
	else
		J.force = (J.force / 1.15)
	
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
	if(I.sound_dualwield_end)
		playsound(user.loc, I.sound_dualwield_end, 50, 1)
	return

/proc/dualwield_start(mob/living/user, obj/item/I, obj/item/J)
	if(I.is_dual_wielded || J.is_dual_wielded)
		return
	if(user.get_num_arms() < 2)
		return

	I.is_dual_wielded = TRUE
	J.is_dual_wielded = TRUE

	if(I.force_dual_wielded)  //Let's assign other values, in case there are
		I.force = I.force_dual_wielded
	if(J.force_dual_wielded)
		J.force = J.force_dual_wielded

	if(I.wielded_mult)
		I.force = (I.force * I.wielded_mult)
	else //This will give items wielded 15% more damage. This is balanced by the fact you cannot use your other hand.
		I.force = (I.force * FALLBACK_FORCE) //Items that do 0 damage will still do 0 damage though.
	
	if(J.wielded_mult)
		J.force = (J.force * J.wielded_mult)
	else //This will give items wielded 15% more damage. This is balanced by the fact you cannot use your other hand.
		J.force = (J.force * FALLBACK_FORCE) //Items that do 0 damage will still do 0 damage though.

	I.memory_original_name = I.name //Else using [initial(name)] for the name of object returns compile-time name without any changes that've happened to the object's name
	J.memory_original_name = J.name
	I.name = "[I.name] (Dual Wielded)"
	J.name = "[J.name] (Dual Wielded)"
	I.update_icon()//Legacy	
	J.update_icon()//Legacy

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
			dualwield_end(user,I ,J)
	if(I)
		I.is_dual_wielded = FALSE  //even though, these should be already false, let's be certain about it
	if(J)
		J.is_dual_wielded = FALSE

/obj/item/equipped(mob/living/user)  //if we are equipping our dual wielded blades while dualwielding, we want to end dual wielding
	..()
	var/obj/item/I = src
	var/obj/item/J = user.get_inactive_held_item()

	if(I && J)
		if(I.is_dual_wielded || J.is_dual_wielded)
			dualwield_end(user,I ,J)
	if(I)
		I.is_dual_wielded = FALSE  //even though, these should be already false, let's be certain about it
	if(J)
		J.is_dual_wielded = FALSE

// /mob/living/swap_hand()
// 	. = ..()
// 	to_chat(usr, span_warning("Leonzrygin, debug message n. 4"))

