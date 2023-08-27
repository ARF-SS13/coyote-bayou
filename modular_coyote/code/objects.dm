/obj/machinery/light/sign/nash
	name = "nash sign"
	icon_state = "nash_on"
	base_state = "nash_on"
	icon = 'modular_coyote/icons/objects/sign.dmi'
	density = 0
	desc = "So awful..."
	light_color = LIGHT_COLOR_RED
//Shopping Cart
/obj/structure/shopping_cart
	name = "shopping cart"
	icon_state = "cart"
	icon = 'modular_coyote/icons/objects/cart.dmi'
	desc = "A rusty old shopping cart. It's wheels have melted and it's now very stuck on the ground."
// Signs
/obj/structure/sign/crosswalk
	name = "crosswalk"
	icon_state = "zebracrossing"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/yield
	name = "yield"
	icon_state = "yeld"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/stop
	name = "Stop"
	icon_state = "stop"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/do_not_enter
	name = "do not enter"
	icon_state = "donotenter"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/parking
	name = "parking"
	icon_state = "parking"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/cafesign
	name = "cafe sign"
	icon_state = "cafesign"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/gasolinesign
	name = "gasoline sign"
	icon_state = "gasolinesign"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/humansign
	name = "human sign"
	icon_state = "humansign"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/waysign
	name = "way sign"
	icon_state = "waysign"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/zebra
	name = "zebra"
	icon_state = "zebra"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/radiation
	name = "radiation"
	icon_state = "radiation"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/radiation_l
	name = "radiation"
	icon_state = "radiation_l"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/flag_texas
	name = "Tejaxicoana Flag"
	desc = "Tejas. Mexico. Louisiana. Ancient places with no memory. The states that stood behind or near this flag are long gone, leaving a pale star on a white and red background. The meanings of its colors are forgotten by almost everyone, but the lone star shines."
	icon_state = "flag_texas"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/radiation_l
	name = "radiation"
	icon_state = "radiation_l"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/sheriff
	name = "sheriff"
	icon_state = "sheriff"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/bank
	name = "bank"
	icon_state = "bank"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/gunshop
	name = "gun shop"
	icon_state = "gunshop"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/gas
	name = "gas"
	icon_state = "gas"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/flag_arkansas
	name = "Akansea Flag"
	desc = "What is there to say of the flag so brave as to be so blood-dyed? It is a land now sun-bleached and ruined. To be quite honest, you don't understand how a word can be pronounced so differently from how it's spelled."
	icon_state = "flag_arkansas"
	icon = 'modular_coyote/icons/objects/signs_small.dmi'

/obj/structure/sign/brotherhoodcardboard
	name = "Brotherhood Of Steal?"
	desc = "A cardobard sign with the Brotherhood logo and name scribbled onto it."
	icon_state = "cardboardsteal"
	icon = 'modular_coyote/icons/objects/sign.dmi'

//Gas Pumps

/obj/structure/gas_pump/oilpump1X
	name = "Gas Pump"
	icon_state = "oilpump1X"
	icon = 'modular_coyote/icons/objects/items.dmi'
	var/uses_left = 2
	var/inuse = FALSE

/obj/structure/gas_pump/oilpump1X/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = I
		if(inuse) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
			return
		inuse = TRUE //one at a time boys, this isn't some kind of weird party
		if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
			inuse = FALSE
			return //the tool fails this check, so stop
		user.visible_message("[user] starts disassembling [src].")
		if(!I.use_tool(src, user, 0, volume=100)) //here is the dilemma, use_tool doesn't work like do_after, so moving away screws it(?)
			inuse = FALSE
			return //you can't use the tool, so stop
		for(var/i1 in 1 to 2) //so, I hate waiting
			if(!do_after(user, 1 SECONDS*W.toolspeed, target = src)) //this is my work around, because do_After does have a move away
				user.visible_message("[user] stops disassembling [src].")
				inuse = FALSE
				return //you did something, like moving, so stop
			var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
			user.visible_message("[user] slices through a [fake_dismantle].")
			I.play_tool_sound(src, 100)
		var/turf/usr_turf = get_turf(user)
		var/modifier = 0
		if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
			modifier = rand(1, 3)
		for(var/i2 in 1 to (3+modifier))
			if(prob(25))
				new /obj/item/salvage/low(usr_turf)
		for(var/i3 in 1 to (1+modifier)) //this is just less lines for the same thing
			if(prob(10))
				new /obj/item/salvage/high(usr_turf)
			if(prob(10))
				new /obj/item/salvage/tool(usr_turf)
			if(prob(5))
				new /obj/structure/reagent_dispensers/barrel/explosive(usr_turf)
		inuse = FALSE //putting this after the -- because the first check prevents cheesing
		if(uses_left <= 0) //I prefer to put any qdel stuff at the very end, with src being the very last thing
			visible_message("[src] falls apart, the final components having been removed.")
			qdel(src)

