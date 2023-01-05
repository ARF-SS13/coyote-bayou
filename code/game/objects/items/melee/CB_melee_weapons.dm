
//Master Melee Weapon List

//Glove List//
//Glove Weapon Template
//Brass Knuckles
//Spiked Knuckles
//Sappers
//Tigerclaw
//Lacerators
//Maceglove
//Punchdagger
//Deathclaw Gauntlet
//Yao Guai Gauntlet

//Powerfist List//
//Powerfist
//Goliath
//Ballisticfist
//Moleminer
//Ripper
//Pre-War Ripper
//Shishkebab Backback
//Shishkebab

//One Handed List//
//Dragonfire Katana
//Machete
//Training Machete
//Gladius
//Spatha
//Forged Claymore
//Scrap Sabre
//Throwing Spear

//Knife List//
//Knife Template
//Hunting Knife
// Survival Knife
//Bayonet Knife
//Bowie Knife
//Trench Knife
//Bone Dagger
//Ritual Dagger
//Switchblade

//Cosmic Knife List//
//Dirty Cosmic Knife
//Cosmic Knife
//Superheated Cosmic Knife
//Throwing Knife

//Club Weapon List//
//Pipe
//War Club
//Tire Iron
//NCR Flag
//Wooden Baton
//Military Baton
//Police Baton
//Telescopic Baton
//Slave Whip

//Tool List//
//Carving Knife
//Frying Pan
//Entrenching Tool

//Plasmacutter list//
//Plasmacutter
//Plasmacutter Regular
//Plasmacutter Adam
//Plasmacutter Eve
//Plasmacutter Celestia
//Energy Sword
//Energy Sword Cyborg
//Energy Saw
//Energy Cutlass
//Energy Blade
//Hardlight Blade
//Non-Eatactic Blade
//Misaligned Non-Eutactic Blade
//Dragon's Tooth Sword

//Misc List//
//SORD
//Katana
//Temporal Katana
//Bokken
//Bokken debug
//Wired Rod
//Red Phone
//Throwing Star
//Shock Throwing Star
//Cane
//Wizard Staff
//Broom
//Ectoplasm
//Bust (lmao)
//Tail Club
//Liz o' nine tails
//Cat o' nine tails
//Flyswatter
//Circled Hand
//Slapper
//Extendo Hand
//ACME Extendo-Hand
//Vibro Weapon Template
//Pitchfork
//Demonic Pitchfork
//Greater Demonic Pitchfork
//Ascended Demonic Pitchfork
//Archieved Homerun Bat




/*
		,--.--._
------" _, \___)
        / _/____)
        \//(____)
------\     (__)
		`-----"
*/
///////////////////
// GLOVE WEAPONS //
///////////////////

//Weapons that, generally, go in your glove slot. These are for people who want to be punching faces in and
//generally making a mess out of things with their 'hands.'  Despite that, it doesn't include power fists.
//I think the logic is that a powerfist stops the hand holding it from being used for finer dexterity tasks,
//but we all know that's bullshit.  It really should be all or nothing, because you aren't exactly going to be 
//able to hold a gun and spiked knuckles at the same time in the same hand and use either to any degree.
// ~TK

//Glove Weapon Template
//Brass Knuckles
//Spiked Knuckles
//Sappers
//Tigerclaw
//Lacerators
// Maceglove
//Punchdagger
//Deathclaw Gauntlet
//Yao Guai Gauntlet

/obj/item/melee/unarmed
	name = "glove weapon template"
	desc = "should not be here"
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	attack_speed = CLICK_CD_MELEE * 0.9
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	sharpness = SHARP_NONE
	armour_penetration = 0.05
	throwforce = 10
	throw_range = 5
	attack_verb = list("punched", "jabbed", "whacked")
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
			H.dna.species.punchdamagehigh = 14
			H.dna.species.punchdamagelow = 4
		if(HAS_TRAIT(user, TRAIT_FEV)) //Holy shit that Supermutant had a powerfist!
			H.dna.species.punchdamagehigh = 16
			H.dna.species.punchdamagelow = 10
		H.dna.species.attack_sound = 'sound/weapons/punch1.ogg'
		H.dna.species.attack_verb = "punch"

/obj/item/melee/unarmed/examine(mob/user)
	. = ..()
	if(can_adjust_unarmed == TRUE)
		if(unarmed_adjusted == TRUE)
			. += span_notice("Alt-click on [src] to wear it on a different hand. You must take it off first, then put it on again.")
		else
			. += span_notice("Alt-click on [src] to wear it on a different hand. You must take it off first, then put it on again.")

/obj/item/melee/unarmed/AltClick(mob/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ishuman(user)))
		return
	if(can_adjust_unarmed == TRUE)
		toggle_unarmed_adjust()

/obj/item/melee/unarmed/proc/toggle_unarmed_adjust()
	unarmed_adjusted = !unarmed_adjusted
	to_chat(usr, span_notice("[src] is ready to be worn on another hand."))


// Brass knuckles	Keywords: Damage 26
/obj/item/melee/unarmed/brass
	name = "brass knuckles"
	desc = "Hardened knuckle grip that is actually made out of steel. They protect your hand, and do more damage, in unarmed combat."
	icon_state = "brass"
	item_state = "brass"
	attack_verb = list("punched", "jabbed", "whacked")
	force = 26
	custom_materials = list(/datum/material/iron = 2000)

// Spiked knuckles	Keywords: Damage 28
/obj/item/melee/unarmed/brass/spiked
	name = "spiked knuckes"
	desc = "Unlike normal brass knuckles, these have a metal plate across the knuckles with four spikes on, one for each knuckle. So not only does the victim feel the force of the punch, but also the devastating effects of spikes being driven in."
	icon_state = "spiked"
	item_state = "spiked"
	sharpness = SHARP_POINTY
	force = 28
	armour_penetration = 0.10

// Sappers			Keywords: Damage 27
/obj/item/melee/unarmed/sappers
	name = "sappers"
	desc = "Lead filled gloves which are ideal for beating the crap out of opponents. Deals significant stamina damage. I mean, I wouldn't want to get punched in the chest with it..."
	icon_state = "sapper"
	item_state = "sapper"
	w_class = WEIGHT_CLASS_NORMAL
	force = 27

/obj/item/melee/unarmed/sappers/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, "head", M.run_armor_check("head", "melee"))

// Tiger claws		Keywords: Damage 33, Pointy
/obj/item/melee/unarmed/tigerclaw
	name = "tiger claws"
	desc = "Gloves with short claws built into the palms."
	icon_state = "tiger_claw"
	item_state = "tiger_claw"
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_POINTY
	force = 33
	hitsound = 'sound/weapons/bladeslice.ogg'

// Lacerator		Keywords: Damage 29, Edged, Wound bonus
/obj/item/melee/unarmed/lacerator
	name = "lacerator"
	desc = "Leather gloves with razor blades built into the back of the hand."
	icon_state = "lacerator"
	item_state = "lacerator"
	w_class = WEIGHT_CLASS_NORMAL
	force = 29
	armour_penetration = 0 //my brother in christ it is razor blades on tape
	bare_wound_bonus = 5
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

// Mace Glove		Keywords: Damage 30
/obj/item/melee/unarmed/maceglove
	name = "mace glove"
	desc = "Weighted metal gloves that are covered in spikes.  Don't expect to grab things with this."
	icon_state = "mace_glove"
	item_state = "mace_glove"
	w_class = WEIGHT_CLASS_BULKY
	force = 30
	sharpness = SHARP_NONE

