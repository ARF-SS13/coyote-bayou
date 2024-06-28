//KEEP IN MIND: These are different from gun/grenadelauncher. These are designed to shoot premade rocket and grenade projectiles, not flashbangs or chemistry casings etc.
//Put handheld rocket launchers here if someone ever decides to make something so hilarious ~Paprika

/obj/item/gun/ballistic/revolver/grenadelauncher
	desc = "A break-operated grenade rifle. Projectiles travel slowly."
	name = "grenade rifle"
	icon = 'modular_coyote/icons/objects/gun.dmi'
	icon_state = "m79" // shinier sprite! but also points left :V
	item_state = "gun"
	mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	init_mag_type = /obj/item/ammo_box/magazine/internal/grenadelauncher
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_class = WEAPON_CLASS_CARBINE
	weapon_weight = GUN_TWO_HAND_ONLY
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/attackby(obj/item/A, mob/user, params)
	..()
	if(istype(A, /obj/item/ammo_box) || istype(A, /obj/item/ammo_casing))
		chamber_round()

	ammo_kind = /datum/ammo_kind/shotgun/q_40mm
	ammo_capacity = 1

//pump grenade launcher

/obj/item/gun/ballistic/shotgun/grenade
	name = "pump grenade launcher"
	desc = "A bulky but surprisingly lightweight grenade launcher with a stiff pump."
	icon = 'modular_coyote/icons/objects/ncrrangersguns.dmi'
	icon_state = "china_lake"
	item_state = "shotguntrench"
	mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	init_mag_type = /obj/item/ammo_box/magazine/internal/shot/grenade
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	weapon_weight = GUN_TWO_HAND_ONLY
	damage_multiplier = GUN_EXTRA_DAMAGE_0

	can_bayonet = FALSE
	init_firemodes = list(
		/datum/firemode/semi_auto/slower
	)

	ammo_kind = /datum/ammo_kind/shotgun/q_40mm
	ammo_capacity = 3

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg
	desc = "A 6-shot grenade launcher."
	name = "multi grenade launcher"
	icon = 'icons/mecha/mecha_equipment.dmi'
	icon_state = "mecha_grenadelnchr"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/grenademulti
	pin = /obj/item/firing_pin

/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg/attack_self()
	return

/obj/item/gun/ballistic/automatic/gyropistol
	name = "gyrojet pistol"
	desc = "A prototype pistol designed to fire self propelled rockets."
	icon_state = "gyropistol"
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	weapon_class = WEAPON_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/m75
	init_mag_type = /obj/item/ammo_box/magazine/m75
	actions_types = list()
	casing_ejector = FALSE

/obj/item/gun/ballistic/automatic/gyropistol/update_icon_state()
	icon_state = "[initial(icon_state)][magazine ? "loaded" : ""]"

/obj/item/gun/ballistic/automatic/speargun
	name = "kinetic speargun"
	desc = "A weapon favored by carp hunters. Fires specialized spears using kinetic energy."
	icon_state = "speargun"
	item_state = "speargun"
	weapon_class = WEAPON_CLASS_RIFLE
	can_suppress = FALSE
	mag_type = /obj/item/ammo_box/magazine/internal/speargun
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	actions_types = list()
	casing_ejector = FALSE

/obj/item/gun/ballistic/automatic/speargun/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_blocker)

/obj/item/gun/ballistic/automatic/speargun/attack_self()
	return

/obj/item/gun/ballistic/automatic/speargun/attackby(obj/item/A, mob/user, params)
	var/num_loaded = magazine.attackby(A, user, params, 1)
	if(num_loaded)
		to_chat(user, span_notice("You load [num_loaded] spear\s into \the [src]."))
		update_icon()
		chamber_round()

//yep~
/obj/item/gun/ballistic/fatman
	name = "fatman"
	desc =  "a man-portable launcher for tactical nuclear ordnance. what's not to love?"
	icon = 'modular_coyote/icons/objects/gun.dmi'
	icon_state = "fatman"
	item_state = "rocketlauncher" //not sure where it is or if this works. hopefully.
	mag_type = /obj/item/ammo_box/magazine/internal/mininuke
	fire_sound = 'sound/weapons/rocketlaunch.ogg'
	weapon_class = WEAPON_CLASS_HEAVY
	can_suppress = FALSE
	slowdown = 1
	projectile_speed_multiplier = 0.4 //run
	casing_ejector = FALSE
	weapon_weight = GUN_TWO_HAND_ONLY
	magazine_wording = "mininuke"

