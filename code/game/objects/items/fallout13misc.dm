//Holodisks stuff
//Here we get the basic mechanics as coded by WB! Praise him and other Unknown coder for this.

/obj/item/weapon/holodisk
	name = "holodisk"
	desc = "A durable laser-readable storage device produced by Wattz Electronics, based on the tape holography technology, storing their information safely for extended periods of time."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "holodisk"
	inhand_icon_state = "holodisk"
	throwforce = 0
	hitsound = null
	w_class = 1.0
	throw_speed = 3
	throw_range = 7
	attack_verb = list("Played holodisk")
	var/busy = 0
	var/soundLength = 50
	var/soundFile = 'sound/f13music/mysterious_stranger.ogg'

/obj/item/weapon/holodisk/New()
		src.name = "holodisk #[rand(1,999)]"
		return ..()

/obj/item/weapon/holodisk/attack(mob/living/carbon/M as mob, mob/living/carbon/user as mob)
	src.playAudio(user)
	return ..()

/obj/item/weapon/holodisk/attack_self(mob/user as mob)
	src.playAudio(user)
	return

/obj/item/weapon/holodisk/proc/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			src.icon_state = initial(src.icon_state)
			src.busy = 0
	return

//Here we get any holodisks we want, using the basic mechanics.
/*  disabling holodisks until the sound files are replaced with much more reasonably-sized files.

/obj/item/weapon/holodisk/holodiskabducted
	soundFile =  'sound/f13items/holodisk_abducted.ogg'
	soundLength = 430

//One special holodisk can gib the listener or cripple someone else.

/obj/item/weapon/holodisk/holodiskcursed
	soundFile =  'sound/f13items/holodisk_cursed.ogg'
	soundLength = 230
	throwforce = 50 //It's funny counting you can't give objects hand to hand on TG, but have to throw or drop them instead.

/obj/item/weapon/holodisk/holodiskcursed/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			if(user) user.gib()
			src.icon_state = initial(src.icon_state)
			src.busy = 0
	return
/obj/item/weapon/holodisk/powerarmor
	desc = "A durable laser-readable storage device produced by Wattz Electronics, based on the tape holography technology, storing their information safely for extended periods of time.<br>This one is labeled, 'Power Armor For Dummies.'"
	soundFile =  'sound/f13items/holodisk_pa.ogg'
	soundLength = 30

/obj/item/weapon/holodisk/music1
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording one'"
	soundFile =  'sound/f13music/new_vegas_show_1.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/music2
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording two'"
	soundFile =  'sound/f13music/new_vegas_show_2.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/music3
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording three'"
	soundFile =  'sound/f13music/new_vegas_show_3.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/music4
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording four'"
	soundFile =  'sound/f13music/new_vegas_show_4.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/music5
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording five'"
	soundFile =  'sound/f13music/new_vegas_show_5.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/music6
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording six'"
	soundFile =  'sound/f13music/new_vegas_show_6.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/musicspecial1
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording special1'"
	soundFile =  'sound/f13music/new_vegas_show_bonus_1.ogg'
	soundLength = 186

/obj/item/weapon/holodisk/musicspecial2
	desc = "A durable laser-readable storage device. This one is labeled 'NV Recording special2 personal favourite'"
	soundFile =  'sound/f13music/new_vegas_show_bonus_2.ogg'
	soundLength = 246

/obj/item/weapon/holodisk/questfinished
	desc = "A durable laser-readable storage device. This one is labeled 'A curious sound'"
	soundFile =  'sound/f13music/quest.ogg'
	soundLength = 12

/obj/item/weapon/holodisk/clown
	desc = "A durable laser-readable storage device. This one is labeled 'Chick chicka boom'"
	soundFile =  'sound/ambience/clown.ogg'
	soundLength = 61
*/
/*
/obj/item/weapon/holodisk/powerarmor/playAudio(mob/user)
	if(!src.busy)
		src.busy = 1
		playsound(get_turf(src),src.soundFile,50)
		src.add_fingerprint(user)
		src.icon_state = "[initial(src.icon_state)]anim"
		spawn(src.soundLength)
			if(ishuman(user))
				var/mob/living/carbon/human/H = user
				var/datum/martial_art/patraining/F = new/datum/martial_art/patraining(null)
				F.teach(H)
				H << span_boldannounce("You have received the specialized training needed to move in any form of Power Armor.")
			src.icon_state = initial(src.icon_state)
			src.busy = 0
			visible_message(span_warning("[src] self-destructs!"))
			qdel(src)
	return
*/
//////////////////////////
//////////Flags//////////
/////////////////////////

