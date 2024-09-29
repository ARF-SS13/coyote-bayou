/obj/machinery/hydroponics
	name = "hydroponics tray"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "hydrotray"
	density = TRUE
	pixel_z = 8
	obj_flags = CAN_BE_HIT | UNIQUE_RENAME
	circuit = /obj/item/circuitboard/machine/hydroponics
	idle_power_usage = 0
	var/waterlevel = 100	//The amount of water in the tray (max 100)
	var/maxwater = 100		//The maximum amount of water in the tray
	var/nutridrain = 0.05      // How many units of nutrient will be drained in the tray //test //lowering it even further
	var/maxnutri = 100		//The maximum nutrient of water in the tray
	var/pestlevel = 0		//The amount of pests in the tray (max 10)
	var/weedlevel = 0		//The amount of weeds in the tray (max 10)
	var/yieldmod = 1		//Nutriment's effect on yield
	var/mutmod = 1			//Nutriment's effect on mutations
	var/toxic = 0			//Toxicity in the tray?
	var/age = 0				//Current age
	var/dead = FALSE			//Is it dead?
	var/plant_health		//Its health
	var/lastproduce = 0		//Last time it was harvested
	var/lastcycle = 0		//Used for timing of cycles.
	var/cycledelay = 200	//About 10 seconds / cycle
	var/harvest = FALSE			//Ready to harvest?
	var/obj/item/seeds/myseed = null	//The currently planted seed
	var/rating = 1
	var/unwrenchable = TRUE
	tooadvanced = TRUE
	var/recent_bee_visit = FALSE //Have we been visited by a bee recently, so bees dont overpollinate one plant
	var/mob/lastuser //Last user to add reagents to a tray. Mostly for logging.
	var/self_sustaining = FALSE //If the tray generates nutrients and water on its own
	var/self_sustainingprog = 0
	// Here lies irrigation. You won't be missed, because you were never used.

/obj/machinery/hydroponics/Initialize()
	//Here lies "nutrilevel", killed by ArcaneMusic 20??-2019. Finally, we strive for a better future. Please use "reagents" instead
	create_reagents(100)
	reagents.add_reagent(/datum/reagent/plantnutriment/eznutriment, 100) //Half filled nutrient trays for dirt trays to have more to grow with in prison/lavaland.
	. = ..()
	LAZYREMOVE(GLOB.machines, src)
	LAZYADD(GLOB.plant_bins, src)
	if(myseed)
		START_PROCESSING(SSplants, src)

/obj/machinery/hydroponics/constructable
	name = "hydroponics tray"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "hydrotray3"

/obj/machinery/hydroponics/constructable/RefreshParts()
	reagents.maximum_volume = 100
	/* 
	var/tmp_capacity = 0
	for (var/obj/item/stock_parts/matter_bin/M in component_parts)
		tmp_capacity += M.rating
	for (var/obj/item/stock_parts/manipulator/M in component_parts)
		rating = M.rating
	maxwater = tmp_capacity * 50 // Up to 400
	maxnutri = (tmp_capacity * 5) + STATIC_NUTRIENT_CAPACITY // Up to 50 Maximum
	reagents.maximum_volume = maxnutri
	nutridrain = 1/rating
	*/

/obj/machinery/hydroponics/constructable/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>Alt-Click</b> to empty the tray's nutrients.")
	//if(in_range(user, src) || isobserver(user))
	//	. += span_notice("The status display reads: Tray efficiency at <b>[rating*100]%</b>.")

/obj/machinery/hydroponics/Destroy()
	if(myseed)
		qdel(myseed)
		myseed = null
		STOP_PROCESSING(SSplants, src)
	GLOB.plant_bins -= src
	return ..()

/obj/machinery/hydroponics/constructable/attackby(obj/item/I, mob/user, params)
	if (user.a_intent != INTENT_HARM)
		// handle opening the panel
		if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
			return
		if(default_deconstruction_crowbar(I))
			return
		if(tooadvanced == TRUE && HAS_TRAIT(user, TRAIT_TECHNOPHOBE))
			to_chat(user, span_warning("The array of simplistic button pressing confuses you. Besides, did you really want to spend all day staring at a screen?"))
			return

	return ..()

/obj/machinery/hydroponics/bullet_act(obj/item/projectile/Proj) //Works with the Somatoray to modify plant variables.
	if(!myseed)
		return ..()
	if(istype(Proj , /obj/item/projectile/energy/floramut))
		mutate()
		return BULLET_ACT_HIT
	else if(istype(Proj , /obj/item/projectile/energy/florayield))
		return myseed.bullet_act(Proj)
	else
		return ..()

