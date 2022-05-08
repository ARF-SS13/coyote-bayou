/* FEV diseases */
// Main code
/datum/disease/transformation/mutant
	name = "Forced Evolutionary Virus"
	cure_text = "mutadone."
	cures = list(/datum/reagent/medicine/mutadone)
	cure_chance = 5 // Good luck
	stage_prob = 10
	agent = "FEV-I toxin strain" // The unstable one.
	desc = "A megavirus, with a protein sheath reinforced by ionized hydrogen. This virus is capable of mutating the affected into something horrifying..."
	severity = DISEASE_SEVERITY_BIOHAZARD
	visibility_flags = NONE
	stage1 = list()
	stage2 = list()
	stage3 = list()
	stage4 = list()
	stage5 = list("<span class='danger'>You don't feel like yourself anymore!</span>")
	viable_mobtypes = list(/mob/living/carbon/human)
	new_form = /mob/living/simple_animal/hostile/centaur
	var/list/possible_forms = list(\
		/mob/living/simple_animal/hostile/centaur/strong = 4,
		/mob/living/simple_animal/hostile/abomination/weak = 3,
		/mob/living/simple_animal/hostile/ghoul/glowing/strong = 2,
		)

/datum/disease/transformation/mutant/do_disease_transformation(mob/living/affected_mob)
	new_form = pickweight(possible_forms)
	if(!ispath(new_form, /mob/living/carbon)) // If you've become simple_mob - you can't go and be all friendly to those around you!
		to_chat(affected_mob, "<big><span class='warning'><b>You've become something entirely different! You are being controlled only by your hunger and desire to kill!</b></span></big>")
	. = ..()

// FEV - I
/datum/disease/transformation/mutant/unstable/stage_act()
	..()

	affected_mob.adjustCloneLoss(-4,0) // Don't die while you are mutating.
	switch(stage)
		if(2)
			if (prob(8))
				to_chat(affected_mob, "<span class='danger'>You feel weird...</span>")
		if(3)
			if (prob(12))
				to_chat(affected_mob, "<span class='danger'>Your skin twitches...</span>")
				affected_mob.Jitter(3)
		if(4)
			if (prob(20))
				to_chat(affected_mob, "<span class='danger'>The pain is unbearable!</span>")
				affected_mob.emote("cry")
			if (prob(15))
				to_chat(affected_mob, "<span class='danger'>Your skin begins to shift, hurting like hell!</span>")
				affected_mob.emote("scream")
				affected_mob.Jitter(4)
			if (prob(6))
				to_chat(affected_mob, "<span class='danger'>Your body shuts down for a moment!</span>")
				affected_mob.Unconscious(10)

// FEV - II
/datum/disease/transformation/mutant/super
	agent = "FEV-II toxin strain" // The unstable one.
	desc = "A megavirus, with a protein sheath reinforced by ionized hydrogen. This variant has been mutated by radiation and will turn the affected person into something less horrifying."
	new_form = /mob/living/carbon/human/species/smutant
	possible_forms = list(/mob/living/carbon/human/species/smutant = 1)
	stage5 = list("<span class='reallybig hypnophrase'>Simple! Efficient! Glorious!</span>")

/datum/disease/transformation/mutant/super/stage_act()
	..()

	switch(stage)
		if(2)
			if (prob(8))
				to_chat(affected_mob, "<span class='danger'>You feel weird...</span>")
		if(3)
			if (prob(12))
				to_chat(affected_mob, "<span class='danger'>Your skin twitches...</span>")
				affected_mob.Jitter(3)
		if(4)
			if (prob(20))
				to_chat(affected_mob, "<span class='danger'>The pain is unbearable!</span>")
				affected_mob.emote("scream")
			if (prob(15))
				to_chat(affected_mob, "<span class='warning'>Your skin begins to shift, it hurts, but only for a moment..?</span>")
				affected_mob.emote("cry")
			if (prob(5))
				to_chat(affected_mob, "<span class='notice'>Simple, efficient, glorious...</span>")
				var/datum/component/mood/mood = affected_mob.GetComponent(/datum/component/mood)
				mood.setSanity(SANITY_INSANE) // You're happy, aren't you?

