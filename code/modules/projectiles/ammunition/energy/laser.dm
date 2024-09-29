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
	variance = 25
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

/* KELP NOTES
10000 energy = small energy cell
20000 energy = electron charge pack
30000 energy = micro fusion cell
40000 energy = ultracite cell
50000 energy = alien cell

Projectile weapons should be stronger than hitscan weapons, either through damage or shot efficiency.

Avoid decimals when possible when it comes to e_cost!
*/

/obj/item/ammo_casing/energy/laser/scatter/tribeam
	projectile_type = /obj/item/projectile/beam/laser/tribeam
	pellets = 3
	variance = 14
	select_name = "scatter"
	e_cost = 2500 // 12 shots
	fire_sound = 'sound/f13weapons/tribeamfire.ogg'

/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan
	projectile_type = /obj/item/projectile/beam/laser/tribeam/hitscan
	pellets = 3
	variance = 38
	select_name = "tribeam"
	e_cost = 3000 // 10 shots

/obj/item/ammo_casing/energy/laser/scatter/tribeam/laserbuss
	projectile_type = /obj/item/projectile/beam/laser/tribeam/laserbuss
	pellets = 8
	variance = 14
	select_name = "scatter"
	e_cost = 3750 // 8 shots
	fire_sound = 'sound/f13weapons/tribeamfire.ogg'

/obj/item/ammo_casing/energy/laser/scatter/tribeam/laserbuss/hitscan
	projectile_type = /obj/item/projectile/beam/laser/tribeam/laserbuss/hitscan
	pellets = 8
	variance = 50
	select_name = "tribeam"
	e_cost = 15000 //2 shots

/obj/item/ammo_casing/energy/laser/scatter/tribeam/hitscan/nonlethal
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/stun
	pellets = 3
	variance = 38
	select_name = "tribeam"
	e_cost = 1500 //20 shots
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/pistol
	projectile_type = /obj/item/projectile/beam/laser/pistol
	e_cost = 500 // 20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/hitscan //25 damage per, with 0 near 0 AP-4 shot crit on unarmored target, significantly less useful against armored
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan
	e_cost = 400 // 25 shots
	damage_threshold_penetration = 4 // Doesn't pierce as much armor or hit as hard, but has more ammo capacity than the 1k

/obj/item/ammo_casing/energy/laser/pistol/hitscan/worn //25 damage per, with 0 near 0 AP-4 shot crit on unarmored target, significantly less useful against armored
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan
	e_cost = 500 //20 shots, to make it a little more on par to wattz 1k
	damage_threshold_penetration = 4 // Doesn't pierce as much armor or hit as hard, but has more ammo capacity than the 1k

/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_0_dt_pierce
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce
	e_cost = 1
	damage_threshold_penetration = 0

/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_10_dt_pierce
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce
	e_cost = 1
	damage_threshold_penetration = 10

/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_0_dt_pierce_50_ap
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce_50_ap
	e_cost = 1
	damage_threshold_penetration = 0

/obj/item/ammo_casing/energy/laser/pistol/hitscan/debug_10_damage_10_dt_pierce_50_ap
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce_50_ap
	e_cost = 1
	damage_threshold_penetration = 10

/obj/item/ammo_casing/energy/laser/ultra_pistol
	projectile_type = /obj/item/projectile/beam/laser/ultra_pistol
	e_cost = 500 // 20 shots, apparently it's a SEC despite the name?
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/ultra_rifle
	projectile_type = /obj/item/projectile/beam/laser/ultra_rifle
	e_cost = 2000 //20 shots
	fire_sound = 'sound/f13weapons/aep7fire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/recharger/hitscan
	projectile_type = /obj/item/projectile/beam/laser/recharger/hitscan
	e_cost = 1500 // 20 shots
	fire_sound = 'sound/f13weapons/RechargerFire.ogg'

/obj/item/ammo_casing/energy/laser/stun  //compliance regulator
	projectile_type = /obj/item/projectile/beam/laser/pistol/hitscan/stun
	e_cost = 625 // 16 shots
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/pistol/retro //this gun prolly sucks for now. will see
	projectile_type = /obj/item/projectile/beam/laser/pistol/retro
	e_cost = 1250 // holdout laser, 8 shots
	fire_sound = 'sound/weapons/laser.ogg'

