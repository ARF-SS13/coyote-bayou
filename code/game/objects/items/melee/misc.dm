/obj/item/melee/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_martial_melee_block())
		target.visible_message("<span class='danger'>[target.name] blocks [src] and twists [user]'s arm behind [user.p_their()] back!</span>",
					"<span class='userdanger'>You block the attack!</span>")
		user.Stun(40)
		return TRUE

/obj/item/melee/chainofcommand
	name = "chain of command"
	desc = "A tool used by great men to placate the frothing masses."
	icon_state = "chain"
	item_state = "chain"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 14
	throwforce = 10
	wound_bonus = 15
	bare_wound_bonus = 10
	max_reach = 2
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/weapons/chainhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/chainofcommand/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is strangling [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (OXYLOSS)

/obj/item/melee/chainofcommand/fake
	name = "kinky whip"
	desc = "An imitation whip made for erotic roleplay. Still stings, but not much of a real weapon."
	force = 2
	throwforce = 2
	wound_bonus = 2
	bare_wound_bonus = 2

/obj/item/melee/synthetic_arm_blade
	name = "synthetic arm blade"
	desc = "A grotesque blade that on closer inspection seems made of synthetic flesh, it still feels like it would hurt very badly as a weapon."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	force = 20
	throwforce = 10
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "impaled", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	total_mass = TOTAL_MASS_HAND_REPLACEMENT

/obj/item/melee/synthetic_arm_blade/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 80) //very imprecise

/obj/item/melee/sabre
	name = "officer's sabre"
	desc = "An elegant weapon, its monomolecular edge is capable of cutting through flesh and bone with ease."
	icon_state = "sabre"
	item_state = "sabre"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	force = 18
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	armour_penetration = 0.95
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	custom_materials = list(/datum/material/iron = 1000)
	total_mass = 3.4
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/captain_saber

/datum/block_parry_data/captain_saber
	parry_time_windup = 0.5
	parry_time_active = 4
	parry_time_spindown = 1
	parry_time_perfect = 0.75
	parry_time_perfect_leeway = 0.75
	parry_imperfect_falloff_percent = 30
	parry_efficiency_perfect = 100
	parry_failed_stagger_duration = 3 SECONDS
	parry_failed_clickcd_duration = 2 SECONDS

/obj/item/melee/sabre/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 95, 5) //fast and effective, but as a sword, it might damage the results.
	AddElement(/datum/element/sword_point)

/obj/item/melee/sabre/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(attack_type & ATTACK_TYPE_PROJECTILE)		// Don't bring a sword to a gunfight.
		return BLOCK_NONE
	return ..()

/obj/item/melee/sabre/on_exit_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, 1)
	..()

/obj/item/melee/sabre/on_enter_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, 1)
	..()

/obj/item/melee/sabre/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "sabre")

/obj/item/melee/sabre/get_worn_belt_overlay(icon_file)
	return mutable_appearance(icon_file, "-sabre")

/obj/item/melee/sabre/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is trying to cut off all [user.p_their()] limbs with [src]! it looks like [user.p_theyre()] trying to commit suicide!</span>")
	var/i = 0
	ADD_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)
	if(iscarbon(user))
		var/mob/living/carbon/Cuser = user
		var/obj/item/bodypart/holding_bodypart = Cuser.get_holding_bodypart_of_item(src)
		var/list/limbs_to_dismember
		var/list/arms = list()
		var/list/legs = list()
		var/obj/item/bodypart/bodypart

		for(bodypart in Cuser.bodyparts)
			if(bodypart == holding_bodypart)
				continue
			if(bodypart.body_part & ARMS)
				arms += bodypart
			else if (bodypart.body_part & LEGS)
				legs += bodypart

		limbs_to_dismember = arms + legs
		if(holding_bodypart)
			limbs_to_dismember += holding_bodypart

		var/speedbase = abs((4 SECONDS) / limbs_to_dismember.len)
		for(bodypart in limbs_to_dismember)
			i++
			addtimer(CALLBACK(src, .proc/suicide_dismember, user, bodypart), speedbase * i)
	addtimer(CALLBACK(src, .proc/manual_suicide, user), (5 SECONDS) * i)
	return MANUAL_SUICIDE

