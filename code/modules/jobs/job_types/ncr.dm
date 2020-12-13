/datum/job/ncr //do NOT use this for anything, it's just to store faction datums
	department_flag = NCR
	selection_color = "#ffeeaa"

	access = list(ACCESS_NCR)
	minimal_access = list(ACCESS_NCR)
	forbids = "The NCR forbids: Chem and drug use such as jet or alcohol while on duty. Execution of unarmed or otherwise subdued targets without authorisation."
	enforces = "The NCR expects: Obeying the lawful orders of superiors. Proper treatment of prisoners.  Good conduct within the Republic's laws. Wearing the uniform."
	objectivesList = list("Leadership recommends the following goal for this week: Establish an outpost at the radio tower","Leadership recommends the following goal for this week: Neutralize and capture dangerous criminals", "Leadership recommends the following goal for this week: Free slaves and establish good relations with unaligned individuals.")

/datum/outfit/job/ncr/
	name = "NCRdatums"
	jobtype = /datum/job/ncr/
	backpack = /obj/item/storage/backpack/trekker
	satchel = /obj/item/storage/backpack/satchel/trekker
	ears = /obj/item/radio/headset/headset_ncr
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless

/*
Colonel
*/
/datum/job/ncr/f13colonel
	title = "NCR Colonel"
	flag = F13COLONEL
//	faction = "Station"
	head_announce = list("Security")
	supervisors = "the general"
	req_admin_notify = 1

	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/ncr/f13colonel

/datum/outfit/job/ncr/f13colonel/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13colonel
	name 		= "NCR Colonel"
	jobtype 	= /datum/job/ncr/f13colonel
	uniform		= /obj/item/clothing/under/f13/ncr
	accessory 	= /obj/item/clothing/accessory/ncr
	suit 		= /obj/item/clothing/suit/armor/f13/power_armor/t45d/sierra
	head 		= /obj/item/clothing/head/beret/ncr
	belt        = /obj/item/storage/belt/military/assault/ncr
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	suit_store  = /obj/item/gun/ballistic/automatic/marksman
	shoes       = /obj/item/clothing/shoes/f13/military/ncr_officer
	gloves      = /obj/item/clothing/gloves/f13/leather
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m45=3, \
		/obj/item/ammo_box/magazine/m556/rifle=2, \
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/gun/ballistic/automatic/pistol/m1911=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/storage/bag/money/small/ncr)

/*
Captain
*/
/datum/job/ncr/f13captain
	title = "NCR Captain"
	flag = F13CAPTAIN
	head_announce = list("Security")
	faction = "NCR"
	total_positions = 1
	spawn_positions = 1
	description = "You are the commanding officer of your company and direct superior to the Veteran Ranger and Lieutenant. Coordinating with your staff, you must ensure that the objectives of High Command are completed to the letter. Working closely with your subordinates on logistics, mission planning and special operations with the Rangers, you are here to establish a strong foothold for the NCR within the region."
	supervisors = "Colonel"
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_CAPTAIN
	outfit = /datum/outfit/job/ncr/f13captain

	loadout_options = list(
	/datum/outfit/loadout/captinf, //Unique R82 assault rifle
	/datum/outfit/loadout/captscout, //Unique scoped m1 garand
	)

/datum/outfit/job/ncr/f13captain/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13captain
	name = "NCR Captain"
	jobtype 	= /datum/job/ncr/f13captain
	id 			= /obj/item/card/id/dogtag/ncrcaptain
	uniform		= /obj/item/clothing/under/f13/ncr
	accessory 	= /obj/item/clothing/accessory/ncr/CPT
	suit 		= /obj/item/clothing/suit/armor/f13/ncrarmor/captain
	suit_store 	= /obj/item/gun/ballistic/automatic/pistol/ninemil
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	shoes       = /obj/item/clothing/shoes/f13/military/ncr_officer
	neck 		= /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m9mm=2, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/twohanded/binocs=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/clothing/mask/ncr_facewrap)

/datum/job/ncr/f13captain/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")
	H.add_quirk("Lifegiver")
	H.add_quirk("Self-Aware")

/datum/outfit/loadout/captscout
	name = "Scout"
	head 		= /obj/item/clothing/head/beret/ncr_scout_lt
	shoes 		= /obj/item/clothing/shoes/f13/military/ncr_scout
	gloves 		= /obj/item/clothing/gloves/f13/leather/fingerless
	l_hand 		= /obj/item/gun/ballistic/automatic/m1garand/republicspride
	backpack_contents = list(
	/obj/item/ammo_box/magazine/garand308=3)

