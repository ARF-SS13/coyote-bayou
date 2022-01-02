/obj/item/ammo_casing/energy/laser
	projectile_type = /obj/item/projectile/beam/laser
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun
	projectile_type = /obj/item/projectile/beam/laser
	e_cost = 83
	select_name = "kill"

/obj/item/ammo_casing/energy/lasergun/old
	projectile_type = /obj/item/projectile/beam/laser
	e_cost = 200
	select_name = "kill"

/obj/item/ammo_casing/energy/laser/hos
	e_cost = 100

/obj/item/ammo_casing/energy/laser/practice
	projectile_type = /obj/item/projectile/beam/practice
	select_name = "practice"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/scatter
	projectile_type = /obj/item/projectile/beam/scatter
	pellets = 5
	variance = 35
	select_name = "scatter"

/obj/item/ammo_casing/energy/laser/scatter/disabler
	projectile_type = /obj/item/projectile/beam/disabler
	pellets = 3
	variance = 15
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/heavy
	projectile_type = /obj/item/projectile/beam/laser/heavylaser
	select_name = "anti-vehicle"
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/ammo_casing/energy/laser/hellfire
	projectile_type = /obj/item/projectile/beam/laser/hellfire
	e_cost = 130
	select_name = "maim"

/obj/item/ammo_casing/energy/laser/pulse
	projectile_type = /obj/item/projectile/beam/pulse
	e_cost = 200
	select_name = "DESTROY"
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/ammo_casing/energy/laser/bluetag
	projectile_type = /obj/item/projectile/beam/lasertag/bluetag
	select_name = "bluetag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/bluetag/hitscan
	projectile_type = /obj/item/projectile/beam/lasertag/bluetag/hitscan

/obj/item/ammo_casing/energy/laser/redtag
	projectile_type = /obj/item/projectile/beam/lasertag/redtag
	select_name = "redtag"
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/redtag/hitscan
	projectile_type = /obj/item/projectile/beam/lasertag/redtag/hitscan

/obj/item/ammo_casing/energy/laser/redtag/hitscan/holy
	projectile_type = /obj/item/projectile/beam/lasertag/redtag/hitscan/holy

/obj/item/ammo_casing/energy/laser/magtag
	projectile_type = /obj/item/projectile/beam/lasertag/mag
	select_name = "magtag"
	pellets = 3
	variance = 30
	e_cost = 1000
	fire_sound = 'sound/weapons/magburst.ogg'

/obj/item/ammo_casing/energy/xray
	projectile_type = /obj/item/projectile/beam/xray
	e_cost = 50
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/mindflayer
	projectile_type = /obj/item/projectile/beam/mindflayer
	select_name = "MINDFUCK"
	fire_sound = 'sound/weapons/laser.ogg'

/*
---Fallout 13---
*/

/* here are the ammo sizes since nobody ever wrote these down
electron chargepack = 2400, this is currently only used in the RCW
mfc = 2000
ec = 1600

each one goes up by 4,000 power. why? nobody fucking knows lmao

also: most hitscan weapons have more charge than their normal projectile counterparts, since the actual projectiles are lower in damage and AP. this is to represent spammability.
*/

/obj/item/ammo_casing/energy/laser/scatter/tribeam
	projectile_type = /obj/item/projectile/beam/laser/tribeam
	pellets = 3
	variance = 14
	select_name = "scatter"
	e_cost = 180 //11 shots
	fire_sound = 'sound/f13weapons/tribeamfire.ogg'

/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan
	projectile_type = /obj/item/projectile/beam/laser/tribeam/hitscan
	pellets = 3
	variance = 45
	select_name = "tribeam"
	e_cost = 200 //10 shots

/obj/item/ammo_casing/energy/laser/pistol
	projectile_type = /obj/item/projectile/beam/laser/pistol
	e_cost = 80 //20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/hitscan //25 damage per, with 0 near 0 AP-4 shot crit on unarmored target, significantly less useful against armored
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan
	e_cost = 53.33 //30 shots, as per FNV

