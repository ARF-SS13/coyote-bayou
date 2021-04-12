/*
Town access doors
Sheriff/Deputy, Gatehouse etc: 62 ACCESS_GATEWAY
General access: 25 ACCESS_BAR
Clinic surgery/storage: 68 ACCESS_CLONING
Shopkeeper: 34 ACCESS_CARGO_BOT
Banker : 52 ACCESS_MINT_VAULT
Barkeep : 28 ACCESS_KITCHEN - you jebronis made default bar for no reason bruh
Prospector : 48 ACCESS_MINING
Detective : 4 ACCESS_FORENSICS_LOCKERS
here's a tip, go search DEFINES/access.dm
*/

/*
Mayor
*/

/datum/job/den/f13mayor
	title = "Mayor"
	flag = F13MAYOR
	department_flag = DEN
	faction = "Town"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the people of the town"
	description = "You are the head honcho of Oasis and the people look to you for leadership. Pass laws to protect your Citizens, distribute the Town's funds and make deals with the powers present within the Region to better the people - or exploit them for your own personal gain."
	selection_color = "#d7b088"

	outfit = /datum/outfit/job/den/f13mayor
	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_CLINIC, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS)

/datum/outfit/job/den/f13mayor/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/datum/outfit/job/den/f13mayor
	name = "Mayor"
	jobtype = /datum/job/den/f13mayor

	ears = 			/obj/item/radio/headset/headset_den
	id =            /obj/item/card/id/silver/mayor
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	belt = /obj/item/gun/ballistic/revolver/colt357
	shoes = 		/obj/item/clothing/shoes/f13/tan
	uniform = /obj/item/clothing/under/f13/gentlesuit
	suit = /obj/item/clothing/suit/armor/f13/town/mayor
	head = /obj/item/clothing/head/f13/town/mayor
	backpack_contents = list(
		/obj/item/clothing/head/f13/town/big = 1, \
		/obj/item/storage/box/citizenship_permits = 1, \
		/obj/item/ammo_box/a357=2, \
		/obj/item/pen/fountain/captain = 1)

/*--------------------------------------------------------------*/

/datum/job/den/f13sheriff
	title = "Sheriff"
	flag = F13SHERIFF
	department_flag = DEN
	head_announce = list("Security")
	faction = "Town"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the mayor"
	description = "As the chief law enforcer of the Town, your job is to keep the peace, settle local disputes, and keep your townsfolk safe and alive. Unfortunately, with the NCR and Legion closing in on the region, the Town is caught between a rock and a hard place, as with the war brings with it unsavory elements like the Khans and Outlaws. Sometimes the people you handle inside the town will be alive in cuffs, or dead on the street. Other times, they'll escape the limits of the town, to which you can put a bounty on their head for their capture, or have your deputies capture them. However, you must remember these three critical things: never leave the town undefended, keep the townsfolk alive and safe, and most importantly - keep your hand on your gun and don't you trust anyone."
	selection_color = "#d7b088"

	outfit = /datum/outfit/job/den/f13sheriff

	access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS)
	minimal_access = list(ACCESS_BAR, ACCESS_CLONING, ACCESS_GATEWAY, ACCESS_CARGO_BOT, ACCESS_MINT_VAULT, ACCESS_CLINIC, ACCESS_KITCHEN, ACCESS_MINING, ACCESS_FORENSICS_LOCKERS)

