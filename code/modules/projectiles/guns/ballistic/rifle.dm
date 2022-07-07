//IN THIS DOCUMENT: Rifle template, Lever-action rifles, Bolt-action rifles, Magazine-fed bolt-action rifles
// See gun.dm for keywords and the system used for gun balance



////////////////////
// RIFLE TEMPLATE //
////////////////////


/obj/item/gun/ballistic/rifle

	name = "rifle template"
	desc = "Should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	flags_1 =  CONDUCT_1
	can_automatic = FALSE
	casing_ejector = FALSE
	var/recentpump = 0 // to prevent spammage
	spawnwithmagazine = TRUE
	var/pump_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	var/pump_stam_cost = 2

/obj/item/gun/ballistic/rifle/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/rifle/can_shoot()
	return !!chambered?.BB

/obj/item/gun/ballistic/rifle/attack_self(mob/living/user)
	if(recentpump > world.time)
		return
	if(IS_STAMCRIT(user))//CIT CHANGE - makes pumping shotguns impossible in stamina softcrit
		to_chat(user, "<span class='warning'>You're too exhausted for that.</span>")//CIT CHANGE - ditto
		return//CIT CHANGE - ditto
	pump(user, TRUE)
	if(HAS_TRAIT(user, TRAIT_FAST_PUMP))
		recentpump = world.time + GUN_COCK_RIFLE_LIGHTNING
	else
		recentpump = world.time + cock_delay
		if(istype(user))//CIT CHANGE - makes pumping shotguns cost a lil bit of stamina.
			user.adjustStaminaLossBuffered(pump_stam_cost) //CIT CHANGE - DITTO. make this scale inversely to the strength stat when stats/skills are added
	return

/obj/item/gun/ballistic/rifle/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/rifle/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message("<span class='warning'>[M] racks [src].</span>", "<span class='warning'>You rack [src].</span>")
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/rifle/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/rifle/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	if (chambered)
		. += "A [chambered.BB ? "live" : "spent"] one is in the chamber."



/* * * * * * *
 * Repeaters *
 * * * * * * */

/* * * * * * * * * * *
 * Revolvers, but bigger
 * More magazine space
 * Little more damage
 * Two handed
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater
	name = "repeater template"
	desc = "should not exist"
	can_scope = TRUE
	scope_state = "scope_long"

	slowdown = GUN_SLOWDOWN_REPEATER
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_REPEATER_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	scope_x_offset = 5
	scope_y_offset = 13
	pump_sound = 'sound/f13weapons/cowboyrepeaterreload.ogg'

/obj/item/gun/ballistic/rifle/repeater/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	..()
	src.pump(user)

/* * * * * * * * * * *
 * Cowboy Repeater
 * Baseline Repeater
 * .357 Magnum
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/cowboy
	name = "cowboy repeater"
	desc = "A lever action rifle chambered in .357 Magnum. Smells vaguely of whiskey and cigarettes."
	icon_state = "cowboyrepeater"
	item_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357

	slowdown = GUN_SLOWDOWN_REPEATER
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_REPEATER_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'

/* * * * * * * * * * *
 * Trail Repeater
 * Big Repeater
 * .44 Magnum
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/trail
	name = "trail carbine"
	desc = "A lever action rifle chambered in .44 Magnum."
	icon_state = "trailcarbine"
	item_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44

	slowdown = GUN_SLOWDOWN_REPEATER
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_REPEATER_LIGHT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_NORMAL
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/f13weapons/44mag.ogg'

/* * * * * * * * * * *
 * Brush Repeater
 * Bigger Repeater
 * .45-70 Bigboy
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/repeater/brush
	name = "brush gun"
	desc = "A short lever action rifle chambered in the heavy 45-70 round. Issued to NCR Veteran Rangers in the absence of heavier weaponry."
	icon_state = "brushgun"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube4570

	slowdown = GUN_SLOWDOWN_REPEATER
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_REPEATER_HEAVY
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	fire_sound = 'sound/f13weapons/brushgunfire.ogg'


/* * * * * * * * * * * *
 * Bolt-Action Rifles  *
 * * * * * * * * * * * */

/* * * * * * * * * * *
 * Slow rifles
 * Low magazine space
 * More damage
 * Higher caliber
 * Accurate
 * Generally scopeable
 * Common
 * * * * * * * * * * */

