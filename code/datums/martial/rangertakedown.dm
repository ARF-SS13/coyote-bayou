/datum/martial_art/rangertakedown
	name = "Ranger Takedown"
	id = MARTIALART_RANGERTAKEDOWN

/datum/martial_art/rangertakedown/disarm_act(mob/living/carbon/human/A, mob/living/carbon/human/D)
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
