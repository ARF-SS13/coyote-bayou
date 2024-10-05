#define RESKIN_BE_ALIVE (1<<0)
#define RESKIN_MUST_HOLD (1<<1)
#define RESKIN_MUST_BE_NEAR (1<<2)
#define RESKIN_ONCE (1<<3)
#define RESKIN_COOLDOWN (1<<4)
#define RESKIN_SKINDEX_ORIGINAL "This Thing's Default Skin"

GLOBAL_LIST_EMPTY(reskin_list)

/datum/component/reskinnable
	/// Only living mobs can reskin it
	var/reskin_flags = RESKIN_BE_ALIVE | RESKIN_MUST_HOLD | RESKIN_MUST_BE_NEAR | RESKIN_COOLDOWN
	/// Holds a list of all the appearances that can be cycled through.
	/// They're keys to datums! Cool huh?
	var/list/skins = list()
	/// index of the current appearance in the list
	var/skindex
	/// our original skin
	var/datum/reskin/my_original_skin
	/// Actually use the original skin thing
	var/use_original_skin = TRUE
	/// The cooldown between reskins
	var/reskin_cooldown = 5 SECONDS
	COOLDOWN_DECLARE(reskin_when)
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

/datum/component/reskinnable/Initialize(list/skin_override = list())
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE
	if(LAZYLEN(skin_override))
		skins = skin_override.Copy()
	initialize_skins()
	RegisterSignal(parent, list(COMSIG_CLICK_CTRL_SHIFT),PROC_REF(open_skin_picker))
	RegisterSignal(parent, list(COMSIG_ITEM_RESKINNABLE),PROC_REF(is_reskinnable))
	RegisterSignal(parent, list(COMSIG_ITEM_UPDATE_RESKIN),PROC_REF(update_skin))
	RegisterSignal(parent, list(COMSIG_ITEM_GET_CURRENT_RESKIN),PROC_REF(get_current_skin))
	RegisterSignal(parent, list(COMSIG_ITEM_SET_SKIN),PROC_REF(force_skin))

/datum/component/reskinnable/UnregisterFromParent()
	skins = null
	QDEL_NULL(my_original_skin)
	. = ..()

/datum/component/reskinnable/proc/is_reskinnable()
	return TRUE

/datum/component/reskinnable/proc/initialize_skins(list/newskins = list())
	init_skins_if_they_havent_yet()
	if(use_original_skin)
		my_original_skin = new /datum/reskin(parent)
		skindex = RESKIN_SKINDEX_ORIGINAL

/datum/component/reskinnable/proc/init_skins_if_they_havent_yet()
	if(LAZYLEN(GLOB.reskin_list))
		return
	for(var/sken in typesof(/datum/reskin))
		var/datum/reskin/skine = new sken()
		GLOB.reskin_list[skine.skin] = skine

/datum/component/reskinnable/proc/open_skin_picker(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!LAZYLEN(GLOB.reskin_list))
		init_skins_if_they_havent_yet()
	if(!can_reskin(src, user))
		return
	INVOKE_ASYNC(src,PROC_REF(actually_open_skin_picker), user)

/datum/component/reskinnable/proc/actually_open_skin_picker(mob/user)
	var/obj/item/master = parent
	var/list/skinnies = list()
	if(use_original_skin)
		skinnies[RESKIN_SKINDEX_ORIGINAL] = image(icon = my_original_skin.icon, icon_state = my_original_skin.icon_state, dir = SOUTH)
	for(var/sken in skins)
		var/datum/reskin/skine = LAZYACCESS(GLOB.reskin_list, sken)
		if(!skine)
			skins -= skine
			continue
		var/the_icon = skine.icon
		if(!the_icon)
			the_icon = my_original_skin.icon
		skinnies["[skine.skin]"] = skine.get_preview_image(master)
	var/choice = show_radial_menu(user, master, skinnies, custom_check = CALLBACK(src,PROC_REF(can_reskin), src, user), radius = 40, require_near = TRUE, ultradense = (LAZYLEN(skins) > 7))
	if(!choice)
		return FALSE
	if(QDELETED(master))
		return FALSE
	assign_skin(choice)

/datum/component/reskinnable/proc/force_skin(datum/source, choice)
	assign_skin(choice, FALSE)

/datum/component/reskinnable/proc/assign_skin(choice, cooldown)
	if(choice == "Random!")
		choice = safepick(skins)
		if(!choice)
			return FALSE
	var/obj/item/master = parent
	var/datum/reskin/skindatum
	if(choice == RESKIN_SKINDEX_ORIGINAL)
		skindatum = my_original_skin
	else
		skindatum = LAZYACCESS(GLOB.reskin_list, choice)
	if(!skindatum)
		return FALSE
	skindex = skindatum.skin
	skindatum.apply_to_item(master)
	if(cooldown)
		COOLDOWN_START(src, reskin_when, reskin_cooldown)
	return TRUE

/datum/component/reskinnable/proc/can_reskin(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!user)
		return FALSE
	var/obj/item/master = parent
	if(CHECK_BITFIELD(reskin_flags, RESKIN_BE_ALIVE) && !isliving(user))
		to_chat(user, span_alert("You must be alive to reskin [master], silly."))
		return FALSE
	if(CHECK_BITFIELD(reskin_flags, RESKIN_MUST_HOLD))
		var/list/haystack = get_nested_locs(master)
		if(!(user in haystack))
			to_chat(user, span_alert("You must be holding [master] to reskin it."))
			return FALSE
	if(CHECK_BITFIELD(reskin_flags, RESKIN_MUST_BE_NEAR))
		if(!master.Adjacent(user))
			to_chat(user, span_alert("You must be in reach of [master] to reskin it."))
			return FALSE
	if(CHECK_BITFIELD(reskin_flags, RESKIN_ONCE) && skindex != RESKIN_SKINDEX_ORIGINAL)
		to_chat(user, span_alert("[master] can only be reskinned once."))
		return FALSE
	if(CHECK_BITFIELD(reskin_flags, RESKIN_COOLDOWN) && !COOLDOWN_FINISHED(src, reskin_when))
		var/when_u_can = COOLDOWN_TIMELEFT(src, reskin_when)
		to_chat(user, span_alert("You must wait [DisplayTimeText(when_u_can, 1)] before reskinning [master] again."))
		return FALSE
	return TRUE

/datum/component/reskinnable/proc/get_current_skin(datum/source, list/liststate)
	SIGNAL_HANDLER
	if(!islist(liststate))
		return
	var/datum/reskin/myskin = LAZYACCESS(GLOB.reskin_list, skindex)
	if(!myskin)
		return
	liststate |= myskin
	return TRUE

/datum/component/reskinnable/proc/update_skin(obj/item/skinme)
	SIGNAL_HANDLER
	if(!isitem(skinme))
		return
	var/datum/reskin/myskin = LAZYACCESS(GLOB.reskin_list, skindex)
	if(!myskin)
		return
	return myskin.update_skin(skinme)

/datum/reskin
	/// The name the item will be called after reskinning
	var/skin = "shrug"
	var/name = "Reskin"
	var/desc = "A reskinned item"
	var/icon
	var/icon_state
	var/item_state
	var/mob_overlay_icon
	var/mutantrace_variation
	/// Some... extra shit to add at the end of the description. Aftger you examine it twice
	var/datum/component/lore/my_lore
	/// the type of thing this thing expects
	var/expected_type = /obj/item

	var/lefthand_file
	var/righthand_file

/datum/reskin/New(obj/item/template)
	if(!isitem(template))
		return
	build_from_template(template)

/datum/reskin/proc/build_from_template(obj/item/template)
	var/did_pre = pre_build(template)
	build(template)
	if(did_pre)
		post_build(template)

/datum/reskin/proc/build(obj/item/template)
	skin = "Original [template.name]]"
	name = template.name
	desc = template.desc
	icon = template.icon
	icon_state = template.icon_state
	item_state = template.item_state
	lefthand_file = template.lefthand_file
	righthand_file = template.righthand_file
	mob_overlay_icon = template.mob_overlay_icon
	mutantrace_variation = template.mutantrace_variation

/datum/reskin/proc/apply_to_item(obj/item/target)
	if(!istype(target, expected_type))
		message_admins("Reskin error: [target] is not a [expected_type]. Someone tried to apply the wrong kind of reskin component to [target]! This'll need a code fix!")
		return
	if(!isnull(name))
		target.name = name
	if(!isnull(desc))
		target.desc = desc
	if(!isnull(icon))
		target.icon = icon
	if(!isnull(icon_state))
		target.icon_state = icon_state
	if(!isnull(item_state))
		target.item_state = item_state
	if(!isnull(lefthand_file))
		target.lefthand_file = lefthand_file
	if(!isnull(righthand_file))
		target.righthand_file = righthand_file
	if(!isnull(mob_overlay_icon))
		target.mob_overlay_icon = mob_overlay_icon
	if(!isnull(mutantrace_variation))
		target.mutantrace_variation = mutantrace_variation
	// if(my_lore)
	// 	target.AddComponent(my_lore)
	// else
	// 	target.RemoveComponentByType(/datum/component/lore)
	apply_extra(target)
	target.update_icon()
	if(isliving(target.loc))
		var/mob/living/thingholder = target.loc
		thingholder.update_icons()

