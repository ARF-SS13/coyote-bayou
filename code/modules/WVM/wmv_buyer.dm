GLOBAL_LIST_EMPTY(wasteland_vendor_shop_list)

#define WVM_SCRAPPER "wasteland_trader"

/obj/machinery/mineral/wasteland_trader
	name = "Workshop Scrapper"
	desc = "A vending machine that's been modified to accept various items in exchange for copper Edisons. \
			A sign on it reads, 'Keep your workplace clean and get paid doing it!' \
			It's better than a trash can, at least. \
			Make sure to check in with the shopkeep for a better deal!"
	icon = 'icons/WVM/machines.dmi'
	icon_state = "trade_idle"

	density = TRUE
	use_power = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	can_be_unanchored = FALSE
	layer = 2.9

	var/stored_caps = 0	// store caps
	var/expected_price = 0
	var/list/prize_list = list()  // infinite profits should be crap, more limited profits should be good. Should never be better than cargo.
	var/trader_key = WVM_SCRAPPER
	var/exact_change = TRUE


	/// List of things it buys, and allows any of its children into the buy list
	var/list/buyables_loose = list(
		/obj/item/stack/sheet/metal = 0.4,
		/obj/item/stack/sheet/mineral/titanium = 0.8,
		/obj/item/stack/sheet/plasteel = 2,
		/obj/item/stack/ore/blackpowder = 1,
		/obj/item/stack/sheet/prewar = 2,
		/obj/item/stack/sheet/sinew = 1,
		/obj/item/stack/sheet/mineral/plastitanium = 3,
		/obj/item/pearl = 20,
		/obj/item/clothing/accessory/pearl_necklace = 300,
		/obj/item/reagent_containers/hypospray = 1,
		/obj/item/reagent_containers/pill/patch/medx = 3,
		/obj/item/reagent_containers/pill/patch/steady = 3,
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
		/obj/item/stack/sheet/bone = 4,
		/obj/item/stack/sheet/cloth = 0.2, // low because botany and because use this for medical supplies you drongo
		/obj/item/stack/sheet/leather = 0.8,
		/obj/item/reagent_containers/food/snacks/meat = 5,
		/obj/item/reagent_containers/food/snacks/meat/slab/synthmeat = 0, // To prevent people from printing effortless money at a biogen
		/obj/item/fishy/carp = 5,
		/obj/item/fishy/salmon = 5,
		/obj/item/fishy/eel = 15,
		/obj/item/fishy/crawdad = 5,
		/obj/item/fishy/shrimp = 5,
		/obj/item/fishy/guppy = 5,
		/obj/item/fishy/firefish = 25,
		/obj/item/fishy/greenchromis = 10,
		/obj/item/fishy/cardinalfish = 20,
		/obj/item/fishy/catfish = 5,
		/obj/item/fishy/plastetra = 20,
		/obj/item/fishy/angelfish = 15,
		/obj/item/fishy/clownfish = 10,
		/obj/item/fishy/lubefish = 10,
		/obj/item/fishy/lanternfish = 15,
		/obj/item/fishy/goldfish = 100,
		/obj/item/fishy/dwarf_moonfish = 20,
		/obj/item/fishy/bugfish = 15,
		/obj/item/fishy/gunner_jellyfish = 15,
		/obj/item/fishy/needlefish = 1,
		/obj/item/fishy/armorfish = 5,
		/obj/item/fishy/pufferfish = 20,
		/obj/item/reagent_containers/food/snacks/meat/slab/human = 0,
		/obj/item/stack/sheet/animalhide = 3,
		/obj/item/clothing/suit/armor = 10,
		/obj/item/clothing/head/helmet = 10,
		/obj/item/clothing/suit/armor/heavy/salvaged_pa = 30,
		/obj/item/clothing/head/helmet/f13/heavy/salvaged_pa = 30,
		/obj/item/clothing/suit/armor/power_armor = 75,
		/obj/item/clothing/head/helmet/f13/power_armor = 75,
		/obj/item/gun/ballistic/shotgun/toy = 5,
		/obj/item/gun/ballistic/automatic/toy = 5,
		/obj/item/toy/plush = 5,
		/obj/item/toy/talking = 5,
		/obj/item/toy/toy_xeno = 5,
		/obj/item/toy/cattoy = 5,
		/obj/item/toy/figure = 5,
		/obj/item/toy/eightball = 5,
		/obj/item/melee = 5,
		/obj/item/melee/transforming = 5,
		/obj/item/twohanded = 5,
		/obj/item/gun/energy/laser = 15,
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
		// magic shit:tm:
		/obj/item/gun/magic/ = 15,
		// weapon mods
		/obj/item/gun_upgrade/ = 15,
	)
	/// List of things it buys, but does NOT allow any of its children into the buy list
	var/list/buyables_tight = list(
		/obj/item/gun/ballistic/automatic/autopipe = 0,
		/obj/item/gun/ballistic/rifle/hobo/lasmusket = 0,
		/obj/item/gun/ballistic/rifle/hobo/plasmacaster = 0,
		/obj/item/gun/ballistic/automatic/hobo/destroyer = 0,
		/obj/item/gun/ballistic/rifle/hunting/obrez = 0,
		/obj/item/gun/ballistic/revolver/winchesterrebored = 0,
		/obj/item/gun/ballistic/revolver/brick = 0,
		/obj/item/gun/ballistic/revolver/sling/staff = 0,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/sling = 0,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/sling/staff = 0,
		/obj/item/gun/ballistic/automatic/hobo/zipgun = 0,
		/obj/item/gun/ballistic/revolver/hobo/piperifle = 0,
		/obj/item/gun/ballistic/revolver/hobo/piperifle/romckit = 0,
		/obj/item/gun/ballistic/revolver/hobo/pepperbox = 0,
		/obj/item/gun/ballistic/revolver/hobo/single_shotgun = 0,
		/obj/item/gun/ballistic/revolver/hobo/knifegun = 0,
		/obj/item/gun/ballistic/revolver/hobo/knucklegun = 0,
		/obj/item/stack/sheet/animalhide/chitin = 1,
		/obj/item/stack/sheet/animalhide/aethergiest = 20,
		/obj/item/stack/sheet/animalhide/gecko = 2,
		/obj/item/stack/sheet/animalhide/molerat = 2,
		/obj/item/stack/sheet/animalhide/wolf = 8,
		/obj/item/stack/sheet/animalhide/radstag = 12,
		/obj/item/stack/sheet/animalhide/brahmin = 6,
		/obj/item/clothing/head/f13/stalkerpelt = 8,
		/obj/item/clothing/head/bearpelt = 20,
		/obj/item/stack/sheet/animalhide/human = 0,
		/obj/item/reagent_containers/food/snacks/meat/slab/aethergiest = 20, // meat high because you can't carry a lot of it, and it's actually really valuable as healing
		/obj/item/reagent_containers/food/snacks/meat/slab/gecko = 4,
		/obj/item/reagent_containers/food/snacks/meat/slab/molerat = 4,
		/obj/item/reagent_containers/food/snacks/meat/slab/wolf = 8,
		/obj/item/reagent_containers/food/snacks/meat/slab/mirelurk = 4,
		/obj/item/reagent_containers/food/snacks/meat/slab/radroach_meat = 2,
		/obj/item/reagent_containers/food/snacks/meat/slab/ant_meat = 4,
		/obj/item/reagent_containers/food/snacks/meat/slab/fireant_meat = 9,
		/obj/item/reagent_containers/food/snacks/meat/slab/bloatfly_meat = 1,
		/obj/item/reagent_containers/food/snacks/meat/slab/cazador_meat = 3,
		/obj/item/reagent_containers/food/snacks/meat/slab/radscorpion_meat = 3,
		/obj/item/gun/energy/kinetic_accelerator/crossbow = 15,
		/obj/item/gun/energy/kinetic_accelerator/crossbow/large = 15,
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
		/obj/item/card/lowbounty = 75,
		/obj/item/card/midbounty = 150,
		/obj/item/card/highbounty = 250,
		/obj/item/card/kingbounty = 500,
		// Artifacts: Someone who actually playes needs to test these prices -Kelprunner
		/obj/item/artifact/common = 150,
		/obj/item/artifact/uncommon = 300,
		/obj/item/artifact/rare = 500,
	)
	var/list/quicklisted = list()
	var/is_grinding = FALSE
	var/sales_timer
	var/my_bar
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
	var/list/buylist = sortList(buyables_loose, GLOBAL_PROC_REF(cmp_typepaths_length_asc))
	for(var/stuff in buylist)
		var/list/cumfrosting = list()
		cumfrosting = typecacheof(stuff)
		cumfrosting = counterlist_scale(cumfrosting, buylist[stuff])
		for(var/thing in cumfrosting)
			donut[thing] = cumfrosting[thing]
	/// now, prune and process the tight list
	buylist.Cut()
	buylist = sortList(buyables_tight, GLOBAL_PROC_REF(cmp_typepaths_length_asc))
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
	. += span_notice("To use, insert items you want to sell, and then press the big CONFIRM SALE button. This will destroy the items and give you Edisons.")
	. += span_notice("ALT-click this machine to open its internal sales-hopper.")
	. += span_notice("Click the item on the button inside the machine's inventory to see how much it's worth.")

