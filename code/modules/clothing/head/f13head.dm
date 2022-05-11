/*PARENT ITEMS FOR REFERENCE PURPOSES. DO NOT UNCOMMENT

/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
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
	item_state = "helmet"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEEARS
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

	dog_fashion = /datum/dog_fashion/head/helmet

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_HEAD))*/

//Combat Armor FACTION SPECIFIC COMBAT ARMOR IN f13factionhead.dm

/obj/item/clothing/head/helmet/f13/combat
	name = "combat helmet"
	desc = "An old military grade pre-war combat helmet."
	icon_state = "combat_helmet"
	item_state = "combat_helmet"
	armor = list("melee" = 45, "bullet" = 45, "laser" = 45, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	strip_delay = 50
	flags_inv = HIDEEARS|HIDEHAIR
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

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
	desc = "An advanced pre-war titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms."
	icon_state = "combat_helmet_mk2"
	item_state = "combat_helmet_mk2"
	armor = list("melee" = 50, "bullet" = 50, "laser" = 40, "energy" = 22, "bomb" = 55, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/helmet/f13/combat/mk2/dark
	name = "reinforced combat helmet"
	color = "#302E2E" // Dark Grey

/obj/item/clothing/head/helmet/f13/combat/mk2/raider
	name = "customized raider combat helmet"
	desc = "A reinforced combat helmet painted black with the laser designator removed."
	icon_state = "combat_helmet_raider"
	item_state = "combat_helmet_raider"

/obj/item/clothing/head/helmet/f13/rangerbroken
	name = "broken riot helmet"
	icon_state = "ranger_broken"
	desc = "An old riot police helmet, out of use around the time of the war."
	armor = list("melee" = 38, "bullet" = 45, "laser" = 38, "energy" = 18, "bomb" = 45, "bio" = 55, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1

/obj/item/clothing/head/helmet/f13/combat/swat
	name = "SWAT combat helmet"
	desc = "A prewar combat helmet issued to S.W.A.T. personnel."
	icon_state = "swatsyndie"
	item_state = "swatsyndie"
	armor = list("melee" = 30, "bullet" = 50, "laser" = 30, "energy" = 20, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)


/obj/item/clothing/head/helmet/f13/combat/environmental
	name = "environmental armor helmet"
	desc = "A full head helmet and gas mask, developed for use in heavily contaminated environments."
	icon_state = "env_helmet"
	item_state = "env_helmet"
	armor = list("melee" = 35, "bullet" = 40, "laser" = 40,"energy" = 20, "bomb" = 55, "bio" = 70, "rad" = 100, "fire" = 60, "acid" = 50)
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
	item_state = "sulphite_helm"
	armor = list("melee" = 25, "bullet" = 55,"laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

//Metal

/obj/item/clothing/head/helmet/knight/f13/metal
	name = "metal helmet"
	desc = "An iron helmet forged by tribal warriors, with a unique design to protect the face from arrows and axes."
	icon_state = "metalhelmet"
	item_state = "metalhelmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 35, "bullet" = 20, "laser" = 40, "energy" = 15, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/helmet/knight/f13/metal/reinforced
	name = "reinforced metal helmet"
	icon_state = "metalhelmet_r"
	item_state = "metalhelmet_r"
	armor = list("melee" = 37, "bullet" = 22, "laser" = 42, "energy" = 16, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/helmet/knight/f13/rider
	name = "rider helmet" //Not raider. Rider.
	desc = "It's a fancy dark metal helmet with orange spray painted flames."
	icon_state = "rider"
	item_state = "rider"

/obj/item/clothing/head/helmet/f13/metalmask
	name = "metal mask"
	desc = "A crudely formed metal hockey mask."
	icon_state = "metal_mask"
	item_state = "metal_mask"
	toggle_message = "You lower"
	alt_toggle_message = "You raise"
	can_toggle = 1
	armor = list("melee" = 35, "bullet" = 20, "laser" = 40, "energy" = 15, "bomb" = 45, "bio" = 30, "rad" = 15, "fire" = 60, "acid" = 0)
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
	item_state = "metal_mask2"
	armor = list("melee" = 37, "bullet" = 25, "laser" = 42, "energy" = 15, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/helmet/f13/tesla
	name = "tesla helmet"
	desc = "A prewar armor design by Nikola Tesla before being confiscated by the U.S. government. Provides high energy weapons resistance."
	icon_state = "tesla_helmet"
	item_state = "tesla_helmet"
	armor = list("melee" = 25, "bullet" = 25,"laser" = 80, "energy" = 60, "bomb" = 40, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
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
	min_cold_protection_temperature = SPACE_HELM_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = SPACE_HELM_MAX_TEMP_PROTECT
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
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_HELM_MAX_TEMP_PROTECT
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 5
	light_on = FALSE
	/// Projectiles below this damage will get deflected
	var/deflect_damage = 18
	/// If TRUE - it requires PA training trait to be worn
	var/requires_training = TRUE
	/// If TRUE - the suit will give its user specific traits when worn
	var/powered = TRUE
	/// Path of item that this helmet gets salvaged into
	var/obj/item/salvaged_type = null
	/// Used to track next tool required to salvage the suit
	var/salvage_step = 0

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
		to_chat(user, "<span class='warning'>You don't have the proper training to operate the power armor!</span>")
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
						to_chat(user, "<span class='warning'>You have to take off the helmet before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin unsecuring the cover...</span>")
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 1
						to_chat(user, "<span class='notice'>You unsecure the cover.</span>")
					return
			if(1)
				// Salvage
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the helmet before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin disconnecting the connection ports...</span>")
					if(I.use_tool(src, user, 80, volume=50))
						salvage_step = 2
						to_chat(user, "<span class='notice'>You disconnect the connection ports.</span>")
					return
				// Fix
				if(istype(I, /obj/item/screwdriver))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the helmet before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin securing the cover...</span>")
					if(I.use_tool(src, user, 60, volume=50))
						salvage_step = 0
						to_chat(user, "<span class='notice'>You secure the cover.</span>")
					return
			if(2)
				// Salvage
				if(istype(I, /obj/item/wirecutters))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the helmet before salvaging it.</span>")
						return
					to_chat(user, "<span class='notice'>You begin disconnecting wires...</span>")
					if(I.use_tool(src, user, 60, volume=70))
						to_chat(user, "<span class='notice'>You finish salvaging the helmet.</span>")
						var/obj/item/ST = new salvaged_type(src)
						user.put_in_hands(ST)
						qdel(src)
					return
				// Fix
				if(istype(I, /obj/item/wrench))
					if(ishuman(user) && user.wear_suit == src)
						to_chat(user, "<span class='warning'>You have to take off the helmet before fixing it.</span>")
						return
					to_chat(user, "<span class='notice'>You try to anchor connection ports to the frame...</span>")
					if(I.use_tool(src, user, 80, volume=60))
						salvage_step = 1
						to_chat(user, "<span class='notice'>You re-connect connection ports.</span>")
					return
	return ..()

/obj/item/clothing/head/helmet/f13/power_armor/examine(mob/user)
	. = ..()
	if(ispath(salvaged_type))
		. += salvage_hint()

/obj/item/clothing/head/helmet/f13/power_armor/proc/salvage_hint()
	switch(salvage_step)
		if(0)
			return "<span class='notice'>The metal cover can be <i>screwed</i> open.</span>"
		if(1)
			return "<span class='notice'>The cover is <i>screwed</i> open with connection ports <i>bolted down</i>.</span>"
		if(2)
			return "<span class='warning'>The connections ports have been <i>unanchored</i> and only <i>wires</i> remain.</span>"

/obj/item/clothing/head/helmet/f13/power_armor/t45b
	name = "T-45b helmet"
	desc = "It's a T-45b power armor helmet."
	icon_state = "t45bhelmet"
	item_state = "t45bhelmet"
	armor = list("melee" = 70, "bullet" = 70, "laser" = 70, "energy" = 22, "bomb" = 55, "bio" = 65, "rad" = 55, "fire" = 85, "acid" = 0, "wound" = 40)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_t45b

/obj/item/clothing/head/helmet/f13/power_armor/t45d
	name = "T-45d power helmet"
	desc = "t's an old pre-War power armor helmet. It's pretty hot inside of it."
	icon_state = "t45dhelmet0"
	item_state = "t45dhelmet0"
	actions_types = list(/datum/action/item_action/toggle_helmet_light)
	armor = list("melee" = 72.5, "bullet" = 72.5, "laser" = 72.5, "energy" = 25, "bomb" = 65, "bio" = 75, "rad" = 80, "fire" = 85, "acid" = 30, "wound" = 40)
	salvaged_type = /obj/item/clothing/head/helmet/f13/heavy/salvaged_t45d

/obj/item/clothing/head/helmet/f13/power_armor/t45d/update_icon_state()
	icon_state = "t45dhelmet[light_on]"
	item_state = "t45dhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t45d/bos
	name = "Brotherhood T-45d power helmet"
	desc = "It's an old pre-War power armor helmet. It's pretty hot inside of it."

/obj/item/clothing/head/helmet/f13/power_armor/t45d/bos/update_icon_state()
	icon_state = "t45dhelmet[light_on]"
	item_state = "t45dhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t51b
	name = "T-51b power helmet"
	desc = "It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming."
	icon_state = "t51bhelmet0"
	item_state = "t51bhelmet0"
	armor = list("melee" = 70, "bullet" = 70, "laser" = 70, "energy" = 27, "bomb" = 62, "bio" = 100, "rad" = 99, "fire" = 90, "acid" = 0, "wound" = 70)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)

/obj/item/clothing/head/helmet/f13/power_armor/t51b/update_icon_state()
	icon_state = "t51bhelmet[light_on]"
	item_state = "t51bhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t51b/bos
	name = "T-51b power helmet"
	desc = "It's a T-51b power helmet, typically used by the Brotherhood. It looks somewhat charming."

/obj/item/clothing/head/helmet/f13/power_armor/t51b/bos/update_icon_state()
	icon_state = "t51bhelmet[light_on]"
	item_state = "t51bhelmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/t60
	name = "T-60a power helmet"
	desc = "The T-60 powered helmet, equipped with targetting software suite, Friend-or-Foe identifiers, dynamic HuD, and an internal music player."
	icon_state = "t60helmet0"
	item_state = "t60helmet0"
	armor = list("melee" = 80, "bullet" = 70, "laser" = 80, "energy" = 30, "bomb" = 82, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 0, "wound" = 80)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)


/obj/item/clothing/head/helmet/f13/power_armor/t60/update_icon_state()
	icon_state = "t60helmet[light_on]"
	item_state = "t60helmet[light_on]"

/obj/item/clothing/head/helmet/f13/power_armor/excavator
	name = "excavator power helmet"
	desc = "The helmet of the excavator power armor suit."
	icon_state = "excavator"
	item_state = "excavator"
	armor = list("melee" = 80, "bullet" = 50, "laser" = 50, "energy" = 15, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 95, "acid" = 80, "wound" = 80)


/obj/item/clothing/head/helmet/f13/power_armor/advanced
	name = "advanced power helmet"
	desc = "It's an advanced power armor MK1 helmet, typically used by the Enclave. It looks somewhat threatening."
	icon_state = "advhelmet1"
	item_state = "advhelmet1"
	armor = list("melee" = 80, "bullet" = 80, "laser" = 85, "energy" = 35, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 90)


/obj/item/clothing/head/helmet/f13/power_armor/advanced/hellfire
	name = "hellfire power armor"
	desc = "A deep black helmet of Enclave-manufactured heavy power armor with yellow ballistic glass, based on pre-war designs such as the T-51 and improving off of data gathered by post-war designs such as the X-01. Most commonly fielded on the East Coast, no other helmet rivals it's strength."
	icon_state = "hellfirehelm"
	item_state = "hellfirehelm"
	armor = list("melee" = 85, "bullet" = 85, "laser" = 87, "energy" = 37, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 100)


//Part of the peacekeeper enclave stuff, adjust values as needed.
/obj/item/clothing/head/helmet/f13/power_armor/x02helmet
	name = "Enclave power armor helmet"
	desc = "The Enclave Mark II Powered Combat Armor helmet."
	icon_state = "advanced"
	item_state = "advanced"
	slowdown = 0.1
	armor = list("melee" = 85, "bullet" = 85, "laser" = 85, "energy" = 65, "bomb" = 70, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 75)
	actions_types = list(/datum/action/item_action/toggle_helmet_light)


//Generic Tribal - For Wayfarer specific, see f13factionhead.dm

/obj/item/clothing/head/helmet/f13/tribal
	name = "tribal power helmet"
	desc = "This power armor helmet was salvaged by savages from the battlefield.<br>They believe that these helmets capture the spirits of their fallen wearers, so they painted some runes on to give it a more sacred meaning."
	icon_state = "tribal"
	item_state = "tribal"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("melee" = 50, "bullet" = 50, "laser" = 50, "energy" = 35, "bomb" = 72, "bio" = 100, "rad" = 100, "fire" = 90, "acid" = 0, "wound" = 90)
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
	item_state = "fedora"
	cold_protection = HEAD //This tam brings the warm reggae and Jamaican sun with it.
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT

/obj/item/clothing/head/f13/hairband
	name = "hairband"
	desc = "Pretty yellow hairband"
	icon_state = "50shairband"
	item_state = "50shairband"

/obj/item/clothing/head/f13/nursehat
	name = "nursehat"
	desc = "White cloth headdress for nurses"
	icon_state = "nursehat"
	item_state = "nursehat"

/obj/item/clothing/head/f13/beaver
	name = "beaverkin"
	desc = "A hat made from felted beaver fur which makes the wearer feel both comfortable and elegant."
	icon_state = "beaver"
	item_state = "that"

/obj/item/clothing/head/f13/purple
	name = "purple top hat"
	desc = "You may not own the best jail in the observed Universe, or the best chocolate factory in the entire world, but at least you can try to have that purple top hat."
	icon_state = "ptophat"
	item_state = "that"

/obj/item/clothing/head/f13/trilby
	name = "feather trilby"
	desc = "A sharp, stylish blue hat with a feather."
	icon_state = "trilby"
	item_state = "fedora"

/obj/item/clothing/head/f13/stormchaser
	name = "stormchaser hat"
	desc = "Home, home on the wastes,<br>Where the mole rat and the fire gecko play.<br>Where seldom is heard a discouraging word,<br>And my skin is not glowing all day."
	icon_state = "stormchaser"
	item_state = "fedora"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/headscarf
	name = "headscarf"
	desc = "A piece of cloth worn on head for a variety of purposes, such as protection of the head or hair from rain, wind, dirt, cold, warmth, for sanitation, for fashion, recognition or social distinction - with religious significance, to hide baldness, out of modesty, or other forms of social convention."
	icon_state = "headscarf"
	item_state = "dethat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/f13/headscarf/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/pot
	name = "metal cooking pot"
	desc = "Step one: Start with the sauce.<br>Step two: Add the noodles.<br>Step three: Stir the pasta.<br>Step four: Turn up the heat.<br>Step five: Burn the house."
	icon_state = "pot"
	item_state = "fedora"
	force = 20
	hitsound = 'sound/items/trayhit1.ogg'
	flags_inv = HIDEHAIR
	armor = list("melee" = 30, "bullet" = 20, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

/obj/item/clothing/head/f13/cowboy
	name = "cowboy hat"
	desc = "I've never seen so many men wasted so badly."
	icon_state = "cowboy"
	item_state = "dethat"
	flags_inv = HIDEHAIR
	armor = list("melee" = 20, "bullet" = 15, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

/obj/item/clothing/head/f13/cowboy/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/f13/bandit
	name = "bandit hat"
	desc = "A black cowboy hat with a large brim that's curved to the sides.<br>A silver eagle pin is attached to the front."
	icon_state = "bandit"
	item_state = "fedora"
	flags_inv = HIDEHAIR
	armor = list("melee" = 20, "bullet" = 15, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

/obj/item/clothing/head/f13/bandit/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/gambler
	name = "gambler hat"
	desc = "A perfect hat for a ramblin' gamblin' man." //But I got to ramble (ramblin' man) //Oh I got to gamble (gamblin' man) //Got to got to ramble (ramblin' man) //I was born a ramblin' gamblin' man
	icon_state = "gambler"
	item_state = "dethat"
	flags_inv = HIDEHAIR
	armor = list("melee" = 20, "bullet" = 15, "laser" = 10, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

/obj/item/clothing/head/f13/gambler/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/helmet/f13/motorcycle
	name = "motorcycle helmet"
	desc = "A type of helmet used by motorcycle riders.<br>The primary goal of a motorcycle helmet is motorcycle safety - to protect the rider's head during impact, thus preventing or reducing head injury and saving the rider's life."
	icon_state = "motorcycle"
	item_state = "motorcycle"
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 35, "bullet" = 10, "laser" = 10, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEHAIR
	strip_delay = 10

/obj/item/clothing/head/helmet/f13/motorcycle/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/firefighter
	name = "firefighter helmet"
	desc = "A firefighter's helmet worn on top of a fire-retardant covering and broken gas mask.<br>It smells heavily of sweat."
	icon_state = "firefighter"
	item_state = "firefighter"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor = list("melee" = 20, "bullet" = 20, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
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
	item_state = "vaquerohat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/wastewarhat
	name = "warrior helmet"
	desc = "It might have been a cooking pot once, now its a helmet, with a piece of cloth covering the neck from the sun."
	icon = 'icons/fallout/clothing/helmets.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/helmet.dmi'
	icon_state = "wastewar"
	item_state = "wastewar"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/wastewarhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


/obj/item/clothing/head/helmet/f13/hoodedmask
	name = "hooded mask"
	desc = "A gask mask with the addition of a hood."
	icon_state = "Hooded_Gas_Mask"
	item_state = "Hooded_Gas_Mask"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/brahmincowboyhat
	name = "brahmin leather cowboy hat"
	desc = "A cowboy hat made from brahmin hides."
	icon_state = "brahmin_leather_cowboy_hat"
	item_state = "brahmin_leather_cowboy_hat"
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/brahmincowboyhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/rustedcowboyhat
	name = "Rusted Cowboy Hat"
	desc = "A hat made from tanned leather hide."
	icon_state = "rusted_cowboy"
	item_state = "rusted_cowboy"
	flags_inv = HIDEEARS|HIDEHAIR
	armor = list("melee" = 25, "bullet" = 25, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/rustedcowboyhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/police
	name = "police hat"
	desc = "The wasteland's finest."
	icon_state = "retropolice"
	item_state = "fedora"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/simplekitty
	name = "kitty headband"
	desc = "A headband with a pair of cute kitty ears."
	icon_state = "kittyb"
	color = "#999999"
	armor = list("tier" = 0)
	dynamic_hair_suffix = ""

/obj/item/clothing/head/f13/riderw
	name = "Reinforced Rider Helmet" //Not raider. Rider. //Count up your sins
	desc = "It's a fancy two-tone metal helmet. It's been lined with additional plating and given a fresh coat of paint."
	icon_state = "riderw"
	item_state = "riderw"
	armor = list("melee" = 55, "bullet" = 35, "laser" = 35, "energy" = 15, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 0)

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
	desc = "A resistant, tan peaked cap, typically worn by pre-War Generals."
	icon_state = "macarthur"
	item_state = "macarthur"


/obj/item/clothing/head/helmet/f13/ncr/rangercombat/rigscustom
	name = "11th armored calvary helmet"
	desc = "An advanced combat helmet used by the 11th Armored Calvary Regiment before the war. There is a worn and faded 11th Armored Calvary Regiment's insignia just above the visor. The helmet itself has some scratches and dents sustained from battle."
	icon_state = "rigscustom_helmet"
	item_state = "rigscustom_helmet"
	icon = 'icons/fallout/clothing/hats.dmi'

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/pricecustom
	name = "spider riot helmet"
	desc = "A customised riot helmet reminiscient of the more advanced riot helmets found in the Divide, sporting purple lenses over the traditional red or green and a pair of red fangs painted over the respirator. The back of the helmet has a the face of an albino spider painted over it."
	icon_state = "price_ranger"
	item_state = "price_ranger"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/foxcustom
	name = "reclaimed ranger-hunter combat helmet"
	desc = "A reclaimed Ranger-Hunter centurion helmet, carefully and lovingly restored to working condition with a sniper's veil wrapped around the neck. 'DE OPPRESSO LIBER' is stenciled on the front."
	icon_state = "foxranger"
	item_state = "foxranger"
	actions_types = list(/datum/action/item_action/toggle)
	toggle_message = "You put the sniper's veil on"
	alt_toggle_message = "You take the sniper's veil off"
	can_toggle = 1
	toggle_cooldown = 0

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/degancustom
	name = "reclaimed ranger-hunter combat helmet"
	desc = "A reclaimed Ranger-Hunter centurion helmet, carefully and lovingly restored to working condition with a sniper's veil wrapped around the neck. 'DE OPPRESSO LIBER' is stenciled on the front."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	actions_types = list(/datum/action/item_action/toggle)
	toggle_message = "You put the sniper's veil on"
	alt_toggle_message = "You take the sniper's veil off"
	can_toggle = 1
	toggle_cooldown = 0
	armor = list("tier" = 2, "energy" = 20, "bomb" = 20, "bio" = 20, "rad" = 20, "fire" = 20, "acid" = 20)

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/mosshelmet
	name = "veteran patrol stetson"
	desc = "A weathered campaign hat tightly fitted over the viscera of a ranger combat helmet. The old stetson is faded with age and heavy use, having seen the green shores of California to the white peaks of the rockies."
	icon_state = "mosshelmet"
	item_state = "mosshelmet"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/head/helmet/f13/power_armor/midwest/hardened
	name = "hardened midwestern power helmet"
	desc = "This helmet once belonged to the Midwestern branch of the Brotherhood of Steel, and now resides here. This particular one has gone through a chemical hardening process, increasing its armor capabilities."
	icon_state = "midwestpa_helm"
	item_state = "midwestpa_helm"

/obj/item/clothing/head/helmet/f13/jasonmask
	name = "jasons mask"
	desc = "A metal mask made specifically for jason."
	icon_state = "jasonmask"
	item_state = "jasonmask"

/obj/item/clothing/head/welding/f13/fire
	name = "cremator welding helmet"
	desc = "A welding helmet with flames painted on it.<br>It sure is creepy but also badass."
	icon_state = "welding_fire"
	item_state = "welding"
	tint = 1

/obj/item/clothing/head/helmet/f13/atombeliever
	name = "believer headdress"
	desc = "The headwear of the true faith."
	icon_state = "atombeliever"
	item_state = "atombeliever"
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/f13/flatranger
	name = "NCR gambler ranger hat"
	desc = "A rustic, homely style gambler hat adorning an NCR Ranger patch. Yeehaw!"
	icon_state = "gamblerrang"
	item_state = "gamblerrang"

/obj/item/clothing/head/helmet/f13/legion/venator/diohelmet
	name = "galerum lacertarex"
	desc = "The hide of a deadly green gecko affixed over a reinforced legion helmet. Its ghastly appearance serves as an intimidating gesture to those who do not yet fear the Lizard King."
	icon_state = "diohelmet"
	item_state = "diohelmet"

/obj/item/clothing/head/helmet/f13/herbertranger
	name = "weathered desert ranger helmet"
	icon_state = "modified_usmc_riot"
	item_state = "modified_usmc_riot"
	desc = "An ancient USMC riot helmet. This paticular piece retains the classic colouration of the legendary Desert Rangers, and looks as if it has been worn for decades; its night vision no longer seems to be functional. Scratched into the helmet is the sentence: 'Death to the Devils that simulate our freedom.'"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/marlowhat
	name = "boss of the plains hat"
	desc = "(IV) A thick undyed felt cowboy hat, bleached from excessive sun exposure and creased from heavy usage."
	icon_state = "marlowhat"
	item_state = "marlowhat"
	armor = list("tier" = 4, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/marlowhat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/ranger_hat
	name = "grey cowboy hat"
	desc = "A simple grey cowboy hat."
	icon_state = "ranger_grey_hat"
	item_state = "ranger_grey_hat"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/f13/ranger_hat/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/ranger_hat/banded
	name = "banded cowboy hat"
	desc = "A grey cowboy hat with a hat band decorated with brassen rings."
	icon = 'icons/mob/clothing/head.dmi'
	icon_state = "ranger_hat_grey_banded"
	item_state = "ranger_hat_grey_banded"

/obj/item/clothing/head/f13/ranger_hat/tan
	name = "tan cowboy hat"
	desc = "A thick tanned leather hat, with a Montana Peak crease."
	icon_state = "ranger_tan_hat"
	item_state = "ranger_tan_hat"

/obj/item/clothing/head/f13/chinahelmetcosmetic
	name = "dysfunctional chinese stealth helmet"
	desc = "A bright yellow visor in a timelessly infamous shape makes this helmet immediately recognizable. It's non-ballistic, and it's power unit for the HUD has been long since removed."
	icon_state = "stealthhelmet"
	item_state = "stealthhelmet"

/obj/item/clothing/glasses/f13/tribaleyepatch
	name = "bandage eyepatch"
	desc = "A set of heavy bandages wrapped around the head. Made to protect the eye from whatever injury occured."
	icon_state = "eyepatch_white_r"
	item_state = "eyepatch_white_r"

/obj/item/clothing/head/helmet/skull/bone
	name = "Reinforced skull helmet"
	desc = "An intimidating tribal helmet reinforced with leather and cloth parts on the inside for more comfort, while styling it on the Bone dancers way."
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = HEADCOVERSEYES
	armor = list("melee" = 30, "bullet" = 30, "laser" = 25, "energy" = 10, "bomb" = 15, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)
	icon_state = "bone_dancer_helmet"
	item_state = "bone_dancer_helmet"
	strip_delay = 100
