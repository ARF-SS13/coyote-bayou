/obj/item/organ/genital
	color = "#fcccb3"
	w_class = WEIGHT_CLASS_SMALL
	organ_flags = ORGAN_NO_DISMEMBERMENT|ORGAN_EDIBLE
	var/pornhud_slot = PHUD_NONE
	var/associated_has = CS_MISC // for cockstring stuff
	var/shape
	var/sensitivity = 1 // wow if this were ever used that'd be cool but it's not but i'm keeping it for my unshit code
	var/genital_flags //see citadel_defines.dm
	var/genital_visflags
	/// What flag is this associated with?
	var/hide_flag = HIDE_MISC
	var/masturbation_verb = "masturbate"
	var/orgasm_verb = "cumming" //present continous
	var/arousal_verb = "You feel aroused"
	var/unarousal_verb = "You no longer feel aroused"
	var/fluid_transfer_factor = 0 //How much would a partner get in them if they climax using this?
	var/size = 2 //can vary between num or text, just used in icon_state strings
	var/prev_size = 2 // the last size we were, for determining resizedness. should always be a number
	var/cached_size = 2 // our current size, in numberform
	var/datum/reagent/fluid_id = null
	var/fluid_max_volume = 50
	var/fluid_efficiency = 1
	var/fluid_rate = CUM_RATE
	var/fluid_mult = 1
	var/last_orgasmed = 0
	var/aroused_state = FALSE //Boolean used in icon_state strings
	var/obj/item/organ/genital/linked_organ
	var/linked_organ_slot //used for linking an apparatus' organ to its other half on update_link().
	var/layer_index = GENITAL_LAYER_INDEX //Order should be very important. FIRST vagina, THEN testicles, THEN penis, as this affects the order they are rendered in.

/obj/item/organ/genital/Initialize(mapload, do_update = TRUE)
	. = ..()
	if(do_update)
		update()

/obj/item/organ/genital/Destroy()
	if(linked_organ?.linked_organ == src)
		linked_organ.linked_organ = null
	linked_organ = null
	. = ..()

/obj/item/organ/genital/proc/format_for_tgui()
	return

/obj/item/organ/genital/proc/update_size()
	return

