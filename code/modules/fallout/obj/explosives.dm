#define DISABLED 0
#define PREACTIVE 1
#define ACTIVE 2

/obj/item/bottlecap_mine
	name = "bottlecap mine"
	desc = "It has an adjustable timer. It can explode in 5 seconds after activating."
	w_class = 2
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "capmine"
	item_state = "capmine"
	throw_speed = 1
	throw_range = 0
//	flags = CONDUCT
	resistance_flags = FLAMMABLE
	obj_integrity = 80
	max_integrity = 80
	var/state = FALSE
	layer = 10

/obj/item/bottlecap_mine/attack_self(mob/user as mob)
	toggle_activate(user)


/obj/item/bottlecap_mine/proc/toggle_activate(mob/user)
	switch(state)
		if(DISABLED)
			state = PREACTIVE
			update_icon()
			spawn(50)
				if(state == PREACTIVE)
					state = ACTIVE
					update_icon()
					playsound(get_turf(src),'sound/f13weapons/mine_one.ogg',50)
					START_PROCESSING(SSobj, src)
		if(PREACTIVE)
			state = DISABLED
			update_icon()
		if(ACTIVE)
			state = DISABLED
			update_icon()
			STOP_PROCESSING(SSobj, src)

/obj/item/bottlecap_mine/proc/boom()
	explosion(src.loc,0,2,3, flame_range = 6)

/obj/item/bottlecap_mine/process()
	if(state != ACTIVE)
		STOP_PROCESSING(SSobj, src)
		return
	if (locate(/mob/living) in range(1, get_turf(src)))
		playsound(get_turf(src),'sound/f13weapons/mine_five.ogg',50)
		spawn(5)
			boom()
			STOP_PROCESSING(SSobj, src)
			return
	if(prob(15))
		playsound(get_turf(src),'sound/f13weapons/mine_one.ogg',100, extrarange = -5)

/*
/obj/item/bottlecap_mine/proc/on_entered(go/AM)
	if(state == ACTIVE && ishuman(AM))
		boom()
*/

/obj/item/bottlecap_mine/update_icon()
	switch(state)
		if(DISABLED)
			icon_state = "capmine"
		if(PREACTIVE)
			icon_state = "capmine_preactive"
		if(ACTIVE)
			icon_state = "capmine_active"

/obj/item/bottlecap_mine/examine(mob/user)
	. = ..()
	switch(state)
		if(DISABLED)
			. += span_warning("It seems to be inactive.")
		if(PREACTIVE)
			. += span_warning("It seems to be activating!")
		if(ACTIVE)
			. += span_warning("It seems activated!")




/obj/item/grenade/plastic/c4/New()
	wires = new /datum/wires/explosive/c4(src)
	..()

/obj/item/grenade/plastic/c4/Destroy()
	qdel(wires)
	wires = null
	target = null
	return ..()

/obj/item/mine
	name = "dummy mine"
	desc = "Better stay away from that thing."
	w_class = WEIGHT_CLASS_NORMAL
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "uglymine"
	var/armed = TRUE //we can be armed and unanchored if we want, but this isn't normally the case
	var/random = FALSE //are our wires random?
	/// We manually check to see if we've been triggered in case multiple atoms cross us in the time between the mine being triggered and it actually deleting, to avoid a race condition with multiple detonations
	var/triggered = FALSE

/obj/item/mine/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_WIRES)

/obj/item/mine/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	if(random)
		wires = new /datum/wires/explosive/mine/random(src)
	else
		wires = new /datum/wires/explosive/mine(src)


/obj/item/mine/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/item/mine/attack_self(mob/user)
	if(armed)
		to_chat(user, "<span class='danger'>The mine is already armed!</span>") //how did we get here
	if(user.dropItemToGround(src))
		anchored = TRUE
		addtimer(CALLBACK(src, .proc/arm), 5 SECONDS)
		to_chat(user, "<span class='notice'>You drop the mine and activate the 5-second arming process.</span>")
		return

/obj/item/mine/proc/arm()
	visible_message("<span class='danger'>[src] beeps!</span>")
	if(armed)
		triggermine()
		return
	armed = TRUE

/obj/item/mine/attackby(obj/item/I, mob/user, params)
	if(is_wire_tool(I))
		wires.interact(user)
	else ..()

