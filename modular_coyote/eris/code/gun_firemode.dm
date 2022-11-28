/*
	Defines a firing mode for a gun.

	A firemode is created from a list of fire mode settings. Each setting modifies the value of the gun var with the same name.
	If the fire mode value for a setting is null, it will be replaced with the initial value of that gun's variable when the firemode is created.
	Obviously not compatible with variables that take a null value. If a setting is not present, then the corresponding var will not be modified.
*/
/datum/firemode
	var/name = "default"
	var/desc = "The default firemode"
	var/icon_state
	var/list/settings = list()
	/// is the gun semi, burst, or fullauto?
	var/fire_type = GUN_FIREMODE_SEMIAUTO
	var/firerate_semi = GUN_FIRE_DELAY_NORMAL
	var/firerate_burst = GUN_AUTOFIRE_DELAY_NORMAL
	var/firerate_auto = GUN_BURSTFIRE_DELAY_NORMAL
	var/burst_count = 1
	var/obj/item/gun/gun = null

/datum/firemode/New(obj/item/gun/_gun, list/properties = null)
	..()
	gun = _gun
	
	if(!properties || !properties.len) 
		return

	for(var/propname in properties)
		var/propvalue = properties[propname]
		if(propname == "mode_name")
			name = propvalue
		else if(propname == "mode_desc")
			desc = propvalue
		else if(propname == "icon")
			icon_state = properties["icon"]
		else if(isnull(propvalue))
			settings[propname] = gun.vars[propname] //better than initial() as it handles list vars like dispersion
		else
			settings[propname] = propvalue

/datum/firemode/Destroy()
	gun = null
	return ..()

/datum/firemode/proc/apply_firemode()

	for(var/propname in settings)
		if(propname in gun.vars)
			gun.vars[propname] = settings[propname]
			// Apply gunmods effects that have been erased by the previous line
		else if(propname == "damage_mult_add")
			gun.damage_multiplier += settings[propname]

	gun.automatic = (fire_type == GUN_FIREMODE_AUTO)
	gun.burst_size = burst_count
	gun.fire_delay = firerate_semi
	gun.autofire_shot_delay = firerate_auto
	gun.burst_shot_delay = firerate_burst

	for(var/obj/I in gun.item_upgrades)
		var/datum/component/item_upgrade/IU = I.GetComponent(/datum/component/item_upgrade)
		if(IU.weapon_upgrades[GUN_UPGRADE_CHARGECOST])
			gun.vars["charge_cost"] *= IU.weapon_upgrades[GUN_UPGRADE_CHARGECOST]
		if(IU.weapon_upgrades[GUN_UPGRADE_FIRE_DELAY_MULT])
			gun.fire_delay *= IU.weapon_upgrades[GUN_UPGRADE_FIRE_DELAY_MULT]
			gun.fire_delay = round(gun.fire_delay, 0.1)
			gun.autofire_shot_delay *= IU.weapon_upgrades[GUN_UPGRADE_FIRE_DELAY_MULT]
			gun.autofire_shot_delay = round(gun.autofire_shot_delay, 0.1)
			gun.burst_shot_delay *= IU.weapon_upgrades[GUN_UPGRADE_FIRE_DELAY_MULT]
			gun.burst_shot_delay = round(gun.burst_shot_delay, 0.1)

//Called whenever the firemode is switched to, or the gun is picked up while its active
/datum/firemode/proc/update()
	return

/datum/firemode/semi_auto
	name = "Semi Automatic"
	desc = "Shoot one shot per trigger pull."
	icon_state = "semi"
	fire_type = GUN_FIREMODE_SEMIAUTO
	firerate_semi = GUN_FIRE_DELAY_NORMAL
	firerate_burst = GUN_AUTOFIRE_DELAY_NORMAL
	firerate_auto = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count = 1

/datum/firemode/semi_auto/shotgun_fixed
	name = "One at a time"
	desc = "Send vagabonds flying back several paces"

/datum/firemode/semi_auto/fastest
	firerate_semi = GUN_FIRE_DELAY_FASTEST

/datum/firemode/semi_auto/faster
	firerate_semi = GUN_FIRE_DELAY_FASTER

/datum/firemode/semi_auto/fast
	firerate_semi = GUN_FIRE_DELAY_FAST

/datum/firemode/semi_auto/slow
	firerate_semi = GUN_FIRE_DELAY_SLOW

