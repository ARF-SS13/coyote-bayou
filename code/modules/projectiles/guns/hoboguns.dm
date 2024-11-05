// IN THIS DOCUMENT: Improvised/home made, rebuilt whacky guns
// See gun.dm for keywords and the system used for gun balance


/obj/item/gun/ballistic/automatic/hobo
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	use_casing_sounds = TRUE
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 5, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

/obj/item/gun/ballistic/revolver/hobo
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	use_casing_sounds = TRUE
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 5, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

/obj/item/gun/ballistic/rifle/hobo
	icon = 'icons/fallout/objects/guns/energy.dmi'
	use_casing_sounds = TRUE
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 5, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

/* * * * *
 * Hobo! *
 * * * * */

/* * * * * * * * * * *
 * Guns, but impractical
 * Generally lower capacity
 * Much higher damage
 * Obnoxious mechanics
 * Generally poor accuracy
 * Lot of recoil
 * Long recoil cooldown
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Zipgun
 * Loud angry pistol
 * 9mm
 * High damage
 * Slow shooting
 * One handed
 * Akimbo
 * Common
 * * * * * * * * * * */


/* * * * * * * * * * *
 * Pipe Gun
 * Loud angry rifle
 * .223 / 5.56mm
 * High damage
 * Slow shooting
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/hobo/piperifle
	name = "pipe rifle"
	desc = "A wasteland staple, an unrifled pipe welded to a break-action... thing and bolted to a nicely-carved plank of wood. \
		Despite its crudeness, and pipebombedness, the humble pipe rifle has served many a waster well against the horrors of the wilds, \
		often the one thing that stands between life and death. Fingers not withstanding. <br><br> \
		A brave, enterprising waster can change what this gun fires! Simply " + span_notice("unscrew") + " the bolts, " + span_notice("insert") + " \
		some metal parts into the breech block, " + span_notice("weld") + " it until its good and soft, and then " + span_notice("insert") + " a new \
		casing in there. Be sure to unload it first!"
	icon_state = "piperifle"
	inhand_icon_state = "pepperbox"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvisedpipe
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_recoil = RIFLE_RECOIL(3, 3)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	prefered_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(20, 15, 25, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(1),
		GUN_MISFIRE_UNLOADS_GUN(10, 50)
	)

	//fire_sound = 'sound/weapons/Gunshot.ogg'
	can_scope = TRUE

/// Multicaliber shouldergun
/obj/item/gun/ballistic/revolver/hobo/piperifle/romckit
	name = "\improper romckit launcher"
	desc = "An advanced recoilless rifle made from the fancy memory steel used in the twist-action \
		series of guns, able to load and fire just about anything without problem. \
		However, the energy-absorbing metal ends up slowing whatever travels through it, making \
		anything fired through it hit like a wet noodle."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "rocketlauncher"
	inhand_icon_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised_any
	fire_sound = 'sound/weapons/magrifle.ogg'

	damage_multiplier = GUN_LESS_DAMAGE_T5
	projectile_speed_multiplier = 0.1
	misfire_possibilities = list()

/obj/item/gun/ballistic/revolver/hobo/piperifle/romckit/update_icon_state()
	icon_state = "[initial(icon_state)]-[chambered ? "1" : "0"]"

/obj/item/storage/box/hobo_tox
	name = "romckit launcher kit"
	desc = "Contains a romckit launcher! (romckit, launcher, and explosives not included)"

/obj/item/storage/box/hobo_tox/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/hobo/piperifle/romckit(src)
	new /obj/item/ammo_box/magazine/amr(src)
	new /obj/item/ammo_box/magazine/amr(src)

/* * * * * * * * * * *
 * Pepperbox Gun
 * Pistol, but four of them
 * 10mm
 * High damage
 * Slow shooting
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/hobo/pepperbox
	name = "pepperbox gun (10mm)"
	desc = "Four unrifled pipes bolted to a splintering wooden plank (might have been a bat?), with an awkward spring-loaded \
		mechanism on the end you assume should be pointed <i>at</i> you. It's essentially four slam(?)-fire pipe-\"rifles\" in one, \
		each connected to a separate trigger that'll fire a 10mm pistol round. If you grip it <i>just right</i>, you might just \
		get it to fire all four shots at once! Or explode!"
	icon_state = "pepperbox"
	inhand_icon_state = "pepperbox"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised10mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(2.4, 2.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
		/datum/firemode/burst/four/fastest/hobo
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(10, 10, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(1),
		GUN_MISFIRE_UNLOADS_GUN(5, 50)
	)

/obj/item/gun/ballistic/revolver/hobo/pepperbox/deal
	name = "Deal with the Devil"
	desc = "This terrifying abomination of a weapon is made of four heavy pipes strapped together, with a single trigger mechanism. Be very careful when firing it, or better yet, don't."
	icon_state = "pepperbox"
	inhand_icon_state = "pepperbox"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised10mm
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	init_recoil = HANDGUN_RECOIL(2.4, 2.4)
	init_firemodes = list(
		/datum/firemode/burst/four/fastest/hobo
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 50, 100, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(2, 50)
	)

	//fire_sound = 'sound/weapons/Gunshot.ogg'

/* * * * * * * * * * *
 * SHOTGUN BAT
 * SHOTGUN BAT
 * 12g
 * High damage
 * Slow shooting
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/hobo/single_shotgun
	name = "shotgun bat"
	desc = "A heavy home-run worthy baseball bat bolted onto the side of a sturdy slam-fire shotgun barrel thing. \
		While the bat itself would make for a poor, painful stock, the trigger plate on the other side of the bat \
		would suggest that, yes, it'll likely shoot someone if you hit them with it. Hopefully that someone isn't you. \
		Also doubles as a pipebomb when you least expect it. Especially if you stick a .50 MG round in there. Which you totally can do."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgunbat"
	inhand_icon_state = "shotgunbat"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised

	added_spread = 5 // its a melee weapon lol
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = RIFLE_RECOIL(3.1, 3.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	//fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	prefered_power = CASING_POWER_SHOTGUN * CASING_POWER_MOD_SURPLUS // can fire handloadeds fine, everything else has *a price~*
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(20, 15, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(30),
		GUN_MISFIRE_UNLOADS_GUN(5, 50)
	)


/obj/item/gun/ballistic/revolver/single_shotgun/update_icon_state()
	icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/* * * * * * * * * * *
 * Knifegun
 * A knife, with a gun
 * .44 magnum
 * High damage
 * Is a knife
 * One handed
 * Common
 * * * * * * * * * * */


	//fire_sound = 'sound/weapons/Gunshot.ogg'