/datum/outfit/loadout/captinf
	name = "Infantry"
	head = 		/obj/item/clothing/head/beret/ncr
	gloves = 	/obj/item/clothing/gloves/f13/leather
	belt = 		/obj/item/storage/belt/military/assault/ncr
	l_hand = 	/obj/item/gun/ballistic/automatic/service/r82
	backpack_contents = list(
	/obj/item/ammo_box/magazine/m556/rifle/assault=2)

/*
Ambassador
*/

/datum/job/ncr/f13ambassador
	title = "NCR Ambassador"
	flag = F13AMBASSADOR
	head_announce = list("Security")
	faction = "NCR"
	total_positions = 1
	spawn_positions = 1
	description = "You are the political and diplomatic attaché to the NCR forces in the area. Though you are not part of the military, and should avoid conflict, you wield great bureaucratic power."
	supervisors = "Colonel"
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_AMBASSADOR
	outfit = /datum/outfit/job/ncr/f13ambassador

/datum/outfit/job/ncr/f13ambassador
	name = "NCR Ambassador"
	jobtype 	= /datum/job/ncr/f13ambassador
	id 			= /obj/item/card/id/dogtag/ncrambassador
	uniform		= /obj/item/clothing/under/f13/gentlesuit
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	shoes 		= /obj/item/clothing/shoes/laceup
	suit		= /obj/item/clothing/suit/toggle/lawyer/black
	l_hand = /obj/item/storage/briefcase
	gloves      = null
	backpack_contents = list(
		/obj/item/ammo_box/a357=1, \
		/obj/item/gun/ballistic/revolver/police=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/storage/bag/money/small/ncr=1,
		/obj/item/megaphone=1)

/*
Lieutenant
*/

/datum/job/ncr/f13lieutenant
	title = "NCR Lieutenant"
	flag = F13LIEUTENANT
	total_positions = 2
	spawn_positions = 2
	faction = "NCR"
	description = "You are the direct superior to the Sergeant and Enlisted, working with the Captain and under special circumstances, Rangers. You plan patrols, training and missions, working in some cases with Rangers in accomplishing objectives otherwise beyond the capabilities of ordinary enlisted personnel."
	supervisors = "Captain and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_LIEUTENANT
	outfit = /datum/outfit/job/ncr/f13lieutenant

	loadout_options = list(
	/datum/outfit/loadout/ltmedic, //Grease gun, meds
	/datum/outfit/loadout/ltinf, //Assault carbine, extra ammo
	/datum/outfit/loadout/ltscout, //DKS, trekking
	/datum/outfit/loadout/ltmp // Pump riot, baton, beanbags
	)

/datum/outfit/job/ncr/f13lieutenant/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13lieutenant
	name = "NCR Lieutenant"
	jobtype	= /datum/job/ncr/f13lieutenant
	id = 		/obj/item/card/id/dogtag/ncrlieutenant
	uniform	= 	/obj/item/clothing/under/f13/ncr
	accessory = /obj/item/clothing/accessory/ncr/LT
	head = 		/obj/item/clothing/head/beret/ncr
	neck = 		/obj/item/storage/belt/holster
	glasses = 	/obj/item/clothing/glasses/sunglasses/big
	shoes = 	/obj/item/clothing/shoes/f13/military/ncr_officer
	gloves = 	/obj/item/clothing/gloves/f13/leather
	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/ammo_box/magazine/m9mm=2, \
		/obj/item/twohanded/binocs=1, \
		/obj/item/storage/bag/money/small/ncrofficers, \
		/obj/item/clothing/mask/ncr_facewrap)

/datum/outfit/loadout/ltmedic
	name = "Medic"
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	glasses = 		/obj/item/clothing/glasses/hud/health
	gloves = 		/obj/item/clothing/gloves/color/latex/nitrile
	mask = 			/obj/item/clothing/mask/surgical
	suit_store = 	/obj/item/gun/ballistic/automatic/greasegun
	belt = 			/obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/greasegun=2,
		/obj/item/clothing/accessory/armband/medblue=1,
		/obj/item/storage/pill_bottle/mining=1,
		/obj/item/storage/firstaid/regular=1,
		/obj/item/book/granter/trait/chemistry=1,
		/obj/item/reagent_containers/hypospray/CMO=1)

/datum/outfit/loadout/ltinf
	name = "Infantry"
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	suit_store = 	/obj/item/gun/ballistic/automatic/assault_carbine
	belt = 			/obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault=3,
		/obj/item/book/granter/trait/trekking=1)

/datum/outfit/loadout/ltscout
	name = "Scout"
	head = 			/obj/item/clothing/head/beret/ncr_scout_lt
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr_scout
	gloves = 		/obj/item/clothing/gloves/rifleman
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/scout/officer
	suit_store = 	/obj/item/gun/ballistic/automatic/marksman/sniper
	belt = 			/obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308=3,
		/obj/item/book/granter/trait/trekking=1)

