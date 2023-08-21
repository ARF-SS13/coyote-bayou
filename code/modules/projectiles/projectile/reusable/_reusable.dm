/obj/item/projectile/bullet/reusable
	name = "reusable bullet"
	desc = "How do you even reuse a bullet?"
	var/ammo_type = /obj/item/ammo_casing/caseless
	var/dropped = FALSE
	impact_effect_type = null
	/// Percent chance for the thing to break and cease to exist
	var/break_chance = 0

/obj/item/projectile/bullet/reusable/on_hit(atom/target, blocked = FALSE)
	. = ..()
	handle_drop()

/obj/item/projectile/bullet/reusable/on_range()
	handle_drop()
	..()

/obj/item/projectile/bullet/reusable/proc/handle_drop()
	if(!dropped)
		if(prob(break_chance))
			return
		var/turf/T = get_turf(src)
		new ammo_type(T)
		dropped = TRUE
