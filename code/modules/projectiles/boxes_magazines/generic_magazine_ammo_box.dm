
/obj/item/ammo_box/generic
	name = "uninitialized ambiguous generic ammo box"
	desc = "This ammo box can contain all sorts of stuff! It's a mystery!"
	caliber = list(CALIBER_COMPACT)
	ammo_type = /obj/item/ammo_casing/generic/compact // will NOT be overwritten by the ammo_kind
	start_empty = TRUE // the base one is spawned by vendors, which will be filled by the ammo_kind
	var/datum/ammo_kind/ammo_kind = /datum/ammo_kind/compact
	var/box_or_crate = AMMOBOX_IS_BOX
	var/cylinder = FALSE // clender

/obj/item/ammo_box/generic/Initialize(mapload, ...)
	SSCMLS.SetupBox(src, ammo_type)
	. = ..()

/obj/item/ammo_box/generic/AltClick(mob/user)
	. = ..()
	SSCMLS.ReskinBox(user, src)

/obj/item/ammo_box/generic/CtrlShiftClick(mob/user)
	. = ..()
	SSCMLS.ReskinBox(user, src)

/obj/item/ammo_box/generic/pop_casing(mob/user, to_ground, silent)
	. = ..()
	if(istype(., /obj/item/ammo_casing/generic))
		SSCMLS.SkinBullet(., ammo_kind)

/obj/item/ammo_box/generic/insert_round(obj/item/ammo_casing/other_casing, index)
	. = ..()
	if(istype(., /obj/item/ammo_casing/generic))
		SSCMLS.SkinBullet(., ammo_kind)

/obj/item/ammo_box/generic/update_icon_state()
	. = ..()
	SSCMLS.SkinBox(src, ammo_kind, FALSE)

/obj/item/ammo_box/generic/examine(mob/user)
	. = ..()
	var/datum/ammo_kind/ACK = SSCMLS.GetAmmoKind(ammo_kind)
	. += span_notice("Currently converting any [LAZYACCESS(calibers, 1)] into [ACK.GetBulletName()]")
	. += span_notice("ALT click or CTRL+SHIFT click to change the what kind of [LAZYACCESS(calibers, 1)] it will convert!")

/obj/item/ammo_box/generic/post_process_ammo(bluuet)
	if(!istype(bluuet, /obj/item/ammo_casing/generic))
		return
	SSCMLS.SetupBullet(bluuet, ammo_kind)
