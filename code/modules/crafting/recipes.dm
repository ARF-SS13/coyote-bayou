
/datum/crafting_recipe
	var/name = "" //in-game display name
	var/reqs[] = list() //type paths of items consumed associated with how many are needed
	var/result //type path of item resulting from this craft
	var/tools[] = list() //type paths of items needed but not consumed
	var/traits[] = list() //type paths of traits needed, hopefully
	var/time = 30 //time in deciseconds
	var/parts[] = list() //type paths of items that will be placed in the result
	var/chem_catalysts[] = list() //like tools but for reagents
	var/category = CAT_NONE //where it shows up in the crafting UI
	var/subcategory = CAT_NONE
	var/gunsmith_one_req = FALSE
	var/gunsmith_two_req = FALSE
	var/gunsmith_three_req = FALSE
	var/gunsmith_four_req = FALSE

/*
---Fallout 13 Crafting
*/


/datum/crafting_recipe/workbench
	name = "workbench"
	result = /obj/machinery/workbench
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/lighter = 1,
				/obj/item/reagent_containers/glass/beaker = 1,
				/obj/item/screwdriver = 1,
				/obj/item/crowbar = 1,
				/obj/item/wrench = 1,
				/obj/item/wirecutters = 1,
				/obj/item/stack/crafting/metalparts = 5)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/stove
	name = "cook stove"
	result = /obj/machinery/microwave/stove
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/cable_coil = 2,
				/obj/item/assembly/igniter = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/bellystove
	name = "pot belly stove"
	result = /obj/structure/campfire/stove
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_WELDER, TOOL_WORKBENCH)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/trading_machine
	name = "vending machine"
	result = /obj/machinery/trading_machine
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/cable_coil = 10)
	tools = list(TOOL_WELDER, TOOL_WORKBENCH, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/dildo_plastic
    name = "plastic dildo"
    result = /obj/item/dildo
    reqs = list(/obj/item/stack/sheet/plastic)
    time = 20
    tools = list(TOOL_WELDER, TOOL_WORKBENCH)
    category = CAT_MISC
    subcategory = CAT_MISC

/datum/crafting_recipe/dildo_tribal
    name = "wooden dildo"
    result = /obj/item/dildo/wooden
    reqs = list(/obj/item/stack/sheet/mineral/wood = 3)
    tools = list(TOOL_KNIFE)
    time = 85
    category = CAT_MISC
    subcategory = CAT_MISC

/datum/crafting_recipe/campfirekit
	name = "campfire kit"
	result = /obj/item/crafting/campfirekit
	reqs = list(/obj/item/stack/sheet/mineral/wood = 15)
	time = 80
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/setupcampfirekit
	name = "set up campfire kit"
	result = /obj/structure/campfire
	reqs = list(/obj/item/crafting/campfirekit = 1)
	time = 40
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/shower
	name = "shower"
	result = /obj/machinery/shower
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10)
	tools = list(TOOL_WRENCH, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/grill
	name = "grill"
	result = /obj/machinery/grill
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 5)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/barrelfire
	name = "stoke barrel fire"
	result = /obj/structure/campfire/barrel
	reqs = list(/obj/item/stack/sheet/mineral/wood = 15,
				/obj/item/stack/sheet/metal = 10)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/pin_removal
	name = "Pin Removal"
	result = /obj/item/gun
	reqs = list(/obj/item/gun = 1)
	parts = list(/obj/item/gun = 1)
	tools = list(TOOL_WORKBENCH)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/IED
	name = "IED"
	result = /obj/item/grenade/iedcasing
	reqs = list(/datum/reagent/fuel = 50,
				/obj/item/stack/cable_coil = 1,
				/obj/item/assembly/igniter = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 15
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/molotov
	name = "Molotov"
	result = /obj/item/reagent_containers/food/drinks/bottle/molotov
	reqs = list(/obj/item/reagent_containers/glass/rag = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1)
	parts = list(/obj/item/reagent_containers/food/drinks/bottle = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/bola
	name = "Bola"
	result = /obj/item/restraints/legcuffs/bola
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/stack/sheet/metal = 6)
	time = 20//15 faster than crafting them by hand!
	category= CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/USAeyebot
	name = "Propaganda eyebot"
	result = /mob/living/simple_animal/pet/dog/eyebot
	reqs = list(/obj/item/stack/crafting/electronicparts = 5,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 2)
	tools = list(TOOL_WORKBENCH)
	time = 40
	category = CAT_ASSEM
	subcategory = CAT_ROBOT

/datum/crafting_recipe/needlerammo
	name = "needler stripper clip (needle darts)"
	result = /obj/item/ammo_box/needle
	reqs = list(/obj/item/stack/crafting/metalparts = 3)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/needlerammoap
	name = "armour-piercing needler stripper clip (needle darts)"
	result = /obj/item/ammo_box/needleap
	reqs = list(/obj/item/stack/crafting/goodparts = 3)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/speedloader38
	name = "empty speed loader (.38)"
	result = /obj/item/ammo_box/c38/empty
	reqs = list(/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/mg34mag
	name = "empty machine gun magazine (7.62)"
	result = /obj/item/ammo_box/magazine/mg34/empty
	reqs = list(/obj/item/stack/sheet/metal = 4)
	tools = list(TOOL_WORKBENCH)
	time = 10
	traits = list(TRAIT_GUNSMITH_FOUR)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER4)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/cell
	name = "Power Cell"
	result = /obj/item/stock_parts/cell
	reqs = list(/obj/item/stack/crafting/electronicparts = 1,
				/obj/item/stack/sheet/glass = 5,
				/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FOUR

/datum/crafting_recipe/ec
	name = "Small Energy Cell"
	result = /obj/item/stock_parts/cell/ammo/ec
	reqs = list(/obj/item/stock_parts/capacitor=2)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FOUR

/datum/crafting_recipe/mfc
	name = "Microfusion Cell"
	result = /obj/item/stock_parts/cell/ammo/mfc
	reqs = list(/obj/item/stack/crafting/goodparts=2, /obj/item/stock_parts/capacitor=3)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FOUR

/datum/crafting_recipe/ecp
	name = "Electron Charge Pack"
	result = /obj/item/stock_parts/cell/ammo/ecp
	reqs = list(/obj/item/stack/crafting/goodparts=3, /obj/item/stock_parts/capacitor=5)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FOUR

/datum/crafting_recipe/speedloader10mm
	name = "empty speed loader (10mm)"
	result = /obj/item/ammo_box/l10mm/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/speedloader44
	name = "empty speed loader (.44)"
	result = /obj/item/ammo_box/m44/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/speedloader4570
	name = "empty speed loader (.45-70)"
	result = /obj/item/ammo_box/c4570/empty
	reqs = list(/obj/item/stack/sheet/metal = 4)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/tube44
	name = "empty speed loader tube (.44)"
	result = /obj/item/ammo_box/tube/m44/empty
	reqs = list(/obj/item/stack/sheet/metal = 3)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/batterybox //lasmusket ammo
	name = "Laser Musket battery pack"
	result = /obj/item/ammo_box/lasmusket
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/sheet/glass = 6,
				/obj/item/stack/sheet/metal = 6)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 20
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/tube357
	name = "empty speed loader tube (.357)"
	result = /obj/item/ammo_box/tube/a357/empty
	reqs = list(/obj/item/stack/sheet/metal = 3)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/tube4570
	name = "empty speed loader tube (.45-70)"
	result = /obj/item/ammo_box/tube/c4570/empty
	reqs = list(/obj/item/stack/sheet/metal = 6)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/autoriflemag
	name = "empty auto pipe rifle magazine (.38/.357)"
	result = /obj/item/ammo_box/magazine/autopipe/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m10mm_auto
	name = "empty 10mm submachine gun magazine (10mm)"
	result = /obj/item/ammo_box/magazine/m10mm_auto/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/greasegunmag
	name = "empty grease submachine gun magazine (.45)"
	result = /obj/item/ammo_box/magazine/greasegun/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/mini_uzimag
	name = "empty mini uzi magazine (9mm)"
	result = /obj/item/ammo_box/magazine/uzim9mm/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/d12g
	name = "empty shotgun drum magazine (12g)"
	result = /obj/item/ammo_box/magazine/d12g/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/riflesmall556
	name = "empty small rifle magazine (5.56mm)"
	result = /obj/item/ammo_box/magazine/m556/rifle/small/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/rifle556
	name = "empty 20rd rifle magazine (5.56mm)"
	result = /obj/item/ammo_box/magazine/m556/rifle/empty
	reqs = list(/obj/item/stack/sheet/metal = 3)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/rifleassault556
	name = "empty 30rd rifle magazine (5.56mm)"
	result = /obj/item/ammo_box/magazine/m556/rifle/assault/empty
	reqs = list(/obj/item/stack/sheet/metal = 4)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/rifleextended556
	name = "empty extended rifle magazine (5.56mm)"
	result = /obj/item/ammo_box/magazine/m556/rifle/extended/empty
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER4)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m45
	name = "empty handgun magazine (.45)"
	result = /obj/item/ammo_box/magazine/m45/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m50
	name = "empty handgun magazine (.50 AE)"
	result = /obj/item/ammo_box/magazine/a50/empty
	reqs = list(/obj/item/stack/sheet/metal = 3)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m10mm_adv
	name = "empty 10mm pistol magazine (10mm)"
	result = /obj/item/ammo_box/magazine/m10mm_adv/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m9mm
	name = "empty 9mm pistol magazine (9mm)"
	result = /obj/item/ammo_box/magazine/m9mm/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/enbloc
	name = "empty en-bloc clip (7.62x51mm)"
	result = /obj/item/ammo_box/magazine/garand308/empty
	reqs = list(/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER4)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m762
	name = "empty rifle magazine (7.62x51/.308)"
	result = /obj/item/ammo_box/magazine/m762/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/m762ext
	name = "empty extended rifle magazine (7.62x51.308)"
	result = /obj/item/ammo_box/magazine/m762/ext/empty
	reqs = list(/obj/item/stack/sheet/metal = 4)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER4)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/mSniperRifle
	name = "empty sniper rifle magazine (7.62x51/.308)"
	result = /obj/item/ammo_box/magazine/w308/empty
	reqs = list(/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_ONE

/datum/crafting_recipe/c45
	name = ".45 FMJ ammo box"
	result = /obj/item/ammo_box/c45
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c45jhp
	name = ".45 JHP ammo box"
	result = /obj/item/ammo_box/c45/jhp
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/m44
	name = ".44 Magnum FMJ ammo box"
	result = /obj/item/ammo_box/m44box
	reqs = list(/obj/item/stack/sheet/metal = 7,
				/datum/reagent/blackpowder = 35)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/m44jhp
	name = ".44 Magnum JHP ammo box"
	result = /obj/item/ammo_box/m44box/jhp
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/datum/reagent/blackpowder = 35)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/a357
	name = ".357 Magnum FMJ ammo box"
	result = /obj/item/ammo_box/a357box
	reqs = list(/obj/item/stack/sheet/metal = 8,
				/datum/reagent/blackpowder = 35)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/a357jhp
	name = ".357 Magnum JHP ammo box"
	result = /obj/item/ammo_box/a357box
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/datum/reagent/blackpowder = 35)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c38
	name = ".38 special ammo box"
	result = /obj/item/ammo_box/box38
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c4570
	name = ".45-70 FMJ ammo box"
	result = /obj/item/ammo_box/c4570box
	reqs = list(/obj/item/stack/sheet/metal = 8,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/c4570jhp
	name = ".45-70 JHP ammo box"
	result = /obj/item/ammo_box/c4570box/jhp
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a50mg
	name = ".50 MG (rifle) ammo box"
	result = /obj/item/ammo_box/a50MGbox
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/datum/reagent/blackpowder = 50)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/minieball
	name = "Box of musket catridges"
	result = /obj/item/ammo_box/musketbag
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/datum/reagent/blackpowder = 30)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a50ae
	name = ".50 AE (pistol) ammo box"
	result = /obj/item/ammo_box/a50AEbox
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/datum/reagent/blackpowder = 50)
	traits = list(TRAIT_GUNSMITH_THREE)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c10mm
	name = "10mm FMJ ammo box"
	result = /obj/item/ammo_box/c10mm
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c10mmjhp
	name = "10mm JHP ammo box"
	result = /obj/item/ammo_box/c10mm/jhp
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c10mmap
	name = "10mm AP ammo box"
	result = /obj/item/ammo_box/c10mm/ap
	reqs = list(/obj/item/stack/sheet/metal = 7,
				/datum/reagent/blackpowder = 30)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/magnumshot
	name = "magnum buckshot shotgun box"
	result = /obj/item/storage/box/magnumshot
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/datum/reagent/blackpowder = 35)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/lethalshot
	name = "buckshot shotgun box"
	result = /obj/item/storage/box/lethalshot
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/datum/reagent/blackpowder = 25)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/slugshot
	name = "slug shotgun box"
	result = /obj/item/storage/box/slugshot
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/datum/reagent/blackpowder = 25)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/beanbag
	name = "beanbag shotgun box"
	result = /obj/item/storage/box/rubbershot/beanbag
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/datum/reagent/blackpowder = 15)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/rubbershot
	name = "rubbershot shotgun box"
	result = /obj/item/storage/box/rubbershot
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/datum/reagent/blackpowder = 15)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/a556
	name = "5.56mm FMJ ammo box"
	result = /obj/item/ammo_box/a556
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a556jhp
	name = "5.56mm JHP ammo box"
	result = /obj/item/ammo_box/a556/jhp
	reqs = list(/obj/item/stack/sheet/metal = 8,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a556ap
	name = "5.56 AP ammo box"
	result = /obj/item/ammo_box/a556/ap
	reqs = list(/obj/item/stack/sheet/metal = 12,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a556sport
	name = "5.56 match ammo box"
	result = /obj/item/ammo_box/a556/sport
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/datum/reagent/blackpowder = 40)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/c9mm
	name = "9mm FMJ ammo box"
	result = /obj/item/ammo_box/c9mm
	reqs = list(/obj/item/stack/sheet/metal = 8,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c9mmjhp
	name = "9mm JHP ammo box"
	result = /obj/item/ammo_box/c9mm/jhp
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/c9mmap
	name = "9mm AP ammo box"
	result = /obj/item/ammo_box/c9mm/ap
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_TWO

/datum/crafting_recipe/a762
	name = "7.62mm FMJ ammo box"
	result = /obj/item/ammo_box/a762box
	reqs = list(/obj/item/stack/sheet/metal = 8,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a762jhp
	name = "7.62mm JHP ammo box"
	result = /obj/item/ammo_box/a762box/jhp
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a762ap
	name = "7.62mm AP ammo box"
	result = /obj/item/ammo_box/a762box/ap
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_TWO)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	time = 10
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/a308
	name = ".308 ammo box"
	result = /obj/item/ammo_box/a308box
	reqs = list(/obj/item/stack/sheet/metal = 7,
				/datum/reagent/blackpowder = 40)
	traits = list(TRAIT_GUNSMITH_ONE)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_THREE

/datum/crafting_recipe/twohanded/spear
	name = "Spear"
	result = /obj/item/twohanded/spear
	reqs = list(/obj/item/restraints/handcuffs/cable = 1,
				/obj/item/shard = 1,
				/obj/item/stack/rods = 1)
	time = 40
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
/*
/datum/crafting_recipe/kittyears
	name = "Kitty Ears"
	result = /obj/item/clothing/head/kitty/genuine
	time = 10
	reqs = list(/obj/item/organ/tail/cat = 1,
				/obj/item/organ/ears/cat = 1)
	category = CAT_MISC
	subcategory = CAT_MISC
*/
/*
/datum/crafting_recipe/skateboard
	name = "Skateboard"
	result = /obj/vehicle/ridden/scooter/skateboard
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/rods = 10)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/scooter
	name = "Scooter"
	result = /obj/vehicle/ridden/scooter
	time = 65
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/rods = 12)
	category = CAT_MISC
	subcategory = CAT_MISC
*/
/datum/crafting_recipe/papersack
	name = "Paper Sack"
	result = /obj/item/storage/box/papersack
	time = 10
	reqs = list(/obj/item/paper = 5)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/flashlight_eyes
	name = "Flashlight Eyes"
	result = /obj/item/organ/eyes/robotic/flashlight
	time = 10
	reqs = list(
		/obj/item/flashlight = 2,
		/obj/item/restraints/handcuffs/cable = 1
	)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/paperframes
	name = "Paper Frames"
	result = /obj/item/stack/sheet/paperframes/five
	time = 10
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5, /obj/item/paper = 20)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/naturalpaper
	name = "Hand-Pressed Paper"
	time = 30
	reqs = list(/datum/reagent/water = 50, /obj/item/stack/sheet/mineral/wood = 1)
	tools = list(/obj/item/hatchet)
	result = /obj/item/paper_bin/bundlenatural
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/blackcarpet
	name = "Black Carpet"
	reqs = list(/obj/item/stack/tile/carpet = 50, /obj/item/toy/crayon/black = 1)
	result = /obj/item/stack/tile/carpet/black/fifty
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/showercurtain
	name = "Shower Curtains"
	reqs = 	list(/obj/item/stack/sheet/cloth = 2, /obj/item/stack/sheet/plastic = 2, /obj/item/stack/rods = 1)
	result = /obj/structure/curtain
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

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
	subcategory = CAT_WEAPON

/*/datum/crafting_recipe/chemical_payload2
	name = "Chemical Payload (Gibtonite)"
	result = /obj/item/bombcore/chemical
	reqs = list(
		/obj/item/stock_parts/matter_bin = 1,
		/obj/item/twohanded/required/gibtonite = 1,
		/obj/item/grenade/chem_grenade = 2
	)
	parts = list(/obj/item/stock_parts/matter_bin = 1, /obj/item/grenade/chem_grenade = 2)
	time = 50
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON*/

/datum/crafting_recipe/scavengerod
	name = "Scavenge For Rods"
	result = /obj/item/stack/rods
	time = 600
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/scavengemetal
	name = "Scavenge For Plating"
	result = /obj/item/stack/sheet/metal
	time = 600
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/bonearmor
	name = "Bone Armor"
	result = /obj/item/clothing/suit/armor/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/chitinarmor
	name = "Insect Chitin Armor"
	result = /obj/item/clothing/suit/armor/f13/chitinarmor
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/chitin = 12,
				/obj/item/stack/sheet/sinew = 4,
				/obj/item/stack/sheet/cloth = 4)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/animalhide/deathclaw = 1) //changed from goliath to deathclaw
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/skullhelm
	name = "Skull Helmet"
	result = /obj/item/clothing/head/helmet/skull
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bonedagger
	name = "Bone Dagger"
	result = /obj/item/kitchen/knife/combat/bone
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bonespear
	name = "Bone Spear"
	result = /obj/item/twohanded/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				 /obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS
/*
/datum/crafting_recipe/viperspear
	name = "Viper Spear"
	result = /obj/item/twohanded/bonespear/venom
	time = 45
	reqs = list(/obj/item/twohanded/bonespear = 1,
				/obj/item/viper_venom = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/viperrecycle //an empty viper spear can already be used to make new bone spears, but I still like this idea
	name = "Recycled Viper Spear"
	result = /obj/item/twohanded/bonespear
	time = 25
	reqs = list(/obj/item/twohanded/bonespear/venom = 1,
				/obj/item/stack/sheet/bone = 2)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL
*/
/datum/crafting_recipe/boneaxe
	name = "Bone Axe"
	result = /obj/item/twohanded/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				 /obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/bonepestle
	name = "Bone Pestle"
	result = /obj/item/pestle
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/bonemortar
	name = "Bone Mortar"
	result = /obj/item/reagent_containers/glass/mortar
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 3)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/tribal_torch
	name = "Tribal Torch"
	result = /obj/item/candle/tribal_torch
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 4)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/handheld_torch
	name = "Handheld Torch"
	result = /obj/item/flashlight/flare/torch
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3,
				/obj/item/stack/sheet/cloth = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/headpike
	name = "Spike Head (Glass Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/headpikebone
	name = "Spike Head (Bone Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/bonespear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/bonespear = 1)
	result = /obj/structure/headpike/bone
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/headpikelegion
	name = "Spike Head (Throwing Spear)"
	time = 65
	reqs = list(/obj/item/throwing_star/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/throwing_star/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/goliathcloak
	name = "Deathclaw cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/deathclaw = 4)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/tatteredredcloak
	name = "Tattered red cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/stack/sheet/cloth = 2)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/talisman
	name = "Hunter's talisman"
	result = /obj/item/clothing/neck/cloak/amulet
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/cloakbrown
	name = "Cloak"
	result = /obj/item/clothing/neck/cloak
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/cloakdark
	name = "Dark Cloak"
	result = /obj/item/clothing/neck/cloak/grey
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/smallcarton
	name = "Small Carton"
	result = /obj/item/reagent_containers/food/drinks/sillycup/smallcarton
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/pressureplate
	name = "Pressure Plate"
	result = /obj/item/pressure_plate
	time = 5
	reqs = list(/obj/item/stack/sheet/metal = 1,
				  /obj/item/stack/tile/plasteel = 1,
				  /obj/item/stack/cable_coil = 2,
				  /obj/item/assembly/igniter = 1)
	category = CAT_ASSEM
	subcategory = CAT_MACHINES


/*/datum/crafting_recipe/rcl
	name = "Makeshift Rapid Cable Layer"
	result = /obj/item/twohanded/rcl/ghetto
	time = 40
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER, TOOL_WRENCH)
	reqs = list(/obj/item/stack/sheet/metal = 15)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/guillotine
	name = "Guillotine"
	result = /obj/structure/guillotine
	time = 150 // Building a functioning guillotine takes time
	reqs = list(/obj/item/stack/sheet/plasteel = 3,
		        /obj/item/stack/sheet/mineral/wood = 20,
		        /obj/item/stack/cable_coil = 10)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH, TOOL_WELDER)
	category = CAT_MISC
	subcategory = CAT_MISC*/

/datum/crafting_recipe/binoculars
	name = "Binoculars"
	result = /obj/item/binoculars
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/glass = 5)
	tools = list(TOOL_SCREWDRIVER,TOOL_WORKBENCH)
	category = CAT_MISC
	subcategory = CAT_MISC

