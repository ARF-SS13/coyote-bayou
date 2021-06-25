//In this document: Ammo boxes, speed loaders, stripper clips.


////////////////////
//AMMUNITION BOXES//
////////////////////


//Shotguns 
/obj/item/ammo_box/shotgun
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	max_ammo = 12
	custom_materials = list(/datum/material/iron = 6000, /datum/material/blackpowder = 1500)
	ammo_type = /obj/item/ammo_casing/shotgun
	multiple_sprites = 1
	
/obj/item/ammo_box/shotgun/slug
	name = "Slug shotgun ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/shotgun
	icon_state = "lbox"

/obj/item/ammo_box/shotgun/buck
	name = "Buckshot shotgun ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	icon_state = "gbox"

/obj/item/ammo_box/shotgun/magnum
	name = "Magnum buckshot shotgun ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/shotgun/magnumshot
	icon_state = "mbox"

/obj/item/ammo_box/shotgun/bean
	name = "Beanbag shotgun ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	icon_state = "bbox"

/obj/item/ammo_box/shotgun/rubber
	name = "Rubbershot shotgun ammo box"
	desc = "A box full of shotgun shells."
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	icon_state = "stunbox"


//.22 LR
/obj/item/ammo_box/m22
	name = "ammo box (.22lr)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "ammobox"
	multiple_sprites = 3
	ammo_type = /obj/item/ammo_casing/a22
	max_ammo = 40
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/iron = 6000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/m22/plinking
	name = "ammo box (.22lr plinking)"
	ammo_type = /obj/item/ammo_casing/a22/plinking
	custom_materials = list(/datum/material/iron = 3000, /datum/material/blackpowder = 1000)

/obj/item/ammo_box/m22/hp
	name = "ammo box (.22lr hollow point)"
	ammo_type = /obj/item/ammo_casing/a22/hp
	custom_materials = list(/datum/material/iron = 8000, /datum/material/blackpowder = 2000)


//9mm and .38
/obj/item/ammo_box/c9mm
	name = "ammo box (9mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "9mmbox"
	multiple_sprites = 2
	caliber = "9mm"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30
	custom_materials = list(/datum/material/iron = 15000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/c9mm/ap
	name = "ammo box (9mm AP)"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	custom_materials = list(/datum/material/iron = 15000, /datum/material/titanium = 3750, /datum/material/blackpowder = 2000)

/obj/item/ammo_box/c9mm/jhp
	name = "ammo box (9mm JHP)"
	ammo_type = /obj/item/ammo_casing/c9mm/jhp
	custom_materials = list(/datum/material/iron = 11000, /datum/material/blackpowder = 1000)

/obj/item/ammo_box/c9mm/op
	name = "ammo box (9mm +P)"
	ammo_type = /obj/item/ammo_casing/c9mm/op
	custom_materials = list(/datum/material/iron = 19000, /datum/material/blackpowder = 3500)

/obj/item/ammo_box/c38box
	name = "ammo box (.38)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "38box"
	multiple_sprites = 2
	caliber = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 30
	custom_materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)


//10mm
/obj/item/ammo_box/c10mm
	name = "ammo box (10mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "10mmbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = "10mm"
	max_ammo = 30
	custom_materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1000)

