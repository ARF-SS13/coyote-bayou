#define TIMES_TO_NUMBER(yeor, moonth, diay) (((yeor - 2020) * 10000) + (moonth * 100) + diay)

SUBSYSTEM_DEF(economy)
	name = "QuestEconomy"
	wait = 15 MINUTES
	init_order = INIT_ORDER_ECONOMY + 2000
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
	/// when depositing coins, what proportion just fricks off into the void?
	var/coin_deposit_tax = 0.80 
	/// Every day you dont log in, how much of your money just fricks off into the void?
	var/housing_fee_percent = 0.02
	/// where all the money that you lose from taxes goes
	var/public_projects = "local localatorium"

	/// weakrefs to all the bounty computers, so they can go BEEP when updated
	var/list/computers = list()

	var/last_quest_update = 0
	var/next_quest_update = 0
	var/quest_update_interval = 15 MINUTES

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
	var/easy_quests = 0
	var/medium_quests = 0
	var/hard_quests = 0
	var/cbt_quests = 0
	var/max_quests = 5

	var/total_completed = 0
	var/highest_completed = 0
	var/highest_completed_uid = ""
	var/historical_highest_completed = 0
	var/historical_highest_completed_uid = ""

	var/most_valuable_quest = 0
	var/most_valuable_quest_uid = ""

	var/total_banked = 0
	var/highest_banked = 0
	var/highest_banked_uid = ""
	var/historical_highest_banked = 0
	var/historical_highest_banked_uid = ""


	var/list/used_tags = list()

	var/list/quest_console_paths = list()

	var/easy_quest_count = 3
	var/medium_quest_count = 2
	var/hard_quest_count = 1
	var/cbt_quest_count = 1

	var/static_spam = 0

	var/list/relevant_dates = list()
	var/today = 0
	var/inactivity_cutoff = 7 // days
	var/spree_reward_per_day = COINS_TO_CREDITS(100)
	var/spree_max = 7 // days

	var/debug_quests = FALSE
	var/debug_objectives = FALSE
	var/debug_ignore_extinction = FALSE
	var/debug_include_laggy_item_quests = FALSE
	var/debug_ignore_historical_round_number_check = TRUE
	var/debug_daily_spawn_in_stuff = TRUE

/datum/controller/subsystem/economy/Initialize(timeofday)
	setup_currency()
	setup_public_project()
	var/budget_to_hand_out = round(budget_pool / department_accounts.len)
	for(var/A in department_accounts)
		new /datum/bank_account/department(A, budget_to_hand_out)
	if(!GLOB.bounties_list.len)
		setup_bounties()
	if(!LAZYLEN(all_quests))
		setup_quests()
	refresh_quest_pool()
	init_quest_consoles()

	today = QDAY_TODAY

	var/datelength = today // its the number of days since the beginning of time, so what better size for a list of dates?
	relevant_dates.Cut()
	relevant_dates.len = datelength
	var/list/list_o_days = list(REALTIME2QDAYS(0)) // today!

	for(var/dia in 1 to LAZYLEN(relevant_dates))
		list_o_days += REALTIME2QDAYS(-dia)
	relevant_dates = list_o_days.Copy() // reverseList(list_o_days)
	if(relevant_dates[1] != today)
		to_chat(world, span_adminobserverooc("Today is not the first day of the universe! [relevant_dates[1]] != [today]"))
	
	. = ..()
	spawn(5 SECONDS)
		to_chat(world, span_boldannounce("Added [LAZYLEN(all_quests)] quests! :D"))

/datum/controller/subsystem/economy/fire(resumed = 0)
	if(world.time > next_quest_update)
		refresh_quest_pool()
		update_quest_statistics()


/datum/controller/subsystem/economy/proc/setup_public_project()
	var/list/projects = list(
		"be used to fund the guns for tots program",
		"go towards the national debt",
		"help fund public schools",
		"help build the localatorium",
		"be invested into making more and better guns",
		"help fund research into more powerful rift-blasters",
		"help pay off Chiara's donut budget",
		"help pay off Chiara's chair repair budget",
		"go towards growing of a new and even even bigger World's Largest Potato",
		"fund constructuion of libraries with books in them this time",
		"be used to fund a use for all these corpses you've all been sending us",
		"go towards putting out the River of Flame",
		"pay to put food on your family",
		"help fund moving New Boston 20 meters to the left",
		"go towards putting up wallpaper in the Portal Shelters",
		"be put in the Rainy Day fund",
		"help fund the Bras for Broken Backs charity",
		"be put into your retirement fund",
		"help fund the Bosoms for Bosomless charity",
		"go towards the Larger Rears for the Lacking charity",
		"fund cuter homes for all those adorable crows what deliver things for nuts",
		"be used to buy more magnets",
		"be used to buy more candles",
		"be used to spend less on candles",
		"help fund research into what the heck a Gibbl is",
		"help feed the curveless",
		"be used to fund the new and improved World's Largest Potato",
		"go towards finally removing all those peckleschteiner doors that keep popping up",
		"pay for more bonfires in the middle of every road",
		"go towards the Wider Waists for Waifus charity",
		"help dig a deeper hot tub for the tribals",
		"be used to fund GekkerTec do whatever it is they do",
		"fund more bulletproof ducks",
		"help drive the spiders out of Spiders, New Sharon",
		"go towards the Beefier Arms for Blaster Users charity",
		"go towards buying more landmines to put outside the Army Base",
		"go towards buying more robots for Mass Fusion",
		"go towards buying thicker thighs for raptors",
		"go towards floofening tails for foxes",
		"fund the lubrication of local synths",
		"fund the de-lubrication of local synths",
		"fund our army of maids that clean up all the fluids you all keep spraying all over the rental houses",
		"fund the Keep Isabelle Well Fed ordinance",
		"be used to buy more war bonds",
		"go towards making arm warmers that actually fit under your DataPal",
		"help bribe deathclaws into having really delicious meat",
		"fund research as to why nobody can frickin die anymore",
		"be used to keep our portals their bluest",
		"be used to remove the soundproofing on mechs",
		"pay for more public contortionist lessons",
		"be used to put less apples in the vending machines, please",
		"go towards making your dreams come true",
		"go towards making your dreams come true, in pog form",
		"help hungry foxes eat the world's largest potato",
		"help repave the Lancaster section of the I-14 for the next 5 goshdarned years",
		"be used to increase the length of those chains they have on those pens at the bank",
		"fund butt combat",
		"help rebaconify hellpigs",
	)
	public_projects = pick(projects)

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
	if(boring_units_only && prob(95))
		currency_name = "Copper"
		currency_name_plural = "Coppers"
		if(prob(85))
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

/datum/controller/subsystem/economy/proc/format_currency(amount, credits_to_coins = FALSE, full = FALSE)
	if(credits_to_coins)
		amount = CREDITS_TO_COINS(amount)
		amount = floor(amount)
	if(!full)
		return "[amount] [currency_unit]"
	if(amount > 1 || amount < -1)
		return "[amount] [currency_name_plural]"
	else
		return "[amount] [currency_name]"

/// calculates how many days you havent been on the bayou, and returns how much you should lose for not being here for more than a day
/// ya know, like how scummy mobile games do evil mindgames on their players so they play every day and suck their microtransaction dicks dry
/// cept we arent actually making any money off this game, and player retention here is just to feel like I'm not a loser, mom
/datum/controller/subsystem/economy/proc/calculate_daily_spawn_in_stuff(taxated, list/override_dates, override_bank)
	var/datum/preferences/P = extract_prefs(taxated)
	var/datum/quest_book/QB = get_quest_book(taxated)
	if(!override_dates && !override_bank)
		if(!taxated)
			return FALSE
		if(!P)
			return FALSE
		if(!LAZYLEN(P.days_spawned_in))
			return FALSE
		if(!QB)
			return FALSE
	/// if they havent been on the bayou for more than a day, they start losing money
	var/list/dates2check = override_dates ? override_dates.Copy() : P.days_spawned_in.Copy()
	var/list/our_calendar = relevant_dates.Copy()
	if(LAZYACCESS(our_calendar, 1) == LAZYACCESS(dates2check, 1)) // they logged in today
		return 0 // no penalty or reward
	/// they didnt log in today. lets see how many days they missed
	var/yasterday = LAZYACCESS(our_calendar, 2)
	var/their_bank = override_bank ? override_bank : P.saved_unclaimed_points
	if(LAZYACCESS(dates2check, 1) == yasterday) // their last login was yesterday
		return calculate_spree_reward(dates2check, our_calendar, their_bank)
	else
		return calculate_inactivity_penalty(dates2check, our_calendar, their_bank)

/datum/controller/subsystem/economy/proc/calculate_spree_reward(list/dates2check, list/our_calendar, their_bank)
	if(!LAZYLEN(dates2check) || !LAZYLEN(our_calendar) || !their_bank)
		return 0
	var/login_spree = 0 // check for spree!
	var/ourcheck_index = 2
	var/theircheck_index = 1
	var/our_date = 0
	var/their_date = 0
	var/safety = 200
	while(ourcheck_index <= LAZYLEN(our_calendar) && theircheck_index <= LAZYLEN(dates2check) && safety--)
		if(login_spree >= spree_max)
			break
		our_date = LAZYACCESS(our_calendar, ourcheck_index)
		their_date = LAZYACCESS(dates2check, theircheck_index)
		if(our_date == their_date)
			login_spree++
			ourcheck_index++
			theircheck_index++
		else
			break
	if(login_spree > 0)
		var/reward = ceil(login_spree * spree_reward_per_day)
		return reward

/datum/controller/subsystem/economy/proc/calculate_inactivity_penalty(list/dates2check, list/our_calendar, their_bank)
	if(!LAZYLEN(dates2check) || !LAZYLEN(our_calendar) || !their_bank)
		return 0
	var/inactive_days = -1
	var/our_date = LAZYACCESS(our_calendar, 1)
	var/their_date = LAZYACCESS(dates2check, 1)
	inactive_days = clamp(our_date - their_date - 1, 0 , inactivity_cutoff) // today should be bigger than their last login, so this should be positive
	if(inactive_days > 0)
		var/penalty_percent = ((1-housing_fee_percent) ** inactive_days) // 1 - 4 inactive days at 2% compounding daily = (0.98**4) = 0.92236816
		var/penalty = their_bank - floor(their_bank * penalty_percent)
		return -penalty

