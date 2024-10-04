// PARTS //
/obj/item/weaponcrafting
	icon = 'icons/obj/improvised.dmi'

/obj/item/weaponcrafting/stock
	name = "rifle stock"
	desc = "A classic rifle stock that doubles as a grip, roughly carved out of wood."
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 6)
	icon_state = "riflestock"

/obj/item/weaponcrafting/string
	name = "string"
	desc = "A long piece of thread with some resemblance to cable coil."
	icon_state = "durastring"

////////////////////////////////
// IMPROVISED WEAPON PARTS//
////////////////////////////////

/obj/item/weaponcrafting/improvised_parts
	name = "Debug Improvised Gun Part"
	desc = "A badly coded gun part. You should report coders if you see this."
	icon = 'icons/obj/guns/gun_parts.dmi'
	icon_state = "palette"

// RECEIVERS

/obj/item/weaponcrafting/improvised_parts/rifle_receiver
	name = "rifle receiver"
	desc = "A crudely constructed receiver to create an improvised bolt-action breechloaded rifle."  // removed some text implying that the item had more uses than it does
	icon_state = "receiver_rifle"
	w_class = WEIGHT_CLASS_SMALL


/obj/item/weaponcrafting/improvised_parts/shotgun_receiver
	name = "shotgun reciever"
	desc = "An improvised receiver to create a break-action breechloaded shotgun."  // removed some text implying that the item had more uses than it does
	icon_state = "receiver_shotgun"
	w_class = WEIGHT_CLASS_SMALL

// MISC

/obj/item/weaponcrafting/improvised_parts/trigger_assembly
	name = "firearm trigger assembly"
	desc = "A modular trigger assembly with a firing pin, this can be used to make a whole bunch of improvised firearms."
	icon_state = "trigger_assembly"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/weaponcrafting/improvised_parts/wooden_body
	name = "wooden firearm body"
	desc = "A crudely fashioned wooden body to help keep higher calibre improvised weapons from blowing themselves apart."
	icon_state = "wooden_body"

#define WB_DISASSEMBLY_STEP_SCREW (1<<0)
#define WB_DISASSEMBLY_STEP_WELD (1<<1)
#define WB_DISASSEMBLY_STEP_CUT (1<<2)
#define WB_DISASSEMBLY_STEP_CROWBAR (1<<3)
#define WB_DISASSEMBLY_STEP_ELECTRONICS (1<<4)
#define WB_DISASSEMBLY_STEP_CLUB (1<<5)

/obj/machinery/workbench
	name = "workbench"
	icon = 'icons/obj/machines/reloadingbench.dmi'
	icon_state = "standard_bench"
	desc = "A basic workbench for simple to intermediate projects."
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	machine_tool_behaviour = TOOL_WORKBENCH
	var/wrenchable = TRUE
	/// Can this thing be disassembled?
	var/can_disassemble = FALSE
	/// is currently being disassembled
	var/disassembling = FALSE
	/// The steps to be done after initiating deconstruction -- dont use wrench here, its used for something else
	var/disassembly_steps_remaining
	/// The step to do if you want to start deconstructing the thing -- dont use wrench here, its used for something else
	var/disassembly_start_step
	/// What comes out when its deconstructed. Technophreaks get about 50% more
	var/list/disassembly_loot = list()

/obj/machinery/workbench/examine(mob/user)
	. = ..()
	if(anchored)
		if(wrenchable)
			. += span_notice("The bolts holding it to the floor look loose enough to be removed with a wrench.")
		else
			. += span_notice("It looks to be so securely fastened to the floor that not even a wrench could loosen it.")
	else if(wrenchable)
		. += span_notice("It has a set of bolts at the base that could be wrenched to secure it to the floor.")
	if(can_disassemble && disassembly_start_step)
		. += disassembly_hints()