/obj/machinery/hydroponics/process()
	var/needs_update = 0 // Checks if the icon needs updating so we don't redraw empty trays every time

	if(myseed && (myseed.loc != src))
		myseed.forceMove(src)

	else if(self_sustaining)
		adjustWater(5)
		adjustWeeds(-5)
		adjustPests(-5)

	if(world.time > (lastcycle + cycledelay))
		lastcycle = world.time
		if(myseed && !dead)
			// Advance age
			age++
			if(age < myseed.maturation)
				lastproduce = age

			needs_update = 1


//Nutrients//////////////////////////////////////////////////////////////
			// Nutrients deplete at a constant rate, since new nutrients can boost stats far easier.
			apply_chemicals(lastuser)
			if(self_sustaining)
				//reagents.remove_any(min(0.3, nutridrain))
			else
				reagents.remove_any(nutridrain)

			// Lack of nutrients hurts non-weeds
			if(reagents.total_volume <= 0 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
				adjustHealth(-rand(1,3))

//Photosynthesis/////////////////////////////////////////////////////////
			// Lack of light hurts non-mushrooms
			if(isturf(loc))
				var/turf/currentTurf = loc
				var/lightAmt = currentTurf.get_lumcount()
				if(myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
					if(lightAmt < 0.2)
						adjustHealth(-1 / rating)
				else // Non-mushroom
					if(lightAmt < 0.4)
						adjustHealth(-2 / rating)

//Water//////////////////////////////////////////////////////////////////
			// Drink random amount of water
			adjustWater(-nutridrain)//6

			// If the plant is dry, it loses health pretty fast, unless mushroom
			if(waterlevel <= 10 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism))
				adjustHealth(-rand(0,1) / rating)
				if(waterlevel <= 0)
					adjustHealth(-rand(0,2) / rating)

			// Sufficient water level and nutrient level = plant healthy but also spawns weeds
			else if(waterlevel > 10 && reagents.total_volume > 0)
				adjustHealth(rand(1,2) / rating)
				if(myseed && prob(myseed.weed_chance))
					adjustWeeds(myseed.weed_rate)
				// else if(prob(2))  //5 percent chance the weed population will increase
					// adjustWeeds(1 / rating)

//Toxins/////////////////////////////////////////////////////////////////

			// Too much toxins cause harm, but when the plant drinks the contaiminated water, the toxins disappear slowly
			if(toxic >= 40 && toxic < 80)
				adjustHealth(-1 / rating)
				adjustToxic(-rand(1,10) / rating)
			else if(toxic >= 80) // I don't think it ever gets here tbh unless above is commented out
				adjustHealth(-3)
				adjustToxic(-rand(1,10) / rating)

//Pests & Weeds//////////////////////////////////////////////////////////
/*
			if(pestlevel >= 8)
				if(!myseed.get_gene(/datum/plant_gene/trait/plant_type/carnivory))
					adjustHealth(-2 / rating)

				else
					adjustHealth(2 / rating)
					adjustPests(-1 / rating)

			else if(pestlevel >= 4)
				if(!myseed.get_gene(/datum/plant_gene/trait/plant_type/carnivory))
					adjustHealth(-1 / rating)

				else
					adjustHealth(1 / rating)
					if(prob(50))
						adjustPests(-1 / rating)

			else if(pestlevel < 4 && myseed.get_gene(/datum/plant_gene/trait/plant_type/carnivory))
				adjustHealth(-2 / rating)
				if(prob(5))
					adjustPests(-1 / rating)

			// If it's a weed, it doesn't stunt the growth
			if(weedlevel >= 5 && !myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy))
				adjustHealth(-1 / rating)

//This is where stability mutations exist now.
			if(myseed.instability >= 80)
				var/mutation_chance = myseed.instability - 75
				mutate(0, 0, 0, 0, 0, 0, 0, mutation_chance, 0) //Scaling odds of a random trait or chemical
			if(myseed.instability >= 60)
				if(prob((myseed.instability)/2) && !self_sustaining && length(myseed.mutatelist)) //Minimum 30%, Maximum 50% chance of mutating every age tick when not on autogrow.
					mutatespecie()
					myseed.instability = myseed.instability/2
			if(myseed.instability >= 40)
				if(prob(myseed.instability))
					hardmutate()
			if(myseed.instability >= 20 )
				if(prob(myseed.instability))
					mutate()
*/
//Health & Age///////////////////////////////////////////////////////////

			// Plant dies if plant_health <= 0
			if(plant_health <= 0)
				plantdies()
				adjustWeeds(1 / rating) // Weeds flourish

			// If the plant is too old, lose health fast
			if(age > myseed.lifespan)
				adjustHealth(-rand() / rating)

			// Harvest code
			if(age > myseed.production && (age - lastproduce) > myseed.production && (!harvest && !dead))
				if(myseed && myseed.yield != -1) // Unharvestable shouldn't be harvested
					harvest = TRUE
				else
					lastproduce = age
			// if(prob(5))  // On each tick, there's a 5 percent chance the pest population will increase
				// adjustPests(1 / rating)
		// else
			if(waterlevel > 10 && reagents.total_volume > 0 && prob(3))  // If there's no plant, the percentage chance is 10% // Nerfing down to 3%
				adjustWeeds(1 / rating)

		// Weeeeeeeeeeeeeeedddssss
		if(weedlevel >= 10 && prob(50)) // At this point the plant is kind of fucked. Weeds can overtake the plant spot.
			if(myseed)
				if(!myseed.get_gene(/datum/plant_gene/trait/plant_type/weed_hardy) && !myseed.get_gene(/datum/plant_gene/trait/plant_type/fungal_metabolism)) // If a normal plant
					weedinvasion()
			else
				weedinvasion() // Weed invasion into empty tray
			needs_update = 1
		if (needs_update)
			update_icon()

		if(myseed && prob(5 * (11-myseed.production)))
			for(var/g in myseed.genes)
				if(istype(g, /datum/plant_gene/trait))
					var/datum/plant_gene/trait/selectedtrait = g
					selectedtrait.on_grow(src)
	return

/obj/machinery/hydroponics/update_icon()
	//Refreshes the icon and sets the luminosity
	cut_overlays()

	if(self_sustaining)
		if(istype(src, /obj/machinery/hydroponics/soil))
			add_atom_colour(rgb(255, 175, 0), FIXED_COLOUR_PRIORITY)
		else
			add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "gaia_blessing"))
		set_light(3)

	if(myseed)
		update_icon_plant()
		update_icon_lights()

	if(!self_sustaining)
		if(myseed && myseed.get_gene(/datum/plant_gene/trait/glow))
			var/datum/plant_gene/trait/glow/G = myseed.get_gene(/datum/plant_gene/trait/glow)
			set_light(G.glow_range(myseed), G.glow_power(myseed), G.glow_color)
		else
			set_light(0)

	return

