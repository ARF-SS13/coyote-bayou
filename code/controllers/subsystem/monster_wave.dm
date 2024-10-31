#define KILL_INVALID_SPAWN 3
SUBSYSTEM_DEF(monster_wave)
	name = "Monster Wave"
	wait = 2 SECONDS //change to either 30 MINUTES or 1 HOURS
	var/allow_spawner_lads = TRUE
	/// big list of all the spawners that have been destroyed
	var/list/spawner_tickets = list() // list(/datum/nest_box)
	/// big list of all the spawner lads in existence
	var/list/spawner_lads = list() // list(/mob/living/simple_animal/nest_spawn_hole_guy)
	/// big list of what we actually spawned, for an occasional admin report
	/// How long it takes from when the spawner dies to when it starts the respawn process
	var/nest_respawndelay = 1 HOURS
	/// How long it takes from when the spawnermob thing spawns to when it turns into a nest
	var/spawn_delay = 1 // 15 MINUTES
	/// how long after being blocked will we hold off on trying to spawn stuff there?
	var/spawn_block_delay = 1 HOURS
	/// coords of spawn blocker devices per Z level
	var/list/spawn_blockers = list() // list(/obj/structure/respawner_blocker)
	var/num_spawned = 0
	var/highest_gen = 0
	var/insta_boy = TRUE
	var/ignore_blockers = FALSE

//So admins, you want to be a tough guy, like it really rough guy?
//just know you can't modify the time in between each fire
//but you can allow it to always fire, by changing chance_of_fire to 0
//and changing allowed_firings to like.... 12?
//     ^This guy was a coward. ~TK

/datum/controller/subsystem/monster_wave/Initialize(start_timeofday)
	. = ..()
	if(!allow_spawner_lads)
		to_chat(world, span_boldannounce("Nest Portals Disabled :c"))

/datum/controller/subsystem/monster_wave/stat_entry(msg)
	msg = "T:[num_spawned],G:[highest_gen],S:[LAZYLEN(spawner_tickets)],M:[LAZYLEN(spawner_lads)],B:[LAZYLEN(spawn_blockers)],C:[round(cost,0.005)]"
	return msg


/datum/controller/subsystem/monster_wave/fire(resumed = 0)
	ticket2mob()
	mob2hole()

/datum/controller/subsystem/monster_wave/proc/ticket2mob()
	if(!allow_spawner_lads)
		return
	var/tries = 50
	mainloop:
		while(tries-- > 0)
			if(!LAZYLEN(spawner_tickets))
				return
			var/datum/nest_box/NB = pick(spawner_tickets)
			if(!istype(NB) || QDELETED(NB))
				continue
			if(NB.time_i_died + NB.delayed_by + nest_respawndelay > world.time)
				continue
			var/turf/there = coords2turf(NB.coords)
			if(!there)
				killnest(NB)
				continue
			if(!ignore_blockers && is_spawn_blocked(there))
				NB.delayed_by += spawn_block_delay
				continue
			var/can_put = can_place_riftnest(there)
			if(can_put == KILL_INVALID_SPAWN)
				killnest(NB)
				continue
			else if(!can_put)
				for(var/turf/somewhere in spiral_range(dist=3, center=there, orange=1))
					can_put = can_place_riftnest(somewhere)
					if(can_put == KILL_INVALID_SPAWN)
						killnest(NB)
						continue mainloop
					else if(can_put)
						there = somewhere
						break
			if(can_put == KILL_INVALID_SPAWN)
				killnest(NB)
				continue
			else if(!can_put)
				continue
			NB.mutate() // >:3c
			var/mob/living/simple_animal/nest_spawn_hole_guy/NSHG = new(there)
			NSHG.set_up(NB)
			killnest(NB)
			return TRUE

