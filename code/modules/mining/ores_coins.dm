
#define GIBTONITE_QUALITY_HIGH 3
#define GIBTONITE_QUALITY_MEDIUM 2
#define GIBTONITE_QUALITY_LOW 1

#define ORESTACK_OVERLAYS_MAX 10

/**********************Mineral ores**************************/

/obj/item/stack/ore
	name = "rock"
	icon = 'icons/obj/mining.dmi'
	icon_state = "ore"
	item_state = "ore"
	full_w_class = WEIGHT_CLASS_BULKY
	singular_name = "ore chunk"
	var/points = 0 //How many points this ore gets you from the ore redemption machine
	var/refined_type = null //What this ore defaults to being refined into
	novariants = TRUE // Ore stacks handle their icon updates themselves to keep the illusion that there's more going
	var/list/stack_overlays

/obj/item/stack/ore/update_overlays()//this is broken
	. = ..()
	var/difference = min(ORESTACK_OVERLAYS_MAX, amount) - (LAZYLEN(stack_overlays)+1)
	if(difference == 0)
		return
	else if(difference < 0 && LAZYLEN(stack_overlays))			//amount < stack_overlays, remove excess.
		if (LAZYLEN(stack_overlays)-difference <= 0)
			stack_overlays = null
		else
			stack_overlays.len += difference
	else if(difference > 0)			//amount > stack_overlays, add some.
		for(var/i in 1 to difference)
			var/mutable_appearance/newore = mutable_appearance(icon, icon_state)
			newore.pixel_x = rand(-8,8)
			newore.pixel_y = rand(-8,8)
			LAZYADD(stack_overlays, newore)
	if (stack_overlays)
		. += stack_overlays

/obj/item/stack/ore/welder_act(mob/living/user, obj/item/I)
	if(!refined_type)
		return TRUE

	if(I.use_tool(src, user, 0, volume=50, amount=15))
		new refined_type(drop_location())
		use(1)

	return TRUE

/obj/item/stack/ore/fire_act(exposed_temperature, exposed_volume)
	. = ..()
	if(isnull(refined_type))
		return
	else
		var/probability = (rand(0,100))/100
		var/burn_value = probability*amount
		var/amountrefined = round(burn_value, 1)
		if(amountrefined < 1)
			qdel(src)
		else
			new refined_type(drop_location(),amountrefined)
			qdel(src)