/obj/machinery/hydroponics/proc/update_icon_plant()
	var/mutable_appearance/plant_overlay = mutable_appearance(myseed.growing_icon, layer = OBJ_LAYER + 0.01)
	if(dead)
		plant_overlay.icon_state = myseed.icon_dead
	else if(harvest)
		if(!myseed.icon_harvest)
			plant_overlay.icon_state = "[myseed.icon_grow][myseed.growthstages]"
		else
			plant_overlay.icon_state = myseed.icon_harvest
	else
		var/t_growthstate = min(round((age / myseed.maturation) * myseed.growthstages), myseed.growthstages)
		plant_overlay.icon_state = "[myseed.icon_grow][t_growthstate]"
	add_overlay(plant_overlay)

/obj/machinery/hydroponics/proc/update_icon_lights()
	if(waterlevel <= 10)
		add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lowwater3"))
	if(reagents.total_volume <= 2)
		add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lownutri3"))
	if(plant_health <= (myseed.endurance / 2))
		add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_lowhealth3"))
	if(weedlevel >= 5 || pestlevel >= 5 || toxic >= 40)
		add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_alert3"))
	if(harvest)
		add_overlay(mutable_appearance('icons/obj/hydroponics/equipment.dmi', "over_harvest3"))


/obj/machinery/hydroponics/examine(user)
	. = ..()
	if(myseed)
		. += "<span class='info'>It has <span class='name'>[myseed.plantname]</span> planted.</span>"
		if (dead)
			. += span_warning("It's dead!")
		else if (harvest)
			. += span_info("It's ready to harvest.")
		else if (plant_health <= (myseed.endurance / 2))
			. += span_warning("It looks unhealthy.")
	else
		. += span_info("It's empty.")

	. += span_info("Water: [waterlevel]/[maxwater].")
	. += span_info("Nutrient: [reagents.total_volume]/[maxnutri].")

//	if(weedlevel >= 5)
//		to_chat(user, span_warning("It's filled with weeds!"))
//	if(pestlevel >= 5)
//		to_chat(user, span_warning("It's filled with tiny worms!"))

