/datum/job/ncr //do NOT use this for anything, it's just to store faction datums
	department_flag = NCR
	selection_color = "#ffeeaa"
	faction = "NCR"
	exp_type = EXP_TYPE_NCR

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
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	l_pocket = /obj/item/book/manual/ncr/jobguide

/datum/outfit/job/ncr/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedarmorconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrcombatarmor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrcombathelmet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrcombatarmormk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrcombathelmetmk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/servicerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/entrenching_tool)

/*
Colonel
*/
/datum/job/ncr/f13colonel
	title = "NCR Colonel"
	flag = F13COLONEL
	faction = "NCR"
	head_announce = list("Security")
	supervisors = "the general"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	req_admin_notify = 1

	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/ncr/f13colonel

/datum/outfit/job/ncr/f13colonel/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)

/datum/outfit/job/ncr/f13colonel
	name 		= "NCR Colonel"
	jobtype 	= /datum/job/ncr/f13colonel
	id 			= /obj/item/card/id/dogtag/ncrcolonel
	uniform		= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes 		= /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory 	= /obj/item/clothing/accessory/ncr
	head 		= /obj/item/clothing/head/helmet/f13/power_armor/t45d/sierra
	belt        = /obj/item/storage/belt/military/assault/ncr
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	suit_store  = /obj/item/gun/ballistic/automatic/marksman
	gloves      = /obj/item/clothing/gloves/f13/leather
	suit 		= /obj/item/clothing/suit/armor/f13/power_armor/t45d/sierra
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m45=3, \
		/obj/item/ammo_box/magazine/m556/rifle=1, \
		/obj/item/kitchen/knife/combat/survival=1, \
		/obj/item/gun/ballistic/automatic/pistol/m1911=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/storage/bag/money/small/ncr=1, \
		/obj/item/clothing/head/beret/ncr=1)

/*
Captain
*/
/datum/job/ncr/f13captain
	title = "NCR Captain"
	flag = F13CAPTAIN
	head_announce = list("Security")
	total_positions = 1
	spawn_positions = 1
	description = "You are the commanding officer of your company and direct superior to the Veteran Ranger and Lieutenant. Coordinating with your staff, you must ensure that the objectives of High Command are completed to the letter. Working closely with your subordinates on logistics, mission planning and special operations with the Rangers, you are here to establish a strong foothold for the NCR within the region."
	supervisors = "Colonel"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_CAPTAIN_NCR
	outfit = /datum/outfit/job/ncr/f13captain
	exp_requirements = 2000

	loadout_options = list(
	/datum/outfit/loadout/captao, //Captain armor, m16a1, deagle
	/datum/outfit/loadout/captco, //Officer coat, R91, hunting revolver
	)

/datum/outfit/job/ncr/f13captain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)

/datum/outfit/job/ncr/f13captain
	name = "NCR Captain"
	jobtype 	= /datum/job/ncr/f13captain
	id 			= /obj/item/card/id/dogtag/ncrcaptain
	uniform		= /obj/item/clothing/under/f13/ncr/ncr_officer
	head 		= /obj/item/clothing/head/beret/ncr
	gloves =	/obj/item/clothing/gloves/f13/military
	shoes 		= /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory 	= /obj/item/clothing/accessory/ncr/CPT
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	neck 		= /obj/item/storage/belt/holster
	ears = 		/obj/item/radio/headset/headset_ncr_com
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/binoculars=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/megaphone,	\
		/obj/item/clothing/mask/ncr_facewrap)

/datum/outfit/loadout/captao
	name = "Armored Officer"
	suit 		= /obj/item/clothing/suit/armor/f13/ncrarmor/captain
	belt 		= /obj/item/storage/belt/military/assault/ncr
	l_hand 		= /obj/item/gun/ballistic/automatic/assault_rifle
	backpack_contents = list(
	/obj/item/ammo_box/magazine/m556/rifle/assault=1,
	/obj/item/gun/ballistic/automatic/pistol/deagle=1,
	/obj/item/ammo_box/magazine/m44=3)

/datum/outfit/loadout/captco
	name = "Commanding Officer"
	suit = 		/obj/item/clothing/suit/armor/f13/ncrarmor/lieutenant/ncr_officer_coat
	belt = 		/obj/item/storage/belt/military/assault/ncr
	l_hand =	/obj/item/gun/ballistic/automatic/assault_rifle
	backpack_contents = list(
	/obj/item/ammo_box/magazine/m556/rifle/assault=1,
	/obj/item/gun/ballistic/revolver/hunting=1,
	/obj/item/ammo_box/c4570=3
	)

/*
Lieutenant
*/