/datum/outfit/job/den/f13sheriff
	name = "Sheriff"
	jobtype = /datum/job/den/f13sheriff

	id = /obj/item/card/id/dogtag/sheriff
	belt = null
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer

	ears = 			/obj/item/radio/headset/headset_den
	uniform =  		/obj/item/clothing/under/f13/sheriff
	neck =			/obj/item/storage/belt/holster
	shoes = 		/obj/item/clothing/shoes/f13/cowboy
	suit = 			/obj/item/clothing/suit/armor/f13/town/sheriff
	head = 			/obj/item/clothing/head/f13/town/sheriff
	glasses =		/obj/item/clothing/glasses/sunglasses
	l_hand = 		/obj/item/gun/ballistic/shotgun/automatic/hunting/brush
	l_pocket =		/obj/item/storage/bag/money/small/den
	backpack_contents = list(
		/obj/item/storage/box/deputy_badges=1, \
		/obj/item/ammo_box/tube/c4570=3, \
		/obj/item/ammo_box/m44=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/melee/classic_baton=1, \
		/obj/item/kitchen/knife/combat)
	r_pocket = /obj/item/flashlight/flare
	belt = /obj/item/gun/ballistic/revolver/m29/peacekeeper

/datum/outfit/job/den/f13sheriff/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)
	ADD_TRAIT(H, TRAIT_LIFEGIVER, src)
	ADD_TRAIT(H, TRAIT_SELF_AWARE, src)

/*--------------------------------------------------------------*/

/datum/job/den/f13deputy
	title = "Deputy"
	flag = F13DEPUTY
	department_flag = DEN
	faction = "Town"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the sheriff and the mayor"
	description = "Working alongside the Sheriff you've known them for a while, having worked with them under the previous Sheriff - you bagged many a bandit and raider together on the road. These days you patrol the areas outside of town, tracking down bounties on the run and keeping the settlers safe from harm."
	selection_color = "#dcba97"
	exp_requirements = 12
	exp_type = EXP_TYPE_DEN

	outfit = /datum/outfit/job/den/f13deputy
	access = list(ACCESS_BAR, ACCESS_GATEWAY)
	minimal_access = list(ACCESS_BAR, ACCESS_GATEWAY)

/datum/outfit/job/den/f13deputy
	name = "Deputy"
	jobtype = /datum/job/den/f13deputy

	ears = 			/obj/item/radio/headset/headset_den
	id =            /obj/item/card/id/dogtag/deputy
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	r_hand = /obj/item/gun/ballistic/shotgun/automatic/hunting/trail
	suit = 			/obj/item/clothing/suit/armor/f13/town/deputy
	head =	/obj/item/clothing/head/f13/town/deputy
	belt = /obj/item/gun/ballistic/revolver/colt357
	shoes = 		/obj/item/clothing/shoes/f13/explorer
	uniform = /obj/item/clothing/under/f13/cowboyb
	backpack_contents = list(
		/obj/item/ammo_box/a357=2, \
		/obj/item/ammo_box/tube/m44=2, \
		/obj/item/restraints/handcuffs=1, \
		/obj/item/kitchen/knife/combat)

/datum/outfit/job/den/f13deputy/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_HARD_YARDS, src)

/*--------------------------------------------------------------*/

/datum/job/den/f13farmer
	title = "Farmer"
	flag = F13FARMER
	department_flag = DEN
	faction = "Town"
	total_positions = 4
	spawn_positions = 4
	supervisors = "law and order"
	description = "As a Farmer, you believe that the frontier holds abundant opportunities for you to encroach and take advantage of. Enshrouded in safety by the walls of Oasis, you enact out your skills of cultivation and husbandry, making you a vital backbone business of the town in growing medicines, crops and livestock, focusing on thriving and profiting off of this for your own intrinsic goals. As per your terms of agreement you should follow the law and order of the town, maintaining a distinct amount of peace from the wild wasteland that civilisation hopes to outrun..."
	selection_color = "#dcba97"
	exp_requirements = 2
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13farmer

	access = list(ACCESS_BAR,  ACCESS_KITCHEN)
	minimal_access = list(ACCESS_BAR,  ACCESS_KITCHEN)

/datum/outfit/job/den/f13farmer
	name = "Farmer"
	jobtype = /datum/job/den/f13farmer

	id = /obj/item/card/id/dogtag/town
	ears = 			/obj/item/radio/headset/headset_den
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
		/obj/item/ammo_box/magazine/m10mm_adv=2)
	shoes = 		/obj/item/clothing/shoes/workboots

