
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
/////////////////////// Canisters & Materials ////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/materials
	group = "Canisters & Materials"

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Materials //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/* disabled pending rework of advcrafting lootdrop
/datum/supply_pack/materials/weaponparts
	goody = PACK_GOODY_PUBLIC
	name = "Weapon Parts"
	desc = "A random collection of recovered weapon parts. A gunsmith's wet dream."
	cost = 750
	contains = list(/obj/effect/spawner/lootdrop/f13/advcrafting,
					/obj/effect/spawner/lootdrop/f13/advcrafting,
					/obj/effect/spawner/lootdrop/f13/advcrafting,
					/obj/effect/spawner/lootdrop/f13/advcrafting)
*/
/* /datum/supply_pack/materials/rcdammo
	goody = PACK_GOODY_PUBLIC
	name = "Large RCD ammo Single-Pack"
	desc = "A single large compressed RCD matter pack, to help with any holes or projects people might be working on."
	cost = 600
	contains = list(/obj/item/rcd_ammo/large) */

//datum/supply_pack/materials/rawlumber
//	name = "50 Towercap Logs"
//	desc = "Raw logs from towercaps. Contains fifty logs."
//	cost = 1000
//	contains = list(/obj/item/grown/log)
//	crate_name = "lumber crate"

//datum/supply_pack/materials/rawlumber/generate()
//	. = ..()
//	for(var/i in 1 to 49)
//		new /obj/item/grown/log(.)

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Canisters //////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/* /datum/supply_pack/materials/bz
	name = "BZ Canister Crate"
	desc = "Contains a canister of BZ. Requires Toxins access to open."
	cost = 7500 // Costs 3 credits more than what you can get for selling it.
	access = ACCESS_TOX_STORAGE
	contains = list(/obj/machinery/portable_atmospherics/canister/bz)
	crate_name = "BZ canister crate"
	crate_type = /obj/structure/closet/crate/secure/science

/datum/supply_pack/materials/carbon_dio
	name = "Carbon Dioxide Canister"
	desc = "Contains a canister of Carbon Dioxide."
	cost = 3000
	contains = list(/obj/machinery/portable_atmospherics/canister/carbon_dioxide)
	crate_name = "carbon dioxide canister crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/materials/nitrogen
	name = "Nitrogen Canister"
	desc = "Contains a canister of Nitrogen."
	cost = 2000
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrogen)
	crate_name = "nitrogen canister crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/materials/nitrous_oxide_canister
	name = "Nitrous Oxide Canister"
	desc = "Contains a canister of Nitrous Oxide. Requires Atmospherics access to open."
	cost = 3000
	access = ACCESS_ATMOSPHERICS
	contains = list(/obj/machinery/portable_atmospherics/canister/nitrous_oxide)
	crate_name = "nitrous oxide canister crate"
	crate_type = /obj/structure/closet/crate/secure

/datum/supply_pack/materials/oxygen
	name = "Oxygen Canister"
	desc = "Contains a canister of Oxygen. Canned in Druidia."
	cost = 1500
	contains = list(/obj/machinery/portable_atmospherics/canister/oxygen)
	crate_name = "oxygen canister crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/materials/water_vapor
	name = "Water Vapor Canister"
	desc = "Contains a canister of Water Vapor. I swear to god if you open this in the halls..."
	cost = 2500
	contains = list(/obj/machinery/portable_atmospherics/canister/water_vapor)
	crate_name = "water vapor canister crate"
	crate_type = /obj/structure/closet/crate/large */

//////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Tanks ////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/materials/fueltank
	name = "Fuel Tank Crate"
	desc = "Contains a welding fuel tank. Caution, highly flammable."
	cost = 500
	contains = list(/obj/structure/reagent_dispensers/fueltank)
	crate_name = "fuel tank crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/materials/housekit
	name = "House Building Kit"
	desc = "Contains 200 wooden planks, 200 bricks, 100 metal sheets and 100 glass sheets. Perfect for building a modest home!"
	cost = 4500
	contains = list(/obj/item/stack/sheet/mineral/brick/fifty,
					/obj/item/stack/sheet/mineral/brick/fifty,
					/obj/item/stack/sheet/mineral/brick/fifty,
					/obj/item/stack/sheet/mineral/brick/fifty,
					/obj/item/stack/sheet/metal/fifty,
					/obj/item/stack/sheet/metal/fifty,
					/obj/item/stack/sheet/mineral/wood/fifty,
					/obj/item/stack/sheet/mineral/wood/fifty,
					/obj/item/stack/sheet/mineral/wood/fifty,
					/obj/item/stack/sheet/mineral/wood/fifty,
					/obj/item/stack/sheet/glass/fifty,
					/obj/item/stack/sheet/glass/fifty)
	crate_name = "house building kit"
	crate_type = /obj/structure/closet/crate/secure/engineering

/datum/supply_pack/materials/watertank
	name = "Water Tank Crate"
	desc = "Contains a tank of dihydrogen monoxide... sounds dangerous."
	cost = 500
	contains = list(/obj/structure/reagent_dispensers/watertank)
	crate_name = "water tank crate"
	crate_type = /obj/structure/closet/crate/large

/* /datum/supply_pack/materials/foamtank
	name = "Firefighting Foam Tank Crate"
	desc = "Contains a tank of firefighting foam. Also known as \"plasmaman's bane\"."
	cost = 1500
	contains = list(/obj/structure/reagent_dispensers/foamtank)
	crate_name = "foam tank crate"
	crate_type = /obj/structure/closet/crate/large */

/datum/supply_pack/materials/hightank
	name = "Large Water Tank Crate"
	desc = "Contains a high-capacity water tank. Useful for botany or other service jobs."
	cost = 800
	contains = list(/obj/structure/reagent_dispensers/watertank/high)
	crate_name = "high-capacity water tank crate"
	crate_type = /obj/structure/closet/crate/large

/datum/supply_pack/materials/powder50
	name = "50 Gunpowder Clumps"
	desc = "For when ammunition is in low supply."
	cost = 2000
	contains = list(/obj/item/stack/ore/blackpowder/fifty)
	crate_name = "Gunpowder Restock"