/obj/machinery/mineral/wasteland_trader/proc/run_button()
	if(is_grinding)
		return "<b>SALE IN PROGRESS!</b> <A href='?src=[REF(src)];choice=abort'><u>Abort?</u></A><br>"
	else
		return "IDLE - <A href='?src=[REF(src)];choice=run'><u>Initiate Sale</u></A><br>"

/obj/machinery/mineral/wasteland_trader/proc/charon()
	if(exact_change)
		return "<A href='?src=[REF(src)];choice=toggle_exact_change'><u>Paying out in Copper, Silver, Gold</u></A><br>"
	else
		return "<A href='?src=[REF(src)];choice=toggle_exact_change'><u>Paying out in Copper only</u></A><br>"

/obj/machinery/mineral/wasteland_trader/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]<br>"
	dat += "[charon()]"
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
	dat += "Energy Weapons: 15¢<br>"
	dat += "Armor: 10¢ (for now)<br>"
	dat += "Salvaged Power Armor: 30¢<br>"
	dat += "Power Armor: 75¢<br>"
	dat += "Melee Weapons: 10¢<br>"
	dat += "Weapon Mods: 5¢<br>"
	dat += "<br>"
	dat += "<b>Turn your kills into coins today!</b><br>"
	dat += "Small Roller Bounty Ticket: 75¢<br>"
	dat += "Medium Roller Bounty Ticket: 150¢<br>"
	dat += "High Roller Bounty Ticket: 250¢<br>"
	dat += "King's Bounty Ticket: 500¢<br>"
	dat += "<br>"
	dat += "<b>No use for an artifact? Trade it for hard coins!</b><br>"
	dat += "Lesser Artifact: 150¢<br>"
	dat += "Standard Artifact: 300¢<br>"
	dat += "Greater Artifact: 500¢<br>"
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
	if(href_list["choice"] == "toggle_exact_change")
		TOGGLE_VAR(exact_change)
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
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, I, user)

