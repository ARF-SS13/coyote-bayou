/*	Marauder
	Meant for attacking heavy fortifications and generally prolonged combat
	Has the most attack force, but is also slower than other mechs and can't strafe
*/

/obj/mecha/combat/marauder
	name = "\improper Marauder"
	desc = "A retrofit of the orginal 'Durand' exosuit designed for extended combat operations, the shield projector has been replaced with a smoke-screen dispenser and a sophisticated sensor suite."
	icon_state = "marauder"
	step_in = 5
	max_integrity = 500
	armor = list("melee" = 60, "bullet" = 60, "laser" = 40, "energy" = 30, "bomb" = 60, "bio" = 0, "rad" = 75, "fire" = 100, "acid" = 100)
	max_temperature = 60000
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/marauder
	internal_damage_threshold = 10
	step_energy_drain = 60
	force = 40 // Just don't go near that thing, or do, it can't strafe.
	canstrafe = FALSE

/obj/mecha/combat/marauder/GrantActions(mob/living/user, human_occupant = 0)
	..()
	smoke_action.Grant(user, src)
	zoom_action.Grant(user, src)

/obj/mecha/combat/marauder/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	smoke_action.Remove(user)
	zoom_action.Remove(user)

/obj/mecha/combat/marauder/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	max_ammo()

/obj/mecha/combat/marauder/seraph // Very OP adminbus mech.
	name = "\improper Seraph"
	desc = "Heavy-duty, command-type exosuit. This is a custom model, utilized only by high-ranking military personnel."
	icon_state = "seraph"
	step_in = 3
	max_integrity = 1000
	armor = list("melee" = 75, "bullet" = 70, "laser" = 50, "energy" = 60, "bomb" = 60, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	infra_luminosity = 1
	wreckage = /obj/structure/mecha_wreckage/seraph
	internal_damage_threshold = 20
	force = 65
	max_equip = 5

/obj/mecha/combat/marauder/seraph/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/teleporter(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	max_ammo()

/obj/mecha/combat/marauder/mauler // Evil adminbus variant of the marauder.
	desc = "Heavy-duty, combat exosuit, developed off of the existing Marauder model."
	name = "\improper Mauler"
	icon_state = "mauler"
	wreckage = /obj/structure/mecha_wreckage/mauler
	max_equip = 5

/obj/mecha/combat/marauder/mauler/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/tesla_energy_relay(src)
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/antiproj_armor_booster(src)
	ME.attach(src)
	max_ammo()


