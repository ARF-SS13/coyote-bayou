//IN THIS DOCUMENT: Shotgun template, Double barrel shotguns, Pump-action shotguns, Semi-auto shotgun
// See gun.dm for keywords and the system used for gun balance



//////////////////////
// SHOTGUN TEMPLATE //
//////////////////////


/obj/item/gun/ballistic/shotgun
	name = "shotgun template"
	desc = "Should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_prefix = "shotgunpump"
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/internal/shot

	slowdown = GUN_SLOWDOWN_SHOTGUN_PUMP
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE

	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	can_scope = FALSE
	flags_1 =  CONDUCT_1
	casing_ejector = FALSE
	var/recentpump = 0 // to prevent spammage
	spawnwithmagazine = TRUE
	var/pump_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	init_recoil = RIFLE_RECOIL(2.5)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)


/obj/item/gun/ballistic/shotgun/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/shotgun/can_shoot()
	return !!chambered?.BB

/obj/item/gun/ballistic/shotgun/attack_self(mob/living/user)
	update_icon()
	//if(recentpump > world.time)
	//	return
	if(IS_STAMCRIT(user))//CIT CHANGE - makes pumping shotguns impossible in stamina softcrit
		to_chat(user, span_warning("You're too exhausted for that."))//CIT CHANGE - ditto
		return//CIT CHANGE - ditto
	pump(user, TRUE)
	//if(HAS_TRAIT(user, TRAIT_FAST_PUMP))
	//	recentpump = world.time + GUN_COCK_SHOTGUN_LIGHTNING
	//else
	//	recentpump = world.time + cock_delay
	if(istype(user))//CIT CHANGE - makes pumping shotguns cost a lil bit of stamina.
		user.adjustStaminaLossBuffered(2) //CIT CHANGE - DITTO. make this scale inversely to the strength stat when stats/skills are added
	return

/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/shotgun/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message(span_warning("[M] racks [src]."), span_warning("You rack [src]."))
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	update_firemode()
	return 1

/obj/item/gun/ballistic/shotgun/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/shotgun/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/shotgun/examine(mob/user)
	. = ..()
	if (chambered)
		. += "A [chambered.BB ? "live" : "spent"] one is in the chamber."

/obj/item/gun/ballistic/shotgun/lethal
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

/// Pump if click with empty thing
/obj/item/gun/ballistic/shotgun/shoot_with_empty_chamber(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	if(chambered && HAS_TRAIT(user, TRAIT_FAST_PUMP))
		attack_self(user)
	else
		..()

/* * * * * * * * * * * * * *
 * Double barrel shotguns  *
 * * * * * * * * * * * * * */

/* * * * * * * * * * *
 * Caravan shotgun
 * Baseline DB shotgun
 * 12g
 * Sawable
 * Common
 * * * * * * * * * * */
/obj/item/gun/ballistic/revolver/caravan_shotgun
	name = "caravan shotgun"
	desc = "An common over-under double barreled shotgun made in the post-war era."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "caravan"
	item_state = "shotgundouble"
	icon_prefix = "shotgundouble"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual/simple

	slowdown = GUN_SLOWDOWN_SHOTGUN_FIXED
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed,
	)

	sawn_desc = "Short and concealable, terribly uncomfortable to fire, but worse on the other end."
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)
/obj/item/gun/ballistic/revolver/caravan_shotgun/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter) | istype(A, /obj/item/twohanded/chainsaw))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/revolver/caravan_shotgun/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/* * * * * * * * * * *
 * Widowmaker shotgun
 * Baseline DB shotgun
 * 12g
 * Sawable
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/widowmaker
	name = "Winchester Widowmaker"
	desc = "Old-world Winchester Widowmaker double-barreled 12 gauge shotgun, with mahogany furniture"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "widowmaker"
	item_state = "shotgundouble"
	icon_prefix = "shotgundouble"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	w_class = WEIGHT_CLASS_BULKY

	slowdown = GUN_SLOWDOWN_SHOTGUN_FIXED
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed,
		/datum/firemode/burst/two/shotgun_fixed,
	)
	sawn_desc = "Someone took the time to chop the last few inches off the barrel and stock of this shotgun. Now, the wide spread of this hand-cannon's short-barreled shots makes it perfect for short-range crowd control."
	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)

/obj/item/gun/ballistic/revolver/widowmaker/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter) | istype(A, /obj/item/twohanded/chainsaw))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

/obj/item/gun/ballistic/revolver/widowmaker/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/* * * * * * * * * * *
 * Singleshot shotgun
 * Baseline "DB" shotgun
 * 12g
 * fits in a pocket
 * One shot
 * Squeak
 * tulyak
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/revolver/shotpistol
	name = "hand shotgun"
	desc = "Exactly one half of a sawed off double barrel shotgun, stripped down and streamlined to fit snugly in someone's pocket. \
			The rubberized grip helps absorb just enough of the recoil to be fired with one hand, and a sturdy latch locks the breech \
			open after unloading for easy access. Despite claims to the contrary, this is <i>not</i> just flare gun with extra parts. \
			Allegedly based on old schematics for the 'tulyak' single-shot pistol shotgun, albeit rechambered to 12-gauge due to availability."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotpistol"
	item_state = "357colt"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_TINY
	mag_type = /obj/item/ammo_box/magazine/internal/shot/single

	slowdown = GUN_SLOWDOWN_PISTOL_LIGHT
	force = GUN_MELEE_FORCE_PISTOL_HEAVY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	draw_time = GUN_DRAW_QUICK
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_FASTEST
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed
	)

	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)

/obj/item/gun/ballistic/revolver/shotpistol/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/* * * * * * * * *
 * Pump shotguns *
 * * * * * * * * */

