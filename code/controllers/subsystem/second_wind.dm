#define FLOOR_MASTER var/mob/living/master = get_revivable_body();
/// If we dont have a played mob, we have bigger problems
#define BODY_PLAYED var/mob/played = get_currently_played_mob(); if(!played) return;

#define SW_ERROR_NO_ERROR       (1 << 0)
#define SW_ERROR_NO_BODY        (1 << 1)
#define SW_ERROR_QDELLED_BODY   (1 << 2)
#define SW_ERROR_THIRD_WINDED   (1 << 3)
#define SW_ERROR_NO_GHOST       (1 << 4)
#define SW_ERROR_NOT_DEAD       (1 << 5)
#define SW_ERROR_BODY_OCCUPIED  (1 << 6)
#define SW_ERROR_CANNOT_REENTER (1 << 7)
#define SW_ERROR_ON_COOLDOWN    (1 << 8)
#define SW_ERROR_CUFFED         (1 << 9)
#define SW_ERROR_NO_LIVES       (1 << 10)
#define SW_ERROR_DISABLED       (1 << 11)
#define SW_ERROR_NOT_STARTED    (1 << 12)
#define SW_ERROR_RUNTIMED       (1 << 13)
#define SW_ERROR_DEAD_DELAYED   (1 << 14)
#define SW_ERROR_HARDCORE       (1 << 15)
#define SW_ERROR_NO_ERROR_GRACE (1 << 16) // there isnt an error, GRACE

#define SW_UI_DEFAULT "SWDefault"
#define SW_UI_README  "SWReadMe"
#define SW_UI_CONFIRM "SWConfirm"

#define SW_AM_THIRD_WINDED        (1 << 0)
#define SW_I_SECOND_WINDED        (1 << 1)
#define SW_I_DIED_BEFORE          (1 << 2)
#define SW_FULL_LIFE_CONSEQUENCES (1 << 3)
#define SW_HC                     (1 << 4)
#define SW_GRACE_PERIOD           (1 << 5)

/// Yeah this is gonna be important later
SUBSYSTEM_DEF(secondwind)
	name = "SecondWind"
	flags = SS_BACKGROUND
	wait = 1 SECONDS

	/// all our fine folk with second wind
	/// format: list("ckey" = datum/second_wind)
	var/list/second_winders = list()
	var/life_cooldown = 1.25 HOURS
	var/death_delay = 5 MINUTES
	var/max_lives = 1
	var/start_lives = 1
	var/allow_third_wind = TRUE
	var/master_toggle = TRUE

	var/grace_duration = 5 MINUTES // good enough

	var/used_a_second_wind = 0
	var/died_at_least_once = 0
	var/third_winded_folk = 0
	var/full_life_consequences = 0
	var/hardcores = 0
	var/graces = 0

	var/last_life_tick = 0

/datum/controller/subsystem/secondwind/stat_entry(msg)
	msg = "#:[LAZYLEN(second_winders)] - F:[full_life_consequences] - D:[died_at_least_once] - SW:[used_a_second_wind] - TW:[third_winded_folk] - HC:[hardcores] - G:[graces] - C:[round(cost,0.005)]"
	return ..()

/datum/controller/subsystem/secondwind/Initialize(start_timeofday)
	last_life_tick = world.time
	. = ..()

/datum/controller/subsystem/secondwind/fire(resumed)
	if(!master_toggle)
		return
	var/adustment = world.time - last_life_tick
	used_a_second_wind = 0
	died_at_least_once = 0
	third_winded_folk = 0
	full_life_consequences = 0
	hardcores = 0
	graces = 0
	for(var/mob_key in second_winders)
		var/datum/second_wind/my_wind = second_winders[mob_key]
		if(!my_wind)
			second_winders -= mob_key
			continue
		var/stats = my_wind.process_sw(adustment)
		if(CHECK_BITFIELD(stats, SW_AM_THIRD_WINDED))
			third_winded_folk++
		if(CHECK_BITFIELD(stats, SW_I_SECOND_WINDED))
			used_a_second_wind++
		if(CHECK_BITFIELD(stats, SW_I_DIED_BEFORE))
			died_at_least_once++
		if(CHECK_BITFIELD(stats, SW_FULL_LIFE_CONSEQUENCES))
			full_life_consequences++
		if(CHECK_BITFIELD(stats, SW_HC))
			hardcores++
		graces += my_wind.graces
	last_life_tick = world.time

/datum/controller/subsystem/secondwind/proc/show_menu_to(client_mob_or_ckey)
	var/datum/second_wind/my_wind = get_second_wind_datum(client_mob_or_ckey)
	return my_wind?.open_window()

