/*
Town access doors
Sheriff/Deputy, Gatehouse etc: 62 ACCESS_GATEWAY
General access: 25 ACCESS_BAR
Clinic surgery/storage: 68 ACCESS_CLONING
Shopkeeper: 34 ACCESS_CARGO_BOT / 31 ACCESS CARGO
Barkeep : 28 ACCESS_KITCHEN - you jebronis made default bar for no reason bruh
Prospector : 48 ACCESS_MINING
Detective : 4 ACCESS_FORENSICS_LOCKERS
here's a tip, go search DEFINES/access.dm
*/

// Headsets for everyone!!
/datum/outfit/job/den
	name = "New Boston Default Template"
	ears = /obj/item/radio/headset/headset_town
	belt = /obj/item/supplykit
	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/settler
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/satchel/explorer
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/melee/onehanded/knife/hunting = 1
		)

/*
Mayor
*/

/datum/job/oasis
	exp_type = EXP_TYPE_OASIS
	faction = FACTION_OASIS

/datum/job/oasis/f13mayor   // /obj/item/card/id/captains_spare for any elected mayors. - Blue
	title = "High Alderperson"
	flag = F13MAYOR
	department_flag = DEP_OASIS
	total_positions = 0
	spawn_positions = 0
	supervisors = "New Boston"
	description = "You are the civil leader of the Town of New Boston. You were chosen by the people to represent and lead them from your manor. Your town is in a terse situation with the slaver town to the south, Redwater. While not at war, you will have to work to keep your people safe from their predations. The Tribals to the south east are also a nuisance but it's best not to provoke them needlessly. Do what's best for the town, and it's people. All while lining your pockets occasionally, of course."
	enforces = "The Secretary is your stand-in replacement, and under this the Sheriff."
	selection_color = "#d7b088"

	exp_requirements = 0

	outfit = /datum/outfit/job/den/f13mayor
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_CLINIC, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_FOLLOWER)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)
/*
	loadout_options = list(
		/datum/outfit/loadout/mayoral,
		/datum/outfit/loadout/dictator,
		/datum/outfit/loadout/firstcitizen,
		/datum/outfit/loadout/highroller
		)
*/

/*
/datum/outfit/job/den/f13mayor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
*/

/datum/outfit/job/den/f13mayor
	name = "High Alderperson"
	jobtype = /datum/job/oasis/f13mayor
	id = /obj/item/card/id/silver/mayor
	ears = /obj/item/radio/headset/headset_town/mayor
	backpack = /obj/item/storage/backpack/satchel/explorer
	belt = /obj/item/supplykit
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/wallet/stash/high
	r_pocket = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/f13/tan
	uniform = /obj/item/clothing/under/f13/gentlesuit
	head = /obj/item/clothing/head/f13/town/big
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/box/citizenship_permits = 1,
		/obj/item/pen/fountain/captain = 1
		)



/datum/outfit/loadout/dictator
	name = "Alderman for Life"
	backpack_contents = list(
	/obj/item/clothing/under/f13/general/oasis = 1,
	/obj/item/clothing/head/f13/army/general = 1,
	// /obj/item/ammo_box/magazine/m45 = 2,
	/obj/item/clothing/shoes/jackboots = 1,
	/obj/item/clothing/mask/cigarette/pipe/cobpipe = 1
	)

/datum/outfit/loadout/mayoral
	name = "Frontier Leader"
	backpack_contents = list(
		/obj/item/clothing/suit/armor/medium/duster/town/mayor = 1,
		/obj/item/clothing/head/f13/town/mayor = 1,
		// /obj/item/gun/ballistic/revolver/m29/peacekeeper = 1,
		// /obj/item/ammo_box/m44 = 2,
		/obj/item/clothing/shoes/f13/cowboy = 1,
		/obj/item/clothing/mask/cigarette/cigar = 1
		)

/datum/outfit/loadout/firstcitizen
	name = "First Citizen"
	backpack_contents = list(
		/obj/item/clothing/under/f13/vault = 1,
		/obj/item/clothing/shoes/jackboots = 1,
		/obj/item/clothing/suit/armor/light/duster/battlecoat/vault/overseer = 1,
		/obj/item/reagent_containers/food/drinks/flask/vault113 = 1,
		// /obj/item/gun/ballistic/automatic/pistol/beretta/automatic = 1,
		// /obj/item/ammo_box/magazine/m9mm/doublestack = 1
		)

/datum/outfit/loadout/highroller
	name = "High Roller"
	backpack_contents = list(
		/obj/item/clothing/glasses/orange = 1,
		/obj/item/clothing/suit/armor/outfit/vest = 1,
		/obj/item/clothing/under/f13/sleazeball = 1,
		/obj/item/clothing/shoes/laceup = 1,
		/obj/item/toy/cards/deck/unum = 1,
		// /obj/item/gun/ballistic/automatic/pistol/mk23 = 1,
		// /obj/item/ammo_box/magazine/m45/socom = 2
	)


/*--------------------------------------------------------------*/

/datum/job/oasis/f13secretary
	title = "Deputy Mayor"
	flag = F13SECRETARY
	department_flag = DEP_OASIS
	total_positions = 1
	spawn_positions = 1
	supervisors = "your constituents, your greed, and realpolitik"
	description = "Welcome to the show, kid. Through nepotism, Edisons, or genuine democracy, you've gotten a place as one of the Deputy Mayors of New Boston. Keep the town running smoothly; help your constituents without stepping on their toes, or don't.  They'll probably only shoot you some."
	enforces = "You serve as the de-facto leader of New Boston, but you have very little actual power. Good luck with that!"
	selection_color = "#d7b088"
	exp_requirements = 0


	outfit = /datum/outfit/job/den/f13secretary
/*
	loadout_options = list(
	/datum/outfit/loadout/pr,
	/datum/outfit/loadout/pw
	)
*/
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_CLINIC, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_FOLLOWER)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13secretary
	name = "Councilperson"
	jobtype = /datum/job/oasis/f13secretary
	id = /obj/item/card/id/silver
	belt = /obj/item/supplykit
	ears = /obj/item/radio/headset/headset_town/mayor
	glasses = /obj/item/clothing/glasses/regular/hipster
	gloves = /obj/item/clothing/gloves/color/white
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	r_hand = /obj/item/storage/briefcase/secretary
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/f13/fancy
	uniform = /obj/item/clothing/under/suit/black
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/ammo_box/magazine/m9mm = 1,
		/obj/item/melee/onehanded/knife/switchblade = 1,
		/obj/item/pda = 1
		)

/datum/outfit/loadout/pr
	name = "Public Relations"
	backpack_contents = list(
		/obj/item/megaphone = 1,
		/obj/item/reagent_containers/food/snacks/store/cake/birthday = 1,
		/obj/item/clothing/accessory/medal/ribbon = 1,
		/obj/item/clothing/gloves/color/latex/nitrile = 1,
		/obj/item/camera = 1,
		/obj/item/storage/crayons = 1,
		/obj/item/choice_beacon/box/carpet = 1
		)

