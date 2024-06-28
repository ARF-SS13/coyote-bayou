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
		"30" = 60,
		"45" = 30,
		"60" = 9,
		"200" = 1
	)

// Example

/*
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
	ammo_icon = 'icons/obj/ammo/compact.dmi' // this is an example please ignore
*/
/datum/ammo_kind/compact/q_22lr
	name = ".22 Long Rifle"
	bullet_flavor = "The .22 Long Rifle, also known as the .22LR or 5.6×15mmR, is a long-established variety of .22 caliber rimfire ammunition originating from the United States."
	box_name = "box of .22LR bullets"
	crate_name = "crate of .22LR bullets"
	magazine_name = ".22LR magazine"
	magazine_flavor = "A magazine fitting .22LR bullets."
	sound_properties = CSP_PISTOL_22

/datum/ammo_kind/compact/q_357
	name = ".357 Magnum"
	bullet_flavor = "The .357 Magnum, .357 S&W Magnum, or 9×33mmR (as it is known in unofficial metric designation) is a smokeless powder cartridge with a 0.357 in (9.07 mm) bullet diameter. It was created by Smith & Wesson and Winchester."
	box_name = "box of .357 Magnum bullets"
	crate_name = "crate of .357 Magnum bullets"
	magazine_name = ".357 Magnum magazine"
	magazine_flavor = "A magazine fitting .357 Magnum bullets."
	sound_properties = CSP_PISTOL_357

/datum/ammo_kind/compact/q_9mm
	name = "9x19mm Parabellum"
	bullet_flavor = "Originally designed by Austrian firearm designer Georg Luger in 1901, it is widely considered the most popular handgun and submachine gun cartridge due to its low cost, adequate stopping power and extensive availability."
	box_name = "box of 9x19mm Parabellum bullets"
	crate_name = "crate of 9x19mm Parabellum bullets"
	magazine_name = "9x19mm Parabellum magazine"
	magazine_flavor = "A magazine fitting 9x19mm Parabellum bullets."
	sound_properties = CSP_PISTOL_9MM

/datum/ammo_kind/compact/q_10mm
	name = ".40 S&W"
	bullet_flavor = "The .40 S&W (10.2×22mm) is a rimless pistol cartridge developed jointly by Smith & Wesson and Winchester in 1990. It was developed as a law enforcement cartridge designed to duplicate performance of the Federal Bureau of Investigation's (FBI) reduced-velocity 10mm Auto cartridge which could be retrofitted into medium-frame (9 mm size) semi-automatic handguns."
	box_name = "box of .40 S&W bullets"
	crate_name = "crate of .40 S&W bullets"
	magazine_name = ".40 S&W magazine"
	magazine_flavor = "A magazine fitting .40 S&W bullets."
	sound_properties = CSP_PISTOL_10MM

/datum/ammo_kind/compact/q_45
	name = ".45 ACP"
	bullet_flavor = "The .45 ACP (Automatic Colt Pistol), also known as .45 Auto, .45 Automatic, or 11.43×23mm is a rimless straight-walled handgun cartridge designed by John Moses Browning in 1904, for use in his prototype Colt semi-automatic pistol."
	box_name = "box of .45 ACP bullets"
	crate_name = "crate of .45 ACP bullets"
	magazine_name = ".45 ACP magazine"
	magazine_flavor = "A magazine fitting .45 ACP bullets."
	sound_properties = CSP_PISTOL_45

/datum/ammo_kind/compact/q_45lc
	name = ".45 LC"
	bullet_flavor = "The .45 Colt (11.43×33mmR), is a rimmed, straight-walled, handgun cartridge dating to 1872. It was originally a black-powder revolver round developed for the Colt Single Action Army revolver."
	box_name = "box of .45 LC bullets"
	crate_name = "crate of .45 LC bullets"
	magazine_name = ".45 LC magazine"
	magazine_flavor = "A magazine fitting .45 LC bullets."
	sound_properties = CSP_PISTOL_45

/datum/ammo_kind/compact/q_needler
	name = "10mm Needle"
	bullet_flavor = "A strange, futuristic looking needle for use in strange and futuristic looking guns."
	box_name = "capsule of 10mm Needles"
	crate_name = "barrel of 10mm Needles"
	magazine_name = "10mm Needle magazine"
	magazine_flavor = "A magazine fitting 10mm Needles."
