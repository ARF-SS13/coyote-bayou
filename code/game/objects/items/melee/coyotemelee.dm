/obj/item/melee/coyote/oldclaymore
	name = "old claymore"
	desc = "The owner of this knows the price of their freedom."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "claymore_old"
	item_state = "claymore"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 25
	force_unwielded = 25
	force_wielded = 47
	throwforce = 23
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "have'd at the")
	hitsound = 'sound/weapons/slice.ogg'
	block_chance = 5

/obj/item/melee/coyote/harpoon 
	name = "old harpoon"
	desc = "White whale, holy grail."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "harpoon"
	item_state = "harpoon"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 40
	throwforce = 35
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/melee/coyote/katanaold //Technically a worse scrap sabre, but stylistic as shit so eat my ass I guess ~TK
	name = "old katana"
	desc = "Sharp, and as well taken care of as one can expect in the wastes, it's a wonder this object even exists."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "katana"
	item_state = "katana"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 28
	force_unwielded = 28
	force_wielded = 38
	throwforce = 23
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 15

/obj/item/melee/coyote/wakazashiold 
	name = "old wakazashi"
	desc = "Sharp, and well cared for. Such a strange blade in this land."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "wakazashi"
	item_state = "wakazashi"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 20
	force_unwielded = 20
	force_wielded = 28
	throwforce = 20
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10

/obj/item/melee/coyote/tantoold 
	name = "old tanto"
	desc = "Sharp, and well cared for. This small blade carries a lot of weight for its size."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "tanto"
	item_state = "tanto"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 15
	force_unwielded = 15
	force_wielded = 22
	throwforce = 15
	wound_bonus = 10
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7
	block_chance = 5

/obj/item/melee/coyote/combataxe 
	name = "Combat Axe"
	desc = "An axe made specifically for more modern combats, its got a handguard!"
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "combat_axe"
	item_state = "combat_axe"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 25
	force_unwielded = 25
	force_wielded = 35
	throwforce = 30
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "hacked")
	hitsound = 'sound/weapons/slice.ogg'
	block_chance = 5

/obj/item/melee/coyote/smallsword
	name = "Small Sword"
	desc = "Not really a dagger, not really a short sword. This things a mess(er)."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "smallsword2"
	item_state = "smallsword"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 20
	force_unwielded = 20
	force_wielded = 28
	throwforce = 20
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 10

/obj/item/melee/coyote/oldcutlass
	name = "Old Cutlass"
	desc = "Enterprising, maybe even a bit bucaneering. This blades drawn blood, but seems to lack a salty crust."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "cutlass"
	item_state = "cutlass"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 28
	force_unwielded = 28
	force_wielded = 35
	throwforce = 28
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "swashbuckled")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.9
	block_chance = 8

/obj/item/melee/coyote/crudeblade
	name = "Crude Blade"
	desc = "Sort of sharp, this gigantic blade is big enough to be used defensively pretty reliably. It hits like a truck too, but takes a lot of time to do so."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "crude"
	item_state = "crude"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 55
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "smashed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 1.8
	block_chance = 40

/obj/item/melee/coyote/oldkanobo
	name = "Old Kanobo"
	desc = "This gigantic club somewhat resembles a baseball bat, if you squinted a bit. Its studded with steel and built like a fucking tank though."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "kanabo"
	item_state = "kanabo"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 55
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "smashed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 1.8
	block_chance = 40

/obj/item/melee/coyote/mauler
	name = "Mauler"
	desc = "There is nothing subtle about this hulking spiked ball on a stick. The saving grace of the wasteland is that its slow to swing."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "maul"
	item_state = "mauler1"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 65
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 2.5

/obj/item/melee/coyote/club
	name = "club"
	desc = "At the end of time the weapons of the dawn of man still have a place. This branch of bois'd'arc ain't fucking around."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "club"
	item_state = "club"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 20
	force_unwielded = 20
	force_wielded = 25
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7

/obj/item/melee/coyote/bigclub
	name = "big club"
	desc = "At the end of time the weapons of the dawn of man still have a place. This big ass branch of bois'd'arc ain't fucking around."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "big_club"
	item_state = "big_club"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 25
	force_unwielded = 25
	force_wielded = 40
	throwforce = 30
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.9

/obj/item/melee/coyote/oldlongsword
	name = "Old Longsword"
	desc = "An old longsword thats kept a decent edge."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "longsword"
	item_state = "longsword2"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 28
	force_unwielded = 28
	force_wielded = 35
	throwforce = 28
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "swashbuckled")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.9
	block_chance = 8

