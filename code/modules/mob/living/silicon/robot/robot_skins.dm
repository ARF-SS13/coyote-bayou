/// Goon had an old datum, an appearanceholder. this is kinda that, but for robots
/// The appearance of a borg
/datum/robot_skin
	var/key
	var/name
	var/mob/living/silicon/owner

	var/base_icon
	var/base_icon_state

	var/rest_state
	var/sit_state
	var/cute_state

	var/dead_state
	var/dead_overlay

	var/eye_state_off
	var/eye_state_1
	var/eye_state_2
	var/eye_state_3
	var/eye_state_4
	var/eye_state_5
	var/eye_color

	var/open_icon = 'icons/mob/borgs/robots.dmi'
	var/open_wires_state = "ov-opencover +w"
	var/open_empty_state = "ov-opencover +c"
	var/open_cell_state = "ov-opencover -c"

	var/stunned_state
	var/stuned_overlay_state

	var/list/ride_offset_x = list("north" = 0, "south" = 0, "east" = -6, "west" = 6)
	var/list/ride_offset_y = list("north" = 4, "south" = 4, "east" = 3, "west" = 3)

	var/list/hat_offsets_x = list()
	var/list/hat_offsets_y = list()

	var/list/weapon_offsets_x = list()
	var/list/weapon_offsets_y = list()

	var/matrix/normal_transform
	var/matrix/dead_transform
	var/curr_transform = "normal"

/datum/robot_skin/New(mob/living/silicon/target)
	. = ..()
	if(target)
		owner = target
		normal_transform = owner.transform
		dead_transform = owner.transform.Turn(90)

/datum/robot_skin/Destroy(force, ...)
	if(owner)
		owner.my_skin = null
		owner = null
	. = ..()

/datum/robot_skin/proc/update_me()
	if(!owner)
		return
	owner.cut_overlays()
	update_body()
	update_wires()
	update_hat()

/datum/robot_skin/proc/update_body()
	owner.icon = base_icon
	if(owner.stat == DEAD)
		if(dead_state)
			owner.icon_state = dead_state
		if(dead_overlay)
			owner.add_overlay(dead_overlay)
		else
			death_turn()
		return
	death_unturn()
	if(owner.incapacitated(ignore_grab = TRUE))
		//owner.icon_state = stunned_state
		if(stuned_overlay_state)
			owner.add_overlay(stuned_overlay_state)
		return
	// okay now they get their eyes, if any
	var/relaxstate
	if(owner.resting)
		switch(owner.fluff_state)
			if("cute")
				relax_state = cute_state
			if("sit")
				relax_state = sit_state
			if("rest")
				relax_state = rest_state
	if(relaxstate)
		owner.icon_state = relax_state
	else
		var/mutable_appearance/eyes = new()
		eyes.icon = base_icon
		switch(owner.lamp_intensity)
			if(0)
				eyes.icon_state = eye_state_off
			if(1)
				eyes.icon_state = eye_state_1
			if(2)
				eyes.icon_state = eye_state_2
			if(3)
				eyes.icon_state = eye_state_3
			if(4)
				eyes.icon_state = eye_state_4
			if(5)
				eyes.icon_state = eye_state_5
		eyes.color = "#FFFFFF" // for now
		owner.add_overlay(eyes)

/datum/robot_skin/proc/overlay_wires()
	if(!owner.opened)
		return
	var/mutable_appearance/wires = new()
	wires.icon = open_icon
	if(owner.wiresexposed)
		wires.icon_state = open_wires_state
	else if(cell)
		wires.icon_state = open_cell_state
	else
		wires.icon_state = open_empty_state
	owner.add_overlay(wires)

/datum/robot_skin/proc/handle_hat()
	if(!owner)
		return
	if(owner.resting || owner.stat)
		return
	if(!owner.hat)
		return
	var/mutable_appearance/head_overlay = owner.hat.build_worn_icon(default_layer = 20, default_icon_file = 'icons/mob/clothing/head.dmi', override_state = owner.hat.icon_state)
	head_overlay.pixel_x = hat_offsets_x[dir2text(owner.dir)]
	head_overlay.pixel_y = hat_offsets_y[dir2text(owner.dir)]
	owner.add_overlay(head_overlay)