/obj/item/melee/sabre/proc/suicide_dismember(mob/living/user, obj/item/bodypart/affecting)
	if(!QDELETED(affecting) && affecting.dismemberable && affecting.owner == user && !QDELETED(user))
		playsound(user, hitsound, 25, 1)
		affecting.dismember(BRUTE)
		user.adjustBruteLoss(20)

/obj/item/melee/sabre/proc/manual_suicide(mob/living/user, originally_nodropped)
	if(!QDELETED(user))
		user.adjustBruteLoss(200)
		user.death(FALSE)
	REMOVE_TRAIT(src, TRAIT_NODROP, SABRE_SUICIDE_TRAIT)

/obj/item/melee/rapier
	name = "plastitanium rapier"
	desc = "A thin blade made of plastitanium with a diamond tip. It appears to be coated in a persistent layer of an unknown substance."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "rapier"
	item_state = "rapier"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 15
	throwforce = 25
	armour_penetration = 1
	flags_1 = CONDUCT_1
	obj_flags = UNIQUE_RENAME
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_POINTY //It cant be sharpend cook -_-
	attack_verb = list("stabs", "punctures", "pierces", "pokes")
	hitsound = 'sound/weapons/rapierhit.ogg'
	total_mass = 0.4
	item_flags = ITEM_CAN_PARRY | NEEDS_PERMIT
	block_parry_data = /datum/block_parry_data/traitor_rapier

// Fast, efficient parry.
/datum/block_parry_data/traitor_rapier
	parry_time_windup = 0.5
	parry_time_active = 5
	parry_time_spindown = 0
	parry_time_active_visual_override = 3
	parry_time_spindown_visual_override = 2
	parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK | PARRY_LOCK_ATTACKING
	parry_time_perfect = 0
	parry_time_perfect_leeway = 3
	parry_time_perfect_leeway_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 1
	)
	parry_imperfect_falloff_percent_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 50				// useless after 3rd decisecond
	)
	parry_imperfect_falloff_percent = 30
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 1
	parry_efficiency_perfect = 100
	parry_data = list(
		PARRY_DISARM_ATTACKER = TRUE,
		PARRY_KNOCKDOWN_ATTACKER = 10
	)
	parry_failed_stagger_duration = 2 SECONDS
	parry_failed_clickcd_duration = CLICK_CD_RANGE
	parry_cooldown = 0

/obj/item/melee/rapier/active_parry_reflex_counter(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, list/return_list, parry_efficiency, list/effect_text)
	. = ..()
	if((attack_type & ATTACK_TYPE_PROJECTILE) && (parry_efficiency >= 100))
		. |= BLOCK_SHOULD_REDIRECT
		return_list[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT

/obj/item/melee/rapier/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 65, 0)

/obj/item/melee/rapier/on_exit_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/rapier/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, 1)
	..()

/obj/item/melee/rapier/on_enter_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/rapier/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, 1)
	..()

/obj/item/melee/rapier/get_belt_overlay()
	return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "rapier")

/obj/item/melee/rapier/get_worn_belt_overlay(icon_file)
	return mutable_appearance(icon_file, "-rapier")

/obj/item/melee/rapier/attack(mob/living/target, mob/living/user)
	. = ..()
	if(iscarbon(target))
		if(HAS_TRAIT(user, TRAIT_PACIFISM))
			visible_message("<span class='warning'>[user] gently taps [target] with [src].</span>",null,null,COMBAT_MESSAGE_RANGE)
		log_combat(user, target, "slept", src)
		var/mob/living/carbon/H = target
		H.Dizzy(10)
		H.adjustStaminaLoss(30)
		if(CHECK_STAMCRIT(H) != NOT_STAMCRIT)
			H.Sleeping(180)





/obj/item/melee/classic_baton/telescopic/contractor_baton
	name = "contractor baton"
	desc = "A compact, specialised baton assigned to Syndicate contractors. Applies light electrical shocks to targets."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "contractor_baton_0"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	item_state = null
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 5
	cooldown = 20
	stam_dmg = 45	//4 hit stamcrit
	affect_silicon = TRUE
	on_sound = 'sound/weapons/contractorbatonextend.ogg'
	on_stun_sound = 'sound/effects/contractorbatonhit.ogg'
	on_icon_state = "contractor_baton_1"
	off_icon_state = "contractor_baton_0"
	on_item_state = "contractor_baton"
	force_on = 16
	force_off = 5
	weight_class_on = WEIGHT_CLASS_NORMAL

