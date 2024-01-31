

/obj/item/artifact
	name = "artifact"
	desc = "A bizarre relic of some sort. It seems to radiate an aura of otherworldly power. Perfect to fit in your coat pocket."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "battery"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF
	var/unique
	var/rareness = ART_RARITY_COMMON
	var/buff_strength_high = 30
	var/buff_strength_low = 10
	var/buff_type
	var/buff_strength
	var/debuff_type
	var/debuff_strength

/obj/item/artifact/common
	buff_strength_high = 30
	buff_strength_low = 20
	rareness = ART_RARITY_COMMON

/obj/item/artifact/uncommon
	buff_strength_high = 60
	buff_strength_low = 30
	rareness = ART_RARITY_UNCOMMON

/obj/item/artifact/rare
	buff_strength_high = 90
	buff_strength_low = 40
	rareness = ART_RARITY_RARE

/obj/item/artifact/Initialize(mapload)
	. = ..()
	artifact_me()
	update_icon()

/obj/item/artifact/proc/artifact_me()
	var/list/overrides = roll_artifact()
	SSartifacts.artifactify(src, null, rareness, overrides)

/obj/item/artifact/proc/roll_artifact()
	var/list/overrides = list()
	var/list/effect_entries = list()
	for(var/i in 1 to 8)
		effect_entries += i
	buff_type = pick(effect_entries)
	effect_entries -= buff_type
	debuff_type = pick(effect_entries)
	effect_entries -= debuff_type
	buff_strength = rand(buff_strength_low, buff_strength_high) //if you touch this, also touch export cost formula
	debuff_strength = rand(buff_strength_low, buff_strength_high)

	switch(buff_type)
		if(1) //brute
			overrides[ARTMOD_PASSIVE_HEAL] = list()
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MIN_HEALTH] = 5
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MAX_HEALTH] = 100
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BRUTE] = -(buff_strength/200)
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_IS_BUFF] = TRUE
		if(2) //burn
			overrides[ARTMOD_PASSIVE_HEAL] = list()
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MIN_HEALTH] = 5
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MAX_HEALTH] = 100
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_BURN] = -(buff_strength/200)
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_IS_BUFF] = TRUE
		if(3) //toxin
			overrides[ARTMOD_PASSIVE_HEAL] = list()
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MAX_HEALTH] = 100
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_MIN_HEALTH] = 5
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_TOXIN] = -(buff_strength/200)
			overrides[ARTMOD_PASSIVE_HEAL][ARTVAR_IS_BUFF] = TRUE
		if(4) //health
			overrides[ARTMOD_MAX_HP] = list()
			overrides[ARTMOD_MAX_HP][ARTVAR_HP_CHANGE] = (buff_strength/5)
			overrides[ARTMOD_MAX_HP][ARTVAR_IS_BUFF] = TRUE
		if(5) //stamina
			overrides[ARTMOD_STAMINA] = list()
			overrides[ARTMOD_STAMINA][ARTVAR_STAMINA_ADJUSTMENT] = (buff_strength/25)
			overrides[ARTMOD_STAMINA][ARTVAR_IS_BUFF] = TRUE
		if(6) //speed
			overrides[ARTMOD_SPEED] = list()
			overrides[ARTMOD_SPEED][ARTVAR_SPEED_ADJUSTMENT] = -(buff_strength/90)
			overrides[ARTMOD_SPEED][ARTVAR_IS_BUFF] = TRUE
		if(7) //blood
			overrides[ARTMOD_BLOOD] = list()
			overrides[ARTMOD_BLOOD][ARTVAR_BLOOD_ADJUSTMENT] = (buff_strength/100)
			overrides[ARTMOD_BLOOD][ARTVAR_IS_BUFF] = TRUE
		if(8) //radiation
			overrides[ARTMOD_RADIATION] = list()
			overrides[ARTMOD_RADIATION][ARTVAR_RADIATION_ADJUSTMENT] = -(buff_strength/100)
			overrides[ARTMOD_RADIATION][ARTVAR_IS_BUFF] = TRUE
	// switch(debuff_type)
	// 	if(1) //brute
	// 		overrides[ARTMOD_PASSIVE_DOT] = list()
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_MIN_HEALTH] = 5
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_BRUTE] = (buff_strength/100)
	// 	if(2) //burn
	// 		overrides[ARTMOD_PASSIVE_DOT] = list()
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_MIN_HEALTH] = 5
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_BURN] = (buff_strength/100)
	// 	if(3) //toxin
	// 		overrides[ARTMOD_PASSIVE_DOT] = list()
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_MIN_HEALTH] = 5
	// 		overrides[ARTMOD_PASSIVE_DOT][ARTVAR_TOXIN] = (buff_strength/100)
	// 	if(4) //health
	// 		overrides[ARTMOD_MAX_HP] = list()
	// 		overrides[ARTMOD_MAX_HP][ARTVAR_HP_CHANGE] = -(buff_strength/5)
	// 	if(5) //stamina
	// 		overrides[ARTMOD_STAMINA] = list()
	// 		overrides[ARTMOD_STAMINA][ARTVAR_STAMINA_ADJUSTMENT] = -(buff_strength/100)
	// 	if(6) //speed
	// 		overrides[ARTMOD_SPEED] = list()
	// 		overrides[ARTMOD_SPEED][ARTVAR_SPEED_ADJUSTMENT] = -(buff_strength/100)
	// 	if(7) //blood
	// 		overrides[ARTMOD_BLOOD] = list()
	// 		overrides[ARTMOD_BLOOD][ARTVAR_BLOOD_ADJUSTMENT] = (buff_strength/100)
	// 	if(8) //radiation
	// 		overrides[ARTMOD_RADIATION] = list()
	// 		overrides[ARTMOD_RADIATION][ARTVAR_RADIATION_ADJUSTMENT] = -(buff_strength/100)
	set_name_to()
	var/name_prefix = get_prefix()
	var/colorize = get_color()
	overrides[ARTCOMP_PREFIX] = name_prefix
	overrides[ARTCOMP_SUFFIX] = ART_NO_SUFFIX
	overrides[ARTCOMP_COLOR] = colorize
	overrides[ARTCOMP_PREROLLED] = TRUE
	return overrides


