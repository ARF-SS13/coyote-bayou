//Remains of code/game/objects/items/weaponry.dm
//WEAPONS HERE ARE UNLIKELY TO BE BALANCED FOR F13 COMBAT and not everything here is a weapon
/obj/item/banhammer
	desc = "A banhammer."
	name = "banhammer"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	slot_flags = INV_SLOTBIT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb = list("banned")
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF

/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/

/* 
superlagg says: cool story, oranges
*/

/obj/item/banhammer/attack(mob/M, mob/user)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message(span_danger("[user] strikes [M]'s head with [src]."), span_userdanger("[user] strikes your head with [src]."), "You hear a banhammer striking someone's head.");
	else
		M.visible_message(span_danger("[M] has been banned FOR NO REISIN by [user]"), span_userdanger("You have been banned FOR NO REISIN by [user]"), "you hear a banhammer banning someone")
	playsound(loc, 'sound/effects/adminnotification.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.a_intent != INTENT_HELP)
		return ..(M, user)

/obj/item/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT
	force = 2
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/katana
	name = "katana"
	desc = "After the world ended, seppuku rates in Japan skyrocketed!"
	icon_state = "katana"
	item_state = "katana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 40
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 50
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON

/obj/item/katana/cursed
	slot_flags = null

/obj/item/katana/cursed/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/katana/timestop
	name = "temporal katana"
	desc = "Delicately balanced, this finely-crafted blade hums with barely-restrained potential."
	icon_state = "temporalkatana"
	item_state = "temporalkatana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 0 // oops
	force = 35 // oops
	item_flags = ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/bokken
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/katana/timestop/on_active_parry(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, list/block_return, parry_efficiency, parry_time)
	if(ishuman(owner))
		var/mob/living/carbon/human/flynn = owner
		flynn.emote("smirk")
	new /obj/effect/timestop/magic(get_turf(owner), 1, 50, list(owner)) // null roddies counter

/obj/item/melee/bokken // parrying stick
	name = "bokken"
	desc = "A Japanese training sword made of wood and shaped like a katana."
	icon_state = "bokken"
	item_state = "bokken"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	w_class = WEIGHT_CLASS_BULKY
	force = 7 //how much harm mode damage we do
	var/stamina_damage_increment = 4 //how much extra damage do we do when in non-harm mode
	throwforce = 10
	damtype = STAMINA
	attack_verb = list("whacked", "smacked", "struck")
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	hitsound = 'sound/weapons/grenadelaunch.ogg' // no good wood thunk sounds
	var/harm = FALSE // TRUE = brute, FALSE = stam
	var/reinforced = FALSE
	var/burnt = FALSE
	var/burned_in // text you burned in (with a welder)
	var/quick_parry = FALSE // false = default parry, true = really small parry window
	item_flags = ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/bokken
	bare_wound_bonus = 0
	wound_bonus = 0

/datum/block_parry_data/bokken // fucked up parry data, emphasizing quicker, shorter parries
	parry_stamina_cost = 10 // be wise about when you parry, though, else you won't be able to fight enough to make it count
	parry_time_windup = 0
	parry_time_active = 15 // small parry window
	parry_time_spindown = 0
	// parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK		// bokken users can no longer strike while parrying
	parry_time_perfect = 1.5
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 20 // unless you completely butcher your parry, you will riposte
	parry_efficiency_considered_successful = 0		// VERY generous
	parry_efficiency_perfect = 120
	parry_efficiency_perfect_override = list()
	parry_failed_stagger_duration = 0.5 SECONDS
	parry_failed_clickcd_duration = 0.5 SECONDS
	parry_data = list(
		PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5, // 7*2.5 = 17.5, 8*2.5 = 20, 9*2.5 = 22.5, 10*2.5 = 25
	)

/datum/block_parry_data/bokken/quick_parry // emphasizing REALLY SHORT PARRIES
	parry_stamina_cost = 10 // still more costly than most parries, but less than a full bokken parry
	parry_time_active = 5 // REALLY small parry window
	// still, don't fucking miss your parries or you're down stamina and staggered to shit

/obj/item/melee/bokken/Initialize()
	. = ..()
	AddElement(/datum/element/sword_point)
	if(!harm) //if initialised in non-harm mode, setup force accordingly
		force = force + stamina_damage_increment

/obj/item/melee/bokken/attack_self(mob/user)
	harm = !harm
	if(harm)
		force -= stamina_damage_increment
		damtype = BRUTE
		attack_verb = list("bashed", "smashed", "attacked")
		bare_wound_bonus = 15 // having your leg smacked by a wooden stick is probably not great for it if it's naked
		wound_bonus = 0
	else
		force += stamina_damage_increment
		damtype = STAMINA
		attack_verb = list("whacked", "smacked", "struck")
		bare_wound_bonus = 0
		wound_bonus = 0
	to_chat(user, span_notice("[src] is now [harm ? "harmful" : "not quite as harmful"]."))

/obj/item/melee/bokken/AltClick(mob/user)
	. = ..()
	quick_parry = !quick_parry
	if(quick_parry)
		block_parry_data = /datum/block_parry_data/bokken/quick_parry
	else
		block_parry_data = /datum/block_parry_data/bokken
	to_chat(user, span_notice("[src] is now [quick_parry ? "emphasizing shorter parries, forcing you to riposte or be staggered" : "emphasizing longer parries, with a shorter window to riposte but more forgiving parries"]."))

/obj/item/melee/bokken/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/pen))
		var/new_name = stripped_input(user, "What do you wish to name [src]?", "New Name", "bokken", 30)
		if(new_name)
			name = new_name
	if(I.tool_behaviour == TOOL_WELDER)
		var/new_burn = stripped_input(user, "What do you wish to burn into [src]?", "Burnt Inscription","", 140)
		if(new_burn)
			burned_in = new_burn
			if(!burnt)
				icon_state += "_burnt"
				item_state += "_burnt"
				burnt = TRUE
			update_icon()
			update_icon_state()
	if(istype(I, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = I
		if(!reinforced)
			if(R.use(1))
				force++
				reinforced = TRUE
				to_chat(user, "<span class='notice'>You slide a metal rod into [src]\'s hilt. It feels a little heftier in your hands.")
		else
			to_chat(user, "<span class='notice'>[src] already has a weight slid into the hilt.")

/obj/item/melee/bokken/examine(mob/user)
	. = ..()
	if(quick_parry)
		. += " [src] is gripped in a way to emphasize quicker parries."
	if(reinforced)
		. += " There's a metal rod shoved into the base."
	if(burnt)
		. += " Burned into the \"blade\" is [burned_in]."

/obj/item/melee/bokken/debug
	name = "funny debug parrying stick"
	desc = "if you see this you've fucked up somewhere my good man"
	block_parry_data = /datum/block_parry_data/bokken/debug

/obj/item/melee/bokken/debug/AltClick(mob/user)
	quick_parry = !quick_parry
	if(quick_parry)
		block_parry_data = /datum/block_parry_data/bokken/quick_parry/debug
	else
		block_parry_data = /datum/block_parry_data/bokken/debug
	to_chat(user, span_notice("[src] is now [quick_parry ? "emphasizing shorter parries, forcing you to riposte or be staggered" : "emphasizing longer parries, with a shorter window to riposte but more forgiving parries"]."))

/datum/block_parry_data/bokken/debug
	parry_efficiency_perfect_override = list()
	parry_data = list(
		PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5, // 7*2.5 = 17.5, 8*2.5 = 20, 9*2.5 = 22.5, 10*2.5 = 25
		PARRY_DISARM_ATTACKER = TRUE,
		PARRY_KNOCKDOWN_ATTACKER = 10,
		PARRY_STAGGER_ATTACKER = 10,
		PARRY_DAZE_ATTACKER = 10,
		)

/datum/block_parry_data/bokken/quick_parry/debug
	parry_efficiency_perfect_override = list()
	parry_data = list(
		PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5, // 7*2.5 = 17.5, 8*2.5 = 20, 9*2.5 = 22.5, 10*2.5 = 25
		PARRY_DISARM_ATTACKER = TRUE,
		PARRY_KNOCKDOWN_ATTACKER = 10,
		PARRY_STAGGER_ATTACKER = 10,
		PARRY_DAZE_ATTACKER = 10,
		)

/obj/item/wirerod
	name = "wired rod"
	desc = "A rod with some wire wrapped around the top. It'd be easy to attach something to the top bit."
	icon_state = "wiredrod"
	item_state = "rods"
	flags_1 = CONDUCT_1
	force = 9
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=1150, /datum/material/glass=75)
	attack_verb = list("hit", "bludgeoned", "whacked", "bonked")
	wound_bonus = -10

/obj/item/wirerod/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/shard))
		var/obj/item/twohanded/spear/S = new /obj/item/twohanded/spear

		remove_item_from_storage(user)
		if (!user.transferItemToLoc(I, S))
			return
		S.CheckParts(list(I))
		qdel(src)

		user.put_in_hands(S)
		to_chat(user, span_notice("You fasten the glass shard to the top of the rod with the cable."))

	else if(istype(I, /obj/item/assembly/igniter) && !HAS_TRAIT(I, TRAIT_NODROP))
		var/obj/item/melee/baton/cattleprod/P = new /obj/item/melee/baton/cattleprod

		remove_item_from_storage(user)

		to_chat(user, span_notice("You fasten [I] to the top of the rod with the cable."))

		qdel(I)
		qdel(src)

		user.put_in_hands(P)
	else
		return ..()

