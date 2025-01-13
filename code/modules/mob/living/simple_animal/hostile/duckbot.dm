/* 
 * File:   amusing_duck.cpp
 * Author: tnc02_000
 * toys series with strong sense for playing
 * action! music! light!
 * LAY EGG IS TRUE!!!
 * BUMP'N GO ACTION
 * As the duck advancing, flicking the
 * plumage and yawning the mouth go
 * with music & light.
 * 
 * The duck stop, it swaying tail then the
 * duck lay an egg as open it's buttocks,
 * go with the duck's call
 * 
 * Its an amusing duck toy
 * */

/mob/living/simple_animal/hostile/amusing_duck // have you ever known a duck to *not* be hostile?
	name = "Amusing Duck"
	desc = "bump'n go action! Ages 3 and up. \n Looks like it has a port on its back that'd fit a multitool, neat!"
	icon = 'icons/mob/amusing_duck.dmi'
	icon_state = "duckbot"
	icon_living = "duckbot"
	icon_dead = "duckbot_dead"
	ignore_faction = TRUE // so mobs dont kill it on accident
	ranged = TRUE
	melee_attacks = FALSE
	environment_smash = NONE
	mob_armor = ARMOR_VALUE_RENEGADE_POWER_ARMOR // so we get the tombstone message for our duck
	maxHealth = 40
	health = 40
	density = FALSE
	move_to_delay = 1 SECONDS // slow duck
	melee_damage_lower = 0
	melee_damage_upper = 0
	ranged_cooldown_time = 20 SECONDS
	pass_flags = LETPASSTHROW
	robust_searching = TRUE
	death_sound = 'sound/machines/machinery_break_1.ogg'
	aggro_vision_range = 8 //A little more aggressive once in combat to balance out their really low HP
	decompose = FALSE
	blood_volume = 0
	despawns_when_lonely = FALSE
	robuster_searching = TRUE
	retreat_distance = 0
	minimum_distance = 0
	turns_per_move = 1
	mob_biotypes = MOB_ROBOTIC|MOB_INORGANIC
	faction = list("duck")
	/// may not quack until this time
	COOLDOWN_DECLARE(wakka_cooldown)
	COOLDOWN_DECLARE(egg_cooldown)
	var/lay_egg_is = FALSE
	var/lights = TRUE
	var/loud_mode = TRUE
	var/amusing_song = 'sound/machines/amusingduck.ogg'
	var/amusing_song_volume = 65
	var/amusing_song_cooldown = 10 SECONDS
	var/amusing_song_chance = 20
	var/amusing_egg_drop = 'sound/machines/eggdrop.ogg'
	var/awful_mode = FALSE
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 6
	light_power = 2 // abusing (your retinas) duck
	light_color = "#ffffff"
	light_on = TRUE
	randpixel = 12
	can_ghost_into = TRUE
	bounty = 40

/mob/living/simple_animal/hostile/amusing_duck/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "quacks!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "quacks!", EMOTE_AUDIBLE)
	AddElement(/datum/element/mob_holder, "duck")

/mob/living/simple_animal/hostile/amusing_duck/OpenFire(atom/target)
	if(!client)
		return
	if(!COOLDOWN_FINISHED(src, egg_cooldown))
		var/timeleft = egg_cooldown - world.time
		to_chat(src, "Lay egg willl be true in [timeleft/10] seconds.")
		return
	blast_an_egg_at_someone(target)

/mob/living/simple_animal/hostile/amusing_duck/AttackingTarget()
	if(!client)
		return
	wakka_wakka(TRUE)

/mob/living/simple_animal/hostile/amusing_duck/handle_automated_action()
	. = ..()
	if(!. && !client)
		return
	wakka_wakka()
	blast_an_egg_at_someone()

