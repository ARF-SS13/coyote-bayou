/obj/item/projectile/beam
	name = "laser"
	icon_state = "laser"
	pass_flags = PASSTABLE| PASSGLASS
	damage = 20
	light_range = 2
	damage_type = BURN
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = "laser"
	eyeblur = 2
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED
	ricochets_max = 50	//Honk!
	ricochet_chance = 0
	is_reflectable = TRUE
	wound_bonus = -20
	bare_wound_bonus = 10
	recoil = BULLET_RECOIL_LASER
	sharpness = SHARP_POINTY // Temporary fix for the Wound system. Makes lasers/plasma bleed you out per hit.

/obj/item/projectile/f13plasma
	name = "plasma template"
	icon_state = "plasma_clot"
	sharpness = SHARP_POINTY // Temporary fix for the Wound system. Makes lasers/plasma bleed you out per hit.
	wound_bonus = 30 // plasma is horrific; should be overidden more often than not

/obj/item/projectile/beam/laser
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser
	wound_bonus = -30
	bare_wound_bonus = 40

/obj/item/projectile/beam/laser/mech
	hitscan = TRUE
	wound_bonus = 0

// Low energy drain and cooldown
/obj/item/projectile/beam/laser/mech/light
	name = "laser beam"
	damage = 60

// More energy drain and higher cooldown
/obj/item/projectile/beam/laser/mech/heavy
	name = "heavy laser beam"
	damage = 80
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser

// The highest energy drain and cooldown
/obj/item/projectile/beam/laser/mech/pulse
	name = "charged pulse beam"
	damage = 99
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse

//overclocked laser, does a bit more damage but has much higher wound power (-0 vs -20)
/obj/item/projectile/beam/laser/hellfire
	name = "hellfire laser"
	wound_bonus = 0
	damage = 25

/obj/item/projectile/beam/laser/hellfire/Initialize()
	. = ..()
	transform *= 2

/obj/item/projectile/beam/laser/heavylaser
	name = "heavy laser"
	icon_state = "heavylaser"
	damage = 40
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser

/obj/item/projectile/beam/laser/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.IgniteMob()
	else if(isturf(target))
		impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser/wall

/obj/item/projectile/beam/weak
	damage = 25

/obj/item/projectile/beam/weak/penetrator

/obj/item/projectile/beam/practice
	name = "practice laser"
	damage = 0
	nodamage = 1

/obj/item/projectile/beam/scatter
	name = "laser pellet"
	icon_state = "scatterlaser"
	damage = 12.5

/obj/item/projectile/beam/xray
	name = "\improper X-ray beam"
	icon_state = "xray"
	damage = 15
	irradiate = 300
	range = 15
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF

	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/item/projectile/beam/gamma
	name = "gamma beam"
	icon_state = "xray"
	damage = 25 //makes it more useful against mobs
	damage_list = list("20" = 30, "25" = 50, "30" = 20)
	flag = "energy"
	damage_type = "burn"
	irradiate = 400 // rad armor is easy to get; testing showed its old value to be basically useless
	range = 15
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE | PASSCLOSEDTURF

	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/item/projectile/beam/disabler
	name = "disabler beam"
	icon_state = "omnilaser"
	damage = 36 // Citadel change for balance from 36
	damage_list = list("31" = 30, "36" = 50, "41" = 20)
	damage_type = STAMINA
	flag = "energy"
	hitsound = 'sound/weapons/tap.ogg'
	eyeblur = 0
	pixels_per_second = TILES_TO_PIXELS(16.667)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler

/obj/item/projectile/beam/disabler/debug
	name = "debug disablebeam"
	stamina = 100

/obj/item/projectile/beam/pulse
	name = "pulse"
	icon_state = "u_laser"
	damage = 50
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	wound_bonus = 10

/obj/item/projectile/beam/pulse/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if (!QDELETED(target) && (isturf(target) || istype(target, /obj/structure/)))
		target.ex_act(EXPLODE_HEAVY)

/obj/item/projectile/beam/pulse/shotgun
	damage = 40