/obj/item/mine/proc/mineEffect(mob/victim)
	to_chat(victim, "<span class='danger'>*click*</span>")

/obj/item/mine/proc/on_entered(atom/movable/AM)
	SIGNAL_HANDLER
	if(!armed)
		return
	if(triggered || !isturf(loc) || !isliving(AM) || isstructure(AM) || isnottriggermine(AM))
		return

	if(AM.movement_type & FLYING)
		return

	INVOKE_ASYNC(src, .proc/triggermine, AM)

/obj/item/mine/proc/triggermine(mob/victim)
	if(triggered)
		return
	visible_message("<span class='danger'>[victim] sets off [icon2html(src, viewers(src))] [src]!</span>")
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(3, 1, src)
	s.start()
	mineEffect(victim)
	SEND_SIGNAL(src, COMSIG_ITEM_MINE_TRIGGERED)
	triggered = 1
	qdel(src)

/obj/item/mine/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir)
	. = ..()
	triggermine()

/obj/item/mine/screwdriver_act(mob/living/user, obj/item/S)
	if(!armed)
		return
	to_chat(user, "<span class='danger'>You begin carefully disarming [src].</span>")
	if(S.use_tool(src, user, 200, volume=100)) //20 seconds base, if you don't want to play the game of chance
		to_chat(user, "<span class='notice'>You carefully destroy the detonator of the mine!</span>")
		qdel(src)
	else
		triggermine(user)

/obj/item/mine/explosive
	name = "explosive mine"
	var/range_devastation = 0
	var/range_heavy = 1
	var/range_light = 2
	var/range_flash = 3

/obj/item/mine/explosive/mineEffect(mob/victim)
	explosion(loc, range_devastation, range_heavy, range_light, range_flash)

/obj/item/mine/explosive/random
	random = TRUE
	anchored = FALSE
	armed = FALSE

/obj/item/mine/stun
	name = "stun mine"
	var/stun_time = 80

/obj/item/mine/stun/mineEffect(mob/living/victim)
	if(isliving(victim))
		victim.DefaultCombatKnockdown(stun_time)

/obj/item/mine/stun/random
	random = TRUE
	anchored = FALSE
	armed = FALSE

/obj/item/mine/shrapnel
	name = "shrapnel mine"
	var/shrapnel_type = /obj/item/projectile/bullet/shrapnel
	var/shrapnel_magnitude = 3

/obj/item/mine/shrapnel/mineEffect(mob/victim)
	AddComponent(/datum/component/pellet_cloud, projectile_type=shrapnel_type, magnitude=shrapnel_magnitude)
	explosion(loc, 0, 0, 2, 2)

/obj/item/mine/shrapnel/random
	random = TRUE
	anchored = FALSE
	armed = FALSE

/obj/item/mine/shrapnel/sting
	name = "stinger mine"
	shrapnel_type = /obj/item/projectile/bullet/pellet/stingball

/obj/item/mine/shrapnel/sting/random
	random = TRUE
	anchored = FALSE
	armed = FALSE

/obj/item/mine/kickmine
	name = "kick mine"

/obj/item/mine/kickmine/mineEffect(mob/victim)
	if(isliving(victim) && victim.client)
		to_chat(victim, "<span class='userdanger'>You have been kicked FOR NO REISIN!</span>")
		qdel(victim.client)


/obj/item/mine/gas
	name = "oxygen mine"
	var/gas_amount = 360
	var/gas_type = "o2"

/obj/item/mine/gas/mineEffect(mob/victim)
	atmos_spawn_air("[gas_type]=[gas_amount]")


/obj/item/mine/gas/plasma
	name = "plasma mine"
	gas_type = "plasma"


/obj/item/mine/gas/n2o
	name = "\improper N2O mine"
	gas_type = "n2o"

/obj/item/mine/sound
	name = "dummy mine"
	var/soundtoplay

/obj/item/mine/sound/mineEffect(mob/victim)
	playsound(loc, soundtoplay, 100, 1)

/obj/item/mine/sound/bwoink
	soundtoplay = 'sound/effects/adminhelp.ogg'

/obj/item/mine/emp
	name = "pulse mine"
	var/range = 3

/obj/item/mine/emp/mineEffect(mob/victim)
	empulse_using_range(src, range)

/obj/item/mine/emp/random
	random = TRUE
	anchored = FALSE
	armed = FALSE
