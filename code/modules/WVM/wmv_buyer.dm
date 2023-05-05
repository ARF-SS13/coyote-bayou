GLOBAL_LIST_EMPTY(wasteland_vendor_shop_list)

#define WVM_SCRAPPER "wasteland_trader"

/obj/machinery/mineral/wasteland_trader
	name = "Workshop Scrapper"
	desc = "A vending machine that's been modified to accept various items in exchange for caps. \
			A sign on it reads, 'Keep your workplace clean and get paid doing it!' \
			It's better than a trash can, at least."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "trade_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  // Once this is readded to the map, I need to do some testing regarding gunpowder. See if I can't bully the commie reloading bench to death.
	var/trader_key = WVM_SCRAPPER

	/// List of things it buys, and allows any of its children into the buy list
	var/list/buyables_loose = list(
		/obj/item/stack/sheet/metal = 0.4,
		/obj/item/stack/sheet/mineral/titanium = 0.8,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/stack/sheet/cloth = 1,
		/obj/item/stack/ore/blackpowder = 1,
		/obj/item/stack/sheet/prewar = 2,
		/obj/item/stack/sheet/leather = 1,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/stack/sheet/mineral/plastitanium = 3,
		/obj/item/reagent_containers/hypospray = 1,
		/obj/item/reagent_containers/hypospray/medipen/medx = 3,
		/obj/item/reagent_containers/hypospray/medipen/steady = 3,
		/obj/item/reagent_containers/pill/patch/jet =3,
		/obj/item/reagent_containers/pill/patch/turbo =3,
		/obj/item/storage/pill_bottle/chem_tin/mentats = 3,
		/obj/item/storage/pill_bottle/chem_tin/buffout = 3,
		/obj/item/reagent_containers/pill/stimulant = 3,
		/obj/item/storage/pill_bottle/chem_tin/radx = 3,
		/obj/item/reagent_containers/pill/antivenom = 3,
		/obj/item/reagent_containers/pill = 1,
		/obj/item/grown/cotton = 1,
		/obj/item/grown/sunflower = 1,
		/obj/item/reagent_containers/food = 1,
		/obj/item/grown/log = 1,
		/obj/item/advanced_crafting_components = 15,
		/obj/item/stealthboy = 100,
		/obj/item/blueprint/research = 25,
		// pistols/revolvers, 5 caps
		/obj/item/gun/ballistic/revolver = 5,
		/obj/item/gun/ballistic/automatic/pistol = 5,
		// shotguns/rifles, 10 caps
		/obj/item/gun/ballistic/revolver/m2405 = 10,
		/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
		/obj/item/gun/ballistic/revolver/widowmaker = 10,
		/obj/item/gun/ballistic/shotgun = 10,
		/obj/item/gun/ballistic/automatic/shotgun = 10,
		/obj/item/gun/ballistic/rifle = 10,
		// full auto smgs/rifles, 15 caps
		/obj/item/gun/ballistic/automatic = 5,
		/obj/item/gun/ballistic/automatic/smg = 15,
		/obj/item/gun/ballistic/automatic/m1carbine = 15,
		/obj/item/gun/ballistic/automatic/delisle = 15,
		/obj/item/gun/ballistic/automatic/combat = 15,
		/obj/item/gun/ballistic/automatic/sportcarbine = 15,
		/obj/item/gun/ballistic/automatic/varmint = 15,
		/obj/item/gun/ballistic/automatic/service = 15,
		/obj/item/gun/ballistic/automatic/marksman = 15,
		/obj/item/gun/ballistic/automatic/rangemaster = 15,
		/obj/item/gun/ballistic/automatic/slr = 15,
		/obj/item/gun/ballistic/automatic/m1garand = 15,
		/obj/item/gun/ballistic/automatic/assault_rifle = 15,
		/obj/item/gun/ballistic/automatic/r93 = 15,
		/obj/item/gun/ballistic/automatic/type93 = 15,
		/obj/item/gun/ballistic/automatic/bozar = 15,
		/obj/item/gun/ballistic/automatic/assault_carbine = 15,
		/obj/item/gun/ballistic/automatic/fnfal = 15,
		/obj/item/gun/ballistic/automatic/armalite = 15,
		/obj/item/gun/ballistic/automatic/l1a1 = 15,
		/obj/item/gun/ballistic/automatic/bar = 15,
		/obj/item/gun/ballistic/automatic/g11 = 15,
		/obj/item/gun/ballistic/automatic/wt550 = 15,
		/obj/item/gun/ballistic/automatic/r84 = 15,
		/obj/item/gun/ballistic/automatic/lsw = 15,
		/obj/item/gun/ballistic/automatic/lewis = 15,
		/obj/item/gun/ballistic/automatic/bren = 15,
		/obj/item/gun/ballistic/automatic/m1919 = 15,
		/obj/item/gun/ballistic/automatic/m72 = 15,
		/obj/item/gun/ballistic/automatic/xl70e3 = 15,
	)
	/// List of things it buys, but does NOT allow any of its children into the buy list
	var/list/buyables_tight = list(
		/obj/item/stack/sheet/animalhide/chitin = 1,
		/obj/item/stack/sheet/animalhide/deathclaw = 25,
		/obj/item/stack/sheet/animalhide/gecko = 2,
		/obj/item/stack/sheet/animalhide/molerat = 2,
		/obj/item/stack/sheet/animalhide/wolf = 5,
		/obj/item/stack/sheet/animalhide/radstag = 5,
		/obj/item/stack/sheet/animalhide/brahmin = 5,
		/obj/item/reagent_containers/food/snacks/meat/slab/deathclaw = 15,
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/wolf = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat = 5,
		/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 3,
		/obj/item/stock_parts/capacitor/adv = 3,
		/obj/item/stock_parts/scanning_module/adv = 3,
		/obj/item/stock_parts/manipulator/nano = 3,
		/obj/item/stock_parts/micro_laser/high = 3,
		/obj/item/stock_parts/matter_bin/adv = 3,
		/obj/item/stock_parts/cell/super = 3,
		/obj/item/stock_parts/capacitor/super = 6,
		/obj/item/stock_parts/scanning_module/phasic = 6,
		/obj/item/stock_parts/manipulator/pico = 6,
		/obj/item/stock_parts/micro_laser/ultra = 6,
		/obj/item/stock_parts/matter_bin/super = 6,
		/obj/item/stock_parts/cell/hyper = 6,
		/obj/item/stock_parts/capacitor/quadratic = 10,
		/obj/item/stock_parts/scanning_module/triphasic = 10,
		/obj/item/stock_parts/manipulator/femto = 10,
		/obj/item/stock_parts/micro_laser/quadultra = 10,
		/obj/item/stock_parts/matter_bin/bluespace = 10,
		/obj/item/stock_parts/cell/bluespace = 10,
		/obj/item/crowbar/power = 20,
		/obj/item/screwdriver/power = 20,
		/obj/item/weldingtool/experimental = 15,
		/obj/item/weldingtool/advanced = 20,
		/obj/item/crowbar/hightech = 10,
		/obj/item/screwdriver/hightech = 10,
		/obj/item/wrench/hightech = 10,
		/obj/item/wirecutters/hightech = 10,
		/obj/item/multitool/advanced = 20,
		/obj/item/scalpel/advanced = 20,
		/obj/item/surgicaldrill/advanced = 20,
		/obj/item/retractor/advanced = 20,
		/obj/item/cautery/alien = 10,
		/obj/item/surgicaldrill/alien = 10,
		/obj/item/circular_saw/alien = 10,
		/obj/item/retractor/alien = 10,
		/obj/item/hemostat/alien = 10,
		/obj/item/scalpel/alien = 10,
		/obj/item/export/bottle/gin = 8,
		/obj/item/export/bottle/whiskey = 8,
		/obj/item/export/bottle/wine = 8,
		/obj/item/export/bottle/vodka = 8,
		/obj/item/export/bottle/rum = 8,
		/obj/item/export/bottle/tequila = 8,
		/obj/item/export/bottle/minikeg = 8,
		/obj/item/export/bottle/applejack = 8,
		/obj/item/export/bottle/cognac = 8,
		/obj/item/export/bottle/sake = 8,
		/obj/item/export/bottle/hcider = 8,
		/obj/item/export/bottle/vermouth = 8,
		/obj/item/export/bottle/absinthe = 8,
		/obj/item/export/bottle/grappa = 8,
		/obj/item/export/bottle/fernet = 8,
		/obj/item/export/bottle/kahlua = 8,
		/obj/item/export/bottle/champagne = 15,
		/obj/item/export/bottle/blazaam = 15,
		/obj/item/export/bottle/nukashine = 15,
		/obj/item/export/bottle/trappist = 15,
		/obj/item/export/bottle/goldschlager = 15,
		/obj/item/export/bottle/patron = 15,
	)
	var/list/goods_list = list()
	var/list/quicklisted = list()
	var/is_grinding = FALSE
	var/sales_timer
	var/datum/progressbar/stored/my_bar
	var/start_time = 0
	var/end_time = 0
	var/datum/looping_sound/grinding_noises/soundloop
	var/last_appraised