/obj/item/ammo_box/c10mm/jhp
	name = "ammo box (10mm JHP)"
	ammo_type = /obj/item/ammo_casing/c10mm/jhp
	custom_materials = list(/datum/material/iron = 6000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/c10mm/fire
	name = "ammo box (10mm Incendiary)"
	icon_state = "10mmbox"
	max_ammo = 20

/obj/item/ammo_box/c10mm/ap
	name = "ammo box (10mm AP)"
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	custom_materials = list(/datum/material/iron = 14000, /datum/material/titanium = 3500, /datum/material/blackpowder = 1500)


//.357 Magnum
/obj/item/ammo_box/a357box
	name = "ammo box (.357 Magnum FMJ)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "357box"
	multiple_sprites = 2
	caliber = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 30
	custom_materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1500)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/a357box/jhp
	name = "ammo box (.357 Magnum JHP)"
	ammo_type = /obj/item/ammo_casing/a357/jhp
	custom_materials = list(/datum/material/iron = 12000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a357box/jfp
	name = "ammo box (.357 Magnum JFP)"
	ammo_type = /obj/item/ammo_casing/a357/jfp
	custom_materials = list(/datum/material/iron = 19000, /datum/material/blackpowder = 2000)


//.44 Magnum
/obj/item/ammo_box/m44box
	name = "ammo box (.44 Magnum FMJ)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "44box"
	multiple_sprites = 2
	caliber = "44"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 30
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 14000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/m44box/jhp
	name = "ammo box (.44 Magnum JHP)"
	ammo_type = /obj/item/ammo_casing/m44/jhp
	custom_materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/m44box/swc
	name = "ammo box (.44 Magnum SWC)"
	ammo_type = /obj/item/ammo_casing/m44/swc
	custom_materials = list(/datum/material/iron = 19000, /datum/material/blackpowder = 2000)


//.45 ACP
/obj/item/ammo_box/c45
	name = "ammo box (.45)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	caliber = ".45"
	multiple_sprites = 2
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 30
	custom_materials = list(/datum/material/iron = 10000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/c45/jhp
	name = "ammo box (.45 JHP)"
	ammo_type = /obj/item/ammo_casing/c45/jhp
	custom_materials = list(/datum/material/iron = 6000, /datum/material/blackpowder = 1000)

/obj/item/ammo_box/c45/op
	name = "ammo box (.45 +P)"
	ammo_type = /obj/item/ammo_casing/c45/op
	custom_materials = list(/datum/material/iron = 14000, /datum/material/blackpowder = 2000)


//.45-70 Gov't
/obj/item/ammo_box/c4570box
	name = "ammo box (.45-70 FMJ)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "4570box"
	multiple_sprites = 2
	caliber = "4570"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 30
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 2000)

/obj/item/ammo_box/c4570box/jhp
	name = "ammo box (.45-70 JHP)"
	ammo_type = /obj/item/ammo_casing/c4570/jhp
	custom_materials = list(/datum/material/iron = 12000, /datum/material/blackpowder = 2000)

/obj/item/ammo_box/c4570box/swc
	name = "ammo box (.45-70 SWC)"
	ammo_type = /obj/item/ammo_casing/c4570/swc
	custom_materials = list(/datum/material/iron = 20000, /datum/material/blackpowder = 3500)


//5.56x45
/obj/item/ammo_box/a556
	name = "ammo box (5.56 FMJ)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "556box"
	multiple_sprites = 2
	caliber = "a556"
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 40
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 20000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a556/jhp
	name = "ammo box (5.56 JHP)"
	ammo_type = /obj/item/ammo_casing/a556/jhp
	custom_materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a556/ap
	name = "ammo box (5.56 AP)"
	ammo_type = /obj/item/ammo_casing/a556/ap
	custom_materials = list(/datum/material/iron = 24000, /datum/material/titanium = 6000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a556/match
	name = "ammo box (5.56 match)"
	ammo_type = /obj/item/ammo_casing/a556/match
	custom_materials = list(/datum/material/iron = 28000, /datum/material/blackpowder = 3500)

/obj/item/ammo_box/a556/sport
	name = "ammo box (.223 sport)"
	ammo_type = /obj/item/ammo_casing/a556/sport
	custom_materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1000)


//7.62x51, .308 Winchester
/obj/item/ammo_box/a308box
	name = "ammo box (.308)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "308box"
	multiple_sprites = 2
	caliber = "a762"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 30
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 14000, /datum/material/blackpowder = 1000)

/obj/item/ammo_box/a762box
	name = "ammo box (7.62x51 FMJ)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "762box"
	multiple_sprites = 2
	caliber = "a762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 30
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 16000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a762box/jhp
	name = "ammo box (7.62x51 JHP)"
	ammo_type = /obj/item/ammo_casing/a762/jhp
	custom_materials = list(/datum/material/iron = 12000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/a762box/ap
	name = "ammo box (7.62x51 AP)"
	ammo_type = /obj/item/ammo_casing/a762/ap
	custom_materials = list(/datum/material/iron = 20000, /datum/material/titanium = 5000, /datum/material/blackpowder = 2000)

/obj/item/ammo_box/a762box/match
	name = "ammo box (7.62x51 Match)"
	ammo_type = /obj/item/ammo_casing/a762/match
	custom_materials = list(/datum/material/iron = 28000, /datum/material/blackpowder = 3500)


//.50 MG and .50 AE
/obj/item/ammo_box/a50MGbox
	name = "ammo box (.50 MG)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50box"
	multiple_sprites = 2
	caliber = "a50MG"
	ammo_type = /obj/item/ammo_casing/a50MG
	max_ammo = 25
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 20000, /datum/material/blackpowder = 2000)

/obj/item/ammo_box/m127mm
	name = "ammo box (12.7mm)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "50aebox"
	multiple_sprites = 2
	caliber = "12.7"
	ammo_type = /obj/item/ammo_casing/a127mm
	max_ammo = 30
	w_class = WEIGHT_CLASS_NORMAL
	custom_materials = list(/datum/material/iron = 11000, /datum/material/blackpowder = 1500)

/obj/item/ammo_box/m127mm/jhp
	name = "ammo box (12.7mm JHP)"
	ammo_type = /obj/item/ammo_casing/a127mm/jhp
	custom_materials = list(/datum/material/iron = 11000)


//Misc.
/obj/item/ammo_box/m473
	name = "ammo box (4.73mm caseless)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "ammobox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/caseless/g11
	max_ammo = 50

/obj/item/ammo_box/lasmusket
	name = "Battery box (Laser musket)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "lasmusketbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/caseless/lasermusket
	max_ammo = 18
	custom_materials = list(MAT_METAL = 1000)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/plasmamusket
	name = "Canister box (Plasma musket)"
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	icon_state = "plasmusketbox"
	multiple_sprites = 2
	ammo_type = /obj/item/ammo_casing/caseless/plasmacaster
	max_ammo = 6
	custom_materials = list(MAT_METAL = 1000)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/a40mm
	name = "ammo box (40mm grenades)"
	caliber = "40mm"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = 1


////////////////
//SPEEDLOADERS//
////////////////

/obj/item/ammo_box/tube
	icon = 'icons/fallout/objects/guns/ammo.dmi'
	custom_materials = list(/datum/material/iron = 6000)
	multiple_sprites = 1

//.38
/obj/item/ammo_box/c38
	name = "speed loader (.38)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "38"
	caliber = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/c38/empty
	start_empty = 1


//10mm
/obj/item/ammo_box/l10mm
	name = "speed loader (10mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "10mm2"
	caliber = "10mm"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 12
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/l10mm/empty
	start_empty = 1


//.357
/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 Match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."

/obj/item/ammo_box/a357/ap
	name = "speed loader (.357 AP)"

/obj/item/ammo_box/a357/dumdum
	name = "speed loader (.357 DumDum)"
	desc = "Designed to quickly reload revolvers. Usage of these rounds will constitute a war crime in your area."

/obj/item/ammo_box/tube/a357
	name = "speed loader tube (.357)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "357tube"
	caliber = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 12

/obj/item/ammo_box/tube/a357/empty
	start_empty = 1


//.44 Magnum
/obj/item/ammo_box/m44
	name = "speed loader (.44)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "44"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 6
	caliber = "44"
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/m44/empty
	start_empty = 1

