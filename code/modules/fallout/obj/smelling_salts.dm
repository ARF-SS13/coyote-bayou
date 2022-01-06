//smelling salts
/obj/item/smelling_salts
	name = "smelling salts"
	desc = "A large glass phial of pungent smelling salts, used to revive those who have fainted.<br>It is bound in cord marking the colors of Caesars Legion,"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/fallout/objects/medicine/primitivedefib.dmi'
	icon_state = "smelling_salts"
	var/charges = 10
	var/in_use = FALSE
	var/time_to_use = 10 SECONDS // a defib is 5 seconds

/obj/item/smelling_salts/examine(mob/user)
	. = ..()
	if(in_range(user, src) || isobserver(user))
		. += "<span class='notice'>It currently has <b>[charges]</b> uses remaining.</span>"

/obj/item/smelling_salts/wayfarer
	icon_state = "smelling_salts_large"
	charges = 20
	w_class = WEIGHT_CLASS_NORMAL


/obj/item/smelling_salts/attack(mob/target, mob/user)
	if(in_use)
		return
	if(world.time < time_to_use)
		to_chat(user, "<span class='warning'>They are not ready smell something so pungent yet, I should wait a moment.</span>")
		return
	if(!user.IsAdvancedToolUser())
		to_chat(user, span_warning("You don't know how to use [src]!"))
		return
	if(!iscarbon(target))
		to_chat(user, span_warning("Do smelling salts even work on that?"))
		return
	var/mob/living/carbon/target_carbon = target

	if(user.zone_selected != BODY_ZONE_PRECISE_MOUTH && user.zone_selected != BODY_ZONE_HEAD)
		to_chat(user, span_warning("[target_carbon] has to smell [src] to be revived, hold it up to their face!"))
		return

	if((target_carbon.head?.flags_cover & HEADCOVERSMOUTH) || (target_carbon.wear_mask?.flags_cover & MASKCOVERSMOUTH))
		to_chat(user, span_notice("You're going to need to remove that [(target_carbon.head?.flags_cover & HEADCOVERSMOUTH) ? "helmet" : "mask"] first."))
		return

	else if(can_revive(target_carbon))
		target_carbon.notify_ghost_cloning("You're being revived with smelling salts. Re-enter your corpse if you want to be revived!", source = src)

	do_revive(target_carbon, user)
	charges--
	if(charges <= 0)
		to_chat(user, span_notice("[src] is now empty and useless; you throw it away."))
		qdel(src)

/obj/item/smelling_salts/proc/can_revive(mob/living/carbon/T)
	var/obj/item/organ/brain/BR = T.getorgan(/obj/item/organ/brain)
	var/obj/item/organ/heart = T.getorgan(/obj/item/organ/heart)
	var/tlimit = DEFIB_TIME_LIMIT * 10
	if(T.suiciding || T.hellbound || HAS_TRAIT(src, TRAIT_HUSK) || AmBloodsucker(T))
		return
	if ((world.time - T.timeofdeath) < tlimit)
		return
	if((T.getBruteLoss() >= 160) || (T.getFireLoss() >= 160))
		return
	if(!heart || (heart.organ_flags & ORGAN_FAILING))
		return
	if(QDELETED(BR) || BR.brain_death || (BR.organ_flags & ORGAN_FAILING))
		return
	return TRUE

/obj/item/smelling_salts/proc/do_revive(mob/living/carbon/revived_mob, mob/living/user)
	in_use = TRUE
	if(!do_after(user, time_to_use, target = revived_mob))
		in_use = FALSE
		return
	user.visible_message(span_notice("[user] starts waving [src] under [revived_mob]'s nose."), span_warning("You wave [src] under [revived_mob]'s nose."))
	var/time_since_death = world.time - revived_mob.timeofdeath
	// past this much time the patient is unrecoverable
	// (in deciseconds)
	// brain damage starts setting in on the patient after
	// some time left rotting
	var/total_burn	= 0
	var/total_brute	= 0
	if(!do_after(user, 20, target = revived_mob)) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
		in_use = FALSE
		return
	if((revived_mob.head?.flags_cover & HEADCOVERSMOUTH) || (revived_mob.wear_mask?.flags_cover & MASKCOVERSMOUTH)) // should've been checked prior, so it must've been put on during the pause
		to_chat(user, span_notice("You're going to need to remove that [(revived_mob.head?.flags_cover & HEADCOVERSMOUTH) ? "helmet" : "mask"] again."))
		in_use = FALSE
		return
	if(revived_mob.stat != DEAD)
		in_use = FALSE
		revived_mob.emote("cough")
		return
	total_brute	= revived_mob.getBruteLoss()
	total_burn	= revived_mob.getFireLoss()

	if (!can_revive(revived_mob))
		revived_mob.visible_message(span_warning("[revived_mob] doesn't respond..."))
		in_use = FALSE
		return
	else if(revived_mob.get_ghost())
		revived_mob.visible_message(span_warning("[revived_mob] gasps, but doesn't stir yet."))
		to_chat(user, span_notice("Perhaps they need another dose?"))
		in_use = FALSE
		return
	//If the body has been fixed so that they would not be in crit when revived, give them oxyloss to put them back into crit
	var/const/threshold = ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)
	var/tlimit = DEFIB_TIME_LIMIT * 10
	if (revived_mob.health > threshold)
		revived_mob.adjustOxyLoss(revived_mob.health - threshold, 0)
	else
		var/overall_damage = total_brute + total_burn + revived_mob.getToxLoss() + revived_mob.getOxyLoss()
		var/mobhealth = revived_mob.health
		revived_mob.adjustOxyLoss((mobhealth - threshold) * (revived_mob.getOxyLoss() / overall_damage), 0)
		revived_mob.adjustToxLoss((mobhealth - threshold) * (revived_mob.getToxLoss() / overall_damage), 0)
		revived_mob.adjustFireLoss((mobhealth - threshold) * (total_burn / overall_damage), 0)
		revived_mob.adjustBruteLoss((mobhealth - threshold) * (total_brute / overall_damage), 0)
	revived_mob.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
	revived_mob.visible_message(span_notice("[revived_mob] gasps and stirs!"), span_notice("You're alive!"))
	revived_mob.set_heartattack(FALSE) // if you can safely be revived without this, then this should be removed; smelling salts aren't a defib
	revived_mob.revive()
	revived_mob.emote("gasp")
	revived_mob.Jitter(20)
	if(time_since_death > tlimit)
		revived_mob.adjustOrganLoss(ORGAN_SLOT_BRAIN, max(0, min(99, ((tlimit - time_since_death) / tlimit * 100))), 150)
	log_combat(revived_mob, revived_mob, "revived", src)
	var/list/policies = CONFIG_GET(keyed_list/policyconfig)
	var/memory_limit = CONFIG_GET(number/defib_cmd_time_limit)
	var/late = memory_limit && (time_since_death > memory_limit)
	var/policy = late? policies[POLICYCONFIG_ON_DEFIB_LATE] : policies[POLICYCONFIG_ON_DEFIB_INTACT]
	if(policy)
		to_chat(revived_mob, policy)
	revived_mob.log_message("revived using strange reagent, [time_since_death / 10] seconds from time of death, considered [late? "late" : "memory-intact"] revival under configured policy limits.", LOG_GAME)
	//add_logs(user, revived_mob, "revived (smelling salts)", src)
	in_use = FALSE
