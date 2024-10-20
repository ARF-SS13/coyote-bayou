/datum/reagent/drug/jet
	name = "Staminup Inhalant"
	description = "A chemical used to induce a euphoric high derived from brahmin dung."
	color = "#60A584" // rgb: 96, 165, 132
	overdose_threshold = 200
	addiction_threshold = 200
	ghoulfriendly = TRUE

/datum/reagent/drug/jet/on_mob_add(mob/living/carbon/human/M)
	..()
	if(isliving(M))
		if(NODRUGS(M))
			to_chat(M, span_userdanger("Jet-- but doesn't that come from-- OH SHIT???!"))
		else
			to_chat(M, span_notice("You feel an incredible high! You just absolutely love life in this moment!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "jet euphoria", /datum/mood_event/jet_euphoria, name)

/datum/reagent/drug/jet/on_mob_delete(mob/living/carbon/human/M)
	..()
	if(isliving(M) && !NODRUGS(M))
		to_chat(M, span_notice("You come down from your high. The wild ride is unfortunately over..."))
		M.confused += 2
	SEND_SIGNAL(M, COMSIG_CLEAR_MOOD_EVENT, "jet euphoria")

/datum/reagent/drug/jet/on_mob_life(mob/living/carbon/M)
	if(dont_do_drugs(M))
		. = TRUE
		..()
		return
	M.adjustStaminaLoss(-20*REM, 0)
	M.set_drugginess(20*REM)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !isspaceturf(M.loc) && prob(10))
		step(M, pick(GLOB.cardinals))
	if(prob(12))
		M.emote(pick("twitch","drool","moan","giggle"))
	if(M.mind)
		var/datum/job/job = SSjob.GetJob(M.mind.assigned_role)
		if(istype(job))
			switch(job.faction)
				if(FACTION_NCR, FACTION_ENCLAVE, FACTION_BROTHERHOOD)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "used drugs", /datum/mood_event/used_drugs, name)
				if(FACTION_LEGION)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "betrayed caesar", /datum/mood_event/betrayed_caesar, name)
	..()
	. = TRUE

/datum/reagent/drug/jet/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("You start tripping hard!"))
	SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "[type]_overdose", /datum/mood_event/overdose, name)

/datum/reagent/drug/jet/overdose_process(mob/living/M)
	if(M.hallucination < volume && prob(20))
		M.hallucination += 10
		M.adjustToxLoss(10, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 60)
	..()

/datum/reagent/drug/jet/addiction_act_stage1(mob/living/M)
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/jet/addiction_act_stage2(mob/living/M)
	M.Dizzy(5)
	M.adjustToxLoss(1, 0)
	if(prob(30))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/jet/addiction_act_stage3(mob/living/M)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 4, i++)
			step(M, pick(GLOB.cardinals))
	M.adjustToxLoss(3, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	M.set_disgust(60)
	M.Dizzy(10)
	if(prob(40))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/jet/addiction_act_stage4(mob/living/carbon/human/M)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.adjustToxLoss(5, 0)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	M.set_disgust(100)
	M.Dizzy(15)
	if(prob(50))
		M.emote(pick("twitch","drool","moan"))
	..()
	. = TRUE

/datum/reagent/drug/turbo
	name = "Speedster Inhalant"
	description = "A chemical compound that, when inhaled, vastly increases the user's reflexes and slows their perception of time."
	reagent_state = LIQUID
	color = "#FAFAFA"
	overdose_threshold = 200
	addiction_threshold = 200
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	ghoulfriendly = TRUE

/datum/reagent/drug/turbo/on_mob_add(mob/M)
	..()
	if(NODRUGS(M))
		to_chat(M, span_userdanger("What a horrible feeling!"))
		return
	ADD_TRAIT(M, TRAIT_IGNOREDAMAGESLOWDOWN, "[type]")

/datum/reagent/drug/turbo/on_mob_delete(mob/M)
	REMOVE_TRAIT(M, TRAIT_IGNOREDAMAGESLOWDOWN, "[type]")
	..()

/datum/reagent/drug/turbo/on_mob_life(mob/living/carbon/M)
	if(dont_do_drugs(M))
		. = TRUE
		..()
		return
	var/high_message = pick("You feel hyper.", "You feel like you need to go faster.", "You feel like you can run the world.")
	if(prob(5))
		to_chat(M, span_notice("[high_message]"))
	M.Jitter(2*REM)
	if(prob(5))
		M.emote(pick("twitch", "shiver"))
	if(M.mind)
		var/datum/job/job = SSjob.GetJob(M.mind.assigned_role)
		if(istype(job))
			switch(job.faction)
				if(FACTION_NCR, FACTION_ENCLAVE, FACTION_BROTHERHOOD)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "used drugs", /datum/mood_event/used_drugs, name)
				if(FACTION_LEGION)
					SEND_SIGNAL(M, COMSIG_ADD_MOOD_EVENT, "betrayed caesar", /datum/mood_event/betrayed_caesar, name)
	..()
	. = TRUE

