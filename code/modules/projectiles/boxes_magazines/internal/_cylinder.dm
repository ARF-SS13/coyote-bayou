/obj/item/ammo_box/magazine/internal/cylinder
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = list(CALIBER_357)
	max_ammo = 7
	replace_spent_rounds = 1

/obj/item/ammo_box/magazine/internal/cylinder/ammo_count(countempties = 1)
	var/boolets = 0
	for(var/obj/item/ammo_casing/bullet in stored_ammo)
		if(bullet && (bullet.BB || countempties))
			boolets++
	return boolets

/obj/item/ammo_box/magazine/internal/cylinder/fill_magazine(num_bullets)
	if(LAZYLEN(stored_ammo))
		QDEL_LIST(stored_ammo)
	LAZYLENGTHEN(stored_ammo, max_ammo)
	num_bullets = clamp(num_bullets, 0, LAZYLEN(stored_ammo))
	for(var/i in 1 to LAZYLEN(stored_ammo))
		var/be_spent = FALSE
		if(i > num_bullets)
			be_spent = TRUE
		var/bluuet = new ammo_type(src, be_spent)
		LAZYSET(stored_ammo, i, bluuet)

/obj/item/ammo_box/magazine/internal/cylinder/get_round(keep = 0)
	rotate()
	var/b = LAZYACCESS(stored_ammo, 1)
	if(!keep)
		stored_ammo[1] = null
	return b

/obj/item/ammo_box/magazine/internal/cylinder/proc/rotate()
	var/b = stored_ammo[1]
	stored_ammo.Cut(1,2)
	stored_ammo.Insert(0, b)

/obj/item/ammo_box/magazine/internal/cylinder/proc/spin()
	for(var/i in 1 to rand(0, max_ammo*2))
		rotate()

/* /obj/item/ammo_box/magazine/internal/cylinder/give_round(obj/item/ammo_casing/R, replace_spent = 0)
	if(!R || (caliber && R.caliber != caliber) || (!caliber && R.type != ammo_type))
		return FALSE

	for(var/i in 1 to stored_ammo.len)
		var/obj/item/ammo_casing/bullet = stored_ammo[i]
		if(!bullet || !bullet.BB) // found a spent ammo
			stored_ammo[i] = R
			R.forceMove(src)

			if(bullet)
				bullet.forceMove(get_turf(src.loc))
			return TRUE

	return FALSE
 */