/// My first unit tests! :3
/datum/controller/subsystem/economy/proc/test_daily_calcs()
	// var/list/dates_of_interest = list()
	// for(var/i in 1 to 500)
	// 	// var/list/newday = splittext(time2text(round(world.realtime - ((i - 1) * (1 DAYS)), (1 DAYS)), "YYYY-MM-DD"), "-")
	// 	// dates_of_interest += TIMES_TO_NUMBER(text2num(newday[1]), text2num(newday[2]), text2num(newday[3]))
	// 	// dates_of_interest += floor((world.realtime - ((i - 1) * (1 DAYS)) - (23 YEARS)) / (1 DAYS))
	// 	dates_of_interest += REALTIME2QDAYS(i)
	// dates_of_interest = reverseList(dates_of_interest)
	var/list/dates_of_interest = relevant_dates.Copy() // whatever
	var/list/return_list = list()
	/// penalty loop
	var/list/date_list = list()
	var/test_amount = 10000

	/// 1. logging in again on the same day
	/// - should return 0 and no changed bank
	date_list = list(LAZYACCESS(dates_of_interest, 1))
	var/exp_penalty = 0
	var/exp_bank = test_amount
	return_list += run_unit_test("1. logging in again on the same day", date_list, test_amount, exp_bank, exp_penalty)

	/// 2. logging in after a day
	/// - should return a bonus of 100, and the bank should be increased to test_amount + 100
	date_list = list(LAZYACCESS(dates_of_interest, 2))
	exp_penalty = (spree_reward_per_day * 1)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("2. logging in after a day", date_list, test_amount, exp_bank, exp_penalty)

	/// 3. logging in after 2 days
	/// - should return one penalty, and the bank should be reduced to test_amount - (1 = (0.02^1))
	date_list = list(LAZYACCESS(dates_of_interest, 3))
	exp_penalty = -( test_amount - floor(test_amount * ((1-housing_fee_percent) ** 1)))
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("3. logging in after 2 days", date_list, test_amount, exp_bank, exp_penalty)

	/// 4. logging in after 3 days
	/// - should return two penalty, and the bank should be reduced to test_amount - (2 = (0.02^2))
	date_list = list(LAZYACCESS(dates_of_interest, 4))
	exp_penalty = -( test_amount - floor(test_amount * ((1-housing_fee_percent) ** 2)))
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("4. logging in after 3 days", date_list, test_amount, exp_bank, exp_penalty)

	/// 5. logging in after 7 days
	/// - should return six penalty, and the bank should be reduced to test_amount - (6 = (0.02^6))
	date_list = list(LAZYACCESS(dates_of_interest, 8))
	exp_penalty = -( test_amount - floor(test_amount * ((1-housing_fee_percent) ** 6)))
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("5. logging in after 7 days", date_list, test_amount, exp_bank, exp_penalty)

	/// 6. logging in after 8 days (the max)
	/// - should return seven penalty, and the bank should be reduced to test_amount - (7 = (0.02^7))
	date_list = list(LAZYACCESS(dates_of_interest, 9))
	exp_penalty = -( test_amount - floor(test_amount * ((1-housing_fee_percent) ** 7)))
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("6. logging in after 8 days (max)", date_list, test_amount, exp_bank, exp_penalty)

	/// 7. logging in after 200 days
	/// - should return seven penalty, and the bank should be reduced to test_amount - (7 = (0.02^7))
	date_list = list(LAZYACCESS(dates_of_interest, 201))
	exp_penalty = -( test_amount - floor(test_amount * ((1-housing_fee_percent) ** 7)))
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("7. logging in after 200 days", date_list, test_amount, exp_bank, exp_penalty)

	/// reward loop
	/// 8. logging in today and yesterday
	/// - should return 1 bonus, and the bank should be increased to test_amount + 100
	date_list = list(LAZYACCESS(dates_of_interest, 2))
	exp_penalty = (spree_reward_per_day * 1)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("8. logging in today and yesterday", date_list, test_amount, exp_bank, exp_penalty)

	/// 9. logging in today, yesterday, and the day before that
	/// - should return 2 bonus, and the bank should be increased to test_amount + 200
	date_list = list(LAZYACCESS(dates_of_interest, 2), LAZYACCESS(dates_of_interest, 3))
	exp_penalty = (spree_reward_per_day * 2)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("9. logging in today, yesterday, and the day before that", date_list, test_amount, exp_bank, exp_penalty)

	/// 10. logging in today, yesterday, the day before that, and the day before that
	/// - should return 3 bonus, and the bank should be increased to test_amount + 300
	date_list = list(LAZYACCESS(dates_of_interest, 2), LAZYACCESS(dates_of_interest, 3), LAZYACCESS(dates_of_interest, 4))
	exp_penalty = (spree_reward_per_day * 3)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("10. logging in today, yesterday, the day before that, and the day before that", date_list, test_amount, exp_bank, exp_penalty)

	/// 11. logging in for the past 20 days
	/// - should return 7 bonus, and the bank should be increased to test_amount + 700
	date_list.Cut()
	for(var/i in 2 to 20)
		date_list += LAZYACCESS(dates_of_interest, i)
	exp_penalty = (spree_reward_per_day * 7)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("11. logging in for the past 20 days", date_list, test_amount, exp_bank, exp_penalty)

	/// 12. logging in for the past 5 days, then a break of 2 days, then logging in for the past 200 days
	/// - should return 5 bonus, and the bank should be increased to test_amount + 500
	date_list.Cut()
	for(var/i in 2 to 6)
		date_list += LAZYACCESS(dates_of_interest, i)
	for(var/i in 8 to 200)
		date_list += LAZYACCESS(dates_of_interest, i)
	exp_penalty = (spree_reward_per_day * 5)
	exp_bank = test_amount + exp_penalty
	return_list += run_unit_test("12. logging in for the past 5 days, then a break of 2 days, then logging in for the past 200 days", date_list, test_amount, exp_bank, exp_penalty)
	var/printme = return_list.Join("\n")
	to_chat(world, span_boldannounce("Daily spawn in stuff tests:\n") + "[printme]")

/datum/controller/subsystem/economy/proc/run_unit_test(nombre = "ERROR", list/date_list = list(today), cash_before = 1000, expected_cash_after = 1000, expected_penalty = 1000)
	var/penalty = calculate_daily_spawn_in_stuff(null, date_list, cash_before)
	var/cash_after = cash_before + penalty
	var/days_passed = relevant_dates[1] - LAZYACCESS(date_list, 1)
	var/list/gotted_data = list(
		"cash_before" = cash_before, 
		"penalty" = penalty, 
		"expected_penalty" = expected_penalty, 
		"cash_after" = cash_after, 
		"expected_cash_after" = expected_cash_after,
		"days_passed" = days_passed
		)
	return parsify_unit_tests(nombre, gotted_data)

/datum/controller/subsystem/economy/proc/parsify_unit_tests(nombre, list/parseme_list)
	var/return_string = "[nombre]\n"
	return_string += "\tDays passed: [parseme_list["days_passed"]]\n"
	return_string += "\tCash before: [parseme_list["cash_before"]]\n"
	var/pig = parseme_list["penalty"] == parseme_list["expected_penalty"] ? span_green("PASS") : span_alert("FAIL")
	return_string += "\tExpected change: [parseme_list["expected_penalty"]]\n"
	return_string += "\tChange: [parseme_list["penalty"]] -> [pig]\n"
	var/cow = parseme_list["cash_after"] == parseme_list["expected_cash_after"] ? span_green("PASS") : span_alert("FAIL")
	return_string += "\tExpected cash after: [parseme_list["expected_cash_after"]]\n"
	return_string += "\tCash after: [parseme_list["cash_after"]] -> [cow]\n"
	return return_string

/// Actually ded00cts the money from the player
// /datum/controller/subsystem/economy/proc/calculate_daily_spawn_in_stuff(taxated)
// 	if(!taxated)
// 		return FALSE
// 	var/datum/preferences/P = extract_prefs(taxated)
// 	if(!P)
// 		return FALSE
// 	var/penalty = housing_fee_percent(taxated)
// 	if(!penalty)
// 		return FALSE
// 	P.saved_unclaimed_points -= penalty
// 	P.last_quest_login = world.realtime
// 	P.save_character()
// 	return penalty

/// Handles when the player logs in, to load their quest book, but NOT calculate penalties (at least not yet)
/// basically just a wrapper for get_quest_book
/datum/controller/subsystem/economy/proc/player_login(someone)
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		CRASH("No preferences for [someone]!")
	P.anticipated_daily_change = calculate_daily_spawn_in_stuff(someone)
	return P.anticipated_daily_change

/// Handles actually deducting/adding cash to the player's account, updating their cash, updating their personal calendar
/// Updates their calendar on fire! So, be mindful with it
/datum/controller/subsystem/economy/proc/player_spawned(someone)
	var/datum/preferences/P = extract_prefs(someone)
	if(!P)
		return FALSE
	if(LAZYACCESS(P.days_spawned_in, 1) == today)
		return FALSE // already been handled!
	var/penalty = P.anticipated_daily_change
	if(!penalty)
		penalty = calculate_daily_spawn_in_stuff(someone)
	P.saved_unclaimed_points += penalty
	P.anticipated_daily_change = 0
	P.last_quest_login = world.realtime
	P.days_spawned_in.Insert(1, REALTIME2QDAYS(0)) // 0 is today
	P.save_character()
	var/datum/quest_book/QB = get_quest_book(someone)
	QB.load_saved_data()
	return penalty

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
	next_quest_update = world.time + quest_update_interval
	last_quest_update = world.time
	QDEL_LIST_ASSOC_VAL(quest_pool)
	if(debug_quests)
		var/list/quist = list()
		for(var/thingtype in all_quests)
			var/datum/bounty/B = LAZYACCESS(all_quests, thingtype)
			if(B.is_laggy_as_hell && !debug_include_laggy_item_quests)
				continue
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
		if(B.is_laggy_as_hell && !debug_include_laggy_item_quests)
			continue
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
		var/datum/quest_book/QB = LAZYACCESS(quest_books, kcey)
		QB.questpool_updated()

/// gives a local copy of a quest to a player's device........ if they can handle it!!
/datum/controller/subsystem/economy/proc/add_active_quest(datum/bounty/B, mob/user, loud = TRUE)
	if(!user)
		return FALSE
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return FALSE
	return QB.add_active_quest(B, TRUE)

/// removes an active quest
/datum/controller/subsystem/economy/proc/remove_active_quest(datum/bounty/B, mob/user, loud = TRUE, system_handled)
	if(!user)
		return FALSE
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return FALSE
	return QB.remove_active_quest(B, loud, system_handled)

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
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return FALSE
	. = QB.finish_quest(B, TRUE)
	update_quest_statistics()

/datum/controller/subsystem/economy/proc/adjust_funds(mob/user, amount, datum/bounty/payer)
	if(!user || !amount)
		return
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return
	return QB.adjust_funds(amount, payer)

/datum/controller/subsystem/economy/proc/get_top_quester_quest_book()
	var/highest_completed = 0
	var/highest_completed_uid = ""
	for(var/k in quest_books)
		var/datum/quest_book/QB = LAZYACCESS(quest_books, k)
		if(LAZYLEN(QB.finished_this_round) > highest_completed)
			highest_completed = LAZYLEN(QB.finished_this_round)
			highest_completed_uid = QB.q_uid
	return LAZYACCESS(quest_books, highest_completed_uid)

/datum/controller/subsystem/economy/proc/get_top_earner_quest_book()
	var/highest_banked = 0
	var/highest_banked_uid = ""
	for(var/k in quest_books)
		var/datum/quest_book/QB = LAZYACCESS(quest_books, k)
		if(QB.overall_banked > highest_banked)
			highest_banked = QB.overall_banked
			highest_banked_uid = QB.q_uid
	return LAZYACCESS(quest_books, highest_banked_uid)

/datum/controller/subsystem/economy/proc/update_quest_statistics()
	highest_banked = 0
	highest_banked_uid = ""
	highest_completed = 0
	highest_completed_uid = ""
	total_banked = 0
	total_completed = 0
	most_valuable_quest = 0
	most_valuable_quest_uid = ""
	historical_highest_completed = 0
	historical_highest_completed_uid = ""
	historical_highest_banked = 0
	historical_highest_banked_uid = ""
	var/updatem = FALSE
	if(COOLDOWN_FINISHED(src, static_spam))
		updatem = TRUE
		COOLDOWN_START(src, static_spam, 2 SECONDS)
	for(var/k in quest_books)
		var/datum/quest_book/QB = LAZYACCESS(quest_books, k)
		total_banked += QB.overall_banked
		total_completed += LAZYLEN(QB.finished_this_round)
		/// compare how much they earned this round to the highest
		if(QB.overall_banked > highest_banked)
			highest_banked = QB.overall_banked
			highest_banked_uid = QB.q_uid
		/// compare how many they completed this round to the highest
		if(LAZYLEN(QB.finished_this_round) > highest_completed)
			highest_completed = LAZYLEN(QB.finished_this_round)
			highest_completed_uid = QB.q_uid
		/// compare how many quest they've completed throughout all time to the highest
		if(LAZYLEN(QB.get_historical_finished()) > historical_highest_completed)
			historical_highest_completed = QB.get_historical_finished()
			historical_highest_completed_uid = QB.q_uid
		/// compare how much they've earned throughout all time to the highest
		if(QB.get_historical_banked() > historical_highest_banked)
			historical_highest_banked = QB.get_historical_banked()
			historical_highest_banked_uid = QB.q_uid
		// for(var/datum/finished_quest/FQ in QB.finished_quests)
		// 	if(FQ.value > most_valuable_quest)
		// 		most_valuable_quest = FQ.value
		// 		most_valuable_quest_uid = FQ.quest_uid
		if(updatem)
			QB.update_pls = TRUE
	

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
		var/datum/quest_book/QB = LAZYACCESS(quest_books, k)
		QB.remove_active_quest(B, FALSE, system_handled)