/datum/outfit/loadout/pw
	name = "Public Works"
	backpack_contents = list(
		/obj/item/clothing/head/hardhat = 1,
		/obj/item/clothing/suit/hazardvest = 1,
		/obj/item/stack/sheet/metal/twenty = 2,
		/obj/item/stack/sheet/glass/ten = 2,
		/obj/item/stack/sheet/mineral/concrete/ten = 2
		)

/*
/datum/outfit/job/den/f13secretary/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policepistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steelbib/heavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/armyhelmetheavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)
*/


/*--------------------------------------------------------------*/

/datum/job/oasis/f13sheriff
	title = "Sheriff"
	flag = F13SHERIFF
	department_flag = DEP_OASIS
	head_announce = list("Security")
	total_positions = 0
	spawn_positions = 1
	supervisors = "The Mayor"
	description = "You are the civil enforcer of New Boston, keeping the settlement within firm control under the authority of the Mayor. With your loyal patrolmen, you maintain your claim to authority by keeping the peace, managing disputes, and protecting the citizens from threats within and without. Never leave New Bostonundefended, and don't let its people die out. If this town falls, new conquerors don't tend to look kindly upon the old law."
	enforces = "You are the stand-in leader of New Bostonif a Mayor or Secretary does not exist."
	selection_color = "#d7b088"
	exp_requirements = 0

	outfit = /datum/outfit/job/den/f13sheriff
/*
	loadout_options = list(
	/datum/outfit/loadout/thelaw,
	/datum/outfit/loadout/thechief,
	/datum/outfit/loadout/thedictator
	)
*/
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLINIC, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS, ACCESS_CLINIC, ACCESS_FOLLOWER)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13sheriff
	name = "Sheriff"
	jobtype = /datum/job/oasis/f13sheriff
	id = /obj/item/card/id/dogtag/sheriff
	belt = /obj/item/supplykit
	ears = /obj/item/radio/headset/headset_town/lawman
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	uniform = /obj/item/clothing/under/f13/sheriff
	shoes = /obj/item/clothing/shoes/f13/cowboy
	glasses = /obj/item/clothing/glasses/sunglasses
	l_pocket = /obj/item/storage/wallet/stash/high
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/box/deputy_badges = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/melee/baton/loaded = 1,
		/obj/item/melee/onehanded/knife/bowie = 1,
		/obj/item/grenade/flashbang = 1,
		/obj/item/storage/belt/army = 1,
		/obj/item/gun/energy/taser = 1
		)

/datum/outfit/loadout/thelaw
	name = "The Law Man"
	suit = /obj/item/clothing/suit/armor/medium/duster/town/sheriff
	head = /obj/item/clothing/head/f13/town/sheriff
	uniform = /obj/item/clothing/under/f13/police/formal
	neck = /obj/item/storage/belt/shoulderholster
	//r_hand = /obj/item/gun/ballistic/rifle/repeater/brush
	shoes = /obj/item/clothing/shoes/f13/military/plated

	//backpack_contents = list(
	//	/obj/item/ammo_box/tube/c4570 = 3,
	//	/obj/item/gun_upgrade/scope/watchman = 1
	//	)

/datum/outfit/loadout/thechief
	name = "The Chief"
	uniform = /obj/item/clothing/under/f13/police/chief
	suit = /obj/item/clothing/suit/armor/medium/duster/town/chief
	head = /obj/item/clothing/head/f13/town/chief
	neck = /obj/item/storage/belt/shoulderholster/ranger45
	shoes = /obj/item/clothing/shoes/combat
	// r_hand = /obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	//backpack_contents = list(/obj/item/ammo_box/shotgun/slug = 1,
	//	/obj/item/ammo_box/shotgun/buck = 2
	//	)

/datum/outfit/loadout/thedictator
	name = "The Dictator"
	uniform = /obj/item/clothing/under/f13/police/chief
	suit = /obj/item/clothing/suit/armor/medium/duster/town/sheriff
	//r_hand = /obj/item/gun/energy/laser/scatter
	//backpack_contents = list(/obj/item/stock_parts/cell/ammo/mfc = 1,
	//	)

/*
/datum/outfit/loadout/pew
	name = "Tactical"
	suit_store = /obj/item/gun/ballistic/shotgun/automatic/combat/citykiller
	backpack_contents = list(
		/obj/item/stock_parts/cell/ammo/ecp = 1,
		/obj/item/ammo_box/shotgun/bean = 1,
		/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/ammo_box/shotgun/trainshot = 1,
		/obj/item/gun/energy/laser/auto/oasis = 1,
		)
*/

/*
/datum/outfit/job/den/f13sheriff/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policepistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steelbib/heavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/armyhelmetheavy)
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)
*/

/*--------------------------------------------------------------*/

/datum/job/oasis/f13deputy
	title = "New Boston Security"
	flag = F13DEPUTY
	department_flag = DEP_OASIS
	total_positions = -1
	spawn_positions = -1
	supervisors = "Your best Judgement"
	description = "You are a loyal protector of New Boston, keeping the settlement within firm control under the authority of the Mayor. Maintain your claim to authority by keeping the peace, managing disputes, and protecting the citizens from threats within and without. Never leave New Bostonundefended, and don't let its people die out."
//	enforces = "You may be elected temporary Sheriff if one does not exist. This may make you the stand-in leader of New Bostonif a Mayor or Secretary does not exist."
	selection_color = "#dcba97"
	exp_type = EXP_TYPE_OASIS
	exp_requirements = 0
/*
	loadout_options = list(
	/datum/outfit/loadout/frontierjustice,
	/datum/outfit/loadout/police,
	/datum/outfit/loadout/swat,
	/datum/outfit/loadout/energy,
	)
*/
	outfit = /datum/outfit/job/den/f13deputy
	access = list(ACCESS_BAR, ACCESS_GATEWAY)
	minimal_access = list(ACCESS_BAR, ACCESS_GATEWAY)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13deputy
	name = "Deputy"
	jobtype = /datum/job/oasis/f13deputy
	id = /obj/item/card/id/dogtag/deputy
	ears = /obj/item/radio/headset/headset_town/lawman
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	belt = /obj/item/supplykit
	suit_store = /obj/item/storage/belt/legholster
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/flashlight/flare
	shoes = /obj/item/clothing/shoes/f13/explorer
	uniform = /obj/item/clothing/under/f13/cowboyb
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/melee/onehanded/knife/bowie = 1,
		/obj/item/grenade/flashbang = 1,
		/obj/item/flashlight/seclite = 1,
		/obj/item/storage/belt/army/assault = 1,
		/obj/item/gun/energy/taser = 1
		)

/datum/outfit/loadout/frontierjustice
	name = "Frontier Justice"
	suit = /obj/item/clothing/suit/armor/medium/duster/town/deputy
	head = /obj/item/clothing/head/f13/town/deputy
	neck = /obj/item/storage/belt/shoulderholster
	//r_hand = /obj/item/gun/ballistic/rifle/repeater/trail
	//backpack_contents = list(
	//	/obj/item/ammo_box/tube/m44 = 2,
	//	/obj/item/ammo_box/m44 = 2,
	//	/obj/item/gun/ballistic/revolver/m29 = 1,
	//	)