/obj/machinery/mineral/wasteland_trader/general
	name = "Trading point"
	icon_state = "generic_idle"
	prize_list = list()

/obj/machinery/mineral/wasteland_trader/Initialize(mapload)
	. = ..()
	setup_prices()
	soundloop = new(list(src), FALSE)

/obj/machinery/mineral/wasteland_trader/Destroy()
	eject()
	QDEL_NULL(soundloop)
	if(sales_timer)
		deltimer(sales_timer)
	. = ..()

/obj/machinery/mineral/wasteland_trader/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/sellbox)

/datum/component/storage/concrete/sellbox
	storage_flags = STORAGE_FLAGS_VOLUME_DEFAULT // space limited, only
	max_w_class = WEIGHT_CLASS_GIGANTIC
	max_combined_w_class = WEIGHT_CLASS_GIGANTIC * 10
	max_volume = WEIGHT_CLASS_GIGANTIC * 3
	rustle_sound = TRUE
	number_of_rows = 3

/obj/machinery/mineral/wasteland_trader/proc/setup_prices()
	if(GLOB.wasteland_vendor_shop_list[trader_key])
		return // All done!
	GLOB.wasteland_vendor_shop_list[trader_key] = list()
	var/list/donut = list()
	/// so parents are processed first, and subtype prices have priority
	var/list/buylist = sortList(buyables_loose, /proc/cmp_typepaths_length_asc)
	for(var/stuff in buylist)
		var/list/cumfrosting = list()
		cumfrosting = typecacheof(stuff)
		cumfrosting = counterlist_scale(cumfrosting, buylist[stuff])
		for(var/thing in cumfrosting)
			donut[thing] = cumfrosting[thing]
	/// now, prune and process the tight list
	buylist.Cut()
	buylist = sortList(buyables_tight, /proc/cmp_typepaths_length_asc)
	for(var/stuff in buylist)
		var/list/cumfrosting = list()
		cumfrosting = typecacheof(stuff, TRUE)
		/// remove any entries that are in the tight list that would get deleted when we prune
		for(var/thing in cumfrosting)
			if(thing == stuff)
				cumfrosting -= thing
		donut -= cumfrosting
		donut[stuff] = buylist[stuff]

	for(var/thing in donut)
		GLOB.wasteland_vendor_shop_list[trader_key][thing] = donut[thing]

