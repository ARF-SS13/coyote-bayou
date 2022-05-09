
/obj/item/melee/smith
	name = "base class obj/item/melee/smith" //tin. handles overlay and quality and shit.
	desc = "cringe"
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "claymore"
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON //yeah ok
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	force = 6
	obj_flags = UNIQUE_RENAME
	var/quality
	var/overlay_state = "stick"
	var/mutable_appearance/overlay
	var/wielded_mult = 1
	var/wield_force = 15

/obj/item/melee/smith/Initialize()
	..()
	if(desc == "cringe")
		desc = "A handmade [name]."
	overlay = mutable_appearance(icon, overlay_state)
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
	if(force < 0)
		force = 0


/obj/item/melee/smith/twohand
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	item_flags = NEEDS_PERMIT //it's a bigass sword/spear. beepsky is going to give you shit for it.
	sharpness = SHARP_EDGED
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	force = 10
	wielded_mult = 1.8
	w_class = WEIGHT_CLASS_BULKY
	var/icon_prefix = null
	var/wielded = FALSE

/obj/item/melee/smith/twohand/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

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
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "hammer"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	item_state = "hammer"
	overlay_state = "hammerhandle"
	var/qualitymod = 0

/obj/item/melee/smith/hammer/premade
	custom_materials = list(/datum/material/iron=1000)
	quality = 5

// The true manual mining scanner, knock it on rock to scan. Could use a cooldown, can't be bothered to sort it. Lowest quality got too short range to test out.
/obj/item/mining_scanner/prospector
	name = "prospectors pick"
	desc = "A pick that can sound rocks to find mineral deposits."
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "prospect_smith"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	item_state = "prospect_smith"
	sharpness = SHARP_POINTY

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
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "pickaxe"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	item_state = "pickaxe"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	sharpness = SHARP_POINTY

/obj/item/pickaxe/smithed/Initialize()
	..()
	desc = "A handmade [name]."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "woodrod")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)
	if(force < 0)
		force = 0

/obj/item/pickaxe/smithed/attack_self(mob/user)
		to_chat(user, "<span class='notice'>Tool does not have a configureable dig range.</span>")

/obj/item/shovel/smithed
	name = "shovel"
	desc = "A shovel."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "shovel"
	lefthand_file = 'icons/fallout/onmob/tools/tools_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/tools_righthand.dmi'
	item_state = "shovel"
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
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "crowbar_smith"
	item_state = "crowbar"
	toolspeed = 0.8
	force = 15
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
	name = "universal tool"
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "unitool_smith"
	lefthand_file = 'icons/fallout/onmob/weapons/melee1h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee1h_righthand.dmi'
	item_state = "unitool_smith"
	sharpness = SHARP_POINTY
	material_flags = MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	force = 28

/obj/item/crowbar/smithedunitool/Initialize()
	..()
	desc = "A bizarre combination of a crowbar and some sort of knifeblade."
	var/mutable_appearance/overlay
	overlay = mutable_appearance(icon, "handle_unitool")
	overlay.appearance_flags = RESET_COLOR
	add_overlay(overlay)



//////////////////////////
//						//
//  ONEHANDED WEAPONS	//
//						//
//////////////////////////

/obj/item/melee/smith/sword
	name = "sword"
	icon_state = "sword_smith"
	item_state = "sword_smith"
	overlay_state = "hilt_sword"
	armour_penetration = 0.1
	force = 23
	sharpness = SHARP_EDGED
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/captain_saber
	w_class = WEIGHT_CLASS_BULKY
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	layer = MOB_UPPER_LAYER
	wound_bonus = 30

/obj/item/melee/smith/sword/spatha
	name = "spatha"
	icon_state = "spatha_smith"
	item_state = "spatha_smith"
	overlay_state = "hilt_spatha"
	block_chance = 18

