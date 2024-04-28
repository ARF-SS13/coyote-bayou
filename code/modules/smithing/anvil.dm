#define WORKPIECE_PRESENT 1
#define WORKPIECE_INPROGRESS 2
#define WORKPIECE_FINISHED 3
#define WORKPIECE_SLAG 5

#define RECIPE_PICKAXE "Pickaxe Head"
#define RECIPE_SHOVEL "Shovel Head"
#define RECIPE_HAMMER "Hammer Head"
#define RECIPE_PROSPECTPICK "Prospecting Pick Head"
#define RECIPE_KITCHENKNIFE "Kitchen Knife Blade"
#define RECIPE_CROWBAR "Crowbar"
#define RECIPE_UNITOOL "Crowbaxe"

#define RECIPE_RING "Ring"

#define RECIPE_BALLANDCHAIN "Unchained Ball"

#define RECIPE_MACHETE 		"Machete Blade"
#define RECIPE_SABRE 		"Sabre Blade"
#define RECIPE_SWORD 		"Sword Blade"
#define RECIPE_WAKI 		"Wakizashi Blade"
#define RECIPE_KATANA 		"Katana Blade"
#define RECIPE_LONGSWORD 	"Longsword Blade"
#define RECIPE_MACHREFORG 	"Lawnmower Machete Blade"

#define RECIPE_MACE 		"Mace Head"
#define RECIPE_AXE 			"Axe Head"
#define RECIPE_SCRAP 		"Greatsword Blade"
#define RECIPE_CRUSHER 		"Greathammer Head"

#define RECIPE_DAGGER 		"Dagger Blade"
#define RECIPE_SPEAR 		"Spear Head"
#define RECIPE_JAVELIN 		"Javelin Head"
#define RECIPE_THROWING 	"Throwing Knife Blade"
#define RECIPE_TRIDENT 		"Trident Head"
#define RECIPE_SAW 			"Saw Blade"
#define RECIPE_BOWIE 		"Bowie Blade"

#define RECIPE_LANCE 		"Lance Head"
#define RECIPE_GLADIUS 		"Gladius Blade"
#define RECIPE_SPATHA 		"Spatha Blade"
#define RECIPE_WARHONED 	"Greataxe Blade"

#define RECIPE_KNUCKLES 	"Knuckledusters"
#define RECIPE_CLAWS 		"Claws"

GLOBAL_LIST_INIT(anvil_recipes, list(
	RECIPE_HAMMER = /obj/item/smithing/hammerhead,
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
	RECIPE_UNITOOL = /obj/item/smithing/unitool,
	RECIPE_MACHREFORG = /obj/item/smithing/macheterblade,
	RECIPE_SCRAP = /obj/item/smithing/scrapblade,
	RECIPE_GLADIUS =  /obj/item/smithing/gladiusblade,
	RECIPE_SPATHA = /obj/item/smithing/spathablade,
	RECIPE_WARHONED = /obj/item/smithing/warhonedhead,
	RECIPE_LANCE = /obj/item/smithing/lancehead,
	RECIPE_CRUSHER = /obj/item/smithing/crusherhead,
	RECIPE_TRIDENT = /obj/item/smithing/tridenthead,
	RECIPE_LONGSWORD = /obj/item/smithing/longswordblade,
	RECIPE_SAW = /obj/item/smithing/sawblade,
	RECIPE_BOWIE = /obj/item/smithing/bowieblade,
	RECIPE_KNUCKLES = /obj/item/smithing/unarmed/knuckles,
	RECIPE_CLAWS = /obj/item/smithing/unarmed/claws,
	))

