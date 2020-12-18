//Fallout 13 various suits directory

/obj/item/clothing/suit/f13

/obj/item/clothing/suit/f13/robe_liz
	name = "tan robe"
	desc = "Only a monk would find this robe nice and comfortable."
	icon_state = "robe_liz"
	item_state = "brownjsuit"
/obj/item/storage/box/dice

/obj/item/clothing/suit/f13/mantle_liz
	name = "hide mantle"
	desc = "A rather grisly selection of cured hides and skin, sewn together to form a ragged mantle."
	icon_state = "mantle_liz"
	item_state = "det_suit"
	allowed = list(/obj/item/pen,/obj/item/gun,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/melee,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/scalpel,/obj/item/surgical_drapes,/obj/item/cautery,/obj/item/hemostat,/obj/item/retractor,/obj/item/storage/box/dice,/obj/item/dice)

/obj/item/clothing/suit/f13/vest
	name = "tan vest"
	desc = "A vest made of tanned leather."
	icon_state = "tanleather"
	item_state = "det_suit"
	body_parts_covered = CHEST
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/gun,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/melee,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/scalpel,/obj/item/surgical_drapes,/obj/item/cautery,/obj/item/hemostat,/obj/item/retractor,/obj/item/storage/box/dice,/obj/item/dice)

