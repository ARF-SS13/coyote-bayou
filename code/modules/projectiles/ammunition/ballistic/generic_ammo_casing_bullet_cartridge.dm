/obj/item/ammo_casing/generic
	caliber = CALIBER_COMPACT
	var/datum/ammo_kind/ammo_kind = /datum/ammo_kind/compact

/obj/item/ammo_casing/generic/Initialize(mapload, ...)
	. = ..()
	SSCMLS.SetupBullet(src, ammo_kind)

/obj/item/ammo_casing/generic/AltClick(mob/user)
	. = ..()
	SSCMLS.ReskinBullet(user, src)

/obj/item/ammo_casing/generic/CtrlShiftClick(mob/user)
	. = ..()
	SSCMLS.ReskinBullet(user, src)

/obj/item/ammo_casing/generic/examine(mob/user)
	. = ..()
	var/datum/ammo_kind/ACK = SSCMLS.GetAmmoKind(ammo_kind)
	. += span_notice("Currently converting any [LAZYACCESS(calibers, 1)] into [ACK.GetBulletName()]")
	. += span_notice("ALT click or CTRL+SHIFT click to change the what kind of [LAZYACCESS(calibers, 1)] it will convert!")

/obj/item/ammo_casing/generic/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", damage_multiplier = 1, penetration_multiplier = 1, projectile_speed_multiplier = 1, fired_from, damage_threshold_penetration = 0)
	if(istype(loc, /obj/item/ammo_box/generic))
		var/obj/item/ammo_box/generic/box = loc
		if(ammo_kind != box.ammo_kind)
			SSCMLS.SetupBullet(src, box.ammo_kind)
	. = ..()





