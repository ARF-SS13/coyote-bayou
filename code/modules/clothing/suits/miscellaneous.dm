/*
 * Contains:
 *		Lasertag
 *		Costume
 *		Misc
 */

/*
 * Lasertag
 */
/obj/item/clothing/suit/bluetag
	name = "blue laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to red light." //Lasers are concentrated light
	icon_state = "bluetag"
	item_state = "bluetag"
	blood_overlay_type = "armor"
	allowed = list (/obj/item/gun/energy/laser/bluetag)
	resistance_flags = NONE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/redtag
	name = "red laser tag armor"
	desc = "A piece of plastic armor. It has sensors that react to blue light."
	icon_state = "redtag"
	item_state = "redtag"
	blood_overlay_type = "armor"
	allowed = list (/obj/item/gun/energy/laser/redtag)
	resistance_flags = NONE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/*
 * Costume
 */
/obj/item/clothing/suit/hooded/flashsuit
	name = "flashy costume"
	desc = "What did you expect?"
	icon_state = "flashsuit"
	item_state = "armor"
	hoodtype = /obj/item/clothing/head/hooded/flashsuit
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/flashsuit
	name = "flash button"
	desc = "You will learn to fear the flash."
	icon_state = "flashsuit"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS|HIDEFACIALHAIR|HIDEFACE|HIDEMASK

/obj/item/clothing/suit/pirate
	name = "pirate coat"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"

/obj/item/clothing/suit/pirate/captain
	name = "pirate captain coat"
	desc = "Yarr."
	icon_state = "hgpirate"
	item_state = "hgpirate"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON


/obj/item/clothing/suit/cyborg_suit
	name = "cyborg suit"
	desc = "Suit for a cyborg costume."
	icon_state = "death"
	item_state = "death"
	flags_1 = CONDUCT_1
	fire_resist = T0C+5200
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/justice
	name = "justice suit"
	desc = "this pretty much looks ridiculous" //Needs no fixing
	icon_state = "justice"
	item_state = "justice"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/judgerobe
	name = "judge's robe"
	desc = "This robe commands authority."
	icon_state = "judge"
	item_state = "judge"
	flags_inv = HIDEJUMPSUIT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/tailcoat
	name = "tailcoat"
	desc = "A rather impractical, long coat."
	icon_state = "tailcoat"
	item_state = "tailcoat"

/obj/item/clothing/suit/vickyblack
	name = "black victorian coat"
	desc = "An overbearing black coat, it looks far older than you are."
	icon_state = "vickyblack"
	item_state = "vickyblack"

/obj/item/clothing/suit/vickyred
	name = "red victorian coat"
	desc = "An overbearing red coat, it looks far older than you are."
	icon_state = "vickyred"
	item_state = "vickyred"

/obj/item/clothing/suit/syndicatefake
	name = "black and red space suit replica"
	icon_state = "syndicate-black-red"
	item_state = "syndicate-black-red"
	desc = "A plastic replica of the Syndicate space suit. You'll look just like a real murderous Syndicate agent in this! This is a toy, it is not made for use in space!"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	resistance_flags = NONE

/obj/item/clothing/suit/hastur
	name = "\improper Hastur's robe"
	desc = "Robes not meant to be worn by man."
	icon_state = "hastur"
	item_state = "hastur"
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	mutantrace_variation = NONE

/obj/item/clothing/suit/imperium_monk
	name = "\improper Imperium monk suit"
	desc = "Have YOU killed a xeno today?"
	icon_state = "imperium_monk"
	item_state = "imperium_monk"
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	mutantrace_variation = NONE

/obj/item/clothing/suit/chickensuit
	name = "chicken suit"
	desc = "A suit made long ago by the ancient empire KFC."
	icon_state = "chickensuit"
	item_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT


/obj/item/clothing/suit/monkeysuit
	name = "monkey suit"
	desc = "A suit that looks like a primate."
	icon_state = "monkeysuit"
	item_state = "monkeysuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "owl cloak"
	desc = "A soft brown cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive the ladies mad."
	icon_state = "owl_wings"
	item_state = "owl_wings"
	togglename = "wings"
	actions_types = list(/datum/action/item_action/toggle_wings)

/obj/item/clothing/suit/toggle/owlwings/Initialize()
	. = ..()
	allowed = GLOB.security_vest_allowed

/obj/item/clothing/suit/toggle/owlwings/griffinwings
	name = "griffon cloak"
	desc = "A plush white cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive your captives mad."
	icon_state = "griffin_wings"
	item_state = "griffin_wings"

/obj/item/clothing/suit/cardborg
	name = "cardborg suit"
	desc = "An ordinary cardboard box with holes cut in the sides."
	icon_state = "cardborg"
	item_state = "cardborg"
	flags_inv = HIDEJUMPSUIT
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/suit/cardborg/equipped(mob/living/user, slot)
	..()
	if(slot == SLOT_WEAR_SUIT)
		disguise(user)

/obj/item/clothing/suit/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")

/obj/item/clothing/suit/cardborg/proc/disguise(mob/living/carbon/human/H, obj/item/clothing/head/cardborg/borghead)
	if(istype(H))
		if(!borghead)
			borghead = H.head
		if(istype(borghead, /obj/item/clothing/head/cardborg)) //why is this done this way? because equipped() is called BEFORE THE ITEM IS IN THE SLOT WHYYYY
			var/image/I = image(icon = 'icons/mob/robots.dmi' , icon_state = "robot", loc = H)
			I.override = 1
			I.add_overlay(mutable_appearance('icons/mob/robots.dmi', "robot_e")) //gotta look realistic
			add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/silicons, "standard_borg_disguise", I) //you look like a robot to robots! (including yourself because you're totally a robot)


/obj/item/clothing/suit/snowman
	name = "snowman outfit"
	desc = "Two white spheres covered in white glitter. 'Tis the season."
	icon_state = "snowman"
	item_state = "snowman"
	flags_inv = HIDEJUMPSUIT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/whitedress
	name = "white dress"
	desc = "A fancy white dress."
	icon_state = "white_dress"
	item_state = "w_suit"
	flags_inv = HIDEJUMPSUIT|HIDESHOES
	mutantrace_variation = NONE

