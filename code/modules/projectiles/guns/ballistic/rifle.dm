//In this document. Lever action rifles, Bolt action rifles

//////////////////////////////////////////
//UNIVERSAL GUN CATEGORIES AND MODIFIERS//
//////////////////////////////////////////
/*
GENERAL

	Bonuses should not go far from this framework, for non-unique stuff plus minus one or two is enough to give a good spread, considering its compounded by tinkering and attachments and ammo.
	A reduction of 1 in burst shot delay gives a lot more effect than adding 1 damage.

MECHANISMS

	SINGLE ACTION REVOLVER
	fire_delay = 7
	spread = 1

	DOUBLE ACTION REVOLVER
	fire_delay = 6	
	spread = 2

	SEMI-AUTOMATIC PISTOL
	fire_delay = 3-5	
	spread = 3

	SEMI-AUTOMATIC RIFLE
	fire_delay = 3-6
	spread = 1-2

	AUTOMATIC
	fire_delay = 3-7
	burst_shot_delay = 2.5
	spread = 7-14

	REPEATER	
	fire_delay = 8
	spread = 1	

	DOUBLE BARREL
	fire_delay = 1

	PUMP-ACTION
	fire_delay = 7
	extra damage = 1
	spread = 0 (shotguns need 0 spread unless sawn off since it scatters the individual pellets. Slugs have gotten a 2 spread increase instead, so all good.)
	(requires manual action to cycle)

	BOLT-ACTION
	fire_delay = 10-15
	extra damage = 5
	extra_speed = 500
	(requires manual action to cycle)

BULK
	SMALL GUNS
	slowdown = 0.1-0.2
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT - MEDIUM		

	MEDIUM GUNS
	slowdown = 0.3-0.4
	w_class = WEIGHT_CLASS_NORMAL - BULKY
	weapon_weight = WEAPON_MEDIUM - HEAVY	

	RIFLES 
	slowdown = 0.5
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY

PARTS

	PISTOL GRIP/FOLDED STOCK MALUS
	For rifles, not pistols obviously
	recoil = +0.5
	spread = +2 unless shotgun

	SAWN OFF
	recoil = 1
	spread = 10
	weapon_weight = WEAPON_LIGHT

	LONG BARREL
	extra_damage = +2
	spread = -1

	SHORT BARREL
	extra_damage = -2
	spread = +3

	HEAVY
	recoil = 0.1
	No dual wield

	AMMO RECOIL BASE VALUES
	.50  recoil = 1
	.45/70  recoil = 0.25


FORCE 	Delicate, clumsy or small gun force 10
		Pistol whip force 12
		Rifle type force 15
		Unusually sturdy clublike 20

ATTACHMENTS

	BURST CAM
	burst_size + 1
	spread + 5 (recoil)
	burst_shot_delay + 0.5 (recoil managment)

	RECOIL COMPENSATOR
	spread above 10 = -4 spread
	spread under 10 = -2 spread

	AUTO SEAR
	Enables fire select automatic
	burst_size + 1
	spread + 6 (to bring it into the automatic template range)
*/


////////////
// RIFLES //
////////////

// Rifle template
/obj/item/gun/ballistic/rifle
	slowdown = 0.5 
	name = "rifle template"
	desc = "Should not exist"
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgun"
	item_state = "shotgun"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	can_automatic = FALSE
	fire_delay = 8
	spread = 1
	force = 15 //Decent clubs generally speaking
	flags_1 =  CONDUCT_1
	casing_ejector = FALSE
	var/recentpump = 0 // to prevent spammage
	spawnwithmagazine = TRUE
	var/pump_sound = 'sound/weapons/shotgunpump.ogg'
	fire_sound = 'sound/f13weapons/shotgun.ogg'

/obj/item/gun/ballistic/rifle/process_chamber(mob/living/user, empty_chamber = 0)
	return ..() //changed argument value

/obj/item/gun/ballistic/rifle/can_shoot()
	return !!chambered?.BB

/obj/item/gun/ballistic/rifle/attack_self(mob/living/user)
	if(recentpump > world.time)
		return
	if(IS_STAMCRIT(user))//CIT CHANGE - makes pumping shotguns impossible in stamina softcrit
		to_chat(user, "<span class='warning'>You're too exhausted for that.</span>")//CIT CHANGE - ditto
		return//CIT CHANGE - ditto
	pump(user, TRUE)
	if(HAS_TRAIT(user, TRAIT_FAST_PUMP))
		recentpump = world.time + 2
	else
		recentpump = world.time + 10
		if(istype(user))//CIT CHANGE - makes pumping shotguns cost a lil bit of stamina.
			user.adjustStaminaLossBuffered(2) //CIT CHANGE - DITTO. make this scale inversely to the strength stat when stats/skills are added
	return

