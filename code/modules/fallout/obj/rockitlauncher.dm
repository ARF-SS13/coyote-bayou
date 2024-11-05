
///////////////////////////
// Rock-It-Launcher pack //
///////////////////////////

/obj/item/rockitlauncher_pack
	name = "\improper Rock-It-Launcher"
	desc = "Homemade pneumatic cannon made from a vacuum cleaner, firehose, and a leaf blower."
	icon = 'icons/fallout/objects/guns/rockitlauncher.dmi'
	icon_state = "rockitlauncher_back"
	inhand_icon_state = "rockitlauncher_back"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	slot_flags = INV_SLOTBIT_BACK
	w_class = WEIGHT_CLASS_HUGE
	var/obj/item/pneumatic_cannon/rockitlauncher/gun //The nozzle of the launcher
	var/armed = 0 //whether the gun is attached, 0 is attached, 1 is the gun is wielded.
	var/maxWeightClass = 10 //The max weight of items that can fit into the cannon
	var/loadedWeightClass = 0 //The weight of items currently in the cannon
	var/pressureSetting = 1 //How powerful the cannon is - higher pressure = more gas but more powerful throws
	var/list/loadedItems = list() //What is loaded in the launcher
	var/overheat = 0 //How hot the loader is. Too hot and it will not fire
	var/overheat_max = 3 //How hot it can get before it stops firing
	var/heat_diffusion = 1 //Acts as a 'literal' cooldown. How much heat is lost.

		//Add things that we do not want in the launcher here
	var/static/list/blacklist_typecache = typecacheof(/obj/item/throwing_star)

/obj/item/rockitlauncher_pack/Initialize()
	. = ..()
	gun = new(src)
	START_PROCESSING(SSobj, src)

/obj/item/rockitlauncher_pack/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/rockitlauncher_pack/process()
	overheat = max(0, overheat - heat_diffusion)

/obj/item/rockitlauncher_pack/on_attack_hand(mob/living/user) //Grabbing the "gun"
	if(src.loc == user)
		if(!armed)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				armed = 1
				if(!user.put_in_hands(gun))
					armed = 0
					to_chat(user, span_warning("You need a free hand to hold the nozzle!"))
					return
				update_icon()
				user.update_inv_back()
			else
				..()
		else
			to_chat(user, span_warning("You are already holding the nozzle!"))
	else
		..()

/obj/item/rockitlauncher_pack/dropped(mob/user)
	. = ..()
	if(armed)
		user.dropItemToGround(gun, TRUE)

/obj/item/rockitlauncher_pack/MouseDrop(atom/over_object) //This allows you to move the pack to your hand from your back, I think - Dave
	. = ..()
	if(armed)
		return
	if(isliving(usr))
		var/mob/living/M = usr

		if(!over_object)
			return

		if(!M.incapacitated(allow_crit = TRUE))

			if(istype(over_object, /atom/movable/screen/inventory/hand))
				var/atom/movable/screen/inventory/hand/H = over_object
				M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/rockitlauncher_pack/update_icon_state()
	if(armed)
		icon_state = "rockitlauncher_back_unholstered"
	else
		icon_state = "rockitlauncher_back"

/obj/item/rockitlauncher_pack/proc/attach_gun(mob/user)
	if(!gun)
		gun = new(src)
	gun.forceMove(src)
	armed = 0
	if(user)
		to_chat(user, span_notice("You attach the [gun.name] to the [name]."))
	else
		src.visible_message(span_warning("The [gun.name] snaps back onto the [name]!"))
	update_icon()
	user.update_inv_back()


