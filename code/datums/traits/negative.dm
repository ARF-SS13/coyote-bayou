//predominantly negative traitsvalue = -1

/datum/quirk/blooddeficiency
	name = "Acute Blood Deficiency"
	desc = "Your body struggles to produce enough blood to sustain itself. Whilst not fatal, not treating your condition and getting wounded will send you into an un-recoverable death-spiral!"
	value = -30
	category = "Health Quirks"
	mechanics = "Your blood will constantly drop to 30% of blood capacity. Replenishing your lost blood will also make you hungry!"
	conflicts = list(
		/datum/quirk/bloodpressure,
	)
	gain_text = span_danger("You feel your vigor slowly fading away.")
	lose_text = span_notice("You feel vigorous again.")
	antag_removal_text = "Your antagonistic nature has removed your blood deficiency."
	medical_record_text = "Patient struggles to maintain an optimal blood volume, requires transfusions and iron supplements."

/datum/quirk/blooddeficiency/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	if(NOBLOOD in H.dna.species.species_traits) //can't lose blood if your species doesn't have any
		return
	else
		if(H.blood_volume > BLOOD_VOLUME_SYMPTOMS_DEBILITATING) // If blood volume is higher than (30%), do stuff. You can survive with this blood level but it sucks.
			H.blood_volume -= 0.275	//WARNING! PR #843 HAS DONE A LOT OF STUFF TO BLOOD SO CHECK IT BEFORE CHANGING THIS ! ! You regenerate 2.5 blood if you're fed.


/datum/quirk/depression
	name = "Mood - Depressive" //mood dude
	desc = "You sometimes just hate life, and get a mood debuff for it."
	mob_trait = TRAIT_DEPRESSION
	value = -22
	category = "Emotional Quirks"
	mechanics = "Every tick you have a chance to get hit with a pretty big negative moodlet. Yeah. Depression kind of sucks, who'da'thunk'it?"
	conflicts = list(
		/datum/quirk/friendly,
		// /datum/quirk/jolly,
		// /datum/quirk/optimist,
		/datum/quirk/pessimist,
		/datum/quirk/apathetic,
	)
	gain_text = span_danger("You start feeling depressed.")
	lose_text = span_notice("You no longer feel depressed.") //if only it were that easy!
	medical_record_text = "Patient has a severe mood disorder, causing them to experience acute episodes of depression."
	mood_quirk = TRUE

/datum/quirk/depression/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "depression", /datum/mood_event/depression)

/datum/quirk/pessimist
	name = "Mood - Pessimist"
	desc = "You sometimes just sort of hate life, and get a mood debuff for it."
	mob_trait = TRAIT_PESSIMIST
	value = -11
	category = "Emotional Quirks"
	mechanics = "Every tick you have a chance to be hit with a negative moodlet. Yeah. It sucks being a downer all the time."
	conflicts = list(
		/datum/quirk/friendly,
		// /datum/quirk/jolly,
		// /datum/quirk/optimist,
		/datum/quirk/depression,
		/datum/quirk/apathetic,
)
	gain_text = span_danger("You start feeling depressed.")
	lose_text = span_notice("You no longer feel depressed.") //if only it were that easy!
	medical_record_text = "Patient has a mood disorder, causing them to experience episodes of depression like symptoms."
	mood_quirk = TRUE

/datum/quirk/pessimist/on_process()
	if(prob(0.05))
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "pessimist", /datum/mood_event/pessimism)

/*
/datum/quirk/family_heirloom
	name = "Family Heirloom"
	desc = "You are the current owner of an heirloom, passed down for generations. You have to keep it safe!"
	value = -11
	category = "Emotional Quirks"
	mechanics = "As it stands this will give you a random item from a list to keep track of, remind Fenny constantly that it should be broken down into multiple different items or like a labeller to make any one item your squishy."
	conflicts = list(/datum/quirk/apathetic)
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
*/

/datum/quirk/heavy_sleeper
	name = "Heavy Sleeper" //hard consider redesigning, since this is a flat update. ~TK
	desc = "You sleep like a rock! Whenever you're put to sleep, you sleep for a little bit longer."
	value = -11
	category = "Functional Quirks"
	mechanics = "If you use the sleep verb you sleep for longer, but don't heal any more than you would normally. If you use sleep-toggle it takes you longer to wake up."
	conflicts = list(
		/datum/quirk/nosleep,
	)
	mob_trait = TRAIT_HEAVY_SLEEPER
	gain_text = span_danger("You feel sleepy.")
	lose_text = span_notice("You feel awake again.")
	medical_record_text = "Patient has abnormal sleep study results and is difficult to wake up."

/datum/quirk/brainproblems
	name = "Brain Tumor"
	desc = "You have a little friend in your brain that keeps growing back! Mannitol will keep it at bay, but it can't be cured!"
	value = -30 // Constant brain DoT until 75 brain damage. Brains have 200 health
	category = "Health Quirks"
	mechanics = "Your brain has a tumor that will grow quickly while it's small, but will slow down over time. \
				While not lethal in the scope of a single round, you will want to frequently take mannitol or \
				you will suffer frequent, debilitating debuffs."
	conflicts = list(

	)
	gain_text = span_danger("You feel smooth.")
	lose_text = span_notice("You feel wrinkled again.")
	medical_record_text = "Patient has a tumor in their brain that is slowly driving them to brain death."
	COOLDOWN_DECLARE(annoying_message)

/datum/quirk/brainproblems/on_process()
	//Deal fast brain damage at the start and ramp it down over time so it takes a long time to reach the cap.
	var/bdam = quirk_holder.getOrganLoss(ORGAN_SLOT_BRAIN)
	switch(bdam)
		if(0 to 25)
			quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.3)
		if(25 to 50)
			quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.25)
		if(50 to 75)
			quirk_holder.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.2)
	if((bdam > 25) && COOLDOWN_FINISHED(src, annoying_message))
		COOLDOWN_START(src, annoying_message, 3 MINUTES)
		to_chat(quirk_holder, span_danger("I really need some mannitol!"))

