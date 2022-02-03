//ARMOR, AND ALL PATREON/CUSTOM/DONOR STUFF (EVEN IF SUIT AND NOT ARMOR) TO GO INTO f13armor.dm
/*FOR REFERENCE
/obj/item/clothing/suit
	icon = 'icons/obj/clothing/suits.dmi'
	name = "suit"
	block_priority = BLOCK_PRIORITY_WEAR_SUIT
	var/fire_resist = T0C+100
	allowed = null
	armor = list("tier" = 1, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	slot_flags = ITEM_SLOT_OCLOTHING
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
/obj/item/clothing/suit/overalls
	name = "overalls"
	desc = "A set of denim overalls suitable for farming."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "overalls_farmer"
	item_state = "overalls_farmer"
	armor = list("melee" = 15, "bullet" = 10, "laser" = 10, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed = list(/obj/item/hatchet, /obj/item/scythe, /obj/item/cultivator, /obj/item/shovel)

/obj/item/clothing/suit/f13/vest
	name = "tan vest"
	desc = "It's a vest made of tanned leather."
	icon_state = "tanleather"
	item_state = "det_suit"
	body_parts_covered = CHEST|GROIN|LEGS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/battlecruiser //Do we have Star Craft here as well?!
	name = "captain's coat"
	desc = "Battlecruiser operational!"
	icon_state = "battlecruiser"
	item_state = "hostrench"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/cowboybvest //Originally cowboy stuff by Nienhaus
	name = "brown vest"
	desc = "A brown vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboybvest"
	item_state = "lb_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS

/obj/item/clothing/suit/f13/westender
	name = "bartenders vest"
	desc = "A grey vest, adorned with bartenders arm cuffs, a classic western look."
	icon_state = "westender"
	item_state = "lb_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/bartender

/obj/item/clothing/suit/f13/cowboygvest
	name = "grey vest"
	desc = "A grey vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboygvest"
	item_state = "gy_suit"
	body_parts_covered = CHEST|GROIN|LEGS
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/ghost_sheet
	name = "ghost sheet"
	desc = "The hands float by themselves, so it's extra spooky."
	icon_state = "ghost_sheet"
	item_state = "ghost_sheet"
	throwforce = 0
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEGLOVES|HIDEEARS|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

//Fallout 13 various suits directory
/obj/item/clothing/suit/f13/robe_liz
	name = "tan robe"
	desc = "Only a monk would find this robe nice and comfortable."
	icon_state = "robe_liz"
	item_state = "brownjsuit"

/obj/item/clothing/suit/f13/mantle_liz
	name = "hide mantle"
	desc = " A rather grisly selection of cured hides and skin, sewn together to form a ragged mantle."
	icon_state = "mantle_liz"
	item_state = "det_suit"
	
/obj/item/clothing/suit/f13/mfp //Mad Max 1 1979 babe!
	name = "MFP jacket"
	desc = "A Main Force Patrol leather jacket.<br>Offbeat."
	icon_state = "mfp"
	item_state = "hostrench"
	armor = list("melee" = 25, "bullet" = 20, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/mfp/raider
	name = "offbeat jacket"
	desc = "A black leather jacket with a single metal shoulder pad on the right side.<br>The right sleeve was obviously ripped or cut away.<br>It looks like it was originally a piece of a Main Force Patrol uniform."
	icon_state = "mfp_raider"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/lonesome
	name = "lonesome duster"
	desc = "A blue leather coat with the number 21 on the back.<br><i>If war doesn't change, men must change, and so must their symbols.</i><br><i>Even if there is nothing at all, know what you follow.</i>"
	icon_state = "courier"
	item_state = "suit-command"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	
/obj/item/clothing/suit/f13/veteran
	name = "merc veteran coat"
	desc = " A blue leather coat adorned with war medals.<br>This type of outfit is common for professional mercenaries and bounty hunters."
	icon_state = "veteran"
	item_state = "suit-command"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/duster
	name = "duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of fearsome bounty hunter."
	icon_state = "duster"
	item_state = "det_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/f13/sheriff
	name = "sheriff duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of a respectful sheriff, bringer of justice."
	icon_state = "sheriff"
	item_state = "det_suit"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/f13/banker
	name = "bankers tailcoat"
	desc = " A long black jacket, finely crafted black leather and smooth finishings make this an extremely fancy piece of rich-mans apparel."
	icon_state = "banker"
	item_state = "banker"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS

/obj/item/clothing/suit/f13/autumn //Based of Colonel Autumn's uniform.
	name = "tan trenchcoat"
	desc = "A heavy-duty tan trenchcoat typically worn by pre-War generals."
	icon_state = "autumn"
	item_state = "autumn"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 30, "bullet" = 30, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets
	

/obj/item/clothing/suit/f13/hubologist
	name = "hubologist robe"
	desc = "A black robe worn by Adepts of Hubology Studies.<br>Beware - the spirits of the dead are all around us!"
	icon_state = "hubologist"
	item_state = "wcoat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 25, "bullet" = 15, "laser" = 15, "energy" = 5, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/sexymaid
	name = "sexy maid outfit"
	desc = "A maid outfit that shows just a little more skin than needed for cleaning duties."
	icon_state = "sexymaid_s"
	item_state = "sexymaid_s"
	body_parts_covered = CHEST

/obj/item/clothing/suit/f13/blacksmith_apron
	name = "blacksmith apron"
	desc = "A heavy leather apron designed for protecting the user when metalforging."
	icon_state = "opifex_apron"
	item_state = "opifex_apron"
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

/obj/item/clothing/suit/bio_suit/f13/hazmat
	name = "hazmat suit"
	desc = "(Yellow Level A , hazmat protective suit.<br>You can see some numbers on the tag: 35 56."
	icon = 'icons/fallout/clothing/suits_utility.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/suit_utility.dmi'
	icon_state = "hazmat"
	item_state = "hazmat"
	armor = list("melee" = 20, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/bio_hood/f13/hazmat
	name = "hazmat hood"
	desc = "My star, my perfect silence."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hazmat"
	item_state = "hazmat_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 29, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)

//Fallout 13 toggle apparel directory
/obj/item/clothing/suit/toggle/labcoat/f13/emergency
	name = "first responder jacket"
	desc = "A high-visibility jacket worn by medical first responders."
	icon_state = "fr_jacket"
	item_state = "fr_jacket"

/obj/item/clothing/suit/toggle/labcoat/f13/warriors
	name = "warriors jacket"
	desc = "A red leather jacket, with the word \"Warriors\" sewn above the white wings on the back."
	icon_state = "warriors"
	item_state = "owl"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 0, "rad" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/toggle/labcoat/f13/wanderer
	name = "wanderer jacket"
	desc = "A zipped-up hoodie made of tanned leather."
	icon_state = "wanderer"
	item_state = "owl"
	armor = list("melee" = 25, "bullet" = 10, "laser" = 30, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 0, "fire" = 0, "acid" = 0)


///////////////////////
// GREAT KHANS ARMOR //
///////////////////////

//Basic Jacket
/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket
	name = "Great Khan jacket"
	desc = "A black leather jacket. <br>There is an illustration on the back - an aggressive, red-eyed skull wearing a fur hat with horns.<br>The skull has a mongoloid moustache - it's obviously a Great Khans emblem."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_jacket"
	item_state = "khan_jacket"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 20, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0)
	slowdown = 0.05
	pocket_storage_component_path = /datum/component/storage/concrete/pockets

/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Armored jacket
/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/armored
	name = "Great Khan armored jacket"
	desc = "A black leather jacket with metal plates and a big Great Khan logo on the back. Some prefer to wear a leather vest (alt-click)."
	icon_state = "khan_jacket_armored"
	item_state = "khan_jacket_armored"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 37, "bullet" = 37, "laser" = 40, "energy" = 25, "bomb" = 30, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0)
	slowdown = 0.12
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small

/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/armored/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Battlecoat
/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
	name = "Great Khan battle coat"
	desc = "Heavy leather coat lined with a patchwork of metal plates on the inside. On the back the symbol of the Great Khans is displayed proudly."
	icon_state = "khan_heavy"
	item_state = "khan_heavy"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS|HANDS|FEET
	armor = list("melee" = 40, "bullet" = 40, "laser" = 47, "energy" = 25, "bomb" = 35, "bio" = 10, "rad" = 10, "fire" = 10, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small
	slowdown = 0.2

/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

// --------------------------------------------------------------------------

/obj/item/clothing/suit/toggle/labcoat/f13/followers
	name = "followers lab coat"
	desc = "A worn-down white labcoat with some wiring hanging from the right side.<br>Upon closer inspection, you can see an ancient bloodstains that could tell an entire story about thrilling adventures of a previous owner."
	icon_state = "followers"
	item_state = "labcoat"
	armor = list("melee" = 25, "bullet" = 15, "laser" = 20, "energy" = 25, "bomb" = 20, "bio" = 100, "rad" = 100, "fire" = 0, "acid" = 0)
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/medical

/obj/item/clothing/suit/armor/f13/generaluniform
	name = "Yuma 1st Irregular General Uniform"
	desc = "(III) A uniform created by Kaleb alongside the laser muskets. On the breast is a patch of the Yuma 1st Irregulars, a sun over a wasteland desert, a cactus standing lonely in the middle. It denotes him as the Leader of the militia company."
	icon_state = "gen_uniform"
	item_state = "gen_uniform"
	armor = list("tier" = 3, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0) //change those values

/obj/item/clothing/suit/hooded/cloak/desert
	name = "desert cloak"
	icon_state = "desertcloak"
	desc = "(II) A practical cloak made out of animal hide."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert
	armor = list("tier" = 2, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS


/obj/item/clothing/head/hooded/cloakhood/desert
	name = "desert cloak hood"
	icon_state = "desertcloak"
	desc = "(II) A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("tier" = 2, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/desert/raven_cloak
	name = "Raven cloak"
	desc = "(II) A huge cloak made out of hundreds of knife-like black bird feathers. It glitters in the light, ranging from blue to dark green and purple."
	icon_state = "raven_cloak"
	item_state = "raven_cloak"
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert/raven_hood

/obj/item/clothing/head/hooded/cloakhood/desert/raven_hood
	name = "Raven cloak hood"
	desc = "(II) A hood fashioned out of patchwork and feathers"
	icon_state = "raven_hood"
	item_state = "raven_hood"

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "deathclaw cloak"
	icon_state = "clawsuitcloak"
	desc = "A staunch, practical cloak made out of sinew and skin from the fearsome deathclaw."
	armor = list("melee" = 40, "bullet" = 20, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	slowdown = 0.07

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "deathclaw cloak hood"
	icon_state = "clawheadcloak"
	desc = "A protective & concealing hood."
	armor = list("melee" = 40, "bullet" = 20, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

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
	icon_state = "armorgrey"
	desc = "(III) A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	armor = list("tier" = 3, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	hoodtype = /obj/item/clothing/head/hooded/parkahood/grey

/obj/item/clothing/head/hooded/parkahood/grey
	name = "armored grey parka hood"
	icon_state = "armorhoodgrey"
	desc = "(III) A protective & concealing parka hood."
	armor = list("tier" = 3, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	name = "tattered red cloak"
	icon_state = "goliath_cloak"
	desc = "(II) An old ragged, tattered red cloak that is covered in burns and bullet holes."
	armor = list("tier" = 2, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS


/obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	name = "tattered red cloak hood"
	icon_state = "golhood"
	desc = "(II) A tattered hood, better than nothing in the waste."
	armor = list("tier" = 2, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/hooded/cloak/drake //SS13 item, obviously
	name = "drake armour"
	icon_state = "dragon"
	desc = "(V) A suit of armour fashioned from the remains of an ash drake."
	armor = list("tier" = 5, "energy" = 40, "bomb" = 70, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	icon_state = "dragon"
	desc = "(V) The skull of a dragon."
	armor = list("tier" = 5, "energy" = 40, "bomb" = 70, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/hooded/cloak/hhunter
	name = "Razorclaw armour"
	icon_state = "rcarmour"
	desc = "A suit of armour fashioned out of the remains of a legendary deathclaw."
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/hhunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF
	slowdown = 0.05

/obj/item/clothing/head/hooded/cloakhood/hhunter
	name = "Razorclaw helm"
	icon_state = "rchelmet"
	desc = "The skull of a legendary deathclaw."
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/f13/jamrock
	name = "disco-ass blazer"
	desc = "Looks like someone skinned this blazer off some long extinct disco-animal. It has an enigmatic white rectangle on the back and the right sleeve."
	icon_state = "jamrock_blazer"
	item_state = "jamrock_blazer"


/obj/item/clothing/suit/hooded/cloak/shunter
	name = "Quickclaw armour"
	icon_state = "birdarmor"
	desc = "A suit of armour fashioned out of the remains of a legendary deathclaw, this one has been crafted to remove a good portion of its protection to improve on speed and trekking."
	slowdown = 0.025
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/shunter
	heat_protection = CHEST|GROIN|LEGS|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/hooded/cloakhood/shunter
	name = "Quickclaw hood"
	icon_state = "birdhood"
	desc = "A hood madde of deathclaw hides, light while also being comfortable to wear, designed for speed."
	armor = list("melee" = 35, "bullet" = 35, "laser" = 35, "energy" = 25, "bomb" = 16, "bio" = 10, "rad" = 10, "fire" = 0, "acid" = 0)
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF
