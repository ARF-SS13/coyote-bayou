#define FLOOR_MASTER var/mob/living/master = get_revivable_body(); if(!master) return;
#define BODY_PLAYED var/mob/played = get_currently_played_mob(); if(!played) return;

#define SW_ERROR_NO_ERROR       0
#define SW_ERROR_NO_BODY        (0 << 1 )
#define SW_ERROR_QDELLED_BODY   (0 << 2 )
#define SW_ERROR_THIRD_WINDED   (0 << 3 )
#define SW_ERROR_NO_GHOST       (0 << 4 )
#define SW_ERROR_NOT_DEAD       (0 << 5 )
#define SW_ERROR_BODY_OCCUPIED  (0 << 6 )
#define SW_ERROR_CANNOT_REENTER (0 << 7 )
#define SW_ERROR_ON_COOLDOWN    (0 << 8 )
#define SW_ERROR_CUFFED         (0 << 9 )
#define SW_ERROR_NO_LIVES       (0 << 10)
#define SW_ERROR_DISABLED       (0 << 11)
#define SW_ERROR_NOT_STARTED    (0 << 12)

#define SW_UI_DEFAULT "SWDefault"
#define SW_UI_README  "SWReadMe"
#define SW_UI_CONFIRM "SWConfirm"

#define SW_AM_THIRD_WINDED        (1 << 0)
#define SW_I_SECOND_WINDED        (1 << 1)
#define SW_I_DIED_BEFORE          (1 << 2)
#define SW_FULL_LIFE_CONSEQUENCES (1 << 3)

/// Yeah this is gonna be important later
SUBSYSTEM_DEF(secondwind)
	name = "SecondWind"
	flags = SS_BACKGROUND
	wait = 1 SECONDS

	/// all our fine folk with second wind
	/// format: list("ckey" = datum/second_wind)
	var/list/second_winders = list()
	var/life_cooldown = 2 HOURS
	var/max_lives = 1
	var/start_lives = 1
	var/allow_third_wind = TRUE
	var/master_toggle = TRUE

	var/used_a_second_wind = 0
	var/died_at_least_once = 0
	var/third_winded_folk = 0
	var/full_life_consequences = 0
	var/last_life_tick = 0

/datum/controller/subsystem/secondwind/stat_entry(msg)
	msg = "#:[LAZYLEN(second_winders)]-F:[full_life_consequences]-D:[died_at_least_once]-SW:[used_a_second_wind]-TW:[third_winded_folk]-C:[round(cost,0.005)]"
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
	for(var/mob_key in second_winders)
		var/datum/second_wind/my_wind = second_winders[mob_key]
		if(!my_wind)
			second_winders -= mob_key
			continue
		var/stats = my_wind.living_tick(adustment)
		if(CHECK_BITFIELD(stats, SW_AM_THIRD_WINDED))
			third_winded_folk++
		if(CHECK_BITFIELD(stats, SW_I_SECOND_WINDED))
			used_a_second_wind++
		if(CHECK_BITFIELD(stats, SW_I_DIED_BEFORE))
			died_at_least_once++
		if(CHECK_BITFIELD(stats, SW_FULL_LIFE_CONSEQUENCES))
			full_life_consequences++
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
	if(!my_wind)
		my_wind = new /datum/second_wind(ckey)
	my_wind.one_up()

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

	var/window_state = SW_UI_DEFAULT

	var/times_second_winded = 0
	var/times_died = 0

/datum/second_wind/New(new_key)
	ownerkey = new_key
	lives_left = SSsecondwind.start_lives
	SSsecondwind.second_winders[ownerkey] = src
	get_revivable_body()

/datum/second_wind/proc/get_revivable_body()
	var/mob/corpse = GET_WEAKREF(ownermob)
	var/mob/current = get_currently_played_mob() // should always be *something*
	if(!current)
		CRASH("get_revivable_body failed to get the player's current body! Did someone banish them to the shadow realm (nullspace)?")
	if(isliving(current) && (!corpse || current != corpse))
		corpse = current
		ownermob = WEAKREF(corpse)
	return corpse

/datum/second_wind/proc/get_currently_played_mob()
	if(!ownerkey)
		CRASH("get_currently_played_mob called on a second wind with no ownerkey! wtf")
	var/mob/maybemob = ckey2mob(ownerkey)
	return maybemob

/datum/second_wind/proc/living_tick(time_shift)
	. = get_stats()
	if(third_winded)
		return
	if(lives_left >= SSsecondwind.max_lives)
		life_meter = 0
		lives_left = SSsecondwind.max_lives
		return
	life_meter += time_shift
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