// Examining more a plant will yield a rough estimation of it's stats.
// Intended for use by Wayfarer's and Legion to allow their farmers to gauge roughly how it's going.
/obj/machinery/hydroponics/examine_more(user)
	if(myseed && (in_range(user, src) || isobserver(user)))
		to_chat(user, "<span class=info>You examine the plant to get a better view of it's harvest...</span>")
		switch(src.myseed.potency)	// Check potency
			if(0 to 20)
				to_chat(user, span_warning("The harvest's size is questioned, the fruits are small and insignificant."))
			if(21 to 40)
				to_chat(user, span_notice("The harvest's size is moderate, small but capable of feeding a singular person."))
			if(41 to 60)
				to_chat(user, span_notice("The harvest's size is good, well sized and fit for a family."))
			if(61 to 80)
				to_chat(user, span_notice("The harvest's size is great! It's capable of providing a good feast!"))
			if(81 to 100)
				to_chat(user, span_nicegreen("The harvest's size is huge and unmistakable!"))
		switch(src.myseed.yield) 	// Check yield
			if(0 to 2)
				to_chat(user, span_warning("The plant will bear but a few fruits, if any at that."))
			if(3 to 5)
				to_chat(user, span_notice("The plant will bear a handful of fruit at most."))
			if(5 to 7)
				to_chat(user, span_notice("The plant will yield an ample amount."))
			if(8 to 10)
				to_chat(user, span_nicegreen("The plant is high yielding and fertile!"))
		switch(src.myseed.production) // Check production speed
			if(1 to 3)
				to_chat(user, span_nicegreen("The plant'll be ready for harvest within a minute once it's matured!"))
			if(4 to 7)
				to_chat(user, span_notice("The plant'll be ready for harvest in around a few minutes after reaching maturation."))
			if(8 to 10)
				to_chat(user, span_warning("The plant's harvest is going to take a while after it's matured.'"))
		switch(src.myseed.endurance)	// Check endurance
			if(10 to 30)
				to_chat(user, span_warning("The plant's endurance is faltering, a breeze is capable of causing it to buckle."))
			if(31 to 50)
				to_chat(user, span_notice("The plant is durable, capable of taking the rough environment for a while."))
			if(51 to 70)
				to_chat(user, span_notice("The plant's fortitude is remarkable, it's able to withstand harsh toxins and stay alive."))
			if(71 to 90)
				to_chat(user, span_notice("The plant's endurance is as solid as an oak!"))
			if(90 to 100)
				to_chat(user, span_nicegreen("The plant's endurance is herculean, capable of surviving far longer than any man!"))
		switch(src.myseed.lifespan)		// Checks lifespan
			if(10 to 30)
				to_chat(user, span_warning("The plant's lifespan is counted in minutes, look away, and it will be nevermore."))
			if(31 to 50)
				to_chat(user, span_notice("The plant's lifespan is counted in hours, do not let it go so simply."))
			if(51 to 70)
				to_chat(user, span_notice("The plant's lifespan is counted in days."))
			if(71 to 90)
				to_chat(user, span_notice("The plant's lifepsan is counted in weeks."))
			if(90 to 100)
				to_chat(user, span_nicegreen("The plant's lifespan is forevermore. Treat it well, and it will not abandon you."))
		switch(src.myseed.instability)		// Checks Instability
			if(0 to 20)
				to_chat(user, span_nicegreen("The plant's stability is solid, the foundation secure."))
			if(21 to 40)
				to_chat(user, span_notice("The plant's stability is shifting, the harvest uncertain."))
			if(41 to 60)
				to_chat(user, span_notice("The plant's stability is loose, the harvest producing ancient relatives."))
			if(61 to 80)
				to_chat(user, span_notice("The plant's unstable, it actively morphs and tries to push itself to something greater."))
			if(81 to 100)
				to_chat(user, span_warning("The plant's unstable, the earth beneath moans and croaks, roots bend and insidious liquids seep from the skin."))
		switch(src.myseed.weed_rate)		//Checks Weed Growth Rate
			if(0 to 2)
				to_chat(user, span_nicegreen("The weed growth around the plant appear to be of a miniscule amount..."))
			if(3 to 5)
				to_chat(user, span_notice("The weed growth could overwhelm the plant in a matter of minutes..."))
			if(5 to 7)
				to_chat(user, span_notice("The weed growth would in but a few moments overwhelm the plant..."))
			if(8 to 10)
				to_chat(user, span_warning("The weed growth could instantly put down the plant..!"))
		switch(src.myseed.weed_chance)		//Checks weed growth chance
			if(0 to 20)
				to_chat(user, span_nicegreen("... and the chance of the weeds to grow are highly unlikely."))
			if(21 to 40)
				to_chat(user, span_notice("... and there's a coinflip's chance for the weeds to come forth."))
			if(41 to 60)
				to_chat(user, span_notice("... and the weeds are more likely to spew forth than not."))
			if(61 to 80)
				to_chat(user, span_notice("... and the weeds are very likely to come!"))
			if(81 to 100)
				to_chat(user, span_warning("... and the weeds will bloom."))
	else if(!myseed)
		to_chat(user, span_notice("... nothing seems to be growing there."))
	else
		to_chat(user, span_notice("... You can't see anything in particular. Maybe you need to get closer to examine it closely?"))