/obj/item/phone
	name = "red phone"
	desc = "Should anything ever go wrong..."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "red_phone"
	force = 3
	throwforce = 2
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("called", "rang")
	hitsound = 'sound/weapons/ring.ogg'

/obj/item/throwing_star
	name = "throwing star"
	desc = "A serrated metal disk. Useless against armor, but looks painful if chucked into someone's face."
	icon_state = "throwingstar"
	item_state = "eshield0"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 2
	throwforce = 12
	throw_speed = 4
	embedding = list("pain_mult" = 2, "embed_chance" = 100, "fall_chance" = 0, "embed_chance_turf_mod" = 75)

	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_EDGED
	custom_materials = list(/datum/material/iron=500, /datum/material/glass=500)
	resistance_flags = FIRE_PROOF

/obj/item/throwing_star/stamina
	name = "shock throwing star"
	desc = "An aerodynamic disc designed to cause excruciating pain when stuck inside fleeing targets, hopefully without causing fatal harm."
	throwforce = 5
	embedding = list("pain_chance" = 5, "embed_chance" = 100, "fall_chance" = 0, "jostle_chance" = 10, "pain_stam_pct" = 0.8, "jostle_pain_mult" = 3)

/obj/item/cane
	name = "cane"
	desc = "A cane used by a true gentleman. Or a clown."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("bludgeoned", "whacked", "disciplined", "thrashed")