/datum/controller/subsystem/economy/proc/is_part_of_a_quest(atom/thing)
	if(!thing)
		return FALSE
	return LAZYACCESS(quest_things, thing.type)

/datum/controller/subsystem/economy/proc/check_quest_repeat(mob/completer, datum/bounty/B)
	if(!completer || !completer.client)
		return
	var/datum/quest_book/QB = get_quest_book(completer)
	if(!QB)
		return
	QB.have_they_done_this_quest_before(B)

/datum/controller/subsystem/economy/proc/extract_quid(something)
	if(!something)
		return
	var/datum/preferences/P = extract_prefs(something)
	if(P)
		return P.quester_uid

/datum/controller/subsystem/economy/proc/quid2mob(q_uid)
	for(var/client/plr in GLOB.clients)
		if(!plr.mob)
			continue // shouldnt ever ever happen but idk
		var/datum/preferences/P = extract_prefs(plr)
		if(P && P.quester_uid == q_uid)
			return plr.mob

/datum/controller/subsystem/economy/proc/get_quest_book(mob/completer)
	if(!completer)
		return
	var/datum/preferences/P = extract_prefs(completer)
	if(!P)
		return
	var/datum/quest_book/QB = LAZYACCESS(quest_books, P.quester_uid)
	if(!QB)
		QB = new(completer)
	return QB

/datum/controller/subsystem/economy/proc/open_quest_console(mob/user, atom/thing)
	if(!user)
		return
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return
	QB.open_console(user)

/datum/controller/subsystem/economy/proc/give_claimer(mob/user, atom/base)
	if(!user)
		return
	var/obj/item/in_active_hand = user.get_active_held_item()
	var/obj/item/inactive_hand = user.get_inactive_held_item()
	if(istype(in_active_hand, /obj/item/hand_item/quest_scanner))
		to_chat(user, span_warning("You're already standing there with your claimer in your hand!"))
		return
	if(istype(inactive_hand, /obj/item/hand_item/quest_scanner))
		if(in_active_hand == null)
			if(user.put_in_hands(inactive_hand))
				to_chat(user, span_notice("You get out the Claimer!"))
			return
		to_chat(user, span_warning("You already have a quest scanner, right there in your other hand! You'd get it out, but your [prob(1) ? "beans" : "hands"] are full!"))
		return
	var/list/all_their_stuff = get_all_in_turf(user)
	for(var/atom/thing in all_their_stuff)
		if(istype(thing, /obj/item/hand_item/quest_scanner))
			if(user.put_in_hands(thing))
				to_chat(user, span_notice("You get out the Claimer!"))
				return
			to_chat(user, span_warning("You already have a quest scanner, right there in your [thing.loc]! You'd get it out, but your hands are full!"))
			return
	if(in_active_hand && inactive_hand)
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
	var/datum/quest_book/QB = get_quest_book(user)
	var/atom/thing = GET_WEAKREF(QB.last_used)
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
	var/datum/quest_book/QB = get_quest_book(user)
	return QB.turn_something_in(thing)

/datum/controller/subsystem/economy/proc/is_duplicate_submission(atom/thing, mob/user, datum/bounty_quota/BQ)
	if(!thing || !user || !BQ)
		return FALSE
	if(!LAZYLEN(thing.quest_tag))
		return FALSE // nobody's even touched it, sadge
	var/datum/quest_book/QB = get_quest_book(user)
	if(!QB)
		return FALSE
	var/user_uid = QB.q_uid
	for(var/datum/quest_tag_data/QTD in thing.quest_tag)
		if(QTD.quid != user_uid)
			continue
		if(QTD.did_they_do_it(BQ.bq_uid, user_uid))
			return TRUE

/datum/controller/subsystem/economy/proc/mark_quest_submission(atom/thing, mob/living/user, datum/bounty_quota/BQ)
	if(!thing || !BQ || !BQ)
		return
	var/datum/quest_book/QB = get_quest_book(user)
	if(!BQ)
		return
	var/user_uid = QB.q_uid
	for(var/datum/quest_tag_data/QTD in thing.quest_tag)
		if(QTD.quid != user_uid)
			continue
		if(QTD.did_they_do_it(BQ.bq_uid, user_uid))
			return FALSE
		QTD.add_bq_uid(BQ.bq_uid, user_uid)
		return TRUE
	/// didnt find one, lets make one
	var/datum/quest_tag_data/QTD = new(user_uid)
	QTD.add_bq_uid(BQ.bq_uid, user_uid)
	LAZYINITLIST(thing.quest_tag)
	thing.quest_tag |= QTD
	return TRUE

//// datum used to hold information as to who did what to who now
/datum/quest_tag_data
	var/quid
	var/list/bqoids = list()

/datum/quest_tag_data/New(quid)
	. = ..()
	if(!quid)
		qdel(src)
		return
	src.quid = quid

/datum/quest_tag_data/proc/add_bq_uid(bquid, their_quid)
	if(!bquid || their_quid != quid)
		return
	bqoids[bquid] = TRUE

/datum/quest_tag_data/proc/did_they_do_it(bquid, their_quid)
	if(!bquid || their_quid != quid)
		return FALSE
	return LAZYACCESS(bqoids, bquid)

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
	return next_quest_update - world.time
	
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

////////////////////////////////////////////////////////////////////////////
/// Quest book /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
/datum/quest_book
	var/q_uid
	var/ownername = "RELPH"
	var/ownerjob = "RELPHER"
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
	var/lifetime_total_banked = 0
	/// list of unique(ish) IDs of things that have been turned in
	var/list/things_turned_in = list() // THINGS IVE SHOVED UP ME ARSE
	var/list/paystubs = list()
	var/datum/quest_window/QW
	var/printer_cooldown = 0
	var/claim_on_kill = FALSE
	/// the bingus
	var/virgin = TRUE
	var/list/finished_this_round = list()
	var/update_pls = FALSE
	var/save_cooldown = 0 // just so we dont clobber the hard drive
	/// the bongos
	var/double_virgin = TRUE
	var/queued_save = FALSE
	var/lifetime_quest_total = 0
	var/save_spam_cooldown = 0
	var/scanning_mobs_makes_nests_dump_questable_mobs = FALSE
	/// and the holy bepis
	var/triple_virgin = TRUE
	var/money_dialogging = FALSE
	var/max_coin_depositry = QUEST_MINIMUM_MAX_COIN_DEPOSIT
	var/coins_deposited = 0

/datum/quest_book/New(mob/quester)
	. = ..()
	if(!quester)
		stack_trace("Quest book created without a quester!")
		qdel(src)
		return
	var/datum/preferences/P = extract_prefs(quester)
	if(!P)
		stack_trace("Quest book created for [quester], but they lacked a prefs file!")
		qdel(src)
		return
	q_uid = P.quester_uid
	QW = new(src)
	if(!LAZYACCESS(SSeconomy.quest_books, q_uid))
		SSeconomy.quest_books[q_uid] = src
	update_owner_data(quester)

/datum/quest_book/proc/load_saved_data()
	var/mob/quester = SSeconomy.quid2mob(q_uid)
	/// who lives in a pineapple under the sea?
	load_player_finished_quests(quester)
	/// who loves his brainwashing and always wants more?
	load_player_active_quests(quester)
	/// who's got a big quest book and a heart full of glee?
	load_player_banked_points(quester)

/datum/quest_book/Destroy(force, ...)
	if(QW)
		QDEL_NULL(QW)
	SSeconomy.quest_books -= q_uid
	last_used = null
	. = ..()

/datum/quest_book/proc/update_owner_data(mob/quester)
	if(!isliving(quester))
		ownername = safepick(GLOB.cow_names + GLOB.carp_names)
		ownerjob = "[safepick(GLOB.megacarp_first_names)] [safepick(GLOB.megacarp_last_names)]"
		return
	if(ckey(quester.real_name) == ckey(quester.ckey) || ckey(quester.name) == ckey(quester.ckey))
		if(!(strings("data/super_special_ultra_instinct.json", "[ckey(quester.name)]", TRUE, TRUE) || strings("data/super_special_ultra_instinct.json", "[ckey(quester.real_name)]", TRUE, TRUE)))
			ownername = safepick(GLOB.cow_names + GLOB.carp_names + GLOB.megacarp_last_names)
			ownerjob = "Cowshark"
			return
	ownername = quester.real_name
	ownerjob = quester.job
	if(update_pls) // not a bad place for it tbh
		update_pls = FALSE
		update_static_data(quester)

/datum/quest_book/proc/add_active_quest(datum/bounty/B, loud = TRUE)
	var/mob/user = SSeconomy.quid2mob(q_uid)
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
	update_owner_data(user)
	update_static_data(user)
	sync_active_quests_with_save()
	return TRUE

/datum/quest_book/proc/can_take_quest(datum/bounty/B, loud = TRUE)
	if(!B)
		return FALSE
	var/mob/user = SSeconomy.quid2mob(q_uid)
	update_owner_data(user)
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
	var/mob/user = SSeconomy.quid2mob(q_uid)
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
	sync_active_quests_with_save()
	update_owner_data(user)
	update_static_data(user)
	return TRUE

/datum/quest_book/proc/turn_something_in(atom/thing)
	if(!thing)
		return FALSE
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, turnin_cooldown))
		return FALSE
	COOLDOWN_START(src, turnin_cooldown, 0.2 SECONDS)
	var/turf/here = get_turf(user) // just so moving will interrupt it
	var/list/stuff = list()
	stuff |= thing
	stuff |= thing.contents // warning, may extract nuts
	stuff |= get_all_in_turf(get_turf(thing))
	mainloop:
		for(var/atom/thingy in stuff)
			var/mob/living/no_stealing = recursive_loc_path_search(thingy, /mob/living, 7)
			if(no_stealing && no_stealing.ckey)
				continue mainloop // no stealing things from players
			for(var/uid in active_quests)
				var/datum/bounty/B = LAZYACCESS(active_quests, uid)
				if(B.attempt_turn_in(thingy,user,TRUE))
					. = TRUE
				update_static_data(user)
				if(get_turf(user) != here)
					break mainloop // maybe THIS labeled break will survive more than 1 commit
	sync_active_quests_with_save()
	update_owner_data(user)

/datum/quest_book/proc/finish_quest(datum/bounty/B, loud = TRUE)
	if(istext(B))
		B = LAZYACCESS(active_quests, B)
	if(!B)
		return FALSE
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return FALSE
	update_owner_data(user)
	if(!B.is_complete())
		if(loud)
			to_chat(user, span_alert("That quest still has things it needs!"))
		return FALSE
	if(!B.payout(user))
		if(loud)
			to_chat(user, span_alert("Something went wrong with the payment method!!!!!!!"))
		return FALSE
	quest_done(B)
	lifetime_quest_total++
	SSeconomy.deactivate_quest(B) // just so they get good and dizzy
	remove_active_quest(B, FALSE, TRUE)
	update_lifetime_total(TRUE)
	update_static_data(user)
	playsound(user, 'sound/effects/quest_cashout.ogg', 40, TRUE)
	return TRUE

/datum/quest_book/proc/quest_done(datum/bounty/B)
	if(!B)
		return FALSE
	finished_quests |= new /datum/finished_quest(B)
	finished_this_round[B.uid] = B
	compare_n_sort_finished_quests()

/datum/quest_book/proc/load_player_banked_points(mob/quester)
	if(!quester)
		return
	var/datum/preferences/P = extract_prefs(quester)
	if(!P)
		return
	lifetime_total_banked = P.historical_banked_points
	triple_virgin = FALSE // we will always remain a triple virgin =3

/datum/quest_book/proc/load_player_finished_quests(mob/quester)
	if(!quester)
		return
	var/datum/preferences/P = extract_prefs(quester)
	if(!P)
		return
	virgin = FALSE
	/// list format: list("1" = list(list(queststuff)), "2" = list(top_5_medium_quests), "4" = list(top_5_hard_quests)), "8" = list(top_5_cbt_quests))
	for(var/list/questy in P.saved_finished_quests)
		if(!LAZYACCESS(questy, "VALID"))
			P.saved_finished_quests -= questy
			continue
		var/datum/finished_quest/FQ = new /datum/finished_quest()
		FQ.deserialize_from_list(questy)
		finished_quests += FQ
	lifetime_quest_total = P.number_of_finished_quests
	compare_n_sort_finished_quests()

