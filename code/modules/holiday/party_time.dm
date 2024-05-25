/// woo party time
/// IF U GET THAT REFERENCE SEND ME A DM ON DISCORD AND I'LL GIVE U A COOKIE
/// (I'm not joking, I will actually give you a cookie)

/// Simple holiday for things celebrated on certain days
/datum/holiday/weekly
	/// Which day(s) of the week this holiday is celebrated on
	var/list/weekdays = list()

/datum/holiday/weekly/shouldCelebrate(dd, mm, yy, ww, ddd)
	var/adjustedDDD = time2text(world.realtime, "DDD", -6) //Fenny doesn't wanna use UTC, but instead Central Standard Time
	return (adjustedDDD in weekdays) // ez

/// A cool lil potluck for subby bottoms to come together and make friends to frick them
/datum/holiday/weekly/potluck
	name = POTLUCK
	weekdays = list(SUNDAY)
	var/zero_hour = 0
	var/all_done
	var/warning_time = 1 MINUTES
	var/warned
	var/sparkles_time = 3 MINUTES
	var/sparkling
	var/pizza_time = 5 MINUTES
	var/pillar_johned

/datum/holiday/weekly/potluck/celebrate()
	. = ..()
	world.TgsTargetedChatBroadcast("<@&1147595783147880568> Come on down for the Coyote Bayou meet, greet, n' eat!  Gather in new folks, won't be so lonely if you're all new together!  Let's get y'all settled in!", FALSE)
	START_PROCESSING(SSevents, src) // I love processing nonprocessing subsystems

/datum/holiday/weekly/potluck/greet()
	return "Something about today feels oddly festive! Might want to hang around town!"

/datum/holiday/weekly/potluck/late_greet()
	return "The air around you starts to feel oddly festive. Might want to hang around town!"

/datum/holiday/weekly/potluck/on_join_game(mob/living/newbie)
	to_chat(newbie, span_greenannounce("Looks like New Boston, Ashdown, and the Den are throwing a party in the bar! Might be a great way to meet some people and make some friends! Or at the very least get some free food!"))

/datum/holiday/weekly/potluck/process()
	if(all_done)
		return // we're done here~
	if(!SSticker.setup_done)
		return
	if(!zero_hour)
		zero_hour = world.time
	if(warned && sparkling && pillar_johned)
		all_done = TRUE
		return
	var/tss = world.time - zero_hour
	if(!warned && tss >= warning_time)
		var/list/partyzones = list()
		for(var/obj/effect/landmark/party/party in GLOB.party_landmarks)
			partyzones += party.get_zone()
		var/msg = "some unknown place"
		if(LAZYLEN(warning_time))
			msg = "[english_list(partyzones)]"
		to_chat(world, span_nicegreen("You feel an otherworldly sense of mirth and togetherness coalescing in [msg]. Huh."))
		warned = TRUE
		return
	if(!sparkling && tss >= sparkles_time)
		to_chat(world, span_nicegreen("Impending meet-n-greet approaches."))
		for(var/obj/effect/landmark/party/party in GLOB.party_landmarks)
			party.start_sparkling()
		sparkling = TRUE
		return
	if(!pillar_johned && tss >= pizza_time)
		pillar_johned = TRUE
		var/list/partyzones = list()
		for(var/obj/effect/landmark/party/party in GLOB.party_landmarks)
			partyzones += party.get_zone()
			party.stop_sparkling()
			party.pizza_time()
		to_chat(world, span_nicegreen("A hefty chunk of someone's potluck materialized within [english_list(partyzones)]! Come check it out, maybe meet some people!"))
		return

GLOBAL_LIST_EMPTY(party_landmarks)

/obj/effect/landmark/party
	name = "party landmark"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x7"
	var/region
	var/sparkle_radius = 4
	
/obj/effect/landmark/party/Initialize(mapload)
	. = ..()
	GLOB.party_landmarks += src

/obj/effect/landmark/party/Destroy()
	GLOB.party_landmarks -= src
	return ..()

/obj/effect/landmark/party/proc/start_sparkling()
	START_PROCESSING(SSprocessing, src)

