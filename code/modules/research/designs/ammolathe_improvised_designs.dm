/datum/design/ammolathe/improvised
	build_type = AMMOLATHE_HOBO

/* 
 * Ammolathe, but shit
 */

//materials
/datum/design/ammolathe/improvised/metalplate
	name = "Metal"
	id = "handloader_metalplate"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/stack/sheet/metal
	category = list("initial", "Materials")
	maxstack = 50

/datum/design/ammolathe/improvised/blackpowder
	name = "Blackpowder"
	id = "handloader_blackpowder"
	materials = list(/datum/material/blackpowder = 2000)
	build_path = /obj/item/stack/ore/blackpowder
	category = list("initial", "Materials")
	maxstack = 50

//////////
/// MAGS!

/datum/design/ammolathe/improvised/pistol22mag
	name = "empty pistol magazine (.22lr)"
	id = "handloader_pistol22mag"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/m22/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/m9mm
	name = "empty 9mm pistol magazine (9mm)"
	id = "handloader_m9mm"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_box/magazine/m9mm/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/m10mm
	name = "empty 10mm pistol magazine (10mm)"
	id = "handloader_m10mm_adv"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_box/magazine/m10mm/adv/simple/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/m45
	name = "empty handgun magazine (.45)"
	id = "handloader_m45"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_box/magazine/m45/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/speedloader38
	name = "empty speed loader (.38)"
	id = "handloader_speedloader38"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_box/c38/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/speedloader44
	name = "empty speed loader (.44)"
	id = "handloader_speedloader44"
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_box/m44/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/speedloader4570
	name = "empty speed loader (.45-70)"
	id = "handloader_speedloader4570"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/c4570/empty
	category = list("initial", "Handmade Magazines")
	
/datum/design/ammolathe/improvised/m556_rifle_small
	name = "empty small rifle magazine (5.56mm)"
	id = "handloader_m556_rifle_small"
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_box/magazine/m556/rifle/small/empty
	category = list("initial", "Handmade Magazines")

/datum/design/ammolathe/improvised/rev308
	name = "Empty 7.62mm/.308 Stripper clip"
	id = "handloader_rev308"	
	materials = list(/datum/material/iron = 6000)
	build_path = /obj/item/ammo_box/rev308/empty
	category = list("initial", "Handmade Magazines")	

//////////
/// AMMO!

/datum/design/ammolathe/improvised/a22
	name = ".22lr ammo box"
	id = "handloader_a22"
	build_path = /obj/item/ammo_box/m22
	materials = list(/datum/material/iron = 6000, /datum/material/blackpowder = 1500)
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a22rubber
	name = ".22 rubber ammo box"
	id = "handloader_m22rubber"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1500)
	build_path = /obj/item/ammo_box/m22/rubber
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a9mmfmj
	name = "9mm bag"
	id = "handloader_a9mmfmj"
	build_path = /obj/item/ammo_box/c9mm/improvised
	materials = list(/datum/material/iron = 15000, /datum/material/blackpowder = 1500)
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/c9mm/rubber
	name = "9mm rubber ammo box"
	id = "handloader_c9mmrubber_lathe"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/c9mm/rubber
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/c10mm
	name = "10mm bag"
	id = "handloader_c10mm_lathe"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/c10mm/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/c10mm/rubber
	name = "10mm rubber ammo box"
	id = "handloader_c10mmrubber_lathe"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/c10mm/rubber
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a45fmj
	name = ".45 bag"
	id = "handloader_a45fmj"
	build_path = /obj/item/ammo_box/c45/improvised
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1500)
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a45rubber
	name = ".45 ACP rubber ammo box"
	id = "handloader_a45rubber"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1500)
	build_path = /obj/item/ammo_box/c45/rubber
	category = list("initial", "Handloaded Ammo")




/datum/design/ammolathe/improvised/c38
	name = ".38 bag"
	id = "handloader_c38"
	materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/c38box/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/c38rubber
	name = ".38 rubber ammo box"
	id = "handloader_useless" // (X)Doubt
	materials = list(/datum/material/iron = 8000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/c38box/rubber
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a357
	name = ".357 Magnum bag"
	id = "handloader_a357_lathe"
	materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1500)
	build_path = /obj/item/ammo_box/a357box/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/m44
	name = ".44 Magnum bag"
	id = "handloader_m44"
	materials = list(/datum/material/iron = 14000, /datum/material/blackpowder = 1500)
	build_path = /obj/item/ammo_box/m44box/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/c4570
	name = ".45-70 bag"
	id = "handloader_c4570"
	materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 2000)
	build_path = /obj/item/ammo_box/c4570box/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/lc45
	name = ".45 LC bag"
	id = "handloader_c45lc"
	materials = list(/datum/material/iron = 12000, /datum/material/blackpowder = 1500)
	build_path = /obj/item/ammo_box/a45lcbox/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a14mm
	name = "14mm bag"
	id = "handloader_a127mm"
	build_path = /obj/item/ammo_box/m14mm/improvised
	materials = list(/datum/material/iron = 15000, /datum/material/blackpowder = 2000)
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/lethalshot
	name = "shotgun shell bag"
	id = "handloader_lethalshot"
	materials = list(/datum/material/iron = 8000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/shotgun/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/beanbag
	name = "beanbag shotgun box"
	id = "handloader_beanbag"
	materials = list(/datum/material/iron = 8000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/shotgun/bean
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/rubbershot
	name = "rubbershot shotgun box"
	id = "handloader_rubbershot"
	materials = list(/datum/material/iron = 8000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/shotgun/rubber
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a223
	name = ".223 bag"
	id = "handloader_a223"
	build_path = /obj/item/ammo_box/a556/sport/improvised
	materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1000)
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a308
	name = ".308 bag"
	id = "handloader_a308"
	materials = list(/datum/material/iron = 14000, /datum/material/blackpowder = 1000)
	build_path = /obj/item/ammo_box/a308box/improvised
	category = list("initial", "Handloaded Ammo")

/datum/design/ammolathe/improvised/a50mg
	name = ".50 MG bag"
	id = "handloader_a50mg"
	materials = list(/datum/material/iron = 20000, /datum/material/blackpowder = 2000)
	build_path = /obj/item/ammo_box/a50MGbox/improvised
	category = list("initial", "Handloaded Ammo")
