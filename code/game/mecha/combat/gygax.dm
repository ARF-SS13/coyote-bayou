/*	Gygax
	The go-to mech for active combat with its ability to move fast
	Has less attack force than most other mechs and is easily destroyed
*/

/obj/mecha/combat/gygax
	name = "\improper Gygax"
	desc = "A pre-War security exosuit developed by Vault-Tec to minimize casulties among security staff during violent uprisings. It's painted in a bright orange scheme to ensure recognizability."
	icon_state = "gygax"
	step_in = 3
	dir_in = 1 //Facing North.
	max_integrity = 450
	armor = list("melee" = 30, "bullet" = 25, "laser" = 30, "energy" = 25, "bomb" = 15, "bio" = 0, "rad" = 75, "fire" = 100, "acid" = 100)
	max_temperature = 25000
	infra_luminosity = 6
	wreckage = /obj/structure/mecha_wreckage/gygax
	internal_damage_threshold = 20
	step_energy_drain = 20
	leg_overload_coeff = 300
	smashcooldown = 8
	canstrafe = TRUE

/obj/mecha/combat/gygax/dark // Adminus mech.
	name = "\improper Dark Gygax"
	desc = "A lightweight exosuit, painted in a dark scheme. This model appears to have some modifications."
	icon_state = "darkgygax"
	max_integrity = 500
	armor = list("melee" = 45, "bullet" = 45, "laser" = 60, "energy" = 40, "bomb" = 35, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	max_temperature = 35000
	leg_overload_coeff = 100
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

/obj/mecha/combat/gygax/GrantActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Grant(user, src)

/obj/mecha/combat/gygax/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	overload_action.Remove(user)
