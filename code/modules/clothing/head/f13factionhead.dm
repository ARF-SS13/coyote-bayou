/*PARENT ITEMS FOR REFERENCE PURPOSES. DO NOT UNCOMMENT
/obj/item/clothing/head
	name = BODY_ZONE_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "top_hat"
	item_state = "that"
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_HEAD
	var/blockTracking = 0 //For AI tracking
	var/can_toggle = null
	dynamic_hair_suffix = "+generic"
	var/datum/beepsky_fashion/beepsky_fashion //the associated datum for applying this to a secbot
	var/list/speechspan = null
	armor = list("tier" = 1)

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
	armor = list("tier" = 4, "energy" = 10, "bomb" = 25, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)
	flags_inv = HIDEEARS
	cold_protection = HEAD
	min_cold_protection_temperature = HELMET_MIN_TEMP_PROTECT
	heat_protection = HEAD
	max_heat_protection_temperature = HELMET_MAX_TEMP_PROTECT
	strip_delay = 60
	resistance_flags = NONE
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEHAIR

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
	armor = list("tier" = 4, "energy" = 25, "bomb" = 30, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/raider/supafly
	name = "supa-fly raider helmet"
	desc = "(IV) It's a makeshift raider helmet, made of leather. It heavily smells with chems and sweat."
	icon_state = "supafly"
	item_state = "supafly"

/obj/item/clothing/head/helmet/f13/raider/supafly/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/wastehound
	name = "wastehound raider helmet"
	desc = "(IV) A sack hood made out of a suspicious leather with tufts of hair sticking out. This mask would make Leatherface proud."
	icon_state = "wastehound_hood_icon"
	item_state = "raider_wastehound_hood"
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE

/obj/item/clothing/head/helmet/f13/raider/wastehound/Initialize() //HQ parts reinforcement
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/arclight
	name = "arclight raider helmet"
	desc = "(IV) An intimidating visor, however its eye protection qualities are compromised."
	icon_state = "arclight"
	item_state = "arclight"
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE

/obj/item/clothing/head/helmet/f13/raider/arclight/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/blastmaster
	name = "blastmaster raider helmet"
	desc = "(IV) A sturdy helmet to protect against both the elements and from harm, if only it was not looking in such poor condition."
	icon_state = "blastmaster"
	item_state = "blastmaster"
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/raider/blastmaster/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/yankee
	name = "yankee raider helmet"
	desc = "(IV) Long time ago, it has belonged to a football player, now it belongs to wasteland."
	icon_state = "yankee"
	item_state = "yankee"
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE

/obj/item/clothing/head/helmet/f13/raider/yankee/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/eyebot
	name = "eyebot helmet"
	desc = "(IV) It is a dismantled eyebot, hollowed out to accommodate for a humanoid head."
	icon_state = "eyebot"
	item_state = "eyebot"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	strip_delay = 50
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/raider/eyebot/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/raider/psychotic
	name = "psycho-tic raider helmet"
	desc = "(IV) A leather skullcap with tufts of hair sticking from each side."
	icon_state = "psychotic"
	item_state = "psychotic"
	flags_cover = HEADCOVERSEYES
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR

/obj/item/clothing/head/helmet/f13/raider/psychotic/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/helmet/f13/fiend
	name = "fiend helmet"
	desc = "(IV) A leather cap cobbled together adorned with a bighorner skull, perfect for any drug-fueled frenzy."
	icon_state = "fiend"
	item_state = "fiend"
	armor = list("tier" = 4, "energy" = 10, "bomb" = 16, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/fiend_reinforced
	name = "reinforced fiend helmet"
	desc = "(V) A leather cap cobbled together adorned with a bighorner skull, perfect for any drug-fueled frenzy. This helmet has been reinforced with metal plates under its skull"
	icon_state = "fiend"
	item_state = "fiend"
	armor = list("tier" = 5, "laser" = 20, "energy" = 10, "bomb" = 16, "bio" = 20, "rad" = 0, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR

/obj/item/clothing/head/helmet/f13/raidermetal
	name = "metal raider helmet"
	desc = "(V) A metal helmet, rusty and awful."
	icon_state = "raidermetal"
	item_state = "raidermetal"
	can_toggle = TRUE
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 30, "fire" = 20, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEYES|HIDEFACE
	strip_delay = 80
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

/obj/item/clothing/head/helmet/f13/raidercombathelmet
	name = "combat raider helmet"
	desc = "(V) A combat helmet modified with metal plating"
	icon_state = "raider_combat_helmet"
	item_state = "raider_combat_helmet"
	armor = list("tier" = 5, "energy" = 35, "bomb" = 70, "bio" = 70, "rad" = 70, "fire" = 65, "acid" = 30)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR


//Enclave

/obj/item/clothing/head/helmet/f13/helmet/enclave/science
	name = "science beret"
	desc = "(I) Blue beret signifying the wearer is a Science Officer of the Enclave."
	icon_state = "hat_enclave_science"
	item_state = "hat_enclave_science"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = null
	armor = list("tier" = 1)

/obj/item/clothing/head/helmet/f13/helmet/enclave/intel
	name = "intel beret"
	desc = "(III) Dark beret issued to Intelligence Officers of the Enclave."
	icon_state = "hat_enclave_intel"
	item_state = "hat_enclave_intel"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = null
	armor = list("tier" = 3)

/obj/item/clothing/head/helmet/f13/helmet/enclave/peacekeeper
	name = "peacekeeper cap"
	desc = "(IV) Reinforced field cap issued to the soldiers of the Enclave."
	icon_state = "hat_enclave_peacekeeper"
	item_state = "hat_enclave_peacekeeper"
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	armor = list("tier" = 4)

/obj/item/clothing/head/helmet/f13/helmet/enclave/officer
	name = "enclave officer hat"
	desc = "(VII) Wheeled hat with a cap made of light-weight alloys beneath."
	icon_state = "hat_enclave_officer"
	item_state = "hat_enclave_officer"
	armor = list("tier" = 7, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30) // On par with BoS Knight

//////////
//LEGION//
//////////


/obj/item/clothing/head/helmet/f13/legion
	name = "legion helmet template"
	desc = "should not exist."
	icon = 'icons/fallout/objects/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/head.dmi'
	lefthand_file = ""
	righthand_file = ""
	armor = list("tier" = 3, "energy" = 10, "bomb" = 16, "bio" = 30, "rad" = 20, "fire" = 50, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 50
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""

/obj/item/clothing/head/helmet/f13/legion/marsheaddress
	name = "priestess' headdress"
	desc = "(III) A headdress made of feathers and decorated with two golden tassles."
	icon_state = "legion-priestess"
	item_state = "legion-priestess"
	dynamic_hair_suffix = "+generic"

/obj/item/clothing/head/helmet/f13/legion/recruit
	name = "legion recruit helmet"
	desc = "(III) It's a leather skullcap issued to recruits."
	icon_state = "legion-recruit"
	item_state = "legion-recruit"

/obj/item/clothing/head/helmet/f13/legion/prime
	name = "legion prime helmet"
	desc = "(IV) A helmet from reinforced leather witha red peak."
	item_state = "legion-prime"
	icon_state = "legion-prime"
	armor = list("tier" = 4, "energy" = 15, "bomb" = 25, "bio" = 40, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/prime/slavemaster
	name = "slave master helmet"
	desc = "(IV) The unique helmet used by the disciplinary corps of the Legion."
	icon_state = "legion-slavemaster"
	item_state = "legion-slavemaster"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR
	flags_cover = HEADCOVERSEYES
	dog_fashion = null

/obj/item/clothing/head/helmet/f13/legion/vet
	name = "legion veteran helmet"
	desc = "(V) It's a metal legion veteran helmet, clearly inspired by old world sports uniforms."
	icon_state = "legion-veteran"
	item_state = "legion-veteran"
	armor = list("tier" = 5, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/vet/explorer
	name = "legion explorer hood"
	desc = "(V) It's a leather hood with metal reinforcments and built in headphones to plug the radio into."
	icon_state = "legion-explorer"
	item_state = "legion-explorer"

/obj/item/clothing/head/helmet/f13/legion/vet/combvexil
	name = "legion bear vexillarius helmet"
	desc = "(V) This helmet is decorated with the pelt of a ashland bear."
	icon_state = "legion-vex"
	item_state = "legion-vex"

/obj/item/clothing/head/helmet/f13/legion/vet/vexil
	name = "legion fox vexillarius helmet"
	desc = "(V) This helmet is decorated with the pelt of a desert fox."
	icon_state = "legion-vex-alt"
	item_state = "legion-vex-alt"

/obj/item/clothing/head/helmet/f13/legion/venator
	name = "legion venator hood"
	desc = "(VI) A leather hood with a sturdy metal skullcap and a gold bull insignia in the front."
	icon_state = "legion-venator"
	item_state = "legion-venator"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/recruit/decan
	name = "legion recruit decanus helmet"
	desc = "(VI) This reinforced leather helmet has a plume of black and dark red feathers."
	icon_state = "legion-decrec"
	item_state = "legion-decrec"
	armor = list("tier" = 5, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/prime/decan
	name = "legion prime decanus helmet"
	desc = "(VI) This reinforced leather helmet with a red peak has a plume of black feathers."
	item_state = "legion-decprime"
	icon_state = "legion-decprime"
	armor = list("tier" = 5, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/heavy
	name = "reinforced legion veteran decanus helmet"
	desc = "(VI) A metal helmet with ballistic visor and a plume, denoting veteran Decanus status."
	icon_state = "legion-decvet"
	item_state = "legion-decvet"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 60, "rad" = 20, "fire" = 75, "acid" = 10)
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/helmet/f13/legion/heavy/attack_self(mob/user)
	weldingvisortoggle(user)
	icon_state = "legion-decvetup"
	item_state = "legion-decvetup"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/vet/decan
	name = "legion veteran decanus helmet"
	desc = "(VI) It's a metal helmet with an array of red, white and black feathers, unmistakably a Veteran Decanus."
	icon_state = "legion-decvet-alt"
	item_state = "legion-decvet-alt"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/centurion
	name = "legion centurion helmet"
	desc = "(VI) A sturdy helmet from steel and brass with a red horizontal plume."
	icon_state = "legion-centurion"
	item_state = "legion-centurion"
	armor = list("tier" = 6, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/item/clothing/head/helmet/f13/legion/rangercent
	name = "ranger-hunter centurion helmet"
	desc = "(V) The helmet of an NCR ranger, refit to serve as a Centurions helmet."
	icon_state = "legion-rangercent"
	item_state = "legion-rangercent"
	armor = list("tier" = 5, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/item/clothing/head/helmet/f13/legion/palacent
	name = "paladin-slayer centurion helmet"
	desc = "(VII) The once-marvelous helmet of the T-45d power armor set, repurposed by the Legion into a symbol of its might. It has a large plume of red horse hair across the top of it going horizontally, donoting the rank of Centurion."
	icon_state = "legion-palacent"
	item_state = "legion-palacent"
	armor = list("tier" = 6, "energy" = 35, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/item/clothing/head/helmet/f13/legion/legate
	name = "legion legate helmet"
	desc = "(VIII) A custom forged steel full helmet complete with abstract points and arches. The face is extremely intimidating, as it was meant to be. This particular one was ordered to be forged by Caesar, given to his second legate in exchange for his undying loyalty to Caesar."
	icon_state = "legion-legate"
	item_state = "legion-legate"
	armor = list("tier" = 8, "energy" = 40, "bomb" = 45, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEHAIR
	resistance_flags = LAVA_PROOF | FIRE_PROOF


/obj/item/clothing/head/f13/legion/servant
	name = "servant headwear"
	desc = "A simple uncoloured linen cloth wrapped around the head, the mark of a servant slave trained in household work."
	icon = 'icons/fallout/objects/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/head.dmi'
	icon_state = "legion-servant"
	item_state = "legion-servant"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = null

/obj/item/clothing/head/f13/legion/auxilia
	name = "auxilia headwear"
	desc = "A soft red cap with a black band, used by female Auxilia outside camp."
	icon = 'icons/fallout/objects/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/head.dmi'
	icon_state = "legion-aux"
	item_state = "legion-aux"
	flags_inv = HIDEEARS|HIDEFACE
	flags_cover = null

/obj/item/clothing/head/helmet/f13/combat/legion
	name = "Legion combat helmet"
	desc = "(V) An old military grade pre-war helmet, repainted to the colour scheme of Caesar's Legion."
	icon = 'icons/fallout/objects/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/head.dmi'
	icon_state = "legion-combat"
	item_state = "legion-combat"

/obj/item/clothing/head/helmet/f13/combat/mk2/legion
	name = "reinforced Legion combat helmet"
	desc = "(VI) A pre-war helmet in good condition, made from advanced materialas and paintend in the colors of Caesar's Legion."
	icon = 'icons/fallout/objects/clothing/hats.dmi'
	mob_overlay_icon = 'icons/fallout/onmob/clothing/head.dmi'
	icon_state = "legion-combat2"
	item_state = "legion-combat2"

/*
/obj/item/clothing/head/helmet/f13/legion/recruit/scout
	name = "legion scout hood"
	desc = "(III) It's a leather hood worn by legion scouts."
	icon_state = "legscout"
	item_state = "legscout"

/obj/item/clothing/head/helmet/f13/legion/libritor
	name = "legion libritor helmet"
	desc = "(VII) A metal legion veteran helmet with an inverted color scheme for libritors"
	icon_state = "legheavy"
	item_state = "legheavy"
	armor = list("tier" = 7, "energy" = 15, "bomb" = 25, "bio" = 50, "rad" = 20, "fire" = 70, "acid" = 0)

/obj/item/clothing/head/helmet/f13/legion/palacent/custom_excess
	name = "Champion of Kanab's Helm"
	desc = "(VII) A custom forged steel full helmet made for the Conqueror and Champion of Kanab. It has a large plume of red horse hair across the top of it going horizontally, symbolizing the position of a Centurion."
	icon_state = "palacent_excess"
	item_state = "palacent_excess"
*/


