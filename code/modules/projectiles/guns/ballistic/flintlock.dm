/obj/item/gun/flintlock
	name = "flintlock pistol"
	desc = "An ancient but well kept blackpowder pistol."
	icon_state = "flintlock"
	item_state = "flintlock"
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	fire_sound = 'sound/f13weapons/44revolver.ogg'
	trigger_guard = TRIGGER_GUARD_NORMAL //hate to break it to ya, flintlocks require more technical skill to operate than a cartridge loaded firearm
	draw_sound = 'sound/effects/wep_magazines/smg_load.ogg'
	dryfire_text = "*not loaded*"
	init_firemodes = list(
		/datum/firemode/semi_auto/slow //slow for the sake of macros, but not toooo slow
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_AUTOMATIC //smoothbore short barrel round ball
	release_text = "you gently lower the hammer and clear the powder charge." //flintlocks can't be easily unloaded, buuut making that so would be difficult
	draw_noun = "hammer"
	var/cocked = FALSE

/obj/item/gun/flintlock/attack_self(mob/living/user)
	cock(user)

/obj/item/gun/flintlock/AltClick(mob/user)
	unload(user)

/obj/item/gun/flintlock/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/ammo_box))
		load_from_box(user, I)
	if(istype(I, /obj/item/ammo_casing))
		load_casing(user, I)

/// Sets cocked to TRUE, and plays a ka-ta-click noise
/obj/item/gun/flintlock/proc/cock(mob/living/user)
	if(!user)
		return FALSE
	if(cocked)
		uncock(user)
		return
	to_chat(user, span_alert("You cock [src]"))
	playsound(get_turf(src), 'sound/weapons/hammer_cock.ogg')


/// Plays a click-sound, then a half-second later, shoots whatever's under the user's cursor. or the mob's direction if the cursor's params are null
/obj/item/gun/flintlock/pre_fire(mob/user, atom/target, params, zone_override, stam_cost, message = TRUE)
	if(!user?.client)
		return FALSE
	playsound(user, 'sound/weapons/hammer_click2.ogg', 90, 1)
	addtimer(CALLBACK(src, .proc/fire_at_cursor, user), 0.5 SECONDS)
	return TRUE

/// shoots whatever's under the user's cursor. or the user's direction if the cursor's params are null
/obj/item/gun/flintlock/proc/fire_at_cursor(mob/user)
	firing = FALSE // dont wan tto make a new proc just for this
	if(!user)
		return FALSE // cus shit like this could happen
	if(!user.client)
		return FALSE
	var/atom/tar_get = user.client.mouseObject
	if(!tar_get)
		tar_get = get_step(user, user.dir)
	do_fire(tar_get, mob/living/user, message = TRUE, user.client.mouseParams)

/obj/item/gun/flintlock/laser
	name = "flintlock laser pistol"
	desc = "An old sport shooting pistol that utilizes a compact explosively pumped ferroelectric generator to create a burst of capacitor energy out of a blackpowder charge."
	icon_state = "flintlock_laser"
	item_state = "flintlock_laser"
	icon_prefix = "flintlock_laser"
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO	
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock

/obj/item/gun/flintlock/laser/post_modify_projectile(obj/item/projectile/BB) //thurr. I turned a regular bullet into a laser bullet.
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


//Fenny begins being evil here

/obj/item/gun/flintlock/musket
	name = "ancient musket"
	desc = "An ancient but well kept blackpowder musket."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "musket1"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T4
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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

/obj/item/gun/flintlock/musketoon
	name = "ancient musketoon"
	desc = "An ancient but well kept blackpowder musketoon; handy!"
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "musketoon"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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

/obj/item/gun/flintlock/musket/jezail
	name = "ancient jezail"
	desc = "An ancient but well kept blackpowder jezail; handy!"
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "jezail"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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

/obj/item/gun/flintlock/musket/tanegashima
	name = "ancient tanegashima"
	desc = "A matchlock rifle handmade by a craftsman some time after the fall of the old world."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "tanegashima"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "tanegashima"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T5
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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

/obj/item/gun/flintlock/musketoon/spingarda
	name = "ancient spingarda"
	desc = "An ancient but well kept blackpowder rock chucker!"
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "spingarda"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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

/obj/item/gun/flintlock/musketoon/mosquete
	name = "ancient mosquete"
	desc = "An ancient but well kept blackpowder musket, lighter and handier than a full sized musket with a beautiful ebony stock."
	icon = 'modular_coyote/icons/objects/ancient.dmi'
	icon_state = "mosquete1752"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_prefix = "flintlock"
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	added_spread = GUN_SPREAD_POOR
	damage_multiplier = GUN_EXTRA_DAMAGE_T3
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/flintlock
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
