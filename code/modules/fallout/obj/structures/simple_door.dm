//In the beginning of time, there was a door subtype called /dooor/ to allow a shitcode copypaste.
// "Fuck them copypastes, someone pls, make a system for dooor so no one gets to copypaste shit!"
//  - bartnixon
// "The system was always there, you just needed to use it ..."
//  - bauen1, the guy having to clean up the mess
// "I know what you feel, bro (and thx)."
//  - maxyo

// Ok, this is the main door directory. They open, they close, they take padlocks, easy. For ID locked doors use either airlocks for mechanical ones, or machinery/unpowered for secure wooden doors or cell doors.

/obj/structure/simple_door
	name = "wooden door"
	desc = "It opens and closes - nothing out of the ordinary."
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "house"
	opacity = TRUE
	density = TRUE
	anchored = TRUE
	layer = CLOSED_DOOR_LAYER
	explosion_block = 0.5
	smoothing_groups = list(SMOOTH_GROUP_WINDOW_FULLTILE)	//	Okay, this is scuffed. If we're a wall that merges with windows, we'll merge with doors too!
	var/can_have_lock = FALSE
	var/obj/item/lock_construct/padlock
	var/obj/item/lock_bolt/deadbolt
	/// Set one that fits the type of door. Default is for a french-style door that opens from the middle.
	var/deadbolt_overlay = "deadbolt"
	var/door_type = "house"
	var/base_opacity = TRUE
	var/manual_opened = 0
	var/material_count = 10
	var/hard_open = FALSE
	var/moving = 0
	var/material_type = /obj/item/stack/sheet/mineral/wood
	var/can_disasemble = 0
	var/open_sound = 'sound/machines/door_open.ogg'
	var/close_sound = 'sound/machines/door_close.ogg'
	var/opening_time = 2
	var/closing_time = 4
	var/can_atmos_pass = -2

	//Multi-tile doors
	dir = EAST
	///How wide this door is, measured in tiles.
	var/width = 1

/obj/structure/simple_door/Initialize(mapload)
	. = ..()
	icon_state = door_type
	SetBounds()
	if(mapload)
		if(prob(50))
			INVOKE_ASYNC(src, PROC_REF(Open), TRUE)

/obj/structure/simple_door/Destroy()
	if(padlock)
		padlock.forceMove(get_turf(src))
		padlock = null
	if(deadbolt)
		deadbolt.forceMove(get_turf(src))
		deadbolt = null
	//fortuna edit
	investigate_log("Door '[src]' destroyed at [AREACOORD(src)]. Last fingerprints: [src.fingerprintslast]", INVESTIGATE_DESTROYED)
	//message_admins("Door '[ADMIN_JMP(src)]' destroyed at [AREACOORD(src)]. Last fingerprints(If any): [src.fingerprintslast]")
	log_game("Door '[src]' destroyed at [AREACOORD(src)]. Last fingerprints: [src.fingerprintslast]")
	return ..()

/obj/structure/simple_door/examine(mob/user)
	. = ..()
	if(padlock)
		. += span_notice("Ctrl-Click [src] to try and lock/unlock the padlock.")
	if(deadbolt)
		. += span_notice("Alt-Click [src] from \the [dir2text(deadbolt.dir)] to use the bolt lock.")

/obj/structure/simple_door/AltClick(mob/user)
	. = ..()
	if(isliving(user) && istype(deadbolt))
		var/mob/living/L = user
		if(L.Adjacent(src) && L?.mobility_flags & MOBILITY_USE)
			if(get_dir(src,user) != deadbolt.dir)
				to_chat(user, span_warning("[deadbolt] can only be reached from \the [dir2text(deadbolt.dir)]!"))
			else
				deadbolt.ToggleLock(user)
				do_squish(0.9,0.9,0.25 SECONDS)
				playsound(get_turf(src), "sound/f13items/flashlight_off.ogg", 50, FALSE, 0)

