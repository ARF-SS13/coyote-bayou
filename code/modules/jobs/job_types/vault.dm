/*
Vault access doors
Overseer/Chief of security: 19 ACCESS_HEADS
Security: 1 ACCESS_SECURITY
General access: 31 ACCESS_CARGO
Engineering: 10, 11 ACCESS_ENGINE_EQUIP, ACCESS_ENGINE
Science: 47 ACCESS_RESEARCH
here's a tip, go search DEFINES/access.dm
*/
// I swear to god stop copy-pasting you damn snowflakes
/datum/job/vault
	department_flag = VAULT
	exp_type = EXP_TYPE_VAULT

/datum/outfit/job/vault
	gloves = /obj/item/pda

/datum/outfit/job/vault/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_TECHNOPHREAK, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
/*
Overseer
*/

/datum/job/vault
	objectivesList = list("Leadership recommends the following goal for this week: Establish trade with the wasteland","Leadership recommends the following goal for this week: Acquire blueprints and interesting artifacts for research", "Leadership recommends the following goal for this week: Expand operations outside the vault")

/datum/job/vault/f13overseer
	title = "Overseer"
	flag = F13OVERSEER
	department_flag = VAULT
	head_announce = list("Security")
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations."
	description = "You are the leader of the Vault, and your word is law. Working with the Security team and your fellow Vault Dwellers, your goal is to ensure the continued prosperity and survival of the vault, through any and all means necessary."
	supervisors = "Vault-tec"
	selection_color = "#ccffcc"
	req_admin_notify = 1
	exp_requirements = 1500

	outfit = /datum/outfit/job/vault/f13overseer

	access = list()			//See get_access()
	minimal_access = list()	//See get_access()

/datum/job/vault/f13overseer/get_access()
	return get_all_accesses()

/datum/outfit/job/vault/f13overseer
	name = "Overseer"
	jobtype = /datum/job/vault/f13overseer
	chemwhiz = TRUE

	implants = list(/obj/item/implant/mindshield)

	id = 			/obj/item/card/id/gold
	uniform = 		/obj/item/clothing/under/f13/vault13
	shoes = 		/obj/item/clothing/shoes/jackboots
	glasses = 		/obj/item/clothing/glasses/sunglasses
	ears = 			/obj/item/radio/headset/headset_overseer
	neck = 			/obj/item/clothing/neck/cloak/overseer
	backpack = 		/obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/ids = 1,
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/gun/ballistic/automatic/pistol/n99/executive = 1,
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 3,
		/obj/item/crowbar = 1)

/*
Head of Security
*/

/datum/job/vault/f13hos
	title = "Chief of Security"
	flag = F13HOS
	department_head = list("Overseer")
	department_flag = VAULT
	head_announce = list("Security")
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Overseer. You are tasked with organising the safety, security and readiness of the Vault, as well as managing the Security team. It is also your duty to secure the Vault against outside invasion. At your discretion, you are encouraged to train capable dwellers in the usage of firearms and issue weapon permits accordingly."
	supervisors = "the Overseer"
	selection_color = "#ccffcc"
	req_admin_notify = 1
	exp_requirements = 1500

	outfit = /datum/outfit/job/vault/f13hos

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_WEAPONS,ACCESS_FORENSICS_LOCKERS,
						ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MINING, ACCESS_MEDICAL,
						ACCESS_CARGO, ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS,
						ACCESS_MORGUE, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CARGO, ACCESS_HEADS,
						ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_MINERAL_STOREROOM)

/datum/outfit/job/vault/f13hos
	name = "Chief of Security"
	jobtype = /datum/job/vault/f13hos

	id = /obj/item/card/id/chief
	//pda
	uniform = /obj/item/clothing/under/f13/vault13
	ears = /obj/item/radio/headset/headset_vault_hos/alt
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/alt
	head = /obj/item/clothing/head/collectable/police/cos
	belt = /obj/item/storage/belt/security
	glasses = /obj/item/clothing/glasses/sunglasses
	r_hand = /obj/item/gun/ballistic/revolver/colt6520
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/security
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/restraints/handcuffs = 2,
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 2,
		/obj/item/crowbar = 1,
		)

	implants = list(/obj/item/implant/mindshield)

