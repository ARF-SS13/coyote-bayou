/datum/job/tribal
	department_flag = TRIBAL
	selection_color = "#ffeeaa"
	exp_type = EXP_TYPE_TRIBAL
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	enforces = "The tribe operate as if they are a part of a singular clan. Any harm dealt upon another member is likened to harm placed upon your brother or sister. Above all things, the tribe comes first."
	objectivesList = list(
		"The Clan has decided to look for fresh blood from the out-peoples.  See if you can find someone to willingly join the tribe and learn our ways.",
		"This week we hunt, gecko's are to be reduced in numbers to a more sustainable level on this land for having murdered too many of our brahmin.",
		"This week we hunt, the Cazador menace is too strong in this land.  Their stingers are dangerous and the elders demand their extinction.",
		"The harvest leaders far off have asked us to find a cursed pre-war weapon that throws burning light at whatever you seek to destroy.  All of them must be found and destroyed, or our crops might fail.",
		"The Village rests, defend it and prosper this week.  Peace is rare, and we should enjoy it with song, dance, and good company.  Feel free to include outsiders if they will follow our ways when on our lands.",
		"The Village rests, defend it and prosper this week.  Peace is rare, but at least we can build defenses and take solitude in our isolation.",
		"The swamp calls the hunters forth, seek out the thing that shines and return it to the spiritual leaders to appease the spirits.  If no spiritual leader can be found then hide the item from the out-peoples.",
		"Something awful happened a bit back and it calls for blood, harass the outlaws of Redwater for their predations of wandering tribesman.  Remember to fortify the southern tunnel to their lands.  We should try to take at least one of them prisoner, and see how they like the collar on their own necks.",
		"The people of tribe of Nash insulted us in recent weeks, harass the people of Nash for their highbrow attitude.  Remember to Fortify the northern entrance to the village, and try to take them down a peg for their witty insolence.",
		"This week is one of rememberance.  Think of the times when our tribe came forth from The Cave of Crying.  Of the friends and loved ones lost.  Remember peace, and cry for what is lost.",
		"This week is one of rememberance.  Think of the times when our tribe has failed at our duties and work together as the family we are to try and solve internal issues. Tomorrow can be better, if only we try today.")

GLOBAL_LIST_INIT(tribal_job_recipes, list(
	/datum/crafting_recipe/tribal_pa,
	/datum/crafting_recipe/tribal_pa_helmet,
	/datum/crafting_recipe/tribal_combat_armor,
	/datum/crafting_recipe/tribal_combat_armor_helmet,
	/datum/crafting_recipe/tribal_r_combat_armor,
	/datum/crafting_recipe/tribal_r_combat_armor_helmet,
	/datum/crafting_recipe/tribalwar/chitinarmor,
	/datum/crafting_recipe/tribalwar/lightcloak,
	/datum/crafting_recipe/warmace,
	/datum/crafting_recipe/tribalwar/lighttribe,
	/datum/crafting_recipe/tribalwar/heavytribe,
	/datum/crafting_recipe/tribalwar/legendaryclawcloak,
	/datum/crafting_recipe/tribalwar/deathclawspear,
	/datum/crafting_recipe/warpaint,
	/datum/crafting_recipe/tribalradio,
	/datum/crafting_recipe/tribalwar/goliathcloak,
	///datum/crafting_recipe/tribalwar/bonebow,
	///datum/crafting_recipe/tribalwar/tribe_bow,
	///datum/crafting_recipe/tribalwar/sturdybow,
	/datum/crafting_recipe/tribalwar/warclub,
	///datum/crafting_recipe/tribalwar/silverbow,
	///datum/crafting_recipe/tribalwar/arrowbone,
	///datum/crafting_recipe/tribalwar/arrowemp,
	/datum/crafting_recipe/tribalwar/bonespear,
	/datum/crafting_recipe/tribalwar/bonecodpiece,
	/datum/crafting_recipe/tribalwar/bracers,
	///datum/crafting_recipe/tribal/bonetalisman,
	/datum/crafting_recipe/spearfisher,
	/datum/crafting_recipe/bitterdrink,
	/datum/crafting_recipe/bitterdrink5,
	/datum/crafting_recipe/healpoultice,
	/datum/crafting_recipe/healpoultice5,
	/datum/crafting_recipe/redambrosia,
	/datum/crafting_recipe/blueambrosia,
	/datum/crafting_recipe/greenambrosia,
	/datum/crafting_recipe/food/pemmican,
	/datum/crafting_recipe/tribal/bonebag,
	/datum/crafting_recipe/horsecream_good))

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

