
/datum/job/biker
	title = "Hells Nomad"
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_BIKER
	exp_type = EXP_TYPE_LIVING
	total_positions = -1 // supposedly whitelisted, no worries here
	spawn_positions = -1
	outfit = /datum/outfit/job/biker


	//whitelist_path = "strings/job_whitelist/biker.txt"
	/// They get tattoos, which are *basically* access
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_MINING, ACCESS_GATEWAY)

/// The boss of the cowbikers (unused, for now)
/datum/job/biker/boss
	title = "Overbiker"
	department_flag = KHAN
	selection_color = "#ff915e"
	faction = FACTION_BIKER
	exp_type = EXP_TYPE_LIVING
	total_positions = 1
	spawn_positions = 1
	//access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)
	//minimal_access = list(ACCESS_BIKER, ACCESS_BAR, ACCESS_CLINIC, ACCESS_GATEWAY, ACCESS_MINT_VAULT, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLONING)

/datum/outfit/job/biker
	name = "Hells Nomad"
	jobtype = /datum/job/biker
	suit = /obj/item/clothing/suit/armor/light/duster/brahmin/biker
	ears = /obj/item/radio/headset/headset_biker
	head = /obj/item/clothing/head/helmet/f13/khan/bandana
	shoes = /obj/item/clothing/shoes/f13/cowboy
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/old
	uniform = /obj/item/clothing/under/f13/khan/biker
	belt = /obj/item/kit_spawner/waster
	r_pocket = /obj/item/flashlight/flare
	box = /obj/item/storage/survivalkit
	box_two = /obj/item/storage/survivalkit/medical
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/kit_spawner/tools = 1,
		/obj/item/cool_book/ashdowncit = 1
		)
	tattoos_they_get = list(/datum/tattoo/biker)

/datum/outfit/job/biker/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/gate_biker)

