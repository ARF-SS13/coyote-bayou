/* //ARMOR, AND ALL PATREON/CUSTOM/DONOR STUFF (EVEN IF SUIT AND NOT ARMOR) TO GO INTO f13armor.dm
/*FOR REFERENCE
/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	block_priority = BLOCK_PRIORITY_WEAR_SUIT
	var/fire_resist = T0C+100
	allowed = null
	slot_flags = INV_SLOTBIT_OCLOTHING
	body_parts_covered = CHEST|GROIN|LEGS|ARMS //I don't care if some armors only visibly covers the chest, they're going to offer protection to limbs too because game design.
	var/blood_overlay_type = "suit"
	var/togglename = null
	var/suittoggled = FALSE
	limb_integrity = 0 // disabled for most exo-suits
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/suit/Initialize()
	. = ..()
	if(!allowed)
		allowed = GLOB.f13_coat_allowed

/obj/item/clothing/suit/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		if(damaged_clothes)
			. += mutable_appearance('icons/effects/item_damage.dmi', "damaged[blood_overlay_type]")
		if(blood_DNA)
			var/file2use = (style_flags & STYLE_ALL_TAURIC) ? 'modular_citadel/icons/mob/64x32_effects.dmi' : 'icons/effects/blood.dmi'
			. += mutable_appearance(file2use, "[blood_overlay_type]blood", color = blood_DNA_to_color())
		var/mob/living/carbon/human/M = loc
		if(ishuman(M) && M.w_uniform)
			var/obj/item/clothing/under/U = M.w_uniform
			if(istype(U) && U.attached_accessory)
				var/obj/item/clothing/accessory/A = U.attached_accessory
				if(A.above_suit)
					. += U.accessory_overlay

/obj/item/clothing/suit/update_clothes_damaged_state()
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_wear_suit()
*/

//Fallout 50s
/obj/item/clothing/suit/armor/outfit/overalls/farmer
	name = "overalls"
	desc = "A set of denim overalls suitable for farming."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "overalls_farmer"
	inhand_icon_state = "overalls_farmer"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed = list(/obj/item/hatchet, /obj/item/scythe, /obj/item/cultivator, /obj/item/shovel)

/obj/item/clothing/suit/armor/outfit/vest
	name = "tan vest"
	desc = "It's a vest made of tanned leather."
	icon_state = "tanleather"
	inhand_icon_state = "det_suit"
	body_parts_covered = CHEST|GROIN|LEGS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/jacket/battlecruiser //Do we have Star Craft here as well?!
	name = "captain's coat"
	desc = "Battlecruiser operational!"
	icon_state = "battlecruiser"
	inhand_icon_state = "hostrench"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/vest/cowboy //Originally cowboy stuff by Nienhaus
	name = "brown vest"
	desc = "A brown vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboybvest"
	inhand_icon_state = "lb_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/armor/outfit/vest/bartender
	name = "bartenders vest"
	desc = "A grey vest, adorned with bartenders arm cuffs, a classic western look."
	icon_state = "westender"
	inhand_icon_state = "lb_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/service

/obj/item/clothing/suit/armor/outfit/vest/cowboy/grey
	name = "grey vest"
	desc = "A grey vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboygvest"
	inhand_icon_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|LEGS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/costume/ghost
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	inhand_icon_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

//Fallout 13 various suits directory
/obj/item/clothing/suit/armor/light/duster/tan_robe
	name = "tan robe"
	desc = "Only a monk would find this robe nice and comfortable."
	icon_state = "robe_liz"
	inhand_icon_state = "brownjsuit"

/obj/item/clothing/suit/armor/outfit/jacket/mantle
	name = "hide mantle"
	desc = " A rather grisly selection of cured hides and skin, sewn together to form a ragged mantle."
	icon_state = "mantle_liz"
	inhand_icon_state = "det_suit"