GLOBAL_LIST_EMPTY(all_flags)

/obj/item/flag
	name = "empty flag"
	desc = "An empty post, just looking for someone to hang something up."
	w_class = WEIGHT_CLASS_HUGE
	layer = 4.1
	icon = 'icons/obj/flags.dmi'
	icon_state = "emptyflag"
	inhand_icon_state = "emptyflag"
	var/removing
	/// Number of sheets of leather to hang up a flag.
	var/flagcost = 3

/obj/item/flag/Initialize()
	. = ..()
	AddComponent(/datum/component/largetransparency, y_size = 1)
	init_flags()

/obj/item/flag/examine(mob/user)
	. = ..()
	. += span_notice("Use a sheet of leather to change the flag's appearance.")

/obj/item/flag/proc/init_flags()
	if(LAZYLEN(GLOB.all_flags))
		return
	for(var/flag in typesof(/obj/item/flag))
		var/obj/item/flag/F = flag
		GLOB.all_flags[initial(F.name)] = F

/obj/item/flag/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/sheet/leather))
		change_the_flag(user, I)
		return
	if(I.sharpness && icon_state != "emptyflag")
		unflag(user, I)
		return
	. = ..()

/obj/item/flag/proc/change_the_flag(mob/user, obj/item/stack/sheet/changeup)
	if(!user)
		return
	if(CHECK_BITFIELD(obj_flags, IN_USE))
		to_chat(user, span_alert("Someone's already messing with this!"))
		return
	if(!changeup.tool_use_check(user, flagcost))//This already sends a message to the client who fails the check
		return
	if(!LAZYLEN(GLOB.all_flags))
		init_flags()
	var/new_flag = input(user, "What kind of flag do you want to put up?", "Flagoning") as null|anything in GLOB.all_flags
	if(!new_flag)
		to_chat(user, span_alert("Never mind!"))
		return
	ENABLE_BITFIELD(obj_flags, IN_USE)
	to_chat(user, span_notice("You start putting up a [new_flag]..."))
	if(!do_after(user, 10 SECONDS, target = src, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE))
		DISABLE_BITFIELD(obj_flags, IN_USE)
		to_chat(user, span_alert("You were interrupted!"))
		return
	if(!changeup.use(used=flagcost,transfer=FALSE,check=TRUE))
		to_chat(user, span_alert("You don't have the required materials to make a flag. [flagcost] sheets of leather should do the trick!"))
		return FALSE
	DISABLE_BITFIELD(obj_flags, IN_USE)
	re_flag(GLOB.all_flags[new_flag])
	to_chat(user, span_notice("You tear down the old flag and put up a [new_flag]!"))

/obj/item/flag/proc/re_flag(new_flag)
	if(!ispath(new_flag, /obj/item/flag))
		return
	var/obj/item/flag/F = new_flag
	name = initial(F.name)
	desc = initial(F.desc)
	icon_state = initial(F.icon_state)
	inhand_icon_state = initial(F.inhand_icon_state)
	update_icon()

/obj/item/flag/proc/unflag(mob/user, obj/item/sharpthing)
	if(!user)
		return
	if(CHECK_BITFIELD(obj_flags, IN_USE))
		to_chat(user, span_alert("Someone's already messing with this!"))
		return
	if(!LAZYLEN(GLOB.all_flags))
		init_flags()
	ENABLE_BITFIELD(obj_flags, IN_USE)
	to_chat(user, span_notice("You begin to remove the flag."))
	if(!do_after(user, 10 SECONDS, target = src, allow_movement = TRUE, stay_close = TRUE, public_progbar = TRUE))
		DISABLE_BITFIELD(obj_flags, IN_USE)
		to_chat(user, span_alert("You were interrupted!"))
		return
	DISABLE_BITFIELD(obj_flags, IN_USE)
	re_flag(/obj/item/flag)
	to_chat(user, span_notice("You tear down the flag!"))