/datum/outfit/job/den/f13settler/pre_equip(mob/living/carbon/human/H)
	..()
	uniform = pick(
		/obj/item/clothing/under/f13/settler, \
		/obj/item/clothing/under/f13/brahminm, \
		/obj/item/clothing/under/f13/machinist, \
		/obj/item/clothing/under/f13/lumberjack, \
		/obj/item/clothing/under/f13/roving)

/*--------------------------------------------------------------*/

/datum/job/den/f13prospector
	title = "Prospector"
	flag = F13PROSPECTOR
	department_flag = DEN
	faction = "Town"
	total_positions = 4
	spawn_positions = 4
	supervisors = "law and order"
	description = "Prospecting is a complicated business, some call it scrounging or looting, but there is more to it then sifting through rubble - few can boast the skills you posess in mining and delving through the ruins of pre-war America. Not many survive this line of business and the pay has always been uncertain, but perhaps today you'll find strike gold."
	selection_color = "#dcba97"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13prospector

	access = list(ACCESS_BAR, ACCESS_MINING)
	minimal_access = list(ACCESS_BAR, ACCESS_MINING)

/datum/outfit/job/den/f13prospector
	name = "Prospector"
	jobtype = /datum/job/den/f13prospector

	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_den
	suit = /obj/item/clothing/suit/armor/f13/raider/iconoclast/
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	r_hand = /obj/item/pickaxe
	belt = /obj/item/storage/bag/ore
	shoes = /obj/item/clothing/shoes/workboots
	backpack_contents = list(
		/obj/item/mining_scanner=1, \
		/obj/item/shovel=1, \
		/obj/item/kitchen/knife/combat, \
		/obj/item/gun/ballistic/automatic/pistol/n99, \
		/obj/item/ammo_box/magazine/m10mm_adv=2)

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
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)

/*--------------------------------------------------------------*/

/datum/job/den/f13dendoc
	title = "Doctor"
	flag = F13DENDOC
	department_flag = DEN
	faction = "Town"
	total_positions = 1
	spawn_positions = 1
	supervisors = "law and order"
	description = "Handy with a scalpel and scanner, your expertise in the practice of medicine makes you an indispensible asset to the Town. Just remember - medicine doesn't come free, and you aren't here out of the kindness of your heart. Be sure to turn a profit, or the Mayor might reconsider your position!"
	selection_color = "#dcba97"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13dendoc
	access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING)
	minimal_access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING)

/datum/outfit/job/den/f13dendoc
	name = "Doctor"
	jobtype = /datum/job/den/f13dendoc
	chemwhiz = TRUE
	uniform = /obj/item/clothing/under/f13/medic
	ears = /obj/item/radio/headset/headset_den
	neck = /obj/item/clothing/neck/stethoscope
	suit = /obj/item/clothing/suit/toggle/labcoat
	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	shoes = /obj/item/clothing/shoes/sneakers/white
	id = /obj/item/card/id/dendoctor
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=2, \
		/obj/item/storage/firstaid/regular,
		/obj/item/clothing/accessory/armband/medblue  \
		)
/datum/outfit/job/den/f13dendoc/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src)
/*--------------------------------------------------------------*/

/datum/job/den/f13preacher
	title = "Preacher"
	flag = F13PREACHER
	department_head = list("Captain")
	department_flag = DEN
	head_announce = list("Security")
	faction = "Town"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Your Master(s)."
	description = "You are a beacon of faith in the wasteland. Guide the Town and any others who wish to be led on spiritual matters, and try to build your flock. Remember, the Oasis Oak and the Church are the centre of your religion - protect them at all costs."
	selection_color = "#dcba97"

	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13preacher

	loadout_options = list(
	/datum/outfit/loadout/standardpreacher, //Robes, Book
	/datum/outfit/loadout/atompreacher, //Atoms Judgement, Followers Robes
	)

	access = list(ACCESS_BAR)
	minimal_access = list(ACCESS_BAR)


