SUBSYSTEM_DEF(cmls)
	name = "CMLS"
	flags = SS_BACKGROUND|SS_NO_FIRE
	init_order = INIT_ORDER_CMLS

	var/num_ammo_states = 0

	var/list/ammos = list()
	var/list/ammodesigns = list()
	var/list/design_cats = list()

	var/list/all_C_box = list()
	var/list/all_C_crate = list()
	var/list/all_C_bullet = list()

	var/list/all_M_box = list()
	var/list/all_M_crate = list()
	var/list/all_M_bullet = list()

	var/list/all_L_box = list()
	var/list/all_L_crate = list()
	var/list/all_L_bullet = list()

	var/list/all_S_box = list()
	var/list/all_S_crate = list()
	var/list/all_S_bullet = list()

	var/list/data_for_tgui = list()
	var/list/tgui_cats = list()
	var/list/tgui_full_cats = list()

	var/compact_ammo_per_box = 60
	var/compact_ammo_price_per_box = 10
	var/compact_ammo_per_crate = 600
	var/compact_ammo_price_per_crate = 100

	var/medium_ammo_per_box = 30
	var/medium_ammo_price_per_box = 15
	var/medium_ammo_per_crate = 300
	var/medium_ammo_price_per_crate = 150

	var/long_ammo_per_box = 20
	var/long_ammo_price_per_box = 20
	var/long_ammo_per_crate = 200
	var/long_ammo_price_per_crate = 200

	var/shotgun_ammo_per_box = 12
	var/shotgun_ammo_price_per_box = 24
	var/shotgun_ammo_per_crate = 120
	var/shotgun_ammo_price_per_crate = 240

/datum/controller/subsystem/cmls/Initialize(start_timeofday)
	InitGunNerdStuff()
	. = ..()
	to_chat(world, span_boldnotice("Initialized [LAZYLEN(ammos)] different ammo kinds! 🔫🐈"))

/datum/controller/subsystem/cmls/proc/InitGunNerdStuff()
	if(LAZYLEN(ammos))
		return // already done
	ammos = list()
	for(var/flt in subtypesof(/datum/ammo_kind))
		new flt() // it knows what its do

/datum/controller/subsystem/cmls/proc/GetAmmoTypeDesigns()
	if(!LAZYLEN(ammodesigns))
		InitGunNerdStuff()
	return ammodesigns

/datum/controller/subsystem/cmls/proc/ExtractCORB(txt)
	switch(lowertext(txt))
		if(CORB_BULLET)
			return CORB_BULLET
		if(CORB_BOX)
			return CORB_BOX
		if(CORB_CRATE)
			return CORB_CRATE
		if(CORB_MAGAZINE)
			return CORB_MAGAZINE

///////////////////////////MAGAZINES///////////////////////////
/datum/controller/subsystem/cmls/proc/SetupMagazine(obj/item/ammo_box/generic/magazine/ABM, kind, obj/item/ammo_box/generic/magazine/source)
	if(!istype(ABM))
		return
	if(!kind)
		kind = ABM.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSetupMagazine(ABM, source)

/datum/controller/subsystem/cmls/proc/SkinMagazine(obj/item/ammo_casing/generic/ABM, kind, soft)
	if(!istype(ABM))
		return
	if(!kind)
		kind = ABM.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSkinBox(ABM, soft)

/datum/controller/subsystem/cmls/proc/UpdateMagazine(obj/item/ammo_casing/generic/ABM)
	if(!istype(ABM))
		return
	var/datum/ammo_kind/ammou = GetAmmoKind(ABM.ammo_kind)
	if(!ammou)
		return
	ammou.AKUpdateBox(ABM)

///////////////////////////BULLETS///////////////////////////
/datum/controller/subsystem/cmls/proc/SetupBullet(obj/item/ammo_casing/generic/AC, kind)
	if(!istype(AC))
		return
	if(!kind)
		kind = AC.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSetupBullet(AC)

/datum/controller/subsystem/cmls/proc/SkinBullet(obj/item/ammo_casing/generic/AC, kind, soft)
	if(!istype(AC))
		return
	if(!kind)
		kind = AC.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSkinBullet(AC, soft)

/datum/controller/subsystem/cmls/proc/UpdateBullet(obj/item/ammo_casing/generic/AC)
	if(!istype(AC))
		return
	var/datum/ammo_kind/ammou = GetAmmoKind(AC.ammo_kind)
	if(!ammou)
		return
	ammou.AKUpdateBullet(AC)

