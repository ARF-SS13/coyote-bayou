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
	armor = list("tier" = 4, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 25)


/obj/item/clothing/suit/armor/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.security_vest_allowed
*/

// Temporal fix until digitigrade-adapted sprites are done
/obj/item/clothing/suit/armor/f13
	mutantrace_variation = NONE

//Leather and metal
/obj/item/clothing/suit/armor/f13/leather_jacket
	name = "leather jacket"
	icon_state = "leather_jacket"
	item_state = "leather_jacket"
	desc = "A black, heavy leather jacket. Looks like it has spare pockets."
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 25)
	slowdown = 0.025 //token slowdown
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/armor/f13/leather_jacket/combat
	name = "combat leather jacket"
	icon_state = "combat_jacket"
	item_state = "combat_jacket"
	desc = "This heavily padded leather jacket is unusual in that it has two sleeves and bullet belts draped across it. You'll definitely make a fashion statement whenever, and wherever, you rumble."
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20, "energy" = 15, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25, "wound" = 30)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt

/obj/item/clothing/suit/armor/f13/leather_jacket/combat/coat
	name = "combat leather coat"
	icon_state = "combat_coat"
	item_state = "combat_coat"
	desc = "A combat leather jacket, outfitted with a special armored leather coat."
	armor = list("melee" = 35, "bullet" = 22, "laser" = 22, "energy" = 15, "bomb" = 45, "bio" = 30, "rad" = 5, "fire" = 50, "acid" = 35, "wound" = 35)


/obj/item/clothing/suit/armor/f13/kit
	name = "armor kit"
	desc = "Separate armor parts you can wear over the clothing to get the most basic protection from the dangers of wasteland.<br>It sure is better than going into the battle without any armor at all."
	icon_state = "armorkit"
	item_state = "armorkit"
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 30)
	strip_delay = 30
	slowdown = 0.025

/obj/item/clothing/suit/armor/f13/kit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/punk
	name = "armor kit"
	desc = "A couple of armor parts that can be worn over the clothing for moderate protection against the dangers of wasteland.<br>Do you feel lucky now? Well, do ya, punk?"
	icon_state = "armorkit_punk"
	item_state = "armorkit_punk"
	armor = list("melee" = 20, "bullet" = 40, "laser" = 15, "energy" = 15, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 30)
	strip_delay = 30
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	slowdown = 0.025

/obj/item/clothing/suit/armor/f13/punk/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/plates
	name = "light armor plates"
	desc = "Well-made metal plates covering your vital organs."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "light_plates"
	item_state = "armorkit"
	armor = list("melee" = 33, "bullet" = 33, "laser" = 40, "energy" = 15, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	slowdown = 0.08

/obj/item/clothing/suit/armor/f13/leatherarmor
	name = "leather armor"
	desc = "Your basic all leather apparel. Finely crafted from tanned brahmin hide."
	icon_state = "leather_armor"
	item_state = "leather_armor"
	armor = list("melee" = 35, "bullet" = 20, "laser" = 35, "energy" = 25, "bomb" = 32, "bio" = 0, "rad" = 10, "fire" = 30, "acid" = 35, "wound" = 30)
	strip_delay = 40
	slowdown = 0.06

/obj/item/clothing/suit/armor/f13/leatherarmor/reinforced
	name = "reinforced leather armor"
	icon_state = "leather_armor_2"
	item_state = "leather_armor_2"
	desc = "An enhanced version of the basic leather armor with extra layers of protection. Finely crafted from tanned brahmin hide."
	armor = list("melee" = 37, "bullet" = 22, "laser" = 37, "energy" = 27, "bomb" = 35, "bio" = 0, "rad" = 15, "fire" = 40, "acid" = 35, "wound" = 35)
	slowdown = 0.08


/obj/item/clothing/suit/armor/f13/metalarmor
	name = "metal armor"
	desc = "A set of plates formed together to form a crude chestplate."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "metal_chestplate"
	item_state = "metal_chestplate"
	armor = list("melee" = 40, "bullet" = 45, "laser" = 50, "energy" = 15, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0, "wound" = 45)
	slowdown = 0.22
	strip_delay = 10

/obj/item/clothing/suit/armor/f13/metalarmor/laserproof
	name = "polished metal armor"
	desc = "A set of plates formed together to form a crude chestplate. These have been waxed and buffed to a mirror finish, but it looks a bit thinner."
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'
	icon_state = "armor_enclave_peacekeeper"
	item_state = "armor_enclave_peacekeeper"
	armor = list("melee" = 38, "bullet" = 38, "laser" = 72, "energy" = 25, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0, "wound" = 45)
	slowdown = 0.2
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
	desc = "A set of well-fitted plates formed together to provide effective protection."
	icon_state = "metal_chestplate2"
	item_state = "metal_chestplate2"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 55, "energy" = 15, "bomb" = 45, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 50)
	slowdown = 0.25
	strip_delay = 10

/obj/item/clothing/suit/armor/f13/metalarmor/steelbib
	name = "steel breastplate"
	desc = "a steel breastplate, inspired by a pre-war design. It provides some protection against impacts, cuts, and medium-velocity bullets."
	icon_state = "steel_bib"
	item_state = "steel_bib"
	armor = list("melee" = 20, "bullet" = 45, "laser" = 50, "energy" = 15, "bomb" = 20, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0, "wound" = 40)
	slowdown = 0.06
	strip_delay = 5

//Combat armor (Faction specific is on f13factionarmor.dm)
/obj/item/clothing/suit/armor/f13/combat
	name = "combat armor"
	desc = "An old military grade pre war combat armor."
	icon_state = "combat_armor"
	item_state = "combat_armor"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)
	slowdown = 0.12

/obj/item/clothing/suit/armor/f13/combat/laserproof
	name = "ablative combat armor"
	desc = "An old military grade pre war combat armor. This one switches out its ballistic fibers for an ablative coating that disrupts energy weapons."
	armor = list("melee" = 35, "bullet" = 35, "laser" = 60, "energy" = 50, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)

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

