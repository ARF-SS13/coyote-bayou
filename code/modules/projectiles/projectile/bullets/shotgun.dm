/* buckshot pellet
 * DAMAGE: 11
 * STAMIN: 1
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/pellet/shotgun_buckshot
	name = "buckshot pellet"
	damage = BULLET_DAMAGE_SHOTGUN_PELLET
	damage_list = list("5" = 10, "7" = 20, "8" = 20, "9" = 20, "10" = 20, "12" = 10)
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

//	supereffective_damage = 2
//	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")


//needler shotgun pellet.
/obj/item/projectile/bullet/pellet/needler_buckshot //very weak PVP damage, good bane damage.
	name = "needler pellet"
	icon_state = "needlesg"
	icon = 'icons/obj/projectiles.dmi'
	damage = BULLET_DAMAGE_NEEDLER_PELLET
	damage_list = list("3" = 10, "4" = 10, "5" = 0.5 )
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	ricochets_max = 2
	ricochet_chance = 30
	ricochet_auto_aim_angle = 50
	ricochet_auto_aim_range = 6
	ricochet_incidence_leeway = 80

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN
	supereffective_damage = 8
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

//ratshot pellet: 6 damage instead of 8, fewer pellets. would make many tiny damage pellets but performance
/obj/item/projectile/bullet/pellet/shotgun_ratshot
	name = "ratshot pellet"
	damage = BULLET_DAMAGE_RATSHOT_PELLET
	damage_list = list("4" = 10, "5" = 20, "6" = 20, "7" = 20, "8" = 20, "9" = 10)
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	supereffective_damage = 2
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/* rubber pellet
 * DAMAGE: 1
 * STAMIN: 11
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/pellet/shotgun_rubbershot
	name = "rubbershot pellet"
	damage = RUBBERY_DAMAGE_SHOTGUN_PELLET
	stamina = RUBBERY_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_SHOTGUN_PELLET

	wound_bonus = RUBBERY_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN
	sharpness = SHARP_NONE
	embedding = null

	//Each pellet does the same damage as handloaded buckshot to mobs, but rubbershot gets 2 more pellets.
	//This does mean theres no reason to print handloaded buckshot unless you're hunting men.
	//However, you can find handloaded buckshot in the trash, you can't find rubbershot.
	//This means that you'll always be paying to use rubbershot, whereas handloaded buckshot is often a freebie.
	supereffective_damage = 2
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/* handload pellet
 * DAMAGE: 8
 * STAMIN: 1
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/pellet/shotgun_improvised
	damage = BULLET_DAMAGE_SHOTGUN_PELLET
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

	supereffective_damage = 2
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/projectile/bullet/pellet/shotgun_improvised/Initialize()
	. = ..()
	range = rand(4, 8)

/obj/item/projectile/bullet/pellet/shotgun_improvised/on_range()
	if(prob(25))
		do_sparks(1, TRUE, get_turf(src))
	..()

/obj/item/projectile/bullet/pellet/shotgun_improvised/on_hit(atom/target, blocked = FALSE)
	if(prob(50))
		do_sparks(1, FALSE, get_turf(target))
	..()

/* simplemob pellet
 * DAMAGE: 8
 * STAMIN: 1
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/pellet/simplemob
	damage = BULLET_DAMAGE_SHOTGUN_PELLET * 0.5
	stamina = BULLET_STAMINA_SHOTGUN_PELLET
	spread = BULLET_SPREAD_SURPLUS * 3

	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/bullet/pellet/simplemob/Initialize()
	. = ..()
	range = abs(floor(gaussian(5, 2))) // yeah suck it cpu

/* 12g slug
 * DAMAGE: 50
 * STAMIN: 10
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 30
 */
/obj/item/projectile/bullet/shotgun_slug
	name = "12g shotgun slug"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG
	damage_list = list("40" = 15, "50" = 15, "60" = 50, "70" = 10, "80" = 10)
	stamina = BULLET_STAMINA_SHOTGUN_SLUG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO

/* 12g slug
 * DAMAGE: 50
 * STAMIN: 10
 * RECOIL: 2
 * WOUNDS: 80
 * WNAKED: 30
 */
