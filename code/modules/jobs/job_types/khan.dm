/datum/job/khan //do NOT use this for anything, it's just to store faction datums
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_KHAN
	exp_type = EXP_TYPE_KHAN
	access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	minimal_access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	forbids = "THE KHANATE DISCOURAGES: Dishonorable actions, Weakness, Abuse of power or status, sabotaging other Khans."
	enforces = "THE KHANATE ENCOURAGES: Bravery, Honor, Displays of strenght, Brotherhood."

/datum/job/khanleader //do NOT use this for anything, it's just to store faction datums
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_KHAN
	exp_type = EXP_TYPE_KHAN
	access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)
	minimal_access = list(ACCESS_KHAN, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)
	forbids = "THE KHANATE DISCOURAGES: Dishonorable actions, Weakness, Abuse of power or status, sabotaging other Khans."
	enforces = "THE KHANATE ENCOURAGES: Bravery, Honor, Displays of strenght, Brotherhood."

/datum/outfit/job/khan
	name = "Khan"
	jobtype = /datum/job/khan
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket
	id = /obj/item/card/id/khantattoo
	ears = /obj/item/radio/headset/headset_khans
	head = /obj/item/clothing/head/helmet/f13/khan/bandana
	shoes = /obj/item/clothing/shoes/f13/military/khan
	backpack =	/obj/item/storage/backpack/satchel/explorer
	satchel = 	/obj/item/storage/backpack/satchel/old
	uniform = /obj/item/clothing/under/f13/khan
	r_hand = /obj/item/book/granter/trait/selection
	r_pocket = /obj/item/flashlight/flare
	l_pocket = /obj/item/storage/survivalkit_khan
	gloves = /obj/item/melee/unarmed/brass/spiked
	box = null
	backpack_contents = list(
		/obj/item/storage/bag/money/small/khan = 1
		)

/datum/outfit/job/khan/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/set_vrboard/den)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/trail_carbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/varmintrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/combatrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/smg10mm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_khanate)

/datum/outfit/job/khan/mangudai
	jobtype = /datum/job/khan/mangudai

/datum/outfit/job/khan/kipchak
	jobtype = /datum/job/khan/kipchak

/datum/outfit/job/khan/khorchin
	jobtype = /datum/job/khan/khorchin

/datum/outfit/job/khan/kheshig
	jobtype = /datum/job/khan/kheshig

/datum/outfit/job/khanleader/steward
	jobtype = /datum/job/khan/steward

/datum/outfit/job/khanleader/noyan
	jobtype = /datum/job/khan/noyan

/datum/outfit/job/khanleader
	name = "Khan"
	jobtype = /datum/job/khanleader
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket
	id = /obj/item/card/id/khanleadertattoo
	ears = /obj/item/radio/headset/headset_khans
	head = /obj/item/clothing/head/helmet/f13/khan/bandana
	shoes = /obj/item/clothing/shoes/f13/military/khan
	backpack =	/obj/item/storage/backpack/satchel/explorer
	satchel = 	/obj/item/storage/backpack/satchel/old
	uniform = /obj/item/clothing/under/f13/khan
	r_hand = /obj/item/book/granter/trait/selection
	r_pocket = /obj/item/flashlight/flare
	l_pocket = /obj/item/storage/survivalkit_khan
	gloves = /obj/item/melee/unarmed/brass/spiked
	box = null
	backpack_contents = list(
		/obj/item/storage/bag/money/small/khan = 1
		)

/datum/outfit/job/khanleader/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/set_vrboard/den)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/trail_carbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/varmintrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/combatrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/smg10mm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_khanate)

/datum/job/khan/mangudai
	title = "Mangudai"
	flag = F13MANGUDAI
	faction = FACTION_KHAN
	total_positions = 4
	spawn_positions = 4
	description = "You are a Mangudai, a warrior of the Great Khans who has passed the Trial of Position within the arena and earned their place. While your combat skills are to be respected, remember your position as a soldier - protect the Khan Fortress and Bighorn, show loyalty, and you may find chances yet to prove your greater worth."
	supervisors = "the Noyan and Khanate"
	selection_color = "#ff915e"
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan/mangudai

	loadout_options = list(
		/datum/outfit/loadout/enforcer,
		/datum/outfit/loadout/khanskirmisher,
		/datum/outfit/loadout/khandrug,
		)

//=========================================================== LOADOUT DATUMS ===========================================================

//KIPCHAK =================================================================

/datum/outfit/loadout/miner
	name = "Miner"
	r_hand = /obj/item/pickaxe
	l_hand = /obj/item/flashlight/lantern
	belt = /obj/item/storage/bag/ore
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/shovel = 1)

