/obj/mecha/combat/marauder
	desc = "A retrofit of the orginal 'Durand' exosuit designed for extended combat operations, the shield projector has been replaced with a smoke-screen dispenser and a sophisticated sensor suite."
	icon_state = "marauder"
	name = "\improper Marauder"
	step_in = 5
	max_integrity = 500
	armor = list("melee" = 60, "bullet" = 60, "laser" = 40, "energy" = 30, "bomb" = 30, "bio" = 0, "rad" = 80, "fire" = 100, "acid" = 100)
	max_temperature = 60000
	step_energy_drain = 30
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	infra_luminosity = 3
	wreckage = /obj/structure/mecha_wreckage/marauder
	force = 45
	max_equip = 4

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

obj/mecha/combat/marauder/GrantActions(mob/living/user, human_occupant = 0)
	..()
	smoke_action.Grant(user, src)
	zoom_action.Grant(user, src)

/obj/mecha/combat/marauder/RemoveActions(mob/living/user, human_occupant = 0)
	..()
	smoke_action.Remove(user)
	zoom_action.Remove(user)

/obj/mecha/combat/marauder/seraph // Adminbus.
	desc = "Heavy-duty, command-type exosuit. This is a custom model, utilized only by high-ranking military personnel."
	name = "\improper Seraph"
	icon_state = "seraph"
	step_in = 3
	max_integrity = 750
	armor = list("melee" = 75, "bullet" = 70, "laser" = 50, "energy" = 50, "bomb" = 50, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	wreckage = /obj/structure/mecha_wreckage/seraph
	internal_damage_threshold = 20
	force = 60
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

/obj/mecha/combat/marauder/mauler
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


