/obj/mecha/working/ripley
	name = "\improper APLU \"Ripley\""
	desc = "Autonomous Power Loader Unit. This newer model is refitted with powerful armour against the dangers of planetary mining."
	icon_state = "ripley"
	step_in = 3 //Move speed, lower is faster.
	max_temperature = 20000
	max_integrity = 300
	armor = list("melee" = 30, "bullet" = 15, "laser" = 10, "energy" = 20, "bomb" = 40, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	max_equip = 6
	wreckage = /obj/structure/mecha_wreckage/ripley
	var/list/cargo = new
	var/cargo_capacity = 15
	var/hides = 0

/obj/mecha/working/ripley/go_out()
	..()
	update_icon()

/obj/mecha/working/ripley/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()
/*
/obj/mecha/working/ripley/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate,3,/obj/item/stack/sheet/animalhide/goliath_hide,list("melee" = 10, "bullet" = 5, "laser" = 5))
*/
/obj/mecha/working/ripley/Destroy()
	for(var/atom/movable/A in cargo)
		A.forceMove(drop_location())
		step_rand(A)
	cargo.Cut()
	return ..()

/obj/mecha/working/ripley/firefighter
	desc = "Autonomous Power Loader Unit. This model is refitted with additional thermal protection."
	name = "\improper APLU \"Firefighter\""
	icon_state = "firefighter"
	step_in = 4
	max_temperature = 65000
	max_integrity = 400
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	armor = list("melee" = 40, "bullet" = 30, "laser" = 30, "energy" = 30, "bomb" = 60, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	max_equip = 5 // More armor, less tools
	wreckage = /obj/structure/mecha_wreckage/ripley/firefighter


/obj/mecha/working/ripley/deathripley // Admin-only mecha.
	desc = "OH SHIT IT'S THE DEATHSQUAD WE'RE ALL GONNA DIE"
	name = "\improper DEATH-RIPLEY"
	icon_state = "deathripley"
	step_in = 2
	max_temperature = 100000
	max_integrity = 500
	armor = list("melee" = 60, "bullet" = 40, "laser" = 40, "energy" = 40, "bomb" = 80, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	lights_power = 7
	wreckage = /obj/structure/mecha_wreckage/ripley/deathripley
	step_energy_drain = 0

/obj/mecha/working/ripley/deathripley/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill
	ME.attach(src)

/obj/mecha/working/ripley/deathripley/real
	desc = "OH SHIT IT'S THE DEATHSQUAD WE'RE ALL GONNA DIE. FOR REAL"

/obj/mecha/working/ripley/deathripley/real/Initialize()
	. = ..()
	for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
		E.detach()
		qdel(E)
	equipment.Cut()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/real
	ME.attach(src)

/obj/mecha/working/ripley/clarke
	desc = "A pre-War design by Vault-Tec to protect workers in hazardous post-War conditions. This model has had its internal ore box replaced with a generic storage module."
	name = "\improper Clarke"
	icon_state = "clarke"
	max_temperature = 65000
	max_integrity = 300
	step_in = 1.6
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	step_energy_drain = 30 //slightly higher energy drain since you movin those wheels FAST
	armor = list("melee" = 35, "bullet" = 15, "laser" = 20, "energy" = 20, "bomb" = 60, "bio" = 0, "rad" = 100, "fire" = 100, "acid" = 100)
	max_equip = 5
	wreckage = /obj/structure/mecha_wreckage/clarke
	cargo_capacity = 10
	canstrafe = FALSE

/obj/mecha/working/clarke/moved_inside(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.add_hud_to(H)

/obj/mecha/working/clarke/go_out()
	if(isliving(occupant))
		var/mob/living/L = occupant
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.remove_hud_from(L)
	return ..()

/obj/mecha/working/clarke/mmi_moved_inside(obj/item/mmi/M, mob/user)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		var/mob/living/brain/B = M.brainmob
		hud.add_hud_to(B)

/obj/mecha/working/ripley/mining
	desc = "An old, dusty mining Ripley."
	name = "\improper APLU \"Miner\""
	obj_integrity = 75 //Low starting health

/obj/mecha/working/ripley/mining/Initialize()
	. = ..()
	if(cell)
		cell.charge = FLOOR(cell.charge * 0.25, 1) //Starts at very low charge
	if(prob(70)) //Maybe add a drill
		if(prob(15)) //Possible diamond drill... Feeling lucky?
			var/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/D = new
			D.attach(src)
		else
			var/obj/item/mecha_parts/mecha_equipment/drill/D = new
			D.attach(src)

	else //Add plasma cutter if no drill
		var/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma/P = new
		P.attach(src)

	//Add ore box to cargo
	cargo.Add(new /obj/structure/ore_box(src))

	//Attach hydraulic clamp
	var/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/HC = new
	HC.attach(src)
	for(var/obj/item/mecha_parts/mecha_tracking/B in trackers)//Deletes the beacon so it can't be found easily
		qdel(B)

	var/obj/item/mecha_parts/mecha_equipment/mining_scanner/scanner = new
	scanner.attach(src)

/obj/mecha/working/ripley/Exit(atom/movable/O)
	if(O in cargo)
		return 0
	return ..()

/obj/mecha/working/ripley/Topic(href, href_list)
	..()
	if(href_list["drop_from_cargo"])
		var/obj/O = locate(href_list["drop_from_cargo"])
		if(O && (O in cargo))
			occupant_message("<span class='notice'>You unload [O].</span>")
			O.forceMove(drop_location())
			cargo -= O
			mecha_log_message("Unloaded [O]. Cargo compartment capacity: [cargo_capacity - src.cargo.len]")
	return

/obj/mecha/working/ripley/contents_explosion(severity, target)
	for(var/X in cargo)
		var/obj/O = X
		if(prob(30/severity))
			cargo -= O
			O.forceMove(drop_location())
	. = ..()

/obj/mecha/working/ripley/get_stats_part()
	var/output = ..()
	output += "<b>Cargo Compartment Contents:</b><div style=\"margin-left: 15px;\">"
	if(cargo.len)
		for(var/obj/O in cargo)
			output += "<a href='?src=[REF(src)];drop_from_cargo=[REF(O)]'>Unload</a> : [O]<br>"
	else
		output += "Nothing"
	output += "</div>"
	return output

/obj/mecha/working/ripley/relay_container_resist(mob/living/user, obj/O)
	to_chat(user, "<span class='notice'>You lean on the back of [O] and start pushing so it falls out of [src].</span>")
	if(do_after(user, 300, target = O))
		if(!user || user.stat != CONSCIOUS || user.loc != src || O.loc != src )
			return
		to_chat(user, "<span class='notice'>You successfully pushed [O] out of [src]!</span>")
		O.forceMove(drop_location())
		cargo -= O
	else
		if(user.loc == src) //so we don't get the message if we resisted multiple times and succeeded.
			to_chat(user, "<span class='warning'>You fail to push [O] out of [src]!</span>")
