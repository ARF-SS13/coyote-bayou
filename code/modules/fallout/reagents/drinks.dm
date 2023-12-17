/datum/reagent/consumable/nuka_cola
	name = "Cosmic Cola"
	description = "Cola, cola never changes."
	color = "#100800" // rgb: 16, 8, 0
	taste_description = "the future"
	glass_icon_state = "nukacolaglass"
	glass_name = "Cosmic Cola"
	glass_desc = "Don't cry, Don't raise your eye, It's only nuclear wasteland."
	overdose_threshold = 100
	ghoulfriendly = TRUE
	sodie_tier = SODIE_TIER_1 // pretty dangerous too!
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_1, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_1, SODIE_HEALRANK_MED)

/datum/reagent/consumable/nuka_cola/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()

/datum/reagent/consumable/nuka_cola/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Too much Nuka-Cola! This cannot be good for you!"))
	M.AdjustSleeping(600, FALSE)
	. = 1

/datum/reagent/consumable/sunset
	name = "Sunset Sarsaparilla"
	description = "Build Mass With Sass!"
	color = "#994C00" // rgb: 153, 76, 0
	taste_description = "root beer, vanilla and caramel"
	glass_icon_state = "sunsetglass"
	glass_name = "glass of Sunset Sarsaparilla"
	glass_desc = "Beverage of the West Coast."
	ghoulfriendly = TRUE
	sodie_tier = SODIE_TIER_1 // pretty dangerous too!
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_1, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_1, SODIE_HEALRANK_MED)

/datum/reagent/consumable/sunset/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/vim
	name = "Vim"
	description = "You've Got Vim!"
	color = "#946B4A"
	taste_description = "off-brand Cosmic-cola"
	glass_icon_state = "vimglass"
	glass_name = "glass of Vim"
	glass_desc = "Unrelated to Cosmic-Cola, Vim trademark Circa 2077."
	ghoulfriendly = TRUE
	sodie_tier = SODIE_TIER_1 // pretty dangerous too!
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_1, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_1, SODIE_HEALRANK_MED)


/datum/reagent/consumable/vim/on_mob_life(mob/living/carbon/M)
	M.drowsyness = max(0,M.drowsyness-3)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	if(holder?.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 5)
	..()
	. = TRUE

/datum/reagent/consumable/vimquartz
	name = "Vim Quartz"
	description = "You've Got Vim! Quartz edition, worse than the Imitation."
	color = "#946B4A"
	taste_description = "off-brand Cosmic-cola but fucking worse"
	glass_icon_state = "vimquartzglass"
	glass_name = "Vim Quartz"
	glass_desc = "You've Got Vim! Quartz edition, worse than the Imitation."
	sodie_tier = SODIE_TIER_2 // Quartz! extra oxybrain heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)

/datum/reagent/consumable/vimquartz/on_mob_life(mob/living/carbon/M)
	M.vomit(10)
	M.adjustOxyLoss(2, 0)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	if(holder?.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 5)
	..()
	. = TRUE

/datum/reagent/consumable/vimrefresh
	name = "Vim Refresh"
	description = "You've Got Vim Refresh! Ooooh!"
	color = "#BFAC9C"
	taste_description = "off-brand Cosmic-cola and refreshment"
	glass_icon_state = "grasshopper"
	glass_name = "Vim Refresh"
	glass_desc = "You've Got Vim Refresh! Ooooh!"
	sodie_tier = SODIE_TIER_2 // Lime vim! Extra toxin heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/vimrefresh/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	M.AdjustSleeping(-40, FALSE)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	if(holder?.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 5)
	..()
	. = TRUE

/datum/reagent/consumable/vimice
	name = "Vim Ice"
	description = "You've Got Vim! Cold as the East."
	color = "#DFECED"
	taste_description = "cold off-brand Cosmic-cola"
	glass_icon_state = "vimiceglass"
	glass_name = "Iced Vim"
	glass_desc = "You've Got Vim! Cold as the East."
	sodie_tier = SODIE_TIER_2 // Iced series! Extra burn heals at the expense of everything else
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_NONE)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_NONE)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_NONE)