/obj/structure/gas_pump/oilpump2X
	name = "Gas Pump"
	icon_state = "oilpump2X"
	icon = 'modular_coyote/icons/objects/items.dmi'

	var/uses_left = 2
	var/inuse = FALSE

/obj/structure/gas_pump/oilpump2X/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/weldingtool))
		var/obj/item/weldingtool/W = I
		if(inuse) //this means that if mappers or admins want an nonharvestable version, set the uses_left to 0
			return
		inuse = TRUE //one at a time boys, this isn't some kind of weird party
		if(!I.tool_start_check(user, amount=0)) //this seems to be called everywhere, so for consistency's sake
			inuse = FALSE
			return //the tool fails this check, so stop
		user.visible_message("[user] starts disassembling [src].")
		if(!I.use_tool(src, user, 0, volume=100)) //here is the dilemma, use_tool doesn't work like do_after, so moving away screws it(?)
			inuse = FALSE
			return //you can't use the tool, so stop
		for(var/i1 in 1 to 2) //so, I hate waiting
			if(!do_after(user, 1 SECONDS*W.toolspeed, target = src)) //this is my work around, because do_After does have a move away
				user.visible_message("[user] stops disassembling [src].")
				inuse = FALSE
				return //you did something, like moving, so stop
			var/fake_dismantle = pick("plating", "rod", "rim", "part of the frame")
			user.visible_message("[user] slices through a [fake_dismantle].")
			I.play_tool_sound(src, 100)
		var/turf/usr_turf = get_turf(user)
		var/modifier = 0
		if(HAS_TRAIT(user,TRAIT_TECHNOPHREAK))
			modifier = rand(1, 3)
		for(var/i2 in 1 to (3+modifier))
			if(prob(25))
				new /obj/item/salvage/low(usr_turf)
		for(var/i3 in 1 to (1+modifier)) //this is just less lines for the same thing
			if(prob(10))
				new /obj/item/salvage/high(usr_turf)
			if(prob(10))
				new /obj/item/salvage/tool(usr_turf)
			if(prob(5))
				new /obj/structure/reagent_dispensers/barrel/explosive(usr_turf)
		inuse = FALSE //putting this after the -- because the first check prevents cheesing
		if(uses_left <= 0) //I prefer to put any qdel stuff at the very end, with src being the very last thing
			visible_message("[src] falls apart, the final components having been removed.")
			qdel(src)

/obj/structure/gas_pump/oilpump3X
	name = "Gas Pump"
	icon_state = "oilpump3X"
	icon = 'modular_coyote/icons/objects/items.dmi'

/obj/structure/gas_pump/oilpump4X
	name = "Gas Pump"
	icon_state = "oilpump4X"
	icon = 'modular_coyote/icons/objects/items.dmi'

/obj/structure/gas_pump/oilpump1
	name = "Gas Pump"
	icon_state = "oilpump1"
	icon = 'modular_coyote/icons/objects/items.dmi'

/obj/structure/gas_pump/oilpump2
	name = "Gas Pump"
	icon_state = "oilpump2"
	icon = 'modular_coyote/icons/objects/items.dmi'

/obj/structure/gas_pump/oilpump3
	name = "Gas Pump"
	icon_state = "oilpump3"
	icon = 'modular_coyote/icons/objects/items.dmi'

/obj/structure/gas_pump/oilpump4
	name = "Gas Pump"
	icon_state = "oilpump4"
	icon = 'modular_coyote/icons/objects/items.dmi'

//Plushies
/obj/item/toy/plush/deer
	name = "deer plushie"
	desc = "An adorable stuffed toy that resembles a deer."
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "deer"
	attack_verb = list("headbutt", "booped", "bapped", "bumped")
	squeak_override = list('sound/items/deerplush.ogg' = 1)

/obj/structure/bed/small_nest
	name = "small nest"
	desc = "A small round nest that looks soft"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	icon_state = "nest_chair"
	max_integrity = 80

/obj/structure/bed/big_nest
	name = "big nest"
	desc = "A big round nest that looks soft"
	buildstacktype = /obj/item/stack/sheet/mineral/wood
	icon_state = "nest_chair_large"
	max_integrity = 80

//alien coins from virgo

/obj/item/coin/iron/strangecoin1
	name = "strange coin"
	desc = "A strange triangle shaped coin."
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "triangle-p"

/obj/item/coin/iron/strangecoin2
	name = "strange coin"
	desc = "A strange triangle shaped coin."
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "triangle-g"

/obj/item/coin/iron/strangecoin3
	name = "strange coin"
	desc = "A strange triangle shaped coin."
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "triangle-s"

