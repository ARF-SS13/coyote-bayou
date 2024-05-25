/* 
 * Tattoos! 
 */
// Mutable appearances are children of images, just so you know. just a fun fact

#define TATTOO_SUPER_HIDDEN "arse_nath" // so butt tattoos dont show up if you lack a butt
#define TATTOO_NOT_PRIVATE "not_private" // your shoulder isnt a private part

/datum/tattoo
	/// Name of the tat
	var/name
	/// Description of the tat, flavor text, etc. Make it start lowercased!
	var/desc
	/// Optional, access related to the tat
	var/list/tat_access = list()
	/// the owning limb
	var/obj/item/bodypart/owner_limb
	/// Optional, extra desc stuff
	var/extra_desc
	/// Where on the body part is the tat?
	var/tat_location = TATTOO_FUCKUP
	/// Is the tattoo really really private? Like, hidden and needs to be nekked to show up? Maybe an old embarassing tat you keep under your hat
	var/extra_private = FALSE
	/// how faded is the tattoo? for temporary tats
	var/fadedness = TATTOO_NOT_FADED
	/// how long does the temporary tattoo last between fade cycles? total life will be around 3-4 times this. if null, its permanent
	var/fade_time
	/// is this tattoo permanent?
	var/is_permanent = FALSE
	/// just to make job-related tattoo jobs easier, only checked if its a tat that's part of a loadout or job outfit!
	var/default_bodypart = BODY_ZONE_CHEST
	/// just to make job-related tattoo jobs easier, only checked if its a tat that's part of a loadout or job outfit!
	var/default_spot = TATTOO_CHEST

/datum/tattoo/New(obj/item/bodypart/owner, datum/tattoo/cool_tat, put_here)
	. = ..()
	if(istype(cool_tat))
		name = cool_tat.name
		desc = cool_tat.desc
		tat_access = cool_tat.tat_access.Copy()
		extra_desc = cool_tat.extra_desc
		fade_time = cool_tat.fade_time
	if(istype(owner, /obj/item/bodypart))
		owner_limb = owner
	if(put_here)
		tat_location = put_here

/datum/tattoo/proc/on_apply(mob/user)
	if(fade_time)
		addtimer(CALLBACK(src,PROC_REF(fade_tattoo)), fade_time)

/datum/tattoo/Destroy(force, ...)
	if(owner_limb)
		owner_limb.tattoos -= src
		owner_limb = null
	return ..()

/// Is the tattoo visible?
/datum/tattoo/proc/is_it_visible(mob/viewer)
	if(!owner_limb)
		return FALSE
	if(!ishuman(owner_limb.owner))
		return FALSE
	var/mob/living/carbon/human/tatted = owner_limb.owner
	if(!tatted)
		return TRUE // shrug, its visible
	var/dist_between_em = get_dist(tatted, viewer)
	if(dist_between_em > TATTOO_VISIBILITY_RANGE)
		return FALSE
	var/privacy_invaded = invade_privacy()
	if(privacy_invaded == TRUE)
		return TRUE // bits are out and visible
	if(privacy_invaded == TATTOO_SUPER_HIDDEN)
		return FALSE // the boobie fell off :c
	if(privacy_invaded == TATTOO_NOT_PRIVATE && dist_between_em <= 1)
		return TRUE // close up, and the tat isnt private? see it
	if(LAZYLEN(tatted.clothingonpart(owner_limb)))
		return FALSE // uncovered? uncovered
	return TRUE

/datum/tattoo/proc/fade_tattoo()
	if(fadedness++ > TATTOO_VERY_FADED)
		qdel(src)
		return
	addtimer(CALLBACK(src,PROC_REF(fade_tattoo)), fade_time)