/obj/item/projectile/beam/pulse/heavy
	name = "heavy pulse laser"
	icon_state = "pulse1_bl"
	var/life = 20

/obj/item/projectile/beam/pulse/heavy/on_hit(atom/target, blocked = FALSE)
	life -= 10
	if(life > 0)
		. = BULLET_ACT_FORCE_PIERCE
	return ..()

/obj/item/projectile/beam/emitter
	name = "emitter beam"
	icon_state = "emitter"
	damage = 30
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	wound_bonus = -40
	bare_wound_bonus = 70

/obj/item/projectile/beam/emitter/singularity_pull()
	return

/obj/item/projectile/beam/emitter/hitscan
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter
	impact_effect_type = null

/obj/item/projectile/beam/lasertag
	name = "laser tag beam"
	icon_state = "omnilaser"
	hitsound = null
	damage = 0
	damage_type = STAMINA
	flag = "laser"
	var/suit_types = list(/obj/item/clothing/suit/redtag, /obj/item/clothing/suit/bluetag)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/lasertag/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/M = target
		if(istype(M.wear_suit))
			if(M.wear_suit.type in suit_types)
				M.adjustStaminaLoss(34)

/obj/item/projectile/beam/lasertag/mag		//the projectile, compatible with regular laser tag armor
	icon_state = "magjectile-toy"
	name = "lasertag magbolt"
	movement_type = FLYING | UNSTOPPABLE		//for penetration memes
	range = 5		//so it isn't super annoying
	light_range = 2
	light_color = LIGHT_COLOR_YELLOW
	eyeblur = 0

/obj/item/projectile/beam/lasertag/redtag
	icon_state = "laser"
	suit_types = list(/obj/item/clothing/suit/bluetag)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/lasertag/redtag/hitscan
	hitscan = TRUE

/obj/item/projectile/beam/lasertag/redtag/hitscan/holy
	name = "lasrifle beam"
	damage = 0.1
	damage_type = BURN

/obj/item/projectile/beam/lasertag/bluetag
	icon_state = "bluelaser"
	suit_types = list(/obj/item/clothing/suit/redtag)
	tracer_type = /obj/effect/projectile/tracer/laser/blue
	muzzle_type = /obj/effect/projectile/muzzle/laser/blue
	impact_type = /obj/effect/projectile/impact/laser/blue

/obj/item/projectile/beam/lasertag/bluetag/hitscan
	hitscan = TRUE

/obj/item/projectile/beam/instakill
	name = "instagib laser"
	icon_state = "purple_laser"
	damage = 200
	damage_type = BURN
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	light_color = LIGHT_COLOR_PURPLE

/obj/item/projectile/beam/instakill/blue
	icon_state = "blue_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/instakill/red
	icon_state = "red_laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/instakill/on_hit(atom/target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.visible_message(span_danger("[M] explodes into a shower of gibs!"))
		M.gib()

//a shrink ray that shrinks stuff, which grows back after a short while.
/obj/item/projectile/beam/shrink
	name = "shrink ray"
	icon_state = "blue_laser"
	hitsound = 'sound/weapons/shrink_hit.ogg'
	damage = 0
	damage_type = STAMINA
	flag = "energy"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/shrink
	light_color = LIGHT_COLOR_BLUE
	var/shrink_time = 90

/obj/item/projectile/beam/shrink/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(isopenturf(target) || istype(target, /turf/closed/indestructible))//shrunk floors wouldnt do anything except look weird, i-walls shouldnt be bypassable
		return
	target.AddComponent(/datum/component/shrink, shrink_time)

//musket
/obj/item/projectile/beam/laser/musket //musket
	name = "laser beam"
	damage = 45
	damage_list = list("40" = 30, "45" = 50, "50" = 20)
	hitscan = TRUE
	pixels_per_second = TILES_TO_PIXELS(50)

//plasma caster
/obj/item/projectile/f13plasma/plasmacaster
	name = "plasma bolt"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 60
	damage_list = list("55" = 30, "60" = 50, "65" = 20)
	flag = "energy"
	eyeblur = 0
	is_reflectable = TRUE

