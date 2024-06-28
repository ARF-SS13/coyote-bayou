/*
 * Contents:
 *		Welding mask
 *		Cakehat
 *		Ushanka
 *		Pumpkin head
 *		Kitty ears
 *		Cardborg disguise
 *		Wig
 *		Bronze hat
 */

/*
 * Welding mask
 */
/obj/item/clothing/head/welding
	name = "welding helmet"
	desc = "A head-mounted face cover designed to protect the wearer completely from space-arc eye."
	icon_state = "welding"
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	item_state = "welding"
	w_class = WEIGHT_CLASS_NORMAL //needs a disadvantage over welding goggles
	custom_materials = list(/datum/material/iron=1750, /datum/material/glass=400)
	flash_protect = 2
	tint = 2
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	resistance_flags = FIRE_PROOF
	mutantrace_variation = STYLE_MUZZLE

/obj/item/clothing/head/welding/attack_self(mob/user)
	weldingvisortoggle(user)

/*
 * Cakehat
 */
/obj/item/clothing/head/hardhat/cakehat
	name = "cakehat"
	desc = "You put the cake on your head. Brilliant."
	icon_state = "hardhat0_cakehat"
	item_state = "hardhat0_cakehat"
	hat_type = "cakehat"
	hitsound = 'sound/weapons/tap.ogg'
	flags_inv = HIDEEARS|HIDEHAIR
	light_system = MOVABLE_LIGHT
	light_range = 2 //luminosity when on
	flags_cover = HEADCOVERSEYES
	heat = 1000
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	beepsky_fashion = /datum/beepsky_fashion/cake

/obj/item/clothing/head/hardhat/cakehat/process()
	var/turf/location = src.loc
	if(ishuman(location))
		var/mob/living/carbon/human/M = location
		if(M.is_holding(src) || M.head == src)
			location = M.loc

	if(isturf(location))
		location.hotspot_expose(700, 1)

/obj/item/clothing/head/hardhat/cakehat/turn_on()
	. = ..()
	force = 15
	throwforce = 15
	damtype = BURN
	hitsound = 'sound/items/welder.ogg'
	START_PROCESSING(SSobj, src)

/obj/item/clothing/head/hardhat/cakehat/turn_off()
	. = ..()
	force = 0
	throwforce = 0
	damtype = BRUTE
	hitsound = 'sound/weapons/tap.ogg'
	STOP_PROCESSING(SSobj, src)

/obj/item/clothing/head/hardhat/cakehat/get_temperature()
	return light_on * heat
/*
 * Ushanka
 */
/obj/item/clothing/head/ushanka
	name = "ushanka"
	desc = "Perfect for winter in Siberia, da?"
	icon_state = "ushankadown"
	item_state = "ushankadown"
	alternate_screams = list('sound/voice/human/cyka1.ogg', 'sound/voice/human/cheekibreeki.ogg')
	flags_inv = HIDEEARS|HIDEHAIR
	var/earflaps = 1
	cold_protection = HEAD
	min_cold_protection_temperature = FIRE_HELM_MIN_TEMP_PROTECT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/ushanka

/obj/item/clothing/head/ushanka/attack_self(mob/user)
	if(earflaps)
		src.icon_state = "ushankaup"
		src.item_state = "ushankaup"
		earflaps = 0
		to_chat(user, span_notice("You raise the ear flaps on the ushanka."))
	else
		src.icon_state = "ushankadown"
		src.item_state = "ushankadown"
		earflaps = 1
		to_chat(user, span_notice("You lower the ear flaps on the ushanka."))

/*
 * Pumpkin head
 */
/obj/item/clothing/head/hardhat/pumpkinhead
	name = "carved pumpkin"
	desc = "A jack o' lantern! Believed to ward off evil spirits."
	icon_state = "hardhat0_pumpkin"
	item_state = "hardhat0_pumpkin"
	hat_type = "pumpkin"
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	light_system = MOVABLE_LIGHT
	light_range = 2
	flags_cover = HEADCOVERSEYES
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/hardhat/pumpkinhead/blumpkin
	name = "carved blumpkin"
	desc = "A very blue jack o' lantern! Believed to ward off vengeful chemists."
	icon_state = "hardhat0_blumpkin"
	item_state = "hardhat0_blumpkin"
	hat_type = "blumpkin"
	light_color = "#76ff8e"