/datum/reskin/proc/apply_extra(obj/item/target)
	return

/datum/reskin/proc/pre_build(obj/item/target)
	return

/datum/reskin/proc/post_build(obj/item/target)
	return

/datum/reskin/proc/get_overlays(obj/item/target)
	return

/datum/reskin/proc/get_color(obj/item/target)
	return

/datum/reskin/proc/get_preview_image(obj/item/target)
	var/the_icon = isnull(icon) ? target.icon : icon
	var/the_icon_state = isnull(icon_state) ? target.icon_state : icon_state
	return image(icon = the_icon, icon_state = the_icon_state, dir = SOUTH)

/datum/reskin/proc/update_skin(obj/item/target)
	return

/// CROWBAR ///
/datum/component/reskinnable/crowbar
	skins = list(
		"Brass Crowbar",
		"Bronze Crowbar",
		"Large Crowbar",
		"Red Crowbar",

	)
/datum/reskin/crowbar
	skin = "Crowbar"
	name = "crowbar"
	desc = "This handy brass tool is useful for lots of things, \
			such as prying floor tiles or opening unpowered doors. \
			Has a certain clockwork feel to it, despite its lack of moving parts."
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/crowbar
/datum/reskin/crowbar/brass
	skin = "Brass Crowbar"
	name = "brass crowbar"
	desc = "This handy brass tool is useful for lots of things, \
			such as prying floor tiles or opening unpowered doors. \
			Has a certain clockwork feel to it, despite its lack of moving parts."
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar_clock"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/crowbar/bronze
	skin = "Bronze Crowbar"
	name = "bronze crowbar"
	desc = "This handy brass tool is useful for lots of things, \
			such as prying floor tiles or opening unpowered doors. \
			Now in bronze!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar_brass"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/crowbar/large
	skin = "Large Crowbar"
	name = "large crowbar"
	desc = "This handy brass tool is useful for lots of things, \
			such as prying floor tiles or opening unpowered doors. \
			This one is really, really big!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar_large"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/crowbar/red
	skin = "Red Crowbar"
	name = "red crowbar"
	desc = "Golly, your own lucky red crowbar!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "crowbar_red"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// WRENCH ///
/datum/component/reskinnable/wrench
	skins = list(
		"Brass Wrench",
		"Bronze Wrench",
		"Pipe Wrench",
		"Medical Pipe Wrench",
		"Medical Wrench",
	)
/datum/reskin/wrench
	skin = "Wrench"
	name = "wrench"
	desc = "A hefty device used to turn bolts. Keep out of the works."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/wrench
/datum/reskin/wrench/brass
	skin = "Brass Wrench"
	name = "brass wrench"
	desc = "A hefty device used to turn bolts. Now in honey-glazed flavor."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_clock"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/wrench/bronze
	skin = "Bronze Wrench"
	name = "bronze wrench"
	desc = "A hefty device used to turn bolts. Now in orange flavor."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_brass"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/wrench/old
	skin = "Pipe Wrench"
	name = "pipe wrench"
	desc = "The following story was widespread from the late 19th and early 20th centuries:\n\
			\t\"That handy tool, the 'monkey-wrench', is not so named because it is a handy thing to monkey with, \
			or for any kindred reason. 'Monkey' is not its name at all, Charles Moncky, the inventor of it, \
			sold his patent for $5000, and invested the money in a house in Williamsburg, Kings County, where he now lives.\" \n\
			Although this story was refuted by historical and patent research in the late 19th century, it appears to have been inspired \
			by a real person. A Charles Monk (not Moncky) lived in the Williamsburg section of Brooklyn in the 1880s where he made and \
			sold moulder's tools, not mechanics' tools like a monkey wrench. He could not have invented or named the monkey wrench because \
			he was born after the term first appeared in print.\n\
			\n\
			Though on closer inspection, this looks more like a pipe wrench."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_old"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/wrench/old_medical
	skin = "Medical Pipe Wrench"
	name = "medical pipe wrench"
	desc = "A hefty tool used to tighten the bolts on anyone monkeying around in the clinic."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_medical"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/wrench/medical
	skin = "Medical Wrench"
	name = "medical wrench"
	desc = "A hefty tool used to tighten the bolts on anyone monkeying around in the clinic."
	icon = 'icons/obj/tools.dmi'
	icon_state = "wrench_medical_old"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// COLORABLE HANDLE TOOL STUFFS ///
/datum/reskin/colorable_tool
	skin = "Colorful Thing"
	name = "screwdriver"
	desc = "A long rod with a plump, grabbable knob on the base. Used to screw things."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/screwdriver
	var/uncolored_overlay_icon = 'icons/obj/tools.dmi'
	var/uncolored_overlay_icon_state = "screwdriver_screwybits"
	var/colorize
	var/list/tool_colors = list(
		"blue" = rgb(24, 97, 213),
		"red" = rgb(255, 0, 0),
		"pink" = rgb(213, 24, 141),
		"brown" = rgb(160, 82, 18),
		"green" = rgb(14, 127, 27),
		"cyan" = rgb(24, 162, 213),
		"yellow" = rgb(255, 165, 0)
	)

/datum/reskin/colorable_tool/get_preview_image(obj/item/screwdriver/target)
	if(!colorize)
		return ..()
	var/image/img = image(uncolored_overlay_icon, uncolored_overlay_icon_state)
	var/image/olay = image(icon, icon_state)
	var/color_to_make_it = tool_colors[colorize]
	olay.color = color_to_make_it
	img.overlays += olay
	return img

/datum/reskin/colorable_tool/get_overlays(obj/item/screwdriver/target)
	. = list()
	var/mutable_appearance/base_overlay = mutable_appearance(uncolored_overlay_icon, uncolored_overlay_icon_state)
	base_overlay.appearance_flags = RESET_COLOR
	. += base_overlay

/datum/reskin/colorable_tool/get_color(obj/item/screwdriver/target)
	return tool_colors[colorize]

/datum/reskin/colorable_tool/pre_build(obj/item/screwdriver/target)
	if(colorize == "RAND")
		colorize = pick(tool_colors)
	return TRUE

/datum/reskin/colorable_tool/post_build(obj/item/screwdriver/target)
	target.update_icon()

/// SCREWDRIVER ///
/datum/component/reskinnable/screwdriver
	my_original_skin = /datum/reskin/colorable_tool/screwdriver
	skins = list(
		"Brass Screwdriver",
		"Bronze Screwdriver",
		"Blue Screwdriver",
		"Red Screwdriver",
		"Pink Screwdriver",
		"Brown Screwdriver",
		"Green Screwdriver",
		"Cyan Screwdriver",
		"Yellow Screwdriver",
	)
/datum/reskin/colorable_tool/screwdriver
	skin = "Screwdriver"
	name = "screwdriver"
	desc = "A long rod with a plump, grabbable knob on the base. Used to screw things."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/screwdriver
	colorize = "RANDOM"
	uncolored_overlay_icon = 'icons/obj/tools.dmi'
	uncolored_overlay_icon_state = "screwdriver_screwybits"
	tool_colors = list(
		"blue" = rgb(24, 97, 213),
		"red" = rgb(255, 0, 0),
		"pink" = rgb(213, 24, 141),
		"brown" = rgb(160, 82, 18),
		"green" = rgb(14, 127, 27),
		"cyan" = rgb(24, 162, 213),
		"yellow" = rgb(255, 165, 0)
	)

/datum/reskin/colorable_tool/screwdriver/brass
	skin = "Brass Screwdriver"
	name = "brass screwdriver"
	desc = "A shiny yellowish screw-driving tool that looks prettier than it has any right to be."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver_clock"
	item_state = "screwdriver_brass"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = null
/datum/reskin/colorable_tool/screwdriver/bronze
	skin = "Bronze Screwdriver"
	name = "bronze screwdriver"
	desc = "A long pointy screw-driving tool that was left in the fryer too long."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver_brass"
	item_state = "screwdriver_brass"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = null

/datum/reskin/colorable_tool/screwdriver/blue
	skin = "Blue Screwdriver"
	name = "blue screwdriver"
	desc = "The classic screwing utensil used by Blueberry Bates and his Band of Bate Bonded Bome Bimprovement Bomtractors."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "blue"
/datum/reskin/colorable_tool/screwdriver/red
	skin = "Red Screwdriver"
	name = "red screwdriver"
	desc = "Just when you thought the screwdriver companies couldn't be more inventive, bam, they make red."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "red"
