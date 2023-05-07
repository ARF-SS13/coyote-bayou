SUBSYSTEM_DEF(mobs)
	name = "Mobs"
	priority = FIRE_PRIORITY_MOBS
	flags = SS_KEEP_TIMING | SS_NO_INIT
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()
	var/static/list/clients_by_zlevel[][]
	var/static/list/dead_players_by_zlevel[][] = list(list()) // Needs to support zlevel 1 here, MaxZChanged only happens when z2 is created and new_players can login before that.
	var/static/list/cubemonkeys = list()
	var/static/list/cheeserats = list()

/datum/controller/subsystem/mobs/stat_entry(msg)
	msg = "P:[length(GLOB.mob_living_list)]"
	return ..()

/datum/controller/subsystem/mobs/proc/MaxZChanged()
	if (!islist(clients_by_zlevel))
		clients_by_zlevel = new /list(world.maxz,0)
		dead_players_by_zlevel = new /list(world.maxz,0)
	while (clients_by_zlevel.len < world.maxz)
		clients_by_zlevel.len++
		clients_by_zlevel[clients_by_zlevel.len] = list()
		dead_players_by_zlevel.len++
		dead_players_by_zlevel[dead_players_by_zlevel.len] = list()

/datum/controller/subsystem/mobs/fire(resumed = 0)
	var/seconds = wait * 0.1
	if (!resumed)
		src.currentrun = GLOB.mob_living_list.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun
	var/times_fired = src.times_fired
	while(currentrun.len)
		var/mob/living/L = currentrun[currentrun.len]
		currentrun.len--
		if(L)
			L.Life(seconds, times_fired)
		else
			GLOB.mob_living_list.Remove(L)
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/mobs/proc/should_plantigrade(spec_id, part_kind)
	if(part_kind != LIMB_DIGITIGRADE && part_kind != LIMB_AVIAN)
		return FALSE
	if(!spec_id)
		spec_id = SPECIES_HUMAN
	switch(spec_id)
		if("catslug", BODYTYPE_GOLEM, BODYTYPE_GOLEM_CULT, BODYTYPE_GOLEM_RATVAR, BODYTYPE_GOLEM_CLOTH, BODYTYPE_GOLEM_CLOTH, BODYTYPE_GOLEM_CLOTH, BODYTYPE_GOLEM_BONE)
			return TRUE