/// Is the tattoo somewhere really private? So you dont examine someone in power armor and find FOXYGRANDMA above their ass
/// A really in-depth check through a person's privates to see if their relevant bits are, in fact, visible
/datum/tattoo/proc/invade_privacy()
	if(extra_private)
		return FALSE // extra private? *must* be revealed
	if(!owner_limb)
		return FALSE // shouldnt happen

	var/mob/living/carbon/human/grundlehaver = owner_limb?.owner
	if(!grundlehaver)
		return TRUE // how the heck did you sever a chest? nice
	var/obj/item/organ/genital/grundle
	switch(tat_location)
		if(TATTOO_TRAMP_STAMP, TATTOO_LEFT_ASS, TATTOO_RIGHT_ASS) // Butt tattoo?
			grundle = grundlehaver.has_butt()
		if(TATTOO_WOMB_TATTOO)
			grundle = grundlehaver.has_vagina()
			if(!grundle)
				grundle = grundlehaver.has_penis()
			if(!grundle)
				grundle = grundlehaver.has_balls() // fun fact the womb is stored in the balls
		if(TATTOO_LEFT_BOOB, TATTOO_RIGHT_BOOB)
			grundle = grundlehaver.has_breasts()
		else
			return TATTOO_NOT_PRIVATE // wasnt private to begin with lol
	if(!istype(grundle)) // pro-pain
		return TATTOO_SUPER_HIDDEN // no ass, no tat
	if(grundle in grundlehaver.exposed_genitals)
		return TRUE // ur cock out
	return grundle.is_exposed() // ur cock out?

/datum/tattoo/proc/get_desc(mob/viewer, check_vis = TRUE)
	if(!owner_limb)
		return
	if(check_vis && !is_it_visible(viewer))
		return
	var/list/msg_out = list()
	msg_out += "You see \a [name] [location2words()]"
	msg_out += "\tIt features [desc]"
	if(extra_desc)
		msg_out += "\t[extra_desc]"
	if(fade_time)
		switch(fadedness)
			if(TATTOO_NOT_FADED)
				msg_out += "Looks good and fresh!"
			if(TATTOO_KINDA_FADED)
				msg_out += "Looks a little faded."
			if(TATTOO_VERY_FADED)
				msg_out += "Looks about to rub off!"
	if(isnull(fade_time))
		msg_out += "Looks permanent."
	return jointext(msg_out, "<br>")

/// takes in the tat's location, outputs words about their location
/// person is the person the tat is allegedly on, cus we dont *really* keep track ourselves
/datum/tattoo/proc/location2words()
	var/mob/living/carbon/human/person = owner_limb?.owner
	if(!person)
		stack_trace("A tattoo named [src.name] has no person attached!")
		return "somewhere."
	switch(tat_location)
		if(TATTOO_FUCKUP)
			return "misapplied over [ishuman(person) ? "[person.p_their()]" : "the"] bepis. There's a bit more written there:[span_phobia("hey this tattoo didnt set the location right, tell superlagg their shit broke.")]."
		if(TATTOO_TRAMP_STAMP)
			return "positioned over [ishuman(person) ? "[person.p_their()]" : "the"] [person.getorganslot(ORGAN_SLOT_TAIL) ? "tail" : "buttcrack"]."
		if(TATTOO_WOMB_TATTOO)
			return "positioned over [ishuman(person) ? "[person.p_their()]" : "the"] lower groin."
		if(TATTOO_LEFT_ASS)
			return "situated on [ishuman(person) ? "[person.p_their()]" : "the"] left buttcheek."
		if(TATTOO_RIGHT_ASS)
			return "situated on [ishuman(person) ? "[person.p_their()]" : "the"] right buttcheek."
		if(TATTOO_LEFT_BOOB)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] left [prob(1) ? "boobie" : "breast"]."
		if(TATTOO_RIGHT_BOOB)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] right [prob(1) ? "boobie" : "breast"]."
		if(TATTOO_CHEST)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] chest."
		if(TATTOO_BELLY)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] [pick("belly", "gut", "tummy")]."
		if(TATTOO_UPPER_BACK)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] upper back."
		if(TATTOO_LOWER_BACK)
			return "printed across [ishuman(person) ? "[person.p_their()]" : "the"] lower back."
		if(TATTOO_RIGHT_UPPER_ARM)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] right upper arm."
		if(TATTOO_RIGHT_LOWER_ARM)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] right lower arm."
		if(TATTOO_RIGHT_HAND)
			return "situated on [ishuman(person) ? "[person.p_their()]" : "the"] right hand."
		if(TATTOO_LEFT_UPPER_ARM)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] left upper arm."
		if(TATTOO_LEFT_LOWER_ARM)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] left lower arm."
		if(TATTOO_LEFT_HAND)
			return "situated across [ishuman(person) ? "[person.p_their()]" : "the"] left hand."
		if(TATTOO_RIGHT_UPPER_LEG)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] right upper leg."
		if(TATTOO_RIGHT_LOWER_LEG)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] right lower leg."
		if(TATTOO_RIGHT_FOOT)
			return "planted on [ishuman(person) ? "[person.p_their()]" : "the"] right foot."
		if(TATTOO_LEFT_UPPER_LEG)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] left upper leg."
		if(TATTOO_LEFT_LOWER_LEG)
			return "plastered across [ishuman(person) ? "[person.p_their()]" : "the"] left lower leg."
		if(TATTOO_LEFT_FOOT)
			return "planted on [ishuman(person) ? "[person.p_their()]" : "the"] left foot."
		if(TATTOO_LEFT_CHEEK)
			return "slapped on [ishuman(person) ? "[person.p_their()]" : "the"] left cheek."
		if(TATTOO_RIGHT_CHEEK)
			return "slapped on [ishuman(person) ? "[person.p_their()]" : "the"] right cheek."
		if(TATTOO_LEFT_EYE)
			return "printed around [ishuman(person) ? "[person.p_their()]" : "the"] left eye."
		if(TATTOO_RIGHT_EYE)
			return "printed around [ishuman(person) ? "[person.p_their()]" : "the"] right eye."
		if(TATTOO_FOREHEAD)
			return "drawn across [ishuman(person) ? "[person.p_their()]" : "the"] forehead."
		if(TATTOO_BIKER_RIGHT_SHOULDER)
			return "drawn across [ishuman(person) ? "[person.p_their()]" : "the"] right upper arm."
		else
			return "jammed somewhere wierd. There's a bit more written there:[span_phobia("hey this tattoo didnt set a bad location, tell superlagg their shit broke.")]."