/datum/outfit/loadout/ltmp
	name = "Military Police"
	accessory = 	/obj/item/clothing/accessory/armband/black
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	suit_store = 	/obj/item/gun/ballistic/shotgun/riot
	belt = 			/obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/restraints/handcuffs=1, \
		/obj/item/storage/box/rubbershot = 1, \
		/obj/item/storage/box/rubbershot/beanbag = 1, \
		/obj/item/melee/classic_baton= 1
	)

/*
Sergeant
*/

/datum/job/ncr/f13sergeant
	title = "NCR Sergeant"
	flag = F13SERGEANT
	total_positions = 2
	spawn_positions = 2
	faction = "NCR"
	description = "You are the direct superior to the enlisted troops, working with the chain of command you echo the orders of your superiors and ensure that the enlisted follow them to the letter. Additionally, you are responsible for the wellbeing of the troops and their ongoing training with the NCR."
	supervisors = "Lieutenants and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_SERGEANT
	outfit = /datum/outfit/job/ncr/f13sergeant

	loadout_options = list(
	/datum/outfit/loadout/sgtinf, //Service rifle, extra ammo
	/datum/outfit/loadout/sgtscout, //Marksman rifle
	/datum/outfit/loadout/sgtmp, //Drum riot shotgun, baton, beanbags
	/datum/outfit/loadout/sgtmech //Salvaged power armor, LMG
	)

/datum/outfit/job/ncr/f13sergeant
	name = "NCR Sergeant"
	jobtype = /datum/job/ncr/f13sergeant
	id = 			/obj/item/card/id/dogtag/ncrsergeant
	uniform =  		/obj/item/clothing/under/f13/ncr
	accessory =     /obj/item/clothing/accessory/ncr/SGT
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	neck = 			/obj/item/storage/belt/holster
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr
	gloves =        /obj/item/clothing/gloves/f13/leather/fingerless
	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/stack/medical/gauze=1, \
		/obj/item/ammo_box/magazine/m9mm=2, \
		/obj/item/storage/bag/money/small/ncrofficers, \
		/obj/item/clothing/mask/ncr_facewrap)

/datum/outfit/loadout/sgtinf
	name = "Infantry"
	accessory =     /obj/item/clothing/accessory/ncr/SGT
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	suit_store = 	/obj/item/gun/ballistic/automatic/service
	belt = 			/obj/item/storage/belt/military/NCR_Bandolier
	head = 			/obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault=5
	)

/datum/outfit/loadout/sgtmp
	name = "Military Police"
	accessory = 	/obj/item/clothing/accessory/ncr/SGT
	accessory = 	/obj/item/clothing/accessory/armband/black
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	suit_store = 	/obj/item/gun/ballistic/automatic/shotgun/riot
	belt = 			/obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/d12g=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/storage/box/rubbershot = 1, \
		/obj/item/storage/box/rubbershot/beanbag = 1, \
		/obj/item/melee/classic_baton= 1
	)

/datum/outfit/loadout/sgtscout
	name = "Scout"
	accessory = 	/obj/item/clothing/accessory/ncr/SSGT
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/scout/veteran
	head = 			/obj/item/clothing/head/beret/ncr_scout
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr_scout
	gloves = 		/obj/item/clothing/gloves/rifleman
	suit_store = 	/obj/item/gun/ballistic/automatic/marksman
	belt = 			/obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=3)

/datum/outfit/loadout/sgtmech
	name = "Mechanized"
	accessory = 	/obj/item/clothing/accessory/ncr/SSGT
	suit = 			/obj/item/clothing/suit/armor/f13/power_armor/ncr
	head = 			/obj/item/clothing/head/helmet/f13/power_armor/t45b
	belt = 			/obj/item/storage/belt/military/assault/ncr
	suit_store = 	/obj/item/gun/ballistic/automatic/lmg
	backpack_contents = list(
		/obj/item/ammo_box/magazine/lmg=3, \
		/obj/item/book/granter/trait/trekking=1
	)

/*
Corporal
*/

/datum/job/ncr/f13specialist
	title = "NCR Corporal"
	flag = F13SPECIALIST
	faction = "NCR"
	total_positions = 4
	spawn_positions = 4
	description = "You are an experienced junior NCO with a specialized skill set. You work closely with your squad, taking orders from your Sergeant to achieve the NCR's goals."
	supervisors = "Sergeants and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_SPECIALIST
	outfit = /datum/outfit/job/ncr/f13specialist

	loadout_options = list(
	/datum/outfit/loadout/specmedic, //Medkit, medHUD, patches, needler
	/datum/outfit/loadout/speceng, //C4, toolbelt, welding goggles
	/datum/outfit/loadout/specscout, //Scoped hunting rifle, binoculars
	/datum/outfit/loadout/specmp, //Hunting shotgun, baton, beanbags
	///datum/outfit/loadout/specmech //Power armor, assault rifle
	)

