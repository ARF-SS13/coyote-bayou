//predominantly negative traitsvalue = -1

/datum/quirk/blooddeficiency
	name = "Acute Blood Deficiency"
	desc = "Your body can't produce enough blood to sustain itself."
	value = -1
	gain_text = span_danger("You feel your vigor slowly fading away.")
	lose_text = span_notice("You feel vigorous again.")
	antag_removal_text = "Your antagonistic nature has removed your blood deficiency."
	medical_record_text = "Patient requires regular treatment for blood loss due to low production of blood."

/datum/quirk/blooddeficiency/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if your species doesn't have any
		return
	else
		quirk_holder.blood_volume -= 0.2

/datum/quirk/depression
	name = "Mood - Depressive"
	desc = "You sometimes just hate life, and get a mood debuff for it."
	mob_trait = TRAIT_DEPRESSION
	value = -2
	gain_text = span_danger("You start feeling depressed.")
	lose_text = span_notice("You no longer feel depressed.") //if only it were that easy!
	medical_record_text = "Patient has a severe mood disorder, causing them to experience acute episodes of depression."
	mood_quirk = TRUE

/datum/quirk/depression/on_process()
	if(prob(0.15))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "depression", /datum/mood_event/depression)

/datum/quirk/pessimist
	name = "Mood - Pessimist"
	desc = "You sometimes just sort of hate life, and get a mood debuff for it."
	mob_trait = TRAIT_PESSIMIST
	value = -1
	gain_text = span_danger("You start feeling depressed.")
	lose_text = span_notice("You no longer feel depressed.") //if only it were that easy!
	medical_record_text = "Patient has a mood disorder, causing them to experience episodes of depression like symptoms."
	mood_quirk = TRUE

/datum/quirk/pessimist/on_process()
	if(prob(0.15))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "pessimist", /datum/mood_event/pessimism)


/datum/quirk/family_heirloom
	name = "Family Heirloom"
	desc = "You are the current owner of an heirloom, passed down for generations. You have to keep it safe!"
	value = -1
	mood_quirk = TRUE
	medical_record_text = "Patient demonstrates an unnatural attachment to a family heirloom."
	var/obj/item/heirloom
	var/where

GLOBAL_LIST_EMPTY(family_heirlooms)

/datum/quirk/family_heirloom/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/heirloom_type
	switch(quirk_holder.mind.assigned_role)
		if("Scribe")
			heirloom_type = pick(/obj/item/trash/f13/electronic/toaster, /obj/item/screwdriver/crude, /obj/item/toy/tragicthegarnering)
		if("Knight")
			heirloom_type = /obj/item/gun/ballistic/automatic/toy/pistol
		if("BoS Off-Duty")
			heirloom_type = /obj/item/toy/figure/borg
		if("Sheriff")
			heirloom_type = /obj/item/clothing/accessory/medal/silver
		if("Deputy")
			heirloom_type = /obj/item/clothing/accessory/medal/bronze_heart
		if("Texarkana Trade Worker")
			heirloom_type = /obj/item/coin/plasma
		if("Town Doctor")
			heirloom_type = pick(/obj/item/clothing/neck/stethoscope,/obj/item/toy/tragicthegarnering)
		if("Senior Doctor")
			heirloom_type = pick(/obj/item/toy/nuke, /obj/item/wrench/medical, /obj/item/clothing/neck/tie/horrible)
		if("Prime Legionnaire")
			heirloom_type = pick(/obj/item/melee/onehanded/machete, /obj/item/melee/onehanded/club/warclub, /obj/item/clothing/accessory/talisman, /obj/item/toy/plush/mr_buckety)
		if("Recruit Legionnaire")
			heirloom_type = pick(/obj/item/melee/onehanded/machete, /obj/item/melee/onehanded/club/warclub, /obj/item/clothing/accessory/talisman,/obj/item/clothing/accessory/skullcodpiece/fake)
		if("Den Mob Boss")
			heirloom_type = /obj/item/lighter/gold
		if("Den Doctor")
			heirloom_type = /obj/item/card/id/dogtag/MDfakepermit
		if("Farmer")
			heirloom_type = pick(/obj/item/hatchet, /obj/item/shovel/spade, /obj/item/toy/plush/beeplushie)
		if("Janitor")
			heirloom_type = /obj/item/mop
		if("Security Officer")
			heirloom_type = /obj/item/clothing/accessory/medal/silver/valor
		if("Scientist")
			heirloom_type = /obj/item/toy/plush/slimeplushie
		if("Assistant")
			heirloom_type = /obj/item/clothing/gloves/cut/family
		if("Chaplain")
			heirloom_type = /obj/item/camera/spooky/family
		if("Captain")
			heirloom_type = /obj/item/clothing/accessory/medal/gold/captain/family
	if(!heirloom_type)
		heirloom_type = pick(
		/obj/item/toy/cards/deck,
		/obj/item/lighter,
		/obj/item/card/id/rusted,
		/obj/item/card/id/rusted/fadedvaultid,
		/obj/item/clothing/gloves/ring/silver,
		/obj/item/toy/figure/detective,
		/obj/item/toy/tragicthegarnering,
		)
	heirloom = new heirloom_type(get_turf(quirk_holder))
	GLOB.family_heirlooms += heirloom
	var/list/slots = list(
		"in your left pocket" = SLOT_L_STORE,
		"in your right pocket" = SLOT_R_STORE,
		"in your backpack" = SLOT_IN_BACKPACK
	)
	where = H.equip_in_one_of_slots(heirloom, slots, FALSE) || "at your feet"

