/*FOR REFERENCE
/obj/item/clothing/suit/armor
	allowed = null
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	armor = list("tier" = 4, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)


/obj/item/clothing/suit/armor/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed
*/
//Leather and metal
/obj/item/clothing/suit/armor/f13/leather_jacket
	name = "leather jacket"
	icon_state = "leather_jacket"
	item_state = "leather_jacket"
	desc = "(II) A black, heavy leather jacket."
	armor = list("tier" = 2, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/armor/f13/leather_jacket/combat
	name = "combat leather jacket"
	icon_state = "combat_jacket"
	item_state = "combat_jacket"
	desc = "(III) This heavily padded leather jacket is unusual in that it has two sleeves. You'll definitely make a fashion statement whenever, and wherever, you rumble."
	armor = list("tier" = 3, "energy" = 20, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)

/obj/item/clothing/suit/armor/f13/leather_jacket/combat/coat
	name = "combat leather coat"
	icon_state = "combat_coat"
	item_state = "combat_coat"
	desc = "(IV) A combat leather jacket, outfitted with a special armored leather coat."
	armor = list("tier" = 4, "energy" = 35, "bomb" = 45, "bio" = 30, "rad" = 5, "fire" = 50, "acid" = 35)

/obj/item/clothing/suit/armor/f13/leather_jacket/combat/riotpolice
	name = "combat body armor"
	icon_state = "combat_coat"
	item_state = "combat_coat"
	desc = "(VII) A heavy armor with ballistic inserts, sewn into a padded riot police coat."
	armor = list("tier" = 7, "energy" = 25, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 35)

/obj/item/clothing/suit/armor/f13/kit
	name = "armor kit"
	desc = "(III) Separate armor parts you can wear over the clothing to get the most basic protection from the dangers of wasteland.<br>It is unable to reflect laser beams and probably won't shield you from a random bullet, but it sure is better than going into the battle without any armor at all."
	icon_state = "armorkit"
	item_state = "armorkit"
	armor = list("tier" = 3, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	strip_delay = 30

/obj/item/clothing/suit/armor/f13/kit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/punk
	name = "armor kit"
	desc = "(III) A couple of armor parts that can be worn over the clothing for moderate protection against the dangers of wasteland.<br>Do you feel lucky now? Well, do ya, punk?"
	icon_state = "punkit" //Punk it
	item_state = "punkit" //Pun kit
	armor = list("tier" = 3, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	strip_delay = 30
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/punk/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/leatherarmor
	name = "leather armor"
	desc = "(III) Your basic all leather apparel. Finely crafted from tanned brahmin hide."
	icon_state = "leather_armor"
	item_state = "leather_armor"
	armor = list("tier" = 3, "energy" = 25, "bomb" = 32, "bio" = 0, "rad" = 10, "fire" = 30, "acid" = 35)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/leatherarmor/reinforced
	name = "reinforced leather armor"
	icon_state = "leather_armor_2"
	item_state = "leather_armor_2"
	desc = "(IV) An enhanced version of the basic leather armor with extra layers of protection. Finely crafted from tanned brahmin hide."
	armor = list("tier" = 4, "energy" = 30, "bomb" = 35, "bio" = 0, "rad" = 15, "fire" = 40, "acid" = 35)

/obj/item/clothing/suit/armor/f13/metalarmor
	name = "metal armor"
	desc = "(IV) A set of plates formed together to form a crude chestplate."
	icon_state = "metal_chestplate"
	item_state = "metal_chestplate"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 40, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0)
	slowdown = 0.25
	strip_delay = 10

/obj/item/clothing/suit/armor/fluff/metalarmor/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/fluff/metalarmor/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/armor/f13/metalarmor/reinforced
	name = "reinforced metal armor"
	desc = "(V) A set of polished plates formed together to provide effective protection."
	icon_state = "metal_chestplate2"
	item_state = "metal_chestplate2"
	armor = list("tier" = 5, "energy" = 50, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	slowdown = 0.05
	strip_delay = 10

//Combat armor (Faction specific is on f13factionarmor.dm)
/obj/item/clothing/suit/armor/f13/combat
	name = "combat armor"
	desc = "(V) An old military grade pre war combat armor."
	icon_state = "combat_armor"
	item_state = "combat_armor"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/combat/dark
	name = "combat armor"
	desc = "An old military grade pre war combat armor. Now in dark, and extra-crispy!"
	color = "#514E4E"

/obj/item/clothing/suit/armor/f13/combat/Initialize()
	. = ..()
	AddComponent(/datum/component/spraycan_paintable)
	START_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/f13/combat/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/clothing/suit/armor/f13/combat/mk2
	name = "reinforced combat armor"
	desc = "(VI) A reinforced set of bracers, greaves, and torso plating of prewar design. This one is kitted with additional plates."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "combat_armor_mk2"
	item_state = "combat_armor_mk2"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/suit/armor/f13/combat/mk2/dark
	name = "reinforced combat armor"
	desc = "A reinforced model based of the pre-war combat armor. Now in dark, light, and smoky barbeque!"
	color = "#302E2E"

/obj/item/clothing/suit/armor/f13/combat/swat
	name = "SWAT combat armor"
	desc = "(V) A custom version of the pre-war combat armor, slimmed down and minimalist for domestic S.W.A.T. teams."
	icon_state = "armoralt"
	item_state = "armoralt"
	armor = list("tier" = 5, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/suit/armor/f13/combat/chinese
	name = "chinese combat armor"
	desc = "(IV) An uncommon suit of pre-war Chinese combat armor. It's a very basic and straightforward piece of armor that covers the front of the user."
	icon_state = "chicom_armor"
	item_state = "chicom_armor"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 60, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 10)

/obj/item/clothing/suit/armor/f13/combatrusted
	name = "rusted combat armor"
	desc = "(V) An old military grade pre war combat armor. This set has seen better days, weathered by time. The composite plates look sound and intact still."
	icon_state = "rusted_combat_armor"
	item_state = "rusted_combat_armor"
	armor = list("tier" = 5, "energy" = 38, "bomb" = 48, "bio" = 58, "rad" = 10, "fire" = 58, "acid" = 18)

/obj/item/clothing/suit/armor/f13/combat/environmental
	name = "environmental armor"
	desc = "(V) A pre-war suit developed for use in heavily contaminated environments, and is prized in the Wasteland for its ability to protect against biological threats."
	icon_state = "environmental_armor"
	item_state = "environmental_armor"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("tier" = 5,"energy" = 45, "bomb" = 55, "bio" = 70, "rad" = 100, "fire" = 60, "acid" = 50)
	strip_delay = 60
	equip_delay_other = 60
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/armor/f13/combat/environmental/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, FALSE)

//Power armors, including salvaged and faction

/obj/item/clothing/suit/armor/f13/power_armor
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 0.4 //+0.1 from helmet = total 0.5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEJUMPSUIT
	item_flags = SLOWS_WHILE_IN_HAND
	clothing_flags = THICKMATERIAL
	equip_delay_self = 50
	equip_delay_other = 60
	strip_delay = 200
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	var/emped = 0
	var/requires_training = TRUE
	var/armor_block_chance = 0 //Chance for the power armor to block a low penetration projectile
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/deflection_chance = 0 //Chance for the power armor to redirect a blocked projectile

/obj/item/clothing/suit/armor/f13/power_armor/mob_can_equip(mob/user, mob/equipper, slot, disable_warning = 1)
	var/mob/living/carbon/human/H = user
	if(src == H.wear_suit) //Suit is already equipped
		return ..()
	if (!HAS_TRAIT(H, TRAIT_PA_WEAR) && slot == SLOT_WEAR_SUIT && requires_training)
		to_chat(user, "<span class='warning'>You don't have the proper training to operate the power armor!</span>")
		return 0
	if(slot == SLOT_WEAR_SUIT)
		ADD_TRAIT(user, TRAIT_STUNIMMUNE,	"stun_immunity")
		ADD_TRAIT(user, TRAIT_PUSHIMMUNE,	"push_immunity")
		return ..()
	return

/obj/item/clothing/suit/armor/f13/power_armor/dropped(mob/user)
//	var/mob/living/carbon/human/H = user
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE,	"stun_immunity")
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE,	"push_immunity")
	return ..()

