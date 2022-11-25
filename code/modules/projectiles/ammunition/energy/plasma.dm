/obj/item/ammo_casing/energy/plasma
	projectile_type = /obj/item/projectile/f13plasma
	select_name = "plasma burst"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 100

/obj/item/ammo_casing/energy/miningplasma
	projectile_type = /obj/item/projectile/plasma
	select_name = "plasma burst"
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	e_cost = 100

/obj/item/ammo_casing/energy/plasma/adv
	projectile_type = /obj/item/projectile/plasma/adv
	delay = 10
	e_cost = 10

/obj/item/ammo_casing/energy/plasma/weak
	projectile_type = /obj/item/projectile/plasma/weak
	e_cost = 100

/obj/item/ammo_casing/energy/plasmacarbine
	projectile_type = /obj/item/projectile/plasmacarbine
	select_name = "plasma burst"
	icon_state = "neurotoxin"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 160//12

/obj/item/ammo_casing/energy/plasma/scatter
	projectile_type = /obj/item/projectile/f13plasma/scatter
	pellets = 3
	variance = 14
	select_name = "scatter"
	fire_sound = 'sound/f13weapons/multiplas_rifle.ogg'
	e_cost = 200 //10 shots

/obj/item/ammo_casing/energy/plasma/pistol
	projectile_type = /obj/item/projectile/f13plasma/pistol
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 200 //8 shots

/obj/item/ammo_casing/energy/plasma/pistol/eve
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 250 //6 shots

/obj/item/ammo_casing/energy/plasma/pistol/eve/worn
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve/worn
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 375 //4 shots

/obj/item/ammo_casing/energy/plasma/pistol/adam
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 250 //6 shots

/obj/item/ammo_casing/energy/plasma/pistol/worn
	projectile_type = /obj/item/projectile/f13plasma/pistol/worn
	e_cost = 200 //8 shots

/obj/item/ammo_casing/energy/plasma/pistol/glock
	projectile_type = /obj/item/projectile/f13plasma/pistol/glock
	fire_sound = 'sound/f13weapons/Glock86Fire.ogg'
	e_cost = 160 //10 shots

/obj/item/ammo_casing/energy/plasma/pistol/glock/extended
	e_cost = 80 //20 shots

/obj/item/ammo_casing/energy/plasma/pistol/alien
	projectile_type = /obj/item/projectile/f13plasma/pistol/alien
	select_name = "alien projectile"
	icon_state = "ion"
	fire_sound = 'sound/f13weapons/AlienBlasterFire.ogg'
	e_cost = 1000 //four shots and you're out. use them wisely.

/obj/item/ammo_casing/energy/plasma/miner
	projectile_type = /obj/item/projectile/f13plasma/repeater/mining
	select_name = "mining plasma stream"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 2.4 //this seems very low but the weapon fires 5 5-damage shots per burst and only fires in bursts