/datum/reskin/colorable_tool/screwdriver/pink
	skin = "Pink Screwdriver"
	name = "pink screwdriver"
	desc = "You're a Barbie girl, building your Barbie world."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "pink"
/datum/reskin/colorable_tool/screwdriver/brown
	skin = "Brown Screwdriver"
	name = "brown screwdriver"
	desc = "Why does it smell like chocolate?"
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "brown"
/datum/reskin/colorable_tool/screwdriver/green
	skin = "Green Screwdriver"
	name = "green screwdriver"
	desc = "Careful, it's either radioactive, or ready to screw you through a wall."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "green"
/datum/reskin/colorable_tool/screwdriver/cyan
	skin = "Cyan Screwdriver"
	name = "cyan screwdriver"
	desc = "So this one lizard, lets call him Cyan, woke up one day with an injector pen and a <i>plan</i>. \
			He bribed his boyfriend with meat (he's also a lizard) and got himself several gallons of amanitin \
			and corazargh (his boyfriend is also a chemist). I forget what happened next, but a bunch of people \
			died, the end."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "cyan"
/datum/reskin/colorable_tool/screwdriver/yellow
	skin = "Yellow Screwdriver"
	name = "yellow screwdriver"
	desc = "Don't eat the yellow screwdriver."
	icon = 'icons/obj/tools.dmi'
	icon_state = "screwdriver"
	item_state = "screwdriver"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "yellow"

/// WIRECUTTERS ///
/datum/component/reskinnable/wirecutters
	skins = list(
		"Brass Wirecutters",
		"Bronze Wirecutters",
		"Blue Wirecutters",
		"Red Wirecutters",
		"Pink Wirecutters",
		"Brown Wirecutters",
		"Green Wirecutters",
		"Cyan Wirecutters",
		"Yellow Wirecutters",
	)
/datum/reskin/colorable_tool/wirecutters
	skin = "Wirecutters"
	name = "wirecutters"
	desc = "A pair of sharp snipping bits joined to a pair of hard plastic gripping bits. Supposedly cuts wires."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/wirecutters
	colorize = "RANDOM"
	uncolored_overlay_icon = 'icons/obj/tools.dmi'
	uncolored_overlay_icon_state = "cutters_cutty_thingy"
	tool_colors = list(
		"blue" = rgb(24, 97, 213),
		"red" = rgb(255, 0, 0),
		"pink" = rgb(213, 24, 141),
		"brown" = rgb(160, 82, 18),
		"green" = rgb(14, 127, 27),
		"cyan" = rgb(24, 162, 213),
		"yellow" = rgb(255, 165, 0)
	)

/datum/reskin/colorable_tool/wirecutters/brass
	skin = "Brass Wirecutters"
	name = "brass wirecutters"
	desc = "An enormous pair of pan-fried scissors."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters_clock"
	item_state = "cutters_brass"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = null
/datum/reskin/colorable_tool/wirecutters/bronze
	skin = "Bronze Wirecutters"
	name = "bronze wirecutters"
	desc = "A set of Ultra Premium Limited Edition Caramel Cutters. Only 1000 were made, and they're all sold out."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters_brass"
	item_state = "cutters_brass"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = null

/datum/reskin/colorable_tool/wirecutters/blue
	skin = "Blue Wirecutters"
	name = "blue wirecutters"
	desc = "The classic snipping tool used by Blueberry Bates and his Band of Bate Bonded Bome Bimprovement Bomtractors."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "blue"
/datum/reskin/colorable_tool/wirecutters/red
	skin = "Red Wirecutters"
	name = "red wirecutters"
	desc = "That'll hide the rust for sure."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "red"
/datum/reskin/colorable_tool/wirecutters/pink
	skin = "Pink Wirecutters"
	name = "pink wirecutters"
	desc = "You're a Barbie girl, cutting the locks off your Barbie world."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "pink"
/datum/reskin/colorable_tool/wirecutters/brown
	skin = "Brown Wirecutters"
	name = "brown wirecutters"
	desc = "Why does it smell like chocolate?"
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "brown"
/datum/reskin/colorable_tool/wirecutters/green
	skin = "Green Wirecutters"
	name = "green wirecutters"
	desc = "Careful, it's either radioactive, or lime flavored."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "green"
/datum/reskin/colorable_tool/wirecutters/cyan
	skin = "Cyan Wirecutters"
	name = "cyan wirecutters"
	desc = "So this one lizard, lets call him Cyan, woke up one day with an injector pen and a <i>plan</i>. \
			He bribed his boyfriend with meat (he's also a lizard) and got himself several gallons of amanitin \
			and corazargh (his boyfriend is also a chemist). I forget what happened next, but a bunch of people \
			died, the end."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "cyan"
/datum/reskin/colorable_tool/wirecutters/yellow
	skin = "Yellow Wirecutters"
	name = "yellow wirecutters"
	desc = "Don't eat the yellow wirecutters."
	icon = 'icons/obj/tools.dmi'
	icon_state = "cutters"
	item_state = "cutters"
	mob_overlay_icon = null
	mutantrace_variation = null
	colorize = "yellow"

/// NCR TROOPER HELMET ///
/datum/component/reskinnable/ncr_helm
	skins = list(
		"M1 Old",
		"M1 Old Medic",
		"M1 Old MP",
		"M1 Old Gambler",
		"M1 Old Bandolier",
	)
/datum/reskin/ncr_helm
	skin = "M1 Old"
	name = null
	desc = "A standard issue NCR steel helmet. Looks like you can write on it and strap a few items on the helmet band."
	icon = null
	icon_state = "ncr_old"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/ncr_helm/medic
	skin = "M1 Old Medic"
	name = null
	desc = null
	icon = null
	icon_state = "ncr_old_med"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/ncr_helm/mp
	skin = "M1 Old MP"
	name = null
	desc = null
	icon = null
	icon_state = "ncr_old_mp"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/ncr_helm/gambler
	skin = "M1 Old Gambler"
	name = null
	desc = null
	icon = null
	icon_state = "ncr_old_gambler"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/ncr_helm/bandolier
	skin = "M1 Old Bandolier"
	name = null
	desc = null
	icon = null
	icon_state = "ncr_old_bandolier"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// KHAN DUTY BOOTIES ///
/datum/component/reskinnable/khan_boots
	skins = list(
		"Khan Boots",
		"Alt Khan Boots",
		"Long Khan Boots",
	)
/datum/reskin/khan_boots
	skin = "Khan Boots"
	name = null
	desc = null
	icon = null
	icon_state = "duty"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/khan_boots/alt
	skin = "Alt Khan Boots"
	name = null
	desc = null
	icon = null
	icon_state = "duty_alt"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/khan_boots/long
	skin = "Long Khan Boots"
	name = null
	desc = null
	icon = null
	icon_state = "duty_long"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// HOS TRENCH COAT ///
/datum/component/reskinnable/hos_trench_coat
	skins = list(
		"HOS Trench Coat",
		"HOS Trench Cloak"
	)
/datum/reskin/hos_trench_coat
	skin = "HOS Trench Coat"
	name = null
	desc = null
	icon = null
	icon_state = "duty"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/hos_trench_coat/cloak
	skin = "HOS Trench Cloak"
	name = null
	desc = null
	icon = null
	icon_state = "trenchcloak"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// CAPTAIN PEN ///
/datum/component/reskinnable/captain_pen
	skins = list(
		"Oak Pen",
		"Gold Pen",
		"Rosewood Pen",
		"Black and Silver Pen",
		"Command Blue Pen",
	)
/datum/reskin/captain_pen
	skin = "Oak Pen"
	name = "Swankline Oak Pen"
	desc = "It's an expensive Oak fountain pen. The nib is quite sharp."
	icon = null
	icon_state = "pen-fountain-o"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/pen/fountain
/datum/reskin/captain_pen/gold
	skin = "Gold Pen"
	name = "Swankline Gold Pen"
	desc = "It's an expensive Gold fountain pen. The nib is quite sharp."
	icon = null
	icon_state = "pen-fountain-g"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/captain_pen/rosewood
	skin = "Rosewood Pen"
	name = "Swankline Rosewood Pen"
	desc = "It's an expensive Rosewood fountain pen. The nib is quite sharp."
	icon = null
	icon_state = "pen-fountain-r"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/captain_pen/black_and_silver
	skin = "Black And Silver Pen"
	name = "Swankline Black And Silver Pen"
	desc = "It's an expensive Black and Silver fountain pen. The nib is quite sharp."
	icon = null
	icon_state = "pen-fountain-b"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/captain_pen/command_blue
	skin = "Command Blue Pen"
	name = "Swankline Command Blue Pen"
	desc = "It's an expensive Command Blue fountain pen. The nib is quite sharp."
	icon = null
	icon_state = "pen-fountain-cb"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// SMALL HYPOVIAL ///