/obj/item/ammo_casing/energy/laser/pistol/wattz
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz
	e_cost = 625 // 16 shots Civilian gun hits harder but has less charge.
	fire_sound = 'sound/f13weapons/WattzPistolFire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/magneto
	damage_threshold_penetration = 7
	variance = -100

/obj/item/ammo_casing/energy/laser/pistol/wattz/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/hitscan
	e_cost = 625 // 16 Shots. More than enough to kill anything that moves. The wattz 1k isn't even in FNV.
	damage_threshold_penetration = 3 // Better against lightly armored targets.

/obj/item/ammo_casing/energy/laser/pistol/wattz/magneto/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattz/magneto/hitscan
	e_cost = 1000 // 10 Shots. That extra Armor pen has to come out of somewhere.

/obj/item/ammo_casing/energy/laser/pistol/wattzs
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattzs
	e_cost = 333 // 30 shots
	fire_sound = 'sound/f13weapons/WattzPistolFire.ogg'

/obj/item/ammo_casing/energy/laser/pistol/wattzs/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/wattzs/hitscan
	e_cost = 250 // 40 Shots
	damage_threshold_penetration = 4 // Better against slightly more armored targets

/obj/item/ammo_casing/energy/laser/lasgun
	projectile_type = /obj/item/projectile/beam/laser/lasgun
	e_cost = 1500 // 20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

/obj/item/ammo_casing/energy/laser/lasgun/hitscan
	projectile_type = /obj/item/projectile/beam/laser/lasgun/hitscan
	e_cost = 1500 // 20; lore-accurate 25 shots is just a touch too good for a T1.5 / T2 gun

/obj/item/ammo_casing/energy/laser/lasgun/hitscan/focused
	projectile_type = /obj/item/projectile/beam/laser/lasgun/hitscan/focused
	e_cost = 1500 // 20 shots, 2rnd burst

/obj/item/ammo_casing/energy/laser/lasgun/ultra
	projectile_type = /obj/item/projectile/beam/laser/ultra_rifle
	e_cost = 1000 // 40 shots

/obj/item/ammo_casing/energy/laser/solar
	projectile_type = /obj/item/projectile/beam/laser/solar
	e_cost = 1875 // same as the hitscan, though this is unused
	fire_sound = 'sound/f13weapons/laser_pistol.ogg'

/obj/item/ammo_casing/energy/laser/solar/hitscan
	projectile_type = /obj/item/projectile/beam/laser/solar/hitscan
	e_cost = 1875 // 16 shots, the gun self charges over 30 seconds

/obj/item/ammo_casing/energy/laser/pistol/badlands
	projectile_type = /obj/item/projectile/beam/laser/pistol/badlands
	pellets = 2
	variance = 20
	e_cost = 625 // 16 shots
	fire_sound = 'sound/f13weapons/laser_pistol.ogg'

/obj/item/ammo_casing/energy/laser/pistol/badlands/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/badlands/hitscan
	e_cost = 625

/obj/item/ammo_casing/energy/laser/pistol/badlands/worn
	projectile_type = /obj/item/projectile/beam/laser/pistol/badlands/worn
	pellets = 2
	variance = 20
	e_cost = 1000 //10 shots
	fire_sound = 'sound/f13weapons/laser_pistol.ogg'

/obj/item/ammo_casing/energy/laser/pistol/badlands/worn/hitscan
	projectile_type = /obj/item/projectile/beam/laser/pistol/badlands/worn/hitscan
	e_cost = 1000

/obj/item/ammo_casing/energy/laser/pistol/freeblade
	projectile_type = /obj/item/projectile/beam/laser/pistol/freeblade
	pellets = 3
	variance = 35
	e_cost = 1666 // 6 shots
	fire_sound = 'sound/f13weapons/laser_pistol.ogg'

/obj/item/ammo_casing/energy/laser/rcw
	projectile_type = /obj/item/projectile/beam/laser/rcw
	e_cost = 1000 // 20 shots
	fire_sound = 'sound/f13weapons/rcwfire.ogg'

/obj/item/ammo_casing/energy/laser/stunrcw
	projectile_type = /obj/item/projectile/beam/disabler
	e_cost = 800 // 25 shots
	harmful = FALSE

