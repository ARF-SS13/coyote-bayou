/* 
 * Tattoos! 
 */
// Mutable appearances are children of images, just so you know. just a fun fact

#define TATTOO_CUSTOMIZE_NAME (1<<0)
#define TATTOO_CUSTOMIZE_DESC (1<<1)
#define TATTOO_CUSTOMIZE_EXTRA (1<<3)
#define TATTOO_CUSTOMIZE_ALL TATTOO_CUSTOMIZE_NAME | TATTOO_CUSTOMIZE_DESC | TATTOO_CUSTOMIZE_EXTRA
#define TATTOO_NAME "Name"
#define TATTOO_DESC "Desc"
#define TATTOO_EXTRA "Extra Details"

#define TATTOO_NOT_FADED 1
#define TATTOO_KINDA_FADED 2
#define TATTOO_VERY_FADED 3

#define UNLIMITED_TATTOO -1

#define TATTOO_TRAMP_STAMP "Sacrum"
#define TATTOO_WOMB_TATTOO "Upper Groin" // river tat
#define TATTOO_LEFT_ASS "Left Buttock"
#define TATTOO_RIGHT_ASS "Right Buttock"
#define TATTOO_LEFT_BOOB "Left Breast"
#define TATTOO_RIGHT_BOOB "Right Breast"
#define TATTOO_CHEST "Chest" // totally different from boob
#define TATTOO_BELLY "Abdomen" // monkey bent over, belly button in the right (wrong) place
#define TATTOO_UPPER_BACK "Upper Back"
#define TATTOO_LOWER_BACK "Lower Back"
#define TATTOO_RIGHT_UPPER_ARM "Right Shoulder"
#define TATTOO_RIGHT_LOWER_ARM "Right Forearm"
#define TATTOO_RIGHT_HAND "Right Hand"
#define TATTOO_LEFT_UPPER_ARM "Left Shoulder"
#define TATTOO_LEFT_LOWER_ARM "Left Forearm"
#define TATTOO_LEFT_HAND "Left Hand"
#define TATTOO_RIGHT_UPPER_LEG "Right Hip"
#define TATTOO_RIGHT_LOWER_LEG "Right Calf"
#define TATTOO_RIGHT_FOOT "Right Foot"
#define TATTOO_LEFT_UPPER_LEG "Left Hip"
#define TATTOO_LEFT_LOWER_LEG "Left Calf"
#define TATTOO_LEFT_FOOT "Left Foot"
#define TATTOO_LEFT_CHEEK "Left Cheek"
#define TATTOO_RIGHT_CHEEK "Right Cheek"
#define TATTOO_LEFT_EYE "Left Eyelid"
#define TATTOO_RIGHT_EYE "Right Eyelid"
#define TATTOO_FOREHEAD "Forehead" // somethign something guy with a tattoo'd forehead gonna get us all killed!

GLOBAL_LIST_INIT(tattoo_locations, list(
	BODY_ZONE_HEAD = list(
		TATTOO_LEFT_CHEEK,
		TATTOO_RIGHT_CHEEK,
		TATTOO_LEFT_EYE,
		TATTOO_RIGHT_EYE,
		TATTOO_FOREHEAD,
		),
	BODY_ZONE_CHEST = list(
		TATTOO_TRAMP_STAMP,
		TATTOO_WOMB_TATTOO,
		TATTOO_CHEST,
		TATTOO_BELLY,
		TATTOO_UPPER_BACK,
		TATTOO_LOWER_BACK,
		TATTOO_LEFT_BOOB,
		TATTOO_RIGHT_BOOB,
	),
	BODY_ZONE_L_ARM = list(
		TATTOO_LEFT_UPPER_ARM,
		TATTOO_LEFT_LOWER_ARM,
		TATTOO_LEFT_HAND,
	),
	BODY_ZONE_R_ARM = list(
		TATTOO_RIGHT_UPPER_ARM,
		TATTOO_RIGHT_LOWER_ARM,
		TATTOO_RIGHT_HAND,
	),
	BODY_ZONE_L_LEG = list(
		TATTOO_LEFT_UPPER_LEG,
		TATTOO_LEFT_LOWER_LEG,
		TATTOO_LEFT_ASS,
		TATTOO_LEFT_FOOT,
	),
	BODY_ZONE_R_LEG = list(
		TATTOO_RIGHT_UPPER_LEG,
		TATTOO_RIGHT_LOWER_LEG,
		TATTOO_RIGHT_ASS,
		TATTOO_RIGHT_FOOT,
	),
))