/datum/component/reskinnable/small_hypovial
	skins = list(
		"Small Hypovial",
		"Small Red Hypovial",
		"Small Blue Hypovial",
		"Small Green Hypovial",
		"Small Orange Hypovial",
		"Small Purple Hypovial",
		"Small Black Hypovial",
		"Small Pink Hypovial",
	)
/datum/reskin/small_hypovial
	skin = "Small Hypovial"
	name = "hypovial"
	desc = null
	icon = null
	icon_state = "hypovial"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/reagent_containers/glass/bottle/vial
/datum/reskin/small_hypovial/red
	skin = "Small Red Hypovial"
	name = "red hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-b"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/blue
	skin = "Small Blue Hypovial"
	name = "blue hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-d"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/green
	skin = "Small Green Hypovial"
	name = "green hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-a"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/orange
	skin = "Small Orange Hypovial"
	name = "orange hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-k"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/purple
	skin = "Small Purple Hypovial"
	name = "purple hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-p"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/black
	skin = "Small Black Hypovial"
	name = "black hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-t"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/small_hypovial/pink
	skin = "Small Pink Hypovial"
	name = "pink hypovial"
	desc = null
	icon = null
	icon_state = "hypovial-pink"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// LARGE HYPOVIAL ///"hypovial-
/datum/component/reskinnable/large_hypovial
	skins = list(
		"Large Hypovial",
		"Large Red Hypovial",
		"Large Blue Hypovial",
		"Large Green Hypovial",
		"Large Orange Hypovial",
		"Large Purple Hypovial",
		"Large Black Hypovial",
	)
/datum/reskin/large_hypovial
	skin = "Large Hypovial"
	name = "hypovial"
	desc = null
	icon = null
	icon_state = "hypovial"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/reagent_containers/glass/bottle/vial
/datum/reskin/large_hypovial/red
	skin = "Large Red Hypovial"
	name = "red hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-b"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/large_hypovial/blue
	skin = "Large Blue Hypovial"
	name = "blue hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-d"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/large_hypovial/green
	skin = "Large Green Hypovial"
	name = "green hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-a"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/large_hypovial/orange
	skin = "Large Orange Hypovial"
	name = "orange hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-k"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/large_hypovial/purple
	skin = "Large Purple Hypovial"
	name = "purple hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-p"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/large_hypovial/black
	skin = "Large Black Hypovial"
	name = "black hypovial"
	desc = null
	icon = null
	icon_state = "hypoviallarge-t"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

/// fritz ///
/datum/component/reskinnable/fritz
	skins = list(
		"Fritz Goodboye",
		"Fritz Badboye",
	)
/datum/reskin/fritz
	skin = "Fritz Goodboye"
	name = "Goodboye"
	desc = null
	icon = null
	icon_state = "fritz"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null
/datum/reskin/fritz/badboye
	skin = "Fritz Badboye"
	name = "Badboye"
	desc = null
	icon = null
	icon_state = "fritz_bad"
	item_state = null
	mob_overlay_icon = null
	mutantrace_variation = null

GLOBAL_LIST_INIT(pda_skins, list(
	"Random!",
	"DataPal",
	"Medical PDA",
	"Virology PDA",
	"Engineering PDA",
	"Security PDA",
	"Detective PDA",
	"Warden PDA",
	"Janitor PDA",
	"Scientist PDA",
	"Head of Personnel PDA",
	"Head of Security PDA",
	"Chief Engineer PDA",
	"Chief Medical Officer PDA",
	"Research Director PDA",
	"Captain PDA",
	"Lieutenant PDA",
	"Atmospheric Technician PDA",
	"Chemist PDA",
	"Geneticist PDA",
	"Teachboy PDA",
	"Curator PDA",
	"Neko PDA",
	"Handy Orange PDA",
	"Handy PDA",
	"Handy Medical PDA",
	"Handy Virologist PDA",
	"Handy Engineer PDA",
	"Handy Security PDA",
	"Handy Detective PDA",
	"Handy Warden PDA",
	"Handy Janitor PDA",
	"Handy Scientist PDA",
	"Handy HoP PDA",
	"Handy HoS PDA",
	"Handy CE PDA",
	"Handy CMO PDA",
	"Handy RD PDA",
	"Handy Captain PDA",
	"Handy Lieutenant PDA",
	"Handy Cargo PDA",
	"Handy QM PDA",
	"Handy Miner PDA",
	"Handy Chaplain PDA",
	"Handy Cook PDA",
	"Handy Garden PDA",
	"Handy Syndicate PDA",
	"Handy Lawyer PDA",
	"Handy Roboticist PDA",
	"Handy Bartender PDA",
	"Handy Atmos PDA",
	"Handy Chemist PDA",
	"Handy Geneticist PDA",
	"Handy Clear PDA",
	"Handy Librarian PDA",
	"Handy Neko PDA",
	))

/// PDA SKINS ///
/datum/component/reskinnable/pda
	skins = list(
		"DataPal",
		"Medical PDA",
		"Virology PDA",
		"Engineering PDA",
		"Security PDA",
		"Detective PDA",
		"Warden PDA",
		"Janitor PDA",
		"Scientist PDA",
		"Head of Personnel PDA",
		"Head of Security PDA",
		"Chief Engineer PDA",
		"Chief Medical Officer PDA",
		"Research Director PDA",
		"Captain PDA",
		"Lieutenant PDA",
		"Atmospheric Technician PDA",
		"Chemist PDA",
		"Geneticist PDA",
		"Teachboy PDA",
		"Curator PDA",
		"Neko PDA",
		"Handy Orange PDA",
		"Handy PDA",
		"Handy Medical PDA",
		"Handy Virologist PDA",
		"Handy Engineer PDA",
		"Handy Security PDA",
		"Handy Detective PDA",
		"Handy Warden PDA",
		"Handy Janitor PDA",
		"Handy Scientist PDA",
		"Handy HoP PDA",
		"Handy HoS PDA",
		"Handy CE PDA",
		"Handy CMO PDA",
		"Handy RD PDA",
		"Handy Captain PDA",
		"Handy Lieutenant PDA",
		"Handy Cargo PDA",
		"Handy QM PDA",
		"Handy Miner PDA",
		"Handy Chaplain PDA",
		"Handy Cook PDA",
		"Handy Garden PDA",
		"Handy Syndicate PDA",
		"Handy Lawyer PDA",
		"Handy Roboticist PDA",
		"Handy Bartender PDA",
		"Handy Atmos PDA",
		"Handy Chemist PDA",
		"Handy Geneticist PDA",
		"Handy Clear PDA",
		"Handy Librarian PDA",
		"Handy Neko PDA",
	)

/datum/reskin/pda
	skin = "Datapal 3000"
	name = "Datapal 3000"
	desc = null
	icon = 'icons/obj/pda.dmi'
	icon_state = "pda"
	item_state = "Pip-boy"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/pda
	var/disable_overlays = FALSE
	var/overlay_offset_x = 0
	var/overlay_offset_y = 0
	var/alert_icon = 'icons/obj/pda.dmi'
	var/alert_icon_state = "pda-r"
	var/screen_icon = 'icons/obj/pda.dmi'
	var/screen_icon_state = "screen_default"
	var/id_card_icon = 'icons/obj/pda.dmi'
	var/id_card_icon_state = "id_overlay"
	var/insert_icon = 'icons/obj/pda.dmi'
	var/insert_icon_state = "insert_overlay"
	var/flashlight_icon = 'icons/obj/pda.dmi'
	var/flashlight_icon_state = "light_overlay"
	var/pai_icon = 'icons/obj/pda.dmi'
	var/pai_icon_state = "pai_overlay"
	var/pai_on_icon = 'icons/obj/pda.dmi'
	var/pai_on_icon_state = "pai_overlay"

/datum/reskin/pda/get_preview_image(obj/item/pda/target)
	var/image/img = image(icon, icon_state)
	// var/image/alert = image(alert_icon, alert_icon_state)
	var/image/screen = image(screen_icon, screen_icon_state)
	var/image/id_card = image(id_card_icon, id_card_icon_state)
	var/image/insert = image(insert_icon, insert_icon_state)
	var/image/flashlight = image(flashlight_icon, flashlight_icon_state)
	// var/image/pai = image(pai_icon, pai_icon_state)
	// var/image/pai_on = image(pai_on_icon, pai_on_icon_state)
	img.overlays += list(screen, id_card, insert, flashlight)
	return img

