/proc/get_supplykit_items(allow_sales = TRUE, allow_restricted = TRUE, other_filter = list())
	var/list/filtered_supplykit_items = GLOB.supplykit_categories.Copy() // list of supplykit categories without associated values.
	var/list/sale_items = list()

	var/list/rest_of_them = GLOB.supplykit_items.Copy()
	var/list/important_ones = list()

	for(var/path in GLOB.supplykit_items)
		var/datum/supplykit_item/sukit = path
		if(initial(sukit.important) == TRUE)
			rest_of_them -= path
			important_ones += path

	/// stacks rest of them under important_ones
	important_ones += rest_of_them

	for(var/path in important_ones)
		var/datum/supplykit_item/I = new path
		if (I.restricted && !allow_restricted)
			continue
		if (I.type in other_filter)
			continue
		LAZYSET(filtered_supplykit_items[I.category], I.name, I)

		if(I.limited_stock < 0 && !I.cant_discount && I.item && I.cost > 1)
			sale_items += I
	if(allow_sales)
		for(var/i in 1 to 15)
			var/datum/supplykit_item/I = pick_n_take(sale_items)
			var/datum/supplykit_item/A = new I.type
			var/discount = A.get_discount()
			var/list/disclaimer = list("Void where prohibited.", "Not recommended for children.", "Contains small parts.", "Check local laws for legality in region.", "Do not taunt.", "Not responsible for direct, indirect, incidental or consequential damages resulting from any defect, error or failure to perform.", "Keep away from fire or flames.", "Product is provided \"as is\" without any implied or expressed warranties.", "As seen on TV.", "For recreational use only.", "Use only as directed.", "16% sales tax will be charged for orders originating within Nebraska.")
			A.limited_stock = 1
			if(A.cost >= 20)
				discount *= 0.5
			A.cost = max(round(A.cost * discount),1)
			A.category = "Discounted Gear"
			A.name += " ([round(((initial(A.cost)-A.cost)/initial(A.cost))*100)]% off!)"
			A.desc += " Normally costs [initial(A.cost)] supply tokens. All sales final. [pick(disclaimer)]"
			A.item = I.item

			LAZYSET(filtered_supplykit_items[A.category], A.name, A)

	for(var/category in filtered_supplykit_items)
		if(!filtered_supplykit_items[category]) //empty categories with no associated supplykit item. Remove.
			filtered_supplykit_items -= category

	return filtered_supplykit_items


/**
 * Supplykit Items
 *
 * Items that can be spawned from a supplykit
**/
/datum/supplykit_item
	var/name = "item name"
	var/category = "item category"
	var/desc = "item description"
	var/item = null // Path to the item to spawn.
	var/cost = 0
	var/important = FALSE //for putting an entry at the top of the page
	var/surplus = 100 // Chance of being included in the surplus crate.
	var/cant_discount = FALSE
	var/limited_stock = -1 //Setting this above zero limits how many times this item can be bought by the same person in a round, -1 is unlimited
	var/list/restricted_roles = list() //If this uplink item is only available to certain roles.
	var/restricted = FALSE // Adds restrictions for VR/Events

/datum/supplykit_item/proc/get_discount()
	return pick(4;0.75,2;0.5,1;0.25)

/datum/supplykit_item/proc/purchase(mob/user, datum/component/supplykit/U)
	spawn_item(item, user, U)

/datum/supplykit_item/proc/spawn_item(spawn_path, mob/user, datum/component/supplykit/U)
	if(!spawn_path)
		return
	var/atom/A
	if(ispath(spawn_path))
		A = new spawn_path(get_turf(user))
	else
		A = spawn_path
	if(ishuman(user) && istype(A, /obj/item))
		var/mob/living/carbon/human/H = user
		if(H.put_in_hands(A))
			to_chat(H, "[A] is unpacked into your hands.")
			return A
	to_chat(user, "[A] is unpacked onto the floor.")
	return A

/*
	supplykit Categories:
	Due to how the typesof() in-built byond proc works, it should be kept in mind
	the order categories are displayed in the supplykit UI is same to the order they are loaded in the code.
	I trust no extra filter is needed as long as they are all contained within the following lines.
	When adding new supplykit categories, please keep them separate from their sub paths here and without set item.
	Failure to comply may result in the new categories being listed at the bottom of the UI.
*/

/*
/datum/supplykit_item/holiday
	category = "Holiday"
*/

/datum/supplykit_item/misc
	category = "Misc Gear"

/datum/supplykit_item/longarms
	category = "Longarms"
	cost = 20

/datum/supplykit_item/handguns
	category = "Handguns"
	cost = 20

/datum/supplykit_item/revolvers
	category = "Revolvers"
	cost = 20

/datum/supplykit_item/improvised
	category = "Pipe Guns"
	cost = 10

/datum/supplykit_item/magazines
	category = "Magazines"
	cost = 10

/datum/supplykit_item/ammo
	category = "Ammunition"
	surplus = 40
	cost = 10

/datum/supplykit_item/ammospec
	category = "Special Ammunition"
	surplus = 20
	cost = 5

/datum/supplykit_item/explosives
	category = "Explosives"

/datum/supplykit_item/blackpowder
	category = "Blackpowder"
	cost = 20

/datum/supplykit_item/magic
	category = "Magic Weapons"
	cost = 20

/datum/supplykit_item/energy
	category = "Energy Weapons"
	cost = 20

/datum/supplykit_item/meleesmall
	category = "One handed Melee"
	cost = 20

/datum/supplykit_item/meleebig
	category = "Two handed Melee"
	cost = 20

/datum/supplykit_item/shields
	category = "Shields"
	cost = 20
	surplus = 20

/datum/supplykit_item/animals
	category = "Plants & Animals"

/datum/supplykit_item/salvage
	category = "Mining & Salvage"

/datum/supplykit_item/tools
	category = "General Tools"

/datum/supplykit_item/tech
	category = "Technology"

/datum/supplykit_item/medical
	category = "Medical"

/datum/supplykit_item/materials
	category = "Materials"

//Discounts (dynamically filled above)
/datum/supplykit_item/discounts
	category = "Discounted Gear"