/datum/reagent/consumable/vimice/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-40 * TEMPERATURE_DAMAGE_COEFFICIENT, T0C)
	M.adjustOxyLoss(1, 0)
	M.dizziness = max(0,M.dizziness-5)
	M.drowsyness = max(0,M.drowsyness-3)
	//310.15 is the normal bodytemp.
	..()
	. = TRUE

//nuka bases

/datum/reagent/consumable/nukacherry
	name = "Cosmic Cherry"
	description = "Cosmic-Cola with a Cherry Aftertaste."
	color = "#9C1512"
	taste_description = "fizzy cherry soda"
	glass_icon_state = "nukacherryglass"
	glass_name = "Cosmic Cherry"
	glass_desc = "Cosmic-Cola with a Cherry Aftertaste."
	sodie_tier = SODIE_TIER_2 // Cherry Cosmic! Extra brute heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGHER)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukacherry/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukagrape
	name = "Cosmic Grape"
	description = "Cosmic-Cola with a Grape Aftertaste."
	color = "#643B65"
	taste_description = "fizzy grape soda"
	glass_icon_state = "nukagrapeglass"
	glass_name = "Cosmic Grape"
	glass_desc = "Cosmic-Cola with a Grape Aftertaste."
	sodie_tier = SODIE_TIER_2 // grape cosmic! Extra burn heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGHER)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukagrape/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaorange
	name = "Cosmic Orange"
	description = "Cosmic-Cola with a Orange Aftertaste."
	color = "#FF7F00"
	taste_description = "fizzy orange soda"
	glass_icon_state = "nukaorangeglass"
	glass_name = "Cosmic Orange"
	glass_desc = "Cosmic-Cola with a Orange Aftertaste."
	sodie_tier = SODIE_TIER_2 // Orange Cosmic! Extra toxin heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGHER)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukaorange/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukastrawberry
	name = "Cosmic Strawberry"
	description = "Cosmic-Cola with a Strawberry Aftertaste."
	color = "#B43528"
	taste_description = "fizzy strawberry soda"
	glass_icon_state = "nukastrawberryglass"
	glass_name = "Cosmic Strawberry"
	glass_desc = "Cosmic-Cola with a Strawberry Aftertaste."
	sodie_tier = SODIE_TIER_2 // Strawberry Cosmic! Its like cherry, but with some orange in it, sorta
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGHER)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukastrawberry/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaquartz
	name = "Cosmic Quartz"
	description = "An abomination of Americas favourite soda."
	color = "#FFFFFF"
	taste_description = "clear"
	glass_icon_state = "nukaquartzglass"
	glass_name = "Cosmic Quartz"
	glass_desc = "An abomination of Americas favourite soda."
	sodie_tier = SODIE_TIER_2 // Cosmic Quartz! Extra oxybrain heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)

/datum/reagent/consumable/nukaquartz/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaice
	name = "Iced Cosmic"
	description = "Cosmic. Stay frosty."
	color = "#646A7B"
	taste_description = "cold Nuka-Cola"
	glass_icon_state = "nukaiceglass"
	glass_name = "Iced Cosmic"
	glass_desc = "Cosmic. Stay frosty."
	sodie_tier = SODIE_TIER_2 // Iced series! Extra burn heals at the expense of everything else
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_NONE)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGHEST)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_LOW)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_NONE)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_NONE)

/datum/reagent/consumable/nukaice/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-20 * TEMPERATURE_DAMAGE_COEFFICIENT, T0C) //310.15 is the normal bodytemp.
	M.drowsyness = 0
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaice/overdose_start(mob/living/M)
	to_chat(M, span_userdanger("Too much Nuka-Cola! This cannot be good for you!"))
	M.AdjustSleeping(600, FALSE)
	. = 1

/datum/reagent/consumable/nukawild
	name = "Cosmic Wild"
	description = "A totally original concept of Cosmic-Cola!"
	color = "#734517"
	taste_description = "Nuka and root-beer"
	glass_icon_state = "nukawildglass"
	glass_name = "Cosmic Wild"
	glass_desc = "A totally original concept of Cosmic-Cola!"

