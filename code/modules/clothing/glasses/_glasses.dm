//Glasses
/obj/item/clothing/glasses
	name = "glasses"
	icon = 'icons/obj/clothing/glasses.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_cover = GLASSESCOVERSEYES
	slot_flags = INV_SLOTBIT_EYES
	strip_delay = 20
	equip_delay_other = 25
	resistance_flags = NONE
	custom_materials = list(/datum/material/glass = 250)
	var/vision_flags = 0
	var/invis_view = SEE_INVISIBLE_LIVING	//admin only for now
	var/invis_override = 0 //Override to allow glasses to set higher than normal see_invis
	var/list/icon/current = list() //the current hud icons
	var/vision_correction = 0 //does wearing these glasses correct some of our vision defects?
	var/throw_hit_chance = 35

/obj/item/clothing/glasses/examine(mob/user)
	. = ..()
	if(glass_colour_type && ishuman(user))
		. += span_notice("Alt-click to toggle its colors.")

/obj/item/clothing/glasses/visor_toggling()
	..()
	if(visor_vars_to_toggle & VISOR_VISIONFLAGS)
		vision_flags ^= initial(vision_flags)
	if(visor_vars_to_toggle & VISOR_DARKNESSVIEW)
		darkness_view ^= initial(darkness_view)
	if(visor_vars_to_toggle & VISOR_INVISVIEW)
		invis_view ^= initial(invis_view)

/obj/item/clothing/glasses/weldingvisortoggle(mob/user)
	. = ..()
	if(. && user)
		user.update_sight()

//called when thermal glasses are emped.
/obj/item/clothing/glasses/proc/thermal_overload()
	if(!ishuman(loc))
		return
	var/mob/living/carbon/human/H = loc
	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if((!HAS_TRAIT(H, TRAIT_BLIND) || !eyes) && H.glasses == src)
		to_chat(H, span_danger("[src] overloads and blinds you!"))
		H.flash_act(visual = 1)
		H.blind_eyes(3)
		H.blur_eyes(5)
		eyes.applyOrganDamage(5)

/obj/item/clothing/glasses/proc/ranged_attack(mob/living/carbon/human/user,atom/A, params)
	return FALSE

/obj/item/clothing/glasses/meson
	name = "optical meson scanner"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions."
	icon_state = "meson"
	inhand_icon_state = "meson"
	darkness_view = 2
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/meson/prescription
	name = "prescription optical meson scanner"
	desc = "Used by engineering and mining staff to see basic structural and terrain layouts through walls, regardless of lighting conditions. This one has prescription lens fitted in."
	vision_correction = 1

/obj/item/clothing/glasses/meson/night
	name = "night vision meson scanner"
	desc = "An optical meson scanner fitted with an amplified visible light spectrum overlay, providing greater visual clarity in darkness."
	icon_state = "nvgmeson"
	inhand_icon_state = "nvgmeson"
	darkness_view = 24
	flash_protect = -2
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/meson/gar
	name = "gar mesons"
	icon_state = "garm"
	inhand_icon_state = "garm"
	desc = "Do the impossible, see the invisible!"
	force = 10
	throwforce = 10
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/clothing/glasses/meson/eyepatch
	name = "eyepatch mesons"
	desc = "A meson system that connects directly to the optical nerve of the user, replacing the need for that useless eyeball."
	icon_state = "mesonpatch"

/obj/item/clothing/glasses/science
	name = "science goggles"
	desc = "A pair of snazzy goggles used to protect against chemical spills. Fitted with an analyzer for scanning items and reagents."
	icon_state = "purple"
	inhand_icon_state = "glasses"
	clothing_flags = SCAN_REAGENTS //You can see reagents while wearing science goggles
	actions_types = list(/datum/action/item_action/toggle_research_scanner)
	glass_colour_type = /datum/client_colour/glass_colour/purple
	resistance_flags = ACID_PROOF
	armor = ARMOR_VALUE_CLOTHES

/obj/item/clothing/glasses/science/item_action_slot_check(slot, mob/user, datum/action/A)
	if(slot == SLOT_GLASSES)
		return 1

/obj/item/clothing/glasses/night
	name = "night vision goggles"
	desc = "You can totally see in the dark now! Just don't look too closely at bright lights. This lacks any flash correction."
	icon_state = "night"
	inhand_icon_state = "glasses"
	darkness_view = 24
	flash_protect = -2
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = /datum/client_colour/glass_colour/green