//NCR

/obj/item/clothing/head/f13/ncr
	name = "NCR trooper helmet"
	desc = "(III) A standard issue NCR steel helmet. Looks like you can write on it and strap a few items on the helmet band."
	icon_state = "ncr_steelpot"
	item_state = "ncr_steelpot"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 50
	obj_flags = UNIQUE_RENAME
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/tiny

/obj/item/clothing/head/f13/ncr/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

/obj/item/clothing/head/f13/ncr/steelpot_goggles
	name = "NCR storm helmet"
	desc = "(III) A standard issue NCR steel helmet, issued with an additional pair of storm goggles for weather resistance."
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

/obj/item/clothing/head/f13/ncr/steelpot_med
	name = "NCR medic helmet"
	desc = "(III) A standard issue NCR steel helmet with the addition of decalling signifying a medic."
	icon_state = "steelpot_med"
	item_state = "steelpot_med"

/obj/item/clothing/head/f13/ncr/steelpot_mp
	name = "NCR military police helmet"
	desc = "(III) A standard issue NCR steel helmet emblazoned with the initials of the military police."
	icon_state = "steelpot_mp"
	item_state = "steelpot_mp"

/obj/item/clothing/head/f13/ncr/steelpot_gambler
	name = "NCR gambler helmet"
	desc = "(III) A standard issue NCR steel helmet. Stashed in the strap are decks of cards, dominoes and cigarettes for personal use."
	icon_state = "steelpot_gambler"
	item_state = "steelpot_gambler"