// Shredding combat armor a direct action. Use a saw.
/obj/item/clothing/suit/armor/f13/combat/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SAW)
		user.visible_message("[user] begins recycling the [src] into armor plates.", \
				"<span class='notice'>You begin recycling the [src] into armor plates.</span>", \
				"<span class='italics'>You hear the noise of a saw cutting through metal and ceramic.</span>")
		playsound(get_turf(src), 'sound/weapons/circsawhit.ogg', 50, TRUE)
		if(!do_after(user, 50, TRUE, src))
			return
		new /obj/item/stack/crafting/armor_plate/ (drop_location(), 4)
		qdel(src)
		to_chat(user, "<span class='notice'>You salvage armor plates from the [src].</span>")
	else
		return ..()

/obj/item/clothing/suit/armor/f13/combat/riotpolice
	name = "combat body armor"
	icon_state = "combat_coat"
	item_state = "combat_coat"
	desc = "A heavy armor with ballistic inserts, sewn into a padded riot police coat."
	armor = list("melee" = 45, "bullet" = 45, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 35, "wound" = 45)
	slowdown = 0.15

/obj/item/clothing/suit/armor/f13/combat/mk2
	name = "reinforced combat armor"
	desc = "A reinforced set of bracers, greaves, and torso plating of prewar design. This one is kitted with additional plates."
	icon = 'icons/obj/clothing/suits.dmi'
	icon_state = "combat_armor_mk2"
	item_state = "combat_armor_mk2"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 22, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 55)
	slowdown = 0.15

/obj/item/clothing/suit/armor/f13/combat/mk2/dark
	name = "reinforced combat armor"
	desc = "A reinforced model based of the pre-war combat armor. Now in dark, light, and smoky barbeque!"
	color = "#302E2E"

/obj/item/clothing/suit/armor/f13/combat/swat
	name = "SWAT combat armor"
	desc = "A custom version of the pre-war combat armor, slimmed down and minimalist for domestic S.W.A.T. teams."
	icon_state = "armoralt"
	item_state = "armoralt"
	armor = list("melee" = 30, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30, "wound" = 55)

/obj/item/clothing/suit/armor/f13/combat/chinese
	name = "chinese combat armor"
	desc = "(An uncommon suit of pre-war Chinese combat armor. It's a very basic and straightforward piece of armor that covers the front of the user."
	icon_state = "chicom_armor"
	item_state = "chicom_armor"

/obj/item/clothing/suit/armor/f13/combatrusted
	name = "rusted combat armor"
	desc = "An old military grade pre war combat armor. This set has seen better days, weathered by time. The composite plates look sound and intact still."
	icon_state = "rusted_combat_armor"
	item_state = "rusted_combat_armor"
	armor = list("melee" = 38, "bullet" = 45, "laser" = 38, "energy" = 18, "bomb" = 45, "bio" = 55, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 45)
	slowdown = 0.12

/obj/item/clothing/suit/armor/f13/combat/environmental
	name = "environmental armor"
	desc = "A pre-war suit developed for use in heavily contaminated environments, and is prized in the Wasteland for its ability to protect against biological threats."
	icon_state = "environmental_armor"
	item_state = "environmental_armor"
	w_class = WEIGHT_CLASS_BULKY
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.5
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 35, "bullet" = 40, "laser" = 40,"energy" = 20, "bomb" = 55, "bio" = 70, "rad" = 100, "fire" = 60, "acid" = 50)
	strip_delay = 60
	equip_delay_other = 60
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/armor/f13/combat/environmental/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/rad_insulation, RAD_NO_INSULATION, TRUE, FALSE)

/obj/item/clothing/suit/armor/f13/combat/mk2/raider
	name = "raider combat armor"
	desc = "An old set of reinforced combat armor with some parts supplanted with painspike armor. It seems less protective than a mint-condition set of combat armor."
	armor = list("melee" = 35, "bullet" = 40, "laser" = 40, "energy" = 35, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 45)
	slowdown = 0.05
	item_state = "combat_armor_raider"

/////////////////
// Power armor //
/////////////////

/obj/item/clothing/suit/armor/f13/power_armor
	w_class = WEIGHT_CLASS_HUGE
	slowdown = 0.3 //+0.1 from helmet = total 0.4
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
	/// Cell that is currently installed in the suit
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell/high
	/// How much power the cell consumes each process tick
	var/usage_cost = 5 // With high-capacity cell it'd run out of charge in ~33 minutes
	/// If TRUE - suit has ran out of charge and is currently affected by slowdown from it
	var/no_power = FALSE
	/// How much slowdown is added when suit is unpowered
	var/unpowered_slowdown = 1.2
	/// Projectiles below this damage will get deflected
	var/deflect_damage = 18
	/// If TRUE - it requires PA training trait to be worn
	var/requires_training = TRUE
	/// If TRUE - the suit will give its user specific traits when worn
	var/powered = TRUE
	/// If TRUE - the suit has been recently affected by EMP blast
	var/emped = FALSE
	/// Path of item that this set of armor gets salvaged into
	var/obj/item/salvaged_type = null
	/// Used to track next tool required to salvage the suit
	var/salvage_step = 0

/obj/item/clothing/suit/armor/f13/power_armor/Initialize()
	. = ..()
	if(ispath(cell))
		cell = new cell(src)

/obj/item/clothing/suit/armor/f13/power_armor/mob_can_equip(mob/user, mob/equipper, slot, disable_warning = 1)
	var/mob/living/carbon/human/H = user
	if(src == H.wear_suit) //Suit is already equipped
		return ..()
	if (!HAS_TRAIT(H, TRAIT_PA_WEAR) && slot == SLOT_WEAR_SUIT && requires_training)
		to_chat(user, "<span class='warning'>You don't have the proper training to operate the power armor!</span>")
		return FALSE
	if(slot == SLOT_WEAR_SUIT)
		return ..()
	return

/obj/item/clothing/suit/armor/f13/power_armor/equipped(mob/user, slot)
	..()
	if(slot == SLOT_WEAR_SUIT && powered)
		START_PROCESSING(SSobj, src)
		assign_traits(user)

/obj/item/clothing/suit/armor/f13/power_armor/proc/assign_traits(mob/user)
	if(no_power) // Has no charge left
		return
	ADD_TRAIT(user, TRAIT_STUNIMMUNE, "PA_stun_immunity")
	ADD_TRAIT(user, TRAIT_PUSHIMMUNE, "PA_push_immunity")
	ADD_TRAIT(user, SPREAD_CONTROL, "PA_spreadcontrol")
	ADD_TRAIT(user, TRAIT_POWER_ARMOR, "PA_worn_trait") // General effects from being in PA