/obj/effect/landmark/party/proc/stop_sparkling()
	STOP_PROCESSING(SSprocessing, src)

/obj/effect/landmark/party/process()
	var/list/sparkleturf = block(locate(x + sparkle_radius,y + sparkle_radius,z),locate(x - sparkle_radius,y - sparkle_radius,z))
	var/sparkles_left = 5
	for(var/turf/spawrkle in sparkleturf)
		if(!prob(2))
			continue
		do_sparks(rand(1,2), FALSE, spawrkle)
		if(!sparkles_left--)
			return

/obj/effect/landmark/party/proc/get_zone()
	if(!region)
		var/area/A = get_area(src)
		if(!A)
			return "the middle of nowhere (literally)"
		return A.name
	return "[region]"

/obj/effect/landmark/party/proc/pizza_time()
	playsound(src, 'sound/effects/lightning_impact.ogg', 100, TRUE, SOUND_DISTANCE(25))
	if(load())
		return TRUE
	backup_party()

/obj/effect/landmark/party/proc/backup_party()
	new /obj/item/storage/box/party_pouch(get_turf(src))
	new /obj/item/storage/box/party_pouch(get_turf(src))
	new /obj/item/storage/box/party_pouch(get_turf(src))
	new /obj/item/storage/box/party_pouch(get_turf(src))
	new /obj/item/storage/box/party_pouch/drinks(get_turf(src))
	new /obj/item/storage/box/party_pouch/drinks(get_turf(src))
	new /obj/item/storage/box/party_pouch/drinks(get_turf(src))
	new /obj/item/storage/box/party_pouch/drinks(get_turf(src))
	audible_message(src, span_nicegreen("A portal opens up, and some festive stuff falls out of it."))

/obj/effect/landmark/party/proc/load()
	var/turf/T = get_turf(src)
	if(!T)
		return FALSE
	var/template_name = pick(SSmapping.party_templates)
	if(!template_name)
		stack_trace("No party templates found! Please add some to the list in /datum/map_template/ruin/party")
		GLOB.party_landmarks -= src
		qdel(src)
		return FALSE
	var/datum/map_template/template = SSmapping.party_templates[template_name]
	if(!template)
		return FALSE
	for(var/mob/living/seer in range(10, src))
		seer.overlay_fullscreen("flash", type, 2)
		addtimer(CALLBACK(seer, TYPE_PROC_REF(/mob/living,clear_fullscreen), "flash", 25), 2.5 SECONDS)
	for(var/turf/blocker in block(locate(x + template.width*0.5,y + template.height*0.5,z),locate(x - template.width*0.5,y - template.height*0.5,z)))
		for(var/atom/movable/AM in blocker)
			if(!AM.anchored)
				AM.throw_at(get_edge_target_turf(AM, get_dir(src, AM)), 300, 2)
			else
				AM.ex_act(1)
		if(blocker.density)
			blocker.ScrapeAway()
			qdel(blocker)
	testing("Party \"[template_name]\" placed at ([T.x], [T.y], [T.z])")
	template.load(T, centered = TRUE)
	template.loaded++
	GLOB.party_landmarks -= src
	qdel(src)
	return TRUE

/datum/map_template/ruin/party // nobody ruins my parties but me
	prefix = "_maps/party_prefabs/"

/datum/map_template/ruin/party/foodboard
	id = "lunchboard"
	suffix = "pfab_1.dmm"
	name = "Food Board"
	description = "Someones throwing a party! Bring something!"

/datum/map_template/ruin/party/barparts
	id = "barparts"
	suffix = "pfab_2.dmm"
	name = "Bar Board"
	description = "Someones throwing a party! Bring something!"

/// comment these out before merging
// /datum/map_template/ruin/party/debug
// 	id = "potluck"
// 	prefix = "_maps/shuttles/"
// 	suffix = "ferry_fancy.dmm"
// 	name = "Interdimensional Potluck"
// 	description = "Someones throwing a party! Bring something!"

