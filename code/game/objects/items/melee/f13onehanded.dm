//SS13 weapons that are parents to F13 weapons or still used may be included here
//Unlike weaponry.dm, everything in here should be balanced for F13 combat.


/obj/item/melee //Melee weapon template
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 50)

/obj/item/melee/onehanded
	name = "onehand melee template"
	desc = "should not exist"
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 30
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON


////////////
// SWORDS //
////////////		-block, 30-40 damage

/obj/item/melee/onehanded/machete
	name = "simple machete"
	desc = "A makeshift machete made of a lawn mower blade."
	icon_state = "machete_imp"
	item_state = "salvagedmachete"
	force = 32
	block_chance = 5
	throwforce = 20
	sharpness = SHARP_EDGED


/obj/item/melee/onehanded/machete/forgedmachete
	name = "machete"
	desc = "A forged machete made of high quality steel."
	icon_state = "machete"
	force = 35
	block_chance = 8

/obj/item/melee/onehanded/machete/training
	name = "training machete"
	desc = "A training machete made of tough wood."
	icon_state = "machete_training"
	force = 1
	throwforce = 5
	block_chance = 8

/obj/item/melee/onehanded/machete/training/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, null, 0)

/obj/item/melee/onehanded/machete/gladius
	name = "gladius"
	desc = "A heavy cutting blade, made for war and mass produced in Legion territory."
	icon_state = "gladius"
	item_state = "gladius"
	force = 36
	block_chance = 10

/obj/item/melee/onehanded/machete/spatha
	name = "spatha"
	desc = "This long blade is favoured by Legion officers and leaders, a finely crafted weapon with good steel and hilt made from bronze and bone."
	icon_state = "spatha"
	item_state = "spatha"
	force = 40
	block_chance = 15

/obj/item/claymore/machete //obsolete
	name = "machete"
	desc = "A makeshift machete made of a lawn mower blade."
	icon_state = "machete_imp"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	item_state = "salvagedmachete"
	slot_flags = ITEM_SLOT_BELT
	force = 30
	block_chance = 5

/obj/item/claymore/machete/reinforced //obsolete
	name = "reinforced machete"
	desc = "A reinforced machete made of high quality steel."
	icon_state = "machete"
	force = 35

/obj/item/claymore/machete/training //obsolete
	name = "training machete"
	desc = "A training machete made of tough wood."
	icon_state = "machete_training"
	force = 0
	throwforce = 5

/obj/item/claymore/machete/training/attack(mob/living/M, mob/living/user)//obsolete
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, null, 0)

/obj/item/claymore/machete/gladius//obsolete
	name = "gladius"
	desc = "A heavy cutting blade, made for war and mass produced in Legion territory."
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "gladius"
	item_state = "gladius"
	slot_flags = ITEM_SLOT_BELT
	force = 35
	throwforce = 25
	block_chance = 10

/obj/item/claymore/machete/spatha//obsolete
	name = "spatha"
	desc = "This long blade is favoured by Legion officers and leaders, a finely crafted weapon with good steel and hilt made from bronze and bone."
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "spatha"
	item_state = "spatha"
	slot_flags = ITEM_SLOT_BELT
	force = 40
	throwforce = 25
	block_chance = 15

/obj/item/throwing_star/spear
	name = "throwing spear"
	desc = "An heavy hefty ancient weapon used to this day, due to its ease of lodging itself into its victim's body parts."
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	icon_state = "throw_spear"
	item_state = "tribalspear"
	force = 20
	throwforce = 35
	armour_penetration = 0.10
	max_reach = 2
	item_flags = SLOWS_WHILE_IN_HAND
	slowdown = 0.3
	embedding = list("pain_mult" = 2, "embed_chance" = 60, "fall_chance" = 20)
	w_class = WEIGHT_CLASS_NORMAL




////////////
// KNIVES //
////////////			-small AP bonus, 24-32 damage


/obj/item/melee/onehanded/knife
	name = "knife template"
	desc = "should not exist"
	item_state = "knife"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 0.05
	throw_speed = 3
	throw_range = 6
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_POINTY
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	var/bayonet = FALSE	//Can this be attached to a gun?
	bare_wound_bonus = 5
	custom_materials = list(/datum/material/iron=6000)
	resistance_flags = FIRE_PROOF

/obj/item/melee/onehanded/knife/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/melee/onehanded/knife/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/melee/onehanded/knife/suicide_act(mob/user)
	user.visible_message(pick("<span class='suicide'>[user] is slitting [user.p_their()] wrists with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting [user.p_their()] throat with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide.</span>", \
						"<span class='suicide'>[user] is slitting [user.p_their()] stomach open with the [src.name]! It looks like [user.p_theyre()] trying to commit seppuku.</span>"))
	return (BRUTELOSS)


