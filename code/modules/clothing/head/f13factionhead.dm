/*PARENT ITEMS FOR REFERENCE PURPOSES. DO NOT UNCOMMENT
/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = INV_SLOTBIT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	dynamic_hair_suffix = "+generic"
	var/datum/beepsky_fashion/beepsky_fashion //the associated datum for applying this to a secbot
	var/list/speechspan = null
	armor = list("melee" = 20, "bullet" = 10, "laser" = 10, "bio" = 0, "bomb" = 10, "rad" = 0, "fire" = 25, "acid" = 25)
	slowdown = 0

/obj/item/clothing/head/Initialize()
	. = ..()
	if(ishuman(loc) && dynamic_hair_suffix)
		var/mob/living/carbon/human/H = loc
		H.update_hair()

/obj/item/clothing/head/get_head_speechspans(mob/living/carbon/user)
	if(speechspan)
		return speechspan
	else
		return

/obj/item/clothing/head/helmet
	name = "helmet"
	desc = "Standard Security gear. Protects the head from impacts."
	icon_state = "helmet"
	item_state = "helmet"
	armor = list("melee" = 40, "bullet" = 40, "laser" = 40, energy = "25", "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50, "wound" = 10)
	flags_inv = HIDEEARS | HIDEHAIR
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES

	dog_fashion = /datum/dog_fashion/head/helmet

/obj/item/clothing/head/helmet/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(SLOT_HEAD))*/

//Raider
/obj/item/clothing/head/helmet/f13/raider
	name = "base raider helmet"
	desc = "for testing"
	icon_state = "supafly"
	item_state = "supafly"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T1)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	slowdown = 0

/obj/item/clothing/head/helmet/f13/raider/supafly
	name = "supa-fly raider helmet"
	desc = "It's a makeshift raider helmet, made of leather. It heavily smells with chems and sweat."
	icon_state = "supafly"
	item_state = "supafly"

/* /obj/item/clothing/head/helmet/f13/raider/supafly/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

 */
/obj/item/clothing/head/helmet/f13/raider/wastehound
	name = "wastehound raider helmet"
	desc = "A sack hood made out of a suspicious leather with tufts of hair sticking out. This mask would make Leatherface proud."
	icon_state = "wastehound_hood_icon"
	item_state = "raider_wastehound_hood"
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE

/* /obj/item/clothing/head/helmet/f13/raider/wastehound/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/raider/arclight
	name = "arclight raider helmet"
	desc = "Welding mask with rare polarizing glass thats somehow still in working order. A treasured item in the wasteland."
	icon_state = "arclight"
	item_state = "arclight"
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	flash_protect = 2
	tint = 0.5

/* /obj/item/clothing/head/helmet/f13/raider/arclight/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate) */