/mob/living/simple_animal/hostile/amusing_duck/proc/wakka_wakka(playerdid)
	if(!loud_mode)
		return
	if(!COOLDOWN_FINISHED(src, wakka_cooldown))
		return
	COOLDOWN_START(src, wakka_cooldown, 10 SECONDS)
	var/message = pick("wacka", "quack","quacky","gaggle")
	say(message, only_overhead = TRUE)
	if(prob(amusing_song_chance) || playerdid)
		playsound(src, amusing_song, amusing_song_volume, awful_mode)

/mob/living/simple_animal/hostile/amusing_duck/proc/blast_an_egg_at_someone(mob/targ)
	if(lay_egg_is == FALSE && !targ)
		return
	if(!COOLDOWN_FINISHED(src, egg_cooldown))
		return
	if(prob(95) && !targ)
		return
	var/list/critters = hearers(7, src)
	var/mob/target = targ || safepick(critters)
	if(target)
		var/obj/item/degg = prob(50) ? new /obj/item/duck_egg(get_turf(src)) : new /obj/item/grenade/f13/dynamite/egg(get_turf(src))
		degg.throw_at(target, 100, 2)
		playsound(src, amusing_egg_drop, 75, awful_mode)
	COOLDOWN_START(src, egg_cooldown, (client ? 20 SECONDS : 1 MINUTES))

/mob/living/simple_animal/hostile/amusing_duck/multitool_act(mob/living/user, obj/item/I)
	openwindow(user)

/mob/living/simple_animal/hostile/amusing_duck/proc/openwindow(mob/user)
	. = TRUE
	var/list/dat = list() // todo: make this have the old awful bright white IE6 style that our grandpappies robusted to
	dat += "<TT><B>AMUSING DUCK</B></TT><BR>"
	dat += "<B>toy series with strong sense for playing</B><BR><BR>"
	dat += "<B><A href='?src=\ref[src];toggle=1'><u>[AIStatus != AI_OFF ? "ACTION" : "INACTION"]</u></A>! <A href='?src=\ref[src];loudmode=1'><u>[loud_mode ? "MUSIC" : "SILENCE"]</u></A>! <A href='?src=\ref[src];light=1'><u>[lights ? "LIGHT" : "DARKNESS"]</u></A>!</B><BR>"
	dat += "BUMP'N GO ACTION<BR>"
	dat += "LAY EGG IS: <A href='?src=\ref[src];egg=1'><u>[lay_egg_is ? "TRUE!!!" : "NOT TRUE!!!"]</u></A><BR><BR>"
	dat += "AS THE DUCK <A href='?src=\ref[src];wander=1'><u>[peaceful ? "WANDERING" : "ADVANCING"]</u></A>,FLICKING THE PLUMAGE AND YAWNING THE MOUTH GO WITH <A href='?src=\ref[src];loudmode=1'><u>[loud_mode ? "MUSIC" : "SILENCE"]</u></A> & <A href='?src=\ref[src];light=1'><u>[lights ? "LIGHT" : "DARKNESS"]</u></A>.<BR>"
	dat += "THE DUCK STOP,IT SWAYING TAIL THEN THE DUCK LAY AN EGG AS OPEN IT'S <A href='?src=\ref[src];explode=1'><u>BUTTOCKS</u></A>,<BR>GO WITH THE DUCK'S <A href='?src=\ref[src];awfulmode=1'><u>[awful_mode ? "WHINE" : "CALL"]</u></A>"

	winset(user, "ducky", "is-visible=1;focus=0;")
	var/datum/browser/popup = new(user, "ducky", "<HEAD><TITLE>Amusing Duck</TITLE></HEAD>", 320, 320)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "ducky", src)

