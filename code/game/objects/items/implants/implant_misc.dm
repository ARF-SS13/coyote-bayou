/obj/item/implant/weapons_auth
	name = "firearms authentication implant"
	desc = "Lets you shoot your guns."
	icon_state = "auth"
	activated = 0

/obj/item/implant/weapons_auth/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Firearms Authentication Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Allows operation of implant-locked weaponry, preventing equipment from falling into enemy hands."}
	return dat


/obj/item/implant/adrenalin
	name = "FighterFlight adrenal implant"
	desc = "An implantable device that delivers a potent mix of rescue drugs when it detects critical injuries. May cause weakness, muscle spasms, and the complete inability to shoot straight. \
		<br><br><b>WARNING:</b> This implant is not intended for use by the elderly, the infirm, or the pregnant. Multiple implants may have unintended effects. No refunds."
	icon_state = "adrenal"
	uses = 1
	actions_types = list()
	var/juicing


/obj/item/implant/adrenalin/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Nash Salvage and Research Endogenous Rescue Implant<BR>
				<b>Life:</b> 48 hours.<BR>
				<HR>
				<b>Implant Details:</b> Delivers a dose of rescue drugs to the host upon critial injury.<BR>
				<b>Contents:</b> Epinephrine, Coagulant, Water, Adrenaline.<BR>
				<b>Function:</b> Removes stuns, increases speed, and has a mild healing effect.<BR>
				<b>Integrity:</b> Implant is destroyed on use."}
	return dat

/obj/item/implant/adrenalin/post_implant(mob/living/target, mob/living/user, silent = FALSE)
	RegisterSignal(target, COMSIG_MOB_STATCHANGE,PROC_REF(prejuice))
	return

/obj/item/implant/adrenalin/post_removed(mob/living/source, silent = FALSE, special = 0)
	UnregisterSignal(source, COMSIG_MOB_STATCHANGE)
	return

/obj/item/implant/adrenalin/proc/prejuice(datum/source, newstat)
	if(juicing)
		return
	juicing = TRUE
	if(newstat == CONSCIOUS)
		return
	playsound(imp_in, 'sound/effects/autoinjector_beeps.ogg', 75, TRUE)
	addtimer(CALLBACK(src,PROC_REF(juice)), 2 SECONDS)


/obj/item/implant/adrenalin/proc/juice()
	playsound(imp_in, 'sound/effects/bamf.ogg', 75, TRUE)
	imp_in.do_adrenaline(
		stamina_boost = 75,
		put_on_feet = TRUE,
		clamp_unconscious_to = 0,
		clamp_immobility_to = 0,
		reset_misc = TRUE,
		healing_chems = list(
			/datum/reagent/medicine/atropine = 3,
			/datum/reagent/medicine/epinephrine = 25,
			/datum/reagent/medicine/coagulant = 19,
			/datum/reagent/medicine/omnizine/protozine = 20,
			/datum/reagent/water = 100,
			/datum/reagent/medicine/adrenaline = 100
		)
	)
	to_chat(imp_in, span_userdanger("You feel your adrenal implant burst!"))
	qdel(src)

/obj/item/implant/warp
	name = "warp implant"
	desc = "Saves your position somewhere, and then warps you back to it after five seconds."
	icon_state = "warp"
	uses = 15

/obj/item/implant/warp/activate()
	. = ..()
	uses--
	imp_in.do_adrenaline(20, TRUE, 0, 0, TRUE, list(/datum/reagent/fermi/eigenstate = 1.2), span_boldnotice("You feel an internal prick as as the bluespace starts ramping up!"))
	to_chat(imp_in, span_notice("You feel an internal prick as as the bluespace starts ramping up!"))
	if(!uses)
		qdel(src)

/obj/item/implanter/warp
	name = "implanter (warp)"
	imp_type = /obj/item/implant/warp

/obj/item/implant/emp
	name = "emp implant"
	desc = "Triggers an EMP."
	icon_state = "emp"
	uses = 3

/obj/item/implant/emp/activate()
	. = ..()
	uses--
	empulse_using_range(imp_in, 7)
	if(!uses)
		qdel(src)


//Health Tracker Implant

/obj/item/implant/health
	name = "health implant"
	activated = 0
	var/healthstring = ""

/obj/item/implant/health/proc/sensehealth()
	if (!imp_in)
		return "ERROR"
	else
		if(isliving(imp_in))
			var/mob/living/L = imp_in
			healthstring = "<small>Oxygen Deprivation Damage => [round(L.getOxyLoss())]<br />Fire Damage => [round(L.getFireLoss())]<br />Toxin Damage => [round(L.getToxLoss())]<br />Brute Force Damage => [round(L.getBruteLoss())]</small>"
		if (!healthstring)
			healthstring = "ERROR"
		return healthstring