/obj/item/gun/ballistic/rifle/blow_up(mob/user)
	. = 0
	if(chambered && chambered.BB)
		process_fire(user, user, FALSE)
		. = 1

/obj/item/gun/ballistic/rifle/proc/pump(mob/M, visible = TRUE)
	if(visible)
		M.visible_message("<span class='warning'>[M] racks [src].</span>", "<span class='warning'>You rack [src].</span>")
	playsound(M, pump_sound, 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/rifle/proc/pump_unload(mob/M)
	if(chambered)//We have a shell in the chamber
		chambered.forceMove(drop_location())//Eject casing
		chambered.bounce_away()
		chambered = null

/obj/item/gun/ballistic/rifle/proc/pump_reload(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/rifle/examine(mob/user)
	. = ..()
	if (chambered)
		. += "A [chambered.BB ? "live" : "spent"] one is in the chamber."



///////////////////
//REPEATER RIFLES//
///////////////////


/obj/item/gun/ballistic/rifle/repeater
	name = "repeater template"
	desc = "should not exist"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	fire_delay = 8 //Standard repeater mechanism delay 
	can_automatic = FALSE
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 5
	scope_y_offset = 13
	pump_sound = 'sound/f13weapons/cowboyrepeaterreload.ogg'

/obj/item/gun/ballistic/rifle/repeater/shoot_live_shot(mob/living/user, pointblank = FALSE, mob/pbtarget, message = 1, stam_cost = 0)
	..()
	src.pump(user)


//Cowboy Repeater						Keywords: .357, Lever action, 12 round internal, Long barrel
/obj/item/gun/ballistic/rifle/repeater/cowboy
	name = "cowboy repeater"
	desc = "A lever action rifle chambered in .357 Magnum. Smells vaguely of whiskey and cigarettes."
	icon_state = "cowboyrepeater"
	item_state = "cowboyrepeater"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube357
	extra_damage = 2
	fire_sound = 'sound/f13weapons/cowboyrepeaterfire.ogg'


//Trail carbine							Keywords: .44, Lever action, 12 round internal, Long barrel
/obj/item/gun/ballistic/rifle/repeater/trail
	name = "trail carbine"
	desc = "A lever action rifle chambered in .44 Magnum."
	icon_state = "trailcarbine"
	item_state = "trailcarbine"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube44
	extra_damage = 2
	fire_sound = 'sound/f13weapons/44mag.ogg'


//Brush gun								Keywords: .45-70, Lever action, 10 round internal, Long barrel
/obj/item/gun/ballistic/rifle/repeater/brush
	name = "brush gun"
	desc = "A short lever action rifle chambered in the heavy 45-70 round. Issued to NCR Veteran Rangers in the absence of heavier weaponry."
	icon_state = "brushgun"
	item_state = "brushgun"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/tube4570
	extra_damage = 2
	recoil = 0.1
	fire_sound = 'sound/f13weapons/brushgunfire.ogg'



////////////////////////
// BOLT ACTION RIFLES //
////////////////////////


//Hunting Rifle							Keywords: .308, Bolt-action, 5 rounds internal
/obj/item/gun/ballistic/rifle/hunting
	name = "hunting rifle"
	desc = "A sturdy hunting rifle, chambered in .308. and in use before the war."
	icon_state = "308"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting
	sawn_desc = "A hunting rifle, crudely shortened with a saw. It's far from accurate, but the short barrel makes it quite portable."
	fire_delay = 10
	extra_damage = 5
	extra_speed = 500
	spread = 0
	force = 18
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 4
	scope_y_offset = 12
	pump_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/hunting_rifle.ogg'

/obj/item/gun/ballistic/rifle/hunting/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)

//Remington rifle						Keywords: 7.62, Bolt-action, 5 rounds internal
/obj/item/gun/ballistic/rifle/hunting/remington
	name = "Remington rifle"
	desc = "A militarized hunting rifle rechambered to 7.62. This one has had the barrel floated with shims to increase accuracy. In use by 1st Recon and designated marksman throughout the NCR."
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/remington
	fire_delay = 12
	extra_damage = 6
	extra_penetration = 0.05
	extra_speed = 500 
	force = 18
	untinkerable = TRUE

/obj/item/gun/ballistic/rifle/hunting/remington/attackby(obj/item/A, mob/user, params) //DO NOT BUBBA YOUR STANDARD ISSUE RIFLE SOLDIER!
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()


//Paciencia								Keywords: Unique, .308, Bolt-action, 5 rounds internal
/obj/item/gun/ballistic/rifle/hunting/paciencia
	name = "Paciencia"
	desc = "A modified .308 hunting rifle with a reduced magazine but an augmented receiver. A Mexican flag is wrapped around the stock. You only have three shots- make them count."
	icon_state = "paciencia"
	item_state = "paciencia"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction/hunting/paciencia
	fire_delay = 8
	extra_damage = 20 //60 damage- hits as hard as an AMR!
	extra_penetration = 0.2

/obj/item/gun/ballistic/rifle/hunting/paciencia/attackby(obj/item/A, mob/user, params) //no sawing off this one
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		return
	else if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			return
	else
		..()


//Mosin-Nagant							Keywords: 7.62, Bolt-action, 5 rounds internal
/obj/item/gun/ballistic/rifle/mosin
	name = "Mosin-Nagant m38"
	desc = "A classic Russian bolt action chambered in 7.62. Now all you need is some vodka."
	icon_state = "mosin"
	item_state = "308"
	mag_type = /obj/item/ammo_box/magazine/internal/boltaction
	extra_damage = 4
	extra_speed = 400
	fire_delay = 12
	force = 18
	can_scope = TRUE
	scope_state = "scope_mosin"
	scope_x_offset = 3
	scope_y_offset = 13
	can_bayonet = TRUE
	bayonet_state = "bayonet"
	knife_x_offset = 22
	knife_y_offset = 21
	pump_sound = 'sound/weapons/boltpump.ogg'
	fire_sound = 'sound/f13weapons/boltfire.ogg'



/////////////////////////////////////
// MAGAZINE FED BOLT-ACTION RIFLES //
/////////////////////////////////////


/obj/item/gun/ballistic/rifle/mag
	name = "magazine fed bolt-action rifle template"
	desc = "should not exist."
	extra_speed = 500

/obj/item/gun/ballistic/rifle/mag/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to remove the magazine.</span>"

/obj/item/gun/ballistic/rifle/mag/AltClick(mob/living/user)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(magazine)
		magazine.forceMove(drop_location())
		user.put_in_hands(magazine)
		magazine.update_icon()
		if(magazine.ammo_count())
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, 1)
		else
			playsound(src, "gun_remove_empty_magazine", 70, 1)
		magazine = null
		to_chat(user, "<span class='notice'>You pull the magazine out of \the [src].</span>")
	else if(chambered)
		AC.forceMove(drop_location())
		AC.bounce_away()
		chambered = null
		to_chat(user, "<span class='notice'>You unload the round from \the [src]'s chamber.</span>")
		playsound(src, "gun_slide_lock", 70, 1)
	else
		to_chat(user, "<span class='notice'>There's no magazine in \the [src].</span>")
	update_icon()
	return

