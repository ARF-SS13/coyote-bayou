/* Backpacks
 * Contains:
 *		Backpack
 *		Backpack Types
 *		Satchel Types
 */

/*
 * Backpack
 */

/obj/item/storage/debug
	name = "debug testsack"
	desc = "A testing device used to hold various debug things for testing."
	icon_state = "eq_backpack"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = INV_SLOTBIT_BACK	//ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	component_type = /datum/component/storage/concrete/debug_sack/smaller

/obj/item/storage/debug_box
	name = "debug testbox"
	desc = "A testing device used to hold various debug things for testing."
	icon_state = "eq_box"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = INV_SLOTBIT_BACK	//ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	component_type = /datum/component/storage/concrete/debug_sack

/obj/item/storage/backpack
	name = "hiking backpack"
	desc = "You wear this on your back and put items into it."
	icon_state = "backpack"
	item_state = "backpack"
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = INV_SLOTBIT_BACK	//ERROOOOO
	resistance_flags = NONE
	max_integrity = 300
	component_type = /datum/component/storage/concrete/backpack

/*
 * Backpack Types
 */

/obj/item/storage/backpack/old/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 12

/obj/item/storage/backpack/holding
	name = "bag of holding"
	desc = "A backpack that opens into a localized pocket of Blue Space."
	icon_state = "holdingpack"
	item_state = "holdingpack"
	resistance_flags = FIRE_PROOF
	item_flags = NO_MAT_REDEMPTION
	armor = ARMOR_VALUE_GENERIC_ITEM
	component_type = /datum/component/storage/concrete/bluespace/bag_of_holding
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/holding/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.allow_big_nesting = TRUE
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.max_combined_w_class = 35

/obj/item/storage/backpack/spearquiver
	name = "sturdy quiver"
	desc = "A leather and iron quiver designed to hold throwing spears and bolas."
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/belt.dmi'
	icon_state = "spearquiver"
	item_state = "spearquiver"
	slot_flags = INV_SLOTBIT_BACK|INV_SLOTBIT_BELT
	component_type = /datum/component/storage/concrete/backpack/spear_quiver

/obj/item/storage/backpack/spearquiver/PopulateContents()
	new /obj/item/throwing_star/spear(src)
	new /obj/item/throwing_star/spear(src)
	new /obj/item/throwing_star/spear(src)
	new /obj/item/throwing_star/spear(src)
	new /obj/item/throwing_star/spear(src)

/obj/item/storage/backpack/spearquiver/empty/PopulateContents()
	return

/obj/item/storage/backpack/spearquiver/AltClick(mob/living/carbon/user)
	. = ..()
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	if(!length(user.get_empty_held_indexes()))
		to_chat(user, span_warning("Your hands are full!"))
		return
	var/obj/item/throwing_star/L = locate() in contents
	if(L)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, L, user, FALSE)
		user.put_in_hands(L)
		to_chat(user, span_notice("You take a spear out of the quiver."))
		return TRUE
	var/obj/item/restraints/legcuffs/W = locate() in contents
	if(W && contents.len > 0)
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, W, user, FALSE)
		user.put_in_hands(W)
		to_chat(user, span_notice("You take a bola out of the quiver."))
	else
		to_chat(user, span_notice("There is nothing left in the quiver."))
	return TRUE

/obj/item/storage/backpack/holding/satchel
	name = "satchel of holding"
	desc = "A satchel that opens into a localized pocket of Blue Space."
	icon_state = "holdingsat"
	item_state = "holdingsat"
	species_exception = list(/datum/species/angel)

/obj/item/storage/backpack/holding/duffel
	name = "duffel bag of holding"
	desc = "A duffel bag that opens into a localized pocket of Blue Space."
	icon_state = "holdingduffel"
	item_state = "holdingduffel"

/obj/item/storage/backpack/holding/singularity_act(current_size)
	var/dist = max((current_size - 2),1)
	explosion(src.loc,(dist),(dist*2),(dist*4))
	return

/obj/item/storage/backpack/santabag
	name = "Santa's Gift Bag"
	desc = "Space Santa uses this to deliver toys to all the nice children in space in Christmas! Wow, it's pretty big!"
	icon_state = "giftbag0"
	item_state = "giftbag"
	w_class = WEIGHT_CLASS_BULKY
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/backpack/duffelbag/scav

