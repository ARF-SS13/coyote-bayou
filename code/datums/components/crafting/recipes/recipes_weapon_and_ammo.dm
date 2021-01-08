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
	subcategory = CAT_WEAPON

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

//R82 heavy service rifle
/datum/crafting_recipe/R82
	name = "r82 heavy service rifle"
	result = /obj/item/gun/ballistic/automatic/service/r82
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//marksman carbine
/datum/crafting_recipe/marksmancarbine
	name = "marksman carbine"
	result = /obj/item/gun/ballistic/automatic/marksman
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/stack/crafting/goodparts = 3
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//r84 lmg
/datum/crafting_recipe/lmg
	name = "r84 LMG"
	result = /obj/item/gun/ballistic/automatic/r84
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//service rifle
/datum/crafting_recipe/servicerifle
	name = "service rifle"
	result = /obj/item/gun/ballistic/automatic/service
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//aep7
/datum/crafting_recipe/AEP7
	name = "aep7"
	result = /obj/item/gun/energy/laser/pistol
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/lenses = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//lever action
/datum/crafting_recipe/lever_action
	name = "lever action shotgun"
	result = /obj/item/gun/ballistic/shotgun/trench
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//trail carbine
/datum/crafting_recipe/trail_carbine
	name = "trail carbine"
	result = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//.223 pistol
/datum/crafting_recipe/thatgun
	name = ".223 pistol"
	result = /obj/item/gun/ballistic/revolver/thatgun
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 15,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//pps
/datum/crafting_recipe/pps
	name = "ppsh41"
	result = /obj/item/gun/ballistic/automatic/pps
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/metalparts = 2
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//mg34
/*
/datum/crafting_recipe/mg34
	name = "Maschinengewehr 34"
	result = /obj/item/gun/ballistic/automatic/mg34
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/stack/crafting/metalparts = 3
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE
*/
//plasma pistol
/datum/crafting_recipe/plasmapistol
	name = "plasma pistol"
	result = /obj/item/gun/energy/laser/plasma/pistol
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//uzi
/datum/crafting_recipe/uzi
	name = "mini uzi"
	result = /obj/item/gun/ballistic/automatic/mini_uzi
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//10mm smg
/datum/crafting_recipe/smg10mm
	name = "10mm SMG"
	result = /obj/item/gun/ballistic/automatic/smg10mm
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//grease gun
/datum/crafting_recipe/grease_gun
	name = "Grease gun"
	result = /obj/item/gun/ballistic/automatic/greasegun
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/receiver = 1,
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//brush gun
/datum/crafting_recipe/brush
	name = "Brush gun"
	result = /obj/item/gun/ballistic/shotgun/automatic/hunting/brush
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 3
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//r91
/datum/crafting_recipe/r91
	name = "R91 assault rifle"
	result = /obj/item/gun/ballistic/automatic/assault_rifle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//breacher
/datum/crafting_recipe/breacher
	name = "Breacher shotgun"
	result = /obj/item/gun/ballistic/automatic/shotgun/riot
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//sniper
/datum/crafting_recipe/sniper
	name = "Sniper rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/sniper
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//deagle
/datum/crafting_recipe/deagle
	name = "Desert Eagle"
	result = /obj/item/gun/ballistic/automatic/pistol/deagle
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

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
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//plasma rifle
/datum/crafting_recipe/plasmarifle
	name = "Plasma Rifle"
	result = /obj/item/gun/energy/laser/plasma
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/advanced_crafting_components/flux = 1,
				/obj/item/advanced_crafting_components/conductors = 2,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/electronicparts = 3
				)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

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
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//AM rifle
/datum/crafting_recipe/am_rifle
	name = "AM Rifle"
	result = /obj/item/gun/ballistic/shotgun/antimateriel
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

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
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//rangemaster
/datum/crafting_recipe/rangemaster
	name = "Colt Rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//bozar
/datum/crafting_recipe/bozar
	name = "Bozar"
	result = /obj/item/gun/ballistic/automatic/bozar
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/goodparts = 5, 
				
				)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE
