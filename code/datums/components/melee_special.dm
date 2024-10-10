#define WEAPON_MASTER var/obj/item/master = parent; if(!istype(master)) {return}

#define WS_TARGET_IGNORE_FRIENDLIES (1<<0) // target friendlies
#define WS_TARGET_IGNORE_DEAD (1<<1) // target dead mobs
#define WS_TARGET_IGNORE_SELF (1<<2) // target self
#define WS_TARGET_MOBS (1<<3) // hit all mobs on the turf
#define WS_TARGET_STRUCTURES (1<<4) // hit objects on the turf
#define WS_TARGET_MACHINES (1<<5) // hit machines on the turf
#define WS_TARGET_WALLS (1<<6) // hit opaque walls on the turf
//#define WS_TARGET_PREFERED_FIRST (1<<6) // If we hit multiple objects, hit the prefered one first
#define WS_TARGET_ALL (1<<8) // Hit all objects on the turf -- probably dont use this

#define WS_DAMAGE_FALLOFF_CLOSE_HIGH (1<<0) // damage falls off the further away the target is
#define WS_DAMAGE_FALLOFF_FAR_HIGH (1<<1) // damage falls off the closer the target is
#define WS_DAMAGE_SPLIT (1<<2) // damage is split between all targets
// #define WS_DAMAGE_TOPMOST (1<<5) // hit the topmost object on the turf
// #define WS_DAMAGE_RANDOM (1<<7) // If we hit multiple objects, hit a random one

#define WS_NORMAL "normal_damage"
#define WS_EXTRA_BRUTE BRUTE
#define WS_EXTRA_BURN BURN
#define WS_EXTRA_TOX TOX
#define WS_EXTRA_OXY OXY
#define WS_EXTRA_BRAIN BRAIN
#define WS_EXTRA_CLONE CLONE
#define WS_EXTRA_STAMINA STAMINA

#define WS_CLOSEST_POPULATED_TILE "closest_populated_tile"
#define WS_FURTHEST_POPULATED_TILE "furthest_populated_tile"
#define WS_RANDOM_POPULATED_TILE "random_populated_tile"
#define WS_ALL_POPULATED_TILES "all_populated_tiles"

/datum/component/weapon_special
	/// The maximum distance the weapon can hit a mob from.
	var/max_distance = 1
	/// List of which intents trigger this thing
	var/list/intent_flags = list(INTENT_HARM)
	/// targetting flags
	var/target_flags = WS_TARGET_WALLS | WS_TARGET_IGNORE_DEAD | WS_TARGET_IGNORE_SELF | WS_TARGET_MOBS | WS_TARGET_STRUCTURES | WS_TARGET_MACHINES
	/// target mode
	var/target_mode = WS_FURTHEST_POPULATED_TILE
	/// damage flags
	var/damage_flags = NONE
	/// Extra damage multiplier to certain atoms -- list(atom_type = list(WS_EXTRA_BRUTE = 1, WS_EXTRA_BURN = 0.5))
	/// Does master.force * extra_damage_multiplier extra damage of these types to the atom
	//var/list/extra_damage_to_type = list(/obj/structure/window = list(WS_EXTRA_BRUTE = 0.5))
	var/list/extra_damage_to_type = list(/obj/structure/window = list(WS_EXTRA_BRUTE = 0.5))
	/// does extra damage to all atoms
	var/list/extra_damage = list()
	/// Damage multiplier for damage fallof
	var/falloff_mult = 0.80
	/// max mobs it can hit
	var/max_mobs_hit = 1
	/// effect kind
	var/effect_kind = ATTACK_EFFECT_PUNCH
	/// make a cool line effect
	var/line_effect = FALSE
	/// Sunset joked about turning melee into hitscan projectiles. Went so far over my head I actually did it.
	var/datum/point/vector/punch_laser
	/// debug highlights
	var/debug = FALSE
	/// Always do the thing, mostly for spears
	var/always_do = FALSE
	/// fucking click delay bullshit
	var/fucking_click_delay_bullshit = FALSE
	COOLDOWN_DECLARE(fuckin_fuck)

/datum/component/weapon_special/single_turf

