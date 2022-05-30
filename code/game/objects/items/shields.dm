//In this document: Shield template, riot shield, bulletproof shield, buckler, legion shield, scrap shield, energy shield. Unused code last.

/obj/item/shield
	name = "shield template"
	icon = 'icons/fallout/objects/melee/shields.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/shields_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/shields_righthand.dmi'
	item_flags = ITEM_CAN_BLOCK | SLOWS_WHILE_IN_HAND
	slowdown = 0
	block_parry_data = /datum/block_parry_data/shield
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70) //this is how much armor the SHIELD has. how much it PROTECTS is defined by block_parry_data. look at riot/bulletproof shield for implementation and living_blocking_parrying.dm for more info re:block
	/// Shield flags
	var/shield_flags = SHIELD_FLAGS_DEFAULT
	/// Last shieldbash world.time
	var/last_shieldbash = 0
	/// Shieldbashing cooldown
	var/shieldbash_cooldown = 4 SECONDS
	/// Shieldbashing stamina cost
	var/shieldbash_stamcost = 7.5
	/// Shieldbashing knockback
	var/shieldbash_knockback = 2
	/// Shield bashing brute damage
	var/shieldbash_brutedamage = 25
	/// Shield bashing stamina damage
	var/shieldbash_stamdmg = 35
	/// Shield bashing stagger duration
	var/shieldbash_stagger_duration = 5 SECONDS
	/// Shield bashing push distance
	var/shieldbash_push_distance = 1

/datum/block_parry_data/shield
	block_damage_multiplier = 0.25
	block_stamina_efficiency = 2.5
	block_stamina_cost_per_second = 2.5
	block_slowdown = 0.4
	block_lock_attacking = FALSE
	block_lock_sprinting = TRUE
	block_start_delay = 1.5
	block_damage_absorption = 5
	block_resting_stamina_penalty_multiplier = 2
	block_projectile_mitigation = 75

/obj/item/shield/examine(mob/user)
	. = ..()
	if(shield_flags & SHIELD_CAN_BASH)
		. += "<span class='notice'>Right click on combat mode attack with [src] to shield bash!</span>"
		if(shield_flags & SHIELD_BASH_GROUND_SLAM)
			. += "<span class='notice'>Directly rightclicking on a downed target with [src] will slam them instead of bashing.</span>"

/obj/item/shield/proc/on_shield_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance)
	return TRUE

/obj/item/shield/altafterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return
	user_shieldbash(user, target, user.a_intent == INTENT_HARM)
	return TRUE

/obj/item/shield/proc/do_shieldbash_effect(mob/living/user, dir, harmful)
	var/px = 0
	var/py = 0
	switch(dir)
		if(NORTH)
			py = 12
		if(SOUTH)
			py = -12
		if(EAST)
			px = 12
		if(WEST)
			px = -12
	var/obj/effect/temp_visual/dir_setting/shield_bash/effect = new(user.loc, dir)
	effect.pixel_x = user.pixel_x - 32		//96x96 effect, -32.
	effect.pixel_y = user.pixel_y - 32
	user.visible_message("<span class='warning'>[user] [harmful? "charges forwards with" : "sweeps"] [src]!</span>")
	animate(user, pixel_x = px, pixel_y = py, time = 3, easing = SINE_EASING | EASE_OUT, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)
	animate(user, pixel_x = -px, pixel_y = -py, time = 3, flags = ANIMATION_RELATIVE)
	animate(effect, alpha = 0, pixel_x = px * 1.5, pixel_y = py * 1.5, time = 3, flags = ANIMATION_PARALLEL | ANIMATION_RELATIVE)

