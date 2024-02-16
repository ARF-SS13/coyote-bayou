/obj/item/clothing/under/
	name = "Base"
	mutantrace_variation = STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/pj/red
	name = "red pj's"
	desc = "Sleepwear."
	icon_state = "red_pyjamas"
	item_state = "w_suit"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/misc/pj/blue
	name = "blue pj's"
	desc = "Sleepwear."
	icon_state = "blue_pyjamas"
	item_state = "w_suit"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/misc/patriotsuit
	name = "Patriotic Suit"
	desc = "Motorcycle not included."
	icon_state = "ek"
	item_state = "ek"
	can_adjust = FALSE

/obj/item/clothing/under/rank/prisoner
	name = "prison jumpsuit"
	desc = "Standardised prisoner-wear."
	icon_state = "prisoner"
	item_state = "o_suit"
	has_sensor = LOCKED_SENSORS
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/patriotsuit
	name = "Patriotic Suit"
	desc = "Motorcycle not included."
	icon_state = "ek"
	item_state = "ek"
	item_color = "ek"
	can_adjust = FALSE

/obj/item/clothing/under/scarecrow
	name = "scarecrow clothes"
	desc = "Perfect camouflage for hiding in the fields."
	icon_state = "scarecrow"
	item_state = "scarecrow"
	item_color = "scarecrow"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/jester
	name = "jester suit"
	desc = "A jolly dress, well suited to entertain your master."
	icon_state = "jester"
	item_state = "jester"
	item_color = "jester"
	can_adjust = FALSE

/obj/item/clothing/under/jester/alt
	icon_state = "jester2"

/obj/item/clothing/under/jester/dark
	name = "chaos jester suit"
	desc = "Filled with chaos, this outfit makes it feel like you can do anything!"
	icon_state = "d_jester"
	item_state = "dark_jester"
	item_color = "d_jester"

/obj/item/clothing/under/hosparademale
	name = "head of security's parade uniform"
	desc = "A male head of security's luxury-wear, for special occasions."
	icon_state = "hos_parade_male"
	item_state = "r_suit"
	item_color = "hos_parade_male"
	can_adjust = FALSE


/obj/item/clothing/under/sundress
	name = "sundress"
	desc = "Makes you want to frolic in a field of daisies."
	icon_state = "sundress"
	item_state = "sundress"
	item_color = "sundress"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/rank/mailman
	name = "mailman's jumpsuit"
	desc = "<i>'Special delivery!'</i>"
	icon_state = "mailman"
	item_state = "b_suit"
	item_color = "mailman"

/obj/item/clothing/under/burial
	name = "burial garments"
	desc = "Traditional burial garments."
	icon_state = "burial"
	item_state = "burial"
	item_color = "burial"
	has_sensor = NO_SENSORS

/obj/item/clothing/under/stripeddress
	name = "striped dress"
	desc = "Fashion in space."
	icon_state = "striped_dress"
	item_state = "stripeddress"
	item_color = "striped_dress"
	fitted = FEMALE_UNIFORM_FULL
	can_adjust = FALSE

/obj/item/clothing/under/singery
	name = "yellow performer's outfit"
	desc = "Just looking at this makes you want to sing."
	icon_state = "ysing"
	item_state = "ysing"
	item_color = "ysing"
	fitted = NO_FEMALE_UNIFORM
	alternate_worn_layer = ABOVE_SHOES_LAYER
	can_adjust = FALSE

/obj/item/clothing/under/assistantformal
	name = "assistant's formal uniform"
	desc = "An assistant's formal-wear. Why an assistant needs formal-wear is still unknown."
	icon_state = "assistant_formal"
	item_state = "gy_suit"
	item_color = "assistant_formal"
	can_adjust = FALSE

/obj/item/clothing/under/rank/prisoner/skirt
	name = "prison jumpskirt"
	desc = "Standardised prisoner-wear."
	icon_state = "prisoner_skirt"
	item_state = "o_suit"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE
	fitted = FEMALE_UNIFORM_TOP
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/mailman
	name = "mailman's jumpsuit"
	desc = "<i>'Special delivery!'</i>"
	icon_state = "mailman"
	item_state = "b_suit"

/obj/item/clothing/under/misc/psyche
	name = "psychedelic jumpsuit"
	desc = "Groovy!"
	icon_state = "psyche"
	item_state = "p_suit"

/obj/item/clothing/under/misc/vice_officer
	name = "vice officer's jumpsuit"
	desc = "It's the standard issue pretty-boy outfit."
	icon_state = "vice"
	item_state = "gy_suit"
	can_adjust = FALSE


/obj/item/clothing/under/misc/adminsuit
	name = "administrative cybernetic jumpsuit"
	icon_state = "syndicate"
	item_state = "bl_suit"
	desc = "A cybernetically enhanced jumpsuit used for administrative duties."
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list("melee" = 100, "bullet" = 100, "laser" = 100,"energy" = 100, "bomb" = 100, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100, "wound" = 1000) //wound defense at 100 wont stop wounds
	cold_protection = CHEST | GROIN | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	can_adjust = FALSE
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/clothing/under/misc/overalls
	name = "laborer's overalls"
	desc = "A set of durable overalls for getting the job done."
	icon_state = "overalls"
	item_state = "lb_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/assistantformal
	name = "assistant's formal uniform"
	desc = "An assistant's formal-wear. Why an assistant needs formal-wear is still unknown."
	icon_state = "assistant_formal"
	item_state = "gy_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/staffassistant
	name = "staff assistant's jumpsuit"
	desc = "It's a generic grey jumpsuit. That's about what assistants are worth, anyway."
	icon = 'goon/icons/obj/item_js_rank.dmi'
	mob_overlay_icon = 'goon/icons/mob/worn_js_rank.dmi'
	icon_state = "assistant"
	item_state = "gy_suit"
	mutantrace_variation = USE_TAUR_CLIP_MASK

/obj/item/clothing/under/croptop
	name = "crop top"
	desc = "We've saved money by giving you half a shirt!"
	icon_state = "croptop"
	body_parts_covered = CHEST|GROIN|ARMS
	body_parts_hidden = CHEST
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/jamrock
	name = "Disco-Ass Shirt and Pants"
	desc = "This white satin shirt used to be fancy. It used to really catch the light. Now it smells like someone took a piss in the armpits while the golden brown trousers are flare-cut. Normal bell-bottom trousers would be boot-cut, but these are far from normal. They are someone's piss-soaked, cum-stained party pants. "
	icon_state = "jamrock_uniform"
	item_state = "jamrock_uniform"
	item_color = "jamrock_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/plasmaman
	name = "enviromental suit"
	desc = "A special containment suit that allows lifeforms to exist safely in an oxygenated environment, and automatically extinguishes them in a crisis. Despite being airtight, it's not spaceworthy."
	icon_state = "plasmaman"
	item_state = "plasmaman"
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T3)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	mutantrace_variation = USE_TAUR_CLIP_MASK
	can_adjust = FALSE
	strip_delay = 80
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5

