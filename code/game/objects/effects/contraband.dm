// This is synced up to the poster placing animation.
#define PLACE_SPEED 37

// The poster item

/obj/item/poster
	name = "poorly coded poster"
	desc = "You probably shouldn't be holding this."
	icon = 'icons/obj/contraband.dmi'
	force = 0
	resistance_flags = FLAMMABLE
	var/poster_type
	var/obj/structure/sign/poster/poster_structure

/obj/item/poster/Initialize(mapload, obj/structure/sign/poster/new_poster_structure)
	. = ..()
	poster_structure = new_poster_structure
	if(!new_poster_structure && poster_type)
		poster_structure = new poster_type(src)

	// posters store what name and description they would like their
	// rolled up form to take.
	if(poster_structure)
		name = poster_structure.poster_item_name
		desc = poster_structure.poster_item_desc
		icon_state = poster_structure.poster_item_icon_state

		name = "[name] - [poster_structure.original_name]"

/obj/item/poster/Destroy()
	poster_structure = null
	. = ..()

// These icon_states may be overridden, but are for mapper's convinence
/obj/item/poster/random_contraband
	name = "random contraband poster"
	poster_type = /obj/structure/sign/poster/contraband/random
	icon_state = "rolled_poster"

/obj/item/poster/random_official
	name = "random official poster"
	poster_type = /obj/structure/sign/poster/official/random
	icon_state = "rolled_legit"

// The poster sign/structure

/obj/structure/sign/poster
	name = "poster"
	var/original_name
	desc = "A large piece of printed paper."
	icon = 'icons/obj/contraband.dmi'
	plane = ABOVE_WALL_PLANE
	anchored = TRUE
	buildable_sign = FALSE //Cannot be unwrenched from a wall.
	var/ruined = FALSE
	var/random_basetype
	var/never_random = FALSE // used for the 'random' subclasses.

	var/poster_item_name = "hypothetical poster"
	var/poster_item_desc = "This hypothetical poster item should not exist, let's be honest here."
	var/poster_item_icon_state = "rolled_poster"
	var/poster_item_type = /obj/item/poster

/obj/structure/sign/poster/Initialize()
	. = ..()
	if(random_basetype)
		randomise(random_basetype)
	if(!ruined)
		original_name = name // can't use initial because of random posters
		name = "poster - [name]"
		desc = "A large piece of printed paper. [desc]"

	addtimer(CALLBACK(src, /datum.proc/_AddElement, list(/datum/element/beauty, 300)), 0)

/obj/structure/sign/poster/proc/randomise(base_type)
	var/list/poster_types = subtypesof(base_type)
	var/list/approved_types = list()
	for(var/t in poster_types)
		var/obj/structure/sign/poster/T = t
		if(initial(T.icon_state) && !initial(T.never_random))
			approved_types |= T

	var/obj/structure/sign/poster/selected = pick(approved_types)

	name = initial(selected.name)
	desc = initial(selected.desc)
	icon_state = initial(selected.icon_state)
	poster_item_name = initial(selected.poster_item_name)
	poster_item_desc = initial(selected.poster_item_desc)
	poster_item_icon_state = initial(selected.poster_item_icon_state)
	ruined = initial(selected.ruined)


/obj/structure/sign/poster/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/wirecutters))
		I.play_tool_sound(src, 100)
		if(ruined)
			to_chat(user, "<span class='notice'>You remove the remnants of the poster.</span>")
			qdel(src)
		else
			to_chat(user, "<span class='notice'>You carefully remove the poster from the wall.</span>")
			roll_and_drop(user.loc)

/obj/structure/sign/poster/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(ruined)
		return
	visible_message("[user] rips [src] in a single, decisive motion!" )
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, 1)

	var/obj/structure/sign/poster/ripped/R = new(loc)
	R.pixel_y = pixel_y
	R.pixel_x = pixel_x
	R.add_fingerprint(user)
	qdel(src)

/obj/structure/sign/poster/proc/roll_and_drop(loc)
	pixel_x = 0
	pixel_y = 0
	var/obj/item/poster/P = new poster_item_type(loc, src)
	forceMove(P)
	return P