/obj/item/ammo_box/tube/m44
	name = "speed loader tube (.44)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "44tube"
	caliber = "44"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 12

/obj/item/ammo_box/tube/m44/empty
	start_empty = 1


//.45 ACP
/obj/item/ammo_box/c45rev
	name = "speed loader (.45 ACP)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "38"
	caliber = ".45"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/c45rev/empty
	start_empty = 1


//.45-70 Gov't
/obj/item/ammo_box/c4570
	name = "speed loader (.45-70)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "4570"
	caliber = "4570"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)

/obj/item/ammo_box/c4570/empty
	start_empty = 1

/obj/item/ammo_box/c4570/explosive
	name = "speed loader (.45-70 explosive)"
	icon_state = "4570"
	caliber = "4570"
	ammo_type = /obj/item/ammo_casing/c4570/explosive

/obj/item/ammo_box/tube/c4570
	name = "speed loader tube (.45-70)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "4570tube"
	caliber = "4570"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 10

/obj/item/ammo_box/tube/c4570/empty
	start_empty = 1



//////////////////
//STRIPPER CLIPS//
//////////////////


//Shotgun clips (sort out with the box versio if implemented)
/*
/obj/item/ammo_box/shotgun
	name = "stripper clip (shotgun shells)"
	desc = "A stripper clip, designed to help with loading a shotgun slightly faster."
	icon = 'icons/obj/ammo.dmi'
	icon_state = "shotgunclip"
	caliber = "shotgun" // slapped in to allow shell mix n match
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKET
	w_class = WEIGHT_CLASS_NORMAL
	w_volume = ITEM_VOLUME_STRIPPER_CLIP
	ammo_type = /obj/item/ammo_casing/shotgun
	max_ammo = 4
	var/pixeloffsetx = 4
	start_empty = TRUE
*/
/obj/item/ammo_box/shotgun/loaded
	start_empty = FALSE

/obj/item/ammo_box/shotgun/loaded/rubbershot
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/shotgun/loaded/buckshot
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/shotgun/loaded/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/shotgun/loaded/incendiary
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/musketbag/
	name = "Bag of Musket Cartridges"
	icon_state = "musketbag"
	ammo_type = /obj/item/ammo_casing/caseless/musketball
	max_ammo = 15
	custom_materials = list(/datum/material/iron = 3000)
	w_class = WEIGHT_CLASS_NORMAL

//7.62x51, .308 Winchester
/obj/item/ammo_box/a762
	name = "stripper clip (7.62)"
	desc = "A stripper clip."
	icon_state = "762"
	caliber = "a762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/a308
	name = "stripper clip (.308)"
	desc = "A stripper clip."
	icon_state = "308"
	caliber = "a762"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/a762/doublestacked
	name = "double stack stripper clip (.308)"
	desc = "A stripper clip."
	icon_state = "762a"
	caliber = "a762"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 10
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)
	w_class = WEIGHT_CLASS_SMALL

//5.56x45mm
/obj/item/ammo_box/a556/stripper
	name = "stripper clip (5.56x45mm)"
	desc = "A stripper clip."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000)
	w_class = WEIGHT_CLASS_SMALL


//Needler
/obj/item/ammo_box/needle
	name = "needler stripper clip (needle darts)"
	icon_state = "needler"
	caliber = "needle"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 3000, /datum/material/glass = 5000)

/obj/item/ammo_box/needleap
	name = "armour-piercing needler stripper clip (needle darts)"
	icon_state = "apneedler"
	caliber = "needle"
	ammo_type = /obj/item/ammo_casing/caseless/needle/ap
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 4000, /datum/material/glass = 5000)

/obj/item/ammo_box/needleultra
	name = "ultracite needler stripper clip (needle darts)"
	icon_state = "ultraneedler"
	caliber = "needle"
	ammo_type = /obj/item/ammo_casing/caseless/needle/ultra
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 4000, /datum/material/glass = 5000)

