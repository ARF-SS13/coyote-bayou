/obj/item/gun/ballistic/revolver
	slowdown = 0.1
	name = "\improper .357 revolver"
	desc = "A suspicious revolver. Uses .357 ammo." //usually used by syndicates
	icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder
	casing_ejector = FALSE
	spawnwithmagazine = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	equipsound = 'sound/f13weapons/equipsounds/pistolequip.ogg'

/obj/item/gun/ballistic/revolver/Initialize()
	. = ..()
	if(!istype(magazine, /obj/item/ammo_box/magazine/internal/cylinder))
		verbs += /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/chamber_round(spin = 1)
	if(spin)
		chambered = magazine.get_round(1)
	else
		chambered = magazine.stored_ammo[1]

/obj/item/gun/ballistic/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round(1)

/*
/obj/item/gun/ballistic/revolver/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(.)
		return
	var/num_loaded = magazine.attackby(A, user, params, 1)
	if(num_loaded)
		to_chat(user, "<span class='notice'>You load [num_loaded] shell\s into \the [src].</span>")
		playsound(user, 'sound/weapons/bulletinsert.ogg', 60, 1)
		A.update_icon()
		update_icon()
		chamber_round(0)
*/

/obj/item/gun/ballistic/revolver/attack_self(mob/living/user)
	var/num_unloaded = 0
	chambered = null
	while (get_ammo() > 0)
		var/obj/item/ammo_casing/CB
		CB = magazine.get_round(0)
		if(CB)
			CB.forceMove(drop_location())
			CB.bounce_away(FALSE, NONE)
			num_unloaded++
	if (num_unloaded)
		to_chat(user, "<span class='notice'>You unload [num_unloaded] shell\s from [src].</span>")
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

/obj/item/gun/ballistic/revolver/verb/spin()
	set name = "Spin Chamber"
	set category = "Object"
	set desc = "Click to spin your revolver's chamber."

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if(do_spin())
		usr.visible_message("[usr] spins [src]'s chamber.", "<span class='notice'>You spin [src]'s chamber.</span>")
	else
		verbs -= /obj/item/gun/ballistic/revolver/verb/spin

/obj/item/gun/ballistic/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(0)

/obj/item/gun/ballistic/revolver/can_shoot()
	return get_ammo(0,0)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = 0, countempties = 1)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/revolver/examine(mob/user)
	. = ..()
	. += "[get_ammo(0,0)] of those are live rounds."


/obj/item/gun/ballistic/revolver/detective
	name = "\improper .38 Mars Special"
	desc = "A cheap Martian knock-off of a classic law enforcement firearm. Uses .38-special rounds."
	icon_state = "detective"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	obj_flags = UNIQUE_RENAME
	unique_reskin = list("Default" = "detective",
						"Leopard Spots" = "detective_leopard",
						"Black Panther" = "detective_panther",
						"Gold Trim" = "detective_gold",
						"The Peacemaker" = "detective_peacemaker"
						)
	var/list/safe_calibers

/obj/item/gun/ballistic/revolver/detective/Initialize()
	. = ..()
	safe_calibers = magazine.caliber

/obj/item/gun/ballistic/revolver/detective/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	if(chambered && !(chambered.caliber in safe_calibers))
		if(prob(70 - (magazine.ammo_count() * 10)))	//minimum probability of 10, maximum of 60
			playsound(user, fire_sound, 50, 1)
			to_chat(user, "<span class='userdanger'>[src] blows up in your face!</span>")
			user.take_bodypart_damage(0,20)
			user.dropItemToGround(src)
			return FALSE
	..()


/obj/item/gun/ballistic/revolver/mateba
	name = "\improper Unica 6 auto-revolver"
	desc = "A retro high-powered autorevolver typically used by officers of the New Russia military. Uses .357 ammo."
	icon_state = "mateba"


// A gun to play Russian Roulette!
// You can spin the chamber to randomize the position of the bullet.

/obj/item/gun/ballistic/revolver/russian
	name = "\improper Russian revolver"
	desc = "A Russian-made revolver for drinking games. Uses .357 ammo, and has a mechanism requiring you to spin the chamber before each trigger pull."
	icon_state = "russianrevolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rus357
	var/spun = FALSE

/obj/item/gun/ballistic/revolver/russian/do_spin()
	. = ..()
	spun = TRUE

