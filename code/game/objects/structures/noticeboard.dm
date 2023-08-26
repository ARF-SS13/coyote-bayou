/obj/structure/noticeboard
	name = "notice board"
	desc = "A board for pinning important notices upon."
	icon = 'icons/fallout/objects/furniture/stationary.dmi'
	icon_state = "nboard00"
	plane = ABOVE_WALL_PLANE
	density = FALSE
	anchored = TRUE
	max_integrity = 150
	var/notices = 0
	var/noticeLimit = 5 // How many papers can you stick to a noticeboard?
	var/persistenceID = null

/obj/structure/noticeboard/Initialize(mapload)
	. = ..()

	if(!mapload)
		return

	for(var/obj/item/I in loc)
		if(notices > 4)
			break
		if(istype(I, /obj/item/paper))
			I.forceMove(src)
			notices++
	icon_state = "nboard0[notices]"
	LAZYADD(SSpersistence.noticeBoards, src)

/obj/structure/noticeboard/Destroy()
	LAZYREMOVE(SSpersistence.noticeBoards, src)
	..()

/obj/structure/noticeboard/proc/PersistenceLoad()
	var/list/data = SSpersistence.GetNoticeboardsPhotos()
	if(data[persistenceID])
		PopulatePhotosFromIDList(data[persistenceID])

/obj/structure/noticeboard/proc/PopulatePhotosFromIDList(list/ids)
	var/list/current_ids = GetPictureIDList()
	for(var/i in ids)
		if(i in current_ids)
			continue
		var/obj/item/photo/P = load_photo_from_disk(i)
		if(P)
			P.forceMove(src)
			notices++
	update_icon()

/obj/structure/noticeboard/proc/PopulatePaperFromList(list/ids)
	var/list/current_ids = StorePaperDataList()
	for(var/i in ids)
		if(i in current_ids)
			continue
		var/obj/item/paper/P = new /obj/item/paper()
		if(P.LoadData(ids[i]))
			P.pers_id = i
			P.forceMove(src)
			notices++
	update_icon()

/obj/structure/noticeboard/proc/StorePaperDataList()
	var/list/L = list()
	for(var/i in contents)
		if(istype(i, /obj/item/paper))
			L += i

	if(!L.len)
		return
	. = list()
	var/list/paperData = list()
	for(var/i in L)
		var/obj/item/paper/P = i
		if(!P.pers_id)
			P.pers_id = "[persistenceID]_[md5(strip_html(P.info))]" // cursed but it'll make it unique at least.
		var/list/dat = P.SaveData()
		if(dat.len)
			paperData[P.pers_id] = dat
	
	if(paperData.len)
		. = paperData
	
/obj/structure/noticeboard/proc/GetPictureIDList()
	var/list/L = list()
	for(var/i in contents)
		if(istype(i, /obj/item/photo))
			L += i
	if(!L.len)
		return
	. = list()
	for(var/i in L)
		var/obj/item/photo/P = i
		if(!istype(P.picture))
			continue
		. |= P.picture.id

//attaching papers!!
/obj/structure/noticeboard/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/paper) || istype(O, /obj/item/photo))
		if(!allowed(user))
			to_chat(user, span_info("You are not authorized to add notices"))
			return
		if(notices < noticeLimit)
			if(!user.transferItemToLoc(O, src))
				return
			notices++
			update_icon()
			to_chat(user, span_notice("You pin the [O] to the noticeboard."))
		else
			to_chat(user, span_notice("The notice board is full"))
	else
		return ..()

/obj/structure/noticeboard/update_icon()
	icon_state = "nboard0[clamp(notices, 0, 5)]"
	..()

/obj/structure/noticeboard/interact(mob/user)
	ui_interact(user)

/obj/structure/noticeboard/ui_interact(mob/user)
	. = ..()
	var/auth = allowed(user)
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/P in src)
		if(istype(P, /obj/item/paper))
			dat += "<A href='?src=[REF(src)];read=[REF(P)]'>[P.name]</A> [auth ? "<A href='?src=[REF(src)];write=[REF(P)]'>Write</A> <A href='?src=[REF(src)];remove=[REF(P)]'>Remove</A>" : ""]<BR>"
		else
			dat += "<A href='?src=[REF(src)];read=[REF(P)]'>[P.name]</A> [auth ? "<A href='?src=[REF(src)];remove=[REF(P)]'>Remove</A>" : ""]<BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=noticeboard")
	onclose(user, "noticeboard")

/obj/structure/noticeboard/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if((usr.stat || usr.restrained()))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/I = locate(href_list["remove"]) in contents
		if(istype(I) && I.loc == src)
			I.forceMove(usr.loc)
			usr.put_in_hands(I)
			notices--
			icon_state = "nboard0[notices]"

	if(href_list["write"])
		if((usr.stat || usr.restrained())) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"]) in contents
		if(istype(P) && P.loc == src)
			var/obj/item/I = usr.is_holding_item_of_type(/obj/item/pen)
			if(I)
				add_fingerprint(usr)
				P.attackby(I, usr)
			else
				to_chat(usr, span_notice("You'll need something to write with!"))

	if(href_list["read"])
		var/obj/item/I = locate(href_list["read"]) in contents
		if(istype(I) && I.loc == src)
			usr.examinate(I)

/obj/structure/noticeboard/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		new /obj/item/stack/sheet/metal (loc, 1)
	qdel(src)

// Notice boards for the heads of staff (plus the qm)

/obj/structure/noticeboard/captain
	name = "Captain's Notice Board"
	desc = "Important notices from the Captain."
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/noticeboard/hop
	name = "Head of Personnel's Notice Board"
	desc = "Important notices from the Head of Personnel."
	req_access = list(ACCESS_HOP)

/obj/structure/noticeboard/ce
	name = "Chief Engineer's Notice Board"
	desc = "Important notices from the Chief Engineer."
	req_access = list(ACCESS_CE)

/obj/structure/noticeboard/hos
	name = "Head of Security's Notice Board"
	desc = "Important notices from the Head of Security."
	req_access = list(ACCESS_HOS)

/obj/structure/noticeboard/cmo
	name = "Chief Medical Officer's Notice Board"
	desc = "Important notices from the Chief Medical Officer."
	req_access = list(ACCESS_CMO)

/obj/structure/noticeboard/rd
	name = "Research Director's Notice Board"
	desc = "Important notices from the Research Director."
	req_access = list(ACCESS_RD)

/obj/structure/noticeboard/qm
	name = "Quartermaster's Notice Board"
	desc = "Important notices from the Quartermaster."
	req_access = list(ACCESS_QM)

/obj/structure/noticeboard/staff
	name = "Staff Notice Board"
	desc = "Important notices from the heads of staff."
	req_access = list(ACCESS_HEADS)
