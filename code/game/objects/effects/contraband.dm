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
		if(QDELETED(poster_structure))
			stack_trace("A poster was initialized with a qdeleted poster_structure, something's gone wrong")
			return INITIALIZE_HINT_QDEL
		name = poster_structure.poster_item_name
		desc = poster_structure.poster_item_desc
		icon_state = poster_structure.poster_item_icon_state

		name = "[name] - [poster_structure.original_name]"
		//If the poster structure is being deleted something has gone wrong, kill yourself off too
		RegisterSignal(poster_structure, COMSIG_PARENT_QDELETING,PROC_REF(react_to_deletion))


/obj/item/poster/Destroy()
	poster_structure = null
	return ..()

/obj/item/poster/proc/react_to_deletion()
	SIGNAL_HANDLER
	qdel(src)

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
	var/obj/item/poster/poster_item

/obj/structure/sign/poster/Initialize()
	. = ..()
	if(random_basetype)
		randomise(random_basetype)
	if(!ruined)
		original_name = name // can't use initial because of random posters
		name = "poster - [name]"
		desc = "A large piece of printed paper. [desc]"

	AddElement(/datum/element/beauty, 300)


/obj/structure/sign/poster/Destroy()
	QDEL_NULL(poster_item)
	return ..()


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
	if(I.tool_behaviour == TOOL_WIRECUTTER)
		I.play_tool_sound(src, 100)
		if(ruined)
			to_chat(user, span_notice("You remove the remnants of the poster."))
			qdel(src)
		else
			to_chat(user, span_notice("You carefully remove the poster from the wall."))
			roll_and_drop(user.loc)


/obj/structure/sign/poster/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(ruined)
		return
	visible_message(span_notice("[user] rips [src] in a single, decisive motion!") )
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 100, TRUE)

	var/obj/structure/sign/poster/ripped/R = new(loc)
	R.pixel_y = pixel_y
	R.pixel_x = pixel_x
	R.add_fingerprint(user)
	qdel(src)


/obj/structure/sign/poster/proc/roll_and_drop(loc)
	pixel_x = 0
	pixel_y = 0
	var/obj/item/poster/P = poster_item || new poster_item_type(loc, src)
	P.forceMove(loc)
	forceMove(P)
	return P


//separated to reduce code duplication. Moved here for ease of reference and to unclutter r_wall/attackby()
/turf/closed/wall/proc/place_poster(obj/item/poster/P, mob/user)
	if(!P.poster_structure)
		to_chat(user, span_warning("[P] has no poster... inside it? Inform a coder!"))
		return

	// Deny placing posters on currently-diagonal walls, although the wall may change in the future.
	if (smoothing_flags & SMOOTH_DIAGONAL_CORNERS)
		for (var/O in overlays)
			var/image/I = O
			if(copytext(I.icon_state, 1, 3) == "d-") //3 == length("d-") + 1
				return

	var/stuff_on_wall = 0
	for(var/obj/O in contents) //Let's see if it already has a poster on it or too much stuff
		if(istype(O, /obj/structure/sign/poster))
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return
		stuff_on_wall++
		if(stuff_on_wall == 3)
			to_chat(user, span_warning("The wall is far too cluttered to place a poster!"))
			return

	to_chat(user, span_notice("You start placing the poster on the wall...") )

	var/obj/structure/sign/poster/D = P.poster_structure

	var/temp_loc = get_turf(user)
	flick("poster_being_set",D)
	D.forceMove(src)
	D.poster_item = P
	P.forceMove(D)
	playsound(D.loc, 'sound/items/poster_being_created.ogg', 100, TRUE)

	if(do_after(user, PLACE_SPEED, target=src))
		if(!D || QDELETED(D))
			return

		if(iswallturf(src) && user && user.loc == temp_loc) //Let's check if everything is still there
			to_chat(user, span_notice("You place the poster!"))
			return

	to_chat(user, span_notice("The poster falls down!"))
	D.roll_and_drop(get_turf(user))

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
	poster_item_desc = "This poster comes with its own adhesive backing, for easy pinning to any vertical surface. Its vulgar themes have marked it as contraband in decent workspaces."
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

/obj/structure/sign/poster/contraband/smoke
	name = "Smoke"
	desc = "A poster advertising Grey Tortoise cigarettes."
	icon_state = "poster7"

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

