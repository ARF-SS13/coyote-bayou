/datum/job/tribals //do NOT use this for anything, it's just to store faction datums
	department_flag = TRIBAL
	selection_color = "#ffeeaa"
	forbids = "The use of pre-war technology, especially prewar weapons of war."
	enforces = "The tribe operate as if they are a part of a singular clan. Any harm dealt upon another member is likened to harm placed upon your brother or sister. Above all things, the tribe comes first."
	objectivesList = list("Leadership recommends the following goal for this week: Recruit worthy outlanders into the tribe","Leadership recommends the following goal for this week: Hunt dangerous creatures to improve the clan's standing", "Leadership recommends the following goal for this week: Preserve dangerous technology to prevent it from falling into the wrong hands.")

/datum/outfit/job/tribal/
	name = "TRIBALdatums"
	jobtype = /datum/job/tribal/
	shoes = 		/obj/item/clothing/shoes/f13/rag
	gloves =        /obj/item/clothing/gloves/f13/handwraps
	backpack = 	/obj/item/storage/backpack/explorer
	satchel = 	/obj/item/storage/backpack/satchel/explorer
	id = null
	box = /obj/item/storage/survivalkit_tribal
	ears = null

/datum/outfit/job/tribal/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.add_quirk("Hard Yards")
	H.add_quirk("Trapper")
	H.add_quirk("Spirit Blessed")
/*
Tribal Chief
*/
/datum/job/tribal/f13chief
	title = "Chief"
	flag = F13CHIEF
	department_flag = TRIBAL
	faction = "Village"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elders of the tribe."
	enforces = "The ways of the Machine spirits."
	forbids = "Abusing technology and using Pre-War weapons."
	description = "The leader and central political figure in the Wayfarer Tribe. You engage in diplomatic meetings with the powers present within the Region to ensure the village's safety and independence."
	selection_color = "#006666"
	outfit = /datum/outfit/job/tribal/f13chief

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

/datum/job/tribals/f13chief/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Big Leagues")

/datum/outfit/job/tribal/f13chief
	name = "Chief"
	jobtype = /datum/job/tribal/f13chief
	uniform = 		/obj/item/clothing/under/f13/tribe_chief
	belt = 			/obj/item/storage/backpack/spearquiver
	neck =			/obj/item/clothing/neck/cloak/chiefcloak
	id = 			/obj/item/card/id/tribetattoo
	suit =			/obj/item/clothing/suit/armor/f13/tribe_armor
	suit_store =	/obj/item/spear/bonespear/deathclaw
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/lantern=1)

/*
Tribal Shaman
*/
/datum/job/tribal/f13shaman
	title = "Shaman"
	flag = F13SHAMAN
	department_flag = TRIBAL
	faction = "Village"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elders of the tribe and the chief."
	enforces = "The ways of the Machine spirits."
	forbids = "Abusing technology and using Pre-War weapons."
	description = "The spiritual leader and cultural core of the Wayfarer Tribe. You aid villagers in their day to day lives by offering guidance and advice, while also acting as the direct aid to the chief. You are the guardian of the tribe's customs, their health, and knowledge."
	selection_color = "#006666"

	outfit = /datum/outfit/job/tribal/f13shaman

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

/datum/job/tribals/f13shaman/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Lifegiver")
	H.add_quirk("Spiritual")

/datum/outfit/job/tribal/f13shaman
	name = "Shaman"
	jobtype = /datum/job/tribal/f13shaman
	uniform = 	/obj/item/clothing/under/f13/tribe_shaman
	r_pocket = 	/obj/item/kitchen/knife/ritualdagger
	r_hand = 	/obj/item/twohanded/sledgehammer/shamanstaff
	id = 		/obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/book/granter/trait/spirit_teachings=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1,
		/obj/item/reagent_containers/glass/mortar=2,
		/obj/item/pestle=1)

/*
Tribal Head Hunter
*/
/datum/job/tribal/f13Hhunter
	title = "Head Hunter"
	flag = F13HHUNTER
	department_flag = TRIBAL
	faction = "Village"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Elders of the tribe and the chief."
	enforces = "The ways of the Machine spirits."
	forbids = "Abusing technology and using Pre-War weapons."
	description = "You are the village Head Hunter; you organize the hunters of the tribe and are the authority in matters of protecting the tribe and the land of the Wayfarers. You lead the Great Hunts and War-Bands in time of conflict."
	selection_color = "#006666"

	outfit = /datum/outfit/job/tribal/f13Hhunter
	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

/datum/job/tribal/f13Hhunter/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Lifegiver")
	H.add_quirk("Big Leagues")

/datum/outfit/job/tribal/f13Hhunter
	name = "Hhunter"
	jobtype = /datum/job/tribal/f13Hhunter
	uniform = 	/obj/item/clothing/under/f13/tribe_Hhunter
	suit = 		/obj/item/clothing/suit/hooded/cloak/hhunter
	belt = 		/obj/item/melee/transforming/cleaving_saw
	id = 		/obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1)

/*
Villager
*/

/datum/job/tribal/f13villager
	title = "Villager"
	flag = F13VILLAGER
	department_flag = TRIBAL
	faction = "Village"
	total_positions = 8
	spawn_positions = 8
	supervisors = "Tribal Chief, Shaman and Headhunter"
	description = "A proud member of the Wayfarer tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe."
	selection_color = "#006666"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/tribal/f13villager

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

	loadout_options = list(
	/datum/outfit/loadout/acolytevillager, //mortar and pistol
	/datum/outfit/loadout/farmervillager //Warclub farming gear
	)

/datum/job/tribals/f13villager/after_spawn(mob/living/carbon/human/H, mob/M)

/datum/outfit/job/tribal/f13villager
	name = "Villager"
	jobtype = /datum/job/tribal/f13villager
	uniform = 	/obj/item/clothing/under/f13/tribe
	id = 		/obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1)


/datum/outfit/loadout/farmervillager
	name = "Village Farmer"
	belt = /obj/item/claymore/machete/warclub
	backpack_contents = list(
		/obj/item/cultivator=1,
		/obj/item/hatchet=1,
		/obj/item/shovel/spade=1)

/datum/outfit/loadout/acolytevillager
	name = "Village Acolyte"
	belt = /obj/item/storage/bag/plants
	backpack_contents = list(
		/obj/item/reagent_containers/glass/mortar=1,
		/obj/item/pestle=1)

/*
Hunter
*/
/datum/job/tribal/f13hunter
	title = "Hunter"
	flag = F13HUNTER
	department_flag = TRIBAL
	faction = "Village"
	total_positions = 3
	spawn_positions = 3
	supervisors = "The chief and Head Hunter."
	enforces = "The ways of the Machine spirits."
	forbids = "Abusing technology and using Pre-War weapons."
	description = "You are a Hunter for the tribe; you bring back food and relics, anything that may house a machine spirit that can be purified by the shaman. You also are the protectors of the tribe, and work with the Head Hunter during Great Hunts or times of War."
	selection_color = "#006666"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/tribal/f13hunter

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

/datum/job/tribal/f13hunter/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Lifegiver")

/datum/outfit/job/tribal/f13hunter
	name = "Hunter"
	jobtype = /datum/job/tribal/f13hunter
	uniform = 	/obj/item/clothing/under/f13/tribe
	suit = 		/obj/item/clothing/suit/armor/f13/tribe_armor
	id = 		/obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1)
