/obj/item/gun/ballistic/automatic/toy
	name = "foam force SMG"
	desc = "A prototype three-round burst toy submachine gun. Ages 8 and up."
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "saber"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/smg
	//fire_sound = 'sound/weapons/gunshot_smg.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	force = 0
	throwforce = 0
	burst_size = 3
	can_suppress = TRUE
	clumsy_check = 0
	item_flags = NONE
	casing_ejector = FALSE
	use_gun_sprite_handler = FALSE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/automatic/toy/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/toy/pistol
	name = "foam force pistol"
	desc = "A small, easily concealable toy handgun. Ages 8 and up."
	icon_state = "pistol"
	weapon_class = WEAPON_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/pistol
	fire_sound = 'sound/weapons/gunshot.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/automatic/toy/pistol/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"][silenced ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/toy/pistol/riot
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/pistol/riot

/obj/item/gun/ballistic/automatic/toy/pistol/riot/Initialize()
	magazine = new /obj/item/ammo_box/magazine/toy/pistol/riot(src)
	return ..()

/obj/item/gun/ballistic/automatic/toy/pistol/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/toy/pistol/riot/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/shotgun/toy
	name = "foam force shotgun"
	desc = "A toy shotgun with wood furniture and a four-shell capacity underneath. Ages 8 and up."
	icon = 'icons/obj/guns/toy.dmi'
	force = 0
	throwforce = 0
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy
	clumsy_check = FALSE
	item_flags = NONE
	casing_ejector = FALSE
	can_suppress = FALSE
	weapon_weight = GUN_ONE_HAND_ONLY

/obj/item/gun/ballistic/shotgun/toy/process_chamber(mob/living/user, empty_chamber = 0)
	..()
	if(chambered && !chambered.BB)
		qdel(chambered)

/obj/item/gun/ballistic/shotgun/toy/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/shotgun/toy/crossbow
	name = "foam force crossbow"
	desc = "A weapon favored by many overactive children. Ages 8 and up."
	icon = 'icons/obj/toy.dmi'
	icon_state = "foamcrossbow"
	item_state = "crossbow"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/crossbow
	fire_sound = 'sound/items/syringeproj.ogg'
	weapon_class = WEAPON_CLASS_SMALL

/obj/item/gun/ballistic/automatic/c20r/toy //This is the syndicate variant with syndicate firing pin and riot darts.
	name = "donksoft SMG"
	desc = "A bullpup two-round burst toy SMG, designated 'C-20r'. Ages 8 and up."
	icon = 'icons/obj/guns/toy.dmi'
	can_suppress = TRUE
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/smgm45/riot
	casing_ejector = FALSE
	clumsy_check = FALSE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted //Use this for actual toys
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/smgm45

/obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/smgm45/riot

/obj/item/gun/ballistic/automatic/l6_saw/toy //This is the syndicate variant with syndicate firing pin and riot darts.
	name = "donksoft LMG"
	desc = "A heavily modified toy light machine gun, designated 'L6 SAW'. Ages 8 and up."
	icon = 'icons/obj/guns/toy.dmi'
	can_suppress = FALSE
	item_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/m762/riot
	casing_ejector = FALSE
	clumsy_check = FALSE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted //Use this for actual toys
	pin = /obj/item/firing_pin
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/m762

/obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted/riot
	mag_type = /obj/item/ammo_box/magazine/toy/m762
	init_mag_type = /obj/item/ammo_box/magazine/toy/m762/riot

/obj/item/gun/ballistic/automatic/toy/magrifle
	name = "foamag rifle"
	desc = "A foam launching magnetic rifle. Ages 8 and up."
	icon_state = "foamagrifle"
	obj_flags = NONE
	mag_type = /obj/item/ammo_box/magazine/toy
	init_mag_type = /obj/item/ammo_box/magazine/toy/foamag
	fire_sound = 'sound/weapons/magrifle.ogg'
	can_suppress = FALSE
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/shotgun/toy/mag
	name = "foam force magpistol"
	desc = "A fancy toy sold alongside light-up foam force darts. Ages 8 and up."
	icon_state = "toymag"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/toy/mag
	fire_sound = 'sound/weapons/magpistol.ogg'
	weapon_weight = GUN_ONE_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/burst/three,
		/datum/firemode/semi_auto
	)
