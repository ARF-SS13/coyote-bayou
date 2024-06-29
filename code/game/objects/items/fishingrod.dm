GLOBAL_LIST_INIT(fish_rates, list(
	/obj/item/fishy/carp		=8,
	/obj/item/fishy/salmon		=8,
	/obj/item/fishy/eel			=2,
	/obj/item/fishy/crawdad		=4,
	/obj/item/fishy/shrimp		=2,
	/obj/item/fishy/guppy		=4,
	/obj/item/fishy/firefish		=1,
	/obj/item/fishy/greenchromis		=2,
	/obj/item/fishy/cardinalfish		=1,
	/obj/item/fishy/catfish		=8,
	/obj/item/fishy/plastetra		=1,
	/obj/item/fishy/angelfish		=1,
	/obj/item/fishy/clownfish		=2,
	/obj/item/fishy/lubefish		=2,
	/obj/item/fishy/lanternfish		=1,
	/obj/item/fishy/goldfish		=1,
	/obj/item/fishy/dwarf_moonfish		=1,
	/obj/item/fishy/bugfish		=1,
	/obj/item/fishy/gunner_jellyfish		=1,
	/obj/item/fishy/needlefish		=4,
	/obj/item/fishy/armorfish		=2,
	/obj/item/fishy/pufferfish		=1,
	/mob/living/simple_animal/whale		= 0.5
))
//I have tried to have variables be highly influential so that customization can happen
//customization, maybe some rods are better than others ;)
/obj/item/fishingrod
	name = "fishing rod"
	desc = "A long pole that was once used to capture mighty beasts from the sea."
	icon = 'icons/obj/fish/fish_items.dmi'
	icon_state = "fishingrod"
	item_state = "fishing_rod"
	lefthand_file = 'icons/obj/fishingrod_lefthand.dmi'
	righthand_file = 'icons/obj/fishingrod_righthand.dmi'
	//this is for checking
	var/mob/current_user
	//this is for checking
	var/turf/current_turf
	//so you can't fish from multiple spots!
	var/inuse = FALSE
	//customization, allow rods to "... go the distance"
	var/fish_range = 2
	//customization, some rods are faster (or slower) than others
	//maybe in the future, lets add some kind of skill for this?
	var/min_fishtime = 1 SECONDS
	var/max_fishtime = 30 SECONDS
	//customization, you have two seconds to catch your fish
	var/max_afterfish = 4 SECONDS
	//these two vars are basically the timers
	var/current_wait = 0
	var/current_waitfail = 0
	//customization, some rods catch trash better than others, if you really want that I guess
	//default is 40, which is 40 percent chance
	var/trash_chance = 10
	/// Changes alert sound when a fish is biting the line.
	var/alert_sound = 1

/obj/item/fishingrod/AltClick(mob/user)
	if(alert_sound == 1)
		alert_sound = 2
		balloon_alert(user, "You feel like you could catch a Legend!")
	else
		alert_sound = 1
		balloon_alert(user, "Perhaps we shouldn't take this so seriously...")

/obj/item/fishingrod/equipped(mob/user, slot)
	. = ..()
	if(current_user == user)
		return
	if(current_user)
		UnregisterSignal(current_user, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED,PROC_REF(falsify_inuse))
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
		balloon_alert(user, "Too far away, move closer!")
		return
	if(inuse)
		if(current_wait <= world.time && world.time <= current_waitfail)
			var/fish_result = complete_fishing()
			switch(fish_result)
				if(1)
					balloon_alert(user, "You got trash, lame.")
					playsound(src.loc, 'sound/f13effects/karma_down.ogg', 100, TRUE, -1)
				if(2)
					balloon_alert(user, "You got nothing!")
					playsound(src.loc, 'sound/f13effects/karma_down.ogg', 100, TRUE, -1)
				if(3)
					balloon_alert(user, "You caught a fish!")
					playsound(src.loc, 'sound/f13effects/karma_up.ogg', 100, TRUE, -1)
		else	// If we catch trash, a fish, or nothing, we know we reel our line back in.
			balloon_alert(user, "You reel your line back in.")
		playsound(src.loc, 'sound/f13items/youpullbackyourline.ogg', 100, TRUE, -1)
		inuse = FALSE
		return //yea, we aren't terraria with a fishing rod that has multiple lines
	inuse = TRUE
	var/random_fishtime = rand(min_fishtime, max_fishtime)
	addtimer(CALLBACK(src,PROC_REF(play_readysound)), random_fishtime)
	current_wait = world.time + random_fishtime
	current_waitfail = current_wait + max_afterfish
	balloon_alert(user, "You cast out your fishing line!")
	playsound(src.loc, 'sound/f13items/youcastyourfishingline.ogg', 100, TRUE, -1)
	current_turf = get_turf(current_user)

