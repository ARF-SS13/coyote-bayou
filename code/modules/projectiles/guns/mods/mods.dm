/obj/item/gun_upgrade
	icon = 'modular_coyote/eris/icons/mods.dmi'
	w_class = WEIGHT_CLASS_TINY

// hi bestie
// so, we redid mods entirely (lmao)
// due to errors, I had to delete the legacy code - Jaeger
// PR #4792 on the CB repo did this
// okay bestie, bye

// for reference

/obj/item/gun_upgrade/example
	name = "Example Mod"
	desc = "Uses bnuy coiling to increase the exit velocity of a metal projectile. It's kind of awful due to the bnuyness, though."
	icon_state = "Weintraub"

/obj/item/gun_upgrade/example/example/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(1,10) * 0.01, 					// Positives increase raw damage.
		GUN_UPGRADE_RECOIL_1H=1 + rand(-1,-10) * 0.01,					// Negatives decrease recoil.
		GUN_UPGRADE_RECOIL_2H=1 + rand(-1,-10) * 0.01, 					// Negatives decrease recoil.
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-1,-10) * 0.01, 			// Negatives = less fire delay.
		GUN_UPGRADE_ZOOM = 1, 											// Anything above 2x is almost unusable.
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(1,10) * 0.01,				// This is pretty much only good for black powder and plasma weapons, still good to have regardless.
	)
	I.req_gun_tags = list() 		// Basically the "class" of gun. Ballistic, Magic, and or Energy.
	I.gun_loc_tag = null 												// This is in case you want a "one type of this mod" thing.

// Damage. PROJECTILE gets barrels, ENERGY gets chips, and MAGIC gets crystalized nether energy.

/obj/item/gun_upgrade/barrelone
	name = "Heavy Barrel"
	desc = "It's a heavier barrel that will increase the stress tolerances that can go into your ammo. In nerd terms it makes your bullets hit harder."
	icon_state = "forged_barrel"

/obj/item/gun_upgrade/barrelone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + 10 * 0.01
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_BARREL1

/obj/item/gun_upgrade/barreltwo
	name = "Magnetic Accelerator Coil"
	desc = "A heavier barrel combined with a magnetic accelerator to not only increase the stress tolerances on the barrel, but also send the bullet traveling faster using coilgun tech. The highest this can roll is 20%"
	icon_state = "penetrator"

/obj/item/gun_upgrade/barreltwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + rand(10,20) * 0.01
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_BARREL2

/obj/item/gun_upgrade/barrelthree
	name = "Polarized Magnetic Hyper-Accelerator"
	desc = "A titanium-plasteel barrel combined with an uber-tuned mag accelerator to not only increase the stress tolerances on the barrel, but also send the bullet traveling faster using coilgun tech. The highest this can roll is 30%"
	icon_state = "gauss"

/obj/item/gun_upgrade/barrelthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + rand(10,30) * 0.01
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_BARREL3

/obj/item/gun_upgrade/chipone
	name = "Reinforced Energy Pumps"
	desc = "A set of fittings and inserts to upgrade an energy gun's power pumping ability. In nerd terms, it makes plasma and lasers burn harder."
	icon_state = "hydraulic"

/obj/item/gun_upgrade/chipone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + 10 * 0.01
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = GUN_CHIP1

/obj/item/gun_upgrade/chiptwo
	name = "Dynamo Booster"
	desc = "A device that shunts unwanted weapon features like 'safeties' to increase power output. The highest this can roll is 20%"
	icon_state = "booster"

/obj/item/gun_upgrade/chiptwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + rand(10,20) * 0.01
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = GUN_CHIP2

/obj/item/gun_upgrade/chipthree
	name = "Miniature Fusion Reactor"
	desc = "A miniature sized fusion reactor that (kind of) safely dumps extra energy into the system to increase damage. The highest this can roll is 30%"
	icon_state = "battery_shunt"

/obj/item/gun_upgrade/chipthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 1 + rand(10,30) * 0.01
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = GUN_CHIP3

