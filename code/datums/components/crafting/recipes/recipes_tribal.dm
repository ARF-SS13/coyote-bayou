/datum/crafting_recipe/tribalwar
	category = CAT_PRIMAL

//ARMOR//

/datum/crafting_recipe/tribalwar/tatteredredcloak
	name = "Tattered red cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/stack/sheet/cloth = 2)

/datum/crafting_recipe/tribalwar/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/animalhide/aethergiest = 1) //changed from goliath to aethergiest
	always_available = FALSE

/datum/crafting_recipe/tribalwar/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	always_available = FALSE

//WEAPONS//

/datum/crafting_recipe/tribalwar/blowgun
	name = "Blowgun"
	result = /obj/item/gun/syringe/blowgun
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/bamboo = 10)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/bow
	name = "Short Bow"
	result = /obj/item/gun/ballistic/bow/shortbow
	time = 65
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10, //easy to make. you can get one as a starter
				/obj/item/weaponcrafting/string = 1,
				)

/datum/crafting_recipe/tribalwar/bow
	name = "Long Bow"
	result = /obj/item/gun/ballistic/bow/longbow
	time = 65
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20, //easy to make. you can get one as a starter
				/obj/item/weaponcrafting/string = 5,
				/obj/item/stack/sheet/leather = 5,
				/obj/item/stack/sheet/metal = 5
				)

/datum/crafting_recipe/tribalwar/composite
	name = "Composite Bow"
	result = /obj/item/gun/ballistic/bow/composite
	time = 65
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10, 
				/obj/item/weaponcrafting/string = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/bone = 2
				)

/datum/crafting_recipe/tribalwar/training_machete
	name = "Training Machete"
	result = /obj/item/melee/onehanded/machete/training
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/cloth = 2
				)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/boomerang
	name = "Wooden Boomerang"
	result = /obj/item/melee/f13onehanded/boomerang
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 15,
				/obj/item/stack/sheet/cloth = 2
				)
	tools = list(TOOL_WORKBENCH)

//CLOTHING AND TOOLS

/datum/crafting_recipe/tribal
	category = CAT_PRIMAL

/datum/crafting_recipe/tribal/tikimask
	name = "Tiki mask"
	result = /obj/item/clothing/mask/gas/tiki_mask
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)

/*this thing is broken and unneeded
/datum/crafting_recipe/tribal/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	always_available = FALSE
*/
/datum/crafting_recipe/tribal/bonebag
	name = "Tribal Satchel"
	result = /obj/item/storage/backpack/satchel/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)
	always_available = TRUE

/*
/datum/crafting_recipe/headpike
	name = "Spike Head (Glass Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL
	subcategory = CAT_PRIMAL

/datum/crafting_recipe/headpikebone
	name = "Spike Head (Bone Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/bonespear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/bonespear = 1)
	result = /obj/structure/headpike/bone
	category = CAT_PRIMAL
	subcategory = CAT_PRIMAL
*/

/datum/crafting_recipe/tribal/mantlebrown
	name = "Brown Mantle"
	result = /obj/item/clothing/neck/mantle/brown
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribal/mantlegray
	name = "Gray Mantle"
	result = /obj/item/clothing/neck/mantle/gray
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribal/bonedie
	name = "Carve Bone Die"
	result = /obj/item/dice/d6
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1)
	tools = list(TOOL_WORKBENCH)

//Gecko outfits already exist, see below.
/*datum/crafting_recipe/tribal/maletribal
	//name = "Coarse Tribal outfit"
	//result = /obj/item/clothing/under/f13/tribal
	//reqs = list(/obj/item/stack/sheet/cloth = 3)
	//tools = list(TOOL_WORKBENCH)
	//time = 30
*/

/datum/crafting_recipe/tribal/tribaloutfit
	name = "Male Tribal Outfit"
	result = /obj/item/clothing/under/f13/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribal/tribaloutfitfemale
	name = "Female Tribal Outfit"
	result = /obj/item/clothing/under/f13/female/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribal/tribalarmoredcloth
	name = "Patched Tribal Loincloth"
	result = /obj/item/clothing/under/f13/wayfarer/hunter
	time = 20
	reqs = list(/obj/item/stack/sheet/cloth = 3,
				/obj/item/stack/sheet/leather = 1)
	tools = list (TOOL_WORKBENCH)