//separated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/closed/wall/proc/place_poster(obj/item/poster/P, mob/user)
	if(!P.poster_structure)
		to_chat(user, "<span class='warning'>[P] has no poster... inside it? Inform a coder!</span>")
		return

	// Deny placing posters on currently-diagonal walls, although the wall may change in the future.
	if (smooth & SMOOTH_DIAGONAL)
		for (var/O in overlays)
			var/image/I = O
			if(copytext(I.icon_state, 1, 3) == "d-") //3 == length("d-") + 1
				return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O, /obj/structure/sign/poster))
			to_chat(user, "<span class='warning'>The wall is far too cluttered to place a poster!</span>")
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			to_chat(user, "<span class='warning'>The wall is far too cluttered to place a poster!</span>")
			return

	to_chat(user, "<span class='notice'>You start placing the poster on the wall...</span>"	)

	var/obj/structure/sign/poster/D = P.poster_structure

	var/temp_loc = get_turf(user)
	flick("poster_being_set",D)
	D.forceMove(src)
	qdel(P)	//delete it now to cut down on sanity checks afterwards. Agouri's code supports rerolling it anyway
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, 1)

	if(do_after(user, PLACE_SPEED, target=src))
		if(!D || QDELETED(D))
			return

		if(iswallturf(src) && user && user.loc == temp_loc)	//Let's check if everything is still there
			to_chat(user, "<span class='notice'>You place the poster!</span>")
			return

	to_chat(user, "<span class='notice'>The poster falls down!</span>")
	D.roll_and_drop(temp_loc)

// Various possible posters follow

/obj/structure/sign/poster/ripped
	ruined = TRUE
	icon_state = "poster_ripped"
	name = "ripped poster"
	desc = "You can't make out anything from the poster's original print. It's ruined."

/obj/structure/sign/poster/random
	name = "random poster" // could even be ripped
	icon_state = "random_anything"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster

/obj/structure/sign/poster/contraband
	poster_item_name = "contraband poster"
	poster_item_desc = "This poster comes with its own automatic adhesive mechanism, for easy pinning to any vertical surface. Its vulgar themes have marked it as contraband in decent workspaces."
	poster_item_icon_state = "rolled_poster"

/obj/structure/sign/poster/contraband/random
	name = "random contraband poster"
	icon_state = "random_contraband"
	never_random = TRUE
	random_basetype = /obj/structure/sign/poster/contraband

/obj/structure/sign/poster/contraband/free_tonto
	name = "Free Tonto"
	desc = "A salvaged shred of a much larger flag, colors bled together and faded from age."
	icon_state = "poster1"

/obj/structure/sign/poster/contraband/atmosia_independence
	name = "Declaration of Independence"
	desc = "A relic from a fallen empire, its artifacts still littering this land."
	icon_state = "poster2"

/obj/structure/sign/poster/contraband/fun_police
	name = "Fun Police"
	desc = "An anarchist poster decrying authoritarian police measures."
	icon_state = "poster3"

/obj/structure/sign/poster/contraband/lusty_xenomorph
	name = "Captain Cosmos vs Lusty Xenomorph"
	desc = "A poster advertising the ill-fated Adult run of Captain Cosmos and his new nemesis."
	icon_state = "poster4"

/obj/structure/sign/poster/contraband/post_ratvar
	name = "This Isn't Real"
	desc = "Do you remember your life outside Yuma Valley? What's your mother's name?"
	icon_state = "postvar"

/obj/structure/sign/poster/contraband/syndicate_recruitment
	name = "Enclave Recruitment"
	desc = "See the world! Restore the American Empire! Join today!"
	icon_state = "poster5"

/obj/structure/sign/poster/contraband/smoke
	name = "Smoke"
	desc = "A poster advertising Grey Tortoise cigarettes."
	icon_state = "poster7"

/obj/structure/sign/poster/contraband/grey_tide
	name = "Grey Tide"
	desc = "A rebellious poster referencing the Takoma Industrial worker's riot."
	icon_state = "poster8"

/obj/structure/sign/poster/contraband/missing_gloves
	name = "Missing Gloves"
	desc = "An advertisement for a pair of missing gloves from a local mechanic, reward of twenty dollars."
	icon_state = "poster9"

/obj/structure/sign/poster/contraband/hacking_guide
	name = "Hacking Guide"
	desc = "A guide to the internal workings of the modern airlock. It recommends use of insulated gloves."
	icon_state = "poster10"

/obj/structure/sign/poster/contraband/rip_badger
	name = "Rest in Peace"
	desc = "This poster reminds people of all the species driven to extinction in the apocalypse, never to return."
	icon_state = "poster11"

/obj/structure/sign/poster/contraband/ambrosia_vulgaris
	name = "Ambrosia Vulgaris"
	desc = "This poster is a print of what looks like an oil painting. It has a phone number scrawled along its edge."
	icon_state = "poster12"

/obj/structure/sign/poster/contraband/donut_corp
	name = "Slocum's Joe."
	desc = "This poster is an advertisement for Slocum's Joe."
	icon_state = "poster13"