// 1H Recoil. Classless, all grips.

/obj/item/gun_upgrade/gripone
	name = "Mesh Grip"
	desc = "A thin rubber mesh grip to enhance your one handed firing ability. It's faded and sun worn."
	icon_state = "rubbermesh"

/obj/item/gun_upgrade/gripone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = 1 + -20 * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_GRIP1

/obj/item/gun_upgrade/griptwo
	name = "Styrene-Butadiene Grip"
	desc = "A thick and grippy rubber mesh to enhance your one handed firing ability. This one is pristine, and features stipling. The highest this can roll is 35%."
	icon_state = "stabilizing"

/obj/item/gun_upgrade/griptwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = 1 + rand(-20,-35) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_GRIP2

/obj/item/gun_upgrade/gripthree
	name = "Gyration Stabilization Sleeve"
	desc = "A thin and SUPER grippy metamaterial mesh to enhance your one handed firing ability. Oh my god! It even has a watermark... The highest this can roll is 50%."
	icon_state = "vibcompensator"

/obj/item/gun_upgrade/gripthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = 1 + rand(-20,-50) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_GRIP3

// 2H Recoil. PROJECTILE, ENERGY gets muzzle devices

/obj/item/gun_upgrade/muzzleone
	name = "Muzzle Device"
	desc = "A muzzle device that vents gun gasses horizontally to decrease muzzle rise. In nerd terms, it reduces recoil."
	icon_state = "ported_barrel"

/obj/item/gun_upgrade/muzzleone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = 1 + -20 * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1 + 20 * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_MUZZLE1

/obj/item/gun_upgrade/muzzletwo
	name = "Military Muzzle Device"
	desc = "An enhanced muzzle device that vents gun gasses in all directions but down to decrease muzzle rise. In nerd terms, it significantly reduces recoil. The highest this can roll is 35%."
	icon_state = "compensatedbarrel"

/obj/item/gun_upgrade/muzzletwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = 1 + rand(-20,-35) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1 + rand(20,35) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_MUZZLE2

/obj/item/gun_upgrade/muzzlethree
	name = "Research Muzzle Device"
	desc = "A powerful muzzle device that uses science-y non-sense to decrease muzzle rise. In nerd terms, it significantly reduces recoil. The highest this can roll is 50%."
	icon_state = "compensatedbarrel"

/obj/item/gun_upgrade/muzzlethree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = 1 + rand(-20,-55) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1 + rand(20,55) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_MUZZLE3


//  Fire Delay Multiplier

/obj/item/gun_upgrade/triggerone
	name = "Match Trigger"
	desc = "An enhanced trigger for competition shooting. Features enhanced firerate, and lighter pulls."
	icon_state = "danger_zone"

/obj/item/gun_upgrade/triggerone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + -15 * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_TRIGGER1

/obj/item/gun_upgrade/triggertwo
	name = "Military Trigger"
	desc = "A military fielded enhanced trigger for easier pulls and enhanced firerate. The highest this can roll is 35%."
	icon_state = "cop_block"

/obj/item/gun_upgrade/triggertwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + rand(-15,-35) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_TRIGGER2

/obj/item/gun_upgrade/triggerthree
	name = "Pristine Trigger"
	desc = "An in-development high tech product that signifcantly reduces the weight needed to pull the trigger to send a fresh slug down range. The highest this can roll is 50%."
	icon_state = "dna_lock"

/obj/item/gun_upgrade/triggerthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + rand(-15,-50) * 0.01
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_TRIGGER3

// Scope: "Classless" upgrades for zooming.

/obj/item/gun_upgrade/sightone
	name = "Reflex Sight"
	desc = "A holographic reticle projected and housed inside a weathering polymer. It works fine due to the rugged construction, but the glass is a little cracked."
	icon_state = "reflex"

/obj/item/gun_upgrade/sightone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_ZOOM = 1.1
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_SIGHT1

