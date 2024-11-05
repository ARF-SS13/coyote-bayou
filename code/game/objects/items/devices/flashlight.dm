/obj/item/flashlight
	name = "flashlight"
	desc = "A hand-held emergency light. Comes with a robust lanyard and set of clips for hands-free use. Neat!"
	custom_price = PRICE_REALLY_CHEAP
	icon = 'icons/obj/lighting.dmi'
	icon_state = "flashlight"
	inhand_icon_state = "flashlight"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	custom_materials = list(/datum/material/iron=50, /datum/material/glass=20)
	actions_types = list(/datum/action/item_action/toggle_light)
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 6
	light_power = 1
	light_color = "#CDDDFF"
	light_on = FALSE
	var/on = FALSE

/obj/item/flashlight/Initialize()
	. = ..()
	if(icon_state == "[initial(icon_state)]-on")
		on = TRUE
	update_brightness()

/obj/item/flashlight/proc/update_brightness(mob/user)
	if(on)
		icon_state = "[initial(icon_state)]-on"
	else
		icon_state = initial(icon_state)
	set_light_on(on)
	if(light_system == STATIC_LIGHT)
		update_light()

/obj/item/flashlight/attack_self(mob/user)
	on = !on
	update_brightness(user)
	playsound(user, on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, 1)
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()
	return 1