/datum/outfit/job/ncr/f13specialist
	name = "NCR Corporal"
	jobtype = /datum/job/ncr/f13specialist
	uniform =  		/obj/item/clothing/under/f13/ncr
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	neck = 			/obj/item/storage/belt/holster
	accessory = /obj/item/clothing/accessory/ncr/CPL
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=2, \
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/stack/medical/gauze=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1, \
		/obj/item/clothing/mask/ncr_facewrap=1
		)

/datum/outfit/loadout/specmedic
	name = "Medic"
	glasses = 		/obj/item/clothing/glasses/hud/health
	head = 			/obj/item/clothing/head/f13/ncr
	gloves = 		/obj/item/clothing/gloves/color/latex/nitrile
	mask = 			/obj/item/clothing/mask/surgical
	belt = 			/obj/item/storage/belt/military/assault/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	suit_store = 	/obj/item/gun/ballistic/revolver/needler
	backpack_contents = list(
		/obj/item/clothing/accessory/armband/medblue=1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=3,
		/obj/item/book/granter/trait/chemistry=1,
		/obj/item/storage/pill_bottle/mining=1,
		/obj/item/storage/firstaid/regular=1,
		/obj/item/ammo_box/needle=3
		)

/datum/outfit/loadout/speceng
	name = "Engineer"
	glasses = 		/obj/item/clothing/glasses/welding
	gloves = 		/obj/item/clothing/gloves/color/yellow
	belt = 			/obj/item/storage/belt/utility/full/engi
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	suit_store = 	/obj/item/gun/ballistic/automatic/service
	head = 			/obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/grenade/plastic=1,
		/obj/item/stack/sheet/metal/fifty=2,
		/obj/item/stack/sheet/glass/fifty=1,
		/obj/item/ammo_box/magazine/m556/rifle=2,
		/obj/item/book/granter/trait/techno
		)

/datum/outfit/loadout/specscout
	name = "Scout"
	suit_store = 	/obj/item/gun/ballistic/shotgun/remington/scoped
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/scout
	head = 			/obj/item/clothing/head/beret/ncr_scout
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	gloves = 		/obj/item/clothing/gloves/rifleman
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr_scout
	belt = 			/obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/ammo_box/a308=3,
		/obj/item/twohanded/binocs=1
		)

/datum/outfit/loadout/specmp
	name = "Military Police"
	accessory = 	/obj/item/clothing/accessory/armband/black
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	suit_store = 	/obj/item/gun/ballistic/shotgun/hunting
	belt = 			/obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/restraints/handcuffs=1, , \
		/obj/item/storage/box/rubbershot = 1, \
		/obj/item/storage/box/rubbershot/beanbag = 1, \
		/obj/item/melee/classic_baton=1
	)

/datum/outfit/loadout/specmech
	name = "Mechanized"
	suit = 			/obj/item/clothing/suit/armor/f13/power_armor/ncr
	head = 			/obj/item/clothing/head/helmet/f13/power_armor/t45b
	belt = 			/obj/item/storage/belt/military/assault/ncr
	suit_store = 	/obj/item/gun/ballistic/automatic/assault_rifle

	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault = 2, \
		/obj/item/book/granter/trait/trekking=1,
	)
/*
NCR Heavy Trooper
*/

/*
/datum/job/ncr/f13ncrht
	title = "NCR Heavy Trooper"
	flag = F13NCRHT
	faction = "NCR"
	total_positions = 2
	spawn_positions = 2
	description = "You are a corporal or a Sergeant who has been selected for the special duty of Heavy Trooper. You are exceptionally physically fit, being conditioned to wear the many, many pounds of salvaged power armor; and trained with your R84 LMG. You are the poster-child of the NCR Embassy, and should act accordingly."
	supervisors = "the officers"
	selection_color = "#fff5cc"

	outfit = /datum/outfit/job/ncr/f13ncrht

	loadout_options = list(
	/datum/outfit/loadout/heavycpl,
	/datum/outfit/loadout/heavysgt,
	)

/datum/outfit/job/ncr/f13ncrht
	name = "NCR Heavy Trooper"
	jobtype = /datum/job/ncr/f13ncrht
	id = 			/obj/item/card/id/dogtag/ncrht
	uniform =  		/obj/item/clothing/under/f13/ncr
	suit_store = 	/obj/item/gun/ballistic/automatic/lmg
	suit = 			/obj/item/clothing/suit/armor/f13/power_armor/ncr
	head = 			/obj/item/clothing/head/helmet/f13/power_armor/t45b
	belt =          /obj/item/storage/belt/military/NCR_Bandolier
	glasses = 		null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1, \
		/obj/item/book/granter/trait/trekking=1, \
		/obj/item/ammo_box/magazine/lmg=3
		)

/datum/outfit/loadout/heavycpl
	name = "Heavy Corporal"
	backpack_contents = list(
		/obj/item/clothing/accessory/ncr/CPL=1,
		)

/datum/outfit/loadout/heavysgt
	name = "Heavy Sergeant"
	backpack_contents = list(
		/obj/item/clothing/accessory/ncr/SGT=1,
		)
*/