// Punch Dagger		Keywords: Damage 29, Pointy
/obj/item/melee/unarmed/punchdagger
	name = "punch dagger"
	desc = "A dagger designed to be gripped in the user�s fist with the blade protruding between the middle and ring fingers, to increase the penetration of a punch."
	icon_state = "punch_dagger"
	item_state = "punch_dagger"
	force = 29
	armour_penetration = 0.12
	sharpness = SHARP_POINTY
	attack_verb = list("stabbed", "sliced", "pierced", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

obj/item/melee/unarmed/punchdagger/cyborg
	name = "assaultron claws"
	desc = "Razor sharp blades embedded into the grippers of an assaultron. Sharp."
	icon_state = "tiger_claw"
	item_state = "tiger_claw"
	force = 40 //Assaultron, so, makes sense.

// Deathclaw Gauntlet	Keywords: Damage 35, AP 1
/obj/item/melee/unarmed/deathclawgauntlet
	name = "deathclaw gauntlet"
	desc = "The severed hand of a mighty Deathclaw, cured, hollowed out, and given a harness to turn it into the deadliest gauntlet the wastes have ever seen."
	icon_state = "deathclaw_g"
	item_state = "deathclaw_g"
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	force = 35
	armour_penetration = 1
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

//Yao Guai Gauntlet	Keywords: Damage 25, Fast, "Saw Bleed" Effect
/obj/item/melee/unarmed/yaoguaigauntlet
	name = "yao guai gauntlet"
	desc = "The severed hand of a yao guai, the hide cured, the muscles and bone removed, and given a harness to turn it into a deadly gauntlet. A weapon worthy of the Sulfurs."
	icon_state = "yao_guai_g"
	item_state = "deathclaw_g"
	slot_flags = ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	force = 23
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.75 //6

/obj/item/melee/unarmed/yaoguaigauntlet/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!isliving(target))
		return
	target.apply_status_effect(/datum/status_effect/stacking/saw_bleed/yaoguaigauntlet)




/*
	ad88 88                    ... 
	d8"   ..             ..,d      
	88                   ...88     
	MM88MMM	 88 ,adPPYba, MM88MMM  
	88   	 88 I8[    ""   88     
	88   	 88  `"Y8ba,    88     
	88 		 88 aa    ]8I   88,    
	88   	 88 `"YbbdP"'   "Y888  
*/

/////////////////
// POWER FISTS //
/////////////////

//The logic for these seems to be that they use welding fuel for knockback and have heavy AP for attacking heavy armor.
//The reality is its a gigantic fucking catchall. Including wonders such as the balistic fist (shouldn't that be a punching weapon?)
//and the moleminer (bruh, literally a gauntlet.) This entire subtype could, and likely should, be combined into general punching weapons
//for the sake of simplicity.  Oh, it also includes the ripper and Shishkebab. Why? Because fuck you, why not?
//~TK

//Powerfist
//Goliath
//Ballisticfist
//Moleminer
//Ripper
//Pre-War Ripper
//Shishkebab Backback
//Shishkebab

// Power Fist			Throws targets. Max damage 44. Full AP.
/obj/item/melee/powerfist/f13
	name = "power fist"
	desc = "A metal gauntlet with a piston-powered ram on top for that extra 'oomph' in your punch."
	icon_state = "powerfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 22
	throwforce = 10
	throw_range = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	var/throw_distance = 1
	attack_speed = CLICK_CD_MELEE

/obj/item/melee/powerfist/f13/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/wrench))
		switch(fisto_setting)
			if(1)
				fisto_setting = 2
			if(2)
				fisto_setting = 1
		W.play_tool_sound(src)
		to_chat(user, span_notice("You tweak \the [src]'s piston valve to [fisto_setting]."))
		attack_speed = CLICK_CD_MELEE * fisto_setting

/obj/item/melee/powerfist/f13/updateTank(obj/item/tank/internals/thetank, removing = 0, mob/living/carbon/human/user)
	return

/obj/item/melee/powerfist/f13/attack(mob/living/target, mob/living/user, attackchain_flags = NONE)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm other living beings!"))
		return FALSE
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	var/totalitemdamage = target.pre_attacked_by(src, user)
	target.apply_damage(totalitemdamage * fisto_setting, BRUTE, wound_bonus = -25*fisto_setting**2)
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
	force = 25
	throw_distance = 3


// Ballistic Fist			Keywords: Damage max 42, AP 0.45, Shotgun
/obj/item/gun/ballistic/revolver/ballisticfist
	name = "ballistic fist"
	desc = "This powerfist has been modified to have two shotgun barrels welded to it, with the trigger integrated into the knuckle guard. For those times when you want to punch someone and shoot them in the face at the same time."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "ballisticfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	force = 30
	armour_penetration = 0.45
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	item_flags = NEEDS_PERMIT //doesn't slow you down
	fire_delay = 0
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot


// Mole Miner
/obj/item/melee/powerfist/f13/moleminer
	name = "mole miner gauntlet"
	desc = "A hand-held mining and cutting implement, repurposed into a deadly melee weapon.  Its name origins are a mystery..."
	icon_state = "mole_miner_g"
	item_state = "mole_miner_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 15
	throwforce = 10
	throw_range = 7
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	tool_behaviour = TOOL_MINING
	var/digrange = 0
	toolspeed = 0.6
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_GLOVES
	armor = ARMOR_VALUE_GENERIC_ITEM


//lmfao I fucking hate these ~TK


// Ripper				
/obj/item/melee/powered/ripper
	name = "ripper"
	desc = "The Ripper™ vibroblade is powered by a small energy cell wich allows it to easily cut through flesh and bone."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	icon_state = "ripper"
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
	slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
	force = 10
	wound_bonus = 25
	block_chance = 15
	throw_speed = 3
	throw_range = 4
	throwforce = 10
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
		slot_flags = ITEM_SLOT_SUITSTORE | ITEM_SLOT_BELT
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
	force_on = 50
	armour_penetration = 0.15


// Shishkebab backpack				The shishkebab weapon base unit
/obj/item/shishkebabpack
	name = "shishkebab backpack"
	desc = "A backpack containing a large quantity of fuel and a pipe attaching it to a long, deadly blade. You ever wanted to set fire to people with a sword?"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "shishkebabpack"
	item_state = "shishkebabpack"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
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


/*
         //
        ||
|\[][][]||-----------------------------\
|/[][][]||-----------------------------/
        ||
        \\
*/

//////////////////////
//One Handed Weapons//
//////////////////////

//This is a GIGANTIC list of weapons, sort of from all over the fucking place. Many of them make little sense, and a bunch are literally 
//tiny percent change copies of one another.
//~TK

/obj/item/melee //Melee weapon template
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM

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
////////////		-block, 34-39 damage

//Here's most of the culprits of fucking horrible copy paste-ism. Most of the bladed weapons on the following list are bordering on being
//clones of each other, and it makes me want to fucking DIE lol.
//~TK

//Dragonfire Katana
//Machete
//Training Machete
//Gladius
//Spatha
//Forged Claymore
//Scrap Sabre
//Throwing Spear

/obj/item/melee/onehanded/dragonfire //unique. big damage. can parry.
	name = "Dragonfire Katana"
	desc = "A sword that crackles with an unknown power source. It's warm in your hands, cutting and cauterizing flesh like butter- and yet, the geiger counter remains silent. The blade seems to guide you to block, twist, and dodge.. <br> <span class='phobia'>The sky above the clouds, a rainbow that fate has devoured- I gave up hope!</span>"
//	icon_state = "DFkatana" HAHA THE INHAND SPRITES DON'T EXIST
//	item_state = "DFkatana"
	icon_state = "temporalkatana"
	item_state = "temporalkatana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	force = 55
	throwforce = 10
	block_chance = 20
	armour_penetration = 0.40
	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON
//	item_flags = ITEM_CAN_PARRY does nothing from what i can tell arghhhggh todo: fix

/obj/item/melee/onehanded/dragonfire/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, BURN, "chest", M.run_armor_check("chest", "energy"))



/obj/item/melee/onehanded/machete
	name = "simple machete"
	desc = "A makeshift machete made of a lawn mower blade."
	icon_state = "machete_imp"
	item_state = "salvagedmachete"
	force = 35
	block_chance = 7
	throwforce = 20
	wound_bonus = 10
	sharpness = SHARP_EDGED

/obj/item/melee/onehanded/machete/forgedmachete
	name = "machete"
	desc = "A forged machete made of high quality steel."
	icon_state = "machete"
	force = 35
	wound_bonus = 20
	block_chance = 8

/obj/item/melee/onehanded/machete/training
	name = "training machete"
	desc = "A training machete made of tough wood."
	icon_state = "machete_training"
	force = 1
	throwforce = 5
	wound_bonus = -20
	block_chance = 8