// /datum/map_template/ruin/party/debug2
// 	id = "potluck1"
// 	prefix = "_maps/shuttles/"
// 	suffix = "pahrump_train.dmm"
// 	name = "Interdimensional Potluck"
// 	description = "Someones throwing a party! Bring something!"

// /datum/map_template/ruin/party/debug3
// 	id = "potluck2"
// 	prefix = "_maps/templates/"
// 	suffix = "shelter_1.dmm"
// 	name = "Interdimensional Potluck"
// 	description = "Someones throwing a party! Bring something!"

// /datum/map_template/ruin/party/debug4
// 	id = "potluck3"
// 	prefix = "_maps/templates/"
// 	suffix = "shelter_2.dmm"
// 	name = "Interdimensional Potluck"
// 	description = "Someones throwing a party! Bring something!"

GLOBAL_LIST_INIT(party_food, list(
	/obj/item/reagent_containers/food/snacks/pie/plain,
	/obj/item/reagent_containers/food/snacks/pie/berryclafoutis,
	/obj/item/reagent_containers/food/snacks/pie/bearypie,
	/obj/item/reagent_containers/food/snacks/pie/burek,
	/obj/item/reagent_containers/food/snacks/friedegg,
	/obj/item/reagent_containers/food/snacks/waffles,
	/obj/item/reagent_containers/food/snacks/pie/meatpie,
	/obj/item/reagent_containers/food/snacks/pancakes/blueberry,
	/obj/item/reagent_containers/food/snacks/meat/steak/chicken,
	/obj/item/reagent_containers/food/snacks/scotchegg,
	/obj/item/reagent_containers/food/snacks/loadedbakedpotato,
	/obj/item/reagent_containers/food/snacks/meat/cutlet/chicken,
	/obj/item/reagent_containers/food/snacks/salad/potato_salad,
	/obj/item/reagent_containers/food/condiment/bbqsauce,
	/obj/item/reagent_containers/food/snacks/butterbiscuit,
	/obj/item/reagent_containers/food/snacks/butteredpotato,
	/obj/item/reagent_containers/food/snacks/pie/shepherds_pie,
	/obj/item/reagent_containers/food/snacks/bbqribs,
	/obj/item/reagent_containers/food/snacks/mashedpotato,
	/obj/item/reagent_containers/food/snacks/meat/steak,
	/obj/item/reagent_containers/food/snacks/pie/peachpie,
	/obj/item/reagent_containers/food/snacks/pie/applepie,
	/obj/item/reagent_containers/food/snacks/meat/slab,
	/obj/item/reagent_containers/glass/beaker/jar,
	/obj/item/reagent_containers/glass/bottle/sugar,
	/obj/item/reagent_containers/food/drinks/bottle/lemonjuice,
	/obj/item/reagent_containers/food/drinks/bottle/instatea,
))

GLOBAL_LIST_INIT(party_drinks, subtypesof(/obj/item/reagent_containers/food/drinks/bottle))

/// basket!
/obj/item/storage/box/party_pouch
	name = "Party Pouch"
	desc = "A festive lil pouch full of tasty treats! Or whatever someone decided to put in it."
	icon = 'icons/obj/storage.dmi'
	icon_state = "paperbag_SmileyFace"
	item_state = "paperbag_None"
	resistance_flags = FLAMMABLE
	foldable = null

/obj/item/storage/box/party_pouch/PopulateContents()
	. = ..()
	for(var/i in 1 to 7)
		var/obj/item/food = pick(GLOB.party_food)
		if(!food)
			continue
		new food(src)

/obj/item/storage/box/party_pouch/update_icon_state()
	if(contents.len == 0)
		icon_state = "[initial(icon_state)]"
	else
		icon_state = "[initial(icon_state)]_closed"

/obj/item/storage/box/party_pouch/drinks
	name = "Party Punch"
	desc = "A festive lil pouch full of tasty drinks! Or something along those lines."
	icon_state = "paperbag_Heart"

/obj/item/storage/box/party_pouch/PopulateContents()
	. = ..()
	for(var/i in 1 to 7)
		var/obj/item/drink = pick(GLOB.party_drinks)
		if(!drink)
			continue
		new drink(src)

