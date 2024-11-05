/obj/item/airlock_painter
	name = "airlock painter"
	desc = "An advanced autopainter preprogrammed with several paintjobs for airlocks. Use it on an airlock during or after construction to change the paintjob."
	icon = 'icons/obj/objects.dmi'
	icon_state = "paint sprayer"
	inhand_icon_state = "paint sprayer"

	w_class = WEIGHT_CLASS_SMALL

	custom_materials = list(/datum/material/iron=50, /datum/material/glass=50)

	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	slot_flags = INV_SLOTBIT_BELT
	usesound = 'sound/effects/spray2.ogg'

	var/obj/item/toner/ink = null

/obj/item/airlock_painter/Initialize()
	. = ..()
	ink = new /obj/item/toner(src)

//This proc doesn't just check if the painter can be used, but also uses it.
//Only call this if you are certain that the painter will be used right after this check!
/obj/item/airlock_painter/proc/use_paint(mob/user)
	if(can_use(user))
		ink.charges--
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, 1)
		return 1
	else
		return 0

//This proc only checks if the painter can be used.
//Call this if you don't want the painter to be used right after this check, for example
//because you're expecting user input.
/obj/item/airlock_painter/proc/can_use(mob/user)
	if(!ink)
		to_chat(user, span_notice("There is no toner cartridge installed in [src]!"))
		return 0
	else if(ink.charges < 1)
		to_chat(user, span_notice("[src] is out of ink!"))
		return 0
	else
		return 1

/obj/item/airlock_painter/examine(mob/user)
	. = ..()
	if(!ink)
		. += span_notice("It doesn't have a toner cartridge installed.")
		return
	var/ink_level = "high"
	if(ink.charges < 1)
		ink_level = "empty"
	else if((ink.charges/ink.max_charges) <= 0.25) //25%
		ink_level = "low"
	else if((ink.charges/ink.max_charges) > 1) //Over 100% (admin var edit)
		ink_level = "dangerously high"
	. += span_notice("Its ink levels look [ink_level].")


/obj/item/airlock_painter/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/toner))
		if(ink)
			to_chat(user, span_notice("[src] already contains \a [ink]."))
			return
		if(!user.transferItemToLoc(W, src))
			return
		to_chat(user, span_notice("You install [W] into [src]."))
		ink = W
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
	else
		return ..()

/obj/item/airlock_painter/attack_self(mob/user)
	if(ink)
		playsound(src.loc, 'sound/machines/click.ogg', 50, 1)
		ink.forceMove(user.drop_location())
		user.put_in_hands(ink)
		to_chat(user, span_notice("You remove [ink] from [src]."))
		ink = null


/obj/item/airlock_painter/decal
	name = "decal painter"
	desc = "An airlock painter, reprogramed to use a different style of paint in order to apply decals for floor tiles as well, in addition to repainting doors. Decals break when the floor tiles are removed. Alt-Click to change design."
	icon = 'icons/obj/objects.dmi'
	icon_state = "decal_sprayer"
	inhand_icon_state = "decalsprayer"
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=500)
	var/stored_dir = 2
	var/stored_color = ""
	var/stored_decal = "warningline"
	var/stored_decal_total = "warningline"
	var/color_list = list("","red","white")
	var/dir_list = list(1,2,4,8)
	var/decal_list = list(list("Warning Line","warningline"),
			list("Warning Line Corner","warninglinecorner"),
			list("Caution Label","caution"),
			list("Directional Arrows","arrows"),
			list("Stand Clear Label","stand_clear"),
			list("Box","box"),
			list("Box Corner","box_corners"),
			list("Delivery Marker","delivery"),
			list("Warning Box","warn_full"))

/obj/item/airlock_painter/decal/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/turf/open/floor/F = target
	if(!proximity)
		to_chat(user, span_notice("You need to get closer!"))
		return
	if(use_paint(user) && isturf(F))
		F.AddElement(/datum/element/decal, 'icons/turf/decals.dmi', stored_decal_total, turn(stored_dir, -dir2angle(F.dir)), CLEAN_STRONG, color, null, null, alpha)

/obj/item/airlock_painter/decal/attack_self(mob/user)
	if((ink) && (ink.charges >= 1))
		to_chat(user, span_notice("[src] beeps to prevent you from removing the toner until out of charges."))
		return
	. = ..()

/obj/item/airlock_painter/decal/AltClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/airlock_painter/decal/Initialize()
	. = ..()
	ink = new /obj/item/toner/large(src)

/obj/item/airlock_painter/decal/proc/update_decal_path()
	var/yellow_fix = "" //This will have to do until someone refactor's markings.dm
	if (stored_color)
		yellow_fix = "_"
	stored_decal_total = "[stored_decal][yellow_fix][stored_color]"
	return

/obj/item/airlock_painter/decal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DecalPainter", name)
		ui.open()

/obj/item/airlock_painter/decal/ui_data(mob/user)
	var/list/data = list()
	data["decal_direction"] = stored_dir
	data["decal_color"] = stored_color
	data["decal_style"] = stored_decal
	data["decal_list"] = list()
	data["color_list"] = list()
	data["dir_list"] = list()

	for(var/i in decal_list)
		data["decal_list"] += list(list(
			"name" = i[1],
			"decal" = i[2]
		))
	for(var/j in color_list)
		data["color_list"] += list(list(
			"colors" = j
		))
	for(var/k in dir_list)
		data["dir_list"] += list(list(
			"dirs" = k
		))
	return data