/obj/item/flashlight/attack(mob/living/carbon/M, mob/living/carbon/human/user)
	add_fingerprint(user)
	if(istype(M) && on && (user.zone_selected in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH)))

		if((HAS_TRAIT(user, TRAIT_CLUMSY) || HAS_TRAIT(user, TRAIT_DUMB)) && prob(50))	//too dumb to use flashlight properly
			return ..()	//just hit them in the head

		if(!user.IsAdvancedToolUser())
			to_chat(user, span_warning("You don't have the dexterity to do this!"))
			return

		if(!M.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[M] doesn't have a head!"))
			return

		if(light_power < 1)
			to_chat(user, "<span class='warning'>\The [src] isn't bright enough to see anything!</span> ")
			return

		switch(user.zone_selected)
			if(BODY_ZONE_PRECISE_EYES)
				if((M.head && M.head.flags_cover & HEADCOVERSEYES) || (M.wear_mask && M.wear_mask.flags_cover & MASKCOVERSEYES) || (M.glasses && M.glasses.flags_cover & GLASSESCOVERSEYES))
					to_chat(user, span_notice("You're going to need to remove that [(M.head && M.head.flags_cover & HEADCOVERSEYES) ? "helmet" : (M.wear_mask && M.wear_mask.flags_cover & MASKCOVERSEYES) ? "mask": "glasses"] first."))
					return

				var/obj/item/organ/eyes/E = M.getorganslot(ORGAN_SLOT_EYES)
				if(!E)
					to_chat(user, span_danger("[M] doesn't have any eyes!"))
					return

				if(M == user)	//they're using it on themselves
					if(M.flash_act(visual = 1))
						M.visible_message("[M] directs [src] to [M.p_their()] eyes.", span_notice("You wave the light in front of your eyes! Trippy!"))
					else
						M.visible_message("[M] directs [src] to [M.p_their()] eyes.", span_notice("You wave the light in front of your eyes."))
				else
					user.visible_message(span_warning("[user] directs [src] to [M]'s eyes."), \
										span_danger("You direct [src] to [M]'s eyes."))
					if(M.stat == DEAD || (HAS_TRAIT(M, TRAIT_BLIND)) || !M.flash_act(visual = 1)) //mob is dead or fully blind
						to_chat(user, span_warning("[M]'s pupils don't react to the light!"))
					else if(M.dna && M.dna.check_mutation(XRAY))	//mob has X-ray vision
						to_chat(user, span_danger("[M]'s pupils give an eerie glow!"))
					else //they're okay!
						to_chat(user, span_notice("[M]'s pupils narrow."))

			if(BODY_ZONE_PRECISE_MOUTH)

				if(M.is_mouth_covered())
					to_chat(user, span_notice("You're going to need to remove that [(M.head && M.head.flags_cover & HEADCOVERSMOUTH) ? "helmet" : "mask"] first."))
					return

				var/their = M.p_their()

				var/list/mouth_organs = new
				for(var/obj/item/organ/O in M.internal_organs)
					if(O.zone == BODY_ZONE_PRECISE_MOUTH)
						mouth_organs.Add(O)
				var/organ_list = ""
				var/organ_count = LAZYLEN(mouth_organs)
				if(organ_count)
					for(var/I in 1 to organ_count)
						if(I > 1)
							if(I == mouth_organs.len)
								organ_list += ", and "
							else
								organ_list += ", "
						var/obj/item/organ/O = mouth_organs[I]
						organ_list += (O.gender == "plural" ? O.name : "\an [O.name]")

				var/pill_count = 0
				for(var/datum/action/item_action/hands_free/activate_pill/AP in M.actions)
					pill_count++

				if(M == user)
					var/can_use_mirror = FALSE
					if(isturf(user.loc))
						var/obj/structure/mirror/mirror = locate(/obj/structure/mirror, user.loc)
						if(mirror)
							switch(user.dir)
								if(NORTH)
									can_use_mirror = mirror.pixel_y > 0
								if(SOUTH)
									can_use_mirror = mirror.pixel_y < 0
								if(EAST)
									can_use_mirror = mirror.pixel_x > 0
								if(WEST)
									can_use_mirror = mirror.pixel_x < 0

					M.visible_message("[M] directs [src] to [their] mouth.", \
					span_notice("You point [src] into your mouth."))
					if(!can_use_mirror)
						to_chat(user, span_notice("You can't see anything without a mirror."))
						return
					if(organ_count)
						to_chat(user, span_notice("Inside your mouth [organ_count > 1 ? "are" : "is"] [organ_list]."))
					else
						to_chat(user, span_notice("There's nothing inside your mouth."))
					if(pill_count)
						to_chat(user, span_notice("You have [pill_count] implanted pill[pill_count > 1 ? "s" : ""]."))

				else
					user.visible_message(span_notice("[user] directs [src] to [M]'s mouth."),\
										span_notice("You direct [src] to [M]'s mouth."))
					if(organ_count)
						to_chat(user, span_notice("Inside [their] mouth [organ_count > 1 ? "are" : "is"] [organ_list]."))
					else
						to_chat(user, span_notice("[M] doesn't have any organs in [their] mouth."))
					if(pill_count)
						to_chat(user, span_notice("[M] has [pill_count] pill[pill_count > 1 ? "s" : ""] implanted in [their] teeth."))

	else
		return ..()

/obj/item/flashlight/pen
	name = "penlight"
	desc = "A pen-sized light, used by medical staff. It can also be used to create a hologram to alert people of incoming medical assistance. Comes with a handy necklace and bite-resistant coating for hands-free use. Try not to swallow it."
	icon_state = "penlight"
	inhand_icon_state = ""
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK | INV_SLOTBIT_MASK
	flags_1 = CONDUCT_1
	light_range = 3
	light_color = "#FFDDCC"
	var/holo_cooldown = 0

/obj/item/flashlight/pen/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!proximity_flag)
		if(holo_cooldown > world.time)
			to_chat(user, span_warning("[src] is not ready yet!"))
			return
		var/T = get_turf(target)
		if(locate(/mob/living) in T)
			new /obj/effect/temp_visual/medical_holosign(T,user) //produce a holographic glow
			holo_cooldown = world.time + 10 SECONDS
			return

// see: [/datum/wound/burn/proc/uv()]
/obj/item/flashlight/pen/paramedic
	name = "paramedic penlight"
	desc = "A high-powered UV penlight intended to help stave off infection in the field on serious burned patients. Probably really bad to look into. Comes with a rubberized coating for 'that comfy mouth-feel'."
	icon_state = "penlight_surgical"
	/// Our current UV cooldown
	var/uv_cooldown = 0
	/// How long between UV fryings
	var/uv_cooldown_length = 1 MINUTES
	/// How much sanitization to apply to the burn wound
	var/uv_power = 1

