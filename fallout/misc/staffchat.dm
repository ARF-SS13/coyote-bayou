//this file is where we put all of our fortuna verb additions
GLOBAL_LIST_INIT(staff_verbs, list(
	/client/proc/cmd_staff_say,
	/client/proc/open_event_panel
	))
GLOBAL_PROTECT(staff_verbs)
GLOBAL_LIST_EMPTY(staff)
GLOBAL_PROTECT(staff)
/client/proc/add_staff_verbs()
	if(is_staff())
		add_verb(src, GLOB.staff_verbs)

/client/proc/remove_staff_verbs()
	remove_verb(src, GLOB.staff_verbs)


/client/proc/cmd_staff_say(msg as text)
	set category = "OOC"
	set name = "Schat"
	set hidden = 1
	if(!is_staff())
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	msg = emoji_parse(msg)
	log_mentor("STAFFCHAT: [key_name(src)] : [msg]")

	if(check_rights_for(src, R_ADMIN,0))
		msg = "<span class='mentorsay_admin filter_MSAY'><span class='prefix'>STAFF CHAT:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
	else
		msg = "<span class='mentorsay filter_MSAY'><span class='prefix'>STAFF CHAT:</span> <EM>[key_name(src, 0, 0)]</EM>: <span class='message'>[msg]</span></span>"
	to_chat(GLOB.admins | GLOB.staff, msg, confidential = TRUE)

