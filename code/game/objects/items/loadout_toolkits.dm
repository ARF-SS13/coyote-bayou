/*
#define LOADOUT_FLAG_TOOL_WASTER (1<<5)

#define LOADOUT_CAT_WORKER "Worker Tools"
#define LOADOUT_CAT_ADVENTURE "Adventure Tools"
#define LOADOUT_CAT_MEDICAL "Medical Tools"
#define LOADOUT_CAT_SINISTER "Sinister Tools"
#define LOADOUT_CAT_OTHER "Other Things"
*/

/obj/item/kit_spawner/tools
	name = "tool kit"
	desc = "a sturdy bag keeping your tools of choice safe until you pop it open."
	icon = 'icons/obj/storage.dmi'
	icon_state = "backpack_enclave"
	item_state = "backpack_enclave"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	allowed_flags = LOADOUT_FLAG_TOOL_WASTER

/obj/item/storage/box/tools
	name = "bag of tools"
	desc = "a sturdy bag keeping your tools of choice safe until you pop it open."
	icon = 'icons/obj/storage.dmi'
	icon_state = "backpack_enclave"
	item_state = "backpack_enclave"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	component_type = /datum/component/storage/concrete/box

/obj/item/storage/box/tools/update_icon_state()
	if(contents.len == 0)
		qdel(src)

/obj/item/storage/box/tools/farming
	name = "farming tools"

/obj/item/storage/box/tools/farming/PopulateContents()
	new /obj/item/clothing/gloves/botanic_leather(src)
	new /obj/item/plant_analyzer(src)
	new /obj/item/shovel/spade(src)
	new /obj/item/cultivator(src)
	new /obj/item/reagent_containers/glass/bucket/plastic(src)
	new /obj/item/storage/bag/plants/portaseeder(src)
	new /obj/item/reagent_containers/glass/bottle/nutrient/ez(src)
	new /obj/item/reagent_containers/glass/bottle/nutrient/rh(src)

/datum/loadout_box/farming
	entry_tag = "farming tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/farming

/obj/item/storage/box/tools/ranching
	name = "riding tools"

/obj/item/storage/box/tools/ranching/PopulateContents()
	// new /obj/item/brahminbags(src)
	new /obj/item/brahmincollar(src)
	new /obj/item/brahminbridle(src)
	new /obj/item/brahminsaddle(src)
	new /obj/item/brahminbrand(src)
	new /obj/item/capturedevice(src)//hopefully this will make having a pet motorcycle a lot less annoying
	new /obj/item/choice_beacon/pet/mountable(src)

/datum/loadout_box/ranching
	entry_tag = "riding tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/ranching

/obj/item/storage/box/tools/groundskeeping
	name = "groundskeeping tools"