//Securitrons Beam
/obj/item/projectile/beam/laser/pistol/ultraweak
	damage = 15 //quantity over quality

//Alrem's plasmacaster
/obj/item/projectile/f13plasma/plasmacaster/arlem
	name = "plasma bolt"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 40
	damage_list = list("35" = 30, "40" = 50, "45" = 20)
	flag = "laser"
	eyeblur = 0
	is_reflectable = FALSE
	pixels_per_second = TILES_TO_PIXELS(25)

/obj/item/projectile/beam/laser/lasgun //AER9
	name = "laser beam"
	damage = 33

/obj/item/projectile/beam/laser/lasgun/hitscan //hitscan aer9 test
	name = "laser beam"
	damage = 32
	damage_list = list("28" = 30, "32" = 50, "37" = 20)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/lasgun/hitscan/focused
	name = "overcharged laser beam"
	damage = 32
	damage_list = list("22" = 30, "28" = 50, "33" = 20)

/obj/item/projectile/beam/laser/gatling/hitscan //Gatling Laser
	name = "laser beam"
	damage = 15
	damage_list = list("12" = 15, "15" = 50, "18" = 35)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol
	name = "laser beam"
	damage = 35
	damage_list = list("30" = 30, "35" = 50, "40" = 20)

/obj/item/projectile/beam/laser/pistol/wastebot
	name = "laser beam"
	damage = 35
	damage_list = list("30" = 30, "35" = 50, "40" = 20)
	pixels_per_second = TILES_TO_PIXELS(7.5)


/obj/item/projectile/beam/laser/pistol/hitscan //Actual AEP7
	name = "laser beam"
	damage = 24
	damage_list = list("19" = 30, "24" = 50, "29" = 20)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce
	name = "debug 10 damage 0 DT pierce"
	damage = 10
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/hitscan/debug_10_damage_0_dt_pierce_50_ap
	name = "debug 10 damage 0 DT pierce"
	damage = 10
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/hitscan/stun //compliance regulator beam
	name = "compliance beam"
	damage = 33
	damage_list = list("28" = 30, "33" = 50, "38" = 20)
	damage_type = STAMINA
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/disabler
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler
	is_reflectable = FALSE

	// This could be a bit overboard, if it actually worked.
	supereffective_damage = BULLET_DAMAGE_PISTOL_10MM
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/beam/laser/recharger/hitscan //hitscan recharger pistol
	name = "recharger beam"
	damage = 25
	damage_list = list("20" = 30, "25" = 50, "30" = 20)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	light_color = LIGHT_COLOR_BLUE


/obj/item/projectile/beam/laser/ultra_pistol //unused
	name = "laser beam"
	damage = 40
	irradiate = 200

/obj/item/projectile/beam/laser/ultra_rifle
	name = "ultracite beam"
	damage = 32
	damage_list = list("28" = 30, "32" = 50, "37" = 20)
	hitscan = TRUE
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray
	irradiate = 300

/obj/item/projectile/beam/laser/gatling //Gatling Laser Projectile
	name = "rapid-fire laser beam"
	damage = 12

/obj/item/projectile/beam/laser/pistol/retro
	name = "laser beam"
	damage = 40 //hits the trashmob threshold, the only thing making this gun okay
	damage_list = list("30" = 15, "40" = 65, "55" = 30)

/obj/item/projectile/beam/laser/pistol/wattz //Wattz pistol
	name = "laser beam"
	damage = 30
	damage_list = list("27" = 25, "30" = 50, "33" = 25)
	icon_state = "laser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/laser/pistol/wattz/hitscan //hitscan wattz
	name = "laser beam"
	damage = 26 // Civilian gun hits harder but has less charge now.
	damage_list = list("24" = 25, "26" = 50, "28" = 25)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/wattz/magneto //upgraded Wattz
	name = "penetrating laser beam"
	damage = 35
	damage_list = list("32" = 25, "35" = 50, "42" = 25)
	icon_state = "heavylaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED
	spread = -100

