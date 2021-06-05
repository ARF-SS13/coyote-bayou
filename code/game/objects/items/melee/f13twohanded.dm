//Previously obj/items/twohanded.dm

/*
 * Twohanded
 */

/obj/item/twohanded
	var/icon_prefix = null
	var/wielded = FALSE

/obj/item/twohanded/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)
	//var/datum/component/jousting/JC = AddComponent(/datum/component/jousting) //Oh yeah. We can modify and tweak this for individual items
	//JC.mounted_damage_boost_per_tile = 25 //Percentage of weapon force on the bonus hit
	//JC.mounted_knockdown_chance_per_tile = 10 // This is 100% at 4 tiles - not any more, haha
	//JC.mounted_knockdown_time = 60

/// triggered on wield of two handed item
/obj/item/twohanded/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/// triggered on unwield of two handed item
/obj/item/twohanded/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/twohanded/update_icon_state()
	icon_state = "[icon_prefix]0"

/*
 * Fireaxe
 */
/obj/item/twohanded/fireaxe //DONE
	icon_state = "fireaxe0"
	lefthand_file = 'icons/mob/inhands/weapons/axes_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/axes_righthand.dmi'
	name = "woodaxe"
	desc = "The axe forgets what the tree remembers."
	force = 25
	throwforce = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
//	force_unwielded = 25
//	force_wielded = 50
	attack_verb = list("axed", "chopped", "cleaved", "torn", "hacked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20
	icon_prefix = "fireaxe"

/*/obj/item/twohanded/fireaxe/Initialize()
	. = ..()
	GET_COMPONENT(JC,/datum/component/jousting)
	JC.movement_reset_tolerance = 4
	JC.unmounted_damage_boost_per_tile = 25
	JC.unmounted_knockdown_chance_per_tile = 10
	JC.unmounted_knockdown_time = 5
	JC.mounted_damage_boost_per_tile = 25
	JC.mounted_knockdown_chance_per_tile = 10
	JC.mounted_knockdown_time = 30*/

/obj/item/twohanded/fireaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound) //axes are not known for being precision butchering tools
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=50, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/fireaxe/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] axes [user.p_them()]self from head to toe! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/twohanded/fireaxe/afterattack(atom/A, mob/living/user, proximity)
	. = ..()
	if(!proximity || !wielded || IS_STAMCRIT(user))
		return
	if(istype(A, /obj/structure/window)) //destroys windows and grilles in one hit (or more if it has a ton of health like plasmaglass)
		var/obj/structure/window/W = A
		W.take_damage(200, BRUTE, "melee", 0)
	else if(istype(A, /obj/structure/grille))
		var/obj/structure/grille/G = A
		G.take_damage(40, BRUTE, "melee", 0)

/*
 * Bone Axe
 */
/obj/item/twohanded/fireaxe/boneaxe  //DONE
	icon_state = "bone_axe0"
	name = "bone axe"
	desc = "A large, vicious axe crafted out of several sharpened bone plates and crudely tied together. Made of monsters, by killing monsters, for killing monsters."
	icon_prefix = "bone_axe"

/obj/item/twohanded/fireaxe/boneaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=25, force_wielded=40, icon_wielded="[icon_prefix]1")


/obj/item/twohanded/fireaxe/bmprsword
	name = "bumper sword"
	icon_state = "bmprsword0"
	desc = "A heavy makeshift sword fashioned out of a car bumper."
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	icon_prefix = "bmprsword"

//spears
/obj/item/twohanded/spear //DONE
	icon_state = "spearglass0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "improvised metal glaive"
	desc = "A improvised metal glaive that can be wielded."
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
//	force_unwielded = 25
//	force_wielded = 40
	throwforce = 25
	throw_speed = 4
	embedding = list("embed_chance" = 0)
	armour_penetration = 0
//	custom_materials = list(MAT_METAL=1150, MAT_GLASS=2075)
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "impaled", "jabbed", "torn", "gored")
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	var/obj/item/grenade/explosive = null
	var/war_cry = "AAAAARGH!!!"
	icon_prefix = "spearglass"
	wound_bonus = -15
	bare_wound_bonus = 15