/// if nautical nonsense be something you wish
/datum/quest_book/proc/compare_n_sort_finished_quests()
	/// sort by difficulty
	var/list/semisorted_grabbag = list()
	semisorted_grabbag["[QUEST_DIFFICULTY_EASY]"] = list()
	semisorted_grabbag["[QUEST_DIFFICULTY_MED]"] = list()
	semisorted_grabbag["[QUEST_DIFFICULTY_HARD]"] = list()
	semisorted_grabbag["[QUEST_DIFFICULTY_CBT]"] = list()
	for(var/datum/finished_quest/FQ in finished_quests)
		if(CHECK_BITFIELD(FQ.quest_difficulty, QUEST_DIFFICULTY_EASY))
			semisorted_grabbag["[QUEST_DIFFICULTY_EASY]"] += FQ
		if(CHECK_BITFIELD(FQ.quest_difficulty, QUEST_DIFFICULTY_MED))
			semisorted_grabbag["[QUEST_DIFFICULTY_MED]"] += FQ
		if(CHECK_BITFIELD(FQ.quest_difficulty, QUEST_DIFFICULTY_HARD))
			semisorted_grabbag["[QUEST_DIFFICULTY_HARD]"] += FQ
		if(CHECK_BITFIELD(FQ.quest_difficulty, QUEST_DIFFICULTY_CBT))
			semisorted_grabbag["[QUEST_DIFFICULTY_CBT]"] += FQ
	/// list of quests by difficulty, only saving the top 5
	var/list/allsorts = list()
	allsorts["[QUEST_DIFFICULTY_EASY]"] = list()
	allsorts["[QUEST_DIFFICULTY_MED]"] = list()
	allsorts["[QUEST_DIFFICULTY_HARD]"] = list()
	allsorts["[QUEST_DIFFICULTY_CBT]"] = list()
	// of each, keep only the top 4 by rewarded
	for(var/diffi in semisorted_grabbag)
		var/list/quests = semisorted_grabbag[diffi]
		for(var/datum/finished_quest/FQ in quests)
			if(LAZYLEN(allsorts[diffi]) < 4)
				allsorts[diffi] += FQ
			else
				for(var/datum/finished_quest/FQ2 in allsorts[diffi])
					if(FQ.quest_rewarded > FQ2.quest_rewarded)
						allsorts[diffi] -= FQ2
						allsorts[diffi] += FQ
						break
	var/list/pre_finished = list()
	/// now we have a list of the top 4 of each difficulty
	/// lets sort them by value
	var/list/in_this_order = list("[QUEST_DIFFICULTY_EASY]", "[QUEST_DIFFICULTY_MED]", "[QUEST_DIFFICULTY_HARD]", "[QUEST_DIFFICULTY_CBT]")
	for(var/diffi in in_this_order)
		var/list/quests = allsorts[diffi]
		quests = sortTim(quests, /proc/cmp_sort_finished_quest_by_value)
		pre_finished += quests
	/// now we have a list of the top 5 of each difficulty, sorted by value
	finished_quests = pre_finished.Copy()

/proc/cmp_sort_finished_quest_by_value(datum/finished_quest/A, datum/finished_quest/B)
	var/result = text2num(B.quest_rewarded) - text2num(A.quest_rewarded)
	if(result == 0)
		result = text2num(B.quest_round_id) - text2num(A.quest_round_id)
	return result

/datum/quest_book/proc/sort_by_difficulty()
	var/list/my_finished = sortTim(finished_quests.Copy(), /proc/cmp_sort_finished_quest_by_roundid_or_time_completed)
	finished_quests = my_finished.Copy()

/proc/cmp_sort_finished_quest_by_roundid_or_time_completed(datum/finished_quest/A, datum/finished_quest/B)
	var/result = text2num(B.quest_round_id) - text2num(A.quest_round_id)
	if(result == 0)
		result = text2num(B.quest_time_completed) - text2num(A.quest_time_completed)
	return result

/datum/quest_book/proc/update_lifetime_total(sync_active_too)
	if(virgin)
		return // they havent loaded in yet!
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return // iether doesnt exist or isnt connected
	update_owner_data(user)
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return
	P.saved_finished_quests = serialize_finished_quests_to_list()
	if(lifetime_quest_total >= P.number_of_finished_quests) // we somehow have less quests than are saved (which cannot happen!!!!)
		P.historical_banked_points = lifetime_total_banked
	if(sync_active_too)
		if(sync_active_quests_with_save())
			return
	P.save_character() // backup plan

/datum/quest_book/proc/serialize_finished_quests_to_list()
	var/list/quests = list()
	compare_n_sort_finished_quests()
	for(var/datum/finished_quest/FQ in finished_quests)
		quests += list(FQ.serialize_to_list())
	return quests

/// builds quests from the saved ones in a player's save, if any
/datum/quest_book/proc/load_player_active_quests()
	if(!double_virgin)
		return // already took a hot load
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return // they dont exist or arent connected
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return // they broke everything
	// SSeconomy.incur_housing_fee_percent(P)
	adjust_funds(P.saved_unclaimed_points, null, FALSE)
	max_coin_depositry = max(QUEST_MINIMUM_MAX_COIN_DEPOSIT, round(unclaimed_points * 0.1, 100)) // increments of 10 coins
	coins_deposited = 0
	var/list/savequests = P.saved_active_quests.Copy()
	for(var/list/questy in savequests)
		if(!LAZYACCESS(questy, "VALID"))
			message_admins("Quest Book: Quest loading for [user.ckey] encourntered an invalid save chunk! This is bad! It means they couldnt load their active quests!")
			P.saved_active_quests -= questy
			continue
		var/datum/bounty/B = text2path(questy[QB_SAVE_QUEST_TYPE])
		B = new B(null, TRUE) // prevents it from generating anything
		var/succeedful = B.deserialize_from_list(questy[QB_SAVE_QUEST_DATA])
		if(!succeedful)
			message_admins("Quest Book: Quest loading for [user.ckey] failed for quest [B.name]! This is bad! It means they couldnt load their active quests!")
			CRASH("Quest Book: Quest loading for [user.ckey] failed for quest [B.name]! This is bad! It means they couldnt load their active quests!")
		active_quests[B.uid] = B
		SSeconomy.activate_quest(B)
		B.assign_to(user)
	double_virgin = FALSE
	to_chat(user, span_green("Loaded [LAZYLEN(active_quests)] quests and [SSeconomy.format_currency(P.saved_unclaimed_points, TRUE)] from your save file! =3"))
	return TRUE

/// Save all the active quests to the save, overwriting whatever's in there
/datum/quest_book/proc/sync_active_quests_with_save()
	if(double_virgin)
		return // we havent gotten our user's load yer!
	if(!COOLDOWN_FINISHED(src, save_cooldown))
		queued_save = TRUE
		return FALSE
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return FALSE
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return FALSE
	var/list/to_save = list()
	for(var/uid in active_quests)
		var/datum/bounty/B = LAZYACCESS(active_quests, uid)
		var/list/presave = B.serialize_to_list()
		if(!LAZYACCESS(presave, "VALID"))
			message_admins("Quest Book: Quest serialization for [user.ckey] failed for quest [B.name]! This is bad! It means they couldnt save their active quests!")
			CRASH("Quest Book: Quest serialization for [user.ckey] failed for quest [B.name]! This is bad! It means they couldnt save their active quests!")
		var/list/save_package = list()
		save_package[QB_SAVE_QUEST_TYPE] = "[B.type]" // this is the type of the quest
		save_package[QB_SAVE_QUEST_DATA] = presave.Copy() // this is the data of the quest
		save_package["VALID"] = TRUE
		to_save += list(save_package)
	P.saved_active_quests = to_save.Copy()
	P.saved_unclaimed_points = unclaimed_points
	. = P.save_character()
	COOLDOWN_START(src, save_cooldown, 15 SECONDS)
	if(!COOLDOWN_FINISHED(src, save_spam_cooldown))
		return
	COOLDOWN_START(src, save_spam_cooldown, 15 SECONDS)
	


/datum/quest_book/proc/adjust_funds(amount, datum/bounty/B, update_overall = TRUE, set_it_instead = FALSE)
	if(!amount)
		return
	if(istype(B))
		if(LAZYACCESS(paystubs, B.uid))
			return // no double dipping~
		paystubs[B.uid] = amount
	var/delta = amount
	if(set_it_instead)
		delta = amount - unclaimed_points
		unclaimed_points = amount
	else
		unclaimed_points = clamp(unclaimed_points + delta, 0, 1000000000)
	if(update_overall)
		overall_banked += delta
		lifetime_total_banked += delta
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	var/datum/preferences/P = extract_prefs(user)
	P.saved_unclaimed_points = unclaimed_points
	P.historical_banked_points = lifetime_total_banked
	update_lifetime_total(FALSE)
	return TRUE

/datum/quest_book/proc/have_they_done_this_quest_before(datum/bounty/B)
	if(!B)
		return FALSE
	return LAZYACCESS(finished_this_round, B.uid)
	// todo: quests that you cann only ever take once, as, like, story quests or something

/datum/quest_book/proc/questpool_updated()
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	update_static_data(user)
	update_lifetime_total()
	sync_active_quests_with_save()
	if(!beep_on_update)
		return
	var/atom/thing = SSeconomy.get_plausible_quest_console(user)
	if(!thing)
		thing = user
	playsound(thing, 'sound/effects/quests_updated.ogg', 40, TRUE)

/// returns a typecache
/datum/quest_book/proc/get_quest_paths()
	var/list/out = list()
	for(var/uid in active_quests)
		var/datum/bounty/B = LAZYACCESS(active_quests, uid)
		out |= B.get_quest_paths()
	return out

/datum/quest_book/proc/open_console(mob/user)
	ui_interact(user) // @TalkingCactus: I'm not sure what this is supposed to do, but it's not doing anything right now.

/datum/quest_book/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CargoBountyConsole") // It has nothing to do with Cargo, it has nothing to do with bounties, it has everything to do with hurting
		ui.open()

/datum/quest_book/ui_state(mob/user)
	return GLOB.quest_book_state