/obj/item/shield/proc/bash_target(mob/living/user, mob/living/target, bashdir, harmful)
	if(!(target.status_flags & CANKNOCKDOWN) || HAS_TRAIT(src, TRAIT_STUNIMMUNE))	// should probably add stun absorption check at some point I guess..
		// unified stun absorption system when lol
		target.visible_message("<span class='warning'>[user] slams [target] with [src], but [target] doesn't falter!</span>", "<span class='userdanger'>[user] slams you with [src], but it barely fazes you!</span>")
		return FALSE
	var/target_downed = !CHECK_MOBILITY(target, MOBILITY_STAND)
	var/wallhit = FALSE
	var/turf/target_current_turf = get_turf(target)
	if(harmful)
		target.visible_message("<span class='warning'>[target_downed? "[user] slams [src] into [target]" : "[user] bashes [target] with [src]"]!</span>",
		"<span class='warning'>[target_downed? "[user] slams [src] into you" : "[user] bashes you with [src]"]!</span>")
	else
		target.visible_message("<span class='warning'>[user] shoves [target] with [src]!</span>",
		"<span class='warning'>[user] shoves you with [src]!</span>")
	for(var/i in 1 to harmful? shieldbash_knockback : shieldbash_push_distance)
		var/turf/new_turf = get_step(target, bashdir)
		var/mob/living/carbon/human/H = locate() in (new_turf.contents - target)
		if(H && harmful)
			H.visible_message("<span class='warning'>[target] is sent crashing into [H]!</span>",
			"<span class='userdanger'>[target] is sent crashing into you!</span>")
			H.KnockToFloor()
			wallhit = TRUE
			break
		else
			step(target, bashdir)
			if(get_turf(target) == target_current_turf)
				wallhit = TRUE
				break
			else
				target_current_turf = get_turf(target)
	var/disarming = (target_downed && (shield_flags & SHIELD_BASH_GROUND_SLAM_DISARM)) || (shield_flags & SHIELD_BASH_ALWAYS_DISARM) || (wallhit && (shield_flags & SHIELD_BASH_WALL_DISARM))
	var/knockdown = !target_downed && ((shield_flags & SHIELD_BASH_ALWAYS_KNOCKDOWN) || (wallhit && (shield_flags & SHIELD_BASH_WALL_KNOCKDOWN)))
	if(shieldbash_stagger_duration || knockdown)
		target.visible_message("<span class='warning'>[target] is knocked [knockdown? "to the floor" : "off balance"]!</span>",
		"<span class='userdanger'>You are knocked [knockdown? "to the floor" : "off balance"]!</span>")
	if(knockdown)
		target.KnockToFloor(disarming)
	else if(disarming)
		target.drop_all_held_items()

	if(harmful)
		target.apply_damage(shieldbash_stamdmg, STAMINA, BODY_ZONE_CHEST)
		target.apply_damage(shieldbash_brutedamage, BRUTE, BODY_ZONE_CHEST)
	target.Stagger(shieldbash_stagger_duration)
	return TRUE

/obj/item/shield/proc/user_shieldbash(mob/living/user, atom/target, harmful)
	if(!SEND_SIGNAL(user, COMSIG_COMBAT_MODE_CHECK, COMBAT_MODE_ACTIVE)) //Combat mode has to be enabled for shield bashing
		return FALSE
	if(!(shield_flags & SHIELD_CAN_BASH))
		to_chat(user, "<span class='warning'>[src] can't be used to shield bash!</span>")
		return FALSE
	if(!CHECK_MOBILITY(user, MOBILITY_STAND))
		to_chat(user, "<span class='warning'>You can't bash with [src] while on the ground!</span>")
		return FALSE
	if(world.time < last_shieldbash + shieldbash_cooldown)
		to_chat(user, "<span class='warning'>You can't bash with [src] again so soon!</span>")
		return FALSE
	var/mob/living/livingtarget = target		//only access after an isliving check!
	if(isliving(target) && !CHECK_MOBILITY(livingtarget, MOBILITY_STAND))		//GROUND SLAAAM
		if(!(shield_flags & SHIELD_BASH_GROUND_SLAM))
			to_chat(user, "<span class='warning'>You can't ground slam with [src]!</span>")
			return FALSE
		bash_target(user, target, NONE, harmful)
		user.do_attack_animation(target, used_item = src)
		playsound(src, harmful? "swing_hit" : 'sound/weapons/thudswoosh.ogg', 75, 1)
		last_shieldbash = world.time
		user.adjustStaminaLossBuffered(shieldbash_stamcost)
		return TRUE
	// Directional sweep!
	last_shieldbash = world.time
	user.adjustStaminaLossBuffered(shieldbash_stamcost)
	// Since we are in combat mode, we can probably safely use the user's dir instead of getting their mouse pointing cardinal dir.
	var/bashdir = user.dir
	do_shieldbash_effect(user, bashdir, harmful)
	var/list/checking = list(get_step(user, user.dir), get_step(user, turn(user.dir, 45)), get_step(user, turn(user.dir, -45)))
	var/list/victims = list()
	for(var/i in checking)
		var/turf/T = i
		for(var/mob/living/L in T.contents)
			victims += L
	if(length(victims))
		for(var/i in victims)
			bash_target(user, i, bashdir, harmful)
		playsound(src, harmful? "swing_hit" : 'sound/weapons/thudswoosh.ogg', 75, 1)
	else
		playsound(src, 'sound/weapons/punchmiss.ogg', 75, 1)
	return length(victims)