/obj/item/clothing/glasses/night/prescription
	name = "prescription night vision goggles"
	desc = "NVGs but for those with nearsightedness."
	vision_correction = 1

/obj/item/clothing/glasses/night/syndicate
	name = "combat night vision goggles"
	desc = "See everything, without fear."
	flash_protect = 1
	vision_correction = 1

/obj/item/clothing/glasses/eyepatch
	name = "eyepatch"
	desc = "Avast ye wasteys!"
	icon_state = "eyepatch"
	inhand_icon_state = "eyepatch"

/obj/item/clothing/glasses/eyepatchl
	name = "white eyepatch left"
	desc = "Avast ye wasteys!"
	icon_state = "epwhitel"
	inhand_icon_state = "eyepatch"

/obj/item/clothing/glasses/eyepatchr
	name = "white eyepatch right"
	desc = "Avast ye wasteys!"
	icon_state = "epwhiter"
	inhand_icon_state = "eyepatch"

/obj/item/clothing/glasses/eyepatch/goji
	name = "emblazoned eyepatch"
	desc = "You have the eye of a mad dog!"
	icon_state = "Gojipatch"
	inhand_icon_state = "Gojipatch"

/obj/item/clothing/glasses/eyepatch/syndicate
	name = "cybernetic eyepatch"
	desc = "An eyepatch used to enhance one's aim with guns."
	icon_state = "syndicatepatch"
	inhand_icon_state = "syndicatepatch"
	resistance_flags = ACID_PROOF

/*/obj/item/clothing/glasses/eyepatch/syndicate/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_GLASSES)
		user.visible_message("<span class='warning'>Circuitry from the eyepatch links itself to your brain as you put on the eyepatch.")
		if(HAS_TRAIT(user, TRAIT_POOR_AIM))
			user.visible_message("<span class='warning'>You hear a fizzing noise from the circuit. That can't be good.")
		ADD_TRAIT(user, TRAIT_CRIT_SHOT, "SYNDICATE_EYEPATCH_AIM")
		ADD_TRAIT(src, TRAIT_NODROP, "SYNDICATE_EYEPATCH_NODROP")

/obj/item/clothing/glasses/eyepatch/syndicate/dropped(mob/living/carbon/human/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_CRIT_SHOT, "SYNDICATE_EYEPATCH_AIM")
	var/obj/item/organ/eyes/eyes = user.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.applyOrganDamage(30)
		user.visible_message("<span class='warning'>Your eye stings as the circuitry is removed from your eye!")*/

/obj/item/clothing/glasses/monocle
	name = "monocle"
	desc = "Such a dapper eyepiece!"
	icon_state = "monocle"
	inhand_icon_state = "headset" // lol

/obj/item/clothing/glasses/material
	name = "optical material scanner"
	desc = "Very confusing glasses."
	icon_state = "material"
	inhand_icon_state = "glasses"
	vision_flags = SEE_OBJS
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

/obj/item/clothing/glasses/material/mining
	name = "optical material scanner"
	desc = "Used by miners to detect ores deep within the rock."
	icon_state = "material"
	inhand_icon_state = "glasses"
	darkness_view = 0

/obj/item/clothing/glasses/material/mining/gar
	name = "gar material scanner"
	icon_state = "garm"
	inhand_icon_state = "garm"
	desc = "Do the impossible, see the invisible!"
	force = 10
	throwforce = 20
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	vision_correction = 1
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

/obj/item/clothing/glasses/regular
	name = "prescription glasses"
	desc = "Made by Nerd. Co."
	icon_state = "glasses"
	inhand_icon_state = "glasses"
	vision_correction = 1 //corrects nearsightedness

/obj/item/clothing/glasses/contact
	name = "contact lenses"
	desc = "Prescription contact lenses, a miracle of science."
	icon_state = "contact_lenses"
	inhand_icon_state = "contact_lenses"
	vision_correction = 1

/obj/item/clothing/glasses/regular/jamjar
	name = "jamjar glasses"
	desc = "Also known as Virginity Protectors."
	icon_state = "jamjar_glasses"
	inhand_icon_state = "jamjar_glasses"

/obj/item/clothing/glasses/regular/hipster
	name = "prescription glasses"
	desc = "Made by Uncool. Co."
	icon_state = "hipster_glasses"
	inhand_icon_state = "hipster_glasses"

/obj/item/clothing/glasses/regular/circle
	name = "circle glasses"
	desc = "Why would you wear something so controversial yet so brave?"
	icon_state = "circle_glasses"
	inhand_icon_state = "circle_glasses"