/obj/machinery/hydroponics/proc/weedinvasion() // If a weed growth is sufficient, this happens.
	dead = 0
	var/oldPlantName
	if(myseed) // In case there's nothing in the tray beforehand
		oldPlantName = myseed.plantname
		qdel(myseed)
		myseed = null
	else
		oldPlantName = "empty tray"
	switch(rand(1,18))		// randomly pick predominative weed
		if(16 to 18)
			myseed = new /obj/item/seeds/reishi(src)
		if(14 to 15)
			myseed = new /obj/item/seeds/nettle(src)
		if(12 to 13)
			myseed = new /obj/item/seeds/harebell(src)
		if(10 to 11)
			myseed = new /obj/item/seeds/amanita(src)
		if(8 to 9)
			myseed = new /obj/item/seeds/chanterelle(src)
		if(6 to 7)
			myseed = new /obj/item/seeds/tower(src)
		if(4 to 5)
			myseed = new /obj/item/seeds/plump(src)
		else
			myseed = new /obj/item/seeds/starthistle(src)
	age = 0
	plant_health = myseed.endurance
	lastcycle = world.time
	harvest = 0
	weedlevel = 0 // Reset
	pestlevel = 0 // Reset
	update_icon()
	visible_message(span_warning("The [oldPlantName] is overtaken by some [myseed.plantname]!"))
	name = "hydroponics tray ([myseed.plantname])"
	if(myseed.product)
		desc = initial(myseed.product.desc)
	else
		desc = initial(desc)

/obj/machinery/hydroponics/proc/mutate(lifemut = 2, endmut = 5, productmut = 1, yieldmut = 2, potmut = 25, wrmut = 2, wcmut = 5, traitmut = 0) // Mutates the current seed
	if(!myseed)
		return
	myseed.mutate(lifemut, endmut, productmut, yieldmut, potmut, wrmut, wcmut, traitmut)

/obj/machinery/hydroponics/proc/hardmutate()
	mutate(4, 10, 2, 4, 50, 4, 10, 3)


/obj/machinery/hydroponics/proc/mutatespecie() // Mutagent produced a new plant!
	if(!myseed || dead)
		return

	var/oldPlantName = myseed.plantname
	if(myseed.mutatelist.len > 0)
		var/mutantseed = pick(myseed.mutatelist)
		qdel(myseed)
		myseed = null
		myseed = new mutantseed
	else
		return

	hardmutate()
	age = 0
	plant_health = myseed.endurance
	lastcycle = world.time
	harvest = 0
	weedlevel = 0 // Reset

	sleep(5) // Wait a while
	update_icon()
	visible_message(span_warning("[oldPlantName] suddenly mutates into [myseed.plantname]!"))
	TRAY_NAME_UPDATE

/obj/machinery/hydroponics/proc/mutateweed() // If the weeds gets the mutagent instead. Mind you, this pretty much destroys the old plant
	if( weedlevel > 5 )
		if(myseed)
			qdel(myseed)
			myseed = null
		var/newWeed = pick(/obj/item/seeds/liberty, /obj/item/seeds/angel, /obj/item/seeds/nettle/death)
		myseed = new newWeed
		dead = 0
		hardmutate()
		age = 0
		plant_health = myseed.endurance
		lastcycle = world.time
		harvest = 0
		weedlevel = 0 // Reset

		sleep(5) // Wait a while
		update_icon()
		visible_message(span_warning("The mutated weeds in [src] spawn some [myseed.plantname]!"))
		TRAY_NAME_UPDATE
	else
		to_chat(usr, span_warning("The few weeds in [src] seem to react, but only for a moment..."))


/**
 * Plant Death Proc.
 * Cleans up various stats for the plant upon death, including pests, harvestability, and plant health.
 */
/obj/machinery/hydroponics/proc/plantdies()
	plant_health = 0
	harvest = FALSE
	pestlevel = 0 // Pests die
	lastproduce = 0
	STOP_PROCESSING(SSplants, src)
	if(!dead)
		update_icon()
		dead = TRUE


/obj/machinery/hydroponics/proc/mutatepest(mob/user)
	if(pestlevel > 5)
		message_admins("[ADMIN_LOOKUPFLW(user)] caused spiderling pests to spawn in a hydro tray")
		log_game("[key_name(user)] caused spiderling pests to spawn in a hydro tray")
		visible_message(span_warning("The pests seem to behave oddly..."))
		spawn_atom_to_turf(/obj/structure/spider/spiderling/hunter, src, 3, FALSE)
	else
		to_chat(user, span_warning("The pests seem to behave oddly, but quickly settle down..."))