/*/datum/crafting_recipe/spooky_camera
	name = "Camera Obscura"
	result = /obj/item/camera/spooky
	time = 15
	reqs = list(/obj/item/camera = 1,
				/datum/reagent/water/holywater = 10)
	parts = list(/obj/item/camera = 1)
	category = CAT_MISC
	subcategory = CAT_MISC*/

//drugs
/datum/crafting_recipe/jet
	name = "Jet"
	result = /obj/item/reagent_containers/pill/patch/jet
	reqs = list(/datum/reagent/consumable/milk = 10, /obj/item/clothing/mask/cigarette = 3, /obj/item/toy/crayon/spraycan)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	subcategory = CAT_DRUGS

/datum/crafting_recipe/psycho
	name = "Psycho"
	result = /obj/item/reagent_containers/hypospray/medipen/psycho
	time = 20
	reqs = list(/obj/item/reagent_containers/syringe = 1, /obj/item/reagent_containers/food/snacks/grown/feracactus = 2, /obj/item/reagent_containers/food/snacks/grown/fungus = 2, /datum/reagent/consumable/nuka_cola = 5)
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	subcategory = CAT_DRUGS

/datum/crafting_recipe/medx
	name = "med-x"
	result = /obj/item/reagent_containers/syringe/medx
	time = 20
	reqs = list(/obj/item/reagent_containers/syringe = 1, /obj/item/reagent_containers/food/snacks/grown/feracactus = 2, /obj/item/reagent_containers/food/snacks/grown/agave = 1, /datum/reagent/consumable/ethanol/whiskey = 10)
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	subcategory = CAT_DRUGS

