// In this document: Goat, Chicken, Brahmin, Radstag, Bighorner (also cow but extinct so basically brahmin)

//////////
// GOAT //
//////////

/mob/living/simple_animal/hostile/retaliate/goat
	name = "goat"
	desc = "Not known for their pleasant disposition."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "goat"
	icon_living = "goat"
	icon_dead = "goat_dead"
	speak = list("EHEHEHEHEH","eh?")
	speak_emote = list("brays")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	faction = list("neutral")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_same = 1
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 40
	maxHealth = 40
	melee_damage_lower = 1
	melee_damage_upper = 2
	environment_smash = ENVIRONMENT_SMASH_NONE
	stop_automated_movement_when_pulled = 1
	blood_volume = 480
	var/obj/item/udder/udder = null
	var/datum/reagent/milk_reagent = /datum/reagent/consumable/milk

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/hostile/retaliate/goat/Initialize(/datum/reagent/milk_reagent)
	if(milk_reagent)
		src.milk_reagent = milk_reagent
	udder = new (null, src.milk_reagent)
	. = ..()

/mob/living/simple_animal/hostile/retaliate/goat/Destroy()
	qdel(udder)
	udder = null
	return ..()

/mob/living/simple_animal/hostile/retaliate/goat/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(stat == CONSCIOUS)
		//chance to go crazy and start wacking stuff
		if(!enemies.len && prob(1))
			Retaliate()

		if(enemies.len && prob(10))
			enemies = list()
			LoseTarget()
			src.visible_message("<span class='notice'>[src] calms down.</span>")
		udder.generateMilk(milk_reagent)
		eat_plants()
		if(!pulledby)
			for(var/direction in shuffle(list(1,2,4,8,5,6,9,10)))
				var/step = get_step(src, direction)
				if(step)
					if(locate(/obj/structure/spacevine) in step || locate(/obj/structure/glowshroom) in step)
						Move(step, get_dir(src, step))

/mob/living/simple_animal/hostile/retaliate/goat/Retaliate()
	..()
	src.visible_message("<span class='danger'>[src] gets an evil-looking gleam in [p_their()] eye.</span>")

/mob/living/simple_animal/hostile/retaliate/goat/Move()
	. = ..()
	if(!stat)
		eat_plants()

/mob/living/simple_animal/hostile/retaliate/goat/proc/eat_plants()
	var/eaten = FALSE
	var/obj/structure/spacevine/SV = locate(/obj/structure/spacevine) in loc
	if(SV)
		SV.eat(src)
		eaten = TRUE

	var/obj/structure/glowshroom/GS = locate(/obj/structure/glowshroom) in loc
	if(GS)
		qdel(GS)
		eaten = TRUE

	if(eaten && prob(10))
		say("Nom")

/mob/living/simple_animal/hostile/retaliate/goat/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass))
		udder.milkAnimal(O, user)
		return 1
	else
		return ..()


/mob/living/simple_animal/hostile/retaliate/goat/AttackingTarget()
	. = ..()
	if(. && ishuman(target))
		var/mob/living/carbon/human/H = target
		if(istype(H.dna.species, /datum/species/pod))
			var/obj/item/bodypart/NB = pick(H.bodyparts)
			H.visible_message("<span class='warning'>[src] takes a big chomp out of [H]!</span>", \
								  "<span class='userdanger'>[src] takes a big chomp out of your [NB]!</span>")
			NB.dismember()
//cow
/mob/living/simple_animal/cow
	name = "cow"
	desc = "Known for their milk, just don't tip them over."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "brahmin"
	icon_living = "brahmin"
	icon_dead = "brahmin_dead"
	icon_gib = "brahmin_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 6)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 200
	maxHealth = 200
	var/obj/item/udder/udder = null
	var/datum/reagent/milk_reagent = /datum/reagent/consumable/milk
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	gold_core_spawnable = FRIENDLY_SPAWN
	var/is_calf = 0
	var/has_calf = 0
	var/young_type = null
	blood_volume = 480

	footstep_type = FOOTSTEP_MOB_SHOE

/mob/living/simple_animal/cow/Initialize()
	udder = new(null, milk_reagent)
	. = ..()

