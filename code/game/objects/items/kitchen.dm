/* Kitchen tools
 * Contains:
 *		Fork
 *		Kitchen knives
 *		Ritual Knife
 *		Bloodletter
 *		Butcher's cleaver
 *		Combat Knife
 *		Rolling Pins
 */

/obj/item/kitchen
	icon = 'icons/obj/kitchen.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'

/obj/item/kitchen/fork
	name = "fork"
	desc = "Pointy."
	icon_state = "fork"
	force = 5
	w_class = WEIGHT_CLASS_TINY
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	custom_materials = list(/datum/material/iron=80)
	flags_1 = CONDUCT_1
	attack_verb = list("attacked", "stabbed", "poked")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 30)
	sharpness = SHARP_POINTY
	var/datum/reagent/forkload //used to eat omelette

/obj/item/kitchen/fork/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] stabs \the [src] into [user.p_their()] chest! It looks like [user.p_theyre()] trying to take a bite out of [user.p_them()]self!</span>")
	playsound(src, 'sound/items/eatfood.ogg', 50, 1)
	return BRUTELOSS

/obj/item/kitchen/fork/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(!istype(M))
		return ..()

	if(forkload)
		if(M == user)
			M.visible_message("<span class='notice'>[user] eats a delicious forkful of omelette!</span>")
			M.reagents.add_reagent(forkload.type, 1)
		else
			M.visible_message("<span class='notice'>[user] feeds [M] a delicious forkful of omelette!</span>")
			M.reagents.add_reagent(forkload.type, 1)
		icon_state = "fork"
		forkload = null

	else if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/kitchen/fork/throwing
	name = "throwing fork"
	desc = "A fork, sharpened to perfection, making it a great weapon for throwing."
	throwforce = 15
	throw_speed = 4
	throw_range = 6
	embedding = list("pain_mult" = 2, "embed_chance" = 100, "fall_chance" = 0, "embed_chance_turf_mod" = 15)
	sharpness = SHARP_EDGED

/obj/item/kitchen/knife
	name = "kitchen knife"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "knife_kitchen"
	desc = "Keep hackin' and whackin' and smackin'."
	flags_1 = CONDUCT_1
	force = 15
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 6
	custom_materials = list(/datum/material/iron=12000)
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_POINTY
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	var/bayonet = FALSE	//Can this be attached to a gun?
	wound_bonus = -5
	bare_wound_bonus = 10
	custom_price = PRICE_NORMAL

/obj/item/kitchen/knife/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/kitchen/knife/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/kitchen/knife/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is slitting [user.p_their()] wrists with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting [user.p_their()] throat with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting [user.p_their()] stomach open with the [src.name]! It looks like [user.p_theyre()] trying to commit seppuku.</span>"))
	return (BRUTELOSS)


/*
/obj/item/kitchen/knife/bloodletter
	name = "bloodletter"
	desc = "An occult looking dagger that is cold to the touch. Somehow, the flawless orb on the pommel is made entirely of liquid blood."
	icon = 'icons/obj/ice_moon/artifacts.dmi'
	icon_state = "bloodletter"
	w_class = WEIGHT_CLASS_NORMAL
	/// Bleed stacks applied when an organic mob target is hit
	var/bleed_stacks_per_hit = 3

/obj/item/kitchen/knife/bloodletter/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!isliving(target) || !proximity_flag)
		return
	var/mob/living/M = target
	if(!(M.mob_biotypes & MOB_ORGANIC))
		return
	var/datum/status_effect/stacking/saw_bleed/bloodletting/B = M.has_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting)
	if(!B)
		M.apply_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting, bleed_stacks_per_hit)
	else
		B.add_stacks(bleed_stacks_per_hit)
*/
/obj/item/kitchen/knife/butcher
	name = "butcher's cleaver"
	icon_state = "knife_cleaver"
	desc = "Heavy bladed tool for chopping meat."
	flags_1 = CONDUCT_1
	force = 25
	throwforce = 15
	custom_materials = list(/datum/material/iron=18000)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PRICE_EXPENSIVE