/obj/effect/temp_visual/medical_holosign
	name = "medical holosign"
	desc = "A small holographic glow that indicates a medic is coming to treat a patient."
	icon_state = "medi_holo"
	duration = 30
	var/sounding = TRUE

/obj/effect/temp_visual/medical_holosign/Initialize(mapload, creator)
	. = ..()
	if(sounding)
		playsound(loc, 'sound/machines/ping.ogg', 50, 0) //make some noise!
		if(creator)
			visible_message(span_danger("[creator] created a medical hologram!"))

/obj/effect/temp_visual/medical_holosign/silent
	sounding = FALSE

/obj/item/flashlight/seclite
	name = "seclite"
	desc = "A Seclite brand flashlight. Despite being made to be worn in a belt or attached to certain rifles, it looks robust enough to crack some skulls."
	icon_state = "seclite"
	inhand_icon_state = "seclite"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	force = 30 // Barely more than a bootknife. Makes for a quicker club if you don't stick it to something.
	light_range = 9 // A little better than the standard flashlight.
	light_color = "#CDDDFF"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	hitsound = 'sound/weapons/genhit1.ogg'
	custom_price = PRICE_ALMOST_CHEAP

/obj/item/flashlight/blue
	name = "Blue Flashlight"
	desc = "A good quality plastic flashlight."
	icon_state = "flashlight_blue"
	inhand_icon_state = "flashlight"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	light_range = 7 // A little better than the standard flashlight.
	light_color = "#CDDDFF"
	hitsound = 'sound/weapons/genhit1.ogg'
	custom_price = PRICE_ALMOST_CHEAP

// the desk lamps are a bit special
/obj/item/flashlight/lamp
	name = "desk lamp"
	desc = "A desk lamp with an adjustable mount."
	icon_state = "lamp"
	inhand_icon_state = "lamp"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 10
	light_range = 7
	light_color = "#FFDDBB"
	light_system = STATIC_LIGHT
	light_on = TRUE
	slot_flags = INV_SLOTBIT_BELT // Big and heavy!
	on = TRUE
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	custom_materials = null

// green-shaded desk lamp
/obj/item/flashlight/lamp/green
	desc = "A classic green-shaded desk lamp."
	icon_state = "lampgreen"
	inhand_icon_state = "lampgreen"

/obj/item/flashlight/lamp/verb/toggle_light()
	set name = "Toggle light"
	set category = "Object"
	set src in oview(1)

	if(!usr.stat)
		attack_self(usr)

//Bananalamp
/obj/item/flashlight/lamp/bananalamp
	name = "banana lamp"
	desc = "Only a clown would think to make a ghetto banana-shaped lamp. Even has a goofy pullstring."
	icon_state = "bananalamp"
	inhand_icon_state = "bananalamp"

// FLARES

/obj/item/flashlight/flare
	name = "flare"
	desc = "A red emergency flare. There are instructions on the side, it reads 'pull cord, make light'."
	icon = 'icons/fallout/objects/lamps.dmi'
	w_class = WEIGHT_CLASS_TINY
	light_system = MOVABLE_LIGHT
	light_range = 6 // Pretty bright.
	light_color = LIGHT_COLOR_FLARE
	total_mass = 0.8
	icon_state = "flare"
	inhand_icon_state = "flare"
	actions_types = list()
	slot_flags = INV_SLOTBIT_BELT // its a little hot for your neck
	//var/fuel = 0
	var/on_damage = 30
	var/produce_heat = 1500
	heat = 1000
	grind_results = list(/datum/reagent/sulfur = 15)

/obj/item/flashlight/flare/New()
	//fuel = rand(800, 1000) // Sorry for changing this so much but I keep under-estimating how long X number of ticks last in seconds.
	..()

