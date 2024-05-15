//fallout teas

/datum/reagent/consumable/tea/agavetea
	name = "Agave Tea"
	description = "A soothing herbal rememedy steeped from the Agave Plant. Inhibits increased healing of burns and sores."
	color = "#FFFF91"
	nutriment_factor = 0
	taste_description = "bitterness"
	glass_icon_state = "tea"
	glass_name = "Agave Tea"
	glass_desc = "A soothing herbal rememedy steeped from the Agave Plant. Inhibits increased healing of burns and sores."

/datum/reagent/consumable/tea/agavetea/on_mob_life(mob/living/carbon/M)
	M.adjustFireLoss(-3*REM, 0)
	M.nutrition = max(M.nutrition - 3, 0)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/broctea
	name = "Broc Tea"
	description = "A soothing herbal rememedy steeped from the Broc Flower. Increases the clearance and flow of airways."
	color = "#FF6347"
	nutriment_factor = 0
	taste_description = "bitterness"
	glass_icon_state = "tea"
	glass_name = "Broc Tea"
	glass_desc = "A soothing herbal rememedy steeped from the Broc Flower. Increases the clearance and flow of airways."

/datum/reagent/consumable/tea/broctea/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-4*REM, 0)
	M.nutrition = max(M.nutrition - 3, 0)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/coyotetea
	name = "Coyote Tea"
	description = "A smokey herbal rememedy steeped from coyote tobacco stems. Natural caffeines keep the drinker alert and awake while numbing the senses."
	color = "#008000"
	nutriment_factor = 0
	taste_description = "smoke"
	glass_icon_state = "tea"
	glass_name = "Coyote Tea"
	glass_desc = "A smokey herbal rememedy steeped from coyote tobacco stems. Natural caffeines keep the drinker alert and awake while numbing the senses."

/datum/reagent/consumable/tea/coyotetea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		var/smoke_message = pick("You feel relaxed.", "You feel calmed.","You feel alert.","You feel rugged.")
		to_chat(M, span_notice("[smoke_message]"))
	M.AdjustStun(-40, 0)
	M.AdjustKnockdown(-40, 0)
	M.AdjustUnconscious(-40, 0)
	M.adjustStaminaLoss(-1*REM, 0)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/feratea
	name = "Barrel Tea"
	description = "A sour and dry rememedy steeped from barrel cactus fruit. Detoxifies the user through natural filteration and dehydration."
	color = "#FF6347"
	nutriment_factor = 0
	taste_description = "bitterness"
	glass_icon_state = "tea"
	glass_name = "Barrel Tea"
	glass_desc = "A sour and dry rememedy steeped from barrel cactus fruit. Detoxifies the user through natural filteration and dehydration."

/datum/reagent/consumable/tea/feratea/on_mob_life(mob/living/carbon/M)
	if(prob(80))
		M.Dizzy(-2)
		M.Jitter(-2)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R != src)
			M.reagents.remove_reagent(R.type,2.5)
	if(M.health > 20)
		M.adjustToxLoss(-3*REM, 0)
		. = TRUE
	M.radiation += 0.1
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/pricklytea
	name = "Prickly Tea"
	description = "A sweet and fruity rememedy steeped from prickly pear fruit. Keeps you on edge."
	color = "#FF6347"
	nutriment_factor = 0
	taste_description = "sweetness"
	glass_icon_state = "cafe_latte"
	glass_name = "Prickly Tea"
	glass_desc = "A sweet and fruity rememedy steeped from prickly pear fruit. Keeps you on edge."

/datum/reagent/consumable/tea/pricklytea/on_mob_life(mob/living/carbon/M)
	if(prob(33))
		M.Dizzy(2)
		M.Jitter(2)
	..()
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/xandertea
	name = "Xander Tea"
	description = "A engaging herbal rememedy steeped from blitzed Xander root. Detoxifies and replenishes the bodies blood supply."
	color = "#FF6347"
	nutriment_factor = 0
	taste_description = "earthy"
	glass_icon_state = "coffee"
	glass_name = "Xander Tea"
	glass_desc = "A engaging herbal rememedy steeped from blitzed Xander root. Detoxifies and replenishes the bodies blood supply."
	effective_blood_max = 400
	effective_blood_multiplier = 10

/datum/reagent/consumable/tea/xandertea/on_mob_life(mob/living/carbon/M)
	if(M.get_blood(TRUE) < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(BLOOD_VOLUME_NORMAL, M.blood_volume + 1)
	M.adjustToxLoss(-4*REM, 0)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.jitteriness = max(0,M.jitteriness-3)
	M.AdjustSleeping(-20, FALSE)
	if(M.getToxLoss() && prob(20))
		M.adjustToxLoss(-1, 0)
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/tea/fever_blossom_tea
	name = "Passion Tea"
	description = "A pleasant tea steeped from fever blossom petals. It yields an earthy, subtle flavor while relaxing the senses."
	color = "#e380ff" //a light purple
	nutriment_factor = 0
	taste_description = "subtle warmth"
	glass_icon_state = "blossomtea"
	glass_name = "Passion Tea"
	glass_desc = "A pleasant tea steeped from fever blossom petals. It yields an earthy, subtle flavor while relaxing the senses."

/datum/reagent/consumable/tea/fever_blossom_tea/on_mob_life(mob/living/carbon/M)
	if(prob(10))
		var/blossom_message = pick("You feel relaxed.", "You feel calmed.","You feel sensual.","You feel warm.")
		to_chat(M, span_notice("[blossom_message]"))
	M.dizziness = max(0,M.dizziness-2)
	M.jitteriness = max(0,M.jitteriness-2)
	M.drowsyness += 1
	M.adjust_bodytemperature(20 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()
	. = TRUE