/obj/item/gun/ballistic/rifle/mag/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "-[magazine.max_ammo]" : ""][chambered ? "" : "-e"]"


//Varmint rifle								Keywords: 5.56, Bolt-action, 10/20/30 round magazine, Reduced damage & speed
/obj/item/gun/ballistic/rifle/mag/varmint
	name = "varmint rifle"
	desc = "A simple bolt action rifle in 5.56mm calibre. Easy to use and maintain."
	icon_state = "varmint"
	item_state = "varmintrifle"
	force = 18
	mag_type = /obj/item/ammo_box/magazine/m556/rifle
	init_mag_type = /obj/item/ammo_box/magazine/m556/rifle/small
	fire_delay = 9
	spread = 0
	extra_damage = 4
	extra_speed = 400
	can_bayonet = FALSE
	scope_state = "scope_short"
	scope_x_offset = 4
	scope_y_offset = 12
	can_suppress = TRUE
	suppressor_state = "rifle_suppressor"
	suppressor_x_offset = 27
	suppressor_y_offset = 31
	fire_sound = 'sound/f13weapons/varmint_rifle.ogg'


//Commando carbine							Keywords: .45 ACP, Bolt-action, 12 round magazine, Long barrel, Suppressed
/obj/item/gun/ballistic/rifle/mag/commando
	name = "commando carbine"
	desc = "An integrally suppressed bolt action carbine, perfect for quiet varmint hunting. Uses .45 socom magazines."
	icon_state = "commando"
	item_state = "varmintrifle"
	mag_type = /obj/item/ammo_box/magazine/m45exp
	extra_damage = 7
	fire_delay = 8
	spread = 1
	can_unsuppress = FALSE
	suppressed = 1
	scope_state = "scope_medium"
	scope_x_offset = 6
	scope_y_offset = 14
	fire_sound = 'sound/weapons/Gunshot_large_silenced.ogg'