/obj/item/storage/backpack/cultpack
	name = "trophy rack"
	desc = "It's useful for both carrying extra gear and proudly declaring your insanity."
	icon_state = "cultpack"
	item_state = "backpack"

/obj/item/storage/backpack/explorer
	name = "explorer bag"
	desc = "A robust backpack for stashing your loot."
	icon_state = "explorerpack"
	item_state = "explorerpack"

/obj/item/storage/backpack/medic
	name = "medical backpack"
	desc = "It's a backpack especially designed for use in a sterile environment."
	icon_state = "medicalpack"
	item_state = "medicalpack"

/obj/item/storage/backpack/security
	name = "security backpack"
	desc = "It's a very robust backpack."
	icon_state = "securitypack"
	item_state = "securitypack"

/obj/item/storage/backpack/captain
	name = "captain's backpack"
	desc = "It's a special backpack made exclusively for US Government officers."
	icon_state = "captainpack"
	item_state = "captainpack"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/industrial
	name = "industrial backpack"
	desc = "It's a tough backpack for the daily grind of station life."
	icon_state = "engiepack"
	item_state = "engiepack"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/botany
	name = "botany backpack"
	desc = "It's a backpack made of all-natural fibers."
	icon_state = "botpack"
	item_state = "botpack"

/obj/item/storage/backpack/chemistry
	name = "chemistry backpack"
	desc = "A backpack specially designed to repel stains and hazardous liquids."
	icon_state = "chempack"
	item_state = "chempack"

/obj/item/storage/backpack/genetics
	name = "genetics backpack"
	desc = "A bag designed to be super tough, just in case someone hulks out on you."
	icon_state = "genepack"
	item_state = "genepack"

/obj/item/storage/backpack/science
	name = "science backpack"
	desc = "A specially designed backpack. It's fire resistant and smells vaguely of plasma."
	icon_state = "toxpack"
	item_state = "toxpack"

/obj/item/storage/backpack/virology
	name = "virology backpack"
	desc = "A backpack made of hypo-allergenic fibers. It's designed to help prevent the spread of disease. Smells like monkey."
	icon_state = "viropack"
	item_state = "viropack"



/*
 * Satchel Types
 */

/obj/item/storage/backpack/satchel
	name = "satchel"
	desc = "A trendy looking satchel."
	icon_state = "satchel-norm"
	species_exception = list(/datum/species/angel) //satchels can be equipped since they are on the side, not back

/obj/item/storage/backpack/satchel/leather
	name = "leather satchel"
	desc = "It's a very fancy satchel made with fine leather."
	icon_state = "satchel"

/obj/item/storage/backpack/satchel/leather/withwallet/PopulateContents()
	new /obj/item/storage/wallet/random(src)

/obj/item/storage/backpack/satchel/eng
	name = "industrial satchel"
	desc = "A tough satchel with extra pockets."
	icon_state = "satchel-eng"
	item_state = "engiepack"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/satchel/med
	name = "medical satchel"
	desc = "A sterile satchel used in medical departments."
	icon_state = "satchel-med"
	item_state = "medicalpack"

/obj/item/storage/backpack/satchel/vir
	name = "virologist satchel"
	desc = "A sterile satchel with virologist colours."
	icon_state = "satchel-vir"
	item_state = "satchel-vir"

/obj/item/storage/backpack/satchel/chem
	name = "chemist satchel"
	desc = "A sterile satchel with chemist colours."
	icon_state = "satchel-chem"
	item_state = "satchel-chem"

/obj/item/storage/backpack/satchel/gen
	name = "geneticist satchel"
	desc = "A sterile satchel with geneticist colours."
	icon_state = "satchel-gen"
	item_state = "satchel-gen"

/obj/item/storage/backpack/satchel/tox
	name = "scientist satchel"
	desc = "Useful for holding research materials."
	icon_state = "satchel-tox"
	item_state = "satchel-tox"

/obj/item/storage/backpack/satchel/hyd
	name = "botanist satchel"
	desc = "A satchel made of all natural fibers."
	icon_state = "satchel-hyd"
	item_state = "satchel-hyd"

/obj/item/storage/backpack/satchel/sec
	name = "security satchel"
	desc = "A robust satchel for security related needs."
	icon_state = "satchel-sec"
	item_state = "securitypack"