/datum/crafting_recipe/tribal/tribalcloth
	name = "Tribal Loincloth"
	result = /obj/item/clothing/under/f13/wayfarer
	time = 15
	reqs = list(/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribal/shittycleaver
	name = "Carving Knife"
	result = /obj/item/kitchen/knife/butcher/tribal
	time = 45
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2, /obj/item/stack/sheet/metal = 3)

/datum/crafting_recipe/warpaint
	name = "Body Paint"
	result = /obj/item/warpaint_bowl
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2,
				/obj/item/stack/ore/glass = 1,
				/obj/item/pestle = 1,
				/obj/item/reagent_containers/glass/mortar = 1)
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/warmace
	name = "Carve Wooden Warmace"
	result = /obj/item/twohanded/sledgehammer/warmace
	time = 100
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	always_available = FALSE

/*datum/crafting_recipe/voodoo
	name = "Voodoo"
	result = /obj/item/reagent_containers/pill/patch/voodoo
	time = 20
	reqs = list(/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 2,
				/obj/item/reagent_containers/food/snacks/grown/feracactus = 2,
				/obj/item/reagent_containers/food/snacks/grown/yucca = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/coyotechew
	name = "Coyote Tobacco Chew"
	result = /obj/item/reagent_containers/pill/patch/coyotechew
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 2, /obj/item/reagent_containers/food/snacks/grown/feracactus = 1, /obj/item/reagent_containers/food/snacks/grown/yucca = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_PRIMAL
	always_available = FALSE
*/

//White Legs
/datum/crafting_recipe/tribalwar/whitelegs
	always_available = FALSE

/datum/crafting_recipe/tribalwar/whitelegs/lightarmour
	name = "White Legs Light Armour"
	result = /obj/item/clothing/suit/armor/light/tribal/whitelegs
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/metalparts = 4)

/datum/crafting_recipe/tribalwar/whitelegs/armour
	name = "White Legs Armour"
	result = /obj/item/clothing/suit/armor/medium/tribal/whitelegs
	time = 60
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/goodparts = 5)

/datum/crafting_recipe/tribalwar/whitelegs/heavyarmour
	name = "White Legs Heavy Armour"
	result = /obj/item/clothing/suit/armor/heavy/tribal/whitelegs
	time = 60
	reqs = list(/obj/item/clothing/suit/armor/light/tribal/whitelegs = 1,
				/obj/item/stack/sheet/animalhide/gecko = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/goodparts = 5)

/datum/crafting_recipe/tribalwar/whitelegs/garb
	name = "White Legs Garb"
	result = /obj/item/clothing/under/f13/whitelegs
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 1,
				/obj/item/stack/sheet/cloth = 2)

/datum/crafting_recipe/tribalwar/whitelegs/femalegarb
	name = "Female White Legs Garb"
	result = /obj/item/clothing/under/f13/female/whitelegs
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 1,
				/obj/item/stack/sheet/cloth = 2)

//Rustwalkers
/datum/crafting_recipe/tribalwar/rustwalkers
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribalwar/rustwalkers/lightarmour
	name = "Rustwalkers Light Armour"
	result = /obj/item/clothing/suit/armor/light/tribal/rustwalkers
	time = 30
	reqs = list(/obj/item/stack/sheet/leather = 4,
				/obj/item/stack/crafting/metalparts = 4)

/datum/crafting_recipe/tribalwar/rustwalkers/armour
	name = "Rustwalkers Armour"
	result = /obj/item/clothing/suit/armor/medium/tribal/rustwalkers
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/goodparts = 5)

