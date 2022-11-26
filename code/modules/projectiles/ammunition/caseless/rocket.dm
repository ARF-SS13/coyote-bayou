/obj/item/ammo_casing/caseless/rocket
	name = "\improper Low Yield Rocket"
	desc = "The PM-9LHE is an 84mm low-yield High Explosive rocket. Fire at people and pray."
	caliber = CALIBER_ROCKET
	icon_state = "srm-8"
	projectile_type = /obj/item/projectile/bullet/a84mm_he
	is_pickable = FALSE
	custom_materials = list(
		/datum/material/iron = MATS_ROCKET_CASING + MATS_ROCKET_BULLET,
		/datum/material/blackpowder = MATS_ROCKET_POWDER) // great source of powder

/obj/item/ammo_casing/caseless/rocket/hedp
	name = "\improper High Explosive Dual Purpose Rocket"
	desc = "The PM-9HEDP is an 84mm High Explosive Dual Purpose rocket. Pointy end toward mechs."
	icon_state = "84mm-hedp"
	projectile_type = /obj/item/projectile/bullet/a84mm

/obj/item/ammo_casing/caseless/rocket/incendiary
	name = "\improper Incendiary Rocket"
	desc = "The PM-9 I is an 84mm incendiary rocket. Fire with care."
	icon_state = "84mm-incin"
	projectile_type = /obj/item/projectile/bullet/a84mm_incend

/obj/item/ammo_casing/caseless/rocket/chem
	name = "\improper Chemical Rocket"
	desc = "The PM-9C is an 84mm chemical dispersement rocket. Fire with great shame."
	icon_state = "84mm-chem"
	projectile_type = /obj/item/projectile/bullet/a84mm_chem

/obj/item/ammo_casing/caseless/rocket/big
	name = "\improper High Yield HE Rocket"
	desc = " The PM-9 HHE is like the low-yield HE rocket, but bigger."
	icon_state = "84mm-hedp"
	projectile_type = /obj/item/projectile/bullet/a84mm_he_big

/obj/item/ammo_casing/caseless/a75
	desc = "A .75 bullet casing."
	caliber = CALIBER_75
	icon_state = "s-casing-live"
	projectile_type = /obj/item/projectile/bullet/gyro
