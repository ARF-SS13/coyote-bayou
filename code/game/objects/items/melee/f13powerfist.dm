/////////////////
// POWER FISTS //
/////////////////		-Uses power (gas currently) for knockback. Heavy AP, specialized for attacking heavy armor

// Power Fist			Throws targets. Max damage 52. Full AP.
/obj/item/melee/powerfist/f13
	name = "power fist"
	desc = "A metal gauntlet with a piston-powered ram on top for that extra 'oomph' in your punch."
	icon_state = "powerfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 55 //needs more hefty damage to be worthwhile outside pvp. will have to test
	throwforce = 10
	throw_range = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	var/throw_distance = 1
	attack_speed = CLICK_CD_MELEE
	var/can_adjust_unarmed = TRUE
	var/unarmed_adjusted = TRUE

/obj/item/melee/powerfist/f13/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(unarmed_adjusted)
		mob_overlay_icon = righthand_file
	if(!unarmed_adjusted)
		mob_overlay_icon = lefthand_file
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + 8 //Work around for turbo bad code here. Makes this correctly stack with your base damage. No longer makes ghouls the kings of melee.
			H.dna.species.punchdamagelow += force + 8
			H.dna.species.attack_sound = hitsound
			if(sharpness == SHARP_POINTY || sharpness ==  SHARP_EDGED)
				H.dna.species.attack_verb = pick("slash","slice","rip","tear","cut","dice")
			if(sharpness == SHARP_NONE)
				H.dna.species.attack_verb = pick("punch","jab","whack")
	if(ishuman(user) && slot != SLOT_GLOVES && !H.gloves)
		REMOVE_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(!HAS_TRAIT(user, TRAIT_UNARMED_WEAPON)) //removing your funny trait shouldn't make your fists infinitely stack damage.
			H.dna.species.punchdamagehigh = 10
			H.dna.species.punchdamagelow = 1
		if(HAS_TRAIT(user, TRAIT_IRONFIST))
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = 'sound/weapons/punch1.ogg'
		H.dna.species.attack_verb = "punch"

/obj/item/clothing/gloves/fingerless/pugilist/dropped(mob/user)

	REMOVE_TRAIT(user, TRAIT_PUGILIST, GLOVE_TRAIT)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.dna.species.punchdamagehigh -= enhancement
		H.dna.species.punchdamagelow -= enhancement
	return ..()
//obj/item/melee/powerfist/f13/attackby(obj/item/W, mob/user, params)
	//if(istype(W, /obj/item/wrench))
		//switch(fisto_setting)
			//if(1)
				//fisto_setting = 2
			//.if(2)
				//fisto_setting = 1
		//W.play_tool_sound(src)
		//to_chat(user, span_notice("You tweak \the [src]'s piston valve to [fisto_setting]."))
		//attack_speed = CLICK_CD_MELEE * fisto_setting

//obj/item/melee/powerfist/f13/updateTank(obj/item/tank/internals/thetank, removing = 0, mob/living/carbon/human/user)
	//return

/obj/item/melee/powerfist/f13/attack(mob/living/target, mob/living/user, attackchain_flags = NONE)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm other living beings!"))
		return FALSE
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	var/totalitemdamage = target.pre_attacked_by(src, user)
	SSdamage.damage_mob(user, target, totalitemdamage)
	//target.apply_damage(totalitemdamage * fisto_setting, BRUTE, wound_bonus = -25*fisto_setting**2)
	target.visible_message(span_danger("[user]'s powerfist lets out a loud hiss as [user.p_they()] punch[user.p_es()] [target.name]!"), \
		span_userdanger("You cry out in pain as [user]'s punch flings you backwards!"))
	new /obj/effect/temp_visual/kinetic_blast(target.loc)
	playsound(loc, 'sound/weapons/resonator_blast.ogg', 50, 1)
	playsound(loc, 'sound/weapons/genhit2.ogg', 50, 1)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 2 * throw_distance, 0.5 + (throw_distance / 2))
	log_combat(user, target, "power fisted", src)

// Goliath				Throws targets far. Max damage 50.
/obj/item/melee/powerfist/f13/goliath
	name = "Goliath"
	desc = "A massive, experimental metal gauntlet crafted by some poor bastard in Redwater that since outlived their usefulness. The piston-powered ram on top is designed to throw targets very, very far."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "goliath"
	item_state = "goliath"
	force = 55 //legendary tier power fist, one of a kind, why should it hit for less than a machete
	throw_distance = 3

// Saturnite fist				Hits hard. Max damage 65.
/obj/item/melee/powerfist/f13/satfist
	name = "Saturnite Power Fist"
	desc = "A massive, experimental metal gauntlet crafted by some Genius in The Military that has more than likely died. The alloy it's made of appears to be light, yet stronger than most steels."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "satfist"
	item_state = "satfist"
	force = 65 //Mythical tier power fist, literally able to kill god
	throw_distance = 2

// Heat it with a welder
/obj/item/melee/powerfist/f13/satfist/welder_act(mob/living/user, obj/item/I)
	if(I.use_tool(src, user, 20, volume=50, amount=15))
		user.visible_message("[user] heats up the Metal of the [src].", \
				span_notice("You heat up the [src] until the Fist glows!"), \
				span_italic("You hear faint sounds of a welder working."))
		new /obj/item/melee/powerfist/f13/satfisth(drop_location())
		qdel(src)
		return
	return ..()

