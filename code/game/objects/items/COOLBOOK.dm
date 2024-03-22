/// Cus wikis are for chumps who actually update them

/obj/item/cool_book
	name = "Fancy Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	w_class = WEIGHT_CLASS_SMALL
	/// The key to the book's entry in the library.
	var/book_key = "example"
	/// The chapter we're on. If null, its the index page.
	var/chapter
	/// The page we're on
	var/page = 1

/obj/item/cool_book/hnguide
	name = "Fancy Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	book_key = "hnguide"
	color = "#ff3388"

/obj/item/cool_book/druidguide
	name = "Fancy Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	book_key = "druidguide"

/obj/item/cool_book/shamanguide
	name = "Gecko Skin Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book5"
	color = "#335533"
	book_key = "shamanguide"

/obj/item/cool_book/teacherguidebook
	name = "Teachers Guide"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book8"
	color = "#FFD700"
	book_key = "teacherguidebook"

/obj/item/cool_book/warriorguide
	name = "Gecko Skin Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book5"
	color = "#553333"
	book_key = "warriorguide"

/obj/item/cool_book/villagerguide
	name = "Molerat Skin Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book5"
	color = "#333355"
	book_key = "villagerguide"

/obj/item/cool_book/chiefguide
	name = "Deathclaw Skin Book"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book5"
	color = "#888833"
	book_key = "chiefguide"

/obj/item/cool_book/ashdowncit
	name = "Guide to Ashdown"
	desc = "This is an error. If you see this, inform a developer!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book5"
	color = "#CC3333"
	book_key = "ashcitguide"

/obj/item/cool_book/guildguide
	name = "Guild Guidebook"
	desc = "Thats a guidebook for the Adventurers Guild!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	book_key = "guildguide"
	color = "#f89b06"

/obj/item/cool_book/reclaimerguide
	name = "Reclaimer Guidebook"
	desc = "Thats a guidebook for the Reclaimers!"
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	book_key = "reclaimerguide"
	color = "#9999F6"

/obj/item/cool_book/warandpeace
	name = "War And Peace, Book One"
	desc = "Thats literally just a copy of War and Peace..."
	icon = 'icons/obj/library.dmi'
	icon_state = "book1"
	book_key = "wnp1"
	color = "#db2100"
	force = 30
	force_wielded = 45
	force_unwielded = 30
	throwforce = 35

/obj/item/cool_book/Initialize()
	. = ..()
	bookify()

/obj/item/cool_book/proc/bookify()
	var/datum/cool_book/mybook = SScool_books.get_book(book_key)
	if(!mybook)
		CRASH("Book key [book_key] does not exist in the library!")
	name = mybook.title
	desc = mybook.desc
	icon_state = mybook.cover

/obj/item/cool_book/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/simple/dynamic/book_images),
	)

/obj/item/cool_book/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CoolBook", name)
		ui.open()

/obj/item/cool_book/ui_data(mob/user)
	var/list/data = SScool_books.format_book_for_tgui(book_key, chapter, page)
	return data

/obj/item/cool_book/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("NextPage")
			page++
			page = clamp(page, 1, SScool_books.get_max_pages(book_key, chapter))
			return TRUE
		if("PrevPage")
			page--
			page = max(page, 1)
			return TRUE
		if("SetChapter")
			chapter = params["Chapter2Set"]
			page = 1
			return TRUE