/obj/item/flag/ncr
	name = "Two Bear flag"
	desc = "A flag with a two headed bear, the symbol of the Chibeara Clan. Or something."
	icon_state = "ncrflag"
	inhand_icon_state = "ncrflag"

/obj/item/flag/bos
	name = "Flying Sword Magnet flag"
	desc = "A red and black flag with a sword surrounded in magnets and wings, the symbol of the Fridgeknife clan. Or something."
	icon_state = "bosflag"
	inhand_icon_state = "bosflag"

/obj/item/flag/legion
	name = "Fat Unicorn flag"
	desc = "A flag with a fat unicorn, the symbol of the Magiquestrian Pranceliance. Or something."
	icon_state = "legionflag"
	inhand_icon_state = "legionflag"

/obj/item/flag/oasis
	name = "Crossflower flag"
	desc = "A flag depicting a stylised pink flower on a green background, the symbol of the Feverblossom Family. Or something."
	icon_state = "oasisflag"
	inhand_icon_state = "oasisflag"

/obj/item/flag/followers
	name = "Clinic flag"
	desc = "A white flag with a turqoise cross on it representing the clinic doctors."
	icon_state = "followersflag"
	inhand_icon_state = "followersflag"

/// Locust flag but renamed to bandit.

/obj/item/flag/locust
	name = "Grody Skull flag"
	desc = "A flag with a skull, the symbol of the Grody Skull Gang. Or something."
	icon_state = "locustflag"
	inhand_icon_state = "locustflag"

/// Gunner flag but renamed to Outlaw.

/obj/item/flag/outlaw
	name = "Knife Skull flag"
	desc = "A ragged flag with a skull with a knife through its face, the symbol of the Peeper Pokers. Or something."
	icon_state = "gunnerflag"
	inhand_icon_state = "gunnerflag"

/obj/item/flag/yuma
	name = "Yuma banner"
	desc = "A banner depicting three rivers meeting at its center, overlaid with an ear of corn."
	icon_state = "cornflag"
	inhand_icon_state = "cornflag"

/obj/item/flag/vtcc
	name = "Liney-Dot flag"
	desc = "A flag with a white circle and lines on top of red and white blocks, the symbol of the Stretched Out Asterisk Alliance. Or something"
	icon_state = "vtccflag"
	inhand_icon_state = "vtccflag"

/obj/item/flag/vtcc/highvhills
	name = "Tall Liney-Dot flag"
	desc = "A flag with the Liney-Dot logo turned on its side and stretched out, the symbol of the Tall Terriers Troupe. Or something."
	icon_state = "hvhflag"
	inhand_icon_state = "vtccflag"

/obj/item/flag/khan
	name = "Horny Marauder flag"
	desc = "A flag with a moustached skull wearing a helmet with horns on, the symbol of the Angry Andies. Or something"
	icon_state = "khanflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/uk
	name = "Red Asterisk flag"
	desc = "A flag with a red asterisk overlaid on blue and white blocks, the symbol of the Criss Cross Crew. Or something."
	icon_state = "ukflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/straya
	name = "Mini Blue Asterisk flag"
	desc = "A flag with a tiny red asterisk in the corner of a blue field with stars on, the symbol of the Criss Cross Correctional Colony. Or something."
	icon_state = "strayaflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/raj
	name = "Mini Red Asterisk-and-Circle flag"
	desc = "A flag with a tiny red asterisk in the corner of a red field with a yellow circle on, the symbol of the Criss Cross Circle Court. Or something."
	icon_state = "rajflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/canada
	name = "Mini Red Asterisk-and-Leaf flag"
	desc = "A flag with a tiny red asterisk in the corner of a red field with a white leaf on, the symbol of the Criss Cross Cultivators. Or something."
	icon_state = "rajflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/japan
	name = "Red Dot flag"
	desc = "A flag with a red circle on a white background, the symbol of the Lazor Sytez. Or something."
	icon_state = "japanflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/germany
	name = "Black Red and Yellow flag"
	desc = "A flag with black, red, and yellow bars, the symbol of the Rotten Neapolitans. Or something."
	icon_state = "germanyflag"
	inhand_icon_state = "khanflag"

