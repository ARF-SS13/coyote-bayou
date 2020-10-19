/obj/item/ammo_box/a357
	name = "speed loader (.357)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "357"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 7
	multiple_sprites = 1

/obj/item/ammo_box/a357/match
	name = "speed loader (.357 Match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/a357/match

/obj/item/ammo_box/a357/ap
	name = "speed loader (.357 AP)"
	ammo_type = /obj/item/ammo_casing/a357/ap

/obj/item/ammo_box/a357/dumdum
	name = "speed loader (.357 DumDum)"
	desc = "Designed to quickly reload revolvers. Usage of these rounds will constitute a war crime in your area."
	ammo_type = /obj/item/ammo_casing/a357/dumdum

/obj/item/ammo_box/c38
	name = "speed loader (.38 rubber)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "38"
	caliber = "38"
	ammo_type = /obj/item/ammo_casing/c38
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 20000)

/obj/item/ammo_box/c38/lethal
	name = "speed loader (.38)"
	ammo_type = /obj/item/ammo_casing/c38/lethal

/obj/item/ammo_box/c38/trac
	name = "speed loader (.38 TRAC)"
	desc = "Designed to quickly reload revolvers. TRAC bullets embed a tracking implant within the target's body."
	ammo_type = /obj/item/ammo_casing/c38/trac

/obj/item/ammo_box/c38/hotshot
	name = "speed loader (.38 Hot Shot)"
	desc = "Designed to quickly reload revolvers. Hot Shot bullets contain an incendiary payload."
	ammo_type = /obj/item/ammo_casing/c38/hotshot

/obj/item/ammo_box/c38/iceblox
	name = "speed loader (.38 Iceblox)"
	desc = "Designed to quickly reload revolvers. Iceblox bullets contain a cryogenic payload."
	ammo_type = /obj/item/ammo_casing/c38/iceblox

/obj/item/ammo_box/c38/dumdum
	name = "speed loader (.38 DumDum)"
	desc = "Designed to quickly reload revolvers. These rounds expand on impact, allowing them to shred the target and cause massive bleeding. Very weak against armor and distant targets."
	ammo_type = /obj/item/ammo_casing/c38/dumdum

/obj/item/ammo_box/c38/match
	name = "speed loader (.38 Match)"
	desc = "Designed to quickly reload revolvers. These rounds are manufactured within extremely tight tolerances, making them easy to show off trickshots with."
	ammo_type = /obj/item/ammo_casing/c38/match

/obj/item/ammo_box/c9mm
	name = "ammo box (9mm)"
	icon_state = "9mmbox"
	ammo_type = /obj/item/ammo_casing/c9mm
	max_ammo = 30

/obj/item/ammo_box/c10mm
	name = "ammo box (10mm)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 20

/obj/item/ammo_box/c10mm/fire
	name = "ammo box (10mm Incendiary)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm/fire
	max_ammo = 20

/obj/item/ammo_box/c10mm/hp
	name = "ammo box (10mm Hollow Point)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	max_ammo = 20

/obj/item/ammo_box/c10mm/ap
	name = "ammo box (10mm Armour Piercing)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	max_ammo = 20

/obj/item/ammo_box/c10mm/soporific
	name = "ammo box (10mm Soporific)"
	ammo_type = /obj/item/ammo_casing/c10mm/soporific
	max_ammo = 20

/obj/item/ammo_box/c45
	name = "ammo box (.45)"
	icon_state = "45box"
	ammo_type = /obj/item/ammo_casing/c45
	max_ammo = 20

/obj/item/ammo_box/a40mm
	name = "ammo box (40mm grenades)"
	icon_state = "40mm"
	ammo_type = /obj/item/ammo_casing/a40mm
	max_ammo = 4
	multiple_sprites = 1

/obj/item/ammo_box/l10mm
	name = "speed loader (10mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "10mm"
	ammo_type = /obj/item/ammo_casing/c10mm
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 50000)

/obj/item/ammo_box/l10mm/empty
	start_empty = 1

/obj/item/ammo_box/a762
	name = "stripper clip (7.62mm)"
	desc = "A stripper clip."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = 1

/obj/item/ammo_box/n762
	name = "ammo box (7.62x38mmR)"
	icon_state = "10mmbox"
	ammo_type = /obj/item/ammo_casing/n762
	max_ammo = 14

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

//Shotgun clips
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

/obj/item/ammo_box/shotgun/loaded
	start_empty = FALSE

/obj/item/ammo_box/shotgun/loaded/rubbershot
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot

/obj/item/ammo_box/shotgun/loaded/buckshot
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot

/obj/item/ammo_box/shotgun/loaded/beanbag
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/ammo_box/shotgun/loaded/stunslug
	ammo_type = /obj/item/ammo_casing/shotgun/stunslug