/datum/second_wind/proc/one_up(silent)
	lives_left = clamp(lives_left + 1, 0, SSsecondwind.max_lives)
	if(third_winded)
		third_winded = FALSE // Third Wind prevents this from being called naturall, but admins can still force it
	if(silent)
		return
	BODY_PLAYED
	to_chat(played, span_greentext("You feel your energy return to you! Seems like you've gotten yourself a second wind!"))

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
	if(!revive_me())
		return
	spend_life(freebie)

/datum/second_wind/proc/revive_me()
	if(third_winded)
		return
	FLOOR_MASTER
	BODY_PLAYED
	var/datum/reagents/master_reagents = master.reagents
	var/toxinlover = is_toxin_lover(master)
	var/is_robot = isrobotic(master)
	var/mob/ghost = master.get_ghost()
	if(!ghost)
		relay_msg_admins("Second Wind: [master] tried to revive, but their ghost was null!")
		return
	ghost.client?.change_view(CONFIG_GET(string/default_view))
	ghost.transfer_ckey(ghost.mind.current, FALSE)
	SStgui.on_transfer(src, ghost.mind.current) // Transfer NanoUIs.
	ghost.mind?.current?.client?.init_verbs()
	to_chat(master, span_greentext("You feel drawn back into your body!"))
	master_reagents.remove_all(999) // First purge all their reagents
	master.adjustOxyLoss(-999)
	master.adjust_fire_stacks(-20)
	var/list/my_damages = list(
		"brute" = master.getBruteLoss(),
		"burn" = master.getFireLoss(),
		"tox" = master.toxloss,
	)
	if(is_robot)
		my_damages["brute"] += (my_damages["tox"] * 0.5) // shouldnt happen, but just in case
		my_damages["burn"] += (my_damages["tox"] * 0.5) // shouldnt happen, but just in case
		master.apply_damage(-master.toxloss, TOX)
		my_damages["tox"] = 0
	var/total_damage = 0
	for(var/dtype in my_damages)
		total_damage += my_damages[dtype]
	var/deficit = total_damage - 120
	var/list/to_heal = list(
		"brute" = 0,
		"burn" = 0,
		"tox" = 0,
	)
	while(deficit-- > 0 && my_damages.len)
		var/damtype = pick(my_damages)
		my_damages[damtype] -= 1
		to_heal[damtype] += 1
		if(my_damages[damtype] <= 0)
			my_damages -= damtype
	var/highest_type = "brute"
	var/highest = my_damages["brute"]
	for(var/dtype in my_damages)
		if(my_damages[type] > highest)
			highest_type = dtype
			highest = my_damages[dtype]
	master.apply_damages(
		brute = -to_heal["brute"],
		burn = -to_heal["burn"],
		tox = -to_heal["tox"],
		oxy = -200,
		brain = -200,
	)
	if(is_robot)
		master_reagents.add_reagent(/datum/reagent/fuel/robo_repair_gel, 50)
	else
		switch(highest_type)
			if("brute")
				if(is_robot)
					master_reagents.add_reagent(/datum/reagent/fuel/robo_repair_gel, 20)
				else
					master_reagents.add_reagent(/datum/reagent/medicine/sal_acid, 20)
			if("burn")
				if(is_robot)
					master_reagents.add_reagent(/datum/reagent/fuel/robo_repair_gel, 20)
				else
					master_reagents.add_reagent(/datum/reagent/medicine/oxandrolone, 20)
			if("tox")
				if(toxinlover)
					master_reagents.add_reagent(/datum/reagent/toxin, 50)
				else
					master_reagents.add_reagent(/datum/reagent/medicine/antitoxin, 20)
					master_reagents.add_reagent(/datum/reagent/medicine/prussian_blue, 20)
		master_reagents.add_reagent(/datum/reagent/medicine/epinephrine, 20)
		master_reagents.add_reagent(/datum/reagent/medicine/atropine, 20)
		master_reagents.add_reagent(/datum/reagent/medicine/salglu_solution, 100)
		master_reagents.add_reagent(/datum/reagent/medicine/coagulant, 15)
		master_reagents.add_reagent(/datum/reagent/medicine/silibinin, 15)
		master_reagents.add_reagent(/datum/reagent/medicine/polypyr, 15)
		master_reagents.add_reagent(/datum/reagent/medicine/muscle_stimulant, 20)
	/// should be enough to get them up
	master.revive()
	if(master.stat == DEAD) // huh, still dead
		to_chat(played, span_alert("Something went wrong and you're still dead!"))
		master.apply_damages(
			brute = to_heal["brute"],
			burn = to_heal["burn"],
			tox = to_heal["tox"],
		)
		master_reagents.remove_all(999)
		relay_msg_admins("Second Wind: [master] tried to revive, but they're still dead!")
		return
	return TRUE

