
/obj/item/melee/smith
	name = "base class obj/item/melee/smith" //tin. handles overlay and quality and shit.
	desc = "cringe"
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "claymore"
	lefthand_file = 'code/modules/smithing/icons/onmob/lefthand.dmi'
	righthand_file = 'code/modules/smithing/icons/onmob/righthand.dmi'
	mob_overlay_icon = 'code/modules/smithing/icons/onmob/slot.dmi'
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	total_mass = TOTAL_MASS_TOY_SWORD //casually making it where it takes very little stamina to swing
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/bokken
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_SUITSTORE 
	w_class = WEIGHT_CLASS_NORMAL
	force = WEAPON_FORCE_TOOL_SMALL
	obj_flags = UNIQUE_RENAME
//	var/quality
	var/overlay_state = "woodenrod"
	var/mutable_appearance/overlay
	//var/wielded_mult = 1
	var/is_sharpened = FALSE

/obj/item/melee/smith/Initialize()
	. = ..()
	if(desc == "cringe")
		desc = "A handmade [name]."
	overlay = mutable_appearance(icon, overlay_state)
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
	if(force < 0)
		force = 0

/obj/item/melee/smith/twohand
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	lefthand_file = 'code/modules/smithing/icons/onmob/lefthand.dmi'
	righthand_file = 'code/modules/smithing/icons/onmob/righthand.dmi'
	item_flags = NEEDS_PERMIT //it's a bigass sword/spear. beepsky is going to give you shit for it. // if we had beepskies this is a post apoc dumbass
	sharpness = SHARP_EDGED
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_SUITSTORE
	var/icon_prefix = null

/obj/item/melee/smith/twohand/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD,PROC_REF(on_wield))
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD,PROC_REF(on_unwield))

/obj/item/melee/smith/twohand/proc/on_wield(obj/item/source, mob/user)
	wielded = TRUE

/obj/item/melee/smith/twohand/proc/on_unwield(obj/item/source, mob/user)
	wielded = FALSE

/obj/item/melee/smith/twohand/update_icon_state()
	icon_state = "[icon_prefix]"

/obj/item/melee/smith/twohand/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 70) //decent in a pinch, but pretty bad.
	AddElement(/datum/element/sword_point)



//////////////////////
//					//
//  SMITHED TOOLS	//
//					//
//////////////////////

// Blacksmithing hammer, not useful for anything else.
/obj/item/melee/smith/hammer
	name = "smithing hammer"
	desc = "A hammer for smacking raw materials into place, if you've got the skills to use it."
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "hammer"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	inhand_icon_state = "hammer"
	overlay_state = "hammerhandle"
	var/qualitymod = 0

/obj/item/melee/smith/hammer/premade
//	quality = 3
//	qualitymod = 1
	custom_materials = list(/datum/material/iron = 1000)

/obj/item/melee/smith/hammer/premadeadam
	custom_materials = list(/datum/material/adamantine = 1000)

// The true manual mining scanner, knock it on rock to scan. Could use a cooldown, can't be bothered to sort it. Lowest quality got too short range to test out.
/obj/item/mining_scanner/prospector
	name = "prospectors pick"
	desc = "A pick that can sound rocks to find mineral deposits."
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "prospect_smith"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	inhand_icon_state = "prospect_smith"
	sharpness = SHARP_EDGED

/obj/item/mining_scanner/prospector/Initialize()
	..()
	var/mutable_appearance/overlay
	desc = "A handmade [name]."
	overlay = mutable_appearance(icon, "handle_prospect")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)

/obj/item/mining_scanner/prospector/afterattack(atom/A, mob/living/user, proximity)
	. = ..()
	if(!proximity || IS_STAMCRIT(user))
		return
	if(istype(A, /turf/closed/mineral))
		mineral_scan_pulse(get_turf(user), range)
		playsound(src, 'sound/effects/Glassknock.ogg', 50, 1)

/obj/item/mining_scanner/prospector/attack_self(mob/user)
	return

/obj/item/pickaxe/smithed
	name = "pickaxe"
	desc = "A pickaxe."
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "pickaxe"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	inhand_icon_state = "pickaxe"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	sharpness = SHARP_EDGED
	digrange = 1
	toolspeed = 0.2

