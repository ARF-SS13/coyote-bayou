//In this document: SMGs, Carbines, Rifles, Assault rifles, Machineguns and Misc.
/*Current templates
Force 12 for stuff without a stock or thats clumsy, 15 for most, 20 for those with a nice stock to bash with and that arent super heavy.
Slowdown 0.2 for smg, 0.5 for most, 2 for machineguns
Burst 2 as base, only special guns get more and has to be rare or balance other ways with current system.
*/

/obj/item/gun/ballistic/automatic
	name = "automatic gun template"
	desc = "should not be here, bugreport."
	slowdown = 0.5
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = 0
	force = 15
	burst_size = 2
	burst_shot_delay = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	var/automatic_burst_overlay = TRUE
	var/semi_auto = FALSE
	var/auto_eject = 0
	var/auto_eject_sound = null
	var/alarmed = 0
	var/select = 1
	can_suppress = FALSE
	equipsound = 'sound/f13weapons/equipsounds/riflequip.ogg'

/obj/item/gun/ballistic/automatic/attackby(obj/item/I, mob/user, params)
	if(user.a_intent == INTENT_HARM)
		return ..()
	else if(istype(I, /obj/item/attachments/auto_sear))
		var/obj/item/attachments/auto_sear/A = I
		if(!auto_sear && can_automatic && semi_auto)
			if(!user.transferItemToLoc(I, src))
				return
			auto_sear = A
			src.desc += " It has an automatic sear installed."
			src.burst_size += 1
			src.automatic_burst_overlay = TRUE
			src.semi_auto = FALSE
			to_chat(user, "<span class='notice'>You attach \the [A] to \the [src].</span>")
			update_icon()
	else
		return ..()

/obj/item/gun/ballistic/automatic/update_overlays()
	. = ..()
	if(automatic_burst_overlay)
		if(!select)
			. += ("[initial(icon_state)]semi")
		if(select == 1)
			. += "[initial(icon_state)]burst"

/obj/item/gun/ballistic/automatic/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(A, /obj/item/ammo_box/magazine))
		var/obj/item/ammo_box/magazine/AM = A
		if(istype(AM, mag_type))
			var/obj/item/ammo_box/magazine/oldmag = magazine
			if(user.transferItemToLoc(AM, src))
				magazine = AM
				if(oldmag)
					to_chat(user, "<span class='notice'>You perform a tactical reload on \the [src], replacing the magazine.</span>")
					oldmag.forceMove(get_turf(src.loc))
					oldmag.update_icon()
				else
					to_chat(user, "<span class='notice'>You insert the magazine into \the [src].</span>")

				playsound(user, 'sound/weapons/autoguninsert.ogg', 60, 1)
				chamber_round()
				A.update_icon()
				update_icon()
				return 1
			else
				to_chat(user, "<span class='warning'>You cannot seem to get \the [src] out of your hands!</span>")

/obj/item/gun/ballistic/automatic/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/toggle_firemode))
		burst_select()
	else
		return ..()

/obj/item/gun/ballistic/automatic/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	if(semi_auto)
		to_chat(user, "<span class = 'notice'>This weapon is semi-automatic only.</span>")
		return
	else
		select = !select
		if(!select)
			disable_burst()
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
		else
			enable_burst()
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		playsound(user, 'sound/weapons/empty.ogg', 100, 1)
		update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/gun/ballistic/automatic/proc/enable_burst()
	burst_size = initial(burst_size)
	if(auto_sear)
		burst_size = 1 + initial(burst_size)
	if(burst_improvement)
		burst_size = 1 + initial(burst_size)
	if(burst_improvement && auto_sear)
		burst_size = 2 + initial(burst_size)

/obj/item/gun/ballistic/automatic/proc/disable_burst()
	burst_size = 1

/obj/item/gun/ballistic/automatic/can_shoot()
	return get_ammo()

/obj/item/gun/ballistic/automatic/proc/empty_alarm()
	if(!chambered && !get_ammo() && !alarmed)
		playsound(src.loc, 'sound/weapons/smg_empty_alarm.ogg', 40, 1)
		update_icon()
		alarmed = 1
	return

/obj/item/gun/ballistic/automatic/afterattack(atom/target, mob/living/user)
	..()
	if(auto_eject && magazine && magazine.stored_ammo && !magazine.stored_ammo.len && !chambered)
		magazine.dropped()
		user.visible_message(
			"[magazine] falls out and clatters on the floor!",
			"<span class='notice'>[magazine] falls out and clatters on the floor!</span>"
		)
		if(auto_eject_sound)
			playsound(user, auto_eject_sound, 40, 1)
		magazine.forceMove(get_turf(src.loc))
		magazine.update_icon()
		magazine = null
		update_icon()