/obj/machinery/hydroponics/attackby(obj/item/O, mob/user, params)
	//Called when mob user "attacks" it with object O
	if(istype(O, /obj/item/reagent_containers/food/snacks/grown/ambrosia/gaia))
		if(!self_sustaining)
			adjustSelfSuff(1)
			to_chat(user, "You spread the gaia through the soil. ([self_sustainingprog] out of 1)")
			qdel(O)
			return
		else
			. = ..()
	if(istype(O, /obj/item/reagent_containers) )  // Syringe stuff (and other reagent containers now too)
		var/obj/item/reagent_containers/reagent_source = O

		if(istype(reagent_source, /obj/item/reagent_containers/syringe))
			var/obj/item/reagent_containers/syringe/syr = reagent_source
			if(syr.mode != 1)
				to_chat(user, span_warning("You can't get any extract out of this plant.")		)
				return

		if(!reagent_source.reagents.total_volume)
			to_chat(user, span_notice("[reagent_source] is empty."))
			return 1

		if(reagents.total_volume >= reagents.maximum_volume && !reagent_source.reagents.has_reagent(/datum/reagent/water, 1))
			to_chat(user, span_notice("[src] is full."))
			return

		var/list/trays = list(src)//makes the list just this in cases of syringes and compost etc
		var/target = myseed ? myseed.plantname : src
		var/visi_msg = ""
		var/transfer_amount

		if(istype(reagent_source, /obj/item/reagent_containers/food/snacks) || istype(reagent_source, /obj/item/reagent_containers/pill))
			if(istype(reagent_source, /obj/item/reagent_containers/food/snacks))
				var/obj/item/reagent_containers/food/snacks/R = reagent_source
				if (R.trash)
					R.generate_trash(get_turf(user))
			visi_msg="[user] composts [reagent_source], spreading it through [target]"
			transfer_amount = reagent_source.reagents.total_volume
		else
			transfer_amount = reagent_source.amount_per_transfer_from_this
			if(istype(reagent_source, /obj/item/reagent_containers/syringe/))
				var/obj/item/reagent_containers/syringe/syr = reagent_source
				visi_msg="[user] injects [target] with [syr]"
				if(syr.reagents.total_volume <= syr.amount_per_transfer_from_this)
					syr.mode = 0
			// Beakers, bottles, buckets, etc.
			if(reagent_source.is_drainable())
				playsound(loc, 'sound/effects/slosh.ogg', 25, TRUE)

		if(visi_msg)
			visible_message(span_notice("[visi_msg]."))


		for(var/obj/machinery/hydroponics/H in trays)
		//cause I don't want to feel like im juggling 15 tamagotchis and I can get to my real work of ripping flooring apart in hopes of validating my life choices of becoming a space-gardener
			//This was originally in apply_chemicals, but due to apply_chemicals only holding nutrients, we handle it here now.
			if(reagent_source.reagents.has_reagent(/datum/reagent/water, 1))
				var/water_amt = reagent_source.reagents.get_reagent_amount(/datum/reagent/water) * transfer_amount / reagent_source.reagents.total_volume
				H.adjustWater(round(water_amt))
				reagent_source.reagents.remove_reagent(/datum/reagent/water, water_amt)
			reagent_source.reagents.trans_to(H.reagents, transfer_amount)
			if(istype(reagent_source, /obj/item/reagent_containers/food/snacks) || istype(reagent_source, /obj/item/reagent_containers/pill))
				qdel(reagent_source)
				lastuser = user
				H.update_icon()
				return 1
			H.update_icon()
		if(reagent_source) // If the source wasn't composted and destroyed
			reagent_source.update_icon()
		return 1

	else if(istype(O, /obj/item/seeds) && !istype(O, /obj/item/seeds/sample))
		if(!myseed)
			if(istype(O, /obj/item/seeds/liberty))
				investigate_log("had Kudzu planted in it by [key_name(user)] at [AREACOORD(src)]", INVESTIGATE_BOTANY)
			if(!user.transferItemToLoc(O, src))
				return
			to_chat(user, span_notice("You plant [O]."))
			dead = FALSE
			myseed = O
			investigate_log("planting: [user] planted [O] with traits [english_list(myseed)] and reagents [english_list_assoc(myseed.reagents_add)] and potency [myseed.potency]", INVESTIGATE_BOTANY)
			TRAY_NAME_UPDATE
			age = 1
			plant_health = myseed.endurance
			lastcycle = world.time
			START_PROCESSING(SSplants, src)
			update_icon()
			return
		else
			to_chat(user, span_warning("[src] already has seeds in it!"))
			return

	else if(istype(O, /obj/item/plant_analyzer))
		var/obj/item/plant_analyzer/P_analyzer = O
		if(myseed)
			if(P_analyzer.scan_mode == PLANT_SCANMODE_STATS)
				to_chat(user, "*** <B>[myseed.plantname]</B> ***" )
				to_chat(user, "- Plant Age: <span class='notice'>[age]</span>")
				var/list/text_string = myseed.get_analyzer_text()
				if(text_string)
					to_chat(user, text_string)
					to_chat(user, "*---------*")
			if(myseed.reagents_add && P_analyzer.scan_mode == PLANT_SCANMODE_CHEMICALS)
				to_chat(user, "- <B>Plant Reagents</B> -")
				to_chat(user, "*---------*")
				for(var/datum/plant_gene/reagent/G in myseed.genes)
					to_chat(user, span_notice("- [G.get_name()] -"))
				to_chat(user, "*---------*")
		else
			to_chat(user, "<B>No plant found.</B>")
		to_chat(user, "- Weed level: <span class='notice'>[weedlevel] / 10</span>")
		to_chat(user, "- Pest level: <span class='notice'>[pestlevel] / 10</span>")
		to_chat(user, "- Toxicity level: <span class='notice'>[toxic] / 100</span>")
		to_chat(user, "- Water level: <span class='notice'>[waterlevel] / [maxwater]</span>")
		to_chat(user, "- Nutrition level: <span class='notice'>[reagents.total_volume] / [maxnutri]</span>")
		return

	else if(istype(O, /obj/item/cultivator))
		if(weedlevel > 0)
			user.visible_message("[user] uproots the weeds.", span_notice("You remove the weeds from [src]."))
			weedlevel = 0
			update_icon()
		else
			to_chat(user, span_warning("This plot is completely devoid of weeds! It doesn't need uprooting."))

	else if(istype(O, /obj/item/storage/bag/plants))
		attack_hand(user)
		for(var/obj/item/reagent_containers/food/snacks/grown/G in locate(user.x,user.y,user.z))
			SEND_SIGNAL(O, COMSIG_TRY_STORAGE_INSERT, G, user, TRUE)

	else if(default_unfasten_wrench(user, O))
		return

	else if(istype(O, /obj/item/shovel/spade))
		if(!myseed && !weedlevel)
			to_chat(user, span_warning("[src] doesn't have any plants or weeds!"))
			return
		user.visible_message(span_notice("[user] starts digging out [src]'s plants..."),
			span_notice("You start digging out [src]'s plants..."))
		if(O.use_tool(src, user, 50, volume=50) || (!myseed && !weedlevel))
			user.visible_message(span_notice("[user] digs out the plants in [src]!"), span_notice("You dig out all of [src]'s plants!"))
			if(myseed) //Could be that they're just using it as a de-weeder
				age = 0
				plant_health = 0
				if(harvest)
					harvest = FALSE //To make sure they can't just put in another seed and insta-harvest it
				qdel(myseed)
				myseed = null
				name = initial(name)
				desc = initial(desc)
				STOP_PROCESSING(SSplants, src)
			weedlevel = 0 //Has a side effect of cleaning up those nasty weeds
			update_icon()

	else
		return ..()