/datum/outfit/loadout/prospector
	name = "Prospector"
	r_hand = /obj/item/gun/ballistic/automatic/pistol/m1911/custom
	l_hand = /obj/item/weldingtool/largetank
	belt = /obj/item/storage/belt/fannypack
	mask = /obj/item/clothing/mask/gas/welding
	backpack_contents = list(
		/obj/item/wrench = 1,
		/obj/item/ammo_box/magazine/m45 = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/techno = 1)

/datum/outfit/loadout/hunter
	name = "Hunter"
	r_hand = /obj/item/gun/ballistic/rifle/hunting
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
		/obj/item/ammo_box/a308  = 3,
		/obj/item/melee/onehanded/knife/hunting = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

//MANGUDAI =================================================================

/datum/outfit/loadout/enforcer
	name = "Enforcer"
	r_hand = /obj/item/twohanded/baseball/spiked
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/book/granter/trait/bigleagues = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

/datum/outfit/loadout/khanskirmisher
	name = "Skirmisher"
	r_hand = /obj/item/gun/ballistic/automatic/smg/mini_uzi
	backpack_contents = list(
		/obj/item/ammo_box/magazine/uzim9mm = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/storage/belt/holster = 1)

/datum/outfit/loadout/khandrug
	name = "Drug Pusher"
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
		/obj/item/book/granter/trait/midsurgery = 1,
		/obj/item/book/granter/trait/chemistry = 1,
		/obj/item/reagent_containers/pill/patch/turbo = 2)

//KHORCHIN =================================================================

/datum/outfit/loadout/fighter
	name = "Fighter"
	r_hand = /obj/item/gun/ballistic/rifle/repeater/trail
	belt = /obj/item/storage/belt/bandolier
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/tube/m44 = 3,
		/obj/item/book/granter/trait/bigleagues = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

/datum/outfit/loadout/guard
	name = "Guard"
	r_hand = /obj/item/gun/ballistic/shotgun/trench
	belt = /obj/item/storage/belt/bandolier
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/book/granter/trait/bigleagues = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

/datum/outfit/loadout/protector
	name = "protector"
	r_hand = /obj/item/gun/ballistic/automatic/pistol/n99
	l_hand = /obj/item/shield/riot/scrapshield
	belt = /obj/item/storage/belt/bandolier
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 3,
		/obj/item/melee/onehanded/machete/scrapsabre = 1,
		/obj/item/book/granter/trait/bigleagues = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

//KESHIG ===================================================================

/datum/outfit/loadout/veteran
	name = "Veteran Fighter"
	belt = /obj/item/storage/belt/bandolier
	r_hand = /obj/item/gun/ballistic/automatic/m1garand
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308 = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/sprayer
	name = "Sprayer"
	belt = /obj/item/storage/belt/bandolier
	r_hand = /obj/item/gun/ballistic/automatic/smg/smg10mm
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m10mm_adv/ext = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/pusher
	name = "Pusher"
	belt = /obj/item/storage/backpack/spearquiver
	l_hand = /obj/item/shield/riot/tower
	r_hand = /obj/item/melee/onehanded/machete/scrapsabre
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

//STEWARD ==================================================================

/datum/outfit/loadout/privileged
	name = "Privileged"
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat/goji
	glasses = /obj/item/clothing/glasses/wraith_spectacles
	head = /obj/item/clothing/head/collectable/petehat/gang
	r_hand = /obj/item/gun/ballistic/revolver/colt357/lucky
	l_hand = /obj/item/twohanded/baseball/louisville
	belt = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/a357 = 3,
		/obj/item/clipboard = 1,
		/obj/item/pen = 1,
		/obj/item/folder = 1)

/datum/outfit/loadout/taxcollector
	name = "Tax Collector"
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/gun/ballistic/revolver/hunting
	belt = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/c4570 = 3,
		/obj/item/twohanded/baseball = 1,
		/obj/item/clipboard = 1,
		/obj/item/pen = 1,
		/obj/item/folder = 1)

//NOYAN ====================================================================