/obj/item/melee/onehanded/machete/training/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, "chest", M.run_armor_check("chest", "melee"))

/obj/item/melee/onehanded/machete/gladius
	name = "gladius"
	desc = "A heavy cutting blade, with a fairly good tip too."
	icon_state = "gladius"
	item_state = "gladius"
	force = 36
	wound_bonus = 30
	block_chance = 10

/obj/item/melee/onehanded/machete/spatha
	name = "spatha"
	desc = "A long blade favoured by those who travel light, a finely crafted weapon with good steel and hilt made from bronze and bone."
	icon_state = "spatha"
	item_state = "spatha"
	force = 38
	wound_bonus = 30
	block_chance = 18

/obj/item/melee/onehanded/machete/spatha/longblade
	name = "forged claymore"
	desc = "A long one-handed blade sporting lovingly applied wraps and a wonderfully forged and engraved guard. The blade looks to be carefully sharpened."
	icon_state = "longblade"
	item_state = "longblade"
	force = 38
	block_chance = 18

/obj/item/melee/onehanded/machete/scrapsabre
	name = "scrap sabre"
	desc = "Made from materials found in the wastes, a skilled blacksmith has turned it into a thing of deadly beauty."
	icon_state = "scrapsabre"
	item_state = "scrapsabre"
	force = 37
	block_chance = 15

/obj/item/throwing_star/spear
	name = "throwing spear"
	desc = "An heavy hefty ancient weapon used to this day, due to its ease of lodging itself into its victim's body parts."
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	icon_state = "throw_spear"
	item_state = "tribalspear"
	force = 15
	throwforce = 40 //clears threshholds for trash mobs
	armour_penetration = 0.10
	max_reach = 2
	embedding = list("pain_mult" = 2, "embed_chance" = 40, "fall_chance" = 15)
	w_class = WEIGHT_CLASS_NORMAL

////////////
// KNIVES //
////////////		-small AP bonus, 23-31 damage. Attack fast.

//Welcome to hell.
// ~TK

//Knife Template
//Hunting Knife
// Survival Knife
//Bayonet Knife
//Bowie Knife
//Trench Knife
//Bone Dagger
//Ritual Dagger
//Switchblade

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
	armor = ARMOR_VALUE_GENERIC_ITEM
	var/bayonet = FALSE	//Can this be attached to a gun?
	bare_wound_bonus = 5
	custom_materials = list(/datum/material/iron=6000)
	resistance_flags = FIRE_PROOF
	attack_speed = CLICK_CD_MELEE * 0.85 //6.8

/obj/item/melee/onehanded/knife/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80 - force, 100, force - 10) //bonus chance increases depending on force

/obj/item/melee/onehanded/knife/attack(mob/living/carbon/M, mob/living/carbon/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		return eyestab(M,user)
	else
		return ..()

/obj/item/melee/onehanded/knife/suicide_act(mob/user)
	user.visible_message(pick(span_suicide("[user] is slitting [user.p_their()] wrists with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide."), \
						span_suicide("[user] is slitting [user.p_their()] throat with the [src.name]! It looks like [user.p_theyre()] trying to commit suicide."), \
						span_suicide("[user] is slitting [user.p_their()] stomach open with the [src.name]! It looks like [user.p_theyre()] trying to commit seppuku.")))
	return (BRUTELOSS)


/obj/item/melee/onehanded/knife/hunting
	name = "hunting knife"
	icon_state = "knife_hunting"
	desc = "Dependable hunting knife."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 23
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")

/obj/item/melee/onehanded/knife/survival
	name = "survival knife"
	icon_state = "knife_survival"
	desc = "Multi-purpose knife with blackened steel."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 23
	throwforce = 25

/obj/item/melee/onehanded/knife/bayonet
	name = "bayonet knife"
	icon_state = "knife_bayonet"
	desc = "This weapon is made for stabbing, not much use for other things."
	force = 23
	bayonet = TRUE

/obj/item/melee/onehanded/knife/bowie
	name = "bowie knife"
	icon_state = "knife_bowie"
	item_state = "knife_bowie"
	desc = "A large clip point fighting knife."
	force = 28
	throwforce = 25
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/melee/onehanded/knife/trench
	name = "trench knife"
	icon_state = "knife_trench"
	item_state = "knife_trench"
	desc = "This blade is designed for brutal close quarters combat."
	force = 30
	custom_materials = list(/datum/material/iron=8000)
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")

/obj/item/melee/onehanded/knife/bone
	name = "bone dagger"
	item_state = "knife_bone"
	icon_state = "knife_bone"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	desc = "A sharpened bone. The bare minimum in survival. Faster than other knives by a small margin due to its weight."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 23
	throwforce = 20
	custom_materials = null
	attack_speed = 6.4

/obj/item/melee/onehanded/knife/ritualdagger
	name = "ritual dagger"
	desc = "An ancient blade used to carry out the spiritual rituals of the Wayfarer people."
	icon_state = "knife_ritual"
	item_state = "knife_ritual"
	force = 25
	armour_penetration = 0.1
	custom_materials = null

obj/item/melee/onehanded/knife/switchblade
	name = "switchblade"
	desc = "A sharp, concealable, spring-loaded knife."
	icon_state = "knife_switch"
	force = 3
	throwforce = 5
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb = list("stubbed", "poked")
	var/extended = 0
	var/extended_force = 21
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

//////////////////
// Cosmic Knife //
////////////////// now you do the cleaning & heating manually.

//Cosmic Blade family.
//Oh, and throwing knives. Why? Becuase fuck making sense, lmfao.
//~TK

//Dirty Cosmic Knife
//Cosmic Knife
//Superheated Cosmic Knife
//Throwing Knife

/obj/item/melee/onehanded/knife/cosmicdirty
	name = "dirty cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one is covered in oxidation. Perhaps Abraxo might clean it up?"
	icon_state = "knife_cosmic_dirty"
	item_state = "knife"
	force = 15
	throwforce = 10
	armour_penetration = 0.2

// Abraxo my beloved. Can now be used directly to clean the blade.
/obj/item/melee/onehanded/knife/cosmicdirty/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/crafting/abraxo))
		user.visible_message("[user] begins cleaning the blade of the [src].", \
				span_notice("You begin scrubbing the [src] with Abraxo. Smells nice."), \
				span_italic("You hear faint sounds of scrubbing."))
		playsound(get_turf(src), 'sound/FermiChem/heatdam.ogg', 50, TRUE)
		if(!do_after(user, 60, TRUE, src))
			return
		new /obj/item/melee/onehanded/knife/cosmic(drop_location())
		qdel(src)
		qdel(C)
		return
	return ..()

/obj/item/melee/onehanded/knife/cosmic
	name = "cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, can be heated with a welder for easier cutting of frozen butter."
	icon_state = "knife_cosmic"
	item_state = "knife"
	force = 25
	throwforce = 15
	armour_penetration = 0.2

// Heat it with a welder
/obj/item/melee/onehanded/knife/cosmic/welder_act(mob/living/user, obj/item/I)
	if(I.use_tool(src, user, 20, volume=50, amount=15))
		user.visible_message("[user] heats up the blade of the [src].", \
				span_notice("You heat up the [src] until the blade glows!"), \
				span_italic("You hear faint sounds of a welder working."))
		new /obj/item/melee/onehanded/knife/cosmicheated(drop_location())
		qdel(src)
		return
	return ..()

/obj/item/melee/onehanded/knife/cosmicheated
	name = "superheated cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one looks like it has been heated to high temperatures."
	icon_state = "knife_cosmic_heated"
	item_state = "knife"
	damtype = BURN
	force = 35
	throwforce = 20
	armour_penetration = 0.4
	w_class = WEIGHT_CLASS_NORMAL // Its super hot, not comfy to put back in your pocket.

/obj/item/melee/onehanded/knife/throwing
	name = "throwing knife"
	desc = "a finely balanced knife made from a lightweight alloy, designed for being thrown. You can easily embed these in someone, and you look darn cool while doing so."
	icon_state = "knife_throw"
	force = 20
	throwforce = 30
	armour_penetration = 0.25
	bare_wound_bonus = 15 //keep your arteries covered
	throw_speed = 5
	throw_range = 7
	embedding = list("pain_mult" = 4, "embed_chance" = 70, "fall_chance" = 5)

