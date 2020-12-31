//FOR BOTH SUITS AND ARMORS BELONGING TO FACTIONS
//PLEASE PUT CUSTOM ARMORS IN f13armor.dm. All power armors are found in f13armor.dm.

//Enclave/Remnants

/obj/item/clothing/suit/armor/f13/combat/enclave
	name = "enclave combat armor"
	desc = "An old set of pre-war combat armor, painted black."
	icon_state = "enclave_armor"
	item_state = "enclave_armor"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 45, "energy" = 75, "bomb" = 70, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 50)

/obj/item/clothing/suit/armor/f13/combat/remnant
	name = "combat armor"
	desc = "A dark armor, used commonly in espionage or shadow ops. Worn by CAG or OS members."
	icon_state = "remnant"
	item_state = "remnant"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 45, "energy" = 75, "bomb" = 70, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 50)

//Raider
/obj/item/clothing/suit/armor/f13/raider
	name = "base raider armor"
	desc = "for testing"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 35, "bullet" = 30, "laser" = 35, "energy" = 35, "bomb" = 30, "bio" = 0, "rad" = 0, "fire" = 25, "acid" = 25)
	strip_delay = 40

/obj/item/clothing/suit/armor/f13/raider/supafly
	name = "supa-fly raider armor"
	desc = "Fabulous mutant powers were revealed to me the day I held aloft my bumper sword and said...<br>BY THE POWER OF NUKA-COLA, I AM RAIDER MAN!"
	icon_state = "supafly"
	item_state = "supafly"

/obj/item/clothing/suit/armor/f13/raider/supafly/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/sadist
	name = "sadist raider armor"
	desc = "A bunch of metal chaps adorned with severed hands at the waist with a leather plate worn on the left shoulder. Very intimidating."
	icon_state = "sadist"
	item_state = "sadist"

/obj/item/clothing/suit/armor/f13/raider/sadist/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/blastmaster
	name = "blastmaster raider armor"
	desc = "A suit composed largely of blast plating, though there's so many holes it's hard to say if it will protect against much."
	icon_state = "blastmaster"
	item_state = "blastmaster"
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	flash_protect = 2

/obj/item/clothing/suit/armor/f13/raider/blastmaster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/yankee
	name = "yankee raider armor"
	desc = "A set of armor made from bulky plastic and rubber. A faded sports team logo is printed in various places. Go Desert Rats!"
	icon_state = "yankee"
	item_state = "yankee"

/obj/item/clothing/suit/armor/f13/raider/yankee/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/badlands
	name = "badlands raider armor"
	desc = "A leather top with a bandolier over it and a straps that cover the arms."
	icon_state = "badlands"
	item_state = "badlands"

/obj/item/clothing/suit/armor/f13/raider/badlands/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/painspike
	name = "painspike raider armor"
	desc = "A particularly unhuggable armor, even by raider standards. Extremely spiky."
	icon_state = "painspike"
	item_state = "painspike"

/obj/item/clothing/suit/armor/f13/raider/painspike/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/iconoclast/
	name = "iconoclast raider armor"
	desc = "A rigid armor set that appears to be fashioned from a radiation suit, or a mining suit."
	icon_state = "iconoclast"
	item_state = "iconoclast"

/obj/item/clothing/suit/armor/f13/raider/iconoclast/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile
	name = "base faction exile armor"
	desc = "this is for testing."
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 40, "bullet" = 25, "laser" = 20, "energy" = 20, "bomb" = 40, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 20)
	strip_delay = 30
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/exile/ncrexile
	name = "modified NCR armor"
	desc = "A modified detoriated armor kit consisting of NCR gear and scrap metal."
	icon_state = "ncrexile"
	item_state = "ncrexile"

/obj/item/clothing/suit/armor/f13/exile/ncrexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile/legexile
	name = "modified Legion armor"
	desc = "A modified detoriated armor kit consisting of Legion gear and scrap metal."
	icon_state = "legexile"
	item_state = "legexile"

/obj/item/clothing/suit/armor/f13/exile/legexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/exile/bosexile
	name = "modified Brotherhood armor"
	desc = "A modified detoriated armor kit consisting of brotherhood combat armor and scrap metal."
	icon_state = "brotherhoodexile"
	item_state = "brotherhoodexile"