/obj/item/melee/onehanded/knife/hunting
	name = "hunting knife"
	icon_state = "knife_hunting"
	desc = "Dependable hunting knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 28
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")

/obj/item/melee/onehanded/knife/survival
	name = "survival knife"
	icon_state = "knife_survival"
	desc = "Multi-purpose knife with blackened steel."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 27
	throwforce = 25

/obj/item/melee/onehanded/knife/bayonet
	name = "bayonet knife"
	icon_state = "knife_bayonet"
	desc = "This weapon is made for stabbing, not much use for other things."
	force = 26
	bayonet = TRUE

/obj/item/melee/onehanded/knife/bowie
	name = "bowie knife"
	icon_state = "knife_bowie"
	item_state = "knife_bowie"
	desc = "A large clip point fighting knife."
	force = 31
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/melee/onehanded/knife/trench
	name = "trench knife"
	icon_state = "knife_trench"
	item_state = "knife_trench"
	desc = "This blade is designed for brutal close quarters combat."
	force = 32
	custom_materials = list(/datum/material/iron=8000)
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/melee/onehanded/knife/bone
	name = "bone dagger"
	item_state = "knife_bone"
	icon_state = "knife_bone"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharpened bone. The bare minimum in survival."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 24
	throwforce = 20
	custom_materials = null

/obj/item/melee/onehanded/knife/ritualdagger
	name = "ritual dagger"
	desc = "An ancient blade used to carry out the spiritual rituals of the Wayfarer people."
	icon_state = "knife_ritual"
	item_state = "knife_ritual"
	force = 25
	armour_penetration = 0.1
	custom_materials = null

/obj/item/melee/onehanded/knife/switchblade
	name = "switchblade"
	desc = "A sharp, concealable, spring-loaded knife."
	icon_state = "knife_switch"
	force = 3
	throwforce = 5
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb = list("stubbed", "poked")
	var/extended = 0
	var/extended_force = 24
	var/extended_throwforce = 23
	var/extended_icon_state = "knife_switch_ext"
	var/retracted_icon_state = "knife_switch"

/obj/item/melee/onehanded/knife/switchblade/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 40, 105)

/obj/item/melee/onehanded/knife/switchblade/attack_self(mob/user)
	extended = !extended
	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	if(extended)
		force = extended_force
		w_class = WEIGHT_CLASS_NORMAL
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = SHARP_EDGED
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_SMALL
		throwforce = initial(throwforce)
		icon_state = retracted_icon_state
		attack_verb = list("stubbed", "poked")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = SHARP_NONE

/obj/item/melee/onehanded/knife/cosmicdirty
	name = "dirty cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy."
	icon_state = "knife_cosmic_dirty"
	item_state = "knife"
	force = 15
	throwforce = 10
	armour_penetration = 0.2

/obj/item/melee/onehanded/knife/cosmic
	name = "cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one seems to be in better condition."
	icon_state = "knife_cosmic"
	item_state = "knife"
	force = 25
	throwforce = 15
	armour_penetration = 0.2

/obj/item/melee/onehanded/knife/cosmicheated
	name = "superheated cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one looks like it has been heated to high temperatures."
	icon_state = "knife_cosmic_heated"
	item_state = "knife"
	damtype = BURN
	force = 35
	throwforce = 20
	armour_penetration = 0.4


///////////
// CLUBS //
///////////			- stamina damage, 26-32 damage


/obj/item/melee/onehanded/club
	name = "pipe"
	desc = "A piece of rusted metal pipe, good for smashing heads. "
	icon_state = "pipe"
	item_state = "pipe"
	attack_verb = list("mashed", "bashed", "piped", "hit", "bludgeoned", "whacked", "bonked")
	force = 26
	throwforce = 10
	throw_speed = 3
	throw_range = 3
	sharpness = SHARP_NONE
	slot_flags = SLOT_BELT

/obj/item/twohanded/baseball/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(10, STAMINA, null, 0)

/obj/item/melee/onehanded/club/warclub
	name = "war club"
	desc = "A simple carved wooden club with turquoise inlays."
	icon_state = "warclub"
	item_state = "warclub"
	attack_verb = list("mashed", "bashed", "hit", "bludgeoned", "whacked")
	force = 32
	throwforce = 25
	block_chance = 5

/obj/item/twohanded/baseball/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, null, 0)

