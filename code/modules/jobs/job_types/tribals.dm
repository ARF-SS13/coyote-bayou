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
	id = null
	box = /obj/item/storage/survivalkit_tribal
	ears = null

/datum/outfit/job/tribal/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHOBE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
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
	supervisors = "The wellbeing of the tribe and every one of it's members."
	description = "The leader and central political figure in the Wayfarer Tribe. It is your duty to preserve the culture of your people, including their historic aversion to pre-war weapons and technology. Meanwhile with outsiders you engage in diplomatic meetings with the powers present within the Region to ensure the village's safety and independence. Additional material, lore and information for your faction: https://desert-rose-fallout-13.fandom.com/wiki/Wayfarer_Tribe_Lore"
	selection_color = "#006666"

	outfit = /datum/outfit/job/tribal/f13chief

/datum/job/tribals/f13chief/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")

/datum/outfit/job/tribal/f13chief
	name = "Chief"
	jobtype = /datum/job/tribal/f13chief

	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/tribe_chief
	belt = /obj/item/claymore/machete/warclub
	neck = /obj/item/clothing/neck/cloak/chiefcloak
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola=1,
		/obj/item/reagent_containers/pill/patch/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1)

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
	supervisors = "Tribal Chief"
	description = "The spiritual leader and cultural core of the Wayfarer Tribe. You aid villagers in their day to day lives by offering guidance and advice, while also acting as the direct aid to the chief. To you the breaking of cultural norms such as an aversion to pre-war weapons and technology is to be taken with the upmost seriousness. Additional material, lore and information for your faction: https://desert-rose-fallout-13.fandom.com/wiki/Wayfarer_Tribe_Lore"
	selection_color = "#006666"

	outfit = /datum/outfit/job/tribal/f13shaman

/datum/job/tribals/f13shaman/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")

/datum/outfit/job/tribal/f13shaman
	name = "Shaman"
	jobtype = /datum/job/tribal/f13shaman

	head = /obj/item/clothing/head/helmet/f13/shamanhead
	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/tribe_shaman
	r_pocket = /obj/item/kitchen/knife/ritualdagger
	r_hand = /obj/item/twohanded/sledgehammer/shamanstaff
	backpack_contents = list(
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
	supervisors = "Tribal Chief and Shaman"
	description = "A proud member of the Wayfarer tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe in regards to the historic aversion to pre-war weapons and technology. Additional material, lore and information for your faction: https://desert-rose-fallout-13.fandom.com/wiki/Wayfarer_Tribe_Lore"
	selection_color = "#008080"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/tribal/f13villager

	loadout_options = list(
	/datum/outfit/loadout/huntervillager, //Bow and quiver
	/datum/outfit/loadout/farmervillager //Warclub farming gear
	)

/datum/job/tribals/f13villager/after_spawn(mob/living/carbon/human/H, mob/M)
	H.add_quirk("Hard Yards")

/datum/outfit/job/tribal/f13villager
	name = "Villager"
	jobtype = /datum/job/tribal/f13villager

	backpack = /obj/item/storage/backpack/explorer
	uniform = /obj/item/clothing/under/f13/tribe
	suit = /obj/item/clothing/suit/armor/f13/tribe_armor
	backpack_contents = list(
		/obj/item/reagent_containers/pill/patch/healingpowder=1,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/flare/torch=1)

/datum/outfit/loadout/huntervillager
	name = "Village Hunter"
	belt = /obj/item/storage/belt/tribe_quiver
	suit_store = /obj/item/gun/ballistic/automatic/tribalbow

/datum/outfit/loadout/farmervillager
	name = "Village Farmer"
	belt = /obj/item/claymore/machete/warclub
	backpack_contents = list(
		/obj/item/cultivator=1,
		/obj/item/hatchet=1,
		/obj/item/shovel/spade=1)