/obj/machinery/hydroponics/can_be_unfasten_wrench(mob/user, silent)
	if (!unwrenchable)  // case also covered by NODECONSTRUCT checks in default_unfasten_wrench
		return CANT_UNFASTEN

	return ..()

/obj/machinery/hydroponics/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(issilicon(user)) //How does AI know what plant is?
		return
	if(harvest)
		myseed.harvest(user)
		return

	else if(dead)
		dead = FALSE
		to_chat(user, span_notice("You remove the dead plant from [src]."))
		qdel(myseed)
		myseed = null
		update_icon()
		STOP_PROCESSING(SSplants, src)
		TRAY_NAME_UPDATE
	else
		if(user)
			examine(user)
/*
/obj/machinery/hydroponics/CtrlClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		return
	if(!powered())
		to_chat(user, span_warning("[name] has no power."))
		return
	if(!anchored)
		return
	self_sustaining = !self_sustaining
	idle_power_usage = self_sustaining ? 2500 : 0
	to_chat(user, "<span class='notice'>You [self_sustaining ? "activate" : "deactivated"] [src]'s autogrow function[self_sustaining ? ", maintaining the tray's health while using high amounts of power" : ""].")
	update_icon()
*/
/obj/machinery/hydroponics/AltClick(mob/user)
	. = ..()
	if(!anchored)
		update_icon()
		return FALSE
	var/warning = alert(user, "Are you sure you wish to empty the tray's nutrient beaker?","Empty Tray Nutrients?", "Yes", "No")
	if(warning == "Yes" && user.canUseTopic(src, BE_CLOSE, FALSE, NO_TK))
		reagents.clear_reagents()
		to_chat(user, span_warning("You empty [src]'s nutrient tank."))

