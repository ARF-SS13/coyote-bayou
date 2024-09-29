/datum/crafting_recipe/tribal_torchbonfire
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

/datum/crafting_recipe/bonfire
	name = "Bonfire"
	time = 60
	reqs = list(/obj/item/stack/sheet/mineral/wood = 30)
	result = /obj/structure/bonfire
	category = CAT_PRIMAL

/datum/crafting_recipe/bonfirecaps
	name = "Bonfire"
	time = 60
	reqs = list(/obj/item/grown/log = 5)
	result = /obj/structure/bonfire
	category = CAT_PRIMAL

/datum/crafting_recipe/campfire //Adding a campfire; it takes less expertise, and less ingredients than the bonfire available to primals, but it's also less grand and takes more time.
	name = "Campfire"
	time = 75
	reqs = list(/obj/item/stack/sheet/mineral/wood = 20)
	result = /obj/structure/campfire
	category = CAT_PRIMAL
	always_available = TRUE

/datum/crafting_recipe/spearfisher
	name = "Spearfisher"
	time = 60
	reqs = list(/obj/item/grown/log = 2,
				/obj/item/weaponcrafting/string = 1,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/leather = 3)
	result = /obj/item/fishingrod/spearfisher
	category = CAT_PRIMAL

/datum/crafting_recipe/wonderglue
	name = "Wonder Glue"
	time = 60
	always_available = TRUE
	tools = list(TOOL_WORKBENCH)
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/leather = 1,
				/obj/item/stack/sheet/sinew = 1)
	result = /obj/item/crafting/wonderglue
	category = CAT_PRIMAL

/datum/crafting_recipe/food/pemmican
	name = "Pemmican"
	always_available = FALSE
	tools = list(TOOL_WORKBENCH)
	reqs = list(
		/obj/item/reagent_containers/food/snacks/meatball = 15,
		/datum/reagent/consumable/eggyolk = 25,
		/obj/item/reagent_containers/food/snacks/grown/yucca = 5,
		/obj/item/reagent_containers/food/snacks/grown/pinyon = 5
	)
	result = /obj/item/reagent_containers/food/snacks/pemmican
	category = CAT_PRIMAL

/datum/crafting_recipe/duct_tape
	name = "Duct Tape" // Why was this named bonfire
	time = 60
	always_available = TRUE
	tools = list(TOOL_WORKBENCH)
	reqs = list(/obj/item/stack/sheet/durathread = 4,
				/obj/item/crafting/wonderglue = 1)
	result = /obj/item/crafting/duct_tape
	category = CAT_PRIMAL

/datum/crafting_recipe/headpikelegion
	name = "Spike Head (Throwing Spear)"
	time = 65
	reqs = list(/obj/item/throwing_star/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/throwing_star/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL

/datum/crafting_recipe/headpike
	name = "Spike Head (Glass Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/spear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/spear = 1)
	result = /obj/structure/headpike
	category = CAT_PRIMAL

/datum/crafting_recipe/headpikebone
	name = "Spike Head (Bone Spear)"
	time = 65
	reqs = list(/obj/item/twohanded/spear/bonespear = 1,
				/obj/item/bodypart/head = 1)
	parts = list(/obj/item/bodypart/head = 1,
			/obj/item/twohanded/spear/bonespear = 1)
	result = /obj/structure/headpike/bone
	category = CAT_PRIMAL

/datum/crafting_recipe/bow_tablet
	name = "Sandstone Bow Making Manual"
	result = /obj/item/book/granter/crafting_recipe/bone_bow
	time = 200 //Scribing // don't care
	always_available = FALSE
	reqs = list(/obj/item/stack/rods = 1,
				/obj/item/stack/sheet/mineral/sandstone = 4)
	category = CAT_PRIMAL

/datum/crafting_recipe/rib
	name = "Collosal Rib"
	always_available = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 10,
			/datum/reagent/oil = 5)
	result = /obj/structure/statue/bone/rib
	category = CAT_PRIMAL

/datum/crafting_recipe/skull
	name = "Skull Carving"
	always_available = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 6,
			/datum/reagent/oil = 5)
	result = /obj/structure/statue/bone/skull
	category = CAT_PRIMAL

