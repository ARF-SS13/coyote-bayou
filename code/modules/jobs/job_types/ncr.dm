/*
NCR Design notes:
Standard issue stuff to keep the theme visually and gameplay and avoid watering down.
Gloves		Officers - Leather glovesl, fingerless leather gloves for sergeants. Bayonet standard issue knife. Sidearms mostly for officers, 9mm is the standard. MP gets nonstandard pot helm, the exception to prove the rule.
			NCOs -		Fingerless gloves
			Rest -		No gloves
Knives		Army -		Bayonet
			Ranger -	Bowie knife
Money		Commanding Officer (LT and CAP) - "small" money bag
			Officers and Rangers - /obj/item/storage/bag/money/small/ncrofficers
			Rest - /obj/item/storage/bag/money/small/ncrenlisted
Sidearm		Officers & a few specialists - 9mm pistol
Weapons		Service Rifle, Grease Gun, 9mm pistol, all good.
			Don't use Greaseguns, Lever shotguns, Police shotguns, Berettas, Hunting knives
*/

/datum/job/ncr //do NOT use this for anything, it's just to store faction datums
	department_flag = NCR
	selection_color = "#ffeeaa"
	faction = FACTION_NCR
	exp_type = EXP_TYPE_NCR

	access = list(ACCESS_NCR)
	minimal_access = list(ACCESS_NCR)
	forbids = "The NCR forbids: Chem and drug use such as jet or alcohol while on duty. Execution of unarmed or otherwise subdued targets without authorisation."
	enforces = "The NCR expects: Obeying the lawful orders of superiors. Proper treatment of prisoners.  Good conduct within the Republic's laws. Wearing the uniform."
	objectivesList = list("Leadership recommends the following goal for this week: Establish an outpost at the radio tower","Leadership recommends the following goal for this week: Neutralize and capture dangerous criminals", "Leadership recommends the following goal for this week: Free slaves and establish good relations with unaligned individuals.")

/datum/outfit/job/ncr
	name = "NCRdatums"
	jobtype = /datum/job/ncr
	backpack = /obj/item/storage/backpack/trekker
	satchel = /obj/item/storage/backpack/satchel/trekker
	ears = /obj/item/radio/headset/headset_ncr
	uniform	= /obj/item/clothing/under/f13/ncr
	belt = /obj/item/storage/belt/military/assault/ncr
	shoes = /obj/item/clothing/shoes/f13/military/ncr
	l_pocket = /obj/item/book/manual/ncr/jobguide
	backpack_contents = list(
		/obj/item/storage/survivalkit_aid = 1,
		)

/datum/outfit/job/ncr/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrgate)


///////////////////////
/// Colonel - Admin ///
///////////////////////

// COLONEL

/datum/job/ncr/f13colonel
	title = "NCR Colonel"
	flag = F13COLONEL
	head_announce = list("Security")
	supervisors = "The Republic Senate, High Command"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_CHANGE_IDS, ACCESS_NCR_COMMAND)
	req_admin_notify = 1

	total_positions = 0
	spawn_positions = 0

	outfit = /datum/outfit/job/ncr/f13colonel

/datum/outfit/job/ncr/f13colonel/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_PA_WEAR, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/ncr/f13colonel	// Sierra Power Armor, , Desert Eagle
	name = "NCR Colonel"
	jobtype = /datum/job/ncr/f13colonel
	id = /obj/item/card/id/dogtag/ncrcolonel
	uniform	= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes = /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory = /obj/item/clothing/accessory/ncr
	head = /obj/item/clothing/head/beret/ncr/ncr_sof
	neck = /obj/item/storage/belt/holster/legholster
	glasses = /obj/item/clothing/glasses/sunglasses/big
	gloves = /obj/item/clothing/gloves/f13/leather
	suit = /obj/item/clothing/suit/armor/power_armor/t45d/sierra
	r_pocket = /obj/item/binoculars
	suit_store = /obj/item/gun/ballistic/automatic/pistol/deagle
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m44 = 3,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/megaphone = 1,
		)

// PERSONAL AIDE		The Colonels flagbearer and personal aide, for events only to help the Colonel and add color.

/datum/job/ncr/f13aide
	title = "NCR Personal Aide"
	flag = F13COLONEL
	supervisors = "The Colonel"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	req_admin_notify = 1
	total_positions = 0
	spawn_positions = 0
	outfit = /datum/outfit/job/ncr/f13aide

/datum/outfit/job/ncr/f13aide/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/ncr/f13aide	// NCR Flag, Desert Eagle
	name = "NCR Personal Aide"
	jobtype = /datum/job/ncr/f13aide
	id = /obj/item/card/id/dogtag/ncrtrooper
	accessory = /obj/item/clothing/accessory/ncr/CPL
	shoes = /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	head = /obj/item/clothing/head/f13/ncr
	neck = /obj/item/storage/belt/holster/legholster
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	suit = /obj/item/clothing/suit/armor/ncrarmor/captain
	suit_store = /obj/item/gun/ballistic/automatic/pistol/deagle
	r_hand = /obj/item/melee/onehanded/club/ncrflag
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m44 = 2,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)


/////////////////////////////////
/// Combat Officers & Leaders ///
/////////////////////////////////

// CAPTAIN

/datum/job/ncr/f13captain
	title = "NCR Captain"
	flag = F13CAPTAIN
	head_announce = list("Security")
	total_positions = 1
	spawn_positions = 1
	description = "You are the commanding officer of your company and direct superior to the Veteran Ranger and Lieutenant. Coordinating with your staff, you must ensure that the objectives of High Command are completed to the letter. Working closely with your subordinates on logistics, mission planning and special operations with the Rangers, you are here to establish a strong foothold for the NCR within the region."
	supervisors = "Colonel"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_CHANGE_IDS, ACCESS_NCRREP, ACCESS_NCR_COMMAND)
	req_admin_notify = 1
	display_order = JOB_DISPLAY_ORDER_CAPTAIN_NCR
	outfit = /datum/outfit/job/ncr/f13captain
	exp_requirements = 1900

	loadout_options = list(
		/datum/outfit/loadout/captainbackline,	// Infiltrator, El Capitan
		/datum/outfit/loadout/captainfrontline, // Pancor Jackhammer, The Court Martial, Desert Eagle
		)

/datum/outfit/job/ncr/f13captain/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)
	if(H.mind)
		var/obj/effect/proc_holder/spell/terrifying_presence/S = new /obj/effect/proc_holder/spell/terrifying_presence
		H.mind.AddSpell(S)