/obj/structure/sign/poster/contraband/rebels_unite
	name = "Rebels Unite"
	desc = "A poster urging the viewer to rebel against authority."
	icon_state = "poster23"

/obj/structure/sign/poster/contraband/have_a_puff
	name = "Have a Puff"
	desc = "You have the feeling this poster isn't approved by any medical authority."
	icon_state = "poster25"

/obj/structure/sign/poster/contraband/revolver
	name = "Revolver"
	desc = "Because seven shots are all you need."
	icon_state = "poster26"

/obj/structure/sign/poster/contraband/syndicate_pistol
	name = "Hitmen"
	desc = "A poster advertising the services of a mercenary company in the Hub. It seems very old."
	icon_state = "poster28"

/obj/structure/sign/poster/contraband/red_rum
	name = "Red Rum"
	desc = "Looking at this poster gives you an uneasy feeling. But its just an advertisement for alcohol, right?"
	icon_state = "poster30"

/obj/structure/sign/poster/contraband/punch_shit
	name = "Punch Shit"
	desc = "Fight things for no reason, like a man!"
	icon_state = "poster32"

/obj/structure/sign/poster/contraband/the_griffin
	name = "The Griffin"
	desc = "The Griffin, the latest nemesis to Grognak the Barbarian. The bombs dropped before the issue hit shelves."
	icon_state = "poster33"

/obj/structure/sign/poster/contraband/robust_softdrinks
	name = "Cosmic Cola"
	desc = "Cosmic Cola: Consumed on average by Americans more than water!"
	icon_state = "poster37"

/obj/structure/sign/poster/contraband/shamblers_juice
	name = "Mysterious Sign"
	desc = "This display fills you with uncertain dread, the air feels damp and chill."
	icon_state = "poster38"

/obj/structure/sign/poster/contraband/space_cola
	name = "Cosmic Cola"
	desc = "Your favorite cola, now in a can!"
	icon_state = "poster41"

/obj/structure/sign/poster/contraband/kudzu
	name = "Kudzu"
	desc = "A poster advertising a movie about plants. How dangerous could they possibly be?"
	icon_state = "poster43"

/obj/structure/sign/poster/contraband/buzzfuzz
	name = "Careless Talk Costs Lives"
	desc = "What I know - I keep to myself. CARELESS TALK COSTS LIVES."
	icon_state = "poster45"

/obj/structure/sign/poster/contraband/scum
	name = "Only You Can Prevent CORPORATE ESPIONAGE"
	desc = "This poster shows the silhouette of a man wearing a raincoat with the collar up and a hat groping towards the files in a drawer of a filing cabinet."
	icon_state = "poster46"

/obj/structure/sign/poster/contraband/syndicate_logo
	name = "You Bring Democracy to This Land"
	desc = "NCR Trooper... YOU bring DEMOCRACY to This Land."
	icon_state = "poster47"

/obj/structure/sign/poster/contraband/bountyhunters
	name = "Do Not Eat Irradiated Food"
	desc = "A warning to NCR troopers about eating irradiated food."
	icon_state = "poster48"

/obj/structure/sign/poster/official
	poster_item_name = "motivational poster"
	poster_item_desc = "An official government-issued poster to foster a compliant and obedient workforce. It comes with state-of-the-art adhesive backing, for easy pinning to any vertical surface."
	poster_item_icon_state = "rolled_legit"

/obj/structure/sign/poster/official/random
	name = "random official poster"
	random_basetype = /obj/structure/sign/poster/official
	icon_state = "random_official"
	never_random = TRUE

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

/obj/structure/sign/poster/official/science
	name = "Science"
	desc = "A poster depicting an atom."
	icon_state = "poster7_legit"

/obj/structure/sign/poster/official/obey
	name = "Obey"
	desc = "A poster instructing the viewer to obey authority."
	icon_state = "poster9_legit"

/obj/structure/sign/poster/official/walk
	name = "Walk"
	desc = "A poster instructing the viewer to walk instead of run."
	icon_state = "poster10_legit"

/obj/structure/sign/poster/official/love_ian
	name = "Love!"
	desc = "An advertistment for a pet shelter; cats and dogs now thrive in feral colonies across the continent, utilizing empty ruined buildings."
	icon_state = "poster12_legit"

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
	desc = "A poster instructing the viewer to report suspicious activity to local police."
	icon_state = "poster21_legit"