/obj/item/storage/box/tools/groundskeeping/PopulateContents()
	new /obj/item/storage/bag/trash(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/mop(src)
	new /obj/item/reagent_containers/glass/bucket/plastic(src)
	new /obj/item/broom(src)
	new /obj/item/lightreplacer(src)
	new /obj/item/clothing/shoes/galoshes(src)
	new /obj/item/soap(src)
	new /obj/item/paint/paint_remover(src)

/datum/loadout_box/groundskeeping
	entry_tag = "groundskeeping tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/groundskeeping

/obj/item/storage/box/tools/salvage
	name = "salvaging tools"

/obj/item/storage/box/tools/salvage/PopulateContents()
	new /obj/item/clothing/glasses/welding(src)
	new /obj/item/metaldetector(src)
	new /obj/item/shovel(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/storage/bag/salvage(src)

/datum/loadout_box/salvage
	entry_tag = "salvaging tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/salvage

/obj/item/storage/box/tools/mining
	name = "mining tools"

/obj/item/storage/box/tools/mining/PopulateContents()
	new /obj/item/pickaxe/drill(src)
	new /obj/item/pickaxe/mini(src)
	new /obj/item/t_scanner/adv_mining_scanner/lesser(src)
	new /obj/item/clothing/head/hardhat(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/storage/bag/ore(src)

/datum/loadout_box/mining
	entry_tag = "mining tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/mining
	
/obj/item/storage/box/tools/merchant
	name = "merchant tools"

/obj/item/storage/box/tools/merchant/PopulateContents()
	new /obj/item/stack/f13Cash/caps/twofive
	new /obj/item/stack/f13Cash/caps/fivezero
	new /obj/item/storage/box/vendingmachine


/datum/loadout_box/merchant
	entry_tag = "merchant tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/merchant

/obj/item/storage/box/tools/smithing
	name = "smithing tools"

/obj/item/storage/box/tools/smithing/PopulateContents()
	new /obj/item/clothing/gloves/f13/blacksmith(src)
	new /obj/item/clothing/suit/armor/outfit/overalls/blacksmith(src)
	new /obj/item/melee/smith/hammer/premade(src)
	new /obj/item/reagent_containers/glass/bottle/welding_fuel(src)
	new /obj/item/stack/sheet/metal/fifty(src)
	new /obj/item/stack/sheet/mineral/titanium/twentyfive(src)
	new /obj/item/stack/sheet/bronze/thirty(src)

/datum/loadout_box/smithing
	entry_tag = "smithing tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/smithing

/obj/item/storage/box/tools/chemist
	name = "chemistry tools"

/obj/item/storage/box/tools/chemist/PopulateContents() //no chem dispenser for now. and you'll have to do a lil work to set up your lab, find stock parts and such. might could expand on it for easiness
	new /obj/item/stock_parts/chem_cartridge/crafted(src)
	new /obj/item/circuitboard/machine/chem_master(src)
	new /obj/item/circuitboard/machine/chem_heater(src)
	new /obj/item/circuitboard/machine/reagentgrinder(src)
	new /obj/item/storage/bag/chemistry(src)
	new /obj/item/storage/blender_belt(src)
	new /obj/item/reagent_containers/glass/beaker/plastic(src)
	new /obj/item/reagent_containers/glass/beaker/plastic(src)
	new /obj/item/clothing/glasses/science(src)

/datum/loadout_box/chemist
	entry_tag = "chemistry tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_MEDICAL
	spawn_thing = /obj/item/storage/box/tools/chemist

/obj/item/storage/box/tools/surgery
	name = "surgery tools"

/obj/item/storage/box/tools/surgery/PopulateContents()
	new /obj/item/storage/backpack/duffelbag/med/surgery(src)
	new /obj/item/clothing/gloves/color/latex(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/stack/sheet/mineral/silver/two(src)
	new /obj/item/stack/rods/two(src)
	new /obj/item/tele_iv(src)
	new /obj/item/reagent_containers/blood/OMinus(src)

/datum/loadout_box/surgery
	entry_tag = "surgery tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_MEDICAL
	spawn_thing = /obj/item/storage/box/tools/surgery

/obj/item/storage/box/tools/triage
	name = "triage tools"

/obj/item/storage/box/tools/triage/PopulateContents() //your basic med supplies, for adventurers and doctors alike
	new /obj/item/storage/firstaid/ancient(src)
	new /obj/item/healthanalyzer(src)
	new /obj/item/clothing/gloves/color/latex(src)
	new /obj/item/reagent_containers/glass/bottle/salglu_solution(src)
	new /obj/item/reagent_containers/glass/bottle/salglu_solution(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak/epipak(src)

/datum/loadout_box/triage
	entry_tag = "triage tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_MEDICAL
	spawn_thing = /obj/item/storage/box/tools/triage

/obj/item/storage/box/tools/wealth
	name = "personal savings"

/obj/item/storage/box/tools/wealth/PopulateContents() //sellout.
	new /obj/item/stack/f13Cash/caps/onezerozero(src)

/datum/loadout_box/wealth
	entry_tag = "personal savings"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_OTHER
	spawn_thing = /obj/item/storage/box/tools/wealth

/datum/loadout_box/archeology
	entry_tag = "archeologist"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_OTHER
	spawn_thing = /obj/item/storage/belt/xenoarch/full

/obj/item/storage/box/tools/guns
	name = "weapon collection"

/obj/item/storage/box/tools/guns/PopulateContents() //moar guns
	new /obj/item/kit_spawner/townie(src)
	new /obj/item/kit_spawner/townie(src)
	new /obj/item/kit_spawner/townie(src)

/datum/loadout_box/guns
	entry_tag = "weapon collection"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/guns

/obj/item/storage/box/tools/settler
	name = "settler's tools"

/obj/item/storage/box/tools/settler/PopulateContents() //might need somethin more. these are easily attainable. second stack of metal helps tho
	new /obj/item/storage/toolbox/mechanical(src)
	new /obj/item/stack/sheet/mineral/wood/fifty(src)
	new /obj/item/stack/sheet/metal/fifty(src)
	new /obj/item/stack/sheet/metal/fifty(src)
	new /obj/item/toy/crayon/spraycan(src)
	new /obj/item/stack/sheet/glass/fifty(src)

/datum/loadout_box/settler
	entry_tag = "settler's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/settler

/obj/item/storage/box/tools/thief
	name = "thief's tools"

/obj/item/storage/box/tools/thief/PopulateContents()
	new /obj/item/clothing/gloves/thief(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/soap/homemade(src)
	new /obj/item/lockpick_set(src)
	new /obj/item/lockpick_set(src)

/datum/loadout_box/thief
	entry_tag = "thief's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/thief

/obj/item/storage/box/tools/stealth
	name = "stealth tools"

/obj/item/storage/box/tools/stealth/PopulateContents()
	new /obj/item/binoculars(src)
	new /obj/item/grenade/smokebomb(src)
	new /obj/item/stealthboy(src)
	new /obj/item/clothing/mask/chameleon(src)
	new /obj/item/lockpick_set(src)

/datum/loadout_box/stealth
	entry_tag = "stealth tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/stealth

/obj/item/storage/box/tools/entertainer //hybrid erp/musical
	name = "entertainer's tools"

/obj/item/storage/box/tools/entertainer/PopulateContents() //needs more substance and love. needs crocin in beaker form
	new /obj/item/choice_beacon/music(src)
	new /obj/item/musicaltuner(src)
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/reagent_containers/glass/bottle/chloralhydrate(src)
	new /obj/item/restraints/handcuffs/fake/kinky(src)
	new /obj/item/reagent_containers/food/snacks/grown/fever_blossom(src)

/datum/loadout_box/entertainer
	entry_tag = "entertainer's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/entertainer

/obj/item/storage/box/tools/radiation
	name = "radiation gear"

/obj/item/storage/box/tools/radiation/PopulateContents()
	new /obj/item/clothing/head/radiation(src)
	new /obj/item/clothing/suit/radiation(src)
	new /obj/item/geiger_counter(src)
	new /obj/item/storage/pill_bottle/chem_tin/radx(src)
	new /obj/item/storage/pill_bottle/chem_tin/radx(src)
	new /obj/item/reagent_containers/blood/radaway(src)
	new /obj/item/reagent_containers/syringe(src) //for applying the radaway
	new /obj/item/crafting/abraxo(src)
	new /obj/item/crafting/abraxo(src)

/datum/loadout_box/radiation
	entry_tag = "radiation gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/radiation

//your standardized adventuring kits. one useful item, some melee or ballistic armor, and a smol bit of triage gear
/obj/item/storage/box/tools/melee
	name = "melee gear"

/obj/item/storage/box/tools/melee/PopulateContents()
	new /obj/item/shield/riot/buckler/stop(src)
	new /obj/item/clothing/suit/armor/medium/vest/breastplate(src)
	new /obj/item/clothing/head/helmet/armyhelmet(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture/emergency/five(src)

/datum/loadout_box/melee
	entry_tag = "melee gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/melee

/obj/item/storage/box/tools/marksman
	name = "marksman gear"

/obj/item/storage/box/tools/marksman/PopulateContents()
	new /obj/item/clothing/suit/armor/medium/vest/flak(src)
	new /obj/item/clothing/head/flakhelm(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture/emergency/five(src)

/datum/loadout_box/marksman
	entry_tag = "marksman gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/marksman

/obj/item/storage/box/tools/energy
	name = "energy gear"

/obj/item/storage/box/tools/energy/PopulateContents()
	new /obj/item/circuitboard/machine/cell_charger(src)
	new /obj/item/clothing/suit/armor/medium/vest/flak(src)
	new /obj/item/clothing/head/flakhelm(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture/emergency/five(src)

/datum/loadout_box/energy
	entry_tag = "energy gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/energy

/obj/item/storage/box/tools/military
	name = "military gear"

/obj/item/storage/box/tools/military/PopulateContents()
	new /obj/item/grenade/f13/frag(src) //maaaybe a second frag
	new /obj/item/clothing/suit/armor/medium/combat/rusted(src)
	new /obj/item/clothing/head/helmet/f13/combat/rangerbroken(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture/emergency/five(src)

/datum/loadout_box/military
	entry_tag = "military gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/military

/obj/item/storage/box/tools/hunter
	name = "hunting gear"

/obj/item/storage/box/tools/hunter/PopulateContents()
	new /obj/item/storage/bag/plants(src)
	new /obj/item/melee/onehanded/knife/bowie(src) //skinnin knife
	new /obj/item/fishingrod(src) //mornin! nice day for fishin ain't it
	new /obj/item/binoculars(src)
	new /obj/item/reagent_containers/hypospray/medipen/stimpak(src)
	new /obj/item/stack/medical/suture/emergency/five(src)

/datum/loadout_box/hunter
	entry_tag = "hunting gear"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/hunter

/obj/item/storage/box/tools/trapper
	name = "trapper's tools"

/obj/item/storage/box/tools/trapper/PopulateContents()
	new /obj/item/reverse_bear_trap(src) //for all your trapping needs
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/storage/box/mousetraps(src)

/datum/loadout_box/tools
	entry_tag = "trapper's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/trapper

/obj/item/storage/box/tools/demolition
	name = "demolition ordnance"

/obj/item/storage/box/tools/demolition/PopulateContents() //many boom things
	new /obj/item/grenade/homemade/coffeepotbomb(src)
	new /obj/item/grenade/homemade/coffeepotbomb(src)
	new /obj/item/grenade/homemade/coffeepotbomb(src)
	new /obj/item/grenade/homemade/coffeepotbomb(src)
	new /obj/item/bottlecap_mine(src)
	new /obj/item/storage/box/dynamite_box(src)

/datum/loadout_box/demolition
	entry_tag = "demolition ordnance"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/demolition

/obj/item/storage/box/tools/pyrotechnics
	name = "pyrotechnic devices"

/obj/item/storage/box/tools/pyrotechnics/PopulateContents() //many boom things
	new /obj/item/clothing/suit/fire(src)
	new /obj/item/clothing/head/helmet/f13/firefighter(src)
	new /obj/item/grenade/homemade/firebomb(src)
	new /obj/item/grenade/homemade/firebomb(src)
	new /obj/item/grenade/homemade/firebomb(src)
	new /obj/item/grenade/homemade/firebomb(src)
	new /obj/item/shishkebabpack(src) //might be much for a roundstart iunno.
	new /obj/item/extinguisher/mini(src) //creator and destroyer of fire

/datum/loadout_box/pyrotechnics
	entry_tag = "pyrotechnic devices"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/pyrotechnics

/obj/item/storage/box/tools/drugs
	name = "drug stash"

/obj/item/storage/box/tools/drugs/PopulateContents() //moar drumgs
	new /obj/item/reagent_containers/pill/patch/psycho(src)
	new /obj/item/reagent_containers/pill/patch/psycho(src)
	new /obj/item/reagent_containers/pill/patch/turbo(src)
	new /obj/item/reagent_containers/pill/patch/medx(src)
	new /obj/item/reagent_containers/pill/patch/medx(src)
	new /obj/item/storage/pill_bottle/chem_tin/buffout(src)
	new /obj/item/reagent_containers/pill/patch/jet(src) //more than 7 objects, absolutely overflowing with drumgs
	new /obj/item/reagent_containers/pill/patch/jet(src)
	new /obj/item/reagent_containers/pill/patch/jet(src)
	new /obj/item/storage/pill_bottle/random(src)

/datum/loadout_box/drugs
	entry_tag = "drug stash"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/drugs

/obj/item/storage/box/tools/mancatcher
	name = "mancatcher tools" //for slavin'

/obj/item/storage/box/tools/mancatcher/PopulateContents()
	new /obj/item/melee/onehanded/slavewhip(src)
	new /obj/item/electropack/shockcollar(src)
	new /obj/item/electropack/shockcollar/explosive(src)
	new /obj/item/assembly/signaler(src)
	new /obj/item/restraints/legcuffs/bola(src)
	new /obj/item/restraints/legcuffs/bola(src)
	new /obj/item/restraints/handcuffs (src)
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/restraints/legcuffs(src)

/datum/loadout_box/mancatcher
	entry_tag = "mancatcher tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/mancatcher

/obj/item/storage/box/tools/kidnapper
	name = "kidnapper tools" //for napin'

/obj/item/storage/box/tools/kidnapper/PopulateContents()
	new /obj/item/melee/classic_baton/telescopic(src)
	new /obj/item/electropack/shockcollar(src)
	new /obj/item/jammer(src)
	new /obj/item/assembly/signaler(src)
	new /obj/item/restraints/handcuffs (src)
	new /obj/item/restraints/legcuffs/beartrap(src)
	new /obj/item/restraints/legcuffs(src)

/datum/loadout_box/kidnapper
	entry_tag = "kidnapper tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/kidnapper

/obj/item/storage/box/tools/quack
	name = "fake medical tools"

/obj/item/storage/box/tools/quack/PopulateContents()
	new /obj/item/storage/backpack/duffelbag/med/surgery(src)
	new /obj/item/storage/pill_bottle/aranesp(src)
	new /obj/item/storage/pill_bottle/happy(src)
	new /obj/item/reagent_containers/glass/bottle/chloralhydrate(src)
	new /obj/item/reagent_containers/syringe(src)
	new /obj/item/storage/pill_bottle/random(src)

/datum/loadout_box/quack
	entry_tag = "fake medical tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/quack

/obj/item/storage/box/tools/slave //soft implimentation of the ol slave roles. unsure if we need this
	name = "servant's tools"

/obj/item/storage/box/tools/slave/PopulateContents() //might need an expansion, don't get much beyond tools and collar rn...
	new /obj/item/electropack/shockcollar(src)
	new /obj/item/storage/belt/utility/waster(src)
	new /obj/item/assembly/signaler(src)
//	new /obj/item/clothing/under/f13/rag(src) //can add cosmetics if we really need, but they should be selectable in the character creator
//	new /obj/item/clothing/shoes/f13/rag(src)

/datum/loadout_box/slave
	entry_tag = "servant's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/slave

/obj/item/storage/box/tools/carp
	name = "carp cult tools"

/obj/item/storage/box/tools/carp/PopulateContents()
	new /obj/item/clothing/suit/hooded/carp_costume(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_carp(src)
	new /obj/item/nullrod/carp(src)
	new /obj/item/grenade/spawnergrenade/spesscarp(src)
	//new /obj/item/guardiancreator/carp(src) //is so tempting
	new /obj/item/toy/plush/carpplushie/dehy_carp(src)
	new /obj/item/toy/plush/carpplushie/dehy_carp(src)
	new /obj/item/toy/plush/carpplushie/dehy_carp(src)

/datum/loadout_box/carp
	entry_tag = "carp cult tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_SINISTER
	spawn_thing = /obj/item/storage/box/tools/carp

/obj/item/storage/box/tools/beastmaster
	name = "beastmaster's tools"

/obj/item/storage/box/tools/beastmaster/PopulateContents()
	new /obj/item/capturedevice(src)
	new	/obj/item/capturedevice(src)
	new /obj/item/lazarus_injector(src)
	new /obj/item/lazarus_injector(src)
	new /obj/item/lazarus_injector(src)

/datum/loadout_box/beastmaster
	entry_tag = "beastmaster's tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/beastmaster

/obj/item/storage/box/tools/animal
	name = "animal husbandry tools"

/obj/item/storage/box/tools/animal/PopulateContents()
	new /obj/item/stack/medical/gauze(src) //for healing your animals
	new /obj/item/choice_beacon/pet(src)
	new /obj/item/choice_beacon/pet(src)
	new /obj/item/choice_beacon/pet(src)
	new /obj/item/seeds/wheat(src)
	new /obj/item/seeds/wheat/oat(src)
	new /obj/item/pitchfork(src)

/datum/loadout_box/animal
	entry_tag = "animal husbandry tools"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_WORKER
	spawn_thing = /obj/item/storage/box/tools/animal

/datum/loadout_box/hunting_horn
	entry_tag = "hunting horn"
	entry_flags = LOADOUT_FLAG_TOOL_WASTER
	entry_class = LOADOUT_CAT_ADVENTURE
	spawn_thing = /obj/item/storage/box/tools/hunting_horn

/obj/item/storage/box/tools/hunting_horn/PopulateContents()
	new /obj/item/melee/onehanded/knife/hunting(src) //for hunting
	new /obj/item/huntinghorn/offense(src) //for horn
	new /obj/item/huntinghorn/defense(src) //for horn
	new /obj/item/huntinghorn/utility(src) //for horn
	new /obj/item/huntinghorn/healing(src) //for horn
	new /obj/item/bikehorn(src) //for HONK 