/*
 * Kitty ears
 */
/obj/item/clothing/head/kitty
	name = "kitty ears"
	desc = "A pair of kitty ears. Meow!"
	icon_state = "kitty"
	color = "#999999"
	dynamic_hair_suffix = ""

	dog_fashion = /datum/dog_fashion/head/kitty
	beepsky_fashion = /datum/beepsky_fashion/cat

/obj/item/clothing/head/kitty/equipped(mob/living/carbon/human/user, slot)
	if(ishuman(user) && slot == SLOT_HEAD)
		update_icon(user)
		user.update_inv_head() //Color might have been changed by update_icon.
	..()

/obj/item/clothing/head/kitty/update_icon(mob/living/carbon/human/user)
	if(ishuman(user))
		add_atom_colour("#[user.hair_color]", FIXED_COLOUR_PRIORITY)

/obj/item/clothing/head/kitty/genuine
	desc = "A pair of kitty ears. A tag on the inside says \"Hand made from real cats.\""


/obj/item/clothing/head/hardhat/reindeer
	name = "novelty reindeer hat"
	desc = "Some fake antlers and a very fake red nose."
	icon_state = "hardhat0_reindeer"
	item_state = "hardhat0_reindeer"
	hat_type = "reindeer"
	flags_inv = 0
	light_system = MOVABLE_LIGHT
	light_range = 1
	dynamic_hair_suffix = ""
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/reindeer

/obj/item/clothing/head/cardborg
	name = "cardborg helmet"
	desc = "A helmet made out of a box."
	icon_state = "cardborg_h"
	item_state = "cardborg_h"
	flags_cover = HEADCOVERSEYES
	alternate_screams = list('modular_citadel/sound/voice/scream_silicon.ogg')
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

	dog_fashion = /datum/dog_fashion/head/cardborg

/obj/item/clothing/head/cardborg/equipped(mob/living/user, slot)
	..()
	if(ishuman(user) && slot == SLOT_HEAD)
		var/mob/living/carbon/human/H = user
		if(istype(H.wear_suit, /obj/item/clothing/suit/cardborg))
			var/obj/item/clothing/suit/cardborg/CB = H.wear_suit
			CB.disguise(user, src)

/obj/item/clothing/head/cardborg/dropped(mob/living/user)
	..()
	user.remove_alt_appearance("standard_borg_disguise")


/obj/item/clothing/head/welding/weldingfire
	icon_state = "weldingfire"
	item_state = "weldingfire"

/obj/item/clothing/head/welding/weldingjapan
	icon_state = "weldingjapan"
	item_state = "weldingjapan"

/obj/item/clothing/head/wig
	name = "wig"
	desc = "A bunch of hair without a head attached."
	icon = 'icons/mob/hair.dmi'	  // default icon for all hairs
	icon_state = "hair_vlong"
	flags_inv = HIDEHAIR
	color = "#000"
	var/hair_style = "Very Long Hair"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/wig/Initialize(mapload)
	. = ..()
	icon_state = "" //Shitty hack that i dont know if it is even neccesary to deal with the vendor stack exception
	update_icon()

/obj/item/clothing/head/wig/update_icon_state()
	var/datum/sprite_accessory/S = GLOB.hair_styles_list[hair_style]
	if(!S)
		icon = 'icons/obj/clothing/hats.dmi'
		icon_state = "pwig"
	else
		icon = S.icon
		icon_state = S.icon_state

/obj/item/clothing/head/wig/worn_overlays(isinhands = FALSE, icon_file, used_state, style_flags = NONE)
	. = ..()
	if(!isinhands)
		var/datum/sprite_accessory/S = GLOB.hair_styles_list[hair_style]
		if(!S)
			return
		var/mutable_appearance/M = mutable_appearance(S.icon, S.icon_state,layer = -HAIR_LAYER)
		M.appearance_flags |= RESET_COLOR
		M.color = color
		. += M

