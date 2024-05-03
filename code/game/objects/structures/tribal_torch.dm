/obj/structure/destructible/tribal_torch
	name = "tribal torch"
	desc = "A standing torch, used to provide light in dark environments."
	density = FALSE
	plane = MOB_PLANE
	anchored = TRUE
	icon = 'icons/obj/candle.dmi'
	icon_state = "torch_unlit"
	light_color = LIGHT_COLOR_FIRE
	light_power = 0.6
	light_range = 0
	break_sound = 'sound/hallucinations/veryfar_noise.ogg'
	debris = list(/obj/item/candle/tribal_torch = 1)
	tastes = list("wood" = 1, "fuel" = 1)
	var/burning = FALSE
	var/flickering = FALSE
	var/flicker_chance = 1 // percent

/obj/structure/destructible/tribal_torch/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_LICKED,PROC_REF(smooch_fire))

/obj/structure/destructible/tribal_torch/Destroy()
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_LICKED)

/obj/structure/destructible/tribal_torch/proc/smooch_fire(atom/A, mob/living/carbon/licker, obj/item/hand_item/tongue)
	if(!iscarbon(licker) || !tongue || !burning || HAS_TRAIT(licker, TRAIT_RESISTHEAT))
		return FALSE

	var/obj/item/bodypart/ur_mouth = licker.get_bodypart(BODY_ZONE_HEAD)
	if(ur_mouth && ur_mouth.receive_damage(0, 25, wound_bonus = 10)) // burn idiot
		playsound(licker, 'sound/items/welder.ogg', 100, TRUE)
		licker.emote("scream")
		licker.adjust_fire_stacks(5)
		licker.IgniteMob()
		licker.visible_message(
			span_warning("[licker] burns their tongue on \the [src]!"),
			span_danger("You lick \the [src], and it, of course, burns your tongue!"),
			span_warning("You hear a sizzle!")
		)
		return TRUE
	return FALSE

/obj/structure/destructible/tribal_torch/update_icon()
	icon_state = "torch_[burning ? null : "un"]lit"

/obj/structure/destructible/tribal_torch/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(burning)
		user.visible_message(span_notice("[user] snuffs [src] out."), span_notice("You snuff [src] out."))
		burning = FALSE
		update_icon()
		set_light(0)
		return
	if(!burning)
		user.visible_message(span_notice("[user] starts to pull [src] free from the ground...."), span_notice("You start to pull [src] free from the ground..."))
		if(do_after(user, 20, progress = 1, target = src))
			to_chat(user, span_notice("You pull [src] free from the ground."))
			var/torch = new /obj/item/candle/tribal_torch
			user.put_in_hands(torch)
			qdel(src)
			return

/obj/structure/destructible/tribal_torch/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature())
		StartBurning()
		user.visible_message(span_notice("[user] lights [src] with [W]."), span_notice("You light [src] with [W]."))
		return
	..()

/obj/structure/destructible/tribal_torch/proc/StartBurning()
	if(!burning)
		burning = TRUE
		set_light(7)
		update_icon()
		return

/obj/structure/destructible/tribal_torch/process()
	. = ..()
	if(!flickering && prob(flicker_chance))
		flicker(rand(1, 4)) // 0.1 to 0.4 seconds

/obj/structure/destructible/tribal_torch/proc/flicker(duration)
	addtimer(CALLBACK(src,PROC_REF(unflicker), light_range), duration)
	set_light(light_range - rand(1, 2))
	flickering = TRUE
	addtimer(CALLBACK(src,PROC_REF(unflicker)), duration)

/obj/structure/destructible/tribal_torch/proc/unflicker(new_range)
	set_light(new_range)
	flickering = FALSE

/obj/structure/destructible/tribal_torch/fire_act(exposed_temperature, exposed_volume)
	StartBurning()

/obj/structure/destructible/tribal_torch/lit //ALREADY LIT TORCH FOR USE IN MAPPING
	burning = TRUE
	icon_state = "torch_lit"
	light_range = 7

/obj/structure/destructible/tribal_torch/wall
	icon_state = "wall_torch_unlit"
	layer = WALL_OBJ_LAYER

/obj/structure/destructible/tribal_torch/wall/update_icon()
	. = ..()
	icon_state = "wall_[icon_state]"
	pixel_y = (dir == NORTH) ? 15 : 0
	pixel_x = 0

/obj/structure/destructible/tribal_torch/wall/lit
	burning = TRUE
	icon_state = "wall_torch_lit"
	light_range = 7

//Tiki torches from Civ

/obj/structure/destructible/tribal_torch/tikilit //ALREADY LIT TORCH FOR USE IN MAPPING
	burning = TRUE
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "tikitorch_lit"
	light_range = 7