/obj/structure/simple_door/CtrlClick(mob/user)
	. = ..()
	if(isliving(user) && istype(padlock))
		var/mob/living/L = user
		if(L?.mobility_flags & MOBILITY_USE && L.Adjacent(src))
			var/obj/item/key/K
			var/foundit
			for(var/maybekey in L) //Search two layers deep for a matching key
				if(istype(maybekey, /obj/item/key))
					K = maybekey
				else for(var/maybekey2 in maybekey)
					if(istype(maybekey2, /obj/item/key))
						K = maybekey2
				if(K?.lock_data == padlock?.lock_data)
					attackby(K, L)
					foundit = TRUE
					break
			if(!foundit) //We can't find it :(
				to_chat(L, span_warning("You can't find the right key for \the [src]. Maybe it's too deeply packed away or you lost it?"))

/obj/structure/simple_door/proc/SetBounds()
	if(width>1)
		if(dir in list(EAST, WEST))
			bound_width = width * world.icon_size
			bound_height = world.icon_size
		else
			bound_width = world.icon_size
			bound_height = width * world.icon_size
		apply_opacity_to_my_turfs(opacity)

/obj/structure/simple_door/proc/apply_opacity_to_my_turfs(new_opacity)
	for(var/turf/T in locs)
		T.set_opacity(new_opacity)

/obj/structure/simple_door/set_opacity(new_opacity)
	. = ..()
	apply_opacity_to_my_turfs(new_opacity)

/obj/structure/simple_door/proc/HasLock()
	if(padlock || deadbolt)
		return TRUE
	return FALSE

//Padlocks
/obj/structure/simple_door/proc/attach_padlock(obj/item/lock_construct/P, force = FALSE, mob/user)
	if(!force && (!can_have_lock || !P ))
		return FALSE
	if(padlock)
		to_chat(user, "[src] already has \a [padlock] attached")
		return FALSE
	if(user.transferItemToLoc(P, src))
		user.visible_message(span_notice("[user] adds [P] to [src]."),span_notice("You add [P] to [src]."))
		padlock = P
		desc = "[src.desc] Has a lock."
		if(density)
			add_overlay("[initial(icon_state)]_padlock")
		return TRUE

/obj/structure/simple_door/proc/remove_padlock(force = FALSE)
	if(!force && (!padlock))
		return FALSE
	padlock.forceMove(get_turf(src))
	padlock = null
	cut_overlay("[initial(icon_state)]_padlock")

//Deadbolts
/obj/structure/simple_door/proc/attach_deadbolt(obj/item/lock_bolt/L, force = FALSE, mob/user, mapload)
	if(!force && (!can_have_lock || !L ))
		return FALSE
	if(deadbolt)
		to_chat(user, "[src] already has \a [deadbolt] attached")
		return FALSE
	if(padlock?.locked)
		to_chat(user, span_warning("Unlock \the [padlock] before installing a bolt lock."))//Prevents grief, mostly.
		return FALSE
	if(mapload)
		L.forceMove(src)
		deadbolt = L
		if(density)
			add_overlay(deadbolt_overlay)
	else if(user.transferItemToLoc(L, src))
		L.dir = get_dir(src,user)
		user.visible_message(span_notice("[user] adds [L] to [src]."),span_notice("You add [L] to [src]. It can only be manipulated from \the [dir2text(L.dir)]"))
		deadbolt = L
		if(density)
			add_overlay(deadbolt_overlay)
/// Moves the deadbolt to the turf of the door, sets the door's deadbolt to null, and cuts the deadbolt overlay/
/obj/structure/simple_door/proc/remove_deadbolt(force = FALSE)
	if(!force && (!deadbolt))
		return FALSE
	deadbolt.forceMove(get_turf(src))
	deadbolt = null
	cut_overlay(deadbolt_overlay)

//Very useful proc we have here, excellent work on that one
/obj/structure/simple_door/bullet_act(obj/item/projectile/Proj)
	..()

/obj/structure/simple_door/Bumped(atom/user)
	..()
	if(density)
		if(hard_open)
			return TryToSwitchState(user, 0)
		else
			return TryToSwitchState(user, 1)
	return