/datum/component/weapon_special/ranged_spear
	max_distance = 2
	max_mobs_hit = 3
	always_do = TRUE
	line_effect = TRUE
	effect_kind = null
	target_mode = WS_ALL_POPULATED_TILES
	target_flags = WS_TARGET_WALLS | WS_TARGET_IGNORE_DEAD | WS_TARGET_IGNORE_SELF | WS_TARGET_MOBS | WS_TARGET_STRUCTURES | WS_TARGET_MACHINES | WS_TARGET_WALLS
	damage_flags = WS_DAMAGE_FALLOFF_FAR_HIGH

/datum/component/weapon_special/ranged_spear/longer/pike
	extra_damage = list(WS_EXTRA_BRUTE = 1)

/datum/component/weapon_special/ranged_spear/longer
	max_distance = 3
	max_mobs_hit = 5
	falloff_mult = 0.5 // even harsher fallff!

/datum/component/weapon_special/ranged_spear/cult_bastard
	max_distance = 1
	max_mobs_hit = 3
	always_do = TRUE
	line_effect = ATTACK_EFFECT_PUNCH
	effect_kind = null
	target_mode = WS_ALL_POPULATED_TILES
	target_flags = WS_TARGET_WALLS | WS_TARGET_IGNORE_DEAD | WS_TARGET_IGNORE_SELF | WS_TARGET_MOBS | WS_TARGET_STRUCTURES | WS_TARGET_MACHINES | WS_TARGET_WALLS
	damage_flags = NONE

/datum/component/weapon_special/Initialize()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

/datum/component/weapon_special/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ITEM_ATTACKCHAIN,PROC_REF(item_attackchain))

/datum/component/weapon_special/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, list(COMSIG_ITEM_ATTACKCHAIN))

/datum/component/weapon_special/proc/item_attackchain(datum/source, mob/user, atom/target, params)
	if(!user || !target)
		return
	WEAPON_MASTER
	if(fucking_click_delay_bullshit)
		if(!master.CheckAttackCooldown(user, target))
			return
	fucking_click_delay_bullshit = FALSE
	if(!COOLDOWN_FINISHED(src, fuckin_fuck))
		return
	COOLDOWN_START(src, fuckin_fuck, 0.5 SECONDS)
	var/list/paramslist = params2list(params)
	var/angle = text2num(paramslist["angle"])
	if(run_special(user, target, params, angle))
		fucking_click_delay_bullshit = TRUE // fuk u
		user.DelayNextAction(master.attack_speed)
		return

/datum/component/weapon_special/proc/run_special(mob/user, atom/target, params, angle = null)
	if(!user || !target)
		return
	if(!check_intent(user))
		return
	var/inrange = user.can_reach(target, reach = 1)
	if(inrange)
		if(!isturf(target))
			return
	if(isnull(angle))
		angle = mouse_angle_from_client(user.client)
	var/list/hit_tiles = get_turfs_in_range(user, target, angle)
	if(!LAZYLEN(hit_tiles))
		return
	cool_effect(hit_tiles, user, target, angle)
	var/list/hit_atoms = select_atoms_to_hit(user, hit_tiles, target_mode)
	if(!LAZYLEN(hit_atoms))
		return
	var/list/damages = calculate_damages(user, hit_atoms, target)
	if(!LAZYLEN(damages))
		return
	/// Past here, we're we're initiating the attack, whether it hits something or now
	. = TRUE // Only incur the cooldown *after* we have something to hit
	var/list/moblist = list()
	for(var/mob/living/livom in damages)
		moblist[livom] = damages[livom]
		damages -= livom
	if(LAZYLEN(moblist))
		hit_list(user, moblist, target)
	if(LAZYLEN(damages))
		hit_list(user, damages, target)

/datum/component/weapon_special/proc/hit_list(mob/user, list/to_hit, atom/target)
	if(!user || !target || !LAZYLEN(to_hit))
		return
	for(var/times in 1 to max_mobs_hit)
		var/atom/lucky_sob = pick(to_hit)
		do_a_hit(user, lucky_sob, to_hit[lucky_sob], target)
		to_hit -= lucky_sob
		if(!LAZYLEN(to_hit))
			return

/datum/component/weapon_special/proc/check_intent(mob/user)
	if(!ismob(user))
		return
	if(!LAZYLEN(intent_flags))
		return TRUE
	return (user.a_intent in intent_flags)