/obj/machinery/mineral/wasteland_trader/examine(mob/user)
	. = ..()
	. += span_notice("To use, insert items you want to sell, and then press the big CONFIRM SALE button. This will destroy the items and give you caps.")
	. += span_notice("ALT-click this machine to open its internal sales-hopper.")
	. += span_notice("Click the item on the button inside the machine's inventory to see how much it's worth.")

/obj/machinery/mineral/wasteland_trader/proc/run_button()
	if(is_grinding)
		return "<b>SALE IN PROGRESS!</b> <A href='?src=[REF(src)];choice=abort'><u>Abort?</u></A><br>"
	else
		return "IDLE - <A href='?src=[REF(src)];choice=run'><u>Initiate Sale</u></A><br>"

/obj/machinery/mineral/wasteland_trader/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Metal: 0.4¢ per sheet<br>"
	dat += "Titanium: 0.8¢ per sheet<br>"
	dat += "Plasteel: 1¢ per sheet<br>"
	dat += "Plastitanium: 3¢ per sheet<br>"
	dat += "<br>"
	dat += "Salvaged Resources: 1 - 15¢<br>"
	dat += "Metal, Quality, Electronic Parts: 0¢<br>"
	dat += "Advanced Machine Parts: 3 - 10¢<br>"
	dat += "Advanced Tools: 10 - 20¢ <br>"
	dat += "Research Papers: 25¢<br>"
	dat += "Stealth Boy: 100¢<br>"
	dat += "<br>"
	dat += "Produce: 1 - 3¢<br>"
	dat += "Animal Parts: 1 - 25¢<br>"
	dat += "Sealed Alcohol: 8 - 15¢<br>"
	dat += "Stealth Boy: 100¢<br>"
	dat += "<br>"
	dat += "Handguns and Revolvers: 5¢<br>"
	dat += "Bolt Rifles and Shotguns: 10¢<br>"
	dat += "Automatics and Semiautomatics: 15¢<br>"
	dat += "Improvised Weapons: 0¢<br>"
	dat += "Energy Weapons: 0¢ (for now)<br>"
	dat += "Armor: 0¢ (for now)<br>"
	dat += "Power Armor: 0¢ (for now)<br>"
	dat += "Melee Weapons: 0¢ (for now)<br>"
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/Topic(href, href_list)
	if(..())
		return
	if(href_list["choice"] == "run")
		initiate_sale()
	if(href_list["choice"] == "abort")
		abort()
	if(href_list["choice"] == "eject")
		eject()
	if(href_list["purchase"])
		var/datum/data/wasteland_equipment/prize = locate(href_list["purchase"])
		if (!prize || !(prize in prize_list))
			to_chat(usr, span_warning("Error: Invalid choice!"))
			return
		if(prize.cost > stored_caps)
			to_chat(usr, span_warning("Error: Insufficent coinage value for [prize.equipment_name]!"))
		else
			stored_caps -= prize.cost
			GLOB.vendor_cash += prize.cost
			to_chat(usr, span_notice("[src] clanks to life briefly before vending [prize.equipment_name]!"))
			new prize.equipment_path(src.loc)
			SSblackbox.record_feedback("nested tally", "wasteland_equipment_bought", 1, list("[type]", "[prize.equipment_path]"))
	updateUsrDialog()
	return