/datum/controller/subsystem/secondwind/proc/get_second_wind_datum(client_mob_or_ckey)
	if(!client_mob_or_ckey)
		CRASH("get_second_wind_datum called with no key_lookup!")
	var/key_lookup = get_ckey(client_mob_or_ckey)
	if(!key_lookup)
		CRASH("get_second_wind_datum called with something that lacked a ckey! (mob_or_ckey: '[client_mob_or_ckey]')")
	var/datum/second_wind/my_wind = LAZYACCESS(second_winders, key_lookup)
	if(!my_wind)
		my_wind = new /datum/second_wind(key_lookup)
	return my_wind

/datum/controller/subsystem/secondwind/proc/grant_one_up(ckey)
	if(!ckey)
		CRASH("grant_one_up called with no key_lookup!")
	var/datum/second_wind/my_wind = get_second_wind_datum(ckey)
	my_wind.one_up()

/datum/controller/subsystem/secondwind/proc/init_my_second_wind(ckey)
	if(!ckey)
		CRASH("grant_one_up called with no key_lookup!")
	var/datum/second_wind/my_wind = get_second_wind_datum(ckey)
	my_wind.get_revivable_body()

/datum/controller/subsystem/secondwind/proc/i_died(ckey)
	if(!ckey)
		CRASH("i_died called with no key_lookup!")
	var/datum/second_wind/my_wind = get_second_wind_datum(ckey)
	my_wind.i_died()

/datum/controller/subsystem/secondwind/proc/is_hardcore(ckey)
	if(!ckey)
		CRASH("i_died called with no key_lookup!")
	var/datum/second_wind/my_wind = get_second_wind_datum(ckey)
	return my_wind.hardcore

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////
/// The datum holding a mob's second wind
/// Only applies to the most recent living mob you inhabited
/datum/second_wind
	var/ownerkey
	var/datum/weakref/ownermob
	var/lives_left = 1
	var/third_winded = FALSE
	var/life_meter = 0
	var/death_meter = 0
	var/hardcore = FALSE

	var/window_state = SW_UI_DEFAULT

	var/times_second_winded = 0
	var/times_died = 0

	/// time you rezzed so we know if ur gonna grace it
	var/last_revive = 0
	/// time you died, for reasons
	var/last_death = 0

	var/grace_freebie = FALSE

	var/graces = 0

	var/too_late_for_grace = TRUE // i mean we ahvent died yet

/datum/second_wind/New(new_key)
	ownerkey = new_key
	SSsecondwind.second_winders[ownerkey] = src
	initialize_lives()
	get_revivable_body()

/datum/second_wind/proc/get_revivable_body()
	hardcore = FALSE
	var/mob/corpse = GET_WEAKREF(ownermob)
	var/mob/current = get_currently_played_mob()
	if(!current) // They're disconnected!
		return // Wait till they get back
	var/mob/currenter = current?.mind?.current
	if(isliving(currenter))
		if(!corpse || currenter != corpse)
			corpse = currenter
			ownermob = WEAKREF(corpse)
			//initialize_lives()      <--- any feature that makes you switch mobs will make this happen so. i made it not
	else if(isliving(current))
		if(!corpse || current != corpse)
			corpse = current
			ownermob = WEAKREF(corpse)
			//initialize_lives()      <--- same as above
	if(!corpse)
		return
		//CRASH("get_revivable_body for [ownerkey] called with no corpse and no currently played mob! wtf") // turns out disconnected players count, I guess?
	if(HAS_TRAIT(corpse, TRAIT_NO_SECOND_WIND))
		hardcore = TRUE
	return corpse

/datum/second_wind/proc/get_currently_played_mob()
	if(!ownerkey)
		CRASH("get_currently_played_mob called on a second wind with no ownerkey! wtf")
	var/mob/maybemob = ckey2mob(ownerkey)
	return maybemob

/datum/second_wind/proc/initialize_lives()
	lives_left = SSsecondwind.start_lives
	third_winded = FALSE
	life_meter = 0
	death_meter = 0

/datum/second_wind/proc/i_died()
	death_meter = 0
	life_meter = 0
	last_death = world.time
	times_died++
	if(check_grace())
		say_grace() // our further what which in heven please blush this freast unwhich you bestowed upom we

/datum/second_wind/proc/check_grace()
	if(!last_revive || !last_death)
		return FALSE
	var/time_alive = abs(last_revive - last_death)
	return time_alive <= SSsecondwind.grace_duration

