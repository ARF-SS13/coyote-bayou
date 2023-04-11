/obj/item/gun/ballistic/bow/flintlock
	name = "flintlock pistol"
	desc = "An ancient but well kept blackpowder pistol."
	icon_state = "flintlock"
	item_state = "flintlock"
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	mag_type = /obj/item/ammo_box/magazine/internal/flintlock
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	draw_sound = 'sound/effects/wep_magazines/smg_load.ogg'
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball
	can_link_to_quiver = FALSE //do NOT turn this on
	release_text = "you gently lower the hammer and clear the powder charge." //flintlocks can't be easily unloaded, buuut making that so would be difficult
	draw_noun = "hammer"

/obj/item/gun/ballistic/bow/flintlock/laser
	name = "flintlock laser pistol"
	desc = "An old sport shooting pistol that utilizes a compact explosively pumped ferroelectric generator to create a burst of capacitor energy out of a blackpowder charge."
	icon_state = "flintlock_laser"
	item_state = "flintlock_laser"
	icon_prefix = "flintlock_laser"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO	
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	mag_type = /obj/item/ammo_box/magazine/internal/flintlock

/obj/item/gun/ballistic/bow/flintlock/laser/post_modify_projectile(obj/item/projectile/BB) //thurr. I turned a regular bullet into a laser bullet.
	BB.name = "musket bolt"
	BB.icon = 'icons/obj/projectiles.dmi'
	BB.icon_state = "emitter"
	BB.pass_flags = PASSTABLE| PASSGLASS
	BB.light_range = 2
	BB.damage_type = BURN
	BB.flag = "laser"
	BB.impact_effect_type = /obj/effect/temp_visual/impact_effect/green_laser
	BB.light_color = LIGHT_COLOR_GREEN
	BB.is_reflectable = TRUE
	BB.hitsound = 'sound/weapons/sear.ogg'
	BB.hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	playsound(src, 'sound/weapons/emitter.ogg', 25, 1)

/obj/item/gun/ballistic/bow/chamber_round()
	chambered = magazine.stored_ammo[1]
