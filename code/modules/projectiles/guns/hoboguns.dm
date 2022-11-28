// IN THIS DOCUMENT: Improvised/home made, rebuilt whacky guns
// See gun.dm for keywords and the system used for gun balance


/obj/item/gun/ballistic/automatic/hobo
	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 5, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

/obj/item/gun/ballistic/revolver/hobo
	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 5, 15, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

/obj/item/gun/ballistic/rifle/hobo
	slowdown = GUN_SLOWDOWN_PISTOL_MEDIUM
	icon = 'icons/fallout/objects/guns/energy.dmi'
	gun_tags = list(GUN_SCOPE)
	can_scope = TRUE
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

/obj/item/gun/ballistic/automatic/hobo/zipgun
	name = "Zip gun (9mm)"
	icon_state = "zipgun"
	desc = "A clever little makeshift pistol, one of the few easily-constructed firearms that accept more rounds than it has barrels. \
		Light, compact, and packing a surprising punch, the zip gun serves as a waster's insurance policy when doing business, \
		small enough to whip out of a coat when someone doesn't feel like paying for your raccoon pelts. \
		A brave, enterprising waster can stuff just about anything into the improvised clipazine, though anything more powerful \
		than a handloaded 9mm round will run the risk of voiding the warranty on your fingers."
	item_state = "gun"
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/zipgun

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HANDGUN_RECOIL(2.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 5, 15, BRUTELOSS),
		GUN_MISFIRE_THROWS_GUN(2),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)
	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/hobo/zipgun/update_icon_state()
	icon_state = "zipgun[magazine ? "-[CEILING(get_ammo(0)/1, 1)*1]" : ""][chambered ? "" : "-e"][silenced ? "-suppressed" : ""]"

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
	item_state = "pepperbox"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvisedpipe

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(3)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	prefered_power = CASING_POWER_LIGHT_RIFLE * CASING_POWER_MOD_HANDLOAD
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 15, 25, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(5, 50)
	)

	fire_sound = 'sound/weapons/Gunshot.ogg'

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
	item_state = "pepperbox"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised10mm

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HANDGUN_RECOIL(2.4)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow,
		/datum/firemode/burst/four/fastest/hobo
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_HANDLOAD
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 15, 25, BRUTELOSS | FIRELOSS | OXYLOSS),
		GUN_MISFIRE_THROWS_GUN(0.5),
		GUN_MISFIRE_UNLOADS_GUN(2, 50)
	)

	fire_sound = 'sound/weapons/Gunshot.ogg'

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
	item_state = "shotgunbat"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised

	added_spread = 5 // its a melee weapon lol
	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(3.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
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

/obj/item/gun/ballistic/revolver/hobo/knifegun
	name = "knife gun (.44)"
	desc = "It's a gun! It's a knife! It's... a knife taped to a slamfire bullet shooter thingy. \
		The lack of a barrel rules out any advanced marksmanry with this thing, but judging by the \
		thrust-activated trigger extension plunger... thing running down the fuller, a good solid \
		stab should point-blank the everliving daylights out of someone. Or blast one of your fingers into them. \
		Either way, someone's in for a bad time."
	icon_state = "knifegun"
	item_state = "knifegun"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised44

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HANDGUN_RECOIL(2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS // very likely to explode, cept with 9mm and 38
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(5, 5, 10, BRUTELOSS | FIRELOSS),
		GUN_MISFIRE_THROWS_GUN(10),
		GUN_MISFIRE_UNLOADS_GUN(0.5, 50)
	)

	fire_sound = 'sound/weapons/Gunshot.ogg'

/* * * * * * * * * * *
 * Knucklegun
 * Ballistic fist, for wasters
 * .45ACP
 * High damage
 * Hits people
 * One handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/hobo/knucklegun
	name = "knucklegun (.45)"
	desc = "When your knuckles don't cut it, put some brass on them. When that doesnt work? Weld on four slamfire barrels \"chambered\" \
		in .45 ACP, connect all those to a pressure plate on the strikeface, and try not to think about all the explosives you have \
		less than an inch from your fingers. Fires all four round at once, and if your hand still exists, delivers a solid punch too."
	icon_state = "knucklegun"
	item_state = "knucklegun"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_GLOVES
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised45

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HANDGUN_RECOIL(1.6)
	init_firemodes = list(
		/datum/firemode/burst/four/fastest/hobo
	)
	prefered_power = CASING_POWER_LIGHT_PISTOL * CASING_POWER_MOD_SURPLUS // very likely to explode, cept with 9mm and 38
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 10, 25, BRUTELOSS | FIRELOSS),
		GUN_MISFIRE_THROWS_GUN(5),
		GUN_MISFIRE_UNLOADS_GUN(5, 50)
	)

	fire_sound = 'sound/weapons/Gunshot.ogg'


/* * * * * * * * * * *
 * Autopipe Rifle
 * Waster BFG
 * .357 magnum-ish
 * Burst fire?
 * Akimbo
 * Awful accuracy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/autopipe
	name = "Auto-pipe rifle"
	desc = "The pride of wasteland engineering, a fully automatic, belt fed pipe machine gun. Despite looking like the scrap heap it was \
		made from, and its eagerness to fire before fully chambering, many wasters swear by its overwhelming firepower, capable of delivering \
		24 or so .357 magnum bullets into some unlucky beast before needing to reload. Not only does its loose receiver accept 9mm, .38 special, \
		and .357 magnum with ease, but it also can survive dozens of premature detonations without a scratch!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "autopipe"
	item_state = "autopipe"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/autopipe

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOW
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	automatic = 1
	init_recoil = RIFLE_RECOIL(2.7)
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/burst/three/slow,
		/datum/firemode/semi_auto
	)

	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/autopipe/update_icon_state()
	icon_state = "autopipe[magazine ? "-[CEILING(get_ammo(0)/1, 6)*1]" : ""][chambered ? "" : "-e"][silenced ? "-suppressed" : ""]"



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
	item_state = "lasmusket"
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
	pump_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(2, 5, 10, FIRELOSS | TOXLOSS | RADIATIONLOSS | EMPLOSS)
	)


//Plasma musket.
/obj/item/gun/ballistic/rifle/hobo/plasmacaster
	name = "Plasma Musket"
	desc = "The cooling looks dubious and is that a empty can of beans used as a safety valve? Pray the plasma goes towards the enemy and not your face when you pull the trigger."
	icon_state = "plasmamusket"
	item_state = "plasmamusket"
	mag_type = /obj/item/ammo_box/magazine/internal/plasmacaster
	fire_delay = 20
	var/bolt_open = FALSE
	dryfire_sound = 'sound/f13weapons/noammoenergy.ogg'
	dryfire_text = "*power failure*"
	scope_state = "scope_medium"
	scope_x_offset = 9
	scope_y_offset = 20
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	pump_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	misfire_possibilities = list(
		GUN_MISFIRE_HURTS_USER(1, 30, 35, FIRELOSS | TOXLOSS | RADIATIONLOSS | EMPLOSS)
	)

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
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/greasegun

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	automatic_burst_overlay = TRUE
	can_scope = FALSE
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14
	semi_auto = FALSE
	init_recoil = CARBINE_RECOIL(2.3)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)


//Obrez, sawn off bolt action rifle						Keywords: .308, 5 round internal
/obj/item/gun/ballistic/rifle/hunting/obrez
	name = "Obrez"
	desc = "A cut down bolt action rifle. Uses .308."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "308-sawn"
	item_state = "308-sawn"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = HANDGUN_RECOIL(4)
	init_firemodes = list(
		/datum/firemode/semi_auto
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
	item_state = "shotgundouble"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised762
	w_class = WEIGHT_CLASS_BULKY

	slowdown = GUN_SLOWDOWN_SHOTGUN_FIXED
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(2.3)
	init_firemodes = list(
		/datum/firemode/semi_auto,
		/datum/firemode/burst/two/shotgun_fixed
	)
	prefered_power = CASING_POWER_MEDIUM_RIFLE * CASING_POWER_MOD_SURPLUS

	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

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