/// Generic tattoo for overwriting with other stuff
/datum/tattoo/blank
	name = "tattoo"
	desc = "some generic tattoo-shaped tattoo. Nothing fancy, just a little ink."
	fade_time = null

/// Generic temp tattoo for overwriting with other stuff
/datum/tattoo/blank/temporary
	name = "temporary tattoo"
	desc = "some generic temporary tattoo-shaped tattoo. Nothing fancy, just a little ink."
	fade_time = 10 MINUTES

/datum/tattoo/biker
	name = "Hell's Nomads insignia"
	desc = "a bitchin' patch of skinart featuring a shitload of flames wrapped around a pair of flaming brahmin \
			skulls, with their horns done up like handlebars on a motorcycle, bordered by guns and knives and other \
			stuff a teenage boy would find badass."
	tat_access = list(ACCESS_BIKER)
	default_bodypart = BODY_ZONE_R_ARM
	default_spot = TATTOO_BIKER_RIGHT_SHOULDER
	fade_time = null

/// A tattoo *thing*
/obj/item/tattoo_holder
	name = "tattoo template"
	desc = "A little card loaded with a tattoo style."
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	force = 0
	/// our tattoo template
	var/datum/tattoo/loaded_tat = /datum/tattoo/blank
	/// Lets you apply the thing itself to a limb. Mostly for temporary tattoos
	var/customizableness = TATTOO_CUSTOMIZE_ALL
	/// Makes its name and desc resemble the loaded tat
	var/inherit_tat_name_n_desc = FALSE
	/// can be applied just by using it on yourself
	var/self_apply = FALSE
	/// how many times left can this thing be used? UNLIMITED_TATTOO for infinite uses
	var/uses_left = UNLIMITED_TATTOO
	var/applying = FALSE
	var/apply_time = 5 SECONDS

/obj/item/tattoo_holder/blank
	name = "blank template"
	desc = "A little card loaded with a tattoo style."
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	loaded_tat = /datum/tattoo/blank
	customizableness = TATTOO_CUSTOMIZE_ALL

/obj/item/tattoo_holder/blank/temporary
	name = "blank temporary template"
	desc = "A little card loaded with a tattoo style."
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	loaded_tat = /datum/tattoo/blank/temporary
	customizableness = TATTOO_CUSTOMIZE_ALL

/obj/item/tattoo_holder/biker
	name = "this failed to initialize right"
	desc = "oopsie"
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	loaded_tat = /datum/tattoo/biker
	inherit_tat_name_n_desc = TRUE
	customizableness = TATTOO_CUSTOMIZE_EXTRA

/obj/item/tattoo_holder/Initialize()
	. = ..()
	if(ispath(loaded_tat))
		loaded_tat = new loaded_tat(null, null, null)
	if(inherit_tat_name_n_desc)
		name = loaded_tat.name
		desc = "A little card loaded with [loaded_tat.desc]"

/obj/item/tattoo_holder/Destroy()
	if(istype(loaded_tat))
		QDEL_NULL(loaded_tat)
	if(loaded_tat)
		loaded_tat = null
	. = ..()