/datum/outfit/loadout/police
	name = "New Boston PD"
	uniform = /obj/item/clothing/under/f13/police/officer
	suit = /obj/item/clothing/suit/armor/heavy/vest/bulletproof
	head = /obj/item/clothing/head/f13/town/officer
	belt = /obj/item/storage/belt/legholster
	//r_hand = /obj/item/gun/ballistic/shotgun/police
	shoes = /obj/item/clothing/shoes/jackboots
	//backpack_contents = list(
	//	/obj/item/ammo_box/shotgun/bean = 1,
	//	/obj/item/ammo_box/shotgun/buck = 1,
	//	/obj/item/ammo_box/a357 = 3,
	//	/obj/item/flashlight/seclite = 1,
	//	/obj/item/gun/ballistic/revolver/police = 1
	//	)

/datum/outfit/loadout/swat
	name = "S.W.A.T. Officer"
	uniform = /obj/item/clothing/under/f13/police/swat
	suit = /obj/item/clothing/suit/armor/heavy/vest/bulletproof
	head = /obj/item/clothing/head/helmet/alt
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/f13/military
	//suit_store = /obj/item/gun/ballistic/automatic/assault_carbine/policerifle
	//backpack_contents = list(
	//	/obj/item/ammo_box/magazine/m45/socom=2,
	//	/obj/item/gun/ballistic/automatic/pistol/mk23=1,
	//	/obj/item/ammo_box/magazine/m5mm=1,
	//	/obj/item/flashlight/seclite = 1
	//	)

/datum/outfit/loadout/energy
	name = "High Tech Officer"
	uniform = /obj/item/clothing/under/f13/police/officer
	suit = /obj/item/clothing/suit/armor/heavy/metal/polished
	gloves = /obj/item/clothing/gloves/f13/military
	//suit_store = /obj/item/gun/energy/laser/aer9
	//backpack_contents = list(
	//	/obj/item/stock_parts/cell/ammo/mfc = 1
	//	)

/*
/datum/outfit/job/den/f13deputy/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
*/

/*--------------------------------------------------------------*/
/*
/datum/job/oasis/f13farmer
	title = "Farmer"
	flag = F13FARMER
	department_flag = DEP_OASIS
	total_positions = 4
	spawn_positions = 4
	supervisors = "New Boston laws"
	description = "You are a farmer living in New Boston. Treat your town with respect and make sure to follow the laws in place, as your premium status may be revoked if you are considered a danger to the populace."
	enforces = "Farming is a public service, and you are under control of local governance - and you are expected to produce food."
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13farmer

	access = list(ACCESS_BAR, ACCESS_KITCHEN)
	minimal_access = list(ACCESS_BAR, ACCESS_KITCHEN)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis,
		),
	)
/*
	loadout_options = list(
	/datum/outfit/loadout/abiotic,
	/datum/outfit/loadout/pomologist,
	/datum/outfit/loadout/zany,)
*/
/datum/outfit/job/den/f13farmer
	name = "Farmer"
	jobtype = /datum/job/oasis/f13farmer

	id = /obj/item/card/id/dogtag/town

	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	belt = /obj/item/storage/bag/plants
	backpack_contents = list(
		/obj/item/cultivator=1, \
		/obj/item/hatchet=1,
		/obj/item/shovel/spade=1, \
		/obj/item/gun/ballistic/automatic/pistol/n99, \
		/obj/item/ammo_box/magazine/m10mm/adv/simple=2)
	shoes = 		/obj/item/clothing/shoes/workboots

/datum/outfit/job/den/f13settler/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = pick(
		/obj/item/clothing/under/f13/settler, \
		/obj/item/clothing/under/f13/brahminm, \
		/obj/item/clothing/under/f13/machinist, \
		/obj/item/clothing/under/f13/lumberjack, \
		/obj/item/clothing/under/f13/roving)

/datum/outfit/loadout/abiotic
	name = "Abiotic"
	backpack_contents = list(
		/obj/item/seeds/bamboo = 1,
		/obj/item/seeds/glowshroom = 1,
		/obj/item/seeds/tower = 1,
		)

/datum/outfit/loadout/pomologist
	name = "Pomologist"
	backpack_contents = list(
		/obj/item/seeds/grape/green = 1,
		/obj/item/seeds/apple/gold = 1,
		/obj/item/seeds/cherry/blue = 1,
		)

/datum/outfit/loadout/zany
	name = "Zany"
	backpack_contents = list(
		/obj/item/clothing/mask/cigarette/pipe = 1,
		/obj/item/seeds/cannabis = 1,
		/obj/item/seeds/tea/catnip = 1,
		)
*/
/*--------------------------------------------------------------*/
/*
/datum/job/oasis/f13prospector
	title = "Prospector"
	flag = F13PROSPECTOR
	department_flag = DEP_OASIS
	total_positions = 4
	spawn_positions = 4
	supervisors = "The Mayor"
	description = "Prospecting is a complicated business. Some call it scrounging or looting, but there is more to it than sifting through rubble - few can boast the valuable skills of mining and scavenging the ruins of fallen empires. The settlement of New Bostonunderstands the value of this, and you've found purpose within their mines. Sell the materials you find to the highest bidder - the local store may be particularly interested in metals."
	enforces = "Mining is a public service, and you are under control of local governance - but by default you are expected to work with private businesses and individual clients."
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13prospector

	access = list(ACCESS_BAR, ACCESS_MINING)
	minimal_access = list(ACCESS_BAR, ACCESS_MINING)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis,
		),
	)
/*
	loadout_options = list(
	/datum/outfit/loadout/engineer,
	/datum/outfit/loadout/miner,)
*/
/datum/outfit/job/den/f13prospector
	name = "Prospector"
	jobtype = /datum/job/oasis/f13prospector

	id = /obj/item/card/id/dogtag/town
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/lantern
	belt = /obj/item/storage/bag/ore
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(
		/obj/item/mining_scanner,
		/obj/item/melee/onehanded/knife/hunting,
		/obj/item/gun/ballistic/automatic/pistol/n99,
		/obj/item/ammo_box/magazine/m10mm/adv/simple = 2,
		w = 1,
		)

/datum/outfit/job/den/f13settler/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = pick(
		/obj/item/clothing/under/f13/machinist, \
		/obj/item/clothing/under/f13/roving, \
		/obj/item/clothing/under/f13/cowboyt)

/datum/outfit/job/den/f13prospector/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/loadout/engineer
	name = "Engineer"
	suit = /obj/item/clothing/suit/apron/overalls
	glasses = /obj/item/clothing/glasses/welding
	uniform = /obj/item/clothing/under/misc/overalls
	belt = /obj/item/storage/belt/utility/full
	shoes = /obj/item/clothing/shoes/workboots
	backpack_contents = list(
		/obj/item/pickaxe/mini = 1,
		/obj/item/shovel/spade = 1,
		)