/obj/item/clothing/suit/hooded/robes
	name = "thick brown robes"
	desc = "When was the last time these things were washed?"
	icon_state = "brownrobes"
	item_state = "brownrobes"
	flags_inv = HIDESHOES|HIDEJUMPSUIT
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	hoodtype = /obj/item/clothing/head/hooded/robes
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/duster/armored
	armor_tier_desc = ARMOR_CLOTHING_MEDIUM
	armor = ARMOR_VALUE_MEDIUM
	slowdown = ARMOR_SLOWDOWN_MEDIUM * ARMOR_SLOWDOWN_LESS_T1 * ARMOR_SLOWDOWN_GLOBAL_MULT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/head/hooded/robes
	name = "brown hood"
	desc = "Perfect for concealing your identity."
	icon_state = "eldritch"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES
	flash_protect = 2
	armor = ARMOR_VALUE_MEDIUM
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/suit/hooded/robes/grey
	name = "grey robes"
	desc = "Requisite attire for the monthly meetings of your local cult."
	icon_state = "greyrobes"
	item_state = "greyrobes"
	hoodtype = /obj/item/clothing/head/hooded/robes/grey

/obj/item/clothing/head/hooded/robes/grey
	name = "grey hood"
	desc = "Keeps the sun out of your face, so you can brood in peace."
	item_state = "greyrobes"
	icon_state = "greyrobes"

/obj/item/clothing/suit/hooded/carp_costume
	name = "carp costume"
	desc = "A costume made from 'synthetic' carp scales, it smells."
	icon_state = "carp_casual"
	item_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT	//Space carp like space, so you should too
	hoodtype = /obj/item/clothing/head/hooded/carp_hood

/obj/item/clothing/head/hooded/carp_hood
	name = "carp hood"
	desc = "A hood attached to a carp costume."
	icon_state = "carp_casual"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/ian_costume	//It's Ian, rub his bell- oh god what happened to his inside parts?
	name = "corgi costume"
	desc = "A costume that looks like someone made a human-like corgi, it won't guarantee belly rubs."
	icon_state = "ian"
	item_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET
	hoodtype = /obj/item/clothing/head/hooded/ian_hood
	dog_fashion = /datum/dog_fashion/back

/obj/item/clothing/head/hooded/ian_hood
	name = "corgi hood"
	desc = "A hood that looks just like a corgi's head, it won't guarantee dog biscuits."
	icon_state = "ian"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/suit/hooded/bee_costume // It's Hip!
	name = "bee costume"
	desc = "Bee the true Queen!"
	icon_state = "bee"
	item_state = "labcoat"
	clothing_flags = THICKMATERIAL
	hoodtype = /obj/item/clothing/head/hooded/bee_hood
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/hooded/bee_hood
	name = "bee hood"
	desc = "A hood attached to a bee costume."
	icon_state = "bee"
	body_parts_covered = HEAD
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEHAIR|HIDEEARS
	dynamic_hair_suffix = ""

/obj/item/clothing/suit/hooded/bloated_human	//OH MY GOD WHAT HAVE YOU DONE!?!?!?
	name = "bloated human suit"
	desc = "A horribly bloated suit made from human skins."
	icon_state = "lingspacesuit"
	item_state = "labcoat"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|FEET|HANDS
	actions_types = list(/datum/action/item_action/toggle_human_head)
	hoodtype = /obj/item/clothing/head/hooded/human_head
	mutantrace_variation = NONE

/obj/item/clothing/head/hooded/human_head
	name = "bloated human head"
	desc = "A horribly bloated and mismatched human head."
	icon_state = "lingspacehelmet"
	body_parts_covered = HEAD
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/armor/outfit/jacket/navyblue/russian
	name = "\improper Russian officer's jacket"
	desc = "This jacket is for those special occasions when a russian officer isn't required to wear their armor."
	icon_state = "officertanjacket"
	item_state = "officertanjacket"
	body_parts_covered = CHEST|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/ran
	name = "shikigami costume"
	desc = "A costume that looks like a certain shikigami, is super fluffy."
	icon_state = "ran_suit"
	item_state = "ran_suit"
	flags_inv = HIDEJUMPSUIT|HIDETAUR
	heat_protection = CHEST|GROIN|LEGS //fluffy tails!
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/ran
	name = "shikigami hat"
	desc = "A hat that looks like it keeps any fluffy ears contained super warm, has little charms over it."
	icon_state = "ran_hat"
	item_state = "ran_hat"
	flags_inv = HIDEEARS

/obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/costume
	name = "T-45d power armor"
	desc = "Originally developed and manufactured for the United States Army by American defense contractor West Tek, the T-45d power armor was the first version of power armor to be successfully deployed in battle. This one is made of syrofoam."
	armor = ARMOR_VALUE_LIGHT

/*
 * Misc
 */

/obj/item/clothing/suit/straight_jacket
	name = "straight jacket"
	desc = "A suit that completely restrains the wearer. Manufactured by Antyphun Corp." //Straight jacket is antifun
	icon_state = "straight_jacket"
	item_state = "straight_jacket"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	equip_delay_self = 50
	strip_delay = 60
	breakouttime = 3000

/obj/item/clothing/suit/ianshirt
	name = "worn shirt"
	desc = "A worn out, curiously comfortable t-shirt with a picture of Ian. You wouldn't go so far as to say it feels like being hugged when you wear it, but it's pretty close. Good for sleeping in."
	icon_state = "ianshirt"
	item_state = "ianshirt"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/nerdshirt
	name = "gamer shirt"
	desc = "A baggy shirt with vintage game character Phanic the Weasel. Why would anyone wear this?"
	icon_state = "nerdshirt"
	item_state = "nerdshirt"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/vapeshirt //wearing this is asking to get beat.
	name = "Vape Naysh shirt"
	desc = "A cheap white T-shirt with a big tacky \"VN\" on the front, Why would you wear this unironically?"
	icon_state = "vapeshirt"
	item_state = "vapeshirt"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/jacket/flannel
	name = "black flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel"
	item_state = "flannel"

