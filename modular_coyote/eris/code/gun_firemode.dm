/*
 * /datum/firemode - the way guns know how to fire
 * Every gun gets one of these. Every one of them. Even the ones that don't have a firemode. They get a default one.
 * Defines things like:
 * - Fire rate
 * - Burst size
 * - Fire type (semi, burst, auto)
 * - Damage multiplier
 * - etc
 */
/datum/firemode
	var/name = "default"
	var/desc = "The default firemode"
	var/extra_tip = "Shoots!"
	var/icon_state
	var/list/settings = list()
	/// is the gun semi, burst, or fullauto?
	var/fire_type = GUN_FIREMODE_SEMIAUTO
	var/fire_type_default = GUN_FIREMODE_SEMIAUTO
	/// Time between shots, both semi and full auto
	var/shoot_delay = GUN_FIRE_DELAY_NORMAL
	var/shoot_delay_default = GUN_FIRE_DELAY_NORMAL
	/// Time between shots when fired as a burst. Shoot delay is time between bursts
	var/burst_delay = GUN_BURSTFIRE_DELAY_NORMAL
	var/burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	/// How many shots per burst
	var/burst_count = 1
	var/burst_count_default = 1
	/// Damage multiplier
	var/damage_multiplier = 1
	var/damage_multiplier_default = 1
	/// Shot cost multiplier
	var/shot_cost_multiplier = 1
	var/shot_cost_multiplier_default = 1
	/// If set, will override the gun's chambered casing with this just as its about to fire
	// var/obj/item/ammo_casing/override_shot
	// var/obj/item/ammo_casing/override_shot_default
	/// If we are here because of an upgrade, this is the upgrade that brought us here
	/// If this is ever not in the gun's item_upgrades list, we will be destroyed!
	var/atom/movable/my_dependant
	/// THe gun this is attached to
	var/datum/weakref/my_gun

/datum/firemode/New(obj/item/gun/_gun, atom/movable/_dependant)
	..()
	fire_type = fire_type_default
	shoot_delay = shoot_delay_default
	burst_delay = burst_delay_default
	burst_count = burst_count_default
	damage_multiplier_default = _gun.damage_multiplier
	damage_multiplier = damage_multiplier_default
	shot_cost_multiplier = shot_cost_multiplier_default
	my_gun = WEAKREF(_gun)
	if(_dependant)
		my_dependant = WEAKREF(_dependant)

/datum/firemode/Destroy()
	var/obj/item/gun/gun = GET_WEAKREF(my_gun)
	if(gun)
		gun.firemodes -= src
		gun.set_firemode(1)
	my_gun = null
	return ..()

/datum/firemode/proc/apply_firemode()
	var/obj/item/gun/gun = GET_WEAKREF(my_gun)
	if(!gun)
		stack_trace("[src]'s gun is null in apply_firemode()! OH FUCK")
		qdel(src)
		return
	update_mods()
	gun.automatic = (fire_type == GUN_FIREMODE_AUTO)
	gun.burst_size = burst_count
	gun.fire_delay = shoot_delay
	gun.burst_shot_delay = burst_delay
	gun.damage_multiplier = damage_multiplier

/datum/firemode/proc/update_mods()
	var/obj/item/gun/gun = GET_WEAKREF(my_gun)
	if(!gun)
		stack_trace("[src]'s gun is null in update_mods()! OH FUCK")
		qdel(src)
		return
	if(my_dependant)
		var/atom/movable/papa_mod = GET_WEAKREF(my_dependant)
		if(!papa_mod || !(papa_mod in gun.item_upgrades))
			qdel(src)
			return
	fire_type = fire_type_default
	shoot_delay = shoot_delay_default
	burst_delay = burst_delay_default
	burst_count = burst_count_default
	damage_multiplier = damage_multiplier_default
	shot_cost_multiplier = shot_cost_multiplier_default
	for(var/obj/item/attch in gun.item_upgrades)
		var/list/my_upgrades = list()
		SEND_SIGNAL(attch, COMSIG_GET_UPGRADES, my_upgrades)
		if(!LAZYLEN(my_upgrades))
			continue
		for(var/cat in my_upgrades)
			switch(cat)
				if(GUN_UPGRADE_DAMAGE_MULT)
					damage_multiplier = LAZYACCESS(my_upgrades, cat)
				if(GUN_UPGRADE_FIRE_DELAY_MULT)
					shoot_delay *= LAZYACCESS(my_upgrades, cat)
					burst_delay *= LAZYACCESS(my_upgrades, cat)
				if(GUN_UPGRADE_CHARGECOST)
					shot_cost_multiplier *= LAZYACCESS(my_upgrades, cat)

/datum/firemode/proc/get_fire_delay(rpm_plz)
	var/deciseconds_per_shot = shoot_delay
	if(rpm_plz)
		deciseconds_per_shot = round((10 / max(deciseconds_per_shot, 0.1)) * 60, 5)
	return deciseconds_per_shot

//Called whenever the firemode is switched to, or the gun is picked up while its active
/datum/firemode/proc/update()
	return

/datum/firemode/semi_auto
	name = "Semi Automatic"
	desc = "Shoot one shot per trigger pull."
	extra_tip = "Fires when you release the mouse button. Note that on any intent other than Harm, \
		if you move your mouse before releasing the button, or your mouse is over a different 'thing' \
		when let go, you will probably not fire. To more reliably fire, use the Harm intent when shooting!"
	icon_state = "semi"
	fire_type_default = GUN_FIREMODE_SEMIAUTO
	shoot_delay_default = GUN_FIRE_DELAY_NORMAL
	burst_count_default = 1

