// ANYTHING IN THIS FILE WILL OVERWRITE ANYTHING IN THE LAST FILES

// This file is broken up into tiers.
// tiers go from zero to three.


// TIER 0, STARTER
// These guns should have minimal DPS, be a relic, or are generally good for newbies.

/obj/item/gun/flintlock/musket
	name = "post-fall fire belcher"
	desc = "A decently made, probably even safe, muzzle loading rifle made after the fall of the old world."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "musket1"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_AWFUL
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	force = 25
	force_unwielded = 25
	force_wielded = 30
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball
	load_time = FLINTLOCK_MUSKET_RELOAD_TIME
	prefire_time = FLINTLOCK_MUSKET_PREFIRE_TIME
	prefire_randomness = FLINTLOCK_MUSKET_PREFIRE_STD
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/gun/flintlock/musketoon
	name = "post-fall thunder rod"
	desc = "A handy post-fall muzzle loading carbine."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "musketoon"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_AWFUL
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	force = 23
	force_unwielded = 23
	force_wielded = 28
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball
	load_time = FLINTLOCK_MINIMUSKET_RELOAD_TIME
	prefire_time = FLINTLOCK_MINIMUSKET_PREFIRE_TIME
	prefire_randomness = FLINTLOCK_MINIMUSKET_PREFIRE_STD

/obj/item/gun/flintlock/musket/jezail
	name = "post-fall heirloom long belcher"
	desc = "A well taken care of muzzle loading firearm. This one shows family insignia and looks to have been handed down for generations."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "jezail"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	load_time = FLINTLOCK_MUSKET_RELOAD_TIME
	force = 20
	force_unwielded = 20 //it's kind of long and awkward ~TK
	force_wielded = 28
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	dryfire_text = "*not loaded*"
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball
	weapon_special_component = /datum/component/weapon_special/single_turf

/obj/item/gun/flintlock
	name = "post-fall short belcher"
	desc = "An almost safe post-fall muzzle loading pistol. Probably- uh.  Just don't drop it while loaded."
	icon_state = "flintlock"
	item_state = "flintlock"
	weapon_class = WEAPON_CLASS_SMALL // yarr harr fiddle dee dee, something something gundolier
	weapon_weight = GUN_ONE_HAND_AKIMBO //need both hands to fire
	added_spread = GUN_SPREAD_AWFUL
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	force = 20
	force_unwielded = 20
	force_wielded = 25
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball

/obj/item/gun/ballistic/automatic/pistol/pistol22
	name = "can tacker"
	desc = "A 16 shot pre-fall handgun chambered in .22 long rifle. Great for killing rusty cans."
	icon_state = "silenced22"
	mag_type = /obj/item/ammo_box/magazine/m22
	disallowed_mags = list(/obj/item/ammo_box/magazine/m22/extended)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // plug em in the skull!
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = FALSE
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/22pistol.ogg'

/obj/item/gun/ballistic/revolver/detective
	name = "sidewinder"
	desc = "A very handy six shooter. If your only worries in life are killing a family of squirrels."
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev22
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

/obj/item/gun/ballistic/rifle/repeater/trainer
	name = "snapback"
	desc = "A lever action rifle chambered in .22LR. Used to teach people the basics of firearm operation."
	icon_state = "lever22" // Placeholder
	item_state = "lever22"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/long22
	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	cock_delay = GUN_COCK_RIFLE_BASE
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = CARBINE_RECOIL(1, 0.8)
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 29
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/obj/item/gun/ballistic/automatic/sportcarbine
	name = "spitball"
	desc = "One of the many .22 LR carbines that were all the rage before the cataclysm. While lacking in firepower, it more than makes up for it with its cheapness to fire."
	icon_state = "surplus"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m22
	init_mag_type = /obj/item/ammo_box/magazine/m22/extended
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0 // its a weakass cartridge
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_bayonet = TRUE
	bayonet_state = "bayonetstraight"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "leveraction_scope"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/weapons/Gunshot2.ogg'