///////////////////////////BOXES///////////////////////////
/datum/controller/subsystem/cmls/proc/SetupBox(obj/item/ammo_box/generic/mag, kind, CorB = CORB_BOX, gunthing = null)
	if(!istype(mag))
		return
	if(!kind)
		kind = mag.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSetupBox(mag, CorB, gunthing)

/datum/controller/subsystem/cmls/proc/SkinBox(obj/item/ammo_box/generic/mag, kind, bullets_too, CorB = CORB_BOX)
	if(!istype(mag))
		return
	if(!kind)
		kind = mag.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	ammou.AKSkinBox(mag, CorB, bullets_too)

/datum/controller/subsystem/cmls/proc/UpdateBox(obj/item/ammo_box/generic/mag, CorB = CORB_BOX)
	if(!istype(mag))
		return
	var/datum/ammo_kind/ammou = GetAmmoKind(mag.ammo_kind)
	if(!ammou)
		return
	ammou.AKUpdateBox(mag, CorB)

///////////////////////////GUNS///////////////////////////
/// Makes a CMLS magazine for the gun, with specified vars
/datum/controller/subsystem/cmls/proc/SetupGun(obj/item/gun/ballistic/gun, kind)
	if(!istype(gun))
		return
	if(!GunCanCMLS(gun))
		return
	if(!kind)
		kind = gun.ammo_kind
	var/datum/ammo_kind/ammou = GetAmmoKind(kind)
	if(!ammou)
		return
	var/obj/item/ammo_box/generic/internal/mag = new(gun)
	SetupBox(mag, kind, gunthing = gun)

/datum/controller/subsystem/cmls/proc/GunCanCMLS(obj/item/gun/ballistic/gun)
	if(!istype(gun))
		return FALSE
	/// check if it has any of its damage vars set up, gotta have at least one!
	var/can_haz_dmg = FALSE
	if(!isnull(gun.damage))
		can_haz_dmg = TRUE
	else if(LAZYLEN(gun.damage_list))
		can_haz_dmg = TRUE
	else if(!isnull(gun.damage_low) && !isnull(gun.damage_high))
		can_haz_dmg = TRUE
	if(!can_haz_dmg)
		return FALSE // CMLS ammo inherently doesnt do damage, I think, probably
	/// check if it has a valid ammo kind
	var/datum/ammo_kind/ammou = GetAmmoKind(gun.ammo_kind)
	if(!istype(ammou))
		return FALSE
	return TRUE // should work

///////////////////////////RESKINS///////////////////////////
/// attempts to have the user transform a bullet into a different kind of bullet of the same CMLS type
/// brings up a dialog for the user to select a new bullet kind
/datum/controller/subsystem/cmls/proc/ReskinBullet(mob/user, obj/item/ammo_casing/generic/AC)
	if(!user)
		return
	if(!istype(AC))
		to_chat(user, span_alert("That's not a kind of bullet you can reskin!"))
		return
	var/datum/ammo_kind/curr_ammou = GetAmmoKind(AC.ammo_kind)
	if(!curr_ammou)
		to_chat(user, span_alert("That bullet doesn't have a valid ammo kind!"))
		return
	var/list/prechoices
	switch(AC.caliber)
		if(CALIBER_COMPACT)
			prechoices = all_C_bullet.Copy()
		if(CALIBER_MEDIUM)
			prechoices = all_M_bullet.Copy()
		if(CALIBER_LONG)
			prechoices = all_L_bullet.Copy()
		if(CALIBER_SHOTGUN)
			prechoices = all_S_bullet.Copy()
		else
			to_chat(user, span_alert("That bullet doesn't have a valid CMLS type!"))
			return
	if(!LAZYLEN(prechoices))
		to_chat(user, span_alert("There are no other bullet types to choose from!"))
		return
	var/list/pre_prechoices = list()
	for(var/ammokind in prechoices)
		if(!ispath(ammokind, /datum/ammo_kind))
			continue
		var/datum/ammo_kind/ammou = prechoices[ammokind]
		if(!istype(ammou))
			continue
		pre_prechoices["[ammou.name]"] = ammou.type
	var/mychoose = tgui_input_list(
		user,
		"Choose a new flavor for your bullet!",
		"Pick a [AC.caliber] bullet",
		pre_prechoices
		)
	if(!mychoose)
		to_chat(user, span_alert("Never mind!!"))
		return
	var/datum/ammo_kind/ammouback = GetAmmoKind(pre_prechoices[mychoose])
	if(!istype(ammouback))
		to_chat(user, span_alert("That's not a valid choice!"))
		return
	to_chat(user, span_green("Your bullet is now \a [ammouback.name]!"))
	SkinBullet(AC, pre_prechoices[mychoose], TRUE)