/obj/machinery/mineral/wasteland_trader/proc/appraise_item(obj/item/I, silent)
	if(!I)
		return
	var/quiet
	if("[I.type]" == last_appraised)
		quiet = TRUE
	last_appraised = "[I.type]"
	var/final_price = (round(CREDITS_TO_COINS(SEND_SIGNAL(I, COMSIG_ATOM_GET_VALUE)))) || GLOB.wasteland_vendor_shop_list[trader_key][I.type] // get value, get paid
	if(!final_price)
		if(!silent)
			say("I'll give you absolutely nothing for \the [I]!", only_overhead = quiet)
		return FALSE
	if(!silent)
		say("I'll give you [SSeconomy.format_currency(final_price, FALSE, TRUE)] per [I]!", only_overhead = quiet) //Uses false for second argument because final_price has already been converted to copper from credits during initial assignment.
	return final_price

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
	SSprogress_bars.remove_bar(my_bar)
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
			INVOKE_ASYNC(src,PROC_REF(sell_loop_start))
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
	var/final_price = appraise_item(thing2sell, TRUE)
	if(!final_price)
		say("Nope, don't want that [thing2sell]!")
		yeet_thing(thing2sell)
		sell_loop_start()
		return
	if(istype(thing2sell, /obj/item/stack))
		var/obj/item/stack/S = thing2sell
		final_price = S.amount * final_price
	var/time2sell = final_price * 0.1 SECONDS
	if(time2sell > 10 SECONDS)
		var/difference = time2sell - (10 SECONDS)
		time2sell = (10 SECONDS) + sqrt(sqrt(difference)) // genius
	say("Now processing [thing2sell]!", only_overhead = TRUE)
	my_bar = SSprogress_bars.add_bar(src, list(), time2sell, TRUE, TRUE)
	soundloop.start()
	lock_belt()
	sales_timer = addtimer(CALLBACK(src,PROC_REF(sell_loop_end), thing2sell), time2sell, TIMER_STOPPABLE)

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
	var/final_price = appraise_item(I, FALSE)
	if(!final_price)
		say("Nope, don't want that [I]!")
		yeet_thing(I)
		sell_loop_start()
		return
	if(istype(I, /obj/item/stack))
		var/obj/item/stack/S = I
		final_price = S.amount * final_price
	var/fractional = final_price - FLOOR(final_price, 1)
	if(fractional || prob(2))
		generate_fortune(fractional || rand(1,10)) // no more only-bad fortunes for everyone
	payout(floor(final_price), I, TRUE, exact_change, TRUE)
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
	yote.forceMove(get_turf(src)) // juuuuuust in case
	var/atom/lucky_target
	var/list/throw_at_ables = list()
	for(var/mob/oops in view(7, src))
		throw_at_ables |= oops
	if(LAZYLEN(throw_at_ables))
		lucky_target = pick(throw_at_ables)
	else
		lucky_target = get_ranged_target_turf(src, pick(GLOB.alldirs), rand(1,5), 5)
	yote.throw_at(lucky_target, 20, 1)

/// takes in an amount of raw cash, and returns a list of the denominations of coins that would be used to make that amount
/// Assumptions: 10 copper -> 1 silver, 10 silver -> 1 gold
/// list format: list("copper" = 0, "silver" = 0, "gold" = 0)
/proc/generate_denomination_list(money_in)
	var/list/coinage = list("copper" = 0, "silver" = 0, "gold" = 0)
	while(money_in > 0)
		if(money_in >= 100)
			coinage["gold"] += 1
			money_in -= 100
		else if(money_in >= 10)
			coinage["silver"] += 1
			money_in -= 10
		else
			coinage["copper"] += 1
			money_in -= 1
	return coinage

/// takes in an amount of raw cash, and distributes it through only copper stacks in the machine
/// each stack can only take 500 coins, so it will create new stacks as needed
/obj/machinery/proc/copper_only(caps, obj/item/I, loud)
	for(var/obj/item/stack/f13Cash/caps/copper_stack in contents)
		if(copper_stack.amount < 500)
			var/amount_to_add = min(500 - copper_stack.amount, caps)
			copper_stack.amount += amount_to_add
			copper_stack.update_icon()
			caps -= amount_to_add
			if(caps <= 0)
				return TRUE // all done!
	var/safety = 100
	while(caps > 0 && safety--)
		var/obj/item/stack/f13Cash/caps/C = new(src)
		if(!C)
			return FALSE
		C.amount = min(500, caps)
		C.update_icon()
		caps -= C.amount
	var/total_cash = 0
	for(var/obj/item/stack/f13Cash/C in contents)
		if(istype(C, /obj/item/stack/f13Cash/denarius))
			total_cash += (C.amount * 10) // silver, 10 copper per
		else if(istype(C, /obj/item/stack/f13Cash/aureus))
			total_cash += (C.amount * 100) // gold, 100 copper per
		else
			total_cash += C.amount
	if(loud && I)
		announce_sale(caps, total_cash, I)

