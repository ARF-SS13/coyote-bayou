/obj/item/ammo_casing/caseless/magspear
	name = "magnetic spear"
	desc = "A reusable spear that is typically loaded into kinetic spearguns."
	projectile_type = /obj/item/projectile/bullet/reusable/magspear
	caliber = CALIBER_SPEAR
	icon_state = "magspear"
	throwforce = 15 //still deadly when thrown
	throw_speed = 3
	sound_properties = CSP_GAUSS

/obj/item/ammo_casing/caseless/laser
	name = "laser casing"
	desc = "You shouldn't be seeing this."
	caliber = CALIBER_LASER
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/beam
	fire_sound = 'sound/weapons/laser.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy
	sound_properties = CSP_MISC

/obj/item/ammo_casing/caseless/laser/gatling
	caliber = CALIBER_LASERGATLING
	projectile_type = /obj/item/projectile/beam/laser/gatling
	variance = 0.5
	click_cooldown_override = 1

/obj/item/ammo_casing/caseless/flamethrower
	name = "napalm"
	desc = "a bunch of napalm fuel for a flamethrower. A bit useless now that it's been spilt on the ground."
	caliber = CALIBER_FUEL
	icon = 'icons/mob/robots.dmi'
	icon_state = "floor1"
	projectile_type = /obj/item/projectile/incendiary/flamethrower
	pellets = 1
	variance = 5
	sound_properties = CSP_MISC
