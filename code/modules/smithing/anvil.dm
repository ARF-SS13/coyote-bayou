#define WORKPIECE_PRESENT 1
#define WORKPIECE_INPROGRESS 2
#define WORKPIECE_FINISHED 3
#define WORKPIECE_SLAG 5

#define RECIPE_PICKAXE "bff" //bend fold fold
#define RECIPE_SHOVEL "buu" //bend upset upset
#define RECIPE_HAMMER "bpp" //bend punch punch
#define RECIPE_PROSPECTPICK "bfs" //bend fold shrink
#define RECIPE_KITCHENKNIFE "bsd" //bend shrink draw
#define RECIPE_CROWBAR "bbb" //bend bend bend

#define RECIPE_RING "sss" //shrink shrink shrink
#define RECIPE_BALLANDCHAIN "pbu" //punch bend upset

#define RECIPE_MACHETE "fdf" //fold draw fold
#define RECIPE_SABRE "ffdd" //fold fold draw draw
#define RECIPE_SWORD "ffdf" // fold fold draw fold
#define RECIPE_WAKI "fffd" //fold fold fold draw
#define RECIPE_KATANA "fffff" //fold fold fold fold fold

#define RECIPE_MACE "upu"  //upset punch upset
#define RECIPE_AXE "udsp" //upset draw shrink punch

#define RECIPE_DAGGER "dfs" //draw fold shrink
#define RECIPE_SPEAR "ddbf" //draw draw bend fold
#define RECIPE_JAVELIN "dbf" //draw bend fold
#define RECIPE_THROWING "dbd" //draw bend draw

//Tablevil specific
#define RECIPE_MACHREFORG "fdf" //fold punch punch
#define RECIPE_SCRAP "udsp" //upset draw shrink punch
#define RECIPE_UNITOOL "bbb"  //bend bend bend

//Legion specific
#define RECIPE_LANCE "ddbf" //draw draw fold fold
#define RECIPE_GLADIUS "fdf" //fold draw fold
#define RECIPE_SPATHA "ffdf" // fold fold draw fold
#define RECIPE_WARHONED "udsp" //upset draw shrink punch

// Logic of smithing recipes: Tools start with bend and have 3 steps. 1h weapons have 3-4 steps. 2h weapons have 4-5 steps. Bigger bladed stuff start with a fold. Pointy stuff generally start with a draw. Unusual stuff migth start with upset.
// Point of having a structure is obviously to help remember, not just keeping every recipe as pure rote memory with no internal logic. If you add more stuff and fuck this up and don't read comments I hope you get a prolapse. - Pebbles

/obj/structure/anvil
	name = "anvil"
	desc = "Base class of anvil. This shouldn't exist, but is useable."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "anvil"
	density = TRUE
	anchored = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE
	var/busy = FALSE //If someone is already interacting with this anvil
	var/workpiece_state = FALSE
	var/datum/material/workpiece_material
	var/currentquality = 0 //lolman? what the fuck do these vars do?
	var/currentsteps = 0 //even i don't know
	var/outrightfailchance = 1 //todo: document this shit
	var/stepsdone = ""
	var/rng = FALSE
	var/debug = FALSE //vv this if you want an artifact
	var/artifactrolled = FALSE
	var/itemqualitymax = 8
	var/list/smithrecipes = list(RECIPE_HAMMER = /obj/item/smithing/hammerhead,
	RECIPE_SHOVEL = /obj/item/smithing/shovelhead,
	RECIPE_PICKAXE = /obj/item/smithing/pickaxehead,
	RECIPE_PROSPECTPICK = /obj/item/smithing/prospectingpickhead,
	RECIPE_KITCHENKNIFE = /obj/item/smithing/knifeblade,
	RECIPE_CROWBAR = /obj/item/smithing/crowbar,
	RECIPE_RING = /obj/item/smithing/special/jewelry/ring,
	RECIPE_BALLANDCHAIN = /obj/item/smithing/ballandchain,
	RECIPE_DAGGER = /obj/item/smithing/daggerblade,
	RECIPE_MACHETE = /obj/item/smithing/macheteblade,
	RECIPE_SWORD = /obj/item/smithing/swordblade,
	RECIPE_SABRE = /obj/item/smithing/sabreblade,
	RECIPE_WAKI = /obj/item/smithing/wakiblade,
	RECIPE_KATANA = /obj/item/smithing/katanablade,
	RECIPE_MACE = /obj/item/smithing/macehead,
	RECIPE_AXE = /obj/item/smithing/axehead,
	RECIPE_SPEAR = /obj/item/smithing/spearhead,
	RECIPE_JAVELIN = /obj/item/smithing/javelinhead,
	RECIPE_THROWING = /obj/item/smithing/throwingknife,
)

