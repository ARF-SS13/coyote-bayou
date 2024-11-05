/obj/item/gun/magic/wand
	name = "wand of nothing"
	desc = "It's not just a stick, it's a MAGIC stick!"
	ammo_type = /obj/item/ammo_casing/magic
	icon_state = "nothingwand"
	inhand_icon_state = "wand"
	weapon_class = WEAPON_CLASS_SMALL
	can_charge = TRUE
	max_charges = 100 //100, 50, 50, 34 (max charge distribution by 25%ths)
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi' //not really a gun and some toys use these inhands
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	var/variable_charges = FALSE

/obj/item/gun/magic/wand/Initialize()
	if(prob(75) && variable_charges) //25% chance of listed max charges, 50% chance of 1/2 max charges, 25% chance of 1/3 max charges
		if(prob(33))
			max_charges = CEILING(max_charges / 3, 1)
		else
			max_charges = CEILING(max_charges / 2, 1)
	return ..()

/obj/item/gun/magic/wand/examine(mob/user)
	. = ..()
	. += "Has [charges] charge\s remaining."

/obj/item/gun/magic/wand/update_icon_state()
	icon_state = "[initial(icon_state)][charges ? "" : "-drained"]"

/obj/item/gun/magic/wand/attack(atom/target, mob/living/user)
	if(target == user)
		return
	..()

/obj/item/gun/magic/wand/afterattack(atom/target, mob/living/user)
	if(!charges)
		shoot_with_empty_chamber(user)
		return
	if(target == user)
		if(no_den_usage)
			var/area/A = get_area(user)
			if(istype(A, /area/wizard_station))
				to_chat(user, span_warning("You know better than to violate the security of The Den, best wait until you leave to use [src]."))
				return
			else
				no_den_usage = 0
		zap_self(user)
	else
		. = ..()
	update_icon()


/obj/item/gun/magic/wand/proc/zap_self(mob/living/user)
	user.visible_message(span_danger("[user] zaps [user.p_them()]self with [src]."))
	playsound(user, fire_sound, 50, 1)
	user.log_message("zapped [user.p_them()]self with a <b>[src]</b>", LOG_ATTACK)


/////////////////////////////////////
//WAND OF DEATH
/////////////////////////////////////

/obj/item/gun/magic/wand/death
	name = "wand of death"
	desc = "This deadly wand overwhelms the victim's body with pure energy, slaying them without fail."
	fire_sound = 'sound/magic/wandodeath.ogg'
	ammo_type = /obj/item/ammo_casing/magic/death
	icon_state = "deathwand"
	max_charges = 3 //3, 2, 2, 1

/obj/item/gun/magic/wand/death/zap_self(mob/living/user)
	..()
	to_chat(user, "<span class='warning'>You irradiate yourself with pure energy! \
	[pick("Do not pass go. Do not collect 200 zorkmids.","You feel more confident in your spell casting skills.","You Die...","Do you want your possessions identified?")]\
	</span>")
	user.adjustOxyLoss(500)
	charges--

/obj/item/gun/magic/wand/death/debug
	desc = "In some obscure circles, this is known as the 'cloning tester's friend'."
	max_charges = 500
	variable_charges = FALSE
	can_charge = TRUE
	recharge_rate = 1

/////////////////////////////////////
//WAND OF HEALING
/////////////////////////////////////

/obj/item/gun/magic/wand/resurrection
	name = "Stick of healing"
	desc = "This wand uses healing magics to heal and revive. They are rarely utilized within the Wizard Federation for some reason."
	ammo_type = /obj/item/ammo_casing/magic/heal
	fire_sound = 'sound/magic/staff_healing.ogg'
	icon_state = "revivewand"
	max_charges = 1 //10, 5, 5, 4
	recharge_rate = 30 MINUTES

/obj/item/gun/magic/wand/resurrection/zap_self(mob/living/user)
	..()
	charges--
	if(user.anti_magic_check())
		user.visible_message(span_warning("[src] has no effect on [user]!"))
		return
	user.revive(full_heal = 1)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		C.regenerate_limbs()
		C.regenerate_organs()
	to_chat(user, span_notice("You feel great!"))

/obj/item/gun/magic/wand/resurrection/debug //for testing
	name = "debug wand of healing"
	max_charges = 500