/datum/quirk/nearsighted //t. errorage
	name = "Nearsighted - Corrected"
	desc = "You are nearsighted without prescription glasses, but spawn with a pair."
	value = -11
	category = "Vision Quirks"
	mechanics = "Your vision is blurry at a distance, but you have glasses you spawn with that can fix that."
	conflicts = list(
		/datum/quirk/noglasses,
		/datum/quirk/badeyes,
		/datum/quirk/blindness,
	)
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
	desc = "You are nearsighted and without prescription glasses, you should find a pair."
	value = -15
	category = "Vision Quirks"
	mechanics = "Your vision is blurred, but you either never had or lost your glasses.  Good luck!"
	conflicts = list(
		/datum/quirk/nearsighted,
		/datum/quirk/badeyes,
		/datum/quirk/blindness,
	)
	gain_text = span_danger("Things far away from you start looking blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract nearsightedness."

/datum/quirk/noglasses/add()
	quirk_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/quirk/badeyes
	name = "Nearsighted - Trashed Vision"
	desc = "You are badly nearsighted without prescription glasses, so much so that it's kind of a miracle you're still alive. You defintiely don't have any corrective lenses, but they would help."
	value = -32
	category = "Vision Quirks"
	mechanics = "Bro your eyes are straight up having a bad time, your vision is absolutely recked and you have no immediate way of helping it."
	conflicts = list(
		/datum/quirk/nearsighted,
		/datum/quirk/noglasses,
		/datum/quirk/blindness,
	)
	gain_text = span_danger("Things far away from you start looking VERY blurry.")
	lose_text = span_notice("You start seeing faraway things normally again.")
	medical_record_text = "Patient requires prescription glasses in order to counteract sort of ridiculous levels of nearsightedness."

/datum/quirk/badeyes/add()
	quirk_holder.become_mega_nearsighted(ROUNDSTART_TRAIT)


/datum/quirk/nyctophobia
	name = "Phobia - The Dark"
	desc = "As far as you can remember, you've always been afraid of the dark. While in the dark without a light source, you instinctually act careful, and constantly feel a sense of dread."
	value = -11 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "You must walk carefully through dark areas and will feel a sense of panic when you do. Don't turn the lights out."
	conflicts = list(/datum/quirk/lightless)
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

/datum/quirk/lightless
	name = "Light Sensitivity"
	desc = "Bright lights irritate you. Your eyes start to water, your skin feels itchy against the photon radiation, and your hair gets dry and frizzy. Maybe it's a medical condition."
	value = -22
	category = "Vision Quirks"
	mechanics = "While in bright light without sunglasses, you get a negative moodlet and your eyes go blurry. Are you part molerat?"
	conflicts = list(/datum/quirk/nyctophobia)
	gain_text = span_danger("The light begins to hurt your eyes...")
	lose_text = span_notice("Your eyes no longer sting in the light.")
	medical_record_text = "Patient has acute light sensitivity, and insists it is physically harmful."

/datum/quirk/lightless/on_process()
	var/turf/T = get_turf(quirk_holder)
	var/lums = T.get_lumcount()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/sunglasses = H.get_item_by_slot(SLOT_GLASSES)

	if(lums >= 0.8) // Eyeblur for those ill prepared
		if(!istype(sunglasses, /obj/item/clothing) || sunglasses?.tint < 1)
			if(quirk_holder.eye_blurry < 10)
				quirk_holder.eye_blurry = 10
			SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "brightlight", /datum/mood_event/brightlight)
	if(lums >= 0.6) // Accuracy gets kicked in the teeth regardless of sunglasses. A bit stronger than regular poor aim. Also stacks.
		ADD_TRAIT(quirk_holder, TRAIT_LIGHT_SENSITIVITY, TRAIT_GENERIC)
	if(lums <= 0.6)
		REMOVE_TRAIT(quirk_holder, TRAIT_LIGHT_SENSITIVITY, TRAIT_GENERIC)

/datum/quirk/lightburning
	name = "Shadow Creature"
	desc = "You are a shadey creature! Bright lights burn you, the shadows mend you."
	value = -33 // This can kill you, which is extremely bad, and makes city play somewhat impossible
	category = "Health Quirks"
	mechanics = "While in the light, you slowly wither away, but the reverse happens in the dark, healing you and giving you nutrition."
	conflicts = list(/datum/quirk/nyctophobia)

/datum/quirk/lightburning/add()
	var/mob/living/carbon/human/H = quirk_holder
	H.AddElement(/datum/element/photosynthesis, 0.5, 0.5, 0.5, 0.5, 1, 0, 0.2, 0.2) // Set it a bit higher, since finding true dark areas (totally 0) is near impossible

/datum/quirk/lightburning/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.RemoveElement(/datum/element/photosynthesis, 0.5, 0.5, 0.5, 0.5, 1, 0, 0.2, 0.2)

/datum/quirk/nonviolent
	name = "Pacifist"
	desc = "The thought of violence makes you sick. So much so, in fact, that you can't hurt anyone."
	value = -65
	category = "Lifepath Quirks"
	mechanics = "You are mechanically stopped from hurting things, or throwing things that could."
	conflicts = list(
		/datum/quirk/nonviolent_lesser
	)
	mob_trait = TRAIT_PACIFISM
	gain_text = span_danger("You feel repulsed by the thought of violence!")
	lose_text = span_notice("You think you can defend yourself again.")
	medical_record_text = "Patient is unusually pacifistic and cannot bring themselves to cause physical harm."
	antag_removal_text = "Your antagonistic nature has caused you to renounce your pacifism."

/datum/quirk/nonviolent_lesser
	name = "Pacifist - Lesser"
	desc = "You think that hurting sapient living beings is wrong, but defending yourself from fauna is your goddamn American right."
	value = -35
	category = "Lifepath Quirks"
	mechanics = "You can hurt simplemobs, but in case you hurt a carbon you'll shake and temporarely be afraid of doing harm for little time."
	conflicts = list(
		/datum/quirk/nonviolent
	)
	mob_trait = TRAIT_PACIFISM_LESSER
	gain_text = span_danger("Hurting sapient creatures is wrong!")
	lose_text = span_notice("Actually... I think I like violence...")
	medical_record_text = "Patient cannot bring themselves to cause physical harm to sapient creatures."
	antag_removal_text = "Your antagonistic nature has caused you to renounce your pacifism and choose violence."