/*
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢸⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢀⣴⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠋⠀⠀⣀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠁⢀⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⡿⠋⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⡿⠋⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣌⠻⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
*/

///////////
// CLUBS //
///////////		

//An almost sensible list of melee weapons that are for beating things with. Oh, but the slave whip is in it to. :)
//~TK

//Pipe
//War Club
//Tire Iron
//NCR Flag (??? What the fuck.)
//Wooden Baton
//Military Baton
//Police Baton
//Telescopic Baton
//Slave Whip (lmao lol)

// Pipe
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

/obj/item/melee/onehanded/club/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(10, STAMINA, "chest", M.run_armor_check("chest", "melee"))

// War Club
/obj/item/melee/onehanded/club/warclub
	name = "war club"
	desc = "A simple carved wooden club with turquoise inlays."
	icon_state = "warclub"
	item_state = "warclub"
	attack_verb = list("mashed", "bashed", "hit", "bludgeoned", "whacked")
	force = 30
	throwforce = 25
	block_chance = 5

/obj/item/melee/onehanded/club/warclub/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, "chest", M.run_armor_check("chest", "melee"))

// Tire Iron
/obj/item/melee/onehanded/club/tireiron
	name = "tire iron"
	desc = "A rusty old tire iron, normally used for loosening nuts from car tires.<br>Though it has a short reach, it has decent damage and a fast swing."
	icon_state = "tire"
	item_state = "tire"
	force = 30
	custom_materials = list(/datum/material/iron = 4000)

// NCR Flag			Keywords: NCR, Damage 26, Stamina damage, Block
/obj/item/melee/onehanded/club/ncrflag
	name = "NCR flagpole"
	desc = "The proud standard of the New California Republic. Used as a tool by patriots, used as a weapon by legends."
	icon_state = "flag-ncr"
	item_state = "flag-ncr"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = null
	force = 26
	block_chance = 30
	attack_verb = list("smacked", "thwacked", "democratized", "freedomed")

// Classic Baton
/obj/item/melee/classic_baton
	name = "wooden baton"
	desc = "A wooden truncheon for beating criminal scum."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "baton"
	item_state = "classic_baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 18
	w_class = WEIGHT_CLASS_NORMAL
	wound_bonus = 15
	var/stun_stam_cost_coeff = 1.25
	var/hardstun_ds = TRUE
	var/softstun_ds = 0
	var/stam_dmg = 30
	var/cooldown_check = 0 // Used internally, you don't want to modify
	var/cooldown = 13 // Default wait time until can stun again.
	var/stun_time_silicon = 60 // How long it stuns silicons for - 6 seconds.
	var/affect_silicon = FALSE // Does it stun silicons.
	var/on_sound // "On" sound, played when switching between able to stun or not.
	var/on_stun_sound = "sound/effects/woodhit.ogg" // Default path to sound for when we stun.
	var/stun_animation = TRUE // Do we animate the "hit" when stunning.
	var/on = TRUE // Are we on or off
	var/on_icon_state // What is our sprite when turned on
	var/off_icon_state // What is our sprite when turned off
	var/on_item_state // What is our in-hand sprite when turned on
	var/force_on // Damage when on - not stunning
	var/force_off // Damage when off - not stunning
	var/weight_class_on // What is the new size class when turned on

/obj/item/melee/classic_baton/Initialize()
	. = ..()

// Description for trying to stun when still on cooldown.
/obj/item/melee/classic_baton/proc/get_wait_description()
	return

// Description for when turning their baton "on"
/obj/item/melee/classic_baton/proc/get_on_description()
	. = list()
	.["local_on"] = "<span class ='warning'>You extend the baton.</span>"
	.["local_off"] = "<span class ='notice'>You collapse the baton.</span>"
	return .

// Default message for stunning mob.
/obj/item/melee/classic_baton/proc/get_stun_description(mob/living/target, mob/living/user)
	. = list()
	.["visible"] =  "<span class ='danger'>[user] has knocked down [target] with [src]!</span>"
	.["local"] = "<span class ='danger'>[user] has knocked down [target] with [src]!</span>"
	return .

// Default message for stunning a silicon.
/obj/item/melee/classic_baton/proc/get_silicon_stun_description(mob/living/target, mob/living/user)
	. = list()
	.["visible"] = span_danger("[user] pulses [target]'s sensors with the baton!")
	.["local"] = span_danger("You pulse [target]'s sensors with the baton!")
	return .

// Are we applying any special effects when we stun to carbon
/obj/item/melee/classic_baton/proc/additional_effects_carbon(mob/living/target, mob/living/user)
	return

// Are we applying any special effects when we stun to silicon
/obj/item/melee/classic_baton/proc/additional_effects_silicon(mob/living/target, mob/living/user)
	return

/obj/item/melee/classic_baton/attack(mob/living/target, mob/living/user)
	if(!on)
		return ..()

	if(IS_STAMCRIT(user))//CIT CHANGE - makes batons unusuable in stamina softcrit
		to_chat(user, span_warning("You're too exhausted for that."))//CIT CHANGE - ditto
		return //CIT CHANGE - ditto

	add_fingerprint(user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) && prob(50))
		to_chat(user, "<span class ='danger'>You club yourself over the head.</span>")
		user.DefaultCombatKnockdown(60 * force)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(2*force, BRUTE, BODY_ZONE_HEAD)
		else
			user.take_bodypart_damage(2*force)
		return
	if(iscyborg(target))
		if(user.a_intent != INTENT_HARM)	// We don't stun if we're on harm.
			if(affect_silicon)
				var/list/desc = get_silicon_stun_description(target, user)
				target.flash_act(affect_silicon = TRUE)
				target.Stun(stun_time_silicon)
				additional_effects_silicon(target, user)
				user.visible_message(desc["visible"], desc["local"])
				playsound(get_turf(src), on_stun_sound, 100, TRUE, -1)
				if(stun_animation)
					user.do_attack_animation(target)
			else
				..()
		else
			..()
		return
	if(!isliving(target))
		return
	if(user.a_intent == INTENT_HARM)
		if(!..() || !iscyborg(target))
			return
	else
		if(cooldown_check < world.time)
			if(target.mob_run_block(src, 0, "[user]'s [name]", ATTACK_TYPE_MELEE, 0, user, null, null) & BLOCK_SUCCESS)
				playsound(target, 'sound/weapons/genhit.ogg', 50, 1)
				return
			if(ishuman(target) && !user.zone_selected ==	BODY_ZONE_L_LEG || !user.zone_selected == BODY_ZONE_R_LEG)
				var/mob/living/carbon/human/H = target
				if(check_martial_counter(H, user))
					return
			var/list/desc = get_stun_description(target, user)
			if(stun_animation)
				user.do_attack_animation(target)
			playsound(get_turf(src), on_stun_sound, 75, 1, -1)
			target.adjustStaminaLoss(30)
			additional_effects_carbon(target, user)
			add_fingerprint(user)
			target.visible_message(desc["visible"], desc["local"])
			if(!iscarbon(user))
				target.LAssailant = null
			else
				target.LAssailant = WEAKREF(user)
			cooldown_check = world.time + cooldown
			user.adjustStaminaLossBuffered(getweight(user, STAM_COST_BATON_MOB_MULT))
		else
			var/wait_desc = get_wait_description()
			if(wait_desc)
				to_chat(user, wait_desc)
			return DISCARD_LAST_ACTION

// Military baton - Desired effect instant disarm on hit on NCR when used by MP, could be sorted with a interesting martial art maybe.
/obj/item/melee/classic_baton/militarypolice
	name = "military baton"
	desc = "Sturdy stick painted white, used by military police to get unruly troopers into line."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "batonmp"
	item_state = "batonmp"

// Baton but coloured black
/obj/item/melee/classic_baton/police
	name = "police baton"
	desc = "A black plastic nightstick, used by police officers to detain rowdy law-breakers."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "batonpolice"
	item_state = "batonpolice"

