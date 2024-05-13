// In this document: Onehanded templates, Swords, Knives, Clubs, Glove weapons, Tool weapons

/obj/item/melee //Melee weapon template
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	block_parry_data = /datum/block_parry_data/bokken
	item_flags = ITEM_CAN_PARRY
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/melee/onehanded
	name = "onehand melee template"
	desc = "should not exist"
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	force = 30
	throwforce = 10
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON


////////////
// SWORDS //
////////////		-block, 34-39 damage


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
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 55
	throwforce = 10
	block_chance = 20
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
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
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
	force = 35 // lets make this an actual weapon and not a wiffle bat
	throwforce = 60 // Its normal sized, throwing spears should hurt
	embedding = list("pain_mult" = 2, "embed_chance" = 40, "fall_chance" = 15)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_special_component = /datum/component/weapon_special/ranged_spear



////////////
// KNIVES //
////////////		-small AP bonus, 23-31 damage. Attack fast.

/obj/item/melee/onehanded/knife
	name = "knife template"
	desc = "should not exist"
	item_state = "knife"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_MASK
	tool_behaviour = TOOL_SCREWDRIVER
	toolspeed = 4
	throwforce = 15
	hitsound = 'sound/weapons/bladeslice.ogg'
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

/obj/item/melee/onehanded/knife/hunting
	name = "hunting knife"
	icon_state = "knife_hunting"
	desc = "A dependable hunting knife. Good for skinning one's kills."
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	force = 23
	throwforce = 25
	backstab_multiplier = 1.65
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "cut")
	toolspeed = 0.7

/obj/item/melee/onehanded/knife/survival
	name = "survival knife"
	icon_state = "knife_survival"
	desc = "A high-quality pre-war survival knife. Perfect for a survivalist or hunter."
	embedding = list("pain_mult" = 4, "embed_chance" = 35, "fall_chance" = 10)
	force = 23
	backstab_multiplier = 1.65
	throwforce = 25
	toolspeed = 0.3

/obj/item/melee/onehanded/knife/bayonet
	name = "bayonet knife"
	icon_state = "knife_bayonet"
	desc = "This weapon is made for stabbing, not much use for other things."
	force = 23
	backstab_multiplier = 1.65
	bayonet = TRUE

/obj/item/melee/onehanded/knife/bowie
	name = "bowie knife"
	icon_state = "knife_bowie"
	item_state = "knife_bowie"
	desc = "Now this is a knife! Better as both a tool and weapon than most knives, but loses out to specialized tools."
	force = 28
	throwforce = 25
	backstab_multiplier = 1.65
	attack_verb = list("slashed", "stabbed", "sliced", "shanked", "ripped", "lacerated")
	toolspeed = 0.5

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
	backstab_multiplier = 1.85
	custom_materials = null
	attack_speed = 6.4

/obj/item/melee/onehanded/knife/ritualdagger
	name = "ritual dagger"
	desc = "An ancient blade used to carry out spiritual and mystic rituals."
	icon_state = "knife_ritual"
	item_state = "knife_ritual"
	force = 25
	custom_materials = null
	backstab_multiplier = 2
	tool_behaviour = TOOL_RITUAL
	toolspeed = 1

/obj/item/melee/onehanded/knife/switchblade
	name = "switchblade"
	desc = "A sharp, concealable, spring-loaded knife."
	icon_state = "knife_switch"
	w_class = WEIGHT_CLASS_TINY
	force = 3
	throwforce = 5
	hitsound = 'sound/weapons/genhit.ogg'
	attack_verb = list("stubbed", "poked")
	var/extended = 0
	var/extended_force = 21
	var/extended_throwforce = 23
	backstab_multiplier = 2
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
		w_class = WEIGHT_CLASS_SMALL
		throwforce = extended_throwforce
		icon_state = extended_icon_state
		attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
		hitsound = 'sound/weapons/bladeslice.ogg'
		sharpness = SHARP_EDGED
	else
		force = initial(force)
		w_class = WEIGHT_CLASS_TINY
		throwforce = initial(throwforce)
		icon_state = retracted_icon_state
		attack_verb = list("stubbed", "poked")
		hitsound = 'sound/weapons/genhit.ogg'
		sharpness = SHARP_NONE

