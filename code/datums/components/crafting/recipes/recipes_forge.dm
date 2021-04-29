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
	category = CAT_MISC
	subcategory = CAT_TOOL

/datum/crafting_recipe/butchers
	name = "Butchers Knife"
	result = /obj/item/kitchen/knife/butcher
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/combat
	name = "Combat Knife"
	result = /obj/item/kitchen/knife/combat
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/combatbayonet
	name = "Bayonet Knife"
	result = /obj/item/kitchen/knife/combat/bayonet
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/kitchen
	name = "Kitchen Knife"
	result = /obj/item/kitchen/knife
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/ritual
	name = "Ritual Knife"
	result = /obj/item/kitchen/knife/ritualdagger
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/survival
	name = "Survival Knife"
	result = /obj/item/kitchen/knife/combat/survival
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/survival
	name = "Switchblade"
	result = /obj/item/switchblade
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/throwingknife
	name = "Throwing Knife"
	result = /obj/item/throwing_star/throwingknife
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 1)
	time = 300
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/bowie_knife
	name = "Bowie Knife"
	result = /obj/item/kitchen/knife/bowie
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/mineral/wood = 2)
	time = 300
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/trench_knife
	name = "Trench Knife"
	result = /obj/item/kitchen/knife/trench
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/crafting/goodparts = 2,
				/obj/item/stack/sheet/mineral/wood = 2)
	time = 300
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//swords
/datum/crafting_recipe/bmprsword
	name = "Bumper Sword"
	result = /obj/item/twohanded/fireaxe/bmprsword 
	reqs = list(/obj/item/stack/sheet/metal = 25,
				/obj/item/stack/sheet/cloth = 2)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/katana
	name = "Longsword"
	result = /obj/item/katana/scrap
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 2)
	time = 1000
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/spatha
	name = "Spatha"
	result = /obj/item/claymore/machete/spatha
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/sheet/bone = 2)
	time = 1000
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/gladuis
	name = "Gladius"
	result = /obj/item/claymore/machete/gladius
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 2)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/reinforcemachete
	name = "Machete"
	result = /obj/item/claymore/machete/reinforced
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/shortsword
	name = "Shortsword"
	result = /obj/item/claymore
	reqs = list(/obj/item/stack/sheet/metal = 15,
				/obj/item/stack/sheet/cloth = 2)
	time = 600
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE


//polearms

/*
/datum/crafting_recipe/bostaff
	name = "Quarterstaff"
	result = /obj/item/twohanded/bostaff
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 2)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/forgeglaive
	name = "Metal Glaive"
	result = /obj/item/twohanded/spear
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 4)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/forgethrowingspear
	name = "Throwing Spear"
	result = /obj/item/throwing_star/spear
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/mineral/wood = 3)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/*
/datum/crafting_recipe/harpoon
	name = "Harpoon"
	result = /obj/item/throwing_star/spear/harpoon
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON

/datum/crafting_recipe/pitchfork
	name = "Pitchfork"
	result = /obj/item/twohanded/pitchfork
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 3)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/sythe //fucc english
	name = "Scythe"
	result = /obj/item/scythe
	time = 400
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 4)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//blunt

/datum/crafting_recipe/sledge
	name = "Sledgehammer"
	result = /obj/item/twohanded/sledgehammer
	time = 1000
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/mineral/wood = 5)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/pipe
	name = "Pipe"
	result = /obj/item/claymore/machete/pipe
	time = 50
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/golf
	name = "Golf Club"
	result = /obj/item/claymore/machete/golf/teniron
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 10)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/pan
	name = "Frying Pan"
	result = /obj/item/claymore/machete/pipe/pan
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

//miscweapons

/*
/datum/crafting_recipe/fire_axe
	name = "Wood Axe"
	result = /obj/item/twohanded/twohanded/fireaxe
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEWEAPON
*/

/datum/crafting_recipe/pick_axe
	name = "Pickaxe"
	result = /obj/item/pickaxe
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/cpick_axe
	name = "Compact Pickaxe"
	result = /obj/item/pickaxe/mini
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/shovel
	name = "Shovel"
	result = /obj/item/shovel
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/hatchet
	name = "Hatchet"
	result = /obj/item/hatchet
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/entrenching_tool
	name = "Pattern 2281 Entrenching Tool"
	result = /obj/item/shovel/trench
	time = 300
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 1,
				/obj/item/stack/sheet/mineral/wood = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
	always_availible = FALSE


