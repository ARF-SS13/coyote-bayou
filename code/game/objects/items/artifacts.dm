

/obj/item/artifact
	name = "debug artifact"
	desc = "A bizarre relic with supernatual properties. It causes strange effects when fitted into your armor or jacket."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "battery"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF

	var/buff_type
	var/buff_strength

	var/debuff_type
	var/debuff_strength

	var/buff_text
	var/debuff_text
	/*
	switch(buff_type)
		if(1) //brute
			if(M.health > 5) //prevents you from using it to be immortal in crit
				M.adjustBruteLoss(-buff_strength/100, 0, include_roboparts = TRUE)
		if(2) //burn
			if(M.health > 5)
				M.adjustFireLoss(-buff_strength/100, 0, include_roboparts = TRUE)
		if(3) //toxin
			if(M.health > 5)
				M.adjustToxLoss(-buff_strength/100, 0, TRUE)
		if(4) //health
				//on add
			M.maxHealth += buff_strength/5
			M.health += buff_strength/5
				//on remove
			M.maxHealth -= buff_strength/5
			M.health = min(M.health - buff_strength/5, M.maxHealth)
		if(5) //stamina
			M.adjustStaminaLoss(-buff_strength/100, 0)
		if(6) //speed
				//on add
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/artifact, TRUE, -buff_strength/100)
				//on remove
			remove_movespeed_modifier(/datum/movespeed_modifier/artifact) //gotta make sure these can stack I think...
		if(7) //blood
			if(M.get_blood(TRUE) < (BLOOD_VOLUME_NORMAL*M.blood_ratio && M.get_blood(TRUE) > 250))
				M.blood_volume += buff_strength/100
		if(8) //radiation
			if(M.radiation > 0)
				M.radiation -= min(M.radiation, buff_strength/100)


	switch(debuff_type)
		if(1) //brute
			if(M.health > 5) //safeguards against permacrit and afk crit
				M.adjustBruteLoss(debuff_strength/100, 0, include_roboparts = TRUE)
		if(2) //burn
			if(M.health > 5)
				M.adjustFireLoss(debuff_strength/100, 0, include_roboparts = TRUE)
		if(3) //toxin
			if(M.health > 5)
				M.adjustToxLoss(debuff_strength/100, 0, TRUE)
		if(4) //health
				//on add
			M.maxHealth -= debuff_strength/5 //dunno if these need switched so health moves then maxhealth
			M.health = min(M.health - debuff_strength/5, M.maxHealth)
				//on remove
			M.maxHealth += debuff_strength/5
			M.health += debuff_strength/5
		if(5) //stamina
			if(M.stamina > 100)
				M.adjustStaminaLoss(debuff_strength/100, 0)
		if(6) //speed
				//on add
			add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/artifact, TRUE, debuff_strength/100)
				//on remove
			remove_movespeed_modifier(/datum/movespeed_modifier/artifact)
		if(7) //blood
			if(M.get_blood(TRUE) > 250)
				M.blood_volume -= debuff_strength/100
		if(8) //radiation
			if(M.radiation < (RAD_BURN_THRESHOLD - 5))
					M.radiation += debuff_strength/100
*/
/obj/item/artifact/examine(mob/user)
	.=..()
	if(buff_text)
		.+= "[buff_text]"
	if(debuff_text)
		.+= "[debuff_text]"



/obj/item/artifact/low
	name = "debug low artifact"