/* * * * * * * * * * *
 * Hunting Bolt-Action Rifle
 * Baseline Bolt-Action Rifle
 * .308 / 7.62
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting
	name = "hunting rifle"
	desc = "A sturdy hunting rifle, chambered in .308. and in use before the war."
	icon_state = "308"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	sawn_desc = "A hunting rifle, crudely shortened with a saw. It's far from accurate, but the short barrel makes it quite portable."

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	pump_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/rifle/hunting/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/* * * * * * * * * * *
 * Remmington Bolt-Action Rifle
 * Accurate Bolt-Action Rifle
 * .308 / 7.62
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting/remington
	name = "Remington rifle"
	desc = "A militarized hunting rifle rechambered to 7.62. This one has had the barrel floated with shims to increase accuracy."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/remington

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

/obj/item/gun/ballistic/rifle/hunting/remington/attackby(obj/item/A, mob/user, params) //DO NOT BUBBA YOUR STANDARD ISSUE RIFLE SOLDIER!
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()

/* * * * * * * * * * *
 * Paciencia Bolt-Action Rifle
 * Superstrong Bolt-Action Rifle
 * .308 / 7.62
 * More damage
 * Less magazine
 * Unique
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/hunting/paciencia
	name = "Paciencia"
	desc = "A modified .308 hunting rifle with a reduced magazine but an augmented receiver. A Mexican flag is wrapped around the stock. You only have three shots- make them count."
	icon_state = "paciencia"
	item_state = "paciencia"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/paciencia

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_NONE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T4
	cock_delay = GUN_COCK_RIFLE_BASE

	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE

/obj/item/gun/ballistic/rifle/hunting/paciencia/attackby(obj/item/A, mob/user, params) //no sawing off this one
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()

/* * * * * * * * * * *
 * Mosin Bolt-Action Rifle
 * Moist Bolt-Action Rifle
 * .308 / 7.62
 * Can bayonet
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mosin
	name = "Mosin-Nagant m38"
	desc = "A rusty old Russian bolt action chambered in 7.62."
	icon_state = "mosin"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_BASE

	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	pump_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'

/* * * * * * * * * * *
 * SMLE Bolt-Action Rifle
 * Quick Bolt-Action Rifle
 * .308 / 7.62
 * Faster cock
 * More tiring cock
 * Can bayonet
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/enfield
	name = "Lee-Enfield rifle"
	desc = "A british rifle sometimes known as the SMLE. It seems to have been re-chambered in .308."
	icon_state = "enfield2"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_INSTANT
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_T1
	cock_delay = GUN_COCK_RIFLE_FAST

	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	pump_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'
	pump_stam_cost = 15


/* * * * * * * * * * * * * * * * * *
 * Magazine-Fed Bolt-Action Rifles *
 * * * * * * * * * * * * * * * * * */

/* * * * * * * * * * *
 * Slower rifles
 * Low magazine space
 * More damage
 * Higher caliber
 * Accurate
 * Generally scopeable
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mag
	name = "magazine fed bolt-action rifle template"
	desc = "should not exist."

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

/obj/item/gun/ballistic/rifle/mag/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to remove the magazine.</span>"

/obj/item/gun/ballistic/rifle/mag/AltClick(mob/living/user)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(magazine)
		magazine.forceMove(drop_location())
		user.put_in_hands(magazine)
		magazine.update_icon()
		if(magazine.ammo_count())
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, 1)
		else
			playsound(src, "gun_remove_empty_magazine", 70, 1)
		magazine = null
		to_chat(user, "<span class='notice'>You pull the magazine out of \the [src].</span>")
	else if(chambered)
		AC.forceMove(drop_location())
		AC.bounce_away()
		chambered = null
		to_chat(user, "<span class='notice'>You unload the round from \the [src]'s chamber.</span>")
		playsound(src, "gun_slide_lock", 70, 1)
	else
		to_chat(user, "<span class='notice'>There's no magazine in \the [src].</span>")
	update_icon()
	return

/obj/item/gun/ballistic/rifle/mag/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/* * * * * * * * * * *
 * Anti-Materiel Rifle
 * Huge Bolt-Action Rifle
 * .50MG
 * Slow to fire
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/rifle/mag/antimateriel
	name = "anti-materiel rifle"
	desc = "The Hecate II is a heavy, high-powered bolt action sniper rifle chambered in .50 caliber ammunition. Lacks an iron sight."
	icon_state = "amr"
	item_state = "amr"
	mag_type = /obj/item/ammo_box/magazine/amr

	slowdown = GUN_SLOWDOWN_RIFLE_BOLT
	force = GUN_MELEE_FORCE_RIFLE_LIGHT
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	recoil_multiplier = GUN_RECOIL_RIFLE_BOLT
	recoil_cooldown_time = GUN_RECOIL_TIMEOUT_LONG
	spread = GUN_SPREAD_ACCURATE
	fire_delay = GUN_FIRE_DELAY_SLOWER
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	gun_damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_RIFLE_BASE

	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/f13weapons/antimaterielfire.ogg'
	pump_sound = 'sound/f13weapons/antimaterielreload.ogg'

// BETA // Obsolete
/obj/item/gun/ballistic/rifle/rifletesting
	name = "hunting"
	mag_type = /obj/item/ammo_box/magazine/testbullet
	gun_damage_multiplier = 30