//////////////////
// Cosmic Knife //
////////////////// now you do the cleaning & heating manually.

/obj/item/melee/onehanded/knife/cosmicdirty
	name = "dirty cosmic knife"
	desc = "A high-quality kitchen knife made from Saturnite alloy, this one is covered in oxidation. Perhaps Abraxo might clean it up?"
	icon_state = "knife_cosmic_dirty"
	item_state = "knife"
	force = 15
	throwforce = 10
	backstab_multiplier = 1.85

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
	backstab_multiplier = 1.85
	toolspeed = 0.8

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
	backstab_multiplier = 1.85
	throwforce = 20
	w_class = WEIGHT_CLASS_NORMAL // Its super hot, not comfy to put back in your pocket.

/obj/item/melee/onehanded/knife/throwing
	name = "throwing knife"
	desc = "a finely balanced knife made from a lightweight alloy, designed for being thrown. You can easily embed these in someone, and you look darn cool while doing so."
	icon_state = "knife_throw"
	force = 20
	throwforce = 45 // Shits made out of prewar metals, may make telekinesis really good with throwing knives
	backstab_multiplier = 1.90
	bare_wound_bonus = 15 //keep your arteries covered
	throw_speed = 5
	throw_range = 7
	embedding = list("pain_mult" = 4, "embed_chance" = 70, "fall_chance" = 5)

///////////
// CLUBS //
///////////		- stamina damage, 26-30 damage

// Pipe
/obj/item/melee/onehanded/club
	name = "pipe"
	desc = "A piece of rusted metal pipe, good for smashing heads. "
	icon_state = "pipe"
	item_state = "pipe"
	attack_verb = list("mashed", "bashed", "piped", "hit", "bludgeoned", "whacked", "bonked")
	force = 26
	backstab_multiplier = 1.85
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
	force_wielded = 43
	force_unwielded = 30
	backstab_multiplier = 1.55
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
	backstab_multiplier = 1.50
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
	slot_flags = INV_SLOTBIT_BELT
	force = 18
	backstab_multiplier = 1.50
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

	/*if(IS_STAMCRIT(user))//CIT CHANGE - makes batons unusuable in stamina softcrit
		to_chat(user, span_warning("You're too exhausted for that."))//CIT CHANGE - ditto
		return */ //CIT CHANGE - ditto // If your in near stamina crit your already dead

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
			target.adjustStaminaLoss(stam_dmg)
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
	slot_flags = INV_SLOTBIT_BELT
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
		slot_flags = INV_SLOTBIT_BELT
		w_class = WEIGHT_CLASS_SMALL
		force = force_off
		attack_verb = list("hit", "poked")
	playsound(loc, on_sound, 50, TRUE)
	add_fingerprint(user)


/obj/item/melee/f13onehanded/boomerang
	name = "boomerang"
	desc = "An ancient, primitive weapon used by hunters, able to return when thrown and surprisingly powerful for a piece of wood, this one seems to be equipped with non functioning electronics"
	icon_state = "boomerang"
	item_state = "boomerang"
	force = 30
	throwforce = 20 // 5 points worse than a hunting knife, equiv to gar glasses
	throw_speed = 4
	w_class = WEIGHT_CLASS_SMALL
	backstab_multiplier = 1.40
	attack_verb = list("beat", "smacked", "clubbed", "clobbered")
	sharpness = SHARP_NONE
	attack_speed = CLICK_CD_MELEE
	var/throw_hit_chance = 99