/datum/job/tribal/f13chief
	title = "Chief"
	flag = F13CHIEF
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 1
	spawn_positions = 1
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "The Elders of the tribe."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "The leader and central political figure in this village of the Suplphur Bottom Tribe. You engage in diplomatic meetings with the powers present within the Region to ensure the village's safety and independence."
	selection_color = "#006666"
	outfit = /datum/outfit/job/tribal/f13chief
	exp_requirements = 0

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

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
	jobtype =	/datum/job/tribal/f13chief
	head =	/obj/item/clothing/head/helmet/f13/wayfarer/chief/green
	uniform =	/obj/item/clothing/under/f13/wayfarer
	belt =	/obj/item/storage/backpack/spearquiver
	neck =	/obj/item/clothing/neck/mantle/chief
	id =	/obj/item/card/id/tribetattoo
	suit =	/obj/item/clothing/suit/hooded/cloak/hhunter
	suit_store =	/obj/item/twohanded/spear/bonespear/deathclaw
	backpack_contents = list(
		/obj/item/restraints/legcuffs/bola = 1,
		/obj/item/reagent_containers/pill/healingpowder = 2,
		/obj/item/stack/medical/gauze = 1,
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/supplykit = 1,
		/obj/item/cool_book/chiefguide = 1
	)

/*
Tribal Shaman
*/
/datum/job/tribal/f13shaman
	title = "Spiritual Leader"
	flag = F13SHAMAN
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 2
	spawn_positions = 2
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "The chief.  You are a peer to the harvest leader."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "The spiritual leader and medical leader of the Sulphur Bottom Tribe. You aid villagers in their day to day lives but also have access to the spiritual realm via your scrying orb to render assistance on a wider scale."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13shaman

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
/*
	loadout_options = list(
		/datum/outfit/loadout/seeker, //Seeker
	)
*/

	matchmaking_allowed = list(
		/datum/matchmaking_pref/mentor = list(
			/datum/job/tribal/f13druid,
		),
	)


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
	jobtype = /datum/job/tribal/f13shaman
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
		/obj/item/cool_book/shamanguide = 1,
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
/datum/job/tribal/f13Hhunter
	title = "Head Forager"
	flag = F13HHUNTER
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 1
	spawn_positions = 1
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "The Elders of the tribe and the chief."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are the village Hunt Master; you organize the hunters of the tribe and are the authority in matters of protecting the tribe and the land of the Sulphur Bottom. You lead the Great Hunts and War-Bands in time of conflict."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13Hhunter
	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/tribal/f13hunter,
		),
	)

/datum/outfit/job/tribal/f13Hhunter/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TRAPPER, src)

/datum/outfit/job/tribal/f13Hhunter
	name = "Head Forager"
	jobtype = /datum/job/tribal/f13Hhunter
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
		/obj/item/cool_book/warriorguide = 1
	)

/*
Druid
*/