/obj/item/staff
	name = "wizard staff"
	desc = "Apparently a staff used by the wizard."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "staff"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("bludgeoned", "whacked", "disciplined")
	resistance_flags = FLAMMABLE

/obj/item/staff/broom
	name = "broom"
	desc = "Used for sweeping, and flying into the night while cackling. Black cat not included."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "broom"
	resistance_flags = FLAMMABLE

/obj/item/staff/stick
	name = "stick"
	desc = "A great tool to drag someone else's drinks across the bar."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "cane"
	item_state = "stick"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 3
	throwforce = 5
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ectoplasm
	name = "ectoplasm"
	desc = "Spooky."
	gender = PLURAL
	icon = 'icons/obj/wizard.dmi'
	icon_state = "ectoplasm"

/obj/item/statuebust
	name = "bust"
	desc = "A priceless ancient marble bust, the kind that belongs in a museum." //or you can hit people with it
	icon = 'icons/obj/statue.dmi'
	icon_state = "bust"
	force = 15
	throwforce = 10
	throw_speed = 5
	throw_range = 2
	attack_verb = list("busted")
	var/impressiveness = 45

/obj/item/statuebust/Initialize()
	. = ..()
	AddElement(/datum/element/art, impressiveness)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum,_AddElement), list(/datum/element/beauty, 1000)), 0)

/obj/item/tailclub
	name = "tail club"
	desc = "For the beating to death of lizards with their own tails."
	icon_state = "tailclub"
	force = 14
	throwforce = 1 // why are you throwing a club do you even weapon
	throw_speed = 1
	throw_range = 1
	attack_verb = list("clubbed", "bludgeoned")

/obj/item/melee/chainofcommand/tailwhip
	name = "liz o' nine tails"
	desc = "A whip fashioned from the severed tails of lizards."
	icon_state = "tailwhip"
	item_flags = NONE

/obj/item/melee/chainofcommand/tailwhip/kitty
	name = "cat o' nine tails"
	desc = "A whip fashioned from the severed tails of cats."
	icon_state = "catwhip"



/obj/item/melee/flyswatter
	name = "flyswatter"
	desc = "Useful for killing insects of all sizes."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "flyswatter"
	item_state = "flyswatter"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 1
	throwforce = 1
	attack_verb = list("swatted", "smacked")
	hitsound = 'sound/effects/snap.ogg'
	w_class = WEIGHT_CLASS_SMALL
	//Things in this list will be instantly splatted.  Flyman weakness is handled in the flyman species weakness proc.
	var/list/strong_against
	var/list/spider_panic