///////////////////
//SUBMACHINE GUNS//
///////////////////


//Rockwell gun. 9mm
/obj/item/gun/ballistic/automatic/sten
	name = "the Rockwell gun"
	desc = "Post-war submachine gun in 9mm, based on old schematics by T.G. Rockwell for home-made weapons if under enemy occupation. Basically a toploaded sten gun with a pistol grip, allowing makeshift magazines without a spring."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "rockwell"
	item_state = "rockwell"
	slowdown = 0.2
	w_class = WEIGHT_CLASS_NORMAL
	force = 10
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	burst_shot_delay = 2
	fire_delay = 1
	spread = 11
	extra_damage = -2
	can_attachments = TRUE


//American 180. .22 LR
/obj/item/gun/ballistic/automatic/smg22
	name = "American 180"
	desc = "An integrally suppressed submachinegun chambered in the common .22 long rifle. Top loaded drum magazine."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "smg22"
	item_state = "shotgun"
	slowdown = 0.3
	slot_flags = 0
	force = 10
	mag_type = /obj/item/ammo_box/magazine/m22smg
	fire_sound = 'sound/f13weapons/american180.ogg'
	can_unsuppress = FALSE
	burst_shot_delay = 1
	suppressed = 1


//Greasegun. .45 ACP
/obj/item/gun/ballistic/automatic/greasegun
	name = "M3A1 Grease Gun"
	desc = "An inexpensive submachine gun chambered in .45 ACP. Slow fire rate allows the operator to conserve ammunition in controllable bursts."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "grease_gun"
	item_state = "smg9mm"
	slowdown = 0.2
	mag_type = /obj/item/ammo_box/magazine/greasegun
	fire_sound = 'sound/f13weapons/greasegun.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	force = 12
	fire_delay = 2.5
	burst_shot_delay = 3
	can_attachments = TRUE
	spread = 12
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 19


//10mm SMG
/obj/item/gun/ballistic/automatic/smg10mm
	name = "10mm submachine gun"
	desc = "One of the most common personal-defense weapons of the Great War, a sturdy and reliable open-bolt 10mm submachine gun."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "smg10mm"
	item_state = "smg10mm"
	slowdown = 0.2
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM //You should be able to dual-wield these.
	force = 12
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv
	init_mag_type = /obj/item/ammo_box/magazine/m10mm_adv/ext
	fire_delay = 5
	burst_shot_delay = 2.5
	can_attachments = TRUE
	spread = 14
	suppressor_state = "10mm_suppressor" //activate if sprited 
	suppressor_x_offset = 30
	suppressor_y_offset = 16
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

//UZI. 9mm
/obj/item/gun/ballistic/automatic/mini_uzi
	name = "Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "uzi"
	item_state = "uzi"
	slowdown = 0.2
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	force = 12
	fire_delay = 4
	burst_shot_delay = 2
	can_suppress = TRUE
	can_attachments = TRUE
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21
	spread = 10
	suppressor_state = "uzi_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16


//Carl Gustaf. 10mm. Two handed firing, so should be a level above the 1h SMGs.
/obj/item/gun/ballistic/automatic/cg45
	name = "Carl Gustaf 10mm"
	desc = "Post-war submachine gun made in workshops based on a simple old design. Chambered in 10mm."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "cg45"
	item_state = "cg45"
	slowdown = 0.2
	mag_type = /obj/item/ammo_box/magazine/cg45
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	force = 12
	fire_delay = 4
	burst_shot_delay = 2.5
	spread = 9
	can_attachments = TRUE


//Ppsh-41. 9mm. Seems weird this is so common, ww2 soviet stuff should be a rare drop if anything. Two handed firing, should be better than 1h SMGs.
/obj/item/gun/ballistic/automatic/pps
	name = "Ppsh-41"
	desc = "An extremely fast firing, inaccurate submachine gun from World War 2. Low muzzle velocity. Uses 9mm rounds."
	icon_state = "pps"
	slowdown = 0.3
	mag_type = /obj/item/ammo_box/magazine/pps9mm
	burst_size = 3
	fire_delay = 6
	burst_shot_delay = 2
	can_attachments = TRUE
	extra_damage = -4
	can_scope = TRUE
	scope_state = "AEP7_scope"
	scope_x_offset = 9
	scope_y_offset = 21
	spread = 20