/datum/crafting_recipe/rags
	name = "Cut clothing into rags"
	result = /obj/item/stack/sheet/cloth/three
	reqs = list(/obj/item/clothing/under = 1)
	time = 20
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/healpowder
	name = "Healing powder"
	result = /obj/item/reagent_containers/pill/patch/healingpowder
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2)
	time = 50
	category = CAT_MEDICAL
	subcategory = CAT_MEDS

/datum/crafting_recipe/healpoultice
	name = "Healing poultice"
	result = /obj/item/reagent_containers/pill/patch/healpoultice
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/fungus = 1)
	time = 80
	category = CAT_MEDICAL
	subcategory = CAT_MEDS


/datum/crafting_recipe/stimpak
	name = "Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/broc = 2,
				/obj/item/reagent_containers/food/snacks/grown/xander = 2,
				/obj/item/reagent_containers/syringe = 1)
	tools = list(TOOL_WORKBENCH)
	time = 50
	category = CAT_MEDICAL
	subcategory = CAT_MEDS


/datum/crafting_recipe/superstimpak
	name = "Super Stimpak"
	result = /obj/item/reagent_containers/hypospray/medipen/stimpak/super
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2)
	tools = list(TOOL_WORKBENCH)
	time = 80
	category = CAT_MEDICAL
	subcategory = CAT_MEDS

/datum/crafting_recipe/salvage_stimpak
	name = "Salvage injector"
	result = /obj/item/reagent_containers/syringe
	reqs = list(/obj/item/reagent_containers/hypospray/medipen/stimpak = 1)
	time = 20
	tools = list(TOOL_WORKBENCH)
	category = CAT_MEDICAL
	subcategory = CAT_MEDS

/datum/crafting_recipe/slavecollar
	name = "Slave Collar"
	result = /obj/item/assembly/signaler/electropack/shockcollar
	reqs = list(/obj/item/clothing/neck/petcollar = 1,
				/obj/item/assembly/signaler = 1,
				/obj/item/assembly/igniter =1)
	time = 40
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/mop
	name = "Mop"
	result = /obj/item/mop
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/reagent_containers/glass/rag = 1)
	time = 30
	category = CAT_MISC
	subcategory = CAT_MISC

/*/datum/crafting_recipe/reversebeartrap
	name = "Reverse Bear Trap"
	result = /obj/item/reverse_bear_trap
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/crafting/timer = 1)
	tools = list(TOOL_SCREWDRIVER, TOOL_WRENCH)
	time = 60
	category = CAT_ASSEM*/

/datum/crafting_recipe/whip
	name = "Leather whip"
	result = /obj/item/melee/curator_whip
	reqs = list(/obj/item/stack/sheet/leather = 3)
	time = 60
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//F13
///ASSEMBLY ITEMS
/datum/crafting_recipe/mousetrap
	name = "Mousetrap"
	result = /obj/item/assembly/mousetrap
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/igniter
	name = "Igniter"
	result = /obj/item/assembly/igniter
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/health_sensor
	name = "Health sensor"
	result = /obj/item/assembly/health
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/timer
	name = "Timer"
	result = /obj/item/assembly/timer
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/signaler
	name = "Remote signaling device"
	result = /obj/item/assembly/signaler
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1,
				/obj/item/stack/cable_coil = 2)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/infrared
	name = "Infrared emitter"
	result = /obj/item/assembly/infra
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

/datum/crafting_recipe/proximity
	name = "Proximity sensor"
	result = /obj/item/assembly/prox_sensor
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/rods = 1)
	time = 10
	category = CAT_ASSEM
	subcategory = CAT_ASSEMBLIES

///Medical
/datum/crafting_recipe/healthanalyzer
	name = "Health analyzer"
	result = /obj/item/healthanalyzer
	reqs = list(/obj/item/stack/sheet/glass = 1,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/assembly/infra = 1,
				/obj/item/assembly/health = 1)
	tools = list(TOOL_WELDER, TOOL_SCREWDRIVER)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/beaker
	name = "Beaker"
	result = /obj/item/reagent_containers/glass/beaker
	reqs = list(/obj/item/stack/sheet/glass = 2)
	tools = list(TOOL_WELDER)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/beaker_large
	name = "Large beaker"
	result = /obj/item/reagent_containers/glass/beaker/large
	reqs = list(/obj/item/stack/sheet/glass = 6)
	tools = list(TOOL_WELDER)
	time = 40
	category = CAT_MEDICAL

/datum/crafting_recipe/syringe
	name = "Syringe"
	result = /obj/item/reagent_containers/syringe
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/glass = 1)
	tools = list(TOOL_WIRECUTTER)
	time = 10
	category = CAT_MEDICAL

/datum/crafting_recipe/solids
	name = "Solid beaker"
	result = /obj/item/reagent_containers/glass/beaker/solids
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WELDER)
	time = 30
	category = CAT_MEDICAL

