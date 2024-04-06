/obj/item/gun_upgrade
	icon = 'modular_coyote/eris/icons/mods.dmi'
	w_class = WEIGHT_CLASS_TINY

// hi bestie
// so, we redid mods entirely (lmao)
// the non-legacy stuff is at the bottom.
// okay bestie, bye

/*
/obj/item/gun_upgrade/barrel

/obj/item/gun_upgrade/muzzle

/obj/item/gun_upgrade/underbarrel

/obj/item/gun_upgrade/underbarrel/bipod
	name = "bipod"
	desc = "A simple set of telescopic poles to keep a weapon stabilized during firing. It greatly reduces recoil when deployed, but also increases the gun's weight, making it unwieldy unless braced."
	icon_state = "bipod"

/obj/item/gun_upgrade/underbarrel/bipod/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_BIPOD = TRUE,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(90,120) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(-15,-40) * 0.01
		)
	I.gun_loc_tag = GUN_UNDERBARREL

//Silences the weapon, reduces damage multiplier slightly, Legacy port.
/obj/item/gun_upgrade/muzzle/silencer
	name = "silencer"
	desc = "A threaded silencer that can be attached to the muzzle of certain guns. Vastly reduces noise, but impedes muzzle velocity."
	icon_state = "silencer"


/obj/item/gun_upgrade/muzzle/silencer/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_SILENCER = TRUE,
		GUN_UPGRADE_MUZZLEFLASH=1 + rand(-15,-40) * 0.01,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(15,30) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(-5,-25) * 0.01
		)
	I.gun_loc_tag = GUN_MUZZLE
	I.req_gun_tags = list(GUN_SILENCABLE)

//Decreases fire delay. Acquired through loot spawns
/obj/item/gun_upgrade/barrel/forged
	name = "forged barrel"
	desc = "Despite pre-war advancements in weapon manufacture, a properly forged steel barrel is still a great addition to any gun."
	icon_state = "Forged_barrel"

/obj/item/gun_upgrade/barrel/forged/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + rand(-5,-25) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1 + rand(-5,-20) * 0.01
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

/obj/item/gun_upgrade/barrel/blender
	name = "Makeshift \"Bullet Blender\" barrel"
	desc = "A curious-looking barrel bearing a faded insignia. A small label reads \"No refunds for any collateral damage caused\"."
	icon_state = "Penetrator"

/obj/item/gun_upgrade/barrel/blender/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	//	GUN_UPGRADE_PEN_MULT = 0.2,
		GUN_UPGRADE_RICO_MULT=1 + rand(-10,-60) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(15,50) * 0.01,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(10,30) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(5,15) * 0.01
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

//For energy weapons, increases the damage output, but also the charge cost. Acquired through loot spawns or Eye of the Protector.
/obj/item/gun_upgrade/barrel/excruciator
	name = "Wattz \"GigaLens\" 3000"
	desc = "A Pre-war Wattz-brand upgrade kit, or an imitation of one. Exchanges the gun's lens frame with a hyper-focused one."
	icon_state = "Excruciator"

/obj/item/gun_upgrade/barrel/excruciator/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(17,28) * 0.01,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(25,80) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(25,60) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + rand(40,60) * 0.01, // This can stack with the Heatsink. Makes the jet-cooled one practically required.
		GUN_UPGRADE_CHARGECOST = 1 + rand(28,42) * 0.01
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_ENERGY)

/obj/item/gun_upgrade/trigger

//Disables the ability to toggle the safety, toggles the safety permanently off, decreases fire delay. Acquired through loot spawns
/obj/item/gun_upgrade/trigger/raidertrigger
	name = "Raider trigger"
	desc = "Who needs safeties anyways?"
	icon_state = "Danger_Zone"


/obj/item/gun_upgrade/trigger/raidertrigger/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-5,-25) * 0.01,
		GUN_UPGRADE_FORCESAFETY = FALSE,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(25,35) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(25,35) * 0.01
		)
	I.gun_loc_tag = GUN_TRIGGER

//Disables the ability to toggle the safety, toggles the safety permanently on, takes 2 minutes to remove (yikes). Acquired through loot spawns
/obj/item/gun_upgrade/trigger/cop_block
	name = "Secured trigger"
	desc = "A simpler way of making a weapon display-only."
	icon_state = "Cop_Block"

/obj/item/gun_upgrade/trigger/cop_block/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FORCESAFETY = TRUE
		)
	I.removal_time *= 10
	I.gun_loc_tag = GUN_TRIGGER
	I.breakable = FALSE

/obj/item/gun_upgrade/mechanism

//Adds +3 to the internal magazine of a weapon. Acquired through loot spawns.
/*/obj/item/gun_upgrade/mechanism/overshooter
	name = "Extended internal magazine kit"
	desc = "A method of overloading a weapon's internal magazine, fitting more ammunition within the weapon."
	icon_state = "Overshooter"