/*
Medical Doctor
*/
/datum/job/vault/f13doctor
	title = "Vault-tec Doctor"
	flag = F13DOCTOR
	department_head = list("Overseer")
	department_flag = VAULT
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Overseer. You are tasked with providing medical care to Vault Dwellers and ensuring the medical well-being of everyone in the Vault."
	supervisors = "the Overseer"
	selection_color = "#ddffdd"

	outfit = /datum/outfit/job/vault/f13doctor

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_MINERAL_STOREROOM, ACCESS_CARGO)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_CHEMISTRY, ACCESS_MINERAL_STOREROOM, ACCESS_CARGO)

/datum/outfit/job/vault/f13doctor
	name = "Medical Doctor"
	jobtype = /datum/job/vault/f13doctor
	chemwhiz = TRUE
	//pda
	uniform = /obj/item/clothing/under/f13/vault13
	ears = /obj/item/radio/headset/headset_vault
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/toggle/labcoat
	l_hand = /obj/item/storage/firstaid/regular
	suit_store = /obj/item/flashlight/pen
	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	backpack_contents = list(
		/obj/item/crowbar = 1,
		)

/datum/outfit/job/vault/f13doctor/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_MEDICALEXPERT, src)
	ADD_TRAIT(H, TRAIT_GENERIC, src)
	ADD_TRAIT(H, TRAIT_SURGERY_HIGH, src)

/*
Scientist
*/
/datum/job/vault/f13vaultscientist
	title = "Vault-tec Scientist"
	flag = F13VAULTSCIENTIST
	department_head = list("Overseer")
	department_flag = VAULT
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Overseer. You are tasked with researching new technologies, conducting mining expeditions (with the approval of Security or the Overseer), and upgrading the machinery of the Vault."
	supervisors = "the Overseer"
	selection_color = "#ddffdd"

	outfit = /datum/outfit/job/vault/f13vaultscientist

	access = list(ACCESS_ROBOTICS, ACCESS_RESEARCH, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_CARGO)
	minimal_access = list(ACCESS_ROBOTICS, ACCESS_RESEARCH, ACCESS_MINERAL_STOREROOM, ACCESS_CARGO)

/datum/outfit/job/vault/f13vaultscientist
	name = "Scientist"
	jobtype = /datum/job/vault/f13vaultscientist
	chemwhiz = TRUE

	//pda
	uniform = /obj/item/clothing/under/f13/vault13
	ears = /obj/item/radio/headset/headset_vault
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/toggle/labcoat
	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/tox
	backpack_contents = list(
		/obj/item/crowbar = 1,
		)

/datum/outfit/job/vault/f13vaultscientist/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	if(visualsOnly)
		return
	ADD_TRAIT(H, TRAIT_SURGERY_MID, src) //they need this for dissections

/*
Security Officer
*/
/datum/job/vault/f13officer
	title = "Vault-tec Security"
	flag = F13OFFICER
	department_head = list("Chief of Security")
	department_flag = VAULT
	faction = "Vault"
	total_positions = 0 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	spawn_positions = 0 //Handled in /datum/controller/occupations/proc/setup_officer_positions()
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Chief of Security, and in their absence, the Overseer. You are the first line of defense against civil unrest and outside intrusion. It is your duty to enforce the laws created by the Overseer and proactively seek out potential threats to the safety of Vault residents."
	supervisors = "the head of security"
	selection_color = "#ddffdd"
	exp_requirements = 600

	outfit = /datum/outfit/job/vault/f13security

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_WEAPONS,ACCESS_FORENSICS_LOCKERS,
						ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MINING, ACCESS_MEDICAL,
						ACCESS_CARGO, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS,
						ACCESS_MORGUE, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CARGO,
						ACCESS_MINERAL_STOREROOM)
/datum/outfit/job/vault/f13security
	name = "Vault-tec Security"
	jobtype = /datum/job/vault/f13officer

	id = /obj/item/card/id/sec
	//pda
	ears = /obj/item/radio/headset/headset_vaultsec
	uniform = /obj/item/clothing/under/f13/vault13
	head = /obj/item/clothing/head/helmet/riot/vaultsec
	suit = /obj/item/clothing/suit/armor/vest
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/jackboots
	belt = /obj/item/storage/belt/security
	r_hand = /obj/item/gun/ballistic/automatic/pistol/n99
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	box = /obj/item/storage/box/security
	backpack_contents = list(
		/obj/item/melee/classic_baton/telescopic = 1,
		/obj/item/restraints/handcuffs = 1,
		/obj/item/ammo_box/magazine/m10mm_adv/simple = 2,
		/obj/item/crowbar = 1,
		)

	implants = list(/obj/item/implant/mindshield)


