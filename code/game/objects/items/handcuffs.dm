/obj/item/restraints
	breakouttime = 600
	var/demoralize_criminals = TRUE // checked on carbon/carbon.dm to decide wheter to apply the handcuffed negative moodlet or not.
	var/del_on_remove = FALSE

/obj/item/restraints/Destroy()
	if(iscarbon(loc))
		var/mob/living/carbon/M = loc
		if(M.handcuffed == src)
			M.handcuffed = null
			M.update_handcuffed()
			if(M.buckled && M.buckled.buckle_requires_restraints)
				M.buckled.unbuckle_mob(M)
		if(M.legcuffed == src)
			M.legcuffed = null
			M.update_inv_legcuffed()
	return ..()

//Handcuffs

/obj/item/restraints/handcuffs
	name = "handcuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handcuff"
	inhand_icon_state = "handcuff"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=500)
	breakouttime = 600 //Deciseconds = 60s = 1 minute
	armor = ARMOR_VALUE_GENERIC_ITEM
	var/cuffsound = 'sound/weapons/handcuffs.ogg'
	var/trashtype = null //for disposable cuffs

/obj/item/restraints/handcuffs/attack(mob/living/carbon/C, mob/living/user)
	if(!istype(C))
		return

	if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
		to_chat(user, span_warning("Uh... how do those things work?!"))
		apply_cuffs(user,user)
		return

	// chance of monkey retaliation
	if(ismonkey(C) && prob(MONKEY_CUFF_RETALIATION_PROB))
		var/mob/living/carbon/monkey/M
		M = C
		M.retaliate(user)

	if(!C.handcuffed)
		if(C.get_num_arms(FALSE) >= 2 || C.get_arm_ignore())
			C.visible_message(span_danger("[user] is trying to put [src.name] on [C]!"), \
								span_userdanger("[user] is trying to put [src.name] on [C]!"))

			playsound(loc, cuffsound, 30, 1, -2)
			if(do_mob(user, C, 30) && (C.get_num_arms(FALSE) >= 2 || C.get_arm_ignore()))
				if(iscyborg(user))
					apply_cuffs(C, user, TRUE)
				else
					apply_cuffs(C, user)
				to_chat(user, span_notice("You handcuff [C]."))
				SSblackbox.record_feedback("tally", "handcuffs", 1, type)

				log_combat(user, C, "handcuffed")
			else
				to_chat(user, span_warning("You fail to handcuff [C]!"))
		else
			to_chat(user, span_warning("[C] doesn't have two hands..."))

/obj/item/restraints/handcuffs/proc/apply_cuffs(mob/living/carbon/target, mob/user, dispense = 0)
	if(target.handcuffed)
		return

	if(!user.temporarilyRemoveItemFromInventory(src) && !dispense)
		return

	var/obj/item/restraints/handcuffs/cuffs = src
	if(trashtype)
		cuffs = new trashtype()
	else if(dispense)
		cuffs = new type()

	target.equip_to_slot(cuffs, SLOT_HANDCUFFED)

	if(trashtype && !dispense)
		qdel(src)
	if(iscyborg(user))
		playsound(user, "law", 50, 0)
	return

/obj/item/restraints/handcuffs/sinew
	name = "sinew restraints"
	desc = "A pair of restraints fashioned from long strands of flesh."
	icon = 'icons/obj/mining.dmi'
	icon_state = "sinewcuff"
	breakouttime = 300 //Deciseconds = 30s
	cuffsound = 'sound/weapons/cablecuff.ogg'

/obj/item/restraints/handcuffs/cable
	name = "cable restraints"
	desc = "Looks like some cables tied together. Could be used to tie something up."
	icon_state = "cuff"
	inhand_icon_state = "coil"
	color =  "#ff0000"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(/datum/material/iron=150, /datum/material/glass=75)
	breakouttime = 300 //Deciseconds = 30s
	cuffsound = 'sound/weapons/cablecuff.ogg'

/obj/item/restraints/handcuffs/cable/attack_self(mob/user)
	to_chat(user, span_notice("You start unwinding the cable restraints back into coil"))
	if(!do_after(user, 25, TRUE, user))
		return
	qdel(src)
	var/obj/item/stack/cable_coil/coil = new(get_turf(user))
	coil.amount = 15
	user.put_in_hands(coil)
	coil.color = color
	to_chat(user, span_notice("You unwind the cable restraints back into coil"))

/obj/item/restraints/handcuffs/cable/red
	color = "#ff0000"

/obj/item/restraints/handcuffs/cable/yellow
	color = "#ffff00"

/obj/item/restraints/handcuffs/cable/blue
	color = "#1919c8"

/obj/item/restraints/handcuffs/cable/green
	color = "#00aa00"

/obj/item/restraints/handcuffs/cable/pink
	color = "#ff3ccd"

/obj/item/restraints/handcuffs/cable/orange
	color = "#ff8000"

/obj/item/restraints/handcuffs/cable/cyan
	color = "#00ffff"

