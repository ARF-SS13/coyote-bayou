/mob/living/simple_animal/hostile/megafauna/captainarlem
	name = "Captain Arlem"
	desc = "A grotesque, Enclave-manufactured and Enclave-loyal prime super mutant given cybernetic augmentations, unique hardened power armor, and an arm-mounted plasma repeater, alongside drug cocktails administered by his suit. Your ride's over mutie, time to die."
	health = 3000
	maxHealth = 3000
	icon_state = "arlem"
	icon_living = "arlem"
	icon_dead = "arlem"
	icon = 'icons/fallout/mobs/bigmob.dmi'
	friendly_verb_continuous = "mutters 'Enclave huh? Get out of here. This is a restricted area by order of President Eden.'"
	friendly_verb_simple = "mutters 'Enclave huh? Get out of here. This is a restricted area by order of President Eden.'"
	attack_verb_continuous = "eviscerates"
	attack_verb_simple = "eviscerate"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	weather_immunities = list("snow")
	speak_emote = list("shouts")
	melee_damage_lower = 40
	melee_damage_upper = 50
	vision_range = 15
	aggro_vision_range = 15
	speed = 1
	move_to_delay = 8
	ranged_cooldown_time = 10
	rapid_melee = 1
	melee_queue_distance = 20 // as far as possible really, need this because of charging
	ranged = 1
	pixel_x = -16
	waddle_amount = 10
	waddle_up_time = 1
	waddle_side_time = 6
	wander = FALSE
	movement_type = GROUND
	var/charging = 0
	blood_volume = BLOOD_VOLUME_NORMAL
	deathmessage = span_colossus("chokes on their own blood, gurgling out 'You're coming with me, mutie' as they activate their self destruct!")
	deathsound = 'sound/effects/gravhit.ogg'
	del_on_death = FALSE
	loot = list(/obj/item/keycard/library)


/mob/living/simple_animal/hostile/megafauna/captainarlem/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	move_to_delay = clamp(round((health/maxHealth) * 10), 3, 10)

/mob/living/simple_animal/hostile/megafauna/captainarlem/OpenFire()
	anger_modifier = clamp(((maxHealth - health)/50),0,20)
	if(charging)
		return
	ranged_cooldown = world.time + ranged_cooldown_time

	if(prob(15))
		visible_message("<span class='colossus'>\"<b>AH, THE SUGAR SWEET KISS OF HEAVY ARTILLERY!</b>\"</span>")
		ranged_cooldown = world.time + 10
		blast()
	else if(prob(3+anger_modifier/2))
		visible_message("<span class='colossus'>\"<b>I HAVE SOME FRIENDS I'D LIKE YOU TO MEET!</b>\"</span>")
		eyebots()
	else
		if(health > maxHealth/2 && !client)
			INVOKE_ASYNC(src,PROC_REF(charge))
			visible_message("<span class='colossus'>\"<b> FOR THE ENCLAVE!</b>\"</span>")
		else
			INVOKE_ASYNC(src,PROC_REF(triple_charge))
			visible_message("<span class='colossus'>\"<b>YOUR RIDE IS OVER MUTIE, TIME TO DIE!</b>\"</span>")
			
/mob/living/simple_animal/hostile/megafauna/captainarlem/Initialize()
	. = ..()
	for(var/mob/living/simple_animal/hostile/megafauna/captainarlem/B in GLOB.mob_list)
		if(B != src)
			return INITIALIZE_HINT_QDEL //There can be only one

/mob/living/simple_animal/hostile/megafauna/captainarlem/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(charging)
		return
	..()

/mob/living/simple_animal/hostile/megafauna/captainarlem/AttackingTarget()
	if(charging)
		return
	..()

/mob/living/simple_animal/hostile/megafauna/captainarlem/Goto(target, delay, minimum_distance)
	if(charging)
		return
	..()

/mob/living/simple_animal/hostile/megafauna/captainarlem/Move()
	if(!stat)
		playsound(src.loc, 'sound/effects/meteorimpact.ogg', 200, 1, 2, 1)
	if(charging)
		new/obj/effect/temp_visual/decoy/fading(loc,src)
		DestroySurroundings()
	. = ..()
	if(charging)
		DestroySurroundings()

/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/triple_charge()
	charge()
	sleep(10)
	charge()
	sleep(10)
	charge()

/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/charge()
	var/atom/my_target = get_target()
	var/turf/T = get_turf(my_target)
	if(!T || T == loc)
		return
	new /obj/effect/temp_visual/dragon_swoop(T)
	charging = 1
	DestroySurroundings()
	walk(src, 0)
	setDir(get_dir(src, T))
	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(loc,src)
	animate(D, alpha = 0, color = "#11d839", transform = matrix()*2, time = 5)
	sleep(5)
	throw_at(T, get_dist(src, T), 1, src, 0)
	charging = 0
	Goto(my_target, move_to_delay, minimum_distance)


/mob/living/simple_animal/hostile/megafauna/captainarlem/Bump(atom/A)
	if(charging)
		if(isturf(A) || isobj(A) && A.density)
			A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()
	..()

/mob/living/simple_animal/hostile/megafauna/captainarlem/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!charging)
		return ..()

	else if(isliving(hit_atom))
		var/mob/living/L = hit_atom
		L.visible_message(span_danger("[src] laughs maniacally as he rends[L]!"), span_userdanger("[src] slams into you, laughing maniacally!"))
		L.apply_damage(50, BRUTE)
		playsound(get_turf(L), 'sound/effects/meteorimpact.ogg', 100, 1)
		shake_camera(L, 4, 3)
		shake_camera(src, 2, 3)
		var/throwtarget = get_edge_target_turf(src, get_dir(src, get_step_away(L, src)))
		L.throw_at(throwtarget, 3)

	charging = 0

/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/fire_plasmacaster(turf/marker, set_angle)
	if(!isnum(set_angle) && (!marker || marker == loc))
		return
	var/turf/startloc = get_turf(src)
	var/obj/item/projectile/P = new /obj/item/projectile/f13plasma/plasmacaster/arlem(startloc)
	P.preparePixelProjectile(marker, startloc)
	P.firer = src
	var/atom/my_target = get_target()
	if(my_target)
		P.original = my_target
	P.fire(set_angle)

/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/blast(set_angle)
	var/turf/target_turf = get_turf(target)
	playsound(src, 'sound/weapons/lasercannonfire.ogg', 200, 1, 2)
	newtonian_move(get_dir(target_turf, src))
	var/angle_to_target = Get_Angle(src, target_turf)
	if(isnum(set_angle))
		angle_to_target = set_angle
	var/static/list/plasmacaster_angles = list(12.5, 7.5, 2.5, -2.5, -7.5, -12.5)
	for(var/i in plasmacaster_angles)
		fire_plasmacaster(target_turf, angle_to_target + i)

/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/eyebots()
	visible_message(span_danger("[src] presses a button on their wrist, activating some of the eyebots!"))
	for(var/obj/effect/decal/remains/deadeyebot/H in range(src, 10))
		if(prob(40))
			new /mob/living/simple_animal/hostile/eyebot(H.loc)
	
/mob/living/simple_animal/hostile/megafauna/captainarlem/proc/self_destruct()
	explosion(src,3,5,7,7)
	qdel(src)

/mob/living/simple_animal/hostile/megafauna/captainarlem/death()
	do_sparks(3, TRUE, src)
	addtimer(CALLBACK(src,PROC_REF(self_destruct)), 4 SECONDS)
	return ..()