// Saturnite fist	but hotter	Hits hard. Max damage 70.
/obj/item/melee/powerfist/f13/satfisth
	name = "Saturnite Power Fist"
	desc = "A massive, experimental metal gauntlet crafted by some Genius in The Military that has more than likely died. The alloy it's made of appears to be light, yet stronger than most steels."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "satfisth"
	item_state = "satfisth"
	force = 70 //Mythical tier power fist, literally able to kill god and cook him
	throw_distance = 2


// Mole Miner
/obj/item/melee/powerfist/f13/moleminer
	name = "mole miner gauntlet"
	desc = "A hand-held mining and cutting implement, repurposed into a deadly melee weapon.  Its name origins are a mystery..."
	icon_state = "mole_miner_g"
	item_state = "mole_miner_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 38 //weaker but it should atleast 1 tap trash mobs
	throwforce = 10
	throw_range = 7
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	tool_behaviour = TOOL_MINING
	var/digrange = 1 //This should give it the 3x1 dig range that drills and some picks have
	toolspeed = 0.3 //This should make it dig really quick. Like a moleminer!
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	armor = ARMOR_VALUE_GENERIC_ITEM


/////////////////////
// ADVANCED SWORDS //
/////////////////////

// Ripper				Keywords: Damage 10/45, Wound bonus, block
/obj/item/melee/powered/ripper
	name = "ripper"
	desc = "The Ripper™ vibroblade is powered by a small energy cell wich allows it to easily cut through flesh and bone."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	icon_state = "ripper"
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	slot_flags = INV_SLOTBIT_SUITSTORE | INV_SLOTBIT_BELT
	force = 10
	wound_bonus = 25
	block_chance = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	armour_penetration = 0.2
	tool_behaviour = TOOL_SAW
	sharpness = SHARP_EDGED
	toolspeed = 1.5
	resistance_flags = FIRE_PROOF
	hitsound = 'sound/weapons/chainsawhit.ogg'
	var/on_item_state = "ripper_on"
	var/off_item_state = "ripper"
	var/weight_class_on = WEIGHT_CLASS_HUGE
	var/force_on = 45
	var/force_off = 10
	var/on = FALSE
	var/on_icon_state = "ripper_on"
	var/off_icon_state = "ripper"
	var/on_sound = 'sound/weapons/chainsawhit.ogg'
	var/description_on = "<span class ='warning'>You thumb the on button, the whining, blurry edge of the Ripper now lethal to touch.</span>"
	var/description_off = "<span class ='notice'>You turn off the Ripper, the buzz of the cutting teeth ceasing.</span>"
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/melee/powered/ripper/attack_self(mob/user)
	on = !on
	to_chat(user, description_on)
	if(on)
		to_chat(user, description_on)
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = force_on
		slot_flags = null
		attack_verb = list("sawed", "torn", "cut", "chopped", "diced")
		playsound(loc, on_sound, 50, TRUE)
	else
		to_chat(user, description_off)
		icon_state = off_icon_state
		item_state = off_item_state
		w_class = WEIGHT_CLASS_NORMAL
		force = force_off
		slot_flags = INV_SLOTBIT_SUITSTORE | INV_SLOTBIT_BELT
		attack_verb = list("poked", "scraped")
	add_fingerprint(user)


//Warhammer chainsword			Keywords: Damage 10/50, Wound bonus, Block, Bonus AP + 0.15
/obj/item/melee/powered/ripper/prewar
	name = "pre-war military ripper"
	desc = "A hand-held, militarized chainsaw, popular with Army units requiring a compact engineering tool for cutting. Just what material is intended to be cut with the weapon remains open to debate."
	icon_state = "prewarrip_off"
	on_icon_state = "prewarrip_on"
	off_icon_state = "prewarrip_off"
	on_item_state = "prewarrip_on"
	off_item_state = "prewarrip_off"
	armour_penetration = 0.3
	force_on = 50
	

/obj/item/melee/powered/ripper/dull
	name = "worn ripper"
	desc = "A Ripper vibroblade, cutting edges dulled from overuse. Still decent for cutting, though not as good as a well-maintained one."
	force_on = 27 //it still gets the block. I think this makes sense.

// Shishkebab backpack				The shishkebab weapon base unit
/obj/item/shishkebabpack
	name = "shishkebab backpack"
	desc = "A backpack containing a large quantity of fuel and a pipe attaching it to a long, deadly blade. You ever wanted to set fire to people with a sword?"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "shishkebabpack"
	item_state = "shishkebabpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BACK
//	actions_types = list(/datum/action/item_action/toggle_shishkebab)
	armor = ARMOR_VALUE_GENERIC_ITEM
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
		to_chat(user, span_warning("The backpack must be worn properly to use!"))
		return
	if(user.incapacitated())
		return

	if(QDELETED(sword))
		sword = make_sword()
	if(sword in src)
		//Detach the sword into the user's hands
		if(!user.put_in_hands(sword))
			to_chat(user, span_warning("You need a free hand to hold the shishkebab!"))
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
	if(istype(M) && istype(over_object, /atom/movable/screen/inventory/hand))
		var/atom/movable/screen/inventory/hand/H = over_object
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

// Shishkebab sword				Keywords: Damage 55 (fire), Tool welder
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
	weapon_special_component = /datum/component/weapon_special/single_turf

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
			to_chat(tank.loc, span_notice("The shishkebab slides back into the backpack tank."))
		destination = tank
	..()
