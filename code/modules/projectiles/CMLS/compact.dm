/datum/ammo_kind/compact
	name = "compact"
	bullet_flavor = "A small, compact bullet. It's small, it's compact, and it's a bullet. Back in 2235, the Compact Bullet was designed by \
		Dr. Compact, hero of the Compact Wars, to be the most compact bullet in the galaxy. The sheer compactness of its load complemented \
		its compact design, and it was called the Compact Bullet."
	casing_kind = "bullet"
	projectile_kind = "bullet"
	box_name = "box of compact bullets"
	box_flavor = "A box of small bullets designed for small guns. Low damage and high capacity, compact bullets are the perfect choice for \
		those who like to shoot a lot of bullets."
	crate_name = "crate of compact bullets"
	crate_flavor = "A high-capacity crate of small bullets designed for small guns. Holds an absurd amount of bullets, which is good, because \
		compact bullets aren't as powerful as their larger counterparts."
	magazine_name = "compact magazine"
	magazine_flavor = "A small magazine designed for small guns. Holds compact bullets, which are small and compact. The compact magazine is the \
		perfect choice for those who like to shoot a lot of bullets."
	caliber = CALIBER_COMPACT
	sound_properties = CSP_PISTOL_LIGHT
	ammo_icon = 'icons/obj/ammo/compact.dmi'
	damage_list = list(
		"30" = 30,
		"35" = 10,
		"40" = 1,
		"200" = 1,
	)

/datum/ammo_kind/compact/q_9x19mm
	name = "9x19mm Parabellum"
	bullet_flavor = "A 9x19mm Parabellum bullet. It's a bullet, and it's 9x19mm. The 9x19mm Parabellum was designed in 1902 by Georg Luger, \
		who was a big fan of the number 9 and the number 1. He combined them into the famed 9x19mm Parabellum, named after his daughter, \
		Parabellum Luger. Often chastized for its lack of stopping power and unlucky number, the 9x19mm Parabellum is still a popular choice \
		for those who like the number 9 and 1."
	box_name = "box of 9x19mm Parabellum bullets"
	crate_name = "crate of 9x19mm Parabellum bullets"
	magazine_name = "9x19mm Parabellum magazine"
	magazine_flavor = "A small magazine designed for small guns. Holds compact bullets, which are small and compact. The compact magazine is the \
		perfect choice for those who like to shoot a lot of bullets."
	caliber = CALIBER_COMPACT
	sound_properties = CSP_PISTOL_9MM
	ammo_icon = 'icons/obj/ammo/compact.dmi'