/obj/item/storage/backpack/satchel/explorer
	name = "explorer satchel"
	desc = "A robust satchel for stashing your loot."
	icon_state = "satchel-explorer"
	item_state = "securitypack"

/obj/item/storage/backpack/satchel/bone
	name = "bone satchel"
	desc = "A grotesque satchel made of sinews and bones."
	icon = 'icons/obj/mining.dmi'
	icon_state = "goliath_saddle"
	slot_flags = INV_SLOTBIT_BACK

/obj/item/storage/backpack/satchel/cap
	name = "captain's satchel"
	desc = "An exclusive satchel for US Government officers."
	icon_state = "satchel-cap"
	item_state = "captainpack"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/satchel/flat
	name = "smuggler's satchel"
	desc = "A very slim satchel that can easily fit into tight spaces."
	icon_state = "satchel-flat"
	w_class = WEIGHT_CLASS_NORMAL //Can fit in backpacks itself.
	level = 1
	component_type = /datum/component/storage/concrete/secret_satchel

/obj/item/storage/backpack/satchel/invisible
	name = "inconspicuous satchel"
	desc = "A minimalist satchel designed to fit inside of clothing, directly against the skin."
	icon_state = "invisible_satchel"
	icon_state = "invisible_satchel"

/obj/item/storage/backpack/satchel/flat/Initialize()
	. = ..()
	SSpersistence.new_secret_satchels += src

/obj/item/storage/backpack/satchel/flat/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_combined_w_class = 6
	STR.cant_hold = typecacheof(list(/obj/item/storage/backpack/satchel/flat)) //muh recursive backpacks

/obj/item/storage/backpack/satchel/flat/hide(intact)
	if(intact)
		invisibility = INVISIBILITY_MAXIMUM
		anchored = TRUE //otherwise you can start pulling, cover it, and drag around an invisible backpack.
		icon_state = "[initial(icon_state)]2"
	else
		invisibility = initial(invisibility)
		anchored = FALSE
		icon_state = initial(icon_state)

/obj/item/storage/backpack/satchel/flat/PopulateContents()
	new /obj/item/stack/tile/plasteel(src)
	new /obj/item/crowbar(src)

/obj/item/storage/backpack/satchel/flat/Destroy()
	SSpersistence.new_secret_satchels -= src
	return ..()

/obj/item/storage/backpack/satchel/flat/secret
	var/list/reward_one_of_these = list() //Intended for map editing
	var/list/reward_all_of_these = list() //use paths!
	var/revealed = FALSE

/obj/item/storage/backpack/satchel/flat/secret/Initialize()
	. = ..()

	if(isfloorturf(loc) && !isplatingturf(loc))
		hide(1)

/obj/item/storage/backpack/satchel/flat/secret/hide(intact)
	..()
	if(!intact && !revealed)
		if(reward_one_of_these.len > 0)
			var/reward = pick(reward_one_of_these)
			new reward(src)
		for(var/R in reward_all_of_these)
			new R(src)
		revealed = TRUE

/obj/item/storage/backpack/duffelbag
	name = "duffel bag"
	desc = "A large duffel bag for holding extra things."
	icon_state = "duffel"
	item_state = "duffel"
	slowdown = DUFFELBAG_SLOWDOWN
	component_type = /datum/component/storage/concrete/backpack/duffelbag

/obj/item/storage/backpack/duffelbag/equipment/update_icon_state()
	if(contents.len == 0)
		qdel(src)

/obj/item/storage/backpack/duffelbag/scavengers
	name = "scavenger's duffel bag"
	desc = "An extra large duffel bag for holding extra things."
	slowdown = DUFFELBAG_SCAV_SLOWDOWN
	component_type = /datum/component/storage/concrete/backpack/duffelbag/scav

/obj/item/storage/backpack/duffelbag/captain
	name = "captain's duffel bag"
	desc = "A large duffel bag for holding extra captainly goods."
	icon_state = "duffel-captain"
	item_state = "duffel-captain"

/obj/item/storage/backpack/duffelbag/med
	name = "medical duffel bag"
	desc = "A large duffel bag for holding extra medical supplies."
	icon_state = "duffel-med"
	item_state = "duffel-med"

/obj/item/storage/backpack/duffelbag/med/surgery
	name = "surgical duffel bag"
	desc = "A large duffel bag for holding extra medical supplies - this one seems to be designed for holding surgical tools."