/datum/outfit/loadout/bigboss
	name = "Big Boss"
	belt =/obj/item/storage/belt/bandolier
	r_hand = /obj/item/gun/ballistic/automatic/pistol/deagle/elcapitan
	head = /obj/item/clothing/head/helmet/f13/khan/fullhelm
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m14mm = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/ironfist
	name = "Iron Fist"
	gloves = /obj/item/melee/powerfist/f13
	belt = /obj/item/storage/belt/bandolier
	head = /obj/item/clothing/head/helmet/f13/khan/fullhelm
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/book/granter/trait/iron_fist  = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/peopleleader
	name = "People's leader"
	r_hand = /obj/item/gun/ballistic/revolver/revolver45
	head = /obj/item/clothing/head/helmet/f13/khan/fullhelm
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/c45rev = 3,
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/pacifier
	name = "Pacifier"
	r_hand = /obj/item/gun/ballistic/automatic/shotgun/riot
	head = /obj/item/clothing/head/helmet/f13/khan/fullhelm
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket/coat
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(
		/obj/item/ammo_box/magazine/d12g = 2,
		/obj/item/ammo_box/shotgun/buck = 2,
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

//=========================================================== JOBS ===========================================================

/datum/job/khan/kipchak
	title = "Kipchak"
	flag = F13KIPCHAK
	faction = FACTION_KHAN
	total_positions = 4
	spawn_positions = 4
	description = "You are a Kipchak, a warrior of the Great Khans who has demonstrated prowess beyond the domain of a Mangudai. While you remain a humble soldier, greater duties may be entrusted upon you - such as leadership of small scouting parties or the collection of tribute. Your additional duties may involve hunting, prospecting and mining."
	supervisors = "the Noyan and Khanate"
	selection_color = "#ff915e"
	exp_requirements = 60
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan/kipchak

	loadout_options = list(
		/datum/outfit/loadout/miner,
		/datum/outfit/loadout/prospector,
		/datum/outfit/loadout/hunter,
		)


/datum/job/khan/khorchin
	title = "Khorchin"
	flag = F13KHORCHIN
	faction = FACTION_KHAN
	total_positions = 4
	spawn_positions = 4
	description = "You are a Khorchin, an experienced warrior of the Great Khans who has proven their worth to the Khanate several times over. Your lamellar armor was forged for your person, and you shall find ample instruments of warfare at your disposal. Duties of greater prestige shall be given to you, from protecting Bighorn from lawbreakers to serving on diplomatic missions and expeditions."
	supervisors = "the Noyan and Khanate"
	selection_color = "#ff915e"
	exp_requirements = 150
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan/khorchin

	loadout_options = list(
		/datum/outfit/loadout/fighter,
		/datum/outfit/loadout/guard,
		/datum/outfit/loadout/protector,
		)


/datum/job/khan/kheshig
	title = "Kheshig"
	flag = F13KHESHIG
	faction = FACTION_KHAN
	total_positions = 2
	spawn_positions = 2
	description = "You are a Kheshig, a veteran Khorchin of the Great Khans who has displayed a degree of combat mastery in service to the Khanate. You receive access to a far greater arsenal, but with this comes greater expectations - expect to be given duties befitting of a true loyalist of the Khan such as leading dangerous expeditions alongside Knorchin, Bighorn prospectors and Followers."
	supervisors = "the Noyan and Khanate"
	selection_color = "#ff915e"
	exp_requirements = 500
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan/kheshig

	loadout_options = list(
		/datum/outfit/loadout/veteran,
		/datum/outfit/loadout/sprayer,
		/datum/outfit/loadout/pusher,
		)


/datum/job/khan/steward
	title = "Steward"
	flag = F13STEWARD
	head_announce = list("Security")
	faction = FACTION_KHAN
	total_positions = 1
	spawn_positions = 1
	description = "You are a Steward, a veteran of the Great Khans now serving its interests through negotiations and book-keeping. While dialogue and paperwork may be less exciting than the battlefield, you are instrumental in securing the financial and political wellbeing of the Khanate in this region. You are expected to lead in the absence of a Noyan."
	enforces = "You have control over the First Bank of Bighorn, a valuable asset in generating profit. Some ideas - distributing loans, handling the collection of tribute, establishing a chem distribution ring, and working with another faction - perhaps against another. But don't unnecessarily endanger the Khanate, and listen to the Noyan!"
	supervisors = "the Noyan and Khanate"
	selection_color = "#ff915e"
	exp_requirements = 750
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khanleader/steward

	loadout_options = list(
		/datum/outfit/loadout/taxcollector,
		/datum/outfit/loadout/privileged,
		)


/datum/job/khan/noyan
	title = "Noyan"
	flag = F13NOYAN
	head_announce = list("Security")
	faction = FACTION_KHAN
	total_positions = 1
	spawn_positions = 1
	description = "You are a Noyan, a ranking officer of the Khanate in charge of the local territory. You serve with the authority of the Khan themselves, and answer only to them - every Khan within the region is under your command. Maintain control of Bighorn from your mighty Khan Fortress. Work closely with the Steward if present - an invaluable financial and political adviser."
	enforces = "While you command great respect, you are nevertheless expected to keep the interests of the Khanate central. Put down dissent, but expect rapid and justified rebellion amongst your Khans if you begin unnecessarily endangering the interests of the Khanate. Mangudai and Kipchaks make good guards and scouts: Khorchins and Kheshigs are a more formidable military garrison."
	supervisors = "the Khan and Khanate"
	selection_color = "#ff915e"
	req_admin_notify = 1
	exp_requirements = 1000
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khanleader/noyan

	loadout_options = list(
		/datum/outfit/loadout/ironfist,
		/datum/outfit/loadout/peopleleader,
		/datum/outfit/loadout/pacifier,
		/datum/outfit/loadout/bigboss,
		)