/obj/item/melee/smith/sword/sabre
	name = "sabre"
	icon_state = "sabre_smith"
	item_state = "sabre_smith"
	overlay_state = "hilt_sabre"
	armour_penetration = 0.15
	force = 22


/obj/item/melee/smith/dagger
	name = "dagger"
	icon_state = "dagger_smith"
	overlay_state = "hilt_dagger"
	w_class = WEIGHT_CLASS_SMALL
	sharpness = SHARP_EDGED
	force = 22
	hitsound = 'sound/weapons/rapierhit.ogg'

/obj/item/melee/smith/machete
	name = "machete"
	icon_state = "machete_smith"
	overlay_state = "hilt_machete"
	force = 24
	sharpness = SHARP_EDGED
	wound_bonus = 30

/obj/item/melee/smith/machete/gladius
	name = "gladius"
	icon_state = "gladius_smith"
	overlay_state = "hilt_gladius"
	block_chance = 10

/obj/item/melee/smith/machete/reforged
	name = "reforged machete"
	icon_state = "macheter_smith"
	overlay_state = "hilt_macheter"

/obj/item/melee/smith/wakizashi
	name = "wakizashi"
	icon_state = "waki_smith"
	overlay_state = "hilt_waki"
	sharpness = SHARP_EDGED
	force = 22
	item_flags = NEEDS_PERMIT | ITEM_CAN_PARRY
	block_parry_data = /datum/block_parry_data/waki
	hitsound = 'sound/weapons/rapierhit.ogg'

/datum/block_parry_data/waki //like longbokken but worse reflect
	parry_stamina_cost = 6
	parry_time_windup = 0
	parry_time_active = 15 //decent window
	parry_time_spindown = 0
	parry_time_perfect = 2
	parry_time_perfect_leeway = 0.75
	parry_imperfect_falloff_percent = 7.5
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 80
	parry_efficiency_perfect = 120
	parry_failed_stagger_duration = 3 SECONDS
	parry_data = list(PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 1.9)

// Mace - low damage, high AP (25, 0,4)
/obj/item/melee/smith/mace 
	name = "mace"
	icon_state = "mace_smith"
	overlay_state = "handle_mace"
	force = 13


//////////////////////////
//						//
//  TWOHANDED WEAPONS	//
//						//
//////////////////////////

/obj/item/melee/smith/twohand/katana
	name = "katana"
	icon_state = "katana_smith"
	icon_prefix = "katana_smith"
	overlay_state = "hilt_katana"
	force = 20
	wielded_mult = 1.5
	item_flags = ITEM_CAN_PARRY | NEEDS_PERMIT
	block_parry_data = /datum/block_parry_data/smithrapier
	hitsound = 'sound/weapons/rapierhit.ogg'
	slot_flags = ITEM_SLOT_BELT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	layer = MOB_UPPER_LAYER

/datum/block_parry_data/smithrapier //Old rapier code reused. parry into riposte. i am pretty sure this is going to be nearly fucking impossible to land.
	parry_stamina_cost = 12 //dont miss
	parry_time_active = 4
	parry_time_perfect = 2
	parry_time_perfect_leeway = 2
	parry_failed_stagger_duration = 3 SECONDS
	parry_failed_clickcd_duration = 3 SECONDS
	parry_time_windup = 0
	parry_time_spindown = 0
	parry_imperfect_falloff_percent = 0
	parry_efficiency_to_counterattack = 100
	parry_efficiency_considered_successful = 120
	parry_efficiency_perfect = 120
	parry_data = list(PARRY_COUNTERATTACK_MELEE_ATTACK_CHAIN = 4)

// Heavy axe, 2H focused chopper 27/54. Can be worn on your back.
/obj/item/melee/smith/twohand/axe
	name = "heavy axe"
	icon_state = "axe_smith"
	icon_prefix = "axe_smith"
	overlay_state = "shaft_axe"
	total_mass = TOTAL_MASS_MEDIEVAL_WEAPON * 2
	force = 15
	wielded_mult = 2
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	slot_flags = ITEM_SLOT_BACK
	layer = MOB_UPPER_LAYER

