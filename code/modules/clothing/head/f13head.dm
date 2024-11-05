/*PARENT ITEMS FOR REFERENCE PURPOSES. DO NOT UNCOMMENT

/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	inhand_icon_state = "that"
	body_parts_covered = HEAD
	slot_flags = INV_SLOTBIT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	dynamic_hair_suffix = "+generic"
	var/datum/beepsky_fashion/beepsky_fashion //the associated datum for applying this to a secbot
	var/list/speechspan = null

/obj/item/clothing/head/Initialize()
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/get_head_speechspans(mob/living/carbon/user)
	if(speechspan)
		return speechspan
	else
		return

/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	inhand_icon_state = "helmet"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEEARS | HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES

	dog_fashion = /datum/dog_fashion/head/helmet

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_HEAD))*/

//Combat Armor FACTION SPECIFIC COMBAT ARMOR IN f13factionhead.dm

/obj/item/clothing/head/helmet/f13/combat
	name = "combat helmet"
	desc = "An old military grade Pre-Fall combat helmet."
	icon_state = "combat_helmet"
	inhand_icon_state = "combat_helmet"
	armor = ARMOR_VALUE_MEDIUM
	strip_delay = 50
	flags_inv = HIDEEARS|HIDEHAIR
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/head/helmet/f13/combat/dark
	color = "#302E2E" // Dark Grey

/obj/item/clothing/head/helmet/f13/combat/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/f13/combat/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/head/helmet/f13/combat/mk2
	name = "reinforced combat helmet"
	desc = "An advanced Pre-Fall titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms."
	icon_state = "combat_helmet_mk2"
	inhand_icon_state = "combat_helmet_mk2"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/head/helmet/f13/combat/mk2/custom
	name = "weathered aethergiest power armor helmet"
	desc = "An Enclave 'Equalizer' Advanced power armor helmet-- though this one appears to be more like a mask, to accommodate a aethergiest's uniquely shaped skull. The polarized yellow lenses have long since stopped functioning, and one of the lenses is badly cracked. It's pretty hard to see out of, but it's something, at least."
	icon_state = "arroyohelm"
	inhand_icon_state = "arroyohelm"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2)
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	slowdown = ARMOR_SLOWDOWN_NONE * ARMOR_SLOWDOWN_GLOBAL_MULT
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	flags_inv = HIDESNOUT
	var/requires_training = FALSE

/obj/item/clothing/head/helmet/f13/combat/mk2/dark
	name = "reinforced combat helmet"
	color = "#302E2E" // Dark Grey

/obj/item/clothing/head/helmet/f13/combat/mk2/raider
	name = "customized raider combat helmet"
	desc = "A reinforced combat helmet painted black with the laser designator removed."
	icon_state = "combat_helmet_raider"
	inhand_icon_state = "combat_helmet_raider"

/obj/item/clothing/head/helmet/f13/combat/rangerbroken
	name = "broken riot helmet"
	icon_state = "ranger_broken"
	desc = "An old riot police helmet, out of use around the time of the war."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1

/obj/item/clothing/head/helmet/f13/combat/rangerbroken/smog
	name = "winterized riot helmet"
	icon_state = "modified_usmc_riot_smog"
	inhand_icon_state = "modified_usmc_riot_smog"
	desc = "This helmet was originally intended to be a riot helmet meant for cold climates, now it's a part of a generational heirloom, the once functional night vision has been shot out in one eye, rendering it totally useless, a bullet casing hangs from the now useless radio, tuned in to a dead frequency. an old Alaskan flag is emblazoned on the side."
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1

/obj/item/clothing/head/helmet/f13/combat/swat
	name = "SWAT combat helmet"
	desc = "A prefall combat helmet issued to S.W.A.T. personnel."
	icon_state = "swatsyndie"
	inhand_icon_state = "swatsyndie"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2)


/obj/item/clothing/head/helmet/f13/combat/environmental
	name = "environmental armor helmet"
	desc = "A full head helmet and gas mask, developed for use in heavily contaminated environments."
	icon_state = "env_helmet"
	inhand_icon_state = "env_helmet"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)
	strip_delay = 60
	equip_delay_other = 60
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/f13/combat/environmental/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, FALSE)

//Sulphite Helm

