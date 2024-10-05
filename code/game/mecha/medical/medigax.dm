/obj/mecha/medical/medigax
	name = "\improper Medical Gygax"
	desc = "A Pre-Fall medical exosuit based on the Gygax platform. It features a robust suspension to safetly transport patients over rough terrain. The exterior plating is advertised as able to withstand minor impacts and is anti-microbial to boot."
	icon_state = "medigax"
	step_in = 1.75 // a little faster than an odysseus
	max_temperature = 25000
	max_integrity = 350
	wreckage = /obj/structure/mecha_wreckage/medigax
	armor = ARMOR_VALUE_HEAVY
	internal_damage_threshold = 30

/obj/mecha/medical/medigax/moved_inside(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		hud.add_hud_to(H)

/obj/mecha/medical/medigax/go_out()
	if(isliving(occupant))
		var/mob/living/carbon/human/L = occupant
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		hud.remove_hud_from(L)
	..()

/obj/mecha/medical/medigax/mmi_moved_inside(obj/item/mmi/mmi_as_oc, mob/user)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
		var/mob/living/brain/B = mmi_as_oc.brainmob
		hud.add_hud_to(B)