/*
NCR Military Police
*/

/*
/datum/job/ncr/f13ncrmp
	title = "NCR Military Police"
	flag = F13NCRMP
	faction = "NCR"
	total_positions = 2
	spawn_positions = 2
	description = "You are the primary enforcers of NCR law within the ranks of the local embassy. You are technically exempt from the standard chain of command, answering only to High-Command, and specifically, the NCR Office of Special Investigations (NCROSI). "
	supervisors = "NCROSI"
	selection_color = "#fff5cc"

	outfit = /datum/outfit/job/ncr/f13ncrmp

/datum/outfit/job/ncr/f13ncrmp
	name = "NCR Military Police"
	jobtype = /datum/job/ncr/f13ncrmp
	id = 			/obj/item/card/id/dogtag/ncrmp
	uniform =  		/obj/item/clothing/under/f13/ncr
	accessory =     /obj/item/clothing/accessory/armband/black
	head = 			/obj/item/clothing/head/f13/ncr/mp
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor
	suit_store = 	/obj/item/gun/ballistic/shotgun/sc_pump
	r_hand = 		/obj/item/melee/classic_baton
	belt =          /obj/item/storage/belt/military/NCR_Bandolier
	glasses = 		null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrenlisted, \
		/obj/item/storage/box/rubbershot = 1, \
		/obj/item/storage/box/rubbershot/beanbag =1, \
		)
*/

/*
Trooper
*/

/datum/job/ncr/f13trooper
	title = "NCR Trooper"
	flag = F13TROOPER
	faction = "NCR"
	total_positions = 5
	spawn_positions = 5
	description = "You are considered the backbone and workforce strength of the NCR Army. You answer to everyone above you in the chain of command, taking orders from your Sergeant directly and obeying all commands given by officers such as the Lieutenant and Captain."
	supervisors = "Corporals and above"
	selection_color = "#fff5cc"
	exp_requirements = 12
	exp_type = EXP_TYPE_NCR
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13trooper

/*
	loadout_options = list(
	/datum/outfit/loadout/trooperfrontline, //Service rifle
	/datum/outfit/loadout/trooperranged //Hunting rifle
	)
*/

/datum/outfit/job/ncr/f13trooper
	name = "NCR Trooper"
	jobtype = /datum/job/ncr/f13trooper
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	uniform =  		/obj/item/clothing/under/f13/ncr
	accessory =     /obj/item/clothing/accessory/ncr/TPR
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor/mantle
	suit_store = 	/obj/item/gun/ballistic/automatic/service
	belt =          /obj/item/storage/belt/military/assault/ncr
	glasses = 		null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/stack/medical/gauze=1, \
		/obj/item/storage/bag/money/small/ncrenlisted, \
		/obj/item/clothing/mask/ncr_facewrap, \
		/obj/item/ammo_box/magazine/m556/rifle=2)

/*
/datum/outfit/loadout/trooperfrontline
	name = "Front-Line Trooper"
	suit_store = 	/obj/item/gun/ballistic/automatic/marksman/servicerifle
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=3)

/datum/outfit/loadout/trooperranged
	name = "Ranged Trooper"
	suit_store = /obj/item/gun/ballistic/shotgun/remington
	backpack_contents = list(
		/obj/item/ammo_box/a308=3
		)
*/

/*
Recruit
*/

/datum/job/ncr/f13recruit
	title = "NCR Recruit"
	flag = F13RECRUIT
	faction = "NCR"
	total_positions = 3
	spawn_positions = 3
	description = "You are the lowest-ranked combatant in the military, having just completed Basic Combat Training. Utilize the skills and knowledge you acquired during basic training and follow orders that are given by higher ranking supervisors."
	supervisors = "everyone in the NCR"
	selection_color = "#fff5cc"
	exp_requirements = 12
	exp_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_RECRUIT
	outfit = /datum/outfit/job/ncr/f13recruit