//.50 BMG
/obj/item/ammo_box/a50MG
	name = "anti-materiel ammo rack (.50MG)"
	desc = "A rack of .50 MG ammo, for when you really need something dead."
	icon_state = "50mg"
	caliber = "a50mg"
	ammo_type = /obj/item/ammo_casing/a50MG
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 20000)

/obj/item/ammo_box/a50MG/incendiary
	name = "anti-materiel incendiary ammo rack (.50MG)"
	desc = "A rack of .50 MG ammo, for when you really need something dead... and also on fire."
	icon_state = "50in"
	ammo_type = /obj/item/ammo_casing/a50MG/incendiary
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 20000)


/obj/item/ammo_box/a50MG/explosive
	name = "anti-materiel explosive ammo rack (.50MG)"
	desc = "5 rounds of explosive .50 MG. More then enough to kill anything that moves."
	icon_state = "50ex"
	ammo_type = /obj/item/ammo_casing/a50MG/explosive
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 20000)


/*
/obj/item/ammo_box/a50MG/AP
	name = "anti-materiel armor piercing ammo rack (.50MG)"
	desc = "A .rack of .50 MG ammo, for when you really need (a very big) something dead."
	icon_state = "50ap"
	ammo_type = /obj/item/ammo_casing/a50MG/AP
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/magazine/m308/heap
	name = "rifle magazine (.308) (+Heap!)"
	ammo_type = /obj/item/ammo_casing/F13/m308/heap

/obj/item/ammo_box/magazine/m308/armourpiercing
	name = "rifle magazine (.308) (+AP!)"
	ammo_type = /obj/item/ammo_casing/F13/m308/armourpiercing

/obj/item/ammo_box/magazine/m308/toxic
	name = "rifle magazine (.308) (+TOXIC!)"
	ammo_type = /obj/item/ammo_casing/F13/m308/toxic

/obj/item/ammo_box/magazine/m308/fire
	name = "rifle magazine (.308) (+FIRE!)"
	ammo_type = /obj/item/ammo_casing/F13/m308/fire

/obj/item/ammo_box/shotgun/update_overlays()
	. = ..()
	if(stored_ammo.len)
		var/offset = -4
		for(var/A in stored_ammo)
			var/obj/item/ammo_casing/shotgun/C = A
			offset += pixeloffsetx
			var/mutable_appearance/shell_overlay = mutable_appearance(icon, "[initial(C.icon_state)]-clip")
			shell_overlay.pixel_x += offset
			shell_overlay.appearance_flags = RESET_COLOR
			. += shell_overlay

/obj/item/ammo_box/m44/heap
	name = "speed loader (.44) (+Heap!)"
	ammo_type = /obj/item/ammo_casing/F13/m44/heap

/obj/item/ammo_box/m44/armourpiercing
	name = "speed loader (.44) (+AP!)"
	ammo_type = /obj/item/ammo_casing/F13/m44/armourpiercing

/obj/item/ammo_box/m44/toxic
	name = "speed loader (.44) (+TOXIC!)"
	ammo_type = /obj/item/ammo_casing/F13/m44/toxic

/obj/item/ammo_box/m44/fire
	name = "speed loader (.44) (+FIRE!)"
	ammo_type = /obj/item/ammo_casing/F13/m44/fire

*/

//Trash for removal
/obj/item/ammo_box/foambox
	name = "ammo box (Foam Darts)"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart
	max_ammo = 40
	custom_materials = list(/datum/material/iron = 500)

/obj/item/ammo_box/foambox/mag
	name = "ammo box (Magnetic Foam Darts)"
	icon = 'icons/obj/guns/toy.dmi'
	icon_state = "foambox"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/mag
	max_ammo = 42

/obj/item/ammo_box/foambox/riot
	icon_state = "foambox_riot"
	ammo_type = /obj/item/ammo_casing/caseless/foam_dart/riot
	custom_materials = list(/datum/material/iron = 50000)