//MP-5. Silenced 9mm. Kinda boring.
/obj/item/gun/ballistic/automatic/mp5
	name = "MP-5 SD"
	desc = "An integrally suppressed sub machine chambered in 9mm."
	icon_state = "mp5"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/uzim9mm
	spread = 6
	burst_shot_delay = 1
	suppressed = 1
	can_attachments = TRUE
	can_suppress = FALSE
	can_unsuppress = FALSE
	fire_sound = 'sound/weapons/Gunshot_silenced.ogg'


//Tommygun. .45
/obj/item/gun/ballistic/automatic/tommygun
	name = "Thompson SMG"
	desc = "Based on the classic 'Chicago Typewriter'."
	icon_state = "tommygun"
	item_state = "shotgun"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/tommygunm45
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	burst_size = 3
	burst_shot_delay = 3
	fire_delay = 5



////////////
//CARBINES//
////////////


//Auto-pipe rifle. The ultimate in hobo firearms. .357 autofire, inaccurate as hell, slow RoF.
/obj/item/gun/ballistic/automatic/autopipe
	name = "Auto-pipe rifle (.357)"
	desc = "A belt fed pipe rifle held together with duct tape. Highly inaccurate. What could go wrong."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "autopipe"
	item_state = "autopipe"
	mag_type = /obj/item/ammo_box/magazine/autopipe
	burst_size = 4
	fire_delay = 30
	burst_shot_delay = 3
	spread = 24
	fire_sound = 'sound/weapons/Gunshot.ogg'


//M1 Carbine - 10mm
/obj/item/gun/ballistic/automatic/m1carbine
	name = "m1 carbine"
	desc = "The M1 Carbine is a renowned carbine that has been in service since WW2. Recently retired, these guns were transferred to National Guard Armouries and rechambered to 10mm."
	icon_state = "m1carbine"
	item_state = "rifle"
	burst_size = 1
	fire_delay = 2
	mag_type = /obj/item/ammo_box/magazine/m10mm_adv
	extra_damage = 4
	extra_penetration = 0.08
	automatic_burst_overlay = FALSE
	can_bayonet = TRUE
	bayonet_state = "lasmusket"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "lasmusket_scope"
	scope_x_offset = 5
	scope_y_offset = 14
	can_attachments = TRUE
	can_automatic = TRUE
	semi_auto = TRUE
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'

/obj/item/gun/ballistic/automatic/m1carbine/compact
	name = "m1a1 carbine"
	desc = "The M1A1 carbine is an improvement of the original, with this particular model having a folding stock allowing for greater mobility. Chambered in 10mm."
	icon_state = "m1a1carbine"
	var/stock = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	spread = 5

/obj/item/gun/ballistic/automatic/m1carbine/compact/AltClick(mob/user)
	if(!istype(user) || !user.canUseTopic(src, BE_CLOSE, ismonkey(user)))
		return
	toggle_stock(user)

/obj/item/gun/ballistic/automatic/m1carbine/compact/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to toggle the stock.</span>"

/obj/item/gun/ballistic/automatic/m1carbine/compact/proc/toggle_stock(mob/living/user)
	stock = !stock
	if(stock)
		w_class = WEIGHT_CLASS_BULKY
		to_chat(user, "You unfold the stock.")
		spread = 5
	else
		w_class = WEIGHT_CLASS_NORMAL
		to_chat(user, "You fold the stock.")
		spread = 20
	update_icon()

/obj/item/gun/ballistic/automatic/m1carbine/compact/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"][stock ? "" : "-f"]"


//Commando carbine, .45 ACP
/obj/item/gun/ballistic/automatic/commando
	name = "commando carbine"
	desc = "An integrally suppressed bolt action carbine, perfect for quiet varmint hunting. Uses .45 pistol magazines."
	icon_state = "delisle"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/greasegun
	extra_damage = 3
	extra_penetration = 0.06
	fire_delay = 4.5
	burst_size = 1
	can_unsuppress = FALSE
	suppressed = 1
	can_attachments = TRUE
	can_automatic = TRUE
	automatic_burst_overlay = FALSE
	can_scope = TRUE
	scope_state = "lasmusket_scope"
	scope_x_offset = 6
	scope_y_offset = 14
	semi_auto = TRUE
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'



//////////
//RIFLES//
//////////


//Varmint rifle. 5.56.
/obj/item/gun/ballistic/automatic/varmint
	name = "varmint rifle"
	desc = "A low powered 5.56, easy to use rifle."
	icon_state = "varmint_rifle"
	item_state = "varmintrifle"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 8.5
	burst_size = 1
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	can_attachments = TRUE
	can_bayonet = FALSE
	can_scope = TRUE
	scope_state = "rifle_scope"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'


