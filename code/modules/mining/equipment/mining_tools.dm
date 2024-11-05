/*****************Pickaxes & Drills & Shovels****************/
/obj/item/pickaxe
	name = "pickaxe"
	icon = 'icons/obj/mining.dmi'
	icon_state = "pickaxe"
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 60
	attack_speed = CLICK_CD_MELEE * 1.35
	throwforce = 40
	inhand_icon_state = "pickaxe"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=2000) //one sheet, but where can you make them?
	tool_behaviour = TOOL_MINING
	toolspeed = 1
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	attack_verb = list("hit", "pierced", "sliced", "attacked")
	var/digrange = 1

/obj/item/pickaxe/attack_self(mob/user)
	if(initial(digrange) > 0)
		if(digrange == 0)
			digrange = initial(digrange)
			toolspeed = initial(toolspeed)
			to_chat(user, span_notice("You increase the tools dig range, decreasing its mining speed."))
		else
			digrange = 0
			toolspeed = toolspeed/2
			to_chat(user, span_notice("You decrease the tools dig range, increasing its mining speed."))
	else
		to_chat(user, span_notice("Tool does not have a configureable dig range."))

/obj/item/pickaxe/mini
	name = "compact pickaxe"
	desc = "A smaller, compact version of the standard pickaxe."
	icon_state = "minipick"
	force = 15
	force_unwielded = 15
	force_wielded = 30
	throwforce = 15
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=1000)

/obj/item/pickaxe/silver
	name = "silver-plated pickaxe"
	icon_state = "spickaxe"
	inhand_icon_state = "spickaxe"
	toolspeed = 0.5 //mines faster than a normal pickaxe, bought from mining vendor
	desc = "A silver-plated pickaxe that mines slightly faster than standard-issue."
	force = 15
	force_unwielded = 15
	force_wielded = 50
	attack_speed = CLICK_CD_MELEE * 1.25
	custom_materials = list(/datum/material/silver=4000)

/obj/item/pickaxe/diamond
	name = "diamond-tipped pickaxe"
	icon_state = "dpickaxe"
	inhand_icon_state = "dpickaxe"
	toolspeed = 0.3
	desc = "A pickaxe with a diamond pick head. Extremely robust at cracking rock walls and digging up dirt."
	force = 25
	force_unwielded = 25
	force_wielded = 65
	attack_speed = CLICK_CD_MELEE * 1.45
	custom_materials = list(/datum/material/diamond=4000)

/obj/item/pickaxe/rosegold
	name = "rose gold pickaxe"
	icon_state = "rgpickaxe"
	inhand_icon_state = "rgpickaxe"
	toolspeed = 0.1
	desc = "A pickaxe with a light rose gold head and some red glowing runes. Extremely robust at cracking rock walls and digging up dirt."
	force = 20
	force_unwielded = 20
	force_wielded = 60
	attack_speed = CLICK_CD_MELEE * 1
	custom_materials = list(/datum/material/gold=4000)
	digrange = 3

/obj/item/pickaxe/plasteel
	name = "plasteel-tipped pickaxe"
	icon_state = "titaxe"
	toolspeed = 0.5
	desc = "A pickaxe with a plasteel pick head. Less robust at cracking rock walls and digging up dirt than the titanium pickaxe, but better at cracking open skulls."
	force = 25
	force_unwielded = 25
	force_wielded = 65
	attack_speed = CLICK_CD_MELEE * 1.45
	custom_materials = list(/datum/material/iron=2000, /datum/material/plasma=2000)

/obj/item/pickaxe/titanium
	name = "titanium-tipped pickaxe"
	icon_state = "psteelaxe"
	toolspeed = 0.3
	desc = "A pickaxe with a titanium pick head. Extremely robust at cracking rock walls and digging up dirt, but less than the plasteel pickaxe at cracking open skulls."
	force = 20
	force_unwielded = 20
	force_wielded = 60
	attack_speed = CLICK_CD_MELEE * 1.15
	custom_materials = list(/datum/material/titanium=4000)