/obj/item/projectile/beam/laser/pistol/wattz/magneto/hitscan
	name = "penetrating laser beam"
	damage = 26 // Hits less than the W1K but has innate AP/DT reduction.
	damage_list = list("22" = 25, "26" = 50, "35" = 25)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/wattzs //Wattz 1000s pistol
	name = "laser beam"
	damage = 25
	damage_list = list( "25" = 30, "28" = 70)
	icon_state = "omnilaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/laser/pistol/wattzs/hitscan //hitscan wattz
	name = "laser beam"
	damage = 20 //Less damage but more charge
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/solar //Solar Scorcher
	name = "solar scorcher beam"
	damage = 28
	damage_list = list( "27" = 30, "28" = 70)

/obj/item/projectile/beam/laser/solar/hitscan
	name = "solar scorcher beam"
	damage = 27
	damage_list = list( "27" = 30, "28" = 70)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/pistol/badlands //Badland's Special
	name = "badland's special beam"
	damage = 25
	damage_list = list( "24" = 30, "26" = 70)
	icon_state = "bluelaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/laser/pistol/badlands/hitscan
	name = "badland's special beam"
	damage = 24
	damage_list = list( "24" = 30, "26" = 70)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/badlands
	muzzle_type = /obj/effect/projectile/muzzle/laser/badlands
	impact_type = /obj/effect/projectile/impact/laser/badlands

/obj/item/projectile/beam/laser/pistol/badlands/worn //Worn Badland's Special
	name = "badland's special beam"
	damage = 20
	damage_list = list( "19" = 30, "21" = 70)
	icon_state = "bluelaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/laser/pistol/badlands/worn/hitscan
	name = "badland's special beam"
	damage = 24
	damage_list = list( "23" = 30, "25" = 70)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/laser/badlands
	muzzle_type = /obj/effect/projectile/muzzle/laser/badlands
	impact_type = /obj/effect/projectile/impact/laser/badlands

/obj/item/projectile/beam/laser/pistol/freeblade //Freeblade Blaster
	name = "freeblade beam"
	damage = 15
	damage_list = list( "14" = 30, "16" = 70)
	icon_state = "freeblade"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/beam/laser/tribeam //Tribeam laser, fires 3 shots, will melt you
	name = "tribeam laser"
	damage = 21

/obj/item/projectile/beam/laser/tribeam/hitscan
	name = "tribeam laser"
	damage = 25 //if all bullets connect, this will do 75.
	damage_list = list( "24" = 30, "26" = 70)
	hitscan = TRUE
	bare_wound_bonus = -30 //tribeam is bad at wounding, as basically its only real downside
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/beam/laser/tribeam/laserbuss //Tribeam laser, fires 3 shots, will melt you
	name = "tribeam laser"
	damage = 21
	damage_list = list( "20" = 30, "22" = 70)

/obj/item/projectile/beam/laser/tribeam/laserbuss/hitscan
	name = "tribeam laser"
	damage = 20
	damage_list = list( "20" = 30, "22" = 70)
	hitscan = TRUE
	bare_wound_bonus = -30 //tribeam is bad at wounding, as basically its only real downside
	tracer_type = /obj/effect/projectile/tracer/laser
	muzzle_type = /obj/effect/projectile/muzzle/laser
	impact_type = /obj/effect/projectile/impact/laser

/obj/item/projectile/f13plasma/rifle //Plasma rifle
	name = "plasma bolt"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 60 //fucc you normies
	damage_list = list( "55" = 30, "60" = 50, "65" = 20)
	flag = "energy" //checks vs. energy protection
	wound_bonus = 40 //being hit with plasma is horrific
	eyeblur = 0
	is_reflectable = TRUE
	pixels_per_second =  TILES_TO_PIXELS(10) //same as 40mm grenade
	recoil = BULLET_RECOIL_PLASMA