/obj/item/clothing/suit/armor/f13/power_armor/dropped(mob/user)
	..()
	if(powered)
		STOP_PROCESSING(SSobj, src)
		remove_traits(user)

/obj/item/clothing/suit/armor/f13/power_armor/proc/remove_traits(mob/user)
	REMOVE_TRAIT(user, TRAIT_STUNIMMUNE, "PA_stun_immunity")
	REMOVE_TRAIT(user, TRAIT_PUSHIMMUNE, "PA_push_immunity")
	REMOVE_TRAIT(user, SPREAD_CONTROL, "PA_spreadcontrol")
	REMOVE_TRAIT(user, TRAIT_POWER_ARMOR, "PA_worn_trait")

/obj/item/clothing/suit/armor/f13/power_armor/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/suit/armor/f13/power_armor/process()
	var/mob/living/carbon/human/user = src.loc
	if(!user || !ishuman(user) || (user.wear_suit != src))
		return
	if((!cell || !cell?.use(usage_cost) || (salvage_step > 1))) // No cell, ran out of charge or we're in the process of being salvaged
		if(!no_power)
			remove_power(user)
		return
	if(no_power) // Above didn't proc and suit is currently unpowered, meaning cell is installed and has charge - restore power
		restore_power(user)
		return

/obj/item/clothing/suit/armor/f13/power_armor/proc/remove_power(mob/user)
	if(salvage_step > 1) // Being salvaged
		to_chat(user, "<span class='warning'>Components in [src] require repairs!</span>")
	else
		to_chat(user, "<span class='warning'>\The [src] has ran out of charge!</span>")
	remove_traits(user)
	slowdown += unpowered_slowdown
	no_power = TRUE
	user.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/f13/power_armor/proc/restore_power(mob/user)
	to_chat(user, "<span class='notice'>\The [src]'s power restored.</span>")
	assign_traits(user)
	slowdown -= unpowered_slowdown
	no_power = FALSE
	user.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/f13/power_armor/attackby(obj/item/I, mob/living/carbon/human/user, params)
	if(powered && istype(I, /obj/item/stock_parts/cell))
		if(cell)
			to_chat(user, "<span class='warning'>\The [src] already has a cell installed.</span>")
			return
		if(user.transferItemToLoc(I, src))
			cell = I
			to_chat(user, "<span class='notice'>You successfully install \the [cell] into [src].</span>")
		return

	if(ispath(salvaged_type))
		switch(salvage_step)
			if(0)
				// Salvage
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin unsecuring the wiring cover...</span>")
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 1
						to_chat(user, "<span class='notice'>You unsecure the wiring cover.</span>")
					return
			if(1)
				// Salvage
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You start to cut down the wiring...</span>")
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 2
						to_chat(user, "<span class='notice'>You disconnect the wires.</span>")
					return
				// Fix
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin securing the wiring cover...</span>")
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 0
						to_chat(user, "<span class='notice'>You secure the wiring cover.</span>")
					return
			if(2)
				// Salvage
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You start loosening the bolts that secure components to the frame...</span>")
					if(I.use_tool(src, user, 100, volume=50))
						salvage_step = 3
						to_chat(user, "<span class='notice'>You disconnect the inner components.</span>")
					return
				// Fix
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin placing wires back into their place...</span>")
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 1
						to_chat(user, "<span class='notice'>You re-connect the wires.</span>")
					return
			if(3)
				// Salvage
				if(istype(I, /obj/item/weldingtool) || istype(I, /obj/item/gun/energy/plasmacutter))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin slicing the servomotors apart from the frame...</span>")
					if(I.use_tool(src, user, 150, volume=60))
						salvage_step = 4
						to_chat(user, "<span class='notice'>You disconnect servomotors from the main frame.</span>")
					return
				// Fix
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You start securing components to the frame...</span>")
					if(I.use_tool(src, user, 100, volume=50))
						salvage_step = 2
						to_chat(user, "<span class='notice'>You re-connect the inner components.</span>")
					return
			if(4)
				// Salvage
				if(istype(I, /obj/item/crowbar))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You start to remove remaining components...</span>")
					if(I.use_tool(src, user, 50, volume=70))
						to_chat(user, "<span class='notice'>You finish salvaging the suit.</span>")
						var/obj/item/ST = new salvaged_type(src)
						user.put_in_hands(ST)
						qdel(src)
					return
				// Fix
				if(istype(I, /obj/item/weldingtool) || istype(I, /obj/item/gun/energy/plasmacutter))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the suit before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin welding the servomotors to the frame...</span>")
					if(I.use_tool(src, user, 150, volume=60))
						salvage_step = 3
						to_chat(user, "<span class='notice'>You re-connect servomotors to the main frame.</span>")
					return
	return ..()

/obj/item/clothing/suit/armor/f13/power_armor/attack_self(mob/living/user)
	if(powered)
		toggle_cell(user)
	return ..()

/obj/item/clothing/suit/armor/f13/power_armor/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return ..()
	if(powered)
		toggle_cell(user)
	return

/obj/item/clothing/suit/armor/f13/power_armor/proc/toggle_cell(mob/living/user)
	if(cell)
		user.visible_message("<span class='notice'>[user] removes \the [cell] from [src]!</span>", \
			"<span class='notice'>You remove [cell].</span>")
		cell.add_fingerprint(user)
		user.put_in_hands(cell)
		cell = null
	else
		to_chat(user, "<span class='warning'>[src] has no cell installed.</span>")

/obj/item/clothing/suit/armor/f13/power_armor/examine(mob/user)
	. = ..()
	if(powered && (in_range(src, user) || isobserver(user)))
		if(cell)
			. += "The power meter shows [round(cell.percent(), 0.1)]% charge remaining."
		else
			. += "The power cell slot is currently empty."
	if(ispath(salvaged_type))
		. += salvage_hint()