/obj/item/clothing/suit/f13/puffer
	name = "puffer vest"
	desc = "A thick, worn-down vest with a rubbery water-resistant shell."
	icon_state = "puffervest"
	item_state = "det_suit"
	body_parts_covered = CHEST
	armor = list(melee = 20, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
/obj/item/storage/box/dice

/obj/item/clothing/suit/f13/battlecruiser //Do we have Star Craft here as well?!
	name = "captain's coat"
	desc = "Battlecruiser operational!"
	icon_state = "battlecruiser"
	item_state = "hostrench"
	body_parts_covered = CHEST|ARMS
	armor = list(melee = 20, bullet = 20, laser = 10, energy = 10, bomb = 20, bio = 0, rad = 0, fire = 20, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/melee,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun/energy,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/cowboybvest //Originally cowboy stuff by Nienhaus
	name = "brown vest"
	desc = "A brown vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboybvest"
	item_state = "lb_suit"
/obj/item/storage/box/dice

/obj/item/clothing/suit/f13/cowboygvest
	name = "grey vest"
	desc = "A grey vest, typically worn by wannabe cowboys and prospectors. It has a few pockets for tiny items."
	icon_state = "cowboygvest"
	item_state = "gy_suit"
/obj/item/storage/box/dice

/obj/item/clothing/suit/f13/mfp //Mad Max 1 1979 babe!
	name = "MFP jacket"
	desc = "A Main Force Patrol leather jacket.<br>Offbeat."
	icon_state = "mfp"
	item_state = "hostrench"
	body_parts_covered = CHEST|ARMS
	armor = list(melee = 20, bullet = 10, laser = 0, energy = 0, bomb = 10, bio = 0, rad = 0, fire = 20, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/mfp/raider
	name = "offbeat jacket"
	desc = "A black leather jacket with a single metal shoulder pad on the right side.<br>The right sleeve was obviously ripped or cut away.<br>It looks like it was originally a piece of a Main Force Patrol uniform."
	icon_state = "mfp_raider"

/obj/item/clothing/suit/f13/lonesome
	name = "lonesome duster"
	desc = "A blue leather coat with the number 21 on the back.<br><i>If war doesn't change, men must change, and so must their symbols.</i><br><i>Even if there is nothing at all, know what you follow.</i>"
	icon_state = "courier"
	item_state = "suit-command"
	body_parts_covered = CHEST|GROIN
	armor = list(melee = 20, bullet = 20, laser = 10, energy = 10, bomb = 20, bio = 0, rad = 0, fire = 10, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/melee,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/veteran
	name = "merc veteran coat"
	desc = "A blue leather coat adorned with war medals.<br>This type of outfit is common for professional mercenaries and bounty hunters."
	icon_state = "veteran"
	item_state = "suit-command"
	body_parts_covered = CHEST|GROIN
	armor = list(melee = 20, bullet = 20, laser = 10, energy = 10, bomb = 20, bio = 0, rad = 0, fire = 10, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/duster
	name = "duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of fearsome bounty hunter."
	icon_state = "duster"
	item_state = "det_suit"
	body_parts_covered = CHEST|LEGS|FEET|ARMS
	armor = list(melee = 20, bullet = 20, laser = 0, energy = 0, bomb = 20, bio = 0, rad = 0, fire = 0, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/sheriff
	name = "sheriff duster"
	desc = "A long brown leather overcoat.<br>A powerful accessory of a respectful sheriff, bringer of justice."
	icon_state = "sheriff"
	item_state = "det_suit"
	body_parts_covered = CHEST|LEGS|FEET|ARMS
	armor = list(melee = 30, bullet = 20, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 10, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/weapon,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/banker
	name = "bankers tailcoat"
	desc = "A long black jacket, finely crafted black leather and smooth finishings make this an extremely fancy piece of rich-mans apparel."
	icon_state = "banker"
	item_state = "banker"
	body_parts_covered = CHEST|LEGS|FEET|ARMS
	armor = list(melee = 5, bullet = 5, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/weapon,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/autumn //Based of Colonel Autumn's uniform.
	name = "tan trenchcoat"
	desc = "A heavy-duty tan trenchcoat typically worn by pre-War generals."
	icon_state = "autumn"
	item_state = "autumn"
	body_parts_covered = CHEST|LEGS|FEET|ARMS
	armor = list(melee = 30, bullet = 20, laser = 20, energy = 20, bomb = 20, bio = 0, rad = 999, fire = 0, acid = 0) //Reference to colonel not dying from radiation where anyone else dies.
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/f13/hubologist
	name = "hubologist robe"
	desc = "A black robe worn by Adepts of Hubology Studies.<br>Beware - the spirits of the dead are all around us!"
	icon_state = "hubologist"
	item_state = "wcoat"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/melee,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/weapon,/obj/item/storage/box/dice,/obj/item/dice)

/obj/item/clothing/suit/f13/sexymaid
	name = "sexy maid outfit"
	desc = "A maid outfit that shows just a little more skin than needed for cleaning duties."
	icon_state = "sexymaid_s"
	item_state = "sexymaid_s"
	body_parts_covered = CHEST

//Special Biosuit

/obj/item/clothing/suit/bio_suit/f13/hazmat
	name = "hazmat suit"
	desc = "Yellow Level A , hazmat protective suit.<br>You can see some numbers on the tag: 35 56."
	icon = 'icons/fallout/clothing/suits.dmi'
	icon_state = "hazmat"
	item_state = "hazmat_suit"

/obj/item/clothing/head/bio_hood/f13/hazmat
	name = "hazmat hood"
	desc = "My star, my perfect silence."
	icon = 'icons/fallout/clothing/hats.dmi'
	icon_state = "hazmat"
	item_state = "hazmat_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

//Fallout 13 toggle apparel directory

/obj/item/clothing/suit/toggle/labcoat/f13

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
	body_parts_covered = CHEST
	armor = list(melee = 10, bullet = 10, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)

/obj/item/clothing/suit/toggle/labcoat/f13/wanderer
	name = "wanderer jacket"
	desc = "A zipped-up hoodie made of tanned leather."
	icon_state = "wanderer"
	item_state = "owl"
	body_parts_covered = CHEST
	armor = list(melee = 10, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/weapon,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket
	name = "Great Khan jacket"
	desc = "A black leather jacket. <br>There is an illustration on the back - an aggressive, red-eyed skull wearing a fur hat with horns.<br>The skull has a mongoloid moustache - it's obviously a Great Khans emblem."
	icon_state = "khan_jacket"
	item_state = "jensencoat"
	body_parts_covered = CHEST
	armor = list(melee = 40, bullet = 35, laser = 25, energy = 25, bomb = 30, bio = 0, rad = 0, fire = 25, acid = 25)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/weapon,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket_armored
	name = "Great Khan armored jacket"
	desc = "A black leather jacket. <br>There is an illustration on the back - an aggressive, red-eyed skull wearing a fur hat with horns.<br>The skull has a mongoloid moustache - it's obviously a Great Khans emblem.<br>Protective plates have been sewn into the jacket."
	icon_state = "khan_jacket"
	item_state = "jensencoat"
	body_parts_covered = CHEST
	armor = list(melee = 50, bullet = 45, laser = 35, energy = 35, bomb = 30, bio = 0, rad = 0, fire = 25, acid = 25)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/weapon,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/toggle/labcoat/f13/khan/battlecoat
	name = "Great Khan battle coat"
	desc = "A dark red leather coat lined with a patchwork of metal plates and padding on the inside. The back is dominated by a burning skull adorned with a horned helmet; the symbol of the Khans."
	icon_state = "khan_battlecoat"
	item_state = "khan_battlecoat"
	body_parts_covered = CHEST
	armor = list(melee = 50, bullet = 45, laser = 35, energy = 35, bomb = 30, bio = 0, rad = 0, fire = 25, acid = 25)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/weapon,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/gun,/obj/item/ammo_box,/obj/item/ammo_casing)

/obj/item/clothing/suit/toggle/labcoat/f13/followers
	name = "followers lab coat"
	desc = "A worn-down white labcoat with some wiring hanging from the right side.<br>Upon closer inspection, you can see an ancient bloodstains that could tell an entire story about thrilling adventures of a previous owner."
	icon_state = "followers"
	item_state = "labcoat"
	body_parts_covered = CHEST
	armor = list(melee = 0, bullet = 0, laser = 10, energy = 10, bomb = 0, bio = 10, rad = 10, fire = 10, acid = 10)
	allowed = list(/obj/item/pen,/obj/item/paper,/obj/item/stamp,/obj/item/reagent_containers/food/drinks/flask,/obj/item/storage/box/matches,/obj/item/lighter,/obj/item/clothing/mask/cigarette,/obj/item/storage/fancy/cigarettes,/obj/item/flashlight,/obj/item/ammo_box,/obj/item/ammo_casing,/obj/item/scalpel,/obj/item/surgical_drapes,/obj/item/cautery,/obj/item/hemostat,/obj/item/retractor,/obj/item/storage/box/dice,/obj/item/dice)

/obj/item/clothing/suit/armor/f13/generaluniform
    name = "Yuma 1st Irregular General Uniform"
    desc = "A uniform created by Kaleb alongside the laser muskets. On the breast is a patch of the Yuma 1st Irregulars, a sun over a wasteland desert, a cactus standing lonely in the middle. It denotes him as the Leader of the militia company."
    icon_state = "gen_uniform"
    item_state = "gen_uniform"
    body_parts_covered = CHEST|LEGS|FEET|ARMS
    armor = list(melee = 18, bullet = 20, laser = 10, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 0, acid = 0) //change those values

/obj/item/clothing/suit/hooded/cloak/desert
	name = "desert cloak"
	icon_state = "desertcloak"
	desc = "A practical cloak made out of animal hide."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/spear, /obj/item/gun)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list("melee" = 20, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/head/hooded/cloakhood/desert
	name = "desert cloak hood"
	icon_state = "desertcloak"
	desc = "A protective and concealing hood."
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("melee" = 20, "bullet" = 15, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

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


/obj/item/clothing/suit/hooded/cloak/desert/bridgekeeper
	name = "tattered cloak"
	desc = "An old ragged cloak that is covered in plasma burns and scorches."
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/desert/bridgekeeper
	armor = list("melee" = 40, "bullet" = 45, "laser" = 40, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/head/hooded/cloakhood/desert/bridgekeeper
	name = "tattered cloak hood"
	armor = list("melee" = 45, "bullet" = 30, "laser" = 30, "energy" = 60, "bomb" = 25, "bio" = 60, "rad" = 60, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/hooded/cloak/goliath
	name = "deathclaw cloak"
	icon_state = "goliath_cloak"
	desc = "A staunch, practical cloak made out of sinew and skin from the fearsome deathclaw."
	allowed = list(/obj/item/gun, /obj/item/kitchen, /obj/item/twohanded, /obj/item/claymore, /obj/item/spear)
	armor = list("melee" = 50, "bullet" = 40, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/cloakhood/goliath
	name = "deathclaw cloak hood"
	icon_state = "golhood"
	desc = "A protective & concealing hood."
	armor = list("melee" = 50, "bullet" = 40, "laser" = 25, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/parka/medical
	name = "armored medical parka"
	icon_state = "armormedical"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/spear, /obj/item/gun)
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	hoodtype = /obj/item/clothing/head/hooded/parkahood/medical
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/parkahood/medical
	name = "armored medical parka hood"
	icon_state = "armorhoodmedical"
	desc = "A protective & concealing parka hood."
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/parka/grey
	name = "grey armored parka"
	icon_state = "armorgrey"
	desc = "A staunch, practical parka made out of a wind-breaking jacket, reinforced with metal plates."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/pickaxe, /obj/item/spear,/obj/item/gun)
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	hoodtype = /obj/item/clothing/head/hooded/parkahood/grey
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/head/hooded/parkahood/grey
	name = "armored grey parka hood"
	icon_state = "armorhoodgrey"
	desc = "A protective & concealing parka hood."
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 60, "acid" = 60)
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/suit/hooded/cloak/goliath/tatteredred
	name = "tattered red cloak"
	desc = "An old ragged, tattered red cloak that is covered in burns and bullet holes."
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/goliath/tattered

/obj/item/clothing/head/hooded/cloakhood/goliath/tattered
	name = "tattered red cloak hood"
	desc = "A tattered hood, better than nothing in the waste."
	armor = list("melee" = 20, "bullet" = 20, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/hooded/cloak/drake
	name = "drake armour"
	icon_state = "dragon"
	desc = "A suit of armour fashioned from the remains of an ash drake."
	allowed = list(/obj/item/flashlight, /obj/item/tank/internals, /obj/item/resonator, /obj/item/mining_scanner, /obj/item/t_scanner/adv_mining_scanner, /obj/item/gun/energy/kinetic_accelerator, /obj/item/pickaxe, /obj/item/spear)
	armor = list("melee" = 70, "bullet" = 30, "laser" = 50, "energy" = 40, "bomb" = 70, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/drake
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/hooded/cloakhood/drake
	name = "drake helm"
	icon_state = "dragon"
	desc = "The skull of a dragon."
	armor = list("melee" = 70, "bullet" = 30, "laser" = 50, "energy" = 40, "bomb" = 70, "bio" = 60, "rad" = 50, "fire" = 100, "acid" = 100)
	heat_protection = HEAD
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/suit/hooded/cloak/hhunter
	name = "Razorclaw armour"
	icon_state = "rcarmour"
	desc = "A suit of armour fashioned out of the remains of a legendary deathclaw."
	allowed = list(/obj/item/gun, /obj/item/kitchen, /obj/item/twohanded, /obj/item/claymore, /obj/item/spear, /obj/item/melee/transforming/cleaving_saw)
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	hoodtype = /obj/item/clothing/head/hooded/cloakhood/hhunter
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/head/hooded/cloakhood/hhunter
	name = "Razorclaw helm"
	icon_state = "rchelmet"
	desc = "The skull of a legendary deathclaw."
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	heat_protection = HEAD
	resistance_flags = FIRE_PROOF | ACID_PROOF