/datum/outfit/job/ncr/f13recruit
	name = "NCR Recruit"
	jobtype = 		/datum/job/ncr/f13recruit
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	uniform = 		/obj/item/clothing/under/f13/ncr
	accessory = 	/obj/item/clothing/accessory/ncr/REC
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor
	suit_store =	/obj/item/gun/ballistic/automatic/pistol/ninemil
	gloves = null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/stack/medical/gauze=1, \
		/obj/item/storage/bag/money/small/ncrenlisted)

//NCR Administrator
/datum/job/ncr/f13ncradmin
	title = "NCR Administrator"
	flag = F13NCRADMIN
	faction = "NCR"
	total_positions = 1
	spawn_positions = 1
	description = "As an Administrator, you perform managerial duties for the facilities of the city as well as the people who occupy it, ensure that people are listened to and their needs are met, and assist the military in a civilian capacity by corresponding and delegating others to complete tasks. "
	supervisors = "Ambassador or Captain"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_NCRADMIN
	outfit = /datum/outfit/job/ncr/f13ncradmin

/datum/outfit/job/ncr/f13ncradmin
	name = "NCR Administrator"
	jobtype = /datum/job/ncr/f13ncradmin
	id = 			/obj/item/card/id/dogtag/ncradmin
	uniform =  		/obj/item/clothing/under/suit_jacket/tan
	glasses =		/obj/item/clothing/glasses/sunglasses
	shoes = 		/obj/item/clothing/shoes/f13/fancy
	backpack_contents = list(
		/obj/item/storage/secure/briefcase=1, \
		/obj/item/pen/fountain=1, \
		/obj/item/pen/fourcolor=1, \
		/obj/item/clipboard=1, \
		/obj/item/stamp=1, \
		/obj/item/stamp/denied=1)

//NCR Citizen
/datum/job/ncr/f13ncrcitizen
	title = "NCR Citizen"
	flag = F13NCRCITIZEN
	faction = "NCR"
	total_positions = 8
	spawn_positions = 8
	access = list()
	description = "As an NCR Citizen, you may believe that the potential for fortune out west has dried up and that the frontier holds abundant opportunities for you to encroach and take advantage of. Surrounded by the relative safety of the Republic, you are responsible for being a part of the cities community and maintaining the facilities within it in any capacity which will aid the greater good. You may correspond with the Administrator or other NCR leadership to help them achieve goals, or pursue your own individual goals as an independent agent of the NCR.."
	supervisors = "NCR Administrator"
	selection_color = "#fff5cc"
	exp_requirements = 12
	exp_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_NCRCITIZEN
	outfit = /datum/outfit/job/ncr/f13ncrcitizen

	loadout_options = list(
	/datum/outfit/loadout/brahminbaron,
	/datum/outfit/loadout/sharecropper,
	/datum/outfit/loadout/mechanic,
	/datum/outfit/loadout/offduty
	)

/datum/outfit/job/ncr/f13ncrcitizen
	ears = /obj/item/radio/headset
	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/caravaneer
	shoes = /obj/item/clothing/shoes/f13/tan
	head = /obj/item/clothing/head/f13/cowboy
	gloves = /obj/item/clothing/gloves/color/brown
	glasses = /obj/item/clothing/glasses/orange
	backpack_contents = list(
		/obj/item/storage/bag/money/small/wastelander)

/datum/outfit/loadout/brahminbaron
	name = "Brahmin Baron"
	backpack_contents = list(
		/obj/item/clothing/under/f13/gentlesuit=1,
		/obj/item/clothing/suit/jacket/leather=1,
		/obj/item/clothing/head/collectable/tophat=1,
		/obj/item/clothing/shoes/f13/fancy=1,
		/obj/item/stack/f13Cash/ncr=1,
		/obj/item/clothing/glasses/monocle=1,
		/obj/item/staff/stick=1)

/datum/outfit/loadout/sharecropper
	name = "Sharecropper"
	backpack_contents = list(
		/obj/item/clothing/under/overalls=1,
		/obj/item/clothing/suit/f13/vest=1,
		/obj/item/clothing/head/f13/cowboy=1,
		/obj/item/reagent_containers/glass/bucket=1,
		/obj/item/cultivator=1,
		/obj/item/shovel/spade=1,
		/obj/item/reagent_containers/glass/bottle/nutrient/rh=2,
		/obj/item/hatchet=1
		)

/datum/outfit/loadout/mechanic
	name = "Mechanic"
	backpack_contents = list(
		/obj/item/clothing/under/f13/mechanic=1,
		/obj/item/clothing/suit/apron/overalls=1,
		/obj/item/clothing/head/hardhat/dblue=1,
		/obj/item/clothing/shoes/workboots=1,
		/obj/item/storage/belt/utility/full/engi=1,
		/obj/item/clothing/glasses/welding=1,
		/obj/item/book/granter/trait/techno
		)

