// In this document: Clothing for suit slot with no special functions (see suit_utility for those)


///////////////
// WASTELAND //
///////////////


/obj/item/clothing/suit/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	inhand_icon_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	togglename = "buttons"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/suit/toggle/labcoat/fieldscribe
	name = "fieldscribe suit"
	desc = "A suit that protects against the weather, and looks stylish, but not much else."
	icon_state = "fieldscribe"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1)

/obj/item/clothing/suit/toggle/labcoat/scribecoat
	name = "fieldscribe coat"
	desc = "A heavy-duty coat and chestrig fitted with tons of pockets for every scribe's storage needs."
	icon_state = "scribecoat"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_LASER_T1)

/obj/item/clothing/suit/cyborg_suit
	name = "cyborg suit"
	desc = "Suit for a cyborg costume."
	icon_state = "death"
	inhand_icon_state = "death"
	flags_1 = CONDUCT_1
	fire_resist = T0C+5200
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/justice
	name = "justice suit"
	desc = "this pretty much looks ridiculous" //Needs no fixing
	icon_state = "justice"
	inhand_icon_state = "justice"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|FEET
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/judgerobe
	name = "judge's robe"
	desc = "This robe commands authority."
	icon_state = "judge"
	inhand_icon_state = "judge"
	flags_inv = HIDEJUMPSUIT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/suit/tailcoat
	name = "tailcoat"
	desc = "A rather impractical, long coat."
	icon_state = "tailcoat"
	inhand_icon_state = "tailcoat"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/vickyblack
	name = "black victorian coat"
	desc = "An overbearing black coat, it looks far older than you are."
	icon_state = "vickyblack"
	inhand_icon_state = "vickyblack"

/obj/item/clothing/suit/vickyred
	name = "red victorian coat"
	desc = "An overbearing red coat, it looks far older than you are."
	icon_state = "vickyred"
	inhand_icon_state = "vickyred"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/apron/overalls
	name = "coveralls"
	desc = "A set of denim overalls."
	icon_state = "overalls"
	inhand_icon_state = "overalls"

/obj/item/clothing/suit/apron/purple_bartender
	name = "purple bartender apron"
	desc = "A fancy purple apron for a stylish person."
	icon_state = "purplebartenderapron"
	inhand_icon_state = "purplebartenderapron"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = CHEST

/*
 * Misc
 */


/obj/item/clothing/suit/jacket
	name = "bomber jacket"
	desc = "Aviators not included."
	icon_state = "bomberjacket"
	inhand_icon_state = "brownjsuit"
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	armor = ARMOR_VALUE_CLOTHES
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/flannel/red
	name = "red flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_red"
	inhand_icon_state = "flannel_red"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/flannel/aqua
	name = "aqua flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_aqua"
	inhand_icon_state = "flannel_aqua"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/flannel/brown
	name = "brown flannel jacket"
	desc = "Comfy and supposedly flammable."
	icon_state = "flannel_brown"
	inhand_icon_state = "flannel_brown"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/leather
	name = "leather jacket"
	desc = "Pompadour not included."
	icon_state = "leatherjacket"
	inhand_icon_state = "hostrench"
	resistance_flags = NONE
	body_parts_hidden = ARMS
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT

/obj/item/clothing/suit/jacket/leather/overcoat
	name = "leather overcoat"
	desc = "That's a damn fine coat."
	icon_state = "leathercoat"
	cold_protection = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/jacket/puffer/vest
	name = "puffer vest"
	desc = "A thick fluffy vest that keeps you warm. Keep away from fire."
	icon_state = "puffervest"
	inhand_icon_state = "armor"
	cold_protection = CHEST|GROIN
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/miljacket
	name = "military jacket"
	desc = "A canvas jacket styled after classical American military garb. Very durable, yet comfortable."
	icon_state = "militaryjacket"
	inhand_icon_state = "militaryjacket"
	body_parts_hidden = ARMS

