//Faction datums of sorts, use the dang hierarchies in the future
//It looks like var/faction controls what becomes visible on setup. Should likely be fixed or something, but I'm not doing it.
/datum/job/CaesarsLegion
	department_flag = LEGION
	selection_color = "#ffeeee"

	forbids = "The Legion forbids: Ghouls joining the Legion. Women in armed roles. Chems and drugs such as jet or alcohol. Reliance on technology. Lethally harming any servants of Caesar without proper reason."
	enforces = "The Legion expects: Obeying orders of superiors. A roman style name. Wearing the uniform, unless acting as a nonlethal infiltrator."
	objectivesList = list("Leadership recommends the following goal for this week: Establish an outpost at the radio tower","Leadership recommends the following goal for this week: Establish patrols and fortifications around the main road", "Leadership recommends the following goal for this week: Acquire and train slaves")

/datum/outfit/job/CaesarsLegion
	id = null
	ears = null
	box = null

/datum/outfit/job/CaesarsLegion/Legionnaire
	belt = 			/obj/item/storage/belt/military/assault/legion
	backpack = 		/obj/item/storage/backpack/explorer
	satchel = 		/obj/item/storage/backpack/satchel/explorer
	uniform = 		/obj/item/clothing/under/f13/legskirt
	shoes = 		/obj/item/clothing/shoes/f13/military/plated
	gloves =		/obj/item/clothing/gloves/legion
	box = 			/obj/item/storage/survivalkit_tribal

/datum/outfit/job/CaesarsLegion/Legionnaire/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(H.gender == FEMALE)
		H.gender = MALE
		H.real_name = random_unique_name(MALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()
	if(H.real_name == ("Biggus Dickus" || "Bigus Dickus"))
		H.real_name = "Minimae Coles"
		H.name = "Minimae Coles"
//		H.lust_tolerance = 0
//		H.sexual_potency = 0
//		H.lust = 0

/*
Legate

Needs whitelist
*/
/datum/job/CaesarsLegion/Legionnaire/f13legate
	title = "Legate"
//	faction = "Legion"
	flag = F13LEGATE
	head_announce = list("Security")
	supervisors = "Caesar"
	selection_color = "#ffdddd"
	req_admin_notify = 1
	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13legate

	access = list()
	minimal_access = list()


/datum/outfit/job/CaesarsLegion/Legionnaire/f13legate/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legate
	name = "Legate"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13legate
	shoes = 		/obj/item/clothing/shoes/f13/military/legate
	suit = 			/obj/item/clothing/suit/armor/f13/legion/legate
	head = 			/obj/item/clothing/head/helmet/f13/legion/legate
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears =			/obj/item/radio/headset/headset_legion
	suit_store = 	/obj/item/gun/ballistic/automatic/marksman
	l_pocket = 		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=2,
		/obj/item/melee/powerfist=1,
		/obj/item/ammo_box/magazine/m556/rifle=2,
		/obj/item/reagent_containers/pill/patch/healpoultice=2,
		/obj/item/storage/bag/money/small/legion=1)

/*
Centurion
*/
/datum/job/CaesarsLegion/Legionnaire/f13centurion
	title = "Legion Centurion"
	flag = F13CENTURION
	faction = "Legion"
	head_announce = list("Security")
	total_positions = 1
	spawn_positions = 1
	description = "You are the commander of the Centuria and are the direct superior to the Decanii, working with them and your soldiers to establish a strong foothold within the region for Caesar's glory. You oversee all Legion operations in the area, and lead the charge against Caesar's foes."
	supervisors = "the Legate"
	selection_color = "#ffdddd"
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_CENTURION
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion

	loadout_options = list(
	/datum/outfit/loadout/centheavy, //10mm SMG and powerfist
	/datum/outfit/loadout/centassault, //9mm uzi and thermic lance
	/datum/outfit/loadout/centbreacher //breacher shotgun and fire axe
	)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13centurion
	name = "Legion Centurion"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13centurion
	id =			/obj/item/card/id/dogtag/legcenturion
	mask =			/obj/item/clothing/mask/bandana/legcenturion
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	r_pocket =      /obj/item/restraints/handcuffs
	l_pocket = 		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/melee/powerfist/goliath=1,
		/obj/item/key/scollar=1,
		/obj/item/key/bcollar=1,
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/electropack/shockcollar=1,
		/obj/item/electropack/shockcollar/explosive=2,
		/obj/item/storage/bag/money/small/legofficers=1)

/datum/outfit/loadout/centheavy
	name = "Paladin-Slayer Centurion"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/palacent
	head = 			/obj/item/clothing/head/helmet/f13/legion/palacent
	suit_store = /obj/item/gun/energy/laser/aer9
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/mfc=2,
		/obj/item/gun/energy/laser/plasma/glock=1,
		/obj/item/stock_parts/cell/ammo/ec=2)