/mob/living/simple_animal/hostile/amusing_duck/Topic(href, href_list)
	. = ..()
	var/refreshpls
	var/mob/user = usr
	if(href_list["egg"])
		toggle_lay_egg(user)
		refreshpls = TRUE
	if(href_list["wander"])
		toggle_peaceful(user)
		refreshpls = TRUE
	if(href_list["loudmode"])
		toggle_loud_mode(user)
		refreshpls = TRUE
	if(href_list["light"])
		toggle_lights(user)
		refreshpls = TRUE
	if(href_list["explode"])
		pop(user)
		refreshpls = TRUE
	if(href_list["toggle"])
		toggle_duck(user)
		update_icon()
		refreshpls = TRUE
	if(href_list["awfulmode"])
		toggle_awful_mode(user)
		refreshpls = TRUE
	if(refreshpls)
		openwindow(user)

/mob/living/simple_animal/hostile/amusing_duck/update_icon_state()
	. = ..()
	if(AIStatus == AI_OFF)
		icon_state = "duckbot_off"
		icon_living = "duckbot_off"
	else
		icon_state = "duckbot"
		icon_living = "duckbot"

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_awful_mode(mob/user)
	TOGGLE_VAR(awful_mode)
	if(awful_mode == TRUE)
		to_chat(user, "You turn on awful mode.")
		amusing_song_volume = 100
		amusing_song_chance = 100
	else
		to_chat(user, "You thankfully turn off awful mode.")
		amusing_song_volume = 65
		amusing_song_chance = 20
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_lay_egg(mob/user)
	TOGGLE_VAR(lay_egg_is)
	if(lay_egg_is == TRUE)
		to_chat(user, "You flip the switch on the duck's back to TRUE.")
	else
		to_chat(user, "You flip the switch on the duck's back to FALSE.")
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_peaceful(mob/user)
	TOGGLE_VAR(peaceful)
	if(peaceful == TRUE)
		to_chat(user, "You flip the switch on the duck's back to WANDERING.")
	else
		to_chat(user, "You flip the switch on the duck's back to ADVANCING.")
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_loud_mode(mob/user)
	TOGGLE_VAR(loud_mode)
	if(loud_mode == TRUE)
		to_chat(user, "You flip the switch on the duck's back to MUSIC.")
	else
		to_chat(user, "You flip the switch on the duck's back to SILENCE.")
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_lights(mob/user)
	TOGGLE_VAR(lights)
	set_light_on(lights)
	if(lights == TRUE)
		to_chat(user, "You flip the switch on the duck's back to LIGHT.")
	else
		to_chat(user, "You flip the switch on the duck's back to DARKNESS.")
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/toggle_duck(mob/user)
	if(AIStatus == AI_OFF)
		toggle_ai(AI_ON)
		to_chat(user, "You switch the duck on.")
	else
		toggle_ai(AI_OFF)
		to_chat(user, "You switch the duck off.")
	playsound(src, 'sound/machines/switch_on.ogg', 75)

/mob/living/simple_animal/hostile/amusing_duck/proc/pop()
	playsound(get_turf(src),death_sound, 200, ignore_walls = TRUE, vary = FALSE, frequency = SOUND_FREQ_NORMALIZED(sound_pitch, vary_pitches[1], vary_pitches[2]))
	gib(src)

/obj/item/duck_egg
	name = "cute plastic egg"
	desc = "A cute plastic egg! Oh boy, what could be inside? Also why is it so heavy?"
	icon = 'icons/mob/amusing_duck.dmi'
	icon_state = "easter_egg"
	throwforce = 15
	force = 25

/obj/item/duck_egg/attack_self(mob/user)
	. = ..()
	new /obj/effect/spawner/lootdrop/f13/trash(get_turf(user))
	to_chat(user, span_alert("Aw man! It's just full of trash!"))
	qdel(src)

/obj/item/grenade/f13/dynamite/egg
	name = "cute plastic egg"
	desc = "A cute plastic egg! Oh boy, what could be inside? Also why is it ticking?"
	icon = 'icons/mob/amusing_duck.dmi'
	icon_state = "easter_egg"

/obj/item/grenade/f13/dynamite/egg/preprime(mob/user, delayoverride, msg, volume)
	. = ..()
	to_chat(user, span_alert("Oh! It's actually a bomb!"))