//Ratslayer. Varmint rifle with more crap on it.
/obj/item/gun/ballistic/automatic/varmint/ratslayer
	name = "Ratslayer"
	desc = "A modified varmint rifle with better stopping power, a scope, and suppressor. Oh, don't forget the sick paint job."
	icon_state = "rat_slayer"
	item_state = "ratslayer"
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	suppressed = 1
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
	suppressed = 1
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'


//Service rifle. 5.56mm.
/obj/item/gun/ballistic/automatic/service
	name = "service rifle"
	desc = "A 5.56x45 semi-automatic service rifle manufactured by the NCR and issued to all combat personnel."
	icon_state = "service_rifle"
	item_state = "servicerifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 5
	burst_size = 1
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_bayonet = TRUE
	bayonet_state = "lasmusket"
	can_attachments = TRUE
	knife_x_offset = 22
	knife_y_offset = 21
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 28
	suppressor_y_offset = 30
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'


//R82 Heavy service rifle. 5.56
/obj/item/gun/ballistic/automatic/service/r82
	name = "R82 heavy service rifle"
	desc = "The assault rifle variant of the R84, based off the pre-war FN FNC. Issued to high-ranking troopers and specialized units. Chambered in 5.56."
	icon_state = "R82"
	item_state = "R84"
	spread = 3
	fire_delay = 2
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 28


//Scout carbine. 5.56, slightly worse damage and faster rate of fire than normal service. 
/obj/item/gun/ballistic/automatic/service/carbine
	name = "scout carbine"
	desc = "A cut down version of the standard-issue service rifle tapped with mounting holes for a scope. Shorter barrel, lower muzzle velocity."
	icon_state = "scout_carbine"
	extra_damage = -4
	fire_delay = 4
	can_scope = TRUE
	scope_state = "smallrifle_scope"
	scope_x_offset = 4
	scope_y_offset = 15
	suppressor_x_offset = 26
	suppressor_y_offset = 28


//Marksman carbine. 5.56.
/obj/item/gun/ballistic/automatic/marksman
	name = "marksman carbine"
	desc = "A marksman carbine built off the AR platform chambered in 5.56x45. Seen heavy usage in pre-war conflicts. This particular model is a civilian version and is semi-auto only."
	icon_state = "marksman_rifle"
	item_state = "marksman"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 4
	burst_size = 1
	extra_damage = 2
	can_attachments = TRUE
	can_automatic = TRUE
	semi_auto = TRUE
	automatic_burst_overlay = FALSE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_bayonet = TRUE
	bayonet_state = "rifles"
	knife_x_offset = 22
	knife_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "suppressor"
	suppressor_x_offset = 31
	suppressor_y_offset = 15
	fire_sound = 'sound/f13weapons/marksman_rifle.ogg'


//Colt Rangemaster. 7.62.
/obj/item/gun/ballistic/automatic/rangemaster
	name = "Colt Rangemaster"
	desc = "A Colt Rangemaster semi-automatic rifle, chambered for 7.62x51. Single-shot only."
	icon_state = "rangemaster"
	item_state = "308"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/m762
	burst_size = 1
	fire_delay = 4.5
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_attachments = TRUE
	can_scope = TRUE
	can_bayonet = TRUE
	bayonet_state = "lasmusket"
	knife_x_offset = 24
	knife_y_offset = 21
	scope_state = "rifle_scope"
	scope_x_offset = 4
	scope_y_offset = 11
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 27
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'


// Enfield SLR. 7.62.
/obj/item/gun/ballistic/automatic/slr
	name = "Enfield SLR"
	desc = "A self-loading rifle in 7.62mm NATO. Semi-auto only."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "slr"
	item_state = "slr"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/m762
	burst_size = 1
	fire_delay = 4.5
	automatic_burst_overlay = FALSE
	semi_auto = TRUE
	can_attachments = TRUE
	can_scope = TRUE
	can_bayonet = TRUE
	bayonet_state = "lasmusket"
	knife_x_offset = 24
	knife_y_offset = 21
	scope_state = "rifle_scope"
	scope_x_offset = 4
	scope_y_offset = 11
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'