/obj/item/melee/classic_baton/telescopic/contractor_baton/get_wait_description()
	return "<span class='danger'>The baton is still charging!</span>"

/obj/item/melee/classic_baton/telescopic/contractor_baton/additional_effects_carbon(mob/living/target, mob/living/user)
	target.Jitter(20)
	target.apply_effect(EFFECT_STUTTER, 20)
	target.apply_status_effect(/datum/status_effect/electrostaff, 30)	//knockdown, disarm, and slowdown, the unholy triumvirate of stam combat

/obj/item/melee/supermatter_sword
	name = "supermatter sword"
	desc = "In a station full of bad ideas, this might just be the worst."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "supermatter_sword"
	item_state = "supermatter_sword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = null
	w_class = WEIGHT_CLASS_BULKY
	force = 0.001
	armour_penetration = 1
	var/obj/machinery/power/supermatter_crystal/shard
	var/balanced = 1
	force_string = "INFINITE"

/obj/item/melee/supermatter_sword/Initialize()
	. = ..()
	shard = new /obj/machinery/power/supermatter_crystal(src)
	qdel(shard.countdown)
	shard.countdown = null
	START_PROCESSING(SSobj, src)
	visible_message("<span class='warning'>[src] appears, balanced ever so perfectly on its hilt. This isn't ominous at all.</span>")

/obj/item/melee/supermatter_sword/process()
	if(balanced || throwing || ismob(src.loc) || isnull(src.loc))
		return
	if(!isturf(src.loc))
		var/atom/target = src.loc
		forceMove(target.loc)
		consume_everything(target)
	else
		var/turf/T = get_turf(src)
		if(!isspaceturf(T))
			shard.consume_turf(T)

/obj/item/melee/supermatter_sword/afterattack(target, mob/user, proximity_flag)
	. = ..()
	if(user && target == user)
		user.dropItemToGround(src)
	if(proximity_flag)
		consume_everything(target)

/obj/item/melee/supermatter_sword/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	if(ismob(hit_atom))
		var/mob/M = hit_atom
		if(src.loc == M)
			M.dropItemToGround(src)
	consume_everything(hit_atom)

/obj/item/melee/supermatter_sword/pickup(user)
	..()
	balanced = 0