/obj/item/airlock_painter/decal/ui_act(action,list/params)
	if(..())
		return
	switch(action)
		//Lists of decals and designs
		if("select decal")
			var/selected_decal = params["decals"]
			stored_decal = selected_decal
		if("select color")
			var/selected_color = params["colors"]
			stored_color = selected_color
		if("selected direction")
			var/selected_direction = text2num(params["dirs"])
			stored_dir = selected_direction
	update_decal_path()
	. = TRUE

/obj/item/airlock_painter/decal/debug
	name = "extreme decal painter"
	icon_state = "decal_sprayer_ex"

/obj/item/airlock_painter/decal/debug/Initialize()
	. = ..()
	ink = new /obj/item/toner/extreme(src)


/obj/item/airlock_painter/tile
	name = "tile painter"
	desc = "An industrial tool for painting different designs onto tiles - a must-have gadget for aesthetic chasers. Alt-Click to change design."
	icon = 'icons/obj/objects.dmi'
	icon_state = "tile_sprayer"
	inhand_icon_state = "tilesprayer"
	custom_materials = list(/datum/material/iron=2000, /datum/material/glass=2000) // = one sheet of both
	var/stored_dir = 2
	var/stored_color = ""
	var/stored_decal = "floor"
	var/stored_decal_total = "floor"
	var/color_list = list("","red","white")
	var/dir_list = list(1,2,4,8)
	var/decal_list = list(list("Grey Tile","floor"),
			list("Grey Solid","floorsolid"),
			list("White Tile","white"),
			list("White Solid","whitesolid"),
			list("Dark Tile","dark"),
			list("Dark Solid","darksolid"),
			list("Red Tile","redfull"),
			list("Red Solid","redsolid"),
			list("Red-Grey Checkers","redchess"),
			list("Red-White Checkers","whiteredchess"),
			list("Green Tile","greenfull"),
			list("Green Solid","greensolid"),
			list("Green-Grey Checkers","greenchess"),
			list("Green-White Checkers","whitegreenchess"),
			list("Yellow Tile","yellowfull"),
			list("Yellow Solid","darkbrownfull"),
			list("Yellow-Grey Checkers","yellowchess"),
			list("Yellow-White Checkers","whiteyellowchess"),
			list("Blue Tile","bluefull"),
			list("Blue Solid","bluesolid"),
			list("Blue-Grey Checkers","bluechess"),
			list("Blue-White Checkers","whitebluechess"),
			list("Purple Tile","purplefull"),
			list("Purple Solid","purplesolid"),
			list("Purple-Grey Checkers","purplechess"),
			list("Purple-White Checkers","whitepurplechess"),
			list("Teal Tile","neutralfull2"),
			list("Teal Solid","neutralsolid"),
			list("Teal-Grey Checkers","neutralchess"),
			list("Teal-White Checkers","whiteneutralchess"),
			list("Dark Brown Tile","darkbrownfull"),
			list("Red-Yellow Checkers","redyellowfull"),
			list("Red-Blue Checkers","redbluefull"),
			list("Red-Green Checkers","redgreenfull"),
			list("Green-Yellow Checkers","greenyellowfull"),
			list("Green-Blue Checkers","greenbluefull"),
			list("Blue-Yellow Checkers","blueyellowfull"),
			list("Bar","bar"),
			list("Cafeteria","cafeteria"),
			list("Freezer","freezerfloor"),
			list("Hydroponics","hydrofloor"),
			list("Showroom","showroomfloor"),
			list("Vault","vault"))

/obj/item/airlock_painter/tile/proc/isValidSurface(surface)
	return istype(surface, /turf/open/floor/plasteel)

/obj/item/airlock_painter/tile/afterattack(atom/target, mob/user, proximity)
	. = ..()
	var/turf/open/floor/F = target
	if(!proximity)
		to_chat(user, span_notice("You need to get closer!"))
		return
	if(use_paint(user) && isValidSurface(F))
		playsound(src.loc, 'sound/effects/spray2.ogg', 50, 1)
		F.AddElement(/datum/element/decal, 'icons/fallout/turfs/floors.dmi', stored_decal_total, CLEAN_STRONG, null, null, alpha)
	else
		to_chat(user, span_notice("The tile painter can only be used on freshly laid tiles!"))
		return

/obj/item/airlock_painter/tile/attack_self(mob/user)
	if((ink) && (ink.charges >= 1))
		to_chat(user, span_notice("[src] beeps to prevent you from removing the toner until out of charges."))
		return
	. = ..()

/obj/item/airlock_painter/tile/AltClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/airlock_painter/tile/Initialize()
	. = ..()
	ink = new /obj/item/toner/large(src)

/obj/item/airlock_painter/tile/proc/update_decal_path()
	var/yellow_fix = "" //This will have to do until someone refactor's markings.dm
	if (stored_color)
		yellow_fix = "_"
	stored_decal_total = "[stored_decal][yellow_fix][stored_color]"
	return

/obj/item/airlock_painter/tile/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DecalPainter", name)
		ui.open()

/obj/item/airlock_painter/tile/ui_data(mob/user)
	var/list/data = list()
	data["decal_style"] = stored_decal
	data["decal_list"] = list()

	for(var/i in decal_list)
		data["decal_list"] += list(list(
			"name" = i[1],
			"decal" = i[2]
		))
	return data

/obj/item/airlock_painter/tile/ui_act(action,list/params)
	if(..())
		return
	switch(action)
		//Lists of decals and designs
		if("select decal")
			var/selected_decal = params["decals"]
			stored_decal = selected_decal
	update_decal_path()
	. = TRUE