//Ratslayer									Keywords: Unique, 5.56, Bolt-action, 10/20/30 round magazine, Suppressed, Extra damage +3
/obj/item/gun/ballistic/rifle/mag/varmint/ratslayer
	name = "Ratslayer"
	desc = "A modified varmint rifle with better stopping power, a scope, and suppressor. Oh, don't forget the sick paint job."
	icon_state = "ratslayer"
	item_state = "ratslayer"
	extra_damage = 8
	extra_penetration = 0.1
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


//Anti-Material Rifle						Keywords: .50, Bolt-action, 8 round magazine
/obj/item/gun/ballistic/rifle/mag/antimateriel
	name = "anti-materiel rifle"
	desc = "The Hecate II is a heavy, high-powered bolt action sniper rifle chambered in .50 caliber ammunition. Lacks an iron sight."
	icon_state = "amr"
	item_state = "amr"
	mag_type = /obj/item/ammo_box/magazine/amr
	fire_delay = 11 //Heavy round, tiny bit slower
	recoil = 1
	spread = 0
	force = 10 //Big clumsy and sensitive scope, makes for a poor club
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	fire_sound = 'sound/f13weapons/antimaterielfire.ogg'
	pump_sound = 'sound/f13weapons/antimaterielreload.ogg'


/////////////
//HOBO GUNS//
/////////////


//Laser musket
/obj/item/gun/ballistic/rifle/lasmusket
	name = "Laser Musket"
	desc = "In the wasteland, one must make do. And making do is what the creator of this weapon does. Made from metal scraps, electronic parts. an old rifle stock and a bottle full of dreams, the Laser Musket is sure to stop anything in their tracks and make those raiders think twice."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "lasmusket"
	item_state = "lasmusket"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/lasmusket
	fire_delay = 15
	isenergy = TRUE
	var/bolt_open = FALSE
	can_bayonet = TRUE
	knife_x_offset = 22
	knife_y_offset = 20
	bayonet_state = "bayonet"
	can_scope = TRUE
	scope_state = "scope_long"
	scope_x_offset = 11
	scope_y_offset = 14
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	pump_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'


//Plasma musket.
/obj/item/gun/ballistic/rifle/plasmacaster
	name = "Plasma Musket"
	desc = "The cooling looks dubious and is that a empty can of beans used as a safety valve? Pray the plasma goes towards the enemy and not your face when you pull the trigger."
	icon = 'icons/fallout/objects/guns/energy.dmi'
	icon_state = "plasmamusket"
	item_state = "plasmamusket"
	mag_type = /obj/item/ammo_box/magazine/internal/plasmacaster
	fire_delay = 20
	var/bolt_open = FALSE
	isenergy = TRUE
	can_scope = TRUE
	scope_state = "scope_medium"
	scope_x_offset = 9
	scope_y_offset = 20
	fire_sound = 'sound/f13weapons/lasmusket_fire.ogg'
	pump_sound = 'sound/f13weapons/lasmusket_crank.ogg'
	equipsound = 'sound/f13weapons/equipsounds/aep7equip.ogg'


//Slamfire shotgun.
/obj/item/gun/ballistic/revolver/single_shotgun
	name = "Slamfire shotgun"
	desc = "A pipe, some wood and a screwdriver is all you need to fire a shotgun shell apparantly."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	lefthand_file = 'icons/fallout/onmob/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/fallout/onmob/weapons/guns_righthand.dmi'
	icon_state = "shotgunimprov"
	item_state = "improvgun"
	force = 20 //Good club
	mag_type = /obj/item/ammo_box/magazine/internal/shot/improvised
	sawn_desc = "At this point, you're basically holding an individual shotgun shell as it goes off."
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'

/obj/item/gun/ballistic/revolver/single_shotgun/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/circular_saw) || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)
	if(istype(A, /obj/item/melee/transforming/energy))
		var/obj/item/melee/transforming/energy/W = A
		if(W.active)
			sawoff(user)



/////////////////
//CODE SNIPPETS//
/////////////////


/*
SOME SORT OF  BOLT ACTION CODE UNUSED
/obj/item/gun/ballistic/shotgun/boltaction/pump(mob/M)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	if(bolt_open)
		pump_reload(M)
	else
		pump_unload(M)
	bolt_open = !bolt_open
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/shotgun/boltaction/pump(mob/M)
	playsound(M, 'sound/weapons/shotgunpump.ogg', 60, 1)
	pump_unload(M)
	pump_reload(M)
	update_icon()	//I.E. fix the desc
	return 1

/obj/item/gun/ballistic/shotgun/boltaction/attackby(obj/item/A, mob/user, params)
	if(!bolt_open)
		to_chat(user, "<span class='notice'>The bolt is closed!</span>")
		return
	. = ..()

/obj/item/gun/ballistic/shotgun/boltaction/examine(mob/user)
	. = ..()
	. += "The bolt is [bolt_open ? "open" : "closed"]."
*/