/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += span_notice("There are [extinguishes_left] extinguisher charges left in this suit.")

/obj/item/clothing/under/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(H.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message(span_warning("[H]'s suit automatically extinguishes [H.p_them()]!"),span_warning("Your suit automatically extinguishes you."))
			H.ExtinguishMob()
			new /obj/effect/particle_effect/water(get_turf(H))
	return 0

/obj/item/clothing/under/plasmaman/attackby(obj/item/E, mob/user, params)
	..()
	if (istype(E, /obj/item/extinguisher_refill))
		if (extinguishes_left == 5)
			to_chat(user, span_notice("The inbuilt extinguisher is full."))
			return
		else
			extinguishes_left = 5
			to_chat(user, span_notice("You refill the suit's built-in extinguisher, using up the cartridge."))
			qdel(E)
			return
	return

/obj/item/extinguisher_refill
	name = "envirosuit extinguisher cartridge"
	desc = "A cartridge loaded with a compressed extinguisher mix, used to refill the automatic extinguisher on plasma envirosuits."
	icon_state = "plasmarefill"
	icon = 'icons/obj/device.dmi'

/obj/item/clothing/under/misc/gear_harness
	name = "gear harness"
	desc = "A simple, inconspicuous harness replacement for a jumpsuit."
	icon_state = "gear_harness"
	item_state = "gear_harness"
	body_parts_covered = 0
	body_parts_hidden = 0 // nudie~
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/durathread
	name = "durathread jumpsuit"
	desc = "A jumpsuit made from durathread, its resilient fibres provide some protection to the wearer."
	icon_state = "durathread"
	item_state = "durathread"
	can_adjust = TRUE

/obj/item/clothing/under/misc/durathread/skirt
	name = "durathread jumpskirt"
	desc = "A jumpsuit made from durathread, its resilient fibres provide some protection to the wearer. Being a short skirt, it naturally doesn't protect the legs."
	icon_state = "duraskirt"
	item_state = "duraskirt"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/squatter
	name = "slav squatter tracksuit"
	desc = "Cyka blyat."
	icon_state = "squatteroutfit"
	item_state = "squatteroutfit"
	can_adjust = FALSE
	mutantrace_variation = USE_TAUR_CLIP_MASK

/obj/item/clothing/under/misc/blue_camo
	name = "russian blue camo"
	desc = "Drop and give me dvadtsat!"
	icon_state = "russobluecamo"
	item_state = "russobluecamo"
	can_adjust = FALSE
	mutantrace_variation = USE_TAUR_CLIP_MASK

/obj/item/clothing/under/misc/keyholesweater
	name = "keyhole sweater"
	desc = "What is the point of this, anyway?"
	icon_state = "keyholesweater"
	item_state = "keyholesweater"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/stripper
	name = "pink stripper outfit"
	icon_state = "stripper_p"
	item_state = "stripper_p"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	body_parts_hidden = 0

/obj/item/clothing/under/misc/stripper/green
	name = "green stripper outfit"
	icon_state = "stripper_g"
	item_state = "stripper_g"

/obj/item/clothing/under/misc/stripper/mankini
	name = "pink mankini"
	icon_state = "mankini"
	item_state = "mankini"

/obj/item/clothing/under/misc/corporateuniform
	name = "corporate uniform"
	desc = "A comfortable, tight fitting jumpsuit made of premium materials. Not space-proof."
	icon_state = "tssuit"
	item_state = "r_suit"
	can_adjust = FALSE
	mutantrace_variation = USE_TAUR_CLIP_MASK

/obj/item/clothing/under/misc/poly_shirt
	name = "polychromic button-up shirt"
	desc = "A fancy button-up shirt made with polychromic threads."
	icon_state = "polysuit"
	item_state = "sl_suit"
	mutantrace_variation = NONE

/obj/item/clothing/under/misc/poly_shirt/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#353535", "#353535"), 3)

/obj/item/clothing/under/misc/polyshorts
	name = "polychromic shorts"
	desc = "For ease of movement and style."
	icon_state = "polyshorts"
	item_state = "rainbow"
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|ARMS

/obj/item/clothing/under/misc/polyshorts/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#353535", "#808080", "#808080"), 3)

/obj/item/clothing/under/misc/polyjumpsuit
	name = "polychromic tri-tone jumpsuit"
	desc = "A fancy jumpsuit made with polychromic threads."
	icon_state = "polyjump"
	item_state = "rainbow"
	can_adjust = FALSE
	mutantrace_variation = NONE

/obj/item/clothing/under/misc/polyjumpsuit/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#FFFFFF", "#808080", "#353535"), 3)

/obj/item/clothing/under/misc/poly_bottomless
	name = "polychromic bottomless shirt"
	desc = "Great for showing off your underwear in dubious style."
	icon_state = "polybottomless"
	item_state = "rainbow"
	body_parts_covered = CHEST|ARMS	//Because there's no bottom included
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON

/obj/item/clothing/under/misc/poly_bottomless/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, list("#808080", "#FF3535"), 2)

/obj/item/clothing/under/misc/poly_tanktop
	name = "polychromic tank top"
	desc = "For those lazy summer days."
	icon_state = "polyshimatank"
	item_state = "rainbow"
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE|STYLE_NO_ANTHRO_ICON
	var/list/poly_states = 3
	var/list/poly_colors = list("#808080", "#FFFFFF", "#8CC6FF")

/obj/item/clothing/under/misc/poly_tanktop/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/polychromic, poly_colors, poly_states)

/obj/item/clothing/under/misc/poly_tanktop/female
	name = "polychromic feminine tank top"
	desc = "Great for showing off your chest in style. Not recommended for males."
	icon_state = "polyfemtankpantsu"
	poly_states = 2
	poly_colors = list("#808080", "#FF3535")

/obj/item/clothing/under/misc/black_dress
	name = "little black dress"
	desc = "A small black dress."
	icon_state = "littleblackdress_s"
	item_state = "littleblackdress_s"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/misc/pinktutu
	name = "pink tutu"
	desc = "A pink tutu."
	icon_state = "pinktutu_s"
	item_state = "pinktutu_s"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/misc/bathrobe
	name = "bathrobe"
	desc = "A blue bathrobe."
	icon_state = "bathrobe"
	item_state = "bathrobe"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/misc/mechsuitred
	name = "red mech suit"
	desc = "What are you, stupid?"
	icon_state = "red_mech_suit"
	item_state = "red_mech_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/mechsuitwhite
	name = "white mech suit"
	desc = "...Mom?"
	icon_state = "white_mech_suit"
	item_state = "white_mech_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/mechsuitblue
	name = "blue mech suit"
	desc = "Get in the damn robot already!"
	icon_state = "blue_mech_suit"
	item_state = "blue_mech_suit"
	can_adjust = FALSE