/obj/item/ammo_casing/energy/laser/rcw/hitscan
	projectile_type = /obj/item/projectile/beam/laser/rcw/hitscan
	e_cost = 400 // 50 shots, just like an actual drum Thompson

/obj/item/ammo_casing/energy/laser/gatling/hitscan
	projectile_type = /obj/item/projectile/beam/laser/gatling/hitscan
	e_cost = 100 // 200 shots, because fuck you, fuck the wall behind you, fuck the 10 guys around you, and fuck your index finger.

/obj/item/ammo_casing/energy/laser/laer
	projectile_type = /obj/item/projectile/beam/laser/laer
	e_cost = 1875 //16 shots
	fire_sound = 'sound/f13weapons/laerfire.ogg'

/obj/item/ammo_casing/energy/laser/laer/hitscan
	projectile_type = /obj/item/projectile/beam/laser/laer/hitscan

/obj/item/ammo_casing/energy/laser/aer14
	projectile_type = /obj/item/projectile/beam/laser/aer14
	e_cost = 1200 // 25 shots
	fire_sound = 'sound/f13weapons/aer14fire.ogg'

/obj/item/ammo_casing/energy/laser/aer14/hitscan
	projectile_type = /obj/item/projectile/beam/laser/aer14/hitscan
	e_cost = 1200 // 25 shots

/obj/item/ammo_casing/energy/laser/aer12
	projectile_type = /obj/item/projectile/beam/laser/aer12
	e_cost = 1500 // 20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'

/obj/item/ammo_casing/energy/laser/aer12/hitscan
	projectile_type = /obj/item/projectile/beam/laser/aer12/hitscan
	e_cost = 1500 // 20 shots
	fire_sound = 'sound/f13weapons/aer9fire.ogg'
	damage_threshold_penetration = 6 //Upgraded gun lets more damage through than a typical rifle.

/obj/item/ammo_casing/energy/gammagun
	projectile_type = /obj/item/projectile/beam/gamma
	e_cost = 400 // 25 shots
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/wattz2k
	projectile_type = /obj/item/projectile/beam/laser/wattz2k
	e_cost = 2000 // 15 shots; AER has 20
	fire_sound = 'sound/f13weapons/WattzRifleFire.ogg'

/obj/item/ammo_casing/energy/wattz2k/hitscan
	projectile_type = /obj/item/projectile/beam/laser/wattz2k/hitscan
	e_cost = 2500 // 12 shots; AER has 20
	damage_threshold_penetration = 7 //You're a sniper laser, act like it.

/obj/item/ammo_casing/energy/wattz2k/extended
	projectile_type = /obj/item/projectile/beam/laser/wattz2k
	e_cost = 1875 // 16 shots

/obj/item/ammo_casing/energy/wattz2k/extended/hitscan
	projectile_type = /obj/item/projectile/beam/laser/wattz2k/hitscan/weak
	damage_threshold_penetration = 4 //The prices you pay for ammo efficiency.

/obj/item/ammo_casing/energy/wattz2ks
	projectile_type = /obj/item/projectile/beam/laser/wattz2ks
	e_cost = 1600 // 25 shots
	fire_sound = 'sound/f13weapons/WattzRifleFire.ogg'

/obj/item/ammo_casing/energy/wattz2ks/hitscan
	projectile_type = /obj/item/projectile/beam/laser/wattz2ks/hitscan
	e_cost = 1200 // 25 shots
	damage_threshold_penetration = 7 //You're a sniper laser, act like it.

//musket

/obj/item/ammo_casing/energy/laser/musket
	projectile_type = /obj/item/projectile/beam/laser/musket
	e_cost = 250
	fire_sound = 'sound/weapons/laser3.ogg'

//autolasers

/obj/item/ammo_casing/energy/laser/autolaser
	projectile_type = /obj/item/projectile/beam/laser/rcw/hitscan/autolaser
	e_cost = 333 // 60 shots. Ish.

/obj/item/ammo_casing/energy/laser/autolaser/twinshot
	projectile_type = /obj/item/projectile/beam/laser/rcw/hitscan/autolaser/twinshot
	e_cost = 400 // 50 shots

/obj/item/ammo_casing/energy/laser/autolaser/worn
	projectile_type = /obj/item/projectile/beam/laser/rcw/hitscan/autolaser/worn
	e_cost = 333 // 60 shots