/datum/crafting_recipe/Bowl
	name = "Glass Bowl"
	result = /obj/item/reagent_containers/glass/bowl
	reqs = list(/obj/item/stack/sheet/glass = 2)
	tools = list(TOOL_WELDER)
	time = 10
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/spray
	name = "Abraxo Cleaner"
	result = /obj/item/reagent_containers/spray/cleaner
	reqs = list(/obj/item/stack/sheet/glass = 2,
				/obj/item/crafting/abraxo = 1,
				/datum/reagent/water = 50)
	tools = list(TOOL_WELDER)
	time = 10
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/headset
	name = "radio headset"
	result = /obj/item/radio/headset
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/crafting/electronicparts = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/throwingknife
	name = "Throwing Knife"
	result = /obj/item/throwing_star/throwingknife
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WELDER)
	time = 30
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON


/datum/crafting_recipe/handheldradio
	name = "handheld radio"
	result = /obj/item/radio/off
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/crafting/electronicparts = 1)
	time = 10
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/salvagedpaconversion
	name = "Salvaged NCR Power Armor"
	result = /obj/item/clothing/suit/armor/f13/power_armor/ncr
	reqs = list(/obj/item/clothing/suit/armor/f13/power_armor/t45b = 1,
				/obj/item/toy/crayon/spraycan)
	time = 30
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

/datum/crafting_recipe/salvagedpaconversion2
	name = "Salvaged Power Armor"
	result = /obj/item/clothing/suit/armor/f13/power_armor/t45b
	reqs = list(/obj/item/clothing/suit/armor/f13/power_armor/ncr = 1,
				/obj/item/toy/crayon/spraycan)
	time = 30
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

/datum/crafting_recipe/suppressor
	name = "Suppressor"
	result = /obj/item/suppressor
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/plastic = 2,
				/obj/item/crafting/duct_tape = 1)
	tools = list(TOOL_WELDER)
	time = 30
	category  = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/zipgun
	name = "zip gun"
	result = /obj/item/gun/ballistic/revolver/zipgun
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
	/datum/reagent/blackpowder = 1,
				/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