/obj/item/clothing/under/jabroni
	name = "Jabroni Outfit"
	desc = "The leather club is two sectors down."
	icon_state = "darkholme"
	item_state = "darkholme"
	item_color = "darkholme"
	can_adjust = FALSE

/obj/item/clothing/under/overalls
	name = "laborer's overalls"
	desc = "A set of durable overalls for getting the job done."
	icon_state = "overalls"
	item_state = "lb_suit"
	item_color = "overalls"
	can_adjust = FALSE

/obj/item/clothing/under/plaid_skirt
	name = "red plaid skirt"
	desc = "A preppy red skirt with a white blouse."
	icon_state = "plaid_red"
	item_state = "plaid_red"
	item_color = "plaid_red"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/plaid_skirt/green
	name = "green plaid skirt"
	desc = "A preppy green skirt with a white blouse."
	icon_state = "plaid_green"
	item_state = "plaid_green"
	item_color = "plaid_green"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/plaid_skirt/purple
	name = "purple plaid skirt"
	desc = "A preppy purple skirt with a white blouse."
	icon_state = "plaid_purple"
	item_state = "plaid_purple"
	item_color = "plaid_purple"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/blacktango
	name = "black tango dress"
	desc = "Filled with Latin fire."
	icon_state = "black_tango"
	item_state = "wcoat"
	item_color = "black_tango"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/kilt
	name = "kilt"
	desc = "Includes shoes and plaid."
	icon_state = "kilt"
	item_state = "kilt"
	item_color = "kilt"
	body_parts_covered = CHEST|GROIN|FEET
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/pirate
	name = "pirate outfit"
	desc = "Yarr."
	icon_state = "pirate"
	item_state = "pirate"
	item_color = "pirate"
	can_adjust = FALSE

/obj/item/clothing/under/kilt/highlander
	desc = "You're the only one worthy of this kilt."
//	item_flags = NODROP

/obj/item/clothing/under/redeveninggown
	name = "red evening gown"
	desc = "Fancy dress for space bar singers."
	icon_state = "red_evening_gown"
	item_state = "redeveninggown"
	item_color = "red_evening_gown"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/janimaid
	name = "maid uniform"
	desc = "A simple maid uniform for housekeeping."
	icon_state = "janimaid"
	item_state = "janimaid"
	item_color = "janimaid"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/janimaid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/A = new (src)
	attach_accessory(A)

/obj/item/clothing/under/suit_jacket/charcoal
	name = "charcoal suit"
	desc = "A charcoal suit and red tie. Very professional."
	icon_state = "charcoal_suit"
	item_state = "charcoal_suit"
	item_color = "charcoal_suit"

/obj/item/clothing/under/suit_jacket/burgundy
	name = "burgundy suit"
	desc = "A burgundy suit and black tie. Somewhat formal."
	icon_state = "burgundy_suit"
	item_state = "burgundy_suit"
	item_color = "burgundy_suit"

/obj/item/clothing/under/suit_jacket/checkered
	name = "checkered suit"
	desc = "That's a very nice suit you have there. Shame if something were to happen to it, eh?"
	icon_state = "checkered_suit"
	item_state = "checkered_suit"
	item_color = "checkered_suit"

/obj/item/clothing/under/scratch
	name = "white suit"
	desc = "A white suit, suitable for an excellent host."
	icon_state = "scratch"
	item_state = "scratch"
	item_color = "scratch"
	can_adjust = FALSE

/obj/item/clothing/under/plaid_skirt/blue
	name = "blue plaid skirt"
	desc = "A preppy blue skirt with a white blouse."
	icon_state = "plaid_blue"
	item_state = "plaid_blue"
	item_color = "plaid_blue"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/geisha
	name = "geisha suit"
	desc = "Cute space ninja senpai not included."
	icon_state = "geisha"
	item_color = "geisha"
	can_adjust = FALSE

/obj/item/clothing/under/sailor
	name = "sailor suit"
	desc = "Skipper's in the wardroom drinkin gin'."
	icon_state = "sailor"
	item_state = "sailor"
	item_color = "sailor"
	can_adjust = FALSE

/obj/item/clothing/under/schoolgirl/red
	name = "red schoolgirl uniform"
	icon_state = "schoolgirlred"
	item_state = "schoolgirlred"
	item_color = "schoolgirlred"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/suit_jacket/navy
	name = "navy suit"
	desc = "A navy suit and red tie, intended for the station's finest."
	icon_state = "navy_suit"
	item_state = "navy_suit"
	item_color = "navy_suit"

/obj/item/clothing/under/suit_jacket/female
	name = "executive suit"
	desc = "A formal trouser suit for women, intended for the station's finest."
	icon_state = "black_suit_fem"
	item_state = "black_suit_fem"
	item_color = "black_suit_fem"

/obj/item/clothing/under/soviet
	name = "soviet uniform"
	desc = "For the Motherland!"
	icon_state = "soviet"
	item_state = "soviet"
	item_color = "soviet"
	can_adjust = FALSE

/obj/item/clothing/under/gladiator
	name = "gladiator uniform"
	desc = "Are you not entertained? Is that not why you are here?"
	icon_state = "gladiator"
	item_state = "gladiator"
	item_color = "gladiator"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/gladiator/ash_walker
	desc = "This gladiator uniform appears to be covered in ash and fairly dated."
	has_sensor = NO_SENSORS

/obj/item/clothing/under/maid
	name = "maid costume"
	desc = "Maid in China."
	icon_state = "maid"
	item_state = "maid"
	item_color = "maid"
	body_parts_covered = CHEST|GROIN
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/maid/Initialize()
	. = ..()
	var/obj/item/clothing/accessory/maidapron/A = new (src)
	attach_accessory(A)

/obj/item/clothing/under/draculass
	name = "draculass coat"
	desc = "A dress inspired by the ancient \"Victorian\" era."
	icon_state = "draculass"
	item_state = "draculass"
	item_color = "draculass"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/suit_jacket/tan
	name = "tan suit"
	desc = "A tan suit with a yellow tie. Smart, but casual."
	icon_state = "tan_suit"
	item_state = "tan_suit"
	item_color = "tan_suit"

