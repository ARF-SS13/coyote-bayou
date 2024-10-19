/obj/item/gun/magic/staff
	weapon_class = WEAPON_CLASS_RIFLE
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	item_flags = NEEDS_PERMIT | NO_MAT_REDEMPTION
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/magic/staff/change
	name = "staff of change"
	desc = "An artefact that spits bolts of coruscating energy which cause the target's very form to reshape itself."
	fire_sound = 'sound/magic/staff_change.ogg'
	ammo_type = /obj/item/ammo_casing/magic/change
	icon_state = "staffofchange"
	item_state = "staffofchange"

/obj/item/gun/magic/staff/animate
	name = "staff of animation"
	desc = "An artefact that spits bolts of life-force which causes objects which are hit by it to animate and come to life! This magic doesn't affect machines."
	fire_sound = 'sound/magic/staff_animation.ogg'
	ammo_type = /obj/item/ammo_casing/magic/animate
	icon_state = "staffofanimation"
	item_state = "staffofanimation"

/obj/item/gun/magic/staff/healing
	name = "staff of resurrection"
	desc = "An artefact that spits bolts of restoring magic which can remove ailments of all kinds and even raise the dead."
	fire_sound = 'sound/magic/staff_healing.ogg'
	ammo_type = /obj/item/ammo_casing/magic/heal
	icon_state = "staffofhealing"
	item_state = "staffofhealing"
	max_charges = 1
	recharge_rate = 10 MINUTES

/obj/item/gun/magic/staff/chaos
	name = "staff of chaos"
	desc = "An artefact that spits bolts of chaotic magic that can potentially do anything."
	fire_sound = 'sound/magic/staff_chaos.ogg'
	ammo_type = /obj/item/ammo_casing/magic/chaos
	icon_state = "staffofchaos"
	item_state = "staffofchaos"
	max_charges = 10
	recharge_rate = 1 MINUTES
	no_den_usage = 1
	var/allowed_projectile_types = list(/obj/item/projectile/magic/change, /obj/item/projectile/magic/animate, /obj/item/projectile/magic/resurrection,
	/obj/item/projectile/magic/death, /obj/item/projectile/magic/teleport, /obj/item/projectile/magic/door, /obj/item/projectile/magic/aoe/fireball,
	/obj/item/projectile/magic/spellblade, /obj/item/projectile/magic/arcane_barrage, /obj/item/projectile/magic/locker)

/obj/item/gun/magic/staff/chaos/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	chambered.projectile_type = pick(allowed_projectile_types)
	. = ..()

/obj/item/gun/magic/staff/healing/triheal
	name = "staff of unstable blessings"
	desc = "An artefact that spits bolts of restorative magic. This one has three spells of healing enchanted into its crystal, however the wielder cannot choose which shall be cast due to the artefact's wild nature."
	fire_sound = 'sound/magic/mystical.ogg'
	ammo_type = /obj/item/ammo_casing/magic/chaos
	icon_state = "triheal"
	item_state = "broom"
	max_charges = 30
	recharge_rate = 6 SECONDS
	var/allowed_projectile_types = list(/obj/item/projectile/magic/healbrute, /obj/item/projectile/magic/healburn, /obj/item/projectile/magic/healtoxin)
	init_firemodes = list(
		/datum/firemode/automatic/rpm100,
		/datum/firemode/semi_auto/faster
	)

/obj/item/gun/magic/staff/healing/triheal/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	chambered.projectile_type = pick(allowed_projectile_types)
	. = ..()

/obj/item/gun/magic/staff/door
	name = "staff of door creation"
	desc = "An artefact that spits bolts of transformative magic that can create doors in walls."
	fire_sound = 'sound/magic/staff_door.ogg'
	ammo_type = /obj/item/ammo_casing/magic/door
	icon_state = "staffofdoor"
	item_state = "staffofdoor"
	max_charges = 10
	recharge_rate = 30 SECONDS
	no_den_usage = 1

/obj/item/gun/magic/staff/spellblade
	name = "spellblade"
	desc = "A deadly combination of laziness and boodlust, this blade allows the user to dismember their enemies without all the hard work of actually swinging the sword."
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/spellblade
	icon_state = "spellblade"
	item_state = "spellblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	hitsound = 'sound/weapons/rapierhit.ogg'
	force = 40
	block_chance = 20
	sharpness = SHARP_EDGED
	max_charges = 4



/obj/item/gun/magic/staff/spellblade/run_block(mob/living/owner, atom/object, damage, attack_text, attack_type, armour_penetration, mob/attacker, def_zone, final_block_chance, list/block_return)
	// Do not block projectiles.
	if(attack_type & ATTACK_TYPE_PROJECTILE)
		return BLOCK_NONE
	return ..()

