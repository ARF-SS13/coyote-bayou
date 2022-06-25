// In this document: Clothing for suit slot with no special functions (see suit_utility for those)


///////////////
// WASTELAND //
///////////////


/obj/item/clothing/suit/toggle/labcoat
	name = "labcoat"
	desc = "A suit that protects against minor chemical spills."
	icon_state = "labcoat"
	item_state = "labcoat"
	blood_overlay_type = "coat"
	body_parts_covered = CHEST|ARMS

	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 50, "rad" = 20, "fire" = 50, "acid" = 50)
	togglename = "buttons"
	species_exception = list(/datum/species/golem)


/obj/item/clothing/suit/toggle/labcoat/fieldscribe
	name = "fieldscribe suit"
	desc = "A suit that protects against the weather, and looks stylish, but not much else."
	icon_state = "fieldscribe"
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 16, "bio" = 30, "rad" = 20, "fire" = 10, "acid" = 40)

/obj/item/clothing/suit/toggle/labcoat/scribecoat
	name = "fieldscribe coat"
	desc = "A heavy-duty coat and chestrig fitted with tons of pockets for every scribe's storage needs."
	icon_state = "scribecoat"
	armor = list("melee" = 25, "bullet" = 20, "laser" = 20, "energy" = 10, "bomb" = 16, "bio" = 30, "rad" = 20, "fire" = 10, "acid" = 40)

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

/obj/item/clothing/suit/apron/overalls
	name = "coveralls"
	desc = "A set of denim overalls."
	icon_state = "overalls"
	item_state = "overalls"

/obj/item/clothing/suit/apron/purple_bartender
	name = "purple bartender apron"
	desc = "A fancy purple apron for a stylish person."
	icon_state = "purplebartenderapron"
	item_state = "purplebartenderapron"
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/*
 * Misc
 */


/obj/item/clothing/suit/jacket
	name = "bomber jacket"
	desc = "Aviators not included."
	icon_state = "bomberjacket"
	item_state = "brownjsuit"
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT


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

/obj/item/clothing/suit/jacket/leather/overcoat
	name = "leather overcoat"
	desc = "That's a damn fine coat."
	icon_state = "leathercoat"
	cold_protection = CHEST|GROIN|ARMS|LEGS

/obj/item/clothing/suit/jacket/puffer/vest
	name = "puffer vest"
	desc = "A thick fluffy vest that keeps you warm. Keep away from fire."
	icon_state = "puffervest"
	item_state = "armor"
	cold_protection = CHEST|GROIN
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = -50, "acid" = 0)

/obj/item/clothing/suit/jacket/miljacket
	name = "military jacket"
	desc = "A canvas jacket styled after classical American military garb. Very durable, yet comfortable."
	icon_state = "militaryjacket"
	item_state = "militaryjacket"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 5, "rad" = 0, "fire" = 5, "acid" = 0)

/obj/item/clothing/suit/jacket/letterman
	name = "letterman jacket"
	desc = "A classic brown letterman jacket. Looks pretty hot and heavy."
	icon_state = "letterman"
	item_state = "letterman"

/obj/item/clothing/suit/jacket/letterman_red
	name = "red letterman jacket"
	desc = "A letterman jacket in a sick red color. Radical."
	icon_state = "letterman_red"
	item_state = "letterman_red"


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



/obj/item/clothing/suit/bronze
	name = "bronze suit"
	desc = "A big and clanky suit made of bronze that offers no protection and looks very unfashionable. Nice."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass_old"

/obj/item/clothing/suit/hooded/wintercoat/christmascoatr
	name = "red christmas coat"
	desc = "A festive red Christmas coat! Smells like Candy Cane!"
	icon_state = "christmascoatr"
	item_state = "christmascoatr"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/christmashoodr

/obj/item/clothing/head/hooded/winterhood/christmashoodr
	icon_state = "christmashoodr"



/obj/item/clothing/suit/toggle/labcoat/fieldscribe
	name = "fieldscribe suit"
	desc = "A suit that protects against the weather, and looks stylish, but not much else."
	icon_state = "fieldscribe"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/toggle/labcoat/scribecoat
	name = "fieldscribe coat"
	desc = "A heavy-duty coat and chestrig fitted with tons of pockets for every scribe's storage needs."
	icon_state = "scribecoat"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/slavelabor
	name = "old leather strips"
	desc = "Worn leather strips, used as makeshift protection from chafing and sharp stones by labor slaves."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "legion_slaveleather"
	item_state = "legion_slaveleather"

/obj/item/clothing/suit/bomber
	name = "old bomber jacket"
	desc = "It looks like someone dragged this out of a muddy lake."
	icon_state = "bomberalt"
	item_state = "bomberalt"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 5, "acid" = 0)


/obj/item/clothing/suit/armor/light/duster/robe_hubologist
	name = "hubologist robe"
	desc = "A black robe worn by Adepts of Hubology Studies.<br>Beware - the spirits of the dead are all around us!"
	icon_state = "hubologist"
	item_state = "wcoat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	
