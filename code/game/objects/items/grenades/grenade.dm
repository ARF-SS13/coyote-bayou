/obj/item/grenade
	name = "grenade"
	desc = "It has an adjustable timer."
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade"
	inhand_icon_state = "flashbang"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	throw_speed = 3
	throw_range = 7
	throwforce = 1
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	resistance_flags = FLAMMABLE
	max_integrity = 40
	var/preprime_sound = 'sound/f13weapons/garand_ping.ogg'
	var/active = 0
	var/det_time = 50
	var/display_timer = 1
	var/clumsy_check = GRENADE_CLUMSY_FUMBLE
	var/sticky = FALSE
	// I moved the explosion vars and behavior to base grenades because we want all grenades to call [/obj/item/grenade/proc/prime] so we can send COMSIG_GRENADE_PRIME
	///how big of a devastation explosion radius on prime
	var/ex_dev = 0
	///how big of a heavy explosion radius on prime
	var/ex_heavy = 0
	///how big of a light explosion radius on prime
	var/ex_light = 0
	///how big of a flame explosion radius on prime
	var/ex_flame = 0
	tastes = list("metal" = 1, "a bad time" = 2)

	// dealing with creating a [/datum/component/pellet_cloud] on prime
	/// if set, will spew out projectiles of this type
	var/shrapnel_type
	/// the higher this number, the more projectiles are created as shrapnel
	var/shrapnel_radius
	var/shrapnel_initialized

/obj/item/grenade/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_VORE_ATOM_DIGESTED,PROC_REF(vore_prime))

/obj/item/grenade/deconstruct(disassembled = TRUE)
	if(!disassembled)
		prime()
	if(!QDELETED(src))
		qdel(src)

/obj/item/grenade/proc/botch_check(mob/living/carbon/human/user)
	var/clumsy = HAS_TRAIT(user, TRAIT_CLUMSY)
	if(clumsy)
		if(clumsy_check == GRENADE_CLUMSY_FUMBLE && prob(50))
			to_chat(user, span_warning("Huh? How does this thing work?"))
			preprime(user, 5, FALSE)
			return TRUE
	else if(clumsy_check == GRENADE_NONCLUMSY_FUMBLE && !(user.mind && HAS_TRAIT(user.mind, TRAIT_CLOWN_MENTALITY)))
		to_chat(user, span_warning("You pull the pin on [src]. Attached to it is a pink ribbon that says, \"<span class='clown'>HONK</span>\""))
		preprime(user, 5, FALSE)
		return TRUE

	else if(sticky && prob(50)) // to add risk to sticky tape grenade cheese, no return cause we still prime as normal after
		to_chat(user, span_warning("What the... [src] is stuck to your hand!"))
		ADD_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)

/obj/item/grenade/examine(mob/user)
	. = ..()
	if(display_timer)
		if(det_time > 1)
			. += "The timer is set to [DisplayTimeText(det_time)]."
		else
			. += "\The [src] is set for instant detonation."


/obj/item/grenade/attack_self(mob/user)
	if(user && user.incapacitated(allow_crit = TRUE))
		to_chat(user, span_danger("You're too messed up to do that!"))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_NODROP))
		to_chat(user, span_notice("You try prying [src] off your hand..."))
		if(do_after(user, 70, target=src))
			to_chat(user, span_notice("You manage to remove [src] from your hand."))
			REMOVE_TRAIT(src, TRAIT_NODROP, STICKY_NODROP)

		return

	if(!active)
		if(!botch_check(user)) // if they botch the prime, it'll be handled in botch_check
			preprime(user)

/obj/item/grenade/proc/log_grenade(mob/user, turf/T)
	var/message = "[ADMIN_LOOKUPFLW(user)]) primed \a [src] at [ADMIN_VERBOSEJMP(T)]"
	GLOB.bombers += message
	message_admins(message)
	log_game("[key_name(user)] primed \a [src] at [AREACOORD(T)].")

// heh
/obj/item/grenade/proc/vore_prime(datum/source, obj/vore_belly/belly, mob/living/vorer)
	SIGNAL_HANDLER
	if(active)
		return
	to_chat(vorer, span_userdanger("Uh oh."))
	vorer?.visible_message(
		span_alert("[vorer]'s [belly] starts ticking?"),
		pref_check = VOREPREF_VORE_MESSAGES
	)
	INVOKE_ASYNC(src,PROC_REF(preprime), vorer, null, FALSE, 100)
	return TRUE