/obj/item/organ/genital/proc/update()
	if(QDELETED(src))
		return
	update_size()
	update_appearance()
	if(genital_flags & UPDATE_OWNER_APPEARANCE && owner && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.update_genitals()
	// if(linked_organ_slot || (linked_organ && !owner))
	// 	update_link()

/obj/item/organ/genital/proc/get_icon_state(mob/living/carbon/cockhaver, datum/sprite_accessory/sprote, aroused_state, layertext)
	return "[slot]_[sprote.icon_state]_[size][(cockhaver.dna.species.use_skintones && !cockhaver.dna.skin_tone_override) ? "_s" : ""]_[aroused_state]_[layertext]"

//exposure and through-clothing code
/mob/living/carbon
	var/list/exposed_genitals = list() //Keeping track of them so we don't have to iterate through every genitalia and see if exposed

/obj/item/organ/genital/proc/is_exposed()
	var/exposed = check_exposure()
	SSpornhud.update_visibility(owner, pornhud_slot, exposed)
	return exposed

/obj/item/organ/genital/proc/check_exposure()
	if(!owner || CHECK_BITFIELD(genital_flags,GENITAL_INTERNAL) || CHECK_BITFIELD(genital_visflags,GENITAL_ALWAYS_HIDDEN))
		return FALSE
	if(CHECK_BITFIELD(genital_visflags,GENITAL_ALWAYS_VISIBLE))
		return TRUE

	. = TRUE // we're visible, unless something is hiding us
	// I am looking at your underwear *respectfully*
	if(CHECK_BITFIELD(genital_visflags, GENITAL_RESPECT_UNDERWEAR) && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(!(NO_UNDERWEAR in H.dna.species.species_traits))
			var/datum/sprite_accessory/underwear/top/T = H.hidden_undershirt ? null : GLOB.undershirt_list[H.undershirt]
			var/datum/sprite_accessory/underwear/bottom/B = H.hidden_underwear ? null : GLOB.underwear_list[H.underwear]
			switch(slot)
				if(ORGAN_CHEST_GENITALS)
					if(T?.covers_chest)
						return FALSE
					if(B?.covers_chest)
						return FALSE
				if(ORGAN_BELLY_GENITALS)
					if(T?.covers_belly)
						return FALSE
					if(B?.covers_belly)
						return FALSE
				if(ORGAN_GROIN_GENITALS)
					if(T?.covers_groin)
						return FALSE
					if(B?.covers_groin)
						return FALSE
	if(CHECK_BITFIELD(genital_visflags, GENITAL_RESPECT_CLOTHING) && ishuman(owner))
		switch(slot) //update as more genitals are added Okay - lagg
			if(ORGAN_BELLY_GENITALS, ORGAN_CHEST_GENITALS)
				return owner.is_chest_exposed()
			if(ORGAN_GROIN_GENITALS) // heard it here first folks, belly is in the groin // why do my stupid comments stop being relevant just one PR after I make them
				return owner.is_groin_exposed()

/// fed all the flags at once on init, fed one at a time when poked by the verb
/obj/item/organ/genital/proc/update_genital_visibility(gunt_flags, update = TRUE, initting = FALSE)
	if(!isnum(gunt_flags))
		gunt_flags = text2num(gunt_flags)
	if(initting)
		owner?.exposed_genitals -= src
		genital_visflags = gunt_flags
		if(CHECK_BITFIELD(gunt_flags, GENITAL_ALWAYS_VISIBLE) || (!CHECK_BITFIELD(genital_visflags, GENITAL_RESPECT_CLOTHING) && !CHECK_BITFIELD(genital_visflags, GENITAL_RESPECT_UNDERWEAR)))
			owner?.exposed_genitals |= src
	else
		//if(IS_GENITAL_VIS_OVERRIDE(gunt_flags))
		if(CHECK_BITFIELD(gunt_flags, GENITAL_ALWAYS_HIDDEN))
			ENABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_HIDDEN)
			DISABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_VISIBLE)
			owner?.exposed_genitals -= src
		if(CHECK_BITFIELD(gunt_flags, GENITAL_ALWAYS_VISIBLE))
			ENABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_VISIBLE)
			DISABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_HIDDEN)
			owner?.exposed_genitals |= src
		if(CHECK_BITFIELD(gunt_flags, GENITAL_NO_OVERRIDE)) // i LOVE the hit new anime Genital No Override!
			DISABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_VISIBLE)
			DISABLE_BITFIELD(genital_visflags,GENITAL_ALWAYS_HIDDEN)
			owner?.exposed_genitals -= src
		// here be layering shit
		if(CHECK_BITFIELD(gunt_flags, GENITAL_ABOVE_UNDERWEAR))
			ENABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_UNDERWEAR)
			DISABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_CLOTHING)
			DISABLE_BITFIELD(genital_visflags,GENITAL_UNDER_UNDERWEAR)
		if(CHECK_BITFIELD(gunt_flags, GENITAL_ABOVE_CLOTHING))
			DISABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_UNDERWEAR)
			ENABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_CLOTHING)
			DISABLE_BITFIELD(genital_visflags,GENITAL_UNDER_UNDERWEAR)
		if(CHECK_BITFIELD(gunt_flags, GENITAL_UNDER_UNDERWEAR))
			DISABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_UNDERWEAR)
			DISABLE_BITFIELD(genital_visflags,GENITAL_ABOVE_CLOTHING)
			ENABLE_BITFIELD(genital_visflags,GENITAL_UNDER_UNDERWEAR)
		
		if(CHECK_BITFIELD(gunt_flags, GENITAL_RESPECT_UNDERWEAR))
			TOGGLE_BITFIELD(genital_visflags,GENITAL_RESPECT_UNDERWEAR)
		if(CHECK_BITFIELD(gunt_flags, GENITAL_RESPECT_CLOTHING))
			TOGGLE_BITFIELD(genital_visflags,GENITAL_RESPECT_CLOTHING)

	if(update && ishuman(owner)) //recast to use update genitals proc
		var/mob/living/carbon/human/H = owner
		H.update_genitals()

/// Allows you to rearrange your guts
/mob/living/carbon/verb/toggle_genitals()
	set category = "Private"
	set name = "Private Panel"
	set desc = "Allows you to modify various aspects of your jiggly bits and underwear."
	show_genital_panel()

