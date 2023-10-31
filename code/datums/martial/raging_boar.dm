#define WHIRLWIND_COMBO "HD"

/datum/martial_art/raging_boar
	name = "Raging Boar"
	id = MARTIALART_RAGINGBOAR
	allow_temp_override = FALSE
	help_verb = /mob/living/carbon/human/proc/raging_boar_help
	pugilist = TRUE

/datum/martial_art/raging_boar/proc/check_streak(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(findtext(streak,WHIRLWIND_COMBO))
		streak = ""
		whirlwind(A,D) 
		return TRUE
	return FALSE

/datum/martial_art/raging_boar/proc/whirlwind(mob/living/carbon/human/A, mob/living/carbon/human/D)
	if(!ishuman(A))
		return
	A.emote("scream")
	A.spin(1 SECONDS, 1)
	var/obj/effect/proc_holder/spell/aoe_turf/repulse/spin/R = new(null)
	var/list/turfs = list()
	for(var/turf/T in range(1,A))
		turfs.Add(T)
	R.cast(turfs)
	log_combat(A, D, "whirlwinded(raging boar)")
	return

/datum/martial_art/raging_boar/disarm_act(mob/living/carbon/human/A, mob/living/D)
	if(!isliving(D))
		return
	add_to_streak("D", D, TRUE)
	if(check_streak(A,D))
		return TRUE
	var/damage = damage_roll(A,D) * 0.8
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	D.visible_message(span_danger("[A] shoves [D]!"), \
				span_userdanger("You're shoved by [A]!"), span_hear("You hear a whump!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You shove [D]!"))
	D.Dizzy(1)
	deal_damage(A, D, damage, BRUTE, A.zone_selected)
	deal_damage(A, D, damage, STAMINA, A.zone_selected)
	playsound(D, 'sound/weapons/slap.ogg', 25, 1, -1)
	if(D.anchored)
		return
	var/atom/throw_target = get_ranged_target_turf(D, get_dir(A, D), 1, 1)
	D.safe_throw_at(throw_target, 10, 1, A, TRUE)
	return TRUE

/datum/martial_art/raging_boar/harm_act(mob/living/carbon/human/A, mob/living/D)
	if(!isliving(D))
		return
	add_to_streak("H", D, TRUE)
	if(check_streak(A,D))
		return TRUE
	. = TRUE
	var/damage = (damage_roll(A,D) + 5)
	A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
	D.visible_message(span_danger("[A] sends [D] reeling with an atomic pork hammer!"), \
				span_userdanger("You're sent reeling by [A]'s atomic pork hammer!"), span_hear("You hear a whump!"), COMBAT_MESSAGE_RANGE, A)
	to_chat(A, span_danger("You smack [D] back with an atomic pork hammer!"))
	playsound(A, 'sound/effects/flesh_impact_2.ogg', 60, TRUE)
	deal_damage(A, D, damage, BRUTE, A.zone_selected)
	if(D.anchored)
		return
	var/atom/throw_target = get_ranged_target_turf(D, get_dir(A, D), 1, 2)
	D.safe_throw_at(throw_target, 10, 1, A, TRUE)

/datum/martial_art/raging_boar/add_to_streak(element, mob/living/carbon/human/D)
	if (streak == WHIRLWIND_COMBO)
		return
	. = ..()

/* /datum/martial_art/raging_boar/on_projectile_hit(mob/living/carbon/human/A, obj/item/projectile/P, def_zone)
	. = ..()
	if(A.incapacitated(FALSE, TRUE)) //NO STUN
		return BULLET_ACT_HIT
	if(!CHECK_ALL_MOBILITY(A, MOBILITY_USE|MOBILITY_STAND)) //NO UNABLE TO USE, NO DODGING ON THE FLOOR
		return BULLET_ACT_HIT
	if(A.dna && A.dna.check_mutation(HULK)) //NO HULK
		return BULLET_ACT_HIT
	if(!isturf(A.loc)) //NO MOTHERFLIPPIN MECHS!
		return BULLET_ACT_HIT
	if(A.throwing) //BULLETS LESS HURTY WHEN WE ARE IN FLIGHT
		P.damage *= 0.80
		P.def_zone = ran_zone(BODY_ZONE_CHEST, 0, ZONE_WEIGHT_LIST_SHOTGUN)
		A.visible_message(span_danger("[P] grazes [A]! Projectiles are less effective on them while they're charging!"), span_userdanger("The projectile grazes you!"))
		playsound(get_turf(A), pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, TRUE)
		return BULLET_ACT_HIT
 */

/mob/living/carbon/human/proc/raging_boar_help()
	set name = "Recall Teachings"
	set desc = "Remember the rage of the boar."
	set category = "Raging Boar"

	to_chat(usr, "<b><i>You retreat inward and recall the teachings of the Raging Boar...</i></b>")

	to_chat(usr, "[span_notice("Charging Boar")]: Fling yourself at your enemy at mach speed! The further you fly, the harder it hits!")
	to_chat(usr, "[span_notice("Spinning Marsupial")]: Harm-punch, then disarm-slap to attack everything around you!")
	to_chat(usr, "[span_notice("Pork Hammer")]: Punch someone on harm intent to send them flying!")
	to_chat(usr, "[span_notice("Swine Slap")]: Punch someone on disarm intent to shove them back and disorient them a bit!")

/datum/martial_art/raging_boar/teach(mob/living/carbon/human/H, make_temporary = FALSE)
	. = ..()
	if(!.)
		return
	//deftswitch.Grant(H)
	//sidekick.Grant(H)
	H.AddComponent(/datum/component/tackler/simple_dunkstrong, \
		stamina_cost = 10, \
		base_knockdown = 0, \
		range = 7, \
		speed = 1, \
		skill_mod = 0, \
		min_distance = 1\
	)
	ADD_TRAIT(H, TRAIT_NOGUNS, RAGING_BOAR_TRAIT)
	ADD_TRAIT(H, TRAIT_AUTO_CATCH_ITEM, RAGING_BOAR_TRAIT)
	ADD_TRAIT(H, TRAIT_MARTIAL_A, RAGING_BOAR_TRAIT)
	H.physiology.stamina_mod *= 0.5 //more stamina
	H.physiology.stun_mod *= 0.5 //better stun resistance

/datum/martial_art/raging_boar/on_remove(mob/living/carbon/human/H)
	. = ..()
	//deftswitch.Remove(H)
	//sidekick.Remove(H)
	qdel(H?.GetComponent(/datum/component/tackler/simple))

	REMOVE_TRAIT(H, TRAIT_NOGUNS, RAGING_BOAR_TRAIT)
	REMOVE_TRAIT(H, TRAIT_AUTO_CATCH_ITEM, RAGING_BOAR_TRAIT)
	REMOVE_TRAIT(H, TRAIT_MARTIAL_A, RAGING_BOAR_TRAIT)