/////////////////////////////////////
//WAND OF POLYMORPH
/////////////////////////////////////

/obj/item/gun/magic/wand/polymorph
	name = "wand of polymorph"
	desc = "This wand is attuned to chaos and will radically alter the victim's form."
	ammo_type = /obj/item/ammo_casing/magic/change
	icon_state = "polywand"
	fire_sound = 'sound/magic/staff_change.ogg'
	max_charges = 10 //10, 5, 5, 4

/obj/item/gun/magic/wand/polymorph/zap_self(mob/living/user)
	..() //because the user mob ceases to exists by the time wabbajack fully resolves
	wabbajack(user)
	charges--

/////////////////////////////////////
//WAND OF TELEPORTATION
/////////////////////////////////////

/obj/item/gun/magic/wand/teleport
	name = "wand of teleportation"
	desc = "This wand will wrench targets through space and time to move them somewhere else."
	ammo_type = /obj/item/ammo_casing/magic/teleport
	fire_sound = 'sound/magic/wand_teleport.ogg'
	icon_state = "telewand"
	max_charges = 10 //10, 5, 5, 4
	no_den_usage = 1

/obj/item/gun/magic/wand/teleport/zap_self(mob/living/user)
	if(do_teleport(user, user, 10, channel = TELEPORT_CHANNEL_MAGIC))
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(3, user.loc)
		smoke.start()
		charges--
	..()

/////////////////////////////////////
//WAND OF DOOR CREATION
/////////////////////////////////////

/obj/item/gun/magic/wand/door
	name = "wand of door creation"
	desc = "This particular wand can create doors in any wall for the unscrupulous wizard who shuns teleportation magics."
	ammo_type = /obj/item/ammo_casing/magic/door
	icon_state = "doorwand"
	fire_sound = 'sound/magic/staff_door.ogg'
	max_charges = 20 //20, 10, 10, 7
	no_den_usage = 1

/obj/item/gun/magic/wand/door/zap_self(mob/living/user)
	to_chat(user, span_notice("You feel vaguely more open with your feelings."))
	charges--
	..()

/////////////////////////////////////
//WAND OF FIREBALL
/////////////////////////////////////

/obj/item/gun/magic/wand/fireball
	name = "wand of fireball"
	desc = "This wand shoots scorching balls of fire that explode into destructive flames."
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/fireball
	icon_state = "firewand"
	max_charges = 8 //8, 4, 4, 3

/obj/item/gun/magic/wand/fireball/zap_self(mob/living/user)
	..()
	explosion(user.loc, -1, 0, 2, 3, 0, flame_range = 2)
	charges--

/////////////////////////////////////
//WAND OF ARCANE MISSILE
/////////////////////////////////////

/obj/item/gun/magic/wand/arcane
	name = "wand of arcane missile"
	desc = "This wand fires off small bolts of concentrated magic energy, searing any victim."
	ammo_type = /obj/item/ammo_casing/magic/arcane_barrage
	fire_sound = 'sound/weapons/mmlbuster.ogg'
	icon_state = "arcanewand"
	max_charges = 20 //20, 10, 10, 7

/obj/item/gun/magic/wand/arcane/zap_self(mob/living/user)
	..()
	charges--
	user.take_overall_damage(0,30)
	to_chat(user, span_warning("You zap yourself. Why?"))

/////////////////////////////////////
//KELPRUNNER'S MAGIC WEAPONS
//Wands are just pistols
//If this doesn't get too big, just define projectile/damage here for simplicity's sake?
/////////////////////////////////////

/obj/item/gun/magic/wand/kelpmagic
	name = "Kelp's Wand of Templating"
	desc = "If you see this, call a coder! Or panic."
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic
	weapon_class = WEAPON_CLASS_SMALL // Wands are ALWAYS either Small or Normal. They're not as strong as staves because of this; balance around people carrying 3 - 4 of these
	weapon_weight = GUN_ONE_HAND_ONLY // despite being smol, magic requires focus just to fire. Also akimbo OP
	w_class = WEIGHT_CLASS_SMALL
	force = 10 // It's a stick
	throwforce = 10 // Same.
	fire_sound = 'sound/weapons/pulse2.ogg'
	draw_time = GUN_DRAW_QUICK
	is_kelpwand = TRUE
	init_firemodes = list(
		/datum/firemode/semi_auto/slow
	)
	// NOTE: max_charges is the number of shots, recharge_rate is time to recharge a single charge.

