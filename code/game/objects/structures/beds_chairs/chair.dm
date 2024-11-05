/obj/structure/chair
	name = "chair"
	desc = "You sit in this. Either by will or force."
	icon = 'icons/fallout/objects/furniture/chairs_and_beds.dmi'
	icon_state = "chair"
	anchored = TRUE
	can_buckle = 1
	buckle_lying = 0 //you sit in a chair, not lay
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 0.1
	custom_materials = list(/datum/material/iron = 2000)
	var/buildstacktype = /obj/item/stack/sheet/metal
	var/buildstackamount = 1
	var/item_chair = /obj/item/chair // if null it can't be picked up
	plane = MOB_PLANE
	layer = OBJ_LAYER

/obj/structure/chair/examine(mob/user)
	. = ..()
	. += span_notice("It's held together by a couple of <b>bolts</b>.")
	if(!has_buckled_mobs())
		. += span_notice("Drag your sprite to sit in it.")

/obj/structure/chair/Initialize()
	. = ..()
	if(!anchored)	//why would you put these on the shuttle?
		addtimer(CALLBACK(src,PROC_REF(RemoveFromLatejoin)), 0)

/obj/structure/chair/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/simple_rotation,ROTATION_ALTCLICK | ROTATION_CLOCKWISE, CALLBACK(src,PROC_REF(can_user_rotate),CALLBACK(src),PROC_REF(can_be_rotated),null))

/obj/structure/chair/proc/can_be_rotated(mob/user)
	return TRUE

/obj/structure/chair/proc/can_user_rotate(mob/user)
	var/mob/living/L = user

	if(istype(L))
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			return FALSE
		else
			return TRUE
	else if(isobserver(user) && CONFIG_GET(flag/ghost_interaction))
		return TRUE
	return FALSE

/obj/structure/chair/Destroy()
	RemoveFromLatejoin()
	return ..()

/obj/structure/chair/proc/RemoveFromLatejoin()
	SSjob.latejoin_trackers -= src	//These may be here due to the arrivals shuttle

/obj/structure/chair/deconstruct()
	// If we have materials, and don't have the NOCONSTRUCT flag
	if(!(flags_1 & NODECONSTRUCT_1))
		if(buildstacktype)
			new buildstacktype(loc,buildstackamount)
		else
			for(var/i in custom_materials)
				var/datum/material/M = i
				new M.sheet_type(loc, FLOOR(custom_materials[M] / MINERAL_MATERIAL_AMOUNT, 1))
	..()

/obj/structure/chair/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/chair/narsie_act()
	var/obj/structure/chair/wood/W = new/obj/structure/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/*/obj/structure/chair/ratvar_act()
	var/obj/structure/chair/brass/B = new(get_turf(src))
	B.setDir(dir)
	qdel(src) */

/obj/structure/chair/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/wrench) && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct()
	else if(istype(W, /obj/item/assembly/shock_kit))
		if(!user.temporarilyRemoveItemFromInventory(W))
			return
		var/obj/item/assembly/shock_kit/SK = W
		var/obj/structure/chair/e_chair/E = new /obj/structure/chair/e_chair(src.loc)
		playsound(src.loc, 'sound/items/deconstruct.ogg', 50, 1)
		E.setDir(dir)
		E.part = SK
		SK.forceMove(E)
		SK.master = E
		qdel(src)
	else
		return ..()

/obj/structure/chair/alt_attack_hand(mob/living/user)
	if(Adjacent(user) && istype(user))
		if(!item_chair || !user.can_hold_items() || !has_buckled_mobs() || buckled_mobs.len > 1 || dir != user.dir || flags_1 & NODECONSTRUCT_1)
			return TRUE
		if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
			to_chat(user, span_warning("You can't do that right now!"))
			return TRUE
		if(IS_STAMCRIT(user))
			to_chat(user, span_warning("You're too exhausted for that."))
			return TRUE
		var/mob/living/poordude = buckled_mobs[1]
		if(!istype(poordude))
			return TRUE
		user.visible_message(span_notice("[user] pulls [src] out from under [poordude]."), span_notice("You pull [src] out from under [poordude]."))
		var/obj/item/chair/C = new item_chair(loc)
		C.set_custom_materials(custom_materials)
		TransferComponents(C)
		user.put_in_hands(C)
		poordude.DefaultCombatKnockdown(20)//rip in peace
		user.adjustStaminaLoss(5)
		unbuckle_all_mobs(TRUE)
		qdel(src)
		return TRUE