/obj/structure/sign/poster/official/report_crimes
	name = "Report Crimes"
	desc = "A poster encouraging the swift reporting of crime or seditious behavior to local police."
	icon_state = "poster22_legit"

/obj/structure/sign/poster/official/ion_rifle
	name = "Ion Rifle"
	desc = "A poster displaying an Ion Rifle."
	icon_state = "poster23_legit"

/obj/structure/sign/poster/official/foam_force_ad
	name = "Foam Force Ad"
	desc = "Foam Force, selling violence as fun in cooperation with the United States Army!"
	icon_state = "poster24_legit"

/obj/structure/sign/poster/official/cohiba_robusto_ad
	name = "Cohiba Robusto Ad"
	desc = "Cohiba Robusto, the classy cigar."
	icon_state = "poster25_legit"

/obj/structure/sign/poster/official/anniversary_vintage_reprint
	name = "320th Anniversary Vintage Reprint"
	desc = "A reprint of a poster from 1961, commemorating the 320th Anniversary of the first manned space flight, by Captain Carl Bell."
	icon_state = "poster26_legit"

/obj/structure/sign/poster/official/fruit_bowl
	name = "Fruit Bowl"
	desc = " Simple, yet awe-inspiring."
	icon_state = "poster27_legit"

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
	desc = "The Owl was a late addition to the Hubris Comics family, but his few issues gave comfort to children growing up in the rubble."
	icon_state = "poster33_legit"

/obj/structure/sign/poster/official/wtf_is_co2
	name = "Carbon Dioxide"
	desc = "This informational poster teaches the viewer about the dangers of carbon dioxide."
	icon_state = "poster35_legit"

/obj/structure/sign/poster/official/hydro_ad
	name = "Hydroponics Tray"
	desc = "An advertisement for hydroponics trays. The principles are simple. From left to right: Green means the harvest is ready, red means the plant is unhealthy, flashing red lights mean pests or weeds, yellow means the plant needs nutrients, and blue means the plant needs watering."
	icon_state = "poster41_legit"

/obj/structure/sign/poster/official/medical_green_cross
	name = "Medical"
	desc = "A green cross, one of the international symbols of aid and health." // Didn't the American Heart Foundation trademark red crosses? I'm playing it safe with green, not that they'll notice spacegame13 poster.
	icon_state = "poster42_legit"


/obj/structure/sign/poster/ncr/keep_to_myself
	name = "Careless Talk Costs Lives"
	desc = "What I know - I keep to myself. CARELESS TALK COSTS LIVES."
	icon_state = "poster45"

/obj/structure/sign/poster/ncr/democracy
	name = "You Bring Democracy to This Land"
	desc = "NCR Trooper... YOU bring DEMOCRACY to This Land."
	icon_state = "poster47"

/obj/structure/sign/poster/ncr/irradiated_food
	name = "Do Not Eat Irradiated Food"
	desc = "A warning to NCR troopers about eating irradiated food."
	icon_state = "poster48"

/obj/structure/sign/poster/ncr/loaded
	name = "Loaded?"
	desc = "Loaded? Don't take chances with pick-ups... Loose women may also be loaded with disease."
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
	desc = "Wasteland 7, Coming SOON."
	icon_state = "poster62"

/obj/structure/sign/poster/prewar/poster63
	name = "unsettling poster"
	desc = "Foreign agents can be anywhere. Trust nobody, report everybody."
	icon_state = "poster63"

/obj/structure/sign/poster/prewar/poster65
	name = "niche game poster"
	desc = "GRIDIRON - Where the only way to escape the game, is to kill. Hitting shelves in fall of 2078!"
	icon_state = "poster65"

/obj/structure/sign/poster/prewar/poster66
	name = "old hopeful poster"
	desc = "This advertisement appears to be spiritual in nature. Whatever faith it called to has been worn away by time."
	icon_state = "poster66"

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
	desc = "Suffer well. May God be saved, and may God save us all. Who else can, in times such as these?"
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
	name = "old festive poster"
	desc = "An old world advertisement for a festive atomic pail."
	icon_state = "poster75"

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