/obj/item/coin/iron/strangecoin4
	name = "strange coin"
	desc = "A strange triangle shaped coin."
	icon = 'modular_coyote/icons/objects/items.dmi'
	icon_state = "triangle"

//Playground

/obj/structure/playground/slide
	name = "Slide"
	desc = "A slide! Oh god, it's metal. Don't go down in the summer."
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "slide"

/obj/structure/playground/merrygoround
	name = "Merry go Round!"
	desc = "Speeeeen."
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "merry_go_round"

/obj/structure/playground/ride/brown
	name = "spring rider"
	desc = "Bo-ing!"
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "brown_ride"

/obj/structure/playground/ride/white
	name = "spring rider"
	desc = "Bo-ing!"
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "white_ride"

/obj/structure/playground/ride/white2
	name = "spring rider"
	desc = "Bo-ing!"
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "white2_ride"

/obj/structure/playground/ride/black
	name = "spring rider"
	desc = "Bo-ing!"
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "black_ride"

/obj/structure/playground/ride/red
	name = "spring rider"
	desc = "Bo-ing!"
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "red_ride"

/obj/structure/playground/hopscotch_number
	name = "hopscotch"
	desc = "Hop to it."
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "hopscotch_number"

/obj/structure/playground/hopscotch
	name = "hopscotch"
	desc = "Hop to it."
	icon = 'modular_coyote/icons/objects/playground64x32.dmi'
	icon_state = "hopscotch"

/obj/structure/playground/tireswing
	name = "Tire swing"
	desc = "Swing Low."
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "tire_swing"

/obj/structure/playground/seesaw
	name = "See Saw"
	desc = "For all your ups and downs in life."
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "see_saw"

/obj/structure/playground/sandbox
	name = "Sandbox"
	desc = "Gritty."
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "sandbox"

/obj/structure/playground/swings
	name = "Swings"
	desc = "Swing high! Swing low! Jump off and break your toe!"
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "swings"

/obj/structure/playground/vollyball
	name = "Vollyball"
	desc = "What goes around comes around."
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "vollyball"

/obj/structure/playground/monkeybars
	name = "Monkey Bars"
	desc = "Funny..there's no monkeys!"
	icon = 'modular_coyote/icons/objects/playground100x100.dmi'
	icon_state = "monkeybars"

//Things from Mojave Sun, credit for the spirits go to them.

//Rugs

/obj/structure/rug/carpet
	name = "run carpet"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/run_carpets.dmi'
	icon_state = "carpet"

/obj/structure/rug/carpet2
	name = "run carpet"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/run_carpets.dmi'
	icon_state = "carpet2"

/obj/structure/rug/carpet3
	name = "run carpet"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/run_carpets.dmi'
	icon_state = "carpet3"

/obj/structure/rug/carpet4
	name = "run carpet"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/run_carpets.dmi'
	icon_state = "carpet4"

//bigger rugs

/obj/structure/rug/big/rug_rubber
	name = "rubber rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_rubber"

/obj/structure/rug/big/rug_rubber
	name = "rubber rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_rubber"

/obj/structure/rug/big/rug_fancy
	name = "fancy rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_fancy"

/obj/structure/rug/big/rug_red
	name = "red rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_red"

/obj/structure/rug/big/rug_yellow
	name = "yellow rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_yellow"

/obj/structure/rug/big/rug_blue_shag
	name = "blue shag rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_blue_shag"

/obj/structure/rug/big/rug_blue
	name = "blue rug"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/64x64_rugs.dmi'
	icon_state = "rug_blue"

/obj/structure/rug/mat
	name = "mat"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "mat_blank"

/obj/structure/rug/mat/welcome
	name = "welcome mat"
	desc = "Roll around on it!"
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "mat_welcome"


/obj/structure/props/micstand
	name = "microphone stand"
	desc = "A mic stand."
	icon = 'icons/obj/device.dmi'
	icon_state = "micstand"
	density = TRUE
	opacity = TRUE
	anchored = TRUE

/obj/structure/nightstand
	name = "Night Stand"
	desc = "A night stand! Maybe even a one, night stand."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "nightstand"
	density = TRUE
	opacity = TRUE
	anchored = TRUE

/obj/structure/nightstand/small
	name = "Night Stand"
	desc = "A night stand! Maybe even a one, night stand."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "nightstand_small"

/obj/structure/nightstand/white
	name = "Night Stand"
	desc = "A night stand! Maybe even a one, night stand."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "nightstand_alt"

//From Mojave sun, credit to them for the sprite
/obj/structure/wood_counter
	name = "Wooden Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "wood_counter"

/obj/structure/wood_counter/bend
	name = "Wooden Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "wood_counter_bend"