/obj/item/pickaxe/smithed/Initialize()
	..()
	desc = "A handmade [name]."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "handle_pickaxe")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
	if(force < 0)
		force = 0

/obj/item/pickaxe/smithed/attack_self(mob/user)
		to_chat(user, span_notice("Tool does not have a configureable dig range."))

/obj/item/shovel/smithed
	name = "shovel"
	desc = "A shovel."
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "shovel"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	inhand_icon_state = "shovel"
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	sharpness = SHARP_EDGED //it cuts through the earth

/obj/item/shovel/smithed/Initialize()
	..()
	desc = "A handmade [name]."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "shovelhandle")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
	if(force < 0)
		force = 0

// Smithed crowbars top out at 0.2 toolspeed max quality. Not bad. Not that useful either, its just a crowbar, still.
/obj/item/crowbar/smithed
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "crowbar_smith"
	inhand_icon_state = "crowbar"
	toolspeed = 0.8
	force = WEAPON_FORCE_TOOL_LARGE
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/crowbar/smithed/Initialize()
	..()
	desc = "A handmade [name]."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "handle_crowbar")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)

// Crowbar-axe. Just a crowbar with more force and a homemade vibe.
/obj/item/crowbar/smithedunitool
	name = "crowbaxe"
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
	icon_state = "unitool_smith"
	lefthand_file = 'code/modules/smithing/icons/onmob/lefthand.dmi'
	righthand_file = 'code/modules/smithing/icons/onmob/righthand.dmi'
	inhand_icon_state = "unitool_smith"
	sharpness = SHARP_EDGED
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	force = WEAPON_FORCE_AXE_TOOL

/obj/item/crowbar/smithedunitool/Initialize()
	..()
	desc = "A bizarre combination of a crowbar and some sort of knifeblade."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "handle_unitool")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)



//////////////////////////
//						//
//	UNARMED WEAPONS		//
//						//
//////////////////////////

/obj/item/melee/smith/unarmed
	name = "glove weapon template"
	desc = "should not be here"
	icon = 'code/modules/smithing/icons/blacksmith.dmi'
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

/obj/item/melee/smith/unarmed/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/H = user
	if(unarmed_adjusted)
		mob_overlay_icon = righthand_file
	if(!unarmed_adjusted)
		mob_overlay_icon = lefthand_file
	if(ishuman(user) && slot == SLOT_GLOVES)
		ADD_TRAIT(user, TRAIT_UNARMED_WEAPON, "glove")
		if(HAS_TRAIT(user, TRAIT_UNARMED_WEAPON))
			H.dna.species.punchdamagehigh += force + 8
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

/obj/item/melee/smith/unarmed/knuckles
	name = "scrap knuckles"
	desc = "Hardened knuckle grip made out of metal. They protect your hand, and do more damage, in unarmed combat."
	icon_state = "knuckles_smith"
	inhand_icon_state = "knuckles_smith"
	overlay_state = "grip_knuckles"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	attack_verb = list("punched", "jabbed", "whacked")

	force = 25 // 35 when masterworked, 45 when whetstoned
	force_unwielded = 25
	force_wielded = 25

/obj/item/melee/smith/unarmed/claws
	name = "scrap claws"
	desc = "Gloves with short claws built into the palms."
	icon_state = "claws_smith"
	inhand_icon_state = "claws_smith"
	overlay_state = "grip_claws"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	attack_verb = list("slashed", "sliced", "torn", "ripped", "diced", "cut")
	sharpness = SHARP_EDGED

	force = 25 // 35 when masterworked, 45 when whetstoned
	force_unwielded = 25
	force_wielded = 25

	hitsound = 'sound/weapons/bladeslice.ogg'

//
// Shortswords + extra
// Not the best, not the worst.
// + Hits hard enough
// - Slow because of it
//

/obj/item/melee/smith/sword
	name = "shortsword"
	desc = "It's a one handed 'sword'. To kill a vagabond, swing at it until it dies."
	icon_state = "sword_smith"
	inhand_icon_state = "sword_smith"
	overlay_state = "hilt_sword"
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	layer = MOB_UPPER_LAYER

	force = 35 // 45 = MW, 55 = Masterwork + Whetstone, 65 = Master Work + Whetstone + Big leagues 
	force_unwielded = 35 // 
	force_wielded = 45 // 75 max extra damage. As a treat. 
	block_chance = 3 // learn to parry, filthy casual
	attack_speed = CLICK_CD_MELEE * 1.1 
	backstab_multiplier = 1.1