/obj/item/ammo_casing/energy/laser/ultra_pistol
	projectile_type = /obj/item/projectile/beam/laser/ultra_pistol
	e_cost = 80 //20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/ultra_rifle
	projectile_type = /obj/item/projectile/beam/laser/ultra_rifle
	e_cost = 80 //20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/recharger/hitscan
	projectile_type = /obj/item/projectile/beam/laser/recharger/hitscan
	e_cost = 100 //20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/stun  //compliance regulator
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/stun
	e_cost = 100
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/pistol/wattz
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz
	e_cost = 100 //16 shots

/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/magneto

/obj/item/ammo_casing/energy/laser/pistol/wattz/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/hitscan
	e_cost = 53.33 //30 shots, as per FNV

/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/magneto/hitscan
	e_cost = 53.33 //30 shots, as per FNV

/obj/item/ammo_casing/energy/laser/lasgun
	projectile_type = /obj/item/projectile/beam/laser/lasgun
	e_cost = 100 //20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

/obj/item/ammo_casing/energy/laser/lasgun/hitscan
	projectile_type = /obj/item/projectile/beam/laser/lasgun/hitscan
	e_cost = 80 //25 shots, as per FNV

/obj/item/ammo_casing/energy/laser/solar
	projectile_type = /obj/item/projectile/beam/laser/solar
	e_cost = 30 //basically infinite shots
	fire_sound = 'sound/f13weapons/laser_pistol.ogg'

/obj/item/ammo_casing/energy/laser/solar/hitscan
	projectile_type = /obj/item/projectile/beam/laser/solar/hitscan
	e_cost = 125 //16 shots, self charges. selfchargng adds 100 each time it fires off, so 2 ticks per laser recharge.

/obj/item/ammo_casing/energy/laser/rcw
	projectile_type = /obj/item/projectile/beam/laser/rcw
	e_cost = 100 //11 shots
	fire_sound = 'sound/f13weapons/rcwfire.ogg'

/obj/item/ammo_casing/energy/laser/rcw/hitscan
	projectile_type = /obj/item/projectile/beam/laser/rcw/hitscan
	e_cost = 50 //it's actually 24 shots now, as it fires in a burst of 2

/obj/item/ammo_casing/energy/laser/laer
	projectile_type = /obj/item/projectile/beam/laser/laer
	e_cost = 125 //16 shots
	fire_sound = 'sound/f13weapons/laerfire.ogg'

/obj/item/ammo_casing/energy/laser/laer/hitscan
	projectile_type = /obj/item/projectile/beam/laser/laer/hitscan

/obj/item/ammo_casing/energy/laser/aer14
	projectile_type = /obj/item/projectile/beam/laser/aer14
	e_cost = 80 //25 shots
	fire_sound = 'sound/f13weapons/aer14fire.ogg'

/obj/item/ammo_casing/energy/laser/aer14/hitscan
	projectile_type = /obj/item/projectile/beam/laser/aer14/hitscan
	e_cost = 133.33 //15 shots, i hate the decimal value too trust me

/obj/item/ammo_casing/energy/laser/aer12
	projectile_type = /obj/item/projectile/beam/laser/aer12
	e_cost = 100 //20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

/obj/item/ammo_casing/energy/laser/aer12/hitscan
	projectile_type = /obj/item/projectile/beam/laser/aer12/hitscan
	e_cost = 100 //20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

/obj/item/ammo_casing/energy/gammagun
	projectile_type = /obj/item/projectile/beam/gamma
	e_cost = 75
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/wattz2k
	projectile_type = /obj/item/projectile/beam/laser/wattz2k
	e_cost = 125

/obj/item/ammo_casing/energy/wattz2k/hitscan
	projectile_type = /obj/item/projectile/beam/laser/wattz2k/hitscan
	e_cost = 80 //25 //32.5 shots

/obj/item/ammo_casing/energy/wattz2k/extended
	projectile_type = /obj/item/projectile/beam/laser/wattz2k
	e_cost = 62.5 //32.5 shots

/obj/item/ammo_casing/energy/wattz2k/extended/hitscan
	projectile_type = /obj/item/projectile/beam/laser/wattz2k/hitscan

//musket

/obj/item/ammo_casing/energy/laser/musket
	projectile_type = /obj/item/projectile/beam/laser/musket
	e_cost = 250
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

// BETA // Obsolete
/obj/item/ammo_casing/energy/laser/pistol/lasertest
	projectile_type = /obj/item/projectile/beam/laser/pistol/lasertesting