/obj/machinery/proc/payout(caps, obj/item/I, loud, denominate, inside)
	if(!denominate)
		return copper_only(caps, I, loud)
	/// get the total cash we have in the machine, plus the amount we're paying out, in copper
	var/total_cash = caps
	/// we're going to sweep up any duplicate stacks of copper and silver
	var/obj/item/stack/f13Cash/caps/one_copper
	var/obj/item/stack/f13Cash/denarius/one_silver
	var/obj/item/stack/f13Cash/aureus/one_gold
	for(var/obj/item/stack/f13Cash/C in contents)
		if(istype(C, /obj/item/stack/f13Cash/denarius))
			total_cash += (C.amount * 10) // silver, 10 copper per
			if(one_silver)
				qdel(C)
			else
				one_silver = C
				one_silver.amount = 0
		else if(istype(C, /obj/item/stack/f13Cash/aureus))
			total_cash += (C.amount * 100) // gold, 100 copper per
			if(one_gold)
				qdel(C)
			else
				one_gold = C
				one_gold.amount = 0
		else
			total_cash += C.amount
			if(one_copper)
				qdel(C)
			else
				one_copper = C
				one_copper.amount = 0 // we'll give em back, I swear
	var/atom/put_it = inside ? src : get_turf(src) // insiiide, outsiiide, insiiide, outsiiide, insiiide, outsiiide the machine
	/// if we're paying out in exact change, we need to generate the list of denominations
	var/list/coinage = generate_denomination_list(total_cash)
	var/copperamt = coinage["copper"]
	var/silveramt = coinage["silver"]
	var/goldamt = coinage["gold"]
	/// first distribute the copper
	if(copperamt > 0)
		if(!one_copper)
			one_copper = new(put_it, copperamt)
		else
			one_copper.amount = copperamt
		one_copper.update_icon()
	/// then the silver
	if(silveramt > 0)
		if(!one_silver)
			one_silver = new(put_it, silveramt)
		else
			one_silver.amount = silveramt
		one_silver.update_icon()
	/// then make some gold stacks. if we have more than 500 gold to place, we'll make as many stacks of 500 as we need, and then one for the remainder
	if(goldamt > 0)
		if(goldamt > 500)
			while(goldamt > 500)
				var/obj/item/stack/f13Cash/aureus/G = new(put_it, 500)
				G.update_icon()
				goldamt -= 500
		if(goldamt > 0)
			var/obj/item/stack/f13Cash/aureus/G = new(put_it, goldamt)
			G.update_icon()
	if(loud && I)
		announce_sale(caps, total_cash, I)

/obj/machinery/proc/announce_sale(soldfor, totalcash, obj/item/I)
	var/thing = I ? "\the [I]" : "something"
	var/currencie = "[SSeconomy.format_currency(soldfor, FALSE, TRUE)]" //Second argument false because we are already receiving coppers for the proc arguments
	var/currencei = "[SSeconomy.format_currency(totalcash, FALSE, TRUE)]"
	say("Sold [thing] for [currencie], bringing the total to [currencei]!")

/obj/item/debug_vendorsale
	name = "Really Valuable Thing"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "latexballoon_blow"

/obj/item/debug_vendorsale/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_GET_VALUE, PROC_REF(get_value))

/obj/item/debug_vendorsale/proc/get_value()
	return round(CREDITS_TO_COINS(12345))

/obj/machinery/mineral/wasteland_trader/proc/generate_fortune(fractional)
	var/mob/whos_it_for
	if(prob(50))
		var/list/allclients = GLOB.player_list
		var/list/coolclients = allclients.Copy()
		for(var/i in 1 to LAZYLEN(allclients))
			var/mob/C = pick(coolclients)
			if(isnewplayer(C))
				coolclients -= C
				continue
			if(ismob(C)) // juuuust in case
				whos_it_for = C
	else
		for(var/mob/who in range(7, src)) // this also counts ghosts
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
	var/true_luck = rand(1, clamp(fractional * 10, 1, 100))
	our_paper.name = "[whos_it_for.name]'s fortune"
	our_paper.info += "<br>"
	our_paper.info += write_contents(true_luck, whos_it_for.real_name || whos_it_for.name)
	our_paper.update_icon_state()
	playsound(src, 'sound/machines/printer_thermal.ogg', 50, 1)
	return TRUE