/datum/controller/subsystem/monster_wave/proc/killnest(datum/nest_box/NB)
	if(!istype(NB) || QDELETED(NB))
		return
	NB.time_i_died = world.time
	NB.delayed_by = 0
	if(insta_boy)
		return // no kill the insta boy
	SSmonster_wave.unregister_nest_seed(NB)
	qdel(NB)

/datum/controller/subsystem/monster_wave/proc/mob2hole()
	if(!allow_spawner_lads)
		return
	var/tries = 50
	while(tries-- > 0)
		var/whichnum = rand(1, LAZYLEN(spawner_lads))
		var/mob/living/simple_animal/nest_spawn_hole_guy/NSHG = LAZYACCESS(spawner_lads, whichnum)
		if(!istype(NSHG) || QDELETED(NSHG))
			continue
		if(NSHG.deploy_if_ready())
			return TRUE

/datum/controller/subsystem/monster_wave/proc/spawned_a_nest()
	num_spawned++

/datum/controller/subsystem/monster_wave/proc/catalogue_me(datum/nest_box/NB)
	if(NB.generation > highest_gen)
		highest_gen = NB.generation

/datum/controller/subsystem/monster_wave/proc/is_spawn_blocked(turf/here)
	if(!here)
		return TRUE
	for(var/client/C in GLOB.clients)
		var/mob/d = C.mob
		if(!isliving(d))
			continue
		if(d.z != here.z)
			continue
		if(get_dist(d, here) <= 9)
			return TRUE
	for(var/obj/structure/respawner_blocker/RB in spawn_blockers)
		if(here.z != RB.z)
			continue
		var/maxdist = RB.protection_radius
		if(maxdist < 0)
			continue
		if(get_dist(RB, here) <= maxdist)
			RB.blocked_something()
			return TRUE

/datum/controller/subsystem/monster_wave/proc/can_place_riftnest(turf/here)
	if(!here)
		return FALSE
	if(locate(/obj/structure/nest) in here)
		return KILL_INVALID_SPAWN
	if(locate(/mob/living/simple_animal/nest_spawn_hole_guy) in here)
		return FALSE
	if(here.density)
		return FALSE
	for(var/atom/movable/thing in here)
		if(thing.density)
			return FALSE
	return TRUE

/datum/controller/subsystem/monster_wave/proc/get_spawn_delay()
	if(insta_boy)
		return 1 // nowish
	return spawn_delay + world.time

/datum/controller/subsystem/monster_wave/proc/register_nest_seed(datum/nest_box/NB)
	spawner_tickets |= NB

/datum/controller/subsystem/monster_wave/proc/unregister_nest_seed(datum/nest_box/NB)
	spawner_tickets -= NB

/datum/controller/subsystem/monster_wave/proc/register_hole(mob/living/simple_animal/nest_spawn_hole_guy/NSHG)
	spawner_lads |= NSHG

/datum/controller/subsystem/monster_wave/proc/unregister_hole(mob/living/simple_animal/nest_spawn_hole_guy/NSHG)
	spawner_lads -= NSHG


/// who lives in a ditch on the side of the road?
/mob/living/simple_animal/nest_spawn_hole_guy
	name = "rift"
	desc = "Huh, the ground here is glowing! That can't be good! Better smash it to be sure!"
	icon = 'icons/effects/effects.dmi'
	icon_state = "dragnetfield"
	mob_armor = ARMOR_VALUE_RIFT
	maxHealth = 50
	health = 50
	move_resist = MOVE_FORCE_OVERPOWERING
	density = FALSE
	a_intent = INTENT_HARM
	del_on_death = TRUE
	wander = FALSE
	AIStatus = AI_OFF
	var/datum/nest_box/nest_seed
	var/spawn_after = 0
	light_system = STATIC_LIGHT
	light_range = 11
	light_power = 0.7
	light_color = "#6eaaff"
	light_on = TRUE
	shoot_me = TRUE
	var/shhh_im_dead