/obj/item/melee/onehanded/club/tireiron
	name = "tire iron"
	desc = "A rusty old tire iron, normally used for loosening nuts from car tires.<br>Though it has a short reach, it has decent damage and a fast swing."
	icon_state = "tire"
	item_state = "tire"
	force = 32


/obj/item/claymore/machete/warclub //obsolete
	name = "war club"
	desc = "A simple carved wooden club with turquoise inlays."
	icon_state = "warclub"
	item_state = "warclub"
	attack_verb = list("mashed", "bashed", "hit", "bludgeoned", "whacked")
	force = 34
	throwforce = 25
	block_chance = 10
	armour_penetration = 0.1
	sharpness = SHARP_NONE
/obj/item/claymore/machete/pipe/pan //obsolete
	name = "frying pan"
	desc = "An ancient cast iron frying pan.<br>It's heavy, but fairly useful if you need to keep the mutants away, and don't have a better weapon around."
	icon_state = "pan"
	item_state = "pan"
/obj/item/claymore/machete/pipe //obsolete
	name = "pipe"
	desc = "A heavy rusted pipe, good for smashing heads. "
	icon_state = "pipe"
	item_state = "pipe"

/obj/item/claymore/machete/golf//obsolete

/obj/item/claymore/machete/pipe/tireiron//obsolete

/obj/item/bostaff/ncr_flag
	name = "NCR flagpole"
	desc = "The proud standard of the New California Republic. Used as a tool by patriots, used as a weapon by legends."
	attack_verb = list("smacked", "thwacked", "democratized", "freedomed")
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	force = 20
	block_chance = 50
	icon_state = "ncr_flag"
	item_state = "ncr_flag"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'


///////////////////
// GLOVE WEAPONS //
///////////////////


/obj/item/melee/unarmed
	name = "glove weapon template"
	desc = "should not be here"
	var/can_adjust_unarmed = TRUE
	var/unarmed_adjusted = TRUE
	flags_1 = CONDUCT_1
	attack_verb = list("punched", "jabbed", "whacked")
	sharpness = SHARP_NONE
	throwforce = 10
	throw_range = 5
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/unarmed/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(unarmed_adjusted)
		mob_overlay_icon = righthand_file
	if(!unarmed_adjusted)
		mob_overlay_icon = lefthand_file
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh = force + 8 //The +8 damage is what brings up your punch damage to the unarmed weapon's force fully
			H.dna.species.punchdamagelow = force + 8
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = pick("slash","slice","rip","tear","cut","dice")
			if(sharpness == SHARP_NONE)
				H.dna.species.attack_verb = pick("punch","jab","whack")
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh = 1
			H.dna.species.punchdamagelow = 10
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 4
			H.dna.species.punchdamagelow = 11
		H.dna.species.attack_sound = 'sound/weapons/punch1.ogg'
		H.dna.species.attack_verb = "punch"

/obj/item/melee/unarmed/examine(mob/user)
	. = ..()
	if(can_adjust_unarmed == TRUE)
		if(unarmed_adjusted == TRUE)
			. += "<span class='notice'>Alt-click on [src] to wear it on a different hand. You must take it off first, then put it on again.</span>"
		else
			. += "<span class='notice'>Alt-click on [src] to wear it on a different hand. You must take it off first, then put it on again.</span>"

/obj/item/melee/unarmed/AltClick(mob/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ishuman(user)))
		return
	if(can_adjust_unarmed == TRUE)
		toggle_unarmed_adjust()

/obj/item/melee/unarmed/proc/toggle_unarmed_adjust()
	unarmed_adjusted = !unarmed_adjusted
	to_chat(usr, "<span class='notice'>[src] is ready to be worn on another hand.</span>")


// Brass knuckles					Keywords: Damage 23
/obj/item/melee/unarmed/brass
	name = "brass knuckles"
	desc = "Hardened knuckle grip that is actually made out of steel. They protect your hand, and do more damage, in unarmed combat."
	icon_state = "brass"
	item_state = "brass"
	attack_verb = list("punched", "jabbed", "whacked")
	force = 23


// Spiked knuckles					Keywords: Damage 24
/obj/item/melee/unarmed/brass/spiked
	name = "spiked knuckes"
	desc = "Unlike normal brass knuckles, these have a metal plate across the knuckles with four spikes on, one for each knuckle. So not only does the victim feel the force of the punch, but also the devastating effects of spikes being driven in."
	icon_state = "spiked"
	item_state = "spiked"
	force = 24


// Sappers							Keywords: Damage 26
/obj/item/melee/unarmed/sappers
	name = "sappers"
	desc = "Lead filled gloves which are ideal for beating the crap out of opponents."
	icon_state = "sapper"
	item_state = "sapper"
	force = 26
	w_class = WEIGHT_CLASS_NORMAL