/obj/item/artifact/low/Initialize()
	buff_type = rand(1,8)
	debuff_type = rand(1,8)

	buff_strength = rand(10,30) //if you touch this, also touch export cost formula
	debuff_strength = rand(10,30)

	var/name_suffix
	var/name_prefix
	switch(buff_type)
		if(1) //brute
			name_suffix = "stone flower" //adv is beads/mamini_busi
			icon_state = "stoneflower"
			buff_text = "Provides [buff_strength/100] brute regeneration"
		if(2) //burn
			name_suffix = "jellyfish" //adv is fireball
			icon_state = "meduza"
			buff_text = "Provides [buff_strength/100] burn regeneration"
		if(3) //toxin
			name_suffix = "thorn" //adv is urchin/ezh
			icon_state = "koluchka"
			buff_text = "Provides [buff_strength/100] toxin regeneration"
		if(4) //health
			name_suffix = "stone blood" //adv is soul
			icon_state = "stone_blood"
			buff_text = "Provides [buff_strength/5] health"
		if(5) //stamina
			name_suffix = "moonlight" //adv is night star
			icon_state = "moonlight"
			buff_text = "Provides [buff_strength/100] stamina regeneration"
		if(6) //speed
			name_suffix = "mica" //adv is firefly
			icon_state = "mica"
			buff_text = "Provides [buff_strength/100] movement speed"
		if(7) //blood
			name_suffix = "slime" //adv is slug/sliznyak
			icon_state = "sliz"
			buff_text = "Provides [buff_strength/100] blood regeneration"
		if(8) //radiation
			name_suffix = "droplet" //adv is crystal
			icon_state = "droplet"
			buff_text = "Provides [buff_strength/100] radiation regeneration"

	switch(debuff_type)
		if(1) //brute
			name_prefix = "stinging"
			color = COLOR_PALE_RED_GRAY
			debuff_text = "Causes [debuff_strength/100] brute drain"
		if(2) //burn
			name_prefix = "smoldering"
			color = COLOR_PALE_ORANGE
			debuff_text = "Causes [debuff_strength/100] burn drain"
		if(3) //toxin
			name_prefix = "emetic"
			color = COLOR_PALE_GREEN_GRAY
			debuff_text = "Causes [debuff_strength/100] toxin drain"
		if(4) //health
			name_prefix = "frail"
			color = null
			debuff_text = "Causes [debuff_strength/5] lower health"
		if(5) //stamina
			name_prefix = "soporific"
			color = COLOR_PALE_BLUE_GRAY
			debuff_text = "Causes [debuff_strength/100] stamina drain"
		if(6) //speed
			name_prefix = "lethargic"
			color = COLOR_PALE_PURPLE_GRAY
			debuff_text = "Causes [debuff_strength/100] less movement speed"
		if(7) //blood
			name_prefix = "bloody"
			color = COLOR_RED_GRAY
			debuff_text = "Causes [debuff_strength/100] blood drain"
		if(8) //radiation
			name_prefix = "glowing"
			color = COLOR_GREEN_GRAY
			debuff_text = "Causes [debuff_strength/100] radiation buildup"

	name = "[name_prefix] [name_suffix]"
	..()



/obj/item/artifact/high
	name = "debug high artifact"

/obj/item/artifact/high/Initialize()
	buff_type = rand(1,8)
	debuff_type = rand(1,8)

	buff_strength = rand(30,50)/10	//if you touch this, also touch export cost formula
	debuff_strength = rand(30,50)/10

	var/name_suffix
	var/name_prefix
	switch(buff_type)
		if(1) //brute
			name_suffix = "beads"
			icon_state = "mamini_busi"
			buff_text = "Provides [buff_strength/100] brute regeneration"
		if(2) //burn
			name_suffix = "fireball"
			icon_state = "fireball"
			buff_text = "Provides [buff_strength/100] burn regeneration"
		if(3) //toxin
			name_suffix = "urchin"
			icon_state = "ezh"
			buff_text = "Provides [buff_strength/100] toxin regeneration"
		if(4) //health
			name_suffix = "soul"
			icon_state = "soul"
			buff_text = "Provides [buff_strength/5] health"
		if(5) //stamina
			name_suffix = "night star"
			icon_state = "nightstar"
			buff_text = "Provides [buff_strength/100] stamina regeneration"
		if(6) //speed
			name_suffix = "firefly"
			icon_state = "firefly"
			buff_text = "Provides [buff_strength/100] movement speed"
		if(7) //blood
			name_suffix = "slug"
			icon_state = "sliznyak"
			buff_text = "Provides [buff_strength/100] blood regeneration"
		if(8) //radiation
			name_suffix = "crystal"
			icon_state = "crystal"
			buff_text = "Provides [buff_strength/100] radiation regeneration"

	switch(debuff_type)
		if(1) //brute
			name_prefix = "rending"
			color = COLOR_PALE_RED_GRAY
			debuff_text = "Causes [debuff_strength/100] brute drain"
		if(2) //burn
			name_prefix = "searing"
			color = COLOR_PALE_ORANGE
			debuff_text = "Causes [debuff_strength/100] burn drain"
		if(3) //toxin
			name_prefix = "bilious"
			color = COLOR_PALE_GREEN_GRAY
			debuff_text = "Causes [debuff_strength/100] toxin drain"
		if(4) //health
			name_prefix = "evanescent"
			color = null
			debuff_text = "Causes [debuff_strength/5] lower health"
		if(5) //stamina
			name_prefix = "exigent"
			color = COLOR_PALE_BLUE_GRAY
			debuff_text = "Causes [debuff_strength/100] stamina drain"
		if(6) //speed
			name_prefix = "torpid"
			color = COLOR_PALE_PURPLE_GRAY
			debuff_text = "Causes [debuff_strength/100] less movement speed"
		if(7) //blood
			name_prefix = "weeping"
			color = COLOR_RED_GRAY
			debuff_text = "Causes [debuff_strength/100] blood drain"
		if(8) //radiation
			name_prefix = "discharging"
			color = COLOR_GREEN_GRAY
			debuff_text = "Causes [debuff_strength/100] radiation buildup"

	name = "[name_prefix] [name_suffix]"
	..()