/datum/crafting_recipe/halfskull
	name = "Cracked Skull Carving"
	always_available = FALSE
	reqs = list(
			/obj/item/stack/sheet/bone = 3,
			/datum/reagent/oil = 5)
	result = /obj/structure/statue/bone/skull/half
	category = CAT_PRIMAL

/datum/crafting_recipe/boneshovel
	name = "Serrated Bone Shovel"
	always_available = TRUE
	reqs = list(
			/obj/item/stack/sheet/bone = 4,
			/datum/reagent/oil = 5,
			/obj/item/shovel/spade = 1)
	result = /obj/item/shovel/serrated
	category = CAT_PRIMAL

/datum/crafting_recipe/wickerdoll
	name = "Wicker Doll"
	time = 15
	reqs = list(
			/obj/item/stack/sheet/hay = 25)
	result = /obj/item/voodoo
	category = CAT_PRIMAL

/datum/crafting_recipe/tribal_pa
	name = "Tribal Salvaged Power Armor"
	time = 120
	reqs = list(
			/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b = 1,
			/obj/item/stack/sheet/sinew = 2,
			/obj/item/stack/sheet/bone = 4
			)
	result = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribal_pa_helmet
	name = "Tribal Salvaged Power Armor Helmet"
	time = 120
	reqs = list(
			/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b = 1,
			/obj/item/stack/sheet/sinew = 1,
			/obj/item/stack/sheet/bone = 2
			)
	result = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribal_combat_armor
	name = "Tribal Combat Armor"
	time = 40
	reqs = list(
			/obj/item/clothing/suit/armor/medium/combat = 1,
			/obj/item/stack/sheet/sinew = 1,
			/obj/item/stack/sheet/bone = 2
			)
	result = /obj/item/clothing/suit/armor/medium/combat/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribal_r_combat_armor
	name = "Tribal Reinforced Combat Armor"
	time = 40
	reqs = list(
			/obj/item/clothing/suit/armor/medium/combat/mk2 = 1,
			/obj/item/stack/sheet/sinew = 1,
			/obj/item/stack/sheet/bone = 2
			)
	result = /obj/item/clothing/suit/armor/medium/combat/mk2/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribal_combat_armor_helmet
	name = "Tribal Combat Helmet"
	time = 40
	reqs = list(
			/obj/item/clothing/head/helmet/f13/combat = 1,
			/obj/item/stack/sheet/bone = 1
			)
	result = /obj/item/clothing/head/helmet/f13/combat/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/datum/crafting_recipe/tribal_r_combat_armor_helmet
	name = "Tribal Reinforced Combat Helmet"
	time = 40
	reqs = list(
			/obj/item/clothing/head/helmet/f13/combat/mk2 = 1,
			/obj/item/stack/sheet/bone = 1
			)
	result = /obj/item/clothing/head/helmet/f13/combat/mk2/tribal
	category = CAT_PRIMAL
	always_available = FALSE

