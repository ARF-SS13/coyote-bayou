/* 
 * Author: r0c the f0x
 * Date: 2021-07-07
 * License: CC0
 * 
 * This is a simple toolable component for adding in self-contained tool interactions.
 * This way you can have one brunch of code that can be used for multiple objects.
 * so we dont have to copypaste the same damn code over and over again.
 * Seriously, the salvage code was all over the place!
 * 
 * And yes, I know that the code is a bit messy, but I'm not a coder, I'm a fox.
 * I gekker and screech, big and soft paws, and my turn-ons are headpats and belly rubs.
 * Put me in your game, I'm a good boi.
 */

/datum/component/toolable
	var/list/ckeys_using_me = list() // public use component uwu
	var/list/valid_tools = list()

/datum/component/toolable/Initialize()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ATOM_TOOL_ACT,PROC_REF(OnToolAct))

/datum/component/toolable/proc/OnToolAct(atom/source, mob/living/user, obj/item/tool, tool_type)
	if(!isitem(tool) || !tool.tool_behaviour)
		return FALSE
	if(!user || !user.client || (user.client.ckey in ckeys_using_me))
		return FALSE
	if(!(tool_type in valid_tools))
		return FALSE
	switch(tool_type)
		if(TOOL_CROWBAR)
			return OnCrowbarAct(user, tool) 
		if(TOOL_MULTITOOL)
			return OnMultitoolAct(user, tool)
		if(TOOL_SCREWDRIVER)
			return OnScrewdriverAct(user, tool)
		if(TOOL_WRENCH)
			return OnWrenchAct(user, tool)
		if(TOOL_WIRECUTTER)
			return OnWirecutterAct(user, tool)
		if(TOOL_WELDER)
			return OnWelderAct(user, tool)
		if(TOOL_ANALYZER)
			return OnAnalyzerAct(user, tool)
	return FALSE

/datum/component/toolable/proc/OnCrowbarAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnMultitoolAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnScrewdriverAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnWrenchAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnWirecutterAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnWelderAct(mob/living/user, obj/item/tool)
	return FALSE

/datum/component/toolable/proc/OnAnalyzerAct(mob/living/user, obj/item/tool)
	return FALSE

#define SCRAP_RARITY_COMMON "common"
#define SCRAP_RARITY_UNCOMMON "uncommon"
#define SCRAP_RARITY_RARE "rare"
#define SCRAP_EXTRA_ROLL_CHANCE "extra_roll_chance"

/* 
 * This is a simple salvage component for adding in self-contained salvage interactions.
 */
/datum/component/toolable/salvage
	var/depleted = FALSE
	var/dropped_things = 0
	var/guaranteed_drops = 8
	var/max_drops = 16
	var/del_on_deplete = TRUE
	var/base_time_per_drop = 4 SECONDS
	var/trash_per_drop = 1
	var/list/bonus_traits = list() // traits that add bonuses to the salvage results, and how effective
	var/list/valid_containers = list()

	var/list/rarity_table = list(
		SCRAP_RARITY_UNCOMMON = 20,
		SCRAP_RARITY_RARE = 5,
	)
	var/list/common_loot_table = list(/obj/item/salvage/low = 1)
	var/list/uncommon_loot_table = list(/obj/item/salvage/high = 1)
	var/list/rare_loot_table = list(/obj/item/salvage/tool = 1)
	var/list/extra_trash = list(/obj/effect/spawner/lootdrop/f13/trash = 1)
	var/atom/movable/trashpath = /obj/effect/spawner/lootdrop/f13/trash

/// all those procs are cool and all, but im cooler
/datum/component/toolable/salvage/OnCrowbarAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnMultitoolAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnScrewdriverAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnWrenchAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnWirecutterAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnWelderAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/OnAnalyzerAct(mob/living/user, obj/item/tool)
	return CommonToolAct(user, tool)

/datum/component/toolable/salvage/proc/CommonToolAct(mob/living/user, obj/item/tool)
	if(depleted)
		return FALSE
	. = STOP_ATTACK_PROC_CHAIN
	INVOKE_ASYNC(src, PROC_REF(DisassembleLoop), user, tool)