/datum/quest_book/ui_static_data(mob/user)
	var/list/data = list()
	var/list/bountyinfo = list()
	for(var/uid in SSeconomy.quest_pool)
		var/datum/bounty/B1 = LAZYACCESS(SSeconomy.quest_pool, uid)
		bountyinfo += list(B1.get_tgui(user))
	var/list/mybounties = list()
	for(var/uid2 in active_quests)
		var/datum/bounty/B2 = LAZYACCESS(active_quests, uid2)
		mybounties += list(B2.get_tgui(user))
	var/list/quest_history = list()
	for(var/datum/finished_quest/B3 in finished_quests)
		if(!SSeconomy.debug_ignore_historical_round_number_check && text2num(B3.quest_round_id) == text2num(GLOB.round_id))
			continue
		quest_history += list(B3.tgui_slug(user))
	var/list/recent_finished = list()
	for(var/uid3 in finished_this_round)
		var/datum/bounty/B3 = LAZYACCESS(finished_this_round, uid3)
		recent_finished += list(B3.get_tgui(user))
	data["UserName"] = user ? user.real_name : "RELPH"
	data["AllQuests"] = bountyinfo
	data["MyQuests"] = mybounties
	data["QuestHistory"] = quest_history
	data["MyFinished"] = recent_finished
	data["scanning_mobs_makes_nests_dump_questable_mobs"] = scanning_mobs_makes_nests_dump_questable_mobs

	data["CurrencyUnit"] = SSeconomy.currency_unit
	data["CurrencyName"] = SSeconomy.currency_name
	data["CurrencyNamePlural"] = SSeconomy.currency_name_plural
	data["ReadmeText"] = QUEST_BOOK_README
	var/list/toots = list()
	var/am_top_quester = (LAZYLEN(finished_this_round) >= SSeconomy.highest_completed)
	var/am_top_earner = (overall_banked >= SSeconomy.highest_banked)
	var/am_top_quester_historical = (get_historical_finished() >= SSeconomy.historical_highest_completed)
	var/am_top_earner_historical = (get_historical_banked() >= SSeconomy.historical_highest_banked)
	toots["AmTopQuester"] = am_top_quester
	toots["AmTopEarner"] = am_top_earner
	toots["AmTopQuesterHistorical"] = am_top_quester_historical
	toots["AmTopEarnerHistorical"] = am_top_earner_historical

	toots["TTyourquests"] = "You have completed [LAZYLEN(finished_this_round)] quests this period[am_top_quester ? ", making you the top quester this period! Nice job =3" : "."]"
	toots["TTtopquests"] = "The top quester this period has completed [SSeconomy.highest_completed] quests[am_top_quester ? ", and that top quester is you! Keep it up =3" : "."]"
	toots["TThistoricalquests"] = "Since the beginning of time, you have completed [get_historical_finished()] quests[am_top_quester_historical ? ", making you the top quester of all time (at least compared to everyone present)! Nice job =3" : "."]"
	toots["TTtophistoricalquests"] = "The top quester of all time has completed [SSeconomy.historical_highest_completed] quests[am_top_quester_historical ? ", and that top quester is you! Keep it up =3" : "."]"
	toots["TTglobalquests"] = "In total, [SSeconomy.total_completed] quests have been completed this period."

	toots["TTyourbanked"] = "You have earned [SSeconomy.format_currency(overall_banked, TRUE, TRUE)] this period[am_top_earner ? ", making you the top earner this period! Nice job =3" : "."]"
	toots["TTtopbanked"] = "The top earner this period has earned [SSeconomy.format_currency(SSeconomy.highest_banked, TRUE, TRUE)][am_top_earner ? ", and that top earner is you! Keep it up =3" : "."]"
	toots["TThistoricalbanked"] = "Since the beginning of time, you have earned [SSeconomy.format_currency(get_historical_banked(), TRUE, TRUE)][am_top_earner_historical ? ", making you the top earner of all time (at least compared to everyone present)! Nice job =3" : "."]"
	toots["TTtophistoricalbanked"] = "The top earner of all time has earned [SSeconomy.format_currency(SSeconomy.historical_highest_banked, TRUE, TRUE)][am_top_earner_historical ? ", and that top earner is you! Keep it up =3" : "."]"
	toots["TTglobalbanked"] = "In total, [SSeconomy.format_currency(SSeconomy.total_banked, TRUE, TRUE)] have been earned this period."

	data["Toots"] = toots
	return data

/datum/quest_book/ui_data(mob/user)
	var/list/data = list()
	data["TimeToNext"] = SSeconomy.update_when(TRUE)
	data["BeepOnUpdate"] = beep_on_update
	data["QuestCount"] = LAZYLEN(active_quests)
	data["QuestMax"] = SSeconomy.max_quests
	
	data["QuestsCompleted"] = LAZYLEN(finished_this_round)
	data["QuestHistoryCount"] = get_historical_finished()
	data["GlobalQuestsCompleted"] = SSeconomy.total_completed
	data["GlobalHighestCompleted"] = SSeconomy.highest_completed
	data["GlobalHistoricalQuestsCompleted"] = SSeconomy.historical_highest_completed

	data["BankedPoints"] = unclaimed_points
	data["HistoricalBankedPoints"] = get_historical_banked()
	data["OverallBankedPoints"] = overall_banked
	data["GlobalHighestBanked"] = SSeconomy.highest_banked
	data["GlobalTotalEarned"] = SSeconomy.total_banked
	data["GlobalHistoricalBanked"] = SSeconomy.historical_highest_banked
	return data

/datum/quest_book/ui_act(action,params)
	if(..())
		return
	var/mob/user = usr
	update_static_data(user)
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
			operate_cash_machine()
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
		if("ToggleNestDump")
			TOGGLE_VAR(scanning_mobs_makes_nests_dump_questable_mobs)
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
	playsound(user, "terminal_type", 50, TRUE)
	if(queued_save) // as good a heartbeat as any
		sync_active_quests_with_save()
		queued_save = FALSE

/datum/quest_book/proc/give_scanner()
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	SSeconomy.give_claimer(user)

/datum/quest_book/proc/show_quest(datum/bounty/B)
	if(!B)
		return
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	update_static_data(user)
	var/its_mine = LAZYACCESS(active_quests, B.uid) && !B.is_templarte
	QW.show_quest_window(user, B, its_mine)
	update_static_data(user)

/// Click with empty hand? it ask how mmuch cash u wanna out
/// click with ticket in hand? it puts ticket cash un u cashhole, 100% return
/// click with cash in hand? it puts cash in u cashhole, like 20% return
/datum/quest_book/proc/operate_cash_machine()
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	if(money_dialogging)
		to_chat(user, span_alert("You're already in the middle of a transaction!"))
		return
	var/obj/item/holded = user.get_active_held_item()
	if(holded && QDELING(holded))
		to_chat(user, span_alert("That item is no more!"))
		return
	if(istype(holded, /obj/item/card/quest_reward)) // Ticket in hand
		return devour_ticket(holded)
	// if(istype(holded, /obj/item/stack/f13Cash))
	// 	return deposit_coins(holded)
	return cash_out()

/datum/quest_book/proc/cash_out()
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	if(unclaimed_points < 10)
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("You don't have any cash to cash out! Try completing some quests =3"))
		return
	money_dialogging = TRUE
	var/howmuch = input(
		user,
		"How many [SSeconomy.currency_name_plural] would you like to withdraw? Max: [round(CREDITS_TO_COINS(unclaimed_points))]",
		"$$$ for U",
		0,
	) as num|null
	money_dialogging = FALSE
	if(isnull(howmuch) || howmuch == 0)
		to_chat(user, span_notice("Nevermind!!"))
		return
	if(!isnum(howmuch))
		to_chat(user, span_alert("That's not a number!"))
		return
	if(howmuch < 0)
		to_chat(user, span_alert("You need to enter a positive number to get anything out of this!"))
		return
	howmuch = round(COINS_TO_CREDITS(clamp(floor(howmuch), 0, unclaimed_points)), 10)
	return dispense_reward(howmuch)

/datum/quest_book/proc/deposit_coins(obj/item/stack/f13Cash/coins)
	if(!coins)
		return
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return
	update_owner_data(user)
	var/valueper = 1
	if(istype(coins, /obj/item/stack/f13Cash/caps))
		valueper = 1
	else if(istype(coins, /obj/item/stack/f13Cash/denarius))
		valueper = 10
	else if(istype(coins, /obj/item/stack/f13Cash/aureus))
		valueper = 100 // aaaaaaAAAAAAAAAAAAAAAA WHY ARENT THESE DEFINED ONST HR ASTUFNISJ K AAAAAAA
	var/totalvalue = coins.amount * valueper
	if(totalvalue < 1)
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("That cash is worthless!"))
		return
	var/to_tax = ceil(totalvalue * SSeconomy.coin_deposit_tax)
	var/to_deposit = totalvalue - to_tax
	if(to_deposit < COINS_TO_CREDITS(1))
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("The taxes wouldn't leave you with anything! Try depositing at least 10 [SSeconomy.currency_name_plural] worth of cash!"))
		return
	/// check if they have enough daily cash allowance to deposit this
	// var/allowance_remaining = max_coin_depositry - coins_deposited
	// if(allowance_remaining < COINS_TO_CREDITS)
	// 	playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
	// 	to_chat(user, span_alert("You've already deposited the maximum amount of cash today! Try again tomorrow!"))
	// 	return

	var/sans_representation = "You are holding [coins.amount] [coins.name], totalling [totalvalue] [SSeconomy.currency_name_plural].\n\n If you wish to deposit this into your Guild Account, this involves an 80% tax, meaning that you will deposit [to_deposit] [SSeconomy.currency_name_plural] into your account, and [to_tax] [SSeconomy.currency_name_plural] will [SSeconomy.public_projects]. \n\n\
		The money that is added to your account will be yours, and can be cashed out at any time, tax free. All banked cash will be subject to a [SSeconomy.housing_fee_percent * 100]% housing fee for every galactic cycle (1 real-life day) that you are not in the region (having spawned in on this character at least once that day). \
		Do you wish to proceed?"
	money_dialogging = TRUE
	var/confyrm = alert(
		user,
		sans_representation,
		"Tax Form CB-13",
		"Deposit",
		"Cancel",
	)
	money_dialogging = FALSE
	if(confyrm == "Deposit" && !QDELETED(coins))
		/// time has passed! time to update how much we're really adding to the cash hole
		var/newtotalvalue = coins.amount * valueper
		if(newtotalvalue != totalvalue) // their coins changed value!
			playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
			to_chat(user, span_alert("Deposit discrepancy detected! Transaction terminated, please try again!"))
			return // might be trying to pull a fast one, but more likely that stack code kinda chowdered their cash
		if(totalvalue < 1)
			playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
			to_chat(user, span_alert("That cash is suddenly worthless!"))
			return
		coins.amount = 0
		coins.value = 0
		qdel(coins)
		adjust_funds(round(COINS_TO_CREDITS(to_deposit)), null, FALSE, FALSE)
		to_chat(user, span_green("You deposited [to_deposit] [SSeconomy.currency_name_plural] (after taxes) into your Guild Account!"))
		playsound(user, 'sound/machines/coin_insert.ogg', 80, TRUE)
		update_static_data(user)
		return
	else
		to_chat(user, span_notice("Nevermind!!"))
		return

/datum/quest_book/proc/dispense_reward(cashmoney)
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return FALSE
	update_owner_data(user)
	if(unclaimed_points < 1)
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("You don't have any cash to cash out! Try completing some quests =3"))
		return FALSE
	var/payment = clamp(cashmoney, 0, unclaimed_points)
	if(payment < 1)
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("You don't have that much cash to cash out! Try completing some quests =3"))
		return FALSE
	adjust_funds(-payment, null, FALSE, FALSE)
	var/obj/item/card/quest_reward/QR = new(get_turf(user))
	QR.assign_value(payment, 1, "#[random_color()]")
	if(user)
		user.put_in_hands(QR)
	playsound(user, 'sound/machines/printer_press.ogg', 40, TRUE)
	update_lifetime_total()
	update_static_data(user)
	return TRUE

/// FIN VORE FIN VORE
/datum/quest_book/proc/devour_ticket(obj/item/card/quest_reward/QR)
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return FALSE
	update_owner_data(user)
	if(!istype(QR, /obj/item/card/quest_reward))
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("That's not a ticket!"))
		return FALSE
	var/payment = QR.saleprice
	QR.saleprice = 0
	if(payment < 1)
		playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
		to_chat(user, span_alert("That ticket is worthless!"))
		return FALSE
	playsound(user, 'sound/machines/printer_press_unbirth.ogg', 40, TRUE)
	to_chat(user, span_green("You deposited a ticket for [CREDITS_TO_COINS(payment)] [SSeconomy.currency_name_plural] into your Guild Account!"))
	qdel(QR)
	adjust_funds(payment, null, FALSE, FALSE)
	return TRUE

/datum/quest_book/proc/get_historical_finished()
	return lifetime_quest_total

/datum/quest_book/proc/get_historical_banked()
	return lifetime_total_banked

/datum/quest_book/proc/print_quest(datum/bounty/B)
	var/mob/user = SSeconomy.quid2mob(q_uid)
	if(!user)
		return FALSE
	update_owner_data(user)
	playsound(user, 'sound/machines/dash.ogg', 75, TRUE)
	to_chat(user, span_alert("Could not establish connection to FoxEye Wireless Printer. Contact your Guild webmaster for assistance."))
	// if(printer_cooldown > world.time)
	// 	to_chat(user, span_alert("The printer is still refilling its inkwell."))
	// 	return FALSE
	// B.print_quest(user)
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
			. = TRUE
		if("CancelQuest")
			SSeconomy.remove_active_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), user, TRUE)
			. = TRUE
		if("FinishQuest")
			SSeconomy.finish_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), user, TRUE)
			. = TRUE
		if("GiveScanner")
			parent.give_scanner()
			. = TRUE
		if("PrintQuest")
			parent.print_quest(LAZYACCESS(parent.active_quests, params["BountyUID"]), src, user)
			. = TRUE
		if("DebugGiveObjectivePoint")
			playsound(user, "terminal_type", 50, TRUE)
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
	playsound(user, "terminal_type", 50, TRUE)
	parent.update_static_data(user)