/datum/second_wind/proc/spend_life(free_life)
	BODY_PLAYED
	if(!free_life)
		lives_left--
	if(lives_left < 0)
		third_winded = TRUE
		to_chat(played, span_phobia("You have exhausted the last of your strength! If you die again, you will need someone else to get you back up!"))
	else if(lives_left == 0)
		to_chat(played, span_alert("You have exerted a great deal of strength to get yourself back up! You'll need to stay alive for at least \
			[DisplayTimeText(SSsecondwind.life_cooldown, 1)] before you can do it again safely!"))
	else
		to_chat(played, span_alert("You have exerted a great deal of strength to get yourself back up, though you still have the strength to do it \
			[lives_left] more time[lives_left > 1 ? "s" : ""]!"))

/datum/second_wind/proc/message_the_revived()
	BODY_PLAYED
	if(third_winded)
		to_chat(played, span_userdanger("You have exerted every last ounce of mortal strength you have into your second chance! \
			If you die again, your only choice for revival will be from a rescuer!"))
		played.mind?.store_memory("You're all out of revives, and if you die again, you'll need someone to rescue you!")
	else
		to_chat(played, span_userdanger("You have found the strength to revive yourself! However, it was very taxing, you'll need \
			to wait at least [DisplayTimeText(SSsecondwind.life_cooldown, 1)] before you can safely do it again."))
		played.mind?.store_memory("You've used your second wind, and you'll need to wait at least [DisplayTimeText(SSsecondwind.life_cooldown, 1)] before you can safely do it again.")

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
	if(QDELETED(master))
		return SW_ERROR_QDELLED_BODY
	if(!master.stat != DEAD)
		return SW_ERROR_NOT_DEAD
	if(third_winded)
		return SW_ERROR_THIRD_WINDED
	if(lives_left <= 0)
		return SW_ERROR_NO_LIVES
	var/mob/dead/observer/myghost = master.get_ghost()
	if(!myghost)
		return SW_ERROR_NO_GHOST
	if(!myghost.can_reenter_corpse || master.suiciding)
		return SW_ERROR_CANNOT_REENTER
	if(master.restrained(TRUE))
		return SW_ERROR_CUFFED
	return SW_ERROR_NO_ERROR

/datum/second_wind/proc/get_time_text()
	FLOOR_MASTER
	. = list(
		"PBarColors" = "average",
		"TimeText" = "Soon!",
		"Percentage" = 100,
		"TargTime" = SSsecondwind.life_cooldown,
	)
	if(third_winded)
		.["PBarColors"] = "bad"
		.["TimeText"] = "Never!"
		return
	if(master.stat == DEAD)
		.["PBarColors"] = "average"
		.["TimeText"] = "Paused!"
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
		.["PBarColors"] = "good"
		.["Percentage"] = round((timeleft / SSsecondwind.life_cooldown) * 100, 0.1)
		.["TimeText"] = "[DisplayTimeText(timeleft, 1)]"