/obj/item/gun/ballistic/revolver/russian/Initialize()
	. = ..()
	do_spin()
	spun = TRUE
	update_icon()

/obj/item/gun/ballistic/revolver/russian/attackby(obj/item/A, mob/user, params)
	..()
	if(get_ammo() > 0)
		spin()
		spun = TRUE
	update_icon()
	A.update_icon()
	return

/obj/item/gun/ballistic/revolver/russian/attack_self(mob/user)
	if(!spun)
		spin()
		spun = TRUE
		return
	..()

/obj/item/gun/ballistic/revolver/russian/afterattack(atom/target, mob/living/user, flag, params)
	. = ..(null, user, flag, params)

	if(flag)
		if(!(target in user.contents) && ismob(target))
			if(user.a_intent == INTENT_HARM) // Flogging action
				return

	if(isliving(user))
		if(!can_trigger_gun(user))
			return
	if(target != user)
		if(ismob(target))
			to_chat(user, "<span class='warning'>A mechanism prevents you from shooting anyone but yourself!</span>")
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(!spun)
			to_chat(user, "<span class='warning'>You need to spin \the [src]'s chamber first!</span>")
			return

		spun = FALSE

		if(chambered)
			var/obj/item/ammo_casing/AC = chambered
			if(AC.fire_casing(user, user))
				playsound(user, fire_sound, 50, 1)
				var/zone = check_zone(user.zone_selected)
				var/obj/item/bodypart/affecting = H.get_bodypart(zone)
				if(zone == BODY_ZONE_HEAD || zone == BODY_ZONE_PRECISE_EYES || zone == BODY_ZONE_PRECISE_MOUTH)
					shoot_self(user, affecting)
				else
					user.visible_message("<span class='danger'>[user.name] cowardly fires [src] at [user.p_their()] [affecting.name]!</span>", "<span class='userdanger'>You cowardly fire [src] at your [affecting.name]!</span>", "<span class='italics'>You hear a gunshot!</span>")
				chambered = null
				return

		user.visible_message("<span class='danger'>*click*</span>")
		playsound(src, "gun_dry_fire", 30, 1)

/obj/item/gun/ballistic/revolver/russian/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0, stam_cost = 0)
	add_fingerprint(user)
	playsound(src, "gun_dry_fire", 30, TRUE)
	user.visible_message("<span class='danger'>[user.name] tries to fire \the [src] at the same time, but only succeeds at looking like an idiot.</span>", "<span class='danger'>\The [src]'s anti-combat mechanism prevents you from firing it at the same time!</span>")

/obj/item/gun/ballistic/revolver/russian/proc/shoot_self(mob/living/carbon/human/user, affecting = BODY_ZONE_HEAD)
	user.apply_damage(300, BRUTE, affecting)
	user.visible_message("<span class='danger'>[user.name] fires [src] at [user.p_their()] head!</span>", "<span class='userdanger'>You fire [src] at your head!</span>", "<span class='italics'>You hear a gunshot!</span>")


//////////////////////F13 Guns///////////////


/obj/item/gun/ballistic/revolver/police
	name = ".38 police revolver"
	desc = "Pre-war double action police revolver in .38 calibre."
	icon_state = "police"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev38
	fire_delay = 6
	fire_sound = 'sound/f13weapons/policepistol.ogg'

/obj/item/gun/ballistic/revolver/colt357
	name = ".357 Magnum revolver"
	desc = "A crudely made but effective revolver."
	item_state = "357colt"
	icon_state = "357colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev357
	fire_delay = 7
	var/select = 0
	fire_sound = 'sound/f13weapons/357magnum.ogg'

/obj/item/gun/ballistic/revolver/colt357/lucky
	name = "Lucky"
	desc = "Just holding this gun makes you feel like an ace. This .357 revolver has been decorated with a polished ivory handle and a smooth black barrel, and seems just a little quicker on the draw than most guns."
	item_state = "lucky"
	icon_state = "lucky"
	w_class = WEIGHT_CLASS_SMALL
	fire_delay = 3
	block_chance = 20 //Do you feel lucky? Well, do you, punk?

/obj/item/gun/ballistic/revolver/lucky37
	name = "Lucky 37"
	desc = "One of the few weapons designed and created purely in the post-war world, it takes .38 ad .357 rounds, adjusting the rifling and boring based upon which is loaded."
	item_state = "gun"
	icon_state = "lucky37"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/lucky37
	fire_delay = 7

