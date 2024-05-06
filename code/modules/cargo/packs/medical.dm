
//Reminders-
// If you add something to this list, please group it by type and sort it alphabetically instead of just jamming it in like an animal
// cost = 700- Minimum cost, or infinite points are possible.
//////////////////////////////////////////////////////////////////////////////
//////////////////////////// Medical /////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/medical
	group = "Medical"
	crate_type = /obj/structure/closet/crate/medical

//////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Equipment ////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

/datum/supply_pack/medical/bodybags
	name = "Bodybags"
	desc = "For when the bodies hit the floor. Contains 4 boxes of bodybags."
	cost = 500
	contains = list(/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,)
	crate_name = "bodybag crate"

/datum/supply_pack/medical/bloodpacks
	name = "Blood Pack Variety Crate"
	desc = "Contains nine different blood packs for reintroducing blood to patients, plus two universal synthetic blood packs."
	cost = 1000
	contains = list(/obj/item/reagent_containers/blood/random,
					/obj/item/reagent_containers/blood/APlus,
					/obj/item/reagent_containers/blood/AMinus,
					/obj/item/reagent_containers/blood/BPlus,
					/obj/item/reagent_containers/blood/BMinus,
					/obj/item/reagent_containers/blood/OPlus,
					/obj/item/reagent_containers/blood/OMinus,
					/obj/item/reagent_containers/blood/lizard,
					/obj/item/reagent_containers/blood/jellyblood,
					/obj/item/reagent_containers/blood/insect)
	crate_name = "blood freezer"
	crate_type = /obj/structure/closet/crate/freezer

/datum/supply_pack/medical/chemical
	name = "Chemical Starter Kit Crate"
	desc = "Contains twelve different chemicals, for all the fun experiments you can make."
	cost = 1200
	contains = list(/obj/item/reagent_containers/glass/bottle/hydrogen,
					/obj/item/reagent_containers/glass/bottle/carbon,
					/obj/item/reagent_containers/glass/bottle/nitrogen,
					/obj/item/reagent_containers/glass/bottle/oxygen,
					/obj/item/reagent_containers/glass/bottle/fluorine,
					/obj/item/reagent_containers/glass/bottle/phosphorus,
					/obj/item/reagent_containers/glass/bottle/silicon,
					/obj/item/reagent_containers/glass/bottle/chlorine,
					/obj/item/reagent_containers/glass/bottle/radium,
					/obj/item/reagent_containers/glass/bottle/sacid,
					/obj/item/reagent_containers/glass/bottle/ethanol,
					/obj/item/reagent_containers/glass/bottle/potassium,
					/obj/item/clothing/glasses/science,
					/obj/item/reagent_containers/dropper,
					/obj/item/storage/box/beakers)
	crate_name = "chemical crate"

/datum/supply_pack/medical/defibs
	name = "Defibrillator Crate"
	desc = "Contains two defibrillators for bringing the recently deceased back to life."
	cost = 1000
	contains = list(/obj/item/defibrillator/loaded,
					/obj/item/defibrillator/loaded)
	crate_name = "defibrillator crate"

/datum/supply_pack/medical/firstaidbruises_single
	name = "Bruise Treatment Kit Single-Pack"
	desc = "A single brute first-aid kit, perfect for recovering from being crushed by a super-mutant. Did you know people get crushed by super-mutants all the time? Interesting..."
	cost = 400
	contains = list(/obj/item/storage/firstaid/brute)

/datum/supply_pack/medical/firstaidburns_single
	name = "Burn Treatment Kit Single-Pack"
	desc = "A single burn first-aid kit. The advertisement displays a winking Brotherhood scribe giving a thumbs up, saying \"Mistakes happen!\""
	cost = 400
	contains = list(/obj/item/storage/firstaid/fire)

/datum/supply_pack/medical/firstaid_single
	name = "First Aid Kit Single-Pack"
	desc = "A single first-aid kit, fit for healing most types of bodily harm."
	cost = 500
	contains = list(/obj/item/storage/firstaid/regular)

/datum/supply_pack/medical/firstaidoxygen_single
	name = "Oxygen Deprivation Kit Single-Pack"
	desc = "A single oxygen deprivation first-aid kit, marketed heavily to those with crippling fears of asphyxiation."
	cost = 400
	contains = list(/obj/item/storage/firstaid/o2)

/datum/supply_pack/medical/firstaidtoxins_single
	name = "Toxin Treatment Kit Single-Pack"
	desc = "A single first aid kit focused on healing damage dealt by heavy toxins."
	cost = 400
	contains = list(/obj/item/storage/firstaid/toxin)

/datum/supply_pack/medical/tacticalkit
	name = "Tactical Treatment Kit Single-Pack"
	desc = "A single first aid kit focused on getting people out of a bad situation."
	cost = 5000
	contains = list(/obj/item/storage/firstaid/tactical)

/datum/supply_pack/medical/brutepouch
	name = "Brute Medical Pouch Refill"
	desc = "A set of bandages, sutures, and a first-aid spray perfect to refill a medical pouch or medkit. Tailored for bruises."
	cost = 500
	contains = list(
	/obj/item/stack/medical/gauze/adv,
	/obj/item/stack/medical/gauze/adv,
	/obj/item/stack/medical/suture,
	/obj/item/stack/medical/suture,
	/obj/item/reagent_containers/medspray/styptic
	)