/mob/living/simple_animal/cow/Destroy()
	qdel(udder)
	udder = null
	return ..()

/mob/living/simple_animal/cow/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass))
		udder.milkAnimal(O, user)
		return 1
	else if(stat == CONSCIOUS && istype(O, food_type))
		if(is_calf)
			visible_message("<span class='alertalien'>[src] adorably chews the [O].</span>")
			qdel(O)
		if(!has_calf && !is_calf)
			has_calf = 1
			visible_message("<span class='alertalien'>[src] hungrily consumes the [O].</span>")
			qdel(O)
		else
			visible_message("<span class='alertalien'>[src] absently munches the [O].</span>")
			qdel(O)
	else
		return ..()

/mob/living/simple_animal/cow/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(stat == CONSCIOUS)
		if((prob(3) && has_calf))
			has_calf++
		if(has_calf > 10)
			has_calf = 0
			visible_message("<span class='alertalien'>[src] gives birth to a calf.</span>")
			new young_type(get_turf(src))

		if(is_calf)
			if((prob(3)))
				is_calf = 0
				udder = new()
				if (name == "brahmin calf")
					name = "brahmin"
				else
					name = "cow"
				visible_message("<span class='alertalien'>[src] has fully grown.</span>")
		else
			udder.generateMilk(milk_reagent)

/mob/living/simple_animal/cow/on_attack_hand(mob/living/carbon/M)
	if(!stat && M.a_intent == INTENT_DISARM && icon_state != icon_dead)
		M.visible_message("<span class='warning'>[M] tips over [src].</span>",
			"<span class='notice'>You tip over [src].</span>")
		to_chat(src, "<span class='userdanger'>You are tipped over by [M]!</span>")
		DefaultCombatKnockdown(60,ignore_canknockdown = TRUE)
		icon_state = icon_dead
		spawn(rand(20,50))
			if(!stat && M)
				icon_state = icon_living
				var/external
				var/internal
				switch(pick(1,2,3,4))
					if(1,2,3)
						var/text = pick("imploringly.", "pleadingly.",
							"with a resigned expression.")
						external = "[src] looks at [M] [text]"
						internal = "You look at [M] [text]"
					if(4)
						external = "[src] seems resigned to its fate."
						internal = "You resign yourself to your fate."
				visible_message("<span class='notice'>[external]</span>",
					"<span class='revennotice'>[internal]</span>")
	else
		..()

//a cow that produces a random reagent in its udder
/mob/living/simple_animal/cow/random
	name = "strange cow"
	desc = "Something seems off about the milk this cow is producing."

/mob/living/simple_animal/cow/random/Initialize()
	milk_reagent = get_random_reagent_id() //this has a blacklist so don't worry about romerol cows, etc
	..()

//Wisdom cow, speaks and bestows great wisdoms
/mob/living/simple_animal/cow/wisdom
	name = "wisdom cow"
	desc = "Known for its wisdom, shares it with all"
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/wisdomcow = 1) //truly the best meat
	gold_core_spawnable = FALSE
	speak_chance = 10 //the cow is eager to share its wisdom! //but is wise enough to not lag  the server too bad
	milk_reagent = /datum/reagent/medicine/liquid_wisdom

/mob/living/simple_animal/cow/wisdom/Initialize()
	. = ..()
	speak = GLOB.wisdoms //Done here so it's setup properly


/////////////
// CHICKEN //
/////////////

/mob/living/simple_animal/chick
	name = "\improper chick"
	desc = "Adorable! They make such a racket though."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "chick"
	icon_living = "chick"
	icon_dead = "chick_dead"
	icon_gib = "chick_gib"
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak = list("Cherp.","Cherp?","Chirrup.","Cheep!")
	speak_emote = list("cheeps")
	emote_hear = list("cheeps.")
	emote_see = list("pecks at the ground.","flaps its tiny wings.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 2
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 1)
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 3
	maxHealth = 3
	ventcrawler = VENTCRAWLER_ALWAYS
	var/amount_grown = 0
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	gold_core_spawnable = FRIENDLY_SPAWN

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chick/Initialize()
	. = ..()
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)