// TIER 1, STARTER
// These guns should have okay DPS, be an older weapon, and are very good canidates for roundstart weapons. This sets the pace.

/obj/item/gun/ballistic/automatic/pistol/ninemil
	name = "nine"
	desc = "A mass produced pre-cataclysm 9mm pistol."
	icon_state = "ninemil"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 19
	fire_sound = 'sound/f13weapons/ninemil.ogg'

/obj/item/gun/ballistic/automatic/pistol/ninemil/skorpion
	name = "subby"
	desc = "A machine pistol. In 9mm."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "skorpion"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

/obj/item/gun/ballistic/automatic/pistol/ninemil/ruby
	name = "ruby"
	desc = "A post-cataclysm petite pocket pistol copied after the pre-cataclysm design of the same name."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "ruby"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/m9mm/doublestack)
	weapon_class = WEAPON_CLASS_TINY

/obj/item/gun/ballistic/automatic/pistol/ninemil/makarov
	name = "eastern pistol"
	desc = "An easy to conceal pistol chambered in 9mm."
	icon_state = "makarov"
	item_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	init_mag_type = /obj/item/ammo_box/magazine/m9mm
	mag_type = /obj/item/ammo_box/magazine/m9mm
	weapon_class = WEAPON_CLASS_TINY

/obj/item/gun/ballistic/automatic/pistol/ninemil/c93/luger
	name = "trophy pistol"
	desc = "A foreign 9mm pistol, which takes single stack magazines."
	icon_state = "p08"
	item_state = "p38"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/ninemil/glock
	name = "P.D."
	desc = "Chambered in 9mm, this is a versatile compact pistol. It fits comfortably in the hand or a chest rig, and its solid design lets it survive mud, sand, and sometimes even peanut butter."
	icon_state = "glock"
	item_state = "glock"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/type17
	name = "broomie"
	desc = "The ones around are old and worn, but somewhat popular due to the long barrel and rechambered in 9mm after the original ammo ran dry centuries ago."
	icon_state = "chinapistol"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(0.6, 0.6)

	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = TRUE

/obj/item/gun/ballistic/revolver/revolver45
	name = ".45 ACP two step"
	desc = "Post-fall revolver firing .45 ACP from a seven round cylinder."
	item_state = "45revolver"
	icon_state = "45revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/revolver/colt357
	name = "357 two step"
	desc = "A no-nonsense revolver, more than likely made in some crude workshop in one of the more prosperous frontier towns."
	icon_state = "357colt"
	item_state = "357colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/357magnum.ogg'

/obj/item/gun/ballistic/revolver/revolver44
	name = ".44 two step"
	desc = "A fairly large post-fall revolver chambered in .44, chunky."
	item_state = "44colt"
	icon_state = "44colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = HANDGUN_RECOIL(1, 0.8)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	fire_sound = 'sound/f13weapons/44revolver.ogg'

/obj/item/gun/ballistic/revolver/buntline
	name = "long two step"
	desc = "A revolver carbine. The revolver itself is the same as any other single action, albeit it has an elongated barrel and attachable stock. For when you wanna hit the cowpokes from afar."
	icon_state = "coltcarbine"
	item_state = "coltcarbine"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45/gunslinger
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = SMG_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_scope = TRUE
	can_suppress = FALSE
	can_bayonet = FALSE

/obj/item/gun/ballistic/revolver/derringerLC
	name = "garnet"
	desc = "A classy, pearl handled pistol firing .45 in a very compact package."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "remington_95_ivory"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45/two
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/45revolver.ogg'