/obj/effect/temp_visual/dir_setting/shield_bash
	icon = 'icons/effects/96x96_attack_sweep.dmi'
	icon_state = "shield_bash"
	duration = 3

/obj/item/shield/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(ismovable(object))
		var/atom/movable/AM = object
		if(CHECK_BITFIELD(shield_flags, SHIELD_TRANSPARENT) && (AM.pass_flags & PASSGLASS))
			return BLOCK_NONE
	if(attack_type & ATTACK_TYPE_THROWN)
		final_block_chance += 30
	if(attack_type & ATTACK_TYPE_TACKLE)
		final_block_chance = 100
	. = ..()
	if(. & BLOCK_SUCCESS)
		on_shield_block(owner, object, damage, attack_text, attack_type, armour_penetration, attacker, def_zone, final_block_chance, block_return)

/obj/item/shield/on_active_block(mob/living/owner, atom/object, damage, damage_blocked, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return, override_direction)
	on_shield_block(owner, object, damage, attack_text, attack_type, armour_penetration, attacker, def_zone, final_block_chance)


//Basic riotshield, meant to protect from melee and thrown weapons.
/obj/item/shield/riot
	name = "riot shield"
	desc = "A shield for protecting the user from low impact force while giving good visibility."
	icon_state = "shield_riot"
	item_state = "shield_riot"
	slot_flags = ITEM_SLOT_BACK
	armor = list("melee" = 80, "bullet" = 65, "laser" = 60, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	force = 10
	block_parry_data = /datum/block_parry_data/shield/riot
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/plastic=8000)
	attack_verb = list("shoved", "bashed")
	var/cooldown = 0 //shield bash cooldown. based on world.time
	var/repair_material = /obj/item/stack/sheet/plastic
	var/can_shatter = FALSE
	shield_flags = SHIELD_FLAGS_DEFAULT | SHIELD_TRANSPARENT
	max_integrity = 2250

/datum/block_parry_data/shield/riot
	block_damage_multiplier = 0.35
	block_stamina_efficiency = 5
	block_stamina_cost_per_second = 1
	block_damage_absorption = 7.5

/obj/item/shield/riot/attackby(obj/item/W, mob/user, params)
	if(istype(W, repair_material))
		if(obj_integrity >= max_integrity)
			to_chat(user, "<span class='warning'>[src] is already in perfect condition.</span>")
		else
			var/obj/item/stack/S = W
			S.use(1)
			obj_integrity = max_integrity
			to_chat(user, "<span class='notice'>You repair [src] with [S].</span>")
	else if(istype(W, /obj/item/melee))
		if(cooldown < world.time - 25)
			user.visible_message("<span class='warning'>[user] bashes [src] with [W]!</span>")
			playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, 1)
			cooldown = world.time
	else
		return ..()