// Tiger claws						Keywords: Damage 27
/obj/item/melee/unarmed/tigerclaw
	name = "tiger claws"
	desc = "Gloves with short claws built into the palms."
	icon_state = "tiger_claw"
	item_state = "tiger_claw"
	force = 27
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_NORMAL


// Lacerator						Keywords: Damage 28
/obj/item/melee/unarmed/lacerator
	name = "lacerator"
	desc = "Leather gloves with razor blades built into the back of the hand."
	icon_state = "lacerator"
	item_state = "lacerator"
	force = 28
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL


// Mace Glove						Keywords: Damage 30
/obj/item/melee/unarmed/maceglove
	name = "mace glove"
	desc = "Weighted metal gloves that are covered in spikes.  Don't expect to grab things with this."
	icon_state = "mace_glove"
	item_state = "mace_glove"
	force = 30
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_BULKY


// Punch Dagger						Keywords: Damage 30
/obj/item/melee/unarmed/punchdagger
	name = "punch dagger"
	desc = "A dagger designed to be gripped in the user�s fist with the blade protruding between the middle and ring fingers, to increase the penetration of a punch."
	icon_state = "punch_dagger"
	item_state = "punch_dagger"
	force = 30
	attack_verb = list("stabbed", "sliced", "pierced", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_POINTY


// Deathclaw Gauntlet				Keywords: Damage 30, AP 1
/obj/item/melee/unarmed/deathclawgauntlet
	name = "deathclaw gauntlet"
	desc = "The severed hand of a mighty Deathclaw, cured, hollowed out, and given a harness to turn it into the deadliest gauntlet the wastes have ever seen."
	icon_state = "deathclaw_g"
	item_state = "deathclaw_g"
	force = 30
	armour_penetration = 1 //there is no such thing as armor to the claws of death
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL



///////////
// TOOLS //
///////////		-generally max 24 damage


/obj/item/melee/onehanded/knife/kitchen
	name = "kitchen knife"
	desc = "Simple kitchen knife.."
	icon_state = "knife_kitchen"
	force = 15
	armour_penetration = 0

/obj/item/melee/onehanded/knife/butcher
	name = "butcher's cleaver"
	desc = "Keep hackin' and whackin' and smackin'."
	icon_state = "knife_butcher"
	item_state = "knife_butcher"
	w_class = WEIGHT_CLASS_NORMAL
	force = 24
	armour_penetration = 0
	custom_materials = list(/datum/material/iron=8000)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/melee/onehanded/club/rollingpin
	name = "rolling pin"
	desc = "Intended for baking, could in theory be used as a awkward club."
	icon_state = "rolling_pin"
	force = 10
	attack_verb = list("bashed", "battered", "bludgeoned", "thrashed", "whacked")

/obj/item/melee/onehanded/club/rollingpin/suicide_act(mob/living/carbon/user)
	user.visible_message("<span class='suicide'>[user] begins flattening [user.p_their()] head with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return BRUTELOSS

/obj/item/melee/onehanded/club/fryingpan
	name = "frying pan"
	desc = "An ancient cast iron frying pan.<br>It's heavy, but fairly useful if you need to keep the mutants away, and don't have a better weapon around."
	icon_state = "pan"
	item_state = "pan"
	force = 24 //Just try to swing a frying pan//BONK
	throw_speed = 1
	throw_range = 3
	throwforce = 20
	hitsound = 'sound/f13weapons/pan.ogg'

/obj/item/shovel/trench
	name = "p81 entrenching tool"
	desc = "The 'Pattern 2281' Entrenching Tool is a new piece of infantry equipment given in limited quantity to infantry troops. An extremely robust shovel with a serrated edge for chopping wood."
	icon_state = "entrenching_tool"
	item_state = "trench"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 30
	throwforce = 15
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	attack_verb = list("cleaved", "chopped", "sliced", "slashed")
	sharpness = SHARP_EDGED

/obj/item/hatchet
	name = "hatchet"
	desc = "Simple small metal axehead on a handle made from wood or some other hard material."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "hatchet"
	item_state = "hatchet"
	lefthand_file = 'icons/mob/inhands/equipment/hydroponics_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/hydroponics_righthand.dmi'
	attack_speed = CLICK_CD_MELEE
	flags_1 = CONDUCT_1
	force = 24
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 3
	throw_range = 4
	custom_materials = list(/datum/material/iron = 6000)
	attack_verb = list("chopped", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/hatchet/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)

/obj/item/hatchet/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is chopping at [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return (BRUTELOSS)

// Wrench force 12
// Crowbar force 15