/*
/datum/crafting_recipe/n99
	name = "10mm pistol"
	result = /obj/item/gun/ballistic/automatic/pistol/n99
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 10,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/datum/crafting_recipe/colt6520
	name = "colt 6520"
	result = /obj/item/gun/ballistic/revolver/colt6520
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 5,
				/datum/reagent/blackpowder = 10,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/ninemil
	name = "9mm pistol"
	result = /obj/item/gun/ballistic/automatic/pistol/ninemil
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 1,
				/datum/reagent/blackpowder = 10,
				/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/m1911
	name = "M1911"
	result = /obj/item/gun/ballistic/automatic/pistol/m1911
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/datum/reagent/blackpowder = 10,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/sledgehammer
	name = "sledgehammer"
	result = /obj/item/twohanded/sledgehammer
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/sheet/metal = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/* CRAFT rework: removed for balance
/datum/crafting_recipe/deagle
	name = "desert eagle"
	result = /obj/item/gun/ballistic/automatic/pistol/deagle
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/datum/reagent/blackpowder = 15,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/thatgun
	name = ".556 pistol"
	result = /obj/item/gun/ballistic/revolver/thatgun
	reqs = list(/obj/item/gun/ballistic/shotgun/remington = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/mineral/titanium = 1,
				/datum/reagent/blackpowder = 15,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/thatgun, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/needler
	name = "needler pistol"
	result = /obj/item/gun/ballistic/revolver/needler
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/mineral/titanium = 3,
				/datum/reagent/blackpowder = 5,
				/obj/item/stack/sheet/metal = 4)
	tools = list(TOOL_AWORKBENCH, /obj/item/blueprint/weapon/needler, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/

/datum/crafting_recipe/piperifle
	name = "pipe rifle"
	result = /obj/item/gun/ballistic/revolver/pipe_rifle
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
	/datum/reagent/blackpowder = 1,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/autopiperifle
	name = "auto pipe rifle"
	result = /obj/item/gun/ballistic/automatic/autopipe
	reqs = list(/datum/reagent/blackpowder = 30,
	/obj/item/stack/sheet/metal = 5,
	/obj/item/stack/sheet/mineral/wood = 5)
	tools = list(TOOL_WORKBENCH,TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/lasmusket
	name = "Laser Musket"
	result = /obj/item/gun/ballistic/shotgun/lasmusket
	reqs = list(/obj/item/stack/crafting/electronicparts = 2,
	/obj/item/gun/ballistic/revolver/pipe_rifle = 1,
	/obj/item/reagent_containers/food/drinks/bottle/f13nukacola = 1,
	/obj/item/stack/cable_coil = 3)
	tools = list(TOOL_WORKBENCH, TOOL_MULTITOOL)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/musket
	name = "Rifled Musket"
	result = /obj/item/gun/ballistic/shotgun/musket
	reqs = list(/obj/item/stack/crafting/metalparts = 5,
	/obj/item/stack/sheet/mineral/wood = 2,
	/obj/item/stack/sheet/metal = 10,
	/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/huntingrifle
	name = "hunting rifle"
	result = /obj/item/gun/ballistic/shotgun/remington
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/datum/reagent/blackpowder = 20,
				/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/*/datum/crafting_recipe/huntingrifle_scoped
	name = "scoped hunting rifle"
	result = /obj/item/gun/ballistic/shotgun/remington/scoped
	reqs = list(/obj/item/gun/ballistic/shotgun/remington = 1,
				/obj/item/binoculars,
				/obj/item/stack/crafting/metalparts = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/* CRAFT rework: removed for balance
/datum/crafting_recipe/m1garand
	name = "M1 Garand"
	result = /obj/item/gun/ballistic/automatic/m1garand
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/crafting/goodparts = 2,
				/datum/reagent/blackpowder = 25,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/m1garand, TOOL_GUNTIER4)
	traits = list(TRAIT_GUNSMITH_FOUR)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//*
/datum/crafting_recipe/varmintrifle
	name = "varmint rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle/varmint
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/datum/reagent/blackpowder = 20,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON*/
/* CRAFT rework: removed for balance
/datum/crafting_recipe/rangemaster
	name = "colt rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/obj/item/stack/sheet/metal = 3,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/rangemasterscoped
	name = "scoped colt rangemaster"
	result = /obj/item/gun/ballistic/automatic/rangemaster/scoped
	reqs = list(/obj/item/gun/ballistic/automatic/rangemaster = 1,
				/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/crafting/metalparts = 1,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/r91
	name = "r91 assault rifle"
	result = /obj/item/gun/ballistic/automatic/assault_rifle
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/mineral/titanium = 2,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/r91, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/r91
	name = "infiltrator"
	result = /obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	reqs = list(/obj/item/gun/ballistic/automatic/assault_rifle = 1,
				/obj/item/stack/sheet/glass = 2,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/suppressor = 1,
				/obj/item/stack/sheet/plastic = 1,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_AWORKBENCH, /obj/item/blueprint/weapon/infiltrator, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/*/datum/crafting_recipe/servicerifle
	name = "service rifle (crude)"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle
	reqs = list(/obj/item/prefabs/complex/barrel/m556 = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/action = 1,
				/obj/item/prefabs/complex/bolt = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/screw = 3,
				/obj/item/prefabs/complex/complexWeaponFrame = 1,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/servicerifle/mid
	name = "service rifle (fair)"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle/mid
	reqs = list(/obj/item/prefabs/complex/barrel/m556 = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/action = 1,
				/obj/item/prefabs/complex/bolt = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/screw = 3,
				/obj/item/prefabs/complex/complexWeaponFrame/mid = 1,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/servicerifle/high
	name = "service rifle (masterwork)"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle/high
	reqs = list(/obj/item/prefabs/complex/barrel/m556 = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/action = 1,
				/obj/item/prefabs/complex/bolt = 1,
				/obj/item/prefabs/complex/trigger = 1,
				/obj/item/prefabs/complex/screw = 3,
				/obj/item/prefabs/complex/complexWeaponFrame/high = 1,
				/datum/reagent/blackpowder = 20)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/* CRAFT rework: removed for balance
/datum/crafting_recipe/marksmanrifle
	name = "marksman rifle"
	result = /obj/item/gun/ballistic/automatic/marksman
	reqs = list(/obj/item/stack/sheet/plastic = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/mineral/titanium = 3,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_AWORKBENCH, /obj/item/blueprint/weapon/marksmanrifle, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/fnfal
	name = "fn fal"
	result = /obj/item/gun/ballistic/automatic/fnfal
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/mineral/titanium = 2,
				/datum/reagent/blackpowder = 30)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/fnfal, TOOL_GUNTIER4)
	traits = list(TRAIT_GUNSMITH_FOUR)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/datum/crafting_recipe/widowmaker
	name = "winchester widowmaker double barrel"
	result = /obj/item/gun/ballistic/revolver/widowmaker
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 5,
				/datum/reagent/blackpowder = 5)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/huntingshotgun
	name = "hunting shotgun"
	result = /obj/item/gun/ballistic/shotgun/hunting
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/metal = 3,
				/datum/reagent/blackpowder = 15)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
/* CRAFT rework: removed for balance
/datum/crafting_recipe/citykiller
	name = "combat shotgun"
	result = /obj/item/gun/ballistic/shotgun/automatic/combat
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 4,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/metal = 1,
				/datum/reagent/blackpowder = 35)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER4)
	traits = list(TRAIT_GUNSMITH_FOUR)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/caws
	name = "h&k caws"
	result = /obj/item/gun/ballistic/automatic/shotgun/caws
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/mineral/titanium = 2,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 3,
				/datum/reagent/blackpowder = 35)
	tools = list(TOOL_AWORKBENCH, /obj/item/blueprint/weapon/caws, TOOL_GUNTIER4)
	traits = list(TRAIT_GUNSMITH_FOUR)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//*CRAFT rework: removed for balance
/datum/crafting_recipe/greasegun
	name = "M3A1 Grease Gun"
	result = /obj/item/gun/ballistic/automatic/greasegun
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 6,
				/datum/reagent/blackpowder = 25)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*//* CRAFT rework: removed for balance
/datum/crafting_recipe/smg10mm
	name = "10mm submachine gun"
	result = /obj/item/gun/ballistic/automatic/smg10mm
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/crafting/goodparts = 1,
				/datum/reagent/blackpowder = 25,
				/obj/item/stack/sheet/metal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
*/
/datum/crafting_recipe/magnetowattz
	name = "(Upgrade) Wattz 1000 magneto-laser pistol"
	result = /obj/item/gun/energy/laser/wattz/magneto
	reqs = list(/obj/item/gun/energy/laser/wattz = 1,
				/obj/item/stack/crafting/electronicparts = 2)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/glock86a
	name = "(Upgrade) Glock 86a"
	result = /obj/item/gun/energy/laser/plasma/glock/extended
	reqs = list(/obj/item/gun/energy/laser/plasma/glock = 1,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/crafting/electronicparts = 3)
	tools = list(TOOL_WORKBENCH, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/cosmicknife
	name = "cosmic knife"
	result = /obj/item/kitchen/knife/cosmic
	reqs = list(/obj/item/kitchen/knife/cosmicdirty = 1,
				/obj/item/crafting/abraxo = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	time = 30

/datum/crafting_recipe/cosmicknifeheated
	name = "superheated cosmic knife"
	result = /obj/item/kitchen/knife/cosmicheated
	reqs = list(/obj/item/kitchen/knife/cosmic = 1,
				/datum/reagent/fuel = 25)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON
	time = 40

/datum/crafting_recipe/baseballspiked
	name = "spiked baseball bat"
	result = /obj/item/twohanded/baseball/spiked
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/twohanded/baseball = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

//scrap weaponry

/datum/crafting_recipe/machete
	name = "Machete"
	result = /obj/item/claymore/machete
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/obj/item/stack/sheet/cloth = 1)
	time = 80
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/bonedie
	name = "Carve Bone Die"
	result = /obj/item/dice/d6
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/strawdummy
	name = "Weave Target Dummy"
	result = /obj/structure/punching_bag/dummy
	time = 30
	reqs = list(/obj/item/stack/sheet/hay = 15)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/Tallow
	name = "Render Fat From Scraps"
	result = /obj/item/reagent_containers/food/snacks/tallow
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/cutlet = 3)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/TallowCandle
	name = "Mold Tallow Candle"
	result = /obj/item/candle
	time = 30
	reqs = list(
		/obj/item/reagent_containers/food/snacks/tallow = 1,
		/obj/item/stack/sheet/durathread = 3
	)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/salvagecandle
	name = "Salvage Wax"
	result = /obj/item/candle
	time = 80
	reqs = list(
		/obj/item/trash/candle = 5,
		/obj/item/stack/sheet/durathread = 3
	)
	category = CAT_MISC
	subcategory = CAT_MISC

/datum/crafting_recipe/warclub
	name = "Carve Wooden Warclub"
	result = /obj/item/claymore/machete/warclub
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/tribe_bow
	name = "String Wooden Bow"
	result = /obj/item/gun/ballistic/automatic/tribalbow
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/sinew = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/arrow
	name = "Fletch Arrows"
	result = /obj/item/ammo_casing/caseless/arrow
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/tribe_quiver
	name = "Craft Quiver and Arrows"
	result = /obj/item/storage/belt/tribe_quiver
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/tribe_armor
	name = "Tribe Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 6)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/tribaloutfit
	name = "Male Tribal Outfit"
	result = /obj/item/clothing/under/f13/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/geckohide = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/tribaloutfitfemale
	name = "Female Tribal Outfit"
	result = /obj/item/clothing/under/f13/female/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/geckohide = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

/datum/crafting_recipe/warmace
	name = "Carve Wooden Warmace"
	result = /obj/item/twohanded/sledgehammer/warmace
	time = 100
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/training_machete
	name = "Carve Training Machete"
	result = /obj/item/claymore/machete/training
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/spearquiver
	name = "Spear Quiver"
	result = /obj/item/storage/backpack/spearquiver
	time = 60
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/metal = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/arrowap
	name = "Sturdy Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ap
	time = 40
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/crafting/metalparts = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/arrowpoison
	name = "Poison Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/grown/nettle/basic = 5)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/arrowburn
	name = "Burn Posion Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/burning
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1,
				/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 4)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO_FIVE

/datum/crafting_recipe/voodoo
    name = "Voodoo"
    result = /obj/item/reagent_containers/pill/patch/voodoo
    time = 20
    reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 2,
                /obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
                /obj/item/reagent_containers/food/snacks/grown/yucca = 1)
    tools = list(TOOL_WORKBENCH)
    category = CAT_PRIMAL
    subcategory = CAT_TRIBAL

/datum/crafting_recipe/coyotechew
	name = "Coyote Tobacco Chew"
	result = /obj/item/reagent_containers/pill/patch/coyotechew
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 2, /obj/item/reagent_containers/food/snacks/grown/feracactus = 1, /obj/item/reagent_containers/food/snacks/grown/yucca = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL

//BOTTLING

/datum/crafting_recipe/bottler
	name = "Bottle Press"
	result = /obj/machinery/workbench/bottler
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/cable_coil = 10,
				/obj/item/wrench = 1)
	tools = list(TOOL_WRENCH, TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	time = 80
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

/datum/crafting_recipe/bottle
	name = "brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown
	reqs = list(/obj/item/stack/sheet/glass = 3,
				/obj/item/stack/f13Cash = 1)
	tools = list(TOOL_BOTTLER)
	time = 10
	category = CAT_MISC
	subcategory = CAT_BOTTLE

/datum/crafting_recipe/bottle/darkbrown
	name = "dark brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/darkbrown

/datum/crafting_recipe/bottle/lightbrown
	name = "light brown bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/lightbrown

/datum/crafting_recipe/bottle/white
	name = "white bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/white

/datum/crafting_recipe/bottle/green
	name = "green bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/green

/datum/crafting_recipe/bottle/wine
	name = "wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/wine

/datum/crafting_recipe/bottle/greenwine
	name = "green wine bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/greenwine

/datum/crafting_recipe/bottle/beerbottle
	name = "beer bottle"
	result = /obj/item/reagent_containers/food/drinks/bottle/brown/beer

//tools

/datum/crafting_recipe/crudewire
    name = "Crude Cutters"
    result = /obj/item/wirecutters/crude
    time = 80
    reqs = list(/obj/item/stack/rods = 2)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/crudeweld
    name = "Crude Welder"
    result = /obj/item/weldingtool/crude
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/rods = 2)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/crudewrench
    name = "Crude Wrench"
    result = /obj/item/wrench/crude
    time = 80
    reqs = list(/obj/item/stack/rods = 2)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/crudebar
    name = "Crude Crowbar"
    result = /obj/item/crowbar/crude
    time = 80
    reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/metal = 1)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/crudescrew
    name = "Crude Screwdriver"
    result = /obj/item/screwdriver/crude
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 2)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicvolt
    name = "Crude Voltage Scanner"
    result = /obj/item/multitool/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/glass = 1)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicwire
    name = "Basic Cutters"
    result = /obj/item/wirecutters/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 4)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicweld
    name = "Basic Welder"
    result = /obj/item/weldingtool/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 5)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicwrench
    name = "Basic Wrench"
    result = /obj/item/wrench/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 3)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicbar
    name = "Basic Crowbar"
    result = /obj/item/crowbar/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 1)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