/datum/robot_skin/proc/get_preview_image()
	var/mutable_appearance/preview = new()
	preview.icon = base_icon
	preview.icon_state = base_icon_state
	preview.color = "#FFFFFF"
	return preview

/// The handies
/datum/robot_skin/handy_handy
	name = "Mr. Handy"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "handy"

	eye_state_off = "eyes-handy"
	eye_state_1 = "eyes-handy"
	eye_state_2 = "eyes-handy-lights"
	eye_state_3 = "eyes-handy-lights"
	eye_state_4 = "eyes-handy-lights"
	eye_state_5 = "eyes-handy-lights"

/datum/robot_skin/handy_engineer
	name = "Mr. Fixit"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "engineer"

	eye_state_off = "engineer_e"
	eye_state_1 = "engineer_e"
	eye_state_2 = "engineer_l"
	eye_state_3 = "engineer_l"
	eye_state_4 = "engineer_l"
	eye_state_5 = "engineer_l"

/datum/robot_skin/handy_tophat
	name = "Mr. Dapper"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "tophat"

	eye_state_off = "tophat_e"
	eye_state_1 = "tophat_e"
	eye_state_2 = "tophat_l"
	eye_state_3 = "tophat_l"
	eye_state_4 = "tophat_l"
	eye_state_5 = "tophat_l"

/datum/robot_skin/handy_medical
	name = "Mr. Mendy"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "medical"

	eye_state_off = "medical_e"
	eye_state_1 = "medical_e"
	eye_state_2 = "medical_l"
	eye_state_3 = "medical_l"
	eye_state_4 = "medical_l"
	eye_state_5 = "medical_l"

/datum/robot_skin/handy_peace
	name = "Officer Handy"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "peace"

	eye_state_off = "peace_e"
	eye_state_1 = "peace_e"
	eye_state_2 = "peace_l"
	eye_state_3 = "peace_l"
	eye_state_4 = "peace_l"
	eye_state_5 = "peace_l"

/datum/robot_skin/handy_botany
	name = "Mr. Slipsy"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "botany"

	eye_state_off = "botany_e"
	eye_state_1 = "botany_e"
	eye_state_2 = "botany_l"
	eye_state_3 = "botany_l"
	eye_state_4 = "botany_l"
	eye_state_5 = "botany_l"

/datum/robot_skin/handy_miner
	name = "Mr. Roxy"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "miner"

	eye_state_off = "miner_e"
	eye_state_1 = "miner_e"
	eye_state_2 = "miner_l"
	eye_state_3 = "miner_l"
	eye_state_4 = "miner_l"
	eye_state_5 = "miner_l"

/datum/robot_skin/handy_gutsy
	name = "Mr. Gusty"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "gutsy"

	eye_state_off = "gutsy_e"
	eye_state_1 = "gutsy_e"
	eye_state_2 = "gutsy_l"
	eye_state_3 = "gutsy_l"
	eye_state_4 = "gutsy_l"
	eye_state_5 = "gutsy_l"

/datum/robot_skin/handy_pleasure
	name = "Mr. Diddly"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "pleasure"

	eye_state_off = "pleasure_e"
	eye_state_1 = "pleasure_e"
	eye_state_2 = "pleasure_l"
	eye_state_3 = "pleasure_l"
	eye_state_4 = "pleasure_l"
	eye_state_5 = "pleasure_l"

///ss13 borgs
/datum/robot_skin/ss13_botany
	name = "Farmin' Fred"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "botany"

	eye_state_off = "botany_e"
	eye_state_1 =   "botany_e"
	eye_state_2 =   "botany_e"
	eye_state_3 =   "botany_e"
	eye_state_4 =   "botany_e"
	eye_state_5 =   "botany_e"