/mob/living/simple_animal/chick/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if(!stat && !ckey)
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			new /mob/living/simple_animal/chicken(src.loc)
			qdel(src)

/mob/living/simple_animal/chick/holo/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	amount_grown = 0

/mob/living/simple_animal/chicken
	name = "\improper chicken"
	desc = "Hopefully the eggs are good this season."
	gender = FEMALE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "chicken_brown"
	icon_living = "chicken_brown"
	icon_dead = "chicken_brown_dead"
	speak = list("Cluck!","BWAAAAARK BWAK BWAK BWAK!","Bwaak bwak.")
	speak_emote = list("clucks","croons")
	emote_hear = list("clucks.")
	emote_see = list("pecks at the ground.","flaps its wings viciously.")
	density = FALSE
	speak_chance = 2
	turns_per_move = 3
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/chicken = 2)
	var/egg_type = /obj/item/reagent_containers/food/snacks/egg
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	health = 15
	maxHealth = 15
	ventcrawler = VENTCRAWLER_ALWAYS
	var/eggsleft = 0
	var/eggsFertile = TRUE
	var/body_color
	var/icon_prefix = "chicken"
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	var/list/feedMessages = list("It clucks happily.","It clucks happily.")
	var/list/layMessage = EGG_LAYING_MESSAGES
	var/list/validColors = list("brown","black","white")
	gold_core_spawnable = FRIENDLY_SPAWN
	var/static/chicken_count = 0

	footstep_type = FOOTSTEP_MOB_CLAW

/mob/living/simple_animal/chicken/Initialize()
	. = ..()
	if(!body_color)
		body_color = pick(validColors)
	icon_state = "[icon_prefix]_[body_color]"
	icon_living = "[icon_prefix]_[body_color]"
	icon_dead = "[icon_prefix]_[body_color]_dead"
	pixel_x = rand(-6, 6)
	pixel_y = rand(0, 10)
	++chicken_count

/mob/living/simple_animal/chicken/Destroy()
	--chicken_count
	return ..()

/mob/living/simple_animal/chicken/attackby(obj/item/O, mob/user, params)
	if(istype(O, food_type)) //feedin' dem chickens
		if(!stat && eggsleft < 8)
			var/feedmsg = "[user] feeds [O] to [name]! [pick(feedMessages)]"
			user.visible_message(feedmsg)
			qdel(O)
			eggsleft += rand(1, 4)
		else
			to_chat(user, "<span class='warning'>[name] doesn't seem hungry!</span>")
	else
		..()

/mob/living/simple_animal/chicken/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	if((!stat && prob(3) && eggsleft > 0) && egg_type)
		visible_message("<span class='alertalien'>[src] [pick(layMessage)]</span>")
		eggsleft--
		var/obj/item/E = new egg_type(get_turf(src))
		E.pixel_x = rand(-6,6)
		E.pixel_y = rand(-6,6)
		if(eggsFertile)
			if(chicken_count < MAX_CHICKENS && prob(25))
				START_PROCESSING(SSobj, E)

/obj/item/reagent_containers/food/snacks/egg/var/amount_grown = 0
/obj/item/reagent_containers/food/snacks/egg/process()
	if(isturf(loc))
		amount_grown += rand(1,2)
		if(amount_grown >= 100)
			visible_message("[src] hatches with a quiet cracking sound.")
			new /mob/living/simple_animal/chick(get_turf(src))
			STOP_PROCESSING(SSobj, src)
			qdel(src)
	else
		STOP_PROCESSING(SSobj, src)

///////////
// UDDER //
///////////

/obj/item/udder
	name = "udder"

/obj/item/udder/Initialize(loc, milk_reagent)
	if(!milk_reagent)
		milk_reagent = /datum/reagent/consumable/milk
	create_reagents(50, NONE, NO_REAGENTS_VALUE)
	reagents.add_reagent(milk_reagent, 20)
	. = ..()

/obj/item/udder/proc/generateMilk(datum/reagent/milk_reagent)
	if(prob(5))
		reagents.add_reagent(milk_reagent, rand(5, 10))