/datum/reagent/consumable/nukawild/on_mob_life(mob/living/carbon/M)
	M.AdjustStun(-2, 0)
	M.AdjustKnockdown(-2, 0)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaray
	name = "Cosmic Ray"
	description = "A Cosmic mixture of both Cosmic victory and orange."
	color = "#FFFF00"
	taste_description = "Cosmic orange with a kick"
	glass_icon_state = "nukarayglass"
	glass_name = "Cosmic Ray"
	glass_desc = "A Cosmic mixture of both Cosmic victory and orange."
	sodie_tier = SODIE_TIER_4 // Basic high tier drink, kinda annoying to make
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_4, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_4, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_4, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_4, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_4, SODIE_HEALRANK_MED)

/datum/reagent/consumable/nukaray/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukarush
	name = "Cosmic Rush"
	description = "A Cosmic mixture of both Cosmic victory and wild."
	color = "#FFFF00"
	taste_description = "Cosmic wild with a kick"
	glass_icon_state = "nukarushglass"
	glass_name = "Cosmic Rush"
	glass_desc = "A Cosmic mixture of both Cosmic victory and wild."
	sodie_tier = SODIE_TIER_3 // Amplified high tier normal
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_LOW)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_LOW)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_HIGHER)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukarush/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-60, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

//nuka mixes

/datum/reagent/consumable/nukanew
	name = "New-Cosmic Cola"
	description = "The tastiest Hybridisation of Cosmic-Colas."
	color = "#75E11D"
	taste_description = "impossibly tasty Cosmic"
	glass_icon_state = "nukanewglass"
	glass_name = "New-Cosmic Cola"
	glass_desc = "The tastiest Hybridisation of Cosmic-Colas."
	sodie_tier = SODIE_TIER_3 // sike, its actually atomic red
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_HIGH)

/datum/reagent/consumable/nukanew/on_mob_life(mob/living/carbon/M)
	M.AdjustStun(-3, 0)
	M.AdjustKnockdown(-3, 0)
	M.AdjustUnconscious(-3, 0)
	M.drowsyness = 0
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukaberry
	name = "Cosmic Berry"
	description = "Cosmic-Cola with a Berry Aftertaste."
	color = "#753453"
	taste_description = "berry Cosmic-Cola"
	glass_icon_state = "nukaberryglass"
	glass_name = "Cosmic Berry"
	glass_desc = "Cosmic-Cola with a Berry Aftertaste."
	sodie_tier = SODIE_TIER_2 // Berry blast! Extra off-brand heals
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_MED)

/datum/reagent/consumable/nukacooler
	name = "Cosmic Cooler"
	description = "Insanely cold Cosmic-Cola, Freezing the air that surrounds it."
	color = "#B2B2B2"
	taste_description = "insanely cold Cosmic-Cola"
	glass_icon_state = "nukacoolerglass"
	glass_name = "Cosmic Cooler"
	glass_desc = "Insanely cold Cosmic-Cola, Freezing the air that surrounds it."
	sodie_tier = SODIE_TIER_3 // Super Iced series! Extra burn heals at the expense of everything else
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_NONE)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_HIGHEST)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_LOW)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_NONE)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_NONE)

/datum/reagent/consumable/nukacooler/on_mob_life(mob/living/carbon/M)
	M.adjust_bodytemperature(-60 * TEMPERATURE_DAMAGE_COEFFICIENT, T0C) //310.15 is the normal bodytemp.
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/nukafree
	name = "Diet Cosmic"
	description = "Cosmic-Cola with no added sugars!"
	color = "#663300"
	taste_description = "watered down Cosmic"
	glass_icon_state = "nukafreeglass"
	glass_name = "Diet Cosmic"
	glass_desc = "Cosmic-Cola with no added sugars!"
	sodie_tier = SODIE_TIER_3 // Diet?!?! its good for the body, but not the soul
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_HIGHER)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_HIGHER)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_NONE)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_NONE)

/datum/reagent/consumable/nukafree/on_mob_life(mob/living/carbon/M)
	if(M.nutrition <= NUTRITION_LEVEL_STARVING)
		M.adjustToxLoss(0.1*REM, 0)
	M.nutrition = max(M.nutrition - 3, 0)
	M.overeatduration = 0
	M.drowsyness = 0
	..()
	. = TRUE