/obj/item/melee/smith/sword/spatha
	name = "spatha"
	icon_state = "spatha_smith"
	inhand_icon_state = "spatha_smith"
	overlay_state = "hilt_spatha"

/obj/item/melee/smith/sword/sabre
	name = "sabre"
	icon_state = "sabre_smith"
	inhand_icon_state = "sabre_smith"
	overlay_state = "hilt_sabre"

/obj/item/melee/smith/sword/machete
	name = "machete"
	icon_state = "machete_smith"
	overlay_state = "hilt_machete"

/obj/item/melee/smith/sword/gladius
	name = "gladius"
	icon_state = "gladius_smith"
	overlay_state = "hilt_gladius"

/obj/item/melee/smith/sword/reforged
	name = "mowerblade machete"
	icon_state = "macheter_smith"
	overlay_state = "hilt_macheter"

/obj/item/melee/smith/sword/mace
	name = "mace"
	icon_state = "mace_smith"
	overlay_state = "shaft_mace"
	sharpness = SHARP_NONE // kinda not a sword lol

//
// DAGGERS
// Light, and fast
// BEEG backstab bonus
// Less damage, though.
//

/obj/item/melee/smith/dagger
	name = "dagger"
	desc = "It's a smithed dagger with a HUGE backstab bonus."
	icon_state = "dagger_smith"
	overlay_state = "hilt_dagger"
	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_EDGED
	force = 23 // max is 53 
	force_unwielded = 23
	force_wielded =  25 // max is 55
	block_chance = 1 // haha. SERIOUSLY. LEARN TO PARRY.
	attack_speed = CLICK_CD_MELEE * 0.6 
	backstab_multiplier = 4 // absolutely kino goated with the sauce 
	throwforce= 40 // p good as a throwing weapon, but not as good as backstab spam
	embedding = list("pain_mult" = 4, "embed_chance" = 65, "fall_chance" = 10, "ignore_throwspeed_threshold" = TRUE)
	hitsound = 'sound/weapons/rapierhit.ogg'

/obj/item/melee/smith/dagger/bowie
	name = "bowie knife"
	icon_state = "bowie_smith"
	overlay_state = "hilt_bowie"

/obj/item/melee/smith/dagger/saw
	name = "saw"
	icon_state = "saw_smith"
	overlay_state = "handle_saw"

/obj/item/melee/smith/dagger/wakizashi
	name = "wakizashi"
	icon_state = "waki_smith"
	overlay_state = "hilt_waki"

/obj/item/melee/smith/dagger/throwingknife
	name = "kunai"
	icon_state = "throwing_smith"
	overlay_state = "handle_throwing"
	inhand_icon_state = "dagger_smith"

/obj/item/melee/smith/dagger/javelin
	name = "throwing spear"
	icon_state = "javelin_smith"
	overlay_state = "shaft_javelin"
	inhand_icon_state = "javelin_smith"
	w_class = WEIGHT_CLASS_NORMAL

//
// Longsword
// + Damage
// - Slower
// - Bulky
// -/+ literally the inbetween "giant ass sword" and "teensy girldagger"
//

/obj/item/melee/smith/twohand/longsword
	name = "longsword"
	icon_state = "longsword_smith"
	icon_prefix = "longsword_smith"
	overlay_state = "hilt_longsword"

	force = 40
	force_unwielded = 40 // 70 max
	force_wielded = 50 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat

	w_class = WEIGHT_CLASS_BULKY
	hitsound = 'sound/weapons/rapierhit.ogg'
	layer = MOB_UPPER_LAYER

/obj/item/melee/smith/twohand/longsword/katana
	name = "katana"
	icon_state = "katana_smith"
	icon_prefix = "katana_smith"
	overlay_state = "hilt_katana"

/obj/item/melee/smith/twohand/longsword/axe
	name = "woodsplitter"
	icon_state = "axe_smith"
	icon_prefix = "axe_smith"
	overlay_state = "shaft_axe"