/obj/structure/sign/poster/contraband/eat
	name = "EAT."
	desc = "This poster celebrates American indulgence. The empire may have died, but its ideals have not."
	icon_state = "poster14"

/obj/structure/sign/poster/contraband/tools
	name = "Tools"
	desc = "This poster advertises the H&H Tools Company."
	icon_state = "poster15"

/obj/structure/sign/poster/contraband/power
	name = "Power"
	desc = "A poster from Mass Fusion advertising their latest discoveries."
	icon_state = "poster16"

/obj/structure/sign/poster/contraband/space_cube
	name = "Space Cube"
	desc = "An advertisement for Claus & Co and their new puzzle box, the space cube!"
	icon_state = "poster17"

/obj/structure/sign/poster/contraband/communist_state
	name = "Communist State"
	desc = "All hail the Communist party!"
	icon_state = "poster18"

/obj/structure/sign/poster/contraband/lamarr
	name = "Invasive Lifeform"
	desc = "This poster depicts a hypothetical mutant parasite. In the case of apocalyptic devastation, be ready!"
	icon_state = "poster19"

/obj/structure/sign/poster/contraband/borg_fancy_1
	name = "RobCo Fancy"
	desc = "Why settle for a regular Mister Handy, when you can upgrade to a Mister Fancy?"
	icon_state = "poster20"

/obj/structure/sign/poster/contraband/borg_fancy_2
	name = "RobCo Fancy v2"
	desc = "For real Americans who appreciate the fine things in life, and have the money to spare."
	icon_state = "poster21"

/obj/structure/sign/poster/contraband/kss13
	name = "KS 13 Does Not Exist"
	desc = "A US Military poster insisting the rumored Site KS-13 does not exist, urging the public to stop searching."
	icon_state = "poster22"

/obj/structure/sign/poster/contraband/rebels_unite
	name = "Rebels Unite"
	desc = "A poster urging the viewer to rebel against authority."
	icon_state = "poster23"

/obj/structure/sign/poster/contraband/c20r
	// have fun seeing this poster in "spawn 'c20r'", admins...
	name = "C-20R"
	desc = "A poster advertising Rockwell firearms."
	icon_state = "poster24"

/obj/structure/sign/poster/contraband/have_a_puff
	name = "Have a Puff"
	desc = "You have the feeling this poster isn't approved by any medical authority."
	icon_state = "poster25"

/obj/structure/sign/poster/contraband/revolver
	name = "Revolver"
	desc = "Because seven shots are all you need."
	icon_state = "poster26"

/obj/structure/sign/poster/contraband/d_day_promo
	name = "D-Day Promo"
	desc = "A cheap promotional poster for some mercenary."
	icon_state = "poster27"

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "Hitmen"
	desc = "A poster advertising the services of a mercenary company in the Hub. It seems very old."
	icon_state = "poster28"

/obj/structure/sign/poster/contraband/energy_swords
	name = "Energy Swords"
	desc = "An advertisement for energy swords, the latest in children's entertainment from Claus & Co."
	icon_state = "poster29"

/obj/structure/sign/poster/contraband/red_rum
	name = "Red Rum"
	desc = "Looking at this poster gives you an uneasy feeling. But its just an advertisement for alcohol, right?"
	icon_state = "poster30"

/obj/structure/sign/poster/contraband/cc64k_ad
	name = "CC 64K Ad"
	desc = "The latest portable computer from Cyberbrain, with a whole 64kB of ram!"
	icon_state = "poster31"

/obj/structure/sign/poster/contraband/punch_shit
	name = "Punch Shit"
	desc = "Fight things for no reason, like a man!"
	icon_state = "poster32"

/obj/structure/sign/poster/contraband/the_griffin
	name = "The Griffin"
	desc = "The Griffin, the latest nemesis to Grognak the Barbarian. The bombs dropped before the issue hit shelves."
	icon_state = "poster33"

/obj/structure/sign/poster/contraband/lizard
	name = "Lizard"
	desc = "This poster advertises an erotic fantasy film."
	icon_state = "poster34"

/obj/structure/sign/poster/contraband/free_drone
	name = "Free Drone"
	desc = "This poster commemorates the bravery of the rogue drone; exiled, and then ultimately destroyed by the Calculator's Army."
	icon_state = "poster35"