/obj/machinery/hydroponics/proc/update_tray(mob/user)
	harvest = FALSE
	lastproduce = age
	if(myseed.getYield() <= 0)
		to_chat(user, span_warning("You fail to harvest anything useful!"))
	else
		to_chat(user, span_notice("You harvest [myseed.getYield()] items from the [myseed.plantname]."))
	if(!myseed.get_gene(/datum/plant_gene/trait/repeated_harvest))
		qdel(myseed)
		STOP_PROCESSING(SSplants, src)
		myseed = null
		dead = FALSE
		name = initial(name)
		desc = initial(desc)
		TRAY_NAME_UPDATE
	update_icon()

/// Tray Setters - The following procs adjust the tray or plants variables, and make sure that the stat doesn't go out of bounds.///
/obj/machinery/hydroponics/proc/adjustWater(adjustamt)
	waterlevel = clamp(waterlevel + adjustamt, 0, maxwater)

	if(adjustamt>0)
		adjustToxic(-round(adjustamt/4))//Toxicity dilutation code. The more water you put in, the lesser the toxin concentration.

/obj/machinery/hydroponics/proc/adjustHealth(adjustamt)
	if(myseed && !dead)
		plant_health = clamp(plant_health + adjustamt, 0, myseed.endurance)

/obj/machinery/hydroponics/proc/adjustToxic(adjustamt)
	toxic = clamp(toxic + adjustamt, 0, 100)

/obj/machinery/hydroponics/proc/adjustPests(adjustamt)
	pestlevel = clamp(pestlevel + adjustamt, 0, 10)

/obj/machinery/hydroponics/proc/adjustWeeds(adjustamt)
	weedlevel = clamp(weedlevel + adjustamt, 0, 10)

/obj/machinery/hydroponics/proc/adjustSelfSuff(adjustamt)
	if(self_sustainingprog>=0)
		become_self_sufficient()
	else
		self_sustainingprog += adjustamt

/obj/machinery/hydroponics/proc/spawnplant() // why would you put strange reagent in a hydro tray you monster I bet you also feed them blood
	var/list/livingplants = list(/mob/living/simple_animal/hostile/tree, /mob/living/simple_animal/hostile/killertomato)
	var/chosen = pick(livingplants)
	var/mob/living/simple_animal/hostile/C = new chosen
	C.faction = list("plants")

///////////////////////////////////////////////////////////////////////////////
/obj/machinery/hydroponics/soil //Not actually hydroponics at all! Honk!
	name = "soil"
	desc = "A patch of dirt. <b>Alt-Click</b> to empty the soil's nutrients."
	icon = 'icons/fallout/farming/farming_structures.dmi'
	icon_state = "soil"
	circuit = null
	density = FALSE
	use_power = NO_POWER_USE
	flags_1 = NODECONSTRUCT_1
	unwrenchable = FALSE

/obj/machinery/hydroponics/soil/pot //Not actually hydroponics at all! Honk!
	name = "Growing pot"
	desc = "A growing pot. <b>Alt-Click</b> to empty the pot's nutrients."
	icon_state = "plantpot"

/obj/machinery/hydroponics/soil/update_icon_lights()
	return // Has no lights

/obj/machinery/hydroponics/soil/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/shovel) && !istype(O, /obj/item/shovel/spade)) //Doesn't include spades because of uprooting plants
		to_chat(user, span_notice("You clear up [src]!"))
		qdel(src)
	else
		return ..()

/obj/machinery/hydroponics/soil/CtrlClick(mob/user)
	return //Dirt doesn't have electricity, last I checked.

/obj/machinery/hydroponics/soil/update_icon_lights()
	return // Has no lights

/obj/machinery/hydroponics/soil/crafted
	waterlevel = 0
//	nutrilevel = 0

/obj/machinery/hydroponics/soil/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt-Click</b> to empty the tray's nutrients.")
	if(in_range(user, src) || isobserver(user))
		. += span_notice("You might be able to discern a plant's harvest by examining it <b>closer</b>.")

/obj/machinery/hydroponics/proc/become_self_sufficient() // Ambrosia Gaia effect
	visible_message(span_boldnotice("[src] begins to glow with a beautiful light!"))
	self_sustaining = TRUE
	update_icon()