/obj/item/twohanded/spear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
//	AddComponent(/datum/component/jousting)
	AddElement(/datum/element/sword_point)
	AddComponent(/datum/component/two_handed, force_unwielded=8, force_wielded=30, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/spear/rightclick_attack_self(mob/user)
	if(explosive)
		explosive.attack_self(user)
		return
	. = ..()


/obj/item/twohanded/spear/update_overlays()
	. = ..()
	if(explosive)
		. += "spearbomb_overlay"

/obj/item/twohanded/spear/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins to sword-swallow \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(explosive) //Citadel Edit removes qdel and explosive.forcemove(AM)
		user.say("[war_cry]", forced="spear warcry")
		explosive.prime()
		user.gib()
		return BRUTELOSS
	return BRUTELOSS

/obj/item/twohanded/spear/examine(mob/user)
	. = ..()
	if(explosive)
		. += "<span class='notice'>Alt-click to set your war cry.</span>"
		. += "<span class='notice'>Right-click in combat mode to activate the attached explosive.</span>"

/obj/item/twohanded/spear/afterattack(atom/movable/AM, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isopenturf(AM)) //So you can actually melee with it
		return
	if(explosive && wielded) //Citadel edit removes qdel and explosive.forcemove(AM)
		user.say("[war_cry]", forced="spear warcry")
		explosive.prime()

/obj/item/twohanded/spear/grenade_prime_react(obj/item/grenade/nade) //Citadel edit, removes throw_impact because memes
	nade.forceMove(get_turf(src))
	qdel(src)
/*
//THIS MIGHT BE UNBALANCED SO I DUNNO // it totally is.
/obj/item/twohanded/spear/throw_impact(atom/target)
	. = ..()
	if(!.) //not caught
		if(explosive)
			explosive.prime()
			qdel(src)*/

/obj/item/twohanded/spear/AltClick(mob/user)
	. = ..()
	if(user.canUseTopic(src, BE_CLOSE))
		..()
		if(!explosive)
			return
		if(istype(user) && loc == user)
			var/input = stripped_input(user,"What do you want your war cry to be? You will shout it when you hit someone in melee.", ,"", 50)
			if(input)
				src.war_cry = input
		return TRUE

/obj/item/twohanded/spear/CheckParts(list/parts_list)
	var/obj/item/twohanded/spear/S = locate() in parts_list
	if(S)
		if(S.explosive)
			S.explosive.forceMove(get_turf(src))
			S.explosive = null
		parts_list -= S
		qdel(S)
	..()
	var/obj/item/grenade/G = locate() in contents
	if(G)
		explosive = G
		name = "explosive lance"
		embedding = list(embed_chance = 0, pain_mult = 1)//elances should not be embeddable
		updateEmbedding()
		desc = "A makeshift spear with \a [G] attached to it."
	update_icon()

/obj/item/twohanded/spear/lance
	icon_state = "lance0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "legion lance"
	desc = "A long spear made in the Legions war foundries. Useful for fighting tribals and hunting when ammunition is scarce."
	icon_prefix = "lance"

/obj/item/twohanded/spear/lance/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
	AddElement(/datum/element/sword_point)
	AddComponent(/datum/component/two_handed, force_unwielded=10, force_wielded=40, icon_wielded="[icon_prefix]1")

/*
 * Bone Spear
 */
/obj/item/twohanded/spear/bonespear	//Blatant imitation of spear, but made out of bone. Not valid for explosive modification.
	icon_state = "bone_spear0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "bone spear"
	desc = "A haphazardly-constructed yet still deadly weapon. The pinnacle of modern technology."
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 25
	throw_speed = 4
	embedding = list("embedded_impact_pain_multiplier" = 3)
	armour_penetration = 0.24				//Enhanced armor piercing
	custom_materials = null
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "poked", "jabbed", "torn", "gored")
	sharpness = SHARP_POINTY
	icon_prefix = "bone_spear"