//10mm revolver. Double action, long barrel.
/obj/item/gun/ballistic/revolver/colt6520
	name = "Colt 6520"
	desc = "The Colt 6520 10mm double action revolver is a highly durable weapon developed by Colt Firearms prior to the Great War. It proved to be resistant to the desert-like conditions of the post-nuclear wasteland and is a fine example of workmanship and quality construction."
	icon_state = "colt6520"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev6520
	fire_delay = 7
	extra_damage = 1
	spread = 1
	fire_sound = 'sound/f13weapons/10mm_fire_02.ogg'

///////////////////
// .44 REVOLVERS //
///////////////////

//.44 Magnum. Double action.
/obj/item/gun/ballistic/revolver/m29
	name = ".44 Magnum revolver"
	desc = "The powerful cartridge makes this revolver pack a mean punch."
	item_state = "model29"
	icon_state = "m29"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	fire_sound = 'sound/f13weapons/44mag.ogg'
	fire_delay = 7
	can_scope = TRUE
	scope_state = "revolver_scope"
	scope_x_offset = 6
	scope_y_offset = 24

/obj/item/gun/ballistic/revolver/m29/snub
	name = "\improper snubnose .44 magnum revolver"
	desc = "A snubnose variant of the common place .44 magnum. An excellent holdout weapon for self defense."
	icon_state = "m29_snub"
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	extra_damage = -2 //Smaller barrel, smaller bullet velocity
	extra_penetration = -0.1 //See above
	spread = 6

/obj/item/gun/ballistic/revolver/m29/alt
	item_state = "44magnum"
	icon_state = "mysterious_m29"
	can_scope = FALSE


/obj/item/gun/ballistic/revolver/m29/peacekeeper
	name = "Peacekeeper"
	desc = "Even desert roses have thorns. This .44 revolver has been modified with a special hammer mechanism, allowing for slow, powerful shots, or fanning the hammer for a flurry of more inaccurate shots."
	item_state = "m29peace"
	icon_state = "m29peace"
	extra_damage = 15
	extra_penetration = 0.1
	fire_delay = 10
	burst_size = 1
	var/select = 0
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_scope = FALSE

/obj/item/gun/ballistic/revolver/m29/peacekeeper/ui_action_click()
	burst_select()

/obj/item/gun/ballistic/revolver/m29/peacekeeper/proc/burst_select()
	var/mob/living/carbon/human/user = usr
	switch(select)
		if(0)
			select += 1
			burst_size = 3 //fan the hammer
			spread = 15
			extra_penetration = 0
			fire_delay = 1
			to_chat(user, "<span class='notice'>You prepare to fan the hammer for a rapid burst of shots.</span>")
		if(1)
			select = 0
			burst_size = 1
			spread = 0
			extra_damage = 15 //50 damage, 10 AP - equivalent to a .45-70 Govt round. Strong, but slow.
			extra_penetration = 0.1
			to_chat(user, "<span class='notice'>You switch to single-shot fire.</span>")
	update_icon()



/obj/item/gun/ballistic/revolver/revolver44
	name = "\improper .44 magnum single-action revolver"
	desc = "I hadn't noticed, but there on his hip, was a short-barreled bad .44..."
	item_state = "44colt"
	icon_state = "44colt"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	fire_delay = 8
	extra_damage = 1
	fire_sound = 'sound/f13weapons/44revolver.ogg'

/obj/item/gun/ballistic/revolver/revolver44/desert_ranger
	desc = "I hadn't noticed, but there on his hip, was a short-barreled bad .44... This one has been improved by its owner."
	fire_delay = 6
	extra_damage = 5 //Just rarity bonus
	extra_penetration = 0.1

/obj/item/gun/ballistic/revolver/revolver45
	name = "\improper .45 colt revolver"
	desc = "A Colt Single Action Army retooled to accept .45 ACP catridges. A classic piece of Americana."
	item_state = "45revolver"
	icon_state = "45revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev45
	fire_delay = 8
	fire_sound = 'sound/f13weapons/45revolver.ogg'