/obj/item/flag/usa
	name = "Red White and Blue flag"
	desc = "A flag with red and white stripes and a blue square full of stars, the symbol of the Pajama Pouncers. Or something."
	icon_state = "usaflag"
	inhand_icon_state = "khanflag"


/*   OLDER things that isnt the flags in a way, and how to use them in the upper things.
				var/list/choices = list("NCR", "Legion", "Yuma", "BOS", "Followers", "Great Khans")
					if(FACTION_NCR)
						name = "NCR flag"
						desc = "A flag with a two headed bear, the symbol of the New California Republic."
						icon_state = "ncrflag"
						inhand_icon_state = "ncrflag"
						faction = "NCR"
					if(FACTION_LEGION)
						name = "Larper flag"
						desc = "A flag with a golden bull, the symbol of Caesar's Legion."
						icon_state = "legionflag"
						inhand_icon_state = "legionflag"
						faction = FACTION_LEGION
					if("Yuma")
						name = "Yuma flag"
						desc = "A banner depicting three rivers meeting at its center, overlaid with an ear of corn."
						icon_state = "cornflag"
						inhand_icon_state = "cornflag"
						faction = FACTION_OASIS

					if("Great Khans")
						name = "Great Khans flag"
						desc = "A flag worn and weathered from a long cherished history. A decorated smiling skull smiles mockingly upon those who challenge it."
						icon_state = "khanflag"
						inhand_icon_state = "khanflag"
						faction = "Great Khans"
*/

////////Viper stuff////// subject to change, but this way was simple
/obj/item/viper_venom
	name = "Viper venom"
	desc = "A container of special Mojave viper venom, prepared by a skilled Viper shaman." //only used for viper spear recipe
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle7"
	throwforce = 2
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("bashed")

/obj/item/warpaint_bowl
	name = "warpaint bowl"
	desc = "A small ceramic bowl, used for the mixing of warpaints by a skilled shaman."
	icon = 'icons/mob/tribe_warpaint.dmi'
	icon_state = "wp_bowl"
	/// List of choosable warpaint icon states.
	var/static/list/choices = list(
		"cazador", "claw", "facestripe",
		"armwrap", "legwrap", "lizard",
		"priestess", "stripe", "spider",
		"prongs", "tears", "thorns",
		"whitestripe")
	/// Currently selected warpaint.
	var/paint_type = null
	/// Currently selected warpaint color.
	var/paint_color = "FFFFFF"

/obj/item/warpaint_bowl/attack_self(mob/user)
	. = ..()
	var/chosen_paint = input(user, "Pick a warpaint style.", "Tribal warpaint", paint_type) as null|anything in choices
	if(!chosen_paint)
		return
	paint_type = chosen_paint

	var/chosen_color = input(user, "Pick a warpaint color.", "Tribal warpaint", paint_color) as null|color
	if(!chosen_color)
		return
	paint_color = chosen_color

/obj/item/warpaint_bowl/attack(mob/living/M, mob/living/user, attackchain_flags, damage_multiplier)
	if(!paint_type || !paint_color)
		to_chat(user, span_warning("You need to select a style first!"))
		return
	if(!user.Adjacent(M) || !ishuman(M))
		return ..()
	var/mob/living/carbon/human/H = M
	if((H.warpaint == paint_type) && (H.warpaint_color == paint_color))
		to_chat(user, span_warning("[H] is already painted with this style!"))
		return

	user.visible_message(span_notice("[user] starts painting [H] with [src]."), span_notice("You start painting [H] with [src]."))
	if(!do_mob(user, H, 10 SECONDS))
		return
	user.visible_message(span_notice("[user] applies warpaint onto [H]."), span_notice("You apply warpaint onto [H]."))

	H.warpaint = paint_type
	H.warpaint_color = paint_color
	H.update_body()