/obj/item/clothing/glasses/regular/protected
	name = "prescription sunglasses"
	desc = "A pair of tinted glasses to help prevent from the ever present sun and bright flashes."
	icon_state = "presc_sun"
	inhand_icon_state = "presc_sun"
	flash_protect = 1
	tint = 1
	darkness_view = 1

//Here lies green glasses, so ugly they died. RIP

/obj/item/clothing/glasses/sunglasses
	name = "sunglasses"
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Enhanced shielding blocks flashes."
	icon_state = "sun"
	inhand_icon_state = "sunglasses"
	darkness_view = 1
	flash_protect = 1
	tint = 1
	glass_colour_type = /datum/client_colour/glass_colour/gray
	dog_fashion = /datum/dog_fashion/head

/obj/item/clothing/glasses/sunglasses/garb
	name = "black gar glasses"
	desc = "Go beyond impossible and kick reason to the curb!"
	icon_state = "garb"
	inhand_icon_state = "garb"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	throwforce = 25
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10
	throw_hit_chance = 99

/obj/item/clothing/glasses/sunglasses/garb/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force)
	if(ishuman(thrower))
		var/mob/living/carbon/human/H = thrower
		H.throw_mode_off() //so they can catch it on the return.
	return ..()

/obj/item/clothing/glasses/sunglasses/garb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	if(thrownby && !caught)
		sleep(1)
		if(!QDELETED(src))
			throw_at(thrownby, throw_range+2, throw_speed, null, TRUE)
	else if(!thrownby)
		return
	return ..()

/obj/item/clothing/glasses/sunglasses/garb/supergarb
	name = "black giga gar glasses"
	desc = "Believe in us humans."
	icon_state = "supergarb"
	inhand_icon_state = "garb"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	throwforce = 25
	throw_speed = 4
	sharpness = SHARP_EDGED
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10

/obj/item/clothing/glasses/sunglasses/gar
	name = "gar glasses"
	desc = "Just who the hell do you think I am?!"
	icon_state = "gar"
	inhand_icon_state = "gar"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	throwforce = 25
	throw_speed = 4
	attack_verb = list("sliced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	glass_colour_type = /datum/client_colour/glass_colour/orange
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10

/obj/item/clothing/glasses/sunglasses/gar/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force)
	if(ishuman(thrower))
		var/mob/living/carbon/human/H = thrower
		H.throw_mode_off() //so they can catch it on the return.
	return ..()

/obj/item/clothing/glasses/sunglasses/gar/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	if(thrownby && !caught)
		sleep(1)
		if(!QDELETED(src))
			throw_at(thrownby, throw_range+2, throw_speed, null, TRUE)
	else if(!thrownby)
		return
	return ..()

/obj/item/clothing/glasses/sunglasses/gar/supergar
	name = "giga gar glasses"
	desc = "We evolve past the person we were a minute before. Little by little we advance with each turn. That's how a drill works!"
	icon_state = "supergar"
	inhand_icon_state = "gar"
	force = 35
	force_wielded = 45
	force_unwielded = 35
	throwforce = 25
	throw_speed = 4
	sharpness = SHARP_EDGED
	glass_colour_type = /datum/client_colour/glass_colour/red
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10
/obj/item/clothing/glasses/sunglasses/stunglasses
	name = "stunglasses"
	desc = "Sunglasses with inbuilt flashes. Made for those who prefer to walk around in style, who needs clumsy flashes anyway?"
	actions_types = list(/datum/action/item_action/flash)
	var/obj/item/assembly/flash/installed

/obj/item/clothing/glasses/sunglasses/stunglasses/Initialize()
	. = ..()
	if (!installed)
		installed = new(src)

/obj/item/clothing/glasses/sunglasses/stunglasses/ui_action_click(mob/user)
	if (installed && !installed.crit_fail)
		installed.attack_self(user)
	else
		to_chat(user, "<span class = 'danger'>Install a new flash in [src]!</span>")

/obj/item/clothing/glasses/sunglasses/stunglasses/attackby(obj/item/W,mob/user)
	if (istype(W,/obj/item/screwdriver))
		if (installed)
			installed.forceMove(get_turf(src))
			to_chat(user, "<span class = 'notice'>You remove [installed] from [src].</span>")
			installed = null
	if (istype(W,/obj/item/assembly/flash))
		if (!installed)
			W.forceMove(src)
			to_chat(user, "<span class = 'notice'>You install [W] into [src].</span>")
			installed = W
	. = ..()