/obj/item/pickaxe/drill
	name = "mining drill"
	icon_state = "handdrill"
	inhand_icon_state = "jackhammer"
	slot_flags = INV_SLOTBIT_BELT
	force = 40
	force_unwielded = 40
	force_wielded = 45 // You're drilling people, not smashing them like a pick.
	attack_speed = CLICK_CD_MELEE * 1.25
	toolspeed = 0.6 //available from roundstart, faster than a pickaxe.
	usesound = 'sound/weapons/drill.ogg'
	hitsound = 'sound/weapons/drill.ogg'
	desc = "An electric mining drill for the especially scrawny."

/obj/item/pickaxe/drill/cyborg
	name = "cyborg mining drill"
	desc = "An integrated electric mining drill."
	flags_1 = NONE
	toolspeed = 0.5

/obj/item/pickaxe/drill/cyborg/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CYBORG_ITEM_TRAIT)

/obj/item/pickaxe/drill/diamonddrill
	name = "diamond-tipped mining drill"
	icon_state = "diamonddrill"
	toolspeed = 0.4
	desc = "Yours is the drill that will pierce the heavens!"

/obj/item/pickaxe/drill/cyborg/diamond //This is the BORG version!
	name = "diamond-tipped cyborg mining drill" //To inherit the NODROP_1 flag, and easier to change borg specific drill mechanics.
	icon_state = "diamonddrill"
	toolspeed = 0.4
	digrange = 2
	force = 45
	force_unwielded = 45
	force_wielded = 60 // You're drilling people, not smashing them like a pick.
	attack_speed = CLICK_CD_MELEE * 1.30

/obj/item/pickaxe/drill/jackhammer
	name = "sonic jackhammer"
	icon_state = "jackhammer"
	inhand_icon_state = "jackhammer"
	w_class = WEIGHT_CLASS_HUGE
	toolspeed = 0.2 //the epitome of powertools. extremely fast mining, laughs at puny walls
	usesound = 'sound/weapons/sonic_jackhammer.ogg'
	hitsound = 'sound/weapons/sonic_jackhammer.ogg'
	desc = "Cracks rocks with sonic blasts, and doubles as a demolition power tool for smashing walls."
	digrange = 2
	force = 25
	force_unwielded = 25
	force_wielded = 35 // It's a sonic tool, not a weapon. Trades all combat for diggy diggy hole
	attack_speed = CLICK_CD_MELEE * 1.25

/obj/item/shovel
	name = "shovel"
	desc = "A large tool for digging and moving dirt. Also useful as a weapon if one has nothing better."
	icon = 'icons/obj/mining.dmi'
	icon_state = "shovel"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT
	w_class = WEIGHT_CLASS_BULKY
	force = 15
	force_unwielded = 15
	force_wielded = 32
	weapon_special_component = /datum/component/weapon_special/ranged_spear
	tool_behaviour = TOOL_SHOVEL
	toolspeed = 0.1 //Can only dig ash and thats about it, out classed by the picks and drills no more!
	usesound = 'sound/effects/shovel_dig.ogg'
	throwforce = 30
	inhand_icon_state = "shovel"
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron=350)
	attack_verb = list("bashed", "bludgeoned", "thrashed", "whacked")
	sharpness = SHARP_EDGED

/obj/item/shovel/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 150, 40) //it's sharp, so it works, but barely.

/obj/item/shovel/serrated
	name = "serrated bone shovel"
	desc = "A wicked tool that cleaves through dirt just as easily as it does flesh. The design was styled after ancient tribal designs."
	icon_state = "shovel_bone"
	inhand_icon_state = "shovel_bone"
	lefthand_file = 'icons/mob/inhands/equipment/mining_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/mining_righthand.dmi'
	force = 25
	force_unwielded = 25
	force_wielded = 40
	throwforce = 40
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7
	attack_verb = list("slashed", "impaled", "stabbed", "sliced")
	sharpness = SHARP_EDGED