/obj/structure/wood_counter/intersect
	name = "Wooden Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "wood_counter_intersect"

/obj/structure/wood_counter/cross
	name = "Wooden Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "wood_counter_cross"

/obj/structure/craft_counter
	name = "Crafted Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "craft_counter"

/obj/structure/craft_counter/bend
	name = "Crafted Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "craft_counter_bend"

/obj/structure/craft_counter/intersect
	name = "Crafted Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "craft_counter_intersect"

/obj/structure/craft_counter/cross
	name = "Crafted Counter"
	desc = "Count your wood? Or is it wood your count.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "craft_counter_cross"

/obj/structure/toilet_paper
	name = "Toilet Paper Holder"
	desc = "Look before you shit! I mean, sit!"
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "paper_roller"

/obj/structure/towel_rack
	name = "Towel Rack"
	desc = "People still use these?"
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "towel_rack"

/obj/structure/mirror/alt
	name = "mirror"
	desc = "Mirror mirror on the wall, who's the most robust of them all?"
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "mirror"

/obj/structure/cupboard
	name = "cupboard"
	desc = "Yep. It's a cupboard. Good job."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "cuboard"

/obj/structure/sink/cupboard
	name = "Sink Cupboard"
	desc = "A rather nice looking sink. How quint."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "sink"

/obj/structure/dvd_player
	name = "Dvd Player"
	desc = "An old and dusty looking machine. Maybe it even still works.."
	icon = 'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "dvd_player"

/obj/item/weapon/dvd
	name = "Dvd"
	desc = "A shiny disk! Don't scratch it."
	icon =  'modular_coyote/icons/objects/miscellaneous.dmi'
	icon_state = "dvd"

/obj/item/storage/box/tools/locksmith
	name = "locksmith tools"

/obj/item/storage/box/tools/locksmith/PopulateContents()
	new /obj/item/door_key(src)
	new /obj/item/door_key(src)
	new /obj/item/lock(src)
	new /obj/item/storage/keys_set(src)

//New fish


/obj/item/fishy/guppy
	name = "guppy"
	desc = "I caught a guppy! Welcome to the team, newbie!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "guppy"

/obj/item/fishy/firefish
	name = "fire fish"
	desc = "I caught fire...fish! Ouch ouch hot!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "firefish"

/obj/item/fishy/greenchromis
	name = "green chromis"
	desc = "Wow that sure is a green fish! Might be good for the enviroment."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "greenchromis"

/obj/item/fishy/cardinalfish
	name = "cardinal fish"
	desc = "Better call the pope."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "cardinalfish"

/obj/item/fishy/catfish
	name = "catfish"
	desc = "I caught a puffer fish! I thought you would be tougher, fish!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "catfish"

/obj/item/fishy/plastetra
	name = "plastetra"
	desc = "Plaster this guy on the dinner plate."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "plastetra"

/obj/item/fishy/angelfish
	name = "angel fish"
	desc = "I caught an angelfish! That other fish told me to do it!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "angelfish"

/obj/item/fishy/clownfish
	name = "clown fish"
	desc = "I caught a clown fish! How many can fit in a carfish?"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "clownfish"

/obj/item/fishy/lubefish
	name = "lube fish"
	desc = "This fish looks quite slick, better hold on tight"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "lubefish"

/obj/item/fishy/lanternfish
	name = "lantern fish"
	desc = "When your fish boss is watching, you'd better look e-fish-ent."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "lanternfish"

/obj/item/fishy/dwarf_moonfish
	name = "dwarf moonfish"
	desc = "When a fish meets the love of their live, they say they've 'met the gill of my dreams.'"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "dwarf_moonfish"

/obj/item/fishy/bugfish
	name = "bugfish"
	desc = "Surfing the net is great, unless, of course, you're a fish."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "bugfish"

/obj/item/fishy/gunner_jellyfish
	name = "gunner jellyfish"
	desc = "Speaking of being jelly, tunas were really miffed about the whole salmon-ella thing."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "gunner_jellyfish"

/obj/item/fishy/needlefish
	name = "nibble fish"
	desc = "Yes! I caught a nibble fish! Come to think of it, I could use a bite!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "needlefish"

/obj/item/fishy/armorfish
	name = "armorfish"
	desc = "Never try to talk to a fish before they’ve caf-fin-ated."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "armorfish"

/obj/item/fishy/pufferfish
	name = "pufferfish"
	desc = "Never fall in love with a blowfish. You’ll always get re-puffed."
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "pufferfish"

/obj/item/fishy/goldfish
	name = "goldfish"
	desc = "I caught a goldfish! It's worth its weight in fish!"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	icon =  'modular_coyote/icons/objects/items.dmi'
	icon_state = "goldfish"