/obj/item/twohanded/spear/bonespear/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=15, force_wielded=40, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/spear/bonespear/deathclaw
	name = "deathclaw spear"
	desc = "A finely crafted spear with a shaft wrapped in deathclaw leather. It is tipped with a claw from a beast that must have been terrifying in size."
	force = 20
	armour_penetration = 0.3
	icon_state = "clawspear0"
	icon_prefix = "clawspear"

/obj/item/twohanded/spear/bonespear/deathclaw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 20, force_wielded = 50)

//Ultracite
/obj/item/twohanded/spear/ultra
	icon_state = "ultraglaive0"
	name = "ultracite glaive"
	desc = "An ultracite enhanced metal glaive that can be wielded."
	force = 30
	armour_penetration = 0.1
	icon_prefix = "ultraglaive"

/obj/item/twohanded/spear/ultra/Initialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=30, force_wielded=50)

/obj/item/twohanded/spear/ultra/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, TOX, null, 0)

// CHAINSAW
/obj/item/twohanded/chainsaw
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon_state = "chainsaw_off"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 13
	var/force_on = 72
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 10
	throw_speed = 2
	throw_range = 4
//	custom_materials = list(MAT_METAL=13000)
	attack_verb = list("sawn", "torn", "carved", "chopped", "ripped")
	hitsound = "swing_hit"
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/startchainsaw)
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5
	var/on = FALSE

/obj/item/twohanded/chainsaw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/chainsawhit.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/twohanded/chainsaw/suicide_act(mob/living/carbon/user)
	if(on)
		user.visible_message("<span class='suicide'>[user] begins to tear [user.p_their()] head off with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/chainsawhit.ogg', 100, 1)
		var/obj/item/bodypart/head/myhead = user.get_bodypart(BODY_ZONE_HEAD)
		if(myhead)
			myhead.dismember()
	else
		user.visible_message("<span class='suicide'>[user] smashes [src] into [user.p_their()] neck, destroying [user.p_their()] esophagus! It looks like [user.p_theyre()] trying to commit suicide!</span>")
		playsound(src, 'sound/weapons/genhit1.ogg', 100, 1)
	return(BRUTELOSS)

/obj/item/twohanded/chainsaw/attack_self(mob/user)
	on = !on
	to_chat(user, "As you pull the starting cord dangling from [src], [on ? "it begins to whirr." : "the chain stops moving."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : force
	update_icon()
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = on

	if(on)
		hitsound = 'sound/weapons/chainsawhit.ogg'
	else
		hitsound = "swing_hit"

/obj/item/twohanded/chainsaw/update_icon_state()
	icon_state = "chainsaw_[on ? "on" : "off"]"

//THERMIC LANCE
/obj/item/twohanded/thermic_lance
	name = "thermic lance"
	desc = "A versatile power-welding tool. Useful for cutting apart metal and limbs."
	icon_state = "thermiclance_off"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	slot_flags = ITEM_SLOT_BACK
	force = 5
	var/force_on = 60
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 20
	throw_speed = 2
	throw_range = 4
//	custom_materials = list(MAT_METAL=13000)
	attack_verb = list("burned", "welded", "cauterized", "melted", "charred")
	hitsound = "swing_hit"
	actions_types = list(/datum/action/item_action/toggle_lance)
	var/on = FALSE

/obj/item/twohanded/thermic_lance/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddElement(/datum/element/update_icon_updates_onmob)


/obj/item/twohanded/thermic_lance/attack_self(mob/user)
	on = !on
	to_chat(user, "As you turn the lever from [src], [on ? "it begins to heat." : "the flame goes off."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	update_icon()

	if(on)
		hitsound = 'sound/items/welder2.ogg'
		damtype = "fire"
	else
		hitsound = "swing_hit"
		damtype = "brute"

	if(src == user.get_active_held_item()) //update inhands
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/twohanded/thermic_lance/update_icon_state()
	icon_state = "thermiclance_[on ? "on" : "off"]"

//Baseball

/obj/item/twohanded/baseball
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baseball0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 15
	throwforce = 15
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("beat", "smacked", "clubbed", "clobbered")
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_NONE
	icon_prefix = "baseball"

/obj/item/twohanded/baseball/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 30, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/baseball/spiked
	name = "spiked baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter, especially with large nails drilled through the top of it."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baseballspike0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 20
	throwforce = 20
	icon_prefix = "baseballspike"

/obj/item/twohanded/baseball/spiked/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 20, force_wielded = 35, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/sledgehammer
	name = "sledgehammer"
	desc = "A heavy sledgehammer that lost most of its use besides caving in heads."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "sledgehammer0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 25
	throwforce = 30
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_NONE
	icon_prefix = "sledgehammer"

/obj/item/twohanded/sledgehammer/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 45, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/sledgehammer/supersledge
	name = "super sledge"
	desc = "A heavy sledgehammer manufacted from ultra-dense materials, developed by the Brotherhood of Steel. It looks like it could crush someone's skull with ease."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "supersledge0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 25
	icon_prefix = "supersledge"

obj/item/twohanded/sledgehammer/supersledge/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 60, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/sledgehammer/atomsjudgement
	name = "atom's judgement"
	desc = "A heavy sledgehammer manufacted from ultra-dense materials. The head of this hammer seems to of been replaced with four fusion cores, shorted to discharge its fissle material."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "atom_hammer0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 25
	icon_prefix = "atom_hammer"

/obj/item/twohanded/sledgehammer/atomsjudgement/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 60, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/sledgehammer/atomsjudgement/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_effect(300, EFFECT_IRRADIATE, 0)

/obj/item/twohanded/sledgehammer/warmace
	name = "war mace"
	desc = "A heavy wooden club with a turquoise head."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "warmace0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 25
	throwforce = 20
	armour_penetration = 0.5
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_NONE
	icon_prefix = "warmace"

/obj/item/twohanded/sledgehammer/atomsjudgement/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 25, force_wielded = 45, icon_wielded="[icon_prefix]1")


/obj/item/twohanded/sledgehammer/shamanstaff
	name = "shaman staff"
	desc = "An intricate staff, carried for centuries by the shaman class of the Wayfayer Tribe."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "shamanstaff0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	force = 15
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "thrashed")
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_NONE
	icon_prefix = "shamanstaff"

/obj/item/twohanded/sledgehammer/shamanstaff/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 15, force_wielded = 30, icon_wielded="[icon_prefix]1")