/obj/structure/simple_door/proc/Open(animate)
	playsound(src.loc, open_sound, 30, 0, 0)
	if(padlock)
		cut_overlay("[initial(icon_state)]_padlock")
	if(deadbolt)
		cut_overlay(deadbolt_overlay)
	if(animate)
		moving = 1
		flick("[door_type]opening", src)
		sleep(opening_time)
		moving = 0
	set_opacity(0)
	density = 0
	icon_state = "[door_type]open"
	layer = OPEN_DOOR_LAYER

/obj/structure/simple_door/proc/Close(animate)
	playsound(src.loc, close_sound, 30, 0, 0)
	manual_opened = 0
	if(animate)
		moving = 1
		flick("[door_type]closing", src)
		sleep(closing_time)
	icon_state = door_type
	set_opacity(base_opacity)
	if(padlock)
		add_overlay("[initial(icon_state)]_padlock")
	if(deadbolt)
		add_overlay(deadbolt_overlay)
	density = 1
	moving = 0
	layer = CLOSED_DOOR_LAYER

/* can crowbar off a lock, to force a door open. This is overriden in airlock so shouldnt be an issue */
/obj/structure/simple_door/proc/try_to_crowbar(obj/item/I, mob/user)
	if(padlock) /* attempt to pry the lock off */
		if(padlock.pry_off(user,src))
			remove_padlock()
			padlock = null
			src.desc = "[initial(desc)]"
			cut_overlay("[initial(icon_state)]_padlock")
	else if(deadbolt)
		if(deadbolt.pry_off(user,src))
			if(deadbolt.mapped)
				message_admins("Mapped in deadbolt [ADMIN_JMP(deadbolt)] removed at [AREACOORD(src)] by [user.real_name][ADMIN_PP(user)].")
			remove_deadbolt()
			deadbolt = null
			cut_overlay(deadbolt_overlay)
	return

/obj/structure/simple_door/proc/SwitchState(animate)
	if(density)
		var/padlocked = padlock?.locked
		var/boltlocked = deadbolt?.locked
		if(!padlocked && !boltlocked)
			Open(animate)
		else //One of the lock types on this door is locked
			playsound(src.loc, pick('sound/f13items/door_knock1.wav', 'sound/f13items/door_knock2.wav', 'sound/f13items/door_knock3.wav', 'sound/f13items/door_knock4.wav'), 80, 0, 0)
	else
		var/turf/T = get_turf(src)
		for(var/mob/living/L in T)
			return
		Close(animate)
	return 1

/obj/structure/simple_door/attackby(obj/item/weapon/I, mob/living/user, params)
	if(user.a_intent != INTENT_HARM && (istype(I, /obj/item/crowbar) || istype(I, /obj/item/twohanded/fireaxe)))
		try_to_crowbar(I, user)
		return TRUE
	if(!istype(I, /obj/item/stack/sheet/mineral/wood))
		for(var/obj/structure/barricade/wooden/planks/P in loc)
			P.attackby(I, user, params)
			return TRUE
	if(istype(I, /obj/item/screwdriver))
		if(HasLock())
			to_chat(user, span_warning("Remove all locks before door dissasembling."))
			return 1
		else
			if(can_disasemble && do_after(user, 60, target = src))
				for(var/i = 1, i <= material_count, i++)
					new material_type(get_turf(src))
				to_chat(user,span_notice("You disassemble [name]."))
				playsound(loc, 'sound/items/Screwdriver.ogg', 25, -3)
				qdel(src)
				return 1
	if(istype(I, /obj/item/lock_construct) && can_have_lock)
		if(attach_padlock(I,FALSE,user))
			return TRUE//Don't open the door when we add a padlock
		else return FALSE//Don't knock on the door if we fail to put the lock on.
	if(istype(I, /obj/item/lock_bolt) && can_have_lock)
		if(attach_deadbolt(I,FALSE,user,FALSE))
			return TRUE//Don't open the door when we add a padlock
		else return FALSE//Don't knock on the door if we fail to put the lock on.
	if(istype(I, /obj/item/key))
		if(!padlock)
			to_chat(user, "[src] has no lock attached")
			return
		else
			return padlock.check_key(I,user,src)
	if(user.a_intent == INTENT_HARM)
		return ..()
	attack_hand(user)



