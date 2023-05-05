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
	name = "Texas Flag"
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
	name = "Arkansas Flag"
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

/obj/structure/gas_pump/oilpump2X
	name = "Gas Pump"
	icon_state = "oilpump2X"
	icon = 'modular_coyote/icons/objects/items.dmi'

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
