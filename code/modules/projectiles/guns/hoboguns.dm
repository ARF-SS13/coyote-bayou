// IN THIS DOCUMENT: Improvised/home made, rebuilt whacky guns
// See gun.dm for keywords and the system used for gun balance


/obj/item/gun/ballistic/automatic/hobo
	slowdown = 0.3
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/automatic/hobo/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] misfires, detonating the round in the barrel prematurely!</span>")
		user.take_bodypart_damage(0,20)
		user.dropItemToGround(src)
		return FALSE
	..()

/obj/item/gun/ballistic/revolver/hobo
	slowdown = 0.2
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/revolver/hobo/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] misfires, detonating the round in the barrel prematurely!</span>")
		user.take_bodypart_damage(0,22)
		user.dropItemToGround(src)
		return FALSE
	..()


/obj/item/gun/ballistic/rifle/hobo
	slowdown = 0.4
	icon = 'icons/fallout/objects/guns/energy.dmi'
	can_scope = TRUE

/obj/item/gun/ballistic/rifle/hobo/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] overheats and blasts you with superheated air!</span>")
		user.take_bodypart_damage(0,20)
		user.dropItemToGround(src)
		return FALSE
	..()

/obj/item/gun/ballistic/automatic/autopipe/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] misfires, detonating the round in the barrel prematurely!</span>")
		user.take_bodypart_damage(0,20)
		user.dropItemToGround(src)
		return FALSE
	..()

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
	desc = "A crudely handcrafted zip gun that uses 9mm ammo."
	item_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/zipgun

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_LIGHT
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/hobo/zipgun/update_icon_state()
	icon_state = "zipgun[magazine ? "-[CEILING(get_ammo(0)/1, 1)*1]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

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
	name = "pipe rifle (.223)"
	desc = "A rusty piece of pipe used to fire .223 and 5,56mm ammo."
	icon_state = "piperifle"
	item_state = "pepperbox"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvisedpipe

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/revolver/hobo/piperifle/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] misfires, detonating the round in the barrel prematurely!</span>")
		user.take_bodypart_damage(0,20)
		user.dropItemToGround(src)
		return FALSE
	..()

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
	desc = "Take four pipes. Tie them together. Add planks, 10mm ammo and prayers."
	icon_state = "pepperbox"
	item_state = "pepperbox"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised10mm

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T5
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/revolver/hobo/pepperbox/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(prob(1))
		playsound(user, fire_sound, 50, 1)
		to_chat(user, "<span class='userdanger'>[src] misfires, detonating the round in the barrel prematurely!</span>")
		user.take_bodypart_damage(0,20)
		user.dropItemToGround(src)
		return FALSE
	..()

/* * * * * * * * * * *
 * SHOTGUN BAT
 * SHOTGUN BAT
 * 12g
 * High damage
 * Slow shooting
 * Two-handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/single_shotgun
	name = "shotgun bat"
	desc = "A baseball bat, a piece of pipe and a screwdriver is all you need to fire a shotgun shell apparantly. Good for whacking things once fired too."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgunbat"
	item_state = "shotgunbat"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'

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
	desc = "Someone thought, whats better than a knife? A knife that can shoot a bullet from its handle, that's what. It's doubtful if its true but it´s here so might as well use it."
	icon_state = "knifegun"
	item_state = "knifegun"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = GUN_ONE_HAND_AKIMBO
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised44

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

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
	desc = "An attempt to combine a knuckleduster and four short gun barrels. Totally works as a ballistic fist, if you take them off first."
	icon_state = "knucklegun"
	item_state = "knucklegun"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_GLOVES
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised45

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_SEMI
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_PISTOL_LIGHT * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/Gunshot.ogg'


/* * * * * * * * * * *
 * Autopipe Rifle
 * Waster BFG
 * .357 magnum
 * Burst fire?
 * Akimbo
 * Awful accuracy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/autopipe
	name = "Auto-pipe rifle (.357)"
	desc = "A belt fed pipe rifle held together with duct tape. Highly inaccurate. What could go wrong."
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
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 4
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/weapons/Gunshot.ogg'

/obj/item/gun/ballistic/automatic/autopipe/update_icon_state()
	icon_state = "autopipe[magazine ? "-[CEILING(get_ammo(0)/1, 6)*1]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"



/////////////////////
//PREMIUM HOBO GUNS//
/////////////////////


//Laser musket
/obj/item/gun/ballistic/rifle/hobo/lasmusket
	name = "Laser Musket"
	desc = "In the wasteland, one must make do. And making do is what the creator of this weapon does. Made from metal scraps, electronic parts. an old rifle stock and a bottle full of dreams, the Laser Musket is sure to stop anything in their tracks and make those raiders think twice."
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

/* * * * * * * * * * *
 * Destroyer Carbine
 * Hobo semi-auto
 * 9mm
 * Awful accuracy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/hobo/destroyer
	name = "destroyer carbine"
	desc = "There are many ways to describe this, very few of them nice. This is a 9mm silenced bolt action rifle - that via the expertise of a gun runner mainlining 50 liters of psycho, mentats, and turbo - has been converted into a semi auto."
	icon_state = "destroyer-carbine"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/greasegun

	slowdown = GUN_SLOWDOWN_RIFLE_LIGHT_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_RIFLE_LIGHT_AUTO * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	can_attachments = FALSE
	can_automatic = FALSE
	automatic_burst_overlay = TRUE
	can_scope = FALSE
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14
	semi_auto = FALSE


//Obrez, sawn off bolt action rifle						Keywords: .308, 5 round internal
/obj/item/gun/ballistic/rifle/hunting/obrez
	name = "Obrez"
	desc = "A cut down bolt action rifle. Uses .308."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "308-sawn"
	item_state = "308-sawn"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting

	slowdown = GUN_SLOWDOWN_RIFLE_MEDIUM_SEMI
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_RIFLE_MEDIUM_AUTO * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = FALSE


//Winchester rebore. 									Keywords: .308, 2 round internal, saw-off
/obj/item/gun/ballistic/revolver/winchesterrebored
	name = "rebored Winchester"
	desc = "A Winchester double-barreled shotgun rebored to fire .308 ammunition."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "winchesterbore"
	item_state = "shotgundouble"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised762
	w_class = WEIGHT_CLASS_BULKY

	slowdown = GUN_SLOWDOWN_SHOTGUN_FIXED
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_ONLY
	draw_time = GUN_DRAW_QUICK
	recoil_multiplier = GUN_RECOIL_SHOTGUN_FIXED * HOBO_RECOIL_MULT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONGER
	spread = GUN_SPREAD_AWFUL
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_SLOWER
	burst_shot_delay = GUN_BURSTFIRE_DELAY_SLOWER
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

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