/obj/item/shield/riot/examine(mob/user)
	. = ..()
	var/healthpercent = round((obj_integrity/max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			. += "<span class='info'>It looks slightly damaged.</span>"
		if(25 to 50)
			. += "<span class='info'>It appears heavily damaged.</span>"
		if(0 to 25)
			. += "<span class='warning'>It's falling apart!</span>"

/obj/item/shield/riot/proc/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/shard((get_turf(src)))

/obj/item/shield/riot/on_shield_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(can_shatter && (obj_integrity <= damage))
		var/turf/T = get_turf(owner)
		T.visible_message("<span class='warning'>[attack_text] destroys [src]!</span>")
		shatter(owner)
		qdel(src)
		return FALSE
	take_damage(damage)
	return ..()

//Bulletproof riot shield
obj/item/shield/riot/bullet_proof
	name = "bullet resistant shield"
	desc = "Kevlar coated surface makes this riot shield a lot better for blocking projectiles."
	icon_state = "shield_bulletproof"
	item_state = "shield_bulletproof"
	block_parry_data = /datum/block_parry_data/shield/bulletproof
	armor = list("melee" = 50, "bullet" = 90, "laser" = 50, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 80, "acid" = 70)
	max_integrity = 1750
	slowdown = 0.2
	custom_materials = list(/datum/material/plastic=8000, /datum/material/titanium=1000)
	repair_material = /obj/item/stack/sheet/mineral/titanium

/datum/block_parry_data/shield/bulletproof
	block_damage_multiplier_override = list(ATTACK_TYPE_PROJECTILE_TEXT = 0.65)
	block_damage_absorption_override = list(ATTACK_TYPE_PROJECTILE_TEXT = 12.5)
	block_resting_stamina_penalty_multiplier = 2
	block_projectile_mitigation = 90
	block_damage_limit = 100

//Buckler. Cheapest shield, also the worst.
/obj/item/shield/riot/buckler
	name = "wooden buckler"
	desc = "A small wooden shield."
	icon_state = "shield_buckler"
	item_state = "shield_buckler"
	block_parry_data = /datum/block_parry_data/shield/scrap
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 40)
	max_integrity = 150
	custom_materials = list(/datum/material/wood = 18000)
	resistance_flags = FLAMMABLE
	repair_material = /obj/item/stack/sheet/mineral/wood
	shield_flags = SHIELD_FLAGS_LIGHT
	shieldbash_push_distance = 0
	shieldbash_knockback = 0

/obj/item/shield/riot/buckler/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/bang.ogg', 50)
	new /obj/item/stack/sheet/mineral/wood(get_turf(src))


// Stop sign shield.
/obj/item/shield/riot/buckler/stop
	name = "stop sign buckler"
	desc = "Made from a ancient roadsign, with handles made of rope."
	icon_state = "shield_stop"
	item_state = "shield_stop"
	armor = list("melee" = 65, "bullet" = 60, "laser" = 65, "energy" = 0, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)
	max_integrity = 300
	slowdown = 0
	resistance_flags = null
	repair_material = /obj/item/stack/sheet/metal


//Legion shield
/obj/item/shield/riot/legion
	name = "legion shield"
	desc = "Heavy shield with metal pieces bolted to a wood backing, with a painted yellow bull insignia in the centre. Repair with metal."
	icon_state = "shield_legion"
	item_state = "shield_legion"
	block_parry_data = /datum/block_parry_data/shield/legion
	armor = list("melee" = 70, "bullet" = 60, "laser" = 60, "energy" = 0, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)
	force = 13
	slowdown = 0
	max_integrity = 500
	custom_materials = list(/datum/material/wood = 16000, /datum/material/iron= 16000)
	repair_material = /obj/item/stack/sheet/metal
	shield_flags = SHIELD_FLAGS_HEAVY

/obj/item/shield/riot/legion/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/grillehit.ogg', 100)
	new /obj/item/stack/sheet/metal(get_turf(src))

/datum/block_parry_data/shield/legion
	block_damage_multiplier = 0.3
	block_damage_absorption = 7.5
	block_damage_limit = 30

//Scrap shield. Somewhat cheaper, simpler and worse than Legion shield but basically similar.
/obj/item/shield/riot/scrapshield
	name = "scrap shield"
	desc = "A large shield made of glued and welded sheets of metal. Heavy and clumsy, but at least its handle is wrapped in some cloth."
	icon_state = "shield_scrap"
	item_state = "shield_scrap"
	block_parry_data = /datum/block_parry_data/shield/scrap
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 0, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)
	max_integrity = 500
	slowdown = 0.1
	force = 13
	custom_materials = list(/datum/material/iron = 16000)
	repair_material = /obj/item/stack/sheet/metal
	shield_flags = SHIELD_FLAGS_DEFAULT