/obj/item/clothing/head/wig/random/Initialize(mapload)
	hair_style = pick(GLOB.hair_styles_list - "Bald") //Don't want invisible wig
	color = "#[random_short_color()]"
	. = ..()

/obj/item/clothing/head/bronze
	name = "bronze hat"
	desc = "A crude helmet made out of bronze plates. It offers very little in the way of protection."
	icon = 'icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_helmet_old"
	flags_inv = HIDEEARS|HIDEHAIR
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/foilhat
	name = "tinfoil hat"
	desc = "Thought control rays, psychotronic scanning. Don't mind that, I'm protected cause I made this hat."
	icon_state = "foilhat"
	item_state = "foilhat"
	equip_delay_other = 140
	var/datum/brain_trauma/mild/phobia/conspiracies/paranoia
	var/warped = FALSE
	clothing_flags = IGNORE_HAT_TOSS

/obj/item/clothing/head/foilhat/Initialize(mapload)
	. = ..()
	if(!warped)
		AddComponent(/datum/component/anti_magic, FALSE, FALSE, TRUE, INV_SLOTBIT_HEAD, 6, TRUE, null, CALLBACK(src,PROC_REF(warp_up)))
	else
		warp_up()

/obj/item/clothing/head/foilhat/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(slot != SLOT_HEAD || warped)
		return
	if(ishuman(user))
		if(paranoia)
			QDEL_NULL(paranoia)
		paranoia = new()
		paranoia.clonable = FALSE
		user.gain_trauma(paranoia, TRAUMA_RESILIENCE_MAGIC)
		to_chat(user, span_warning("As you don the foiled hat, an entire world of conspiracy theories and seemingly insane ideas suddenly rush into your mind. What you once thought unbelievable suddenly seems.. undeniable. Everything is connected and nothing happens just by accident. You know too much and now they're out to get you. "))

/obj/item/clothing/head/foilhat/MouseDrop(atom/over_object)
	//God Im sorry
	if(!warped && iscarbon(usr))
		var/mob/living/carbon/C = usr
		if(src == C.head)
			to_chat(C, span_userdanger("Why would you want to take this off? Do you want them to get into your mind?!"))
			return
	return ..()

/obj/item/clothing/head/foilhat/dropped(mob/user)
	. = ..()
	if(paranoia)
		QDEL_NULL(paranoia)

/obj/item/clothing/head/foilhat/proc/warp_up()
	name = "scorched tinfoil hat"
	desc = "A badly warped up hat. Quite unprobable this will still work against any of fictional and contemporary dangers it used to."
	warped = TRUE
	if(!isliving(loc) || !paranoia)
		return
	var/mob/living/target = loc
	if(target.get_item_by_slot(SLOT_HEAD) != src)
		return
	QDEL_NULL(paranoia)
	if(!target.IsUnconscious())
		to_chat(target, span_warning("Your zealous conspirationism rapidly dissipates as the donned hat warps up into a ruined mess. All those theories starting to sound like nothing but a ridicolous fanfare."))

/obj/item/clothing/head/foilhat/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(!warped && iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.head)
			to_chat(user, span_userdanger("Why would you want to take this off? Do you want them to get into your mind?!"))
			return
	return ..()

/obj/item/clothing/head/foilhat/microwave_act(obj/machinery/microwave/M)
	. = ..()
	if(!warped)
		warp_up()