/obj/item/clothing/suit/armor/f13/power_armor/emp_act(mob/living/carbon/human/owner, severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(emped == 0)
		if(ismob(loc))
			to_chat(loc, "<span class='warning'>Warning: electromagnetic surge detected in armor. Rerouting power to emergency systems.</span>")
			slowdown += 30
			armor = armor.modifyRating(linemelee = -75, linebullet = -75, linelaser = -75)
			emped = 1
			spawn(50) //5 seconds of being slow and weak
				to_chat(loc, "<span class='warning'>Armor power reroute successful. All systems operational.</span>")
				slowdown -= 30
				armor = armor.modifyRating(linemelee = 75, linebullet = 75, linelaser = 75)
				emped = 0

/obj/item/clothing/suit/armor/f13/power_armor/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(check_armor_penetration(object) <= 0.15 && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(armor_block_chance))
			var/ratio = rand(0,100)
			if(ratio <= deflection_chance)
				block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
				return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
			if(ismob(loc))
				to_chat(loc, "<span class='warning'>Your power armor absorbs the projectile's impact!</span>")
			block_return[BLOCK_RETURN_SET_DAMAGE_TO] = 0
			return BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/f13/power_armor/t45b
	name = "salvaged T-45b power armor"
	desc = "(VIII) It's a set of early-model T-45 power armor with a custom air conditioning module and stripped out servomotors. Bulky and slow, but almost as good as the real thing."
	icon_state = "t45bpowerarmor"
	item_state = "t45bpowerarmor"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	requires_training = FALSE
	slowdown = 1.40
	armor_block_chance = 25
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not nearly as effective as true power armor


/obj/item/clothing/suit/armor/f13/power_armor/ncr
	name = "salvaged NCR power armor"
	desc = "(VIII) It's a set of T-45b power armor with a air conditioning module installed, it however lacks servomotors to enhance the users strength. This one has brown paint trimmed along the edge and a two headed bear painted onto the chestplate."
	icon_state = "ncrpowerarmor"
	item_state = "ncrpowerarmor"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	requires_training = FALSE
	slowdown = 1.40
	armor_block_chance = 25
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not nearly as effective as true power armor

/obj/item/clothing/suit/armor/f13/power_armor/raiderpa
	name = "raider T-45b power armor"
	desc = "(VIII) It's a set of T-45b power armor with some of its plating heavily reconditioned. This set has seen better days, metal scrap has been spot welded to the chassis "
	icon_state = "raiderpa"
	item_state = "raiderpa"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	slowdown = 0.4
	requires_training = FALSE
	armor_block_chance = 20
	deflection_chance = 5 //5% chance to block damage from blockable bullets and redirect the bullet at a random angle. Stripped down version of an already stripped down version

/obj/item/clothing/suit/armor/f13/power_armor/hotrod
	name = "hotrod T-45b power armor"
	desc = "(VIII) It's a set of T-45b power armor with a with some of its plating removed. This set has exhaust pipes piped to the pauldrons, flames erupting from them."
	icon_state = "t45hotrod"
	item_state = "t45hotrod"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0, "wound" = 40)
	slowdown = 0.4
	requires_training = FALSE
	armor_block_chance = 20
	deflection_chance = 5 //5% chance to block damage from blockable bullets and redirect the bullet at a random angle. Stripped down version of an already stripped down version

