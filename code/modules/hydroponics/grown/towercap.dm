/obj/item/seeds/tower
	name = "pack of tower-cap mycelium"
	desc = "This mycelium grows into tower-cap mushrooms."
	icon_state = "mycelium-tower"
	species = "towercap"
	plantname = "Tower Caps"
	product = /obj/item/grown/log
	lifespan = 80
	endurance = 50
	maturation = 15
	production = 1
	yield = 5
	potency = 50
	growthstages = 3
	growing_icon = 'icons/obj/hydroponics/growing_mushrooms.dmi'
	icon_dead = "towercap-dead"
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	mutatelist = list(/obj/item/seeds/tower/steel)
	reagents_add = list(
		/datum/reagent/cellulose = 0.05,
		/datum/reagent/oxygen = 0.05
	)

/obj/item/seeds/tower/steel
	name = "pack of steel-cap mycelium"
	desc = "This mycelium grows into steel logs."
	icon_state = "mycelium-steelcap"
	species = "steelcap"
	plantname = "Steel Caps"
	product = /obj/item/grown/log/steel
	mutatelist = list()
	reagents_add = list(
		/datum/reagent/cellulose = 0.05,
		/datum/reagent/iron = 0.05,
		/datum/reagent/oxygen = 0.1
	)
	rarity = 20

/obj/item/grown/log
	seed = /obj/item/seeds/tower
	name = "tower-cap log"
	desc = "It's better than bad, it's good!"
	icon_state = "logs"
	force = 5
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	throw_speed = 2
	throw_range = 3
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	var/plank_type = /obj/item/stack/sheet/mineral/wood
	var/plank_name = "wooden planks"
	var/static/list/accepted = typecacheof(list(/obj/item/reagent_containers/food/snacks/grown/tobacco,
	/obj/item/reagent_containers/food/snacks/grown/tea,
	/obj/item/reagent_containers/food/snacks/grown/ambrosia/vulgaris,
	/obj/item/reagent_containers/food/snacks/grown/ambrosia/deus,
	/obj/item/reagent_containers/food/snacks/grown/wheat))

/obj/item/grown/log/attackby(obj/item/W, mob/user, params)
	if(W.sharpness)
		user.show_message(span_notice("You make [plank_name] out of \the [src]!"), MSG_VISUAL)
		var/seed_modifier = 3
		if(seed)
			seed_modifier = round(seed.potency / 25)
		new plank_type(user.loc, 1 + seed_modifier)
		/*
		var/old_plank_amount = plank.amount
		for(var/obj/item/stack/ST in user.loc)
			if(ST != plank && istype(ST, plank_type) && ST.amount < ST.max_amount)
				ST.attackby(plank, user) //we try to transfer all old unfinished stacks to the new stack we created.
		if(plank.amount > old_plank_amount)
			to_chat(user, span_notice("You add the newly-formed [plank_name] to the stack. It now contains [plank.amount] [plank_name]."))
		*/
		qdel(src)

	if(CheckAccepted(W))
		var/obj/item/reagent_containers/food/snacks/grown/leaf = W
		if(leaf.dry)
			user.show_message(span_notice("You wrap \the [W] around the log, turning it into a torch!"))
			var/obj/item/flashlight/flare/torch/T = new /obj/item/flashlight/flare/torch(user.loc)
			usr.dropItemToGround(W)
			usr.put_in_active_hand(T)
			qdel(leaf)
			qdel(src)
			return
		else
			to_chat(usr, "<span class ='warning'>You must dry this first!</span>")
	else
		return ..()

/obj/item/grown/log/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, accepted)

/obj/item/grown/log/tree
	seed = null
	name = "wood log"
	desc = "TIMMMMM-BERRRRRRRRRRR!"

/obj/item/grown/log/steel
	seed = /obj/item/seeds/tower/steel
	name = "steel-cap log"
	desc = "It's made of metal."
	icon_state = "steellogs"
	plank_type = /obj/item/stack/rods
	plank_name = "rods"

/obj/item/grown/log/steel/CheckAccepted(obj/item/I)
	return FALSE

