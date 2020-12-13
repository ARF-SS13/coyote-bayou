/datum/crafting_recipe/machete
	name = "Machete"
	result = /obj/item/claymore/machete
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WELDER, TOOL_FORGE)
	category = CAT_PRIMAL
	subcategory = CAT_FORGE

/datum/crafting_recipe/gladius
	name = "Machete Gladius"
	result = /obj/item/claymore/machete/gladius
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 2)
	tools = list(TOOL_WELDER, TOOL_FORGE)
	category = CAT_PRIMAL
	subcategory = CAT_FORGE

/datum/crafting_recipe/forgeglaive
	name = "Improvised Metal Glaive"
	result = /obj/item/spear
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 10,
				/obj/item/stack/sheet/mineral/wood = 4)
	tools = list(TOOL_WELDER, TOOL_FORGE)
	category = CAT_PRIMAL
	subcategory = CAT_FORGE

/datum/crafting_recipe/forgethrowingspear
	name = "Throwing Spear"
	result = /obj/item/throwing_star/spear
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 2,
				/obj/item/stack/sheet/mineral/wood = 3)
	tools = list(TOOL_WELDER, TOOL_FORGE)
	category = CAT_PRIMAL
	subcategory = CAT_FORGE

/datum/crafting_recipe/legionshield
	name = "Legion Shield"
	result = /obj/item/shield/legion
	time = 80
	reqs = list(/obj/item/stack/sheet/metal = 6,
				/obj/item/stack/sheet/mineral/wood = 6)
	tools = list(TOOL_WELDER, TOOL_FORGE)
	category = CAT_PRIMAL
	subcategory = CAT_FORGE