/obj/item/flashlight/flare/process()
	open_flame(heat)
	//fuel = max(fuel - 1, 0)
	//if(!fuel || !on)
	//	turn_off()
	//	if(!fuel)
	//		icon_state = "[initial(icon_state)]-empty"
	//	STOP_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/ignition_effect(atom/A, mob/user)
	if(on)	//fuel &&
		. = "<span class='notice'>[user] lights [A] with [src] like a real \
			badass.</span>"
	else
		. = ""

/obj/item/flashlight/flare/proc/turn_off()
	on = FALSE
	force = initial(src.force)
	damtype = initial(src.damtype)
	if(ismob(loc))
		var/mob/U = loc
		update_brightness(U)
	else
		update_brightness(null)

/obj/item/flashlight/flare/update_brightness(mob/user = null)
	..()
	if(on)
		inhand_icon_state = "[initial(inhand_icon_state)]-on"
	else
		inhand_icon_state = "[initial(inhand_icon_state)]"

/obj/item/flashlight/flare/attack_self(mob/user)

	// Usual checks
	//if(!fuel)
	//	to_chat(user, span_warning("[src] is out of fuel!"))
	//	return
	if(on)
		to_chat(user, span_notice("[src] is already on."))
		return

	. = ..()
	// All good, turn it on.
	if(.)
		user.visible_message(span_notice("[user] lights \the [src]."), span_notice("You light \the [src]!"))
		playsound(loc, 'sound/effects/flare_light.ogg', 50, 0)
		force = on_damage
		damtype = "fire"
		START_PROCESSING(SSobj, src)

/obj/item/flashlight/flare/get_temperature()
	return on * heat

/obj/item/flashlight/flare/torch
	name = "torch"
	desc = "A self-lighting handheld torch fashioned from some cloth wrapped around a wooden handle. It could probably fit in a backpack while it isn't burning."
	icon = 'icons/obj/lighting.dmi'
	w_class = WEIGHT_CLASS_SMALL // Sure stuff it in your pocket
	light_range = 6
	light_color = LIGHT_COLOR_ORANGE
	icon_state = "torch"
	inhand_icon_state = "torch"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	total_mass = TOTAL_MASS_NORMAL_ITEM
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	on_damage = 30

/obj/item/flashlight/flare/torch/attack_self(mob/user)
	// Usual checks
	//if(!fuel)
	//	to_chat(user, span_warning("[src] is out of fuel!"))
	//	return
	if(on)
		to_chat(user, span_notice("[src] is already lit."))
		return
	// All good, turn it on.
	else
		user.visible_message(span_notice("[user] lights [src]."), span_notice("You light [src]!"))
		playsound(loc, 'sound/effects/torch_light.ogg', 50, 0)
		force = on_damage
		damtype = BURN
		//w_class = WEIGHT_CLASS_BULKY
		desc = "A handheld wooden torch that's slowly burning away."
		START_PROCESSING(SSobj, src)
		on = !on
		update_brightness(user)
		for(var/X in actions)
			var/datum/action/A = X
			A.UpdateButtonIcon()
		return TRUE

/obj/item/flashlight/lantern
	name = "lantern"
	icon_state = "lantern"
	inhand_icon_state = "lantern"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 15 // Just some kind of damage because lanterns are heavy. Gonna be in your belt or pocket anyway, now it's not totally useless if you accidentally grab it to smash a roach.
	desc = "While not the brightest, lanterns like these light up a large area. Good for exploration, or just making do when the lights go out. Might make do as a bludgeon if you were really desperate."
	light_system = MOVABLE_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	light_range = 9	// luminosity when on
	light_color = LIGHT_COLOR_ORANGE
	custom_price = PRICE_CHEAP

/obj/item/flashlight/lantern/dim //to replace the 426 mapped in lanterns
	name = "dim lantern"
	desc = "An old lantern, who's flickering wick has dimmed with age."
	light_range = 6

