/obj/item/storage/box/dice
	name = "bag of dice"
	desc = "Contains all the luck you'll ever need."
	icon = 'icons/obj/dice.dmi'
	icon_state = "dicebag"

/obj/item/storage/box/dice/Initialize()
	. = ..()
	var/special_die = pick("1","2","fudge","space","00","8bd20","4dd6","100")
	if(special_die == "1")
		new /obj/item/dice/d1(src)
	if(special_die == "2")
		new /obj/item/dice/d2(src)
	new /obj/item/dice/d4(src)
	new /obj/item/dice/d6(src)
	if(special_die == "fudge")
		new /obj/item/dice/fudge(src)
	if(special_die == "space")
		new /obj/item/dice/d6/space(src)
	new /obj/item/dice/d8(src)
	new /obj/item/dice/d10(src)
	if(special_die == "00")
		new /obj/item/dice/d00(src)
	new /obj/item/dice/d12(src)
	new /obj/item/dice/d20(src)
	if(special_die == "8bd20")
		new /obj/item/dice/eightbd20(src)
	if(special_die == "4dd6")
		new /obj/item/dice/fourdd6(src)
	if(special_die == "100")
		new /obj/item/dice/d100(src)

/obj/item/dice //depreciated d6, use /obj/item/dice/d6 if you actually want a d6
	name = "die"
	desc = "A die with six sides. Basic and serviceable."
	icon = 'icons/obj/dice.dmi'
	icon_state = "d6"
	w_class = WEIGHT_CLASS_TINY
	var/sides = 6
	var/result = null
	var/list/special_faces = list() //entries should match up to sides var if used
	var/can_be_rigged = TRUE
	var/rigged = FALSE

/obj/item/dice/Initialize()
	. = ..()
	result = roll(sides)
	update_icon()

/obj/item/dice/d1
	name = "d1"
	desc = "A die with only one side. Deterministic!"
	icon_state = "d1"
	sides = 1

/obj/item/dice/d2
	name = "d2"
	desc = "A die with two sides. Coins are undignified!"
	icon_state = "d2"
	sides = 2

/obj/item/dice/d4
	name = "d4"
	desc = "A die with four sides. The nerd's caltrop."
	icon_state = "d4"
	sides = 4

/obj/item/dice/d4/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, 4)

/obj/item/dice/d6
	name = "d6"

/obj/item/dice/d6/space
	name = "space cube"
	desc = "A die with six sides. 6 TIMES 255 TIMES 255 TILE TOTAL EXISTENCE, SQUARE YOUR MIND OF EDUCATED STUPID: 2 DOES NOT EXIST."
	icon_state = "spaced6"

/obj/item/dice/d6/space/Initialize()
	. = ..()
	if(prob(10))
		name = "spess cube"

/obj/item/dice/fudge
	name = "fudge die"
	desc = "A die with six sides but only three results. Is this a plus or a minus? Your mind is drawing a blank..."
	sides = 3 //shhh
	icon_state = "fudge"
	special_faces = list("minus","blank","plus")

/obj/item/dice/d8
	name = "d8"
	desc = "A die with eight sides. It feels... lucky."
	icon_state = "d8"
	sides = 8

/obj/item/dice/d10
	name = "d10"
	desc = "A die with ten sides. Useful for percentages."
	icon_state = "d10"
	sides = 10

/obj/item/dice/d00
	name = "d00"
	desc = "A die with ten sides. Works better for d100 rolls than a golf ball."
	icon_state = "d00"
	sides = 10

/obj/item/dice/d12
	name = "d12"
	desc = "A die with twelve sides. There's an air of neglect about it."
	icon_state = "d12"
	sides = 12

/obj/item/dice/d20
	name = "d20"
	desc = "A die with twenty sides. The preferred die to throw at the GM."
	icon_state = "d20"
	sides = 20

/obj/item/dice/d100
	name = "d100"
	desc = "A die with one hundred sides! Probably not fairly weighted..."
	icon_state = "d100"
	w_class = WEIGHT_CLASS_SMALL
	sides = 100

/obj/item/dice/d100/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/eightbd20
	name = "strange d20"
	desc = "A weird die with raised text printed on the faces. Everything's white on white so reading it is a struggle. What poor design!"
	icon_state = "8bd20"
	sides = 20
	special_faces = list("It is certain","It is decidedly so","Without a doubt","Yes, definitely","You may rely on it","As I see it, yes","Most likely","Outlook good","Yes","Signs point to yes","Reply hazy try again","Ask again later","Better not tell you now","Cannot predict now","Concentrate and ask again","Don't count on it","My reply is no","My sources say no","Outlook not so good","Very doubtful")