/datum/outfit/loadout/centassault
	name = "Ranger-Hunter Centurion"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/rangercent
	head = 			/obj/item/clothing/head/helmet/f13/legion/rangercent
	suit_store = /obj/item/gun/ballistic/shotgun/antimateriel
	backpack_contents = list(
		/obj/item/ammo_box/a50MG=2,	
		/obj/item/gun/ballistic/automatic/pistol/deagle=1,
		/obj/item/ammo_box/magazine/m44=1
	)
/datum/outfit/loadout/centbreacher
	name = "Standard Centurion"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/centurion
	head = 			/obj/item/clothing/head/helmet/f13/legion/centurion
	suit_store = /obj/item/gun/ballistic/automatic/m1919
	backpack_contents = list(
		/obj/item/ammo_box/magazine/mm762=2,
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1,
		/obj/item/ammo_box/magazine/m9mm=3)

/*
Orator
*/

/datum/job/CaesarsLegion/Legionnaire/f13orator
	title = "Legion Orator"
	flag = F13ORATOR
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You are the the resonator of Caesar's better wills; a Legionnaire who has, perhaps through injury or advanced age, proven himself unable to fight effectively any longer. Instead of facing \"retirement\" in the Legion, one of your superiors took note of your studies and way with words, and you have been made the face and voice of the Conturbernae."
	supervisors = "the Centurion"
	display_order = JOB_DISPLAY_ORDER_ORATOR
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13orator

/datum/outfit/job/CaesarsLegion/Legionnaire/f13orator
	name = "Legion Orator"
	suit = 	/obj/item/clothing/suit/armor/f13/legion/vet/orator
	ears =	/obj/item/radio/headset/headset_legion
	id = /obj/item/card/id/dogtag/legorator
	belt = /obj/item/claymore/machete/gladius
	suit_store = /obj/item/gun/ballistic/automatic/pistol/type17
	l_pocket = 		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/ammo_box/magazine/m9mm=3,
		/obj/item/storage/box/ids/follower=1,
		/obj/item/storage/bag/money/small/legion=1)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13orator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
/*
Priestess of Mars
*/

/datum/job/CaesarsLegion/f13priestess
	title = "Priestess of Mars"
	flag = F13PRIESTESS
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You are a spiritual and logistics advisor for the Legion forces in the area. Being raised in and from the homeland, you have fully adapted to the Legion's ideals and fully committed yourself to the role as mother and caretaker of the Legion's future. You are an icon to be respected, even by fellow Legion; and although a woman, your status does not allow you to be belittled."
	supervisors = "the Centurion, Mars"
	display_order = JOB_DISPLAY_ORDER_PRIESTESS
	outfit = /datum/outfit/job/CaesarsLegion/f13priestess

/datum/outfit/job/CaesarsLegion/f13priestess
	name = "Priestess of Mars"
	uniform = /obj/item/clothing/under/f13/priestess
	glasses = /obj/item/clothing/glasses/sunglasses/fakeblindfold
	head	= /obj/item/clothing/head/helmet/f13/legion/marsheaddress
	ears	= /obj/item/radio/headset/headset_legion
	gloves	= /obj/item/clothing/gloves/fingerless
	jobtype = /datum/job/CaesarsLegion/f13priestess
	id = /obj/item/card/id/dogtag/legpriest
	r_hand = /obj/item/twohanded/sledgehammer/marsstaff
	shoes = /obj/item/clothing/shoes/roman
	l_pocket = 		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice=2,
		/obj/item/clothing/under/f13/pmarsrobe=1)