/obj/structure/simple_door/proc/TryToSwitchState(atom/user, animate)
	if(moving)
		return 0
	if(isliving(user))
		var/mob/living/M = user
		if(/obj/structure/barricade in src.loc)
			M << "It won't budge!"
			return 0
		if(M.client)
			if(iscarbon(M))
				var/mob/living/carbon/C = M
				if(!C.handcuffed)
					SwitchState(animate)
					return 1
			else
				SwitchState(animate)
				return 1
	else if(istype(user, /obj/mecha))
		SwitchState(animate)
		return 1
	return 0

/obj/structure/simple_door/attack_hand(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
//	user.changeNext_move(CLICK_CD_MELEE)
	..()


/obj/structure/simple_door/attack_tk(mob/user)
	if(TryToSwitchState(user, 1) && !density)
		manual_opened = 1
//	user.changeNext_move(CLICK_CD_MELEE)
	..()

/obj/structure/simple_door/CanAllowThrough(atom/movable/mover, border_dir, height=0)
	..()
	if(mover.loc == loc)
		return 1
	return !density

/obj/structure/simple_door/CheckExit(atom/movable/O as mob|obj, target)
	if(!density && !manual_opened && ishuman(O))
		var/mob/living/carbon/human/H = O
		if(H.client && H.stat != 2)
			if(hard_open)
				spawn(H.movement_delay())TryToSwitchState(H) //AutoClosing
			else
				spawn(H.movement_delay())TryToSwitchState(H,1)
	if(O.loc == loc)
		return 1
	return !density

// Fallout 13 general doors directory

// -------------------------------------------------
//	WOODEN DOORS

// weathered white door
/obj/structure/simple_door/house
	icon_state = "house"
	door_type = "house"
	can_disasemble = TRUE
	can_have_lock = TRUE

/obj/structure/simple_door/house/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

// cleaned and repainted white
/obj/structure/simple_door/house/clean
	icon_state = "houseclean"
	door_type = "houseclean"

// Rough outer door
/obj/structure/simple_door/wood
	icon_state = "wood"
	door_type = "wood"
	can_disasemble = TRUE
	can_have_lock = TRUE

/obj/structure/simple_door/wood/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

/obj/structure/simple_door/interior
	icon_state = "interior"
	door_type = "interior"
	can_disasemble = 1
	can_have_lock = TRUE

/obj/structure/simple_door/interior/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

//Example wide doors with terrible sprites but you get the idea
/obj/structure/simple_door/twowide_example
	icon = 'icons/fallout/structures/doors_2wide.dmi'
	name = "wide example door"
	desc = "Is that just two doors glued together? How come when you open one, the other opens?"
	icon_state = "interior"
	door_type = "interior"
	can_disasemble = 1
	can_have_lock = TRUE
	width = 2

/obj/structure/simple_door/threewide_example
	icon = 'icons/fallout/structures/doors_3wide.dmi'
	name = "wider example door"
	desc = "God has abandoned us."
	icon_state = "interior"
	door_type = "interior"
	can_disasemble = 1
	can_have_lock = TRUE
	width = 3

/obj/structure/simple_door/room
	icon_state = "room"
	door_type = "room"
	can_disasemble = TRUE
	can_have_lock = TRUE

/obj/structure/simple_door/room/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

/obj/structure/simple_door/room/dirty
	icon_state = "room_d"
	door_type = "room_d"

// Raider style door
/obj/structure/simple_door/repaired
	name = "old damaged door"
	desc = "Battered and hastily repaired."
	icon_state = "room_repaired"
	door_type = "room_repaired"
	can_have_lock = TRUE

/obj/structure/simple_door/repaired/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

// ---------------------------------------------
//	TENT FLAPS

/obj/structure/simple_door/tentflap_leather
	name = "brahminskin tent entrance"
	icon_state = "tentflap_leather"
	door_type = "tentflap_leather"
	base_opacity = TRUE
	can_disasemble = FALSE
	can_have_lock = FALSE
	open_sound = 'sound/effects/footstep/hardbarefoot4.ogg'
	close_sound = 'sound/effects/footstep/hardbarefoot5.ogg'

/obj/structure/simple_door/tentflap_cloth
	name = "cotton tent entrance"
	icon_state = "tentflap_cloth"
	door_type = "tentflap_cloth"
	base_opacity = TRUE
	can_disasemble = FALSE
	can_have_lock = FALSE
	open_sound = 'sound/effects/footstep/hardbarefoot4.ogg'
	close_sound = 'sound/effects//footstep/hardbarefoot5.ogg'

// Old square style tent door
/obj/structure/simple_door/tent
	name = "tent flap"
	desc = "A fairly simple looking entrance to a war tent."
	icon_state = "tent"
	door_type = "tent"
	material_type = /obj/item/stack/sheet/cloth
	open_sound = "sound/effects/curtain.ogg"
	close_sound = "sound/effects/curtain.ogg"
	can_have_lock = TRUE


// --------------------------------------------------------------
//	METAL DOORS

/obj/structure/simple_door/metal
	name = "metal door"
	icon_state = "metal"
	door_type = "metal"
	material_type = /obj/item/stack/sheet/metal
	open_sound = "sound/f13machines/doorstore_open.ogg"
	close_sound = "sound/f13machines/doorstore_close.ogg"
	explosion_block = 1.5
	material_count = 5
	can_have_lock = TRUE

/obj/structure/simple_door/metal/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -15, 8, 1)