/datum/outfit/loadout/miner
	name = "Miner"
	suit = /obj/item/clothing/suit/armor/light/leather/rig
	uniform = /obj/item/clothing/under/f13/lumberjack
	head = /obj/item/clothing/head/hardhat
	belt = /obj/item/storage/belt/utility/mining/alt
	shoes = /obj/item/clothing/shoes/f13/miner
	backpack_contents = list(
		/obj/item/t_scanner/adv_mining_scanner = 1,
		/obj/item/pickaxe/silver = 1,
		/obj/item/shovel = 1,
		)
*/

/*--------------------------------------------------------------*/

/datum/job/oasis/f13dendoc
	title = "Doctor"
	flag = F13DENDOC
	department_flag = DEP_OASIS
	total_positions = 0
	spawn_positions = 0
	supervisors = "The Mayor"
	description = "Handy with a scalpel and scanner, your expertise in the practice of medicine makes you an indispensible asset to the settlement of New Boston. Just remember that you're no Follower - medicine doesn't come for free, and you aren't here out of the kindness of your heart. Make sure to turn a profit on your services, or the Mayor might reconsider your position!"
	enforces = "Medicine is a public service, and you are under control of local governance - but remember public doesn't equate to free."
	selection_color = "#dcba97"
/*
	loadout_options = list(
	/datum/outfit/loadout/rescueranger,
	/datum/outfit/loadout/stitcher,
	/datum/outfit/loadout/mixer,
	/datum/outfit/loadout/holidaydoc)
*/
	outfit = /datum/outfit/job/den/f13dendoc
	access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING, ACCESS_FOLLOWER)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13dendoc
	name = "Doctor"
	jobtype = /datum/job/oasis/f13dendoc
	chemwhiz = TRUE
	belt = /obj/item/supplykit
	ears = /obj/item/radio/headset/headset_town/medical
	uniform = /obj/item/clothing/under/f13/medic
	neck = /obj/item/clothing/neck/stethoscope
	suit = /obj/item/clothing/suit/toggle/labcoat
	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	shoes = /obj/item/clothing/shoes/sneakers/white
	id = /obj/item/card/id/dendoctor
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/reagent_containers/hypospray/medipen/stimpak=2,
		/obj/item/storage/firstaid/regular,
		/obj/item/clothing/accessory/armband/medblue
		)
/datum/outfit/job/den/f13dendoc/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(GLOB.chemwhiz_recipes)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_CHEMWHIZ, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)

/datum/outfit/loadout/rescueranger
	name = "Search and Rescue"
	backpack_contents = list(/obj/item/clothing/head/f13/police/sergeant = 1,
	//	/obj/item/gun/ballistic/shotgun/automatic/combat/auto5 = 1,
	//	/obj/item/ammo_box/shotgun/buck = 1,
		/obj/item/clothing/suit/toggle/labcoat/paramedic = 1,
		/obj/item/folder/white = 1,
		/obj/item/flashlight/pen/paramedic = 1
		)

/datum/outfit/loadout/stitcher
	name = "Stitcher"
	backpack_contents = list(/obj/item/clothing/head/hardhat/white = 1,
		/obj/item/grenade/flashbang = 1,
		/obj/item/clothing/glasses/welding = 1,
		/obj/item/storage/belt/medical/primitive = 1,
		/obj/item/storage/medical/ancientfirstaid = 1,
		/obj/item/circuitboard/machine/limbgrower = 1,
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/storage/belt/legholster/police = 1
		)

/datum/outfit/loadout/mixer
	name = "Mixer"
	backpack_contents = list(/obj/item/clothing/head/beret/chem = 1,
		/obj/item/melee/classic_baton/police = 1,
		/obj/item/pen/sleepy = 1,
		/obj/item/reagent_containers/glass/beaker/plastic = 1,
		/obj/item/reagent_containers/glass/beaker/meta = 1,
		/obj/item/reagent_containers/hypospray = 1,
		/obj/item/circuitboard/machine/bloodbankgen = 1
		)

/datum/outfit/loadout/holidaydoc
	name = "Holiday Doc"
	backpack_contents = list(/obj/item/vending_refill/medical = 1,
		/obj/item/pda/medical = 1,
		/obj/item/clothing/suit/hooded/surgical = 1,
		/obj/item/storage/medical/ancientfirstaid = 1,
	//	/obj/item/ammo_box/m44 = 1,
	//	/obj/item/gun/ballistic/revolver/m29/snub = 1
		)
/*--------------------------------------------------------------*/

/datum/job/oasis/f13settler
	title = "Citizen"
	flag = F13SETTLER
	department_flag = DEP_OASIS
	total_positions = -1
	spawn_positions =-1
	supervisors = "New Boston's laws"
	description = "You are a citizen living in New Boston. Treat your town with respect and make sure to follow the laws in place, as your premium status may be revoked if you are considered a danger to the populace. One of the local businesses may have work if you require funds."
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13settler

	/*
	loadout_options = list(
		/datum/outfit/loadout/provisioner,
		/datum/outfit/loadout/groundskeeper,
		/datum/outfit/loadout/artisan,
		/datum/outfit/loadout/outdoorsman,
		/datum/outfit/loadout/militia,
		/datum/outfit/loadout/singer,
		/datum/outfit/loadout/farmer,
		/datum/outfit/loadout/prospector
	)*/
	access = list(ACCESS_BAR)
	minimal_access = list(ACCESS_BAR)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)


/datum/outfit/job/den/f13settler
	name = "Citizen"
	jobtype = /datum/job/oasis/f13settler
	belt = /obj/item/supplykit
	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/settler
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/satchel/explorer
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/pda = 1,
		///obj/item/melee/onehanded/knife/hunting = 1 //you already got a knife
		)

/datum/outfit/job/den/f13settler/pre_equip(mob/living/carbon/human/H)
	. = ..()
	/*people generally find their own hats
	head = pick(/obj/item/clothing/head/f13/ranger_hat/tan,
		/obj/item/clothing/head/soft/mime,
		/obj/item/clothing/head/soft/black,
		/obj/item/clothing/head/soft/grey,
		/obj/item/clothing/head/f13/gambler,
		/obj/item/clothing/head/f13/cowboy,
		/obj/item/clothing/head/f13/ranger_hat/banded,
		/obj/item/clothing/head/cowboyhat/white,
		/obj/item/clothing/head/beret/headband,
		/obj/item/clothing/head/cowboyhat/pink,
		/obj/item/clothing/head/f13/police/trooper,
		/obj/item/clothing/head/fedora/curator,
		/obj/item/clothing/head/fedora/det_hat,
		/obj/item/clothing/head/bowler)
		*/ //they do need a uniform tho
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