/datum/outfit/job/CaesarsLegion/f13priestess/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	if(H.gender == MALE)
		H.gender = FEMALE
		H.real_name = random_unique_name(MALE)
		H.name = H.real_name
		if(H.wear_id)
			var/obj/item/card/id/dogtag/L = H.wear_id
			L.registered_name = H.name
			L.update_label()
	ADD_TRAIT(H, TRAIT_SPIRITUAL, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/* Decanus
/datum/job/CaesarsLegion/Legionnaire/f13decan
	title = "Legion Decanus"
	flag = F13DECAN
	faction = "Legion"
	total_positions = 3
	spawn_positions = 3
	description = "You answer directly to the Centurion, working with them to organize the Legionaries. You lead the Legionaries, and Vexillari on patrols, raids and scouting missions on behalf of your Centurion."
	supervisors = "the Centurion and up"

	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decan

	loadout_options = list(
	/datum/outfit/loadout/decancharger, //greasegun and bumper sword
	/datum/outfit/loadout/decanspec, //nerfed infiltrator and machete gladius
	/datum/outfit/loadout/decanprotec //lever-action shotgun, roman shield and ballistic fist
	)

/datum/job/CaesarsLegion/Legionnaire/f13decan/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")
	H.add_quirk("Big Leagues")
	H.add_quirk("Iron Fist")

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decan
	name = "Legion Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decan
	id = 			/obj/item/card/id/dogtag/legveteran
	mask =			/obj/item/clothing/mask/bandana/legdecan
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1, \
		/obj/item/throwing_star/spear, \
		/obj/item/reagent_containers/pill/patch/healingpowder=2, \
		/obj/item/storage/box/handcuffs=1, \
		/obj/item/flashlight/lantern=1, \
		/obj/item/key/scollar=1, \
		/obj/item/electropack/shockcollar=1, \
		/obj/item/storage/bag/money/small/legofficers)

/datum/outfit/loadout/decancharger
	name = "Recruit Decanus"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/vet
	head = 			/obj/item/clothing/head/helmet/f13/legion/recruit/decan
	suit_store = /obj/item/gun/ballistic/automatic/greasegun
	backpack_contents = list(
		/obj/item/twohanded/fireaxe/bmprsword=1,
		/obj/item/ammo_box/magazine/greasegun=1)

/datum/outfit/loadout/decanspec
	name = "Prime Decanus"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/vet
	head = 			/obj/item/clothing/head/helmet/f13/legion/prime/decan
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator=1,
		/obj/item/ammo_box/magazine/m556/rifle=1,
		/obj/item/claymore/machete/gladius=1
		)

/datum/outfit/loadout/decanprotec
	name = "Veteran Decanus"
	suit = 			/obj/item/clothing/suit/armor/f13/legion/heavy
	head = 			/obj/item/clothing/head/helmet/f13/legion/heavy
	suit_store = 	/obj/item/gun/ballistic/revolver/ballisticfist
	backpack_contents = list(
		/obj/item/storage/fancy/ammobox/lethalshot=1,
		/obj/item/storage/fancy/ammobox/slugshot=1,
		/obj/item/shield/riot/roman=1)

*/

/*
Decanii
*/


//Veteran Decanus
/datum/job/CaesarsLegion/Legionnaire/f13decanvet
	title = "Legion Veteran Decanus"
	flag = F13DECANVET
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Centurion, working with them to organize the Legionaries. You lead the Veteran Legionaries on patrols, raids and scouting missions on behalf of your Centurion."
	supervisors = "the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECANVET
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanvet
	name = "Legion Veteran Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decanvet
	id = 			/obj/item/card/id/dogtag/legveteran
	suit = 			/obj/item/clothing/suit/armor/f13/legion/heavy
	head = 			/obj/item/clothing/head/helmet/f13/legion/heavy
	mask =			/obj/item/clothing/mask/bandana/legdecan
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	suit_store = 	/obj/item/gun/ballistic/automatic/service/r82
	r_pocket =		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=3,
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/restraints/handcuffs=2,
		/obj/item/binoculars=1,
		/obj/item/claymore/machete/gladius=1,
		/obj/item/key/scollar=1,
		/obj/item/electropack/shockcollar=1,
		/obj/item/storage/bag/money/small/legofficers=1)


//Prime Decanus
/datum/job/CaesarsLegion/Legionnaire/f13decan
	title = "Legion Prime Decanus"
	flag = F13DECAN
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Centurion, working with them to organize the Legionaries. You lead the Prime Legionaries on patrols, raids and scouting missions on behalf of your Centurion."
	supervisors = "the Veteran Decanus and the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECAN
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decan

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decan/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decan
	name = "Prime Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decan
	id = 			/obj/item/card/id/dogtag/legveteran
	suit =			/obj/item/clothing/suit/armor/f13/legion/vet
	head =			/obj/item/clothing/head/helmet/f13/legion/prime/decan
	mask =			/obj/item/clothing/mask/bandana/legdecan
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	suit_store =	/obj/item/gun/ballistic/automatic/m1garand
	r_pocket =		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308=3,
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/gun/ballistic/automatic/pistol/m1911=1,
		/obj/item/ammo_box/magazine/m45=3,
		/obj/item/claymore/machete/gladius=1,
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/restraints/handcuffs=2,
		/obj/item/key/scollar=1,
		/obj/item/electropack/shockcollar=1,
		/obj/item/storage/bag/money/small/legofficers=1)


//Recruit Decanus
/datum/job/CaesarsLegion/Legionnaire/f13decanrec
	title = "Legion Recruit Decanus"
	flag = F13DECANREC
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Centurion, working with them to organize the Legionaries. You lead the Recruit Legionaries on patrols, raids and scouting missions on behalf of your Centurion."
	supervisors = "the Prime Decanus and the Centurion"
	display_order = JOB_DISPLAY_ORDER_DECANREC
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13decanrec
	name = "Legion Recruit Decanus"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13decanrec
	id = 			/obj/item/card/id/dogtag/legveteran
	suit = 			/obj/item/clothing/suit/armor/f13/legion/vet
	head = 			/obj/item/clothing/head/helmet/f13/legion/recruit/decan
	mask =			/obj/item/clothing/mask/bandana/legdecan
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	suit_store = 	/obj/item/gun/ballistic/automatic/mini_uzi
	r_pocket =		/obj/item/flashlight/lantern
	backpack_contents = list(
		/obj/item/ammo_box/magazine/uzim9mm=3,
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/gun/ballistic/revolver/m29/snub=1,
		/obj/item/ammo_box/m44=2,
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/restraints/handcuffs=2,
		/obj/item/key/scollar=1,
		/obj/item/electropack/shockcollar=1,
		/obj/item/storage/bag/money/small/legofficers=1)