/obj/machinery/mineral/wasteland_trader/proc/write_contents(luck, whofor)
	var/list/msg_out = list()
	msg_out += "<hr><br>"
	msg_out += "<center>- START REPORT -</center><br>"
	msg_out += "<center>- [span_small(uppertext(STATION_TIME_TIMESTAMP(FALSE, world.time)))] -</center><br>"
	msg_out += "<u><b>FoxEye Destiny Divination Station v1.23 PRO</b></u><br>"
	msg_out += "[FOURSPACES][whofor]'s projected destiny<br>"
	msg_out += "<hr><br><br><center>"
	var/bitch = FALSE
	luck = rand(1,100) // old system was kinda bungus
	switch(luck)
		if(-INFINITY to 35)
			switch(rand(1,20))
				if(1)
					msg_out += "\tYou will die."
				if(2)
					msg_out += "\tBad luck and misfortune will haunt your pathetic soul for all eternity."
				if(3)
					msg_out += "\tYou will be eaten by a grue."
				if(4)
					msg_out += "\tWake up."
				if(5)
					msg_out += "\tThe resplendent sun, which once bathed the world in a radiant glow, now shrouds itself behind dark, ominous clouds, casting an overwhelming gloom upon the once-vibrant landscape. The birds' enchanting melodies, once a celestial symphony, now resonate with melancholic notes, filling your heart with a profound sense of sorrow and despair. Life's infinite miracles and boundless possibilities, which once beckoned with allure, now seem distant and unattainable, veiled behind an impenetrable mist of uncertainty. The motivation and eagerness that once fueled your pursuit of dreams have dimmed, leaving you feeling lost and devoid of any ambition to seize the opportunities that life may present."
				if(6)
					msg_out += "\tYou, who were once an intrepid voyager, weaving through the labyrinthine city streets with enthusiasm and anticipation, now find yourself engulfed in a sea of closed hearts and disappointments. The world, once a captivating tapestry of wonder and excitement, now appears drab and monotonous, lacking any semblance of novelty or connection. Each encounter, which was once a source of joy and camaraderie, now feels like a stark reminder of your isolation and alienation from the world around you. Your heart, once open and receptive, now hesitates to extend trust or vulnerability, guarded by the fortress of your disillusionment and disenchantment."
				if(7)
					msg_out += "\tBooks, which were once gateways to boundless realms of fantasy and science fiction, now appear as mere collections of lifeless words etched upon a canvas of dull paper. The enchanting worlds that once unfolded before your eyes, igniting the spark of imagination within you, now lay dormant and devoid of wonder. The pages, which once glittered with stardust, now seem faded and lackluster, failing to inspire any sense of awe or captivation. The worlds within the pages, which were once a refuge of inspiration and motivation, now appear mundane and uninteresting, leaving you bereft of the desire to embark on any literary journey."
				if(8)
					msg_out += "\tMusic, which was once a symphony of healing and solace, cascading through the corridors of your soul, now sounds like a cacophony of discordant notes, exacerbating the ache within you. The melodies, which once resonated with your deepest emotions, now fall upon deaf ears, unable to penetrate the fortress of your melancholy. The ethereal healing, which music once offered, now eludes you, leaving you feeling disconnected and hollow. The notes, which were once a chorus of hope and joy, now fade into a somber dirge, amplifying the profound sense of sadness that envelops your being."
				if(9)
					msg_out += "\tBitch."
					bitch = TRUE
				if(10)
					msg_out += "\tThe mornings, which were once greeted with radiant smiles and a sense of boundless hope, now arrive with heavy hearts and weariness. The days, which were once a tapestry of jubilation and exuberance, now appear as burdensome chores, devoid of any glimmer of excitement or delight. The world, which once seemed like a playground of infinite possibilities, now feels like a stage for mere spectators, leaving you estranged from the vibrant dance of life. Your spirit, which once soared like a jubilant bird, now appears tethered and grounded, unable to find ecstasy or elation in the simplest pleasures."
				if(11)
					msg_out += "\tNature, which was once a sanctuary of lush marvels and flourishing dreams, now appears desolate and barren. The once vibrant trees and flowers, which painted the world with hues of vivacity, now stand withered and lifeless, mirroring the emptiness that consumes your heart. The air, which once carried the sweet fragrance of life, now feels stale and suffocating, leaving you feeling isolated and disconnected from the vibrant dance of existence. Far from being a refuge of solace and serenity, the natural world now appears indifferent to your presence, amplifying your sense of loneliness and insignificance."
				if(12)
					msg_out += "\tThe stars, which were once celestial allies conspiring to fulfill your every wish, now seem distant and cold, their once-bright radiance dimmed to mere flickers in the night sky. Your dreams, which once seemed like shimmering stars waiting to be plucked from the heavens, now appear as elusive and unattainable as distant constellations. Each intention, which was once a beacon of hope guiding you towards your heart's desires, now feels like a faint glimmer, struggling to pierce through the darkness of uncertainty and doubt. The universe, which once appeared in harmony with your aspirations, now seems indifferent to your desires, leaving you feeling adrift in an unfathomable cosmic sea."
				if(13)
					msg_out += "\tLaughter, which was once a joyous fountain gushing from the depths of your soul, now remains a mere echo of past merriment. The once infectious sound of laughter, which once filled your surroundings with gaiety, now rings hollow and devoid of any genuine cheer. Your attempts to find humor in the world now feel forced and unnatural, leaving you feeling even more desolate and disconnected from the joys of life. The sound of laughter, which was once a symphony of shared happiness, now falls upon deaf ears, unable to alleviate the profound sense of sorrow that envelops your being."
				if(14)
					msg_out += "\tLove, which was once an ethereal symphony resonating within your being, now feels like a distant memory, fading like a waning moon in the night sky. Your heart, which was once a boundless wellspring of compassion, now feels guarded and closed, fearing rejection and pain. Each act of kindness, which was once a tender caress that warmed your soul, now appears insincere and devoid of any genuine affection. The once harmonious connection between hearts, which once united all beings in a dance of love, now feels fractured and distant, leaving you feeling unloved and unappreciated."
				if(15)
					msg_out += "\tYour creativity, which was once a radiant aurora illuminating the canvas of existence with dazzling hues, now appears dimmed and obscured, like a fading star in the night sky. Each stroke of artistic brilliance, which was once a testament to your boundless imagination, now feels lackluster and uninspired, lacking the depth and originality that once defined your artistry. The palette of your creativity, which was once a vibrant tapestry of uncharted ideas, now appears muted and devoid of any vivid expression, leaving you feeling creatively stifled and unfulfilled."
				if(16)
					msg_out += "\tThe universe, which once showered you with cosmic blessings, feels like an unfathomable abyss, concealing its treasures beyond your reach. Your efforts to manifest your desires now seem futile, like a ship lost at sea, adrift in a vast ocean of emptiness. Each day, which was once a canvas of boundless miracles and blessings, now appears monotonous and devoid of any magic or wonder. Your dreams, which once gleamed like a constellation of stars, now appear distant and unreachable, leaving you feeling disconnected from the cosmic rhythm of creation."
				if(17)
					msg_out += "\tGratitude, which was once a celestial elixir that nourished your soul, now feels like a mere empty ritual, void of any genuine sentiment. The world, which once sparkled with hidden blessings and miracles, now appears filled with hardship and sorrow, leaving you struggling to find anything to be thankful for. Each breath, which was once a sweet hymn of gratitude, now feels like a laborious endeavor, weighed down by the burdens you carry. The symphony of thankfulness, which once resonated with the heartbeat of the universe, now falls silent, leaving you feeling bereft of any cause for appreciation."
				if(18)
					msg_out += "\tYour spirit, which once soared like an iridescent phoenix, ascending to celestial heights on wings of courage, now feels grounded and defeated, like a bird with clipped wings. Each challenge, which once served as a stepping stone to greatness, now appears insurmountable, a mountain that looms imposingly on your path. Your dreams of greatness, which once burned like a blazing star within you, now appear like mere fantasies, impossible to achieve amidst the shadows of doubt and self-doubt. Your once-boundless strength and resilience have now given way to a sense of powerlessness and resignation."
				if(19)
					msg_out += "\tThe world, which was once a tapestry of love and compassion, now feels like a cold and heartless place, devoid of any genuine affection or understanding. Each act of kindness, which was once a brushstroke that painted the canvas of existence with hues of empathy, now appears superficial and fleeting, like fading watercolor on a canvas exposed to the relentless rain. The celestial symphony of love, which once united all hearts in perfect cadence, now feels discordant and distant, leaving you feeling isolated and disconnected from the vibrant dance of humanity."
				if(20)
					msg_out += "\tBitch."
					bitch = TRUE
			switch(rand(1,20))
				if(1)
					msg_out += "\tA bird in the hand is worth two in the bush, but a cat in the bag is worth nothing at all."
				if(2)
					msg_out += "\tThe sun is shining brightly today, and the birds are singing their melodious songs. You feel happy and grateful for this wonderful day. Life is full of surprises and opportunities, and you are ready to embrace them all."
				if(3)
					msg_out += "\tSometimes you like to wander around the city, and explore new places and people. You enjoy the diversity and richness of cultures and experiences. There is so much to learn and discover in this world, and you are curious and open-minded."
				if(4)
					msg_out += "\tI love reading books, especially fantasy and science fiction. They transport you to different worlds and realities, where anything is possible. You admire the creativity and imagination of the authors, and you feel inspired by their stories."
				if(5)
					msg_out += "\tBitch."
					bitch = TRUE
				if(6)
					msg_out += "\tWhen you plant a seed of kindness, it grows and spreads, touching the lives of many."
				if(7)
					msg_out += "\tIn the journey of life, it's the little moments of joy that create the most cherished memories."
				if(8)
					msg_out += "\tThe best way to find yourself is to lose yourself in helping others."
				if(9)
					msg_out += "\tBelieve in the beauty of your dreams and have the courage to pursue them relentlessly."
				if(10)
					msg_out += "\tThe key to success is not just hard work, but also embracing failure as a stepping stone to progress."
				if(11)
					msg_out += "\tHappiness is not a destination, but a way of life; find joy in the journey."
				if(12)
					msg_out += "\tSurround yourself with those who inspire and uplift you; together, you can achieve greatness."
				if(13)
					msg_out += "\tEvery cloud has a silver lining; even in tough times, there is something to be grateful for."
				if(14)
					msg_out += "\tEmbrace change as an opportunity for growth and self-discovery."
				if(15)
					msg_out += "\tThe more you give, the more you receive; kindness and compassion create a ripple effect."
				if(16)
					msg_out += "\tStay true to yourself, for you are unique and have something special to offer the world."
				if(17)
					msg_out += "\tIn the face of challenges, remain resilient and adaptable; you are stronger than you think."
				if(18)
					msg_out += "\tCelebrate the successes of others as if they were your own, and you'll find joy in their happiness."
				if(19)
					msg_out += "\tTake time to appreciate the beauty of nature; it can bring peace and clarity to your mind."
				if(20)
					msg_out += "\tEvery day is a new beginning, full of opportunities to make a positive impact on the world."
		if(66 to 100)
			switch(rand(1,20))
				if(1)
					msg_out += "\tThe sun is dazzling today, and the birds are serenading you with their heavenly songs. You feel ecstatic and blessed for this magnificent day. Life is overflowing with miracles and possibilities, and you are eager to seize them all."
				if(2)
					msg_out += "\tSometimes you like to roam around the city, and discover new wonders and friends. You delight in the variety and richness of cultures and experiences. There is so much to learn and explore in this world, and you are adventurous and open-hearted."
				if(3)
					msg_out += "\tI adore reading books, especially fantasy and science fiction. They whisk you away to different worlds and realities, where anything is achievable. You marvel at the creativity and imagination of the authors, and you feel motivated by their stories."
				if(4)
					msg_out += "\tMusic is my joy and my healing. It calms my soul and elevates my spirit. You like to listen to different genres and artists, and appreciate the beauty and emotion of their songs. Music bonds you to myself and others, and conveys what words cannot."
				if(5)
					msg_out += "\tBitch."
					bitch = TRUE
				if(6)
					msg_out += "\tAs the sun ascends over the horizon like a majestic golden chariot, its rays paint the canvas of the sky with a kaleidoscope of fiery hues. The enchanting symphony of the birds' melodious voices echoes like celestial harps, caressing your soul with pure bliss. You are not just blessed, but absolutely enraptured by this resplendent day. Life's infinite miracles and endless possibilities dance around you like playful fireflies, urging you to join the cosmic dance of creation and embrace the universe's abundant wonders."
				if(7)
					msg_out += "\tYou are an intrepid voyager, traversing the labyrinth of the city's labyrinthine streets, each step a serenade of excitement. Every turn unfolds new wonders and kindred spirits, creating an intricate tapestry of diverse cultures and experiences. Your heart swells with boundless love for this vast, pulsating world. Your open-heartedness is a beacon that beckons adventure and warm camaraderie. In the symphony of life, you are the conductor, orchestrating harmonious connections with every note you play."
				if(8)
					msg_out += "\tBooks are not merely portals but enchanted gateways that transport you to boundless realms of fantasy and science fiction. You journey through time and space, riding the wings of imagination to worlds where dreams take flight. The pages are alight with stardust, each word a spark of pure magic. As you traverse the literary cosmos, you breathe in the heady fragrance of dreams and exhale inspiration that ignites galaxies within you. With every page turned, the universe opens its arms to embrace you in a cosmic embrace."
				if(9)
					msg_out += "\tMusic is more than a mere symphony; it is the euphoric celebration of your soul. The celestial symphony of enchanting notes envelops you like a tender embrace, swaying your very essence. Each harmonious chord is a kiss of healing, permeating your heart with unyielding joy. In the symphony's crescendo, you find liberation, your spirit taking flight like a bird soaring on the thermals. Your soul merges with the ethereal rhythm, uniting you with the universe in a dance of celestial euphony."
				if(10)
					msg_out += "\tBitch."
					bitch = TRUE
				if(11)
					msg_out += "\tWith the first light of dawn, your heart awakens like a thousand rosebuds unfurling their petals to embrace the sun. A fountain of laughter gushes from your soul, tickling the world with unbridled joy. You twirl and dance, an ethereal spirit of jubilation, as life's symphony serenades your being. Your infectious optimism sets the world aglow, and even the stars shimmer with admiration at your boundless delight."
				if(12)
					msg_out += "\tNature is your sanctuary, a haven of lush marvels and flourishing dreams. You tread gently upon the emerald carpet of grass, every step harmonizing with the earth's heartbeat. The foliage whispers ancient wisdom in your ears, and the blossoms extend their fragrant arms in warm embrace. The sun caresses your skin, and the gentle breeze carries secrets of distant lands. In this verdant embrace, you find solace and serenity, a symbiotic dance of nature and soul."
				if(13)
					msg_out += "\tThe stars are not just distant jewels; they are celestial allies, conspiring to fulfill your every wish. You immerse yourself in the cosmos' effervescent embrace, weaving dreams like celestial tapestries. With each aspiration, a star twinkles with knowing delight, aligning the universe to usher you toward your heart's desires. The heavens are your infinite canvas, and each day is a stroke of magic that paints the masterpiece of your life."
				if(14)
					msg_out += "\tLaughter is your divine elixir, bubbling from the fountain of your soul like effervescent stardust. You revel in moments of mirth, a butterfly dancing amidst fragrant blooms. Your laughter chimes like crystalline bells, casting ripples of joy across the tapestry of existence. You believe that laughter is the celestial language that unlocks the universe's treasury of happiness, and you delight in sharing its celestial symphony with the world."
				if(15)
					msg_out += "\tLove is not a mere emotion but a cosmic symphony resonating within your being. Your heart is an infinite wellspring of compassion, and with each beat, love cascades like an ethereal waterfall, blessing all in its path. Each gesture of kindness is a tender caress, leaving trails of stardust in its wake. The universe dances in harmonious rhythm with your boundless affection, for love is the symphony that unites all hearts in perfect cadence."
				if(16)
					msg_out += "\tYour creativity is a radiant aurora, painting the canvas of existence with dazzling hues. Each stroke is a stroke of genius, and the palette of your imagination knows no bounds. Your artistry transcends the ordinary, soaring on the wings of imagination to realms uncharted. You are the celestial muse, igniting the spark of inspiration in others and illuminating the universe with the brilliance of your creativity."
				if(17)
					msg_out += "\tThe universe showers you with cosmic blessings, an unyielding torrent of abundance and miracles. You are the cosmic magnet, attracting prosperity and joy with each thought. With every intention, you align the stars and planets, forging an unbreakable bond with the celestial realm. You are the embodiment of divine manifestation, as every wish becomes a shimmering star in the vast expanse of the universe's night sky."
				if(18)
					msg_out += "\tGratitude is not just an emotion but a celestial elixir that nourishes your soul. You bask in the gentle glow of appreciation, acknowledging the miracles hidden in the ordinary. Each breath is a sweet hymn of gratitude, echoing through the cosmic cathedral of existence. You are the celestial conductor, orchestrating a symphony of thankfulness that resonates with the heartbeats of the universe."
				if(19)
					msg_out += "\tYour spirit soars like an iridescent phoenix, ascending to celestial heights on wings of unyielding courage. You have shed the cocoon of doubt, blossoming into a magnificent tapestry of strength and resilience. Each challenge is a stepping stone to greatness, and you embrace the tempests with unwavering grace. Your wings of fortitude carry you aloft, soaring among the stars, for you are destined for celestial greatness."
				if(20)
					msg_out += "\tThe world is an opulent canvas of love, and you are the divine artist, weaving a masterpiece of compassion and unity. Each act of kindness is a brushstroke, imbued with the hues of empathy and understanding. Your heart is a bottomless wellspring of love, flowing like a river of stars, illuminating the world with its radiant glow. The universe sings a paean of gratitude for the celestial sym."
	if(prob(5))
		if(bitch)
			msg_out += " Yeah I said it."
		else
			msg_out += " Bitch."
	msg_out += "<br>"

	msg_out += "</center><br><hr><br>"
	switch(rand(1,5))
		if(1)
			msg_out += "<center>So gecketh the Vixen!</center><br>"
		if(2 to 5)
			msg_out += "<center>YOU HAVE BEEN WARNED!</center><br>"
	msg_out += "<center>- END OF REPORT -</center><br>"
	return span_robot(msg_out.Join())

