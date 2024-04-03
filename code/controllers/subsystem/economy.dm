SUBSYSTEM_DEF(economy)
	name = "AAAAEconomy"
	wait = 3 MINUTES
	init_order = INIT_ORDER_ECONOMY
	runlevels = RUNLEVEL_GAME
	var/roundstart_paychecks = 5
	var/budget_pool = 35000
	var/list/department_accounts = list(
		ACCOUNT_CIV = ACCOUNT_CIV_NAME,
		ACCOUNT_ENG = ACCOUNT_ENG_NAME,
		ACCOUNT_SCI = ACCOUNT_SCI_NAME,
		ACCOUNT_MED = ACCOUNT_MED_NAME,
		ACCOUNT_SRV = ACCOUNT_SRV_NAME,
		ACCOUNT_CAR = ACCOUNT_CAR_NAME,
		ACCOUNT_SEC = ACCOUNT_SEC_NAME)
	var/list/generated_accounts = list()
	var/full_ancap = FALSE // Enables extra money charges for things that normally would be free, such as sleepers/cryo/cloning.
							//Take care when enabling, as players will NOT respond well if the economy is set up for low cash flows.
	var/alive_humans_bounty = 100
	var/crew_safety_bounty = 1500
	var/monster_bounty = 150
	var/mood_bounty = 100
	var/techweb_bounty = 250
	var/slime_bounty = list(
		"grey" = 10,
		// tier 1
		"orange" = 100,
		"metal" = 100,
		"blue" = 100,
		"purple" = 100,
		// tier 2
		"dark purple" = 500,
		"dark blue" = 500,
		"green" = 500,
		"silver" = 500,
		"gold" = 500,
		"yellow" = 500,
		"red" = 500,
		"pink" = 500,
		// tier 3
		"cerulean" = 750,
		"sepia" = 750,
		"bluespace" = 750,
		"pyrite" = 750,
		"light pink" = 750,
		"oil" = 750,
		"adamantine" = 750,
		// tier 4
		"rainbow" = 1000)
	var/list/bank_accounts = list() //List of normal accounts (not department accounts)
	var/list/dep_cards = list()

	//// all the good stuff below this
	var/currency_unit = "$"
	var/currency_name = "buc"
	var/currency_name_plural = "bux"
	var/boring_units_only = TRUE

	/// weakrefs to all the bounty computers, so they can go BEEP when updated
	var/list/computers = list()

	/// Holds all the cool stuff that's happening in the world of quests!
	var/list/quest_books = list()
	/// list of paths that are probably part of a quest
	var/list/quest_things = list()
	/// list of paths of quests people have accepted!
	var/list/active_quests = list()

	/// All the possible quests!
	var/list/all_quests = list()
	/// All the publically-available quests!
	var/list/quest_pool = list() // quest pool! quest pool! quest pool!
	var/easy_quests = 5
	var/medium_quests = 3
	var/hard_quests = 2
	var/cbt_quests = 1

	var/max_quests = 5

	var/total_completed = 0
	var/highest_completed = 0
	var/most_valuable_quest = 0
	var/total_banked = 0
	var/highest_banked = 0

	var/highest_banked_ckey = ""
	var/highest_completed_ckey = ""
	var/most_valuable_quest_ckey = ""

	var/list/used_tags = list()

	var/list/quest_console_paths = list()

	var/easy_quest_count = 7
	var/medium_quest_count = 5
	var/hard_quest_count = 3
	var/cbt_quest_count = 2

	var/debug_quests = FALSE
	var/debug_objectives = TRUE
	var/debug_ignore_extinction = TRUE

/datum/controller/subsystem/economy/Initialize(timeofday)
	setup_currency()
	var/budget_to_hand_out = round(budget_pool / department_accounts.len)
	for(var/A in department_accounts)
		new /datum/bank_account/department(A, budget_to_hand_out)
	if(!GLOB.bounties_list.len)
		setup_bounties()
	if(!LAZYLEN(all_quests))
		setup_quests()
	refresh_quest_pool()
	init_quest_consoles()
	. = ..()
	to_chat(world, span_boldannounce("Added [LAZYLEN(all_quests)] quests! :D"))

/datum/controller/subsystem/economy/fire(resumed = 0)
	refresh_quest_pool()
	//eng_payout()  // Payout based on nothing. What will replace it? Surplus power, powered APC's, air alarms? Who knows.
	//sci_payout() // Payout based on slimes.
	//secmedsrv_payout() // Payout based on crew safety, health, and mood.
	//civ_payout() // Payout based on ??? Profit
	//car_payout() // Cargo's natural gain in the cash moneys.
	//for(account in bank_accounts)
	//	var/datum/bank_account/bank_account = account
	//	bank_account.payday(1)
	//disabled payday