/datum/outfit/job/ncr/f13captain	// Binoculars, Trench knife
	name = "NCR Captain"
	jobtype = /datum/job/ncr/f13captain
	id = /obj/item/card/id/dogtag/ncrcaptain
	uniform	= /obj/item/clothing/under/f13/ncr/ncr_officer
	head = /obj/item/clothing/head/beret/ncr
	glasses = /obj/item/clothing/glasses/sunglasses/big
	ears = /obj/item/radio/headset/headset_ncr_com
	glasses = /obj/item/clothing/glasses/night/ncr
	gloves = /obj/item/clothing/gloves/f13/leather
	shoes = /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory = /obj/item/clothing/accessory/ncr/CPT
	mask = /obj/item/clothing/mask/cigarette/pipe
	neck = /obj/item/storage/belt/holster/legholster
	r_pocket = /obj/item/binoculars
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/megaphone = 1,
		/obj/item/grenade/syndieminibomb/concussion = 2,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 3,
		/obj/item/lighter = 1,
		/obj/item/reagent_containers/food/snacks/grown/tobacco/dried = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/loadout/captainbackline
	name = "El Capitan"
	suit_store = /obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	backpack_contents = list(
		/obj/item/clothing/suit/armor/ncrarmor/captain/ncr_officer_coat = 1,
		/obj/item/ammo_box/magazine/m556/rifle/extended = 1,
		/obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan = 1,
		/obj/item/ammo_box/magazine/m14mm = 3,
		/obj/item/storage/box/ration/menu_two = 1,
		/obj/item/melee/onehanded/knife/trench = 1,
		)

/datum/outfit/loadout/captainfrontline
	name = "The Court Martial"
	suit_store = /obj/item/gun/ballistic/automatic/shotgun/pancor
	backpack_contents = list(
		/obj/item/clothing/suit/armor/ncrarmor/captain = 1,
		/obj/item/gun/ballistic/automatic/pistol/deagle = 1,
		/obj/item/ammo_box/magazine/d12g = 3,
		/obj/item/twohanded/sledgehammer/rockethammer/courtmartial = 1,
		/obj/item/storage/box/ration/menu_eight = 1,
		)


// LIEUTENANT

/datum/job/ncr/f13lieutenant
	title = "NCR Lieutenant"
	flag = F13LIEUTENANT
	total_positions = 1
	spawn_positions = 1
	description = "You are the direct superior to the NCOs and Enlisted, and under special circumstances, Rangers. You are the XO of Camp Miller. You plan patrols, training and missions, working in some cases with Rangers in accomplishing objectives otherwise beyond the capabilities of ordinary enlisted personnel."
	supervisors = "Captain"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_CHANGE_IDS, ACCESS_NCR_COMMAND)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_LIEUTENANT
	outfit = /datum/outfit/job/ncr/f13lieutenant
	exp_requirements = 1250

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
		),
	)

/datum/outfit/job/ncr/f13lieutenant		// Republic's Pride, Binoculars, Bayonet, M1911 custom
	name = "NCR Lieutenant"
	jobtype	= /datum/job/ncr/f13lieutenant
	id = /obj/item/card/id/dogtag/ncrlieutenant
	uniform	= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes =	/obj/item/clothing/shoes/f13/military/ncr_officer_boots
	accessory = /obj/item/clothing/accessory/ncr/LT1
	head = /obj/item/clothing/head/beret/ncr
	neck = /obj/item/storage/belt/holster/legholster
	glasses = /obj/item/clothing/glasses/night/ncr
	gloves = /obj/item/clothing/gloves/f13/leather
	ears = /obj/item/radio/headset/headset_ncr_com
	suit = /obj/item/clothing/suit/armor/ncrarmor/lieutenant
	r_pocket = /obj/item/binoculars
	suit_store = /obj/item/gun/ballistic/automatic/m1garand/republicspride
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/ammo_box/magazine/garand308 = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 3,
		/obj/item/grenade/syndieminibomb/concussion = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/job/ncr/f13lieutenant/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)


// SERGEANT

/datum/job/ncr/f13sergeant
	title = "NCR Sergeant"
	flag = F13SERGEANT
	total_positions = 3
	spawn_positions = 3
	description = "You are the direct superior to the enlisted troops, working with the chain of command you echo the orders of your superiors and ensure that the enlisted follow them to the letter. Additionally, you are responsible for the wellbeing of the troops and their ongoing training with the NCR."
	supervisors = "Sergeant First Class and Above"
	selection_color = "#fff5cc"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	display_order = JOB_DISPLAY_ORDER_SERGEANT
	outfit = /datum/outfit/job/ncr/f13sergeant
	exp_requirements = 500

	loadout_options = list( // ALL: Bayonet, M1911 sidearm
		/datum/outfit/loadout/sergeantrifleman,	// Worn Assault Carbine
		/datum/outfit/loadout/sergeantrecon, // Scout Carbine, Trekking
		/datum/outfit/loadout/sergeantcqc, // Trench Shotgun, Gas mask, Smoke bombs, Trench knife
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
		),
		)

/datum/outfit/job/ncr/f13sergeant/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)


/datum/outfit/job/ncr/f13sergeant
	name = "NCR Sergeant"
	jobtype = /datum/job/ncr/f13sergeant
	id = /obj/item/card/id/dogtag/ncrsergeant
	accessory = /obj/item/clothing/accessory/ncr/SGT
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced
	neck = /obj/item/storage/belt/holster/legholster
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/grenade/f13/frag = 1,
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/loadout/sergeantrifleman
	name = "Lead Rifleman"
	suit_store = /obj/item/gun/ballistic/automatic/assault_carbine/worn
	head = /obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m5mm = 2,
		/obj/item/storage/box/ration/menu_two = 1,
		/obj/item/melee/onehanded/knife/bowie = 1,
		/obj/item/flashlight/seclite = 1,
		)

/datum/outfit/loadout/sergeantrecon
	name = "Recon Squad Leader"
	suit_store = /obj/item/gun/ballistic/automatic/service/carbine
	head = /obj/item/clothing/head/f13/ncr
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/extended = 2,
		/obj/item/storage/box/ration/menu_eight = 1,
		/obj/item/attachments/scope = 1,
		/obj/item/book/granter/trait/trekking = 1,
		)

