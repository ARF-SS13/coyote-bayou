/obj/item/melee/transforming
	sharpness = SHARP_EDGED
	var/active = FALSE
	var/force_on = 30 //force when active
	var/faction_bonus_force = 0 //Bonus force dealt against certain factions
	var/reach_on = 1
	var/throwforce_on = 20
	var/icon_state_on = "axe1"
	var/hitsound_on = 'sound/weapons/blade1.ogg'
	var/list/attack_verb_on = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	var/list/attack_verb_off = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	w_class = WEIGHT_CLASS_SMALL
	var/bonus_active = FALSE //If the faction damage bonus is active
	var/list/nemesis_factions //Any mob with a faction that exists in this list will take bonus damage/effects
	var/w_class_on = WEIGHT_CLASS_BULKY
	var/clumsy_check = TRUE
	var/total_mass_on //Total mass in ounces when transformed. Primarily for balance purposes. Don't think about it too hard.

/obj/item/melee/transforming/Initialize()
	. = ..()
	if(active)
		if(attack_verb_on.len)
			attack_verb = attack_verb_on
	else
		if(attack_verb_off.len)
			attack_verb = attack_verb_off
	if(sharpness)
		AddComponent(/datum/component/butchering, 50, 100, 0, hitsound)

/obj/item/melee/transforming/attack_self(mob/living/carbon/user)
	if(transform_weapon(user))
		clumsy_transform_effect(user)

/obj/item/melee/transforming/attack(mob/living/target, mob/living/carbon/human/user)
	var/nemesis_faction = FALSE
	if(LAZYLEN(nemesis_factions))
		for(var/F in target.faction)
			if(F in nemesis_factions)
				nemesis_faction = TRUE
				force += faction_bonus_force
				nemesis_effects(user, target)
				break
	. = ..()
	if(nemesis_faction)
		force -= faction_bonus_force

/obj/item/melee/transforming/proc/transform_weapon(mob/living/user, supress_message_text)
	active = !active
	if(active)
		force = force_on
		max_reach = reach_on
		total_mass = total_mass_on
		throwforce = throwforce_on
		hitsound = hitsound_on
		throw_speed = 4
		if(attack_verb_on.len)
			attack_verb = attack_verb_on
		if(embedding)
			updateEmbedding()
		icon_state = icon_state_on
		w_class = w_class_on
	else
		force = initial(force)
		max_reach = initial(max_reach)
		throwforce = initial(throwforce)
		hitsound = initial(hitsound)
		throw_speed = initial(throw_speed)
		if(attack_verb_off.len)
			attack_verb = attack_verb_off
		if(embedding)
			updateEmbedding()
		icon_state = initial(icon_state)
		w_class = initial(w_class)
		total_mass = initial(total_mass)
	transform_messages(user, supress_message_text)
	add_fingerprint(user)
	return TRUE

/obj/item/melee/transforming/proc/nemesis_effects(mob/living/user, mob/living/target)
	return

/obj/item/melee/transforming/proc/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, 1)  //changed it from 50% volume to 35% because deafness
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")

/obj/item/melee/transforming/proc/clumsy_transform_effect(mob/living/user)
	if(clumsy_check && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, "<span class='warning'>You accidentally cut yourself with [src], like a doofus!</span>")
		user.take_bodypart_damage(5,5)

/obj/item/melee/transforming/old_rusty
	name = "Old Rusty"
	desc = "A chosen weapon of a hunter made in the image of a cleaving saw but heavily improvised"
	force = 15
	force_on = 30 //force when active
	throwforce = 20
	throwforce_on = 20
	max_reach = 1
	reach_on = 2
	icon = 'icons/obj/lavaland/artefacts.dmi'
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	icon_state = "cleaving_saw"
	icon_state_on = "cleaving_saw_open"
	slot_flags = ITEM_SLOT_BELT
	attack_verb_off = list("attacked", "sawed", "sliced", "torn", "ripped", "diced", "cut")
	attack_verb_on = list("cleaved", "swiped", "slashed", "chopped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	hitsound_on = 'sound/weapons/bladeslice.ogg'
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	faction_bonus_force = 30
	nemesis_factions = list("deathclaw", "raider")
	var/transform_cooldown
	var/swiping = FALSE
	var/bleed_stacks_per_hit = 3
	total_mass = 2.75
	total_mass_on = 5
	attack_speed = 0
	attack_unwieldlyness = CLICK_CD_MELEE * 0.5

/obj/item/melee/transforming/old_rusty/examine(mob/user)
	. = ..()
	. += "<span class='notice'>It is [active ? "open, and will cleave enemies in a wide arc":"closed, and can be used for rapid consecutive attacks that cause beastly enemies to bleed"].<br>\
	Both modes will build up existing bleed effects, doing a burst of high damage if the bleed is built up high enough.<br>\
	Transforming it immediately after an attack causes the next attack to come out faster.</span>"

/obj/item/melee/transforming/old_rusty/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is [active ? "closing [src] on [user.p_their()] neck" : "opening [src] into [user.p_their()] chest"]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	transform_cooldown = 0
	transform_weapon(user, TRUE)
	return BRUTELOSS

/obj/item/melee/transforming/old_rusty/transform_weapon(mob/living/user, supress_message_text)
	if(transform_cooldown > world.time)
		return FALSE
	. = ..()
	if(.)
		if(active)
			attack_unwieldlyness = CLICK_CD_MELEE
		else
			attack_unwieldlyness = CLICK_CD_MELEE * 0.5
		transform_cooldown = world.time + (CLICK_CD_MELEE * 0.5)
		user.SetNextAction(CLICK_CD_MELEE * 0.25, considered_action = FALSE, flush = TRUE)

/obj/item/melee/transforming/old_rusty/transform_messages(mob/living/user, supress_message_text)
	if(!supress_message_text)
		if(active)
			to_chat(user, "<span class='notice'>You open [src]. It will now cleave enemies in a wide arc.</span>")
		else
			to_chat(user, "<span class='notice'>You close [src]. It will now attack rapidly and cause beastly enemies to bleed.</span>")
	playsound(user, 'sound/magic/clockwork/fellowship_armory.ogg', 35, TRUE, frequency = 90000 - (active * 30000))

/obj/item/melee/transforming/old_rusty/clumsy_transform_effect(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, "<span class='warning'>You accidentally cut yourself with [src], like a doofus!</span>")
		user.take_bodypart_damage(10)