/datum/quirk/paraplegic
	name = "Paraplegic"
	desc = "Your legs do not function. Nothing will ever fix this. Luckily you found a wheelchair."
	value = -40
	category = "Health Quirks"
	mechanics = "Your legs just flat out don't work."
	conflicts = list(
		// /datum/quirk/soft_yards,
		// /datum/quirk/hard_yards,
		/datum/quirk/slower,
		/datum/quirk/slow,
	)
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
	value = -11
	category = "Ranged Quirks"
	mechanics = "Your accuracy degrades like crazy when moving, firing, or doing much of anything."
	conflicts = list(
		// /datum/quirk/deadeye,
		/datum/quirk/straightshooter
	)
	mob_trait = TRAIT_POOR_AIM
	medical_record_text = "Patient possesses a strong tremor in both hands."
	human_only = FALSE

/* Removed because it just sucks for RP. ~TK
/datum/quirk/prosopagnosia
	name = "Prosopagnosia"
	desc = "You have a mental disorder that prevents you from being able to recognize faces at all."
	value = -1
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_PROSOPAGNOSIA
	medical_record_text = "Patient suffers from prosopagnosia, and cannot recognize faces."


/datum/quirk/insanity
	name = "Reality Dissociation Syndrome"
	desc = "You suffer from a severe disorder that causes very vivid hallucinations. Mindbreaker toxin can suppress its effects, and you are immune to mindbreaker's hallucinogenic properties. <b>This is not a license to grief.</b>"
	value = -1
	category = ""
	mechanics = ""
	conflicts = list(

	)
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
*/

/datum/quirk/social_anxiety
	name = "Social Anxiety"
	desc = "Talking to people is very difficult for you, and you often stutter or even lock up."
	value = -22
	category = "Emotional Quirks"
	mechanics = "You stutter a lot, and make a bit of a mess of your sentences. Doesn't come with the bottom quirk for free."
	conflicts = list(
		/datum/quirk/apathetic,
	)
	gain_text = span_danger("You start worrying about what you're saying.")
	lose_text = span_notice("You feel easier about talking again.") //if only it were that easy!
	medical_record_text = "Patient is usually anxious in social encounters and prefers to avoid them."
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_EYECONTACT,PROC_REF(eye_contact))
	// RegisterSignal(quirk_holder, COMSIG_MOB_EXAMINATE,PROC_REF(looks_at_floor))

/datum/quirk/social_anxiety/remove()
	if(!quirk_holder)
		return // guy don't exist no more, therefore stop it.
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
	//	o_chat(H, span_danger("You retreat into yourself. You <i>really</i> don't feel up to talking."))
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

	addtimer(CALLBACK(usr, GLOBAL_PROC_REF(to_chat), quirk_holder, span_smallnotice("You make eye contact with [A].")), 3)
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
	addtimer(CALLBACK(usr, GLOBAL_PROC_REF(to_chat), quirk_holder, span_userdanger("[msg]")), 3) // so the examine signal has time to fire and this will print after
	return COMSIG_BLOCK_EYECONTACT

/datum/mood_event/anxiety_eyecontact
	description = span_warning("Sometimes eye contact makes me so nervous...")
	mood_change = -5
	timeout = 3 MINUTES

/datum/quirk/catphobia
	name = "Phobia - Cats"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with cats."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "You're scared of cats, dog."
	conflicts = list(
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_CATPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of catgirl paradise's creatures grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. You wish to go to catgirl paradise some day.")
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

/datum/quirk/ratphobia
	name = "Phobia - Rats"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with rats."
	value = -22 // Mostly experimental, with tweaks to how phobia works and accounting for how common the target phobia seems to be.
	category = "Phobia Quirks"
	mechanics = "You're scared of rats, cheesebag."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_RATPHOBIA
	gain_text = span_danger("You begin to tremble as you could hear in your head, \"Rats, rats, we're the rats.\nWe prey at night, we stalk at night, we're the rats.\" it echoes in your mind hauntingly.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. You're the giant rat now who makes all the rules.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/ratphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/rats, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/ratphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/rats, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/spiderphobia
	name = "Phobia - Spiders"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with spiders and other creepy crawlies."
	value = -22 // Mostly experimental, with tweaks to how phobia works and accounting for how common the target phobia seems to be.
	category = "Phobia Quirks"
	mechanics = "You're scared of spiders, check your shoes!"
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_SPIDERPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of eight legged monsters grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to spiders and insects."
	locked = FALSE

/datum/quirk/spiderphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/spiders, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/spiderphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/spiders, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/lizardphobia
	name = "Phobia - Lizards"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with lizards and reptiles."
	value = -22 // Mostly experimental, with tweaks to how phobia works and accounting for how common the target phobia seems to be.
	category = "Phobia Quirks"
	mechanics = "You're scared of lizards. I...  Yeah, you're scared of lizards."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_LIZARDPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of those scalie smooth brains grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. Now you can't help but giggle at the sounds of turtles moaning which had appeared in your head.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = FALSE

/datum/quirk/lizardphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/lizards, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/lizardphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/lizards, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/robotphobia
	name = "Phobia - Robots/Synths"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with robot or synthetics."
	value = -22 // Mostly experimental, with tweaks to how phobia works and accounting for how common the target phobia seems to be.
	category = "Phobia Quirks"
	mechanics = "You're scared of robots, time traveller."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_ROBOTPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of not understanding what x=x<<1 even means...Those robots are too scary to understand that, the fear grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. You've learnt bitshifting!")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to bitwise operations."
	locked = FALSE

/datum/quirk/robotphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/robots, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/robotphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/robots, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/birdphobia
	name = "Phobia - Birds"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with birds."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = ""
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_BIRDPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of winged dubious creatures grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. Bird up!")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to undefined stimuli."
	locked = FALSE

/datum/quirk/birdphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/birds, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/birdphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/birds, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/dogphobia
	name = "Phobia - Dogs"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with dogs."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "You're scared of dogs, cat."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
	mob_trait = TRAIT_DOGPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of loud bork borks, which grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you. Bork bork!")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to undefined stimuli."
	locked = FALSE

/datum/quirk/dogphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/dogs, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/dogphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/dogs, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/alienphobia
	name = "Phobia - Aliens"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with aliens."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "You're scared of aliens."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/maskphobia,
		/datum/quirk/eyephobia,
		/datum/quirk/dogphobia
	)
	mob_trait = TRAIT_ALIENPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of creatures from beyond your terrestrial comprehension.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you!")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to undefined stimuli."
	locked = FALSE

/datum/quirk/alienphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/aliens, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/alienphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/aliens, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/skelephobia
	name = "Phobia - Skeletons"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with bones."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "You really hate it when shit gets spooky."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/maskphobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
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
	name = "Phobia - Strangers" // Turns out this trait doesnt search for a mask, but if there's an 'unknown' or 'as unknown'. Which means, if someone's identity is hidden at all, it will trigger.
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with someone wearing a mask. You no longer feel comfortable around people whose face you cant see."
	value = -22 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "Chic chicy boom?  No thanks."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/alienphobia,
		/datum/quirk/eyephobia
	)
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