/obj/item/clothing/suit/armor/f13/power_armor/proc/salvage_hint()
	switch(salvage_step)
		if(0)
			return "<span class='notice'>The wiring cover is <i>screwed</i> in place.</span>"
		if(1)
			return "<span class='notice'>The cover is <i>screwed</i> open and <i>wires</i> are visible.</span>"
		if(2)
			return "<span class='warning'>The wiring has been <i>cut</i> and components connected with <i>bolts</i> are visible.</span>"
		if(3)
			return "<span class='warning'>The components have been <i>unanchored</i> servomotors inside the suit can be <i>sliced through</i>.</span>"
		if(4)
			return "<span class='warning'>The servomotors have been <i>sliced apart</i> from the frame and remaining components can be <i>pried away</i>.</span>"

/obj/item/clothing/suit/armor/f13/power_armor/emp_act(mob/living/carbon/human/owner, severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(!powered)
		return
	if(cell)
		cell.emp_act(severity)
	if(!emped)
		if(isliving(loc))
			var/mob/living/L = loc
			var/induced_slowdown = 0
			if(severity >= 41) //heavy emp
				induced_slowdown = 4
				to_chat(L, "<span class='boldwarning'>Warning: severe electromagnetic surge detected in armor. Rerouting power to emergency systems.</span>")
			else
				induced_slowdown = 2
				to_chat(L, "<span class='warning'>Warning: light electromagnetic surge detected in armor. Rerouting power to emergency systems.</span>")
			emped = TRUE
			slowdown += induced_slowdown
			L.update_equipment_speed_mods()
			addtimer(CALLBACK(src, .proc/end_emp_effect, induced_slowdown), 50)
	return

/obj/item/clothing/suit/armor/f13/power_armor/proc/end_emp_effect(slowdown_induced)
	emped = FALSE
	slowdown -= slowdown_induced // Even if armor is dropped it'll fix slowdown
	if(isliving(loc))
		var/mob/living/L = loc
		to_chat(L, "<span class='warning'>Armor power reroute successful. All systems operational.</span>")
		L.update_equipment_speed_mods()

/obj/item/clothing/suit/armor/f13/power_armor/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if((attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(70) && (damage < deflect_damage)) // Weak projectiles like shrapnel get deflected
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

// Recycle power armor with blowtorch (welder ok fine)
/obj/item/clothing/suit/armor/f13/power_armor/welder_act(mob/living/user, obj/item/I)
	user.visible_message("[user] begins recycling the [src].", \
			"<span class='notice'>You begin cutting the [src] apart.</span>", \
			"<span class='italics'>You hear the noise of a blowtorch working.</span>")
	if(I.use_tool(src, user, 100, volume=50, amount=15))
		new /obj/item/stack/crafting/armor_plate/ (drop_location(), 10)
		qdel(src)
		to_chat(user, "<span class='notice'>You salvage armor plates from the [src].</span>")
	else
		return ..()

/obj/item/clothing/suit/armor/f13/power_armor/t45b
	name = "T-45b power armor"
	desc = "It's a set of early-model T-45 power armor with a custom air conditioning module and restored servomotors. Bulky, but almost as good as the real thing."
	armor = list("melee" = 70, "bullet" = 70, "laser" = 70, "energy" = 22, "bomb" = 55, "bio" = 65, "rad" = 55, "fire" = 85, "acid" = 0, "wound" = 65)
	slowdown = 0.4
	salvaged_type = /obj/item/clothing/suit/armored/heavy/salvaged_pa/t45b

/obj/item/clothing/suit/armor/f13/power_armor/t45d
	name = "T-45d power armor"
	desc = "Originally developed and manufactured for the United States Army by American defense contractor West Tek, the T-45d power armor was the first version of power armor to be successfully deployed in battle."
	icon_state = "t45dpowerarmor"
	item_state = "t45dpowerarmor"
	slowdown = 0.25
	armor = list("melee" = 72.5, "bullet" = 72.5, "laser" = 72.5, "energy" = 25, "bomb" = 65, "bio" = 75, "rad" = 80, "fire" = 85, "acid" = 30, "wound" = 70)
	salvaged_type = /obj/item/clothing/suit/armored/heavy/salvaged_pa/t45d

/obj/item/clothing/suit/armor/f13/power_armor/t45d/knightcaptain
	name = "Head-Knight's T-45d Power Armour"
	desc = "A classic set of T-45d Power Armour only to be used in armed combat, it signifies the Head Knight and their place in the Brotherhood. A leader, and a beacon of structure in a place where chaos reigns. All must rally to his call, for he is the Head Knight and your safety is his duty."
	icon_state = "t45dkc"
	item_state = "t45dkc"
	slowdown = 0.16

/obj/item/clothing/suit/armor/f13/power_armor/t45d/bos
	name = "Brotherhood T-45d Power Armour"
	desc = "A suit of T-45d Power Armour adorned with the markings of the Brotherhood of Steel. Commonly used by the Paladins of the Brotherhood."
	icon_state = "t45dpowerarmor_bos"
	item_state = "t45dpowerarmor_bos"

/obj/item/clothing/suit/armor/f13/power_armor/t45d/sierra
	name = "Scorched Sierra power armor"
	desc = "A captured set of T-45d power armor put into use by the NCR, it's been heavily modified and decorated with the head of a bear and intricate gold trimming. A two headed bear is scorched into the breastplate."
	icon_state = "sierra"
	item_state = "sierra"

/obj/item/clothing/suit/armor/f13/power_armor/t51b
	name = "T-51b power armor"
	desc = "The pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer."
	icon_state = "t51bpowerarmor"
	item_state = "t51bpowerarmor"
	slowdown = 0.25 //+0.05 from helmet = total 0.255
	armor = list("melee" = 72.5, "bullet" = 72.5, "laser" = 72.5, "energy" = 30, "bomb" = 62, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 40, "wound" = 72)
	salvaged_type = /obj/item/clothing/suit/armored/heavy/salvaged_pa/t51b

/obj/item/clothing/suit/armor/f13/power_armor/t51green
	name = "Hardened T-51b power armor"
	desc = "The pinnacle of pre-war technology. This suit of power armor provides substantial protection to the wearer. It's plates have been chemially treated to be stronger."
	icon_state = "t51green"
	item_state = "t51green"
	slowdown = 0.25 //+0.05 from helmet = total 0.255
	armor = list("melee" = 75, "bullet" = 75, "laser" = 75, "energy" = 27, "bomb" = 64, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 40, "wound" = 75)

/obj/item/clothing/suit/armor/f13/power_armor/hmidwest
	name = "Hardened Midwestern power armor"
	desc = "This set of power armor belongs to the Midwestern branch of the Brotherhood of Steel. This particular one has gone through a chemical hardening process, increasing its armor capabilities."
	icon_state = "midwestgrey_pa"
	item_state = "midwestgrey_pa"
	slowdown = 0.25 //+0.05 from helmet = total 0.255
	armor = list("melee" = 75, "bullet" = 75, "laser" = 75, "energy" = 27, "bomb" = 64, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 40, "wound" = 75)

/obj/item/clothing/suit/armor/f13/power_armor/t51b/bos
	name = "Brotherhood T-51b Power Armour"
	desc = "The pinnacle of pre-war technology, appropriated by the Brotherhood of Steel. Commonly worn by Head Paladins."
	icon_state = "t51bpowerarmor_bos"
	item_state = "t51bpowerarmor_bos"

/obj/item/clothing/suit/armor/f13/power_armor/t60
	name = "T-60a power armor"
	desc = "Developed in early 2077 after the Anchorage Reclamation, the T-60 series of power armor was designed to eventually replace the T-51b as the pinnacle of powered armor technology in the U.S. military arsenal."
	icon_state = "t60powerarmor"
	item_state = "t60powerarmor"
	slowdown = 0.2
	armor = list("melee" = 80, "bullet" = 70, "laser" = 80, "energy" = 30, "bomb" = 82, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 50, "wound" = 80)
	salvaged_type = /obj/item/clothing/suit/armored/heavy/salvaged_pa/t60

/obj/item/clothing/suit/armor/f13/power_armor/t60/pineapple
	name = "degraded T-60a power armor"
	desc = "Developed in early 2077 after the Anchorage Reclamation, the T-60 series of power armor was designed to eventually replace the T-51b as the pinnacle of powered armor technology in the U.S. military arsenal. This suit is heavily degraded." //reskin of head knight armor
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 60, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 50)
	salvaged_type = null

/obj/item/clothing/suit/armor/f13/power_armor/excavator
	name = "excavator power armor"
	desc = "Developed by Garrahan Mining Co. in collaboration with West Tek, the Excavator-class power armor was designed to protect miners from rockfalls and airborne contaminants while increasing the speed at which they could work. "
	icon_state = "excavator"
	item_state = "excavator"
	slowdown = 0.4
	armor = list("melee" = 80, "bullet" = 50, "laser" = 50, "energy" = 15, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 80, "wound" = 80)

/obj/item/clothing/suit/armor/f13/power_armor/advanced
	name = "advanced power armor"
	desc = "An advanced suit of armor typically used by the Enclave.<br>It is composed of lightweight metal alloys, reinforced with ceramic castings at key stress points.<br>Additionally, like the T-51b power armor, it includes a recycling system that can convert human waste into drinkable water, and an air conditioning system for its user's comfort."
	icon_state = "advpowerarmor1"
	item_state = "advpowerarmor1"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 85, "energy" = 35, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 50, "wound" = 90)