/obj/item/artifact/update_icon()
	. = ..()
	set_iconstate()

/obj/item/artifact/proc/set_iconstate()
	if(prob(1))
		icon_state = "oh-no-my-fingers" // oh im so sick i hope this crystal will help me to get better, oh no my fingers
		return
	switch(buff_type)
		if(1) //brute
			icon_state = "stoneflower"
		if(2) //burn
			icon_state = "meduza"
		if(3) //toxin
			icon_state = "koluchka"
		if(4) //health
			icon_state = "stone_blood"
		if(5) //stamina
			icon_state = "moonlight"
		if(6) //speed
			icon_state = "mica"
		if(7) //blood
			icon_state = "sliz"
		if(8) //radiation
			icon_state = "droplet"

/obj/item/artifact/proc/set_name_to()
	switch(buff_type)
		if(1) //brute
			name = "stone flower" //adv is beads/mamini_busi
		if(2) //burn
			name = "jellyfish" //adv is fireball
		if(3) //toxin
			name = "thorn" //adv is urchin/ezh
		if(4) //health
			name = "stone blood" //adv is soul
		if(5) //stamina
			name = "moonlight" //adv is night star
		if(6) //speed
			name = "mica" //adv is firefly
		if(7) //blood
			name = "slime" //adv is slug/sliznyak
		if(8) //radiation
			name = "droplet" //adv is crystal

/obj/item/artifact/proc/get_prefix()
	switch(debuff_type)
		if(1) //brute
			return "stinging"
		if(2) //burn
			return "smoldering"
		if(3) //toxin
			return "emetic"
		if(4) //health
			return "frail"
		if(5) //stamina
			return "soporific"
		if(6) //speed
			return "lethargic"
		if(7) //blood
			return "bloody"
		if(8) //radiation
			return "glowing"

/obj/item/artifact/proc/get_color()
	switch(debuff_type)
		if(1) //brute
			return COLOR_PALE_RED_GRAY
		if(2) //burn
			return COLOR_PALE_ORANGE
		if(3) //toxin
			return COLOR_PALE_GREEN_GRAY
		if(4) //health
			return COLOR_ALMOST_BLACK
		if(5) //stamina
			return COLOR_PALE_BLUE_GRAY
		if(6) //speed
			return COLOR_PALE_PURPLE_GRAY
		if(7) //blood
			return COLOR_RED_GRAY
		if(8) //radiation
			return COLOR_GREEN_GRAY