/obj/structure/anvil
	name = "anvil"
	desc = "Base class of anvil. This shouldn't exist, but is useable."
	icon = 'icons/fallout/objects/crafting/blacksmith.dmi'
	icon_state = "anvil"
	density = TRUE
	anchored = TRUE
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 0.4
	light_color = LIGHT_COLOR_FIRE
	light_on = FALSE
	var/busy = FALSE //If someone is already interacting with this anvil
	var/workpiece_state = FALSE
	var/datum/material/workpiece_material
	var/anvilquality = 0
	var/currentquality = 0 //lolman? what the fuck do these vars do?
	var/currentsteps = 0 //even i don't know
	var/outrightfailchance = 1 //todo: document this shit
	var/stepsdone = ""
	var/rng = FALSE
	var/debug = FALSE //vv this if you want an artifact
	var/artifactrolled = FALSE
	var/itemqualitymax = 20 //A quality 8 bronze spear does less damage than a regular bone spear from craftmenu, lol


/obj/structure/anvil/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT,PROC_REF(ResetAnvil)) // emergency way to reset the anvil incase something goes wrong.
	currentquality = anvilquality

/obj/structure/anvil/attackby(obj/item/I, mob/user)
	if(!HAS_TRAIT(user, TRAIT_WEAPONSMITH))
		to_chat(user, span_warning("You arent a blacksmith, you have no clue how to work this thing!"))
		return
	if(istype(I, /obj/item/ingot)) // That's it we're refactoring this code because I can't im literally crying rn ; _;
		return HandleIngot(I, user)

	if(istype(I, /obj/item/melee/smith/hammer) || istype(I, /obj/item/twohanded/sledgehammer/simple)) // Hammer interactions:
		var/obj/item/melee/smith/hammer/hammertime = I // Even though they are two seperate object paths, I believe because we're only accessing qualitymod, it casts accordingly.
		// If the player has weaponsmith
		if(!HAS_TRAIT(user, TRAIT_WEAPONSMITH))
			to_chat(user, span_warning("You arent a blacksmith, you have no clue how to work this thing!"))
			return
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

/obj/structure/anvil/proc/SetBusy(value, mob/living/carbon/human/H)
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

