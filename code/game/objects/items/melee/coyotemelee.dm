/obj/item/melee/coyote/
	name = "Generic Coyote Melee Weapon"
	desc = "Snarpening my snife for my snins."
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "claymore_old"
	inhand_icon_state = "claymore"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
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

/obj/item/melee/coyote/oldclaymore
	name = "old claymore"
	desc = "The owner of this knows the price of their freedom."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "claymore_old"
	inhand_icon_state = "claymore"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 30
	backstab_multiplier = 1.1
	force_unwielded = 30
	force_wielded = 75
	throwforce = 30
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "have'd at the")
	hitsound = 'sound/weapons/slice.ogg'
	block_chance = 10

/obj/item/melee/coyote/harpoon
	name = "old harpoon"
	desc = "White whale, holy grail."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "harpoon"
	inhand_icon_state = "harpoon"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 25
	force_unwielded = 25
	force_wielded = 55
	backstab_multiplier = 1.6 //I mean, it's a harpoon.  Aren't they kind of MADE for stabbing fat things in the back?
	throwforce = 55
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	weapon_special_component = /datum/component/weapon_special/ranged_spear
	block_chance = 15

/obj/item/melee/coyote/katanaold //Technically a worse scrap sabre, but stylistic as shit so eat my ass I guess ~TK
	name = "old katana"
	desc = "Sharp, and as well taken care of as one can expect in the wastes, it's a wonder this object even exists."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "katana"
	inhand_icon_state = "katana"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 40
	force_unwielded = 40
	force_wielded = 50
	backstab_multiplier = 1.5
	throwforce = 23
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 8

/obj/item/melee/coyote/wakazashiold
	name = "old wakazashi"
	desc = "Sharp, and well cared for. Such a strange blade in this land."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "wakazashi"
	inhand_icon_state = "wakazashi"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 30
	force_unwielded = 30
	force_wielded = 42
	backstab_multiplier = 1.1
	throwforce = 20
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.8
	block_chance = 3

/obj/item/melee/coyote/tantoold
	name = "old tanto"
	desc = "Sharp, and well cared for. This small blade carries a lot of weight for its size."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "tanto"
	inhand_icon_state = "tanto"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20
	force_wielded = 25
	backstab_multiplier = 4
	throwforce = 15
	wound_bonus = 10
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 0.6
	block_chance = 1

/obj/item/melee/coyote/combataxe
	name = "Combat Axe"
	desc = "An axe made specifically for more modern combats, its got a handguard!"
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "combat_axe"
	inhand_icon_state = "combat_axe"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35
	force_unwielded = 35
	force_wielded = 50
	backstab_multiplier = 1.5
	throwforce = 35
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "hacked")
	hitsound = 'sound/weapons/slice.ogg'
	block_chance = 8

/obj/item/melee/coyote/smallsword
	name = "Small Sword"
	desc = "Not really a dagger, not really a short sword. This things a mess(er)."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "smallsword2"
	inhand_icon_state = "smallsword"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35 // 45 = MW, 55 = Masterwork + Whetstone, 65 = Master Work + Whetstone + Big leagues 
	force_unwielded = 35 // 
	force_wielded = 45 // 75 max extra damage. As a treat. 
	block_chance = 3 // learn to parry, filthy casual
	attack_speed = CLICK_CD_MELEE * 1.1 
	backstab_multiplier = 1.1
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("slashed", "sliced", "ginsu'd")
	hitsound = 'sound/weapons/slice.ogg'
	

/obj/item/melee/coyote/oldcutlass
	name = "Old Cutlass"
	desc = "Enterprising, maybe even a bit bucaneering. This blades drawn blood, but seems to lack a salty crust."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "cutlass"
	inhand_icon_state = "cutlass"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 40
	force_unwielded = 40 // 70 max
	force_wielded = 50 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "swashbuckled")
	hitsound = 'sound/weapons/slice.ogg'
	