/datum/outfit/loadout/sergeantcqc
	name = "Trench Raider"
	suit_store = /obj/item/gun/ballistic/shotgun/trench //Over thereee over thereeeee spread the spread the word over thereeee
	head = /obj/item/clothing/head/f13/ncr/steelpot_goggles/trenchraider
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/clothing/mask/gas = 1,
		/obj/item/grenade/smokebomb = 2,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced/trenchraider = 1,
		)

// DRILL SERGEANT

/datum/job/ncr/f13drillsergeant
	title = "NCR Senior Enlisted Advisor"
	flag = F13DRILLSERGEANT
	total_positions = 1
	spawn_positions = 1
	description = "The direct superior to all enlisted, you are to provide training exercises, maintain military discipline, and instill orderliness within the ranks. You may also manage the NCOs. You are the pinnacle of the NCR's enlisted ranks, and are to advise the commissioned officers. You are not a frontline trooper, you are camp support."
	supervisors = "Lieutenant and Above"
	selection_color = "#fff5cc"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	display_order = JOB_DISPLAY_ORDER_SERGEANT
	outfit = /datum/outfit/job/ncr/f13drillsergeant
	exp_requirements = 1000

	loadout_options = list( // ALL: Bayonet
		/datum/outfit/loadout/seatechnical,
		/datum/outfit/loadout/seacommand,
		/datum/outfit/loadout/seastaff,
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
		),
		)


/datum/outfit/job/ncr/f13drillsergeant
	name = "NCR Senior Enlisted Advisor"
	jobtype = /datum/job/ncr/f13drillsergeant
	id = /obj/item/card/id/dogtag/ncrsergeant
	gloves = /obj/item/clothing/gloves/f13/leather
	head = /obj/item/clothing/head/f13/ncr/ncr_campaign
	shoes = /obj/item/clothing/shoes/f13/military/ncr_officer_boots
	glasses	= /obj/item/clothing/glasses/sunglasses
	head = /obj/item/clothing/head/f13/ncr/ncr_campaign
	neck = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/loadout/seatechnical
	name = "Technical Senior Advisor"
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/assault_carbine = 1,
		/obj/item/ammo_box/magazine/m5mm = 1,
		/obj/item/clothing/accessory/ncr/FSGT = 1
		)

/datum/outfit/loadout/seacommand
	name = "Command Senior Advisor"
	suit = /obj/item/clothing/suit/armor/ncrarmor/ncr_dressjack
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 1,
		/obj/item/ammo_box/a45lcbox = 1,
		/obj/item/binoculars = 1,
		/obj/item/clothing/accessory/ncr/FSGT = 1
		)

/datum/outfit/loadout/seastaff
	name = "Drill Sergeant"
	uniform = /obj/item/clothing/under/f13/ncr/ncr_dress
	suit = /obj/item/clothing/suit/armor/ncrarmor/ncr_dressjack
	backpack_contents = list(
		/obj/item/book/granter/trait/rifleman = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mmds = 2,
		/obj/item/clothing/accessory/ncr/SSGT = 1
		)


// REPRESENATIVE

/datum/job/ncr/f13representative
	title = "NCR Representative"
	flag = F13REP
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCRREP)
	total_positions = 1
	spawn_positions = 1
	description = "You are an influential representative for the NCR and experienced bureaucrat. You are here to further the objective and ensure the interests of the NCR, your company or own enterprise are met through thick and thin, and have been supplied with ample amounts of money to do so."
	supervisors = "The Captain and the NCR"
	display_order = JOB_DISPLAY_ORDER_REPRESENTATIVE
	outfit = /datum/outfit/job/ncr/f13representative
	exp_requirements = 750

	loadout_options = list(
		/datum/outfit/loadout/repbrahminbaron,
		/datum/outfit/loadout/repambassador,
		/datum/outfit/loadout/repexecutive
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr
			)
		)

/datum/outfit/job/ncr/f13representative
	name = "NCR Representative"
	uniform = /obj/item/clothing/under/f13/ncr/ncr_dress
	jobtype	= /datum/job/ncr/f13representative
	id = /obj/item/card/id/dogtag/ncrrep
	neck = /obj/item/storage/belt/holster/legholster
	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/ammo_box/c45rev = 2,
		/obj/item/storage/bag/money/small/ncr = 2,
		)

/datum/outfit/loadout/repbrahminbaron
	name = "Brahmin Baron"
	suit = /obj/item/clothing/under/suit/burgundy
	shoes = /obj/item/clothing/shoes/f13/cowboy
	head = /obj/item/clothing/head/helmet/f13/brahmincowboyhat
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/storage/box/ration/menu_two = 1
		)

/datum/outfit/loadout/repambassador
	name = "Ambassador"
	suit = /obj/item/clothing/under/rank/security/detective/grey
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		/obj/item/clothing/accessory/waistcoat = 1,
		/obj/item/clothing/suit/toggle/lawyer/black = 1,
		/obj/item/storage/briefcase = 1,
		)

/datum/outfit/loadout/repexecutive
	name = "Executive"
	suit = /obj/item/clothing/under/suit_jacket/tan
	shoes = /obj/item/clothing/shoes/laceup
	head = /obj/item/clothing/head/helmet/f13/rustedcowboyhat
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncr = 1,
		/obj/item/storage/box/ration/menu_two = 1
		)

///////////////
/// Rangers ///
///////////////

// VETERAN RANGER

/datum/job/ncr/f13vetranger
	title = "NCR Veteran Ranger"
	flag = F13VETRANGER
	total_positions = 1
	spawn_positions = 1
	description = "You answer directly to the Captain, working either independently or in a team to complete your mission objectives however required, operating either alone, in a squad or with the NCR Army. Your primary mission is to improve general opinion of the Republic and to neutralize slavers and raiders operating in the area."
	supervisors = "NCRA Captain, High Command"
	selection_color = "#ffeeaa"
	display_order = JOB_DISPLAY_ORDER_VETRANGE
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	outfit = /datum/outfit/job/ncr/f13vetranger
	exp_requirements = 1750

	loadout_options = list( // ALL: Binoculars, Bowie knife
		/datum/outfit/loadout/vrclassic, // AMR, Sequoia
		/datum/outfit/loadout/vrlite, // Brush, Sequoia
		/datum/outfit/loadout/vrshotgunner, // Winchester City-Killer, Sequoia
		/datum/outfit/loadout/vrcqc // 2 x .45 Long colt revolvers
		)