/datum/reagent/consumable/nukafrutti
	name = "Cosmic Frutti"
	description = "The frutiest of Cosmics."
	color = "#FF9ABF"
	taste_description = "fruity Cosmic"
	glass_icon_state = "nukafruttiglass"
	glass_name = "Cosmic Frutti"
	glass_desc = "The frutiest of Cosmic."
	sodie_tier = SODIE_TIER_3 // fruity cosmic! bonuses to everything!
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_LOW)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_LOW)

/datum/reagent/consumable/nukafrutti/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	..()
	. = TRUE

//shake shack royal rumble

/datum/reagent/consumable/nukafloat
	name = "Cosmic Float"
	description = "A delicious blend of ice-cream and classic Nuka-Cosmic!"
	color = "#11111E"
	nutriment_factor = 10 * REAGENTS_METABOLISM
	taste_description = "creamy Cosmic"
	glass_icon_state = "nukafloatglass"
	glass_name = "Nuka Cosmic"
	glass_desc = "A delicious blend of ice-cream and classic Cosmic-Cola!"
	sodie_tier = SODIE_TIER_3 // I like floats, so they get a higher tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_HIGH) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_MED)

/datum/reagent/consumable/nukafloat/on_mob_life(mob/living/carbon/M)
	..()
	. = 1

/datum/reagent/consumable/sunsetfloat
	name = "Sunset Float"
	description = "A delicious blend of ice-cream and classic Sunset Sass!"
	color = "#734517"
	nutriment_factor = 10 * REAGENTS_METABOLISM
	taste_description = "creamy root beer"
	glass_icon_state = "sunsetfloatglass"
	glass_name = "Sunset Float"
	glass_desc = "A delicious blend of ice-cream and classic Sunset Sass!"
	sodie_tier = SODIE_TIER_3 // I like floats, so they get a higher tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_HIGH) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_HIGHER)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_MED)

/datum/reagent/consumable/bawlsshake
	name = "Bawls Shake"
	description = "A blended shake consumed by those on high energy blitz-lifestyles."
	color = "#0070E1"
	nutriment_factor = 10
	taste_description = "creamy sugar"
	glass_icon_state = "bawlsshakeglass"
	glass_name = "Bawls Shake"
	glass_desc = "A blended shake consumed by those on high energy blitz-lifestyles."
	sodie_tier = SODIE_TIER_3 // I like floats, so they get a higher tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_3, SODIE_HEALRANK_HIGH) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_3, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_3, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_3, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_3, SODIE_HEALRANK_HIGHEST)

/datum/reagent/consumable/jakeshake
	name = "Jake Shake"
	description = "Jakes patented shake of Jake."
	color = "#7ABB5F"
	nutriment_factor = 10
	taste_description = "creamy patented juice"
	glass_icon_state = "jakeshakeglass"
	glass_name = "Jake Shake"
	glass_desc ="Jakes patented shake of Jake."
	sodie_tier = SODIE_TIER_4 // I like floats, so they get a higher tier // idk what they do so they get a bonus tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_4, SODIE_HEALRANK_HIGH) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_4, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_4, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_4, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_4, SODIE_HEALRANK_HIGHEST)

/datum/reagent/consumable/jakeshake/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/sweetwaterfloat
	name = "Sweetwater Float"
	description = "The sweetest water."
	color = "#FAFAF8"
	nutriment_factor = 10
	taste_description = "the sweetest water"
	glass_icon_state = "sweetwaterfloatglass"
	glass_name = "Sweetwater Float"
	glass_desc = "The sweetest water."
	sodie_tier = SODIE_TIER_4 // I like floats, so they get a higher tier // idk what they do so they get a bonus tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_4, SODIE_HEALRANK_HIGH) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_4, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_4, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_4, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_4, SODIE_HEALRANK_HIGHEST)


/datum/reagent/consumable/sweetwaterfloat/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/sunsetter
	name = "Sunsetter"
	description = "For when the days dawn, lest brings a brighter tommorrow."
	color = "#B06A24"
	nutriment_factor = 10
	taste_description = "days gone by"
	glass_icon_state = "sunsetterglass"
	glass_name = "Sunsetter"
	glass_desc = "For when the days dawn, lest brings a brighter tommorrow."
	sodie_tier = SODIE_TIER_2 // I like floats, so they get a higher tier // idk what they do so they get a bonus tier
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_LOW) // they canonically made Dan fat, and so will you
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGH)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_MED)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_MED)


