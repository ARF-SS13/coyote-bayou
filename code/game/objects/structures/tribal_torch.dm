/obj/structure/destructible/tribal_torch
	name = "tribal torch"
	desc = "A standing torch, used to provide light in dark environments."
	density = FALSE
	anchored = TRUE
	icon = 'icons/obj/candle.dmi'
	icon_state = "torch_unlit"
	light_color = LIGHT_COLOR_FIRE
	light_power = 1
	light_range = 0
	break_sound = 'sound/hallucinations/veryfar_noise.ogg'
	debris = list(/obj/item/candle/tribal_torch = 1)
	var/burning = FALSE
	var/flickering = FALSE
	var/flicker_chance = 1 // percent

/obj/structure/destructible/tribal_torch/update_icon()
	icon_state = "torch_[burning ? null : "un"]lit"

/obj/structure/destructible/tribal_torch/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(burning)
		user.visible_message("<span class='notice'>[user] snuffs [src] out.</span>", "<span class='notice'>You snuff [src] out.</span>")
		burning = FALSE
		update_icon()
		set_light(0)
		return
	if(!burning)
		user.visible_message("<span class='notice'>[user] starts to pull [src] free from the ground....</span>", "<span class='notice'>You start to pull [src] free from the ground...</span>")
		if(do_after(user, 20, progress = 1, target = src))
			to_chat("<span class='notice'>You pull [src] free from the ground.</span>")
			var/torch = new /obj/item/candle/tribal_torch
			user.put_in_hands(torch)
			qdel(src)
			return

/obj/structure/destructible/tribal_torch/attackby(obj/item/W, mob/user, params)
	if(W.get_temperature())
		StartBurning()
		user.visible_message("<span class='notice'>[user] lights [src] with [W].</span>", "<span class='notice'>You light [src] with [W].</span>")
		return

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
	addtimer(CALLBACK(src, .proc/unflicker, light_range), duration)
	set_light(light_range - rand(1, 2))
	flickering = TRUE
	addtimer(CALLBACK(src, .proc/unflicker), duration)

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

/obj/structure/destructible/tribal_torch/wall/update_icon()
	. = ..()
	icon_state = "wall_[icon_state]"
	pixel_y = (dir == NORTH) ? 15 : 0
	pixel_x = 0

/obj/structure/destructible/tribal_torch/wall/lit
	burning = TRUE
	icon_state = "wall_torch_lit"
	light_range = 7
