/obj/item/gun_upgrade
	icon = 'modular_coyote/eris/icons/mods.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/gun_upgrade/barrel

/obj/item/gun_upgrade/muzzle

/obj/item/gun_upgrade/underbarrel

/obj/item/gun_upgrade/underbarrel/bipod
	name = "bipod"
	desc = "A simple set of telescopic poles to keep a weapon stabilized during firing. It greatly reduces recoil when deployed, but also increases the gun\'s weight, making it unwieldy unless braced."
	icon_state = "bipod"

/obj/item/gun_upgrade/underbarrel/bipod/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_BIPOD = TRUE,
		GUN_UPGRADE_RECOIL = 1.2
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
		GUN_UPGRADE_MUZZLEFLASH = 0.8,
		GUN_UPGRADE_DAMAGE_PLUS = -0.1,
		GUN_UPGRADE_RECOIL = 0.9
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
		GUN_UPGRADE_FIRE_DELAY_MULT = 0.8
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
		GUN_UPGRADE_PEN_MULT = 0.2,
		GUN_UPGRADE_RICO_MULT = 5,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1.4,
		GUN_UPGRADE_RECOIL = 1.4
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
		GUN_UPGRADE_DAMAGE_MULT = 1.25,
		GUN_UPGRADE_CHARGECOST = 1.4
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
		GUN_UPGRADE_FIRE_DELAY_MULT = 0.8,
		GUN_UPGRADE_FORCESAFETY = FALSE
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
		GUN_UPGRADE_RECOIL = 1.2
	)
	I.req_gun_tags = list(GUN_FA_MODDABLE)
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
		GUN_UPGRADE_RECOIL = 1.1,
		GUN_UPGRADE_ZOOM = 1.2
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
		GUN_UPGRADE_RECOIL = 1.3,
		GUN_UPGRADE_ZOOM = 2
		)
	I.gun_loc_tag = GUN_SCOPE
	I.req_gun_tags = list(GUN_SCOPE)

/obj/item/gun_upgrade/cosmetic

/obj/item/gun_upgrade/cosmetic/gold
	name = "Pot of gold paint"
	desc = "A small pot of gold paint, for the kingpin in your life."
	icon_state = "gold_pot"

/obj/item/gun_upgrade/cosmetic/gold/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_GILDED = TRUE
		)
	I.gun_loc_tag = GUN_COSMETIC
	I.req_gun_tags = list(GUN_GILDABLE)

//Trash mods, for putting on old guns

/obj/item/gun_upgrade/trigger/faulty
	name = "Faulty Trigger"
	desc = "Weirdly sticky, and none of your fingers seem to fit to it comfortably. This causes more recoil and increases delay between shots as you try to compensate for it."
	icon_state = "Cop_Block"

/obj/item/gun_upgrade/trigger/faulty/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL = rand(12,30)/10,
		GUN_UPGRADE_FIRE_DELAY_MULT = rand(11,18)/10
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
		GUN_UPGRADE_DAMAGE_MULT = rand(0.8,1.2)
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
		GUN_UPGRADE_PEN_MULT = rand(4,9)/10,
		GUN_UPGRADE_PROJ_SPEED_MULT = rand(8,10)/10,
		GUN_UPGRADE_SILENCER = TRUE
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
		GUN_UPGRADE_RECOIL = rand(5, 20)/10
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
		GUN_UPGRADE_ZOOM = rand(4,8)/10
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_SCOPE
	I.removable = FALSE

/obj/item/gun_upgrade/trigger/better
	name = "Pre-war trigger"
	desc = "This trigger seems to be made of pre-war alloys and cut to the precision of milimeters."

/obj/item/gun_upgrade/trigger/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY = 0.7
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_TRIGGER

/obj/item/gun_upgrade/barrel/better
	name = "High-temperature forged barrel"
	desc = "A barrel forged in high temperature, making the metal more resistant."

/obj/item/gun_upgrade/barrel/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_FIRE_DELAY = 0.7
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_BARREL

/obj/item/gun_upgrade/muzzle/better
	name = "Pre-war muzzle"
	desc = "A pre-war muzzle, with an integrated silencer."

/obj/item/gun_upgrade/muzzle/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_SILENCER = TRUE,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1.1
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_MUZZLE
	I.req_gun_tags = list(GUN_PROJECTILE)

/obj/item/gun_upgrade/mechanism/better
	name = "Hydraulic mechanism"
	desc = "A pre-war mechanism that uses hydraulic pumps to keep recoil at a minimum."

/obj/item/gun_upgrade/mechanism/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_RECOIL = 0.8,
	)
	I.destroy_on_removal = TRUE
	I.gun_loc_tag = GUN_MECHANISM

/obj/item/gun_upgrade/scope/better
	name = "Pre-war sniper scope"
	desc = "A high resolution scope"

/obj/item/gun_upgrade/scope/better/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_ZOOM = 2,
	)
	I.destroy_on_removal = TRUE
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
		GUN_UPGRADE_PEN_MULT = 1.2,
		GUN_UPGRADE_PROJ_SPEED_MULT = 1.2,
		GUN_UPGRADE_FIRE_DELAY_MULT = 1.5
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