/obj/item/clothing/suit/armor/outfit/jacket/mfp //Mad Max 1 1979 babe!
	name = "MFP jacket"
	desc = "A Main Force Patrol leather jacket.<br>Offbeat."
	icon_state = "mfp"
	inhand_icon_state = "hostrench"
	armor = list("melee" = 25, "bullet" = 20, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/jacket/mfp/raider
	name = "offbeat jacket"
	desc = "A black leather jacket with a single metal shoulder pad on the right side.<br>The right sleeve was obviously ripped or cut away.<br>It looks like it was originally a piece of a Main Force Patrol uniform."
	icon_state = "mfp_raider"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/light/duster/lonesome
	name = "lonesome duster"
	desc = "A blue leather coat with the number 21 on the back.<br><i>If war doesn't change, men must change, and so must their symbols.</i><br><i>Even if there is nothing at all, know what you follow.</i>"
	icon_state = "courier"
	inhand_icon_state = "suit-command"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/armor/outfit/jacket/merc
	name = "merc veteran coat"
	desc = " A blue leather coat adorned with war medals.<br>This type of outfit is common for professional mercenaries and bounty hunters."
	icon_state = "veteran"
	inhand_icon_state = "suit-command"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/light/duster
	name = "duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of fearsome bounty hunter."
	icon_state = "duster"
	inhand_icon_state = "det_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/armor/light/duster/sheriff
	name = "sheriff duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of a respectful sheriff, bringer of justice."
	icon_state = "sheriff"
	inhand_icon_state = "det_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/armor/outfit/jacket/banker
	name = "bankers tailcoat"
	desc = " A long black jacket, finely crafted black leather and smooth finishings make this an extremely fancy piece of rich-mans apparel."
	icon_state = "banker"
	inhand_icon_state = "banker"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/armor/light/duster/autumn //Based of Colonel Autumn's uniform.
	name = "tan trenchcoat"
	desc = "A heavy-duty tan trenchcoat typically worn by Pre-Fall generals."
	icon_state = "autumn"
	inhand_icon_state = "autumn"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 30, "bullet" = 30, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets


/obj/item/clothing/suit/armor/light/duster/robe_hubologist
	name = "hubologist robe"
	desc = "A black robe worn by Adepts of Hubology Studies.<br>Beware - the spirits of the dead are all around us!"
	icon_state = "hubologist"
	inhand_icon_state = "wcoat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/overalls/sexymaid
	name = "sexy maid outfit"
	desc = "A maid outfit that shows just a little more skin than needed for cleaning duties."
	icon_state = "sexymaid_s"
	inhand_icon_state = "sexymaid_s"
	body_parts_covered = CHEST

/obj/item/clothing/suit/armor/outfit/overalls/blacksmith
	name = "blacksmith apron"
	desc = "A heavy leather apron designed for protecting the user when metalforging."
	icon_state = "opifex_apron"
	inhand_icon_state = "opifex_apron"
	blood_overlay_type = "armor"
	allowed = list(/obj/item/crowbar,
		/obj/item/screwdriver,
		/obj/item/weldingtool,
		/obj/item/wirecutters,
		/obj/item/wrench,
		/obj/item/multitool,
		/obj/item/flashlight,
		/obj/item/stack/cable_coil,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/geiger_counter,
		/obj/item/extinguisher/mini,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/holosign_creator,
		/obj/item/assembly/signaler
	) //robust storage options!! -superballs
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

//Special Biosuit

/obj/item/clothing/suit/bio_suit/hazmat
	name = "hazmat suit"
	desc = "(Yellow Level A , hazmat protective suit.<br>You can see some numbers on the tag: 35 56."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "hazmat"
	inhand_icon_state = "hazmat"
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/bio_hood/hazmat
	name = "hazmat hood"
	desc = "My star, my perfect silence."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hazmat"
	inhand_icon_state = "hazmat_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 29, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

//Fallout 13 toggle apparel directory
/obj/item/clothing/suit/toggle/labcoat/emergency
	name = "first responder jacket"
	desc = "A high-visibility jacket worn by medical first responders."
	icon_state = "fr_jacket"
	inhand_icon_state = "fr_jacket"

/obj/item/clothing/suit/toggle/labcoat/warriors
	name = "warriors jacket"
	desc = "A red leather jacket, with the word \"Warriors\" sewn above the white wings on the back."
	icon_state = "warriors"
	inhand_icon_state = "owl"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 0, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/toggle/labcoat/wanderer
	name = "wanderer jacket"
	desc = "A zipped-up hoodie made of tanned leather."
	icon_state = "wanderer"
	inhand_icon_state = "owl"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)


///////////////////////
// GREAT KHANS ARMOR //
///////////////////////

//Basic Jacket
/obj/item/clothing/suit/toggle/labcoat/khan_jacket
	name = "Great Khan jacket"
	desc = "A black leather jacket. <br>There is an illustration on the back - an aggressive, red-eyed skull wearing a fur hat with horns.<br>The skull has a mongoloid moustache - it's obviously a Great Khans emblem."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_jacket"
	inhand_icon_state = "khan_jacket"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0, "wound" = 30)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/toggle/labcoat/khan_jacket/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Armored jacket
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored
	name = "Great Khan armored jacket"
	desc = "A black leather jacket with ballistic plates and a big Great Khan logo on the back. Some prefer to wear a leather vest (alt-click)."
	icon_state = "khan_jacket_armored"
	inhand_icon_state = "khan_jacket_armored"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 37, "bullet" = 37, "laser" = 40, "energy" = 25, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0, "wound" = 30)
	slowdown = 0.08
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/toggle/labcoat/khan_jacket/armored/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Battlecoat
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	name = "Great Khan battle coat"
	desc = "Heavy leather coat lined with a patchwork of metal plates on the inside. On the back the symbol of the Great Khans is displayed proudly."
	icon_state = "khan_heavy"
	inhand_icon_state = "khan_heavy"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 40, "bullet" = 40, "laser" = 47, "energy" = 25, "bomb" = 35, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0, "wound" = 40)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	slowdown = 0.3