/obj/item/seeds/bamboo
	name = "pack of bamboo seeds"
	desc = "A plant known for its flexible and resistant logs."
	icon_state = "seed-bamboo"
	species = "bamboo"
	plantname = "Bamboo"
	product = /obj/item/grown/log/bamboo
	lifespan = 80
	endurance = 70
	maturation = 15
	production = 2
	yield = 5
	potency = 50
	growthstages = 2
	growing_icon = 'icons/obj/hydroponics/growing.dmi'
	icon_dead = "bamboo-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)

/obj/item/grown/log/bamboo
	seed = /obj/item/seeds/bamboo
	name = "bamboo log"
	desc = "A long and resistant bamboo log."
	icon_state = "bamboo"
	plank_type = /obj/item/stack/sheet/mineral/bamboo
	plank_name = "bamboo sticks"

/obj/item/grown/log/bamboo/CheckAccepted(obj/item/I)
	return FALSE

/obj/structure/punji_sticks
	name = "punji sticks"
	desc = "Don't step on this."
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "punji"
	resistance_flags = FLAMMABLE
	max_integrity = 30
	density = FALSE
	anchored = TRUE

/obj/structure/punji_sticks/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)

/obj/structure/punji_sticks/spikes
	name = "wooden spikes"
	icon_state = "woodspike"

/////////BONFIRES//////////

/obj/structure/bonfire
	name = "bonfire"
	desc = "For grilling, broiling, charring, smoking, heating, roasting, toasting, simmering, searing, melting, and occasionally burning things."
	icon = 'icons/fallout/objects/furniture/heating.dmi'
	icon_state = "bonfire"
	light_color = LIGHT_COLOR_FIRE
	density = FALSE
	anchored = TRUE
	buckle_lying = 0
	pass_flags = LETPASSTHROW
	pass_flags_self = PASSTABLE
	var/burning = 0
	var/burn_icon = "bonfire_on_fire" //for a softer more burning embers icon, use "bonfire_warm"
	var/grill = FALSE
	var/stones = FALSE
	var/fire_stack_strength = 5
	var/datum/looping_sound/fireplace/soundloop

/obj/structure/bonfire/Initialize()
	. = ..()
	soundloop = new(list(src), FALSE)

