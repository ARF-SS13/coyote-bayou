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
	//r_pocket = /obj/item/storage/fancy/flare_pouch
	backpack_contents = list(
		/obj/item/storage/pill_bottle/chem_tin/radx,
		/obj/item/storage/wallet/stash/low = 1,
		/obj/item/melee/onehanded/knife/hunting = 1
		)

/datum/outfit/job/den/pre_equip(mob/living/carbon/human/H)
	..()
	r_pocket = pick(
		/obj/item/storage/fancy/flare_pouch, \
		/obj/item/storage/fancy/flare_pouch/glowstick)




/datum/outfit/job/den/f13farmer
	name = "Farmer"
	jobtype = /datum/job/townfolk/f13farmer

	id = /obj/item/card/id/dogtag/town

	backpack = /obj/item/storage/backpack/satchel/explorer
	satchel = /obj/item/storage/backpack/satchel/explorer
	l_pocket = /obj/item/storage/wallet/stash/mid
	//r_pocket = /obj/item/storage/fancy/flare_pouch
	belt = /obj/item/storage/bag/plants
	backpack_contents = list(
		/obj/item/cultivator=1, \
		/obj/item/hatchet=1,
		/obj/item/shovel/spade=1,
		/obj/item/pda=1,
		/obj/item/supplykit)
	shoes = 		/obj/item/clothing/shoes/workboots


/*--------------------------------------------------------------*/


/*--------------------------------------------------------------*/

/datum/job/townfolk/f13dendoc
	title = "Doctor"
	flag = F13DENDOC
	department_flag = DEP_OASIS
	total_positions = 0
	spawn_positions = 0
	supervisors = "The Mayor"
	description = "Handy with a scalpel and scanner, your expertise in the practice of medicine makes you an indispensible asset to the settlement of New Boston. Just remember that you're no Follower - medicine doesn't come for free, and you aren't here out of the kindness of your heart. Make sure to turn a profit on your services, or the Mayor might reconsider your position!"
	enforces = "Medicine is a public service, and you are under control of local governance - but remember public doesn't equate to free."
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/den/f13dendoc
	access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING, ACCESS_FOLLOWER)
	minimal_access = list(ACCESS_BAR, ACCESS_CLINIC, ACCESS_CLONING, ACCESS_FOLLOWER)
	matchmaking_allowed = list(
		/datum/matchmaking_pref/friend = list(
			/datum/job/townfolk
		),
		/datum/matchmaking_pref/rival = list(
			/datum/job/townfolk
		)
	)

/datum/outfit/job/den/f13dendoc
	name = "Doctor"
	jobtype = /datum/job/townfolk/f13dendoc
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
	r_pocket = /obj/item/storage/fancy/flare_pouch/glowstick
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


/*--------------------------------------------------------------*/






/datum/outfit/loadout/provisioner
	name = "Provisioner"
	backpack_contents = list(/obj/item/reagent_containers/food/drinks/flask = 1,
	/obj/item/storage/medical/ancientfirstaid = 1,
	/obj/item/reagent_containers/food/drinks/flask/survival = 1,
	)

/datum/outfit/loadout/groundskeeper
	name = "Groundskeeper"
	backpack_contents = list(
	/obj/item/storage/bag/trash = 1,
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
	backpack_contents = list(
	/obj/item/clothing/glasses/welding = 1,
	/obj/item/storage/belt/utility/mining/alt = 1,
	/obj/item/melee/smith/hammer/premade = 1,
	/obj/item/stack/sheet/mineral/titanium = 15,
	/obj/item/pickaxe/mini = 1,
	)

/datum/outfit/loadout/outdoorsman
	name = "Outdoorsman"
	backpack_contents = list(
	/obj/item/fishingrod = 1,
	/obj/item/binoculars = 1,
	)

/datum/outfit/loadout/busker
	name = "Busker"
	backpack_contents = list(
	/obj/item/clothing/under/f13/classdress = 1,
	/obj/item/clothing/under/suit/black_really = 1,
	/obj/item/clothing/gloves/evening = 1,
	/obj/item/clothing/gloves/color/white = 1,
	/obj/item/grenade/smokebomb = 2,
	/obj/item/clothing/accessory/pocketprotector/full = 1,
	/obj/item/choice_beacon/music = 1,
	)


// Reclaimers

//Researcher

/datum/outfit/job/den/recresearcher/pre_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/rechargerpistol)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedenergycell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedmfcell)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/enhancedecp)
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_DNAWHIZ, src)