// Telescopic baton
/obj/item/melee/classic_baton/telescopic
	name = "telescopic baton"
	desc = "A compact yet robust personal defense weapon. Can be concealed when folded."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "telebaton_0"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	item_state = null
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	on = FALSE
	on_sound = 'sound/weapons/batonextend.ogg'
	on_icon_state = "telebaton_1"
	off_icon_state = "telebaton_0"
	on_item_state = "nullrod"
	force_on = 10
	force_off = 0
	weight_class_on = WEIGHT_CLASS_BULKY
	total_mass = TOTAL_MASS_NORMAL_ITEM
	bare_wound_bonus = 5

/obj/item/melee/classic_baton/telescopic/suicide_act(mob/user)
	var/mob/living/carbon/human/H = user
	var/obj/item/organ/brain/B = H.getorgan(/obj/item/organ/brain)

	user.visible_message(span_suicide("[user] stuffs [src] up [user.p_their()] nose and presses the 'extend' button! It looks like [user.p_theyre()] trying to clear [user.p_their()] mind."))
	if(!on)
		src.attack_self(user)
	else
		playsound(loc, on_sound, 50, 1)
		add_fingerprint(user)
	sleep(3)
	if (H && !QDELETED(H))
		if (B && !QDELETED(B))
			H.internal_organs -= B
			qdel(B)
		H.spawn_gibs()
		return (BRUTELOSS)

/obj/item/melee/classic_baton/telescopic/attack_self(mob/user)
	on = !on
	var/list/desc = get_on_description()
	if(on)
		to_chat(user, desc["local_on"])
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = force_on
		attack_verb = list("smacked", "struck", "cracked", "beaten")
	else
		to_chat(user, desc["local_off"])
		icon_state = off_icon_state
		item_state = null //no sprite for concealment even when in hand
		slot_flags = ITEM_SLOT_BELT
		w_class = WEIGHT_CLASS_SMALL
		force = force_off
		attack_verb = list("hit", "poked")
	playsound(loc, on_sound, 50, TRUE)
	add_fingerprint(user)


// Slave whip
/obj/item/melee/onehanded/slavewhip
	name = "slave whip"
	desc = "Corded leather strips turned into a instrument of pain. Cracks ominously when a skilled wielder uses it."
	icon_state = "whip"
	item_state = "chain"
	force = 1
	bare_wound_bonus = 5
	sharpness = SHARP_EDGED
	attack_verb = list("flogged", "whipped", "lashed", "disciplined")
	hitsound = 'sound/weapons/whip.ogg'

/obj/item/melee/onehanded/slavewhip/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, null, 0)



/*
.(U)...
..\\...
...\\..
...(O).
*/
///////////
// TOOLS //
///////////		

//I dare you to ask me why this list exists.
//~TK

//Carving Knife
//Frying Pan
//Entrenching Tool

//Tribal Butcher's Knife
/obj/item/kitchen/knife/butcher/tribal
	name = "Carving Knife"
	desc = "A simple, hand-fashioned carving knife meant for separating meat from bone. Hardly more than some sharpened, rusty metal stuck between a tied wooden handle."
	icon_state = "knife_butcher_primal"
	force = 13
	throwforce = 7
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT*3, /datum/material/wood=MINERAL_MATERIAL_AMOUNT*2)
	custom_price = PRICE_ALMOST_CHEAP

// Frying pan
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
	custom_materials = list(/datum/material/iron = 4000)

// Entrenching tool P81
/obj/item/shovel/trench
	name = "p81 entrenching tool"
	desc = "The 'Pattern 2281' Entrenching Tool is a new piece of infantry equipment given in limited quantity to infantry troops. An extremely robust shovel with a serrated edge for chopping wood."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "entrenching_tool"
	item_state = "trench"
	w_class = WEIGHT_CLASS_NORMAL
	force = 30
	throwforce = 15
	toolspeed = 0.7
	sharpness = SHARP_EDGED
	attack_verb = list("cleaved", "chopped", "sliced", "slashed")


// Hatchet				Force 24
// Wrench				Force 12
// Crowbar				Force 15
// Kitchen knife		Force 15
// Rolling pin			Force x