// FEV - Curling 13
/datum/disease/curling_thirteen
	form = "Virus"
	name = "Curling 13"
	desc = "A modified version of Forced Evolutionary Virus specifically engineered to kill every irradiated lifeform. The more radiation you have stored - the faster you'll die."
	max_stages = 5
	stage_prob = 100 // It's handled below
	spread_text = "Airborne"
	agent = "Forced Evolutionary Virus"
	viable_mobtypes = list(/mob/living/carbon/human)
	cure_text = "Mutadone, Haloperidol and Penicillin"
	cures = list(/datum/reagent/medicine/mutadone, /datum/reagent/medicine/haloperidol, /datum/reagent/medicine/spaceacillin)
	cure_chance = 8 // If you can gather all three - you deserve a somewhat of a good chance.
	severity = DISEASE_SEVERITY_BIOHAZARD

/datum/disease/curling_thirteen/update_stage(new_stage)
	if(new_stage > stage)
		var/radiation_prob = max(round(affected_mob.radiation * 0.05), 1) // 1000 rads will result in 50 chance
		var/new_stage_prob = min(radiation_prob, 50)
		if(prob(new_stage_prob))
			return ..()
		return
	return ..()

/datum/disease/curling_thirteen/stage_act()
	..()
	switch(stage)
		if(1) // Calm before the storm
			if(prob(1))
				to_chat(affected_mob, "<span class='warning'>You scratch at an itch.")
				affected_mob.adjustBruteLoss(1,0)
			if(prob(1))
				affected_mob.emote("cough")
		if(2)
			if(prob(2))
				to_chat(affected_mob, "<span class='warning'>You scratch at an itch.")
				affected_mob.adjustBruteLoss(3,0)
			if(prob(2))
				affected_mob.emote("cough")
				affected_mob.adjustOxyLoss(2)
				to_chat(affected_mob, "<span class='warning'>Your chest hurts.</span>")
			if(prob(4))
				to_chat(affected_mob, "<span class='warning'>You feel a cold sweat form.</span>")
		if(3)
			if(prob(2))
				to_chat(affected_mob, "<span class='danger'>You see four of everything...</span>")
				affected_mob.Dizzy(5)
			if(prob(3))
				to_chat(affected_mob, "<span class='danger'>You feel a sharp pain from your lower chest!</span>")
				affected_mob.adjustOxyLoss(6)
				affected_mob.emote("gasp")
			if(prob(3))
				to_chat(affected_mob, "<span class='danger'>It hurts like hell! Make it stop!")
				affected_mob.adjustBruteLoss(6,0)
			if(prob(3))
				affected_mob.vomit(10)
			if(prob(4))
				to_chat(affected_mob, "<span class='danger'>Your head feels dizzy...</span>")
				affected_mob.adjustStaminaLoss(10)
		if(4) // That's the part where you start dying
			if(prob(2))
				to_chat(affected_mob, "<span class='userdanger'>You feel as if your organs just exploded!</span>")
				affected_mob.playsound_local(affected_mob, 'sound/effects/singlebeat.ogg', 50, 0)
				affected_mob.blur_eyes(10)
				affected_mob.vomit(10, 1, 1, 0, 1, 1)
			if(prob(3))
				to_chat(affected_mob, "<span class='warning'>You should probably lie down for a moment...</span>")
				affected_mob.adjustStaminaLoss(30)
			if(prob(3))
				to_chat(affected_mob, "<span class='userdanger'>Your skin starts to rip apart!")
				affected_mob.adjustBruteLoss(10,0)
				affected_mob.emote("scream")
			if(prob(8))
				affected_mob.adjustToxLoss(2)
		if(5) // That's the part where you die for real
			var/datum/component/mood/mood = affected_mob.GetComponent(/datum/component/mood)
			mood.setSanity(SANITY_INSANE) // Who wouldn't be insane when they have 5 seconds left to live?
			if(prob(5))
				to_chat(affected_mob, "<span class='userdanger'>You feel as if all your organs just exploded!</span>")
				affected_mob.emote("scream")
				affected_mob.blur_eyes(5)
				affected_mob.vomit(50, 1, 1, 0, 1, 1)
			if(prob(7))
				to_chat(affected_mob, "<span class='userdanger'>Your skin keeps ripping itself apart!")
				affected_mob.adjustBruteLoss(15,0)
				affected_mob.emote("cry")
			if(prob(10))
				affected_mob.adjustToxLoss(5)
	return