/datum/second_wind/proc/say_grace() // and also set it too
	grace_freebie = TRUE
	BODY_PLAYED
	if(prob(1))
		to_chat(played, span_green("Back when Army of Two first came out, me and my college roommates, suitemates, were all way too into Halo 3 to really care. I didn't even think Army of Two was on my radar in 2008. My college suitemates would sneak into my room while I wasn't there and play Halo 3 without my permission, on my Xbox, but more importantly, they would look at my DVD collection. I had like 215 DVDs in alphabetical order and they would play a cruel joke where they would move two random titles in different places and see how long it would take me to notice. Yeah, I know that says a lot more about me than it does about them, but I could tell every time that was the joke. I would just scan briefly over my DVDs everyday and see if they had taken one was usually the issue wasn't-I wasn't checking to see if they put them out of order, I was checking because they would turn up MISSING. And then I would track them down and find someone across the hallway who borrowed one without asking and what do you know! The DVD is missing from inside of its jewel case! Where did it go? No one knows. Oh I found it, it's in two pieces now. No, I'm not still angry about that."))
	else
		switch(graces)
			if(0)
				to_chat(played, span_green("You died again? That sucks."))
			if(1)
				to_chat(played, span_green("Hi again! So, when you head back in, try to get away from whatever killed you."))
			if(2)
				to_chat(played, span_green("Just couldn't stay away, could you? Protip: Blood loss will seriously kill you."))
			if(3)
				to_chat(played, span_green("Is everything alright? Protip: Radiation will seriously kill you."))
			if(4)
				to_chat(played, span_green("Seriously, is everything alright? Protip: The Meister will seriously kill you."))
			if(5)
				to_chat(played, span_green("I agree, dying is fun. Protip: Spider poison will seriously kill you."))
			else
				to_chat(played, span_green("Death never had any meaning, and this is why! Death is fun as heck!"))
	to_chat(played, span_greentext("Have a free life, for dying so quickly!"))
	graces++
	one_up(TRUE) // good enuf
	played.playsound_local(played, "sound/effects/get_new_life.ogg", 75, respect_deafness = FALSE) // YEAH FUCK THE DEAF

/// does stuff while you're alive (or dead)
/datum/second_wind/proc/process_sw(time_shift)
	. = get_stats()
	if(third_winded)
		return
	FLOOR_MASTER
	if(!master)
		return
	if(lives_left >= SSsecondwind.max_lives)
		life_meter = 0
		lives_left = SSsecondwind.max_lives
	if(master.stat == DEAD)
		death_meter += time_shift
		return
	death_meter = 0
	life_meter += time_shift
	if(!too_late_for_grace && ((world.time - last_revive) > SSsecondwind.grace_duration))
		too_late_for_grace = TRUE
		BODY_PLAYED
		to_chat(played, span_alert("The strange buzzing inside fades."))
	if(life_meter > SSsecondwind.life_cooldown)
		one_up()
		life_meter = 0

/datum/second_wind/proc/get_stats()
	if(third_winded)
		. |= SW_AM_THIRD_WINDED
	if(times_died)
		. |= SW_I_DIED_BEFORE
	if(times_second_winded)
		. |= SW_I_SECOND_WINDED
	if(lives_left >= SSsecondwind.max_lives)
		. |= SW_FULL_LIFE_CONSEQUENCES
	if(hardcore)
		. |= SW_HC

/datum/second_wind/proc/one_up(silent)
	lives_left = clamp(lives_left + 1, 0, SSsecondwind.max_lives)
	if(third_winded)
		third_winded = FALSE // Third Wind prevents this from being called naturall, but admins can still force it
	if(silent)
		return
	BODY_PLAYED
	to_chat(played, span_greentext("You feel a renewed warmth inside! Seems like you've gotten yourself a second wind!"))
	played.playsound_local(played, "sound/effects/get_new_life.ogg", 75, respect_deafness = FALSE) // YEAH FUCK THE DEAF

/datum/second_wind/proc/attempt_revival(freebie)
	BODY_PLAYED
	var/revive_error = can_revive(freebie)
	switch(revive_error)
		if(SW_ERROR_NO_BODY)
			to_chat(played, span_danger("You don't have a body to revive!"))
			return
		if(SW_ERROR_QDELLED_BODY)
			to_chat(played, span_danger("Your body is in the trash where it belongs! Its been deleted! D:"))
			return
		if(SW_ERROR_NOT_DEAD)
			to_chat(played, span_danger("You're not dead!"))
			return
		if(SW_ERROR_THIRD_WINDED)
			to_chat(played, span_danger("You've spent your Third Wind! You can't revive!"))
			return
		if(SW_ERROR_NO_GHOST)
			to_chat(played, span_phobia("Your body doesn't see you as its ghost! This might be a bug!"))
			return
		if(SW_ERROR_CANNOT_REENTER)
			to_chat(played, span_danger("You've made it clear you don't want to be alive!"))
			return
		if(SW_ERROR_CUFFED)
			to_chat(played, span_danger("Your body is cuffed! You can't revive!"))
			return
		if(SW_ERROR_DISABLED)
			to_chat(played, span_danger("Second Wind is disabled!"))
			return
		if(SW_ERROR_DEAD_DELAYED)
			to_chat(played, span_danger("You're not ready to revive! Check back in [DisplayTimeText(SSsecondwind.death_delay - death_meter, 1)]!"))
			return
	if(!revive_me())
		return
	last_revive = world.time // so we can check if we died just after reviving
	spend_life(freebie)

