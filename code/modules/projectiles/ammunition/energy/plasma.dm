/* KELP NOTES
10000 energy = small energy cell
20000 energy = electron charge pack
30000 energy = micro fusion cell
40000 energy = ultracite cell
50000 energy = alien cell
*/

/obj/item/ammo_casing/energy/plasma
	projectile_type = /obj/item/projectile/f13plasma/rifle
	select_name = "plasma burst"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 2500 // 12 shots

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

/obj/item/ammo_casing/energy/plasma/bouncy
	projectile_type = /obj/item/projectile/energy/nuclear_particle/plasmabounce
	e_cost = 1500 // 20 shots

/obj/item/ammo_casing/energy/plasmacarbine
	projectile_type = /obj/item/projectile/plasmacarbine
	select_name = "plasma burst"
	icon_state = "neurotoxin"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 1500 // 20 shots

/obj/item/ammo_casing/energy/plasma/scatter
	projectile_type = /obj/item/projectile/f13plasma/scatter
	pellets = 3
	variance = 14
	select_name = "scatter"
	fire_sound = 'sound/f13weapons/multiplas_rifle.ogg'
	e_cost = 3000 // 10 shots

/obj/item/ammo_casing/energy/plasma/pistol
	projectile_type = /obj/item/projectile/f13plasma/pistol
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 1000 // 10 shots

/obj/item/ammo_casing/energy/plasma/pistol/eve
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 1000 // 10 shots

/obj/item/ammo_casing/energy/plasma/pistol/eve/worn
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve/worn
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 1250 // 8 shots

/obj/item/ammo_casing/energy/plasma/pistol/adam
	projectile_type = /obj/item/projectile/f13plasma/pistol/adam
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 1250 // 8 shots

/obj/item/ammo_casing/energy/plasma/pistol/worn
	projectile_type = /obj/item/projectile/f13plasma/pistol/worn
	e_cost = 1000 // 10 shots

/obj/item/ammo_casing/energy/plasma/pistol/glock
	projectile_type = /obj/item/projectile/f13plasma/pistol/glock
	fire_sound = 'sound/f13weapons/Glock86Fire.ogg'
	e_cost = 625 // 16 shots

/obj/item/ammo_casing/energy/plasma/pistol/glock/extended
	e_cost = 500 // 20 shots

/obj/item/ammo_casing/energy/plasma/pistol/alien
	projectile_type = /obj/item/projectile/f13plasma/pistol/alien
	select_name = "alien projectile"
	icon_state = "ion"
	fire_sound = 'sound/f13weapons/AlienBlasterFire.ogg'
	e_cost = 12500 //four shots and you're out. use them wisely.

/obj/item/ammo_casing/energy/plasma/pistol/eve/caster
	projectile_type = /obj/item/projectile/f13plasma/pistol/eve/worn
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 675

/obj/item/ammo_casing/energy/plasma/pistol/covenantpistol
	projectile_type = /obj/item/projectile/f13plasma/pistol/covenant
	e_cost = 2727 // 11 shots
	fire_sound = 'sound/f13weapons/haloplasma.ogg'

/obj/item/ammo_casing/energy/plasma/pistol/covenantpistol/screech
	projectile_type = /obj/item/projectile/f13plasma/pistol/covenant/bane
	e_cost = 1450
	fire_sound = 'sound/f13weapons/haloplasma.ogg'

/obj/item/ammo_casing/energy/plasma/pistol/covenantrifle
	projectile_type = /obj/item/projectile/f13plasma/repeater/covenant
	e_cost = 1200
	fire_sound = 'sound/f13weapons/prrifle.ogg'

/obj/item/ammo_casing/energy/plasma/pistol/onirifle
	projectile_type = /obj/item/projectile/f13plasma/repeater/onibane
	e_cost = 700
	fire_sound = 'sound/f13weapons/prrifle.ogg'

/obj/item/ammo_casing/energy/plasma/pistol/caster
	projectile_type = /obj/item/projectile/f13plasma/plasmacaster
	fire_sound = 'sound/f13weapons/plasma_pistol.ogg'
	e_cost = 1350 //should be double of the eve caster

/obj/item/ammo_casing/energy/plasma/miner
	projectile_type = /obj/item/projectile/f13plasma/repeater/mining
	select_name = "mining plasma stream"
	fire_sound = 'sound/f13weapons/plasma_rifle.ogg'
	e_cost = 625 // may need changing later