/obj/item/clothing/glasses/welding
	name = "welding goggles"
	desc = "Protects the eyes from welders; approved by the mad scientist association."
	icon_state = "welding-g"
	inhand_icon_state = "welding-g"
	actions_types = list(/datum/action/item_action/toggle)
	custom_materials = list(/datum/material/iron = 250)
	flash_protect = 2
	tint = 2
	visor_vars_to_toggle = VISOR_FLASHPROTECT | VISOR_TINT
	flags_cover = GLASSESCOVERSEYES
	visor_flags_inv = HIDEEYES
	glass_colour_type = /datum/client_colour/glass_colour/gray

/obj/item/clothing/glasses/welding/attack_self(mob/user)
	weldingvisortoggle(user)


/obj/item/clothing/glasses/sunglasses/blindfold
	name = "blindfold"
	desc = "Covers the eyes, preventing sight."
	icon_state = "blindfold"
	inhand_icon_state = "blindfold"
	flash_protect = 2
	tint = 3			// to make them blind

/obj/item/clothing/glasses/sunglasses/blindfold/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot == SLOT_GLASSES)
		user.become_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/sunglasses/blindfold/dropped(mob/living/carbon/human/user)
	..()
	user.cure_blind("blindfold_[REF(src)]")

/obj/item/clothing/glasses/fakeblindfold
	name = "thin blindfold"
	desc = "Covers the eyes, but not thick enough to obscure vision. Mostly for aesthetic."
	icon_state = "blindfoldwhite"
	inhand_icon_state = "blindfoldwhite"

/obj/item/clothing/glasses/sunglasses/blindfold/white
	name = "blind personnel blindfold"
	desc = "Indicates that the wearer suffers from blindness."
	icon_state = "blindfoldwhite"
	inhand_icon_state = "blindfoldwhite"
	var/colored_before = FALSE

/obj/item/clothing/glasses/sunglasses/blindfold/white/equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && slot == SLOT_GLASSES)
		update_icon(user)
		user.update_inv_glasses() //Color might have been changed by update_icon.
	..()

/obj/item/clothing/glasses/sunglasses/blindfold/white/update_icon(mob/living/carbon/human/user)
	if(ishuman(user) && !colored_before)
		add_atom_colour("#[user.left_eye_color]", FIXED_COLOUR_PRIORITY)
		colored_before = TRUE

/obj/item/clothing/glasses/sunglasses/blindfold/white/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands && ishuman(loc) && !colored_before)
		var/mob/living/carbon/human/H = loc
		var/mutable_appearance/M = mutable_appearance('icons/mob/clothing/eyes.dmi', "blindfoldwhite")
		M.appearance_flags |= RESET_COLOR
		M.color = "#[H.left_eye_color]"
		. += M

/obj/item/clothing/glasses/sunglasses/big
	desc = "Strangely ancient technology used to help provide rudimentary eye cover. Larger than average enhanced shielding blocks flashes."
	icon_state = "bigsunglasses"
	inhand_icon_state = "bigsunglasses"

/obj/item/clothing/glasses/thermal
	name = "optical thermal scanner"
	desc = "Thermals in the shape of glasses."
	icon_state = "thermal"
	inhand_icon_state = "glasses"
	vision_flags = SEE_MOBS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	flash_protect = 0
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/thermal/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	thermal_overload()

/obj/item/clothing/glasses/thermal/syndi	//These are now a traitor item, concealed as mesons.	-Pete
	name = "chameleon thermals"
	desc = "A pair of thermal optic goggles with an onboard chameleon generator."
	flash_protect = -1

	var/datum/action/item_action/chameleon/change/chameleon_action

/obj/item/clothing/glasses/thermal/syndi/New()
	..()
	chameleon_action = new(src)
	chameleon_action.chameleon_type = /obj/item/clothing/glasses
	chameleon_action.chameleon_name = "Glasses"
	chameleon_action.chameleon_blacklist = typecacheof(/obj/item/clothing/glasses/changeling, only_root_path = TRUE)
	chameleon_action.initialize_disguises()

/obj/item/clothing/glasses/thermal/syndi/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	chameleon_action.emp_randomise()

/obj/item/clothing/glasses/thermal/monocle
	name = "thermoncle"
	desc = "Never before has seeing through walls felt so gentlepersonly."
	icon_state = "thermoncle"
	flags_1 = null //doesn't protect eyes because it's a monocle, duh

