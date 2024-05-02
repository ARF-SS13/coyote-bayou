/obj/item/ammo_casing/caseless/rocket
	name = "\improper Low Yield Rocket"
	desc = "The PM-9LHE is an 84mm low-yield High Explosive rocket. Fire at people and pray."
	caliber = CALIBER_ROCKET
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "m6a1"
	projectile_type = /obj/item/projectile/bullet/a84mm_he
	is_pickable = FALSE
	custom_materials = list(
		/datum/material/iron = MATS_ROCKET_CASING + MATS_ROCKET_BULLET,
		/datum/material/blackpowder = MATS_ROCKET_POWDER) // great source of powder
	sound_properties = CSP_MISC

/obj/item/ammo_casing/caseless/rocket/hedp
	name = "\improper High Explosive Dual Purpose Rocket"
	desc = "The PM-9HEDP is an 84mm High Explosive Dual Purpose rocket. Pointy end toward mechs."
	icon_state = "og7v"
	projectile_type = /obj/item/projectile/bullet/a84mm

/obj/item/ammo_casing/caseless/rocket/incendiary
	name = "\improper Incendiary Rocket"
	desc = "The PM-9 I is an 84mm incendiary rocket. Fire with care."
	icon_state = "rocketshell"
	projectile_type = /obj/item/projectile/bullet/a84mm_incend

/obj/item/ammo_casing/caseless/rocket/chem
	name = "\improper Chemical Rocket"
	desc = "The PM-9C is an 84mm chemical dispersement rocket. Fire with great shame."
	icon_state = "pg7v"
	projectile_type = /obj/item/projectile/bullet/a84mm_chem

/obj/item/ammo_casing/caseless/rocket/big
	name = "\improper High Yield HE Rocket"
	desc = " The PM-9 HHE is like the low-yield HE rocket, but bigger."
	icon_state = "m6a1"
	projectile_type = /obj/item/projectile/bullet/a84mm_he_big

/obj/item/ammo_casing/caseless/rocket/big/Initialize(mapload, set_snowflake_id)
	. = ..()
	transform *= 1.5
	special_transform = transform

/obj/item/ammo_casing/caseless/a75
	desc = "A .75 bullet casing."
	caliber = CALIBER_75
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/bullet/gyro

/obj/item/ammo_casing/caseless/mininuke
	name = "\improper Mininuke"
	desc = "That's a mininuke. it's more of a tactical demolition weapon than antipersonal, but when has that ever stopped anyone?"
	w_class = WEIGHT_CLASS_NORMAL
	caliber = CALIBER_MININUKE
	icon = 'modular_coyote/icons/objects/c13ammo.dmi'
	icon_state = "nuclear"
	projectile_type = /obj/item/projectile/bullet/mininuke

/obj/item/ammo_casing/caseless/mininuke/meganuke
	name = "\improper Meganuke"
	desc = "You thought a mininuke was high yield? try a mininuke that fires mininukes."
	projectile_type = /obj/item/projectile/bullet/meganuke