/datum/tattoo
	/// Name of the tat
	var/name
	/// Description of the tat, flavor text, etc. Make it start lowercased!
	var/desc
	/// Optional, access related to the tat
	var/list/tat_access = list()
	/// the owning limb
	var/datum/weakref/owner_limb
	/// Optional, extra desc stuff
	var/extra_desc
	/// Where on the body part is the tat?
	var/tat_location
	/// Is the tattoo somewhere really private? So you dont examine someone in power armor and find FOXYGRANDMA above their ass
	var/private = FALSE
	/// how faded is the tattoo? for temporary tats
	var/fadedness = TATTOO_NOT_FADED
	/// how long does the temporary tattoo last between fade cycles? total life will be around 3-4 times this. if null, its permanent
	var/fade_time

/datum/tattoo/New(obj/item/bodypart/owner, name_override, desc_override, extra_description, fade_override, datum/tattoo/cool_tat)
	. = ..()
	if(istype(owner))
		owner_limb = WEAKREF(owner)
	else if(isweakref(owner))
		owner_limb = owner
	if(istype(cool_tat))
		for(var/v in vars) // just dump them all in
			vars[v] = cool_tat.vars[v]
	if(!isnull(name_override))
		name = name_override
	if(!isnull(desc_override))
		desc = desc_override
	if(!isnull(extra_description))
		extra_desc = extra_description
	if(!isnull(fade_override))
		fade_time = fade_override
	if(fade_time)
		addtimer(CALLBACK(src, .proc/fade_tattoo), fade_time)

/datum/tattoo/Destroy(force, ...)
	if(isweakref(owner_limb))
		var/obj/item/bodypart/owner/wiggle = owner_limb.resolve()
		wiggle.tattoos[tat_location] -= src
	. = ..()

/datum/tattoo/proc/fade_tattoo()
	if(fadedness++ > TATTOO_VERY_FADED)
		qdel(src)
		return
	addtimer(CALLBACK(src, .proc/fade_tattoo), fade_time)

/datum/tattoo/proc/get_desc(mob/limbhaver)
	if(!owner_limb)
		return
	var/obj/item/bodypart/meatchunk = owner_limb.resolve()
	var/list/msg_out = list()
	if(tat_location)
		msg_out += "You see \a [name] [location2words(limbhaver)]"
	else
		msg_out += "You see \a [name] on [ismob(limbhaver) ? "[limbhaver.p_their()]" : "the"] [meatchunk.name]."
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
	return jointext(msg_out, "<br>")