/obj/item/tattoo_holder/examine(mob/user)
	. = ..()
	var/extra = loaded_tat.extra_desc
	if(extra)
		. += extra
	var/list/what_customize = list()
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_NAME))
		what_customize += TATTOO_NAME
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_DESC))
		what_customize += TATTOO_DESC
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_EXTRA))
		what_customize += TATTOO_EXTRA
	if(LAZYLEN(what_customize))
		. += "Use in hand to customize the tattoo's [english_list(what_customize)]!"
	if(self_apply)
		. += "You can apply this to yourself or others by just targetting a limb, picking a spot, and slapping it on!"

/obj/item/tattoo_holder/attack_self(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return FALSE
	change_stuff(user)

/obj/item/tattoo_holder/pre_attack(mob/living/carbon/human/victim, mob/living/user, params)
	. = ..()
	if(self_apply)
		start_apply_tattoo(victim, user)

/// it puts the tattoo on its skin, it does a good job (at duplicating code)
/obj/item/tattoo_holder/proc/start_apply_tattoo(mob/living/carbon/human/victim, mob/living/user)
	if(applying)
		user.show_message(span_alert("You're already applying this!"))
		return
	if(!ishuman(victim))
		user.show_message(span_alert("They can't be tattooed (yet)!"))
		return
	if(!ismob(user))
		user.show_message(span_phobia("You don't exist!"))
		return
	if(!in_range(user, victim))
		user.show_message(span_alert("They're too far away!"))
		return // we'll have tattoo rifles, some day...
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		user.show_message(span_alert("You can't use this like that!"))
		return
	if(user.incapacitated())
		user.show_message(span_alert("You're incapacitated!"))
		return
	var/put_it_there = check_zone(user.zone_selected)
	if(!LAZYLEN(GLOB.tattoo_locations[put_it_there])) // just in case
		user.show_message(span_alert("That's... what even is that? [span_phobia("yeah this is probably a bug")]"))
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(put_it_there)
	if(!istype(chunk))
		user.show_message(span_alert("[victim] doesn't have one of those!"))
		return // we dont decorate phantom limbs in THIS parlor
	var/list/places_to_put_it = list()
	for(var/key in GLOB.tattoo_locations[put_it_there])
		if(GLOB.tattoo_locations[put_it_there][key] == TRUE)
			places_to_put_it += key
	if(!LAZYLEN(places_to_put_it))
		user.show_message(span_alert("Nothing there?!"))
		return
	var/tat_loc = input(user, "Where do you want to put the tattoo?", "Pick a spot!") as null|anything in places_to_put_it
	if(!tat_loc)
		user.show_message(span_alert("Never mind!"))
		return
	if(tat_loc in chunk.tattoos) // they got one there lol
		user.show_message(span_alert("There isn't enough room on [victim]'s [lowertext(tat_loc)] to fully complete your vision!"))
		return
	apply_tattoo(victim, user, tat_loc, put_it_there)

/obj/item/tattoo_holder/proc/apply_tattoo(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	applying = TRUE
	if(!ishuman(victim))
		user.show_message(span_alert("No longer exists, probably!"))
		abort()
		return
	if(!ismob(user))
		user.show_message(span_phobia("You do not exist!"))
		abort()
		return
	if(!in_range(user, victim))
		user.show_message(span_alert("They ran off!"))
		abort()
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		user.show_message(span_alert("You can't seem to use this right now!"))
		abort()
		return
	if(user.incapacitated())
		user.show_message(span_alert("You're incapacitated!"))
		abort()
		return
	if(!do_mob(user, victim, apply_time, allow_movement = TRUE)) // tattooing on the GO!
		user.show_message(span_alert("You messed up!"))
		abort()
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(part)
	if(!istype(chunk))
		user.show_message(span_alert("[victim] no longer has the part you're working on!"))
		return // we dont decorate phantom limbs in THIS parlor
	if(tat_loc in chunk.tattoos) // they got one there lol
		user.show_message(span_alert("[victim] suddenly has a tattoo on [victim.p_their()] [lowertext(tat_loc)], now there's no room for you! Great."))
		return
	finish_tattoo(victim, user, tat_loc, part)

/obj/item/tattoo_holder/proc/finish_tattoo(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	abort() // job successfully failed~
	var/obj/item/bodypart/pretty_part = victim.get_bodypart(part)
	if(!pretty_part)
		user.show_message(span_alert("[victim] no longer has the part you're working on!"))
		return // we dont decorate phantom limbs in THIS parlor
	if(!pretty_part.add_tattoo(loaded_tat, tat_loc))
		user.show_message(span_alert("You couldn't actually tattoo [victim]'s [lowertext(tat_loc)] for some reason!"))
		return
	if(!use_charge())
		qdel(src)

/// reset
/obj/item/tattoo_holder/proc/abort(mob/living/carbon/human/victim, mob/living/user)
	applying = FALSE

// returns TRUE if theres any charges left
/obj/item/tattoo_holder/proc/use_charge()
	if(uses_left == UNLIMITED_TATTOO)
		return TRUE
	if(uses_left-- > 0)
		return TRUE

// returns TRUE if theres any charges left, but doesnt decrement
/obj/item/tattoo_holder/proc/has_charge()
	return abs(uses_left) // yay maths

/obj/item/tattoo_holder/proc/change_stuff(mob/user)
	if(!istype(loaded_tat))
		loaded_tat = new
		if(!istype(loaded_tat))
			user.show_message(span_phobia("[src] doesn't have a template! This is likely a bug~"))
	var/list/customization = list()
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_NAME))
		customization += TATTOO_NAME
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_DESC))
		customization += TATTOO_DESC
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_EXTRA))
		customization += TATTOO_EXTRA
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_FADE_TIME))
		customization += TATTOO_FADE_TIME

	if(!LAZYLEN(customization))
		user.show_message(span_alert("[src] cannot be customized!"))
		return
	var/change_what
	if(LAZYLEN(customization) > 1)
		change_what = input(user, "Customize the tattoo!", "Pick a category!") as null|anything in customization
		if(!change_what)
			return
	else
		change_what = customization[1]
	switch(change_what)
		if(TATTOO_NAME)
			var/newname = stripped_input(user, "Name the tattoo this will make! Format will be \"You see a newname on Ladbro's left leg\"", "Type a name!", loaded_tat.name)
			if(newname)
				loaded_tat.name = newname
				name = "[newname] template"
				user.show_message(span_notice("You label the tattoo as \"[newname]\"."))
		if(TATTOO_DESC)
			var/newdesc = stripped_input(user, "Describe your tattoo! Format will be \"It features newdescription.\"", "Type a description!", loaded_tat.desc)
			if(newdesc)
				loaded_tat.desc = newdesc
				user.show_message(span_notice("You customize the tattoo as \"[newdesc]\"."))
				desc = "A little card loaded with [newdesc]"
		if(TATTOO_EXTRA)
			var/newextra = stripped_input(user, "Add on some extra details, like someone's name, serial number, their turn-offs, anything that'll go good after the description!", "Type some stuff!", loaded_tat.extra_desc)
			if(newextra)
				loaded_tat.extra_desc = newextra
				user.show_message(span_notice("You add \"[newextra]\" to the tattoo."))
		if(TATTOO_FADE_TIME)
			var/pickpermanent = alert(user, "Should the tattoo be permanent?",,"Yes","No",)

			loaded_tat.fade_time = null
			if(pickpermanent == "Yes")
				loaded_tat.is_permanent = TRUE
				return

			var/numdeciseconds = stripped_input(user, "How many seconds should it last? ", "Pick a number!", loaded_tat.fade_time)
			if(isnum(numdeciseconds))
				loaded_tat.fade_time = numdeciseconds SECONDS