/datum/controller/subsystem/mobs/proc/get_species_part_icon(spec_id, part_kind)
	if(!spec_id)
		spec_id = SPECIES_HUMAN
	var/datum/species/my_spec = get_species(spec_id)
	if(should_plantigrade(spec_id, part_kind))
		part_kind = LIMB_PLANTIGRADE
	switch(spec_id)
		if(BODYTYPE_INSECT)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/insect.dmi'
				else
					return 'icons/mob/parts/body/color/insect.dmi'
		if(BODYTYPE_APID)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/bee.dmi'
				else
					return 'icons/mob/parts/body/color/bee.dmi'
		if(BODYTYPE_MOTH)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/moth.dmi'
				else
					return 'icons/mob/parts/body/greyscale/moth.dmi'
		if(BODYTYPE_MOTH_NOT_GREYSCALE)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/moth.dmi'
				else
					return 'icons/mob/parts/body/color/moth.dmi'
		if(SPECIES_HUMAN, SPECIES_VAMPIRE, SPECIES_ANGEL, SPECIES_DULLAHAN, SPECIES_DWARF, SPECIES_FELINID)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/human.dmi'
				else
					return 'icons/mob/parts/body/greyscale/human.dmi'
		if(SPECIES_AGENT)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/agent.dmi'
				else
					return 'icons/mob/parts/body/color/agent.dmi'
		if(SPECIES_FURRY, SPECIES_SYNTH_FURRY)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base_2.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base_2.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/furry.dmi'
				else
					return 'icons/mob/parts/body/greyscale/furry.dmi'
		if(BODYTYPE_AVIAN)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/aquatic.dmi'
				else
					return 'icons/mob/parts/body/greyscale/aquatic.dmi'
		if(BODYTYPE_AQUATIC)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/avian.dmi'
				else
					return 'icons/mob/parts/body/greyscale/avian.dmi'
		if(SPECIES_AVIAN)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/avian.dmi'
				else
					return 'icons/mob/parts/body/greyscale/avian.dmi'
		if(SPECIES_ETHEREAL)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/etherial.dmi'
				else
					return 'icons/mob/parts/body/greyscale/etherial.dmi'
		if(SPECIES_FLY)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/fly.dmi'
				else
					return 'icons/mob/parts/body/color/fly.dmi'
		if(SPECIES_GHOUL)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/ghoul.dmi'
				else
					return 'icons/mob/parts/body/color/ghoul.dmi'
		if(BODYTYPE_GOLEM)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/golem.dmi'
				else
					return 'icons/mob/parts/body/greyscale/golem.dmi'
		if(BODYTYPE_GOLEM_CULT)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/golem_cult.dmi'
				else
					return 'icons/mob/parts/body/color/golem_cult.dmi'
		if(BODYTYPE_GOLEM_RATVAR)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/golem_ratvar.dmi'
				else
					return 'icons/mob/parts/body/color/golem_ratvar.dmi'
		if(BODYTYPE_GOLEM_CLOTH, BODYTYPE_GOLEM_CLOTH)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/golem_cloth.dmi'
				else
					return 'icons/mob/parts/body/color/golem_cloth.dmi'
		if(BODYTYPE_GOLEM_BONE)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/golem_bone.dmi'
				else
					return 'icons/mob/parts/body/color/golem_bone.dmi'
		if(SPECIES_HOMUNCULUS)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/homonculus.dmi'
				else
					return 'icons/mob/parts/body/color/homonculus.dmi'
		if(SPECIES_JELLY)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/jelly.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/jelly.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/jelly.dmi'
				else
					return 'icons/mob/parts/body/greyscale/jelly.dmi'
		if(SPECIES_SLIME, SPECIES_SLIMEPERSON)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/slime.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/slime.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/slime.dmi'
				else
					return 'icons/mob/parts/body/greyscale/slime.dmi'
		if(SPECIES_SLIME_LUMINESCENT)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/slimelumi.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/slimelumi.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/slimelumi.dmi'
				else
					return 'icons/mob/parts/body/greyscale/slimelumi.dmi'
		if(SPECIES_SLIME_STARGAZER)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/slimestargazer.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/slimestargazer.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/slimestargazer.dmi'
				else
					return 'icons/mob/parts/body/greyscale/slimestargazer.dmi'
		if(SPECIES_LIZARD, SPECIES_LIZARD_ASHWALKER)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/lizard.dmi'
				else
					return 'icons/mob/parts/body/greyscale/lizard.dmi'
		if(SPECIES_MUSH)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base_2.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base_2.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/human.dmi'
				else
					return 'icons/mob/parts/body/greyscale/mushroom.dmi'
		if(SPECIES_PLASMAMAN)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/plasmaman.dmi'
				else
					return 'icons/mob/parts/body/color/plasmaman.dmi'
		if(SPECIES_PODPERSON, SPECIES_PODPERSON_WEAK)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/podperson.dmi'
				else
					return 'icons/mob/parts/body/greyscale/podperson.dmi'
		if("Shadekin")
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/shadekin.dmi'
				else
					return 'icons/mob/parts/body/greyscale/shadekin.dmi'
		if(SPECIES_SHADOW, SPECIES_NIGHTMARE)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/shadow.dmi'
				else
					return 'icons/mob/parts/body/color/shadow.dmi'
		if(SPECIES_SKELETON)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/skeleton.dmi'
				else
					return 'icons/mob/parts/body/color/skeleton.dmi'
		if(SPECIES_SUPERMUTANT)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/supermutant.dmi'
				else
					return 'icons/mob/parts/body/color/supermutant.dmi'
		if(SPECIES_SYNTH_LIZARD)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/synth_lizard.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/synth_lizard.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/synth_lizard.dmi'
				else
					return 'icons/mob/parts/body/greyscale/synth_lizard.dmi'
		if(SPECIES_SYNTH, SPECIES_SYNTH_MILITARY, SPECIES_ANDROID)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/synth.dmi'
				else
					return 'icons/mob/parts/body/color/synth.dmi'
		if(SPECIES_XENO)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/xeno.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/xeno.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/greyscale/xeno.dmi'
				else
					return 'icons/mob/parts/body/greyscale/xeno.dmi'
		if(SPECIES_ZOMBIE)
			switch(part_kind)
				if(LIMB_AVIAN)
					return 'icons/mob/parts/legs/avian/base_2.dmi'
				if(LIMB_DIGITIGRADE)
					return 'icons/mob/parts/legs/digitigrade/base_2.dmi'
				if(LIMB_PLANTIGRADE)
					return 'icons/mob/parts/legs/plantigrade/color/zombie.dmi'
				else
					return 'icons/mob/parts/body/color/zombie.dmi'

