//wip: fishing to fishtanks
/obj/item/fishy
	name = "parent fish"
	desc = "debug, report to Jake"
	icon = 'icons/obj/fish/fish_items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	//the type of meat it drops
	var/meat_type
	//the max primary meat it drops
	var/max_meat = 3
	//the secondary drop upon butcher
	var/secondary_drop
	//secondary drop chance, default 25 (twenty-five) percent
	var/secondary_chance = 25
	//the max secondary drops
	var/max_secondary = 3
	//sex that is contributing to allowing breeding
	var/spawn_sex = FEMALE

//made a proc so that it can be influenced by other stuff
/obj/item/fishy/proc/randomize_sex()
	spawn_sex = pick(MALE, FEMALE)

//butchering and other attack stuff goes here
/obj/item/fishy/attackby(obj/item/W, mob/user, params)
	if(W.get_sharpness())
		to_chat(user, span_notice("You begin to butcher [src]..."))
		playsound(user.loc, 'sound/effects/butcher.ogg', 50, TRUE, -1)
		if(!do_after(user, 3 SECONDS, target = src))
			to_chat(user, span_notice("You stop trying to butcher [src]..."))
			return
		if(meat_type)
			var/turf/meat_turf = get_turf(src)
			for(var/i in 1 to rand(1, max_meat))
				new meat_type(meat_turf)
		if(secondary_drop)
			var/turf/second_turf = get_turf(src)
			for(var/i in 1 to rand(1, max_secondary))
				if(prob(secondary_chance))
					new secondary_drop(second_turf)
		to_chat(user, span_notice("You successfully butchered [src]."))
		qdel(src)
		return
	else
		return ..()

//ive taken it into my hands to have all the fish have puns, send help - jake
//also, please make more actual fish meat and food with the new fish meat, please
//and secondary_drops will not be fishyeggs once actual fish tanks are implemented
/obj/item/fishy/carp
	name = "carp"
	desc = "carpe diem, meaning seize the car-- day. It means seize the day."
	icon_state = "carp"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/carp
	secondary_drop = /obj/item/fishyegg/carp

/obj/item/fishy/salmon
	name = "salmon"
	desc = "salmon day, spending all day going upstream just to get screwed and die."
	icon_state = "salmon"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/salmon
	secondary_drop = /obj/item/fishyegg/salmon

/obj/item/fishy/eel
	name = "electric eel"
	desc = "When you're down by the sea and an eel bites your knee, that's a moray."
	icon_state = "electric_eel"
	secondary_drop = /obj/item/fishyegg/eel
	var/delay_shock = 0

/obj/item/fishy/eel/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(delay_shock > world.time)
		return
	delay_shock = world.time + 1 MINUTES
	if(istype(target, /mob/living))
		var/mob/living/livingTarget = target
		livingTarget.electrocute_act(35, src, 1, flags = SHOCK_NOGLOVES|SHOCK_ILLUSION)

/obj/item/fishy/crawdad
	name = "Crawdad"
	desc = "Crawdad not to be confused with lobster!"
	icon_state = "crawdad"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/crawdad
	secondary_drop = /obj/item/fishyegg/crawdad

/obj/item/fishy/shrimp
	name = "shrimp"
	desc = "Whenever shrimps fight at bars, they get absolutely battered."
	icon_state = "shrimp"
	meat_type = /obj/item/reagent_containers/food/snacks/fishmeat/shrimp
	secondary_drop = /obj/item/fishyegg/shrimp

/obj/item/fishy/clownfish
	name = "clownfish"
	desc = "Keep friends close, anenomes closer."
	icon_state = "clownfish"
	secondary_drop = /obj/item/fishyegg/clownfish

/obj/item/fishy/clownfish/Initialize()
	. = ..()
	AddComponent(/datum/component/slippery, 80) //clownfish really do be soap though

/obj/item/fishyegg
	name = "parent fish egg"
	desc = "debug, report to coders (or jake) if you see this."
	icon = 'icons/obj/fish/fish_items.dmi'
	grind_results = list(/datum/reagent/nutracid = 1)
	w_class = WEIGHT_CLASS_TINY

/obj/item/fishyegg/carp
	name = "carp fish egg"
	icon_state = "carp_eggs"
	desc = "Carp roe is often referred to the 'poor man's caviar'. This particular set of eggs seems to be unfit even for hoboes, though."

/obj/item/fishyegg/salmon
	name = "salmon fish egg"
	icon_state = "salmon_eggs"
	desc = "Salmon roe is an inexpensive alternative to sturgeon caviar. If you're eating this, it's probably not for the taste."

/obj/item/fishyegg/eel
	name = "eel fish egg"
	icon_state = "electric_eel_eggs"
	desc = "Eel eggs are not, typically, considered food. Then again, haute cuisine has fallen mostly by the wayside in the modern era, so go ham."

/obj/item/fishyegg/crawdad
	name = "crawdad fish egg"
	icon_state = "catfish_eggs"
	desc = "crawdad eggs are historically widely eaten by absolutely nobody."

/obj/item/fishyegg/shrimp
	name = "shrimp fish egg"
	icon_state = "shrimp_eggs"
	desc = "Don't put it in your mouth. Don't do it. Trust your instincts on this one."

/obj/item/fishyegg/clownfish
	name = "clown fish egg"
	icon_state = "clown_eggs"
	desc = "If this tastes funny to you, it's probably because it's toxic."