//M1 Garand. .308.
/obj/item/gun/ballistic/automatic/m1garand
	name = "battle rifle"
	desc = "The WWII American Classic. Still has that satisfiying ping."
	icon_state = "m1garand"
	item_state = "rifle"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/garand308
	fire_delay = 4
	burst_size = 1
	en_bloc = 1
	auto_eject = 1
	auto_eject_sound = 'sound/f13weapons/garand_ping.ogg'
	semi_auto = TRUE
	can_bayonet = TRUE
	bayonet_state = "lasmusket"
	knife_x_offset = 22
	knife_y_offset = 21
	can_scope = TRUE
	scope_state = "rifle_scope"
	scope_x_offset = 5
	scope_y_offset = 14
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/m1garand/update_icon()
	..()
	icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/automatic/m1garand/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return

//Old Glory. Better M1 Garand. .308.
/obj/item/gun/ballistic/automatic/m1garand/oldglory
	name = "Old Glory"
	desc = "This Machine kills communists!"
	icon_state = "oldglory"
	extra_damage = 10

//Republics Pride. Better M1 Garand. 7.62.
/obj/item/gun/ballistic/automatic/m1garand/republicspride
	name = "Republic's Pride"
	desc = "A well-tuned scoped M1C rifle crafted by master gunsmith from the Gunrunners. Chambered in 7.62x51."
	icon_state = "republics_pride"
	item_state = "scoped308"
	extra_damage = 8
	extra_penetration = 0.1
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE


//SKS. .308
/obj/item/gun/ballistic/automatic/m1garand/sks
	name = "SKS"
	desc = "Refurbished old rifle. .308, semi-auto only, internal magazine."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "sks"
	item_state = "sks"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/sks
	fire_delay = 6
	extra_penetration = 0.1
	knife_x_offset = 24
	knife_y_offset = 21
	scope_x_offset = 4
	scope_y_offset = 11
	can_suppress = FALSE
	auto_eject_sound = 'sound/weapons/magout.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'


//DKS 501 sniper rifle. .30
/obj/item/gun/ballistic/automatic/marksman/sniper
	name = "sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester.  With a light polymer body, it's suited for long treks through the desert."
	w_class = WEIGHT_CLASS_NORMAL
	icon_state = "sniper_rifle"
	item_state = "sniper_rifle"
	mag_type = /obj/item/ammo_box/magazine/w308
	fire_delay = 10
	burst_size = 1
	extra_speed = 5000
	semi_auto = TRUE
	can_automatic = FALSE
	can_bayonet = FALSE
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/automatic/marksman/sniper/gold
	name = "golden sniper rifle"
	desc = "A DKS 501, chambered in .308 Winchester. This one has a gold trim and the words 'Old Cassius' engraved into the stock."
	icon_state = "gold_sniper"
	item_state = "gold_sniper"


//Infiltrator. 5.56
/obj/item/gun/ballistic/automatic/assault_rifle/infiltrator
	name = "infiltrator"
	desc = "A customized R91 assault rifle, with an integrated suppressor, cut down stock and polymer furniture."
	icon_state = "infiltrator"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	spread = 1
	fire_delay = 3
	burst_shot_delay = 2
	can_suppress = FALSE
	can_unsuppress = FALSE
	suppressed = 1
	can_bayonet = FALSE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'



//////////////////
//ASSAULT RIFLES//
//////////////////


//R91 assault rifle. Auto fire 5.56
/obj/item/gun/ballistic/automatic/assault_rifle
	name = "r91 assault rifle"
	desc = "A standard R91 assault rifle, out of use around the time of the Great War."
	icon_state = "assault_rifle"
	item_state = "fnfal"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 4
	burst_shot_delay = 3
	spread = 8
	can_attachments = TRUE
	can_bayonet = TRUE
	bayonet_state = "rifles"
	knife_x_offset = 23
	knife_y_offset = 11
	can_suppress = TRUE
	suppressor_x_offset = 32
	suppressor_y_offset = 15
	suppressor_state = "ar_suppressor"


//Bozar. Autofire 5.56
/obj/item/gun/ballistic/automatic/bozar
	name = "Bozar"
	desc = "The ultimate refinement of the sniper's art, the Bozar is a scoped, accurate, light machine gun that will make nice big holes in your enemy. Uses 5.56."
	icon_state = "bozar"
	item_state = "sniper"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	burst_size = 3
	fire_delay = 3
	can_attachments = TRUE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
	fire_sound = 'sound/f13weapons/bozar_fire.ogg'