/datum/controller/subsystem/economy/proc/setup_currency()
	var/list/units = list(
		"$", "C", "©", "§", "¶", "¤", "☺", "☻", "☼", "♥", "♫", "♪", "≡", "∞", "√", "∑", "∆", "∫", 
		"∏", "∂", "∀", "∃", "∅", "∇", "∈", "∉", "∋", "∌", "∍", "∎", "∏", "∐", "∑", "∓", "∔", 
		"∘", "∙", "√", "∛", "∜", "∝", "∞", "∟", "∠", "∡", "∢", "∤", "∥", "∦", "∧", "∩", "∫", "∬", 
		"∭", "∮", "∯", "∰", "∱", "∲", "∳", "∴", "∵", "∷", "∸", "∹", "∺", "∻", "∽", "∾", "∿", 
		"≀", "≁", "≂", "≃", "≄", "≅", "≆", "≇", "≈", "≉", "≊", "≋", "≌", "≍", "≎", "≏", "≐", "≑", 
		"≒", "≓", "≔", "≕", "≖", "≗", "≘", "≙", "≚", "≛", "≜", "≝", "≞", "≟", "≠", "≡", "≢", "≣", 
		"≤", "≥", "≦", "≧", "≨", "≩", "≪", "≫", "≬", "≭", "≮", "≯", "≰", "≱", "≲", "≳", "≴", "≵", 
		"≶", "≷", "≸", "≹", "≺")
	if(boring_units_only && prob(99))
		currency_name = "Copper"
		currency_name_plural = "Coppers"
		if(prob(95))
			currency_unit = "₡"
		else
			currency_unit = pick(units)
		return ":/"
	currency_unit = "[pick(units)]"
	var/s33d = rand(1,12)
	switch(s33d)
		if(1)
			currency_name = "Simoleon"
			currency_name_plural = "Simoleons"
			currency_unit = "§"
		if(2)
			currency_name = "Smackeroo"
			currency_name_plural = "Smackeroos"
			currency_unit = "§"
		if(3)
			currency_name = "Gil"
			currency_name_plural = "Gil"
			currency_unit = "GP"
		if(4)
			currency_name = "Zennus"
			currency_name_plural = "Zenny"
			currency_unit = "Z"
		if(5)
			currency_name = "Plat"
			currency_name_plural = "Plat"
			currency_unit = "pp"
		if(6)
			currency_name = "Bean"
			currency_name_plural = "Beans"
			currency_unit = "🐾"
		if(7)
			currency_name = "Banana"
			currency_name_plural = "Bananas"
			currency_unit = "%"
		if(8)
			currency_name = "Quadrillion Cookies"
			currency_name_plural = "Quadrillion Cookies"
			currency_unit = "🥠"
		if(9)
			currency_name = "Meat"
			currency_name_plural = "Meat"
			currency_unit = "Prime"
		if(10)
			currency_name = "Capsule"
			currency_name_plural = "Capsules"
			currency_unit = "♥"
		if(11)
			currency_name = "Buck"
			currency_name_plural = "Bucks"
			currency_unit = "$"
		if(12)
			currency_name = "Dollar"
			currency_name_plural = "Dollars"
			currency_unit = "$"

/datum/controller/subsystem/economy/proc/setup_quests()
	if(LAZYLEN(all_quests))
		QDEL_LIST_ASSOC_VAL(all_quests)
	for(var/pat in subtypesof(/datum/bounty))
		var/datum/bounty/B = pat
		if(!initial(B.name))
			continue
		B = new pat()
		all_quests["[B.type]"] = B
		B.is_templarte = TRUE

/datum/controller/subsystem/economy/proc/refresh_quest_pool()
	if(LAZYLEN(all_quests))
		setup_quests()
	QDEL_LIST_ASSOC_VAL(quest_pool)
	if(debug_quests)
		var/list/quist = list()
		for(var/thingtype in all_quests)
			var/datum/bounty/B = LAZYACCESS(all_quests, thingtype)
			quist[B] = B.weight
		roll_for_quests(quist, LAZYLEN(quist))
		alert_devices()
		return
	var/list/easy = list()
	var/list/medium = list()
	var/list/hard = list()
	var/list/cbt = list()
	for(var/qpath in all_quests)
		var/datum/bounty/B = LAZYACCESS(all_quests, qpath)
		if(!B.should_be_completable())
			continue // Mingus Matt is ded
		if(CHECK_BITFIELD(B.difficulty, QUEST_DIFFICULTY_EASY))
			easy[B] = B.weight
		if(CHECK_BITFIELD(B.difficulty, QUEST_DIFFICULTY_MED))
			medium[B] = B.weight
		if(CHECK_BITFIELD(B.difficulty, QUEST_DIFFICULTY_HARD))
			hard[B] = B.weight
		if(CHECK_BITFIELD(B.difficulty, QUEST_DIFFICULTY_CBT))
			cbt[B] = B.weight
	if(LAZYLEN(easy))
		roll_for_quests(easy, easy_quest_count, QUEST_DIFFICULTY_EASY)
	if(LAZYLEN(medium))
		roll_for_quests(medium, medium_quest_count, QUEST_DIFFICULTY_MED)
	if(LAZYLEN(hard))
		roll_for_quests(hard, hard_quest_count, QUEST_DIFFICULTY_HARD)
	if(LAZYLEN(cbt))
		roll_for_quests(cbt, cbt_quest_count, QUEST_DIFFICULTY_CBT)
	if(!LAZYLEN(quest_pool)) // no quests? NO QUESTS??
		var/list/quist = list()
		for(var/thingpath in all_quests)
			var/datum/bounty/B = LAZYACCESS(all_quests, thingpath)
			quist[B] = B.weight
		roll_for_quests(quist, easy_quest_count+medium_quest_count+hard_quest_count+cbt_quest_count)
	alert_devices()

/datum/controller/subsystem/economy/proc/roll_for_quests(list/questlist, howmany, difficulty)
	for(var/i in 1 to howmany)
		if(!LAZYLEN(questlist))
			break
		var/datum/bounty/B = pickweight(questlist)
		if(B)
			if(!B.candupe)
				questlist -= B
			var/datum/bounty/B2 = new B.type(difficulty)
			B2.is_templarte = TRUE
			quest_pool[B2.uid] = B2

