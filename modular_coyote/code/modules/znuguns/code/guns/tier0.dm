
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
	desc = "An almost safe post-fall muzzle loading pistol. Probably- uh. Just don't drop it while loaded."
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
	init_recoil = HANDGUN_RECOIL(1, 1)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION // plug em in the skull!
	init_firemodes = list(
		/datum/firemode/semi_auto/fast
	)
	can_suppress = FALSE
	silenced = TRUE
	fire_sound_silenced = 'sound/f13weapons/22pistol.ogg'

	damage_multiplier = TIER0

/obj/item/gun/ballistic/revolver/detective
	name = "sidewinder"
	desc = "A very handy six shooter. If your only worries in life are killing a family of squirrels."
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev22
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	init_recoil = HANDGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

	damage_multiplier = TIER0

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

	damage_multiplier = TIER0

/obj/item/gun/ballistic/automatic/sportcarbine
	name = "spitball"
	desc = "One of the many .22 LR carbines that were all the rage before the cataclysm. While lacking in firepower, it more than makes up for it with its cheapness to fire."
	icon_state = "surplus"
	item_state = "rifle"
	mag_type = /obj/item/ammo_box/magazine/m22
	init_mag_type = /obj/item/ammo_box/magazine/m22/extended
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_ONE_HAND_AKIMBO
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

	damage_multiplier = TIER0