//Type 93 Chinese rifle. Autofire 5.56
/obj/item/gun/ballistic/automatic/type93
	name = "type 93 assault rifle"
	desc = "The Type 93 Chinese assault rifle was designed and manufactured by a Chinese industrial conglomerate for the People's Liberation Army during the Resource Wars, for the purpose of equipping the Chinese infiltrators and American fifth-columnists. Chambered in 5.56x45."
	icon_state = "type93"
	item_state = "handmade_rifle"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 3
	spread = 10
	extra_damage = 2
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 27
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/type93/worn
	name = "\improper Worn Type 56"
	desc = "The original Type 56 was a copy of the Soviet AKM, and this is a copy of that copy produced in a garage. The bore is shot to hell, the threading is destroyed, but atleast it works."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "chinese"
	item_state = "handmade_rifle"
	fire_delay = 4
	spread = 13
	extra_damage = -3
	can_suppress = FALSE

//CAR-15 rifle. Autofire 5.56
/obj/item/gun/ballistic/automatic/assault_carbine
	name = "assault carbine"
	desc = "A CAR-15 assault rifle, designated as the 'R8' in the U.S. Army. A variant of the R84 with increased rate of fire and a matte black exterior."
	icon_state = "assault_carbine"
	item_state = "assault_carbine"
	slot_flags = 0
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 3
	burst_shot_delay = 2.0
	spread = 16
	can_attachments = TRUE
	can_scope = TRUE
	scope_state = "smallrifle_scope"
	scope_x_offset = 4
	scope_y_offset = 15
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 26
	suppressor_y_offset = 28
	fire_sound = 'sound/f13weapons/assault_carbine.ogg'


//M16. Autofire 5.56
/obj/item/gun/ballistic/automatic/service/automatic
	name = "m16a1"
	desc = "The pre-war predecessor of the NCR service rifle. Select fire with three round burst. Chambered in 5.56."
	icon_state = "m16a1"
	fire_delay = 1
	burst_size = 3
	automatic_burst_overlay = TRUE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	semi_auto = FALSE


//FN-FAL. Autofire 7.62
/obj/item/gun/ballistic/automatic/fnfal
	name = "FN FAL"
	desc = "This rifle has been more widely used by armed forces than any other rifle in history. It's a reliable assault weapon for any terrain or tactical situation."
	icon_state = "fnfal"
	item_state = "fnfal"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/m762
	spread = 10
	fire_delay = 3
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'



////////////////
//MACHINE-GUNS//
////////////////


//R84 Light machinegun 5.56.
/obj/item/gun/ballistic/automatic/r84
	name = "R84 LMG"
	desc = "A light machinegun using 60 round belts fed from an ammobox, its one of the few heavy weapons designs NCR has produced."
	icon_state = "R84"
	item_state = "R84"
	slowdown = 1
	mag_type = /obj/item/ammo_box/magazine/lmg
	burst_size = 1
	fire_delay = 3
	burst_shot_delay = 3
	spread = 7
	randomspread = 1
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'

/obj/item/gun/ballistic/automatic/r84/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select += 1
			burst_size = 3
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(2)
			select = 0
			burst_size = 1
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return


//LSW squad support weapon. 5.56.
/obj/item/gun/ballistic/automatic/lsw
	name = "LSW (Light Support Weapon)"
	desc = "This squad-level support weapon has a bullpup design. The bullpup design makes it difficult to use while lying down. Because of this it was remanded to National Guard units. It, however, earned a reputation as a reliable weapon that packs a lot of punch for its size."
	icon_state = "lsw"
	item_state = "lsw"
	slowdown = 1
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 5
	burst_shot_delay = 2
	spread = 15
	spawnwithmagazine = TRUE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_attachments = TRUE
	can_scope = FALSE


//M1919 Machinegun. 7.62.
/obj/item/gun/ballistic/automatic/m1919
	name = "Browning M1919"
	desc = "An old pre-war machine gun used in service by the US Military around the time of the war. Rechambered in 7.62x51."
	icon_state = "M38"
	item_state = "M38"
	slot_flags = 0
	slowdown = 2
	mag_type = /obj/item/ammo_box/magazine/mm762
	fire_sound = 'sound/f13weapons/assaultrifle_fire.ogg'
	can_suppress = FALSE
	burst_size = 1
	fire_delay = 3
	spread = 20
	var/cover_open = FALSE

/obj/item/gun/ballistic/automatic/m1919/update_icon()
	icon_state = "M38[cover_open ? "open" : "closed"][magazine ? CEILING(get_ammo(0)/20, 1)*20 : "-empty"]"
	item_state = "M38[cover_open ? "open" : "closed"][magazine ? "mag" : "nomag"]"