/datum/firemode/semi_auto/slower
	firerate_semi = GUN_FIRE_DELAY_SLOWER

/datum/firemode/automatic
	name = "Fully Automatic"
	desc = "Spray and pray."
	icon_state = "auto"
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_1200

/datum/firemode/automatic/rpm1200
	name = "Fully Automatic"
	desc = "Automatic - 1200 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_1200

/datum/firemode/automatic/rpm1000
	name = "Fully Automatic"
	desc = "Automatic - 1000 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_1000

/datum/firemode/automatic/rpm800
	name = "Fully Automatic"
	desc = "Automatic - 800 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_800

/datum/firemode/automatic/rpm600
	name = "Fully Automatic"
	desc = "Automatic - 600 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_600

/datum/firemode/automatic/rpm400
	name = "Fully Automatic"
	desc = "Automatic - 400 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_400

/datum/firemode/automatic/rpm300
	name = "Fully Automatic"
	desc = "Automatic - 300 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_300

/datum/firemode/automatic/rpm200
	name = "Fully Automatic"
	desc = "Automatic - 200 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_200

/datum/firemode/automatic/rpm150
	name = "Fully Automatic"
	desc = "Automatic - 150 RPM."
	fire_type = GUN_FIREMODE_AUTO
	firerate_auto = GUN_FIRE_RATE_200

/datum/firemode/burst
	name = "Burstfire"
	desc = "Shoot multiple shots per triggerpull."
	icon_state = "burst"
	fire_type = GUN_FIREMODE_BURST
	firerate_semi = GUN_FIRE_DELAY_SLOW
	firerate_burst = GUN_FIRE_RATE_1200
	burst_count = 3

/datum/firemode/burst/two
	name = "2-Round Burst"
	desc = "Short, controlled bursts."
	fire_type = GUN_FIREMODE_BURST
	firerate_burst = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count = 2

/datum/firemode/burst/two/shotgun_fixed
	name = "Both barrels"
	desc = "Give them the side-by-side"
	fire_type = GUN_FIREMODE_BURST
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST
	burst_count = 2

/datum/firemode/burst/two/slower
	name = "2-Round Burst"
	desc = "Sedate, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/two/slow
	name = "2-Round Burst"
	desc = "Calm, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/two/fast
	name = "2-Round Burst"
	desc = "Fast, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/two/faster
	name = "2-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/two/fastest
	name = "2-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/four
	name = "4-Round Burst"
	desc = "Short, controlled bursts."
	fire_type = GUN_FIREMODE_BURST
	firerate_burst = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count = 4

/datum/firemode/burst/four/slower
	name = "4-Round Burst"
	desc = "Sedate, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/four/slow
	name = "4-Round Burst"
	desc = "Calm, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/four/fast
	name = "4-Round Burst"
	desc = "Fast, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/four/faster
	name = "4-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/four/fastest
	name = "4-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/four/fastest/hobo
	name = "All four barrels"
	desc = "Unleash the whole gun at once."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/three
	name = "3-Round Burst"
	desc = "Short, controlled bursts."
	fire_type = GUN_FIREMODE_BURST
	firerate_burst = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count = 3

/datum/firemode/burst/three/slower
	name = "3-Round Burst"
	desc = "Sedate, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/three/slow
	name = "3-Round Burst"
	desc = "Calm, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/three/fast
	name = "3-Round Burst"
	desc = "Fast, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/three/faster
	name = "3-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/three/fastest
	name = "3-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST

/datum/firemode/burst/five
	name = "5-Round Burst"
	desc = "Short, controlled bursts."
	fire_type = GUN_FIREMODE_BURST
	firerate_burst = GUN_BURSTFIRE_DELAY_NORMAL
	burst_count = 5

/datum/firemode/burst/five/slower
	name = "5-Round Burst"
	desc = "Sedate, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOWER

/datum/firemode/burst/five/slow
	name = "5-Round Burst"
	desc = "Calm, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_SLOW

/datum/firemode/burst/five/fast
	name = "5-Round Burst"
	desc = "Fast, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FAST

/datum/firemode/burst/five/faster
	name = "5-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTER

/datum/firemode/burst/five/fastest
	name = "5-Round Burst"
	desc = "Quick, controlled bursts."
	firerate_burst = GUN_BURSTFIRE_DELAY_FASTEST