/obj/item/clothing/under/sailordress
	name = "sailor dress"
	desc = "Formal wear for a leading lady."
	icon_state = "sailor_dress"
	item_state = "sailor_dress"
	item_color = "sailor_dress"
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/schoolgirl
	name = "blue schoolgirl uniform"
	desc = "It's just like one of my Japanese animes!"
	icon_state = "schoolgirl"
	item_state = "schoolgirl"
	item_color = "schoolgirl"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/schoolgirl/red
	name = "red schoolgirl uniform"
	icon_state = "schoolgirlred"
	item_state = "schoolgirlred"
	item_color = "schoolgirlred"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/schoolgirl/green
	name = "green schoolgirl uniform"
	icon_state = "schoolgirlgreen"
	item_state = "schoolgirlgreen"
	item_color = "schoolgirlgreen"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

/obj/item/clothing/under/schoolgirl/orange
	name = "orange schoolgirl uniform"
	icon_state = "schoolgirlorange"
	item_state = "schoolgirlorange"
	item_color = "schoolgirlorange"
	body_parts_covered = CHEST|GROIN|ARMS
	fitted = FEMALE_UNIFORM_TOP
	can_adjust = FALSE

//Kimono's from Virgo

/obj/item/clothing/under/kimono/red
	name = "Red Kimono"
	icon_state = "kimono_red"
	item_state = "kimono_red"
	item_color = "kimono_red"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/orange
	name = "Orange Kimono"
	icon_state = "kimono_orange"
	item_state = "kimono_orange"
	item_color = "kimono_orange"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/yellow
	name = "Yellow Kimono"
	icon_state = "kimono_yellow"
	item_state = "kimono_yellow"
	item_color = "kimono_yellow"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/green
	name = "Green Kimono"
	icon_state = "kimono_green"
	item_state = "kimono_green"
	item_color = "kimono_green"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/blue
	name = "Blue Kimono"
	icon_state = "kimono_blue"
	item_state = "kimono_blue"
	item_color = "kimono_blue"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/purple
	name = "Purple Kimono"
	icon_state = "kimono_purple"
	item_state = "kimono_purple"
	item_color = "kimono_purple"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/violet
	name = "Violet Kimono"
	icon_state = "kimono_violet"
	item_state = "kimono_violet"
	item_color = "kimono_violet"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/pink
	name = "Pink Kimono"
	icon_state = "kimono_pink"
	item_state = "kimono_pink"
	item_color = "kimono_pink"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/kimono/earth
	name = "Earth Kimono"
	icon_state = "kimono_earth"
	item_state = "kimono_earth"
	item_color = "kimono_earth"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/blueskirt_alt
	name = "black and blue skirt"
	icon_state = "blue_skirt2"
	item_state = "blue_skirt2"
	item_color = "blue_skirt2"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

//NCRANGER STUFF

/obj/item/clothing/under/burma
	name = "Jungle Uniform"
	desc = "A Commonwealth made jungle uniform commonly used in Burma"
	icon_state = "burma"
	item_state = "burma"
	item_color = "burma"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/burma/britishbattledress
	name = "British Battle Dress"
	desc = "The No. 5 Uniform, was the combat uniform worn by British Commonwealth and Imperial forces specifically for temperate, cold or even artic conditions"
	icon_state = "british_battle_dress"
	item_state = "british_battle_dress"
	can_adjust = TRUE

//Stuff from Civ 13
/obj/item/clothing/under/civ
	name = "Base"
	mutantrace_variation = NONE

/obj/item/clothing/under/civ/indiancloth_one
	name = "Fuzzy loincloth, just waist. Short."
	icon_state = "indian1"
	item_state = "indian1"
	item_color = "indian1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/indiancloth_two
	name = "Fuzzy loincloth, just waist. Longer."
	icon_state = "indian2"
	item_state = "indian2"
	item_color = "indian2"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE


/obj/item/clothing/under/civ/indiancloth_three
	name = "Fuzzy loincloth, waist and chest."
	icon_state = "indian3"
	item_state = "indian3"
	item_color = "indian3"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/indiancloth_shaman
	name = "Fuzzy loincloth, shaman"
	icon_state = "indianshaman"
	item_state = "indianshaman"
	item_color = "indianshaman"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/indiancloth_chef
	name = "Fuzzy loincloth, chef"
	icon_state = "indianchef"
	item_state = "indianchef"
	item_color = "indianchef"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/portuguese_sailor1
	name = "Green Sailor"
	icon_state = "portuguese_sailor1"
	item_state = "portuguese_sailor1"
	item_color = "portuguese_sailor1"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE

/obj/item/clothing/under/civ/portuguese_sailor2
	name = "Green sailor, with bow"
	icon_state = "portuguese_sailor_alt"
	item_state = "portuguese_sailor_alt"
	item_color = "portuguese_sailor_alt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/sailor_port
	name = "Pink Sailor"
	icon_state = "sailor_port"
	item_state = "sailor_port"
	item_color = "sailor_port"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE

/obj/item/clothing/under/civ/spanish_sailor
	name = "Brown Sailor"
	icon_state = "spanish_sailor"
	item_state = "spanish_sailor"
	item_color = "spanish_sailor"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE

/obj/item/clothing/under/civ/spanish_soldier
	name = "brown suit"
	icon_state = "spanish_soldier"
	item_state = "spanish_soldier"
	item_color = "spanish_soldier"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/british_soldier
	name = "white suit with black pants"
	icon_state = "british_soldier"
	item_state = "british_soldier"
	item_color = "british_soldier"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/french_sailor
	name = "french sailor"
	icon_state = "french_sailor"
	item_state = "french_sailor"
	item_color = "french_sailor"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE

/obj/item/clothing/under/civ/dutch_sailor
	name = "white shirt with orange pants"
	icon_state = "dutch_sailor"
	item_state = "dutch_sailor"
	item_color = "dutch_sailor"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = TRUE

/obj/item/clothing/under/civ/dress2
	name = "blue peasant dress"
	icon_state = "dress2"
	item_state = "dress2"
	item_color = "dress2"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/dress3
	name = "brown peasant dress"
	icon_state = "dress3"
	item_state = "dress3"
	item_color = "dress3"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/dressg
	name = "green peasant dress"
	icon_state = "dressg"
	item_state = "dressg"
	item_color = "dressg"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/dressr
	name = "red peasant dress"
	icon_state = "dressr"
	item_state = "dressr"
	item_color = "dressr"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/leopardpelt
	name = "leopard pelt"
	icon_state = "giant_leopard_pelt"
	item_state = "giant_leopard_pelt"
	item_color = "giant_leopard_pelt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/arabw_robe
	name = "blue robe"
	icon_state = "arabw_robe"
	item_state = "arabw_robe"
	item_color = "arabw_robe"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/arabw_tunic
	name = "blue tunic"
	icon_state = "arabw_tunic"
	item_state = "arabw_tunic"
	item_color = "arabw_tunic"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/mayan_loincloth
	name = "long loincloth"
	icon_state = "mayan_loincloth"
	item_state = "mayan_loincloth"
	item_color = "mayan_loincloth"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/greatshendyt
	name = "Egypt dress"
	icon_state = "greatshendyt"
	item_state = "greatshendyt"
	item_color = "greatshendyt"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/pharaoh
	name = "pharaoh dress"
	icon_state = "pharaoh"
	item_state = "pharaoh"
	item_color = "pharaoh"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/dark_hanfu
	name = "dark hanfu"
	icon_state = "dark_hanfu"
	item_state = "dark_hanfu"
	item_color = "dark_hanfu"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/light_hanfu
	name = "light hanfu"
	icon_state = "light_hanfu"
	item_state = "light_hanfu"
	item_color = "light_hanfu"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

