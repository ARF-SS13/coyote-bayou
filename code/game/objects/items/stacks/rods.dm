GLOBAL_LIST_INIT(rod_recipes, list ( \
	new/datum/stack_recipe("table frame", /obj/structure/table_frame, 2, time = 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("metal bars", /obj/structure/barricade/bars, 8, time = 20, one_per_turf = 1, on_floor = 0), \
	new/datum/stack_recipe("metal bars with window", /obj/structure/barricade/barswindow, 4, time = 10, one_per_turf = 1, on_floor = 0), \
	new/datum/stack_recipe("barred door", /obj/structure/simple_door/metal/barred, 30, time = 40, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("railing", /obj/structure/railing, 3, time = 18, window_checks = TRUE), \
	new/datum/stack_recipe("grille", /obj/structure/grille, 2, time = 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("flagpole", /obj/item/flag, 2, time = 8, one_per_turf = 1, on_floor = 1), \
	null, \
	new/datum/stack_recipe_list("fences", list( \
		new /datum/stack_recipe("fence", /obj/structure/fence,8, time = 20, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("fence (corner)", /obj/structure/fence/corner, 8, time = 20, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("fence (end)", /obj/structure/fence/end, 8, time = 20, one_per_turf = 1, on_floor = 1), \
		new /datum/stack_recipe("fence (gate)", /obj/structure/simple_door/metal/fence, 8, time = 20, one_per_turf = 1, on_floor = 1), \
		)),
	null, \
	new/datum/stack_recipe("barbed wire",/obj/structure/obstacle/barbedwire, 5, time = 10, one_per_turf = 1, on_floor = 1), \
	new/datum/stack_recipe("barbed wire ends", /obj/structure/obstacle/barbedwire/end, 5, time = 10, one_per_turf = 1, on_floor = 1), \
	))
/obj/item/stack/rods
	name = "metal rod"
	desc = "Metal rods useful for building various frames and supporting structures."
	singular_name = "metal rod"
	icon_state = "rods"
	item_state = "rods"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	force = 9
	throwforce = 10
	throw_speed = 3
	throw_range = 7
	custom_materials = list(/datum/material/iron=1000)
	max_amount = 100
	attack_verb = list("hit", "bludgeoned", "whacked")
	hitsound = 'sound/weapons/grenadelaunch.ogg'
	embedding = list()
	novariants = TRUE
	merge_type = /obj/item/stack/rods

/obj/item/stack/rods/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	update_icon()

/obj/item/stack/rods/get_main_recipes()
	. = ..()
	. += GLOB.rod_recipes

/obj/item/stack/rods/update_icon_state()
	var/amount = get_amount()
	if(amount <= 5)
		icon_state = "rods-[amount]"
	else
		icon_state = "rods"

/obj/item/stack/rods/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/weldingtool))
		if(get_amount() < 2)
			to_chat(user, span_warning("You need at least two rods to do this!"))
			return

		if(W.use_tool(src, user, 0, volume=40))
			var/obj/item/stack/sheet/metal/new_item = new(usr.loc)
			user.visible_message("[user.name] shaped [src] into metal with [W].", \
						span_notice("You shape [src] into metal with [W]."), \
						span_italic("You hear welding."))
			var/obj/item/stack/rods/R = src
			src = null
			var/replace = (user.get_inactive_held_item()==R)
			R.use(2)
			if (!R && replace)
				user.put_in_hands(new_item)

	else if(istype(W, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = W
		if(amount != 1)
			to_chat(user, span_warning("You must use a single rod!"))
		else if(S.w_class > WEIGHT_CLASS_SMALL)
			to_chat(user, span_warning("The ingredient is too big for [src]!"))
		else
			var/obj/item/reagent_containers/food/snacks/customizable/A = new/obj/item/reagent_containers/food/snacks/customizable/kebab(get_turf(src))
			A.initialize_custom_food(src, S, user)
	else
		return ..()

/obj/item/stack/rods/cyborg
	custom_materials = null
	is_cyborg = 1
	cost = 250
	merge_type = /obj/item/stack/rods/cyborg

/obj/item/stack/rods/cyborg/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/stack/rods/ten
	amount = 10

/obj/item/stack/rods/twentyfive
	amount = 25

/obj/item/stack/rods/fifty
	amount = 50

/obj/item/stack/rods/two //for surgical tables
	amount = 2

/obj/item/stack/rods/lava
	name = "heat resistant rod"
	desc = "Treated, specialized metal rods. When exposed to the vaccum of space their coating breaks off, but they can hold up against the extreme heat of active lava."
	singular_name = "heat resistant rod"
	icon_state = "rods"
	item_state = "rods"
	color = "#5286b9ff"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=1000, /datum/material/plasma=500, /datum/material/titanium=2000)
	max_amount = 100
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	merge_type = /obj/item/stack/rods/lava

/obj/item/stack/rods/lava/thirty
	amount = 30

/obj/item/stack/rods/scaffold // fortnite bars
	name = "Pre-Fall aerial foundation"
	desc = "A set of extra-light, ultra-sturdy DIY structural supports, able to connect to just about anything and support an entire \
		floor of a house, with a bit of work. Based on schematics looted from various ancient architectural companies and 'refined' down \
		into a simple recipe that anyone can put together, given the right materials. Also able to withstand lava, if you feel like living \
		in a volcano."
	singular_name = "Pre-Fall aerial foundation"
	icon_state = "rods"
	item_state = "rods"
	color = "#f44a4aff"
	flags_1 = CONDUCT_1
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(
		/datum/material/iron = (MINERAL_MATERIAL_AMOUNT * 5),
		/datum/material/plastic = (MINERAL_MATERIAL_AMOUNT * 1),
		/datum/material/bronze = (MINERAL_MATERIAL_AMOUNT * 1),
		/datum/material/plasma = (MINERAL_MATERIAL_AMOUNT * 0.5),
		/datum/material/titanium = (MINERAL_MATERIAL_AMOUNT * 0.5)
		)
	max_amount = 100
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	merge_type = /obj/item/stack/rods/scaffold

/obj/item/stack/rods/scaffold/ten
	amount = 10

/obj/item/stack/rods/scaffold/get_main_recipes()
	return list()