/*
/datum/crafting_recipe/tribalwar/sturdybow
	name = "Sturdy Bow"
	result = /obj/item/gun/ballistic/bow/sturdy
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 5,
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/cloth = 5)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/goldenbow
	name = "Golden Bow"
	result = /obj/item/gun/ballistic/bow/gold
	time = 70
	reqs = list(/obj/item/stack/sheet/mineral/gold = 10,
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 5)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/silverbow
	name = "Silver Bow"
	result = /obj/item/gun/ballistic/bow/silver
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/silver = 10,
				/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 5)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/bonebow
	name = "Deathclaw Bow"
	result = /obj/item/gun/ballistic/bow/claw
	time = 80
	reqs = list(/obj/item/stack/sheet/animalhide/aethergiest = 6,
				/obj/item/stack/sheet/bone = 10,
				/obj/item/stack/sheet/sinew = 5)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/tribe_bow
	name = "Short Bow"
	result = /obj/item/gun/ballistic/bow/tribal
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL
	always_available = TRUE

/datum/crafting_recipe/tribalwar/crossbow
	name = "CrossBow"
	result = /obj/item/gun/ballistic/bow/crossbow
	time = 180
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/crafting/metalparts = 3,
				/obj/item/advanced_crafting_components/assembly = 1,
				/obj/item/advanced_crafting_components/alloys = 1,
				/obj/item/stack/sheet/glass = 4)
	category = CAT_PRIMAL
*/
/datum/crafting_recipe/tribalwar/rockbag
	name = "Bag for Rocks"
	result = /obj/item/ammo_box/rock/improvised
	time = 10
	reqs = list(/obj/item/weaponcrafting/string = 1,
					/obj/item/stack/sheet/cloth = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/tribalwar/sling
	name = "Sling"
	result = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling
	time = 30
	reqs = list(/obj/item/weaponcrafting/string = 1,
					/obj/item/stack/sheet/cloth = 1)
	category = CAT_PRIMAL

/datum/crafting_recipe/tribalwar/slingstaff
	name = "Sling Staff"
	result = /obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff
	time = 60
	reqs = list(/obj/item/weaponcrafting/string = 2,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/mineral/wood = 1)
	category = CAT_PRIMAL

//ARROWS

/* /datum/crafting_recipe/tribalwar/arrowburn
	name = "Burning Oil Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/burning
	time = 30
	reqs = list(/obj/item/ammo_casing/caseless/arrow = 1,
				/datum/reagent/fuel = 10)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowap
	name = "Sturdy Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ap
	time = 40
	reqs = list(
		/obj/item/stack/rods = 2,
		/obj/item/stack/crafting/metalparts = 2,
		)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowbronze
	name = "Bronze Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bronze
	time = 30
	reqs = list(/obj/item/stack/sheet/bronze = 1,
				/obj/item/stack/sheet/mineral/wood = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowgold
	name = "Golden Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/gold
	time = 30
	reqs = list(/obj/item/stack/sheet/mineral/gold = 1,
				/obj/item/stack/sheet/mineral/wood = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowpoison
	name = "Poison Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/poison
	time = 30
	reqs = list(
		/obj/item/ammo_casing/caseless/arrow = 1,
		/obj/item/reagent_containers/food/snacks/grown/feracactus = 1,
		)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowbone
	name = "Bone Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/bone
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/mineral/wood = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/cheaparrow
	name = "Lightweight Wooden Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/cheap
	time = 15
	reqs = list(/obj/item/stack/sheet/mineral/wood = 1,
				/obj/item/stack/sheet/mineral/sandstone = 2)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)


/datum/crafting_recipe/tribalwar/arrowwound
	name = "Serrated Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/serrated
	time = 10
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/stack/crafting/goodparts = 1
		)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowembed
	name = "Broadhead Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/broadhead
	time = 10
	reqs = list(
		/obj/item/stack/rods = 1,
		/obj/item/stack/crafting/goodparts = 1
		)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/datum/crafting_recipe/tribalwar/arrowemp
	name = "Ion-Spirit Arrow"
	result = /obj/item/ammo_casing/caseless/arrow/ion
	time = 30
	reqs = list(/obj/item/stack/crafting/electronicparts = 3,
				/obj/item/stack/rods = 2)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
 */
//MELEE

/datum/crafting_recipe/tribalwar/bonespear
	name = "Bone Spear"
	result = /obj/item/twohanded/spear/bonespear
	time = 30
	reqs = list(/obj/item/stack/sheet/bone = 4,
				/obj/item/stack/sheet/sinew = 1)
	category = CAT_PRIMAL
	always_available = TRUE

/datum/crafting_recipe/tribalwar/boneaxe
	name = "Bone Axe"
	result = /obj/item/twohanded/fireaxe/boneaxe
	time = 50
	reqs = list(/obj/item/stack/sheet/bone = 6,
				/obj/item/stack/sheet/sinew = 3)
	category = CAT_PRIMAL
	always_available = TRUE

/datum/crafting_recipe/tribalwar/warclub
	name = "Wooden Warclub"
	result = /obj/item/melee/onehanded/club/warclub
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 10,
				/obj/item/stack/sheet/cloth = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/light_quiver
	name = "light quiver"
	result = /obj/item/storage/bag/tribe_quiver/light
	time = 40
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2,
				/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/cloth = 6)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/tribe_quiver
	name = "belt quiver"
	result = /obj/item/storage/bag/tribe_quiver
	time = 80
	reqs = list(/obj/item/stack/sheet/mineral/wood = 4,
				/obj/item/stack/sheet/metal = 4,
				/obj/item/stack/sheet/leather = 6)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/heavy_quiver
	name = "heavy back quiver"
	result = /obj/item/storage/bag/tribe_quiver/heavy
	time = 120 //arbitrary numbers yay
	reqs = list(/obj/item/stack/sheet/mineral/wood = 6,
				/obj/item/stack/sheet/metal = 8,
				/obj/item/stack/sheet/leather = 8) //Nobody has ever or will ever make this because belt quivers would be superior if it required aethergiest kills
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = TRUE