/obj/item/clothing/head/helmet/f13/sulphitehelm
	name = "sulphite helmet"
	desc = "A sulphite raider helmet, affixed with thick anti-ballistic glass over the eyes."
	icon_state = "sulphite_helm"
	inhand_icon_state = "sulphite_helm"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_FIRE_T3)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

//Metal

/obj/item/clothing/head/helmet/knight/f13/metal
	name = "metal helmet"
	desc = "An iron helmet forged by tribal warriors, with a unique design to protect the face from arrows and axes."
	icon_state = "metalhelmet"
	inhand_icon_state = "metalhelmet"
	flags_inv = HIDEMASK|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_MELEE_T2)
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/helmet/knight/f13/metal/reinforced
	name = "reinforced metal helmet"
	icon_state = "metalhelmet_r"
	inhand_icon_state = "metalhelmet_r"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_UP_MELEE_T2)

/obj/item/clothing/head/helmet/knight/f13/rider
	name = "rider helmet" //Not raider. Rider.
	desc = "It's a fancy dark metal helmet with orange spray painted flames."
	icon_state = "rider"
	inhand_icon_state = "rider"

/obj/item/clothing/head/helmet/f13/metalmask
	name = "metal mask"
	desc = "A crudely formed metal hockey mask."
	icon_state = "metal_mask"
	inhand_icon_state = "metal_mask"
	toggle_message = "You lower"
	alt_toggle_message = "You raise"
	can_toggle = 1
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_MELEE_T2)
	flags_inv = HIDEMASK|HIDEEYES|HIDEFACE
	strip_delay = 80
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_inv = HIDEMASK|HIDEEYES|HIDEFACE

/obj/item/clothing/head/helmet/f13/metalmask/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/helmet/f13/metalmask/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/head/helmet/f13/metalmask/mk2
	name = "reinforced metal mask"
	desc = "A reinforced metal hockey mask."
	icon_state = "metal_mask2"
	inhand_icon_state = "metal_mask2"
	armor_tokens = list(ARMOR_MODIFIER_UP_LASER_T3, ARMOR_MODIFIER_UP_MELEE_T3)


/obj/item/clothing/head/helmet/f13/metalmask/custom
	name = "hockey mask"
	desc = "A hockey mask made out of some pretty tough plastic, it's covered in scratches"
	icon_state = "metal_mask2"
	inhand_icon_state = "metal_mask2"
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/head/helmet/f13/tesla
	name = "tesla helmet"
	desc = "A prefall armor design by Nikola Tesla before being confiscated by the U.S. government. Provides high energy weapons resistance."
	icon_state = "tesla_helmet"
	inhand_icon_state = "tesla_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	var/hit_reflect_chance = 20
	protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/obj/item/clothing/head/helmet/f13/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/////////////////
// Power Armor //
/////////////////

/obj/item/clothing/head/helmet/f13/power_armor
	cold_protection = HEAD
	heat_protection = HEAD
	ispowerarmor = 1 //TRUE
	strip_delay = 200
	equip_delay_self = 20
	slowdown = 0.05
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDEMASK|HIDEJUMPSUIT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	clothing_flags = THICKMATERIAL
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	item_flags = SLOWS_WHILE_IN_HAND
	flash_protect = 2
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	speechspan = SPAN_ROBOT //makes you sound like a robot
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 5
	light_on = FALSE
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 10)
	salvage_tool_behavior = TOOL_WELDER
	/// Projectiles below this damage will get deflected
	var/deflect_damage = 18
	/// If TRUE - it requires PA training trait to be worn
	var/requires_training = FALSE // testing if the PA trait is actually fun or not
	/// If TRUE - the suit will give its user specific traits when worn
	var/powered = TRUE
	/// Path of item that this helmet gets salvaged into
	var/obj/item/salvaged_type = null
	/// Used to track next tool required to salvage the suit
	var/salvage_step = 0
	armor = ARMOR_VALUE_PA

/obj/item/clothing/head/helmet/f13/power_armor/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/head/helmet/f13/power_armor/attack_self(mob/living/user)
	toggle_helmet_light(user)

/obj/item/clothing/head/helmet/f13/power_armor/proc/toggle_helmet_light(mob/living/user)
	set_light_on(!light_on)
	update_icon()