/obj/item/gun_upgrade/mechanism/overshooter/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_MAGUP = 3
		)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_INTERNAL_MAG)
	I.gun_loc_tag = GUN_MECHANISM*/

//Adds radiation damage to .35 rounds. Acquired through telecrystal uplink
/*/obj/item/gun_upgrade/mechanism/glass_widow
	name = "Syndicate \"Glass Widow\" infuser"
	desc = "An old technology from the Corporate Wars, this mechanism rests inside the receiver and adds trace amounts of radioactive material to each bullet fired." // wtf
	custom_materials = list(MATERIAL_STEEL = 2, MATERIAL_URANIUM = 3)
	icon_state = "Glass_Widow"
	rarity_value = 50
	spawn_blacklisted = TRUE

/obj/item/gun_upgrade/mechanism/glass_widow/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_RADIATION = 100
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_CALIBRE_35)
	I.gun_loc_tag = GUN_MECHANISM*/

//Lets the SOL be made into a fully automatic weapon, but increases recoil. Acquirable through Frozen Star Guns&Ammo Vendor
/obj/item/gun_upgrade/mechanism/weintraub
	name = "Full auto kit"
	desc = "A fully automatic receiver for rifles"
	icon_state = "Weintraub"

/obj/item/gun_upgrade/mechanism/weintraub/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FULLAUTO = TRUE,
		GUN_UPGRADE_RECOIL_1H = 2,
		GUN_UPGRADE_RECOIL_2H = 2,
	)
	//I.req_gun_tags = list(GUN_FA_MODDABLE) // teehee
	I.gun_loc_tag = GUN_MECHANISM

//Causes your weapon to shoot you in the face, then explode. Acquired through uplink
/obj/item/gun_upgrade/mechanism/reverse_loader
	name = "In-Your-Face reverse loader"
	desc = "Makes bullets loaded into the weapon fire backwards, into its user."
	icon_state = "Reverse_loader"

/obj/item/gun_upgrade/mechanism/reverse_loader/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RIGGED = TRUE
	)
	I.removal_time *= 5
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_MECHANISM

/obj/item/gun_upgrade/trigger/boom
	name = "Rigged trigger"
	desc = "A trapped trigger mechanism, wired to cause an energy gun to short-circuit when it's pulled."
	icon_state = "Boom"

/obj/item/gun_upgrade/trigger/boom/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_EXPLODE = TRUE
		)
	I.removal_time *= 10
	I.gun_loc_tag = GUN_TRIGGER
	I.req_gun_tags = list(GUN_ENERGY)

/obj/item/gun_upgrade/scope

/obj/item/gun_upgrade/scope/watchman
	name = "old scope"
	desc = "A medium range scope, with a bit of heft to it.  Amazing that it's even still dialed in."
	icon_state = "Watchman"

/obj/item/gun_upgrade/scope/watchman/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(90,110) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-5,-30) * 0.01,
		GUN_UPGRADE_ZOOM = 1.2,
		)
	I.gun_loc_tag = GUN_SCOPE
	I.req_gun_tags = list(GUN_SCOPE)