/obj/item/clothing/under/civ/green_hanfu
	name = "green hanfu"
	icon_state = "green_hanfu"
	item_state = "green_hanfu"
	item_color = "green_hanfu"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE

//Swimsuits

/obj/item/clothing/under/swimsuit/black
	name = "black swimsuit"
	desc = "An oldfashioned black swimsuit."
	icon_state = "swim_black"
	item_state = "swim_black"
	item_color = "swim_black"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/blue
	name = "blue swimsuit"
	desc = "An oldfashioned blue swimsuit."
	icon_state = "swim_blue"
	item_state = "swim_blue"
	item_color = "swim_blue"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/purple
	name = "purple swimsuit"
	desc = "An oldfashioned purple swimsuit."
	icon_state = "swim_purp"
	item_state = "swim_purp"
	item_color = "swim_purp"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/green
	name = "green swimsuit"
	desc = "An oldfashioned green swimsuit."
	icon_state = "swim_green"
	item_state = "swim_green"
	item_color = "swim_green"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/red
	name = "red swimsuit"
	desc = "An oldfashioned red swimsuit."
	icon_state = "swim_red"
	item_state = "swim_red"
	item_color = "swim_red"
	can_adjust = FALSE


/obj/item/clothing/under/swimsuit/striped
	name = "striped swimsuit"
	desc = "A more revealing striped swimsuit."
	icon_state = "swim_striped"
	item_state = "swim_striped"
	item_color = "swim_striped"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/white
	name = "white swimsuit"
	desc = "A classic one piece."
	icon_state = "swim_white"
	item_state = "swim_white"
	item_color = "swim_white"
	can_adjust = FALSE

/obj/item/clothing/under/swimsuit/earth
	name = "earthen swimsuit"
	desc = "A design more popular on Earth these days."
	icon_state = "swim_earth"
	item_state = "swim_earth"
	item_color = "swim_earth"
	can_adjust = FALSE

/obj/item/clothing/under/revealingdress
	name = "Revealing Dress"
	desc = "A blue topped dress with a black bottom. Quite revealing!"
	icon_state = "revealingdress"
	item_state = "revealingdress"
	item_color = "revealingdress"
	can_adjust = FALSE

/obj/item/clothing/under/rippedpunk
	name = "Ripped Punk"
	desc = "A ripped black outfit"
	icon_state = "rippedpunk"
	item_state = "rippedpunk"
	item_color = "rippedpunk"
	can_adjust = FALSE

/obj/item/clothing/under/gothic_dress_virgo
	name = "gothic dress"
	desc = "Hot Topic and stuff."
	icon_state = "gothic"
	item_state = "gothic"
	item_color = "gothic"
	can_adjust = FALSE

/obj/item/clothing/under/fancy_red_formaldress
	name = "Red Formal"
	desc = "blood red and long"
	icon_state = "formalred"
	item_state = "formalred"
	item_color = "formalred"
	can_adjust = FALSE

/obj/item/clothing/under/greenasym
	name = "Green wrapped dress"
	desc = "A green dress that wraps around your form."
	icon_state = "greenasym"
	item_state = "greenasym"
	item_color = "greenasym"
	can_adjust = FALSE

/obj/item/clothing/under/cyberhell
	name = "Cyber Hell"
	desc = "Some sort of dress. Fancy."
	icon_state = "cyberhell"
	item_state = "cyberhell"
	item_color = "cyberhell"
	can_adjust = FALSE

/obj/item/clothing/under/floofdress
	name = "floof dress"
	desc = "A white floofy dress"
	icon_state = "floofdress"
	item_state = "floofdress"
	item_color = "floofdress"
	can_adjust = FALSE

/obj/item/clothing/under/blackngold
	name = "black and gold dress"
	desc = "A fancy dress of black and gold"
	icon_state = "blackngold"
	item_state = "blackngold"
	item_color = "blackngold"
	can_adjust = FALSE

/obj/item/clothing/under/sheerblue
	name = "A sheer blue dress"
	desc = "A pretty blue shimmering dress."
	icon_state = "sheerblue"
	item_state = "sheerblue"
	item_color = "sheerblue"
	can_adjust = FALSE

/obj/item/clothing/under/whitegown
	name = "White Gown"
	desc = "A white gown with black sleeves"
	icon_state = "whitegown"
	item_state = "whitegown"
	item_color = "whitegown"
	can_adjust = FALSE

/obj/item/clothing/under/pinksun
	name = "pink summer dress"
	desc = "A dress!"
	icon_state = "pinksun"
	item_state = "pinksun"
	item_color = "pinksun"
	can_adjust = FALSE

/obj/item/clothing/under/whitesun
	name = "white summer dress"
	desc = "A dress!"
	icon_state = "whitesun"
	item_state = "whitesun"
	item_color = "whitesun"
	can_adjust = FALSE

/obj/item/clothing/under/bowsun
	name = "pink summer dress with a bow"
	desc = "A dress!"
	icon_state = "bowsun"
	item_state = "bowsun"
	item_color = "bowsun"
	can_adjust = FALSE

/obj/item/clothing/under/bluesun
	name = "blue summer dress"
	desc = "A dress!"
	icon_state = "bluesun"
	item_state = "bluesun"
	item_color = "bluesun"
	can_adjust = FALSE

/obj/item/clothing/under/shortpink
	name = "short pink dress"
	desc = "A dress!"
	icon_state = "shortpink"
	item_state = "shortpink"
	item_color = "shortpink"
	can_adjust = FALSE

/obj/item/clothing/under/twopiece
	name = "A two piece dress"
	desc = "A dress!"
	icon_state = "twopiece"
	item_state = "twopiece"
	item_color = "twopiece"
	can_adjust = FALSE

/obj/item/clothing/under/gothic2
	name = "gothic dress"
	desc = "A dress!"
	icon_state = "gothic2"
	item_state = "gothic2"
	item_color = "gothic2"
	can_adjust = FALSE