/obj/item/clothing/suit/armor/f13/power_armor/vaulttec
	name = "Vault-Tec power armour"
	desc = "(VIII)  A refined suit of power armour, purpose-built by the residents of Vault-115 in order to better keep the peace in their new settlement."
	icon_state = "vaultpa"
	item_state = "vaultpa"
	armor = list("tier" = 8, "energy" = 50, "bomb" = 48, "bio" = 60, "rad" = 50, "fire" = 80, "acid" = 0)
	slowdown = 0
	armor_block_chance = 40
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not a heavy combat model

/obj/item/clothing/suit/armor/f13/power_armor/vaulttecta
	name = "Vault-Tec technical armour"
	desc = "(VIII)  A primative  suit of power armour, the first kind built by the residents of Vault-115 in order to fight off immediate threats."
	icon_state = "vaultta"
	item_state = "vaultta"
	armor = list("tier" = 8, "energy" = 30, "bomb" = 38, "bio" = 40, "rad" = 20, "fire" = 100, "acid" = 0)
	slowdown = 0.4

/obj/item/clothing/suit/armor/f13/power_armor/excavator
	name = "excavator power armor"
	desc = "(VIII) Developed by Garrahan Mining Co. in collaboration with West Tek, the Excavator-class power armor was designed to protect miners from rockfalls and airborne contaminants while increasing the speed at which they could work. "
	icon_state = "excavator"
	item_state = "excavator"
	slowdown = 0.5 //+0.1 from helmet
	armor = list("tier" = 8, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0)
	armor_block_chance = 40
	deflection_chance = 10 //10% chance to block damage from blockable bullets and redirect the bullet at a random angle. Not a heavy combat model

