/*IN THIS FILE:
-Rattler
as per originally proposed concept: less powerful directly than aethergiests, but faster, and venom is rough. don't yell at me if this is OP
using ant armor b/c it just kinda works here and i don't want it to be super beefy lol.
*/

//Rattler
/mob/living/simple_animal/hostile/texas_rattler
	name = "texas rattler"
	desc = "Keratin gleams and articulates over its massive sixty-foot body. Distended venom glands behind its upper pterygoid shudder and pressure deadly venom into its victims. A coil of thick muscle allows it to pounce. In layman's terms: don't get bit."
	icon = 'icons/mob/texas_rattler.dmi'
	icon_state = "texasrattler"
	icon_living = "texasrattler"
	icon_dead = "texasrattler_dead"
	icon_gib = "texasrattler_gib" //TODO: this is terrible
	mob_armor = ARMOR_VALUE_ANTS
	maxHealth = 150
	health = 150
	reach = 2
	speed = -1
	move_to_delay = 2.1
	tastes = list("weird oil" = 5, "dirt" = 1)

	speak_emote = list("hisses", "shakes its rattle")
	emote_hear = list("flicks its tongue.")
	emote_taunt = list("flicks its tongue", "hisses and shakes its ratttle")

	speak_chance = 10
	taunt_chance = 25

	melee_damage_lower = 18
	melee_damage_upper = 38

	attack_verb_simple = "bites and constricts"
	see_in_dark = 8

	retreat_distance = 2

	faction = list("hostile", "wastebot", "ghoul", "cazador", "supermutant", "bighorner")
	loot = list(/obj/effect/spawner/lootdrop/f13/rare)
	loot_drop_amount = 3
	loot_amount_random = TRUE



/mob/living/simple_animal/hostile/texas_rattler/AttackingTarget()
	. = ..()
	var/atom/my_target = get_target()
	if(!. || !ishuman(my_target))
		return
	var/mob/living/carbon/human/H = my_target
	H.reagents.add_reagent(/datum/reagent/toxin/rattler_venom, 5)
	H.adjustStaminaLoss(7)