/obj/item/projectile/bullet/shotgun_slug/executioner
	name = "executioner slug" // admin only, can dismember limbs
	wound_bonus = 80

/* 12g slug
 * DAMAGE: 50
 * STAMIN: 10
 * RECOIL: 2
 * WOUNDS: 80
 * WNAKED: 30
 */
/obj/item/projectile/bullet/shotgun_slug/pulverizer
	name = "pulverizer slug" // admin only, can crush bones
	wound_bonus = 80
	sharpness = SHARP_NONE


/* 12g beanbag
 * DAMAGE: 5
 * STAMIN: 100
 * RECOIL: 2
 * WOUNDS: 120
 * WNAKED: 90
 */
/obj/item/projectile/bullet/shotgun_beanbag
	name = "beanbag slug"
	damage = RUBBERY_DAMAGE_SHOTGUN_SLUG
	stamina = RUBBERY_STAMINA_SHOTGUN_SLUG
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_SHOTGUN_SLUG

	wound_bonus = RUBBERY_WOUND_SHOTGUN_SLUG
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_PRECISION

	supereffective_damage = BULLET_DAMAGE_PISTOL_9MM
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/* train
 * DAMAGE: 20
 * STAMIN: 4
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 30
 */
/obj/item/projectile/bullet/pellet/trainshot
	name = "trainshot slug"
	damage = BULLET_DAMAGE_SHOTGUN_TRAIN
	stamina = BULLET_STAMINA_SHOTGUN_TRAIN
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_TRAIN

	wound_bonus = BULLET_WOUND_SHOTGUN_TRAIN
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_TRAIN_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_TRAIN
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO
	sharpness = SHARP_NONE //crunch

/obj/item/projectile/bullet/pellet/trainshot/on_hit(atom/target)
	. = ..()
	if(ismovable(target) && prob(8))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 2, 3)

/* 12g slug fire
 * DAMAGE: 25
 * STAMIN: 50
 * RECOIL: 2
 * WOUNDS: 120
 * WNAKED: 0
 */
/obj/item/projectile/bullet/incendiary/shotgun
	name = "incendiary slug"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_SHOTGUN_SLUG * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO
	sharpness = SHARP_NONE

/* 12g pellet fire
 * DAMAGE: 5
 * STAMIN: 5
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/bullet/incendiary/shotgun/dragonsbreath
	name = "dragonsbreath pellet"
	damage = BULLET_DAMAGE_SHOTGUN_PELLET * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_SHOTGUN_PELLET * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/* 12g pellet fire
 * DAMAGE: 5
 * STAMIN: 5
 * RECOIL: 2
 * WOUNDS: 0
 * WNAKED: 0
 */
/obj/item/projectile/incendiary/flamethrower
	name = "FIREEEEEEEEEE!!!!!"
	icon = 'icons/effects/fire.dmi'
	icon_state = "3"
	light_range = LIGHT_RANGE_FIRE
	light_color = LIGHT_COLOR_FIRE

	damage_type = BURN
	damage = BULLET_DAMAGE_SHOTGUN_PELLET * BULLET_DAMAGE_FIRE
	stamina = BULLET_STAMINA_SHOTGUN_PELLET * BULLET_STAMINA_FIRE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET

	wound_bonus = BULLET_WOUND_SHOTGUN_PELLET * BULLET_WOUND_FIRE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_PELLET_NAKED_MULT * BULLET_NAKED_WOUND_FIRE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_PELLET
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	sharpness = SHARP_NONE
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/obj/item/projectile/incendiary/flamethrower/on_hit(atom/target)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.adjust_fire_stacks(3)
		M.IgniteMob()

/* 12g slug stun
 * DAMAGE: 5
 * STAMIN: 100
 * RECOIL: 2
 * WOUNDS: 120
 * WNAKED: 90
 */
/obj/item/projectile/bullet/shotgun_stunslug
	name = "stunslug"
	damage = RUBBERY_DAMAGE_SHOTGUN_SLUG
	stamina = RUBBERY_STAMINA_SHOTGUN_SLUG
	spread = BULLET_SPREAD_SURPLUS
	recoil = RUBBERY_RECOIL_SHOTGUN_SLUG

	wound_bonus = RUBBERY_WOUND_SHOTGUN_SLUG
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_PRECISION

	stutter = 5
	jitter = 20
	range = 7
	icon_state = "spark"
	color = "#FFFF00"
	var/tase_duration = 50