/datum/block_parry_data/shield/scrap
	block_damage_multiplier = 0.3
	block_damage_limit = 22

//Energy shield. Placeholder for the experimental BoS shield concept that never got implemented I suppose.
/obj/item/shield/energy
	name = "experimental energy shield"
	desc = "A forcefield that reflects almost all energy projectiles, but is useless against physical attacks. It can be retracted, expanded, and stored anywhere."
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("shoved", "bashed")
	throw_range = 5
	force = 3
	throwforce = 3
	throw_speed = 3
	var/base_icon_state = "shield_energy" // [base_icon_state]1 for expanded, [base_icon_state]0 for contracted
	var/on_force = 10
	var/on_throwforce = 8
	var/on_throw_speed = 2
	var/active = 0
	var/clumsy_check = TRUE

/obj/item/shield/energy/Initialize()
	. = ..()
	icon_state = "[base_icon_state]0"

/obj/item/shield/energy/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if((attack_type & ATTACK_TYPE_PROJECTILE) && is_energy_reflectable_projectile(object))
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
		return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT
	return ..()

/obj/item/shield/energy/active_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return, override_direction)
	if((attack_type & ATTACK_TYPE_PROJECTILE) && is_energy_reflectable_projectile(object))
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
		return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT
	return ..()

/obj/item/shield/energy/attack_self(mob/living/carbon/human/user)
	if(clumsy_check && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, "<span class='userdanger'>You beat yourself in the head with [src]!</span>")
		user.take_bodypart_damage(5)
	active = !active
	icon_state = "[base_icon_state][active]"

	if(active)
		force = on_force
		throwforce = on_throwforce
		throw_speed = on_throw_speed
		w_class = WEIGHT_CLASS_BULKY
		playsound(user, 'sound/weapons/saberon.ogg', 35, TRUE)
		to_chat(user, "<span class='notice'>[src] is now active.</span>")
	else
		force = initial(force)
		throwforce = initial(throwforce)
		throw_speed = initial(throw_speed)
		w_class = WEIGHT_CLASS_TINY
		playsound(user, 'sound/weapons/saberoff.ogg', 35, TRUE)
		to_chat(user, "<span class='notice'>[src] can now be concealed.</span>")
	add_fingerprint(user)

/obj/item/shield/riot/tower
	name = "tower shield"
	desc = "A heavy metal tower shield. Very unwieldly."
	icon_state = "shield_tower"
	item_state = "shield_tower"
	slot_flags = ITEM_SLOT_BACK
	shieldbash_cooldown = 8 SECONDS
	shieldbash_brutedamage = 50//if you close in with this, and land a shieldbash you should deal a good bit of damage
	shieldbash_stamdmg = 80//and stamina
	force = 25
	block_parry_data = /datum/block_parry_data/shield/tower
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	w_class = WEIGHT_CLASS_HUGE
	custom_materials = list(/datum/material/iron = 32000)
	repair_material = /obj/item/stack/sheet/metal
	shield_flags = SHIELD_FLAGS_HEAVY
	max_integrity = 3000

/datum/block_parry_data/shield/tower
	block_slowdown = 0.75
	block_damage_multiplier = 0.7
	block_stamina_efficiency = 10
	block_stamina_cost_per_second = 5
	block_damage_absorption = 20
	block_damage_limit = 160
	block_start_delay = 10 //1 second to start blocking