/datum/crafting_recipe/basicscrew
    name = "Basic Screwdriver"
    result = /obj/item/screwdriver/basic
    time = 80
    reqs = list(/obj/item/stack/sheet/metal = 5)
    tools = list(TOOL_WORKBENCH)
    category = CAT_ASSEM
    subcategory = CAT_TOOLS

//forge making

/datum/crafting_recipe/forge
	name = "Forge"
	result = /obj/machinery/workbench/forge
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/lighter = 1,
				/obj/item/twohanded/sledgehammer = 1,
				/obj/item/screwdriver = 1,
				/obj/item/crowbar = 1,
				/obj/item/wrench = 1,
				/obj/item/wirecutters = 1,
				/obj/item/stack/sheet/metal = 50)
	time = 400
	category = CAT_ASSEM
	subcategory = CAT_MACHINES

//Knives

/datum/crafting_recipe/butchers
	name = "Butchers Knife"
	result = /obj/item/kitchen/knife/butcher
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/combat
	name = "Combat Knife"
	result = /obj/item/kitchen/knife/combat/scrap
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/combatbayonet
	name = "Bayonet Knife"
	result = /obj/item/kitchen/knife/combat/bayonet
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/kitchen
	name = "Kitchen Knife"
	result = /obj/item/kitchen/knife
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/ritual
	name = "Ritual Knife"
	result = /obj/item/kitchen/knife/ritualdagger
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/survival
	name = "Survival Knife"
	result = /obj/item/kitchen/knife/combat/survival
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/survival
	name = "Switchblade"
	result = /obj/item/switchblade
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/throwingknife
	name = "Throwing Knife"
	result = /obj/item/throwing_star/throwingknife
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 300
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

//swords

/datum/crafting_recipe/bmprsword
	name = "Bumper Sword"
	result = /obj/item/twohanded/fireaxe/bmprsword
	reqs = list(/obj/item/stack/sheet/metal = 25,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/katana
	name = "Longsword"
	result = /obj/item/katana/scrap
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 1000
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/spatha
	name = "Spatha"
	result = /obj/item/claymore/machete/spatha
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/sheet/bone = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 1000
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/gladuis
	name = "Gladius"
	result = /obj/item/claymore/machete/gladius
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/reinforcemachete
	name = "Machete"
	result = /obj/item/claymore/machete/reinforced
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/shortsword
	name = "Shortsword"
	result = /obj/item/claymore
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON


//polearms

/datum/crafting_recipe/bostaff
	name = "Quarterstaff"
	result = /obj/item/twohanded/bostaff
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/forgeglaive
	name = "Metal Glaive"
	result = /obj/item/twohanded/spear
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 4)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/forgethrowingspear
	name = "Throwing Spear"
	result = /obj/item/throwing_star/spear
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/mineral/wood = 3)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/harpoon
	name = "Harpoon"
	result = /obj/item/throwing_star/spear/harpoon
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/pitchfork
	name = "Pitchfork"
	result = /obj/item/twohanded/pitchfork
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 3)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/sythe //fucc english
	name = "Scythe"
	result = /obj/item/scythe
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 4)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

//blunt

/datum/crafting_recipe/sledge
	name = "Sledgehammer"
	result = /obj/item/twohanded/sledgehammer
	time = 1000
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/mineral/wood = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/pipe
	name = "Pipe"
	result = /obj/item/claymore/machete/pipe
	time = 50
	reqs = list(/obj/item/stack/sheet/metal = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/golf
	name = "Golf Club"
	result = /obj/item/claymore/machete/golf/teniron
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 10)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/pan
	name = "Frying Pan"
	result = /obj/item/claymore/machete/pipe/pan
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

//miscweapons

/datum/crafting_recipe/fire_axe
	name = "Wood Axe"
	result = /obj/item/twohanded/fireaxe
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/pick_axe
	name = "Pickaxe"
	result = /obj/item/pickaxe
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/cpick_axe
	name = "Compact Pickaxe"
	result = /obj/item/pickaxe/mini
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/shovel
	name = "Shovel"
	result = /obj/item/shovel
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/hatchet
	name = "Hatchet"
	result = /obj/item/hatchet
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

//fists

/datum/crafting_recipe/knucklespike
	name = "Spiked Knuckledusters"
	result = /obj/item/melee/unarmed/brass/spiked
	time = 50
	reqs = list(/obj/item/stack/sheet/metal = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/sap
	name = "Sappers"
	result = /obj/item/melee/unarmed/sappers
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/maceglove
	name = "Mace Glove"
	result = /obj/item/melee/unarmed/maceglove
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 20)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

//armorhelmets