/datum/job/ncr/f13lieutenant
	title = "NCR Lieutenant"
	flag = F13LIEUTENANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the direct superior to the Sergeant First Class and Enlisted, and under special circumstances, Rangers. You are the XO of Camp Miller. You plan patrols, training and missions, working in some cases with Rangers in accomplishing objectives otherwise beyond the capabilities of ordinary enlisted personnel."
	supervisors = "Captain and above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_LIEUTENANT
	outfit = /datum/outfit/job/ncr/f13lieutenant
	exp_requirements = 1500

/datum/outfit/job/ncr/f13lieutenant
	name = "NCR Lieutenant"
	jobtype	= /datum/job/ncr/f13lieutenant
	id			= /obj/item/card/id/dogtag/ncrlieutenant
	uniform		= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes 		= /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory 	= /obj/item/clothing/accessory/ncr/LT1
	head 		= /obj/item/clothing/head/beret/ncr
	neck 		= /obj/item/storage/belt/holster
	glasses 	= /obj/item/clothing/glasses/sunglasses/big
	gloves 		= /obj/item/clothing/gloves/f13/leather
	ears 		= /obj/item/radio/headset/headset_ncr_com
	suit 		= /obj/item/clothing/suit/armor/f13/ncrarmor/lieutenant
	suit_store	= /obj/item/gun/ballistic/automatic/service/r82
	belt		= /obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/reagent_containers/hypospray/medipen/stimpak=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/binoculars=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/ammo_box/magazine/m556/rifle/assault=1)

/datum/outfit/job/ncr/f13lieutenant/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)

/*
Medical Officer
*/
/datum/job/ncr/f13medicalofficer
	title = "NCR Medical Officer"
	flag = F13MEDICALOFFICER
	total_positions = 1
	spawn_positions = 1
	description = "You are lead medical professional in Camp Miller, you do not have any command authority unless it is of medical nature. Your duties are to ensure your troopers are in good health and that medical supplies are stocked for troopers."
	supervisors = "Captain and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_MEDICALOFFICER
	outfit = /datum/outfit/job/ncr/f13medicalofficer
	exp_requirements = 1500

/datum/outfit/job/ncr/f13medicalofficer
	name = "NCR Medical Officer"
	jobtype		= /datum/job/ncr/f13medicalofficer
	id			= /obj/item/card/id/dogtag/ncrlieutenant
	uniform		= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes 		= /obj/item/clothing/shoes/f13/military/ncr
	accessory 	= /obj/item/clothing/accessory/ncr/LT2
	head 		= /obj/item/clothing/head/beret/ncr
	neck 		= /obj/item/storage/belt/holster
	glasses 	= /obj/item/clothing/glasses/hud/health/f13
	gloves		= /obj/item/clothing/gloves/color/latex/nitrile
	ears 		= /obj/item/radio/headset/headset_ncr_com
	suit 		= /obj/item/clothing/suit/armor/f13/ncrarmor/labcoat
	belt		= /obj/item/storage/belt/military/assault/ncr
	r_hand 		= /obj/item/storage/backpack/duffelbag/med/surgery
	mask 		= /obj/item/clothing/mask/surgical
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom=1, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/storage/survivalkit_aid=2, \
		/obj/item/storage/survivalkit_aid_adv=1, \
		/obj/item/ammo_box/magazine/m45=3, \
		/obj/item/binoculars=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/storage/firstaid/regular=1)

/datum/outfit/job/ncr/f13medicalofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)

/*
Logistics Officer
*/
/datum/job/ncr/f13logisticsofficer
	title = "NCR Logistics Officer"
	flag = F13LOGISTICSOFFICER
	total_positions = 1
	spawn_positions = 1
	description = "You are the lead engineering professional in Camp Miller, you do not have any command authority unless it is of engineering nature. Your duties are to ensure your outpost is well defended, the armory is in order, and you always have supplies."
	supervisors = "Captain and above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_LOGISTICSOFFICER
	outfit = /datum/outfit/job/ncr/f13logisticsofficer
	exp_requirements = 1500

/datum/outfit/job/ncr/f13logisticsofficer
	name = "NCR Logistics Officer"
	jobtype			= /datum/job/ncr/f13logisticsofficer
	id				= /obj/item/card/id/dogtag/ncrlieutenant
	uniform			= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	accessory 		= /obj/item/clothing/accessory/ncr/LT2
	head 			= /obj/item/clothing/head/beret/ncr_sapper
	neck 			= /obj/item/storage/belt/holster
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/mantle
	glasses			= /obj/item/clothing/glasses/welding
	belt 			= /obj/item/storage/belt/utility/full/engi
	gloves			= /obj/item/clothing/gloves/color/yellow
	suit_store		= /obj/item/gun/ballistic/automatic/service/r82
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom=1, \
		/obj/item/ammo_box/magazine/m45=3, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/ammo_box/magazine/m556/rifle=1, \
		/obj/item/grenade/plastic=2, \
		/obj/item/stack/sheet/metal/fifty=2, \
		/obj/item/stack/sheet/glass/fifty=2
		)