/datum/robot_skin/ss13_centcom
	name = "Diplomatic Dan"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "centcom"

	eye_state_off = "centcom_e"
	eye_state_1 =   "centcom_e"
	eye_state_2 =   "centcom_e"
	eye_state_3 =   "centcom_e"
	eye_state_4 =   "centcom_e"
	eye_state_5 =   "centcom_e"

/datum/robot_skin/ss13_engi_tread
	name = "Rolling Rupert"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "engi-tread"

	eye_state_off = "engi-tread_e"
	eye_state_1 =   "engi-tread_e"
	eye_state_2 =   "engi-tread_e"
	eye_state_3 =   "engi-tread_e"
	eye_state_4 =   "engi-tread_e"
	eye_state_5 =   "engi-tread_e"

/datum/robot_skin/ss13_sec_tread
	name = "Security Sam"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "sec-tread"

	eye_state_off = "sec-tread_e"
	eye_state_1 =   "sec-tread_e"
	eye_state_2 =   "sec-tread_e"
	eye_state_3 =   "sec-tread_e_r"
	eye_state_4 =   "sec-tread_e_r"
	eye_state_5 =   "sec-tread_e_r"

/datum/robot_skin/ss13_sec
	name = "Security Sox"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "sec"

	eye_state_off = "sec_e"
	eye_state_1 =   "sec_e"
	eye_state_2 =   "sec_e"
	eye_state_3 =   "sec_e_r"
	eye_state_4 =   "sec_e_r"
	eye_state_5 =   "sec_l"

/datum/robot_skin/ss13_synd_sec
	name = "Syndicate Susie"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "synd_sec"

	eye_state_off = "synd_sec_e"
	eye_state_1 =   "synd_sec_e"
	eye_state_2 =   "synd_sec_e"
	eye_state_3 =   "synd_sec_l"
	eye_state_4 =   "synd_sec_l"
	eye_state_5 =   "synd_sec_l"

/datum/robot_skin/ss13_synd_medical
	name = "Syndicate Sloppington"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "synd_medical"

	eye_state_off = "synd_medical_e"
	eye_state_1 =   "synd_medical_e"
	eye_state_2 =   "synd_medical_e"
	eye_state_3 =   "synd_medical_l"
	eye_state_4 =   "synd_medical_l"
	eye_state_5 =   "synd_medical_l"

/// ass-aultrons

/datum/robot_skin/assaultron_sase
	name = "Diplomatic Dan"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "assaultron_sase"

	dead_state = "assaultron_sase_dead"

	eye_state_off = "assaultron_sase_e"
	eye_state_1 =   "assaultron_sase_e"
	eye_state_2 =   "assaultron_sase_e"
	eye_state_3 =   "assaultron_sase_e"
	eye_state_4 =   "assaultron_sase_e"
	eye_state_5 =   "assaultron_sase_e"

/// robots from the robots2 file
/// retro bots
/datum/robot_skin/retro_engineering
	name = "TEG 999"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Engineering"

/datum/robot_skin/retro_miner_old
	name = "ROK 123"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Miner_old"

/datum/robot_skin/retro_brobot
	name = "BRO B12"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Brobot"

/datum/robot_skin/retro_service_f
	name = "SRV F80"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Service"

/datum/robot_skin/retro_service_m
	name = "SRV M80"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Service2"

/datum/robot_skin/retro_hydro
	name = "HYD P39"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Hydrobot"

/datum/robot_skin/retro_med
	name = "MED D11"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "Medbot"

/datum/robot_skin/retro_sec
	name = "SEC B47"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "secborg"

/datum/robot_skin/retro_max
	name = "MAX $$$"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "maximillion"

/datum/robot_skin/retro_janbot
	name = "JAN M09
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "JanBot2"

// cool retro borgs
/datum/robot_skin/cool_retro_sec
	name = "DEATHNIHILATOR
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "securityrobot"

/datum/robot_skin/cool_retro_med
	name = "MALPRACTRON"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "medicalrobot"