/obj/item/clothing/glasses/thermal/monocle/examine(mob/user) //Different examiners see a different description!
	var/desk = desc
	if(user.gender == MALE)
		desc = replacetext(desc, "person", "man")
	else if(user.gender == FEMALE)
		desc = replacetext(desc, "person", "woman")
	. = ..()
	desc = desk

/obj/item/clothing/glasses/thermal/eyepatch
	name = "optical thermal eyepatch"
	desc = "An eyepatch with built-in thermal optics."
	icon_state = "eyepatch"
	inhand_icon_state = "eyepatch"

/obj/item/clothing/glasses/cold
	name = "cold goggles"
	desc = "A pair of goggles meant for low temperatures."
	icon_state = "cold"
	inhand_icon_state = "cold"

/obj/item/clothing/glasses/heat
	name = "heat goggles"
	desc = "A pair of goggles meant for high temperatures."
	icon_state = "heat"
	inhand_icon_state = "heat"

/obj/item/clothing/glasses/orange
	name = "orange glasses"
	desc = "A sweet pair of orange shades."
	icon_state = "orangeglasses"
	inhand_icon_state = "orangeglasses"
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

/obj/item/clothing/glasses/red
	name = "red glasses"
	desc = "Hey, you're looking good, senpai!"
	icon_state = "redglasses"
	inhand_icon_state = "redglasses"
	glass_colour_type = /datum/client_colour/glass_colour/red

/obj/item/clothing/glasses/godeye
	name = "eye of god"
	desc = "A strange eye, said to have been torn from an omniscient creature that used to roam the wastes."
	icon_state = "godeye"
	inhand_icon_state = "godeye"
	vision_flags = SEE_TURFS|SEE_MOBS|SEE_OBJS
	darkness_view = 24
	clothing_flags = SCAN_REAGENTS
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/item/clothing/glasses/godeye/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, EYE_OF_GOD_TRAIT)

/obj/item/clothing/glasses/godeye/attackby(obj/item/W as obj, mob/user as mob, params)
	if(istype(W, src) && W != src && W.loc == user)
		if(W.icon_state == "godeye")
			W.icon_state = "doublegodeye"
			W.inhand_icon_state = "doublegodeye"
			W.desc = "A pair of strange eyes, said to have been torn from an omniscient creature that used to roam the wastes. There's no real reason to have two, but that isn't stopping you."
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.update_inv_wear_mask()
		else
			to_chat(user, span_notice("The eye winks at you and vanishes into the abyss, you feel really unlucky."))
		qdel(src)
	..()

/obj/item/clothing/glasses/AltClick(mob/user)
	. = ..()
	if(glass_colour_type && ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.client?.prefs && src == H.glasses)
			H.client.prefs.uses_glasses_colour = !H.client.prefs.uses_glasses_colour
			if(H.client.prefs.uses_glasses_colour)
				to_chat(H, "You will now see glasses colors.")
			else
				to_chat(H, "You will no longer see glasses colors.")
			H.update_glasses_color(src, 1)
		return TRUE

/obj/item/clothing/glasses/proc/change_glass_color(mob/living/carbon/human/H, datum/client_colour/glass_colour/new_color_type)
	var/old_colour_type = glass_colour_type
	if(!new_color_type || ispath(new_color_type)) //the new glass colour type must be null or a path.
		glass_colour_type = new_color_type
		if(H && H.glasses == src)
			if(old_colour_type)
				H.remove_client_colour(old_colour_type)
			if(glass_colour_type)
				H.update_glasses_color(src, 1)


/mob/living/carbon/human/proc/update_glasses_color(obj/item/clothing/glasses/G, glasses_equipped)
	if(client && client.prefs.uses_glasses_colour && glasses_equipped)
		add_client_colour(G.glass_colour_type)
	else
		remove_client_colour(G.glass_colour_type)

/obj/item/clothing/glasses/sunglasses/reagent
	name = "beer goggles"
	icon_state = "sunhudbeer"
	inhand_icon_state = "sunhudbeer"
	desc = "A pair of sunglasses outfitted with apparatus to scan reagents, as well as providing an innate understanding of liquid viscosity while in motion."
	clothing_flags = SCAN_REAGENTS