/datum/outfit/job/ncr/f13vetranger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_SILENT_STEP, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	var/datum/martial_art/rangertakedown/RT = new
	RT.teach(H)

/datum/outfit/job/ncr/f13vetranger
	name = "NCR Veteran Ranger"
	jobtype	= /datum/job/ncr/f13vetranger
	id = /obj/item/card/id/dogtag/ncrvetranger
	uniform	= /obj/item/clothing/under/f13/ranger/vet
	suit = /obj/item/clothing/suit/armor/rangercombat
	head = /obj/item/clothing/head/helmet/f13/ncr/rangercombat
	gloves = /obj/item/clothing/gloves/rifleman
	shoes =	/obj/item/clothing/shoes/f13/military/leather
	glasses	= /obj/item/clothing/glasses/sunglasses
	neck = /obj/item/storage/belt/holster
	ears = /obj/item/radio/headset/headset_ranger
	mask = /obj/item/clothing/mask/gas/ranger
	r_pocket = /obj/item/binoculars
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/bowie = 1,
		/obj/item/storage/survivalkit_aid_adv = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak/super = 2,
		/obj/item/grenade/smokebomb = 1,
		)

/datum/outfit/loadout/vrclassic
	name = "Classic Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/rifle/mag/antimateriel
	backpack_contents = list(
		/obj/item/ammo_box/magazine/amr = 2,
		/obj/item/gun/ballistic/revolver/sequoia = 1,
		/obj/item/ammo_box/c4570box/knockback = 1,
		/obj/item/ammo_box/magazine/amr/penetrator = 1,
		/obj/item/book/granter/trait/rifleman = 1,
		)

/datum/outfit/loadout/vrlite
	name = "Rifler Veteran Ranger"
	suit_store = /obj/item/gun/ballistic/rifle/repeater/brush
	backpack_contents = list(
		/obj/item/ammo_box/c4570 = 3,
		/obj/item/gun/ballistic/revolver/sequoia = 1,
		/obj/item/book/granter/trait/rifleman = 1,
		)

/datum/outfit/loadout/vrshotgunner
	name = "Veteran Ranger Shotgunner"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 3,
		/obj/item/ammo_box/shotgun/trainshot = 1,
		/obj/item/gun/ballistic/revolver/sequoia = 1,
		/obj/item/ammo_box/c4570box/knockback = 1,
		)

/datum/outfit/loadout/vrcqc
	name = "Gunslinger"
	mask = /obj/item/clothing/mask/cigarette/cigar/havana
	backpack_contents = list(
		/obj/item/book/granter/trait/gunslinger = 1,
		/obj/item/gun/ballistic/revolver/revolver45/gunslinger = 2,
		/obj/item/ammo_box/a45lcbox = 1,
		/obj/item/lighter = 1,
		)


// NCR Ranger

/datum/job/ncr/f13ranger
	title = "NCR Ranger"
	flag = F13RANGER
	total_positions = 3
	spawn_positions = 3
	description = "As an NCR Ranger, you are the premier special forces unit of the NCR. You are the forward observations and support the Army in it's campaigns, as well as continuing the tradition of stopping slavery in it's tracks."
	supervisors = "Veteran Ranger"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_RANGER
	outfit = /datum/outfit/job/ncr/f13ranger
	exp_requirements = 500

	loadout_options = list( // ALL: Binoculars, Bowie knife
	/datum/outfit/loadout/rangerrecon, // DKS Sniper rifle, .45 Revolver
	/datum/outfit/loadout/rangertrail, // Rangermaster, 2 x .357 Revolvers
	/datum/outfit/loadout/rangerpatrol, // R91 Assault Rifle, .44 SA Revolver
	/datum/outfit/loadout/rangerpatrolcqb, // 10mm SMG, .44 Snubnose revolver
	)

/datum/outfit/job/ncr/f13ranger/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	var/datum/martial_art/rangertakedown/RT = new
	RT.teach(H)


/datum/outfit/job/ncr/f13ranger
	name = "NCR Ranger"
	jobtype	= /datum/job/ncr/f13ranger
	id = /obj/item/card/id/dogtag/ncrranger
	uniform	= /obj/item/clothing/under/f13/ranger/trail
	head = /obj/item/clothing/head/f13/trailranger
	gloves = /obj/item/clothing/gloves/patrol
	shoes = /obj/item/clothing/shoes/f13/military/leather
	glasses	= /obj/item/clothing/glasses/sunglasses
	belt = null
	ears = /obj/item/radio/headset/headset_ranger
	r_pocket = /obj/item/binoculars
	neck = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/restraints/handcuffs = 1,
		/obj/item/melee/onehanded/knife/bowie = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/clothing/mask/gas/ranger = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/loadout/rangerrecon
	name = "Recon Ranger"
	suit = /obj/item/clothing/suit/toggle/armor/rangerrecon
	belt = /obj/item/storage/belt/military/reconbandolier
	head = /obj/item/clothing/head/beret/ncr_recon_ranger
	neck = /obj/item/clothing/neck/mantle/ranger
	suit_store = /obj/item/gun/ballistic/automatic/marksman/sniper/sniperranger
	backpack_contents = list(
		/obj/item/ammo_box/magazine/w308 = 3,
		/obj/item/gun/ballistic/revolver/revolver45 = 1,
		/obj/item/ammo_box/c45rev = 2,
		)

/datum/outfit/loadout/rangertrail
	name = "Trail Ranger"
	suit = /obj/item/clothing/suit/armor/trailranger
	belt = /obj/item/storage/belt/military/NCR_Bandolier
	neck = /obj/item/clothing/neck/mantle/ranger
	suit_store = /obj/item/gun/ballistic/automatic/rangemaster
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m762 = 3,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/attachments/scope = 1,
		/obj/item/gun/ballistic/revolver/colt357 = 2,
		/obj/item/ammo_box/a357=4,
		)

/datum/outfit/loadout/rangerpatrol
	name = "Patrol Ranger"
	suit = /obj/item/clothing/suit/armor/medium/combat/ncr_patrol
	head = /obj/item/clothing/head/f13/ranger
	uniform	= /obj/item/clothing/under/f13/ranger/patrol
	belt = /obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/automatic/assault_rifle
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle/extended = 1,
		/obj/item/clothing/head/helmet/f13/combat/ncr_patrol = 1,
		/obj/item/gun/ballistic/revolver/revolver44 = 1,
		/obj/item/ammo_box/m44 = 2,
		)

