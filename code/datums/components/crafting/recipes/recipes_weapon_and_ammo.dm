/datum/crafting_recipe/pin_removal
	name = "Pin Removal"
	result = /obj/item/gun
	reqs = list(/obj/item/gun = 1)
	parts = list(/obj/item/gun = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_OTHER

/datum/crafting_recipe/pin_removal/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/G = collected_requirements[/obj/item/gun][1]
	if (G.no_pin_required || !G.pin)
		return FALSE
	return TRUE

/*
/datum/crafting_recipe/strobeshield
	name = "Strobe Shield"
	result = /obj/item/assembly/flash/shield
	reqs = list(/obj/item/wallframe/flasher = 1,
				/obj/item/assembly/flash/handheld = 1,
				/obj/item/shield/riot = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/strobeshield/New()
	..()
	blacklist |= subtypesof(/obj/item/shield/riot/)
*/

/datum/crafting_recipe/makeshiftshield
	name = "Makeshift Metal Shield"
	result = /obj/item/shield/makeshift
	reqs = list(/obj/item/stack/cable_coil = 30,
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 3)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/spear
	name = "Spear"
	result = /obj/item/spear
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/shard = 1,
				/obj/item/stack/rods = 1)
	parts = list(/obj/item/shard = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/stunprod
	name = "Stunprod"
	result = /obj/item/melee/baton/cattleprod
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/rods = 1,
				/obj/item/assembly/igniter = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/teleprod
	name = "Teleprod"
	result = /obj/item/melee/baton/cattleprod/teleprod
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/rods = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/ore/bluespace_crystal = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
*/

/datum/crafting_recipe/bola
	name = "Bola"
	result = /obj/item/restraints/legcuffs/bola
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/sheet/metal = 6)
	time = 20//15 faster than crafting them by hand!
	category= CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/tailclub
	name = "Tail Club"
	result = /obj/item/tailclub
	reqs = list(/obj/item/organ/tail/lizard = 1,
	            /obj/item/stack/sheet/metal = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/tailwhip
	name = "Liz O' Nine Tails"
	result = /obj/item/melee/chainofcommand/tailwhip
	reqs = list(/obj/item/organ/tail/lizard = 1,
				/obj/item/stack/cable_coil = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/catwhip
	name = "Cat O' Nine Tails"
	result = /obj/item/melee/chainofcommand/tailwhip/kitty
	reqs = list(/obj/item/organ/tail/cat = 1,
				/obj/item/stack/cable_coil = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/chainsaw
	name = "Chainsaw"
	result = /obj/item/chainsaw
	reqs = list(/obj/item/circular_saw = 1,
				/obj/item/stack/cable_coil = 3,
				/obj/item/stack/sheet/plasteel = 5)
	tools = list(TOOL_WELDER)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//////////////////
///BOMB CRAFTING//
//////////////////

/datum/crafting_recipe/chemical_payload
	name = "Chemical Payload (C4)"
	result = /obj/item/bombcore/chemical
	reqs = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/grenade/plastic/c4 = 1,
		/obj/item/grenade/chem_grenade = 2
	)
	parts = list(/obj/item/stock_parts/matter_bin = 1, /obj/item/grenade/chem_grenade = 2)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_OTHER

/*
/datum/crafting_recipe/chemical_payload2
	name = "Chemical Payload (Gibtonite)"
	result = /obj/item/bombcore/chemical
	reqs = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/gibtonite = 1,
		/obj/item/grenade/chem_grenade = 2
	)
	parts = list(/obj/item/stock_parts/matter_bin = 1, /obj/item/grenade/chem_grenade = 2)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_OTHER
*/

/datum/crafting_recipe/molotov
	name = "Molotov"
	result = /obj/item/reagent_containers/food/drinks/bottle/molotov
	reqs = list(/obj/item/reagent_containers/rag = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/IED
	name = "IED"
	result = /obj/item/grenade/iedcasing
	reqs = list(/datum/reagent/fuel = 50,
				/obj/item/stack/cable_coil = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/reagent_containers/food/drinks/soda_cans = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/soda_cans = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_OTHER

/datum/crafting_recipe/lance
	name = "Explosive Lance (Grenade)"
	result = /obj/item/spear
	reqs = list(/obj/item/spear = 1,
				/obj/item/grenade = 1)
	parts = list(/obj/item/spear = 1,
				/obj/item/grenade = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//////////////////
///GUNS CRAFTING//
//////////////////

/*
/datum/crafting_recipe/pipebow
	name = "Pipe Bow"
	result =  /obj/item/gun/ballistic/bow/pipe
	reqs = list(/obj/item/pipe = 5,
	/obj/item/stack/sheet/plastic = 15,
	/obj/item/weaponcrafting/string = 5)
	time = 150
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/smartdartgun
	name = "Smart dartgun"
	result =  /obj/item/gun/syringe/dart
	reqs = list(/obj/item/stack/sheet/metal = 10,
	/obj/item/stack/sheet/glass = 5,
	/obj/item/tank/internals = 1,
	/obj/item/reagent_containers/glass/beaker = 1,
	/obj/item/stack/sheet/plastic = 5,
	/obj/item/stack/cable_coil = 1)
	time = 150 //It's a gun
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/rapiddartgun
	name = "Rapid Smart dartgun"
	result = /obj/item/gun/syringe/dart/rapiddart
	reqs = list(
		/obj/item/gun/syringe/dart = 1,
		/obj/item/stack/sheet/plastic = 5,
		/obj/item/stack/cable_coil = 1,
		/obj/item/reagent_containers/glass/beaker = 1
	)
	parts = list(/obj/item/reagent_containers/glass/beaker = 1)
	time = 120 //Modifying your gun
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/improvised_pneumatic_cannon
	name = "Pneumatic Cannon"
	result = /obj/item/pneumatic_cannon/ghetto
	tools = list(TOOL_WELDER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/packageWrap = 8,
				/obj/item/pipe = 2)
	time = 300
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/flamethrower //Gun*
	name = "Flamethrower"
	result = /obj/item/flamethrower
	reqs = list(/obj/item/weldingtool = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/stack/rods = 1)
	parts = list(/obj/item/assembly/igniter = 1,
				/obj/item/weldingtool = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/ishotgun // smaller and more versatile gun requires some better materials
	name = "Improvised Shotgun"
	result = /obj/item/gun/ballistic/revolver/doublebarrel/improvised
	reqs = list(/obj/item/pipe = 2, // putting a large amount of meaningless timegates by forcing people to turn base resources into upgraded resources kinda sucks
				/obj/item/weaponcrafting/improvised_parts/shotgun_receiver = 1,
				/obj/item/weaponcrafting/improvised_parts/trigger_assembly = 1,
				/obj/item/weaponcrafting/improvised_parts/wooden_body = 1,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/stack/packageWrap = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/irifle // larger and less versatile gun, but a bit easier to make
	name = "Improvised Rifle (7.62mm)"
	result = /obj/item/gun/ballistic/shotgun/boltaction/improvised
	reqs = list(/obj/item/pipe = 2, // above
				/obj/item/weaponcrafting/improvised_parts/rifle_receiver = 1,
				/obj/item/weaponcrafting/improvised_parts/trigger_assembly = 1,
				/obj/item/weaponcrafting/improvised_parts/wooden_body = 1,
				/obj/item/weaponcrafting/stock = 1,
				/obj/item/stack/packageWrap = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 100
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/

/datum/crafting_recipe/AEP7
	name = "AEP7"
	result = /obj/item/gun/energy/laser/pistol
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/lenses = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/AEP7)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//lever action

/datum/crafting_recipe/lever_action
	name = "Lever Action shotgun"
	result = /obj/item/gun/ballistic/shotgun/trench
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/lever_action)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//trail carbine
/*
/datum/crafting_recipe/trail_carbine
	name = "Trail Carbine"
	result = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/lever_action)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON
*/
//mid tier
//.223 pistol
/*/datum/crafting_recipe/thatgun
	name = ".223 pistol"
	result = /obj/item/gun/ballistic/revolver/thatgun
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 15,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/thatgun)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/thatgun_lim
	name = ".223 pistol"
	result = /obj/item/gun/ballistic/revolver/thatgun
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 15,
				/obj/item/stack/sheet/metal = 3,
				/obj/item/blueprint/weapon/thatgun/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//pps
/*
/datum/crafting_recipe/pps
	name = "Ancient SMG"
	result = /obj/item/gun/ballistic/automatic/pps
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 30
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/pps)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/pps_lim
	name = "Ancient SMG"
	result = /obj/item/gun/ballistic/automatic/pps
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 30,
				/obj/item/blueprint/weapon/pps/limited = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE*/
//mg34

/*
/datum/crafting_recipe/mg34
	name = "Maschinengewehr 34"
	result = /obj/item/gun/ballistic/automatic/mg34
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 60
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/mg34)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/mg34_lim
	name = "Maschinengewehr 34"
	result = /obj/item/gun/ballistic/automatic/mg34
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 60, 
				/obj/item/blueprint/weapon/mg34/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

//kar98

/datum/crafting_recipe/kar98
	name = "Karabiner 98k"
	result = /obj/item/gun/ballistic/shotgun/ww2rifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 10
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/kar98)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/kar98_lim
	name = "Karabiner 98k"
	result = /obj/item/gun/ballistic/shotgun/ww2rifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 10, 
				/obj/item/blueprint/weapon/kar98/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//plasma pistol

/datum/crafting_recipe/PlasmaPistol
	name = "Plasma Pistol"
	result = /obj/item/gun/energy/laser/plasma/pistol
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/plasmapistol)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/PlasmaPistol_lim
	name = "Plasma Pistol"
	result = /obj/item/gun/energy/laser/plasma/pistol
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/blueprint/weapon/plasmapistol/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//uzi
/*
/datum/crafting_recipe/uzi
	name = "Mini uzi"
	result = /obj/item/gun/ballistic/automatic/mini_uzi
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/uzi)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/uzi_lim
	name = "Mini uzi"
	result = /obj/item/gun/ballistic/automatic/mini_uzi
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/blueprint/weapon/uzi/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//10mm smg
/*
/datum/crafting_recipe/smg10mm
	name = "10mm SMG"
	result = /obj/item/gun/ballistic/automatic/smg10mm
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/smg10mm)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/smg10mm_lim
	name = "10mm SMG"
	result = /obj/item/gun/ballistic/automatic/smg10mm
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30, 
				/obj/item/blueprint/weapon/smg10mm/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//grease gun
/*
/datum/crafting_recipe/grease_gun
	name = "Grease gun"
	result = /obj/item/gun/ballistic/automatic/greasegun
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30, 
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/grease_gun)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/grease_gun_lim
	name = "Grease gun"
	result = /obj/item/gun/ballistic/automatic/greasegun
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30, 
				/obj/item/blueprint/weapon/grease_gun/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//marksman rifle

/datum/crafting_recipe/marksmanrifle
	name = "Marksman rifle"
	result = /obj/item/gun/ballistic/automatic/marksman
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/marksmanrifle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/marksmanrifle_lim
	name = "Marksman rifle"
	result = /obj/item/gun/ballistic/automatic/marksman
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/blueprint/weapon/marksmanrifle/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//brush gun

/datum/crafting_recipe/brush
	name = "Brush gun"
	result = /obj/item/gun/ballistic/shotgun/automatic/hunting/brush
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/brush)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/brush_lim
	name = "Brush gun"
	result = /obj/item/gun/ballistic/shotgun/automatic/hunting/brush
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/blueprint/weapon/brush/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//high tier

//r91
/*
/datum/crafting_recipe/r91
	name = "R91 assault rifle"
	result = /obj/item/gun/ballistic/automatic/assault_rifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/R91)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/r91_lim
	name = "R91 assault rifle"
	result = /obj/item/gun/ballistic/automatic/assault_rifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/blueprint/weapon/R91/limited = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//lmg

/datum/crafting_recipe/lmg
	name = "R84 LMG"
	result = /obj/item/gun/ballistic/automatic/lmg
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/lmg)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/lmg_lim
	name = "R84 LMG"
	result = /obj/item/gun/ballistic/automatic/lmg
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/blueprint/weapon/lmg/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//breacher

/datum/crafting_recipe/breacher
	name = "Breacher shotgun"
	result = /obj/item/gun/ballistic/automatic/shotgun/riot
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/breacher)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/breacher_lim
	name = "Breacher shotgun"
	result = /obj/item/gun/ballistic/automatic/shotgun/riot
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/blueprint/weapon/breacher/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//sniper

/datum/crafting_recipe/sniper
	name = "Sniper rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/sniper
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/sniper)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/sniper_lim
	name = "Sniper rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/sniper
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5, 
				/obj/item/blueprint/weapon/sniper/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//r82

/datum/crafting_recipe/R82
	name = "R82 heavy service rifle"
	result = /obj/item/gun/ballistic/automatic/service/r82
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/R82)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/R82_lim
	name = "R82 heavy service rifle"
	result = /obj/item/gun/ballistic/automatic/service/r82
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5,
				 /obj/item/blueprint/weapon/R82/limited = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
//desert eagle

/datum/crafting_recipe/deagle
	name = "Desert Eagle"
	result = /obj/item/gun/ballistic/automatic/pistol/deagle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/deagle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/deagle_lim
	name = "Desert Eagle"
	result = /obj/item/gun/ballistic/automatic/pistol/deagle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5, 
				/obj/item/blueprint/weapon/deagle/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON


//very high tier
//bozar
/datum/crafting_recipe/bozar
	name = "Bozar"
	result = /obj/item/gun/ballistic/automatic/bozar
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/R91, /obj/item/blueprint/weapon/marksmanrifle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
//aer9
/datum/crafting_recipe/AER9
	name = "AER9"
	result = /obj/item/gun/energy/laser/aer9
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/lenses = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/AER9)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/AER9_lim
	name = "AER9"
	result = /obj/item/gun/energy/laser/aer9
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/lenses = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/stack/crafting/electronicparts = 3, 
				/obj/item/blueprint/weapon/AER9/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
//plasma rifle
/datum/crafting_recipe/PlasmaRifle
	name = "Plasma Rifle"
	result = /obj/item/gun/energy/laser/plasma
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/advanced_crafting_components/conductors = 2,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/plasmarifle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/PlasmaRifle_lim
	name = "Plasma Rifle"
	result = /obj/item/gun/energy/laser/plasma
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/advanced_crafting_components/conductors = 2,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3, 
				/obj/item/blueprint/weapon/plasmarifle/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//tribeam

/datum/crafting_recipe/tribeam
	name = "Tribeam Laser Rifle"
	result = /obj/item/gun/energy/laser/scatter
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/conductors = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/lenses = 1,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/AER9, /obj/item/blueprint/weapon/AEP7)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
//AM rifle
/datum/crafting_recipe/AM_rifle
	name = "AM Rifle"
	result = /obj/item/gun/ballistic/shotgun/antimateriel
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/AM_rifle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/AM_rifle_lim
	name = "AM Rifle"
	result = /obj/item/gun/ballistic/shotgun/antimateriel
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5, 
				/obj/item/blueprint/weapon/AM_rifle/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//city killer

/datum/crafting_recipe/city_killer
	name = "City-Killer shotgun"
	result = /obj/item/gun/ballistic/shotgun/automatic/combat
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/city_killer)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/city_killer_lim

	name = "City-Killer shotgun"
	result = /obj/item/gun/ballistic/shotgun/automatic/combat
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/blueprint/weapon/city_killer/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//rangemaster
/*
/datum/crafting_recipe/rangemaster
	name = "Colt Rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/rangemaster)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/rangemaster_lim
	name = "Colt Rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5, 
				/obj/item/blueprint/weapon/rangemaster/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
*/
//bozar
/datum/crafting_recipe/bozar
	name = "Bozar"
	result = /obj/item/gun/ballistic/automatic/bozar
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5, 
				
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/bozar)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/bozar_lim
	name = "Bozar"
	result = /obj/item/gun/ballistic/automatic/bozar
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5, 
				/obj/item/blueprint/weapon/bozar/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//BP copy
/datum/crafting_recipe/bpcopy	
	result = /obj/item/blueprint/weapon/marksmanrifle/limited
	name = "Marksman Rifle blueprint"
	reqs = list(/obj/item/paper = 1)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/marksmanrifle)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/bpcopy/plasmapistol
	result = /obj/item/blueprint/weapon/plasmapistol/limited
	name = "Plasma Pistol blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/plasmapistol)

/datum/crafting_recipe/bpcopy/uzi
	result = /obj/item/blueprint/weapon/uzi/limited
	name = "UZI blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/uzi)
	
/datum/crafting_recipe/bpcopy/smg10mm
	result = /obj/item/blueprint/weapon/smg10mm/limited
	name = "10mm SMG blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/smg10mm)

/datum/crafting_recipe/bpcopy/brush
	result = /obj/item/blueprint/weapon/brush/limited
	name = "Brush Gun blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/brush)

/datum/crafting_recipe/bpcopy/grease_gun
	result = /obj/item/blueprint/weapon/grease_gun/limited
	name = "Grease Gun blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/grease_gun)

/datum/crafting_recipe/bpcopy/R91
	result = /obj/item/blueprint/weapon/R91/limited
	name = "R91 Assault rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/R91)

/datum/crafting_recipe/bpcopy/sniper
	result = /obj/item/blueprint/weapon/sniper/limited
	name = "Sniper Rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/sniper)

/datum/crafting_recipe/bpcopy/breacher
	result = /obj/item/blueprint/weapon/breacher/limited
	name = "Breacher Shotgun blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/breacher)

/datum/crafting_recipe/bpcopy/lmg
	result = /obj/item/blueprint/weapon/lmg/limited
	name = "LMG blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/lmg)

/datum/crafting_recipe/bpcopy/R82
	result = /obj/item/blueprint/weapon/R82/limited
	name = "R82 heavy service rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/R82)

/datum/crafting_recipe/bpcopy/deagle
	result = /obj/item/blueprint/weapon/deagle/limited
	name = "Desert Eagle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/deagle)

/datum/crafting_recipe/bpcopy/plasmarifle
	result = /obj/item/blueprint/weapon/plasmarifle/limited
	name = "Plasma Rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/plasmarifle)

/datum/crafting_recipe/bpcopy/AER9
	result = /obj/item/blueprint/weapon/AER9/limited
	name = "AER9 blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/AER9)

/datum/crafting_recipe/bpcopy/AM_rifle
	result = /obj/item/blueprint/weapon/AM_rifle/limited
	name = "AM Rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/AM_rifle)

/datum/crafting_recipe/bpcopy/city_killer
	result = /obj/item/blueprint/weapon/city_killer/limited
	name = "City Killer shotgun blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/city_killer)

/datum/crafting_recipe/bpcopy/rangemaster
	result = /obj/item/blueprint/weapon/rangemaster/limited
	name = "Colt Rangemaster blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/rangemaster)

/datum/crafting_recipe/bpcopy/bozar
	result = /obj/item/blueprint/weapon/bozar/limited
	name = "Bozar blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/bozar)

/datum/crafting_recipe/bpcopy/pps
	result = /obj/item/blueprint/weapon/pps/limited
	name = "PPSh-41 blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/pps)

/datum/crafting_recipe/bpcopy/mg34
	result = /obj/item/blueprint/weapon/mg34/limited
	name = "Maschinengewehr 34 blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/mg34)

/datum/crafting_recipe/bpcopy/kar98
	result = /obj/item/blueprint/weapon/kar98/limited
	name = "Karabiner 98k blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/kar98)

/datum/crafting_recipe/bpcopy/thatgun
	result = /obj/item/blueprint/weapon/thatgun/limited
	name = ".223 pistol blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/thatgun)

//////////////////
///AMMO CRAFTING//
//////////////////
/*
/datum/crafting_recipe/arrow
	name = "Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/wood
	time = 5 // these only do 15 damage
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				 /obj/item/stack/sheet/cloth = 1,
				 /obj/item/stack/rods = 1) // 1 metal sheet = 2 rods = 2 arrows
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/bone_arrow
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bone
	time = 5
	always_availible = FALSE
	reqs = list(/obj/item/stack/sheet/bone = 1,
				 /obj/item/stack/sheet/sinew = 1,
				 /obj/item/ammo_casing/caseless/arrow/ash = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ashen_arrow
	name = "Ashen Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ash
	tools = list(TOOL_WELDER)
	time = 10 // 1.5 seconds minimum per actually worthwhile arrow excluding interface lag
	always_availible = FALSE
	reqs = list(/obj/item/ammo_casing/caseless/arrow/wood = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/smartdart
	name = "Medical smartdart"
	result =  /obj/item/reagent_containers/syringe/dart
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/plastic = 1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/meteorslug
	name = "Meteorslug Shell"
	result = /obj/item/ammo_casing/shotgun/meteorslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/rcd_ammo = 1,
				/obj/item/stock_parts/manipulator = 2)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/pulseslug
	name = "Pulse Slug Shell"
	result = /obj/item/ammo_casing/shotgun/pulseslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/capacitor/adv = 2,
				/obj/item/stock_parts/micro_laser/ultra = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/dragonsbreath
	name = "Dragonsbreath Shell"
	result = /obj/item/ammo_casing/shotgun/dragonsbreath
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/datum/reagent/phosphorus = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/frag12
	name = "FRAG-12 Shell"
	result = /obj/item/ammo_casing/shotgun/frag12
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/datum/reagent/glycerol = 5,
				/datum/reagent/toxin/acid = 5,
				/datum/reagent/toxin/acid/fluacid = 5)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ionslug
	name = "Ion Scatter Shell"
	result = /obj/item/ammo_casing/shotgun/ion
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/micro_laser/ultra = 1,
				/obj/item/stock_parts/subspace/crystal = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/improvisedslug
	name = "Improvised Shotgun Shell"
	result = /obj/item/ammo_casing/shotgun/improvised
	reqs = list(/obj/item/grenade/chem_grenade = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/cable_coil = 1,
				/datum/reagent/fuel = 10)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/laserslug
	name = "Scatter Laser Shell"
	result = /obj/item/ammo_casing/shotgun/laserslug
	reqs = list(/obj/item/ammo_casing/shotgun/techshell = 1,
				/obj/item/stock_parts/capacitor/adv = 1,
				/obj/item/stock_parts/micro_laser/high = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 5
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO
*/
////////////////////
// PARTS CRAFTING //
////////////////////

// RECEIVERS
/*
/datum/crafting_recipe/rifle_receiver
	name = "Improvised Rifle Receiver"
	result = /obj/item/weaponcrafting/improvised_parts/rifle_receiver
	reqs = list(/obj/item/stack/sheet/metal = 15) // you can carry multiple shotguns
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 25
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS

/datum/crafting_recipe/shotgun_receiver
	name = "Improvised Shotgun Receiver"
	result = /obj/item/weaponcrafting/improvised_parts/shotgun_receiver
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/plasteel = 1) // requires access or hacking since shotgun is better
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 25
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS

// MISC

/datum/crafting_recipe/trigger_assembly
	name = "Trigger Assembly"
	result = /obj/item/weaponcrafting/improvised_parts/trigger_assembly
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/assembly/igniter = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WELDER)
	time = 25
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
*/
