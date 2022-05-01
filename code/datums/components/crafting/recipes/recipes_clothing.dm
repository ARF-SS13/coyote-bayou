/////////
//BELTS//
/////////

/datum/crafting_recipe/bandolier
	name = "Bandolier"
	result = /obj/item/storage/belt/bandolier
	reqs = list(/obj/item/stack/sheet/hay = 3,
				/obj/item/stack/sheet/leather = 4)
	tools = list(TOOL_WORKBENCH)
	time = 40
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/belt
	name = "Belt"
	result = /obj/item/storage/belt
	reqs = list(/obj/item/stack/sheet/hay = 3,
				/obj/item/stack/sheet/leather = 3)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/chestrig
	name = "Chest Rig"
	result = /obj/item/storage/belt/military
	tools = list(TOOL_AWORKBENCH)
	reqs = list(/obj/item/stack/sheet/plastic = 2,
				/obj/item/stack/sheet/leather = 3)
	time = 30
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/webbing
	name = "Webbing"
	result = /obj/item/storage/belt/military/alt
	reqs = list(/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/shoulderholster
	name = "Shoulder Holster"
	result = /obj/item/storage/belt/holster
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/hay = 3)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/legholster
	name = "Leg Holster"
	result = /obj/item/storage/belt/holster/legholster
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/hay = 3)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/medolier
	name = "Medolier"
	result =  /obj/item/storage/belt/medolier
	reqs = list(/obj/item/stack/sheet/metal = 2,
	/obj/item/stack/sheet/cloth = 3,
	/obj/item/stack/sheet/plastic = 4)
	time = 30
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/durathread_toolbelt
	name = "Durathread Toolbelt"
	result = /obj/item/storage/belt/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 5,
				/obj/item/stack/sheet/leather = 2)
	time = 30
	category = CAT_CLOTHING
	subcategory = CAT_BELTS
	always_available = FALSE

/datum/crafting_recipe/durathread_bandolier
	name = "Durathread Bandolier"
	result = /obj/item/storage/belt/bandolier/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 6,
				/obj/item/stack/sheet/leather = 2)
	time = 50
	category = CAT_CLOTHING
	subcategory = CAT_BELTS
	always_available = FALSE

/datum/crafting_recipe/durathread_wintercoat
	name = "Durathread Winter Coat"
	result = /obj/item/clothing/suit/hooded/wintercoat/durathread
	reqs = list(/obj/item/stack/sheet/durathread = 12,
				/obj/item/stack/sheet/leather = 10)
	time = 70
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/heavysheath
	name = "Heavy-Duty Sheath"
	result = /obj/item/storage/belt/sabre/heavy
	reqs = list(/obj/item/stack/sheet/hay = 1,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/crafting/metalparts = 2)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/datum/crafting_recipe/twinsheath
	name = "Twin Sheath"
	result = /obj/item/storage/belt/sword/twin
	reqs = list(/obj/item/stack/sheet/hay = 1,
				/obj/item/stack/sheet/leather = 3,
				/obj/item/stack/crafting/metalparts = 2)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_BELTS

/////////
//SHOES//
/////////