/obj/item/udder/proc/milkAnimal(obj/O, mob/user)
	var/obj/item/reagent_containers/glass/G = O
	if(G.reagents.total_volume >= G.volume)
		to_chat(user, "<span class='danger'>[O] is full.</span>")
		return
	var/transfered = reagents.trans_to(O, rand(5,10))
	if(transfered)
		user.visible_message("[user] milks [src] using \the [O].", "<span class='notice'>You milk [src] using \the [O].</span>")
	else
		to_chat(user, "<span class='danger'>The udder is dry. Wait a bit longer...</span>")



/////////////
// BRAHMIN //
/////////////

/mob/living/simple_animal/cow/brahmin
	name = "brahmin"
	desc = "Brahmin or brahma are mutated cattle with two heads and looking udderly ridiculous.<br>Known for their milk, just don't tip them over."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "brahmin"
	icon_living = "brahmin"
	icon_dead = "brahmin_dead"
	icon_gib = "brahmin_gib"
	speak = list("moo?","moo","MOOOOOO")
	speak_emote = list("moos","moos hauntingly")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	response_help_continuous  = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	attack_verb_continuous = "kicks"
	attack_verb_simple = "kick"
	attack_sound = 'sound/weapons/punch1.ogg'
	young_type = /mob/living/simple_animal/cow/brahmin/calf
	emote_hear = list("brays.")
	var/obj/item/inventory_back
	speak_chance = 0.4
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/reagent_containers/food/snacks/rawbrahminliver = 1, /obj/item/reagent_containers/food/snacks/rawbrahmintongue = 2, /obj/item/stack/sheet/animalhide/brahmin = 3, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1

///////////////////////
//Dave's Brahmin Bags//
///////////////////////
	var/bags = FALSE
	var/collar = FALSE
	var/mob/living/owner = null
	var/follow = FALSE
	var/bridle = FALSE

/obj/item/brahminbags
	name = "brahmin bags"
	desc = "Attach these bags to a brahmin and leave the heavy lifting to them!"
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "trekkerpack"

/obj/item/brahmincollar
	name = "brahmin collar"
	desc = "A collar with a piece of etched metal serving as a tag. Use this on a brahmin you own to rename them."
	icon = 'icons/mob/pets.dmi'
	icon_state = "petcollar"

/obj/item/brahminbridle
	name = "brahmin bridle set"
	desc = "A set of headgear used to control and claim a brahmin. Consists of a bit, reins, and leather straps stored in a satchel."
	icon = 'icons/fallout/objects/storage.dmi'
	icon_state = "satchel_enclave"