/obj/item/restraints/handcuffs/cable/white
	color = null

/obj/item/restraints/handcuffs/cable/random

/obj/item/restraints/handcuffs/cable/random/Initialize(mapload)
	. = ..()
	var/list/cable_colors = GLOB.cable_colors
	color = pick(cable_colors)

/obj/item/restraints/handcuffs/cable/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if (R.use(1))
			var/obj/item/wirerod/W = new /obj/item/wirerod
			remove_item_from_storage(user)
			user.put_in_hands(W)
			to_chat(user, span_notice("You wrap the cable restraint around the top of the rod."))
			qdel(src)
		else
			to_chat(user, span_warning("You need one rod to make a wired rod!"))
			return
	else if(istype(I, /obj/item/stack/sheet/metal))
		var/obj/item/stack/sheet/metal/M = I
		if(M.get_amount() < 6)
			to_chat(user, span_warning("You need at least six metal sheets to make good enough weights!"))
			return
		to_chat(user, span_notice("You begin to apply [I] to [src]..."))
		if(do_after(user, 35, target = src))
			if(M.get_amount() < 6 || !M)
				return
			var/obj/item/restraints/legcuffs/bola/S = new /obj/item/restraints/legcuffs/bola
			M.use(6)
			user.put_in_hands(S)
			to_chat(user, span_notice("You make some weights out of [I] and tie them to [src]."))
			remove_item_from_storage(user)
			qdel(src)
	else
		return ..()

/obj/item/restraints/handcuffs/cable/zipties
	name = "zipties"
	desc = "Plastic, disposable zipties that can be used to restrain temporarily but are destroyed after use."
	inhand_icon_state = "zipties"
	color = "white"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	custom_materials = null
	breakouttime = 450 //Deciseconds = 45s
	trashtype = /obj/item/restraints/handcuffs/cable/zipties/used

/obj/item/restraints/handcuffs/cable/zipties/attack_self() //Zipties arent cable
	return

/obj/item/restraints/handcuffs/cable/zipties/used
	desc = "A pair of broken zipties."
	icon_state = "cuff_used"

/obj/item/restraints/handcuffs/cable/zipties/used/attack()
	return

/obj/item/restraints/handcuffs/alien
	icon_state = "handcuffAlien"

/obj/item/restraints/handcuffs/fake
	name = "fake handcuffs"
	desc = "Fake handcuffs meant for gag purposes."
	breakouttime = 10 //Deciseconds = 1s
	demoralize_criminals = FALSE

/obj/item/restraints/handcuffs/fake/kinky
	name = "kinky handcuffs"
	desc = "Imitation handcuffs meant for erotic roleplay."
	icon_state = "handcuffgag"
	inhand_icon_state = "kinkycuff"

//Legcuffs

/obj/item/restraints/legcuffs
	name = "leg cuffs"
	desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handcuff"
	inhand_icon_state = "legcuff"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	flags_1 = CONDUCT_1
	throwforce = 0
	w_class = WEIGHT_CLASS_SMALL
	slowdown = 4.5
	breakouttime = 300	//Deciseconds = 30s = 0.5 minute

/obj/item/restraints/legcuffs/beartrap
	name = "bear trap"
	throw_speed = 1
	throw_range = 1
	icon_state = "beartrap"
	w_class = WEIGHT_CLASS_NORMAL
	desc = "A trap used to catch bears and other legged creatures."
	var/armed = FALSE
	var/trap_damage = 30

/obj/item/restraints/legcuffs/beartrap/Initialize()
	. = ..()
	icon_state = "[initial(icon_state)][armed]"
	
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(spring_trap),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/item/restraints/legcuffs/beartrap/attack_self(mob/user)
	..()
	if(ishuman(user) && !user.stat && !user.restrained())
		armed = !armed
		icon_state = "[initial(icon_state)][armed]"
		to_chat(user, span_notice("[src] is now [armed ? "armed" : "disarmed"]"))

/obj/item/restraints/legcuffs/beartrap/proc/spring_trap(datum/source, atom/movable/AM, thrown_at = FALSE)
	SIGNAL_HANDLER
	if(!armed || !isturf(loc) || !isliving(AM))
		return
	var/mob/living/L = AM
	var/snap = TRUE
	// if(istype(L.buckled, /obj/vehicle))
	// 	var/obj/vehicle/ridden_vehicle = L.buckled
	// 	if(!ridden_vehicle.are_legs_exposed) //close the trap without injuring/trapping the rider if their legs are inside the vehicle at all times.
	// 		close_trap()
	// 		ridden_vehicle.visible_message(span_danger("[ridden_vehicle] triggers \the [src]."))

	if(!thrown_at && L.movement_type & (FLYING|FLOATING)) //don't close the trap if they're flying/floating over it.
		snap = FALSE

	var/def_zone = BODY_ZONE_CHEST
	if(snap && iscarbon(L))
		var/mob/living/carbon/C = L
		if(!C.lying)
			def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(!C.legcuffed) //beartrap can't cuff your leg if there's already a beartrap or legcuffs, or you don't have two legs.
				INVOKE_ASYNC(C, TYPE_PROC_REF(/mob/living/carbon,equip_to_slot), src, SLOT_LEGCUFFED)
				SSblackbox.record_feedback("tally", "handcuffs", 1, type)
	else if(snap && isanimal(L))
		var/mob/living/simple_animal/SA = L
		if(SA.mob_size <= MOB_SIZE_TINY) //don't close the trap if they're as small as a mouse.
			snap = FALSE
	if(snap)
		close_trap()
		if(!thrown_at)
			L.visible_message(span_danger("[L] triggers \the [src]."), \
					span_userdanger("You trigger \the [src]!"))
		else
			L.visible_message(span_danger("\The [src] ensnares [L]!"), \
					span_userdanger("\The [src] ensnares you!"))
		L.apply_damage(trap_damage, BRUTE, def_zone)