/datum/quirk/family_heirloom/post_add()
	if(where == "in your backpack")
		var/mob/living/carbon/human/H = quirk_holder
		SEND_SIGNAL(H.back, COMSIG_TRY_STORAGE_SHOW, H)

	to_chat(quirk_holder, span_boldnotice("There is a precious family [heirloom.name] [where], passed down from generation to generation. Keep it safe!"))
	var/list/family_name = splittext(quirk_holder.real_name, " ")
	heirloom.name = "\improper [family_name[family_name.len]] family [heirloom.name]"

/datum/quirk/family_heirloom/on_process()
	if(heirloom in quirk_holder.GetAllContents())
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom_missing")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom", /datum/mood_event/family_heirloom)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "family_heirloom")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "family_heirloom_missing", /datum/mood_event/family_heirloom_missing)

/datum/quirk/family_heirloom/clone_data()
	return heirloom

/datum/quirk/family_heirloom/on_clone(data)
	heirloom = data

/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper" //hard consider redesigning, since this is a flat update. ~TK
	desc = "You sleep like a rock! Whenever you're put to sleep, you sleep for a little bit longer."
	value = -1
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("You feel sleepy.")
	lose_text = span_notice("You feel awake again.")
	medical_record_text = "Patient has abnormal sleep study results and is difficult to wake up."

/datum/quirk/brainproblems
	name = "Brain Tumor"
	desc = "You have a little friend in your brain that is slowly destroying it. Better bring some mannitol!"
	value = -1
	gain_text = span_danger("You feel smooth.")
	lose_text = span_notice("You feel wrinkled again.")
	medical_record_text = "Patient has a tumor in their brain that is slowly driving them to brain death."

/datum/quirk/brainproblems/on_process()
	quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)

/datum/quirk/nearsighted //t. errorage
	name = "Nearsighted - Corrected"
	desc = "You are nearsighted without prescription glasses, but spawn with a pair."
	value = -1
	gain_text = span_danger("Things far away from you start looking blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."

/datum/quirk/nearsighted/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nearsighted/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/regular/glasses = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(glasses, SLOT_GLASSES))
		H.put_in_hands(glasses)