//obj/item/gun/magic/staff/spellblade/weak
	//name = "spellblade"
	//desc = "A weapon summoned by the will of the user, it's capable of shooting magic arrows to soften up foes in close range"
	//fire_sound = 'sound/magic/fireball.ogg'
	//ammo_type = /obj/item/projectile/spellcard/sword
	//icon_state = "spellblade"
	//item_state = "spellblade"
	//lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	//righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	//hitsound = 'sound/weapons/rapierhit.ogg'
	//force_unwielded = 25
	//force_wielded = 40
	//block_parry_data = /datum/block_parry_data/bokken
	//item_flags = ITEM_CAN_PARRY
	//weapon_special_component = /datum/component/weapon_special/single_turf
	//item_flags = DROPDEL
	//sharpness = SHARP_EDGED
	//max_charges = 1
	//damage = 30

/obj/item/gun/magic/staff/locker
	name = "staff of the locker"
	desc = "An artefact that expells encapsulating bolts, for incapacitating thy enemy."
	fire_sound = 'sound/magic/staff_change.ogg'
	ammo_type = /obj/item/ammo_casing/magic/locker
	icon_state = "locker"
	item_state = "locker"
	max_charges = 6
	recharge_rate = 10 SECONDS

/////////////////////////////////////
//KELPRUNNER'S MAGIC WEAPONS
//Staves define your playstyle
//If this doesn't get too big, just define projectile/damage here for simplicity's sake?
/////////////////////////////////////

/obj/item/gun/magic/staff/kelpmagic
	name = "Kelp's Stave of Templating"
	desc = "If you can see this, call a coder! Or panic."
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic
	max_charges = 50
	recharge_rate = 1 SECONDS
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_ONE_HAND_ONLY // Staves can be fired one-handed but should be held with two. Akimbo bad.
	w_class = WEIGHT_CLASS_BULKY // Staves are ALWAYS Bulky. There are no exceptions.
	force = 20 // It's a bigger stick.
	force_unwielded = 20
	force_wielded = 30 // It *is* a bigger stick...
	throwforce = 20
	is_kelpwand = TRUE
	fire_sound = 'sound/weapons/pulse2.ogg'
	cock_delay = GUN_COCK_RIFLE_BASE
	init_recoil = RIFLE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	reskinnable_component = /datum/component/reskinnable/staff_kelpmagic
	// NOTE: max_charges is the number of shots, recharge_rate is time to recharge a single charge.

/* This segment is commented out because the original template is over in wand.dm; this is here just for ease of reference
/obj/item/ammo_casing/magic/kelpmagic
	projectile_type = /obj/item/projectile/magic/kelpmagic

/obj/item/projectile/magic/kelpmagic
	name = "template projectile"
	icon_state = "arcane_barrage"
	damage = 0
	damage_type = BURN
	nodamage = 0
	flag = "magic"
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	recoil = BULLET_RECOIL_LASER
*/

/****************/
//Staff of Magic Missile//
//Basic Mage's Staff - Shotgun with bayonet/
/***************/

/obj/item/gun/magic/staff/kelpmagic/magicmissile
	name = "staff of magic missile"
	desc = "This staff's unusual design allows it to be easily aimed from the hip and be used as a slashing weapon. Attuned to this staff is an enhanced version of the Magic Missile spell."
	icon_state = "mmstaff"
	max_charges = 6
	recharge_rate = 8 SECONDS
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/magicmissile/advanced
	force_wielded = 40 // Practical all around! May change later.
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "cut")
	sharpness = SHARP_EDGED
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto
	)

/obj/item/ammo_casing/magic/kelpmagic/magicmissile/advanced
	projectile_type = /obj/item/projectile/magic/kelpmagic/magicmissile/advanced
	pellets = 6

/obj/item/projectile/magic/kelpmagic/magicmissile/advanced
	name = "greater magic missile"
	icon_state = "arcane_barrage"
	damage = 40
	damage_low = 30
	damage_high = 50
	damage_type = BURN
	flag = "laser" // "magic" ignores all armor, "laser" checks laser, "energy" is plasma
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

/****************/
//Staff of Fireball//
//The most dreaded spell, now on a stick - RPG adjacent/
/***************/

/obj/item/gun/magic/staff/kelpmagic/fireball
	name = "staff of fireball"
	desc = "A simple staff topped with a giant ruby. It appears utterly mundane at a glance, and yet when held one can feel the flames roiling within. Devastation awaits whoever should be on the receiving end of this staff."
	icon_state = "firestaff"
	max_charges = 1
	recharge_rate = 27 SECONDS // With delimbing disabled this is much less dangerous than it used to be.
	slowdown = 1
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball // 40 to 90 bomb + knockdown + always blinds a square around the impact point + bonus dmg vs mobs