/obj/structure/bonfire/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/datum/looping_sound/fireplace
	start_sound = list(SOUND_LOOP_ENTRY('sound/machines/fire_crackle1.ogg', 0.2 SECONDS, 1))
	start_length = 2
	mid_sounds = list(
		SOUND_LOOP_ENTRY('sound/machines/fire_crackle1.ogg', 1 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/machines/fire_crackle2.ogg', 1 SECONDS, 1),
		SOUND_LOOP_ENTRY('sound/machines/fire_crackle3.ogg', 1 SECONDS, 1),
		)
	mid_length = 0
	end_sound = list(SOUND_LOOP_ENTRY('sound/machines/fire_crackle1.ogg', 1 SECONDS, 1))
	volume = 100

/obj/structure/bonfire/dense/Initialize()
	. = ..()
	density = TRUE
	stones = TRUE
	add_overlay("bonfire_stones")
	return

/obj/structure/bonfire/prelit/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	StartBurning()

/obj/structure/bonfire/dense/prelit/Initialize()
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED =PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

	StartBurning()

/obj/structure/bonfire/dense/prelit/grill/Initialize()
	. = ..()
	grill = TRUE
	add_overlay("bonfire_grill")

/obj/structure/bonfire/CanAllowThrough(atom/movable/mover, border_dir)
	..()
	if(istype(mover) && (mover.pass_flags & pass_flags_self))
		return TRUE
	if(mover.throwing)
		return TRUE
	return ..()

/obj/structure/bonfire/attackby(obj/item/W, mob/user, params)
	//SMOKE SIGNALS. Burn cloth to send a radio message to everyone who knows tribal.
	if(istype(W, /obj/item/stack/sheet/cloth) && !grill && burning)
		if(!user.has_language(/datum/language/tribal))
			return ..()
		attempt_smoke_signal(W, user)
		return
	//SANDSTONE GUARDRAIL. Use sandstone to make the bonfire dense to avoid accidentally walking onto the fire.
	if(istype(W, /obj/item/stack/sheet/mineral/sandstone) && !stones)
		var/obj/item/stack/sheet/mineral/sandstone/stone = W
		if(stone.use(3))
			to_chat(user, span_warning("You surround \the [src] with stones to make it safer."))
			density = TRUE
			stones = TRUE
			add_overlay("bonfire_stones")
			return
		else
			to_chat(user, span_warning("You do not have enough [W] to surround \the [src] with stones."))
			return
	//STAKE AND GRILL. Use metal rods to add either a stake to burn your enemies on, or a grill to cook food like a microwave.
	if(istype(W, /obj/item/stack/rods) && !can_buckle && !grill)
		var/obj/item/stack/rods/rod = W
		var/choice = input(user, "What would you like to construct?", "Bonfire") as null|anything in list("Stake","Grill")
		switch(choice)
			if("Stake")
				rod.use(1)
				can_buckle = TRUE
				buckle_requires_restraints = TRUE
				to_chat(user, "<span class='italics'>You add a rod to \the [src].")
				var/mutable_appearance/rod_underlay = mutable_appearance('icons/obj/hydroponics/equipment.dmi', "bonfire_rod")
				rod_underlay.pixel_y = 16
				underlays += rod_underlay
				return
			if("Grill")
				rod.use(1)
				grill = TRUE
				to_chat(user, "<span class='italics'>You add a grill to \the [src].")
				add_overlay("bonfire_grill")
				return
			else
				return ..()
	//IGNITE. Use a hot object to light the bonfire.
	var/ignition = W.ignition_effect(src, user)
	if(ignition)
		visible_message(ignition)
		StartBurning()
		soundloop.start()
		return

	//COOKING. Place an object on the bonfire as if it were a table, using its grill.
	if(grill)
		if(user.a_intent != INTENT_HARM && !(W.item_flags & ABSTRACT))
			if(user.temporarilyRemoveItemFromInventory(W))
				W.forceMove(get_turf(src))
				var/list/click_params = params2list(params)
				//Center the icon where the user clicked.
				if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
					return
				//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
				W.pixel_x = clamp(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
				W.pixel_y = clamp(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
		else //Standard attackby response, but also expose anything used on it to flame.
			. = ..()
			if(burning)
				W.fire_act(1000, 500)


/obj/structure/bonfire/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(burning)
		to_chat(user, span_warning("You need to extinguish [src] before removing the logs!"))
		return
	if(!has_buckled_mobs() && do_after(user, 50, target = src))
		for(var/I in 1 to 5)
			var/obj/item/grown/log/L = new /obj/item/grown/log(src.loc)
			L.pixel_x += rand(1,4)
			L.pixel_y += rand(1,4)
		if(can_buckle || grill)
			new /obj/item/stack/rods(loc, 1)
		if(stones)
			new /obj/item/stack/sheet/mineral/sandstone(loc, 3)
		qdel(src)
		return

/obj/structure/bonfire/proc/CheckOxygen()
	/*
	if(isopenturf(loc))
		var/turf/open/O = loc
		if(O.air)
			var/datum/gas_mixture/loc_air = O.air
			if(loc_air.get_moles(GAS_O2) > 13)
				return TRUE
	return FALSE
	*/
	return TRUE

/obj/structure/bonfire/proc/StartBurning()
	if(!burning && CheckOxygen())
		icon_state = burn_icon
		burning = TRUE
		set_light(6)
		Burn()
		START_PROCESSING(SSobj, src)

/obj/structure/bonfire/fire_act(exposed_temperature, exposed_volume)
	StartBurning()

/obj/structure/bonfire/proc/on_entered(atom/movable/AM)
	SIGNAL_HANDLER
	if(burning & !grill)
		INVOKE_ASYNC(src,PROC_REF(Burn))

/obj/structure/bonfire/proc/Burn()
	var/turf/current_location = get_turf(src)
	current_location.hotspot_expose(1000,100,1)
	for(var/A in current_location)
		if(A == src)
			continue
		if(isobj(A))
			var/obj/O = A
			O.fire_act(1000, 500)
		else if(isliving(A))
			var/mob/living/L = A
			L.adjust_fire_stacks(fire_stack_strength)
			L.IgniteMob()

/obj/structure/bonfire/proc/Cook()
	var/turf/current_location = get_turf(src)
	for(var/A in current_location)
		if(A == src)
			continue
		else if(isliving(A)) //It's still a fire, idiot.
			var/mob/living/L = A
			L.adjust_fire_stacks(fire_stack_strength)
			L.IgniteMob()
		else if(istype(A, /obj/item) && prob(20))
			var/obj/item/O = A
			O.microwave_act()
		else if(istype(A, /obj/item/grown/log))
			qdel(A)
			new /obj/item/stack/sheet/mineral/coal(loc, 1)

/obj/structure/bonfire/process()
	if(!CheckOxygen())
		extinguish()
		return
	if(!grill)
		Burn()
	else
		Cook()

/obj/structure/bonfire/extinguish()
	if(burning)
		icon_state = "bonfire"
		burning = 0
		set_light(0)
		STOP_PROCESSING(SSobj, src)

/obj/structure/bonfire/proc/attempt_smoke_signal(obj/item/stack/sheet/cloth/sheet, mob/living/user, )
	if(!is_type_in_list(get_area(src), GLOB.outdoor_areas))
		to_chat(user, span_warning("You must be outside to send a smoke signal."))
		return
	var/signalmessage = stripped_input(user, "What would you like to send via smoke signal?", "Smoke Signal")
	if(!signalmessage)
		return
	var/send_time = length(signalmessage) * 2 //Deciseconds. A 10 character message would take 20 deciseconds, or two seconds, to send.
	if(!user.canUseTopic(src, BE_CLOSE))
		to_chat(user, span_warning("You have to stand still to send a smoke signal."))
		to_chat(user, span_warning("You attempted to send: [signalmessage]"))
		return
	if(do_after(user, send_time, target = src))
		if(!sheet.use(1))
			to_chat(user, span_warning("You don't have enough cloth to send a smoke signal."))
			to_chat(user, span_warning("You attempted to send: [signalmessage]"))
			return
		smoke_signal(user, signalmessage, src)
		user.visible_message("[user] burns \the [sheet] in short, controlled bursts.")
	else
		to_chat(user, span_warning("You have to stand still to send a smoke signal."))
		to_chat(user, span_warning("You attempted to send: [signalmessage]"))
		return
	

/obj/structure/bonfire/proc/smoke_signal(mob/living/M, message, obj/structure/bonfire/B)
	var/log_message = "[message]"
	M.log_talk(log_message, LOG_CHAT)

	for(var/mob/player in GLOB.player_list)
		if(player == M)
			var/msg = span_engradio("You send a message by smoke signal: "+span_papyrus("\"[message]\""))
			to_chat(player, msg)
			continue
		if(istype(player, /mob/dead))
			var/msg_dead = "(Smoke Signal) [M]: "+span_papyrus("\"[message]\"")
			to_chat(player, msg_dead)
			continue
		if(player.has_language(/datum/language/tribal) && !HAS_TRAIT(player, TRAIT_BLIND))
			if(!player.z == Z_LEVEL_NASH_UNDERGROUND) //Can be seen while indoors, just not sent. Still, can't see while underground.
				continue
			var/dirmessage = "somewhere in the distance"
			if(player.z == B.z)
				var/dir = get_dir(get_turf(player), get_turf(B))
				switch(dir)
					if(NORTH)
						dirmessage = "in the north"
					if(SOUTH)
						dirmessage = "in the south"
					if(EAST)
						dirmessage = "in the east"
					if(WEST)
						dirmessage = "in the west"
					if(NORTHEAST)
						dirmessage = "in the northeast"
					if(NORTHWEST)
						dirmessage = "in the northwest"
					if(SOUTHEAST)
						dirmessage = "in the southeast"
					if(SOUTHWEST)
						dirmessage = "in the southwest"
			var/msg = span_engradio("Smoke rises [dirmessage]: "+span_papyrus("\"[message]\""))
			to_chat(player, msg)

/obj/structure/bonfire/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if(..())
		M.pixel_y += 13

/obj/structure/bonfire/unbuckle_mob(mob/living/buckled_mob, force=FALSE)
	if(..())
		buckled_mob.pixel_y -= 13