/obj/item/gun_upgrade/sighttwo
	name = "Old Scope"
	desc = "An old fashioned scope. Possibly pre-cataclysm, it's amazing that it's still dialed in. The max that this can roll is 2."
	icon_state = "watchman"

/obj/item/gun_upgrade/sighttwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_ZOOM = 1 + rand(0.5,1)
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_SIGHT2

/obj/item/gun_upgrade/sightthree
	name = "Pristine Scope"
	desc = "A smart scope- the height of old-world technology. It would give you a perfect zero after every shot, taking in weather conditions and the curvature of the earth to boot. Sadly, the technology that did this isn't around anymore, and it serves purely as a really good scope. The max that the zoom can roll is 3x."
	icon_state = "killer"

/obj/item/gun_upgrade/sightthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_ZOOM = 1 + rand(0,2)
	)
	I.req_gun_tags = list()
	I.gun_loc_tag = GUN_SIGHT3

// Paint: "Classless" upgrades for multiple types of traits at once. Only one at once, takes a special paint slot.

/obj/item/gun_upgrade/paint/red
	name = "red paint"
	desc = "Red paint increases the guns overall speed in its abilities, and magazine size, or makes it worse."
	icon_state = "paint_red"

/obj/item/gun_upgrade/paint/red/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-15,50) * 0.01,
		UPGRADE_COLOR = "#FF4444"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "red"

/obj/item/gun_upgrade/paint/blue
	name = "blue paint"
	desc = "Blue paint reduces recoil and increases ricochet, while also reducing charge cost of a laser gun, or makes it worse."
	icon_state = "blue_paint"

/obj/item/gun_upgrade/paint/blue/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-40,25) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-28,17) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-40,25) * 0.01,
		UPGRADE_COLOR = "#00356b"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "blue"

/obj/item/gun_upgrade/paint/yellow
	name = "yellow paint"
	desc = "Yellow paint reduces movement delay and recoil, while increasing gun damage, or makes them worse."
	icon_state = "yellow_paint"

/obj/item/gun_upgrade/paint/yellow/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_MOVE_DELAY_MULT=1 + rand(-70,-50) * 0.01,
		GUN_UPGRADE_RECOIL_1H=1 + rand(-40,25) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-20,34) * 0.01,
		UPGRADE_COLOR = "#FFFF00"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "yellow"

/obj/item/gun_upgrade/paint/orange //red + yellow
	name = "orange paint"
	desc = "Orange paint combines the effects of red and yellow for a more pronounced paint quality."
	icon_state = "orange_paint"

/obj/item/gun_upgrade/paint/orange/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_MOVE_DELAY_MULT=1 + rand(-75,-55) * 0.01,
		GUN_UPGRADE_RECOIL_1H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-14,40) * 0.01,
		UPGRADE_COLOR = "#FFA500"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "orange"

/obj/item/gun_upgrade/paint/purple //blue + red
	name = "purple paint"
	desc = " Purple paint combines the effects of red and blue for a more pronounced paint quality."
	icon_state = "violet_paint"

/obj/item/gun_upgrade/paint/purple/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		UPGRADE_COLOR = "#8F00FF"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "purple"

/obj/item/gun_upgrade/paint/green //yellow + blue
	name = "green paint"
	desc = " Green paint combines the effects of blue and yellow for a more pronounced paint quality."
	icon_state = "green_paint"

/obj/item/gun_upgrade/paint/green/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		UPGRADE_COLOR = "#00790e"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "green"

/obj/item/gun_upgrade/paint/black //green + purple + orange
	name = "black paint"
	desc = "A combination of all three main colors. This makes a paint that has a maximized chance of being perfect."
	icon_state = "black_paint"

/obj/item/gun_upgrade/paint/black/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-35,10) * 0.01,
		GUN_UPGRADE_RICO_MULT=1 + rand(-45,20) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-40,5) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(-10,55) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-10,44) * 0.01,
		UPGRADE_COLOR = "#505050"
	)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "black"