/datum/component/weapon_special/proc/get_turfs_in_range(mob/user, atom/target, angle = null)
	if(!user)
		return
	if(isnull(angle))
		angle = mouse_angle_from_client(user.client)
	if(!target)
		target = get_turf_in_angle(angle, get_turf(user), 10)
	if(debug)
		INVOKE_ASYNC(src,PROC_REF(debug_highlight), target)
	if(target && max_distance < 2 && user.can_reach(target, reach = max_distance))
		return list(get_turf(target)) // we're close enough to just hit the target
	// okay we clicked something out of range, so we need to find the turf at the edge of our range in the direction we clicked
	// at this point, target isnt really important, everything is derived from where the user clicked
	// obviously the user needs a client in it to do this
	//var/turf/far_target = client_mouse_angle2turf(user, get_turf(user))
	//if(!far_target)
	//	return // cool
	//var/turf/furthest_reachable_tile = user.euclidian_reach(far_target, max_distance, REACH_ATTACK) // dunno what it does, but someone clever made it, probably
	// Now we have our destination turf, now we just need all the tiles between us and that turf
	var/list/line_of_turfs = sim_punch_laser(user, angle) // matt mcmuscles said it once and i liked it uwu
	//var/list/line_of_turfs = getline(get_turf(user), furthest_reachable_tile) // line of turfs starting at the user and ending at the turf at the edge of our range
	if(!LAZYLEN(line_of_turfs)) // ^ hopefully in the right order
		return // cool
	if(debug)
		INVOKE_ASYNC(src,PROC_REF(debug_highlight_line), user, line_of_turfs, target)
	return line_of_turfs

/datum/component/weapon_special/proc/sim_punch_laser(mob/user, angle = null)
	if(!user)
		return
	if(!user.client)
		return
	if(isnull(angle))
		angle = mouse_angle_from_client(user.client)
	if(!punch_laser)
		punch_laser = new()
	punch_laser.initialize_location(user.x, user.y, user.z, 0, 0)
	punch_laser.initialize_trajectory(4, angle) // 8 steps per tile!
	var/list/output_turfs = list()
	var/steps = (max_distance * 8) + 1
	output_turfs |= punch_laser.return_turf()
	if(!LAZYLEN(output_turfs))
		return
	var/turf/cached
	while(steps)
		steps--
		punch_laser.increment()
		var/turf/current = punch_laser.return_turf()
		if(current == cached)
			continue
		cached = current
		output_turfs |= current
		if(is_hard_blocker(current))
			break
	return output_turfs

// So turns out can_reach is fuckin high, keeps letting me reach past things
// So, fuck it, gonna make my own cursed busted bullshit fuckin wall check cus having good things is illegal in this state
/datum/component/weapon_special/proc/is_hard_blocker(turf/check)
	if(!isturf(check))
		return TRUE
	if(check.density)
		return TRUE
	for(var/atom/obstacle in check)
		if(ismob(obstacle))
			continue
		if(obstacle.opacity)
			return TRUE
		if(obstacle.density && (isturf(obstacle) || !CHECK_BITFIELD(obstacle.pass_flags_self, LETPASSTHROW)))
			return TRUE

/datum/component/weapon_special/proc/client_mouse_angle2turf(mob/user, atom/origin)
	if(!user || !origin)
		return
	if(!user.client)
		return
	var/client/clint = user.client
	var/click_angle = mouse_angle_from_client(clint)
	if(!click_angle)
		return
	var/turf/far_target = get_turf_in_angle(click_angle, get_turf(origin), 10) // 10 is arbitrary, just needs to be big enough to be out of range
	if(!far_target)
		return
	return far_target