/datum/outfit/loadout/atompreacher
	name = "Atom's Devout"
	l_hand = /obj/item/twohanded/sledgehammer/atomsjudgement
	backpack_contents = list(
		/obj/item/clothing/under/f13/atombeliever=1,
		/obj/item/clothing/under/f13/atomfaithful=3,
		/obj/item/clothing/head/helmet/f13/atombeliever=1
		)

/datum/outfit/loadout/standardpreacher
	name = "Protector of the Faith"
	l_hand = /obj/item/nullrod
	backpack_contents = list(
		/obj/item/reagent_containers/hypospray/medipen/stimpak=2
		)

/datum/job/den/f13preacher/after_spawn(mob/living/H, mob/M)
	if(H.mind)
		H.mind.isholy = TRUE

	var/obj/item/storage/book/bible/booze/B = new

	if(GLOB.religion)
		B.deity_name = GLOB.deity
		B.name = GLOB.bible_name
		B.icon_state = GLOB.bible_icon_state
		B.item_state = GLOB.bible_item_state
		to_chat(H, "There is already an established religion onboard the station. You are an acolyte of [GLOB.deity]. Defer to the Chaplain.")
		H.equip_to_slot_or_del(B, SLOT_IN_BACKPACK)
		var/nrt = GLOB.holy_weapon_type || /obj/item/nullrod
		var/obj/item/nullrod/N = new nrt(H)
		H.put_in_hands(N)
		return

	var/new_religion = DEFAULT_RELIGION
	if(M.client && M.client.prefs.custom_names["religion"])
		new_religion = M.client.prefs.custom_names["religion"]

	var/new_deity = DEFAULT_DEITY
	if(M.client && M.client.prefs.custom_names["deity"])
		new_deity = M.client.prefs.custom_names["deity"]

	B.deity_name = new_deity


	switch(lowertext(new_religion))
		if("christianity") // DEFAULT_RELIGION
			B.name = pick("The Holy Bible","The Dead Sea Scrolls")
		if("buddhism")
			B.name = "The Sutras"
		if("clownism","honkmother","honk","honkism","comedy")
			B.name = pick("The Holy Joke Book", "Just a Prank", "Hymns to the Honkmother")
		if("chaos")
			B.name = "The Book of Lorgar"
		if("cthulhu")
			B.name = "The Necronomicon"
		if("hinduism")
			B.name = "The Vedas"
		if("homosexuality")
			B.name = pick("Guys Gone Wild","Coming Out of The Closet")
		if("imperium")
			B.name = "Uplifting Primer"
		if("islam")
			B.name = "Quran"
		if("judaism")
			B.name = "The Torah"
		if("lampism")
			B.name = "Fluorescent Incandescence"
		if("lol", "wtf", "gay", "penis", "ass", "poo", "badmin", "shitmin", "deadmin", "cock", "cocks", "meme", "memes")
			B.name = pick("Woodys Got Wood: The Aftermath", "War of the Cocks", "Sweet Bro and Hella Jef: Expanded Edition","F.A.T.A.L. Rulebook")
			H.adjustOrganLoss(ORGAN_SLOT_BRAIN, 100) // starts off dumb as fuck
		if("monkeyism","apism","gorillism","primatism")
			B.name = pick("Going Bananas", "Bananas Out For Harambe")
		if("mormonism")
			B.name = "The Book of Mormon"
		if("pastafarianism")
			B.name = "The Gospel of the Flying Spaghetti Monster"
		if("rastafarianism","rasta")
			B.name = "The Holy Piby"
		if("satanism")
			B.name = "The Unholy Bible"
		if("science")
			B.name = pick("Principle of Relativity", "Quantum Enigma: Physics Encounters Consciousness", "Programming the Universe", "Quantum Physics and Theology", "String Theory for Dummies", "How To: Build Your Own Warp Drive", "The Mysteries of Bluespace", "Playing God: Collector's Edition")
		if("scientology")
			B.name = pick("The Biography of L. Ron Hubbard","Dianetics")
		if("servicianism", "partying")
			B.name = "The Tenets of Servicia"
			B.deity_name = pick("Servicia", "Space Bacchus", "Space Dionysus")
			B.desc = "Happy, Full, Clean. Live it and give it."
		if("subgenius")
			B.name = "Book of the SubGenius"
		if("toolboxia","greytide")
			B.name = pick("Toolbox Manifesto","iGlove Assistants")
		if("weeaboo","kawaii")
			B.name = pick("Fanfiction Compendium","Japanese for Dummies","The Manganomicon","Establishing Your O.T.P")
		else
			B.name = "The Holy Book of [new_religion]"

	GLOB.religion = new_religion
	GLOB.bible_name = B.name
	GLOB.deity = B.deity_name

	H.equip_to_slot_or_del(B, SLOT_IN_BACKPACK)

	SSblackbox.record_feedback("text", "religion_name", 1, "[new_religion]", 1)
	SSblackbox.record_feedback("text", "religion_deity", 1, "[new_deity]", 1)