/obj/item/rockitlauncher_pack/attackby(obj/item/W, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(W == gun) //Don't need armed check, because if you have the gun assume its armed.
		user.dropItemToGround(gun, TRUE)
		return
	else if(istype(W, /obj/item/wrench))
		switch(pressureSetting)
			if(1)
				pressureSetting = 2
			if(2)
				pressureSetting = 3
			if(3)
				pressureSetting = 1
		to_chat(user, span_notice("You tweak \the [src]'s pressure output to [pressureSetting]."))
	else if(istype(W, /obj/item/screwdriver))
		switch(gun.settings)
			if(1)
				gun.fire_mode = PCANNON_FILO
				gun.settings = 2
				to_chat(user, span_notice("You switch \the [src]'s fire mode to fire the last item inserted first."))
			if(2)
				gun.throw_amount = 5
				gun.settings = 3
				to_chat(user, span_notice("You switch \the [src]'s fire mode to fire five objects at once."))
			if(3)
				gun.throw_amount = 1
				gun.settings = 1
				gun.fire_mode = PCANNON_FIFO
				to_chat(user, span_notice("You switch \the [src]'s fire mode to fire the first item inserted first."))
	else if(loadedWeightClass >= maxWeightClass)
		to_chat(user, span_warning("\The [src] can't hold any more items!"))
	else if(isitem(W))
		var/obj/item/IW = W
		load_item(IW, user)
	else
		..()

/obj/item/rockitlauncher_pack/proc/can_load_item(obj/item/I, mob/user)
	if(!istype(I))			//Players can't load non items, this allows for admin varedit inserts.
		return TRUE
	if(is_type_in_typecache(I, blacklist_typecache))
		if(user)
			to_chat(user, span_warning("[I] won't fit into [src]!"))
		return
	if((loadedWeightClass + I.w_class) > maxWeightClass)	//Only make messages if there's a user
		if(user)
			to_chat(user, span_warning("\The [I] won't fit into \the [src]!"))
		return FALSE
	if(I.w_class > w_class)
		if(user)
			to_chat(user, span_warning("\The [I] is too large to fit into \the [src]!"))
		return FALSE
	return TRUE

/obj/item/rockitlauncher_pack/proc/load_item(obj/item/I, mob/user)
	if(!can_load_item(I, user))
		return FALSE
	if(user)		//Only use transfer proc if there's a user, otherwise just set loc.
		if(!user.transferItemToLoc(I, src))
			return FALSE
		to_chat(user, span_notice("You load \the [I] into \the [src]."))
	else
		I.forceMove(src)
	if(istype (I, /obj/item/stack))
		loadedItems += I
		loadedWeightClass += 1
		return TRUE

/*
ISSUE:
The code correctly deducts the weightclass of sheets once they are used up
BUT, the weightclass of the sheets change due to being used up. E.g. a fifty stack will fall from 3 weight to 1 weight
Possible solution: Only add the minimum weight class of a stack (which is basically always 1) so when it is removed fully, it does it correctly. Extremely stupid but might work
*/

	loadedItems += I
	loadedWeightClass += I.w_class
	return TRUE

/obj/item/rockitlauncher_pack/examine(mob/user)
	. = ..()
	if(!in_range(user, src))
		. += span_notice("You'll need to get closer to see any more.")
		return

	. += span_info("The pressure and fire modes can be adjusted with a wrench and screwdriver respectively.")
	. += span_info("Alt-Click to turn spin mode on or off.")
	. += span_info("Ctrl-Click to eject the contents.")

	for(var/obj/item/I in loadedItems)
		. += span_info("[icon2html(I, user)] It has \a [I] loaded.")
		CHECK_TICK

/obj/item/rockitlauncher_pack/handle_atom_del(atom/A)
	. = ..()
	if (loadedItems.Remove(A))
		var/obj/item/I = A
		loadedWeightClass -= I.w_class

/obj/item/rockitlauncher_pack/AltClick(mob/user)
	gun.speen = !gun.speen
	to_chat(user, span_warning("Toggled spin mode [gun.speen?"on":"off"]."))

/obj/item/rockitlauncher_pack/CtrlClick(mob/user)
	eject_contents()
	to_chat(user, span_warning("You open the storage compartment of \the [src], dumping the contents all over the floor."))

/obj/item/rockitlauncher_pack/proc/eject_contents()
	for(var/obj/item/I in loadedItems) //Item To Discharge
		loadedItems -= I
		I.forceMove(get_turf(src))
	loadedWeightClass = 0

/////////////////////////////
// Rock-It-Launcher Nozzle //
/////////////////////////////

/obj/item/pneumatic_cannon/rockitlauncher
	name = "\improper Rock-It-Launcher nozzle"
	desc = "The nozzle of a Rock-It-Launcher pneumatic cannon. Point towards target."
	icon = 'icons/fallout/objects/guns/rockitlauncher.dmi'
	icon_state = "rockitlauncher_nozzle"
	checktank = FALSE
	fire_mode = PCANNON_FIFO
	throw_amount = 1
	var/obj/item/rockitlauncher_pack/ammo_pack
	var/gtimer = 15
	var/speen = TRUE
	var/settings = 1

/obj/item/pneumatic_cannon/rockitlauncher/Initialize()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD,PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD,PROC_REF(on_unwield))

	if(istype(loc, /obj/item/rockitlauncher_pack)) //We should spawn inside an ammo pack so let's use that one.
		ammo_pack = loc
	else
		return INITIALIZE_HINT_QDEL //No pack, no gun

	return ..()