/obj/item/gun_upgrade/scope/killer
	name = "Deadeye scope"
	desc = "A scope used for sniping from large distances."
	icon_state = "Killer"

/obj/item/gun_upgrade/scope/killer/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(15,25) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-15,-40) * 0.01,
		GUN_UPGRADE_ZOOM = 2,
		)
	I.gun_loc_tag = GUN_SCOPE
	I.req_gun_tags = list(GUN_SCOPE)

/obj/item/gun_upgrade/cosmetic

/*/obj/item/gun_upgrade/cosmetic/gold
	name = "Pot of gold paint"
	desc = "A small pot of gold paint, for the kingpin in your life."
	icon_state = "gold_pot"

/obj/item/gun_upgrade/cosmetic/gold/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-20,-50) * 0.01,
		//GUN_UPGRADE_PROJ_SPEED_MULT = 1.25,
		//GUN_UPGRADE_OFFSET = 3,
		GUN_UPGRADE_RECOIL_1H=1 + rand(10,30) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(10,30) * 0.01,
		UPGRADE_COLOR = "#FFD700"
		)
	I.gun_loc_tag = GUN_PAINTABLE
	I.prefix = "gold"*/

//Trash mods, for putting on old guns

/obj/item/gun_upgrade/trigger/faulty
	name = "Faulty Trigger"
	desc = "Weirdly sticky, and none of your fingers seem to fit to it comfortably. This causes more recoil and increases delay between shots as you try to compensate for it."
	icon_state = "Cop_Block"

/obj/item/gun_upgrade/trigger/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = rand(8,30) * 0.1,
		GUN_UPGRADE_RECOIL_2H = rand(8,30) * 0.1,
		GUN_UPGRADE_FIRE_DELAY_MULT = rand(11,18) * 0.1
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_TRIGGER
	I.removable = FALSE

/obj/item/gun_upgrade/barrel/faulty
	name = "Warped Barrel"
	desc = "Extreme heat has warped this barrel off-target. This decreases the impact force of bullets fired through it and makes it more difficult to correctly aim the weapon it's attached to."
	icon_state = "Forged_barrel"

/obj/item/gun_upgrade/barrel/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_OFFSET = rand(5,15),
		GUN_UPGRADE_PEN_MULT = rand(0.8,1.2),
		GUN_UPGRADE_DAMAGE_MULT = rand(0.8,1.2),
		GUN_UPGRADE_RECOIL_1H = rand(0.8,1.2),
		GUN_UPGRADE_RECOIL_2H = rand(0.8,1.2)
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_BARREL
	I.removable = FALSE

/obj/item/gun_upgrade/muzzle/faulty
	name = "Failed Makeshift Silencer"
	desc = "Inspired by cheesy action movies, somebody has left trash on the end of this weapon. This causes the attached weapon to suffer from weaker armor penetration."
	icon_state = "silencer"

/obj/item/gun_upgrade/muzzle/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_PEN_MULT = rand(4,9)*0.1,
		GUN_UPGRADE_PROJ_SPEED_MULT = rand(8,10)*0.1,
		GUN_UPGRADE_SILENCER = TRUE,
		GUN_UPGRADE_RECOIL_1H = 1.3,
		GUN_UPGRADE_RECOIL_2H = 1.1
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_MUZZLE
	I.removable = FALSE

/obj/item/gun_upgrade/mechanism/faulty
	name = "Unknown Clockwork Mechanism"
	desc = "It's really not clear what this modification actually does. It appears to effect the attached weapon's recoil, but if it actually helps or hinders the weapon is unclear."
	icon_state = "Weintraub"

/obj/item/gun_upgrade/mechanism/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = rand(5, 20)*0.1,
		GUN_UPGRADE_RECOIL_2H = rand(5, 20)*0.1
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_MECHANISM
	I.removable = FALSE

