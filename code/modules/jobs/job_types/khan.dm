/datum/job/khan //do NOT use this for anything, it's just to store faction datums
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_KHAN
	exp_type = EXP_TYPE_KHAN
	access = list(ACCESS_KHAN)
	minimal_access = list(ACCESS_KHAN)
	forbids = "The NCR forbids: Chem and drug use such as jet or alcohol while on duty. Execution of unarmed or otherwise subdued targets without authorisation."
	enforces = "The NCR expects: Obeying the lawful orders of superiors. Proper treatment of prisoners.  Good conduct within the Republic's laws. Wearing the uniform."

/datum/outfit/job/khan
	jobtype = /datum/job/khan
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket
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
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legioncombatarmor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legioncombathelmet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legioncombatarmormk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legioncombathelmetmk2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionsalvaged)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionsalvaged_ncr)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionsalvaged_salvaged)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionsalvagedhelmet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionriot_broken)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionriothelmet_broken)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionriot_ncr)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/legionriothelmet_ncr)
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
	description = "Mangudai desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

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
	belt = /obj/item/storage/belt
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
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/ammo_box/magazine/garand308 = 3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/sprayer
	name = "Sprayer"
	belt = /obj/item/storage/belt/bandolier
	r_hand = /obj/item/gun/ballistic/automatic/smg/smg10mm
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
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
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
	head = /obj/item/clothing/head/helmet/f13/khan
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

//STEWARD ==================================================================

/datum/outfit/loadout/privileged
	name = "Privileged"
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat/goji
	glasses = /obj/item/clothing/glasses/wraith_spectacles
	head = /obj/item/clothing/head/collectable/petehat/gang
	r_hand = /obj/item/gun/ballistic/revolver/colt357/lucky
	l_hand = /obj/item/twohanded/baseball/louisville
	neck = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/a357 = 3,
		/obj/item/clipboard = 1,
		/obj/item/pen = 1,
		/obj/item/folder = 1)

/datum/outfit/loadout/taxcollector
	name = "Tax Collector"
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/gun/ballistic/revolver/hunting
	neck = /obj/item/storage/belt/holster
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
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
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
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
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
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
	glasses = /obj/item/clothing/glasses/sunglasses
	neck = /obj/item/storage/belt/holster
	backpack_contents = list(
		/obj/item/ammo_box/c45rev = 3,
		/obj/item/restraints/legcuffs/bola/tactical = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3,
		/obj/item/book/granter/trait/bigleagues = 1)

/datum/outfit/loadout/pacifier
	name = "Pacifier"
	r_hand = /obj/item/gun/ballistic/automatic/shotgun/riot
	head = /obj/item/clothing/head/helmet/f13/khan/fullhelm
	suit = /obj/item/clothing/suit/toggle/labcoat/f13/khan_jacket/coat
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
	description = "Kipchak desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_requirements = 60
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

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
	description = "Korchin desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_requirements = 150
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

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
	description = "Kheshig desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_requirements = 500
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

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
	description = "steward desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_requirements = 500
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

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
	description = "noyan desc"
	supervisors = "your gang leadership"
	selection_color = "#ff915e"
	exp_requirements = 1000
	exp_type = EXP_TYPE_KHAN
	outfit = /datum/outfit/job/khan

	loadout_options = list(
		/datum/outfit/loadout/ironfist,
		/datum/outfit/loadout/peopleleader,
		/datum/outfit/loadout/pacifier,
		/datum/outfit/loadout/bigboss,
		)