/obj/item/ammo_casing/caseless
	desc = "A caseless bullet casing."
	firing_effect_type = null
	heavy_metal = FALSE
	custom_materials = list(
		/datum/material/iron = MATS_PISTOL_MEDIUM_CASING + MATS_PISTOL_MEDIUM_BULLET,
		/datum/material/blackpowder = MATS_PISTOL_MEDIUM_POWDER)

/obj/item/ammo_casing/caseless/fire_casing(atom/target, mob/living/user, params, distro, quiet, zone_override, spread, damage_multiplier, penetration_multiplier, projectile_speed_multiplier, atom/fired_from)
	if (..()) //successfully firing
		moveToNullspace()
		if(istype(fired_from, /obj/item/gun))
			var/obj/item/gun/gonne = fired_from
			if(gonne.chambered == src)
				gonne.chambered = null // harddels suffer
				gonne.update_icon()
		qdel(src)
		return TRUE
	else
		return FALSE

/obj/item/ammo_casing/caseless/update_icon_state()
	icon_state = "[initial(icon_state)]"