/obj/item/clothing/head/flakhelm	//Actually the M1 Helmet
	name = "flak helmet"
	desc = "A dilapidated helmet, obsolete even by pre-war standards. An ace of spades is tucked into the band around the outer shell."
	icon_state = "m1helm"
	item_state = "helmet"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/slouch
	name = "Khaki Slouch Hat"
	desc = "A khaki fur felt hat adopted by the Australian army in the late 1800s, it has a puggaree hat band and has a cattleman esk crease. Was in use as its standard head gear before the bombs fell"
	icon_state = "slouch_khaki"
	item_state = "slouch_khaki"
	can_toggle = 1
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/slouch/attack_self(mob/user)
	if(can_toggle && !user.incapacitated(allow_crit = TRUE))
		up = !up
		icon_state = "[initial(icon_state)][up ? "up" : ""]"
		to_chat(user, "you button \the [src]'s brim [up ? "up" : "down"]")

		user.update_inv_head()
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.head_update(src, forced = 1)

/obj/item/clothing/head/slouch/alt
	name = "Khaki Slouch Hat, Alt"
	desc = "A khaki fur felt hat adopted by the Australian army in the late 1800s, it has a puggaree hat band and has a cattleman esk crease. Was in use as its standard head gear before the bombs fell"
	icon_state = "slouch_khaki_alt"
	item_state = "slouch_khaki_alt"
	can_toggle = 1
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/slouch/alt/attack_self(mob/user)
	if(can_toggle && !user.incapacitated(allow_crit = TRUE))
		up = !up
		icon_state = "[initial(icon_state)][up ? "up" : ""]"
		to_chat(user, "you button \the [src]'s brim [up ? "up" : "down"]")

		user.update_inv_head()
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.head_update(src, forced = 1)

/obj/item/clothing/head/slouch/colorable
	name = "Colorable Slouch Hat"
	desc = "A fur felt hat adopted by the Australian army in the late 1800s, it has a puggaree hat band and has a cattleman esk crease. Was in use as its standard head gear before the bombs fell"
	icon_state = "slouch_colorable"
	item_state = "slouch_colorable"
	can_toggle = 1
	actions_types = list(/datum/action/item_action/toggle)

/obj/item/clothing/head/slouch/colorable/attack_self(mob/user)
	if(can_toggle && !user.incapacitated(allow_crit = TRUE))
		up = !up
		icon_state = "[initial(icon_state)][up ? "up" : ""]"
		to_chat(user, "you button \the [src]'s brim [up ? "up" : "down"]")

		user.update_inv_head()
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			C.head_update(src, forced = 1)


//////////////////////////////////
//Fenis Helmet & Hat-a-polooza///
////////////////////////////////


