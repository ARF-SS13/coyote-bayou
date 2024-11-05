// -------------- Sickshot -------------
/obj/item/gun/energy/sickshot
	name = "\improper MPA6 \'Sickshot\'"
	desc = "A device that can trigger convusions in specific areas to eject foreign material from a host. Must be used very close to a target. Not for Combat usage."

	icon_state = "dragnet"
	inhand_icon_state = "dragnet"
	ammo_x_offset = 1
	ammo_type = list(/obj/item/ammo_casing/energy/sickshot)

/obj/item/ammo_casing/energy/sickshot
	projectile_type = /obj/item/projectile/sickshot
	e_cost = 100

//Projectile
/obj/item/projectile/sickshot
	name = "sickshot pulse"
	icon_state = "e_netting"
	damage = 0
	damage_type = STAMINA
	range = 2

/obj/item/projectile/sickshot/on_hit(atom/movable/target, blocked = 0)
	. = ..()
	if(isliving(target) && prob(5))
		SEND_SIGNAL(target, COMSIG_VORE_EXPEL_ALL, TRUE, TRUE)
		target.visible_message(span_danger("[target] contracts strangely, spewing out contents on the floor!"), \
				span_userdanger("You spew out everything inside you on the floor!"),
				pref_check = VOREPREF_VORE_MESSAGES)
	return BULLET_ACT_HIT