/obj/item/ammo_casing/energy/laser/autolaser/shock
	projectile_type = /obj/item/projectile/energy/teslacannon/oasis
	fire_sound = 'sound/weapons/taser.ogg'
	e_cost = 400 // 50 shots

/obj/item/ammo_casing/energy/laser/mpc
	projectile_type = /obj/item/projectile/beam/laser/mpc
	e_cost = 333 // 60 shots. Ish.
	fire_sound = 'sound/weapons/magpistol.ogg'

/obj/item/ammo_casing/energy/laser/xcomufolaser
	projectile_type = /obj/item/projectile/beam/laser/xcom
	e_cost = 10 // 7 shots
	fire_sound = 'modular_coyote/sound/items/xcom/LaserRifleFire.wav'

// Kelp's TG blaster casings, internal cell has 5000 power units, CANNOT BE RELOADED IN THE FIELD KEEP THAT IN MIND.

/obj/item/ammo_casing/energy/laser/tg
	projectile_type = /obj/item/projectile/beam/laser/tg
	e_cost = 250 // 20 shots

/obj/item/ammo_casing/energy/laser/tg/carbine
	projectile_type = /obj/item/projectile/beam/laser/tg
	e_cost = 200 // 25 shots

/obj/item/ammo_casing/energy/laser/tg/rifle
	projectile_type = /obj/item/projectile/beam/laser/tg
	e_cost = 125 // 40 shots

/obj/item/ammo_casing/energy/laser/tg/rifle/heavy
	projectile_type = /obj/item/projectile/beam/laser/tg/heavy
	e_cost = 208 // 24 shots
	fire_sound = 'sound/weapons/pulse.ogg'

/obj/item/ammo_casing/energy/laser/tg/rifle/auto
	projectile_type = /obj/item/projectile/beam/laser/tg
	e_cost = 83 // 60 shots

/obj/item/ammo_casing/energy/laser/tg/recharger
	projectile_type = /obj/item/projectile/beam/laser/tg
	e_cost = 312 // 16 shots

/obj/item/ammo_casing/energy/laser/tg/nuclear
	projectile_type = /obj/item/projectile/beam/laser/tg/nuclear
	e_cost = 312 // 16 shots
	fire_sound = 'sound/weapons/laser3.ogg'

/obj/item/ammo_casing/energy/laser/tg/nuclear/rifle
	projectile_type = /obj/item/projectile/beam/laser/tg/nuclear
	e_cost = 208 // 24 shots

/obj/item/ammo_casing/energy/laser/tg/nuclear/rifle/worn
	projectile_type = /obj/item/projectile/beam/laser/tg/nuclear/worn

/obj/item/ammo_casing/energy/laser/tg/particle
	projectile_type = /obj/item/projectile/beam/laser/tg/particle
	e_cost = 1000 // 5 shots
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/ammo_casing/energy/laser/tg/spam
	projectile_type = /obj/item/projectile/beam/laser/tg/spam
	e_cost = 40 // 125 shots; might need adjustment. Half the DPS of a compact RCW

//Laser AK casings
/obj/item/ammo_casing/energy/laser/tg/kalashheavy
	projectile_type = /obj/item/projectile/beam/laser/tg/kalashheavy
	e_cost = 1000 // 30 shots
	fire_sound = 'sound/f13weapons/WattzRifleFire.ogg'

/obj/item/ammo_casing/energy/laser/tg/kalashlight
	projectile_type = /obj/item/projectile/beam/laser/tg/kalashlight
	e_cost = 1000 // 30 shots
	fire_sound = 'sound/f13weapons/WattzRifleFire.ogg'

// Halo casings
/obj/item/ammo_casing/energy/laser/tg/covenantbrr
	projectile_type = /obj/item/projectile/beam/laser/beam
	e_cost = 3000 // 10 shots
	fire_sound = 'sound/f13weapons/beamrifle.ogg'

//"Laser" Cov Carbine
/obj/item/ammo_casing/energy/laser/covcarbine
	projectile_type = /obj/item/projectile/beam/laser/mpc/covcarb
	e_cost = 1660 // ~18 shots, accurate to Halo 2
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'


// BETA // Obsolete
/obj/item/ammo_casing/energy/laser/pistol/lasertest
	projectile_type = /obj/item/projectile/beam/laser/pistol/lasertesting
