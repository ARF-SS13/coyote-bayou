/obj/item/ammo_box/magazine/internal/shot
	name = "shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	caliber = list(CALIBER_SHOTGUN)
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/shot/ammo_count(countempties = 1)
	if (!countempties)
		var/boolets = 0
		for(var/obj/item/ammo_casing/bullet in stored_ammo)
			if(bullet.BB)
				boolets++
		return boolets
	else
		return ..()
/obj/item/ammo_box/magazine/internal/shot/trench
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 5

/obj/item/ammo_box/magazine/internal/shot/mino
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 3

/obj/item/ammo_box/magazine/internal/shot/needler
	ammo_type = /obj/item/ammo_casing/generic/shotgun/needlerbuckshot
	caliber = list(CALIBER_SHOTGUNNEEDLER)
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/tube
	name = "dual feed shotgun internal tube"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/lethal
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot

/obj/item/ammo_box/magazine/internal/shot/shorty
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/shot/com
	name = "combat shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/com/compact
	name = "compact combat shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 4

/obj/item/ammo_box/magazine/internal/shot/com/citykiller
	name = "city killer shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/buckshot
	max_ammo = 12

/obj/item/ammo_box/magazine/internal/shot/single
	name = "single-barrel shotgun internal magazine"
	max_ammo = 1

/obj/item/ammo_box/magazine/internal/shot/single/fifty
	name = "single-barrel fifty cal internal magazine"
	max_ammo = 1
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = list(CALIBER_50MG)

/obj/item/ammo_box/magazine/internal/shot/dual
	name = "double-barrel shotgun internal magazine"
	max_ammo = 2

/obj/item/ammo_box/magazine/internal/shot/dual/simple
	name = "double-barrel shotgun internal magazine (simple)"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/improvised

/obj/item/ammo_box/magazine/internal/shot/improvised
	name = "improvised shotgun internal magazine"
	caliber = SHOTGUNBAT_AMMO_CALIBERS
	ammo_type = /obj/item/ammo_casing/generic/shotgun/improvised
	max_ammo = 1

/obj/item/ammo_box/magazine/internal/shot/police
	name = "police shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/beanbag
	max_ammo = 6

/obj/item/ammo_box/magazine/internal/shot/grenade
	name = "pump grenade launcher internal magazine"
	ammo_type = /obj/item/ammo_casing/a40mm
	caliber = list(CALIBER_40MM)
	max_ammo = 3

/obj/item/ammo_box/magazine/internal/shot/bounty
	name = "triple-barrel shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/generic/shotgun/incapacitate
	max_ammo = 3

/obj/item/ammo_box/magazine/internal/shot/tube44
	name = ".44 magnum internal tube magazine" //trail carbine
	ammo_type = /obj/item/ammo_casing/m44
	caliber = list(CALIBER_44)
	max_ammo = 12
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/volcanic
	name = ".45acp internal tube magazine"
	ammo_type = /obj/item/ammo_casing/c45
	caliber = list(CALIBER_45ACP)
	max_ammo = 5
	multiload = 0


/obj/item/ammo_box/magazine/internal/shot/derringer
	name = "14mm internal magazine"
	ammo_type = /obj/item/ammo_casing/p14mm
	caliber = list(CALIBER_14MM)
	max_ammo = 4
	multiload = 0

/obj/item/ammo_box/magazine/internal/shot/tube357
	name = ".357 magnum internal tube magazine" //cowboy repeater
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 12
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/long22
	name = ".22LR Long internal tube magazine" //baby repeater
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 20
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/short22
	name = ".22LR Short internal tube magazine" //spicy baby repeater
	ammo_type = /obj/item/ammo_casing/a22
	caliber = list(CALIBER_22LR)
	max_ammo = 10
	multiload = 1
/obj/item/ammo_box/magazine/internal/shot/tube4570
	name = "4570 internal tube magazine" //brush gun
	ammo_type = /obj/item/ammo_casing/c4570
	caliber = list(CALIBER_4570)
	max_ammo = 10
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/tube380
	name = "308 internal tube magazine" //long ranger
	ammo_type = /obj/item/ammo_casing/a308
	caliber = list(CALIBER_308)
	max_ammo = 7
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/lasmusket
	name = "lasmusket magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/caseless/lasermusket
	caliber = list(CALIBER_MUSKET_LASER)
	max_ammo = 6
	multiload = 1

/obj/item/ammo_box/magazine/internal/plasmacaster
	name = "plasmacaster magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/caseless/plasmacaster
	caliber = list(CALIBER_MUSKET_PLASMA)
	max_ammo = 2
	multiload = 1

/obj/item/ammo_box/magazine/internal/shot/lasmusket/mosin
	max_ammo = 8
	multiload = 0