/**
 * Closes a bear trap
 *
 * Closes a bear trap.
 * Arguments:
 */
/obj/item/restraints/legcuffs/beartrap/proc/close_trap()
	armed = FALSE
	update_icon()
	playsound(src, 'sound/effects/snap.ogg', 50, TRUE)

/obj/item/restraints/legcuffs/beartrap/energy
	name = "energy snare"
	armed = TRUE
	icon_state = "e_snare"
	trap_damage = 0
	item_flags = DROPDEL
	flags_1 = NONE
	breakouttime = 50

/obj/item/restraints/legcuffs/beartrap/energy/New()
	..()
	addtimer(CALLBACK(src,PROC_REF(dissipate)), 100)

/obj/item/restraints/legcuffs/beartrap/energy/proc/dissipate()
	if(!ismob(loc))
		do_sparks(1, TRUE, src)
		qdel(src)

/obj/item/restraints/legcuffs/beartrap/energy/cyborg
	breakouttime = 20 // Cyborgs shouldn't have a strong restraint

/obj/item/restraints/legcuffs/bola
	name = "bola"
	desc = "A restraining device designed to be thrown at the target. Upon connecting with said target, it will wrap around their legs, making it difficult for them to move quickly."
	icon_state = "bola"
	breakouttime = 20//easy to apply, easy to break out of
	gender = NEUTER
	slowdown = 1.3
	var/knockdown = 0

/obj/item/restraints/legcuffs/bola/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback)
	if(!..())
		return
	playsound(src.loc,'sound/weapons/bolathrow.ogg', 75, 1)

/obj/item/restraints/legcuffs/bola/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !iscarbon(hit_atom))//if it gets caught or the target can't be cuffed,
		return//abort
	ensnare(hit_atom)

/obj/item/restraints/legcuffs/bola/fragile
	name = "crude bola"
	desc = "An unsturdy piece of cables and sinew that'll tangle up a target's legs. Once applied, they're easy to remove, but next to impossible to retrieve \
		from the victim. They also have a habit of falling right the fuck apart if it hits anything more solid than a pair of legs."
	breakouttime = 1.5 SECONDS
	del_on_remove = TRUE

/obj/item/restraints/legcuffs/bola/fragile/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!iscarbon(hit_atom))
		qdel(src)
		return
	..()

/**
 * Attempts to legcuff someone with the bola
 *
 * Arguments:
 * * C - the carbon that we will try to ensnare
 */
/obj/item/restraints/legcuffs/bola/proc/ensnare(mob/living/carbon/C)
	if(!C.legcuffed && C.get_num_legs(FALSE) >= 2)
		visible_message(span_danger("\The [src] ensnares [C]!"))
		C.legcuffed = src
		forceMove(C)
		C.update_equipment_speed_mods()
		C.update_inv_legcuffed()
		SSblackbox.record_feedback("tally", "handcuffs", 1, type)
		to_chat(C, span_userdanger("\The [src] ensnares you!"))
		C.Knockdown(knockdown)
		playsound(src, 'sound/effects/snap.ogg', 50, TRUE)
		return TRUE

/obj/item/restraints/legcuffs/bola/tactical//traitor variant
	name = "reinforced bola"
	desc = "A strong bola, made with a long steel chain. It looks heavy, enough so that it could trip somebody."
	icon_state = "bola_r"
	breakouttime = 35
	slowdown = 7

/obj/item/restraints/legcuffs/bola/energy //For Security
	name = "energy bola"
	desc = "A specialized hard-light bola designed to ensnare fleeing criminals and aid in arrests."
	icon_state = "ebola"
	hitsound = 'sound/weapons/taserhit.ogg'
	w_class = WEIGHT_CLASS_SMALL
	breakouttime = 60

/obj/item/restraints/legcuffs/bola/energy/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(iscarbon(hit_atom))
		var/obj/item/restraints/legcuffs/beartrap/B = new /obj/item/restraints/legcuffs/beartrap/energy/cyborg(get_turf(hit_atom))
		B.Crossed(hit_atom)
		qdel(src)
	..()