/datum/crafting_recipe/laceup
	name = "Laceup shoes"
	result = /obj/item/clothing/shoes/laceup
	reqs = list(/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/sneakers
	name = "Sneakers"
	result = /obj/item/clothing/shoes/sneakers/black
	reqs = list(/obj/item/stack/sheet/cloth = 2)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/footcloths
	name = "Footcloths"
	result = /obj/item/clothing/shoes/f13/rag
	reqs = list(/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	time = 5
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/cowboy
	name = "Cowboy boots"
	result = /obj/item/clothing/shoes/f13/cowboy
	reqs = list(/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/explorer
	name = "Work boots"
	result = /obj/item/clothing/shoes/f13/explorer
	reqs = list(/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/fancy
	name = "Leather shoes, black"
	result = /obj/item/clothing/shoes/f13/fancy
	reqs = list(/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	time = 15
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/brownie
	name = "Leather shoes, brown"
	result = /obj/item/clothing/shoes/f13/brownie
	reqs = list(/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/datum/crafting_recipe/tan
	name = "Leather shoes, tan"
	result = /obj/item/clothing/shoes/f13/tan
	reqs = list(/obj/item/stack/sheet/leather = 1)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_SHOES

/*
/datum/crafting_recipe/armwraps
	name = "Armwraps"
	result = /obj/item/clothing/gloves/fingerless/pugilist
	time = 60
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/stack/sheet/cloth = 4,
				/obj/item/stack/sticky_tape = 2,
				/obj/item/stack/sheet/leather = 2)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/briefcase
	name = "Hand made Briefcase"
	result = /obj/item/storage/briefcase/crafted
	time = 35
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/stack/sheet/cardboard = 1,
				/obj/item/stack/sheet/cloth = 2,
				/obj/item/stack/sheet/leather = 5)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/gripperoffbrand
	name = "Improvised Gripper Gloves"
	reqs = list(
			/obj/item/clothing/gloves/fingerless = 1,
//		    /obj/item/stack/sticky_tape = 1
			/obj/item/stack/cable_coil = 5,
			/obj/item/stack/sheet/cloth = 2,
	)
	result = /obj/item/clothing/gloves/tackler/offbrand
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	tools = list(TOOL_WIRECUTTER)
	time = 20
	always_available = FALSE

/datum/crafting_recipe/mummy
	name = "Mummification Bandages (Mask)"
	result = /obj/item/clothing/mask/mummy
	time = 10
	tools = list(/obj/item/nullrod/egyptian)
	reqs = list(/obj/item/stack/sheet/cloth = 2)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/mummy/body
	name = "Mummification Bandages (Body)"
	result = /obj/item/clothing/under/costume/mummy
	reqs = list(/obj/item/stack/sheet/cloth = 5)

/datum/crafting_recipe/lizardhat
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/lizard
	time = 10
	reqs = list(/obj/item/organ/tail/lizard = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/lizardhat_alternate
	name = "Lizard Cloche Hat"
	result = /obj/item/clothing/head/lizard
	time = 10
	reqs = list(/obj/item/stack/sheet/animalhide/lizard = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/kittyears
	name = "Kitty Ears"
	result = /obj/item/clothing/head/kitty/genuine
	time = 10
	reqs = list(/obj/item/organ/tail/cat = 1,
				/obj/item/organ/ears/cat = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE
*/

/datum/crafting_recipe/papermask	//Citadel item
	name = "Paper Mask"
	result = /obj/item/clothing/mask/paper
	reqs = list(/obj/item/paper = 20)
	tools = list(TOOL_WORKBENCH)
	time = 10
	category = CAT_CLOTHING
	subcategory = CAT_MISCCLOTHING	//F13 category

/*
/datum/crafting_recipe/hudsunsec
	name = "Security HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/security/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/security = 1,
					/obj/item/clothing/glasses/sunglasses = 1)
	reqs = list(/obj/item/clothing/glasses/hud/security = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/hudsunsecremoval
	name = "Security HUD removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security/sunglasses = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/hudsunmed
	name = "Medical HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/health/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/health = 1,
				/obj/item/clothing/glasses/sunglasses = 1)
	reqs = list(/obj/item/clothing/glasses/hud/health = 1,
				/obj/item/clothing/glasses/sunglasses = 1,
				/obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/hudsunmedremoval
	name = "Medical HUD removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health/sunglasses = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/beergoggles
	name = "Beer Goggles"
	result = /obj/item/clothing/glasses/sunglasses/reagent
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/science = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/beergogglesremoval
	name = "Beer Goggles removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/sunglasses/reagent = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/diagnostic_sunglasses
	name = "Diagnostic HUDsunglasses"
	result = /obj/item/clothing/glasses/hud/diagnostic/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/diagnostic = 1,
				/obj/item/clothing/glasses/sunglasses = 1)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic = 1,
				  /obj/item/clothing/glasses/sunglasses = 1,
				  /obj/item/stack/cable_coil = 5)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/diagnostic_sunglasses_removal
	name = "Diagnostic HUDsunglasses removal"
	result = /obj/item/clothing/glasses/sunglasses
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic/sunglasses = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/ghostsheet
	name = "Ghost Sheet"
	result = /obj/item/clothing/suit/ghost_sheet
	time = 5
	tools = list(TOOL_WIRECUTTER)
	reqs = list(/obj/item/bedsheet = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES

/datum/crafting_recipe/secpatch
	name = "Security Eyepatch HUD"
	result = /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/security/sunglasses = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	reqs = list(/obj/item/clothing/glasses/hud/security/sunglasses = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/secpatch_removal
	name = "Security HUDpatch Removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/security/sunglasses/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/medpatch
	name = "Medical Eyepatch HUD"
	result = /obj/item/clothing/glasses/hud/health/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/health = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	reqs = list(/obj/item/clothing/glasses/hud/health = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/medpatch_removal
	name = "Medical HUDpatch Removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/health/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/diagpatch
	name = "Diagnostic Eyepatch HUD"
	result = /obj/item/clothing/glasses/hud/diagnostic/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/hud/diagnostic = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/diagpatch_removal
	name = "Diagnostic HUDpatch Removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/hud/diagnostic/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/mesonpatch
	name = "Meson Scanner Eyepatch"
	result = /obj/item/clothing/glasses/meson/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	parts = list(/obj/item/clothing/glasses/meson = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	reqs = list(/obj/item/clothing/glasses/meson = 1,
				/obj/item/clothing/glasses/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

/datum/crafting_recipe/mesonpatch_removal
	name = "Meson Scanner patch Removal"
	result = /obj/item/clothing/glasses/eyepatch
	time = 20
	tools = list(TOOL_SCREWDRIVER, TOOL_WIRECUTTER)
	reqs = list(/obj/item/clothing/glasses/meson/eyepatch = 1)
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	always_available = FALSE

	/datum/crafting_recipe/garlic_necklace
	name = "Garlic Necklace"
	result = /obj/item/clothing/neck/garlic_necklace
	reqs = list(/obj/item/reagent_containers/food/snacks/grown/garlic = 15,
				/obj/item/stack/cable_coil = 10)
	time = 100 //Takes awhile to put all the garlics on the coil and knot it.
	category = CAT_CLOTHING
	subcategory = CAT_GENCLOTHES
	*/