/datum/reagent/consumable/sunsetter/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/yuccashake
	name = "Yucca Shake"
	description = "A blended shake consisting of yucca and creamy goodness."
	color = "#FFD24A"
	nutriment_factor = 10
	taste_description = "bannanas and cream"
	glass_icon_state = "yuccashakeglass"
	glass_name = "Yucca Shake"
	glass_desc = "A blended shake consisting of yucca and creamy goodness."

/datum/reagent/consumable/yuccashake/on_mob_life(mob/living/carbon/M)
	M.adjustOxyLoss(-1*REM, 0)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-10 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = TRUE

/datum/reagent/consumable/bawls
	name = "Balls Guarana"
	description = "For that Guarana Bounce!"
	color = "#494A82"
	taste_description = "insanely sweet coffee"
	glass_icon_state = "bawlsglass"
	glass_name = "glass of Balls Guarana"
	glass_desc = "Beverage of the Balls Guarana Company."
	sodie_tier = SODIE_TIER_1 // bawbags
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_1, SODIE_HEALRANK_MED)
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_1, SODIE_HEALRANK_HIGHEST)
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_1, SODIE_HEALRANK_HIGHEST)

/datum/reagent/consumable/bawls/on_mob_life(mob/living/carbon/M)
	M.dizziness = max(0,M.dizziness-2)
	M.drowsyness = max(0,M.drowsyness-1)
	M.AdjustSleeping(-40, FALSE)
	//310.15 is the normal bodytemp.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	if(holder?.has_reagent(/datum/reagent/consumable/frostoil))
		holder.remove_reagent(/datum/reagent/consumable/frostoil, 5)
	..()
	. = 1

/datum/reagent/consumable/big_red
	name = "Atomic Red"
	description = "Nothing Bigger or Redder than Big Red!" // NOTICES BIG RED ROCKET KNOT OWO X3 ~MURR~ HE HE HE
	color = "#ff0000"
	taste_description = "bubblegum with a creamy aftertaste"
	glass_icon_state = "bigred"
	glass_name = "bottle of Atomic Red"
	glass_desc = "A bottle of an old southern classic soda, still mixed to this day. A creamy blend of bubblegum-esque orange-lemon, topped off with vanilla for a uniquely pleasant flavor. A favorite of otterlike folk."
	sodie_tier = SODIE_TIER_2 // So far there arent any recipies with this, so it gets a boost
	sodie_heal_brute = SODIE_BRUTE(SODIE_TIER_2, SODIE_HEALRANK_HIGH) // I also put a lot of work into the drink!
	sodie_heal_burn =  SODIE_BURN( SODIE_TIER_2, SODIE_HEALRANK_HIGH) // the reagent, the bottle the machine
	sodie_heal_toxin = SODIE_TOXIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH) // and nobody drinks the damn thing!
	sodie_heal_oxy =   SODIE_OXY(  SODIE_TIER_2, SODIE_HEALRANK_HIGH) // the bird (otter, jackalope, whatever she is now) deserves better
	sodie_heal_brain = SODIE_BRAIN(SODIE_TIER_2, SODIE_HEALRANK_HIGH) // drink the damn gamer juice

/datum/reagent/consumable/big_red/on_mob_life(mob/living/carbon/M)
	M.drowsyness = 0
	M.AdjustSleeping(-40, FALSE)
	M.adjust_bodytemperature(-5 * TEMPERATURE_DAMAGE_COEFFICIENT, BODYTEMP_NORMAL)
	..()
	. = 1

/datum/reagent/consumable/tea/berrytea
	name = "Mixed Berry Tea"
	description = "Hot tea with a sweet, fruity taste!"
	color = "#2E0206"
	nutriment_factor = 10
	taste_description = "tart, fruiy tea"
	glass_icon_state = "berrytea"
	glass_name = "cup of mixed berry tea"
	glass_desc = "Hot tea with a sweet, fruity taste!"