/obj/item/clothing/suit/armor/f13/exile/bosexile/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/suit/armor/f13/raider/raidercombat
	name = "raider combat armor"
	desc = "An old military-grade pre-war combat armor. It appears to be fitted with metal plates to replace the crumbling ceramic."
	icon_state = "raider_combat"
	item_state = "raider_combat"
	armor = list("melee" = 42, "bullet" = 40, "laser" = 35, "energy" = 30, "bomb" = 50, "bio" = 50, "rad" = 10, "fire" = 60, "acid" = 10)

/obj/item/clothing/suit/armor/f13/raider/raidermetal
	name = "raider metal armor"
	desc = "A suit of welded, fused metal plates. Looks bulky, with great protection."
	icon_state = "raider_metal"
	item_state = "raider_metal"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 35, "energy" = 35, "bomb" = 50, "bio" = 50, "rad" = 10, "fire" = 60, "acid" = 10)
	resistance_flags = FIRE_PROOF

//Legion

/obj/item/clothing/suit/armor/f13/legion
	name = "legion armor"
	desc = "Unadorned Legion armor."
	icon_state = "legrecruit"
	item_state = "legarmor"
	lefthand_file = 'icons/mob/inhands/clothing_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing_righthand.dmi'
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	allowed = list(/obj/item/gun, /obj/item/claymore, /obj/item/throwing_star/spear, /obj/item/restraints/legcuffs/bola, /obj/item/twohanded)
	armor = list("melee" = 40, "bullet" = 25, "laser" = 10, "energy" = 10, "bomb" = 16, "bio" = 30, "rad" = 20, "fire" = 50, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/recruit
	name = "legion recruit armor"
	desc = "Legion recruit armor is a common light armor, supplied to recruit legionaries and to recruit decanus units. Like most Legion armor, it is made from repurposed sports equipment, consisting of a football player's protective shoulder and chest pads reinforced with additional leather padding and worn over a baseball catcher's vest."
	icon_state = "legrecruit"
	slowdown = -0.15

/obj/item/clothing/suit/armor/f13/legion/recruit/scout
	name = "legion scout armor"
	desc = "A modified set of recruit armor with the chestplate removed to provide greater agility and reduce weight."
	icon_state = "legscout"

/obj/item/clothing/suit/armor/f13/legion/prime
	name = "legion prime armor"
	desc = "It's a legion prime armor, supplied to recruits who have survived several skirmishes, and are more worthy of sturdier equipment."
	icon_state = "legprime"
	slowdown = -0.13
	armor = list("melee" = 50, "bullet" = 35, "laser" = 15, "energy" = 15, "bomb" = 25, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/vet
	name = "legion veteran armor"
	desc = "Armor worn by veteran legionaries who have proven their combat prowess in many battles, its hardened leather is sturdier than that of previous ranks."
	icon_state = "legvet"
	slowdown = -0.1
	armor = list("melee" = 60, "bullet" = 40, "laser" = 25, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/heavy
	name = "legion veteran decan armor"
	desc = "Heavy metal armor worn by the Veteran Decanii retinue of the region."
	icon_state = "legmetal"
	item_state = "legmetal"
	slowdown = -0.1
	armor = list("melee" = 65, "bullet" = 45, "laser" = 25, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/vet/explorer
	name = "legion explorer armor"
	desc = "A modified set of veteran armor with much of the metal replaced by layered strips of laminated linen and leather."
	icon_state = "legexplorer"

/obj/item/clothing/suit/armor/f13/legion/vet/vexil
	name = "legion vexillarius armor"
	slowdown = -0.12
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of circular metal plates attached to the torso, as well as a banner displaying the flag of the Legion worn on the back."
	icon_state = "legvexil"

/obj/item/clothing/suit/armor/f13/legion/venator
	name = "legion venator armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of bracers and a chainmail skirt."
	icon_state = "legvenator"
	armor = list("melee" = 60, "bullet" = 50, "laser" = 30, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/vet/orator
	name = "legion orator armor"
	desc = "The armor appears to be based off of a suit of Legion veteran armor, with the addition of bracers, a chainmail skirt, and large pauldrons.  A tabard emblazoned with the bull is loosely draped over the torso."
	icon_state = "legheavy"
	armor = list("melee" = 65, "bullet" = 50, "laser" = 30, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/centurion
	name = "legion centurion armor"
	desc = "The Legion centurion armor is by far the strongest suit of armor available to Caesar's Legion. The armor is composed from other pieces of armor taken from that of the wearer's defeated opponents in combat."
	icon_state = "legcenturion"
	slowdown = -0.13
	armor = list("melee" = 60, "bullet" = 45, "laser" = 30, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/palacent
	name = "paladin-slayer centurion armor"
	desc = "The armor of a Centurion who has bested one or more Brotherhood Paladins, adding pieces of his prizes to his own defense. The symbol of the Legion is crudely painted on this once-marvelous suit of armor."
	icon_state = "palacent"
	armor = list("melee" = 75, "bullet" = 50, "laser" = 35, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/palacent/custom_excess
	name = "Champion of Kanab's Armor"
	desc = "The armor of the Champion and Conqueror of the city in Utah named Kanab. The armor is made up of pieces of Power Armor and pre-war Riot Gear, the shin guards are spraypainted a dark crimson and the Power Armour pauldron has a red trim. The symbol of a Pheonix is carefully engraved and painted upon the chest piece... I wonder what it means.."
	icon_state = "palacent_excess"
	item_state = "palacent_excess"

/obj/item/clothing/suit/armor/f13/legion/rangercent
	name = "ranger-hunter centurion armor"
	desc = "A suit of armor collected over the years by the deaths of countless NCR rangers. It forfeits protection for added speed."
	icon_state = "rangercent"
	item_state = "rangercent"
	slowdown = -0.2
	armor = list("melee" = 55, "bullet" = 40, "laser" = 25, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/legion/legate
	name = "legion legate armor"
	desc = "The armor appears to be a full suit of heavy gauge steel and offers full body protection. It also has a cloak in excellent condition, but the armor itself bears numerous battle scars and the helmet is missing half of the left horn. The Legate's suit appears originally crafted, in contrast to other Legion armor which consists of repurposed pre-War sports equipment."
	icon_state = "leglegat"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 85, "bullet" = 60, "laser" = 40, "energy" = 40, "bomb" = 45, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/combat/mk2/leg
	name = "legatus armor mk2"
	desc = "An old military grade pre war combat armor, specially designed for a Legionary Legatus."
	icon_state = "combat_armor_mk2_leg"
	item_state = "combat_armor_mk2_leg"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 45, "bullet" = 55, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)
	icon = 'icons/fallout/clothing_w/suit.dmi'

/obj/item/clothing/suit/armor/f13/caeserpelt
	name = "Caesars' Pelt"
	desc = "A pelt fit for Caeser himself. Ave!"
	icon = 'icons/fallout/clothing_w/suit.dmi'
	icon_state = "caesar_pelt"
	item_state = "caeser_pelt"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 45, "bullet" = 55, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)

//NCR
/obj/item/clothing/suit/armor/f13/ncrarmor
	name = "NCR patrol vest"
	desc = "A standard issue NCR Infantry vest."
	icon_state = "ncr_infantry_vest"
	item_state = "ncr_infantry_vest"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	armor = list("melee" = 40, "bullet" = 35, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/mantle
	name = "NCR mantle vest"
	desc = "A standard issue NCR Infantry vest with a mantle on the shoulder."
	icon_state = "ncr_standard_mantle"
	item_state = "ncr_standard_mantle"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/reinforced
	name = "NCR reinforced patrol vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad."
	icon_state = "ncr_reinforced_vest"
	item_state = "ncr_reinforced_vest"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/mantle/reinforced
	name = "NCR reinforced mantle vest"
	desc = "A standard issue NCR Infantry vest reinforced with a groinpad and a mantle."
	icon_state = "ncr_reinforced_mantle"
	item_state = "ncr_reinforced_mantle"
	armor = list("melee" = 55, "bullet" = 45, "laser" = 35, "energy" = 20, "bomb" = 30, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/labcoat
	name = "NCR medical labcoat"
	desc = "An armored labcoat typically issued to NCR Medical Officers. It's a standard white labcoat with the Medical Officer's name stitched into the breast and a two headed bear sewn into the shoulder."
	icon_state = "ncr_labcoat"
	item_state = "ncr_labcoat"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	allowed = list(/obj/item/gun, /obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight/pen, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/classic_baton/telescopic, /obj/item/soap, /obj/item/sensor_device, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/suit/armor/f13/ncrarmor/captain
	name = "NCR reinforced officer vest"
	desc = "A heavily reinforced set of NCR mantle armour, the armor has been heavily patched and given ceramic inserts in vital areas to protect the wearer. The design indicates it belongs to a high ranking NCR officer."
	icon_state = "ncr_captain_armour"
	item_state = "ncr_captain_armour"
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 50, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/scout
	name = "NCR 3rd Scout combat armor"
	desc = "A specialized variant of combat armor issued to members of the 3rd Scout Battalion."
	icon_state = "scoutarmor"
	item_state = "scoutarmor"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 30, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 30, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/scout/veteran
	name = "NCR 3rd Scout veteran combat armor"
	desc = "A specialized variant of combat armor issued to veteran members of the 3rd Scout Battalion."
	armor = list("melee" = 55, "bullet" = 45, "laser" = 35, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 30, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrarmor/scout/officer
	name = "NCR 3rd Scout officer combat armor"
	icon_state = "scout_armor_lt"
	item_state = "scout_armor_lt"
	desc = "A specialized variant of combat armor issued to officers of the 3rd Scout Battalion."
	armor = list("melee" = 60, "bullet" = 50, "laser" = 40, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 30, "fire" = 60, "acid" = 0)

/obj/item/clothing/suit/armor/f13/ncrcfjacket
	name = "NCRCF jacket"
	icon_state = "ncrcfjacket"
	item_state = "ncrcfjacket"
	desc = "A cheap, standard issue teal canvas jacket issued to poor suckers who find themselves at the butt-end of the NCR's judiciary system."
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0, "energy" = 0, "bomb" = 15, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/armor/f13/combat/mk2/ncr
	name = "combat armor mk2"
	desc = "An old military grade pre war combat armor, modified to the NCR's standard."
	icon_state = "combat_armor_mk2_ncr"
	item_state = "combat_armor_mk2_ncr"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 45, "bullet" = 55, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)
	icon = 'icons/fallout/clothing_w/suit.dmi'


//NCR Ranger
/obj/item/clothing/suit/toggle/armor/f13/rangerrecon
	name = "ranger recon duster"
	desc = "A thicker than average duster worn by NCR recon rangers out in the field. It's not heavily armored by any means, but is easy to move around in and provides excellent protection from the harsh desert environment."
	icon_state = "duster_recon"
	item_state = "duster_recon"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 35, "bullet" = 30, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	slowdown = -0.1

/obj/item/clothing/suit/armor/f13/trailranger
	name = "ranger vest"
	desc = "A quaint little jacket and scarf worn by NCR trail rangers."
	icon_state = "cowboyrang"
	item_state = "cowboyrang"
	armor = list("melee" = 40, "bullet" = 35, "laser" = 20, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	slowdown = -0.14

/obj/item/clothing/suit/armor/f13/combat/ncr
	name = "ranger patrol armor"
	desc = "A set of standard issue ranger patrol armor that provides defense similar to a suit of pre-war combat armor. It's got NCR markings, making it clear who it was made by."
	icon_state = "ncr_patrol"
	item_state = "ncr_patrol"

/obj/item/clothing/suit/armor/f13/rangercombat
	name = "veteran ranger combat armor"
	desc = "The NCR veteran ranger combat armor, or black armor consists of a pre-war L.A.P.D. riot suit under a duster with rodeo jeans. Considered one of the most prestigious suits of armor to earn and wear while in service of the NCR Rangers."
	icon_state = "ranger"
	item_state = "ranger"
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
	armor = list("melee" = 55, "bullet" = 55, "laser" = 55, "energy" = 40, "bomb" = 55, "bio" = 60, "rad" = 60, "fire" = 90, "acid" = 20)

/obj/item/clothing/suit/armor/f13/rangercombat/eliteriot
	name = "elite riot gear"
	desc = "A heavily reinforced set of military grade armor, commonly seen in the Divide now repurposed and reissued to Chief Rangers."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	armor = list("melee" = 65, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 70, "bio" = 60, "rad" = 60, "fire" = 90, "acid" = 50)
	icon = 'icons/fallout/clothing_w/suit.dmi'

/obj/item/clothing/suit/armor/f13/rangercombat/eliteriot/reclaimed
	name = "reclaimed desert ranger helmet"
	desc = "A refurbished and personalized set of pre-unification desert ranger gear."
	icon_state = "reclaimed_desert_ranger"
	item_state = "reclaimed_desert_ranger"
	armor = list("melee" = 30, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 30)
	icon = 'icons/fallout/clothing_w/suit.dmi'
	
/obj/item/clothing/suit/armor/f13/rangercombat/desert
	name = "desert ranger combat armor"
	desc = "This is the original armor the NCR Ranger Combat armor was based off of. An awe inspiring suit of armor used by the legendary Desert Rangers."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"

/obj/item/clothing/suit/armor/f13/rangercombat/old
	name = "worn veteran ranger combat armor"
	desc = "A unique armor, that has been in countless battles and caused much bloodshed."
	icon_state = "oldranger"
	item_state = "oldranger"
	armor = list(melee = 40, bullet = 20, laser = 20, energy = 20, bomb = 20, bio = 0, rad = 30, fire = 20, acid = 20)
	icon = 'icons/fallout/clothing/suits.dmi'

//NCR Armors I've never seen used and can possibly be deleted
/obj/item/clothing/suit/armor/f13/ncrarmor/soldier
	name = "standard issue trooper armor"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons, and gauntlets, worn by NCR soldiers in combat environments.<br>This one has had its breastplate emblazoned with the emblem of the NCR, that has slightly faded over time."
	icon_state = "ncr_armor2"
	item_state = "ncr_armor2"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/patriot
	name = "trooper armor of \"Patriot\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR patriots in combat environments.<br>This one has a five-pointed star painted over the chestplate with white paint - it must be a battalion insignia."
	icon_state = "ncr_armor3"
	item_state = "ncr_armor3"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/commie
	name = "trooper armor of \"Commie\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR comrades in combat environments.<br>This one has a five-pointed star painted over the chestplate with red paint - it must be a battalion insignia."
	icon_state = "ncr_armor4"
	item_state = "ncr_armor4"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/preacher
	name = "trooper armor of \"Preacher\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR zealots in combat environments.<br>This one has a holy cross painted over the chestplate with yellow paint - it must be a battalion insignia."
	icon_state = "ncr_armor5"
	item_state = "ncr_armor5"

/obj/item/clothing/suit/armor/f13/ncrarmor/lover
	name = "trooper armor of \"Lover\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR lovers in combat environments.<br>This one has a heart symbol painted over the chestplate with pink paint - it must be a battalion insignia."
	icon_state = "ncr_armor6"
	item_state = "ncr_armor6"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/stalker //Cheeki breeki i v damke !!!
	name = "trooper armor of \"Stalker\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR explorers in combat environments.<br>This one has a radiation symbol painted over the chestplate with yellow paint - it must be a battalion insignia."
	icon_state = "ncr_armor7"
	item_state = "ncr_armor7"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/punisher
	name = "trooper armor of \"Punisher\" battalion"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR heroes and villains in combat environments.<br>This one has a skull symbol painted over the chestplate with white paint - it must be a battalion insignia."
	icon_state = "ncr_armor8"
	item_state = "ncr_armor8"
	icon = 'icons/fallout/clothing/suits.dmi'

/obj/item/clothing/suit/armor/f13/ncrarmor/facewrap
	name = "face wrap armor"
	desc = "A set of NCR armor that consists of an armored breastplate, metal pauldrons and gauntlets, worn by NCR scouts in combat environments.<br>This one has the facewrap, designed to be pulled over the user's face to protect oneself from dust particles and other mainly radioactive elements."
	icon_state = "ncr_armor9"
	item_state = "ncr_armor9"
	armor = list(melee = 30, bullet = 20, laser = 10, energy = 10, bomb = 20, bio = 0, rad = 30, fire = 10, acid = 10) //Better radiation protection, thank the facewrap bro!
	icon = 'icons/fallout/clothing/suits.dmi'

//Brotherhood of Steel

/obj/item/clothing/suit/armor/f13/headscribe
    name = "brotherhood head scribe robe"
    desc = "A red cloth robe with gold trimmings, worn eclusively by the Head Scribe of a chapter."
    icon_state = "headscribe"
    item_state = "headscribe"
    body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS
    armor = list("melee" = 15, "bullet" = 16, "laser" = 0, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 10, "acid" = 0)

/obj/item/clothing/suit/f13/scribe
	name = "Brotherhood Scribe's robe"
	desc = "A red cloth robe worn by the Brotherhood of Steel Scribes."
	icon_state = "scribe"
	item_state = "scribe"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 15, "bullet" = 16, "laser" = 15, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/seniorscribe
	name = "Brotherhood Senior Scribe's robe"
	desc = "A red cloth robe with silver gildings worn by the Brotherhood of Steel Senior Scribes."
	icon_state = "seniorscribe"
	item_state = "seniorscribe"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 15, "bullet" = 16, "laser" = 15, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/suit/f13/elder
	name = "Brotherhood Elder's robe"
	desc = "A blue cloth robe with some scarlet red parts, traditionally worn by the Brotherhood of Steel Elder."
	icon_state = "elder"
	item_state = "elder"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list("melee" = 15, "bullet" = 16, "laser" = 15, "energy" = 0, "bomb" = 16, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	allowed = list(/obj/item/gun)

/obj/item/clothing/suit/armor/f13/combat/brotherhood
	name = "brotherhood combat armor"
	desc = "A superior combat armor set made by the Brotherhood of Steel, standard issue for all Knights. It bears a red stripe."
	icon_state = "brotherhood_armor"
	item_state = "brotherhood_armor"
	armor = list("melee" = 40, "bullet" = 45, "laser" = 40, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/suit/armor/f13/combat/knightcap
	name = "knight-captain combat armor"
	desc = "A customized set of combat armor designed for the Knight-Captain, with golden embroidery."
	icon_state = "knightcap"
	item_state = "knightcap"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 45, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)


/obj/item/clothing/suit/armor/f13/combatbosrein
	name = "reinforced brotherhood combat armor"
	desc = "A heavily-reinforced combat suit of prewar design, but postwar influence. It's marked in deep black with the insignia of the Brotherhood of Steel."
	icon_state = "combat_armor_reinforced_bos"
	item_state = "combat_armor_reinforced_bos"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 45, "bullet" = 55, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)
	icon = 'icons/fallout/clothing_w/suit.dmi'

//Oasis/Town
/obj/item/clothing/suit/armor/f13/town
	name = "town trenchcoat"
	desc = "A non-descript black trenchcoat."
	icon_state = "towntrench"
	item_state = "hostrench"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	armor = list("melee" = 40, "bullet" = 30, "laser" = 20, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 30, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/town/mayor
	name = "mayor trenchcoat"
	desc = "A symbol of the mayor's authority (or lack thereof)."

/obj/item/clothing/suit/armor/f13/town/sheriff
	name = "sheriff trenchcoat"
	desc = "A trenchcoat which does not attempt to hide the full-body combat armor beneath it."
	icon_state = "towntrench_heavy"
	armor = list("melee" = 60, "bullet" = 50, "laser" = 30, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/town/embroidered
	name = "embroidered trenchcoat"
	desc = "A custom armored trench coat with extra-length and a raised collar. There's a flower embroidered onto the back, although the color is a little faded."
	icon_state = "towntrench_special"
	item_state = "towntrench_special"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 25, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 35, "fire" = 80, "acid" = 0)

/obj/item/clothing/suit/armor/f13/town/deputy
	name = "deputy trenchcoat"
	desc = "An armored trench coat with added shoulderpads, a chestplate, and legguards."
	icon_state = "towntrench_medium"
	armor = list("melee" = 50, "bullet" = 40, "laser" = 25, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 35, "fire" = 80, "acid" = 0)

//Great Khan
/obj/item/clothing/suit/armor/khan_jacket
	name = "khan armored jacket"
	desc = "The symbol of the greatest pushers."
	icon_state = "khan_jacket"
	item_state = "khan_jacket"

//Wayfarer
/obj/item/clothing/suit/armor/f13/tribe_armor
	name = "light tribal armor"
	desc = "Light armor made of leather stips and a large, flat piece of turquoise.Armor commonplace among the Wayfinders."
	icon_state = "tribal_armor"
	item_state = "tribal_armor"
	body_parts_covered = CHEST|GROIN|ARMS
	armor = list("melee" = 45, "bullet" = 30, "laser" = 35, "energy" = 25, "bomb" = 25, "bio" = 70, "rad" = 65, "fire" = 80, "acid" = 100)
	allowed = list(/obj/item/gun, /obj/item/kitchen, /obj/item/twohanded, /obj/item/claymore, /obj/item/spear)

/obj/item/clothing/suit/armor/f13/tribe_heavy_armor
	name = "heavy tribal armor"
	desc = "Heavy armor make of sturdy leather and pieces of bone. Worn by seasoned veterans within the Wayfinder tribe."
	icon_state = "heavy_tribal_armor"
	item_state = "heavy_tribal_armor"
	armor = list("melee" = 45, "bullet" = 50, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)
	flags_inv = HIDEJUMPSUIT
	allowed = list(/obj/item/gun, /obj/item/kitchen, /obj/item/twohanded, /obj/item/claymore, /obj/item/spear)

//Followers

//Vault

//Gunner/Locust

/obj/item/clothing/suit/armor/f13/gunnerplates
	name = "gunner armor"
	desc = "An old military grade pre war combat armor. This armor has a skull painted on the back to symbolize the gunners."
	icon_state = "GunnerPlates"
	item_state = "GunnerPlates"
	slowdown = 0
	flags_inv = HIDEJUMPSUIT|HIDENECK
	icon = 'icons/fallout/clothing_w/suit.dmi'
	armor = list("melee" = 45, "bullet" = 55, "laser" = 45, "energy" = 45, "bomb" = 55, "bio" = 65, "rad" = 10, "fire" = 60, "acid" = 20)

//COMMENTED OUT STUFF. I NEED TO GET BIGGER BALLS AND JUST DELETE THINGS
/*
/obj/item/clothing/suit/armor/f13/exile/r
	name = "reinforced base faction exile armor"
	desc = "this is for testing"
	armor = list("melee" = 55, "bullet" = 40, "laser" = 30, "energy" = 30, "bomb" = 50, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 20)
	strip_delay = 30

/obj/item/clothing/suit/armor/f13/exile/r/ncr
	name = "reinforced modified NCR armor"
	desc = "A modified detoriated armor kit consisting of NCR gear and scrap metal.This set has been add additional protective plates fused inside of the armor, granting additional protection."
	icon_state = "ncrexile"
	item_state = "ncrexile"

/obj/item/clothing/suit/armor/f13/exile/r/legion
	name = "reinforced modified Legion armor"
	desc = "A modified detoriated armor kit consisting of Legion gear and scrap metal.This set has been add additional protective plates fused inside of the armor, granting additional protection."
	icon_state = "legexile"
	item_state = "legexile"

/obj/item/clothing/suit/armor/f13/exile/r/bos
	name = "reinforced modified Brotherhood armor"
	desc = "A modified detoriated armor kit consisting of brotherhood combat armor and scrap metal. This set has been add additional protective plates fused inside of the armor, granting additional protection."
	icon_state = "brotherhoodexile"
	item_state = "brotherhoodexile"

/obj/item/clothing/suit/armor/f13/raider/r/
	name = "reinforced base raider armor"
	armor = list("melee" = 40, "bullet" = 45, "laser" = 45, "energy" = 45, "bomb" = 45, "bio" = 0, "rad" = 0, "fire" = 30, "acid" = 30)

/obj/item/clothing/suit/armor/f13/raider/r/supafly
	name = "reinforced supa-fly raider armor"
	desc = "Fabulous mutant powers were revealed to me the day I held aloft my bumper sword and said...<br>BY THE POWER OF NUKA-COLA, I AM RAIDER MAN!"
	icon_state = "supafly"
	item_state = "supafly"

/obj/item/clothing/suit/armor/f13/raider/r/sadist
	name = "reinforced sadist raider armor"
	desc = "a bunch of metal chaps adorned with severed hands at the waist with a leather plate worn on the left shoulder"
	icon_state = "sadist"
	item_state = "sadist"

/obj/item/clothing/suit/armor/f13/raider/r/blastmaster
	name = "reinforced blastmaster raider armor"
	desc = "A bunch of leather straped around the torso that support a tire worn on the left shoulder. "
	icon_state = "blastmaster"
	item_state = "blastmaster"
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	flash_protect = 2

/obj/item/clothing/suit/armor/f13/raider/r/yankee
	name = "yankee raider armor"
	desc = "A set of armor made from football player protective wear. Together we play."
	icon_state = "yankee"
	item_state = "yankee"

/obj/item/clothing/suit/armor/f13/raider/r/badlands
	name = "badlands raider armor"
	desc = "A leather top with a bandolier over it and a straps that cover the arms"
	icon_state = "badlands"
	item_state = "badlands"

/obj/item/clothing/suit/armor/f13/raider/r/painspike
	name = "painspike raider armor"
	desc = "A particularly unhuggable armor, even by raider standards."
	icon_state = "painspike"
	item_state = "painspike"

/obj/item/clothing/suit/armor/f13/raider/r/iconoclast/
	name = "iconoclast raider armor"
	desc = "A rigid armor set that appears to be fashioned from a radiation suit, or a mining suit."
	icon_state = "iconoclast"
	item_state = "iconoclast"
*/