/*
//Adds +10 burn damage to a bullet, lowers armor penetration, adds a constant projectile offset, increases recoil and fire delay. Acquired via science
/obj/item/gun_upgrade/barrel/overheat
	name = "Moebius \"Caster\" magnetic overheat barrel"
	desc = "Uses magnetic induction to heat the projectile of a weapon. Arguable combat effectiveness, but flashy nonetheless."
	icon_state = "Caster"
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_PLASTEEL = 1, MATERIAL_GOLD = 1)
	rarity_value = 30
	spawn_blacklisted = TRUE

/obj/item/gun_upgrade/barrel/overheat/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_PEN_MULT = 0.8,
		GUN_UPGRADE_DAMAGE_BURN = 10,
		GUN_UPGRADE_OFFSET = 5,
		GUN_UPGRADE_RECOIL = 1.5,
		GUN_UPGRADE_FIRE_DELAY_MULT = 1.2
		)
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)
*/

// Double damage at the cost of more recoil and a tripled energy consumption
/obj/item/gun_upgrade/mechanism/battery_shunt
	name = "Poseidon Quantum Injection Electro-shunt"
	desc = "This experimental battery shunt is a cutting edge tool attachment which bypasses battery protection circuits to deliver the maximum amount of power in the shortest amount of time. You can still notice REPCONN branding on it..."
	icon_state = "battery_shunt"

/obj/item/gun_upgrade/mechanism/battery_shunt/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	GUN_UPGRADE_RECOIL = 1.2,
	GUN_UPGRADE_DAMAGE_MULT = 1.30,
	GUN_UPGRADE_CHARGECOST = 1.5)
	I.req_fuel_cell = REQ_CELL
	I.gun_loc_tag = GUN_MECHANISM

// Massively lowers cell charge usage at the cost of lower damage
/obj/item/gun_upgrade/mechanism/overdrive
	name = "REPCONN overdrive chip"
	desc = "This experimental chip is a cutting edge tool attachment which bypasses power management protocols to dramatically increase battery cell potential at the cost of lowering the power output of a weapon tremendously."
	icon_state = "overdrive"

/obj/item/gun_upgrade/mechanism/overdrive/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	GUN_UPGRADE_RECOIL = 0.9, // lowering the power output of the weapon should realistically lower the recoil - risingstarslash
	GUN_UPGRADE_DAMAGE_MULT = 0.5,
	GUN_UPGRADE_CHARGECOST = 0.65)
	//GUN_UPGRADE_FULLAUTO = TRUE)
	I.req_fuel_cell = REQ_CELL
	I.gun_loc_tag = GUN_MECHANISM

/*
// Add toxin damage to your weapon
/obj/item/gun_upgrade/barrel/toxin_coater
	name = "Moebius \"Black Mamba\" toxin coater"
	desc = "This experimental barrel coats bullets with a thin layer of toxins just before they leave the weapon. Do not lick it."
	icon_state = "toxin_coater"
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_PLASTEEL = 1, MATERIAL_GOLD = 2)
	spawn_blacklisted = TRUE

/obj/item/gun_upgrade/barrel/toxin_coater/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	GUN_UPGRADE_DAMAGE_TOX = 5)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_BARREL

// Add radiation damage to your weapon
/obj/item/gun_upgrade/barrel/isotope_diffuser
	name = "Moebius \"Atomik\" isotope diffuser"
	desc = "This experimental barrel constantly sprays a thin mist of radioactive isotopes to make projectiles leaving the weapons deadlier. Do not put it in your mouth."
	icon_state = "isotope_diffuser"
	matter = list(MATERIAL_PLASTIC = 2, MATERIAL_PLASTEEL = 1, MATERIAL_URANIUM = 2)
	spawn_blacklisted = TRUE

/obj/item/gun_upgrade/barrel/isotope_diffuser/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	GUN_UPGRADE_DAMAGE_RADIATION = 30)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_BARREL

// Add psy damage to your weapon
/obj/item/gun_upgrade/mechanism/psionic_catalyst
	name = "Moebius \"Mastermind\" psionic catalyst"
	desc = "This controversial device greatly amplifies the natural psionic ability of the user and allows them to project their will into the world. Before the development of the Psi Amp, psionic disciplines were mostly detectable only in a lab environment."
	icon_state = "psionic_catalyst"
	matter = list(MATERIAL_SILVER = 3, MATERIAL_PLASTEEL = 3, MATERIAL_URANIUM = 3)
	spawn_blacklisted = TRUE

/obj/item/gun_upgrade/mechanism/psionic_catalyst/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
	GUN_UPGRADE_DAMAGE_PSY = 0.4)
	I.req_gun_tags = list(GUN_PROJECTILE)
	I.gun_loc_tag = GUN_MECHANISM
*/

/obj/item/gun_upgrade/barrel/gauss
	name = "Chinese Anti-Material Gauss barrel"
	desc = "A portable, attachable version of a large caliber gauss rifle. Made in China."
	icon_state = "Gauss"

/obj/item/gun_upgrade/barrel/gauss/New()
	..()
	var/datum/component/item_upgrade/I = AddComponent(/datum/component/item_upgrade)
	I.weapon_upgrades = list(
		GUN_UPGRADE_PROJ_SPEED_MULT = 1.2,
		GUN_UPGRADE_PEN_MULT = 1.3,
		GUN_UPGRADE_FIRE_DELAY_MULT = 1.4,
		GUN_UPGRADE_RECOIL = 1.4
		)
	I.removal_time *= 10
	I.gun_loc_tag = GUN_BARREL
	I.req_gun_tags = list(GUN_PROJECTILE)