/obj/item/ammo_casing/magic/kelpmagic
	projectile_type = /obj/item/projectile/magic/kelpmagic

/obj/item/projectile/magic/kelpmagic
	name = "template projectile"
	icon_state = "arcane_barrage"
	damage = 0
	nodamage = 0
	damage_type = BURN // Determines the health damage type; BRUTE, BURN, OXY, TOX.
	flag = "magic"  // "magic" ignores all armor, "laser" checks laser, "bullet" is bullet, "energy" is plasma
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	recoil = BULLET_RECOIL_LASER

/****************/
//Improvised Wand//
//Spawn tier weapon/
/***************/

/obj/item/gun/magic/wand/kelpmagic/magicmissile // T0 spawn wand. Everything should be better than this!
	name = "improvised wand of magic missile"
	desc = "An extremely basic wand carved from bone, and topped with a roughly hewn crystal. Good for begginers, and handling vermin, but not much else."
	icon_state = "missilewand"
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/magicmissile/weak
	max_charges = 1
	recharge_rate = 4 SECONDS
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
		/datum/firemode/semi_auto/faster
	)

/obj/item/ammo_casing/magic/kelpmagic/magicmissile/weak
	projectile_type = /obj/item/projectile/magic/kelpmagic/magicmissile/weak
	pellets = 6

/obj/item/projectile/magic/kelpmagic/magicmissile/weak
	name = "weak arcane bolt"
	icon_state = "arcane_barrage"
	damage = 15
	damage_low = 25
	damage_high = 35
	damage_type = BURN
	flag = "laser"

/****************/
//Improvised Zapper//
//Spawn tier weapon, hitscan/
/***************/

/obj/item/gun/magic/wand/kelpmagic/basiczappies
	name = "improvised rod of sparks"
	desc = "Someone's gone and tied a lump of gold to the end of a metal rod before wiring a battery up to it. Somehow, this allows the 'wand' to channel a lesser variant of the Sparks spell."
	icon_state = "improvshock"
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/sparks/weak
	max_charges = 3
	recharge_rate = 1 SECONDS // It used to fire 3 shots, this just makes it a bit like how it was before
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)

/obj/item/ammo_casing/magic/kelpmagic/sparks/weak
	projectile_type = /obj/item/projectile/magic/kelpmagic/sparks/weak

/obj/item/projectile/magic/kelpmagic/sparks/weak
	supereffective_damage = null
	supereffective_faction = null

/****************/
//Wand of Magic Missile//
//Projectile wand, generalist//
/***************/

/obj/item/gun/magic/wand/kelpmagic/magicmissile/improved
	name = "wand of magic missile"
	desc = "A golden rod sits securely in a handle of runed wood. Attuned to this wand is the most iconic of mage spells: Magic Missile. It's a simple spell for more practical practitioners."
	icon_state = "magicmissile"
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/magicmissile/average
	max_charges = 2
	recharge_rate = 6 SECONDS
	init_recoil = AUTOCARBINE_RECOIL(1, 1)
	init_firemodes = list(
	/datum/firemode/semi_auto/faster
	)

/obj/item/ammo_casing/magic/kelpmagic/magicmissile/average
	projectile_type = /obj/item/projectile/magic/kelpmagic/magicmissile/average
	pellets = 6

/obj/item/projectile/magic/kelpmagic/magicmissile/average
	name = "arcane bolt"
	icon_state = "arcane_barrage"
	damage = 35
	damage_low = 30
	damage_high = 40
	damage_type = BURN
	flag = "laser"
	spread = BULLET_SPREAD_SURPLUS
	recoil = BULLET_RECOIL_SHOTGUN_PELLET
	wound_falloff_tile = BULLET_WOUND_FALLOFF_PISTOL_LIGHT
	zone_accuracy_type = ZONE_WEIGHT_SHOTGUN


/****************/
//Wand of Sparks//
//Beam wand, anti-swarm//
/***************/