/obj/item/clothing/head/coyote
	name = "Coyote Tophat"
	desc = "A tophat made of coyote fur, weird."
	mob_overlay_icon = 'modular_coyote/icons/objects/head.dmi'
	icon = 'modular_coyote/icons/objects/hats.dmi'
	icon_state = "tophat"
	item_state = "tophat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/yellowtricorne
	name = "Yellow Tricorne"
	desc = "A yellow tricorne hat, it conjures images of conquistadors and gold."
	icon_state = "tricorne_spanish"
	item_state = "tricorne_spanish"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/whiteandbluetricorne
	name = "White & Blue Tricorne"
	desc = "A white and blue tricorne hat; very dashing mon ami."
	icon_state = "tricorne_french"
	item_state = "tricorne_french"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/orangetricorne
	name = "Orange Tricorne"
	desc = "An odd orange tricorne, something about it reminds you of windmills."
	icon_state = "tricorne_dutch"
	item_state = "tricorne_dutch"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/kerchief
	name = "Kerchief"
	desc = "A light head covering for those with a pale complexion."
	icon_state = "kerchief"
	item_state = "kerchief"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/britishtricorne
	name = "Black Tricorne"
	desc = "An odd black tricorne hat, it smells like earl gray."
	icon_state = "tricorne_british_soldier"
	item_state = "tricorne_british_soldier"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/britishtricornetwo
	name = "Red Tricorne"
	desc = "A red tricorne hat, it has a tag in the back saying 'for king and country.'"
	icon_state = "tricorne_british2"
	item_state = "tricorne_british2"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/chasseur_pt
	name = "Chasseurs Hat - Green Feather"
	desc = "The hat of a man who chases, green feather edition."
	icon_state = "chasseur_pt"
	item_state = "chasseur_pt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/chasseur_nl
	name = "Chasseurs Hat - Pro"
	desc = "The hat of a man who chases professionally, it might give you a complex."
	icon_state = "chasseur_nl"
	item_state = "chasseur_nl"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/chasseur_fr
	name = "Chasseurs Hat - Light Blue Feather"
	desc = "The hat of a man who chases, blue feather edition."
	icon_state = "chasseur_fr"
	item_state = "chasseur_fr"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/chasseur_br
	name = "Chasseurs Hat - Red Feather"
	desc = "The hat of aman who chases, red feather edition."
	icon_state = "chasseur_br"
	item_state = "chasseur_br"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/bearpelt
	name = "Bear Pelt"
	desc = "A bear pelt, keeps you comfy and impresses the cavewomen."
	icon_state = "bearpelt"
	item_state = "bearpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/wolfpelt
	name = "Wolf Pelt"
	desc = "A wolf pelt, keeps you comfy and impresses the cavewomen."
	icon_state = "wolfpelt"
	item_state = "wolfpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/whitewolfpelt
	name = "White Wolf Pelt"
	desc = "The world of darkness could never contain you."
	icon_state = "wolfpelt"
	item_state = "whitewolfpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/knightsimple
	name = "Knights Helmet"
	desc = "A decently made bit of steel to cover your head. For honest work only."
	icon_state = "knight_simple"
	item_state = "knight_simple"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/medievalhelmet1
	name = "Guards Helmet"
	desc = "Wearing this you can't help but want to pick up a spear and guard a gate."
	icon_state = "medieval_helmet1"
	item_state = "medieval_helmet1"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/medievalhelmet2
	name = "Flat Guards Helmet"
	desc = "Wearing this you can't help but want to pick up a spear and guard a gate, but it might make an okay soup bowl too."
	icon_state = "medieval_helmet2"
	item_state = "medieval_helmet2"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/medievalhelmet3
	name = "Guards Helmet with nose guard"
	desc = "You've broken your nose enough times, it's time for this to stop."
	icon_state = "medieval_helmet3"
	item_state = "medieval_helmet3"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/coif
	name = "Chainmail Coif"
	desc = "An honest to god chainmail coif, made by some blacksmith after the fall of the old world."
	icon_state = "coif"
	item_state = "coif"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/coifhelmet
	name = "Chainmail Coif with Helmet"
	desc = "An honest to god chainmail coif, made by some blacksmith after the fall of the old world. You even found a helmet to put on too!"
	icon_state = "coif_helmet"
	item_state = "coif_helmet"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/leatherhelmet
	name = "Leather Helmet"
	desc = "You got a great deal for this, only three silver pieces!"
	icon_state = "leatherhelmet"
	item_state = "leatherhelmet"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/mayanheaddress
	name = "Exotic Headdress"
	desc = "If it was up to you? The lever would be pulled."
	icon_state = "mayan_headdress"
	item_state = "mayan_headdress"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/featheredhat
	name = "Feathered Hat"
	desc = "They told you to stick a feather in your hat, so you did."
	icon_state = "feathered_hat"
	item_state = "feathered_hat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/adrian
	name = "Adrian Helmet"
	desc = "You're pretty sure this is supposed to be a firefighting helmet, but you'd rather play in the mud."
	icon_state = "adrian"
	item_state = "adrian"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/pickelhaube
	name = "Pickelhaube Helmet"
	desc = "Motorcycle not included."
	icon_state = "pickelhaube"
	item_state = "pickelhaube"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/samuraiwarriorone
	name = "Stylish Samurai Helmet"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_warrior1"
	item_state = "samurai_warrior1"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiwarriortwo
	name = "Stylish Samurai Helmet - Blue"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_warrior2"
	item_state = "samurai_warrior2"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/samuraiwarriorthree
	name = "Stylish Samurai Helmet - Brown"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_warrior3"
	item_state = "samurai_warrior3"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiwarriorfour
	name = "Stylish Samurai Helmet - Black"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_warrior4"
	item_state = "samurai_warrior4"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiwarriorfive
	name = "Stylish Samurai Helmet - White"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_warrior5"
	item_state = "samurai_warrior5"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiguard1
	name = "Simple Samurai Helmet - Reddish Brown"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_guard1"
	item_state = "samurai_guard1"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiguard2
	name = "Simple Samurai Helmet - Blue"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_guard2"
	item_state = "samurai_guard2"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiguard3
	name = "Simple Samurai Helmet - Brown"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_guard3"
	item_state = "samurai_guard3"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiguard4
	name = "Simple Samurai Helmet - Black"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_guard4"
	item_state = "samurai_guard4"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/samuraiguard5
	name = "Simple Samurai Helmet - White"
	desc = "Oda Nobunag-on-my-balls."
	icon_state = "samurai_guard5"
	item_state = "samurai_guard5"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet



/obj/item/clothing/head/coyote/lionpelt
	name = "Lion Pelt"
	desc = "It's good to be king."
	icon_state = "lionpelt"
	item_state = "lionpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/foxpelt
	name = "Fox Pelt"
	desc = "The fox doesn't say much anymore."
	icon_state = "foxpelt"
	item_state = "foxpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/whitefoxpelt
	name = "White Fox Pelt"
	desc = "The fox doesn't say much anymore."
	icon_state = "whitefoxpelt"
	item_state = "whitefoxpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/gatorpelt
	name = "Gator Pelt"
	desc = "It's not from a croc, you're sure of it."
	icon_state = "gatorpelt"
	item_state = "gatorpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/blackcape
	name = "Black Cape"
	desc = "You're really not Batman."
	icon_state = "black_cape"
	item_state = "black_cape"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/sheeppelt
	name = "Sheep Pelt"
	desc = "Are you the wolf?"
	icon_state = "sheeppelt"
	item_state = "sheeppelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/goatpelt
	name = "Goat Pelt"
	desc = "Menudo anyone?"
	icon_state = "goatpelt"
	item_state = "goatpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/lizardpelt
	name = "Lizard Pelt"
	desc = "Why is this so crinkly?"
	icon_state = "lizardpelt"
	item_state = "lizardpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/tengallon
	name = "Ten Gallon Hat"
	desc = "A ten gallong hat for a 2 gallon genius."
	icon_state = "ten_gallon_hat_white"
	item_state = "ten_gallon_hat_white"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/cavalier
	name = "Cavalier"
	desc = "You lost a donkey around here somewhere..."
	icon_state = "cavalier"
	item_state = "cavalier"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/bisonpelt
	name = "Bison Pelt"
	desc = "The little horns really sold it to you."
	icon_state = "bisonpelt"
	item_state = "bisonpelt"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet


/obj/item/clothing/head/coyote/raccoonfurhat
	name = "Raccoon Fur Cap"
	desc = "You'll be an American legend yet."
	icon_state = "raccoonfurcap_hat"
	item_state = "raccoonfurcap_hat"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/greek
	name = "Hoplite Helmet"
	desc = "Shade not included."
	icon_state = "greek"
	item_state = "greek"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/greek
	name = "Crested Greek Helmet"
	desc = "Shade included."
	icon_state = "greek_c"
	item_state = "greek_c"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/greekcrested
	name = "Crested Greek Helmet"
	desc = "Shade included."
	icon_state = "greek_c"
	item_state = "greek_c"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/hennin
	name = "Hennin"
	desc = "Doesn't make you a maid, fox or not."
	icon_state = "hennin"
	item_state = "hennin"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/kasa
	name = "Kasa"
	desc = "A coin for a wandering monk?"
	icon_state = "kasa"
	item_state = "kasa"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/jingasa
	name = "Jingasa"
	desc = "Shade in hat form, nice."
	icon_state = "jingasa"
	item_state = "jingasa"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet

/obj/item/clothing/head/coyote/crusaderhelmweak
	name = "Crusader Helmet"
	desc = "A full, closed plate helmet with a cross engraved into it. Deus vult!"
	icon_state = "knight_templar"
	item_state = "knight_templar"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/rushelmet