/obj/item/clothing/suit/jacket/letterman
	name = "letterman jacket"
	desc = "A classic brown letterman jacket. Looks pretty hot and heavy."
	icon_state = "letterman"
	inhand_icon_state = "letterman"
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/jacket/letterman_red
	name = "red letterman jacket"
	desc = "A letterman jacket in a sick red color. Radical."
	icon_state = "letterman_red"
	inhand_icon_state = "letterman_red"
	body_parts_hidden = CHEST|ARMS

/obj/item/clothing/suit/dracula
	name = "dracula coat"
	desc = "Looks like this belongs in a very old movie set."
	icon_state = "draculacoat"
	inhand_icon_state = "draculacoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/drfreeze_coat
	name = "doctor freeze's labcoat"
	desc = "A labcoat imbued with the power of features and freezes."
	icon_state = "drfreeze_coat"
	inhand_icon_state = "drfreeze_coat"
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/suit/gothcoat
	name = "gothic coat"
	desc = "Perfect for those who want stalk in a corner of a bar."
	icon_state = "gothcoat"
	inhand_icon_state = "gothcoat"
	body_parts_covered = CHEST|ARMS|HAND_LEFT //peculiar

/obj/item/clothing/suit/bronze
	name = "bronze suit"
	desc = "A big and clanky suit made of bronze that offers no protection and looks very unfashionable. Nice."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"

/obj/item/clothing/suit/hooded/wintercoat/christmascoatr
	name = "red christmas coat"
	desc = "A festive red Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatr"
	inhand_icon_state = "christmascoatr"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmashoodr

/obj/item/clothing/head/hooded/winterhood/christmashoodr
	icon_state = "christmashoodr"

/obj/item/clothing/suit/bomber
	name = "old bomber jacket"
	desc = "It looks like someone dragged this out of a muddy lake."
	icon_state = "bomberalt"
	inhand_icon_state = "bomberalt"

// "Funny" Masquerade suits. Keep off the maps.

/obj/item/clothing/suit/spookyghost
	name = "spooky ghost"
	desc = "This is obviously just a bedsheet, but maybe try it on?"
	icon_state = "bedsheet"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|HEAD
	user_vars_to_edit = list("name" = "Spooky Ghost", "real_name" = "Spooky Ghost" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire
	mutantrace_variation = NONE

/obj/item/clothing/suit/ran
	name = "shikigami costume"
	desc = "A costume that looks like a certain shikigami, is super fluffy."
	icon_state = "ran_suit"
	inhand_icon_state = "ran_suit"
	flags_inv = HIDEJUMPSUIT|HIDETAUR
	heat_protection = CHEST|GROIN|LEGS //fluffy tails!
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/head/ran
	name = "shikigami hat"
	desc = "A hat that looks like it keeps any fluffy ears contained super warm, has little charms over it."
	icon_state = "ran_hat"
	inhand_icon_state = "ran_hat"
	flags_inv = HIDEEARS

/obj/item/clothing/suit/chickensuit
	name = "chicken suit"
	desc = "A suit made long ago by the ancient empire KFC."
	icon_state = "chickensuit"
	inhand_icon_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "owl cloak"
	desc = "A soft brown cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive the ladies mad."
	icon_state = "owl_wings"
	inhand_icon_state = "owl_wings"
	togglename = "wings"
	actions_types = list(/datum/action/item_action/toggle_wings)

/obj/item/clothing/suit/toggle/owlwings/griffinwings
	name = "griffon cloak"
	desc = "A plush white cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive your captives mad."
	icon_state = "griffin_wings"
	inhand_icon_state = "griffin_wings"

/obj/item/clothing/suit/cardborg
	name = "cardborg suit"
	desc = "An ordinary cardboard box with holes cut in the sides."
	icon_state = "cardborg"
	inhand_icon_state = "cardborg"
	flags_inv = HIDEJUMPSUIT
	dog_fashion = /datum/dog_fashion/back
/* uncomment when old system cleaned out
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
*/