/datum/outfit/job/den/f13preacher
	name = "Preacher"
	jobtype = /datum/job/den/f13preacher
	ears = /obj/item/radio/headset/headset_den
	belt = null

	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/rank/chaplain
	backpack_contents = list(/obj/item/camera/spooky = 1)
	backpack = /obj/item/storage/backpack/cultpack
	satchel = /obj/item/storage/backpack/cultpack
	gloves =		/obj/item/clothing/gloves/fingerless
	shoes = 		/obj/item/clothing/shoes/jackboots
	backpack = 		/obj/item/storage/backpack/cultpack
	satchel = 		/obj/item/storage/backpack/cultpack
	r_hand = 		/obj/item/gun/ballistic/revolver/m29
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
		/obj/item/ammo_box/m44=2, \
		/obj/item/reagent_containers/food/drinks/flask=1, \
		/obj/item/storage/fancy/candle_box, \
		/obj/item/storage/bag/money/small/settler)

/*--------------------------------------------------------------*/

/datum/job/den/f13barkeep
	title = "Barkeep"
	flag = F13BARKEEP
	department_flag = DEN
	faction = "Town"
	total_positions = 2
	spawn_positions = 2
	supervisors = "law and order"
	description = "As a Barkeep, you believe that the frontier holds abundant opportunity for bartending and service. Hidden safely away behind the walls of Oasis, you enact out your skills of mixing the finest drinks and serving the best grub in the wasteland. As per your terms of agreement you should follow the law and order of the town. However the Blue Oyster is your private business, working in harmony with the farm next door to supply you with crop and goods to keep you in profit."
	selection_color = "#dcba97"
	exp_requirements = 12
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13barkeep

	loadout_options = list(
	/datum/outfit/loadout/rugged,
	/datum/outfit/loadout/frontier,
	/datum/outfit/loadout/richmantender,
	/datum/outfit/loadout/diner)

	access = list(ACCESS_BAR, ACCESS_KITCHEN)
	minimal_access = list(ACCESS_BAR, ACCESS_KITCHEN)

/datum/outfit/job/den/f13barkeep
	name = "Barkeep"
	jobtype = /datum/job/den/f13barkeep

	uniform = /obj/item/clothing/under/f13/bartenderalt
	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_den
	belt = /obj/item/gun/ballistic/revolver/caravan_shotgun
	shoes = /obj/item/clothing/shoes/workboots/mining
	backpack = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/bag/money/small/settler = 1,
		/obj/item/storage/fancy/ammobox/beanbag = 2
		)

/datum/outfit/loadout/rugged
	name = "Rugged"
	head = /obj/item/clothing/head/helmet/f13/brahmincowboyhat
	uniform = /obj/item/clothing/under/f13/cowboyb
	suit = /obj/item/clothing/suit/f13/cowboybvest
	gloves = /obj/item/clothing/gloves/color/brown
	shoes = /obj/item/clothing/shoes/f13/brownie