/obj/structure/anvil/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, .proc/ResetAnvil) // emergency way to reset the anvil incase something goes wrong.

/obj/structure/anvil/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/ingot)) // That's it we're refactoring this code because I can't im literally crying rn ; _;
		return HandleIngot()

	if(istype(I, /obj/item/melee/smith/hammer) || istype(I, /obj/item/twohanded/sledgehammer/simple)) // Hammer interactions:
		var/obj/item/melee/smith/hammer/hammertime = I // Even though they are two seperate object paths, I believe because we're only accessing qualitymod, it casts accordingly.

		// if there is nothing present or something in progress.
		if(!(workpiece_state == WORKPIECE_PRESENT || workpiece_state == WORKPIECE_INPROGRESS))
			to_chat(user, "You can't work an empty anvil!")
			return FALSE

		// Checks if F.busy or busy.
		if(CheckBusy(user))
			to_chat(user, "This anvil is already being worked or you're already working on another one!")
			return FALSE

		return do_shaping(user, hammertime.qualitymod) // The actual progression part.

	return ..()

/obj/structure/anvil/proc/CheckBusy(mob/user)
	var/mob/living/carbon/human/F = user

	return F.busy || busy

/obj/structure/anvil/proc/SetBusy(var/value, var/mob/living/carbon/human/H)
	if(H)
		H.busy = value
	busy = value

/obj/structure/anvil/proc/ResetAnvil()
	set_light_on(FALSE)
	currentquality = initial(currentquality)
	stepsdone = ""
	currentsteps = 0
	outrightfailchance = initial(outrightfailchance)
	artifactrolled = FALSE
	workpiece_state = FALSE

	cut_overlay(image(icon= 'icons/fallout/objects/crafting/blacksmith.dmi',icon_state="workpiece"))
	SetBusy(FALSE, null)

/obj/structure/anvil/proc/HandleIngot(var/obj/item/ingot/notsword, mob/user)
	if(workpiece_state)
		to_chat(user, "There's already a workpiece! Finish it or take it off.")
		return FALSE
	if(notsword.workability == "shapeable")
		workpiece_state = WORKPIECE_PRESENT
		workpiece_material = notsword.custom_materials
		to_chat(user, "You place the [notsword] on the [src].")

		currentquality = initial(currentquality)

		if(workpiece_state == WORKPIECE_PRESENT)
			add_overlay(image(icon= 'icons/fallout/objects/crafting/blacksmith.dmi',icon_state="workpiece"))
			set_light_on(TRUE)

		var/skillmod = 4
		if(user.mind.skill_holder)
			skillmod = user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing)/2
		currentquality += skillmod

		qdel(notsword)
	else
		to_chat(user, "The ingot isn't workable yet!")
		return FALSE