/// attempts to have the user transform a box into a different kind of box of the same CMLS type
/// brings up a dialog for the user to select a new box kind
/datum/controller/subsystem/cmls/proc/ReskinBox(mob/user, obj/item/ammo_box/generic/mag)
	if(!user)
		return
	if(!istype(mag))
		to_chat(user, span_alert("That's not a kind of box you can reskin!"))
		return
	var/datum/ammo_kind/curr_ammou = GetAmmoKind(mag.ammo_kind)
	if(!curr_ammou)
		to_chat(user, span_alert("That box doesn't have a valid ammo kind!"))
		return
	var/CorB = ExtractCORB(mag.box_CorB || CORB_BOX)
	var/list/prechoices
	switch(curr_ammou.caliber)
		if(CALIBER_COMPACT)
			switch(CorB)
				if(CORB_BOX)
					prechoices = all_C_box.Copy()
				if(CORB_CRATE)
					prechoices = all_C_crate.Copy()
		if(CALIBER_MEDIUM)
			switch(CorB)
				if(CORB_BOX)
					prechoices = all_M_box.Copy()
				if(CORB_CRATE)
					prechoices = all_M_crate.Copy()
		if(CALIBER_LONG)
			switch(CorB)
				if(CORB_BOX)
					prechoices = all_L_box.Copy()
				if(CORB_CRATE)
					prechoices = all_L_crate.Copy()
		if(CALIBER_SHOTGUN)
			switch(CorB)
				if(CORB_BOX)
					prechoices = all_S_box.Copy()
				if(CORB_CRATE)
					prechoices = all_S_crate.Copy()
		else
			to_chat(user, span_alert("That box doesn't have a valid CMLS type!"))
			return
	if(!LAZYLEN(prechoices))
		to_chat(user, span_alert("There are no other box types to choose from!"))
		return
	var/list/pre_prechoices = list()
	for(var/ammokind in prechoices)
		if(!ispath(ammokind, /datum/ammo_kind))
			continue
		var/datum/ammo_kind/ammou = prechoices[ammokind]
		if(!istype(ammou))
			continue
		pre_prechoices["[ammou.name]"] = ammou.type
	var/mychoose = tgui_input_list(
		user,
		"Choose what your ammo box holds and converts any compatible ammo into!",
		"Pick a [mag.caliber] box",
		pre_prechoices
		)
	if(!mychoose)
		to_chat(user, span_alert("Never mind!!"))
		return
	var/datum/ammo_kind/ammouback = GetAmmoKind(pre_prechoices[mychoose])
	if(!istype(ammouback))
		to_chat(user, span_alert("That's not a valid choice!"))
		return
	to_chat(user, span_green("Your ammobox now holds (and will convert any compatible ammo) into \a [ammouback.name]!"))
	SkinBox(mag, pre_prechoices[mychoose], TRUE, CorB)

/datum/controller/subsystem/cmls/proc/RandomizeBox(obj/item/ammo_box/generic/mag)
	if(!istype(mag))
		return
	var/caliber = LAZYACCESS(mag.caliber, 1)
	var/CorB = ExtractCORB(mag.box_CorB || CORB_BOX)
	var/list/topickfrom
	switch(caliber)
		if(CALIBER_COMPACT)
			switch(CorB)
				if(CORB_BOX)
					topickfrom = SScmls.all_C_box
				if(CORB_CRATE)
					topickfrom = SScmls.all_C_crate
		if(CALIBER_MEDIUM)
			switch(CorB)
				if(CORB_BOX)
					topickfrom = SScmls.all_M_box
				if(CORB_CRATE)
					topickfrom = SScmls.all_M_crate
		if(CALIBER_LONG)
			switch(CorB)
				if(CORB_BOX)
					topickfrom = SScmls.all_L_box
				if(CORB_CRATE)
					topickfrom = SScmls.all_L_crate
		if(CALIBER_SHOTGUN)
			switch(CorB)
				if(CORB_BOX)
					topickfrom = SScmls.all_S_box
				if(CORB_CRATE)
					topickfrom = SScmls.all_S_crate
		else
			return
	SetupBox(mag, safepick(topickfrom))