/obj/item/projectile/plasmacarbine //Plasma carbine
	name = "plasma bolt"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 40
	damage_list = list( "35" = 30, "40" = 50, "45" = 20)
	flag = "energy" //checks vs. energy protection
	wound_bonus = 50 //let's not make the carbine horrifying // nah lets make it horrifying
	eyeblur = 0
	is_reflectable = TRUE
	pixels_per_second = TILES_TO_PIXELS(10)
	recoil = BULLET_RECOIL_PLASMA

/obj/item/projectile/f13plasma/repeater //Plasma repeater
	name = "plasma stream"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 40
	damage_list = list( "35" = 30, "40" = 50, "45" = 20)
	flag = "energy" //checks vs. energy protection
	eyeblur = 0
	is_reflectable = FALSE

/obj/item/projectile/f13plasma/repeater/mining
	name = "mining plasma stream"
	icon_state = "plasma_clot"
	damage_type = BURN
	damage = 25
	flag = "energy"
	eyeblur = 0
	is_reflectable = FALSE

/obj/item/projectile/f13plasma/repeater/mining/on_hit(atom/target)
	. = ..()
	if(ismineralturf(target))
		var/turf/closed/mineral/M = target
		M.gets_drilled(firer)

/obj/item/projectile/f13plasma/pistol //Plasma pistol
	damage = 35
	damage_type = BURN
	damage_list = list( "34" = 30, "35" = 50, "50" = 20)
	wound_bonus = 70 //being hit with plasma is horrific

/obj/item/projectile/f13plasma/pistol/eve //Eve
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	icon_state = "eve"
	damage = 45
	damage_list = list( "44" = 30, "45" = 50, "60" = 20)
	wound_bonus = 75 //being hit with plasma is horrific
	light_color = LIGHT_COLOR_PINK

/obj/item/projectile/f13plasma/pistol/eve/worn //Eve worn
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	icon_state = "eve"
	damage = 35
	damage_list = list( "34" = 30, "35" = 50, "55" = 20)
	wound_bonus = 65 //being hit with plasma is horrific
	light_color = LIGHT_COLOR_PINK

/obj/item/projectile/f13plasma/pistol/adam //Adam
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	icon_state = "adam"
	damage = 55
	damage_list = list( "54" = 30, "55" = 50, "70" = 20)
	wound_bonus = 35 //Adam is stronger, but not in the wounding department.
	light_color = LIGHT_COLOR_RED

/obj/item/projectile/f13plasma/pistol/adam/simple //Adam
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	icon_state = "adam"
	damage = 55
	damage_list = list( "54" = 30, "55" = 50, "70" = 20)
	wound_bonus = 35 //Adam is stronger, but not in the wounding department.
	light_color = LIGHT_COLOR_RED
	pixels_per_second = BULLET_SPEED_RIFLE_223_HANDLOAD * 0.3

/obj/item/projectile/f13plasma/pistol/worn
	damage = 30

/obj/item/projectile/f13plasma/pistol/glock //Glock (streamlined plasma pistol)
	damage = 40
	damage_list = list( "39" = 30, "40" = 50, "55" = 20)
	wound_bonus = 35 //being hit with plasma is horrific

/obj/item/projectile/f13plasma/scatter //Multiplas, fires 3 shots, will melt you
	damage = 35
	damage_list = list( "34" = 30, "35" = 50, "55" = 20)
	pixels_per_second = BULLET_SPEED_RIFLE_223_HANDLOAD * 0.3

/obj/item/projectile/beam/laser/rcw //RCW
	name = "rapidfire beam"
	icon_state = "xray"
	damage = 30
	damage_list = list( "25" = 30, "30" = 40, "31" = 30)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN

/obj/item/projectile/beam/laser/rcw/hitscan //RCW
	name = "rapidfire beam"
	icon_state = "emitter"
	damage = 19
	damage_list = list( "14" = 30, "19" = 40, "24" = 30)
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/laser/emitter
	tracer_type = /obj/effect/projectile/tracer/laser/emitter
	impact_type = /obj/effect/projectile/impact/laser/emitter
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser

/obj/item/projectile/beam/laser/rcw/hitscan/autolaser //Compact RCW
	damage = 10 //Good for piercing armor, terrible damage
	damage_list = list( "8" = 15, "10" = 40, "11" = 45)
	bare_wound_bonus = -20 //The intensity of the beams are no where near enough to cause lasting prolonged trauma.

/obj/item/projectile/beam/laser/rcw/hitscan/autolaser/twinshot // burst RCW
	name = "intense twinbeam"
	damage = 15 // Good for piercing armor, terrible damage
	damage_list = list( "14" = 15, "15" = 40, "16" = 45)
	flag = "energy" // to bring it on par with the tesla autoshock
	bare_wound_bonus = -20 // The intensity of the beams are no where near enough to cause lasting prolonged trauma.

/obj/item/projectile/beam/laser/rcw/hitscan/autolaser/worn //Compact RCW
	damage = 9 //Good for piercing armor, terrible damage
	damage_list = list( "8" = 15, "9" = 40, "10" = 45)
	bare_wound_bonus = -20 //The intensity of the beams are no where near enough to cause lasting prolonged trauma.

/obj/item/projectile/beam/laser/mpc
	name = "iron slug"
	icon_state = "magjectile"
	damage = 10
	damage_list = list( "9" = 15, "10" = 40, "11" = 45)
	flag = "bullet"
	hitsound_wall = "ricochet"
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	sharpness = SHARP_POINTY

//Covie Carbine "bullet"
/obj/item/projectile/beam/laser/mpc/covcarb
	name = "crystal"
	icon_state = "plasma1"
	damage = 30
	damage_list = list("20" = 8, "25" = 8, "30" = 55, "35" = 10, "40" = 19)
	stamina = BULLET_STAMINA_PISTOL_10MM
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_PISTOL_10MM
	light_color = LIGHT_COLOR_GREEN

/obj/item/projectile/f13plasma/pistol/alien
	name = "alien projectile"
	icon_state = "ion"
	damage = 90 //horrifyingly powerful, but very limited ammo
	damage_list = list( "85" = 15, "90" = 40, "120" = 45)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_range = 2
	light_color = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/laser/laer //Elder's/Unique LAER
	name = "advanced laser beam"
	icon_state = "u_laser"
	damage = 45
	damage_list = list( "32" = 30, "45" = 40, "50" = 15, "75" = 15)
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/laer/hitscan
	hitscan = TRUE

/obj/item/projectile/beam/laser/laer/hitscan/Initialize()
	. = ..()
	transform *= 2

/obj/item/projectile/beam/laser/aer14 //AER14
	name = "laser beam"
	damage = 50 //unique and hefty
	damage_list = list( "45" = 25, "50" = 40, "55" = 25)
	icon_state = "omnilaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/aer14/hitscan
	damage = 42
	damage_list = list( "42" = 25, "48" = 40, "53" = 25)
	wound_bonus = 20
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	hitscan = TRUE
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = LIGHT_COLOR_BLUE
	muzzle_flash_intensity = 6
	muzzle_flash_range = 2
	muzzle_flash_color_override = LIGHT_COLOR_BLUE
	impact_light_intensity = 7
	impact_light_range = 2.5
	impact_light_color_override = LIGHT_COLOR_BLUE

/obj/item/projectile/beam/laser/aer12 //AER12
	name = "laser beam"
	damage = 36
	icon_state = "xray"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/aer12/hitscan
	name = "laser beam"
	damage = 36
	damage_list = list( "34" = 25, "36" = 50, "38" = 25)
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_LIME
	muzzle_flash_intensity = 6
	muzzle_flash_range = 2
	muzzle_flash_color_override = COLOR_LIME
	impact_light_intensity = 7
	impact_light_range = 2.5
	impact_light_color_override = COLOR_LIME

/obj/item/projectile/beam/laser/wattz2k
	name = "laser bolt"
	damage = 35
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/wattz2k/hitscan
	name = "sniper laser bolt"
	damage = 52
	damage_list = list( "50" = 25, "52" = 40, "54" = 25)
	wound_bonus = 10
	bare_wound_bonus = 20
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser
	hitscan = TRUE