/datum/job/tribal/f13druid
	title = "Harvest Leader"
	flag = F13DRUID
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 2
	spawn_positions = 2
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "The Chief"
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are a Harvest Leader in the tribe; while you are the one who would be performing rituals for the tribe your usual job is helping the farmers get the most out of our fields."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13druid
	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/tribal/f13villager,
			/datum/job/tribal/f13spiritpledged,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/f13shaman,
		),
	)


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
	jobtype = /datum/job/tribal/f13druid
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
		/obj/item/cool_book/druidguide=1,
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
	description = "A proud member of the Sulphur Bottom tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe. While it is common to venture out into the wasteland, do not tread far or without informing your kin."
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
			/datum/job/tribal/f13spiritpledged,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/f13druid,
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
		/obj/item/cool_book/villagerguide = 1
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
/datum/job/tribal/f13hunter
	title = "Forager"
	flag = F13HUNTER
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = -1
	spawn_positions = -1
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "The chief and Hunt Master. Failing their appearance you fall back on the Spiritual Leader and Harvest Leader for task management."
	enforces = "The ways of the Sulphur River spirits."
	forbids = "Against abuse of pre-collapse technology, especially pre-collapse weapons of war. Your pipboy is pre-blessed."
	description = "You are a Forager and lowest ranking villager of the tribe; you bring back food and relics, anything that may house a spirit infused from the Time of Crying that can be purified by the Spiritual Leader. While a protector you are also the arm of the tribe in the world, performing tasks from the Spiritual Leaders and Harvest Leaders."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13hunter

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
/*
	loadout_options = list(
		/datum/outfit/loadout/ranged,
		/datum/outfit/loadout/melee,
		/datum/outfit/loadout/healer,
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
			/datum/job/tribal/f13spiritpledged,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/f13Hhunter,
		),
	)


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
		/obj/item/cool_book/warriorguide = 1
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
/datum/job/tribal/f13spiritpledged
	title = "Spirit-Pledged"
	flag = F13SPIRITPLEDGED
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = -1
	spawn_positions = -1
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "All other tribals."
	description = "An outsider to the tribe, you have been welcomed in by their higher ups to learn more about the tribes way of life. Perhaps you will attempt to join the tribe, but its not a requirement."
	selection_color = "#006666"

	outfit = /datum/outfit/job/tribal/f13spiritpledged

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/tribal,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/f13druid,
			/datum/job/tribal/f13villager,
			/datum/job/tribal/f13hunter,
		),
	)

/datum/outfit/job/tribal/f13spiritpledged
	name = "Spirit-Pledged"
	jobtype = /datum/job/tribal/f13spiritpledged
	uniform = /obj/item/clothing/under/f13/wayfarer
	id = /obj/item/card/id/tribetattoo
	belt = /obj/item/supplykit
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign)

/*
Guardian
*/

/datum/job/tribal/f13guardian
	title = "Guardian"
	flag = F13GUARDIAN
	department_flag = TRIBAL
	faction = FACTION_TRIBE
	total_positions = 3
	spawn_positions = 3
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "All leadership, but the Chief is priority"
	description = "A hand chosen Forager with much promise, you are one of the village Guardians. An elite Hunter given the duty to protect the village, your duty is to ensure your kin are safe at all costs, as well as follow any orders from your superiors and enforce the law of the tribe. You should focus on being available in case of emergencies."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/tribal/f13guardian

	access = list(ACCESS_TRIBE)
	minimal_access = list(ACCESS_TRIBE)

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
	jobtype = /datum/job/tribal/f13guardian
	uniform = /obj/item/clothing/under/f13/wayfarer/hunter
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	suit = /obj/item/clothing/suit/armor/medium/tribal/tribe_heavy_armor
	//suit_store = /obj/item/twohanded/spear/bonespear/deathclaw
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/card/id/selfassign,
		/obj/item/reagent_containers/pill/healingpowder=2,
		/obj/item/stack/medical/gauze=1,
		/obj/item/restraints/legcuffs/bola/tactical=1,
		/obj/item/cool_book/warriorguide = 1
	)

/datum/job/tribal/f13dualcitizen
	title = "Dual Citizen"
	flag = F13VILLAGER
	department_flag = TRIBAL | DEP_OASIS
	faction = FACTION_TRIBE
	total_positions = -1
	spawn_positions = -1
	exp_type = EXP_TYPE_TRIBAL
	supervisors = "New Boston's laws and all tribe members aside from other villagers"
	description = "A proud member of the Sulphur Bottom tribe, you do what needs to be done to ensure the survival of yourself and your people while following the laws of the tribe. While it is common to venture out into the wasteland, do not tread far or without informing your kin. You are also a citizen living in Nash. Treat your town with respect and make sure to follow the laws in place, as your premium status may be revoked if you are considered a danger to the populace. One of the local businesses may have work if you require funds."
	selection_color = "#006666"
	exp_requirements = 0

	outfit = /datum/outfit/job/den/f13dualcitizen

	access = list(ACCESS_TRIBE, ACCESS_BAR)
	minimal_access = list(ACCESS_TRIBE, ACCESS_BAR)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/tribal,
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/tribal,
			/datum/job/oasis
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/tribal/f13villager,
			/datum/job/tribal/f13spiritpledged,
		),
		/datum/matchmaking_pref/disciple = list(
			/datum/job/tribal/f13druid,
			/datum/job/tribal/f13villager,
			/datum/job/tribal/f13hunter,
		),
	)

/datum/outfit/job/den/f13dualcitizen
	name = "Dual Citizen"
	jobtype = /datum/job/tribal/f13dualcitizen
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/wayfarer
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/sandal
	id = /obj/item/card/id/tribetattoo
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/cool_book/villagerguide = 1
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