/mob/living/carbon/proc/show_genital_panel()
	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		genital_list |= G
	var/list/dat = list("<center>")
	/// woo lookit me im a web designer from the early 2010s!
	dat += "<table class='table_genital_list'>"
	dat += "<tr class='talign'>"
	dat += "<td class='talign'>"
	dat += "<div class='gen_name'>Modify Unmentionables</div>"
	dat += "</td></tr>"
	dat += "<tr class='talign'><td class='talign'>"
	dat += "<div class='gen_container'>"
	for(var/obj/item/organ/genital/nad in genital_list)
		dat += "<div class='gen_setting_name'>Your [nad.name]:</div>"
		dat += {"<a 
					class='clicky' 
					href='
						?src=[REF(nad)];
						action=open_genital_window'>
							Modify?
				</a>"}
	dat += "<div class='gen_setting_name'>Layering and Visibility:</div>"
	dat += {"<a 
				class='clicky' 
				href='
					?src=[REF(src)];
					action=open_genital_layering'>
						Modify?
			</a>"}
	dat += "<div class='gen_setting_name'>Underwear:</div>"
	dat += {"<a 
				class='clicky' 
				href='
					?src=[REF(src)];
					action=open_sockdrawer'>
						Modify?
			</a>"}
	dat += "<div class='gen_setting_name'>See/Unsee Genitals:</div>"
	dat += {"<a 
				class='clicky' 
				href='
					?src=[REF(src)];
					action=open_genital_hide'>
						Modify?
			</a>"}
	dat += "</div>"
	dat += "</td></tr>"
	dat += "</table>" // leaving this one out makes the save/undo line show up over the table, oddly enough!
	dat += "</center>"

	winshow(src, "erp_window", TRUE)
	var/datum/browser/popup = new(src, "erp_window", "<div align='center'>Rearrange Your Guts</div>", 400, 500)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(src, "erp_window", src)

/// returns a huge grody list thing
/obj/item/organ/genital/proc/get_genital_panel()
	if(!owner || !iscarbon(owner))
		stack_trace("[src] genital menu called without an actual owner!")
		return
	var/anythingatall = FALSE
	var/list/dat = list()
	dat += {"<a 
				class='clicky'
				href='
					?src=[REF(owner)];
					action=genital_return'>
						Go back
			</a>"}
	dat += "<table class='table_genital_list'>"
	dat += "<tr class='talign'>"
	dat += "<td class='talign'>"
	dat += "<div class='gen_name'>[name]</div>"
	dat += "</td></tr>"

	dat += "<tr class='talign'><td class='talign'>"
	dat += "<div class='gen_container'>"
	if(CHECK_BITFIELD(genital_flags, GENITAL_CAN_RECOLOR))
		anythingatall = TRUE
		dat += "<div class='gen_setting_name'>Color:</div>"
		dat += {"<a 
					class='clicky'
					style='
						background-color:[color]' 
					href='
						?src=[REF(src)];
						action=recolor'>
							[color]
				</a>"}
	if(CHECK_BITFIELD(genital_flags, GENITAL_CAN_RESHAPE))
		anythingatall = TRUE
		dat += "<div class='gen_setting_name'>Shape:</div>"
		dat += {"<a 
					class='clicky' 
					href='
						?src=[REF(src)];
						action=reshape'>
							[shape]
				</a>"}
	if(CHECK_BITFIELD(genital_flags, GENITAL_CAN_RESIZE))
		anythingatall = TRUE
		dat += "<div class='gen_setting_name'>Size:</div>"
		dat += {"<a 
					class='clicky' 
					href='
						?src=[REF(src)];
						action=resize'>
							[size_kind()]
				</a>"}
	if(CHECK_BITFIELD(genital_flags, GENITAL_CAN_AROUSE))
		anythingatall = TRUE
		dat += "<div class='gen_setting_name'>Arousal:</div>"
		dat += {"<a 
					class='clicky' 
					href='
						?src=[REF(src)];
						action=arouse'>
							[arousal_term()]
				</a>"}
	if(!anythingatall)
		dat += "<div class='gen_setting_name'>Nothing here! =3</div>"
	dat += "</div>"
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>" // leaving this one out makes the save/undo line show up over the table, oddly enough!
	dat += "<br>"
	winshow(owner, "erp_window", TRUE)
	var/datum/browser/popup = new(owner, "erp_window", "<div align='center'>Rearrange Your Guts</div>", 480, 640)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(owner, "erp_window", src)

/obj/item/organ/genital/Topic(href, list/href_list)
	. = ..()
	if(owner != usr) // hope not
		return
	switch(href_list["action"])
		if("open_genital_window")
			get_genital_panel()
			return
		if("go_back") // return to the mob's own genital panel
			if(iscarbon(usr))
				var/mob/living/carbon/user = usr
				user.show_genital_panel()
			return
		if("recolor")
			var/new_color = input(usr, "Recolor:", "Character Preference","[color]") as color|null
			if(new_color)
				var/temp_hsv = RGBtoHSV(new_color)
				if(ReadHSV(temp_hsv)[3] >= ReadHSV(MINIMUM_MUTANT_COLOR)[3])
					color = sanitize_hexcolor(new_color, 6, TRUE)
					to_chat(usr,span_notice("New color set!"))
				else
					to_chat(usr,span_danger("Invalid color! Your color is not bright enough."))
			get_genital_panel()
		if("resize")
			resize_genital(usr)
			get_genital_panel()
		if("reshape")
			reshape_genital(usr)
			get_genital_panel()
		if("change_vis_override")
			var/list/genital_overrides = GENITAL_VIS_FLAG_LIST
			var/new_visibility = input(usr, "Set a visibility override! If set, this part will always be visible/hidden, regardless of how covered it is.", "Character Preference", href_list["genital_flag"]) as null|anything in genital_overrides
			if(new_visibility)
				var/new_bit = genital_overrides[new_visibility]
				update_genital_visibility(new_bit)
			get_genital_panel()
		if("change_vis_flag")
			var/new_bitt = text2num(href_list["genital_flag"])
			update_genital_visibility(new_bitt)
			get_genital_panel()
		if("arouse")
			toggle_arousal()
			get_genital_panel()
	update()
	

/obj/item/organ/genital/proc/modify_size(modifier, min = -INFINITY, max = INFINITY)
	fluid_max_volume += modifier*2.5
	fluid_rate += modifier*0.1
	return

/obj/item/organ/genital/proc/set_size(newsize)
	// TODO: add in fluid shit in here (not actual shit)
	return

/// returns what kind of size this is
/obj/item/organ/genital/proc/size_kind()
	return "Size-[size]"

/// Lets a user resize the genital, if possible
/obj/item/organ/genital/proc/resize_genital(mob/user)
	return

/// Lets a user reshape the genital, if possible
/obj/item/organ/genital/proc/reshape_genital(mob/user)
	update()
	return

/// Erect/flaccid, drippy/dry, etc
/obj/item/organ/genital/proc/arousal_term()
	if(aroused_state)
		return "Turned on"
	return "Turned off"

/// Do something when made (un)aroused
/obj/item/organ/genital/proc/toggle_arousal(set_state, force_state)
	var/old_arousal = aroused_state
	if(!CHECK_BITFIELD(genital_flags, GENITAL_CAN_AROUSE))
		aroused_state = FALSE
		return FALSE
	if(force_state)
		aroused_state = !isnull(set_state) ? set_state : !aroused_state
	else if(HAS_TRAIT(owner,TRAIT_PERMABONER) && !aroused_state)
		aroused_state = TRUE
	else if(HAS_TRAIT(owner,TRAIT_NEVERBONER) && aroused_state)
		aroused_state = FALSE
	else
		aroused_state = !isnull(set_state) ? set_state : !aroused_state
	if(old_arousal == aroused_state)
		return aroused_state
	switch(aroused_state)
		if(TRUE)
			on_arouse()
		if(FALSE)
			on_unarouse()
	return aroused_state

/// your butt sets people on fire when horny
/obj/item/organ/genital/proc/on_arouse()
	update_appearance()
	owner?.update_body(TRUE)

/// your womb eats a burger when unhorny
/obj/item/organ/genital/proc/on_unarouse()
	update_appearance()
	owner?.update_body(TRUE)

/// Extra genital panels for extra cool folks
/obj/item/organ/genital/proc/extra_genital_panel()
	return

/obj/item/organ/genital/proc/update_appearance()
	if(!owner || owner.stat == DEAD)
		aroused_state = FALSE

/obj/item/organ/genital/proc/generate_fluid(datum/reagents/R)
	var/amount = clamp((fluid_rate * ((world.time - last_orgasmed) / (10 SECONDS)) * fluid_mult),0,fluid_max_volume)
	R.clear_reagents()
	R.maximum_volume = fluid_max_volume
	if(fluid_id)
		R.add_reagent(fluid_id,amount)
	else if(linked_organ?.fluid_id)
		R.add_reagent(linked_organ.fluid_id,amount)
	return TRUE

/obj/item/organ/genital/proc/update_link()
	if(owner)
		if(linked_organ)
			return FALSE
		linked_organ = owner.getorganslot(linked_organ_slot)
		if(linked_organ)
			linked_organ.linked_organ = src
			linked_organ.upon_link()
			upon_link()
			return TRUE
	if(linked_organ)
		linked_organ.linked_organ = null
		linked_organ = null
	return FALSE

//post organ duo making arrangements.
/obj/item/organ/genital/proc/upon_link()
	return

/obj/item/organ/genital/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(.)
		update()
		RegisterSignal(owner, COMSIG_MOB_DEATH,PROC_REF(update_appearance))
		if(genital_visflags & GENITAL_ALWAYS_VISIBLE)
			owner.exposed_genitals += src

/obj/item/organ/genital/Remove(special = FALSE)
	. = ..()
	var/mob/living/carbon/C = .
	update()
	if(!QDELETED(C))
		if(genital_flags & UPDATE_OWNER_APPEARANCE && ishuman(C))
			var/mob/living/carbon/human/H = .
			H.update_genitals()
		C.exposed_genitals -= src
		UnregisterSignal(C, COMSIG_MOB_DEATH)

//proc to give a player their genitals and stuff when they log in
/mob/living/carbon/human/proc/give_genitals(clean = FALSE)//clean will remove all pre-existing genitals. proc will then give them any genitals that are enabled in their DNA
	if(clean)
		destroy_genitals()
	if (NOGENITALS in dna.species.species_traits)
		return
	if(dna.features["has_vag"])
		give_genital(/obj/item/organ/genital/vagina, FALSE)
	if(dna.features["has_womb"])
		give_genital(/obj/item/organ/genital/womb, FALSE)
	if(dna.features["has_balls"])
		give_genital(/obj/item/organ/genital/testicles, FALSE)
	if(dna.features["has_breasts"])
		give_genital(/obj/item/organ/genital/breasts, FALSE)
	if(dna.features["has_butt"])
		give_genital(/obj/item/organ/genital/butt, FALSE)
	if(dna.features["has_cock"])
		give_genital(/obj/item/organ/genital/penis, FALSE)
	if(dna.features["has_belly"])
		give_genital(/obj/item/organ/genital/belly, FALSE)
	update_body(TRUE)

/mob/living/carbon/human/proc/give_genital(obj/item/organ/genital/G, update = TRUE)
	if(!dna || (NOGENITALS in dna.species.species_traits) || getorganslot(initial(G.slot)))
		return FALSE
	G = new G(null, FALSE)
	G.get_features(src, update)
	G.Insert(src)
	return G

/// Called when the giblet is first stuffed into the mob
/obj/item/organ/genital/proc/get_features(mob/living/carbon/human/H, update = TRUE)
	return

/// Returns its respective sprite accessory from the global list (full of init'd types, hopefully)
/obj/item/organ/genital/proc/get_sprite_accessory()
	return

/// Returns what layer this awful thing should be on, for a given Position ("FRONT", "MID", "BEHIND")
/obj/item/organ/genital/proc/get_layer_number(position)
	switch(position)
		if("FRONT", "MID")
			if(CHECK_BITFIELD(genital_visflags, GENITAL_ABOVE_CLOTHING)) // over clothing takes priority
				return GENITAL_OVER_CLOTHES_FRONT_LAYER
			if(CHECK_BITFIELD(genital_visflags, GENITAL_ABOVE_UNDERWEAR))
				return GENITAL_OVER_UNDERWEAR_FRONT_LAYER
			return GENITAL_UNDER_UNDERWEAR_FRONT_LAYER // under both underwear and clothing
		// if("MID")
		// 	if(CHECK_BITFIELD(genital_visflags, GENITAL_ABOVE_CLOTHING)) // over clothing takes priority
		// 		return GENITAL_OVER_CLOTHES_MID_LAYER
		// 	if(CHECK_BITFIELD(genital_visflags, GENITAL_ABOVE_UNDERWEAR))
		// 		return GENITAL_OVER_UNDERWEAR_MID_LAYER
		// 	return GENITAL_UNDER_UNDERWEAR_MID_LAYER // under both underwear and clothing
		if("BEHIND")
			return GENITALS_BEHIND_LAYER // behind is just always in the back

/// Handle whether or not this thing should mask anything out. mostly just for butts
/// returns an icon if masked, nothing otherwise (so it can be a cheaper mutable appearance thing)
/obj/item/organ/genital/proc/mask_part(icon_in, state_in, layer, position)
	return

/// Ahah. Ahah hah. You fuckin butts thought you were sooooo clever, putting hands in front of things and making a mess of layering
/// Lets see how clever you are with a hand-shaped hole in your ass!!!
/// Cuts a hole in genitals
/obj/item/organ/genital/proc/cut_up_genital(icon_in,state_in,list/masks)
	var/icon/I = icon(icon_in, state_in)
	var/icon/alpha
	for(var/cookie in masks)
		alpha = icon('icons/obj/genitals/mask.dmi', cookie)
		I.Blend(alpha, ICON_MULTIPLY)
	return I

/// Holds a list of relevant genital layers and positions
GLOBAL_LIST_INIT(genital_layers, list(
	// "layers" = list(
	// 	GENITALS_BEHIND_LAYER,
	// 	GENITAL_UNDER_UNDERWEAR_FRONT_LAYER,
	// 	GENITAL_UNDER_UNDERWEAR_MID_LAYER,
	// 	GENITAL_OVER_UNDERWEAR_FRONT_LAYER,
	// 	GENITAL_OVER_UNDERWEAR_MID_LAYER,
	// 	GENITAL_OVER_CLOTHES_FRONT_LAYER,
	// 	GENITAL_OVER_CLOTHES_MID_LAYER,
	// 	),
	"positions" = list(
		"BEHIND",
		"MID",
		"FRONT"
	)
))

/// That way, we can update *EVERYONES* genitals when someone updates their genitals
/mob/living/carbon/human/proc/signal_update_genitals()
	update_genitals(FALSE) // and prevents infinite loops

/// clears all genital overlays, and reapplies them
/mob/living/carbon/human/proc/update_genitals(signal = TRUE)
	if(QDELETED(src) || IsFeral())
		return
	for(var/layernum in GLOB.genital_layers["layers"]) // Clear all our genital overlays
		remove_overlay(layernum)
	SSpornhud.flush_genitals(src)

	//okay cool, compile a list of genitals that are visible
	var/list/genitals_to_add[GENITAL_LAYER_INDEX_LENGTH]
	var/has_nads = FALSE
	var/list/nad_order = splittext(dna?.features["genital_order"], ":") // NOT reversed cus the reversal is only for UI shit
	for(var/obj/item/organ/genital/geni in internal_organs)
		if(geni.is_exposed()) //Checks appropriate clothing slot and if it's through_clothes
			genitals_to_add[clamp(nad_order.Find(geni.associated_has), 1, GENITAL_LAYER_INDEX_LENGTH)] = geni
			has_nads = TRUE
	if(!has_nads)
		return

	/// for the fuckin preview thing
	var/list/genital_sprites = list() // format list("[layer_number]" = list(mutable_sprites))
	for(var/obj/item/organ/genital/nad in genitals_to_add)
		var/list/nadpics = list()
		// list of sprites for these genitals (usually one or two)
		for(var/position in GLOB.genital_layers["positions"]) // "BEHIND", "MID", "FRONT"
			var/layer_to_put_it = nad.get_layer_number(position)
			if(!layer_to_put_it)
				continue // not all nads have all three. in fact none of them do!
			var/datum/sprite_accessory/sprite_acc = nad.get_sprite_accessory()
			if(!sprite_acc || sprite_acc.icon_state == "none")
				continue
			var/aroused_state = nad.aroused_state && sprite_acc.alt_aroused
			var/accessory_icon = sprite_acc.icon
			var/do_center = sprite_acc.center
			var/dim_x = sprite_acc.dimension_x
			var/dim_y = sprite_acc.dimension_y
			if(nad.genital_flags & GENITAL_CAN_TAUR && sprite_acc.taur_icon && (!sprite_acc.feat_taur || dna.features[sprite_acc.feat_taur]) && dna.species.mutant_bodyparts["taur"])
				var/datum/sprite_accessory/taur/T = GLOB.taur_list[dna.features["taur"]]
				if(T?.taur_mode & sprite_acc.accepted_taurs)
					accessory_icon = sprite_acc.taur_icon
					do_center = TRUE
					dim_x = sprite_acc.taur_dimension_x
					dim_y = sprite_acc.taur_dimension_y
			var/genital_state = nad.get_icon_state(src, sprite_acc, aroused_state, position)
			if(!genital_state)
				continue
			/// this SHOULD(tm) make arms show up over butts from the front -- currently broken, love Lagg
			var/icon/grundle_out = nad.mask_part(accessory_icon, genital_state, layer_to_put_it, position)
			var/mutable_appearance/genital_overlay = mutable_appearance(grundle_out ? grundle_out : accessory_icon, genital_state, layer = -layer_to_put_it)
			var/image/gross_image = image(grundle_out ? grundle_out : accessory_icon, src, genital_state, layer = -layer_to_put_it) // mutable appearances just... dont work for client images. rip performance

			if(do_center)
				genital_overlay = center_image(genital_overlay, dim_x, dim_y)
				gross_image = center_image(genital_overlay, dim_x, dim_y)

			// color color color
			if(dna.species.use_skintones)
				genital_overlay.color = SKINTONE2HEX(skin_tone)
				gross_image.color = SKINTONE2HEX(skin_tone)
			else
				genital_overlay.color = nad.color
				gross_image.color = nad.color
			// set the sprite's layer
			genital_overlay.layer = -layer_to_put_it
			//gross_image.layer = -layer_to_put_it
			genital_overlay.loc = src
			gross_image.loc = src
			gross_image.layer = SSpornhud.get_layer(src, nad.pornhud_slot, position)
			// and then add it to the genital_sprites layer list thing
			if(!genital_sprites["[layer_to_put_it]"])
				genital_sprites["[layer_to_put_it]"] = list()

			// cus byond doesnt like arbitrary indexes or something, idk im dum
			genital_sprites["[layer_to_put_it]"] |= genital_overlay
			nadpics += gross_image
		SSpornhud.catalogue_part(src, nad.pornhud_slot, nadpics)

	if(istype(src, /mob/living/carbon/human/dummy)) // cus our user eyes dont have PornHUDs in the character prefs window
		for(var/index in genital_sprites)
			overlays_standing[text2num(index)] = genital_sprites[index]
			apply_overlay(text2num(index))

//Checks to see if organs are new on the mob, and changes their colours so that they don't get crazy colours.
/mob/living/carbon/human/proc/emergent_genital_call()
	if(!client?.prefs?.arousable)
		return FALSE

	var/organCheck = locate(/obj/item/organ/genital) in internal_organs
	var/breastCheck = getorganslot(ORGAN_SLOT_BREASTS)
	var/willyCheck = getorganslot(ORGAN_SLOT_PENIS)
	var/buttCheck = getorganslot(ORGAN_SLOT_BUTT)
	var/bellyCheck = getorganslot(ORGAN_SLOT_BELLY)

	if(organCheck == FALSE)
		if(src.dna.species.fixed_mut_color)
			dna.features["cock_color"] = "[dna.species.fixed_mut_color]"
			dna.features["breasts_color"] = "[dna.species.fixed_mut_color]"
			dna.features["butt_color"] = "[dna.species.fixed_mut_color]"
			dna.features["belly_color"] = "[dna.species.fixed_mut_color]"
			return
		//So people who haven't set stuff up don't get rainbow surprises.
		dna.features["cock_color"] = "[dna.features["mcolor"]]"
		dna.features["breasts_color"] = "[dna.features["mcolor"]]"
		dna.features["butt_color"] = "[dna.features["mcolor"]]"
		dna.features["belly_color"] = "[dna.features["mcolor"]]"
	else //If there's a new organ, make it the same colour.
		if(breastCheck == FALSE)
			dna.features["breasts_color"] = dna.features["cock_color"]
		else if (willyCheck == FALSE)
			dna.features["cock_color"] = dna.features["breasts_color"]
		else if (buttCheck == FALSE)
			dna.features["butt_color"] = dna.features["cock_color"] ? dna.features["cock_color"] : dna.features["breasts_color"]
		else if (bellyCheck == FALSE)
			dna.features["belly_color"] = dna.features["cock_color"] ? dna.features["cock_color"] : dna.features["breasts_color"]
	return TRUE

/// uh hi we're here to reposess your nads
/mob/living/carbon/human/proc/destroy_genitals()
	for(var/obj/item/organ/genital/mike_look_down in internal_organs)
		qdel(mike_look_down)