/obj/item/storage/backpack/duffelbag/med/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/reagent_containers/medspray/sterilizine(src)
	new /obj/item/razor(src)
	new /obj/item/stack/sticky_tape/surgical(src)
	new /obj/item/stack/sticky_tape/surgical(src)
	new /obj/item/stack/medical/bone_gel(src)
	new /obj/item/stack/medical/bone_gel(src)

/obj/item/storage/backpack/duffelbag/sec
	name = "security duffel bag"
	desc = "A large duffel bag for holding extra security supplies and ammunition."
	icon_state = "duffel-sec"
	item_state = "duffel-sec"

/obj/item/storage/backpack/duffelbag/sec/surgery
	name = "surgical duffel bag"
	desc = "A large duffel bag for holding extra supplies - this one has a material inlay with space for various sharp-looking tools."

/obj/item/storage/backpack/duffelbag/sec/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/mask/surgical(src)
	new /obj/item/reagent_containers/medspray/sterilizine(src)

/obj/item/storage/backpack/duffelbag/engineering
	name = "industrial duffel bag"
	desc = "A large duffel bag for holding extra tools and supplies."
	icon_state = "duffel-eng"
	item_state = "duffel-eng"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/duffelbag/durathread
	name = "durathread duffel bag"
	desc = "A lightweight duffel bag made out of durathread."
	icon_state = "duffel-durathread"
	item_state = "duffel-durathread"
	resistance_flags = FIRE_PROOF
	slowdown = 0

