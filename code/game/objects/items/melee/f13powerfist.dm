/obj/item/melee/powerfist
	name = "powerfist"
	desc = "A metal gauntlet with a piston-powered ram on top for that extra 'oomph' in your punch."
	icon_state = "powerfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 40
	armour_penetration = 0.8
	throwforce = 10
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)

//obj/item/melee/powerfist/goliath
//	name = "\improper Goliath" //the Goliath
//	desc = "A metal gauntlet with a piston-powered ram on top. This one has been painted in the colors of Caesar's Legion, and features a brutal metal spike to increase penetration and damage."
//	icon_state = "goliath"
//	force = 40 //you are Strongly Encouraged not to get hit by this.
//	armour_penetration = 0.95 //what is armor?
//	throwforce = 20

/obj/item/melee/goliath //Workaround to the gas issue with the powerfist. No idea why it works.
	name = "Goliath"
	desc = "Armored gauntlet with a piston-powered ram, this one is a experimental one captured and named by the Legion."
	icon_state = "goliath"
	item_state = "goliath"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 40
	armour_penetration = 0.95
	throwforce = 20
	throw_range = 7
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 100, "acid" = 40)


/obj/item/gun/ballistic/revolver/ballisticfist //it's a double-barrel shotgun disguised as a fist shhh
	name = "ballistic fist"
	desc = "This powerfist has been modified to have two shotgun barrels welded to it, with the trigger integrated into the knuckle guard. For those times when you want to punch someone and shoot them in the face at the same time."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "ballisticfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 30
	armour_penetration = 0.7
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = NEEDS_PERMIT //doesn't slow you down
	fire_delay = 0
//	distro = 1
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot

/obj/item/melee/unarmed
	var/can_adjust_unarmed = TRUE
	var/unarmed_adjusted = TRUE

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

/obj/item/melee/unarmed/brass
	name = "brass knuckles"
	desc = "Hardened knuckle grip that is actually made out of steel. They protect your hand, and do more damage, in unarmed combat."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "brass"
	item_state = "brass"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("punched", "jabbed", "whacked")
	sharpness = SHARP_NONE
	force = 20
	throwforce = 10
	throw_range = 7
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/unarmed/brass/spiked
	name = "spiked knuckes"
	desc = "Unlike normal brass knuckles, these have a metal plate across the knuckles with four spikes on, one for each knuckle. So not only does the victim feel the force of the punch, but also the devastating effects of spikes being driven in."
	icon_state = "spiked"
	item_state = "spiked"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 23

/obj/item/melee/unarmed/sappers
	name = "sappers"
	desc = "Lead filled gloves which are ideal for beating the crap out of opponents."
	icon_state = "sapper"
	item_state = "sapper"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 25
	throwforce = 20
	sharpness = SHARP_NONE
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/unarmed/tigerclaw
	name = "tiger claws"
	desc = "Gloves with short claws built into the palms."
	icon_state = "tiger_claw"
	item_state = "tiger_claw"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 25
	throwforce = 10
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_POINTY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/unarmed/bladed
	name = "bladed gauntlet"
	desc = "A weapon composed of a thick, reinforced leather armband with three crude, jagged blades made from scrap metal bound to it with leather straps."
	icon_state = "bladed_g"
	item_state = "bladed_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 27
	throwforce = 10
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL


/obj/item/melee/unarmed/lacerator
	name = "lacerator"
	desc = "Leather gloves with razor blades built into the back of the hand."
	icon_state = "lacerator"
	item_state = "lacerator"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 28
	throwforce = 20
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/unarmed/maceglove
	name = "mace glove"
	desc = "Weighted metal gloves that are covered in spikes.  Don't expect to grab things with this."
	icon_state = "mace_glove"
	item_state = "mace_glove"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 30
	throwforce = 30
	sharpness = SHARP_NONE
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_BULKY

/obj/item/melee/unarmed/punchdagger
	name = "punch dagger"
	desc = "A dagger designed to be gripped in the user�s fist with the blade protruding between the middle and ring fingers, to increase the penetration of a punch."
	icon_state = "punch_dagger"
	item_state = "punch_dagger"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 32
	throwforce = 10
	attack_verb = list("stabbed", "sliced", "pierced", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_POINTY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/unarmed/deathclawgauntlet
	name = "deathclaw gauntlet"
	desc = "The severed hand of a mighty Deathclaw, cured, hollowed out, and given a harness to turn it into the deadliest gauntlet the wastes have ever seen."
	icon_state = "deathclaw_g"
	item_state = "deathclaw_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 30
	armour_penetration = 1 //there is no such thing as armor to the claws of death
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/melee/powerfist/moleminer
	name = "mole miner gauntlet"
	desc = "A hand-held mining and cutting implement, repurposed into a deadly melee weapon.  Its name origins are a mystery..."
	icon_state = "mole_miner_g"
	item_state = "mole_miner_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 40
	armour_penetration = 0.5
	throwforce = 10
	throw_range = 7
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
