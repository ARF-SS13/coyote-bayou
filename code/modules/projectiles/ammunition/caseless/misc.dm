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

//throwin' rock, for throwin'. obtained via *rocks
/obj/item/ammo_casing/caseless/rock
	name = "rock"
	desc = "a nice hefty rock, for bashing over someone's head or throwing at someone's head. You can get your own with *rocks!"
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "rock"
	inhand_icon_state = "rock"
	force = 15
	throwforce = 20
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
	sound_properties = CSP_ROCK

/obj/item/ammo_casing/caseless/brick
	name = "brick"
	desc = "a weighty brick for bashing heads. You too might find some laying around with *brick"
	icon = 'modular_coyote/icons/objects/brick.dmi'
	icon_state = "brick"
	inhand_icon_state = "brick"
	force = 15
	throwforce = 20
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
	sound_properties = CSP_ROCK
	hitsound = 'sound/effects/brickthrow.ogg'

/obj/item/ammo_casing/caseless/flintlock
	name = "packed blackpowder cartridge"
	desc = "a measure of blackpowder and round musket ball."
	caliber = CALIBER_FLINTLOCK
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing"
	projectile_type = /obj/item/projectile/flintlock
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_BULLET, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_LIGHT_POWDER)
	sound_properties = CSP_FLINTLOCK
	custom_materials = list(/datum/material/blackpowder = 500)
	w_class = WEIGHT_CLASS_SMALL
	variance = CASING_SPREAD_FLINTLOCK

/obj/item/ammo_casing/caseless/flintlock/minie
	name = "packed blackpowder minie cartridge"
	desc = "A conical bullet designed to give flintlocks a bit more of a modern edge."
	caliber = CALIBER_FLINTLOCK
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing_minie"
	projectile_type = /obj/item/projectile/flintlock/minie
	sound_properties = CSP_FLINTLOCK
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_POWDER, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_HEAVY_POWDER)
	w_class = WEIGHT_CLASS_SMALL
	variance = CASING_SPREAD_SURPLUS

/obj/item/ammo_casing/caseless/flintlock/rubber
	name = "packed blackpowder rubber cartridge"
	desc = "A superball mashed into a blackpowder cartridge. It's not very effective, but it's fun to shoot. Less than lethal?"
	caliber = CALIBER_FLINTLOCK
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "flintlock_casing_rubber"
	projectile_type = /obj/item/projectile/flintlock/rubber
	sound_properties = CSP_FLINTLOCK
	variance = CASING_SPREAD_SURPLUS
	custom_materials = list(
		/datum/material/iron = MATS_FLINTLOCK_LIGHT_POWDER, // what casing? ~ uwu ~
		/datum/material/blackpowder = MATS_FLINTLOCK_HEAVY_POWDER)
	w_class = WEIGHT_CLASS_SMALL