/*
/datum/outfit/loadout/provisioner
	name = "Provisioner"
	neck = /obj/item/clothing/neck/scarf/cptpatriot
	suit = /obj/item/clothing/suit/jacket/miljacket
	neck = /obj/item/clothing/ears/headphones
	gloves = /obj/item/pda
	shoes = /obj/item/clothing/shoes/f13/explorer
	uniform = /obj/item/clothing/under/f13/merca
	gloves = /obj/item/clothing/gloves/f13/leather
	shoes = /obj/item/clothing/shoes/f13/explorer
	backpack_contents = list(/obj/item/reagent_containers/food/drinks/flask = 1,
	///obj/item/gun/ballistic/automatic/pistol/n99 = 1,
	///obj/item/ammo_box/magazine/m10mm/adv/simple = 1,
	/obj/item/storage/medical/ancientfirstaid = 1,
	/obj/item/reagent_containers/food/drinks/flask/survival = 1,
	///obj/item/gun/ballistic/automatic/pistol/n99 = 1,
	///obj/item/ammo_box/magazine/m10mm/adv/simple = 1
	)

/datum/outfit/loadout/groundskeeper
	name = "Groundskeeper"
	head = /obj/item/clothing/head/soft/grey
	belt = /obj/item/storage/belt/utility/waster
	suit = /obj/item/clothing/under/f13/mechanic
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/sneakers/noslip
	neck = /obj/item/storage/belt/shoulderholster/
	backpack_contents = list(/obj/item/storage/bag/trash = 1,
	/obj/item/reagent_containers/spray/cleaner = 1,
	/obj/item/mop = 1,
	/obj/item/reagent_containers/glass/bucket/plastic = 1,
	/obj/item/broom = 1,
	/obj/item/stack/sheet/metal/fifty = 1,
	/obj/item/lightreplacer = 1,
	/obj/item/reagent_containers/spray/cleaner = 1
	)

/datum/outfit/loadout/artisan
	name = "Artisan"
	uniform = /obj/item/clothing/under/f13/cowboyg
	belt = /obj/item/storage/belt/utility/mining/alt
	gloves = /obj/item/clothing/gloves/f13/blacksmith
	shoes = /obj/item/clothing/shoes/f13/military/leather
	neck = /obj/item/storage/belt/shoulderholster
	backpack_contents = list(/obj/item/twohanded/sledgehammer/simple = 1,
	/obj/item/book/granter/crafting_recipe/ODF = 1,
	/obj/item/clothing/glasses/welding = 1,
	/obj/item/storage/belt/utility/mining/alt = 1,
	/obj/item/melee/smith/hammer/premade = 1,
	/obj/item/stack/sheet/mineral/titanium = 15,
	/obj/item/pickaxe/mini = 1,
	/obj/item/mining_scanner = 1
	)

/datum/outfit/loadout/outdoorsman
	name = "Outdoorsman"
	head = /obj/item/clothing/head/helmet/f13/marlowhat
	suit = /obj/item/clothing/suit/armor/light/leather/tanvest
	belt = /obj/item/melee/onehanded/knife/bowie
	uniform = /obj/item/clothing/under/f13/cowboyt
	gloves = /obj/item/clothing/gloves/botanic_leather
	shoes = /obj/item/clothing/shoes/f13/peltboots
	backpack_contents = list(
	///obj/item/gun/ballistic/revolver/winchesterrebored = 1,
	///obj/item/ammo_box/a762/doublestacked = 2,
	/obj/item/fishingrod = 1,
	/obj/item/binoculars = 1,
	/obj/item/crafting/campfirekit = 1,
	/obj/item/storage/fancy/rollingpapers/makeshift = 1
	)

/datum/outfit/loadout/militia
	name = "Militia"
	head = /obj/item/clothing/head/helmet/armyhelmet
	suit = /obj/item/clothing/suit/armor/medium/vest/breastplate
	uniform = /obj/item/clothing/under/f13/combat/militia
	gloves = /obj/item/clothing/gloves/f13/leather
	shoes = /obj/item/clothing/shoes/f13/military
	belt = /obj/item/storage/belt/bandolier
	backpack_contents = list(
	///obj/item/ammo_box/a308 = 2,
	/obj/item/shovel/trench =1,
	/obj/item/binoculars = 1,
	///obj/item/gun/ballistic/rifle/hunting = 1,
	/obj/item/gun_upgrade/scope/watchman = 1
	)

/datum/outfit/loadout/singer
	name = "Singer"
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/clothing/under/f13/classdress = 1,
	/obj/item/clothing/under/suit/black_really = 1,
	/obj/item/clothing/gloves/evening = 1,
	/obj/item/clothing/gloves/color/white = 1,
	/obj/item/melee/classic_baton/militarypolice = 1,
	/obj/item/grenade/smokebomb = 2,
	/obj/item/clothing/accessory/pocketprotector/full = 1,
	/obj/item/choice_beacon/music = 1,
	///obj/item/gun/energy/laser/complianceregulator = 1,
	///obj/item/stock_parts/cell/ammo/ec = 1
	)

// if we ever add back the loadout display you'll have to put the items in places you want it to appear on the display model

/datum/outfit/loadout/farmer
	name = "Farmer"
	backpack_contents = list(/obj/item/clothing/head/helmet/f13/brahmincowboyhat = 1,
	/obj/item/clothing/under/f13/rustic = 1,
	/obj/item/clothing/suit/armor/light/duster/battlecoat = 1,
	/obj/item/clothing/gloves/botanic_leather = 1,
	/obj/item/twohanded/fireaxe= 1,
	/obj/item/storage/belt/utility/gardener = 1,
	/obj/item/shovel/spade = 1,
	/obj/item/cultivator = 1,
	/obj/item/reagent_containers/glass/bucket/plastic = 1,
	/obj/item/storage/bag/plants/portaseeder= 1,
	/obj/item/seeds/bamboo = 1,
	/obj/item/seeds/apple/gold = 1,
	/obj/item/seeds/cannabis = 1
	)

/datum/outfit/loadout/prospector
	name = "Prospector"
	backpack_contents = list(/obj/item/clothing/head/hardhat = 1,
	/obj/item/clothing/under/overalls = 1,
	/obj/item/clothing/suit/armor/light/leather/rig = 1,
	/obj/item/clothing/gloves/patrol = 1,
	/obj/item/clothing/shoes/workboots = 1,
	/obj/item/storage/belt/utility/waster = 1,
	/obj/item/shovel/spade = 1,
	/obj/item/pickaxe/silver = 1,
	/obj/item/clothing/glasses/welding = 1,
	/obj/item/t_scanner/adv_mining_scanner = 1,
	///obj/item/ammo_box/m44 = 2,
	///obj/item/gun/ballistic/revolver/m29/snub = 1
	)*/

/*----------------------------------------------------------------
--							Detective							--
----------------------------------------------------------------*/

/datum/job/oasis/f13detective
	title = "Detective"
	flag = F13DETECTIVE
	total_positions = 0
	spawn_positions = 1
	supervisors = "paying clients and New Boston's laws"
	selection_color = "#dcba97"
	outfit = /datum/outfit/job/oasis/f13detective

	access = list(ACCESS_BAR, ACCESS_FORENSICS_LOCKERS)
	minimal_access = list(ACCESS_BAR, ACCESS_FORENSICS_LOCKERS)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/wasteland/f13wastelander,
			/datum/job/oasis/f13detective
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/wasteland/f13wastelander,
			/datum/job/oasis/f13detective
		),
		/datum/matchmaking_pref/mentor = list(
			/datum/job/wasteland/f13wastelander
		)
	)