/datum/outfit/loadout/rangerpatrolcqb
	name = "CQB Patrol Ranger"
	suit = /obj/item/clothing/suit/armor/medium/combat/ncr_patrol
	head = /obj/item/clothing/head/f13/ranger
	uniform	= /obj/item/clothing/under/f13/ranger/patrol
	belt = /obj/item/storage/belt/military/assault/ncr
	suit_store = /obj/item/gun/ballistic/automatic/smg/smg10mm
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv = 2,
		/obj/item/clothing/head/helmet/f13/combat/ncr_patrol = 1,
		/obj/item/gun/ballistic/revolver/m29/snub = 1,
		/obj/item/ammo_box/m44box = 1,
		)


////////////////////
/// Specialists ////
////////////////////

// HEAVY TROOPER

/datum/job/ncr/f13heavytrooper
	title = "NCR Heavy Trooper"
	flag = F13HEAVYTROOPER
	total_positions = 1
	spawn_positions = 1
	description = "You are the most elite of the enlisted, sergeant in rank but forgoing regular command roles to lead in battle only. You are expected to be on the frontlines of every engagement, and to provide firing support for the rank and file. Your power armor lacks the protection the full working sets have, but you have trained with it and can use it in battle well. General Oliver praises you and your other Heavy Troopers, prove to him you're no exception to the rule."
	supervisors = "Lieutenant and Above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_HEAVYTROOPER
	outfit = /datum/outfit/job/ncr/f13heavytrooper
	exp_requirements = 375

	loadout_options = list(
		/datum/outfit/loadout/shockht,	// Minigun
		/datum/outfit/loadout/supportht, // R84
		)

/datum/outfit/job/ncr/f13heavytrooper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)

/datum/outfit/job/ncr/f13heavytrooper	// Mk. 23, Bayonet, Heavy armor
	name = "NCR Heavy Trooper"
	jobtype	= /datum/job/ncr/f13heavytrooper
	id = /obj/item/card/id/dogtag/ncrsergeant
	uniform = /obj/item/clothing/under/f13/ncr
	accessory =	/obj/item/clothing/accessory/ncr/SGT
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	head = /obj/item/clothing/head/helmet/f13/heavy/salvaged_pa/t45b/ncr
	neck = /obj/item/storage/belt/holster/legholster
	suit = /obj/item/clothing/suit/armor/heavy/salvaged_pa/t45b/ncr
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		/obj/item/ammo_box/magazine/m45exp = 2,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)

/datum/outfit/loadout/shockht
	name = "Shock Heavy Trooper"
	backpack_contents = list(
		/obj/item/minigunpackbal5mm = 1,
		/obj/item/melee/onehanded/knife/bowie = 1,
		)

/datum/outfit/loadout/supportht
	name = "Support Heavy Trooper"
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/r84 = 1,
		/obj/item/ammo_box/magazine/lmg = 1,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		)


// COMBAT ENGINEER

/datum/job/ncr/f13combatengineer
	title = "NCR Combat Engineer"
	flag = F13COMBATENGINEER
	total_positions = 2
	spawn_positions = 2
	description = "You are a senior enlisted trooper with an engineering skill set. You work closely with your squad, taking orders from the officers. You have the authority to command troopers if there are no non-commissioned officers present."
	supervisors = "Corporals and Above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_COMBATENGINEER
	outfit = /datum/outfit/job/ncr/f13combatengineer
	exp_requirements = 60

	loadout_options = list( // ALL: Trench tool, Limited blueprints
		/datum/outfit/loadout/combatengineerbuilder, // R82, X4 explosive, Extra materials
		/datum/outfit/loadout/combatengineertrapper, // 10mm SMG, Minelaying, Explosive Crafting
		/datum/outfit/loadout/combatengineerflamethrower, // Flamer, R82
		/datum/outfit/loadout/combatengineerrocketeer, // Rocket launcher, Explosive Crafting
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
		),
		)

/datum/outfit/job/ncr/f13combatengineer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/servicerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/scoutcarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1garand)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedarmorconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tools/forged/entrenching_tool)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedhelmetconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ninemil)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1911)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingshotgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1carbine)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/ncr/f13combatengineer
	name = "NCR Combat Engineer"
	jobtype = /datum/job/ncr/f13combatengineer
	id = /obj/item/card/id/dogtag/ncrtrooper
	uniform = /obj/item/clothing/under/f13/ncr
	head = /obj/item/clothing/head/hardhat/ncr
	suit = /obj/item/clothing/suit/armor/ncrarmor/reinforced/engineer
	gloves = /obj/item/clothing/gloves/color/yellow
	accessory =	/obj/item/clothing/accessory/ncr/SPC
	belt = null
	backpack_contents = list(
		/obj/item/shovel/trench = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/grenade/f13/frag = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/loadout/combatengineerbuilder
	name = "Construction Specialist"
	belt = /obj/item/storage/belt/military/assault/ncr/engineer
	glasses = /obj/item/clothing/glasses/welding
	suit_store = /obj/item/gun/ballistic/automatic/service/r82
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 2,
		/obj/item/book/granter/trait/explosives = 1,
		/obj/item/grenade/plastic/x4 = 1,
		/obj/item/stack/sheet/metal/fifty = 1,
		/obj/item/stack/sheet/glass/fifty = 1,
		/obj/item/stack/ore/blackpowder/twenty = 1,
		)

/datum/outfit/loadout/combatengineertrapper
	name = "Minelayer"
	belt = /obj/item/storage/belt/military/assault/ncr/engineer
	suit_store = /obj/item/gun/ballistic/automatic/smg/smg10mm
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/ext = 2,
		/obj/item/book/granter/crafting_recipe/blueprint/trapper = 1,
		/obj/item/book/granter/trait/explosives = 1,
		/obj/item/book/granter/trait/explosives_advanced = 1,
		)

/datum/outfit/loadout/combatengineerflamethrower
	name = "Combat Sapper"
	belt = /obj/item/storage/belt/military/assault/ncr
	glasses	= /obj/item/clothing/glasses/sunglasses
	suit_store =  /obj/item/gun/ballistic/automatic/service/r82
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 2,
		/obj/item/m2flamethrowertank = 1,
		)

