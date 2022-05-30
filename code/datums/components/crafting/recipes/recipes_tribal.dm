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
				/obj/item/stack/sheet/animalhide/deathclaw = 1) //changed from goliath to deathclaw
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
	name = "String Wooden Bow"
	result = /obj/item/gun/ballistic/bow/tribal
	time = 65
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/weaponcrafting/string = 1,
				/obj/item/melee/onehanded/knife
				)

/datum/crafting_recipe/tribalwar/xbow
	name = "Manual Crossbow"
	result = /obj/item/gun/ballistic/bow/xbow
	time = 120
	always_available = FALSE
	reqs = list(/obj/item/stack/crafting/metalparts = 5,
				/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/mineral/wood = 15,
				/obj/item/weaponcrafting/string = 1
				)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/training_machete
	name = "Training Machete"
	result = /obj/item/melee/onehanded/machete/training
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
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

/datum/crafting_recipe/tribal/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	always_available = FALSE

/datum/crafting_recipe/tribal/bonebag
	name = "Tribal Satchel"
	result = /obj/item/storage/backpack/satchel/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)
	always_available = FALSE

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

/datum/crafting_recipe/warpaint
	name = "Body Paint"
	result = /obj/item/warpaint_bowl
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/mutfruit = 2,
				/obj/item/stack/ore/glass = 1,
				/obj/item/pestle = 1,
				/obj/item/reagent_containers/glass/mortar = 1)
	category = CAT_TRIBAL
	always_available = FALSE

/datum/crafting_recipe/warmace
	name = "Carve Wooden Warmace"
	result = /obj/item/twohanded/sledgehammer/warmace
	time = 100
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_TRIBAL
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
	subcategory = CAT_TRIBAL
	always_available = FALSE

/datum/crafting_recipe/coyotechew
	name = "Coyote Tobacco Chew"
	result = /obj/item/reagent_containers/pill/patch/coyotechew
	time = 30
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/coyotetobacco = 2, /obj/item/reagent_containers/food/snacks/grown/feracactus = 1, /obj/item/reagent_containers/food/snacks/grown/yucca = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL
	always_available = FALSE
*/

//White Legs
/datum/crafting_recipe/tribalwar/whitelegs
	always_available = FALSE

/datum/crafting_recipe/tribalwar/whitelegs/lightarmour
	name = "White Legs Light Armour"
	result = /obj/item/clothing/suit/f13/tribal/light/whitelegs
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/metalparts = 4)

/datum/crafting_recipe/tribalwar/whitelegs/armour
	name = "White Legs Armour"
	result = /obj/item/clothing/suit/f13/tribal/whitelegs
	time = 60
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/goodparts = 5)

/datum/crafting_recipe/tribalwar/whitelegs/heavyarmour
	name = "White Legs Heavy Armour"
	result = /obj/item/clothing/suit/f13/tribal/heavy/whitelegs
	time = 60
	reqs = list(/obj/item/clothing/suit/f13/tribal/whitelegs = 1,
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
	always_available = FALSE

/datum/crafting_recipe/tribalwar/rustwalkers/lightarmour
	name = "Rustwalkers Light Armour"
	result = /obj/item/clothing/suit/f13/tribal/light/rustwalkers
	time = 30
	reqs = list(/obj/item/stack/sheet/leather = 4,
				/obj/item/stack/crafting/metalparts = 4)

/datum/crafting_recipe/tribalwar/rustwalkers/armour
	name = "Rustwalkers Armour"
	result = /obj/item/clothing/suit/f13/tribal/rustwalkers
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/crafting/goodparts = 5)

/datum/crafting_recipe/tribalwar/rustwalkers/heavyarmour
	name = "Rustwalkers Heavy Armour"
	result = /obj/item/clothing/suit/f13/tribal/heavy/rustwalkers
	time = 60
	reqs = list(/obj/item/clothing/suit/f13/tribal/light/rustwalkers =1,
				/obj/item/clothing/suit/f13/tribal/rustwalkers = 1,
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
	always_available = FALSE

/datum/crafting_recipe/tribalwar/eighties/lightarmour
	name = "Eighties Light Armour"
	result = /obj/item/clothing/suit/f13/tribal/light/eighties
	time = 30
	reqs = list(/obj/item/stack/sheet/leather = 4,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/crafting/metalparts = 1)

/datum/crafting_recipe/tribalwar/eighties/armour
	name = "Eighties Armour"
	result = /obj/item/clothing/suit/f13/tribal/eighties
	time = 60
	reqs = list(/obj/item/stack/crafting/goodparts = 1,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/cloth = 4)

/datum/crafting_recipe/tribalwar/eighties/heavyarmour
	name = "Eighties Heavy Armour"
	result = /obj/item/clothing/suit/f13/tribal/heavy/eighties
	time = 60
	reqs = list(/obj/item/clothing/suit/f13/tribal/light/eighties =1,
				/obj/item/clothing/suit/f13/tribal/eighties = 1,
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
	result = /obj/item/clothing/suit/f13/tribal/light/deadhorses
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2,
				/obj/item/stack/sheet/cloth = 1)

/datum/crafting_recipe/tribalwar/deadhorses/armour
	name = "Dead Horses Armour"
	result = /obj/item/clothing/suit/f13/tribal/deadhorses
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/animalhide/gecko = 3,
				/obj/item/stack/sheet/cloth = 2)

/datum/crafting_recipe/tribalwar/deadhorses/heavyarmour
	name = "Dead Horses Heavy Armour"
	result = /obj/item/clothing/suit/f13/tribal/heavy/deadhorses
	time = 60
	reqs = list(/obj/item/clothing/suit/f13/tribal/light/deadhorses =1,
				/obj/item/clothing/suit/f13/tribal/deadhorses = 1,
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
	result = /obj/item/clothing/suit/f13/tribal/light/sorrows
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

datum/crafting_recipe/tribalwar/bone
	always_available = FALSE

/datum/crafting_recipe/tribalwar/bone/lightarmour
	name = "Bone Dancer Light Armor"
	result = /obj/item/clothing/suit/f13/tribal/light/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)

/datum/crafting_recipe/tribalwar/bone/armour
	name = "Bone Dancer Reinforced Armor"
	result = /obj/item/clothing/suit/f13/tribal/bone
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/bone = 6)

/datum/crafting_recipe/tribalwar/bone/heavyarmour
	name = "Bone Dancer Heavy Armor"
	result = /obj/item/clothing/suit/f13/tribal/heavy/bone
	time = 60
	reqs = list(/obj/item/clothing/suit/f13/tribal/light/bone =1,
				/obj/item/clothing/suit/f13/tribal/bone = 1,
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
