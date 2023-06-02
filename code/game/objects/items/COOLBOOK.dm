/// Cus wikis are for chumps who actually update them

/obj/item/cool_book
	name = "Fancy Book"
	desc = "Wow! What a fancy book! Looks like it'll support all kinds of Inferno-brand coffee tables."
	icon = 'modular_coyote/icons/objects/survival_guide.dmi'
	icon_state = "survbook"
	/// The key to the book's entry in the library.
	var/book_key = "example"
	/// The chapter we're on. If null, its the index page.
	var/chapter
	/// The page we're on
	var/page = 1

/obj/item/cool_book/Initialize()
	. = ..()
	bookify()

/obj/item/cool_book/proc/bookify()
	var/datum/cool_book/mybook = SScool_books.get_book(book_key)
	if(!mybook)
		CRASH("Book key [book_key] does not exist in the library!")
	name = mybook.title
	desc = mybook.desc

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