/obj/item/melee/coyote/crudeblade
	name = "Crude Blade"
	desc = "Sort of sharp, this gigantic blade is big enough to be used defensively pretty reliably. It hits like a truck too, but takes a lot of time to do so."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "crude"
	inhand_icon_state = "crude"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 80
	backstab_multiplier = 2 //Very rewarding backstab smash attack
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("slashed", "sliced", "smashed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 1.8
	block_chance = 20

/obj/item/melee/coyote/oldkanobo
	name = "Old Kanobo"
	desc = "This gigantic club somewhat resembles a baseball bat, if you squinted a bit. Its studded with steel and built like a fucking tank though."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "kanabo"
	inhand_icon_state = "kanabo"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 80
	backstab_multiplier = 2 //Very rewarding backstab smash attack
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("slashed", "sliced", "smashed")
	hitsound = 'sound/weapons/slice.ogg'
	attack_speed = CLICK_CD_MELEE * 1.8
	block_chance = 20

/obj/item/melee/coyote/mauler
	name = "Mauler"
	desc = "There is nothing subtle about this hulking spiked ball on a stick. The saving grace of the wasteland is that its slow to swing."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "maul"
	inhand_icon_state = "mauler1"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 10 //Needs to be wielded
	force_unwielded = 10
	force_wielded = 90
	backstab_multiplier = 1.7 //Very rewarding backstab smash attack
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 2.5

/obj/item/melee/coyote/club
	name = "club"
	desc = "At the end of time the weapons of the dawn of man still have a place. This branch of bois'd'arc ain't fucking around."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "club"
	inhand_icon_state = "club"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 30 // 45 = MW, 55 = Masterwork + Whetstone, 65 = Master Work + Whetstone + Big leagues 
	force_unwielded = 30 // 
	force_wielded = 40 // 75 max extra damage. As a treat. 
	block_chance = 3 // learn to parry, filthy casual
	attack_speed = CLICK_CD_MELEE * 1.1 
	backstab_multiplier = 1.1	
	throwforce = 25
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'
	

/obj/item/melee/coyote/club/mace
	name = "mace"
	desc = "A fucking metal whacking stick. Whack them with it."
	icon_state = "mace"
	inhand_icon_state = "mace"

/obj/item/melee/coyote/bigclub
	name = "big club"
	desc = "At the end of time the weapons of the dawn of man still have a place. This big ass branch of bois'd'arc ain't fucking around."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "big_club"
	inhand_icon_state = "big_club"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35
	force_unwielded = 35 // 70 max
	force_wielded = 45 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat	
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("wrecked", "bashed", "smashed")
	hitsound = 'sound/weapons/smash.ogg'

/obj/item/melee/coyote/oldlongsword
	name = "Old Longsword"
	desc = "An old longsword thats kept a decent edge."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "longsword"
	inhand_icon_state = "longsword2"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35
	force_unwielded = 35 // 70 max
	force_wielded = 45 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "swashbuckled")
	hitsound = 'sound/weapons/slice.ogg'

/obj/item/melee/coyote/oldlongsword/kuddleslongsword
	name = "Break of Dawn"
	desc = "This brilliant sword has had its link severed from its source of power, in such a way it can't even call out to the being that forged it. Despite being deprived of its magic, the blade's razor sharp edge never dulls and the light of its crystal never extinguishes. An artifact of its wielder's faith."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "dawnbreaker"
	light_system = MOVABLE_LIGHT
	light_range = 3
	light_on = FALSE

/obj/item/melee/coyote/oldlongsword/kuddleslongsword/Initialize()
	. = ..()
	set_light_on(TRUE)
	START_PROCESSING(SSobj, src)