/obj/machinery/mineral/wasteland_trader/attackby(obj/item/I, mob/user, params)
	if(user?.a_intent == INTENT_HARM)
		return ..()
	appraise_item(I)
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, I, user, FALSE)

/obj/machinery/mineral/wasteland_trader/proc/appraise_item(obj/item/I, looping)
	if(!I)
		return
	var/silent
	if("[I.type]" == last_appraised)
		silent = TRUE
	last_appraised = "[I.type]"
	if(!GLOB.wasteland_vendor_shop_list[trader_key][I.type])
		if(!looping)
			say("I'll give you absolutely nothing for \the [I]!", just_chat = silent)
		return FALSE
	var/final_price = GLOB.wasteland_vendor_shop_list[trader_key][I.type]
	if(!looping)
		say("I'll give you [final_price] copper per [I]!", just_chat = silent)
	return TRUE

/obj/machinery/mineral/wasteland_trader/proc/lock_belt(silent)
	var/was_locked = islocked()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, TRUE)
	playsound(get_turf(src), 'sound/effects/box_close.ogg', 20)
	if(!silent && !was_locked)
		var/turf/here = get_turf(src)
		here.audible_message(span_notice("[src] locks itself tight!"))

/obj/machinery/mineral/wasteland_trader/proc/unlock_belt(silent)
	var/was_locked = islocked()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SET_LOCKSTATE, FALSE)
	playsound(get_turf(src), 'sound/effects/box_open.ogg', 20)
	if(!silent && was_locked)
		var/turf/here = get_turf(src)
		here.audible_message(span_notice("[src] unlocks itself!"))

/obj/machinery/mineral/wasteland_trader/proc/islocked()
	return (SEND_SIGNAL(src, COMSIG_IS_STORAGE_LOCKED))

/obj/machinery/mineral/wasteland_trader/proc/eject()
	playsound(get_turf(src), 'sound/effects/clang.ogg', 20)
	return SEND_SIGNAL(src, COMSIG_TRY_STORAGE_QUICK_EMPTY)

/obj/machinery/mineral/wasteland_trader/proc/abort(hard)
	STOP_PROCESSING(SSfastprocess, src)
	unlock_belt()
	soundloop.stop()
	stop_progress_bar()
	playsound(src, 'sound/machines/ding.ogg', 90, 1)
	deltimer(sales_timer)
	is_grinding = FALSE
	if(hard)
		say("Whoa! Aborting sale!")

/obj/machinery/mineral/wasteland_trader/proc/initiate_sale()
	for(var/thingy in contents)
		if(istype(thingy, /obj/item/button))
			continue
		if(appraise_item(thingy, TRUE))
			INVOKE_ASYNC(src, .proc/sell_loop_start)
			return TRUE
	say("There's nothing to sell!")