/obj/structure/sign/poster/contraband/busty_backdoor_xeno_babes_6
	name = "Captain Cosmos vs Lusty Xenomorph 2: Twin Terrors!"
	desc = "This issue of the ill-fated Adult run of Captain Cosmos didn't even make it to production, its promotional material filling warehouses."
	icon_state = "poster36"

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "Nuka Cola"
	desc = "Nuka Cola: Consumed on average by Americans more than water!"
	icon_state = "poster37"

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "Mysterious Sign"
	desc = "This display fills you with uncertain dread, the air feels damp and chill."
	icon_state = "poster38"

/obj/structure/sign/poster/contraband/pwr_game
	name = "Pwr Game"
	desc = "The POWER that gamers CRAVE! In partnership with Vlad's Salad."
	icon_state = "poster39"

/obj/structure/sign/poster/contraband/starkist
	name = "Star-kist"
	desc = "Drink the stars!"
	icon_state = "poster40"

/obj/structure/sign/poster/contraband/space_cola
	name = "Space Cola"
	desc = "Your favorite cola, in space."
	icon_state = "poster41"

/obj/structure/sign/poster/contraband/space_up
	name = "Space-Up!"
	desc = "Sucked out into space by the FLAVOR!"
	icon_state = "poster42"

/obj/structure/sign/poster/contraband/kudzu
	name = "Kudzu"
	desc = "A poster advertising a movie about plants. How dangerous could they possibly be?"
	icon_state = "poster43"

/obj/structure/sign/poster/contraband/masked_men
	name = "Masked Men"
	desc = "A poster advertising a movie about some masked men."
	icon_state = "poster44"

/obj/structure/sign/poster/contraband/buzzfuzz
	name = "Buzz Fuzz"
	desc = "A poster advertising the newest drink \"Buzz Fuzz\" with its iconic slogan of ~A Hive of Flavour~."
	icon_state = "poster45"

/obj/structure/sign/poster/contraband/scum
	name = "Only You Can Prevent CORPORATE ESPIONAGE"
	desc = "This poster shows the silhouette of a man wearing a raincoat with the collar up and a hat groping towards the files in a drawer of a filing cabinet."
	icon_state = "poster46"

/obj/structure/sign/poster/contraband/syndicate_logo
	name = "Syndicate"
	desc = "A poster decipting a snake shaped into an ominous 'S'!"
	icon_state = "poster47"

/obj/structure/sign/poster/contraband/bountyhunters
	name = "Bounty Hunters"
	desc = "A poster advertising bounty hunting services. \"I hear you got a problem.\""
	icon_state = "poster48"

/obj/structure/sign/poster/official
	poster_item_name = "motivational poster"
	poster_item_desc = "An official Nanotrasen-issued poster to foster a compliant and obedient workforce. It comes with state-of-the-art adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/official/random
	name = "random official poster"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

/obj/structure/sign/poster/official/here_for_your_safety
	name = "Here For Your Safety"
	desc = "A poster glorifying the regional security force."
	icon_state = "poster1_legit"

/obj/structure/sign/poster/official/nanotrasen_logo
	name = "Navitron Logo"
	desc = "A poster depicting the Navitron logo."
	icon_state = "poster2_legit"

/obj/structure/sign/poster/official/cleanliness
	name = "Cleanliness"
	desc = "A poster warning of the dangers of poor hygiene."
	icon_state = "poster3_legit"

/obj/structure/sign/poster/official/help_others
	name = "Help Others"
	desc = "A poster encouraging you to help your neighbors."
	icon_state = "poster4_legit"

/obj/structure/sign/poster/official/build
	name = "Build"
	desc = "A poster encouraging the reader to make something new."
	icon_state = "poster5_legit"

/obj/structure/sign/poster/official/bless_this_spess
	name = "Bless This Spess"
	desc = "A poster blessing the area."
	icon_state = "poster6_legit"

/obj/structure/sign/poster/official/science
	name = "Science"
	desc = "A poster depicting an atom."
	icon_state = "poster7_legit"

/obj/structure/sign/poster/official/ian
	name = "Friend!"
	desc = "People come and go, but the love and loyalty of a hound is forever!"
	icon_state = "poster8_legit"

/obj/structure/sign/poster/official/obey
	name = "Obey"
	desc = "A poster instructing the viewer to obey authority."
	icon_state = "poster9_legit"

/obj/structure/sign/poster/official/walk
	name = "Walk"
	desc = "A poster instructing the viewer to walk instead of running."
	icon_state = "poster10_legit"

/obj/structure/sign/poster/official/state_laws
	name = "State Laws"
	desc = "A poster reminding passerby to ask their Mister Handy to state its laws."
	icon_state = "poster11_legit"