/datum/quirk/noglasses
	name = "Nearsighted - No Glasses"
	desc = "You are nearsighted and without prescription glasses, you might could find a pair."
	value = -2
	gain_text = span_danger("Things far away from you start looking blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."

/datum/quirk/noglasses/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/badeyes
	name = "Nearsighted - Trashed Vision"
	desc = "You are badly nearsighted without prescription glasses, so much so that it's kind of a miracle you're still alive. You defintiely don't have any corrective lenses, but they would help."
	value = -3
	gain_text = span_danger("Things far away from you start looking VERY blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract sort of ridiculous levels of nearsightedness."

/datum/quirk/badeyes/add()
	quirk_holder.become_mega_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/nyctophobia
	name = "Phobia - The Dark"
	desc = "As far as you can remember, you've always been afraid of the dark. While in the dark without a light source, you instinctually act careful, and constantly feel a sense of dread."
	value = -1
	medical_record_text = "Patient demonstrates a fear of the dark."

/datum/quirk/nyctophobia/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(H.dna.species.id in list("shadow", "nightmare"))
		return //we're tied with the dark, so we don't get scared of it; don't cleanse outright to avoid cheese
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	if(lums <= 0.2)
		if(quirk_holder.m_intent == MOVE_INTENT_RUN)
			to_chat(quirk_holder, span_warning("Easy, easy, take it slow... you're in the dark..."))
			quirk_holder.toggle_move_intent()
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "nyctophobia", /datum/mood_event/nyctophobia)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "nyctophobia")

/datum/quirk/lightless
	name = "Phobia - Bright Light"
	desc = "Bright lights irritate you. Your eyes start to water, your skin feels itchy against the photon radiation, and your hair gets dry and frizzy. Maybe it's a medical condition."
	value = -1
	gain_text = span_danger("The safety of light feels off...")
	lose_text = span_notice("Enlightening.")
	medical_record_text = "Patient has acute phobia of light, and insists it is physically harmful."

/datum/quirk/lightless/on_process()
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	if(lums >= 0.8)
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "brightlight", /datum/mood_event/brightlight)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "brightlight")

/datum/quirk/nonviolent
	name = "Pacifist"
	desc = "The thought of violence makes you sick. So much so, in fact, that you can't hurt anyone."
	value = -1
	mob_trait = TRAIT_PACIFISM
	gain_text = span_danger("You feel repulsed by the thought of violence!")
	lose_text = span_notice("You think you can defend yourself again.")
	medical_record_text = "Patient is unusually pacifistic and cannot bring themselves to cause physical harm."
	antag_removal_text = "Your antagonistic nature has caused you to renounce your pacifism."

/datum/quirk/paraplegic
	name = "Paraplegic"
	desc = "Your legs do not function. Nothing will ever fix this. Luckily you found a wheelchair."
	value = -3
	mob_trait = TRAIT_PARA
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Patient has an untreatable impairment in motor function in the lower extremities."

/datum/quirk/paraplegic/add()
	var/datum/brain_trauma/severe/paralysis/paraplegic/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/paraplegic/on_spawn()
	if(quirk_holder.client)
		var/modified_limbs = quirk_holder.client.prefs.modified_limbs
		if(!(modified_limbs[BODY_ZONE_L_LEG] == LOADOUT_LIMB_AMPUTATED && modified_limbs[BODY_ZONE_R_LEG] == LOADOUT_LIMB_AMPUTATED && !isjellyperson(quirk_holder)))
			if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
				quirk_holder.buckled.unbuckle_mob(quirk_holder)

			var/turf/T = get_turf(quirk_holder)
			var/obj/structure/chair/spawn_chair = locate() in T

			var/obj/vehicle/ridden/wheelchair/wheels = new(T)
			if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
				wheels.setDir(spawn_chair.dir)

			wheels.buckle_mob(quirk_holder)

			// During the spawning process, they may have dropped what they were holding, due to the paralysis
			// So put the things back in their hands.

			for(var/obj/item/I in T)
				if(I.fingerprintslast == quirk_holder.ckey)
					quirk_holder.put_in_hands(I)

/datum/quirk/poor_aim
	name = "Poor Aim"
	desc = "You're terrible with guns and can't line up a straight shot to save your life. Dual-wielding is right out."
	value = -1
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "Patient possesses a strong tremor in both hands."

/datum/quirk/prosopagnosia
	name = "Prosopagnosia"
	desc = "You have a mental disorder that prevents you from being able to recognize faces at all."
	value = -1
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "Patient suffers from prosopagnosia, and cannot recognize faces."

/datum/quirk/insanity
	name = "Reality Dissociation Syndrome"
	desc = "You suffer from a severe disorder that causes very vivid hallucinations. Mindbreaker toxin can suppress its effects, and you are immune to mindbreaker's hallucinogenic properties. <b>This is not a license to grief.</b>"
	value = -1
	//no mob trait because it's handled uniquely
	gain_text = span_userdanger("...")
	lose_text = span_notice("You feel in tune with the world again.")
	medical_record_text = "Patient suffers from acute Reality Dissociation Syndrome and experiences vivid hallucinations."

