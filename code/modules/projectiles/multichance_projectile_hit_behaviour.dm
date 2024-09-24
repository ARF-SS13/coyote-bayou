//-->Multichance projectile hit behaviour v1 (MCPHB v1)
//basically stacking more damage or prompting a gimmick for aiming your projectiles well.
//""coder"": Leonzrygin - yell at me
//<--

//master constants
#define MCPHB_MASTER_VOLUME 100		//playsounds volume
#define MCPHB_CRIT_SHOT 15			//+15% of chances to hit the mob IF it's a dead eye user

//probabilities of an event to happen
#define PROB_HEADSHOT_HIT 50		//Chances of dealing extra damage to the mob when aiming head
#define PROB_HEADSHOT_MISS 25		//Chances of wasting a bullet when aiming head
#define PROB_ARMS_HIT 75			//Chances of triggering a gimmick by shooting arms
#define PROB_THRESHOLD_ARMS_HIT 20  //Minimum percentage value to trigger the stun (it makes the function sharper and avoids cases where peashooters can knock aethergiests down)
#define PROB_LEGS_HIT 50			//Chances of hitting on the legs
#define PROB_LEGS_MISS 25			//Chances of wasting a bullet when aiming legs

//multipliers of damage dealth by the projectile
#define DAM_MULT_HEADSHOT_HIT 1.15   //headshots deal more damage
#define DAM_MULT_ARMS_HIT 0.85      //shooting on the arms deals less damage
#define DAM_MULT_LEGS_HIT 0.70		//shooting on the legs deals less damage
#define SPEED_MULT_LEGS_HIT 1.2		//shooting on the legs makes the mob chase you slowly

//target debuffs
#define TRGT_DEBUFF_MULT_DAM_ARMS_HIT 0.75			//After being shot on the arms, the mob deals less damage, because it can't swing its claws just as good!
#define TRGT_DEBUFF_TIMEOUT_ARMS_HIT 3 SECONDS		//How long does this debuff last? and at the same time how long do we have to wait before triggering it again? (basically this constant is doubled)
#define TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT 2 SECONDS 	//if we actually manage to knock the mob on its butt (hehe) how long should it stay down?
#define TRGT_DEBUFF_TIMEOUT_LEGS_HIT 6 SECONDS      //How long does this debuff last?