/datum/outfit/job/oasis/f13detective
	name = "Detective"
	jobtype = /datum/job/oasis/f13detective
	belt = /obj/item/supplykit
	suit = /obj/item/clothing/suit/det_suit/grey
	uniform = /obj/item/clothing/under/f13/detectivealt
	head = /obj/item/clothing/head/f13/det_hat_alt
	ears = /obj/item/radio/headset/headset_town/lawman
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/silver
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/flashlight/flare
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	suit_store = /obj/item/gun/ballistic/revolver
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/pda/detective=1,
		/obj/item/camera/detective=1,
		/obj/item/toy/crayon/white=1,
		/obj/item/detective_scanner=1,
		/obj/item/storage/box/gloves=1,
		/obj/item/pda = 1,
		/obj/item/storage/box/evidence=1)
		///obj/item/ammo_box/a357=2)

/*--------------------------------------------------------------*/

/datum/job/oasis/f13banker
	title = "Guild Financier"
	flag = F13BANKER
	department_flag = DEP_OASIS
	total_positions = 2
	spawn_positions = 2
	supervisors = "The Mayor"
	description = "No matter the nature of society, fortune and profit are there to be made! It is up to you to make deals, distribute caps and earn interest - an easy first venture might be safekeeping possessions in the strongboxes of your vault within the First Bank of New Boston. Ensure you make a profit and retain enough capital for your day-to-day operations. You are under the governance of New Boston, but perhaps deal-making will take you into other alliances."
	enforces = "Your bank is a private business and you are not under direct control of local governance, but are subject to their laws."
	selection_color = "#dcba97"
	outfit = /datum/outfit/job/den/f13banker
/*
	loadout_options = list(
	/datum/outfit/loadout/classy,
	/datum/outfit/loadout/loanshark,
	/datum/outfit/loadout/investor
	)
*/
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)

/datum/outfit/job/den/f13banker
	name = "Banker"
	jobtype = /datum/job/oasis/f13banker
	belt = /obj/item/supplykit

	uniform = /obj/item/clothing/under/lawyer/blacksuit
	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_town/commerce
	shoes = /obj/item/clothing/shoes/f13/fancy
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/banker = 1)

/datum/outfit/loadout/classy
	name = "Classy"
	head = /obj/item/clothing/head/collectable/tophat
	glasses = /obj/item/clothing/glasses/monocle
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	suit = /obj/item/clothing/suit/armor/outfit/jacket/banker
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/cane=1,
		///obj/item/storage/belt/shoulderholster/ranger45 =1,
		/obj/item/storage/fancy/cigarettes/cigpack_bigboss=1,
		/obj/item/reagent_containers/food/drinks/bottle/whiskey=1,
		/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass=1,
		/obj/item/lighter/gold = 1
		)

/datum/outfit/loadout/loanshark
	name = "Loanshark"
	glasses = /obj/item/clothing/glasses/orange
	mask = /obj/item/clothing/mask/cigarette/cigar
	suit = /obj/item/clothing/suit/armor/outfit/vest
	uniform = /obj/item/clothing/under/f13/sleazeball
	shoes = /obj/item/clothing/shoes/sandal
	backpack_contents = list(/obj/item/reagent_containers/food/drinks/bottle/whiskey=1,
		/obj/item/storage/box/matches=1,
		///obj/item/gun/ballistic/automatic/smg/mini_uzi=1,
		/obj/item/instrument/violin/golden = 1
		)

/datum/outfit/loadout/investor
	name = "Investor"
	glasses = /obj/item/clothing/glasses/sunglasses
	suit = /obj/item/clothing/suit/toggle/lawyer/black
	uniform = /obj/item/clothing/under/f13/bennys
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(/obj/item/storage/fancy/cigarettes/cigpack_bigboss=1,
		/obj/item/storage/box/matches=1,
		/obj/item/ingot/gold = 1,
		///obj/item/gun/ballistic/shotgun/automatic/combat/shotgunlever = 1
		)
/*--------------------------------------------------------------*/

/*
//The Quartermaster
/datum/job/oasis/f13quartermaster
	title = "Texarkana Quartermaster"
	flag = F13QUARTERMASTER
	department_flag = DEP_OASIS
	total_positions = 0
	spawn_positions = 1
	supervisors = "the free market and New Boston's laws"
	description = "You are the team leader for your various workers in the shop. Guide them as you see fit towards a profitable future."
	enforces = "The New Bostonstore is part of your workplace, but it is not your workplace alone. You should try to work with your team in order to turn a profit."
	selection_color = "#dcba97"
	exp_requirements = 0
/*
	loadout_options = list(
	/datum/outfit/loadout/laser_master,
	/datum/outfit/loadout/ballistic_master
	)
*/
	outfit = /datum/outfit/job/den/f13quartermaster
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13quartermaster
	name = "Texarkana Quartermaster"
	jobtype = /datum/job/oasis/f13quartermaster
	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_town/commerce
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/roving
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	gloves = /obj/item/clothing/gloves/fingerless
	l_pocket = /obj/item/storage/wallet/stash/high
	r_pocket = /obj/item/flashlight/glowstick
	shoes = /obj/item/clothing/shoes/f13/explorer
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/pda/quartermaster,
		/obj/item/stack/f13Cash/caps/twofivezero)

/datum/outfit/loadout/laser_master
	name = "Laser Master"
	backpack_contents = list(
		/obj/item/book/granter/crafting_recipe/blueprint/plasmarifle = 1
	)

/datum/outfit/loadout/ballistic_master
	name = "Ballistic Master"
	backpack_contents = list(
		/obj/item/book/granter/crafting_recipe/blueprint/armalite = 1
	)

/datum/outfit/job/den/f13quartermaster/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policepistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steelbib/heavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/armyhelmetheavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/trail_carbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lever_action)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/a180)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/varmintrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingshotgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/thatgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/smg10mm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/frag_shrapnel)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/concussion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/explosive/shrapnelmine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)

/datum/outfit/job/den/f13quartermaster/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
*/




//pilot job, bare basics rn, but we can add as needed
/datum/job/oasis/f13pilot
	title = "Vertibird Pilot"
	flag = F13PILOT
	department_flag = DEP_OASIS
	total_positions = -1
	spawn_positions = -1
	supervisors = "New Boston's laws"
	description = "You are a pilot, hired to fly the town's vertibird. Your job is to provide transport for people and aid in search and rescue. Don't forget to charge a fare."
	selection_color = "#dcba97"