/obj/structure/anvil/proc/HandleIngot(obj/item/ingot/notsword, mob/user)
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

		var/skillmod = 0
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
	var/list/shapingsteps = list(
		"Pickaxe Head",
		"Shovel Head",
		"Hammer Head",
		"Prospecting Pick Head",
		"Kitchen Knife Blade",
		"Crowbar",
		"Crowbaxe",
		"Ring",
		"Unchained Ball",
		"Machete Blade",
		"Sabre Blade",
		"Sword Blade",
		"Wakizashi Blade",
		"Katana Blade",
		"Longsword Blade",
		"Lawnmower Machete Blade",
		"Mace Head",
		"Axe Head",
		"Greatsword Blade",
		"Greathammer Head",
		"Dagger Blade",
		"Spear Head",
		"Javelin Head",
		"Throwing Knife Blade",
		"Trident Head",
		"Saw Blade",
		"Bowie Blade",
		"Lance Head",
		"Gladius Blade",
		"Spatha Blade",
		"Greataxe Blade",
		"Claws",
		"Knuckledusters"
		) //weak/strong/heavy hit affect strength. All the other steps shape.
	var/stepdone = input(user, "How would you like to work the metal?") in shapingsteps


	// if user is not in range, remove business.
	if(!locate(src) in range(1, user))
		return SetBusy(FALSE, user)


	// Time it takes for us to uh...forge..?
	var/steptime = 0.5 SECONDS
	if(user.mind.skill_holder) // Skill modifier to make it faster at blacksmithing.
		var/skillmod = user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing)/8 + 1 //Makes this faster as EXP gain was lowered
		steptime = 50 / skillmod

	if(!do_after(user, steptime, target = src))
		return SetBusy(FALSE, user)

	// I hate this.
	// I'd rather die.
	switch(stepdone)
		if("Pickaxe Head")
			stepsdone += "Pickaxe Head"
			currentsteps += 1
			currentquality -= 1
		if("Shovel Head")
			stepsdone += "Shovel Head"
			currentsteps += 1
			currentquality -= 1
		if("Hammer Head")
			stepsdone += "Hammer Head"
			currentsteps += 1
			currentquality -= 1
		if("Prospecting Pick Head")
			stepsdone += "Prospecting Pick Head"
			currentsteps += 1
			currentquality -= 1
		if("Kitchen Knife Blade")
			stepsdone += "Kitchen Knife Blade"
			currentsteps += 1
			currentquality -= 1
		if("Crowbar")
			stepsdone += "Crowbar"
			currentsteps += 1
			currentquality -= 1
		if("Crowbaxe")
			stepsdone += "Crowbaxe"
			currentsteps += 1
			currentquality -= 1
		if("Ring")
			stepsdone += "Ring"
			currentsteps += 1
			currentquality -= 1
		if("Unchained Ball")
			stepsdone += "Unchained Ball"
			currentsteps += 1
			currentquality -= 1
		if("Machete Blade")
			stepsdone += "Machete Blade"
			currentsteps += 1
			currentquality -= 1
		if("Sabre Blade")
			stepsdone += "Sabre Blade"
			currentsteps += 1
			currentquality -= 1
		if("Sword Blade")
			stepsdone += "Sword Blade"
			currentsteps += 1
			currentquality -= 1
		if("Wakizashi Blade")
			stepsdone += "Wakizashi Blade"
			currentsteps += 1
			currentquality -= 1
		if("Katana Blade")
			stepsdone += "Katana Blade"
			currentsteps += 1
			currentquality -= 1
		if("Longsword Blade")
			stepsdone += "Longsword Blade"
			currentsteps += 1
			currentquality -= 1
		if("Lawnmower Machete Blade")
			stepsdone += "Lawnmower Machete Blade"
			currentsteps += 1
			currentquality -= 1
		if("Mace Head")
			stepsdone += "Mace Head"
			currentsteps += 1
			currentquality -= 1
		if("Axe Head")
			stepsdone += "Axe Head"
			currentsteps += 1
			currentquality -= 1
		if("Greatsword Blade")
			stepsdone += "Greatsword Blade"
			currentsteps += 1
			currentquality -= 1
		if("Greathammer Head")
			stepsdone += "Greathammer Head"
			currentsteps += 1
			currentquality -= 1
		if("Dagger Blade")
			stepsdone += "Dagger Blade"
			currentsteps += 1
			currentquality -= 1
		if("Spear Head")
			stepsdone += "Spear Head"
			currentsteps += 1
			currentquality -= 1
		if("Javelin Head")
			stepsdone += "Javelin Head"
			currentsteps += 1
			currentquality -= 1
		if("Throwing Knife Blade")
			stepsdone += "Throwing Knife Blade"
			currentsteps += 1
			currentquality -= 1
		if("Trident Head")
			stepsdone += "Trident Head"
			currentsteps += 1
			currentquality -= 1
		if("Saw Blade")
			stepsdone += "Saw Blade"
			currentsteps += 1
			currentquality -= 1
		if("Bowie Blade")
			stepsdone += "Bowie Blade"
			currentsteps += 1
			currentquality -= 1
		if("Lance Head")
			stepsdone += "Lance Head"
			currentsteps += 1
			currentquality -= 1
		if("Gladius Blade")
			stepsdone += "Gladius Blade"
			currentsteps += 1
			currentquality -= 1
		if("Spatha Blade")
			stepsdone += "Spatha Blade"
			currentsteps += 1
			currentquality -= 1
		if("Greataxe Blade")
			stepsdone += "Greataxe Blade"
			currentsteps += 1
			currentquality -= 1
		if("Knuckledusters")
			stepsdone += "Knuckledusters"
			currentsteps += 1
			currentquality -= 1
		if("Claws")
			stepsdone += "Claws"
			currentsteps += 1
			currentquality -= 1

	// Display message
	user.show_message(span_notice("You hammer the metal into a [stepdone]."))

	// more sounds... uhhh...
	playsound(src, 'code/modules/smithing/sound/anvil_double3.ogg',30)

	// sparkles~
	do_smithing_sparks(1, TRUE, src)

	// the stepsdone is a string of characters which are actions made.
	// Once it is more or equal to 1, call try finish.
	if(length(stepsdone) >= 1)
		tryfinish(user)

	SetBusy(FALSE, user) // Set it to false, cause we're done now some how.