/obj/item/clothing/glasses/sunglasses/chemical
	name = "science glasses"
	icon_state = "sunhudsci"
	inhand_icon_state = "sunhudsci"
	desc = "A pair of tacky purple sunglasses that allow the wearer to recognize various chemical compounds with only a glance."
	clothing_flags = SCAN_REAGENTS

/obj/item/clothing/glasses/geist_gazers
	name = "geist gazers"
	icon_state = "geist_gazers"
	inhand_icon_state = "geist_gazers"
	glass_colour_type = /datum/client_colour/glass_colour/green

/* /obj/item/clothing/glasses/psych // commented out because someone deleted the psych glasses hand sprite
	name = "psych glasses"
	icon_state = "psych_glasses"
	inhand_icon_state = "psych_glasses"
	glass_colour_type = /datum/client_colour/glass_colour/red */

/obj/item/clothing/glasses/debug
	name = "debug glasses"
	desc = "Medical, security and diagnostic hud. Alt click to toggle xray."
	icon_state = "nvgmeson"
	inhand_icon_state = "nvgmeson"
	flags_cover = GLASSESCOVERSEYES
	darkness_view = 24
	flash_protect = 2
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	glass_colour_type = FALSE
	clothing_flags = SCAN_REAGENTS
	vision_flags = SEE_TURFS
	var/list/hudlist = list(DATA_HUD_MEDICAL_ADVANCED, DATA_HUD_DIAGNOSTIC_ADVANCED, DATA_HUD_SECURITY_ADVANCED)
	var/xray = FALSE

/obj/item/clothing/glasses/debug/equipped(mob/user, slot)
	. = ..()
	if(slot != INV_SLOTBIT_EYES)
		return
	if(ishuman(user))
		for(var/hud in hudlist)
			var/datum/atom_hud/H = GLOB.huds[hud]
			H.add_hud_to(user)

/obj/item/clothing/glasses/debug/dropped(mob/user)
	. = ..()
	if(ishuman(user))
		for(var/hud in hudlist)
			var/datum/atom_hud/H = GLOB.huds[hud]
			H.remove_hud_from(user)

/obj/item/clothing/glasses/debug/AltClick(mob/user)
	. = ..()
	if(ishuman(user))
		if(xray)
			vision_flags -= SEE_MOBS|SEE_OBJS
		else
			vision_flags += SEE_MOBS|SEE_OBJS
		xray = !xray
		var/mob/living/carbon/human/H = user
		H.update_sight()

/obj/item/clothing/glasses/sunglasses/fakeblindfold
	name = "priestess blindfold"
	desc = "The coverings used to restrict the sight of the world, but see with the Sight of Mars."
	icon_state = "legpriestess"
	inhand_icon_state = "legpriestess"

/obj/item/clothing/glasses/sunglasses/fakeblindfold/equipped(mob/living/user, slot)
	..()
	if(ishuman(user))
		var/mob/living/carbon/human/U = user
		if(U.job in list("Priestess of Mars"))
		else
			to_chat(user, span_userdanger("\"You want to be blind, do you?\""))
			user.dropItemToGround(src, TRUE)
			user.Dizzy(30)
			user.Knockdown(100)
			user.blind_eyes(30)
		return

// Prescription variants for Bayou

/obj/item/clothing/glasses/geist_gazers/upgr
	name = "prescription geist gazers"
	vision_correction = 1

/obj/item/clothing/glasses/psych/upgr
	name = "prescription pysch glasses"
	vision_correction = 1

/obj/item/clothing/glasses/f13/biker/upgr
	name = "prescription biker goggles"
	vision_correction = 1

/obj/item/clothing/glasses/legiongoggles/upgr
	name = "prescription sandstorm goggles"
	vision_correction = 1

/obj/item/clothing/glasses/regular/hipster/upgr
	name = "prescription hipster glasses"
	vision_correction = 1

/obj/item/clothing/glasses/regular/jamjar/upgr
	name = "prescription jamjar glasses"
	vision_correction = 1

/obj/item/clothing/glasses/regular/circle/upgr
	name = "prescription circle glasses"
	vision_correction = 1

/obj/item/clothing/glasses/orange/upgr
	name = "prescription orange glasses"
	vision_correction = 1

/obj/item/clothing/glasses/red/upgr
	name = "prescription red glasses"
	vision_correction = 1

/obj/item/clothing/glasses/heat/upgr
	name = "prescription heat goggles"
	vision_correction = 1

/obj/item/clothing/glasses/cold/upgr
	name = "prescription cold goggles"
	vision_correction = 1