/obj/item/flashlight/lantern/mining
	name = "prospector lamp"
	icon_state = "prospector_lamp"
	inhand_icon_state = "lantern"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 15 // Just some kind of damage because lanterns are heavy. Gonna be in your belt or pocket anyway, now it's not totally useless if you accidentally grab it to smash a roach.
	desc = "A small oil lamp, made to hang on the belt or strap onto a harness, for lighting up cramped caves and dark nights."
	light_system = MOVABLE_LIGHT
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	light_range = 7	// luminosity when on
	light_color = LIGHT_COLOR_ORANGE
	custom_price = PRICE_CHEAP

/obj/item/flashlight/lantern/jade
	name = "jade lantern"
	desc = "An ornate, green lantern."
	color = LIGHT_COLOR_GREEN
	light_color = LIGHT_COLOR_GREEN

/obj/item/flashlight/slime
	gender = PLURAL
	name = "glowing slime extract"
	desc = "Extract from a yellow slime. It emits a strong light when squeezed."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "slime"
	inhand_icon_state = "slime"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT
	custom_materials = null
	light_system = MOVABLE_LIGHT
	light_range = 9 //luminosity when on
	light_color = "#FFEEAA"

/obj/item/flashlight/emp
	var/emp_max_charges = 4
	var/emp_cur_charges = 4
	var/charge_tick = 0

/obj/item/flashlight/emp/New()
	..()
	START_PROCESSING(SSobj, src)

/obj/item/flashlight/emp/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/flashlight/emp/process()
	charge_tick++
	if(charge_tick < 10)
		return FALSE
	charge_tick = 0
	emp_cur_charges = min(emp_cur_charges+1, emp_max_charges)
	return TRUE

/obj/item/flashlight/emp/attack(mob/living/M, mob/living/user)
	if(on && (user.zone_selected in list(BODY_ZONE_PRECISE_EYES, BODY_ZONE_PRECISE_MOUTH))) // call original attack when examining organs
		..()
	return

/obj/item/flashlight/emp/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(emp_cur_charges > 0)
		emp_cur_charges -= 1

		if(ismob(A))
			var/mob/M = A
			log_combat(user, M, "attacked", "EMP-light")
			M.visible_message("<span class='danger'>[user] blinks \the [src] at \the [A].", \
								"<span class='userdanger'>[user] blinks \the [src] at you.")
		else
			A.visible_message("<span class='danger'>[user] blinks \the [src] at \the [A].")
		to_chat(user, "\The [src] now has [emp_cur_charges] charge\s.")
		A.emp_act(80)
	else
		to_chat(user, span_warning("\The [src] needs time to recharge!"))
	return

/obj/item/flashlight/emp/debug //for testing emp_act()
	name = "debug EMP flashlight"
	emp_max_charges = 100
	emp_cur_charges = 100

// Glowsticks, in the uncomfortable range of similar to flares,
// but not similar enough to make it worth a refactor
/obj/item/flashlight/glowstick
	name = "glowstick"
	desc = "A military-grade glowstick. Has a long lanyard that should fit around someone's neck."
	custom_price = PRICE_CHEAP_AS_FREE
	w_class = WEIGHT_CLASS_TINY
	light_system = MOVABLE_LIGHT
	light_range = 6
	color = LIGHT_COLOR_GREEN
	icon_state = "glowstick"
	inhand_icon_state = "glowstick"
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_NECK
	grind_results = list(/datum/reagent/phenol = 15, /datum/reagent/hydrogen = 10, /datum/reagent/oxygen = 5) //Meth-in-a-stick
	rad_flags = RAD_NO_CONTAMINATE
	//var/fuel = 0

/obj/item/flashlight/glowstick/Initialize()
	//fuel = rand(1000, 1500)
	light_color = color
	. = ..()

