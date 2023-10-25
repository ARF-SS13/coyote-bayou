//-->Addition of some character actions that go on the same spot

/atom/movable/screen/autowhisper
	name = "autowhisper"
	icon_state = "autowhisper0"
	screen_loc = ui_character_actions

/atom/movable/screen/autowhisper/Click(location,control,params)
	var/mob/M = usr
	to_chat(M, span_notice("You'll now whisper everything you say."))
	M.is_autowhisper = M.is_autowhisper ? FALSE : TRUE
	if(M.is_autowhisper)
		icon_state = "autowhisper1"
	else
		icon_state = "autowhisper0"




/atom/movable/screen/pose
	name = "pose"
	icon_state = "pose"
	screen_loc = ui_character_actions

/atom/movable/screen/pose/Click(location,control,params)
	var/mob/M = usr
	M.manage_flavor_tests()




/atom/movable/screen/up
	name = "up"
	icon_state = "up"
	screen_loc = ui_character_actions

/atom/movable/screen/up/Click(location,control,params)
	if(isliving(usr))
		var/mob/living/L = usr
		to_chat(L, span_danger("Double clicking on the same button will make you travel up, if possible."))
		L.lookup()

/atom/movable/screen/up/DblClick(location,control,params)
	var/mob/L = usr
	L.up()



/atom/movable/screen/down
	name = "down"
	icon_state = "down"
	screen_loc = ui_character_actions

/atom/movable/screen/down/Click(location,control,params)
	var/mob/L = usr
	L.down()




/atom/movable/screen/sleep_hud_button
	name = "sleep toggle"
	icon_state = "sleep"
	screen_loc = ui_character_actions

/atom/movable/screen/sleep_hud_button/Click(location,control,params)
	if(isliving(usr))
		var/mob/living/L = usr
		L.toggle_mob_sleep()