/datum/second_wind/proc/get_body_text()
	FLOOR_MASTER
	if(window_state == SW_UI_README)
		return get_readme_text()
	if(window_state == SW_UI_CONFIRM)
		return get_confirm_text()
	var/revive_error = can_revive()
	var/am_dead = master.stat == DEAD
	. = list()
	switch(revive_error)
		if(SW_ERROR_NO_ERROR)
			if(am_dead)
				.["BodyHead"] = "Clear to revive"
				.["BodyFill"] = "You can revive yourself!"
				.["BodyHeadColor"] = "good"
				.["ShowButtons"] = "OnlyRevive"
			else
				.["BodyHead"] = "Second Wind Ready"
				.["BodyFill"] = "You're good and rested! If you die, you can revive yourself just fine!"
				.["BodyHeadColor"] = "good"
				.["ShowButtons"] = "None"
		if(SW_ERROR_DISABLED)
			.["BodyHead"] = "DISABLED"
			.["BodyFill"] = "Second Wind is disabled. Sorry!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_NOT_STARTED)
			.["BodyHead"] = "Round Hasn't Started"
			.["BodyFill"] = "Hold your horses, the world isn't even alive yet!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_NO_BODY)
			.["BodyHead"] = "No body"
			.["BodyFill"] = "You don't have a body to revive!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_QDELLED_BODY)
			.["BodyHead"] = "Body deleted"
			.["BodyFill"] = "Your body is in the trash where it belongs (its been deleted, sorry!) You can't revive yourself!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_NO_GHOST)
			.["BodyHead"] = "No ghost"
			.["BodyFill"] = "You somehow lack a ghost! This is probably a bug."
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_BODY_OCCUPIED)
			.["BodyHead"] = "Body occupied"
			.["BodyFill"] = "Your body is occupied by someone else! You can't revive yourself!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_CANNOT_REENTER)
			.["BodyHead"] = "Can't re-enter your body"
			.["BodyFill"] = "You have elected to stay dead, or something along those lines."
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_CUFFED)
			.["BodyHead"] = "Body handcuffed"
			.["BodyFill"] = "Your body is handcuffed! You can't revive yourself!"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_THIRD_WINDED)
			.["BodyHead"] = "Third winded"
			if(am_dead)
				.["BodyFill"] = "You've already used your third wind, you can't revive yourself! You'll need to be rescued, or hop on a different character if you want to keep playing!"
			else
				.["BodyFill"] = "You've already used your third wind, you won't be able to revive yourself if you die!"
				if(prob(1))
					.["BodyFill"] += " YOLO~"
			.["BodyHeadColor"] = "bad"
			.["ShowButtons"] = "None"
		if(SW_ERROR_NO_LIVES)
			.["BodyHead"] = "Out of lives"
			if(am_dead)
				.["BodyFill"] = "You have revived yourself recently, and while you can still revive yourself right now, it will be your last! \
					If you die again after reviving, you'll need to be rescued, or hop on a different character if you want to keep playing!"
				.["ShowButtons"] = "OnlyRevive"
			else
				.["BodyFill"] = "You have revived yourself recently, and you'll need to wait a while before you can do it again safely! \
					If you die, you will still be able to revive yourself, but it'll be your last! Try to stay alive!"
				if(prob(1))
					.["BodyFill"] += " YOLO~"
				.["ShowButtons"] = "None"
			.["BodyHeadColor"] = "bad"

/datum/second_wind/proc/get_confirm_text()
	FLOOR_MASTER
	. = list()
	if(!SSsecondwind.master_toggle)
		.["BodyHead"] = "DISALBED!"
		.["BodyFill"] = "Second Wind is disabled. Sorry! (How'd you even get here =3)"
		.["BodyHeadColor"] = "good"
		.["ShowButtons"] = "OnlyBack" // hey come check out my OnlyBack
		return
	if(!SSticker.current_state < GAME_STATE_PLAYING)
		.["BodyHead"] = "Round Hasn't Started"
		.["BodyFill"] = "Hold your horses, the world isn't even alive yet! (How'd you even get here =3)"
		.["BodyHeadColor"] = "good"
		.["ShowButtons"] = "OnlyBack"
		return
	if(master.stat != DEAD)
		.["BodyHead"] = "You're not dead!"
		.["BodyFill"] = "You need to be dead to revive yourself, silly!"
		.["BodyHeadColor"] = "good"
		.["ShowButtons"] = "OnlyBack"
		return
	if(third_winded)
		.["BodyHead"] = "You cannot revive yourself!"
		.["BodyFill"] = "You've already spent your last life! You'll need to be rescued, or hop on a different character if you want to keep playing!"
		.["BodyHeadColor"] = "bad"
		.["ShowButtons"] = "OnlyBack"
		return
	if(lives_left > 1)
		.["BodyHead"] = "Revive yourself?"
		.["BodyFill"] = "You have [lives_left] lives left. Reviving yourself will cost one of them, \
							and it will take [DisplayTimeText(SSsecondwind.life_cooldown, 1)] to get one back."
		.["BodyHeadColor"] = "good"
		.["ShowButtons"] = "OnlyConfirm"
		return
	if(lives_left <= 0 && !third_winded)
		.["BodyHead"] = "Revive yourself for the last time?"
		.["BodyFill"] = "WARNING: This is your last life! If you revive yourself now, you will not be able to revive yourself \
							again if you die! If you die again, the only way you'll be able to play again is if someone else revives \
							you, or you hop onto a different character!"
		.["BodyHeadColor"] = "bad"
		.["ShowButtons"] = "OnlyConfirm"
		return

/datum/second_wind/proc/get_readme_text()
	. = list()
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
	.["BodyHeadColor"] = "good"
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
