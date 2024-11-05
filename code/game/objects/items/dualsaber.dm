/*
 * Double-Bladed Energy Swords - Cheridan
 */
/obj/item/dualsaber
	icon_state = "dualsaber0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "double-bladed energy sword"
	desc = "Handle with care."
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	item_flags = SLOWS_WHILE_IN_HAND
	var/w_class_on = WEIGHT_CLASS_BULKY
	hitsound = "swing_hit"
	var/hitsound_on = 'sound/weapons/blade1.ogg'
	var/saber_color = "green"
	light_system = MOVABLE_LIGHT
	light_range = 6 //TWICE AS BRIGHT AS A REGULAR ESWORD
	light_color = "#00ff00"//green
	light_on = FALSE
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	wound_bonus = -110
	bare_wound_bonus = 20
	block_parry_data = /datum/block_parry_data/dual_esword
	block_chance = 60
	var/hacked = FALSE
	/// Can this reflect all energy projectiles?
	var/can_reflect = TRUE
	var/list/possible_colors = list("red", "blue", "green", "purple")
	var/list/rainbow_colors = list(LIGHT_COLOR_RED, LIGHT_COLOR_GREEN, LIGHT_COLOR_LIGHT_CYAN, LIGHT_COLOR_LAVENDER)
	var/spinnable = TRUE
	total_mass = 0.4 //Survival flashlights typically weigh around 5 ounces.
	var/total_mass_on = 3.4
	var/slowdown_wielded = 0

/datum/block_parry_data/dual_esword // please run at the man going apeshit with his funny doublesword
	can_block_directions = BLOCK_DIR_NORTH | BLOCK_DIR_NORTHEAST | BLOCK_DIR_NORTHWEST | BLOCK_DIR_WEST | BLOCK_DIR_EAST
	block_damage_absorption = 2
	block_damage_multiplier = 0.15
	block_damage_multiplier_override = list(
		ATTACK_TYPE_MELEE = 0.25
	)
	block_start_delay = 0		// instantaneous block
	block_stamina_cost_per_second = 2.5
	block_stamina_efficiency = 3
	block_lock_sprinting = TRUE
	// no attacking while blocking
	block_lock_attacking = TRUE
	block_projectile_mitigation = 85
	// more efficient vs projectiles
	block_stamina_efficiency_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 6
	)

	parry_time_windup = 0
	parry_time_active = 8
	parry_time_spindown = 0
	// we want to signal to players the most dangerous phase, the time when automatic counterattack is a thing.
	parry_time_windup_visual_override = 1
	parry_time_active_visual_override = 3
	parry_time_spindown_visual_override = 4
	parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK		// esword users can attack while parrying.
	parry_time_perfect = 2		// first ds isn't perfect
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 10
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 25		// VERY generous
	parry_failed_stagger_duration = 3 SECONDS
	parry_failed_clickcd_duration = CLICK_CD_MELEE

/obj/item/dualsaber/active_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return, override_direction)
	if((attack_type & ATTACK_TYPE_PROJECTILE) && is_energy_reflectable_projectile(object))
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_RETURN_TO_SENDER
		return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT
	return ..()

/obj/item/dualsaber/on_active_parry(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, list/block_return, parry_efficiency, parry_time)
	. = ..()
	if(parry_efficiency >= 90)		// perfect parry
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_RETURN_TO_SENDER
		. |= BLOCK_SHOULD_REDIRECT

/obj/item/dualsaber/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD,PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD,PROC_REF(on_unwield))

/obj/item/dualsaber/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=3, force_wielded=34, \
					wieldsound='sound/weapons/saberon.ogg', unwieldsound='sound/weapons/saberoff.ogg')

/obj/item/dualsaber/Initialize()
	. = ..()
	if(LAZYLEN(possible_colors))
		saber_color = pick(possible_colors)
		switch(saber_color)
			if("red")
				set_light_color(LIGHT_COLOR_RED)
			if("green")
				set_light_color(LIGHT_COLOR_GREEN)
			if("blue")
				set_light_color(LIGHT_COLOR_LIGHT_CYAN)
			if("purple")
				set_light_color(LIGHT_COLOR_LAVENDER)

