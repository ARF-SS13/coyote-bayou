
/datum/ammo_kind/long
	name = "long"
	bullet_flavor = "A long bullet. It's a bullet with a long body and an equally long history. The Long Bullet was originally a handy carrying \
		case for several Compact Bullets, put together as a clever way to recycle old worn out bullets without violating the 79th Amendment. \
		Partway through the Gecko Wars, a wayward enchanted Gecko ballista shell struck an ammo cart full of Compact Bullets, and in the blast \
		melted them all together into several Long Bullets. Now, they didnt have guns that would accept these new Long Bullets, but their \
		heavy, aerodynamic design made them more than a replacement for Ashdown's Tactical Rock Stockpile, and so the Long Bullet was born. \
		Shortly after, the 79th Amendment was repealed, allowing for Long Bullets to actually be used in guns."
	casing_kind = "cartridge"
	projectile_kind = "slug"
	box_name = "long bullet box"
	box_flavor = "A box of really large bullets. Big, high powered, and perfect to rip through even the toughest of mutants with a single shot. \
		Their size and weight make them a bit impractical to carry lots of, but when you need to make a big hole, there's no better choice."
	crate_name = "long bullet crate"
	crate_flavor = "A high-capacity crate of Long Bullets. Big, heavy, and perfect for when you need to make a big hole in a lot of things. \
		While it does hold a lot more bullets than a box, it's still a bit impractical for anything other than against the toughest of mutants."
	magazine_name = "long bullet magazine"
	magazine_flavor = "A magazine of Long Bullets. Big, high powered, and perfect to rip through even the toughest of mutants with a single shot. \
		Their size and weight make them a bit impractical to carry lots of, but when you need to make a big hole, there's no better choice."
	caliber = CALIBER_LONG
	sound_properties = CSP_RIFLE_HEAVY
	ammo_icon = 'icons/obj/ammo/long.dmi'
	damage_list = list(
		"50" = 40,
		"75" = 10,
		"1" = 1,
		"1000" = 1,
	)

/datum/ammo_kind/long/q_30_06_springfield
	name = ".30-06 Springfield"
	bullet_flavor = "A .30-06 Springfield bullet. A classic bullet found in the hands of hunters, soldiers, and the occasional madman. The .30-06 \
		Springfield refers to the date it was designed, Springfield 30th, 6, a good year for high power, low drag bullets. Few can resist the \
		temptation of the .30-06 Springfield, a bullet that has been used to take down everything from deer to tanks."
	box_name = "box of .30-06 Springfield bullets"
	crate_name = "crate of .30-06 Springfield bullets"
	magazine_name = ".30-06 Springfield magazine"
	magazine_flavor = "A magazine of .30-06 Springfield bullets. Big, high powered, and perfect to rip through even the toughest of mutants with a single shot. \
		Their size and weight make them a bit impractical to carry lots of, but when you need to make a big hole, there's no better choice."
	ammo_icon = 'icons/obj/ammo/long.dmi'