/obj/item/clothing/suit/jacket/flannel/red
	name = "red flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_red"
	item_state = "flannel_red"

/obj/item/clothing/suit/jacket/flannel/aqua
	name = "aqua flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_aqua"
	item_state = "flannel_aqua"

/obj/item/clothing/suit/jacket/flannel/brown
	name = "brown flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_brown"
	item_state = "flannel_brown"

/obj/item/clothing/suit/jacket/leather
	name = "leather jacket"
	desc = "Pompadour not included."
	icon_state = "leatherjacket"
	item_state = "hostrench"
	resistance_flags = NONE
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1)

/obj/item/clothing/suit/jacket/leather/overcoat
	name = "leather overcoat"
	desc = "That's a damn fine coat."
	icon_state = "leathercoat"
	cold_protection = CHEST|GROIN|ARMS|LEGS
	mutantrace_variation = STYLE_DIGITIGRADE
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_MELEE_T1)


/obj/item/clothing/suit/jacket/puffer
	name = "puffer jacket"
	desc = "A thick jacket with a rubbery, water-resistant shell."
	icon_state = "pufferjacket"
	item_state = "hostrench"

/obj/item/clothing/suit/jacket/puffer/vest
	name = "puffer vest"
	desc = "A thick vest with a rubbery, water-resistant shell."
	icon_state = "puffervest"
	item_state = "armor"
	cold_protection = CHEST|GROIN

/obj/item/clothing/suit/jacket/miljacket
	name = "military jacket"
	desc = "A canvas jacket styled after classical American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket"
	item_state = "militaryjacket"
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/jacket/letterman
	name = "letterman jacket"
	desc = "A classic brown letterman jacket. Looks pretty hot and heavy."
	icon_state = "letterman"
	item_state = "letterman"
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/jacket/letterman_red
	name = "red letterman jacket"
	desc = "A letterman jacket in a sick red color. Radical."
	icon_state = "letterman_red"
	item_state = "letterman_red"

/obj/item/clothing/suit/jacket/letterman_syndie
	name = "blood-red letterman jacket"
	desc = "Oddly, this jacket seems to have a large S on the back..."
	icon_state = "letterman_s"
	item_state = "letterman_s"

/obj/item/clothing/suit/jacket/letterman_nanotrasen
	name = "blue letterman jacket"
	desc = "A blue letterman jacket with a proud US Government N on the back. The tag says that it was made in Space China."
	icon_state = "letterman_n"
	item_state = "letterman_n"

/obj/item/clothing/suit/dracula
	name = "dracula coat"
	desc = "Looks like this belongs in a very old movie set."
	icon_state = "draculacoat"
	item_state = "draculacoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/drfreeze_coat
	name = "doctor freeze's labcoat"
	desc = "A labcoat imbued with the power of features and freezes."
	icon_state = "drfreeze_coat"
	item_state = "drfreeze_coat"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/gothcoat
	name = "gothic coat"
	desc = "Perfect for those who want stalk in a corner of a bar."
	icon_state = "gothcoat"
	item_state = "gothcoat"
	body_parts_covered = CHEST|ARMS|HAND_LEFT //peculiar

/obj/item/clothing/suit/xenos
	name = "xenos suit"
	desc = "A suit made out of chitinous alien hide."
	icon_state = "xenos"
	item_state = "xenos_helm"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

// WINTER COATS

/obj/item/clothing/suit/hooded/wintercoat
	name = "winter coat"
	desc = "A heavy jacket made from 'synthetic' animal furs."
	icon_state = "coatwinter"
	item_state = "coatwinter"
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/head/hooded/winterhood
	name = "winter hood"
	desc = "A hood attached to a heavy winter jacket."
	icon_state = "winterhood"
	body_parts_covered = HEAD
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	flags_inv = HIDEHAIR|HIDEEARS
	rad_flags = RAD_NO_CONTAMINATE
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/suit/hooded/wintercoat/centcom
	name = "centcom winter coat"
	desc = "A coat layered with both insulation and armor."
	icon_state = "coatcentcom"
	item_state = "coatcentcom"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/centcom
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/centcom/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/centcom
	icon_state = "winterhood_centcom"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/captain
	name = "captain's winter coat"
	desc = "A luxurious winter coat, stuffed with the down of the endangered Uka bird and trimmed with genuine sable. The fabric is an indulgently soft micro-fiber, and the deep ultramarine color is only one that could be achieved with minute amounts of crystalline bluespace dust woven into the thread between the plectrums. Extremely lavish, and extremely durable. The tiny flakes of protective material make it nothing short of extremely light lamellar armor."
	icon_state = "coatcaptain"
	item_state = "coatcaptain"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/captain
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/captain/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/captain
	desc = "A blue and yellow hood attached to a heavy winter jacket."
	icon_state = "winterhood_captain"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/hop
	name = "head of personnel's winter coat"
	desc = "A cozy winter coat, covered in thick fur. The breast features a proud yellow chevron, reminding everyone that you're the second banana."
	icon_state = "coathop"
	item_state = "coathop"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hop
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/head/hooded/winterhood/hop
	desc = "A cozy winter hood attached to a heavy winter jacket."
	icon_state = "winterhood_hop"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/security
	name = "security winter coat"
	desc = "A red, armor-padded winter coat. It glitters with a mild ablative coating and a robust air of authority.  The zipper tab is a pair of jingly little handcuffs that get annoying after the first ten seconds."
	icon_state = "coatsecurity"
	item_state = "coatsecurity"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/security/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/security
	desc = "A red, armor-padded winter hood."
	icon_state = "winterhood_security"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)


