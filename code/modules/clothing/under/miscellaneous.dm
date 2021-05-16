/obj/item/clothing/under/misc/pj/red
	name = "red pj's"
	desc = "Sleepwear."
	icon_state = "red_pyjamas"
	item_state = "w_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/pj/blue
	name = "blue pj's"
	desc = "Sleepwear."
	icon_state = "blue_pyjamas"
	item_state = "w_suit"
	can_adjust = FALSE

/obj/item/clothing/under/misc/patriotsuit
	name = "Patriotic Suit"
	desc = "Motorcycle not included."
	icon_state = "ek"
	item_state = "ek"
	can_adjust = FALSE

/obj/item/clothing/under/rank/prisoner
	name = "prison jumpsuit"
	desc = "It's standardised Nanotrasen prisoner-wear. Its suit sensors are stuck in the \"Fully On\" position."
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
	desc = "Perfect camouflage for hiding in botany."
	icon_state = "scarecrow"
	item_state = "scarecrow"
	item_color = "scarecrow"
	body_parts_covered = CHEST|GROIN|ARMS|LEGS
	fitted = NO_FEMALE_UNIFORM
	can_adjust = FALSE
	resistance_flags = NONE

/obj/item/clothing/under/jester
	name = "jester suit"
	desc = "A jolly dress, well suited to entertain your master, nuncle."
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
	desc = "Traditional burial garments from the early 22nd century."
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
	desc = "It's standardised Nanotrasen prisoner-wear. Its suit sensors are stuck in the \"Fully On\" position."
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
	desc = "It's the standard issue pretty-boy outfit, as seen on Holo-Vision."
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

/obj/item/clothing/under/misc/burial
	name = "burial garments"
	desc = "Traditional burial garments from the early 22nd century."
	icon_state = "burial"
	item_state = "burial"
	has_sensor = NO_SENSORS

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
	name = "plasma envirosuit"
	desc = "A special containment suit that allows plasma-based lifeforms to exist safely in an oxygenated environment, and automatically extinguishes them in a crisis. Despite being airtight, it's not spaceworthy."
	icon_state = "plasmaman"
	item_state = "plasmaman"
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 100, "rad" = 0, "fire" = 95, "acid" = 95)
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	mutantrace_variation = USE_TAUR_CLIP_MASK
	can_adjust = FALSE
	strip_delay = 80
	var/next_extinguish = 0
	var/extinguish_cooldown = 100
	var/extinguishes_left = 5

/obj/item/clothing/under/plasmaman/examine(mob/user)
	. = ..()
	. += "<span class='notice'>There are [extinguishes_left] extinguisher charges left in this suit.</span>"

/obj/item/clothing/under/plasmaman/proc/Extinguish(mob/living/carbon/human/H)
	if(!istype(H))
		return
	if(H.on_fire)
		if(extinguishes_left)
			if(next_extinguish > world.time)
				return
			next_extinguish = world.time + extinguish_cooldown
			extinguishes_left--
			H.visible_message("<span class='warning'>[H]'s suit automatically extinguishes [H.p_them()]!</span>","<span class='warning'>Your suit automatically extinguishes you.</span>")
			H.ExtinguishMob()
			new /obj/effect/particle_effect/water(get_turf(H))
	return 0

/obj/item/clothing/under/plasmaman/attackby(obj/item/E, mob/user, params)
	..()
	if (istype(E, /obj/item/extinguisher_refill))
		if (extinguishes_left == 5)
			to_chat(user, "<span class='notice'>The inbuilt extinguisher is full.</span>")
			return
		else
			extinguishes_left = 5
			to_chat(user, "<span class='notice'>You refill the suit's built-in extinguisher, using up the cartridge.</span>")
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
	body_parts_covered = CHEST|GROIN
	can_adjust = FALSE

/obj/item/clothing/under/misc/durathread
	name = "durathread jumpsuit"
	desc = "A jumpsuit made from durathread, its resilient fibres provide some protection to the wearer."
	icon_state = "durathread"
	item_state = "durathread"
	can_adjust = TRUE
	armor = list("melee" = 10, "laser" = 10, "fire" = 40, "acid" = 10, "bomb" = 5)

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
	desc = "A small black dress"
	icon_state = "littleblackdress_s"
	item_state = "littleblackdress_s"

/obj/item/clothing/under/misc/pinktutu
	name = "pink tutu"
	desc = "A pink tutu"
	icon_state = "pinktutu_s"
	item_state = "pinktutu_s"

/obj/item/clothing/under/misc/bathrobe
	name = "bathrobe"
	desc = "A blue bathrobe."
	icon_state = "bathrobe"
	item_state = "bathrobe"

/obj/item/clothing/under/misc/mechsuitred
	name = "red mech suit"
	desc = "What are you, stupid?"
	icon_state = "red_mech_suit"
	item_state = "red_mech_suit"

/obj/item/clothing/under/misc/mechsuitwhite
	name = "white mech suit"
	desc = "...Mom?"
	icon_state = "white_mech_suit"
	item_state = "white_mech_suit"

/obj/item/clothing/under/misc/mechsuitblue
	name = "blue mech suit"
	desc = "Get in the damn robot already!"
	icon_state = "blue_mech_suit"
	item_state = "blue_mech_suit"

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
