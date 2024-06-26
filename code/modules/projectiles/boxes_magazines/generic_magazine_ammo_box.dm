
/obj/item/ammo_box/generic
	name = "uninitialized ambiguous generic ammo box"
	desc = "This ammo box can contain all sorts of stuff! It's a mystery!"
	caliber = list(CALIBER_COMPACT)
	ammo_type = /obj/item/ammo_casing/generic/compact // will NOT be overwritten by the ammo_kind
	start_empty = TRUE // the base one is spawned by vendors, which will be filled by the ammo_kind
	randomize_ammo_count = FALSE // the base one is spawned by vendors, which will be filled by the ammo_kind
	var/wildspawned = FALSE // if it's wildspawned, it will be filled by the ammo_kind
	var/datum/ammo_kind/ammo_kind = /datum/ammo_kind/compact
	var/box_CorB = CORB_BOX
	var/rawname = ""

/obj/item/ammo_box/generic/Initialize(mapload, ...)
	if(wildspawned)
		SScmls.RandomizeBox(src)
	. = ..()

/obj/item/ammo_box/generic/AltClick(mob/user)
	. = ..()
	SScmls.ReskinBox(user, src)

/obj/item/ammo_box/generic/CtrlShiftClick(mob/user)
	. = ..()
	SScmls.ReskinBox(user, src)

/obj/item/ammo_box/generic/pop_casing(mob/user, to_ground, silent)
	. = ..()
	if(istype(., /obj/item/ammo_casing/generic))
		SScmls.SkinBullet(., ammo_kind, TRUE)

/obj/item/ammo_box/generic/insert_round(obj/item/ammo_casing/other_casing, index)
	. = ..()
	if(istype(., /obj/item/ammo_casing/generic))
		SScmls.SkinBullet(., ammo_kind, TRUE)

/obj/item/ammo_box/generic/update_icon_state()
	. = ..()
	SScmls.SkinBox(src, ammo_kind, FALSE)

/obj/item/ammo_box/generic/examine(mob/user)
	. = ..()
	var/datum/ammo_kind/ACK = SScmls.GetAmmoKind(ammo_kind)
	. += span_notice("Currently converting any [LAZYACCESS(caliber, 1)] into [ACK.GetBulletName()]")
	. += span_notice("ALT click or CTRL+SHIFT click to change the what kind of [LAZYACCESS(caliber, 1)] it will convert!")

/obj/item/ammo_box/generic/post_process_ammo(bluuet)
	if(!istype(bluuet, /obj/item/ammo_casing/generic))
		return
	SScmls.SetupBullet(bluuet, ammo_kind)

/obj/item/ammo_box/generic/proc/PrepForGun(obj/item/gun/ballistic/gun)
	if(!istype(gun, /obj/item/gun/ballistic))
		return
	SetGunName(gun)
	max_ammo = gun.ammo_capacity || 1
	multiload = !gun.ammo_single_load || TRUE
	replace_spent_rounds = gun.is_revolver || FALSE
	gun.magazine = src

/obj/item/ammo_box/generic/proc/SetGunName(obj/item/gun/ballistic/gun)
	rawname = istext(gun.ammo_magazine_name) ? gun.ammo_magazine_name : "[gun.name]" // you reload your Shoot Gun with 5.23x45mm bullets
	rawname = replacetext(rawname, MAG_TOKEN_MAX_AMMO, "[max_ammo]")

/// takes the ammo from the source and puts it into the box
/obj/item/ammo_box/generic/proc/LoadFromSource(obj/item/ammo_box/generic/source)
	load_from_box(source, null, TRUE)

/// creates a magazine version of the ammo box, as a metamagazine!!!
/obj/item/ammo_box/generic/proc/MagazineifyFrom(obj/item/ammo_box/generic/source)
	caliber              = source.caliber
	ammo_type            = source.ammo_type
	ammo_kind            = source.ammo_kind
	name                 = source.name
	desc                 = source.desc
	max_ammo             = source.max_ammo
	multiload            = source.multiload
	replace_spent_rounds = source.replace_spent_rounds
	start_empty          = TRUE
	box_CorB = CORB_MAGAZINE





/// This is the basic Crate, to be turned into the big ammo container of your choice
/obj/item/ammo_box/generic/crate
	box_CorB = CORB_CRATE

/// This is what'll go inside generified guns, to have ammo put into us
/obj/item/ammo_box/generic/internal
	fixed_mag = TRUE

/obj/item/ammo_box/generic/magazine
	start_empty = TRUE