/obj/item/melee/f13onehanded/boomerang/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force)
	if(ishuman(thrower))
		var/mob/living/carbon/human/H = thrower
		H.throw_mode_on() //so they can catch it on the return.
	return ..()

/obj/item/melee/f13onehanded/boomerang/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	if(thrownby && !caught)
		sleep(1)
		if(!QDELETED(src))
			throw_at(thrownby, throw_range+2, throw_speed, null, TRUE)
	else if(!thrownby)
		return
	return



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

///////////////////
// GLOVE WEAPONS //
///////////////////		-faster attack speed


/obj/item/melee/unarmed
	name = "glove weapon template"
	desc = "should not be here"
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	attack_speed = CLICK_CD_MELEE * 0.9
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	sharpness = SHARP_NONE

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
			H.dna.species.punchdamagehigh = 12
			H.dna.species.punchdamagelow = 6
		if(HAS_TRAIT(user, TRAIT_STEELFIST))
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
	backstab_multiplier = 1.40

// Spiked knuckles	Keywords: Damage 28
/obj/item/melee/unarmed/brass/spiked
	name = "spiked knuckes"
	desc = "Unlike normal brass knuckles, these have a metal plate across the knuckles with four spikes on, one for each knuckle. So not only does the victim feel the force of the punch, but also the devastating effects of spikes being driven in."
	icon_state = "spiked"
	item_state = "spiked"
	sharpness = SHARP_POINTY
	force = 28


// Sappers			Keywords: Damage 27
/obj/item/melee/unarmed/sappers
	name = "sappers"
	desc = "Lead filled gloves which are ideal for beating the crap out of opponents. Deals significant stamina damage. I mean, I wouldn't want to get punched in the chest with it..."
	icon_state = "sapper"
	item_state = "sapper"
	w_class = WEIGHT_CLASS_NORMAL
	force = 27
	backstab_multiplier = 1.40

/obj/item/melee/unarmed/sappers/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(20, STAMINA, "head", M.run_armor_check("head", "melee"))

// Snowflake sappers	Keywords: Damage 27
/obj/item/melee/unarmed/sappers/fightgloves
	name = "MMA gloves"
	desc = "Padded gloves which are ideal for beating the crap out of opponents while keeping your own hands protected."
	icon_state = "fightglovesblack"
	item_state = "fightglovesblack"
	w_class = WEIGHT_CLASS_NORMAL
	force = 27
	backstab_multiplier = 1.40

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
	backstab_multiplier = 1.40
	hitsound = 'sound/weapons/bladeslice.ogg'

// Lacerator		Keywords: Damage 29, Edged, Wound bonus
/obj/item/melee/unarmed/lacerator
	name = "lacerator"
	desc = "Leather gloves with razor blades built into the back of the hand."
	icon_state = "lacerator"
	item_state = "lacerator"
	w_class = WEIGHT_CLASS_NORMAL
	force = 29
	backstab_multiplier = 1.40
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
	backstab_multiplier = 1.50
	sharpness = SHARP_NONE