/*
CODE ARCHIVE MELEE

CODE FOR BLEEDING STACK
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



//////////////////
//Plasma Cutters//
//////////////////


//Yep.
//~TK

//Plasmacutter
//Plasmacutter Regular
//Plasmacutter Adam
//Plasmacutter Eve
//Plasmacutter Celestia
//Energy Sword
//Energy Sword Cyborg
//Energy Saw
//Energy Cutlass
//Energy Blade
//Hardlight Blade
//Non-Eatactic Blade
//Misaligned Non-Eutactic Blade
//Dragon's Tooth Sword

/obj/item/melee/transforming/plasmacutter
	hitsound_on = 'sound/weapons/blade1.ogg'
	heat = 3500
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_on = FALSE
	var/sword_color
	total_mass = 0.4 //Survival flashlights typically weigh around 5 ounces.

/obj/item/melee/transforming/plasmacutter/Initialize()
	. = ..()
	total_mass_on = (total_mass_on ? total_mass_on : (w_class_on * 0.75))
	if(active)
		if(sword_color)
			icon_state = "sword[sword_color]"
		set_light_on(TRUE)
		START_PROCESSING(SSobj, src)

/obj/item/melee/transforming/plasmacutter/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/transforming/plasmacutter/suicide_act(mob/user)
	if(!active)
		transform_weapon(user, TRUE)
	user.visible_message(span_suicide("[user] is [pick("slitting [user.p_their()] stomach open with", "falling on")] [src]! It looks like [user.p_theyre()] trying to commit seppuku!"))
	return (BRUTELOSS|FIRELOSS)

/obj/item/melee/transforming/plasmacutter/add_blood_DNA(list/blood_dna)
	return FALSE

/obj/item/melee/transforming/plasmacutter/get_sharpness()
	return active * sharpness

/obj/item/melee/transforming/plasmacutter/process()
	open_flame()

/obj/item/melee/transforming/plasmacutter/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(.)
		if(active)
			if(sword_color)
				icon_state = "sword[sword_color]"
			START_PROCESSING(SSobj, src)
			set_light_on(TRUE)
		else
			STOP_PROCESSING(SSobj, src)
			set_light_on(FALSE)

/obj/item/melee/transforming/plasmacutter/get_temperature()
	return active * heat

/obj/item/melee/transforming/plasmacutter/ignition_effect(atom/A, mob/user)
	if(!active)
		return ""

	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask)
			in_mouth = ", barely missing [C.p_their()] nose"
	. = span_warning("[user] swings [user.p_their()] [name][in_mouth]. [user.p_they(TRUE)] light[user.p_s()] [user.p_their()] [A.name] in the process.")
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)

/obj/item/melee/transforming/plasmacutter/regular
	name = "plasma cutter"
	desc = "A bright green plasma cutter."
	icon_state = "plasmacutter0"
	icon_state_on = "plasmacutter1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 10
	force_on = 25
	throwforce = 5
	throwforce_on = 20
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	w_class_on = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 0.25
	attack_verb_off = list("attacked", "burned", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = "#00FF00"
	total_mass = null

/obj/item/melee/transforming/plasmacutter/regular/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] swings [src] towards [user.p_their()] head! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS|FIRELOSS)

/obj/item/melee/transforming/plasmacutter/regular/adam
	name = "plasma cutter adam"
	desc = "A bright crimson plasma cutter.."
	icon_state = "adam0"
	icon_state_on = "adam1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 10
	force_on = 40
	throwforce = 5
	throwforce_on = 20
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	w_class_on = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 0.75
	attack_verb_off = list("attacked", "burned", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = "#FF0000"
	total_mass = null

/obj/item/melee/transforming/plasmacutter/regular/eve
	name = "plasma cutter eve"
	desc = "A violet colored plasma cutter. An inscription on it reads: In the land of the shadow of death a light has dawned."
	icon_state = "eve0"
	icon_state_on = "eve1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 10
	force_on = 30
	throwforce = 5
	throwforce_on = 20
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	w_class_on = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 0.5
	attack_verb_off = list("attacked", "burned", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = "#A020F0"
	total_mass = null

/obj/item/melee/transforming/plasmacutter/regular/celestia
	name = "plasma cutter celestia"
	desc = "A sapphire colored plasma cutter."
	icon_state = "celestia0"
	icon_state_on = "celestia1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 10
	force_on = 20
	throwforce = 5
	throwforce_on = 15
	hitsound = 'sound/weapons/bladeslice.ogg'
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	w_class_on = WEIGHT_CLASS_HUGE
	flags_1 = CONDUCT_1
	armour_penetration = 0.3
	attack_verb_off = list("attacked", "burned", "cleaved", "torn", "cut")
	attack_verb_on = list()
	light_color = "#0F52BA"
	total_mass = null

/obj/item/melee/transforming/plasmacutter/sword
	name = "energy sword"
	desc = "May the force be within you."
	icon_state = "sword0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	embedding = list("embed_chance" = 75, "impact_pain_mult" = 10)
	armour_penetration = 0.65
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/energy_sword
	var/list/possible_colors = list("red" = LIGHT_COLOR_RED, "blue" = LIGHT_COLOR_LIGHT_CYAN, "green" = LIGHT_COLOR_GREEN, "purple" = LIGHT_COLOR_LAVENDER)

/datum/block_parry_data/energy_sword
	parry_time_windup = 0
	parry_time_active = 25
	parry_time_spindown = 0
	// we want to signal to players the most dangerous phase, the time when automatic counterattack is a thing.
	parry_time_windup_visual_override = 1
	parry_time_active_visual_override = 3
	parry_time_spindown_visual_override = 12
	parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK		// esword users can attack while
	parry_time_perfect = 2.5		// first ds isn't perfect
	parry_time_perfect_leeway = 1.5
	parry_imperfect_falloff_percent = 5
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 65		// VERY generous
	parry_efficiency_perfect = 100
	parry_failed_stagger_duration = 4 SECONDS
	parry_cooldown = 0.5 SECONDS

/obj/item/melee/transforming/plasmacutter/sword/Initialize(mapload)
	. = ..()
	set_sword_color()

/obj/item/melee/transforming/plasmacutter/sword/proc/set_sword_color()
	if(LAZYLEN(possible_colors))
		set_light_color(possible_colors[pick(possible_colors)])

/obj/item/melee/transforming/plasmacutter/sword/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	if(active)
		AddElement(/datum/element/sword_point)
	else
		RemoveElement(/datum/element/sword_point)

/obj/item/melee/transforming/plasmacutter/sword/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(!active)
		return NONE
	return ..()

/obj/item/melee/transforming/plasmacutter/sword/on_active_parry(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, list/block_return, parry_efficiency, parry_time)
	. = ..()
	if(parry_efficiency >= 80)		// perfect parry
		block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_RETURN_TO_SENDER
		. |= BLOCK_SHOULD_REDIRECT

/obj/item/melee/transforming/plasmacutter/sword/cyborg
	sword_color = "red"
	light_color = "#ff0000"
	possible_colors = null
	var/hitcost = 50

/obj/item/melee/transforming/plasmacutter/sword/cyborg/attack(mob/M, mob/living/silicon/robot/R)
	if(R.cell)
		var/obj/item/stock_parts/cell/C = R.cell
		if(active && !(C.use(hitcost)))
			attack_self(R)
			to_chat(R, span_notice("It's out of charge!"))
			return
		return ..()

/obj/item/melee/transforming/plasmacutter/sword/cyborg/saw //Used by medical Syndicate cyborgs
	name = "energy saw"
	desc = "For heavy duty cutting. It has a carbon-fiber blade in addition to a toggleable hard-light edge to dramatically increase sharpness."
	force_on = 30
	force = 18 //About as much as a spear
	hitsound = 'sound/weapons/circsawhit.ogg'
	icon = 'icons/obj/surgery.dmi'
	icon_state = "esaw_0"
	icon_state_on = "esaw_1"
	sword_color = null //stops icon from breaking when turned on.
	hitcost = 75 //Costs more than a standard cyborg esword
	w_class = WEIGHT_CLASS_NORMAL
	sharpness = SHARP_EDGED
	light_color = "#40ceff"
	tool_behaviour = TOOL_SAW
	toolspeed = 0.7

/obj/item/melee/transforming/plasmacutter/sword/cyborg/saw/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	return NONE

/obj/item/melee/transforming/plasmacutter/sword/saber
	possible_colors = list("red" = LIGHT_COLOR_RED, "blue" = LIGHT_COLOR_LIGHT_CYAN, "green" = LIGHT_COLOR_GREEN, "purple" = LIGHT_COLOR_LAVENDER)
	var/hacked = FALSE

/obj/item/melee/transforming/plasmacutter/sword/saber/set_sword_color()
	if(LAZYLEN(possible_colors))
		sword_color = pick(possible_colors)
		set_light_color(possible_colors[sword_color])

/obj/item/melee/transforming/plasmacutter/sword/saber/process()
	. = ..()
	if(hacked)
		var/set_color = pick(possible_colors)
		set_light_color(possible_colors[set_color])

/obj/item/melee/transforming/plasmacutter/sword/saber/red
	possible_colors = list("red" = LIGHT_COLOR_RED)

/obj/item/melee/transforming/plasmacutter/sword/saber/blue
	possible_colors = list("blue" = LIGHT_COLOR_LIGHT_CYAN)

/obj/item/melee/transforming/plasmacutter/sword/saber/green
	possible_colors = list("green" = LIGHT_COLOR_GREEN)

/obj/item/melee/transforming/plasmacutter/sword/saber/purple
	possible_colors = list("purple" = LIGHT_COLOR_LAVENDER)

/obj/item/melee/transforming/plasmacutter/sword/saber/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/multitool))
		if(!hacked)
			hacked = TRUE
			sword_color = "rainbow"
			to_chat(user, span_warning("RNBW_ENGAGE"))

			if(active)
				icon_state = "swordrainbow"
				user.update_inv_hands()
		else
			to_chat(user, span_warning("It's already fabulous!"))
	else
		return ..()

/obj/item/melee/transforming/plasmacutter/sword/pirate
	name = "energy cutlass"
	desc = "Arrrr matey."
	icon_state = "cutlass0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state_on = "cutlass1"
	light_color = "#ff0000"
	possible_colors = null

/obj/item/melee/transforming/plasmacutter/blade
	name = "energy blade"
	desc = "A concentrated beam of energy in the shape of a blade. Very stylish... and lethal."
	icon_state = "blade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 30 //Normal attacks deal esword damage
	hitsound = 'sound/weapons/blade1.ogg'
	active = 1
	throwforce = 1 //Throwing or dropping the item deletes it.
	throw_speed = 3
	throw_range = 1
	w_class = WEIGHT_CLASS_BULKY//So you can't hide it in your pocket or some such.
	var/datum/effect_system/spark_spread/spark_system
	sharpness = SHARP_EDGED

//Most of the other special functions are handled in their own files. aka special snowflake code so kewl
/obj/item/melee/transforming/plasmacutter/blade/Initialize()
	. = ..()
	spark_system = new /datum/effect_system/spark_spread()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)

/obj/item/melee/transforming/plasmacutter/blade/transform_weapon(mob/living/user, supress_message_text)
	return

/obj/item/melee/transforming/plasmacutter/blade/hardlight
	name = "hardlight blade"
	desc = "An extremely sharp blade made out of hard light. Packs quite a punch."
	icon_state = "lightblade"
	item_state = "lightblade"

/*/////////////////////////////////////////////////////////////////////////
/////////////		The TRUE Energy Sword		///////////////////////////
*//////////////////////////////////////////////////////////////////////////

/obj/item/melee/transforming/plasmacutter/sword/cx
	name = "non-eutactic blade"
	desc = "The Non-Eutactic Blade utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable."
	icon_state = "cxsword_hilt"
	item_state = "cxsword"
	force = 3
	force_on = 21
	throwforce = 5
	throwforce_on = 20
	hitsound = "swing_hit" //it starts deactivated
	hitsound_on = 'sound/weapons/nebhit.ogg'
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = SHARP_EDGED
	embedding = list("embedded_pain_multiplier" = 6, "embed_chance" = 20, "embedded_fall_chance" = 60)
	armour_penetration = 0.2
	block_chance = 35
	light_color = "#37FFF7"
	actions_types = list()