/obj/item/clothing/head/f13/ncr/steelpot_bandolier
	name = "NCR bandolier helmet"
	desc = "(III) A standard issue NCR steel helmet. This one has clearly seen heavy use, as well as having additional bullets tucked into the strap."
	icon_state = "steelpot_bandolier"
	item_state = "steelpot_bandolier"

/obj/item/clothing/head/f13/ncr_flapcap
	name = "NCR field cap"
	desc = "(III) A special issue canvas NCR field cap with cotton neckflap, for sun protection in arid climates."
	icon_state = "ncr_flapcap"
	item_state = "ncr_flapcap"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	icon_state = "ncr_flapcap"
	item_state = "ncr_flapcap"

/obj/item/clothing/head/f13/ncr_slouch
	name = "NCR slouch hat"
	desc = "(III) An irregular issue NCR sun hat, the left side of the brim is pinned to the crown for ease with shouldering rifles."
	icon_state = "ncr_slouch"
	item_state = "ncr_slouch"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr
	name = "NCR officer beret"
	desc = "(V) A green beret, standard issue for all commissioned NCR Officers."
	icon_state = "ncr_officer_beret"
	item_state = "ncr_officer_beret"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr/ncr_medic
	name = "NCR medical beret"
	desc = "(V) A white beret, issued to officers of the medical corps."
	icon_state = "ncr_medical_beret"
	item_state = "ncr_medical_beret"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_recon
	name = "NCR First Recon beret"
	desc = "(V) A red beret, issued to members of NCR First Recon."
	icon_state = "ncr_recon_beret"
	item_state = "ncr_recon_beret"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_recon/worn
	name = "Worn NCR First Recon beret"
	desc = "(IV) A red beret, issued to members of NCR First Recon. This one is worn, having been kept when a soldier was transfered from the unit."
	icon_state = "ncr_recon_beret"
	item_state = "ncr_recon_beret"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_scout
	name = "NCR Third Scout beret"
	desc = "(IV) A brown beret, issued to members of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_scout_lt
	name = "NCR Third Scout officer beret"
	desc = "(V) A brown beret, issued to officers of the NCR Third Scout Battallion."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_sapper
	name = "NCR Sapper beret"
	desc = "(V) A grey beret, issued to troopers that have passed Sapper School."
	icon_state = "ncr_sapper_beret"
	item_state = "ncr_sapper_beret"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_sof
	name = "NCR SOF beret"
	desc = "(IV) A tan beret, issued members of the New California Republic Special Operations Command."
	icon_state = "ncr_sof_beret"
	item_state = "ncr_sof_beret"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/f13/ncr_stetson
	name = "NCR air cavalry stetson"
	desc = "(IV) A black brahmin leather stetson, authorized for usage amongst all troopers assigned to Air Cavalry units."
	icon_state = "ncr_stetson"
	item_state = "ncr_stetson"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/f13/ncr_cap
	name = "NCR garrison cap"
	desc = "(II) A simple cloth garrison cap to be worn when a helmet isn't necessary."
	icon_state = "ncr_cap"
	item_state = "ncr_cap"
	armor = list("tier" = 2, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

/obj/item/clothing/head/f13/ncr_campaign
	name = "NCR campaign hat"
	desc = "(V) A khaki campaign hat, popularly used by senior NCOs in the NCRA."
	icon_state = "ncr_campaign"
	item_state = "ncr_campaign"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_dresscap
	name = "NCR peaked cap"
	desc = "(III) A tan peaked cap with silver pin, designated for enlisted NCRA personnel."
	icon_state = "ncr_dresscap"
	item_state = "ncr_dresscap"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/beret/ncr_codresscap
	name = "NCR peaked cap"
	desc = "(III) A tan peaked cap with golden pin, designated for commissioned NCRA personnel."
	icon_state = "ncr_codresscap"
	item_state = "ncr_codresscap"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

//NCR Ranger

/obj/item/clothing/head/beret/ncr_recon_ranger
	name = "NCR Ranger scout beret"
	desc = "(IV) A brown beret, issued to members of the NCR Recon Rangers."
	icon_state = "scoutberet"
	item_state = "scoutberet"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)