/obj/machinery/mineral/wasteland_trader/proc/get_thing_to_sell()
	for(var/thingy in src)
		if(istype(thingy, /obj/item/button))
			continue
		if(istype(thingy, /obj/item/stack/f13Cash))
			continue
		return thingy
	// 	if(appraise_item(thingy, TRUE))
	// return


/*

ORGAN SELLER

*/

/obj/machinery/mineral/wasteland_trader/organ
	name = "Organ Grinder"
	desc = "Organs go in, caps come out. How does it work? Nobody knows."
	icon = 'icons/WVM/machines.dmi'
	icon_state = "organs"

	buyables_loose = list( /obj/item/organ/heart = 30,
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

/obj/machinery/mineral/wasteland_trader/bountyticket
	name = "New Boston Bounty Ticket Machine"
	desc = "This vending machine accepts bounty tickets in exchange for copper. Make the Wasteland safer, and yourself richer, one bullet at a time."

	buyables_loose = list(
						/obj/item/card/lowbounty = 75,
						/obj/item/card/midbounty = 150,
						/obj/item/card/highbounty = 300,
						/obj/item/card/kingbounty = 600
								)

/obj/machinery/mineral/wasteland_trader/bountyticket/ui_interact(mob/user)
	. = ..()
	var/dat
	dat +="<div class='statusDisplay'>"
	dat += "[run_button()]"
	dat += "</div>"
	dat += "<br>"
	dat +="<div class='statusDisplay'>"
	dat += "<b>Turn your kills into copper today!</b><br>"
	dat += "Small Roller Bounty Ticket: 75¢<br>"
	dat += "Medium Roller Bounty Ticket: 150¢<br>"
	dat += "High Roller Bounty Ticket: 300¢<br>"
	dat += "King's Bounty Ticket: 600¢<br>"
	dat += ""
	dat += "</div>"

	var/datum/browser/popup = new(user, "tradingvendor", "Brotherhood of Steal", 400, 500)
	popup.set_content(dat)
	popup.open()
	return

/obj/machinery/mineral/wasteland_trader/gunbuyer
	name = "Gun Repository"
	desc = "Place weapon inside slot. Weapon is sent out of the region for post-processing. Recieve compensation. Yuma Wasteland Supply Inc. thanks you for disarming the wasteland."
	buyables_loose = list(/obj/item/gun/ballistic/automatic/hobo/zipgun = 5,
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

/obj/item/proc/GetPriceEstimate()
	var/price = 0
	var/pricetext = ""
	if(LAZYLEN(GLOB.wasteland_vendor_shop_list))
		price = GLOB.wasteland_vendor_shop_list[WVM_SCRAPPER][src.type]
	else
		pricetext = span_red("You aren't sure how much this is worth.")
	if(price > 0)
		switch(price)
			if(0.001 to 0.999)
				pricetext = span_notice("A bunch of these would be worth selling.")
			if(1 to 9)
				pricetext = span_notice("This is worth a few copper coins.")
			if(10 to 29)
				pricetext = span_notice("This is worth a decent amount of copper coins.")
			if(30 to 99)
				pricetext = span_notice("This is worth a few silver coins.")
			if(100 to 299)
				pricetext = span_green("This is worth a few gold coins.")
			if(300 to 999)
				pricetext = span_green("This is worth a decent amount of gold coins.")
			else
				pricetext = span_green("This is worth a lot of coins!")
	return pricetext