/obj/item/melee/supermatter_sword/ex_act(severity, target)
	visible_message("<span class='danger'>The blast wave smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='italics'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything()

/obj/item/melee/supermatter_sword/acid_act()
	visible_message("<span class='danger'>The acid smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='italics'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything()

/obj/item/melee/supermatter_sword/bullet_act(obj/item/projectile/P)
	visible_message("<span class='danger'>[P] smacks into [src] and rapidly flashes to ash.</span>",\
	"<span class='italics'>You hear a loud crack as you are washed with a wave of heat.</span>")
	consume_everything(P)
	return BULLET_ACT_HIT

/obj/item/melee/supermatter_sword/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] touches [src]'s blade. It looks like [user.p_theyre()] tired of waiting for the radiation to kill [user.p_them()]!</span>")
	user.dropItemToGround(src, TRUE)
	shard.Bumped(user)

/obj/item/melee/supermatter_sword/proc/consume_everything(target)
	if(isnull(target))
		shard.Consume()
	else if(!isturf(target))
		shard.Bumped(target)
	else
		shard.consume_turf(target)

/obj/item/melee/supermatter_sword/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/roastingstick
	name = "advanced roasting stick"
	desc = "A telescopic roasting stick with a miniature shield generator designed to ensure entry into various high-tech shielded cooking ovens and firepits."
	icon_state = "roastingstick_0"
	item_state = "null"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	attack_verb = list("hit", "poked")
	var/obj/item/reagent_containers/food/snacks/sausage/held_sausage
	var/static/list/ovens
	var/on = FALSE
	var/datum/beam/beam
	total_mass = 2.5

/obj/item/melee/roastingstick/Initialize()
	. = ..()
	if (!ovens)
		ovens = typecacheof(list(/obj/singularity, /obj/machinery/power/supermatter_crystal, /obj/structure/bonfire, /obj/structure/destructible/clockwork/massive/ratvar))

/obj/item/melee/roastingstick/attack_self(mob/user)
	on = !on
	if(on)
		extend(user)
	else
		if (held_sausage)
			to_chat(user, "<span class='warning'>You can't retract [src] while [held_sausage] is attached!</span>")
			return
		retract(user)

	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	add_fingerprint(user)

/obj/item/melee/roastingstick/attackby(atom/target, mob/user)
	..()
	if (istype(target, /obj/item/reagent_containers/food/snacks/sausage))
		if (!on)
			to_chat(user, "<span class='warning'>You must extend [src] to attach anything to it!</span>")
			return
		if (held_sausage)
			to_chat(user, "<span class='warning'>[held_sausage] is already attached to [src]!</span>")
			return
		if (user.transferItemToLoc(target, src))
			held_sausage = target
		else
			to_chat(user, "<span class='warning'>[target] doesn't seem to want to get on [src]!</span>")
	update_icon()

/obj/item/melee/roastingstick/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	..()
	if (held_sausage)
		user.put_in_hands(held_sausage)
		held_sausage = null
	update_icon()

/obj/item/melee/roastingstick/update_overlays()
	. = ..()
	if (held_sausage)
		. += mutable_appearance(icon, "roastingstick_sausage")

/obj/item/melee/roastingstick/proc/extend(user)
	to_chat(user, "<span class ='warning'>You extend [src].</span>")
	icon_state = "roastingstick_1"
	item_state = "nullrod"
	w_class = WEIGHT_CLASS_BULKY

/obj/item/melee/roastingstick/proc/retract(user)
	to_chat(user, "<span class ='notice'>You collapse [src].</span>")
	icon_state = "roastingstick_0"
	item_state = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/roastingstick/handle_atom_del(atom/target)
	if (target == held_sausage)
		held_sausage = null
		update_icon()

/obj/item/melee/roastingstick/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if (!on)
		return
	if (is_type_in_typecache(target, ovens))
		if (held_sausage && held_sausage.roasted)
			to_chat("Your [held_sausage] has already been cooked.")
			return
		if (istype(target, /obj/singularity) && get_dist(user, target) < 10)
			to_chat(user, "You send [held_sausage] towards [target].")
			playsound(src, 'sound/items/rped.ogg', 50, 1)
			beam = user.Beam(target,icon_state="rped_upgrade",time=100)
		else if (user.Adjacent(target))
			to_chat(user, "You extend [src] towards [target].")
			playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
		else
			return
		if(do_after(user, 100, target = user))
			finish_roasting(user, target)
		else
			QDEL_NULL(beam)
			playsound(src, 'sound/weapons/batonextend.ogg', 50, 1)

/obj/item/melee/roastingstick/proc/finish_roasting(user, atom/target)
	to_chat(user, "You finish roasting [held_sausage]")
	playsound(src,'sound/items/welder2.ogg',50,1)
	held_sausage.add_atom_colour(rgb(103,63,24), FIXED_COLOUR_PRIORITY)
	held_sausage.name = "[target.name]-roasted [held_sausage.name]"
	held_sausage.desc = "[held_sausage.desc] It has been cooked to perfection on \a [target]."
	update_icon()

/obj/item/melee/cleric_mace
	name = "cleric mace"
	desc = "The grandson of the club, yet the grandfather of the baseball bat. Most notably used by holy orders in days past."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "mace_greyscale"
	item_state = "mace_greyscale"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS //Material type changes the prefix as well as the color.
	custom_materials = list(/datum/material/iron = 12000)  //Defaults to an Iron Mace.
	slot_flags = ITEM_SLOT_BELT
	force = 14
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 8
	block_chance = 10
	armour_penetration = 1
	attack_verb = list("smacked", "struck", "cracked", "beaten")
	var/overlay_state = "mace_handle"
	var/mutable_appearance/overlay

/obj/item/melee/cleric_mace/Initialize()
	. = ..()
	overlay = mutable_appearance(icon, overlay_state)
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
