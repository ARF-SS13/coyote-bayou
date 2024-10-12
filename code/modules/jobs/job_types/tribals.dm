/datum/outfit/job/tribal/
	name = "Tribal"
	jobtype = /datum/job/tribal/
	belt = /obj/item/supplykit
	shoes = /obj/item/clothing/shoes/sandal
	gloves = /obj/item/clothing/gloves/f13/handwraps
	r_pocket = /obj/item/storage/fancy/flare_pouch
	backpack = /obj/item/storage/backpack/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	id = null
	box = /obj/item/storage/survivalkit/tribal
	box_two = /obj/item/storage/survivalkit/medical/tribal
	ears = null

/datum/outfit/job/tribal/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TRIBAL, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_MACHINE_SPIRITS, src)
	H.grant_language(/datum/language/tribal)
	for(var/datum/crafting_recipe/recipe as() in GLOB.tribal_job_recipes)
		H.mind.teach_crafting_recipe(recipe)

/*
Tribal Chief
*/


/*
/datum/outfit/job/tribal/f13chief/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
*/

/datum/outfit/job/tribal/f13chief
	name =	"Chief"
	jobtype =	/datum/job/tribal/chief
	head =	/obj/item/clothing/head/helmet/f13/wayfarer/chief/green
	uniform =	/obj/item/clothing/under/f13/wayfarer
	belt =	/obj/item/storage/backpack/spearquiver
	neck =	/obj/item/clothing/neck/mantle/chief
	id =	/obj/item/card/id/tribetattoo
	suit =	/obj/item/clothing/suit/hooded/cloak/hhunter
	suit_store =	/obj/item/twohanded/spear/bonespear/aethergiest
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/reagent_containers/pill/healingpowder = 2,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/supplykit = 1,
		// /obj/item/cool_book/chiefguide = 1
	)

/*
Tribal Shaman
*/

/datum/outfit/job/tribal/f13shaman/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/wickerdoll)
	ADD_TRAIT(H, TRAIT_BLINDFAITH, src)
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, src)
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)


/datum/outfit/job/tribal/f13shaman
	name = "Spiritual Leader"
	jobtype = /datum/job/tribal/spiritual_leader
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/tribe
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	r_hand = /obj/item/twohanded/sledgehammer/shamanstaff
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/smelling_salts/wayfarer=1,
		/obj/item/reagent_containers/pill/patch/healpoultice=2,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/book/granter/crafting_recipe/bitters = 1,
		// /obj/item/cool_book/shamanguide = 1,
		/obj/item/healthanalyzer/tribal = 1,
		/obj/item/scrying = 1
	)



/datum/outfit/loadout/seeker
	name = "Shaman"
	backpack_contents = list(
		/obj/item/clothing/head/helmet/f13/wayfarer/shamanred=1,
		/obj/item/clothing/under/f13/wayfarer/shamanred=1,
		/obj/item/scrying = 1 //Please don't abuse this or I will hunt you down like an animal and gut you with one of those deer buttplugs they sell at walmart, ~Love TK

	)
/*
/datum/outfit/loadout/ascetic
	name = "Ascetic"
	backpack_contents = list(
		/obj/item/clothing/head/helmet/f13/wayfarer/shamanblue=1,
		/obj/item/clothing/under/f13/wayfarer/shamanblue=1,

	)
*/

/*
Tribal Hunt Master
*/

/datum/outfit/job/tribal/f13Hhunter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TRAPPER, src)

/datum/outfit/job/tribal/f13Hhunter
	name = "Head Forager"
	jobtype = /datum/job/tribal/head_forager
	uniform = /obj/item/clothing/under/f13/wayfarer/hunter
	suit = /obj/item/clothing/suit/hooded/cloak/shunter
	belt = /obj/item/twohanded/spearaxe
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/reagent_containers/pill/healingpowder=2,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/stack/medical/gauze=1,
		/obj/item/flashlight/lantern = 1,
		/obj/item/supplykit = 1,
		// /obj/item/cool_book/warriorguide = 1
	)

/*
Druid
*/

/datum/outfit/job/tribal/f13druid/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/wickerdoll)
	ADD_TRAIT(H, TRAIT_BLINDFAITH, src)
	ADD_TRAIT(H, TRAIT_SURGERY_LOW, src)
	ADD_TRAIT(H, TRAIT_DNAWHIZ, src)


/datum/outfit/job/tribal/f13druid
	name = "Harvest Leader"
	jobtype = /datum/job/tribal/harvest_leader
	head = /obj/item/clothing/head/helmet/f13/wayfarer/antler
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/wayfarer/acolyte
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/reagent_containers/glass/mortar=1,
		/obj/item/pestle=1,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/melee/onehanded/knife/ritualdagger=1,
		/obj/item/reagent_containers/glass/primitive_chem_isolator=1,
		/obj/item/reagent_containers/pill/patch/healpoultice=2,
		// /obj/item/cool_book/druidguide=1,
		/obj/item/healthanalyzer/tribal=1
	)

/*
Villager
*/

/datum/job/tribal/f13villager
	title = "Villager"
	flag = F13VILLAGER
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 0
	spawn_positions = 10
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "everyone but the other villagers."
	description = "A proud member of the Mountain River tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe. While it is common to venture out into the wasteland, do not tread far or without informing your kin."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13villager

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
/*
	loadout_options = list(
		/datum/outfit/loadout/gatherer, //Bone Spear, Bone Knife, Healing powder
		/datum/outfit/loadout/mender,	//Ritual dagger, Improvized gauze, Healing powders, Mortar
		/datum/outfit/loadout/craftsman, //Crude tools
	)
*/
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/tribal/f13villager,
			/datum/job/tribal/spirit_pledged,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/harvest_leader,
			/datum/job/tribal/f13villager,
			/datum/job/tribal/f13hunter,
		),
	)