//main function
/proc/multichance_projectile_hit_behaviour(obj/item/projectile/P, atom/movable/firer, atom/target, status)
	if(!status && istype(firer))  //status needs to be 0, otherwise it means that bullet has missed already
		var/firer_crit_shot_add = 0
		if(HAS_TRAIT(firer, TRAIT_CRIT_SHOT))
			firer_crit_shot_add = MCPHB_CRIT_SHOT

		//Let's check if what we are shooting is a mob
		if(ismob(target) && !iscarbon(target))  //if the target is a simplemob or anything beyond but not an actual playable carbon
			if(iscarbon(firer))  //we need to make sure that our firer is a carbon
				var/mob/living/carbon/C = firer
				var/mob/living/simple_animal/hostile/T = target

				// Headshot hit:
				// 1. prob of 50% landing a headshot --> +50% raw damage on the projectile
				// 2. prob of 25% of completely missing the shot
				if(C.zone_selected == "head")  //if the firer is aiming for the head of the simplemob
					if(prob(PROB_HEADSHOT_HIT+firer_crit_shot_add))
						to_chat(firer, span_green("The [P] flies with a perfect trajectory to hit [T] in the head, dealing more damage!"))
						P.damage *= DAM_MULT_HEADSHOT_HIT
						playsound(T.loc, 'sound/weapons/crit_headshot.ogg', MCPHB_MASTER_VOLUME, TRUE)
					else if(prob(PROB_HEADSHOT_MISS-firer_crit_shot_add))
						to_chat(firer, span_warning("The [P] misses [T] completely!"))	
						playsound(T.loc, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), MCPHB_MASTER_VOLUME, TRUE)
						return 1

				//Shoulders hit:
				//1. chances of hitting = 75% otherwise regular hit
				//2. mob deals -25% damage for 3 seconds and wait 6 seconds total before being able to re-trigger this gimmick
				//3. bullet deals -15% damage
				//4. chance of stunning the mob, following this function: f(damage_projectile) = damage_projectile - DT - PROB_THRESHOLD_ARMS_HIT
				else if(C.zone_selected == "l_arm" || C.zone_selected == "r_arm")  //if the firer is aiming for one of the arms on the simplemob
					if(prob(PROB_ARMS_HIT+firer_crit_shot_add))
						if(!T.mcphb_arms_hit)
							to_chat(firer, span_green("The [P] hits [T] on their arm, making it jitter and forcing it to move inconsistently!"))
							INVOKE_ASYNC(T, TYPE_PROC_REF(/mob,emote), "me", EMOTE_VISIBLE, "'s arms jitter in pain!")
							T.mcphb_arms_hit = TRUE  //arms got hit, so for a while don't do damage 
							T.melee_damage_lower *= TRGT_DEBUFF_MULT_DAM_ARMS_HIT
							T.melee_damage_upper *= TRGT_DEBUFF_MULT_DAM_ARMS_HIT

							spawn(TRGT_DEBUFF_TIMEOUT_ARMS_HIT)
								T.melee_damage_lower /= TRGT_DEBUFF_MULT_DAM_ARMS_HIT
								T.melee_damage_upper /= TRGT_DEBUFF_MULT_DAM_ARMS_HIT

								spawn(TRGT_DEBUFF_TIMEOUT_ARMS_HIT)
									T.mcphb_arms_hit = FALSE

							var/DT = max(T.run_armor_check(null, "damage_threshold", null, null, 0, null), 0)
							var/probability = P.damage-DT-PROB_THRESHOLD_ARMS_HIT
							if(probability >= 0)
								probability = round(probability+PROB_THRESHOLD_ARMS_HIT)
								if(prob(probability))
									to_chat(firer, span_green("The [P] hits between [target]'s collarbone and shoulder, making them fall on their back!"))
									T.SetAllImmobility(TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT - (0.1 SECONDS), TRUE, TRUE)
									playsound(T.loc, 'sound/weapons/crit.ogg', MCPHB_MASTER_VOLUME, TRUE)

									spawn(TRGT_KNOCKDOWN_TIMEOUT_ARMS_HIT)
										if(!T.stat)
											T.icon = initial(T.icon)
											T.icon_state = T.icon_living
											T.density = initial(T.density)
											T.lying = FALSE
											T.set_resting(FALSE, silent = TRUE, updating = TRUE)
											T.setMovetype(initial(T.movement_type))
					
						P.damage *= DAM_MULT_ARMS_HIT  //this has to be the last calculation done
						playsound(T.loc, 'sound/weapons/bullet_flesh_1.ogg', MCPHB_MASTER_VOLUME, TRUE)

				//Legs hit:
				//1. chances of missing completely = 25%
				//2. mob speed reduced for 5 seconds (cannot stack)
				//3. bullet deals -25% damage (we are not shooting on vital organs)
				else if(C.zone_selected == "l_leg" || C.zone_selected == "r_leg")  //if the firer is aiming for one of the arms on the simplemob
					if(prob(PROB_LEGS_HIT+firer_crit_shot_add))
						if(!T.mcphb_legs_hit)
							to_chat(firer, span_green("The [P] hits [T] on their legs, forcing them to trudge along!"))
							INVOKE_ASYNC(T, TYPE_PROC_REF(/mob,emote), "me", EMOTE_VISIBLE, "'s legs jitter in pain!")
							T.mcphb_legs_hit = TRUE
							T.move_to_delay *= SPEED_MULT_LEGS_HIT

							spawn(TRGT_DEBUFF_TIMEOUT_LEGS_HIT)
								T.move_to_delay /= SPEED_MULT_LEGS_HIT

								spawn(TRGT_DEBUFF_TIMEOUT_LEGS_HIT)
									T.mcphb_legs_hit = FALSE

						P.damage *= DAM_MULT_LEGS_HIT  //this has to be the last calculation done
						playsound(T.loc, 'sound/weapons/bullet_flesh_1.ogg', MCPHB_MASTER_VOLUME, TRUE)

					else if(prob(PROB_LEGS_MISS-firer_crit_shot_add))  //chance of missing the mob's legs
						to_chat(firer, span_warning("The [P] misses [T] completely!"))	
						playsound(T.loc, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), MCPHB_MASTER_VOLUME, TRUE)
						return 1

		return 0