/obj/item/artifact/rare/set_iconstate()
	if(prob(1))
		icon_state = "oh-no-my-fingers" // oh im so sick i hope this crystal will help me to get better, oh no my fingers
		return
	switch(buff_type)
		if(1) //brute
			icon_state = "mamini_busi"
		if(2) //burn
			icon_state = "fireball"
		if(3) //toxin
			icon_state = "ezh"
		if(4) //health
			icon_state = "soul"
		if(5) //stamina
			icon_state = "nightstar"
		if(6) //speed
			icon_state = "firefly"
		if(7) //blood
			icon_state = "sliznyak"
		if(8) //radiation
			icon_state = "crystal"

/obj/item/artifact/rare/set_name_to()
	switch(buff_type)
		if(1) //brute
			name = "beads"
		if(2) //burn
			name = "fireball"
		if(3) //toxin
			name = "urchin"
		if(4) //health
			name = "soul"
		if(5) //stamina
			name = "night star"
		if(6) //speed
			name = "firefly"
		if(7) //blood
			name = "slug"
		if(8) //radiation
			name = "crystal"

/obj/item/artifact/rare/get_prefix()
	switch(debuff_type)
		if(1) //brute
			return "rending"
		if(2) //burn
			return "searing"
		if(3) //toxin
			return "bilious"
		if(4) //health
			return "evanescent"
		if(5) //stamina
			return "exigent"
		if(6) //speed
			return "torpid"
		if(7) //blood
			return "weeping"
		if(8) //radiation
			return "discharging"

/obj/item/artifact/rare/get_color()
	switch(debuff_type)
		if(1) //brute
			return COLOR_PALE_RED_GRAY
		if(2) //burn
			return COLOR_PALE_ORANGE
		if(3) //toxin
			return COLOR_PALE_GREEN_GRAY
		if(4) //health
			return COLOR_ALMOST_BLACK
		if(5) //stamina
			return COLOR_PALE_BLUE_GRAY
		if(6) //speed
			return COLOR_PALE_PURPLE_GRAY
		if(7) //blood
			return COLOR_RED_GRAY
		if(8) //radiation
			return COLOR_GREEN_GRAY

// /obj/item/artifact/unique
// 	name = "debug legendary artifact"
// 	desc = "A bizarre relic with supernatual properties. It causes strange effects when fitted into your armor or jacket."
// 	var/unique

// /obj/item/artifact/unique/artifact_me()
// 	var/list/overrides = list()
// 	if(unique in SSartifacts.unique_templates)
// 		overrides[ART_FORCE_SPECIFIC_UNIQUE] = unique
// 	SSartifacts.uniqueify(src, overrides)

//apotheosis holds all possible positives at max value
//this exists as the be all, end all. it should not be found like...ever.
/obj/item/artifact/unique/apotheosis
	name = "Apotheosis"
	icon_state = "pustishka"
	unique = ART_UNIQUE_APOTHEOSIS
	// buff_text = "Most artifacts are flawed in some way or another. This one is not only perfect, but reflects the boons of all lesser artifacts."
	// buff_strength = 200 //6000 credits
	/*
	if(M.health > 5)
		M.adjustBruteLoss(-0.5, 0, include_roboparts = TRUE)
		M.adjustFireLoss(-0.5, 0, include_roboparts = TRUE)
		M.adjustToxLoss(-0.5, 0, TRUE)
	M.adjustStaminaLoss(-0.5, 0)
	if(M.get_blood(TRUE) < (BLOOD_VOLUME_NORMAL*M.blood_ratio && M.get_blood(TRUE) > 250))
		M.blood_volume += 0.5
	if(M.radiation > 0)
		M.radiation -= min(M.radiation, 0.5)
	//on add
	M.maxHealth += 10
	M.health += 10
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/artifact, TRUE, -0.5)

	//on remove
	M.maxHealth -= 10
	M.health = min(M.health - 10, M.maxHealth)
	remove_movespeed_modifier(/datum/movespeed_modifier/artifact)
	*/