/obj/item/gun/ballistic/automatic/smg/cg45
	name = "open bolt sweeper"
	desc = "Post-cataclysm submachine gun crudely constructed out of various steel parts using advanced powered hand tools; likely one of the most complex guns that is feasible to make outside of a machine shop."
	icon_state = "cg45"
	item_state = "cg45"
	mag_type = /obj/item/ammo_box/magazine/cg45
	init_mag_type = /obj/item/ammo_box/magazine/cg45
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = SMG_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/obj/item/gun/ballistic/automatic/m1carbine
	name = "reservist carbine"
	desc = "A design thought to have been used hundreds of years ago by a now long gone power. It's ubiquitous nature made it prime for post-fall gunsmiths to restore."
	icon_state = "m1carbine"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m10mm
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T2
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_tags = list(GUN_FA_MODDABLE, GUN_SCOPE) //need to check what this do
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 5
	scope_y_offset = 14
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/obj/item/gun/ballistic/revolver/caravan_shotgun
	name = "alley-oop"
	desc = "An over-under hunting rifle, for large game."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "caravan"
	item_state = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/caravan
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed,
	)
	can_scope = TRUE
	sawn_desc = "Short and concealable, terribly uncomfortable to fire, but worse on the other end."
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'

/obj/item/gun/ballistic/revolver/shotpistol
	name = "blaster"
	desc = "Exactly one half of a hammer fired double barrel shotgun, stripped down and streamlined to fit snugly in someone's pocket."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotpistol"
	item_state = "357colt"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/single
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed
	)

	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

/obj/item/gun/ballistic/revolver/widowmaker
	name = "flyswatter"
	desc = "A simple hammer fired double barrel shotgun."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "widowmaker"
	item_state = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed,
	)
	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock
	name = "slapback"
	desc = "A speedy lever action shotgun with a five-shell capacity underneath plus one in chamber."
	icon_state = "lashotgunstocked"
	item_state = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST
	init_recoil = SHOTGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = FALSE

/obj/item/gun/ballistic/rifle/repeater/cowboy
	name = "cavalry rifle"
	desc = "A lever action rifle chambered in .357 Magnum. Smells vaguely of whiskey and cigarettes."
	icon_state = "cowboyrepeater"
	item_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = CARBINE_RECOIL(1, 0.8)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/obj/item/gun/ballistic/rifle/antique/gras
	name = "Mardi-Gras rifle"
	desc = "A post-catacylsm copy of an old black powder cartridge gun of French lineage. No one is sure where the name came from, but it stuck."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "gras"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/gras
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 25
	cock_sound = 'sound/f13weapons/grasbolt.ogg'
	fire_sound = 'sound/f13weapons/gras.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	reskinnable_component = null

/obj/item/gun/ballistic/rifle/mag/boys
	name = "salvaged bolt-action rifle"
	desc = "A heavy rifle boasting a strong kick and an even stronger punch. This one probably won't even come apart from the excess pressures! (worm gear clamps not included)"
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "boys"
	item_state = "boys"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	lefthand_file = 'icons/fallout/onmob/weapons/64x64_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/64x64_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/boys
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HMG_RECOIL(3, 3)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/antimaterialfire.ogg'
	cock_sound = 'sound/f13weapons/antimaterialreload.ogg'

/obj/item/gun/ballistic/rifle/salvaged_eastern_rifle
	name = "salvaged eastern dragon"
	desc = "A clever design adapted out of salvaged surplus eastern rifles and wasteland scarcity. The magazine is welded to the frame and a port was added after."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "salvak"
	item_state = "salvak"
	mag_type = /obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	init_mag_type = /obj/item/ammo_box/magazine/internal/salvaged_eastern_rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 0.5)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION

	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/salvaged.ogg'
	can_scope = TRUE
	casing_ejector = TRUE

/obj/item/gun/ballistic/automatic/pistol/m1911
	name = "flatline"
	desc = "A classic .45 handgun with a small magazine capacity."
	icon_state = "m1911"
	item_state = "pistolchrome"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'