/obj/item/fishingrod/proc/falsify_inuse()
	inuse = FALSE

/obj/item/fishingrod/proc/play_readysound()
	if(inuse)
		if(alert_sound == 1)
			playsound(src.loc, 'sound/f13items/youvegotsomething.ogg', 100, TRUE, -1)
		else
			playsound(src.loc, 'sound/f13items/fishing_alert.ogg', 100, TRUE, -1)
		to_chat(current_user,"You've got something...")
		balloon_alert(current_user, "Something is biting!")

/obj/item/fishingrod/proc/complete_fishing()
	var/fish_got = prob(100-trash_chance)
	switch(fish_got)
		if(FALSE)
			if(prob(trash_chance))
				//var/junk_item = pick(GLOB.loot_garbage)
				new /obj/effect/spawner/lootdrop/f13/trash(current_turf)
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

// craftable/obtainable fishing rods

/obj/item/fishingrod/spearfisher
	name = "Spearfisher"
	desc = "In the ancient books, fishermen speak of a technique called spear-fishing. Over time, the tribe has recreated what they must have spoken of; a spear with a fishing line attached. It both fishes, and self-defenses. Truly, the ancients were wise."
	icon_state = "spearfisher"
	force = 22
	force_unwielded = 25
	force_wielded = 55

/obj/item/fishingrod/sleepyrod
	name = "fishing rod"
	desc = "A long pole that was once used to capture mighty beasts from the sea. Or it would be, but you didn't put any bait on it and are just wasting time. <span class='bold'>Alt-Click to change alert sound. Ctrl-Shift-Click to vibe.</span>"
	icon = 'icons/obj/fish/fish_items.dmi'
	icon_state = "fishingrod"
	color = "#6666FF"
	inuse = FALSE
	//customization, allow rods to "... go the distance"
	fish_range = 3
	//customization, some rods are faster (or slower) than others
	//maybe in the future, lets add some kind of skill for this?
	min_fishtime = 105 SECONDS
	max_fishtime = 1200 SECONDS
	//customization, you have two seconds to catch your fish
	max_afterfish = 4 SECONDS
	//these two vars are basically the timers
	current_wait = 0
	current_waitfail = 0
	//customization, some rods catch trash better than others, if you really want that I guess
	//default is 40, which is 40 percent chance
	trash_chance = 10

/obj/item/fishingrod/sleepyrod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
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
					to_chat(current_user, span_warning("You got trash, lame..."))
					playsound(src.loc, 'sound/f13effects/karma_down.ogg', 100, TRUE, -1)
				if(2)
					to_chat(current_user, span_warning("You got nothing, lame..."))
					playsound(src.loc, 'sound/f13effects/karma_down.ogg', 100, TRUE, -1)
				if(3)
					to_chat(current_user, span_green("You got a fish, nice!"))
					playsound(src.loc, 'sound/f13effects/karma_up.ogg', 100, TRUE, -1)
		to_chat(current_user, span_notice("You pull back your line!"))
		playsound(src.loc, 'sound/f13items/youpullbackyourline.ogg', 100, TRUE, -1)
		inuse = FALSE
		return //yea, we aren't terraria with a fishing rod that has multiple lines
	inuse = TRUE
	var/random_fishtime = rand(min_fishtime, max_fishtime)
	addtimer(CALLBACK(src,PROC_REF(play_readysound)), random_fishtime)
	current_wait = world.time + random_fishtime
	current_waitfail = current_wait + max_afterfish
	to_chat(current_user, span_notice("You cast your fishing line, get ready to reel it back in!"))

/obj/item/fishingrod/sleepyrod/CtrlShiftClick(mob/user) // ...wuh. It just...plays a sound? Weird!
	balloon_alert(user, "Time to vibe...")
	playsound(src.loc, 'sound/f13items/fishing.ogg', 60, TRUE, -1)