/obj/structure/chair/attack_tk(mob/user)
	if(!anchored || has_buckled_mobs() || !isturf(user.loc))
		..()
	else
		setDir(turn(dir,-90))

/obj/structure/chair/proc/handle_rotation(direction)
	handle_layer()
	if(has_buckled_mobs())
		for(var/m in buckled_mobs)
			var/mob/living/buckled_mob = m
			buckled_mob.setDir(direction)

/obj/structure/chair/proc/handle_layer()
	if(has_buckled_mobs() && dir == NORTH)
		plane = MOB_PLANE
		layer = ABOVE_MOB_LAYER
	else
		plane = initial(plane)
		layer = OBJ_LAYER

/obj/structure/chair/post_buckle_mob(mob/living/M)
	. = ..()
	handle_layer()

/obj/structure/chair/post_unbuckle_mob()
	. = ..()
	handle_layer()

/obj/structure/chair/setDir(newdir)
	..()
	handle_rotation(newdir)

// Chair types

////////////////////
// Fallout chairs //
////////////////////

// Settler chair
/obj/structure/chair/wood
	name = "wooden chair"
	desc = "A basic yet sturdy chair made from weathered old wood."
	icon_state = "wooden_chair_settler"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 3
	item_chair = /obj/item/chair/wood

/obj/item/chair/wood
	name = "wooden chair"
	desc = "A basic yet sturdy chair made from weathered old wood."
	icon_state = "wooden_chair_settler_toppled"
	inhand_icon_state = "woodenchair"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	hitsound = 'sound/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/wood
	custom_materials = null
	break_chance = 50

// Simple dining chair
/obj/structure/chair/wood/dining
	desc = "A commonplace dining chair with a faded green cushion."
	icon_state = "wooden_chair"

/obj/item/chair/wood/dining
	desc = "A commonplace dining chair with a faded green cushion."
	icon_state = "wooden_chair_toppled"
	inhand_icon_state = "wooden_chair"
	origin_type = /obj/structure/chair/wood/dining

// Winged wooden chair
/obj/structure/chair/wood/wings
	desc = "An antique wooden chair of distinctive design. Creaky."
	icon_state = "wooden_chair_fine"
	item_chair = /obj/item/chair/wood/wings

/obj/item/chair/wood/wings
	desc = "An antique wooden chair of distinctive design. Creaky."
	icon_state = "wooden_chair_fine_toppled"
	origin_type = /obj/structure/chair/wood/wings

// Fancy wooden chair
/obj/structure/chair/wood/fancy
	icon_state = "wooden_chair_fancy"
	desc = "A well-designed study chair with a faded red cushion."
	item_chair = /obj/item/chair/wood/fancy

/obj/item/chair/wood/fancy
	desc = "A well-designed study chair with a faded red cushion."
	icon_state = "wooden_chair_fancy_toppled"
	inhand_icon_state = "wooden_chair_fancy"
	origin_type = /obj/structure/chair/wood/fancy

// Folding chair
/obj/structure/chair/folding
	icon_state = "folding_chair"
	item_chair = /obj/item/chair/folding

/obj/item/chair/folding
	icon_state = "folding_chair_toppled"
	inhand_icon_state = "folding_chair"
	origin_type = /obj/structure/chair/folding

// Plywood chair
/obj/structure/chair/comfy/plywood
	name = "deckchair"
	desc = "A relaxing plywood deckchair."
	icon_state = "plywood_chair"
	anchored = FALSE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 4

/obj/structure/chair/comfy/throne
	name = "khan throne"
	desc = "An ornate wooden chair padded with fine leather. A symbol of authority."
	icon_state = "throne"
	anchored = TRUE
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	buildstackamount = 4