/datum/crafting_recipe/brahminbags
	name = "Brahmin bags"
	result = /obj/item/brahminbags
	time = 60
	reqs = list(/obj/item/stack/sheet/leather = 2,
				/obj/item/storage/backpack/duffelbag = 2,
				/obj/item/weaponcrafting/string = 2)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/brahmincollar
	name = "Brahmin collar"
	result = /obj/item/brahmincollar
	time = 60
	reqs = list(/obj/item/stack/crafting/metalparts = 1,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_FARMING
	category = CAT_MISC

/datum/crafting_recipe/brahminbridle
	name = "Brahmin bridle set"
	result = /obj/item/brahminbridle
	time = 60
	reqs = list(/obj/item/stack/sheet/metal = 3,
				/obj/item/stack/sheet/leather = 2,
				/obj/item/stack/sheet/cloth = 1)
	tools = list(TOOL_WORKBENCH)
	subcategory = CAT_FARMING
	category = CAT_MISC

/mob/living/simple_animal/cow/brahmin/attackby(obj/item/I, mob/user)
	. = ..()
	if(istype(I,/obj/item/brahminbags))
		if(bags)
			to_chat(user, "<span class='warning'>The brahmin already has bags attached!</span>")
			return
		if(is_calf)
			to_chat(user, "<span class='warning'>The calf cannot carry the bags!</span>")
			return
		to_chat(user, "<span class='notice'>You add [I] to [src]...</span>")
		bags = TRUE
		desc += "<br>This one has some bags attached."
		qdel(I)
		src.ComponentInitialize()
		return

	if(istype(I,/obj/item/brahmincollar))
		if(user != owner)
			to_chat(user, "<span class='warning'>You need to claim the brahmin with a bridle before you can rename it!</span>")
			return

		name = input("Choose a new name for your brahmin!","Name", name)

		if(!name)
			return

		collar = TRUE
		desc += "<br>A collar with a tag etched '[name]' is hanging from its neck."
		to_chat(user, "<span class='notice'>You add [I] to [src]...</span>")
		message_admins("<span class='notice'>[ADMIN_LOOKUPFLW(user)] renamed a brahmin to [name].</span>") //So people don't name their brahmin the N-Word without notice
		qdel(I)
		return

	if(istype(I,/obj/item/brahminbridle))
		if(bridle)
			to_chat(user, "<span class='warning'>This brahmin already has a bridle!</span>")
			return

		owner = user
		bridle = TRUE
		to_chat(user, "<span class='notice'>You add [I] to [src], claiming it as yours.</span>")
		desc += "<br>It has a bridle and reins attached to its head."
		qdel(I)
		return

/datum/component/storage/concrete/brahminbag
	max_w_class = WEIGHT_CLASS_HUGE //Allows the storage of shotguns and other two handed items.
	max_combined_w_class = 35
	max_items = 30
	drop_all_on_destroy = TRUE
	allow_big_nesting = TRUE


/mob/living/simple_animal/cow/brahmin/ComponentInitialize()
	if(!bags)
		return
	AddComponent(/datum/component/storage/concrete/brahminbag)
	return

/mob/living/simple_animal/cow/brahmin/BiologicalLife(seconds, times_fired)
	if(!(. = ..()))
		return
	handle_following()


/mob/living/simple_animal/cow/brahmin/proc/handle_following()
	if(owner)
		if(!follow)
			return
		else if(CHECK_MOBILITY(src, MOBILITY_MOVE) && isturf(loc))
			step_to(src, owner)

/mob/living/simple_animal/cow/brahmin/CtrlShiftClick(mob/user)
	//if user not close return check!!!
	if(get_dist(user, src) > 1)
		return

	if(!bridle)
		return

	if(bridle && user.a_intent == INTENT_DISARM)
		bridle = FALSE
		owner = null
		to_chat(user, "<span class='notice'>You remove the bridle gear from [src], dropping it on the ground.</span>")
		new /obj/item/brahminbridle(user.loc)
		desc = "Brahmin or brahma are mutated cattle with two heads and looking udderly ridiculous.<br>Known for their milk, just don't tip them over."
		if(collar)
			desc += "<br>A collar with a tag etched '[name]' is hanging from its neck."
		if(bags)
			desc += "<br>This one has some bags attached."
		return

	if(collar && user.a_intent == INTENT_GRAB)
		collar = FALSE
		name = "brahmin"
		to_chat(user, "<span class='notice'>You remove the collar from [src], dropping it on the ground.</span>")
		new /obj/item/brahmincollar(user.loc)
		desc = "Brahmin or brahma are mutated cattle with two heads and looking udderly ridiculous.<br>Known for their milk, just don't tip them over."
		if(bridle)
			desc += "<br>It has a bridle and reins attached to its head."
		if(bags)
			desc += "<br>This one has some bags attached."

	if(user == owner)
		if(bridle && user.a_intent == INTENT_HELP)
			if(follow)
				to_chat(user, "<span class='notice'>You tug on the reins of [src], telling it to stop.</span>")
				follow = FALSE
				return
			else if(!follow)
				to_chat(user, "<span class='notice'>You tug on the reins of [src], telling it to follow.</span>")
				follow = TRUE
				return

///////////////////////////
//End Dave's Brahmin Bags//
///////////////////////////

/mob/living/simple_animal/cow/brahmin/calf
	name = "brahmin calf"
	is_calf = 1

/mob/living/simple_animal/cow/brahmin/calf/Initialize()
	. = ..()
	resize = 0.7
	update_transform()

/mob/living/simple_animal/cow/brahmin/sgtsillyhorn
	name = "Sergeant Sillyhorn"
	desc = "A distinguished war veteran alongside his junior enlisted sidekick, Corporal McCattle. The two of them wear a set of golden rings, smelted from captured Centurions."
	emote_see = list("shakes its head.","swishes its tail eagerly.")
	speak_chance = 2



/mob/living/simple_animal/cow/brahmin/proc/update_brahmin_fluff() //none of this should do anything for now, but it may be used for updating sprites later
	// First, change back to defaults
	name = real_name
	desc = initial(desc)
	// BYOND/DM doesn't support the use of initial on lists.
	speak = list("Moo?","Moo!","Mooo!","Moooo!","Moooo.")
	emote_hear = list("brays.")
	desc = initial(desc)




/////////////
// RADSTAG //
/////////////

/mob/living/simple_animal/radstag
	name = "radstag"
	desc = "a two headed deer that will run at the first sight of danger."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "radstag"
	icon_living = "radstag"
	icon_dead = "radstag_dead"
	icon_gib = "radstag_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/animalhide/radstag = 2, /obj/item/stack/sheet/bone = 2)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/bone = 2)
	butcher_difficulty = 1

	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "kicks"
	attack_verb_simple = "kicks"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 50
	maxHealth = 50
	gold_core_spawnable = FRIENDLY_SPAWN
	blood_volume = BLOOD_VOLUME_NORMAL
	faction = list("neutral")


///////////////
// BIGHORNER //
///////////////

/mob/living/simple_animal/hostile/retaliate/goat/bighorn
	name = "bighorner"
	desc = "Mutated bighorn sheep that are often found in mountains, and are known for being foul-tempered even at the best of times."
	icon = 'icons/fallout/mobs/animals/farmanimals.dmi'
	icon_state = "bighorner"
	icon_living = "bighorner"
	icon_dead = "bighorner_dead"
	icon_gib = "bighorner_gib"
	speak = list("EHEHEHEHEH","eh?")
	speak_emote = list("brays")
	emote_hear = list("brays.")
	emote_see = list("shakes its head.", "stamps a foot.", "glares around.", "grunts.")
	speak_chance = 1
	turns_per_move = 5
	see_in_dark = 6
	guaranteed_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 3)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab = 4, /obj/item/stack/sheet/sinew = 2, /obj/item/stack/sheet/bone = 1)
	butcher_difficulty = 1
	response_help_simple  = "pets"
	response_disarm_simple = "gently pushes aside"
	response_harm_simple   = "kicks"
	faction = list("bighorner")
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	attack_verb_simple = "rams"
	attack_sound = 'sound/weapons/punch1.ogg'
	health = 120
	maxHealth = 120
	melee_damage_lower = 25
	melee_damage_upper = 20
	environment_smash = ENVIRONMENT_SMASH_NONE
	stop_automated_movement_when_pulled = 1
	var/is_calf = 0
	var/food_type = /obj/item/reagent_containers/food/snacks/grown/wheat
	var/has_calf = 0
	var/young_type = /mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/attackby(obj/item/O, mob/user, params)
	if(stat == CONSCIOUS && istype(O, /obj/item/reagent_containers/glass)) // Should probably be bound into a proc at this point.
		udder.milkAnimal(O, user)
		return 1
	if(stat == CONSCIOUS && istype(O, food_type))
		if(is_calf)
			visible_message("<span class='alertalien'>[src] adorably chews the [O].</span>")
			qdel(O)
		if(!has_calf && !is_calf)
			has_calf = 1
			visible_message("<span class='alertalien'>[src] hungrily consumes the [O].</span>")
			qdel(O)
		else
			visible_message("<span class='alertalien'>[src] absently munches the [O].</span>")
			qdel(O)
	else
		return ..()

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/Life()
	. = ..()
	if(stat == CONSCIOUS)
		if((prob(3) && has_calf))
			has_calf++
		if(has_calf > 10)
			has_calf = 0
			visible_message("<span class='alertalien'>[src] gives birth to a calf.</span>")
			new young_type(get_turf(src))

		if(is_calf)
			if((prob(3)))
				is_calf = 0
				udder = new()
				if(name == "bighorn lamb")
					name = "bighorn"
				else
					name = "bighorn"
				visible_message("<span class='alertalien'>[src] has fully grown.</span>")
		else
			udder.generateMilk(milk_reagent)