/datum/controller/subsystem/economy/proc/init_quest_consoles()
	quest_console_paths |= typecacheof(/obj/item/radio)
	quest_console_paths |= typecacheof(/obj/item/pda)
	quest_console_paths |= typecacheof(/obj/machinery/computer)

/datum/controller/subsystem/economy/proc/alert_devices()
	for(var/kcey in quest_books)
		var/datum/quest_book/QL = LAZYACCESS(quest_books, kcey)
		QL.questpool_updated()

/// gives a local copy of a quest to a player's device........ if they can handle it!!
/datum/controller/subsystem/economy/proc/add_active_quest(datum/bounty/B, mob/user, loud = TRUE)
	if(!user)
		return FALSE
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return FALSE
	return QL.add_active_quest(B, TRUE)

/// removes an active quest
/datum/controller/subsystem/economy/proc/remove_active_quest(datum/bounty/B, mob/user, loud = TRUE, system_handled)
	if(!user)
		return FALSE
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return FALSE
	return QL.remove_active_quest(B, loud, system_handled)

/datum/controller/subsystem/economy/proc/activate_quest(datum/bounty/B)
	active_quests[B.uid] = B
	update_quest_things()

/datum/controller/subsystem/economy/proc/deactivate_quest(datum/bounty/B)
	if(istext(B))
		active_quests -= B
	else
		active_quests -= B.uid
	update_quest_things()

/datum/controller/subsystem/economy/proc/update_quest_things()
	quest_things.Cut()
	for(var/uid in active_quests)
		var/datum/bounty/B = LAZYACCESS(active_quests, uid)
		if(QDELETED(B))
			active_quests -= uid
			continue
		quest_things |= B.get_quest_paths()

/// finishing a quest involves completing the objectives, and getting the payout
/datum/controller/subsystem/economy/proc/finish_quest(datum/bounty/B, mob/user, loud = TRUE)
	if(!B || !user)
		return FALSE
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return FALSE
	. = QL.finish_quest(B, TRUE)
	update_quest_statistics()

/datum/controller/subsystem/economy/proc/adjust_funds(mob/user, amount, datum/bounty/payer)
	if(!user || !amount)
		return
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return
	return QL.adjust_funds(amount, payer)

/datum/controller/subsystem/economy/proc/update_quest_statistics()
	highest_banked = 0
	highest_banked_ckey = ""
	highest_completed = 0
	highest_completed_ckey = ""
	total_banked = 0
	total_completed = 0
	most_valuable_quest = 0
	most_valuable_quest_ckey = ""
	for(var/k in quest_books)
		var/datum/quest_book/QL = LAZYACCESS(quest_books, k)
		total_banked += QL.overall_banked
		total_completed += LAZYLEN(QL.finished_quests)
		if(QL.overall_banked > highest_banked)
			highest_banked = QL.overall_banked
			highest_banked_ckey = QL.ckey
		if(LAZYLEN(QL.finished_quests) > highest_completed)
			highest_completed = LAZYLEN(QL.finished_quests)
			highest_completed_ckey = QL.ckey
		for(var/uid in QL.finished_quests)
			var/datum/finished_quest/FQ = LAZYACCESS(QL.finished_quests, uid)
			if(FQ.quest_rewarded > most_valuable_quest)
				most_valuable_quest = FQ.quest_rewarded
				most_valuable_quest_ckey = QL.ckey
				// todo: cross round persistent leaderboards

/datum/controller/subsystem/economy/proc/get_quest_by_uid(uid, list/searchthis)
	var/list/searchit
	if(LAZYLEN(searchthis))
		searchit = searchthis
	else
		searchit = quest_pool
	return LAZYACCESS(searchit, uid)

/datum/controller/subsystem/economy/proc/cleanup_deleting_quest(datum/bounty/B, system_handled)
	if(istext(B))
		B = LAZYACCESS(quest_pool, B)
	if(!B)
		return
	deactivate_quest(B)
	quest_pool -= B.uid
	for(var/k in quest_books)
		var/datum/quest_book/QL = LAZYACCESS(quest_books, k)
		QL.remove_active_quest(B, FALSE, system_handled)

/datum/controller/subsystem/economy/proc/is_part_of_a_quest(atom/thing)
	if(!thing)
		return FALSE
	return LAZYACCESS(quest_things, thing.type)

/datum/controller/subsystem/economy/proc/check_quest_repeat(mob/completer, datum/bounty/B)
	if(!completer || !completer.ckey)
		return
	var/datum/quest_book/QL = get_quest_book(completer.ckey)
	if(!QL)
		return
	QL.have_they_done_this_quest_before(B)

/datum/controller/subsystem/economy/proc/complete_quest(mob/completer, datum/bounty/B)
	if(!completer || !completer.ckey)
		return
	var/datum/quest_book/QL = get_quest_book(completer.ckey)
	if(!QL)
		return
	QL.quest_done(B)

/datum/controller/subsystem/economy/proc/get_quest_book(mob/completer)
	if(!completer || !completer.ckey)
		return
	var/datum/quest_book/QL = LAZYACCESS(quest_books, completer.ckey)
	if(!QL)
		QL = new(completer)
	return QL

/datum/controller/subsystem/economy/proc/open_quest_console(mob/user, atom/thing)
	if(!user || !thing)
		return
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return
	QL.open_console(thing, user)