/datum/second_wind/proc/revive_me()
	if(third_winded)
		return
	FLOOR_MASTER
	if(!isliving(master))
		return
	BODY_PLAYED
	var/datum/reagents/master_reagents = master.reagents
	// var/toxinlover = is_toxin_lover(master)
	var/is_robot = isrobotic(master)
	var/mob/ghost = master.get_ghost()
	if(ghost)
		to_chat(played, span_greentext("You feel drawn back into your body!"))
		ghost.client?.change_view(CONFIG_GET(string/default_view))
		ghost.transfer_ckey(ghost.mind.current, FALSE)
		SStgui.on_transfer(src, ghost.mind.current) // Transfer NanoUIs.
		ghost.mind?.current?.client?.init_verbs()
	if(isanimal(master))
		master.revive(TRUE, TRUE, TRUE) // heck it, simplemobs get a rez
		playsound(get_turf(master), "sound/effects/molly_revived.ogg", 100, TRUE)
		master.emote("scrungy")
		times_second_winded++
		return TRUE
	master_reagents.remove_all(999) // First purge all their reagents
	master.adjustOxyLoss(-999)
	master.adjust_fire_stacks(-20)
	master.radiation = 0
	var/my_brute = master.getBruteLoss()
	var/my_burn = master.getFireLoss()
	var/my_tox = master.getToxLoss()
	var/my_oxy = master.getOxyLoss()
	if(is_robot)
		my_brute += ((my_tox * 0.5) + (my_oxy * 0.5)) // shouldnt happen, but just in case
		my_burn += ((my_tox * 0.5) + (my_oxy * 0.5)) // shouldnt happen, but just in case
		master.adjustToxLoss(-my_tox, TRUE)
		master.adjustOxyLoss(-my_oxy, TRUE)
		my_tox = 0
	var/total_damage = my_brute + my_burn + my_tox + my_oxy
	var/brute_heal = 0
	var/burn_heal = 0
	var/tox_heal = 0
	var/oxy_heal = 0
	var/iterations_left = 1000
	while(total_damage > 180 && iterations_left-- > 0)
		var/list/can_heal = list()
		if(my_brute >= 1)
			can_heal += BRUTE
		if(my_burn >= 1)
			can_heal += BURN
		if(my_tox >= 1)
			can_heal += TOX
		if(my_oxy >= 1)
			can_heal += OXY
		if(!LAZYLEN(can_heal))
			break
		var/healslut = pick(can_heal)
		switch(healslut)
			if(BRUTE)
				my_brute--
				brute_heal++
				total_damage--
			if(BURN)
				my_burn--
				burn_heal++
				total_damage--
			if(TOX)
				my_tox--
				tox_heal++
				total_damage--
			if(OXY)
				my_oxy--
				oxy_heal++
				total_damage--
	master.adjustBruteLoss(-brute_heal, TRUE, include_roboparts = TRUE)
	master.adjustFireLoss(-burn_heal, TRUE, include_roboparts = TRUE)
	master.adjustToxLoss(-tox_heal, force_be_heal = TRUE)
	master.adjustOxyLoss(-oxy_heal)
	master.adjustOrganLoss(ORGAN_SLOT_BRAIN, -200)
	master.blood_volume = max(BLOOD_VOLUME_SAFE, master.blood_volume)
	
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/brute,            25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/burn,             25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/toxin,        25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/all_damage,   25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/oxy,              25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/radheal,          25)
	// master_reagents.add_reagent(/datum/reagent/medicine/critmed/blood,            25)
	// master_reagents.add_reagent(/datum/reagent/medicine/critmed/blood/stabilizer, 25)
	master_reagents.add_reagent(/datum/reagent/medicine/critmed/runfast,          50)
	if(iscarbon(master))
		var/mob/living/carbon/carbaster = master
		QDEL_LIST(carbaster.all_wounds)
		if(ishuman(master))
			var/mob/living/carbon/human/humaster = carbaster
			var/obj/item/stack/medical/gauze/second_wind/bandie = new()
			for(var/obj/item/bodypart/limb in humaster.bodyparts)
				limb.apply_gauze_to_limb(bandie)
				limb.bleed_dam = 0
			qdel(bandie)

	/// should be enough to get them up
	master.revive(FALSE, FALSE, TRUE)
	if(master.stat == DEAD) // huh, still dead
		to_chat(played, span_alert("Something went wrong and you're still dead!"))
		//No reason to damage the mob more if it can't be revived.
		/*master.apply_damages(
			brute = brute_heal,
			burn = burn_heal,
			tox = tox_heal,
		)*/
		master_reagents.remove_all(999)
		message_admins("Second Wind: [master] tried to revive, but they're still dead!")
		return
	played.playsound_local(played, "sound/effects/ghost_succ.ogg", respect_deafness = FALSE)
	playsound(get_turf(master), "sound/effects/molly_revived.ogg", 75)
	played.playsound_local(get_turf(master), "sound/effects/molly_revived.ogg", 50, respect_deafness = FALSE)
	master.emote("scrungy", forced = TRUE)
	times_second_winded++
	too_late_for_grace = FALSE
	return TRUE