/*
Vexillarius
*/

/datum/job/CaesarsLegion/Legionnaire/f13vexillarius
	title = "Legion Vexillarius"
	flag = F13VEXILLARIUS
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Decani and the Centurion, acting as a standard bearer for your squad. You raise troop morale, relay orders from the Decanii and the Centurion, and rally men when ordered, however, you hold no actual authority over the troops and should instead only relay orders from your superiors."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_VEXILLARIUS
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius
	loadout_options = list(
		/datum/outfit/loadout/vexassault, //ripper, m29scoped
		/datum/outfit/loadout/vexsupport //trail carbine, smoke bombs
		)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vexillarius
	name = "Legion Vexillarius"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13vexillarius
	id = 			/obj/item/card/id/dogtag/legveteran
	mask =			/obj/item/clothing/mask/bandana/legvet
	suit = 			/obj/item/clothing/suit/armor/f13/legion/vet/vexil
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	ears = 			/obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/throwing_star/spear=1,
		/obj/item/claymore/machete/gladius=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/flashlight/lantern=1,
		/obj/item/megaphone/cornu=1,
		/obj/item/storage/bag/money/small/legenlisted=1)

/datum/outfit/loadout/vexassault
	name = "Assault Vexillarius"
	head = 			/obj/item/clothing/head/helmet/f13/legion/vet/combvexil
	suit_store = 	/obj/item/gun/ballistic/revolver/m29
	backpack_contents = list(
		/obj/item/ammo_box/m44=1,
		/obj/item/nullrod/claymore/chainsaw_sword=1
		)

/datum/outfit/loadout/vexsupport
	name = "Support Vexillarius"
	head = 			/obj/item/clothing/head/helmet/f13/legion/vet/vexil
	suit_store = 	/obj/item/gun/ballistic/shotgun/automatic/hunting/trail
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44=1,
		/obj/item/grenade/smokebomb=2,
		/obj/item/grenade/plastic/c4=1
		)
/*
Slavemaster
*/

datum/job/CaesarsLegion/Legionnaire/f13slavemaster
	title = "Legion Slavemaster"
	flag = F13SLAVEMASTER
	faction = "Legion"
	total_positions = 2
	spawn_positions = 2
	description = "You are the feared and respected disciplinary corps of the Legion. Acting as both master of the Slaves and de-facto executioner of the Centurion's will within his ranks, you are a faceless and undoubtedly cruel torturer... but be careful to not let your hubris and malice lead to a strikeback from those you thought broken."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_SLAVEMASTER
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13slavemaster

/datum/outfit/job/CaesarsLegion/Legionnaire/f13slavemaster/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13slavemaster
	name = "Legion Slavemaster"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13slavemaster
	id =			/obj/item/card/id/dogtag/legslavemaster
	uniform =		/obj/item/clothing/under/gladiator
	belt = 			/obj/item/melee/curator_whip
	head = 			/obj/item/clothing/head/helmet/gladiator
	glasses = 		/obj/item/clothing/glasses/sunglasses
	ears	=		/obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/claymore/machete/reinforced=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/flashlight/lantern=1,
		/obj/item/storage/bag/money/small/legenlisted=1)


/*
Veteran Legionary
*/

/datum/job/CaesarsLegion/Legionnaire/f13vetlegionary
	title = "Veteran Legionary"
	flag = F13VETLEGIONARY
	faction = "Legion"
	total_positions = 3
	spawn_positions = 3
	description = "You answer to the Decani and the Centurion. Acting as a loyal soldier of the Centuria, you have the great honour of serving under Caesar in his quest to unite the scattered tribes of The Sonora. You are a hardened warrior, and have been waging war with the Legion for many years."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_VETLEGIONARY
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13vetlegionary

	loadout_options = list(
	/datum/outfit/loadout/vetlegassault, //scoped .44 revolver
	/datum/outfit/loadout/vetlegrange, //marksman rifle
	/datum/outfit/loadout/vetlegclose //lever-action shotgun
	)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vetlegionary/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13vetlegionary
	name = "Veteran Legionary"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13vetlegionary
	id = 			/obj/item/card/id/dogtag/legveteran
	mask =			/obj/item/clothing/mask/bandana/legvet
	head = 			/obj/item/clothing/head/helmet/f13/legion/vet
	suit = 			/obj/item/clothing/suit/armor/f13/legion/vet
	glasses = 		/obj/item/clothing/glasses/sunglasses
	ears	=		/obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/flashlight/lantern=1,
		/obj/item/storage/bag/money/small/legenlisted=1)

