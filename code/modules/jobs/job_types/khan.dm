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
	head = /obj/item/clothing/head/helmet/f13/khan
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
		/obj/item/reagent_containers/pill/patch/jet = 2,
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

	loadout_options = list(
		/datum/outfit/loadout/enforcer,
		/datum/outfit/loadout/khanskirmisher,
		/datum/outfit/loadout/khandrug,
		)

/datum/outfit/loadout/enforcer
	name = "Enforcer"
	r_hand = /obj/item/twohanded/baseball/spiked
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola/tactical=1,
		/obj/item/book/granter/trait/bigleagues = 1,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 3)

/datum/outfit/loadout/khanskirmisher
	name = "Skirmisher"
	r_hand = /obj/item/gun/ballistic/automatic/smg/mini_uzi
	backpack_contents = list(
		/obj/item/ammo_box/magazine/uzim9mm=3,
		/obj/item/reagent_containers/hypospray/medipen/stimpak = 1,
		/obj/item/storage/belt/holster=1)

/datum/outfit/loadout/khandrug
	name = "Drug Pusher"
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
		/obj/item/book/granter/trait/midsurgery = 1,
		/obj/item/book/granter/trait/chemistry = 1,
		/obj/item/reagent_containers/pill/patch/turbo=2)




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