/obj/item/clothing/head/helmet/f13/power_armor/mob_can_equip(mob/user, mob/equipper, slot, disable_warning = 1)
	var/mob/living/carbon/human/H = user
	if(src == H.head) //Suit is already equipped
		return ..()
	if (!HAS_TRAIT(H, TRAIT_PA_WEAR) && slot == SLOT_HEAD && requires_training)
		to_chat(user, span_warning("You don't have the proper training to operate the power armor!"))
		return 0
	if(slot == SLOT_HEAD)
		return ..()
	return

/obj/item/clothing/head/helmet/f13/power_armor/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if((attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(70) && (damage < deflect_damage))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/head/helmet/f13/power_armor/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(ispath(salvaged_type))
		switch(salvage_step)
			if(0)
				// Salvage
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the helmet before salvaging it."))
						return
					to_chat(user, span_notice("You begin unsecuring the cover..."))
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 1
						to_chat(user, span_notice("You unsecure the cover."))
					return
			if(1)
				// Salvage
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the helmet before salvaging it."))
						return
					to_chat(user, span_notice("You begin disconnecting the connection ports..."))
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 2
						to_chat(user, span_notice("You disconnect the connection ports."))
					return
				// Fix
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the helmet before fixing it."))
						return
					to_chat(user, span_notice("You begin securing the cover..."))
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 0
						to_chat(user, span_notice("You secure the cover."))
					return
			if(2)
				// Salvage
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the helmet before salvaging it."))
						return
					to_chat(user, span_notice("You begin disconnecting wires..."))
					if(I.use_tool(src, user, 60, volume=70))
						to_chat(user, span_notice("You finish salvaging the helmet."))
						var/obj/item/ST = new salvaged_type(src)
						user.put_in_hands(ST)
						qdel(src)
					return
				// Fix
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, span_warning("You have to take off the helmet before fixing it."))
						return
					to_chat(user, span_notice("You try to anchor connection ports to the frame..."))
					if(I.use_tool(src, user, 80, volume=60))
						salvage_step = 1
						to_chat(user, span_notice("You re-connect connection ports."))
					return
	return ..()

/obj/item/clothing/head/helmet/f13/power_armor/examine(mob/user)
	. = ..()
	if(ispath(salvaged_type))
		. += salvage_hint()

/obj/item/clothing/head/helmet/f13/power_armor/proc/salvage_hint()
	switch(salvage_step)
		if(0)
			return span_notice("The metal cover can be <i>screwed</i> open.")
		if(1)
			return span_notice("The cover is <i>screwed</i> open with connection ports <i>bolted down</i>.")
		if(2)
			return span_warning("The connections ports have been <i>unanchored</i> and only <i>wires</i> remain.")

/obj/item/clothing/head/helmet/f13/power_armor/fluff
	name = "Placeholder Loadout Power Armor Helmet"
	desc = "A placeholder block for personal and loadout power armors."
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon = 'icons/fallout/clothing/helmets.dmi'
	icon_state = "t45bhelmet"
	inhand_icon_state = "t45bhelmet"
	armor = ARMOR_VALUE_HEAVY
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1, ARMOR_MODIFIER_UP_ENV_T1)
	deflect_damage = 5
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	requires_training = FALSE // Testing them if they're disable

/obj/item/clothing/head/helmet/f13/power_armor/fluff/arroyo
	name = "Weathered Deathclaw Power Armor Helmet"
	desc = "An Enclave 'Equalizer' Advanced power armor helmet-- though this one appears to be more like a mask, to accommodate a aethergiest's uniquely shaped skull. The polarized yellow lenses have long since stopped functioning, and one of the lenses is badly cracked. It's pretty hard to see out of, but it's something, at least."
	icon_state = "arroyohelm"
	inhand_icon_state = "arroyohelm"
	flags_inv = HIDESNOUT
/obj/item/clothing/head/helmet/f13/power_armor/fluff/pappavol
	name = "Decaying Power Armor Helmet"
	desc = "Big and green with hints of rust that cover its decaying metal robotic frame. It looks like it was custom built... Roughly put together with shitty welding and crude rivets that hold the green rusty metal together."
	icon_state = "pappavolhelm"
	inhand_icon_state = "pappavolhelm"
	flags_inv = HIDESNOUT

/obj/item/clothing/head/helmet/f13/power_armor/t45b
	name = "Power Armor Helmet Exo-Skeleton"
	desc = "The helmet of a power armors exo-skeleton."
	icon_state = "t45bhelmet"
	inhand_icon_state = "t45bhelmet"
	armor = ARMOR_VALUE_SALVAGE
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b