// TIER 2, ESCALATION
// These guns should have respectable DPS, be a relatively newer weapon, and are very good canidates for loot weapons. You can break these down at a workbench for gunmods and parts to upgrade the tier of your starter.

/obj/item/gun/ballistic/automatic/pistol/ninemil/rare99
	name = "warden"
	desc = "A compact .45 pistol. A shorter version of the Service Pistol. It is tiny compared to its bigger brothers and packs a punch."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "Warden10"
	item_state = "glock"
	init_mag_type = /obj/item/ammo_box/magazine/m10mm/adv/simple
	mag_type = /obj/item/ammo_box/magazine/m10mm // load any 10mm pistol ammos
	disallowed_mags = list(
		/obj/item/ammo_box/magazine/m10mm/adv/ext,
		/obj/item/ammo_box/magazine/m10mm/adv/ext/empty,
		/obj/item/ammo_box/magazine/m10mm/rifle)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	suppressor_state = "n99_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'
	init_recoil = HANDGUN_RECOIL(1.5, 1.1)

/obj/item/gun/ballistic/automatic/pistol/beretta
	name = "big nine"
	desc = "One of the more common 9mm pistols, the Beretta is popular due to its reliability, 15 round magazine and good looks."
	icon_state = "beretta"
	init_mag_type = /obj/item/ammo_box/magazine/m9mm/doublestack
	mag_type = /obj/item/ammo_box/magazine/m9mm // load any 9mm pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/9mm.ogg'

	reskinnable_component = null

/obj/item/gun/ballistic/automatic/pistol/sig
	name = "straightline"
	desc = "A pistol that is compact and has an average rate of fire, but still in .45. Adopted by Park Rangers."
	icon_state = "newsig"
	item_state = "gun"
	init_mag_type = /obj/item/ammo_box/magazine/m45
	mag_type = /obj/item/ammo_box/magazine/m45
	disallowed_mags = list(/obj/item/ammo_box/magazine/m45/socom, /obj/item/ammo_box/magazine/m45/socom/empty)
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.1, 1.1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 30
	suppressor_y_offset = 20
	fire_sound = 'sound/f13weapons/45revolver.ogg'
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/pistol/deagle
	name = "shucker"
	desc = "A .44 magnum semi-automatic handgun."
	icon_state = "deagle"
	item_state = "deagle"
	init_mag_type = /obj/item/ammo_box/magazine/m44
	mag_type = /obj/item/ammo_box/magazine/m44 // load any .44 pistol ammos
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1.2, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	can_suppress = FALSE
	fire_sound = 'sound/f13weapons/44mag.ogg'

/obj/item/gun/ballistic/revolver/police
	name = ".357 one step"
	desc = "Pre-Cataclysm double action police revolver chambered in .357 magnum."
	icon_state = "police"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	fire_sound = 'sound/f13weapons/policepistol.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC // limbfucker2000

/obj/item/gun/ballistic/revolver/m29
	name = ".44 one step"
	desc = "Powerful handgun for those who want to travel the deadlands safely in style. Has a bit of a kick."
	item_state = "model29"
	icon_state = "m29"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_scope = TRUE
	scope_state = "revolver_scope"
	scope_x_offset = 6
	scope_y_offset = 24
	fire_sound = 'sound/f13weapons/44mag.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/ballistic/automatic/smg/mini_uzi/mp5
	name = "hose"
	desc = "A pre-fall design, ancient and fairly common as far as sub machineguns go."
	icon = 'modular_coyote/icons/objects/automatic.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	weapon_class = WEAPON_CLASS_NORMAL //high class, one of the few smol smgs
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire

/obj/item/gun/ballistic/automatic/smg/mini_uzi/mac10
	name = "lil' hose"
	desc = "A pre-fall compact machine pistol with a blistering fire rate. Not terribly accurate though."
	icon = 	'modular_coyote/icons/objects/automatic.dmi'
	icon_state = "mac10"
	weapon_class = WEAPON_CLASS_NORMAL
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = SMG_RECOIL(2, 2)
	suppressor_x_offset = 28
	suppressor_y_offset = 20
	init_firemodes = list(
		/datum/firemode/automatic/rpm300,
		/datum/firemode/semi_auto/faster
	)