/// Compiles a list of atoms that are in the weapon's effect, and sorts them by distance.
/datum/component/weapon_special/proc/select_atoms_to_hit(mob/user, list/turfs_hit, select_mode = WS_CLOSEST_POPULATED_TILE)
	if(!user)
		return
	if(!LAZYLEN(turfs_hit))
		return
	var/list/atomstuff = list()
	var/turf/userorigin = get_turf(user)
	for(var/turf/turfhere in turfs_hit)
		var/list/turfatoms = get_atoms_on_turf(turfhere, user)
		if(!LAZYLEN(turfatoms))
			continue
		var/dist = max(GET_DIST_EUCLIDEAN(userorigin, turfhere), 1)
		if(!islist(atomstuff["[dist]"]))
			atomstuff["[dist]"] = list()
		atomstuff["[dist]"] |= turfatoms
	if(!LAZYLEN(atomstuff))
		return
	switch(select_mode)
		if(WS_CLOSEST_POPULATED_TILE)
			atomstuff = sort_list(atomstuff)
			for(var/just_one in atomstuff)
				var/list/out = list("[just_one]" = atomstuff[just_one])
				if(debug)
					for(var/atom/movable/AM in out)
						INVOKE_ASYNC(src,PROC_REF(debug_highlight_atom), AM, "#0000FF")
				return out
		if(WS_FURTHEST_POPULATED_TILE)
			atomstuff = sort_list(atomstuff, cmp=/proc/cmp_text_dsc)
			for(var/just_one in atomstuff)
				var/list/out = list("[just_one]" = atomstuff[just_one])
				if(debug)
					for(var/atom/movable/AM in out)
						INVOKE_ASYNC(src,PROC_REF(debug_highlight_atom), AM, "#0000FF")
				return out
		if(WS_RANDOM_POPULATED_TILE)
			var/just_one = pick(atomstuff)
			var/list/out = list("[just_one]" = atomstuff[just_one])
			if(debug)
				for(var/atom/movable/AM in out)
					INVOKE_ASYNC(src,PROC_REF(debug_highlight_atom), AM, "#0000FF")
			return out
	if(debug)
		for(var/atom/movable/AM in atomstuff)
			INVOKE_ASYNC(src,PROC_REF(debug_highlight_atom), AM, "#0000FF")
	return atomstuff

/datum/component/weapon_special/proc/get_atoms_on_turf(turf/turfhere, mob/user)
	if(!isturf(turfhere))
		return
	if(!user)
		return
	. = list()
	for(var/atom/atomhere in turfhere.contents)
		if(!atomhere)
			continue
		if(atomhere == user && (target_flags & WS_TARGET_IGNORE_SELF))
			continue
		if(CHECK_BITFIELD(target_flags, WS_TARGET_WALLS))
			if(iswallturf(atomhere))
				. |= atomhere
				continue
		if(CHECK_BITFIELD(target_flags, WS_TARGET_ALL))
			. |= atomhere
			continue
		//var/isprefd = is_type_in_list(atomhere, prefered_types)
		if((CHECK_BITFIELD(target_flags, WS_TARGET_STRUCTURES) && isstructure(atomhere)))
			. |= atomhere
			continue
		if((CHECK_BITFIELD(target_flags, WS_TARGET_MACHINES) && ismachinery(atomhere)))
			. |= atomhere
			continue
		if((CHECK_BITFIELD(target_flags, WS_TARGET_MOBS) && isliving(atomhere)))
			var/mob/living/livinghere = atomhere
			if(CHECK_BITFIELD(target_flags, WS_TARGET_IGNORE_DEAD) && livinghere.stat == DEAD)
				continue
			if((CHECK_BITFIELD(target_flags, WS_TARGET_IGNORE_FRIENDLIES) || get_turf(livinghere) == get_turf(user)) && user.faction_check_mob(livinghere))
				continue
			if(livinghere == user.buckled)
				continue
			. |= livinghere