/obj/item/projectile/beam/laser/wattz2k/hitscan/weak //Hits less than the main wattz2k but has more shots comparable to an aer9
	name = "weak sniper laser bolt"
	damage = 40
	damage_list = list( "38" = 25, "40" = 40, "42" = 25)
	wound_bonus = 10
	bare_wound_bonus = 20
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser
	hitscan = TRUE

/obj/item/projectile/beam/laser/beam //Covenant version of a watzz2k hitscan proj. Hits like a semi-truck
	name = "sniper laser bolt"
	damage = 80
	damage_list = list( "70" = 25, "80" = 40, "85" = 25)
	wound_bonus = 10
	bare_wound_bonus = 20
	tracer_type = /obj/effect/projectile/tracer/covbeamlaser
	muzzle_type = /obj/effect/projectile/muzzle/disabler
	impact_type = /obj/effect/projectile/impact/disabler
	hitscan = TRUE
	muzzle_flash_intensity = 6
	muzzle_flash_range = 2
	muzzle_flash_color_override = LIGHT_COLOR_CYAN
	impact_light_intensity = 7
	impact_light_range = 2.5
	impact_light_color_override = LIGHT_COLOR_CYAN
	light_color = LIGHT_COLOR_CYAN

/obj/item/projectile/f13plasma/pistol/covenant
	name = "plasma energy bolt"
	icon_state = "plasmapistol"
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	damage = 20
	damage_list = list( "18" = 25, "20" = 40, "25" = 25)
	wound_bonus = 8
	bare_wound_bonus = 18
	hitscan = FALSE
	is_reflectable = FALSE
	pixels_per_second = TILES_TO_PIXELS(10)
	recoil = BULLET_RECOIL_PLASMA
	light_color = LIGHT_COLOR_GREEN
	damage_type = BURN
	flag = "energy"
	supereffective_damage = 12
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/f13plasma/pistol/covenant/bane
	name = "plasma energy bolt"
	icon_state = "plasmapistol"
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	damage = 35
	damage_list = list( "30" = 25, "35" = 40, "38" = 25)
	wound_bonus = 12
	bare_wound_bonus = 23
	hitscan = FALSE
	is_reflectable = FALSE
	pixels_per_second = TILES_TO_PIXELS(15)
	recoil = BULLET_RECOIL_PLASMA
	light_color = LIGHT_COLOR_BLUEGREEN
	damage_type = BURN
	flag = "energy"
	supereffective_damage = 20
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/f13plasma/repeater/covenant
	name = "plasma energy bolt"
	icon_state = "prshot"
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	damage = 15
	damage_list = list( "10" = 25, "15" = 40, "20" = 25)
	wound_bonus = 6
	bare_wound_bonus = 16
	hitscan = FALSE
	is_reflectable = FALSE
	pixels_per_second = TILES_TO_PIXELS(12)
	recoil = BULLET_RECOIL_PLASMA
	light_color = LIGHT_COLOR_BLUE
	damage_type = BURN
	flag = "energy"
	supereffective_damage = 11
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/f13plasma/repeater/onibane
	name = "plasma energy bolt"
	icon_state = "onishot"
	icon = 'icons/fallout/objects/guns/projectiles.dmi'
	impact_effect_type = /obj/effect/temp_visual/impact_effect/red_laser
	damage = 25
	damage_list = list( "23" = 25, "25" = 40, "28" = 25)
	wound_bonus = 10
	bare_wound_bonus = 20
	hitscan = FALSE
	is_reflectable = FALSE
	recoil = BULLET_RECOIL_PLASMA
	pixels_per_second = TILES_TO_PIXELS(17)
	light_color = LIGHT_COLOR_RED
	damage_type = BURN
	flag = "energy"
	supereffective_damage = 18
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/beam/laser/wattz2ks
	name = "laser bolt"
	damage = 35
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/wattz2ks/hitscan
	name = "sniper laser bolt"
	damage = 45
	damage_list = list( "40" = 25, "45" = 40, "50" = 25)
	wound_bonus = 5
	bare_wound_bonus = 15
	tracer_type = /obj/effect/projectile/tracer/heavy_laser
	muzzle_type = /obj/effect/projectile/muzzle/heavy_laser
	impact_type = /obj/effect/projectile/impact/heavy_laser
	hitscan = TRUE

