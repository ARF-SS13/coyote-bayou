#define PERSONALITY_TRAIT(trait, emoji, visibleto...) trait = list(emoji, ##visibleto)
#define THE_EMOJI 1
//#define VISIBLE_TO 2

/// Format: PERSONALITY_TRAIT(trait, emoji, traits that can see this trait -- can be multiple, put commas in between)
/// like this: PERSONALITY_TRAIT(TRAIT_ERPBOYKISSER, 🍆, TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER)
GLOBAL_LIST_INIT(personality_quirks, list(
	PERSONALITY_TRAIT(TRAIT_IN_HEAT,          span_love("😘"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPBOYKISSER,     span_love("🍆"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPGIRLKISSER,    span_love("🍑"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPANYKISSER,     span_love("💋"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPQUICKY,        span_love("⏰"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPLONGTERM,      span_love("📅"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPBOTTOM,        span_love("😔"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPTOP,           span_love("😎"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPSWITCH,        span_love("☯"), TRAIT_HEAT_DETECT),
	PERSONALITY_TRAIT(TRAIT_ERPFLIRTY,        span_love("🌹"), TRAIT_HEAT_DETECT),

	PERSONALITY_TRAIT(TRAIT_RPLONGTERM,       span_greenannounce("📅"), TRAIT_RPFOCUSED),
	PERSONALITY_TRAIT(TRAIT_RPSHORTTERM,      span_greenannounce("⏰"), TRAIT_RPFOCUSED),
	PERSONALITY_TRAIT(TRAIT_RPSERIOUS,        span_greenannounce("👑"), TRAIT_RPFOCUSED),
	PERSONALITY_TRAIT(TRAIT_RPLIGHT,          span_greenannounce("🤡"), TRAIT_RPFOCUSED),
	PERSONALITY_TRAIT(TRAIT_RPSCRUBS,         span_greenannounce("⛑"), TRAIT_RPFOCUSED),
	PERSONALITY_TRAIT(TRAIT_RPDAYSOFOURLIVES, span_greenannounce("💀"), TRAIT_RPFOCUSED),
	
	PERSONALITY_TRAIT(TRAIT_PVEFOC,           span_danger("✌️"), TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_PVPFOC,           span_danger("🔥"), TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_OOCAPP,           span_danger("☎️"), TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER), //It needs all this, otherwise people wont see it
	PERSONALITY_TRAIT(TRAIT_COMBATSWITCH,     span_danger("🌎"), TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_SHY,              span_danger("😔"), TRAIT_HEAT_DETECT, TRAIT_RPFOCUSED, TRAIT_ADV_SEEKER),

	PERSONALITY_TRAIT(TRAIT_ADV_ER,           span_binarysay("♞"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_LFG,          span_binarysay("💑"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_SOLO,         span_binarysay("😑"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_GUNNER,       span_binarysay("🔫"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_FIGHTER,      span_binarysay("⚔️"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_TANK,         span_binarysay("🛡"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_BRUISER,      span_binarysay("🏏"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_ROGUE,        span_binarysay("🔓"), TRAIT_ADV_SEEKER),
	PERSONALITY_TRAIT(TRAIT_ADV_HEALER,       span_binarysay("🏥"), TRAIT_ADV_SEEKER)))

/// The description that'll be sent out
/// Dont include the emoji
/// Do include the spans
/// Use span defines like span_warning("words") please, they make it look nice
/// Format: THE_TRAIT = "description"
GLOBAL_LIST_INIT(personalitytrait2description, list(
	TRAIT_IN_HEAT = 				 		  span_love("They are looking for a good time, you should check their OOC Notes."),
	TRAIT_ERPBOYKISSER = 			 		  span_love("They look like they prefer guys."),
	TRAIT_ERPGIRLKISSER =			 		  span_love("They look like they prefer girls."),
	TRAIT_ERPANYKISSER = 			 		  span_love("They look like they'd kiss boys OR girls."),
	TRAIT_ERPQUICKY =						  span_love("They look like they're looking for flings, not long term partners."),
	TRAIT_ERPLONGTERM = 			 		  span_love("They look like they're looking for long term sexual partners."),
	TRAIT_ERPBOTTOM = 						  span_love("They look like a bottom, you'll probably need to be the one to approach."),
	TRAIT_ERPTOP = 							  span_love("They look like a top, maybe if you wiggle right they'll approach you first."),
	TRAIT_ERPSWITCH = 						  span_love("They look like a switch, see what works."),
	TRAIT_ERPFLIRTY = 						  span_love("They look flirty, or like being flirty with them might be very effective.  Check out the *help command for *flirts."),
	TRAIT_RPLONGTERM = 				 span_greenannounce("They are looking for RP that is long term focused. Perhaps contact them via LOOC to work that out together?"),
	TRAIT_RPSHORTTERM = 			 span_greenannounce("They are looking for RP that is short term focused. This generally means only things in the current round."),
	TRAIT_RPSERIOUS =				 span_greenannounce("They are looking for RP that is relatively serious, if you to want to take the setting seriously maybe you should chatter at them via LOOC?"),
	TRAIT_RPLIGHT = 				 span_greenannounce("They are looking for RP that is relatively light, if you're looking for a silly distraction RP maybe you should approach."),
	TRAIT_RPSCRUBS = 				 span_greenannounce("They are looking for RP that is medically inclined. Think House, ER, or maybe even Scrubs."),
	TRAIT_RPDAYSOFOURLIVES =		 span_greenannounce("They are looking for RP that is dramatic, maybe even a bit over the top. Think soap opera."),
	TRAIT_PVEFOC =							span_danger("This player prefers PVE scenarios. Don't force them into PVP"),
	TRAIT_PVPFOC =							span_danger("This player prefers PVP scenarios. "),
	TRAIT_OOCAPP =							span_danger("This players prefers to be approached over L/OOC."),
	TRAIT_COMBATSWITCH =					span_danger("This player is happy to do PVP or PVE gameplay"),
	TRAIT_SHY =								span_danger("They are a bit shy (OOCly & probably ICly too), but is trying to make people know they want to be engaged with. Be a darling and maybe interact with them some if you have time?"),
	TRAIT_ADV_ER = 					 	 span_binarysay("They look like the adventuring sort."),
	TRAIT_ADV_LFG =					 	 span_binarysay("They look like they'd like to have someone adventure with them, maybe you should ask?"),
	TRAIT_ADV_SOLO = 				 	 span_binarysay("They don't look like they'd want anyone to adventure with right now."),
	TRAIT_ADV_GUNNER =				 	 span_binarysay("They look like they know their way around ranged combat."),
	TRAIT_ADV_FIGHTER = 			 	 span_binarysay("A real fighter of all time, they look like they can use a blade"),
	TRAIT_ADV_TANK =				 	 span_binarysay("A shield wielding wall of an adventurer. They look like they could hold back a tsunami."),
	TRAIT_ADV_BRUISER =				 	 span_binarysay("A real bruiser of a waster, the way they hold a two handed weapon speaks volumes about melons being obliterated."),
	TRAIT_ADV_ROGUE = 				 	 span_binarysay("This person looks insanely useful at things that might not be JUST killing monsters. Maybe see if they have a lockpick on hand?"),
	TRAIT_ADV_HEALER = 				 	 span_binarysay("This person looks like they know how to keep your bits glued together and your blood inside you. How nice."),

	// and so onh
))

/mob/living/carbon/human/examine(mob/user)
//this is very slightly better than it was because you can use it more places. still can't do \his[src] though.
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()
	var/obscure_name

	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	. = list("<span class='info'>*---------*\nThis is <EM>[!obscure_name ? name : "Unknown"]</EM>! [t_He] [t_is] a [dna.custom_species ? dna.custom_species : dna.species.name]!")

	var/imagelink = SSchat.GetPicForMode(src, MODE_PROFILE_PIC)
	if (imagelink)
		. += "<a href='?src=[REF(src)];enlargeImage=1'><img src='[imagelink]' width='125' height='auto' max-height='300'></a>"


	var/vampDesc = ReturnVampExamine(user) // Vamps recognize the names of other vamps.
	var/vassDesc = ReturnVassalExamine(user) // Vassals recognize each other's marks.
	if (vampDesc != "") // If we don't do it this way, we add a blank space to the string...something to do with this -->  . += ""
		. += vampDesc
	if (vassDesc != "")
		. += vassDesc

	var/list/obscured = check_obscured_slots()
	var/skipface = !HAS_TRAIT(src, TRAIT_NOHIDEFACE) && ((wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE)))

	. += "[t_He] [t_is] a [dna.custom_species ? dna.custom_species : dna.species.name]!"

	//uniform
	if(w_uniform && !(SLOT_W_UNIFORM in obscured))
		//accessory
		var/accessory_msg
		if(istype(w_uniform, /obj/item/clothing/under))
			var/obj/item/clothing/under/U = w_uniform
			if(U.attached_accessory && !(U.attached_accessory.flags_inv & HIDEACCESSORY) && !(U.flags_inv & HIDEACCESSORY))
				accessory_msg += " with [icon2html(U.attached_accessory, user)] \a [U.attached_accessory]"
			if(U.attached_accessory_b && !(U.attached_accessory_b.flags_inv & HIDEACCESSORY) && !(U.flags_inv & HIDEACCESSORY))
				accessory_msg += ", [icon2html(U.attached_accessory_b, user)] \a [U.attached_accessory_b]"
			if(U.attached_accessory_c && !(U.attached_accessory_c.flags_inv & HIDEACCESSORY) && !(U.flags_inv & HIDEACCESSORY))
				accessory_msg += ", [icon2html(U.attached_accessory_c, user)] \a [U.attached_accessory_c]"

		. += "[t_He] [t_is] wearing [w_uniform.get_examine_string(user)][accessory_msg]."
	//head
	if(head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head."
	//suit/armor
	if(wear_suit)
		. += "[t_He] [t_is] wearing [wear_suit.get_examine_string(user)]."
		//suit/armor storage
		if(s_store && !(SLOT_S_STORE in obscured))
			. += "[t_He] [t_is] carrying [s_store.get_examine_string(user)] on [t_his] [wear_suit.name]."
	//back
	if(back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	//Hands
	for(var/obj/item/I in held_items)
		if(!(I.item_flags & ABSTRACT))
			. += "[t_He] [t_is] holding [I.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(I))]."

	//gloves
	if(gloves && !(SLOT_GLOVES in obscured))
		. += "[t_He] [t_has] [gloves.get_examine_string(user)] on [t_his] hands."
	else if(length(blood_DNA))
		var/hand_number = get_num_arms(FALSE)
		if(hand_number)
			. += span_warning("[t_He] [t_has] [hand_number > 1 ? "" : "a"] blood-stained hand[hand_number > 1 ? "s" : ""]!")

	//handcuffed?
	if(handcuffed)
		if(istype(handcuffed, /obj/item/restraints/handcuffs/cable))
			. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] restrained with cable!")
		else
			. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!")

	//belt
	if(belt)
		. += "[t_He] [t_has] [belt.get_examine_string(user)] about [t_his] waist."

	//shoes
	if(shoes && !(SLOT_SHOES in obscured))
		. += "[t_He] [t_is] wearing [shoes.get_examine_string(user)] on [t_his] feet."

	//mask
	if(wear_mask && !(SLOT_MASK in obscured))
		. += "[t_He] [t_has] [wear_mask.get_examine_string(user)] on [t_his] face."

	if(wear_neck && !(SLOT_NECK in obscured))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)]"

	//eyes
	if(!(SLOT_GLASSES in obscured))
		if(glasses)
			. += "[t_He] [t_has] [glasses.get_examine_string(user)] covering [t_his] eyes."
		else if((left_eye_color == BLOODCULT_EYE || right_eye_color == BLOODCULT_EYE) && iscultist(src) && HAS_TRAIT(src, TRAIT_CULT_EYES))
			. += span_warning("<B>[t_His] eyes are glowing an unnatural red!</B>")
		else if(HAS_TRAIT(src, TRAIT_HIJACKER))
			var/obj/item/implant/hijack/H = user.getImplant(/obj/item/implant/hijack)
			if (H && !H.stealthmode && H.toggled)
				. += "<b><font color=orange>[t_His] eyes are flickering a bright yellow!</font></b>"
		else if(is_brainwashed(src)) //FO13 Change
			. += "<b><font color=red>[t_His] eyes have a far away and dazed look to them.</font></b>"

	//ears
	if(ears && !(SLOT_EARS in obscured))
		. += "[t_He] [t_has] [ears.get_examine_string(user)] on [t_his] ears."

	//ID
	if(wear_id)
		. += "[t_He] [t_is] wearing [wear_id.get_examine_string(user)]."

	//Status effects
	var/effects_exam = status_effect_examines()
	if(!isnull(effects_exam))
		. += effects_exam

	//CIT CHANGES START HERE - adds genital details to examine text
	if(LAZYLEN(internal_organs) && CHECK_BITFIELD(user.client?.prefs.cit_toggles, GENITAL_EXAMINE))
		for(var/obj/item/organ/genital/dicc in internal_organs)
			if(istype(dicc) && dicc.is_exposed())
				. += "[dicc.desc]"
	//END OF CIT CHANGES

	var/list/m8cup = list()
	if(lip_style && lip_color)
		m8cup += span_notice("[lip_color] lipstick")
	if(nail_style && nail_color)
		m8cup += span_notice("[nail_color] nail polish")
	if(LAZYLEN(m8cup))
		. += span_notice("[t_He] has [m8cup.Join(" and ")] applied.")

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			. += span_warning("<B>[t_He] [t_is] convulsing violently!</B>")
		if(200 to 300)
			. += span_warning("[t_He] [t_is] extremely jittery.")
		if(100 to 200)
			. += span_warning("[t_He] [t_is] twitching ever so slightly.")

	var/appears_dead = 0
	if(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
		appears_dead = 1
		if(hellbound)
			. += span_warning("[t_His] soul seems to have been ripped out of [t_his] body.  Revival is impossible.")
		var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
		if(key || !getorgan(/obj/item/organ/brain) || ghost?.can_reenter_corpse)
			. += span_binarysay("[t_He] [t_is] limp and unresponsive; there are no signs of life...")
		else
			. += span_binarysay("[t_He] [t_is] limp and unresponsive; there are no signs of life and [t_his] soul has departed...")

	if(get_bodypart(BODY_ZONE_HEAD) && !getorgan(/obj/item/organ/brain))
		. += span_binarysay("It appears that [t_his] brain is missing...")

	var/temp = getBruteLoss() //no need to calculate each of these twice

	var/list/msg = list()

	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.disabled)
			disabled += BP
		missing -= BP.body_zone
		for(var/obj/item/I in BP.embedded_objects)
			if(I.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] stuck to [t_his] [BP.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] \a [icon2html(I, user)] [I] embedded in [t_his] [BP.name]!</B>\n"
		for(var/i in BP.wounds)
			var/datum/wound/iter_wound = i
			msg += "[iter_wound.get_examine_description(user)]\n"
		switch(BP.bleed_dam)
			if(WOUND_BLEED_CLOSE_THRESHOLD to WOUND_BLEED_MODERATE_THRESHOLD)
				msg += "[t_His] [BP.name] looks a bit cut up!\n"
			if(WOUND_BLEED_MODERATE_THRESHOLD to WOUND_BLEED_SEVERE_THRESHOLD)
				msg += "<B>[t_His] [BP.name] looks torn up!</B>\n"
			if(WOUND_BLEED_SEVERE_THRESHOLD to WOUND_BLEED_CRITICAL_THRESHOLD)
				msg += "<B>[t_His] [BP.name] looks absolutely mangled!</B>\n"
			if(WOUND_BLEED_CRITICAL_THRESHOLD to INFINITY)
				msg += "<B>[t_His] [BP.name] looks like it'd been chewed on by a aethergiest!</B>\n"

		var/has_bleed_wounds = is_bleeding()
		if(istype(BP.current_gauze, /obj/item/stack/medical/gauze))
			msg += "[t_His] [BP.name] is coated with "
			var/bandaid_max_time = initial(BP.current_gauze.covering_lifespan)
			var/bandaid_time = BP.get_covering_timeleft(COVERING_BANDAGE, COVERING_TIME_TRUE)
			// how much life we have left in these bandages
			if(bandaid_time > bandaid_max_time * BANDAGE_GOODLIFE_DURATION)
				msg += "fresh "
			else if(bandaid_time > bandaid_max_time * BANDAGE_MIDLIFE_DURATION)
				msg += "slightly worn "
			else if(bandaid_time > bandaid_max_time * BANDAGE_ENDLIFE_DURATION)
				msg += "badly worn "
			else
				msg += "nearly ruined "
			msg += "[BP.current_gauze.name]"
			if(has_bleed_wounds)
				msg += span_warning(" covering a bleeding wound!\n")
			else
				msg += "!\n"

		if(istype(BP.current_suture, /obj/item/stack/medical/suture))
			msg += "[t_His] [BP.name] is stitched up with "
			var/bandaid_max_time = initial(BP.current_suture.covering_lifespan)
			var/bandaid_time = BP.get_covering_timeleft(COVERING_SUTURE, COVERING_TIME_TRUE)
			// how much life we have left in these bandages
			if(bandaid_time > bandaid_max_time * SUTURE_GOODLIFE_DURATION)
				msg += "sturdy "
			else if(bandaid_time > bandaid_max_time * SUTURE_MIDLIFE_DURATION)
				msg += "slightly frayed "
			else if(bandaid_time > bandaid_max_time * SUTURE_ENDLIFE_DURATION)
				msg += "badly frayed "
			else
				msg += "nearly popped "
			msg += "[BP.current_suture.name]"
			if(has_bleed_wounds)
				msg += span_warning(" covering a bleeding wound!\n")
			else
				msg += "!\n"

	for(var/X in disabled)
		var/obj/item/bodypart/BP = X
		var/damage_text
		if(BP.is_disabled() != BODYPART_DISABLED_WOUND) // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
			if(!(BP.get_damage(include_stamina = FALSE) >= BP.max_damage)) //we don't care if it's stamcritted
				damage_text = "limp and lifeless"
			else
				damage_text = (BP.brute_dam >= BP.burn_dam) ? BP.heavy_brute_msg : BP.heavy_burn_msg
			msg += "<B>[capitalize(t_his)] [BP.name] is [damage_text]!</B>\n"
	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			msg += "<span class='binarysay'><B>[t_His] [parse_zone(t)] is missing!</B></span>\n"
			continue
		if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG)
			r_limbs_missing++

		msg += "<B>[capitalize(t_his)] [parse_zone(t)] is missing!</B>\n"

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		msg += "[t_He] look[p_s()] all right now.\n"
	else if(l_limbs_missing == 0 && r_limbs_missing >= 2)
		msg += "[t_He] really keeps to the left.\n"
	else if(l_limbs_missing >= 2 && r_limbs_missing >= 2)
		msg += "[t_He] [p_do()]n't seem all there.\n"

	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else if(temp < 180)
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"
			else
				msg += "<B>[t_He] [t_has] extreme bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else if(temp < 180)
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"
			else
				msg += "<B>[t_He] [t_has] extreme burns!</B>\n"
		
		temp = getToxLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] looks sick.\n"
			else if(temp < 50)
				msg += "<B>[t_He] looks nauseous.</B>\n"
			else if (temp < 180)
				msg += "<B>[t_He] looks very unwell!</B>\n"
			else
				msg += "<B>[t_He] looks very unwell!</B>\n"

		temp = getOxyLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] looks pale.\n"
			else if(temp < 50)
				msg += "<B>[t_He] Is struggling to breathe!</B>\n"
			else if (temp < 100)
				msg += "<B>[t_He] Isn\'t Breathing!</B>\n"
			else
				msg += "<B>[t_He] Isn\'t Breathing!</B>\n"

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				msg += "[t_He] [t_has] minor cellular damage.\n"
			else if(temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> cellular damage!\n"
			else if(temp < 180)
				msg += "<b>[t_He] [t_has] severe cellular damage!</b>\n"
			else
				msg += "<b>[t_He] [t_has] extreme cellular damage!</b>\n"



	if(fire_stacks > 0)
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(fire_stacks < 0)
		msg += "[t_He] look[p_s()] a little soaked.\n"


	if(pulledby && pulledby.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		msg += "[t_He] [t_is] severely malnourished.\n"
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		if(user.nutrition < NUTRITION_LEVEL_STARVING - 50)
			msg += "[t_He] [t_is] plump and delicious looking - Like a fat little piggy. A tasty piggy.\n"
		else
			msg += "[t_He] looks stuffed to the gills!\n"
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			msg += "[t_He] look[p_s()] a bit grossed out.\n"
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			msg += "[t_He] look[p_s()] really grossed out.\n"
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			msg += "[t_He] look[p_s()] extremely disgusted.\n"

	var/apparent_blood_volume = blood_volume
	if(dna.species.use_skintones && skin_tone == "albino")
		apparent_blood_volume -= 300 // enough to knock you down one tier
	switch(apparent_blood_volume)
		if(BLOOD_VOLUME_SYMPTOMS_ANNOYING to BLOOD_VOLUME_SYMPTOMS_WARN)
			msg += "[t_He] [t_has] pale skin.\n"
		if(BLOOD_VOLUME_SYMPTOMS_DEBILITATING to BLOOD_VOLUME_SYMPTOMS_ANNOYING)
			msg += "<b>[t_He] look[p_s()] like pale death.</b>\n"
		if(-INFINITY to BLOOD_VOLUME_SYMPTOMS_DEBILITATING)
			msg += "<span class='binarysay'><b>[t_He] resemble[p_s()] a crushed, empty juice pouch.</b></span>\n"

	if(bleedsuppress)
		msg += "[t_He] [t_is] embued with a power that defies bleeding.\n" // only statues and highlander sword can cause this so whatever
	else if(is_bleeding())
		var/list/obj/item/bodypart/bleeding_limbs = list()

		for(var/i in bodyparts)
			var/obj/item/bodypart/BP = i
			if(BP.get_bleed_rate(FALSE))
				bleeding_limbs += "[BP.name]"

		//var/num_bleeds = LAZYLEN(bleeding_limbs)
		var/list/bleed_text
		if(appears_dead)
			bleed_text = list("<span class='binarysay'><B>Blood is visible in [t_his] open ")
		else
			bleed_text = list("<B>[t_He] [t_is] bleeding from [t_his] ")
		bleed_text += english_list(bleeding_limbs)
		/* switch(num_bleeds)
			if(1 to 2)
				bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
			if(3 to INFINITY)
				for(var/i in 1 to (num_bleeds - 1))
					var/obj/item/bodypart/BP = bleeding_limbs[i]
					bleed_text += " [BP.name],"
				bleed_text += " and [bleeding_limbs[num_bleeds].name]" */


		if(appears_dead)
			bleed_text += ", but it has pooled and is not flowing.</span></B>\n"
		else
			if(reagents.has_reagent(/datum/reagent/toxin/heparin))
				bleed_text += " incredibly quickly"

			bleed_text += "!</B>\n"
		msg += bleed_text.Join()

	if(reagents.has_reagent(/datum/reagent/teslium))
		msg += "[t_He] [t_is] emitting a gentle blue glow!\n"

	if(islist(stun_absorption))
		for(var/i in stun_absorption)
			if(stun_absorption[i]["end_time"] > world.time && stun_absorption[i]["examine_message"])
				msg += "[t_He] [t_is][stun_absorption[i]["examine_message"]]\n"

	if(drunkenness && !skipface && !appears_dead) //Drunkenness
		switch(drunkenness)
			if(11 to 21)
				msg += "[t_He] [t_is] slightly flushed.\n"
			if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
				msg += "[t_He] [t_is] flushed.\n"
			if(41.01 to 51)
				msg += "[t_He] [t_is] quite flushed and [t_his] breath smells of alcohol.\n"
			if(51.01 to 61)
				msg += "[t_He] [t_is] very flushed and [t_his] movements jerky, with breath reeking of alcohol.\n"
			if(61.01 to 91)
				msg += "[t_He] look[p_s()] like a drunken mess.\n"
			if(91.01 to INFINITY)
				msg += "[t_He] [t_is] a shitfaced, slobbering wreck.\n"

	if(reagents.has_reagent(/datum/reagent/fermi/astral))
		if(mind)
			msg += "[t_He] has wild, spacey eyes and they have a strange, abnormal look to them.\n"
		else
			msg += "[t_He] has wild, spacey eyes and they don't look like they're all there.\n"

	if(isliving(user))
		var/mob/living/L = user
		if(src != user && HAS_TRAIT(L, TRAIT_EMPATH) && !appears_dead)
			if (a_intent != INTENT_HELP)
				msg += "[t_He] seem[p_s()] to be on guard.\n"
			var/datum/component/mood/mood = GetComponent(/datum/component/mood)
			if(mood.sanity <= SANITY_DISTURBED)
				msg += "[t_He] seem[p_s()] distressed.\n"
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empath", /datum/mood_event/sad_empath, src)
			if(mood.shown_mood >= 6) //So roundstart people aren't all "happy" and that antags don't show their true happiness.
				msg += "<span class='nicegreen'>[t_He] seem[p_s()] to have had something nice happen to [t_him] recently.</span>\n"
				SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "empathH", /datum/mood_event/happy_empath, src)
			if (HAS_TRAIT(src, TRAIT_BLIND))
				msg += "[t_He] appear[p_s()] to be staring off into space.\n"
			if (HAS_TRAIT(src, TRAIT_DEAF))
				msg += "[t_He] appear[p_s()] to not be responding to noises.\n"

	var/obj/item/organ/vocal_cords/Vc = user.getorganslot(ORGAN_SLOT_VOICE)
	if(Vc)
		if(istype(Vc, /obj/item/organ/vocal_cords/velvet))
			if(client.prefs.cit_toggles & HYPNO)
				msg += "<span class='velvet'><i>You feel your chords resonate looking at them.</i></span>\n"


	if(!appears_dead)
		if(stat == UNCONSCIOUS)
			msg += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"
		else
			if(InCritical())
				msg += "[t_He] [t_is] barely conscious.\n"
		if(getorgan(/obj/item/organ/brain) && !(living_flags & HIDE_OFFLINE_INDICATOR))
			if(!key)
				msg += span_binarysay("[t_He] [t_is] totally catatonic. The stresses of the Wasteland must have been too much for [t_him]. Any recovery is unlikely.")
			else if(!client)
				msg += "[t_He] [t_has] a blank, absent-minded stare and appears completely unresponsive to anything. [t_He] may snap out of it soon.\n"
			else if(client && ((client.inactivity / 10) / 60 > 10)) //10 Minutes
				msg += "\[Inactive for [round((client.inactivity/10)/60)] minutes\]"
			else if(disconnect_time)
				msg += "\[Disconnected/ghosted [round(((world.realtime - disconnect_time)/10)/60)] minutes ago\]"

		if(digitalcamo)
			msg += "[t_He] [t_is] moving [t_his] body in an unnatural and blatantly inhuman manner.\n"

	// var/scar_severity = 0
	// for(var/i in all_scars)
	// 	var/datum/scar/S = i
	// 	if(S.is_visible(user))
	// 		scar_severity += S.severity

	// switch(scar_severity)
	// 	if(1 to 2)
	// 		msg += span_smallnoticeital("[t_He] [t_has] visible scarring, you can look again to take a closer look...")
	// 	if(3 to 4)
	// 		msg += "<span class='notice'><i>[t_He] [t_has] several bad scars, you can look again to take a closer look...</i></span>\n"
	// 	if(5 to 6)
	// 		msg += "<span class='notice'><b><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></b></span>\n"
	// 	if(7 to INFINITY)
	// 		msg += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"

	/// my first labeled loop thingy~
	//tat_check: // cut down before its time.
	for(var/X in bodyparts) // just check if *any* tats are visible
		var/obj/item/bodypart/BP = X
		if(BP.are_any_tattoos_visible(user))
			msg += span_notice("[t_He] seem[p_s()] to have some ink done. <a href='?src=[REF(src)];show_tattoos=1'>\[Look closer?\]</a>")
			break

	if (length(msg))
		. += span_warning("[msg.Join("")]")

	if(HAS_TRAIT(src, TRAIT_JIGGLY_ASS))
		. += span_notice("[t_His] butt could use a firm smack.</span>")

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	/// Personality and RP Preferences quirk display
	. += get_personality_traits(user)

	var/traitstring = get_trait_string()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		var/obj/item/organ/cyberimp/eyes/hud/CIH = H.getorgan(/obj/item/organ/cyberimp/eyes/hud)
		if(istype(H.glasses, /obj/item/clothing/glasses/hud) || CIH)
			var/perpname = get_face_name(get_id_name(""))
			if(perpname)
				var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
				if(R)
					. += "<span class='deptradio'>Rank:</span> [R.fields["rank"]]\n<a href='?src=[REF(src)];hud=1;photo_front=1'>\[Front photo\]</a><a href='?src=[REF(src)];hud=1;photo_side=1'>\[Side photo\]</a>"
				if(istype(H.glasses, /obj/item/clothing/glasses/hud/health) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/medical))
					var/cyberimp_detect
					for(var/obj/item/organ/cyberimp/CI in internal_organs)
						if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
							cyberimp_detect += "[name] is modified with a [CI.name]."
					if(cyberimp_detect)
						. += "Detected cybernetic modifications:"
						. += cyberimp_detect
					if(R)
						var/health_r = R.fields["p_stat"]
						. += "<a href='?src=[REF(src)];hud=m;p_stat=1'>\[[health_r]\]</a>"
						health_r = R.fields["m_stat"]
						. += "<a href='?src=[REF(src)];hud=m;m_stat=1'>\[[health_r]\]</a>"
					R = find_record("name", perpname, GLOB.data_core.medical)
					if(R)
						. += "<a href='?src=[REF(src)];hud=m;evaluation=1'>\[Medical evaluation\]</a>"
					if(traitstring)
						msg += "<span class='info'>Detected physiological traits:<br></span>"
						msg += "<span class='info'>[traitstring]</span><br>"



				if(istype(H.glasses, /obj/item/clothing/glasses/hud/security) || istype(CIH, /obj/item/organ/cyberimp/eyes/hud/security))
					if(!user.stat && user != src)
					//|| !user.canmove || user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
						var/criminal = "None"

						R = find_record("name", perpname, GLOB.data_core.security)
						if(R)
							criminal = R.fields["criminal"]

						. += jointext(list("<span class='deptradio'>Criminal status:</span> <a href='?src=[REF(src)];hud=s;status=1'>\[[criminal]\]</a>",
							"<span class='deptradio'>Security record:</span> <a href='?src=[REF(src)];hud=s;view=1'>\[View\]</a>",
							"<a href='?src=[REF(src)];hud=s;add_crime=1'>\[Add crime\]</a>",
							"<a href='?src=[REF(src)];hud=s;view_comment=1'>\[View comment log\]</a>",
							"<a href='?src=[REF(src)];hud=s;add_comment=1'>\[Add comment\]</a>"), "")
	else if(isobserver(user) && traitstring)
		. += "<span class='info'><b>Traits:</b> [traitstring]</span>"

	// . += "[print_special()]"//This already includes breaks and newlines, don't add any more


	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, .) //This also handles flavor texts now

	if(HAS_TRAIT(src, TRAIT_PVEFOC))
		. += span_boldwarning("[t_He] [t_has] <u>opted out</u> of PVP combat! Please respect their wishes and do not engage in PVP with them. If they are trying to PVP with you, please let the staff know!")
	else if(!HAS_TRAIT(user, TRAIT_PVEFOC) && HAS_TRAIT(src, TRAIT_PVPFOC))
		. += span_alert("[t_He] [t_has] is looking for PVP encounters! If you're looking for a fight, they're the one to go to!")

	if(has_status_effect(STATUS_EFFECT_ADMINSLEEP))
		. += span_danger("<B>This player has been slept by staff.</B>\n")

	. += "*---------*</span>"

/mob/living/proc/status_effect_examines(pronoun_replacement) //You can include this in any mob's examine() to show the examine texts of status effects!
	var/list/dat = list()
	if(!pronoun_replacement)
		pronoun_replacement = p_they(TRUE)
	for(var/V in status_effects)
		var/datum/status_effect/E = V
		if(E.examine_text)
			var/new_text = replacetext(E.examine_text, "SUBJECTPRONOUN", pronoun_replacement)
			new_text = replacetext(new_text, "[pronoun_replacement] is", "[pronoun_replacement] [p_are()]") //To make sure something become "They are" or "She is", not "They are" and "She are"
			dat += "[new_text]\n" //dat.Join("\n") doesn't work here, for some reason
	if(dat.len)
		dat.Join()
		return

/mob/living/proc/get_personality_traits(mob/user)
	if(!user)
		return
	var/msg
	var/out = ""
	for(var/triat in GLOB.personality_quirks)
		if(!HAS_TRAIT(src, triat))
			continue
		var/list/vistraits = LAZYACCESS(GLOB.personality_quirks, triat)
		var/emoji = LAZYACCESS(vistraits, THE_EMOJI)
		if(!emoji)
			emoji = " [triat] " // better put an emoji there!
		vistraits -= THE_EMOJI
		for(var/treit in vistraits)
			if(!HAS_TRAIT(user, treit))
				continue
			/// The return of the cursed href link!!!
			msg += {"<a href='?src=[REF(user)];read_personality_trait=[triat];>[emoji]</a>"}
	if(!isnull(msg))
		out = "[span_info("They have some cool traits! Click the emojis to learn more!")]\n"
	out += msg
	out +="\n"
	return out

/mob/living/Topic(href, href_list)
	. = ..()
	if(href_list["read_personality_trait"])
		to_chat(src, get_personality_flavor(href_list["read_personality_trait"]))

/mob/living/proc/get_personality_flavor(trait)
	var/list/traittest = LAZYACCESS(GLOB.personality_quirks, trait)
	var/emoji = LAZYACCESS(traittest, THE_EMOJI)
	if(emoji)
		emoji = "[emoji]"
	var/flavor = LAZYACCESS(GLOB.personalitytrait2description, trait)
	if(!flavor)
		stack_trace("get_personality_flavor() called with invalid trait [trait]! Didnt have any flavor, yuck")
		return
	var/alltogethernow = "[emoji] [flavor]"
	return alltogethernow

/* 
//erp focused quirks
	if(HAS_TRAIT(src, TRAIT_IN_HEAT) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>[t_He] [t_is] looking for a good time, you should check their OOC Notes.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPBOYKISSER) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>🍆 - They look like they prefer guys.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPGIRLKISSER) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>🍑 - They look like they prefer girls.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPANYKISSER) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>💋 - They look like they'd kiss boys OR girls.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPQUICKY) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>⏰ - They look like they're looking for flings, not long term partners.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPLONGTERM) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>📅 - They look like they're looking for long term sexual partners.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPBOTTOM) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>😔 - They look like a bottom, you'll probably need to be the one to approach.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPTOP) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>😎 - They look like a top, maybe if you wiggle right they'll approach you first.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPSWITCH) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>☯ - They look like a switch, see what works.</span>"

	if(HAS_TRAIT(src, TRAIT_ERPFLIRTY) && (HAS_TRAIT(user, TRAIT_HEAT_DETECT) || src == user))
		. += ""
		. += "<span class='love'>🌹 - They look flirty, or like being flirty with them might be very effective.  Check out the *help command for *flirts.</span>"

//info quirks that don't need a seeking
	if(HAS_TRAIT(src, TRAIT_SHY))
		. += ""
		. += "<span class='unconcious'>They are a bit shy (OOCly & probably ICly too), but is trying to make people know they want to be engaged with. Be a darling and maybe interact with them some if you have time?</span>"

	if(HAS_TRAIT(src, TRAIT_OOCAPP))
		. += ""
		. += "<span class='unconcious'>☎️ - L/OOC Approach Preffered</span>"

	if(HAS_TRAIT(src, TRAIT_PVEFOC))
		. += ""
		. += "<span class='unconcious'>✌️ - This player prefers PVE Scenarios.</span>"

	if(HAS_TRAIT(src, TRAIT_PVPFOC))
		. += ""
		. += "<span class='unconcious'>🔥 - This player prefers PVP Scenarios.</span>"

	if(HAS_TRAIT(src, TRAIT_COMBATSWITCH))
		. += ""
		. += "<span class='unconcious'>🌎 - This player is happy to do PVP or PVE gameplay.</span>"



//rp focused quirks
	if(HAS_TRAIT(src, TRAIT_RPLONGTERM) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>📅 - They are looking for RP that is long term focused. Perhaps contact them via LOOC to work that out together?</span>"

	if(HAS_TRAIT(src, TRAIT_RPSHORTTERM) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>⏰ - They are looking for RP that is short term focused. This generally means only things in the current round.</span>"

	if(HAS_TRAIT(src, TRAIT_RPSERIOUS) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>👑 - They are looking for RP that is relatively serious, if you to want to take the setting seriously maybe you should chatter at them via LOOC?</span>"

	if(HAS_TRAIT(src, TRAIT_RPLIGHT) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>🤡 - They are looking for RP that is relatively light, if you're looking for a silly distraction RP maybe you should approach.</span>"

	if(HAS_TRAIT(src, TRAIT_RPSCRUBS) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>⛑ -They are looking for RP that is medically inclined. Think House, ER, or maybe even Scrubs.</span>"

	if(HAS_TRAIT(src, TRAIT_RPDAYSOFOURLIVES) && (HAS_TRAIT(user, TRAIT_RPFOCUSED) || src == user))
		. += ""
		. += "<span class='greenannounce'>💀 - They are looking for RP that is dramatic, maybe even a bit over the top. Think soap opera.</span>"

	if(HAS_TRAIT(src, TRAIT_SMOL))
		. += ""
		. += span_notice("[t_He] looks easy to scoop up.</span>")

//Adventure focused quirks

	if(HAS_TRAIT(src, TRAIT_ADV_ER) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>♞ - They look like the adventuring sort.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_LFG) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>💑 - They look like they'd like to have someone adventure with them, maybe you should ask?</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_SOLO) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>😑 - They don't look like they'd want anyone to adventure with right now.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_GUNNER) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🔫 - They look like they know their way around ranged combat.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_FIGHTER) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🗡 - A real fighter of all time, they look like they can use a blade.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_TANK) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🛡 - A shield wielding wall of an adventurer. They look like they could hold back a tsunami.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_BRUISER) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🏏 - A real bruiser of a waster, the way they hold a two handed weapon speaks volumes about melons being obliterated.</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_ROGUE) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🔓 - This person looks insanely useful at things that might not be JUST killing monsters. Maybe see if they have a lockpick on hand?</span>"

	if(HAS_TRAIT(src, TRAIT_ADV_HEALER	) && (HAS_TRAIT(user, TRAIT_ADV_SEEKER) || src == user))
		. += ""
		. += "<span class='binarysay'>🏥 - This person looks like they know how to keep your bits glued together and your blood inside you. How nice.</span>"
 */


		