/obj/machinery/workbench/proc/disassembly_hints()
	if(!can_disassemble || !disassembly_start_step || !disassembly_steps_remaining)
		return
	var/list/msge = list()
	if(!disassembling)
		switch(disassembly_start_step)
			if(WB_DISASSEMBLY_STEP_SCREW)
				msge += span_notice("To begin disassembly, <b>unscrew</b> the supports.")
			if(WB_DISASSEMBLY_STEP_WELD)
				msge += span_notice("To begin disassembly, <b>unweld</b> the seams.")
			if(WB_DISASSEMBLY_STEP_CUT)
				msge += span_notice("To begin disassembly, <b>cut</b> the cables.")
			if(WB_DISASSEMBLY_STEP_CROWBAR)
				msge += span_notice("To begin disassembly, <b>pry</b> the panelling.")
			if(WB_DISASSEMBLY_STEP_ELECTRONICS)
				msge += span_notice("To begin disassembly, <b>bypass</b> the electronics.")
			if(WB_DISASSEMBLY_STEP_CLUB)
				msge += span_notice("To begin disassembly, <b>hit</b> it realy hard.")
	else
		var/original_steps = initial(disassembly_steps_remaining)
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_SCREW))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_SCREW))
				msge += span_notice("The supports are <b>screwed</b> in tight.")
			else
				msge += span_green("The supports have been <b>unscrewed</b>!")
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_WELD))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_WELD))
				msge += span_notice("The seams are <b>welded</b> together.")
			else
				msge += span_green("The seams have been <b>unwelded</b>!")
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CUT))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CUT))
				msge += span_notice("The cables are <b>intact</b>.")
			else
				msge += span_green("The cables have been <b>cut</b>!")
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CROWBAR))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CROWBAR))
				msge += span_notice("The panels are <b>in place</b>.")
			else
				msge += span_green("The panels have been <b>pried out</b>!")
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_ELECTRONICS))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_ELECTRONICS))
				msge += span_notice("The security protocols are <b>active</b>.")
			else
				msge += span_green("The security protocols have been <b>disabled</b>!")
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CLUB))
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CLUB))
				msge += span_notice("The plating is <b>not dented</b>.")
			else
				msge += span_green("The plating is <b>dented to heck</b>!")
	return msge.Join("<br>")