/datum/outfit/job/ncr/f13logisticsofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/R82)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/marksmancarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lmg)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/scoutcarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rangemaster)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1garand)
	ADD_TRAIT(H, TRAIT_MASTER_GUNSMITH, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)


/*
Sergeant First Class
*/

/datum/job/ncr/f13firstsergeant
	title = "NCR Sergeant First Class" 
	flag = F13FIRSTSERGEANT
	total_positions = 0 //basically doesn't get used, remove the bloat roles. I wont delete this but it should be either reworked or commented out.
	spawn_positions = 0
	description = "You are the most senior NCO in Camp Miller. You act as an senior enlisted advisor to the Lieutenant as well as act as in the third in Command. You have the authority to recommend promotions and as well as managing the enlisted personnel"
	supervisors = "Lieutenant and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_FIRSTSERGEANT
	outfit = /datum/outfit/job/ncr/f13firstsergeant
	exp_requirements = 1000

/datum/outfit/job/ncr/f13firstsergeant
	name = "NCR Sergeant First Class"
	jobtype = /datum/job/ncr/f13firstsergeant
	id 				= /obj/item/card/id/dogtag/ncrsergeant
	uniform		 	= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	accessory 		= /obj/item/clothing/accessory/ncr/FSGT
	glasses 		= /obj/item/clothing/glasses/sunglasses/big
	neck 			= /obj/item/storage/belt/holster
	ears 			= /obj/item/radio/headset/headset_ncr_com
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	head 			= /obj/item/clothing/head/f13/ncr_campaign
	suit_store		= /obj/item/gun/ballistic/automatic/service/r82
	belt			= /obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncr, \
		/obj/item/melee/classic_baton/telescopic=1, \
		/obj/item/ammo_box/magazine/m556/rifle/assault=1, \
		/obj/item/binoculars=1)

/*
Sergeant
*/

/datum/job/ncr/f13sergeant
	title = "NCR Sergeant"
	flag = F13SERGEANT
	total_positions = 3
	spawn_positions = 3
	description = "You are the direct superior to the enlisted troops, working with the chain of command you echo the orders of your superiors and ensure that the enlisted follow them to the letter. Additionally, you are responsible for the wellbeing of the troops and their ongoing training with the NCR."
	supervisors = "Sergeant First Class and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_SERGEANT
	outfit = /datum/outfit/job/ncr/f13sergeant
	exp_requirements = 600
	
	loadout_options = list(
	/datum/outfit/loadout/sergeantrifleman,
	/datum/outfit/loadout/sergeantrecon,
	/datum/outfit/loadout/sergeantcqc
	)


/datum/outfit/job/ncr/f13sergeant
	name = "NCR Sergeant"
	jobtype = /datum/job/ncr/f13sergeant
	id 				= /obj/item/card/id/dogtag/ncrsergeant
	uniform 		= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	accessory		= /obj/item/clothing/accessory/ncr/SGT
	glasses			= /obj/item/clothing/glasses/sunglasses/big
	neck 			= /obj/item/storage/belt/holster
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	belt			= /obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/storage/bag/money/small/ncrofficers, \
		/obj/item/binoculars=1)

/datum/outfit/loadout/sergeantrifleman
	name = "Rifleman"
	suit_store = /obj/item/gun/ballistic/automatic/service 
	head = /obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault=2, \
		/obj/item/storage/box/ration/menu_two=1)

/datum/outfit/loadout/sergeantrecon
	name = "Pathfinder Squad Leader"
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/compact //behold, the only autosearable M1
	head 			= /obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/book/granter/trait/trekking=1,
		/obj/item/ammo_box/magazine/m10mm_adv/ext=2, \
		/obj/item/storage/box/ration/menu_eight=1,
		)

/datum/outfit/loadout/sergeantcqc
	name = "Trench Raider"
	suit_store = /obj/item/gun/ballistic/shotgun/trench //Over thereee over thereeeee spread the spread the word over thereeee
	head = /obj/item/clothing/head/f13/ncr/goggles
	backpack_contents = list(
		/obj/item/storage/fancy/ammobox/lethalshot=2, \
		/obj/item/clothing/mask/gas=1, \
		/obj/item/tank/internals/emergency_oxygen/engi=1, \
		/obj/item/grenade/smokebomb/ncr=3, \
		/obj/item/kitchen/knife/trench=1 \
		)



/*
Heavy Trooper
*/

