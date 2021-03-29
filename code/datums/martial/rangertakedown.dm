/datum/martial_art/rangertakedown
	name = "Ranger Takedown"
	id = MARTIALART_RANGERTAKEDOWN
	var/datum/action/ranger_takedown/rangertakedown = new/datum/action/ranger_takedown()

/datum/action/ranger_takedown
	name = "Ranger Takedown - Trips the victim, knocking them down for a brief moment."
	icon_icon = 'icons/mob/actions/actions_items.dmi'
	button_icon_state = "legsweep"

/datum/action/ranger_takedown/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't use [name] while you're incapacitated.</span>")
		return
	var/mob/living/carbon/human/H = owner
	if (H.mind.martial_art.streak == "ranger_takedown")
		owner.visible_message("<span class='danger'>[owner] assumes a neutral stance.</span>", "<b><i>Your next attack is cleared.</i></b>")
		H.mind.martial_art.streak = ""
	else
		if(HAS_TRAIT(H, TRAIT_PACIFISM))
			to_chat(H, "<span class='warning'>You don't want to harm other people!</span>")
			return
		owner.visible_message("<span class='danger'>[owner] assumes the Ranger Takedown stance!</span>", "<b><i>Your next attack will be a Ranger Takedown.</i></b>")
		H.mind.martial_art.streak = "ranger_takedown"

/datum/martial_art/rangertakedown/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return TRUE

/datum/martial_art/rangertakedown/grab_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return TRUE
	..()

/datum/martial_art/rangertakedown/harm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(check_streak(A,D))
		return TRUE

/datum/martial_art/rangertakedown/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	switch(streak)
		if("ranger_takedown")
			streak = ""
			ranger_takedown(A,D)
			return TRUE
	return FALSE

/datum/martial_art/rangertakedown/teach(mob/living/carbon/human/H,make_temporary=0)
	if(..())
		to_chat(H, "<span class = 'userdanger'>You know the arts of [name]!</span>")
		to_chat(H, "<span class = 'danger'>Place your cursor over a move at the top of the screen to see what it does.</span>")
		rangertakedown.Grant(H)

/datum/martial_art/rangertakedown/on_remove(mob/living/carbon/human/H)
	to_chat(H, "<span class = 'userdanger'>You suddenly forget the arts of [name]...</span>")
	rangertakedown.Remove(H)

/datum/martial_art/rangertakedown/proc/ranger_takedown(mob/living/carbon/human/A, mob/living/carbon/human/D)
	var/obj/item/bodypart/affecting = D.get_bodypart(ran_zone(A.zone_selected)) //Applies damage to selected area.
	var/armor_block = D.run_armor_check(affecting, "melee") //Checks Defender's armour.
	var/damage = (damage_roll(A,D) + 5) //Rolls damage based on the Attacker and Defender and if they have combat mode on or not, along with a flat +5 brute damage.
	if(!CHECK_MOBILITY(D, MOBILITY_STAND)) //If the target is not upright, it is a regular disarm.
		return FALSE
	D.visible_message("<span class='warning'>[A] leg sweeps [D], performing a Ranger Takedown!", \
						"<span class='userdanger'>[A] uses the Ranger Takedown on you!</span>")
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	A.adjustStaminaLoss(30) //The disarm will cost stamina to use. You are able to take down four opponents in quick succession before your stamina caps out.
	playsound(get_turf(A), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	D.apply_damage(damage, BRUTE, affecting, armor_block)
	D.DefaultCombatKnockdown(rand(10,30)) //Due to the defensive nature of the move, it shouldn't be longer than putting on a pair of cuffs. (30)
	log_combat(A, D, "sweeped (Ranger Takedown)")
	return TRUE