/obj/structure/anvil/proc/do_shaping(mob/user, qualitychange)
	if(!iscarbon(user))
		return
	
	SetBusy(TRUE, user)

	currentquality += qualitychange
	workpiece_state = WORKPIECE_INPROGRESS // set it so we're working on it.
	
	// Present choice selection.
	var/list/shapingsteps = list("weak hit", "strong hit", "heavy hit", "fold", "draw", "shrink", "bend", "punch", "upset") //weak/strong/heavy hit affect strength. All the other steps shape.
	var/stepdone = input(user, "How would you like to work the metal?") in shapingsteps
	

	// if user is not in range, remove business.
	if(!locate(src) in range(1, user))
		return SetBusy(FALSE, user)


	// Time it takes for us to uh...forge..?
	var/steptime = 50

	if(user.mind.skill_holder) // Skill modifier to make it faster at blacksmithing.
		var/skillmod = user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing)/10 + 1
		steptime = 50 / skillmod

	playsound(src, 'sound/effects/clang2.ogg',40, 2) // sounds. gotta have them..!

	if(!do_after(user, steptime, target = src))
		return SetBusy(FALSE, user)
	
	// I hate this.
	// I'd rather die.
	switch(stepdone)
		if("weak hit")
			currentsteps += 1
			outrightfailchance += 5
			currentquality += 1
		if("strong hit")
			currentsteps += 2
			outrightfailchance += 9.5
			currentquality += 2
		if("heavy hit")
			currentsteps += 3
			outrightfailchance += 12.5
			currentquality += 3
		if("fold")
			stepsdone += "f"
			currentsteps += 1
			currentquality -= 1
		if("draw")
			stepsdone += "d"
			currentsteps += 1
			currentquality -= 1
		if("shrink")
			stepsdone += "s"
			currentsteps += 1
			currentquality -= 1
		if("bend")
			stepsdone += "b"
			currentsteps += 1
			currentquality -= 1
		if("punch")
			stepsdone += "p"
			currentsteps += 1
			currentquality -= 1
		if("upset")
			stepsdone += "u"
			currentsteps += 1
			currentquality -= 1

	// Display message
	user.visible_message("<span class='notice'>[user] works the metal on the anvil with their hammer with a loud clang!</span>", \
						"<span class='notice'>You [stepdone] the metal with a loud clang!</span>")
	
	// more sounds... uhhh...
	playsound(src, 'sound/effects/clang2.ogg',40, 2)

	// sparkles~
	do_smithing_sparks(1, TRUE, src) 

	// more fucking sounds after a timer..????????????????????????????????
	addtimer(CALLBACK(GLOBAL_PROC, .proc/playsound, src, 'sound/effects/clang2.ogg', 40, 2), 15)
	
	// the stepsdone is a string of characters which are actions made.
	// Once it is more or equal to 3, call try finish.
	if(length(stepsdone) >= 3)
		tryfinish(user)
	
	SetBusy(FALSE, user) // Set it to false, cause we're done now some how.

/obj/structure/anvil/proc/tryfinish(mob/user) // Oh god before I prettify this code I just feel like I'm having a stroke at all this word garble.

	var/artifactchance = 0
	if(!artifactrolled) // if there has not been a roll chance, do it now..?
		artifactchance = ( 1 + (user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing) / 4)) / 2500
		artifactrolled = TRUE

	var/artifact = max(prob(artifactchance), debug) // If there is an artifact..?

	var/finalfailchance = outrightfailchance // Compiled fail chance result

	if(user.mind.skill_holder) // Divide the failing chance based on the skillmodifier
		var/skillmod = user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing) / 10 + 1
		finalfailchance = max(0, finalfailchance / skillmod) //lv 2 gives 20% less to fail, 3 30%, etc
	

	///////
	// The two main conditionals
	///////

	// I hate this. If you hit more than 10 times, or the final piece failed and you have no artifact. Why it gotta look so awkward.
	if((currentsteps > 10 || (rng && prob(finalfailchance))) && !artifact)
	
		to_chat(user, "<span class='warning'>You overwork the metal, causing it to turn into useless slag!</span>")
		
		new /obj/item/stack/ore/slag(get_turf(src)) // Spawn some slag

		ResetAnvil() // Resets it to be default.

		if(user.mind.skill_holder) // give them some experience
			user.mind.auto_gain_experience(/datum/skill/level/dwarfy/blacksmithing, 25, 400, silent = FALSE)

		return SetBusy(FALSE, user) 
	
	// IF YOU DIDN'T FUCK UP THE RECIPE
	for(var/i in smithrecipes) // for each recipes.
		if(i == stepsdone) // if... "cum" == "bbu" idfk what the fuck am I looking at why isnt this a GLOB recipe list...

			var/obj/item/smithing/finisheditem = smithrecipes[stepsdone]
			finisheditem = new finisheditem(get_turf(src)) // Lets just spawn the item in immediately!

			to_chat(user, "You finish your [finisheditem]!")

			// math to make quality better if its an artifact.
			if(artifact)
				to_chat(user, "It is an artifact, a creation whose legacy shall live on forevermore.") //todo: SSblackbox
				currentquality = max(currentquality, 2)
				finisheditem.artifact = TRUE

			// Ternary statement to apply quality without an ugly else statement 
			finisheditem.quality = artifact ? currentquality * 3 : min(currentquality, itemqualitymax)

			// more switcheronies~ Adds a description
			switch(finisheditem.quality)
				if(-1000 to -8)
					finisheditem.desc +=  "\nIt looks to be the most awfully made object you've ever seen."
				if(-8)
					finisheditem.desc +=  "\nIt looks to be the second most awfully made object you've ever seen."
				if(-8 to 0)
					finisheditem.desc +=  "\nIt looks to be barely passable as... whatever it's trying to pass for."
				if(0)
					finisheditem.desc +=  "\nIt looks to be totally average."
				if(0 to INFINITY)
					finisheditem.desc +=  "\nIt looks to be better than average."
			finisheditem.set_custom_materials(workpiece_material)

			if(user.mind.skill_holder) // give them some experience!
				user.mind.auto_gain_experience(/datum/skill/level/dwarfy/blacksmithing, 100, 10000000, silent = FALSE)
			break

	ResetAnvil() // Worse Case no item is provided if something goes wrong, and we get to be able to use it again! :O