/datum/second_wind/proc/spend_life(free_life)
	BODY_PLAYED
	if(!free_life)
		lives_left--
		death_meter = 0
	if(lives_left < 0)
		third_winded = TRUE
		to_chat(played, span_alert("You feel a dull warmth seep its way through your body, clamping wounds closed and purging foreign agents with its presence. \
			As you lie there feeling your body knit itself back together, you notice that the warmth is struggling to maintain itself, flickering and fading. \
			Whatever it is that's brought you back, it's not going to be able to do it again."))
	else if(lives_left == 0)
		to_chat(played, span_alert("You feel a deep warmth burn its way through every inch of your form, clamping wounds closed and purging foreign agents with its presence. \
			As you lie there feeling your body knit itself back together, a deep sense of exhaustion wells up, as though your soul had run a marathon. \
			You feel like you'll need to rest for at least [DisplayTimeText(SSsecondwind.life_cooldown, 1)] before you can do this again."))
	else
		to_chat(played, span_alert("You feel a deep warmth burn its way through every inch of your form, clamping wounds closed and purging foreign agents with its presence. \
			As you lie there feeling your body knit itself back together, a vague sense of stamina tickles at the back of your mind, along with the thought that you can do <i>this</i> \
			[lives_left] more time[lives_left > 1 ? "s" : ""]!"))

/datum/second_wind/proc/can_revive(freebie)
	FLOOR_MASTER
	if(!SSsecondwind.master_toggle)
		return SW_ERROR_DISABLED
	if(SSticker.current_state < GAME_STATE_PLAYING)
		return SW_ERROR_NOT_STARTED
	if(freebie)
		return SW_ERROR_NO_ERROR
	if(!isliving(master))
		return SW_ERROR_NO_BODY
	var/mob/dead/observer/myghost = master.get_ghost()
	if((myghost && !myghost.can_reenter_corpse))
		return SW_ERROR_CANNOT_REENTER
	if(QDELETED(master))
		return SW_ERROR_QDELLED_BODY
	if(HAS_TRAIT(master, TRAIT_NO_SECOND_WIND))
		return SW_ERROR_HARDCORE
	if(master.restrained(TRUE))
		return SW_ERROR_CUFFED
	if(third_winded)
		return SW_ERROR_THIRD_WINDED
	if(death_meter < SSsecondwind.death_delay)
		. |= SW_ERROR_DEAD_DELAYED
	if(lives_left <= 0)
		. |= SW_ERROR_NO_LIVES
		return
	. |= SW_ERROR_NO_ERROR // man it was so clean till this

/datum/second_wind/proc/get_time_text()
	FLOOR_MASTER
	. = list(
		"PBarColors" = "average",
		"TimeText" = "Soon!",
		"Percentage" = 100,
		"TargTime" = SSsecondwind.life_cooldown,
	)
	if(third_winded || (master && HAS_TRAIT(master, TRAIT_NO_SECOND_WIND)))
		.["PBarColors"] = "bad"
		.["TimeText"] = "Never!"
		.["Percentage"] = 0
		return
	if(lives_left >= SSsecondwind.max_lives)
		.["PBarColors"] = "good"
		.["TimeText"] = "Full!"
		return
	var/timeleft = (SSsecondwind.life_cooldown - life_meter)
	if(timeleft < 1)
		.["PBarColors"] = "good"
		.["TimeText"] = "Now!"
		return
	else
		if(master?.stat == DEAD)
			.["PBarColors"] = "average"
			.["Percentage"] = round((life_meter / SSsecondwind.life_cooldown) * 100, 0.1)
			.["TimeText"] = "PAUSED - [DisplayTimeText(timeleft, 1, TRUE, TRUE)] - PAUSED"
			return
		else
			.["PBarColors"] = "good"
			.["Percentage"] = round((life_meter / SSsecondwind.life_cooldown) * 100, 0.1)
			.["TimeText"] = "[DisplayTimeText(timeleft, 1, TRUE, TRUE)]"