/obj/item/clothing/head/helmet/f13/raider/blastmaster
	name = "blastmaster raider helmet"
	desc = "A sturdy helmet to protect against both the elements and from harm, if only it was not looking in such poor condition."
	icon_state = "blastmaster"
	item_state = "blastmaster"
	armor_tokens = list(ARMOR_MODIFIER_UP_BOMB_T3, ARMOR_MODIFIER_UP_DT_T1)
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/* /obj/item/clothing/head/helmet/f13/raider/blastmaster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/raider/yankee
	name = "yankee raider helmet"
	desc = "Long time ago, it has belonged to a football player, now it belongs to wasteland."
	icon_state = "yankee"
	item_state = "yankee"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE

/* /obj/item/clothing/head/helmet/f13/raider/yankee/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/raider/eyebot
	name = "eyebot helmet"
	desc = "It is a dismantled eyebot, hollowed out to accommodate for a humanoid head."
	icon_state = "eyebot"
	item_state = "eyebot"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	strip_delay = 50
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/* /obj/item/clothing/head/helmet/f13/raider/eyebot/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/raider/psychotic
	name = "psycho-tic raider helmet"
	desc = "A leather skullcap with tufts of hair sticking from each side."
	icon_state = "psychotic"
	item_state = "psychotic"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR

/* /obj/item/clothing/head/helmet/f13/raider/psychotic/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/fiend
	name = "fiend helmet"
	desc = "A leather cap cobbled together adorned with a bighorner skull, perfect for any drug-fueled frenzy."
	icon_state = "fiend"
	item_state = "fiend"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/fiend_reinforced
	name = "reinforced fiend helmet"
	desc = "A leather cap cobbled together adorned with a bighorner skull, perfect for any drug-fueled frenzy. This helmet has been reinforced with metal plates under its skull"
	icon_state = "fiend"
	item_state = "fiend"
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T2)
	flags_inv = HIDEEARS|HIDEHAIR
	slowdown = 0.025

/obj/item/clothing/head/helmet/f13/raidermetal
	name = "metal raider helmet"
	desc = "A metal helmet, rusty and awful."
	icon_state = "raidermetal"
	item_state = "raidermetal"
	can_toggle = TRUE
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T2)
	flags_inv = HIDEMASK|HIDEEYES|HIDEFACE
	strip_delay = 80
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/f13/raidercombathelmet
	name = "combat raider helmet"
	desc = "A combat helmet modified with metal plating"
	icon_state = "raider_combat_helmet"
	item_state = "raider_combat_helmet"
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T2)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	slowdown = 0.025


///////////
//ENCLAVE//
///////////


/obj/item/clothing/head/f13/enclave
	name = "officer hat"
	desc = "A standard-issue Enclave officer's cap."
	icon_state = "enclave"
	item_color = "enclave"

/* /obj/item/clothing/head/helmet/soft/f13/enclave/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/enclave/peacekeeper
	name = "peacekeeper cap"
	desc = "Reinforced field cap issued to the soldiers of the Enclave."
	icon_state = "hat_enclave_peacekeeper"
	item_state = "hat_enclave_peacekeeper"

/obj/item/clothing/head/beret/enclave
	name = "enclave beret"
	desc = "A standard issue black beret of the Enclave."
	icon_state = "remnant"
	item_state = "remnant"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = null

/obj/item/clothing/head/beret/enclave/science
	name = "science beret"
	desc = "Blue beret signifying the wearer is a Science Officer of the Enclave."
	icon_state = "hat_enclave_science"
	item_state = "hat_enclave_science"

/obj/item/clothing/head/beret/enclave/intel
	name = "intel beret"
	desc = "Dark beret issued to Intelligence Officers of the Enclave."
	icon_state = "hat_enclave_intel"
	item_state = "hat_enclave_intel"

/obj/item/clothing/head/helmet/f13/envirosuit
	name = "enclave envirosuit hood"
	icon_state = "envirohead"
	item_state = "envirohead"
	desc = "A white hazmat helmet designed and produced by the Enclave post-war. It's probably not a good idea to be seen wearing this."
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_UP_LASER_T2, ARMOR_MODIFIER_UP_FIRE_T3, ARMOR_MODIFIER_UP_ENV_T4)
	strip_delay = 60
	equip_delay_other = 60
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/head/helmet/f13/enclave/marine
	name = "old United States Marine Corp helmet"
	desc = "An advanced model of combat helmet worn by marines aboard the USS Democracy, second only to power armor in protection used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "enclave_marine"
	item_state = "enclave_marine"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T2)

/* /obj/item/clothing/head/helmet/f13/enclave/marine/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/enclave/usmcriot
	name = "old United States Marine Corp riot helmet"
	desc = "A Pre-Fall riot armor helmet used by the USCM For various tasks and operations, it's handled the nuclear wasteland somewhat better than the rest of the armors you've seen."
	icon_state = "modified_usmc_riot"
	item_state = "modified_usmc_riot"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	armor_tokens = list(ARMOR_MODIFIER_UP_DT_T2)

/obj/item/clothing/head/helmet/f13/combat/mk2/remnant
	name = "remnant combat helmet"
	desc = "A dark helmet with yellow lenses, used commonly in espionage or shadow ops."
	icon_state = "remnant_helmet"
	item_state = "remnant_helmet"

// Lieutenant's hat
/obj/item/clothing/head/helmet/f13/enclave/officer
	name = "enclave officer hat"
	desc = "Wheeled hat with a cap made of light-weight armored alloys beneath."
	icon_state = "hat_enclave_officer"
	item_state = "hat_enclave_officer"


//////////
//LEGION//
//////////


/obj/item/clothing/head/helmet/f13/legion
	name = "legion helmet template"
	desc = "should not exist."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	lefthand_file = ""
	righthand_file = ""
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 1)

/* /obj/item/clothing/head/helmet/f13/legion/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/legion/marsheaddress
	name = "priestess' headdress"
	desc = "A headdress made of feathers and decorated with two golden tassles."
	icon_state = "legion-priestess"
	item_state = "legion-priestess"
	dynamic_hair_suffix = "+generic"
	salvage_loot = list()

/obj/item/clothing/head/helmet/f13/legion/recruit
	name = "leather skullcap"
	desc = "It's a leather skullcap commonly worn by more wastey wastelanders."
	icon_state = "legion-recruit"
	item_state = "legion-recruit"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/legion/prime
	name = "larper prime helmet"
	desc = "A helmet from reinforced leather with a red peak. Despite being a replica it seems decent quality."
	item_state = "legion-prime"
	icon_state = "legion-prime"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/legion/prime/slavemaster
	name = "middlemanagement helmet"
	desc = "The distinct helmet used by cruel taskmasters."
	icon_state = "legion-slavemaster"
	item_state = "legion-slavemaster"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/f13/legion/vet
	name = "larper 'veteran' helmet"
	desc = "It's a 'metal' larping helmet, clearly inspired by old world sports uniforms and a love of men."
	icon_state = "legion-veteran"
	item_state = "legion-veteran"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/obj/item/clothing/head/helmet/f13/legion/vet/explorer
	name = "padded tanker's cap"
	desc = "It's a hooded cap with extra padding and built in voids to wear bulky headphones under. T-55 not included, sadly this alone won't let you be tank girl."
	icon_state = "legion-explorer"
	item_state = "legion-explorer"

/obj/item/clothing/head/helmet/f13/legion/vet/combvexil
	name = "larping bear vexillarius helmet"
	desc = "This helmet is decorated with the pelt of an assland bear and menaces with leather spikes."
	icon_state = "legion-vex"
	item_state = "legion-vex"

/obj/item/clothing/head/helmet/f13/legion/vet/vexil
	name = "Furcon fox vexillarius helmet"
	desc = "This helmet is decorated with the pelt of a desert fox. Or... maybe its just a fursuit head missing parts.  Its hard to tell."
	icon_state = "legion-vex-alt"
	item_state = "legion-vex-alt"

/obj/item/clothing/head/helmet/f13/legion/vet/nightvexil
	name = "larper's nightstalker vexillarius helmet"
	desc = "This helmet is decorated with the pelt of a nightstalkers unkempt butt fur.  You should probably wash it."
	icon_state = "legion-vex-night"
	item_state = "legion-vex-night"

/obj/item/clothing/head/helmet/f13/legion/venator
	name = "the most lost explorer's hood"
	desc = "A leather hood with a sturdy metal skullcap and a gold compass insignia in the front."
	icon_state = "legion-venator"
	item_state = "legion-venator"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/obj/item/clothing/head/helmet/f13/legion/orator
	name = "just a bunch of leaves"
	desc = "A 'laurel wreath' that is made of branches and trash. It's pretending to be a laurel, a type of evergreen shrub or small tree. This one appears to be out of whatever was laying around, however. In Ancient Rome, it was worn on the head as a symbol of triumph. But who the fuck would have that here?"
	icon_state = "legion-orator"
	item_state = "legion-orator"
	flags_inv = null

/obj/item/clothing/head/helmet/f13/legion/recruit/decan
	name = "larper recruit deci-anus helmet"
	desc = "This reinforced leather helmet has a plume of black and dark red feathers that are hiding ten buttholes under them. Who the fuck made this?"
	icon_state = "legion-decrec"
	item_state = "legion-decrec"

/obj/item/clothing/head/helmet/f13/legion/prime/decan
	name = "amazon prime decanus helmet"
	desc = "This reinforced leather helmet with a red peak has a plume of black feathers and was a steal.  You should have bought four."
	item_state = "legion-decprime"
	icon_state = "legion-decprime"

/obj/item/clothing/head/helmet/f13/legion/heavy
	name = "reinforced amazon veteran decanus helmet"
	desc = "A metal helmet with 'ballistic' visor and a plume, denoting veteran Decanus status. You're pretty sure it was made for airsoft."
	icon_state = "legion-decvet"
	item_state = "legion-decvet"
	actions_types = list(/datum/action/item_action/toggle)
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/obj/item/clothing/head/helmet/f13/legion/heavy/attack_self(mob/user)
	weldingvisortoggle(user)
	icon_state = "legion-decvetup"
	item_state = "legion-decvetup"

/obj/item/clothing/head/helmet/f13/legion/vet/decan
	name = "Larpers veteran decanus 'helmet'"
	desc = "It's a metal 'helmet' (its a pot that they beat around someones head until it was vaguely head shaped) with an array of red, white and black feathers, unmistakably a Veteran Decanus."
	icon_state = "legion-decvet-alt"
	item_state = "legion-decvet-alt"

/obj/item/clothing/head/helmet/f13/legion/centurion
	name = "legion's of centurions helmet"
	desc = "That's a helmet of some sort, beaten out of a CN9-Ds StarGuard III armor.  How this Lyran battemechs chassis managed to be collected in the wacky wastelands of this place no one knows.  But it's stylish enough to make a Capellan vomit."
	icon_state = "legion-centurion"
	item_state = "legion-centurion"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/head/helmet/f13/legion/rangercent
	name = "ranger-hunter centurion helmet"
	desc = "Level 2 gameplay is really overrated, I prefer the succession wars personally.  Wait- what does that intrusive thought even mean?"
	icon_state = "legion-rangercent"
	item_state = "legion-rangercent"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/head/helmet/f13/legion/palacent  //more like placenta amirite ~TK
	name = "paladin-slayer centurion helmet"
	desc = "Holding this object makes you feel like your genitals are shriveling up.  If you have balls, you're certain they got smaller.  Whoever wore this thing in the past had serious ego issues."
	icon_state = "legion-palacent"
	item_state = "legion-palacent"
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3)

/obj/item/clothing/head/helmet/f13/legion/legate
	name = "canibal leg-ater helmet"
	desc = "A custom forged steel full helmet complete with abstract points and arches. The face is extremely intimidating, as it was meant to be. This particular one was ordered to be forged by Lil Caesar, given to his second leg-ater in exchange for his undying loyalty to the pizza chain."
	icon_state = "legion-legate"
	item_state = "legion-legate"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 5)

/obj/item/clothing/head/f13/servant
	name = "Linen headwrap"
	desc = "A simple uncoloured linen cloth wrapped around the head, the mark of a primed maid (femboy or otherwise) trained in household work."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "legion-servant"
	item_state = "legion-servant"
	flags_inv = HIDEEARS
	flags_cover = null

/obj/item/clothing/head/f13/auxilia
	name = "bitter tasting headwear"
	desc = "A soft red cap with a black band, used by people who tend to get the word bitters screamed at them a lot."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "legion-aux"
	item_state = "legion-aux"
	flags_inv = HIDEEARS
	flags_cover = null


//NCR

/obj/item/clothing/head/f13/ncr
	name = "NCR trooper helmet"
	desc = "A standard issue NCR steel helmet. Looks like you can write on it and strap a few items on the helmet band."
	icon_state = "ncr_steelpot"
	item_state = "ncr_steelpot"
	strip_delay = 50
	obj_flags = UNIQUE_RENAME
	reskinnable_component = /datum/component/reskinnable/ncr_helm
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 1)

/* /obj/item/clothing/head/f13/ncr/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/ncr/steelpot_goggles
	name = "NCR storm helmet"
	desc = "A standard issue NCR steel helmet, issued with an additional pair of storm goggles for weather resistance."
	icon_state = "steelpot_goggles"
	item_state = "steelpot_goggles"
	alt_toggle_message = "You push the goggles down "
	can_toggle = 1
	flags_inv = HIDEEARS
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null
	reskinnable_component = null


/obj/item/clothing/head/f13/ncr/steelpot_goggles/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(15)

/obj/item/clothing/head/f13/ncr/steelpot_goggles/trenchraider
	name = "NCR trench storm helmet"
	desc = "A standard issue NCR steel helmet, issued with extra steel for close quarters fighting."
	reskinnable_component = null

/obj/item/clothing/head/f13/ncr/steelpot_med
	name = "NCR medic helmet"
	desc = "A standard issue NCR steel helmet with the addition of decalling signifying a medic."
	icon_state = "steelpot_med"
	item_state = "steelpot_med"

/obj/item/clothing/head/f13/ncr/steelpot_mp
	name = "NCR military police helmet"
	desc = "A standard issue NCR steel helmet emblazoned with the initials of the military police."
	icon_state = "steelpot_mp"
	item_state = "steelpot_mp"

/obj/item/clothing/head/f13/ncr/steelpot_gambler
	name = "NCR gambler helmet"
	desc = "A standard issue NCR steel helmet. Stashed in the strap are decks of cards, dominoes and cigarettes for personal use."
	icon_state = "steelpot_gambler"
	item_state = "steelpot_gambler"

/obj/item/clothing/head/f13/ncr/steelpot_bandolier
	name = "NCR bandolier helmet"
	desc = "A standard issue NCR steel helmet. This one has clearly seen heavy use, as well as having additional bullets tucked into the strap."
	icon_state = "steelpot_bandolier"
	item_state = "steelpot_bandolier"

/obj/item/clothing/head/hardhat/ncr
	name = "NCR engineer helmet"
	desc = "A standard issue NCR Infantry helmet, modified with a head lamp for engineers."
	icon_state = "hardhat0_ncr"
	item_state = "hardhat0_ncr"
	item_color = "ncr"
	hat_type = "ncr"
	flags_inv = HIDEEARS
	dog_fashion = null

/obj/item/clothing/head/f13/ncr/standard/conscript
	name = "NCR conscript helmet"
	desc = "A standard issue NCR steel helmet. Looks like you can write on it and strap a few items on the helmet band."
	icon_state = "ncr_steelpot"
	item_state = "ncr_steelpot"
	flags_inv = HIDEEARS
	flags_cover = HEADCOVERSEYES
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null
	reskinnable_component = /datum/component/reskinnable/ncr_helm

/obj/item/clothing/head/f13/ncr/ncr_flapcap
	name = "NCR field cap"
	desc = "A special issue canvas NCR field cap with cotton neckflap, for sun protection in arid climates."
	icon_state = "ncr_flapcap"
	item_state = "ncr_flapcap"

/obj/item/clothing/head/f13/ncr/ncr_slouch
	name = "NCR slouch hat"
	desc = "An irregular issue NCR sun hat, the left side of the brim is pinned to the crown for ease with shouldering rifles."
	icon_state = "ncr_slouch"
	item_state = "ncr_slouch"

/obj/item/clothing/head/f13/ncr/ncr_stetson
	name = "NCR air cavalry stetson"
	desc = "A black brahmin leather stetson, authorized for usage amongst all troopers assigned to Air Cavalry units."
	icon_state = "ncr_stetson"
	item_state = "ncr_stetson"

/obj/item/clothing/head/f13/ncr/ncr_cap
	name = "NCR garrison cap"
	desc = "A simple cloth garrison cap to be worn when a helmet isn't necessary."
	icon_state = "ncr_cap"
	item_state = "ncr_cap"

/obj/item/clothing/head/f13/ncr/ncr_campaign
	name = "NCR campaign hat"
	desc = "A khaki campaign hat, popularly used by senior NCOs in the NCRA."
	icon_state = "ncr_campaign"
	item_state = "ncr_campaign"

/obj/item/clothing/head/beret/ncr
	name = "NCR officer beret"
	desc = "A green beret, standard issue for all commissioned NCR Officers."
	icon_state = "ncr_officer_beret"
	item_state = "ncr_officer_beret"

/obj/item/clothing/head/beret/ncr/ncr_medic
	name = "NCR medical beret"
	desc = "A white beret, issued to officers of the medical corps."
	icon_state = "ncr_medical_beret"
	item_state = "ncr_medical_beret"

/obj/item/clothing/head/beret/ncr/ncr_sapper
	name = "NCR Sapper beret"
	desc = "A grey beret, issued to troopers that have passed Sapper School."
	icon_state = "ncr_sapper_beret"
	item_state = "ncr_sapper_beret"

/obj/item/clothing/head/beret/ncr/ncr_sof
	name = "NCR SOF beret"
	desc = "A tan beret, issued members of the New California Republic Special Operations Command."
	icon_state = "ncr_sof_beret"
	item_state = "ncr_sof_beret"

/obj/item/clothing/head/beret/ncr_dresscap
	name = "NCR peaked cap"
	desc = "A tan peaked cap with silver pin, designated for enlisted NCRA personnel."
	icon_state = "ncr_dresscap"
	item_state = "ncr_dresscap"

/obj/item/clothing/head/beret/ncr_codresscap
	name = "NCR peaked cap"
	desc = "A tan peaked cap with golden pin, designated for commissioned NCRA personnel."
	icon_state = "ncr_codresscap"
	item_state = "ncr_codresscap"

//NCR Ranger

/obj/item/clothing/head/beret/ncr_recon_ranger
	name = "NCR Ranger scout beret"
	desc = "A brown beret, issued to members of the NCR Recon Rangers."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/* /obj/item/clothing/head/beret/ncr_recon_ranger/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/trailranger
	name = "NCR trail ranger hat"
	desc = "a rustic, homely style cowboy hat worn by NCR trail rangers. Yeehaw!"
	icon_state = "cowboyrang"
	item_state = "cowboyrang"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/* /obj/item/clothing/head/f13/trailranger/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/ranger
	name = "NCR ranger campaign hat"
	desc = "An NCR ranger hat, standard issue amongst all but the most elite rangers."
	icon_state = "rangerhat"
	item_state = "rangerhat"
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/* /obj/item/clothing/head/f13/ranger/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/combat/ncr_patrol
	name = "NCR patrol helmet"
	desc = "A combat helmet hand-manufactured in the NCR and issued to patrol rangers."
	icon_state = "ncr_patrol_helmet"
	item_state = "ncr_patrol_helmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 2)

/* /obj/item/clothing/head/helmet/f13/combat/ncr_patrol/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */

/obj/item/clothing/head/helmet/f13/ncr/rangercombat
	name = "ranger combat helmet"
	desc = "An old combat helmet, out of use around the time of the war."
	icon_state = "ranger"
	item_state = "ranger"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1
	glass_colour_type = /datum/client_colour/glass_colour/red
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	darkness_view = 24
	salvage_loot = list(/obj/item/stack/crafting/armor_plate = 3, /obj/item/clothing/glasses/night/polarizing = 1)

/* /obj/item/clothing/head/helmet/f13/ncr/rangercombat/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/ncr/rangercombat/eliteriot
	name = "elite riot gear helmet"
	desc = "An old combat helmet seen in the divide, repurposed for higher ranking Rangers."
	icon_state = "elite_riot"
	item_state = "elite_riot"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/eliteriotweak
	name = "worn elite riot gear helmet"
	desc = "An old combat helmet seen in the divide, repurposed for higher ranking Rangers. This one seems aged..."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	armor_tokens = list(ARMOR_MODIFIER_DOWN_BULLET_T1, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_DOWN_FIRE_T3, ARMOR_MODIFIER_DOWN_DT_T1)

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert
	name = "desert ranger combat helmet"
	desc = "An U.S Marine Corps helmet, used by the legendary Desert Rangers."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert/whiskey
	name = "weathered ranger helmet"
	desc = "A well-used desert ranger helmet passed down through generations. Though this one's stripped of night vision and it's kevlar lining, it's even more lightweight."
	lighting_alpha = null
	darkness_view = null
	flash_protect = 0
	resistance_flags = null


/obj/item/clothing/head/helmet/f13/rangercombat/eliteriot/reclaimed
	name = "reclaimed desert ranger gear"
	desc = "A refurbished and personalized set of pre-unification desert ranger gear."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

//Brotherhood of Steel (PA in f13head.dm)

/obj/item/clothing/head/helmet/f13/combat/brotherhood
	name = "brotherhood helmet"
	desc = "An improved combat helmet, bearing the symbol of the Knights."
	icon_state = "brotherhood_helmet_knight"
	item_state = "brotherhood_helmet_knight"


/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior
	name = "brotherhood senior knight helmet"
	desc = "An improved combat helmet, bearing the symbol of a Senior Knight."
	icon_state = "brotherhood_helmet_senior"
	item_state = "brotherhood_helmet_senior"

/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain
	name = "brotherhood head knight helmet"
	desc = "An improved combat helmet, bearing the symbol of the Head Knight."
	icon_state = "brotherhood_helmet_captain"
	item_state = "brotherhood_helmet_captain"

/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate
	name = "initiate helmet"
	desc = "An old degraded Pre-Fall combat helmet, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_helmet"
	item_state = "brotherhood_helmet"

/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate/mk2
	name = "reinforced knight helmet"
	desc = "An advanced Pre-Fall titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_helmet"
	item_state = "brotherhood_helmet"

/obj/item/clothing/head/helmet/f13/combat/brotherhood/outcast
	name = "brotherhood helmet"
	desc = " An improved combat helmet, bearing a series of red markings."
	icon_state = "brotherhood_helmet_outcast"
	item_state = "brotherhood_helmet_outcast"

/obj/item/clothing/head/f13/boscap
	name = "brotherhood formal cap"
	desc = "A cap typically worn with the formal uniform for the local Brotherhood of Steel Chapter."
	icon_state = "boscap"
	item_state = "boscap"
	strip_delay = 20

/obj/item/clothing/head/f13/boscap/beret
	name = "brotherhood beret"
	desc = "A beret typically worn with the standard fatigues of the local Brotherhood of Steel Chapter."
	icon_state = "bos_beret"
	item_state = "bos_beret"

//Oasis/Town

/obj/item/clothing/head/f13/town
	name = "town tricorn"
	desc = "Why are there tricorns in the desert again?"
	icon_state = "tricorn"
	item_state = "dethat"
	flags_inv = HIDEHAIR

/obj/item/clothing/head/f13/town/mayor
	name = "mayoral tricorn"
	desc = "A tricorn in the desert.  Stranger things have happened."

/obj/item/clothing/head/f13/town/big
	name = "big hat"
	desc = "It's a big hat."
	icon_state = "bigcowboyhat"

/obj/item/clothing/head/f13/town/deputy
	name = "deputy hat"
	desc = "A black cowboy hat."
	icon_state = "deputyhat"

/obj/item/clothing/head/f13/town/deputy/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/town/officer
	name = "New Boston officer's cap"
	desc = "A simple dark navy peaked cap, worn by police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_officer"
	item_state = "police_officer"

/* /obj/item/clothing/head/f13/town/officer/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/town/sheriff
	name = "sheriff hat"
	desc = "A black cowboy hat with a snakeskin band."
	icon_state = "sheriffhat"

/* /obj/item/clothing/head/f13/town/sheriff/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/town/chief
	name = "NPD Chief's hat"
	desc = "A blue hat with a silver badge."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_chief"
	item_state = "police_chief"

/* /obj/item/clothing/head/f13/town/chief/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/f13/det_hat_alt
	name = "detective's fedora"
	desc = "There's only one man who can sniff out the dirty stench of crime, and he's likely wearing this black hat."
	icon_state = "detectivealt"
	item_state = "fedora"
	flags_inv = HIDEHAIR


////////////////////////
// GREAT KHAN HELMETS //
////////////////////////

/obj/item/clothing/head/helmet/f13/khan
	name = "horned helmet"
	desc = "A piece of headwear commonly worn by the horned tribals that appears to resemble stereotypical traditional Mongolian helmets - likely adapted from a Pre-Fall motorcycle helmet.<br>It is black with two horns on either side and a small spike jutting from the top, much like a pickelhaube.<br>A leather covering protects the wearer's neck and ears from sunburn."
	icon = 'icons/fallout/clothing/khans.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/khaans.dmi'
	icon_state = "khan_helmet"
	item_state = "khan_helmet"
	flags_inv = null
	flags_cover = null
	strip_delay = 20
	dynamic_hair_suffix = "+generic"
	dynamic_fhair_suffix = null

/* /obj/item/clothing/head/helmet/f13/khan/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */

/obj/item/clothing/head/helmet/f13/khan/pelt
	desc = "A helmet with traditional horns, but wasteland-chique fur trimming instead of the classic leather cover. For the horned tribals who wants to show off their hair."
	icon_state = "khan_helmetpelt"
	item_state = "khan_helmetpelt"

/* /obj/item/clothing/head/helmet/f13/khan/pelt/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */

/obj/item/clothing/head/helmet/f13/khan/bandana
	name = "outlaw bandana"
	desc = "A bandana. Tougher than it looks. One side of the cloth is dark, the other red, so it can be reversed."
	icon_state = "khan_bandana"
	item_state = "khan_bandana"
	strip_delay = 10
	dynamic_hair_suffix = null
	dynamic_fhair_suffix = null
	var/helmettoggled = FALSE

/* /obj/item/clothing/head/helmet/f13/khan/bandana/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/f13/khan/bandana/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	helmet_toggle(user)
	return TRUE

/obj/item/clothing/head/helmet/f13/khan/bandana/ui_action_click()
	helmet_toggle()

/obj/item/clothing/head/helmet/f13/khan/bandana/proc/helmet_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You turn the [src] inside out."))
	if(src.helmettoggled)
		src.icon_state = "[initial(icon_state)]"
		src.item_state = "[initial(icon_state)]"
		src.helmettoggled = FALSE
	else if(!src.helmettoggled)
		src.icon_state = "[initial(icon_state)]_t"
		src.item_state = "[initial(icon_state)]_t"
		src.helmettoggled = TRUE
	usr.update_inv_head()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/head/helmet/f13/khan/fullhelm
	name = "Great Khan full helmet"
	desc = " A Khan helmet modified with steel horns and a full guard comprised of red sunglass lenses and a thick metal plate to conceal the lower face."
	icon_state = "khan_fullhelmet"
	item_state = "khan_fullhelmet"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES 
	strip_delay = 20

/* /obj/item/clothing/head/helmet/f13/khan/fullhelm/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)
 */
/obj/item/clothing/head/helmet/infiltrator
	name = "infiltrator helmet"
	desc = "An insidious armored combat helmet with a red and black color scheme."
	icon_state = "infiltrator"
	item_state = "infiltrator"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	mutantrace_variation = STYLE_MUZZLE
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1)
	
/obj/item/clothing/head/helmet/infiltrator/contractor
	name = "contractor helmet"
	desc = "An insidious armored combat helmet with a orange and black color scheme."
	icon_state = "syndicate-contract-helm"
	item_state = "syndicate-contract-helm"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES
	mutantrace_variation = STYLE_MUZZLE
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T2, ARMOR_MODIFIER_DOWN_LASER_T2, ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/head/helmet/infiltrator/contractor/CtrlShiftClick(mob/user)
	var/static/list/choices = list(
			"Black" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black"),
			"Green Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-green"),
			"Orange Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-orange"),
			"Blue Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-blue"),
			"Red Stripe" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-red"),
			"Medic Marks" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-med"),
			"Engi Marks" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-helm-black-engie"),
			"Contractor" = image(icon = 'icons/mob/clothing/head.dmi', icon_state = "syndicate-contract-helm"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 32, require_near = TRUE)
	switch(choice)
		if("Black")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black"
			item_state = "syndicate-helm-black"
		if("Green Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-green"
			item_state = "syndicate-helm-black-green"
		if("Orange Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-orange"
			item_state = "syndicate-helm-black-orange"
		if("Blue Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-blue"
			item_state = "syndicate-helm-black-blue"
		if("Red Stripe")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-red"
			item_state = "syndicate-helm-black-red"
		if("Medic Marks")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-med"
			item_state = "syndicate-helm-black-med"
		if("Engi Marks")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-helm-black-engie"
			item_state = "syndicate-helm-black-engie"
		if("Contractor")
			balloon_alert(user, "Your suit changes color.")
			icon_state = "syndicate-contract-helm"
			item_state = "syndicate-contract-helm"
		else
			return
//Wayfarer
//Wayfarer
/obj/item/clothing/head/helmet/f13/deathskull
	name = "eerie helm"
	desc = "A helmet fastened from the skull of a deer. Something about it doesn't look right."
	icon_state = "shamskull"
	item_state = "shamskull"

/obj/item/clothing/head/f13/helmet/wayfarer

/obj/item/clothing/head/helmet/f13/wayfarer/hunter
	name = "hunter headdress"
	desc = "Azure decorations dangle from the sturdy cap, it is sung that the wearers of these are watched over by the spirits."
	icon_state = "hunterhelm"
	item_state = "hunterhelm"

/obj/item/clothing/head/helmet/f13/wayfarer/antler
	name = "antler skullcap"
	desc = "An antler skull headdress traditionally worn by the spiritually inclined."
	icon_state = "antlerhelm"
	item_state = "antlerhelm"


/obj/item/clothing/head/helmet/f13/wayfarer/shamanblue
	name = "ritual headdress"
	desc = "An ancient mask fashioned at the coasts of the Great Salt Water, imbued with the ancestral blessing through a long forgotten ritual."
	icon_state = "shamanblue"
	item_state = "shamanblue"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/wayfarer/shamanred
	name = "crimson mask"
	desc = "An uncanny helm passed down through generations, originating from a tribal culture once situated at the top of a Sonoran mesa."
	icon_state = "shamanred"
	item_state = "shamanred"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/wayfarer/chief
	name = "helm of the steady walk"
	desc = "A chief who chooses this protectron mantle embodies the defensive, a stalwart heart that protects their village above all other goals, even if it means hampering the growth of the village to do it."
	icon_state = "chiefblue"
	item_state = "chiefblue"
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/combat/tribal
	name = "tribalized combat helmet"
	desc = "An old military grade Pre-Fall combat helmet, repainted and re-purposed with bones and sinew."
	icon_state = "tribe_helmet"
	item_state = "tribe_helmet"

/obj/item/clothing/head/helmet/f13/combat/mk2/tribal
	name = "tribalized reinforced helmet"
	desc = "An old military grade Pre-Fall reinforced combat helmet, repainted and re-purposed with bones and sinew."
	icon_state = "tribe_helmet"
	item_state = "tribe_helmet"
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/wayfarer/chief/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/head/helmet/f13/wayfarer/chief/red
	name = "helm of the piercing gaze"
	desc = "A chief who wears this assaultron helm is known for their prowess in battle, aggressiveness, intimidation and raw power in command. They are bold and strong."
	icon_state = "chiefred"
	item_state = "chiefred"

/obj/item/clothing/head/helmet/f13/wayfarer/chief/green
	name = "helm of the helping hand"
	desc = "The many eyed helper to the village and all, the Chief that chooses this Mr. Handy based mantle is clever and kind in equal measure, they embody industry and diplomacy. Though they aren't defensive, they are surgically precise in eliminating those who oppose them."
	icon_state = "chiefgreen"
	item_state = "chiefgreen"

//Followers

//Vault

/obj/item/clothing/head/helmet/riot/vaultsec
	name = "security helmet"
	desc = "A standard issue vault security helmet, pretty robust."
	slowdown = 0.01


/obj/item/clothing/head/helmet/riot/vaultsec/vc
	name = "vtcc riot helmet"
	desc = "A riot helmet adapted from the design of most Pre-Fall riot helmets, painted blue."
	icon_state = "vtcc_riot_helmet"
	item_state = "vtcc_riot_helmet"

//Old World Militaries
//US Army and PLA

/obj/item/clothing/head/f13/army
	name = "US Army field cap"
	desc = "Standard issue US Army field cap."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_cap"
	item_state = "army_cap"
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/head/f13/army/officer
	name = "US Army officer's cap"
	desc = "US Army officer's cap."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_officer"
	item_state = "army_officer"


/obj/item/clothing/head/f13/army/general
	name = "US Army general's cap"
	desc = "US Army officer's cap."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_general"
	item_state = "army_general"

/obj/item/clothing/head/f13/army/beret
	name = "US Army beret"
	desc = "A black beret, standard issue for all US Army personnel not authorised to wear a different beret."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_beret"
	item_state = "army_beret"

/obj/item/clothing/head/f13/army/beret/airborne
	name = "US Army airborne beret"
	desc = "A red beret, issued to US Army Airborne personnel."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_beret_airborne"
	item_state = "army_beret_airborne"

/obj/item/clothing/head/f13/army/beret/rangers
	name = "US Army rangers beret"
	desc = "A tan beret, issued to US Army Rangers."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_beret_ranger"
	item_state = "army_beret_ranger"

/obj/item/clothing/head/f13/army/beret/specialforces
	name = "US Army special forces beret"
	desc = "A green beret, issued to US Army Special Forces personnel."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "army_beret_specialforces"
	item_state = "army_beret_specialforces"

//People's Liberation Army

/obj/item/clothing/head/f13/chinese
	name = "PLA field cap"
	desc = "A People's Liberation Army cap, worn by enlisted and non-commissioned officers."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "chinese_soldier"
	item_state = "chinese_soldier"

/obj/item/clothing/head/f13/chinese/officer
	name = "PLA officer's cap"
	desc = "A People's Liberation Army peaked cap, worn by officers."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "chinese_officer"
	item_state = "chinese_officer"

//Old World Law Enforcement
//Police and State Police

/obj/item/clothing/head/f13/police/officer
	name = "police officer's cap"
	desc = "A simple dark navy peaked cap, worn by police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_officer"
	item_state = "police_officer"

/obj/item/clothing/head/f13/police/sergeant
	name = "police campaign hat"
	desc = "A simple dark navy campaign hat, worn by police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_sergeant"
	item_state = "police_sergeant"

/obj/item/clothing/head/f13/police/lieutenant
	name = "police lieutenant's cap"
	desc = "A simple dark navy peaked cap, worn by police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_lieutenant"
	item_state = "police_lieutenant"

/obj/item/clothing/head/f13/police/chief
	name = "police chief's cap"
	desc = "A simple dark navy peaked cap, worn by police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "police_chief"
	item_state = "police_chief"

/obj/item/clothing/head/f13/police/trooper
	name = "state police campaign hat"
	desc = "A gray campaign hat, worn by the State Police."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "state_trooper"
	item_state = "state_trooper"

// Unaligned Tribal
/obj/item/clothing/head/helmet/f13/skull_helmet
	name = "skull mask"
	desc = "A tribal skull-mask adorned with decorative feathers and... are those real antler-horns? <span class='bold'>Ctrl + Shift to customise!</span>"
	icon_state = "skullmask1"
	item_state = "skullmask1"
	flags_inv = HIDEEARS|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	var/is_hair_hidden = FALSE
	pocket_storage_component_path = null

/obj/item/clothing/head/helmet/f13/skull_helmet/CtrlShiftClick(mob/user)
	var/static/list/choices = list(
			"Skull_Antler" = image(icon = 'icons/obj/clothing/hats.dmi', icon_state = "skullmask1"),
			"Skull_Redfeather" = image(icon = 'icons/obj/clothing/hats.dmi', icon_state = "skullmask2"),
			"Skull_Bluefeather" = image(icon = 'icons/obj/clothing/hats.dmi', icon_state = "skullmask3"),
			"Safe" = image(icon = 'icons/radials/radial_buttons.dmi', icon_state = "safe"),
			"Danger" = image(icon = 'icons/radials/radial_buttons.dmi', icon_state = "danger"),
		)
	var/choice = show_radial_menu(user, src, choices, radius = 32, require_near = TRUE)
	switch(choice)
		if("Skull_Antler")
			icon_state = "skullmask1"
			balloon_alert(user, "Switched to Default")
		if("Skull_Redfeather")
			icon_state = "skullmask2"
			balloon_alert(user, "Switched to Redfeather")
		if("Skull_Bluefeather")
			icon_state = "skullmask3"
			balloon_alert(user, "Switched to Bluefeather")
		if("Safe")
			flags_inv -= HIDEFACE
			balloon_alert(user, "Revealing Identity!")
		if("Danger")
			flags_inv += HIDEFACE
			balloon_alert(user, "Concealing Identity!")
		else
			return

//THE GRAVEYARD
//UNUSED or LEGACY - RETAINED IN CASE DESIRED FOR ADMIN SPAWN OR REIMPLEMENATION. MAY NOT BE EVERYTHING THAT'S UNUSED. TEST BEFORE USING
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

//NCR

/obj/item/clothing/head/helmet/f13/combat/ncr
	name = "NCR combat helmet"
	desc = "An old military grade Pre-Fall combat helmet, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_helmet"
	item_state = "ncr_helmet"

/obj/item/clothing/head/helmet/f13/combat/mk2/ncr
	name = "reinforced NCR combat helmet"
	desc = "An advanced Pre-Fall titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_helmet_mk2"
	item_state = "ncr_helmet_mk2"

/obj/item/clothing/head/beret/ncr/ncr_recon
	name = "NCR First Recon beret"
	desc = "A red beret, issued to members of NCR First Recon."
	icon_state = "ncr_recon_beret"
	item_state = "ncr_recon_beret"

/obj/item/clothing/head/beret/ncr/ncr_recon/worn
	name = "Worn NCR First Recon beret"
	desc = "A red beret, issued to members of NCR First Recon. This one is worn, having been kept when a soldier was transfered from the unit."
	icon_state = "ncr_recon_beret"
	item_state = "ncr_recon_beret"

/obj/item/clothing/head/beret/ncr/ncr_scout
	name = "NCR Third Scout beret"
	desc = "A brown beret, issued to members of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"

/obj/item/clothing/head/beret/ncr/ncr_scout_lt
	name = "NCR Third Scout officer beret"
	desc = "A brown beret, issued to officers of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"

/obj/item/clothing/head/f13/ncr/medic
	name = "NCR medical helmet"
	desc = "A standard issue NCR Infantry helmet, colored to suit a medical officer."
	icon_state = "ncr_medical_helmet"
	item_state = "ncr_medical_helmet"

/obj/item/clothing/head/f13/ncr/mp
	name = "NCR military police helmet"
	desc = "A standard issue NCR helmet, with the letters \"MP\" scrawled on the front."
	icon_state = "ncr_MP"
	item_state = "ncr_MP"

/obj/item/clothing/head/f13/ncr/goggles
	name = "NCR storm helmet"
	desc = "A standard issue NCR Infantry helmet, with a pair of goggles attached to it."
	icon_state = "ncr_goggles_helmet"
	item_state = "ncr_goggles_helmet"
	toggle_message = "You pull the goggles down under "
	alt_toggle_message = "You push the goggles up onto the "
	can_toggle = 1
	flags_inv = HIDEEARS
	actions_types = list(/datum/action/item_action/toggle)
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES
	visor_flags_cover = HEADCOVERSEYES
	dog_fashion = null


/obj/item/clothing/head/f13/ncr/goggles/attack_self(mob/user)
	if(can_toggle && !user.incapacitated())
		if(world.time > cooldown + toggle_cooldown)
			cooldown = world.time
			up = !up
			flags_1 ^= visor_flags
			flags_inv ^= visor_flags_inv
			flags_cover ^= visor_flags_cover
			icon_state = "[initial(icon_state)][up ? "up" : ""]"
			to_chat(user, "[up ? alt_toggle_message : toggle_message] \the [src]")

			user.update_inv_head()
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.head_update(src, forced = 1)

			if(active_sound)
				while(up)
					playsound(src.loc, "[active_sound]", 100, 0, 4)
					sleep(15)

//Legion

/obj/item/clothing/head/helmet/f13/combat/legion
	name = "Larper combat helmet"
	desc = "An old military grade Pre-Fall helmet, repainted to the colour scheme of Lil Caesar's Pizza Legion."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "legion-combat"
	item_state = "legion-combat"

/obj/item/clothing/head/helmet/f13/combat/mk2/legion
	name = "reinforced Legion combat helmet"
	desc = "A Pre-Fall helmet in good condition, made from advanced materialas and paintend in the colors of Caesar's Legion."
	icon = 'icons/fallout/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothes/head.dmi'
	icon_state = "legion-combat2"
	item_state = "legion-combat2"


//Enclave / Remnant

/obj/item/clothing/head/helmet/f13/helmet/enclave/forgecap
	name = "enclave forge cap"
	desc = "A resistant, black forage cap issued to Enclave Officers."
	icon_state = "enclave_cap"
	item_state = "enclave_cap"

/obj/item/clothing/head/helmet/f13/combat/enclave
	name = "enclave combat helmet"
	desc = "An intimidating helmet that is issued with it's corresponding suit."
	icon_state = "enclave_new"
	item_state = "enclave_new"