/////////////////////////////////////////////////
/// FINISHED QUEST /////////////////////////////
/// A record of a quest that has been completed
/// Cus I haaaaate huge lists
/datum/finished_quest
	var/quester_name
	var/quest_type
	var/quest_name
	var/quest_description
	var/quest_time_completed
	var/quest_round_id
	var/quest_difficulty
	var/quest_rewarded
	var/list/objectives = list()

/datum/finished_quest/New(datum/bounty/B, mob/finisher)
	if(!istype(B) && !istype(finisher))
		return // oh we're being loaded from a save, nice
	quester_name = finisher ? finisher.real_name : "RELPH"
	quest_type = B.type
	quest_name = B.name
	quest_description = B.description
	quest_time_completed = world.time
	quest_round_id = text2num(GLOB.round_id)
	quest_difficulty = B.difficulty
	quest_rewarded = B.get_reward()
	listify_objectives(B)

/datum/finished_quest/proc/listify_objectives(datum/bounty/B)
	for(var/datum/bounty_quota/BQ in B.wanted_things)
		objectives += list(BQ.listify())
	
/datum/finished_quest/proc/serialize_to_list()
	var/list/output = list()
	output[QF_QUESTER_NAME]           = quester_name
	output[QF_QUEST_TYPE]             = quest_type
	output[QF_QUEST_NAME]             = quest_name
	output[QF_QUEST_DESCRIPTION]      = quest_description
	output[QF_QUEST_TIME_COMPLETED]   = text2num(quest_time_completed)
	output[QF_QUEST_ROUND_ID]         = text2num(quest_round_id)
	output[QF_QUEST_DIFFICULTY]       = text2num(quest_difficulty)
	output[QF_QUEST_REWARDED]         = text2num(quest_rewarded)
	output[QF_OBJECTIVES]             = objectives
	output["VALID"]                   = TRUE // everyone is valid under the toolbox
	return output

/datum/finished_quest/proc/serialize_to_json()
	var/list/output = serialize_to_list()
	var/jason = safe_json_encode(output)
	return jason

/datum/finished_quest/proc/deserialize_from_json(jason)
	var/output = safe_json_decode(jason)
	deserialize_from_list(output)
	return TRUE

/datum/finished_quest/proc/deserialize_from_list(list/listin)
	quester_name          = listin[QF_QUESTER_NAME]
	quest_type            = listin[QF_QUEST_TYPE]
	quest_name            = listin[QF_QUEST_NAME]
	quest_description     = listin[QF_QUEST_DESCRIPTION]
	quest_time_completed  = text2num(listin[QF_QUEST_TIME_COMPLETED])
	quest_round_id        = text2num(listin[QF_QUEST_ROUND_ID])
	quest_difficulty      = text2num(listin[QF_QUEST_DIFFICULTY])
	quest_rewarded        = text2num(listin[QF_QUEST_REWARDED])
	objectives            = listin[QF_OBJECTIVES]
	return TRUE

/datum/finished_quest/proc/tgui_slug()
	var/list/output = list()
	output["FinQuester"]           = quester_name
	output["FinQuestName"]         = quest_name
	// output["FinQuestDescription"]  = quest_description
	output["FinQuestTime"]         = quest_time_completed
	output["FinQuestRound"]        = quest_round_id
	output["FinQuestDifficulty"]   = quest_difficulty
	output["FinQuestReward"]       = quest_rewarded
	output["FinQuestRound"]        = quest_round_id
	output["FinQuestObjectives"]   = list(objectives)
	return output

/// output quest report for the end of round window
/datum/quest_report
	var/top_quester_name = "Tad Ghostle"
	var/top_quester_job = "Repairman"
	var/top_quester_total = 0

	var/top_earner_name = "RELPH"
	var/top_earner_job = "RELPH"
	var/top_earner_total = 0

	var/total_quests = 0
	var/total_earned = 0

	var/currency_unit = ":("

/datum/quest_report/New()
	. = ..()
	SSeconomy.update_quest_statistics()
	var/datum/quest_book/top_q = SSeconomy.get_top_quester_quest_book()
	var/datum/quest_book/top_e = SSeconomy.get_top_earner_quest_book()
	if(top_q)
		top_quester_name = top_q.ownername
		top_quester_job = top_q.ownerjob
		top_quester_total = LAZYLEN(top_q.finished_this_round)
	if(top_e)
		top_earner_name = top_e.ownername
		top_earner_job = top_e.ownerjob
		top_earner_total = top_e.overall_banked
	total_quests = SSeconomy.total_completed
	total_earned = SSeconomy.total_banked
	currency_unit = SSeconomy.currency_unit


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
	punchable = FALSE

/obj/item/card/quest_reward/proc/assign_value(price, mult, coler)
	saleprice = round(price)
	punchbonus = round((price * mult) - price)
	add_atom_colour(coler, FIXED_COLOUR_PRIORITY)
	name = "Guild Quest voucher - [SSeconomy.format_currency(saleprice, TRUE)]"
	desc = "An OFFICIAL Guild voucher for making this horrible multi-dimensional hellscape just a bit less awful. At least until whatever you killed comes back to life, cus seriously, nothing ever stays dead. \
		\n\nThis thing is worth [SSeconomy.format_currency(saleprice, TRUE)]!"

/obj/item/card/quest_reward/punch()
	if(!..())
		return
	// name = "Guild Quest voucher - [round(CREDITS_TO_COINS(saleprice))] [SSeconomy.currency_unit] - [span_green("PUNCHED!")]"
	// desc = "An OFFICIAL Guild voucher for making this horrible multi-dimensional hellscape just a bit less awful. At least until whatever you killed comes back to life, cus seriously, nothing ever stays dead. 
	// 	\n\nThis thing is worth [round(CREDITS_TO_COINS(saleprice))] [SSeconomy.currency_unit]! It has been punched, so you've probably already gotten the reward. 
	// 	It is also worth [SEND_SIGNAL(src, COMSIG_ITEM_GET_RESEARCH_POINTS)] research points, perfect gift for your local scientist!"
	// return TRUE

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
	item_flags = PERSONAL_ITEM
	w_class = WEIGHT_CLASS_TINY
	slot_flags = INV_SLOTBIT_ANYWHERE
	max_reach = 7
	force = 0
	force_harmclick = TRUE
	var/ping_cooldown = 0
	var/being_used = FALSE

/obj/item/hand_item/quest_scanner/Initialize(mapload)
	. = ..()
	REMOVE_TRAIT(src, TRAIT_NO_STORAGE_INSERT, TRAIT_GENERIC)

/obj/item/hand_item/quest_scanner/examine(mob/user)
	. = ..()
	. += span_notice("This is a Quest Scanner! It is how you turn in things for quests.")
	. += span_notice("To use it, simply click on the thing you want to turn in.")
	. += span_notice("If that something is part of any of your quests, it will attempt to turn it in.")
	. += span_notice("You can click the ground under a pile of things, and it will attempt to turn in anything questable in that pile.")
	. += span_notice("If you're having trouble finding something to turn in, you can use the 'Ping' ability to scan the area for questable things.")
	. += span_notice("To do this, just use it in your hand, and it will highlight anything you can turn in.")
	. += span_notice("You can get one of these from the Quest Board with a button press, or by pressing the green SCAN-ER button on your HUD.")

/obj/item/hand_item/quest_scanner/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!istype(target))
		return
	if(being_used)
		to_chat(user, span_alert("Your [src] is still doing something!"))
		return
	// being_used = TRUE
	SSeconomy.attempt_turnin(target, user)
	// being_used = FALSE

/obj/item/hand_item/quest_scanner/attack_self(mob/user)
	. = ..()
	ping_for_stuff(user)

/obj/item/hand_item/quest_scanner/proc/ping_for_stuff(mob/user)
	if(!user)
		return
	if(!COOLDOWN_FINISHED(src, ping_cooldown))
		to_chat(user, span_alert("Your [src] is still processing all that data!"))
		return
	COOLDOWN_START(src, ping_cooldown, 1 SECONDS)
	var/datum/quest_book/QB = SSeconomy.get_quest_book(user)
	if(!QB)
		return
	var/found_something = FALSE
	var/list/cacheotypes = QB.get_quest_paths()
	for(var/turf/T in view(7, user))
		for(var/atom/movable/thing in T)
			if(!is_type_in_typecache(thing, cacheotypes))
				continue
			found_something = TRUE
			new /obj/effect/temp_visual/glowy_outline(get_turf(thing), thing)
			break
	if(found_something)
		playsound(user, 'sound/machines/twobeep.ogg', 55, TRUE)
		to_chat(user, span_notice("The Scanner beeps and lights up! It's found something!"))
	else
		playsound(user, 'sound/machines/terminal_error.ogg', 45, TRUE)
		to_chat(user, span_notice("The Scanner couldn't find anything!"))

/obj/effect/temp_visual/glowy_outline
	name = "something questable!"
	desc = "Oh hey! That thing can be turned in for a quest! Neat!"
	icon_state = "medi_holo"
	duration = 3 SECONDS
	var/sounding = TRUE

/obj/effect/temp_visual/glowy_outline/Initialize(mapload, atom/thing)
	. = ..()
	cool_stuff(thing)

/obj/effect/temp_visual/glowy_outline/proc/cool_stuff(atom/thing)
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

GLOBAL_DATUM_INIT(qbank_editor, /datum/quest_bank_editor, new)

#define QBSOUNDTYPE_DIRECT 0
#define QBSOUNDTYPE_INWORLD 1

/// The admin tool what makes the quest bank go b
/// cus doing it by
/datum/quest_bank_editor
	/// why spawn one of these for everyone when I can just spawn one and then store everyone's options in a list, Dan you are a genius!
	var/list/saved_options = list()
	var/list/sound_key_list = list(
		"SILENT" = FALSE,
		"DWOOP" = 'sound/machines/dwoop.ogg',
		"TWO-BEEP" = 'sound/machines/twobeep.ogg',
		"TWO-BEEP-HIGH" = 'sound/machines/twobeep_high.ogg',
		"PDA" = 'modular_coyote/sound/pipsounds/beepboop.ogg',
		"QUEST-COMPLETE" = 'sound/effects/quest_complete.ogg',
		"BWEEBWEE" = 'sound/effects/bweebweebwaa.ogg',
		"DIABLO-COINS" = 'sound/effects/goldcoins.ogg',
	)
	var/list/message_styles = list(
		"RED",
		"GREEN",
		"BLUE",
		"PRIORITY",
		"PRIORITY-CENTERED",
		"HYPNOPHRASE",
		// "PDA-MESSAGE",
	)
	var/list/to_save = list()

/datum/quest_bank_editor/New()
	. = ..()
	START_PROCESSING(SSprocessing, src)

