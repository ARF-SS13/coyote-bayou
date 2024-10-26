/obj/item/ammo_box/magazine/internal/cylinder/rev38
	name = "detective revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev22
	name = ".22 revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev22/four
	name = ".22 derringer cylinder"
	max_ammo = 4

/obj/item/ammo_box/magazine/internal/cylinder/rus357
	name = "\improper Russian revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 6
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/lucky37
	name = "\improper Lucky 37 cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 6


/obj/item/ammo_box/magazine/internal/cylinder/lemat
	name = "Lemat cylnder"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 9

/obj/item/ammo_box/magazine/internal/cylinder/rev6520
	name = "6520 10mm cylinder"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list(CALIBER_10MM)
	max_ammo = 12

/obj/item/ammo_box/magazine/internal/cylinder/rev4570
	name = "4570 cylinder"
	ammo_type = /obj/item/ammo_casing/c4570
	caliber = list(CALIBER_4570)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev4570/two
	name = "4570 derringer cylinder"
	ammo_type = /obj/item/ammo_casing/c4570
	caliber = list(CALIBER_4570)
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/cylinder/rev4570/death
	name = "4570 cylinder"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/hermes
	name = "hermes revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/cylinder/medusa
	name = "multi-caliber revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = MEDUSA_AMMO_CALIBERS
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/revneedler
	name = "needler internal mag"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	caliber = list(CALIBER_NEEDLE)
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/rus357/Initialize()
	stored_ammo += new ammo_type(src)
	. = ..()

/obj/item/ammo_box/magazine/internal/cylinder/improvisedpipe
	name = "pipe rifle"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list(CALIBER_556)
	max_ammo = 1
	can_change_caliber = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/improvisedpipe/Initialize()
	. = ..()
	name += " [pick(GLOB.hobo_gun_mag_fluff["prefix"])] [pick(GLOB.hobo_gun_mag_fluff["suffix"])][prob(20) ? pick(GLOB.hobo_gun_mag_fluff["prefix"]) : ""]"
	valid_new_calibers = GLOB.pipe_rifle_valid_calibers

/obj/item/ammo_box/magazine/internal/cylinder/improvised_any
	name = "omnicaliber loadseat"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list(CALIBER_ANY)
	max_ammo = 1
	can_change_caliber = FALSE

/obj/item/ammo_box/magazine/internal/cylinder/improvised45
	name = "improvised internal magazine .45"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = KNUCKLEGUN_AMMO_CALIBERS
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/improvised9mm
	name = "improvised internal magazine 9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = list(CALIBER_9MM)
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/cylinder/improvised10mm
	name = "pepperbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = list(CALIBER_10MM)
	max_ammo = 4
	multiload = 0
	can_change_caliber = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/improvised10mm/deal
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)
	can_change_caliber = FALSE

/obj/item/ammo_box/magazine/internal/cylinder/improvised10mm/Initialize()
	. = ..()
	name += " [pick(GLOB.hobo_gun_mag_fluff["prefix"])] [pick(GLOB.hobo_gun_mag_fluff["suffix"])][prob(20) ? pick(GLOB.hobo_gun_mag_fluff["prefix"]) : ""]"
	valid_new_calibers = GLOB.zipgun_valid_calibers


/obj/item/ammo_box/magazine/internal/cylinder/improvised308
	name = "rebored"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 2
	multiload = 0
	can_change_caliber = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/caravan
	name = "caravan rifle chamber"
	ammo_type = /obj/item/ammo_casing/c4570
	caliber = list(CALIBER_4570)
	max_ammo = 2
	multiload = 0

/obj/item/ammo_box/magazine/internal/cylinder/improvised308/Initialize()
	. = ..()
	name += " [pick(GLOB.hobo_gun_mag_fluff["prefix"])] [pick(GLOB.hobo_gun_mag_fluff["suffix"])][prob(20) ? pick(GLOB.hobo_gun_mag_fluff["prefix"]) : ""]"
	valid_new_calibers = GLOB.pipe_rifle_valid_calibers

/obj/item/ammo_box/magazine/internal/cylinder/thatgun
	name = ".308 pistol cylinder"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = "44 magnum cylinder"
	ammo_type = /obj/item/ammo_casing/m44
	caliber = list(CALIBER_44)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev357
	name = "357 magnum cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/rev45
	name = ".45 ACP revolver cylinder"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(CALIBER_45ACP)
	max_ammo = 7

/obj/item/ammo_box/magazine/internal/cylinder/rev45/two
	name = ".45 LC derringer cylinder"
	name = ".45 LC revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a45lc
	caliber = list(CALIBER_45LC)
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger
	name = ".45 LC revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a45lc
	caliber = list(CALIBER_45LC)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/judge
	name = "Cylinder for a Judge"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 3

/obj/item/ammo_box/magazine/internal/cylinder/rev47mm
	name = "4.7mm Revolver Cylinder"
	ammo_type = /obj/item/ammo_casing/caseless/g11
	caliber = list(CALIBER_CASELESS)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/cylinder/heavyneedler
	name = "Ruby Cylinder"
	ammo_type = /obj/item/ammo_casing/caseless/needle/heavy
	caliber = list(CALIBER_HNEEDLE)
	max_ammo = 3

/obj/item/ammo_box/magazine/internal/cylinder/rev5mm
	name = "5mm Revolver Cylinder"
	ammo_type = /obj/item/ammo_casing/m5mm
	caliber = list(CALIBER_5MM)
	max_ammo = 7
/obj/item/ammo_box/magazine/internal/cylinder/rev308
	name = ".308 Sporting Revolver Cylinder"
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/gras
	name = "Fusil Gras mle 1874"
	ammo_type = /obj/item/ammo_casing/a3006
	caliber = list(CALIBER_3006)
	max_ammo = 1

/obj/item/ammo_box/magazine/internal/cylinder/magnetic
	name = "Hephestus Internal Magazine"
	ammo_type = /obj/item/ammo_casing/a556
	caliber = list(CALIBER_556)
	max_ammo = 20