/*/datum/quirk/doctorphobia
	name = "Phobia - Doctors"
	desc = "You've had a traumatic past, one that has scarred you for life, and it had something to do with doctors."
	value = -33 // Refer to traumas.dm if balancing point values for phobias. If its too weak, it might be missing some triggers.
	category = "Phobia Quirks"
	mechanics = "Healthcare really is way too expensive these days."
	conflicts = list(

	)
	mob_trait = TRAIT_DOCTORPHOBIA
	gain_text = span_danger("You begin to tremble as an immeasurable fear of the doctors grips your mind.")
	lose_text = span_notice("Your confidence wipes away the fear that had been plaguing you.")
	medical_record_text = "Patient has an extreme or irrational fear and aversion to an undefined stimuli."
	locked = TRUE

/datum/quirk/doctorphobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/mild/phobia/doctors, TRAUMA_RESILIENCE_ABSOLUTE)*/

/datum/quirk/maskphobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/mild/phobia/doctors, TRAUMA_RESILIENCE_ABSOLUTE)

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
	value = -22
	category = "Phobia Quirks"
	mechanics = "You really hope they don't have their eyes on you."
	conflicts = list(
		/datum/quirk/catphobia,
		/datum/quirk/ratphobia,
		/datum/quirk/spiderphobia,
		/datum/quirk/lizardphobia,
		/datum/quirk/robotphobia,
		/datum/quirk/birdphobia,
		/datum/quirk/dogphobia,
		/datum/quirk/skelephobia,
		/datum/quirk/alienphobia
	)
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

/*
/datum/quirk/mute
	name = "Mute"
	desc = "Due to some accident, medical condition, or simply by choice, you are completely unable to speak."
	value = -35 //HALP MAINTS
	category = "Language Quirks"
	mechanics = "You can't talk, big surprise."
	conflicts = list(

	)
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
	value = -33
	category = "Emotional Quirks"
	mechanics = "This quirk stops you from recovering mood levels. Be very careful with it as it can tank your mood rapidly with negative traits like depressed."
	conflicts = list(
		/datum/quirk/apathetic,
	)
	mob_trait = TRAIT_UNSTABLE
	gain_text = span_danger("There's a lot on your mind right now.")
	lose_text = span_notice("Your mind finally feels calm.")
	medical_record_text = "Patient's mind is in a vulnerable state, and cannot recover from traumatic events."
*/

/datum/quirk/blindness
	name = "Blind"
	desc = "You are completely blind, nothing can counteract this."
	value = -42 // Since trashed vision's a step below this, it makes sense to up it by ten.
	category = "Vision Quirks"
	mechanics = "You can't see."
	conflicts = list(
		/datum/quirk/nearsighted,
		/datum/quirk/noglasses,
		/datum/quirk/badeyes,
	)
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

/datum/quirk/deafness
	name = "Deaf"
	desc = "You are completely deaf, nothing can counteract this."
	value = -40	//Kinda prevents you from RPing...
	category = "Vision Quirks" // earballs
	mechanics = "You can't hear."
	conflicts = list(

	)
	mob_trait = TRAIT_DEAF
	gain_text = span_danger("You can't hear anything.")
	lose_text = span_notice("You miraculously gain back your hearing.")
	medical_record_text = "Patient has permanent deafness."

/* No atmos lol
/datum/quirk/coldblooded
	name = "Cold-blooded"
	desc = "Your body doesn't create its own internal heat, requiring external heat regulation."
	value = -1
	category = ""
	mechanics = ""
	conflicts = list(

	)
	medical_record_text = "Patient is ectothermic."
	mob_trait = TRAIT_COLDBLOODED
	gain_text = span_notice("You feel cold-blooded.")
	lose_text = span_notice("You feel more warm-blooded.")
*/

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "You will become increasingly stressed when not in company of others, triggering panic reactions ranging from sickness to the shakes."
	value = -22 //Removed Heart attack, should be good now. :)
	category = "Emotional Quirks"
	mechanics = "You get negative moodlets for being alone, these can ramp up to be pretty awful. The good news is geckos and rats count as not being alone. The bad news is you're probably getting killed."
	conflicts = list(
		/datum/quirk/apathetic,
	)
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
	value = -22
	category = "Ranged Quirks"
	mechanics = "The good news is you can still use bows and slings. Not that anyone uses slings. :("
	conflicts = list(
	)
	mob_trait = TRAIT_CHUNKYFINGERS
	gain_text = span_notice("Your fingers feel... thick.")
	lose_text = span_notice("Your fingers feel normal again.")
	human_only = FALSE