//////////////////////
//					//
//		ANVILS		//
//					//
//////////////////////

// Template
/obj/structure/anvil/obtainable
	name = "anvil template. Punish those who makes this appear."
	currentquality = 0
	outrightfailchance = 5
	rng = TRUE

// Best anvil, should be hard to find or make more
/obj/structure/anvil/obtainable/basic
	name = "anvil"
	desc = "Made from solid steel, you wont be moving this around any time soon."
	currentquality = 1
	itemqualitymax = 8

// Don't make this craftable.
/obj/structure/anvil/obtainable/legion
	name = "anvil"
	desc = "A solid steel anvil with a stamped bull on it."
	icon_state = "legvil"
	currentquality = 1
	itemqualitymax = 8
	anchored = TRUE
	smithrecipes = list(RECIPE_HAMMER = /obj/item/smithing/hammerhead,
	RECIPE_SHOVEL = /obj/item/smithing/shovelhead,
	RECIPE_PICKAXE = /obj/item/smithing/pickaxehead,
	RECIPE_PROSPECTPICK = /obj/item/smithing/prospectingpickhead,
	RECIPE_KITCHENKNIFE = /obj/item/smithing/knifeblade,
	RECIPE_CROWBAR = /obj/item/smithing/crowbar,
	RECIPE_RING = /obj/item/smithing/special/jewelry/ring,
	RECIPE_BALLANDCHAIN = /obj/item/smithing/ballandchain,
	RECIPE_DAGGER = /obj/item/smithing/daggerblade,
	RECIPE_GLADIUS =  /obj/item/smithing/gladiusblade,
	RECIPE_SPATHA = /obj/item/smithing/spathablade,
	RECIPE_SABRE = /obj/item/smithing/sabreblade,
	RECIPE_WAKI = /obj/item/smithing/wakiblade,
	RECIPE_KATANA = /obj/item/smithing/katanablade,
	RECIPE_MACE = /obj/item/smithing/macehead,
	RECIPE_WARHONED = /obj/item/smithing/warhonedhead,
	RECIPE_LANCE = /obj/item/smithing/lancehead,
	RECIPE_JAVELIN = /obj/item/smithing/javelinhead,
	RECIPE_THROWING = /obj/item/smithing/throwingknife,
)