/obj/item/melee/coyote/oldhalberd
	name = "Old Halberd"
	desc = "A deviously simple weapon, it conjures images of town guards and long squiggly flags."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "halberd"
	item_state = "halberd"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 40
	throwforce = 35
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/melee/coyote/oldpike
	name = "Old Pike"
	desc = "A spear, but more. This very long weapon has even more reach than a normal spear but is a bit unwieldy to use, downright impossible up close."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "pike"
	item_state = "pike"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 40
	throwforce = 35
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 1.5
	weapon_special_component = /datum/component/weapon_special/ranged_spear/longer/pike

/obj/item/melee/coyote/oldnaginata
	name = "Old Naginata"
	desc = "An oriental looking blade on a stick."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "naginata"
	item_state = "naginata"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 40
	throwforce = 35
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	block_chance = 10
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/melee/coyote/oldashandarei
	name = "Old Ashandarei"
	desc = "An curved blade on a brown stick. Similar to a Naginata, but shorter and handier."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "naginata"
	item_state = "naginata"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BACK
	force = 18
	force_unwielded = 18
	force_wielded = 35
	throwforce = 30
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 15

/obj/item/melee/coyote/macuahuitl
	name = "Macuahuitl"
	desc = "Obsidian on a stick, eat your heart out."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "macuahuitl"
	item_state = "macuahuitl"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 20
	force_unwielded = 20
	force_wielded = 30
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("batter-gashed", "sliced", "diced")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8

/obj/item/melee/coyote/oldkhopesh
	name = "Old Khopesh"
	desc = "Man, you could really use a chariot right now. This curved blade acts more like an axe than a sword does, chopping comes easy."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "khopesh"
	item_state = "khopesh"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 28
	force_unwielded = 28
	force_wielded = 38
	throwforce = 28
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.9
	block_chance = 8

/obj/item/melee/classic_baton/coyote/oldquarterstaff
	name = "Old Quarterstaff"
	desc = "That's a pole, it's for whomping."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "quarterstaff"
	item_state = "quarterstaff"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 10
	force_unwielded = 10
	force_wielded = 20
	throwforce = 15
	wound_bonus = 15
	stam_dmg = 30
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7
	block_chance = 15

/obj/item/melee/classic_baton/coyote/oldquarterstaff/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(60, STAMINA, "chest", M.run_armor_check("chest", "brute"))

/obj/item/melee/coyote/olddervish
	name = "Old Dervish Blade"
	desc = "Shall we dance the dance of death, wetlander?"
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "umar_sword"
	item_state = "umar_sword"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 28
	force_unwielded = 28
	force_wielded = 38
	throwforce = 28
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.9
	block_chance = 8

/obj/item/melee/coyote/oldpike/sarissa
	name = "Old Sarissa"
	desc = "The clouds are blotting out the sun today. We can fight in the shade."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "sarissa"
	item_state = "sarissa"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'

/obj/item/melee/coyote/oldlongsword/spadroon
	name = "Old Spadroon"
	desc = "A soldiers sword, with tight tolerances."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "spadroon"
	item_state = "spadroon"

/obj/item/melee/coyote/oldlongsword/broadsword
	name = "Old Broadsword"
	desc = "A wide blade for a deep wound."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "broadsword"
	item_state = "broadsword"

/obj/item/melee/coyote/oldlongsword/armingsword
	name = "Old Arming Sword"
	desc = "Disclaimer: Not all that great at chopping arms off."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "armingsword"
	item_state = "armingsword"

/obj/item/melee/coyote/oldlongsword/longquan
	name = "Old Chinese Sword"
	desc = "The Communist blade cuts on both sides, or something."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "longquan"
	item_state = "longquan"

/obj/item/melee/coyote/oldlongsword/xiphos
	name = "Old Xiphos"
	desc = "For what some of its owners may have done in the past this thing ain't all that great."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "xiphos"
	item_state = "xiphos"

//danimaul//
//why am I making this
//please no

/obj/item/melee/coyote/danhead
	name = "dan's head on a stick"
	icon = 'modular_coyote/icons/objects/danimaul.dmi'
	lefthand_file = 'modular_coyote/icons/objects/danimaulinhandleft.dmi'
	righthand_file = 'modular_coyote/icons/objects/danimaulinhandright.dmi'
	icon_state = "danimauler"
	item_state = "danimauler"
	force = 5
	force_unwielded = 5
	force_wielded = 10
	hitsound = 'sound/f13effects/sunsetsounds/geck.ogg'

/obj/item/melee/coyote/danhead/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(100, STAMINA, "chest", M.run_armor_check("chest", "brute"))





