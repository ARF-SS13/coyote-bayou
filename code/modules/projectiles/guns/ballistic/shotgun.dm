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
	icon_state = "pump"
	item_state = "shotgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE

	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	can_scope = FALSE
	flags_1 =  CONDUCT_1
	casing_ejector = FALSE
	spawnwithmagazine = TRUE
	cock_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	init_recoil = SHOTGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	reloading_time = 0.5 SECONDS

/* /obj/item/gun/ballistic/shotgun/process_chamber(mob/living/user, empty_chamber = 0)
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
 */
/obj/item/gun/ballistic/shotgun/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/* /obj/item/gun/ballistic/shotgun/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message(span_warning("[M] racks [src]."), span_warning("You rack [src]."))
	playsound(M, cock_sound, 60, 1)
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

 *//obj/item/gun/ballistic/shotgun/lethal
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal

/* /// Pump if click with empty thing
/obj/item/gun/ballistic/shotgun/shoot_with_empty_chamber(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	if(chambered && HAS_TRAIT(user, TRAIT_FAST_PUMP))
		attack_self(user)
	else
		..() */

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
	name = "caravan rifle"
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
	mag_type = /obj/item/ammo_box/magazine/internal/shot/single
	weapon_class = WEAPON_CLASS_TINY
	weapon_weight = GUN_ONE_HAND_AKIMBO
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/shotgun_fixed
	)

	fire_sound = 'sound/f13weapons/max_sawn_off.ogg'

/obj/item/gun/ballistic/revolver/shotpistol/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/revolver/shotpistol/flair_gun
	name = "Flair Gun"
	desc = "This plastic orange flare gun has been reinforced with a high strength prewar alloy pipe insert, allowing it to fit a .50 bmg cartridge. Hopefully your hand is reinforced too."
	icon = 'modular_coyote/icons/objects/pistols.dmi'
	icon_state = "flaregun50_civ"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/single/fifty


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
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

// Haha johnathan you're fucking my sawed off shotgun
// /obj/item/gun/ballistic/shotgun/hunting/update_icon_state()
//	if(sawn_off)
//		icon_state = "[initial(icon_state)]-sawn"
//	else if(!magazine || !magazine.ammo_count(0))
//		icon_state = "[initial(icon_state)]-e"
//	else
//		icon_state = "[initial(icon_state)]"
/obj/item/gun/ballistic/shotgun/hunting/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/shotgun/hunting/sawn
	name = "sawed-off hunting shotgun"
	desc = "A traditional hunting shotgun with wood furniture and a two-plus-one-shell capacity. This one has probably been modified, in quotes, by someone with a name like Cletus."
	icon_state = "pump-sawn"
	item_state = "shotgun" // Is this how it figures out the in hand sprite to pair with player sprites? This doesn't match anything in guns_left/righthand.dmi...
	mag_type = /obj/item/ammo_box/magazine/internal/shot/shorty
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	
// Makes the gun appear empty when it still has one in the chamber. No sir, I don't like it.
/obj/item/gun/ballistic/shotgun/hunting/sawn/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
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
	mag_type = /obj/item/ammo_box/magazine/internal/shot/police
	sawn_desc = "Portable but with a poor recoil managment."
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
	
	var/stock = FALSE
	can_flashlight = TRUE
	gunlight_state = "flightangle"
	flight_x_offset = 23
	flight_y_offset = 21
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
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
		slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You unfold the stock.")
		recoil_tag = SSrecoil.give_recoil_tag(RIFLE_RECOIL(1, 1))
	else
		slot_flags = INV_SLOTBIT_BACK | INV_SLOTBIT_BELT
		w_class = WEIGHT_CLASS_SMALL
		to_chat(user, "You fold the stock.")
		recoil_tag = SSrecoil.give_recoil_tag(init_recoil)
	update_icon()

/obj/item/gun/ballistic/shotgun/police/update_icon_state()
	var/datum/reskin/myskin = get_current_skin()
	if(myskin)
		icon_state = "[myskin?.icon_state][stock ? "" : "fold"]"
	else
		icon_state = "shotgunpolice[stock ? "" : "fold"]"

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

/obj/item/gun/ballistic/shotgun/trench/update_icon_state()
	if(!magazine || !magazine.ammo_count(0))
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"




/* * * * * * * * * * * *
* s163 minotaur shotgun
* + pump action shotgun
* + Can be supressed
* + Common 'police' shotgun used by I.C police forces
* - doesn't have a folding stock and can not be modified heavily like the police shotgun
* * * * * * * * * * * * */
/obj/item/gun/ballistic/shotgun/s163
	name = "S163 Minotaur shotgun"
	desc = "A S163 Minotaur shotgun, was in used by Lithuanian police departments and military personal. A reliable top loading shotgun design made by the Leo Company. It has a 5+1 magazine tube capacity alongside a built in small ammo counter"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/mino
	icon_state = "s163"
	item_state = "s163"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	cock_delay = GUN_COCK_SHOTGUN_BASE
	gun_skill_check = AFFECTED_BY_FAST_PUMP | AFFECTED_BY_AUTO_PUMP
	can_scope = FALSE
	can_bayonet = FALSE
	can_flashlight = FALSE
	can_suppress = TRUE
	casing_ejector = FALSE
	spawnwithmagazine = TRUE
	cock_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'
	init_recoil = SHOTGUN_RECOIL(2, 2)
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'