/// First half of the disassembly process, prechecks, leading into the actual disassembly.
/datum/component/toolable/salvage/proc/DisassembleLoop(mob/living/user, obj/item/tool)
	if(!ShouldProceed(user, tool))
		Abort(user, tool)
		return
	ckeys_using_me |= user.ckey
	var/obj/item/offhand = user.get_inactive_held_item()
	var/offhand_mult = GetOffhandMult(user, tool, offhand)
	var/time_mult = tool.toolspeed * offhand_mult
	var/salvage_time = base_time_per_drop * time_mult
	StartDisassembleMessage(user, tool, salvage_time, offhand)
	if(!tool.use_tool(parent, user, salvage_time, volume = 75))
		return Abort(user, tool)
	DropSomething(user, tool)
	DisassembleLoop(user, tool) // LAP 2

/datum/component/toolable/salvage/proc/Abort(mob/living/user, obj/item/tool)
	AbortMessage(user, tool)
	ckeys_using_me -= user.ckey

/// override with your cool tool!
/datum/component/toolable/salvage/proc/GetOffhandMult(mob/living/user, obj/item/tool, obj/item/offhand)
	return 1

/datum/component/toolable/salvage/proc/DropSomething(mob/living/user, obj/item/tool)
	var/list/modified_rarity_table = rarity_table.Copy()
	for(var/trait in bonus_traits)
		if(HAS_TRAIT(user, trait))
			modified_rarity_table[SCRAP_RARITY_UNCOMMON] += bonus_traits[trait][SCRAP_RARITY_UNCOMMON]
			modified_rarity_table[SCRAP_RARITY_RARE] += bonus_traits[trait][SCRAP_RARITY_RARE]
	var/finalrarity = SCRAP_RARITY_COMMON
	if(prob(modified_rarity_table[SCRAP_RARITY_UNCOMMON]))
		finalrarity = SCRAP_RARITY_UNCOMMON
	else if(prob(modified_rarity_table[SCRAP_RARITY_RARE]))
		finalrarity = SCRAP_RARITY_RARE
	var/list/loot_table
	switch(finalrarity)
		if(SCRAP_RARITY_COMMON)
			loot_table = common_loot_table
		if(SCRAP_RARITY_UNCOMMON)
			loot_table = uncommon_loot_table
		if(SCRAP_RARITY_RARE)
			loot_table = rare_loot_table
	var/atom/movable/loot = pickweight(loot_table)
	if(ispath(loot))
		loot = new loot(get_turf(user))
		dropped_things += 1
		if(!StuffItSomewhere(user, loot))
			ItWentOnTheGroundMessage(user, loot)
	for(var/i in 1 to trash_per_drop)
		new trashpath(get_turf(user))

/// finds a warm, wet sack to stuff the loot into
/datum/component/toolable/salvage/proc/StuffItSomewhere(mob/living/user, atom/movable/loot)
	if(!loot || !user)
		return
	if(!isitem(loot))
		return // no stuffing non-items
	if(!LAZYLEN(valid_containers))
		return // no stuffing if there are no valid containers
	var/obj/item/lootitem = loot
	/// check the player for a salvage bag
	var/list/atomstocheck = user.contents | user.loc.contents
	if(istype(user.pulling))
		atomstocheck |= user.pulling.contents
		atomstocheck |= user.pulling.loc.contents
	for(var/obj/item/wornhold in atomstocheck)
		for(var/coolpath in valid_containers)
			if(istype(wornhold, coolpath))
				if(SEND_SIGNAL(wornhold, COMSIG_TRY_STORAGE_INSERT, lootitem))
					ItWentSomewhereMessage(user, lootitem, wornhold)
					return TRUE
	return FALSE

/datum/component/toolable/salvage/proc/ShouldProceed(mob/living/user, obj/item/tool)
	if(!user.Adjacent(parent))
		return FALSE
	if(user.stat != CONSCIOUS)
		return FALSE
	if(dropped_things >= max_drops)
		MarkDepleted(user, tool)
		return FALSE
	if(dropped_things >= guaranteed_drops && !RollForExtras(user, tool))
		MarkDepleted(user, tool)
		return FALSE
	return TRUE

/datum/component/toolable/salvage/proc/MarkDepleted(mob/living/user, obj/item/tool)
	depleted = TRUE
	DepletedMessage(user, tool)
	if(del_on_deplete)
		qdel(parent)

/datum/component/toolable/salvage/proc/RollForExtras(mob/living/user, obj/item/tool)
	for(var/trait in bonus_traits)
		if(HAS_TRAIT(user, trait))
			if(prob(bonus_traits[trait][SCRAP_EXTRA_ROLL_CHANCE]))
				to_chat(user, span_notice("Your skills help you find some extra salvage from [parent]."))
				return TRUE