/datum/outfit/loadout/vetlegassault
	name = "Assault Legionary"
	suit_store = /obj/item/gun/ballistic/automatic/smg10mm
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/ext=3,
		/obj/item/shield/riot/roman=1)

/datum/outfit/loadout/vetlegrange
	name = "Ranged Legionary"
	suit_store = /obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=3)

/datum/outfit/loadout/vetlegclose
	name = "Protector Legionary"
	suit_store = /obj/item/gun/ballistic/automatic/shotgun/riot
	backpack_contents = list(
		/obj/item/ammo_box/magazine/d12g=2)

/*
Prime Legionairy
*/

/datum/job/CaesarsLegion/Legionnaire/f13legionary
	title = "Prime Legionary"
	flag = F13LEGIONARY
	faction = "Legion"
	total_positions = 3
	spawn_positions = 3
	description = "You answer to the Decani and the Centurion, as well as Veterans above you. Acting as a loyal soldier of the Centuria, you have the great honour of serving under Caesar in his quest to unite the scattered tribes of The Sonora. You have been through enough battles to call yourself a prime, but you are by no means yet a Veteran."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_LEGIONARY
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary

	loadout_options = list(
	/datum/outfit/loadout/legassault, //5.56 pistol, spear quiver
	/datum/outfit/loadout/legline, //Glaive, extended 10mm
	/datum/outfit/loadout/legbreach, //Lever-action shotgun
	/datum/outfit/loadout/legrange //trail carbine
	)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13legionary
	name = "Prime Legionary"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13legionary
	id = 			/obj/item/card/id/dogtag/legprime
	mask =			/obj/item/clothing/mask/bandana/legprime
	head = 			/obj/item/clothing/head/helmet/f13/legion/prime
	suit = 			/obj/item/clothing/suit/armor/f13/legion/prime
	glasses = 		/obj/item/clothing/glasses/sunglasses
	ears	=		/obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/restraints/handcuffs
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/flashlight/flare/torch=1)

/datum/outfit/loadout/legassault
	name = "Foot Legionary"
	suit_store = /obj/item/gun/ballistic/revolver/thatgun
	backpack_contents = list(
		/obj/item/storage/backpack/spearquiver=1,
		/obj/item/claymore/machete/reinforced=1,
		/obj/item/ammo_box/magazine/m556/rifle=2)

/datum/outfit/loadout/legline
	name = "Lineman"
	suit_store = /obj/item/twohanded/spear
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/n99=1,
		/obj/item/ammo_box/magazine/m10mm_adv=2,
		/obj/item/claymore/machete/reinforced=1)

/datum/outfit/loadout/legbreach
	name = "Close Quarters Legionary"
	suit_store = /obj/item/gun/ballistic/shotgun/trench
	backpack_contents = list(
		/obj/item/storage/fancy/ammobox/slugshot=1,
		/obj/item/storage/fancy/ammobox/beanbag=1,
		/obj/item/claymore/machete/gladius=1)

/datum/outfit/loadout/legrange
	name = "Ranged Legionary"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail/scoped
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44=2,
		/obj/item/ammo_box/m44box=1,
		/obj/item/claymore/machete/reinforced=1)
/*
Recruit Legionary
*/

/datum/job/CaesarsLegion/Legionnaire/f13recleg
	title = "Recruit Legionary"
	flag = F13RECRUITLEG
	faction = "Legion"
	total_positions = 3
	spawn_positions = 3
	description = "You have recently come of age or been inducted into Caesar's Legion. You have absolutely no training, and are expected to follow every whim of the Decanii and your Centurion."
	supervisors = "the Decani and Centurion"
	exp_requirements = 12
	exp_type = EXP_TYPE_LEGION
	display_order = JOB_DISPLAY_ORDER_RECRUITLEG
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg

/datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13recleg
	name = "Recruit Legionary"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13recleg
	id = 			/obj/item/card/id/dogtag/legrecruit
	shoes = 		/obj/item/clothing/shoes/f13/military/leather
	suit = 			/obj/item/clothing/suit/armor/f13/legion/recruit
	head = 			/obj/item/clothing/head/helmet/f13/legion/recruit
	mask =			/obj/item/clothing/mask/bandana/legrecruit
	glasses = 		/obj/item/clothing/glasses/legiongoggles
	ears	=		/obj/item/radio/headset/headset_legion
	r_pocket =      /obj/item/restraints/handcuffs
	suit_store =	/obj/item/gun/ballistic/revolver/colt357
	backpack_contents = list(
		/obj/item/kitchen/knife/butcher=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/flashlight/flare/torch=1,
		/obj/item/restraints/handcuffs=1)