/obj/item/gun/ballistic/automatic/smg/greasegun
	name = "heavy hose"
	desc = "A pre-fall design similar to the fairly common post-fall open bolt smgs. It has tight tolerances and fires a heavy cartridge."
	icon_state = "grease_gun"
	item_state = "smg9mm"
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	mag_type = /obj/item/ammo_box/magazine/greasegun
	init_mag_type = /obj/item/ammo_box/magazine/greasegun
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	can_suppress = TRUE
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 19

/obj/item/gun/ballistic/automatic/m1carbine/compact
	name = "reservist compact"
	desc = "Similar to the reservist carbine, this model has a folding stock for greater mobility."
	icon_state = "m1a1carbine"
	weapon_class = WEAPON_CLASS_CARBINE
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = CARBINE_RECOIL(1.5, 1.5)

/obj/item/gun/ballistic/automatic/varmint
	name = "coyote"
	desc = "A simple pre-fall semi-auto rifle in 5.56mm calibre. Easy to use and maintain."
	icon_state = "varmint"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	can_scope = TRUE

/obj/item/gun/ballistic/automatic/service
	name = "wolf"
	desc = "A pre-fall semi-automatic rifle that is believed to have served a great nation at one time.  Now they're fairly rare, high maintenance and not very popular. Good for those who can keep it fed."
	icon_state = "service_rifle"
	item_state = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'
	reskinnable_component = null

/obj/item/gun/ballistic/automatic/m1garand/sks // to-do, make this have an internal mag please
	name = "eastern dragon"
	desc = "Somehow, despite all that has gone wrong over the last few hundred years this eastern rifle is still working. It's almost immaculate."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "sks"
	item_state = "sks"
	mag_type = /obj/item/ammo_box/magazine/sks
	init_mag_type = /obj/item/ammo_box/magazine/sks
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)

	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 23
	scope_state = "scope_mosin"
	scope_x_offset = 4
	scope_y_offset = 12
	auto_eject_sound = 'sound/weapons/magout.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/aksmol
	name = "eastern drake"
	desc = "An assault rifle given to rear echelon troops in place of an SMG. Lacks a stock, but packs a punch. Oh."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "ak74utest"
	icon_state = "ak74utest"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTORIFLE_RECOIL(1.5, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = TRUE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/fnfal/ak47
	name = "eastern wyvern"
	desc = "A fairly uncommon eastern rifle. It's hard to tell if this one is in good shape or really bad. They just don't ever look quite right."
	icon_state = "trueak"
	item_state = "trueak"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.0, 2.0)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75,
		/datum/firemode/semi_auto/slow
	)
	can_scope = TRUE
	can_suppress = FALSE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/armalite
	name = "bear"
	desc = "A pre-fall semi-automatic .308 rifle. Accurate and packs a punch, but recoil picks up quick, and it's heavy. Makes it suitable for bashing skulls, at least..."
	icon_state = "armalite"
	item_state = "assault_carbine"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1.5, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/ballistic/shotgun/grenade
	name = "bloop"
	desc = "A pre-fall bulky but surprisingly lightweight grenade launcher with a stiff pump."
	icon = 'modular_coyote/icons/objects/ncrrangersguns.dmi'
	icon_state = "china_lake"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	init_mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0

	can_bayonet = FALSE
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/shotgun/hunting
	name = "razorback"
	desc = "A pre-fall traditional hunting shotgun with wood furniture and a four-shell capacity underneath."
	icon_state = "pump"
	item_state = "shotgunpump"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5
	name = "hawg"
	desc = "A pre-fall semi-automatic shotgun with a four round tube."
	icon_state = "auto5"
	item_state = "shotgunauto5"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	casing_ejector = TRUE // makes it eject casings -- and not need pumping!!!
	fire_sound = 'sound/f13weapons/auto5.ogg'