/datum/robot_skin/cool_retro_eng
	name = "OSHAVIOLATOR"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "engineerrobot"

/datum/robot_skin/cool_retro_eng
	name = "KNEEDEEPINTHEDEAD"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "janitorrobot"

/// hi lucy!
/datum/robot_skin/lucy
	name = "Lucy"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "rowtree-lucy"

/datum/robot_skin/lucy_med
	name = "Dr. Lucy"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "rowtree-medical"

/datum/robot_skin/lucy_sec
	name = "Officer Lucy"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "rowtree-security"

/datum/robot_skin/lucy_eng
	name = "Foreman Lucy"
	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "rowtree-engineering"

/// Cool droids
/datum/robot_skin/droid_miner
	name = "Delta Quotient Seismoid"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "droid-miner"

	eye_state_off = "eyes-droid-miner"
	eye_state_1 =   "eyes-droid-miner"
	eye_state_2 =   "eyes-droid-miner"
	eye_state_3 =   "eyes-droid-miner"
	eye_state_4 =   "eyes-droid-miner"
	eye_state_5 =   "eyes-droid-miner"

/datum/robot_skin/droid_medical
	name = "Beta Gamma Mepilex"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "droid-medical"

	eye_state_off = "eyes-droid-medical"
	eye_state_1 =   "eyes-droid-medical"
	eye_state_2 =   "eyes-droid-medical"
	eye_state_3 =   "eyes-droid-medical"
	eye_state_4 =   "eyes-droid-medical"
	eye_state_5 =   "eyes-droid-medical"

/datum/robot_skin/droid_combat
	name = "Omega Omega Targation"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "droid-combat"

	eye_state_off = "eyes-droid-combat"
	eye_state_1 =   "eyes-droid-combat"
	eye_state_2 =   "eyes-droid-combat"
	eye_state_3 =   "eyes-droid-combat"
	eye_state_4 =   "eyes-droid-combat"
	eye_state_5 =   "eyes-droid-combat"

/datum/robot_skin/droid_combat_roll
	name = "Rho Wyeta Bonewheel"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "droid-combat-roll"

	eye_state_off = "eyes-droid-combat-roll"
	eye_state_1 =   "eyes-droid-combat-roll"
	eye_state_2 =   "eyes-droid-combat-roll"
	eye_state_3 =   "eyes-droid-combat-roll"
	eye_state_4 =   "eyes-droid-combat-roll"
	eye_state_5 =   "eyes-droid-combat-roll"

/datum/robot_skin/droid_science
	name = "Eta Charlie Philonistry"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "droid-science"

	eye_state_off = "eyes-droid-science"
	eye_state_1 =   "eyes-droid-science"
	eye_state_2 =   "eyes-droid-science"
	eye_state_3 =   "eyes-droid-science"
	eye_state_4 =   "eyes-droid-science"
	eye_state_5 =   "eyes-droid-science"