/*
	loadout_options = list(
	/datum/outfit/loadout/pilotformal,
	/datum/outfit/loadout/pilotshock,
	/datum/outfit/loadout/flightsurgeon,
	/datum/outfit/loadout/pilotparamed)
*/
	outfit = /datum/outfit/job/den/f13pilot

	access = list(ACCESS_BAR, ACCESS_EVA)
	minimal_access = list(ACCESS_BAR, ACCESS_EVA)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)


/datum/outfit/job/den/f13pilot
	name = "Vertibird Pilot"
	jobtype = /datum/job/oasis/f13pilot
	belt = /obj/item/supplykit
	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/settler
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/satchel/explorer
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/pda = 1,
		)

/datum/outfit/job/den/f13pilot/pre_equip(mob/living/carbon/human/H)
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

/datum/outfit/loadout/pilotformal // Formal captain clothes, low surgery, needs something to make it stand out???
	name = "Town Pilot"
	backpack_contents = list(
	/obj/item/clothing/under/rank/captain/pilot = 1,
	/obj/item/clothing/suit/armor/light/pilotformal = 1,
	/obj/item/storage/firstaid/tactical = 1,
	/obj/item/book/granter/trait/lowsurgery = 1
		)

/datum/outfit/loadout/pilotshock // Captain carapace, bonus mid gun
	name = "LZ Defender"
	backpack_contents = list(
	/obj/item/clothing/under/rank/captain/pilot = 1,
	/obj/item/clothing/suit/armor/medium/pilotcarapace = 1,
	/obj/item/storage/firstaid/emergency = 1,
	/obj/item/gun/ballistic/automatic/marksman/policerifle = 1,
	/obj/item/ammo_box/a556 = 2,
	/obj/item/ammo_box/magazine/m556/rifle = 2
		)

/datum/outfit/loadout/flightsurgeon // Surgical clothing, mid surgery
	name = "Flight Surgeon"
	backpack_contents = list(
	/obj/item/clothing/under/rank/medical/doctor/blue = 1,
	/obj/item/clothing/gloves/color/latex/nitrile = 1,
	/obj/item/clothing/suit/toggle/labcoat/depjacket/med = 1,
	/obj/item/storage/firstaid/emergency = 1,
	/obj/item/book/granter/trait/midsurgery = 1
		)

/datum/outfit/loadout/pilotparamed // Paramed clothing, low surgery, tracker/pinpointer for field work
	name = "Paramedic"
	backpack_contents = list(
	/obj/item/clothing/under/rank/medical/paramedic = 1,
	/obj/item/clothing/suit/toggle/labcoat/paramedic = 1,
	/obj/item/clothing/gloves/color/latex = 1,
	/obj/item/storage/firstaid/emergency = 1,
	/obj/item/defibrillator/compact = 1,
	/obj/item/pinpointer/crew = 1,
	/obj/item/sensor_device = 1
		)

// Professor

/datum/job/oasis/f13Professor
	title = "Town Scientist"
	flag = F13PRACTITIONER
	department_flag = FOLLOWERS
	faction = "Followers"
	total_positions = -1
	spawn_positions = -1
	supervisors = "Generally speaking your only actual supervisor is your own judgement, but it might not be amiss to listen to the Doctors. Assuming they're around."
	description = "You are a Town Scientist. As a Scientist it is your job to teach the wastes- be it teaching them how to make medicine, grow crops or treat toxic water. You are a learned individual in your chosen field, you know how to do research and have all the basic tools to teach others how to handle the technology they will come across. You are free to expand upon what projects you wish to accomplish as long as they align with the principles of the doctors."
	enforces = "Assist and provide medical services to those in need. Provide education for all those who are willing to learn."
	selection_color = "#FFDDFF"
	exp_requirements = 0
	exp_type = EXP_TYPE_FOLLOWERS

	outfit = /datum/outfit/job/den/f13Professor
/*
	loadout_options = list(
	/datum/outfit/loadout/environmental_scientist,
	/datum/outfit/loadout/medical_specialist
	)
*/
	access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS, ACCESS_ROBOTICS)
	minimal_access = list(ACCESS_BAR, ACCESS_SCIENCE, ACCESS_COMMAND, ACCESS_MILITARY, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS, ACCESS_ROBOTICS)

/datum/outfit/job/den/f13Professor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rechargerpistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_toolset)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_surgical)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_janitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_service)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/cyberimp_nutriment)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedenergycell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedmfcell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedecp)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_DNAWHIZ, src)

/datum/outfit/job/den/f13Professor
	name = "Town Scientist"
	jobtype = /datum/job/oasis/f13Professor
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel/tox
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	uniform = /obj/item/clothing/under/f13/followers
	suit= /obj/item/clothing/suit/toggle/labcoat/followers
	belt = /obj/item/supplykit
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/storage/survivalkit/medical/follower = 1,
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/pda = 1,
		/obj/item/storage/firstaid/ancient=1,
		/obj/item/storage/wallet/stash/mid = 1,
		)

/datum/outfit/loadout/environmental_scientist
	name =	"Environmental Scientist"
	neck = /obj/item/clothing/neck/apron/labor
	gloves = /obj/item/clothing/gloves/botanic_leather
	backpack_contents = list(
		/obj/item/book/manual/advice_farming = 1,
		/obj/item/circuitboard/machine/hydroponics = 6,
		/obj/item/storage/bag/plants/portaseeder = 1,
	)

/datum/outfit/loadout/medical_specialist
	name =	"Medical Specialist"
	neck = /obj/item/clothing/neck/stethoscope
	gloves = /obj/item/clothing/gloves/color/latex
	backpack_contents = list(
		/obj/item/healthanalyzer/advanced = 1,
		/obj/item/circuitboard/machine/bloodbankgen = 1,
		/obj/item/gun/syringe/dart = 1,
		/obj/item/reagent_containers/syringe/dart = 3,
	)


// Guild Adventurers

//Guild Worker

/datum/job/oasis/f13shopkeeper
	title = "Guild Shopkeeper"
	flag = GUILDSHOPKEEP
	department_flag = GUILD
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	selection_color = "#dcba97"
	exp_requirements = 0

	outfit = /datum/outfit/job/den/f13shopkeeper
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/f13shopkeeper
	name = "Shopkeeper"
	jobtype = /datum/job/oasis/f13shopkeeper
	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_town/guild
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/f13/roving
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	gloves = /obj/item/pda
	l_pocket = /obj/item/storage/wallet/stash/high
	backpack_contents = list(
		/obj/item/storage/box/guild/uniform,
		/obj/item/cool_book/guildguide = 1
		)

/datum/outfit/job/den/f13shopkeeper/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policepistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/policerifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steelbib/heavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/armyhelmetheavy)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/tribalradio)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/durathread_vest)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/trail_carbine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/lever_action)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/a180)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/varmintrifle)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/huntingshotgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/thatgun)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/uzi)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/smg10mm)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/frag_shrapnel)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/concussion)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/explosive/shrapnelmine)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedenergycell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedmfcell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedecp)

/datum/outfit/job/den/f13shopkeeper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return

