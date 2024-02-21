///////////////////////////////////////////////////////////////////////////////////////
//// THIS ISNT THE RIGHT FILE! THIS IS JUST THE ONE WE USE TO CONFUSE DAN! ////////////
//// THE CORRECT FILE IS code\modules\fallout\obj\structures\mob_spawners.dm //////////
//// NOTE THE STRUCTURES/MOB_SPAWNERS.DM INSTEAD OF SPAWNERS/MOB_SPAWNER.DM ///////////
///////////////////////////////////////////////////////////////////////////////////////

/obj/effect/mob_spawner
	name = "mob spawner"
	icon = 'icons/mob/screen_gen.dmi'
	icon_state = "x2"
	color = "#00FF00"
	invisibility = 100
	var/mob_type

/obj/effect/mob_spawner/gecko
	name = "geckos spawner"
	mob_type = /mob/living/simple_animal/hostile/gecko

/obj/effect/mob_spawner/molerat
	name = "giant rats spawner"
	mob_type = /mob/living/simple_animal/hostile/molerat

/obj/effect/mob_spawner/cazador
	name = "cazadors spawner"
	mob_type = /mob/living/simple_animal/hostile/cazador