/obj/item/gun/ballistic/rifle/repeater/trail
	name = "heavy snapback"
	desc = "A lever action rifle chambered in .44 Magnum."
	icon_state = "trailcarbine"
	item_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	init_recoil = CARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/44mag.ogg'

/obj/item/gun/ballistic/rifle/hunting
	name = "hunting rifle"
	desc = "A sturdy military rifle, rechambered to .30-06 Springfield.  Which one?  Who fucking knows."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	sawn_desc = "A hunting rifle, crudely shortened with a saw. It's far from accurate, but the short barrel makes it quite portable."
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'
	reskinnable_component = null // was /datum/component/reskinnable/hunting_rifle, please go through this list

	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/revolver/police/webley
	name = "half step"
	desc = "A gas operated police revolver that fires just about as fast as you can click the trigger."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "webley"
	item_state = "police"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)
	fire_sound = 'sound/f13weapons/policepistol.ogg'
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC // limbfucker2000

/obj/item/gun/ballistic/automatic/smg/tommygun
	name = "drumroll"
	desc = "A powerful pre-fall submachinegun chambered in .45 ACP, this weapon fires at a blistering rate with a heavy pistol cartridge, and can accept very high capacity magazines, to boot."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "tommygun"
	item_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	init_mag_type = /obj/item/ammo_box/magazine/tommygunm45/stick
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)

	fire_sound = 'sound/weapons/gunshot_smg.ogg'

/obj/item/gun/ballistic/automatic/smg/mini_uzi
	name = "stacatto"
	desc = "A lightweight, automatic submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	item_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	disallowed_mags = list(/obj/item/ammo_box/magazine/uzim9mm/rockwell) //so I don't have to assign a ton of new sprite names
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_LESS_DAMAGE_T1
	can_suppress = TRUE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/fast
	)
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16

/obj/item/gun/ballistic/automatic/smg/mp5sd
	name = "nailtacker"
	desc = "An integrally suppressed submachinegun chambered in 9mm."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "mp5"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	init_mag_type = /obj/item/ammo_box/magazine/uzim9mm
	weapon_class = WEAPON_CLASS_NORMAL
	weapon_weight = GUN_ONE_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // Accurate semiauto fire
	init_firemodes = list(
		/datum/firemode/automatic/rpm200,
		/datum/firemode/semi_auto/faster
	)
	silenced = TRUE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'
	fire_sound_silenced = 'sound/weapons/Gunshot_silenced.ogg'

