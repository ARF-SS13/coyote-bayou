
/obj/item/clothing/gloves/fingerless
	name = "fingerless gloves"
	desc = "Plain black gloves without fingertips for the hard working."
	icon_state = "fingerless"
	item_state = "fingerless"
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	strip_mod = 0.9
	custom_price = PRICE_ALMOST_CHEAP

/obj/item/clothing/gloves/Biker
	name = "future gloves"
	desc = "Gloves in a futuristic color."
	icon_state = "biker_gloves"
	item_state = "biker_gloves"
	transfer_prints = FALSE

/obj/item/clothing/gloves/fingerless/pugilist
	name = "armwraps"
	desc = "A series of armwraps. Makes you pretty keen to start punching people."
	icon_state = "armwraps"
	item_state = "armwraps"
	body_parts_covered = ARMS
	cold_protection = ARMS
	strip_delay = 300 //you can't just yank them off
	///Extra damage through the punch.
	var/enhancement = 0 //it's a +0 to your punches because it isn't magical
	///Main trait added by the gloves to the user on wear.
	var/inherited_trait = NONE //what are you, dishonoroable?
	///Secondary trait added by the gloves to the user on wear.
	var/secondary_trait = NONE //what are you, a coward?

/obj/item/clothing/gloves/fingerless/pugilist/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_GLOVES)
		if(ishuman(user))
			var/mob/living/carbon/human/H = user
			ADD_TRAIT(H, TRAIT_PUGILIST, GLOVE_TRAIT)
			ADD_TRAIT(H, inherited_trait, GLOVE_TRAIT)
			ADD_TRAIT(H, secondary_trait, GLOVE_TRAIT)
			H.dna.species.punchdamagehigh += enhancement
			H.dna.species.punchdamagelow += enhancement

/obj/item/clothing/gloves/fingerless/pugilist/dropped(mob/user)

	REMOVE_TRAIT(user, TRAIT_PUGILIST, GLOVE_TRAIT)
	REMOVE_TRAIT(user, inherited_trait, GLOVE_TRAIT)
	REMOVE_TRAIT(user, secondary_trait, GLOVE_TRAIT)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.dna.species.punchdamagehigh -= enhancement
		H.dna.species.punchdamagelow -= enhancement
	return ..()

/obj/item/clothing/gloves/fingerless/pugilist/chaplain
	name = "armwraps of unyielding resolve"
	desc = "A series of armwraps, soaked in holy water. Makes you pretty keen to smite evil magic users."
	resistance_flags = FIRE_PROOF | ACID_PROOF
	enhancement = 30 // Equal to the mace gloves and vastly outperformed by the power fist.
	secondary_trait = TRAIT_ANTIMAGIC
	var/chaplain_spawnable = TRUE

/obj/item/clothing/gloves/fingerless/pugilist/chaplain/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, FALSE, null, null, FALSE)

/obj/item/clothing/gloves/fingerless/pugilist/magic
	name = "armwraps of mighty fists"
	desc = "A series of armwraps. Makes you pretty keen to go adventuring and punch dragons."
	resistance_flags = FIRE_PROOF | ACID_PROOF //magic items are harder to damage with energy this is a dnd joke okay?
	enhancement = 1 //They're +1!

/obj/item/clothing/gloves/fingerless/pugilist/gravity
	name = "gravity gauntlet"
	desc = "A magical glove that grants the wearer the ability to grab distant objects, use with *magegrab!"
	icon_state = "s_ninjan"
	item_state = "s_ninjan"
	resistance_flags = FIRE_PROOF | ACID_PROOF //magic items are harder to damage with energy this is a dnd joke okay?
	enhancement = 0 //Not for damage, a utility item
	secondary_trait = TRAIT_MAGEGRAB //Should give you the magegrab quirk, not telekinesis

/obj/item/clothing/gloves/fingerless/pugilist/hungryghost
	name = "armwraps of the hungry ghost"
	desc = "A series of blackened, bloodstained armwraps stitched with strange geometric symbols. Makes you pretty keen to commit horrible acts against the living through bloody carnage."
	icon_state = "narsiearmwraps"
	item_state = "narsiearmwraps"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = ARMOR_VALUE_LIGHT
	enhancement = 3
	secondary_trait = TRAIT_KI_VAMPIRE

/obj/item/clothing/gloves/fingerless/pugilist/brassmountain
	name = "armbands of the brass mountain"
	desc = "A series of scolding hot brass armbands. Makes you pretty keen to bring the light to the unenlightened through unmitigated violence."
	icon_state = "ratvararmwraps"
	item_state = "ratvararmwraps"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	armor = ARMOR_VALUE_LIGHT
	enhancement = 4 //The artifice of Ratvar is unmatched except when it is.
	secondary_trait = TRAIT_STRONG_GRABBER

/obj/item/clothing/gloves/fingerless/pugilist/rapid
	name = "Bands of the Swamp Star"
	desc = "The armbands of a deadly martial artist, putting them on means accepting a way of life. Once worn, they cannot be removed!"
	icon_state = "rapid"
	item_state = "rapid"
	enhancement = 10 //omae wa mou shindeiru
	var/warcry = ""
	secondary_trait = TRAIT_NOGUNS //No pew pew


/obj/item/clothing/gloves/fingerless/pugilist/rapid/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, GLOVE_TRAIT)

