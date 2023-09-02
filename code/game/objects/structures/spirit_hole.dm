/obj/structure/spirit_hole
	name = "a hole to the spirit realm	"
	desc = "A seemingly endless void from which you swear you can hear whispers coming through..."
	icon = 'icons/obj/objects2.dmi'
	icon_state = "anom"
	density = TRUE
	anchored = FALSE
	var/virgin = 1
	var/next_use = 0
	var/planchette = "A"
	var/lastuser = null

/obj/structure/spirit_hole/examine()
	desc = "[initial(desc)] the universe pictures the letter \"[planchette]\" into your mind."
	return ..()

/obj/structure/spirit_hole/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	spirit_hole_pick_letter(user)


//ATTACK GHOST IGNORING PARENT RETURN VALUE
/obj/structure/spirit_hole/attack_ghost(mob/dead/observer/user)
	spirit_hole_pick_letter(user)
	return ..()

/obj/structure/spirit_hole/proc/spirit_hole_pick_letter(mob/M)
	if(!spirit_hole_checks(M))
		return 0


	planchette = input("Choose the letter.", "Seance!") as null|anything in list("YES","NO","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	if(!planchette || !Adjacent(M) || next_use > world.time)
		return
	M.log_message("picked a letter on [src], which was \"[planchette]\".")
	next_use = world.time + rand(5,20)
	lastuser = M.ckey
	//blind message is the same because not everyone brings night vision to seances
	var/msg = span_notice("The letter \"[planchette]\" forms in your minds eye.")
	visible_message(msg,"",msg)

/obj/structure/spirit_hole/proc/spirit_hole_checks(mob/M)
	//cooldown
	var/bonus = 0
	if(M.ckey == lastuser)
		bonus = 10 //Adds time to the delay if the person using was the last to use it.

	if(next_use - bonus > world.time )
		return 0 //No feedback here, hiding the cooldown a little makes it harder to tell who's really picking letters.

	//lighting check
	var/light_amount = 0
	var/turf/T = get_turf(src)
	light_amount = T.get_lumcount()


	if(light_amount > 1.0)
		to_chat(M, span_warning("It's too bright here to use [src.name]!"))
		return 0

	//mobs in range check
	var/users_in_range = 0
	for(var/mob/living/L in orange(1,src))
		if(L.ckey && L.client)
			if((world.time - L.client.inactivity) < (world.time - 300) || L.stat != CONSCIOUS || L.restrained())//no playing with braindeads or corpses or handcuffed dudes.
				to_chat(M, span_warning("[L] doesn't seem to be paying attention..."))
			else
				users_in_range++

	if(users_in_range < 1)
		to_chat(M, span_warning("There aren't enough people to use the [src.name]!"))
		return 0

	return 1