/datum/outfit/loadout/combatengineerrocketeer
	name = "Rocket Engineer"
	suit_store = /obj/item/gun/ballistic/rocketlauncher
	backpack_contents = list(
		/obj/item/ammo_casing/caseless/rocket = 4,
		/obj/item/ammo_casing/caseless/rocket/big = 1,
		/obj/item/book/granter/trait/explosives = 1,
		)

// MILITARY POLICE

/datum/job/ncr/f13mp
	title = "NCR Military Police"
	flag = F13MP
	total_positions = 2
	spawn_positions = 2
	description = "You are NOT allowed to participate in front-line combat outside the base/embassy. You are tasked with the supervision of the NCRA to maintain internal order and disciplice and to prevent any warcrimes from happening."
	supervisors = "NCRA Officers"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13mp
	exp_requirements = 150

/datum/outfit/job/ncr/f13mp		// .45 Pistol, Beanbag Shotgun, Military baton
	name = "NCR Military Police"
	jobtype	= /datum/job/ncr/f13mp
	id = /obj/item/card/id/dogtag/ncrsergeant
	neck = /obj/item/storage/belt/holster/legholster
	accessory = /obj/item/clothing/accessory/armband/black
	glasses	= /obj/item/clothing/glasses/sunglasses/big
	head = /obj/item/clothing/head/f13/ncr/steelpot_mp
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle/reinforced
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	backpack = /obj/item/storage/backpack/satchel/trekker
	suit_store = /obj/item/gun/ballistic/shotgun/police
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911 = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		/obj/item/ammo_box/shotgun/bean = 2,
		/obj/item/melee/classic_baton/militarypolice = 1,
		/obj/item/stack/crafting/armor_plate = 4,
		)

/datum/outfit/job/ncr/f13mp/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_IRONFIST, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)


// COMBAT MEDIC

/datum/job/ncr/f13combatmedic
	title = "NCR Combat Medic"
	flag = F13COMBATMEDIC
	total_positions = 2
	spawn_positions = 2
	description = "You are a senior enlisted with a medical skill set. You work closely with your squad, taking orders from your officers. You have the authority to command troopers if there are no non-commissioned officers present."
	supervisors = "Corporals and Above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_COMBATMEDIC
	outfit = /datum/outfit/job/ncr/f13combatmedic
	exp_requirements = 60

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
			),
		)

/datum/outfit/job/ncr/f13combatmedic		// M1A1 Carbine, Survival knife
	name = "NCR Combat Medic"
	jobtype = /datum/job/ncr/f13combatmedic
	id = /obj/item/card/id/dogtag/ncrtrooper
	suit = /obj/item/clothing/suit/armor/ncrarmor/reinforced
	head = /obj/item/clothing/head/f13/ncr/steelpot_med
	mask = /obj/item/clothing/mask/surgical
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	accessory = /obj/item/clothing/accessory/armband/med/ncr
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/compact
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 2,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/storage/survivalkit_aid_adv = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/stack/crafting/armor_plate = 4,
		)

/datum/outfit/job/ncr/f13combatmedic/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)




/////////////////////////
//// Regular Soldiers ///
/////////////////////////

// CORPORAL

/datum/job/ncr/f13corporal
	title = "NCR Corporal"
	flag = F13CORPORAL
	total_positions = 3
	spawn_positions = 3
	description = "You are a junior NCO. You are expected to lead from the frontlines with your sergeant. Keep the troopers in order and keep your squad coherent."
	supervisors = "Sergeant and above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_CORPORAL
	outfit = /datum/outfit/job/ncr/f13corporal
	exp_requirements = 90

	loadout_options = list(
		/datum/outfit/loadout/corporaldesignatedmarksman,	 // Marksman Carbine, 9mm sidearm
		/datum/outfit/loadout/corporalrifleman,				 // R82, Large magazines
		/datum/outfit/loadout/corporalcqc,					 // Hunting Shotgun
		/datum/outfit/loadout/corporalcommand,				 // Intel and backline support
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
			),
		)

/datum/outfit/job/ncr/f13corporal/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/ncr/f13corporal
	name = "NCR Corporal"
	jobtype	= /datum/job/ncr/f13corporal
	id = /obj/item/card/id/dogtag/ncrtrooper
	accessory = /obj/item/clothing/accessory/ncr/CPL
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		/obj/item/stack/crafting/armor_plate = 5,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/grenade/f13/frag = 2,
		)

/datum/outfit/loadout/corporaldesignatedmarksman
	name = "Squad Ranged Support"
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle
	head = /obj/item/clothing/head/f13/ncr/steelpot_bandolier
	neck = /obj/item/storage/belt/holster/legholster
	suit_store = /obj/item/gun/ballistic/automatic/marksman
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 2,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mmds = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		)

/datum/outfit/loadout/corporalrifleman		//Name changed for better flavor
	name = "Master Corporal"
	head = /obj/item/clothing/head/f13/ncr
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle
	suit_store = /obj/item/gun/ballistic/automatic/service/r82
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 2,
		/obj/item/storage/box/ration/menu_one = 1,
		/obj/item/clothing/accessory/ncr/MCPL = 1 //Same rank, mostly for flavor and RP. - Kitsunemitsu
		)

/datum/outfit/loadout/corporalcqc		//I think this one sucks, personally.
	name = "Squad Pointman"
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle
	suit_store = /obj/item/gun/ballistic/shotgun/hunting
	head = /obj/item/clothing/head/f13/ncr/steelpot_goggles
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/storage/box/ration/menu_one = 1,
		)

/datum/outfit/loadout/corporalcommand	//Has a fold out gun. It serves it's purpose in being a support role but it is primarily for RP.
	name = "Squad Pathfinder"
	suit = /obj/item/clothing/suit/armor/ncrarmor/mantle
	suit_store = /obj/item/gun/ballistic/automatic/m1carbine/compact
	neck = /obj/item/storage/belt/holster/legholster
	head = /obj/item/clothing/head/f13/ncr/steelpot_goggles
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/ext = 2,
		/obj/item/binoculars = 1,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mmds = 1,
		/obj/item/storage/box/ration/menu_one = 1,
		)

// TROOPER

/datum/job/ncr/f13trooper
	title = "NCR Trooper"
	flag = F13TROOPER
	total_positions = 6
	spawn_positions = 6
	description = "You are a professional soldier of the NCR Army. Obey your the NCOs and officers, no matter what you are expected to follow military discipline."
	supervisors = "Corporals and Above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13trooper
	exp_requirements = 60

	loadout_options = list(
		/datum/outfit/loadout/trooperrifleman, // Service Rifle, Bayonet
		/datum/outfit/loadout/trooperfiresupport, // M1/n carbine, Trench tool, Sandbags
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
			),
		)