/obj/item/gun_upgrade/scope/faulty
	name = "Misaligned sights"
	desc = "Some bad knocks have changed the angling on the sights of this weapon. This causes the attached weapon to suffer from decreased accuracy."
	icon_state = "Watchman"

/obj/item/gun_upgrade/scope/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_OFFSET = rand(1,3),
		GUN_UPGRADE_ZOOM = rand(4,8)*0.1
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_SCOPE
	I.removable = FALSE

/obj/item/gun_upgrade/trigger/better
	name = "Pre-war trigger"
	desc = "This trigger seems to be made of pre-war alloys and cut to the precision of milimeters."
	icon_state = "DNA_lock"

/obj/item/gun_upgrade/trigger/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-10,-28) * 0.01
	)
	I.gun_loc_tag = GUN_TRIGGER

/obj/item/gun_upgrade/barrel/better
	name = "High-temperature forged barrel"
	desc = "A barrel forged in high temperature, making the metal more resistant."
	icon_state = "gravbarrel"

/obj/item/gun_upgrade/barrel/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(17,31) * 0.01,
		GUN_UPGRADE_RECOIL_1H = 1 + rand(25,80) * 0.01,
		GUN_UPGRADE_RECOIL_2H = 1 + rand(25,60) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT = 1 + rand(28,42) * 0.01
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

/obj/item/gun_upgrade/muzzle/better
	name = "Pre-war muzzle"
	desc = "A pre-war muzzle, with an integrated silencer."
	icon_state = "Glass_Widow"

/obj/item/gun_upgrade/muzzle/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_SILENCER = TRUE,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(5,25) * 0.01
	)
	I.gun_loc_tag = GUN_MUZZLE
	I.req_gun_tags = list(GUN_PROJECTILE)

/obj/item/gun_upgrade/mechanism/better
	icon = 'modular_coyote/eris/icons/tool_upgrades.dmi'
	name = "Hydraulic mechanism"
	desc = "A pre-war mechanism that uses hydraulic pumps to keep recoil at a minimum."
	icon_state = "hydraulic"

/obj/item/gun_upgrade/mechanism/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(-15,-40) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(-15,-40) * 0.01
	)
	I.gun_loc_tag = GUN_MECHANISM

/obj/item/gun_upgrade/scope/better
	name = "Pre-war sniper scope"
	desc = "A high resolution scope"
	icon_state = "Killer"

/obj/item/gun_upgrade/scope/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H=1 + rand(-15,-40) * 0.01,
		GUN_UPGRADE_ZOOM = 2,
	)
	I.gun_loc_tag = GUN_SCOPE

// 	 EXPERIMENTAL WEAPON MODS
//------------------------------------------------

//Increases penetration multiplier, projectile speed. Increases fire delay. Acquired via science
/obj/item/gun_upgrade/barrel/mag_accel
	name = "Salvaged magnetic accelerator barrel"
	desc = "Uses magnetic coiling to increase the exit velocity of a metal projectile."
	icon_state = "Penetrator"

/obj/item/gun_upgrade/barrel/mag_accel/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		//GUN_UPGRADE_PEN_MULT = 1.2,
		GUN_UPGRADE_RECOIL_1H=1 + rand(140,160) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(45,55) * 0.01,
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(150,250) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(45,55) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(14,26) * 0.01
	)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

// Increased damage, but massively slows the ROF and causes recoil.
/obj/item/gun_upgrade/mechanism/battery_shunt
	name = "Poseidon Quantum Injection Electro-shunt"
	desc = "This experimental battery shunt is a cutting edge tool attachment which bypasses battery protection circuits to deliver the maximum amount of power in the shortest amount of time. You can still notice REPCONN branding on it..."
	icon_state = "battery_shunt"

/obj/item/gun_upgrade/mechanism/battery_shunt/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(125,175) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(70,120) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(40,70) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(45,65) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(45,55) * 0.01
	)
	I.req_fuel_cell = REQ_CELL
	I.gun_loc_tag = GUN_MECHANISM