/datum/outfit/loadout/frontier
	name = "Frontier"
	head = /obj/item/clothing/head/bowler
	mask = /obj/item/clothing/mask/fakemoustache
	uniform = /obj/item/clothing/under/f13/westender
	suit = /obj/item/clothing/suit/f13/westender
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/f13/fancy

/datum/outfit/loadout/richmantender
	name = "Fancy"
	head = /obj/item/clothing/head/fedora
	glasses = /obj/item/clothing/glasses/sunglasses
	uniform = /obj/item/clothing/under/rank/bartender
	suit = /obj/item/clothing/suit/toggle/lawyer/black
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/f13/fancy
	neck = /obj/item/clothing/neck/tie/black

/datum/outfit/loadout/diner
	name = "Diner"
	head = /obj/item/clothing/head/soft/mime
	glasses = /obj/item/clothing/glasses/orange
	uniform = /obj/item/clothing/under/f13/brahminf
	suit = /obj/item/clothing/suit/apron/chef
	gloves = /obj/item/clothing/gloves/color/white
	shoes = /obj/item/clothing/shoes/f13/military/ncr

/*--------------------------------------------------------------*/
/datum/job/den/f13settler
	title = "Citizen"
	flag = F13SETTLER
	department_flag = DEN
	faction = "Town"
	total_positions = 8
	spawn_positions = 8
	supervisors = "law and order"
	description = "You are a Settler living within the Town of Oasis - as the name suggests, it is a slightly more civilised place amidst the chaos of the Wasteland. Treat it as such, be sure to follow the laws of the land and do not associate with those who have a tendency not to, or you are likely to face exile. Remember that Oasis is your home, and that you should not be leaving to explore the Wastes."
	selection_color = "#dcba97"
	exp_requirements = 2
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/den/f13settler

	loadout_options = list(
	/datum/outfit/loadout/provisioner,
	/datum/outfit/loadout/bum,
	/datum/outfit/loadout/properlady,
	/datum/outfit/loadout/propergent,
	/datum/outfit/loadout/hombre,
	)
	access = list(ACCESS_BAR)
	minimal_access = list(ACCESS_BAR)

/datum/outfit/loadout/provisioner
	name = "Provisioner"
	neck = /obj/item/clothing/neck/scarf/cptpatriot
	suit = /obj/item/clothing/suit/jacket/miljacket
	uniform = /obj/item/clothing/under/f13/merca
	gloves = /obj/item/clothing/gloves/f13/leather
	shoes = /obj/item/clothing/shoes/f13/explorer
	backpack_contents = list(/obj/item/reagent_containers/food/drinks/flask = 1)

/datum/outfit/loadout/bum
	name = "Bum"
	mask = /obj/item/clothing/mask/facewrap
	suit = /obj/item/clothing/suit/poncho
	uniform = /obj/item/clothing/under/f13/rag
	gloves = /obj/item/clothing/gloves/f13/handwraps
	shoes = /obj/item/clothing/shoes/f13/rag
	backpack_contents = list(/obj/item/storage/bag/trash = 1, /obj/item/reagent_containers/food/drinks/bottle/whiskey = 1)

/datum/outfit/loadout/properlady
	name = "Proper Lady"
	head = /obj/item/clothing/head/beret/black
	suit = /obj/item/clothing/under/sailordress
	gloves = /obj/item/clothing/gloves/f13/lace
	shoes = /obj/item/clothing/shoes/f13/fancy
	backpack_contents = list(/obj/item/reagent_containers/food/drinks/bottle/wine = 1)

/datum/outfit/loadout/propergent
	name = "Respectable Gent"
	head = /obj/item/clothing/head/f13/beaver
	suit = /obj/item/clothing/suit/f13/cowboybvest
	uniform = /obj/item/clothing/under/f13/bartenderalt
	shoes = /obj/item/clothing/shoes/f13/fancy
	backpack_contents = list(/obj/item/storage/box/matches = 1, /obj/item/storage/fancy/cigarettes/cigars = 1)