/datum/outfit/loadout/offduty
	name = "Off Duty"
	backpack_contents = list(
		/obj/item/clothing/under/f13/cowboyt=1,
		/obj/item/clothing/suit/det_suit=1,
		/obj/item/clothing/shoes/f13/military/ncr=1,
		/obj/item/clothing/gloves/f13/leather/fingerless=1,
		/obj/item/kitchen/knife/combat=1
		)

/*
Veteran Ranger
*/

/datum/job/ncr/f13vetranger
	title = "NCR Veteran Ranger"
	flag = F13VETRANGER
	faction = "NCR"
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Captain, working either independently or in a team to complete your mission objectives however required, operating either alone, in a squad or with the NCR Army. Your primary mission is to improve general opinion of the Republic and to neutralize slavers and raiders operating in the area."
	supervisors = "Captain and above"
	selection_color = "#ffeeaa"
	display_order = JOB_DISPLAY_ORDER_VETRANGE
	outfit = /datum/outfit/job/ncr/f13vetranger

	loadout_options = list(
	/datum/outfit/loadout/vrclassic, //AMR and Sequoia,
	/datum/outfit/loadout/vrlite, //Rangemaster and Sequoia,
	/datum/outfit/loadout/vrbrush //Scoped Brushgun and Sequoia
	)

/datum/job/ncr/f13vetranger/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")
	H.add_quirk("Lifegiver")
	H.add_quirk("Iron Fist")

/datum/outfit/job/ncr/f13vetranger/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13vetranger
	name = "NCR Veteran Ranger"
	jobtype = /datum/job/ncr/f13vetranger
	id = 			/obj/item/card/id/dogtag/ncrranger
	uniform =  		/obj/item/clothing/under/f13/ranger/vet
	suit = 			/obj/item/clothing/suit/armor/f13/rangercombat
	belt =			/obj/item/storage/belt/military/assault/ncr
	head = 			/obj/item/clothing/head/helmet/f13/ncr/rangercombat
	gloves =		/obj/item/clothing/gloves/rifleman
	shoes =			/obj/item/clothing/shoes/laced
	glasses = 		/obj/item/clothing/glasses/orange
	r_pocket = 		/obj/item/twohanded/binocs
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/sequoia=1, \
		/obj/item/ammo_box/c4570=3, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrofficers)

/datum/outfit/loadout/vrclassic
	name = "Classic Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/shotgun/antimateriel
	backpack_contents = list(
		/obj/item/ammo_box/a50MG=3)

/datum/outfit/loadout/vrlite
	name = "Light Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/automatic/rangemaster
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m762/ext=2)

/datum/outfit/loadout/vrbrush
	name = "Brush Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/hunting/brush/scoped
	backpack_contents = list(
		/obj/item/ammo_box/tube/c4570=3)

/*
Ranger -- Split into Patrol and Scout

/datum/job/ncr/f13ranger
	title = "NCR Ranger"
	flag = F13RANGER
	faction = "NCR"
	total_positions = 2
	spawn_positions = 2
	description = "As a Ranger, you perform reconnaissance, seize or destroy assets, and capture or recover designated targets in service to the Republic. Your reason for being sent here is to find and exploit local assets within the Region in order to prepare the area for the Republic's eventual arrival."
	supervisors = "Veteran Ranger"
	selection_color = "#fff5cc"

	outfit = /datum/outfit/job/ncr/f13ranger

	loadout_options = list(
	/datum/outfit/loadout/prclassic, //Scoped Sniper rifle and .44,
	/datum/outfit/loadout/prlite, //Marksman carbine and .44,
	/datum/outfit/loadout/prtrail //Scoped Trail carbine and .44
	)

/datum/job/ncr/f13ranger/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")

/datum/outfit/job/ncr/f13ranger/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK)

/datum/outfit/job/ncr/f13ranger
	name = "NCR Ranger"
	jobtype = /datum/job/ncr/f13ranger
	id = 			/obj/item/card/id/dogtag/ncrranger
	uniform =  		/obj/item/clothing/under/f13/ranger
	belt =			/obj/item/storage/belt/military/assault/ncr
	gloves =		/obj/item/clothing/gloves/patrol
	shoes =			/obj/item/clothing/shoes/laced
	glasses = 		/obj/item/clothing/glasses/sunglasses/big
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/m29/alt,
		/obj/item/ammo_box/m44=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrofficers)
	r_pocket = /obj/item/twohanded/binocs

/datum/outfit/loadout/prclassic
	name = "Classic Ranger"
	suit = /obj/item/clothing/suit/armor/f13/combat/ncr
	head = /obj/item/clothing/head/f13/ranger
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308=3)

/datum/outfit/loadout/prlite
	name = "Light Ranger"
	suit = /obj/item/clothing/suit/armor/f13/combat/ncr
	head = /obj/item/clothing/head/f13/ranger
	suit_store = /obj/item/gun/ballistic/automatic/marksman
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=3)

/datum/outfit/loadout/prtrail
	name = "Trail Ranger"
	uniform = /obj/item/clothing/under/f13/trailranger
	suit = /obj/item/clothing/suit/armor/f13/trailranger
	head = /obj/item/clothing/head/f13/trailranger
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail/scoped
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44=2,
		/obj/item/gun/ballistic/revolver/m29=1,
		/obj/item/ammo_box/m44=2
		)
*/