/*
/obj/item/gun/ballistic/revolver/colt357/lucky/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(attack_type == PROJECTILE_ATTACK)
		if(prob(block_chance))
			owner.visible_message("<span class='danger'>[owner] seems to dodge [attack_text] entirely thanks to [src]!</span>")
			playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 75, 1)
			return 1
	return 0
*/



/obj/item/gun/ballistic/revolver/sequoia
	name = "ranger sequoia"
	desc = "This large, double-action revolver is a rare, scopeless variant of the hunting revolver. It is used exclusively by the New California Republic Rangers. This revolver features a dark finish with intricate engravings etched all around the weapon. Engraved along the barrel are the words 'For Honorable Service,' and 'Against All Tyrants.' The hand grip bears the symbol of the NCR Rangers, a bear, and a brass plate attached to the bottom that reads '20 Years.' "
	icon_state = "sequoia"
	item_state = "sequoia"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev4570
	fire_delay = 7
	recoil = 1
	fire_sound = 'sound/f13weapons/sequoia.ogg'

/obj/item/gun/ballistic/revolver/sequoia/bayonet
	name = "bayoneted ranger sequoia"
	desc = "This large, double-action revolver is a rare, scopeless variant of the hunting revolver. It is used exclusively by the New California Republic Rangers. This revolver features a dark finish with intricate engravings etched all around the weapon. Engraved along the barrel are the words 'For Honorable Service,' and 'Against All Tyrants.' The hand grip bears the symbol of the NCR Rangers, a bear, and a brass plate attached to the bottom that reads '20 Years.' This one has a bayonet on it."
	icon_state = "sequoia_b"
	item_state = "sequoia"

/obj/item/gun/ballistic/revolver/hunting
	name = "hunting revolver"
	desc = "A scoped double action revolver chambered in 45-70."
	icon_state = "hunting_revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev4570
	fire_delay = 7
	recoil = 1
	can_scope = TRUE
	scope_state = "revolver_scope"
	scope_x_offset = 9
	scope_y_offset = 20
	fire_sound = 'sound/f13weapons/sequoia.ogg'


//.223 pistol. Very short barrel.
/obj/item/gun/ballistic/revolver/thatgun 
	name = ".223 pistol"
	desc = "A strange pistol firing rifle ammunition, possibly damaging the users wrist and with poor accuracy."
	icon_state = "thatgun"
	fire_sound = 'sound/f13weapons/magnum_fire.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/thatgun
	recoil = 1
	fire_delay = 7
	extra_damage = -3
	spread = 8

/obj/item/gun/ballistic/revolver/needler
	name = "Needler pistol"
	desc = "You suspect this Bringham needler pistol was once used in scientific field studies. It uses small hard-plastic hypodermic darts as ammo. "
	icon_state = "needler"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/revneedler
	fire_sound = 'sound/weapons/gunshot_silenced.ogg'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/gun/ballistic/revolver/needler/ultra
	name = "Ultracite needler"
	desc = "An ultracite enhanced needler pistol"
	icon_state = "ultraneedler"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/revneedler
	fire_sound = 'sound/weapons/gunshot_silenced.ogg'
	w_class = WEIGHT_CLASS_SMALL

//Hobo guns

/obj/item/gun/ballistic/revolver/zipgun
	name = "zipgun (9mm)"
	desc = "A crudely-made 9mm pistol. You're not sure this thing is reliable."
	icon_state = "zipgun"
	item_state = "gun"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised9mm
	spread = 20

/obj/item/gun/ballistic/revolver/pipe_rifle
	name = "pepperbox gun (10mm)"
	desc = "Take six pipes. Tie them together. Add planks, 10mm ammo and prayers."
	icon_state = "pepperbox"
	item_state = "improvgun"
	fire_sound = 'sound/weapons/Gunshot.ogg'
	extra_damage = 1
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/improvised10mm
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	spread = 15

/obj/item/gun/ballistic/revolver/pipe_rifle/attackby(obj/item/A, mob/user, params)
	..()
	if(A.tool_behaviour == TOOL_SAW || istype(A, /obj/item/gun/energy/plasmacutter))
		sawoff(user)

//Adminbus gun. Not ingame.
/obj/item/gun/ballistic/revolver/sequoia/death
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev4570/death
	fire_sound = 'sound/f13weapons/sequoia.ogg'
	fire_delay = 0