/obj/item/gun/ballistic/automatic/m1919/examine(mob/user)
	. = ..()
	if(cover_open && magazine)
		. += "<span class='notice'>It seems like you could use an <b>empty hand</b> to remove the magazine.</span>"

/obj/item/gun/ballistic/automatic/m1919/attack_self(mob/user)
	cover_open = !cover_open
	to_chat(user, "<span class='notice'>You [cover_open ? "open" : "close"] [src]'s cover.</span>")
	if(cover_open)
		playsound(user, 'sound/weapons/sawopen.ogg', 60, 1)
	else
		playsound(user, 'sound/weapons/sawclose.ogg', 60, 1)
	update_icon()

/obj/item/gun/ballistic/automatic/m1919/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params) //what I tried to do here is just add a check to see if the cover is open or not and add an icon_state change because I can't figure out how c-20rs do it with overlays
	if(cover_open)
		to_chat(user, "<span class='warning'>[src]'s cover is open! Close it before firing!</span>")
	else
		. = ..()
		update_icon()

/obj/item/gun/ballistic/automatic/m1919/on_attack_hand(mob/user, act_intent = user.a_intent, unarmed_attack_flags)
	if(loc != user)
		..()
		return	//let them pick it up
	if(!cover_open || (cover_open && !magazine))
		..()
	else if(cover_open && magazine)
		//drop the mag
		magazine.update_icon()
		magazine.forceMove(drop_location())
		user.put_in_hands(magazine)
		magazine = null
		update_icon()
		to_chat(user, "<span class='notice'>You remove the magazine from [src].</span>")
		playsound(user, 'sound/weapons/magout.ogg', 60, 1)

/obj/item/gun/ballistic/automatic/m1919/attackby(obj/item/A, mob/user, params)
	if(!cover_open && istype(A, mag_type))
		to_chat(user, "<span class='warning'>[src]'s cover is closed! You can't insert a new mag.</span>")
		return
	..()