/obj/structure/simple_door/metal/iron
	name = "iron door"
	desc = "A heavy iron door."
	icon_state = "iron"
	door_type = "iron"
	explosion_block = 5
	can_have_lock = TRUE
	opening_time = 12
	closing_time = 8

/obj/structure/simple_door/metal/barred
	name = "barred door"
	desc = "Bars. No matter which side we're on, aren't we always behind them?"
	icon_state = "barred"
	door_type = "barred"
	open_sound = "sound/f13machines/doorchainlink_open.ogg"
	close_sound = "sound/f13machines/doorchainlink_close.ogg"
	opacity = FALSE
	base_opacity = FALSE
	can_have_lock = TRUE
	proj_pass_rate = 95
	pass_flags = LETPASSTHROW

/obj/structure/simple_door/dirtyglass
	desc = "The glass is dirty, you can't see a thing behind it."
	icon_state = "dirtyglass"
	door_type = "dirtyglass"
	can_have_lock = TRUE

/obj/structure/simple_door/dirtyglass/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_GLASS, -10, 5)

/obj/structure/simple_door/brokenglass
	name = "shattered glass door"
	desc = "It still opens and closes."
	icon_state = "brokenglass"
	door_type = "brokenglass"
	opacity = FALSE
	base_opacity = FALSE
	can_have_lock = TRUE

/obj/structure/simple_door/brokenglass/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_WOOD, -10, 5)

/obj/structure/simple_door/glass
	desc = "The glass is quite clean, someone took care of this door."
	icon_state = "glass"
	door_type = "glass"
	opacity = FALSE
	base_opacity = FALSE
	can_have_lock = TRUE

/obj/structure/simple_door/glass/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_GLASS, -10, 5)

/obj/structure/simple_door/metal/dirtystore
	desc = "A metal door with dirty glass, you can't see a thing behind it."
	icon_state = "dirtystore"
	door_type = "dirtystore"
	can_have_lock = TRUE

/obj/structure/simple_door/metal/dirtystore/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_GLASS, -10, 5)

/obj/structure/simple_door/metal/store
	icon_state = "store"
	door_type = "store"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = TRUE

/obj/structure/simple_door/wood/alt/window
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "housedoor"
	door_type = "housedoor"
	opacity = TRUE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = TRUE

/obj/structure/simple_door/wood/alt
	icon = 'icons/fallout/structures/doors.dmi'
	icon_state = "private"
	door_type = "private"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = TRUE

// --------------------------------------
//	BUNKER DOORS