/datum/outfit/job/tribal/f13villager/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BEASTFRIEND_SMALLCRITTER, src)


/datum/outfit/job/tribal/f13villager
	name = "Villager"
	jobtype = /datum/job/tribal/f13villager
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/wayfarer
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/reagent_containers/pill/healingpowder=1,
		/obj/item/stack/medical/gauze=1,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		// /obj/item/cool_book/villagerguide = 1
	)

/datum/outfit/loadout/gatherer
	name = "Gatherer"
	backpack_contents = list(
		///obj/item/twohanded/spear/bonespear = 1,
		/obj/item/reagent_containers/pill/healingpowder = 1,
		/obj/item/storage/bag/plants=1,
		/obj/item/scythe=1,
		/obj/item/cultivator=1,
		/obj/item/reagent_containers/glass/bucket/wood=1
	)

/*
/datum/outfit/loadout/gardener
	name = "Gardener"
	backpack_contents = list(
		/obj/item/scythe=1,
		/obj/item/storage/bag/plants=1,
		/obj/item/cultivator=1,
		/obj/item/reagent_containers/glass/bucket/wood=1
	)
*/

/datum/outfit/loadout/mender
	name = "Mender"
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/ritualdagger = 1,
		/obj/item/stack/medical/gauze/improvised = 1,
		/obj/item/reagent_containers/pill/healingpowder = 2,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle=1,
		/obj/item/healthanalyzer/tribal = 1
	)

/datum/outfit/loadout/craftsman
	name = "Craftsman"
	backpack_contents = list(
		/obj/item/storage/belt/utility=1,
		/obj/item/crowbar/crude=1,
		/obj/item/wrench/crude=1,
		/obj/item/wirecutters/crude=1,
		/obj/item/weldingtool/crude=1
	)

/*
Hunter
*/
/datum/outfit/job/tribal/f13hunter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/wickerdoll)
	ADD_TRAIT(H, TRAIT_TRAPPER, src)


/datum/outfit/job/tribal/f13hunter
	name = "Forager"
	jobtype = /datum/job/tribal/f13hunter
	head = /obj/item/clothing/head/helmet/f13/wayfarer/hunter
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/wayfarer/hunter
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	suit = /obj/item/clothing/suit/armor/light/tribal/strips
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/storage/box/tools/ranching =1,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		// /obj/item/cool_book/warriorguide = 1
	)

/datum/outfit/loadout/ranged
	name = "Archer"
	backpack_contents = list(
		/obj/item/gun/ballistic/bow/composite = 1,
		/obj/item/storage/bag/tribe_quiver/light/full/flint = 1,
		/obj/item/binoculars = 1,
	)

/datum/outfit/loadout/melee
	name = "Militia"
	backpack_contents = list(
		/obj/item/flashlight/flare/torch = 1,
		/obj/item/binoculars = 1,
		/obj/item/restraints/legcuffs/bola/tactical = 2,
		/obj/item/hatchet/war_axe = 1,
	)

/datum/outfit/loadout/healer
	name = "Healer"
	backpack_contents = list(
		/obj/item/melee/onehanded/knife/ritualdagger = 1,
		/obj/item/stack/medical/gauze = 2,
		/obj/item/reagent_containers/pill/healingpowder = 3,
		/obj/item/reagent_containers/glass/mortar = 1,
		/obj/item/pestle=1,
		/obj/item/healthanalyzer/tribal = 1
	)

/*
Spirit-Pledged
*/
/datum/outfit/job/tribal/f13spiritpledged
	name = "Spirit-Pledged"
	jobtype = /datum/job/tribal/spirit_pledged
	uniform = /obj/item/clothing/under/f13/wayfarer
	id = /obj/item/card/id/tribetattoo
	belt = /obj/item/supplykit
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign)

/*
Guardian
*/

/*
/datum/outfit/job/tribal/f13guardian/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_BIG_LEAGUES, src)
*/

/datum/outfit/job/tribal/f13guardian
	name = "Guardian"
	jobtype = /datum/job/tribal/guardian
	uniform = /obj/item/clothing/under/f13/wayfarer/hunter
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	suit = /obj/item/clothing/suit/armor/medium/tribal/tribe_heavy_armor
	//suit_store = /obj/item/twohanded/spear/bonespear/aethergiest
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/reagent_containers/pill/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/restraints/legcuffs/bola/tactical=1,
		// /obj/item/cool_book/warriorguide = 1
	)

/datum/outfit/job/den/f13dualcitizen
	name = "Dual Citizen"
	jobtype = /datum/job/tribal/dual_citizen
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/wayfarer
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/pda = 1,
		// /obj/item/cool_book/villagerguide = 1
	)

/datum/outfit/job/tribal/f13dualcitizen/pre_equip(mob/living/carbon/human/H)
	. = ..()
	uniform = pick(
		/obj/item/clothing/under/f13/gentlesuit,
		/obj/item/clothing/under/f13/formal,
		/obj/item/clothing/under/f13/spring,
		/obj/item/clothing/under/f13/relaxedwear,
		/obj/item/clothing/under/f13/machinist,
		/obj/item/clothing/under/f13/brahminf,
		/obj/item/clothing/under/f13/cowboyb,
		/obj/item/clothing/under/f13/cowboyg,
		/obj/item/clothing/under/f13/cowboyt)

/datum/outfit/job/tribal/f13dualcitizen/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_BEASTFRIEND_SMALLCRITTER, src)