/obj/item/melee/transforming/plasmacutter/sword/cx/Initialize()
	icon_state_on = icon_state
	return ..()

/obj/item/melee/transforming/plasmacutter/sword/cx/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/melee/transforming/plasmacutter/sword/cx/alt_pre_attack(atom/A, mob/living/user, params)	//checks if it can do right click memes
	altafterattack(A, user, TRUE, params)
	return TRUE

/obj/item/melee/transforming/plasmacutter/sword/cx/transform_weapon(mob/living/user, supress_message_text)
	. = ..()
	update_icon()

/obj/item/melee/transforming/plasmacutter/sword/cx/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/nebon.ogg' : 'sound/weapons/neboff.ogg', 65, 1)
	if(!supress_message_text)
		to_chat(user, span_notice("[src] [active ? "is now active":"can now be concealed"]."))


/obj/item/melee/transforming/plasmacutter/sword/cx/update_overlays()
	. = ..()
	var/mutable_appearance/blade_overlay = mutable_appearance(icon, "cxsword_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance(icon, "cxsword_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	. += gem_overlay

	if(active)
		. += blade_overlay

/obj/item/melee/transforming/plasmacutter/sword/cx/AltClick(mob/living/user)
	. = ..()
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, span_warning("You can't do that right now!"))
		return TRUE

	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"","Choose Energy Color",light_color) as color|null
		if(energy_color_input)
			set_light_color(sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1))
		update_icon()
	return TRUE

/obj/item/melee/transforming/plasmacutter/sword/cx/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to recolor it.")

/obj/item/melee/transforming/plasmacutter/sword/cx/worn_overlays(isinhands, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(active)
		if(isinhands)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "cxsword_blade")
			blade_inhand.color = light_color
			. += blade_inhand

//Broken version. Not a toy, but not as strong.
/obj/item/melee/transforming/plasmacutter/sword/cx/broken
	name = "misaligned non-eutactic blade"
	desc = "The Non-Eutactic Blade utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable. This one seems to have a damaged handle and misaligned components, causing the blade to be unstable at best"
	force_on = 15 //As strong a survival knife/bone dagger

/obj/item/melee/transforming/plasmacutter/sword/cx/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/melee/transforming/plasmacutter/sword/cx))
		if(HAS_TRAIT(W, TRAIT_NODROP) || HAS_TRAIT(src, TRAIT_NODROP))
			to_chat(user, span_warning("\the [HAS_TRAIT(src, TRAIT_NODROP) ? src : W] is stuck to your hand, you can't attach it to \the [HAS_TRAIT(src, TRAIT_NODROP) ? W : src]!"))
			return
		else
			to_chat(user, span_notice("You combine the two light swords, making a single supermassive blade! You're cool."))
			new /obj/item/dualsaber/hypereutactic(user.drop_location())
			qdel(W)
			qdel(src)
	else
		return ..()

////////		Tatortot NEB		/////////////// (same stats as regular esword)
/obj/item/melee/transforming/plasmacutter/sword/cx/traitor
	name = "\improper Dragon's Tooth Sword"
	desc = "The Dragon's Tooth sword is a blackmarket modification of a Non-Eutactic Blade, \
			which utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable. \
			It appears to have a wooden grip and a shaved down guard."
	icon_state = "cxsword_hilt_traitor"
	force_on = 30
	armour_penetration = 0.65
	embedding = list("embedded_pain_multiplier" = 10, "embed_chance" = 75, "embedded_fall_chance" = 0, "embedded_impact_pain_multiplier" = 10)
	block_chance = 50
	hitsound_on = 'sound/weapons/blade1.ogg'
	light_color = "#37F0FF"

/obj/item/melee/transforming/plasmacutter/sword/cx/traitor/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, 1)
	if(!supress_message_text)
		to_chat(user, span_notice("[src] [active ? "is now active":"can now be concealed"]."))



////////////
//Weaponry//
////////////

//This feels like a misc set of items left over from normal SS13.
//~TK

//SORD
//Katana
//Temporal Katana
//Bokken
//Bokken debug
//Wired Rod
//Red Phone
//Throwing Star
//Shock Throwing Star
//Cane
//Wizard Staff
//Broom
//Ectoplasm
//Bust (lmao)
//Tail Club
//Liz o' nine tails
//Cat o' nine tails
//Flyswatter
//Circled Hand
//Slapper
//Extendo Hand
//ACME Extendo-Hand
//Vibro Weapon Template
//Pitchfork
//Demonic Pitchfork
//Greater Demonic Pitchfork
//Ascended Demonic Pitchfork
//Archieved Homerun Bat


//Remains of code/game/objects/items/weaponry.dm
//WEAPONS HERE ARE UNLIKELY TO BE BALANCED FOR F13 COMBAT and not everything here is a weapon
/obj/item/banhammer
	desc = "A banhammer."
	name = "banhammer"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "toyhammer"
	slot_flags = ITEM_SLOT_BELT
	throwforce = 0
	force = 1
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 3
	throw_range = 7
	attack_verb = list("banned")
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF

/obj/item/banhammer/suicide_act(mob/user)
		user.visible_message(span_suicide("[user] is hitting [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to ban [user.p_them()]self from life."))
		return (BRUTELOSS|FIRELOSS|TOXLOSS|OXYLOSS)
/*
oranges says: This is a meme relating to the english translation of the ss13 russian wiki page on lurkmore.
mrdoombringer sez: and remember kids, if you try and PR a fix for this item's grammar, you are admitting that you are, indeed, a newfriend.
for further reading, please see: https://github.com/tgstation/tgstation/pull/30173 and https://translate.google.com/translate?sl=auto&tl=en&js=y&prev=_t&hl=en&ie=UTF-8&u=%2F%2Flurkmore.to%2FSS13&edit-text=&act=url
*/
/obj/item/banhammer/attack(mob/M, mob/user)
	if(user.zone_selected == BODY_ZONE_HEAD)
		M.visible_message(span_danger("[user] are stroking the head of [M] with a bangammer"), span_userdanger("[user] are stroking the head with a bangammer"), "you hear a bangammer stroking a head");
	else
		M.visible_message(span_danger("[M] has been banned FOR NO REISIN by [user]"), span_userdanger("You have been banned FOR NO REISIN by [user]"), "you hear a banhammer banning someone")
	playsound(loc, 'sound/effects/adminhelp.ogg', 15) //keep it at 15% volume so people don't jump out of their skin too much
	if(user.a_intent != INTENT_HELP)
		return ..(M, user)

/obj/item/sord
	name = "\improper SORD"
	desc = "This thing is so unspeakably shitty you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 2
	throwforce = 1
	w_class = WEIGHT_CLASS_NORMAL
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")

/obj/item/sord/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is trying to impale [user.p_them()]self with [src]! It might be a suicide attempt if it weren't so shitty."), \
	span_suicide("You try to impale yourself with [src], but it's USELESS..."))
	return SHAME


/obj/item/katana
	name = "katana"
	desc = "After the world ended, seppuku rates in Japan skyrocketed!"
	icon_state = "katana"
	item_state = "katana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
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

/obj/item/katana/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is slitting [user.p_their()] stomach open with [src]! It looks like [user.p_theyre()] trying to commit seppuku!"))
	playsound(src, 'sound/weapons/bladeslice.ogg', 50, 1)
	return(BRUTELOSS)

/obj/item/katana/timestop
	name = "temporal katana"
	desc = "Delicately balanced, this finely-crafted blade hums with barely-restrained potential."
	icon_state = "temporalkatana"
	item_state = "temporalkatana"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	block_chance = 0 // oops
	force = 27.5 // oops
	item_flags = ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/bokken/quick_parry/proj

/obj/item/katana/timestop/on_active_parry(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, list/block_return, parry_efficiency, parry_time)
	if(ishuman(owner))
		var/mob/living/carbon/human/flynn = owner
		flynn.emote("smirk")
	new /obj/effect/timestop/magic(get_turf(owner), 1, 50, list(owner)) // null roddies counter