/obj/item/tattoo_holder/biker
	name = "Hell's Nomads insignia template"
	desc = "A little card loaded with a sick biker tattoo."
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	loaded_tat = /datum/tattoo/biker
	customizableness = TATTOO_CUSTOMIZE_EXTRA
	inherit_tat_name_n_desc = TRUE
	self_apply = FALSE

/// Load in a tattoo, or make one yourself!
/obj/item/tattoo_gun
	name = "tattoo gun"
	desc = "Some kind of artistic torture device designed to stab colors into someone's flesh. The needles are long \
			enough to make your work visible, no matter how furry your victim is. Might want to keep some bandages handy."
	icon = 'icons/obj/tattoo_gun.dmi'
	icon_state = "tattoo_gun"
	w_class = WEIGHT_CLASS_NORMAL
	/// The tattoo template to engrave
	var/obj/item/tattoo_holder/flash
	/// does it start loaded with its flash?
	var/start_loaded = FALSE
	/// How long do they have to suffer per operation?
	var/time_per_operation = 2 SECONDS
	/// how many times do we have to mangle this guy for the tat to stick?
	var/operations_to_complete = 6
	/// How many times did we do a thing this cycle?
	var/operation_counter = 1
	/// is it doing something?
	var/engraving = FALSE
	/// bzzzzzzzz
	var/datum/looping_sound/tattoo_gun/soundloop