/obj/machinery/mineral/wasteland_trader/proc/sell_loop_start(obj/item/I)
	is_grinding = TRUE
	var/obj/item/thing2sell
	if(I && (I in contents))
		thing2sell = I
	else
		thing2sell = get_thing_to_sell()
	if(!thing2sell)
		say("Nothing to sell!")
		abort()
		return
	var/final_price = GLOB.wasteland_vendor_shop_list[trader_key][thing2sell.type]
	if(!final_price)
		say("Nope, don't want that [thing2sell]!")
		yeet_thing(thing2sell)
		sell_loop_start()
		return
	if(istype(thing2sell, /obj/item/stack))
		var/obj/item/stack/S = thing2sell
		final_price = S.amount * final_price
	var/time2sell = final_price * 0.5 SECONDS
	say("Now processing [thing2sell]!", just_chat = TRUE)
	start_progress_bar(time2sell)
	soundloop.start()
	lock_belt()
	sales_timer = addtimer(CALLBACK(src, .proc/sell_loop_end, thing2sell), time2sell, TIMER_STOPPABLE)

/obj/machinery/mineral/wasteland_trader/proc/sell_loop_end(obj/item/I)
	if(!I)
		abort()
		return
	if(QDELETED(src))
		return
	if(I.loc != src || QDELETED(I))
		say("Hey, where'd my [I] go?")
		abort()
		return
	var/final_price = GLOB.wasteland_vendor_shop_list[trader_key][I.type]
	if(!final_price)
		say("Nope, don't want that [I]!")
		yeet_thing(I)
		sell_loop_start()
		return
	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_price = S.amount * final_price
	var/fractional = final_price - FLOOR(final_price, 1)
	if(fractional)
		payout_fractional(fractional)
	var/storedcaps = payout(final_price)
	say("Sold [I] for [final_price] caps, bringing the total to [storedcaps] copper!")
	playsound(get_turf(src), 'sound/effects/coins.ogg', 45)
	qdel(I)
	var/obj/item/next_thing = get_thing_to_sell()
	if(!next_thing)
		say("All done!")
		abort()
		return
	sell_loop_start(next_thing)

/obj/machinery/mineral/wasteland_trader/proc/yeet_thing(obj/item/yote)
	if(yote.loc != src)
		return
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, yote, get_turf(src), TRUE)
	var/atom/lucky_target
	var/list/throw_at_ables = list()
	for(var/mob/oops in view(7, src))
		throw_at_ables |= oops
	if(LAZYLEN(throw_at_ables))
		lucky_target = pick(throw_at_ables)
	else
		lucky_target = get_ranged_target_turf(src, pick(GLOB.alldirs), rand(1,5), 5)
	yote.throw_at(lucky_target, 20, 1, src)

/obj/machinery/mineral/wasteland_trader/proc/payout(caps)
	var/obj/item/stack/f13Cash/caps/C
	for(var/thingy in src)
		if(!istype(thingy, /obj/item/stack/f13Cash/caps))
			continue
		C = thingy
		break
	if(!C)
		C = new(src)
		C.amount = 0
	C.amount += caps
	C.update_icon()
	return C.amount

/obj/machinery/mineral/wasteland_trader/proc/payout_fractional(fractional)
	var/mob/whos_it_for
	for(var/mob/who in view(7, src))
		if(!whos_it_for)
			whos_it_for = who
			continue
		if(get_dist(get_turf(src), get_turf(who)) < get_dist(get_turf(src), get_turf(whos_it_for)))
			whos_it_for = who
	if(!whos_it_for)
		whos_it_for = pick(GLOB.human_list)
	if(!whos_it_for)
		return
	var/obj/item/paper/our_paper = new(src)
	if(!our_paper)
		return FALSE
	var/true_luck = rand(1, (fractional * 100))
	our_paper.name = "[whos_it_for.name]'s fortune"
	our_paper.info += "<br>"
	our_paper.info += write_contents(true_luck, whos_it_for.name)
	our_paper.update_icon_state()
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	return TRUE