/datum/supply_pack/medical/burnpouch
	name = "Burn Medical Pouch Refill"
	desc = "A set of bandages, sutures, and a first-aid spray perfect to refill a medical pouch or medkit. Tailored for burns."
	cost = 500
	contains = list(
	/obj/item/stack/medical/gauze/adv,
	/obj/item/stack/medical/gauze/adv,
	/obj/item/stack/medical/suture,
	/obj/item/stack/medical/suture,
	/obj/item/reagent_containers/medspray/silver_sulf
	)

/datum/supply_pack/medical/potions
	name = "Ambrosia Elixirs"
	desc = "Four bottles of precious Ambrosia Elixirs. Two reds, one blue, and one green included.."
	cost = 5000
	contains = list(
		/obj/item/reagent_containers/pill/redambrosia,
		/obj/item/reagent_containers/pill/redambrosia,
		/obj/item/reagent_containers/pill/blueambrosia,
		/obj/item/reagent_containers/pill/greenambrosia,
)
/datum/supply_pack/emergency/medicalemergency
	name = "Emergency Medical Supplies" //Almost all of this can be ordered seperatly for a much cheaper price, but the HUD increases it.
	desc = "Emergency supplies for a front-line medic. Contains two boxes of body bags, a defib unit, medical belt, toxin bottles, epipens, and several types of medical kits."
	cost = 7500
	contains = list(/obj/item/storage/box/bodybags,
					/obj/item/storage/box/bodybags,
					/obj/item/defibrillator/loaded,
					/obj/item/storage/belt/medical,
					/obj/item/storage/firstaid/toxin,
					/obj/item/storage/firstaid/o2,
					/obj/item/storage/firstaid/brute,
					/obj/item/storage/firstaid/fire,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/storage/box/medipens)
	crate_name = "medical emergency crate"
	crate_type = /obj/structure/closet/crate/medical

/datum/supply_pack/emergency/medemergencylite
	name = "Emergency Medical Supplies (Lite)"
	desc = "A less than optimal, but still effective, set of tools for emergency care. Contains a box of bodybags, some normal (and advanced) health analyzers, healing sprays, a single first aid kit, charcoal, some gauze, a bottle of toxins, and some spare medipens."
	cost = 2800
	contains = list(/obj/item/storage/box/bodybags,
					/obj/item/stack/medical/gauze,
					/obj/item/stack/medical/gauze,
					/obj/item/healthanalyzer,
					/obj/item/healthanalyzer,
					/obj/item/healthanalyzer/advanced,
					/obj/item/storage/firstaid/regular,
					/obj/item/reagent_containers/medspray/styptic,
					/obj/item/reagent_containers/medspray/silver_sulf,
					/obj/item/reagent_containers/medspray/synthflesh,
					/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/hypospray/medipen,
					/obj/item/reagent_containers/hypospray/medipen,
					/obj/item/reagent_containers/hypospray/medipen,
					/obj/item/reagent_containers/hypospray/medipen)
	crate_name = "medical emergency crate (lite)"
	crate_type = /obj/structure/closet/crate/medical

/datum/supply_pack/medical/iv_drip
	name = "IV Drip Crate"
	desc = "Contains a single IV drip stand for intravenous delivery."
	cost = 400
	contains = list(/obj/machinery/iv_drip)
	crate_name = "iv drip crate"
/*
/datum/supply_pack/medical/medicalhardsuit
	name = "Medical Hardsuit"
	desc = "Got people being spaced left and right? Hole in the same room as the dead body of Hos or cap? Fear not, now you can buy one medical hardsuit with a mask and air tank to save your fellow crewmembers. Requires medical access to open."
	cost = 2750
	access = ACCESS_MEDICAL
	contains = list(/obj/item/tank/internals/air,
					/obj/item/clothing/mask/gas,
					/obj/item/clothing/suit/space/hardsuit/medical)
	crate_name = "medical hardsuit"
	crate_type = /obj/structure/closet/crate/secure/medical
*/
/datum/supply_pack/medical/supplies
	name = "Medical Supplies Crate"
	desc = "Contains seven beakers, syringes, and bodybags. Three morphine bottles, four insulin pills. Two charcoal bottles, epinephrine bottles, antitoxin bottles, and large beakers. Finally, a single roll of medical gauze."
	cost = 1500
	contains = list(/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/charcoal,
					/obj/item/reagent_containers/glass/bottle/epinephrine,
					/obj/item/reagent_containers/glass/bottle/epinephrine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/morphine,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/bottle/toxin,
					/obj/item/reagent_containers/glass/beaker/large,
					/obj/item/reagent_containers/glass/beaker/large,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/reagent_containers/pill/insulin,
					/obj/item/stack/medical/gauze,
					/obj/item/storage/box/beakers,
					/obj/item/storage/box/medsprays,
					/obj/item/storage/box/syringes,
					/obj/item/storage/box/bodybags,
					/obj/item/stack/medical/bone_gel,
					/obj/item/stack/medical/bone_gel)
	crate_name = "medical supplies crate"