/obj/item/katana/timestop/suicide_act(mob/living/user) // stolen from hierophant staff
	new /obj/effect/timestop/magic(get_turf(user), 1, 50, list(user)) // free usage for dying
	user.visible_message(span_suicide("[user] poses menacingly with the [src]! It looks like [user.p_theyre()] trying to teleport behind someone!"))
	user.say("Heh.. Nothing personnel, kid..", forced = "temporal katana suicide")
	sleep(20)
	if(!user)
		return
	user.visible_message(span_hierophant_warning("[user] vanishes into a cloud of falling dust and burning embers, likely off to style on some poor sod in the distance!"))
	playsound(user,'sound/magic/blink.ogg', 75, TRUE)
	for(var/obj/item/I in user)
		if(I != src)
			user.dropItemToGround(I)
	user.dropItemToGround(src) //Drop us last, so it goes on top of their stuff
	qdel(user)

/obj/item/melee/bokken // parrying stick
	name = "bokken"
	desc = "A Japanese training sword made of wood and shaped like a katana."
	icon_state = "bokken"
	item_state = "bokken"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
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
	parry_stamina_cost = 8 // be wise about when you parry, though, else you won't be able to fight enough to make it count
	parry_time_windup = 0
	parry_time_active = 10 // small parry window
	parry_time_spindown = 0
	// parry_flags = PARRY_DEFAULT_HANDLE_FEEDBACK		// bokken users can no longer strike while parrying
	parry_time_perfect = 1.5
	parry_time_perfect_leeway = 1
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 120
	parry_efficiency_considered_successful = 65		// VERY generous
	parry_efficiency_perfect = 120
	parry_efficiency_perfect_override = list(
		TEXT_ATTACK_TYPE_PROJECTILE = 30,
	)
	parry_failed_stagger_duration = 3 SECONDS
	parry_data = list(
		PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 2.5, // 7*2.5 = 17.5, 8*2.5 = 20, 9*2.5 = 22.5, 10*2.5 = 25
	)

/datum/block_parry_data/bokken/quick_parry // emphasizing REALLY SHORT PARRIES
	parry_stamina_cost = 6 // still more costly than most parries, but less than a full bokken parry
	parry_time_active = 5 // REALLY small parry window
	parry_time_perfect = 2.5 // however...
	parry_time_perfect_leeway = 2 // the entire time, the parry is perfect
	parry_failed_stagger_duration = 1 SECONDS
	parry_failed_clickcd_duration = 1 SECONDS // more forgiving punishments for missed parries
	// still, don't fucking miss your parries or you're down stamina and staggered to shit

/datum/block_parry_data/bokken/quick_parry/proj
	parry_efficiency_perfect_override = list()

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

/obj/item/phone/suicide_act(mob/user)
	if(locate(/obj/structure/chair/stool) in user.loc)
		user.visible_message(span_suicide("[user] begins to tie a noose with [src]'s cord! It looks like [user.p_theyre()] trying to commit suicide!"))
	else
		user.visible_message(span_suicide("[user] is strangling [user.p_them()]self with [src]'s cord! It looks like [user.p_theyre()] trying to commit suicide!"))
	return(OXYLOSS)

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
	armour_penetration = 0.15

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
	armour_penetration = 1
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

/obj/item/ectoplasm/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] is inhaling [src]! It looks like [user.p_theyre()] trying to visit the astral plane!"))
	return (OXYLOSS)

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
	addtimer(CALLBACK(src, /datum.proc/_AddElement, list(/datum/element/beauty, 1000)), 0)

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
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE, .proc/ownerExamined)

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
	addtimer(CALLBACK(src, .proc/waitASecond, owner, sucker), 4)

/// Stage 2: Fear sets in
/obj/item/circlegame/proc/waitASecond(mob/living/owner, mob/living/sucker)
	if(QDELETED(sucker) || QDELETED(src) || QDELETED(owner))
		return

	if(owner == sucker) // big mood
		to_chat(owner, span_danger("Wait a second... you just looked at your own [src.name]!"))
		addtimer(CALLBACK(src, .proc/selfGottem, owner), 10)
	else
		to_chat(sucker, span_danger("Wait a second... was that a-"))
		addtimer(CALLBACK(src, .proc/GOTTEM, owner, sucker), 6)

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
	to_chat(sucker, "<span class='danger'><b>[owner] sees the fear in your eyes as you try to look away from [owner.p_their()] [src.name]!</b></span>")

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


/obj/item/vibro_weapon
	icon_state = "hfrequency0"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "vibro sword"
	desc = "A potent weapon capable of cutting through nearly anything. Wielding it in two hands will allow you to deflect gunfire."
	armour_penetration = 1
	block_chance = 40
	throwforce = 20
	throw_speed = 4
	sharpness = SHARP_EDGED
	attack_verb = list("cut", "sliced", "diced")
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/vibro_weapon/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

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


/obj/item/pitchfork
	icon_state = "pitchfork0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "pitchfork"
	desc = "A simple tool used for moving hay."
	force = 20
	throwforce = 20
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("attacked", "impaled", "pierced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	resistance_flags = FIRE_PROOF

/obj/item/pitchfork/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/pitchfork/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, force_unwielded=20, force_wielded=30, icon_wielded="pitchfork1")
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

/obj/item/pitchfork/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] impales [user.p_them()]self in [user.p_their()] abdomen with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return (BRUTELOSS)

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





///////////////////////
//Secondary Misc Crap//
///////////////////////

//Just more junk, spread over the nine hells.
//~TK

//Chain of Command
//Fake Chain of Command
//Synthetic Arm Blade
//Officers Sabre
//Plastitanium Rapier
//Contractor Baton
//Supermatter Sword
//Advanced Roasting Stick
//Cleric Mace



/obj/item/melee/proc/check_martial_counter(mob/living/carbon/human/target, mob/living/carbon/human/user)
	if(target.check_martial_melee_block())
		target.visible_message(span_danger("[target.name] blocks [src] and twists [user]'s arm behind [user.p_their()] back!"),
					span_userdanger("You block the attack!"))
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
	user.visible_message(span_suicide("[user] is strangling [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
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
	user.visible_message(span_suicide("[user] is trying to cut off all [user.p_their()] limbs with [src]! it looks like [user.p_theyre()] trying to commit suicide!"))
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
			visible_message(span_warning("[user] gently taps [target] with [src]."),null,null,COMBAT_MESSAGE_RANGE)
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
	return span_danger("The baton is still charging!")

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
	visible_message(span_warning("[src] appears, balanced ever so perfectly on its hilt. This isn't ominous at all."))

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
	visible_message(span_danger("The blast wave smacks into [src] and rapidly flashes to ash."),\
	span_italic("You hear a loud crack as you are washed with a wave of heat."))
	consume_everything()

/obj/item/melee/supermatter_sword/acid_act()
	visible_message(span_danger("The acid smacks into [src] and rapidly flashes to ash."),\
	span_italic("You hear a loud crack as you are washed with a wave of heat."))
	consume_everything()

/obj/item/melee/supermatter_sword/bullet_act(obj/item/projectile/P)
	visible_message(span_danger("[P] smacks into [src] and rapidly flashes to ash."),\
	span_italic("You hear a loud crack as you are washed with a wave of heat."))
	consume_everything(P)
	return BULLET_ACT_HIT

/obj/item/melee/supermatter_sword/suicide_act(mob/user)
	user.visible_message(span_suicide("[user] touches [src]'s blade. It looks like [user.p_theyre()] tired of waiting for the radiation to kill [user.p_them()]!"))
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
			to_chat(user, span_warning("You can't retract [src] while [held_sausage] is attached!"))
			return
		retract(user)

	playsound(src.loc, 'sound/weapons/batonextend.ogg', 50, 1)
	add_fingerprint(user)

/obj/item/melee/roastingstick/attackby(atom/target, mob/user)
	..()
	if (istype(target, /obj/item/reagent_containers/food/snacks/sausage))
		if (!on)
			to_chat(user, span_warning("You must extend [src] to attach anything to it!"))
			return
		if (held_sausage)
			to_chat(user, span_warning("[held_sausage] is already attached to [src]!"))
			return
		if (user.transferItemToLoc(target, src))
			held_sausage = target
		else
			to_chat(user, span_warning("[target] doesn't seem to want to get on [src]!"))
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
			to_chat(user, "Your [held_sausage] has already been cooked.")
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