/datum/crafting_recipe/tribalwar/rustwalkers/heavyarmour
	name = "Rustwalkers Heavy Armour"
	result = /obj/item/clothing/suit/armor/heavy/tribal/rustwalkers
	time = 60
	reqs = list(/obj/item/clothing/suit/armor/light/tribal/rustwalkers =1,
				/obj/item/clothing/suit/armor/light/tribal/rustwalkers = 1,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribalwar/rustwalkers/garb
	name = "Rustwalkers Garb"
	result = /obj/item/clothing/under/f13/rustwalkers
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

/datum/crafting_recipe/tribalwar/rustwalkers/femalegarb
	name = "Female Rustwalkers Garb"
	result = /obj/item/clothing/under/f13/female/rustwalkers
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

//Eighties
/datum/crafting_recipe/tribalwar/eighties
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribalwar/eighties/lightarmour
	name = "Eighties Light Armour"
	result = /obj/item/clothing/suit/armor/light/tribal/eighties
	time = 30
	reqs = list(/obj/item/stack/sheet/leather = 4,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/crafting/metalparts = 1)

/datum/crafting_recipe/tribalwar/eighties/armour
	name = "Eighties Armour"
	result = /obj/item/clothing/suit/armor/medium/tribal/eighties
	time = 60
	reqs = list(/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/cloth = 4)

/datum/crafting_recipe/tribalwar/eighties/heavyarmour
	name = "Eighties Heavy Armour"
	result = /obj/item/clothing/suit/armor/heavy/tribal/eighties
	time = 60
	reqs = list(/obj/item/clothing/suit/armor/light/tribal/eighties =1,
				/obj/item/clothing/suit/armor/light/tribal/eighties = 1,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribalwar/eighties/garb
	name = "Eighties Garb"
	result = /obj/item/clothing/under/f13/eighties
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

/datum/crafting_recipe/tribalwar/eighties/femalegarb
	name = "Female Eighties Garb"
	result = /obj/item/clothing/under/f13/female/eighties
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

//Dead Horses
/datum/crafting_recipe/tribalwar/deadhorses
	always_available = FALSE

/datum/crafting_recipe/tribalwar/deadhorses/lightarmour
	name = "Dead Horses Light Armour"
	result = /obj/item/clothing/suit/armor/light/tribal/deadhorses
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2,
				/obj/item/stack/sheet/cloth = 1)

/datum/crafting_recipe/tribalwar/deadhorses/armour
	name = "Dead Horses Armour"
	result = /obj/item/clothing/suit/armor/medium/tribal/deadhorses
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/animalhide/gecko = 3,
				/obj/item/stack/sheet/cloth = 2)

/datum/crafting_recipe/tribalwar/deadhorses/heavyarmour
	name = "Dead Horses Heavy Armour"
	result = /obj/item/clothing/suit/armor/heavy/tribal/deadhorses
	time = 60
	reqs = list(/obj/item/clothing/suit/armor/light/tribal/deadhorses =1,
				/obj/item/clothing/suit/armor/light/tribal/deadhorses = 1,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribalwar/deadhorses/garb
	name = "Dead Horses Garb"
	result = /obj/item/clothing/under/f13/deadhorses
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

/datum/crafting_recipe/tribalwar/deadhorses/femalegarb
	name = "Female Dead Horses Garb"
	result = /obj/item/clothing/under/f13/female/deadhorses
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

//Sorrows
/datum/crafting_recipe/tribalwar/sorrows
	always_available = FALSE

/datum/crafting_recipe/tribalwar/sorrows/armour
	name = "Sorrows Armour"
	result = /obj/item/clothing/suit/armor/light/tribal/sorrows
	time = 30
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/cloth = 1,
				/obj/item/stack/sheet/metal = 1)

/datum/crafting_recipe/tribalwar/sorrows/garb
	name = "Sorrows Garb"
	result = /obj/item/clothing/under/f13/sorrows
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

/datum/crafting_recipe/tribalwar/sorrows/femalegarb
	name = "Female Sorrows Garb"
	result = /obj/item/clothing/under/f13/female/sorrows
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)

/datum/crafting_recipe/tribalwar/sorrows/yaoguaigauntlet
	name = "Yao Guai Gauntlet"
	result = /obj/item/melee/unarmed/yaoguaigauntlet
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/reagent_containers/food/snacks/meat/slab/bear = 2,
				/obj/item/clothing/head/bearpelt = 1)

//Bone Dancers

/datum/crafting_recipe/tribalwar/bone
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribalwar/bone/lightarmour
	name = "Bone Dancer Light Armor"
	result = /obj/item/clothing/suit/armor/light/tribal/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)