//Peacekeeper armor adjust as needed
/obj/item/clothing/suit/armor/f13/power_armor/x02
	name = "Enclave power armor"
	desc = "Upgraded pre-war power armor design used by the Enclave. It is mildly worn due to it's age and lack of maintenance after the fall of the Enclave."
	icon_state = "advanced"
	item_state = "advanced"
	slowdown = 0.25 //+0.1 from helmet = total 0.35
	armor = list("melee" = 85, "bullet" = 85, "laser" = 85, "energy" = 65, "bomb" = 70, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 50, "wound" = 75)
	salvaged_type = /obj/item/clothing/suit/armored/heavy/salvaged_pa/x02 // Oh the misery

/obj/item/clothing/suit/armor/f13/enclave/armorvest
	name = "armored vest"
	desc = "(VI) Efficient prewar design issued to Enclave personell."
	icon_state = "armor_enclave_peacekeeper"
	item_state = "armor_enclave_peacekeeper"
	armor = list("tier" = 6)


//Generic Tribal - For Wayfarer specific, see f13factionhead.dm
//Trying generic tribal armor stats for this one for now.
/obj/item/clothing/suit/hooded/tribaloutcast
	name = "patched heavy leather cloak"
	desc = "A robust cloak made from layered gecko skin patched with various bits of leather from dogs and other animals, able to absorb more force than one would expect from leather."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	icon_state = "cloak_outcast"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	item_state = "cloak_outcast"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 5, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	strip_delay = 40
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/tribaloutcast
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS

/obj/item/clothing/head/hooded/cloakhood/tribaloutcast
	name = "patched leather hood"
	desc = "Thick layered leather, patched together."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hood_tribaloutcast"
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	item_state = "hood_tribaloutcast"
	armor = list("melee" = 40, "bullet" = 30,"laser" = 5, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/armor/f13/tribal
	name = "tribal armor"
	desc = "A set of armor made of gecko hides.<br>It's pretty good for makeshift armor."
	icon_state = "tribal"
	item_state = "tribal"
	armor = list("melee" = 55, "bullet" = 35,"laser" = 20, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'

/obj/item/clothing/suit/armor/f13/chitinarmor
	name = "insect chitin armor"
	desc = " set of light armor made of insect chitin. Tough and light, it provides some moderate protection from trauma while allowing the user to remain mobile and protected from the elements."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "insect"
	item_state = "insect"
	armor = list("melee" = 40, "bullet" = 35,"laser" = 20, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40

//Various

/obj/item/clothing/suit/armor/tesla //changed from armor/laserproof
	name = "tesla armor"
	desc = "A prewar armor design by Nikola Tesla before being confinscated by the U.S. government. Has a chance to deflect energy projectiles."
	icon_state = "tesla_armor"
	item_state = "tesla_armor"
	blood_overlay_type = "armor"
	armor = list("melee" = 25, "bullet" = 25,"laser" = 99, "energy" = 60, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	resistance_flags = FIRE_PROOF
	var/hit_reflect_chance = 20
	protected_zones = list(BODY_ZONE_CHEST, BODY_ZONE_PRECISE_GROIN, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)

/obj/item/clothing/suit/armor/tesla/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	if(is_energy_reflectable_projectile(object) && (attack_type == ATTACK_TYPE_PROJECTILE) && (def_zone in protected_zones))
		if(prob(hit_reflect_chance))
			block_return[BLOCK_RETURN_REDIRECT_METHOD] = REDIRECT_METHOD_DEFLECT
			return BLOCK_SHOULD_REDIRECT | BLOCK_REDIRECTED | BLOCK_SUCCESS | BLOCK_PHYSICAL_INTERNAL
	return ..()

/obj/item/clothing/suit/armor/f13/sulphitearmor
	name = "sulphite armor"
	desc = "A combination of what seems to be raider metal armor with a jerry-rigged flame-exhaust system and ceramic plating."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	resistance_flags = FIRE_PROOF
	icon_state = "sulphite"
	item_state = "sulphite"
	armor = list("melee" = 25, "bullet" = 55,"laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20, "wound" = 45)
	slowdown = 0.20

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
	desc = "an ornate suit worn by Mexican gunfighters in the Old West, padded with leather for extra protection."
	icon_state = "vaquero"
	item_state = "vaquero"
	armor = list("melee" = 30, "bullet" = 25,"laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEJUMPSUIT

/obj/item/clothing/suit/armor/light/wastewar
	name = "wasteland warrior armor"
	desc = "A mad attempt to recreate armor based of images of japanese samurai, using a sawn up old car tire as shoulder pads, bits of chain to cover the hips and pieces of furniture for a breastplate. Might stop a blade but nothing else."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "wastewar"
	item_state = "wastewar"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0, "wound" = 35)
	slowdown = 0.07

/obj/item/clothing/suit/armor/f13/slam
	name = "slammer raider armor"
	desc = "Crude armor that appears to employ a tire of some kind as the shoulder pad. What appears to be a quilt is tied around the waist.<br>Come on and slam and turn your foes to jam!"
	icon_state = "slam"
	item_state = "slam"
	armor = list("melee" = 45, "bullet" = 20,"laser" = 20, "energy" = 0, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEJUMPSUIT
	strip_delay = 40
	icon = 'icons/fallout/clothing/armored_medium.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_medium.dmi'

/obj/item/clothing/suit/armor/f13/battlecoat //Maxson's battlecoat from Fallout 4
	name = "battlecoat"
	desc = "A heavy padded leather coat, worn by pre-War bomber pilots in the past and post-War zeppelin pilots in the future."
	icon_state = "maxson_battlecoat"
	item_state = "maxson_battlecoat"
	armor = list("melee" = 30, "bullet" = 20,"laser" = 20, "energy" = 20, "bomb" = 30, "bio" = 0, "rad" = 30, "fire" = 30, "acid" = 30, "wound" = 35)
	strip_delay = 30
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/armor/f13/battlecoat/vault
	name = "command coat"
	desc = "A heavy pre-war bomber coat, dyed blue with the number '113' embroidered on the back. Most often worn by leaders, such as the Overseer."
	icon_state = "maxson_battlecoat"
	item_state = "maxson_battlecoat"


/obj/item/clothing/suit/armor/f13/battlecoat/vault/overseer
	name = "Overseer's battlecoat"
	desc = "A heavy pre-war bomber coat, dyed blue with the insignia of the Vault-Tec embroidered on the back. This one is worn by the Coalition's Overseer."
	icon_state = "maxson_battlecoat"
	item_state = "maxson_battlecoat"

/obj/item/clothing/suit/armor/f13/battlecoat/vault/marshal
	name = "Marhsal's battlecoat"
	desc = "A heavy pre-war bomber coat, dyed blue with the insignia of the Vault-Tec City Coalition embroidered on the back. This one is worn by the Marshals of the Coalition."
	icon_state = "maxson_battlecoat"
	item_state = "maxson_battlecoat"


/obj/item/clothing/suit/armor/f13/brahmin_leather_duster
	name = "brahmin leather duster"
	desc = "A duster fashioned with tanned brahmin hide. It appears to be more durable than a normal duster. The leather is laser resistant."
	icon_state = "brahmin_leather_duster"
	item_state = "brahmin_leather_duster"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 35, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10, "wound" = 40)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/armor/f13/rustedcowboy
	name = "rusted cowboy outfit"
	desc = " A weather treated leather cowboy outfit.  Yeehaw Pard'!"
	icon_state = "rusted_cowboy"
	item_state = "rusted_cowboy"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 35, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

//Inherited from SS13
/obj/item/clothing/suit/armor/bulletproof
	name = "bulletproof armor"
	desc = "A heavy bulletproof vest that excels in protecting the wearer against traditional projectile weaponry and explosives to a minor extent."
	icon_state = "bulletproof"
	item_state = "armor"
	blood_overlay_type = "armor"
	armor = list("melee" = 27, "bullet" = 60, "laser" = 27, "energy" = 35, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10, "wound" = 50)
	strip_delay = 70
	equip_delay_other = 50
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	slowdown = 0.05

/obj/item/clothing/suit/armor/bone
	name = "bone armor"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bonearmor"
	item_state = "bonearmor"
	blood_overlay_type = "armor"
	armor = list("melee" = 65, "bullet" = 5, "laser" = 0, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 45)
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
	desc = "An ugly looking combat duster"
	icon_state = "harperduster"
	armor = list("melee" = 25, "bullet" = 50, "laser" = 25, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	slowdown = 0.07

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
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "energy" = 35, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/shankduster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/toggle/armor/f13/rangercustomdark
	name = "tattered recon duster"
	desc = "A thicker than average duster worn by rangers out in the field. This one has been dyed black and appears to be a little more heavily armoured."
	icon_state = "duster_recon_custom"
	item_state = "duster_recon_custom"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/palacent/custom_excess
	name = "Champion of Kanab's Armor"
	desc = "The armor of the Champion and Conqueror of the city in Utah named Kanab. The armor is made up of pieces of Power Armor and pre-war Riot Gear, the shin guards are spraypainted a dark crimson and the Power Armour pauldron has a red trim. The symbol of a Pheonix is carefully engraved and painted upon the chest piece... I wonder what it means.."
	icon_state = "palacent_excess"
	item_state = "palacent_excess"

/obj/item/clothing/suit/donor/soldier
	name = "Soldier's Greatcoat"
	desc = "A resistant, tan greatcoat, typically worn by pre-War Generals."
	icon_state = "soldier"
	item_state = "soldier"
	armor = list("melee" = 30, "bullet" = 33, "laser" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/armor/f13/rangercombat/foxcustom
	name = "sniper riot gear"
	desc = "A customized and well-worn suit of riot gear with parts of the suit reinforced with leather armor and slain Centurion armor pieces by the wearer. A sniper's veil is wrapped around the neck."
	icon_state = "foxranger"
	item_state = "foxranger"

/obj/item/clothing/suit/armor/f13/rangercombat/degancustom
	name = "sniper riot gear"
	desc = "A customized and well-worn suit of riot gear with parts of the suit reinforced with leather armor and slain Centurion armor pieces by the wearer. A sniper's veil is wrapped around the neck."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/rangercombat/rigscustom
	name = "11th armored calvary armor"
	desc = "A suit of special military grade riot control gear and a duster, worn by 11th Armored Calvary Regiment members in The Divide before the war. Yellow markings are painted on the shoulderpads and forearm guards."
	icon_state = "rigscustom_suit"
	item_state = "rigscustom_suit"

/obj/item/clothing/suit/armor/f13/rangercombat/pricecustom
	name = "spider riot gear"
	desc = "A customised and faded suit of riot gear, reminiscient of that found near Hopeville in the Divide, with a pair of wrist mounted ammo pouches for easy access to spare munitions with a pair of stripes down the back made from a fire-proof material."
	icon_state = "price_ranger"
	item_state = "price_ranger"

/obj/item/clothing/suit/toggle/armor/f13/cloakranger //Reskinned trail ranger gear
	name = "ranger poncho"
	desc = "A durable muslin poncho. Tough enough to bear the elements and serve as handy blanket."
	icon_state = "ranger_cloak"
	item_state = "ranger_cloak"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)


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

/obj/item/clothing/suit/armor/f13/marlowsuit //Raider armour reskin.
	name = "Marlow gang overcoat"
	desc = "A heavy raw buckskin overcoat littered with aged bullet holes and frays from regular wear-and-tear."
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	icon_state = "marlowsuit"
	item_state = "marlowsuit"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/marlowsuit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/marlowsuit/ikesuit
	name = "gunfighter's overcoat"
	desc = "(IV) A thick double-breasted red leather overcoat worn through with scattered tears and bullet holes."
	icon_state = "ikesuit"
	item_state = "ikesuit"

/obj/item/clothing/suit/armor/f13/ikesuit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/marlowsuit/masonsuit
	name = "vagabond's vest"
	desc = "(IV) A padded thick red leather vest, coated in stitched pockets and other mends."
	icon_state = "masonsuit"
	item_state = "masonsuit"

/obj/item/clothing/suit/armor/f13/masonsuit/Initialize()
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


//Mutants

/obj/item/clothing/suit/armor/f13/mutant/poncho
	name = "mutant poncho"
	desc = "(IV) An oversized poncho, made to fit the frame of a super mutant. Maybe he's the big ranger with an iron on his hip?"
	icon_state = "mutie_poncho"
	item_state = "mutie_poncho"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/mutant/metal
	name = "mutant armour"
	desc = "(V) An oversized set of metal armour, made to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon_state = "mutie_metal_armour"
	item_state = "mutie_metal_armour"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/suit/armor/f13/mutant/metal/reinforced
	name = "mutant armour"
	desc = "(6) An oversized boiler plate, hammered to fit the frame of a super mutant. Maybe he's the big iron with a ranger on his hip?"
	icon_state = "mutie_metal_armour_mk2"
	item_state = "mutie_metal_armour_mk2"
	armor = list("tier" = 6, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 40, "fire" = 30, "acid" = 20)

//TRIBALS

/obj/item/clothing/suit/f13/tribal
	name = "tribal armor"
	desc = "A set of armor made of gecko hides.<br>It's pretty good for makeshift armor."
	icon_state = "tribal"
	item_state = "tribal"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 35, "energy" = 15, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10, "wound" = 40)
	slowdown = 0.05

/obj/item/clothing/suit/f13/tribal/light
	name = "light tribal armor"
	desc = "A set of armor made of a variety of tanned hides. It's not the best."
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.025

/obj/item/clothing/suit/f13/tribal/heavy
	name = "heavy tribal armor"
	desc = "A heavy suit of armour made of brahmin and gecko hides. It seems rather heavy."
	armor = list("melee" = 37, "bullet" = "40", "laser" = 37, "energy" = 25, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.1

/obj/item/clothing/suit/f13/tribal/ncr
	name = "tribalized NCR armor vest"
	desc = "A suit of worn dated NCR armor, it seems to have seen better days."
	icon_state = "ncr_tribal_armor"
	item_state = "ncr_tribal_armor"
	armor = list("melee" = 25, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

/obj/item/clothing/suit/f13/tribal/light/rustwalkers
	name = "Rustwalkers light armor"
	desc = "A duster made from some combination of leather and cloth, probably torn out of an old car. The shoulders appear to have had parts of an engine either strapped or stitched onto them. Commonly worn by members of the Rustwalkers tribe."
	icon_state = "rustwalkers_armour_light"
	item_state = "rustwalkers_armour_light"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	armor = list("melee" = 35, "bullet" = 35, "laser" = 15, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)

/obj/item/clothing/suit/f13/tribal/rustwalkers
	name = "Rustwalkers armor"
	desc = "A chestplate, pauldron and vambrace that bear a distinct resemblance to a coolant tank, engine valves and an exhaust. Commonly worn by members of the Rustwalkers tribe"
	icon_state = "rustwalkers_armour"
	item_state = "rustwalkers_armour"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 35, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	slowdown = 0.1

/obj/item/clothing/suit/f13/tribal/heavy/rustwalkers
	name = "Rustwalkers heavy armor"
	desc = "A car seat leather duster, a timing belt bandolier, and armour plating made from various parts of a car, it surely would weigh the wearer down. Commonly worn by members of the Rustwalkers tribe."
	icon_state = "rustwalkers_armour_heavy"
	item_state = "rustwalkers_armour_heavy"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	slowdown = 0.15

/obj/item/clothing/suit/f13/tribal/light/whitelegs
	name = "White Legs light armour"
	desc = "A small series of tan and khaki armour plates, held in place with a thin bandolier. Commonly worn by members of the White Legs tribe."
	icon_state = "white_legs_armour_light"
	item_state = "white_legs_armour_light"

/obj/item/clothing/suit/f13/tribal/whitelegs
	name = "White Legs armour"
	desc = "A series of tan and khaki armour plates, held in place with a considerable amount of strapping. Commonly worn by members of the White Legs tribe."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny
	icon_state = "white_legs_armour"
	item_state = "white_legs_armour"

/obj/item/clothing/suit/f13/tribal/heavy/whitelegs
	name = "White Legs heavy armour"
	desc = "A series of tan and khaki armour plates, held in place with a considerable amount of strapping and possibly duct tape. Commonly worn by members of the White Legs tribe."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny
	icon_state = "white_legs_armour_heavy"
	item_state = "white_legs_armour_heavy"

/obj/item/clothing/suit/f13/tribal/light/eighties
	name = "80s light armour"
	desc = "A black leather jacket with the number 80 stitched onto the back. Worn by the members of the 80s tribe."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	icon_state = "80s_armour_light"
	item_state = "80s_armour_light"

/obj/item/clothing/suit/f13/tribal/eighties
	name = "80s armour"
	desc = "A plain, slightly cropped leather jacket with a black lining and neck brace, paired with a set of metal vambraces and a black belt of pouches. Commonly worn by the members of the 80s tribe."
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	icon_state = "80s_armour"
	item_state = "80s_armour"

/obj/item/clothing/suit/f13/tribal/heavy/eighties
	name = "80s heavy armour"
	desc = "A ballistic duster with the number 80 stitched onto the back worn over a breastplate made from a motorcycle's engine housing, with kneepads made from stirrups. Worn by the members of the 80s tribe."
	icon_state = "80s_armour_heavy"
	item_state = "80s_armour_heavy"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

	armor = list("melee" = 35, "bullet" = 45, "laser" = 25, "energy" = 20, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.1

/obj/item/clothing/suit/f13/tribal/light/deadhorses
	name = "Dead Horses light armour"
	desc = "A simple leather bandolier and gecko hide chest covering. Worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour_light"
	item_state = "dead_horses_armour_light"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.01


/obj/item/clothing/suit/f13/tribal/deadhorses
	name = "Dead Horses armour"
	desc = "A simple leather bandolier and gecko hide chest covering, with an engraved metal pauldron and a pair of black leather straps. Commonly worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour"
	item_state = "dead_horses_armour"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.025

/obj/item/clothing/suit/f13/tribal/heavy/deadhorses
	name = "Dead Horses heavy armour"
	desc = "A simple leather bandolier and gecko hide chest covering, with an engraved metal pauldron and a set of black leather straps, one holding a shinpad in place. Commonly worn by the members of the Dead Horses tribe."
	icon_state = "dead_horses_armour_heavy"
	item_state = "dead_horses_armour_heavy"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bulletbelt
	armor = list("melee" = 35, "bullet" = 35, "laser" = 30, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.05

/obj/item/clothing/suit/f13/tribal/light/sorrows
	name = "Sorrows armour"
	desc = "A worn ballistic vest from Salt Lake, adorned with feathers and turqoise beads, with an ornamental pattern painted over the sides. Commonly worn by the members of the peaceful Sorrows tribe."
	icon_state = "sorrows_armour"
	item_state = "sorrows_armour"
	armor = list("melee" = 20, "bullet" = 45, "laser" = 20, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	slowdown = 0.08

/obj/item/clothing/suit/f13/tribal/light/bone
	name = "Bone armor"
	desc = "A tribal armor plate, crafted from animal bone."
	icon_state = "bone_dancer_armor_light"
	item_state = "bone_dancer_armor_light"
	blood_overlay_type = "armor"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/f13/tribal/bone
	name = "Reinforced Bone armor"
	desc = "A tribal armor plate, reinforced with leather and a few metal parts."
	icon_state = "bone_dancer_armor"
	item_state = "bone_dancer_armor"
	blood_overlay_type = "armor"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 30, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	slowdown = 0.025

/obj/item/clothing/suit/f13/tribal/heavy/bone
	name = "Heavy Bone armor"
	desc = "A tribal full armor plate, crafted from animal bone, metal and leather. Usually worn by the Bone Dancers"
	icon_state = "bone_dancer_armor_heavy"
	item_state = "bone_dancer_armor_heavy"
	blood_overlay_type = "armor"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 35, "energy" = 20, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10, "wound" = 45)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	slowdown = 0.05

/obj/item/clothing/suit/f13/tribal/light/westernwayfarer
	name = "Western Wayfarer salvaged armor"
	desc = "A set of scrap and banded metal armor forged by the Wayfarer tribe, due to it's lightweight and unrestrictive nature,  it's used by scouts and agile hunters. A torn cloak hangs around its neck, protecting the user from the harsh desert sands."
	icon = 'icons/fallout/clothing/armored_light.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_light.dmi'
	icon_state = "western_wayfarer_armor"
	item_state = "western_wayfarer_armor"
	armor = list("melee" = 30, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	slowdown = 0.025

/obj/item/clothing/suit/f13/tribal/heavy/westernwayfarer
	name = "Western Wayfarer heavy armor"
	desc = "A Suit of armor crafted by Tribals using pieces of scrap metals and the armor of fallen foes, a bighorner's skull sits on the right pauldron along with bighorner fur lining the collar of the leather bound chest. Along the leather straps adoring it are multiple bone charms with odd markings on them."
	icon = 'icons/fallout/clothing/armored_heavy.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/armor_heavy.dmi'
	icon_state = "western_wayfarer_armor_heavy"
	item_state = "western_wayfarer_armor_heavy"
	armor = list("melee" = 37, "bullet" = 40, "laser" = 25, "energy" = 20, "bomb" = 50, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	slowdown = 0.05