/obj/item/clothing/suit/hooded/wintercoat/hos
	name = "head of security's winter coat"
	desc = "A red, armor-padded winter coat, lovingly woven with a Kevlar interleave and reinforced with semi-ablative polymers and a silver azide fill material. The zipper tab looks like a tiny replica of Beepsky."
	icon_state = "coathos"
	item_state = "coathos"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hos
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/hos/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/hos
	desc = "A red, armor-padded winter hood, lovingly woven with a Kevlar interleave. Definitely not bulletproof, especially not the part where your face goes."
	icon_state = "winterhood_hos"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1)

/obj/item/clothing/suit/hooded/wintercoat/medical
	name = "medical winter coat"
	desc = "An arctic white winter coat with a small blue caduceus instead of a plastic zipper tab. Snazzy."
	icon_state = "coatmedical"
	item_state = "coatmedical"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/medical

/obj/item/clothing/head/hooded/winterhood/medical
	desc = "A white winter coat hood."
	icon_state = "winterhood_medical"

/obj/item/clothing/suit/hooded/wintercoat/cmo
	name = "chief medical officer's winter coat"
	desc = "An arctic white winter coat with a small blue caduceus instead of a plastic zipper tab. The normal liner is replaced with an exceptionally thick, soft layer of fur."
	icon_state = "coatcmo"
	item_state = "coatcmo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cmo
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/cmo
	desc = "A white winter coat hood."
	icon_state = "winterhood_cmo"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/chemistry
	name = "chemistry winter coat"
	desc = "A lab-grade winter coat made with acid resistant polymers. For the enterprising chemist who was exiled to a frozen wasteland on the go."
	icon_state = "coatchemistry"
	item_state = "coatchemistry"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/chemistry
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/chemistry
	desc = "A white winter coat hood."
	icon_state = "winterhood_chemistry"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/viro
	name = "virology winter coat"
	desc = "A white winter coat with green markings. Warm, but wont fight off the common cold or any other disease. Might make people stand far away from you in the hallway. The zipper tab looks like an oversized bacteriophage."
	icon_state = "coatviro"
	item_state = "coatviro"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/viro
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/viro
	desc = "A white winter coat hood with green markings."
	icon_state = "winterhood_viro"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/paramedic
	name = "paramedic winter coat"
	desc = "A winter coat with blue markings. Warm, but probably won't protect from biological agents. For the cozy doctor on the go."
	icon_state = "coatparamed"
	item_state = "coatparamed"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/paramedic

/obj/item/clothing/head/hooded/winterhood/paramedic
	desc = "A white winter coat hood with blue markings."
	icon_state = "winterhood_paramed"

/obj/item/clothing/suit/hooded/wintercoat/science
	name = "science winter coat"
	desc = "A white winter coat with an outdated atomic model instead of a plastic zipper tab."
	icon_state = "coatscience"
	item_state = "coatscience"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/science
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/science
	desc = "A white winter coat hood. This one will keep your brain warm. About as much as the others, really."
	icon_state = "winterhood_science"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/robotics
	name = "robotics winter coat"
	desc = "A black winter coat with a badass flaming robotic skull for the zipper tab. This one has bright red designs and a few useless buttons."
	icon_state = "coatrobotics"
	item_state = "coatrobotics"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/robotics

/obj/item/clothing/head/hooded/winterhood/robotics
	desc = "A black winter coat hood. You can pull it down over your eyes and pretend that you're an outdated, late 1980s interpretation of a futuristic mechanized police force. They'll fix you. They fix everything."
	icon_state = "winterhood_robotics"

/obj/item/clothing/suit/hooded/wintercoat/genetics
	name = "genetics winter coat"
	desc = "A white winter coat with a DNA helix for the zipper tab. "
	icon_state = "coatgenetics"
	item_state = "coatgenetics"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/genetics

/obj/item/clothing/head/hooded/winterhood/genetics
	desc = "A white winter coat hood. It's warm."
	icon_state = "winterhood_genetics"

/obj/item/clothing/suit/hooded/wintercoat/rd
	name = "research director's winter coat"
	desc = "A thick arctic winter coat with an outdated atomic model instead of a plastic zipper tab. Most in the know are heavily aware that Bohr's model of the atom was outdated by the time of the 1930s when the Heisenbergian and Schrodinger models were generally accepted for true. Nevertheless, we still see its use in anachronism, roleplaying, and, in this case, as a zipper tab. At least it should keep you warm on your ivory pillar."
	icon_state = "coatrd"
	item_state = "coatrd"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/rd
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/rd
	desc = "A white winter coat hood. It smells faintly of hair gel."
	icon_state = "winterhood_rd"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/ce
	name = "chief engineer's winter coat"
	desc = "A white winter coat with reflective green and yellow stripes. Stuffed with asbestos, treated with fire retardant PBDE, lined with a micro thin sheet of lead foil and snugly fitted to your body's measurements. This baby's ready to save you from anything except the thyroid cancer and systemic fibrosis you'll get from wearing it. The zipper tab is a tiny golden wrench."
	icon_state = "coatce"
	item_state = "coatce"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/ce
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T3)

/obj/item/clothing/head/hooded/winterhood/ce
	desc = "A white winter coat hood. Feels surprisingly heavy. The tag says that it's not child safe."
	icon_state = "winterhood_ce"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T3)

/obj/item/clothing/suit/hooded/wintercoat/engineering
	name = "engineering winter coat"
	desc = "A surprisingly heavy yellow winter coat with reflective orange stripes. It has a small wrench for its zipper tab, and the inside layer is covered with a radiation-resistant silver-nylon blend. Because you're worth it."
	icon_state = "coatengineer"
	item_state = "coatengineer"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/engineering
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/engineering
	desc = "A yellow winter coat hood. Definitely not a replacement for a hard hat."
	icon_state = "winterhood_engineer"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	name = "atmospherics winter coat"
	desc = "A yellow and blue winter coat. The zipper pull-tab is made to look like a miniature breath mask."
	icon_state = "coatatmos"
	item_state = "coatatmos"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/head/hooded/winterhood/engineering/atmos
	desc = "A yellow and blue winter coat hood."
	icon_state = "winterhood_atmos"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2)