/mob/living/simple_animal/nest_spawn_hole_guy/Initialize(datum/nest_box/NB)
	if(NB)
		set_up(NB)
	if(SSmonster_wave.insta_boy)
		invisibility = INVISIBILITY_ABSTRACT
		light_on = FALSE
	. = ..()

/mob/living/simple_animal/nest_spawn_hole_guy/Destroy()
	if(nest_seed)
		nest_seed.assigned_to = null
		QDEL_NULL(nest_seed)
	SSmonster_wave.unregister_hole(src)
	. = ..()

// /mob/living/simple_animal/nest_spawn_hole_guy/examine_more(mob/user)
// 	. = list(span_notice("In the rift, you notice <i>stuff</i>. "))


/mob/living/simple_animal/nest_spawn_hole_guy/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_HOSTILE_CHECK_FACTION,PROC_REF(no_attack_pls), TRUE)
	RegisterSignal(src, COMSIG_MOB_APPLY_DAMAGE,PROC_REF(im_hit), TRUE)

/mob/living/simple_animal/nest_spawn_hole_guy/update_overlays()
	. = ..()
	cut_overlays()
	var/mutable_appearance/overlay1 = mutable_appearance('icons/effects/effects.dmi', "quantum_sparks")
	. += overlay1

/mob/living/simple_animal/nest_spawn_hole_guy/proc/no_attack_pls()
	return TRUE

/mob/living/simple_animal/nest_spawn_hole_guy/proc/set_up(datum/nest_box/NB)
	if(shhh_im_dead)
		return
	if(!istype(NB))
		return
	nest_seed = NB
	nest_seed.assigned_to = WEAKREF(src)
	SSmonster_wave.register_hole(src)
	SSmonster_wave.unregister_nest_seed(NB) // we have it now
	spawn_after = SSmonster_wave.get_spawn_delay()
	return TRUE

/mob/living/simple_animal/nest_spawn_hole_guy/proc/deploy_if_ready(do_it_now)
	if(!nest_seed)
		return
	if(!COOLDOWN_FINISHED(src, spawn_after) && !do_it_now)
		return
	if(SSmonster_wave.is_spawn_blocked(src))
		return
	if(locate(/obj/structure/nest) in get_turf(src))
		return
	. = TRUE
	/// time to make the nest!
	var/datum/nest_box/NB = nest_seed
	NB.pop_nest(atom2coords(src)) // this kills the datum
	for(var/mob/spectator in hearers(7, src))
		if(!spectator.client)
			continue
		playsound(src, 'sound/effects/portalboy_deploy.ogg', 100, TRUE)
		do_sparks(3, FALSE, src, /datum/effect_system/spark_spread/quantum)
		break
	SSmonster_wave.unregister_hole(src)
	SSmonster_wave.spawned_a_nest()
	qdel(src)

/mob/living/simple_animal/nest_spawn_hole_guy/BiologicalLife(seconds, times_fired)
	if(shhh_im_dead)
		return
	for(var/obj/structure/respawner_blocker/RB in SSmonster_wave.spawn_blockers)
		if(RB.z != z)
			continue
		if(get_dist(src, RB) <= RB.protection_radius)
			if(!RB.killmeplease(src)) // kill me, daddy
				continue
			return

/mob/living/simple_animal/nest_spawn_hole_guy/proc/unbirth()
	shhh_im_dead = null
	if(!nest_seed)
		death()
		return
	SSmonster_wave.register_nest_seed(nest_seed)
	nest_seed = null
	do_sparks(5, TRUE, src, /datum/effect_system/spark_spread/quantum)
	death()
	return TRUE

/mob/living/simple_animal/nest_spawn_hole_guy/proc/im_hit()
	playsound(src, 'sound/effects/portalboy_hit.ogg', 100, TRUE)
	do_sparks(1, FALSE, src, /datum/effect_system/spark_spread/quantum)