/obj/item/tattoo_gun/Initialize()
	. = ..()
	if(start_loaded)
		var/obj/item/tattoo_holder/cool_tat = new flash(src)
		insert_flash(null, cool_tat)
	soundloop = new(list(src), FALSE)

/obj/item/tattoo_gun/Destroy()
	QDEL_NULL(soundloop)
	eject_flash(delet = TRUE)
	. = ..()

/obj/item/tattoo_gun/attack_self(mob/user)
	eject_flash(user, FALSE)

/obj/item/tattoo_gun/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/tattoo_holder))
		insert_flash(user, W)
		return
	. = ..()

/obj/item/tattoo_gun/examine(mob/user)
	. = ..()
	if(!flash)
		. += span_notice("The template slot is empty. Use on someone to remove their tattoos.")
		return
	. += span_notice("It is loaded with \a [flash].")

/obj/item/tattoo_gun/proc/eject_flash(mob/user, delet)
	if(!flash)
		return
	if(delet)
		QDEL_NULL(flash)
		return
	if(ismob(user))
		user.put_in_hands(flash)
		user.show_message(span_notice("You eject [flash]."))
	else
		flash.forceMove(get_turf(src))
	flash = null
	playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)

/obj/item/tattoo_gun/proc/insert_flash(mob/user, obj/item/tattoo_holder/nutat)
	if(!nutat)
		return
	if(flash)
		eject_flash(user)
	if(ismob(user))
		user.transferItemToLoc(nutat, src)
		user.show_message(span_notice("You insert [nutat]."))
	else
		nutat.forceMove(src)
	flash = nutat
	playsound(get_turf(src), 'sound/machines/click.ogg', 50, 1)

/obj/item/tattoo_gun/pre_attack(mob/living/carbon/human/victim, mob/living/user, params)
	. = ..()
	return prepare_engraving_skin(victim, user)

/obj/item/tattoo_gun/proc/prepare_engraving_skin(mob/living/carbon/human/victim, mob/living/user)
	if(engraving)
		user.show_message(span_alert("You're already stabbing someone!"))
		return
	if(!ishuman(victim))
		user.show_message(span_alert("They can't be tattooed (yet)!"))
		return
	if(!ismob(user))
		user.show_message(span_phobia("You don't exist!"))
		return
	if(!in_range(user, victim))
		user.show_message(span_alert("They're too far away!"))
		return // we'll have tattoo rifles, some day...
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		user.show_message(span_alert("You can't use this like that!"))
		return
	if(user.incapacitated())
		user.show_message(span_alert("You're incapacitated!"))
		return
	var/put_it_there = check_zone(user.zone_selected)
	if(!LAZYLEN(GLOB.tattoo_locations[put_it_there])) // just in case
		user.show_message(span_alert("That's... what even is that? [span_phobia("yeah this is probably a bug")]"))
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(put_it_there)
	if(!istype(chunk))
		user.show_message(span_alert("[victim] doesn't have one of those!"))
		return // we dont decorate phantom limbs in THIS parlor
	if(!istype(flash))
		try_remove_tattoo(victim, user, put_it_there, chunk)
		return
	var/list/places_to_put_it = list()
	for(var/key in GLOB.tattoo_locations[put_it_there])
		if(GLOB.tattoo_locations[put_it_there][key] == TRUE)
			places_to_put_it += key
	if(!LAZYLEN(places_to_put_it))
		user.show_message(span_alert("Nothing there?!"))
		return
	var/tat_loc = input(user, "Where do you want to put the tattoo?", "Pick a spot!") as null|anything in places_to_put_it
	if(!tat_loc)
		user.show_message(span_alert("Never mind!"))
		return
	if(tat_loc in chunk.tattoos) // they got one there lol
		user.show_message(span_alert("There isn't enough room on [victim]'s [lowertext(tat_loc)] to fully complete your vision!"))
		return
	// cool, get stabbing
	engraving = TRUE
	make_noises_and_pain(victim, user, tat_loc, put_it_there)
	engrave_skin(victim, user, tat_loc, put_it_there)
	soundloop.start()
	return STOP_ATTACK_PROC_CHAIN // dont hurt them, we want to hurt em