/datum/crafting_recipe/salvagePA
	name = "Salvaged PA Helmet"
	result = /obj/item/clothing/head/helmet/f13/tribal
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 3)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/bighorn
	name = "Bighorner Helmet"
	result = /obj/item/clothing/head/helmet/f13/fiend_reinforced
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 6)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/metalhelmet
	name = "Metal Helmet"
	result = /obj/item/clothing/head/helmet/knight/fluff/metal/reinforced
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/swag
	name = "Flame Metal Helmet"
	result = /obj/item/clothing/head/helmet/knight/f13/rider
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/potonheaddamn
	name = "Salvaged Metal Helmet"
	result = /obj/item/clothing/head/f13/pot
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/salvageweld
	name = "Salvaged Welding Mask"
	result = /obj/item/clothing/head/welding/f13/fire
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/cloth = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/legionaire
	name = "Legionaire Helmet"
	result = /obj/item/clothing/head/helmet/roman/legionaire
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/glad
	name = "Gladiator Helmet"
	result = /obj/item/clothing/head/helmet/gladiator
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/salvecomb
	name = "Salvaged Combat Helmet"
	result = /obj/item/clothing/head/helmet/f13/raidercombathelmet
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/mmask
	name = "Metal Mask"
	result = /obj/item/clothing/head/helmet/f13/metalmask/mk2
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

//armors

/datum/crafting_recipe/heavytribe
	name = "Heavy Tribal Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_heavy_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/lighttribe
	name = "Light Tribal Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/plate
	name = "Plate Armor"
	result = /obj/item/clothing/suit/armor/plate/crusader/plate
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 10)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/thejugg
	name = "Juggernaut Armor"
	result = /obj/item/clothing/suit/armor/plate/crusader/jugger
	time = 1000
	reqs = list(/obj/item/stack/sheet/metal = 90,
				/obj/item/stack/sheet/cloth = 3)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/thejugghelm
	name = "Juggernaut Helmet"
	result = /obj/item/clothing/head/helmet/plate/crusader/jugger
	time = 500
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 3)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

//shoe

/datum/crafting_recipe/plateboot
	name = "Plate Boots"
	result = /obj/item/clothing/shoes/f13/military/legionmetal
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

//glove

/datum/crafting_recipe/plateglove
	name = "Plate Gloves"
	result = /obj/item/clothing/gloves/legion/legate
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

//misc

/datum/crafting_recipe/fork //only a spoon...
	name = "Fork"
	result = /obj/item/kitchen/fork
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEMISC

/datum/crafting_recipe/bowl
	name = "Bowl"
	result = /obj/item/reagent_containers/glass/bowl
	time = 100
	reqs = list(/obj/item/stack/sheet/glass = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEMISC

/datum/crafting_recipe/tallglass
	name = "Tall Glass"
	result = /obj/item/reagent_containers/food/drinks/drinkingglass
	time = 100
	reqs = list(/obj/item/stack/sheet/glass = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEMISC

/datum/crafting_recipe/shotglass
	name = "Shotglass"
	result = /obj/item/reagent_containers/food/drinks/drinkingglass/shotglass
	time = 100
	reqs = list(/obj/item/stack/sheet/glass = 1)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEMISC

/datum/crafting_recipe/igniter2
	name = "Igniter"
	result = /obj/item/crafting/igniter
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5)
	traits = list(TRAIT_TECHNOPHOBE)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEMISC


//Blueprints

//low tier

//laser pistol

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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

/datum/crafting_recipe/mg34
	name = "Ancient machine gun"
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
	name = "Ancient machine gun"
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
	name = "Ancient rifle"
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
	name = "Ancient rifle"
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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	result = /obj/item/gun/ballistic/automatic/r84
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/lmg)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/lmg_lim
	name = "R84 LMG"
	result = /obj/item/gun/ballistic/automatic/r84
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/blueprint/weapon/lmg/limited = 1
				)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

//r82

/datum/crafting_recipe/R82
	name = "R82 heavy service rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle/r82
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5
				)
	tools = list(TOOL_WORKBENCH, /obj/item/blueprint/weapon/R82)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

/datum/crafting_recipe/R82_lim
	name = "R82 heavy service rifle"
	result = /obj/item/gun/ballistic/automatic/marksman/servicerifle/r82
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/receiver = 1,
				/datum/reagent/blackpowder = 30,
				/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/crafting/goodparts = 5,
				 /obj/item/blueprint/weapon/R82/limited = 1)
	tools = list(TOOL_WORKBENCH)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE


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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON
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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE
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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON

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
	category = CAT_BLUEPRINTS
	subcategory = CAT_BPWEAPON_ONEUSE

//BP copy
/datum/crafting_recipe/bpcopy	
	result = /obj/item/blueprint/weapon/marksmanrifle/limited
	name = "Marksman Rifle blueprint"
	reqs = list(/obj/item/paper = 1)
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/marksmanrifle)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 120
	category = CAT_BLUEPRINTS
	subcategory = CAT_BP_COPY

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
	name = "Ancient SMG blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/pps)

/datum/crafting_recipe/bpcopy/mg34
	result = /obj/item/blueprint/weapon/mg34/limited
	name = "Ancient machine gun blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/mg34)

/datum/crafting_recipe/bpcopy/kar98
	result = /obj/item/blueprint/weapon/kar98/limited
	name = "Ancient rifle blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/kar98)

/datum/crafting_recipe/bpcopy/thatgun
	result = /obj/item/blueprint/weapon/thatgun/limited
	name = ".223 pistol blueprint"
	tools = list(TOOL_AWORKBENCH, TOOL_GUNTIER3, /obj/item/blueprint/weapon/thatgun)

//moulds

/datum/crafting_recipe/mould	
	result = /obj/item/prefabs/mould/barrel/m556
	name = "556 Barrel Mould"
	reqs = list(/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_FORGE, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/mm9barrel
	result = /obj/item/prefabs/mould/barrel/mm9
	name = "9mm Barrel Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/mm10barrel
	result = /obj/item/prefabs/mould/barrel/mm10
	name = "10mm Barrel Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/m44barrel
	result = /obj/item/prefabs/mould/barrel/m44
	name = ".44 Barrel Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER2)
	traits = list(TRAIT_GUNSMITH_TWO)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/m357barrel
	result = /obj/item/prefabs/mould/barrel/m357
	name = ".357 Barrel Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/m45barrel
	result = /obj/item/prefabs/mould/barrel/m45
	name = ".45 Barrel Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/simpleaction
	result = /obj/item/prefabs/mould/action/simple
	name = "Simple Action Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/bolt
	result = /obj/item/prefabs/mould/bolt/simple
	name = "Simple Bolt Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/boltadvanced
	result = /obj/item/prefabs/mould/bolt/high
	name = "Advanced Bolt Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/trigger
	result = /obj/item/prefabs/mould/trigger
	name = "Trigger Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/stock
	result = /obj/item/prefabs/mould/stock
	name = "Stock Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/screw
	result = /obj/item/prefabs/mould/screw
	name = "Screw Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/sWeaponFramea
	result = /obj/item/prefabs/mould/simpleWeaponFrame
	name = "Simple Weapon Frame Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER1)
	traits = list(TRAIT_GUNSMITH_ONE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE

/datum/crafting_recipe/mould/cWeaponFrame
	result = /obj/item/prefabs/mould/complexWeaponFrame
	name = "Complex Weapon Frame Mould"
	tools = list(TOOL_FORGE, TOOL_GUNTIER3)
	traits = list(TRAIT_GUNSMITH_THREE)
	time = 30
	category = CAT_MOULD
	subcategory = CAT_MOULD_ONE