/obj/structure/chair/comfy/plywood/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs_and_beds.dmi', "plywood_chair_armrest")

// Pre-Fall chair
/obj/structure/chair/comfy/shuttle
	name = "Pre-Fall comfy chair"
	desc = "A comfortable, secure seat in synthetics."
	icon_state = "shuttle_chair"

/obj/structure/chair/comfy/shuttle/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs_and_beds.dmi', "shuttle_chair_armrest")

/obj/structure/chair/comfy/modern
	name = "modern chair"
	desc = "the latest in Pre-Fall chair technology."
	icon_state = "synthetic_chair"
	max_integrity = 250
	buildstacktype = /obj/item/stack/sheet/prefall
	buildstackamount = 2

/obj/structure/chair/comfy/modern/GetArmrest()
	return mutable_appearance('icons/fallout/objects/furniture/chairs_and_beds.dmi', "synthetic_chair_armrest")



// Office chairs
/obj/structure/chair/office
	icon_state = "office_chair"
	anchored = FALSE
	buildstackamount = 5
	item_chair = null
	drag_delay = 0.05 SECONDS //Pulling something on wheels is easy

/obj/structure/chair/office/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/effects/roll.ogg', 100, 1)

/obj/structure/chair/office/light
	icon_state = "office_chair_white"

/obj/structure/chair/office/dark
	icon_state = "office_chair_dark"

// Bar stools
/obj/structure/chair/stool/retro
	name = "bar stool"
	icon = 'icons/fallout/objects/furniture/chairs_and_beds.dmi'
	icon_state = "bar"
	item_chair = /obj/item/chair/stool/retro

/obj/item/chair/stool/retro
	icon_state = "bar_toppled"
	inhand_icon_state = "bar"
	origin_type = /obj/structure/chair/stool/retro

/obj/structure/chair/stool/retro/black
	icon_state = "bar_black"
	item_chair = /obj/item/chair/stool/retro/black

/obj/item/chair/stool/retro/black
	icon_state = "bar_black_toppled"
	inhand_icon_state = "bar_black"
	origin_type = /obj/structure/chair/stool/retro/black

/obj/structure/chair/stool/retro/tan
	name = "bar stool"
	icon_state = "bar_tan"
	item_chair = /obj/item/chair/stool/retro/tan

/obj/item/chair/stool/retro/tan
	icon_state = "bar_tan_toppled"
	inhand_icon_state = "bar_tan"
	origin_type = /obj/structure/chair/stool/retro/tan

/obj/structure/chair/stool/retro/backed
	icon_state = "bar_backed"
	item_chair = /obj/item/chair/stool/retro/backed

/obj/item/chair/stool/retro/backed
	icon_state = "bar_backed_toppled"
	inhand_icon_state = "bar_backed"
	origin_type = /obj/structure/chair/stool/retro/backed

// Comfy chairs
/obj/structure/chair/comfy
	name = "comfy chair"
	desc = "It looks comfy."
	icon_state = "comfychair"
	color = rgb(255,255,255)
	resistance_flags = FLAMMABLE
	max_integrity = 70
	buildstackamount = 2
	item_chair = null
	var/mutable_appearance/armrest

/obj/structure/chair/comfy/Initialize()
	armrest = GetArmrest()
	armrest.layer = ABOVE_MOB_LAYER
	armrest.plane = MOB_PLANE

	return ..()

/obj/structure/chair/comfy/proc/GetArmrest()
	return mutable_appearance('icons/obj/chairs.dmi', "comfychair_armrest")

/obj/structure/chair/comfy/Destroy()
	QDEL_NULL(armrest)
	return ..()

/obj/structure/chair/comfy/post_buckle_mob(mob/living/M)
	. = ..()
	update_armrest()

/obj/structure/chair/comfy/proc/update_armrest()
	if(has_buckled_mobs())
		add_overlay(armrest)
	else
		cut_overlay(armrest)

/obj/structure/chair/comfy/post_unbuckle_mob()
	. = ..()
	update_armrest()

/obj/structure/chair/comfy/brown
	color = COLOR_MAROON