/obj/item/melee/coyote/oldlongsword/kuddleslongsword/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/melee/coyote/oldhalberd
	name = "Old Halberd"
	desc = "A deviously simple weapon, it conjures images of town guards and long squiggly flags."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "halberd"
	inhand_icon_state = "halberd"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20 // 35 max
	force_wielded = 55 // 90 max
	throwforce = 55
	block_chance = 15 // P-Much a dedicated blocking weapon
	attack_speed = CLICK_CD_MELEE * 1.5  // slow as sin to make up for it
	backstab_multiplier = 2 // makes an otherwise non-position heavy weapon a little more tactical
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
	inhand_icon_state = "pike"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20 // 35 max
	force_wielded = 55 // 90 max
	throwforce = 55
	block_chance = 15 // P-Much a dedicated blocking weapon
	attack_speed = CLICK_CD_MELEE * 1.5  // slow as sin to make up for it
	backstab_multiplier = 2 // makes an otherwise non-position heavy weapon a little more tactical	
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'
	weapon_special_component = /datum/component/weapon_special/ranged_spear

/obj/item/melee/coyote/oldnaginata
	name = "Old Naginata" // Nobushi kick spammer was here.
	desc = "An oriental looking blade on a stick." /* ForHonor */
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "naginata"
	inhand_icon_state = "naginata"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20 // 35 max
	force_wielded = 55 // 90 max
	throwforce = 55
	block_chance = 15 // P-Much a dedicated blocking weapon
	attack_speed = CLICK_CD_MELEE * 1.5  // slow as sin to make up for it
	backstab_multiplier = 2 // makes an otherwise non-position heavy weapon a little more tactical
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
	inhand_icon_state = "naginata"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 20
	force_unwielded = 20 // 35 max
	force_wielded = 55 // 90 max
	throwforce = 55
	block_chance = 15 // P-Much a dedicated blocking weapon
	attack_speed = CLICK_CD_MELEE * 1.5  // slow as sin to make up for it
	backstab_multiplier = 2 // makes an otherwise non-position heavy weapon a little more tactical
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("impaled", "gored", "stabbed")
	hitsound = 'sound/weapons/slice.ogg'


/obj/item/melee/coyote/macuahuitl
	name = "Macuahuitl"
	desc = "Obsidian on a stick, eat your heart out."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "macuahuitl"
	inhand_icon_state = "macuahuitl"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35
	force_unwielded = 35 // 70 max
	force_wielded = 45 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat
	wound_bonus = 20
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("batter-gashed", "sliced", "diced")
	hitsound = 'sound/weapons/smash.ogg'

/obj/item/melee/coyote/oldkhopesh
	name = "Old Khopesh"
	desc = "Man, you could really use a chariot right now. This curved blade acts more like an axe than a sword does, chopping comes easy."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "khopesh"
	inhand_icon_state = "khopesh"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 35
	force_unwielded = 35 // 70 max
	force_wielded = 45 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/slice.ogg'

/obj/item/melee/classic_baton/coyote/oldquarterstaff
	name = "Old Quarterstaff"
	desc = "That's a pole, it's for whomping."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "quarterstaff"
	inhand_icon_state = "quarterstaff"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 10
	force_unwielded = 10
	force_wielded = 20
	backstab_multiplier = 2 //I swear to god I will make quarterstaff meta real ~TK
	throwforce = 15
	wound_bonus = 15
	stam_dmg = 30
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7
	block_chance = 15

/* /obj/item/melee/classic_baton/coyote/oldquarterstaff/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M) || !CheckAttackCooldown(user, M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "brute")) */ //How about we stop instantly stamina critting people in power armor

/obj/item/melee/classic_baton/coyote/oldquarterstaff/oldbokken
	name = "Old Bokken"
	desc = "That's a wooden... sword? For beating up idiots?"
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "bokken"
	inhand_icon_state = "bokken"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 10
	force_unwielded = 10
	force_wielded = 20
	throwforce = 15
	wound_bonus = 15
	stam_dmg = 30
	bare_wound_bonus = 10
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7
	block_chance = 15

/* /obj/item/melee/classic_baton/coyote/oldquarterstaff/oldbokken/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M) || !CheckAttackCooldown(user, M))
		return
	M.apply_damage(30, STAMINA, "chest", M.run_armor_check("chest", "brute")) Silence, code, be quiet for 1 million years*/