/obj/machinery/workbench/proc/try_disassemble(obj/item/tool, mob/user)
	if(!can_disassemble)
		return
	if(!istype(tool) || !istype(user))
		return

	var/original_steps = initial(disassembly_steps_remaining)
	if(!disassembling)
		switch(disassembly_start_step)
			if(WB_DISASSEMBLY_STEP_SCREW)
				if(tool.tool_behaviour != TOOL_SCREWDRIVER)
					return
				if(!tool.use_tool(src, user, 3 SECONDS, 0, 100))
					user.show_message(span_alert("You were interrupted!"))
					return
				disassembling = TRUE
				visible_message(span_notice("[user] <b>unscrewed</b> the outer bolts on [src]!"),
					span_green("You <b>unscrewed</b> the outer bolts on [src]!"))
				return TRUE

			if(WB_DISASSEMBLY_STEP_WELD)
				if(tool.tool_behaviour != TOOL_WELDER)
					return
				if(!tool.tool_start_check(user, amount=1))
					user.show_message(span_alert("You need at least 1 unit of fuel in that thing!"))
					return
				if(!tool.use_tool(src, user, 3 SECONDS, 0, 100))
					user.show_message(span_alert("You were interrupted!"))
					return
				disassembling = TRUE
				visible_message(span_notice("[user] <b>unwelded</b> the outer hull on [src]!"),
					span_green("You <b>unwelded</b> the outer hull on [src]!"))
				return TRUE

			if(WB_DISASSEMBLY_STEP_CUT)
				if(tool.tool_behaviour != TOOL_WIRECUTTER)
					return
				if(!tool.use_tool(src, user, 3 SECONDS, 0, 100))
					user.show_message(span_alert("You were interrupted!"))
					return
				disassembling = TRUE
				visible_message(span_notice("[user] <b>cut</b> the outer wires on [src]!"),
					span_green("You <b>cut</b> the outer wires on [src]!"))
				return TRUE

			if(WB_DISASSEMBLY_STEP_CROWBAR)
				if(tool.tool_behaviour != TOOL_CROWBAR)
					return
				if(!tool.use_tool(src, user, 3 SECONDS, 0, 100))
					user.show_message(span_alert("You were interrupted!"))
					return
				disassembling = TRUE
				visible_message(span_notice("[user] <b>pried</b> the outer covering off [src]!"),
					span_green("You <b>pried</b> the outer covering off [src]!"))
				return TRUE

			if(WB_DISASSEMBLY_STEP_ELECTRONICS)
				if(tool.tool_behaviour != TOOL_MULTITOOL)
					return
				if(!tool.use_tool(src, user, 3 SECONDS, 0, 100))
					user.show_message(span_alert("You were interrupted!"))
					return
				disassembling = TRUE
				visible_message(span_notice("[user] <b>bypassed</b> the outer security on [src]!"),
					span_green("You <b>bypassed</b> the outer security on [src]!"))
				return TRUE

			if(WB_DISASSEMBLY_STEP_CLUB)
				if(tool.force < 15)
					return
				disassembling = TRUE
				play_attack_sound(1)
				visible_message(span_notice("[user] <b>smashed</b> the outer cover on [src]!"),
					span_green("You <b>smashed</b> the outer cover on [src]!"))
				return TRUE
	else
		var/did_something = FALSE
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_SCREW) && tool.tool_behaviour == TOOL_SCREWDRIVER)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_SCREW))
				if(tool.use_tool(src, user, 3 SECONDS, 0, 100))
					DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_SCREW)
					visible_message(span_notice("[user] <b>unscrewed</b> the supports on [src]!"),
						span_green("You <b>unscrewed</b> the supports on [src]!"))
			else
				if(tool.use_tool(src, user, 0, 0, 100))
					ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_SCREW)
					visible_message(span_notice("[user] <b>screwed</b> the supports on [src] back in!"),
						span_notice("You <b>screwed</b> the supports on [src] back in!"))
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_WELD) && tool.tool_behaviour == TOOL_WELDER)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_WELD))
				if(tool.tool_start_check(user, amount=1))
					if(tool.use_tool(src, user, 3 SECONDS, 0, 100))
						DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_WELD)
						visible_message(span_notice("[user] <b>unwelded</b> the seams on [src]!"),
							span_green("You <b>unwelded</b> the seams on [src]!"))
				else
					to_chat(user, span_alert("You need at least 1 unit of fuel in your welder!"))
			else
				if(tool.use_tool(src, user, 0, 0, 100))
					ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_WELD)
					visible_message(span_notice("[user] <b>welded</b> the seams on [src] back together!"),
						span_green("You <b>welded</b> the supports on [src] back together!"))
		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CUT) && tool.tool_behaviour == TOOL_WIRECUTTER)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CUT))
				if(tool.use_tool(src, user, 3 SECONDS, 0, 100))
					DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CUT)
					visible_message(span_notice("[user] <b>cut</b> the cables on [src]!"),
						span_green("You <b>cut</b> the cables on [src]!"))
			else
				if(tool.use_tool(src, user, 0, 0, 100))
					ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CUT)
					visible_message(span_notice("[user] <b>mended</b> the supports on [src] back together!"),
						span_notice("You <b>mended</b> the supports on [src] back together!"))

		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CROWBAR) && tool.tool_behaviour == TOOL_CROWBAR)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CROWBAR))
				if(tool.use_tool(src, user, 3 SECONDS, 0, 100))
					DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CROWBAR)
					visible_message(span_notice("[user] <b>pried</b> the panels off [src]!"),
						span_green("You <b>pried</b> the panels off [src]!"))
			else
				if(tool.use_tool(src, user, 0, 0, 100))
					ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CROWBAR)
					visible_message(span_notice("[user] <b>replaced</b> the panels on [src]!"),
						span_notice("You <b>replaced</b> the panels on [src]!"))

		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_ELECTRONICS) && tool.tool_behaviour == TOOL_MULTITOOL)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_ELECTRONICS))
				if(tool.use_tool(src, user, 3 SECONDS, 0, 100))
					DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_ELECTRONICS)
					visible_message(span_notice("[user] <b>bypassed</b> [src]'s security!"),
						span_green("You <b>bypassed</b> the [src]'s security!"))
			else
				if(tool.use_tool(src, user, 0, 0, 100))
					ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_ELECTRONICS)
					visible_message(span_notice("[user] <b>reenabled</b> [src]'s security!"),
						span_notice("You <b>reenabled</b> [src]'s security!"))

		if(CHECK_BITFIELD(original_steps, WB_DISASSEMBLY_STEP_CLUB) && tool.force >= 15)
			did_something = TRUE
			if(CHECK_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CLUB))
				play_attack_sound(1)
				DISABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CLUB)
				visible_message(span_notice("[user] <b>bashed</b> [src]!"),
					span_green("You <b>bashed</b> the [src]!"))
			else
				play_attack_sound(1)
				ENABLE_BITFIELD(disassembly_steps_remaining, WB_DISASSEMBLY_STEP_CLUB)
				visible_message(span_notice("[user] <b>hit</b> [src] back into place!"),
					span_notice("You <b>hit</b> [src] back into place!"))
		if(!did_something)
			return FALSE
		if(!disassembly_steps_remaining)
			disassemble_it(user)
			return TRUE
		if(disassembly_steps_remaining == original_steps)
			disassembling = FALSE
			visible_message(span_notice("[user] <b>stopped</b> disassembling [src]!"),
				span_notice("You <b>stopped</b> disassembling [src]!"))
			return TRUE