/* * * * * * * * * * *
 * Hunting shotgun
 * Baseline Pump shotgun
 * 12g
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/hunting
	name = "hunting shotgun"
	desc = "A traditional hunting shotgun with wood furniture and a four-shell capacity underneath."
	icon_state = "pump"
	item_state = "shotgunpump"
	icon_prefix = "shotgunpump"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

	slowdown = GUN_SLOWDOWN_SHOTGUN_PUMP //penis
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/ballistic/shotgun/hunting/update_icon_state()
	if(sawn_off)
		icon_state = "[initial(icon_state)]-sawn"
	else if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/* * * * * * * * * * *
 * Police shotgun
 * Hideaway Pump shotgun
 * 12g
 * Folds up
 * More recoil when folded up
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/police
	name = "police shotgun"
	desc = "A pre-war shotgun with large magazine and folding stock, made from steel and polymers. Flashlight attachment rail."
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	icon_prefix = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/police
	sawn_desc = "Portable but with a poor recoil managment."
	w_class = WEIGHT_CLASS_NORMAL

	slowdown = GUN_SLOWDOWN_SHOTGUN_PUMP
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0

	var/stock = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 23
	flight_y_offset = 21
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/ballistic/shotgun/police/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_stock(user)
	return TRUE

/obj/item/gun/ballistic/shotgun/police/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to toggle the stock.")

/obj/item/gun/ballistic/shotgun/police/proc/toggle_stock(mob/living/user)
	stock = !stock
	if(stock)
		slot_flags = ITEM_SLOT_BACK
		w_class = WEIGHT_CLASS_BULKY
		to_chat(user, "You unfold the stock.")
		recoil_dat = getRecoil(RIFLE_RECOIL(2.2)[1],RIFLE_RECOIL(2.2)[2],RIFLE_RECOIL(2.2)[3])
	else
		slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You fold the stock.")
		recoil_dat = getRecoil(init_recoil[1],init_recoil[2],init_recoil[3])
	update_icon()

/obj/item/gun/ballistic/shotgun/police/update_icon_state()
	icon_state = "[current_skin ? unique_reskin[current_skin] : "shotgunpolice"][stock ? "" : "fold"]"

/* * * * * * * * * * *
 * Trench shotgun
 * Hideaway Pump shotgun
 * 12g
 * Quicker to cock
 * Common
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/trench
	name = "trench shotgun"
	desc = "A quick military shotgun designed for close-quarters fighting, equipped with a bayonet lug."
	icon_state = "trench"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench

	slowdown = GUN_SLOWDOWN_SHOTGUN_PUMP
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST

	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 24
	knife_y_offset = 22
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/gun/ballistic/shotgun/trench/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"


/* * * * * * * * * * * *
 * Semi-auto shotguns  *
 * * * * * * * * * * * */