/obj/item/ammo_box/shotgun/loaded/techshell
	ammo_type = /obj/item/ammo_casing/shotgun/techshell

/obj/item/ammo_box/shotgun/loaded/incendiary
	ammo_type = /obj/item/ammo_casing/shotgun/incendiary

/obj/item/ammo_box/shotgun/loaded/dart
	ammo_type = /obj/item/ammo_casing/shotgun/dart

//.44 Magnum
/obj/item/ammo_box/m44
	name = "speed loader (.44)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "44"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 6
	caliber = "44"
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
/*
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

/obj/item/ammo_box/m44/empty
	start_empty = 1

/obj/item/ammo_box/tube/m44
	name = "speed loader tube (.44)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "44tube"
	caliber = "44"
	ammo_type = /obj/item/ammo_casing/m44
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/tube/m44/empty
	start_empty = 1

//Stripper clips

//7.62x51, .308 Winchester
/obj/item/ammo_box/a762
	name = "stripper clip (7.62)"
	desc = "A stripper clip."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a762
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/musketbag/
	name = "Bag of Musket Cartridges"
	icon_state = "musketbag"
	ammo_type = /obj/item/ammo_casing/caseless/musketball
	max_ammo = 15
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
	w_class = WEIGHT_CLASS_NORMAL

//Needler
/obj/item/ammo_box/needle
	name = "needler stripper clip (needle darts)"
	icon_state = "needler"
	ammo_type = /obj/item/ammo_casing/caseless/needle
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/needleap
	name = "armour-piercing needler stripper clip (needle darts)"
	icon_state = "apneedler"
	ammo_type = /obj/item/ammo_casing/caseless/needle/ap
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/needleultra
	name = "ultracite needler stripper clip (needle darts)"
	icon_state = "ultraneedler"
	ammo_type = /obj/item/ammo_casing/caseless/needle/ultra
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/a308
	name = "stripper clip (.308)"
	desc = "A stripper clip."
	icon_state = "308"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
	w_class = WEIGHT_CLASS_SMALL
/*
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
*/

/obj/item/ammo_box/a762/doublestacked
	name = "double stack stripper clip (.308)"
	desc = "A stripper clip."
	icon_state = "762a"
	ammo_type = /obj/item/ammo_casing/a762/sport
	max_ammo = 10
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
	w_class = WEIGHT_CLASS_SMALL

//5.56x45mm
/obj/item/ammo_box/a556/stripper
	name = "stripper clip (5.56x45mm)"
	desc = "A stripper clip."
	icon_state = "762"
	ammo_type = /obj/item/ammo_casing/a556
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
	w_class = WEIGHT_CLASS_SMALL

//.45-70 Gov't
/obj/item/ammo_box/c4570
	name = "speed loader (.45-70)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "4570"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 6
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/c4570/empty
	start_empty = 1

/obj/item/ammo_box/tube/c4570
	name = "speed loader tube (.45-70)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "44tube"
	ammo_type = /obj/item/ammo_casing/c4570
	max_ammo = 8
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/tube/c4570/empty
	start_empty = 1

//.50 BMG
/obj/item/ammo_box/a50MG
	name = "anti-materiel ammo rack (.50MG)"
	desc = "A rack of .50 MG ammo, for when you really need something dead."
	icon_state = "50mg"
	ammo_type = /obj/item/ammo_casing/a50MG
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/a50MG/incendiary
	name = "anti-materiel incendiary ammo rack (.50MG)"
	desc = "A rack of .50 MG ammo, for when you really need something dead... and also on fire."
	icon_state = "50in"
	ammo_type = /obj/item/ammo_casing/a50MG/incendiary
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/*/obj/item/ammo_box/a50MG/AP
	name = "anti-materiel armor piercing ammo rack (.50MG)"
	desc = "A .rack of .50 MG ammo, for when you really need (a very big) something dead."
	icon_state = "50ap"
	ammo_type = /obj/item/ammo_casing/a50MG/AP
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)
*/
/obj/item/ammo_box/a50MG/explosive
	name = "anti-materiel explosive ammo rack (.50MG)"
	desc = "5 rounds of explosive .50 MG. More then enough to kill anything that moves."
	icon_state = "50ex"
	ammo_type = /obj/item/ammo_casing/a50MG/explosive
	max_ammo = 5
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/tube/a357
	name = "speed loader tube (.357)"
	desc = "Designed to quickly reload repeaters."
	icon_state = "44tube"
	caliber = "357"
	ammo_type = /obj/item/ammo_casing/a357
	max_ammo = 7
	multiple_sprites = 1
	custom_materials = list(/datum/material/iron = 40000, /datum/material/glass = 50000)

/obj/item/ammo_box/tube/a357/empty
	start_empty = 1