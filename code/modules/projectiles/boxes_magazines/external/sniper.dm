/obj/item/ammo_box/magazine/amr
	name = "Anti-materiel rifle magazine (.50)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50mag"
	max_ammo = 8
	ammo_type = /obj/item/ammo_casing/a50MG
	caliber = "a50MG"
	multiple_sprites = 2

/obj/item/ammo_box/magazine/amr/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/amr/incindiary
	name = "Anti-materiel magazine (Incindiary)"
	desc = "A .50 anti-materiel rifle magazine loaded with incindiary ammo."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/incendiary

/obj/item/ammo_box/magazine/amr/penetrator
	name = "Anti-materiel magazine (penetrator)"
	desc = "A .50 anti-materiel rifle magazine loaded with wall-penetrating ammo."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/penetrator

/obj/item/ammo_box/magazine/amr/uranium
	name = "Anti-materiel magazine (uranium)"
	desc = "A .50 anti-materiel rifle magazine loaded with crimes against god."
	special_ammo = TRUE
	ammo_type = /obj/item/ammo_casing/a50MG/uraniumtipped

/*
/obj/item/ammo_box/magazine/sniper_rounds/soporific
	name = "sniper rounds (Zzzzz)"
	desc = "Soporific sniper rounds, designed for happy days and dead quiet nights..."
	icon_state = "soporific"
	max_ammo = 3
	caliber = ".50"

/obj/item/ammo_box/magazine/sniper_rounds/penetrator
	name = "sniper rounds (penetrator)"
	desc = "An extremely powerful round capable of passing straight through cover and anyone unfortunate enough to be behind it."
	max_ammo = 5
*/