/datum/controller/subsystem/cmls/proc/RandomizeBullet(obj/item/ammo_casing/generic/AC)
	if(!istype(AC))
		return
	var/caliber = LAZYACCESS(AC.caliber, 1)
	var/list/topickfrom
	switch(caliber)
		if(CALIBER_COMPACT)
			topickfrom = all_C_bullet
		if(CALIBER_MEDIUM)
			topickfrom = all_M_bullet
		if(CALIBER_LONG)
			topickfrom = all_L_bullet
		if(CALIBER_SHOTGUN)
			topickfrom = all_S_bullet
		else
			return
	SetupBullet(AC, safepick(topickfrom))

/datum/controller/subsystem/cmls/proc/GetAmmoKind(kind)
	var/datum/ammo_kind/ammou = LAZYACCESS(ammos, kind)
	if(!ammou)
		ammou = GetAmmokindByName(kind)
		if(!ammou)
			message_admins("Ammo kind [kind] not found!")
			CRASH("Ammo kind [kind] not found!")
	return ammou

/datum/controller/subsystem/cmls/proc/GetAmmokindByName(ammoname)
	for(var/datum/ammo_kind/ammou in ammos)
		if(ammou.name == ammoname)
			return ammou
	return null

/datum/controller/subsystem/cmls/proc/GetAmmokindByType(ammo_kind)
	for(var/datum/ammo_kind/ammou in ammos)
		if(istype(ammou, ammo_kind))
			return ammou
	return null

/// first checks if mag fits in gun, transfers ammo if it can, and vanishes if empty
/datum/controller/subsystem/cmls/proc/InsertCMLSmagIntoGun(mob/user, obj/item/gun/ballistic/gun, obj/item/ammo_box/generic/magazine/mag)
	if(!user || !istype(gun) || !istype(mag))
		return
	if(!gun.use_cmls)
		return
	/// dont really care about the gun, just its magazine
	var/obj/item/ammo_box/generic/internal/gunmag = gun.magazine
	if(!istype(gunmag))
		CRASH("CMLS Gun [gun] has no magazine!")
	/// start stuffing ammo from mag into gunmag
	for(var/obj/item/ammo_casing/AC in mag.stored_ammo)
		var/did_load = gunmag.give_round(AC, mag.replace_spent_rounds)
		if(did_load)
			mag.stored_ammo -= AC
			. ++
		if(!did_load || !gunmag.multiload)
			break
	if(.)
		// if mag ran out of bullets, cease to exist
		if(!LAZYLEN(mag.stored_ammo))
			to_chat(user, span_notice("You insert \the [mag] into \the [gun]!"))
			qdel(mag)
			playsound(user, gun.sound_magazine_insert, 60, 1)
		else
			to_chat(user, span_notice("You top off \the [gun] with [.] shell\s!"))
			playsound(user, 'sound/weapons/bulletinsert.ogg', 60, 1)
		if(!QDELETED(mag))
			mag.update_icon()
	if(!gun.chambered)
		gun.chamber_round()
		if(!gunmag.replace_spent_rounds)
			addtimer(CALLBACK(usr, GLOBAL_PROC_REF(playsound), gun, 'sound/weapons/gun_chamber_round.ogg', 100, 1), 3)
	mag.update_icon()
	gunmag.update_icon()
	gun.update_icon()
	return TRUE

/// if the gun has ammo, spawn a mag with that ammo and fill it with the ammo
/datum/controller/subsystem/cmls/proc/EjectCMLSmagFromGun(mob/user, obj/item/gun/ballistic/gun)
	if(!user || !istype(gun))
		return
	if(!gun.use_cmls)
		return
	var/obj/item/ammo_box/generic/internal/gunmag = gun.magazine
	if(!istype(gunmag))
		CRASH("CMLS Gun [gun] has no magazine!")
	if(!gunmag.ammo_count(TRUE))
		to_chat(user, span_alert("The [gun] is empty!"))
		return
	if(!gun.casing_ejector) // bolties
		if(gun.is_revolver)
			gun.eject_shells(user, TRUE)
		else if(gun.chambered)
			gun.pump(user)
		gun.update_icon()
		return // easy
	/// okay now we gotta do the hard part
	var/datum/ammo_kind/gun_AK = GetAmmoKind(gunmag.ammo_kind)
	if(!gun_AK)
		CRASH("CMLS Gun [gun] has no valid ammo kind!")
	var/obj/item/ammo_box/generic/magazine/mag = new(get_turf(src))
	SetupMagazine(mag, gunmag.ammo_kind, gunmag)
	to_chat(user, span_notice("You eject \the [gunmag] from \the [gun]!"))
	playsound(user, gun.sound_magazine_eject, 60, 1)
	mag.update_icon()
	gunmag.update_icon()
	gun.update_icon()
	user.put_in_hands(mag)
	return mag