/obj/item/shield/riot/tower/scrap
	name = "scrap-tower shield"
	desc = "A heavy metal tower shield, made from scrap metal. Very unwieldly."
	icon_state = "shield_scraptower"
	item_state = "shield_scraptower"
	shieldbash_brutedamage = 40
	shieldbash_stamdmg = 60
	shield_flags = SHIELD_FLAGS_DEFAULT //no guaranteed kd on bash, sorry
	block_parry_data = /datum/block_parry_data/shield/tower/scrap
	max_integrity = 1500

/datum/block_parry_data/shield/tower/scrap
	block_damage_multiplier = 0.6
	block_stamina_efficiency = 7.5
	block_damage_absorption = 15

/obj/item/shield/riot/tele
	name = "telescopic shield"
	desc = "An advanced riot shield made of lightweight materials that collapses for easy storage."
	icon_state = "teleriot0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	slot_flags = null
	force = 3
	throwforce = 3
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL
	var/active = FALSE

/obj/item/shield/riot/tele/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!active)
		return BLOCK_NONE
	return ..()

/obj/item/shield/riot/tele/can_active_block()
	return ..() && active

/obj/item/shield/riot/tele/attack_self(mob/living/user)
	active = !active
	icon_state = "teleriot[active]"
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, TRUE)
	if(active)
		force = 8
		throwforce = 5
		throw_speed = 2
		w_class = WEIGHT_CLASS_BULKY
		slot_flags = ITEM_SLOT_BACK
		to_chat(user, "<span class='notice'>You extend \the [src].</span>")
	else
		force = 3
		throwforce = 3
		throw_speed = 3
		w_class = WEIGHT_CLASS_NORMAL
		slot_flags = null
		to_chat(user, "<span class='notice'>[src] can now be concealed.</span>")
	add_fingerprint(user)

////////////////
//CODE ARCHIVE//
////////////////
/*
The telescopic shields are legacy and don't fit, but the code might be of interest. Leaving it here.
/obj/item/shield/riot/implant
	name = "telescoping shield implant"
	desc = "A compact, arm-mounted telescopic shield. While nigh-indestructible when powered by a host user, it will eventually overload from damage. Recharges while inside its implant."
	item_state = "metal"
	icon_state = "metal"
	slowdown = 1
	shield_flags = SHIELD_FLAGS_DEFAULT
	max_integrity = 100
	obj_integrity = 100
	can_shatter = FALSE
	item_flags = SLOWS_WHILE_IN_HAND | ITEM_CAN_BLOCK
	var/recharge_timerid
	var/recharge_delay = 15 SECONDS
/// Entirely overriden take_damage. This shouldn't exist outside of an implant (other than maybe christmas).
/obj/item/shield/riot/implant/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir, armour_penetration = 0)
	obj_integrity -= damage_amount
	if(obj_integrity < 0)
		obj_integrity = 0
	if(obj_integrity == 0)
		if(ismob(loc))
			var/mob/living/L = loc
			playsound(src, 'sound/effects/glassbr3.ogg', 100)
			L.visible_message("<span class='boldwarning'>[src] overloads from the damage sustained!</span>")
			L.dropItemToGround(src)			//implant component catch hook will grab it.
/obj/item/shield/riot/implant/Moved()
	. = ..()
	if(istype(loc, /obj/item/organ/cyberimp/arm/shield))
		recharge_timerid = addtimer(CALLBACK(src, .proc/recharge), recharge_delay, flags = TIMER_STOPPABLE)
	else		//extending
		if(recharge_timerid)
			deltimer(recharge_timerid)
			recharge_timerid = null
/obj/item/shield/riot/implant/proc/recharge()
	if(obj_integrity == max_integrity)
		return
	obj_integrity = max_integrity
	if(ismob(loc.loc))		//cyberimplant.user
		to_chat(loc, "<span class='notice'>[src] has recharged its reinforcement matrix and is ready for use!</span>")
	*/