/obj/structure/chair/comfy/beige
	color = COLOR_BROWN

/obj/structure/chair/comfy/teal
	color = COLOR_TEAL

/obj/structure/chair/comfy/black
	color = COLOR_FLOORTILE_GRAY

/obj/structure/chair/comfy/green
	color = COLOR_GREEN_GRAY

/obj/structure/chair/comfy/lime
	color = COLOR_LIME

/obj/structure/chair/comfy/purple
	color = COLOR_PURPLE_GRAY


///Material chair
/obj/structure/chair/greyscale
	icon = 'icons/obj/chairs.dmi'
	icon_state = "chair_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	item_chair = /obj/item/chair/greyscale
	buildstacktype = null //Custom mats handle this

/obj/structure/chair/wood/narsie_act()
	return

/obj/structure/chair/f13foldupchair
	icon = 'icons/obj/chairs.dmi'
	icon_state = "f13foldupchair"
	item_chair = null

/obj/structure/chair/f13chair1
	icon = 'icons/obj/chairs.dmi'
	icon_state = "f13chair1"
	item_chair = null

/obj/structure/chair/f13chair2
	icon = 'icons/obj/chairs.dmi'
	icon_state = "f13chair2"
	item_chair = null

//Stool

/obj/structure/chair/stool
	name = "stool"
	desc = "Apply butt."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "stool"
	can_buckle = 0
	buildstackamount = 1
	item_chair = /obj/item/chair/stool

/obj/structure/chair/stool/narsie_act()
	return

/obj/structure/chair/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(over_object == usr && Adjacent(usr))
		if(!item_chair || !usr.can_hold_items() || has_buckled_mobs() || src.flags_1 & NODECONSTRUCT_1)
			return
		if(!usr.canUseTopic(src, BE_CLOSE, ismonkey(usr)))
			return
		usr.visible_message(span_notice("[usr] grabs \the [src.name]."), span_notice("You grab \the [src.name]."))
		var/obj/item/C = new item_chair(loc)
		C.set_custom_materials(custom_materials)
		TransferComponents(C)
		usr.put_in_hands(C)
		qdel(src)

/obj/structure/chair/stool/bar
	name = "bar stool"
	desc = "It has some unsavory stains on it..."
	icon_state = "bar"
	item_chair = /obj/item/chair/stool/bar

/obj/structure/chair/stool/f13stool
	name = "bar stool"
	desc = "It has some unsavory stains on it..."
	icon_state = "f13stool"
	item_chair = /obj/item/chair/stool/bar

/obj/item/chair/stool/bar
	name = "bar stool"
	icon_state = "bar_toppled"
	inhand_icon_state = "stool_bar"
	origin_type = /obj/structure/chair/stool/bar

/obj/item/chair/wood/modern

/obj/item/chair
	name = "chair"
	desc = "Bar brawl essential."
	icon = 'icons/fallout/objects/furniture/chairs_and_beds.dmi'
	icon_state = "chair_toppled"
	inhand_icon_state = "chair"
	lefthand_file = 'icons/mob/inhands/misc/chairs_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/chairs_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 8
	throwforce = 10
	throw_range = 3
	hitsound = 'sound/items/trayhit1.ogg'
	custom_materials = list(/datum/material/iron = 2000)
	var/break_chance = 5 //Likely hood of smashing the chair.
	var/obj/structure/chair/origin_type = /obj/structure/chair
	item_flags = ITEM_CAN_PARRY | ITEM_CAN_BLOCK
	block_parry_data = /datum/block_parry_data/chair

/obj/item/chair/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE)

/datum/block_parry_data/chair
	block_damage_multiplier = 0.7
	block_stamina_efficiency = 2
	block_stamina_cost_per_second = 1.5
	block_slowdown = 0.5
	block_lock_attacking = FALSE
	block_lock_sprinting = TRUE
	block_start_delay = 1.5
	block_damage_absorption = 7
	block_damage_limit = 20
	block_resting_stamina_penalty_multiplier = 2
	block_projectile_mitigation = 20
	parry_stamina_cost = 5
	parry_time_windup = 1
	parry_time_active = 11
	parry_time_spindown = 2
	parry_time_perfect = 1.5
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 50
	parry_efficiency_perfect = 120
	parry_efficiency_perfect_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 30,
	)
	parry_failed_stagger_duration = 3.5 SECONDS
	parry_data = list(PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5)