/*
/datum/quirk/illiterate
	name = "Illiterate"
	desc = "You can't read nor write, plain and simple."
	value = 0
	category = "Lifepath Quirks"
	mechanics = "This is basicaly just a roleplaying quirk. It actually does basically nothing. If you find a skill book though, you can't read it. So congrats."
	conflicts = list(

	)
	mob_trait = TRAIT_ILLITERATE
	gain_text = span_notice("The knowledge of how to read seems to escape from you.")
	lose_text = "<span class='notice'>Written words suddenly make sense again."
*/

/datum/quirk/flimsy
	name = "Health - Flimsy"
	desc = "Your body is a little more fragile than most, decreasing total health a little."
	value = -18
	category = "Health Quirks"
	mechanics = "Your maximum hitpoints are reduced to 90%."
	conflicts = list(
		/datum/quirk/lifegiverplus,
		/datum/quirk/lifegiver,
		/datum/quirk/veryflimsy,
	)
	mob_trait = TRAIT_FLIMSY
	medical_record_text = "Patient is slightly less durable than average."
	gain_text = "<span class='notice'>You feel less durable than those around you."
	lose_text = "<span class='notice'>You start feeling as durable as your peers."
	human_only = FALSE

/datum/quirk/flimsy/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth -= 10
	H.health -= 10

/datum/quirk/veryflimsy
	name = "Health - Very Flimsy"
	desc = "Your body is a lot more fragile than most, decreasing total health a lot."
	value = -36
	category = "Health Quirks"
	mechanics = "Your maximum hitpoints are reduced to 80%."
	conflicts = list(
		/datum/quirk/lifegiverplus,
		/datum/quirk/lifegiver,
		/datum/quirk/flimsy,
	)
	mob_trait = TRAIT_VERYFLIMSY
	medical_record_text = "Patient is considerably less durable than average."
	gain_text = "<span class='notice'>You feel considerably less durable than those around you."
	lose_text = "<span class='notice'>You start feeling as durable as your peers."
	human_only = FALSE

/datum/quirk/veryflimsy/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth -= 20
	H.health -= 20

/datum/quirk/catastrophicflimsy
	name = "Health - Catastrophic"
	desc = "Your body is made of papermache, most attacks are serious."
	value = -55
	category = "Health Quirks"
	mechanics = "Your maximum hitpoints are reduced to 50%."
	conflicts = list(
		/datum/quirk/lifegiverplus,
		/datum/quirk/lifegiver,
		/datum/quirk/flimsy,
		/datum/quirk/veryflimsy,
	)
	mob_trait = TRAIT_VERYFLIMSY
	medical_record_text = "Patient is considerably less durable than average."
	gain_text = "<span class='notice'>You feel considerably less durable than those around you."
	lose_text = "<span class='notice'>You start feeling as durable as your peers."
	human_only = FALSE

/datum/quirk/catastrophicflimsy/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth -= 50
	H.health -= 50

/datum/quirk/fatalflimsy
	name = "Health - Fatal"
	desc = "Your body is made of sticks and twigs, rats are a serious threat. Single hits can be fatal"
	value = -77
	category = "Health Quirks"
	mechanics = "Your maximum hitpoints are reduced to 20 points above crit. Not for the faint of heart."
	conflicts = list(
		/datum/quirk/lifegiverplus,
		/datum/quirk/lifegiver,
		/datum/quirk/flimsy,
		/datum/quirk/veryflimsy,
		/datum/quirk/catastrophicflimsy
	)
	mob_trait = TRAIT_FATALFLIMSY
	medical_record_text = "Patient is considerably less durable than average."
	gain_text = "<span class='notice'>You feel considerably less durable than those around you."
	lose_text = "<span class='notice'>You start feeling as durable as your peers."
	human_only = FALSE

/datum/quirk/fatalflimsy/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.maxHealth -= 80
	H.health -= 80

/datum/quirk/weakpaintolerance
	name = "Pain Tolerance - Weak"
	desc = "Your pain tolerance is really low. Pain is a good thing, and keeps you out of serious danger."
	gain_text = span_danger("You feel wimpy...")
	lose_text = span_notice("You feel stronger.")
	value = -5
	category = "Health Quirks"
	mechanics = "You go into softcrit at 50 points of damage, but Your total health is unchanged. Good for new players"
	conflicts = list(/datum/quirk/fatalflimsy, /datum/quirk/catastrophicflimsy, /datum/quirk/veryweakpaintolerance)

/datum/quirk/weakpaintolerance/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.crit_threshold = 50

/datum/quirk/veryweakpaintolerance
	name = "Pain Tolerance - Very Weak"
	desc = "Your pain tolerance is incredibly low. Pain is a good thing, and keeps you out of serious danger, but this is annoying. Good for new players"
	gain_text = span_danger("You feel really wimpy...")
	lose_text = span_notice("You feel much stronger.")
	value = -15
	category = "Health Quirks"
	mechanics = "You go into crit at 20 points of damage, but your total health is unchanged. This includes all damage, include toxins from radiation, and oxygen from bloodloss"
	conflicts = list(/datum/quirk/fatalflimsy, /datum/quirk/catastrophicflimsy, /datum/quirk/veryflimsy, /datum/quirk/weakpaintolerance)

/datum/quirk/veryweakpaintolerance/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.crit_threshold = 80

/datum/quirk/extremelyweakpaintolerance
	name = "Pain Tolerance - Total Wimp"
	desc = "You don't know what pain is, because you pass out before you can experience it. Doesnt come with the bottom quirk for free"
	gain_text = span_danger(":point_up::nerd::speech_balloon:")
	lose_text = span_notice("You feel much stronger.")
	value = -30
	category = "Health Quirks"
	mechanics = "You go into crit at 1 point of damage, but your total health is unchanged. Radiation can paralyze you until treated and bloodloss oxygen damage is lethal."
	conflicts = list(/datum/quirk/fatalflimsy, /datum/quirk/catastrophicflimsy, /datum/quirk/veryflimsy, /datum/quirk/flimsy, /datum/quirk/weakpaintolerance)