// Scrap blade. 1/2 H chopper, variant on the axe basically 32/48. Can be worn on your back.
/obj/item/melee/smith/twohand/axe/scrapblade
	name = "scrap blade"
	icon_state = "scrap_smith"
	icon_prefix = "scrap_smith"
	overlay_state = "hilt_scrap"
	force = 20
	wielded_mult = 1.5

/obj/item/melee/smith/twohand/spear
	name = "spear"
	icon_state = "spear_smith"
	icon_prefix = "spear_smith"
	overlay_state = "shaft_spear"
	max_reach = 2
	force = 10
	sharpness = SHARP_POINTY

/obj/item/melee/smith/twohand/spear/lance
	name = "legion lance"
	icon_state = "lance_smith"
	icon_prefix = "lance_smith"
	overlay_state = "shaft_lance"


//////////////////////////
//						//
//  THROWING WEAPONS	//
//						//
//////////////////////////


// Good throwing, thats about it (27, 40)
/obj/item/melee/smith/javelin 
	name = "javelin"
	icon_state = "javelin_smith"
	overlay_state = "shaft_javelin"
	item_state = "javelin_smith"
	sharpness = SHARP_POINTY
	embedding = list("pain_mult" = 2, "embed_chance" = 60, "fall_chance" = 20, "ignore_throwspeed_threshold" = TRUE)
	force = 15
	armour_penetration = 0.10

// Smaller weaker javelin, easier to store/carry, less effective
/obj/item/melee/smith/throwingknife
	name = "throwing knife"
	icon_state = "throwing_smith"
	overlay_state = "handle_throwing"
	item_state = "dagger_smith"
	embedding = list("pain_mult" = 2, "embed_chance" = 50, "fall_chance" = 20, "ignore_throwspeed_threshold" = TRUE)
	force = 14
	w_class = WEIGHT_CLASS_SMALL


// TG stuff

//unique hammers
/obj/item/melee/smith/hammer/toolbox
	name = "toolbox hammer"
	desc = "A metal filled toolbox on a stick. Useable as a really shitty hammer."
	w_class = WEIGHT_CLASS_BULKY
	icon_state = "toolbox"
	overlay_state = "hammerhandle"
	qualitymod = 0

/obj/item/melee/smith/hammer/narsie
	name = "runemetal hammer"
	custom_materials = list(/datum/material/runedmetal = 12000)
	desc = "A metal hammer inscribed with geometeric runes."
	qualitymod = 1

/obj/item/melee/smith/hammer/narsie/attack(mob/living/target, mob/living/carbon/human/user)
	if(!iscultist(user))
		user.DefaultCombatKnockdown(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message("<span class='warning'>A powerful force shoves [user] away from [target]!</span>", \
							"<span class='cultlarge'>\"You shouldn't be touching tools that aren't yours.\"</span>")
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2,force))
		return
	..()

/obj/item/melee/smith/hammer/ratvar
	name = "brass hammer"
	custom_materials = list(/datum/material/bronze = 12000)
	desc = "A brass hammer inscribed with... writing? You can't read it."
	qualitymod = 1

/obj/item/melee/smith/hammer/ratvar/attack(mob/living/target, mob/living/carbon/human/user)
	if(!is_servant_of_ratvar(user))
		user.DefaultCombatKnockdown(100)
		user.dropItemToGround(src, TRUE)
		user.visible_message("<span class='warning'>A powerful force shoves [user] away from [target]!</span>", "<span class='neovgre'>\"You shouldn't be touching tools that aren't yours.\"</span>")
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			H.apply_damage(rand(force/2, force), BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		else
			user.adjustBruteLoss(rand(force/2,force))
		return
	..()

/obj/item/melee/smith/hammer/debug
	name = "debugging hammer"
	desc = "A DEBUGGING HAMMER!! EPIC!!."
	qualitymod = 10