/obj/structure/simple_door/metal/ventilation
	name = "ventilation system"
	desc = "As you take a closer look, you notice a handle at the bottom of ventilation system access hatch."
	icon_state = "ventilation"
	door_type = "ventilation"
	open_sound = "sound/f13machines/doorhidden_open.ogg"
	close_sound = "sound/f13machines/doorhidden_close.ogg"
	opening_time = 25
	closing_time = 20

/obj/structure/simple_door/metal/vault
	name = "vault wall"
	desc = "A sturdy and cold metal wall."
	icon = 'icons/fallout/turfs/walls/vault.dmi'
	icon_state = "vaultfwall"
	door_type = "vaultfwall"
	open_sound = "sound/f13items/flashlight_on.ogg"
	close_sound = "sound/f13items/flashlight_off.ogg"

/obj/structure/simple_door/metal/vaultreinforced
	name = "vault reinforced wall"
	desc = "A wall built to withstand an atomic explosion."
	icon = 'icons/fallout/turfs/walls/vault_reinforced.dmi'
	icon_state = "vaultfrwall"
	door_type = "vaultfrwall"
	open_sound = "sound/f13items/flashlight_on.ogg"
	close_sound = "sound/f13items/flashlight_off.ogg"

/obj/structure/simple_door/blast
	name = "blast door"
	desc = "A blast door, alternatively referred to as a shielded door or safety door, is a type of door designed to be especially reliable and durable."
	icon_state = "blastdoor"
	door_type = "blastdoor"
	material_type = /obj/item/stack/sheet/plasteel
	open_sound = "sound/f13machines/doorblast_open.ogg"
	close_sound = "sound/f13machines/doorblast_close.ogg"
	explosion_block = 10
	opening_time = 30
	closing_time = 20

/obj/structure/simple_door/blast/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -15, 8, 1)

/obj/structure/simple_door/bunker
	name = "airlock"
	desc = "An olive green painted airlock.<br>The door mechanism itself is a complex mix of an electic engine and hydraulic motion.<br>This particular door looks like a Pre-Fall military tech."
	icon_state = "bunker"
	door_type = "bunker"
	material_type = /obj/item/stack/sheet/metal
	open_sound = "sound/f13machines/doorairlock_open.ogg"
	close_sound = "sound/f13machines/doorairlock_close.ogg"
	explosion_block = 5

/obj/structure/simple_door/bunker/add_debris_element()
	AddElement(/datum/element/debris, DEBRIS_SPARKS, -15, 8, 1)

/obj/structure/simple_door/bunker/glass
	desc = "A olive green painted armored door with semi-transparent glass window.<br>The door mechanism itself is a complex mix of an elecrtic engine and hydraulic motion.<br>This particular door looks like a Pre-Fall military tech."
	icon_state = "bunkerglass"
	door_type = "bunkerglass"
	explosion_block = 4 //A glass window in it, reduces the resistance, am I right?
	opacity = FALSE
	base_opacity = FALSE

//Doors from Civ13

/obj/structure/simple_door/civ
	icon_state = "base"
	door_type = "base"
	icon = 'modular_coyote/icons/turfs/material_doors.dmi'
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = TRUE

/obj/structure/simple_door/civ/gate
	name = "gate"
	icon_state = "gate"
	door_type = "gate"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/sandgate
	name = "sandstone gate"
	icon_state = "sgate"
	door_type = "sgate"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/saloon
	name = "Saloon"
	icon_state = "saloon"
	door_type = "saloon"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/storedoor
	name = "Store Door"
	icon_state = "storedoor"
	door_type = "storedoor"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/shoji
	name = "shoji"
	icon_state = "shoji"
	door_type = "shoji"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/cell
	name = "cell"
	icon_state = "cell"
	door_type = "cell"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE

/obj/structure/simple_door/civ/cellwooden
	name = "wooden cell"
	icon_state = "woodcell"
	door_type = "woodcell"
	opacity = FALSE
	base_opacity = FALSE
	can_disasemble = 1
	can_have_lock = FALSE