/datum/quirk/extremelyweakpaintolerance/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.crit_threshold = 99



/datum/quirk/masked_mook
	name = "Masked Mook"
	desc = "For some reason you don't feel... Right without wearing some kind of mask. You will need to find one."
	gain_text = span_danger("You start feeling unwell without a mask on.")
	lose_text = span_notice("You no longer have a need to wear a mask.")
	value = -11
	category = "Emotional Quirks"
	mechanics = "You need to keep a mask on your face or else you get a negative moodlet."
	conflicts = list()
	mood_quirk = TRUE
	medical_record_text = "Patient feels more secure when wearing a mask."
	var/mood_category = "masked_mook"

/datum/quirk/masked_mook/on_process()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask = H.get_item_by_slot(SLOT_MASK)
	if(istype(mask))
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "masked_mook_incomplete")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "masked_mook", /datum/mood_event/masked_mook)
	else
		SEND_SIGNAL(quirk_holder, COMSIG_CLEAR_MOOD_EVENT, "masked_mook")
		SEND_SIGNAL(quirk_holder, COMSIG_ADD_MOOD_EVENT, "masked_mook_incomplete", /datum/mood_event/masked_mook_incomplete)


/* /datum/quirk/masked_mook/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/clothing/mask/gas = new(get_turf(quirk_holder))
	H.equip_to_slot(gas, SLOT_MASK)
	H.regenerate_icons()*/

/datum/quirk/easily_wounded
	name = "Easily Wounded"
	desc = "Your body just isn't that robust. Attacks your peers can shrug off will brutalise you."
	value = -25
	category = "Health Quirks"
	mechanics = "You are 25% more likely to receive wounds from attacks."	//Combination of the old paper skin & glass bones quirks.
	conflicts = list(

	)
	mob_trait = TRAIT_EASILY_WOUNDED
	gain_text = span_notice("Wounds feel especially fatal.")
	lose_text = span_notice("Taking a wound doesn't feel as fatal anymore.")
	medical_record_text = "Patient is vulnerable to wounding."

/datum/quirk/noodle_fist
	name = "Fists of Noodle"
	desc = "Your punching is legendary. Legendarily bad at doing anything to anyone."
	value = -11
	category = "Hand to Hand Quirks"
	mechanics = "Your punches do literally nothing."
	conflicts = list(
		/datum/quirk/nonviolent,
		/datum/quirk/iron_fist,
		/datum/quirk/steel_fist,
		/datum/quirk/mastermartialartist,
	)
	mob_trait = TRAIT_NOODLEFIST
	gain_text = span_notice("Your fists feel weak and worthless!")
	lose_text = span_danger("Your fists strong again.")
	locked = FALSE

/datum/quirk/noodle_fist/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.dna.species.punchdamagelow = 0
	H.dna.species.punchdamagehigh = 0

/datum/quirk/gentle
	name = "Melee - Gentle"
	desc = "Something about your strikes in melee is just... below average. You deal slightly less damage with melee weapons."
	value = -11
	category = "Melee Quirks"
	mechanics = "Your melee attacks do 5 less damage."
	conflicts = list(
		/datum/quirk/nonviolent,
		// /datum/quirk/bigleagues,
		// /datum/quirk/littleleagues,
		/datum/quirk/wimpy,
	)
	mob_trait = TRAIT_GENTLE
	gain_text = span_notice("You feel like you don't really like smacking stuff.")
	lose_text = span_danger("You feel like slapping the mess out of a gecko.")
	locked = FALSE
	human_only = FALSE

/datum/quirk/wimpy
	name = "Melee - Wimpy"
	desc = "For some reason you're just really bad at hitting things agianst things. Your melee damage is much lower than average."
	value = -22
	category = "Melee Quirks"
	mechanics = "Your melee attacks do 10 less damage."
	conflicts = list(
		/datum/quirk/nonviolent,
		// /datum/quirk/bigleagues,
		// /datum/quirk/littleleagues,
		/datum/quirk/gentle,
	)
	mob_trait = TRAIT_WIMPY
	gain_text = span_notice("You feel like smacking things is just a waste of time.")
	lose_text = span_danger("You feel like slapping the mess out of a Deathclaw!")
	locked = FALSE
	human_only = FALSE

/datum/quirk/slow
	name = "Mobility - Wasteland Slug"
	desc = "You've spent some time in the wastes, you don't get around great."
	value = -22 // Increasing htese because the slowdown is for everything but grass, road, and manmade tiles.
	category = "Movement Quirks"
	mechanics = "Slows you down a fair deal if you're going off roads and normal paths."
	conflicts = list(
		// /datum/quirk/soft_yards,
		// /datum/quirk/hard_yards,
		/datum/quirk/slower,
		/datum/quirk/paraplegic,
	)
	mob_trait = TRAIT_SLUG
	gain_text = span_notice("Rain or shine, you might get there eventually.")
	lose_text = span_danger("Your gait feels a little more sure!")
	locked = FALSE

/datum/quirk/slower
	name = "Mobility - Wasteland Molasses"
	desc = "You don't get around well off road. Like. At all."
	value = -33 // Increasing htese because the slowdown is for everything but grass, road, and manmade tiles.
	category = "Movement Quirks"
	mechanics = "Slows you down a lot if you go off roads and normal paths."
	conflicts = list(
		// /datum/quirk/soft_yards,
		// /datum/quirk/hard_yards,
		/datum/quirk/slow,
		/datum/quirk/paraplegic,
	)
	mob_trait = TRAIT_SLOWAF
	gain_text = span_notice("You feel like staying at home.")
	lose_text = span_danger("Wow! You feel like you could run around the whole WORLD!")
	locked = FALSE

/datum/quirk/clumsy
	name = "Clumsy"
	desc = "You're very clumsy, it's kind of a miracle you're alive at all really."
	value = -32
	category = "Lifepath Quirks"
	mechanics = "This is the clown quirk for those who know. You shoot yourself in the foot, drop live grenades, beat yourself with stun batons and quarterstaffs. It's pretty terrible!"
	conflicts = list(

	)
	mob_trait = TRAIT_CLUMSY
	gain_text = span_notice("You feel really... awkward?")
	lose_text = span_danger("Your composure seems to return to you.")
	locked = FALSE
	human_only = FALSE