/datum/reskin/pda/medical
	skin = "Medical PDA"
	icon_state = "pda-medical"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/virology
	skin = "Virology PDA"
	icon_state = "pda-virology"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/engineering
	skin = "Engineering PDA"
	icon_state = "pda-engineer"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/security
	skin = "Security PDA"
	icon_state = "pda-security"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/detective
	skin = "Detective PDA"
	icon_state = "pda-detective"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/warden
	skin = "Warden PDA"
	icon_state = "pda-warden"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/janitor
	skin = "Janitor PDA"
	icon_state = "pda-janitor"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/toxins
	skin = "Scientist PDA"
	icon_state = "pda-science"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/hop
	skin = "Head of Personnel PDA"
	icon_state = "pda-hop"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/hos
	skin = "Head of Security PDA"
	icon_state = "pda-hos"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/ce
	skin = "Chief Engineer PDA"
	icon_state = "pda-ce"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/cmo
	skin = "Chief Medical Officer PDA"
	icon_state = "pda-cmo"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/rd
	skin = "Research Director PDA"
	icon_state = "pda-rd"
/datum/reskin/pda/captain
	skin = "Captain PDA"
	icon_state = "pda-captain"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/lieutenant
	skin = "Lieutenant PDA"
	icon_state = "pda-lieutenant"
/datum/reskin/pda/cargo
	skin = "Cargo Technician PDA"
	icon_state = "pda-cargo"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/quartermaster
	skin = "Quartermaster PDA"
	icon_state = "pda-qm"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/shaftminer
	skin = "Shaft Miner PDA"
	icon_state = "pda-miner"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/syndicate
	skin = "Military PDA"
	icon_state = "pda-syndi"
	screen_icon_state = null
	alert_icon_state = null
/datum/reskin/pda/chaplain
	skin = "Chaplain PDA"
	icon_state = "pda-chaplain"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/lawyer
	skin = "Lawyer PDA"
	icon_state = "pda-lawyer"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/botanist
	skin = "Botanist PDA"
	icon_state = "pda-hydro"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/roboticist
	skin = "Roboticist PDA"
	icon_state = "pda-roboticist"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/cook
	skin = "Cook PDA"
	icon_state = "pda-cook"
/datum/reskin/pda/bar
	skin = "Bartender PDA"
	icon_state = "pda-bartender"
	screen_icon_state = "old_screen_liney"
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/atmos
	skin = "Atmospheric Technician PDA"
	icon_state = "pda-atmos"
/datum/reskin/pda/chemist
	skin = "Chemist PDA"
	icon_state = "pda-chemistry"
/datum/reskin/pda/geneticist
	skin = "Geneticist PDA"
	icon_state = "pda-genetics"
/datum/reskin/pda/clear
	skin = "Clear PDA"
	desc = "A portable microcomputer by RobCo Industries. This model is a special edition with a transparent case."
	icon_state = "pda-clear"
/datum/reskin/pda/teachboy
	skin = "Teachboy PDA"
	desc = "A portable microcomputer by RobCo Industries. This model is an EDU-2 series educational device - or at least that's what you can make from the rusty tin case with wires jammed into it- someone's repaired this thing."
	icon_state = "pda-teachboy-unfolded"
	disable_overlays = TRUE
/datum/reskin/pda/curator
	skin = "Curator PDA"
	icon_state = "pda-library"
	overlay_offset_x = -3
	overlay_offset_y = 0
	alert_icon_state = "pda-r-library"
	screen_icon_state = "blank"
	id_card_icon_state = "id_overlay"
	insert_icon_state = "insert_overlay"
	flashlight_icon_state = "light_overlay"
	pai_on_icon_state = "pai_overlay"
	screen_icon_state = ""
	alert_icon_state = "pda_alert-old"
/datum/reskin/pda/neko
	skin = "Neko PDA"
	desc = "A portable microcomputer by RobCo Industries. This model is a special feline edition."
	icon_state = "pda-neko"
	overlay_offset_x = 0
	overlay_offset_y = 0
	alert_icon = 'icons/obj/pda_alt.dmi'
	alert_icon_state = "pda-r"
	screen_icon = 'icons/obj/pda_alt.dmi'
	screen_icon_state = "screen_neko"
	id_card_icon = 'icons/obj/pda_alt.dmi'
	id_card_icon_state = "id_overlay"
	insert_icon = 'icons/obj/pda_alt.dmi'
	insert_icon_state = "insert_overlay"
	flashlight_icon = 'icons/obj/pda_alt.dmi'
	flashlight_icon_state = "light_overlay"
	pai_icon = 'icons/obj/pda_alt.dmi'
	pai_icon_state = "pai_overlay"
	pai_on_icon = 'icons/obj/pda_alt.dmi'
	pai_on_icon_state = "pai_overlay"
/datum/reskin/pda/alt
	skin = "Handy PDA"
	desc = "A handy-dandy microcomputer."
	icon = 'icons/obj/pda_alt.dmi'
	icon_state = "pda"
	alert_icon = 'icons/obj/pda_alt.dmi'
	alert_icon_state = "pda-r"
	screen_icon = 'icons/obj/pda_alt.dmi'
	screen_icon_state = "screen_default"
	id_card_icon = 'icons/obj/pda_alt.dmi'
	id_card_icon_state = "id_overlay"
	insert_icon = 'icons/obj/pda_alt.dmi'
	insert_icon_state = "insert_overlay"
	flashlight_icon = 'icons/obj/pda_alt.dmi'
	flashlight_icon_state = "light_overlay"
	pai_icon = 'icons/obj/pda_alt.dmi'
	pai_icon_state = "pai_overlay_off"
	pai_on_icon = 'icons/obj/pda_alt.dmi'
	pai_on_icon_state = "pai_overlay"
/datum/reskin/pda/alt/orange
	skin = "Handy Orange PDA"
	icon_state = "pda-orange"
/datum/reskin/pda/alt/detective
	skin = "Handy Detective PDA"
	icon_state = "pda-detective"
/datum/reskin/pda/alt/hydro
	skin = "Handy Garden PDA"
	icon_state = "pda-hydro"
/datum/reskin/pda/alt/lawyer
	skin = "Handy Lawyer PDA"
	icon_state = "pda-lawyer"
/datum/reskin/pda/alt/hop
	skin = "Handy HoP PDA"
	icon_state = "pda-hop"
/datum/reskin/pda/alt/mime
	skin = "Handy Mime PDA"
	icon_state = "pda-mime"
/datum/reskin/pda/alt/miner
	skin = "Handy Miner PDA"
	icon_state = "pda-miner"
/datum/reskin/pda/alt/qm
	skin = "Handy QM PDA"
	icon_state = "pda-qm"
/datum/reskin/pda/alt/cargo
	skin = "Handy Cargo PDA"
	icon_state = "pda-cargo"
/datum/reskin/pda/alt/janitor
	skin = "Handy Janitor PDA"
	icon_state = "pda-janitor"
/datum/reskin/pda/alt/engineer
	skin = "Handy Engineer PDA"
	icon_state = "pda-engineer"
/datum/reskin/pda/alt/atmos
	skin = "Handy Atmos PDA"
	icon_state = "pda-atmos"
/datum/reskin/pda/alt/ce
	skin = "Handy CE PDA"
	icon_state = "pda-ce"
/datum/reskin/pda/alt/clown
	skin = "Handy Clown PDA"
	icon_state = "pda-clown"
/datum/reskin/pda/alt/chaplain
	skin = "Handy Chaplain PDA"
	icon_state = "pda-chaplain"
/datum/reskin/pda/alt/bartender
	skin = "Handy Bartender PDA"
	icon_state = "pda-bartender"
/datum/reskin/pda/alt/roboticist
	skin = "Handy Roboticist PDA"
	icon_state = "pda-roboticist"
/datum/reskin/pda/alt/captain
	skin = "Handy Captain PDA"
	icon_state = "pda-captain"
/datum/reskin/pda/alt/security
	skin = "Handy Security PDA"
	icon_state = "pda-security"
/datum/reskin/pda/alt/warden
	skin = "Handy Warden PDA"
	icon_state = "pda-warden"
/datum/reskin/pda/alt/hos
	skin = "Handy HoS PDA"
	icon_state = "pda-hos"
/datum/reskin/pda/alt/cook
	skin = "Handy Cook PDA"
	icon_state = "pda-cook"
/datum/reskin/pda/alt/genetics
	skin = "Handy Geneticist PDA"
	icon_state = "pda-genetics"
/datum/reskin/pda/alt/chemistry
	skin = "Handy Chemist PDA"
	icon_state = "pda-chemistry"
/datum/reskin/pda/alt/medical
	skin = "Handy Medical PDA"
	icon_state = "pda-medical"
/datum/reskin/pda/alt/cmo
	skin = "Handy CMO PDA"
	icon_state = "pda-cmo"
/datum/reskin/pda/alt/science
	skin = "Handy Scientist PDA"
	icon_state = "pda-science"
/datum/reskin/pda/alt/rd
	skin = "Handy RD PDA"
	icon_state = "pda-rd"
/datum/reskin/pda/alt/virology
	skin = "Handy Virologist PDA"
	icon_state = "pda-virology"
/datum/reskin/pda/alt/clear
	skin = "Handy Clear PDA"
	icon_state = "pda-clear"