/// Triggered on wield of two handed item
/// Specific hulk checks due to reflection chance for balance issues and switches hitsounds.
/obj/item/dualsaber/proc/on_wield(obj/item/source, mob/living/carbon/user)
	if(user.has_dna() && user.dna.check_mutation(HULK))
		to_chat(user, span_warning("You lack the grace to wield this!"))
		return COMPONENT_TWOHANDED_BLOCK_WIELD
	wielded = TRUE
	sharpness = SHARP_EDGED
	w_class = w_class_on
	total_mass = total_mass_on
	hitsound = 'sound/weapons/blade1.ogg'
	slowdown += slowdown_wielded
	START_PROCESSING(SSobj, src)
	set_light_on(TRUE)
	AddElement(/datum/element/sword_point)
	item_flags |= (ITEM_CAN_BLOCK|ITEM_CAN_PARRY)

/// Triggered on unwield of two handed item
/// switch hitsounds
/obj/item/dualsaber/proc/on_unwield(obj/item/source, mob/living/carbon/user)
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	total_mass = initial(total_mass)
	wielded = FALSE
	hitsound = "swing_hit"
	slowdown_wielded -= slowdown_wielded
	STOP_PROCESSING(SSobj, src)
	set_light_on(FALSE)
	RemoveElement(/datum/element/sword_point)
	item_flags &= ~(ITEM_CAN_BLOCK|ITEM_CAN_PARRY)

/obj/item/dualsaber/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/dualsaber/update_icon_state()
	if(wielded)
		icon_state = "dualsaber[saber_color][wielded]"
	else
		icon_state = "dualsaber0"
	clean_blood()

/obj/item/dualsaber/attack(mob/target, mob/living/carbon/human/user)
	if(user.has_dna() && user.dna.check_mutation(HULK))
		to_chat(user, span_warning("You grip the blade too hard and accidentally drop it!"))
		user.dropItemToGround(src)
		return
	..()
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && (wielded) && prob(40))
		impale(user)
		return
	if(spinnable && (wielded) && prob(50))
		INVOKE_ASYNC(src,PROC_REF(jedi_spin), user)

/obj/item/dualsaber/proc/jedi_spin(mob/living/user)
	for(var/i in list(NORTH,SOUTH,EAST,WEST,EAST,SOUTH,NORTH,SOUTH,EAST,WEST,EAST,SOUTH))
		if(QDELETED(user) || user.incapacitated())
			return
		user.setDir(i)
		if(i == WEST)
			user.SpinAnimation(7, 1)
		sleep(1)

/obj/item/dualsaber/proc/impale(mob/living/user)
	to_chat(user, span_warning("You twirl around a bit before losing your balance and impaling yourself on [src]."))
	if (force)
		user.take_bodypart_damage(20,25)
	else
		user.adjustStaminaLoss(25)

/obj/item/dualsaber/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!wielded)
		return NONE
	if(can_reflect && is_energy_reflectable_projectile(object) && (attack_type & ATTACK_TYPE_PROJECTILE))
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_RETURN_TO_SENDER			//no you
		return BLOCK_SHOULD_REDIRECT | BLOCK_SUCCESS | BLOCK_REDIRECTED
	return ..()

/obj/item/dualsaber/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)  //In case thats just so happens that it is still activated on the groud, prevents hulk from picking it up
	if(wielded)
		to_chat(user, span_warning("You can't pick up such dangerous item with your meaty hands without losing fingers, better not to!"))
		return 1

/obj/item/dualsaber/process()
	if(wielded)
		if(hacked)
			rainbow_process()
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/dualsaber/proc/rainbow_process()
	light_color = pick(rainbow_colors)

/obj/item/dualsaber/ignition_effect(atom/A, mob/user)
	// same as /obj/item/melee/transforming/energy, mostly
	if(!wielded)
		return ""
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [user.p_their()] nose"
	. = span_warning("[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.")
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)
	// Light your candles while spinning around the room
	if(spinnable)
		INVOKE_ASYNC(src,PROC_REF(jedi_spin), user)

/obj/item/dualsaber/green
	possible_colors = list("green")

/obj/item/dualsaber/red
	possible_colors = list("red")

/obj/item/dualsaber/blue
	possible_colors = list("blue")

/obj/item/dualsaber/purple
	possible_colors = list("purple")