/datum/second_wind/proc/get_dead_time_text()
	FLOOR_MASTER
	. = list(
		"DedPBarColors" = "average",
		"DedTimeText" = "Soon!",
		"DedPercentage" = 100,
		"DedTargTime" = SSsecondwind.death_delay,
	)
	if(third_winded || (master && HAS_TRAIT(master, TRAIT_NO_SECOND_WIND)))
		.["DedPBarColors"] = "bad"
		.["DedTimeText"] = "Never!"
		.["DedPercentage"] = 0
		return
	if(master?.stat != DEAD)
		.["DedPBarColors"] = "good"
		.["DedTimeText"] = "You're alive!"
		.["DedPercentage"] = 100
		return
	var/timeleft = (SSsecondwind.death_delay - death_meter)
	if(timeleft < 1)
		.["DedPBarColors"] = "good"
		.["DedTimeText"] = "Now!"
		.["DedPercentage"] = 100
		return
	else
		.["DedPBarColors"] = "good"
		.["DedPercentage"] = round((death_meter / SSsecondwind.death_delay) * 100, 0.1)
		.["DedTimeText"] = "[DisplayTimeText(timeleft, 1)]"

/datum/second_wind/proc/get_body_text()
	FLOOR_MASTER
	. = list(
		"BodyHead" = "Second Wind",
		"BodyFill" = "Welcome to Second Wind! Try not to die! Though if you do, no sweat!",
		"BodyHeadIconColor" = "good",
		"BodyHeadIconImg" = "check",
		"ShowButtons" = "None",
	)
	if(window_state == SW_UI_README)
		return get_readme_text(.)
	if(window_state == SW_UI_CONFIRM)
		return get_confirm_text(.)
	var/revive_error = can_revive()
	var/am_alive = master?.stat != DEAD
	switch(revive_error)
		if(SW_ERROR_RUNTIMED)
			.["BodyHead"] = "OH"
			.["BodyFill"] = "Something happened that didnt work!!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_NO_BODY)
			.["BodyHead"] = "NO BODY"
			.["BodyFill"] = "You don't have a body to revive!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_HARDCORE)
			.["BodyHead"] = "HARDCORE"
			if(am_alive)
				.["BodyFill"] = "You've opted out of Second Wind! If you die, the only way you're getting back up \
					is if someone else revives you! Don't expect much help from divine intervention, so be careful \
					and bring a friend!"
			else
				.["BodyFill"] = "You've opted out of Second Wind! The only way you're getting back up is if someone else revives you! \
					Don't expect much help from divine intervention!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_DISABLED)
			.["BodyHead"] = "DISABLED"
			.["BodyFill"] = "Second Wind is disabled. Sorry!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_NOT_STARTED)
			.["BodyHead"] = "NOT STARTED"
			.["BodyFill"] = "Hold your horses, we're still getting everything set up!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_QDELLED_BODY)
			.["BodyHead"] = "NO BODY"
			.["BodyFill"] = "Your body is in the trash where it belongs (its been deleted, sorry!) You can't revive yourself!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_NO_GHOST)
			.["BodyHead"] = "NO GHOST"
			.["BodyFill"] = "You somehow lack a ghost! This is probably a bug."
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_BODY_OCCUPIED)
			.["BodyHead"] = "BODY FULL"
			.["BodyFill"] = "Your body is occupied by someone else! You can't revive yourself!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_CANNOT_REENTER)
			.["BodyHead"] = "CANNOT REENTER"
			.["BodyFill"] = "You have elected to stay dead, or something along those lines."
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_CUFFED)
			.["BodyHead"] = "CUFFED"
			.["BodyFill"] = "Your body is handcuffed! You can't revive yourself!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"
			return
		if(SW_ERROR_THIRD_WINDED)
			.["BodyHead"] = "THIRD WINDED"
			if(am_alive)
				.["BodyFill"] = "You've already used your third wind, you won't be able to revive yourself if you die!"
				if(prob(1))
					.["BodyFill"] += " YOLO~"
			else
				.["BodyFill"] = "You've already used your third wind, you can't revive yourself! You'll need to be rescued, or hop on a different character if you want to keep playing!"
			.["BodyHeadIconColor"] = "bad"
			.["BodyHeadIconImg"] = "times"
			.["ShowButtons"] = "None"

	if(CHECK_BITFIELD(revive_error, SW_ERROR_NO_LIVES))
		.["BodyHead"] = "OUT OF LIVES"
		if(am_alive)
			.["BodyFill"] = "You have revived yourself recently, and you'll need to wait a while before you can do it again safely! \
				If you die, you will still be able to revive yourself, but it'll be your last! Try to stay alive!"
			if(prob(1))
				.["BodyFill"] += " YOLO~"
			.["ShowButtons"] = "None"
		else
			if(CHECK_BITFIELD(revive_error, SW_ERROR_DEAD_DELAYED))
				.["BodyFill"] = "You have revived yourself recently, and while you can still revive yourself right now, it will be your last! \
					If you die again after reviving, you'll need to be rescued, or hop on a different character if you want to keep playing! <br><br> \
					Furthermore, you also died recently, and won't be able to revive yourself anyway for another [DisplayTimeText(SSsecondwind.death_delay - death_meter, 1)] or so!"
				.["ShowButtons"] = "None"
				.["BodyHeadIconColor"] = "bad"
				.["BodyHeadIconImg"] = "exclamation-triangle"
			else
				.["BodyFill"] = "You have revived yourself recently, and while you can still revive yourself right now, it will be your last! \
					If you die again after reviving, you'll need to be rescued, or hop on a different character if you want to keep playing!"
				.["ShowButtons"] = "OnlyRevive"
				.["BodyHeadIconColor"] = "average"
				.["BodyHeadIconImg"] = "exclamation-triangle"
		return

	if(CHECK_BITFIELD(revive_error, SW_ERROR_NO_ERROR))
		if(am_alive)
			.["BodyHead"] = "You're alive!"
			.["BodyFill"] = "You're good and rested! If you die, you can revive yourself just fine!"
			.["BodyHeadIconColor"] = "good"
			.["BodyHeadIconImg"] = "check"
			.["ShowButtons"] = "None"
		else
			if(CHECK_BITFIELD(revive_error, SW_ERROR_DEAD_DELAYED))
				.["BodyHead"] = "SOON TO REVIVE"
				.["BodyFill"] = "In [DisplayTimeText(SSsecondwind.death_delay - death_meter, 1)], you can revive yourself! \
					Do note that you should wait at least [DisplayTimeText(SSsecondwind.life_cooldown, 1)] after you're alive before you do it again, \
					otherwise your next time will be your last!"
				.["BodyHeadIconColor"] = "bad"
				.["BodyHeadIconImg"] = "heartbeat"
				.["ShowButtons"] = "None"
			else
				.["BodyHead"] = "READY TO REVIVE"
				.["BodyFill"] = "You can revive yourself! Just click the button below, and you'll be back on your feet in no time! \
					Do note that you should wait at least [DisplayTimeText(SSsecondwind.life_cooldown, 1)] before you do it again, \
					otherwise your next time will be your last!"
				.["BodyHeadIconColor"] = "good"
				.["BodyHeadIconImg"] = "heartbeat"
				.["ShowButtons"] = "OnlyRevive"
		return