/datum/crafting_recipe/tribalwar/bone/armour
	name = "Bone Dancer Reinforced Armor"
	result = /obj/item/clothing/suit/armor/medium/tribal/bone
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/bone = 6)

/datum/crafting_recipe/tribalwar/bone/heavyarmour
	name = "Bone Dancer Heavy Armor"
	result = /obj/item/clothing/suit/armor/heavy/tribal/bone
	time = 60
	reqs = list(/obj/item/clothing/suit/armor/light/tribal/bone =1,
				/obj/item/clothing/suit/armor/light/tribal/bone = 1,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/bone = 4)

/datum/crafting_recipe/tribalwar/bone/garb
	name = "Bone Dancer Garb"
	result = /obj/item/clothing/under/f13/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 3)


/datum/crafting_recipe/tribalwar/bone/helmet
	name = "Bone Dancer helmet"
	result = /obj/item/clothing/head/helmet/skull/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/cloth = 1,
				/obj/item/stack/sheet/leather = 1,
				/obj/item/clothing/head/helmet/skull = 1)

//Cloth Eyepatch
/datum/crafting_recipe/tribal/eyepatch
	name = "Bandage Eyepatch"
	result = /obj/item/clothing/glasses/f13/tribaleyepatch
	time = 10
	reqs = list(/obj/item/stack/medical/gauze/improvised = 2)

/*Kelp's magic stuff*/

/datum/crafting_recipe/magic
	category = CAT_MAGIC

// Ritual dagger (tribal dagger + needed to make magic stuff)
/datum/crafting_recipe/magic/ritualdagger
	name = "Ritual Dagger"
	result = /obj/item/melee/onehanded/knife/ritualdagger
	time = 10
	reqs = list(/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/bone = 1)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/magic/gravitygloves
	name = "Gravity Gloves"
	result = /obj/item/clothing/gloves/fingerless/pugilist/gravity
	time = 30
	reqs = list(/datum/material/titanium = 10,
				/obj/item/stack/crafting/goodparts = 5,
				/obj/item/stack/sheet/mineral/plasma = 2,
				/obj/item/stack/sheet/mineral/diamond = 1,
				/obj/item/stack/sheet/bluespace_crystal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Amulet of Protection (Tier 1.5 armor, 10 DT/Wound prot)
/datum/crafting_recipe/magic/armoramulet
	name = "Amulet of Protection"
	result = /obj/item/clothing/suit/armor/outfit/vest/utility/magicarmor
	time = 10
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/mineral/titanium = 1,
				/obj/item/stack/sheet/mineral/gold = 1)
	tools = list(TOOL_RITUAL)

// Amulet of Hazard Protection (Tier 1? armor, 75 enviro prot + 50 plasma prot)
/datum/crafting_recipe/magic/radamulet
	name = "Amulet of Cleansing"
	result = /obj/item/clothing/suit/armor/outfit/vest/utility/magicarmor/hazard
	time = 10
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/mineral/titanium = 1,
				/obj/item/stack/sheet/mineral/plasma = 1)
	tools = list(TOOL_RITUAL)

// T0 Magic Missile Wand (spawn item)
/datum/crafting_recipe/magic/bonewand
	name = "Improvised Wand of Magic Missile"
	result = /obj/item/gun/magic/wand/kelpmagic/magicmissile
	time = 10
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/mineral/plasma = 1)
	tools = list(TOOL_RITUAL)

//  T0 Zapper Wand (spawn item)
/datum/crafting_recipe/magic/zaprod
	name = "Improvised Rod of Shocks"
	result = /obj/item/gun/magic/wand/kelpmagic/basiczappies
	time = 10
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/mineral/gold = 1)
	tools = list(TOOL_RITUAL)

// T1 Magic Missile Wand (generalist sidearm)
/datum/crafting_recipe/magic/missilewand
	name = "Normal Wand of Magic Missile"
	result = /obj/item/gun/magic/wand/kelpmagic/magicmissile/improved
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/mineral/gold = 1)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// T1 Sparks Wand (anti-swarm sidearm)
/datum/crafting_recipe/magic/lightningrod
	name = "Wand of Sparks"
	result = /obj/item/gun/magic/wand/kelpmagic/sparky
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/sheet/mineral/diamond = 1,
				/obj/item/stack/sheet/mineral/gold = 1)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Staff of Lightning (DMR staff, hitscan projectile)