/obj/item/clothing/suit/armor/f13/power_armor/t45d
	name = "T-45d power armor"
	desc = "(IX) Originally developed and manufactured for the United States Army by American defense contractor West Tek, the T-45d power armor was the first version of power armor to be successfully deployed in battle."
	icon_state = "t45dpowerarmor"
	item_state = "t45dpowerarmor"
	slowdown = 0.24
	armor = list("tier" = 9, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0, "wound" = 60)
	armor_block_chance = 80
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle

/obj/item/clothing/suit/armor/f13/power_armor/t45d/gunslinger
	name = "Gunslinger T-51b"
	desc = "(IX) What was once a suit of T-51 Power Armor is now an almost unrecognizable piece of art or garbage, depending on who you ask. Almost all of the external plating has either been removed or stripped to allow for maximum mobility, and overlapping underplates protect the user from small arms fire. Whoever designed this had a very specific purpose in mind: mobility and aesthetics over defense."
	icon_state = "t51bgs"
	item_state = "t51bgs"
	slowdown = 0
	flags_inv = HIDEJUMPSUIT|HIDENECK

/obj/item/clothing/suit/armor/f13/power_armor/t45d/sierra
	name = "sierra power armor"
	desc = "(IX) A captured set of T-45d power armor put into use by the NCR, it's been heavily modified and decorated with the head of a bear and intricate gold trimming. A two headed bear is scorched into the breastplate."
	icon_state = "sierra"
	item_state = "sierra"

/obj/item/clothing/suit/armor/f13/power_armor/t45d/knightcaptain
	name = "Knight-Captain's T-45d Power Armour"
	desc = "(IX) A classic set of T-45d Power Armour only to be used in armed combat, it signifies the Knight Captain and their place in the Brotherhood. A leader, and a beacon of structure in a place where chaos reigns. All must rally to his call, for he is the Knight Captain and your safety is his duty."
	icon_state = "t45dkc"
	item_state = "t45dkc"
	slowdown = 0.16
	armor = list("tier" = 9, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0, "wound" = 60)

/obj/item/clothing/suit/armor/f13/power_armor/midwest
	name = "midwestern power armor"
	desc = "(IX) This set of power armor once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here."
	icon_state = "midwestgrey_pa"
	item_state = "midwestgrey_pa"
	armor = list("tier" = 9, "energy" = 60, "bomb" = 62, "bio" = 100, "rad" = 90, "fire" = 90, "acid" = 0, "wound" = 60)

	armor_block_chance = 80
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle

/obj/item/clothing/suit/armor/f13/power_armor/t51b
	name = "T-51b power armor"
	desc = "(X) The pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer."
	icon_state = "t51bpowerarmor"
	item_state = "t51bpowerarmor"
	slowdown = 0.15 //+0.1 from helmet = total 0.25
	armor_block_chance = 85
	deflection_chance = 35 //35% chance to block damage from blockable bullets and redirect the bullet at a random angle. Less overall armor compared to T-60, but higher deflection.
	armor = list("tier" = 10, "energy" = 65, "bomb" = 62, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 0, "wound" = 70)

/obj/item/clothing/suit/armor/f13/power_armor/t51b/tesla
	name = "T-51b tesla armor"
	desc = "(X) The pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer, with the added benefit of tesla coils."
	icon_state = "t51tesla"
	item_state = "t51tesla"
	slowdown = 0.15 //+0.1 from helmet = total 0.25
	armor = list("tier" = 10, "energy" = 70, "bomb" = 62, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 0, "wound" = 70)

/obj/item/clothing/suit/armor/f13/power_armor/t51b/wbos
	name = "Washington power armor"
	desc = "(X) A dark mirror to the pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer."
	icon_state = "t51wbos"
	item_state = "t51wbos"

/obj/item/clothing/suit/armor/f13/power_armor/t51b/reforgedwbos
	name = "reforged Washington power armor"
	desc = "(X) A dark mirror to the pinnacle of pre-war technology, reforged. This suit of power armor provides substantial protection to the wearer."
	icon_state = "t51matt"
	item_state = "t51matt"

/obj/item/clothing/suit/armor/f13/power_armor/t51b/ultra
	name = "Ultracite power armor"
	desc = "(X) The pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer. Now ultracite enhanced."
	icon_state = "ultracitepa"
	item_state = "ultracitepa"
	slowdown = 0