/obj/item/clothing/head/helmet/f13/power_armor/t45b/raider
	name = "powered scrap helmet"
	desc = "It's a helmet made of scrap metal and wires, some poor attempt at a power armor helmet."
	icon_state = "raiderpa_helm"
	inhand_icon_state = "raiderpa_helm"
	salvaged_type = /obj/item/clothing/head/helmet/f13/raidermetal

/obj/item/clothing/head/helmet/f13/power_armor/t45d
	name = "T-45d power helmet"
	desc = "t's an old Pre-Fall power armor helmet. It's pretty hot inside of it."
	icon_state = "t45dhelmet0"
	inhand_icon_state = "t45dhelmet0"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45d

/obj/item/clothing/head/helmet/f13/power_armor/t45d/update_icon_state()
	icon_state = "t45dhelmet[light_on]"
	inhand_icon_state = "t45dhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t45d/bos
	name = "Brotherhood T-45d power helmet"
	desc = "It's an old Pre-Fall power armor helmet. It's pretty hot inside of it."

/obj/item/clothing/head/helmet/f13/power_armor/t45d/bos/update_icon_state()
	icon_state = "t45dhelmet[light_on]"
	inhand_icon_state = "t45dhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t51b
	name = "T-51b power helmet"
	desc = "It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming."
	icon_state = "t51bhelmet0"
	inhand_icon_state = "t51bhelmet0"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t51b

/obj/item/clothing/head/helmet/f13/power_armor/t51b/update_icon_state()
	icon_state = "t51bhelmet[light_on]"
	inhand_icon_state = "t51bhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t51b/bos
	name = "T-51b power helmet"
	desc = "It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming."

/obj/item/clothing/head/helmet/f13/power_armor/t51b/bos/update_icon_state()
	icon_state = "t51bhelmet[light_on]"
	inhand_icon_state = "t51bhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t60
	name = "T-60a power helmet"
	desc = "The T-60 powered helmet, equipped with targetting software suite, Friend-or-Foe identifiers, dynamic HuD, and an internal music player."
	icon_state = "t60helmet0"
	inhand_icon_state = "t60helmet0"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_LASER_T1)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t60

/obj/item/clothing/head/helmet/f13/power_armor/t60/update_icon_state()
	icon_state = "t60helmet[light_on]"
	inhand_icon_state = "t60helmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t60/pineapple
	name = "degraded T-60a power helmet"
	desc = "The T-60 powered helmet, equipped with targetting software suite, Friend-or-Foe identifiers, dynamic HuD, and an internal music player. This suit is heavily degraded." //reskin of head knight armor
	salvaged_type = null

/obj/item/clothing/head/helmet/f13/power_armor/midwest
	name = "Midwestern T-51b power helmet"
	desc = "This helmet belongs to the Midwestern branch of the Brotherhood of Steel."
	icon_state = "midwestgrey_helm"
	inhand_icon_state = "midwestgrey_helm"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/midwest

/obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	name = "Hardened midwestern T-51b power helmet"
	desc = "This helmet belongs to the Midwestern branch of the Brotherhood of Steel. This particular one has gone through a chemical hardening process, increasing its armor capabilities."
	icon_state = "midwestpa_helm"
	inhand_icon_state = "midwestpa_helm"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/midwest/hardened

/obj/item/clothing/head/helmet/f13/power_armor/excavator
	name = "excavator power helmet"
	desc = "The helmet of the excavator power armor suit."
	icon_state = "excavator"
	inhand_icon_state = "excavator"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_DOWN_BULLET_T3, ARMOR_MODIFIER_DOWN_LASER_T3, ARMOR_MODIFIER_UP_ENV_T3, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/head/helmet/f13/power_armor/advanced
	name = "advanced power helmet"
	desc = "It's an advanced power armor MK1 helmet, typically used by the Enclave. It looks somewhat threatening."
	icon_state = "advhelmet1"
	inhand_icon_state = "advhelmet1"
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T2, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2)