/obj/item/twohanded/sledgehammer/marsstaff
	name = "Staff of Mars"
	desc = "A staff crafted by the guidance of Mars."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "mars_staff0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	hitsound = "swing_hit"
	attack_verb = list("bashed", "pounded", "bludgeoned", "pummeled", "enlightened")
	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_NONE
	icon_prefix = "mars_staff"

var/brightness_on = 6 //TWICE AS BRIGHT AS A REGULAR ESWORD
var/list/possible_colors = list("red")

/obj/item/twohanded/sledgehammer/marsstaff/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded = 5, force_wielded = 10, icon_wielded="[icon_prefix]1")

/*
/obj/item/twohanded/sledgehammer/marsstaff/update_icon()
	if(wielded)
		playsound(loc, 'sound/effects/torch_light.ogg', 50, 0)
		light_color = LIGHT_COLOR_RED
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		sharpness = SHARP_NONE
	*/
/obj/item/twohanded/sledgehammer/marsstaff/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(2, BURN, 0)
	M.apply_damage(25, STAMINA, null, 0)

/obj/item/twohanded/sledgehammer/marsstaff/pickup(mob/living/user, slot)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/U = user
		if(U.job in list("Priestess of Mars"))
		else
			to_chat(user, "<span class='userdanger'>You invoke the wrath of Mars!</span>")
			user.emote("scream")
			user.apply_damage(30, BURN, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
			user.dropItemToGround(src, TRUE)
			user.Knockdown(50)
		return
/*
/obj/item/twohanded/sledgehammer/marsstaff/unwield() //Specific unwield () to switch hitsounds.
	sharpness = SHARP_NONE
	..()
	STOP_PROCESSING(SSobj, src)
	set_light(0)
*/
//COMMENTED OUT STUFF

/* Im not removing it, but commenting it out. Its a good example of stuff, but it isnt really good for the server, no?
//GREY TIDE
/obj/item/twohanded/spear/grey_tide
	icon_state = "spearglass0"
	name = "\improper Grey Tide"
	desc = "Recovered from the aftermath of a revolt aboard Defense Outpost Theta Aegis, in which a seemingly endless tide of Assistants caused heavy casualities among Nanotrasen military forces."
	throwforce = 20
	throw_speed = 4
	attack_verb = list("gored")
	var/clonechance = 50
	var/clonedamage = 12
	var/clonespeed = 0
	var/clone_replication_chance = 30
	var/clone_lifespan = 100


/obj/item/twohanded/spear/grey_tide/afterattack(atom/movable/AM, mob/living/user, proximity)
	. = ..()
	if(!proximity)
		return
	user.faction |= "greytide([REF(user)])"
	if(isliving(AM))
		var/mob/living/L = AM
		if(istype (L, /mob/living/simple_animal/hostile/illusion))
			return
		if(!L.stat && prob(50))
			var/mob/living/simple_animal/hostile/illusion/M = new(user.loc)
			M.faction = user.faction.Copy()
			M.Copy_Parent(user, 100, user.health/2.5, 12, 30)
			M.GiveTarget(L)



/obj/item/twohanded/bonespear/venom //added for Viper raiders -Thes
	container_type = INJECTABLE
	name = "Viper spear"
	desc = "A bone spear which has been modified to envenomate targets without drawing as much blood. Wielding it with both hands allows for stronger blows, but renders the venom ineffective.<br>It has been designed to allow for easily refitting the tip with a typical spear blade after the venom is dry."
	force_unwielded = 11 //unwielded force decreased to reflect special spear point design and prevent excessive damage during envenomation


/obj/item/twohanded/bonespear/venom/attack(mob/living/L, mob/user)
	..()
	if(!istype(L))
		return

	if(!wielded) //sends empty message when venom is dry and defaults back to normal attack, and allows for injection attack if possible//
		if(!reagents.total_volume)
			to_chat(user, "<span class='warning'>[src]'s venom has been used up!</span>")
		else
			if(L.can_inject(user, 1))
				to_chat(user, "<span class='warning'>Your light strike successfully injects venom into [L]'s veins.</span>")
				. = 1

				add_logs(user, L, "stabbed", src) //left this here, but it may or may not work properly

				var/amount_per_transfer_from_this = 8
				var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

				if(reagents.total_volume)
					if(L.reagents)
						reagents.reaction(L, INJECT, fraction)
						reagents.trans_to(L, amount_per_transfer_from_this)
			else
				..()

/obj/item/twohanded/bonespear/venom/Initialize()
	. = ..()
	create_reagents(72) //mix that causes quick incap without significant risk of death, at least with one attacker. 4-5 attacks on a single target typically causes histamine symptoms, fatigue, sleep, as well as minor suffocation, toxins, and possible liver damage
	reagents.add_reagent(/datum/reagent/venom,12)
	reagents.add_reagent(/datum/reagent/sodium_thiopental, 50)
	reagents.add_reagent(/datum/reagent/pancuronium, 10)
//end of Viper spear. Venom mix is interesting but a simpler poisoned weapon solution might be more generally useful, with injectable or open container weapons that have lower volume but can be easily refilled with small doses of venom or something
*/

/obj/item/twohanded/chainsaw/doomslayer
	name = "THE GREAT COMMUNICATOR"
	desc = "<span class='warning'>VRRRRRRR!!!</span>"
	armour_penetration = 1
	force_on = 30

/obj/item/twohanded/chainsaw/doomslayer/check_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	block_return[BLOCK_RETURN_REFLECT_PROJECTILE_CHANCE] = 100
	return ..()

/obj/item/twohanded/chainsaw/doomslayer/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(attack_type & ATTACK_TYPE_PROJECTILE)
		owner.visible_message("<span class='danger'>Ranged attacks just make [owner] angrier!</span>")
		playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, 1)
		return BLOCK_SUCCESS | BLOCK_PHYSICAL_EXTERNAL
	return ..()