/// cool drones
/datum/robot_skin/drone_standard
	name = "Sally-V"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-standard"

	eye_state_off = "eyes-drone-standard"
	eye_state_1 =   "eyes-drone-standard"
	eye_state_2 =   "eyes-drone-standard"
	eye_state_3 =   "eyes-drone-standard"
	eye_state_4 =   "eyes-drone-standard"
	eye_state_5 =   "eyes-drone-standard"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_engineer
	name = "Grunt-XVII"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-engineer"

	eye_state_off = "eyes-drone-engineer"
	eye_state_1 =   "eyes-drone-engineer"
	eye_state_2 =   "eyes-drone-engineer"
	eye_state_3 =   "eyes-drone-engineer"
	eye_state_4 =   "eyes-drone-engineer"
	eye_state_5 =   "eyes-drone-engineer"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_miner
	name = "Roxanne-II"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-miner"

	eye_state_off = "eyes-drone-miner"
	eye_state_1 =   "eyes-drone-miner"
	eye_state_2 =   "eyes-drone-miner"
	eye_state_3 =   "eyes-drone-miner"
	eye_state_4 =   "eyes-drone-miner"
	eye_state_5 =   "eyes-drone-miner"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_janitor
	name = "Mopdrew-DCXXI"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-janitor"

	eye_state_off = "eyes-drone-janitor"
	eye_state_1 =   "eyes-drone-janitor"
	eye_state_2 =   "eyes-drone-janitor"
	eye_state_3 =   "eyes-drone-janitor"
	eye_state_4 =   "eyes-drone-janitor"
	eye_state_5 =   "eyes-drone-janitor"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_medical
	name = "Doc-IV"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-medical"

	eye_state_off = "eyes-drone-medical"
	eye_state_1 =   "eyes-drone-medical"
	eye_state_2 =   "eyes-drone-medical"
	eye_state_3 =   "eyes-drone-medical"
	eye_state_4 =   "eyes-drone-medical"
	eye_state_5 =   "eyes-drone-medical"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_surgery
	name = "Doc-IIV"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-surgery"

	eye_state_off = "eyes-drone-surgery"
	eye_state_1 =   "eyes-drone-surgery"
	eye_state_2 =   "eyes-drone-surgery"
	eye_state_3 =   "eyes-drone-surgery"
	eye_state_4 =   "eyes-drone-surgery"
	eye_state_5 =   "eyes-drone-surgery"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_sec
	name = "Beep-Boop-IXII"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-sec"

	eye_state_off = "eyes-drone-sec"
	eye_state_1 =   "eyes-drone-sec"
	eye_state_2 =   "eyes-drone-sec"
	eye_state_3 =   "eyes-drone-sec"
	eye_state_4 =   "eyes-drone-sec"
	eye_state_5 =   "eyes-drone-sec"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_service
	name = "Bart-I"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-service"

	eye_state_off = "eyes-drone-service"
	eye_state_1 =   "eyes-drone-service"
	eye_state_2 =   "eyes-drone-service"
	eye_state_3 =   "eyes-drone-service"
	eye_state_4 =   "eyes-drone-service"
	eye_state_5 =   "eyes-drone-service"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_lost
	name = "SynDg-zcX----0xFDED"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-lost"

	eye_state_off = "eyes-drone-lost"
	eye_state_1 =   "eyes-drone-lost"
	eye_state_2 =   "eyes-drone-lost"
	eye_state_3 =   "eyes-drone-lost"
	eye_state_4 =   "eyes-drone-lost"
	eye_state_5 =   "eyes-drone-lost"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_chemistry
	name = "Crack-VX"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-chemistry"

	eye_state_off = "eyes-drone-chemistry"
	eye_state_1 =   "eyes-drone-chemistry"
	eye_state_2 =   "eyes-drone-chemistry"
	eye_state_3 =   "eyes-drone-chemistry"
	eye_state_4 =   "eyes-drone-chemistry"
	eye_state_5 =   "eyes-drone-chemistry"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_science
	name = "Stampy-XXX"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-science"

	eye_state_off = "eyes-drone-science"
	eye_state_1 =   "eyes-drone-science"
	eye_state_2 =   "eyes-drone-science"
	eye_state_3 =   "eyes-drone-science"
	eye_state_4 =   "eyes-drone-science"
	eye_state_5 =   "eyes-drone-science"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_hydro
	name = "Weed-CDXX"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-hydro"

	eye_state_off = "eyes-drone-hydro"
	eye_state_1 =   "eyes-drone-hydro"
	eye_state_2 =   "eyes-drone-hydro"
	eye_state_3 =   "eyes-drone-hydro"
	eye_state_4 =   "eyes-drone-hydro"
	eye_state_5 =   "eyes-drone-hydro"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/datum/robot_skin/drone_blu
	name = "Blue-DD"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "drone-blu"

	eye_state_off = "eyes-drone-blu"
	eye_state_1 =   "eyes-drone-blu"
	eye_state_2 =   "eyes-drone-blu"
	eye_state_3 =   "eyes-drone-blu"
	eye_state_4 =   "eyes-drone-blu"
	eye_state_5 =   "eyes-drone-blu"

	open_icon = 'icons/mob/borgs/robots2.dmi'
	open_wires_state = "drone-opencover +w"
	open_empty_state = "drone-opencover +c"
	open_cell_state = "drone-opencover -c"