/datum/reagent/drink/tea/pomegranate_icetea
	name = "Pomegranate Iced Tea"
	description = "A refreshing, fruity tea. No fruit was harmed in the making of this drink."
	color = "#7C334C"
	taste_description = "sweet pomegranate"

	glass_icon_state = "pomegranatetea"
	glass_name = "glass of pomegranate iced tea"
	glass_desc = "A refreshing, fruity tea. No fruit was harmed in the making of this drink."

/datum/reagent/drink/tea/portsvilleminttea
	name = "Portsville Mint Tea"
	description = "A popular iced pick-me-up originating from a city in Eos, on Biesel."
	color = "#b6f442"
	taste_description = "cool minty tea"

	glass_icon_state = "portsvilleminttea"
	glass_name = "glass of Portsville Mint Tea"
	glass_desc = "A popular iced pick-me-up originating from a city in Eos, on Biesel."

/datum/reagent/drink/tea/potatea
	name = "Potatea"
	description = "Why would you ever drink this?"
	color = "#2B2710"
	taste_description = "starchy regret"

	glass_icon_state = "bigteacup"
	glass_name = "cup of potatea"
	glass_desc = "Why would you ever drink this?"

/datum/reagent/drink/tea/securitea
	name = "Securitea"
	description = "The safest drink around."
	color = "#030B36"
	taste_description = "freshly polished boots"

	glass_icon_state = "securitea"
	glass_name = "cup of securitea"
	glass_desc = "Help, maint!!"

/datum/reagent/drink/tea/sleepytime_tea
	name = "Sleepytime Tea"
	description = "The perfect drink to enjoy before falling asleep in your favorite chair."
	color = "#101000"
	taste_description = "liquid relaxation"

	glass_icon_state = "sleepytea"
	glass_name = "cup of sleepytime tea"
	glass_desc = "The perfect drink to enjoy before falling asleep in your favorite chair."

/datum/reagent/drink/tea/hakhma_tea
	name = "Spiced Hakhma Tea"
	description = "A tea often brewed by Offworlders and Scarabs during important meals."
	color = "#8F6742"
	taste_description = "creamy, cinnamon-spiced alien milk"

	glass_icon_state = "hakhmatea"
	glass_name = "cup of spiced hakhma tea"
	glass_desc = "A tea often brewed by Offworlders and Scarabs during important meals."


/datum/reagent/drink/tea/thewake //dyn properties
	name = "The Wake"
	description = "The tea-based alternative to a Sromshine."
	color = "#00E0E0"
	taste_description = "orange juice mixed with minty toothpaste"

	glass_icon_state = "thewake"
	glass_name = "cup of The Wake"
	glass_desc = "Most young skrell get a kick out of letting humans try this."


/datum/reagent/drink/tea/tomatea
	name = "Tomatea"
	description = "Basically tomato soup in a mug."
	color = "#9F3400"
	taste_description = "sad tomato soup"

	glass_icon_state = "bigteacup"
	glass_name = "cup of tomatea"
	glass_desc = "Basically tomato soup in a mug."

/datum/reagent/drink/tea/tropical_icetea
	name = "Tropical Iced Tea"
	description = "For maximum enjoyment, drink while at the beach on a warm summer day."
	color = "#CC0066"
	taste_description = "sweet beachside fruit"

	glass_icon_state = "junglejuice"
	glass_name = "glass of tropical iced tea"
	glass_desc = "For maximum enjoyment, drink while at the beach on a warm summer day."

/datum/reagent/drink/tea/cocatea
	name = "Mate de Coca"
	description = "An herbal tea made of coca leaves, this tea originated in South America in the Andean countries, and is still consumed there and in Mictlan to this day."
	color = "#adff2f"
	taste_description = "mildly bitter, but sweet"

	glass_icon_state = "bigteacup"
	glass_name = "cup of mate de coca"
	glass_desc = "An herbal tea made of coca leaves, this tea originated in South America in the Andean countries, and is still consumed there and in Mictlan to this day."

/datum/reagent/drink/tea/halfandhalf
	name = "Half and Half"
	description = "Tea and lemonade; not to be confused with the dairy creamer."
	color = "#997207"
	taste_description = "refreshing tea mixed with crisp lemonade"

	glass_icon_state = "halfandhalf"
	glass_name = "glass of half and half"
	glass_desc = "Tea and lemonade; not to be confused with the dairy creamer."