/obj/item/clothing/head/helmet/f13/power_armor/advanced/hellfire
	name = "hellfire power armor"
	desc = "A deep black helmet of Enclave-manufactured heavy power armor with yellow ballistic glass, based on Pre-Fall designs such as the T-51 and improving off of data gathered by post-war designs such as the X-01. Most commonly fielded on the East Coast, no other helmet rivals it's strength."
	icon_state = "hellfirehelm"
	inhand_icon_state = "hellfirehelm"


//Part of the peacekeeper enclave stuff, adjust values as needed.
/obj/item/clothing/head/helmet/f13/power_armor/x02helmet
	name = "Enclave power armor helmet"
	desc = "The Enclave Mark II Powered Combat Armor helmet."
	icon_state = "advanced"
	inhand_icon_state = "advanced"
	slowdown = 0.1
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_UP_BULLET_T3, ARMOR_MODIFIER_UP_LASER_T3)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/x02


//Generic Tribal - For Wayfarer specific, see f13factionhead.dm

/obj/item/clothing/head/helmet/f13/tribal
	name = "tribal power helmet"
	desc = "This power armor helmet was salvaged by savages from the battlefield.<br>They believe that these helmets capture the spirits of their fallen wearers, so they painted some runes on to give it a more sacred meaning."
	icon_state = "tribal"
	inhand_icon_state = "tribal"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T2, ARMOR_MODIFIER_DOWN_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T2)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	strip_delay = 30
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/f13
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/rastacap
	name = "rastacap"
	desc = "<font color='#157206'>Him haffi drop him fork and run,</font><br><font color='green'>Him can't stand up to Jah Jah son,</font><br><font color='#fd680e'>Him haffi lef' ya with him gun,</font><br><font color='red'>Dig off with him bomb.</font>"
	icon_state = "rastacap"
	inhand_icon_state = "fedora"
	cold_protection = HEAD //This tam brings the warm reggae and Jamaican sun with it.
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/f13/hairband
	name = "hairband"
	desc = "Pretty yellow hairband"
	icon_state = "50shairband"
	inhand_icon_state = "50shairband"

/obj/item/clothing/head/f13/nursehat
	name = "nursehat"
	desc = "White cloth headdress for nurses"
	icon_state = "nursehat"
	inhand_icon_state = "nursehat"

/obj/item/clothing/head/f13/beaver
	name = "beaverkin"
	desc = "A hat made from felted beaver fur which makes the wearer feel both comfortable and elegant."
	icon_state = "beaver"
	inhand_icon_state = "that"

/obj/item/clothing/head/f13/purple
	name = "purple top hat"
	desc = "You may not own the best jail in the observed Universe, or the best chocolate factory in the entire world, but at least you can try to have that purple top hat."
	icon_state = "ptophat"
	inhand_icon_state = "that"

/obj/item/clothing/head/f13/trilby
	name = "feather trilby"
	desc = "A sharp, stylish blue hat with a feather."
	icon_state = "trilby"
	inhand_icon_state = "fedora"

/obj/item/clothing/head/f13/stormchaser
	name = "stormchaser hat"
	desc = "Home, home on the wastes,<br>Where the mole rat and the fire gecko play.<br>Where seldom is heard a discouraging word,<br>And my skin is not glowing all day."
	icon_state = "stormchaser"
	inhand_icon_state = "fedora"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/headscarf
	name = "headscarf"
	desc = "A piece of cloth worn on head for a variety of purposes, such as protection of the head or hair from rain, wind, dirt, cold, warmth, for sanitation, for fashion, recognition or social distinction - with religious significance, to hide baldness, out of modesty, or other forms of social convention."
	icon_state = "headscarf"
	inhand_icon_state = "dethat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/f13/headscarf/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/pot
	name = "metal cooking pot"
	desc = "Step one: Start with the sauce.<br>Step two: Add the noodles.<br>Step three: Stir the pasta.<br>Step four: Turn up the heat.<br>Step five: Burn the house."
	icon_state = "pot"
	inhand_icon_state = "fedora"
	force = 20
	hitsound = 'sound/items/trayhit1.ogg'
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/cowboy
	name = "cowboy hat"
	desc = "I've never seen so many men wasted so badly."
	icon_state = "cowboy"
	inhand_icon_state = "dethat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/cowboy/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/f13/bandit
	name = "bandit hat"
	desc = "A black cowboy hat with a large brim that's curved to the sides.<br>A silver eagle pin is attached to the front."
	icon_state = "bandit"
	inhand_icon_state = "fedora"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/bandit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/gambler
	name = "gambler hat"
	desc = "A perfect hat for a ramblin' gamblin' man." //But I got to ramble (ramblin' man) //Oh I got to gamble (gamblin' man) //Got to got to ramble (ramblin' man) //I was born a ramblin' gamblin' man
	icon_state = "gambler"
	inhand_icon_state = "dethat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/gambler/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/helmet/f13/motorcycle
	name = "motorcycle helmet"
	desc = "A type of helmet used by motorcycle riders.<br>The primary goal of a motorcycle helmet is motorcycle safety - to protect the rider's head during impact, thus preventing or reducing head injury and saving the rider's life."
	icon_state = "motorcycle"
	inhand_icon_state = "motorcycle"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEHAIR
	strip_delay = 10