//Baby Fireball//
/obj/item/gun/magic/staff/kelpmagic/fireball/lowpower
	name = "low power staff of fireball"
	color = "#44FF00"
	desc = "A simple staff topped with a cracked ruby. It appears utterly mundane at a glance, and yet when held one can feel the flames roiling within. Devastation awaits whoever should be on the receiving end of this staff."
	icon_state = "firestaff"
	max_charges = 1
	recharge_rate = 10 SECONDS // With delimbing disabled this is much less dangerous than it used to be.
	slowdown = 1
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball/lowpower


/****************/
//Staff of Lightning//
//For I beheld Satan as he fell from heaven, like lightning! - DMR or Sniper adjacent/
/***************/

/obj/item/gun/magic/staff/kelpmagic/lightning
	name = "staff of lightning"
	desc = "The entire staff hums and crackles with power, and excess energy dances along its prongs. When unleashed, a single bolt of great power strikes out faster than the eye can see."
	icon_state = "lightningstaff"
	fire_sound = 'sound/f13weapons/TeslaCannonFire.ogg'
	max_charges = 12
	recharge_rate = 8 SECONDS
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/sparks/thunder
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/ammo_casing/magic/kelpmagic/sparks/thunder
		projectile_type = /obj/item/projectile/magic/kelpmagic/sparks/thunder

/obj/item/projectile/magic/kelpmagic/sparks/thunder
	name = "lightning bolt"
	flag = "laser" // plasma OP
	damage = 60
	damage_low = 40
	damage_high = 70

/obj/item/gun/magic/staff/kelpmagic/lightning/lowpower
	name = "low power staff of lightning"
	desc = "The entire staff hums and crackles with power.  Barely contained."
	icon_state = "lightningstaff"
	color = "#FFFF33"
	fire_sound = 'sound/f13weapons/TeslaCannonFire.ogg'
	max_charges = 4
	recharge_rate = 8 SECONDS
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/sparks/thunder/lowpower
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)

/obj/item/ammo_casing/magic/kelpmagic/sparks/thunder/lowpower
		projectile_type = /obj/item/projectile/magic/kelpmagic/sparks/thunder/lowpower

/obj/item/projectile/magic/kelpmagic/sparks/thunder/lowpower
	name = "low power lightning bolt"
	flag = "laser"
	damage = 40
	damage_low = 40
	damage_high = 60

/****************/
//Staff of Healing//
//Because every bottom needs their tools - medibeam adjacent, now with skill requirements!/
/***************/

/obj/item/gun/magic/staff/kelpmagic/healstaff
	name = "staff of healing"
	desc = "This golden staff is topped with a diamond that lets out a soothing hum. Due to its increased size, this staff is able to store power much more efficiently than its wand counterpart. It still can't heal its wielder, however."
	icon_state = "medstaff"
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/mending
	max_charges = 25 // 5x the capacity than the wand, but it is Bulky; heals 15/10/20/20/20/5 Bru/Brn/Tox/Oxy/Stm/Cln damage per shot; as a projectile it CAN miss and heal an enemy instead
	recharge_rate = 4 SECONDS // This makes it a higher ammo, slower recharging version of the wand, instead of just being completely inferior to the wand

/****************/
//Upgraded Staff of Healing//
//Literally just a bulky medbeam/
/***************/

/obj/item/gun/medbeam/magic
	name = "perfected staff of healing"
	desc = "Through mastery of arcane alchemy, this staff has been brought to the peak of its power... And yet it still can't heal the wielder. Don't cross the streams!"
	icon = 'icons/obj/guns/magic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon_state = "medstaff"
	item_state = "staff"
	w_class = WEIGHT_CLASS_BULKY
	force = 20
	force_unwielded = 20
	force_wielded = 30
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	is_kelpwand = TRUE
	pin = /obj/item/firing_pin/magic

/obj/item/gun/medbeam/magic/lowpower
	name = "lesser staff of healing"
	desc = "Through apprenticeship of arcane alchemy, this staff has been brought to some form of power... And yet it still can't heal the wielder. Don't cross the streams!"
	icon = 'icons/obj/guns/magic.dmi'
	color = "#BBEE33"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon_state = "medstaff"
	item_state = "staff"
	w_class = WEIGHT_CLASS_BULKY
	force = 20
	force_unwielded = 20
	force_wielded = 30
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	is_kelpwand = TRUE
	pin = /obj/item/firing_pin/magic

/obj/item/gun/medbeam/magic/lowpower/on_beam_tick(mob/living/target)
	if(target.health != target.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(target), "#80F5FF")
	target.adjustBruteLoss(-1, include_roboparts = TRUE)
	target.adjustFireLoss(-1, include_roboparts = TRUE)
	target.adjustToxLoss(-1, forced = TRUE)
	target.adjustOxyLoss(-1)
	return