/obj/item/clothing/gloves/fingerless/pugilist/rapid/Touch(atom/target, proximity = TRUE)
	if(!isliving(target))
		return

	var/mob/living/M = loc
	M.SetNextAction(CLICK_CD_RAPID)
	if(warcry)
		M.say("[warcry]", ignore_spam = TRUE, forced = TRUE, just_chat = TRUE) // ONLY in the overhead text thing!

	return NO_AUTO_CLICKDELAY_HANDLING | ATTACK_IGNORE_ACTION

/obj/item/clothing/gloves/fingerless/pugilist/rapid/AltClick(mob/user)
	var/input = stripped_input(user,"What do you want your battlecry to be? Max length of 6 characters.", ,"", 7)
	if(input)
		warcry = input

/obj/item/clothing/gloves/fingerless/pugilist/hug
	name = "Hugs of the North Star"
	desc = "The armbands of a humble friend. Makes you pretty keen to go let everyone know how much you appreciate them!"
	icon_state = "rapid"
	item_state = "rapid"
	enhancement = 0
	secondary_trait = TRAIT_PACIFISM //You are only here to hug and be friends!

/obj/item/clothing/gloves/fingerless/pugilist/hug/Touch(mob/target, proximity = TRUE)
	if(!isliving(target))
		return

	var/mob/living/M = loc

	if(M.a_intent != INTENT_HELP)
		return FALSE
	if(target.stat != CONSCIOUS) //Can't hug people who are dying/dead
		return FALSE
	else
		M.SetNextAction(CLICK_CD_RAPID)

	return NO_AUTO_CLICKDELAY_HANDLING | ATTACK_IGNORE_ACTION


/obj/item/clothing/gloves/combat
	name = "combat gloves"
	desc = "These tactical gloves are fireproof and shock resistant."
	icon_state = "black"
	item_state = "blackgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	strip_delay = 80
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_BULLET_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)
	strip_mod = 1.5


/obj/item/clothing/gloves/bracer
	name = "bone bracers"
	desc = "For when you're expecting to get slapped on the wrist. Offers modest protection to your arms."
	icon_state = "bracers"
	item_state = "bracers"
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	body_parts_covered = ARMS
	cold_protection = ARMS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = ARMOR_VALUE_LIGHT
	armor_tokens = list(ARMOR_MODIFIER_UP_MELEE_T1, ARMOR_MODIFIER_UP_ENV_T1, ARMOR_MODIFIER_UP_DT_T1)

/obj/item/clothing/gloves/thief
	name = "black gloves"
	desc = "Gloves made with completely frictionless, insulated cloth, easier to steal from people with."
	icon_state = "thief"
	item_state = "blackgloves"
	siemens_coefficient = 0
	permeability_coefficient = 0.05
	strip_delay = 80
	transfer_prints = FALSE
	strip_mod = 5
	strip_silence = TRUE

/obj/item/clothing/gloves/evening
	name = "evening gloves"
	desc = "Thin, pretty gloves intended for use in regal feminine attire. A tag on the hem claims they were 'maid' in Space China, these were probably intended for use in some maid fetish."
	icon_state = "evening"
	item_state = "evening"
	transfer_prints = TRUE
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	strip_mod = 0.9

/obj/item/clothing/gloves/evening/black
	name = "midnight gloves"
	desc = "Thin, pretty gloves intended for use in sexy feminine attire. A tag on the hem claims they pair great with black stockings."
	icon_state = "eveningblack"
	item_state = "eveningblack"

/obj/item/clothing/gloves/patrol
	name = "patrol ranger gloves"
	desc = "A pair of ranger's gloves. The right thumb and finger have been removed to not impair the wearer's shooting ability."
	icon_state = "patrol"
	item_state = "patrol"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/modif_patrol
	name = "modified patrol ranger gloves"
	desc = "A pair of ranger's gloves. These ones have been enlongated, protecting the elbow as well."
	icon_state = "patrol"
	item_state = "modif_patrol"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/patrol/burned
	name = "wrapped patrol ranger gloves"
	desc = "A pair of ranger's gloves. One of the gloves was replaced with a bandage."
	icon_state = "burned"
	item_state = "burned"
	item_color = null	//So they don't wash.

/obj/item/clothing/gloves/rifleman
	name = "rifleman gloves"
	desc = "A pair of rifleman's gloves. The thumb and finger have been removed to not impair the wearer's shooting ability."
	icon_state = "rifleman"
	item_state = "rifleman"
	item_color = null	//So they don't wash.
	transfer_prints = TRUE
	strip_delay = 40
	equip_delay_other = 20
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT

/obj/item/clothing/gloves/fingerlessevening
	name = "fingerless evening gloves"
	desc = "A pair of long, white gloves with fingerlips tips.."
	icon_state = "long_fingerless"
	item_state = "long_fingerless"

/obj/item/clothing/gloves/armwarmer
	name = "arm warmer"
	desc = "A pair of arm warmers."
	icon_state = "armwarmer"
	item_state = "armwarmer"

/obj/item/clothing/gloves/armwarmer_long
	name = "arm warmer long"
	desc = "A pair of arm warmers."
	icon_state = "armwarmer_long"
	item_state = "armwarmer_long"

/obj/item/clothing/gloves/armwarmer_striped
	name = "arm warmer striped"
	desc = "A pair of arm warmers."
	icon_state = "armwarmer_striped"
	item_state = "armwarmer_striped"

/obj/item/clothing/gloves/armwarmer_striped_long
	name = "arm warmer striped long"
	desc = "A pair of arm warmers."
	icon_state = "armwarmer_striped_long"
	item_state = "armwarmer_striped_long"