//fists

/datum/crafting_recipe/knucklespike
	name = "Spiked Knuckledusters"
	result = /obj/item/melee/unarmed/brass/spiked
	time = 50
	reqs = list(/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/sap
	name = "Sappers"
	result = /obj/item/melee/unarmed/sappers
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/maceglove
	name = "Mace Glove"
	result = /obj/item/melee/unarmed/maceglove
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 20)
	tools = list(TOOL_FORGE)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE

/datum/crafting_recipe/cosmicknife
	name = "cosmic knife"
	result = /obj/item/kitchen/knife/cosmic
	reqs = list(/obj/item/kitchen/knife/cosmicdirty = 1,
				/obj/item/crafting/abraxo = 1)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
	time = 30

/datum/crafting_recipe/cosmicknifeheated
	name = "superheated cosmic knife"
	result = /obj/item/kitchen/knife/cosmicheated
	reqs = list(/obj/item/kitchen/knife/cosmic = 1,
				/datum/reagent/fuel = 25)
	tools = list(TOOL_WORKBENCH)
	category = CAT_WEAPONRY
	subcategory = CAT_MELEE
	time = 40

//armorhelmets

/datum/crafting_recipe/salvagePA
	name = "Salvaged PA Helmet"
	result = /obj/item/clothing/head/helmet/f13/tribal
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/bighorn
	name = "Bighorner Helmet"
	result = /obj/item/clothing/head/helmet/f13/fiend_reinforced
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 1,
				/obj/item/stack/sheet/cloth = 6)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/metalhelmet
	name = "Metal Helmet"
	result = /obj/item/clothing/head/helmet/knight/f13/metal/reinforced
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/swag
	name = "Flame Metal Helmet"
	result = /obj/item/clothing/head/helmet/knight/f13/rider
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/potonheaddamn
	name = "Salvaged Metal Helmet"
	result = /obj/item/clothing/head/f13/pot
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 1)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/salvageweld
	name = "Salvaged Welding Mask"
	result = /obj/item/clothing/head/welding/f13/fire
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/*
/datum/crafting_recipe/legionaire
	name = "Legionaire Helmet"
	result = /obj/item/clothing/head/helmet/roman/legionaire
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR
*/

/datum/crafting_recipe/glad
	name = "Gladiator Helmet"
	result = /obj/item/clothing/head/helmet/gladiator
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/salvecomb
	name = "Salvaged Combat Helmet"
	result = /obj/item/clothing/head/helmet/f13/raidercombathelmet
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/mmask
	name = "Metal Mask"
	result = /obj/item/clothing/head/helmet/f13/metalmask/mk2
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

//armors

/datum/crafting_recipe/heavytribe
	name = "Heavy Tribal Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_heavy_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 20,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/datum/crafting_recipe/lighttribe
	name = "Light Tribal Armor"
	result = /obj/item/clothing/suit/armor/f13/tribe_armor
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

/*
/datum/crafting_recipe/plate
	name = "Plate Armor"
	result = /obj/item/clothing/suit/armor/plate/crusader/plate
	time = 600
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 10)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR
*/
/*
/datum/crafting_recipe/thejugg
	name = "Juggernaut Armor"
	result = /obj/item/clothing/suit/armor/plate/crusader/jugger
	time = 1000
	reqs = list(/obj/item/stack/sheet/metal = 90,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR

/datum/crafting_recipe/thejugghelm
	name = "Juggernaut Helmet"
	result = /obj/item/clothing/head/helmet/plate/crusader/jugger
	time = 500
	reqs = list(/obj/item/stack/sheet/metal = 30,
				/obj/item/stack/sheet/cloth = 3)
	tools = list(TOOL_FORGE)
	category = CAT_FORGE
	subcategory = CAT_FORGEARMOR
*/

//shoe

/datum/crafting_recipe/plateboot
	name = "Plate Boots"
	result = /obj/item/clothing/shoes/f13/military/plated
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR

//glove

/datum/crafting_recipe/plateglove
	name = "Plate Gloves"
	result = /obj/item/clothing/gloves/legion/plated
	time = 100
	reqs = list(/obj/item/stack/sheet/metal = 5,
				/obj/item/stack/sheet/cloth = 5)
	tools = list(TOOL_FORGE)
	category = CAT_CLOTHING
	subcategory = CAT_ARMOR