/obj/item/kitchen/knife/combat
	name = "hunting knife"
	icon_state = "knife_hunting"
	item_state = "knife"
	desc = "Dependable hunting knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 30
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")
	bayonet = TRUE

/obj/item/kitchen/knife/combat/survival
	name = "survival knife"
	icon_state = "knife_survival"
	item_state = "knife"
	desc = "Multi-purpose knife with blackened steel."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 25
	throwforce = 25
	bayonet = TRUE

/obj/item/kitchen/knife/combat/bayonet
	name = "bayonet knife"
	icon_state = "knife_bayonet"
	item_state = "knife"
	desc = "This weapon is made for stabbing, not much use for other things."
	force = 25
	throwforce = 15
	armour_penetration = 0.1

/obj/item/kitchen/knife/bowie
	name = "bowie knife"
	icon_state = "knife_bowie"
	item_state = "knife"
	desc = "A large clip point fighting knife."
	force = 33
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/kitchen/knife/trench
	name = "trench knife"
	icon_state = "knife_trench"
	item_state = "knife"
	desc = "This blade is designed for brutal close quarters combat."
	force = 35
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/kitchen/knife/combat/bone
	name = "bone dagger"
	item_state = "bone_dagger"
	icon_state = "bone_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharpened bone. The bare minimum in survival."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 20
	throwforce = 20
	custom_materials = null

/obj/item/kitchen/knife/ritualdagger
	name = "ritual dagger"
	desc = "An ancient blade used to carry out the spiritual rituals of the Wayfarer people."
	icon_state = "crysknife"
	item_state = "crysknife"
	force = 25
	throwforce = 20
	armour_penetration = 0.2

/obj/item/kitchen/knife/combat/cyborg
	name = "cyborg knife"
	icon = 'icons/obj/items_cyborg.dmi'
	icon_state = "knife"
	desc = "A cyborg-mounted plasteel knife. Extremely sharp and durable."

/obj/item/kitchen/rollingpin
	name = "rolling pin"
	desc = "Used to knock out the Bartender."
	icon_state = "rolling_pin"
	force = 8
	throwforce = 5
	throw_speed = 3
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 1.5)
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")
	custom_price = PRICE_ALMOST_CHEAP

/obj/item/kitchen/rollingpin/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins flattening [user.p_their()] head with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS


/obj/item/kitchen/knife/cosmicdirty
	name = "dirty cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy."
	icon_state = "knife_cosmic_dirty"
	item_state = "knife"
	force = 15
	throwforce = 10
	armour_penetration = 0.2

/obj/item/kitchen/knife/cosmic
	name = "cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one seems to be in better condition."
	icon_state = "knife_cosmic"
	item_state = "knife"
	force = 25
	throwforce = 15
	armour_penetration = 0.2

/obj/item/kitchen/knife/cosmicheated
	name = "superheated cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one looks like it has been heated to high temperatures."
	icon_state = "knife_cosmic_heated"
	item_state = "knife"
	damtype = BURN
	force = 35
	throwforce = 20
	armour_penetration = 0.4
/*
/obj/item/kitchen/knife/combat/bone/plastic
	name = "plastic knife"
	desc = "A plastic knife. Rather harmless to anything."
	force = 1
	throwforce = 1
	bayonet = FALSE

/obj/item/kitchen/knife/ritual
	name = "ritual knife"
	desc = "Used for blood sacrifices."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "render"
	item_state = "knife"
	lefthand_file = 'icons/mob/inhands/equipment/kitchen_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/kitchen_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/kitchen/knife/scimitar
	name = "Scimitar knife"
	desc = "A knife used to cleanly butcher. Its razor-sharp edge has been honed for butchering, but has been poorly maintained over the years."
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/kitchen/knife/scimiar/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 90 - force, 100, force - 60) //bonus chance increases depending on force
*/