/datum/tattoo/proc/location2words(mob/person)
	switch(tat_location)
		if(TATTOO_TRAMP_STAMP)
			var/taild
			if(ishuman(person))
				var/mob/living/carbon/human/tailie = person
				taild = tailie.getorganslot(ORGAN_SLOT_TAIL)
			return "positioned over [ismob(person) ? "[person.p_their()]" : "the"] [taild ? "tail" : "buttcrack"]."
		if(TATTOO_WOMB_TATTOO)
			return "positioned over [ismob(person) ? "[person.p_their()]" : "the"] lower groin."
		if(TATTOO_LEFT_ASS)
			return "situated on [ismob(person) ? "[person.p_their()]" : "the"] left buttcheek."
		if(TATTOO_RIGHT_ASS)
			return "situated on [ismob(person) ? "[person.p_their()]" : "the"] right buttcheek."
		if(TATTOO_LEFT_BOOB)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] left [prob(1) ? "boobie" : "breast"]."
		if(TATTOO_RIGHT_BOOB)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] right [prob(1) ? "boobie" : "breast"]."
		if(TATTOO_CHEST)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] chest."
		if(TATTOO_BELLY)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] [pick("belly", "gut", "tummy")]."
		if(TATTOO_UPPER_BACK)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] upper back."
		if(TATTOO_LOWER_BACK)
			return "printed across [ismob(person) ? "[person.p_their()]" : "the"] lower back."
		if(TATTOO_RIGHT_UPPER_ARM)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] right upper arm."
		if(TATTOO_RIGHT_LOWER_ARM)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] right lower arm."
		if(TATTOO_RIGHT_HAND)
			return "situated on [ismob(person) ? "[person.p_their()]" : "the"] right hand."
		if(TATTOO_LEFT_UPPER_ARM)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] left upper arm."
		if(TATTOO_LEFT_LOWER_ARM)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] left lower arm."
		if(TATTOO_LEFT_HAND)
			return "situated across [ismob(person) ? "[person.p_their()]" : "the"] left hand."
		if(TATTOO_RIGHT_UPPER_LEG)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] right upper leg."
		if(TATTOO_RIGHT_LOWER_LEG)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] right lower leg."
		if(TATTOO_RIGHT_FOOT)
			return "planted on [ismob(person) ? "[person.p_their()]" : "the"] right foot."
		if(TATTOO_LEFT_UPPER_LEG)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] left upper leg."
		if(TATTOO_LEFT_LOWER_LEG)
			return "plastered across [ismob(person) ? "[person.p_their()]" : "the"] left lower leg."
		if(TATTOO_LEFT_FOOT)
			return "planted on [ismob(person) ? "[person.p_their()]" : "the"] left foot."
		if(TATTOO_LEFT_CHEEK)
			return "slapped on [ismob(person) ? "[person.p_their()]" : "the"] left cheek."
		if(TATTOO_RIGHT_CHEEK)
			return "slapped on [ismob(person) ? "[person.p_their()]" : "the"] right cheek."
		if(TATTOO_LEFT_EYE)
			return "printed around [ismob(person) ? "[person.p_their()]" : "the"] left eye."
		if(TATTOO_RIGHT_EYE)
			return "printed around [ismob(person) ? "[person.p_their()]" : "the"] right eye."
		if(TATTOO_FOREHEAD)
			return "drawn across [ismob(person) ? "[person.p_their()]" : "the"] forehead."

/// Generic tattoo for overwriting with other stuff
/datum/tattoo/blank
	name = "tattoo"
	desc = "some generic tattoo-shaped tattoo. Nothing fancy, just a little ink."

/// Generic temp tattoo for overwriting with other stuff
/datum/tattoo/blank/temporary
	name = "temporary tattoo"
	desc = "some generic temporary tattoo-shaped tattoo. Nothing fancy, just a little ink."
	fade_time = 30 SECONDS

/datum/tattoo/biker
	name = "Hell's Nomads insignia"
	desc = "a bitchin' patch of skinart featuring a shitload of flames wrapped around a pair of flaming brahmin \
			skulls, with their horns done up like handlebars on a motorcycle, bordered by guns and knives and other \
			stuff a teenage boy would find badass."
	tat_access = list(ACCESS_BIKER)

/// A tattoo *thing*
/obj/item/tattoo_holder
	name = "tattoo template"
	desc = "A little card loaded with a tattoo style."
	icon = 'icons/obj/card.dmi'
	icon_state = "data_1"
	/// our tattoo template
	var/datum/tattoo/loaded_tat = /datum/tattoo/blank
	/// Lets you apply the thing itself to a limb. Mostly for temporary tattoos
	var/customizableness = TATTOO_CUSTOMIZE_ALL
	/// Makes its name and desc resemble the loaded tat
	var/inherit_tat_name_n_desc = FALSE
	/// can be applied just by using it on yourself
	var/self_apply = FALSE
	var/custom_name
	var/custom_desc
	var/custom_extra
	/// how many times left can this thing be used? UNLIMITED_TATTOO for infinite uses
	var/uses_left = UNLIMITED_TATTOO