/datum/reagent/drug/turbo/overdose_process(mob/living/M)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i in 1 to 4)
			step(M, pick(GLOB.cardinals))
	if(prob(20))
		M.emote("laugh")
	if(prob(33))
		M.visible_message(span_danger("[M]'s hands flip out and flail everywhere!"))
		M.drop_all_held_items()
	..()
	M.adjustToxLoss(2, 0)
	. = TRUE

/datum/reagent/drug/turbo/addiction_act_stage1(mob/living/M)
	M.Jitter(5)
	if(prob(20))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/turbo/addiction_act_stage2(mob/living/M)
	M.Jitter(10)
	M.Dizzy(10)
	if(prob(30))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/turbo/addiction_act_stage3(mob/living/M)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 4, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(15)
	M.Dizzy(15)
	if(prob(40))
		M.emote(pick("twitch","drool","moan"))
	..()

/datum/reagent/drug/turbo/addiction_act_stage4(mob/living/carbon/human/M)
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(20)
	M.Dizzy(20)
	M.adjustToxLoss(6, 0)
	if(prob(50))
		M.emote(pick("twitch","drool","moan"))
	..()
	. = TRUE

/datum/reagent/drug/psycho
	name = "Berserk Fluid"
	description = "Makes the user hit harder and shrug off slight stuns."
	reagent_state = LIQUID
	color = "#FF0000"
	overdose_threshold = 200
	addiction_threshold = 200
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/rage
	ghoulfriendly = TRUE


/datum/reagent/drug/psycho/on_mob_life(mob/living/carbon/M)
	if(dont_do_drugs(M))
		. = TRUE
		..()
		return
	var/high_message = pick("<br><font color='#FF0000'><b>FUCKING KILL!</b></font>", "<br><font color='#FF0000'><b>RAAAAR!</b></font>", "<br><font color='#FF0000'><b>BRING IT!</b></font>")
	if(prob(20))
		to_chat(M, span_notice("[high_message]"))
	M.AdjustStun(-25*REM, 0)
	M.AdjustKnockdown(-25*REM, 0)
	M.AdjustUnconscious(-25*REM, 0)
	M.Jitter(2*REM)
	..()
	. = TRUE

/datum/reagent/drug/psycho/on_mob_add(mob/living/L)
	..()
	ADD_TRAIT(L, TRAIT_SLEEPIMMUNE, "[type]")
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/reagent/drug/psycho/on_mob_delete(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_SLEEPIMMUNE, "[type]")
	if(rage)
		QDEL_NULL(rage)
	..()

/datum/reagent/drug/psycho/overdose_process(mob/living/carbon/human/M)
	M.hallucination += 20
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 8, i++)
			step(M, pick(GLOB.cardinals))
	if(prob(20))
		M.emote(pick("twitch","scream","laugh"))
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	M.set_heartattack(TRUE)
	M.visible_message(span_userdanger("[M] clutches at their chest as if their heart stopped!"))
	to_chat(M, span_danger("Your vision goes black and your heart stops beating as the amount of drugs in your system shut down your organs one by one. Say hello to Elvis in the afterlife. "))
	..()
	return TRUE