/obj/item/clothing/suit/hooded/wintercoat/hydro
	name = "hydroponics winter coat"
	desc = " A green and blue winter coat. The zipper tab looks like the flower from a member of Rosa Hesperrhodos, a pretty pink-and-white rose. The colors absolutely clash."
	icon_state = "coathydro"
	item_state = "coathydro"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/hydro

/obj/item/clothing/head/hooded/winterhood/hydro
	desc = "A green winter coat hood."
	icon_state = "winterhood_hydro"

/obj/item/clothing/suit/hooded/wintercoat/bar
	name = "bartender winter coat"
	desc = "A fancy winter coat with a waistcoat and flamboyant bowtie stuck onto it. The zipper tab is actually the bowtie."
	icon_state = "coatbar"
	item_state = "coatbar"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/bar

/obj/item/clothing/head/hooded/winterhood/bar
	desc = "A fancy winter coat hood."
	icon_state = "winterhood_bar"

/obj/item/clothing/suit/hooded/wintercoat/janitor
	name = "janitors winter coat"
	desc = "A purple-and-beige winter coat that smells of Abraxo-brand cleaner."
	icon_state = "coatjanitor"
	item_state = "coatjanitor"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/janitor

/obj/item/clothing/head/hooded/winterhood/janitor
	desc = "A purple hood that smells of Abraxo-brand cleaner."
	icon_state = "winterhood_janitor"

/obj/item/clothing/suit/hooded/wintercoat/cargo
	name = "cargo winter coat"
	desc = "A tan-and-grey winter coat that has a crate for its zipper pull tab. It fills you with the warmth of a fierce independence."
	icon_state = "coatcargo"
	item_state = "coatcargo"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/cargo

/obj/item/clothing/head/hooded/winterhood/cargo
	desc = "A grey hood for a winter coat."
	icon_state = "winterhood_cargo"

/obj/item/clothing/suit/hooded/wintercoat/qm
	name = "quartermaster's winter coat"
	desc = "A dark brown winter coat that has a golden crate pin for its zipper pully."
	icon_state = "coatqm"
	item_state = "coatqm"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/qm

/obj/item/clothing/head/hooded/winterhood/qm
	desc = "A dark brown winter hood"
	icon_state = "winterhood_qm"

/obj/item/clothing/suit/hooded/wintercoat/aformal
	name = "assistant's formal winter coat"
	desc = "A black button up winter coat."
	icon_state = "coataformal"
	item_state = "coataformal"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/aformal

/obj/item/clothing/head/hooded/winterhood/aformal
	desc = "A black winter coat hood."
	icon_state = "winterhood_aformal"

/obj/item/clothing/suit/hooded/wintercoat/miner
	name = "mining winter coat"
	desc = "A dusty button up winter coat. The zipper tab looks like a tiny pickaxe."
	icon_state = "coatminer"
	item_state = "coatminer"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/miner

/obj/item/clothing/head/hooded/winterhood/miner
	desc = "A dusty winter coat hood."
	icon_state = "winterhood_miner"

/*/obj/item/clothing/suit/hooded/wintercoat/ratvar
	name = "ratvarian winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red gemstone inset."
	icon_state = "coatratvar"
	item_state = "coatratvar"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/ratvar
	var/real = TRUE

/obj/item/clothing/head/hooded/winterhood/ratvar
	icon_state = "winterhood_ratvar"
	desc = "A brass-plated winter hood that glows softly, hinting at its divinity."
	light_range = 3
	light_power = 1
	light_color = "#B18B25" //clockwork slab background top color

/obj/item/clothing/suit/hooded/wintercoat/ratvar/equipped(mob/living/user,slot)
	..()
	if (slot != SLOT_WEAR_SUIT || !real)
		return
	if (is_servant_of_ratvar(user))
		return
	else
		user.dropItemToGround(src)
		to_chat(user,span_large_brass("\"Amusing that you think you are fit to wear this.\""))
		to_chat(user,span_userdanger("Your skin burns where the coat touched your skin!"))
		user.adjustFireLoss(rand(10,16))*/

/obj/item/clothing/suit/hooded/wintercoat/narsie
	name = "narsian winter coat"
	desc = "A somber button-up in tones of grey entropy and a wicked crimson zipper. When pulled all the way up, the zipper looks like a bloody gash. The zipper pull looks like a single drop of blood."
	icon_state = "coatnarsie"
	item_state = "coatnarsie"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/narsie
	var/real = TRUE

/obj/item/clothing/suit/hooded/wintercoat/narsie/equipped(mob/living/user,slot)
	..()
	if (slot != SLOT_WEAR_SUIT || !real)
		return
	if (iscultist(user))
		return
	else
		user.dropItemToGround(src)
		to_chat(user,span_cultlarge("\"You are not fit to wear my follower's coat!\""))
		to_chat(user,span_userdanger("Sharp spines jab you from within the coat!"))
		user.adjustBruteLoss(rand(10,16))

/obj/item/clothing/head/hooded/winterhood/narsie
	desc = "A black winter hood full of whispering secrets that only She shall ever know."
	icon_state = "winterhood_narsie"

/*/obj/item/clothing/suit/hooded/wintercoat/ratvar/fake
	name = "brass winter coat"
	desc = "A brass-plated button up winter coat. Instead of a zipper tab, it has a brass cog with a tiny red piece of plastic as an inset."
	icon_state = "coatratvar"
	item_state = "coatratvar"
	real = FALSE*/

/obj/item/clothing/suit/hooded/wintercoat/narsie/fake
	name = "runed winter coat"
	desc = "A dusty button up winter coat in the tones of oblivion and ash. The zipper pull looks like a single drop of blood."
	icon_state = "coatnarsie"
	item_state = "coatnarsie"
	real = FALSE