/datum/reskin/pda/alt/lieutenant
	skin = "Handy Lieutenant PDA"
	icon_state = "pda-lieutenant"
/datum/reskin/pda/alt/library
	skin = "Handy Librarian PDA"
	icon_state = "pda-library"
/datum/reskin/pda/alt/syndi
	skin = "Handy Syndicate PDA"
	icon_state = "pda-syndi"
/datum/reskin/pda/alt/neko
	skin = "Handy Neko PDA"
	icon_state = "pda-neko"


/// GUN ///
/datum/reskin/gun
	skin = "Gun"
	name = "gun"
	desc = "Bang!"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	var/sawn_name = "sawed off gun"
	var/sawn_desc = "Gun, but less gun."
	var/sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	var/sawn_icon_state = "308_sawn"

/datum/reskin/gun/update_skin(obj/item/gun/target)
	if(!istype(target))
		return
	. = TRUE
	target.item_state = item_state
	target.mob_overlay_icon = mob_overlay_icon
	if(target.sawn_off)
		target.desc = sawn_desc
		target.icon = sawn_icon
		target.icon_state = sawn_icon_state
	else
		target.desc = desc
		target.icon = icon
		target.icon_state = icon_state

/// HUNTING RIFLES ///
/datum/component/reskinnable/hunting_rifle
	skins = list(
		"Hunting Rifle",
		"Remington 700",
		"Mosin Nagant",
		"Arisaka 30",
		"Arisaka 35",
		"Arisaka 38",
		"Arisaka 99",
		"Gewehr 71",
		"Gewehr 88",
		"Gewehr 98",
		"Mauser 90",
		"Mauser 93",
		"Lebel",
		"Murata",
		"Carcano",
		"KAR98A",
		"KAR98K",
		"Mosin 30",
		"Remington 11",
		"Service Rifle",
		"Revolving Rifle",
		"Marlin",
		//"Martini Henry", // 8 shot .30-06 martini-henry
		"P-14",
		"Madsen M47",
		"Springfield WW2",
		"springfield"
	)
/datum/reskin/gun/hunting_rifle
	skin = "Hunting Rifle"
	name = "hunting rifle"
	desc = "A sturdy hunting rifle, chambered in .30-06 Springfield."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off hunting rifle"
	sawn_desc = "Gun, but less gun."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "308_sawn"
/datum/reskin/gun/hunting_rifle/hypocritical_oath
	skin = "Hypocritical Oath"
	name = "hypocritical oath"
	desc = "An old, worn-in hunting rifle with leather wrapping the stock. Do (no) harm."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308special"
	item_state = "308special"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off hypocritical oath"
	sawn_desc = "Perfect for doing less harm."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "308_sawn"
/datum/reskin/gun/hunting_rifle/remington_700
	skin = "Remington 700"
	name = "Remington 700"
	desc = "This bolt action rifle was popular among hunters, police, and the military before whatever the heck happened."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Remington 700"
	sawn_desc = "Somewhere between a Remington 300 and 400."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "308_sawn"
/datum/reskin/gun/hunting_rifle/paciencia
	skin = "Paciencia"
	name = "Paciencia"
	desc = "A modified .30-06 hunting rifle with a reduced magazine but an augmented receiver. A Mexican flag is wrapped around the stock. You only have three shots- make them count."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "paciencia"
	item_state = "paciencia"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Paciencia"
	sawn_desc = "Someone's patience is running short."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "308_sawn"
/datum/reskin/gun/hunting_rifle/mosin
	skin = "Mosin Nagant"
	name = "Mosin-Nagant m38"
	desc = "A rusty old Russian bolt action chambered in .30-06."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "mosin"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Mosin Nagant"
	sawn_desc = "Looks like this rifle's popping a squat."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/arisaka30
	skin = "Arisaka 30"
	name = "Arisaka 30"
	desc = "A bolt action rifle chambered in .30-06. Rumor has it, the Japanese only had 30 of these in the second world war. And now you have one of them!"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "arisaka30"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Arisaka 30"
	sawn_desc = "There's a lot that could be said about this shortened rifle, none of which appropriate for this description."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/arisaka35
	skin = "Arisaka 35"
	name = "Arisaka 35"
	desc = "A bolt action rifle chambered in .30-06. Rumor has it, the Japanese only had 35 of these in the second world war. That's 5 more than the 30. And that's terrible."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "arisaka35"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Arisaka 35"
	sawn_desc = "Something something Arisaka 17.5, something something gun."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/arisaka38
	skin = "Arisaka 38"
	name = "Arisaka 38"
	desc = "A bolt action rifle chambered in .30-06. Rumor has it, the Japanese originally chambered it in .38, but changed it to .30-06 once the world's supply ran out."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "arisaka38"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Arisaka 38"
	sawn_desc = "A snubnose 38 Arisaka."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/arisaka99
	skin = "Arisaka 99"
	name = "Arisaka 99"
	desc = "A bolt action rifle chambered in .30-06. Rumor has it, the Japanese made this to celebrate 99 years of Arisaka manufacturing. Here's to 99 more!"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "arisaka99"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Arisaka 99"
	sawn_desc = "A bolt action rifle chambered in .30-06. Rumor has it, the Japanese made this to celebrate 49.5 years of Arisaka manufacturing. Here's to 49.5 more!"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/gewehr71
	skin = "Gewehr 71"
	name = "Gewehr 71"
	desc = "A bolt action rifle chambered in .30-06. Invented by John Gehwehr in 2171, this rifle went on to become the most popular rifle in the world. That's why it's so hard to find, everyone already has one."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "gewehr71"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Gewehr 71"
	sawn_desc = "John Gewehr was a genius. He invented the Gewehr 71, and then he invented the Gewehr 71 sawed off. He was a genius."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"

/datum/reskin/gun/hunting_rifle/gewehr88
	skin = "Gewehr 88"
	name = "Gewehr 88"
	desc = "A bolt action rifle chambered in .30-06. Invented by John Gehwehr in 2168."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "gewehr88"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Gewehr 88"
	sawn_desc = "John Gewehr was a genius. He invented the Gewehr 88, and then he invented the Gewehr 88 sawed off. He was a genius."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/gewehr98
	skin = "Gewehr 98"
	name = "Gewehr 98"
	desc = "A bolt action rifle chambered in .30-06. Invented by John Gehwehr in 2171, this rifle went on to become the second most popular rifle in the world. That's why it's so hard to find, everyone already had a 71."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "gewehr98"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Gewehr 98"
	sawn_desc = "John Gewehr was a genius. He invented the Gewehr 71, and then he invented the Gewehr 71 sawed off. He was a genius."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"