/datum/supply_pack/medical/adv_surgery_tools
	name = "Med-Tek Advanced Surgery Tools"
	desc = "A full set of Med-Co advanced surgery tools, this crate also comes with a spay of synth flesh as well as a can of sterilizine. Requires Surgery access to open."
	cost = 4000
	contains = list(/obj/item/storage/belt/medical/surgery_belt_adv,
					/obj/item/reagent_containers/medspray/synthflesh,
					/obj/item/reagent_containers/medspray/sterilizine)
	crate_name = "medtek surgery tools"
	crate_type = /obj/structure/closet/crate/secure/medical

/datum/supply_pack/medical/alien_surgery_tools
	name = "Alien Surgery Tools"
	desc = "A full set of Med-Co advanced surgery tools, this crate also comes with a spay of synth flesh as well as a can of sterilizine. Requires Surgery access to open."
	cost = 7000
	contains = list(/obj/item/scalpel/alien,
					/obj/item/retractor/alien,
					/obj/item/cautery/alien,
					/obj/item/circular_saw/alien,
					/obj/item/hemostat/alien,
					/obj/item/surgicaldrill/alien)
	crate_name = "medtek surgery tools"
	crate_type = /obj/structure/closet/crate/secure/medical

/datum/supply_pack/medical/surgery
	name = "Surgical Supplies Crate"
	desc = "Do you want to perform surgery, but don't have one of those fancy shmancy degrees? Just get started with this crate containing a medical duffelbag, Sterilizine spray and collapsible roller bed."
	cost = 1200
	contains = list(/obj/item/storage/backpack/duffelbag/med/surgery,
					/obj/item/reagent_containers/medspray/sterilizine,
					/obj/item/roller)
	crate_name = "surgical supplies crate"

//////////////////////////////////////////////////////////////////////////////
///////////////////////////// Medical Kits ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////


/datum/supply_pack/medical/sprays
	name = "Medical Sprays"
	desc = "Contains two cans of Styptic Spray, Silver Sulfadiazine Spray, Synthflesh Spray and Sterilizer Compound Spray."
	cost = 2000
	contains = list(/obj/item/reagent_containers/medspray/styptic,
					/obj/item/reagent_containers/medspray/styptic,
					/obj/item/reagent_containers/medspray/silver_sulf,
					/obj/item/reagent_containers/medspray/silver_sulf,
					/obj/item/reagent_containers/medspray/synthflesh,
					/obj/item/reagent_containers/medspray/synthflesh,
					/obj/item/reagent_containers/medspray/sterilizine,
					/obj/item/reagent_containers/medspray/sterilizine)
	crate_name = "medical supplies crate"

/datum/supply_pack/medical/advrad
	name = "Radiation Treatment Crate Deluxe"
	desc = "A crate for when radiation is out of hand... Contains two radaway pouches, one bottle of radx, as well as a radiation treatment deluxe pill bottle!"
	cost = 1200
	contains = list(/obj/item/storage/pill_bottle/antirad_plus,
					/obj/item/storage/pill_bottle/mutarad,
					/obj/item/storage/firstaid/radbgone,
					/obj/item/storage/firstaid/radbgone)

	crate_name = "radiation protection crate"
	crate_type = /obj/structure/closet/crate/radiation


/datum/supply_pack/medical/medipen_variety
	name = "Medipen Variety-Pak"
	desc = "Contains eight different medipens in three different varieties, to assist in quickly treating seriously injured patients."
	cost = 1200
	contains = list(/obj/item/reagent_containers/hypospray/medipen/,
					/obj/item/reagent_containers/hypospray/medipen/,
					/obj/item/reagent_containers/hypospray/medipen/ekit,
					/obj/item/reagent_containers/hypospray/medipen/ekit,
					/obj/item/reagent_containers/hypospray/medipen/ekit,
					/obj/item/reagent_containers/hypospray/medipen/blood_loss,
					/obj/item/reagent_containers/hypospray/medipen/blood_loss,
					/obj/item/reagent_containers/hypospray/medipen/blood_loss)

	crate_name = "medipen crate"

/datum/supply_pack/medical/chems
	name = "Mixed Chems"
	desc = "A raider's dream, contains five random chems."
	cost = 1000
	contains = list(/obj/effect/spawner/lootdrop/f13/trash_drugs,
					/obj/effect/spawner/lootdrop/f13/trash_drugs,
					/obj/effect/spawner/lootdrop/f13/common_drugs,
					/obj/effect/spawner/lootdrop/f13/common_drugs,
					/obj/effect/spawner/lootdrop/f13/uncommon_drugs)
	crate_name = "chem crate"

/datum/supply_pack/medical/radaway
	name = "Radaway"
	desc = "It burns like hell, but it flushes the rads out, for sure. About three."
	cost = 900
	contains = list(/obj/item/reagent_containers/blood/radaway,
					/obj/item/reagent_containers/blood/radaway,
					/obj/item/reagent_containers/blood/radaway,
					/obj/item/storage/pill_bottle/chem_tin/radx)