/obj/item/clothing/head/f13/trailranger
	name = "NCR trail ranger hat"
	desc = "(IV) A rustic, homely style cowboy hat worn by NCR trail rangers. Yeehaw!"
	icon_state = "cowboyrang"
	item_state = "cowboyrang"
	armor = list("tier" = 4, "energy" = 30, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/f13/ranger
	name = "NCR ranger campaign hat"
	desc = "(V) An NCR ranger hat, standard issue amongst all but the most elite rangers."
	icon_state = "drillhat"
	item_state = "drill_hat"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/helmet/f13/combat/ncr_patrol
	name = "NCR patrol helmet"
	desc = "(V) A combat helmet hand-manufactured in the NCR and issued to patrol rangers."
	icon_state = "ncr_patrol_helmet"
	item_state = "ncr_patrol_helmet"
	flags_inv = HIDEEARS|HIDEHAIR
	flags_cover = null

/obj/item/clothing/head/helmet/f13/combat/ncr
	name = "NCR combat helmet"
	desc = "(V) An old military grade pre-war combat helmet, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_helmet"
	item_state = "ncr_helmet"

/obj/item/clothing/head/helmet/f13/combat/mk2/ncr
	name = "reinforced NCR combat helmet"
	desc = "(VI) An advanced pre-war titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms, repainted to the colour scheme of the New California Republic."
	icon_state = "ncr_helmet"
	item_state = "ncr_helmet"

/obj/item/clothing/head/helmet/f13/ncr/rangercombat
	name = "ranger combat helmet"
	desc = "(VII) An old combat helmet, out of use around the time of the war."
	icon_state = "ranger"
	item_state = "ranger"
	armor = list("tier" = 7, "energy" = 50, "bomb" = 39, "bio" = 60, "rad" = 60, "fire" = 90, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	dynamic_hair_suffix = ""
	dynamic_fhair_suffix = ""
	flash_protect = 1
	glass_colour_type = /datum/client_colour/glass_colour/red
	lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	darkness_view = 24

/obj/item/clothing/head/helmet/f13/ncr/rangercombat/eliteriot
	name = "elite riot gear helmet"
	desc = "(VIII) An old combat helmet seen in the divide, repurposed for higher ranking Rangers."
	icon_state = "elite_riot"
	item_state = "elite_riot"
	armor = list("tier" = 8, "energy" = 60, "bomb" = 55, "bio" = 60, "rad" = 60, "fire" = 40, "acid" = 0)


/obj/item/clothing/head/helmet/f13/ncr/rangercombat/desert
	name = "desert ranger combat helmet"
	desc = "(VII) An U.S Marine Corps helmet, used by the legendary Desert Rangers."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"



/obj/item/clothing/head/helmet/f13/rangercombat/eliteriot/reclaimed
	name = "reclaimed desert ranger gear"
	desc = "(IV) A refurbished and personalized set of pre-unification desert ranger gear."
	icon_state = "desert_ranger"
	item_state = "desert_ranger"
	armor = list("tier" = 4, "energy" = 30, "bomb" = 30, "bio" = 30, "rad" = 30, "fire" = 30, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR|HIDEFACE
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH

//Brotherhood of Steel (PA in f13head.dm)

/obj/item/clothing/head/helmet/f13/combat/brotherhood
	name = "brotherhood helmet"
	desc = "(V) An improved combat helmet, bearing the symbol of the Knights."
	icon_state = "brotherhood_helmet_knight"
	item_state = "brotherhood_helmet_knight"
	armor = list("tier" = 5, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/f13/combat/brotherhood/senior
	name = "brotherhood senior knight helmet"
	desc = "(VI) An improved combat helmet, bearing the symbol of a Senior Knight."
	icon_state = "brotherhood_helmet_senior"
	item_state = "brotherhood_helmet_senior"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/f13/combat/brotherhood/captain
	name = "brotherhood head knight helmet"
	desc = "(VI) An improved combat helmet, bearing the symbol of the Head Knight."
	icon_state = "brotherhood_helmet_captain"
	item_state = "brotherhood_helmet_captain"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate
	name = "initiate helmet"
	desc = "(IV) An old degraded pre-war combat helmet, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_helmet"
	item_state = "brotherhood_helmet"
	armor = list("tier" = 4, "energy" = 40, "bomb" = 50, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/head/helmet/f13/combat/brotherhood/initiate/mk2
	name = "reinforced knight helmet"
	desc = "(VI) An advanced pre-war titanium plated, ceramic coated, kevlar, padded helmet designed to withstand extreme punishment of all forms, repainted to the colour scheme of the Brotherhood of Steel."
	icon_state = "brotherhood_helmet"
	item_state = "brotherhood_helmet"
	armor = list("tier" = 6, "energy" = 45, "bomb" = 55, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/helmet/f13/combat/brotherhood/outcast
	name = "brotherhood helmet"
	desc = "(V) An improved combat helmet, bearing a series of red markings."
	icon_state = "brotherhood_helmet_outcast"
	item_state = "brotherhood_helmet_outcast"
	armor = list("tier" = 5, "energy" = 45, "bomb" = 60, "bio" = 60, "rad" = 15, "fire" = 60, "acid" = 30)

/obj/item/clothing/head/f13/boscap
	name = "brotherhood formal cap"
	desc = "(I) A cap typically worn with the formal uniform for the local Brotherhood of Steel Chapter."
	icon_state = "boscap"
	item_state = "boscap"
	armor = list("tier" = 1, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0)
	strip_delay = 20

/obj/item/clothing/head/f13/boscap/beret
	name = "brotherhood beret"
	desc = "(I) A beret typically worn with the standard fatigues of the local Brotherhood of Steel Chapter."
	icon_state = "bos_beret"
	item_state = "bos_beret"

//Oasis/Town
/obj/item/clothing/head/f13/town/big
	name = "old hat"
	desc = "Worn by the first mayor of Oasis, who rallied the people around the one green oak left in the valley."
	icon_state = "bigcowboyhat"

/obj/item/clothing/head/f13/town/patrolmanhat
	name = "Patrolman's Hat"
	desc = "An Oasis Police Department hat, this one belongs to one of the patrolmen. It has an aura of duty."
	icon_state = "townpatrolhat"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 35, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/f13/town/townhelmet
	name = "OPD Helmet"
	desc = "An Oasis Police Department helmet, modified from a former Highway Patrol helmet."
	icon_state = "townhelmet"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 35, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/helmet/f13/town/townriot
	name = "OPD Riot Helmet"
	desc = "An Oasis Police Department riot helmet, this has saved the lives of OPD patrolmen for generations on."
	icon_state = "townriothelmet"
	item_state = "townriothelmet"
	armor = list("tier" = 6, "energy" = 15, "bomb" = 25, "bio" = 60, "rad" = 20, "fire" = 75, "acid" = 10)
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/f13/town/captainhat
	name = "Captain's Hat"
	desc = "An Oasis Police Department hat, this one belongs to the captain of the patrolmen. It has an aura of authority."
	icon_state = "towncaptainhat"
	armor = list("tier" = 6, "energy" = 40, "bomb" = 25, "bio" = 40, "rad" = 40, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/f13/det_hat_alt
	name = "detective's fedora"
	desc = "(III) There's only one man who can sniff out the dirty stench of crime, and he's likely wearing this black hat."
	icon_state = "detectivealt"
	item_state = "fedora"
	flags_inv = HIDEHAIR
	armor = list("tier" = 3, "energy" = 10, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)

//KHAAAAN
/obj/item/clothing/head/helmet/f13/khan
	name = "Great Khan helmet"
	desc = "(IV) A piece of headwear commonly worn by the Great Khans that appears to resemble stereotypical traditional Mongolian helmets - likely adapted from a pre-War motorcycle helmet.<br>It is black with two horns on either side and a small spike jutting from the top, much like a pickelhaube.<br>A leather covering protects the wearer's neck and ears from sunburn."
	icon_state = "khan"
	item_state = "khan"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEEARS|HIDEHAIR
	strip_delay = 20

/obj/item/clothing/head/helmet/f13/khan/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)


//Wayfarer
/obj/item/clothing/head/helmet/f13/deathskull
	name = "eerie helm"
	desc = "(IV) A helmet fastened from the skull of a deer. Something about it doesn't look right."
	icon_state = "shamskull"
	item_state = "shamskull"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 30, "bio" = 20, "rad" = 10, "fire" = 10, "acid" = 0)

/obj/item/clothing/head/f13/helmet/wayfarer

/obj/item/clothing/head/helmet/f13/wayfarer/hunter
	name = "hunter headdress"
	desc = "(V) Azure decorations dangle from the sturdy cap, it is sung that the wearers of these are watched over by the spirits."
	icon_state = "hunterhelm"
	item_state = "hunterhelm"
	armor = list("tier" = 5, "energy" = 20, "bomb" = 30, "bio" = 20, "rad" = 10, "fire" = 10, "acid" = 0)

/obj/item/clothing/head/helmet/f13/wayfarer/antler
	name = "antler skullcap"
	desc = "(III) An antler skull headdress traditionally worn by the spiritually inclined."
	icon_state = "antlerhelm"
	item_state = "antlerhelm"
	armor = list("tier" = 3, "energy" = 0, "bomb" = 20, "bio" = 70, "rad" = 10, "fire" = 20, "acid" = 0)

/obj/item/clothing/head/helmet/f13/wayfarer/shamanblue
	name = "ritual headdress"
	desc = "(IV) An ancient mask fashioned at the coasts of the Great Salt Water, imbued with the ancestral blessing through a long forgotten ritual."
	icon_state = "shamanblue"
	item_state = "shamanblue"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 20, "bio" = 70, "rad" = 10, "fire" = 20, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/wayfarer/shamanred
	name = "crimson mask"
	desc = "(IV) An uncanny helm passed down through generations, originating from a tribal culture once situated at the top of a Sonoran mesa."
	icon_state = "shamanred"
	item_state = "shamanred"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 20, "bio" = 70, "rad" = 10, "fire" = 20, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/wayfarer/chief
	name = "helm of the steady walk"
	desc = "(VII) A chief who chooses this protectron mantle embodies the defensive, a stalwart heart that protects their village above all other goals, even if it means hampering the growth of the village to do it."
	icon_state = "chiefblue"
	item_state = "chiefblue"
	armor = list("tier" = 7, "energy" = 40, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	flags_inv = HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR

/obj/item/clothing/head/helmet/f13/combat/wayfarer/tribe_helmet
	name = "tribalized helmet"
	desc = "(V) An old military grade pre-war combat helmet, repainted and re purposed with bones and sinew to worship some tribal diety."
	icon_state = "tribe_helmet"
	item_state = "tribe_helmet"
	armor = list("tier" = 5, "energy" = 40, "bomb" = 35, "bio" = 60, "rad" = 10, "fire" = 60, "acid" = 20)

/obj/item/clothing/head/helmet/f13/wayfarer/pa_helmet
	name = "tribal full plate headdress"
	desc = "(VII) The once-marvelous helmet of the T-45d power armor set, repurposed and painted with markings of a tribe to signify its holyness to Kwer. It has dye'd feathers addoring it to make it look fierce in battle."
	icon_state = "tribal_PA_helmet"
	item_state = "tribal_PA_helmet"
	armor = list("tier" = 6, "energy" = 50, "bomb" = 40, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)
	resistance_flags = LAVA_PROOF | FIRE_PROOF

/obj/item/clothing/head/helmet/f13/wayfarer/chief/attack_self(mob/user)
	weldingvisortoggle(user)

/obj/item/clothing/head/helmet/f13/wayfarer/chief/red
	name = "helm of the piercing gaze"
	desc = "(VII) A chief who wears this assaultron helm is known for their prowess in battle, aggressiveness, intimidation and raw power in command. They are bold and strong."
	icon_state = "chiefred"
	item_state = "chiefred"
	armor = list("tier" = 7, "energy" = 40, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

/obj/item/clothing/head/helmet/f13/wayfarer/chief/green
	name = "helm of the helping hand"
	desc = "(VII) The many eyed helper to the village and all, the Chief that chooses this Mr. Handy based mantle is clever and kind in equal measure, they embody industry and diplomacy. Though they aren't defensive, they are surgically precise in eliminating those who oppose them."
	icon_state = "chiefgreen"
	item_state = "chiefgreen"
	armor = list("tier" = 7, "energy" = 40, "bomb" = 39, "bio" = 60, "rad" = 20, "fire" = 80, "acid" = 0)

//Followers

//Vault

/obj/item/clothing/head/helmet/riot/vaultsec
	name = "security helmet"
	desc = "(V) A standard issue vault security helmet, pretty robust."
	armor = list("tier" = 5, "energy" = 5, "bomb" = 5, "bio" = 2, "rad" = 0, "fire" = 50, "acid" = 50)

/obj/item/clothing/head/helmet/riot/vaultsec/vc
	name = "vtcc riot helmet"
	desc = "(VII) A riot helmet adapted from the design of most pre-war riot helmets, painted blue."
	icon_state = "vtcc_riot_helmet"
	item_state = "vtcc_riot_helmet"
	armor = list("tier" = 7, "energy" = 35, "bomb" = 35, "bio" = 40, "rad" = 10, "fire" = 60, "acid" = 10)



//THE GRAVEYARD
//UNUSED or LEGACY - RETAINED IN CASE DESIRED FOR ADMIN SPAWN OR REIMPLEMENATION. MAY NOT BE EVERYTHING THAT'S UNUSED. TEST BEFORE USING
//IF PUT BACK INTO USE, PLEASE FILE IT BACK SOMEWHERE ABOVE

/obj/item/clothing/head/f13/ncr/medic
	name = "NCR medical helmet"
	desc = "(V) A standard issue NCR Infantry helmet, colored to suit a medical officer."
	icon_state = "ncr_medical_helmet"
	item_state = "ncr_medical_helmet"

/obj/item/clothing/head/f13/ncr/mp
	name = "NCR military police helmet"
	desc = "(V) A standard issue NCR helmet, with the letters \"MP\" scrawled on the front."
	icon_state = "ncr_MP"
	item_state = "ncr_MP"

/obj/item/clothing/head/f13/ncr/goggles
	name = "NCR storm helmet"
	desc = "(V) A standard issue NCR Infantry helmet, with a pair of goggles attached to it."
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

/obj/item/clothing/head/hardhat/ncr
	name = "NCR engineer helmet"
	desc = "(V) A standard issue NCR Infantry helmet, modified with a head lamp for engineers."
	icon_state = "hardhat_ncr"
	item_state = "hardhat_ncr"
	item_color = "ncr"
	flags_inv = HIDEEARS
	dog_fashion = null
	armor = list("tier" = 5, "energy" = 20, "bomb" = 25, "bio" = 30, "rad" = 20, "fire" = 60, "acid" = 0)
	strip_delay = 50

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

/obj/item/clothing/head/helmet/f13/khan/fullhelm
	name = "Great Khan full helmet"
	desc = "(IV) A Khan helmet modified with steel horns and a full guard comprised of red sunglass lenses and a thick metal plate to conceal the lower face."
	icon_state = "khanhelmet"
	item_state = "khanhelmet"
	armor = list("tier" = 4, "energy" = 20, "bomb" = 10, "bio" = 0, "rad" = 0, "fire" = 0, "acid" = 0)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 20

/obj/item/clothing/head/helmet/f13/khan/fullhelm/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate)

//Enclave / Remnant
/obj/item/clothing/head/donor/enclave
	name = "enclave forge cap"
	desc = "(III) A resistant, black forage cap issued to Enclave soldiers."
	icon_state = "enclave_cap"
	item_state = "enclave_cap"
	armor = list("tier" = 3, "energy" = 20, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 20, "acid" = 0)

/obj/item/clothing/head/helmet/f13/combat/enclave
	name = "enclave combat helmet"
	desc = "(VI) An intimidating helmet that is issued with it's corresponding suit."
	icon_state = "enclave_new"
	item_state = "enclave_new"
	armor = list("tier" = 6, "energy" = 75, "bomb" = 70, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 50)

/obj/item/clothing/head/helmet/f13/combat/remnant
	name = "remnant combat helmet"
	desc = "(VI) A dark helmet with yellow lenses, used commonly in espionage or shadow ops."
	icon_state = "remnant_helmet"
	item_state = "remnant_helmet"
	armor = list("tier" = 6, "energy" = 75, "bomb" = 70, "bio" = 80, "rad" = 80, "fire" = 80, "acid" = 50)

/obj/item/clothing/head/helmet/f13/envirosuit
	name = "enclave envirosuit hood"
	icon_state = "envirohead"
	item_state = "envirohead"
	desc = "(II) A white hazmat helmet with a coupling system, the visor looks to be made out of orange plexiglas."
	clothing_flags = THICKMATERIAL
	flags_inv = HIDEMASK|HIDEEARS|HIDEFACE|HIDEEYES|HIDEHAIR|HIDEFACIALHAIR
	armor = list("tier" = 2,"energy" = 10, "bomb" = 10, "bio" = 100, "rad" = 100, "fire" = 50, "acid" = 100)
	strip_delay = 60
	equip_delay_other = 60
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	rad_flags = RAD_PROTECT_CONTENTS | RAD_NO_CONTAMINATE

/obj/item/clothing/head/soft/f13/enclave
	name = "officer hat"
	desc = "(I) A standard-issue Enclave officer's cap."
	icon_state = "enclave"
	item_color = "enclave"