//Guild Healer
/datum/job/oasis/f13practitioner
	title = "Guild Healer"
	flag = GUILDMEDIC
	department_flag = GUILD
	faction = "Guild"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	selection_color = "#FFDDFF"
	exp_requirements = 0

	outfit = /datum/outfit/job/den/f13practitioner
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis/f13practitioner,
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis/f13practitioner,
		),
	)

/datum/outfit/job/den/f13practitioner/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/jet)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/turbo)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/psycho)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/medx/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/stimpak5/chemistry)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/superstimpak5)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/buffout)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/steady)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/pico_manip)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_matter_bin)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/phasic_scanning)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/super_capacitor)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/ultra_micro_laser)
	ADD_TRAIT(H, TRAIT_MEDICALGRADUATE, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
	ADD_TRAIT(H, TRAIT_CYBERNETICIST, src)

/datum/outfit/job/den/f13practitioner
	name =	"Guild Healer"
	jobtype =	/datum/job/oasis/f13practitioner
	uniform =	/obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_town/guild
	id =	/obj/item/card/id/silver
	chemwhiz =	TRUE
	backpack =	/obj/item/storage/backpack/medic
	belt = /obj/item/supplykit
	satchel =	/obj/item/storage/backpack/satchel/med
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	gloves = /obj/item/pda
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/storage/survivalkit/medical/follower
	backpack_contents = list(
		/obj/item/storage/box/guild/uniform,
		/obj/item/cool_book/guildguide = 1
	)

//Guild Financier

/datum/job/oasis/f13banker
	title = "Guild Financier"
	flag = GUILDBANKER
	department_flag = GUILD
	faction = "Guild"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	selection_color = "#dcba97"
	outfit = /datum/outfit/job/den/f13banker
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)

/datum/outfit/job/den/f13banker
	name = "Banker"
	jobtype = /datum/job/oasis/f13banker
	belt = /obj/item/supplykit
	uniform = /obj/item/clothing/under/lawyer/blacksuit
	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_town/guild
	shoes = /obj/item/clothing/shoes/f13/fancy
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	gloves = /obj/item/pda
	backpack_contents = list(
		/obj/item/storage/box/guild/uniform,
		/obj/item/storage/wallet/stash/banker = 1,
		/obj/item/cool_book/guildguide = 1
		)

//Guild Cataloger

/datum/job/oasis/nashcurator
	title = "Guild Cataloger"
	flag = GUILDLIBRARIAN
	department_flag = GUILD
	faction = "Guild"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	description = "You are a Curator for the library of New Boston. Assist people with writing books, be a journalist, stock the shelves."
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/nashcurator
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)

/datum/outfit/job/den/nashcurator
	name = "New Boston Librarian"
	jobtype = /datum/job/oasis/nashcurator
	belt = /obj/item/supplykit
	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/settler
	ears = /obj/item/radio/headset/headset_town/guild
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/satchel/explorer
	gloves = /obj/item/pda
	r_pocket = /obj/item/storage/wallet/stash/mid
	backpack_contents = list(
		/obj/item/storage/box/guild/uniform,
		/obj/item/cool_book/guildguide = 1
		)

/datum/outfit/job/den/nashcurator/pre_equip(mob/living/carbon/human/H)
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

//Guild Bartender

/datum/job/oasis/f13barkeep
	title = "Guild Kitcheneer"
	flag = GUILDBARTEND
	department_flag = GUILD
	faction = "Guild"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13barkeep
/*
	loadout_options = list(
	/datum/outfit/loadout/diner
	)
*/
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/oasis
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/oasis
		)
	)


/datum/outfit/job/den/f13barkeep
	name = "Barkeep"
	jobtype = /datum/job/oasis/f13barkeep
	uniform = /obj/item/clothing/under/f13/bartenderalt
	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_town/guild
	belt = /obj/item/supplykit
	shoes = /obj/item/clothing/shoes/workboots/mining
	backpack = /obj/item/storage/backpack/satchel/leather
	gloves = /obj/item/pda
	l_pocket = /obj/item/storage/wallet/stash/mid
	backpack_contents = list(
		/obj/item/book/manual/nuka_recipes = 1,
		/obj/item/storage/box/guild/uniform,
		/obj/item/cool_book/guildguide = 1
		)

/datum/outfit/loadout/diner
	name = "Diner"
	neck = /obj/item/clothing/neck/apron/chef

	backpack_contents = list(
	/obj/item/storage/box/ingredients/wildcard = 1,
	/obj/item/storage/box/ingredients/fiesta = 1,
	/obj/item/storage/box/ingredients/italian = 1,
	/obj/item/storage/box/ingredients/vegetarian = 1,
	/obj/item/storage/box/ingredients/american = 1,
	/obj/item/storage/box/ingredients/fruity = 1,
	/obj/item/storage/box/ingredients/sweets = 1,
	/obj/item/storage/box/ingredients/delights = 1,
	/obj/item/storage/box/ingredients/grains = 1,
	/obj/item/storage/box/ingredients/carnivore = 1,
	/obj/item/storage/box/ingredients/exotic = 1,
	/obj/item/storage/box/ingredients/sushi = 1
	)

//Guild Knight

/datum/job/followers/f13followerguard
	title = "Guild Knight"
	flag = GUILDKNIGHT
	department_flag = GUILD
	faction = "Guild"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Adventurers Guild."
	description = "You work for the Adventurers Guild. Check your guidebook for more info."
	enforces = "Check your guidebook"
	selection_color = "#FFDDFF"

	outfit = /datum/outfit/job/followers/f13followerguard
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT, ACCESS_CARGO, ACCESS_GUILD)

/datum/outfit/job/followers/f13followerguard
	name =	"Knight"
	jobtype =	/datum/job/followers/f13followerguard
	belt = /obj/item/supplykit
	id =	/obj/item/card/id/silver
	uniform =	/obj/item/clothing/under/f13/bodyguard
	ears = /obj/item/radio/headset/headset_town/guild
	suit =	/obj/item/clothing/suit/armor/medium/combat/chinese
	head =	/obj/item/clothing/head/beret
	shoes =	/obj/item/clothing/shoes/combat
	backpack =	/obj/item/storage/backpack/explorer
	satchel =	/obj/item/storage/backpack/satchel/explorer
	gloves = /obj/item/pda
	l_pocket = /obj/item/storage/wallet/stash/mid
	r_pocket = /obj/item/megaphone/sec
	backpack_contents = list(
		/obj/item/storage/box/guild/uniform,
		/obj/item/cool_book/guildguide = 1,
	)

//Guild Uniforms

/obj/item/storage/box/guild/uniform
	name = "Formal Guild Uniforms"

/obj/item/storage/box/guild/uniform/PopulateContents()
	new /obj/item/clothing/under/dress/skirt/red(src)
	new /obj/item/clothing/under/f13/medievalgerman3(src)
	new /obj/item/clothing/shoes/cowboy/alt(src)
	new /obj/item/storage/belt/fannypack(src)
	new /obj/item/clothing/gloves/modif_patrol(src)
	new /obj/item/clothing/head/coyote/britishtricornetwo(src)