/obj/structure/anvil/proc/tryfinish(mob/user) // Oh god before I prettify this code I just feel like I'm having a stroke at all this word garble.

	var/artifactchance = 0
	var/combinedqualitymax = user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing)/4 + itemqualitymax //This is no longer as good. /2 divisor to /4 to make the max ~12
	if(!artifactrolled) // if there has not been a roll chance, do it now..?
		artifactchance = (1+(user.mind.get_skill_level(/datum/skill/level/dwarfy/blacksmithing)/2))/1500 //Bumps this up as removal of high-tier smithing items and a decrease to their balance makes artifacts neccessary and worthwhile
		//artifactrolled = TRUE --Disabled because this is a shitty mechanic.

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

		to_chat(user, span_warning("You overwork the metal, causing it to turn into useless slag!"))

		new /obj/item/stack/ore/slag(get_turf(src)) // Spawn some slag

		ResetAnvil() // Resets it to be default.

		if(user.mind.skill_holder) // give them some experience
			user.mind.auto_gain_experience(/datum/skill/level/dwarfy/blacksmithing, 50, 500000, silent = FALSE) //This shouldn't give you a full level until 3+

		return SetBusy(FALSE, user)

	// IF YOU DIDN'T FUCK UP THE RECIPE
	for(var/i in GLOB.anvil_recipes) // for each recipes.
		if(i == stepsdone) // if... "cum" == "bbu" idfk what the fuck am I looking at why isnt this a GLOB recipe list...

			var/obj/item/smithing/finisheditem = GLOB.anvil_recipes[stepsdone]
			finisheditem = new finisheditem(get_turf(src)) // Lets just spawn the item in immediately!

			to_chat(user, "You finish [finisheditem]!")

			// math to make quality better if its an artifact.
			if(artifact)
				to_chat(user, "It is an artifact, a creation whose legacy shall live on forevermore.") //todo: SSblackbox
				currentquality = max(currentquality, 2)
				finisheditem.artifact = TRUE
			else
				if(combinedqualitymax >= 0)
					finisheditem.quality = min(currentquality, combinedqualitymax) //Changed so better smiths can make better gear regardless of their anvil. WILL HAVE TO BE TWEAKED, POSSIBLY.
				else
					finisheditem.quality = min(currentquality, itemqualitymax)

			// more switcheronies~ Adds a description
			switch(finisheditem.quality)
				if(-1000 to -8)
					finisheditem.desc +=  "\nIt looks to be the most awfully made object you've ever seen."
				if(-8)
					finisheditem.desc +=  "\nIt looks to be the second most awfully made object you've ever seen."
				if(-8 to 0)
					finisheditem.desc +=  "\nIt looks to be barely passable as... whatever it's trying to pass for."
				if(0 to 10)
					finisheditem.desc +=  "\nIt looks to be totally average."
				if(10 to INFINITY)
					finisheditem.desc +=  "\nIt looks to be better than average."
			finisheditem.set_custom_materials(workpiece_material)
			var/stepexperience = currentsteps + finisheditem.quality
			var/finalexperience = (150 *(stepexperience + finisheditem.quality))/6 //Makes powerlevelling late-game harder as it gives more bonuses here
			if(user.mind.skill_holder) // give them some experience!
				if(currentquality <= 1)
					user.mind.auto_gain_experience(/datum/skill/level/dwarfy/blacksmithing, 250, 500000, silent = FALSE) //Fixes speedleveling by just making hammers, somewhat.
				else
					user.mind.auto_gain_experience(/datum/skill/level/dwarfy/blacksmithing, finalexperience, 500000, silent = FALSE) //Made more forgiving for lower levels and terrible anvils.

			workpiece_state = FALSE
			finisheditem.set_custom_materials(workpiece_material)
			currentquality = anvilquality
			stepsdone = ""
			currentsteps = 0
			outrightfailchance = 1
			artifactrolled = FALSE
			ResetAnvil() // Worse Case something might break if we dont do this. soo.... yeah!
			break


//////////////////////
//					//
//		ANVILS		//
//					//
//////////////////////

