/mob/living/simple_animal/hostile/retaliate/talker/trader
	var/list/product_records = list()
	var/list/hidden_records = list()
	var/next_restock = 1000
	var/stock_amount = 18
	var/default_price = PRICE_ABOVE_NORMAL
	var/extra_price = PRICE_REALLY_EXPENSIVE
	var/vend_ready = TRUE
	var/myplace = null
	var/my_original_loc = null
	var/walking = FALSE
	intimidation_difficulty = DIFFICULTY_EXPERT

	//format is weakref of mob as key, entry is number (That way no one can steal, vending machines might be stupid, but people are not)
	var/list/stored_caps = list()
	
/mob/living/simple_animal/hostile/retaliate/talker/trader/dialog_options(mob/talker, display_options)
	var/dat = ""
	if (!broken_trust.Find(WEAKREF(talker)) && !enemies.Find(WEAKREF(talker)) && !failed.Find(WEAKREF(talker)))
		dat += "<center><a href='?src=[REF(src)];trade=1'>Trade with [name].</a></center>"
	return dat


/mob/living/simple_animal/hostile/retaliate/talker/trader/Initialize(mapload)
	restock()
	myplace = get_turf(src)
	my_original_loc = loc
	..()

/mob/living/simple_animal/hostile/retaliate/talker/trader/handle_automated_movement()
	if (my_original_loc != loc)
		if (!walking)
			walking = TRUE
			walk_to(src, myplace, 0 , move_to_delay)
	else
		walk_to(src, 0)
		walking = FALSE
		..()

/mob/living/simple_animal/hostile/retaliate/talker/trader/proc/restock()
	var/list/random_list = list()
	for(var/iii in 1 to stock_amount) //go back up to understand why we populate prizes
		if (iii < 2)
			random_list += pick(GLOB.loot_prewar_clothing)
		else if (iii < 3)
			random_list += pick(GLOB.loot_prewar_costume)
		else if (iii < 5)
			random_list += pick(GLOB.loot_medical_drug)
		else if (iii < 7)
			random_list += pick(GLOB.loot_medical_medicine)
		else if (iii < 12)
			random_list += pick(pick(list(GLOB.loot_t1_armor, GLOB.loot_t2_armor, GLOB.loot_t3_armor, GLOB.loot_t4_armor)))
		else if (iii < 15)
			random_list += pick(pick(list(GLOB.loot_t1_melee, GLOB.loot_t2_melee, GLOB.loot_t3_melee, GLOB.loot_t4_melee)))
		else
			random_list += pick(pick(list(GLOB.loot_t1_range, GLOB.loot_t2_range, GLOB.loot_t3_range, GLOB.loot_t4_range)))
	
	//our special something for high speech individuals or for expert barter skill
	var/list/hidden_list = list()
	hidden_list += pick(list(GLOB.loot_t5_armor))
	hidden_list += pick(list(GLOB.loot_t5_melee))
	hidden_list += pick(list(GLOB.loot_t5_range))

	// populate our stock
	for(var/typepath in random_list)
		var/amount = 2

		var/atom/temp = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		GLOB.vending_products[typepath] = 1
		R.name = initial(temp.name)
		R.product_path = typepath
		R.amount = amount
		R.max_amount = amount
		R.custom_price = initial(temp.custom_price)
		R.custom_premium_price = initial(temp.custom_price)
		product_records += R
	
	for(var/typepath in hidden_list)
		var/amount = 1

		var/atom/temp = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()
		GLOB.vending_products[typepath] = 1
		R.name = initial(temp.name)
		R.product_path = typepath
		R.amount = amount
		R.max_amount = amount
		R.custom_price = initial(temp.custom_price)
		R.custom_premium_price = initial(temp.custom_price)
		hidden_records += R


/mob/living/simple_animal/hostile/retaliate/talker/trader/proc/show_trade_box(mob/user)
	ui_interact(user)


/mob/living/simple_animal/hostile/retaliate/talker/trader/Topic(href, href_list)
	if(href_list["trade"])
		say("Alright, here take a look at what I've got.")
		show_trade_box(usr)
	..()