/// Eyebots
/datum/robot_skin/eyebot_engineering
	name = "EG-204"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-engineering"

	eye_state_off = "eyes-eyebot-engineering"
	eye_state_1 =   "eyes-eyebot-engineering"
	eye_state_2 =   "eyes-eyebot-engineering"
	eye_state_3 =   "eyes-eyebot-engineering"
	eye_state_4 =   "eyes-eyebot-engineering"
	eye_state_5 =   "eyes-eyebot-engineering"

/datum/robot_skin/eyebot_janitor
	name = "JN-220"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-janitor"

	eye_state_off = "eyes-eyebot-janitor"
	eye_state_1 =   "eyes-eyebot-janitor"
	eye_state_2 =   "eyes-eyebot-janitor"
	eye_state_3 =   "eyes-eyebot-janitor"
	eye_state_4 =   "eyes-eyebot-janitor"
	eye_state_5 =   "eyes-eyebot-janitor"

/datum/robot_skin/eyebot_medical
	name = "MD-229"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-medical"

	eye_state_off = "eyes-eyebot-medical"
	eye_state_1 =   "eyes-eyebot-medical"
	eye_state_2 =   "eyes-eyebot-medical"
	eye_state_3 =   "eyes-eyebot-medical"
	eye_state_4 =   "eyes-eyebot-medical"
	eye_state_5 =   "eyes-eyebot-medical"

/datum/robot_skin/eyebot_miner
	name = "MN-249"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-miner"

	eye_state_off = "eyes-eyebot-miner"
	eye_state_1 =   "eyes-eyebot-miner"
	eye_state_2 =   "eyes-eyebot-miner"
	eye_state_3 =   "eyes-eyebot-miner"
	eye_state_4 =   "eyes-eyebot-miner"
	eye_state_5 =   "eyes-eyebot-miner"

/datum/robot_skin/eyebot_science
	name = "SC-248"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-science"

	eye_state_off = "eyes-eyebot-science"
	eye_state_1 =   "eyes-eyebot-science"
	eye_state_2 =   "eyes-eyebot-science"
	eye_state_3 =   "eyes-eyebot-science"
	eye_state_4 =   "eyes-eyebot-science"
	eye_state_5 =   "eyes-eyebot-science"

/datum/robot_skin/eyebot_security
	name = "BK-214"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-security"

	eye_state_off = "eyes-eyebot-security"
	eye_state_1 =   "eyes-eyebot-security"
	eye_state_2 =   "eyes-eyebot-security"
	eye_state_3 =   "eyes-eyebot-security"
	eye_state_4 =   "eyes-eyebot-security"
	eye_state_5 =   "eyes-eyebot-security"

/datum/robot_skin/eyebot_standard
	name = "SD-200"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "eyebot-standard"

	eye_state_off = "eyes-eyebot-standard"
	eye_state_1 =   "eyes-eyebot-standard"
	eye_state_2 =   "eyes-eyebot-standard"
	eye_state_3 =   "eyes-eyebot-standard"
	eye_state_4 =   "eyes-eyebot-standard"
	eye_state_5 =   "eyes-eyebot-standard"

/// HUGEbots
/datum/robot_skin/heavyMed
	name = "MediTON"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyMed"

	eye_state_off = "eyes-heavyMed"
	eye_state_1 =   "eyes-heavyMed"
	eye_state_2 =   "eyes-heavyMed"
	eye_state_3 =   "eyes-heavyMed"
	eye_state_4 =   "eyes-heavyMed"
	eye_state_5 =   "eyes-heavyMed"