/datum/job/ncr/f13heavytrooper
	title = "NCR Heavy Trooper"
	flag = F13HEAVYTROOPER
	total_positions = 2
	spawn_positions = 2
	description = "You are the most elite of the enlisted, sergeant in rank but forgoing regular command roles to lead in battle only. You are expected to be on the frontlines of every engagement, and to provide firing support for the rank and file. Your power armor lacks the protects the full working sets have, but you have trained with it and can use it in battle well. General Oliver praises you and your other Heavy Troopers, prove to him you're no exception to the rule."
	supervisors = "Sergeant First Class and above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_HEAVYTROOPER
	outfit = /datum/outfit/job/ncr/f13heavytrooper
	exp_requirements = 750

/datum/outfit/job/ncr/f13heavytrooper
	name = "NCR Heavy Trooper"
	jobtype = /datum/job/ncr/f13heavytrooper
	id 				= /obj/item/card/id/dogtag/ncrsergeant
	uniform 		= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	accessory		= /obj/item/clothing/accessory/ncr/SGT
	gloves			= /obj/item/clothing/gloves/f13/military
	head 			= /obj/item/clothing/head/helmet/f13/power_armor/ncr_t45b
	glasses			= /obj/item/clothing/glasses/sunglasses/big
	neck 			= /obj/item/storage/belt/holster
	suit 			= /obj/item/clothing/suit/armor/f13/power_armor/ncr
	suit_store		= /obj/item/gun/ballistic/automatic/r84
	belt			= /obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/storage/bag/money/small/ncrofficers, \
		/obj/item/ammo_box/magazine/lmg=1, \
		/obj/item/binoculars=1)

/datum/outfit/job/ncr/f13logisticsofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/*
Corporal
*/
/datum/job/ncr/f13corporal
	title = "NCR Corporal"
	flag = F13CORPORAL
	total_positions = 3
	spawn_positions = 3
	description = "You are a junior NCO. You are tasked with organizing the enlisted ranks into fireteams and answer directly to a Sergeant and/or the Sergeant First Class."
	supervisors = "Sergeant and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_CORPORAL
	outfit = /datum/outfit/job/ncr/f13corporal

	loadout_options = list(
	/datum/outfit/loadout/corporaldesignatedmarksman,
	/datum/outfit/loadout/corporalspotter,
	/datum/outfit/loadout/corporalrifleman
	)

/datum/outfit/job/ncr/f13corporal
	name = "NCR Corporal"
	jobtype 		= /datum/job/ncr/f13corporal
	uniform 		= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	id 				= /obj/item/card/id/dogtag/ncrtrooper
	neck 			= /obj/item/storage/belt/holster
	accessory 		= /obj/item/clothing/accessory/ncr/CPL
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/mantle
	belt 			= /obj/item/storage/belt/military/assault/ncr
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1 \
		)

/datum/outfit/loadout/corporaldesignatedmarksman
	name = "Designated marksman"
	suit_store = /obj/item/gun/ballistic/shotgun/remington/ncr
	head = /obj/item/clothing/head/beret/ncr_recon/worn
	backpack_contents = list(
		/obj/item/attachments/scope=1,
		/obj/item/ammo_box/a308=4, \
		/obj/item/storage/box/ration/menu_two=1,
		)

/datum/outfit/loadout/corporalspotter
	name = "Spotter"
	suit_store = /obj/item/gun/ballistic/automatic/service/carbine
	head = /obj/item/clothing/head/beret/ncr_recon/worn
	backpack_contents = list(
		/obj/item/storage/box/ration/menu_eight=1, 
		/obj/item/binoculars=1,
		/obj/item/ammo_box/magazine/m556/rifle/assault=1)

/datum/outfit/loadout/corporalrifleman
	name = "Assistant Squad Leader"
	head = /obj/item/clothing/head/f13/ncr
	suit_store = /obj/item/gun/ballistic/automatic/service
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault=2, \
		/obj/item/storage/box/ration/menu_one=1)


/datum/job/ncr/f13combatmedic
	title = "NCR Combat Medic"
	flag = F13COMBATMEDIC
	total_positions = 1
	spawn_positions = 1
	description = "You are a veteran enlisted with a medical skill set. You work closely with your squad, taking orders from your officers. You have the authority to command troopers if there are none present."
	supervisors = "Corporals and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_COMBATMEDIC
	outfit = /datum/outfit/job/ncr/f13combatmedic

/datum/outfit/job/ncr/f13combatmedic
	name = "NCR Combat Medic"
	jobtype 		= /datum/job/ncr/f13combatmedic
	uniform 		= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	id 				= /obj/item/card/id/dogtag/ncrtrooper
	neck 			= /obj/item/storage/belt/holster
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	belt 			= /obj/item/storage/belt/military/assault/ncr
	head			= /obj/item/clothing/head/f13/ncr/steelpot_med
	gloves			= /obj/item/clothing/gloves/color/latex/nitrile
	accessory		= /obj/item/clothing/accessory/armband/med/ncr
	suit_store		= /obj/item/gun/ballistic/automatic/service
	mask 			= /obj/item/clothing/mask/surgical
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid_adv=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1, \
		/obj/item/ammo_box/magazine/m556/rifle=1, \
		/obj/item/storage/firstaid/regular=1
		)