/*
/obj/item/gun/ballistic/revolver/shotgunrevolver
	name = "\improper revolver shotgun"
	desc = "A large revolver that fires shotgun shells."
	icon_state = "judge"
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/shotgunrevolver
	fire_sound = 'sound/f13weapons/caravan_shotgun.ogg'
	fire_delay = 10
	w_class = WEIGHT_CLASS_SMALL
	weapon_weight = WEAPON_LIGHT
	spread = 40
*/

////////////////
//CODE ARCHIVE//
////////////////
/*

CODE FOR BREAK SHOTGUN  Might be better than the current sprite proc solution at some point.
/obj/item/gun/ballistic/revolver/doublebarrel/attack_self(mob/living/user)
	var/num_unloaded = 0
	while (get_ammo() > 0)
		var/obj/item/ammo_casing/CB
		CB = magazine.get_round(0)
		chambered = null
		CB.forceMove(drop_location())
		CB.update_icon()
		num_unloaded++
	if (num_unloaded)
		to_chat(user, "<span class='notice'>You break open \the [src] and unload [num_unloaded] shell\s.</span>")
	else
		to_chat(user, "<span class='warning'>[src] is empty!</span>")

CODE RELATED TO MAKING SLINGS. Would love to implement at some point.
/obj/item/gun/ballistic/revolver/doublebarrel/improvised/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/stack/cable_coil) && !sawn_off)
		if(A.use_tool(src, user, 0, 10, skill_gain_mult = EASY_USE_TOOL_MULT))
			slot_flags = ITEM_SLOT_BACK
			to_chat(user, "<span class='notice'>You tie the lengths of cable to the shotgun, making a sling.</span>")
			slung = TRUE
			update_icon()
		else
			to_chat(user, "<span class='warning'>You need at least ten lengths of cable if you want to make a sling!</span>")

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/update_overlays()
	. = ..()
	if(slung)
		. += "[icon_state]sling"

/obj/item/gun/ballistic/revolver/doublebarrel/improvised/sawoff(mob/user)
	. = ..()
	if(. && slung) //sawing off the gun removes the sling
		new /obj/item/stack/cable_coil(get_turf(src), 10)
		slung = 0
		update_icon()


REVERSE GUN CODE - maybe useful for booby trapped gun at some point
/obj/item/gun/ballistic/revolver/reverse/can_trigger_gun(mob/living/user)
	if((HAS_TRAIT(user, TRAIT_CLUMSY)) || (user.mind && HAS_TRAIT(user.mind, TRAIT_CLOWN_MENTALITY)))
		return ..()
	if(process_fire(user, user, FALSE, null, BODY_ZONE_HEAD))
		user.visible_message("<span class='warning'>[user] somehow manages to shoot [user.p_them()]self in the face!</span>", "<span class='userdanger'>You somehow shoot yourself in the face! How the hell?!</span>")
		user.emote("scream")
		user.drop_all_held_items()
		user.DefaultCombatKnockdown(80)

CODE FOR CHANGING CALIBER ON GUN WITH SCREWDRIVER. Pretty neat, would fit good on hobo guns.
/obj/item/gun/ballistic/revolver/detective/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if("38" in magazine.caliber)
		to_chat(user, "<span class='notice'>You begin to reinforce the barrel of [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//you know the drill
			user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='userdanger'>[src] goes off in your face!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>You can't modify it!</span>")
				return TRUE
			magazine.caliber = "357"
			desc = "The barrel and chamber assembly seems to have been modified."
			to_chat(user, "<span class='notice'>You reinforce the barrel of [src]. Now it will fire .357 rounds.</span>")
	else
		to_chat(user, "<span class='notice'>You begin to revert the modifications to [src]...</span>")
		if(magazine.ammo_count())
			afterattack(user, user)	//and again
			user.visible_message("<span class='danger'>[src] goes off!</span>", "<span class='userdanger'>[src] goes off in your face!</span>")
			return TRUE
		if(I.use_tool(src, user, 30))
			if(magazine.ammo_count())
				to_chat(user, "<span class='warning'>You can't modify it!</span>")
				return
			magazine.caliber = "38"
			desc = initial(desc)
			to_chat(user, "<span class='notice'>You remove the modifications on [src]. Now it will fire .38 rounds.</span>")
	return TRUE

CODE FOR MODULAR HIGH TECH GUN. Kind of neat. From a place called Vorestation according to the old comment. How nice.
/obj/item/gun/ballistic/revolver/mws
	name = "MWS-01 'Big Iron'"
	desc = "Modular Weapons System"

	icon = 'icons/obj/guns/projectile.dmi'
	icon_state = "mws"

	fire_sound = 'sound/weapons/Taser.ogg'

	mag_type = /obj/item/ammo_box/magazine/mws_mag
	spawnwithmagazine = FALSE

	recoil = 0

	var/charge_sections = 6

/obj/item/gun/ballistic/revolver/mws/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Alt-click to remove the magazine.</span>"

/obj/item/gun/ballistic/revolver/mws/shoot_with_empty_chamber(mob/living/user as mob|obj)
	process_chamber(user)
	if(!chambered || !chambered.BB)
		to_chat(user, "<span class='danger'>*click*</span>")
		playsound(src, "gun_dry_fire", 30, 1)


/obj/item/gun/ballistic/revolver/mws/process_chamber(mob/living/user)
	if(chambered && !chambered.BB) //if BB is null, i.e the shot has been fired...
		var/obj/item/ammo_casing/mws_batt/shot = chambered
		if(shot.cell.charge >= shot.e_cost)
			shot.chargeshot()
		else
			for(var/B in magazine.stored_ammo)
				var/obj/item/ammo_casing/mws_batt/other_batt = B
				if(istype(other_batt,shot) && other_batt.cell.charge >= other_batt.e_cost)
					switch_to(other_batt, user)
					break
	update_icon()

/obj/item/gun/ballistic/revolver/mws/proc/switch_to(obj/item/ammo_casing/mws_batt/new_batt, mob/living/user)
	if(ishuman(user))
		if(chambered && new_batt.type == chambered.type)
			to_chat(user,"<span class='warning'>[src] is now using the next [new_batt.type_name] power cell.</span>")
		else
			to_chat(user,"<span class='warning'>[src] is now firing [new_batt.type_name].</span>")

	chambered = new_batt
	update_icon()

/obj/item/gun/ballistic/revolver/mws/attack_self(mob/living/user)
	if(!chambered)
		return

	var/list/stored_ammo = magazine.stored_ammo

	if(stored_ammo.len == 1)
		return //silly you.

	//Find an ammotype that ISN'T the same, or exhaust the list and don't change.
	var/our_slot = stored_ammo.Find(chambered)

	for(var/index in 1 to stored_ammo.len)
		var/true_index = ((our_slot + index - 1) % stored_ammo.len) + 1 // Stupid ONE BASED lists!
		var/obj/item/ammo_casing/mws_batt/next_batt = stored_ammo[true_index]
		if(chambered != next_batt && !istype(next_batt, chambered.type) && next_batt.cell.charge >= next_batt.e_cost)
			switch_to(next_batt, user)
			break

/obj/item/gun/ballistic/revolver/mws/AltClick(mob/living/user)
	.=..()
	if(magazine)
		user.put_in_hands(magazine)
		magazine.update_icon()
		if(magazine.ammo_count())
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, 1)
		else
			playsound(src, "gun_remove_empty_magazine", 70, 1)
		magazine = null
		to_chat(user, "<span class='notice'>You pull the magazine out of [src].</span>")
		if(chambered)
			chambered = null
		update_icon()

/obj/item/gun/ballistic/revolver/mws/update_overlays()
	.=..()
	if(!chambered)
		return

	var/obj/item/ammo_casing/mws_batt/batt = chambered
	var/batt_color = batt.type_color //Used many times

	//Mode bar
	var/image/mode_bar = image(icon, icon_state = "[initial(icon_state)]_type")
	mode_bar.color = batt_color
	. += mode_bar

	//Barrel color
	var/mutable_appearance/barrel_color = mutable_appearance(icon, "[initial(icon_state)]_barrel", color = batt_color)
	barrel_color.alpha = 150
	. += barrel_color

	//Charge bar
	var/ratio = can_shoot() ? CEILING(clamp(batt.cell.charge / batt.cell.maxcharge, 0, 1) * charge_sections, 1) : 0
	for(var/i = 0, i < ratio, i++)
		var/mutable_appearance/charge_bar = mutable_appearance(icon,  "[initial(icon_state)]_charge", color = batt_color)
		charge_bar.pixel_x = i
		. += charge_bar

*/