/datum/reskin/gun/hunting_rifle/mauser90
	skin = "Mauser 90"
	name = "Mauser 90"
	desc = "A bolt action rifle chambered in .30-06. Originally made by Nyanco as a solution to their rat problem. After 89 unsuccessful models, they finally cleared out their basement."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "mauser90"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Mauser 90"
	sawn_desc = "Perfect for baby mice."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/mauser93
	skin = "Mauser 93"
	name = "Mauser 93"
	desc = "A bolt action rifle chambered in .30-06. Nyanco's apology after the Mauser 90 turned out to be a hit with rats."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "mauser93"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Mauser 93"
	sawn_desc = "Perfect for baby mice."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/lebel
	skin = "Lebel"
	name = "Lebel"
	desc = "A bolt action rifle chambered in .30-06. A French design known as 'The Bell'."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "lebel"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off lebel"
	sawn_desc = "A French design known as 'The B'."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/murata
	skin = "Murata"
	name = "Murata"
	desc = "A bolt action rifle chambered in .30-06. A simple design used for brahmin ranching."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "murata"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off murata"
	sawn_desc = "A simple rifle used for veal ranching."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/carcano
	skin = "Carcano"
	name = "Carcano"
	desc = "A bolt action rifle chambered in .30-06. Chryslus Motors' first and only attempt at making a volcanic pistol. As you can see. there's a reason they stuck to making cars."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "carcano"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off carcano"
	sawn_desc = "'Let your imagination erupt!' - Chryslus Motors"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/kar98a
	skin = "KAR98A"
	name = "kar98A"
	desc = "A bolt action rifle chambered in .30-06. Chryslus Motors' first attempt at making a rifle that fit on their dashboard. Recalled after numerous reports of it not fitting on the dashboard."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "kar98a"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off kar98a"
	sawn_desc = "Now it'll fit on your dashboard!"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/kar98k
	skin = "KAR98K"
	name = "kar98K"
	desc = "A bolt action rifle chambered in .30-06. Chryslus Motors' eleventh attempt at making a rifle that fit on their dashboard. Reportedly fit better in the cup holder."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "kar98k"
	item_state = "308"
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off kar98k"
	sawn_desc = "Now it'll fit on your dashboard!"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/mosin30
	skin = "Mosin 30"
	name = "mosin 30"
	desc = "A bolt action rifle chambered in .30-06. Developed by Large Lars Francis as a competitor to the Mosin Nagant. Was successful in the fact that it was not a Mosin Nagant."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "mosin30"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off mosin 30"
	sawn_desc = "Developed by Tiny Tommy Frank as a competitor to the obrez mosin nagant. Achieved very little success."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/remington11
	skin = "Remington 11"
	name = "Remington 11"
	desc = "A bolt action rifle chambered in .30-06. Developed by 11 of the nodes comprising the Great Eastern Hiveblob in Remington Missouri to prove, once and for all, that they were the best hiveblob."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "remington11"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off remington 11"
	sawn_desc = "Developed with Node 39-A got hungry."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/servicerifle
	skin = "Service Rifle"
	name = "bolt-action rifle"
	desc = "A bolt action rifle chambered in .30-06. Developed by nobody in particular. Just a rifle."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "servicerifle"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off bolt-action rifle"
	sawn_desc = "Just a short rifle."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/revolving_rifle
	skin = "Revolving Rifle"
	name = "revolving rifle"
	desc = "A bolt action rifle chambered in .30-06. Developed by the Great Eastern Hiveblob when dared that it couldn't make a rifle that was also a revolver. Turns out it could."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "revolving"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off revolving rifle"
	sawn_desc = "A snubnosed revolving rifle."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/marlin
	skin = "Marlin"
	name = "marlin"
	desc = "A bolt action rifle chambered in .30-06. The first rifle ever approved for fishing. The fish were not impressed."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "marlin"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off marlin"
	sawn_desc = "A goldfish's worst nightmare."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/madsenm47
	skin = "Madsen M47"
	name = "madsen M47"
	desc = "A bolt action rifle chambered in .30-06. Mad Maddy Madsen's 47th attempt at a bolt action rifle. The previous 46 were okay too."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "madsenm47"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off madsen M47"
	sawn_desc = "Mad Maddy Madsen's 47-and-a-quarterth attempt at a bolt action rifle."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/springfieldww2
	skin = "Springfield WW2"
	name = "springfield WW2"
	desc = "A bolt action rifle chambered in .30-06. Easily the most rifle of all time."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "springfield_ww2"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off springfield WW2"
	sawn_desc = "Easily half the most rifle of all time."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/springfield
	skin = "Springfield"
	name = "springfield"
	desc = "A bolt action rifle chambered in .30-06. Easily the most rifle of all time."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "springfield"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off springfield WW2"
	sawn_desc = "Easily half the most rifle of all time."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
/datum/reskin/gun/hunting_rifle/p14
	skin = "P-14"
	name = "P-14"
	desc = "A bolt-action rifle. Formerly chambered in 14mm, until they missed a payment to the 14mm board. The 'P' remains a mystery."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "p14"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off P-14"
	sawn_desc = "Imagine this in 14mm."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle-sawn"

/// ENFIELD ///
/datum/component/reskinnable/enfield
	skins = list(
		"Lee-Enfield rifle",
		"SMLE",
		"Number 4",
		"Number 4 Tan",
		"Arisaka PRO",
	)
/datum/reskin/gun/enfield
	skin = "Lee-Enfield rifle"
	name = "Lee-Enfield rifle"
	desc = "A British rifle sometimes known as the SMLE. It seems to have been re-chambered in .308. Can be sawn off."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "smle"
	item_state = "smle"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Lee-Enfield rifle"
	sawn_desc = "Golly, someone sawed the smile right off its face!"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle_sawn"
/datum/reskin/gun/enfield/smle
	skin = "SMLE"
	name = "SMLE"
	desc = "A British rifle sometimes known as the SMLE. It seems to have been re-chambered in .308. Can be sawn off."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon_state = "smle"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off SMLE"
	sawn_desc = "Golly, someone sawed the smile right off its face!"
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle-sawn"
/datum/reskin/gun/enfield/no4
	skin = "Number 4"
	name = "Number 4"
	desc = "A bolt-action rifle. The fourth rifle ever made."
	icon = 'icons/fallout/objects/guns/longguns.dmi'
	icon_state = "no_4"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Number 4"
	sawn_desc = "The second rifle ever made."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle-sawn"
/datum/reskin/gun/enfield/no4tan
	skin = "Number 4 Tan"
	name = "Number 4 Tan"
	desc = "A bolt-action rifle. The fourth light-brown rifle ever made, senpai."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "no_4_tan"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Number 4 Tan"
	sawn_desc = "The second light-brown rifle ever made, senpai."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle-sawn"
/datum/reskin/gun/enfield/arisaka_new
	skin = "Arisaka PRO"
	name = "Arisaka PRO"
	desc = "A bolt-action rifle. Rumor has it, the Japanese made this as a prosumer grade rifle. It's also chambered in .308."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "arisaka"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off Arisaka PRO"
	sawn_desc = "One half of a pro is twice an amateur."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "smle-sawn"



/// GRAS ///
/datum/component/reskinnable/gras
	use_original_skin = FALSE
	skins = list(
		"Martini Henry",
	)
/datum/reskin/gun/gras/martini_henry
	skin = "Martini Henry"
	name = "martini henry"
	desc = "A breech-loading single-shot rifle with a lever action .30-06. The shortened version of Henry Martin's 'Kilometer Gun'. Considerably more portable."
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "martini_henry"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	sawn_name = "sawed off martini henry"
	sawn_desc = "The shortened version of the shortened version of Henry Martin's 'Kilometer Gun'. Considerably more portable."
	sawn_icon = 'modular_coyote/icons/objects/rifles.dmi'
	sawn_icon_state = "obrez"
	// my_lore = /datum/component/lore/martini_henry



/// GUN WITH MAG (bird with pie) (no pistols) ///
/datum/reskin/gun/pistol
	skin = "Pistol"
	name = "gun"
	desc = "Bang!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "m3civ"
	item_state = "m3civ"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	/// These are the fallbacks if we don't have a specific icon for the magazine
	var/chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	var/chambered_state = "m3civ"
	var/empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	var/empty_state = "m3civ-e"

/datum/reskin/gun/pistol/get_preview_image(obj/item/target)
	var/image/img = image(chambered_icon, chambered_state)
	return img

/datum/reskin/gun/pistol/update_skin(obj/item/gun/ballistic/target)
	if(!istype(target))
		return
	target.item_state = item_state
	. = TRUE
	target.mob_overlay_icon = mob_overlay_icon
	var/chambered = !!target.chambered
	if(chambered)
		target.icon = chambered_icon
		target.icon_state = chambered_state
	else
		target.icon = empty_icon
		target.icon_state = empty_state

//////////////////////////
/// GLOCKS ///////////////
/datum/component/reskinnable/glock
	use_original_skin = FALSE
	skins = list(
		"Glock",
		"Plock",
	)
/datum/reskin/gun/pistol/glock
	skin = "Glock"
	name = "Glock Pistol"
	desc = "A 9mm compact pistol, quite useful to have around in a holster or chest draw holster."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "glock"
	item_state = "glock"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "glock"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "glock-e"

/datum/reskin/gun/pistol/plock
	skin = "Plock"
	name = "Pink Glock Pistol"
	desc = "A 9mm compact pistol, quite useful to have around in a holster or chest draw holster. This one is a very vibrant pink."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "plock"
	item_state = "plock"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "plock"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "plock-e"


/datum/component/reskinnable/beretta9
	use_original_skin = FALSE
	skins = list(
		"berettam9tan",
		"berettam9",
	)

/datum/reskin/gun/pistol/berettam9tan
	skin = "Tan M9"
	name = "Tan M9 berretta"
	desc = "A 9mm compact pistol, quite useful to have around in a holster or chest draw holster. This one is tan colored!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "tanm9"
	item_state = "gun"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "tanm9"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "tanm9-e"


/datum/reskin/gun/pistol/berettam9
	skin = "Pristine M9"
	name = "Pristine M9 berretta"
	desc = "A 9mm compact pistol, quite useful to have around in a holster or chest draw holster. This one is steel and pristine looking!"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "newm9"
	item_state = "gun"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "newm9"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "newm9-e"


//////////////////////////
/// VOLCANIC PISTOL //////
/datum/component/reskinnable/volcanic
	use_original_skin = FALSE
	skins = list(
		"Volcanic",
		"Custom Volcanic",
	)
/datum/reskin/gun/pistol/volcanic
	skin = "Volcanic"
	name = "Lever action pistol"
	desc = "A Volcanic Pistol from the Volcanic Repeating Arms Company. The pistol itself is a 6 round capacity rechambered in a much more fitting .45 ACP. The gun's original problems have been seemingly taken care of as to not allow your hand or hands to blow off when using the gun itself."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "volcanic"
	item_state = "volcanic"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "volcanic"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "volcanic-e"