/datum/reagent/drug/psycho/addiction_act_stage1(mob/living/M)
	M.hallucination += 10
	M.Jitter(5)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	if(prob(20))
		M.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/drug/psycho/addiction_act_stage2(mob/living/M)
	M.hallucination += 20
	M.Jitter(10)
	M.Dizzy(10)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 1)
	if(prob(30))
		M.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/drug/psycho/addiction_act_stage3(mob/living/M)
	M.hallucination += 30
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 2, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(15)
	M.Dizzy(15)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	if(prob(40))
		M.emote(pick("twitch","scream","laugh"))
	..()
	return
/datum/reagent/drug/psycho/addiction_act_stage4(mob/living/carbon/human/M)
	M.hallucination += 40
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !ismovableatom(M.loc) && !isspaceturf(M.loc))
		for(var/i = 0, i < 4, i++)
			step(M, pick(GLOB.cardinals))
	M.Jitter(50)
	M.Dizzy(50)
	M.adjustToxLoss(5)
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 15)
	if(prob(50))
		M.emote(pick("twitch","scream","laugh"))
	..()
	return

/datum/reagent/drug/buffout
	name = "Beefup Powder"
	description = "A powerful steroid which increases the user's strength and endurance."
	color = "#FF9900"
	reagent_state = SOLID
	overdose_threshold = 200
	addiction_threshold = 200
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/rage
	ghoulfriendly = TRUE

/datum/reagent/drug/buffout/on_mob_add(mob/living/carbon/human/M)
	..()
	if(isliving(M))
		if(NODRUGS(M))
			to_chat(M, span_userdanger("Steriods have been linked to heart attacks and infertility! Oh no!"))
			return
		to_chat(M, span_notice("You feel stronger, and like you're able to endure more."))
		ADD_TRAIT(M, TRAIT_BUFFOUT_BUFF, "buffout")
		ADD_TRAIT(M, TRAIT_PERFECT_ATTACKER, "buffout")
		M.maxHealth += 25
		M.health += 25

/datum/reagent/drug/buffout/on_mob_delete(mob/living/carbon/human/M)
	..()
	if(isliving(M) && !NODRUGS(M))
		to_chat(M, span_notice("You feel weaker."))
		REMOVE_TRAIT(M, TRAIT_BUFFOUT_BUFF, "buffout")
		REMOVE_TRAIT(M, TRAIT_PERFECT_ATTACKER, "buffout")
		M.maxHealth -= 25
		M.health -= 25

/datum/reagent/drug/buffout/on_mob_life(mob/living/carbon/M)
	if(dont_do_drugs(M))
		. = TRUE
		..()
		return
	M.AdjustStun(-10*REM, 0)
	M.AdjustKnockdown(-10*REM, 0)
	..()
	. = TRUE

