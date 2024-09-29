GLOBAL_LIST_EMPTY(supplykits)




/datum/component/supplykit
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/name = "wastelander supply kit"
	var/active = FALSE
	var/allow_restricted = TRUE
	var/supplytokens //telecrystals
	var/selected_cat
	var/list/supplykit_items //uplink items
	var/compact_mode = FALSE
	var/debug = FALSE
	var/list/filters = list()

/datum/component/supplykit/Initialize(_enabled = FALSE, starting_st = 100)
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/OnAttackBy)
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, .proc/interact)

	GLOB.supplykits += src
	supplykit_items = get_supplykit_items(TRUE, allow_restricted, filters)
	active = _enabled

	supplytokens = starting_st + 50*(floor(world.time/(24 HOURS))) //50 per extra hour past the first

/datum/component/supplykit/InheritComponent(datum/component/supplykit/U)
	active |= U.active
	supplytokens += U.supplytokens

/datum/component/supplykit/Destroy()
	GLOB.supplykits -= src
	return ..()

/datum/component/supplykit/proc/LoadST(mob/user, obj/item/stack/supplytoken/ST, silent = FALSE)
	if(!silent)
		to_chat(user, span_notice("You pack additional supplies into [parent]."))
	var/amt = ST.amount
	supplytokens += amt
	ST.use(amt)

/datum/component/supplykit/proc/OnAttackBy(datum/source, obj/item/I, mob/user)
	if(!active)
		return
	if(istype(I, /obj/item/stack/supplytoken))
		LoadST(user, I)

/datum/component/supplykit/proc/interact(datum/source, mob/user)
	active = TRUE
	// if(user)
	// 	//make sure discounts are not rerolled
	// 	var/old_discounts = supplykit_items["Discounted Gear"]
	// 	supplykit_items = get_supplykit_items(FALSE, allow_restricted, filters)
	// 	if(old_discounts)
	// 		supplykit_items["Discounted Gear"] = old_discounts
	ui_interact(user)
	// an unlocked uplink blocks also opening the PDA or headset menu
	return COMPONENT_NO_INTERACT

/datum/component/supplykit/ui_state(mob/user)
	return GLOB.always_state

/datum/component/supplykit/ui_interact(mob/user, datum/tgui/ui)
	active = TRUE
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Supplykit", name)
		// This UI is only ever opened by one person,
		// and never is updated outside of user input.
		// ui.set_autoupdate(FALSE)
		ui.open()

/datum/component/supplykit/ui_data(mob/user)
	if(!user.mind)
		return
	var/list/data = list()
	data["supplytokens"] = supplytokens
	data["compactMode"] = compact_mode
	return data

/datum/component/supplykit/ui_static_data(mob/user)
	var/list/data = list()
	data["categories"] = list()
	for(var/category in supplykit_items)
		var/list/cat = list(
			"name" = category,
			"items" = (category == selected_cat ? list() : null))
		for(var/item in supplykit_items[category])
			var/datum/supplykit_item/I = supplykit_items[category][item]
			if(I.limited_stock == 0)
				continue
			if(I.restricted_roles.len)
				var/is_inaccessible = TRUE
				for(var/R in I.restricted_roles)
					if(R == user.mind.assigned_role || debug)
						is_inaccessible = FALSE
				if(is_inaccessible)
					continue
			cat["items"] += list(list(
				"name" = I.name,
				"cost" = I.cost,
				"desc" = I.desc,
			))
		data["categories"] += list(cat)
	return data

/datum/component/supplykit/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!active)
		return
	switch(action)
		if("buy")
			var/item_name = params["name"]
			var/list/buyable_items = list()
			for(var/category in supplykit_items)
				buyable_items += supplykit_items[category]
			if(item_name in buyable_items)
				var/datum/supplykit_item/I = buyable_items[item_name]
				MakePurchase(usr, I)
				return TRUE
		if("select")
			selected_cat = params["category"]
		if("compact_toggle")
			compact_mode = !compact_mode
			return TRUE

/datum/component/supplykit/proc/MakePurchase(mob/user, datum/supplykit_item/U)
	if(!istype(U))
		return
	if (!user || user.incapacitated(allow_crit = TRUE))
		return

	if(supplytokens < U.cost || U.limited_stock == 0)
		return
	supplytokens -= U.cost

	U.purchase(user, src)

	if(U.limited_stock > 0)
		U.limited_stock -= 1

	return TRUE