// Punch Dagger		Keywords: Damage 29, Pointy
/obj/item/melee/unarmed/punchdagger
	name = "punch dagger"
	desc = "A dagger designed to be gripped in the user�s fist with the blade protruding between the middle and ring fingers, to increase the penetration of a punch."
	icon_state = "punch_dagger"
	item_state = "punch_dagger"
	force = 29
	backstab_multiplier = 2
	sharpness = SHARP_POINTY
	attack_verb = list("stabbed", "sliced", "pierced", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/melee/unarmed/punchdagger/cyborg
	name = "assaultron claws"
	desc = "Razor sharp blades embedded into the grippers of an assaultron. Sharp."
	icon_state = "tiger_claw"
	item_state = "tiger_claw"
	force = 40 //Assaultron, so, makes sense.
	backstab_multiplier = 1.40

// Deathclaw Gauntlet	Keywords: Damage 35, AP 1
/obj/item/melee/unarmed/deathclawgauntlet
	name = "deathclaw gauntlet"
	desc = "The severed hand of a mighty Deathclaw, cured, hollowed out, and given a harness to turn it into the deadliest gauntlet the wastes have ever seen."
	icon_state = "deathclaw_g"
	item_state = "deathclaw_g"
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	force = 35
	backstab_multiplier = 1.5
	armour_penetration = 0 //HAHAHAHAHAHAHAHAHAHAHAHAHAHAHHAHAHAHAHAHAHAHHAHA, ONE MY ASS LMFAO ~TK
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'

//Yao Guai Gauntlet	Keywords: Damage 25, Fast, "Saw Bleed" Effect
/obj/item/melee/unarmed/yaoguaigauntlet
	name = "yao guai gauntlet"
	desc = "The severed hand of a yao guai, the hide cured, the muscles and bone removed, and given a harness to turn it into a deadly gauntlet. A weapon worthy of the Sulfurs."
	icon_state = "yao_guai_g"
	item_state = "deathclaw_g"
	slot_flags = INV_SLOTBIT_GLOVES
	w_class = WEIGHT_CLASS_NORMAL
	force = 23
	backstab_multiplier = 1.5
	sharpness = SHARP_EDGED
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.75 //6

/obj/item/melee/unarmed/yaoguaigauntlet/attack(mob/living/target, mob/living/user)
	. = ..()
	if(!isliving(target))
		return
	target.apply_status_effect(/datum/status_effect/stacking/saw_bleed/yaoguaigauntlet)


/////////////////
// POWER FISTS //
/////////////////		-Uses power (gas currently) for knockback. Heavy AP, specialized for attacking heavy armor

// Power Fist			Throws targets. Max damage 52. Full AP.
/obj/item/melee/unarmed/powerfist
	name = "power fist"
	desc = "A metal gauntlet with a piston-powered ram on top for that extra 'oomph' in your punch."
	icon_state = "powerfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	attack_verb = list("whacked", "fisted", "power-punched")
	force = 45 //needs more hefty damage to be worthwhile outside pvp. will have to test
	throwforce = 10
	throw_range = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	var/throw_distance = 1
	attack_speed = CLICK_CD_MELEE

/obj/item/melee/unarmed/powerfist/attack(mob/living/target, mob/living/user, attackchain_flags = NONE)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, span_warning("You don't want to harm other living beings!"))
		return FALSE
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	var/totalitemdamage = target.pre_attacked_by(src, user)
	SSdamage.damage_mob(user, target, totalitemdamage)
	target.visible_message(span_danger("[user]'s powerfist lets out a loud hiss as [user.p_they()] punch[user.p_es()] [target.name]!"), \
		span_userdanger("You cry out in pain as [user]'s punch flings you backwards!"))
	new /obj/effect/temp_visual/kinetic_blast(target.loc)
	playsound(loc, 'sound/weapons/resonator_blast.ogg', 50, 1)
	playsound(loc, 'sound/weapons/genhit2.ogg', 50, 1)
	var/atom/throw_target = get_edge_target_turf(target, get_dir(src, get_step_away(target, src)))
	target.throw_at(throw_target, 2 * throw_distance, 0.5 + (throw_distance / 2))
	log_combat(user, target, "power fisted", src)

// Goliath				Throws targets far. Max damage 50.
/obj/item/melee/unarmed/powerfist/goliath
	name = "Goliath"
	desc = "A massive, experimental metal gauntlet crafted by some poor bastard in Redwater that since outlived their usefulness. The piston-powered ram on top is designed to throw targets very, very far."
	icon = 'icons/fallout/objects/melee/melee.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	icon_state = "goliath"
	item_state = "goliath"
	force = 55 //legendary tier power fist, one of a kind, why should it hit for less than a machete
	throw_distance = 5
	backstab_multiplier = 1.50