/obj/item/clothing/under/wednesday
	name = "Wednesday dress"
	desc = "A dress!"
	icon_state = "wednesday"
	item_state = "wednesday"
	item_color = "wednesday"
	can_adjust = FALSE

/obj/item/clothing/under/gayvampire
	name = "vampire uniform"
	desc = "I want to suck your blood"
	icon_state = "gayvampire"
	item_state = "gayvampire"
	item_color = "gayvampire"
	can_adjust = FALSE

/obj/item/clothing/under/corsetdress
	name = "corset dress"
	desc = "A dress!"
	icon_state = "corsetdress"
	item_state = "corsetdress"
	item_color = "corsetdress"
	can_adjust = FALSE

/obj/item/clothing/under/goldwrap
	name = "golden wrap"
	desc = "A dress!"
	icon_state = "goldwrap"
	item_state = "goldwrap"
	item_color = "goldwrap"
	can_adjust = FALSE

/obj/item/clothing/under/golddress
	name = "golden dress"
	desc = "A dress!"
	icon_state = "golddress"
	item_state = "golddress"
	item_color = "golddress"
	can_adjust = FALSE

/obj/item/clothing/under/countess
	name = "countess dress"
	desc = "A dress!"
	icon_state = "countess"
	item_state = "countess"
	item_color = "countess"
	can_adjust = FALSE

/obj/item/clothing/under/skyrat/maid
	name = "maid dress"
	desc = "Clean those windows! Dust the floors!"
	icon_state = "maid_skyrat"
	item_state = "maid_skyrat"
	item_color = "maid_skyrat"
	can_adjust = FALSE

/obj/item/clothing/under/skyrat/flower_kimono
	name = "Kimono"
	desc = "Somehow you feel like a weeb in this."
	icon_state = "flower_kimono"
	item_state = "flower_kimono"
	item_color = "flower_kimono"
	can_adjust = FALSE

/obj/item/clothing/under/hawi/orange
	name = "orange hawaiian"
	desc = "Surfs up!"
	icon_state = "tacticool_hawaiian_orange"
	item_state = "tacticool_hawaiian_orange"
	item_color = "tacticool_hawaiian_orange"
	can_adjust = FALSE

/obj/item/clothing/under/hawi/blue
	name = "blue hawaiian"
	desc = "Surfs up!"
	icon_state = "tacticool_hawaiian_blue"
	item_state = "tacticool_hawaiian_blue"
	item_color = "tacticool_hawaiian_blue"
	can_adjust = FALSE

/obj/item/clothing/under/hawi/purple
	name = "purple hawaiian"
	desc = "Surfs up!"
	icon_state = "tacticool_hawaiian_purple"
	item_state = "tacticool_hawaiian_purple"
	item_color = "tacticool_hawaiian_purple"
	can_adjust = FALSE

/obj/item/clothing/under/hawi/green
	name = "green hawaiian"
	desc = "Surfs up!"
	icon_state = "tacticool_hawaiian_green"
	item_state = "tacticool_hawaiian_green"
	item_color = "tacticool_hawaiian_green"
	can_adjust = FALSE

/obj/item/clothing/under/civ/toxotai
	name = "Robe with black belt"
	icon_state = "toxotai"
	item_state = "toxotai"
	item_color = "toxotai"
	can_adjust = FALSE

/obj/item/clothing/under/civ/thebes
	name = "blue swamp hoplite"
	icon_state = "thebes"
	item_state = "thebes"
	item_color = "thebes"
	can_adjust = FALSE

/obj/item/clothing/under/civ/corinthia
	name = "green swamp hoplite"
	icon_state = "corinthia"
	item_state = "corinthia"
	item_color = "corinthia"
	can_adjust = FALSE

/obj/item/clothing/under/civ/greek_commander
	name = "swamp hoplite commander"
	icon_state = "greek_commander"
	item_state = "greek_commander"
	item_color = "greek_commander"
	can_adjust = FALSE

/obj/item/clothing/under/civ/athens
	name = "dark blue swamp hoplite"
	icon_state = "athens"
	item_state = "athens"
	item_color = "athens"
	can_adjust = FALSE

/obj/item/clothing/under/civ/roman_centurion
	name = "robe with red belt"
	icon_state = "roman_centurion"
	item_state = "roman_centurion"
	item_color = "roman_centurion"
	can_adjust = FALSE

/obj/item/clothing/under/japanese_uniform
	name = "Green uniform"
	desc = "A green uniform. Camo!"
	icon_state = "japan_uniform"
	item_state = "japan_uniform"
	item_color = "japan_uniform"
	can_adjust = FALSE

//Lucine's Sprites

/obj/item/clothing/under/gorka_alt
	name = "Gorka outfit"
	desc = "It's a uniform I guess."
	icon_state = "gorka_alt"
	item_state = "gorka_alt"
	item_color = "gorka_alt"
	can_adjust = FALSE

/obj/item/clothing/under/gorka_ss
	name = "Alt Gorka outfit"
	desc = "It's a uniform I guess."
	icon_state = "gorka_ss"
	item_state = "gorka_ss"
	item_color = "gorka_ss"
	can_adjust = FALSE

/obj/item/clothing/under/gorka_tan
	name = "Tan Gorka outfit"
	desc = "It's a uniform I guess."
	icon_state = "gorka_tan"
	item_state = "gorka_tan"
	item_color = "gorka_tan"
	can_adjust = FALSE

/obj/item/clothing/under/puffy
	name = "puffy dress"
	desc = "A pink and puffy dress!"
	icon_state = "puffydress"
	item_state = "puffydress"
	item_color = "puffydress"
	can_adjust = FALSE

/obj/item/clothing/under/labor_black
	name = "black labor suit"
	desc = "A slim fitting black suit"
	icon_state = "labor_black"
	item_state = "labor_black"
	item_color = "labor_black"
	can_adjust = FALSE

/obj/item/clothing/under/divine_robes
	name = "divine robes"
	desc = "Rather holy robes."
	icon_state = "divine_robes"
	item_state = "divine_robes"
	item_color = "divine_robes"
	can_adjust = FALSE

/obj/item/clothing/under/blue_kimono
	name = "Dark blue Kimono"
	desc = "A dark blue kimono."
	icon_state = "blue_kimono"
	item_state = "blue_kimono"
	item_color = "blue_kimono"
	can_adjust = FALSE

/obj/item/clothing/under/miku_bikini
	name = "Blue bikini"
	desc = "A light blue bikini with a red bow!"
	icon_state = "miku_bikini"
	item_state = "miku_bikini"
	item_color = "miku_bikini"
	can_adjust = FALSE

