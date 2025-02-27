/obj/item/clothing/glasses/hud
	name = "HUD"
	desc = "A heads-up display that provides important info in (almost) real time."
	flags_1 = null //doesn't protect eyes because it's a monocle, duh
	hudwhere = list(SLOT_GLASSES)

/obj/item/clothing/glasses/hud/CheckParts(list/parts_list)
	. = ..()
	if(vision_correction)
		return
	for(var/obj/item/clothing/glasses/G in parts_list)
		if(G.vision_correction)
			vision_correction = TRUE
			name = "prescription [name]"
			return


////////////
//Med Huds//
////////////

/obj/item/clothing/glasses/hud/health
	name = "health scanner HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/health/prescription
	name = "prescription health scanner HUD"
	desc = "A heads-up display, made with a prescription lens, that scans the humans in view and provides accurate data about their health status."
	icon_state = "healthhud"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	vision_correction = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/hud/health/night
	name = "night vision health scanner HUD"
	desc = "An advanced medical heads-up display that allows doctors to find patients in complete darkness."
	icon_state = "healthhudnight"
	inhand_icon_state = "glasses"
	darkness_view = 24
	flash_protect = -2
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/hud/health/night/syndicate
	name = "combat night vision health scanner HUD"
	desc = "An advanced shielded medical heads-up display that allows soldiers to approximate how much lead poisoning their allies have suffered in complete darkness."
	flash_protect = 1
	vision_correction = 1

/obj/item/clothing/glasses/hud/health/sunglasses
	name = "medical HUDSunglasses"
	desc = "Sunglasses with a medical HUD."
	icon_state = "sunhudmed"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/blue

/obj/item/clothing/glasses/hud/health/sunglasses/prescription
	name = "prescription medical HUDSunglasses"
	vision_correction = 1

/obj/item/clothing/glasses/hud/health/eyepatch
	name = "eyepatch medHUD"
	desc = "A heads-up display that connects directly to the optical nerve of the user, replacing the need for that useless eyeball."
	icon_state = "medpatch"

///////////////////
//Diagnostic Huds//
///////////////////

/obj/item/clothing/glasses/hud/diagnostic
	name = "diagnostic HUD"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits."
	icon_state = "diagnostichud"
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/diagnostic/sunglasses
	name = "diagnostic HUDSunglasses"
	desc = "Sunglasses with a diagnostic HUD."
	icon_state = "sunhuddiag"
	inhand_icon_state = "glasses"
	darkness_view = 1
	flash_protect = 1
	tint = 1

/obj/item/clothing/glasses/hud/diagnostic/prescription
	name = "prescription diagnostic HUD"
	desc = "A heads-up display capable of analyzing the integrity and status of robotics and exosuits. This one has a prescription lens."
	icon_state = "diagnostichud"
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	vision_correction = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/hud/diagnostic/sunglasses/prescription
	name = "prescription diagnostic HUDSunglasses"
	vision_correction = 1

/obj/item/clothing/glasses/hud/diagnostic/night
	name = "night vision diagnostic HUD"
	desc = "A robotics diagnostic HUD fitted with a light amplifier."
	icon_state = "diagnostichudnight"
	inhand_icon_state = "glasses"
	darkness_view = 24
	flash_protect = -2
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/hud/diagnostic/eyepatch
	name = "eyepatch diagnostic HUD"
	desc = "A heads-up display that connects directly to the optical nerve of the user, replacing the need for that useless eyeball."
	icon_state = "diagpatch"

////////////
//Sec Huds//
////////////

/obj/item/clothing/glasses/hud/security
	name = "security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records."
	icon_state = "securityhud"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/prescription
	name = "prescription security HUD"
	desc = "A heads-up display that scans the humans in view and provides accurate data about their ID status and security records. This one has a prescription lens so you can see the banana peal that slipped you."
	icon_state = "securityhud"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	vision_correction = 1
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/security/chameleon
	name = "chameleon security HUD"
	desc = "A stolen security HUD integrated with Syndicate chameleon technology. Provides flash protection."
	flash_protect = 1

	// Yes this code is the same as normal chameleon glasses, but we don't
	// have multiple inheritance, okay?
	var/datum/action/item_action/chameleon/change/chameleon_action

/obj/item/clothing/glasses/hud/security/chameleon/New()
	..()
	chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/clothing/glasses
	chameleon_action.chameleon_name = "Glasses"
	chameleon_action.chameleon_blacklist = typecacheof(/obj/item/clothing/glasses/changeling, only_root_path = TRUE)
	chameleon_action.initialize_disguises()

/obj/item/clothing/glasses/hud/security/chameleon/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chameleon_action.emp_randomise()

/obj/item/clothing/glasses/hud/security/sunglasses
	name = "security HUDSunglasses"
	desc = "Sunglasses with a security HUD."
	icon_state = "sunhudsec"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/darkred

/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch // why was this defined *before* the sunglasses it is a subtype of.
	name = "eyepatch HUD"
	desc = "A heads-up display that connects directly to the optical nerve of the user, replacing the need for that useless eyeball."
	icon_state = "hudpatch"

/obj/item/clothing/glasses/hud/security/sunglasses/prescription
	name = "prescription security HUDSunglasses"
	vision_correction = 1

/obj/item/clothing/glasses/hud/security/night
	name = "night vision security HUD"
	desc = "An advanced heads-up display which provides id data and vision in complete darkness."
	icon_state = "securityhudnight"
	darkness_view = 24
	flash_protect = -2 //You either are flashproof or you can see in the dark, pick one.
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/hud/security/sunglasses/gars
	name = "\improper HUD gar glasses"
	desc = "GAR glasses with a HUD."
	icon_state = "gars"
	inhand_icon_state = "garb"
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/hud/security/sunglasses/gars/supergars
	name = "giga HUD gar glasses"
	desc = "GIGA GAR glasses with a HUD."
	icon_state = "supergars"
	inhand_icon_state = "garb"
	force = 12
	throwforce = 12

//Hud Toggle

/obj/item/clothing/glasses/hud/toggle
	name = "Toggle HUD"
	desc = "A hud with multiple functions."
	actions_types = list(/datum/action/item_action/switch_hud)

/obj/item/clothing/glasses/hud/toggle/attack_self(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/wearer = user
	if (wearer.glasses != src)
		return

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.remove_hud_from(user)

	if (hud_type == DATA_HUD_MEDICAL_ADVANCED)
		hud_type = null
	else if (hud_type == DATA_HUD_SECURITY_ADVANCED)
		hud_type = DATA_HUD_MEDICAL_ADVANCED
	else
		hud_type = DATA_HUD_SECURITY_ADVANCED

	if (hud_type)
		var/datum/atom_hud/H = GLOB.huds[hud_type]
		H.add_hud_to(user)

//Thermal Huds

/obj/item/clothing/glasses/hud/toggle/thermal
	name = "thermal HUD scanner"
	desc = "Thermal imaging HUD in the shape of glasses."
	icon_state = "thermal"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/hud/toggle/thermal/attack_self(mob/user)
	..()
	switch (hud_type)
		if (DATA_HUD_MEDICAL_ADVANCED)
			icon_state = "meson"
			change_glass_color(user, /datum/client_colour/glass_colour/green)
		if (DATA_HUD_SECURITY_ADVANCED)
			icon_state = "thermal"
			change_glass_color(user, /datum/client_colour/glass_colour/red)
		else
			icon_state = "purple"
			change_glass_color(user, /datum/client_colour/glass_colour/purple)
	user.update_inv_glasses()

/obj/item/clothing/glasses/hud/toggle/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()