/obj/machinery/workbench/proc/disassemble_it(mob/user)
	if(!user)
		return
	visible_message(span_notice("[user] <b>disassembled</b> [src] into a bunch of stuff!"),
		span_notice("You <b>disassembled</b> [src] into a bunch of stuff!"))
	playsound(src, 'sound/weapons/machine_crunch.ogg', 50, 1)
	var/turf/T = get_turf(src)
	for(var/path in disassembly_loot)
		new path(T)
	if(HAS_TRAIT(user, TRAIT_TECHNOPHREAK))
		for(var/path in disassembly_loot)
			if(prob(50))
				new path(T)
	qdel(src)

/obj/machinery/workbench/can_be_unfasten_wrench(mob/user, silent)
	if (!wrenchable)  // case also covered by NODECONSTRUCT checks in default_unfasten_wrench
		if(user && !silent)
			to_chat(user, span_alert("[src] is too securely fastened in place to be moved! Looks like it isn't going anywhere."))
		return CANT_UNFASTEN

	return ..()

/obj/machinery/workbench/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 10)
	return TRUE

/obj/machinery/workbench/attackby(obj/item/W, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	if(can_disassemble && try_disassemble(W, user))
		return
	if (istype(W, /obj/item/wrench) && !(flags_1&NODECONSTRUCT_1))
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return
	if(istype(W,/obj/item/salvage))
		var/obj/item/salvage/S = W
		S.make_loot(user, get_turf(src))

	if(istype(W,/obj/item/storage))
		var/obj/item/storage/baggy = W
		if(!baggy.in_use)
			baggy.in_use = TRUE
			for(var/obj/item/salvage/salvage_thingy in baggy.contents)
				if(!in_range(src, user))
					baggy.in_use = FALSE
					break
				if(!istype(salvage_thingy, /obj/item/salvage))//how did we get here
					continue
				if(!user.transferItemToLoc(salvage_thingy, drop_location()))
					baggy.in_use = FALSE
					break
				if(do_after(user,5,target = src))
					salvage_thingy.make_loot(user, get_turf(src))
				else
					break
					baggy.in_use = FALSE
			baggy.in_use = FALSE

/obj/machinery/workbench/advanced
	name = "advanced workbench"
	icon_state = "advanced_bench"
	desc = "A large and advanced Pre-Fall workbench to tackle any project!"
	machine_tool_behaviour = list(TOOL_AWORKBENCH, TOOL_WORKBENCH)
	wrenchable = TRUE
	can_disassemble = TRUE
	disassembly_steps_remaining = WB_DISASSEMBLY_STEP_SCREW | WB_DISASSEMBLY_STEP_WELD | WB_DISASSEMBLY_STEP_CUT | WB_DISASSEMBLY_STEP_CROWBAR | WB_DISASSEMBLY_STEP_CLUB
	disassembly_start_step = WB_DISASSEMBLY_STEP_ELECTRONICS
	disassembly_loot = list(
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/tool,
		/obj/item/salvage/tool,
		/obj/item/salvage/high,
		/obj/item/salvage/high,
		/obj/item/blueprint/research,
		/obj/item/blueprint/research,
		/obj/item/blueprint/research,
		/obj/item/stack/f13Cash/caps/onefivezero,
		)

/obj/machinery/workbench/mbench
	name = "machine workbench"
	//icon_state = "advanced_bench"
	desc = "A machining bench, useful for producing complex machined parts."
	machine_tool_behaviour = list(TOOL_WORKBENCH, TOOL_MWORKBENCH)
	can_disassemble = TRUE
	disassembly_steps_remaining = WB_DISASSEMBLY_STEP_WELD | WB_DISASSEMBLY_STEP_CUT | WB_DISASSEMBLY_STEP_CROWBAR | WB_DISASSEMBLY_STEP_CLUB
	disassembly_start_step = WB_DISASSEMBLY_STEP_SCREW
	disassembly_loot = list(
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/high,
		/obj/item/salvage/high,
		/obj/item/blueprint/research,
		/obj/item/stack/f13Cash/caps/fivezero,
		/obj/item/stack/sheet/mineral/wood/five,
		)

/obj/machinery/workbench/assbench
	name = "assembly workbench"
	//icon_state = "advanced_bench"
	desc = "An assembly bench, useful for assembling complex parts into semi-finished products."
	machine_tool_behaviour = list(TOOL_WORKBENCH, TOOL_ASSWORKBENCH)
	can_disassemble = TRUE
	disassembly_steps_remaining = WB_DISASSEMBLY_STEP_WELD | WB_DISASSEMBLY_STEP_CUT | WB_DISASSEMBLY_STEP_CROWBAR | WB_DISASSEMBLY_STEP_CLUB
	disassembly_start_step = WB_DISASSEMBLY_STEP_SCREW
	disassembly_loot = list(
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/high,
		/obj/item/salvage/high,
		/obj/item/blueprint/research,
		/obj/item/stack/f13Cash/caps/fivezero,
		/obj/item/stack/sheet/mineral/wood/five,
	)

/obj/machinery/workbench/fbench
	var/obj/item/prefabs/mould
	name = "moulding workbench"
	icon_state = "moulding"
	desc = "A moulding bench, used for superheating metal into its molten form and moulding it."
	machine_tool_behaviour = list(TOOL_WORKBENCH, TOOL_FWORKBENCH)
	wrenchable = FALSE
	can_disassemble = TRUE
	disassembly_steps_remaining = WB_DISASSEMBLY_STEP_WELD | WB_DISASSEMBLY_STEP_CUT | WB_DISASSEMBLY_STEP_CROWBAR | WB_DISASSEMBLY_STEP_CLUB
	disassembly_start_step = WB_DISASSEMBLY_STEP_SCREW
	disassembly_loot = list(
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/low,
		/obj/item/salvage/high,
		/obj/item/salvage/high,
		/obj/item/blueprint/research,
		/obj/item/stack/f13Cash/caps/fivezero,
		)

/obj/machinery/workbench/bottler
	name = "bottle press"
	icon_state = "bottler"
	desc = "A self-crafted all-in-one bottle making and pressing machine."
	machine_tool_behaviour = list(TOOL_BOTTLER)

/obj/machinery/workbench/forge
	name = "metalworking bench"
	desc = "A workbench with a drill press, a makeshift blowtorch setup, and various tools for making crude weapons and tools."
	icon = 'icons/fallout/machines/64x32.dmi'
	icon_state = "bench_metal"
	bound_width = 64
	machine_tool_behaviour = list(TOOL_WORKBENCH, TOOL_FORGE)
	can_disassemble = TRUE
	disassembly_steps_remaining = WB_DISASSEMBLY_STEP_WELD | WB_DISASSEMBLY_STEP_SCREW | WB_DISASSEMBLY_STEP_CROWBAR | WB_DISASSEMBLY_STEP_CLUB
	disassembly_start_step = WB_DISASSEMBLY_STEP_CUT
	disassembly_loot = list(
		/obj/item/stack/sheet/metal/twenty,
		/obj/item/stack/sheet/plasteel/five,
		)

/obj/item/weaponcrafting/receiver
	name = "modular receiver"
	desc = "A prototype modular receiver and trigger assembly for a firearm."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "receiver"

/obj/item/weaponcrafting/stock
	name = "rifle stock"
	desc = "A classic rifle stock that doubles as a grip, roughly carved out of wood."
	icon = 'icons/obj/improvised.dmi'
	icon_state = "riflestock"

/obj/machinery/autolathe/ammobench
	name = "universal reloading bench"
	desc = "A reloading bench used for inefficiently  crafting new ammunition out of scrap metal. There's a substantial supply of powder and primer. This one can be used to craft most NCR and Legion rounds."
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
//	machine_tool_behaviour = list(TOOL_LEGION, TOOL_NCR)
	categories = list("Security")
	super_advanced_technology = FALSE

/obj/machinery/ammobench
	name = "Pre-Fall reloading press"
	desc = "A high quality reloading press from before the war. Capable of cheap, mass production of ammunition."
	icon = 'icons/obj/machines/pre-fall_press.dmi'
	icon_state = "pre-fall_press"
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	machine_tool_behaviour = TOOL_RELOADER

/obj/machinery/ammobench/makeshift
	name = "makeshift reloading bench"
	desc = "A makeshift reloading bench capable of producing ammunition rather inefficiently."
	icon = 'icons/obj/machines/reloadingbench.dmi'
	icon_state = "reloading_bench"
	resistance_flags = INDESTRUCTIBLE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	anchored = TRUE
	machine_tool_behaviour = TOOL_MSRELOADER

/obj/machinery/ammobench/makeshift/wrench_act(mob/living/user, obj/item/I)
	default_unfasten_wrench(user, I, 10)
	return TRUE