/obj/item/melee/flyswatter/Initialize()
	. = ..()
	strong_against = typecacheof(list(
					/mob/living/simple_animal/hostile/poison/bees/,
					/mob/living/simple_animal/butterfly,
					/mob/living/simple_animal/cockroach,
					/obj/item/queen_bee
	))
	spider_panic = typecacheof(list(
					/mob/living/simple_animal/banana_spider,
					/mob/living/simple_animal/hostile/poison/giant_spider,
	))

/obj/item/melee/flyswatter/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(proximity_flag)
		if(is_type_in_typecache(target, strong_against))
			new /obj/effect/decal/cleanable/insectguts(target.drop_location())
			to_chat(user, span_warning("You easily splat the [target]."))
			if(istype(target, /mob/living/))
				var/mob/living/bug = target
				bug.death(1)
		if(is_type_in_typecache(target, spider_panic))
			to_chat(user, span_warning("You easily land a critical blow on the [target]."))
			if(istype(target, /mob/living/))
				var/mob/living/bug = target
				bug.adjustBruteLoss(35) //What kinda mad man would go into melee with a spider?!
			else
				qdel(target)

/obj/item/circlegame
	name = "circled hand"
	desc = "If somebody looks at this while it's below your waist, you get to bop them."
	icon_state = "madeyoulook"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT
	attack_verb = list("bopped")

/obj/item/circlegame/Initialize()
	. = ..()
	var/mob/living/owner = loc
	if(!istype(owner))
		return
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE,PROC_REF(ownerExamined))

/obj/item/circlegame/Destroy()
	var/mob/owner = loc
	if(istype(owner))
		UnregisterSignal(owner, COMSIG_PARENT_EXAMINE)
	return ..()

/obj/item/circlegame/dropped(mob/user)
	UnregisterSignal(user, COMSIG_PARENT_EXAMINE)		//loc will have changed by the time this is called, so Destroy() can't catch it
	// this is a dropdel item.
	return ..()

/// Stage 1: The mistake is made
/obj/item/circlegame/proc/ownerExamined(mob/living/owner, mob/living/sucker)
	if(!istype(sucker) || !in_range(owner, sucker))
		return
	addtimer(CALLBACK(src,PROC_REF(waitASecond), owner, sucker), 4)

/// Stage 2: Fear sets in
/obj/item/circlegame/proc/waitASecond(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker) || QDELETED(src) || QDELETED(owner))
		return

	if(owner == sucker) // big mood
		to_chat(owner, span_danger("Wait a second... you just looked at your own [src.name]!"))
		addtimer(CALLBACK(src,PROC_REF(selfGottem), owner), 10)
	else
		to_chat(sucker, span_danger("Wait a second... was that a-"))
		addtimer(CALLBACK(src,PROC_REF(GOTTEM), owner, sucker), 6)

/// Stage 3A: We face our own failures
/obj/item/circlegame/proc/selfGottem(mob/living/owner)
	if(QDELETED(src) || QDELETED(owner))
		return

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	owner.visible_message(span_danger("[owner] shamefully bops [owner.p_them()]self with [owner.p_their()] [src.name]."), span_userdanger("You shamefully bop yourself with your [src.name]."), \
		span_hear("You hear a dull thud!"))
	log_combat(owner, owner, "bopped", src.name, "(self)")
	owner.do_attack_animation(owner)
	owner.apply_damage(100, STAMINA)
	owner.Knockdown(10)
	qdel(src)