/obj/item/projectile/bullet/shotgun_stunslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - burst into sparks!
		do_sparks(1, TRUE, src)
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		SEND_SIGNAL(C, COMSIG_ADD_MOOD_EVENT, "tased", /datum/mood_event/tased)
		SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
		C.IgniteMob()
		if(C.dna && C.dna.check_mutation(HULK))
			C.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		else if(tase_duration && (C.status_flags & CANKNOCKDOWN) && !HAS_TRAIT(C, TRAIT_STUNIMMUNE) && !HAS_TRAIT(C, TRAIT_TASED_RESISTANCE))
			C.electrocute_act(15, src, 1, SHOCK_NOSTUN)
			C.apply_status_effect(STATUS_EFFECT_TASED_WEAK, tase_duration)

/* 12g slug meteor
 * DAMAGE: 40
 * STAMIN: 15
 * RECOIL: 2
 * WOUNDS: 40
 * WNAKED: 30
 */
/obj/item/projectile/bullet/shotgun_meteorslug
	name = "meteorslug"
	icon = 'icons/obj/meteor.dmi'
	icon_state = "dust"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG
	stamina = BULLET_STAMINA_SHOTGUN_SLUG
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO
	sharpness = SHARP_NONE

	knockdown = 80
	hitsound = 'sound/effects/meteorimpact.ogg'

/obj/item/projectile/bullet/shotgun_meteorslug/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(ismovable(target))
		var/atom/movable/M = target
		var/atom/throw_target = get_edge_target_turf(M, get_dir(src, get_step_away(M, src)))
		M.safe_throw_at(throw_target, 3, 2)

/obj/item/projectile/bullet/shotgun_meteorslug/Initialize()
	. = ..()
	SpinAnimation()

/* 12g slug explode
 * DAMAGE: 25
 * STAMIN: 5
 * RECOIL: 2
 * WOUNDS: 80
 * WNAKED: 60
 */
/obj/item/projectile/bullet/shotgun_frag12
	name ="frag12 slug"
	damage = BULLET_DAMAGE_SHOTGUN_SLUG * BULLET_DAMAGE_EXPLOSIVE
	stamina = BULLET_STAMINA_SHOTGUN_SLUG * BULLET_STAMINA_EXPLOSIVE
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_SLUG

	wound_bonus = BULLET_WOUND_SHOTGUN_SLUG * BULLET_WOUND_EXPLOSIVE
	bare_wound_bonus = BULLET_WOUND_SHOTGUN_SLUG_NAKED_MULT * BULLET_NAKED_WOUND_EXPLOSIVE
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT

	pixels_per_second = BULLET_SPEED_SHOTGUN_SLUG
	damage_falloff = BULLET_FALLOFF_DEFAULT_PISTOL_LIGHT

	zone_accuracy_type = ZONE_WEIGHT_SEMI_AUTO

	knockdown = 50

/obj/item/projectile/bullet/shotgun_frag12/on_hit(atom/target, blocked = FALSE)
	..()
	explosion(target, -1, 0, 1)
	return BULLET_ACT_HIT

// Mech Scattershots

/obj/item/projectile/bullet/scattershot
	damage = 28
	icon_state = "mech_autocannon"
	light_range = 1.5
	light_power = 0.3
	light_color = "#FF7F01"

/obj/item/projectile/bullet/seed
	damage = 6
	stamina = 1

/obj/item/projectile/bullet/pellet/shotgun_incapacitate
	name = "incapacitating pellet"
	damage = 1
	stamina = 6

/obj/item/projectile/bullet/pellet/magnum_buckshot
	name = "magnum buckshot pellet"
	damage = 15
	wound_bonus = 10
	bare_wound_bonus = 10

// BETA STUFF // Obsolete
/obj/item/projectile/bullet/pellet/shotgun_buckshot/test
	name = "buckshot pellet"
	damage = 0