/datum/controller/subsystem/economy/proc/give_claimer(mob/user, atom/base)
	if(!user)
		return
	if(user.get_active_held_item() && user.get_inactive_held_item())
		if(prob(1))
			to_chat(user, span_warning("Your beans are too full to bean the beans, what the hell are you doing???!?"))
		else
			to_chat(user, span_warning("Your hands are too full for the Claimer!"))
		return
	var/obj/item/hand_item/quest_scanner/warbean = new(user)
	if(user.put_in_hands(warbean))
		to_chat(user, span_notice("You get out the Claimer!"))
	else
		qdel(warbean) // war beanz

/// attempts to find something that we can pretend we got the Claimer from
/datum/controller/subsystem/economy/proc/find_claimerable_source(mob/user)
	if(!user)
		return
	var/datum/quest_book/QL = get_quest_book(user)
	var/atom/thing = GET_WEAKREF(QL.last_used)
	if(thing && thing.Adjacent(user))
		return thing
	var/list/everything_in_mob = get_all_in_turf(get_turf(user))
	for(var/atom/other_thing as anything in everything_in_mob)
		if(LAZYACCESS(quest_things, other_thing.type))
			return other_thing
	return get_turf(user)

/datum/controller/subsystem/economy/proc/attempt_turnin(atom/thing, mob/user)
	if(!thing || !user)
		return
	if(!user.Adjacent(thing))
		if(user)
			to_chat(user, span_alert("That thing is too far away!"))
		return FALSE
	var/datum/quest_book/QL = get_quest_book(user)
	return QL.turn_something_in(thing)

/datum/controller/subsystem/economy/proc/check_duplicate_submissions(atom/thing, mob/user)
	if(!thing || !user)
		return FALSE
	var/datum/quest_book/QL = get_quest_book(user)
	if(!QL)
		return FALSE
	return QL.have_they_submitted_this_thing_before(thing)

/datum/controller/subsystem/economy/proc/turned_something_in(atom/thing, datum/quest_book/QB)
	if(!thing || !QB)
		return
	SSeconomy.assign_quest_tag(thing)
	return thing

/datum/controller/subsystem/economy/proc/assign_quest_tag(atom/thing)
	if(!thing)
		return
	var/skulltag = round(world.time)
	while(skulltag in used_tags)
		skulltag++
	thing.quest_tag = skulltag

/datum/controller/subsystem/economy/proc/get_plausible_quest_console(mob/person)
	var/list/everything = get_all_in_turf(get_turf(person))
	var/atom/second_choice
	for(var/atom/thing as anything in everything)
		if(istype(thing, /obj/item/pda))
			return thing
		if(istype(thing, /obj/item/radio))
			second_choice = thing
			continue
	return second_choice || person

/datum/controller/subsystem/economy/proc/update_when(formatit)
	if(!formatit)
		return next_fire
	var/remaining = next_fire - world.time
	return remaining
	// if(remaining <= 0)
	// 	return "Now!"
	// return DisplayTimeText(remaining, show_zeroes = TRUE, abbreviated = TRUE, fixed_digits = 2)
	
// /datum/controller/subsystem/economy/proc/register_computer(atom/thing)
// 	computers |= WEAKREF(thing) // dont forget to register your shareware
	
/datum/controller/subsystem/economy/proc/get_dep_account(dep_id)
	for(var/datum/bank_account/department/D in generated_accounts)
		if(D.department_id == dep_id)
			return D

/datum/controller/subsystem/economy/proc/eng_payout()
	var/engineering_cash = 3000
	var/datum/bank_account/D = get_dep_account(ACCOUNT_ENG)
	if(D)
		D.adjust_money(engineering_cash)


/datum/controller/subsystem/economy/proc/car_payout()
	var/cargo_cash = 250
	var/datum/bank_account/D = get_dep_account(ACCOUNT_CAR)
	if(D)
		D.adjust_money(cargo_cash)

/datum/controller/subsystem/economy/proc/secmedsrv_payout()
	var/crew
	var/alive_crew
	var/dead_monsters
	var/cash_to_grant
	for(var/mob/m in GLOB.mob_list)
		if(isnewplayer(m))
			continue
		if(m.mind)
			if(isbrain(m) || iscameramob(m))
				continue
			if(ishuman(m))
				var/mob/living/carbon/human/H = m
				crew++
				if(H.stat != DEAD)
					alive_crew++
					var/datum/component/mood/mood = H.GetComponent(/datum/component/mood)
					var/medical_cash = (H.health / H.maxHealth) * alive_humans_bounty
					if(mood)
						var/datum/bank_account/D = get_dep_account(ACCOUNT_SRV)
						if(D)
							var/mood_dosh = (mood.mood_level / 9) * mood_bounty
							D.adjust_money(mood_dosh)
						medical_cash *= (mood.sanity / 100)

					var/datum/bank_account/D = get_dep_account(ACCOUNT_MED)
					if(D)
						D.adjust_money(medical_cash)
		if(ishostile(m))
			var/mob/living/simple_animal/hostile/H = m
			if(H.stat == DEAD && (H.z in SSmapping.levels_by_trait(ZTRAIT_STATION)))
				dead_monsters++
		CHECK_TICK
	var/living_ratio = alive_crew / crew
	cash_to_grant = (crew_safety_bounty * living_ratio) + (monster_bounty * dead_monsters)
	var/datum/bank_account/D = get_dep_account(ACCOUNT_SEC)
	if(D)
		D.adjust_money(min(cash_to_grant, MAX_GRANT_SECMEDSRV))