/datum/firemode/semi_auto/shotgun_fixed
	name = "One at a time"
	desc = "Send vagabonds flying back several paces"

/datum/firemode/semi_auto/fastest
	shoot_delay_default = GUN_FIRE_DELAY_FASTEST

/datum/firemode/semi_auto/faster
	shoot_delay_default = GUN_FIRE_DELAY_FASTER

/datum/firemode/semi_auto/fast
	shoot_delay_default = GUN_FIRE_DELAY_FAST

/datum/firemode/semi_auto/slow
	shoot_delay_default = GUN_FIRE_DELAY_SLOW

/datum/firemode/semi_auto/slower
	shoot_delay_default = GUN_FIRE_DELAY_SLOWER

/datum/firemode/semi_auto/slowest
	shoot_delay_default = GUN_FIRE_DELAY_SLOWEST

/datum/firemode/automatic
	name = "Fully Automatic"
	desc = "Spray and pray."
	icon_state = "auto"
	extra_tip = "Fires as long as you hold the mouse click down. Careful when clicking things, \
		it will rapidly click them."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_1200

/datum/firemode/automatic/rpm1200
	name = "Fully Automatic"
	desc = "Automatic - 1200 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_1200

/datum/firemode/automatic/rpm1000
	name = "Fully Automatic"
	desc = "Automatic - 1000 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_1000

/datum/firemode/automatic/rpm800
	name = "Fully Automatic"
	desc = "Automatic - 800 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_800

/datum/firemode/automatic/rpm600
	name = "Fully Automatic"
	desc = "Automatic - 600 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_600

/datum/firemode/automatic/rpm400
	name = "Fully Automatic"
	desc = "Automatic - 400 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_400

/datum/firemode/automatic/rpm300
	name = "Fully Automatic"
	desc = "Automatic - 300 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_300

/datum/firemode/automatic/rpm200
	name = "Fully Automatic"
	desc = "Automatic - 200 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_200

/datum/firemode/automatic/rpm250
	name = "Fully Automatic"
	desc = "Automatic - 250 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_250

/datum/firemode/automatic/rpm150
	name = "Fully Automatic"
	desc = "Automatic - 150 RPM."
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_150


/datum/firemode/automatic/rpm75
	name = "fully automatic"
	desc = "Automatic - 75rpm"
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_75

/datum/firemode/automatic/rpm40
	name = "fully automatic"
	desc = "Automatic - 40rpm"
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_40

/datum/firemode/automatic/rpm100
	name = "fully automatic"
	desc = "Automatic - 100rpm"
	fire_type_default = GUN_FIREMODE_AUTO
	shoot_delay_default = GUN_FIRE_RATE_100

/datum/firemode/burst
	name = "Burstfire"
	desc = "Shoot multiple shots per triggerpull."
	extra_tip = "Fires a several-round burst. Recoil is calculated after the end of the burst, so every shot \
		in the burst will have more or less the same amount of spread."
	icon_state = "burst"
	fire_type_default = GUN_FIREMODE_BURST
	burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	shoot_delay_default = GUN_FIRE_DELAY_SLOW
	burst_count_default = 3

/datum/firemode/burst/two
	name = "2-Round Burst"
	desc = "Short, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count_default = 2

/datum/firemode/burst/two/shotgun_fixed
	name = "Both barrels"
	desc = "Give them the side-by-side"
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST
	burst_count_default = 2

/datum/firemode/burst/two/slower
	name = "2-Round Burst"
	desc = "Sedate, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/two/slow
	name = "2-Round Burst"
	desc = "Calm, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/two/fast
	name = "2-Round Burst"
	desc = "Fast, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/two/faster
	name = "2-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/two/fastest
	name = "2-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/four
	name = "4-Round Burst"
	desc = "Short, controlled bursts."
	fire_type_default = GUN_FIREMODE_BURST
	burst_count_default = 4

/datum/firemode/burst/four/slower
	name = "4-Round Burst"
	desc = "Sedate, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/four/slow
	name = "4-Round Burst"
	desc = "Calm, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/four/fast
	name = "4-Round Burst"
	desc = "Fast, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/four/faster
	name = "4-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/four/fastest
	name = "4-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/four/fastest/hobo
	name = "All four barrels"
	desc = "Unleash the whole gun at once."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/three
	name = "3-Round Burst"
	desc = "Short, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count_default = 3

/datum/firemode/burst/three/slower
	name = "3-Round Burst"
	desc = "Sedate, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/three/slow
	name = "3-Round Burst"
	desc = "Calm, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/three/fast
	name = "3-Round Burst"
	desc = "Fast, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/three/faster
	name = "3-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/three/fastest
	name = "3-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/five
	name = "5-Round Burst"
	desc = "Short, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count_default = 5

/datum/firemode/burst/five/slower
	name = "5-Round Burst"
	desc = "Sedate, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/five/slow
	name = "5-Round Burst"
	desc = "Calm, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/five/fast
	name = "5-Round Burst"
	desc = "Fast, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/five/faster
	name = "5-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/five/fastest
	name = "5-Round Burst"
	desc = "Quick, controlled bursts."
	burst_delay_default = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/twenty/slower
	name = "20-Round burst"
	desc = "Long, hectic burst."
	burst_delay_default = GUN_BURSTFIRE_DELAY_SLOWER
	burst_count_default = 20