/*
Venator
*/
/datum/job/CaesarsLegion/Legionnaire/f13venator
	title = "Legion Venator"
	flag = F13VENATOR
	faction = "Legion"
	total_positions = 1
	spawn_positions = 1
	description = "You are the Venator -- the Hunter. With your powerful rifle and your many years of experience, you are a formidable killing machine, capable of taking down even the most formidable targets. Note that you are not a rank-and-file legionary, and you should not be operating as such -- your job is special operations, not fighting alongside the hordes of the Legion."
	supervisors = "the Centurion"
	selection_color = "#ffdddd"
	display_order = JOB_DISPLAY_ORDER_VENATOR
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13venator

	loadout_options = list(
	/datum/outfit/loadout/vensniper, //.308 sniper and gladius
	/datum/outfit/loadout/venassault //Bulldog assault shotgun and C4
	)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13venator/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13venator
	name = "Legion Venator"
	jobtype 	= /datum/job/CaesarsLegion/Legionnaire/f13explorer
	id 			= 	/obj/item/card/id/dogtag/legvenator
	suit 		= 	/obj/item/clothing/suit/armor/f13/legion/venator
	head 		= 	/obj/item/clothing/head/helmet/f13/legion/venator
	mask		=	/obj/item/clothing/mask/bandana/black
	glasses 	=	/obj/item/clothing/glasses/night
	ears		=	/obj/item/radio/headset/headset_legion
	r_pocket 	= 	/obj/item/binoculars
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healpoultice=1,
		/obj/item/storage/bag/money/small/legenlisted=1)

/datum/outfit/loadout/vensniper
	name = "Venator Assassin"
	suit_store	=	/obj/item/gun/ballistic/automatic/marksman/sniper
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308=2,
		/obj/item/claymore/machete/gladius=1)

/datum/outfit/loadout/venassault
	name = "Venator Assault"
	suit_store	=	/obj/item/gun/ballistic/automatic/shotgun/bulldog
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m12g=2,
		/obj/item/claymore/machete/gladius=1)

/*
Explorer
*/

/datum/job/CaesarsLegion/Legionnaire/f13explorer
	title = "Legion Explorer"
	flag = F13EXPLORER
	faction = "Legion"
	total_positions = 2
	spawn_positions = 2
	description = "Acting as the eyes and ears of the Legion, you are in the region to scout it out for potential conquest. Make note of your surroundings and above all, survive to report back."
	supervisors = "the Venator and Centurion"
	display_order = JOB_DISPLAY_ORDER_EXPLORER
	outfit = /datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer

	loadout_options = list(
	/datum/outfit/loadout/explinfil, //C4, engineering supplies
	/datum/outfit/loadout/explscout //.44 trail carbine
	)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/CaesarsLegion/Legionnaire/f13explorer
	name = "Legion Explorer"
	jobtype = /datum/job/CaesarsLegion/Legionnaire/f13explorer
	id = 		/obj/item/card/id/dogtag/legprime
	suit = 		/obj/item/clothing/suit/armor/f13/legion/vet/explorer
	head = 		/obj/item/clothing/head/helmet/f13/legion/vet/explorer
	glasses = 	/obj/item/clothing/glasses/legiongoggles
	ears	=	/obj/item/radio/headset/headset_legion
	r_pocket = /obj/item/binoculars
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/claymore/machete/reinforced=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/flashlight/flare/torch=1,
		/obj/item/storage/bag/money/small/legenlisted=1)


/datum/outfit/loadout/explinfil
	name = "Infiltrator Explorer"
	suit_store = /obj/item/gun/ballistic/revolver/m29
	backpack_contents = list(
		/obj/item/ammo_box/m44=2,
		/obj/item/grenade/plastic=1,
		/obj/item/storage/belt/utility/full/engi=1,
		/obj/item/clothing/glasses/welding=1)

/datum/outfit/loadout/explscout
	name = "Scout Explorer"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail/scoped
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44=2)

/*
Auxilia
*/
/datum/job/CaesarsLegion/f13auxilia
	title = "Auxilia"
	flag = F13AUXILIA
	faction = "Legion"
	head_announce = list("Security")
	total_positions = 2
	spawn_positions = 2
	description = "You are a respected and valued noncombatant for the Legion, commanding the slaves and Camp Followers and providing important surgical or engineering expertise. Though you hold more authority than the Legionaries in camp, you are not a warrior, and should not act as such unless absolutely necessary."
	supervisors = "the Decani and Centurion"
	display_order = JOB_DISPLAY_ORDER_AUXILIA
	outfit = /datum/outfit/job/CaesarsLegion/f13auxilia

	loadout_options = list(
	/datum/outfit/loadout/auxmedic, //Healing poultices and surgical tools
	/datum/outfit/loadout/auxengi, //Toolbelt, wood, metal, leather
	/datum/outfit/loadout/auxchef, //Flour, rice, bowls, rolling pin, knife and eggs
	/datum/outfit/loadout/auxfarm, //Ambrosia, cultivator, spade, plant bags
	/datum/outfit/loadout/auxassist //Four color pen, briefcase, sunglasses, natural paper
	)

