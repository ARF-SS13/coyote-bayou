//////////
//DILDOS//
//////////
/obj/item/dildo
	name 				= "dildo"
	desc 				= "Floppy!"
	icon 				= 'icons/obj/genitals/dildo.dmi'
	force 				= 0
	hitsound			= 'sound/weapons/tap.ogg'
	throwforce			= 0
	icon_state 			= "dildo_knotted_2"
	alpha 				= 192//transparent
	var/can_customize	= FALSE
	var/dildo_shape 	= "human"
	var/dildo_size		= 2
	var/dildo_type		= "dildo"//pretty much just used for the icon state
	var/random_color 	= TRUE
	var/random_size 	= FALSE
	var/random_shape 	= FALSE
	var/is_knotted		= FALSE
	//Lists moved to _cit_helpers.dm as globals so they're not instanced individually

/obj/item/dildo/update_icon()
	icon_state = "[dildo_type]_[dildo_shape]_[dildo_size]"
	name = "[GLOB.dildo_size_names[dildo_size]] [dildo_shape][can_customize ? " custom" : ""] [dildo_type]"

/obj/item/dildo/AltClick(mob/living/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	customize(user)
	return TRUE

/obj/item/dildo/proc/customize(mob/living/user)
	if(!can_customize)
		return FALSE
	if(src && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		var/color_choice = input(user,"Choose a color for your dildo.","Dildo Color") as null|anything in GLOB.dildo_colors
		if(src && color_choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
			sanitize_inlist(color_choice, GLOB.dildo_colors, "Red")
			color = GLOB.dildo_colors[color_choice]
	update_icon()
	if(src && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		var/shape_choice = input(user,"Choose a shape for your dildo.","Dildo Shape") as null|anything in GLOB.dildo_shapes
		if(src && shape_choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
			sanitize_inlist(shape_choice, GLOB.dildo_colors, "Knotted")
			dildo_shape = GLOB.dildo_shapes[shape_choice]
	update_icon()
	if(src && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		var/size_choice = input(user,"Choose the size for your dildo.","Dildo Size") as null|anything in GLOB.dildo_sizes
		if(src && size_choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
			sanitize_inlist(size_choice, GLOB.dildo_colors, "Medium")
			dildo_size = GLOB.dildo_sizes[size_choice]
	update_icon()
	if(src && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
		var/transparency_choice = input(user,"Choose the transparency of your dildo. Lower is more transparent!(192-255)","Dildo Transparency") as null|num
		if(src && transparency_choice && !user.incapacitated(allow_crit = TRUE) && in_range(user,src))
			sanitize_integer(transparency_choice, 192, 255, 192)
			alpha = transparency_choice
	update_icon()
	return TRUE

/obj/item/dildo/Initialize(mapload)
	. = ..()
	if(random_color == TRUE)
		var/randcolor = pick(GLOB.dildo_colors)
		color = GLOB.dildo_colors[randcolor]
	if(random_shape == TRUE)
		var/randshape = pick(GLOB.dildo_shapes)
		dildo_shape = GLOB.dildo_shapes[randshape]
	if(random_size == TRUE)
		var/randsize = pick(GLOB.dildo_sizes)
		dildo_size = GLOB.dildo_sizes[randsize]
	update_icon()
	alpha		= rand(192, 255)
	pixel_y 	= rand(-7,7)
	pixel_x 	= rand(-7,7)

/obj/item/dildo/examine(mob/user)
	. = ..()
	if(can_customize)
		. += "<span class='notice'>Alt-Click \the [src.name] to customize it.</span>"

/obj/item/dildo/random//totally random
	name 				= "random dildo"//this name will show up in vendors and shit so you know what you're vending(or don't, i guess :^))
	random_color 		= TRUE
	random_shape 		= TRUE
	random_size 		= TRUE

/obj/item/dildo/knotted
	dildo_shape 		= "knotted"
	name 				= "knotted dildo"
	attack_verb 		= list("penetrated", "knotted", "slapped", "inseminated")

/obj/item/dildo/human
	dildo_shape 		= "human"
	name 				= "human dildo"
	attack_verb = list("penetrated", "slapped", "inseminated")

/obj/item/dildo/plain
	dildo_shape 		= "plain"
	name 				= "plain dildo"
	attack_verb 		= list("penetrated", "slapped", "inseminated")

/obj/item/dildo/flared
	dildo_shape 		= "flared"
	name 				= "flared dildo"
	attack_verb 		= list("penetrated", "slapped", "neighed", "gaped", "prolapsed", "inseminated")

/obj/item/dildo/flared/huge
	name 				= "The Penetrator"
	desc 				= "The absurdity of a sex toy with the lethality of a baseball bat."
	dildo_size 			= 4
	force				= 10
	hitsound = 'sound/weapons/klonk.ogg'

/obj/item/dildo/custom
	name 				= "customizable dildo"
	desc 				= "Thanks to significant advances in synthetic nanomaterials, this dildo is capable of taking on many different forms to fit the user's preferences! Pricy!"
	can_customize		= TRUE
	random_color 		= TRUE
	random_shape 		= TRUE
	random_size 		= TRUE

/obj/item/dildo/flared/gigantic
	name 				= "bitch breaker"
	desc 				= "You can barely carry this thing! Meant for... \"advanced\" interrogation techniques."
	dildo_size 			= 5
	attack_verb 		= list("penetrated", "slapped", "gaped", "prolapsed", "inseminated", "destroyed", "broke", "demolished", "whacked")