/datum/outfit/job/ncr/f13combatmedic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)

/*
Combat Engineer
*/

/datum/job/ncr/f13combatengineer
	title = "NCR Combat Engineer"
	flag = F13COMBATENGINEER
	total_positions = 3
	spawn_positions = 3
	description = "You are a veteran enlisted with an engineering skill set. You work closely with your squad, taking orders from your officers. You have the authority to command troopers if there are none present."
	supervisors = "Corporals and above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_COMBATENGINEER
	outfit = /datum/outfit/job/ncr/f13combatengineer

	loadout_options = list(
		/datum/outfit/loadout/combatengineerbuilder,
		/datum/outfit/loadout/combatengineertrapper,
		/datum/outfit/loadout/combatengineerflamethrower
		)

	/*	/obj/item/ammo_box/magazine/m556/rifle=1, \
		/obj/item/grenade/plastic=1, \
		/obj/item/stack/sheet/metal/fifty=1, \
		/obj/item/stack/sheet/glass/fifty=1*/

/datum/outfit/job/ncr/f13combatengineer
	name = "NCR Combat Engineer"
	jobtype 		= /datum/job/ncr/f13combatengineer
	uniform 		= /obj/item/clothing/under/f13/ncr
	shoes 			= /obj/item/clothing/shoes/f13/military/ncr
	id 				= /obj/item/card/id/dogtag/ncrtrooper
	neck 			= /obj/item/storage/belt/holster
	head			= /obj/item/clothing/head/f13/ncr
	suit 			= /obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	gloves			= /obj/item/clothing/gloves/color/yellow
	accessory		= /obj/item/clothing/accessory/ncr/SPC
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1 \
		)

/datum/outfit/loadout/combatengineerbuilder	
	name = "Construction Specialist"
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/m1n 
	head = /obj/item/clothing/head/f13/ncr/goggles
	belt = /obj/item/storage/belt/military/assault/ncr/engineer
	glasses	= /obj/item/clothing/glasses/welding
	backpack_contents = list(
		/obj/item/grenade/plastic=1, \
		/obj/item/stack/sheet/metal/fifty=1, \
		/obj/item/stack/sheet/glass/fifty=1, \
		/obj/item/ammo_box/magazine/m10mm_adv/ext=2  \
		)

/datum/outfit/loadout/combatengineertrapper
	name = "Trapper"
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/m1n
	head = /obj/item/clothing/head/f13/ncr
	belt = /obj/item/storage/belt/military/assault/ncr/engineer
	glasses	= /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv=2, \
		/obj/item/book/granter/crafting_recipe/blueprint/trapper=1, \
		/obj/item/stack/sheet/metal/twenty=1 \
		)

/datum/outfit/loadout/combatengineerflamethrower
	name = "Combat Sapper"
	suit_store = /obj/item/gun/ballistic/automatic/greasegun
	head = /obj/item/clothing/head/f13/ncr/goggles
	belt = /obj/item/storage/belt/military/assault/ncr
	glasses	= /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(
		/obj/item/ammo_box/magazine/greasegun=2, \
		/obj/item/m2flamethrowertank=1
		)


/datum/outfit/job/ncr/f13combatengineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/R82)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/marksmancarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lmg)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/scoutcarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1garand)
	ADD_TRAIT(H, TRAIT_MASTER_GUNSMITH, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/*
Trooper
*/

/datum/job/ncr/f13trooper
	title = "NCR Trooper"
	flag = F13TROOPER
	total_positions = 8
	spawn_positions = 8
	description = "You are considered the backbone and workforce strength of the NCR Army. You answer to everyone above you in the chain of command, taking orders from your Sergeant directly and obeying all commands given by the Lieutenant."
	supervisors = "Corporals and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13trooper

	loadout_options = list(
	/datum/outfit/loadout/trooperrifleman,
	/datum/outfit/loadout/trooperpathfinder,
	/datum/outfit/loadout/trooperfiresupport
	)

/datum/outfit/job/ncr/f13trooper
	name = "NCR Trooper"
	jobtype = /datum/job/ncr/f13trooper
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	uniform =  		/obj/item/clothing/under/f13/ncr
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr
	accessory =     /obj/item/clothing/accessory/ncr/TPR
	head = 			/obj/item/clothing/head/f13/ncr
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor
	belt =          /obj/item/storage/belt/military/assault/ncr
	glasses = 		null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrenlisted)


