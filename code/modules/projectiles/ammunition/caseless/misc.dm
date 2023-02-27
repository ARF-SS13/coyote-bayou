/obj/item/ammo_casing/caseless/magspear
	name = "magnetic spear"
	desc = "A reusable spear that is typically loaded into kinetic spearguns."
	projectile_type = /obj/item/projectile/bullet/reusable/magspear
	caliber = CALIBER_SPEAR
	icon_state = "magspear"
	throwforce = 15 //still deadly when thrown
	throw_speed = 3

/obj/item/ammo_casing/caseless/laser
	name = "laser casing"
	desc = "You shouldn't be seeing this."
	caliber = CALIBER_LASER
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/beam
	fire_sound = 'sound/weapons/laser.ogg'
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

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
	pellets = 3
	variance = 20

//throwin' rock, for throwin'. obtained via *rocks
/obj/item/ammo_casing/caseless/rock
	name = "rock"
	desc = "a nice hefty rock, for bashing over someone's head or throwing at someone's head."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	item_state = "rock"
	force = 15
	throwforce = 15
	throw_speed = 1 // you can see it comin'
	throw_range = 10 //you can chuck a rock pretty far. good luck hitting anything though
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_SMALL_ITEM
	attack_verb = list("attacked", "bashed", "brained", "thunked", "clobbered")
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	caliber = CALIBER_ROCK
	projectile_type = /obj/item/projectile/rock
	is_pickable = TRUE
	custom_materials = list(/datum/material/glass = 50) //rocks are made of silicon, same as sand
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS

/obj/item/ammo_casing/caseless/brick
	name = "brick"
	desc = "a weighty brick for bashing heads."
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	item_state = "rock"
	force = 15
	throwforce = 15
	throw_speed = 1
	throw_range = 10
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FIRE_PROOF
	total_mass = TOTAL_MASS_SMALL_ITEM
	attack_verb = list("attacked", "bashed", "brained", "thunked", "clobbered")
	attack_speed = CLICK_CD_MELEE
	max_integrity = 200
	armor = ARMOR_VALUE_GENERIC_ITEM
	caliber = CALIBER_BRICK
	projectile_type = /obj/item/projectile/brick
	is_pickable = TRUE
	custom_materials = list(/datum/material/glass = 50)
	fire_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