/datum/reagent/drug/buffout/overdose_process(mob/living/carbon/human/M)
	if(iscarbon(M))
		var/mob/living/carbon/C = M
		rage = new()
		C.gain_trauma(rage, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/disease/D = new /datum/disease/heart_failure
	M.ForceContractDisease(D)
	if(prob(33))
		M.visible_message(span_danger("[M]'s muscles spasm, making them drop what they were holding!"))
		M.drop_all_held_items()
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	..()

/datum/reagent/drug/buffout/addiction_act_stage1(mob/living/M)
	to_chat(M, span_notice("Your muscles ache slightly."))
	M.adjustBruteLoss(1.5)
	if(prob(15))
		M.emote(pick("twitch"))
	..()
	return

/datum/reagent/drug/buffout/addiction_act_stage2(mob/living/M)
	to_chat(M, span_notice("Your muscles feel incredibly sore."))
	M.adjustBruteLoss(4)
	if(prob(30))
		to_chat(M, span_notice("Your muscles spasm, making you drop what you were holding."))
		M.drop_all_held_items()
		M.emote(pick("twitch"))
	..()
	return

/datum/reagent/drug/buffout/addiction_act_stage3(mob/living/M)
	to_chat(M, span_notice("Your muscles start to hurt badly, and everything feels like it hurts more."))
	M.adjustBruteLoss(7.5)
	M.maxHealth -= 1.5
	M.health -= 1.5
	if(prob(50))
		to_chat(M, span_notice("Your muscles spasm, making you drop what you were holding. You're not even sure if you can control your arms!"))
		M.drop_all_held_items()
		M.emote(pick("twitch"))
	..()
	return

/datum/reagent/drug/buffout/addiction_act_stage4(mob/living/M)
	to_chat(M, span_danger("Your muscles are in incredible pain! When will it stop!?"))
	M.adjustBruteLoss(12.5)
	M.maxHealth -= 5
	M.health -= 5
	if(prob(90))
		to_chat(M, span_danger("You can't even keep control of your muscles anymore!"))
		M.drop_all_held_items()
		M.emote(pick("twitch"))
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !isspaceturf(M.loc) && prob(25))
		step(M, pick(GLOB.cardinals))
	M.adjustOrganLoss(ORGAN_SLOT_HEART, 20)
	..()
	return

/datum/reagent/drug/steady
	name = "Marksman Fluid"
	description = "A potent, stimulant which increases the user's accuracy."
	color = "#E0D532"
	reagent_state = LIQUID
	overdose_threshold = 200
	addiction_threshold = 200 //no more addicting on a single use
	metabolization_rate = 0.8 * REAGENTS_METABOLISM
	ghoulfriendly = TRUE

/datum/reagent/drug/steady/on_mob_add(mob/living/M)
	..()
	if(M)
		if(NODRUGS(M))
			to_chat(M, span_userdanger("But you were steady before! You feel TOO steady!"))
			return
		to_chat(M, span_notice("You feel your senses becoming sharper, your trigger finger moving instinctively."))
		ADD_TRAIT(M, SPREAD_CONTROL, "steady")

/datum/reagent/drug/steady/on_mob_delete(mob/living/M)
	..()
	if(M)
		to_chat(M, "You feel your aim going back to normal.")
		REMOVE_TRAIT(M, SPREAD_CONTROL, "steady")

/datum/reagent/drug/steady/overdose_process(mob/living/M)
	if(prob(33))
		M.visible_message(span_danger("[M]'s fingers twitch incontrollably, making them drop what they were holding!"))
		M.drop_all_held_items()
	M.adjustOrganLoss(ORGAN_SLOT_EYES, 2)
	..()

/datum/reagent/drug/steady/addiction_act_stage1(mob/living/M)
	if(prob(50))
		to_chat(M, span_notice("Your senses feel dull."))
	if(prob(15))
		M.emote(pick("twitch","blink"))
	M.Dizzy(5)
	..()
	return

/datum/reagent/drug/steady/addiction_act_stage2(mob/living/M)
	if(prob(50))
		to_chat(M, span_notice("Your senses seem to lag."))
	if(prob(30))
		M.emote(pick("twitch","blink"))
	M.Dizzy(10)
	..()
	return

/datum/reagent/drug/steady/addiction_act_stage3(mob/living/M)
	M.adjustToxLoss(2, 0)
	if(prob(50))
		to_chat(M, span_notice("You feel like a snail, your reaction times have slowed down to a crawl."))
	if(prob(50))
		M.emote(pick("twitch","blink"))
	M.Dizzy(15)
	..()
	return

/datum/reagent/drug/steady/addiction_act_stage4(mob/living/M)
	M.adjustToxLoss(2, 0)
	if(prob(50))
		to_chat(M, span_danger("Your hand-eye coordination is a thing of the past, even walking feels hard!"))
	if(prob(90))
		M.emote(pick("blink","twitch"))
	if(CHECK_MOBILITY(M, MOBILITY_MOVE) && !isspaceturf(M.loc) && prob(75))
		step(M, pick(GLOB.cardinals))
	M.Dizzy(30)
	..()
	return
