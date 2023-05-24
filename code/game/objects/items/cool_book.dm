/// Cus wikis are for chumps who actually update them

/obj/item/cool_book
	name = "Fancy Book"
	desc = "Wow! What a fancy book! Looks like it'll support all kinds of Inferno-brand coffee tables."
	icon = 'modular_coyote/icons/objects/survival_guide.dmi'
	icon_state = "survbook"
	/// The key to the book's entry in the library.
	var/book_key = "default"

/obj/item/cool_book/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CoolBook", name)
		ui.open()

/obj/item/cool_book/ui_data(mob/user)
	return SSbooks.format_book_for_tgui(book_key)
	




/obj/item/cool_book/ui_act(action, params)
	if(..())
		return
	switch(action)
		if("amount")
			if(!is_operational() || QDELETED(beaker))
				return
			var/target = text2num(params["target"])
			if(target in beaker.possible_transfer_amounts)
				amount = target
				work_animation()
				. = TRUE