//Patrol Ranger
/datum/job/ncr/f13rangerpatrol
	title = "NCR Patrol Ranger"
	flag = F13RANGERPATROL
	faction = "NCR"
	total_positions = 2
	spawn_positions = 2
	description = "As a Patrol Ranger, you patrol the wasteland, aid those in need, and capture, recover, or neutralize designated targets in service to the Republic. Your reason for being sent here is to improve public opinion of the Republic through acts of service to the community, and by putting down slavers and raiders in the region."
	supervisors = "Veteran Ranger"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_RANGERPATROL
	outfit = /datum/outfit/job/ncr/f13rangerpatrol

/datum/job/ncr/f13rangerpatrol/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")

/datum/outfit/job/ncr/f13ranger/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13rangerpatrol
	name = "NCR Patrol Ranger"
	jobtype = /datum/job/ncr/f13rangerpatrol
	id = 			/obj/item/card/id/dogtag/ncrranger
	uniform =  		/obj/item/clothing/under/f13/ranger/patrol
	suit =			/obj/item/clothing/suit/armor/f13/combat/ncr
	head =			/obj/item/clothing/head/f13/ranger
	belt =			/obj/item/storage/belt/military/assault/ncr
	gloves =		/obj/item/clothing/gloves/patrol
	shoes =			/obj/item/clothing/shoes/laced
	glasses = 		/obj/item/clothing/glasses/orange
	suit_store =	/obj/item/gun/ballistic/automatic/marksman
	r_pocket = /obj/item/twohanded/binocs
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/m29,
		/obj/item/ammo_box/m44=2, \
		/obj/item/ammo_box/magazine/m556/rifle=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrofficers)


//Scout Ranger
/datum/job/ncr/f13rangerscout
	title = "NCR Scout Ranger"
	flag = F13RANGERSCOUT
	faction = "NCR"
	total_positions = 2
	spawn_positions = 2
	description = "As a Scout Ranger, you perform reconnaissance and assist in special operations for the Republic. Your reason for being sent here is to identify and neutralize threats to the Republic and to assist Patrol Rangers in identifying slavers and raiders so that they can be brought to justice."
	supervisors = "Veteran Ranger"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_RANGERSCOUT
	outfit = /datum/outfit/job/ncr/f13rangerscout

	loadout_options = list(
	/datum/outfit/loadout/rangerrecon, //Scoped .308 Sniper rifle and .44,
	/datum/outfit/loadout/rangertrail //M1 Garand and .44,
	)

/datum/job/ncr/f13rangerscout/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")
	H.add_quirk("Light Step")

/datum/outfit/job/ncr/f13ranger/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13rangerscout
	name = "NCR Scout Ranger"
	jobtype = /datum/job/ncr/f13rangerscout
	id = 			/obj/item/card/id/dogtag/ncrranger
	uniform = 		/obj/item/clothing/under/f13/ranger/trail
	gloves =		/obj/item/clothing/gloves/patrol
	shoes =			/obj/item/clothing/shoes/laced
	glasses = 		/obj/item/clothing/glasses/sunglasses
	r_pocket = 		/obj/item/twohanded/binocs
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/m29,
		/obj/item/ammo_box/m44=2, \
		/obj/item/ammo_box/tube/m44=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/storage/bag/money/small/ncrofficers)

/datum/outfit/loadout/rangerrecon
	name = "Recon Ranger"
	suit =	/obj/item/clothing/suit/toggle/armor/f13/rangerrecon
	head =	/obj/item/clothing/head/beret/ncr_recon_ranger
	belt =	/obj/item/storage/belt/military/reconbandolier
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308=3)

/datum/outfit/loadout/rangertrail
	name = "Trail Ranger"
	suit =	/obj/item/clothing/suit/armor/f13/trailranger
	head =	/obj/item/clothing/head/f13/trailranger
	belt =	/obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/automatic/m1garand
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308=3)