/// Stage 3B: We face our reckoning (unless we moved away or they're incapacitated)
/obj/item/circlegame/proc/GOTTEM(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker))
		return

	if(QDELETED(src) || QDELETED(owner))
		to_chat(sucker, span_warning("Nevermind... must've been your imagination..."))
		return

	if(!in_range(owner, sucker) || !(owner.mobility_flags & MOBILITY_USE))
		to_chat(sucker, span_notice("Phew... you moved away before [owner] noticed you saw [owner.p_their()] [src.name]..."))
		return

	to_chat(owner, span_warning("[sucker] looks down at your [src.name] before trying to avert [sucker.p_their()] eyes, but it's too late!"))
	to_chat(sucker, span_danger("<b>[owner] sees the fear in your eyes as you try to look away from [owner.p_their()] [src.name]!</b>"))

	playsound(get_turf(owner), 'sound/effects/hit_punch.ogg', 50, TRUE, -1)
	owner.do_attack_animation(sucker)

	if(HAS_TRAIT(owner, TRAIT_HULK))
		owner.visible_message(span_danger("[owner] bops [sucker] with [owner.p_their()] [src.name] much harder than intended, sending [sucker.p_them()] flying!"), \
			span_danger("You bop [sucker] with your [src.name] much harder than intended, sending [sucker.p_them()] flying!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), ignored_mobs=list(sucker))
		to_chat(sucker, span_userdanger("[owner] bops you incredibly hard with [owner.p_their()] [src.name], sending you flying!"))
		sucker.apply_damage(50, STAMINA)
		sucker.Knockdown(50)
		log_combat(owner, sucker, "bopped", src.name, "(setup- Hulk)")
		var/atom/throw_target = get_edge_target_turf(sucker, owner.dir)
		sucker.throw_at(throw_target, 6, 3, owner)
	else
		owner.visible_message(span_danger("[owner] bops [sucker] with [owner.p_their()] [src.name]!"), span_danger("You bop [sucker] with your [src.name]!"), \
			span_hear("You hear a dull thud!"), ignored_mobs=list(sucker))
		sucker.apply_damage(15, STAMINA)
		log_combat(owner, sucker, "bopped", src.name, "(setup)")
		to_chat(sucker, span_userdanger("[owner] bops you with [owner.p_their()] [src.name]!"))
	qdel(src)

/obj/item/slapper
	name = "slapper"
	desc = "This is how real men fight."
	icon_state = "latexballon"
	item_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT
	attack_verb = list("slapped")
	hitsound = 'sound/effects/snap.ogg'

/obj/item/slapper/attack(mob/M, mob/living/carbon/human/user)
	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(L && L.dna && L.dna.species)
			L.dna.species.stop_wagging_tail(M)
	if(user.a_intent != INTENT_HARM && ((user.zone_selected == BODY_ZONE_PRECISE_MOUTH) || (user.zone_selected == BODY_ZONE_PRECISE_EYES) || (user.zone_selected == BODY_ZONE_HEAD)))
		user.do_attack_animation(M)
		playsound(M, 'sound/weapons/slap.ogg', 50, 1, -1)
		user.visible_message(span_danger("[user] slaps [M]!"),
		span_notice("You slap [M]!"),\
		"You hear a slap.")
		return
	else
		..()

/obj/item/proc/can_trigger_gun(mob/living/user)
	if(!user.can_use_guns(src))
		return FALSE
	return TRUE

/obj/item/extendohand
	name = "extendo-hand"
	desc = "Futuristic tech has allowed these classic spring-boxing toys to essentially act as a fully functional hand-operated hand prosthetic."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "extendohand"
	item_state = "extendohand"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 0
	throwforce = 5
	max_reach = 2
	min_reach = 2

/obj/item/extendohand/acme
	name = "\improper ACME Extendo-Hand"
	desc = "A novelty extendo-hand produced by the ACME corporation. Originally designed to knock out roadrunners."

/obj/item/extendohand/attack(atom/M, mob/living/carbon/human/user)
	var/dist = get_dist(M, user)
	if(dist < min_reach)
		to_chat(user, span_warning("[M] is too close to use [src] on."))
		return
	M.attack_hand(user)

//HF blade

/obj/item/vibro_weapon
	icon_state = "hfrequency0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "vibro sword"
	desc = "A potent weapon capable of cutting through nearly anything. Wielding it in two hands will allow you to deflect gunfire."
	block_chance = 40
	throwforce = 20
	throw_speed = 4
	sharpness = SHARP_EDGED
	attack_verb = list("cut", "sliced", "diced")
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/vibro_weapon/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD,PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD,PROC_REF(on_unwield))

/obj/item/vibro_weapon/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 20, 105)
	AddComponent(/datum/component/two_handed, force_multiplier=2, icon_wielded="hfrequency1")
	AddElement(/datum/element/sword_point)

/// triggered on wield of two handed item
/obj/item/vibro_weapon/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/vibro_weapon/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/vibro_weapon/update_icon_state()
	icon_state = "hfrequency0"