/datum/outfit/loadout/trooperrifleman
	name = "Rifleman"
	suit_store = /obj/item/gun/ballistic/automatic/varmint //Service rifle is dead, long live the varmint rifle! Higher tier roles still get the Service Rifle.
	backpack_contents = list(
		/obj/item/storage/box/ration/menu_two=1,
		/obj/item/ammo_box/magazine/m556/rifle=1)

/datum/outfit/loadout/trooperpathfinder
	name = "Pathfinder"
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/m1n //Generally worse weapon, though can be upgraded
	backpack_contents = list(
		/obj/item/book/granter/trait/trekking=1, //You get a worse weapon, but are good at scouting. Hence "Pathfinder."
		/obj/item/storage/box/ration/menu_eight=1,
		/obj/item/ammo_box/magazine/m10mm_adv/ext=1)

/datum/outfit/loadout/trooperfiresupport
	name = "Fire Support"
	suit_store = /obj/item/gun/ballistic/automatic/sten //Barely better then a pipe gun but you get a pretty rapid burst fire. Intended for suppression/CQC
	backpack_contents = list(
		/obj/item/storage/box/ration/menu_one=1,
		/obj/item/ammo_box/magazine/uzim9mm=1)



//MP

/datum/job/ncr/f13mp
	title = "NCR Military Police"
	flag = F13MP
	total_positions = 2
	spawn_positions = 2
	description = "You are tasked with the supervision of the NCRA to maintain internal order and disciplice and to prevent any warcrimes from happening."
	supervisors = "the Captain"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13mp
	exp_requirements = 300

/datum/outfit/job/ncr/f13mp
	name = "NCR Military Police"
	jobtype = /datum/job/ncr/f13mp
	id = 			/obj/item/card/id/dogtag/ncrsergeant
	uniform =  		/obj/item/clothing/under/f13/ncr
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr
	accessory =     /obj/item/clothing/accessory/armband/black
	head = 			/obj/item/clothing/head/f13/ncr/steelpot_mp
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor
	belt =          /obj/item/storage/belt/military/assault/ncr
	suit_store =    /obj/item/melee/classic_baton/telescopic
	glasses = 		null
	r_pocket = 		/obj/item/binoculars

	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrofficers, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1)

/*
Rear Echelon
*/

/datum/job/ncr/f13rearechelon
	title = "NCR Rear Echelon"
	flag = F13REARECHELON
	total_positions = 4
	spawn_positions = 4
	description = "You are the support element sent to assist the Camp Miller garrison. You are essential specialized support staff to help sustain the base via supply or your specialized skills. You are not allowed to leave base unless given an explicit order by the CO or the current acting CO."
	supervisors = "Corporals and above"
	selection_color = "#fff5cc"
	exp_type = EXP_TYPE_NCR
	display_order = JOB_DISPLAY_ORDER_REAR_ECHELON
	outfit = /datum/outfit/job/ncr/f13rearechelon

	loadout_options = list(
	/datum/outfit/loadout/rearlog,
	/datum/outfit/loadout/reartech,
	/datum/outfit/loadout/rearcorps,
	/datum/outfit/loadout/rearscav,
	/datum/outfit/loadout/offduty
	)

/datum/outfit/job/ncr/f13rearechelon
	name = "NCR Rear Echelon"
	jobtype = /datum/job/ncr/f13rearechelon
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	uniform =  		/obj/item/clothing/under/f13/ncr
	shoes = 		/obj/item/clothing/shoes/f13/military/ncr
	accessory =     /obj/item/clothing/accessory/ncr/TPR
	head = 			/obj/item/clothing/head/f13/ncr_cap
	suit = 			/obj/item/clothing/suit/armor/f13/ncrarmor
	glasses = 		null
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrenlisted=1, \
		)

//Supply and base management
/datum/outfit/loadout/rearlog
	name = "Logistics"
	backpack_contents = list(
		/obj/item/book/granter/trait/tinkering=1, \
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3)

//Technical repairs and engineering
/datum/outfit/loadout/reartech
	name = "Technician"
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/color/yellow
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3)

//Medical
/datum/outfit/loadout/rearcorps
	name = "Corpsman"
	belt = /obj/item/storage/belt/medical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/ammo_box/magazine/m9mm=3, \
		/obj/item/book/granter/trait/chemistry=1)

//Guard duty
/datum/outfit/loadout/rearscav
	name = "Scavenger"
	head = /obj/item/clothing/head/f13/ncr
	belt = /obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/metaldetector=1, \
		/obj/item/shovel/spade=1, \
		/obj/item/gun/ballistic/shotgun/hunting=1, \
		/obj/item/storage/fancy/ammobox/lethalshot=2, \
		/obj/item/weldingtool/largetank)