/* * * * * * * * * * *
 * Knucklegun
 * Ballistic fist, for wasters
 * .45ACP
 * High damage
 * Hits people
 * One handed
 * Common
 * * * * * * * * * * */




/* * * * * * * * * * *
 * Autopipe Rifle
 * Waster BFG
 * .357 magnum-ish
 * Burst fire?
 * Akimbo
 * Awful accuracy
 * Common
 * * * * * * * * * * */


/obj/item/gun/ballistic/automatic/autopipe/special
		name = "Redwater Special"
		desc = "Either a product of passion or product of insanity, it seems that someone modified this pipe rifle to conserve more muzzle pressure, at the cost of not being able to take it off of full auto."
		color = "#FF0000"
		damage_multiplier = GUN_EXTRA_DAMAGE_T3
		init_firemodes = list(
			/datum/firemode/automatic/rpm300
		)

/////////////////////
//PREMIUM HOBO GUNS//
/////////////////////


//Laser musket
/obj/item/gun/ballistic/rifle/hobo/lasmusket
	name = "Laser Musket"
	desc = "In the wasteland, one must make do. And making do is what the creator of this weapon does. \
		Made from metal scraps, electronic parts. an old rifle stock and a bottle full of dreams, \
		the Laser Musket is sure to stop anything in their tracks and make those raiders think twice."
	icon_state = "lasmusket"
	inhand_icon_state = "lasmusket"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lasmusket
	fire_delay = 15
	dryfire_sound = 'sound/f13weapons/noammoenergy.ogg'
	dryfire_text = "*power failure*"
	var/bolt_open = FALSE
	can_bayonet = TRUE
	knife_x_offset = 22
	knife_y_offset = 20
	bayonet_state = "bayonet"
	scope_state = "scope_long"
	scope_x_offset = 11
	scope_y_offset = 14
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	cock_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(3, 5, 10, FIRELOSS | TOXLOSS | RADIATIONLOSS | EMPLOSS)
	)