/datum/crafting_recipe/tribalwar/spearquiver
	name = "Spear Quiver"
	result = /obj/item/storage/backpack/spearquiver/empty
	time = 60
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/metal = 1)
	category = CAT_PRIMAL
	always_available = TRUE

/datum/crafting_recipe/tribalwar/lighttribe
	name = "Light Tribal Armor"
	result = /obj/item/clothing/suit/armor/light/tribal/strips
	time = 75
	reqs = list(/obj/item/stack/sheet/leather = 3)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/heavytribe
	name = "Heavy Tribal Armor"
	result = /obj/item/clothing/suit/armor/medium/tribal/tribe_heavy_armor
	time = 300
	reqs = list(/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/leather = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/goliathcloak
	name = "Deathclaw cloak"
	result = /obj/item/clothing/suit/hooded/cloak/goliath
	time = 50
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/animalhide/aethergiest = 4)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/chitinarmor
	name = "Insect Chitin Armor"
	result = /obj/item/clothing/suit/armor/medium/tribal/chitinarmor
	time = 30
	reqs = list(/obj/item/stack/sheet/animalhide/chitin = 12,
				/obj/item/stack/sheet/sinew = 4,
				/obj/item/stack/sheet/cloth = 4)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/aethergiestspear
	name = "Deathclaw Spear"
	result = /obj/item/twohanded/spear/bonespear/aethergiest
	time = 240
	reqs = list(/obj/item/stack/sheet/animalhide/aethergiest = 6,
				/obj/item/stack/sheet/sinew = 2,
				/obj/item/stack/sheet/bone = 8,
				/obj/item/stack/sheet/mineral/wood = 10)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/lightcloak
	name = "Light Armored Cloak"
	result = /obj/item/clothing/suit/armor/light/tribal/geckocloak
	time = 120
	reqs = list(/obj/item/stack/sheet/animalhide/gecko = 4,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/bone = 1,
				/obj/item/stack/sheet/cloth = 2)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
	always_available = FALSE

/datum/crafting_recipe/tribalwar/legendaryclawcloak
	name = "Legendary Deathclaw Cloak"
	result = /obj/item/clothing/suit/hooded/cloak/hhunter
	time = 300
	reqs = list(/obj/item/melee/unarmed/aethergiestgauntlet = 1,
				/obj/item/stack/sheet/animalhide/chitin = 10,
				/obj/item/stack/sheet/cloth = 5,
				/obj/item/stack/sheet/sinew = 10,
				/obj/item/stack/crafting/goodparts= 3)

/datum/crafting_recipe/tribalradio
	name = "Primitive Radio"
	result = /obj/item/radio/tribal
	time = 25
	reqs = list(/obj/item/stack/crafting/electronicparts = 2,
				/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/cable_coil = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)

/* tdo
/datum/crafting_recipe/beartrap
	name = "Bear Trap"
	result = /obj/item/restraints/legcuffs/beartrap
	time = 25
	reqs = list(/obj/item/stack/crafting/metalparts = 2,
				/obj/item/stack/sheet/metal = 1)
	category = CAT_PRIMAL
	tools = list(TOOL_WORKBENCH)
*/

/datum/crafting_recipe/hay
	name = "hay"
	result = /obj/item/stack/sheet/hay
	time = 10
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/wheat = 1)
	category = CAT_PRIMAL