/obj/item/tattoo_holder/Initialize()
	. = ..()
	if(inherit_tat_name_n_desc && ispath(loaded_tat))
		name = initial(loaded_tat.name)
		desc = "A little card loaded with [initial(loaded_tat.desc)]"

/obj/item/tattoo_holder/Destroy()
	if(istype(loaded_tat))
		QDEL_NULL(loaded_tat)
	if(loaded_tat)
		loaded_tat = null
	. = ..()

/obj/item/tattoo_holder/attack_self(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return FALSE
	change_stuff(user)

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
	var/list/customization = list()
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_NAME))
		customization += TATTOO_NAME
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_DESC))
		customization += TATTOO_DESC
	if(CHECK_BITFIELD(customizableness, TATTOO_CUSTOMIZE_EXTRA))
		customization += TATTOO_EXTRA

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
			var/newname = stripped_input(user, "Name the tattoo this will make! Format will be \"You see a newname on Ladbro's left leg\"", "Type a name!", custom_name ? custom_name : initial(loaded_tat.name))
			if(newname)
				custom_name = newname
				user.show_message(span_notice("You label the tattoo as \"[newname]\"."))
		if(TATTOO_DESC)
			var/newdesc = stripped_input(user, "Describe your tattoo! Format will be \"It features newdescription.\"", "Type a description!", custom_desc ? custom_desc : initial(loaded_tat.desc))
			if(newdesc)
				custom_desc = newdesc
				user.show_message(span_notice("You customize the tattoo as \"[newdesc]\"."))
		if(TATTOO_EXTRA)
			var/newextra = stripped_input(user, "Add on some extra details, like someone's name, serial number, their turn-offs, anything that'll go good after the description!", "Type some stuff!", custom_extra ? custom_extra : null)
			if(newextra)
				custom_name = newextra
				user.show_message(span_notice("You add \"[newextra]\" to the tattoo."))

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
	desc = "Some kind of artistic torture device designed to stab colors into someone's skin. The needles are long \
			enough to make your work visible, no matter how furry your victim is."
	icon = 'icons/obj/guns/gun_parts.dmi'
	icon_state = "reciever_pistol"
	/// The tattoo template to engrave
	var/obj/item/tattoo_holder/flash
	/// does it start loaded with its flash?
	var/start_loaded = FALSE
	/// How long do they have to suffer per operation?
	var/time_per_operation = 2 SECONDS
	/// how many times do we have to mangle this guy for the tat to stick?
	var/operations_to_complete = 6
	/// How many times did we do a thing this cycle?
	var/operation_counter = 0
	/// is it doing something?
	var/engraving = FALSE

/obj/item/tattoo_gun/Destroy()
	eject_flash(delet = TRUE)
	. = ..()

/obj/item/tattoo_gun/attack_self(mob/user)
	eject_flash(user, FALSE)

/obj/item/tattoo_gun/proc/eject_flash(mob/user, delet)
	if(!flash)
		return
	if(delet)
		QDEL_NULL(flash)
		return
	if(ismob(user))
		user.put_in_hands(flash)
	else
		flash.forceMove(get_turf(src))
	flash = null

/obj/item/tattoo_gun/pre_attack(mob/living/carbon/human/victim, mob/living/user, params)
	. = ..()
	return prepare_engraving_skin(victim, user)

/obj/item/tattoo_gun/proc/prepare_engraving_skin(mob/living/carbon/human/victim, mob/living/user)
	if(engraving)
		return
	if(!ishuman(victim))
		return
	if(!ismob(user))
		return
	if(!istype(flash))
		return
	if(!in_range(user, victim))
		return // we'll have tattoo rifles, some day...
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(user.incapacitated())
		return
	var/put_it_there = check_zone(user.zone_selected)
	if(!LAZYLEN(GLOB.tattoo_locations[put_it_there])) // just in case
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(put_it_there)
	if(!istype(chunk))
		return // we dont decorate phantom limbs in THIS parlor
	var/tat_loc = input(user, "Customize the tattoo!", "Pick a category!") as null|anything in GLOB.tattoo_locations[put_it_there]
	if(!tat_loc)
		return
	if(tat_loc in chunk.tattoos) // they got one there lol
		return
	// cool, get stabbing
	make_noises_and_pain(victim, user, put_it_there)
	engrave_skin(victim, user, tat_loc, put_it_there)
	return STOP_ATTACK_PROC_CHAIN // dont hurt them, we want to hurt em