/datum/outfit/loadout/hombre
	name = "Hombre"
	head = /obj/item/clothing/head/f13/cowboy
	suit = /obj/item/clothing/suit/f13/duster
	uniform = /obj/item/clothing/under/f13/cowboyb
	gloves = /obj/item/clothing/gloves/f13/leather
	shoes = /obj/item/clothing/shoes/f13/cowboy
	backpack_contents = list()

/datum/outfit/job/den/f13settler
	name = "Citizen"
	jobtype = /datum/job/den/f13settler
	ears = /obj/item/radio/headset/headset_den
	belt = null
	id = /obj/item/card/id/dogtag/town
	ears = /obj/item/radio/headset/headset_den
	uniform = /obj/item/clothing/under/f13/settler
	shoes = /obj/item/clothing/shoes/jackboots
	backpack = /obj/item/storage/backpack/satchel/explorer
	r_pocket = /obj/item/flashlight/flare
	backpack_contents = list(
			/obj/item/storage/bag/money/small/settler = 1, \
			/obj/item/kitchen/knife/combat = 1, \
			/obj/item/gun/ballistic/automatic/pistol/n99 = 1, \
			/obj/item/ammo_box/magazine/m10mm_adv=2)
/*----------------------------------------------------------------
--							Detective							--
----------------------------------------------------------------*/
/datum/job/wasteland/f13detective
	title = "Detective"
	flag = F13DETECTIVE
	faction = "Town"
	total_positions = 1
	spawn_positions = 1
	description = "As a Detective you are a private eye and investigator who assists private persons to gather evidence, conduct surveillance, find missing people, and verify information. As a private investigator you are not responsible for peacekeeping the wasteland, but by working with forces greater than yourself to resolve conflicts and bring order where it is not present."
	supervisors = "law and order"
	selection_color = "#dcba97"
	outfit = /datum/outfit/job/wasteland/f13detective

	access = list(ACCESS_BAR, ACCESS_FORENSICS_LOCKERS)
	minimal_access = list(ACCESS_BAR, ACCESS_FORENSICS_LOCKERS)


/datum/outfit/job/wasteland/f13detective
	name = "Detective"
	jobtype = /datum/job/wasteland/f13detective
	suit = /obj/item/clothing/suit/det_suit/grey
	ears = /obj/item/radio/headset/headset_den
	uniform = /obj/item/clothing/under/f13/detectivealt
	head = /obj/item/clothing/head/f13/det_hat_alt
	shoes =  /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/silver
	l_pocket = /obj/item/storage/bag/money/small/settler
	r_pocket = /obj/item/flashlight/flare
	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	suit_store = /obj/item/gun/ballistic/revolver/police
	backpack_contents = list(
		/obj/item/pda/detective=1,
		/obj/item/camera/detective=1,
		/obj/item/toy/crayon/white=1,
		/obj/item/detective_scanner=1,
		/obj/item/storage/box/gloves=1,
		/obj/item/storage/box/evidence=1,
		/obj/item/ammo_box/a357=2)

/*--------------------------------------------------------------*/