/obj/item/chair/narsie_act()
	var/obj/item/chair/wood/W = new/obj/item/chair/wood(get_turf(src))
	W.setDir(dir)
	qdel(src)

/obj/item/chair/attack_self(mob/user)
	plant(user)

/obj/item/chair/proc/plant(mob/user)
	for(var/obj/A in get_turf(loc))
		if(istype(A, /obj/structure/chair))
			to_chat(user, span_danger("There is already a chair here."))
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(user, span_danger("There is already something here."))
			return

	user.visible_message(span_notice("[user] rights \the [src.name]."), span_notice("You right \the [name]."))
	var/obj/structure/chair/C = new origin_type(get_turf(loc))
	C.set_custom_materials(custom_materials)
	TransferComponents(C)
	C.setDir(dir)
	qdel(src)

/obj/item/chair/proc/smash(mob/living/user)
	var/stack_type = initial(origin_type.buildstacktype)
	if(!stack_type)
		return
	var/remaining_mats = initial(origin_type.buildstackamount)
	remaining_mats-- //Part of the chair was rendered completely unusable. It magically dissapears. Maybe make some dirt?
	if(remaining_mats)
		for(var/M=1 to remaining_mats)
			new stack_type(get_turf(loc))
	qdel(src)

/obj/item/chair/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!(attack_type & ATTACK_TYPE_UNARMED))
		return NONE
	return ..()