/// warning, most arent semi-automatic

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "semi-auto shotgun template"

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/gun/ballistic/shotgun/automatic/combat/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/* * * * * * * * * * *
 * Auto-5 shotgun
 * Baseline semi-auto shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5
	name = "Browning Auto-5"
	desc = "A semi automatic shotgun with a four round tube."
	icon_state = "auto5"
	item_state = "shotgunauto5"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_SLOW
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	fire_sound = 'sound/f13weapons/auto5.ogg'

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	..()
	src.pump(user)

/* * * * * * * * * * *
 * Lever-Action shotgun
 * Speedy pump shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever
	name = "lever action shotgun"
	desc = "A speedy pistol grip lever action shotgun with a five-shell capacity underneath plus one in chamber."
	icon_state = "shotgunlever"
	item_state = "shotgunlever"
	icon_prefix = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST
	init_recoil = RIFLE_RECOIL(2.8)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 23
	knife_y_offset = 23

/* * * * * * * * * * *
 * Neostead shotgun
 * Two-Tube semi-auto shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead
	name = "Neostead 2000"
	desc = "An advanced shotgun with two separate magazine tubes, allowing you to quickly toggle between ammo types."
	icon_state = "neostead"
	item_state = "shotguncity"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_recoil = RIFLE_RECOIL(2.2)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

	var/toggled = FALSE
	var/obj/item/ammo_box/magazine/internal/shot/alternate_magazine

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click to switch tubes.")

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/Initialize()
	. = ..()
	if (!alternate_magazine)
		alternate_magazine = new mag_type(src)

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/attack_self(mob/living/user)
	. = ..()
	if(!magazine.contents.len)
		toggle_tube(user)

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/proc/toggle_tube(mob/living/user)
	var/current_mag = magazine
	var/alt_mag = alternate_magazine
	magazine = alt_mag
	alternate_magazine = current_mag
	toggled = !toggled
	if(toggled)
		to_chat(user, "You switch to tube B.")
	else
		to_chat(user, "You switch to tube A.")

/obj/item/gun/ballistic/shotgun/automatic/combat/neostead/AltClick(mob/living/user)
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_tube(user)


/* * * * * * * * * * *
 * City-Killer shotgun
 * Super semi-auto shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	name = "Winchester City-Killer shotgun"
	desc = "A high capacity pump action shotgun with black tactical furniture made by Winchester Arms. This particular model uses a internal tube magazine."
	icon_state = "citykiller"
	item_state = "shotguncity"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/citykiller

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_FIRE_DELAY_SLOW
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_recoil = RIFLE_RECOIL(2.8)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'

/* * * * * * * * * * *
 * Riot shotgun
 * Magazine semi-auto shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/shotgun/riot
	name = "Riot shotgun"
	desc = "A compact riot shotgun with a large ammo drum and semi-automatic fire, designed for sustained fire at medium distances. A barrel designed for less-lethal ammo dulls its punch slightly, but you can't argue with the capacity."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	icon_state = "shotgunriot"
	item_state = "shotgunriot"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/d12g

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_LESS_DAMAGE_T1
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_firemodes = list(
		/datum/firemode/semi_auto
	)


	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)


/* * * * * * * * * * *
 * Jackhammer shotgun
 * Magazine automatic! shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/automatic/shotgun/pancor
	name = "Pancor Jackhammer"
	desc = "A drum-loaded, fully automatic shotgun. The pinnacle of turning things into swiss cheese."
	icon_state = "pancor"
	item_state = "cshotgun1"
	fire_sound = 'sound/f13weapons/repeater_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/d12g
	is_automatic = TRUE

	slowdown = GUN_SLOWDOWN_SHOTGUN_AUTO
	force = GUN_MELEE_FORCE_RIFLE_HEAVY
	weapon_weight = GUN_TWO_HAND_ONLY
	draw_time = GUN_DRAW_LONG
	fire_delay = GUN_FIRE_DELAY_NORMAL
	autofire_shot_delay = GUN_AUTOFIRE_DELAY_NORMAL
	burst_shot_delay = GUN_BURSTFIRE_DELAY_NORMAL
	burst_size = 1
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE
	init_recoil = RIFLE_RECOIL(2.8)
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto
	)

	automatic = 1
	w_class = WEIGHT_CLASS_BULKY
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(SHOTGUN_VOLUME),
		SP_VOLUME_SILENCED(SHOTGUN_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(SHOTGUN_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(SHOTGUN_DISTANT_SOUND),
		SP_DISTANT_RANGE(SHOTGUN_RANGE_DISTANT)
	)

// BETA // Obsolete
/obj/item/gun/ballistic/shotgun/shotttesting
	name = "shotgun"
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal/test
	damage_multiplier = 7