/obj/item/gun/ballistic/fatman/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]_empty" //civ13 used a different empty designator
	else
		icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/rocketlauncher
	name = "\improper rocket launcher"
	desc = "Technically, this is actually a rocket propelled grenade launcher, rather than a true rocket launcher. The person you shot is unlikely to care much, though."
	icon_state = "rocketlauncher"
	item_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/rocketlauncher
	fire_sound = 'sound/weapons/rocketlaunch.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	can_suppress = FALSE
	slowdown = 1
	casing_ejector = FALSE
	weapon_weight = GUN_TWO_HAND_ONLY
	magazine_wording = "rocket"

/obj/item/gun/ballistic/rocketlauncher/romket
	name = "\improper romckit launcher"
	desc = ""
	icon_state = "rocketlauncher"
	item_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/rocketlauncher
	fire_sound = 'sound/weapons/rocketlaunch.ogg'
	can_suppress = FALSE
	slowdown = 1
	projectile_speed_multiplier = 0.1
	damage_multiplier = GUN_LESS_DAMAGE_T2
	casing_ejector = FALSE
	weapon_weight = GUN_TWO_HAND_ONLY
	magazine_wording = "rocket"

/obj/item/storage/box/rocketlauncher_tox
	name = "romckit launcher kit"
	desc = "Contains a romckit launcher!"

/obj/item/storage/box/rocketlauncher_tox/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/rocketlauncher/romket(src)
	new /obj/item/ammo_casing/caseless/rocket(src)
	new /obj/item/ammo_casing/caseless/rocket(src)
	new /obj/item/ammo_casing/caseless/rocket(src)
	new /obj/item/ammo_casing/caseless/rocket(src)

/obj/item/gun/ballistic/rocketlauncher/handle_atom_del(atom/A)
	if(A == chambered)
		chambered = null
		if(!QDELETED(magazine))
			QDEL_NULL(magazine)
	if(A == magazine)
		magazine = null
		if(!QDELETED(chambered))
			QDEL_NULL(chambered)
	update_icon()
	return ..()

/obj/item/gun/ballistic/rocketlauncher/can_shoot()
	return chambered?.BB

/obj/item/gun/ballistic/rocketlauncher/attack_self_tk(mob/user)
	return //too difficult to remove the rocket with TK

/obj/item/gun/ballistic/rocketlauncher/attack_self(mob/living/user)
	if(magazine)
		var/obj/item/ammo_casing/AC = chambered
		if(AC)
			if(!user.put_in_hands(AC))
				AC.bounce_away(FALSE, NONE)
			to_chat(user, span_notice("You remove \the [AC] from \the [src]!"))
			playsound(src, 'sound/weapons/gun_magazine_remove_full.ogg', 70, TRUE)
			chambered = null
		else
			to_chat(user, span_notice("There's no [magazine_wording] in [src]."))
	update_icon()

/obj/item/gun/ballistic/rocketlauncher/attackby(obj/item/A, mob/user, params)
	if(magazine && istype(A, /obj/item/ammo_casing))
		if(chambered)
			to_chat(user, span_notice("[src] already has a [magazine_wording] chambered."))
			return
		if(magazine.attackby(A, user, silent = TRUE))
			to_chat(user, span_notice("You load a new [A] into \the [src]."))
			playsound(src, "gun_insert_full_magazine", 70, 1)
			chamber_round()
			update_icon()

/obj/item/gun/ballistic/rocketlauncher/update_icon_state()
	icon_state = "[initial(icon_state)]-[chambered ? "1" : "0"]"

/obj/item/gun/ballistic/rocketlauncher/brick
	name = "\improper brick launcher"
	desc = "An old rocket launcher that has somehow been repurposed to fire bricks at high velocity."
	icon = 'icons/fallout/objects/guns/ballistic.dmi'
	icon_state = "launcher"
	item_state = "rocketlauncher"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/brick
	fire_sound = 'sound/weapons/rocketlaunch.ogg'
	weapon_class = WEAPON_CLASS_RIFLE
	can_suppress = FALSE
	burst_size = 1
	casing_ejector = FALSE
	weapon_weight = GUN_TWO_HAND_ONLY
	magazine_wording = "rocket"

/obj/item/gun/ballistic/rocketlauncher/brick/update_icon_state()
	if(!magazine || !get_ammo(TRUE, FALSE) || !chambered?.BB)
		icon_state = "[initial(icon_state)]-e"
	else
		icon_state = "[initial(icon_state)]"