/datum/component/weapon_special/proc/calculate_damages(mob/user, list/atoms_hit)
	if(!user)
		return
	if(!LAZYLEN(atoms_hit))
		return
	WEAPON_MASTER
	var/total_targets = 0
	for(var/i in atoms_hit)
		for(var/mob/living/vml in atoms_hit[i])
			if(vml)
				total_targets++
	total_targets = max(total_targets, 1)
	. = list()
	for(var/dist in atoms_hit)
		var/trudist = text2num(dist)
		for(var/atom/atomhere in atoms_hit[dist])
			if(!atomhere)
				continue
			var/list/dam_list = list()
			var/damage
			if(isliving(atomhere))
				var/mob/living/livinghere = atomhere
				damage = livinghere.pre_attacked_by(master, user)
			else
				damage = master.force
			var/d_mult = 1
			if(CHECK_BITFIELD(damage_flags, WS_DAMAGE_FALLOFF_CLOSE_HIGH))
				if(trudist < 1.5)
					d_mult = 1
				else
					var/spaces = max(trudist, 1)
					d_mult = falloff_mult ** (spaces - 1) // fun fact, I dont know if this works!
			else if(CHECK_BITFIELD(damage_flags, WS_DAMAGE_FALLOFF_FAR_HIGH))
				if(trudist > (max_distance - 1)) // CAN YOU TELL I DONT KNOW MATHS???
					d_mult = 1
				else
					var/spaces = max_distance - trudist
					d_mult = 1 - max(falloff_mult ** (spaces), 0)
			if(CHECK_BITFIELD(damage_flags, WS_DAMAGE_SPLIT))
				d_mult /= max(total_targets, 1)
			d_mult = max(d_mult, 0.01)
			LAZYSET(dam_list, WS_NORMAL, damage)
			if(LAZYLEN(extra_damage_to_type))
				for(var/banetype in extra_damage_to_type)
					if(!istype(atomhere, banetype))
						continue
					for(var/damtype in extra_damage_to_type[banetype])
						var/xtra_dam = extra_damage_to_type[banetype][damtype]
						if(!xtra_dam) // its a multiple of the weapon's output damage
							continue
						LAZYSET(dam_list, damtype, xtra_dam * damage)
			if(LAZYLEN(extra_damage))
				var/list/extra_damages = counterlist_scale(extra_damage.Copy(), damage)
				counterlist_combine(dam_list, extra_damages)
			for(var/damag in dam_list)
				dam_list[damag] *= d_mult
			LAZYSET(., atomhere, dam_list)

/// Attempts to attack a mob with the weapon.
/datum/component/weapon_special/proc/do_a_hit(mob/user, atom/hit_this, list/damage_list, atom/original_target)
	if(!isatom(hit_this) || !user || !LAZYLEN(damage_list))
		return
	WEAPON_MASTER
	var/d_zone = user.zone_selected
	if(debug)
		INVOKE_ASYNC(src,PROC_REF(debug_highlight_atom), hit_this, "#ff0000")
	for(var/dmge in damage_list)
		if(QDELETED(hit_this))
			return
		switch(dmge)
			if(WS_NORMAL)
				var/damage = damage_list[dmge]
				if(!damage)
					continue
				if(isliving(hit_this))
					master.attack(hit_this, user, NONE, 1, damage)
				else if(isobj(hit_this) || iswallturf(hit_this))
					hit_this.attackby(master, user, damage)
				user.do_attack_animation(hit_this, effect_kind)
			if(WS_EXTRA_BRUTE, WS_EXTRA_BURN, WS_EXTRA_TOX, WS_EXTRA_OXY, WS_EXTRA_CLONE, WS_EXTRA_STAMINA, WS_EXTRA_BRAIN)
				if(isliving(hit_this))
					var/mob/living/hitmob = hit_this
					var/damage = damage_list[dmge]
					if(!damage)
						continue
					var/armor_type = "melee"
					switch(dmge)
						if(WS_EXTRA_BURN)
							armor_type = "fire"
						if(WS_EXTRA_TOX)
							armor_type = "bio"
						if(WS_EXTRA_OXY)
							armor_type = "bomb"
						if(WS_EXTRA_CLONE)
							armor_type = "energy"
					var/armor_block = hitmob.run_armor_check(d_zone, armor_type, null, null, 0, null, TRUE)
					armor_block = min(90,armor_block) //cap damage reduction at 90%
					var/dt = max(hitmob.run_armor_check(d_zone, "damage_threshold"), 0)
					hitmob.apply_damage(damage, dmge, d_zone, armor_block, FALSE, FALSE, master.wound_bonus, master.bare_wound_bonus, master.sharpness, dt)
				else if(isobj(hit_this) && (dmge in list(WS_EXTRA_BRUTE, WS_EXTRA_BURN, WS_EXTRA_STAMINA)))
					var/damage = damage_list[dmge]
					if(!damage)
						continue
					hit_this.attackby(master, user, null, damage)

	// i'm sure nothing bad will happen if i let people run afterattack on every mob they hit using these components.
	master.afterattack(hit_this, user, TRUE, null)

