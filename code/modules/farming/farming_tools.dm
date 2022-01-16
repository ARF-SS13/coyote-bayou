// In this document: Buckets, Spade, Cultivator, Rake, Hatchet, Wicker basket, Newbie farmer guide

/////////////////////
// FALLOUT BUCKETS //
/////////////////////

/obj/item/reagent_containers/glass/bucket
	name = "bucket"
	desc = "It's a bucket."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "bucket"
	item_state = "bucket"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	custom_materials = list(/datum/material/iron=200)
	w_class = WEIGHT_CLASS_NORMAL
	amount_per_transfer_from_this = 20
	possible_transfer_amounts = list(10,20,30,50,120)
	volume = 120
	flags_inv = HIDEHAIR
	slot_flags = ITEM_SLOT_HEAD
	resistance_flags = NONE
	armor = list("melee" = 10, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 75, "acid" = 50) //Weak melee protection, because you can wear it on your head
	slot_equipment_priority = list( \
		SLOT_BACK, SLOT_WEAR_ID,\
		SLOT_W_UNIFORM, SLOT_WEAR_SUIT,\
		SLOT_WEAR_MASK, SLOT_HEAD, SLOT_NECK,\
		SLOT_SHOES, SLOT_GLOVES,\
		SLOT_EARS, SLOT_GLASSES,\
		SLOT_BELT, SLOT_S_STORE,\
		SLOT_L_STORE, SLOT_R_STORE,\
		SLOT_GENERC_DEXTROUS_STORAGE
	)
	container_flags = APTFT_ALTCLICK|APTFT_VERB
	container_HP = 1

/obj/item/reagent_containers/glass/bucket/attackby(obj/O, mob/user, params)
	if(istype(O, /obj/item/mop))
		if(reagents.total_volume < 1)
			to_chat(user, "<span class='warning'>[src] is out of water!</span>")
		else
			reagents.trans_to(O, 5, log = "reagentcontainer-bucket fill mop")
			to_chat(user, "<span class='notice'>You wet [O] in [src].</span>")
			playsound(loc, 'sound/effects/slosh.ogg', 25, 1)
	else if(isprox(O))
		to_chat(user, "<span class='notice'>You add [O] to [src].</span>")
		qdel(O)
		qdel(src)
		user.put_in_hands(new /obj/item/bot_assembly/cleanbot)
	else
		..()

/obj/item/reagent_containers/glass/bucket/equipped(mob/user, slot)
	..()
	if (slot == SLOT_HEAD)
		if(reagents.total_volume)
			to_chat(user, "<span class='userdanger'>[src]'s contents spill all over you!</span>")
			var/R = reagents.log_list()
			log_reagent("SPLASH: [user] splashed [src] on their head via bucket/equipped(self, SLOT_HEAD) - [R]")
			reagents.reaction(user, TOUCH)
			reagents.clear_reagents()
		reagent_flags = NONE

/obj/item/reagent_containers/glass/bucket/dropped(mob/user)
	. = ..()
	reagent_flags = initial(reagent_flags)

/obj/item/reagent_containers/glass/bucket/equip_to_best_slot(mob/M)
	if(reagents.total_volume) //If there is water in a bucket, don't quick equip it to the head
		var/index = slot_equipment_priority.Find(SLOT_HEAD)
		slot_equipment_priority.Remove(SLOT_HEAD)
		. = ..()
		slot_equipment_priority.Insert(index, SLOT_HEAD)
		return
	return ..()

/obj/item/reagent_containers/glass/bucket/wood
	name = "wooden bucket"
	desc = "It's a bucket made of wood."
	icon_state = "bucket_wooden"
	item_state = "bucket_wooden"
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 2)
	slot_flags = NONE
	item_flags = NO_MAT_REDEMPTION

/obj/item/reagent_containers/glass/bucket/plastic
	name = "plastic bucket"
	desc = "It's a bucket made of blue plastic."
	icon_state = "bucket_plastic"
	item_state = "bucket_plastic"
	custom_materials = list(/datum/material/plastic = MINERAL_MATERIAL_AMOUNT * 1)
	item_flags = NO_MAT_REDEMPTION
	possible_transfer_amounts = list(10,25,50,100,150)
	volume = 150

///////////
// SPADE //
/////////// - slower shovel, but can remove plants without removing the soil too

/obj/item/shovel/spade
	name = "spade"
	desc = "A small tool for digging and removing plant roots."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "spade"
	item_state = "spade"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	toolspeed = 0.5
	force = 5
	throwforce = 7
	custom_materials = list(/datum/material/iron=50)
	w_class = WEIGHT_CLASS_SMALL


////////////////
// CULTIVATOR //
////////////////

/obj/item/cultivator
	name = "cultivator"
	desc = "It's used for removing weeds, stepping on it might hurt."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "cultivator"
	item_state = "cultivator"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	resistance_flags = FLAMMABLE
	flags_1 = CONDUCT_1
	force = 5
	throwforce = 7
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron=50)
	attack_verb = list("slashed", "sliced", "cut", "clawed")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/cultivator/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is scratching [user.p_their()] back as hard as [user.p_they()] can with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)


// ------
// RAKE
// ------

/obj/item/cultivator/rake 
	name = "rake"
	icon_state = "rake"
	item_state = "rake"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	flags_1 = null
	force = 8
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = null


/////////////
// HATCHET //
/////////////