// Same slot as the heatsink, better but at a cost
/obj/item/gun_upgrade/mechanism/overdrive
	name = "REPCONN overdrive chip"
	desc = "This experimental chip supercharges the weapon's rate of fire at the cost of massively increasing the weapon's kickback and slightly destabilizing the beam."
	icon_state = "overdrive"

/obj/item/gun_upgrade/mechanism/overdrive/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H=1 + rand(40,60) * 0.01,
		GUN_UPGRADE_RECOIL_2H=1 + rand(15,30) * 0.01,
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(-10,-30) * 0.01,
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-25,-60) * 0.01,
		GUN_UPGRADE_CHARGECOST=1 + rand(-56,-42) * 0.01
	)
	I.req_fuel_cell = REQ_CELL
	I.gun_loc_tag = GUN_MECHANISM
*/
// for reference

/obj/item/gun_upgrade
	icon = 'modular_coyote/eris/icons/mods.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun_upgrade/example
	name = "Example Mod"
	desc = "Uses bnuy coiling to increase the exit velocity of a metal projectile. It's kind of awful due to the bnuyness, though."
	icon_state = "Weintraub"

/obj/item/gun_upgrade/example/example/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT=1 + rand(1,10) * 0.01 					// Positives increase raw damage.
		GUN_UPGRADE_RECOIL_1H=1 + rand(-1,-10) * 0.01,					// Negatives decrease recoil.
		GUN_UPGRADE_RECOIL_2H=1 + rand(-1,-10) * 0.01, 					// Negatives decrease recoil.
		GUN_UPGRADE_FIRE_DELAY_MULT=1 + rand(-1,-10) * 0.01, 			// Negatives = less fire delay.
		GUN_UPGRADE_ZOOM = 1 											// Anything above 2x is almost unusable.
		GUN_UPGRADE_PROJ_SPEED_MULT=1 + rand(1,10) * 0.01,				// This is pretty much only good for black powder and plasma weapons, still good to have regardless.
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_MAGIC, GUN_ENERGY) 		// Basically the "class" of gun. Ballistic, Magic, and or Energy.
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
		GUN_UPGRADE_DAMAGE_MULT = 10
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/barreltwo
	name = "Magnetic Accelerator Coil"
	desc = "A heavier barrel combined with a magnetic accelerator to not only increase the stress tolerances on the barrel, but also send the bullet traveling faster using coilgun tech. The highest this can roll is 20%"
	icon_state = "penetrator"

/obj/item/gun_upgrade/barreltwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = rand(10,20)
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/barrelthree
	name = "Gauss-Polarized Magnetic Hyper-Accelerator Coil"
	desc = "A titanium-plasteel barrel combined with an uber-tuned mag accelerator to not only increase the stress tolerances on the barrel, but also send the bullet traveling faster using coilgun tech. The highest this can roll is 30%"
	icon_state = "gauss"

/obj/item/gun_upgrade/barrelthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = rand(10,30)
	)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/chipone
	name = "Reinforced Energy Pumps"
	desc = "A set of fittings and inserts to upgrade an energy gun's power pumping ability. In nerd terms, it makes plasma and lasers burn harder."
	icon_state = "hydraulic"

/obj/item/gun_upgrade/chipone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = 10
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/chiptwo
	name = "Dynamo Booster"
	desc = "A device that shunts unwanted weapon features like 'safeties' to increase power output. The highest this can roll is 20%"
	icon_state = "booster"

/obj/item/gun_upgrade/chiptwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = rand(10,20)
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/chipthree
	name = "Miniature Fusion Reactor"
	desc = "A miniature sized fusion reactor that (kind of) safely dumps extra energy into the system to increase damage. The highest this can roll is 30%"
	icon_state = "gauss"

/obj/item/gun_upgrade/chipthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_DAMAGE_MULT = rand(10,30)
	)
	I.req_gun_tags = list(GUN_ENERGY)
	I.gun_loc_tag = null

// 1H Recoil. Classless, all grips.