/datum/quest_bank_editor/proc/Open(someone)
	var/client/pussy = extract_mob(someone)
	if(!pussy)
		return
	if(!check_rights(R_ADMIN, 0))
		log_admin("Some pussy tried to open the quest bank editor without permission")
		return
	var/list/dat = list()
	dat += "<center><a href='byond://?src=[REF(src)];Options=1'>\[OPTIONS\]</a> "
	dat += "<a href='byond://?src=[REF(src)];Refresh=1'>\[REFRESH\]</a></center>"
	dat += "<hr>"
	dat += "<h1>HI! I'M THE QUEST BANK EDITOR!</h1> "
	dat += "<br>Here you can edit the Quest Bank of anyone currently connected to the server and spawned in!</br>"
	dat += "<br>Currently only works on people who are currently connected to the server and have already spawned in at least once, so if they disconnect, vore em. =3</br>"
	dat += "<br>Also currently only lets you edit the cash in their bank, but more features are coming soon =3</br>"
	dat += "<br>You can also set options for what sound and message to be sent to them when you adjust their bank! This way you can have the adjustments be flavored as coming from in-world if you want. Or not!</br>"
	dat += "<br>You can set a default notification for all players, and/or set a notification for a specific player. </br>"
	dat += "<br>With love, Dan 'Superlagg' Kelly <3</br>"
	/// the actual editor
	dat += "<b>Quest Bank Editor</b>"
	dat += "<hr>"
	var/list/pussys = list()
	for(var/quid in SSeconomy.quest_books)
		var/datum/quest_book/QB = LAZYACCESS(SSeconomy.quest_books, quid)
		var/msg = "<center><div style='margin:5px; padding:5px; border:1px solid black; border-radius:5px;'>"
		msg += "<span style='font-size:0.8em;'>[QB.q_uid]</span>"
		var/list/their_options = GetOptionsFor(pussy, QB.q_uid)
		msg += "<br><b>[QB.ownername] ([QB.ownerjob])</b> "
		var/mob/owner = SSeconomy.quid2mob(QB.q_uid)
		var/should_work = owner && owner.client && !QB.virgin && !QB.double_virgin
		var/whynot = ""
		if(!owner)
			whynot = "Disconnected!"
		else if(QB.virgin || QB.double_virgin)
			whynot = "Not spawned in yet!"
		if(should_work)
			msg += "<span style='font-size:0.8em; color:green;'>Should work! =3</span>"
		else
			msg += "<span style='font-size:0.8em; color:red;'>[whynot] Probably WONT work!</span>"
		msg += "<br>Banked: "
		if(should_work)
			msg += "<a href='byond://?src=[REF(src)];EditQbank=1;WhoFor=[QB.q_uid]'>"
		msg += "[SSeconomy.format_currency(QB.unclaimed_points, TRUE, TRUE)]"
		if(should_work)
			msg += " \[EDIT\]</a>"
		msg += "<br><a href='byond://?src=[REF(src)];"
		msg += "ToggleNotify=1;WhoFor=[QB.q_uid]'>[their_options["Notify"] ? "\[WILL NOTIFY\]" : "\[WILL NOT NOTIFY\]"]</a> "
		msg += "<a href='byond://?src=[REF(src)];"
		msg += "Options=1;WhoFor=[QB.q_uid]'>\[PERSONALIZE\]</a> "
		msg += "<a href='byond://?src=[REF(src)];"
		msg += "ToggleUsingCustomOptions=1;WhoFor=[QB.q_uid]'>"
		if(their_options["CustomOptions"])
			msg += "<span style='color:green;'>[span_alert("\[USING PERSONALIZED OPTIONS\]")]</span>"
		else
			msg += "<span style='color:blue;'>[span_alert("\[USING DEFAULT OPTIONS\]")]</span>"
		msg += "</a>"
		msg += "</div><br></center>"
		pussys += msg
	dat += pussys.Join()
	dat += "<center><a href='byond://?src=[REF(src)];Options=1'>\[OPTIONS\]</a> "
	dat += "<a href='byond://?src=[REF(src)];Refresh=1'>\[REFRESH\]</a></center>"
	SetCurrentMenu(pussy, "Main")
	/// the browser
	winset(pussy, "qbank_editor", "is-visible=1;focus=0;")
	var/datum/browser/popup = new(pussy, "qbank_browser", "<div align='center'>Quest Bank Editor</div>", 600, 700)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(pussy, "qbank_editor", src)

/datum/quest_bank_editor/proc/OptionsMenu(mob/user, whofor)
	var/list/myoptions = GetOptionsFor(user, whofor)
	var/list/dat = list()
	dat += "<center><a href='byond://?src=[REF(src)];Main=1'>\[MAIN\]</a> "
	if(whofor && whofor != "Default")
		dat += "<a href='byond://?src=[REF(src)];Options=1'>\[BACK\]</a>"
	dat += "<a href='byond://?src=[REF(src)];Refresh=1'>\[REFRESH\]</a></center>"
	dat += "<hr>"
	dat += "<h1>Quest Bank Editor Options</h1>"
	dat += "<hr>"
	if(whofor && whofor != "Default")
		var/mob/who_its_for = SSeconomy.quid2mob(whofor)
		if(who_its_for)
			dat += "<h3>Options for [who_its_for.real_name] ([who_its_for.ckey])</h3>"
		else
			var/datum/quest_book/QB = LAZYACCESS(SSeconomy.quest_books, whofor)
			if(QB)
				dat += "<h3>Options for [QB.ownername] ([QB.ownerjob])</h3>"
			else
				dat += "<h3>Options for someone maybe?</h3>"
		dat += "<b>[whofor]</b>"
		dat += "<a href='byond://?src=[REF(src)];ToggleUsingCustomOptions=1;WhoFor=[whofor]'>"
		if(myoptions["CustomOptions"])
			dat += "<span style='color:green;'>[span_alert("WILL USE THESE CUSTOM OPTIONS")]</span>"
		else
			dat += "<span style='color:red;'>[span_alert("WILL USE DEFAULT OPTIONS")]</span>"
	else
		dat += "<h3>Default Options</h3>"
	dat += "</a>"
	/// toggle letting them know that you adjusted it
	dat += "<p><b>Notify Player : </b>"
	dat += "<a href='byond://?src=[REF(src)];ToggleNotify=1;WhoFor=[whofor]'>"
	if(myoptions["Notify"])
		dat += "<span style='color:green;'>[span_alert("ON")]</span>"
	else
		dat += "<span style='color:red;'>[span_alert("OFF")]</span>"
	dat += "</a>"
	dat += "<br>Toggle whether or not they will get a notification when you adjust their's bank!"
	/// Change what sound to play when you adjust it
	dat += "<p><b>Notification Sound : </b>"
	dat += "<a href='byond://?src=[REF(src)];ChangeSound=1;WhoFor=[whofor]'>"
	dat += "<span style='color:blue;'>[span_alert("[myoptions["Sound"]]")]</span>"
	dat += "</a>"
	dat += "<br>Change the sound that will play to them when you adjust their bank (if any)!"
	/// Change if it is just to the player, or a sound in-world
	dat += "<p><b>Sound Type : </b>"
	dat += "<a href='byond://?src=[REF(src)];ChangeSoundType=1;WhoFor=[whofor]'>"
	if(myoptions["SoundType"] == QBSOUNDTYPE_DIRECT)
		dat += "<span style='color:green;'>[span_alert("DIRECT")]</span>"
	else
		dat += "<span style='color:red;'>[span_alert("NORMAL")]</span>"
	dat += "</a>"
	dat += "<br>Toggle whether or not the sound will play directly to the player, or in-world!"
	/// Change the message that will be sent to them
	dat += "<p><b>Notification Message : </b><br>"
	dat += "<a href='byond://?src=[REF(src)];ChangeMessage=1;WhoFor=[whofor]'>"
	dat += "<span style='color:blue;'>[span_alert("[myoptions["Message"]]")]</span>"
	dat += "</a>"
	dat += "<br>Change the message that will be sent to them when you adjust their bank (if any)!"
	/// Change the message style
	dat += "<p><b>Notification Message Style : </b>"
	dat += "<a href='byond://?src=[REF(src)];ChangeMessageStyle=1;WhoFor=[whofor]'>"
	dat += "<span style='color:blue;'>[span_alert("[myoptions["MessageStyle"]]")]</span>"
	dat += "</a>"
	dat += "<br>Change the style of the message that will be sent to them when you adjust their bank (if any)!"
	dat += "<hr>"
	dat += "<br>With love, Dan 'Superlagg' Kelly <3</br>"
	dat += "<center><a href='byond://?src=[REF(src)];Main=1'>\[MAIN\]</a> "
	if(whofor && whofor != "Default")
		dat += "<a href='byond://?src=[REF(src)];Options=1'>\[BACK\]</a>"
	dat += "<a href='byond://?src=[REF(src)];Refresh=1'>\[REFRESH\]</a> "
	dat += "<br><a href='byond://?src=[REF(src)];Reset=1;WhoFor=[whofor]'>\[RESET\]</a></center>"
	SetCurrentMenu(user, "Options", whofor)
	winset(user, "qbank_editor", "is-visible=1;focus=0;")
	var/datum/browser/popup = new(user, "qbank_browser", "<div align='center'>Quest Bank Editor Options</div>", 600, 700)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "qbank_editor", src)

/datum/quest_bank_editor/proc/SetCurrentMenu(mob/user, menu, whofor)
	var/client/pussy = extract_client(user)
	if(!pussy)
		return
	var/list/myoptions = GetOptionsFor(user)
	myoptions["CurrentMenu"] = menu
	if(myoptions["CurrentMenu"] == "Main")
		myoptions["CurrentWhoFor"] = "Default"
	if(whofor)
		myoptions["CurrentWhoFor"] = whofor
	else
		myoptions["CurrentWhoFor"] = "Default"
	SaveOptions(user, "Default", myoptions)

/datum/quest_bank_editor/proc/Refresh(mob/user)
	var/list/myoptions = GetOptionsFor(user)
	if(myoptions["CurrentMenu"] == "Options")
		OptionsMenu(user, myoptions["CurrentWhoFor"])
	else
		Open(user)

/datum/quest_bank_editor/proc/ToggleNotify(mob/user, edit_for)
	var/list/myoptions = GetOptionsFor(user, edit_for)
	if(myoptions["Notify"])
		myoptions["Notify"] = FALSE
	else
		myoptions["Notify"] = TRUE
	to_chat(user, span_notice("You will now [myoptions["Notify"] ? "notify" : "not notify"] whoever you changed the bank values of!!"))
	SaveOptions(user, edit_for, myoptions, TRUE)
	Refresh(user)

/datum/quest_bank_editor/proc/ChangeSound(mob/user, edit_for)
	var/myoptions = GetOptionsFor(user, edit_for)
	var/newoption = input(
		user,
		"What sound would you like to play when you adjust their bank?",
		"Sound",
		"[myoptions["Sound"]]",
	) as null|anything in sound_key_list
	if(isnull(newoption))
		to_chat(user, span_notice("Nevermind!!"))
		return
	myoptions["Sound"] = newoption
	to_chat(user, span_notice("You will now play [newoption] when you adjust their bank!"))
	SendSound(user, myoptions, TRUE)
	SaveOptions(user, edit_for, myoptions, TRUE)
	Refresh(user)

/datum/quest_bank_editor/proc/ChangeSoundType(mob/user, edit_for)
	var/myoptions = GetOptionsFor(user, edit_for)
	if(myoptions["SoundType"] == QBSOUNDTYPE_INWORLD)
		myoptions["SoundType"] = QBSOUNDTYPE_DIRECT
	else
		myoptions["SoundType"] = QBSOUNDTYPE_INWORLD
	to_chat(user, span_notice("You will now play the sound [myoptions["SoundType"] == QBSOUNDTYPE_DIRECT ? "directly to the player" : "in-world"] when you adjust their bank!"))
	SendSound(user, myoptions, TRUE)
	SaveOptions(user, edit_for, myoptions, TRUE)
	Refresh(user)

/datum/quest_bank_editor/proc/ChangeMessage(mob/user, edit_for)
	var/myoptions = GetOptionsFor(user, edit_for)
	var/newoption = input(
		user,
		"What message would you like to send when you adjust their bank?\n\
		TOKENS!\n\
		:: - everything to the left of :: will be the sender, and everything to the right to be the message!\n\
		$S$ - Cash change (short): 30[SSeconomy.currency_unit]\n\
		$F$ - Cash change (full): 30 [SSeconomy.currency_name]\n\
		$+-$ - Credited (if cash change is positive) or Deducted (if negative)\n\
		$tofrom$ - To (if cash change is positive) or From (if negative)\n\
		$FIN$ - Their final balance after change\n\
		Your mum :: $S$ has been $+-$ $tofrom$ your QBank account! You now have $FIN$! becomes....\n\
		Your mum: 30[SSeconomy.currency_unit] has been credited to your QBank account! You now have 30[SSeconomy.currency_unit]!",
		"Message",
		"[myoptions["Message"]]",
	) as null|message
	if(isnull(newoption))
		to_chat(user, span_notice("Nevermind!!"))
		return
	myoptions["Message"] = newoption
	to_chat(user, span_notice("You will now send this message when you change their bank!:"))
	SendChat(user, myoptions)
	SaveOptions(user, edit_for, myoptions, TRUE)
	Refresh(user)