/obj/machinery/mineral/wasteland_trader/proc/write_contents(luck, whofor)
	var/list/msg_out = list()
	msg_out += "<hr><br>"
	msg_out += "<center>- START REPORT -</center><br>"
	msg_out += "<center>- [span_small(uppertext(STATION_TIME_TIMESTAMP(FALSE, world.time)))] -</center><br>"
	msg_out += "<u><b>Commercial Depilinator Precognition Station</b></u><br>"
	msg_out += "[FOURSPACES][whofor]'s projected destiny<br>"
	msg_out += "<hr><br>"
	switch(luck)
		if(-INFINITY to 35)
			switch(rand(1,5))
				if(1)
					msg_out += "\tYou will die.<br>"
				if(2)
					msg_out += "\tBad luck and misfortune will haunt your pathetic soul for all eternity.<br>"
				if(3)
					msg_out += "\tYou will be eaten by a grue.<br>"
				if(4)
					msg_out += "\tWake up.<br>"
				if(5)
					msg_out += "\tBitch.<br>"
		if(36 to 65)
			switch(rand(1,5))
				if(1)
					msg_out += "\tA bird in the hand is worth two in the bush, but a cat in the bag is worth nothing at all.<br>"
				if(2)
					msg_out += "\tThe sun is shining brightly today, and the birds are singing their melodious songs. I feel happy and grateful for this wonderful day. Life is full of surprises and opportunities, and I am ready to embrace them all.<br>"
				if(3)
					msg_out += "\tSometimes I like to wander around the city, and explore new places and people. I enjoy the diversity and richness of cultures and experiences. There is so much to learn and discover in this world, and I am curious and open-minded.<br>"
				if(4)
					msg_out += "\tI love reading books, especially fantasy and science fiction. They transport me to different worlds and realities, where anything is possible. I admire the creativity and imagination of the authors, and I feel inspired by their stories.<br>"
				if(5)
					msg_out += "\tBitch.<br>"
		if(66 to 100)
			switch(rand(1,5))
				if(1)
					msg_out += "\tThe sun is dazzling today, and the birds are serenading me with their heavenly songs. I feel ecstatic and blessed for this magnificent day. Life is overflowing with miracles and possibilities, and I am eager to seize them all.<br>"
				if(2)
					msg_out += "\tSometimes I like to roam around the city, and discover new wonders and friends. I delight in the variety and richness of cultures and experiences. There is so much to learn and explore in this world, and I am adventurous and open-hearted.<br>"
				if(3)
					msg_out += "\tI adore reading books, especially fantasy and science fiction. They whisk me away to different worlds and realities, where anything is achievable. I marvel at the creativity and imagination of the authors, and I feel motivated by their stories.<br>"
				if(4)
					msg_out += "\tMusic is my joy and my healing. It calms my soul and elevates my spirit. I like to listen to different genres and artists, and appreciate the beauty and emotion of their songs. Music bonds me to myself and others, and conveys what words cannot.<br>"
				if(5)
					msg_out += "\tBitch.<br>"

	msg_out += "<center>YOU HAVE BEEN WARNED!</center><br>"
	msg_out += "<center>- END OF REPORT -</center><br>"
	return span_robot(msg_out.Join())

/obj/machinery/mineral/wasteland_trader/proc/get_thing_to_sell()
	for(var/thingy in src)
		if(istype(thingy, /obj/item/button))
			continue
		if(istype(thingy, /obj/item/stack/f13Cash))
			continue
		if(appraise_item(thingy, TRUE))
			return thingy
	return

/obj/machinery/mineral/wasteland_trader/proc/start_progress_bar(goal_time)
	if(!goal_time)
		return
	if(!istype(my_bar))
		my_bar = new /datum/progressbar/stored(null, goal_time, src)
	my_bar.show_bar()
	my_bar.set_new_goal(goal_time)
	start_time = world.time
	end_time = goal_time + world.time
	START_PROCESSING(SSfastprocess, src)

/obj/machinery/mineral/wasteland_trader/proc/stop_progress_bar()
	STOP_PROCESSING(SSfastprocess, src)
	end_time = 0
	my_bar.hide_bar()
	update_overlays()

/obj/machinery/mineral/wasteland_trader/process()
	if(!my_bar)
		return
	update_overlays()
	if(world.time >= end_time && !is_grinding)
		stop_progress_bar()

/obj/machinery/mineral/wasteland_trader/update_overlays()
	. = ..()
	cut_overlays()
	if(!my_bar || !is_grinding)
		return
	my_bar.update(world.time - start_time)
	add_overlay(my_bar.bar)

/*

ORGAN SELLER

*/