/obj/item/radio/headset/headset_sec/alt/department/Initialize()
	. = ..()
	wires = new/datum/wires/radio(src)
	secure_radio_connections = new
	recalculateChannels()

/obj/item/radio/headset/headset_sec/alt/department/engi
	keyslot = new /obj/item/encryptionkey/headset_vault_security
	keyslot2 = new /obj/item/encryptionkey/headset_eng

/obj/item/radio/headset/headset_sec/alt/department/supply
	keyslot = new /obj/item/encryptionkey/headset_vault_security
	keyslot2 = new /obj/item/encryptionkey/headset_cargo

/obj/item/radio/headset/headset_sec/alt/department/med
	keyslot = new /obj/item/encryptionkey/headset_vault_security
	keyslot2 = new /obj/item/encryptionkey/headset_med

/obj/item/radio/headset/headset_sec/alt/department/sci
	keyslot = new /obj/item/encryptionkey/headset_vault_security
	keyslot2 = new /obj/item/encryptionkey/headset_sci

/*
Vault Engineer
*/

/datum/job/vault/f13vaultengineer
	title = "Vault-tec Engineer"
	flag = F13VAULTENGINEER
	department_head = list("Overseer")
	department_flag = VAULT
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Overseer. You are tasked with overseeing the Reactor, maintaining Vault defenses and machinery, and engaging in construction projects to improve the Vault as a whole."
	supervisors = "the Overseer"
	selection_color = "#ddffdd"

	outfit = /datum/outfit/job/vault/f13vaultengineer

	access = list(ACCESS_CARGO, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_CARGO, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MINERAL_STOREROOM)

/datum/outfit/job/vault/f13vaultengineer
	name = "Vault-tec Engineer"
	jobtype = /datum/job/vault/f13vaultengineer

	//pda
	ears = /obj/item/radio/headset/headset_vault
	uniform = /obj/item/clothing/under/f13/vault13
	belt = /obj/item/storage/belt/utility/full/engi
	shoes = /obj/item/clothing/shoes/sneakers/red
	head = /obj/item/clothing/head/hardhat
	r_pocket = /obj/item/t_scanner
	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/engineer
	backpack_contents = list(
		/obj/item/crowbar,
		)

/datum/job/vault/f13vaultDweller
	title = "Vault Dweller"
	flag = ASSISTANT
	department_flag = VAULT
	faction = "Vault"
	total_positions = 0
	spawn_positions = 0
	forbids = "The Vault forbids: Disobeying the Overseer. Deserting the Vault unless it is rendered unhospitable. Killing fellow Vault Dwellers. Betraying the Vault and its people."
	enforces = "The Vault expects: Contributing to Vault society. Adherence to Vault-tec Corporate Regulations. Participation in special projects, as ordered by the Overseer."
	description = "You answer directly to the Overseer, being assigned to fulfill whatever menial tasks are required. You lack an assignment, but may be given one the Overseer if required or requested. You should otherwise busy yourself with assisting personnel with tasks around the Vault."
	supervisors = "absolutely everyone"
	selection_color = "#ddffdd"
	access = list()			//See /datum/job/vault/assistant/get_access()
	minimal_access = list()	//See /datum/job/vault/assistant/get_access()

	outfit = /datum/outfit/job/vault/f13vaultDweller

/datum/job/vault/f13vaultDweller/get_access()
	access = list(ACCESS_CARGO)
	minimal_access = list(ACCESS_CARGO)

/datum/outfit/job/vault/f13vaultDweller
	name = "Vault Dweller"
	jobtype = /datum/job/vault/f13vaultDweller
	backpack = /obj/item/storage/backpack/satchel/leather
	uniform = /obj/item/clothing/under/f13/vault13
	ears = /obj/item/radio/headset/headset_vault
	shoes = /obj/item/clothing/shoes/jackboots
	backpack_contents = list(
		/obj/item/crowbar,
		)