// Hatchet
/obj/item/hatchet
	name = "hatchet"
	desc = "Simple small metal axehead on a handle made from wood or some other hard material."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "hatchet"
	item_state = "hatchet"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	attack_speed = CLICK_CD_MELEE
	flags_1 = CONDUCT_1
	force = 24
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 15
	throw_speed = 3
	throw_range = 4
	custom_materials = list(/datum/material/iron = 6000)
	attack_verb = list("chopped", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED

/obj/item/hatchet/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 70, 100)

/obj/item/hatchet/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is chopping at [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	playsound(src, 'sound/weapons/bladeslice.ogg', 50, 1, -1)
	return (BRUTELOSS)

///////////////////
// WICKER BASKET //
///////////////////

//Wicker Basket (Crate)
/obj/structure/closet/crate/wicker
	name = "basket"
	desc = "A handmade wicker basket."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "basket"
	resistance_flags = FLAMMABLE


////////////////////////////////
// ADVICE FOR FARMING ROOKIES //
////////////////////////////////

// Add stuff to this if you change or discover vital farming stuff (No bloat, just simple, short stuff). If you change how farming works and don't update I curse you.
/obj/item/book/manual/advice_farming
	name = "Advice on Farming from Uncle Bo"
	desc = "A thin book, handwritten after the Great War and copied in various forms many times."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "advice_farming"
	author = "Uncle Bo"
	title = "Advice on Farming - For beginners"
	dat = {"<html>
				<head>
				<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				<style>
				h1 {font-size: 18px; margin: 15px 0px 5px;}
				h2 {font-size: 15px; margin: 15px 0px 5px;}
				li {margin: 2px 0px 2px 15px;}
				ul {list-style: none; margin: 5px; padding: 0px;}
				ol {margin: 5px; padding: 0px 15px;}
				</style>
				</head>
				<body>
				<h3>The basics of farming in the wasteland of today</h3>

				Slowly starving to death? Stop worrying and start working, the earth will provide, even now. First, you need to understand the basics. 
				<p>
				<ol>
				<li>To grow plants reliably you need at minimum, a plot of soil, a rake or cultivator to whack weeds, and a bucket for water and fertilizer. </li>
				<li>For clothing, denim overalls come with a carrying straps for a single rake, shovel or such. Similar straps are used with the leathers hard labor slaves wear.</li>
				<li>Now, buckets hold plenty, some silly wasters use flimsy glass beakers. Don't be one of them, a bucket will hold as much or more. Plastic buckets are the largest, they don't make buckets like they used to. </li>
				<li>Fertilizing from compost: Don't worry about running out. Just stuff in seeds, fruits and vegetables, or food consisting of mostly these things and you will soon have plenty of compost.  </li>
				<li>Fertilizing directly: Stuffing things directly in the dirt gives some nutrition and can have various additonal effects, some harmful to the plants, but using things like toxic waste is one way to mutate plants to other useful strains.
				</ol>
				<p>

				<h3>Making necessary equipment</h3>

				Sooner or later you will need to build some things to help you with tilling the soil. Use your hands and the appropriate material, and you can build the following:
				<p>
				<ol>
				<li>From wood: fermenting barrels, compost bins, growbins, seedbins, rakes, buckets </li>
				<li>From metal: seed extractor. </li>
				<li>From sandstone: drying racks, soil plots, gardening pots. </li>
				<li>From cloth: plant bags. </li>
				<li>From leather: gardeners belt, farmers gloves.</li>
				<li>From hay: wicker baskets.</li>				
				</ol>
				<p>
				From here, you know enough to get started, keep on trying things out and learn from old hands, and soon you will be as fat and content as me.

				</body>
				</html>
				"}


// ------------------------------------
// Scythe - lacks a real purpose in FO
// ------------------------------------

/obj/item/scythe
	name = "scythe"
	desc = "A sharp and curved blade on a long wooden handle, this tool makes it easy to reap what you sow."
	icon = 'icons/fallout/farming/farming_tools.dmi'
	icon_state = "scythe"
	lefthand_file = 'icons/fallout/onmob/tools/farming_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/tools/farming_righthand.dmi'
	force = 15
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	attack_speed = CLICK_CD_MELEE
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	armour_penetration = 0.4
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("chopped", "sliced", "cut", "reaped")
	hitsound = 'sound/weapons/bladeslice.ogg'
	var/swiping = FALSE

/obj/item/scythe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 90, 105)

/obj/item/scythe/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is beheading [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		var/obj/item/bodypart/BP = C.get_bodypart(BODY_ZONE_HEAD)
		if(BP)
			BP.drop_limb()
			playsound(src,pick('sound/misc/desceration-01.ogg','sound/misc/desceration-02.ogg','sound/misc/desceration-01.ogg') ,50, 1, -1)
	return (BRUTELOSS)

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params, attackchain_flags, damage_multiplier)
	. = ..()
	if(. & STOP_ATTACK_PROC_CHAIN)
		return
	if(swiping || !istype(A, /obj/structure/spacevine) || get_turf(A) == get_turf(user))
		return
	else
		var/turf/user_turf = get_turf(user)
		var/dir_to_target = get_dir(user_turf, get_turf(A))
		var/stam_gain = 0
		swiping = TRUE
		var/static/list/scythe_slash_angles = list(0, 45, 90, -45, -90)
		for(var/i in scythe_slash_angles)
			var/turf/T = get_step(user_turf, turn(dir_to_target, i))
			for(var/obj/structure/spacevine/V in T)
				if(user.Adjacent(V))
					melee_attack_chain(user, V, attackchain_flags = ATTACK_IGNORE_CLICKDELAY)
					stam_gain += 5					//should be hitcost
		swiping = FALSE
		stam_gain += 2								//Initial hitcost
		user.adjustStaminaLoss(-stam_gain)
		user.DelayNextAction()