/obj/item/storage/backpack/duffelbag/drone
	name = "drone duffel bag"
	desc = "A large duffel bag for holding tools and hats."
	icon_state = "duffel-drone"
	item_state = "duffel-drone"
	resistance_flags = FIRE_PROOF
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/storage/backpack/duffelbag/drone/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil/random(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/backpack/duffelbag/syndie
	name = "suspicious looking duffel bag"
	desc = "A large duffel bag for holding extra tactical supplies."
	icon_state = "duffel-syndie"
	item_state = "duffel-syndieammo"
	slowdown = 0
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE
	component_type = /datum/component/storage/concrete/backpack/duffelbag/syndie

/obj/item/storage/backpack/duffelbag/syndie/hitman
	desc = "A large duffel bag for holding extra things. There is a US Government logo on the back."
	icon_state = "duffel-syndieammo"
	item_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/hitman/PopulateContents()
	new /obj/item/clothing/under/suit/black(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/suit/toggle/lawyer/black(src)
	new /obj/item/clothing/shoes/laceup(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/clothing/glasses/sunglasses(src)
	new /obj/item/clothing/head/fedora(src)

/obj/item/storage/backpack/duffelbag/syndie/med
	name = "medical duffel bag"
	desc = "A large duffel bag for holding extra tactical medical supplies."
	icon_state = "duffel-syndiemed"
	item_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery
	name = "surgery duffel bag"
	desc = "A suspicious looking duffel bag for holding surgery tools."
	icon_state = "duffel-syndiemed"
	item_state = "duffel-syndiemed"

/obj/item/storage/backpack/duffelbag/syndie/surgery/PopulateContents()
	new /obj/item/scalpel(src)
	new /obj/item/hemostat(src)
	new /obj/item/retractor(src)
	new /obj/item/circular_saw(src)
	new /obj/item/surgicaldrill(src)
	new /obj/item/cautery(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/mmi/syndie(src)
	new /obj/item/implantcase(src)
	new /obj/item/implanter(src)
	new /obj/item/reagent_containers/medspray/sterilizine(src)

/obj/item/storage/backpack/duffelbag/syndie/surgery_adv
	name = "advanced surgery duffel bag"
	desc = "A large duffel bag for holding surgical tools. Bears the logo of an advanced med-tech firm."

/obj/item/storage/backpack/duffelbag/syndie/surgery_adv/PopulateContents()
	new /obj/item/scalpel/advanced(src)
	new /obj/item/retractor/advanced(src)
	new /obj/item/surgicaldrill/advanced(src)
	new /obj/item/bonesetter(src)
	new /obj/item/surgical_drapes(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/clothing/mask/muzzle(src)
	new /obj/item/mmi/syndie(src)
	new /obj/item/implantcase(src)
	new /obj/item/implanter(src)
	new /obj/item/reagent_containers/medspray/sterilizine(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo
	name = "ammunition duffel bag"
	desc = "A large duffel bag for holding extra weapons ammunition and supplies."
	icon_state = "duffel-syndieammo"
	item_state = "duffel-syndieammo"

/obj/item/storage/backpack/duffelbag/syndie/ammo/shotgun
	desc = "A large duffel bag, packed to the brim with Bulldog shotgun drum magazines."

/obj/item/storage/backpack/duffelbag/syndie/ammo/shotgun/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/ammo_box/magazine/m12g(src)
	new /obj/item/ammo_box/magazine/m12g/stun(src)
	new /obj/item/ammo_box/magazine/m12g/slug(src)
	new /obj/item/ammo_box/magazine/m12g/dragon(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/smg
	desc = "A large duffel bag, packed to the brim with C-20r magazines."

/obj/item/storage/backpack/duffelbag/syndie/ammo/smg/PopulateContents()
	for(var/i in 1 to 9)
		new /obj/item/ammo_box/magazine/tommygunm45/empty(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/dark_gygax
	desc = "A large duffel bag, packed to the brim with various exosuit ammo."

/obj/item/storage/backpack/duffelbag/syndie/ammo/dark_gygax/PopulateContents()
	new /obj/item/mecha_ammo/incendiary(src)
	new /obj/item/mecha_ammo/incendiary(src)
	new /obj/item/mecha_ammo/incendiary(src)
	new /obj/item/mecha_ammo/flashbang(src)
	new /obj/item/mecha_ammo/flashbang(src)
	new /obj/item/mecha_ammo/flashbang(src)

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	desc = "A large duffel bag, packed to the brim with various exosuit ammo."

/obj/item/storage/backpack/duffelbag/syndie/ammo/mauler/PopulateContents()
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/lmg(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/scattershot(src)
	new /obj/item/mecha_ammo/missiles_he(src)
	new /obj/item/mecha_ammo/missiles_he(src)
	new /obj/item/mecha_ammo/missiles_he(src)

/obj/item/storage/backpack/duffelbag/syndie/c20rbundle
	desc = "A large duffel bag containing a C-20r, some magazines, and a cheap looking suppressor."

/obj/item/storage/backpack/duffelbag/syndie/c20rbundle/PopulateContents()
	new /obj/item/ammo_box/magazine/tommygunm45/empty(src)

/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle
	desc = "A large duffel bag containing a Bulldog, some drums, and a pair of thermal imaging glasses."

/obj/item/storage/backpack/duffelbag/syndie/bulldogbundle/PopulateContents()
	new /obj/item/ammo_box/magazine/tommygunm45/empty(src)

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	desc = "A large duffel bag containing a tactical medkit, a Donksoft machine gun, a big jumbo box of riot darts, and a knock-off pair of magboots."

/obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle/PopulateContents()
	new /obj/item/clothing/shoes/magboots/syndie(src)
	new /obj/item/ammo_box/foambox/riot(src)

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle
	desc = "A large duffel bag containing deadly chemicals, a handheld chem sprayer, Bioterror foam grenade, a Donksoft assault rifle, box of riot grade darts, a dart pistol, and a box of syringes."

/obj/item/storage/backpack/duffelbag/syndie/med/bioterrorbundle/PopulateContents()
	new /obj/item/storage/box/syndie_kit/chemical(src)
	new /obj/item/gun/syringe/syndicate(src)
	new /obj/item/storage/box/syringes(src)
	new /obj/item/ammo_box/foambox/riot(src)
	if(prob(5))
		new /obj/item/reagent_containers/food/snacks/pizza/pineapple(src)

/obj/item/storage/backpack/duffelbag/syndie/c4/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/grenade/plastic/c4(src)

/obj/item/storage/backpack/duffelbag/syndie/x4/PopulateContents()
	for(var/i in 1 to 3)
		new /obj/item/grenade/plastic/x4(src)

/obj/item/storage/backpack/duffelbag/syndie/firestarter
	desc = "A large duffel bag containing a New Russian pyro backpack sprayer, Elite hardsuit, a Stechkin APS pistol, minibomb, ammo, and other equipment."

/obj/item/storage/backpack/duffelbag/syndie/firestarter/PopulateContents()
	new /obj/item/watertank/op(src)
	new /obj/item/scalpel(src)
	new /obj/item/reagent_containers/food/drinks/bottle/vodka/badminka(src)
	new /obj/item/reagent_containers/pill/patch/medx(src)
	new /obj/item/grenade/syndieminibomb(src)

/obj/item/storage/backpack/duffelbag/syndie/shredderbundle
	desc = "A large duffel bag containing two CX Shredders, some magazines, an elite hardsuit, and a chest rig."

/obj/item/storage/backpack/duffelbag/syndie/shredderbundle/PopulateContents()
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/suit/space/hardsuit/syndi/elite(src)

///FO13 Edit
/obj/item/storage/backpack/trekker
	name = "trekkers pack"
	desc = "A light and durable pack often seen in use by those prone to wandering the wastes, often alone."
	icon_state = "trekkerpack"
	item_state = "trekkerpack"

/obj/item/storage/backpack/satchel/trekker
	name = "trekkers satchel"
	desc = "A light and durable satchel often seen in use by those prone to wandering the wastes, often alone."
	icon_state = "satchel-trekker"
	item_state = "satchel-trekker"

/obj/item/storage/backpack/trekker/marinepack
	name = "UNMC Standard issue backpack"
	desc = "A standard issued lightweight UNMC backpack. Used in pre-war times, it know finds use by those who equip it. Quite streamline looking too."
	icon_state = "marinepack"
	item_state = "marinepack"
	icon = 'icons/fallout/clothing/belts.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_bags.dmi'

/obj/item/storage/backpack/satchel/old
	name = "old satchel"
	desc = "The leather is stiff and cracking, but the satchel still works."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	lefthand_file = 'icons/fallout/onmob/items/bags_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/items/bags_righthand.dmi'
	icon_state = "satchel_old"
	item_state = "satchel_old"

/obj/item/storage/backpack/enclave
	name = "service backpack"
	desc = "Backpack copying an old US Army pattern."
	icon_state = "backpack_enclave"
	item_state = "backpack_enclave"

/obj/item/storage/backpack/satchel/enclave
	name = "service satchel"
	desc = "Satchel modeled after old US Army pattern."
	icon_state = "satchel_enclave"
	item_state = "satchel_enclave"

/obj/item/storage/backpack/legionr
	name = "Larper 'red' flag"
	desc = "A larper cape made from what looks like red piece of cloth, with a golden baby cow on the back. With a lot of pockets underneath"
	icon_state = "legioncaper"
	item_state = "legioncaper"

/obj/item/storage/backpack/legionb
	name = "Larper purple flag"
	desc = "Lee-gion brand cape made from what looks like pinkish dark blue piece of cluth, with a golden bull cucking a sheep on the back. With a lot of pockets underneath"
	icon_state = "legioncapeb"
	item_state = "legioncapeb"

/obj/item/storage/backpack/satchel/snailshell
	name = "Snail shell"
	desc = "A hard brown spiral of a shell that fits well on a back. You can somehow store items in it..huh! Snailtastic."
	icon_state = "snailshell"
	item_state = "snailshell"

//Backpacks from Skyrat
/obj/item/storage/backpack/skyrat/ertodst
	name = "black ert bag"
	desc = "A black bag, snazzy"
	icon_state = "ert_odst"
	item_state = "ert_odst"

/obj/item/storage/backpack/skyrat/robobackpack
	name = "robotics backpack"
	desc = "A black bag with red and white accents"
	icon_state = "backpack_robo"
	item_state = "backpack_robo"

/obj/item/storage/backpack/satchel/skyrat/robosatchel
	name = "robotics satchel"
	desc = "A black bag with red and white accents"
	icon_state = "satchel_robo"
	item_state = "satchel_robo"

/obj/item/storage/backpack/duffelbag/skyrat/roboduffel
	name = "robotics duffle"
	desc = "A black bag with red and white accents"
	icon_state = "duffel_robo"
	item_state = "duffel_robo"

/obj/item/storage/backpack/skyrat/robomessanger
	name = "robotics messanger"
	desc = "A black bag with red and white accents"
	icon_state = "messenger_robo"
	item_state = "messenger_robo"

/obj/item/storage/backpack/skyrat/hopbackpack
	name = "blue backpack"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "backpack_hop"
	item_state = "backpack_hop"

/obj/item/storage/backpack/satchel/skyrat/hopsatchel
	name = "blue satchel"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "satchel_hop"
	item_state = "satchel_hop"

/obj/item/storage/backpack/duffelbag/skyrat/hopduffel
	name = "blue duffel"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "duffel_hop"
	item_state = "duffel_hop"

/obj/item/storage/backpack/skyrat/hopmessanger
	name = "blue messenger"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "messenger_hop"
	item_state = "messenger_hop"

/obj/item/storage/backpack/skyrat/securitybackpack
	name = "security backpack"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "backpack_security_black"
	item_state = "backpack_security_black"

/obj/item/storage/backpack/satchel/skyrat/securitysatchel
	name = "security satchel"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "satchel_security_black"
	item_state = "satchel_security_black"

/obj/item/storage/backpack/duffelbag/skyrat/securityduffel
	name = "security duffel"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "duffel_security_black"
	item_state = "duffel_security_black"

/obj/item/storage/backpack/skyrat/securitymessenger
	name = "security messenger"
	desc = "A navy blue bag with white accents and a red strap."
	icon_state = "messenger_security_black"
	item_state = "messenger_security_black"

/obj/item/storage/backpack/skyrat/medicalbackpack
	name = "medical backpack"
	desc = "A white bag with navy accents and a light blue strap"
	icon_state = "backpack_security_white"
	item_state = "backpack_security_white"

/obj/item/storage/backpack/satchel/skyrat/medicalsatchel
	name = "medical satchel"
	desc = "A white bag with navy accents and a light blue strap"
	icon_state = "satchel_security_white"
	item_state = "satchel_security_white"

/obj/item/storage/backpack/duffelbag/skyrat/medicalduffel
	name = "medical duffel"
	desc = "A white bag with navy accents and a light blue strap"
	icon_state = "duffel_security_white"
	item_state = "duffel_security_white"

/obj/item/storage/backpack/skyrat/medicalmessenger
	name = "medical messenger"
	desc = "A white bag with navy accents and a light blue strap"
	icon_state = "messenger_security_white"
	item_state = "messenger_security_white"

/obj/item/storage/backpack/skyrat/blueshieldbackpack
	name = "blueshield backpack"
	desc = "A black bag with dark blue accents"
	icon_state = "backpack_blueshield"
	item_state = "backpack_blueshield"

/obj/item/storage/backpack/satchel/skyrat/blueshieldsatchel
	name = "blueshield satchel"
	desc = "A black bag with dark blue accents"
	icon_state = "satchel_blueshield"
	item_state = "satchel_blueshield"

/obj/item/storage/backpack/duffelbag/skyrat/blueshieldduffel
	name = "blueshield duffel"
	desc = "A black bag with dark blue accents"
	icon_state = "duffel_blueshield"
	item_state = "duffel_blueshield"

/obj/item/storage/backpack/skyrat/blueshieldmessanger
	name = "blueshield messanger"
	desc = "A black bag with dark blue accents"
	icon_state = "messsanger_blueshield"
	item_state = "messanger_blueshield"

/obj/item/storage/backpack/duffelbag/skyrat/carrybackpackgreen
	name = "bulky green bag"
	desc = "A big and bulky bag"
	icon_state = "russian_green_backpack"
	item_state = "russian_green_backpack"

/obj/item/storage/backpack/duffelbag/skyrat/carrybackpackblack
	name = "bulky black bag"
	desc = "A big and buklky bag"
	icon_state = "russian_black_backpack"
	item_state = "russian_black_backpack"

/obj/item/storage/backpack/duffelbag/skyrat/carrybackpackwhite
	name = "bulky white bag"
	desc = "A big and buklky bag"
	icon_state = "russian_white_backpack"
	item_state = "russian_white_backpack"

/obj/item/storage/backpack/duffelbag/skyrat/carrybackpackbrown
	name = "bulky brown bag"
	desc = "A big and buklky bag"
	icon_state = "russian_brown_backpack"
	item_state = "russian_brown_backpack"

/obj/item/storage/backpack/skyrat/messangerblack
	name = "black messanger bag"
	desc = "A black messanger bag"
	icon_state = "messenger"
	item_state = "messenger"

/obj/item/storage/backpack/skyrat/messangercaptain
	name = "dark blue messanger bag"
	desc = "A dark blue messanger bag"
	icon_state = "messenger_captain"
	item_state = "messenger_captain"

/obj/item/storage/backpack/skyrat/messangerscience
	name = "purple accented messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_science"
	item_state = "messenger_science"

/obj/item/storage/backpack/skyrat/messangergenetics
	name = "blue accented messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_genetics"
	item_state = "messenger_genetics"

/obj/item/storage/backpack/skyrat/messangerengineering
	name = "brown and orange messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_engineering"
	item_state = "messenger_engineering"

/obj/item/storage/backpack/skyrat/messangerexplorer
	name = "brown and blue messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_explorer"
	item_state = "messenger_explorer"

/obj/item/storage/backpack/skyrat/messengerhydroponics
	name = "green and blue messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_hydroponics"
	item_state = "messenger_hydroponics"

/obj/item/storage/backpack/skyrat/messengerclown
	name = "green messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_clown"
	item_state = "messenger_clown"

/obj/item/storage/backpack/skyrat/messengermedical
	name = "medical messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_medical"
	item_state = "messenger_medical"

/obj/item/storage/backpack/skyrat/messengerchemistry
	name = "chemistry messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_chemistry"
	item_state = "messenger_chemistry"

/obj/item/storage/backpack/skyrat/messengervirology
	name = "virology messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_virology"
	item_state = "messenger_virology"

/obj/item/storage/backpack/skyrat/messengercoroner
	name = "coroner messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_coroner"
	item_state = "messenger_coroner"

/obj/item/storage/backpack/skyrat/messengercoroner
	name = "coroner messanger bag"
	desc = "A messanger bag"
	icon_state = "messenger_coroner"
	item_state = "messenger_coroner"

/obj/item/storage/backpack/skyrat/coneshell
	name = "coneshell bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "coneshell"
	item_state = "coneshell"

/obj/item/storage/backpack/skyrat/cinnamonshell
	name = "cinnamonshell bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "cinnamonshell"
	item_state = "cinnamonshell"

/obj/item/storage/backpack/skyrat/caramelshell
	name = "caramel shell bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "caramelshell"
	item_state = "caramelshell"

/obj/item/storage/backpack/skyrat/pyramidshellwhite
	name = "pyramidshell white snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "pyramidshellwhite"
	item_state = "pyramidshellwhite"

/obj/item/storage/backpack/skyrat/spiralshellwhite
	name = "spiralshell white snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "spiralshellwhite"
	item_state = "spiralshellwhite"

/obj/item/storage/backpack/skyrat/rockshellwhite
	name = "rockshell white snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "rockshellwhite"
	item_state = "rockshellwhite"

/obj/item/storage/backpack/skyrat/mechashell
	name = "mechashell snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "mechashell"
	item_state = "mechashell"

/obj/item/storage/backpack/skyrat/mechashell
	name = "mechashell snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "mechashell"
	item_state = "mechashell"

/obj/item/storage/backpack/skyrat/pyramidshell
	name = "pyramidshell snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "pyramidshell"
	item_state = "pyramidshell"

/obj/item/storage/backpack/skyrat/spiralshell
	name = "spiralshell snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "spiralshell"
	item_state = "spiralshell"

/obj/item/storage/backpack/skyrat/rockshell
	name = "rockshell snail bag"
	desc = "A snail shell that somehow can store things! Don't question it."
	icon_state = "rockshell"
	item_state = "rockshell"

/obj/item/storage/backpack/invisipack // backpack with no mob sprite
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "invisipack"
	item_state = "invisipack"

/obj/item/storage/backpack/purse 
	icon = 'icons/fallout/objects/storage.dmi'
	desc = "A stylish handbag, not really recolorable!"
	lefthand_file = 'icons/fallout/onmob/items/bags_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/items/bags_righthand.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/backslot_bags.dmi'
	icon_state = "purse"
	item_state = "purse"

/obj/item/storage/backpack/purse/black
	color = "#333333"

/obj/item/storage/backpack/purse/red
	color = "#bb3333"

/obj/item/storage/backpack/purse/green
	color = "#33bb33"

/obj/item/storage/backpack/purse/blue
	color = "#3333bb"

/obj/item/storage/backpack/purse/yellow
	color = "#bbbb33"

/obj/item/storage/backpack/purse/cyan
	color = "#33bbbb"

/obj/item/storage/backpack/purse/purple
	color = "#bb33bb"
