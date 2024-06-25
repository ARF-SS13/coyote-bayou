/obj/item/ammo_casing/generic
	projectile_type = /obj/item/projectile/generic
	caliber = CALIBER_COMPACT
	var/datum/ammo_kind/ammo_kind = /datum/ammo_kind/compact

/obj/item/ammo_casing/generic/Initialize(mapload, ...)
	. = ..()
	SScmls.SetupBullet(src, ammo_kind)

/obj/item/ammo_casing/generic/AltClick(mob/user)
	. = ..()
	SScmls.ReskinBullet(user, src)

/obj/item/ammo_casing/generic/CtrlShiftClick(mob/user)
	. = ..()
	SScmls.ReskinBullet(user, src)

/obj/item/ammo_casing/generic/examine(mob/user)
	. = ..()

// /obj/item/ammo_casing/generic/ready_proj(atom/target, mob/living/user, quiet, zone_override = "", damage_multiplier = 1, penetration_multiplier = 1, projectile_speed_multiplier = 1, fired_from, damage_threshold_penetration = 0)
// 	if(istype(loc, /obj/item/ammo_box/generic))
// 		var/obj/item/ammo_box/generic/box = loc
// 		if(ammo_kind != box.ammo_kind)
// 			SScmls.SetupBullet(src, box.ammo_kind)
// 	. = ..()

/obj/item/ammo_casing/generic/update_icon_state()
	SScmls.UpdateBullet(src, ammo_kind)