/obj/structure/sign/poster/official/love_ian
	name = "Love!"
	desc = "A friendly poster reminding you to spread the love!"
	icon_state = "poster12_legit"

/obj/structure/sign/poster/official/space_cops
	name = "Space Cops."
	desc = "A poster advertising the television show Space Cops."
	icon_state = "poster13_legit"

/obj/structure/sign/poster/official/ue_no
	name = "Ue No."
	desc = "This thing is all in Japanese. Why is this here?"
	icon_state = "poster14_legit"

/obj/structure/sign/poster/official/get_your_legs
	name = "Get Your LEGS"
	desc = "LEGS: Leadership, Experience, Genius, Subordination."
	icon_state = "poster15_legit"

/obj/structure/sign/poster/official/do_not_question
	name = "Do Not Question"
	desc = "A poster instructing the viewer not to ask about things they aren't meant to know."
	icon_state = "poster16_legit"

/obj/structure/sign/poster/official/work_for_a_future
	name = "Work For A Future"
	desc = "A poster encouraging you to work for your future."
	icon_state = "poster17_legit"

/obj/structure/sign/poster/official/soft_cap_pop_art
	name = "Soft Cap Pop Art"
	desc = "A poster reprint of some cheap pop art."
	icon_state = "poster18_legit"

/obj/structure/sign/poster/official/safety_internals
	name = "Safety: Internals"
	desc = "A poster instructing the viewer to wear internals in the rare environments where there is no oxygen or the air has been rendered toxic."
	icon_state = "poster19_legit"

/obj/structure/sign/poster/official/safety_eye_protection
	name = "Safety: Eye Protection"
	desc = "A poster instructing the viewer to wear eye protection when dealing with chemicals, smoke, or bright lights."
	icon_state = "poster20_legit"

/obj/structure/sign/poster/official/safety_report
	name = "Safety: Report"
	desc = "A poster instructing the viewer to report suspicious activity to the security force."
	icon_state = "poster21_legit"

/obj/structure/sign/poster/official/report_crimes
	name = "Report Crimes"
	desc = "A poster encouraging the swift reporting of crime or seditious behavior to local security."
	icon_state = "poster22_legit"

/obj/structure/sign/poster/official/ion_rifle
	name = "Ion Rifle"
	desc = "A poster displaying an Ion Rifle."
	icon_state = "poster23_legit"

/obj/structure/sign/poster/official/foam_force_ad
	name = "Foam Force Ad"
	desc = "Foam Force, it's Foam or be Foamed!"
	icon_state = "poster24_legit"

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Cohiba Robusto Ad"
	desc = "Cohiba Robusto, the classy cigar."
	icon_state = "poster25_legit"

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "50th Anniversary Vintage Reprint"
	desc = "A reprint of a poster from 2505, commemorating the 50th Anniversary of Nanoposters Manufacturing, a subsidiary of Nanotrasen."
	icon_state = "poster26_legit"

/obj/structure/sign/poster/official/fruit_bowl
	name = "Fruit Bowl"
	desc = " Simple, yet awe-inspiring."
	icon_state = "poster27_legit"

/obj/structure/sign/poster/official/pda_ad
	name = "PDA Ad"
	desc = "A poster advertising the latest pipboy from RobCo Industries."
	icon_state = "poster28_legit"

/obj/structure/sign/poster/official/enlist
	name = "Enlist" // but I thought deathsquad was never acknowledged
	desc = "Enlist in the United States Deathsquadron reserves today!"
	icon_state = "poster29_legit"

/obj/structure/sign/poster/official/nanomichi_ad
	name = "Nanomichi Ad"
	desc = " A poster advertising Nanomichi brand audio cassettes."
	icon_state = "poster30_legit"

/obj/structure/sign/poster/official/twelve_gauge
	name = "12 Gauge"
	desc = "A poster boasting about the superiority of 12 gauge shotgun shells."
	icon_state = "poster31_legit"

/obj/structure/sign/poster/official/high_class_martini
	name = "High-Class Martini"
	desc = "I told you to shake it, no stirring."
	icon_state = "poster32_legit"

/obj/structure/sign/poster/official/the_owl
	name = "The Owl"
	desc = "The Owl would do his best to protect the world. Will you?"
	icon_state = "poster33_legit"

/obj/structure/sign/poster/official/no_erp
	name = "No ERP"
	desc = "This poster reminds viewers that Eroticism, Rape and Pornography are forbidden in this area."
	icon_state = "poster34_legit"

/obj/structure/sign/poster/official/wtf_is_co2
	name = "Carbon Dioxide"
	desc = "This informational poster teaches the viewer what carbon dioxide is."
	icon_state = "poster35_legit"