/mob/living/simple_animal/nest_spawn_hole_guy/death()
	playsound(src, 'sound/effects/portalboy_death.ogg', 100, TRUE)
	QDEL_NULL(nest_seed)
	SSmonster_wave.unregister_hole(src)
	. = ..()

/obj/structure/respawner_blocker
	name = "anti-transcendental field generator"
	desc = "A simple yet effective device that prevents those pesky rifts from forming. And also keeps raiders from tunneling in. And also keeps the janitor from cleaning up the mess. And also keeps the bartender from serving drinks. And also keeps the clown from slipping on a banana peel. And also keeps the AI from-- you get the idea. It'll also emit a concentrated Yancy-Turtledove anti-displacement beam at any rifts that happen to already be there, blasting them into next week (or at least later today)."
	icon = 'icons/obj/machines/dominator.dmi'
	icon_state = "dominator"
	density = TRUE
	anchored = TRUE
	var/protection_radius = 10
	var/obj/item/my_component
	var/show_range_cooldown = 0
	var/mob/living/simple_animal/nest_spawn_hole_guy/killing_something
	var/datum/beam/my_bean

/obj/structure/respawner_blocker/Initialize()
	. = ..()
	SSmonster_wave.spawn_blockers |= src
	playsound(src, 'sound/machines/respawn_blocker_activate.ogg', 75, TRUE)
	say("Anti-Transcendental Repopulation Field initialized. Safety guaranteed within [protection_radius] meters.")

/obj/structure/respawner_blocker/Destroy()
	SSmonster_wave.spawn_blockers -= src
	if(killing_something)
		killing_something.shhh_im_dead = null
		killing_something = null
	playsound(src, 'sound/machines/respawn_blocker_deactivate.ogg', 75, TRUE)
	if(my_component)
		my_component.forceMove(get_turf(src))
	. = ..()

/obj/structure/respawner_blocker/proc/blocked_something()
	playsound(src, 'sound/machines/respawn_blocker_blocked.ogg', 75, TRUE)
	do_sparks(1, FALSE, src, /datum/effect_system/spark_spread/quantum)

/// we're bout to ruin this guy's day
/obj/structure/respawner_blocker/proc/killmeplease(mob/living/simple_animal/nest_spawn_hole_guy/NSHG)
	if(killing_something) // we're already killing something
		return
	killing_something = NSHG
	NSHG.shhh_im_dead = src // omae wa mou shindeiru
	addtimer(CALLBACK(src, PROC_REF(kill_it)), 3 SECONDS)
	my_bean = Beam(get_turf(NSHG), "sm_arc_dbz_referance")
	my_bean.Start()
	playsound(src, 'sound/machines/shoot_respawn_killer.ogg', 100, FALSE)
	playsound(NSHG, 'sound/machines/shoot_respawn_killer.ogg', 100, FALSE)
	return TRUE

/obj/structure/respawner_blocker/proc/kill_it()
	if(!killing_something)
		return
	my_bean.End()
	my_bean = null
	killing_something.shhh_im_dead = null
	killing_something.unbirth()
	killing_something = null

/obj/structure/respawner_blocker/AltClick(mob/user)
	. = ..()
	if(!user || !istype(user) || !user.client)
		return
	to_chat(user, "You start to take down the field generator...")
	if(!do_after(user, 3 SECONDS, FALSE, src, TRUE, public_progbar = TRUE))
		to_chat(user, "But you're interrupted!")
		return
	to_chat(user, "You've taken down the field generator!")
	qdel(src)