/datum/quirk/insanity/on_process()
	if(quirk_holder.reagents.has_reagent(/datum/reagent/toxin/mindbreaker))
		quirk_holder.hallucination = 0
		return
	if(prob(2)) //we'll all be mad soon enough
		madness()

/datum/quirk/insanity/proc/madness()
	quirk_holder.hallucination += rand(10, 25)

/datum/quirk/insanity/post_add() //I don't /think/ we'll need this but for newbies who think "roleplay as insane" = "license to kill" it's probably a good thing to have
	if(!quirk_holder.mind || quirk_holder.mind.special_role)
		return
	to_chat(quirk_holder, "<span class='big bold info'>Please note that your dissociation syndrome does NOT give you the right to attack people or otherwise cause any interference to \
	the round. You are not an antagonist, and the rules will treat you the same as other crewmembers.</span>")

/datum/quirk/social_anxiety
	name = "Social Anxiety"
	desc = "Talking to people is very difficult for you, and you often stutter or even lock up."
	value = -1
	gain_text = span_danger("You start worrying about what you're saying.")
	lose_text = span_notice("You feel easier about talking again.") //if only it were that easy!
	medical_record_text = "Patient is usually anxious in social encounters and prefers to avoid them."
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_EYECONTACT, .proc/eye_contact)
	// RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINATE, .proc/looks_at_floor)

/datum/quirk/social_anxiety/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_MOB_EYECONTACT, COMSIG_MOB_EXAMINATE))

/datum/quirk/social_anxiety/on_process()
	var/nearby_people = 3
	for(var/mob/living/carbon/human/H in oview(4, quirk_holder))
		if(H.client)
			nearby_people++
	var/mob/living/carbon/human/H = quirk_holder
	if(prob(3 + nearby_people))
		H.stuttering = max(3, H.stuttering)
		//Murder fucking this spammy ass message.  This crap is insane.~ TK
	// else if(prob(min(3, nearby_people)) && !H.silent)
	//	o_chat(H, "<span class='danger'>You retreat into yourself. You <i>really</i> don't feel up to talking.</span>")
	//	H.silent = max(10, H.silent)t
	else if(prob(0.5) && dumb_thing)
		to_chat(H, span_userdanger("You think of a dumb thing you said a long time ago and scream internally."))
		dumb_thing = FALSE //only once per life
		if(prob(1))
			new/obj/item/reagent_containers/food/snacks/pastatomato(get_turf(H)) //now that's what I call spaghetti code

/* small chance to make eye contact with inanimate objects/mindless mobs because of nerves
Edit: TK~  This is the dumbest fucking shit I've ever seen in my life.  This isn't fucking socially anxious, it's a fucking mania.
/datum/quirk/social_anxiety/proc/looks_at_floor(datum/source, atom/A)
	var/mob/living/mind_check = A
	if(prob(85) || (istype(mind_check) && mind_check.mind))
		return

	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, quirk_holder, span_smallnotice("You make eye contact with [A].")), 3)
*/
/datum/quirk/social_anxiety/proc/eye_contact(datum/source, mob/living/other_mob, triggering_examiner)
	if(prob(75))
		return
	var/msg
	if(triggering_examiner)
		msg = "You make eye contact with [other_mob], "
	else
		msg = "[other_mob] is staring at you, "

	switch(rand(1,3))
		if(1)
			quirk_holder.Jitter(10)
			msg += "causing you to start fidgeting!"
		if(2)
			quirk_holder.stuttering = max(3, quirk_holder.stuttering)
			msg += "causing you to start stuttering!"
		if(3)
			quirk_holder.Stun(2 SECONDS)
			msg += "causing you to freeze up!"

	SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "anxiety_eyecontact", /datum/mood_event/anxiety_eyecontact)
	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, quirk_holder, span_userdanger("[msg]")), 3) // so the examine signal has time to fire and this will print after
	return COMSIG_BLOCK_EYECONTACT

/datum/mood_event/anxiety_eyecontact
	description = span_warning("Sometimes eye contact makes me so nervous...")
	mood_change = -5
	timeout = 3 MINUTES

