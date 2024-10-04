//Fallout 13 crafting items directory
//All of the items listed are useful only for crafting things.

/*
/obj/item/weaponcrafting/reciever
	name = "modular receiver"
	desc = "A prototype modular receiver and trigger assembly for a firearm."
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "receiver"
*/ //this...tentatively...does nothing? does not appear anywhere? and has an identical twin called /obj/item/weaponcrafting/receiver, which is properly spelled. wtf. like actually w t f

/obj/item/weaponcrafting/stock
	name = "rifle stock"
	desc = "A classic rifle stock that doubles as a grip, roughly carved out of wood."
	icon = 'icons/fallout/objects/crafting.dmi'
	icon_state = "riflestock"

/obj/item/rocketshell //only useful for crafting rockets
	name = "empty rocket casing"
	desc = "The casing of a rocket, waiting for a warhead."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "84mm-hedp"
	w_class = WEIGHT_CLASS_SMALL

//The following items are in "crafting" type just to keep code clean.
/obj/item/crafting
	name = "basic crafting components obtained from salvaging"
	desc = "This should not be visible. Tell someone about it."
	icon = 'icons/fallout/objects/crafting.dmi'
	item_state = "null"
	w_class = WEIGHT_CLASS_TINY

/obj/item/crafting/diode
	name = "diode"
	desc = "It looks like something I saw in that useless broken television set once.<br>That thing is probably used in some electronic devices."
	icon_state = "diode_1"
/obj/item/crafting/diode/New()
	..()
	icon_state = "diode_[rand(1,3)]"

/obj/item/crafting/transistor
	name = "transistor"
	desc = "Popov would love it, but Tesla got to see it.<br>The most useful electrical component."
	icon_state = "transistor_1"
/obj/item/crafting/transistor/New()
	..()
	icon_state = "transistor_[rand(1,3)]"

/obj/item/crafting/capacitor
	name = "capacitor"
	desc = "It looks like something I saw inside of the radio once.<br>It seems like it's the most basic electrical component."
	icon_state = "capacitor_1"
/obj/item/crafting/capacitor/New()
	..()
	icon_state = "capacitor_[rand(1,3)]"

/obj/item/crafting/fuse
	name = "fuse"
	desc = "A tiny glass tube with some wiring stuck inside of it.<br>I have no idea what it is."
	icon_state = "fuse_1"
/obj/item/crafting/fuse/New()
	..()
	icon_state = "fuse_[rand(1,3)]"

/obj/item/crafting/resistor
	name = "resistor"
	desc = "Tesla Warrior says, \"Stop right there, criminal electron!\"<br>Electron says, \"You'll never catch me!!!\"<br>*Zoom* *Zoom* *Pew* *Pew* *Pew*"
	icon_state = "resistor_1"
/obj/item/crafting/resistor/New()
	..()
	icon_state = "resistor_[rand(1,3)]"

/obj/item/crafting/switch_crafting //look, "switch" is a built in proc and we can't use it in the path by itself
	name = "switch"
	desc = "A common switch, used to light up the flashlight or activate a bomb timer." //Why i code it?
	icon_state = "switch_1"
/obj/item/crafting/switch_crafting/New()
	..()
	icon_state = "switch_[rand(1,3)]"

/obj/item/crafting/bulb
	name = "bulb"
	desc = "And at last I see the light,<br>And it's like the fog has lifted,<br>And at last I see the light,<br>And it's like the sky is new,<br>And it's warm and real and bright,<br>And the world has somehow shifted,<br>All at once everything looks different."
	icon_state = "bulb_1"
/obj/item/crafting/bulb/New()
	..()
	icon_state = "bulb_[rand(1,3)]"

/obj/item/crafting/board
	name = "empty circuit board"
	desc = "A plastic board used to hold all other electrical components together."
	icon_state = "board_1"
/obj/item/crafting/board/New()
	..()
	icon_state = "board_[rand(1,3)]"

/obj/item/crafting/buzzer
	name = "buzzer"
	desc = "I can almost hear it buzzing. Except it's not."
	icon_state = "buzzer"

/obj/item/crafting/frame
	name = "circuit board assembly"
	desc = "A printed circuit board - a complex electrical component."
	icon_state = "frame"

/obj/item/crafting/small_gear
	name = "small gear"
	desc = "A litle part of a big mechanism."
	icon_state = "gear_small"

/obj/item/crafting/large_gear
	name = "large gear"
	desc = "A big part of a grand mechanism."
	icon_state = "gear_large"

/obj/item/crafting/duct_tape
	name = "duct tape"
	desc = "A pinnacle of engineering - it fixes everything!"
	icon_state = "duct_tape"

/obj/item/crafting/coffee_pot
	name = "coffeepot"
	desc = "A coffeepot is a tall, narrow pot with a spout and a lid, in which coffee is made or served"
	icon_state = "coffeepot"

/*/obj/item/crafting/rope //sprite won't take. Maybe someone else can get it to work.
	name = "rope"
	desc = "A strong, thick line made of braided bighorner hair."
	icon_state = "rope"*/

/obj/item/crafting/wonderglue
	name = "wonder glue"
	desc = "A Pre-Fall brand of glue that has retained its adhesive qualities.<br>A glue itself is a liquid acrylic adhesive, meant to fix broken plastics and ceramics or used in the assembly of a great assortment of items."
	icon_state = "wonderglue1"

/obj/item/crafting/wonderglue/New()
	..()
	icon_state = "wonderglue[rand(1,2)]"

/obj/item/crafting/turpentine
	name = "turpentine"
	desc = "A liquid distilled from pine resin, can function as an antiseptic or solvent."
	icon_state = "turpentine"

/obj/item/crafting/abraxo
	name = "Abraxo"
	desc = "A Pre-Fall cleaning agent produced by Abraxodyne Chemical.<br>Its powdery flakes seem useful for dealing with toxic spills."
	icon_state = "abraxo"

/obj/item/circuitboard/machine/autolathe/ammo/improvised
	name = "makeshift reloader"
	desc = "This device allows you to hand-craft your own gun rounds using certain raw materials.<br>Use a screwdriver on it to make it fit inside a machine frame!"
	icon_state = "reloader"
	tool_behaviour = TOOL_MSRELOADER

/obj/item/circuitboard/machine/autolathe/ammo/improvised/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()

	if(.)
		return

	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return

	if(I.use_tool(src, user, volume=50))
		to_chat(user, span_notice("You drill some holes in \the [src]'s base! Looks like it could be attached to a machine frame."))
		make_it_a_board(user)
	else
		to_chat(user, span_alert("You can't seem to drill any holes in \the [src]'s base! Might need to stand still, or the drill might need some juice..."))

/obj/item/circuitboard/machine/autolathe/ammo/improvised/proc/make_it_a_board(mob/living/user)
	if(!user)
		return
	var/turf/this_turf = get_turf(src)
	qdel(src)
	var/obj/item/circuitboard/machine/autolathe/ammo/improvised/jank_board = new(this_turf)
	user.put_in_hands(jank_board)

/obj/item/crafting/lunchbox
	name = "lunch box"
	desc = "This was a promotional item created by Vault-Tec before the Great War and used in the company's advertisements. With the right schematics, it can be used to make bottlecap mines."
	icon_state = "lunchbox"
	tool_behaviour = TOOL_LUNCHBOX

/obj/item/crafting/campfirekit
	name = "campfire kit"
	desc = "A small box filled with an assortment of wood and tender. Useful for quickly making a fire."
	icon_state = "lunchbox"
