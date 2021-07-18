//SS13 weapons that are parents to F13 weapons or still used may be included here
//Unlike weaponry.dm, everything in here should be balanced for F13 combat.

//Inherited from SS13
/obj/item/claymore
	name = "claymore"
	desc = "What are you standing around staring at this for? Get to killing!"
	icon_state = "claymore"
	item_state = "claymore"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 30
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	block_chance = 15
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON

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
	block_chance = 10
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 50)
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON

//F13 Weapons


////////////
// SWORDS //
////////////		-block

/obj/item/melee/onehanded/machete
	name = "simple machete"
	desc = "A makeshift machete made of a lawn mower blade."
	icon_state = "machete_imp"
	item_state = "salvagedmachete"
	force = 32
	block_chance = 5
	throwforce = 20

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
////////////			-small AP bonus


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
	force = 25
	armour_penetration = 0
	custom_materials = list(/datum/material/iron=8000)
	attack_verb = list("cleaved", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")


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
	force = 33
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
	force = 20
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
///////////			- stamina damage

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

/obj/item/melee/onehanded/club
	name = "pipe"
	desc = "A piece of rusted metal pipe, good for smashing heads. "
	icon_state = "pipe"
	item_state = "pipe"
	attack_verb = list("mashed", "bashed", "piped", "hit", "bludgeoned", "whacked", "bonked")
	force = 25
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
	force = 35
	throwforce = 25
	block_chance = 10
	armour_penetration = 0.1

/obj/item/melee/onehanded/club/tireiron
	name = "tire iron"
	desc = "A rusty old tire iron, normally used for loosening nuts from car tires.<br>Though it has a short reach, it has decent damage and a fast swing."
	icon_state = "tire"
	item_state = "tire"
	force = 33

/obj/item/melee/onehanded/club/fryingpan
	name = "frying pan"
	desc = "An ancient cast iron frying pan.<br>It's heavy, but fairly useful if you need to keep the mutants away, and don't have a better weapon around."
	icon_state = "pan"
	item_state = "pan"
	force = 24 //Just try to swing a frying pan//BONK
	throw_speed = 1
	throw_range = 2
	throwforce = 20
	hitsound = 'sound/f13weapons/pan.ogg'


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



/////////////////////////////////
// ADVANCED ONE HANDED WEAPONS //
/////////////////////////////////	


// Ripper							Keywords: Damage 10/45, Wound bonus, block		
/obj/item/melee/powered/ripper
	name = "ripper"
	desc = "The Ripper™ vibroblade is powered by a small energy cell wich allows it to easily cut through flesh and bone."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	icon_state = "ripper"
	var/on_icon_state = "ripper_on"
	var/off_icon_state = "ripper"
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	var/on_item_state = "ripper_on"
	var/off_item_state = "ripper"
	w_class = WEIGHT_CLASS_BULKY
	var/weight_class_on = WEIGHT_CLASS_HUGE
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
	force = 10
	var/force_on = 45
	var/force_off = 10
	wound_bonus = 25
	block_chance = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	var/on = FALSE
	tool_behaviour = TOOL_SAW
	sharpness = SHARP_EDGED
	toolspeed = 1.5 //slower than a real saw
	resistance_flags = FIRE_PROOF
	hitsound = 'sound/weapons/chainsawhit.ogg'
	var/on_sound = 'sound/weapons/chainsawhit.ogg'

// Description for when turning the ripper on
/obj/item/melee/powered/ripper/proc/get_on_description()
	. = list()
	.["local_on"] = "<span class ='warning'>You thumb the on button, the whining, blurry edge of the Ripper now lethal to touch.</span>"
	.["local_off"] = "<span class ='notice'>You turn off the Ripper, the buzz of the cutting teeth ceasing.</span>"
	return

/obj/item/melee/powered/ripper/attack_self(mob/user)
	on = !on
	var/list/desc = get_on_description()
	if(on)
		to_chat(user, desc["local_on"])
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = force_on
		slot_flags = null
		attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
		playsound(src.loc, on_sound, 50, 1)
	else
		to_chat(user, desc["local_off"])
		icon_state = off_icon_state
		item_state = off_item_state
		w_class = WEIGHT_CLASS_BULKY
		force = force_off
		slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
		attack_verb = list("poked", "scraped")
	add_fingerprint(user)


//Warhammer chainsword				Keywords: Damage 10/50, Wound bonus, Block, Bonus AP + 0.15
/obj/item/melee/powered/ripper/prewar
	name = "pre-war military ripper"
	desc = "A hand-held, militarized chainsaw, popular with Army units requiring a compact engineering tool for cutting. Just what material is intended to be cut with the weapon remains open to debate."
	icon_state = "prewarrip_off"
	on_icon_state = "prewarrip_on"
	off_icon_state = "prewarrip_off"
	on_item_state = "prewarrip_on"
	off_item_state = "prewarrip_off"
	force_on = 50
	armour_penetration = 0.15


// Shishkebab backpack				Keywords: Damage 10/45, Wound bonus, block	
/obj/item/shishkebabpack
	name = "shishkebab backpack"
	desc = "A backpack containing a large quantity of fuel and a pipe attaching it to a long, deadly blade. You ever wanted to set fire to people with a sword?"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "shishkebabpack"
	item_state = "shishkebabpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
//	actions_types = list(/datum/action/item_action/toggle_shishkebab)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 30)
	resistance_flags = FIRE_PROOF

	var/obj/item/sword

/obj/item/shishkebabpack/Initialize()
	. = ..()
	sword = make_sword()

/obj/item/shishkebabpack/ui_action_click(mob/user)
	toggle_shishkebab(user)

/obj/item/shishkebabpack/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/shishkebabpack/proc/toggle_shishkebab(mob/living/user)
	if(!istype(user))
		return
	if(user.get_item_by_slot(user.getBackSlot()) != src)
		to_chat(user, "<span class='warning'>The backpack must be worn properly to use!</span>")
		return
	if(user.incapacitated())
		return

	if(QDELETED(sword))
		sword = make_sword()
	if(sword in src)
		//Detach the sword into the user's hands
		if(!user.put_in_hands(sword))
			to_chat(user, "<span class='warning'>You need a free hand to hold the shishkebab!</span>")
			return
	else
		//Remove from their hands and put back "into" the tank
		remove_sword()

/obj/item/shishkebabpack/verb/toggle_shishkebab_verb()
	set name = "Toggle Shishkebab"
	set category = "Object"
	toggle_shishkebab(usr)

/obj/item/shishkebabpack/proc/make_sword()
	return new /obj/item/weapon/melee/shishkebab(src)

/obj/item/shishkebabpack/equipped(mob/user, slot)
	..()
	if(slot != SLOT_BACK)
		remove_sword()

/obj/item/shishkebabpack/proc/remove_sword()
	if(ismob(sword.loc))
		var/mob/M = sword.loc
		M.temporarilyRemoveItemFromInventory(sword, TRUE)
	sword.forceMove(src)

/obj/item/shishkebabpack/Destroy()
	QDEL_NULL(sword)
	return ..()

/obj/item/shishkebabpack/attack_hand(mob/user)
	if (user.get_item_by_slot(user.getBackSlot()) == src)
		toggle_shishkebab(user)
	else
		return ..()

/obj/item/shishkebabpack/MouseDrop(obj/over_object)
	var/mob/M = loc
	if(istype(M) && istype(over_object, /obj/screen/inventory/hand))
		var/obj/screen/inventory/hand/H = over_object
		M.putItemFromInventoryInHandIfPossible(src, H.held_index)
	return ..()

/obj/item/shishkebabpack/attackby(obj/item/W, mob/user, params)
	if(W == sword)
		remove_sword()
		return 1
	else
		return ..()

/obj/item/shishkebabpack/dropped(mob/user)
	..()
	remove_sword()

// Shishkebab sword				Keywords: Damage 55 (fire), Welder	
/obj/item/weapon/melee/shishkebab //This should never exist without the backpack.
	name = "shishkebab"
	desc = "A deadly flaming sword covered in fuel. You're not sure this is entirely safe."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "shishkebab"
	item_state = "shishkebab"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	item_flags = ABSTRACT  // don't put in storage
	slot_flags = 0
	force = 55
	damtype = "fire"
	tool_behaviour = TOOL_WELDER
	toolspeed = 0.3

	var/obj/item/shishkebabpack/tank

/obj/item/weapon/melee/shishkebab/Initialize()
	. = ..()
	tank = loc
	if(!istype(tank))
		return INITIALIZE_HINT_QDEL

/obj/item/weapon/melee/shishkebab/attack_self()
	return

/obj/item/weapon/melee/shishkebab/doMove(atom/destination)
	if(destination && (destination != tank.loc || !ismob(destination)))
		if (loc != tank)
			to_chat(tank.loc, "<span class='notice'>The shishkebab slides back into the backpack tank.</span>")
		destination = tank
	..()

/obj/item/mounted_chainsaw
	name = "mounted chainsaw"
	desc = "A chainsaw that has replaced your arm."
	icon_state = "chainsaw_on"
	item_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_BULKY
	force = 56
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	sharpness = SHARP_EDGED
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	total_mass = TOTAL_MASS_HAND_REPLACEMENT
	tool_behaviour = TOOL_SAW
	toolspeed = 1

/obj/item/mounted_chainsaw/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/mounted_chainsaw/Destroy()
	var/obj/item/bodypart/part
	new /obj/item/twohanded/chainsaw(get_turf(src))
	if(iscarbon(loc))
		var/mob/living/carbon/holder = loc
		var/index = holder.get_held_index_of_item(src)
		if(index)
			part = holder.hand_bodyparts[index]
	. = ..()
	if(part)
		part.drop_limb()