//perfection holds one positive at max value.
//these should not be easy to get as they run contrary to the concept of artifacts having tradeoffs to balance
/obj/item/artifact/unique/perfection
	name = "Perfection"
	icon_state = "pustishka_q"
	unique = ART_UNIQUE_PERFECTION


// 	buff_text = "Most artifacts are flawed in some way or another. This one is perfect."
// 	debuff_type = 0
// 	buff_strength = 50
// 	debuff_strength = 0

// /obj/item/artifact/legendary/perfection/Initialize()
// 	buff_type = rand(1,8)

// 	switch(buff_type)
// 		if(1) //brute
// 			name_prefix = "Salubrious"
// 			color = COLOR_PALE_RED_GRAY
// 			debuff_text = "Provides [buff_strength/100] brute regeneration" //uses debuff text because buff text is already in use
// 		if(2) //burn
// 			name_prefix = "Demulcent"
// 			color = COLOR_PALE_ORANGE
// 			debuff_text = "Provides [buff_strength/100] burn regeneration"
// 		if(3) //toxin
// 			name_prefix = "Pure"
// 			color = COLOR_PALE_GREEN_GRAY
// 			debuff_text = "Provides [buff_strength/100] toxin regeneration"
// 		if(4) //health
// 			name_prefix = "Stalwart"
// 			color = null
// 			debuff_text = "Provides [buff_strength/5] health"
// 		if(5) //stamina
// 			name_prefix = "Vigorous"
// 			color = COLOR_PALE_BLUE_GRAY
// 			debuff_text = "Provides [buff_strength/100] stamina regeneration"
// 		if(6) //speed
// 			name_prefix = "Dynamic"
// 			color = COLOR_PALE_PURPLE_GRAY
// 			debuff_text = "Provides [buff_strength/100] movement speed"
// 		if(7) //blood
// 			name_prefix = "Sanguine"
// 			color = COLOR_RED_GRAY
// 			debuff_text = "Provides [buff_strength/100] blood regeneration"
// 		if(8) //radiation
// 			name_prefix = "Luminescent"
// 			color = COLOR_GREEN_GRAY
// 			debuff_text = "Provides [buff_strength/100] radiation regeneration"
// 	..()
//extremely debilitating artifact 
/obj/item/artifact/unique/penance
	name = "Penance"
	icon_state = "pustishka_old"
	unique = ART_UNIQUE_PENANCE
	// buff_text = "This artifact bears all the flaws of the world. May the gods have mercy on any who carry it."
	// buff_strength = 10 //worth zero
	// debuff_strength = 30

	/*
	if(M.health > 5)
		M.adjustBruteLoss(0.5, 0, include_roboparts = TRUE)
		M.adjustFireLoss(0.5, 0, include_roboparts = TRUE)
		M.adjustToxLoss(0.5, 0, TRUE)
	if(M.stamina > 100)
		M.adjustStaminaLoss(0.5, 0)
	if(M.get_blood(TRUE) > 250)
		M.blood_volume -= 0.5
	if(M.radiation < (RAD_BURN_THRESHOLD - 5))
		M.radiation += 0.5
	//on add
	M.maxHealth -= 10 //dunno if these need switched so health moves then maxhealth
	M.health = min(M.health - 10, M.maxHealth)
	add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/artifact, TRUE, 0.5)
	ADD_TRAIT(M.mind, TRAIT_PENANCE) //make sure putting a second penance in your inventory doesn't cause some weird trait duplication

	//on remove
	M.maxHealth += 10
	M.health += 10
	remove_movespeed_modifier(/datum/movespeed_modifier/artifact)
	REMOVE_TRAIT(M.mind, TRAIT_PENANCE) //...probably needs a check to be sure it's the last penance in your coat
	*/

/obj/item/artifact/unique/bubble //luv u dan
	name = "Bubble"
	icon_state = "bubble"
	unique = ART_UNIQUE_BUBBLE
	//buff_text = "Some call this artifact the Cornucopia."

	/*
	if(!HAS_TRAIT(M, TRAIT_NO_PROCESS_FOOD)) //this is copypasted, so not sure if it's all correct
		current_cycle++
		M.adjust_nutrition(1, max_nutrition) //a quarter the nutrient value of standard food, but persistent
	M.CheckBloodsuckerEatFood(1)
			*/