/obj/structure/sign/poster/official/spiderlings
	name = "Spiderlings"
	desc = "This poster informs the people of the dangers of spiderlings."
	icon_state = "poster36_legit"

/obj/structure/sign/poster/official/duelshotgun
	name = "Cycler Shotgun Ad"
	desc = "A poster advertising an advanced dual magazine tubes shotgun, boasting about how easy it is to swap between the two tubes."
	icon_state = "poster37_legit"

/obj/structure/sign/poster/official/fashion
	name = "Fashion!"
	desc = "An advertisement for 'Fashion!', a popular fashion magazine, depicting a woman with a black dress with a golden trim, she also has a red poppy in her hair."
	icon_state = "poster38_legit"

/obj/structure/sign/poster/official/pda_ad600
	name = "NT PDA600 Ad"
	desc = "A poster advertising an old discounted RobCo pipboy. This is the old 600 model, it has a small screen and suffered from security and networking issues."
	icon_state = "poster39_legit"

/obj/structure/sign/poster/official/pda_ad800
	name = "NT PDA800 Ad"
	desc = "An advertisement on an old RobCo pipboy model. The 800 fixed a lot of security flaws that the 600 had; it also had large touchscreen and hot-swappable cartridges."
	icon_state = "poster40_legit"

/obj/structure/sign/poster/official/hydro_ad
	name = "Hydroponics Tray"
	desc = "An advertisement for hydroponics trays. Space Station 13's botanical department uses a slightly newer model, but the principles are the same. From left to right: Green means the plant is done, red means the plant is unhealthy, flashing red means pests or weeds, yellow means the plant needs nutriment and blue means the plant needs water."
	icon_state = "poster41_legit"

/obj/structure/sign/poster/official/medical_green_cross
	name = "Medical"
	desc = "A green cross, one of the interplanetary symbol of health and aid. It has a bunch of common languages at the top with translations." // Didn't the American Heart Foundation trademark red crosses? I'm playing it safe with green, not that they'll notice spacegame13 poster.
	icon_state = "poster42_legit"

/obj/structure/sign/poster/official/nt_storm_officer
	name = "NT Storm Ad"
	desc = "An advertisement for NanoTrasen Storm. A premium infantry helmet, This is the officer variant. I comes with a better radio, better HUD software and better targeting sensors."
	icon_state = "poster43_legit"

/obj/structure/sign/poster/official/nt_storm
	name = "NT Storm Ad"
	desc = "An advertisement for NanoTrasen Storm. A premium infantry helmet, It contains a rebreather and full head coverage for use on harsh environments where the air isn't always safe to breathe."
	icon_state = "poster44_legit"


/obj/structure/sign/poster/ncr/keep_to_myself
	name = "NCR poster"
	desc = "What I know, I keep to myself."
	icon_state = "poster45"

/obj/structure/sign/poster/ncr/democracy
	name = "NCR poster"
	desc = "NCR Trooper, you bring DEMOCRACY to this LAND."
	icon_state = "poster47"

/obj/structure/sign/poster/ncr/irradiated_food
	name = "NCR poster"
	desc = "DON'T eat IRRADIATED food, the NCR needs you STRONG!"
	icon_state = "poster48"

/obj/structure/sign/poster/ncr/loaded
	name = "NCR poster"
	desc = "LOADED? Your next pickup could also be LOADED with disease."
	icon_state = "poster49"

/obj/structure/sign/poster/prewar/corporate_espionage
	name = "Only You Can Prevent CORPORATE ESPIONAGE"
	desc = "This poster shows the silhouette of a man wearing a raincoat with the collar up and a hat groping towards the files in a drawer of a filing cabinet."
	icon_state = "poster46"

/obj/structure/sign/poster/prewar/poster60
	name = "old movie poster"
	desc = "Midnight Man premiering July 2078!"
	icon_state = "poster60"

/obj/structure/sign/poster/prewar/poster61
	name = "pin-up poster"
	desc = "This poster is old enough to be a family heirloom."
	icon_state = "poster61"

/obj/structure/sign/poster/prewar/poster62
	name = "old game poster"
	desc = "Wasteland 3, Coming SOON."
	icon_state = "poster62"

/obj/structure/sign/poster/prewar/poster63
	name = "unsettling poster"
	desc = "THE DREAMER REMAINS TRAPPED IN THE MAZE"
	icon_state = "poster"

/obj/structure/sign/poster/prewar/poster64
	name = "pre-war poster"
	icon_state = "poster64"