/datum/reskin/gun/pistol/volcanic_custom
	skin = "Custom Volcanic"
	name = "Custom lever action pistol"
	desc = "A Volcanic Pistol from the Volcanic Repeating Arms Company. The pistol itself is a 6 round capacity rechambered in a much more fitting .45 ACP. The gun's original problems have been seemingly taken care of as to not allow your hand or hands to blow off when using the gun itself. Now in lemon-cream flavor."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "customvolcanic"
	item_state = "customvolcanic"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	chambered_state = "customvolcanic"
	empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	empty_state = "customvolcanic-e"

/// GUN WITH MAG (bird with pie) (no pistols) ///
/datum/reskin/gun/magazine
	skin = "GunWithMaggie-nousepls"
	name = "gun"
	desc = "Bang!"
	icon = 'modular_coyote/icons/objects/rifles.dmi'
	icon_state = "308"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun/ballistic
	/// Which magazines we'll visually support
	/// Format: list(10, 15,...) gotta be numbers, not strings
	var/list/supported_sizes = list()
	/// These are the fallbacks if we don't have a specific icon for the magazine
	var/loaded_chambered_icon = 'modular_coyote/icons/objects/rifles.dmi'
	var/loaded_chambered_state = "308_loaded"
	var/loaded_empty_icon = 'modular_coyote/icons/objects/rifles.dmi'
	var/loaded_empty_state = "308_empty"
	var/unloaded_chambered_icon = 'modular_coyote/icons/objects/rifles.dmi'
	var/unloaded_chambered_state = "308_loaded"
	var/unloaded_empty_icon = 'modular_coyote/icons/objects/rifles.dmi'
	var/unloaded_empty_state = "308_empty"

/datum/reskin/gun/magazine/get_preview_image(obj/item/pda/target)
	if(LAZYLEN(supported_sizes))
		var/loadnumber = LAZYACCESS(supported_sizes, 1)
		var/image/img = image(icon, "[icon_state]-[loadnumber]")
		return img
	var/image/img = image(loaded_chambered_icon, loaded_chambered_state)
	return img

/datum/reskin/gun/magazine/update_skin(obj/item/gun/ballistic/target)
	if(!istype(target))
		return
	. = TRUE
	target.item_state = item_state
	target.mob_overlay_icon = mob_overlay_icon
	var/obj/item/ammo_box/magazine/mag = target.magazine
	var/loaded = istype(mag)
	var/chambered = !!target.chambered
	if(loaded) // gonna use the fancy magazine stuff
		var/magsize = mag.max_ammo
		if(magsize in supported_sizes)
			var/state_to_use = "[icon_state]-[magsize]"
			if(!chambered)
				state_to_use = "[state_to_use]-e"
			target.icon = icon
			target.icon_state = state_to_use
			return
		if(chambered)
			target.icon = loaded_chambered_icon
			target.icon_state = loaded_chambered_state
			return
		target.icon = loaded_empty_icon
		target.icon_state = loaded_empty_state
		return
	if(chambered) // chambered and unloaded
		target.icon = unloaded_chambered_icon
		target.icon_state = unloaded_chambered_state
		return
	target.icon = unloaded_empty_icon
	target.icon_state = unloaded_empty_state

///////////////////////
/// SERVICE RIFLES ///
/datum/component/reskinnable/service_rifle
	use_original_skin = FALSE
	skins = list(
		"Service Rifle",
		"ALR-15",
	)
/datum/reskin/gun/magazine/service_rifle
	skin = "Service Rifle"
	name = "service rifle"
	desc = "A Pre-Fall semi-automatic rifle that saw extensive use with the US military. Chambered in 5.56x45 and capable of accepting bayonets, these rifles remain popular with militas and caravans alike."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "service_rifle"
	item_state = "servicerifle"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	supported_sizes = list(10, 20, 30, 50)
	loaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	loaded_chambered_state = "service_rifle-20"
	loaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	loaded_empty_state = "service_rifle-20-e"
	unloaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_chambered_state = "service_rifle"
	unloaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_empty_state = "service_rifle-e"
/datum/reskin/gun/magazine/alr
	skin = "ALR-15"
	name = "ALR-15"
	desc = "Built entirely out of space-age plastic, the Abby-Lante Reciprocator weighs only 15 grams. The rest of the gun is made out of steel, and weighs 15 kilograms. The ALR-15 is chambered in 5.56x45mm, and is capable of accepting bayonets."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "alr15"
	item_state = "alr15"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	supported_sizes = list(10, 20, 30, 50)
	loaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	loaded_chambered_state = "alr15-20"
	loaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	loaded_empty_state = "alr15-20-e"
	unloaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_chambered_state = "alr15"
	unloaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_empty_state = "alr15-e"

///////////////////////
/// 556 AUTO RIFLES ///
/datum/component/reskinnable/auto_556
	use_original_skin = FALSE
	skins = list(
		"Assault Carbine",
		"SCAR-L",
	)
/datum/reskin/gun/magazine/ass_cabine
	skin = "Assault Carbine"
	name = "assault carbine"
	desc = "The U.S. army carbine version of the R91, made by Colt and issued to special forces."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "assault_carbine"
	item_state = "assault_carbine"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	supported_sizes = list(10, 20, 30, 50)
	loaded_chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	loaded_chambered_state = "assault_carbine-20"
	loaded_empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	loaded_empty_state = "assault_carbine-20-e"
	unloaded_chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	unloaded_chambered_state = "assault_carbine-e"
	unloaded_empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	unloaded_empty_state = "assault_carbine-e"
/datum/reskin/gun/magazine/scar_l
	skin = "SCAR-L"
	name = "SCAR-L"
	desc = "As an ancient modern rifle chambered in 5mm, the Sierra Catgirl Army Rifle - (maLe) is a popular choice for those wanting to patrol the Northwestern Silvervine."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "scarl"
	item_state = "scarl"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	supported_sizes = list()
	loaded_chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	loaded_chambered_state = "scarl"
	loaded_empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	loaded_empty_state = "scarl"
	unloaded_chambered_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	unloaded_chambered_state = "scarl-e"
	unloaded_empty_icon = 'icons/fallout/objects/guns/ballistic.dmi'
	unloaded_empty_state = "scarl-e"


////////////////////////////
///   KELPMAGIC STAVES   ///
/datum/component/reskinnable/staff_kelpmagic
	skins = list(
		"Magic Staff",
		"Shaman Staff",
	)

/datum/reskin/gun/staff_kelpmagic/shaman
	skin = "Shaman Staff"
	name = "shaman staff"
	desc = "An intricate staff, carried for centuries by the shaman class of the tribe."
	icon = 'icons/fallout/objects/melee/twohanded.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_weapon.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/melee2h_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/melee2h_righthand.dmi'
	icon_state = "staff-shaman"
	item_state = "staff-shaman"
	expected_type = /obj/item/gun







////////////////////////////
/// DEBUG SERVICE RIFLE ///
/datum/component/reskinnable/service_rifle/debug
	use_original_skin = FALSE
	skins = list(
		"Service Rifle",
		"Service Rifle (180)",
	)
/datum/reskin/gun/magazine/debug
	skin = "Service Rifle (180)"
	name = "Debug Service Rifle skin 180"
	desc = "Its a gun. It shoots bullets. If it kinda looks like an American 180 by default, something fucked up. but its not."
	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "smg22"
	item_state = "308"
	mob_overlay_icon = null
	mutantrace_variation = null
	expected_type = /obj/item/gun
	supported_sizes = list(180)
	loaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	loaded_chambered_state = "m72-10"
	loaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	loaded_empty_state = "mini-uzi-32-e"
	unloaded_chambered_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_chambered_state = "sten"
	unloaded_empty_icon = 'icons/obj/guns/projectile.dmi'
	unloaded_empty_state = "smg10mm-e"

/obj/item/gun/ballistic/automatic/service/debug_skin
	name = "debug rifle"
	desc = "its a service rifle that turns into other shit. if you see this, call 1-800-IMC-ODER"
	icon_state = "service_rifle"
	item_state = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle
	extra_mag_types = list(/obj/item/ammo_box/magazine/m22smg)
	reskinnable_component = /datum/component/reskinnable/service_rifle/debug




/obj/item/storage/backpack/debug_reskins
	name = "debug reskin crate"
	desc = "A box full of devshit!"

/obj/item/storage/backpack/debug_reskins/PopulateContents()
	. = ..()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/wirecutters(src)
	new /obj/item/crowbar(src)
	new /obj/item/pen/fountain/captain(src)
	new /obj/item/reagent_containers/glass/bottle/vial/small(src)
	new /obj/item/reagent_containers/glass/bottle/vial/large(src)
	new /obj/item/clothing/head/f13/ncr(src)
	new /obj/item/pda(src)
	new /obj/item/pda(src)
	new /obj/item/gun/ballistic/rifle/antique/gras(src)