/datum/quirk/spiderphobia
	name = "Phobia - Spiders"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with spiders."
	value = -2
	mob_trait = TRAIT_SPIDERPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of eight legged monsters grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/spiderphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/spiders, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/spiderphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/spiders, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/skelephobia
	name = "Phobia - Skeletons"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with bones."
	value = -1
	mob_trait = TRAIT_BONERPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of bones grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/skelephobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/skeletons, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/skelephobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/skeletons, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/maskphobia
	name = "Phobia - Masked People"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with someone wearing a mask."
	value = -2
	mob_trait = TRAIT_MASKPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of the unknown stranger grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/maskphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/strangers, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/maskphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/strangers, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/doctorphobia
	name = "Phobia - Doctors"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with doctors."
	value = -3
	mob_trait = TRAIT_DOCTORPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of the doctors grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/doctorphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/doctors, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/maskphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/doctors, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/catphobia
	name = "Phobia - Cats"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with cats."
	value = -1
	mob_trait = TRAIT_CATPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of the feline menace grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/catphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/cats, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/catphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/cats, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/eyephobia
	name = "Phobia - Eyes"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with eyes."
	value = -1
	mob_trait = TRAIT_EYEPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of your eyes being stabbed grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/eyephobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/eye, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/eyephobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/eye, TRAUMA_RESILIENCE_ABSOLUTE)


/datum/quirk/mute
	name = "Mute"
	desc = "Due to some accident, medical condition, or simply by choice, you are completely unable to speak."
	value = 0 //HALP MAINTS
	gain_text = span_danger("You find yourself unable to speak!")
	lose_text = span_notice("You feel a growing strength in your vocal chords.")
	medical_record_text = "Functionally mute, patient is unable to use their voice in any capacity."
	antag_removal_text = "Your antagonistic nature has caused your voice to be heard."
	var/datum/brain_trauma/severe/mute/mute