/datum/quirk/dumb
	name = "Dumb"
	desc = "You're, well.  Just kind of stupid."
	value = -22
	category = "Lifepath Quirks"
	mechanics = "Dumb doesn't do much by itself, but it does lock you out of quite a few other quirks that require a character that needs some thinkmeat wrinkles."
	conflicts = list(

	)
	mob_trait = TRAIT_DUMB
	gain_text = span_notice("You brain just about shuts off, and for the first time in your life you feel truly free.")
	lose_text = span_danger("Your brain turns back on, and you remember that Taxes are a thing.")
	locked = FALSE
	human_only = FALSE

/datum/quirk/primitive
	name = "Primitive"
	desc = "You were raised in a barn, by monkeys. Or so it may seem to others. Lacking the ability to use guns, or any sort of advanced tools you've still managed to survive, and you're probably hot to boot."
	value = -22
	category = "Lifepath Quirks"
	mechanics = "This is the monkey quirk for those in the know, it makes you unable to use guns, PDAs, and many machines."
	conflicts = list(

	)
	mob_trait = TRAIT_MONKEYLIKE
	gain_text = span_notice("yOu reTurN tO MonKE")
	lose_text = span_danger("I think, there for... I am?")
	locked = FALSE
	human_only = FALSE

/datum/quirk/nosleep
	name = "Can Not Sleep"
	desc = "For whatever reason you literally lack the ability to sleep."
	value = -33 // Increased by ten after observing people with it dying far more often than normal. Might be a skill issue, we'll see how it feels.
	category = "Lifepath Quirks"
	mechanics = "You can't sleep. Why is this serious?  We have sleep healing."
	conflicts = list(
		/datum/quirk/heavy_sleeper,
	)
	mob_trait = TRAIT_SLEEPIMMUNE
	gain_text = span_notice("You feel like you'll never need to sleep again, for real!")
	lose_text = span_danger("You could kind of go for a nap.")
	locked = FALSE

/* Removed because not fucking fun ~TK
/datum/quirk/garbledspeach
	name = "Unintelligible Speech"
	desc = "You are so far beyond tongue tied."
	value = -2
	category = ""
	mechanics = ""
	conflicts = list(

	)
	mob_trait = TRAIT_UNINTELLIGIBLE_SPEECH
	gain_text = span_notice("Your tongue just sort of stops working!")
	lose_text = span_danger("You can find your words again.")
	locked = FALSE
*/

/datum/quirk/cantrun
	name = "Mobility - Can not Run"
	desc = "For whatever reason you just can't muster up the go to run."
	value = -44 // Upped because its perma walk. Just as bad as wasteland molasses, and they both get to stack. :>
	category = "Movement Quirks"
	mechanics = "Yeah, pretty self explanitory."
	conflicts = list(
		/datum/quirk/super_zoomies,
		/datum/quirk/zoomies,
	)
	mob_trait = TRAIT_NORUNNING
	gain_text = span_notice("Running just isnt' worth the effort!")
	lose_text = span_danger("You really feel like running all of a sudden!")
	locked = FALSE

/datum/quirk/cantrun/on_spawn()
	var/mob/living/L = quirk_holder
	L.toggle_move_intent()

/datum/quirk/luddite
	name = "Luddite"
	desc = "You forgo some technology, like autolathes and some other machinery."
	value = -22
	category = "Lifepath Quirks"
	mechanics = "You can't use some machines like ammo benches. You can still use autolathes though."
	conflicts = list(

	)
	mob_trait = TRAIT_TECHNOPHOBE
	gain_text = span_notice("All my homies hate machines.")
	lose_text = span_danger("Maybe industrial society isn't so bad...")
	locked =  FALSE
	human_only = FALSE

/datum/quirk/nodrugs
	name = "Clean Veins"
	desc = "Your body reacts violently to street drugs. Medicines work... for the most part."
	value = -22
	category = "Health Quirks"
	mechanics = "Drugs of many sorts, including tabacco products, make you violently ill."
	conflicts = list(

	)
	mob_trait = TRAIT_NODRUGS
	gain_text = span_notice("You feel like a winner!")
	lose_text = span_danger("You feel like a loser!")
	locked =  FALSE

/datum/quirk/hardcore
	name = "Hardcore"
	desc = "You are confident enough in your skills that you don't need a second wind! Second wind will be disabled for you, \
		and the only way you'll be able to live again is if someone finds and revives your body or a spirit takes mercy on you!"
	value = -34
	category = "Lifepath Quirks"
	mechanics = "You lose access to the Second Wind function. This is important there's almost never medical staff. Tread lightly, waster."
	conflicts = list(

	)
	mob_trait = TRAIT_NO_SECOND_WIND
	gain_text = span_boldannounce("You have opted out of Second Wind! If you die, you will not be able to revive yourself! \
		The spirits may be merciful, better hope they are in a good mood!")
	lose_text = span_notice("You are no longer opted out of Second Wind! If you die, you will be able to revive yourself!")
	locked =  FALSE

/datum/quirk/armor_aversion
	name = "Armor Aversion"
	desc = "For a reason or another, you're unable to wear medium or heavy armour"
	value = -35
	category = "Functional Quirks"
	mechanics = "You can't wear any armor, only clothing."
	conflicts = list(
		/datum/quirk/pa_wear
	)
	mob_trait = TRAIT_NO_MED_HVY_ARMOR
	gain_text = span_boldannounce("You really don't like to feel encumbered.")
	lose_text = span_notice("You don't mind feeling encumbered too much anymore.")
	locked =  FALSE