/obj/item/stack/ore/uranium
	name = "uranium ore"
	icon_state = "Uranium ore"
	item_state = "Uranium ore"
	singular_name = "uranium ore chunk"
	points = 30
	custom_materials = list(/datum/material/uranium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/uranium
	merge_type = /obj/item/stack/ore/uranium

/obj/item/stack/ore/iron
	name = "iron ore"
	icon_state = "Iron ore"
	item_state = "Iron ore"
	singular_name = "iron ore chunk"
	points = 1
	custom_materials = list(/datum/material/iron=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/metal
	merge_type = /obj/item/stack/ore/iron

/obj/item/stack/ore/glass
	name = "sand pile"
	icon_state = "Glass ore"
	item_state = "Glass ore"
	singular_name = "sand pile"
	points = 1
	custom_materials = list(/datum/material/glass=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/glass
	w_class = WEIGHT_CLASS_TINY
	merge_type = /obj/item/stack/ore/glass
	grind_results = list(/datum/reagent/silicon = 20,)

/obj/item/stack/ore/glass/three
	amount = 3

GLOBAL_LIST_INIT(sand_recipes, list(\
	new/datum/stack_recipe("sandstone", /obj/item/stack/sheet/mineral/sandstone, 1, 1, 50),\
	))

/obj/item/stack/ore/glass/get_main_recipes()
	. = ..()
	. += GLOB.sand_recipes

/obj/item/stack/ore/glass/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(..() || !ishuman(hit_atom))
		return
	var/mob/living/carbon/human/poorsod = hit_atom
	eyesand(poorsod)

/obj/item/stack/ore/glass/attack(mob/living/M, mob/living/user)
	if(!ishuman(M))
		return ..()
	if(user.zone_selected != BODY_ZONE_PRECISE_EYES && user.zone_selected != BODY_ZONE_HEAD)
		return ..()
	var/mob/living/carbon/human/poorsod = M
	visible_message(span_danger("[user] throws the sand at [poorsod]'s face!"))
	if(ishuman(user))
		var/mob/living/carbon/human/sayer = user
		sayer.forcesay("POCKET SAAND!!")
	eyesand(poorsod)

/obj/item/stack/ore/glass/proc/eyesand(mob/living/carbon/human/C)
	if(C.head && C.head.flags_cover & HEADCOVERSEYES)
		visible_message(span_danger("[C]'s headgear blocks the sand!"))
		return
	if(C.wear_mask && C.wear_mask.flags_cover & MASKCOVERSEYES)
		visible_message(span_danger("[C]'s mask blocks the sand!"))
		return
	if(C.glasses && C.glasses.flags_cover & GLASSESCOVERSEYES)
		visible_message(span_danger("[C]'s glasses block the sand!"))
		return
	C.adjust_blurriness(6)
	C.adjustStaminaLoss(15)//the pain from your eyes burning does stamina damage
	C.confused += 5
	to_chat(C, span_userdanger("\The [src] gets into your eyes! The pain, it burns!"))
	C.forcesay("*scream")
	qdel(src)


/obj/item/stack/ore/glass/ex_act(severity, target)
	if (severity == EXPLODE_NONE)
		return
	qdel(src)

/obj/item/stack/ore/blackpowder
	name = "blackpowder"
	icon_state = "Blackpowder ore"
	item_state = "Blackpowder ore"
	singular_name = "blackpowder"
	points = 1
	merge_type = /obj/item/stack/ore/blackpowder
	custom_materials = list(/datum/material/blackpowder=MINERAL_MATERIAL_AMOUNT)
	grind_results = list(/datum/reagent/blackpowder = 50)
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/ore/blackpowder/fifty
	amount = 50

/obj/item/stack/ore/blackpowder/twenty
	amount = 20

/obj/item/stack/ore/blackpowder/ten
	amount = 10

/obj/item/stack/ore/blackpowder/five
	amount = 5

/obj/item/stack/ore/blackpowder/two
	amount = 2

/obj/item/stack/ore/smokelesspowder
	name = "smokeless powder"
	icon_state = "Blackpowder ore"
	item_state = "Blackpowder ore"
	singular_name = "blackpowder"
	points = 1
	merge_type = /obj/item/stack/ore/smokelesspowder
	custom_materials = list(/datum/material/smokelesspowder=MINERAL_MATERIAL_AMOUNT)
	grind_results = list(/datum/reagent/blackpowder = 50)
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/ore/smokelesspowder/fifty
	amount = 50

/obj/item/stack/ore/smokelesspowder/twenty
	amount = 20

/obj/item/stack/ore/smokelesspowder/five
	amount = 5

/obj/item/stack/ore/primerpowder
	name = "primerpowder"
	icon_state = "Blackpowder ore"
	item_state = "Blackpowder ore"
	singular_name = "primerpowder"
	points = 1
	merge_type = /obj/item/stack/ore/primerpowder
	custom_materials = list(/datum/material/primerpowder=MINERAL_MATERIAL_AMOUNT)
	grind_results = list(/datum/reagent/primerpowder = 50)
	w_class = WEIGHT_CLASS_TINY

/obj/item/stack/ore/primerpowder/fifty
	amount = 50

/obj/item/stack/ore/primerpowder/twenty
	amount = 20

/obj/item/stack/ore/primerpowder/five
	amount = 5


//GLOBAL_LIST_INIT(blackpowder_recipes, list(
	//new/datum/stack_recipe("explosive arrowhead", /obj/item/stack/arrowhead/explosive, 5, 1, 3 SECONDS),
	//new/datum/stack_recipe("Powderbag and musket balls", /obj/item/ammo_box/flintlock, 8, 1, 3 SECONDS),
	//))

/obj/item/stack/ore/blackpowder/get_main_recipes()
	. = ..()
	//. += GLOB.blackpowder_recipes

/obj/item/stack/ore/glass/basalt
	name = "volcanic ash"
	icon_state = "volcanic_sand"
	singular_name = "volcanic ash pile"
	merge_type = /obj/item/stack/ore/glass/basalt

/obj/item/stack/ore/plasma
	name = "carbon chunks"
	icon_state = "slag"
	item_state = "slag"
	singular_name = "carbon chunk"
	points = 15
	custom_materials = list(/datum/material/plasma=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/plasma
	merge_type = /obj/item/stack/ore/plasma

/obj/item/stack/ore/plasma/welder_act(mob/living/user, obj/item/I)
	to_chat(user, span_warning("You can't hit a high enough temperature to smelt [src] properly!"))
	return TRUE

/obj/item/stack/ore/silver
	name = "silver ore"
	icon_state = "Silver ore"
	item_state = "Silver ore"
	singular_name = "silver ore chunk"
	points = 16
	custom_materials = list(/datum/material/silver=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/silver
	merge_type = /obj/item/stack/ore/silver

/obj/item/stack/ore/gold
	name = "gold ore"
	icon_state = "Gold ore"
	singular_name = "gold ore chunk"
	points = 18
	custom_materials = list(/datum/material/gold=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/gold
	merge_type = /obj/item/stack/ore/gold

/obj/item/stack/ore/diamond
	name = "diamond ore"
	icon_state = "Diamond ore"
	item_state = "Diamond ore"
	singular_name = "diamond ore chunk"
	points = 50
	custom_materials = list(/datum/material/diamond=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/diamond
	merge_type = /obj/item/stack/ore/diamond

/obj/item/stack/ore/titanium
	name = "titanium ore"
	icon_state = "Titanium ore"
	item_state = "Titanium ore"
	singular_name = "titanium ore chunk"
	points = 50
	custom_materials = list(/datum/material/titanium=MINERAL_MATERIAL_AMOUNT)
	refined_type = /obj/item/stack/sheet/mineral/titanium
	merge_type = /obj/item/stack/ore/titanium

/obj/item/stack/ore/slag
	name = "slag"
	desc = "Completely useless."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "slag"
	item_state = "slag"
	singular_name = "slag chunk"
	merge_type = /obj/item/stack/ore/slag

/obj/item/gibtonite
	name = "gibtonite ore"
	desc = "Extremely explosive if struck with mining equipment, Gibtonite is often used by miners to speed up their work by using it as a mining charge. This material is illegal to possess by unauthorized personnel under space law."
	icon = 'icons/obj/mining.dmi'
	icon_state = "Gibtonite ore"
	item_state = "Gibtonite ore"
	w_class = WEIGHT_CLASS_BULKY
	throw_range = 0
	var/primed = FALSE
	var/det_time = 100
	var/quality = GIBTONITE_QUALITY_LOW //How pure this gibtonite is, determines the explosion produced by it and is derived from the det_time of the rock wall it was taken from, higher value = better
	var/attacher = "UNKNOWN"
	var/det_timer

/obj/item/gibtonite/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/gibtonite/Destroy()
	qdel(wires)
	wires = null
	return ..()

/obj/item/gibtonite/attackby(obj/item/I, mob/user, params)
	if(!wires && istype(I, /obj/item/assembly/igniter))
		user.visible_message("[user] attaches [I] to [src].", span_notice("You attach [I] to [src]."))
		wires = new /datum/wires/explosive/gibtonite(src)
		attacher = key_name(user)
		qdel(I)
		add_overlay("Gibtonite_igniter")
		return

	if(wires && !primed)
		if(is_wire_tool(I))
			wires.interact(user)
			return

	if(I.tool_behaviour == TOOL_MINING || istype(I, /obj/item/resonator) || I.force >= 10)
		GibtoniteReaction(user)
		return
	if(primed)
		if(istype(I, /obj/item/mining_scanner) || istype(I, /obj/item/t_scanner/adv_mining_scanner) || istype(I, /obj/item/multitool))
			primed = FALSE
			if(det_timer)
				deltimer(det_timer)
			user.visible_message("The chain reaction was stopped! ...The ore's quality looks diminished.", span_notice("You stopped the chain reaction. ...The ore's quality looks diminished."))
			icon_state = "Gibtonite ore"
			quality = GIBTONITE_QUALITY_LOW
			return
	..()

/obj/item/gibtonite/attack_self(user)
	if(wires)
		wires.interact(user)
	else
		..()

/obj/item/gibtonite/bullet_act(obj/item/projectile/P)
	GibtoniteReaction(P.firer)
	return ..()

/obj/item/gibtonite/ex_act()
	GibtoniteReaction(null, 1)



/obj/item/gibtonite/proc/GibtoniteReaction(mob/user, triggered_by = 0)
	if(!primed)
		primed = TRUE
		playsound(src,'sound/effects/hit_on_shattered_glass.ogg',50,1)
		icon_state = "Gibtonite active"
		var/turf/bombturf = get_turf(src)
		var/notify_admins = 0
		if(z != 5)//Only annoy the admins ingame if we're triggered off the mining zlevel
			notify_admins = 1

		if(notify_admins)
			if(triggered_by == 1)
				message_admins("An explosion has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)].")
			else if(triggered_by == 2)
				message_admins("A signal has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)]. Igniter attacher: [ADMIN_LOOKUPFLW(attacher)]")
			else
				message_admins("[ADMIN_LOOKUPFLW(attacher)] has triggered a [name] to detonate at [ADMIN_VERBOSEJMP(bombturf)].")
		if(triggered_by == 1)
			log_game("An explosion primed a [name] at [AREACOORD(bombturf)]")
		else if(triggered_by == 2)
			log_game("A signal has primed a [name] at [AREACOORD(bombturf)]. Igniter attacher: [key_name(attacher)].")
		else
			user.visible_message(span_warning("[user] strikes \the [src], causing a chain reaction!"), span_danger("You strike \the [src], causing a chain reaction."))
			log_game("[key_name(user)] has primed a [name] for detonation at [AREACOORD(bombturf)]")
		det_timer = addtimer(CALLBACK(src,PROC_REF(detonate), notify_admins), det_time, TIMER_STOPPABLE)

/obj/item/gibtonite/proc/detonate(notify_admins)
	if(primed)
		switch(quality)
			if(GIBTONITE_QUALITY_HIGH)
				explosion(src,2,4,9,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_MEDIUM)
				explosion(src,1,2,5,adminlog = notify_admins)
			if(GIBTONITE_QUALITY_LOW)
				explosion(src,0,1,3,adminlog = notify_admins)
		qdel(src)

/obj/item/stack/ore/Initialize()
	. = ..()
	pixel_x = rand(0,16)-8
	pixel_y = rand(0,8)-8

/obj/item/stack/ore/ex_act(severity, target)
	if (!severity || severity >= 2)
		return
	qdel(src)


/*****************************Coin********************************/

// The coin's value is a value of it's materials.
// Yes, the gold standard makes a come-back!
// This is the only way to make coins that are possible to produce on station actually worth anything.
/obj/item/coin
	icon = 'icons/obj/economy.dmi'
	name = "coin"
	icon_state = "coin"
	flags_1 = CONDUCT_1
	force = 1
	throwforce = 2
	w_class = WEIGHT_CLASS_TINY
	custom_materials = list(/datum/material/iron = 400)
	material_flags = MATERIAL_ADD_PREFIX | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
	var/string_attached
	var/list/sideslist = list("heads","tails")
	var/cooldown = 0
	var/value
	var/coinflip
	item_flags = NO_MAT_REDEMPTION //You know, it's kind of a problem that money is worth more extrinsicly than intrinsically in this universe.

/obj/item/coin/Initialize()
	. = ..()
	coinflip = pick(sideslist)
	icon_state = "coin_[coinflip]"
	pixel_x = rand(0,16)-8
	pixel_y = rand(0,8)-8

/obj/item/coin/set_custom_materials(list/materials, multiplier = 1)
	. = ..()
	value = 0
	for(var/i in custom_materials)
		var/datum/material/M = i
		value += M.value_per_unit * custom_materials[M]

/obj/item/coin/get_item_credit_value()
	return value

/obj/item/coin/examine(mob/user)
	. = ..()
	. += span_info("It's worth [value] credit\s.")

/obj/item/coin/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stack/cable_coil))
		if(string_attached)
			to_chat(user, span_warning("There already is a string attached to this coin!"))
			return

		if (W.use_tool(src, user, 0, 1, skill_gain_mult = BARE_USE_TOOL_MULT))
			add_overlay("coin_string_overlay")
			string_attached = 1
			to_chat(user, span_notice("You attach a string to the coin."))
		else
			to_chat(user, span_warning("You need one length of cable to attach a string to the coin!"))
			return
	else
		..()

/obj/item/coin/wirecutter_act(mob/living/user, obj/item/I)
	if(!string_attached)
		return TRUE

	new /obj/item/stack/cable_coil(drop_location(), 1)
	overlays = list()
	string_attached = null
	to_chat(user, span_notice("You detach the string from the coin."))
	return TRUE

/obj/item/coin/attack_self(mob/user)
	if(cooldown < world.time)
		if(string_attached) //does the coin have a wire attached
			to_chat(user, span_warning("The coin won't flip very well with something attached!") )
			return FALSE//do not flip the coin
		cooldown = world.time + 15
		flick("coin_[coinflip]_flip", src)
		coinflip = pick(sideslist)
		icon_state = "coin_[coinflip]"
		playsound(user.loc, 'sound/items/coinflip.ogg', 50, 1)
		var/oldloc = loc
		sleep(15)
		if(loc == oldloc && user && !user.incapacitated(allow_crit = TRUE))
			user.visible_message("[user] has flipped [src]. It lands on [coinflip].", \
								span_notice("You flip [src]. It lands on [coinflip]."), \
								span_italic("You hear the clattering of loose change."))
	return TRUE//did the coin flip? Not useful in the slightest anymore!

/obj/item/coin/gold
	custom_materials = list(/datum/material/gold = 400)

/obj/item/coin/silver
	custom_materials = list(/datum/material/silver = 400)

/obj/item/coin/diamond
	custom_materials = list(/datum/material/diamond = 400)

/obj/item/coin/plasma
	custom_materials = list(/datum/material/plasma = 400)

/obj/item/coin/uranium
	custom_materials = list(/datum/material/uranium = 400)

/obj/item/coin/titanium
	custom_materials = list(/datum/material/titanium = 400)

/obj/item/coin/adamantine
	custom_materials = list(/datum/material/adamantine = 400)

/obj/item/coin/mythril
	custom_materials = list(/datum/material/mythril = 400)

/obj/item/coin/plastic
	custom_materials = list(/datum/material/plastic = 400)

/obj/item/coin/runite
	custom_materials = list(/datum/material/runite = 400)

/obj/item/coin/twoheaded
	desc = "Hey, this coin's the same on both sides!"
	sideslist = list("heads")

/obj/item/coin/antagtoken
	name = "antag token"
	desc = "A novelty coin that helps the heart know what hard evidence cannot prove."
	icon_state = "coin_valid"
	custom_materials = list(/datum/material/plastic = 400)
	sideslist = list("valid", "salad")
	material_flags = NONE

/obj/item/coin/gold/dogecoin
	name = "dogecoin"
	desc = "Ironically, such a coin is only valuable after it's too late to buy them."

/obj/item/coin/iron

#undef ORESTACK_OVERLAYS_MAX