/datum/quest_bank_editor/proc/ChangeMessageStyle(mob/user, edit_for)
	var/myoptions = GetOptionsFor(user, edit_for)
	var/newoption = input(
		user,
		"What style would you like to send the message in?",
		"MessageStyle",
		"[myoptions["MessageStyle"]]",
	) as null|anything in message_styles
	if(isnull(newoption))
		to_chat(user, span_notice("Nevermind!!"))
		return
	myoptions["MessageStyle"] = newoption
	to_chat(user, span_notice("You will now send the message in [newoption] style when you change their bank! It will look like this:"))
	SendChat(user, myoptions)
	SaveOptions(user, edit_for, myoptions, TRUE)
	Refresh(user)

/datum/quest_bank_editor/proc/ToggleUseCustomOptions(mob/user, edit_for)
	var/myoptions = GetOptionsFor(user, edit_for)
	if(myoptions["CustomOptions"])
		myoptions["CustomOptions"] = FALSE
	else
		myoptions["CustomOptions"] = TRUE
	to_chat(user, span_notice("You will now [myoptions["CustomOptions"] ? "use" : "not use"] custom options for whoever you changed the bank values of!!"))
	SaveOptions(user, edit_for, myoptions)
	Refresh(user)

/datum/quest_bank_editor/proc/DefaultOptions()
	return list(
		"Notify" = TRUE,
		"Sound" = "DWOOP",
		"SoundType" = QBSOUNDTYPE_DIRECT,
		"Message" = "Sharon Adventurer's Guild :: $L$ has been $+-$ $tofrom$ your QBank account! You now have $FIN$!",
		"MessageStyle" = "PRIORITY",
		"CustomOptions" = FALSE,
	)

/datum/quest_bank_editor/proc/LoadSavedOptionsFromPrefsIfPossible(mob/user)
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return
	if(!LAZYLEN(P.quest_bank_editor_prefs))
		return // sweet un touched cinnamon bun~
	if(!islist(saved_options[user.ckey]))
		saved_options[user.ckey] = list()
	saved_options[user.ckey] = P.quest_bank_editor_prefs.Copy()

/datum/quest_bank_editor/proc/SaveOptionsToPrefs(mob/user)
	var/datum/preferences/P = extract_prefs(user)
	if(!P)
		return
	var/list/myoptions = saved_options[user.ckey]
	P.quest_bank_editor_prefs = myoptions.Copy()
	QueueSave(user.ckey)

/datum/quest_bank_editor/proc/GetOptionsFor(mob/user, edit_for, default_to_default)
	LoadSavedOptionsFromPrefsIfPossible(user)
	if(!edit_for)
		edit_for = "Default"
	if(!islist(saved_options[user.ckey]))
		saved_options[user.ckey] = list()
		saved_options[user.ckey]["Default"] = DefaultOptions()
	if(!islist(saved_options[user.ckey][edit_for]))
		saved_options[user.ckey][edit_for] = DefaultOptions()
	if(default_to_default)
		var/list/myoptions = saved_options[user.ckey][edit_for]
		if(myoptions["CustomOptions"])
			return myoptions
		else
			return saved_options[user.ckey]["Default"]
	return saved_options[user.ckey][edit_for]

/datum/quest_bank_editor/proc/SaveOptions(mob/user, edit_for, list/options, set_custom)
	if(!edit_for)
		edit_for = "Default"
	if(!islist(saved_options[user.ckey]))
		saved_options[user.ckey] = list()
		saved_options[user.ckey]["Default"] = DefaultOptions()
	if(!islist(saved_options[user.ckey][edit_for]))
		saved_options[user.ckey][edit_for] = DefaultOptions()
	if(edit_for != "Default" && set_custom)
		options["CustomOptions"] = TRUE
	var/dosave = LAZYLEN(saved_options[user.ckey][edit_for] ^ options)
	saved_options[user.ckey][edit_for] = options.Copy()
	if(dosave)
		SaveOptionsToPrefs(user)

/datum/quest_bank_editor/proc/EditQbank(mob/user, datum/quest_book/QB)
	if(!user || !QB)
		return
	if(!check_rights(R_ADMIN, 0))
		log_admin("Some pussy tried to open the quest bank editor without permission")
		return
	var/new_balance = input(
		user,
		"Give/Take how much money to/from [QB.ownername] ([QB.ownerjob])?\n\
		Enter a number, positive to give, negative to take.\n\
		Their current balance: [CREDITS_TO_COINS(QB.unclaimed_points)] [SSeconomy.currency_name_plural]",
		"Credit or Debt",
		"[CREDITS_TO_COINS(QB.unclaimed_points)]",
	) as null|num // why did I make questmoney be internally credits, and functionally coins? 
	if(isnull(new_balance)) // oh yeah its cus this whole thing is a grotesque mutant of TG's bounty system
		to_chat(user, span_notice("Nevermind!!")) // Still think I came out ahead
		return
	new_balance = COINS_TO_CREDITS(floor(new_balance)) // 12 -> 120, 12.134 -> 121 
	// if(new_balance < 0)
	// 	to_chat(user, span_alert("You can't set the balance to less than 0!"))
	// 	return
	if(new_balance >= 1000000000)
		to_chat(user, span_alert("You can't set the balance to more than 1,000,000,000!"))
		return
	/// now we need to convert this absolute value to a relative value, so we can use the native adjust_funds function
	// var/list/myoptions = GetOptionsFor(user, QB.q_uid)
	NotifyUser(QB.q_uid, user, new_balance)
	QB.adjust_funds(new_balance, null, TRUE)
	to_chat(user, span_notice("You have adjusted [QB.ownername]'s ([QB.ownerjob]) balance by [SSeconomy.format_currency(new_balance, TRUE)]]!"))
	to_chat(user, span_notice("They now have [SSeconomy.format_currency(QB.unclaimed_points, TRUE)]!"))
	Refresh(user)

/datum/quest_bank_editor/proc/NotifyUser(quid_to_notify, mob/user, cash_change)
	/// first, find the options to use for em!
	var/myoptions = GetOptionsFor(user, quid_to_notify, TRUE)
	if(!myoptions["Notify"])
		return
	var/mob/them = SSeconomy.quid2mob(quid_to_notify)
	SendSound(them, myoptions)
	SendChat(them, myoptions, cash_change)
	to_chat(them, span_notice("Your QBank account have been adjusted by [SSeconomy.format_currency(cash_change, TRUE)]!"))
	to_chat(user, span_notice("You have notified [them] of the change!"))
	return TRUE

/datum/quest_bank_editor/proc/SendSound(mob/them, list/inputoptions, selfonly)
	if(!them || !LAZYLEN(inputoptions))
		return
	var/snd = sound_key_list[inputoptions["Sound"]]
	if(!snd || inputoptions["Sound"] == "SILENT" || snd == "SILENT" || snd == "")
		return
	var/kind = inputoptions["SoundType"]
	if(kind == QBSOUNDTYPE_DIRECT || selfonly)
		them.playsound_local(them, snd, 80, TRUE)
	else
		playsound(them, snd, 80, TRUE)
	return TRUE

/datum/quest_bank_editor/proc/SendChat(mob/them, list/inputoptions, cash_change)
	if(!them || !LAZYLEN(inputoptions))
		return
	var/msg = inputoptions["Message"]
	var/style = inputoptions["MessageStyle"]
	/// if its not a priority message, and there is a :: in the message, we need to split it up
	if(style != "PRIORITY" && style != "PRIORITY-CENTERED")
		var/checktest = splittext(msg, "::")
		if(LAZYLEN(checktest) == 2)
			msg = checktest[2]
			/// and, just so this feature isnt wasted on non-priority, lets use the first part as the sender
			msg = "<b>[checktest[1]]</b>: " + msg
	msg = replacetext(msg, "$S$", SSeconomy.format_currency(cash_change, TRUE))
	msg = replacetext(msg, "$L$", SSeconomy.format_currency(cash_change, TRUE, TRUE))
	msg = replacetext(msg, "$+-$", cash_change >= 0 ? "credited" : "deducted")
	var/datum/quest_book/QB = SSeconomy.get_quest_book(them)
	var/newbank = QB ? max(QB.unclaimed_points + cash_change, 0) : "ERROR"
	msg = replacetext(msg, "$FIN$", SSeconomy.format_currency(newbank, TRUE, TRUE))
	msg = replacetext(msg, "$tofrom$", cash_change >= 0 ? "to" : "from")
	/// now we need to switch the style
	switch(style)
		if("RED")
			msg = span_alert(msg)
		if("GREEN")
			msg = span_green(msg)
		if("BLUE")
			msg = span_notice(msg)
		if("PRIORITY")
			msg = BuildPriorityMessage(msg)
		if("PRIORITY-CENTERED")
			msg = BuildPriorityMessage(msg, TRUE)
		if("HYPNOPHRASE")
			msg = span_hypnophrase(msg)
		// if("PDA-MESSAGE") // todo: this
		// 	SendPDA(them, msg)
	to_chat(them, msg)
	return TRUE

/datum/quest_bank_editor/proc/BuildPriorityMessage(message, slashes)
	var/head = "Adventurer's Guild Message"
	var/list/checktest = splittext(message, "::")
	if(LAZYLEN(checktest) > 1)
		head = checktest[1]
		message = checktest[2]
	head = "<h1 class='alert'>[head]</h1>"
	var/str = "<div style='border:1px solid white; padding:5px; border-radius:5px;'>"
	if(slashes)
		str += "<center>"
	str += head
	str += "<br>"
	str += message
	str += "<br>"
	if(slashes)
		str += "</center>"
	str += "</div>"
	return str

/datum/quest_bank_editor/proc/QueueSave(ckey)
	to_save[ckey] = world.time + 5 SECONDS

/datum/quest_bank_editor/process()
	for(var/ckey in to_save)
		if(world.time > to_save[ckey])
			var/datum/preferences/P = extract_prefs(ckey)
			if(P)
				var/list/tosave = saved_options[ckey]
				P.quest_bank_editor_prefs = tosave.Copy()
				P.save_preferences()
				to_chat(P.parent, span_green("Your Quest Bank Editor options have been saved!"))
			to_save -= ckey

/datum/quest_bank_editor/Topic(href, list/href_list)
	. = ..()
	var/mob/user = usr // bite me
	if(href_list["Options"])
		. = TRUE
		OptionsMenu(user, href_list["WhoFor"])
	if(href_list["Main"])
		. = TRUE
		Open(user)
	if(href_list["Refresh"])
		. = TRUE
		Refresh(user)
	if(href_list["Reset"])
		SaveOptions(user, href_list["WhoFor"], DefaultOptions())
		OptionsMenu(user, href_list["WhoFor"])
	if(href_list["EditQbank"]) // the actual editor
		. = TRUE
		var/datum/quest_book/QB = LAZYACCESS(SSeconomy.quest_books, href_list["WhoFor"])
		if(QB)
			EditQbank(user, QB)
	if(href_list["ToggleNotify"])
		. = TRUE
		ToggleNotify(user, href_list["WhoFor"])
	if(href_list["ChangeSound"])
		. = TRUE
		ChangeSound(user, href_list["WhoFor"])
	if(href_list["ChangeSoundType"])
		. = TRUE
		ChangeSoundType(user, href_list["WhoFor"])
	if(href_list["ChangeMessage"])
		. = TRUE
		ChangeMessage(user, href_list["WhoFor"])
	if(href_list["ChangeMessageStyle"])
		. = TRUE
		ChangeMessageStyle(user, href_list["WhoFor"])
	if(href_list["ToggleUsingCustomOptions"])
		. = TRUE
		ToggleUseCustomOptions(user, href_list["WhoFor"])
	if(.)
		Refresh(user)