// BIGHORNER CALF
/mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf
	name = "bighoner calf"
	resize = 0.7

/mob/living/simple_animal/hostile/retaliate/goat/bighorn/calf/Initialize() //calfs should not be a separate critter, they should just be a normal whatever with these vars
	. = ..()
	resize = 0.7
	update_transform()


/* Seems obsolete with Daves Brahmin packs, marked for death?
	if(inventory_back && inventory_back.brahmin_fashion)
		var/datum/brahmin_fashion/BF = new inventory_back.brahmin_fashion(src)
		BF.apply(src)

/mob/living/simple_animal/cow/brahmin/regenerate_icons()
	..()
	if(inventory_back)
		var/image/back_icon
		var/datum/brahmin_fashion/BF = new inventory_back.brahmin_fashion(src)

		if(!BF.obj_icon_state)
			BF.obj_icon_state = inventory_back.icon_state
		if(!BF.obj_alpha)
			BF.obj_alpha = inventory_back.alpha
		if(!BF.obj_color)
			BF.obj_color = inventory_back.color

		if(health <= 0)
			back_icon = BF.get_overlay(dir = EAST)
			back_icon.pixel_y = -11
			back_icon.transform = turn(back_icon.transform, 180)
		else
			back_icon = BF.get_overlay()
		add_overlay(back_icon)

	return

/mob/living/simple_animal/cow/brahmin/show_inv(mob/user)
	user.set_machine(src)
	if(user.stat)
		return

	var/dat = 	"<div align='center'><b>Inventory of [name]</b></div><p>"
	if(inventory_back)
		dat +=	"<br><b>Back:</b> [inventory_back] (<a href='?src=[REF(src)];remove_inv=back'>Remove</a>)"
	else
		dat +=	"<br><b>Back:</b> <a href='?src=[REF(src)];add_inv=back'>Nothing</a>"

	user << browse(dat, text("window=mob[];size=325x500", real_name))
	onclose(user, "mob[real_name]")
	return

mob/living/simple_animal/cow/brahmin/Topic(href, href_list)
	if(usr.stat)
		return

	//Removing from inventory
	if(href_list["remove_inv"])
		if(!Adjacent(usr) || !(ishuman(usr) || ismonkey(usr) || iscyborg(usr) ||  isalienadult(usr)))
			return
		var/remove_from = href_list["remove_inv"]
		switch(remove_from)
			if("back")
				if(inventory_back)
					inventory_back.forceMove(drop_location())
					inventory_back = null
					update_brahmin_fluff()
					regenerate_icons()
				else
					to_chat(usr, "<span class='danger'>There is nothing to remove from its [remove_from].</span>")
					return

		show_inv(usr)

	//Adding things to inventory
	else if(href_list["add_inv"])
		if(!Adjacent(usr) || !(ishuman(usr) || ismonkey(usr) || iscyborg(usr) ||  isalienadult(usr)))
			return

		var/add_to = href_list["add_inv"]

		switch(add_to)

			if("back")
				if(inventory_back)
					to_chat(usr, "<span class='warning'>It's already wearing something!</span>")
					return
				else
					var/obj/item/item_to_add = usr.get_active_held_item()

					if(!item_to_add)
						usr.visible_message("[usr] pets [src].","<span class='notice'>You rest your hand on [src]'s back for a moment.</span>")
						return

					if(!usr.temporarilyRemoveItemFromInventory(item_to_add))
						to_chat(usr, "<span class='warning'>\The [item_to_add] is stuck to your hand, you cannot put it on [src]'s back!</span>")
						return

					//The objects that brahmin can wear on their backs.
					var/allowed = FALSE
					if(ispath(item_to_add.brahmin_fashion, /datum/brahmin_fashion/back))
						allowed = TRUE

					if(!allowed)
						to_chat(usr, "<span class='warning'>You set [item_to_add] on [src]'s back, but it falls off!</span>")
						item_to_add.forceMove(drop_location())
						if(prob(25))
							step_rand(item_to_add)
						for(var/i in list(1,2,4,8,4,8,4,dir))
							setDir(i)
							sleep(1)
						return

					item_to_add.forceMove(src)
					src.inventory_back = item_to_add
					update_brahmin_fluff()
					regenerate_icons()

		show_inv(usr)
	else
		..()
*/