/obj/item/dice/eightbd20/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/fourdd6
	name = "4d d6"
	desc = "A die that exists in four dimensional space. Properly interpreting them can only be done with the help of a mathematician, a physicist, and a priest."
	icon_state = "4dd6"
	sides = 48
	special_faces = list("Cube-Side: 1-1","Cube-Side: 1-2","Cube-Side: 1-3","Cube-Side: 1-4","Cube-Side: 1-5","Cube-Side: 1-6","Cube-Side: 2-1","Cube-Side: 2-2","Cube-Side: 2-3","Cube-Side: 2-4","Cube-Side: 2-5","Cube-Side: 2-6","Cube-Side: 3-1","Cube-Side: 3-2","Cube-Side: 3-3","Cube-Side: 3-4","Cube-Side: 3-5","Cube-Side: 3-6","Cube-Side: 4-1","Cube-Side: 4-2","Cube-Side: 4-3","Cube-Side: 4-4","Cube-Side: 4-5","Cube-Side: 4-6","Cube-Side: 5-1","Cube-Side: 5-2","Cube-Side: 5-3","Cube-Side: 5-4","Cube-Side: 5-5","Cube-Side: 5-6","Cube-Side: 6-1","Cube-Side: 6-2","Cube-Side: 6-3","Cube-Side: 6-4","Cube-Side: 6-5","Cube-Side: 6-6","Cube-Side: 7-1","Cube-Side: 7-2","Cube-Side: 7-3","Cube-Side: 7-4","Cube-Side: 7-5","Cube-Side: 7-6","Cube-Side: 8-1","Cube-Side: 8-2","Cube-Side: 8-3","Cube-Side: 8-4","Cube-Side: 8-5","Cube-Side: 8-6")

/obj/item/dice/fourdd6/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/dice/attack_self(mob/user)
	diceroll(user)

/obj/item/dice/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	diceroll(thrownby)
	. = ..()

/obj/item/dice/proc/diceroll(mob/user, sayit = TRUE)
	result = roll(sides)
	if(rigged && result != rigged)
		if(prob(clamp(1/(sides - 1) * 100, 25, 80)))
			result = rigged
	var/fake_result = roll(sides)//Daredevil isn't as good as he used to be
	var/comment = ""
	if(sides == 20 && result == 20)
		comment = "NAT 20!"
	else if(sides == 20 && result == 1)
		comment = "Ouch, bad luck."
	update_icon()
	if(initial(icon_state) == "d00")
		result = (result - 1)*10
	if(special_faces.len == sides)
		result = special_faces[result]
	if(sayit)
		say_result(user, fake_result, comment)

/obj/item/dice/proc/say_result(mob/user, fake_result, comment)
	if(!isnull(user)) //Dice was rolled in someone's hand
		user.visible_message("[user] has thrown [src]. It lands on [result]. [comment]", \
							span_notice("You throw [src]. It lands on [result]. [comment]"), \
							span_italic("You hear [src] rolling, it sounds like a [fake_result]."))
	else if(!src.throwing) //Dice was thrown and is coming to rest
		visible_message(span_notice("[src] rolls to a stop, landing on [result]. [comment]"))

/obj/item/dice/update_overlays()
	. = ..()
	. += "[icon_state]-[result]"

/obj/item/dice/microwave_act(obj/machinery/microwave/M)
	if(can_be_rigged)
		rigged = result
	..(M)

/obj/item/storage/bag/dice_cup
	name = "dice cup"
	desc = "Put dice in this cup! Click it to roll them inside the cup! Smack it on a table to dump em out! Gambling is fun!"
	icon = 'icons/obj/drinks.dmi'
	icon_state = "stone_mug"
	max_reach = 7
	component_type = /datum/component/storage/concrete/bag/dice_cup

/obj/item/storage/bag/dice_cup/ComponentInitialize()
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_ATTACK_SELF,        PROC_REF(rattle_them_bones))
	RegisterSignal(src, COMSIG_TABLE_CLICKED_WITH_ITEM, PROC_REF(click_on_table))

/obj/item/storage/bag/dice_cup/proc/rattle_them_bones(datum/source, mob/M)
	if(!M)
		return
	if(!LAZYLEN(contents))
		M.visible_message(
			span_notice("[M] rattles [M.p_their()] empty dice cup! Pass the dice, please!"),
			span_italic("You rattle your empty dice cup!"))
		return
	M.visible_message(
		span_notice("[M] rattles [M.p_their()] dice cup! The dice inside clatter!"),
		span_italic("You rattle your dice cup! The dice inside clatter!"))
	
/// actually rolls the dice and chunks them out on the table
/// must be a table, but ya know
/obj/item/storage/bag/dice_cup/proc/click_on_table(datum/source, obj/structure/table/T, mob/user, params)
	if(!T || !user)
		return
	/// first check if there are any dice on the table
	var/turf/tabturf = get_turf(T)
	if(!tabturf)
		return
	var/haz_dice = FALSE
	for(var/obj/item/dice/D in tabturf.contents)
		if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, D, user, TRUE))
			haz_dice = TRUE
	if(haz_dice)
		user.visible_message(
			span_notice("[user] gathers up the dice on the table and puts them in [src]."),
			span_italic("You gather up the dice on the table and put them in [src]."))
		return TABLE_NO_PLACE // I love this anime, Table No Place
	/// if there are no dice on the table, dump the dice cup's contents
	if(!LAZYLEN(contents))
		return
	var/list/output_messages = list()
	for(var/obj/item/dice/D in contents)
		if(!SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, D, tabturf, FALSE))
			continue
		D.diceroll(user, FALSE)
		output_messages += "[FOURSPACES]\A [D] rolls: [D.result]"
		D.pixel_x = rand(-16, 16)
		D.pixel_y = rand(-16, 16)
	var/msg_out = span_green("[user] dumps the dice out of \the [src]! And here are the results...<br>")
	msg_out += span_notice(output_messages.Join("<br>"))
	user.visible_message(msg_out)
	return TABLE_NO_PLACE