/obj/item/chair/afterattack(atom/target, mob/living/carbon/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(prob(break_chance))
		user.visible_message(span_danger("[user] smashes [src] to pieces against [target]"))
		if(iscarbon(target))
			var/mob/living/carbon/C = target
			if(C.health < C.maxHealth*0.5)
				C.DefaultCombatKnockdown(20)
		smash(user)

/obj/item/chair/greyscale
	icon = 'icons/obj/chairs.dmi'
	icon_state = "chair_greyscale_toppled"
	inhand_icon_state = "chair_greyscale"
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	origin_type = /obj/structure/chair/greyscale

/obj/item/chair/stool
	name = "stool"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "stool_toppled"
	inhand_icon_state = "stool"
	origin_type = /obj/structure/chair/stool
	break_chance = 0 //It's too sturdy.

//////////////////////////
//Alien(Disco) Stools!////
//////////////////////////

/obj/structure/chair/stool/alien
	name = "alien stool"
	desc = "A hard stool made of advanced alien alloy."
	icon_state = "stoolalien"
	icon = 'icons/obj/abductor.dmi'
	item_chair = /obj/item/chair/stool/alien
	buildstacktype = /obj/item/stack/sheet/mineral/abductor
	buildstackamount = 1

/obj/structure/chair/stool/bar/alien
	name = "alien bar stool"
	desc = "A hard bar stool made of advanced alien alloy."
	icon_state = "baralien"
	icon = 'icons/obj/abductor.dmi'
	item_chair = /obj/item/chair/stool/bar/alien
	buildstacktype = /obj/item/stack/sheet/mineral/abductor
	buildstackamount = 1

/obj/item/chair/stool/alien
	name = "stool"
	icon_state = "stoolalien_toppled"
	inhand_icon_state = "stoolalien"
	icon = 'icons/obj/abductor.dmi'
	origin_type = /obj/structure/chair/stool/alien
	break_chance = 0 //It's too sturdy.

/obj/item/chair/stool/bar/alien
	name = "bar stool"
	icon_state = "baralien_toppled"
	inhand_icon_state = "baralien"
	icon = 'icons/obj/abductor.dmi'
	origin_type = /obj/structure/chair/stool/bar/alien

//////////////////////////
//Brass & Bronze stools!//
//////////////////////////

/* /obj/structure/chair/stool/bar/brass
	name = "brass bar stool"
	desc = "A brass bar stool with red silk for a pillow."
	icon_state = "barbrass"
	item_chair = /obj/item/chair/stool/bar/brass
	buildstacktype = /obj/item/stack/tile/brass
	buildstackamount = 1 */

/obj/structure/chair/stool/bar/bronze
	name = "bronze bar stool"
	desc = "A bronze bar stool with red silk for a pillow."
	icon_state = "barbrass"
	item_chair = /obj/item/chair/stool/bar/bronze
	buildstacktype = /obj/item/stack/sheet/bronze
	buildstackamount = 1

/*/obj/structure/chair/stool/brass
	name = "brass stool"
	desc = "A brass stool with a silk top for comfort."
	icon_state = "stoolbrass"
	item_chair = /obj/item/chair/stool/brass
	buildstacktype = /obj/item/stack/tile/brass
	buildstackamount = 1 */

/obj/structure/chair/stool/bronze
	name = "bronze stool"
	desc = "A bronze stool with a silk top for comfort."
	icon_state = "stoolbrass"
	item_chair = /obj/item/chair/stool/bronze
	buildstacktype = /obj/item/stack/sheet/bronze
	buildstackamount = 1

/*/obj/item/chair/stool/brass
	name = "brass stool"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "stoolbrass_toppled"
	inhand_icon_state = "stoolbrass"
	origin_type = /obj/structure/chair/stool/brass

/obj/item/chair/stool/bar/brass
	name = "brass bar stool"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "barbrass_toppled"
	inhand_icon_state = "stoolbrass_bar"
	origin_type = /obj/structure/chair/stool/bar/brass
*/
/obj/item/chair/stool/bronze
	name = "bronze stool"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "stoolbrass_toppled"
	inhand_icon_state = "stoolbrass"
	origin_type = /obj/structure/chair/stool/bronze

/obj/item/chair/stool/bar/bronze
	name = "bronze bar stool"
	icon = 'icons/obj/chairs.dmi'
	icon_state = "barbrass_toppled"
	inhand_icon_state = "stoolbrass_bar"
	origin_type = /obj/structure/chair/stool/bar/bronze

/////////////////////////////////
//End of Brass & Bronze stools!//
/////////////////////////////////

/obj/item/chair/stool/narsie_act()
	return //sturdy enough to ignore a god

/obj/item/chair/wood/narsie_act()
	return

//Temporary compilation stuff, obsolete

/obj/structure/chair/old
	name = "strange chair"
	desc = "You sit in this. Either by will or force. Looks REALLY uncomfortable."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "chairold"
	item_chair = null

/*/obj/structure/chair/brass
	name = "brass chair"
	desc = "A spinny chair made of brass. It looks uncomfortable."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "brass_chair"
	max_integrity = 150
	buildstacktype = /obj/item/stack/tile/brass
	buildstackamount = 1
	item_chair = null

/obj/structure/chair/brass/ComponentInitialize()
	return //it spins with the power of ratvar, not components.

/obj/structure/chair/brass/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	. = ..()

/obj/structure/chair/brass/process()
	setDir(turn(dir,-90))
	playsound(src, 'sound/effects/servostep.ogg', 50, FALSE)

/obj/structure/chair/brass/ratvar_act()
	return

/obj/structure/chair/brass/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!IS_PROCESSING(SSprocessing, src))
		user.visible_message(span_notice("[user] spins [src] around, and Ratvarian technology keeps it spinning FOREVER."), \
		span_notice("Automated spinny chairs. The pinnacle of Ratvarian technology."))
		START_PROCESSING(SSfastprocess, src)
	else
		user.visible_message(span_notice("[user] stops [src]'s uncontrollable spinning."), \
		span_notice("You grab [src] and stop its wild spinning."))
		STOP_PROCESSING(SSfastprocess, src)
	return TRUE */

/obj/structure/chair/bronze
	name = "brass chair"
	desc = "A spinny chair made of bronze. It has little cogs for wheels!"
	anchored = FALSE
	icon = 'icons/obj/chairs.dmi'
	icon_state = "brass_chair"
	buildstacktype = /obj/item/stack/sheet/bronze
	buildstackamount = 1
	item_chair = null

/obj/structure/chair/bronze/Moved()
	. = ..()
	if(has_gravity())
		playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 50, TRUE)



