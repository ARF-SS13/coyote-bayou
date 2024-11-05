/obj/item/compressionkit
	name = "bluespace compression kit"
	desc = "An illegally modified BSRPED, capable of reducing the size of most items."
	icon = 'icons/obj/tools.dmi'
	icon_state = "compression_c"
	inhand_icon_state = "RPED"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	var/charges = 5
	// var/damage_multiplier = 0.2 Not in use yet.
	var/mode = 0

/obj/item/compressionkit/examine(mob/user)
	. = ..()
	. += span_notice("It has [charges] charges left. Recharge with bluespace crystals.")
	. += span_notice("Use in-hand to swap toggle compress/expand mode (expand mode not yet implemented).")

/obj/item/compressionkit/attack_self(mob/user)
	if(mode == 0)
		mode = 1
		icon_state = "compression_e"
		to_chat(user, span_notice("You switch the compressor to expand mode. This isn't implemented yet, so right now it wont do anything different!"))
		return
	if(mode == 1)
		mode = 0
		icon_state = "compression_c"
		to_chat(user, span_notice("You switch the compressor to compress mode. Usage will now reduce the size of objects."))
		return
	else
		mode = 0
		icon_state = "compression_c"
		to_chat(user, span_notice("Some coder cocked up or an admin broke your compressor. It's been set back to compress mode.."))

/obj/item/compressionkit/proc/sparks()
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(5, 1, get_turf(src))
	s.start()

/obj/item/compressionkit/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !target)
		return
	else
		if(charges == 0)
			playsound(get_turf(src), 'sound/machines/buzz-two.ogg', 50, 1)
			to_chat(user, span_notice("The bluespace compression kit is out of charges! Recharge it with bluespace crystals."))
			return
	if(istype(target, /obj/item))
		var/obj/item/O = target
		if(O.w_class == 1)
			playsound(get_turf(src), 'sound/machines/buzz-two.ogg', 50, 1)
			to_chat(user, span_notice("[target] cannot be compressed smaller!."))
			return
		if(O.GetComponent(/datum/component/storage))
			to_chat(user, span_notice("You feel like compressing an item that stores other items would be counterproductive."))
			return
		if(O.w_class > 1)
			playsound(get_turf(src), 'sound/weapons/flash.ogg', 50, 1)
			user.visible_message(span_warning("[user] is compressing [O] with their bluespace compression kit!"))
			if(do_mob(user, O, 40) && charges > 0 && O.w_class > 1)
				playsound(get_turf(src), 'sound/weapons/emitter2.ogg', 50, 1)
				sparks()
				flash_lighting_fx(3, 3, LIGHT_COLOR_CYAN)
				O.w_class -= 1
				// O.force_mult -= damage_multiplier
				charges -= 1
				to_chat(user, span_notice("You successfully compress [target]! The compressor now has [charges] charges."))
		else
			to_chat(user, span_notice("Anomalous error. Summon a coder."))

/obj/item/compressionkit/attackby(obj/item/I, mob/user, params)
	..()
	if(istype(I, /obj/item/stack/ore/bluespace_crystal))
		var/obj/item/stack/ore/bluespace_crystal/B = I
		charges += 2
		to_chat(user, span_notice("You insert [I] into [src]. It now has [charges] charges."))
		if(B.amount > 1)
			B.amount -= 1
		else
			qdel(I)
