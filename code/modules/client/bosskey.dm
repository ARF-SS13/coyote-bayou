/client
	var/boss = FALSE

/client/verb/boss_key()
	set name = "Boss Key"
	set desc = "Press this to avoid uncomfortable HR meetings."
	set category = "OOC"

	if(boss) // unboss
		fit_viewport()
		to_chat(src, span_hypnophrase("Phew, that was close."))
		boss = FALSE
		return
	winset(src, "mainwindow.split", "splitter=100")
	to_chat(src, span_phobia("Oh no, the boss is coming!"))
	boss = TRUE

/datum/keybinding/client/bosskey
	hotkey_keys = list("=")
	name = "bosskey"
	full_name = "Boss Key"
	description = "Press this to avoid uncomfortable HR meetings. Great to use in the middle of a boss fight."

/datum/keybinding/client/bosskey/down(client/user)
	user.boss_key()
	return TRUE