/datum/quirk/mute/add()
	var/mob/living/carbon/human/H = quirk_holder
	mute = new
	H.gain_trauma(mute, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/mute/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(mute, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/unstable
	name = "Unstable"
	desc = "Due to past troubles, you are unable to recover your sanity if you lose it. Be very careful managing your mood!"
	value = -1
	mob_trait = TRAIT_UNSTABLE
	gain_text = span_danger("There's a lot on your mind right now.")
	lose_text = span_notice("Your mind finally feels calm.")
	medical_record_text = "Patient's mind is in a vulnerable state, and cannot recover from traumatic events."

/datum/quirk/blindness
	name = "Blind"
	desc = "You are completely blind, nothing can counteract this."
	value = -4
	gain_text = span_danger("You can't see anything.")
	lose_text = span_notice("You miraculously gain back your vision.")
	medical_record_text = "Patient has permanent blindness."

/datum/quirk/blindness/add()
	quirk_holder.become_blind(ROUNDSTART_TRAIT)

/datum/quirk/blindness/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/glasses/sunglasses/blindfold/white/glasses = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(glasses, SLOT_GLASSES, bypass_equip_delay_self = TRUE)) //if you can't put it on the user's eyes, put it in their hands, otherwise put it on their eyes eyes
		H.put_in_hands(glasses)
	H.regenerate_icons()

/datum/quirk/blindness/remove()
	quirk_holder?.cure_blind(ROUNDSTART_TRAIT)

/datum/quirk/coldblooded
	name = "Cold-blooded"
	desc = "Your body doesn't create its own internal heat, requiring external heat regulation."
	value = -1
	medical_record_text = "Patient is ectothermic."
	mob_trait = TRAIT_COLDBLOODED
	gain_text = span_notice("You feel cold-blooded.")
	lose_text = span_notice("You feel more warm-blooded.")

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "You will become increasingly stressed when not in company of others, triggering panic reactions ranging from sickness to heart attacks."
	value = -2 //Removed Heart attack, should be good now. :)
	gain_text = span_danger("You feel really lonely...")
	lose_text = span_notice("You feel like you could be safe on your own.")
	medical_record_text = "Patient feels sick and distressed when not around other people, leading to potentially lethal levels of stress."
	locked = TRUE

/datum/quirk/monophobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/monophobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/no_guns
	name = "Fat-Fingered"
	desc = "Due to the shape of your hands, width of your fingers or just not having fingers at all, you're unable to fire guns without accommodation."
	value = -1
	mob_trait = TRAIT_CHUNKYFINGERS
	gain_text = "<span class='notice'>Your fingers feel... thick.</span>"
	lose_text = "<span class='notice'>Your fingers feel normal again.</span>"

/datum/quirk/illiterate
	name = "Illiterate"
	desc = "You can't read nor write, plain and simple."
	value = -1
	mob_trait = TRAIT_ILLITERATE
	gain_text = "<span class='notice'>The knowledge of how to read seems to escape from you.</span>"
	lose_text = "<span class='notice'>Written words suddenly make sense again."

/datum/quirk/flimsy
	name = "Health - Flimsy"
	desc = "Your body is a little more fragile then most, decreasing total health some."
	value = -1
	mob_trait = TRAIT_FLIMSY
	medical_record_text = "Patient has low capacity for injury."
	gain_text = "<span class='notice'>You feel like you could break with a single hit."
	lose_text = "<span class='notice'>You feel more durable."

/datum/quirk/flimsy/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.maxHealth -= 10
	mob_tar.health -= 10

/datum/quirk/veryflimsy
	name = "Health - Very Flimsy"
	desc = "Your body is a lot more fragile then most, decreasing total health."
	value = -3
	mob_trait = TRAIT_VERYFLIMSY
	medical_record_text = "Patient has abnormally low capacity for injury."
	gain_text = "<span class='notice'>You feel like you could break with a single hit."
	lose_text = "<span class='notice'>You feel more durable."

/datum/quirk/veryflimsy/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.maxHealth -= 20
	mob_tar.health -= 20


/datum/quirk/masked_mook
	name = "Masked Mook"
	desc = "For some reason you don't feel... right without wearing some kind of gas mask."
	gain_text = "<span class='danger'>You start feeling unwell without any gas mask on.</span>"
	lose_text = "<span class='notice'>You no longer have a need to wear some gas mask.</span>"
	value = -1
	mood_quirk = TRUE
	medical_record_text = "Patient feels more secure when wearing a gas mask."
	var/mood_category = "masked_mook"

/datum/quirk/masked_mook/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/maskmask = H.get_item_by_slot(ITEM_SLOT_MASK)
	if(istype(maskmask) && !istype(maskmask, /obj/item/clothing/mask/cigarette))
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook_incomplete)
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook)
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, mood_category, /datum/mood_event/masked_mook_incomplete)

/datum/mood_event/masked_mook
	description = span_nicegreen("I'm safe in my protective mask.")
	mood_change = 3
	timeout = 0

/datum/mood_event/masked_mook_incomplete
	description = span_warning("I'm forced to breathe the horrors of the wastes!")
	mood_change = -3
	timeout = 0

/datum/quirk/masked_mook/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas/gasmask = new(get_turf(quirk_holder))
	H.equip_to_slot(gasmask, ITEM_SLOT_MASK)
	H.regenerate_icons()

/datum/quirk/paper_skin
	name = "Paper Skin"
	desc = "Your flesh is weaker, resulting in receiving cuts more easily."
	value = -1
	mob_trait = TRAIT_PAPER_SKIN
	gain_text = "<span class='notice'>Your flesh feels weak!</span>"
	lose_text = "<span class='notice'>Your flesh feels more durable!</span>"
	medical_record_text = "Patient suffers from weak flesh, resulting in them receiving cuts far more easily."

/datum/quirk/glass_bones
	name = "Glass Bones"
	desc = "Your bones are far more brittle, and more vulnerable to breakage."
	value = -1
	mob_trait = TRAIT_GLASS_BONES
	gain_text = "<span class='notice'>Your bones feels weak!</span>"
	lose_text = "<span class='notice'>Your bones feels more durable!</span>"
	medical_record_text = "Patient suffers from brittle bones, resulting in them receiving breakages far more easily."

/datum/quirk/noodle_fist
	name = "Fists of Noodle"
	desc = "Your punching is legendary. Legendarily bad at doing anything to anyone."
	value = -1
	mob_trait = TRAIT_NOODLEFIST
	gain_text = span_notice("Your fists feel weak and worthless!")
	lose_text = span_danger("Your fists strong again.")
	locked = FALSE

