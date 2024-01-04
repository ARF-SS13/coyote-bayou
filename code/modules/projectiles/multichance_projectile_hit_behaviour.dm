//-->Multichance projectile hit behaviour v1
//basically stacking more damage or prompting a gimmick for aiming your projectiles well.
//coder: Leonzrygin
//<--

//probabilities of an event to happen
#define PROB_HEADSHOT_HIT 40		//Chances of dealing extra damage to the mob
#define PROB_HEADSHOT_MISS 25		//Chances of wasting a bullet
#define PROB_ARMS_HIT 75			//Chances of triggering a gimmick by shooting arms

//multipliers of damage dealth by the projectile
#define DAM_MULT_HEADSHOT_HIT 1.5
#define DAM_MULT_ARMS_HIT 0.85

//target debuffs
#define TRGT_DEBUFF_MULT_DAM_ARMS_HIT 0.75
#define TRGT_DEBUFF_TIMEOUT_ARMS_HIT 3 SECONDS
#define TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT 2 SECONDS




/proc/multichance_projectile_hit_behaviour(obj/item/projectile/P, atom/movable/firer, atom/target, status)
	if(!status)  //status needs to be 0, otherwise it means that bullet has missed already
		//Let's check if what we are shooting is a mob
		if(ismob(target) && !iscarbon(target))  //if the target is a simplemob or anything beyond but not an actual playable carbon
			if(iscarbon(firer))  //we need to make sure that our firer is a carbon
				var/mob/living/carbon/C = firer
				var/mob/living/simple_animal/T = target

				//Headshot behaviours:
				//1. prob of 40% landing a headshot --> +50% raw damage on the projectile
				//2. prob of 25% of completely missing the shot
				if(C.zone_selected == "head")  //if the firer is aiming for the head of the simplemob
					if(prob(PROB_HEADSHOT_HIT))
						to_chat(firer, span_warning("The [P] flies with a perfect trajectory to hit [T] in the head, dealing more damage!"))
						P.damage = P.damage * DAM_MULT_HEADSHOT_HIT
						playsound(T.loc, 'sound/weapons/bullet_flesh_1.ogg', 50, TRUE)
					else if(prob(PROB_HEADSHOT_MISS))
						to_chat(firer, span_warning("The [P] misses [T] completely!"))	
						playsound(T.loc, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 50, TRUE)
						return 1

				//Shoulders behaviours:
				//1. chances of hitting = 75% otherwise regular hit
				//2. mob deals -25% damage for 3 seconds
				//3. bullet deals -15% damage
				//4. chance of stunning the mob, following this function: f(damage_projectile) = 4 sqrt(damage_projectile-DT)
				else if(C.zone_selected == "l_arm" || C.zone_selected == "r_arm")  //if the firer is aiming for one of the arms on the simplemob
					if(prob(PROB_ARMS_HIT))
						P.damage = P.damage * DAM_MULT_ARMS_HIT

						if(!T.arms_hit)
							to_chat(firer, span_warning("The [P] hits [T] on their arm, making it jitter and forcing it to move inconsistently!"))
							T.arms_hit = TRUE  //arms got hit, so for a while don't do damage 
							T.melee_damage_lower = T.melee_damage_lower * TRGT_DEBUFF_MULT_DAM_ARMS_HIT
							T.melee_damage_upper = T.melee_damage_upper * TRGT_DEBUFF_MULT_DAM_ARMS_HIT

							spawn(TRGT_DEBUFF_TIMEOUT_ARMS_HIT)
								T.melee_damage_lower = T.melee_damage_lower / TRGT_DEBUFF_MULT_DAM_ARMS_HIT
								T.melee_damage_upper = T.melee_damage_upper / TRGT_DEBUFF_MULT_DAM_ARMS_HIT

								spawn(TRGT_DEBUFF_TIMEOUT_ARMS_HIT)
									T.arms_hit = FALSE

							var/DT = max(T.run_armor_check(null, "damage_threshold", null, null, 0, null), 0)
							var/probability = P.damage - DT
							if(probability >= 0)
								probability = round(4*sqrt(probability))
								if(prob(probability))
									to_chat(firer, span_warning("The [P] hits between [target]'s collarbone and shoulder, making them fall on their back!"))
									T.SetAllImmobility(TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT - 0.11 SECONDS, TRUE, TRUE)
									playsound(T.loc, 'sound/weapons/crit.ogg', 50, TRUE)

									spawn(TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT)
										if(!T.stat)
											T.icon = initial(T.icon)
											T.icon_state = T.icon_living
											T.density = initial(T.density)
											T.lying = FALSE
											T.set_resting(FALSE, silent = TRUE, updating = TRUE)
											T.setMovetype(initial(T.movement_type))



						


		return 0