/obj/item/tattoo_gun/proc/engrave_skin(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	engraving = TRUE
	if(!ishuman(victim))
		abort(victim, user)
		return
	if(!ismob(user))
		abort(victim, user)
		return
	if(!istype(flash))
		abort(victim, user)
		return
	if(!in_range(user, victim))
		abort(victim, user)
		return
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		abort(victim, user)
		return
	if(user.incapacitated())
		abort(victim, user)
		return
	if(!do_mob(user, victim, time_per_operation, allow_movement = TRUE)) // tattooing on the GO!
		abort(victim, user)
		return
	var/obj/item/bodypart/chunk = victim.get_bodypart(part)
	if(!istype(chunk))
		return // we dont decorate phantom limbs in THIS parlor
	if(tat_loc in chunk.tattoos) // they got one there lol
		return
	if(operation_counter++ >= operations_to_complete)
		finish(victim, user, tat_loc, part)
		return TRUE
	engrave_skin(victim, user, tat_loc, part)

/obj/item/tattoo_gun/proc/abort(mob/living/carbon/human/victim, mob/living/user)
	engraving = FALSE
	operation_counter = 0

/obj/item/tattoo_gun/proc/finish(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	abort(victim, user) // job successfully failed~
	var/obj/item/bodypart/pretty_part = victim.get_bodypart(part)
	if(!pretty_part)
		return // we dont decorate phantom limbs in THIS parlor
	if(!pretty_part.add_tattoo(flash, tat_loc))
		return
	if(!flash.use_charge())
		eject_flash(TRUE)

/obj/item/tattoo_gun/proc/make_noises_and_pain(mob/living/carbon/human/victim, mob/living/user, tat_loc, part)
	if(!istype(victim))
		return
	if(!engraving)
		return // we done
	var/obj/item/bodypart/owie = victim.get_bodypart(part)
	if(!pretty_part)
		return // we dont decorate phantom limbs in THIS parlor
	var/next_time = 1 SECONDS
	var/brute_d = rand(1,30) * 0.1
	var/bleed_d = brute_d * 1.1
	var/stamina_d = bleed_d * 2
	switch(rand(1,10)) // random sound
		if(1 to 3)
			playsound(get_turf(src), 'sound/weapons/circsawhit.ogg', 50, 1)
			next_time = 1 SECONDS
		if(4 to 5)
			playsound(get_turf(src), 'sound/weapons/chainsawhit.ogg', 50, 1)
			next_time = 3 SECONDS
			brute_d *= 3
			bleed_d *= 3
			stamina_d *= 3
		if(5 to 6)
			playsound(get_turf(src), 'sound/weapons/handcuffs.ogg', 50, 1)
			next_time = 1 SECONDS
		if(7 to 8)
			playsound(get_turf(src), 'sound/weapons/drill.ogg', 50, 1)
			next_time = 1 SECONDS
		if(9 to 10)
			playsound(get_turf(src), 'sound/weapons/bladeslice.ogg', 50, 1)
			next_time = 1 SECONDS
	if(prob(50))
		victim.emote("scream")
	if(owie.brute_dam < 30)
	owie.receive_damage(brute = owie.brute_dam < 30 ? brute_d : 0, stamina = stamina_d, wound_bonus = bleed_d, sharpness = SHARP_EDGED, damage_coverings = FALSE)
	addtimer(CALLBACK(GLOB, .proc/make_noises_and_pain, victim, user, tat_loc, part), next_time)