//Battlecoat/Goji
/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat/goji
	name = "Golden Geckoskin jacket"
	desc = "Heavy Geckoskin jacket lined with a bulletproof lining on the inside. On the back the symbol of the Great Khans is displayed proudly."
	icon_state = "GojiSuit"
	inhand_icon_state = "GojiSuit"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0, "wound" = 30)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

// --------------------------------------------------------------------------

/obj/item/clothing/suit/toggle/labcoat/followers
	name = "followers lab coat"
	desc = "A worn-down white labcoat with some wiring hanging from the right side.<br>Upon closer inspection, you can see an ancient bloodstains that could tell an entire story about thrilling adventures of a previous owner."
	icon_state = "followers"
	inhand_icon_state = "labcoat"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical

/obj/item/clothing/suit/armor/generaluniform
	name = "Yuma 1st Irregular General Uniform"
	desc = "A uniform created by Kaleb alongside the laser muskets. On the breast is a patch of the Yuma 1st Irregulars, a sun over a wasteland desert, a cactus standing lonely in the middle. It denotes him as the Leader of the militia company."
	icon_state = "gen_uniform"
	inhand_icon_state = "gen_uniform"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)	//change those values

/obj/item/clothing/suit/hooded/cloak/desert
	name = "desert cloak"
	icon_state = "desertcloak"
	desc = "A practical cloak made out of animal hide."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS


/obj/item/clothing/head/hooded/cloakhood/desert
	name = "desert cloak hood"
	icon_state = "desertcloak"
	desc = "A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/desert/raven_cloak
	name = "Raven cloak"
	desc = "A huge cloak made out of hundreds of knife-like black bird feathers. It glitters in the light, ranging from blue to dark green and purple."
	icon_state = "raven_cloak"
	inhand_icon_state = "raven_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert/raven_hood

/obj/item/clothing/head/hooded/cloakhood/desert/raven_hood
	name = "Raven cloak hood"
	desc = "A hood fashioned out of patchwork and feathers"
	icon_state = "raven_hood"
	inhand_icon_state = "raven_hood"

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "aethergiest cloak"
	desc = "A staunch, practical cloak made out of sinew and skin from the fearsome aethergiest."
	icon_state = "clawsuitcloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.07
	armor = list("melee" = 40, "bullet" = 20, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "aethergiest cloak hood"
	desc = "A protective & concealing hood."
	icon_state = "clawheadcloak"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 40, "bullet" = 20, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/parka/medical
	name = "armored medical parka"
	icon_state = "armormedical"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."

	hoodtype = /obj/item/clothing/head/hooded/parkahood/medical

/obj/item/clothing/head/hooded/parkahood/medical
	name = "armored medical parka hood"
	icon_state = "armorhoodmedical"
	desc = " A protective & concealing parka hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/parka/grey
	name = "grey armored parka"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	icon_state = "armorgrey"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/parkahood/grey

/obj/item/clothing/head/hooded/parkahood/grey
	name = "armored grey parka hood"
	desc = "A protective & concealing parka hood."
	icon_state = "armorhoodgrey"
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)


/obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	name = "tattered red cloak"
	desc = "An old ragged, tattered red cloak that is covered in burns and bullet holes."
	icon_state = "goliath_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)



/obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	name = "tattered red cloak hood"
	desc = "A tattered hood, better than nothing in the waste."
	icon_state = "golhood"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/drake //SS13 item, obviously
	name = "drake armour"
	desc = "A suit of armour fashioned from the remains of an ash drake."
	icon_state = "dragon"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	desc = "The skull of a dragon."
	icon_state = "dragon"
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/hhunter
	name = "Razorclaw armour"
	desc = "A suit of armour fashioned out of the remains of a legendary aethergiest."
	icon_state = "rcarmour"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/hhunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = 0.05
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/hooded/cloakhood/hhunter
	name = "Razorclaw helm"
	desc = "The skull of a legendary aethergiest."
	icon_state = "rchelmet"
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/outfit/jacket/jamrock
	name = "disco-ass blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"
	inhand_icon_state = "jamrock_blazer"


/obj/item/clothing/suit/hooded/cloak/shunter
	name = "Quickclaw armour"
	desc = "A suit of armour fashioned out of the remains of a legendary aethergiest, this one has been crafted to remove a good portion of its protection to improve on speed and trekking."
	icon_state = "birdarmor_t"
	slowdown = 0
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/shunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 40, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 30)

/obj/item/clothing/head/hooded/cloakhood/shunter
	name = "Quickclaw hood"
	desc = "A hood madde of aethergiest hides, light while also being comfortable to wear, designed for speed."
	icon_state = "birdhood"
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = list("melee" = 40, "bullet" = 40, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0, "wound" = 30)
 */