//Plasma musket.
/obj/item/gun/ballistic/rifle/hobo/plasmacaster
	name = "Plasma Musket"
	desc = "The cooling looks dubious and is that a empty can of beans used as a safety valve? Pray the plasma goes towards the enemy and not your face when you pull the trigger."
	icon_state = "plasmamusket"
	inhand_icon_state = "plasmamusket"
	mag_type = /obj/item/ammo_box/magazine/internal/plasmacaster
	fire_delay = 20
	var/bolt_open = FALSE
	dryfire_sound = 'sound/f13weapons/noammoenergy.ogg'
	dryfire_text = "*power failure*"
	scope_state = "scope_medium"
	scope_x_offset = 9
	scope_y_offset = 20
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	cock_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 30, 35, FIRELOSS | TOXLOSS | RADIATIONLOSS | EMPLOSS)
	)
	can_scope = TRUE
/* * * * * * * * * * *
 * Destroyer Carbine
 * Hobo semi-auto
 * 9mm
 * Awful accuracy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/hobo/destroyer
	name = "destroyer carbine"
	desc = "There are many ways to describe this, very few of them nice. This is a .45ACP silenced bolt action rifle - that via the expertise of a gun runner mainlining 50 liters of psycho, mentats, and turbo - has been converted into a semi auto."
	icon_state = "destroyer-carbine"
	inhand_icon_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/greasegun
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	can_scope = FALSE
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14
	init_recoil = CARBINE_RECOIL(2.3, 2.3)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(10, 10, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(1),
		GUN_MISFIRE_UNLOADS_GUN(3, 50)
	)

//Obrez, sawn off bolt action rifle						Keywords: .308, 5 round internal
/obj/item/gun/ballistic/rifle/hunting/obrez
	name = "Obrez"
	desc = "A cut down bolt action rifle. Uses .308."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "308-sawn"
	inhand_icon_state = "308-sawn"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = HANDGUN_RECOIL(4, 4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	can_scope = FALSE


//Winchester rebore. 									Keywords: .308, 2 round internal, saw-off
/obj/item/gun/ballistic/revolver/winchesterrebored
	name = "rebored Winchester"
	desc = "An old, weathered, battered hunk of junk of a double-barrelled coach gun restored into a somewhat decent hunting rifle. \
		Despite the bore being smoother than a gecko's butt, the accuracy on this thing isn't half bad, and its .308 chambering \
		can pack a real punch. While its shotgunning days are over, it sure ain't done putting holes in things. <br><br>\
		A brave, enterprising waster can change what this gun fires! Simply " + span_notice("unscrew") + " the bolts, " + span_notice("insert") + " \
		some metal parts into the breech block, " + span_notice("weld") + " it until its good and soft, and then " + span_notice("insert") + " a new \
		casing in there. Be sure to unload it first!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "winchesterbore"
	inhand_icon_state = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised308
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(3, 3)
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed
	)
	prefered_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_SURPLUS
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 15, 25, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(5, 50)
)

	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	//fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

/obj/item/gun/ballistic/revolver/winchesterrebored/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/revolver/winchesterrebored/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/revolver/sling
	name = "sling"
	desc = "A simple piece of leather, shaped to hold one rock, and hurl it at a target at high speed. Use *rocks to find more rocks!"
	icon = 'modular_coyote/icons/objects/bows.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	icon_state = "sling"
	inhand_icon_state = "utility"
	pin = null
	no_pin_required = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/sling
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	fire_sound = 'sound/weapons/punchmiss.ogg'

/obj/item/gun/ballistic/revolver/sling/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/revolver/sling/staff
	name = "sling staff"
	desc = "A sling hooked onto a wooden pole, for more leverage. Use *rocks to find more rocks!"
	icon_state = "slingstaff"
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T5 // 45 damage. hits harder, but bulkier, and needs two hands, so harder loading
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/revolver/brick
	name = "brick launcher"
	desc = "An old rocket launcher that has somehow been repurposed to fire bricks at high velocity. You can probably find more bricks with *brick!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "launcher"
	inhand_icon_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/brick
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	casing_ejector = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

	fire_sound = 'sound/weapons/punchmiss.ogg'

/obj/item/gun/ballistic/revolver/brick/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"
