/datum/game_mode/extended
	name = "secret extended"
	config_tag = "secret_extended"
	false_report_weight = 5
	required_players = 0

	announce_span = "notice"
	announce_text = "Just have fun and enjoy the game!"

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return "The transmission mostly failed to mention your sector. It is possible that there is nothing in the Syndicate that could threaten your station during this shift."

/datum/game_mode/extended/announced
	name = "extended"
	config_tag = "extended"
	false_report_weight = 0

/datum/game_mode/extended/announced/generate_station_goals()
	if(flipseclevel) //CIT CHANGE - allows the sec level to be flipped roundstart
		return ..()
	for(var/T in subtypesof(/datum/station_goal))
		var/datum/station_goal/G = new T
		station_goals += G
		G.on_report()