/datum/controller/subsystem/economy/proc/sci_payout()
	var/science_bounty = 0
	for(var/mob/living/simple_animal/slime/S in GLOB.mob_list)
		if(S.stat == DEAD)
			continue
		science_bounty += slime_bounty[S.colour]
	var/datum/bank_account/D = get_dep_account(ACCOUNT_SCI)
	if(D)
		D.adjust_money(min(science_bounty, MAX_GRANT_SCI))

/datum/controller/subsystem/economy/proc/civ_payout()
	var/civ_cash = (rand(1,5) * 500)
	var/datum/bank_account/D = get_dep_account(ACCOUNT_CIV)
	if(D)
		D.adjust_money(min(civ_cash, MAX_GRANT_CIV))

/datum/quest_book
	var/ckey
	var/list/finished_quests = list()
	var/list/active_quests = list()
	/// weakref to the last thing the player used to interact with the quest system
	/// so it can tell you good job you did it
	var/datum/weakref/last_used
	var/beep_on_update = FALSE
	var/turnin_cooldown = 0
	/// Currently unclaimed points
	var/unclaimed_points = 0
	/// Overall total of points earned this round
	var/overall_banked = 0
	/// list of unique(ish) IDs of things that have been turned in
	var/list/things_turned_in = list() // THINGS IVE SHOVED UP ME ARSE
	var/list/paystubs = list()
	var/datum/quest_window/QW
	var/printer_cooldown = 0
	var/claim_on_kill = FALSE

/datum/quest_book/New(mob/quester)
	. = ..()
	if(!quester)
		qdel(src)
	ckey = quester.ckey
	QW = new(src)
	if(!LAZYACCESS(SSeconomy.quest_books, ckey))
		SSeconomy.quest_books[ckey] = src

/datum/quest_book/Destroy(force, ...)
	if(QW)
		QDEL_NULL(QW)
	last_used = null
	. = ..()

/datum/quest_book/proc/add_active_quest(datum/bounty/B, loud = TRUE)
	var/mob/user = ckey2mob(ckey)
	if(istext(B))
		B = SSeconomy.get_quest_by_uid(B)
	if(!B)
		if(loud)
			to_chat(user, span_alert("That quest isn't available anymore!"))
		return FALSE
	if(!can_take_quest(B, TRUE))
		return FALSE
	/// quest is go!!
	var/datum/bounty/B2 = new B.type(B.difficulty, B)
	B2.assign_to(user)
	active_quests[B.uid] = B2
	SSeconomy.activate_quest(B)
	QW.show_quest_window(user, B2, TRUE) // QOL #3690 - swap viewing quest window when you accept a quest
	if(loud)
		to_chat(user, span_green("Quest '[B2.name]' accepted!"))
	return TRUE

/datum/quest_book/proc/can_take_quest(datum/bounty/B, loud = TRUE)
	if(!B)
		return FALSE
	var/mob/user = ckey2mob(ckey)
	if(LAZYLEN(active_quests) >= SSeconomy.max_quests)
		if(loud)
			to_chat(user, span_alert("You've got plenty enough active quests as it is!"))
		return FALSE
	if(have_they_done_this_quest_before(B))
		if(loud)
			to_chat(user, span_alert("You've already had a go at that quest!"))
		return FALSE
	if(LAZYACCESS(active_quests, B.uid))
		if(loud)
			to_chat(user, span_alert("You're already doing that quest!"))
		return FALSE
	return TRUE

/datum/quest_book/proc/remove_active_quest(datum/bounty/B, loud = TRUE, was_finished)
	var/mob/user = ckey2mob(ckey)
	if(istext(B))
		B = LAZYACCESS(active_quests, B)
	if(!istype(B))
		if(loud)
			to_chat(user, span_alert("That quest doesn't exist!"))
		return FALSE
	var/is_it_mine = FALSE
	for(var/wid in active_quests)
		var/datum/bounty/B2 = LAZYACCESS(active_quests, wid)
		if(B2 == B)
			is_it_mine = TRUE
			break
	if(!is_it_mine)
		if(loud)
			to_chat(user, span_alert("You're not doing that quest!"))
		return FALSE
	active_quests -= B.uid
	QW.quest_destroyed(B, TRUE)
	SSeconomy.deactivate_quest(B)
	if(!was_finished)
		qdel(B)
	return TRUE

/datum/quest_book/proc/turn_something_in(atom/thing)
	if(!thing)
		return FALSE
	var/mob/user = ckey2mob(ckey)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, turnin_cooldown))
		return FALSE
	COOLDOWN_START(src, turnin_cooldown, 1 SECONDS)
	var/list/stuff = list()
	if(isturf(thing))
		stuff |= get_all_in_turf(thing)
	else
		stuff |= thing
		stuff |= thing.contents // warning, may extract nuts
	for(var/atom/thingy in stuff)
		if(Turnin(thingy,user,TRUE))
			return TRUE
	return FALSE

/datum/quest_book/proc/Turnin(atom/thing, mob/user,loud)
	for(var/uid in active_quests)
		var/datum/bounty/B = LAZYACCESS(active_quests, uid)
		if(B.attempt_turn_in(thing,user,loud))
			return TRUE

/datum/quest_book/proc/finish_quest(datum/bounty/B, loud = TRUE)
	if(istext(B))
		B = LAZYACCESS(active_quests, B)
	if(!B)
		return FALSE
	var/mob/user = ckey2mob(ckey)
	if(!user)
		return FALSE
	if(!B.is_complete())
		if(loud)
			to_chat(user, span_alert("That quest still has things it needs!"))
		return FALSE
	if(!B.payout(user))
		if(loud)
			to_chat(user, span_alert("Something went wrong with the payment method!!!!!!!"))
		return FALSE
	quest_done(B)
	SSeconomy.deactivate_quest(B) // just so they get good and dizzy
	remove_active_quest(B, FALSE, TRUE)
	return TRUE