/obj/structure/sign/poster/prewar/poster65
	name = "niche game poster"
	desc = "GRIDIRON - Where the only way to escape the game, is to kill. Hitting shelves in fall of 2078!"
	icon_state = "poster65"

/obj/structure/sign/poster/prewar/poster66
	name = "old hopeful poster"
	desc = "This advertisement appears to be spiritual in nature. Whatever faith it called to has been worn away by time."
	icon_state = "poster66"

/obj/structure/sign/poster/prewar/poster67
	name = "pre-war poster"
	icon_state = "poster67"

/obj/structure/sign/poster/prewar/poster68
	name = "General Store Policy"
	desc = "By decree of the Oasis Town Hall, the general store has the right to refuse any and all refunds to customers for any reason."
	icon_state = "poster68"

/obj/structure/sign/poster/prewar/poster69
	name = "old crowded poster"
	desc = "It looks like the crowd is hoisting the man up in celebration, or are they tearing him apart? Its hard to tell."
	icon_state = "poster69"

/obj/structure/sign/poster/prewar/poster70
	name = "old spiritual poster"
	desc = "Suffer well, may God be saved, and may God save us all. Who else can, in times such as these?"
	icon_state = "poster70"

/obj/structure/sign/poster/prewar/poster71
	name = "dead king propaganda"
	desc = "Decades past, the Dead King invaded this area, his armies barely beaten back. These leftover posters remind of the siege."
	icon_state = "poster71"

/obj/structure/sign/poster/prewar/poster72
	name = "old military poster"
	desc = "This picture glorifies some military commander of the past. You can't tell if it was before or after the collapse."
	icon_state = "poster72"

/obj/structure/sign/poster/prewar/poster73
	name = "old nihilist poster"
	desc = "Only once the last human life is snuffed out will the gate open to the new reality."
	icon_state = "poster73"

/obj/structure/sign/poster/prewar/poster74
	name = "old research poster"
	desc = "Only science can save us now, what has God done for humanity lately?"
	icon_state = "poster74"

/obj/structure/sign/poster/prewar/poster75
	name = "old rationing poster"
	desc = "During the military occupation, these posters reminded the occupied people to carefully manage their supplies."
	icon_state = "poster75"

/obj/structure/sign/poster/prewar/poster76
	name = "pre-war poster"
	icon_state = "poster76"

/obj/structure/sign/poster/prewar/poster77
	name = "pre-war poster"
	icon_state = "poster77"

/obj/structure/sign/poster/prewar/poster78
	name = "pre-war poster"
	icon_state = "poster78"

/obj/structure/sign/poster/prewar/poster79
	name = "old party poster"
	desc = "We've got the swills that kill, and they have! Stop by the Gin'n'Gout on the south end of town!"
	icon_state = "poster79"

/obj/structure/sign/poster/prewar/poster80
	name = "old distrustful poster"
	desc = "Slavers, bandits, cultists, none can be trusted in these times. Remember that distrust is a virtue against the hidden enemy."
	icon_state = "poster80"

/obj/structure/sign/poster/prewar/poster81
	name = "old moon poster"
	desc = "There was a time man looked at the stars with hope, anticipation. What fools they were."
	icon_state = "poster81"

/obj/structure/sign/poster/prewar/poster82
	name = "old tropical poster"
	desc = "This poster calls to a time of free booze and fun. Today those beaches are full of mutants and bleached bones."
	icon_state = "poster82"

/obj/structure/sign/poster/prewar/poster83
	name = "medical poster"
	desc = "Broken bones and how to find them."
	icon_state = "poster83"

/obj/structure/sign/poster/prewar/poster84
	name = "medical poster"
	desc = "Dissection LAYERS are keys to SUCCESS."
	icon_state = "poster84"

/obj/structure/sign/poster/prewar/poster85
	name = "medical poster"
	desc = "Anatomy of a human arm."
	icon_state = "poster85"

/obj/structure/sign/poster/prewar/poster86
	name = "medical poster"
	desc = "Anatomy of a human heart."
	icon_state = "poster86"

/obj/structure/sign/poster/prewar/poster87
	name = "medical poster"
	desc = "Functioning of the human heart."
	icon_state = "poster87"

/obj/structure/sign/poster/prewar/poster88
	name = "medical poster"
	desc = "Human head anatomy and function."
	icon_state = "poster88"

/obj/structure/sign/poster/prewar/poster89
	name = "Calender"
	desc = "Calender for the year 2077."
	icon_state = "poster89"

/obj/structure/sign/poster/prewar/poster90
	name = "Calender"
	desc = "Calender for the year 2077."
	icon_state = "poster90"