/obj/item/clothing/suit/armor/f13/power_armor/t60
	name = "T-60a power armor"
	desc = "(XI) Developed in early 2077 after the Anchorage Reclamation, the T-60 series of power armor was designed to eventually replace the T-51b as the pinnacle of powered armor technology in the U.S. military arsenal."
	icon_state = "t60powerarmor"
	item_state = "t60powerarmor"
	slowdown = 0.16
	armor = list("tier" = 11, "energy" = 70, "bomb" = 82, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 0, "wound" = 80)

	armor_block_chance = 90
	deflection_chance = 20 //20% chance to block damage from blockable bullets and redirect the bullet at a random angle. Same deflection as T-45 due to it having the same general shape.

/obj/item/clothing/suit/armor/f13/power_armor/t60/tesla
	name = "T-60b tesla armor"
	desc = "(X*) An experimental variant of T-60a power armor featuring an array of tesla coils. A small amount of protection has been sacrificed to give a chance to deflect energy projectiles."
	icon_state = "t60tesla"
	item_state = "t60tesla"
	slowdown = 0.15
	armor = list("tier" = 10, "linelaser" = 25, "energy" = 70, "bomb" = 82, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 0, "wound" = 80)
	var/hit_reflect_chance = 20

/obj/item/clothing/suit/armor/f13/power_armor/t60/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/f13/power_armor/advanced
	name = "advanced power armor"
	desc = "An advanced suit of armor typically used by the Enclave.<br>It is composed of lightweight metal alloys, reinforced with ceramic castings at key stress points.<br>Additionally, like the T-51b power armor, it includes a recycling system that can convert human waste into drinkable water, and an air conditioning system for its user's comfort."
	icon_state = "advpowerarmor1"
	item_state = "advpowerarmor1"
	armor = list("linemelee" = 300, "linebullet" = 300, "linelaser" = 300, "energy" = 75, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 90)

	armor_block_chance = 100 //Enclave. 'nuff said
	deflection_chance = 40 //40% chance to block damage from blockable bullets and redirect the bullet at a random angle. Your ride's over mutie, time to die.

/obj/item/clothing/suit/armor/f13/power_armor/advanced/mk2
	name = "advanced power armor mark II"
	desc = "It's an improved model of advanced power armor used exclusively by the Enclave military forces, developed after the Great War.<br>Like its older brother, the standard advanced power armor, it's matte black with a menacing appearance, but with a few significant differences - it appears to be composed entirely of lightweight ceramic composites rather than the usual combination of metal and ceramic plates.<br>Additionally, like the T-51b power armor, it includes a recycling system that can convert human waste into drinkable water, and an air conditioning system for its user's comfort."
	icon_state = "advpowerarmor2"
	item_state = "advpowerarmor2"
	armor = list("linemelee" = 400, "linebullet" = 400, "linelaser" = 400, "energy" = 90, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 100)

/obj/item/clothing/suit/armor/f13/power_armor/advanced/mk2/wbos
	name = "advanced Washington power armor"
	desc = "It's an improved model of the power armor used exclusively by the Washington Brotherhood."
	icon_state = "apawbos"
	item_state = "apawbos"

/obj/item/clothing/suit/armor/f13/power_armor/tesla
	name = "tesla power armor"
	desc = "A variant of the Enclave's advanced power armor Mk I, jury-rigged with a Tesla device that is capable of dispersing a large percentage of the damage done by directed-energy attacks.<br>As it's made of complex composite materials designed to block most of energy damage - it's notably weaker against kinetic impacts."
	icon_state = "tesla"
	item_state = "tesla"
	armor = list("linemelee" = 200, "linebullet" = 200, "linelaser" = 300, "energy" = 95, "bomb" = 62, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 80)
	var/hit_reflect_chance = 35

/obj/item/clothing/suit/armor/f13/power_armor/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