/datum/quest_book/proc/quest_done(datum/bounty/B)
	if(!B)
		return FALSE
	finished_quests[B.uid] = B

/datum/quest_book/proc/adjust_funds(amount, datum/bounty/B)
	if(!amount)
		return
	if(istype(B))
		if(LAZYACCESS(paystubs, B.uid))
			return // no double dipping~
		paystubs[B.uid] = amount
	unclaimed_points += amount
	overall_banked += amount
	return TRUE

/datum/quest_book/proc/have_they_done_this_quest_before(datum/bounty/B)
	if(!B)
		return FALSE
	return LAZYACCESS(finished_quests, B.uid)

/datum/quest_book/proc/have_they_submitted_this_thing_before(atom/thing)
	if(!thing || !thing.quest_tag)
		return FALSE
	return (thing.quest_tag in things_turned_in)

/datum/quest_book/proc/questpool_updated()
	if(!beep_on_update)
		return
	var/mob/user = ckey2mob(ckey)
	if(!user)
		return
	var/atom/thing = SSeconomy.get_plausible_quest_console(user)
	if(!thing)
		thing = user
	playsound(thing, 'sound/effects/quests_updated.ogg', 40, TRUE)

/datum/quest_book/proc/get_quest_paths()
	var/list/out = list()
	for(var/uid in active_quests)
		var/datum/bounty/B = LAZYACCESS(active_quests, uid)
		out |= B.get_quest_paths()
	return out

/datum/quest_book/proc/open_console(atom/thing, mob/user)
	ui_interact(user) // @TalkingCactus: I'm not sure what this is supposed to do, but it's not doing anything right now.

/datum/quest_book/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CargoBountyConsole") // It has nothing to do with Cargo, it has nothing to do with bounties, it has everything to do with hurting
		ui.open()

/datum/quest_book/ui_state(mob/user)
	return GLOB.quest_book_state

/datum/quest_book/ui_data(mob/user)
	var/list/data = list()
	var/list/bountyinfo = list()
	for(var/uid in SSeconomy.quest_pool)
		var/datum/bounty/B1 = LAZYACCESS(SSeconomy.quest_pool, uid)
		bountyinfo += list(B1.get_tgui(user))
	var/list/mybounties = list()
	for(var/uid2 in active_quests)
		var/datum/bounty/B2 = LAZYACCESS(active_quests, uid2)
		mybounties += list(B2.get_tgui(user))
	var/list/myfinished = list()
	for(var/uid3 in finished_quests)
		var/datum/bounty/B3 = LAZYACCESS(finished_quests, uid3)
		myfinished += list(B3.get_tgui(user))
	data["UserName"] = user ? user.real_name : "RELPH"
	data["AllQuests"] = bountyinfo
	data["MyQuests"] = mybounties
	data["MyFinished"] = myfinished
	data["TimeToNext"] = SSeconomy.update_when(TRUE)
	data["BeepOnUpdate"] = beep_on_update
	data["QuestCount"] = LAZYLEN(active_quests)
	data["QuestMax"] = SSeconomy.max_quests
	data["QuestsCompleted"] = LAZYLEN(finished_quests)
	data["GlobalQuestsCompleted"] = SSeconomy.total_completed
	data["GlobalHighestCompleted"] = SSeconomy.highest_completed
	data["BankedPoints"] = unclaimed_points
	data["HighestBankedPoints"] = overall_banked
	data["GlobalHighestBanked"] = SSeconomy.highest_banked
	data["GlobalTotalEarned"] = SSeconomy.total_banked
	data["CurrencyUnit"] = SSeconomy.currency_unit
	data["CurrencyName"] = SSeconomy.currency_name
	data["CurrencyNamePlural"] = SSeconomy.currency_name_plural
	return data

/datum/quest_book/ui_act(action,params)
	if(..())
		return
	var/mob/user = usr
	switch(action) // lets bounce these commands back and forth between us and the subsystem, just so they get good and dizzy
		if("AcceptQuest")
			SSeconomy.add_active_quest(SSeconomy.get_quest_by_uid(params["BountyUID"]), src, user)
			. = TRUE
		if("CancelQuest")
			SSeconomy.remove_active_quest(LAZYACCESS(active_quests, params["BountyUID"]), src, user)
			. = TRUE
		if("FinishQuest")
			SSeconomy.finish_quest(LAZYACCESS(active_quests, params["BountyUID"]), src, user)
			. = TRUE
		if("CashOut")
			dispense_reward()
			. = TRUE
		if("ToggleBeep")
			TOGGLE_VAR(beep_on_update)
			. = TRUE
		if("GetScanner")
			give_scanner()
			. = TRUE
		if("ToggleClaimOnKill")
			TOGGLE_VAR(claim_on_kill)
			. = TRUE
		if("OpenQuest")
			var/datum/bounty/B
			if(params["QuestIsMine"])
				B = LAZYACCESS(active_quests, params["BountyUID"])
			else
				B = SSeconomy.get_quest_by_uid(params["BountyUID"])
			if(B)
				show_quest(B)
		if("DebugGiveObjectivePoint")
			if(!SSeconomy.debug_quests)
				to_chat(user, span_alert("You can't do that! You've gotta set debug_quests to TRUE in the economy subsystem first! =3"))
				. = FALSE
			var/datum/bounty/B = LAZYACCESS(active_quests, params["BountyUID"])
			if(!B)
				to_chat(user, span_alert("That quest doesn't exist!"))
				. = FALSE
			var/datum/bounty_quota/BQ = B.get_quota_by_uid(params["QuotaUID"])
			if(!BQ)
				to_chat(user, span_alert("That objective doesn't exist!"))
				. = FALSE
			BQ.Claim()
			to_chat(user, span_notice("Added 1 to objective '[BQ.name]'"))
			. = TRUE
	if(.)
		playsound(user, "terminal_type", 50, TRUE)

