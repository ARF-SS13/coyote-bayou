/datum/species_body_type
	var/name = BODYTYPE_HUMAN
	var/sexes = TRUE
	var/body = 'icons/mob/species/body/greyscale/human.dmi'
	var/body_greyscale = TRUE
	var/plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/human.dmi'
	var/plantigrade_greyscale = TRUE
	var/only_plantigrade = FALSE
	var/digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	var/digitigrade_greyscale = TRUE
	var/avian = 'icons/mob/species/legs/avian/base.dmi'
	var/avian_greyscale = TRUE

/datum/species_body_type/proc/get_icon(bodyzone, legkind)
	switch(bodyzone)
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(legkind == LEGS_PLANTIGRADE || only_plantigrade)
				return plantigrade
			if(legkind == LEGS_DIGITIGRADE)
				return digitigrade
			if(legkind == LEGS_AVIAN)
				return avian
		else
			return body

/datum/species_body_type/proc/is_greyscale(bodyzone, legkind)
	switch(bodyzone)
		if(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
			if(legkind == LEGS_PLANTIGRADE || only_plantigrade)
				return plantigrade_greyscale
			if(legkind == LEGS_DIGITIGRADE)
				return digitigrade_greyscale
			if(legkind == LEGS_AVIAN)
				return avian_greyscale
		else
			return body_greyscale

/datum/species_body_type/abductor
	name = BODYTYPE_ABDUCTOR
	sexes = FALSE
	body = 'icons/mob/species/body/color/abductor.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/human.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/agent
	name = BODYTYPE_AGENT
	sexes = FALSE
	body = 'icons/mob/species/body/color/agent.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/agent.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/apid
	name = BODYTYPE_APID
	body = 'icons/mob/species/body/color/bee.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/bee.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/aquatic
	name = BODYTYPE_AQUATIC
	body = 'icons/mob/species/body/greyscale/aquatic.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/aquatic.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/avian
	name = BODYTYPE_AVIAN
	body = 'icons/mob/species/body/greyscale/avian.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/avian.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/catslug
	name = BODYTYPE_CATSLUG
	body = 'icons/mob/species/body/greyscale/catslug.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/catslug.dmi'
	plantigrade_greyscale = TRUE
	only_plantigrade = TRUE

/datum/species_body_type/ethereal
	name = BODYTYPE_ETHEREAL
	body = 'icons/mob/species/body/greyscale/ethereal.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/etherial.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/fly
	name = BODYTYPE_FLY
	sexes = FALSE
	body = 'icons/mob/species/body/color/fly.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/fly.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/furry
	name = BODYTYPE_FURRY
	body = 'icons/mob/species/body/greyscale/furry.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/furry.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base_2.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base_2.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/insect
	name = BODYTYPE_INSECT
	body = 'icons/mob/species/body/greyscale/insect.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/moth.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/moth
	name = BODYTYPE_MOTH
	body = 'icons/mob/species/body/greyscale/moth.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/moth.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/ghoul
	name = BODYTYPE_GHOUL
	body = 'icons/mob/species/body/color/ghoul.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/ghoul.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/ghoul_glowing
	name = BODYTYPE_GHOUL_GLOWING
	sexes = FALSE
	body = 'icons/mob/species/body/color/ghoul_glowing.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/ghoul_glowing.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/golem_greyscale
	name = BODYTYPE_GOLEM
	body = 'icons/mob/species/body/greyscale/golem.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/golem.dmi'
	plantigrade_greyscale = TRUE
	only_plantigrade = TRUE

/datum/species_body_type/golem_ratvar
	name = BODYTYPE_GOLEM_RATVAR
	sexes = FALSE
	body = 'icons/mob/species/body/color/golem_ratvar.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/golem_ratvar.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/golem_bone
	name = BODYTYPE_GOLEM_BONE
	sexes = FALSE
	body = 'icons/mob/species/body/color/golem_bone.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/golem_bone.dmi'
	plantigrade_greyscale = TRUE
	only_plantigrade = TRUE

/datum/species_body_type/golem_cardboard
	name = BODYTYPE_GOLEM_CARDBOARD
	body = 'icons/mob/species/body/color/golem_cardboard.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/golem_cardboard.dmi'
	plantigrade_greyscale = TRUE
	only_plantigrade = TRUE

/datum/species_body_type/golem_cloth
	name = BODYTYPE_GOLEM_CLOTH
	sexes = FALSE
	body = 'icons/mob/species/body/color/golem_cloth.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/golem_cloth.dmi'
	plantigrade_greyscale = TRUE
	only_plantigrade = TRUE

/datum/species_body_type/golem_cult
	name = BODYTYPE_GOLEM_CULT
	sexes = FALSE
	body = 'icons/mob/species/body/color/golem_cult.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/golem_cult.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/homonculus
	name = BODYTYPE_HOMUNCULUS
	sexes = FALSE
	body = 'icons/mob/species/body/color/homonculus.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/homonculus.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/lizard
	name = BODYTYPE_LIZARD
	body = 'icons/mob/species/body/greyscale/lizard.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/lizard.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/moth
	name = BODYTYPE_MOTH
	body = 'icons/mob/species/body/greyscale/moth.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/moth.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/mushroom
	name = BODYTYPE_MUSH
	body = 'icons/mob/species/body/greyscale/mushroom.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/human.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base_2.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base_2.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/plasmaman
	name = BODYTYPE_PLASMAMAN
	sexes = FALSE
	body = 'icons/mob/species/body/color/plasmaman.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/plasmaman.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/podperson
	name = BODYTYPE_PODPERSON
	sexes = FALSE
	body = 'icons/mob/species/body/greyscale/podperson.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/podperson.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/skeleton
	name = BODYTYPE_SKELETON
	sexes = FALSE
	body = 'icons/mob/species/body/color/skeleton.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/skeleton.dmi'
	plantigrade_greyscale = FALSE
	only_plantigrade = TRUE

/datum/species_body_type/jelly
	name = BODYTYPE_JELLY
	body = 'icons/mob/species/body/greyscale/jelly.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/jelly.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/jelly.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/jelly.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/slime
	name = BODYTYPE_SLIME
	body = 'icons/mob/species/body/greyscale/slime.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/slime.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/slime.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/slime.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/slime_lumi
	name = BODYTYPE_SLIME_LUMINESCENT
	body = 'icons/mob/species/body/greyscale/slimelumi.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/slimelumi.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/slimelumi.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/slimelumi.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/slime_stargazer
	name = BODYTYPE_SLIME_STARGAZER
	body = 'icons/mob/species/body/greyscale/slimestargazer.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/slimestargazer.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/slimestargazer.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/slimestargazer.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/shadekin
	name = BODYTYPE_SHADEKIN
	body = 'icons/mob/species/body/greyscale/shadekin.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/shadekin.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/shadow
	name = BODYTYPE_SHADOW
	sexes = FALSE
	body = 'icons/mob/species/body/color/shadow.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/shadow.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/supermutant
	name = BODYTYPE_SUPERMUTANT
	sexes = FALSE
	body = 'icons/mob/species/body/color/supermutant.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/supermutant.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/synth_lizard
	name = BODYTYPE_SYNTH_LIZARD
	body = 'icons/mob/species/body/greyscale/synth_lizard.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/synth_lizard.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/synth_lizard.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/synth_lizard.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/ipc
	name = BODYTYPE_SYNTH_IPC
	sexes = FALSE
	body = 'icons/mob/species/body/greyscale/ipc.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/ipc.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/synth_lizard.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/synth_lizard.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/ipc_dark
	name = BODYTYPE_SYNTH_IPC_DARK
	sexes = FALSE
	body = 'icons/mob/species/body/color/ipc_dark.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/ipc_dark.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/synth_lizard.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/synth_lizard.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/synth
	name = BODYTYPE_SYNTH_MILITARY
	sexes = FALSE
	body = 'icons/mob/species/body/color/synth.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/synth.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/xeno
	name = BODYTYPE_XENO
	body = 'icons/mob/species/body/greyscale/xeno.dmi'
	body_greyscale = TRUE
	plantigrade = 'icons/mob/species/legs/plantigrade/greyscale/xeno.dmi'
	plantigrade_greyscale = TRUE
	digitigrade = 'icons/mob/species/legs/digitigrade/xeno.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/xeno.dmi'
	avian_greyscale = TRUE

/datum/species_body_type/zombie
	name = BODYTYPE_ZOMBIE
	sexes = FALSE
	body = 'icons/mob/species/body/color/zombie.dmi'
	body_greyscale = FALSE
	plantigrade = 'icons/mob/species/legs/plantigrade/color/zombie.dmi'
	plantigrade_greyscale = FALSE
	digitigrade = 'icons/mob/species/legs/digitigrade/base_2.dmi'
	digitigrade_greyscale = TRUE
	avian = 'icons/mob/species/legs/avian/base_2.dmi'
	avian_greyscale = TRUE