/datum/second_wind/proc/get_confirm_text(list/input_list = list())
	FLOOR_MASTER
	. = input_list
	if(!SSsecondwind.master_toggle)
		.["BodyHead"] = "DISALBED!"
		.["BodyFill"] = "Second Wind is disabled. Sorry! (How'd you even get here =3)"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyBack" // hey come check out my OnlyBack
		return
	if(SSticker.current_state < GAME_STATE_PLAYING)
		.["BodyHead"] = "Round Hasn't Started"
		.["BodyFill"] = "Hold your horses, the world isn't even alive yet! (How'd you even get here =3)"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyBack"
		return
	if(HAS_TRAIT(master, TRAIT_NO_SECOND_WIND))
		.["BodyHead"] = "HARDCORE"
		.["BodyFill"] = "You've opted out of Second Wind! If you die, the only way you're getting back up \
			is if someone else revives you! Don't expect much help from divine intervention, so be careful \
			and bring a friend!"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "None"
		return
	if(master?.stat != DEAD)
		.["BodyHead"] = "You're not dead!"
		.["BodyFill"] = "You need to be dead to revive yourself, silly!"
		.["BodyHeadIconColor"] = "good"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyBack"
		return
	if(third_winded)
		.["BodyHead"] = "You cannot revive yourself!"
		.["BodyFill"] = "You've already spent your last life! You'll need to be rescued, or hop on a different character if you want to keep playing!"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyBack"
		return
	if(death_meter < SSsecondwind.death_delay)
		.["BodyHead"] = "COOLING DOWN"
		.["BodyFill"] = "You're dead, but you're not ready to revive yet! You'll be able to revive yourself in [DisplayTimeText(SSsecondwind.death_delay - death_meter, 1)]!"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyBack"
		return
	if(lives_left >= 1)
		.["BodyHead"] = "Revive yourself?"
		.["BodyFill"] = "You have [lives_left] lives left. Reviving yourself will cost one of them, \
							and it will take [DisplayTimeText(SSsecondwind.life_cooldown, 1)] to get one back."
		.["BodyHeadIconColor"] = "good"
		.["BodyHeadIconImg"] = "heartbeat"
		.["ShowButtons"] = "Both"
		return
	if(lives_left <= 0 && !third_winded)
		.["BodyHead"] = "Revive yourself for the last time?"
		.["BodyFill"] = "WARNING: This is your last life! If you revive yourself now, you will not be able to revive yourself \
							again if you die! If you die again, the only way you'll be able to play again is if someone else revives \
							you, or you hop onto a different character!"
		.["BodyHeadIconColor"] = "bad"
		.["BodyHeadIconImg"] = "times"
		.["ShowButtons"] = "OnlyRevive"
		return
	.["BodyHead"] = "Something went wrong!"
	.["BodyFill"] = "Something happened, and you shouldn't be here!!"
	.["BodyHeadIconColor"] = "bad"
	.["BodyHeadIconImg"] = "question-circle"
	.["ShowButtons"] = "OnlyBack"