/obj/item/clothing/suit/hooded/wintercoat/durathread
	name = "durathread winter coat"
	desc = "The one coat to rule them all. Extremely durable while providing the utmost comfort."
	icon_state = "coatdurathread"
	item_state = "coatdurathread"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_LASER_T1)

	hoodtype = /obj/item/clothing/head/hooded/winterhood/durathread

/obj/item/clothing/suit/hooded/wintercoat/durathread/Initialize()
	. = ..()
	allowed = GLOB.security_wintercoat_allowed

/obj/item/clothing/head/hooded/winterhood/durathread
	desc = "The one coat to rule them all. Extremely durable while providing the utmost comfort."
	icon_state = "winterhood_durathread"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T2, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_DOWN_LASER_T1)

/obj/item/clothing/suit/spookyghost
	name = "spooky ghost"
	desc = "This is obviously just a bedsheet, but maybe try it on?"
	icon_state = "bedsheet"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|HEAD
	user_vars_to_edit = list("name" = "Spooky Ghost", "real_name" = "Spooky Ghost" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire
	mutantrace_variation = NONE

/obj/item/clothing/suit/bronze
	name = "bronze suit"
	desc = "A big and clanky suit made of bronze that offers no protection and looks very unfashionable. Nice."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"

/obj/item/clothing/suit/armor/outfit/costume/ghost
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	item_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|HEAD
	alternate_worn_layer = UNDER_HEAD_LAYER
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/assu_suit
	name = "DAB suit"
	desc = "A cheap replica of old SWAT armor. On its back, it is written: \"<i>Desperate Assistance Battleforce</i>\"."
	icon_state = "assu_suit"
	item_state = "assu_suit"
	blood_overlay_type = "armor"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	flags_inv = HIDEJUMPSUIT
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/hooded/wintercoat/christmascoatr
	name = "red christmas coat"
	desc = "A festive red Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatr"
	item_state = "christmascoatr"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmashoodr

/obj/item/clothing/head/hooded/winterhood/christmashoodr
	icon_state = "christmashoodr"

/obj/item/clothing/suit/hooded/wintercoat/christmascoatg
	name = "green christmas coat"
	desc = "A festive green Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatg"
	item_state = "christmascoatg"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmashoodg

/obj/item/clothing/head/hooded/winterhood/christmashoodg
	icon_state = "christmashoodg"

/obj/item/clothing/suit/hooded/wintercoat/christmascoatrg
	name = "red and green christmas coat"
	desc = "A festive red and green Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatrg"
	item_state = "christmascoatrg"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmashoodrg

/obj/item/clothing/head/hooded/winterhood/christmashoodrg
	icon_state = "christmashoodrg"

/obj/item/clothing/suit/hooded/wintercoat/polychromic
	name = "polychromic winter coat"
	icon_state = "coatpoly"
	item_state = "coatpoly"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/polychromic

/obj/item/clothing/suit/hooded/wintercoat/polychromic/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#6A6964", "#C4B8A6", "#0000FF"), 3)

/obj/item/clothing/head/hooded/winterhood/polychromic
	icon_state = "winterhood_poly"
	item_state = "winterhood_poly"

/obj/item/clothing/suit/striped_sweater
	name = "striped sweater"
	desc = "Reminds you of someone, but you just can't put your finger on it..."
	icon_state = "waldo_shirt"
	item_state = "waldo_shirt"

/obj/item/clothing/suit/samurai
	name = "Samurai outfit"
	desc = "An outfit used by traditional japanese warriors."
	icon_state = "samurai"
	item_state = "samurai"
	armor = ARMOR_VALUE_LIGHT

//NCR Ranger Stuff

/obj/item/clothing/suit/rain_coat
	name = "Commonwealth sniper rain coat"
	desc = "Used in jungle envrioments its a soft canvas cloak with a black mesh over it, with green foliage sticking out the front half."
	icon_state = "rain_coat_sniper"
	item_state = "rain_coat_sniper"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/pip_cloak
	name = "heart cloak"
	desc = "A pretty blue cloak with a heart on the back."
	icon_state = "pip_cloak"
	item_state = "pip_cloak"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/flintlock
	name = "flintlock coat"
	desc = "A green jacket with a brown fur lined inner."
	icon_state = "flintlock"
	item_state = "flintlock"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/dension
	name = "Denison jacket"
	desc = "A coverall jacket created by the British during the second world war, its still in use by commonwealth units by specifically Paratroopers and units working in colder climates."
	icon_state = "dension"
	item_state = "dension"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/canadian_coat
	name = "flintlock coat"
	desc = "A pre war standard issue service coat for the Canadian army but is a man stake for all British commonwealth Nations Winterwear."
	icon_state = "Canadian_coat"
	item_state = "Canadian_coat"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/adamantite
	name = "adamantite coat"
	desc = "A purple kinda fancy looking coat."
	icon_state = "adamantite"
	item_state = "adamantite"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/arcanium
	name = "arcanium coat"
	desc = "A blue and white kinda fancy looking coat."
	icon_state = "arcanium"
	item_state = "arcanium"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/gladiator
	name = "gladiator armor"
	desc = "A red and sliver piece of armor!"
	icon_state = "gladiator"
	item_state = "gladiator"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/black
	name = "Black Coat"
	desc = "A fancy looking black coat"
	icon_state = "black"
	item_state = "black"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/black_gold
	name = "black and gold coat"
	desc = "A fancy looking black and gold coat."
	icon_state = "black_gold"
	item_state = "black_gold"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/copper
	name = "copper coat"
	desc = "A copper colored coat."
	icon_state = "copper"
	item_state = "copper"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/dark_knight
	name = "dark knight coat"
	desc = "A grey and sliver coat with a cross on the chest. Avast Ye! Wait, that's pirates."
	icon_state = "dark_knight"
	item_state = "dark_knight"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/holy_knight
	name = "holy knight coat"
	desc = "A fancy coat!"
	icon_state = "holy_knight"
	item_state = "holy_knight"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/iron
	name = "iron coat"
	desc = "A fancy coat!"
	icon_state = "iron"
	item_state = "iron"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/kraus
	name = "kraus armor"
	desc = "A shiny suit of armor!"
	icon_state = "kraus"
	item_state = "kraus"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/leather
	name = "leahter coat"
	desc = "A leather coat! Don't call peta."
	icon_state = "leather"
	item_state = "leather"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/gob/steel
	name = "Steel coat"
	desc = "A Steel coat! Jet fuel might melt this.."
	icon_state = "steel"
	item_state = "steel"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/ranger/ned
	name = "Ned Armor"
	desc = "Maybe it will protect you, maybe it won't. Who's to know."
	icon_state = "ned"
	item_state = "ned"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/ranger/us_coat
	name = "US coat"
	desc = "A nice enough looking coat"
	icon_state = "us_coat"
	item_state = "us_coat"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/ranger/trench_colorable
	name = "Trench, colorable"
	desc = "Trench coat! Colorable verision."
	icon_state = "trench_colorable"
	item_state = "trench_colorable"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/poncho
	name = "Rainbow Poncho"
	desc = "A rainbow poncho"
	icon_state = "poncho"
	item_state = "poncho"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek
	name = "Cyperpunk Brown"
	desc = "A brown jacket!"
	icon_state = "cyberpunksleek"
	item_state = "cyberpunksleek"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_black
	name = "Cyperpunk Black"
	desc = "A black jacket!"
	icon_state = "cyberpunksleek_black"
	item_state = "cyberpunksleek_black"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_green
	name = "Cyperpunk Green"
	desc = "A green jacket!"
	icon_state = "cyberpunksleek_green"
	item_state = "cyberpunksleek_green"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_white
	name = "Cyperpunk White"
	desc = "A white jacket!"
	icon_state = "cyberpunksleek_white"
	item_state = "cyberpunksleek_white"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_long_green
	name = "Cyperpunk Long Green"
	desc = "A green jacket!"
	icon_state = "cyberpunksleek_long_green"
	item_state = "cyberpunksleek_long_green"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_long_black
	name = "Cyperpunk Long Black"
	desc = "A black jacket!"
	icon_state = "cyberpunksleek_long_black"
	item_state = "cyberpunksleek_long_black"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_long_white
	name = "Cyperpunk Long white"
	desc = "A white jacket!"
	icon_state = "cyberpunksleek_long_white"
	item_state = "cyberpunksleek_long_white"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/cyberpunksleek_long
	name = "Cyperpunk Long brown"
	desc = "A brown jacket!"
	icon_state = "cyberpunksleek_long"
	item_state = "cyberpunksleek_long"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/overcoat_brown
	name = "Brown Overcoat"
	desc = "A brown jacket!"
	icon_state = "overcoat_brown"
	item_state = "overcoat_brown"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/overcoat_black
	name = "Black Overcoat"
	desc = "A black jacket!"
	icon_state = "overcoat_black"
	item_state = "overcoat_black"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/bladerunner_coat
	name = "Blade Runner Coat"
	desc = "A black jacket!"
	icon_state = "bladerunner_coat"
	item_state = "bladerunner_coat"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/boxer_jacket
	name = "boxing jacket"
	desc = "A nice looking jacket"
	icon_state = "boxer_jacket"
	item_state = "boxer_jacket"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/drive_jacket
	name = "drive jacket"
	desc = "A nice looking jacket"
	icon_state = "drive_jacket"
	item_state = "drive_jacket"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/violet_jacket
	name = "Violet Jacket"
	desc = "A nice looking jacket"
	icon_state = "violet_jacket"
	item_state = "violet_jacket"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/tunnelsnake
	name = "Tunnel Snake"
	desc = "A nice looking jacket"
	icon_state = "tunnelsnake"
	item_state = "tunnelsnake"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/eris/dante
	name = "Dante jacket"
	desc = "A nice looking jacket"
	icon_state = "dante"
	item_state = "dante"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/chomp/warden
	name = "Warden jacket"
	desc = "A nice looking jacket"
	icon_state = "warden"
	item_state = "warden"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/chomp/hos_trench
	name = "Black Trench Coat"
	desc = "A nice looking jacket"
	icon_state = "hos_trench"
	item_state = "hos_trench"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/talon
	name = "Dark blue coat"
	desc = "A nice looking jacket"
	icon_state = "taloncoat"
	item_state = "taloncoat"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/talon
	name = "Dark blue coat"
	desc = "A nice looking jacket"
	icon_state = "taloncoat"
	item_state = "taloncoat"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/redjacket
	name = "Red Hoodie"
	desc = "A nice looking jacket"
	icon_state = "hoodie_redtrim"
	item_state = "hoodie_redtrim"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/bluejacket
	name = "Blue Hoodie"
	desc = "A nice looking jacket"
	icon_state = "hoodie_bluetrim"
	item_state = "hoodie_bluetrim"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/greenjacket
	name = "Green Hoodie"
	desc = "A nice looking jacket"
	icon_state = "hoodie_greentrim"
	item_state = "hoodie_greentrim"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/purplejacket
	name = "Purple Hoodie"
	desc = "A nice looking jacket"
	icon_state = "hoodie_purpletrim"
	item_state = "hoodie_purpletrim"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/chomp/yellowjacket
	name = "Yellow Hoodie"
	desc = "A nice looking jacket"
	icon_state = "hoodie_yellowtrim"
	item_state = "hoodie_yellowtrim"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/toggle/labcoat/dinosaur
	name = "Dinosaur costume"
	desc = "Life...life finds a way."
	icon_state = "dinosaur"
	item_state = "dinosaur"
	flags_inv = HIDESHOES|HIDEJUMPSUIT | HIDEEARS | HIDEHAIR
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/coat/coyote
	icon = 'icons/obj/clothing/coats.dmi'
	mob_overlay_icon = 'icons/mob/clothing/coats.dmi'
	icon_state = "surgical_scrubs"

/obj/item/clothing/suit/coat/coyote/short_nurse_dress
	name = "short nurse dress"
	desc = "A short, easy to move in nurse dress. Give it a twirl!"
	icon_state = "short-nurse-dress"
	item_state = "short-nurse-dress"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/nurse_coat
	name = "nurse coat"
	desc = "A pristine medical coat, the inside is very soft to the touch."
	icon_state = "nurse-coat"
	item_state = "nurse-coat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/science_puffer
	name = "science puffer"
	desc = "A big comfy puffer jacket, perfect for the lab!"
	icon_state = "science-puffer"
	item_state = "science-puffer"
	body_parts_covered = CHEST|ARMS


/obj/item/clothing/suit/coat/coyote/hi_vis_coat
	name = "hi-vis coat"
	desc = "A coat that makes you even more visible!"
	icon_state = "hi-vis-coat"
	item_state = "hi-vis-coat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/engineering_puffer
	name = "engineering puffer"
	desc = "A big comfy puffer jacket, perfect for the engine!"
	icon_state = "engineering-puffer"
	item_state = "engineering-puffer"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/security_puffer
	name = "security puffer"
	desc = "A big comfy puffer jacket, perfect for catching criminals!"
	icon_state = "sec-puffer"
	item_state = "sec-puffer"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/botany_puffer
	name = "botanist puffer"
	desc = "A big comfy puffer jacket, perfect for gardening!"
	icon_state = "botanist-puffer"
	item_state = "botanist-puffer"

/obj/item/clothing/suit/coat/coyote/geneticist_puffer
	name = "geneticist puffer"
	desc = "A big comfy puffer jacket, perfect for defying nature!"
	icon_state = "geneticist-puffer"
	item_state = "geneticist-puffer"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/janitor_jacket
	name = "janitorial jacket"
	desc = "Sturdy and easy to wash, inevitably going to be splashed with blood."
	icon_state = "janitor-jacket"
	item_state = "janitor-jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/coat/coyote/rancher_puffer
	name = "rancher puffer"
	desc = "A big comfy puffer jacket, perfect for chicken care!"
	icon_state = "rancher-puffer"
	item_state = "rancher-puffer"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/toggle/labcoat/detvest
	name = "Colorable Detective Vest"
	desc = "A colorable detective vest."
	icon_state = "det_vest"
	item_state = "det_vest"
	armor = ARMOR_VALUE_LIGHT

/obj/item/clothing/suit/civ13/coat/black
	name = "Thick Black Coat"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "japcoat"
	item_state = "japcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/tancoat
	name = "Thick Tan Coat"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "japcoat2"
	item_state = "japcoat2"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/gray
	name = "Thick Gray Coat"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "russcoat"
	item_state = "russcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/brown
	name = "Thick Brown Coat"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "sov_offcoat"
	item_state = "sov_offcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/brownwaistcoat
	name = "Thick Brown Waistcoat"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "ger_offcoat"
	item_state = "ger_offcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/civ13/coat/sidebuttonjacket
	name = "Overcoat - Tan with sidebuttons"
	desc = "Bro, why are you wearing this in humid ass east Texas?"
	icon_state = "chi_korea_offcoat"
	item_state = "chi_korea_offcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/civ13/coat/kozhanka
	name = "Kozhanka Coat"
	desc = "Our Coat™"
	icon_state = "kozhanka"
	item_state = "kozhanka"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/kozhanka/white
	name = "Kozhanka Coat - White"
	desc = "Our Coat™"
	icon_state = "kozhanka_w"
	item_state = "kozhanka_w"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/leathervest
	name = "Leather Vest with Belt"
	desc = "A nice lether vest with a smart belt around your midsection."
	icon_state = "japvest"
	item_state = "japvest"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/blackvest
	name = "Black vest - Half buttoned"
	desc = "Great for showing off your chest hair.  Or cleavage.  Your call, really."
	icon_state = "blackvest"
	item_state = "blackvest"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/olivevest
	name = "Olive vest - Half buttoned"
	desc = "Great for showing off your chest hair.  Or cleavage.  Your call, really."
	icon_state = "olivevest"
	item_state = "olivevest"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/bluevest
	name = "Blue vest - Half buttoned"
	desc = "Great for showing off your chest hair.  Or cleavage.  Your call, really."
	icon_state = "bluevest"
	item_state = "bluevest"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/civ13/coat/greenusjacket
	name = "US Jacket - Green"
	desc = "2000 push ups not required. Smells like mildew though."
	icon_state = "us_jacket"
	item_state = "us_jacket"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/civ13/coat/ghillie
	name = "Ghillie Suit - no hood"
	desc = "Are you sure that's just not a bunch of fucking grass?"
	icon_state = "ghillie"
	item_state = "ghillie"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/tanovercoat
	name = "Overcoat - Tan"
	desc = "A nice jacket, you know, if it ever got cold around here."
	icon_state = "ww2_japcoat"
	item_state = "ww2_japcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/fluffypilotsjacket
	name = "Pilots Jacket - Fluffy"
	desc = "A nice pilots jacket.  This ones lined with kitsun- fox... fur...  Yeah..."
	icon_state = "jappilotcoat"
	item_state = "jappilotcoat"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'

/obj/item/clothing/suit/civ13/coat/monk_robes
	name = "Nasty Monk Robes"
	desc = "Damn bitch, you sure that isn't a potato sack?"
	icon_state = "monk_robes"
	item_state = "monk_robes"
	icon = 'modular_coyote/icons/objects/civ13suitobj.dmi'
	mob_overlay_icon = 'modular_coyote/icons/objects/civ13suitonmob.dmi'


/obj/item/clothing/suit/hooded/robes/whitemage
	name = "White Mage Robes"
	desc = "Hammer not included"
	icon_state = "whitemagerobes"
	item_state = "whitemagerobes"
	hoodtype = /obj/item/clothing/head/hooded/robes/whitemage

/obj/item/clothing/head/hooded/robes/whitemage
	name = "grey hood"
	desc = "Keeps the sun out of your face, so you can brood in peace."
	item_state = "whitemagerobes"
	icon_state = "whitemagerobes"