/obj/item/clothing/under/shark
	name = "shark uniform"
	desc = "A skimpy light grey uniform. The same color as a shark!"
	icon_state = "shark_cloth"
	item_state = "shark_cloth"
	item_color = "shark_cloth"
	can_adjust = FALSE

/obj/item/clothing/under/tribal_colorful
	name = "bright outfit"
	desc = "A skimply outfit with bright colors."
	icon_state = "tribal_colorful"
	item_state = "tribal_colorful"
	item_color = "tribal_colorful"
	can_adjust = FALSE

/obj/item/clothing/under/tribal_colorful/top
	name = "bright outfit top"
	desc = "A skimply outfit with bright colors, just the top not the skirt included!"
	icon_state = "tribal_colorful_top"
	item_state = "tribal_colorful_top"
	item_color = "tribal_colorful_top"
	can_adjust = FALSE

/obj/item/clothing/under/flow_dress/green
	name = "green flow dress"
	desc = "A soft looking dress, green in color."
	icon_state = "flow_green"
	item_state = "flow_green"
	item_color = "flow_green"
	can_adjust = FALSE

/obj/item/clothing/under/flow_dress/red
	name = "red flow dress"
	desc = "A soft looking dress, red in color."
	icon_state = "flow_red"
	item_state = "flow_red"
	item_color = "flow_red"
	can_adjust = FALSE

/obj/item/clothing/under/desert_uniform
	name = "desert uniform"
	desc = "A desert uniform used by commonwealth nations"
	icon_state = "desert_uniform"
	item_state = "desert_uniform"
	item_color = "desert_uniform"
	can_adjust = FALSE

/obj/item/clothing/under/shrine_maiden
	name = "shrine maiden"
	desc = "A tradional dress for shrine maidens to wear"
	icon_state = "shrine_maiden"
	item_state = "shrine_maiden"
	item_color = "shrine_maiden"
	can_adjust = FALSE

/obj/item/clothing/under/striped_clown
	name = "striped clown overalls"
	desc = "Honk honk! Oh wait you don't know clown? It's a clown uniform of course!"
	icon_state = "striped_clown"
	item_state = "striped_clown"
	item_color = "striped_clown"
	can_adjust = FALSE

/obj/item/clothing/under/engineer_alt
	name = "engineering jumpsuit"
	desc = "A skin tight jumpsuit in bright orange (or is it red?) and yellow."
	icon_state = "engine_alt"
	item_state = "engine_alt"
	item_color = "engine_alt"
	mutantrace_variation = STYLE_DIGITIGRADE
	can_adjust = TRUE
	armor_tokens = list(ARMOR_MODIFIER_UP_ENV_T1)

/obj/item/clothing/under/witchfinder
	name = "witch finder"
	desc = "A dark style uniform."
	icon_state = "witchfinder"
	item_state = "witchfinder"
	item_color = "witchfinder"
	can_adjust = FALSE

/obj/item/clothing/under/jester_muli
	name = "Jester"
	desc = "A dark, yet multicolored, jester outfit."
	icon_state = "jester_muli"
	item_state = "jester_muli"
	item_color = "jester_muli"
	can_adjust = FALSE

/obj/item/clothing/under/greek_dress
	name = "Greek Dress"
	desc = "Make sure this dress doesn't creak."
	icon_state = "greek_dress"
	item_state = "greek_dress"
	item_color = "greek_dress"
	can_adjust = TRUE

/obj/item/clothing/under/loincloth
	name = "grassy loincloth"
	desc = "Yep, that sure hardly covers anything."
	icon_state = "loincloth"
	item_state = "loincloth"
	item_color = "loincloth"
	can_adjust = FALSE
	w_class = WEIGHT_CLASS_SMALL

// Bayou Stuff - started by Kelprunner

/obj/item/clothing/under/tactiflannel
	name = "mercenary flannel"
	desc = "A pair of Tiger Stripe or Woodland camoflagued fatigue pants paired with a red flannel shirt. It looks a little worn."
	icon_state = "tactiflannel"
	item_state = "tactiflannel"
	item_color = "tactiflannel"
	can_adjust = TRUE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/frogsuit // nuh uh
	name = "frogsuit"
	desc = "A suit designed for sneaking and dynamic entry. Has tacticool straps for keeping additional armor snug to the body."
	icon_state = "rachel_frogsuit"
	item_state = "rachel_frogsuit"
	item_color = "rachel_frogsuit"
	can_adjust = FALSE

/obj/item/clothing/under/qipaonosleeve
	name = "black qipao no sleeve"
	desc = "A fancy outfit with no sleeves"
	icon_state = "qipao_nosleeve"
	item_state = "qipao_nosleeve"
	item_color = "qipao_nosleeve"
	can_adjust = FALSE

/obj/item/clothing/under/qipaonosleevewhite
	name = "white qipao no sleeve"
	desc = "A fancy outfit with no sleeves"
	icon_state = "qipao_white_nosleeve"
	item_state = "qipao_white_nosleeve"
	item_color = "qipao_white_nosleeve"
	can_adjust = FALSE

/obj/item/clothing/under/qipaonosleevered
	name = "red qipao no sleeve"
	desc = "A fancy outfit with no sleeves"
	icon_state = "qipao_red_nosleeve"
	item_state = "qipao_red_nosleeve"
	item_color = "qipao_red_nosleeve"
	can_adjust = FALSE

/obj/item/clothing/under/qipaonosleeveteal
	name = "teal qipao no sleeve"
	desc = "A fancy outfit with no sleeves"
	icon_state = "qipao_teal_nosleeve"
	item_state = "qipao_teal_nosleeve"
	item_color = "qipao_teal_nosleeve"
	can_adjust = FALSE

/obj/item/clothing/under/dress/coyote/jute
	name = "jute dress"
	desc = "A brown adjustable dress."
	icon_state = "jute"
	item_state = "jute"
	item_color = "jute"
	can_adjust = TRUE

/obj/item/clothing/under/dress/coyote/striped_skirt
	name = "striped skirt dress"
	desc = "A red and striped adjustable dress."
	icon_state = "striped_skirt"
	item_state = "striped_skirt"
	item_color = "striped_skirt"
	can_adjust = TRUE

/obj/item/clothing/under/dress/coyote/red_skirt
	name = "red skirt dress"
	desc = "A red adjustable dress."
	icon_state = "red_skirt"
	item_state = "red_skirt"
	item_color = "red_skirt"
	can_adjust = TRUE

/obj/item/clothing/under/dress/coyote/black_skirt
	name = "black skirt dress"
	desc = "A black adjustable dress."
	icon_state = "black_skirt"
	item_state = "black_skirt"
	item_color = "black_skirt"
	can_adjust = TRUE