/obj/item/vibro_weapon/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(wielded)
		final_block_chance *= 2
	if(wielded || !(attack_type & ATTACK_TYPE_PROJECTILE))
		if(prob(final_block_chance))
			if(attack_type & ATTACK_TYPE_PROJECTILE)
				owner.visible_message(span_danger("[owner] deflects [attack_text] with [src]!"))
				playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, 1)
				block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
				return BLOCK_SUCCESS | BLOCK_REDIRECTED | BLOCK_SHOULD_REDIRECT | BLOCK_PHYSICAL_EXTERNAL
			else
				owner.visible_message(span_danger("[owner] parries [attack_text] with [src]!"))
				return BLOCK_SUCCESS | BLOCK_PHYSICAL_EXTERNAL
	return NONE

//PITCHFORKS

/obj/item/pitchfork
	icon_state = "pitchfork0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "pitchfork"
	desc = "A simple tool used for moving hay."
	force = 40
	throwforce = 25
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "impaled", "pierced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF

/obj/item/pitchfork/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD,PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD,PROC_REF(on_unwield))

/obj/item/pitchfork/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=38, icon_wielded="pitchfork1")
	AddElement(/datum/element/sword_point)

/// triggered on wield of two handed item
/obj/item/pitchfork/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/pitchfork/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/pitchfork/update_icon_state()
	icon_state = "pitchfork0"

/obj/item/pitchfork/demonic
	name = "demonic pitchfork"
	desc = "A red pitchfork, it looks like the work of the devil."
	force = 19
	throwforce = 24
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_power = 6
	light_color = LIGHT_COLOR_RED

/obj/item/pitchfork/demonic/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=35)

/obj/item/pitchfork/demonic/greater
	force = 24
	throwforce = 50

/obj/item/pitchfork/demonic/greater/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=30, force_wielded=40)

/obj/item/pitchfork/demonic/ascended
	force = 100
	throwforce = 100

/obj/item/pitchfork/demonic/ascended/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=100, force_wielded=500000) // Kills you DEAD

/obj/item/pitchfork/demonic/pickup(mob/living/user)
	. = ..()
	if(isliving(user) && user.mind && user.owns_soul() && !is_devil(user))
		var/mob/living/U = user
		U.visible_message(span_warning("As [U] picks [src] up, [U]'s arms briefly catch fire."), \
			span_warning("\"As you pick up [src] your arms ignite, reminding you of all your past sins.\""))
		if(ishuman(U))
			var/mob/living/carbon/human/H = U
			H.apply_damage(rand(force/2, force), BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			U.adjustFireLoss(rand(force/2,force))

/obj/item/pitchfork/demonic/attack(mob/target, mob/living/carbon/human/user)
	if(user.mind && user.owns_soul() && !is_devil(user))
		to_chat(user, span_warning("[src] burns in your hands."))
		user.apply_damage(rand(force/2, force), BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
	..()

/obj/item/pitchfork/demonic/ascended/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !wielded)
		return
	if(iswallturf(target))
		var/turf/closed/wall/W = target
		user.visible_message(span_danger("[user] blasts \the [target] with \the [src]!"))
		playsound(target, 'sound/magic/disintegrate.ogg', 100, TRUE)
		W.break_wall()
		W.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		return

/*
//////////////////
// CODE ARCHIVE //
//////////////////

BASEBALL HOMERUN
/obj/item/melee/baseball_bat/homerun
	name = "home run bat"
	desc = "This thing looks dangerous... Dangerously good at baseball, that is."
	homerun_able = 1

/obj/item/melee/baseball_bat/attack_self(mob/user)
	if(!homerun_able)
		..()
		return
	if(homerun_ready)
		to_chat(user, span_notice("You're already ready to do a home run!"))
		..()
		return
	to_chat(user, span_warning("You begin gathering strength..."))
	playsound(get_turf(src), 'sound/magic/lightning_chargeup.ogg', 65, 1)
	if(do_after(user, 90, target = src))
		to_chat(user, span_userdanger("You gather power! Time for a home run!"))
		homerun_ready = 1
	..()

/obj/item/melee/baseball_bat/attack(mob/living/target, mob/living/user)
	. = ..()
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(homerun_ready)
		user.visible_message(span_userdanger("It's a home run!"))
		target.throw_at(throw_target, rand(8,10), 14, user)
		target.ex_act(EXPLODE_HEAVY)
		playsound(get_turf(src), 'sound/weapons/homerun.ogg', 100, 1)
		homerun_ready = 0
		return
	else if(!target.anchored)
		var/whack_speed = (prob(60) ? 1 : 4)
		target.throw_at(throw_target, rand(1, 2), whack_speed, user) // sorry friends, 7 speed batting caused wounds to absolutely delete whoever you knocked your target into (and said target)
*/