/obj/item/gun/ballistic/automatic/m1919/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 2
			spread = 30
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select += 1
			burst_size = 3
			spread = 40
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(2)
			select += 1
			burst_size = 4
			spread = 50
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(3)
			select = 0
			burst_size = 1
			spread = 20
			to_chat(user, "<span class='notice'>You switch to semi-automatic.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return



////////
//MISC//
////////


//M72 Gauss rifle
/obj/item/gun/ballistic/automatic/m72
	name = "\improper M72 gauss rifle"
	desc = "The M72 rifle is of German design. It uses an electromagnetic field to propel rounds at tremendous speed... and pierce almost any obstacle. Its range, accuracy and stopping power is almost unparalleled."
	icon_state = "m72"
	item_state = "shotgun"
	slot_flags = SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/m2mm
	burst_size = 1
	fire_delay = 15
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	//projectile_speed = 0
	recoil = 2
	semi_auto = TRUE
	fire_sound = 'sound/f13weapons/gauss_rifle.ogg'

/obj/item/gun/ballistic/automatic/xl70e3
	name = "xl70e3"
	desc = "This was an experimental weapon at the time of the war. Manufactured, primarily, from high-strength polymers, the weapon is almost indestructible. It's light, fast firing, accurate, and can be broken down without the use of any tools. Chamebered in 5.56mm."
	icon_state = "xl70e3"
	item_state = "xl70e3"
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	fire_delay = 1
	burst_shot_delay = 1
	spawnwithmagazine = TRUE
	spread = 4
	can_attachments = TRUE
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE

/obj/item/gun/ballistic/automatic/p90
	name = "FN P90c"
	desc = "The Fabrique Nationale P90c was just coming into use at the time of the war. The weapon's bullpup layout, and compact design, make it easy to control. The durable P90c is prized for its reliability, and high firepower in a ruggedly-compact package. Chambered in 10mm."
	icon_state = "p90"
	item_state = "m90"
	burst_size = 3
	fire_delay = 1
	mag_type = /obj/item/ammo_box/magazine/m10mm_p90
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_LIGHT
	extra_damage = 5
	extra_penetration = 0.1
	can_suppress = TRUE
	suppressor_state = "pistol_suppressor"
	suppressor_x_offset = 29
	suppressor_y_offset = 16
	fire_sound = 'sound/f13weapons/10mm_fire_03.ogg'

/obj/item/gun/ballistic/automatic/p90/worn
	name = "Worn FN P90c"
	desc = "A FN P90 manufactured by Fabrique Nationale. This one is beat to hell but still works."
	fire_delay = 4
	burst_size = 2
	extra_damage = 0


/obj/item/gun/ballistic/automatic/g11
	name = "g11"
	desc = "This gun revolutionized assault weapon design. The weapon fires a caseless cartridge consisting of a block of propellant with a bullet buried inside. The resultant weight and space savings allow this weapon to have a very high magazine capacity. Chambered in 4.73mm."
	icon_state = "g11"
	item_state = "g11"
	mag_type = /obj/item/ammo_box/magazine/m473
	fire_delay = 2
	burst_shot_delay = 2
	can_attachments = TRUE
	can_automatic = TRUE
	semi_auto = TRUE
	can_scope = FALSE
	spread = 10
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13

/obj/item/gun/ballistic/automatic/g11/upgraded
	name = "g11e"
	icon_state = "g11e"
	item_state = "g11e"
	fire_delay = 1
	burst_shot_delay = 1
	spread = 5



/////////////////
//CODE SNIPPETS//
/////////////////

/*
CODE FOR ASSAULT RIFE WITH GRENADE LAUNCHER ATTACHED
/obj/item/gun/ballistic/automatic/m90
	name = "\improper M-90gl Carbine"
	desc = "A three-round burst 5.56 toploading carbine, designated 'M-90gl'. Has an attached underbarrel grenade launcher which can be toggled on and off."
	icon_state = "m90"
	item_state = "m90"
	mag_type = /obj/item/ammo_box/magazine/m556
	fire_sound = 'sound/weapons/gunshot_smg.ogg'
	can_suppress = FALSE
	automatic_burst_overlay = FALSE
	var/obj/item/gun/ballistic/revolver/grenadelauncher/underbarrel

/obj/item/gun/ballistic/automatic/m90/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher(src)
	update_icon()

/obj/item/gun/ballistic/automatic/m90/unrestricted
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/automatic/m90/unrestricted/Initialize()
	. = ..()
	underbarrel = new /obj/item/gun/ballistic/revolver/grenadelauncher/unrestricted(src)
	update_icon()

/obj/item/gun/ballistic/automatic/m90/afterattack(atom/target, mob/living/user, flag, params)
	if(select == 2)
		underbarrel.afterattack(target, user, flag, params)
	else
		. = ..()
		return
/obj/item/gun/ballistic/automatic/m90/attackby(obj/item/A, mob/user, params)
	if(istype(A, /obj/item/ammo_casing))
		if(istype(A, underbarrel.magazine.ammo_type))
			underbarrel.attack_self()
			underbarrel.attackby(A, user, params)
	else
		..()
/obj/item/gun/ballistic/automatic/m90/update_overlays()
	. = ..()
	switch(select)
		if(0)
			. += "[initial(icon_state)]semi"
		if(1)
			. += "[initial(icon_state)]burst"
		if(2)
			. += "[initial(icon_state)]gren"

/obj/item/gun/ballistic/automatic/m90/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/m90/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select = 1
			burst_size = initial(burst_size)
			to_chat(user, "<span class='notice'>You switch to [burst_size]-rnd burst.</span>")
		if(1)
			select = 2
			to_chat(user, "<span class='notice'>You switch to grenades.</span>")
		if(2)
			select = 0
			burst_size = 1
			to_chat(user, "<span class='notice'>You switch to semi-auto.</span>")
	playsound(user, 'sound/weapons/empty.ogg', 100, 1)
	update_icon()
	return


LONG SCOPE
	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 13


MAG ICON CODE
/obj/item/gun/ballistic/automatic/surplus/update_icon_state()
	if(magazine)
		icon_state = "surplus"
	else
		icon_state = "surplus-e"

SPREAD UPON BURST TOGGLE
/obj/item/gun/ballistic/automatic/wt550/enable_burst()
	. = ..()
	spread = 15

/obj/item/gun/ballistic/automatic/wt550/disable_burst()
	. = ..()
	spread = 0

ICON UPDATE FOR GRADUAL DEPLETION, PLASTIC MAGS ETC
/obj/item/gun/ballistic/automatic/c20r/update_icon_state()
	icon_state = "c20r[magazine ? "-[CEILING(get_ammo(0)/4, 1)*4]" : ""][chambered ? "" : "-e"][suppressed ? "-suppressed" : ""]"

/obj/item/gun/ballistic/automatic/wt550/update_icon_state()
	icon_state = "wt550[magazine ? "-[CEILING(((get_ammo(FALSE) / magazine.max_ammo) * 20) /4, 1)*4]" : "-0"]" //Sprites only support up to 20.
*/