/obj/structure/respawner_blocker/attack_hand(mob/user, act_intent, attackchain_flags)
	. = ..()
	say("[protection_radius] meter radius. [protection_radius*2+1]x[protection_radius*2+1] area. [protection_radius*2+1]^2 square meters. Protecting against transdimensional incursions, no rifts can or will exist in this area.")
	if(!COOLDOWN_FINISHED(src, show_range_cooldown))
		return
	COOLDOWN_START(src, show_range_cooldown, 10 SECONDS)
	var/list/turfs2spawn = block(x-protection_radius, y-protection_radius, z, x+protection_radius, y+protection_radius, z)
	turfs2spawn -= block(x-protection_radius+1, y-protection_radius+1, z, x+protection_radius-1, y+protection_radius-1, z)
	var/north_y = y+protection_radius
	var/south_y = y-protection_radius
	var/west_x = x-protection_radius
	var/east_x = x+protection_radius

	for(var/turf/T in turfs2spawn)
		// is it an end piece?
		var/obj/effect/temp_visual/outline/I = new(T)
		/// left end?
		if(T.x == west_x)
			/// top left?
			if(T.y == north_y)
				I.dir = NORTHWEST
			/// bottom left?
			else if(T.y == south_y)
				I.dir = SOUTHWEST
			/// middlebit
			else
				I.dir = WEST
		/// right end?
		else if(T.x == east_x)
			/// top right?
			if(T.y == north_y)
				I.dir = NORTHEAST
			/// bottom right?
			else if(T.y == south_y)
				I.dir = SOUTHEAST
			/// middlebit
			else
				I.dir = EAST
		/// top middle?
		else if(T.y == north_y)
			I.dir = NORTH
		/// bottom middle?
		else if(T.y == south_y)
			I.dir = SOUTH
		else
			stack_trace("ERROR: Box drawing failed! Unknown direction x: [T.x], y: [T.y]")
	return TRUE

/obj/effect/temp_visual/outline
	name = "Field Generator Perimeter"
	desc = "Wow! Nests that try to spawn in here will be blocked! Neat!"
	icon_state = "shieldwall_but_better"
	icon = 'icons/effects/effects.dmi'
	duration = 10 SECONDS
	var/sounding = TRUE

/obj/effect/temp_visual/outline/Initialize(mapload)
	. = ..()
	animate(
		src,
		time=duration,
		alpha=0,
	)

/obj/structure/respawner_blocker/alt_attack_hand(mob/user)
	. = ..()
	to_chat(user, "You start to take down the field generator...")
	if(!do_after(user, 3 SECONDS))
		to_chat(user, "But you're interrupted!")
		return
	to_chat(user, "You've taken down the field generator!")
	qdel(src)

/obj/item/packaged_respawner_blocker
	name = "normalizer"
	desc = "A simple yet effective device that disrupts whatever keeps sending in holes filled with monsters. Fits in any bag fairly well despite seeming large.  Use it to create a field 10 tiles across where nests will not respawn. Can also be purchased from the workshop!"
	icon = 'icons/obj/machines/dominator.dmi'
	icon_state = "dominator-closed"
	w_class = WEIGHT_CLASS_TINY
	var/range = 5

/obj/item/packaged_respawner_blocker/attack_self(mob/user)
	. = ..()
	deploy(user)

/obj/item/packaged_respawner_blocker/proc/deploy(mob/user)
	var/turf/here = get_turf(src)
	if(!here)
		return
	to_chat(user, "You start to deploy the field generator...")
	if(!do_after(user, 3 SECONDS, FALSE, src, TRUE, public_progbar = TRUE))
		to_chat(user, "You start to deploy the field generator, but you're interrupted!")
		return
	to_chat(user, "You've deployed the field generator!")
	var/obj/structure/respawner_blocker/RB = new(here)
	RB.my_component = src
	forceMove(RB)

/obj/effect/landmark/hardmode_spawner
	name = "Hardmode thing spawner"
	var/difficulty = 1

/obj/effect/landmark/hardmode_spawner/easy
	name = "Hardmode Easy thing spawner"

/obj/effect/landmark/hardmode_spawner/medium
	name = "Hardmode Medium thing spawner"

/obj/effect/landmark/hardmode_spawner/hard
	name = "Hardmode Hard thing spawner"