/obj/item/gun/ballistic/automatic/m1garand
	name = "eagle"
	desc = "A very hefty pre-fall rifle with an en-bloc magazine known for making an appealing noise when it is ejected."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "m1garand"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/garand3006
	init_mag_type = /obj/item/ammo_box/magazine/garand3006
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	gun_tags = list(GUN_SCOPE)
	en_bloc = 1
	auto_eject = 1
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 5
	scope_y_offset = 14
	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/ak556
	name = "eastern lynx"
	desc = "A pre-fall eastern rifle of a design believed to be more modern. A bit of a unicorn of a gun, and kind of needy."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "ak74"
	icon_state = "ak74"
	mag_type = /obj/item/ammo_box/magazine/m5mm
	init_mag_type = /obj/item/ammo_box/magazine/m5mm
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(1.4, 1.6)
	init_firemodes = list(
		/datum/firemode/automatic/rpm200 ,
		/datum/firemode/semi_auto
		)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_suppress = TRUE
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/z34rifle
	name = "eastern puma"
	desc = "A pre-fall large eastern rifle designed for hunting.  Hunting what?  Men."
	icon_state = "zastava"
	item_state = "zastava"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2.5, 2.5)
	init_firemodes = list (
		/datum/firemode/semi_auto/slower
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_flashlight = FALSE
	zoom_factor = 1.1
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/fnfal
	name = "handy"
	desc = "A large pre-fall battle rifle. Known today as a tempermental, heavy, beast of a weapon. At least the designers had the foresight to add a handle."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "fnfal"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1, 1.5)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/fnfal/g3battlerifle
	name = "forte"
	desc = "A foreign designed battle rifle. Pre-fall in design and well.  Tempermental.  Pretty decent overall though."
	icon_state = "g3"
	item_state = "g3"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/m308/ext
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(1.3, 1.2)
	init_firemodes = list(
		/datum/firemode/semi_auto ,
		/datum/firemode/automatic/rpm200
	)
	can_scope = TRUE
	can_suppress = TRUE
	can_flashlight = FALSE
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/rpd
	name = "eastern whirlwind"
	desc = "A pre-fall eastern designed light machine gun. It's rude, it's crude, it's downright demonic."
	icon_state = "rpd"
	item_state = "rpd"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/rpd
	init_mag_type = /obj/item/ammo_box/magazine/rpd
	weapon_class = WEAPON_CLASS_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	slowdown = GUN_SLOWDOWN_RIFLE_LMG * 1.5
	damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = LMG_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100
	)
	can_scope = FALSE
	can_suppress = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE

/obj/item/gun/ballistic/automatic/bar
	name = "lion"
	desc = "A pre-fall rifle. No one is sure who these were made for, they're almost too big for the average man to use. Perhaps people were larger back then?"
	icon = 'icons/fallout/objects/guns/bar.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "BAR"
	item_state = "BAR"
	mag_type = /obj/item/ammo_box/magazine/m308
	init_mag_type = /obj/item/ammo_box/magazine/m308/ext
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = AUTORIFLE_RECOIL(2, 1)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	fire_sound = 'sound/f13weapons/automaticrifle_BAR.ogg'

/obj/item/gun/ballistic/automatic/saiga12k
	name = "eastern stag"
	desc = "A pre-fall eastern shotgun. It's reliable and packs a punch.  Sure hope you don't want spare parts though."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	item_state = "saiga"
	icon_state = "saiga"
	mag_type = /obj/item/ammo_box/magazine/saiga
	init_mag_type = /obj/item/ammo_box/magazine/saiga
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_recoil = AUTORIFLE_RECOIL(2, 1.8)
	init_firemodes = list(
		/datum/firemode/automatic/rpm75 ,
		/datum/firemode/semi_auto/slow
	)
	can_flashlight = FALSE
	can_bayonet = FALSE
	can_scope = FALSE
	can_suppress = TRUE

/obj/item/gun/ballistic/shotgun/police
	name = "jackhammer"
	desc = "A pre-war shotgun with large magazine and folding stock, made from steel and polymers. Flashlight attachment rail."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/police
	sawn_desc = "Portable but with a poor recoil managment."
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
	
	stock = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 23
	flight_y_offset = 21
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/shotgun/trench
	name = "bucktoothed boar"
	desc = "A post-fall military shotgun designed for close-quarters fighting, equipped with a bayonet lug."
	icon_state = "trench"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 22
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

/obj/item/gun/ballistic/rifle/repeater/brush
	name = "smashback"
	desc = "A heavy Lever-action rifle chambered in .30-06 its sturdy design lets it handle the largest cartridges and largest game."
	icon_state = "brushgun"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube4570
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'

/obj/item/gun/ballistic/rifle/enfield
	name = "smelly"
	desc = "A pre-fall 10 round bolt action rifle.  No one is sure why they're called smellies, they don't stink at all generally and are quite good."
	sawn_desc = "Why would someone short stock a smelly? Does that make this just a whiff?"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "smle"
	item_state = "smle"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/enfield
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_recoil = RIFLE_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	cock_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	reskinnable_component = /datum/component/reskinnable/enfield