/datum/quest_book/proc/give_scanner()
	var/mob/user = ckey2mob(ckey)
	if(!user)
		return
	SSeconomy.give_claimer(user)

/datum/quest_book/proc/show_quest(datum/bounty/B)
	if(!B)
		return
	var/mob/user = ckey2mob(ckey)
	if(!user)
		return
	var/its_mine = LAZYACCESS(active_quests, B.uid) && !B.is_templarte
	QW.show_quest_window(user, B, its_mine)

/datum/quest_book/proc/dispense_reward()
	var/mob/doer = ckey2mob(ckey)
	if(!doer)
		return FALSE
	if(unclaimed_points < 1)
		playsound(doer, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(doer, span_alert("You don't have any cash to cash out! Try completing some quests =3"))
		return FALSE
	var/payment = unclaimed_points
	unclaimed_points = 0
	var/obj/item/card/quest_reward/QR = new(get_turf(doer))
	QR.assign_value(payment, 1.15, "#[random_color()]")
	if(doer)
		doer.put_in_hands(QR)
	playsound(doer, 'sound/machines/printer_press.ogg', 40, TRUE)
	return TRUE

/datum/quest_book/proc/print_quest(datum/bounty/B)
	var/mob/doer = ckey2mob(ckey)
	if(!doer)
		return FALSE
	playsound(doer, 'sound/machines/dash.ogg', 75, TRUE)
	to_chat(doer, span_alert("Could not establish connection to FoxEye Wireless Printer. Contact your Guild webmaster for assistance."))
	// if(printer_cooldown > world.time)
	// 	to_chat(doer, span_alert("The printer is still refilling its inkwell."))
	// 	return FALSE
	// B.print_quest(doer)
	// printer_cooldown = world.time + 5 SECONDS

/////////////////////////////////////////////////////////////////////
/// cute little thing that'll pop out a window of the selected quest
/datum/quest_window
	var/datum/quest_book/parent
	var/is_active_quest = FALSE
	var/viewing_uid = 0

/datum/quest_window/New(datum/quest_book/parent)
	. = ..()
	src.parent = parent

/datum/quest_window/proc/quest_destroyed(datum/bounty/B, only_if_active, only_if_public)
	if(only_if_active && !is_active_quest)
		return
	if(only_if_public && is_active_quest)
		return
	if(viewing_uid == B.uid)
		viewing_uid = 0

/datum/quest_window/proc/show_quest_window(mob/user, datum/bounty/B, is_active)
	if(!user || !B)
		return
	viewing_uid = B.uid
	is_active_quest = is_active
	ui_interact(user)

/datum/quest_window/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "QuestWindow")
		ui.open()

/datum/quest_window/ui_state(mob/user)
	return GLOB.quest_window_state

/datum/quest_window/ui_data(mob/user)
	var/list/data = list()
	var/datum/bounty/B
	if(is_active_quest)
		B = LAZYACCESS(parent.active_quests, viewing_uid)
	else
		B = SSeconomy.get_quest_by_uid(viewing_uid)
	if(!B)
		data["ItBroke"] = TRUE
		return data
	return B.get_tgui(user)

/datum/quest_window/ui_act(action,params)
	if(..())
		return
	var/mob/user = usr // close enough
	switch(action)
		if("AcceptQuest")
			SSeconomy.add_active_quest(SSeconomy.get_quest_by_uid(params["BountyUID"]), user, TRUE)
			return TRUE
		if("CancelQuest")
			SSeconomy.remove_active_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), user, TRUE)
			return TRUE
		if("FinishQuest")
			SSeconomy.finish_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), user, TRUE)
			return TRUE
		if("GiveScanner")
			parent.give_scanner()
			return TRUE
		if("PrintQuest")
			parent.print_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), src, user)
			return TRUE
		if("DebugGiveObjectivePoint")
			if(!SSeconomy.debug_objectives)
				to_chat(user, span_alert("You can't do that! You've gotta set debug_objectives to TRUE in the economy subsystem first! =3"))
				return
			var/datum/bounty/B = LAZYACCESS(parent.active_quests, params["BountyUID"])
			if(!B)
				to_chat(user, span_alert("That quest doesn't exist!"))
				return
			var/datum/bounty_quota/BQ = B.get_quota_by_uid(params["QuotaUID"])
			if(!BQ)
				to_chat(user, span_alert("That objective doesn't exist!"))
				return
			BQ.Claim()
			to_chat(user, span_notice("Added 1 to objective '[BQ.name]'"))
			return TRUE


/////////////////////////////////////////////////
/// FINISHED QUEST /////////////////////////////
/// A record of a quest that has been completed
/// Cus I haaaaate huge lists
/datum/finished_quest
	var/quest_uid
	var/quest_type
	var/quest_time_completed
	var/quest_difficulty
	var/quest_rewarded
	var/datum/bounty/my_bounty