// Decent makeshift anvil, can break, mobile. Gets the exclusive scrap version of the machete and 2h chopper, as well as the universal tool instead of a crowbar
/obj/structure/anvil/obtainable/table
	name = "table anvil"
	desc = "A reinforced table. Usable as an anvil, favored by mad wastelanders and the dregs of the wasteland. Can be loosened from its bolts and moved."
	icon_state = "tablevil"
	currentquality = 0
	itemqualitymax = 7
	smithrecipes = list(RECIPE_HAMMER = /obj/item/smithing/hammerhead,
	RECIPE_SHOVEL = /obj/item/smithing/shovelhead,
	RECIPE_PICKAXE = /obj/item/smithing/pickaxehead,
	RECIPE_PROSPECTPICK = /obj/item/smithing/prospectingpickhead,
	RECIPE_KITCHENKNIFE = /obj/item/smithing/knifeblade,
	RECIPE_UNITOOL = /obj/item/smithing/unitool,
	RECIPE_RING = /obj/item/smithing/special/jewelry/ring,
	RECIPE_BALLANDCHAIN = /obj/item/smithing/ballandchain,
	RECIPE_DAGGER = /obj/item/smithing/daggerblade,
	RECIPE_MACHREFORG = /obj/item/smithing/macheterblade,
	RECIPE_SWORD = /obj/item/smithing/swordblade,
	RECIPE_SABRE = /obj/item/smithing/sabreblade,
	RECIPE_WAKI = /obj/item/smithing/wakiblade,
	RECIPE_KATANA = /obj/item/smithing/katanablade,
	RECIPE_MACE = /obj/item/smithing/macehead,
	RECIPE_SPEAR = /obj/item/smithing/spearhead,
	RECIPE_SCRAP = /obj/item/smithing/scrapblade,
	RECIPE_JAVELIN = /obj/item/smithing/javelinhead,
	RECIPE_THROWING = /obj/item/smithing/throwingknife,
)

/obj/structure/anvil/obtainable/table/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 5)
	return TRUE


/obj/structure/anvil/obtainable/table/do_shaping(mob/user, qualitychange)
	if(prob(2))
		to_chat(user, "The [src] breaks under the strain!")
		take_damage(max_integrity)
		return FALSE
	else
		..()

// Worst craftable anvil, sturdy but limits the quality
/obj/structure/anvil/obtainable/sandstone
	name = "sandstone brick anvil"
	desc = "A big block of sandstone. Useable as an anvil."
	custom_materials = list(/datum/material/sandstone=8000)
	icon_state = "sandvil"
	currentquality = -1
	itemqualitymax = 7

// Debug anvil for some reason
/obj/structure/anvil/debugsuper
	name = "super ultra epic anvil of debugging."
	desc = "WOW. A DEBUG <del>ITEM</DEL> STRUCTURE. EPIC."
	icon_state = "anvil"
	currentquality = 10
	itemqualitymax = 9001
	outrightfailchance = 0

// Remnant trash
/obj/structure/anvil/obtainable/bronze
	name = "slab of bronze"
	desc = "A big block of bronze. Useable as an anvil."
	icon = 'icons/obj/smith.dmi'
	custom_materials = list(/datum/material/bronze=8000)
	icon_state = "ratvaranvil"
	currentquality = 0
	itemqualitymax = 6

/obj/structure/anvil/obtainable/ratvar
	name = "brass anvil"
	desc = "A big block of what appears to be brass. Useable as an anvil, if whatever's holding the brass together lets you."
	icon = 'icons/obj/smith.dmi'
	custom_materials = list(/datum/material/bronze=8000)
	icon_state = "ratvaranvil"
	currentquality = 1
	itemqualitymax = 8
/obj/structure/anvil/obtainable/ratvar/attackby(obj/item/I, mob/user)
	if(is_servant_of_ratvar(user))
		return ..()
	else
		to_chat(user, "<span class='neovgre'>KNPXWN, QNJCQNW!</span>") //rot13 then rot22 if anyone wants to decode

/obj/structure/anvil/obtainable/narsie
	name = "runic anvil"
	desc = "An anvil made of a strange, runic metal."
	custom_materials = list(/datum/material/runedmetal=8000)
	icon = 'icons/obj/smith.dmi'
	icon_state = "evil"
	currentquality = 1
	itemqualitymax = 8

/obj/structure/anvil/obtainable/narsie/attackby(obj/item/I, mob/user)
	if(iscultist(user))
		return ..()
	else
		to_chat(user, "<span class='narsiesmall'>That is not yours to use!</span>")

#undef WORKPIECE_PRESENT
#undef WORKPIECE_INPROGRESS
#undef WORKPIECE_FINISHED
#undef WORKPIECE_SLAG