/datum/component/toolable/salvage/proc/StartDisassembleMessage(mob/living/user, obj/item/tool, time, obj/item/offhand)
	return // replace with a message!

/datum/component/toolable/salvage/proc/AbortMessage(mob/living/user, obj/item/tool)
	return

/datum/component/toolable/salvage/proc/DepletedMessage(mob/living/user, obj/item/tool)
	return // replace with a message!

/// if the loot can't be stuffed, it goes on the ground
/datum/component/toolable/salvage/proc/ItWentOnTheGroundMessage(mob/living/user, atom/movable/loot)
	return // replace with a message!

/// if the loot can be stuffed, it goes in the container
/datum/component/toolable/salvage/proc/ItWentSomewhereMessage(mob/living/user, atom/movable/loot, obj/item/dest)
	return // replace with a message!

/datum/component/toolable/salvage/welder
	valid_tools = list(TOOL_WELDER)
	valid_containers = list(/obj/item/storage/bag/salvage, /obj/item/storage/bag/salvagestorage)
	bonus_traits = list(
		TRAIT_TECHNOPHREAK = list(
			SCRAP_RARITY_UNCOMMON = 0,
			SCRAP_RARITY_RARE = 0,
			SCRAP_EXTRA_ROLL_CHANCE = 50,
		)
	)

/datum/component/toolable/salvage/welder/StartDisassembleMessage(mob/living/user, obj/item/tool, time, obj/item/offhand)
	if(!user || !tool)
		return
	var/welder_akimbo = offhand && offhand.tool_behaviour == TOOL_WELDER
	var/speediness = ""
	if(time < base_time_per_drop)
		speediness = "quickly "
	if(time < base_time_per_drop * 0.5)
		speediness = "very quickly "
	if(time > base_time_per_drop * 2)
		speediness = "slowly"

	/// you start Wing through X with your Y welder, Zly.
	var/static/list/chunkparts = list(
		"part of the frame",
		"part of the casing",
		"part of the handle",
		"part of the nozzle",
		"part of the fuel tank",
		"part of the power supply",
		"part of the cooling system",
		"part of the control system",
		"part of the safety system",
		"chunk of the frame",
		"hunk of fused metal",
		"telefragged subsystem",
		"melted component",
		"rusty jagged bit",
		"out of place part",
		"warped thingy",
		"banged up whatsit",
		"broken thingamajig",
		"totalled bingus",
		"mangled doohickey",
		"scraped up whatsit",
	)
	var/part = pick(chunkparts)
	var/static/list/whatimdoing = list(
		"cutting through",
		"unwelding",
		"disassembling",
		"taking apart",
		"breaking down",
		"deconstructing",
		"freeing",
		"separating",
		"slicing free"
	)
	var/doing = pick(whatimdoing)
	var/with_what = "with [tool]."
	if(welder_akimbo)
		with_what = "with both of your welders, like a pro!"
	to_chat(user, "You start [doing] \a [part] [speediness][with_what]")

/datum/component/toolable/salvage/welder/AbortMessage(mob/living/user, obj/item/tool)
	if(!user || !tool)
		return
	to_chat(user, span_alert("You stop cutting it up."))

/datum/component/toolable/salvage/welder/DepletedMessage(mob/living/user, obj/item/tool)
	if(!user || !tool)
		return
	var/atom/wreck = parent
	wreck.audible_message(span_alert("\The [wreck] falls apart, all the valuable bits cut free!"))

/datum/component/toolable/salvage/welder/ItWentOnTheGroundMessage(mob/living/user, atom/movable/loot)
	if(!user || !loot)
		return
	to_chat(user, span_notice("You cut free a [loot] from [parent]."))

/datum/component/toolable/salvage/welder/ItWentSomewhereMessage(mob/living/user, atom/movable/loot, obj/item/dest)
	if(!user || !loot || !dest)
		return
	to_chat(user, span_notice("You cut free a [loot] from [parent] and put it in [dest]."))

/datum/component/toolable/salvage/welder/ShouldProceed(mob/living/user, obj/item/tool)
	. = ..()
	if(!.)
		return FALSE
	if(!tool.tool_start_check(user, amount=2))
		return FALSE
	return TRUE

/datum/component/toolable/salvage/welder/GetOffhandMult(mob/living/user, obj/item/tool, obj/item/offhand)
	if(offhand && offhand.tool_behaviour == TOOL_WELDER)
		if(offhand.tool_start_check(user, amount=2))
			return 0.85
	return 1