/datum/outfit/job/ncr/f13trooper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/datum/outfit/job/ncr/f13trooper
	name = "NCR Trooper"
	jobtype	= /datum/job/ncr/f13trooper
	id = /obj/item/card/id/dogtag/ncrtrooper
	accessory = /obj/item/clothing/accessory/ncr/TPR
	head = /obj/item/clothing/head/f13/ncr
	suit = /obj/item/clothing/suit/armor/ncrarmor
	glasses	= null
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		/obj/item/stack/crafting/armor_plate = 4,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/grenade/f13/frag = 1
		)

/datum/outfit/loadout/trooperrifleman
	name = "Rifleman"
	suit_store = /obj/item/gun/ballistic/automatic/service
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 3,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		)

/datum/outfit/loadout/trooperfiresupport
	name = "Sapper"
	suit_store = /obj/item/gun/ballistic/shotgun/hunting
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/shovel/trench = 1,
		/obj/item/stack/sheet/mineral/sandbags = 10,
		/obj/item/storage/box/ration/menu_eight = 1,
		)


// CONSCRIPT

/datum/job/ncr/f13conscript
	title = "NCR Conscript"
	flag = F13CONSCRIPT
	total_positions = 3
	spawn_positions = 3
	description = "You are the recent bulk of the NCR Army. You have been recently conscripted, given little to no training and were issued a gun. Obey your the NCOs and officers, no matter what you are expected to follow military discipline."
	supervisors = "The Drill Sergeant, Corporals and Above"
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_TROOPER
	outfit = /datum/outfit/job/ncr/f13conscript

	loadout_options = list(
		/datum/outfit/loadout/conscriptvarmint, // Service Rifle, Bayonet
		/datum/outfit/loadout/conscripthunting, // Hunting rifle, Trench tool, Sandbags
		)

	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
			),
		)

/datum/outfit/job/ncr/f13conscript
	name = "NCR Conscript"
	jobtype	= /datum/job/ncr/f13conscript
	id = /obj/item/card/id/dogtag/ncrtrooper
	accessory = /obj/item/clothing/accessory/ncr/REC
	head = /obj/item/clothing/head/f13/ncr/standard/conscript
	uniform = /obj/item/clothing/under/f13/ncr/conscript
	suit = /obj/item/clothing/suit/armor/ncrarmor/conscript
	glasses	= null
	backpack_contents = list(
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)

/datum/outfit/loadout/conscriptvarmint
	name = "Assault"
	suit_store = /obj/item/gun/ballistic/automatic/service
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle = 1,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/storage/box/ration/menu_two = 1,
		)

/datum/outfit/loadout/conscripthunting
	name = "Reservist"
	suit_store = /obj/item/gun/ballistic/rifle/hunting
	backpack_contents = list(
		/obj/item/ammo_box/a308 = 2,
		/obj/item/shovel/trench = 1,
		/obj/item/stack/sheet/mineral/sandbags = 7,
		/obj/item/storage/box/ration/menu_eight = 1,
		)


/////////////////
/// Logistics ///
/////////////////

// MEDICAL OFFICER

/datum/job/ncr/f13medicalofficer
	title = "NCR Medical Officer"
	flag = F13MEDICALOFFICER
	total_positions = 1
	spawn_positions = 1
	description = "You are the lead medical professional in Camp Miller, you do not have any command authority unless it is of medical nature. Your duties are to ensure your troopers are in good health and that medical supplies are stocked for troopers."
	supervisors = "Captain and Above"
	selection_color = "#fff5cc"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	display_order = JOB_DISPLAY_ORDER_MEDICALOFFICER
	outfit = /datum/outfit/job/ncr/f13medicalofficer
	exp_requirements = 750
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/ncr,
			),
		/datum/matchmaking_pref/rival = list(
			/datum/job/ncr,
			),
		)

/datum/outfit/job/ncr/f13medicalofficer		// M1911 Custom, Telescopic baton
	name = "NCR Medical Officer"
	jobtype	= /datum/job/ncr/f13medicalofficer
	id = /obj/item/card/id/dogtag/ncrlieutenant
	uniform	= /obj/item/clothing/under/f13/ncr/ncr_officer
	shoes =	/obj/item/clothing/shoes/f13/military/ncr
	accessory =	/obj/item/clothing/accessory/ncr/LT2
	head = /obj/item/clothing/head/beret/ncr/ncr_medic
	neck = /obj/item/storage/belt/holster/legholster
	glasses = /obj/item/clothing/glasses/hud/health/f13
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	ears = /obj/item/radio/headset/headset_ncr_com
	suit = /obj/item/clothing/suit/armor/ncrarmor/labcoat
	belt = /obj/item/storage/belt/military/assault/ncr
	r_hand = /obj/item/storage/backpack/duffelbag/med/surgery
	mask = /obj/item/clothing/mask/surgical
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/m1911/custom = 1,
		/obj/item/ammo_box/magazine/m45 = 2,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/storage/survivalkit_aid_adv = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/stack/crafting/armor_plate = 5
		)

/datum/outfit/job/ncr/f13medicalofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)


// LOGISTICS OFFICER

/datum/job/ncr/f13logisticsofficer
	title = "NCR Logistics Officer"
	flag = F13LOGISTICSOFFICER
	total_positions = 1
	spawn_positions = 1
	description = "You are the lead engineering professional in Camp Miller, you do not have any command authority beyond the logistical side. Your duties are to ensure your outpost is well defended, the armory is in order, and you always have supplies. Organize the rear echelon to offload the frontline officers and make things happen."
	supervisors = "Captain and Above"
	access = list(ACCESS_NCR, ACCESS_NCR_ARMORY, ACCESS_NCR_COMMAND)
	selection_color = "#fff5cc"
	display_order = JOB_DISPLAY_ORDER_LOGISTICSOFFICER
	outfit = /datum/outfit/job/ncr/f13logisticsofficer
	exp_requirements = 750

/datum/outfit/job/ncr/f13logisticsofficer/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/marksmancarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lmg)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/scoutcarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rangemaster)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/servicerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedarmorconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tools/forged/entrenching_tool)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedhelmetconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/concussion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/incendiaryrocket)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/empgrenade)
	//guns
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/dks)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/a180)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ninemil)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1911)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/n99)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/m1garand)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/commando)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/marksmancarbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/servicerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/scoutcarbine)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)