/datum/outfit/job/CaesarsLegion/f13auxilia
	name = "Auxilia"
	jobtype = /datum/job/CaesarsLegion/f13auxilia
	id =			/obj/item/card/id/dogtag/legauxilia
	shoes = 		/obj/item/clothing/shoes/roman
	uniform = 		/obj/item/clothing/under/f13/legskirt
	ears	=		/obj/item/radio/headset/headset_legion
	gloves =		null
	belt =			null
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/flashlight/flare/torch=1,
		/obj/item/storage/bag/money/small/legenlisted=1)

/datum/outfit/loadout/auxmedic
	name = "Medicus Auxilia"
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healpoultice=3,
		/obj/item/scalpel=1,
		/obj/item/hemostat=1,
		/obj/item/retractor=1,
		/obj/item/circular_saw=1,
		/obj/item/cautery=1,
		/obj/item/surgical_drapes=1,
		/obj/item/storage/firstaid/ancient=1)

/datum/outfit/loadout/auxengi
	name = "Opifex Auxilia"
	glasses = /obj/item/clothing/glasses/welding
	belt = /obj/item/storage/belt/utility/full/engi
	suit = /obj/item/clothing/suit/f13/blacksmith_apron
	gloves = /obj/item/clothing/gloves/f13/blacksmith
	backpack_contents = list(
		/obj/item/stack/sheet/metal/twenty=1,
		/obj/item/stack/sheet/mineral/wood/twenty=1,
		/obj/item/stack/sheet/leather/twenty=1,
		/obj/item/stack/sheet/cloth/thirty=1,
		/obj/item/stack/sheet/prewar=1)

/datum/outfit/loadout/auxchef
	name = "Archimagirus Auxilia"
	head = /obj/item/clothing/head/chefhat
	suit = /obj/item/clothing/suit/toggle/chef
	suit_store = /obj/item/kitchen/rollingpin
	belt = /obj/item/kitchen/knife/cosmic
	backpack_contents = list(
		/obj/item/reagent_containers/food/condiment/flour=2,
		/obj/item/reagent_containers/food/condiment/rice=1,
		/obj/item/storage/box/bowls=1,
		/obj/item/reagent_containers/glass/beaker/large=1,
		/obj/item/storage/fancy/egg_box=1)

/datum/outfit/loadout/auxfarm
	name = "Cultor Auxilia"
	head = /obj/item/reagent_containers/food/snacks/grown/ambrosia/deus
	backpack_contents = list(
		/obj/item/cultivator=1,
		/obj/item/shovel/spade=1,
		/obj/item/reagent_containers/glass/beaker/large=1,
		/obj/item/storage/bag/plants=2)

/datum/outfit/loadout/auxassist
	name = "Exceptor Auxilia"
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/storage/briefcase
	backpack_contents = list(
		/obj/item/folder/red=1,
		/obj/item/paper_bin/bundlenatural=1,
		/obj/item/pen/fourcolor=1,
		/obj/item/taperecorder=1)

/*
Camp Follower

/datum/job/CaesarsLegion/f13campfollower
	title = "Camp Follower"
	flag = F13CAMPFOLLOWER
	faction = "Legion"
	total_positions = 4
	spawn_positions = 4
	description = "You answer to any member of the Legion, but take orders directly from the Auxilia around the camp. Working as a Camp Follower for the Centuria, you bear the great honor of supporting Caesar's Army in its conquest of the Mojave in whatever capacity required from those whom you serve. You perform any tasks required of you, for you know how to serve the Legion well."
	supervisors = "the entire legion"
	exp_requirements = 300

	outfit = /datum/outfit/job/CaesarsLegion/f13campfollower

/datum/outfit/job/CaesarsLegion/f13campfollower
	name = "Camp Follower"
	jobtype = /datum/outfit/job/CaesarsLegion/f13campfollower
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/flashlight/flare/torch
	uniform = 		/obj/item/clothing/under/f13/legskirt
	id =			/obj/item/card/id/dogtag/legfollower

/datum/outfit/job/CaesarsLegion/f13campfollower/pre_equip(mob/living/carbon/human/H)
	..()
	var/follower_job = "nothing"
	if (H.gender == MALE)
		uniform = pick(
			/obj/item/clothing/under/f13/caravan, \
			/obj/item/clothing/under/f13/brahminm)
		follower_job = pick("miner", "farmer", "smith", "healer")
	else
		uniform = pick(
			/obj/item/clothing/under/f13/caravan, \
			/obj/item/clothing/under/f13/brahminf)
		follower_job = pick("cook", "farmer", "healer", "caretaker")

	if (follower_job == "cook")
		belt = /obj/item/kitchen/knife
		if (prob(50))
			suit = /obj/item/clothing/suit/apron/chef
	else if (follower_job == "miner")
		belt = /obj/item/storage/bag/ore
		backpack = /obj/item/pickaxe
		l_hand = /obj/item/radio
		if (prob(50))
			suit = /obj/item/clothing/suit/f13/vest
	else if (follower_job == "farmer")
		belt = /obj/item/storage/bag/plants
		l_hand = /obj/item/radio
		if (prob(50))
			suit = /obj/item/clothing/suit/f13/vest
	else if (follower_job == "smith")
		backpack = /obj/item/storage/backpack/satchel/explorer
		backpack_contents = list(/obj/item/radio, /obj/item/screwdriver, /obj/item/wrench, /obj/item/crowbar, /obj/item/wirecutters)
		if (prob(50))
			suit = /obj/item/clothing/suit/f13/vest
	else if (follower_job == "healer")
		backpack = /obj/item/storage/backpack/satchel/explorer
		backpack_contents = list(/obj/item/radio, /obj/item/reagent_containers/pill/patch/healingpowder=4, /obj/item/stack/medical/gauze/improvised = 2)
		if (prob(50))
			suit = /obj/item/clothing/suit/apron/surgical
	else if (follower_job == "caretaker")
		backpack = /obj/item/storage/backpack/satchel/explorer
		backpack_contents = list(/obj/item/radio, /obj/item/soap/homemade, /obj/item/melee/flyswatter, /obj/item/reagent_containers/glass/rag, /obj/item/reagent_containers/glass/bucket, /obj/item/stack/medical/gauze/improvised)
*/