/obj/item/flashlight/glowstick/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/flashlight/glowstick/process()
	//fuel = max(fuel - 1, 0)
	//if(!fuel)
	//	turn_off()
	//	STOP_PROCESSING(SSobj, src)
	//	update_icon()

/obj/item/flashlight/glowstick/proc/turn_off()
	on = FALSE
	set_light_on(FALSE)
	update_icon()

/obj/item/flashlight/glowstick/update_icon_state()
	inhand_icon_state = "glowstick"
	cut_overlays()
	//if(!fuel)
	//	icon_state = "glowstick-empty"
	//	cut_overlays()
	if(on)	//else if
		var/mutable_appearance/glowstick_overlay = mutable_appearance(icon, "glowstick-glow")
		glowstick_overlay.color = color
		add_overlay(glowstick_overlay)
		inhand_icon_state = "glowstick-on"
	else
		icon_state = "glowstick"
		cut_overlays()

/obj/item/flashlight/glowstick/attack_self(mob/user)
	//if(!fuel)
	//	to_chat(user, span_notice("[src] is spent."))
	//	return
	if(on)
		to_chat(user, span_notice("[src] is already lit."))
		return

	. = ..()
	if(.)
		user.visible_message(span_notice("[user] cracks and shakes [src]."), span_notice("You crack and shake [src], turning it on!"))
		activate()

/obj/item/flashlight/glowstick/proc/activate()
	if(!on)
		on = TRUE
		set_light_on(TRUE)
		START_PROCESSING(SSobj, src)

/obj/item/flashlight/glowstick/red
	name = "red glowstick"
	color = LIGHT_COLOR_RED

/obj/item/flashlight/glowstick/blue
	name = "blue glowstick"
	color = LIGHT_COLOR_BLUE

/obj/item/flashlight/glowstick/cyan
	name = "cyan glowstick"
	color = LIGHT_COLOR_CYAN

/obj/item/flashlight/glowstick/orange
	name = "orange glowstick"
	color = LIGHT_COLOR_ORANGE

/obj/item/flashlight/glowstick/yellow
	name = "yellow glowstick"
	color = LIGHT_COLOR_YELLOW

/obj/item/flashlight/glowstick/pink
	name = "pink glowstick"
	color = LIGHT_COLOR_PINK

/obj/item/flashlight/spotlight //invisible lighting source
	name = "disco light"
	desc = "Groovy..."
	icon_state = null
	light_color = null
	light_system = MOVABLE_LIGHT
	light_range = 6
	light_power = 10
	light_on = TRUE
	on = TRUE
	alpha = 0
	layer = 0
	anchored = TRUE
	var/range = null
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/item/flashlight/flashdark
	name = "flashdark"
	desc = "A strange device manufactured with mysterious elements that somehow emits darkness. Or maybe it just sucks in light? Nobody knows for sure."
	icon_state = "flashdark"
	inhand_icon_state = "flashdark"
	light_system = STATIC_LIGHT //The overlay light component is not yet ready to produce darkness.
	light_range = 0
	///Variable to preserve old lighting behavior in flashlights, to handle darkness.
	var/dark_light_range = 2.5
	///Variable to preserve old lighting behavior in flashlights, to handle darkness.
	var/dark_light_power = -3

/obj/item/flashlight/flashdark/update_brightness(mob/user)
	. = ..()
	if(on)
		set_light(dark_light_range, dark_light_power)
	else
		set_light(0)

/obj/item/flashlight/eyelight
	name = "eyelight"
	desc = "This shouldn't exist outside of someone's head, how are you seeing this?"
	light_system = MOVABLE_LIGHT
	light_range = 10
	flags_1 = CONDUCT_1
	item_flags = DROPDEL
	actions_types = list()

/obj/item/flashlight/littlelamp
	name = "Little Lamp"
	icon_state = "littlelamp"
	inhand_icon_state = "littlelamp"

/obj/item/flashlight/oldlamp
	name = "Old Lamp"
	icon_state = "oldlamp"
	inhand_icon_state = "oldlamp"