// for electric beep on activation
/obj/item/grenade/proc/preprime(mob/user, delayoverride, msg = TRUE, volume = 60)
	var/turf/T = get_turf(src)
	log_grenade(user, T) //Inbuilt admin procs already handle null users
	if(user)
		add_fingerprint(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_on()
		if(msg)
			to_chat(user, span_warning("You prime [src]! [DisplayTimeText(det_time)]!"))
	playsound(src, preprime_sound, volume, 1)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	inhand_icon_state = initial(inhand_icon_state) + "_active"
	addtimer(CALLBACK(src,PROC_REF(prime)), isnull(delayoverride)? det_time : delayoverride)

// Turn on the grenade if shot
/obj/item/grenade/bullet_act(obj/item/projectile/P)
	. = ..()
	preprime(null, null, FALSE, 100)

// Blow up the grenade if exploded
/obj/item/grenade/ex_act(severity, target)
	prime()
	. = ..()

// for ticking sound until detonation
/obj/item/grenade/proc/primetimer(mob/user, delayoverride, msg = TRUE, volume = 60) 
	var/turf/T = get_turf(src)
	log_grenade(user, T) //Inbuilt admin procs already handle null users
	if(user)
		add_fingerprint(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_on()
		if(msg)
			playsound(src, preprime_sound, 100, 1)
			to_chat(user, span_warning("You prime [src]! [DisplayTimeText(det_time)]!"))
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	inhand_icon_state = initial(inhand_icon_state) + "_active"
	addtimer(CALLBACK(src,PROC_REF(prime)), isnull(delayoverride)? det_time : delayoverride)

// For hissing fuse sound
/obj/item/grenade/proc/primefuse(mob/user, delayoverride, msg = TRUE, volume = 60) 
	var/turf/T = get_turf(src)
	log_grenade(user, T) //Inbuilt admin procs already handle null users
	if(user)
		add_fingerprint(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_on()
		if(msg)
			to_chat(user, span_warning("You prime [src]! [DisplayTimeText(det_time)]!"))
	playsound(src, preprime_sound, volume, 1)
	active = TRUE
	icon_state = initial(icon_state) + "_active"
	inhand_icon_state = initial(inhand_icon_state) + "_active"
	addtimer(CALLBACK(src,PROC_REF(prime)), isnull(delayoverride)? det_time : delayoverride)


/obj/item/grenade/proc/prime(mob/living/lanced_by)
	var/turf/T = get_turf(src)
	log_game("Grenade detonation at [AREACOORD(T)], location [loc]")

	if(shrapnel_type && shrapnel_radius && !shrapnel_initialized) // add a second check for adding the component in case whatever triggered the grenade went straight to prime (badminnery for example)
		shrapnel_initialized = TRUE
		AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_radius)

	SEND_SIGNAL(src, COMSIG_GRENADE_PRIME, lanced_by)
	if(ex_dev || ex_heavy || ex_light || ex_flame)
		explosion(loc, ex_dev, ex_heavy, ex_light, flame_range = ex_flame)

/obj/item/grenade/proc/update_mob()
	if(ismob(loc))
		var/mob/M = loc
		M.dropItemToGround(src)
	else if(isitem(loc))
		var/obj/item/I = loc
		I.grenade_prime_react(src)

/obj/item/grenade/tool_act(mob/living/user, obj/item/I, tool_behaviour)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		switch(det_time)
			if ("1")
				det_time = 10
				to_chat(user, span_notice("You set the [name] for 1 second detonation time."))
			if ("10")
				det_time = 30
				to_chat(user, span_notice("You set the [name] for 3 second detonation time."))
			if ("30")
				det_time = 50
				to_chat(user, span_notice("You set the [name] for 5 second detonation time."))
			if ("50")
				det_time = 1
				to_chat(user, span_notice("You set the [name] for instant detonation."))
		add_fingerprint(user)
	else
		return ..()

/obj/item/grenade/attack_paw(mob/user)
	return attack_hand(user)

/obj/item/grenade/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(attack_type & ATTACK_TYPE_PROJECTILE)
		var/obj/item/projectile/P = object
		if(damage && !P.nodamage && (P.damage_type != STAMINA) && prob(15))
			owner.visible_message(span_danger("[attack_text] hits [owner]'s [src], setting it off! What a shot!"))
			prime()
			return BLOCK_SUCCESS | BLOCK_PHYSICAL_EXTERNAL
	return ..()

/obj/item/proc/grenade_prime_react(obj/item/grenade/nade)
	return