/obj/machinery/mineral/wasteland_trader/organ
	name = "Organ Grinder"
	desc = "Organs go in, caps come out. How does it work? Nobody knows."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "organs"

	goods_list = list( /obj/item/organ/heart = 30,
								/obj/item/organ/ears = 5,
								/obj/item/organ/eyes = 5,
								/obj/item/organ/liver = 15,
								/obj/item/organ/lungs = 25,
								/obj/item/organ/stomach = 15,
								/obj/item/organ/tongue = 5
								)

/obj/machinery/mineral/wasteland_trader/organ/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Heart : 30 copper<br>"
	dat += "Lungs : 25 copper<br>"
	dat += "Liver : 15 copper<br>"
	dat += "Stomach : 15 copper<br>"
	dat += "Eyes : 5 copper<br>"
	dat += "Ears : 5 copper<br>"
	dat += "Tongue : 5 copper<br>"
	dat += "Brain : UNAVAILABLE<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Organ Grinder", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/*

Fence

*/

/obj/machinery/mineral/wasteland_trader/brotherhood
	name = "Nash Bounty Ticket Machine"
	desc = "This vending machine accepts bounty tickets in exchange for caps. Make the Wasteland safer, and yourself richer, one bullet at a time."

	goods_list = list( 	/obj/item/card/lowbounty = 100,
						/obj/item/card/midbounty = 200,
						/obj/item/card/highbounty = 400,
						/obj/item/card/kingbounty = 800
								)

/obj/machinery/mineral/wasteland_trader/brotherhood/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Turn your kills into caps today!</b><br>"
	dat += "Small Roller Bounty Ticket: 1 copper<br>"
	dat += "Medium Roller Bounty Ticket: 200 copper<br>"
	dat += "High Roller Bounty Ticket: 400 copper<br>"
	dat += "King's Bounty Ticket: 800 copper<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Brotherhood of Steal", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/gunbuyer
	name = "Gun Repository"
	desc = "Place weapon inside slot. Weapon is sent out of the region for post-processing. Recieve compensation. Yuma Wasteland Supply Inc. thanks you for disarming the wasteland."
	goods_list = list(/obj/item/gun/ballistic/automatic/hobo/zipgun = 5,
						/obj/item/gun/ballistic/revolver/hobo = 5,
						/obj/item/gun/ballistic/revolver/detective = 5,
						/obj/item/gun/ballistic/revolver/hobo = 8,
						/obj/item/gun/ballistic/revolver/hobo/piperifle = 8,
						/obj/item/gun/ballistic/revolver/hobo/knifegun = 8,
						/obj/item/gun/ballistic/revolver/hobo/pepperbox = 8,
						/obj/item/gun/ballistic/revolver/single_shotgun = 8,
						/obj/item/gun/ballistic/automatic/pistol/n99 = 8,
						/obj/item/gun/ballistic/automatic/pistol/pistol22 = 8,
						/obj/item/gun/ballistic/automatic/pistol/ninemil = 8,
						/obj/item/gun/ballistic/automatic/pistol/sig = 8,
						/obj/item/gun/ballistic/automatic/pistol/beretta = 8,
						/obj/item/gun/ballistic/automatic/pistol/m1911 = 8,
						/obj/item/gun/ballistic/rifle/hunting = 10,
						/obj/item/gun/ballistic/revolver/colt357 = 10,
						/obj/item/gun/ballistic/rifle/mosin = 10,
						/obj/item/gun/ballistic/revolver/caravan_shotgun = 10,
						/obj/item/gun/ballistic/revolver/widowmaker = 10,
						/obj/item/gun/ballistic/revolver/winchesterrebored = 10,
						/obj/item/gun/ballistic/automatic/autopipe = 15,
						/obj/item/gun/ballistic/rifle/hobo/lasmusket = 15,
						)

/obj/machinery/mineral/wasteland_trader/gunbuyer/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Disarming the Wasteland one gun at a time.</b><br>"
	dat += "<b>Warning: The automated system cannot guarantee an accurate appraisal of value.</b><br>"
	dat += "<b>Accepted goods and prices:</b><br>"
	dat += "Pistols and revolvers: 5-10 copper<br>"
	dat += "Rifles and Shotguns : 10-15 copper<br>"
	dat += "Does not accept weapons of historical or artisanal value. Those belong in a musuem."
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Trading point", 400, 500)
	popup.set_content(dat)
	popup.open()
	return