/obj/item/gun_upgrade/gripone
	name = "Mesh Grip"
	desc = "A thin rubber mesh grip to enhance your one handed firing ability. It's faded and sun worn."
	icon_state = "rubbermesh"

/obj/item/gun_upgrade/gripone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = -20
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY, GUN_MAGIC)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/griptwo
	name = "Styrene-Butadiene Grip"
	desc = "A thick and grippy rubber mesh to enhance your one handed firing ability. This one is pristine, and features stipling. The highest this can roll is 35%."
	icon_state = "stabilizing"

/obj/item/gun_upgrade/griptwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = (-20,-35)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY, GUN_MAGIC)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/gripthree
	name = "Gyration Stabilization Sleeve"
	desc = "A thin and SUPER grippy metamaterial mesh to enhance your one handed firing ability. Oh my god! It even has a watermark... The highest this can roll is 50%."
	icon_state = "stabilizing"

/obj/item/gun_upgrade/gripthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_1H = (-20,-50)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY, GUN_MAGIC)
	I.gun_loc_tag = null

// 2H Recoil. PROJECTILE, ENERGY gets muzzle devices, MAGIC gets higher quality focuses.

/obj/item/gun_upgrade/muzzleone
	name = "Muzzle Device"
	desc = "A muzzle device that vents gun gasses horizontally to decrease muzzle rise. In nerd terms, it reduces recoil."
	icon_state = "ported_barrel"

/obj/item/gun_upgrade/muzzleone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = -20
		GUN_UPGRADE_PROJ_SPEED_MULT = -20
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/muzzletwo
	name = "Military Muzzle Device"
	desc = "An enhanced muzzle device that vents gun gasses in all directions but down to decrease muzzle rise. In nerd terms, it significantly reduces recoil. The highest this can roll is 35%."
	icon_state = "compensatedbarrel"

/obj/item/gun_upgrade/muzzletwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = rand(-20,-35)
		GUN_UPGRADE_PROJ_SPEED_MULT = rand(-20,-35)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/muzzlethree
	name = "Research Muzzle Device"
	desc = "A powerful muzzle device that uses science-y non-sense to decrease muzzle rise. In nerd terms, it significantly reduces recoil. The highest this can roll is 50%."
	icon_state = "compensatedbarrel"

/obj/item/gun_upgrade/muzzletwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL_2H = rand(-20,-50)
		GUN_UPGRADE_PROJ_SPEED_MULT = rand(-20,-50)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null


//  Fire Delay Multiplier / ROF. PROJECTILE, ENERGY gets triggers, MAGIC gets books. 

/obj/item/gun_upgrade/triggerone
	name = "Match Trigger"
	desc = "An enhanced trigger for competition shooting. Features enhanced firerate, and lighter pulls."
	icon_state = "danger_zone"

/obj/item/gun_upgrade/triggerone/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = -15
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/triggertwo
	name = "Military Trigger"
	desc = "A military fielded enhanced trigger for easier pulls and enhanced firerate. The highest this can roll is 35%."
	icon_state = "cop_block"

/obj/item/gun_upgrade/triggertwo/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = rand(-15,-35)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null

/obj/item/gun_upgrade/triggerthree
	name = "Pristine Trigger"
	desc = "An in-development high tech product that signifcantly reduces the weight needed to pull the trigger to send a fresh slug down range. The highest this can roll is 50%."
	icon_state = "dna_lock"

/obj/item/gun_upgrade/triggerthree/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY_MULT = rand(-15,-50)
	)
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_ENERGY)
	I.gun_loc_tag = null

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
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_MAGIC, GUN_ENERGY)
	I.gun_loc_tag = null

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
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_MAGIC, GUN_ENERGY)
	I.gun_loc_tag = null

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
	I.req_gun_tags = list(GUN_PROJECTILE, GUN_MAGIC, GUN_ENERGY)
	I.gun_loc_tag = null

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
		UPGRADE_COLOR = "#007958"
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