/datum/component/weapon_special/proc/cool_effect(list/hit_tiles, mob/user, atom/target, angle = null)
	if(!user || !target)
		return
	playsound(get_turf(LAZYACCESS(hit_tiles, 1)), "sound/weapons/swoosh.ogg", 80, TRUE)
	if(effect_kind)
		for(var/turf/cool_tile in hit_tiles)
			if(get_turf(cool_tile) == get_turf(user))
				continue
			user.do_attack_animation(cool_tile, effect_kind)
	if(line_effect)
		if(!user.client)
			return
		if(isnull(angle))
			angle = mouse_angle_from_client(user?.client)
		SSeffects.do_effect(EFFECT_LINE_EFFECT, user, target, angle, max_distance * 32)

/datum/component/weapon_special/proc/debug_highlight(atom/target, clr = "#00FF00")
	if(!target)
		to_chat(world, "no target")
		return
	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		to_chat(world, "no target turf")
		return
	var/obj/effect/temp_visual/debug_highlight/thing = new(target_turf)
	thing.color = clr

/// spawns a green highlight on the clicked turf, a red one on the turf the user is on, and a blue one on every turf in the line that's in range
/datum/component/weapon_special/proc/debug_highlight_line(mob/user, list/turfs, atom/target)
	if(!user || !turfs)
		return
	var/turf/user_turf = get_turf(user)
	if(!user_turf)
		return
	debug_highlight(user_turf, "#FF0000")
	for(var/turf/turfhere as anything in turfs)
		if(!turfhere)
			continue
		debug_highlight(turfhere, "#0000FF")
	debug_highlight(target, "#00FF00")

/datum/component/weapon_special/proc/debug_highlight_atom(mob/highlit, clr = "#00FF00")
	if(!highlit)
		return
	highlit.add_atom_colour(clr, ADMIN_COLOUR_PRIORITY)
	addtimer(CALLBACK(highlit, /atom/proc/remove_atom_colour, ADMIN_COLOUR_PRIORITY), 2 SECONDS)

/obj/effect/temp_visual/debug_highlight
	name = "love heart"
	icon = 'icons/effects/effects.dmi'
	icon_state = "scanlineslow"
	duration = 2 SECONDS

/datum/component/weapon_special/debug
	debug = TRUE
	max_distance = 4
	max_mobs_hit = 10
	line_effect = TRUE
	effect_kind = ATTACK_EFFECT_BOOP
	damage_flags = WS_DAMAGE_FALLOFF_CLOSE_HIGH
	extra_damage_to_type = list(/obj/structure/window = list(WS_EXTRA_BRUTE = 500), /obj/machinery = list(WS_EXTRA_BURN = 500))
	extra_damage = list(WS_EXTRA_BRAIN = 20, WS_EXTRA_OXY = 20, WS_EXTRA_STAMINA = 10000)

/obj/item/debug_melee_turf_thing
	name = "debug melee turf thing"
	desc = "debug melee turf thing"
	icon_state = "sord"
	item_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT
	force = 12
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/debug_melee_turf_thing/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/weapon_special/debug)

/obj/effect/spawner/bundle/mobs/debug/melee_special
	name = "special debug thing that fenny shouldnt map in"
	items = list(
		/mob/living/simple_animal/hostile/rat/skitter/melee_debug,
		/mob/living/simple_animal/hostile/rat/skitter/melee_debug,
		/mob/living/simple_animal/hostile/rat/skitter/melee_debug,
		/mob/living/simple_animal/hostile/rat/skitter/melee_debug,
		/mob/living/simple_animal/hostile/rat/skitter/melee_debug,
		/obj/item/debug_melee_turf_thing,
		/obj/item/melee/coyote/oldpike,
	)

/mob/living/simple_animal/hostile/rat/skitter/melee_debug
	name = "debug rat"
	desc = "Its a rat!"
	melee_damage_lower = 0.01
	melee_damage_upper = 0.01
	maxHealth = 50
	health = 50
	retreat_distance = 1
	minimum_distance = 1
	aggro_vision_range = 7
	vision_range = 10
	is_smol = TRUE

	variation_list = list(
	)

/mob/living/simple_animal/hostile/rat/skitter/melee_debug/attacked_by(obj/item/I, mob/living/user, attackchain_flags = NONE, damage_multiplier = 1, damage_addition, damage_override)
	say("I took damage! [damage_override] to be exact! Weapon's damage is [I.force]! Thanks [user]!", only_overhead = TRUE)
	return ..()