/mob/living/simple_animal/hostile/retaliate/talker/trader/ui_data(mob/user)
	. = list()
	var/mob/living/carbon/human/H
	var/obj/item/card/id/C
	if(ishuman(user))
		H = user
		C = H.get_idcard(TRUE)
		if(C?.registered_account)
			.["user"] = list()
			.["user"]["name"] = C.registered_account.account_holder
			.["user"]["cash"] = C.registered_account.account_balance
			if(C.registered_account.account_job)
				.["user"]["job"] = C.registered_account.account_job.title
				.["user"]["department"] = C.registered_account.account_job.paycheck_department
			else
				.["user"]["job"] = "No Job"
				.["user"]["department"] = "No Department"
	.["stock"] = list()
	if (intimidated.Find(WEAKREF(user)) || user.skill_check(SKILL_BARTER, HARD_CHECK))
		say("Couple of special things just for you.")
		for (var/datum/data/vending_product/R in product_records + hidden_records)
			.["stock"][R.name] = R.amount
	else
		for (var/datum/data/vending_product/R in product_records)
			.["stock"][R.name] = R.amount
	.["extended_inventory"] = null
	.["insertedCaps"] = stored_caps[WEAKREF(user)] ? stored_caps[WEAKREF(user)] : "0"
	.["forceFree"] = FALSE

/mob/living/simple_animal/hostile/retaliate/talker/trader/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/vending),
	)

/mob/living/simple_animal/hostile/retaliate/talker/trader/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Vending")
		ui.open()

/mob/living/simple_animal/hostile/retaliate/talker/trader/ui_static_data(mob/user)
	. = list()
	.["onstation"] = TRUE
	.["department"] = null
	.["product_records"] = list()
	for (var/datum/data/vending_product/R in product_records)
		var/calc_price = R.custom_price || default_price
		calc_price = round((calc_price * ((150 - user.skill_value(SKILL_BARTER))/100)))
		var/list/data = list(
			asset = get_spritesheet_icon_key_from_type(R.product_path),
			name = R.name,
			price = calc_price,
			max_amount = R.max_amount,
			ref = REF(R)
		)
		.["product_records"] += list(data)
	.["hidden_records"] = list()
	for (var/datum/data/vending_product/R in hidden_records)
		var/calc_price = R.custom_premium_price || extra_price
		calc_price = round((calc_price * ((150 - user.skill_value(SKILL_BARTER))/100)))
		var/list/data = list(
			asset = get_spritesheet_icon_key_from_type(R.product_path),
			name = R.name,
			price = R.custom_premium_price || extra_price, //may cause breakage. please note
			max_amount = R.max_amount,
			ref = REF(R),
			premium = TRUE
		)
		.["hidden_records"] += list(data)

/mob/living/simple_animal/hostile/retaliate/talker/trader/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/f13Cash))
		add_caps(user, I)
		return
	..()