//add or remove a targets crafting knowledge
/client/proc/modify_recipes(mob/living/target)
	set category = null
	set name = "Modify Recipes"

	if(!check_rights(R_SPAWN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use modify_recipes() without perms!")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use modify_recipes() without perms!")
		return

	var/valid_recipe
	var/datum/crafting_recipe/chosen_recipe = new
	var/list/our_known_recipes = list()
	if(!target)
		return
	for(var/recipes in target.mind.learned_recipes)
		our_known_recipes += recipes

	var/add_or_remove = input("Add or Remove recipe?", "Modify target's knowledge") as null|anything in list("Add","Remove")
	if(!add_or_remove)
		return

	
	switch(add_or_remove)
		if("Add")
			chosen_recipe = input(src, "Enter the recipe name to add to [target.name].", "Search recipes") as null|text
			if(isnull(chosen_recipe))
				return
			if(!ispath(text2path(chosen_recipe)))
				chosen_recipe = pick_closest_path(chosen_recipe, make_types_fancy(subtypesof(/datum/crafting_recipe)))
				if(ispath(chosen_recipe))
					valid_recipe = TRUE

			else
				valid_recipe = TRUE
			var/add_name = initial(chosen_recipe.name)
			if(!valid_recipe)
				to_chat(src, span_notice("No crafting recipe by that name found. Maybe you made a typo?"))
				return
			if(chosen_recipe in our_known_recipes)
				to_chat(src, span_notice("Target already knows the [add_name] recipe! Maybe you made a typo?"))
				return
			else
				target?.mind.teach_crafting_recipe(chosen_recipe)
				to_chat(src, span_notice("Target now knows the [add_name] recipe! They may need to reenter any open crafting menus."))
				to_chat(target, span_warning("You begin to remember how to make '[add_name]...'"))
				log_admin("[key_name(usr)] added [chosen_recipe] recipe to [key_name(target)].")
				message_admins("[key_name(usr)] added [chosen_recipe] recipe to [key_name(target)].")
		if("Remove")
			if(our_known_recipes.len)
				chosen_recipe = input("Pick a recipe to remove", "Modify target's knowledge") as null|anything in our_known_recipes
				var/remove_name = initial(chosen_recipe.name)
				if(chosen_recipe in our_known_recipes)
					target?.mind.learned_recipes -= chosen_recipe
					to_chat(src, span_notice("Target now no longer knows [remove_name]."))
					to_chat(target, span_warning("You feel the knowledge of '[remove_name]' slipping from your mind..."))
					log_admin("[key_name(usr)] removed [remove_name] from [key_name(target)].")
					message_admins("[key_name(usr)] removed [remove_name] from [key_name(target)].")
					return
				else
					to_chat(src, span_notice("Target did not know [chosen_recipe]. Maybe you made a typo?"))
					return
			else
				to_chat(src, span_warning("Target does not know any recipes!"))
				return

			
//event coordinator stuff
/datum/admins/proc/event_panel()
	if(!check_rights(R_SPAWN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use open_event_panel() without perms!")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use open_event_panel() without perms!")
		return

	var/dat = ""

	dat += "<head><style>body {padding: 0; margin: 15px; background-color: #062113; color: #4aed92; line-height: 170%;} a, button, a:link, a:visited, a:active, .linkOn, .linkOff {color: #4aed92; text-decoration: none; background: #062113; border: none; padding: 1px 4px 1px 4px; margin: 0 2px 0 0; cursor:default;} a:hover {color: #062113; background: #4aed92; border: 1px solid #4aed92} a.white, a.white:link, a.white:visited, a.white:active {color: #4aed92; text-decoration: none; background: #4aed92; border: 1px solid #161616; padding: 1px 4px 1px 4px; margin: 0 2px 0 0; cursor:default;} a.white:hover {color: #062113; background: #4aed92;} .linkOn, a.linkOn:link, a.linkOn:visited, a.linkOn:active, a.linkOn:hover {color: #4aed92; background: #062113; border-color: #062113;} .linkOff, a.linkOff:link, a.linkOff:visited, a.linkOff:active, a.linkOff:hover{color: #4aed92; background: #062113; border-color: #062113;}</style></head><font face='courier'>"
	dat += "<center><b>ROBCO INDUSTRIES UNIFIED OPERATING SYSTEM v.85</b><br>"
	dat += "<b>COPYRIGHT 2075-2077 ROBCO INDUSTRIES</b><br><br><br></center>"
	dat += "<br><br><font size=2><b>Event Coordinator's Terminal</b></font><br>"
	dat += "<b>_______________________________</b><br><br>"

	dat += "<br><font size=2>Be sure to be as specific as you can be with these commands!</font><br>"
	dat += "<br><font size=1>Never spawn obvious parent types. Example: obj/item/gun is NOT something you should spawn! You need a specific subtype.</font><br>"
	dat += "<br><font size=1>You can locate a subtype by simply searching for the weapon's name. You may need to enlarge the window by dragging at the corner to view the full results to verify which is which.</font><br>"
	dat += "<br><font size=1>Being lazy with this command directly lags the server and Buffy will know! So try to be efficient. <3</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"

	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];create_object=1'>Create Object</A><br><br></font>"
	dat += "<br><font size=1>Spawn an object (type of /obj).</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"
	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];quick_create_object=1'>Quick Create Object</A><br><br></font>"
	dat += "<br><font size=1>DO IT QUICKLY MY CHILDS</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"
	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];create_turf=1'><b>Create Turf</b></A><br><br></font>"
	dat += "<br><font size=1>Spawn a floor (type of /turf).</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"
	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];create_mob=1'><b>Create Mob</b></A><br><br></font>"
	dat += "<br><font size=1>Spawn a mob (type of /mob).</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"
	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];toggle_build=1'><b>Toggle Build Mode</b></font></a>"
	dat += "<br><br><font size=2>Enables build mode. Use this instead of spawning 500 things by hand please.</font><br><br>"
	dat += "<b>_______________________________</b><br><br>"
	dat += "<font size=3><A href='?src=[REF(src)];[HrefToken()];toggle_invis=1'>Toggle Own Invisibility</a></font>"
	dat += "<br><br><font size=1>Makes you invisible if you are alive.<br><br></font>"

	var/datum/browser/popup = new(usr, "eventcoordpanel", "Event Coordinator Panel", 500, 750)
	popup.set_content(dat)
	popup.open()
	return

/client/proc/open_event_panel()
	set name = "Event Coordinator Panel"
	set category = "Admin.Fun"

	if(!check_rights(R_SPAWN))
		message_admins("[ADMIN_TPMONTY(usr)] tried to use open_event_panel() without perms!")
		log_admin("INVALID ADMIN PROC ACCESS: [key_name(usr)] tried to use open_event_panel() without perms!")
		return
	
	src.holder.event_panel()

//for the client to optionally go fullscreen
/client/verb/toggle_fullscreenwindow()
	set category = "Preferences"
	set name = "Toggle Fullscreen"

	src.is_fullscreen = !src.is_fullscreen

	if(src.is_fullscreen)
		winset(src, "mainwindow", "is-maximized=false;can-resize=false;titlebar=false;menu=menu")
		winset(src, "mainwindow.mainvsplit", "pos=0x0")
	else
		winset(src, "mainwindow", "is-maximized=false;can-resize=true;titlebar=true;menu=menu")
		winset(src, "mainwindow.mainvsplit", "pos=3x0")
	winset(src, "mainwindow", "is-maximized=true")

	fit_viewport()

// writing this here for testing reasons pls ignore