/datum/outfit/job/ncr/f13logisticsofficer		// M1 Garand, 9mm sidearm, Survival knife, C-4 bomb, Extra materials, Full blueprints
	name = "NCR Logistics Officer"
	jobtype	= /datum/job/ncr/f13logisticsofficer
	id = /obj/item/card/id/dogtag/ncrlieutenant
	uniform	= /obj/item/clothing/under/f13/ncr/ncr_officer
	accessory = /obj/item/clothing/accessory/ncr/LT2
	head = /obj/item/clothing/head/beret/ncr/ncr_sapper
	neck = /obj/item/storage/belt/holster/legholster
	suit = /obj/item/clothing/suit/armor/utilityvest/logisticsofficer
	glasses	= /obj/item/clothing/glasses/welding
	belt = /obj/item/storage/belt/military/assault/ncr/engineer
	gloves = /obj/item/clothing/gloves/color/yellow
	suit_store = /obj/item/gun/ballistic/automatic/m1garand
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308 = 2,
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mm = 2,
		/obj/item/grenade/plastic/c4 = 1,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		/obj/item/stack/sheet/metal/twenty = 2,
		/obj/item/stack/sheet/glass/ten = 2,
		/obj/item/book/granter/trait/explosives = 1,
		/obj/item/book/granter/trait/explosives_advanced = 1,
		/obj/item/book/granter/crafting_recipe/blueprint/trapper = 1,
		)


// REAR ECHELON

/datum/job/ncr/f13rearechelon
	title = "NCR Rear Echelon"
	flag = F13REARECHELON
	total_positions = 4
	spawn_positions = 4
	description = "You are the support element sent to assist the Camp Miller garrison. You are essential specialized support staff to help sustain the base via supply or specialized skills. You are not allowed to leave base unless given an explicit order by the CO or the current acting CO."
	supervisors = "Logistics/Medical officer first, regular chain of command after that."
	selection_color = "#fff5cc"
	exp_type = EXP_TYPE_NCR
	display_order = JOB_DISPLAY_ORDER_REAR_ECHELON
	outfit = /datum/outfit/job/ncr/f13rearechelon
	exp_requirements = 60

	loadout_options = list( // ALL: Very limited blueprints
		/datum/outfit/loadout/rearlog, // Varmint rifle, Trench tool
		/datum/outfit/loadout/reartech, // Hunting shotgun, Survival knife, Toolbelt, Metal detector, Salvaging
		/datum/outfit/loadout/rearcorps, // 9mm sidearm, Survival knife, Chemistry
		/datum/outfit/loadout/offduty, // 9mm sidearm, Bayonet
		)

/datum/outfit/job/ncr/f13rearechelon
	name = "NCR Rear Echelon"
	jobtype	= /datum/job/ncr/f13rearechelon
	id = /obj/item/card/id/dogtag/ncrtrooper
	accessory =	/obj/item/clothing/accessory/ncr/TPR
	head = /obj/item/clothing/head/f13/ncr/ncr_cap
	suit = null
	belt = null

/datum/outfit/job/ncr/f13rearechelon/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tailor/ncruniform)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedarmorconversion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tools/forged/entrenching_tool)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/servicerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ncrsalvagedhelmetconversion)

// Logistics soldier
/datum/outfit/loadout/rearlog
	name = "Logistics"
	suit = /obj/item/clothing/suit/armor/utilityvest
	belt = /obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/varmint = 1,
		/obj/item/ammo_box/magazine/m556/rifle/small = 2,
		/obj/item/shovel/trench = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)

// Technician	Salvaging
/datum/outfit/loadout/reartech
	name = "Technician"
	suit = /obj/item/clothing/suit/armor/utilityvest
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/color/yellow
	backpack_contents = list(
		/obj/item/book/granter/trait/techno = 1,
		/obj/item/clothing/suit/armor/utilityvest = 1,
		/obj/item/gun/ballistic/shotgun/hunting = 1,
		/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/metaldetector = 1,
		/obj/item/weldingtool/largetank = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)

// Corpsman		Chemistry, simple medical
/datum/outfit/loadout/rearcorps
	name = "Corpsman"
	suit = /obj/item/clothing/suit/armor/utilityvest
	belt = /obj/item/storage/belt/medical
	gloves = /obj/item/clothing/gloves/f13/leather/fingerless
	neck = /obj/item/storage/belt/holster/legholster
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mmds = 2,
		/obj/item/melee/onehanded/knife/survival = 1,
		/obj/item/storage/firstaid/regular = 1,
		/obj/item/book/granter/trait/chemistry = 1,
		/obj/item/book/granter/trait/lowsurgery = 1,
		/obj/item/storage/bag/money/small/ncrenlisted = 1,
		)

// Off-duty		Snazzy jacket, saved up money for leave
/datum/outfit/loadout/offduty
	name = "Off-Duty"
	suit = /obj/item/clothing/suit/armor/ncrarmor/ncr_dressjack
	belt = /obj/item/storage/belt/military/NCR_Bandolier
	backpack_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ninemil = 1,
		/obj/item/ammo_box/magazine/m9mmds = 2,
		/obj/item/melee/onehanded/knife/bayonet = 1,
		/obj/item/reagent_containers/food/snacks/cheesyburrito = 2,
		/obj/item/reagent_containers/food/drinks/bottle/f13nukacola = 1,
		/obj/item/storage/bag/money/small/ncrofficers = 1,
		)

// NCR Citizen
// Really only used for ID console
/datum/job/ncr/f13ncrcitizen
	title = "NCR Citizen"
	access = list(ACCESS_NCROFFDUTY)
	minimal_access = list(ACCESS_NCROFFDUTY)
	outfit = /datum/outfit/job/ncr/f13ncrcitizen

/datum/outfit/job/ncr/f13ncrcitizen
	name = "NCR Citizen (Role)"
	uniform = /obj/item/clothing/under/f13/ncrcaravan
	shoes = /obj/item/clothing/shoes/f13/tan
	head = /obj/item/clothing/head/f13/cowboy
	gloves = /obj/item/clothing/gloves/color/brown
	id = /obj/item/card/id/dogtag/town/ncr
	l_hand = /obj/item/gun/ballistic/automatic/varmint
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m556/rifle=2,
		)