/obj/item/gun/ballistic/shotgun/
/* * * * * * * * * * * *
 * Semi-auto shotguns  *
 * * * * * * * * * * * */
/// warning, most arent semi-automatic

/obj/item/gun/ballistic/shotgun/automatic/combat
	name = "semi-auto shotgun template"
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_BASE

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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	casing_ejector = TRUE // makes it eject casings -- and not need pumping!!!
	fire_sound = 'sound/f13weapons/auto5.ogg'

/obj/item/gun/ballistic/shotgun/automatic/combat/auto5/worn
	name = " Venn Family Shotgun"
	desc = "A semi automatic shotgun with a four round tube. Has an etching into the side."
	icon_state = "auto5"
	item_state = "shotgunauto5"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/com/compact
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	casing_ejector = TRUE // makes it eject casings -- and not need pumping!!!
	fire_sound = 'sound/f13weapons/auto5.ogg'


/* /obj/item/gun/ballistic/shotgun/automatic/combat/auto5/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	..()
	src.pump(user) */

/* * * * * * * * * * *
 * Lever-Action shotgun
 * Speedy pump shotgun
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever
	name = "mare's leg shotgun"
	desc = "A speedy pistol grip lever action shotgun with a five-shell capacity underneath plus one in chamber."
	icon_state = "shotgunlever"
	item_state = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_SMALL
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T2 //can bump to T1 if this is too poor
	cock_delay = GUN_COCK_SHOTGUN_FAST
	init_recoil = SHOTGUN_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = FALSE //doesn't need one, needs some disadvantage compared to a trench gun
	bayonet_state = "bayonet"
	knife_x_offset = 23
	knife_y_offset = 23

/* * * * * * * * * * *
 * Lever-Action shotgun Restocked
 * Speedy pump shotgun, with stock
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock
	name = "lever action shotgun"
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
/* * * * * * * * * * *
 * Lever-Action shotgun Restocked Tribal
 * Speedy pump shotgun, with stock
 * 12g
 * Uncommon
 * * * * * * * * * * */

/obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever/stock/tribal
	name = "Mourning Sunrise"
	desc = "A speedy lever action shotgun with a sunrise painted on the furnishings, morbid in context of it's purpose."
	icon_state = "latribal"
	item_state = "shotgunlever"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/trench
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	cock_delay = GUN_COCK_SHOTGUN_FAST
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

	fire_sound = 'sound/f13weapons/shotgun.ogg'
	can_bayonet = FALSE
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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'
	init_recoil = AUTOSHOTGUN_RECOIL(1, 1)

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
	mag_type = /obj/item/ammo_box/magazine/d12g
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/riot_shotgun.ogg'
	init_recoil = AUTOSHOTGUN_RECOIL(1, 1)

/obj/item/gun/ballistic/shotgun/needles
	name = "Pz87 pump-action shotgun"
	desc = "A Pz87 shotgun. Manufactured by Latos Systems in collaboration with the Swiss navy and Remington, this shotgun has a internal 6+1 internal tube capacity. Unlike traditional ballistics, it fires micro-needles. A prototype shotgun that never saw the light of combat and battle."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "needlesg"
	item_state = "needlesg"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/needler
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	fire_sound = 'sound/f13weapons/needler.ogg'
	init_recoil = AUTOSHOTGUN_RECOIL(1, 1)

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
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_LESS_DAMAGE_T1
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/slow
	)
	init_recoil = AUTOSHOTGUN_RECOIL(1, 0.8)

// Ballistic Fist			Keywords: Damage max 42, Shotgun
/obj/item/gun/ballistic/revolver/ballisticfist
	name = "ballistic fist"
	desc = "This powerfist has been modified to have two shotgun barrels welded to it, with the trigger integrated into the knuckle guard. For those times when you want to punch someone and shoot them in the face at the same time."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "ballisticfist"
	item_state = "powerfist"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	mag_type = /obj/item/ammo_box/magazine/internal/shot/dual
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	weapon_class = WEAPON_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_GLOVES
	var/transfer_prints = TRUE //prevents runtimes with forensics when held in glove slot
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	init_recoil = SHOTGUN_RECOIL(1, 1)

// BETA // Obsolete
/obj/item/gun/ballistic/shotgun/shotttesting
	name = "shotgun"
	icon_state = "shotgunpolice"
	item_state = "shotgunpolice"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lethal/test
	damage_multiplier = 7