/obj/item/melee/classic_baton/coyote/oldquarterstaff/disputestick
	name = "Dispute Stick"
	desc = "A large stick, culturally used for dispute duels, whoevers still standing by the end had a better argument."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "handle"
	inhand_icon_state = "debranched_stick_old"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 0
	throwforce = 0
	wound_bonus = -20
	force_unwielded = 0
	force_wielded = 0
	stam_dmg = 18
	cooldown = 13
	bare_wound_bonus = 0
	sharpness = SHARP_NONE
	w_class = WEIGHT_CLASS_TINY
	attack_verb = list("articulated", "clocked", "bonked")
	hitsound = 'sound/weapons/smash.ogg'
	attack_speed = CLICK_CD_MELEE * 0.7
	block_chance = 30 // Skill based gameplay

/obj/item/melee/coyote/olddervish
	name = "Old Dervish Blade"
	desc = "Shall we dance the dance of death, wetlander?"
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "umar_sword"
	inhand_icon_state = "umar_sword"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	flags_1 = CONDUCT_1
	slot_flags = INV_SLOTBIT_BELT | INV_SLOTBIT_BACK
	force = 40
	force_unwielded = 40 // 70 max
	force_wielded = 50 // 80 max
	throwforce = 0 
	block_chance = 8 // kinda like before, because I know you won't be parrying.
	attack_speed = CLICK_CD_MELEE * 1.1 
	armour_penetration =  0.1 // as a treat
	backstab_multiplier = 1.5 // as a treat
	wound_bonus = 15
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("slashed", "sliced", "chopped")
	hitsound = 'sound/weapons/slice.ogg'

/obj/item/melee/coyote/oldpike/sarissa
	name = "Old Sarissa"
	desc = "The clouds are blotting out the sun today. We can fight in the shade."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "sarissa"
	inhand_icon_state = "sarissa"
	lefthand_file = 'modular_coyote/icons/objects/lefthand_weapons.dmi'
	righthand_file = 'modular_coyote/icons/objects/righthand_weapons.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/back.dmi'

/obj/item/melee/coyote/oldlongsword/spadroon
	name = "Old Spadroon"
	desc = "A soldiers sword, with tight tolerances."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "spadroon"
	inhand_icon_state = "spadroon"

/obj/item/melee/coyote/oldlongsword/broadsword
	name = "Old Broadsword"
	desc = "A wide blade for a deep wound."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "broadsword"
	inhand_icon_state = "broadsword"

/obj/item/melee/coyote/oldlongsword/armingsword
	name = "Old Arming Sword"
	desc = "Disclaimer: Not all that great at chopping arms off."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "armingsword"
	inhand_icon_state = "armingsword"

/obj/item/melee/coyote/oldlongsword/longquan
	name = "Old Chinese Sword"
	desc = "The Communist blade cuts on both sides, or something."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "longquan"
	inhand_icon_state = "longquan"

/obj/item/melee/coyote/oldlongsword/xiphos
	name = "Old Xiphos"
	desc = "For what some of its owners may have done in the past this thing ain't all that great."
	icon = 'modular_coyote/icons/objects/weapons.dmi'
	icon_state = "xiphos"
	inhand_icon_state = "xiphos"

//danimaul//
//why am I making this
//please no

/obj/item/melee/coyote/danimaul
	name = "dan's head on a stick"
	icon = 'modular_coyote/icons/objects/danimaul.dmi'
	lefthand_file = 'modular_coyote/icons/objects/danimaulinhandleft.dmi'
	righthand_file = 'modular_coyote/icons/objects/danimaulinhandright.dmi'
	icon_state = "danimauler"
	inhand_icon_state = "danimauler"
	force = 5
	force_unwielded = 5
	force_wielded = 200
	backstab_multiplier = 478 //get sat on, idiot ~TK
	hitsound = 'sound/f13effects/sunsetsounds/geck.ogg'

/obj/item/melee/coyote/danhead/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!istype(M))
		return
	M.apply_damage(100, STAMINA, "chest", M.run_armor_check("chest", "brute"))