/obj/item/projectile/beam/laser/musket //musket
	name = "laser bolt"
	damage = 40
	recoil = BULLET_RECOIL_HEAVY_LASER


/obj/item/projectile/beam/laser/xcom
	name = "laser beam"
	damage_low = 0
	damage = 30
	damage_high = 60
	recoil = BULLET_RECOIL_HEAVY_LASER //I want the burst fire to have some level of RNG deviation
	tracer_type = /obj/effect/projectile/tracer/laser/solar
	muzzle_type = /obj/effect/projectile/muzzle/laser/solar
	impact_type = /obj/effect/projectile/impact/laser/solar
	hitscan = TRUE
	hitsound = 'modular_coyote/sound/items/xcom/Laserhit.wav'
	hitsound_wall = 'modular_coyote/sound/items/xcom/Laserhit.wav'

// Kelp's TG blaster projectiles, should almost all be projectiles and not hitscan
/obj/item/projectile/beam/laser/tg
	name = "blaster bolt"
	damage = 30
	damage_list = list("25" = 25, "30" = 25, "35" = 25, "40" = 25)
	recoil = BULLET_RECOIL_HEAVY_LASER

/obj/item/projectile/beam/laser/tg/heavy
	name = "intense blaster bolt"
	damage = 60
	damage_list = list("55" = 25, "60" = 25, "65" = 25, "70" = 25)
	wound_bonus = 40 // nasty, but it's still a laser.
	recoil = BULLET_RECOIL_PLASMA

/obj/item/projectile/beam/laser/tg/nuclear
	name = "nuclear laser bolt"
	icon_state = "xray"
	irradiate = 300
	impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	light_color = LIGHT_COLOR_GREEN
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/item/projectile/beam/laser/tg/nuclear/worn
	damage = 30
	damage_list = list("25" = 25, "30" = 45, "35" = 25, "40" = 5)

/obj/item/projectile/beam/laser/tg/particle
	name = "hyper-velocity particle beam"
	icon_state = "emitter"
	damage = 100 // With no -HP traits, any light armor saves you and EVERYONE is armored; you get 5 shots and can't reload in the field
	damage_list = list("90" = 25, "100" = 25, "115" = 25, "130" = 24, "1000" = 1) //fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you fuck you ~TK
	wound_bonus = 60 // nasty, but it's still a laser
	supereffective_damage = 150 // Unlike .50 BMG guns, you can't reload in the field
	supereffective_faction = list("hostile", "ant", "supermutant", "deathclaw", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")
	hitscan = TRUE
	tracer_type = /obj/effect/projectile/tracer/xray
	muzzle_type = /obj/effect/projectile/muzzle/xray
	impact_type = /obj/effect/projectile/impact/xray

/obj/item/projectile/beam/laser/tg/spam //ultra weak but spammy, duh
	name = "blaster bolt"
	damage = 10
	damage_list = list("7" = 10, "8" = 10, "10" = 75, "15" = 5)
	recoil = BULLET_RECOIL_PLASMA

//Laser AK projectiles
/obj/item/projectile/beam/laser/tg/kalashheavy
	name = "heavy laser bolt"
	damage = 40
	damage_list = list("35" = 20, "40" = 60, "45" = 20)
	icon_state = "arcane_barrage"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	light_color = LIGHT_COLOR_PURPLE

/obj/item/projectile/beam/laser/tg/kalashlight
	name = "light laser bolt"
	damage = 20
	damage_list = list( "18" = 20, "20" = 60, "25" = 20)
	icon_state = "arcane_barrage"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/purple_laser
	light_color = LIGHT_COLOR_PURPLE

// BETA // Obsolete
/obj/item/projectile/beam/laser/pistol/lasertesting //Wattz pistol
	damage = 25