/datum/outfit/job/den/recresearcher
	name = "Reclaimer Researcher"
	jobtype = /datum/job/reclaimers/researcher
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel/tox
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	uniform = /obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_sci
	suit = /obj/item/clothing/suit/toggle/labcoat/followers
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/cool_book/reclaimerguide
		)

//Archeologist

/datum/outfit/job/den/recresearcher/archeologist
	name = "Reclaimer Archeologist"
	jobtype = /datum/job/reclaimers/archeologist
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel
	duffelbag =	/obj/item/storage/backpack/duffelbag
	uniform = /obj/item/clothing/under/f13/doctor
	ears = /obj/item/radio/headset/headset_sci
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/bag/strangerock = 1,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/storage/belt/xenoarch/full,
		/obj/item/cool_book/reclaimerguide
		)

//Slimeologist

/datum/outfit/job/den/recresearcher/slimeologist
	name = "Reclaimer Slimeologist"
	jobtype = /datum/job/reclaimers/slimeologist
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel
	duffelbag =	/obj/item/storage/backpack/duffelbag
	uniform = /obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_sci
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/gun/energy/laser/complianceregulator = 1,
		/obj/item/cool_book/reclaimerguide
		)

//Mechanic

/datum/outfit/job/den/recresearcher/mechanic
	name = "Reclaimer Mechanic"
	jobtype = /datum/job/reclaimers/mechanic
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel
	duffelbag =	/obj/item/storage/backpack/duffelbag
	uniform = /obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_sci
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/storage/belt/utility/full/engi = 1,
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/cool_book/reclaimerguide
		)

//Nanite Specialist

/datum/outfit/job/den/recresearcher/nanspec
	name = "Reclaimer Nanite Specialist"
	jobtype = /datum/job/reclaimers/nanspec
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel
	duffelbag =	/obj/item/storage/backpack/duffelbag
	uniform = /obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_sci
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/nanite_scanner,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/cool_book/reclaimerguide
		)

//Reclaimer Guard


/datum/outfit/job/den/recresearcher/guard
	name = "Reclaimer Guard"
	jobtype = /datum/job/reclaimers/guard
	backpack =	/obj/item/storage/backpack/science
	satchel =	/obj/item/storage/backpack/satchel
	duffelbag =	/obj/item/storage/backpack/duffelbag
	uniform = /obj/item/clothing/under/pants/camo
	ears = /obj/item/radio/headset/headset_sci
	suit = /obj/item/clothing/suit/armor/texaslight
	id = /obj/item/card/id/silver
	glasses = /obj/item/clothing/glasses/science
	chemwhiz = TRUE
	backpack_contents = list(
		/obj/item/pda = 1,
		/obj/item/storage/wallet/stash/mid = 1,
		/obj/item/cool_book/reclaimerguide
		)



//Reclaimer healer
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
	jobtype =	/datum/job/reclaimers/healer
	uniform =	/obj/item/clothing/under/f13/followers
	ears = /obj/item/radio/headset/headset_town/guild
	id =	/obj/item/card/id/silver
	chemwhiz =	TRUE
	backpack =	/obj/item/storage/backpack/medic
	belt = /obj/item/supplykit
	satchel =	/obj/item/storage/backpack/satchel/med
	duffelbag =	/obj/item/storage/backpack/duffelbag/med
	gloves = /obj/item/pda
	//l_pocket = /obj/item/storage/wallet/stash/mid
	l_pocket = /obj/item/storage/survivalkit/medical/follower
	backpack_contents = list(
		/obj/item/cool_book/reclaimerguide,
		/obj/item/storage/wallet/stash/mid
	)