// Template
/obj/structure/anvil/obtainable
	name = "anvil template. Punish those who makes this appear."
	anvilquality = 0
	outrightfailchance = 5
	rng = TRUE

// Best anvil, should be hard to find or make more
/obj/structure/anvil/obtainable/basic
	name = "anvil"
	desc = "Made from solid steel, you wont be moving this around any time soon."
	anvilquality = -1 //This was causing balance problems to where you could get high levels of blacksmithing in 1-2 items
	itemqualitymax = 6  //Do not change this.

// Don't make this craftable.
/obj/structure/anvil/obtainable/legion
	name = "anvil"
	desc = "A solid steel anvil with a stamped bull on it."
	icon_state = "legvil"
	anvilquality = 0 //DO NOT GIVE A +1 BONUS TO ANVILS WHEN THEY HAVE A MAXQAL OF 8, THIS ONLY ASKS FOR MAX TIER FORGED ITEMS
	itemqualitymax = 8 //The legion and tribe rely mostly on melee weapons, so they should have the best anvil
	anchored = TRUE

// Decent makeshift anvil, can break, mobile. Gets the exclusive scrap version of the machete and 2h chopper, as well as the universal tool instead of a crowbar
/obj/structure/anvil/obtainable/table
	name = "table anvil"
	desc = "A reinforced table. Usable as an anvil, favored by mad wastelanders and the dregs of the wasteland. Can be loosened from its bolts and moved."
	icon_state = "tablevil"
	anvilquality = -2 //WE SHOULD NOT HAVE CHANGED THIS.
	itemqualitymax = 4

/obj/structure/anvil/obtainable/table/wrench_act(mob/living/user, obj/item/I)
	..()
	default_unfasten_wrench(user, I, 5)
	return TRUE

/obj/structure/anvil/obtainable/table/do_shaping(mob/user, qualitychange)
	if(prob(2))
		to_chat(user, "The [src] breaks under the strain!")
		take_damage(max_integrity, attacked_by = user)
		return FALSE
	else
		..()

// Worst craftable anvil, sturdy but limits the quality
/obj/structure/anvil/obtainable/sandstone
	name = "sandstone brick anvil"
	desc = "A big block of sandstone. Useable as an anvil."
	custom_materials = list(/datum/material/sandstone=8000)
	icon_state = "sandvil"
	anvilquality = 0
	itemqualitymax = 4

// Debug anvil for some reason
/obj/structure/anvil/debugsuper
	name = "super ultra epic anvil of debugging."
	desc = "WOW. A DEBUG <del>ITEM</DEL> STRUCTURE. EPIC."
	icon_state = "anvil"
	anvilquality = 10
	itemqualitymax = 9001
	outrightfailchance = 0

// Remnant trash
/obj/structure/anvil/obtainable/bronze
	name = "slab of bronze"
	desc = "A big block of bronze. Useable as an anvil."
	icon = 'icons/obj/smith.dmi'
	custom_materials = list(/datum/material/bronze=8000)
	icon_state = "ratvaranvil"
	anvilquality = 0
	itemqualitymax = 5 //Its too easy to obtain it

/obj/structure/anvil/obtainable/ratvar
	name = "brass anvil"
	desc = "A big block of what appears to be brass. Useable as an anvil, if whatever's holding the brass together lets you."
	icon = 'icons/obj/smith.dmi'
	custom_materials = list(/datum/material/bronze=8000)
	icon_state = "ratvaranvil"
	currentquality = 1
	itemqualitymax = 8
/*/obj/structure/anvil/obtainable/ratvar/attackby(obj/item/I, mob/user)
	if(is_servant_of_ratvar(user))
		return ..()
	else
		to_chat(user, span_neovgre("KNPXWN, QNJCQNW!")) //rot13 then rot22 if anyone wants to decode
*/
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
		to_chat(user, span_narsiesmall("That is not yours to use!"))

#undef WORKPIECE_PRESENT
#undef WORKPIECE_INPROGRESS
#undef WORKPIECE_FINISHED
#undef WORKPIECE_SLAG