// Notes below are for kuddles or anyone else that wants to learn. Love, peace, chicken grease! - Jaeger
/obj/item/clothing/under/kuddles // In detail, this is an object, an item, a piece of clothing, a specific type of clothing, and the type of the type of clothing. This line here is the whole "obj(ect) path". You can go further in the layers by using a / and continuing.
	name = "racc flannel" // The name of the object.
	desc = "A nonexistent racc flannel. Sick as hell if you ask me." // Description.
	icon_state = null // You put the mob state (the name of the icon in icon/mob) here.
	item_state = null // You put the item state (the name of the icon in icons/obj) here.
	item_color = null // If it already has colors in the sprite, throw a null here. Otherwise, look at something like scarf code over at `/obj/item/clothing/neck/scarf/red`.
	can_adjust = FALSE // If you have alt sprites, make sure the sprite sheet knows that and tick this to true.

/obj/item/clothing/under/kuddles/redflannel // This "subobject" shares the same variables as the "object" a layer above it, but the difference is that we can edit them on layers below without a lot of consequence. This can save us time so we don't have to copy+paste everything.
	name = "Red Flannel"
	desc = "It's a red flannel on jeans. How quaint can it get?"
	icon_state = "redflannel"
	item_state = "redflannel" // You've mastered the basics of CQC! (Clothing Qoding Content)

/obj/item/clothing/under/kuddles/blueflannel
	name = "Blue Flannel"
	desc = "It's a blue flannel on jeans. How quaint can it get?"
	icon_state = "blueflannel"
	item_state = "blueflannel"

/obj/item/clothing/under/kuddles/whiteflannel
	name = "White Flannel"
	desc = "It's a white flannel on jeans. How quaint can it get?"
	icon_state = "whiteflannel"
	item_state = "whiteflannel"

/obj/item/clothing/under/kuddles/tealflannel
	name = "Teal Flannel"
	desc = "It's a teal flannel on jeans. How quaint can it get?"
	icon_state = "tealflannel"
	item_state = "tealflannel"

/obj/item/clothing/under/kuddles/pinkflannel
	name = "Pink Flannel"
	desc = "It's a pink flannel on jeans. How quaint can it get?"
	icon_state = "pinkflannel"
	item_state = "pinkflannel"

/obj/item/clothing/under/kuddles/purpleflannel
	name = "Purple Flannel"
	desc = "It's a purple flannel on jeans. How quaint can it get?"
	icon_state = "purpleflannel"
	item_state = "purpleflannel"

/obj/item/clothing/under/kuddles/yellowflannel
	name = "Yellow Flannel"
	desc = "It's a yellow flannel on jeans. How quaint can it get?"
	icon_state = "yellowflannel"
	item_state = "yellowflannel"

/obj/item/clothing/under/kuddles/orangeflannel
	name = "Orange Flannel"
	desc = "It's an orange flannel on jeans. How quaint can it get?"
	icon_state = "orangeflannel"
	item_state = "orangeflannel"

/obj/item/clothing/under/kuddles/greenflannel
	name = "Green Flannel"
	desc = "It's a green flannel on jeans. How quaint can it get?"
	icon_state = "greenflannel"
	item_state = "greenflannel"

/obj/item/clothing/under/kuddles/rattyskirtgreen
	name = "Ratty Skirt"
	desc = "A colored skirt with a undershirt and jacket. The skirt has holes that remind you of pest damage."
	icon_state = "rattyskirtgreen"
	item_state = "rattyskirtgreen"

/obj/item/clothing/under/kuddles/rattyskirtyellow
	name = "Ratty Skirt"
	desc = "A colored skirt with a undershirt and jacket. The skirt has holes that remind you of pest damage."
	icon_state = "rattyskirtyellow"
	item_state = "rattyskirtyellow"

/obj/item/clothing/under/kuddles/rattyskirtpink
	name = "Ratty Skirt"
	desc = "A colored skirt with a undershirt and jacket. The skirt has holes that remind you of pest damage."
	icon_state = "rattyskirtpink"
	item_state = "rattyskirtpink"

/obj/item/clothing/under/kuddles/rattyskirtcyberpunk
	name = "Ratty Skirt"
	desc = "A colored skirt with a undershirt and jacket. The skirt has holes that remind you of pest damage."
	icon_state = "rattyskirtcyberpunk"
	item_state = "rattyskirtcyberpunk"

/obj/item/clothing/under/kuddles/brownpunkpants
	name = "Brown Punk Pants"
	desc = "A pair punk pants. Looks cute, but I wouldn't tell the wearer."
	icon_state = "brownpunkpants"
	item_state = "brownpunkpants"

/obj/item/clothing/under/kuddles/olivecargopunk
	name = "OD Cargopunk Pants"
	desc = "A pair of OD green cargopunk cargopants. Never enough pockets..."
	icon_state = "olivecargopunk"
	item_state = "olivecargopunk"

/obj/item/clothing/under/tribalcustom
	name = "tribal leaf dress"
	desc = "A dress mostly made of leafs and vines."
	icon_state = "tribal_custom"
	item_state = "tribal_custom"
	item_color = "tribal_custom"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/tribaliris
	name = "tribal loincloth"
	desc = "A dress mostly made of what looks like a mixmatch of a loincloth and a swimsuit."
	icon_state = "iris_tribal"
	item_state = "iris_tribal"
	item_color = "iris_tribal"
	can_adjust = FALSE
	mutantrace_variation = STYLE_DIGITIGRADE

/obj/item/clothing/under/sun_skirt
	name = "sun skirt, green"
	desc = "A middrif skirt that's colored in forest green."
	icon_state = "sun_skirt"
	item_state = "sun_skirt"
	item_color = "sun_skirt"
	can_adjust = FALSE

/obj/item/clothing/under/sun_skirt_grey
	name = "sun skirt, grey scaled"
	desc = "A middrif skirt that's colorable."
	icon_state = "sun_skirt_grey"
	item_state = "sun_skirt_grey"
	item_color = "sun_skirt_grey"
	can_adjust = FALSE

/obj/item/clothing/under/half_skirt
	name = "flowy midrif skirt"
	desc = "A middrif skirt that's blue."
	icon_state = "half_skirt"
	item_state = "half_skirt"
	item_color = "half_skirt"
	can_adjust = FALSE

/obj/item/clothing/under/poofygreen
	name = "green poof"
	desc = "A green poofy skirt with not much to hide chest wise."
	icon = 'icons/obj/clothing/dress.dmi'
	mob_overlay_icon = 'icons/mob/clothing/dress.dmi'
	icon_state = "petal_custom"
	item_state = "petal_custom"
	item_color = "petal_custom"
	body_parts_covered = CHEST|GROIN|ARMS
	can_adjust = FALSE