/datum/quirk/noodle_fist/on_spawn()
	var/mob/living/carbon/human/mob_tar = quirk_holder
	mob_tar.dna.species.punchdamagelow = 0
	mob_tar.dna.species.punchdamagehigh = 0

/datum/quirk/gentle
	name = "Melee - Gentle"
	desc = "Something about your strikes in melee is just... below average. You deal slightly less damage with melee weapons."
	value = -1
	mob_trait = TRAIT_GENTLE
	gain_text = span_notice("You feel like you don't really like smacking stuff.")
	lose_text = span_danger("You feel like slapping the mess out of a gecko.")
	locked = FALSE

/datum/quirk/wimpy
	name = "Melee - Wimpy"
	desc = "For some reason you're just really bad at hitting things agianst things. Your melee damage is much lower than average."
	value = -3
	mob_trait = TRAIT_WIMPY
	gain_text = span_notice("You feel like smacking things is just a waste of time.")
	lose_text = span_danger("You feel like slapping the mess out of a Deathclaw!")
	locked = FALSE

/datum/quirk/slow
	name = "Mobility - Wasteland Slug"
	desc = "You've spent some time in the wastes, you don't get around great."
	value = -1
	mob_trait = TRAIT_SLUG
	gain_text = span_notice("Rain or shine, you might get there eventually.")
	lose_text = span_danger("Your gait feels a little more sure!")
	locked = FALSE

/datum/quirk/slower
	name = "Mobility - Wasteland Molasses"
	desc = "You don't get around well off road. Like. At all."
	value = -2
	mob_trait = TRAIT_SLOWAF
	gain_text = span_notice("You feel like staying at home.")
	lose_text = span_danger("Wow! You feel like you could run around the whole WORLD!")
	locked = FALSE

/datum/quirk/clumsy
	name = "Clumsy"
	desc = "You're very clumsy, it's kind of a miracle you're alive at all really."
	value = -3
	mob_trait = TRAIT_CLUMSY
	gain_text = span_notice("You feel really... awkward?")
	lose_text = span_danger("Your composure seems to return to you.")
	locked = FALSE

/datum/quirk/dumb
	name = "Dumb"
	desc = "You're, well.  Just kind of stupid."
	value = -2
	mob_trait = TRAIT_DUMB
	gain_text = span_notice("You brain just about shuts off, and for the first time in your life you feel truly free.")
	lose_text = span_danger("Your brain turns back on, and you remember that Taxes are a thing.")
	locked = FALSE

/datum/quirk/primitive
	name = "Primitive"
	desc = "Unga Bunga"
	value = -2
	mob_trait = TRAIT_MONKEYLIKE
	gain_text = span_notice("yOu reTurN tO MonKE")
	lose_text = span_danger("I think, there for... I am?")
	locked = FALSE

/datum/quirk/nosleep
	name = "Can Not Sleep"
	desc = "For whatever reason you literally lack the ability to sleep."
	value = -1
	mob_trait = TRAIT_SLEEPIMMUNE
	gain_text = span_notice("You feel like you'll never need to sleep again, for real!")
	lose_text = span_danger("You could kind of go for a nap.")
	locked = FALSE

/datum/quirk/garbledspeach
	name = "Unintelligible Speech"
	desc = "You are so far beyond tongue tied."
	value = -2
	mob_trait = TRAIT_UNINTELLIGIBLE_SPEECH
	gain_text = span_notice("Your tongue just sort of stops working!")
	lose_text = span_danger("You can find your words again.")
	locked = FALSE

/datum/quirk/cantrun
	name = "Mobility - Can not Run"
	desc = "For whatever reason you just can't muster up the go to run."
	value = -3
	mob_trait = TRAIT_NORUNNING
	gain_text = span_notice("Running just isnt' worth the effort!")
	lose_text = span_danger("You really feel like running all of a sudden!")
	locked = FALSE

/datum/quirk/luddite
	name = "Luddite"
	desc = "You forgo some technology, like autolathes and some other machinery."
	value = -2
	mob_trait = TRAIT_TECHNOPHOBE
	gain_text = span_notice("You feel like all that training with bows has paying off.")
	lose_text = span_danger("Guns were always better...")
	locked =  FALSE