/datum/export/artifact
	cost = 100
	unit_name = "artifacts"
	export_types = list(/obj/item/artifact)

//ratio of 3 to 1 positive to negative is based on low artifacts where negative can be up to three times more than positive
/datum/export/artifact/get_cost(atom/movable/AM)
	var/obj/item/artifact/H = AM
	return (H.buff_strength*3 - H.debuff_strength)*10 //only change the last number to adjust value

//legendary artifacts don't get the normal initializes
/obj/item/artifact/legendary
	name = "debug legendary artifact"
	desc = "A bizarre relic with supernatual properties. It causes strange effects when fitted into your armor or jacket."
	buff_type = 0 //legendaries use their own, so lay outside the bounds of the standardized switch statement
	debuff_type = 0

	buff_strength = 100 //maths out to a total value of 3000 per legendary
	debuff_strength = 0

//apotheosis holds all possible positives at max value
//this exists as the be all, end all. it should not be found like...ever.
/obj/item/artifact/legendary/apotheosis
	name = "Apotheosis"
	icon_state = "pustishka"
	buff_text = "Most artifacts are flawed in some way or another. This one is not only perfect, but reflects the boons of all lesser artifacts."
	buff_strength = 200 //6000 credits
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
/obj/item/artifact/legendary/perfection
	name = "Perfection"
	icon_state = "pustishka_q"
	buff_text = "Most artifacts are flawed in some way or another. This one is perfect."
	debuff_type = 0
	buff_strength = 50
	debuff_strength = 0

/obj/item/artifact/legendary/perfection/Initialize()
	buff_type = rand(1,8)

	switch(buff_type)
		if(1) //brute
			name_prefix = "Salubrious"
			color = COLOR_PALE_RED_GRAY
			debuff_text = "Provides [buff_strength/100] brute regeneration" //uses debuff text because buff text is already in use
		if(2) //burn
			name_prefix = "Demulcent"
			color = COLOR_PALE_ORANGE
			debuff_text = "Provides [buff_strength/100] burn regeneration"
		if(3) //toxin
			name_prefix = "Pure"
			color = COLOR_PALE_GREEN_GRAY
			debuff_text = "Provides [buff_strength/100] toxin regeneration"
		if(4) //health
			name_prefix = "Stalwart"
			color = null
			debuff_text = "Provides [buff_strength/5] health"
		if(5) //stamina
			name_prefix = "Vigorous"
			color = COLOR_PALE_BLUE_GRAY
			debuff_text = "Provides [buff_strength/100] stamina regeneration"
		if(6) //speed
			name_prefix = "Dynamic"
			color = COLOR_PALE_PURPLE_GRAY
			debuff_text = "Provides [buff_strength/100] movement speed"
		if(7) //blood
			name_prefix = "Sanguine"
			color = COLOR_RED_GRAY
			debuff_text = "Provides [buff_strength/100] blood regeneration"
		if(8) //radiation
			name_prefix = "Luminescent"
			color = COLOR_GREEN_GRAY
			debuff_text = "Provides [buff_strength/100] radiation regeneration"
	..()
//extremely debilitating artifact 
/obj/item/artifact/legendary/penance
	name = "Penance"
	icon_state = "pustishka_old"
	buff_text = "This artifact bears all the flaws of the world. May the gods have mercy on any who carry it."
	buff_strength = 10 //worth zero
	debuff_strength = 30

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

/obj/item/artifact/legendary/bubble //luv u dan
	name = "Bubble"
	icon_state = "bubble"
	buff_text = "Some call this artifact the Cornucopia."

	/*
	if(!HAS_TRAIT(M, TRAIT_NO_PROCESS_FOOD)) //this is copypasted, so not sure if it's all correct
		current_cycle++
		M.adjust_nutrition(1, max_nutrition) //a quarter the nutrient value of standard food, but persistent
	M.CheckBloodsuckerEatFood(1)
			*/