/mob/living/simple_animal/hostile/retaliate/talker/trader/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("vend")
			. = TRUE
			if(!vend_ready)
				return
			vend_ready = FALSE //One thing at a time!!
			var/datum/data/vending_product/R = locate(params["ref"])
			var/list/record_to_check = product_records 
			if(intimidated.Find(WEAKREF(usr)) || usr.skill_check(SKILL_BARTER, HARD_CHECK))
				record_to_check = product_records + hidden_records
			if(!R || !istype(R) || !R.product_path)
				vend_ready = TRUE
				return
			
			//debug
			if(product_records.Find(R) && hidden_records.Find(R))
				log_runtime("WARN - vendor [src] @ [loc] has Duplicate [R] accross normal and hidden product tables!")
			
			//Set price for the item we're using.
			var/price_to_use = default_price
			if(R.custom_price)
				price_to_use = R.custom_price
			if(hidden_records.Find(R))
				price_to_use = R.custom_premium_price ? R.custom_premium_price : extra_price
			
			price_to_use = round((price_to_use * ((150 - usr.skill_value(SKILL_BARTER))/100)))

			//Make sure we actually have the item.
			if(R in hidden_records)
				vend_ready = TRUE
				return
			else if (!(R in record_to_check))
				vend_ready = TRUE
				message_admins("Vending machine exploit attempted by [ADMIN_LOOKUPFLW(usr)]!")
				return
			if (R.amount <= 0)
				say("None of [R.name] left, sorry pal.")
				vend_ready = TRUE
				return

			//Do we have the money inserted to buy this item?
			if(price_to_use > stored_caps[WEAKREF(usr)])
				to_chat(usr, span_alert("Not enough caps to pay for [R.name]!"))
				vend_ready = TRUE
				return
			
			//Thank them like any megaglobal corp should.
			say("Take good care of that.")

			//Deduct that price if we're not overridden to be free.
			stored_caps[WEAKREF(usr)] = stored_caps[WEAKREF(usr)] - price_to_use

			//Set up what we're vending and actually vend it to the person buying it.
			var/obj/item/vended = new R.product_path(get_turf(src))
			R.amount--
			if(usr.can_reach(src) && usr.put_in_hands(vended))
				to_chat(usr, span_notice("You take [R.name] out of the slot."))
			else
				to_chat(usr, span_warning("[capitalize(R.name)] falls onto the floor!"))
			SSblackbox.record_feedback("nested tally", "vending_machine_usage", 1, list("[type]", "[R.product_path]"))
			vend_ready = TRUE
		if("ejectCaps")
			remove_all_caps(usr)


/* Spawn all caps on world and clear caps storage */
/mob/living/simple_animal/hostile/retaliate/talker/trader/proc/remove_all_caps(mob/user)
	if(stored_caps.Find(WEAKREF(user)) <= 0)
		return
	var/obj/item/stack/f13Cash/C = new /obj/item/stack/f13Cash/caps
	if(stored_caps[WEAKREF(user)] > C.max_amount)
		C.add(C.max_amount - 1)
		C.forceMove(user.loc)
		stored_caps[WEAKREF(user)] -= C.max_amount
	else
		C.add(stored_caps[WEAKREF(user)] - 1)
		C.forceMove(user.loc)
		stored_caps[WEAKREF(user)] = 0
	playsound(src, 'sound/items/coinflip.ogg', 60, 1)
	src.ui_interact(usr)

/mob/living/simple_animal/hostile/retaliate/talker/trader/proc/add_caps(mob/user, obj/item/stack/f13Cash/cash)
	if(!stored_caps[WEAKREF(user)])
		stored_caps[WEAKREF(user)] = cash.amount
	else
		stored_caps[WEAKREF(user)] += cash.amount
	cash.use(cash.amount)
	

/mob/living/simple_animal/hostile/retaliate/talker/trader/basic
	name = "Bob the Trader"
	desc = "An officer part of Nanotrasen's private security force."
	icon = 'icons/mob/simple_human.dmi'
	icon_state = "nanotrasen"
	icon_living = "nanotrasen"
	icon_dead = null
	del_on_death = TRUE
	icon_gib = "syndicate_gib"
	turns_per_move = 5
	response_help_continuous = "pokes"
	response_help_simple = "poke"
	response_disarm_continuous = "shoves"
	response_disarm_simple = "shove"
	response_harm_continuous = "hits"
	response_harm_simple = "hit"
	speed = 0
	stat_attack = CONSCIOUS
	ranged_cooldown_time = 22
	ranged = TRUE
	robust_searching = TRUE
	healable = TRUE
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 15
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	faction = list("nanotrasenprivate")
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 15
	status_flags = CANPUSH
	search_objects = 1
	icon_state = "nanotrasenrangedsmg"
	icon_living = "nanotrasenrangedsmg"
	vision_range = 9
	rapid = 3
	retreat_distance = 3
	minimum_distance = 5
	casingtype = /obj/item/ammo_casing/c9mm
	projectiletype = /obj/item/projectile/bullet/c46x30mm
	projectilesound = 'sound/weapons/gunshot_smg.ogg'
	loot = list(/obj/item/gun/ballistic/automatic/autopipe,
				/obj/effect/mob_spawn/human/corpse/nanotrasensoldier)
