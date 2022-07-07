/obj/vertibird
	name = "VB-02"
	icon = 'icons/fallout/vehicles/vertibird.dmi'
	icon_state = "vb-static"
	pixel_x = -128
	pixel_y = -64
	layer = 4
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE
	density = TRUE
	var/engine = FALSE
	var/locked = FALSE
	var/inFly = FALSE
	var/obj/machinery/camera/portable/builtInCamera

/obj/vertibird/New()
	var/obj/item/start = new /obj/effect/landmark/vertibird()
	start.name = "Vertibird Initial Point"
	start.loc = loc
	if(GLOB.vertibird)
		CRASH("Vertibird already exists!")
	GLOB.vertibird = src

/obj/vertibird/attack_hand(mob/user)
	if(locked)
		to_chat(usr, "It's locked.")
		return

	if(inFly)
		return

	getIn(user)

/obj/vertibird/proc/toggleLock(mob/user)
	if(locked)
		locked = FALSE
		to_chat(user, "You unlock the vertibird.")
	else
		locked = TRUE
		to_chat(user, "You lock the vertibird.")

/obj/vertibird/attackby(obj/item/weapon/W, mob/user, params)
	if(istype(W, /obj/item/key/vertibird))
		toggleLock(user)

/obj/vertibird/MouseDrop_T(obj/O, mob/user)
	if(locked)
		to_chat(usr, "It's locked.")
		return

	moveIn(O)

/obj/vertibird/proc/getIn(mob/U)
	src.visible_message("[U] enters the vertibird.")
	U.forceMove(GLOB.vertibirdEnterZone)

/obj/vertibird/proc/moveIn(obj/O)
	O.forceMove(GLOB.vertibirdEnterZone)

/obj/vertibird/proc/ejectTurf()
	return locate(src.x, src.y + 6, src.z)

/obj/vertibird/proc/getLocationsHTML()
	var/html
	for(var/I = 1 to GLOB.vertibirdLandZone.len)
		var/obj/effect/landmark/vertibird/mark = GLOB.vertibirdLandZone[I]
		html += "<a href='?src=\ref[src];fly=true;x=[mark.x];y=[mark.y];z=[mark.z]'>[mark.name]</a><br>"
	return html

/obj/vertibird/proc/flew(targetX, targetY, targetZ)

	x = targetX
	y = targetY
	z = targetZ

	playsound(src, "sound/f13machines/vertibird_stop.ogg", 100)
	playsound(GLOB.vertibirdEnterZone, "sound/f13machines/vertibird_stop.ogg", 50)

	spawn(100)
		inFly = FALSE
		src.icon_state = "vb-slow"

	spawn(300)
		if(src.icon_state == "vb-slow")
			src.icon_state = "vb-static"

/obj/vertibird/proc/beginFly()
	var/datum/browser/popup = new(usr, "vending", (name))
	popup.set_content(getLocationsHTML())
	popup.open()

/obj/vertibird/proc/flyGlobal()
	to_chat(world, "<font size='3' color='orange'>The ever increasing roar of an aircraft tearing through the skies above enters your ears.</font>")
	var/sound/global_sound
	global_sound = sound("sound/effects/flyby.ogg", repeat = 0, wait = 0, channel = 776)
	global_sound.priority = 250
	global_sound.status = SOUND_UPDATE|SOUND_STREAM


/obj/vertibird/proc/fly(targetX, targetY, targetZ)
	if(inFly)
		return

	playsound(src, "sound/f13machines/vertibird_start.ogg", 100)
	playsound(GLOB.vertibirdEnterZone, "sound/f13machines/vertibird_start.ogg", 50)
	inFly = TRUE
	icon_state = "vb-fast"
	spawn(60)
		playsound(src, "sound/effects/flyby.ogg", 100)
		playsound(GLOB.vertibirdEnterZone, "sound/effects/flyby.ogg", 50)

		flyGlobal()

		spawn(100)
			flew(targetX, targetY, targetZ)

/obj/vertibird/Topic(href, href_list)
	if(..())
		return

	if(href_list["fly"])
		var/x = text2num(href_list["x"])
		var/y = text2num(href_list["y"])
		var/z = text2num(href_list["z"])
		fly(x, y, z)
