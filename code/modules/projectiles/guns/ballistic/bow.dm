/obj/item/gun/ballistic/bow
	name = "base bow"
	desc = "base type of bow used to define features for multiple-loading bows"
	icon_state = "bow"
	item_state = "bow"
	icon_prefix = "bow"
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = GUN_TWO_HAND_ONLY //need both hands to fire
	force = 5
	mag_type = /obj/item/ammo_box/magazine/internal/bow
	fire_sound = 'sound/weapons/bowfire.wav'
	slot_flags = ITEM_SLOT_BACK
	item_flags = NONE
	pin = null
	no_pin_required = TRUE
	trigger_guard = TRIGGER_GUARD_NONE //so ashwalkers can use it
	spawnwithmagazine = TRUE
	casing_ejector = TRUE
	var/recentdraw
	var/draw_sound = 'sound/weapons/bowdraw.wav'
	dryfire_text = "*no arrows*"
	dryfire_sound = ""
	safety = 0
	restrict_safety = 1
	init_firemodes = list(
		/datum/firemode/semi_auto
	)
	gun_accuracy_zone_type = ZONE_WEIGHT_PRECISION
	gun_sound_properties = list(
		SP_VARY(FALSE),
		SP_VOLUME(PISTOL_LIGHT_VOLUME),
		SP_VOLUME_SILENCED(PISTOL_LIGHT_VOLUME * SILENCED_VOLUME_MULTIPLIER),
		SP_NORMAL_RANGE(PISTOL_LIGHT_RANGE),
		SP_NORMAL_RANGE_SILENCED(SILENCED_GUN_RANGE),
		SP_IGNORE_WALLS(TRUE),
		SP_DISTANT_SOUND(null),
		SP_DISTANT_RANGE(null)
	)

/obj/item/gun/ballistic/bow/process_chamber(mob/living/user, empty_chamber = 0)
	var/obj/item/ammo_casing/AC = chambered //Find chambered round
	if(istype(AC)) //there's a chambered round
		AC.forceMove(drop_location()) //Eject casing onto ground.
		chambered = null
		/* if(casing_ejector)
			AC.bounce_away(TRUE)
		else if(empty_chamber)
			chambered = null */

/obj/item/gun/ballistic/bow/can_shoot()
	return chambered

/obj/item/gun/ballistic/bow/attack_self(mob/living/user)
	if(chambered)
		user.put_in_hands(chambered)
		chambered = null
		update_icon()
		to_chat(user, span_notice("You gently release the bowstring, removing the arrow."))
		return
	if(recentdraw > world.time || !get_ammo(FALSE))
		return
	draw(user, TRUE)
	recentdraw = world.time + 2
	return

/obj/item/gun/ballistic/bow/proc/draw(mob/M, visible = TRUE)
	if(visible)
		M.visible_message(span_warning("[M] draws the string on [src]!"), span_warning("You draw the string on [src]!"))
	playsound(M, draw_sound, 60, 1)
	draw_load(M)
	update_icon()
	return 1

/obj/item/gun/ballistic/bow/proc/draw_load(mob/M)
	if(!magazine.ammo_count())
		return 0
	var/obj/item/ammo_casing/AC = magazine.get_round() //load next casing.
	chambered = AC

/obj/item/gun/ballistic/bow/attackby(obj/item/A, mob/user, params)
	if(magazine.attackby(A, user, params, 1))
		to_chat(user, span_notice("You load [A] into \the [src]."))
		update_icon()

/obj/item/gun/ballistic/bow/update_icon()
	icon_state = "[initial(icon_state)]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"


/obj/item/gun/ballistic/bow/do_fire(atom/target, mob/living/user, message = TRUE, params, zone_override = "", bonus_spread = 0, stam_cost = 0)
	..()
	if(HAS_TRAIT(user, TRAIT_AUTO_DRAW) && !chambered && get_ammo(FALSE))
		user.visible_message(span_warning("[user] instinctively draws the string on [src]!"), span_warning("You instinctively draw the string on [src]!"))
		draw(user, FALSE)
		recentdraw = world.time + 2

/obj/item/gun/ballistic/bow/xbow
	name = "magazine-fed crossbow"
	desc = "A somewhat primitive projectile weapon. Has a spring-loaded magazine, but still requires drawing back before firing. Fires arrows slightly faster than regular bows, improving damage"
	icon_state = "xbow"
	item_state = "xbow"
	icon_prefix = "xbow"
	mag_type = /obj/item/ammo_box/magazine/internal/bow/xbow
	extra_speed = 400


//Regular Bow
/obj/item/gun/ballistic/bow/tribal
	name = "short bow"
	desc = "A simple wooden bow with small pieces of turquiose, cheaply made and small enough to fit most bags, better then nothing I guess."
	icon_state = "tribalbow"
	item_state = "tribalbow"
	icon_prefix = "tribalbow"
	w_class = WEIGHT_CLASS_NORMAL
	force = 10


//Bone Bow
/obj/item/gun/ballistic/bow/claw
	name = "deathclaw bow"
	desc = "A bone bow, made of pieces of sinew and deathclaw skin for extra structure, it is a fierce weapon that all expert hunters and bowmen carry, allowing for ease of firing many arrows."
	icon_state = "ashenbow"
	item_state = "ashenbow"
	icon_prefix = "ashenbow"
	force = 20
	mag_type = /obj/item/ammo_box/magazine/internal/bow/claw
	fire_delay = 2
	extra_speed = 100

//Sturdy Bow
/obj/item/gun/ballistic/bow/sturdy
	name = "sturdy bow"
	desc = "A firm sturdy wooden bow with leather handles and sinew wrapping, for extra stopping power in the shot speed of the arrows."
	icon_state = "bow"
	icon_prefix = "bow"
	force = 15
	mag_type = /obj/item/ammo_box/magazine/internal/bow/sturdy
	extra_speed = 300

//Silver Bow
/obj/item/gun/ballistic/bow/silver
	name = "silver bow"
	desc = "A firm sturdy silver bow created by the earth, its durability and rather strong material allow it to be an excellent option for those looking for the ability to fire more arrows than normally."
	icon_state = "pipebow"
	item_state = "pipebow"
	icon_prefix = "pipebow"
	force = 15
	mag_type = /obj/item/ammo_box/magazine/internal/bow/silver
	fire_delay = 1.5

//Crossbow
/obj/item/gun/ballistic/bow/crossbow
	name = "crossbow"
	desc = "A crossbow."
	icon_state = "crossbow"
	icon_prefix = "crossbow"
	force = 10
	mag_type = /obj/item/ammo_box/magazine/internal/bow/cross
	fire_delay = 1.5
	extra_speed = 400
	zoomable = TRUE
	zoom_amt = 10
	zoom_out_amt = 13
	can_scope = FALSE