// Mole Miner
/obj/item/melee/unarmed/powerfist/moleminer
	name = "mole miner gauntlet"
	desc = "A hand-held mining and cutting implement, repurposed into a deadly melee weapon.  Its name origins are a mystery..."
	icon_state = "mole_miner_g"
	item_state = "mole_miner_g"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 33 //tiger claws tier
	backstab_multiplier = 1.50
	throwforce = 10
	throw_range = 7
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	tool_behaviour = TOOL_MINING
	var/digrange = 2 //This should give it the 3x2 dig range that drills and some picks have
	toolspeed = 0.2 //This should make it dig really quick. Like a moleminer!
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	armor = ARMOR_VALUE_GENERIC_ITEM

///////////
// TOOLS //
///////////		-generally max 24 damage

//Tribal Butcher's Knife
/obj/item/kitchen/knife/butcher/tribal
	name = "Carving Knife"
	desc = "A simple, hand-fashioned carving knife meant for separating meat from bone. Hardly more than some sharpened, rusty metal stuck between a tied wooden handle."
	icon_state = "knife_butcher_primal"
	force = 13
	backstab_multiplier = 3
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
	backstab_multiplier = 2 // >:3 
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
	backstab_multiplier = 1.4
	throwforce = 15
	toolspeed = 0.7
	sharpness = SHARP_EDGED
	attack_verb = list("cleaved", "chopped", "sliced", "slashed")
	weapon_special_component = /datum/component/weapon_special/single_turf

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


// BETA // Obsolete

/obj/item/melee/onehanded/machete/knifetesting
	name = "testing knife"
	icon_state = "knife_bowie"
	item_state = "knife_bowie"
	force = 18
	throwforce = 15

/obj/item/melee/onehanded/machete/clubtesting
	name = "1hgeneric"
	icon_state = "tire"
	item_state = "tire"
	force = 20

/obj/item/melee/onehanded/machete/swordtesting
	name = "topmelee"
	icon_state = "machete_imp"
	item_state = "salvagedmachete"
	force = 30

//Fenny makes fucking handfans because they're cute and maybe dangerous. ~TK
/obj/item/melee/handfan
	name = "handfan"
	desc = "A foldable fan, made out of some sort of hardwood and pink fabric. Good for coolin off, or looking haughty as fuck."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "handfanclosed_0"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	item_state = null
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NONE
	force = 0
	var/on = FALSE
	var/on_sound = 'sound/weapons/batonextend.ogg'
	var/on_icon_state = "handfanopen_1"
	var/off_icon_state = "handfanclosed_0"
	var/on_item_state = "nullrod"
	attack_verb = list("<span class='love'>fanned %t</span>")
	var/force_on = 0
	var/force_off = 0
	var/weight_class_on = WEIGHT_CLASS_BULKY
	total_mass = TOTAL_MASS_TINY_ITEM
	attack_speed = CLICK_CD_MELEE * 0.5

/obj/item/melee/handfan/proc/get_on_off_description()
	if(on)
		return span_alert("You open the fan with a smooth flicking motion.")
	else
		return span_notice("You collapse the fan with a smooth flicking motion.")

/obj/item/melee/handfan/examine()

/obj/item/melee/handfan/attack_self(mob/user)
	TOGGLE_VAR(on)
	if(on)
		to_chat(user, get_on_off_description())
		icon_state = on_icon_state
		item_state = on_item_state
		w_class = weight_class_on
		force = force_on
		attack_verb = list(span_love("fanned"))
	else
		to_chat(user, get_on_off_description())
		icon_state = off_icon_state
		item_state = null //no sprite for concealment even when in hand
		slot_flags = INV_SLOTBIT_BELT
		w_class = WEIGHT_CLASS_SMALL
		force = force_off
		attack_verb = list("badgered", "beat")
	playsound(loc, on_sound, 50, TRUE)
	add_fingerprint(user)


