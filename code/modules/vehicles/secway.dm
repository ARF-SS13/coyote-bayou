
/obj/vehicle/ridden/secway
	name = "secway"
	desc = "A brave security cyborg gave its life to help you look like a complete tool."
	icon_state = "secway"
	key_type = /obj/item/key/security
	var/chargemax = 150
	var/chargerate = 0.35
	var/charge = 150
	var/chargespeed = 1
	var/normalspeed = 2
	var/last_tick = 0
	var/my_bar

/obj/vehicle/ridden/secway/Initialize()
	. = ..()
	var/datum/component/riding/D = LoadComponent(/datum/component/riding)
	D.vehicle_move_delay = 1
	D.set_riding_offsets(RIDING_OFFSET_ALL, list(TEXT_NORTH = list(0, 4), TEXT_SOUTH = list(0, 4), TEXT_EAST = list(0, 4), TEXT_WEST = list( 0, 4)))
	START_PROCESSING(SSfastprocess, src)
	my_bar = SSprogress_bars.add_bar(src, list(), chargemax, FALSE, FALSE)

/obj/vehicle/ridden/secway/process()
	var/diff = world.time - last_tick
	var/regen = chargerate * diff
	charge = clamp(charge + regen, 0, chargemax)
	last_tick = world.time

/obj/vehicle/ridden/secway/relaymove(mob/user, direction)
	var/new_speed = normalspeed
	if(isliving(user))
		var/mob/living/L = user
		if((L.combat_flags & COMBAT_FLAG_SPRINT_TOGGLED) && charge)
			charge--
			new_speed = chargespeed
	var/datum/component/riding/D = GetComponent(/datum/component/riding)
	D.vehicle_move_delay = new_speed
	SSprogress_bars.update_bar(charge)
	return ..()

/obj/vehicle/ridden/secway/buckle_mob(mob/living/M, force, check_loc)
	. = ..()
	SSprogress_bars.add_viewer(my_bar, M)

/obj/vehicle/ridden/secway/Destroy()
	SSprogress_bars.remove_bar(my_bar)
	STOP_PROCESSING(SSfastprocess, src)
	return ..()