/datum/outfit/loadout/offduty //Fuck having an entire role just for off duty, making it a rear-eche loadout
	name = "Off-Duty"
	belt = /obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil=1, \
		/obj/item/reagent_containers/food/snacks/cheesyburrito=2, \
		/obj/item/reagent_containers/food/drinks/bottle/f13nukacola=1, \
		/obj/item/ammo_box/magazine/m9mm=3)


/*
Trooper
*/

/datum/job/ncr/f13ncroffduty
	title = "NCR Off-Duty"
	flag = F13NCROFFDUTY
	total_positions = 0 //Again not commenting out, but it's been moved to a rear echelon loadout
	spawn_positions = 0
	description = "You are off-duty NCR-A personnel in the Yuma Region. Despite being out of uniform and off-duty you are still expected to follow NCR COMJ and represent the uniform properly. Failure to abide by this will result in disciplinary action."
	supervisors = "All NCOs and COs"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_NCR_OFF_DUTY
	outfit = /datum/outfit/job/ncr/f13ncroffduty

/datum/outfit/job/ncr/f13ncroffduty
	name = "NCR Off-Duty"
	jobtype = /datum/job/ncr/f13ncroffduty
	id = 			/obj/item/card/id/dogtag/ncrtrooper
	uniform =  		/obj/item/clothing/under/f13/ncr
	shoes =			/obj/item/clothing/shoes/f13/military/ncr
	backpack_contents = list(
		/obj/item/kitchen/knife/combat=1, \
		/obj/item/storage/survivalkit_aid=1, \
		/obj/item/storage/bag/money/small/ncrenlisted, \
		/obj/item/clothing/mask/ncr_facewrap)

/*
Veteran Ranger
*/

/datum/job/ncr/f13vetranger
	title = "NCR Veteran Ranger"
	flag = F13VETRANGER
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Captain, working either independently or in a team to complete your mission objectives however required, operating either alone, in a squad or with the NCR Army. Your primary mission is to improve general opinion of the Republic and to neutralize slavers and raiders operating in the area."
	supervisors = "Captain and above"
	selection_color = "#ffeeaa"
	display_order = JOB_DISPLAY_ORDER_VETRANGE
	outfit = /datum/outfit/job/ncr/f13vetranger
	exp_requirements = 1500

	loadout_options = list(
	/datum/outfit/loadout/vrclassic, //AMR and Sequoia,
	/datum/outfit/loadout/vrlite, //Rangemaster and Sequoia,
	/datum/outfit/loadout/vrcqc //R91 and a MK23 instead of a Sequoia
	)

/datum/outfit/job/ncr/f13vetranger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	var/datum/martial_art/rangertakedown/RT = new
	RT.teach(H)

/datum/outfit/job/ncr/f13vetranger
	name = "NCR Veteran Ranger"
	jobtype = /datum/job/ncr/f13vetranger
	id = 			/obj/item/card/id/dogtag/ncrvetranger
	uniform =  		/obj/item/clothing/under/f13/ranger/vet
	suit = 			/obj/item/clothing/suit/armor/f13/rangercombat
	belt =			/obj/item/storage/belt/military/assault/ncr
	head = 			/obj/item/clothing/head/helmet/f13/ncr/rangercombat
	gloves =		/obj/item/clothing/gloves/rifleman
	shoes =			/obj/item/clothing/shoes/f13/military/leather
	glasses = 		/obj/item/clothing/glasses/sunglasses
	neck = 			/obj/item/storage/belt/holster
	ears = 			/obj/item/radio/headset/headset_ranger
	r_pocket = 		/obj/item/binoculars
	backpack_contents = list(
		/obj/item/kitchen/knife/bowie=1, \
		/obj/item/storage/survivalkit_aid_adv=1, \
		/obj/item/storage/bag/money/small/ncr=1)

/datum/outfit/loadout/vrclassic
	name = "Classic Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/shotgun/antimateriel
	backpack_contents = list(
		/obj/item/ammo_box/a50MG=2,
		/obj/item/gun/ballistic/revolver/sequoia=1,
		/obj/item/ammo_box/c4570=1)

/datum/outfit/loadout/vrlite
	name = "Light Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/automatic/rangemaster
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m762/ext=1,
		/obj/item/gun/ballistic/revolver/sequoia=1,
		/obj/item/ammo_box/c4570=1)


/datum/outfit/loadout/vrcqc
	name = "Close Quarters Combat Ranger"
	suit_store = /obj/item/gun/ballistic/automatic/commando/ranger
	backpack_contents = list(
		/obj/item/ammo_box/magazine/greasegun=3, \
		/obj/item/gun/ballistic/revolver/sequoia=1,
		/obj/item/ammo_box/c4570=2)