/datum/finished_quest/New(datum/bounty/B)
	quest_uid = B.uid
	quest_type = B.type
	quest_time_completed = world.time
	quest_difficulty = B.difficulty
	quest_rewarded = B.get_reward()
	my_bounty = B

/////////////////////////////////////////////////
/// QUEST REWARD CARD //////////////////////////
/// A card that represents a reward for a quest
/obj/item/card/quest_reward
	name = "reward voucher"
	desc = "A card that someone said is worth something. How much? Who knows!"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	punched_state = "punchedticket"
	w_class = WEIGHT_CLASS_TINY
	punchable = TRUE

/obj/item/card/quest_reward/proc/assign_value(price, mult, coler)
	saleprice = round(price)
	punchbonus = round((price * mult) - price)
	add_atom_colour(coler, FIXED_COLOUR_PRIORITY)
	name = "Guild Quest voucher - [saleprice / 10] [SSeconomy.currency_unit]"
	desc = "An OFFICIAL Guild voucher for making this horrible multi-dimensional hellscape just a bit less awful. At least until whatever you killed comes back to life, cus seriously, nothing ever stays dead. \
		\n\nThis thing is worth [saleprice / 10] [SSeconomy.currency_unit], but you'll get a [punchbonus / 10] [SSeconomy.currency_unit] reward if you get it punched!"

/obj/item/card/quest_reward/punch()
	if(!..())
		return
	name = "Guild Quest voucher - [saleprice / 10] [SSeconomy.currency_unit] - [span_green("PUNCHED!")]"
	desc = "An OFFICIAL Guild voucher for making this horrible multi-dimensional hellscape just a bit less awful. At least until whatever you killed comes back to life, cus seriously, nothing ever stays dead. \
		\n\nThis thing is worth [saleprice / 10] [SSeconomy.currency_unit]! It has been punched, so you've probably already gotten the reward."
	return TRUE

//////////////////////////////////////////////////////
/// CLAIMER ITEM ////////////////////////////////////
/// A device that can be used to claim items for quests
/obj/item/hand_item/quest_scanner
	name = "quest scanner"
	desc = "A handy little modified zorcher used by independant Guild contractors to bend the fabric of reality and deliver specific quest related things to parts unknown."
	icon = 'icons/obj/device.dmi'
	icon_state = "export_scanner"
	item_state = "radio"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	item_flags = NOBLUDGEON | DROPDEL | ABSTRACT | HAND_ITEM
	w_class = WEIGHT_CLASS_NO_INVENTORY
	var/ping_cooldown = 0
	var/being_used = FALSE

/obj/item/hand_item/quest_scanner/examine(mob/user)
	. = ..()
	var/list/readme = list()
	readme += span_notice("This is a Quest Scanner! It is how you turn in things for quests.")
	readme += span_notice("To use it, simply click on the thing you want to turn in.")
	readme += span_notice("If that something is part of any of your quests, it will attempt to turn it in.")
	readme += span_notice("You can click the ground under a pile of things, and it will attempt to turn in anything questable in that pile.")
	readme += span_notice("If you're having trouble finding something to turn in, you can use the 'Ping' ability to scan the area for questable things.")
	readme += span_notice("To do this, just use it in your hand, and it will highlight anything you can turn in.")
	readme += span_notice("You can get one of these from the Quest Board with a button press, or by typing *scanner in the chat.")

/obj/item/hand_item/quest_scanner/afterattack(atom/O, mob/user, proximity)
	. = ..()
	if(!istype(O) || !proximity)
		return
	if(being_used)
		to_chat(user, span_alert("Your [src] is still doing something!"))
		return
	being_used = TRUE
	SSeconomy.attempt_turnin(O, user)
	being_used = FALSE

/obj/item/hand_item/quest_scanner/attack_self(mob/user)
	. = ..()
	ping_for_stuff(user)

/obj/item/hand_item/quest_scanner/proc/ping_for_stuff(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, ping_cooldown))
		to_chat(user, span_alert("Your [src] is still processing all that data!"))
		return
	COOLDOWN_START(src, ping_cooldown, 3 SECONDS)
	var/datum/quest_book/QL = SSeconomy.get_quest_book(user)
	if(!QL)
		return
	var/found_something = FALSE
	var/list/cacheotypes = QL.get_quest_paths()
	for(var/turf/T in view(3, user))
		for(var/atom/movable/thing in T)
			if(!is_type_in_typecache(thing, cacheotypes))
				continue
			found_something = TRUE
			new /obj/effect/temp_visual/glowy_outline(get_turf(thing), thing)
			break
	if(found_something)
		playsound(user, 'sound/machines/terminal_select.ogg', 65, TRUE)
		to_chat(user, span_notice("The Scanner beeps and lights up! It's found something!"))
	else
		playsound(user, 'sound/machines/terminal_prompt_confirm.ogg', 65, TRUE)
		to_chat(user, span_notice("The Scanner couldn't find anything!"))

/obj/effect/temp_visual/glowy_outline
	name = "something questable!"
	desc = "Oh hey! That thing can be turned in for a quest! Neat!"
	icon_state = "medi_holo"
	duration = 3 SECONDS
	var/sounding = TRUE

/obj/effect/temp_visual/glowy_outline/Initialize(mapload, atom/thing)
	. = ..()
	if(thing)
		var/mutable_appearance/looks = new(thing)
		appearance = looks
		filters += filter(type = "outline", size = 1, color = "#00FF00")
	var/matrix/fm = transform.Scale(1.1)
	alpha=150
	animate(
		src,
		time=duration,
		alpha=0,
		transform=fm,
	)