/obj/structure/chair/booth
	name = "single booth"
	desc = "A lone-some diner-styled booth."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "booth_single"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	item_chair = null
	var/mutable_appearance/overlay

/obj/structure/chair/booth/proc/update_overlay()
		add_overlay(overlay)

/obj/structure/chair/booth/Initialize()
	overlay = GetOverlay()
	overlay.layer = ABOVE_ALL_MOB_LAYER
	overlay.plane = MOB_PLANE
	return ..()

/obj/structure/chair/booth/Destroy()
	QDEL_NULL(overlay)
	return ..()

/obj/structure/chair/booth/proc/GetOverlay()
	return mutable_appearance('icons/obj/chairs.dmi', "booth_single_overlay")

/obj/structure/chair/left
	name = "booth"
	desc = "A diner-styled end booth."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "booth_leftend"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	item_chair = null
	var/mutable_appearance/overlay

/obj/structure/chair/left/proc/update_overlay()
		add_overlay(overlay)

/obj/structure/chair/left/Initialize()
	overlay = GetOverlay()
	overlay.layer = ABOVE_ALL_MOB_LAYER
	overlay.plane = MOB_PLANE
	return ..()

/obj/structure/chair/left/Destroy()
	QDEL_NULL(overlay)
	return ..()

/obj/structure/chair/left/proc/GetOverlay()
	return mutable_appearance('icons/obj/chairs.dmi', "booth_leftend_overlay")

/obj/structure/chair/west_middle
	name = "booth"
	desc = "A diner-styled end booth."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "booth_west_middle"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	item_chair = null
	var/mutable_appearance/overlay

/obj/structure/chair/left/Initialize()
	overlay = GetOverlay()
	overlay.layer = ABOVE_ALL_MOB_LAYER
	overlay.plane = MOB_PLANE
	return ..()

/obj/structure/chair/left/Destroy()
	QDEL_NULL(overlay)
	return ..()

/obj/structure/chair/middle
	name = "booth"
	desc = "A diner-styled middle booth."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "booth_middle"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	item_chair = null
	var/mutable_appearance/overlay

/obj/structure/chair/middle/proc/update_overlay()
		add_overlay(overlay)

/obj/structure/chair/middle/Initialize()
	overlay = GetOverlay()
	overlay.layer = ABOVE_ALL_MOB_LAYER
	overlay.plane = MOB_PLANE
	return ..()

/obj/structure/chair/middle/Destroy()
	QDEL_NULL(overlay)
	return ..()

/obj/structure/chair/middle/proc/GetOverlay()
	return mutable_appearance('icons/obj/chairs.dmi', "booth_middle_overlay")

/obj/structure/chair/right
	name = "booth"
	desc = "A diner-styled end booth."
	icon = 'icons/obj/chairs.dmi'
	icon_state = "booth_rightend"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	item_chair = null
	var/mutable_appearance/overlay

/obj/structure/chair/right/proc/update_overlay()
		add_overlay(overlay)

/obj/structure/chair/right/Initialize()
	overlay = GetOverlay()
	overlay.layer = ABOVE_ALL_MOB_LAYER
	overlay.plane = MOB_PLANE
	return ..()

/obj/structure/chair/right/Destroy()
	QDEL_NULL(overlay)
	return ..()

/obj/structure/chair/right/proc/GetOverlay()
	return mutable_appearance('icons/obj/chairs.dmi', "booth_rightend_overlay")

// Modern TG Chairs
/obj/structure/chair/metal
	name = "metal chair"
	icon_state = "chair_metal"
	item_chair = /obj/item/chair/metal // if null it can't be picked up

/obj/item/chair/metal
	name = "metal chair"
	desc = "A basic yet sturdy chair made from metal."
	icon_state = "chair_metal_toppled"
	inhand_icon_state = "chair"
	max_integrity = 70
	hitsound = 'sound/weapons/genhit1.ogg'
	origin_type = /obj/structure/chair/metal
	custom_materials = null
	break_chance = 50
