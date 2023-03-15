
/datum/job/biker
	title = "Hell's Nomad"
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_BIKER
	exp_type = EXP_TYPE_LIVING
	total_positions = 10 // supposedly whitelisted, no worries here
	spawn_positions = 10
	/// They get tattoos, which are *basically* access
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)

/// The boss of the cowbikers (unused, for now)
/datum/job/biker/boss
	title = "Hell's Nomad Boss"
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_BIKER
	exp_type = EXP_TYPE_LIVING
	total_positions = 0
	spawn_positions = 0
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)

/datum/outfit/job/biker
	name = "Hell's Nomad"
	jobtype = /datum/job/biker
	suit = /obj/item/clothing/suit/toggle/labcoat/khan_jacket
	id = /obj/item/card/id/khantattoo
	ears = /obj/item/radio/headset/headset_biker
	head = /obj/item/clothing/head/helmet/f13/khan/bandana
	shoes = /obj/item/clothing/shoes/f13/military
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/old
	uniform = /obj/item/clothing/under/f13/khan
	r_pocket = /obj/item/flashlight/flare
	box = /obj/item/storage/survivalkit/tribal/chief
	box_two = /obj/item/storage/survivalkit/medical/tribal
	gloves = /obj/item/melee/unarmed/brass/spiked
	backpack_contents = list(
		/obj/item/storage/bag/money/small/khan = 1
		)
	tattoos_they_get = list(OUTFIT_TATTOO(/datum/tattoo/biker, TATTOO_BIKER_RIGHT_SHOULDER))

/datum/outfit/job/biker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

/datum/outfit/job/biker/boss/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_biker)