//Generic Tribal - For Wayfarer specific, see f13factionhead.dm
/obj/item/clothing/suit/armor/f13/tribal
	name = "tribal armor"
	desc = "(IV) A set of armor made of gecko hides.<br>It's pretty good for makeshift armor."
	icon_state = "tribal"
	item_state = "tribal"
	armor = list("tier" = 4, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/chitinarmor
	name = "insect chitin armor"
	desc = "(IV) A set of light armor made of insect chitin. Tough and light, it provides some moderate protection from trauma while allowing the user to remain mobile and protected from the elements."
	icon_state = "insect_armor"
	item_state = "insect_armor"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40

//Various

/obj/item/clothing/suit/armor/tesla //changed from armor/laserproof
	name = "tesla armor"
	desc = "(V) A prewar armor design by Nikola Tesla before being confinscated by the U.S. government. Has a chance to deflect energy projectiles."
	icon_state = "tesla_armor"
	item_state = "tesla_armor"
	blood_overlay_type = "armor"
	armor = list("tier" = 5, "energy" = 60, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	resistance_flags = FIRE_PROOF
	var/hit_reflect_chance = 20
	var/list/protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/obj/item/clothing/suit/armor/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/f13/sulphitearmor
	name = "sulphite armor"
	desc = "(VI) A combination of what seems to be raider metal armor with a jerry-rigged flame-exhaust system and ceramic plating."
	icon_state = "sulphitearmor"
	item_state = "sulphitearmor"
	armor = list("tier" = 6, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/toggle/armor
	body_parts_covered = CHEST|GROIN
	cold_protection = CHEST|GROIN
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	strip_delay = 60
	equip_delay_other = 40
	max_integrity = 250
	resistance_flags = NONE
	armor = list("tier" = 2, "energy" = 16, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	togglename = "collar"

/obj/item/clothing/suit/armor/f13/vaquero
	name = "vaquero suit"
	desc = "(III) An ornate suit worn by Mexican gunfighters in the Old West, padded with leather for extra protection."
	icon_state = "vaquero"
	item_state = "vaquero"
	armor = list("tier" = 3, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/armor/f13/slam
	name = "slammer raider armor"
	desc = "(IV) Crude armor that appears to employ a tire of some kind as the shoulder pad. What appears to be a quilt is tied around the waist.<br>Come on and slam and turn your foes to jam!"
	icon_state = "slam"
	item_state = "slam"
	armor = list("tier" = 4, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/battlecoat //Maxson's battlecoat from Fallout 4
	name = "battlecoat"
	desc = "(III) A heavy padded leather coat, worn by pre-War bomber pilots in the past and post-War zeppelin pilots in the future."
	icon_state = "battlecoat"
	item_state = "battlecoat"
	armor = list("tier" = 3, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 30, "fire" = 30, "acid" = 30)
	strip_delay = 30
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/battlecoat/vault
	name = "command coat"
	desc = "(III) A heavy pre-war bomber coat, dyed blue with the number '113' embroidered on the back. Most often worn by leaders, such as the Overseer."
	icon_state = "vault_commandcoat"
	item_state = "vault_commandcoat"
	armor = list("tier" = 3)

/obj/item/clothing/suit/armor/f13/battlecoat/tan
	name = "tan battlecoat"
	desc = "(III) A heavy padded leather coat, worn by pre-War bomber pilots in the past and post-War zeppelin pilots in the future. This one's colors have faded somewhat."
	icon_state = "battlecoat_tan"
	item_state = "maxson_battlecoat"

/obj/item/clothing/suit/armor/f13/brahmin_leather_duster
	name = "brahmin leather duster"
	desc = "(III) A duster fashioned with tanned brahmin hide. It appears to be more durable than a normal duster. The leather is laser resistant."
	icon_state = "brahmin_leather_duster"
	item_state = "brahmin_leather_duster"
	armor = list("tier" = 3, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

/obj/item/clothing/suit/armor/f13/rustedcowboy
	name = "rusted cowboy outfit"
	desc = "(III) A weather treated leather cowboy outfit.  Yeehaw Pard'!"
	icon_state = "rusted_cowboy"
	item_state = "rusted_cowboy"
	armor = list("tier" = 3, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

//Inherited from SS13
/obj/item/clothing/suit/armor/bulletproof
	name = "bulletproof armor"
	desc = "(IV*) A Type III heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "bulletproof"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list("tier" = 4, "linebullet" = 50, "energy" = 35, "bomb" = 55, "bio" = 0, "rad" = 0, "fire" = 55, "acid" = 55)
	strip_delay = 70
	equip_delay_other = 50
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/armor/bone
	name = "bone armor"
	desc = "(III) A tribal armor plate, crafted from animal bone."
	icon_state = "bonearmor"
	item_state = "bonearmor"
	blood_overlay_type = "armor"
	armor = list("tier" = 3, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

//Custom/Patreon/Donor - A lot of this likely needs putting in the graveyard
/obj/item/clothing/suit/armor/f13/power_armor/midwest/reinforced // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	name = "hardened midwestern power armor" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	icon_state = "midwestpa" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	item_state = "midwestpa" // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.
	desc = "This set of power armor once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here. This particular one has gone through a chemical hardening process, increasing its armor capabilities." // PATREON SUPPORTER CUSTOM GEAR, DO NOT USE.

obj/item/clothing/suit/armor/f13/exile/cust0m
	name = "Lorica Iudicis"
	desc = "A set of well maintained though still quite clearly worn armor consisting of a metal vest, a Centurion's shoulder pad, a pair of Centurion's arm guards and an incredibly large, perhaps even over-sized fur cloak. Upon basic examination, one can see that every piece of metal bar the buckles on the leather straps and whatever scratches and blemishes are yet to be retouched is masterfully decorated with silver, in complete contrast to the blackness of the cloak. Though only upon closer examination can the intricacies of the armor set be observed. The most obvious piece is the metal vest which has clearly been engraved, mostly decorationally besides the name 'Iudex Flammae' near the top. Though the engravings provide no tactical advantage whatsoever, the sharp geometric shapes accompanied by smooth, tastefully placed curves would catch the eye of even the most skeptical engraving enjoyer. As for the shoulder pad and arm guards, they hold the same engravings, and though they are recognizable as salvage, they still look incredibly beautiful yet simultaneously sturdy. Not much of the metal seems to exist on the back though that is only due to the fact that the incredibly thick, durable and flexible bear pelt that covers it would definitely provide ample protection. The pelt itself is absolutely covered in thick, almost jet black fur. One can tell from touch that the skin underneath is about as sturdy as skin gets. The pelt hangs across the wearer's back, held up by the neck and shoulders. This armor was competently made, and it shows."
	icon_state = "exilecust0m"
	item_state = "exilecust0m"
	var/adjusted = FALSE

/obj/item/clothing/suit/armor/f13/exile/cust0m/verb/armor_adjust()
	set name = "Adjust Armor"
	set category = null
	set src in usr

	if(!adjusted)
		adjusted = TRUE
		icon_state = "exilecust0m_d"
	else
		adjusted = FALSE
		icon_state = "exilecust0m"

	if(ishuman(usr))
		var/mob/living/carbon/human/H = usr
		H.update_inv_w_uniform()
		H.update_body()

/obj/item/clothing/suit/armor/f13/exile/cust0m/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/harpercoat
	name = "outlaw coat"
	desc = "(IV) A combat duster"
	icon_state = "harperduster"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 35, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/raider/reptiliatenebris
	name = "Reptilia Tenebris"
	desc = "An old military-grade pre-war combat armor under a weathered duster. It appears to be fitted with metal plates to replace the crumbling ceramic. The color of this duster has been washed out time and time again, giving it a more faded look as if time gripped it heavily. Along with that, the duster has been dyed a deep shade of grey, and the body armor a darker shade of green."
	icon_state = "reptiliatenebris"
	item_state = "reptiliatenebris"

/obj/item/clothing/suit/armor/f13/raider/reptiliatenebris/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/shankduster
	name = "follower's duster"
	desc = "An old military-grade pre-war combat armor under a white weathered duster. An emblem of the Followers is painted on the back of it. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "shank_follower"
	item_state = "shank_follower"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("tier" = 4, "energy" = 35, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/shankduster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/toggle/armor/f13/rangercustomdark
	name = "tattered recon duster"
	desc = "(III) A thicker than average duster worn by rangers out in the field. This one has been dyed black and appears to be a little more heavily armoured."
	icon_state = "duster_recon_custom"
	item_state = "duster_recon_custom"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	slowdown = -0.1

/obj/item/clothing/suit/armor/f13/legion/palacent/custom_excess
	name = "Champion of Kanab's Armor"
	desc = "The armor of the Champion and Conqueror of the city in Utah named Kanab. The armor is made up of pieces of Power Armor and pre-war Riot Gear, the shin guards are spraypainted a dark crimson and the Power Armour pauldron has a red trim. The symbol of a Pheonix is carefully engraved and painted upon the chest piece... I wonder what it means.."
	icon_state = "palacent_excess"
	item_state = "palacent_excess"

/obj/item/clothing/suit/donor/soldier
	name = "Soldier's Greatcoat"
	desc = "(III) A resistant, tan greatcoat, typically worn by pre-War Generals."
	icon_state = "soldier"
	item_state = "soldier"
	armor = list("tier" = 3, "energy" = 30, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/armor/f13/rangercombat/foxcustom
	name = "sniper riot gear"
	desc = "A customized and well-worn suit of riot gear with parts of the suit reinforced with leather armor and slain Centurion armor pieces by the wearer. A sniper's veil is wrapped around the neck."
	icon_state = "foxranger"
	item_state = "foxranger"

/obj/item/clothing/suit/armor/f13/rangercombat/rigscustom
	name = "11th armored calvary armor"
	desc = "A suit of special military grade riot control gear and a duster, worn by 11th Armored Calvary Regiment members in The Divide before the war. Yellow markings are painted on the shoulderpads and forearm guards."
	icon_state = "rigscustom_suit"
	item_state = "rigscustom_suit"

/obj/item/clothing/suit/toggle/armor/f13/cloakranger //Reskinned trail ranger gear
	name = "ranger poncho"
	desc = "(IV) A durable muslin poncho. Tough enough to bear the elements and serve as handy blanket."
	icon_state = "ranger_cloak"
	item_state = "ranger_cloak"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0) //Same armor as trail ranger gear
	slowdown = -0.14 //Same speed buff as trail ranger gear

/obj/item/clothing/suit/armor/f13/herbertranger //Armor wise, it's reskinned raider armor.
	name = "weathered desert ranger armor"
	desc = "(IV) A set of pre-unification desert ranger armor, made using parts of what was once USMC riot armor. It looks as if it has been worn for decades; the coat has become discoloured from years under the Mojave sun and has multiple tears and bullet holes in its leather. The armor plating itself seems to be in relatively good shape, though it could do with some maintenance."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	icon_state = "usmc_riot_gear"
	item_state = "usmc_riot_gear"
	armor = list("tier" = 4, "energy" = 35, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/herbertranger/Initialize() //HQ parts reinforcement, just like raider gear
	. = ..()
	AddComponent(/datum/component/armor_plate)

//THE GRAVEYARD
//UNUSED or LEGACY - RETAINED IN CASE DESIRED FOR ADMIN SPAWN OR REIMPLEMENATION. MAY NOT BE EVERYTHING THAT'S UNUSED. TEST BEFORE USING
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/obj/item/clothing/suit/armor/warriors
	name = "warriors armored vest"
	desc = "The symbol of the greatest gangers."
	icon_state = "warriors"
	item_state = "warriors"

/obj/item/clothing/suit/armor/f13/atomzealot
	name = "zealot armor"
	desc = "(IV) The armor of those true to the Division."
	icon_state = "atomzealot"
	item_state = "atomzealot"
	armor = list("tier" = 4, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 100, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/atomwitch
	name = "atomic seer robes"
	desc = "(II) The robes worn by female seers of the Division."
	icon_state = "atomwitch"
	item_state = "atomwitch"
	armor = list("tier" = 2, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 100, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/harbingermantle
	name = "Harbinger's Mantle"
	desc = "(VII) An eerie, silken cloth that seems to be dripping with a thick mist. It is in truth a high-tech stealth device that allows for psionic amplification. The capacitors and manipulators in it utilise quantum technology and are highly volatile."
	icon_state = "scloak"
	item_state = "scloak"
	armor = list("tier" = 7, "energy" = 55, "bomb" = 45, "bio" = 45, "rad" = 45, "fire" = 45, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ghostechoe
	name = "tattered peace coat"
	desc = "(II) An old coat belonging to a Desert Ranger once. It has been stripped of most useful protection, and has seen better days. A crude peace symbol has been painted on the back in white."
	icon_state = "ghostechoe"
	item_state = "ghostechoe"
	armor = list("tier" = 2, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/f13/cyberpunk
	name = "armored trenchcoat"
	desc = "A trenchcoat augmented with a special alloy for some protection and style."
	icon_state = "jensencoat"
	item_state = "jensencoat"
	armor = list("tier" = 3, "energy" = 10, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	resistance_flags = UNACIDABLE
	strip_delay = 30
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/doom
	name = "green chestplate"
	desc = "(V) An odd green chestplate.<br>It's lightweight and strangely comfortable."
	icon_state = "praetor"
	item_state = "g_suit"
	armor = list("tier" = 5, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	resistance_flags = UNACIDABLE
	strip_delay = 10
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/scoutarmor
	name = "light scout armor"
	desc = "(VI) A prewar design for lightweight, battle-ready armor designed to be easily used in the field or in reconnaissance situations where mobility is required."
	icon_state = "scout_armor_lt"
	item_state = "scout_armor_lt"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/reconarmor
	name = "recon armor"
	desc = "(VI) An old military grade pre war combat armor. It's well-fitted for good all-around protection."
	icon_state = "recon_armor"
	item_state = "recon_armor"
	armor = list("tier" = 6, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	icon = 'icons/fallout/clothing/suits.dmi'