/obj/item/clothing/head/helmet/f13/motorcycle/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/firefighter
	name = "firefighter helmet"
	desc = "A firefighter's helmet worn on top of a fire-retardant covering and broken gas mask.<br>It smells heavily of sweat."
	icon_state = "firefighter"
	inhand_icon_state = "firefighter"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
	strip_delay = 30
	resistance_flags = FIRE_PROOF

/obj/item/clothing/head/helmet/f13/vaquerohat
	name = "vaquero hat"
	desc = "An old sombrero worn by Vaqueros to keep off the harsh sun."
	icon_state = "vaquerohat"
	inhand_icon_state = "vaquerohat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/wastewarhat
	name = "warrior helmet"
	desc = "It might have been a cooking pot once, now its a helmet, with a piece of cloth covering the neck from the sun."
	icon = 'icons/fallout/clothing/helmets.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon_state = "wastewar"
	inhand_icon_state = "wastewar"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/wastewarhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/helmet/f13/hoodedmask
	name = "hooded mask"
	desc = "A gask mask with the addition of a hood."
	icon_state = "Hooded_Gas_Mask"
	inhand_icon_state = "Hooded_Gas_Mask"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/brahmincowboyhat
	name = "leather cowboy hat"
	desc = "A cowboy hat made from leather hides."
	icon_state = "brahmin_leather_cowboy_hat"
	inhand_icon_state = "brahmin_leather_cowboy_hat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/brahmincowboyhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/rustedcowboyhat
	name = "Rusted Cowboy Hat"
	desc = "A hat made from tanned leather hide."
	icon_state = "rusted_cowboy"
	inhand_icon_state = "rusted_cowboy"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/rustedcowboyhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/police
	name = "police hat"
	desc = "The wasteland's finest."
	icon_state = "retropolice"
	inhand_icon_state = "fedora"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/unberet
	name = "United Nations beret"
	desc = "A beret in the color and with a logo of the United Nations."
	icon_state = "unberet"
	inhand_icon_state = "unberet"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon = 'icons/fallout/clothing/hats.dmi'
	armor = ARMOR_VALUE_CLOTHES

/obj/item/clothing/head/f13/rusvdvberet
	name = "Russian VDV beret"
	desc = "A beret in the colors and fashion of the Russian VDV"
	icon_state = "rusvdv"
	inhand_icon_state = "rusvdv"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon = 'icons/fallout/clothing/hats.dmi'

/obj/item/clothing/head/simplekitty
	name = "kitty headband"
	desc = "A headband with a pair of cute kitty ears."
	icon_state = "kittyb"
	color = "#999999"
	dynamic_hair_suffix = ""

/obj/item/clothing/head/f13/riderw
	name = "Reinforced Rider Helmet" //Not raider. Rider. //Count up your sins
	desc = "It's a fancy two-tone metal helmet. It's been lined with additional plating and given a fresh coat of paint."
	icon_state = "riderw"
	inhand_icon_state = "riderw"

//Soft caps
/obj/item/clothing/head/soft/f13
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/soft/f13/baseball
	name = "baseball cap"
	desc = "A type of soft cap with a rounded crown and a stiff peak projecting out the front."
	icon_state = "baseballsoft"
	soft_type = "baseball"

/obj/item/clothing/head/soft/f13/utility
	name = "grey utility cover"
	desc = "An eight-pointed hat, with a visor similar to a baseball cap, known as utility cover, also called the utility cap or eight-pointed cover."
	icon_state = "utility_g"
	item_color = "utility_g"