//NCR Ranger
/datum/job/ncr/f13ranger
	title = "NCR Ranger"
	flag = F13RANGER
	total_positions = 4
	spawn_positions = 5
	description = "As an NCR Ranger, you are the premier special forces unit of the NCR. You are the forward observations and support the Army in it's campaigns, as well as continuing the tradition of stopping slavery in it's tracks."
	supervisors = "Veteran Ranger"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_RANGER
	outfit = /datum/outfit/job/ncr/f13ranger
	exp_requirements = 600

	loadout_options = list(
	/datum/outfit/loadout/rangerrecon,
	/datum/outfit/loadout/rangertrail,
	/datum/outfit/loadout/rangerpatrol,
	/datum/outfit/loadout/rangerpatrolcqb
	)

/datum/outfit/job/ncr/f13ranger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	var/datum/martial_art/rangertakedown/RT = new
	RT.teach(H)

/datum/outfit/job/ncr/f13ranger
	name = "NCR Ranger"
	jobtype = /datum/job/ncr/f13ranger
	id = 			/obj/item/card/id/dogtag/ncrranger
	uniform = 		/obj/item/clothing/under/f13/ranger/trail
	head =			/obj/item/clothing/head/f13/trailranger
	gloves =		/obj/item/clothing/gloves/patrol
	shoes =			/obj/item/clothing/shoes/f13/military/leather
	glasses = 		/obj/item/clothing/glasses/sunglasses
	ears = 			/obj/item/radio/headset/headset_ranger
	r_pocket = 		/obj/item/binoculars
	neck = 			/obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/restraints/handcuffs=1, \
		/obj/item/kitchen/knife/bowie=1, \
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/clothing/mask/gas/ranger = 1)

/datum/outfit/loadout/rangerrecon
	name = "Recon Ranger"
	suit =	/obj/item/clothing/suit/toggle/armor/f13/rangerrecon
	belt =	/obj/item/storage/belt/military/reconbandolier
	head = /obj/item/clothing/head/beret/ncr_recon_ranger
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper
	neck = /obj/item/clothing/neck/cloak/ranger
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308 = 3,
		/obj/item/storage/survivalkit_aid=1,
		/obj/item/gun/ballistic/revolver/revolver45=1,
		/obj/item/ammo_box/c45rev=2

	)

/datum/outfit/loadout/rangertrail
	name = "Trail Ranger"
	suit =	/obj/item/clothing/suit/armor/f13/trailranger
	belt =	/obj/item/storage/belt/military/NCR_Bandolier
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail
	neck = /obj/item/clothing/neck/cloak/ranger
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44 = 3,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/storage/survivalkit_aid=1,
		/obj/item/attachments/scope=1,
		/obj/item/gun/ballistic/revolver/colt357=2,
		/obj/item/ammo_box/a357=4
	)

/datum/outfit/loadout/rangerpatrol
	name = "Patrol Ranger"
	suit = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	head = /obj/item/clothing/head/f13/ranger
	uniform = /obj/item/clothing/under/f13/ranger/patrol
	belt =	/obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/automatic/service/carbine
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/assault = 1,
		/obj/item/clothing/head/helmet/f13/combat/ncr_patrol = 1,
		/obj/item/storage/survivalkit_aid = 1,
		/obj/item/attachments/scope = 1,
		/obj/item/gun/ballistic/revolver/revolver44 = 1,
		/obj/item/ammo_box/m44=2
	)

/datum/outfit/loadout/rangerpatrolcqb
	name = "CQB Patrol Ranger"
	suit = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	head = /obj/item/clothing/head/f13/ranger
	uniform = /obj/item/clothing/under/f13/ranger/patrol
	belt =	/obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/auto5
	backpack_contents = list(
		/obj/item/storage/fancy/ammobox/lethalshot = 1,
		/obj/item/storage/fancy/ammobox/slugshot = 1,
		/obj/item/clothing/head/helmet/f13/combat/ncr_patrol = 1,
		/obj/item/storage/survivalkit_aid = 1,
		/obj/item/gun/ballistic/revolver/m29/snub=1,
		/obj/item/ammo_box/m44box=1
	)

/datum/outfit/loadout/rangermedic
	name = "Medic Ranger"
	suit = /obj/item/clothing/suit/armor/f13/combat/ncr_patrol
	head = /obj/item/clothing/head/f13/ranger
	uniform = /obj/item/clothing/under/f13/ranger/patrol
	belt =	/obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/automatic/smg10mm
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/ext = 3,
		/obj/item/storage/firstaid/ancient = 1,
		/obj/item/clothing/accessory/armband/med/ncr = 1,
		/obj/item/clothing/head/helmet/f13/combat/ncr_patrol = 1,
		/obj/item/storage/survivalkit_aid_adv = 1,
		/obj/item/book/granter/trait/chemistry = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911/compact=1,
		/obj/item/ammo_box/magazine/m45=3,
		/obj/item/book/granter/trait/midsurgery=1
	)
