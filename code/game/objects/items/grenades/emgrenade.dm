/obj/item/grenade/empgrenade
	name = "pulse grenade"
	desc = "It is designed to wreak havoc on electronic systems."
	icon_state = "emp"
	item_state = "emp"

/obj/item/grenade/empgrenade/prime(mob/living/lanced_by)
	. = ..()
	update_mob()
	var/empgrenade_turf = get_turf(src)
	if(!empgrenade_turf)
		return
	playsound(empgrenade_turf, 'sound/f13weapons/pulsegrenade.ogg', 100, TRUE, 8, 0.9)
	empulse_using_range(src, 14)
	qdel(src)