/obj/item/pneumatic_cannon/rockitlauncher/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=5) //Force values may need to be changed, but this is OK for now

/obj/item/pneumatic_cannon/rockitlauncher/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/obj/item/pneumatic_cannon/rockitlauncher/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/pneumatic_cannon/rockitlauncher/dropped(mob/user)
	. = ..()
	if(ammo_pack)
		ammo_pack.attach_gun(user)
	else
		qdel(src)

/obj/item/pneumatic_cannon/rockitlauncher/Fire(mob/living/user, atom/target)
	if(target == ammo_pack)
		return
	if(!wielded)
		to_chat(user, span_warning("You need to hold the nozzle in both hands to fire!"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You feel like this could really hurt someone..."))
		return
	if(!istype(user) && !target)
		return
	var/discharge = 0
	if(!can_trigger_gun(user))
		return
	if(!ammo_pack.loadedItems || !ammo_pack.loadedWeightClass)
		to_chat(user, span_warning("\The [src] has nothing loaded."))
		return
	if(ammo_pack.overheat < ammo_pack.overheat_max)
		ammo_pack.overheat += 1
	else
		to_chat(user, "\The [src] is extremely hot! You shouldn't fire it anymore or it might blow up!")
		return
	if(!discharge)
		user.visible_message(span_danger("[user] fires \the [src]!"), \
							span_danger("You fire \the [src]!"))
	log_combat(user, target, "fired at", src)
	var/turf/T = get_target(target, get_turf(src))
	playsound(src, 'sound/f13weapons/rockitlauncher_fire.ogg', 50, 1)
	fire_items(T, user)
	if(ammo_pack.pressureSetting >= 3 && isliving(user))
		var/mob/living/C = user
		C.visible_message(span_warning("[C] is thrown down by the force of the cannon!"), "<span class='userdanger'>[src] slams into your shoulder, knocking you down!")
		C.DefaultCombatKnockdown(60)

/obj/item/pneumatic_cannon/rockitlauncher/fire_items(turf/target, mob/user)
	if(fire_mode == PCANNON_FIREALL)
		for(var/obj/item/ITD in ammo_pack.loadedItems) //Item To Discharge
			if(!throw_item(target, ITD, user))
				break
	else
		for(var/i in 1 to throw_amount)
			if(!ammo_pack.loadedItems.len)
				break
			var/obj/item/I
			if(fire_mode == PCANNON_FILO)
				I = ammo_pack.loadedItems[ammo_pack.loadedItems.len]
			else
				I = ammo_pack.loadedItems[1]
			if(!throw_item(target, I, user))
				break



/obj/item/pneumatic_cannon/rockitlauncher/throw_item(turf/target, obj/item/I, mob/user)
	if(!istype(I))
		return FALSE
	if(istype(I, /obj/item/grenade))
		var/obj/item/grenade/G = I
		G.preprime(null, gtimer)

	if(istype(I, /obj/item/reagent_containers/food/snacks/grown/firelemon))
		var/obj/item/reagent_containers/food/snacks/grown/firelemon/F = I
		F.attack_self(user)
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.throw_mode_off() //This is needed as the attack_self for lemons toggles your throw mode on.

	if(istype (I, /obj/item/stack))
		var/obj/item/stack/stackos = I
		var/stacko_type = stackos.merge_type
		I.use(1)
		//ammo_pack.loadedWeightClass -= I.w_class
		I = new stacko_type
		I.forceMove(get_turf(src))
		I.throw_at(target, ammo_pack.pressureSetting * 10 * range_multiplier, ammo_pack.pressureSetting * 2, user, speen)
		return TRUE

	else
		ammo_pack.loadedItems -= I
		ammo_pack.loadedWeightClass -= I.w_class
		I.forceMove(get_turf(src))
		I.throw_at(target, ammo_pack.pressureSetting * 10 * range_multiplier, ammo_pack.pressureSetting * 2, user, speen)
		return TRUE

/obj/item/pneumatic_cannon/rockitlauncher/attackby(obj/item/W, mob/user, params)
	return