/datum/reagent/drink/tea/heretic_tea
	name = "Heretics' Tea"
	description = "A non-alcoholic take on a bloody brew."
	color = "#820000"
	taste_description = "fizzy, heretically sweet iron"

	glass_icon_state = "heretictea"
	glass_name = "glass of Heretics' Tea"
	glass_desc = "A non-alcoholic take on a bloody brew."

/datum/reagent/drink/tea/kira_tea
	name = "Kira Tea"
	description = "A sweet take on a fizzy favorite."
	color = "#B98546"
	taste_description = "fizzy citrus tea"

	glass_icon_state = "kiratea"
	glass_name = "glass of kira tea"
	glass_desc = "A sweet take on a fizzy favorite."

/datum/reagent/drink/tea/librarian_special
	name = "Librarian Special"
	description = "Shhhhhh!"
	color = "#101000"
	taste_description = "peace and quiet"

	glass_icon_state = "bureacratea"
	glass_name = "cup of Librarian Special"
	glass_desc = "Shhhhhh!"

/datum/reagent/drink/tea/mars_tea
	name = "Martian Tea"
	description = "A foul-smelling brew that you probably don't want to try."
	color = "#101000"
	taste_description = "bitter tea, pungent black pepper and just a hint of shaky politics"

	glass_icon_state = "bigteacup"
	glass_name = "cup of martian tea"
	glass_desc = "A foul-smelling brew that you probably don't want to try."

/datum/reagent/drink/tea/mendell_tea
	name = "Mendell Afternoon Tea"
	description = "A simple, minty tea."
	color = "#EFB300"
	taste_description = "minty tea with a hint of lemon"

	glass_icon_state = "mendelltea"
	glass_name = "cup of Mendell Afternoon Tea"
	glass_desc = "A simple, minty tea. A Biesel favorite."

/datum/reagent/drink/tea/chaitea
	name = "Chai Tea"
	description = "A tea spiced with cinnamon and cloves."
	color = "#DBAD81"
	taste_description = "creamy cinnamon and spice"

	glass_icon_state = "chaitea"
	glass_name = "cup of chai tea"
	glass_desc = "A tea spiced with cinnamon and cloves."

/datum/reagent/drink/tea/coco_chaitea
	name = "Chocolate Chai"
	description = "A surprisingly pleasant mix of chocolate and spice."
	color = "#664300"
	taste_description = "creamy spiced cocoa"

	glass_icon_state = "coco_chaitea"
	glass_name = "cup of chocolate chai tea"
	glass_desc = "A surprisingly pleasant mix of chocolate and spice."

/datum/reagent/drink/tea/chaitealatte
	name = "Chai Latte"
	description = "A frothy spiced tea."
	color = "#DBAD81"
	taste_description = "spiced milk foam"

	glass_icon_state = "chailatte"
	glass_name = "cup of chai latte"
	glass_desc = "For when you need the energy to yell at the barista for making your drink wrong."


/datum/reagent/drink/tea/coco_chailatte
	name = "Chocolate Chai Latte"
	description = "Sweet, liquid chocolate. Have a cup of this and maybe you'll calm down."
	color = "#664300"
	taste_description = "spiced milk chocolate"

	glass_icon_state = "coco_chailatte"
	glass_name = "cup of chocolate chai latte"
	glass_desc = "Sweet, liquid chocolate. Have a cup of this and maybe you'll calm down."

/datum/reagent/drink/tea/cofftea
	name = "Cofftea"
	description = "The only neutral ground in the tea versus coffee debate."
	color = "#292303"
	taste_description = "lightly tart coffee"

	glass_icon_state = "cofftea"
	glass_name = "cup of cofftea"
	glass_desc = "The only neutral ground in the tea versus coffee debate."


/datum/reagent/alcohol/trizkizki_tea
	name = "Trizkizki Tea"
	description = "A popular drink from Ouerea that smells of crisp sea air."
	color = "#876185"
	taste_description = "light, sweet wine, with a hint of sea breeze"

	glass_icon_state = "trizkizkitea"
	glass_name = "cup of Trizkizki tea"
	glass_desc = "A popular drink from Ouerea that smells of crisp sea air"