/****************/
//Staff of Acid//
//OH GOD, IT'S EVERYWHERE - SMG adjacent/
/***************/

/obj/item/gun/magic/staff/kelpmagic/acidstaff
	name = "staff of acid"
	desc = "Simply holding this staff fills you with a sense of unease. Ephemeral ooze gathers at the tip before dripping and falling to nothing. When unleashed, it looses a spray of vile acid to rapidly eat away at anything it touches."
	icon_state = "acidstaff"
	fire_sound = 'sound/f13npc/centaur/spit.ogg'
	max_charges = 40 // This puts it in the same rough ballpark as the tesla autoshock, but projectile
	recharge_rate = 3.5 SECONDS //The acid staff is now a minigun for magic users, with worse damage
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/acidspray
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)

/obj/item/ammo_casing/magic/kelpmagic/acidspray
	projectile_type = /obj/item/projectile/magic/kelpmagic/acidspray

/obj/item/projectile/magic/kelpmagic/acidspray
	name = "acid spray"
	icon_state = "toxin"
	damage = 12
	damage_low = 15
	damage_high = 50 //Reduced the damage slightly, because now it has supereffective
	damage_type = BURN
	flag = "laser"
	supereffective_damage = 5 //This should make it deal 5 damage regardless of armor
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")

/obj/item/gun/magic/staff/kelpmagic/acidstaff/lowpower
	name = "low power staff of acid"
	desc = "Simply holding this staff fills you with a sense of unease. Ephemeral ooze gathers at the tip before dripping and falling to nothing. When unleashed, it looses a spray of vile acid to rapidly eat away at anything it touches."
	icon_state = "acidstaff"
	color = "#33BBFF"
	fire_sound = 'sound/f13npc/centaur/spit.ogg'
	max_charges = 10 // This puts it in the same rough ballpark as the tesla autoshock, but projectile
	recharge_rate = 4 SECONDS //The acid staff is now a minigun for magic users, with worse damage
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/acidspray
	init_firemodes = list(
		/datum/firemode/automatic/rpm150,
		/datum/firemode/semi_auto/faster
	)

/****************/
//Staff of Magma//
//AAAAAAAAAAA HELP MEEE - Flamethrower adjacent//
/***************/

/obj/item/gun/magic/staff/kelpmagic/flamethrower
	name = "staff of alchemical magma"
	desc = "A moderately sized staff made of black bronze that seems to be a hodgepodge of clockwork components connected together. A regenerating fuel cell rests along the side, with a tube connecting to a bunsen burner at the top that expels enflamed fuel that burns as hot as magma. A design of an arcane staff thats more mechanical than arcane, designed by a wandering artificer from a far off realm."
	icon_state = "staff of alchemy"
	item_state = "staff of alchemy"
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	fire_sound = 'sound/weapons/fire03.ogg'
	max_charges = 20
	recharge_rate = 1 SECONDS
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/magmaspray
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)

/obj/item/ammo_casing/magic/kelpmagic/magmaspray
	projectile_type = /obj/item/projectile/magic/kelpmagic/magmaspray
	pellets = 2

/obj/item/projectile/magic/kelpmagic/magmaspray
	name = "magma spray"
	icon_state = "nuclear" //This should make enemies with good burn armor resist the magma staff very well
	damage = 25
	damage_low = 20  // Does about 5-10 more damage than the magic missile wand per projectile, but the magic wand fires 6, this fires 2
	damage_high = 35
	damage_type = BURN
	range = 3
	pixels_per_second = 275
	flag = "laser"
	supereffective_damage = 2 //Reduced number of pellets + reduced super-effective should make this less powerful against all enemies
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN

//weak version
/obj/item/gun/magic/staff/kelpmagic/flamethrower/weak
	name = "low power staff of magma"
	desc = "A moderately sized staff made of black bronze that seems to be a hodgepodge of clockwork components connected together. A regenerating fuel cell rests along the side, with a tube connecting to a bunsen burner at the top that expels enflamed fuel that burns as hot as magma. A design of an arcane staff thats more mechanical than arcane, designed by a wandering artificer from a far off realm."
	icon_state = "staff of alchemy"
	item_state = "staff of alchemy"
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	fire_sound = 'sound/weapons/fire03.ogg'
	color = "#ac233e"
	max_charges = 10
	recharge_rate = 0.4 SECONDS //This staff is very weak against anything with armor
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/magmaspray/weak
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)
/obj/item/ammo_casing/magic/kelpmagic/magmaspray/weak
	projectile_type = /obj/item/projectile/magic/kelpmagic/magmaspray/weak
	pellets = 3

/obj/item/projectile/magic/kelpmagic/magmaspray/weak
	supereffective_damage = null // No more supereffective
	supereffective_faction = null
	damage = 5
	damage_low = 5
	damage_high = 10
	flag = "laser"