//
// 		Greatweapons
// +	big damage
// +	AP
// + blockchance
// +/-	weapon for hyper enjoyers duh
// - 	Slow
// - 	Huge
//

/obj/item/melee/smith/twohand/warhoned
	name = "greataxe"
	icon_state = "warhoned_smith"
	icon_prefix = "warhoned_smith"
	overlay_state = "shaft_warhoned"
	w_class = WEIGHT_CLASS_BULKY
	layer = MOB_UPPER_LAYER

	force = 35 
	force_unwielded = 35 // 65 max
	force_wielded = 80 // 110 max
	throwforce = 0 
	block_chance = 10 // I do not expect your dumb, slow ass to be parrying. Not NEAR as good as dedicated blocking chance weapons, though
	attack_speed = CLICK_CD_MELEE * 1.3 
	armour_penetration =  0.3 // actually fucking HUGE
	backstab_multiplier = 1.1 // as a treat

/obj/item/melee/smith/twohand/warhoned/crusher
	name = "greathammer"
	icon_state = "crusher_smith"
	icon_prefix = "crusher_smith"
	overlay_state = "shaft_crusher"
	sharpness = SHARP_NONE

/obj/item/melee/smith/twohand/warhoned/scrapblade
	name = "greatsword"
	icon_state = "scrap_smith"
	icon_prefix = "scrap_smith"
	overlay_state = "hilt_scrap"

// 
// Spears
// + Reach
// + Throw
// + Block Chance
// +/- single most TUNED item so far. Should feel good to use. 
// - No AP despite size
// - Slow
// - Bulky
// 

/obj/item/melee/smith/twohand/spear
	name = "spear"
	icon_state = "spear_smith"
	icon_prefix = "spear_smith"
	overlay_state = "shaft_spear"

	force = 25 
	force_unwielded = 25 // 35 max
	force_wielded = 60 // 90 max
	throwforce = 60
	block_chance = 15 // P-Much a dedicated blocking weapon
	attack_speed = CLICK_CD_MELEE * 1.5  // slow as sin to make up for it
	backstab_multiplier = 2 // makes an otherwise non-position heavy weapon a little more tactical

	w_class = WEIGHT_CLASS_BULKY
	sharpness = SHARP_EDGED
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/melee/smith/twohand/spear/lance
	name = "lance"
	icon_state = "lance_smith"
	icon_prefix = "lance_smith"
	overlay_state = "shaft_lance"

/obj/item/melee/smith/twohand/spear/trident
	name = "trident"
	icon_state = "trident_smith"
	icon_prefix = "trident_smith"
	overlay_state = "shaft_trident"

// TG stuff

//unique hammers
/obj/item/melee/smith/hammer/toolbox
	name = "toolbox hammer"
	desc = "A metal filled toolbox on a stick. Useable as a really shitty hammer."
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "toolbox"
	overlay_state = "hammerhandle"
//	qualitymod = 0

/obj/item/melee/smith/hammer/narsie
	name = "runemetal hammer"
	custom_materials = list(/datum/material/runedmetal = 12000)
	desc = "A metal hammer inscribed with geometeric runes."
//	qualitymod = 1

/obj/item/melee/smith/hammer/narsie/attack(mob/living/target, mob/living/carbon/human/user)
	if(!iscultist(user))
		user.DefaultCombatKnockdown(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message(span_warning("A powerful force shoves [user] away from [target]!"), \
							span_cultlarge("\"You shouldn't be touching tools that aren't yours.\""))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2,force))
		return
	..()

/*/obj/item/melee/smith/hammer/ratvar
	name = "brass hammer"
	custom_materials = list(/datum/material/bronze = 12000)
	desc = "A brass hammer inscribed with... writing? You can't read it."
//	qualitymod = 1

/obj/item/melee/smith/hammer/ratvar/attack(mob/living/target, mob/living/carbon/human/user)
	if(!is_servant_of_ratvar(user))
		user.DefaultCombatKnockdown(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message(span_warning("A powerful force shoves [user] away from [target]!"), span_neovgre("\"You shouldn't be touching tools that aren't yours.\""))
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2,force))
		return
	..()*/

/obj/item/melee/smith/hammer/debug
	name = "debugging hammer"
	desc = "A DEBUGGING HAMMER!! EPIC!!."
//	qualitymod = 10
