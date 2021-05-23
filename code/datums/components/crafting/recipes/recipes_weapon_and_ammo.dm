

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

/datum/crafting_recipe/buckler
	name = "Wooden Buckler"
	result = /obj/item/shield/riot/buckler
	reqs = list(/obj/item/stack/sheet/mineral/wood = 15,
				/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_SCREWDRIVER)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/twohanded/spear
	name = "Spear"
	result = /obj/item/twohanded/spear
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
/*
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
*/

///datum/crafting_recipe/chainsaw
//	name = "Chainsaw"
//	result = /obj/item/twohanded/chainsaw
//	reqs = list(/obj/item/circular_saw = 1,
//				/obj/item/stack/cable_coil = 3,
//				/obj/item/stack/sheet/plasteel = 5)
//	tools = list(TOOL_WELDER)
//	time = 50
//	category = CAT_WEAPONRY
//	subcategory = CAT_MELEE

//////////////////
///BOMB CRAFTING//
//////////////////

/datum/crafting_recipe/compressedpowder
	name = "Compressed Blackpowder"
	result = /obj/item/stack/ore/blackpowder
	time = 5
	reqs = list(/datum/reagent/blackpowder = 50)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

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
	subcategory = CAT_AMMO

/datum/crafting_recipe/molotov
	name = "Molotov Cocktail"
	result = /obj/item/reagent_containers/food/drinks/bottle/molotov
	reqs = list(/obj/item/reagent_containers/rag = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/IED
	name = "Improvised Grenade (IED)"
	result = /obj/item/grenade/iedcasing
	reqs = list(/datum/reagent/fuel = 50,
				/obj/item/stack/cable_coil = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/lance
	name = "Explosive Lance (Grenade)"
	result = /obj/item/twohanded/spear
	reqs = list(/obj/item/twohanded/spear = 1,
				/obj/item/grenade = 1)
	parts = list(/obj/item/twohanded/spear = 1,
				/obj/item/grenade = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/////////////////////////
///POWER CELL RECYCLING//
/////////////////////////

/datum/crafting_recipe/ecrecharge
	name = "Small Energy Cell (recycle)"
	result = /obj/item/stock_parts/cell/ammo/ec
	reqs = list(/obj/item/stock_parts/cell/ammo/ec=2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/mfcrecharge
	name = "Microfusion Cell (recycle)"
	result = /obj/item/stock_parts/cell/ammo/mfc
	reqs = list(/obj/item/stock_parts/cell/ammo/mfc=2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/ecprecharge
	name = "Electron Charge Pack (recycle)"
	result = /obj/item/stock_parts/cell/ammo/ecp
	reqs = list(/obj/item/stock_parts/cell/ammo/ecp=2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/batteryboxplasma //plasmamusket ammo
	name = "Plasma Can"
	result = /obj/item/ammo_box/plasmamusket
	reqs = list(/obj/item/stack/crafting/electronicparts = 2,
				/obj/item/stack/sheet/glass = 4,
				/obj/item/stack/sheet/metal = 4)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/batterybox //lasmusket ammo
	name = "Laser Musket battery pack"
	result = /obj/item/ammo_box/lasmusket
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/sheet/glass = 6,
				/obj/item/stack/sheet/metal = 6)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO



//////////////////
///GUNS CRAFTING//
//////////////////

//Hobo Guns
/datum/crafting_recipe/zipgun
	name = "Zip Gun (9mm)"
	result = /obj/item/gun/ballistic/revolver/zipgun
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/ammo_casing/c9mm = 6,
				/obj/item/stack/rods = 1,
				/obj/item/stack/crafting/metalparts = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/piperifle
	name = "Pepperbox Gun (10mm)"
	result = /obj/item/gun/ballistic/revolver/pipe_rifle
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/ammo_casing/c10mm = 6,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/rods = 6)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/autopiperifle
	name = "Pipe Rifle (.357)"
	result = /obj/item/gun/ballistic/automatic/autopipe
	reqs = list(/datum/reagent/blackpowder = 30,
	/obj/item/stack/crafting/metalparts = 1,
	/obj/item/crafting/duct_tape = 1,
	/obj/item/stack/sheet/cloth = 1,
	/obj/item/stack/sheet/mineral/wood = 2)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/slamfireshotgun
	name = "Slamfire Shotgun"
	result = /obj/item/gun/ballistic/revolver/single_shotgun
	reqs = list(/obj/item/screwdriver = 1,
	/obj/item/ammo_casing/shotgun = 1,
	/obj/item/stack/rods = 1,
	/obj/item/stack/sheet/mineral/wood = 2)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/plasmamusket //lasmusket ammo
	name = "Plasma Musket"
	result = /obj/item/gun/ballistic/shotgun/plasmacaster
	reqs = list(/obj/item/gun/ballistic/shotgun/lasmusket = 1,
				/obj/item/advanced_crafting_components/conductors = 1)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/lasmusket
	name = "Laser Musket"
	result = /obj/item/gun/ballistic/shotgun/lasmusket
	reqs = list(/obj/item/stack/crafting/electronicparts = 2,
	/obj/item/gun/ballistic/revolver/pipe_rifle = 1,
	/obj/item/reagent_containers/food/drinks/bottle = 1,
	/obj/item/stack/cable_coil = 3)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON


//browning hi-power
/datum/crafting_recipe/ninemil
	name = "9mm Pistol"
	result = /obj/item/gun/ballistic/automatic/pistol/ninemil
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//colt 6520
/datum/crafting_recipe/colt6520
	name = "Colt 6520 Revolver"
	result = /obj/item/gun/ballistic/revolver/colt6520
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 5,
				/datum/reagent/blackpowder = 10,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//m1911
/datum/crafting_recipe/m1911
	name = "M1911"
	result = /obj/item/gun/ballistic/automatic/pistol/m1911
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//n99
/datum/crafting_recipe/n99
	name = "10mm Pistol"
	result = /obj/item/gun/ballistic/automatic/pistol/n99
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//hunting rifle
/datum/crafting_recipe/huntingrifle
	name = "Hunting Rifle"
	result = /obj/item/gun/ballistic/shotgun/remington
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/datum/reagent/blackpowder = 20,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//battle rifle
/datum/crafting_recipe/m1garand
	name = "M1 Garand"
	result = /obj/item/gun/ballistic/automatic/m1garand
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//varmint rifle
/datum/crafting_recipe/varmintrifle
	name = "Varmint Rifle"
	result = /obj/item/gun/ballistic/automatic/varmint
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//SLR
/datum/crafting_recipe/slr
	name = "Enfield Self-loading Rifle"
	result = /obj/item/gun/ballistic/automatic/slr
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//rangemaster
/datum/crafting_recipe/rangemaster
	name = "Colt Rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//r91
/datum/crafting_recipe/r91
	name = "R91 Assault Rifle"
	result = /obj/item/gun/ballistic/automatic/assault_rifle
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/mineral/titanium = 2)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//infiltrator
/datum/crafting_recipe/infiltrator
	name = "Infiltrator Carbine"
	result = /obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	reqs = list(/obj/item/gun/ballistic/automatic/assault_rifle = 1,
				/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/suppressor = 1,
				/obj/item/stack/sheet/plastic = 3,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//fn fal
/datum/crafting_recipe/fnfal
	name = "FN-FAL"
	result = /obj/item/gun/ballistic/automatic/fnfal
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/mineral/titanium = 2,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//widowmaker
/datum/crafting_recipe/widowmaker
	name = "Winchester Widowmaker double barrel"
	result = /obj/item/gun/ballistic/revolver/widowmaker
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 5,
				/datum/reagent/blackpowder = 5)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//hunting shotgun
/datum/crafting_recipe/huntingshotgun
	name = "Hunting Shotgun"
	result = /obj/item/gun/ballistic/shotgun/hunting
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/metal = 3,
				/datum/reagent/blackpowder = 15)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//h&k caws
/datum/crafting_recipe/caws
	name = "h&k caws"
	result = /obj/item/gun/ballistic/automatic/shotgun/caws
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/mineral/titanium = 2,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 3)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//R82 heavy service rifle
/datum/crafting_recipe/R82
	name = "R82 heavy service rifle"
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
	name = "Marksman Carbine"
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
	name = "R84 LMG"
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
	name = "Service Rifle 5.56mm"
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

//scout carbine
/datum/crafting_recipe/scoutcarbine
	name = "Scout Carbine"
	result = /obj/item/gun/ballistic/automatic/service/carbine
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
	name = "AEP-7"
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
	name = "Lever Action Shotgun"
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
	name = "Trail Carbine"
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
	name = ".223 Pistol"
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
	name = "Ppsh-41"
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
	name = "Plasma Pistol"
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
	name = "Uzi SMG"
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
	name = "Grease Gun"
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
	name = "Brush Gun"
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
	name = "R91 Assault Rifle"
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
	name = "Breacher Shotgun"
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
	name = "Sniper Rifle"
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
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	always_availible = FALSE

//aer9
/datum/crafting_recipe/AER9
	name = "AER-9"
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
	name = "Anti-Materiel Rifle"
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
	name = "City-Killer Shotgun"
	result = /obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 10
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

//magneto
/datum/crafting_recipe/magnetowattz
	name = "Wattz 1000 Magneto-laser Pistol"
	result = /obj/item/gun/energy/laser/wattz/magneto
	reqs = list(/obj/item/gun/energy/laser/wattz = 1,
				/obj/item/stack/crafting/electronicparts = 2)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//extendo GLOCK
/datum/crafting_recipe/glock86a
	name = "Glock 86A Plasma Pistol"
	result = /obj/item/gun/energy/laser/plasma/glock/extended
	reqs = list(/obj/item/gun/energy/laser/plasma/glock = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/crafting/electronicparts = 3)
	tools = list(TOOL_AWORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//////////////////////////////////
///GUN ATTACHMENT/PARTS CRAFTING//
//////////////////////////////////
/datum/crafting_recipe/scope
	name = "Weapon Optics"
	result = /obj/item/attachments/scope
	reqs = list(
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/glass = 3,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/crafting/goodparts = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/suppressor
	name = "Suppressor"
	result = /obj/item/suppressor
	reqs = list(
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/plastic = 2,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/crafting/goodparts = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/burst_improvement
	name = "Burst Cam"
	result = /obj/item/attachments/burst_improvement
	reqs = list(
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/recoil_decrease
	name = "Recoil Compensator"
	result = /obj/item/attachments/recoil_decrease
	reqs = list(
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/automatic_sear
	name = "Automatic Sear"
	result = /obj/item/attachments/auto_sear
	reqs = list(
				/obj/item/stack/sheet/metal = 8,
				/obj/item/stack/crafting/metalparts = 8,
				/obj/item/stack/crafting/goodparts = 8
	)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE


/*
/datum/crafting_recipe/flux
	name = "Flux capacitor"
	result = /obj/item/advanced_crafting_components/flux
	reqs = list(
				/obj/item/stack/cable_coil = 5,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/stack/crafting/electronicparts = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/lenses
	name = "Focused crystal lenses"
	result = /obj/item/advanced_crafting_components/lenses
	reqs = list(
				/obj/item/stack/cable_coil = 5,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/crafting/electronicparts = 1,
				/obj/item/stack/sheet/glass = 10
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/conductors
	name = "Superconductor coil"
	result = /obj/item/advanced_crafting_components/conductors
	reqs = list(
				/obj/item/stack/cable_coil = 30,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/crafting/electronicparts = 2
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/receiver
	name = "Advanced modular receiver"
	result = /obj/item/advanced_crafting_components/receiver
	reqs = list(
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/crafting/metalparts = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/assembly
	name = "Pre-war weapon assembly"
	result = /obj/item/advanced_crafting_components/assembly
	reqs = list(
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/sheet/plastic = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

/datum/crafting_recipe/alloys
	name = "Superlight alloys"
	result = /obj/item/advanced_crafting_components/alloys
	reqs = list(
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/titanium = 5,
				/obj/item/stack/sheet/plasteel = 5
				)
	tools = list(TOOL_AWORKBENCH)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_PARTS
	always_availible = FALSE

*/