/obj/item/clothing/head/soft/f13/utility/navy
	name = "navy utility cover"
	icon_state = "utility_n"
	item_color = "utility_n"

/obj/item/clothing/head/soft/f13/utility/olive
	name = "olive utility cover"
	icon_state = "utility_o"
	item_color = "utility_o"

/obj/item/clothing/head/soft/f13/utility/tan
	name = "tan utility cover"
	icon_state = "utility_t"
	item_color = "utility_t"

//DONOR, PATREON AND CUSTOM

/obj/item/clothing/head/donor/macarthur
	name = "Peaked Cap"
	desc = "A resistant, tan peaked cap, typically worn by Pre-Fall Generals."
	icon_state = "macarthur"
	inhand_icon_state = "macarthur"


/obj/item/clothing/head/helmet/f13/ncr/rangercombat/rigscustom
	name = "11th armored calvary helmet"
	desc = "An advanced combat helmet used by the 11th Armored Calvary Regiment before the war. There is a worn and faded 11th Armored Calvary Regiment's insignia just above the visor. The helmet itself has some scratches and dents sustained from battle."
	icon_state = "rigscustom_helmet"
	inhand_icon_state = "rigscustom_helmet"
	icon = 'icons/fallout/clothing/hats.dmi'

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/pricecustom
	name = "spider riot helmet"
	desc = "A customised riot helmet reminiscient of the more advanced riot helmets found in the Divide, sporting purple lenses over the traditional red or green and a pair of red fangs painted over the respirator. The back of the helmet has a the face of an albino spider painted over it."
	icon_state = "price_ranger"
	inhand_icon_state = "price_ranger"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom
	name = "reclaimed ranger-hunter combat helmet"
	desc = "A reclaimed Ranger-Hunter centurion helmet, carefully and lovingly restored to working condition with a sniper's veil wrapped around the neck. 'DE OPPRESSO LIBER' is stenciled on the front."
	icon_state = "foxranger"
	inhand_icon_state = "foxranger"
	actions_types = list(/datum/action/item_action/toggle)
	toggle_message = "You put the sniper's veil on"
	alt_toggle_message = "You take the sniper's veil off"
	can_toggle = 1
	toggle_cooldown = 0

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/degancustom
	name = "reclaimed ranger-hunter combat helmet"
	desc = "A reclaimed Ranger-Hunter centurion helmet, carefully and lovingly restored to working condition with a sniper's veil wrapped around the neck. 'DE OPPRESSO LIBER' is stenciled on the front."
	icon_state = "elite_riot"
	inhand_icon_state = "elite_riot"
	actions_types = list(/datum/action/item_action/toggle)
	toggle_message = "You put the sniper's veil on"
	alt_toggle_message = "You take the sniper's veil off"
	can_toggle = 1
	toggle_cooldown = 0

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/mosshelmet
	name = "veteran patrol stetson"
	desc = "A weathered campaign hat tightly fitted over the viscera of a ranger combat helmet. The old stetson is faded with age and heavy use, having seen the green shores of California to the white peaks of the rockies."
	icon_state = "mosshelmet"
	inhand_icon_state = "mosshelmet"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/helmet/f13/jasonmask
	name = "jasons mask"
	desc = "A metal mask made specifically for jason."
	icon_state = "jasonmask"
	inhand_icon_state = "jasonmask"

/obj/item/clothing/head/welding/f13/fire
	name = "cremator welding helmet"
	desc = "A welding helmet with flames painted on it.<br>It sure is creepy but also badass."
	icon_state = "welding_fire"
	inhand_icon_state = "welding"
	tint = 1

/obj/item/clothing/head/helmet/f13/atombeliever
	name = "believer headdress"
	desc = "The headwear of the true faith."
	icon_state = "atombeliever"
	inhand_icon_state = "atombeliever"
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/f13/flatranger
	name = "gambler ranger hat"
	desc = "A rustic, homely style gambler hat adorning an Texas Ranger patch. Yeehaw!"
	icon_state = "gamblerrang"
	inhand_icon_state = "gamblerrang"

/obj/item/clothing/head/helmet/f13/legion/venator/diohelmet
	name = "galerum lacertarex"
	desc = "The hide of a deadly green gecko affixed over a reinforced legion helmet. Its ghastly appearance serves as an intimidating gesture to those who do not yet fear the Lizard King."
	icon_state = "diohelmet"
	inhand_icon_state = "diohelmet"

/obj/item/clothing/head/helmet/f13/herbertranger
	name = "weathered desert ranger helmet"
	icon_state = "modified_usmc_riot"
	inhand_icon_state = "modified_usmc_riot"
	desc = "An ancient USMC riot helmet. This paticular piece retains the classic colouration of the legendary Desert Rangers, and looks as if it has been worn for decades; its night vision no longer seems to be functional. Scratched into the helmet is the sentence: 'Death to the Devils that simulate our freedom.'"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/marlowhat
	name = "boss of the plains hat"
	desc = "A thick undyed felt cowboy hat, bleached from excessive sun exposure and creased from heavy usage."
	icon_state = "marlowhat"
	inhand_icon_state = "marlowhat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/marlowhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/ranger_hat
	name = "grey cowboy hat"
	desc = "A simple grey cowboy hat."
	icon_state = "ranger_grey_hat"
	inhand_icon_state = "ranger_grey_hat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/ranger_hat/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/ranger_hat/banded
	name = "banded cowboy hat"
	desc = "A grey cowboy hat with a hat band decorated with brassen rings."
	icon = 'icons/mob/clothing/head.dmi'
	icon_state = "ranger_hat_grey_banded"
	inhand_icon_state = "ranger_hat_grey_banded"

/obj/item/clothing/head/f13/ranger_hat/tan
	name = "tan cowboy hat"
	desc = "A thick tanned leather hat, with a Montana Peak crease."
	icon_state = "ranger_tan_hat"
	inhand_icon_state = "ranger_tan_hat"

/obj/item/clothing/head/f13/chinahelmetcosmetic
	name = "dysfunctional chinese stealth helmet"
	desc = "A bright yellow visor in a timelessly infamous shape makes this helmet immediately recognizable. It's non-ballistic, and it's power unit for the HUD has been long since removed."
	icon_state = "stealthhelmet"
	inhand_icon_state = "stealthhelmet"

/obj/item/clothing/glasses/f13/tribaleyepatch
	name = "bandage eyepatch"
	desc = "A set of heavy bandages wrapped around the head. Made to protect the eye from whatever injury occured."
	icon_state = "eyepatch_white_r"
	inhand_icon_state = "eyepatch_white_r"

/obj/item/clothing/head/helmet/skull/bone
	name = "Reinforced skull helmet"
	desc = "An intimidating tribal helmet reinforced with leather and cloth parts on the inside for more comfort, while styling it on the Bone dancers way."
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES
	icon_state = "bone_dancer_helmet"
	inhand_icon_state = "bone_dancer_helmet"
	strip_delay = 100

/obj/item/clothing/head/helmet/f13/knighthelmet
	name = "red medieval helmet"
	desc = "A classic metal helmet worn by all ranks of knights and horsemen of the Old Era.<br>This one is painted red."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "knight_red"
	inhand_icon_state = "knight_red"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T3, ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/head/helmet/f13/ninja
	name = "ninja hood"
	desc = "What may appear to be a simple black garment is in fact a lightly padded helmet. Standard issue ninja gear."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "s-ninja"
	inhand_icon_state = "s-ninja_mask"
	flags_inv = HIDEEARS|HIDEHAIR|HIDEFACIALHAIR
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/head/hat/polis
	name = "police officer's hat"
	desc = "A decent durathread police hat, it's sturdy but won't stop anything too strong."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "police_officer"
	inhand_icon_state = "police_officer"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/head/hat/polislt
	name = "police lieutenant's hat"
	desc = "A decent durathread police hat, it's sturdy but won't stop anything too strong, this one has silver decorations."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "police_lieutenant"
	inhand_icon_state = "police_lieutenant"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)


/obj/item/clothing/head/hat/polischief
	name = "police chief's hat"
	desc = "A decent durathread police hat, it's sturdy but won't stop anything too strong, this one has gold decorations."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "police_chief"
	inhand_icon_state = "police_chief"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/head/hat/polissnr
	name = "police search and rescue hat"
	desc = "A decent durathread police hat, it's sturdy but won't stop anything too strong, this one has search and rescue insignia."
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "police_snr"
	inhand_icon_state = "police_snr"
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_DOWN_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T1, ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_DT_T1)