/datum/robot_skin/heavyServ
	name = "DrinkMAX"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyServ"

	eye_state_off = "eyes-heavyServ"
	eye_state_1 =   "eyes-heavyServ"
	eye_state_2 =   "eyes-heavyServ"
	eye_state_3 =   "eyes-heavyServ"
	eye_state_4 =   "eyes-heavyServ"
	eye_state_5 =   "eyes-heavyServ"

/datum/robot_skin/heavySec
	name = "CrushSMASH"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavySec"

	eye_state_off = "eyes-heavySec"
	eye_state_1 =   "eyes-heavySec"
	eye_state_2 =   "eyes-heavySec"
	eye_state_3 =   "eyes-heavySec"
	eye_state_4 =   "eyes-heavySec"
	eye_state_5 =   "eyes-heavySec"

/datum/robot_skin/heavyEng
	name = "PipeLAYER"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyEng"

	eye_state_off = "eyes-heavyEng"
	eye_state_1 =   "eyes-heavyEng"
	eye_state_2 =   "eyes-heavyEng"
	eye_state_3 =   "eyes-heavyEng"
	eye_state_4 =   "eyes-heavyEng"
	eye_state_5 =   "eyes-heavyEng"

/datum/robot_skin/heavyMiner
	name = "CrackROCKS"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyMiner"

	eye_state_off = "eyes-heavyMiner"
	eye_state_1 =   "eyes-heavyMiner"
	eye_state_2 =   "eyes-heavyMiner"
	eye_state_3 =   "eyes-heavyMiner"
	eye_state_4 =   "eyes-heavyMiner"
	eye_state_5 =   "eyes-heavyMiner"

/datum/robot_skin/heavyRes
	name = "BookWORM"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyRes"

	eye_state_off = "eyes-heavyRes"
	eye_state_1 =   "eyes-heavyRes"
	eye_state_2 =   "eyes-heavyRes"
	eye_state_3 =   "eyes-heavyRes"
	eye_state_4 =   "eyes-heavyRes"
	eye_state_5 =   "eyes-heavyRes"

/datum/robot_skin/heavyStandard
	name = "BigmcLARGEHUGE"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "heavyStandard"

	eye_state_off = "eyes-heavyStandard"
	eye_state_1 =   "eyes-heavyStandard"
	eye_state_2 =   "eyes-heavyStandard"
	eye_state_3 =   "eyes-heavyStandard"
	eye_state_4 =   "eyes-heavyStandard"
	eye_state_5 =   "eyes-heavyStandard"

/datum/robot_skin/syndi-heavy
	name = "Chuck"

	base_icon = 'icons/mob/borgs/robots2.dmi'
	base_icon_state = "syndi-heavy"

	eye_state_off = "eyes-syndi-heavy"
	eye_state_1 =   "eyes-syndi-heavy"
	eye_state_2 =   "eyes-syndi-heavy"
	eye_state_3 =   "eyes-syndi-heavy"
	eye_state_4 =   "eyes-syndi-heavy"
	eye_state_5 =   "eyes-syndi-heavy"



/// more ss13 borgs
/datum/robot_skin/ss13_2_mopgearrex
	name = "Janitor Jerry"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "mopgearrex"

	eye_state_off = "mopgearrex_e"
	eye_state_1 =   "mopgearrex_e"
	eye_state_2 =   "mopgearrex_e"
	eye_state_3 =   "mopgearrex_l"
	eye_state_4 =   "mopgearrex_l"
	eye_state_5 =   "mopgearrex_l"

/datum/robot_skin/ss13_2_mopgearrex
	name = "Janitor Jerry"

	base_icon = 'icons/mob/borgs/robots.dmi'
	base_icon_state = "mopgearrex"

	eye_state_off = "mopgearrex_e"
	eye_state_1 =   "mopgearrex_e"
	eye_state_2 =   "mopgearrex_e"
	eye_state_3 =   "mopgearrex_l"
	eye_state_4 =   "mopgearrex_l"
	eye_state_5 =   "mopgearrex_l"


