/datum/crafting_recipe/magic/shockstaff
	name = "Staff of Lightning"
	result = /obj/item/gun/magic/staff/kelpmagic/lightning
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/crafting/goodparts = 3,
				/obj/item/stack/sheet/mineral/diamond = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// T1 Firebolt Wand (anti-elite sidearm)
/datum/crafting_recipe/magic/fireboltwand
	name = "Wand of Firebolt"
	result = /obj/item/gun/magic/wand/kelpmagic/firebolt
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/gun_upgrade/paint/red = 1,
				/obj/item/stack/sheet/mineral/diamond = 1)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Staff of Fireball (RPG-like staff, 1 shot per 60sec, 75dmg vs players; ~169 vs mobs)
/datum/crafting_recipe/magic/fireball
	name = "Staff of Fireball"
	result = /obj/item/gun/magic/staff/kelpmagic/fireball
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20,
				/obj/item/stack/crafting/metalparts = 10,
				/obj/item/gun_upgrade/paint/red = 1,
				/obj/item/stack/sheet/mineral/diamond = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Staff of Acid (SMG-like staff, rapid fire but low damage per shot, energy-type damage)
/datum/crafting_recipe/magic/acidspray
	name = "Staff of Acid Spray"
	result = /obj/item/gun/magic/staff/kelpmagic/acidstaff
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/sheet/mineral/plasma = 2,
				/obj/item/stack/sheet/mineral/uranium = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Staff of Magma (Flamethrower staff, short range, fast charge, high power)
/datum/crafting_recipe/magic/flamethrower
	name = "Staff of Magma"
	result = /obj/item/gun/magic/staff/kelpmagic/flamethrower
	time = 30
	reqs = list(/obj/item/stack/sheet/bronze = 10,
				/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/sheet/mineral/plasma = 2,
				/obj/item/stack/sheet/bluespace_crystal = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// T1 Mending Wand (basic omni heal, ~50 HP all categories every 5 minutes)
/datum/crafting_recipe/magic/mendingwand
	name = "Wand of Mending"
	result = /obj/item/gun/magic/wand/kelpmagic/healwand
	time = 30
	reqs = list(/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/sheet/mineral/silver = 1,
				/obj/item/stack/sheet/mineral/gold = 1)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Staff of Healing (Lots of omniheals, ~50 HP all categories every 5 minutes, 5x charges of the wand)
/datum/crafting_recipe/magic/healstaff
	name = "Staff of Healing"
	result = /obj/item/gun/magic/staff/kelpmagic/healstaff
	time = 30
	reqs = list(/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/mineral/gold = 3,
				/obj/item/stack/sheet/mineral/diamond = 1)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

/datum/crafting_recipe/magic/resurrectstaff
	name = "Staff of Resurrection"
	result = /obj/item/gun/magic/staff/healing
	time = 30
	reqs = list(/obj/item/stack/crafting/metalparts = 10,
				/obj/item/stack/crafting/goodparts = 20,
				/obj/item/stack/sheet/leather = 5,
				/obj/item/stack/sheet/mineral/gold = 5,
				/obj/item/stack/sheet/mineral/diamond = 2)
	tools = list(TOOL_WORKBENCH, TOOL_RITUAL)

// Perfected Staff of Healing (Literally just the medbeam but Bulky and needs magic)
/datum/crafting_recipe/magic/healstaff/perfected
	name = "Perfected Staff of Healing"
	result = /obj/item/gun/medbeam/magic
	time = 30
	reqs = list(/obj/item/stack/crafting/metalparts = 20,
				/obj/item/stack/crafting/goodparts = 10,
				/obj/item/stack/sheet/bluespace_crystal = 5,
				/obj/item/gun/magic/staff/kelpmagic/healstaff = 1)
	tools = list(TOOL_WORKBENCH, TOOL_ALCHEMY_TABLE, TOOL_RITUAL)
