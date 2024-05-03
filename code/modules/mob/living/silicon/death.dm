/mob/living/silicon/spawn_gibs(with_bodyparts, atom/loc_override)
	new /obj/effect/gibspawner/robot(loc_override ? loc_override.drop_location() : drop_location(), src)

/mob/living/silicon/spawn_dust()
	new /obj/effect/decal/remains/robot(loc)

/mob/living/silicon/death(gibbed)
	if(!gibbed)
		INVOKE_ASYNC(src,PROC_REF(emote), "deathgasp")
	diag_hud_set_status()
	diag_hud_set_health()
	update_health_hud()
	. = ..()