/obj/item/gun/magic/wand/kelpmagic/sparky
	name = "wand of sparks"
	desc = "Cut from diamond and inlaid with gold, this wand is certainly eye-catching. Electricity crawls along the focus, eager to be let loose in a shocking storm."
	icon_state = "lightningrod"
	fire_sound = 'sound/weapons/Taser.ogg'
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/sparks
	max_charges = 4
	recharge_rate = 2 SECONDS
	init_firemodes = list(
		/datum/firemode/automatic/rpm300
	)

/obj/item/ammo_casing/magic/kelpmagic/sparks
		projectile_type = /obj/item/projectile/magic/kelpmagic/sparks

/obj/item/projectile/magic/kelpmagic/sparks
	name = "spark"
	damage = 15 // Don't want to go much higher than this, but 10 bane might be too much. May just need to give it better shots or charging.
	damage_low = 10
	damage_high = 20
	damage_type = BURN
	flag = "energy"
	icon_state = "omnilaser"
	impact_effect_type = /obj/effect/temp_visual/impact_effect/blue_laser
	light_color = LIGHT_COLOR_BLUE
	tracer_type = /obj/effect/projectile/tracer/pulse
	muzzle_type = /obj/effect/projectile/muzzle/pulse
	impact_type = /obj/effect/projectile/impact/pulse
	hitscan = TRUE
	hitscan_light_intensity = 4
	hitscan_light_range = 1
	hitscan_light_color_override = LIGHT_COLOR_BLUE
	muzzle_flash_intensity = 9
	muzzle_flash_range = 4
	muzzle_flash_color_override = LIGHT_COLOR_BLUE
	impact_light_intensity = 8
	impact_light_range = 3.75
	impact_light_color_override = LIGHT_COLOR_BLUE
	supereffective_damage = 10
	supereffective_faction = list("hostile", "ant", "supermutant", "aethergiest", "cazador", "raider", "china", "gecko", "wastebot", "yaoguai")


/****************/
//Wand of Firebolt//
//Projectile wand, anti-elite//
/***************/

/obj/item/gun/magic/wand/kelpmagic/firebolt
	name = "wand of firebolt"
	desc = "This wand is made of meticulously carved wood and diamond, topped with a stone that burns with an inner fire. The bolt it launches is perfect for scorching armored foes."
	icon_state = "fireboltwand"
	fire_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/firebolt
	max_charges = 3
	recharge_rate = 4 SECONDS

/obj/item/ammo_casing/magic/kelpmagic/firebolt
		projectile_type = /obj/item/projectile/magic/kelpmagic/firebolt

/obj/item/projectile/magic/kelpmagic/firebolt
	name = "fire bolt"
	icon_state = "fireball"
	damage = 45
	damage_low = 30
	damage_high = 50
	damage_type = BURN
	flag = "energy"

/****************/
//Wand of Mending//
//Projectile wand, weak(?) healing//
/***************/

/obj/item/gun/magic/wand/kelpmagic/healwand
	name = "wand of mending"
	desc = "With a silver core and a casing of gold, this wand visibly channels the energies of life itself. It can let loose bolts that heal all forms of damage, though it's less efficent than alchemy and cannot heal the wand's wielder."
	icon_state = "mendwand"
	w_class = WEIGHT_CLASS_NORMAL // It's a source of infinite healing, it needs a downside; can carry two wands in a shoulder holster (~100 healing every 5 minutes)
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/mending
	max_charges = 5
	recharge_rate = 3 SECONDS

/obj/item/ammo_casing/magic/kelpmagic/mending // Because the projectile isn't here, heals 15 brute + 10 burn damage and 20 tox/oxy, along with a pittance of clone.
		projectile_type = /obj/item/projectile/magic/tenderwand


/**************/
//Colfer supermagic hands//
//Testing phase//
/**************/
/*/obj/item/gun/magic/wand/kelpmagic/basiczappies/hand
	name = "hand of sparks"
	desc = "A hand of magical energy"
	icon_state = "improvshock"
	ammo_type = /obj/item/ammo_casing/magic/kelpmagic/sparks/weak
	max_charges = 20
	can_charge = FALSE
	init_firemodes = list(
		/datum/firemode/automatic/rpm200
	)
*/// Corpse of a project I don't have the time or willpower to finish
