/datum/crafting_recipe/scavengerod
	name = "Scavenge For Rods"
	result = /obj/item/stack/rods
	time = 600
	category = CAT_PRIMAL

/datum/crafting_recipe/scavengemetal
	name = "Scavenge For Plating"
	result = /obj/item/stack/sheet/metal
	time = 600
	category = CAT_PRIMAL

/datum/crafting_recipe/bonearmor
	name = "Bone Armor"
	result = /obj/item/clothing/suit/armor/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 6)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/chitinarmor
	name = "Insect Chitin Armor"
	result = /obj/item/clothing/suit/armor/f13/chitinarmor
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/chitin = 12,
				/obj/item/stack/sheet/sinew = 4,
				/obj/item/stack/sheet/cloth = 4)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/bonetalisman
	name = "Bone Talisman"
	result = /obj/item/clothing/accessory/talisman
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonecodpiece
	name = "Skull Codpiece"
	result = /obj/item/clothing/accessory/skullcodpiece
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/animalhide/deathclaw = 1) //changed from goliath to deathclaw
	category = CAT_PRIMAL

/datum/crafting_recipe/bracers
	name = "Bone Bracers"
	result = /obj/item/clothing/gloves/bracer
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/skullhelm
	name = "Skull Helmet"
	result = /obj/item/clothing/head/helmet/skull
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/bonedagger
	name = "bone dagger"
	result = /obj/item/kitchen/knife/combat/bone
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 2)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/bonespear
	name = "Bone Spear"
	result = /obj/item/twohanded/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS

/datum/crafting_recipe/boneaxe
	name = "Bone Axe"
	result = /obj/item/twohanded/twohanded/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS
*/

/datum/crafting_recipe/bonepestle
	name = "Bone Pestle"
	result = /obj/item/pestle
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/bonemortar
	name = "Bone Mortar"
	result = /obj/item/reagent_containers/glass/mortar
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/primitive_chem_isolator
	name = "Bone Chemical Isolator"
	result = /obj/item/reagent_containers/glass/primitive_chem_isolator
	time = 20
	reqs = list(/obj/item/stack/sheet/bone = 3)
	category = CAT_PRIMAL

/datum/crafting_recipe/tribal_torch
	name = "Tribal Torch"
	result = /obj/item/candle/tribal_torch
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/handheld_torch
	name = "Handheld Torch"
	result = /obj/item/flashlight/flare/torch
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/wood = 3,
				/obj/item/stack/sheet/cloth = 1)
	category = CAT_PRIMAL

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

/datum/crafting_recipe/headpikelegion
	name = "Spike Head (Throwing Spear)"
	time = 65
	reqs = list(/obj/item/throwing_star/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/throwing_star/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL

/datum/crafting_recipe/goliathcloak
	name = "Deathclaw cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/deathclaw = 4)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/tatteredredcloak
	name = "Tattered red cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/sinew = 1,
				/obj/item/stack/sheet/cloth = 2)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/*
/datum/crafting_recipe/talisman
	name = "Hunter's talisman"
	result = /obj/item/clothing/neck/cloak/amulet
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	subcategory = CAT_TRIBAL_WEAPONS
*/

/datum/crafting_recipe/cloakbrown
	name = "Cloak"
	result = /obj/item/clothing/neck/cloak
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

/datum/crafting_recipe/cloakdark
	name = "Dark Cloak"
	result = /obj/item/clothing/neck/cloak/grey
	time = 50
	reqs = list(/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 2)
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

/datum/crafting_recipe/bonedie
	name = "Carve Bone Die"
	result = /obj/item/dice/d6
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL

/datum/crafting_recipe/warclub
	name = "Carve Wooden Warclub"
	result = /obj/item/claymore/machete/warclub
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_PRIMAL

/datum/crafting_recipe/tribe_bow
	name = "String Wooden Bow"
	result = /obj/item/gun/ballistic/automatic/tribalbow
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/sinew = 3)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_WEAPON

/datum/crafting_recipe/tribe_quiver
	name = "Craft Quiver and Arrows"
	result = /obj/item/storage/belt/tribe_quiver
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 8,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/tribe_armor
	name = "Tribe Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 80
	reqs = list(/obj/item/stack/sheet/leather = 6)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/tribaloutfit
	name = "Male Tribal Outfit"
	result = /obj/item/clothing/under/f13/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

/datum/crafting_recipe/tribaloutfitfemale
	name = "Female Tribal Outfit"
	result = /obj/item/clothing/under/f13/female/tribal
	time = 20
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_CLOTHING
	subcategory = CAT_WASTELAND

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
*/

/datum/crafting_recipe/training_machete
	name = "training machete"
	result = /obj/item/claymore/machete/training
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/spearquiver
	name = "Spear Quiver"
	result = /obj/item/storage/backpack/spearquiver
	time = 60
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/metal = 1)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/arrowap
	name = "Sturdy Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ap
	time = 40
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/crafting/metalparts = 2)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/arrowpoison
	name = "Poison Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/grown/nettle/basic = 5)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/datum/crafting_recipe/arrowburn
	name = "Burn Posion Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/burning
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/obj/item/reagent_containers/food/drinks/bottle = 1,
				/obj/item/reagent_containers/food/snacks/meat/slab/human/ghoul = 4)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_AMMO

/*
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
