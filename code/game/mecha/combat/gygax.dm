/obj/mecha/combat/gygax
	desc = "A pre-War security exosuit developed by Vault-Tec to minimize casulties among security staff during violent uprisings. It's painted in a bright orange scheme to ensure recognizability."
	name = "\improper Gygax"
	icon_state = "gygax"
	step_in = 2.5
	dir_in = 1 //Facing North.
	max_integrity = 300
	force = 25
	armor = list("melee" = 30, "bullet" = 25, "laser" = 40, "energy" = 15, "bomb" = 15, "bio" = 0, "rad" = 65, "fire" = 100, "acid" = 100)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/gygax
	internal_damage_threshold = 20
	max_equip = 4
	step_energy_drain = 10
	canstrafe = TRUE
//	leg_overload_coeff = 300
	allow_diagonal_movement = TRUE

/obj/mecha/combat/gygax/dark // Adminbus.
	desc = "A lightweight exosuit, painted in a dark scheme. This model appears to have some modifications."
	name = "\improper Dark Gygax"
	icon_state = "darkgygax"
	max_integrity = 400
	deflect_chance = 20
	force = 30
	armor = list("melee" = 50, "bullet" = 50, "laser" = 60, "energy" = 40, "bomb" = 30, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	max_temperature = 35000
//	leg_overload_coeff = 100
	wreckage = /obj/structure/mecha_wreckage/gygax/dark
	max_equip = 4

/obj/mecha/combat/gygax/dark/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/teleporter
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay
	ME.attach(src)
	max_ammo()

/obj/mecha/combat/gygax/dark/add_cell(obj/item/stock_parts/cell/C=null)
	if(C)
		C.forceMove(src)
		cell = C
		return
	cell = new /obj/item/stock_parts/cell/hyper(src)

/*
/obj/mecha/combat/gygax/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Grant(user, src)

/obj/mecha/combat/gygax/dark/GrantActions(mob/living/user, human_occupant = 0)
	..()
	thrusters_action.Grant(user, src)


/obj/mecha/combat/gygax/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)

/obj/mecha/combat/gygax/dark/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	thrusters_action.Remove(user)

*/