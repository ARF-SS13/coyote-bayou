/datum/crafting_recipe/tribalwar
	category = CAT_PRIMAL

//ARMOR//

/datum/crafting_recipe/tribalwar/heavytribe
	name = "Heavy Tribal Plates"
	result = /obj/item/clothing/suit/armor/f13/tribe_heavy_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)

/datum/crafting_recipe/tribalwar/lighttribe
	name = "Light Tribal Plates"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)

/datum/crafting_recipe/tribalwar/chitinarmor
	name = "Insect Chitin Armor"
	result = /obj/item/clothing/suit/armor/f13/chitinarmor
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/chitin = 12,
				/obj/item/stack/sheet/sinew = 4,
				/obj/item/stack/sheet/cloth = 4)

/datum/crafting_recipe/tribalwar/goliathcloak
	name = "Deathclaw cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/deathclaw = 4)

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

/datum/crafting_recipe/tribalwar/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)

/datum/crafting_recipe/tribalwar/tribe_armor
	name = "Tribal Hide Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 6)
	tools = list(TOOL_WORKBENCH)

//WEAPONS//

/datum/crafting_recipe/tribalwar/bonespear
	name = "Bone Spear"
	result = /obj/item/twohanded/spear/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/sinew = 1)

/datum/crafting_recipe/tribalwar/boneaxe
	name = "Bone Axe"
	result = /obj/item/twohanded/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				/obj/item/stack/sheet/sinew = 3)

/datum/crafting_recipe/tribalwar/warclub
	name = "Carve Wooden Warclub"
	result = /obj/item/claymore/machete/warclub
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/blowgun
	name = "String Wooden Bow"
	result = /obj/item/gun/syringe/blowgun
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/bamboo = 10)

/datum/crafting_recipe/tribalwar/tribe_bow
	name = "String Wooden Bow"
	result = /obj/item/gun/ballistic/automatic/tribalbow
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/sinew = 3)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/bone_bow
	name = "Bone Bow"
	result = /obj/item/gun/ballistic/bow/ashen
	time = 120 // 80+120 = 200
	always_availible = FALSE
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/sinew = 4)

/datum/crafting_recipe/tribalwar/tribe_quiver
	name = "Craft Quiver and Arrows"
	result = /obj/item/storage/belt/tribe_quiver
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/training_machete
	name = "Training Machete"
	result = /obj/item/claymore/machete/training
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/spearquiver
	name = "Spear Quiver"
	result = /obj/item/storage/backpack/spearquiver
	time = 60
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/metal = 1)

/datum/crafting_recipe/tribalwar/arrowap
	name = "Sturdy Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ap
	time = 40
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/crafting/metalparts = 2)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowpoison
	name = "Poison Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/grown/nettle/basic = 5)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowburn
	name = "Burning Oil Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/burning
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1,
				/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 4)
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

/datum/crafting_recipe/tribal/bonebag
	name = "Tribal Satchel"
	result = /obj/item/storage/backpack/satchel/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 3,
				/obj/item/stack/sheet/sinew = 2)

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

/datum/crafting_recipe/talisman
	name = "Hunter's talisman"
	result = /obj/item/clothing/neck/cloak/amulet
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS
*/

/datum/crafting_recipe/tribal/cloakbrown
	name = "Cloak"
	result = /obj/item/clothing/neck/cloak
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribal/cloakdark
	name = "Dark Cloak"
	result = /obj/item/clothing/neck/cloak/grey
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)

/datum/crafting_recipe/tribal/bonedie
	name = "Carve Bone Die"
	result = /obj/item/dice/d6
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1)
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribal/maletribal
	name = "Coarse Tribal outfit"
	result = /obj/item/clothing/under/f13/tribal
	reqs = list(/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	time = 30

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

/*
/datum/crafting_recipe/warmace
	name = "Carve Wooden Warmace"
	result = /obj/item/twohanded/sledgehammer/warmace
	time = 100
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

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
*/