/obj/item/tattoo_gun/proc/engrave_skin(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	if(!ishuman(victim))
		user.show_message(span_alert("No longer exists, probably!"))
		abort()
		return
	if(!ismob(user))
		user?.show_message(span_phobia("You do not exist!"))
		abort()
		return
	if(!istype(flash))
		user.show_message(span_alert("You popped out the template!"))
		abort()
		return
	if(!in_range(user, victim))
		user.show_message(span_alert("They ran off!"))
		abort()
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		user.show_message(span_alert("You can't seem to use this right now!"))
		abort()
		return
	if(user.incapacitated())
		user.show_message(span_alert("You're incapacitated!"))
		abort()
		return
	if(!do_mob(user, victim, time_per_operation, allow_movement = TRUE)) // tattooing on the GO!
		user.visible_message(span_alert("[user] messes up, their work disappearing instantly somehow."),span_alert("You mess up! Good thing jacked up tattoos arent implemented yet."))
		abort()
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(part)
	if(!istype(chunk))
		user.show_message(span_alert("[victim] no longer has the part you're working on!"))
		return // we dont decorate phantom limbs in THIS parlor
	if(tat_loc in chunk.tattoos) // they got one there lol
		user.show_message(span_alert("[victim] suddenly has a tattoo on [victim.p_their()] [lowertext(tat_loc)], now there's no room for you! Great."))
		return
	if(operation_counter++ >= operations_to_complete)
		finish(victim, user, tat_loc, part)
		return TRUE
	engrave_skin(victim, user, tat_loc, part)

/obj/item/tattoo_gun/proc/abort(mob/living/carbon/human/victim, mob/living/user)
	engraving = FALSE
	operation_counter = 1
	soundloop.stop()

/obj/item/tattoo_gun/proc/finish(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	abort() // job successfully failed~
	if(!flash)
		user.show_message(span_alert("You popped out the template!"))
		return
	var/obj/item/bodypart/pretty_part = victim.get_bodypart(part)
	if(!pretty_part)
		user.show_message(span_alert("[victim] no longer has the part you're working on!"))
		return // we dont decorate phantom limbs in THIS parlor
	if(!pretty_part.add_tattoo(flash.loaded_tat, tat_loc))
		user.show_message(span_alert("You couldn't actually tattoo [victim]'s [lowertext(tat_loc)] for some reason!"))
		return
	if(!flash.use_charge())
		eject_flash(TRUE)
	user.visible_message(span_notice("[user] finishes up [user.p_their()] masterpiece on [victim]'s [lowertext(tat_loc)]!"))
	playsound(get_turf(src), 'sound/machines/ding.ogg', 50, 1)

/obj/item/tattoo_gun/proc/make_noises_and_pain(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	if(!istype(victim))
		abort()
		return
	if(!istype(user))
		abort()
		return
	if(!engraving)
		abort()
		return // we done
	if(!in_range(victim, user)) // safety check!
		abort()
		return
	var/obj/item/bodypart/owie = victim.get_bodypart(part)
	if(!owie)
		abort()
		return // we dont decorate phantom limbs in THIS parlor
	var/next_time = 1 SECONDS
	var/scream_prob = 50
	var/brute_d = rand(1,30) * 0.1
	var/bleed_d = brute_d * 1.35
	var/stamina_d = bleed_d * 2
	switch(rand(1,10)) // random sound
		if(1 to 2)
			playsound(get_turf(src), 'sound/weapons/circsawhit.ogg', 50, 1)
			next_time = 0.5 SECONDS
			user.visible_message(span_notice("[user] zaps a long line into [victim]'s [lowertext(tat_loc)]."))
		if(2 to 3)
			playsound(get_turf(src), 'sound/machines/mixer.ogg', 50, 1)
			next_time = 0.7 SECONDS
			user.visible_message(span_notice("[user] buzzes a nice bold mark into [victim]'s [lowertext(tat_loc)]."))
		if(4)
			playsound(get_turf(src), 'sound/machines/juicer.ogg', 50, 1)
			next_time = 2 SECONDS
			brute_d *= 2
			bleed_d *= 4
			stamina_d *= 2
			scream_prob = 80
			user.visible_message(span_notice("[user] adds a bunch of cool shading to [victim]'s [lowertext(tat_loc)]."))
		if(5)
			playsound(get_turf(src), 'sound/weapons/chainsawhit.ogg', 50, 1)
			next_time = 1.5 SECONDS
			brute_d *= 3
			bleed_d *= 3
			stamina_d *= 3
			scream_prob = 80
			user.visible_message(span_notice("[user] runs the needles over a patch of [victim]'s [lowertext(tat_loc)] several times."))
		if(6)
			playsound(get_turf(src), 'sound/weapons/handcuffs.ogg', 50, 1)
			next_time = 0.5 SECONDS
			user.visible_message(span_notice("[user] pokes a dot on [victim]'s flesh."))
		if(7 to 8)
			playsound(get_turf(src), 'sound/weapons/drill.ogg', 50, 1)
			next_time = 0.7 SECONDS
			user.visible_message(span_notice("[user] dig in <i>reaaal</i> deep into [victim]'s [lowertext(tat_loc)]."))
		if(9 to 10)
			playsound(get_turf(src), 'sound/weapons/fleshtear_1.ogg', 50, 1)
			next_time = 0.5 SECONDS
			user.visible_message(span_notice("[user] zips a quick mark into [victim]'s [lowertext(tat_loc)]."))
	if(prob(scream_prob))
		victim.emote("scream")
	owie.receive_damage(brute = owie.brute_dam < 30 ? brute_d : 0, stamina = stamina_d, wound_bonus = bleed_d, sharpness = SHARP_EDGED, damage_coverings = FALSE)
	if(engraving)
		addtimer(CALLBACK(src,PROC_REF(make_noises_and_pain), victim, user, tat_loc, part), next_time)

/obj/item/tattoo_gun/proc/try_remove_tattoo(mob/living/carbon/human/victim, mob/living/user, bodyzone, obj/item/bodypart/part)
	if(!istype(victim) || !istype(user))
		return
	if(isnull(bodyzone) || !istype(part))
		return
	//find tattoos
	var/list/tats = list()
	for(var/tatspot in GLOB.tattoo_locations[bodyzone])
		if(!isnull(part.tattoos[tatspot]))
			var/datum/tattoo/tat = part.tattoos[tatspot]
			tats[tatspot] = tat.name
	if(!tats.len)
		to_chat(user, span_alert("They don't have any tattoos there!"))
		to_chat(victim, span_alert("[user.name] fails to remove a tattoo from your [part.name]!"))

	//pick one to remove
	var/choice = input(user, "Which tattoo do you want to remove?", "Pick a tattoo!") as null|anything in tats
	//attempt to remove it
	playsound(get_turf(src), 'sound/weapons/drill.ogg', 50, 1)
	if(do_after(user,50,target = victim))
		//removal successful
		part.remove_tattoo(part.tattoos[choice],choice)
		if(victim.client?.prefs)
			victim.client.prefs.permanent_tattoos = victim.format_tattoos()
			victim.client.prefs.save_character()
		playsound(get_turf(src), 'sound/weapons/circsawhit.ogg', 50, 1)
		if(prob(60))
			victim.emote("scream")
		var/removaldam = rand(1,20)
		part.receive_damage(brute = part.brute_dam < 30 ? removaldam : 0, stamina = removaldam, wound_bonus = removaldam, sharpness = SHARP_EDGED, damage_coverings = FALSE)
		to_chat(user, span_alert("You successfully remove the [tats[choice]]."))
		to_chat(victim, span_alert("Your [tats[choice]] was successfully removed."))
	else
		to_chat(user, span_alert("You fail to remove a tattoo from [victim.name]'s [part.name]!"))
		to_chat(victim, span_alert("[user.name] fails to remove a tattoo from your [part.name]!"))


/obj/item/storage/backpack/debug_tattoo
	name = "Bag of Gunstuff 4 tattoos"
	desc = "Cool shit for testing tattoos!"

/obj/item/storage/backpack/debug_tattoo/PopulateContents()
	. = ..()
	new /obj/item/tattoo_gun(src)
	new /obj/item/tattoo_gun(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank/temporary(src)
	new /obj/item/tattoo_holder/blank/temporary(src)
	new /obj/item/tattoo_holder/biker(src)
	new /obj/item/tattoo_holder/biker(src)

/obj/item/storage/box/tattoo_kit
	name = "tattoo starter kit"
	desc = "Everything you need as an aspiring skin artist!"

/obj/item/storage/box/tattoo_kit/PopulateContents()
	. = ..()
	new /obj/item/tattoo_gun(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank(src)
	new /obj/item/tattoo_holder/blank/temporary(src)
	new /obj/item/tattoo_holder/blank/temporary(src)