/*
/datum/job/den/f13banker
	title = "Banker"
	flag = F13BANKER
	department_flag = DEN
	faction = "Town"
	total_positions = 2
	spawn_positions = 2
	supervisors = "law and order"
	description = "No matter where society lurks, profit and fortune are there to be made! It is up to you to distribute caps and earn interest while safekeeping items of value for the wastelands denizens! Ensure you make a profit and make your money back no matter the cost. You are to work alongside the Town, and should not be attempting to harm the residents of Oasis."
	selection_color = "#dcba97"
	enforces = "You are in a Job meant for encouraging roleplay with others, do not abandon your post or hoard money unless absolutely necessary. Do not use the caps provided for yourself."

	outfit = /datum/outfit/job/den/f13banker

	loadout_options = list(
	/datum/outfit/loadout/classy,
	/datum/outfit/loadout/loanshark,
	/datum/outfit/loadout/investor,
	)

	access = list(ACCESS_BAR, ACCESS_MINT_VAULT)
	minimal_access = list(ACCESS_BAR, ACCESS_MINT_VAULT)

/datum/outfit/job/den/f13banker
	name = "Banker"
	jobtype = /datum/job/den/f13banker

	uniform = /obj/item/clothing/under/lawyer/blacksuit
	id = /obj/item/card/id/silver
	ears = /obj/item/radio/headset/headset_den
	shoes = /obj/item/clothing/shoes/f13/fancy
	backpack = /obj/item/storage/backpack/satchel/leather
	satchel = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/bag/money/small/banker)

/datum/outfit/loadout/classy
	name = "Classy"
	head = /obj/item/clothing/head/collectable/tophat
	glasses = /obj/item/clothing/glasses/monocle
	uniform = /obj/item/clothing/under/suit_jacket/charcoal
	suit = /obj/item/clothing/suit/f13/banker
	gloves = /obj/item/clothing/gloves/color/white/redcoat
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(
	/obj/item/cane=1,
	/obj/item/gun/ballistic/revolver/zipgun=1,
	/obj/item/storage/fancy/cigarettes/cigpack_bigboss=1,
	/obj/item/reagent_containers/food/drinks/bottle/whiskey=1,
	/obj/item/reagent_containers/food/drinks/drinkingglass/shotglass=1
	)

/datum/outfit/loadout/loanshark
	name = "Loanshark"
	glasses = /obj/item/clothing/glasses/orange
	mask = /obj/item/clothing/mask/cigarette/cigar
	suit = /obj/item/clothing/suit/f13/vest
	uniform = /obj/item/clothing/under/f13/sleazeball
	shoes = /obj/item/clothing/shoes/sandal
	backpack_contents = list(
	/obj/item/reagent_containers/food/drinks/bottle/whiskey=1,
	/obj/item/storage/box/matches=1,
	/obj/item/gun/ballistic/automatic/mini_uzi=1
	)

/datum/outfit/loadout/investor
	name = "Investor"
	glasses = /obj/item/clothing/glasses/sunglasses
	suit = /obj/item/clothing/suit/toggle/lawyer/black
	uniform = /obj/item/clothing/under/f13/bennys
	gloves = /obj/item/clothing/gloves/fingerless
	shoes = /obj/item/clothing/shoes/laceup
	backpack_contents = list(
		/obj/item/gun/ballistic/revolver/colt357=1,
		/obj/item/storage/fancy/cigarettes/cigpack_bigboss=1,
		/obj/item/storage/box/matches=1
		)
*/

/*--------------------------------------------------------------*/

/datum/job/den/f13shopkeeper
	title = "Shopkeeper"
	flag = F13SHOPKEEPER
	department_flag = DEN
	faction = "Town"
	total_positions = 2
	spawn_positions = 2
	supervisors = "law and order"
	description = "The capitalist economy of pre-war america survived alongside its people. Now it's your job to continue its survival, so make some caps!"
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13shopkeeper
	access = list(ACCESS_BAR, ACCESS_CARGO_BOT)
	minimal_access = list(ACCESS_BAR, ACCESS_CARGO_BOT)

/datum/outfit/job/den/f13shopkeeper
	name = "Shopkeeper"
	jobtype = /datum/job/den/f13shopkeeper

	id = /obj/item/card/id/dogtag/town
	uniform = /obj/item/clothing/under/f13/roving
	ears = /obj/item/radio/headset/headset_den
	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	gloves = /obj/item/clothing/gloves/fingerless
	l_pocket = /obj/item/storage/bag/money/small/den
	r_pocket = /obj/item/flashlight/flare
	shoes = /obj/item/clothing/shoes/f13/explorer
	backpack_contents = list()

/datum/outfit/job/den/f13shopkeeper/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_MASTER_GUNSMITH, src)

/datum/outfit/job/den/f13shopkeeper/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/automatic_sear)