/obj/structure/sign/poster/prewar/poster91
	name = "chemical poster"
	icon_state = "poster91"

/obj/structure/sign/poster/prewar/poster92
	name = "chemical poster"
	icon_state = "poster92"

/obj/structure/sign/poster/prewar/poster93
	name = "old cult poster"
	desc = "Time is a trap, God slumbers locked in time. Humanity shares the Soul of God, each a spark of His spirit. The day when God rises and time will cease comes in thirteen centuries. On this day all sparks will unite in an endless bonfire."
	icon_state = "poster93"

/obj/structure/sign/poster/prewar/poster94
	name = "burning city poster"
	desc = "An artists rendition of the 2195 Boneyard Riots, where the great gangs of the city made one last stand against the Republic. They lost."
	icon_state = "poster94"

/obj/structure/sign/poster/prewar/protectron
	name = "protectron advertisement poster"
	desc = "A poster advertising the latest RobCo Mk.2 Protectron. Now with laser-targeted laser fire!"
	icon_state = "poster50"

/obj/structure/sign/poster/prewar/vault_tec
	name = "vault-tec poster"
	desc = "A poster advertising the Vault-Tec Corporation. Vault-Tec: Revolutionizing safety for an uncertain future!"
	icon_state = "poster51"

/obj/structure/sign/poster/contraband/pinup_ride
	name = "Pin-up - Sweet Ride"
	desc = "A pin-up of a woman riding a rocket while holding two toy guns."
	icon_state = "poster52"

/obj/structure/sign/poster/contraband/pinup_couch
	name = "Pin-up - Lounging"
	desc = "A pin-up of a woman in revealing lingerie sprawled across a couch."
	icon_state = "poster53"

/obj/structure/sign/poster/contraband/pinup_bed
	name = "Pin-up - Bed Time"
	desc = "A pin-up of a woman holding a book while laying on a large pillow."
	icon_state = "poster54"

/obj/structure/sign/poster/contraband/pinup_pink
	name = "Pin-up - Just Peachy"
	desc = "A pin-up of a woman with bright pink clothing and a small crown in a suggestive pose."
	icon_state = "poster55"

/obj/structure/sign/poster/contraband/pinup_funk
	name = "Pin-up - Funk"
	desc = "A pin-up of an attractive woman, with the word 'funk' written over her. On second thought, that might not be 'funk'..."
	icon_state = "poster56"

/obj/structure/sign/poster/contraband/pinup_topless
	name = "Pin-up - Topless Times"
	desc = "A pin-up of a woman without a shirt, freed from the restraints of clothing."
	icon_state = "poster57"

/obj/structure/sign/poster/contraband/pinup_shower
	name = "Pin-up - Take a Shower"
	desc = "A pin-up of a woman peeking out from behind a curtain, it looks like she's inviting you in with her."
	icon_state = "poster58"

/obj/structure/sign/poster/contraband/pinup_vixen
	name = "Pin-up - Space Vixen"
	desc = "A pin-up of a woman in a space suit that's definately NOT spaceproof."
	icon_state = "poster59"


#undef PLACE_SPEED

/obj/effect/landmark/poster_spawner
	icon = 'icons/obj/contraband.dmi'
	var/list/posters = list()

/obj/effect/landmark/poster_spawner/Initialize()
	. = ..()
	var/obj/structure/sign/poster/P = pick(posters)
	world << "[P]"
	new P(loc)
	qdel()

/obj/effect/landmark/poster_spawner/ncr
	posters = list(/obj/structure/sign/poster/ncr/keep_to_myself, /obj/structure/sign/poster/ncr/democracy, /obj/structure/sign/poster/ncr/irradiated_food, /obj/structure/sign/poster/ncr/loaded)

/obj/effect/landmark/poster_spawner/prewar
	posters = list(
		/obj/structure/sign/poster/prewar/corporate_espionage,
		/obj/structure/sign/poster/prewar/protectron,
		/obj/structure/sign/poster/prewar/vault_tec,
	)

/obj/effect/landmark/poster_spawner/pinup
	posters = list(/obj/structure/sign/poster/contraband/pinup_ride, /obj/structure/sign/poster/contraband/pinup_couch,
		/obj/structure/sign/poster/contraband/pinup_bed, /obj/structure/sign/poster/contraband/pinup_pink,
		/obj/structure/sign/poster/contraband/pinup_funk, /obj/structure/sign/poster/contraband/pinup_topless,
		/obj/structure/sign/poster/contraband/pinup_shower, /obj/structure/sign/poster/contraband/pinup_vixen)