/datum/quirk/weak_of_muscles
	name = "Weak of Muscles"
	desc = "For a reason or another, you're unable to lift objects bigger than normal size "
	value = -50  //it's really a big drawback
	category = "Functional Quirks"
	mechanics = "You're only capable of lifting up objects that have weight class equal or smaller than normal. Anything heavier will be impossible for you to lift up, \
				with some core item exceptions. (This is a WIP quirk, feel free to ping us if we forgot to whitelist any core item)."
	conflicts = list(
	)
	mob_trait = TRAIT_WEAK_OF_MUSCLES
	gain_text = span_danger("Your arms feel really tired...")
	lose_text = span_notice("Your arms are invigorated!")
	medical_record_text = "Patient has an exceptionally weak muscolar system."
	antag_removal_text = "Your antagonistic nature gave back the strength you deserved!"

/*
/datum/quirk/bruteweak
	name = "Brute Weakness, Minor"
	desc = "You're weaker to physical trauma than others."
	mob_trait = TRAIT_BRUTEWEAK
	value = -22
	category = "Health Quirks"
	mechanics = "You take 10% more brute damage."
	conflicts = list(
		/datum/quirk/bruteresist,
		/datum/quirk/bruteresistmajor,
		/datum/quirk/bruteweakmajor,
		/datum/quirk/bruteweakfatal
		)

/datum/quirk/bruteweak/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1.1

/datum/quirk/bruteweak/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1

/datum/quirk/bruteweakmajor
	name = "Brute Weakness, Major"
	desc = "You're even weaker to physical trauma than others. Paper tiger!"
	mob_trait = TRAIT_BRUTEWEAKMAJOR
	value = -44
	category = "Health Quirks"
	mechanics = "You take 20% more brute damage."
	conflicts = list(
		/datum/quirk/bruteresist,
		/datum/quirk/bruteresistmajor,
		/datum/quirk/bruteweak,
		/datum/quirk/bruteweakfatal
		)

/datum/quirk/bruteweakmajor/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1.2

/datum/quirk/bruteweakmajor/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1

/datum/quirk/bruteweakfatal
	name = "Brute Weakness, Fatal"
	desc = "You're fatally weak to physical trauma than others. Paper tiger!"
	mob_trait = TRAIT_BRUTEWEAKFATAL
	value = -66
	category = "Health Quirks"
	mechanics = "You take 50% more brute damage."
	conflicts = list(
		/datum/quirk/bruteresist,
		/datum/quirk/bruteresistmajor,
		/datum/quirk/bruteweak
		)

/datum/quirk/bruteweakfatal/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1.5

/datum/quirk/bruteweakfatal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.brutemod = 1

/datum/quirk/burnweak
	name = "Burn Weakness, Minor"
	desc = "You're weaker to burns than others."
	mob_trait = TRAIT_BURNWEAK
	value = -22
	category = "Health Quirks"
	mechanics = "You take 10% more burn damage."
	conflicts = list(
		/datum/quirk/burnresist,
		/datum/quirk/burnresistmajor,
		/datum/quirk/burnweakmajor,
		/datum/quirk/burnweakfatal
)

/datum/quirk/burnweak/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1.1

/datum/quirk/burnweak/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1

/datum/quirk/burnweakmajor
	name = "Burn Weakness, Major"
	desc = "You're even weaker to burns than others. Your skin is kindling!"
	mob_trait = TRAIT_BURNWEAKMAJOR
	value = -44
	category = "Health Quirks"
	mechanics = "You take 20% more burn damage."
	conflicts = list(
		/datum/quirk/burnresist,
		/datum/quirk/burnresistmajor,
		/datum/quirk/burnweak,
		/datum/quirk/burnweakfatal
)

/datum/quirk/burnweakmajor/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1.2

/datum/quirk/burnweakmajor/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1

/datum/quirk/burnweakfatal
	name = "Burn Weakness, Fatal"
	desc = "You're fatally weak to burns. Your skin is kindling!"
	mob_trait = TRAIT_BURNWEAKMAJOR
	value = -66
	category = "Health Quirks"
	mechanics = "You take 50% more burn damage."
	conflicts = list(
		/datum/quirk/burnresist,
		/datum/quirk/burnresistmajor,
		/datum/quirk/burnweak
)

/datum/quirk/burnweakfatal/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1.5

/datum/quirk/burnweakfatal/remove()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.burnmod = 1
*/

/datum/quirk/radweakmajor
	name = "Radiation Weakness, Major"
	desc = "Gieger Counter? Better pack one. Seriously"
	value = -55
	category = "Radiation Quirks"
	mechanics = "You absorb 100% more radiation."
	conflicts = list(
		// /datum/quirk/radimmunesorta,
		// /datum/quirk/radimmuneish,
		/datum/quirk/radweak
	)
	mob_trait = TRAIT_100_RAD_WEAK
	locked =  FALSE

/datum/quirk/radweak
	name = "Radiation Weakness, Minor"
	desc = "You more likely to die than get superpowers from radiation."
	value = -22
	category = "Radiation Quirks"
	mechanics = "You absorb 50% more radiation"
	conflicts = list(
		// /datum/quirk/radimmunesorta,
		// /datum/quirk/radimmuneish,
		/datum/quirk/radweakmajor
	)
	mob_trait = TRAIT_50_RAD_WEAK
	locked =  FALSE

/datum/quirk/toxinlover
	name = "Toxin Inversion"
	desc = "Your biology is hyperadapted to toxins to the point where you process them the opposite of any normal organic, \
		Magic will actively harm you, and taking this as a syntheric forfiets your right to life(Dont). This quirk is not for the faint of heart as you will usually end up RR'ed if dead to toxins."
	value = -34
	category = "Health Quirks"
	mechanics = "You heal and regenerate toxin damage from toxic chemicals, but are harmed by anything that would normally fix toxin damage. With the existance of mages and the hunting horn, this is a burden to bare."
	conflicts = list(

	)
	mob_trait = TRAIT_TOXINLOVER
	gain_text = span_boldannounce("You have opted to take the toxinlover system of damage, your toxin damage will be an inverse of normal, with most hazardous chemicals being beneficial, while healing medicine and magic quickly killing you. Be careful around mages and charcoal.")
	lose_text = span_notice("You are now operating under normal toxin damage systems.")
	locked =  FALSE