/obj/item/dualsaber/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/multitool))
		if(!hacked)
			hacked = TRUE
			to_chat(user, span_warning("2XRNBW_ENGAGE"))
			saber_color = "rainbow"
			update_icon()
		else
			to_chat(user, span_warning("It's starting to look like a triple rainbow - no, nevermind."))
	else
		return ..()

/////////////////////////////////////////////////////
//	HYPEREUTACTIC Blades	/////////////////////////
/////////////////////////////////////////////////////

/obj/item/dualsaber/hypereutactic
	icon = 'icons/obj/1x2.dmi'
	icon_state = "hypereutactic"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_icon_state = "hypereutactic"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "hypereutactic blade"
	desc = "A supermassive weapon envisioned to cleave the very fabric of space and time itself in twain, the hypereutactic blade dynamically flash-forges a hypereutactic crystaline nanostructure capable of passing through most known forms of matter like a hot knife through butter."
	force = 7
	hitsound_on = 'sound/weapons/nebhit.ogg'
	light_color = "#37FFF7"
	rainbow_colors = list("#FF0000", "#FFFF00", "#00FF00", "#00FFFF", "#0000FF","#FF00FF", "#3399ff", "#ff9900", "#fb008b", "#9800ff", "#00ffa3", "#ccff00")
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "destroyed", "ripped", "devastated", "shredded")
	spinnable = FALSE
	total_mass_on = 4
	slowdown_wielded = 1

/obj/item/dualsaber/hypereutactic/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=7, force_wielded=60, \
					wieldsound='sound/weapons/nebon.ogg', unwieldsound='sound/weapons/nebhit.ogg')
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/dualsaber/hypereutactic/update_icon_state()
	return

/obj/item/dualsaber/hypereutactic/update_overlays()
	. = ..()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "hypereutactic_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "hypereutactic_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	. += gem_overlay

	if(wielded)
		. += blade_overlay

	clean_blood()

/obj/item/dualsaber/hypereutactic/AltClick(mob/living/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, FALSE) || hacked)
		return
	if(user.incapacitated(allow_crit = TRUE) || !istype(user))
		to_chat(user, span_warning("You can't do that right now!"))
		return
	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",light_color) as color|null
		if(!energy_color_input || !user.canUseTopic(src, BE_CLOSE, FALSE) || hacked)
			return
		set_light_color(sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1))
		update_icon()
	return TRUE

/obj/item/dualsaber/hypereutactic/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(isinhands)
		var/mutable_appearance/gem_inhand = mutable_appearance(icon_file, "hypereutactic_gem")
		gem_inhand.color = light_color
		. += gem_inhand
		if(wielded)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "hypereutactic_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/dualsaber/hypereutactic/examine(mob/user)
	. = ..()
	if(!hacked)
		. += span_notice("Alt-click to recolor it.")

/obj/item/dualsaber/hypereutactic/rainbow_process()
	. = ..()
	update_icon()

/obj/item/dualsaber/hypereutactic/chaplain
	name = "divine lightblade"
	desc = "A giant blade of bright and holy light, said to cut down the wicked with ease."
	force = 5 // Just a hilt in base mode.
	block_parry_data = /datum/block_parry_data/chaplain
	var/chaplain_spawnable = TRUE
	can_reflect = FALSE
	obj_flags = UNIQUE_RENAME

/datum/block_parry_data/chaplain
	parry_stamina_cost = 12
	parry_time_windup = 2
	parry_time_active = 5
	parry_time_spindown = 3
	// parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK
	parry_time_perfect = 1
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 80
	parry_efficiency_perfect = 120
	parry_efficiency_perfect_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 30,
	)
	parry_failed_stagger_duration = 3 SECONDS
	parry_failed_clickcd_duration = 2 SECONDS

// Fifty seems like alot, given its high parry chance and the fact it works like a light, but it has the huge disadvantage for a null rod weapon by being locked and unchangeable after creation.
// It also is hard locked in being 2 handed only, as its 1 hand deals only 5 damage.
/obj/item/dualsaber/hypereutactic/chaplain/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=50, \
					wieldsound='sound/weapons/nebon.ogg', unwieldsound='sound/weapons/nebhit.ogg')
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)
