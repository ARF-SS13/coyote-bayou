GLOBAL_LIST_INIT(fish_rates, list(
	/obj/item/fishy/carp		=15,
	/obj/item/fishy/salmon		=15
))
//I have tried to have variables be highly influential so that customization can happen
//customization, maybe some rods are better than others ;)
/obj/item/fishingrod
	name = "fishing rod"
	desc = "A long pole that was once used to capture mighty beasts from the sea."
	icon = 'icons/obj/fish/fish_items.dmi'
	icon_state = "fishingrod"
	//this is for checking
	var/mob/current_user
	//this is for checking
	var/turf/current_turf
	//so you can't fish from multiple spots!
	var/inuse = FALSE
	//customization, allow rods to "... go the distance"
	var/fish_range = 1
	//customization, some rods are faster (or slower) than others
	//maybe in the future, lets add some kind of skill for this?
	var/min_fishtime = 6 SECONDS
	var/max_fishtime = 12 SECONDS
	//customization, you have two seconds to catch your fish
	var/max_afterfish = 2 SECONDS
	//these two vars are basically the timers
	var/current_wait = 0
	var/current_waitfail = 0
	//customization, some rods catch trash better than others, if you really want that I guess
	//default is 40, which is 40 percent chance
	var/trash_chance = 40

/obj/item/fishingrod/equipped(mob/user, slot)
	. = ..()
	if(current_user == user)
		return
	if(current_user)
		UnregisterSignal(current_user, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/falsify_inuse)
	current_user = user

/obj/item/fishingrod/dropped(mob/user)
	. = ..()
	if(current_user)
		UnregisterSignal(current_user, COMSIG_MOVABLE_MOVED)
	current_user = null

//I wish I didnt have to use afterattack
//when using pre_attack, it went wonky
/obj/item/fishingrod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!istype(target, /turf/open/water) && !istype(target, /turf/open/indestructible/ground/outside/water))
		return ..()
	if(!(target in range(fish_range, user)))
		to_chat(current_user, span_warning("The line cannot reach that far, move closer!"))
		return
	if(inuse)
		if(current_wait <= world.time && world.time <= current_waitfail)
			var/fish_result = complete_fishing()
			switch(fish_result)
				if(1)
					to_chat(current_user, "<span class='warning'>You got trash, lame...</span>")
				if(2)
					to_chat(current_user, "<span class='warning'>You got nothing, lame...</span>")
				if(3)
					to_chat(current_user, "<span class='green'>You got a fish, nice!</span>")
		to_chat(current_user, "<span class='notice'>You pull back your line!</span>")
		inuse = FALSE
		return //yea, we aren't terraria with a fishing rod that has multiple lines
	inuse = TRUE
	var/random_fishtime = rand(min_fishtime, max_fishtime)
	addtimer(CALLBACK(src, .proc/play_readysound), random_fishtime)
	current_wait = world.time + random_fishtime
	current_waitfail = current_wait + max_afterfish
	to_chat(current_user, "<span class='notice'>You cast your fishing line, get ready to reel it back in!</span>")
	current_turf = get_turf(current_user)

/obj/item/fishingrod/proc/falsify_inuse()
	inuse = FALSE

/obj/item/fishingrod/proc/play_readysound()
	if(inuse)
		playsound(src.loc, 'sound/f13items/fishready.ogg', 100, TRUE, -1)
		to_chat(current_user,"You've got something...")

/obj/item/fishingrod/proc/complete_fishing()
	var/fish_got = prob(trash_chance)
	switch(fish_got)
		if(FALSE)
			if(prob(trash_chance))
				var/junk_item = pick(GLOB.loot_garbage)
				new junk_item(current_turf)
				return 1
			if(prob(10))
				new /obj/item/salvage/low(current_turf)
				if(prob(5))
					new /obj/item/salvage/high(current_turf)
				return 1			
			return 2
		if(TRUE)
			var/pick_fish = pickweight(GLOB.fish_rates) //add your in the global list
			new pick_fish(current_turf)
			return 3