/obj/item/clothing/suit/armor/outfit/overalls/sexymaid
	name = "sexy maid outfit"
	desc = "A maid outfit that shows just a little more skin than needed for cleaning duties."
	icon_state = "sexymaid_s"
	item_state = "sexymaid_s"
	body_parts_covered = CHEST

/obj/item/clothing/suit/armor/outfit/jacket/banker
	name = "bankers tailcoat"
	desc = "A long black jacket, finely crafted black leather and smooth finishings make this an extremely fancy piece of rich-mans apparel."
	icon_state = "banker"
	item_state = "banker"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
//Fallout 50s
/obj/item/clothing/suit/armor/light/duster/tan_robe
	name = "tan robe"
	desc = "Only a monk would find this robe nice and comfortable."
	icon_state = "robe_liz"
	item_state = "brownjsuit"

/obj/item/clothing/suit/armor/outfit/vest
	name = "tan vest"
	desc = "It's a vest made of tanned leather."
	icon_state = "tanleather"
	item_state = "det_suit"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/armor/outfit/vest/cowboy //Originally cowboy stuff by Nienhaus
	name = "brown vest"
	desc = "A brown vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboybvest"
	item_state = "lb_suit"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/armor/outfit/vest/bartender
	name = "bartenders vest"
	desc = "A grey vest, adorned with bartenders arm cuffs, a classic western look."
	icon_state = "westender"
	item_state = "lb_suit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/vest/cowboy/grey
	name = "grey vest"
	desc = "A grey vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboygvest"
	item_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/toggle/labcoat/wanderer
	name = "wanderer jacket"
	desc = "A zipped-up hoodie made of tanned leather."
	icon_state = "wanderer"
	item_state = "owl"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)


/obj/item/clothing/suit/toggle/labcoat/followers
	name = "followers lab coat"
	desc = "A worn-down white labcoat with some wiring hanging from the right side.<br>Upon closer inspection, you can see an ancient bloodstains that could tell an entire story about thrilling adventures of a previous owner."
	icon_state = "followers"
	item_state = "labcoat"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 10, "bomb" = 0, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 10)

/obj/item/clothing/suit/hooded/cloak/desert
	name = "desert cloak"
	icon_state = "desertcloak"
	desc = "A practical cloak made out of animal hide."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS


/obj/item/clothing/head/hooded/cloakhood/desert
	name = "desert cloak hood"
	icon_state = "desertcloak"
	desc = "A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/desert/raven_cloak
	name = "Raven cloak"
	desc = "A huge cloak made out of hundreds of knife-like black bird feathers. It glitters in the light, ranging from blue to dark green and purple."
	icon_state = "raven_cloak"
	item_state = "raven_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert/raven_hood

/obj/item/clothing/head/hooded/cloakhood/desert/raven_hood
	name = "Raven cloak hood"
	desc = "A hood fashioned out of patchwork and feathers"
	icon_state = "raven_hood"
	item_state = "raven_hood"


/obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	name = "tattered red cloak"
	icon_state = "goliath_cloak"
	desc = "An old ragged, tattered red cloak that is covered in burns and bullet holes."
	armor = list("melee" = 25, "bullet" = 20, "laser" = 10, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS


/obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	name = "tattered red cloak hood"
	icon_state = "golhood"
	desc = "A tattered hood, better than nothing in the waste."
	armor = list("melee" = 25, "bullet" = 10, "laser" = 10, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)



/obj/item/clothing/suit/jamrock
	name = "disco-ass blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"
	item_state = "jamrock_blazer"
	armor = list("melee" = 5, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 20, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

// "Funny" Masquerade suits. Keep off the maps.

/obj/item/clothing/suit/spookyghost
	name = "spooky ghost"
	desc = "This is obviously just a bedsheet, but maybe try it on?"
	icon_state = "bedsheet"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS|HEAD
	user_vars_to_edit = list("name" = "Spooky Ghost", "real_name" = "Spooky Ghost" , "incorporeal_move" = INCORPOREAL_MOVE_BASIC, "appearance_flags" = KEEP_TOGETHER|TILE_BOUND, "alpha" = 150)
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //so the bedsheet goes over everything but fire
	mutantrace_variation = NONE

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

/obj/item/clothing/suit/chickensuit
	name = "chicken suit"
	desc = "A suit made long ago by the ancient empire KFC."
	icon_state = "chickensuit"
	item_state = "chickensuit"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS|FEET
	flags_inv = HIDESHOES|HIDEJUMPSUIT

/obj/item/clothing/suit/toggle/owlwings
	name = "owl cloak"
	desc = "A soft brown cloak made of synthetic feathers. Soft to the touch, stylish, and a 2 meter wing span that will drive the ladies mad."
	icon_state = "owl_wings"
	item_state = "owl_wings"
	togglename = "wings"
	actions_types = list(/datum/action/item_action/toggle_wings)

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