/datum/second_wind/proc/get_readme_text(list/input_list = list())
	. = input_list
	.["BodyHead"] = "About Second Wind"
	.["BodyFill"] = "\
		Second Wind allows you to revive yourself when you die, without needing someone to go find your body! \
		Perfect if you're all alone and you die somewhere nobody will ever find. <br></br> \
		When you die, simply become a ghost and click the Second Wind button in the ghost panel. It'll bring up this menu, \
		and from there you can revive yourself! <br></br>\
		\
		When you revive yourself, your body will be purged of all reagents, healed to just above death, \
		and given a hefty dose of healing chems based on your worst injuries, more than enough to get you back on your feet! \
		After that, it is recommended to get to safety as quick as you can!<br></br> \
		\
		However, you can only revive yourself a limited number of times. You start with a single Second Wind, \
		which allows you to revive yourself once. If you manage to survive for two hours after using your Second Wind, \
		you'll get it back, and you'll be able to revive yourself again when you die!<br></br> \
		\
		If you die <b>without</b> a Second Wind, you will have the option to push yourself into using your Third Wind, \
		which will revive you, but prevent you from regaining any more Second Winds. If you die after this Third Wind, \
		you'll be unable to revive yourself, and the only ways back into the round will be if someone finds and revives your body, \
		or you hop onto a different character.<br></br> \
		\
		Do note that you need to have an intact body to revive yourself, so if your body gets deleted, destroyed, or gibbed, \
		you won't be able to revive yourself! <br></br> \
		\
		Also, if your body is handcuffed, you won't be able to revive yourself until you get uncuffed!<br><br> \
		\
		This is all a work in progress, please report any bugs and feedback to the dev team! =3"
	.["BodyHeadIconColor"] = "good"
	.["BodyHeadIconImg"] = "question-circle"
	.["ShowButtons"] = "OnlyBack"

/datum/second_wind/proc/open_window()
	BODY_PLAYED
	ui_interact(played)

/datum/second_wind/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SecondWind")
		ui.open()

/datum/second_wind/ui_state(mob/user)
	return GLOB.always_state

/datum/second_wind/ui_data(mob/user)
	var/list/data = list()
	data["TimeData"] = get_time_text()
	data["DeadData"] = get_dead_time_text()
	data["BodyData"] = get_body_text()
	data["UIState"] = window_state
	return data

/datum/second_wind/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("GoHome")
			go_home()
			. = TRUE
		if("GoReadme")
			go_readme()
			. = TRUE
		if("ClickedRevive")
			clicked_revive()
			. = TRUE

/datum/second_wind/proc/go_home()
	set_ui_state(SW_UI_DEFAULT)

/datum/second_wind/proc/go_readme()
	set_ui_state(SW_UI_README)

/datum/second_wind/proc/clicked_revive()
	if(window_state != SW_UI_CONFIRM)
		set_ui_state(SW_UI_CONFIRM)
		return
	attempt_revival()
	set_ui_state(SW_UI_DEFAULT)

/datum/second_wind/proc/set_ui_state(state)
	BODY_PLAYED
	window_state = state
	ui_interact(played)

////////////////////////////////////////////////////////////////////////
// The Verb to open Window
/client/verb/second_wind()
	set name = "Second Wind"
	set desc = "Attempt to revive yourself (or just check on it)."
	set category = "IC"

	SSsecondwind.show_menu_to(ckey)

/datum/action/innate/second_windify
	name = "Second Wind"
	desc = "Live once more! Maybe~"

/datum/action/innate/second_windify/IsAvailable(silent = FALSE)
	return TRUE // its available all the time

/datum/action/innate/second_windify/Activate()
	if(!isliving(owner))
		return
	SSsecondwind.show_menu_to(owner.ckey)
	return TRUE

#undef FLOOR_MASTER
#undef BODY_PLAYED
#undef SW_ERROR_NO_ERROR
#undef SW_ERROR_NO_BODY
#undef SW_ERROR_QDELLED_BODY
#undef SW_ERROR_THIRD_WINDED
#undef SW_ERROR_NO_GHOST
#undef SW_ERROR_NOT_DEAD
#undef SW_ERROR_BODY_OCCUPIED
#undef SW_ERROR_CANNOT_REENTER
#undef SW_ERROR_ON_COOLDOWN
#undef SW_ERROR_CUFFED
#undef SW_ERROR_NO_LIVES
#undef SW_UI_DEFAULT
#undef SW_UI_README
#undef SW_UI_CONFIRM
#undef SW_AM_THIRD_WINDED
#undef SW_I_SECOND_WINDED
#undef SW_I_DIED_BEFORE
#undef SW_FULL_LIFE_CONSEQUENCES
