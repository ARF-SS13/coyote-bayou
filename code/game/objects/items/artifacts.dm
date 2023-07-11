

/obj/item/artifact
	name = "debug artifact"
	desc = "A bizarre relic with supernatual properties. It causes strange effects when fitted into your armor or jacket."
	icon = 'icons/obj/artifacts.dmi'
	icon_state = "battery"
	w_class = WEIGHT_CLASS_SMALL

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
			remove_movespeed_modifier(/datum/movespeed_modifier/artifact)
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
	.+= "[buff_text]"
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
			buff_text = "Provides .[buff_strength] brute regeneration"
		if(2) //burn
			name_suffix = "jellyfish" //adv is fireball
			icon_state = "meduza"
			buff_text = "Provides .[buff_strength] burn regeneration"
		if(3) //toxin
			name_suffix = "thorn" //adv is urchin/ezh
			icon_state = "koluchka"
			buff_text = "Provides .[buff_strength] toxin regeneration"
		if(4) //health
			name_suffix = "stone blood" //adv is soul
			icon_state = "stone_blood"
			buff_text = "Provides [buff_strength/5] health"
		if(5) //stamina
			name_suffix = "moonlight" //adv is night star
			icon_state = "moonlight"
			buff_text = "Provides .[buff_strength] stamina regeneration"
		if(6) //speed
			name_suffix = "mica" //adv is firefly
			icon_state = "mica"
			buff_text = "Provides .[buff_strength] movement speed"
		if(7) //blood
			name_suffix = "slime" //adv is slug/sliznyak
			icon_state = "sliz"
			buff_text = "Provides .[buff_strength] blood regeneration"
		if(8) //radiation
			name_suffix = "droplet" //adv is crystal
			icon_state = "droplet"
			buff_text = "Provides .[buff_strength] radiation regeneration"

	switch(debuff_type)
		if(1) //brute
			name_prefix = "aching" //adv is stinging
			color = COLOR_PALE_RED_GRAY
			debuff_text = "Causes .[debuff_strength] brute drain"
		if(2) //burn
			name_prefix = "smoldering" //adv is searing
			color = COLOR_PALE_ORANGE
			debuff_text = "Causes .[debuff_strength] burn drain"
		if(3) //toxin
			name_prefix = "nauseating" //adv is sickening
			color = COLOR_PALE_GREEN_GRAY
			debuff_text = "Causes .[debuff_strength] toxin drain"
		if(4) //health
			name_prefix = "enfeebling" //adv is debilitating
			color = null
			debuff_text = "Causes [debuff_strength/5] lower health"
		if(5) //stamina
			name_prefix = "weakening" //adv is exhausting
			color = COLOR_PALE_BLUE_GRAY
			debuff_text = "Causes .[debuff_strength] stamina drain"
		if(6) //speed
			name_prefix = "slowing" //adv is dragging
			color = COLOR_PALE_PURPLE_GRAY
			debuff_text = "Causes .[debuff_strength] less movement speed"
		if(7) //blood
			name_prefix = "dripping" //adv is exsanguinating
			color = COLOR_RED_GRAY
			debuff_text = "Causes .[debuff_strength] blood drain"
		if(8) //radiation
			name_prefix = "glowing" //adv is discharging
			color = COLOR_GREEN_GRAY
			debuff_text = "Causes .[debuff_strength] radiation buildup"

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
			buff_text = "Provides .[buff_strength] brute regeneration"
		if(2) //burn
			name_suffix = "fireball"
			icon_state = "fireball"
			buff_text = "Provides .[buff_strength] burn regeneration"
		if(3) //toxin
			name_suffix = "urchin"
			icon_state = "ezh"
			buff_text = "Provides .[buff_strength] toxin regeneration"
		if(4) //health
			name_suffix = "soul"
			icon_state = "soul"
			buff_text = "Provides [buff_strength/5] health"
		if(5) //stamina
			name_suffix = "night star"
			icon_state = "nightstar"
			buff_text = "Provides .[buff_strength] stamina regeneration"
		if(6) //speed
			name_suffix = "firefly"
			icon_state = "firefly"
			buff_text = "Provides .[buff_strength] movement speed"
		if(7) //blood
			name_suffix = "slug"
			icon_state = "sliznyak"
			buff_text = "Provides .[buff_strength] blood regeneration"
		if(8) //radiation
			name_suffix = "crystal"
			icon_state = "crystal"
			buff_text = "Provides .[buff_strength] radiation regeneration"

	switch(debuff_type)
		if(1) //brute
			name_prefix = "stinging"
			color = COLOR_PALE_RED_GRAY
			debuff_text = "Causes .[debuff_strength] brute drain"
		if(2) //burn
			name_prefix = "searing"
			color = COLOR_PALE_ORANGE
			debuff_text = "Causes .[debuff_strength] burn drain"
		if(3) //toxin
			name_prefix = "sickening"
			color = COLOR_PALE_GREEN_GRAY
			debuff_text = "Causes .[debuff_strength] toxin drain"
		if(4) //health
			name_prefix = "debilitating"
			color = null
			debuff_text = "Causes [debuff_strength/5] lower health"
		if(5) //stamina
			name_prefix = "exhausting"
			color = COLOR_PALE_BLUE_GRAY
			debuff_text = "Causes .[debuff_strength] stamina drain"
		if(6) //speed
			name_prefix = "dragging"
			color = COLOR_PALE_PURPLE_GRAY
			debuff_text = "Causes .[debuff_strength] less movement speed"
		if(7) //blood
			name_prefix = "weeping"
			color = COLOR_RED_GRAY
			debuff_text = "Causes .[debuff_strength] blood drain"
		if(8) //radiation
			name_prefix = "discharging"
			color = COLOR_GREEN_GRAY
			debuff_text = "Causes .[debuff_strength] radiation buildup"

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