/*
Slave
*/
/datum/job/CaesarsLegion/slave
	title = "Legion Slave"
	flag = F13LEGIONSLAVE
	faction = "Legion"
	total_positions = 4
	spawn_positions = 4
	description = "You answer to any member of the Legion, but take orders directly from the Auxilia around the camp. You are to the point where you have been broken in as a slave and most slaves will no longer consider escaping as an option."
	supervisors = "the entire legion, but mostly the Slavemaster"
	exp_requirements = 12
	exp_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_LEGIONSLAVE
	outfit = /datum/outfit/job/CaesarsLegion/slave

	loadout_options = list(
	/datum/outfit/loadout/slcook, //Apron Chef, Knife, Frying Pan, radio
	/datum/outfit/loadout/slfarmer, //Coveralls, bag plants,radio
	/datum/outfit/loadout/slsmith, //vest, screwdriver, wrench, crowbar wirecutters, radio
	/datum/outfit/loadout/slhealer, //Apron Surgical, Healing powder 4,improvized gauze 2 radio
	/datum/outfit/loadout/slcaretaker, //robe_liz, soap, flyswatter, rag, bucket, gauze, radio
	/datum/outfit/loadout/slminer) //vest, ore bag, pickaxe


/datum/outfit/job/CaesarsLegion/slave
	name		= "Legion Slave"
	jobtype		= /datum/job/CaesarsLegion/slave
	id			= /obj/item/card/id/legionbrand
	uniform		= /obj/item/clothing/under/f13/rag
	neck		= /obj/item/electropack/shockcollar
	shoes		= /obj/item/clothing/shoes/f13/rag
	r_hand = /obj/item/flashlight/flare/torch
	backpack = /obj/item/storage/backpack/satchel/explorer

/datum/outfit/loadout/slcook
	name = "Cook"
	suit = /obj/item/clothing/suit/apron/chef
	belt = /obj/item/kitchen/knife
	backpack_contents = list(
		/obj/item/radio=1,
		/obj/item/claymore/machete/pipe/pan=1)

/datum/outfit/loadout/slfarmer
	name = "Farmer"
	suit = /obj/item/clothing/suit/apron/overalls
	belt = /obj/item/storage/bag/plants
	r_hand = /obj/item/flashlight/flare/torch
	backpack_contents = list(
		/obj/item/radio=1)

/datum/outfit/loadout/slsmith
	name = "Smith"
	suit = /obj/item/clothing/suit/f13/vest
	r_hand = /obj/item/flashlight/flare/torch
	backpack_contents = list(
		/obj/item/radio=1,
		/obj/item/screwdriver=1,
		/obj/item/wrench=1,
		/obj/item/crowbar=1,
		/obj/item/radio=1,
		/obj/item/wirecutters=1)

/datum/outfit/loadout/slhealer
	name = "Cleric"
	suit = /obj/item/clothing/suit/apron/surgical
	r_hand = /obj/item/flashlight/flare/torch
	backpack_contents = list(
		/obj/item/radio=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=4,
		/obj/item/stack/medical/gauze/improvised = 2)

/datum/outfit/loadout/slcaretaker
	name = "Caretaker"
	suit = /obj/item/clothing/suit/f13/robe_liz
	belt = /obj/item/radio
	backpack_contents = list(
		/obj/item/soap/homemade=1,
		/obj/item/melee/flyswatter=1,
		/obj/item/reagent_containers/glass/rag=1,
		/obj/item/reagent_containers/glass/bucket=1,
		/obj/item/stack/medical/gauze/improvised=1)

/datum/outfit/loadout/slminer
	name = "Miner"
	suit = /obj/item/clothing/suit/f13/vest
	belt = /obj/item/storage/bag/ore

	backpack_contents = list(
		/obj/item/pickaxe=1,
		/obj/item/radio=1)
